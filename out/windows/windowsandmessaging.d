// Written in the D programming language.

module windows.windowsandmessaging;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.controls : HPROPSHEETPAGE, NMHDR;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : BLENDFUNCTION, HBRUSH, HCURSOR, HDC, HICON;
public import windows.kernel : LUID;
public import windows.menusandresources : HMENU, MSGBOXCALLBACK, WNDENUMPROC, WNDPROC;
public import windows.shell : LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, LRESULT, PSTR, PWSTR;
public import windows.windowsstationsanddesktops : HDESK;
public import windows.xps : DEVMODEA;

extern(Windows) @nogc nothrow:


// Callbacks

///Application-defined callback function used with the CreateDialog and DialogBox families of functions. It processes
///messages sent to a modal or modeless dialog box. The <b>DLGPROC</b> type defines a pointer to this callback function.
///<i>DialogProc</i> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = Type: <b>HWND</b> A handle to the dialog box.
///    Arg2 = Type: <b>UINT</b> The message.
///    Arg3 = Type: <b>WPARAM</b> Additional message-specific information.
///    Arg4 = Type: <b>LPARAM</b> Additional message-specific information. Type: <b>INT_PTR</b> Typically, the dialog box
///           procedure should return <b>TRUE</b> if it processed the message, and <b>FALSE</b> if it did not. If the dialog
///           box procedure returns <b>FALSE</b>, the dialog manager performs the default dialog operation in response to the
///           message. If the dialog box procedure processes a message that requires a specific return value, the dialog box
///           procedure should set the desired return value by calling SetWindowLong(<i>hwndDlg</i>, <b>DWL_MSGRESULT</b>,
///           <i>lResult</i>) immediately before returning <b>TRUE</b>. Note that you must call <b>SetWindowLong</b>
///           immediately before returning <b>TRUE</b>; doing so earlier may result in the <b>DWL_MSGRESULT</b> value being
///           overwritten by a nested dialog box message. The following messages are exceptions to the general rules stated
///           above. Consult the documentation for the specific message for details on the semantics of the return value. <ul>
///           <li> WM_CHARTOITEM </li> <li> WM_COMPAREITEM </li> <li> WM_CTLCOLORBTN </li> <li> WM_CTLCOLORDLG </li> <li>
///           WM_CTLCOLOREDIT </li> <li> WM_CTLCOLORLISTBOX </li> <li> WM_CTLCOLORSCROLLBAR </li> <li> WM_CTLCOLORSTATIC </li>
///           <li> WM_INITDIALOG </li> <li> WM_QUERYDRAGICON </li> <li> WM_VKEYTOITEM </li> </ul>
alias DLGPROC = ptrdiff_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///An application-defined callback function that processes WM_TIMER messages. The <b>TIMERPROC</b> type defines a
///pointer to this callback function. <i>TimerProc</i> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = Type: <b>HWND</b> A handle to the window associated with the timer.
///    Arg2 = Type: <b>UINT</b> The WM_TIMER message.
///    Arg3 = Type: <b>UINT_PTR</b> The timer's identifier.
///    Arg4 = Type: <b>DWORD</b> The number of milliseconds that have elapsed since the system was started. This is the value
///           returned by the GetTickCount function.
alias TIMERPROC = void function(HWND param0, uint param1, size_t param2, uint param3);
///An application-defined or library-defined callback function used with the SetWindowsHookEx function. The system calls
///this function after the SendMessage function is called. The hook procedure can examine the message; it cannot modify
///it. The <b>HOOKPROC</b> type defines a pointer to this callback function. <i>CallWndRetProc</i> is a placeholder for
///the application-defined or library-defined function name.
///Params:
///    code = 
///    wParam = Type: <b>WPARAM</b> Specifies whether the message is sent by the current process. If the message is sent by the
///             current process, it is nonzero; otherwise, it is <b>NULL</b>.
///    lParam = Type: <b>LPARAM</b> A pointer to a CWPRETSTRUCT structure that contains details about the message.
///Returns:
///    Type: <b>LRESULT</b> If <i>nCode</i> is less than zero, the hook procedure must return the value returned by
///    CallNextHookEx. If <i>nCode</i> is greater than or equal to zero, it is highly recommended that you call
///    CallNextHookEx and return the value it returns; otherwise, other applications that have installed
///    WH_CALLWNDPROCRET hooks will not receive hook notifications and may behave incorrectly as a result. If the hook
///    procedure does not call <b>CallNextHookEx</b>, the return value should be zero.
///    
alias HOOKPROC = LRESULT function(int code, WPARAM wParam, LPARAM lParam);
///An application-defined callback function used with the SendMessageCallback function. The system passes the message to
///the callback function after passing the message to the destination window procedure. The <b>SENDASYNCPROC</b> type
///defines a pointer to this callback function. <i>SendAsyncProc</i> is a placeholder for the application-defined
///function name.
///Params:
///    Arg1 = Type: <b>HWND</b> A handle to the window whose window procedure received the message. If the SendMessageCallback
///           function was called with its <i>hwnd</i> parameter set to <b>HWND_BROADCAST</b>, the system calls the
///           <i>SendAsyncProc</i> function once for each top-level window.
///    Arg2 = Type: <b>UINT</b> The message.
///    Arg3 = Type: <b>ULONG_PTR</b> An application-defined value sent from the SendMessageCallback function.
///    Arg4 = Type: <b>LRESULT</b> The result of the message processing. This value depends on the message.
alias SENDASYNCPROC = void function(HWND param0, uint param1, size_t param2, LRESULT param3);
///An application-defined callback function used with the EnumProps function. The function receives property entries
///from a window's property list. The <b>PROPENUMPROC</b> type defines a pointer to this callback function.
///<i>PropEnumProc</i> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = Type: <b>HWND</b> A handle to the window whose property list is being enumerated.
///    Arg2 = Type: <b>LPCTSTR</b> The string component of a property list entry. This is the string that was specified, along
///           with a data handle, when the property was added to the window's property list via a call to the SetProp function.
///    Arg3 = Type: <b>HANDLE</b> A handle to the data. This handle is the data component of a property list entry.
///Returns:
///    Type: <b>BOOL</b> Return <b>TRUE</b> to continue the property list enumeration. Return <b>FALSE</b> to stop the
///    property list enumeration.
///    
alias PROPENUMPROCA = BOOL function(HWND param0, const(PSTR) param1, HANDLE param2);
///An application-defined callback function used with the EnumProps function. The function receives property entries
///from a window's property list. The <b>PROPENUMPROC</b> type defines a pointer to this callback function.
///<i>PropEnumProc</i> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = Type: <b>HWND</b> A handle to the window whose property list is being enumerated.
///    Arg2 = Type: <b>LPCTSTR</b> The string component of a property list entry. This is the string that was specified, along
///           with a data handle, when the property was added to the window's property list via a call to the SetProp function.
///    Arg3 = Type: <b>HANDLE</b> A handle to the data. This handle is the data component of a property list entry.
///Returns:
///    Type: <b>BOOL</b> Return <b>TRUE</b> to continue the property list enumeration. Return <b>FALSE</b> to stop the
///    property list enumeration.
///    
alias PROPENUMPROCW = BOOL function(HWND param0, const(PWSTR) param1, HANDLE param2);
///Application-defined callback function used with the EnumPropsEx function. The function receives property entries from
///a window's property list. The PROPENUMPROCEX type defines a pointer to this callback function. <b>PropEnumProcEx</b>
///is a placeholder for the application-defined function name.
///Params:
///    Arg1 = Type: <b>HWND</b> A handle to the window whose property list is being enumerated.
///    Arg2 = Type: <b>LPTSTR</b> The string component of a property list entry. This is the string that was specified, along
///           with a data handle, when the property was added to the window's property list via a call to the SetProp function.
///    Arg3 = Type: <b>HANDLE</b> A handle to the data. This handle is the data component of a property list entry.
///    Arg4 = Type: <b>ULONG_PTR</b> Application-defined data. This is the value that was specified as the <i>lParam</i>
///           parameter of the call to EnumPropsEx that initiated the enumeration.
///Returns:
///    Type: <b>BOOL</b> Return <b>TRUE</b> to continue the property list enumeration. Return <b>FALSE</b> to stop the
///    property list enumeration.
///    
alias PROPENUMPROCEXA = BOOL function(HWND param0, PSTR param1, HANDLE param2, size_t param3);
///Application-defined callback function used with the EnumPropsEx function. The function receives property entries from
///a window's property list. The PROPENUMPROCEX type defines a pointer to this callback function. <b>PropEnumProcEx</b>
///is a placeholder for the application-defined function name.
///Params:
///    Arg1 = Type: <b>HWND</b> A handle to the window whose property list is being enumerated.
///    Arg2 = Type: <b>LPTSTR</b> The string component of a property list entry. This is the string that was specified, along
///           with a data handle, when the property was added to the window's property list via a call to the SetProp function.
///    Arg3 = Type: <b>HANDLE</b> A handle to the data. This handle is the data component of a property list entry.
///    Arg4 = Type: <b>ULONG_PTR</b> Application-defined data. This is the value that was specified as the <i>lParam</i>
///           parameter of the call to EnumPropsEx that initiated the enumeration.
///Returns:
///    Type: <b>BOOL</b> Return <b>TRUE</b> to continue the property list enumeration. Return <b>FALSE</b> to stop the
///    property list enumeration.
///    
alias PROPENUMPROCEXW = BOOL function(HWND param0, PWSTR param1, HANDLE param2, size_t param3);
///<p class="CCE_Message">[Starting with Windows Vista, the <b>Open</b> and <b>Save As</b> common dialog boxes have been
///superseded by the Common Item Dialog. We recommended that you use the Common Item Dialog API instead of these dialog
///boxes from the Common Dialog Box Library.] Receives notification messages sent from the dialog box. The function also
///receives messages for any additional controls that you defined by specifying a child dialog template. The
///<i>OFNHookProc</i> hook procedure is an application-defined or library-defined callback function that is used with
///the Explorer-style <b>Open</b> and <b>Save As</b> dialog boxes. The <b>LPOFNHOOKPROC</b> type defines a pointer to
///this callback function. <i>OFNHookProc</i> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = A handle to the child dialog box of the <b>Open</b> or <b>Save As</b> dialog box. Use the GetParent function to
///           get the handle to the <b>Open</b> or <b>Save As</b> dialog box.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter. If
///           the <i>Arg2</i> parameter indicates the WM_INITDIALOG message, <i>Arg4</i> is a pointer to an OPENFILENAME
///           structure containing the values specified when the dialog box was created.
///Returns:
///    If the hook procedure returns zero, the default dialog box procedure processes the message. If the hook procedure
///    returns a nonzero value, the default dialog box procedure ignores the message. For the CDN_SHAREVIOLATION and
///    CDN_FILEOK notification messages, the hook procedure should return a nonzero value to indicate that it has used
///    the SetWindowLong function to set a nonzero <b>DWL_MSGRESULT</b> value.
///    
alias LPOFNHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///Receives messages or notifications intended for the default dialog box procedure of the <b>Color</b> dialog box. This
///is an application-defined or library-defined callback function that is used with the ChooseColor function. The
///<b>LPCCHOOKPROC</b> type defines a pointer to this callback function. <i>CCHookProc</i> is a placeholder for the
///application-defined function name.
///Params:
///    Arg1 = A handle to the <b>Color</b> dialog box for which the message is intended.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter. If
///           the <i>Arg2</i> parameter indicates the WM_INITDIALOG message, then <i>Arg4</i> is a pointer to a CHOOSECOLOR
///           structure containing the values specified when the dialog was created.
///Returns:
///    If the hook procedure returns zero, the default dialog box procedure processes the message. If the hook procedure
///    returns a nonzero value, the default dialog box procedure ignores the message.
///    
alias LPCCHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///Receives messages or notifications intended for the default dialog box procedure of the <b>Find</b> or <b>Replace</b>
///dialog box. The <i>FRHookProc</i> hook procedure is an application-defined or library-defined callback function that
///is used with the FindText or ReplaceText function. The <b>LPFRHOOKPROC</b> type defines a pointer to this callback
///function. <i>FRHookProc</i> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = A handle to the <b>Find</b> or <b>Replace</b> dialog box for which the message is intended.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter. If
///           the <i>Arg2</i> parameter indicates the WM_INITDIALOG message, <i>Arg4</i> is a pointer to a FINDREPLACE
///           structure containing the values specified when the dialog box was created.
///Returns:
///    If the hook procedure returns zero, the default dialog box procedure processes the message. If the hook procedure
///    returns a nonzero value, the default dialog box procedure ignores the message.
///    
alias LPFRHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///Receives messages or notifications intended for the default dialog box procedure of the <b>Font</b> dialog box. This
///is an application-defined or library-defined callback procedure that is used with the ChooseFont function. The
///<b>LPCFHOOKPROC</b> type defines a pointer to this callback function. <i>CFHookProc</i> is a placeholder for the
///application-defined function name.
///Params:
///    Arg1 = A handle to the <b>Font</b> dialog box for which the message is intended.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter. If
///           the <i>Arg2</i> parameter indicates the WM_INITDIALOG message, <i>Arg4</i> is a pointer to a CHOOSEFONT structure
///           containing the values specified when the dialog box was created.
///Returns:
///    If the hook procedure returns zero, the default dialog box procedure processes the message. If the hook procedure
///    returns a nonzero value, the default dialog box procedure ignores the message.
///    
alias LPCFHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///Receives messages or notifications intended for the default dialog box procedure of the <b>Print</b> dialog box. This
///is an application-defined or library-defined callback function that is used with the PrintDlg function. The
///<b>LPPRINTHOOKPROC</b> type defines a pointer to this callback function. <i>PrintHookProc</i> is a placeholder for
///the application-defined or library-defined function name.
///Params:
///    Arg1 = A handle to the <b>Print</b> dialog box for which the message is intended.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter. If
///           the <i>Arg2</i> parameter indicates the WM_INITDIALOG message, <i>Arg4</i> is a pointer to a PRINTDLG structure
///           containing the values specified when the dialog box was created.
///Returns:
///    If the hook procedure returns zero, the default dialog box procedure processes the message. If the hook procedure
///    returns a nonzero value, the default dialog box procedure ignores the message.
///    
alias LPPRINTHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///An application-defined or library-defined callback function used with the PrintDlg function. The hook procedure
///receives messages or notifications intended for the default dialog box procedure of the <b>Print Setup</b> dialog
///box. The <b>LPSETUPHOOKPROC</b> type defines a pointer to this callback function. <i>SetupHookProc</i> is a
///placeholder for the application-defined or library-defined function name.
///Params:
///    Arg1 = A handle to the <b>Print Setup</b> dialog box for which the message is intended.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///Returns:
///    If the hook procedure returns zero, the default dialog box procedure processes the message. If the hook procedure
///    returns a nonzero value, the default dialog box procedure ignores the message.
///    
alias LPSETUPHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///Receives messages that allow you to customize drawing of the sample page in the <b>Page Setup</b> dialog box. The
///<i>PagePaintHook</i> hook procedure is an application-defined or library-defined callback function used with the
///PageSetupDlg function. The <b>LPPAGEPAINTHOOK</b> type defines a pointer to this callback function.
///<i>PagePaintHook</i> is a placeholder for the application-defined or library-defined function name.
///Params:
///    Arg1 = A handle to the <b>Page Setup</b> dialog box.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///Returns:
///    If the hook procedure returns <b>TRUE</b> for any of the first three messages of a drawing sequence
///    (WM_PSD_PAGESETUPDLG, WM_PSD_FULLPAGERECT, or WM_PSD_MINMARGINRECT), the dialog box sends no more messages and
///    does not draw in the sample page until the next time the system needs to redraw the sample page. If the hook
///    procedure returns <b>FALSE</b> for all three messages, the dialog box sends the remaining messages of the drawing
///    sequence. If the hook procedure returns <b>TRUE</b> for any of the remaining messages in a drawing sequence, the
///    dialog box does not draw the corresponding portion of the sample page. If the hook procedure returns <b>FALSE</b>
///    for any of these messages, the dialog box draws that portion of the sample page.
///    
alias LPPAGEPAINTHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
///Receives messages or notifications intended for the default dialog box procedure of the <b>Page Setup</b> dialog box.
///The <i>PageSetupHook</i> hook procedure is an application-defined or library-defined callback function used with the
///PageSetupDlg function. The <b>LPPAGESETUPHOOK</b> type defines a pointer to this callback function.
///<i>PageSetupHook</i> is a placeholder for the application-defined or library-defined function name.
///Params:
///    Arg1 = A handle to the <b>Page Setup</b> dialog box for which the message is intended.
///    Arg2 = The identifier of the message being received.
///    Arg3 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter.
///    Arg4 = Additional information about the message. The exact meaning depends on the value of the <i>Arg2</i> parameter. If
///           the <i>Arg2</i> parameter indicates the WM_INITDIALOG message, <i>Arg4</i> is a pointer to a PAGESETUPDLG
///           structure containing the values specified when the dialog box was created.
///Returns:
///    If the hook procedure returns zero, the default dialog box procedure processes the message. If the hook procedure
///    returns a nonzero value, the default dialog box procedure ignores the message.
///    
alias LPPAGESETUPHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);

// Structs


///Contains information passed to a <b>WH_CBT</b> hook procedure, CBTProc, before a window is created.
struct CBT_CREATEWNDA
{
    ///Type: <b>LPCREATESTRUCT</b> A pointer to a CREATESTRUCT structure that contains initialization parameters for the
    ///window about to be created.
    CREATESTRUCTA* lpcs;
    ///Type: <b>HWND</b> A handle to the window whose position in the Z order precedes that of the window being created.
    ///This member can also be <b>NULL</b>.
    HWND           hwndInsertAfter;
}

///Contains information passed to a <b>WH_CBT</b> hook procedure, CBTProc, before a window is created.
struct CBT_CREATEWNDW
{
    ///Type: <b>LPCREATESTRUCT</b> A pointer to a CREATESTRUCT structure that contains initialization parameters for the
    ///window about to be created.
    CREATESTRUCTW* lpcs;
    ///Type: <b>HWND</b> A handle to the window whose position in the Z order precedes that of the window being created.
    ///This member can also be <b>NULL</b>.
    HWND           hwndInsertAfter;
}

///Contains information passed to a <b>WH_CBT</b> hook procedure, CBTProc, before a window is activated.
struct CBTACTIVATESTRUCT
{
    ///Type: <b>BOOL</b> This member is <b>TRUE</b> if a mouse click is causing the activation or <b>FALSE</b> if it is
    ///not.
    BOOL fMouse;
    ///Type: <b>HWND</b> A handle to the active window.
    HWND hWndActive;
}

///Contains information about a hardware message sent to the system message queue. This structure is used to store
///message information for the JournalPlaybackProc callback function.
struct EVENTMSG
{
    ///Type: <b>UINT</b> The message.
    uint message;
    ///Type: <b>UINT</b> Additional information about the message. The exact meaning depends on the <b>message</b>
    ///value.
    uint paramL;
    ///Type: <b>UINT</b> Additional information about the message. The exact meaning depends on the <b>message</b>
    ///value.
    uint paramH;
    ///Type: <b>DWORD</b> The time at which the message was posted.
    uint time;
    ///Type: <b>HWND</b> A handle to the window to which the message was posted.
    HWND hwnd;
}

///Defines the message parameters passed to a <b>WH_CALLWNDPROC</b> hook procedure, CallWndProc.
struct CWPSTRUCT
{
    ///Type: <b>LPARAM</b> Additional information about the message. The exact meaning depends on the <b>message</b>
    ///value.
    LPARAM lParam;
    ///Type: <b>WPARAM</b> Additional information about the message. The exact meaning depends on the <b>message</b>
    ///value.
    WPARAM wParam;
    ///Type: <b>UINT</b> The message.
    uint   message;
    ///Type: <b>HWND</b> A handle to the window to receive the message.
    HWND   hwnd;
}

///Defines the message parameters passed to a <b>WH_CALLWNDPROCRET</b> hook procedure, CallWndRetProc.
struct CWPRETSTRUCT
{
    ///Type: <b>LRESULT</b> The return value of the window procedure that processed the message specified by the
    ///<b>message</b> value.
    LRESULT lResult;
    ///Type: <b>LPARAM</b> Additional information about the message. The exact meaning depends on the <b>message</b>
    ///value.
    LPARAM  lParam;
    ///Type: <b>WPARAM</b> Additional information about the message. The exact meaning depends on the <b>message</b>
    ///value.
    WPARAM  wParam;
    ///Type: <b>UINT</b> The message.
    uint    message;
    ///Type: <b>HWND</b> A handle to the window that processed the message specified by the <b>message</b> value.
    HWND    hwnd;
}

///Contains information about a low-level keyboard input event.
struct KBDLLHOOKSTRUCT
{
    ///Type: <b>DWORD</b> A virtual-key code. The code must be a value in the range 1 to 254.
    uint   vkCode;
    ///Type: <b>DWORD</b> A hardware scan code for the key.
    uint   scanCode;
    ///Type: <b>DWORD</b> The extended-key flag, event-injected flags, context code, and transition-state flag. This
    ///member is specified as follows. An application can use the following values to test the keystroke flags. Testing
    ///LLKHF_INJECTED (bit 4) will tell you whether the event was injected. If it was, then testing
    ///LLKHF_LOWER_IL_INJECTED (bit 1) will tell you whether or not the event was injected from a process running at
    ///lower integrity level. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="LLKHF_EXTENDED"></a><a id="llkhf_extended"></a><dl> <dt><b>LLKHF_EXTENDED</b></dt> <dt>(KF_EXTENDED &gt;&gt;
    ///8)</dt> </dl> </td> <td width="60%"> Test the extended-key flag. </td> </tr> <tr> <td width="40%"><a
    ///id="LLKHF_LOWER_IL_INJECTED"></a><a id="llkhf_lower_il_injected"></a><dl> <dt><b>LLKHF_LOWER_IL_INJECTED</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> Test the event-injected (from a process running at lower
    ///integrity level) flag. </td> </tr> <tr> <td width="40%"><a id="LLKHF_INJECTED"></a><a
    ///id="llkhf_injected"></a><dl> <dt><b>LLKHF_INJECTED</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Test
    ///the event-injected (from any process) flag. </td> </tr> <tr> <td width="40%"><a id="LLKHF_ALTDOWN"></a><a
    ///id="llkhf_altdown"></a><dl> <dt><b>LLKHF_ALTDOWN</b></dt> <dt>(KF_ALTDOWN &gt;&gt; 8)</dt> </dl> </td> <td
    ///width="60%"> Test the context code. </td> </tr> <tr> <td width="40%"><a id="LLKHF_UP"></a><a
    ///id="llkhf_up"></a><dl> <dt><b>LLKHF_UP</b></dt> <dt>(KF_UP &gt;&gt; 8)</dt> </dl> </td> <td width="60%"> Test the
    ///transition-state flag. </td> </tr> </table> The following table describes the layout of this value. <table> <tr>
    ///<th>Bits</th> <th>Description</th> </tr> <tr> <td>0</td> <td>Specifies whether the key is an extended key, such
    ///as a function key or a key on the numeric keypad. The value is 1 if the key is an extended key; otherwise, it is
    ///0.</td> </tr> <tr> <td>1</td> <td>Specifies whether the event was injected from a process running at lower
    ///integrity level. The value is 1 if that is the case; otherwise, it is 0. Note that bit 4 is also set whenever bit
    ///1 is set.</td> </tr> <tr> <td>2-3</td> <td>Reserved.</td> </tr> <tr> <td>4</td> <td>Specifies whether the event
    ///was injected. The value is 1 if that is the case; otherwise, it is 0. Note that bit 1 is not necessarily set when
    ///bit 4 is set.</td> </tr> <tr> <td>5</td> <td>The context code. The value is 1 if the ALT key is pressed;
    ///otherwise, it is 0.</td> </tr> <tr> <td>6</td> <td>Reserved.</td> </tr> <tr> <td>7</td> <td>The transition state.
    ///The value is 0 if the key is pressed and 1 if it is being released.</td> </tr> </table>
    uint   flags;
    ///Type: <b>DWORD</b> The time stamp for this message, equivalent to what GetMessageTime would return for this
    ///message.
    uint   time;
    ///Type: <b>ULONG_PTR</b> Additional information associated with the message.
    size_t dwExtraInfo;
}

///Contains information about a low-level mouse input event.
struct MSLLHOOKSTRUCT
{
    ///Type: <b>POINT</b> The x- and y-coordinates of the cursor, in per-monitor-aware screen coordinates.
    POINT  pt;
    ///Type: <b>DWORD</b> If the message is WM_MOUSEWHEEL, the high-order word of this member is the wheel delta. The
    ///low-order word is reserved. A positive value indicates that the wheel was rotated forward, away from the user; a
    ///negative value indicates that the wheel was rotated backward, toward the user. One wheel click is defined as
    ///<b>WHEEL_DELTA</b>, which is 120. If the message is WM_XBUTTONDOWN, WM_XBUTTONUP, WM_XBUTTONDBLCLK,
    ///WM_NCXBUTTONDOWN, WM_NCXBUTTONUP, or WM_NCXBUTTONDBLCLK, the high-order word specifies which X button was pressed
    ///or released, and the low-order word is reserved. This value can be one or more of the following values.
    ///Otherwise, <b>mouseData</b> is not used. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="XBUTTON1"></a><a id="xbutton1"></a><dl> <dt><b>XBUTTON1</b></dt> <dt>0x0001</dt> </dl> </td>
    ///<td width="60%"> The first X button was pressed or released. </td> </tr> <tr> <td width="40%"><a
    ///id="XBUTTON2"></a><a id="xbutton2"></a><dl> <dt><b>XBUTTON2</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%">
    ///The second X button was pressed or released. </td> </tr> </table>
    uint   mouseData;
    ///Type: <b>DWORD</b> The event-injected flags. An application can use the following values to test the flags.
    ///Testing LLMHF_INJECTED (bit 0) will tell you whether the event was injected. If it was, then testing
    ///LLMHF_LOWER_IL_INJECTED (bit 1) will tell you whether or not the event was injected from a process running at
    ///lower integrity level. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="LLMHF_INJECTED"></a><a id="llmhf_injected"></a><dl> <dt><b>LLMHF_INJECTED</b></dt> <dt>0x00000001</dt> </dl>
    ///</td> <td width="60%"> Test the event-injected (from any process) flag. </td> </tr> <tr> <td width="40%"><a
    ///id="LLMHF_LOWER_IL_INJECTED"></a><a id="llmhf_lower_il_injected"></a><dl> <dt><b>LLMHF_LOWER_IL_INJECTED</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> Test the event-injected (from a process running at lower
    ///integrity level) flag. </td> </tr> </table>
    uint   flags;
    ///Type: <b>DWORD</b> The time stamp for this message.
    uint   time;
    ///Type: <b>ULONG_PTR</b> Additional information associated with the message.
    size_t dwExtraInfo;
}

///Contains debugging information passed to a <b>WH_DEBUG</b> hook procedure, DebugProc.
struct DEBUGHOOKINFO
{
    ///Type: <b>DWORD</b> A handle to the thread containing the filter function.
    uint   idThread;
    ///Type: <b>DWORD</b> A handle to the thread that installed the debugging filter function.
    uint   idThreadInstaller;
    ///Type: <b>LPARAM</b> The value to be passed to the hook in the <i>lParam</i> parameter of the DebugProc callback
    ///function.
    LPARAM lParam;
    ///Type: <b>WPARAM</b> The value to be passed to the hook in the <i>wParam</i> parameter of the DebugProc callback
    ///function.
    WPARAM wParam;
    ///Type: <b>int</b> The value to be passed to the hook in the <i>nCode</i> parameter of the DebugProc callback
    ///function.
    int    code;
}

///Contains information about a mouse event passed to a <b>WH_MOUSE</b> hook procedure, MouseProc.
struct MOUSEHOOKSTRUCT
{
    ///Type: <b>POINT</b> The x- and y-coordinates of the cursor, in screen coordinates.
    POINT  pt;
    ///Type: <b>HWND</b> A handle to the window that will receive the mouse message corresponding to the mouse event.
    HWND   hwnd;
    ///Type: <b>UINT</b> The hit-test value. For a list of hit-test values, see the description of the WM_NCHITTEST
    ///message.
    uint   wHitTestCode;
    ///Type: <b>ULONG_PTR</b> Additional information associated with the message.
    size_t dwExtraInfo;
}

///Contains information about a mouse event passed to a <b>WH_MOUSE</b> hook procedure, MouseProc. This is an extension
///of the MOUSEHOOKSTRUCT structure that includes information about wheel movement or the use of the X button.
struct MOUSEHOOKSTRUCTEX
{
    MOUSEHOOKSTRUCT __AnonymousBase_winuser_L1173_C46;
    ///Type: <b>DWORD</b> If the message is WM_MOUSEWHEEL, the HIWORD of this member is the wheel delta. The LOWORD is
    ///undefined and reserved. A positive value indicates that the wheel was rotated forward, away from the user; a
    ///negative value indicates that the wheel was rotated backward, toward the user. One wheel click is defined as
    ///WHEEL_DELTA, which is 120. If the message is WM_XBUTTONDOWN, WM_XBUTTONUP, WM_XBUTTONDBLCLK, WM_NCXBUTTONDOWN,
    ///WM_NCXBUTTONUP, or WM_NCXBUTTONDBLCLK, the HIWORD of <b>mouseData</b> specifies which X button was pressed or
    ///released, and the LOWORD is undefined and reserved. This member can be one or more of the following values.
    ///Otherwise, <b>mouseData</b> is not used. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="XBUTTON1"></a><a id="xbutton1"></a><dl> <dt><b>XBUTTON1</b></dt> <dt>0x0001</dt> </dl> </td>
    ///<td width="60%"> The first X button was pressed or released. </td> </tr> <tr> <td width="40%"><a
    ///id="XBUTTON2"></a><a id="xbutton2"></a><dl> <dt><b>XBUTTON2</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%">
    ///The second X button was pressed or released. </td> </tr> </table>
    uint            mouseData;
}

///Contains window class information. It is used with the RegisterClassEx and GetClassInfoEx functions. The
///<b>WNDCLASSEX</b> structure is similar to the WNDCLASS structure. There are two differences. <b>WNDCLASSEX</b>
///includes the <b>cbSize</b> member, which specifies the size of the structure, and the <b>hIconSm</b> member, which
///contains a handle to a small icon associated with the window class.
struct WNDCLASSEXA
{
    ///Type: <b>UINT</b> The size, in bytes, of this structure. Set this member to <code>sizeof(WNDCLASSEX)</code>. Be
    ///sure to set this member before calling the GetClassInfoEx function.
    uint        cbSize;
    ///Type: <b>UINT</b> The class style(s). This member can be any combination of the Class Styles.
    uint        style;
    ///Type: <b>WNDPROC</b> A pointer to the window procedure. You must use the CallWindowProc function to call the
    ///window procedure. For more information, see WindowProc.
    WNDPROC     lpfnWndProc;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window-class structure. The system
    ///initializes the bytes to zero.
    int         cbClsExtra;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window instance. The system initializes the
    ///bytes to zero. If an application uses <b>WNDCLASSEX</b> to register a dialog box created by using the
    ///<b>CLASS</b> directive in the resource file, it must set this member to <b>DLGWINDOWEXTRA</b>.
    int         cbWndExtra;
    ///Type: <b>HINSTANCE</b> A handle to the instance that contains the window procedure for the class.
    HINSTANCE   hInstance;
    ///Type: <b>HICON</b> A handle to the class icon. This member must be a handle to an icon resource. If this member
    ///is <b>NULL</b>, the system provides a default icon.
    HICON       hIcon;
    ///Type: <b>HCURSOR</b> A handle to the class cursor. This member must be a handle to a cursor resource. If this
    ///member is <b>NULL</b>, an application must explicitly set the cursor shape whenever the mouse moves into the
    ///application's window.
    HCURSOR     hCursor;
    ///Type: <b>HBRUSH</b> A handle to the class background brush. This member can be a handle to the brush to be used
    ///for painting the background, or it can be a color value. A color value must be one of the following standard
    ///system colors (the value 1 must be added to the chosen color). If a color value is given, you must convert it to
    ///one of the following <b>HBRUSH</b> types: <ul> <li>COLOR_ACTIVEBORDER</li> <li>COLOR_ACTIVECAPTION</li>
    ///<li>COLOR_APPWORKSPACE</li> <li>COLOR_BACKGROUND</li> <li>COLOR_BTNFACE</li> <li>COLOR_BTNSHADOW</li>
    ///<li>COLOR_BTNTEXT</li> <li>COLOR_CAPTIONTEXT</li> <li>COLOR_GRAYTEXT</li> <li>COLOR_HIGHLIGHT</li>
    ///<li>COLOR_HIGHLIGHTTEXT</li> <li>COLOR_INACTIVEBORDER</li> <li>COLOR_INACTIVECAPTION</li> <li>COLOR_MENU</li>
    ///<li>COLOR_MENUTEXT</li> <li>COLOR_SCROLLBAR</li> <li>COLOR_WINDOW</li> <li>COLOR_WINDOWFRAME</li>
    ///<li>COLOR_WINDOWTEXT </li> </ul> The system automatically deletes class background brushes when the class is
    ///unregistered by using UnregisterClass. An application should not delete these brushes. When this member is
    ///<b>NULL</b>, an application must paint its own background whenever it is requested to paint in its client area.
    ///To determine whether the background must be painted, an application can either process the WM_ERASEBKGND message
    ///or test the <b>fErase</b> member of the PAINTSTRUCT structure filled by the BeginPaint function.
    HBRUSH      hbrBackground;
    ///Type: <b>LPCTSTR</b> Pointer to a null-terminated character string that specifies the resource name of the class
    ///menu, as the name appears in the resource file. If you use an integer to identify the menu, use the
    ///MAKEINTRESOURCE macro. If this member is <b>NULL</b>, windows belonging to this class have no default menu.
    const(PSTR) lpszMenuName;
    ///Type: <b>LPCTSTR</b> A pointer to a null-terminated string or is an atom. If this parameter is an atom, it must
    ///be a class atom created by a previous call to the RegisterClass or RegisterClassEx function. The atom must be in
    ///the low-order word of <b>lpszClassName</b>; the high-order word must be zero. If <b>lpszClassName</b> is a
    ///string, it specifies the window class name. The class name can be any name registered with RegisterClass or
    ///RegisterClassEx, or any of the predefined control-class names. The maximum length for <b>lpszClassName</b> is
    ///256. If <b>lpszClassName</b> is greater than the maximum length, the RegisterClassEx function will fail.
    const(PSTR) lpszClassName;
    ///Type: <b>HICON</b> A handle to a small icon that is associated with the window class. If this member is
    ///<b>NULL</b>, the system searches the icon resource specified by the <b>hIcon</b> member for an icon of the
    ///appropriate size to use as the small icon.
    HICON       hIconSm;
}

///Contains window class information. It is used with the RegisterClassEx and GetClassInfoEx functions. The
///<b>WNDCLASSEX</b> structure is similar to the WNDCLASS structure. There are two differences. <b>WNDCLASSEX</b>
///includes the <b>cbSize</b> member, which specifies the size of the structure, and the <b>hIconSm</b> member, which
///contains a handle to a small icon associated with the window class.
struct WNDCLASSEXW
{
    ///Type: <b>UINT</b> The size, in bytes, of this structure. Set this member to <code>sizeof(WNDCLASSEX)</code>. Be
    ///sure to set this member before calling the GetClassInfoEx function.
    uint         cbSize;
    ///Type: <b>UINT</b> The class style(s). This member can be any combination of the Class Styles.
    uint         style;
    ///Type: <b>WNDPROC</b> A pointer to the window procedure. You must use the CallWindowProc function to call the
    ///window procedure. For more information, see WindowProc.
    WNDPROC      lpfnWndProc;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window-class structure. The system
    ///initializes the bytes to zero.
    int          cbClsExtra;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window instance. The system initializes the
    ///bytes to zero. If an application uses <b>WNDCLASSEX</b> to register a dialog box created by using the
    ///<b>CLASS</b> directive in the resource file, it must set this member to <b>DLGWINDOWEXTRA</b>.
    int          cbWndExtra;
    ///Type: <b>HINSTANCE</b> A handle to the instance that contains the window procedure for the class.
    HINSTANCE    hInstance;
    ///Type: <b>HICON</b> A handle to the class icon. This member must be a handle to an icon resource. If this member
    ///is <b>NULL</b>, the system provides a default icon.
    HICON        hIcon;
    ///Type: <b>HCURSOR</b> A handle to the class cursor. This member must be a handle to a cursor resource. If this
    ///member is <b>NULL</b>, an application must explicitly set the cursor shape whenever the mouse moves into the
    ///application's window.
    HCURSOR      hCursor;
    ///Type: <b>HBRUSH</b> A handle to the class background brush. This member can be a handle to the brush to be used
    ///for painting the background, or it can be a color value. A color value must be one of the following standard
    ///system colors (the value 1 must be added to the chosen color). If a color value is given, you must convert it to
    ///one of the following <b>HBRUSH</b> types: <ul> <li>COLOR_ACTIVEBORDER</li> <li>COLOR_ACTIVECAPTION</li>
    ///<li>COLOR_APPWORKSPACE</li> <li>COLOR_BACKGROUND</li> <li>COLOR_BTNFACE</li> <li>COLOR_BTNSHADOW</li>
    ///<li>COLOR_BTNTEXT</li> <li>COLOR_CAPTIONTEXT</li> <li>COLOR_GRAYTEXT</li> <li>COLOR_HIGHLIGHT</li>
    ///<li>COLOR_HIGHLIGHTTEXT</li> <li>COLOR_INACTIVEBORDER</li> <li>COLOR_INACTIVECAPTION</li> <li>COLOR_MENU</li>
    ///<li>COLOR_MENUTEXT</li> <li>COLOR_SCROLLBAR</li> <li>COLOR_WINDOW</li> <li>COLOR_WINDOWFRAME</li>
    ///<li>COLOR_WINDOWTEXT </li> </ul> The system automatically deletes class background brushes when the class is
    ///unregistered by using UnregisterClass. An application should not delete these brushes. When this member is
    ///<b>NULL</b>, an application must paint its own background whenever it is requested to paint in its client area.
    ///To determine whether the background must be painted, an application can either process the WM_ERASEBKGND message
    ///or test the <b>fErase</b> member of the PAINTSTRUCT structure filled by the BeginPaint function.
    HBRUSH       hbrBackground;
    ///Type: <b>LPCTSTR</b> Pointer to a null-terminated character string that specifies the resource name of the class
    ///menu, as the name appears in the resource file. If you use an integer to identify the menu, use the
    ///MAKEINTRESOURCE macro. If this member is <b>NULL</b>, windows belonging to this class have no default menu.
    const(PWSTR) lpszMenuName;
    ///Type: <b>LPCTSTR</b> A pointer to a null-terminated string or is an atom. If this parameter is an atom, it must
    ///be a class atom created by a previous call to the RegisterClass or RegisterClassEx function. The atom must be in
    ///the low-order word of <b>lpszClassName</b>; the high-order word must be zero. If <b>lpszClassName</b> is a
    ///string, it specifies the window class name. The class name can be any name registered with RegisterClass or
    ///RegisterClassEx, or any of the predefined control-class names. The maximum length for <b>lpszClassName</b> is
    ///256. If <b>lpszClassName</b> is greater than the maximum length, the RegisterClassEx function will fail.
    const(PWSTR) lpszClassName;
    ///Type: <b>HICON</b> A handle to a small icon that is associated with the window class. If this member is
    ///<b>NULL</b>, the system searches the icon resource specified by the <b>hIcon</b> member for an icon of the
    ///appropriate size to use as the small icon.
    HICON        hIconSm;
}

///Contains the window class attributes that are registered by the RegisterClass function. This structure has been
///superseded by the WNDCLASSEX structure used with the RegisterClassEx function. You can still use <b>WNDCLASS</b> and
///RegisterClass if you do not need to set the small icon associated with the window class.
struct WNDCLASSA
{
    ///Type: <b>UINT</b> The class style(s). This member can be any combination of the Class Styles.
    uint        style;
    ///Type: <b>WNDPROC</b> A pointer to the window procedure. You must use the CallWindowProc function to call the
    ///window procedure. For more information, see WindowProc.
    WNDPROC     lpfnWndProc;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window-class structure. The system
    ///initializes the bytes to zero.
    int         cbClsExtra;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window instance. The system initializes the
    ///bytes to zero. If an application uses <b>WNDCLASS</b> to register a dialog box created by using the <b>CLASS</b>
    ///directive in the resource file, it must set this member to <b>DLGWINDOWEXTRA</b>.
    int         cbWndExtra;
    ///Type: <b>HINSTANCE</b> A handle to the instance that contains the window procedure for the class.
    HINSTANCE   hInstance;
    ///Type: <b>HICON</b> A handle to the class icon. This member must be a handle to an icon resource. If this member
    ///is <b>NULL</b>, the system provides a default icon.
    HICON       hIcon;
    ///Type: <b>HCURSOR</b> A handle to the class cursor. This member must be a handle to a cursor resource. If this
    ///member is <b>NULL</b>, an application must explicitly set the cursor shape whenever the mouse moves into the
    ///application's window.
    HCURSOR     hCursor;
    ///Type: <b>HBRUSH</b> A handle to the class background brush. This member can be a handle to the physical brush to
    ///be used for painting the background, or it can be a color value. A color value must be one of the following
    ///standard system colors (the value 1 must be added to the chosen color). If a color value is given, you must
    ///convert it to one of the following <b>HBRUSH</b> types: <ul> <li>COLOR_ACTIVEBORDER</li>
    ///<li>COLOR_ACTIVECAPTION</li> <li>COLOR_APPWORKSPACE</li> <li>COLOR_BACKGROUND</li> <li>COLOR_BTNFACE</li>
    ///<li>COLOR_BTNSHADOW</li> <li>COLOR_BTNTEXT</li> <li>COLOR_CAPTIONTEXT</li> <li>COLOR_GRAYTEXT</li>
    ///<li>COLOR_HIGHLIGHT</li> <li>COLOR_HIGHLIGHTTEXT</li> <li>COLOR_INACTIVEBORDER</li>
    ///<li>COLOR_INACTIVECAPTION</li> <li>COLOR_MENU</li> <li>COLOR_MENUTEXT</li> <li>COLOR_SCROLLBAR</li>
    ///<li>COLOR_WINDOW</li> <li>COLOR_WINDOWFRAME</li> <li>COLOR_WINDOWTEXT </li> </ul> The system automatically
    ///deletes class background brushes when the class is unregistered by using UnregisterClass. An application should
    ///not delete these brushes. When this member is <b>NULL</b>, an application must paint its own background whenever
    ///it is requested to paint in its client area. To determine whether the background must be painted, an application
    ///can either process the WM_ERASEBKGND message or test the <b>fErase</b> member of the PAINTSTRUCT structure filled
    ///by the BeginPaint function.
    HBRUSH      hbrBackground;
    ///Type: <b>LPCTSTR</b> The resource name of the class menu, as the name appears in the resource file. If you use an
    ///integer to identify the menu, use the MAKEINTRESOURCE macro. If this member is <b>NULL</b>, windows belonging to
    ///this class have no default menu.
    const(PSTR) lpszMenuName;
    ///Type: <b>LPCTSTR</b> A pointer to a null-terminated string or is an atom. If this parameter is an atom, it must
    ///be a class atom created by a previous call to the RegisterClass or RegisterClassEx function. The atom must be in
    ///the low-order word of <b>lpszClassName</b>; the high-order word must be zero. If <b>lpszClassName</b> is a
    ///string, it specifies the window class name. The class name can be any name registered with RegisterClass or
    ///RegisterClassEx, or any of the predefined control-class names. The maximum length for <b>lpszClassName</b> is
    ///256. If <b>lpszClassName</b> is greater than the maximum length, the RegisterClass function will fail.
    const(PSTR) lpszClassName;
}

///Contains the window class attributes that are registered by the RegisterClass function. This structure has been
///superseded by the WNDCLASSEX structure used with the RegisterClassEx function. You can still use <b>WNDCLASS</b> and
///RegisterClass if you do not need to set the small icon associated with the window class.
struct WNDCLASSW
{
    ///Type: <b>UINT</b> The class style(s). This member can be any combination of the Class Styles.
    uint         style;
    ///Type: <b>WNDPROC</b> A pointer to the window procedure. You must use the CallWindowProc function to call the
    ///window procedure. For more information, see WindowProc.
    WNDPROC      lpfnWndProc;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window-class structure. The system
    ///initializes the bytes to zero.
    int          cbClsExtra;
    ///Type: <b>int</b> The number of extra bytes to allocate following the window instance. The system initializes the
    ///bytes to zero. If an application uses <b>WNDCLASS</b> to register a dialog box created by using the <b>CLASS</b>
    ///directive in the resource file, it must set this member to <b>DLGWINDOWEXTRA</b>.
    int          cbWndExtra;
    ///Type: <b>HINSTANCE</b> A handle to the instance that contains the window procedure for the class.
    HINSTANCE    hInstance;
    ///Type: <b>HICON</b> A handle to the class icon. This member must be a handle to an icon resource. If this member
    ///is <b>NULL</b>, the system provides a default icon.
    HICON        hIcon;
    ///Type: <b>HCURSOR</b> A handle to the class cursor. This member must be a handle to a cursor resource. If this
    ///member is <b>NULL</b>, an application must explicitly set the cursor shape whenever the mouse moves into the
    ///application's window.
    HCURSOR      hCursor;
    ///Type: <b>HBRUSH</b> A handle to the class background brush. This member can be a handle to the physical brush to
    ///be used for painting the background, or it can be a color value. A color value must be one of the following
    ///standard system colors (the value 1 must be added to the chosen color). If a color value is given, you must
    ///convert it to one of the following <b>HBRUSH</b> types: <ul> <li>COLOR_ACTIVEBORDER</li>
    ///<li>COLOR_ACTIVECAPTION</li> <li>COLOR_APPWORKSPACE</li> <li>COLOR_BACKGROUND</li> <li>COLOR_BTNFACE</li>
    ///<li>COLOR_BTNSHADOW</li> <li>COLOR_BTNTEXT</li> <li>COLOR_CAPTIONTEXT</li> <li>COLOR_GRAYTEXT</li>
    ///<li>COLOR_HIGHLIGHT</li> <li>COLOR_HIGHLIGHTTEXT</li> <li>COLOR_INACTIVEBORDER</li>
    ///<li>COLOR_INACTIVECAPTION</li> <li>COLOR_MENU</li> <li>COLOR_MENUTEXT</li> <li>COLOR_SCROLLBAR</li>
    ///<li>COLOR_WINDOW</li> <li>COLOR_WINDOWFRAME</li> <li>COLOR_WINDOWTEXT </li> </ul> The system automatically
    ///deletes class background brushes when the class is unregistered by using UnregisterClass. An application should
    ///not delete these brushes. When this member is <b>NULL</b>, an application must paint its own background whenever
    ///it is requested to paint in its client area. To determine whether the background must be painted, an application
    ///can either process the WM_ERASEBKGND message or test the <b>fErase</b> member of the PAINTSTRUCT structure filled
    ///by the BeginPaint function.
    HBRUSH       hbrBackground;
    ///Type: <b>LPCTSTR</b> The resource name of the class menu, as the name appears in the resource file. If you use an
    ///integer to identify the menu, use the MAKEINTRESOURCE macro. If this member is <b>NULL</b>, windows belonging to
    ///this class have no default menu.
    const(PWSTR) lpszMenuName;
    ///Type: <b>LPCTSTR</b> A pointer to a null-terminated string or is an atom. If this parameter is an atom, it must
    ///be a class atom created by a previous call to the RegisterClass or RegisterClassEx function. The atom must be in
    ///the low-order word of <b>lpszClassName</b>; the high-order word must be zero. If <b>lpszClassName</b> is a
    ///string, it specifies the window class name. The class name can be any name registered with RegisterClass or
    ///RegisterClassEx, or any of the predefined control-class names. The maximum length for <b>lpszClassName</b> is
    ///256. If <b>lpszClassName</b> is greater than the maximum length, the RegisterClass function will fail.
    const(PWSTR) lpszClassName;
}

///Contains message information from a thread's message queue.
struct MSG
{
    ///Type: <b>HWND</b> A handle to the window whose window procedure receives the message. This member is <b>NULL</b>
    ///when the message is a thread message.
    HWND   hwnd;
    ///Type: <b>UINT</b> The message identifier. Applications can only use the low word; the high word is reserved by
    ///the system.
    uint   message;
    ///Type: <b>WPARAM</b> Additional information about the message. The exact meaning depends on the value of the
    ///<b>message</b> member.
    WPARAM wParam;
    ///Type: <b>LPARAM</b> Additional information about the message. The exact meaning depends on the value of the
    ///<b>message</b> member.
    LPARAM lParam;
    ///Type: <b>DWORD</b> The time at which the message was posted.
    uint   time;
    ///Type: <b>POINT</b> The cursor position, in screen coordinates, when the message was posted.
    POINT  pt;
}

///Contains information about a window's maximized size and position and its minimum and maximum tracking size.
struct MINMAXINFO
{
    ///Type: <b>POINT</b> Reserved; do not use.
    POINT ptReserved;
    ///Type: <b>POINT</b> The maximized width (<b>x</b> member) and the maximized height (<b>y</b> member) of the
    ///window. For top-level windows, this value is based on the width of the primary monitor.
    POINT ptMaxSize;
    ///Type: <b>POINT</b> The position of the left side of the maximized window (<b>x</b> member) and the position of
    ///the top of the maximized window (<b>y</b> member). For top-level windows, this value is based on the position of
    ///the primary monitor.
    POINT ptMaxPosition;
    ///Type: <b>POINT</b> The minimum tracking width (<b>x</b> member) and the minimum tracking height (<b>y</b> member)
    ///of the window. This value can be obtained programmatically from the system metrics <b>SM_CXMINTRACK</b> and
    ///<b>SM_CYMINTRACK</b> (see the GetSystemMetrics function).
    POINT ptMinTrackSize;
    ///Type: <b>POINT</b> The maximum tracking width (<b>x</b> member) and the maximum tracking height (<b>y</b> member)
    ///of the window. This value is based on the size of the virtual screen and can be obtained programmatically from
    ///the system metrics <b>SM_CXMAXTRACK</b> and <b>SM_CYMAXTRACK</b> (see the GetSystemMetrics function).
    POINT ptMaxTrackSize;
}

///Contains information about the size and position of a window.
struct WINDOWPOS
{
    ///Type: <b>HWND</b> A handle to the window.
    HWND hwnd;
    ///Type: <b>HWND</b> The position of the window in Z order (front-to-back position). This member can be a handle to
    ///the window behind which this window is placed, or can be one of the special values listed with the SetWindowPos
    ///function.
    HWND hwndInsertAfter;
    ///Type: <b>int</b> The position of the left edge of the window.
    int  x;
    ///Type: <b>int</b> The position of the top edge of the window.
    int  y;
    ///Type: <b>int</b> The window width, in pixels.
    int  cx;
    ///Type: <b>int</b> The window height, in pixels.
    int  cy;
    ///Type: <b>UINT</b> The window position. This member can be one or more of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SWP_DRAWFRAME"></a><a
    ///id="swp_drawframe"></a><dl> <dt><b>SWP_DRAWFRAME</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> Draws a
    ///frame (defined in the window's class description) around the window. Same as the <b>SWP_FRAMECHANGED</b> flag.
    ///</td> </tr> <tr> <td width="40%"><a id="SWP_FRAMECHANGED"></a><a id="swp_framechanged"></a><dl>
    ///<dt><b>SWP_FRAMECHANGED</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> Sends a WM_NCCALCSIZE message to
    ///the window, even if the window's size is not being changed. If this flag is not specified, <b>WM_NCCALCSIZE</b>
    ///is sent only when the window's size is being changed. </td> </tr> <tr> <td width="40%"><a
    ///id="SWP_HIDEWINDOW"></a><a id="swp_hidewindow"></a><dl> <dt><b>SWP_HIDEWINDOW</b></dt> <dt>0x0080</dt> </dl>
    ///</td> <td width="60%"> Hides the window. </td> </tr> <tr> <td width="40%"><a id="SWP_NOACTIVATE"></a><a
    ///id="swp_noactivate"></a><dl> <dt><b>SWP_NOACTIVATE</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> Does not
    ///activate the window. If this flag is not set, the window is activated and moved to the top of either the topmost
    ///or non-topmost group (depending on the setting of the <b>hwndInsertAfter</b> member). </td> </tr> <tr> <td
    ///width="40%"><a id="SWP_NOCOPYBITS"></a><a id="swp_nocopybits"></a><dl> <dt><b>SWP_NOCOPYBITS</b></dt>
    ///<dt>0x0100</dt> </dl> </td> <td width="60%"> Discards the entire contents of the client area. If this flag is not
    ///specified, the valid contents of the client area are saved and copied back into the client area after the window
    ///is sized or repositioned. </td> </tr> <tr> <td width="40%"><a id="SWP_NOMOVE"></a><a id="swp_nomove"></a><dl>
    ///<dt><b>SWP_NOMOVE</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Retains the current position (ignores the
    ///<b>x</b> and <b>y</b> members). </td> </tr> <tr> <td width="40%"><a id="SWP__NOOWNERZORDER"></a><a
    ///id="swp__noownerzorder"></a><dl> <dt><b>SWP_ NOOWNERZORDER</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%">
    ///Does not change the owner window's position in the Z order. </td> </tr> <tr> <td width="40%"><a
    ///id="SWP_NOREDRAW"></a><a id="swp_noredraw"></a><dl> <dt><b>SWP_NOREDRAW</b></dt> <dt>0x0008</dt> </dl> </td> <td
    ///width="60%"> Does not redraw changes. If this flag is set, no repainting of any kind occurs. This applies to the
    ///client area, the nonclient area (including the title bar and scroll bars), and any part of the parent window
    ///uncovered as a result of the window being moved. When this flag is set, the application must explicitly
    ///invalidate or redraw any parts of the window and parent window that need redrawing. </td> </tr> <tr> <td
    ///width="40%"><a id="SWP_NOREPOSITION"></a><a id="swp_noreposition"></a><dl> <dt><b>SWP_NOREPOSITION</b></dt>
    ///<dt>0x0200</dt> </dl> </td> <td width="60%"> Does not change the owner window's position in the Z order. Same as
    ///the <b>SWP_NOOWNERZORDER</b> flag. </td> </tr> <tr> <td width="40%"><a id="SWP_NOSENDCHANGING"></a><a
    ///id="swp_nosendchanging"></a><dl> <dt><b>SWP_NOSENDCHANGING</b></dt> <dt>0x0400</dt> </dl> </td> <td width="60%">
    ///Prevents the window from receiving the WM_WINDOWPOSCHANGING message. </td> </tr> <tr> <td width="40%"><a
    ///id="SWP_NOSIZE"></a><a id="swp_nosize"></a><dl> <dt><b>SWP_NOSIZE</b></dt> <dt>0x0001</dt> </dl> </td> <td
    ///width="60%"> Retains the current size (ignores the <b>cx</b> and <b>cy</b> members). </td> </tr> <tr> <td
    ///width="40%"><a id="SWP_NOZORDER"></a><a id="swp_nozorder"></a><dl> <dt><b>SWP_NOZORDER</b></dt> <dt>0x0004</dt>
    ///</dl> </td> <td width="60%"> Retains the current Z order (ignores the <b>hwndInsertAfter</b> member). </td> </tr>
    ///<tr> <td width="40%"><a id="SWP_SHOWWINDOW"></a><a id="swp_showwindow"></a><dl> <dt><b>SWP_SHOWWINDOW</b></dt>
    ///<dt>0x0040</dt> </dl> </td> <td width="60%"> Displays the window. </td> </tr> </table>
    uint flags;
}

///Contains information that an application can use while processing the WM_NCCALCSIZE message to calculate the size,
///position, and valid contents of the client area of a window.
struct NCCALCSIZE_PARAMS
{
    ///Type: <b>RECT[3]</b> An array of rectangles. The meaning of the array of rectangles changes during the processing
    ///of the WM_NCCALCSIZE message. When the window procedure receives the WM_NCCALCSIZE message, the first rectangle
    ///contains the new coordinates of a window that has been moved or resized, that is, it is the proposed new window
    ///coordinates. The second contains the coordinates of the window before it was moved or resized. The third contains
    ///the coordinates of the window's client area before the window was moved or resized. If the window is a child
    ///window, the coordinates are relative to the client area of the parent window. If the window is a top-level
    ///window, the coordinates are relative to the screen origin. When the window procedure returns, the first rectangle
    ///contains the coordinates of the new client rectangle resulting from the move or resize. The second rectangle
    ///contains the valid destination rectangle, and the third rectangle contains the valid source rectangle. The last
    ///two rectangles are used in conjunction with the return value of the WM_NCCALCSIZE message to determine the area
    ///of the window to be preserved.
    RECT[3]    rgrc;
    ///Type: <b>PWINDOWPOS</b> A pointer to a WINDOWPOS structure that contains the size and position values specified
    ///in the operation that moved or resized the window.
    WINDOWPOS* lppos;
}

///Defines the initialization parameters passed to the window procedure of an application. These members are identical
///to the parameters of the CreateWindowEx function.
struct CREATESTRUCTA
{
    ///Type: <b>LPVOID</b> Contains additional data which may be used to create the window. If the window is being
    ///created as a result of a call to the CreateWindow or CreateWindowEx function, this member contains the value of
    ///the <i>lpParam</i> parameter specified in the function call. If the window being created is a MDI client window,
    ///this member contains a pointer to a CLIENTCREATESTRUCT structure. If the window being created is a MDI child
    ///window, this member contains a pointer to an MDICREATESTRUCT structure. If the window is being created from a
    ///dialog template, this member is the address of a <b>SHORT</b> value that specifies the size, in bytes, of the
    ///window creation data. The value is immediately followed by the creation data. For more information, see the
    ///following Remarks section.
    void*       lpCreateParams;
    ///Type: <b>HINSTANCE</b> A handle to the module that owns the new window.
    HINSTANCE   hInstance;
    ///Type: <b>HMENU</b> A handle to the menu to be used by the new window.
    HMENU       hMenu;
    ///Type: <b>HWND</b> A handle to the parent window, if the window is a child window. If the window is owned, this
    ///member identifies the owner window. If the window is not a child or owned window, this member is <b>NULL</b>.
    HWND        hwndParent;
    ///Type: <b>int</b> The height of the new window, in pixels.
    int         cy;
    ///Type: <b>int</b> The width of the new window, in pixels.
    int         cx;
    ///Type: <b>int</b> The y-coordinate of the upper left corner of the new window. If the new window is a child
    ///window, coordinates are relative to the parent window. Otherwise, the coordinates are relative to the screen
    ///origin.
    int         y;
    ///Type: <b>int</b> The x-coordinate of the upper left corner of the new window. If the new window is a child
    ///window, coordinates are relative to the parent window. Otherwise, the coordinates are relative to the screen
    ///origin.
    int         x;
    ///Type: <b>LONG</b> The style for the new window. For a list of possible values, see Window Styles.
    int         style;
    ///Type: <b>LPCTSTR</b> The name of the new window.
    const(PSTR) lpszName;
    ///Type: <b>LPCTSTR</b> A pointer to a null-terminated string or an atom that specifies the class name of the new
    ///window.
    const(PSTR) lpszClass;
    ///Type: <b>DWORD</b> The extended window style for the new window. For a list of possible values, see Extended
    ///Window Styles.
    uint        dwExStyle;
}

///Defines the initialization parameters passed to the window procedure of an application. These members are identical
///to the parameters of the CreateWindowEx function.
struct CREATESTRUCTW
{
    ///Type: <b>LPVOID</b> Contains additional data which may be used to create the window. If the window is being
    ///created as a result of a call to the CreateWindow or CreateWindowEx function, this member contains the value of
    ///the <i>lpParam</i> parameter specified in the function call. If the window being created is a MDI client window,
    ///this member contains a pointer to a CLIENTCREATESTRUCT structure. If the window being created is a MDI child
    ///window, this member contains a pointer to an MDICREATESTRUCT structure. If the window is being created from a
    ///dialog template, this member is the address of a <b>SHORT</b> value that specifies the size, in bytes, of the
    ///window creation data. The value is immediately followed by the creation data. For more information, see the
    ///following Remarks section.
    void*        lpCreateParams;
    ///Type: <b>HINSTANCE</b> A handle to the module that owns the new window.
    HINSTANCE    hInstance;
    ///Type: <b>HMENU</b> A handle to the menu to be used by the new window.
    HMENU        hMenu;
    ///Type: <b>HWND</b> A handle to the parent window, if the window is a child window. If the window is owned, this
    ///member identifies the owner window. If the window is not a child or owned window, this member is <b>NULL</b>.
    HWND         hwndParent;
    ///Type: <b>int</b> The height of the new window, in pixels.
    int          cy;
    ///Type: <b>int</b> The width of the new window, in pixels.
    int          cx;
    ///Type: <b>int</b> The y-coordinate of the upper left corner of the new window. If the new window is a child
    ///window, coordinates are relative to the parent window. Otherwise, the coordinates are relative to the screen
    ///origin.
    int          y;
    ///Type: <b>int</b> The x-coordinate of the upper left corner of the new window. If the new window is a child
    ///window, coordinates are relative to the parent window. Otherwise, the coordinates are relative to the screen
    ///origin.
    int          x;
    ///Type: <b>LONG</b> The style for the new window. For a list of possible values, see Window Styles.
    int          style;
    ///Type: <b>LPCTSTR</b> The name of the new window.
    const(PWSTR) lpszName;
    ///Type: <b>LPCTSTR</b> A pointer to a null-terminated string or an atom that specifies the class name of the new
    ///window.
    const(PWSTR) lpszClass;
    ///Type: <b>DWORD</b> The extended window style for the new window. For a list of possible values, see Extended
    ///Window Styles.
    uint         dwExStyle;
}

///Contains information about the placement of a window on the screen.
struct WINDOWPLACEMENT
{
    ///Type: <b>UINT</b> The length of the structure, in bytes. Before calling the GetWindowPlacement or
    ///SetWindowPlacement functions, set this member to <code>sizeof(WINDOWPLACEMENT)</code>. GetWindowPlacement and
    ///SetWindowPlacement fail if this member is not set correctly.
    uint  length;
    ///Type: <b>UINT</b> The flags that control the position of the minimized window and the method by which the window
    ///is restored. This member can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="WPF_ASYNCWINDOWPLACEMENT"></a><a id="wpf_asyncwindowplacement"></a><dl>
    ///<dt><b>WPF_ASYNCWINDOWPLACEMENT</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> If the calling thread and
    ///the thread that owns the window are attached to different input queues, the system posts the request to the
    ///thread that owns the window. This prevents the calling thread from blocking its execution while other threads
    ///process the request. </td> </tr> <tr> <td width="40%"><a id="WPF_RESTORETOMAXIMIZED"></a><a
    ///id="wpf_restoretomaximized"></a><dl> <dt><b>WPF_RESTORETOMAXIMIZED</b></dt> <dt>0x0002</dt> </dl> </td> <td
    ///width="60%"> The restored window will be maximized, regardless of whether it was maximized before it was
    ///minimized. This setting is only valid the next time the window is restored. It does not change the default
    ///restoration behavior. This flag is only valid when the <b>SW_SHOWMINIMIZED</b> value is specified for the
    ///<b>showCmd</b> member. </td> </tr> <tr> <td width="40%"><a id="WPF_SETMINPOSITION"></a><a
    ///id="wpf_setminposition"></a><dl> <dt><b>WPF_SETMINPOSITION</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
    ///The coordinates of the minimized window may be specified. This flag must be specified if the coordinates are set
    ///in the <b>ptMinPosition</b> member. </td> </tr> </table>
    uint  flags;
    ///Type: <b>UINT</b> The current show state of the window. This member can be one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SW_HIDE"></a><a id="sw_hide"></a><dl>
    ///<dt><b>SW_HIDE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Hides the window and activates another window.
    ///</td> </tr> <tr> <td width="40%"><a id="SW_MAXIMIZE"></a><a id="sw_maximize"></a><dl> <dt><b>SW_MAXIMIZE</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> Maximizes the specified window. </td> </tr> <tr> <td width="40%"><a
    ///id="SW_MINIMIZE"></a><a id="sw_minimize"></a><dl> <dt><b>SW_MINIMIZE</b></dt> <dt>6</dt> </dl> </td> <td
    ///width="60%"> Minimizes the specified window and activates the next top-level window in the z-order. </td> </tr>
    ///<tr> <td width="40%"><a id="SW_RESTORE"></a><a id="sw_restore"></a><dl> <dt><b>SW_RESTORE</b></dt> <dt>9</dt>
    ///</dl> </td> <td width="60%"> Activates and displays the window. If the window is minimized or maximized, the
    ///system restores it to its original size and position. An application should specify this flag when restoring a
    ///minimized window. </td> </tr> <tr> <td width="40%"><a id="SW_SHOW"></a><a id="sw_show"></a><dl>
    ///<dt><b>SW_SHOW</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Activates the window and displays it in its
    ///current size and position. </td> </tr> <tr> <td width="40%"><a id="SW_SHOWMAXIMIZED"></a><a
    ///id="sw_showmaximized"></a><dl> <dt><b>SW_SHOWMAXIMIZED</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Activates
    ///the window and displays it as a maximized window. </td> </tr> <tr> <td width="40%"><a
    ///id="SW_SHOWMINIMIZED"></a><a id="sw_showminimized"></a><dl> <dt><b>SW_SHOWMINIMIZED</b></dt> <dt>2</dt> </dl>
    ///</td> <td width="60%"> Activates the window and displays it as a minimized window. </td> </tr> <tr> <td
    ///width="40%"><a id="SW_SHOWMINNOACTIVE"></a><a id="sw_showminnoactive"></a><dl> <dt><b>SW_SHOWMINNOACTIVE</b></dt>
    ///<dt>7</dt> </dl> </td> <td width="60%"> Displays the window as a minimized window. This value is similar to
    ///<b>SW_SHOWMINIMIZED</b>, except the window is not activated. </td> </tr> <tr> <td width="40%"><a
    ///id="SW_SHOWNA"></a><a id="sw_showna"></a><dl> <dt><b>SW_SHOWNA</b></dt> <dt>8</dt> </dl> </td> <td width="60%">
    ///Displays the window in its current size and position. This value is similar to <b>SW_SHOW</b>, except the window
    ///is not activated. </td> </tr> <tr> <td width="40%"><a id="SW_SHOWNOACTIVATE"></a><a
    ///id="sw_shownoactivate"></a><dl> <dt><b>SW_SHOWNOACTIVATE</b></dt> <dt>4</dt> </dl> </td> <td width="60%">
    ///Displays a window in its most recent size and position. This value is similar to <b>SW_SHOWNORMAL</b>, except the
    ///window is not activated. </td> </tr> <tr> <td width="40%"><a id="SW_SHOWNORMAL"></a><a
    ///id="sw_shownormal"></a><dl> <dt><b>SW_SHOWNORMAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Activates and
    ///displays a window. If the window is minimized or maximized, the system restores it to its original size and
    ///position. An application should specify this flag when displaying the window for the first time. </td> </tr>
    ///</table>
    uint  showCmd;
    ///Type: <b>POINT</b> The coordinates of the window's upper-left corner when the window is minimized.
    POINT ptMinPosition;
    ///Type: <b>POINT</b> The coordinates of the window's upper-left corner when the window is maximized.
    POINT ptMaxPosition;
    ///Type: <b>RECT</b> The window's coordinates when the window is in the restored position.
    RECT  rcNormalPosition;
}

///Contains the styles for a window.
struct STYLESTRUCT
{
    ///Type: <b>DWORD</b> The previous styles for a window. For more information, see the Remarks.
    uint styleOld;
    ///Type: <b>DWORD</b> The new styles for a window. For more information, see the Remarks.
    uint styleNew;
}

///Contains information about a window that denied a request from BroadcastSystemMessageEx.
struct BSMINFO
{
    ///Type: <b>UINT</b> The size, in bytes, of this structure.
    uint  cbSize;
    ///Type: <b>HDESK</b> A desktop handle to the window specified by <b>hwnd</b>. This value is returned only if
    ///BroadcastSystemMessageEx specifies <b>BSF_RETURNHDESK</b> and <b>BSF_QUERY</b>.
    HDESK hdesk;
    ///Type: <b>HWND</b> A handle to the window that denied the request. This value is returned if
    ///BroadcastSystemMessageEx specifies <b>BSF_QUERY</b>.
    HWND  hwnd;
    ///Type: <b>LUID</b> A locally unique identifier (LUID) for the window.
    LUID  luid;
}

///Used by UpdateLayeredWindowIndirect to provide position, size, shape, content, and translucency information for a
///layered window.
struct UPDATELAYEREDWINDOWINFO
{
    ///Type: <b>DWORD</b> The size, in bytes, of this structure.
    uint          cbSize;
    ///Type: <b>HDC</b> A handle to a DC for the screen. This handle is obtained by specifying <b>NULL</b> in this
    ///member when calling UpdateLayeredWindowIndirect. The handle is used for palette color matching when the window
    ///contents are updated. If <b>hdcDst</b> is <b>NULL</b>, the default palette is used. If <b>hdcSrc</b> is
    ///<b>NULL</b>, <b>hdcDst</b> must be <b>NULL</b>.
    HDC           hdcDst;
    ///Type: <b>const POINT*</b> The new screen position of the layered window. If the new position is unchanged from
    ///the current position, <b>pptDst</b> can be <b>NULL</b>.
    const(POINT)* pptDst;
    ///Type: <b>const SIZE*</b> The new size of the layered window. If the size of the window will not change, this
    ///parameter can be <b>NULL</b>. If <b>hdcSrc</b> is <b>NULL</b>, <b>psize</b> must be <b>NULL</b>.
    const(SIZE)*  psize;
    ///Type: <b>HDC</b> A handle to the DC for the surface that defines the layered window. This handle can be obtained
    ///by calling the CreateCompatibleDC function. If the shape and visual context of the window will not change,
    ///<b>hdcSrc</b> can be <b>NULL</b>.
    HDC           hdcSrc;
    ///Type: <b>const POINT*</b> The location of the layer in the device context. If <b>hdcSrc</b> is <b>NULL</b>,
    ///<b>pptSrc</b> should be <b>NULL</b>.
    const(POINT)* pptSrc;
    ///Type: <b>COLORREF</b> The color key to be used when composing the layered window. To generate a COLORREF, use the
    ///RGB macro.
    uint          crKey;
    ///Type: <b>const BLENDFUNCTION*</b> The transparency value to be used when composing the layered window.
    const(BLENDFUNCTION)* pblend;
    ///Type: <b>DWORD</b> This parameter can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="ULW_ALPHA"></a><a id="ulw_alpha"></a><dl>
    ///<dt><b>ULW_ALPHA</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Use <i>pblend</i> as the blend
    ///function. If the display mode is 256 colors or less, the effect of this value is the same as the effect of
    ///ULW_OPAQUE. </td> </tr> <tr> <td width="40%"><a id="ULW_COLORKEY"></a><a id="ulw_colorkey"></a><dl>
    ///<dt><b>ULW_COLORKEY</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Use <i>crKey</i> as the
    ///transparency color. </td> </tr> <tr> <td width="40%"><a id="ULW_OPAQUE"></a><a id="ulw_opaque"></a><dl>
    ///<dt><b>ULW_OPAQUE</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Draw an opaque layered window. </td>
    ///</tr> <tr> <td width="40%"><a id="ULW_EX_NORESIZE"></a><a id="ulw_ex_noresize"></a><dl>
    ///<dt><b>ULW_EX_NORESIZE</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Force the
    ///UpdateLayeredWindowIndirect function to fail if the current window size does not match the size specified in the
    ///<i>psize</i>. </td> </tr> </table> If <b>hdcSrc</b> is <b>NULL</b>, <b>dwFlags</b> should be zero.
    uint          dwFlags;
    ///Type: <b>const RECT*</b> The area to be updated. This parameter can be <b>NULL</b>. If it is non-NULL, only the
    ///area in this rectangle is updated from the source DC.
    const(RECT)*  prcDirty;
}

///Defines the dimensions and style of a dialog box. This structure, always the first in a standard template for a
///dialog box, also specifies the number of controls in the dialog box and therefore specifies the number of subsequent
///DLGITEMTEMPLATE structures in the template.
struct DLGTEMPLATE
{
align (2):
    ///Type: <b>DWORD</b> The style of the dialog box. This member can be a combination of window style values (such as
    ///<b>WS_CAPTION</b> and <b>WS_SYSMENU</b>) and dialog box style values (such as <b>DS_CENTER</b>). If the style
    ///member includes the <b>DS_SETFONT</b> style, the header of the dialog box template contains additional data
    ///specifying the font to use for text in the client area and controls of the dialog box. The font data begins on
    ///the <b>WORD</b> boundary that follows the title array. The font data specifies a 16-bit point size value and a
    ///Unicode font name string. If possible, the system creates a font according to the specified values. Then the
    ///system sends a WM_SETFONT message to the dialog box and to each control to provide a handle to the font. If
    ///<b>DS_SETFONT</b> is not specified, the dialog box template does not include the font data. The
    ///<b>DS_SHELLFONT</b> style is not supported in the <b>DLGTEMPLATE</b> header.
    uint   style;
    ///Type: <b>DWORD</b> The extended styles for a window. This member is not used to create dialog boxes, but
    ///applications that use dialog box templates can use it to create other types of windows. For a list of values, see
    ///Extended Window Styles.
    uint   dwExtendedStyle;
    ///Type: <b>WORD</b> The number of items in the dialog box.
    ushort cdit;
    ///Type: <b>short</b> The x-coordinate, in dialog box units, of the upper-left corner of the dialog box.
    short  x;
    ///Type: <b>short</b> The y-coordinate, in dialog box units, of the upper-left corner of the dialog box.
    short  y;
    ///Type: <b>short</b> The width, in dialog box units, of the dialog box.
    short  cx;
    ///Type: <b>short</b> The height, in dialog box units, of the dialog box.
    short  cy;
}

///Defines the dimensions and style of a control in a dialog box. One or more of these structures are combined with a
///DLGTEMPLATE structure to form a standard template for a dialog box.
struct DLGITEMTEMPLATE
{
align (2):
    ///Type: <b>DWORD</b> The style of the control. This member can be a combination of window style values (such as
    ///<b>WS_BORDER</b>) and one or more of the control style values (such as <b>BS_PUSHBUTTON</b> and <b>ES_LEFT</b>).
    uint   style;
    ///Type: <b>DWORD</b> The extended styles for a window. This member is not used to create controls in dialog boxes,
    ///but applications that use dialog box templates can use it to create other types of windows. For a list of values,
    ///see Extended Window Styles.
    uint   dwExtendedStyle;
    ///Type: <b>short</b> The <i>x</i>-coordinate, in dialog box units, of the upper-left corner of the control. This
    ///coordinate is always relative to the upper-left corner of the dialog box's client area.
    short  x;
    ///Type: <b>short</b> The <i>y</i>-coordinate, in dialog box units, of the upper-left corner of the control. This
    ///coordinate is always relative to the upper-left corner of the dialog box's client area.
    short  y;
    ///Type: <b>short</b> The width, in dialog box units, of the control.
    short  cx;
    ///Type: <b>short</b> The height, in dialog box units, of the control.
    short  cy;
    ///Type: <b>WORD</b> The control identifier.
    ushort id;
}

///Contains information used to display a message box. The MessageBoxIndirect function uses this structure.
struct MSGBOXPARAMSA
{
    ///Type: <b>UINT</b> The structure size, in bytes.
    uint           cbSize;
    ///Type: <b>HWND</b> A handle to the owner window. This member can be <b>NULL</b>.
    HWND           hwndOwner;
    ///Type: <b>HINSTANCE</b> A handle to the module that contains the icon resource identified by the <b>lpszIcon</b>
    ///member, and the string resource identified by the <b>lpszText</b> or <b>lpszCaption</b> member.
    HINSTANCE      hInstance;
    ///Type: <b>LPCTSTR</b> A null-terminated string, or the identifier of a string resource, that contains the message
    ///to be displayed.
    const(PSTR)    lpszText;
    ///Type: <b>LPCTSTR</b> A null-terminated string, or the identifier of a string resource, that contains the message
    ///box title. If this member is <b>NULL</b>, the default title <b>Error</b> is used.
    const(PSTR)    lpszCaption;
    ///Type: <b>DWORD</b> The contents and behavior of the dialog box. This member can be a combination of flags
    ///described for the <i>uType</i> parameter of the MessageBoxEx function. In addition, you can specify the
    ///<b>MB_USERICON</b> flag (0x00000080L) if you want the message box to display the icon specified by the
    ///<b>lpszIcon</b> member.
    uint           dwStyle;
    ///Type: <b>LPCTSTR</b> Identifies an icon resource. This parameter can be either a null-terminated string or an
    ///integer resource identifier passed to the MAKEINTRESOURCE macro. To load one of the standard system-defined
    ///icons, set the <b>hInstance</b> member to <b>NULL</b> and set <b>lpszIcon</b> to one of the values listed with
    ///the LoadIcon function. This member is ignored if the <b>dwStyle</b> member does not specify the
    ///<b>MB_USERICON</b> flag.
    const(PSTR)    lpszIcon;
    ///Type: <b>DWORD_PTR</b> Identifies a help context. If a help event occurs, this value is specified in the HELPINFO
    ///structure that the message box sends to the owner window or callback function.
    size_t         dwContextHelpId;
    ///Type: <b>MSGBOXCALLBACK</b> A pointer to the callback function that processes help events for the message box.
    ///The callback function has the following form: <code>VOID CALLBACK MsgBoxCallback(LPHELPINFO lpHelpInfo);</code>
    ///If this member is <b>NULL</b>, the message box sends WM_HELP messages to the owner window when help events occur.
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    ///Type: <b>DWORD</b> The language in which to display the text contained in the predefined push buttons. This value
    ///must be in the form returned by the MAKELANGID macro. For a list of supported language identifiers, see Language
    ///Identifiers. Note that each localized release of Windows typically contains resources only for a limited set of
    ///languages. Thus, for example, the U.S. version offers <b>LANG_ENGLISH</b>, the French version offers
    ///<b>LANG_FRENCH</b>, the German version offers <b>LANG_GERMAN</b>, and the Japanese version offers
    ///<b>LANG_JAPANESE</b>. Each version offers <b>LANG_NEUTRAL</b>. This limits the set of values that can be used
    ///with the <b>dwLanguageId</b> parameter. Before specifying a language identifier, you should enumerate the locales
    ///that are installed on a system.
    uint           dwLanguageId;
}

///Contains information used to display a message box. The MessageBoxIndirect function uses this structure.
struct MSGBOXPARAMSW
{
    ///Type: <b>UINT</b> The structure size, in bytes.
    uint           cbSize;
    ///Type: <b>HWND</b> A handle to the owner window. This member can be <b>NULL</b>.
    HWND           hwndOwner;
    ///Type: <b>HINSTANCE</b> A handle to the module that contains the icon resource identified by the <b>lpszIcon</b>
    ///member, and the string resource identified by the <b>lpszText</b> or <b>lpszCaption</b> member.
    HINSTANCE      hInstance;
    ///Type: <b>LPCTSTR</b> A null-terminated string, or the identifier of a string resource, that contains the message
    ///to be displayed.
    const(PWSTR)   lpszText;
    ///Type: <b>LPCTSTR</b> A null-terminated string, or the identifier of a string resource, that contains the message
    ///box title. If this member is <b>NULL</b>, the default title <b>Error</b> is used.
    const(PWSTR)   lpszCaption;
    ///Type: <b>DWORD</b> The contents and behavior of the dialog box. This member can be a combination of flags
    ///described for the <i>uType</i> parameter of the MessageBoxEx function. In addition, you can specify the
    ///<b>MB_USERICON</b> flag (0x00000080L) if you want the message box to display the icon specified by the
    ///<b>lpszIcon</b> member.
    uint           dwStyle;
    ///Type: <b>LPCTSTR</b> Identifies an icon resource. This parameter can be either a null-terminated string or an
    ///integer resource identifier passed to the MAKEINTRESOURCE macro. To load one of the standard system-defined
    ///icons, set the <b>hInstance</b> member to <b>NULL</b> and set <b>lpszIcon</b> to one of the values listed with
    ///the LoadIcon function. This member is ignored if the <b>dwStyle</b> member does not specify the
    ///<b>MB_USERICON</b> flag.
    const(PWSTR)   lpszIcon;
    ///Type: <b>DWORD_PTR</b> Identifies a help context. If a help event occurs, this value is specified in the HELPINFO
    ///structure that the message box sends to the owner window or callback function.
    size_t         dwContextHelpId;
    ///Type: <b>MSGBOXCALLBACK</b> A pointer to the callback function that processes help events for the message box.
    ///The callback function has the following form: <code>VOID CALLBACK MsgBoxCallback(LPHELPINFO lpHelpInfo);</code>
    ///If this member is <b>NULL</b>, the message box sends WM_HELP messages to the owner window when help events occur.
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    ///Type: <b>DWORD</b> The language in which to display the text contained in the predefined push buttons. This value
    ///must be in the form returned by the MAKELANGID macro. For a list of supported language identifiers, see Language
    ///Identifiers. Note that each localized release of Windows typically contains resources only for a limited set of
    ///languages. Thus, for example, the U.S. version offers <b>LANG_ENGLISH</b>, the French version offers
    ///<b>LANG_FRENCH</b>, the German version offers <b>LANG_GERMAN</b>, and the Japanese version offers
    ///<b>LANG_JAPANESE</b>. Each version offers <b>LANG_NEUTRAL</b>. This limits the set of values that can be used
    ///with the <b>dwLanguageId</b> parameter. Before specifying a language identifier, you should enumerate the locales
    ///that are installed on a system.
    uint           dwLanguageId;
}

///Contains information about the class, title, owner, location, and size of a multiple-document interface (MDI) child
///window.
struct MDICREATESTRUCTA
{
    ///Type: <b>LPCTSTR</b> The name of the window class of the MDI child window. The class name must have been
    ///registered by a previous call to the RegisterClass function.
    const(PSTR) szClass;
    ///Type: <b>LPCTSTR</b> The title of the MDI child window. The system displays the title in the child window's title
    ///bar.
    const(PSTR) szTitle;
    ///Type: <b>HANDLE</b> A handle to the instance of the application creating the MDI client window.
    HANDLE      hOwner;
    ///Type: <b>int</b> The initial horizontal position, in client coordinates, of the MDI child window. If this member
    ///is <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default horizontal position.
    int         x;
    ///Type: <b>int</b> The initial vertical position, in client coordinates, of the MDI child window. If this member is
    ///<b>CW_USEDEFAULT</b>, the MDI child window is assigned the default vertical position.
    int         y;
    ///Type: <b>int</b> The initial width, in device units, of the MDI child window. If this member is
    ///<b>CW_USEDEFAULT</b>, the MDI child window is assigned the default width.
    int         cx;
    ///Type: <b>int</b> The initial height, in device units, of the MDI child window. If this member is set to
    ///<b>CW_USEDEFAULT</b>, the MDI child window is assigned the default height.
    int         cy;
    ///Type: <b>DWORD</b> The style of the MDI child window. If the MDI client window was created with the
    ///<b>MDIS_ALLCHILDSTYLES</b> window style, this member can be any combination of the window styles listed in the
    ///Window Styles page. Otherwise, this member can be one or more of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WS_MINIMIZE"></a><a id="ws_minimize"></a><dl>
    ///<dt><b>WS_MINIMIZE</b></dt> <dt>0x20000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
    ///initially minimized. </td> </tr> <tr> <td width="40%"><a id="WS_MAXIMIZE"></a><a id="ws_maximize"></a><dl>
    ///<dt><b>WS_MAXIMIZE</b></dt> <dt>0x01000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
    ///initially maximized. </td> </tr> <tr> <td width="40%"><a id="WS_HSCROLL"></a><a id="ws_hscroll"></a><dl>
    ///<dt><b>WS_HSCROLL</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
    ///a horizontal scroll bar. </td> </tr> <tr> <td width="40%"><a id="WS_VSCROLL"></a><a id="ws_vscroll"></a><dl>
    ///<dt><b>WS_VSCROLL</b></dt> <dt>0x00200000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
    ///a vertical scroll bar. </td> </tr> </table>
    uint        style;
    ///Type: <b>LPARAM</b> An application-defined value.
    LPARAM      lParam;
}

///Contains information about the class, title, owner, location, and size of a multiple-document interface (MDI) child
///window.
struct MDICREATESTRUCTW
{
    ///Type: <b>LPCTSTR</b> The name of the window class of the MDI child window. The class name must have been
    ///registered by a previous call to the RegisterClass function.
    const(PWSTR) szClass;
    ///Type: <b>LPCTSTR</b> The title of the MDI child window. The system displays the title in the child window's title
    ///bar.
    const(PWSTR) szTitle;
    ///Type: <b>HANDLE</b> A handle to the instance of the application creating the MDI client window.
    HANDLE       hOwner;
    ///Type: <b>int</b> The initial horizontal position, in client coordinates, of the MDI child window. If this member
    ///is <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default horizontal position.
    int          x;
    ///Type: <b>int</b> The initial vertical position, in client coordinates, of the MDI child window. If this member is
    ///<b>CW_USEDEFAULT</b>, the MDI child window is assigned the default vertical position.
    int          y;
    ///Type: <b>int</b> The initial width, in device units, of the MDI child window. If this member is
    ///<b>CW_USEDEFAULT</b>, the MDI child window is assigned the default width.
    int          cx;
    ///Type: <b>int</b> The initial height, in device units, of the MDI child window. If this member is set to
    ///<b>CW_USEDEFAULT</b>, the MDI child window is assigned the default height.
    int          cy;
    ///Type: <b>DWORD</b> The style of the MDI child window. If the MDI client window was created with the
    ///<b>MDIS_ALLCHILDSTYLES</b> window style, this member can be any combination of the window styles listed in the
    ///Window Styles page. Otherwise, this member can be one or more of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WS_MINIMIZE"></a><a id="ws_minimize"></a><dl>
    ///<dt><b>WS_MINIMIZE</b></dt> <dt>0x20000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
    ///initially minimized. </td> </tr> <tr> <td width="40%"><a id="WS_MAXIMIZE"></a><a id="ws_maximize"></a><dl>
    ///<dt><b>WS_MAXIMIZE</b></dt> <dt>0x01000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
    ///initially maximized. </td> </tr> <tr> <td width="40%"><a id="WS_HSCROLL"></a><a id="ws_hscroll"></a><dl>
    ///<dt><b>WS_HSCROLL</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
    ///a horizontal scroll bar. </td> </tr> <tr> <td width="40%"><a id="WS_VSCROLL"></a><a id="ws_vscroll"></a><dl>
    ///<dt><b>WS_VSCROLL</b></dt> <dt>0x00200000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
    ///a vertical scroll bar. </td> </tr> </table>
    uint         style;
    ///Type: <b>LPARAM</b> An application-defined value.
    LPARAM       lParam;
}

///Contains information about the menu and first multiple-document interface (MDI) child window of an MDI client window.
///An application passes a pointer to this structure as the <i>lpParam</i> parameter of the CreateWindow function when
///creating an MDI client window.
struct CLIENTCREATESTRUCT
{
    ///Type: <b>HANDLE</b> A handle to the MDI application's window menu. An MDI application can retrieve this handle
    ///from the menu of the MDI frame window by using the GetSubMenu function.
    HANDLE hWindowMenu;
    ///Type: <b>UINT</b> The child window identifier of the first MDI child window created. The system increments the
    ///identifier for each additional MDI child window the application creates, and reassigns identifiers when the
    ///application destroys a window to keep the range of identifiers contiguous. These identifiers are used in
    ///WM_COMMAND messages sent to the application's MDI frame window when a child window is chosen from the window
    ///menu; they should not conflict with any other command identifiers.
    uint   idFirstChild;
}

///Contains the scalable metrics associated with the nonclient area of a nonminimized window. This structure is used by
///the <b>SPI_GETNONCLIENTMETRICS</b> and <b>SPI_SETNONCLIENTMETRICS</b> actions of the SystemParametersInfo function.
struct NONCLIENTMETRICSA
{
    ///The size of the structure, in bytes. The caller must set this to <code>sizeof(NONCLIENTMETRICS)</code>. For
    ///information about application compatibility, see Remarks.
    uint     cbSize;
    ///The thickness of the sizing border, in pixels. The default is 1 pixel.
    int      iBorderWidth;
    ///The width of a standard vertical scroll bar, in pixels.
    int      iScrollWidth;
    ///The height of a standard horizontal scroll bar, in pixels.
    int      iScrollHeight;
    ///The width of caption buttons, in pixels.
    int      iCaptionWidth;
    ///The height of caption buttons, in pixels.
    int      iCaptionHeight;
    ///A LOGFONT structure that contains information about the caption font.
    LOGFONTA lfCaptionFont;
    ///The width of small caption buttons, in pixels.
    int      iSmCaptionWidth;
    ///The height of small captions, in pixels.
    int      iSmCaptionHeight;
    ///A LOGFONT structure that contains information about the small caption font.
    LOGFONTA lfSmCaptionFont;
    ///The width of menu-bar buttons, in pixels.
    int      iMenuWidth;
    ///The height of a menu bar, in pixels.
    int      iMenuHeight;
    ///A LOGFONT structure that contains information about the font used in menu bars.
    LOGFONTA lfMenuFont;
    ///A LOGFONT structure that contains information about the font used in status bars and tooltips.
    LOGFONTA lfStatusFont;
    ///A LOGFONT structure that contains information about the font used in message boxes.
    LOGFONTA lfMessageFont;
    ///The thickness of the padded border, in pixels. The default value is 4 pixels. The <b>iPaddedBorderWidth</b> and
    ///<b>iBorderWidth</b> members are combined for both resizable and nonresizable windows in the Windows Aero desktop
    ///experience. To compile an application that uses this member, define <b>_WIN32_WINNT</b> as 0x0600 or later. For
    ///more information, see Remarks. <b>Windows Server 2003 and Windows XP/2000: </b>This member is not supported.
    int      iPaddedBorderWidth;
}

///Contains the scalable metrics associated with the nonclient area of a nonminimized window. This structure is used by
///the <b>SPI_GETNONCLIENTMETRICS</b> and <b>SPI_SETNONCLIENTMETRICS</b> actions of the SystemParametersInfo function.
struct NONCLIENTMETRICSW
{
    ///The size of the structure, in bytes. The caller must set this to <code>sizeof(NONCLIENTMETRICS)</code>. For
    ///information about application compatibility, see Remarks.
    uint     cbSize;
    ///The thickness of the sizing border, in pixels. The default is 1 pixel.
    int      iBorderWidth;
    ///The width of a standard vertical scroll bar, in pixels.
    int      iScrollWidth;
    ///The height of a standard horizontal scroll bar, in pixels.
    int      iScrollHeight;
    ///The width of caption buttons, in pixels.
    int      iCaptionWidth;
    ///The height of caption buttons, in pixels.
    int      iCaptionHeight;
    ///A LOGFONT structure that contains information about the caption font.
    LOGFONTW lfCaptionFont;
    ///The width of small caption buttons, in pixels.
    int      iSmCaptionWidth;
    ///The height of small captions, in pixels.
    int      iSmCaptionHeight;
    ///A LOGFONT structure that contains information about the small caption font.
    LOGFONTW lfSmCaptionFont;
    ///The width of menu-bar buttons, in pixels.
    int      iMenuWidth;
    ///The height of a menu bar, in pixels.
    int      iMenuHeight;
    ///A LOGFONT structure that contains information about the font used in menu bars.
    LOGFONTW lfMenuFont;
    ///A LOGFONT structure that contains information about the font used in status bars and tooltips.
    LOGFONTW lfStatusFont;
    ///A LOGFONT structure that contains information about the font used in message boxes.
    LOGFONTW lfMessageFont;
    ///The thickness of the padded border, in pixels. The default value is 4 pixels. The <b>iPaddedBorderWidth</b> and
    ///<b>iBorderWidth</b> members are combined for both resizable and nonresizable windows in the Windows Aero desktop
    ///experience. To compile an application that uses this member, define <b>_WIN32_WINNT</b> as 0x0600 or later. For
    ///more information, see Remarks. <b>Windows Server 2003 and Windows XP/2000: </b>This member is not supported.
    int      iPaddedBorderWidth;
}

///Contains the scalable metrics associated with minimized windows. This structure is used with the SystemParametersInfo
///function when the SPI_GETMINIMIZEDMETRICS or SPI_SETMINIMIZEDMETRICS action value is specified.
struct MINIMIZEDMETRICS
{
    ///The size of the structure, in bytes. The caller must set this to <code>sizeof(MINIMIZEDMETRICS)</code>.
    uint cbSize;
    ///The width of minimized windows, in pixels.
    int  iWidth;
    ///The horizontal space between arranged minimized windows, in pixels.
    int  iHorzGap;
    ///The vertical space between arranged minimized windows, in pixels.
    int  iVertGap;
    ///The starting position and direction used when arranging minimized windows. The starting position must be one of
    ///the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ARW_BOTTOMLEFT"></a><a id="arw_bottomleft"></a><dl> <dt><b>ARW_BOTTOMLEFT</b></dt> <dt>0x0000L</dt> </dl>
    ///</td> <td width="60%"> Start at the lower-left corner of the work area. </td> </tr> <tr> <td width="40%"><a
    ///id="ARW_BOTTOMRIGHT"></a><a id="arw_bottomright"></a><dl> <dt><b>ARW_BOTTOMRIGHT</b></dt> <dt>0x0001L</dt> </dl>
    ///</td> <td width="60%"> Start at the lower-right corner of the work area. </td> </tr> <tr> <td width="40%"><a
    ///id="ARW_TOPLEFT"></a><a id="arw_topleft"></a><dl> <dt><b>ARW_TOPLEFT</b></dt> <dt>0x0002L</dt> </dl> </td> <td
    ///width="60%"> Start at the upper-left corner of the work area. </td> </tr> <tr> <td width="40%"><a
    ///id="ARW_TOPRIGHT"></a><a id="arw_topright"></a><dl> <dt><b>ARW_TOPRIGHT</b></dt> <dt>0x0003L</dt> </dl> </td> <td
    ///width="60%"> Start at the upper-right corner of the work area. </td> </tr> </table> The direction must be one of
    ///the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ARW_LEFT"></a><a id="arw_left"></a><dl> <dt><b>ARW_LEFT</b></dt> <dt>0x0000L</dt> </dl> </td> <td
    ///width="60%"> Arrange left (valid with ARW_BOTTOMRIGHT and ARW_TOPRIGHT only). </td> </tr> <tr> <td width="40%"><a
    ///id="ARW_RIGHT"></a><a id="arw_right"></a><dl> <dt><b>ARW_RIGHT</b></dt> <dt>0x0000L</dt> </dl> </td> <td
    ///width="60%"> Arrange right (valid with ARW_BOTTOMLEFT and ARW_TOPLEFT only). </td> </tr> <tr> <td width="40%"><a
    ///id="ARW_UP"></a><a id="arw_up"></a><dl> <dt><b>ARW_UP</b></dt> <dt>0x0004L</dt> </dl> </td> <td width="60%">
    ///Arrange up (valid with ARW_BOTTOMLEFT and ARW_BOTTOMRIGHT only). </td> </tr> <tr> <td width="40%"><a
    ///id="ARW_DOWN"></a><a id="arw_down"></a><dl> <dt><b>ARW_DOWN</b></dt> <dt>0x0004L</dt> </dl> </td> <td
    ///width="60%"> Arrange down (valid with ARW_TOPLEFT and ARW_TOPRIGHT only). </td> </tr> <tr> <td width="40%"><a
    ///id="ARW_HIDE"></a><a id="arw_hide"></a><dl> <dt><b>ARW_HIDE</b></dt> <dt>0x0008L</dt> </dl> </td> <td
    ///width="60%"> Hide minimized windows by moving them off the visible area of the screen. </td> </tr> </table>
    int  iArrange;
}

///Describes the animation effects associated with user actions. This structure is used with the SystemParametersInfo
///function when the SPI_GETANIMATION or SPI_SETANIMATION action value is specified.
struct ANIMATIONINFO
{
    ///The size of the structure, in bytes. The caller must set this to <code>sizeof(ANIMATIONINFO)</code>.
    uint cbSize;
    ///If this member is nonzero, minimize and restore animation is enabled; otherwise it is disabled.
    int  iMinAnimate;
}

///Contains information associated with audio descriptions. This structure is used with the SystemParametersInfo
///function when the SPI_GETAUDIODESCRIPTION or SPI_SETAUDIODESCRIPTION action value is specified.
struct AUDIODESCRIPTION
{
    ///The size of the structure, in bytes. The caller must set this member to <code>sizeof(AUDIODESCRIPTION)</code>.
    uint cbSize;
    ///If this member is <b>TRUE</b>, audio descriptions are enabled; Otherwise, this member is <b>FALSE</b>.
    BOOL Enabled;
    ///The locale identifier (LCID) of the language for the audio description. For more information, see Locales and
    ///Languages.
    uint Locale;
}

///Contains information about a GUI thread.
struct GUITHREADINFO
{
    ///Type: <b>DWORD</b> The size of this structure, in bytes. The caller must set this member to
    ///<code>sizeof(GUITHREADINFO)</code>.
    uint cbSize;
    ///Type: <b>DWORD</b> The thread state. This member can be one or more of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GUI_CARETBLINKING"></a><a
    ///id="gui_caretblinking"></a><dl> <dt><b>GUI_CARETBLINKING</b></dt> <dt>0x00000001</dt> </dl> </td> <td
    ///width="60%"> The caret's blink state. This bit is set if the caret is visible. </td> </tr> <tr> <td
    ///width="40%"><a id="GUI_INMENUMODE"></a><a id="gui_inmenumode"></a><dl> <dt><b>GUI_INMENUMODE</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> The thread's menu state. This bit is set if the thread is in
    ///menu mode. </td> </tr> <tr> <td width="40%"><a id="GUI_INMOVESIZE"></a><a id="gui_inmovesize"></a><dl>
    ///<dt><b>GUI_INMOVESIZE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The thread's move state. This bit
    ///is set if the thread is in a move or size loop. </td> </tr> <tr> <td width="40%"><a id="GUI_POPUPMENUMODE"></a><a
    ///id="gui_popupmenumode"></a><dl> <dt><b>GUI_POPUPMENUMODE</b></dt> <dt>0x00000010</dt> </dl> </td> <td
    ///width="60%"> The thread's pop-up menu state. This bit is set if the thread has an active pop-up menu. </td> </tr>
    ///<tr> <td width="40%"><a id="GUI_SYSTEMMENUMODE"></a><a id="gui_systemmenumode"></a><dl>
    ///<dt><b>GUI_SYSTEMMENUMODE</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> The thread's system menu
    ///state. This bit is set if the thread is in a system menu mode. </td> </tr> </table>
    uint flags;
    ///Type: <b>HWND</b> A handle to the active window within the thread.
    HWND hwndActive;
    ///Type: <b>HWND</b> A handle to the window that has the keyboard focus.
    HWND hwndFocus;
    ///Type: <b>HWND</b> A handle to the window that has captured the mouse.
    HWND hwndCapture;
    ///Type: <b>HWND</b> A handle to the window that owns any active menus.
    HWND hwndMenuOwner;
    ///Type: <b>HWND</b> A handle to the window in a move or size loop.
    HWND hwndMoveSize;
    ///Type: <b>HWND</b> A handle to the window that is displaying the caret.
    HWND hwndCaret;
    ///Type: <b>RECT</b> The caret's bounding rectangle, in client coordinates, relative to the window specified by the
    ///<b>hwndCaret</b> member.
    RECT rcCaret;
}

///Contains window information.
struct WINDOWINFO
{
    ///Type: <b>DWORD</b> The size of the structure, in bytes. The caller must set this member to
    ///<code>sizeof(WINDOWINFO)</code>.
    uint   cbSize;
    ///Type: <b>RECT</b> The coordinates of the window.
    RECT   rcWindow;
    ///Type: <b>RECT</b> The coordinates of the client area.
    RECT   rcClient;
    ///Type: <b>DWORD</b> The window styles. For a table of window styles, see Window Styles.
    uint   dwStyle;
    ///Type: <b>DWORD</b> The extended window styles. For a table of extended window styles, see Extended Window Styles.
    uint   dwExStyle;
    ///Type: <b>DWORD</b> The window status. If this member is <b>WS_ACTIVECAPTION</b> (0x0001), the window is active.
    ///Otherwise, this member is zero.
    uint   dwWindowStatus;
    ///Type: <b>UINT</b> The width of the window border, in pixels.
    uint   cxWindowBorders;
    ///Type: <b>UINT</b> The height of the window border, in pixels.
    uint   cyWindowBorders;
    ///Type: <b>ATOM</b> The window class atom (see RegisterClass).
    ushort atomWindowType;
    ///Type: <b>WORD</b> The Windows version of the application that created the window.
    ushort wCreatorVersion;
}

///Contains title bar information.
struct TITLEBARINFO
{
    ///Type: <b>DWORD</b> The size, in bytes, of the structure. The caller must set this member to
    ///<code>sizeof(TITLEBARINFO)</code>.
    uint    cbSize;
    ///Type: <b>RECT</b> The coordinates of the title bar. These coordinates include all title-bar elements except the
    ///window menu.
    RECT    rcTitleBar;
    ///Type: <b>DWORD[CCHILDREN_TITLEBAR+1]</b> An array that receives a value for each element of the title bar. The
    ///following are the title bar elements represented by the array. <table class="clsStd"> <tr> <th>Index</th>
    ///<th>Title Bar Element</th> </tr> <tr> <td>0</td> <td>The title bar itself.</td> </tr> <tr> <td>1</td>
    ///<td>Reserved.</td> </tr> <tr> <td>2</td> <td>Minimize button.</td> </tr> <tr> <td>3</td> <td>Maximize
    ///button.</td> </tr> <tr> <td>4</td> <td>Help button.</td> </tr> <tr> <td>5</td> <td>Close button.</td> </tr>
    ///</table> Each array element is a combination of one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="STATE_SYSTEM_FOCUSABLE"></a><a
    ///id="state_system_focusable"></a><dl> <dt><b>STATE_SYSTEM_FOCUSABLE</b></dt> <dt>0x00100000</dt> </dl> </td> <td
    ///width="60%"> The element can accept the focus. </td> </tr> <tr> <td width="40%"><a
    ///id="STATE_SYSTEM_INVISIBLE"></a><a id="state_system_invisible"></a><dl> <dt><b>STATE_SYSTEM_INVISIBLE</b></dt>
    ///<dt>0x00008000</dt> </dl> </td> <td width="60%"> The element is invisible. </td> </tr> <tr> <td width="40%"><a
    ///id="STATE_SYSTEM_OFFSCREEN"></a><a id="state_system_offscreen"></a><dl> <dt><b>STATE_SYSTEM_OFFSCREEN</b></dt>
    ///<dt>0x00010000</dt> </dl> </td> <td width="60%"> The element has no visible representation. </td> </tr> <tr> <td
    ///width="40%"><a id="STATE_SYSTEM_UNAVAILABLE"></a><a id="state_system_unavailable"></a><dl>
    ///<dt><b>STATE_SYSTEM_UNAVAILABLE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The element is
    ///unavailable. </td> </tr> <tr> <td width="40%"><a id="STATE_SYSTEM_PRESSED"></a><a
    ///id="state_system_pressed"></a><dl> <dt><b>STATE_SYSTEM_PRESSED</b></dt> <dt>0x00000008</dt> </dl> </td> <td
    ///width="60%"> The element is in the pressed state. </td> </tr> </table>
    uint[6] rgstate;
}

///Expands on the information described in the TITLEBARINFO structure by including the coordinates of each element of
///the title bar. This structure is sent with the WM_GETTITLEBARINFOEX message.
struct TITLEBARINFOEX
{
    ///Type: <b>DWORD</b> The size of the structure, in bytes. Set this member to <code>sizeof(TITLEBARINFOEX)</code>
    ///before sending with the WM_GETTITLEBARINFOEX message.
    uint    cbSize;
    ///Type: <b>RECT</b> The bounding rectangle of the title bar. The rectangle is expressed in screen coordinates and
    ///includes all titlebar elements except the window menu.
    RECT    rcTitleBar;
    ///Type: <b>DWORD[CCHILDREN_TITLEBAR+1]</b> An array that receives a <b>DWORD</b> value for each element of the
    ///title bar. The following are the title bar elements represented by the array. <table class="clsStd"> <tr>
    ///<th>Index</th> <th>Title Bar Element</th> </tr> <tr> <td>0</td> <td>The title bar itself.</td> </tr> <tr>
    ///<td>1</td> <td>Reserved.</td> </tr> <tr> <td>2</td> <td>Minimize button.</td> </tr> <tr> <td>3</td> <td>Maximize
    ///button.</td> </tr> <tr> <td>4</td> <td>Help button.</td> </tr> <tr> <td>5</td> <td>Close button.</td> </tr>
    ///</table> Each array element is a combination of one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="STATE_SYSTEM_FOCUSABLE"></a><a
    ///id="state_system_focusable"></a><dl> <dt><b>STATE_SYSTEM_FOCUSABLE</b></dt> <dt>0x00100000</dt> </dl> </td> <td
    ///width="60%"> The element can accept the focus. </td> </tr> <tr> <td width="40%"><a
    ///id="STATE_SYSTEM_INVISIBLE"></a><a id="state_system_invisible"></a><dl> <dt><b>STATE_SYSTEM_INVISIBLE</b></dt>
    ///<dt>0x00008000</dt> </dl> </td> <td width="60%"> The element is invisible. </td> </tr> <tr> <td width="40%"><a
    ///id="STATE_SYSTEM_OFFSCREEN"></a><a id="state_system_offscreen"></a><dl> <dt><b>STATE_SYSTEM_OFFSCREEN</b></dt>
    ///<dt>0x00010000</dt> </dl> </td> <td width="60%"> The element has no visible representation. </td> </tr> <tr> <td
    ///width="40%"><a id="STATE_SYSTEM_UNAVAILABLE"></a><a id="state_system_unavailable"></a><dl>
    ///<dt><b>STATE_SYSTEM_UNAVAILABLE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The element is
    ///unavailable. </td> </tr> <tr> <td width="40%"><a id="STATE_SYSTEM_PRESSED"></a><a
    ///id="state_system_pressed"></a><dl> <dt><b>STATE_SYSTEM_PRESSED</b></dt> <dt>0x00000008</dt> </dl> </td> <td
    ///width="60%"> The element is in the pressed state. </td> </tr> </table>
    uint[6] rgstate;
    ///Type: <b>RECT[CCHILDREN_TITLEBAR+1]</b> An array that receives a structure for each element of the title bar. The
    ///structures are expressed in screen coordinates. The following are the title bar elements represented by the
    ///array. <table class="clsStd"> <tr> <th>Index</th> <th>Title Bar Element</th> </tr> <tr> <td>0</td>
    ///<td>Reserved.</td> </tr> <tr> <td>1</td> <td>Reserved.</td> </tr> <tr> <td>2</td> <td>Minimize button.</td> </tr>
    ///<tr> <td>3</td> <td>Maximize button.</td> </tr> <tr> <td>4</td> <td>Help button.</td> </tr> <tr> <td>5</td>
    ///<td>Close button.</td> </tr> </table>
    RECT[6] rgrect;
}

///Contains status information for the application-switching (ALT+TAB) window.
struct ALTTABINFO
{
    ///Type: <b>DWORD</b> The size, in bytes, of the structure. The caller must set this to
    ///<code>sizeof(ALTTABINFO)</code>.
    uint  cbSize;
    ///Type: <b>int</b> The number of items in the window.
    int   cItems;
    ///Type: <b>int</b> The number of columns in the window.
    int   cColumns;
    ///Type: <b>int</b> The number of rows in the window.
    int   cRows;
    ///Type: <b>int</b> The column of the item that has the focus.
    int   iColFocus;
    ///Type: <b>int</b> The row of the item that has the focus.
    int   iRowFocus;
    ///Type: <b>int</b> The width of each icon in the application-switching window.
    int   cxItem;
    ///Type: <b>int</b> The height of each icon in the application-switching window.
    int   cyItem;
    ///Type: <b>POINT</b> The top-left corner of the first icon.
    POINT ptStart;
}

///Contains extended result information obtained by calling the ChangeWindowMessageFilterEx function.
struct CHANGEFILTERSTRUCT
{
    ///Type: <b>DWORD</b> The size of the structure, in bytes. Must be set to <code>sizeof(CHANGEFILTERSTRUCT)</code>,
    ///otherwise the function fails with <b>ERROR_INVALID_PARAMETER</b>.
    uint cbSize;
    ///Type: <b>DWORD</b> If the function succeeds, this field contains one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MSGFLTINFO_NONE"></a><a
    ///id="msgfltinfo_none"></a><dl> <dt><b>MSGFLTINFO_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> See the
    ///Remarks section. Applies to <b>MSGFLT_ALLOW</b> and <b>MSGFLT_DISALLOW</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="MSGFLTINFO_ALLOWED_HIGHER"></a><a id="msgfltinfo_allowed_higher"></a><dl>
    ///<dt><b>MSGFLTINFO_ALLOWED_HIGHER</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The message is allowed at a
    ///scope higher than the window. Applies to <b>MSGFLT_DISALLOW</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="MSGFLTINFO_ALREADYALLOWED_FORWND"></a><a id="msgfltinfo_alreadyallowed_forwnd"></a><dl>
    ///<dt><b>MSGFLTINFO_ALREADYALLOWED_FORWND</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The message has already
    ///been allowed by this window's message filter, and the function thus succeeded with no change to the window's
    ///message filter. Applies to <b>MSGFLT_ALLOW</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="MSGFLTINFO_ALREADYDISALLOWED_FORWND"></a><a id="msgfltinfo_alreadydisallowed_forwnd"></a><dl>
    ///<dt><b>MSGFLTINFO_ALREADYDISALLOWED_FORWND</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The message has
    ///already been blocked by this window's message filter, and the function thus succeeded with no change to the
    ///window's message filter. Applies to <b>MSGFLT_DISALLOW</b>. </td> </tr> </table>
    uint ExtStatus;
}

///The <b>OPENFILENAME_NT4</b> structure is identical to OPENFILENAME with _WIN32_WINNT set to 0x0400. It allows an
///application to take advantage of other post-Microsoft Windows NT 4.0 features while running on Microsoft Windows NT
///4.0. Also, MFC42 applications must use <b>OPENFILENAME_NT4</b> to avoid heap corruption. This is because Microsoft
///Foundation Classes (MFC) has classes with embedded <b>OPENFILENAME</b> structures, and you must use the same
///structure size. <div class="alert"><b>Note</b> This structure is provided only for compatibility.</div><div> </div>
struct OPENFILENAME_NT4A
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(PSTR)   lpstrFilter;
    PSTR          lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    PSTR          lpstrFile;
    uint          nMaxFile;
    PSTR          lpstrFileTitle;
    uint          nMaxFileTitle;
    const(PSTR)   lpstrInitialDir;
    const(PSTR)   lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(PSTR)   lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(PSTR)   lpTemplateName;
}

///The <b>OPENFILENAME_NT4</b> structure is identical to OPENFILENAME with _WIN32_WINNT set to 0x0400. It allows an
///application to take advantage of other post-Microsoft Windows NT 4.0 features while running on Microsoft Windows NT
///4.0. Also, MFC42 applications must use <b>OPENFILENAME_NT4</b> to avoid heap corruption. This is because Microsoft
///Foundation Classes (MFC) has classes with embedded <b>OPENFILENAME</b> structures, and you must use the same
///structure size. <div class="alert"><b>Note</b> This structure is provided only for compatibility.</div><div> </div>
struct OPENFILENAME_NT4W
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(PWSTR)  lpstrFilter;
    PWSTR         lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    PWSTR         lpstrFile;
    uint          nMaxFile;
    PWSTR         lpstrFileTitle;
    uint          nMaxFileTitle;
    const(PWSTR)  lpstrInitialDir;
    const(PWSTR)  lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(PWSTR)  lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(PWSTR)  lpTemplateName;
}

///<p class="CCE_Message">[Starting with Windows Vista, the <b>Open</b> and <b>Save As</b> common dialog boxes have been
///superseded by the Common Item Dialog. We recommended that you use the Common Item Dialog API instead of these dialog
///boxes from the Common Dialog Box Library.] Contains information that the GetOpenFileName and GetSaveFileName
///functions use to initialize an <b>Open</b> or <b>Save As</b> dialog box. After the user closes the dialog box, the
///system returns information about the user's selection in this structure.
struct OPENFILENAMEA
{
align (1):
    ///Type: <b>DWORD</b> The length, in bytes, of the structure. Use <code>sizeof (OPENFILENAME)</code> for this
    ///parameter.
    uint          lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND          hwndOwner;
    ///Type: <b>HINSTANCE</b> If the <b>OFN_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to a memory object containing a dialog box template. If the
    ///<b>OFN_ENABLETEMPLATE</b> flag is set, <b>hInstance</b> is a handle to a module that contains a dialog box
    ///template named by the <b>lpTemplateName</b> member. If neither flag is set, this member is ignored. If the
    ///<b>OFN_EXPLORER</b> flag is set, the system uses the specified template to create a dialog box that is a child of
    ///the default Explorer-style dialog box. If the <b>OFN_EXPLORER</b> flag is not set, the system uses the template
    ///to create an old-style dialog box that replaces the default dialog box.
    HINSTANCE     hInstance;
    ///Type: <b>LPCTSTR</b> A buffer containing pairs of null-terminated filter strings. The last string in the buffer
    ///must be terminated by two <b>NULL</b> characters. The first string in each pair is a display string that
    ///describes the filter (for example, "Text Files"), and the second string specifies the filter pattern (for
    ///example, "*.TXT"). To specify multiple filter patterns for a single display string, use a semicolon to separate
    ///the patterns (for example, "*.TXT;*.DOC;*.BAK"). A pattern string can be a combination of valid file name
    ///characters and the asterisk (*) wildcard character. Do not include spaces in the pattern string. The system does
    ///not change the order of the filters. It displays them in the <b>File Types</b> combo box in the order specified
    ///in <b>lpstrFilter</b>. If <b>lpstrFilter</b> is <b>NULL</b>, the dialog box does not display any filters. In the
    ///case of a shortcut, if no filter is set, GetOpenFileName and GetSaveFileName retrieve the name of the .lnk file,
    ///not its target. This behavior is the same as setting the <b>OFN_NODEREFERENCELINKS</b> flag in the <b>Flags</b>
    ///member. To retrieve a shortcut's target without filtering, use the string <code>"All Files\0*.*\0\0"</code>.
    const(PSTR)   lpstrFilter;
    ///Type: <b>LPTSTR</b> A static buffer that contains a pair of null-terminated filter strings for preserving the
    ///filter pattern chosen by the user. The first string is your display string that describes the custom filter, and
    ///the second string is the filter pattern selected by the user. The first time your application creates the dialog
    ///box, you specify the first string, which can be any nonempty string. When the user selects a file, the dialog box
    ///copies the current filter pattern to the second string. The preserved filter pattern can be one of the patterns
    ///specified in the <b>lpstrFilter</b> buffer, or it can be a filter pattern typed by the user. The system uses the
    ///strings to initialize the user-defined file filter the next time the dialog box is created. If the
    ///<b>nFilterIndex</b> member is zero, the dialog box uses the custom filter. If this member is <b>NULL</b>, the
    ///dialog box does not preserve user-defined filter patterns. If this member is not <b>NULL</b>, the value of the
    ///<b>nMaxCustFilter</b> member must specify the size, in characters, of the <b>lpstrCustomFilter</b> buffer.
    PSTR          lpstrCustomFilter;
    ///Type: <b>DWORD</b> The size, in characters, of the buffer identified by <b>lpstrCustomFilter</b>. This buffer
    ///should be at least 40 characters long. This member is ignored if <b>lpstrCustomFilter</b> is <b>NULL</b> or
    ///points to a <b>NULL</b> string.
    uint          nMaxCustFilter;
    ///Type: <b>DWORD</b> The index of the currently selected filter in the <b>File Types</b> control. The buffer
    ///pointed to by <b>lpstrFilter</b> contains pairs of strings that define the filters. The first pair of strings has
    ///an index value of 1, the second pair 2, and so on. An index of zero indicates the custom filter specified by
    ///<b>lpstrCustomFilter</b>. You can specify an index on input to indicate the initial filter description and filter
    ///pattern for the dialog box. When the user selects a file, <b>nFilterIndex</b> returns the index of the currently
    ///displayed filter. If <b>nFilterIndex</b> is zero and <b>lpstrCustomFilter</b> is <b>NULL</b>, the system uses the
    ///first filter in the <b>lpstrFilter</b> buffer. If all three members are zero or <b>NULL</b>, the system does not
    ///use any filters and does not show any files in the file list control of the dialog box.
    uint          nFilterIndex;
    ///Type: <b>LPTSTR</b> The file name used to initialize the <b>File Name</b> edit control. The first character of
    ///this buffer must be <b>NULL</b> if initialization is not necessary. When the GetOpenFileName or GetSaveFileName
    ///function returns successfully, this buffer contains the drive designator, path, file name, and extension of the
    ///selected file. If the <b>OFN_ALLOWMULTISELECT</b> flag is set and the user selects multiple files, the buffer
    ///contains the current directory followed by the file names of the selected files. For Explorer-style dialog boxes,
    ///the directory and file name strings are <b>NULL</b> separated, with an extra <b>NULL</b> character after the last
    ///file name. For old-style dialog boxes, the strings are space separated and the function uses short file names for
    ///file names with spaces. You can use the FindFirstFile function to convert between long and short file names. If
    ///the user selects only one file, the <b>lpstrFile</b> string does not have a separator between the path and file
    ///name. If the buffer is too small, the function returns <b>FALSE</b> and the CommDlgExtendedError function returns
    ///<b>FNERR_BUFFERTOOSMALL</b>. In this case, the first two bytes of the <b>lpstrFile</b> buffer contain the
    ///required size, in bytes or characters.
    PSTR          lpstrFile;
    ///Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <b>lpstrFile</b>. The buffer must be
    ///large enough to store the path and file name string or strings, including the terminating <b>NULL</b> character.
    ///The GetOpenFileName and GetSaveFileName functions return <b>FALSE</b> if the buffer is too small to contain the
    ///file information. The buffer should be at least 256 characters long.
    uint          nMaxFile;
    ///Type: <b>LPTSTR</b> The file name and extension (without path information) of the selected file. This member can
    ///be <b>NULL</b>.
    PSTR          lpstrFileTitle;
    ///Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <b>lpstrFileTitle</b>. This member is
    ///ignored if <b>lpstrFileTitle</b> is <b>NULL</b>.
    uint          nMaxFileTitle;
    ///Type: <b>LPCTSTR</b> The initial directory. The algorithm for selecting the initial directory varies on different
    ///platforms. <b>Windows 7:</b> <ol> <li>If <b>lpstrInitialDir</b> has the same value as was passed the first time
    ///the application used an <b>Open</b> or <b>Save As</b> dialog box, the path most recently selected by the user is
    ///used as the initial directory.</li> <li>Otherwise, if <b>lpstrFile</b> contains a path, that path is the initial
    ///directory.</li> <li>Otherwise, if <b>lpstrInitialDir</b> is not <b>NULL</b>, it specifies the initial
    ///directory.</li> <li>If <b>lpstrInitialDir</b> is <b>NULL</b> and the current directory contains any files of the
    ///specified filter types, the initial directory is the current directory.</li> <li>Otherwise, the initial directory
    ///is the personal files directory of the current user.</li> <li>Otherwise, the initial directory is the Desktop
    ///folder.</li> </ol> <b>Windows 2000/XP/Vista:</b> <ol> <li>If <b>lpstrFile</b> contains a path, that path is the
    ///initial directory.</li> <li>Otherwise, <b>lpstrInitialDir</b> specifies the initial directory.</li>
    ///<li>Otherwise, if the application has used an <b>Open</b> or <b>Save As</b> dialog box in the past, the path most
    ///recently used is selected as the initial directory. However, if an application is not run for a long time, its
    ///saved selected path is discarded.</li> <li>If <b>lpstrInitialDir</b> is <b>NULL</b> and the current directory
    ///contains any files of the specified filter types, the initial directory is the current directory.</li>
    ///<li>Otherwise, the initial directory is the personal files directory of the current user.</li> <li>Otherwise, the
    ///initial directory is the Desktop folder.</li> </ol>
    const(PSTR)   lpstrInitialDir;
    ///Type: <b>LPCTSTR</b> A string to be placed in the title bar of the dialog box. If this member is <b>NULL</b>, the
    ///system uses the default title (that is, <b>Save As</b> or <b>Open</b>).
    const(PSTR)   lpstrTitle;
    ///Type: <b>DWORD</b> A set of bit flags you can use to initialize the dialog box. When the dialog box returns, it
    ///sets these flags to indicate the user's input. This member can be a combination of the following flags. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OFN_ALLOWMULTISELECT"></a><a
    ///id="ofn_allowmultiselect"></a><dl> <dt><b>OFN_ALLOWMULTISELECT</b></dt> <dt>0x00000200</dt> </dl> </td> <td
    ///width="60%"> The <b>File Name</b> list box allows multiple selections. If you also set the <b>OFN_EXPLORER</b>
    ///flag, the dialog box uses the Explorer-style user interface; otherwise, it uses the old-style user interface. If
    ///the user selects more than one file, the <b>lpstrFile</b> buffer returns the path to the current directory
    ///followed by the file names of the selected files. The <b>nFileOffset</b> member is the offset, in bytes or
    ///characters, to the first file name, and the <b>nFileExtension</b> member is not used. For Explorer-style dialog
    ///boxes, the directory and file name strings are <b>NULL</b> separated, with an extra <b>NULL</b> character after
    ///the last file name. This format enables the Explorer-style dialog boxes to return long file names that include
    ///spaces. For old-style dialog boxes, the directory and file name strings are separated by spaces and the function
    ///uses short file names for file names with spaces. You can use the FindFirstFile function to convert between long
    ///and short file names. If you specify a custom template for an old-style dialog box, the definition of the <b>File
    ///Name</b> list box must contain the <b>LBS_EXTENDEDSEL</b> value. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_CREATEPROMPT"></a><a id="ofn_createprompt"></a><dl> <dt><b>OFN_CREATEPROMPT</b></dt> <dt>0x00002000</dt>
    ///</dl> </td> <td width="60%"> If the user specifies a file that does not exist, this flag causes the dialog box to
    ///prompt the user for permission to create the file. If the user chooses to create the file, the dialog box closes
    ///and the function returns the specified name; otherwise, the dialog box remains open. If you use this flag with
    ///the <b>OFN_ALLOWMULTISELECT</b> flag, the dialog box allows the user to specify only one nonexistent file. </td>
    ///</tr> <tr> <td width="40%"><a id="OFN_DONTADDTORECENT"></a><a id="ofn_dontaddtorecent"></a><dl>
    ///<dt><b>OFN_DONTADDTORECENT</b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> Prevents the system from
    ///adding a link to the selected file in the file system directory that contains the user's most recently used
    ///documents. To retrieve the location of this directory, call the SHGetSpecialFolderLocation function with the
    ///<b>CSIDL_RECENT</b> flag. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLEHOOK"></a><a
    ///id="ofn_enablehook"></a><dl> <dt><b>OFN_ENABLEHOOK</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%">
    ///Enables the hook function specified in the <b>lpfnHook</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_ENABLEINCLUDENOTIFY"></a><a id="ofn_enableincludenotify"></a><dl> <dt><b>OFN_ENABLEINCLUDENOTIFY</b></dt>
    ///<dt>0x00400000</dt> </dl> </td> <td width="60%"> Causes the dialog box to send CDN_INCLUDEITEM notification
    ///messages to your OFNHookProc hook procedure when the user opens a folder. The dialog box sends a notification for
    ///each item in the newly opened folder. These messages enable you to control which items the dialog box displays in
    ///the folder's item list. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLESIZING"></a><a
    ///id="ofn_enablesizing"></a><dl> <dt><b>OFN_ENABLESIZING</b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%">
    ///Enables the Explorer-style dialog box to be resized using either the mouse or the keyboard. By default, the
    ///Explorer-style <b>Open</b> and <b>Save As</b> dialog boxes allow the dialog box to be resized regardless of
    ///whether this flag is set. This flag is necessary only if you provide a hook procedure or custom template. The
    ///old-style dialog box does not permit resizing. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLETEMPLATE"></a><a
    ///id="ofn_enabletemplate"></a><dl> <dt><b>OFN_ENABLETEMPLATE</b></dt> <dt>0x00000040</dt> </dl> </td> <td
    ///width="60%"> The <b>lpTemplateName</b> member is a pointer to the name of a dialog template resource in the
    ///module identified by the <b>hInstance</b> member. If the <b>OFN_EXPLORER</b> flag is set, the system uses the
    ///specified template to create a dialog box that is a child of the default Explorer-style dialog box. If the
    ///<b>OFN_EXPLORER</b> flag is not set, the system uses the template to create an old-style dialog box that replaces
    ///the default dialog box. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLETEMPLATEHANDLE"></a><a
    ///id="ofn_enabletemplatehandle"></a><dl> <dt><b>OFN_ENABLETEMPLATEHANDLE</b></dt> <dt>0x00000080</dt> </dl> </td>
    ///<td width="60%"> The <b>hInstance</b> member identifies a data block that contains a preloaded dialog box
    ///template. The system ignores <b>lpTemplateName</b> if this flag is specified. If the <b>OFN_EXPLORER</b> flag is
    ///set, the system uses the specified template to create a dialog box that is a child of the default Explorer-style
    ///dialog box. If the <b>OFN_EXPLORER</b> flag is not set, the system uses the template to create an old-style
    ///dialog box that replaces the default dialog box. </td> </tr> <tr> <td width="40%"><a id="OFN_EXPLORER"></a><a
    ///id="ofn_explorer"></a><dl> <dt><b>OFN_EXPLORER</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%">
    ///Indicates that any customizations made to the <b>Open</b> or <b>Save As</b> dialog box use the Explorer-style
    ///customization methods. For more information, see Explorer-Style Hook Procedures and Explorer-Style Custom
    ///Templates. By default, the <b>Open</b> and <b>Save As</b> dialog boxes use the Explorer-style user interface
    ///regardless of whether this flag is set. This flag is necessary only if you provide a hook procedure or custom
    ///template, or set the <b>OFN_ALLOWMULTISELECT</b> flag. If you want the old-style user interface, omit the
    ///<b>OFN_EXPLORER</b> flag and provide a replacement old-style template or hook procedure. If you want the old
    ///style but do not need a custom template or hook procedure, simply provide a hook procedure that always returns
    ///<b>FALSE</b>. </td> </tr> <tr> <td width="40%"><a id="OFN_EXTENSIONDIFFERENT"></a><a
    ///id="ofn_extensiondifferent"></a><dl> <dt><b>OFN_EXTENSIONDIFFERENT</b></dt> <dt>0x00000400</dt> </dl> </td> <td
    ///width="60%"> The user typed a file name extension that differs from the extension specified by
    ///<b>lpstrDefExt</b>. The function does not use this flag if <b>lpstrDefExt</b> is <b>NULL</b>. </td> </tr> <tr>
    ///<td width="40%"><a id="OFN_FILEMUSTEXIST"></a><a id="ofn_filemustexist"></a><dl>
    ///<dt><b>OFN_FILEMUSTEXIST</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> The user can type only names
    ///of existing files in the <b>File Name</b> entry field. If this flag is specified and the user enters an invalid
    ///name, the dialog box procedure displays a warning in a message box. If this flag is specified, the
    ///<b>OFN_PATHMUSTEXIST</b> flag is also used. This flag can be used in an <b>Open</b> dialog box. It cannot be used
    ///with a <b>Save As</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="OFN_FORCESHOWHIDDEN"></a><a
    ///id="ofn_forceshowhidden"></a><dl> <dt><b>OFN_FORCESHOWHIDDEN</b></dt> <dt>0x10000000</dt> </dl> </td> <td
    ///width="60%"> Forces the showing of system and hidden files, thus overriding the user setting to show or not show
    ///hidden files. However, a file that is marked both system and hidden is not shown. </td> </tr> <tr> <td
    ///width="40%"><a id="OFN_HIDEREADONLY"></a><a id="ofn_hidereadonly"></a><dl> <dt><b>OFN_HIDEREADONLY</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> Hides the <b>Read Only</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="OFN_LONGNAMES"></a><a id="ofn_longnames"></a><dl> <dt><b>OFN_LONGNAMES</b></dt>
    ///<dt>0x00200000</dt> </dl> </td> <td width="60%"> For old-style dialog boxes, this flag causes the dialog box to
    ///use long file names. If this flag is not specified, or if the <b>OFN_ALLOWMULTISELECT</b> flag is also set,
    ///old-style dialog boxes use short file names (8.3 format) for file names with spaces. Explorer-style dialog boxes
    ///ignore this flag and always display long file names. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_NOCHANGEDIR"></a><a id="ofn_nochangedir"></a><dl> <dt><b>OFN_NOCHANGEDIR</b></dt> <dt>0x00000008</dt>
    ///</dl> </td> <td width="60%"> Restores the current directory to its original value if the user changed the
    ///directory while searching for files. This flag is ineffective for GetOpenFileName. </td> </tr> <tr> <td
    ///width="40%"><a id="OFN_NODEREFERENCELINKS"></a><a id="ofn_nodereferencelinks"></a><dl>
    ///<dt><b>OFN_NODEREFERENCELINKS</b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Directs the dialog box to
    ///return the path and file name of the selected shortcut (.LNK) file. If this value is not specified, the dialog
    ///box returns the path and file name of the file referenced by the shortcut. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_NOLONGNAMES"></a><a id="ofn_nolongnames"></a><dl> <dt><b>OFN_NOLONGNAMES</b></dt> <dt>0x00040000</dt>
    ///</dl> </td> <td width="60%"> For old-style dialog boxes, this flag causes the dialog box to use short file names
    ///(8.3 format). Explorer-style dialog boxes ignore this flag and always display long file names. </td> </tr> <tr>
    ///<td width="40%"><a id="OFN_NONETWORKBUTTON"></a><a id="ofn_nonetworkbutton"></a><dl>
    ///<dt><b>OFN_NONETWORKBUTTON</b></dt> <dt>0x00020000</dt> </dl> </td> <td width="60%"> Hides and disables the
    ///<b>Network</b> button. </td> </tr> <tr> <td width="40%"><a id="OFN_NOREADONLYRETURN"></a><a
    ///id="ofn_noreadonlyreturn"></a><dl> <dt><b>OFN_NOREADONLYRETURN</b></dt> <dt>0x00008000</dt> </dl> </td> <td
    ///width="60%"> The returned file does not have the <b>Read Only</b> check box selected and is not in a
    ///write-protected directory. </td> </tr> <tr> <td width="40%"><a id="OFN_NOTESTFILECREATE"></a><a
    ///id="ofn_notestfilecreate"></a><dl> <dt><b>OFN_NOTESTFILECREATE</b></dt> <dt>0x00010000</dt> </dl> </td> <td
    ///width="60%"> The file is not created before the dialog box is closed. This flag should be specified if the
    ///application saves the file on a create-nonmodify network share. When an application specifies this flag, the
    ///library does not check for write protection, a full disk, an open drive door, or network protection. Applications
    ///using this flag must perform file operations carefully, because a file cannot be reopened once it is closed.
    ///</td> </tr> <tr> <td width="40%"><a id="OFN_NOVALIDATE"></a><a id="ofn_novalidate"></a><dl>
    ///<dt><b>OFN_NOVALIDATE</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> The common dialog boxes allow
    ///invalid characters in the returned file name. Typically, the calling application uses a hook procedure that
    ///checks the file name by using the FILEOKSTRING message. If the text box in the edit control is empty or contains
    ///nothing but spaces, the lists of files and directories are updated. If the text box in the edit control contains
    ///anything else, <b>nFileOffset</b> and <b>nFileExtension</b> are set to values generated by parsing the text. No
    ///default extension is added to the text, nor is text copied to the buffer specified by <b>lpstrFileTitle</b>. If
    ///the value specified by <b>nFileOffset</b> is less than zero, the file name is invalid. Otherwise, the file name
    ///is valid, and <b>nFileExtension</b> and <b>nFileOffset</b> can be used as if the <b>OFN_NOVALIDATE</b> flag had
    ///not been specified. </td> </tr> <tr> <td width="40%"><a id="OFN_OVERWRITEPROMPT"></a><a
    ///id="ofn_overwriteprompt"></a><dl> <dt><b>OFN_OVERWRITEPROMPT</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> Causes the <b>Save As</b> dialog box to generate a message box if the selected file already exists.
    ///The user must confirm whether to overwrite the file. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_PATHMUSTEXIST"></a><a id="ofn_pathmustexist"></a><dl> <dt><b>OFN_PATHMUSTEXIST</b></dt>
    ///<dt>0x00000800</dt> </dl> </td> <td width="60%"> The user can type only valid paths and file names. If this flag
    ///is used and the user types an invalid path and file name in the <b>File Name</b> entry field, the dialog box
    ///function displays a warning in a message box. </td> </tr> <tr> <td width="40%"><a id="OFN_READONLY"></a><a
    ///id="ofn_readonly"></a><dl> <dt><b>OFN_READONLY</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Causes
    ///the <b>Read Only</b> check box to be selected initially when the dialog box is created. This flag indicates the
    ///state of the <b>Read Only</b> check box when the dialog box is closed. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_SHAREAWARE"></a><a id="ofn_shareaware"></a><dl> <dt><b>OFN_SHAREAWARE</b></dt> <dt>0x00004000</dt> </dl>
    ///</td> <td width="60%"> Specifies that if a call to the OpenFile function fails because of a network sharing
    ///violation, the error is ignored and the dialog box returns the selected file name. If this flag is not set, the
    ///dialog box notifies your hook procedure when a network sharing violation occurs for the file name specified by
    ///the user. If you set the <b>OFN_EXPLORER</b> flag, the dialog box sends the CDN_SHAREVIOLATION message to the
    ///hook procedure. If you do not set <b>OFN_EXPLORER</b>, the dialog box sends the SHAREVISTRING registered message
    ///to the hook procedure. </td> </tr> <tr> <td width="40%"><a id="OFN_SHOWHELP"></a><a id="ofn_showhelp"></a><dl>
    ///<dt><b>OFN_SHOWHELP</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Causes the dialog box to display
    ///the <b>Help</b> button. The <b>hwndOwner</b> member must specify the window to receive the HELPMSGSTRING
    ///registered messages that the dialog box sends when the user clicks the <b>Help</b> button. An Explorer-style
    ///dialog box sends a CDN_HELP notification message to your hook procedure when the user clicks the <b>Help</b>
    ///button. </td> </tr> </table>
    uint          Flags;
    ///Type: <b>WORD</b> The zero-based offset, in characters, from the beginning of the path to the file name in the
    ///string pointed to by <b>lpstrFile</b>. For the ANSI version, this is the number of bytes; for the Unicode
    ///version, this is the number of characters. For example, if <b>lpstrFile</b> points to the following string,
    ///"c:\dir1\dir2\file.ext", this member contains the value 13 to indicate the offset of the "file.ext" string. If
    ///the user selects more than one file, <b>nFileOffset</b> is the offset to the first file name.
    ushort        nFileOffset;
    ///Type: <b>WORD</b> The zero-based offset, in characters, from the beginning of the path to the file name extension
    ///in the string pointed to by <b>lpstrFile</b>. For the ANSI version, this is the number of bytes; for the Unicode
    ///version, this is the number of characters. Usually the file name extension is the substring which follows the
    ///last occurrence of the dot (".") character. For example, txt is the extension of the filename readme.txt, html
    ///the extension of readme.txt.html. Therefore, if <b>lpstrFile</b> points to the string "c:\dir1\dir2\readme.txt",
    ///this member contains the value 20. If <b>lpstrFile</b> points to the string "c:\dir1\dir2\readme.txt.html", this
    ///member contains the value 24. If <b>lpstrFile</b> points to the string "c:\dir1\dir2\readme.txt.html.", this
    ///member contains the value 29. If <b>lpstrFile</b> points to a string that does not contain any "." character such
    ///as "c:\dir1\dir2\readme", this member contains zero.
    ushort        nFileExtension;
    ///Type: <b>LPCTSTR</b> The default extension. GetOpenFileName and GetSaveFileName append this extension to the file
    ///name if the user fails to type an extension. This string can be any length, but only the first three characters
    ///are appended. The string should not contain a period (.). If this member is <b>NULL</b> and the user fails to
    ///type an extension, no extension is appended.
    const(PSTR)   lpstrDefExt;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the <b>OPENFILENAME</b> structure specified when the dialog box was
    ///created. The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM        lCustData;
    ///Type: <b>LPOFNHOOKPROC</b> A pointer to a hook procedure. This member is ignored unless the <b>Flags</b> member
    ///includes the <b>OFN_ENABLEHOOK</b> flag. If the <b>OFN_EXPLORER</b> flag is not set in the <b>Flags</b> member,
    ///<b>lpfnHook</b> is a pointer to an OFNHookProcOldStyle hook procedure that receives messages intended for the
    ///dialog box. The hook procedure returns <b>FALSE</b> to pass a message to the default dialog box procedure or
    ///<b>TRUE</b> to discard the message. If <b>OFN_EXPLORER</b> is set, <b>lpfnHook</b> is a pointer to an OFNHookProc
    ///hook procedure. The hook procedure receives notification messages sent from the dialog box. The hook procedure
    ///also receives messages for any additional controls that you defined by specifying a child dialog template. The
    ///hook procedure does not receive messages intended for the standard controls of the default dialog box.
    LPOFNHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog template resource in the module identified by the <b>hInstance</b>
    ///member. For numbered dialog box resources, this can be a value returned by the MAKEINTRESOURCE macro. This member
    ///is ignored unless the <b>OFN_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member. If the
    ///<b>OFN_EXPLORER</b> flag is set, the system uses the specified template to create a dialog box that is a child of
    ///the default Explorer-style dialog box. If the <b>OFN_EXPLORER</b> flag is not set, the system uses the template
    ///to create an old-style dialog box that replaces the default dialog box.
    const(PSTR)   lpTemplateName;
    ///Type: <b>void*</b> This member is reserved.
    void*         pvReserved;
    ///Type: <b>DWORD</b> This member is reserved.
    uint          dwReserved;
    ///Type: <b>DWORD</b> A set of bit flags you can use to initialize the dialog box. Currently, this member can be
    ///zero or the following flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="OFN_EX_NOPLACESBAR"></a><a id="ofn_ex_noplacesbar"></a><dl> <dt><b>OFN_EX_NOPLACESBAR</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, the places bar is not displayed. If this
    ///flag is not set, Explorer-style dialog boxes include a places bar containing icons for commonly-used folders,
    ///such as Favorites and Desktop. </td> </tr> </table>
    uint          FlagsEx;
}

///<p class="CCE_Message">[Starting with Windows Vista, the <b>Open</b> and <b>Save As</b> common dialog boxes have been
///superseded by the Common Item Dialog. We recommended that you use the Common Item Dialog API instead of these dialog
///boxes from the Common Dialog Box Library.] Contains information that the GetOpenFileName and GetSaveFileName
///functions use to initialize an <b>Open</b> or <b>Save As</b> dialog box. After the user closes the dialog box, the
///system returns information about the user's selection in this structure.
struct OPENFILENAMEW
{
align (1):
    ///Type: <b>DWORD</b> The length, in bytes, of the structure. Use <code>sizeof (OPENFILENAME)</code> for this
    ///parameter.
    uint          lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND          hwndOwner;
    ///Type: <b>HINSTANCE</b> If the <b>OFN_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to a memory object containing a dialog box template. If the
    ///<b>OFN_ENABLETEMPLATE</b> flag is set, <b>hInstance</b> is a handle to a module that contains a dialog box
    ///template named by the <b>lpTemplateName</b> member. If neither flag is set, this member is ignored. If the
    ///<b>OFN_EXPLORER</b> flag is set, the system uses the specified template to create a dialog box that is a child of
    ///the default Explorer-style dialog box. If the <b>OFN_EXPLORER</b> flag is not set, the system uses the template
    ///to create an old-style dialog box that replaces the default dialog box.
    HINSTANCE     hInstance;
    ///Type: <b>LPCTSTR</b> A buffer containing pairs of null-terminated filter strings. The last string in the buffer
    ///must be terminated by two <b>NULL</b> characters. The first string in each pair is a display string that
    ///describes the filter (for example, "Text Files"), and the second string specifies the filter pattern (for
    ///example, "*.TXT"). To specify multiple filter patterns for a single display string, use a semicolon to separate
    ///the patterns (for example, "*.TXT;*.DOC;*.BAK"). A pattern string can be a combination of valid file name
    ///characters and the asterisk (*) wildcard character. Do not include spaces in the pattern string. The system does
    ///not change the order of the filters. It displays them in the <b>File Types</b> combo box in the order specified
    ///in <b>lpstrFilter</b>. If <b>lpstrFilter</b> is <b>NULL</b>, the dialog box does not display any filters. In the
    ///case of a shortcut, if no filter is set, GetOpenFileName and GetSaveFileName retrieve the name of the .lnk file,
    ///not its target. This behavior is the same as setting the <b>OFN_NODEREFERENCELINKS</b> flag in the <b>Flags</b>
    ///member. To retrieve a shortcut's target without filtering, use the string <code>"All Files\0*.*\0\0"</code>.
    const(PWSTR)  lpstrFilter;
    ///Type: <b>LPTSTR</b> A static buffer that contains a pair of null-terminated filter strings for preserving the
    ///filter pattern chosen by the user. The first string is your display string that describes the custom filter, and
    ///the second string is the filter pattern selected by the user. The first time your application creates the dialog
    ///box, you specify the first string, which can be any nonempty string. When the user selects a file, the dialog box
    ///copies the current filter pattern to the second string. The preserved filter pattern can be one of the patterns
    ///specified in the <b>lpstrFilter</b> buffer, or it can be a filter pattern typed by the user. The system uses the
    ///strings to initialize the user-defined file filter the next time the dialog box is created. If the
    ///<b>nFilterIndex</b> member is zero, the dialog box uses the custom filter. If this member is <b>NULL</b>, the
    ///dialog box does not preserve user-defined filter patterns. If this member is not <b>NULL</b>, the value of the
    ///<b>nMaxCustFilter</b> member must specify the size, in characters, of the <b>lpstrCustomFilter</b> buffer.
    PWSTR         lpstrCustomFilter;
    ///Type: <b>DWORD</b> The size, in characters, of the buffer identified by <b>lpstrCustomFilter</b>. This buffer
    ///should be at least 40 characters long. This member is ignored if <b>lpstrCustomFilter</b> is <b>NULL</b> or
    ///points to a <b>NULL</b> string.
    uint          nMaxCustFilter;
    ///Type: <b>DWORD</b> The index of the currently selected filter in the <b>File Types</b> control. The buffer
    ///pointed to by <b>lpstrFilter</b> contains pairs of strings that define the filters. The first pair of strings has
    ///an index value of 1, the second pair 2, and so on. An index of zero indicates the custom filter specified by
    ///<b>lpstrCustomFilter</b>. You can specify an index on input to indicate the initial filter description and filter
    ///pattern for the dialog box. When the user selects a file, <b>nFilterIndex</b> returns the index of the currently
    ///displayed filter. If <b>nFilterIndex</b> is zero and <b>lpstrCustomFilter</b> is <b>NULL</b>, the system uses the
    ///first filter in the <b>lpstrFilter</b> buffer. If all three members are zero or <b>NULL</b>, the system does not
    ///use any filters and does not show any files in the file list control of the dialog box.
    uint          nFilterIndex;
    ///Type: <b>LPTSTR</b> The file name used to initialize the <b>File Name</b> edit control. The first character of
    ///this buffer must be <b>NULL</b> if initialization is not necessary. When the GetOpenFileName or GetSaveFileName
    ///function returns successfully, this buffer contains the drive designator, path, file name, and extension of the
    ///selected file. If the <b>OFN_ALLOWMULTISELECT</b> flag is set and the user selects multiple files, the buffer
    ///contains the current directory followed by the file names of the selected files. For Explorer-style dialog boxes,
    ///the directory and file name strings are <b>NULL</b> separated, with an extra <b>NULL</b> character after the last
    ///file name. For old-style dialog boxes, the strings are space separated and the function uses short file names for
    ///file names with spaces. You can use the FindFirstFile function to convert between long and short file names. If
    ///the user selects only one file, the <b>lpstrFile</b> string does not have a separator between the path and file
    ///name. If the buffer is too small, the function returns <b>FALSE</b> and the CommDlgExtendedError function returns
    ///<b>FNERR_BUFFERTOOSMALL</b>. In this case, the first two bytes of the <b>lpstrFile</b> buffer contain the
    ///required size, in bytes or characters.
    PWSTR         lpstrFile;
    ///Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <b>lpstrFile</b>. The buffer must be
    ///large enough to store the path and file name string or strings, including the terminating <b>NULL</b> character.
    ///The GetOpenFileName and GetSaveFileName functions return <b>FALSE</b> if the buffer is too small to contain the
    ///file information. The buffer should be at least 256 characters long.
    uint          nMaxFile;
    ///Type: <b>LPTSTR</b> The file name and extension (without path information) of the selected file. This member can
    ///be <b>NULL</b>.
    PWSTR         lpstrFileTitle;
    ///Type: <b>DWORD</b> The size, in characters, of the buffer pointed to by <b>lpstrFileTitle</b>. This member is
    ///ignored if <b>lpstrFileTitle</b> is <b>NULL</b>.
    uint          nMaxFileTitle;
    ///Type: <b>LPCTSTR</b> The initial directory. The algorithm for selecting the initial directory varies on different
    ///platforms. <b>Windows 7:</b> <ol> <li>If <b>lpstrInitialDir</b> has the same value as was passed the first time
    ///the application used an <b>Open</b> or <b>Save As</b> dialog box, the path most recently selected by the user is
    ///used as the initial directory.</li> <li>Otherwise, if <b>lpstrFile</b> contains a path, that path is the initial
    ///directory.</li> <li>Otherwise, if <b>lpstrInitialDir</b> is not <b>NULL</b>, it specifies the initial
    ///directory.</li> <li>If <b>lpstrInitialDir</b> is <b>NULL</b> and the current directory contains any files of the
    ///specified filter types, the initial directory is the current directory.</li> <li>Otherwise, the initial directory
    ///is the personal files directory of the current user.</li> <li>Otherwise, the initial directory is the Desktop
    ///folder.</li> </ol> <b>Windows 2000/XP/Vista:</b> <ol> <li>If <b>lpstrFile</b> contains a path, that path is the
    ///initial directory.</li> <li>Otherwise, <b>lpstrInitialDir</b> specifies the initial directory.</li>
    ///<li>Otherwise, if the application has used an <b>Open</b> or <b>Save As</b> dialog box in the past, the path most
    ///recently used is selected as the initial directory. However, if an application is not run for a long time, its
    ///saved selected path is discarded.</li> <li>If <b>lpstrInitialDir</b> is <b>NULL</b> and the current directory
    ///contains any files of the specified filter types, the initial directory is the current directory.</li>
    ///<li>Otherwise, the initial directory is the personal files directory of the current user.</li> <li>Otherwise, the
    ///initial directory is the Desktop folder.</li> </ol>
    const(PWSTR)  lpstrInitialDir;
    ///Type: <b>LPCTSTR</b> A string to be placed in the title bar of the dialog box. If this member is <b>NULL</b>, the
    ///system uses the default title (that is, <b>Save As</b> or <b>Open</b>).
    const(PWSTR)  lpstrTitle;
    ///Type: <b>DWORD</b> A set of bit flags you can use to initialize the dialog box. When the dialog box returns, it
    ///sets these flags to indicate the user's input. This member can be a combination of the following flags. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OFN_ALLOWMULTISELECT"></a><a
    ///id="ofn_allowmultiselect"></a><dl> <dt><b>OFN_ALLOWMULTISELECT</b></dt> <dt>0x00000200</dt> </dl> </td> <td
    ///width="60%"> The <b>File Name</b> list box allows multiple selections. If you also set the <b>OFN_EXPLORER</b>
    ///flag, the dialog box uses the Explorer-style user interface; otherwise, it uses the old-style user interface. If
    ///the user selects more than one file, the <b>lpstrFile</b> buffer returns the path to the current directory
    ///followed by the file names of the selected files. The <b>nFileOffset</b> member is the offset, in bytes or
    ///characters, to the first file name, and the <b>nFileExtension</b> member is not used. For Explorer-style dialog
    ///boxes, the directory and file name strings are <b>NULL</b> separated, with an extra <b>NULL</b> character after
    ///the last file name. This format enables the Explorer-style dialog boxes to return long file names that include
    ///spaces. For old-style dialog boxes, the directory and file name strings are separated by spaces and the function
    ///uses short file names for file names with spaces. You can use the FindFirstFile function to convert between long
    ///and short file names. If you specify a custom template for an old-style dialog box, the definition of the <b>File
    ///Name</b> list box must contain the <b>LBS_EXTENDEDSEL</b> value. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_CREATEPROMPT"></a><a id="ofn_createprompt"></a><dl> <dt><b>OFN_CREATEPROMPT</b></dt> <dt>0x00002000</dt>
    ///</dl> </td> <td width="60%"> If the user specifies a file that does not exist, this flag causes the dialog box to
    ///prompt the user for permission to create the file. If the user chooses to create the file, the dialog box closes
    ///and the function returns the specified name; otherwise, the dialog box remains open. If you use this flag with
    ///the <b>OFN_ALLOWMULTISELECT</b> flag, the dialog box allows the user to specify only one nonexistent file. </td>
    ///</tr> <tr> <td width="40%"><a id="OFN_DONTADDTORECENT"></a><a id="ofn_dontaddtorecent"></a><dl>
    ///<dt><b>OFN_DONTADDTORECENT</b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> Prevents the system from
    ///adding a link to the selected file in the file system directory that contains the user's most recently used
    ///documents. To retrieve the location of this directory, call the SHGetSpecialFolderLocation function with the
    ///<b>CSIDL_RECENT</b> flag. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLEHOOK"></a><a
    ///id="ofn_enablehook"></a><dl> <dt><b>OFN_ENABLEHOOK</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%">
    ///Enables the hook function specified in the <b>lpfnHook</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_ENABLEINCLUDENOTIFY"></a><a id="ofn_enableincludenotify"></a><dl> <dt><b>OFN_ENABLEINCLUDENOTIFY</b></dt>
    ///<dt>0x00400000</dt> </dl> </td> <td width="60%"> Causes the dialog box to send CDN_INCLUDEITEM notification
    ///messages to your OFNHookProc hook procedure when the user opens a folder. The dialog box sends a notification for
    ///each item in the newly opened folder. These messages enable you to control which items the dialog box displays in
    ///the folder's item list. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLESIZING"></a><a
    ///id="ofn_enablesizing"></a><dl> <dt><b>OFN_ENABLESIZING</b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%">
    ///Enables the Explorer-style dialog box to be resized using either the mouse or the keyboard. By default, the
    ///Explorer-style <b>Open</b> and <b>Save As</b> dialog boxes allow the dialog box to be resized regardless of
    ///whether this flag is set. This flag is necessary only if you provide a hook procedure or custom template. The
    ///old-style dialog box does not permit resizing. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLETEMPLATE"></a><a
    ///id="ofn_enabletemplate"></a><dl> <dt><b>OFN_ENABLETEMPLATE</b></dt> <dt>0x00000040</dt> </dl> </td> <td
    ///width="60%"> The <b>lpTemplateName</b> member is a pointer to the name of a dialog template resource in the
    ///module identified by the <b>hInstance</b> member. If the <b>OFN_EXPLORER</b> flag is set, the system uses the
    ///specified template to create a dialog box that is a child of the default Explorer-style dialog box. If the
    ///<b>OFN_EXPLORER</b> flag is not set, the system uses the template to create an old-style dialog box that replaces
    ///the default dialog box. </td> </tr> <tr> <td width="40%"><a id="OFN_ENABLETEMPLATEHANDLE"></a><a
    ///id="ofn_enabletemplatehandle"></a><dl> <dt><b>OFN_ENABLETEMPLATEHANDLE</b></dt> <dt>0x00000080</dt> </dl> </td>
    ///<td width="60%"> The <b>hInstance</b> member identifies a data block that contains a preloaded dialog box
    ///template. The system ignores <b>lpTemplateName</b> if this flag is specified. If the <b>OFN_EXPLORER</b> flag is
    ///set, the system uses the specified template to create a dialog box that is a child of the default Explorer-style
    ///dialog box. If the <b>OFN_EXPLORER</b> flag is not set, the system uses the template to create an old-style
    ///dialog box that replaces the default dialog box. </td> </tr> <tr> <td width="40%"><a id="OFN_EXPLORER"></a><a
    ///id="ofn_explorer"></a><dl> <dt><b>OFN_EXPLORER</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%">
    ///Indicates that any customizations made to the <b>Open</b> or <b>Save As</b> dialog box use the Explorer-style
    ///customization methods. For more information, see Explorer-Style Hook Procedures and Explorer-Style Custom
    ///Templates. By default, the <b>Open</b> and <b>Save As</b> dialog boxes use the Explorer-style user interface
    ///regardless of whether this flag is set. This flag is necessary only if you provide a hook procedure or custom
    ///template, or set the <b>OFN_ALLOWMULTISELECT</b> flag. If you want the old-style user interface, omit the
    ///<b>OFN_EXPLORER</b> flag and provide a replacement old-style template or hook procedure. If you want the old
    ///style but do not need a custom template or hook procedure, simply provide a hook procedure that always returns
    ///<b>FALSE</b>. </td> </tr> <tr> <td width="40%"><a id="OFN_EXTENSIONDIFFERENT"></a><a
    ///id="ofn_extensiondifferent"></a><dl> <dt><b>OFN_EXTENSIONDIFFERENT</b></dt> <dt>0x00000400</dt> </dl> </td> <td
    ///width="60%"> The user typed a file name extension that differs from the extension specified by
    ///<b>lpstrDefExt</b>. The function does not use this flag if <b>lpstrDefExt</b> is <b>NULL</b>. </td> </tr> <tr>
    ///<td width="40%"><a id="OFN_FILEMUSTEXIST"></a><a id="ofn_filemustexist"></a><dl>
    ///<dt><b>OFN_FILEMUSTEXIST</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> The user can type only names
    ///of existing files in the <b>File Name</b> entry field. If this flag is specified and the user enters an invalid
    ///name, the dialog box procedure displays a warning in a message box. If this flag is specified, the
    ///<b>OFN_PATHMUSTEXIST</b> flag is also used. This flag can be used in an <b>Open</b> dialog box. It cannot be used
    ///with a <b>Save As</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="OFN_FORCESHOWHIDDEN"></a><a
    ///id="ofn_forceshowhidden"></a><dl> <dt><b>OFN_FORCESHOWHIDDEN</b></dt> <dt>0x10000000</dt> </dl> </td> <td
    ///width="60%"> Forces the showing of system and hidden files, thus overriding the user setting to show or not show
    ///hidden files. However, a file that is marked both system and hidden is not shown. </td> </tr> <tr> <td
    ///width="40%"><a id="OFN_HIDEREADONLY"></a><a id="ofn_hidereadonly"></a><dl> <dt><b>OFN_HIDEREADONLY</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> Hides the <b>Read Only</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="OFN_LONGNAMES"></a><a id="ofn_longnames"></a><dl> <dt><b>OFN_LONGNAMES</b></dt>
    ///<dt>0x00200000</dt> </dl> </td> <td width="60%"> For old-style dialog boxes, this flag causes the dialog box to
    ///use long file names. If this flag is not specified, or if the <b>OFN_ALLOWMULTISELECT</b> flag is also set,
    ///old-style dialog boxes use short file names (8.3 format) for file names with spaces. Explorer-style dialog boxes
    ///ignore this flag and always display long file names. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_NOCHANGEDIR"></a><a id="ofn_nochangedir"></a><dl> <dt><b>OFN_NOCHANGEDIR</b></dt> <dt>0x00000008</dt>
    ///</dl> </td> <td width="60%"> Restores the current directory to its original value if the user changed the
    ///directory while searching for files. This flag is ineffective for GetOpenFileName. </td> </tr> <tr> <td
    ///width="40%"><a id="OFN_NODEREFERENCELINKS"></a><a id="ofn_nodereferencelinks"></a><dl>
    ///<dt><b>OFN_NODEREFERENCELINKS</b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Directs the dialog box to
    ///return the path and file name of the selected shortcut (.LNK) file. If this value is not specified, the dialog
    ///box returns the path and file name of the file referenced by the shortcut. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_NOLONGNAMES"></a><a id="ofn_nolongnames"></a><dl> <dt><b>OFN_NOLONGNAMES</b></dt> <dt>0x00040000</dt>
    ///</dl> </td> <td width="60%"> For old-style dialog boxes, this flag causes the dialog box to use short file names
    ///(8.3 format). Explorer-style dialog boxes ignore this flag and always display long file names. </td> </tr> <tr>
    ///<td width="40%"><a id="OFN_NONETWORKBUTTON"></a><a id="ofn_nonetworkbutton"></a><dl>
    ///<dt><b>OFN_NONETWORKBUTTON</b></dt> <dt>0x00020000</dt> </dl> </td> <td width="60%"> Hides and disables the
    ///<b>Network</b> button. </td> </tr> <tr> <td width="40%"><a id="OFN_NOREADONLYRETURN"></a><a
    ///id="ofn_noreadonlyreturn"></a><dl> <dt><b>OFN_NOREADONLYRETURN</b></dt> <dt>0x00008000</dt> </dl> </td> <td
    ///width="60%"> The returned file does not have the <b>Read Only</b> check box selected and is not in a
    ///write-protected directory. </td> </tr> <tr> <td width="40%"><a id="OFN_NOTESTFILECREATE"></a><a
    ///id="ofn_notestfilecreate"></a><dl> <dt><b>OFN_NOTESTFILECREATE</b></dt> <dt>0x00010000</dt> </dl> </td> <td
    ///width="60%"> The file is not created before the dialog box is closed. This flag should be specified if the
    ///application saves the file on a create-nonmodify network share. When an application specifies this flag, the
    ///library does not check for write protection, a full disk, an open drive door, or network protection. Applications
    ///using this flag must perform file operations carefully, because a file cannot be reopened once it is closed.
    ///</td> </tr> <tr> <td width="40%"><a id="OFN_NOVALIDATE"></a><a id="ofn_novalidate"></a><dl>
    ///<dt><b>OFN_NOVALIDATE</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> The common dialog boxes allow
    ///invalid characters in the returned file name. Typically, the calling application uses a hook procedure that
    ///checks the file name by using the FILEOKSTRING message. If the text box in the edit control is empty or contains
    ///nothing but spaces, the lists of files and directories are updated. If the text box in the edit control contains
    ///anything else, <b>nFileOffset</b> and <b>nFileExtension</b> are set to values generated by parsing the text. No
    ///default extension is added to the text, nor is text copied to the buffer specified by <b>lpstrFileTitle</b>. If
    ///the value specified by <b>nFileOffset</b> is less than zero, the file name is invalid. Otherwise, the file name
    ///is valid, and <b>nFileExtension</b> and <b>nFileOffset</b> can be used as if the <b>OFN_NOVALIDATE</b> flag had
    ///not been specified. </td> </tr> <tr> <td width="40%"><a id="OFN_OVERWRITEPROMPT"></a><a
    ///id="ofn_overwriteprompt"></a><dl> <dt><b>OFN_OVERWRITEPROMPT</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> Causes the <b>Save As</b> dialog box to generate a message box if the selected file already exists.
    ///The user must confirm whether to overwrite the file. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_PATHMUSTEXIST"></a><a id="ofn_pathmustexist"></a><dl> <dt><b>OFN_PATHMUSTEXIST</b></dt>
    ///<dt>0x00000800</dt> </dl> </td> <td width="60%"> The user can type only valid paths and file names. If this flag
    ///is used and the user types an invalid path and file name in the <b>File Name</b> entry field, the dialog box
    ///function displays a warning in a message box. </td> </tr> <tr> <td width="40%"><a id="OFN_READONLY"></a><a
    ///id="ofn_readonly"></a><dl> <dt><b>OFN_READONLY</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Causes
    ///the <b>Read Only</b> check box to be selected initially when the dialog box is created. This flag indicates the
    ///state of the <b>Read Only</b> check box when the dialog box is closed. </td> </tr> <tr> <td width="40%"><a
    ///id="OFN_SHAREAWARE"></a><a id="ofn_shareaware"></a><dl> <dt><b>OFN_SHAREAWARE</b></dt> <dt>0x00004000</dt> </dl>
    ///</td> <td width="60%"> Specifies that if a call to the OpenFile function fails because of a network sharing
    ///violation, the error is ignored and the dialog box returns the selected file name. If this flag is not set, the
    ///dialog box notifies your hook procedure when a network sharing violation occurs for the file name specified by
    ///the user. If you set the <b>OFN_EXPLORER</b> flag, the dialog box sends the CDN_SHAREVIOLATION message to the
    ///hook procedure. If you do not set <b>OFN_EXPLORER</b>, the dialog box sends the SHAREVISTRING registered message
    ///to the hook procedure. </td> </tr> <tr> <td width="40%"><a id="OFN_SHOWHELP"></a><a id="ofn_showhelp"></a><dl>
    ///<dt><b>OFN_SHOWHELP</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Causes the dialog box to display
    ///the <b>Help</b> button. The <b>hwndOwner</b> member must specify the window to receive the HELPMSGSTRING
    ///registered messages that the dialog box sends when the user clicks the <b>Help</b> button. An Explorer-style
    ///dialog box sends a CDN_HELP notification message to your hook procedure when the user clicks the <b>Help</b>
    ///button. </td> </tr> </table>
    uint          Flags;
    ///Type: <b>WORD</b> The zero-based offset, in characters, from the beginning of the path to the file name in the
    ///string pointed to by <b>lpstrFile</b>. For the ANSI version, this is the number of bytes; for the Unicode
    ///version, this is the number of characters. For example, if <b>lpstrFile</b> points to the following string,
    ///"c:\dir1\dir2\file.ext", this member contains the value 13 to indicate the offset of the "file.ext" string. If
    ///the user selects more than one file, <b>nFileOffset</b> is the offset to the first file name.
    ushort        nFileOffset;
    ///Type: <b>WORD</b> The zero-based offset, in characters, from the beginning of the path to the file name extension
    ///in the string pointed to by <b>lpstrFile</b>. For the ANSI version, this is the number of bytes; for the Unicode
    ///version, this is the number of characters. Usually the file name extension is the substring which follows the
    ///last occurrence of the dot (".") character. For example, txt is the extension of the filename readme.txt, html
    ///the extension of readme.txt.html. Therefore, if <b>lpstrFile</b> points to the string "c:\dir1\dir2\readme.txt",
    ///this member contains the value 20. If <b>lpstrFile</b> points to the string "c:\dir1\dir2\readme.txt.html", this
    ///member contains the value 24. If <b>lpstrFile</b> points to the string "c:\dir1\dir2\readme.txt.html.", this
    ///member contains the value 29. If <b>lpstrFile</b> points to a string that does not contain any "." character such
    ///as "c:\dir1\dir2\readme", this member contains zero.
    ushort        nFileExtension;
    ///Type: <b>LPCTSTR</b> The default extension. GetOpenFileName and GetSaveFileName append this extension to the file
    ///name if the user fails to type an extension. This string can be any length, but only the first three characters
    ///are appended. The string should not contain a period (.). If this member is <b>NULL</b> and the user fails to
    ///type an extension, no extension is appended.
    const(PWSTR)  lpstrDefExt;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the <b>OPENFILENAME</b> structure specified when the dialog box was
    ///created. The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM        lCustData;
    ///Type: <b>LPOFNHOOKPROC</b> A pointer to a hook procedure. This member is ignored unless the <b>Flags</b> member
    ///includes the <b>OFN_ENABLEHOOK</b> flag. If the <b>OFN_EXPLORER</b> flag is not set in the <b>Flags</b> member,
    ///<b>lpfnHook</b> is a pointer to an OFNHookProcOldStyle hook procedure that receives messages intended for the
    ///dialog box. The hook procedure returns <b>FALSE</b> to pass a message to the default dialog box procedure or
    ///<b>TRUE</b> to discard the message. If <b>OFN_EXPLORER</b> is set, <b>lpfnHook</b> is a pointer to an OFNHookProc
    ///hook procedure. The hook procedure receives notification messages sent from the dialog box. The hook procedure
    ///also receives messages for any additional controls that you defined by specifying a child dialog template. The
    ///hook procedure does not receive messages intended for the standard controls of the default dialog box.
    LPOFNHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog template resource in the module identified by the <b>hInstance</b>
    ///member. For numbered dialog box resources, this can be a value returned by the MAKEINTRESOURCE macro. This member
    ///is ignored unless the <b>OFN_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member. If the
    ///<b>OFN_EXPLORER</b> flag is set, the system uses the specified template to create a dialog box that is a child of
    ///the default Explorer-style dialog box. If the <b>OFN_EXPLORER</b> flag is not set, the system uses the template
    ///to create an old-style dialog box that replaces the default dialog box.
    const(PWSTR)  lpTemplateName;
    ///Type: <b>void*</b> This member is reserved.
    void*         pvReserved;
    ///Type: <b>DWORD</b> This member is reserved.
    uint          dwReserved;
    ///Type: <b>DWORD</b> A set of bit flags you can use to initialize the dialog box. Currently, this member can be
    ///zero or the following flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="OFN_EX_NOPLACESBAR"></a><a id="ofn_ex_noplacesbar"></a><dl> <dt><b>OFN_EX_NOPLACESBAR</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, the places bar is not displayed. If this
    ///flag is not set, Explorer-style dialog boxes include a places bar containing icons for commonly-used folders,
    ///such as Favorites and Desktop. </td> </tr> </table>
    uint          FlagsEx;
}

///Contains information about a WM_NOTIFY message sent to an OFNHookProc hook procedure for an <b>Open</b> or <b>Save
///As</b> dialog box. The <i>lParam</i> parameter of the <b>WM_NOTIFY</b> message is a pointer to an <b>OFNOTIFY</b>
///structure.
struct OFNOTIFYA
{
align (1):
    ///Type: <b>NMHDR</b> The <b>code</b> member of this structure can be one of the following notification messages
    ///that identify the message being sent: CDN_FILEOK, CDN_FOLDERCHANGE, CDN_HELP, CDN_INITDONE, CDN_SELCHANGE,
    ///CDN_SHAREVIOLATION, CDN_TYPECHANGE.
    NMHDR          hdr;
    ///Type: <b>LPOPENFILENAME</b> A pointer to the OPENFILENAME structure that was specified when the <b>Open</b> or
    ///<b>Save As</b> dialog box was created. For some of the notification messages, this structure contains additional
    ///information about the event that caused the notification.
    OPENFILENAMEA* lpOFN;
    ///Type: <b>LPTSTR</b> The file name for which a network sharing violation has occurred. This member is valid only
    ///with the CDN_SHAREVIOLATION notification message.
    PSTR           pszFile;
}

///Contains information about a WM_NOTIFY message sent to an OFNHookProc hook procedure for an <b>Open</b> or <b>Save
///As</b> dialog box. The <i>lParam</i> parameter of the <b>WM_NOTIFY</b> message is a pointer to an <b>OFNOTIFY</b>
///structure.
struct OFNOTIFYW
{
align (1):
    ///Type: <b>NMHDR</b> The <b>code</b> member of this structure can be one of the following notification messages
    ///that identify the message being sent: CDN_FILEOK, CDN_FOLDERCHANGE, CDN_HELP, CDN_INITDONE, CDN_SELCHANGE,
    ///CDN_SHAREVIOLATION, CDN_TYPECHANGE.
    NMHDR          hdr;
    ///Type: <b>LPOPENFILENAME</b> A pointer to the OPENFILENAME structure that was specified when the <b>Open</b> or
    ///<b>Save As</b> dialog box was created. For some of the notification messages, this structure contains additional
    ///information about the event that caused the notification.
    OPENFILENAMEW* lpOFN;
    ///Type: <b>LPTSTR</b> The file name for which a network sharing violation has occurred. This member is valid only
    ///with the CDN_SHAREVIOLATION notification message.
    PWSTR          pszFile;
}

///Contains information about a CDN_INCLUDEITEM notification message.
struct OFNOTIFYEXA
{
align (1):
    ///Type: <b>NMHDR</b> The <b>code</b> member of this structure identifies the notification message being sent.
    NMHDR          hdr;
    ///Type: <b>LPOPENFILENAME</b> A pointer to an OPENFILENAME structure containing the values specified when the
    ///<b>Open</b> or <b>Save As</b> dialog box was created.
    OPENFILENAMEA* lpOFN;
    ///Type: <b>LPVOID</b> A pointer to the interface for the folder or shell name-space extension whose items are being
    ///enumerated.
    void*          psf;
    ///Type: <b>LPVOID</b> A pointer to an item identifier list that identifies an item in the container identified by
    ///the <b>psf</b> member. The item identifier is relative to the <b>psf</b> container.
    void*          pidl;
}

///Contains information about a CDN_INCLUDEITEM notification message.
struct OFNOTIFYEXW
{
align (1):
    ///Type: <b>NMHDR</b> The <b>code</b> member of this structure identifies the notification message being sent.
    NMHDR          hdr;
    ///Type: <b>LPOPENFILENAME</b> A pointer to an OPENFILENAME structure containing the values specified when the
    ///<b>Open</b> or <b>Save As</b> dialog box was created.
    OPENFILENAMEW* lpOFN;
    ///Type: <b>LPVOID</b> A pointer to the interface for the folder or shell name-space extension whose items are being
    ///enumerated.
    void*          psf;
    ///Type: <b>LPVOID</b> A pointer to an item identifier list that identifies an item in the container identified by
    ///the <b>psf</b> member. The item identifier is relative to the <b>psf</b> container.
    void*          pidl;
}

///Contains information the ChooseColor function uses to initialize the <b>Color</b> dialog box. After the user closes
///the dialog box, the system returns information about the user's selection in this structure.
struct CHOOSECOLORA
{
align (1):
    ///Type: <b>DWORD</b> The length, in bytes, of the structure.
    uint         lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND         hwndOwner;
    ///Type: <b>HWND</b> If the <b>CC_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member, <b>hInstance</b>
    ///is a handle to a memory object containing a dialog box template. If the <b>CC_ENABLETEMPLATE</b> flag is set,
    ///<b>hInstance</b> is a handle to a module that contains a dialog box template named by the <b>lpTemplateName</b>
    ///member. If neither <b>CC_ENABLETEMPLATEHANDLE</b> nor <b>CC_ENABLETEMPLATE</b> is set, this member is ignored.
    HWND         hInstance;
    ///Type: <b>COLORREF</b> If the <b>CC_RGBINIT</b> flag is set, <b>rgbResult</b> specifies the color initially
    ///selected when the dialog box is created. If the specified color value is not among the available colors, the
    ///system selects the nearest solid color available. If <b>rgbResult</b> is zero or <b>CC_RGBINIT</b> is not set,
    ///the initially selected color is black. If the user clicks the <b>OK</b> button, <b>rgbResult</b> specifies the
    ///user's color selection. To create a COLORREF color value, use the RGB macro.
    uint         rgbResult;
    ///Type: <b>COLORREF*</b> A pointer to an array of 16 values that contain red, green, blue (RGB) values for the
    ///custom color boxes in the dialog box. If the user modifies these colors, the system updates the array with the
    ///new RGB values. To preserve new custom colors between calls to the ChooseColor function, you should allocate
    ///static memory for the array. To create a COLORREF color value, use the RGB macro.
    uint*        lpCustColors;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Color</b> dialog box. When the dialog
    ///box returns, it sets these flags to indicate the user's input. This member can be a combination of the following
    ///flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CC_ANYCOLOR"></a><a
    ///id="cc_anycolor"></a><dl> <dt><b>CC_ANYCOLOR</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Causes the
    ///dialog box to display all available colors in the set of basic colors. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_ENABLEHOOK"></a><a id="cc_enablehook"></a><dl> <dt><b>CC_ENABLEHOOK</b></dt> <dt>0x00000010</dt> </dl>
    ///</td> <td width="60%"> Enables the hook procedure specified in the <b>lpfnHook</b> member of this structure. This
    ///flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a id="CC_ENABLETEMPLATE"></a><a
    ///id="cc_enabletemplate"></a><dl> <dt><b>CC_ENABLETEMPLATE</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> The <b>hInstance</b> and <b>lpTemplateName</b> members specify a dialog box template to use in place
    ///of the default template. This flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_ENABLETEMPLATEHANDLE"></a><a id="cc_enabletemplatehandle"></a><dl> <dt><b>CC_ENABLETEMPLATEHANDLE</b></dt>
    ///<dt>0x00000040</dt> </dl> </td> <td width="60%"> The <b>hInstance</b> member identifies a data block that
    ///contains a preloaded dialog box template. The system ignores the <b>lpTemplateName</b> member if this flag is
    ///specified. This flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_FULLOPEN"></a><a id="cc_fullopen"></a><dl> <dt><b>CC_FULLOPEN</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> Causes the dialog box to display the additional controls that allow the user to create custom
    ///colors. If this flag is not set, the user must click the <b>Define Custom Color</b> button to display the custom
    ///color controls. </td> </tr> <tr> <td width="40%"><a id="CC_PREVENTFULLOPEN"></a><a
    ///id="cc_preventfullopen"></a><dl> <dt><b>CC_PREVENTFULLOPEN</b></dt> <dt>0x00000004</dt> </dl> </td> <td
    ///width="60%"> Disables the <b>Define Custom Color</b> button. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_RGBINIT"></a><a id="cc_rgbinit"></a><dl> <dt><b>CC_RGBINIT</b></dt> <dt>0x00000001</dt> </dl> </td> <td
    ///width="60%"> Causes the dialog box to use the color specified in the <b>rgbResult</b> member as the initial color
    ///selection. </td> </tr> <tr> <td width="40%"><a id="CC_SHOWHELP"></a><a id="cc_showhelp"></a><dl>
    ///<dt><b>CC_SHOWHELP</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Causes the dialog box to display the
    ///Help button. The <b>hwndOwner</b> member must specify the window to receive the HELPMSGSTRING registered messages
    ///that the dialog box sends when the user clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_SOLIDCOLOR"></a><a id="cc_solidcolor"></a><dl> <dt><b>CC_SOLIDCOLOR</b></dt> <dt>0x00000080</dt> </dl>
    ///</td> <td width="60%"> Causes the dialog box to display only solid colors in the set of basic colors. </td> </tr>
    ///</table>
    uint         Flags;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the <b>CHOOSECOLOR</b> structure specified when the dialog was created.
    ///The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM       lCustData;
    ///Type: <b>LPCCHOOKPROC</b> A pointer to a CCHookProc hook procedure that can process messages intended for the
    ///dialog box. This member is ignored unless the <b>CC_ENABLEHOOK</b> flag is set in the <b>Flags</b> member.
    LPCCHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, <b>lpTemplateName</b> can be a value returned by the MAKEINTRESOURCE macro. This member is ignored
    ///unless the <b>CC_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PSTR)  lpTemplateName;
}

///Contains information the ChooseColor function uses to initialize the <b>Color</b> dialog box. After the user closes
///the dialog box, the system returns information about the user's selection in this structure.
struct CHOOSECOLORW
{
align (1):
    ///Type: <b>DWORD</b> The length, in bytes, of the structure.
    uint         lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND         hwndOwner;
    ///Type: <b>HWND</b> If the <b>CC_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member, <b>hInstance</b>
    ///is a handle to a memory object containing a dialog box template. If the <b>CC_ENABLETEMPLATE</b> flag is set,
    ///<b>hInstance</b> is a handle to a module that contains a dialog box template named by the <b>lpTemplateName</b>
    ///member. If neither <b>CC_ENABLETEMPLATEHANDLE</b> nor <b>CC_ENABLETEMPLATE</b> is set, this member is ignored.
    HWND         hInstance;
    ///Type: <b>COLORREF</b> If the <b>CC_RGBINIT</b> flag is set, <b>rgbResult</b> specifies the color initially
    ///selected when the dialog box is created. If the specified color value is not among the available colors, the
    ///system selects the nearest solid color available. If <b>rgbResult</b> is zero or <b>CC_RGBINIT</b> is not set,
    ///the initially selected color is black. If the user clicks the <b>OK</b> button, <b>rgbResult</b> specifies the
    ///user's color selection. To create a COLORREF color value, use the RGB macro.
    uint         rgbResult;
    ///Type: <b>COLORREF*</b> A pointer to an array of 16 values that contain red, green, blue (RGB) values for the
    ///custom color boxes in the dialog box. If the user modifies these colors, the system updates the array with the
    ///new RGB values. To preserve new custom colors between calls to the ChooseColor function, you should allocate
    ///static memory for the array. To create a COLORREF color value, use the RGB macro.
    uint*        lpCustColors;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Color</b> dialog box. When the dialog
    ///box returns, it sets these flags to indicate the user's input. This member can be a combination of the following
    ///flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CC_ANYCOLOR"></a><a
    ///id="cc_anycolor"></a><dl> <dt><b>CC_ANYCOLOR</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Causes the
    ///dialog box to display all available colors in the set of basic colors. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_ENABLEHOOK"></a><a id="cc_enablehook"></a><dl> <dt><b>CC_ENABLEHOOK</b></dt> <dt>0x00000010</dt> </dl>
    ///</td> <td width="60%"> Enables the hook procedure specified in the <b>lpfnHook</b> member of this structure. This
    ///flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a id="CC_ENABLETEMPLATE"></a><a
    ///id="cc_enabletemplate"></a><dl> <dt><b>CC_ENABLETEMPLATE</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> The <b>hInstance</b> and <b>lpTemplateName</b> members specify a dialog box template to use in place
    ///of the default template. This flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_ENABLETEMPLATEHANDLE"></a><a id="cc_enabletemplatehandle"></a><dl> <dt><b>CC_ENABLETEMPLATEHANDLE</b></dt>
    ///<dt>0x00000040</dt> </dl> </td> <td width="60%"> The <b>hInstance</b> member identifies a data block that
    ///contains a preloaded dialog box template. The system ignores the <b>lpTemplateName</b> member if this flag is
    ///specified. This flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_FULLOPEN"></a><a id="cc_fullopen"></a><dl> <dt><b>CC_FULLOPEN</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> Causes the dialog box to display the additional controls that allow the user to create custom
    ///colors. If this flag is not set, the user must click the <b>Define Custom Color</b> button to display the custom
    ///color controls. </td> </tr> <tr> <td width="40%"><a id="CC_PREVENTFULLOPEN"></a><a
    ///id="cc_preventfullopen"></a><dl> <dt><b>CC_PREVENTFULLOPEN</b></dt> <dt>0x00000004</dt> </dl> </td> <td
    ///width="60%"> Disables the <b>Define Custom Color</b> button. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_RGBINIT"></a><a id="cc_rgbinit"></a><dl> <dt><b>CC_RGBINIT</b></dt> <dt>0x00000001</dt> </dl> </td> <td
    ///width="60%"> Causes the dialog box to use the color specified in the <b>rgbResult</b> member as the initial color
    ///selection. </td> </tr> <tr> <td width="40%"><a id="CC_SHOWHELP"></a><a id="cc_showhelp"></a><dl>
    ///<dt><b>CC_SHOWHELP</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Causes the dialog box to display the
    ///Help button. The <b>hwndOwner</b> member must specify the window to receive the HELPMSGSTRING registered messages
    ///that the dialog box sends when the user clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a
    ///id="CC_SOLIDCOLOR"></a><a id="cc_solidcolor"></a><dl> <dt><b>CC_SOLIDCOLOR</b></dt> <dt>0x00000080</dt> </dl>
    ///</td> <td width="60%"> Causes the dialog box to display only solid colors in the set of basic colors. </td> </tr>
    ///</table>
    uint         Flags;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the <b>CHOOSECOLOR</b> structure specified when the dialog was created.
    ///The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM       lCustData;
    ///Type: <b>LPCCHOOKPROC</b> A pointer to a CCHookProc hook procedure that can process messages intended for the
    ///dialog box. This member is ignored unless the <b>CC_ENABLEHOOK</b> flag is set in the <b>Flags</b> member.
    LPCCHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, <b>lpTemplateName</b> can be a value returned by the MAKEINTRESOURCE macro. This member is ignored
    ///unless the <b>CC_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PWSTR) lpTemplateName;
}

///Contains information that the FindText and ReplaceText functions use to initialize the <b>Find</b> and <b>Replace</b>
///dialog boxes. The FINDMSGSTRING registered message uses this structure to pass the user's search or replacement input
///to the owner window of a <b>Find</b> or <b>Replace</b> dialog box.
struct FINDREPLACEA
{
align (1):
    ///Type: <b>DWORD</b> The length, in bytes, of the structure.
    uint         lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. The window procedure of the specified window
    ///receives FINDMSGSTRING messages from the dialog box. This member can be any valid window handle, but it must not
    ///be <b>NULL</b>.
    HWND         hwndOwner;
    ///Type: <b>HINSTANCE</b> If the <b>FR_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b>, <b>hInstance</b> is
    ///a handle to a memory object containing a dialog box template. If the <b>FR_ENABLETEMPLATE</b> flag is set,
    ///<b>hInstance</b> is a handle to a module that contains a dialog box template named by the <b>lpTemplateName</b>
    ///member. If neither flag is set, this member is ignored.
    HINSTANCE    hInstance;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the dialog box. The dialog box sets these
    ///flags when it sends the FINDMSGSTRING registered message to indicate the user's input. This member can be one or
    ///more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FR_DIALOGTERM"></a><a id="fr_dialogterm"></a><dl> <dt><b>FR_DIALOGTERM</b></dt> <dt>0x00000040</dt> </dl>
    ///</td> <td width="60%"> If set in a FINDMSGSTRING message, indicates that the dialog box is closing. When you
    ///receive a message with this flag set, the dialog box handle returned by the FindText or ReplaceText function is
    ///no longer valid. </td> </tr> <tr> <td width="40%"><a id="FR_DOWN"></a><a id="fr_down"></a><dl>
    ///<dt><b>FR_DOWN</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> If set, the <b>Down</b> button of the
    ///direction radio buttons in a <b>Find</b> dialog box is selected indicating that you should search from the
    ///current location to the end of the document. If not set, the <b>Up</b> button is selected so you should search to
    ///the beginning of the document. You can set this flag to initialize the dialog box. If set in a FINDMSGSTRING
    ///message, indicates the user's selection. </td> </tr> <tr> <td width="40%"><a id="FR_ENABLEHOOK"></a><a
    ///id="fr_enablehook"></a><dl> <dt><b>FR_ENABLEHOOK</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%">
    ///Enables the hook function specified in the <b>lpfnHook</b> member. This flag is used only to initialize the
    ///dialog box. </td> </tr> <tr> <td width="40%"><a id="FR_ENABLETEMPLATE"></a><a id="fr_enabletemplate"></a><dl>
    ///<dt><b>FR_ENABLETEMPLATE</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hInstance</b> and <b>lpTemplateName</b> members specify a dialog box template to use in place of the default
    ///template. This flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_ENABLETEMPLATEHANDLE"></a><a id="fr_enabletemplatehandle"></a><dl> <dt><b>FR_ENABLETEMPLATEHANDLE</b></dt>
    ///<dt>0x00002000</dt> </dl> </td> <td width="60%"> Indicates that the <b>hInstance</b> member identifies a data
    ///block that contains a preloaded dialog box template. The system ignores the <b>lpTemplateName</b> member if this
    ///flag is specified. </td> </tr> <tr> <td width="40%"><a id="FR_FINDNEXT"></a><a id="fr_findnext"></a><dl>
    ///<dt><b>FR_FINDNEXT</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> If set in a FINDMSGSTRING message,
    ///indicates that the user clicked the <b>Find Next</b> button in a <b>Find</b> or <b>Replace</b> dialog box. The
    ///<b>lpstrFindWhat</b> member specifies the string to search for. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_HIDEUPDOWN"></a><a id="fr_hideupdown"></a><dl> <dt><b>FR_HIDEUPDOWN</b></dt> <dt>0x00004000</dt> </dl>
    ///</td> <td width="60%"> If set when initializing a <b>Find</b> dialog box, hides the search direction radio
    ///buttons. </td> </tr> <tr> <td width="40%"><a id="FR_HIDEMATCHCASE"></a><a id="fr_hidematchcase"></a><dl>
    ///<dt><b>FR_HIDEMATCHCASE</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> If set when initializing a
    ///<b>Find</b> or <b>Replace</b> dialog box, hides the <b>Match Case</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_HIDEWHOLEWORD"></a><a id="fr_hidewholeword"></a><dl> <dt><b>FR_HIDEWHOLEWORD</b></dt>
    ///<dt>0x00010000</dt> </dl> </td> <td width="60%"> If set when initializing a <b>Find</b> or <b>Replace</b> dialog
    ///box, hides the <b>Match Whole Word Only</b> check box. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_MATCHCASE"></a><a id="fr_matchcase"></a><dl> <dt><b>FR_MATCHCASE</b></dt> <dt>0x00000004</dt> </dl> </td>
    ///<td width="60%"> If set, the <b>Match Case</b> check box is selected indicating that the search should be
    ///case-sensitive. If not set, the check box is unselected so the search should be case-insensitive. You can set
    ///this flag to initialize the dialog box. If set in a FINDMSGSTRING message, indicates the user's selection. </td>
    ///</tr> <tr> <td width="40%"><a id="FR_NOMATCHCASE"></a><a id="fr_nomatchcase"></a><dl>
    ///<dt><b>FR_NOMATCHCASE</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> If set when initializing a
    ///<b>Find</b> or <b>Replace</b> dialog box, disables the <b>Match Case</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_NOUPDOWN"></a><a id="fr_noupdown"></a><dl> <dt><b>FR_NOUPDOWN</b></dt> <dt>0x00000400</dt>
    ///</dl> </td> <td width="60%"> If set when initializing a <b>Find</b> dialog box, disables the search direction
    ///radio buttons. </td> </tr> <tr> <td width="40%"><a id="FR_NOWHOLEWORD"></a><a id="fr_nowholeword"></a><dl>
    ///<dt><b>FR_NOWHOLEWORD</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> If set when initializing a
    ///<b>Find</b> or <b>Replace</b> dialog box, disables the <b>Whole Word</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_REPLACE"></a><a id="fr_replace"></a><dl> <dt><b>FR_REPLACE</b></dt> <dt>0x00000010</dt>
    ///</dl> </td> <td width="60%"> If set in a FINDMSGSTRING message, indicates that the user clicked the
    ///<b>Replace</b> button in a <b>Replace</b> dialog box. The <b>lpstrFindWhat</b> member specifies the string to be
    ///replaced and the <b>lpstrReplaceWith</b> member specifies the replacement string. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_REPLACEALL"></a><a id="fr_replaceall"></a><dl> <dt><b>FR_REPLACEALL</b></dt>
    ///<dt>0x00000020</dt> </dl> </td> <td width="60%"> If set in a FINDMSGSTRING message, indicates that the user
    ///clicked the <b>Replace All</b> button in a <b>Replace</b> dialog box. The <b>lpstrFindWhat</b> member specifies
    ///the string to be replaced and the <b>lpstrReplaceWith</b> member specifies the replacement string. </td> </tr>
    ///<tr> <td width="40%"><a id="FR_SHOWHELP"></a><a id="fr_showhelp"></a><dl> <dt><b>FR_SHOWHELP</b></dt>
    ///<dt>0x00000080</dt> </dl> </td> <td width="60%"> Causes the dialog box to display the <b>Help</b> button. The
    ///<b>hwndOwner</b> member must specify the window to receive the HELPMSGSTRING registered messages that the dialog
    ///box sends when the user clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_WHOLEWORD"></a><a id="fr_wholeword"></a><dl> <dt><b>FR_WHOLEWORD</b></dt> <dt>0x00000002</dt> </dl> </td>
    ///<td width="60%"> If set, the <b>Match Whole Word Only</b> check box is selected indicating that you should search
    ///only for whole words that match the search string. If not set, the check box is unselected so you should also
    ///search for word fragments that match the search string. You can set this flag to initialize the dialog box. If
    ///set in a FINDMSGSTRING message, indicates the user's selection. </td> </tr> </table>
    uint         Flags;
    ///Type: <b>LPTSTR</b> The search string that the user typed in the <b>Find What</b> edit control. You must
    ///dynamically allocate the buffer or use a global or static array so it does not go out of scope before the dialog
    ///box closes. The buffer should be at least 80 characters long. If the buffer contains a string when you initialize
    ///the dialog box, the string is displayed in the <b>Find What</b> edit control. If a FINDMSGSTRING message
    ///specifies the <b>FR_FINDNEXT</b> flag, <b>lpstrFindWhat</b> contains the string to search for. The
    ///<b>FR_DOWN</b>, <b>FR_WHOLEWORD</b>, and <b>FR_MATCHCASE</b> flags indicate the direction and type of search. If
    ///a <b>FINDMSGSTRING</b> message specifies the <b>FR_REPLACE</b> or <b>FR_REPLACE</b> flags, <b>lpstrFindWhat</b>
    ///contains the string to be replaced.
    PSTR         lpstrFindWhat;
    ///Type: <b>LPTSTR</b> The replacement string that the user typed in the <b>Replace With</b> edit control. You must
    ///dynamically allocate the buffer or use a global or static array so it does not go out of scope before the dialog
    ///box closes. If the buffer contains a string when you initialize the dialog box, the string is displayed in the
    ///<b>Replace With</b> edit control. If a FINDMSGSTRING message specifies the <b>FR_REPLACE</b> or
    ///<b>FR_REPLACEALL</b> flags, <b>lpstrReplaceWith</b> contains the replacement string . The FindText function
    ///ignores this member.
    PSTR         lpstrReplaceWith;
    ///Type: <b>WORD</b> The length, in bytes, of the buffer pointed to by the <b>lpstrFindWhat</b> member.
    ushort       wFindWhatLen;
    ///Type: <b>WORD</b> The length, in bytes, of the buffer pointed to by the <b>lpstrReplaceWith</b> member.
    ushort       wReplaceWithLen;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the <b>FINDREPLACE</b> structure specified when the dialog was created.
    ///The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM       lCustData;
    ///Type: <b>LPFRHOOKPROC</b> A pointer to an FRHookProc hook procedure that can process messages intended for the
    ///dialog box. This member is ignored unless the <b>FR_ENABLEHOOK</b> flag is set in the <b>Flags</b> member. If the
    ///hook procedure returns <b>FALSE</b> in response to the WM_INITDIALOG message, the hook procedure must display the
    ///dialog box or else the dialog box will not be shown. To do this, first perform any other paint operations, and
    ///then call the ShowWindow and UpdateWindow functions.
    LPFRHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, this can be a value returned by the MAKEINTRESOURCE macro. This member is ignored unless the
    ///<b>FR_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PSTR)  lpTemplateName;
}

///Contains information that the FindText and ReplaceText functions use to initialize the <b>Find</b> and <b>Replace</b>
///dialog boxes. The FINDMSGSTRING registered message uses this structure to pass the user's search or replacement input
///to the owner window of a <b>Find</b> or <b>Replace</b> dialog box.
struct FINDREPLACEW
{
align (1):
    ///Type: <b>DWORD</b> The length, in bytes, of the structure.
    uint         lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. The window procedure of the specified window
    ///receives FINDMSGSTRING messages from the dialog box. This member can be any valid window handle, but it must not
    ///be <b>NULL</b>.
    HWND         hwndOwner;
    ///Type: <b>HINSTANCE</b> If the <b>FR_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b>, <b>hInstance</b> is
    ///a handle to a memory object containing a dialog box template. If the <b>FR_ENABLETEMPLATE</b> flag is set,
    ///<b>hInstance</b> is a handle to a module that contains a dialog box template named by the <b>lpTemplateName</b>
    ///member. If neither flag is set, this member is ignored.
    HINSTANCE    hInstance;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the dialog box. The dialog box sets these
    ///flags when it sends the FINDMSGSTRING registered message to indicate the user's input. This member can be one or
    ///more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FR_DIALOGTERM"></a><a id="fr_dialogterm"></a><dl> <dt><b>FR_DIALOGTERM</b></dt> <dt>0x00000040</dt> </dl>
    ///</td> <td width="60%"> If set in a FINDMSGSTRING message, indicates that the dialog box is closing. When you
    ///receive a message with this flag set, the dialog box handle returned by the FindText or ReplaceText function is
    ///no longer valid. </td> </tr> <tr> <td width="40%"><a id="FR_DOWN"></a><a id="fr_down"></a><dl>
    ///<dt><b>FR_DOWN</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> If set, the <b>Down</b> button of the
    ///direction radio buttons in a <b>Find</b> dialog box is selected indicating that you should search from the
    ///current location to the end of the document. If not set, the <b>Up</b> button is selected so you should search to
    ///the beginning of the document. You can set this flag to initialize the dialog box. If set in a FINDMSGSTRING
    ///message, indicates the user's selection. </td> </tr> <tr> <td width="40%"><a id="FR_ENABLEHOOK"></a><a
    ///id="fr_enablehook"></a><dl> <dt><b>FR_ENABLEHOOK</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%">
    ///Enables the hook function specified in the <b>lpfnHook</b> member. This flag is used only to initialize the
    ///dialog box. </td> </tr> <tr> <td width="40%"><a id="FR_ENABLETEMPLATE"></a><a id="fr_enabletemplate"></a><dl>
    ///<dt><b>FR_ENABLETEMPLATE</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hInstance</b> and <b>lpTemplateName</b> members specify a dialog box template to use in place of the default
    ///template. This flag is used only to initialize the dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_ENABLETEMPLATEHANDLE"></a><a id="fr_enabletemplatehandle"></a><dl> <dt><b>FR_ENABLETEMPLATEHANDLE</b></dt>
    ///<dt>0x00002000</dt> </dl> </td> <td width="60%"> Indicates that the <b>hInstance</b> member identifies a data
    ///block that contains a preloaded dialog box template. The system ignores the <b>lpTemplateName</b> member if this
    ///flag is specified. </td> </tr> <tr> <td width="40%"><a id="FR_FINDNEXT"></a><a id="fr_findnext"></a><dl>
    ///<dt><b>FR_FINDNEXT</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> If set in a FINDMSGSTRING message,
    ///indicates that the user clicked the <b>Find Next</b> button in a <b>Find</b> or <b>Replace</b> dialog box. The
    ///<b>lpstrFindWhat</b> member specifies the string to search for. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_HIDEUPDOWN"></a><a id="fr_hideupdown"></a><dl> <dt><b>FR_HIDEUPDOWN</b></dt> <dt>0x00004000</dt> </dl>
    ///</td> <td width="60%"> If set when initializing a <b>Find</b> dialog box, hides the search direction radio
    ///buttons. </td> </tr> <tr> <td width="40%"><a id="FR_HIDEMATCHCASE"></a><a id="fr_hidematchcase"></a><dl>
    ///<dt><b>FR_HIDEMATCHCASE</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> If set when initializing a
    ///<b>Find</b> or <b>Replace</b> dialog box, hides the <b>Match Case</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_HIDEWHOLEWORD"></a><a id="fr_hidewholeword"></a><dl> <dt><b>FR_HIDEWHOLEWORD</b></dt>
    ///<dt>0x00010000</dt> </dl> </td> <td width="60%"> If set when initializing a <b>Find</b> or <b>Replace</b> dialog
    ///box, hides the <b>Match Whole Word Only</b> check box. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_MATCHCASE"></a><a id="fr_matchcase"></a><dl> <dt><b>FR_MATCHCASE</b></dt> <dt>0x00000004</dt> </dl> </td>
    ///<td width="60%"> If set, the <b>Match Case</b> check box is selected indicating that the search should be
    ///case-sensitive. If not set, the check box is unselected so the search should be case-insensitive. You can set
    ///this flag to initialize the dialog box. If set in a FINDMSGSTRING message, indicates the user's selection. </td>
    ///</tr> <tr> <td width="40%"><a id="FR_NOMATCHCASE"></a><a id="fr_nomatchcase"></a><dl>
    ///<dt><b>FR_NOMATCHCASE</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> If set when initializing a
    ///<b>Find</b> or <b>Replace</b> dialog box, disables the <b>Match Case</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_NOUPDOWN"></a><a id="fr_noupdown"></a><dl> <dt><b>FR_NOUPDOWN</b></dt> <dt>0x00000400</dt>
    ///</dl> </td> <td width="60%"> If set when initializing a <b>Find</b> dialog box, disables the search direction
    ///radio buttons. </td> </tr> <tr> <td width="40%"><a id="FR_NOWHOLEWORD"></a><a id="fr_nowholeword"></a><dl>
    ///<dt><b>FR_NOWHOLEWORD</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> If set when initializing a
    ///<b>Find</b> or <b>Replace</b> dialog box, disables the <b>Whole Word</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_REPLACE"></a><a id="fr_replace"></a><dl> <dt><b>FR_REPLACE</b></dt> <dt>0x00000010</dt>
    ///</dl> </td> <td width="60%"> If set in a FINDMSGSTRING message, indicates that the user clicked the
    ///<b>Replace</b> button in a <b>Replace</b> dialog box. The <b>lpstrFindWhat</b> member specifies the string to be
    ///replaced and the <b>lpstrReplaceWith</b> member specifies the replacement string. </td> </tr> <tr> <td
    ///width="40%"><a id="FR_REPLACEALL"></a><a id="fr_replaceall"></a><dl> <dt><b>FR_REPLACEALL</b></dt>
    ///<dt>0x00000020</dt> </dl> </td> <td width="60%"> If set in a FINDMSGSTRING message, indicates that the user
    ///clicked the <b>Replace All</b> button in a <b>Replace</b> dialog box. The <b>lpstrFindWhat</b> member specifies
    ///the string to be replaced and the <b>lpstrReplaceWith</b> member specifies the replacement string. </td> </tr>
    ///<tr> <td width="40%"><a id="FR_SHOWHELP"></a><a id="fr_showhelp"></a><dl> <dt><b>FR_SHOWHELP</b></dt>
    ///<dt>0x00000080</dt> </dl> </td> <td width="60%"> Causes the dialog box to display the <b>Help</b> button. The
    ///<b>hwndOwner</b> member must specify the window to receive the HELPMSGSTRING registered messages that the dialog
    ///box sends when the user clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a
    ///id="FR_WHOLEWORD"></a><a id="fr_wholeword"></a><dl> <dt><b>FR_WHOLEWORD</b></dt> <dt>0x00000002</dt> </dl> </td>
    ///<td width="60%"> If set, the <b>Match Whole Word Only</b> check box is selected indicating that you should search
    ///only for whole words that match the search string. If not set, the check box is unselected so you should also
    ///search for word fragments that match the search string. You can set this flag to initialize the dialog box. If
    ///set in a FINDMSGSTRING message, indicates the user's selection. </td> </tr> </table>
    uint         Flags;
    ///Type: <b>LPTSTR</b> The search string that the user typed in the <b>Find What</b> edit control. You must
    ///dynamically allocate the buffer or use a global or static array so it does not go out of scope before the dialog
    ///box closes. The buffer should be at least 80 characters long. If the buffer contains a string when you initialize
    ///the dialog box, the string is displayed in the <b>Find What</b> edit control. If a FINDMSGSTRING message
    ///specifies the <b>FR_FINDNEXT</b> flag, <b>lpstrFindWhat</b> contains the string to search for. The
    ///<b>FR_DOWN</b>, <b>FR_WHOLEWORD</b>, and <b>FR_MATCHCASE</b> flags indicate the direction and type of search. If
    ///a <b>FINDMSGSTRING</b> message specifies the <b>FR_REPLACE</b> or <b>FR_REPLACE</b> flags, <b>lpstrFindWhat</b>
    ///contains the string to be replaced.
    PWSTR        lpstrFindWhat;
    ///Type: <b>LPTSTR</b> The replacement string that the user typed in the <b>Replace With</b> edit control. You must
    ///dynamically allocate the buffer or use a global or static array so it does not go out of scope before the dialog
    ///box closes. If the buffer contains a string when you initialize the dialog box, the string is displayed in the
    ///<b>Replace With</b> edit control. If a FINDMSGSTRING message specifies the <b>FR_REPLACE</b> or
    ///<b>FR_REPLACEALL</b> flags, <b>lpstrReplaceWith</b> contains the replacement string . The FindText function
    ///ignores this member.
    PWSTR        lpstrReplaceWith;
    ///Type: <b>WORD</b> The length, in bytes, of the buffer pointed to by the <b>lpstrFindWhat</b> member.
    ushort       wFindWhatLen;
    ///Type: <b>WORD</b> The length, in bytes, of the buffer pointed to by the <b>lpstrReplaceWith</b> member.
    ushort       wReplaceWithLen;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the <b>FINDREPLACE</b> structure specified when the dialog was created.
    ///The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM       lCustData;
    ///Type: <b>LPFRHOOKPROC</b> A pointer to an FRHookProc hook procedure that can process messages intended for the
    ///dialog box. This member is ignored unless the <b>FR_ENABLEHOOK</b> flag is set in the <b>Flags</b> member. If the
    ///hook procedure returns <b>FALSE</b> in response to the WM_INITDIALOG message, the hook procedure must display the
    ///dialog box or else the dialog box will not be shown. To do this, first perform any other paint operations, and
    ///then call the ShowWindow and UpdateWindow functions.
    LPFRHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, this can be a value returned by the MAKEINTRESOURCE macro. This member is ignored unless the
    ///<b>FR_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PWSTR) lpTemplateName;
}

///Contains information that the ChooseFont function uses to initialize the <b>Font</b> dialog box. After the user
///closes the dialog box, the system returns information about the user's selection in this structure.
struct CHOOSEFONTA
{
align (1):
    ///Type: <b>DWORD</b> The length of the structure, in bytes.
    uint         lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND         hwndOwner;
    ///Type: <b>HDC</b> This member is ignored by the ChooseFont function. <b>Windows Vista and Windows XP/2000: </b>A
    ///handle to the device context or information context of the printer whose fonts will be listed in the dialog box.
    ///This member is used only if the <b>Flags</b> member specifies the <b>CF_PRINTERFONTS</b> or <b>CF_BOTH</b> flag;
    ///otherwise, this member is ignored.
    HDC          hDC;
    ///Type: <b>LPLOGFONT</b> A pointer to a LOGFONT structure. If you set the <b>CF_INITTOLOGFONTSTRUCT</b> flag in the
    ///<b>Flags</b> member and initialize the other members, the ChooseFont function initializes the dialog box with a
    ///font that matches the <b>LOGFONT</b> members. If the user clicks the <b>OK</b> button, <b>ChooseFont</b> sets the
    ///members of the <b>LOGFONT</b> structure based on the user's selections.
    LOGFONTA*    lpLogFont;
    ///Type: <b>INT</b> The size of the selected font, in units of 1/10 of a point. The ChooseFont function sets this
    ///value after the user closes the dialog box.
    int          iPointSize;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Font</b> dialog box. When the dialog
    ///box returns, it sets these flags to indicate the user input. This member can be one or more of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CF_APPLY"></a><a
    ///id="cf_apply"></a><dl> <dt><b>CF_APPLY</b></dt> <dt>0x00000200L</dt> </dl> </td> <td width="60%"> Causes the
    ///dialog box to display the <b>Apply</b> button. You should provide a hook procedure to process WM_COMMAND messages
    ///for the <b>Apply</b> button. The hook procedure can send the WM_CHOOSEFONT_GETLOGFONT message to the dialog box
    ///to retrieve the address of the structure that contains the current selections for the font. </td> </tr> <tr> <td
    ///width="40%"><a id="CF_ANSIONLY"></a><a id="cf_ansionly"></a><dl> <dt><b>CF_ANSIONLY</b></dt> <dt>0x00000400L</dt>
    ///</dl> </td> <td width="60%"> This flag is obsolete. To limit font selections to all scripts except those that use
    ///the OEM or Symbol character sets, use <b>CF_SCRIPTSONLY</b>. To get the original <b>CF_ANSIONLY</b> behavior, use
    ///<b>CF_SELECTSCRIPT</b> and specify <b>ANSI_CHARSET</b> in the <b>lfCharSet</b> member of the LOGFONT structure
    ///pointed to by <b>lpLogFont</b>. </td> </tr> <tr> <td width="40%"><a id="CF_BOTH"></a><a id="cf_both"></a><dl>
    ///<dt><b>CF_BOTH</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> This flag is ignored for font
    ///enumeration. <b>Windows Vista and Windows XP/2000: </b>Causes the dialog box to list the available printer and
    ///screen fonts. The <b>hDC</b> member is a handle to the device context or information context associated with the
    ///printer. This flag is a combination of the <b>CF_SCREENFONTS</b> and <b>CF_PRINTERFONTS</b> flags. </td> </tr>
    ///<tr> <td width="40%"><a id="CF_EFFECTS"></a><a id="cf_effects"></a><dl> <dt><b>CF_EFFECTS</b></dt>
    ///<dt>0x00000100L</dt> </dl> </td> <td width="60%"> Causes the dialog box to display the controls that allow the
    ///user to specify strikeout, underline, and text color options. If this flag is set, you can use the
    ///<b>rgbColors</b> member to specify the initial text color. You can use the <b>lfStrikeOut</b> and
    ///<b>lfUnderline</b> members of the structure pointed to by <b>lpLogFont</b> to specify the initial settings of the
    ///strikeout and underline check boxes. ChooseFont can use these members to return the user's selections. </td>
    ///</tr> <tr> <td width="40%"><a id="CF_ENABLEHOOK"></a><a id="cf_enablehook"></a><dl> <dt><b>CF_ENABLEHOOK</b></dt>
    ///<dt>0x00000008L</dt> </dl> </td> <td width="60%"> Enables the hook procedure specified in the <b>lpfnHook</b>
    ///member of this structure. </td> </tr> <tr> <td width="40%"><a id="CF_ENABLETEMPLATE"></a><a
    ///id="cf_enabletemplate"></a><dl> <dt><b>CF_ENABLETEMPLATE</b></dt> <dt>0x00000010L</dt> </dl> </td> <td
    ///width="60%"> Indicates that the <b>hInstance</b> and <b>lpTemplateName</b> members specify a dialog box template
    ///to use in place of the default template. </td> </tr> <tr> <td width="40%"><a id="CF_ENABLETEMPLATEHANDLE"></a><a
    ///id="cf_enabletemplatehandle"></a><dl> <dt><b>CF_ENABLETEMPLATEHANDLE</b></dt> <dt>0x00000020L</dt> </dl> </td>
    ///<td width="60%"> Indicates that the <b>hInstance</b> member identifies a data block that contains a preloaded
    ///dialog box template. The system ignores the <b>lpTemplateName</b> member if this flag is specified. </td> </tr>
    ///<tr> <td width="40%"><a id="CF_FIXEDPITCHONLY"></a><a id="cf_fixedpitchonly"></a><dl>
    ///<dt><b>CF_FIXEDPITCHONLY</b></dt> <dt>0x00004000L</dt> </dl> </td> <td width="60%"> ChooseFont should enumerate
    ///and allow selection of only fixed-pitch fonts. </td> </tr> <tr> <td width="40%"><a id="CF_FORCEFONTEXIST"></a><a
    ///id="cf_forcefontexist"></a><dl> <dt><b>CF_FORCEFONTEXIST</b></dt> <dt>0x00010000L</dt> </dl> </td> <td
    ///width="60%"> ChooseFont should indicate an error condition if the user attempts to select a font or style that is
    ///not listed in the dialog box. </td> </tr> <tr> <td width="40%"><a id="CF_INACTIVEFONTS"></a><a
    ///id="cf_inactivefonts"></a><dl> <dt><b>CF_INACTIVEFONTS</b></dt> <dt>0x02000000L</dt> </dl> </td> <td width="60%">
    ///ChooseFont should additionally display fonts that are set to Hide in Fonts Control Panel. <b>Windows Vista and
    ///Windows XP/2000: </b>This flag is not supported until Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_INITTOLOGFONTSTRUCT"></a><a id="cf_inittologfontstruct"></a><dl> <dt><b>CF_INITTOLOGFONTSTRUCT</b></dt>
    ///<dt>0x00000040L</dt> </dl> </td> <td width="60%"> ChooseFont should use the structure pointed to by the
    ///<b>lpLogFont</b> member to initialize the dialog box controls. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_LIMITSIZE"></a><a id="cf_limitsize"></a><dl> <dt><b>CF_LIMITSIZE</b></dt> <dt>0x00002000L</dt> </dl> </td>
    ///<td width="60%"> ChooseFont should select only font sizes within the range specified by the <b>nSizeMin</b> and
    ///<b>nSizeMax</b> members. </td> </tr> <tr> <td width="40%"><a id="CF_NOOEMFONTS"></a><a
    ///id="cf_nooemfonts"></a><dl> <dt><b>CF_NOOEMFONTS</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%"> Same
    ///as the <b>CF_NOVECTORFONTS</b> flag. </td> </tr> <tr> <td width="40%"><a id="CF_NOFACESEL"></a><a
    ///id="cf_nofacesel"></a><dl> <dt><b>CF_NOFACESEL</b></dt> <dt>0x00080000L</dt> </dl> </td> <td width="60%"> When
    ///using a LOGFONT structure to initialize the dialog box controls, use this flag to prevent the dialog box from
    ///displaying an initial selection for the font name combo box. This is useful when there is no single font name
    ///that applies to the text selection. </td> </tr> <tr> <td width="40%"><a id="CF_NOSCRIPTSEL"></a><a
    ///id="cf_noscriptsel"></a><dl> <dt><b>CF_NOSCRIPTSEL</b></dt> <dt>0x00800000L</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Script</b> combo box. When this flag is set, the <b>lfCharSet</b> member of the LOGFONT structure
    ///is set to <b>DEFAULT_CHARSET</b> when ChooseFont returns. This flag is used only to initialize the dialog box.
    ///</td> </tr> <tr> <td width="40%"><a id="CF_NOSIMULATIONS"></a><a id="cf_nosimulations"></a><dl>
    ///<dt><b>CF_NOSIMULATIONS</b></dt> <dt>0x00001000L</dt> </dl> </td> <td width="60%"> ChooseFont should not display
    ///or allow selection of font simulations. </td> </tr> <tr> <td width="40%"><a id="CF_NOSIZESEL"></a><a
    ///id="cf_nosizesel"></a><dl> <dt><b>CF_NOSIZESEL</b></dt> <dt>0x00200000L</dt> </dl> </td> <td width="60%"> When
    ///using a structure to initialize the dialog box controls, use this flag to prevent the dialog box from displaying
    ///an initial selection for the <b>Font Size</b> combo box. This is useful when there is no single font size that
    ///applies to the text selection. </td> </tr> <tr> <td width="40%"><a id="CF_NOSTYLESEL"></a><a
    ///id="cf_nostylesel"></a><dl> <dt><b>CF_NOSTYLESEL</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> When
    ///using a LOGFONT structure to initialize the dialog box controls, use this flag to prevent the dialog box from
    ///displaying an initial selection for the <b>Font Style</b> combo box. This is useful when there is no single font
    ///style that applies to the text selection. </td> </tr> <tr> <td width="40%"><a id="CF_NOVECTORFONTS"></a><a
    ///id="cf_novectorfonts"></a><dl> <dt><b>CF_NOVECTORFONTS</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%">
    ///ChooseFont should not allow vector font selections. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_NOVERTFONTS"></a><a id="cf_novertfonts"></a><dl> <dt><b>CF_NOVERTFONTS</b></dt> <dt>0x01000000L</dt> </dl>
    ///</td> <td width="60%"> Causes the <b>Font</b> dialog box to list only horizontally oriented fonts. </td> </tr>
    ///<tr> <td width="40%"><a id="CF_PRINTERFONTS"></a><a id="cf_printerfonts"></a><dl> <dt><b>CF_PRINTERFONTS</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> This flag is ignored for font enumeration. <b>Windows Vista and
    ///Windows XP/2000: </b>Causes the dialog box to list only the fonts supported by the printer associated with the
    ///device context or information context identified by the <b>hDC</b> member. It also causes the font type
    ///description label to appear at the bottom of the <b>Font</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_SCALABLEONLY"></a><a id="cf_scalableonly"></a><dl> <dt><b>CF_SCALABLEONLY</b></dt> <dt>0x00020000L</dt>
    ///</dl> </td> <td width="60%"> Specifies that ChooseFont should allow only the selection of scalable fonts.
    ///Scalable fonts include vector fonts, scalable printer fonts, TrueType fonts, and fonts scaled by other
    ///technologies. </td> </tr> <tr> <td width="40%"><a id="CF_SCREENFONTS"></a><a id="cf_screenfonts"></a><dl>
    ///<dt><b>CF_SCREENFONTS</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> This flag is ignored for font
    ///enumeration. <b>Windows Vista and Windows XP/2000: </b>Causes the dialog box to list only the screen fonts
    ///supported by the system. </td> </tr> <tr> <td width="40%"><a id="CF_SCRIPTSONLY"></a><a
    ///id="cf_scriptsonly"></a><dl> <dt><b>CF_SCRIPTSONLY</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%">
    ///ChooseFont should allow selection of fonts for all non-OEM and Symbol character sets, as well as the ANSI
    ///character set. This supersedes the <b>CF_ANSIONLY</b> value. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_SELECTSCRIPT"></a><a id="cf_selectscript"></a><dl> <dt><b>CF_SELECTSCRIPT</b></dt> <dt>0x00400000L</dt>
    ///</dl> </td> <td width="60%"> When specified on input, only fonts with the character set identified in the
    ///<b>lfCharSet</b> member of the LOGFONT structure are displayed. The user will not be allowed to change the
    ///character set specified in the <b>Scripts</b> combo box. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_SHOWHELP"></a><a id="cf_showhelp"></a><dl> <dt><b>CF_SHOWHELP</b></dt> <dt>0x00000004L</dt> </dl> </td>
    ///<td width="60%"> Causes the dialog box to display the <b>Help</b> button. The <b>hwndOwner</b> member must
    ///specify the window to receive the HELPMSGSTRING registered messages that the dialog box sends when the user
    ///clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a id="CF_TTONLY"></a><a id="cf_ttonly"></a><dl>
    ///<dt><b>CF_TTONLY</b></dt> <dt>0x00040000L</dt> </dl> </td> <td width="60%"> ChooseFont should only enumerate and
    ///allow the selection of TrueType fonts. </td> </tr> <tr> <td width="40%"><a id="CF_USESTYLE"></a><a
    ///id="cf_usestyle"></a><dl> <dt><b>CF_USESTYLE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td width="60%"> The
    ///<b>lpszStyle</b> member is a pointer to a buffer that contains style data that ChooseFont should use to
    ///initialize the <b>Font Style</b> combo box. When the user closes the dialog box, <b>ChooseFont</b> copies style
    ///data for the user's selection to this buffer. <div class="alert"><b>Note</b> To globalize your application, you
    ///should specify the style by using the <b>lfWeight</b> and <b>lfItalic</b> members of the LOGFONT structure
    ///pointed to by <b>lpLogFont</b>. The style name may change depending on the system user interface language.</div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="CF_WYSIWYG"></a><a id="cf_wysiwyg"></a><dl>
    ///<dt><b>CF_WYSIWYG</b></dt> <dt>0x00008000L</dt> </dl> </td> <td width="60%"> Obsolete. ChooseFont ignores this
    ///flag. <b>Windows Vista and Windows XP/2000: </b>ChooseFont should allow only the selection of fonts available on
    ///both the printer and the display. If this flag is specified, the <b>CF_SCREENSHOTS</b> and
    ///<b>CF_PRINTERFONTS</b>, or <b>CF_BOTH</b> flags should also be specified. </td> </tr> </table>
    uint         Flags;
    ///Type: <b>COLORREF</b> If the <b>CF_EFFECTS</b> flag is set, <b>rgbColors</b> specifies the initial text color.
    ///When ChooseFont returns successfully, this member contains the RGB value of the text color that the user
    ///selected. To create a COLORREF color value, use the RGB macro.
    uint         rgbColors;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the CHOOSEFONT structure specified when the dialog was created. The hook
    ///procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM       lCustData;
    ///Type: <b>LPCFHOOKPROC</b> A pointer to a CFHookProc hook procedure that can process messages intended for the
    ///dialog box. This member is ignored unless the <b>CF_ENABLEHOOK</b> flag is set in the <b>Flags</b> member.
    LPCFHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, <b>lpTemplateName</b> can be a value returned by the MAKEINTRESOURCE macro. This member is ignored
    ///unless the <b>CF_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PSTR)  lpTemplateName;
    ///Type: <b>HINSTANCE</b> If the <b>CF_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to a memory object containing a dialog box template. If the <b>CF_ENABLETEMPLATE</b>
    ///flag is set, <b>hInstance</b> is a handle to a module that contains a dialog box template named by the
    ///<b>lpTemplateName</b> member. If neither <b>CF_ENABLETEMPLATEHANDLE</b> nor <b>CF_ENABLETEMPLATE</b> is set, this
    ///member is ignored.
    HINSTANCE    hInstance;
    ///Type: <b>LPTSTR</b> The style data. If the <b>CF_USESTYLE</b> flag is specified, ChooseFont uses the data in this
    ///buffer to initialize the <b>Font Style</b> combo box. When the user closes the dialog box, <b>ChooseFont</b>
    ///copies the string in the <b>Font Style</b> combo box into this buffer.
    PSTR         lpszStyle;
    ///Type: <b>WORD</b> The type of the selected font when ChooseFont returns. This member can be one or more of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="BOLD_FONTTYPE"></a><a id="bold_fonttype"></a><dl> <dt><b>BOLD_FONTTYPE</b></dt> <dt>0x0100</dt> </dl> </td>
    ///<td width="60%"> The font weight is bold. This information is duplicated in the <b>lfWeight</b> member of the
    ///LOGFONT structure and is equivalent to <b>FW_BOLD</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="ITALIC_FONTTYPE"></a><a id="italic_fonttype"></a><dl> <dt><b>ITALIC_FONTTYPE</b></dt> <dt>0x0200</dt> </dl>
    ///</td> <td width="60%"> The italic font attribute is set. This information is duplicated in the <b>lfItalic</b>
    ///member of the LOGFONT structure. </td> </tr> <tr> <td width="40%"><a id="PRINTER_FONTTYPE"></a><a
    ///id="printer_fonttype"></a><dl> <dt><b>PRINTER_FONTTYPE</b></dt> <dt>0x4000</dt> </dl> </td> <td width="60%"> The
    ///font is a printer font. </td> </tr> <tr> <td width="40%"><a id="REGULAR_FONTTYPE"></a><a
    ///id="regular_fonttype"></a><dl> <dt><b>REGULAR_FONTTYPE</b></dt> <dt>0x0400</dt> </dl> </td> <td width="60%"> The
    ///font weight is normal. This information is duplicated in the <b>lfWeight</b> member of the LOGFONT structure and
    ///is equivalent to <b>FW_REGULAR</b>. </td> </tr> <tr> <td width="40%"><a id="SCREEN_FONTTYPE"></a><a
    ///id="screen_fonttype"></a><dl> <dt><b>SCREEN_FONTTYPE</b></dt> <dt>0x2000</dt> </dl> </td> <td width="60%"> The
    ///font is a screen font. </td> </tr> <tr> <td width="40%"><a id="SIMULATED_FONTTYPE"></a><a
    ///id="simulated_fonttype"></a><dl> <dt><b>SIMULATED_FONTTYPE</b></dt> <dt>0x8000</dt> </dl> </td> <td width="60%">
    ///The font is simulated by the graphics device interface (GDI). </td> </tr> </table>
    ushort       nFontType;
    ushort       ___MISSING_ALIGNMENT__;
    ///Type: <b>INT</b> The minimum point size a user can select. ChooseFont recognizes this member only if the
    ///<b>CF_LIMITSIZE</b> flag is specified.
    int          nSizeMin;
    ///Type: <b>INT</b> The maximum point size a user can select. ChooseFont recognizes this member only if the
    ///<b>CF_LIMITSIZE</b> flag is specified.
    int          nSizeMax;
}

///Contains information that the ChooseFont function uses to initialize the <b>Font</b> dialog box. After the user
///closes the dialog box, the system returns information about the user's selection in this structure.
struct CHOOSEFONTW
{
align (1):
    ///Type: <b>DWORD</b> The length of the structure, in bytes.
    uint         lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND         hwndOwner;
    ///Type: <b>HDC</b> This member is ignored by the ChooseFont function. <b>Windows Vista and Windows XP/2000: </b>A
    ///handle to the device context or information context of the printer whose fonts will be listed in the dialog box.
    ///This member is used only if the <b>Flags</b> member specifies the <b>CF_PRINTERFONTS</b> or <b>CF_BOTH</b> flag;
    ///otherwise, this member is ignored.
    HDC          hDC;
    ///Type: <b>LPLOGFONT</b> A pointer to a LOGFONT structure. If you set the <b>CF_INITTOLOGFONTSTRUCT</b> flag in the
    ///<b>Flags</b> member and initialize the other members, the ChooseFont function initializes the dialog box with a
    ///font that matches the <b>LOGFONT</b> members. If the user clicks the <b>OK</b> button, <b>ChooseFont</b> sets the
    ///members of the <b>LOGFONT</b> structure based on the user's selections.
    LOGFONTW*    lpLogFont;
    ///Type: <b>INT</b> The size of the selected font, in units of 1/10 of a point. The ChooseFont function sets this
    ///value after the user closes the dialog box.
    int          iPointSize;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Font</b> dialog box. When the dialog
    ///box returns, it sets these flags to indicate the user input. This member can be one or more of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CF_APPLY"></a><a
    ///id="cf_apply"></a><dl> <dt><b>CF_APPLY</b></dt> <dt>0x00000200L</dt> </dl> </td> <td width="60%"> Causes the
    ///dialog box to display the <b>Apply</b> button. You should provide a hook procedure to process WM_COMMAND messages
    ///for the <b>Apply</b> button. The hook procedure can send the WM_CHOOSEFONT_GETLOGFONT message to the dialog box
    ///to retrieve the address of the structure that contains the current selections for the font. </td> </tr> <tr> <td
    ///width="40%"><a id="CF_ANSIONLY"></a><a id="cf_ansionly"></a><dl> <dt><b>CF_ANSIONLY</b></dt> <dt>0x00000400L</dt>
    ///</dl> </td> <td width="60%"> This flag is obsolete. To limit font selections to all scripts except those that use
    ///the OEM or Symbol character sets, use <b>CF_SCRIPTSONLY</b>. To get the original <b>CF_ANSIONLY</b> behavior, use
    ///<b>CF_SELECTSCRIPT</b> and specify <b>ANSI_CHARSET</b> in the <b>lfCharSet</b> member of the LOGFONT structure
    ///pointed to by <b>lpLogFont</b>. </td> </tr> <tr> <td width="40%"><a id="CF_BOTH"></a><a id="cf_both"></a><dl>
    ///<dt><b>CF_BOTH</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> This flag is ignored for font
    ///enumeration. <b>Windows Vista and Windows XP/2000: </b>Causes the dialog box to list the available printer and
    ///screen fonts. The <b>hDC</b> member is a handle to the device context or information context associated with the
    ///printer. This flag is a combination of the <b>CF_SCREENFONTS</b> and <b>CF_PRINTERFONTS</b> flags. </td> </tr>
    ///<tr> <td width="40%"><a id="CF_EFFECTS"></a><a id="cf_effects"></a><dl> <dt><b>CF_EFFECTS</b></dt>
    ///<dt>0x00000100L</dt> </dl> </td> <td width="60%"> Causes the dialog box to display the controls that allow the
    ///user to specify strikeout, underline, and text color options. If this flag is set, you can use the
    ///<b>rgbColors</b> member to specify the initial text color. You can use the <b>lfStrikeOut</b> and
    ///<b>lfUnderline</b> members of the structure pointed to by <b>lpLogFont</b> to specify the initial settings of the
    ///strikeout and underline check boxes. ChooseFont can use these members to return the user's selections. </td>
    ///</tr> <tr> <td width="40%"><a id="CF_ENABLEHOOK"></a><a id="cf_enablehook"></a><dl> <dt><b>CF_ENABLEHOOK</b></dt>
    ///<dt>0x00000008L</dt> </dl> </td> <td width="60%"> Enables the hook procedure specified in the <b>lpfnHook</b>
    ///member of this structure. </td> </tr> <tr> <td width="40%"><a id="CF_ENABLETEMPLATE"></a><a
    ///id="cf_enabletemplate"></a><dl> <dt><b>CF_ENABLETEMPLATE</b></dt> <dt>0x00000010L</dt> </dl> </td> <td
    ///width="60%"> Indicates that the <b>hInstance</b> and <b>lpTemplateName</b> members specify a dialog box template
    ///to use in place of the default template. </td> </tr> <tr> <td width="40%"><a id="CF_ENABLETEMPLATEHANDLE"></a><a
    ///id="cf_enabletemplatehandle"></a><dl> <dt><b>CF_ENABLETEMPLATEHANDLE</b></dt> <dt>0x00000020L</dt> </dl> </td>
    ///<td width="60%"> Indicates that the <b>hInstance</b> member identifies a data block that contains a preloaded
    ///dialog box template. The system ignores the <b>lpTemplateName</b> member if this flag is specified. </td> </tr>
    ///<tr> <td width="40%"><a id="CF_FIXEDPITCHONLY"></a><a id="cf_fixedpitchonly"></a><dl>
    ///<dt><b>CF_FIXEDPITCHONLY</b></dt> <dt>0x00004000L</dt> </dl> </td> <td width="60%"> ChooseFont should enumerate
    ///and allow selection of only fixed-pitch fonts. </td> </tr> <tr> <td width="40%"><a id="CF_FORCEFONTEXIST"></a><a
    ///id="cf_forcefontexist"></a><dl> <dt><b>CF_FORCEFONTEXIST</b></dt> <dt>0x00010000L</dt> </dl> </td> <td
    ///width="60%"> ChooseFont should indicate an error condition if the user attempts to select a font or style that is
    ///not listed in the dialog box. </td> </tr> <tr> <td width="40%"><a id="CF_INACTIVEFONTS"></a><a
    ///id="cf_inactivefonts"></a><dl> <dt><b>CF_INACTIVEFONTS</b></dt> <dt>0x02000000L</dt> </dl> </td> <td width="60%">
    ///ChooseFont should additionally display fonts that are set to Hide in Fonts Control Panel. <b>Windows Vista and
    ///Windows XP/2000: </b>This flag is not supported until Windows 7. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_INITTOLOGFONTSTRUCT"></a><a id="cf_inittologfontstruct"></a><dl> <dt><b>CF_INITTOLOGFONTSTRUCT</b></dt>
    ///<dt>0x00000040L</dt> </dl> </td> <td width="60%"> ChooseFont should use the structure pointed to by the
    ///<b>lpLogFont</b> member to initialize the dialog box controls. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_LIMITSIZE"></a><a id="cf_limitsize"></a><dl> <dt><b>CF_LIMITSIZE</b></dt> <dt>0x00002000L</dt> </dl> </td>
    ///<td width="60%"> ChooseFont should select only font sizes within the range specified by the <b>nSizeMin</b> and
    ///<b>nSizeMax</b> members. </td> </tr> <tr> <td width="40%"><a id="CF_NOOEMFONTS"></a><a
    ///id="cf_nooemfonts"></a><dl> <dt><b>CF_NOOEMFONTS</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%"> Same
    ///as the <b>CF_NOVECTORFONTS</b> flag. </td> </tr> <tr> <td width="40%"><a id="CF_NOFACESEL"></a><a
    ///id="cf_nofacesel"></a><dl> <dt><b>CF_NOFACESEL</b></dt> <dt>0x00080000L</dt> </dl> </td> <td width="60%"> When
    ///using a LOGFONT structure to initialize the dialog box controls, use this flag to prevent the dialog box from
    ///displaying an initial selection for the font name combo box. This is useful when there is no single font name
    ///that applies to the text selection. </td> </tr> <tr> <td width="40%"><a id="CF_NOSCRIPTSEL"></a><a
    ///id="cf_noscriptsel"></a><dl> <dt><b>CF_NOSCRIPTSEL</b></dt> <dt>0x00800000L</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Script</b> combo box. When this flag is set, the <b>lfCharSet</b> member of the LOGFONT structure
    ///is set to <b>DEFAULT_CHARSET</b> when ChooseFont returns. This flag is used only to initialize the dialog box.
    ///</td> </tr> <tr> <td width="40%"><a id="CF_NOSIMULATIONS"></a><a id="cf_nosimulations"></a><dl>
    ///<dt><b>CF_NOSIMULATIONS</b></dt> <dt>0x00001000L</dt> </dl> </td> <td width="60%"> ChooseFont should not display
    ///or allow selection of font simulations. </td> </tr> <tr> <td width="40%"><a id="CF_NOSIZESEL"></a><a
    ///id="cf_nosizesel"></a><dl> <dt><b>CF_NOSIZESEL</b></dt> <dt>0x00200000L</dt> </dl> </td> <td width="60%"> When
    ///using a structure to initialize the dialog box controls, use this flag to prevent the dialog box from displaying
    ///an initial selection for the <b>Font Size</b> combo box. This is useful when there is no single font size that
    ///applies to the text selection. </td> </tr> <tr> <td width="40%"><a id="CF_NOSTYLESEL"></a><a
    ///id="cf_nostylesel"></a><dl> <dt><b>CF_NOSTYLESEL</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> When
    ///using a LOGFONT structure to initialize the dialog box controls, use this flag to prevent the dialog box from
    ///displaying an initial selection for the <b>Font Style</b> combo box. This is useful when there is no single font
    ///style that applies to the text selection. </td> </tr> <tr> <td width="40%"><a id="CF_NOVECTORFONTS"></a><a
    ///id="cf_novectorfonts"></a><dl> <dt><b>CF_NOVECTORFONTS</b></dt> <dt>0x00000800L</dt> </dl> </td> <td width="60%">
    ///ChooseFont should not allow vector font selections. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_NOVERTFONTS"></a><a id="cf_novertfonts"></a><dl> <dt><b>CF_NOVERTFONTS</b></dt> <dt>0x01000000L</dt> </dl>
    ///</td> <td width="60%"> Causes the <b>Font</b> dialog box to list only horizontally oriented fonts. </td> </tr>
    ///<tr> <td width="40%"><a id="CF_PRINTERFONTS"></a><a id="cf_printerfonts"></a><dl> <dt><b>CF_PRINTERFONTS</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> This flag is ignored for font enumeration. <b>Windows Vista and
    ///Windows XP/2000: </b>Causes the dialog box to list only the fonts supported by the printer associated with the
    ///device context or information context identified by the <b>hDC</b> member. It also causes the font type
    ///description label to appear at the bottom of the <b>Font</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_SCALABLEONLY"></a><a id="cf_scalableonly"></a><dl> <dt><b>CF_SCALABLEONLY</b></dt> <dt>0x00020000L</dt>
    ///</dl> </td> <td width="60%"> Specifies that ChooseFont should allow only the selection of scalable fonts.
    ///Scalable fonts include vector fonts, scalable printer fonts, TrueType fonts, and fonts scaled by other
    ///technologies. </td> </tr> <tr> <td width="40%"><a id="CF_SCREENFONTS"></a><a id="cf_screenfonts"></a><dl>
    ///<dt><b>CF_SCREENFONTS</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> This flag is ignored for font
    ///enumeration. <b>Windows Vista and Windows XP/2000: </b>Causes the dialog box to list only the screen fonts
    ///supported by the system. </td> </tr> <tr> <td width="40%"><a id="CF_SCRIPTSONLY"></a><a
    ///id="cf_scriptsonly"></a><dl> <dt><b>CF_SCRIPTSONLY</b></dt> <dt>0x00000400L</dt> </dl> </td> <td width="60%">
    ///ChooseFont should allow selection of fonts for all non-OEM and Symbol character sets, as well as the ANSI
    ///character set. This supersedes the <b>CF_ANSIONLY</b> value. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_SELECTSCRIPT"></a><a id="cf_selectscript"></a><dl> <dt><b>CF_SELECTSCRIPT</b></dt> <dt>0x00400000L</dt>
    ///</dl> </td> <td width="60%"> When specified on input, only fonts with the character set identified in the
    ///<b>lfCharSet</b> member of the LOGFONT structure are displayed. The user will not be allowed to change the
    ///character set specified in the <b>Scripts</b> combo box. </td> </tr> <tr> <td width="40%"><a
    ///id="CF_SHOWHELP"></a><a id="cf_showhelp"></a><dl> <dt><b>CF_SHOWHELP</b></dt> <dt>0x00000004L</dt> </dl> </td>
    ///<td width="60%"> Causes the dialog box to display the <b>Help</b> button. The <b>hwndOwner</b> member must
    ///specify the window to receive the HELPMSGSTRING registered messages that the dialog box sends when the user
    ///clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a id="CF_TTONLY"></a><a id="cf_ttonly"></a><dl>
    ///<dt><b>CF_TTONLY</b></dt> <dt>0x00040000L</dt> </dl> </td> <td width="60%"> ChooseFont should only enumerate and
    ///allow the selection of TrueType fonts. </td> </tr> <tr> <td width="40%"><a id="CF_USESTYLE"></a><a
    ///id="cf_usestyle"></a><dl> <dt><b>CF_USESTYLE</b></dt> <dt>0x00000080L</dt> </dl> </td> <td width="60%"> The
    ///<b>lpszStyle</b> member is a pointer to a buffer that contains style data that ChooseFont should use to
    ///initialize the <b>Font Style</b> combo box. When the user closes the dialog box, <b>ChooseFont</b> copies style
    ///data for the user's selection to this buffer. <div class="alert"><b>Note</b> To globalize your application, you
    ///should specify the style by using the <b>lfWeight</b> and <b>lfItalic</b> members of the LOGFONT structure
    ///pointed to by <b>lpLogFont</b>. The style name may change depending on the system user interface language.</div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="CF_WYSIWYG"></a><a id="cf_wysiwyg"></a><dl>
    ///<dt><b>CF_WYSIWYG</b></dt> <dt>0x00008000L</dt> </dl> </td> <td width="60%"> Obsolete. ChooseFont ignores this
    ///flag. <b>Windows Vista and Windows XP/2000: </b>ChooseFont should allow only the selection of fonts available on
    ///both the printer and the display. If this flag is specified, the <b>CF_SCREENSHOTS</b> and
    ///<b>CF_PRINTERFONTS</b>, or <b>CF_BOTH</b> flags should also be specified. </td> </tr> </table>
    uint         Flags;
    ///Type: <b>COLORREF</b> If the <b>CF_EFFECTS</b> flag is set, <b>rgbColors</b> specifies the initial text color.
    ///When ChooseFont returns successfully, this member contains the RGB value of the text color that the user
    ///selected. To create a COLORREF color value, use the RGB macro.
    uint         rgbColors;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the message's
    ///<i>lParam</i> parameter is a pointer to the CHOOSEFONT structure specified when the dialog was created. The hook
    ///procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM       lCustData;
    ///Type: <b>LPCFHOOKPROC</b> A pointer to a CFHookProc hook procedure that can process messages intended for the
    ///dialog box. This member is ignored unless the <b>CF_ENABLEHOOK</b> flag is set in the <b>Flags</b> member.
    LPCFHOOKPROC lpfnHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, <b>lpTemplateName</b> can be a value returned by the MAKEINTRESOURCE macro. This member is ignored
    ///unless the <b>CF_ENABLETEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PWSTR) lpTemplateName;
    ///Type: <b>HINSTANCE</b> If the <b>CF_ENABLETEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to a memory object containing a dialog box template. If the <b>CF_ENABLETEMPLATE</b>
    ///flag is set, <b>hInstance</b> is a handle to a module that contains a dialog box template named by the
    ///<b>lpTemplateName</b> member. If neither <b>CF_ENABLETEMPLATEHANDLE</b> nor <b>CF_ENABLETEMPLATE</b> is set, this
    ///member is ignored.
    HINSTANCE    hInstance;
    ///Type: <b>LPTSTR</b> The style data. If the <b>CF_USESTYLE</b> flag is specified, ChooseFont uses the data in this
    ///buffer to initialize the <b>Font Style</b> combo box. When the user closes the dialog box, <b>ChooseFont</b>
    ///copies the string in the <b>Font Style</b> combo box into this buffer.
    PWSTR        lpszStyle;
    ///Type: <b>WORD</b> The type of the selected font when ChooseFont returns. This member can be one or more of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="BOLD_FONTTYPE"></a><a id="bold_fonttype"></a><dl> <dt><b>BOLD_FONTTYPE</b></dt> <dt>0x0100</dt> </dl> </td>
    ///<td width="60%"> The font weight is bold. This information is duplicated in the <b>lfWeight</b> member of the
    ///LOGFONT structure and is equivalent to <b>FW_BOLD</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="ITALIC_FONTTYPE"></a><a id="italic_fonttype"></a><dl> <dt><b>ITALIC_FONTTYPE</b></dt> <dt>0x0200</dt> </dl>
    ///</td> <td width="60%"> The italic font attribute is set. This information is duplicated in the <b>lfItalic</b>
    ///member of the LOGFONT structure. </td> </tr> <tr> <td width="40%"><a id="PRINTER_FONTTYPE"></a><a
    ///id="printer_fonttype"></a><dl> <dt><b>PRINTER_FONTTYPE</b></dt> <dt>0x4000</dt> </dl> </td> <td width="60%"> The
    ///font is a printer font. </td> </tr> <tr> <td width="40%"><a id="REGULAR_FONTTYPE"></a><a
    ///id="regular_fonttype"></a><dl> <dt><b>REGULAR_FONTTYPE</b></dt> <dt>0x0400</dt> </dl> </td> <td width="60%"> The
    ///font weight is normal. This information is duplicated in the <b>lfWeight</b> member of the LOGFONT structure and
    ///is equivalent to <b>FW_REGULAR</b>. </td> </tr> <tr> <td width="40%"><a id="SCREEN_FONTTYPE"></a><a
    ///id="screen_fonttype"></a><dl> <dt><b>SCREEN_FONTTYPE</b></dt> <dt>0x2000</dt> </dl> </td> <td width="60%"> The
    ///font is a screen font. </td> </tr> <tr> <td width="40%"><a id="SIMULATED_FONTTYPE"></a><a
    ///id="simulated_fonttype"></a><dl> <dt><b>SIMULATED_FONTTYPE</b></dt> <dt>0x8000</dt> </dl> </td> <td width="60%">
    ///The font is simulated by the graphics device interface (GDI). </td> </tr> </table>
    ushort       nFontType;
    ushort       ___MISSING_ALIGNMENT__;
    ///Type: <b>INT</b> The minimum point size a user can select. ChooseFont recognizes this member only if the
    ///<b>CF_LIMITSIZE</b> flag is specified.
    int          nSizeMin;
    ///Type: <b>INT</b> The maximum point size a user can select. ChooseFont recognizes this member only if the
    ///<b>CF_LIMITSIZE</b> flag is specified.
    int          nSizeMax;
}

///Contains information that the PrintDlg function uses to initialize the Print Dialog Box. After the user closes the
///dialog box, the system uses this structure to return information about the user's selections.
struct PRINTDLGA
{
align (1):
    ///Type: <b>DWORD</b> The structure size, in bytes.
    uint            lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND            hwndOwner;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVMODE structure. If
    ///<b>hDevMode</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVMODE</b>
    ///structure and initialize its members. The PrintDlg function uses the input data to initialize the controls in the
    ///dialog box. When <b>PrintDlg</b> returns, the <b>DEVMODE</b> members indicate the user's input. If
    ///<b>hDevMode</b> is <b>NULL</b> on input, PrintDlg allocates memory for the DEVMODE structure, initializes its
    ///members to indicate the user's input, and returns a handle that identifies it. If the device driver for the
    ///specified printer does not support extended device modes, <b>hDevMode</b> is <b>NULL</b> when PrintDlg returns.
    ///If the device name (specified by the <b>dmDeviceName</b> member of the DEVMODE structure) does not appear in the
    ///[devices] section of WIN.INI, PrintDlg returns an error. For more information about the <b>hDevMode</b> and
    ///<b>hDevNames</b> members, see the Remarks section at the end of this topic.
    ptrdiff_t       hDevMode;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVNAMES structure. If
    ///<b>hDevNames</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVNAMES</b>
    ///structure and initialize its members. The PrintDlg function uses the input data to initialize the controls in the
    ///dialog box. When <b>PrintDlg</b> returns, the <b>DEVNAMES</b> members contain information for the printer chosen
    ///by the user. You can use this information to create a device context or an information context. The
    ///<b>hDevNames</b> member can be <b>NULL</b>, in which case, PrintDlg allocates memory for the DEVNAMES structure,
    ///initializes its members to indicate the user's input, and returns a handle that identifies it. For more
    ///information about the <b>hDevMode</b> and <b>hDevNames</b> members, see the Remarks section at the end of this
    ///topic.
    ptrdiff_t       hDevNames;
    ///Type: <b>HDC</b> A handle to a device context or an information context, depending on whether the <b>Flags</b>
    ///member specifies the <b>PD_RETURNDC</b> or <b>PC_RETURNIC</b> flag. If neither flag is specified, the value of
    ///this member is undefined. If both flags are specified, <b>PD_RETURNDC</b> has priority.
    HDC             hDC;
    ///Type: <b>DWORD</b> Initializes the <b>Print</b> dialog box. When the dialog box returns, it sets these flags to
    ///indicate the user's input. This member can be one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PD_ALLPAGES"></a><a id="pd_allpages"></a><dl>
    ///<dt><b>PD_ALLPAGES</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The default flag that indicates that
    ///the <b>All</b> radio button is initially selected. This flag is used as a placeholder to indicate that the
    ///<b>PD_PAGENUMS</b> and <b>PD_SELECTION</b> flags are not specified. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_COLLATE"></a><a id="pd_collate"></a><dl> <dt><b>PD_COLLATE</b></dt> <dt>0x00000010</dt> </dl> </td> <td
    ///width="60%"> If this flag is set, the <b>Collate</b> check box is selected. If this flag is set when the PrintDlg
    ///function returns, the application must simulate collation of multiple copies. For more information, see the
    ///description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag. See <b>PD_NOPAGENUMS</b>. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_DISABLEPRINTTOFILE"></a><a id="pd_disableprinttofile"></a><dl>
    ///<dt><b>PD_DISABLEPRINTTOFILE</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> Disables the <b>Print to
    ///File</b> check box. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLEPRINTHOOK"></a><a
    ///id="pd_enableprinthook"></a><dl> <dt><b>PD_ENABLEPRINTHOOK</b></dt> <dt>0x00001000</dt> </dl> </td> <td
    ///width="60%"> Enables the hook procedure specified in the <b>lpfnPrintHook</b> member. This enables the hook
    ///procedure for the <b>Print</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLEPRINTTEMPLATE"></a><a
    ///id="pd_enableprinttemplate"></a><dl> <dt><b>PD_ENABLEPRINTTEMPLATE</b></dt> <dt>0x00004000</dt> </dl> </td> <td
    ///width="60%"> Indicates that the <b>hInstance</b> and <b>lpPrintTemplateName</b> members specify a replacement for
    ///the default <b>Print</b> dialog box template. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_ENABLEPRINTTEMPLATEHANDLE"></a><a id="pd_enableprinttemplatehandle"></a><dl>
    ///<dt><b>PD_ENABLEPRINTTEMPLATEHANDLE</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hPrintTemplate</b> member identifies a data block that contains a preloaded dialog box template. This template
    ///replaces the default template for the <b>Print</b> dialog box. The system ignores the <b>lpPrintTemplateName</b>
    ///member if this flag is specified. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLESETUPHOOK"></a><a
    ///id="pd_enablesetuphook"></a><dl> <dt><b>PD_ENABLESETUPHOOK</b></dt> <dt>0x00002000</dt> </dl> </td> <td
    ///width="60%"> Enables the hook procedure specified in the <b>lpfnSetupHook</b> member. This enables the hook
    ///procedure for the <b>Print Setup</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_ENABLESETUPTEMPLATE"></a><a id="pd_enablesetuptemplate"></a><dl> <dt><b>PD_ENABLESETUPTEMPLATE</b></dt>
    ///<dt>0x00008000</dt> </dl> </td> <td width="60%"> Indicates that the <b>hInstance</b> and
    ///<b>lpSetupTemplateName</b> members specify a replacement for the default <b>Print Setup</b> dialog box template.
    ///</td> </tr> <tr> <td width="40%"><a id="PD_ENABLESETUPTEMPLATEHANDLE"></a><a
    ///id="pd_enablesetuptemplatehandle"></a><dl> <dt><b>PD_ENABLESETUPTEMPLATEHANDLE</b></dt> <dt>0x00020000</dt> </dl>
    ///</td> <td width="60%"> Indicates that the <b>hSetupTemplate</b> member identifies a data block that contains a
    ///preloaded dialog box template. This template replaces the default template for the <b>Print Setup</b> dialog box.
    ///The system ignores the <b>lpSetupTemplateName</b> member if this flag is specified. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_HIDEPRINTTOFILE"></a><a id="pd_hideprinttofile"></a><dl> <dt><b>PD_HIDEPRINTTOFILE</b></dt>
    ///<dt>0x00100000</dt> </dl> </td> <td width="60%"> Hides the <b>Print to File</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_NONETWORKBUTTON"></a><a id="pd_nonetworkbutton"></a><dl> <dt><b>PD_NONETWORKBUTTON</b></dt>
    ///<dt>0x00200000</dt> </dl> </td> <td width="60%"> Hides and disables the <b>Network</b> button. </td> </tr> <tr>
    ///<td width="40%"><a id="PD_NOPAGENUMS"></a><a id="pd_nopagenums"></a><dl> <dt><b>PD_NOPAGENUMS</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> Disables the <b>Pages</b> radio button and the associated edit
    ///controls. Also, it causes the <b>Collate</b> check box to appear in the dialog. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_NOSELECTION"></a><a id="pd_noselection"></a><dl> <dt><b>PD_NOSELECTION</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> Disables the <b>Selection</b> radio button. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_NOWARNING"></a><a id="pd_nowarning"></a><dl> <dt><b>PD_NOWARNING</b></dt>
    ///<dt>0x00000080</dt> </dl> </td> <td width="60%"> Prevents the warning message from being displayed when there is
    ///no default printer. </td> </tr> <tr> <td width="40%"><a id="PD_PAGENUMS"></a><a id="pd_pagenums"></a><dl>
    ///<dt><b>PD_PAGENUMS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> If this flag is set, the
    ///<b>Pages</b> radio button is selected. If this flag is set when the PrintDlg function returns, the
    ///<b>nFromPage</b> and <b>nToPage</b> members indicate the starting and ending pages specified by the user. </td>
    ///</tr> <tr> <td width="40%"><a id="PD_PRINTSETUP"></a><a id="pd_printsetup"></a><dl> <dt><b>PD_PRINTSETUP</b></dt>
    ///<dt>0x00000040</dt> </dl> </td> <td width="60%"> Causes the system to display the <b>Print Setup</b> dialog box
    ///rather than the <b>Print</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="PD_PRINTTOFILE"></a><a
    ///id="pd_printtofile"></a><dl> <dt><b>PD_PRINTTOFILE</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> If
    ///this flag is set, the <b>Print to File</b> check box is selected. If this flag is set when the PrintDlg function
    ///returns, the offset indicated by the <b>wOutputOffset</b> member of the DEVNAMES structure contains the string
    ///"FILE:". When you call the StartDoc function to start the printing operation, specify this "FILE:" string in the
    ///<b>lpszOutput</b> member of the DOCINFO structure. Specifying this string causes the print subsystem to query the
    ///user for the name of the output file. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDC"></a><a
    ///id="pd_returndc"></a><dl> <dt><b>PD_RETURNDC</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Causes
    ///PrintDlg to return a device context matching the selections the user made in the dialog box. The device context
    ///is returned in <b>hDC</b>. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDEFAULT"></a><a
    ///id="pd_returndefault"></a><dl> <dt><b>PD_RETURNDEFAULT</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%">
    ///If this flag is set, the PrintDlg function does not display the dialog box. Instead, it sets the <b>hDevNames</b>
    ///and <b>hDevMode</b> members to handles to DEVMODE and DEVNAMES structures that are initialized for the system
    ///default printer. Both <b>hDevNames</b> and <b>hDevMode</b> must be <b>NULL</b>, or <b>PrintDlg</b> returns an
    ///error. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNIC"></a><a id="pd_returnic"></a><dl>
    ///<dt><b>PD_RETURNIC</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Similar to the <b>PD_RETURNDC</b>
    ///flag, except this flag returns an information context rather than a device context. If neither <b>PD_RETURNDC</b>
    ///nor <b>PD_RETURNIC</b> is specified, <b>hDC</b> is undefined on output. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_SELECTION"></a><a id="pd_selection"></a><dl> <dt><b>PD_SELECTION</b></dt> <dt>0x00000001</dt> </dl> </td>
    ///<td width="60%"> If this flag is set, the <b>Selection</b> radio button is selected. If neither
    ///<b>PD_PAGENUMS</b> nor <b>PD_SELECTION</b> is set, the <b>All</b> radio button is selected. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_SHOWHELP"></a><a id="pd_showhelp"></a><dl> <dt><b>PD_SHOWHELP</b></dt> <dt>0x00000800</dt>
    ///</dl> </td> <td width="60%"> Causes the dialog box to display the <b>Help</b> button. The <b>hwndOwner</b> member
    ///must specify the window to receive the HELPMSGSTRING registered messages that the dialog box sends when the user
    ///clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a id="PD_USEDEVMODECOPIES"></a><a
    ///id="pd_usedevmodecopies"></a><dl> <dt><b>PD_USEDEVMODECOPIES</b></dt> <dt>0x00040000</dt> </dl> </td> <td
    ///width="60%"> Same as <b>PD_USEDEVMODECOPIESANDCOLLATE</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_USEDEVMODECOPIESANDCOLLATE"></a><a id="pd_usedevmodecopiesandcollate"></a><dl>
    ///<dt><b>PD_USEDEVMODECOPIESANDCOLLATE</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> This flag
    ///indicates whether your application supports multiple copies and collation. Set this flag on input to indicate
    ///that your application does not support multiple copies and collation. In this case, the <b>nCopies</b> member of
    ///the <b>PRINTDLG</b> structure always returns 1, and <b>PD_COLLATE</b> is never set in the <b>Flags</b> member. If
    ///this flag is not set, the application is responsible for printing and collating multiple copies. In this case,
    ///the <b>nCopies</b> member of the <b>PRINTDLG</b> structure indicates the number of copies the user wants to
    ///print, and the <b>PD_COLLATE</b> flag in the <b>Flags</b> member indicates whether the user wants collation.
    ///Regardless of whether this flag is set, an application can determine from <b>nCopies</b> and <b>PD_COLLATE</b>
    ///how many copies to render and whether to print them collated. If this flag is set and the printer driver does not
    ///support multiple copies, the <b>Copies</b> edit control is disabled. Similarly, if this flag is set and the
    ///printer driver does not support collation, the <b>Collate</b> check box is disabled. The <b>dmCopies</b> and
    ///<b>dmCollate</b> members of the DEVMODE structure contain the copies and collate information used by the printer
    ///driver. If this flag is set and the printer driver supports multiple copies, the <b>dmCopies</b> member indicates
    ///the number of copies requested by the user. If this flag is set and the printer driver supports collation, the
    ///<b>dmCollate</b> member of the <b>DEVMODE</b> structure indicates whether the user wants collation. If this flag
    ///is not set, the <b>dmCopies</b> member always returns 1, and the <b>dmCollate</b> member is always zero. <b>Known
    ///issue on Windows 2000/XP/2003:</b> If this flag is not set before calling PrintDlg, <b>PrintDlg</b> might swap
    ///<b>nCopies</b> and <b>dmCopies</b> values when it returns. The workaround for this issue is use <b>dmCopies</b>
    ///if its value is larger than 1, else, use <b>nCopies</b>, for you to to get the actual number of copies to be
    ///printed when <b>PrintDlg</b> returns. </td> </tr> </table> To ensure that PrintDlg or PrintDlgEx returns the
    ///correct values in the <b>dmCopies</b> and <b>dmCollate</b> members of the DEVMODE structure, set
    ///<b>PD_RETURNDC</b> = <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>TRUE</b>. In so doing, the
    ///<b>nCopies</b> member of the <b>PRINTDLG</b> structure is always 1 and <b>PD_COLLATE</b> is always <b>FALSE</b>.
    ///To ensure that PrintDlg or PrintDlgEx returns the correct values in <b>nCopies</b> and <b>PD_COLLATE</b>, set
    ///<b>PD_RETURNDC</b> = <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>FALSE</b>. In so doing,
    ///<b>dmCopies</b> is always 1 and <b>dmCollate</b> is always <b>FALSE</b>. On Windows Vista and Windows 7, when you
    ///call PrintDlg or PrintDlgEx with <b>PD_RETURNDC</b> set to <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b>
    ///set to <b>FALSE</b>, the <b>PrintDlg</b> or <b>PrintDlgEx</b> function sets the number of copies in the
    ///<b>nCopies</b> member of the <b>PRINTDLG</b> structure, and it sets the number of copies in the structure
    ///represented by the hDC member of the <b>PRINTDLG</b> structure. When making calls to GDI, you must ignore the
    ///value of <b>nCopies</b>, consider the value as 1, and use the returned hDC to avoid printing duplicate copies.
    uint            Flags;
    ///Type: <b>WORD</b> The initial value for the starting page edit control. When PrintDlg returns, <b>nFromPage</b>
    ///is the starting page specified by the user. If the <b>Pages</b> radio button is selected when the user clicks the
    ///<b>Okay</b> button, <b>PrintDlg</b> sets the <b>PD_PAGENUMS</b> flag and does not return until the user enters a
    ///starting page value that is within the minimum to maximum page range. If the input value for either
    ///<b>nFromPage</b> or <b>nToPage</b> is outside the minimum/maximum range, PrintDlg returns an error only if the
    ///<b>PD_PAGENUMS</b> flag is specified; otherwise, it displays the dialog box but changes the out-of-range value to
    ///the minimum or maximum value.
    ushort          nFromPage;
    ///Type: <b>WORD</b> The initial value for the ending page edit control. When PrintDlg returns, <b>nToPage</b> is
    ///the ending page specified by the user. If the <b>Pages</b> radio button is selected when the use clicks the
    ///<b>Okay</b> button, <b>PrintDlg</b> sets the <b>PD_PAGENUMS</b> flag and does not return until the user enters an
    ///ending page value that is within the minimum to maximum page range.
    ushort          nToPage;
    ///Type: <b>WORD</b> The minimum value for the page range specified in the <b>From</b> and <b>To</b> page edit
    ///controls. If <b>nMinPage</b> equals <b>nMaxPage</b>, the <b>Pages</b> radio button and the starting and ending
    ///page edit controls are disabled.
    ushort          nMinPage;
    ///Type: <b>WORD</b> The maximum value for the page range specified in the <b>From</b> and <b>To</b> page edit
    ///controls.
    ushort          nMaxPage;
    ///Type: <b>WORD</b> The initial number of copies for the <b>Copies</b> edit control if <b>hDevMode</b> is
    ///<b>NULL</b>; otherwise, the <b>dmCopies</b> member of the DEVMODE structure contains the initial value. When
    ///PrintDlg returns, <b>nCopies</b> contains the actual number of copies to print. This value depends on whether the
    ///application or the printer driver is responsible for printing multiple copies. If the
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag is set in the <b>Flags</b> member, <b>nCopies</b> is always 1 on
    ///return, and the printer driver is responsible for printing multiple copies. If the flag is not set, the
    ///application is responsible for printing the number of copies specified by <b>nCopies</b>. For more information,
    ///see the description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag.
    ushort          nCopies;
    ///Type: <b>HINSTANCE</b> If the <b>PD_ENABLEPRINTTEMPLATE</b> or <b>PD_ENABLESETUPTEMPLATE</b> flag is set in the
    ///<b>Flags</b> member, <b>hInstance</b> is a handle to the application or module instance that contains the dialog
    ///box template named by the <b>lpPrintTemplateName</b> or <b>lpSetupTemplateName</b> member.
    HINSTANCE       hInstance;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnPrintHook</b> or <b>lpfnSetupHook</b> member. When the system sends the WM_INITDIALOG message to the hook
    ///procedure, the message's <i>lParam</i> parameter is a pointer to the <b>PRINTDLG</b> structure specified when the
    ///dialog was created. The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM          lCustData;
    ///Type: <b>LPPRINTHOOKPROC</b> A pointer to a PrintHookProc hook procedure that can process messages intended for
    ///the <b>Print</b> dialog box. This member is ignored unless the <b>PD_ENABLEPRINTHOOK</b> flag is set in the
    ///<b>Flags</b> member.
    LPPRINTHOOKPROC lpfnPrintHook;
    ///Type: <b>LPSETUPHOOKPROC</b> A pointer to a SetupHookProc hook procedure that can process messages intended for
    ///the <b>Print Setup</b> dialog box. This member is ignored unless the <b>PD_ENABLESETUPHOOK</b> flag is set in the
    ///<b>Flags</b> member.
    LPSETUPHOOKPROC lpfnSetupHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template replaces the default <b>Print</b> dialog box template. This member is
    ///ignored unless the <b>PD_ENABLEPRINTTEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PSTR)     lpPrintTemplateName;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template replaces the default <b>Print Setup</b> dialog box template. This member
    ///is ignored unless the <b>PD_ENABLESETUPTEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PSTR)     lpSetupTemplateName;
    ///Type: <b>HGLOBAL</b> If the <b>PD_ENABLEPRINTTEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hPrintTemplate</b> is a handle to a memory object containing a dialog box template. This template replaces the
    ///default <b>Print</b> dialog box template.
    ptrdiff_t       hPrintTemplate;
    ///Type: <b>HGLOBAL</b> If the <b>PD_ENABLESETUPTEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hSetupTemplate</b> is a handle to a memory object containing a dialog box template. This template replaces the
    ///default <b>Print Setup</b> dialog box template.
    ptrdiff_t       hSetupTemplate;
}

///Contains information that the PrintDlg function uses to initialize the Print Dialog Box. After the user closes the
///dialog box, the system uses this structure to return information about the user's selections.
struct PRINTDLGW
{
align (1):
    ///Type: <b>DWORD</b> The structure size, in bytes.
    uint            lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND            hwndOwner;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVMODE structure. If
    ///<b>hDevMode</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVMODE</b>
    ///structure and initialize its members. The PrintDlg function uses the input data to initialize the controls in the
    ///dialog box. When <b>PrintDlg</b> returns, the <b>DEVMODE</b> members indicate the user's input. If
    ///<b>hDevMode</b> is <b>NULL</b> on input, PrintDlg allocates memory for the DEVMODE structure, initializes its
    ///members to indicate the user's input, and returns a handle that identifies it. If the device driver for the
    ///specified printer does not support extended device modes, <b>hDevMode</b> is <b>NULL</b> when PrintDlg returns.
    ///If the device name (specified by the <b>dmDeviceName</b> member of the DEVMODE structure) does not appear in the
    ///[devices] section of WIN.INI, PrintDlg returns an error. For more information about the <b>hDevMode</b> and
    ///<b>hDevNames</b> members, see the Remarks section at the end of this topic.
    ptrdiff_t       hDevMode;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVNAMES structure. If
    ///<b>hDevNames</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVNAMES</b>
    ///structure and initialize its members. The PrintDlg function uses the input data to initialize the controls in the
    ///dialog box. When <b>PrintDlg</b> returns, the <b>DEVNAMES</b> members contain information for the printer chosen
    ///by the user. You can use this information to create a device context or an information context. The
    ///<b>hDevNames</b> member can be <b>NULL</b>, in which case, PrintDlg allocates memory for the DEVNAMES structure,
    ///initializes its members to indicate the user's input, and returns a handle that identifies it. For more
    ///information about the <b>hDevMode</b> and <b>hDevNames</b> members, see the Remarks section at the end of this
    ///topic.
    ptrdiff_t       hDevNames;
    ///Type: <b>HDC</b> A handle to a device context or an information context, depending on whether the <b>Flags</b>
    ///member specifies the <b>PD_RETURNDC</b> or <b>PC_RETURNIC</b> flag. If neither flag is specified, the value of
    ///this member is undefined. If both flags are specified, <b>PD_RETURNDC</b> has priority.
    HDC             hDC;
    ///Type: <b>DWORD</b> Initializes the <b>Print</b> dialog box. When the dialog box returns, it sets these flags to
    ///indicate the user's input. This member can be one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PD_ALLPAGES"></a><a id="pd_allpages"></a><dl>
    ///<dt><b>PD_ALLPAGES</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The default flag that indicates that
    ///the <b>All</b> radio button is initially selected. This flag is used as a placeholder to indicate that the
    ///<b>PD_PAGENUMS</b> and <b>PD_SELECTION</b> flags are not specified. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_COLLATE"></a><a id="pd_collate"></a><dl> <dt><b>PD_COLLATE</b></dt> <dt>0x00000010</dt> </dl> </td> <td
    ///width="60%"> If this flag is set, the <b>Collate</b> check box is selected. If this flag is set when the PrintDlg
    ///function returns, the application must simulate collation of multiple copies. For more information, see the
    ///description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag. See <b>PD_NOPAGENUMS</b>. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_DISABLEPRINTTOFILE"></a><a id="pd_disableprinttofile"></a><dl>
    ///<dt><b>PD_DISABLEPRINTTOFILE</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> Disables the <b>Print to
    ///File</b> check box. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLEPRINTHOOK"></a><a
    ///id="pd_enableprinthook"></a><dl> <dt><b>PD_ENABLEPRINTHOOK</b></dt> <dt>0x00001000</dt> </dl> </td> <td
    ///width="60%"> Enables the hook procedure specified in the <b>lpfnPrintHook</b> member. This enables the hook
    ///procedure for the <b>Print</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLEPRINTTEMPLATE"></a><a
    ///id="pd_enableprinttemplate"></a><dl> <dt><b>PD_ENABLEPRINTTEMPLATE</b></dt> <dt>0x00004000</dt> </dl> </td> <td
    ///width="60%"> Indicates that the <b>hInstance</b> and <b>lpPrintTemplateName</b> members specify a replacement for
    ///the default <b>Print</b> dialog box template. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_ENABLEPRINTTEMPLATEHANDLE"></a><a id="pd_enableprinttemplatehandle"></a><dl>
    ///<dt><b>PD_ENABLEPRINTTEMPLATEHANDLE</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hPrintTemplate</b> member identifies a data block that contains a preloaded dialog box template. This template
    ///replaces the default template for the <b>Print</b> dialog box. The system ignores the <b>lpPrintTemplateName</b>
    ///member if this flag is specified. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLESETUPHOOK"></a><a
    ///id="pd_enablesetuphook"></a><dl> <dt><b>PD_ENABLESETUPHOOK</b></dt> <dt>0x00002000</dt> </dl> </td> <td
    ///width="60%"> Enables the hook procedure specified in the <b>lpfnSetupHook</b> member. This enables the hook
    ///procedure for the <b>Print Setup</b> dialog box. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_ENABLESETUPTEMPLATE"></a><a id="pd_enablesetuptemplate"></a><dl> <dt><b>PD_ENABLESETUPTEMPLATE</b></dt>
    ///<dt>0x00008000</dt> </dl> </td> <td width="60%"> Indicates that the <b>hInstance</b> and
    ///<b>lpSetupTemplateName</b> members specify a replacement for the default <b>Print Setup</b> dialog box template.
    ///</td> </tr> <tr> <td width="40%"><a id="PD_ENABLESETUPTEMPLATEHANDLE"></a><a
    ///id="pd_enablesetuptemplatehandle"></a><dl> <dt><b>PD_ENABLESETUPTEMPLATEHANDLE</b></dt> <dt>0x00020000</dt> </dl>
    ///</td> <td width="60%"> Indicates that the <b>hSetupTemplate</b> member identifies a data block that contains a
    ///preloaded dialog box template. This template replaces the default template for the <b>Print Setup</b> dialog box.
    ///The system ignores the <b>lpSetupTemplateName</b> member if this flag is specified. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_HIDEPRINTTOFILE"></a><a id="pd_hideprinttofile"></a><dl> <dt><b>PD_HIDEPRINTTOFILE</b></dt>
    ///<dt>0x00100000</dt> </dl> </td> <td width="60%"> Hides the <b>Print to File</b> check box. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_NONETWORKBUTTON"></a><a id="pd_nonetworkbutton"></a><dl> <dt><b>PD_NONETWORKBUTTON</b></dt>
    ///<dt>0x00200000</dt> </dl> </td> <td width="60%"> Hides and disables the <b>Network</b> button. </td> </tr> <tr>
    ///<td width="40%"><a id="PD_NOPAGENUMS"></a><a id="pd_nopagenums"></a><dl> <dt><b>PD_NOPAGENUMS</b></dt>
    ///<dt>0x00000008</dt> </dl> </td> <td width="60%"> Disables the <b>Pages</b> radio button and the associated edit
    ///controls. Also, it causes the <b>Collate</b> check box to appear in the dialog. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_NOSELECTION"></a><a id="pd_noselection"></a><dl> <dt><b>PD_NOSELECTION</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> Disables the <b>Selection</b> radio button. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_NOWARNING"></a><a id="pd_nowarning"></a><dl> <dt><b>PD_NOWARNING</b></dt>
    ///<dt>0x00000080</dt> </dl> </td> <td width="60%"> Prevents the warning message from being displayed when there is
    ///no default printer. </td> </tr> <tr> <td width="40%"><a id="PD_PAGENUMS"></a><a id="pd_pagenums"></a><dl>
    ///<dt><b>PD_PAGENUMS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> If this flag is set, the
    ///<b>Pages</b> radio button is selected. If this flag is set when the PrintDlg function returns, the
    ///<b>nFromPage</b> and <b>nToPage</b> members indicate the starting and ending pages specified by the user. </td>
    ///</tr> <tr> <td width="40%"><a id="PD_PRINTSETUP"></a><a id="pd_printsetup"></a><dl> <dt><b>PD_PRINTSETUP</b></dt>
    ///<dt>0x00000040</dt> </dl> </td> <td width="60%"> Causes the system to display the <b>Print Setup</b> dialog box
    ///rather than the <b>Print</b> dialog box. </td> </tr> <tr> <td width="40%"><a id="PD_PRINTTOFILE"></a><a
    ///id="pd_printtofile"></a><dl> <dt><b>PD_PRINTTOFILE</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> If
    ///this flag is set, the <b>Print to File</b> check box is selected. If this flag is set when the PrintDlg function
    ///returns, the offset indicated by the <b>wOutputOffset</b> member of the DEVNAMES structure contains the string
    ///"FILE:". When you call the StartDoc function to start the printing operation, specify this "FILE:" string in the
    ///<b>lpszOutput</b> member of the DOCINFO structure. Specifying this string causes the print subsystem to query the
    ///user for the name of the output file. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDC"></a><a
    ///id="pd_returndc"></a><dl> <dt><b>PD_RETURNDC</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Causes
    ///PrintDlg to return a device context matching the selections the user made in the dialog box. The device context
    ///is returned in <b>hDC</b>. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDEFAULT"></a><a
    ///id="pd_returndefault"></a><dl> <dt><b>PD_RETURNDEFAULT</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%">
    ///If this flag is set, the PrintDlg function does not display the dialog box. Instead, it sets the <b>hDevNames</b>
    ///and <b>hDevMode</b> members to handles to DEVMODE and DEVNAMES structures that are initialized for the system
    ///default printer. Both <b>hDevNames</b> and <b>hDevMode</b> must be <b>NULL</b>, or <b>PrintDlg</b> returns an
    ///error. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNIC"></a><a id="pd_returnic"></a><dl>
    ///<dt><b>PD_RETURNIC</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Similar to the <b>PD_RETURNDC</b>
    ///flag, except this flag returns an information context rather than a device context. If neither <b>PD_RETURNDC</b>
    ///nor <b>PD_RETURNIC</b> is specified, <b>hDC</b> is undefined on output. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_SELECTION"></a><a id="pd_selection"></a><dl> <dt><b>PD_SELECTION</b></dt> <dt>0x00000001</dt> </dl> </td>
    ///<td width="60%"> If this flag is set, the <b>Selection</b> radio button is selected. If neither
    ///<b>PD_PAGENUMS</b> nor <b>PD_SELECTION</b> is set, the <b>All</b> radio button is selected. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_SHOWHELP"></a><a id="pd_showhelp"></a><dl> <dt><b>PD_SHOWHELP</b></dt> <dt>0x00000800</dt>
    ///</dl> </td> <td width="60%"> Causes the dialog box to display the <b>Help</b> button. The <b>hwndOwner</b> member
    ///must specify the window to receive the HELPMSGSTRING registered messages that the dialog box sends when the user
    ///clicks the <b>Help</b> button. </td> </tr> <tr> <td width="40%"><a id="PD_USEDEVMODECOPIES"></a><a
    ///id="pd_usedevmodecopies"></a><dl> <dt><b>PD_USEDEVMODECOPIES</b></dt> <dt>0x00040000</dt> </dl> </td> <td
    ///width="60%"> Same as <b>PD_USEDEVMODECOPIESANDCOLLATE</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_USEDEVMODECOPIESANDCOLLATE"></a><a id="pd_usedevmodecopiesandcollate"></a><dl>
    ///<dt><b>PD_USEDEVMODECOPIESANDCOLLATE</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> This flag
    ///indicates whether your application supports multiple copies and collation. Set this flag on input to indicate
    ///that your application does not support multiple copies and collation. In this case, the <b>nCopies</b> member of
    ///the <b>PRINTDLG</b> structure always returns 1, and <b>PD_COLLATE</b> is never set in the <b>Flags</b> member. If
    ///this flag is not set, the application is responsible for printing and collating multiple copies. In this case,
    ///the <b>nCopies</b> member of the <b>PRINTDLG</b> structure indicates the number of copies the user wants to
    ///print, and the <b>PD_COLLATE</b> flag in the <b>Flags</b> member indicates whether the user wants collation.
    ///Regardless of whether this flag is set, an application can determine from <b>nCopies</b> and <b>PD_COLLATE</b>
    ///how many copies to render and whether to print them collated. If this flag is set and the printer driver does not
    ///support multiple copies, the <b>Copies</b> edit control is disabled. Similarly, if this flag is set and the
    ///printer driver does not support collation, the <b>Collate</b> check box is disabled. The <b>dmCopies</b> and
    ///<b>dmCollate</b> members of the DEVMODE structure contain the copies and collate information used by the printer
    ///driver. If this flag is set and the printer driver supports multiple copies, the <b>dmCopies</b> member indicates
    ///the number of copies requested by the user. If this flag is set and the printer driver supports collation, the
    ///<b>dmCollate</b> member of the <b>DEVMODE</b> structure indicates whether the user wants collation. If this flag
    ///is not set, the <b>dmCopies</b> member always returns 1, and the <b>dmCollate</b> member is always zero. <b>Known
    ///issue on Windows 2000/XP/2003:</b> If this flag is not set before calling PrintDlg, <b>PrintDlg</b> might swap
    ///<b>nCopies</b> and <b>dmCopies</b> values when it returns. The workaround for this issue is use <b>dmCopies</b>
    ///if its value is larger than 1, else, use <b>nCopies</b>, for you to to get the actual number of copies to be
    ///printed when <b>PrintDlg</b> returns. </td> </tr> </table> To ensure that PrintDlg or PrintDlgEx returns the
    ///correct values in the <b>dmCopies</b> and <b>dmCollate</b> members of the DEVMODE structure, set
    ///<b>PD_RETURNDC</b> = <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>TRUE</b>. In so doing, the
    ///<b>nCopies</b> member of the <b>PRINTDLG</b> structure is always 1 and <b>PD_COLLATE</b> is always <b>FALSE</b>.
    ///To ensure that PrintDlg or PrintDlgEx returns the correct values in <b>nCopies</b> and <b>PD_COLLATE</b>, set
    ///<b>PD_RETURNDC</b> = <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>FALSE</b>. In so doing,
    ///<b>dmCopies</b> is always 1 and <b>dmCollate</b> is always <b>FALSE</b>. On Windows Vista and Windows 7, when you
    ///call PrintDlg or PrintDlgEx with <b>PD_RETURNDC</b> set to <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b>
    ///set to <b>FALSE</b>, the <b>PrintDlg</b> or <b>PrintDlgEx</b> function sets the number of copies in the
    ///<b>nCopies</b> member of the <b>PRINTDLG</b> structure, and it sets the number of copies in the structure
    ///represented by the hDC member of the <b>PRINTDLG</b> structure. When making calls to GDI, you must ignore the
    ///value of <b>nCopies</b>, consider the value as 1, and use the returned hDC to avoid printing duplicate copies.
    uint            Flags;
    ///Type: <b>WORD</b> The initial value for the starting page edit control. When PrintDlg returns, <b>nFromPage</b>
    ///is the starting page specified by the user. If the <b>Pages</b> radio button is selected when the user clicks the
    ///<b>Okay</b> button, <b>PrintDlg</b> sets the <b>PD_PAGENUMS</b> flag and does not return until the user enters a
    ///starting page value that is within the minimum to maximum page range. If the input value for either
    ///<b>nFromPage</b> or <b>nToPage</b> is outside the minimum/maximum range, PrintDlg returns an error only if the
    ///<b>PD_PAGENUMS</b> flag is specified; otherwise, it displays the dialog box but changes the out-of-range value to
    ///the minimum or maximum value.
    ushort          nFromPage;
    ///Type: <b>WORD</b> The initial value for the ending page edit control. When PrintDlg returns, <b>nToPage</b> is
    ///the ending page specified by the user. If the <b>Pages</b> radio button is selected when the use clicks the
    ///<b>Okay</b> button, <b>PrintDlg</b> sets the <b>PD_PAGENUMS</b> flag and does not return until the user enters an
    ///ending page value that is within the minimum to maximum page range.
    ushort          nToPage;
    ///Type: <b>WORD</b> The minimum value for the page range specified in the <b>From</b> and <b>To</b> page edit
    ///controls. If <b>nMinPage</b> equals <b>nMaxPage</b>, the <b>Pages</b> radio button and the starting and ending
    ///page edit controls are disabled.
    ushort          nMinPage;
    ///Type: <b>WORD</b> The maximum value for the page range specified in the <b>From</b> and <b>To</b> page edit
    ///controls.
    ushort          nMaxPage;
    ///Type: <b>WORD</b> The initial number of copies for the <b>Copies</b> edit control if <b>hDevMode</b> is
    ///<b>NULL</b>; otherwise, the <b>dmCopies</b> member of the DEVMODE structure contains the initial value. When
    ///PrintDlg returns, <b>nCopies</b> contains the actual number of copies to print. This value depends on whether the
    ///application or the printer driver is responsible for printing multiple copies. If the
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag is set in the <b>Flags</b> member, <b>nCopies</b> is always 1 on
    ///return, and the printer driver is responsible for printing multiple copies. If the flag is not set, the
    ///application is responsible for printing the number of copies specified by <b>nCopies</b>. For more information,
    ///see the description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag.
    ushort          nCopies;
    ///Type: <b>HINSTANCE</b> If the <b>PD_ENABLEPRINTTEMPLATE</b> or <b>PD_ENABLESETUPTEMPLATE</b> flag is set in the
    ///<b>Flags</b> member, <b>hInstance</b> is a handle to the application or module instance that contains the dialog
    ///box template named by the <b>lpPrintTemplateName</b> or <b>lpSetupTemplateName</b> member.
    HINSTANCE       hInstance;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnPrintHook</b> or <b>lpfnSetupHook</b> member. When the system sends the WM_INITDIALOG message to the hook
    ///procedure, the message's <i>lParam</i> parameter is a pointer to the <b>PRINTDLG</b> structure specified when the
    ///dialog was created. The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM          lCustData;
    ///Type: <b>LPPRINTHOOKPROC</b> A pointer to a PrintHookProc hook procedure that can process messages intended for
    ///the <b>Print</b> dialog box. This member is ignored unless the <b>PD_ENABLEPRINTHOOK</b> flag is set in the
    ///<b>Flags</b> member.
    LPPRINTHOOKPROC lpfnPrintHook;
    ///Type: <b>LPSETUPHOOKPROC</b> A pointer to a SetupHookProc hook procedure that can process messages intended for
    ///the <b>Print Setup</b> dialog box. This member is ignored unless the <b>PD_ENABLESETUPHOOK</b> flag is set in the
    ///<b>Flags</b> member.
    LPSETUPHOOKPROC lpfnSetupHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template replaces the default <b>Print</b> dialog box template. This member is
    ///ignored unless the <b>PD_ENABLEPRINTTEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PWSTR)    lpPrintTemplateName;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template replaces the default <b>Print Setup</b> dialog box template. This member
    ///is ignored unless the <b>PD_ENABLESETUPTEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PWSTR)    lpSetupTemplateName;
    ///Type: <b>HGLOBAL</b> If the <b>PD_ENABLEPRINTTEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hPrintTemplate</b> is a handle to a memory object containing a dialog box template. This template replaces the
    ///default <b>Print</b> dialog box template.
    ptrdiff_t       hPrintTemplate;
    ///Type: <b>HGLOBAL</b> If the <b>PD_ENABLESETUPTEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hSetupTemplate</b> is a handle to a memory object containing a dialog box template. This template replaces the
    ///default <b>Print Setup</b> dialog box template.
    ptrdiff_t       hSetupTemplate;
}

///Represents a range of pages in a print job. A print job can have more than one page range. This information is
///supplied in the PRINTDLGEX structure when calling the PrintDlgEx function.
struct PRINTPAGERANGE
{
align (1):
    ///Type: <b>DWORD</b> The first page of the range.
    uint nFromPage;
    ///Type: <b>DWORD</b> The last page of the range.
    uint nToPage;
}

///Contains information that the PrintDlgEx function uses to initialize the Print property sheet. After the user closes
///the property sheet, the system uses this structure to return information about the user's selections.
struct PRINTDLGEXA
{
align (1):
    ///Type: <b>DWORD</b> The structure size, in bytes.
    uint            lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the property sheet. This member must be a valid window handle;
    ///it cannot be <b>NULL</b>.
    HWND            hwndOwner;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVMODE structure. If
    ///<b>hDevMode</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVMODE</b>
    ///structure and initialize its members. The PrintDlgEx function uses the input data to initialize the controls in
    ///the property sheet. When <b>PrintDlgEx</b> returns, the <b>DEVMODE</b> members indicate the user's input. If
    ///<b>hDevMode</b> is <b>NULL</b> on input, PrintDlgEx allocates memory for the DEVMODE structure, initializes its
    ///members to indicate the user's input, and returns a handle that identifies it. For more information about the
    ///<b>hDevMode</b> and <b>hDevNames</b> members, see the Remarks section at the end of this topic.
    ptrdiff_t       hDevMode;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVNAMES structure. If
    ///<b>hDevNames</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVNAMES</b>
    ///structure and initialize its members. The PrintDlgEx function uses the input data to initialize the controls in
    ///the property sheet. When <b>PrintDlgEx</b> returns, the <b>DEVNAMES</b> members contain information for the
    ///printer chosen by the user. You can use this information to create a device context or an information context.
    ///The <b>hDevNames</b> member can be <b>NULL</b>, in which case, PrintDlgEx allocates memory for the DEVNAMES
    ///structure, initializes its members to indicate the user's input, and returns a handle that identifies it. For
    ///more information about the <b>hDevMode</b> and <b>hDevNames</b> members, see the Remarks section at the end of
    ///this topic.
    ptrdiff_t       hDevNames;
    ///Type: <b>HDC</b> A handle to a device context or an information context, depending on whether the <b>Flags</b>
    ///member specifies the <b>PD_RETURNDC</b> or <b>PC_RETURNIC</b> flag. If neither flag is specified, the value of
    ///this member is undefined. If both flags are specified, <b>PD_RETURNDC</b> has priority.
    HDC             hDC;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Print</b> property sheet. When the
    ///PrintDlgEx function returns, it sets these flags to indicate the user's input. This member can be one or more of
    ///the following values. To ensure that PrintDlg or PrintDlgEx returns the correct values in the <b>dmCopies</b> and
    ///<b>dmCollate</b> members of the DEVMODE structure, set <b>PD_RETURNDC</b> = <b>TRUE</b> and
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>TRUE</b>. In so doing, the <b>nCopies</b> member of the PRINTDLG
    ///structure is always 1 and <b>PD_COLLATE</b> is always <b>FALSE</b>. To ensure that PrintDlg or PrintDlgEx returns
    ///the correct values in <b>nCopies</b> and <b>PD_COLLATE</b>, set <b>PD_RETURNDC</b> = <b>TRUE</b> and
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>FALSE</b>. In so doing, <b>dmCopies</b> is always 1 and
    ///<b>dmCollate</b> is always <b>FALSE</b>. Starting with Windows Vista, when you call PrintDlg or PrintDlgEx with
    ///<b>PD_RETURNDC</b> set to <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b> set to <b>FALSE</b>, the
    ///<b>PrintDlg</b> or <b>PrintDlgEx</b> function sets the number of copies in the <b>nCopies</b> member of the
    ///PRINTDLG structure, and it sets the number of copies in the structure represented by the <b>hDC</b> member of the
    ///<b>PRINTDLG</b> structure. When making calls to GDI, you must ignore the value of <b>nCopies</b>, consider the
    ///value as 1, and use the returned <b>hDC</b> to avoid printing duplicate copies. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PD_ALLPAGES"></a><a id="pd_allpages"></a><dl>
    ///<dt><b>PD_ALLPAGES</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The default flag that indicates that
    ///the <b>All</b> radio button is initially selected. This flag is used as a placeholder to indicate that the
    ///<b>PD_PAGENUMS</b>, <b>PD_SELECTION</b>, and <b>PD_CURRENTPAGE</b> flags are not specified. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_COLLATE"></a><a id="pd_collate"></a><dl> <dt><b>PD_COLLATE</b></dt> <dt>0x00000010</dt>
    ///</dl> </td> <td width="60%"> If this flag is set, the <b>Collate</b> check box is selected. If this flag is set
    ///when the PrintDlgEx function returns, the application must simulate collation of multiple copies. For more
    ///information, see the description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag. See <b>PD_NOPAGENUMS</b>.
    ///</td> </tr> <tr> <td width="40%"><a id="PD_CURRENTPAGE"></a><a id="pd_currentpage"></a><dl>
    ///<dt><b>PD_CURRENTPAGE</b></dt> <dt>0x00400000</dt> </dl> </td> <td width="60%"> If this flag is set, the
    ///<b>Current Page</b> radio button is selected. If none of the <b>PD_PAGENUMS</b>, <b>PD_SELECTION</b>, or
    ///<b>PD_CURRENTPAGE</b> flags is set, the <b>All</b> radio button is selected. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_DISABLEPRINTTOFILE"></a><a id="pd_disableprinttofile"></a><dl> <dt><b>PD_DISABLEPRINTTOFILE</b></dt>
    ///<dt>0x00080000</dt> </dl> </td> <td width="60%"> Disables the <b>Print to File</b> check box. </td> </tr> <tr>
    ///<td width="40%"><a id="PD_ENABLEPRINTTEMPLATE"></a><a id="pd_enableprinttemplate"></a><dl>
    ///<dt><b>PD_ENABLEPRINTTEMPLATE</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hInstance</b> and <b>lpPrintTemplateName</b> members specify a replacement for the default dialog box template
    ///in the lower portion of the <b>General</b> page. The default template contains controls similar to those of the
    ///<b>Print</b> dialog box. The system uses the specified template to create a window that is a child of the
    ///<b>General</b> page. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLEPRINTTEMPLATEHANDLE"></a><a
    ///id="pd_enableprinttemplatehandle"></a><dl> <dt><b>PD_ENABLEPRINTTEMPLATEHANDLE</b></dt> <dt>0x00010000</dt> </dl>
    ///</td> <td width="60%"> Indicates that the <b>hInstance</b> member identifies a data block that contains a
    ///preloaded dialog box template. This template replaces the default dialog box template in the lower portion of the
    ///<b>General</b> page. The system uses the specified template to create a window that is a child of the
    ///<b>General</b> page. The system ignores the <b>lpPrintTemplateName</b> member if this flag is specified. </td>
    ///</tr> <tr> <td width="40%"><a id="PD_EXCLUSIONFLAGS"></a><a id="pd_exclusionflags"></a><dl>
    ///<dt><b>PD_EXCLUSIONFLAGS</b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>ExclusionFlags</b> member identifies items to be excluded from the printer driver property pages. If this flag
    ///is not set, items will be excluded by default from the printer driver property pages. The exclusions prevent the
    ///duplication of items among the <b>General</b> page, any application-specified pages, and the printer driver
    ///pages. </td> </tr> <tr> <td width="40%"><a id="PD_HIDEPRINTTOFILE"></a><a id="pd_hideprinttofile"></a><dl>
    ///<dt><b>PD_HIDEPRINTTOFILE</b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Hides the <b>Print to
    ///File</b> check box. </td> </tr> <tr> <td width="40%"><a id="PD_NOCURRENTPAGE"></a><a
    ///id="pd_nocurrentpage"></a><dl> <dt><b>PD_NOCURRENTPAGE</b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Current Page</b> radio button. </td> </tr> <tr> <td width="40%"><a id="PD_NOPAGENUMS"></a><a
    ///id="pd_nopagenums"></a><dl> <dt><b>PD_NOPAGENUMS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Pages</b> radio button and the associated edit controls. Also, it causes the <b>Collate</b> check
    ///box to appear in the dialog. </td> </tr> <tr> <td width="40%"><a id="PD_NOSELECTION"></a><a
    ///id="pd_noselection"></a><dl> <dt><b>PD_NOSELECTION</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Selection</b> radio button. </td> </tr> <tr> <td width="40%"><a id="PD_NOWARNING"></a><a
    ///id="pd_nowarning"></a><dl> <dt><b>PD_NOWARNING</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Prevents
    ///the warning message from being displayed when an error occurs. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_PAGENUMS"></a><a id="pd_pagenums"></a><dl> <dt><b>PD_PAGENUMS</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> If this flag is set, the <b>Pages</b> radio button is selected. If none of the <b>PD_PAGENUMS</b>,
    ///<b>PD_SELECTION</b>, or <b>PD_CURRENTPAGE</b> flags is set, the <b>All</b> radio button is selected. If this flag
    ///is set when the PrintDlgEx function returns, the <b>lpPageRanges</b> member indicates the page ranges specified
    ///by the user. </td> </tr> <tr> <td width="40%"><a id="PD_PRINTTOFILE"></a><a id="pd_printtofile"></a><dl>
    ///<dt><b>PD_PRINTTOFILE</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> If this flag is set, the <b>Print
    ///to File</b> check box is selected. If this flag is set when PrintDlgEx returns, the offset indicated by the
    ///<b>wOutputOffset</b> member of the DEVNAMES structure contains the string "FILE:". When you call the StartDoc
    ///function to start the printing operation, specify this "FILE:" string in the <b>lpszOutput</b> member of the
    ///DOCINFO structure. Specifying this string causes the print subsystem to query the user for the name of the output
    ///file. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDC"></a><a id="pd_returndc"></a><dl>
    ///<dt><b>PD_RETURNDC</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Causes PrintDlgEx to return a device
    ///context matching the selections the user made in the property sheet. The device context is returned in
    ///<b>hDC</b>. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDEFAULT"></a><a id="pd_returndefault"></a><dl>
    ///<dt><b>PD_RETURNDEFAULT</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> If this flag is set, the
    ///PrintDlgEx function does not display the property sheet. Instead, it sets the <b>hDevNames</b> and
    ///<b>hDevMode</b> members to handles to DEVNAMES and DEVMODE structures that are initialized for the system default
    ///printer. Both <b>hDevNames</b> and <b>hDevMode</b> must be <b>NULL</b>, or <b>PrintDlgEx</b> returns an error.
    ///</td> </tr> <tr> <td width="40%"><a id="PD_RETURNIC"></a><a id="pd_returnic"></a><dl> <dt><b>PD_RETURNIC</b></dt>
    ///<dt>0x00000200</dt> </dl> </td> <td width="60%"> Similar to the <b>PD_RETURNDC</b> flag, except this flag returns
    ///an information context rather than a device context. If neither <b>PD_RETURNDC</b> nor <b>PD_RETURNIC</b> is
    ///specified, <b>hDC</b> is undefined on output. </td> </tr> <tr> <td width="40%"><a id="PD_SELECTION"></a><a
    ///id="pd_selection"></a><dl> <dt><b>PD_SELECTION</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> If this
    ///flag is set, the <b>Selection</b> radio button is selected. If none of the <b>PD_PAGENUMS</b>,
    ///<b>PD_SELECTION</b>, or <b>PD_CURRENTPAGE</b> flags is set, the <b>All</b> radio button is selected. </td> </tr>
    ///<tr> <td width="40%"><a id="PD_USEDEVMODECOPIES"></a><a id="pd_usedevmodecopies"></a><dl>
    ///<dt><b>PD_USEDEVMODECOPIES</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Same as
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_USEDEVMODECOPIESANDCOLLATE"></a><a id="pd_usedevmodecopiesandcollate"></a><dl>
    ///<dt><b>PD_USEDEVMODECOPIESANDCOLLATE</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> This flag
    ///indicates whether your application supports multiple copies and collation. Set this flag on input to indicate
    ///that your application does not support multiple copies and collation. In this case, the <b>nCopies</b> member of
    ///the <b>PRINTDLGEX</b> structure always returns 1, and <b>PD_COLLATE</b> is never set in the <b>Flags</b> member.
    ///If this flag is not set, the application is responsible for printing and collating multiple copies. In this case,
    ///the <b>nCopies</b> member of the <b>PRINTDLGEX</b> structure indicates the number of copies the user wants to
    ///print, and the <b>PD_COLLATE</b> flag in the <b>Flags</b> member indicates whether the user wants collation.
    ///Regardless of whether this flag is set, an application can determine from <b>nCopies</b> and <b>PD_COLLATE</b>
    ///how many copies to render and whether to print them collated. If this flag is set and the printer driver does not
    ///support multiple copies, the <b>Copies</b> edit control is disabled. Similarly, if this flag is set and the
    ///printer driver does not support collation, the <b>Collate</b> check box is disabled. The <b>dmCopies</b> and
    ///<b>dmCollate</b> members of the DEVMODE structure contain the copies and collate information used by the printer
    ///driver. If this flag is set and the printer driver supports multiple copies, the <b>dmCopies</b> member indicates
    ///the number of copies requested by the user. If this flag is set and the printer driver supports collation, the
    ///<b>dmCollate</b> member of the <b>DEVMODE</b> structure indicates whether the user wants collation. If this flag
    ///is not set, the <b>dmCopies</b> member always returns 1, and the <b>dmCollate</b> member is always zero. In
    ///Windows versions prior to Windows Vista, if this flag is not set by the calling application and the
    ///<b>dmCopies</b> member of the DEVMODE structure is greater than 1, use that value for the number of copies;
    ///otherwise, use the value of the <b>nCopies</b> member of the <b>PRINTDLGEX</b> structure. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_USELARGETEMPLATE"></a><a id="pd_uselargetemplate"></a><dl>
    ///<dt><b>PD_USELARGETEMPLATE</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> Forces the property sheet to
    ///use a large template for the <b>General</b> page. The larger template provides more space for applications that
    ///specify a custom template for the lower portion of the <b>General</b> page. </td> </tr> </table>
    uint            Flags;
    ///Type: <b>DWORD</b>
    uint            Flags2;
    ///Type: <b>DWORD</b> A set of bit flags that can exclude items from the printer driver property pages in the
    ///<b>Print</b> property sheet. This value is used only if the <b>PD_EXCLUSIONFLAGS</b> flag is set in the
    ///<b>Flags</b> member. Exclusion flags should be used only if the item to be excluded will be included on either
    ///the <b>General</b> page or on an application-defined page in the <b>Print</b> property sheet. This member can
    ///specify the following flag.
    uint            ExclusionFlags;
    ///Type: <b>DWORD</b> On input, set this member to the initial number of page ranges specified in the
    ///<b>lpPageRanges</b> array. When the PrintDlgEx function returns, <b>nPageRanges</b> indicates the number of
    ///user-specified page ranges stored in the <b>lpPageRanges</b> array. If the <b>PD_NOPAGENUMS</b> flag is
    ///specified, this value is not valid.
    uint            nPageRanges;
    ///Type: <b>DWORD</b> The size, in array elements, of the <b>lpPageRanges</b> buffer. This value indicates the
    ///maximum number of page ranges that can be stored in the array. If the <b>PD_NOPAGENUMS</b> flag is specified,
    ///this value is not valid. If the <b>PD_NOPAGENUMS</b> flag is not specified, this value must be greater than zero.
    uint            nMaxPageRanges;
    ///Type: <b>LPPRINTPAGERANGE</b> Pointer to a buffer containing an array of PRINTPAGERANGE structures. On input, the
    ///array contains the initial page ranges to display in the <b>Pages</b> edit control. When the PrintDlgEx function
    ///returns, the array contains the page ranges specified by the user. If the <b>PD_NOPAGENUMS</b> flag is specified,
    ///this value is not valid. If the <b>PD_NOPAGENUMS</b> flag is not specified, <b>lpPageRanges</b> must be
    ///non-<b>NULL</b>.
    PRINTPAGERANGE* lpPageRanges;
    ///Type: <b>DWORD</b> The minimum value for the page ranges specified in the <b>Pages</b> edit control. If the
    ///<b>PD_NOPAGENUMS</b> flag is specified, this value is not valid.
    uint            nMinPage;
    ///Type: <b>DWORD</b> The maximum value for the page ranges specified in the <b>Pages</b> edit control. If the
    ///<b>PD_NOPAGENUMS</b> flag is specified, this value is not valid.
    uint            nMaxPage;
    ///Type: <b>DWORD</b> Contains the initial number of copies for the <b>Copies</b> edit control if <b>hDevMode</b> is
    ///<b>NULL</b>; otherwise, the <b>dmCopies</b> member of the DEVMODE structure contains the initial value. When
    ///PrintDlgEx returns, <b>nCopies</b> contains the actual number of copies the application must print. This value
    ///depends on whether the application or the printer driver is responsible for printing multiple copies. If the
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag is set in the <b>Flags</b> member, <b>nCopies</b> is always 1 on
    ///return, and the printer driver is responsible for printing multiple copies. If the flag is not set, the
    ///application is responsible for printing the number of copies specified by <b>nCopies</b>. For more information,
    ///see the description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag.
    uint            nCopies;
    ///Type: <b>HINSTANCE</b> If the <b>PD_ENABLEPRINTTEMPLATE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to the application or module instance that contains the dialog box template named by
    ///the <b>lpPrintTemplateName</b> member. If the <b>PD_ENABLEPRINTTEMPLATEHANDLE</b> flag is set in the <b>Flags</b>
    ///member, <b>hInstance</b> is a handle to a memory object containing a dialog box template. If neither of the
    ///template flags is set in the <b>Flags</b> member, <b>hInstance</b> should be <b>NULL</b>.
    HINSTANCE       hInstance;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template replaces the default dialog box template in the lower portion of the
    ///<b>General</b> page. The default template contains controls similar to those of the <b>Print</b> dialog box. This
    ///member is ignored unless the PD_ENABLEPRINTTEMPLATE flag is set in the <b>Flags</b> member.
    const(PSTR)     lpPrintTemplateName;
    ///Type: <b>LPUNKNOWN</b> A pointer to an application-defined callback object. The object should contain the
    ///IPrintDialogCallback class to receive messages for the child dialog box in the lower portion of the
    ///<b>General</b> page. The callback object should also contain the IObjectWithSite class to receive a pointer to
    ///the IPrintDialogServices interface. The PrintDlgEx function calls IUnknown::QueryInterface on the callback object
    ///for both <b>IID_IPrintDialogCallback</b> and <b>IID_IObjectWithSite</b> to determine which interfaces are
    ///supported. If you do not want to retrieve any of the callback information, set <b>lpCallback</b> to <b>NULL</b>.
    IUnknown        lpCallback;
    ///Type: <b>DWORD</b> The number of property page handles in the <b>lphPropertyPages</b> array.
    uint            nPropertyPages;
    ///Type: <b>HPROPSHEETPAGE*</b> Contains an array of property page handles to add to the <b>Print</b> property
    ///sheet. The additional property pages follow the <b>General</b> page. Use the CreatePropertySheetPage function to
    ///create these additional pages. When the PrintDlgEx function returns, all the <b>HPROPSHEETPAGE</b> handles in the
    ///<b>lphPropertyPages</b> array have been destroyed. If <b>nPropertyPages</b> is zero, <b>lphPropertyPages</b>
    ///should be <b>NULL</b>.
    HPROPSHEETPAGE* lphPropertyPages;
    ///Type: <b>DWORD</b> The property page that is initially displayed. To display the <b>General</b> page, specify
    ///<b>START_PAGE_GENERAL</b>. Otherwise, specify the zero-based index of a property page in the array specified in
    ///the <b>lphPropertyPages</b> member. For consistency, it is recommended that the property sheet always be started
    ///on the <b>General</b> page.
    uint            nStartPage;
    ///Type: <b>DWORD</b> On input, set this member to zero. If the PrintDlgEx function returns S_OK,
    ///<b>dwResultAction</b> contains the outcome of the dialog. If <b>PrintDlgEx</b> returns an error, this member
    ///should be ignored. The <b>dwResultAction</b> member can be one of the following values.
    uint            dwResultAction;
}

///Contains information that the PrintDlgEx function uses to initialize the Print property sheet. After the user closes
///the property sheet, the system uses this structure to return information about the user's selections.
struct PRINTDLGEXW
{
align (1):
    ///Type: <b>DWORD</b> The structure size, in bytes.
    uint            lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the property sheet. This member must be a valid window handle;
    ///it cannot be <b>NULL</b>.
    HWND            hwndOwner;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVMODE structure. If
    ///<b>hDevMode</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVMODE</b>
    ///structure and initialize its members. The PrintDlgEx function uses the input data to initialize the controls in
    ///the property sheet. When <b>PrintDlgEx</b> returns, the <b>DEVMODE</b> members indicate the user's input. If
    ///<b>hDevMode</b> is <b>NULL</b> on input, PrintDlgEx allocates memory for the DEVMODE structure, initializes its
    ///members to indicate the user's input, and returns a handle that identifies it. For more information about the
    ///<b>hDevMode</b> and <b>hDevNames</b> members, see the Remarks section at the end of this topic.
    ptrdiff_t       hDevMode;
    ///Type: <b>HGLOBAL</b> A handle to a movable global memory object that contains a DEVNAMES structure. If
    ///<b>hDevNames</b> is not <b>NULL</b> on input, you must allocate a movable block of memory for the <b>DEVNAMES</b>
    ///structure and initialize its members. The PrintDlgEx function uses the input data to initialize the controls in
    ///the property sheet. When <b>PrintDlgEx</b> returns, the <b>DEVNAMES</b> members contain information for the
    ///printer chosen by the user. You can use this information to create a device context or an information context.
    ///The <b>hDevNames</b> member can be <b>NULL</b>, in which case, PrintDlgEx allocates memory for the DEVNAMES
    ///structure, initializes its members to indicate the user's input, and returns a handle that identifies it. For
    ///more information about the <b>hDevMode</b> and <b>hDevNames</b> members, see the Remarks section at the end of
    ///this topic.
    ptrdiff_t       hDevNames;
    ///Type: <b>HDC</b> A handle to a device context or an information context, depending on whether the <b>Flags</b>
    ///member specifies the <b>PD_RETURNDC</b> or <b>PC_RETURNIC</b> flag. If neither flag is specified, the value of
    ///this member is undefined. If both flags are specified, <b>PD_RETURNDC</b> has priority.
    HDC             hDC;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Print</b> property sheet. When the
    ///PrintDlgEx function returns, it sets these flags to indicate the user's input. This member can be one or more of
    ///the following values. To ensure that PrintDlg or PrintDlgEx returns the correct values in the <b>dmCopies</b> and
    ///<b>dmCollate</b> members of the DEVMODE structure, set <b>PD_RETURNDC</b> = <b>TRUE</b> and
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>TRUE</b>. In so doing, the <b>nCopies</b> member of the PRINTDLG
    ///structure is always 1 and <b>PD_COLLATE</b> is always <b>FALSE</b>. To ensure that PrintDlg or PrintDlgEx returns
    ///the correct values in <b>nCopies</b> and <b>PD_COLLATE</b>, set <b>PD_RETURNDC</b> = <b>TRUE</b> and
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> = <b>FALSE</b>. In so doing, <b>dmCopies</b> is always 1 and
    ///<b>dmCollate</b> is always <b>FALSE</b>. Starting with Windows Vista, when you call PrintDlg or PrintDlgEx with
    ///<b>PD_RETURNDC</b> set to <b>TRUE</b> and <b>PD_USEDEVMODECOPIESANDCOLLATE</b> set to <b>FALSE</b>, the
    ///<b>PrintDlg</b> or <b>PrintDlgEx</b> function sets the number of copies in the <b>nCopies</b> member of the
    ///PRINTDLG structure, and it sets the number of copies in the structure represented by the <b>hDC</b> member of the
    ///<b>PRINTDLG</b> structure. When making calls to GDI, you must ignore the value of <b>nCopies</b>, consider the
    ///value as 1, and use the returned <b>hDC</b> to avoid printing duplicate copies. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PD_ALLPAGES"></a><a id="pd_allpages"></a><dl>
    ///<dt><b>PD_ALLPAGES</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The default flag that indicates that
    ///the <b>All</b> radio button is initially selected. This flag is used as a placeholder to indicate that the
    ///<b>PD_PAGENUMS</b>, <b>PD_SELECTION</b>, and <b>PD_CURRENTPAGE</b> flags are not specified. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_COLLATE"></a><a id="pd_collate"></a><dl> <dt><b>PD_COLLATE</b></dt> <dt>0x00000010</dt>
    ///</dl> </td> <td width="60%"> If this flag is set, the <b>Collate</b> check box is selected. If this flag is set
    ///when the PrintDlgEx function returns, the application must simulate collation of multiple copies. For more
    ///information, see the description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag. See <b>PD_NOPAGENUMS</b>.
    ///</td> </tr> <tr> <td width="40%"><a id="PD_CURRENTPAGE"></a><a id="pd_currentpage"></a><dl>
    ///<dt><b>PD_CURRENTPAGE</b></dt> <dt>0x00400000</dt> </dl> </td> <td width="60%"> If this flag is set, the
    ///<b>Current Page</b> radio button is selected. If none of the <b>PD_PAGENUMS</b>, <b>PD_SELECTION</b>, or
    ///<b>PD_CURRENTPAGE</b> flags is set, the <b>All</b> radio button is selected. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_DISABLEPRINTTOFILE"></a><a id="pd_disableprinttofile"></a><dl> <dt><b>PD_DISABLEPRINTTOFILE</b></dt>
    ///<dt>0x00080000</dt> </dl> </td> <td width="60%"> Disables the <b>Print to File</b> check box. </td> </tr> <tr>
    ///<td width="40%"><a id="PD_ENABLEPRINTTEMPLATE"></a><a id="pd_enableprinttemplate"></a><dl>
    ///<dt><b>PD_ENABLEPRINTTEMPLATE</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hInstance</b> and <b>lpPrintTemplateName</b> members specify a replacement for the default dialog box template
    ///in the lower portion of the <b>General</b> page. The default template contains controls similar to those of the
    ///<b>Print</b> dialog box. The system uses the specified template to create a window that is a child of the
    ///<b>General</b> page. </td> </tr> <tr> <td width="40%"><a id="PD_ENABLEPRINTTEMPLATEHANDLE"></a><a
    ///id="pd_enableprinttemplatehandle"></a><dl> <dt><b>PD_ENABLEPRINTTEMPLATEHANDLE</b></dt> <dt>0x00010000</dt> </dl>
    ///</td> <td width="60%"> Indicates that the <b>hInstance</b> member identifies a data block that contains a
    ///preloaded dialog box template. This template replaces the default dialog box template in the lower portion of the
    ///<b>General</b> page. The system uses the specified template to create a window that is a child of the
    ///<b>General</b> page. The system ignores the <b>lpPrintTemplateName</b> member if this flag is specified. </td>
    ///</tr> <tr> <td width="40%"><a id="PD_EXCLUSIONFLAGS"></a><a id="pd_exclusionflags"></a><dl>
    ///<dt><b>PD_EXCLUSIONFLAGS</b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>ExclusionFlags</b> member identifies items to be excluded from the printer driver property pages. If this flag
    ///is not set, items will be excluded by default from the printer driver property pages. The exclusions prevent the
    ///duplication of items among the <b>General</b> page, any application-specified pages, and the printer driver
    ///pages. </td> </tr> <tr> <td width="40%"><a id="PD_HIDEPRINTTOFILE"></a><a id="pd_hideprinttofile"></a><dl>
    ///<dt><b>PD_HIDEPRINTTOFILE</b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Hides the <b>Print to
    ///File</b> check box. </td> </tr> <tr> <td width="40%"><a id="PD_NOCURRENTPAGE"></a><a
    ///id="pd_nocurrentpage"></a><dl> <dt><b>PD_NOCURRENTPAGE</b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Current Page</b> radio button. </td> </tr> <tr> <td width="40%"><a id="PD_NOPAGENUMS"></a><a
    ///id="pd_nopagenums"></a><dl> <dt><b>PD_NOPAGENUMS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Pages</b> radio button and the associated edit controls. Also, it causes the <b>Collate</b> check
    ///box to appear in the dialog. </td> </tr> <tr> <td width="40%"><a id="PD_NOSELECTION"></a><a
    ///id="pd_noselection"></a><dl> <dt><b>PD_NOSELECTION</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
    ///Disables the <b>Selection</b> radio button. </td> </tr> <tr> <td width="40%"><a id="PD_NOWARNING"></a><a
    ///id="pd_nowarning"></a><dl> <dt><b>PD_NOWARNING</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Prevents
    ///the warning message from being displayed when an error occurs. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_PAGENUMS"></a><a id="pd_pagenums"></a><dl> <dt><b>PD_PAGENUMS</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> If this flag is set, the <b>Pages</b> radio button is selected. If none of the <b>PD_PAGENUMS</b>,
    ///<b>PD_SELECTION</b>, or <b>PD_CURRENTPAGE</b> flags is set, the <b>All</b> radio button is selected. If this flag
    ///is set when the PrintDlgEx function returns, the <b>lpPageRanges</b> member indicates the page ranges specified
    ///by the user. </td> </tr> <tr> <td width="40%"><a id="PD_PRINTTOFILE"></a><a id="pd_printtofile"></a><dl>
    ///<dt><b>PD_PRINTTOFILE</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> If this flag is set, the <b>Print
    ///to File</b> check box is selected. If this flag is set when PrintDlgEx returns, the offset indicated by the
    ///<b>wOutputOffset</b> member of the DEVNAMES structure contains the string "FILE:". When you call the StartDoc
    ///function to start the printing operation, specify this "FILE:" string in the <b>lpszOutput</b> member of the
    ///DOCINFO structure. Specifying this string causes the print subsystem to query the user for the name of the output
    ///file. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDC"></a><a id="pd_returndc"></a><dl>
    ///<dt><b>PD_RETURNDC</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> Causes PrintDlgEx to return a device
    ///context matching the selections the user made in the property sheet. The device context is returned in
    ///<b>hDC</b>. </td> </tr> <tr> <td width="40%"><a id="PD_RETURNDEFAULT"></a><a id="pd_returndefault"></a><dl>
    ///<dt><b>PD_RETURNDEFAULT</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> If this flag is set, the
    ///PrintDlgEx function does not display the property sheet. Instead, it sets the <b>hDevNames</b> and
    ///<b>hDevMode</b> members to handles to DEVNAMES and DEVMODE structures that are initialized for the system default
    ///printer. Both <b>hDevNames</b> and <b>hDevMode</b> must be <b>NULL</b>, or <b>PrintDlgEx</b> returns an error.
    ///</td> </tr> <tr> <td width="40%"><a id="PD_RETURNIC"></a><a id="pd_returnic"></a><dl> <dt><b>PD_RETURNIC</b></dt>
    ///<dt>0x00000200</dt> </dl> </td> <td width="60%"> Similar to the <b>PD_RETURNDC</b> flag, except this flag returns
    ///an information context rather than a device context. If neither <b>PD_RETURNDC</b> nor <b>PD_RETURNIC</b> is
    ///specified, <b>hDC</b> is undefined on output. </td> </tr> <tr> <td width="40%"><a id="PD_SELECTION"></a><a
    ///id="pd_selection"></a><dl> <dt><b>PD_SELECTION</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> If this
    ///flag is set, the <b>Selection</b> radio button is selected. If none of the <b>PD_PAGENUMS</b>,
    ///<b>PD_SELECTION</b>, or <b>PD_CURRENTPAGE</b> flags is set, the <b>All</b> radio button is selected. </td> </tr>
    ///<tr> <td width="40%"><a id="PD_USEDEVMODECOPIES"></a><a id="pd_usedevmodecopies"></a><dl>
    ///<dt><b>PD_USEDEVMODECOPIES</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Same as
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="PD_USEDEVMODECOPIESANDCOLLATE"></a><a id="pd_usedevmodecopiesandcollate"></a><dl>
    ///<dt><b>PD_USEDEVMODECOPIESANDCOLLATE</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> This flag
    ///indicates whether your application supports multiple copies and collation. Set this flag on input to indicate
    ///that your application does not support multiple copies and collation. In this case, the <b>nCopies</b> member of
    ///the <b>PRINTDLGEX</b> structure always returns 1, and <b>PD_COLLATE</b> is never set in the <b>Flags</b> member.
    ///If this flag is not set, the application is responsible for printing and collating multiple copies. In this case,
    ///the <b>nCopies</b> member of the <b>PRINTDLGEX</b> structure indicates the number of copies the user wants to
    ///print, and the <b>PD_COLLATE</b> flag in the <b>Flags</b> member indicates whether the user wants collation.
    ///Regardless of whether this flag is set, an application can determine from <b>nCopies</b> and <b>PD_COLLATE</b>
    ///how many copies to render and whether to print them collated. If this flag is set and the printer driver does not
    ///support multiple copies, the <b>Copies</b> edit control is disabled. Similarly, if this flag is set and the
    ///printer driver does not support collation, the <b>Collate</b> check box is disabled. The <b>dmCopies</b> and
    ///<b>dmCollate</b> members of the DEVMODE structure contain the copies and collate information used by the printer
    ///driver. If this flag is set and the printer driver supports multiple copies, the <b>dmCopies</b> member indicates
    ///the number of copies requested by the user. If this flag is set and the printer driver supports collation, the
    ///<b>dmCollate</b> member of the <b>DEVMODE</b> structure indicates whether the user wants collation. If this flag
    ///is not set, the <b>dmCopies</b> member always returns 1, and the <b>dmCollate</b> member is always zero. In
    ///Windows versions prior to Windows Vista, if this flag is not set by the calling application and the
    ///<b>dmCopies</b> member of the DEVMODE structure is greater than 1, use that value for the number of copies;
    ///otherwise, use the value of the <b>nCopies</b> member of the <b>PRINTDLGEX</b> structure. </td> </tr> <tr> <td
    ///width="40%"><a id="PD_USELARGETEMPLATE"></a><a id="pd_uselargetemplate"></a><dl>
    ///<dt><b>PD_USELARGETEMPLATE</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> Forces the property sheet to
    ///use a large template for the <b>General</b> page. The larger template provides more space for applications that
    ///specify a custom template for the lower portion of the <b>General</b> page. </td> </tr> </table>
    uint            Flags;
    ///Type: <b>DWORD</b>
    uint            Flags2;
    ///Type: <b>DWORD</b> A set of bit flags that can exclude items from the printer driver property pages in the
    ///<b>Print</b> property sheet. This value is used only if the <b>PD_EXCLUSIONFLAGS</b> flag is set in the
    ///<b>Flags</b> member. Exclusion flags should be used only if the item to be excluded will be included on either
    ///the <b>General</b> page or on an application-defined page in the <b>Print</b> property sheet. This member can
    ///specify the following flag.
    uint            ExclusionFlags;
    ///Type: <b>DWORD</b> On input, set this member to the initial number of page ranges specified in the
    ///<b>lpPageRanges</b> array. When the PrintDlgEx function returns, <b>nPageRanges</b> indicates the number of
    ///user-specified page ranges stored in the <b>lpPageRanges</b> array. If the <b>PD_NOPAGENUMS</b> flag is
    ///specified, this value is not valid.
    uint            nPageRanges;
    ///Type: <b>DWORD</b> The size, in array elements, of the <b>lpPageRanges</b> buffer. This value indicates the
    ///maximum number of page ranges that can be stored in the array. If the <b>PD_NOPAGENUMS</b> flag is specified,
    ///this value is not valid. If the <b>PD_NOPAGENUMS</b> flag is not specified, this value must be greater than zero.
    uint            nMaxPageRanges;
    ///Type: <b>LPPRINTPAGERANGE</b> Pointer to a buffer containing an array of PRINTPAGERANGE structures. On input, the
    ///array contains the initial page ranges to display in the <b>Pages</b> edit control. When the PrintDlgEx function
    ///returns, the array contains the page ranges specified by the user. If the <b>PD_NOPAGENUMS</b> flag is specified,
    ///this value is not valid. If the <b>PD_NOPAGENUMS</b> flag is not specified, <b>lpPageRanges</b> must be
    ///non-<b>NULL</b>.
    PRINTPAGERANGE* lpPageRanges;
    ///Type: <b>DWORD</b> The minimum value for the page ranges specified in the <b>Pages</b> edit control. If the
    ///<b>PD_NOPAGENUMS</b> flag is specified, this value is not valid.
    uint            nMinPage;
    ///Type: <b>DWORD</b> The maximum value for the page ranges specified in the <b>Pages</b> edit control. If the
    ///<b>PD_NOPAGENUMS</b> flag is specified, this value is not valid.
    uint            nMaxPage;
    ///Type: <b>DWORD</b> Contains the initial number of copies for the <b>Copies</b> edit control if <b>hDevMode</b> is
    ///<b>NULL</b>; otherwise, the <b>dmCopies</b> member of the DEVMODE structure contains the initial value. When
    ///PrintDlgEx returns, <b>nCopies</b> contains the actual number of copies the application must print. This value
    ///depends on whether the application or the printer driver is responsible for printing multiple copies. If the
    ///<b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag is set in the <b>Flags</b> member, <b>nCopies</b> is always 1 on
    ///return, and the printer driver is responsible for printing multiple copies. If the flag is not set, the
    ///application is responsible for printing the number of copies specified by <b>nCopies</b>. For more information,
    ///see the description of the <b>PD_USEDEVMODECOPIESANDCOLLATE</b> flag.
    uint            nCopies;
    ///Type: <b>HINSTANCE</b> If the <b>PD_ENABLEPRINTTEMPLATE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to the application or module instance that contains the dialog box template named by
    ///the <b>lpPrintTemplateName</b> member. If the <b>PD_ENABLEPRINTTEMPLATEHANDLE</b> flag is set in the <b>Flags</b>
    ///member, <b>hInstance</b> is a handle to a memory object containing a dialog box template. If neither of the
    ///template flags is set in the <b>Flags</b> member, <b>hInstance</b> should be <b>NULL</b>.
    HINSTANCE       hInstance;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template replaces the default dialog box template in the lower portion of the
    ///<b>General</b> page. The default template contains controls similar to those of the <b>Print</b> dialog box. This
    ///member is ignored unless the PD_ENABLEPRINTTEMPLATE flag is set in the <b>Flags</b> member.
    const(PWSTR)    lpPrintTemplateName;
    ///Type: <b>LPUNKNOWN</b> A pointer to an application-defined callback object. The object should contain the
    ///IPrintDialogCallback class to receive messages for the child dialog box in the lower portion of the
    ///<b>General</b> page. The callback object should also contain the IObjectWithSite class to receive a pointer to
    ///the IPrintDialogServices interface. The PrintDlgEx function calls IUnknown::QueryInterface on the callback object
    ///for both <b>IID_IPrintDialogCallback</b> and <b>IID_IObjectWithSite</b> to determine which interfaces are
    ///supported. If you do not want to retrieve any of the callback information, set <b>lpCallback</b> to <b>NULL</b>.
    IUnknown        lpCallback;
    ///Type: <b>DWORD</b> The number of property page handles in the <b>lphPropertyPages</b> array.
    uint            nPropertyPages;
    ///Type: <b>HPROPSHEETPAGE*</b> Contains an array of property page handles to add to the <b>Print</b> property
    ///sheet. The additional property pages follow the <b>General</b> page. Use the CreatePropertySheetPage function to
    ///create these additional pages. When the PrintDlgEx function returns, all the <b>HPROPSHEETPAGE</b> handles in the
    ///<b>lphPropertyPages</b> array have been destroyed. If <b>nPropertyPages</b> is zero, <b>lphPropertyPages</b>
    ///should be <b>NULL</b>.
    HPROPSHEETPAGE* lphPropertyPages;
    ///Type: <b>DWORD</b> The property page that is initially displayed. To display the <b>General</b> page, specify
    ///<b>START_PAGE_GENERAL</b>. Otherwise, specify the zero-based index of a property page in the array specified in
    ///the <b>lphPropertyPages</b> member. For consistency, it is recommended that the property sheet always be started
    ///on the <b>General</b> page.
    uint            nStartPage;
    ///Type: <b>DWORD</b> On input, set this member to zero. If the PrintDlgEx function returns S_OK,
    ///<b>dwResultAction</b> contains the outcome of the dialog. If <b>PrintDlgEx</b> returns an error, this member
    ///should be ignored. The <b>dwResultAction</b> member can be one of the following values.
    uint            dwResultAction;
}

///Contains strings that identify the driver, device, and output port names for a printer. These strings must be ANSI
///strings when the ANSI version of PrintDlg or PrintDlgEx is used, and must be Unicode strings when the Unicode version
///of <b>PrintDlg</b> or <b>PrintDlgEx</b> is used. The <b>PrintDlgEx</b> and <b>PrintDlg</b> functions use these
///strings to initialize the system-defined Print Property Sheet or Print Dialog Box. When the user closes the property
///sheet or dialog box, information about the selected printer is returned in this structure.
struct DEVNAMES
{
align (1):
    ///Type: <b>WORD</b> The offset, in characters, from the beginning of this structure to a null-terminated string
    ///that contains the file name (without the extension) of the device driver. On input, this string is used to
    ///determine the printer to display initially in the dialog box.
    ushort wDriverOffset;
    ///Type: <b>WORD</b> The offset, in characters, from the beginning of this structure to the null-terminated string
    ///that contains the name of the device.
    ushort wDeviceOffset;
    ///Type: <b>WORD</b> The offset, in characters, from the beginning of this structure to the null-terminated string
    ///that contains the device name for the physical output medium (output port).
    ushort wOutputOffset;
    ///Type: <b>WORD</b> Indicates whether the strings contained in the <b>DEVNAMES</b> structure identify the default
    ///printer. This string is used to verify that the default printer has not changed since the last print operation.
    ///If any of the strings do not match, a warning message is displayed informing the user that the document may need
    ///to be reformatted. On output, the <b>wDefault</b> member is changed only if the <b>Print Setup</b> dialog box was
    ///displayed and the user chose the <b>OK</b> button. The <b>DN_DEFAULTPRN</b> flag is used if the default printer
    ///was selected. If a specific printer is selected, the flag is not used. All other flags in this member are
    ///reserved for internal use by the dialog box procedure for the <b>Print</b> property sheet or <b>Print</b> dialog
    ///box.
    ushort wDefault;
}

///Contains information the PageSetupDlg function uses to initialize the <b>Page Setup</b> dialog box. After the user
///closes the dialog box, the system returns information about the user-defined page parameters in this structure.
struct PAGESETUPDLGA
{
align (1):
    ///Type: <b>DWORD</b> The size, in bytes, of this structure.
    uint            lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND            hwndOwner;
    ///Type: <b>HGLOBAL</b> A handle to a global memory object that contains a DEVMODE structure. On input, if a handle
    ///is specified, the values in the corresponding <b>DEVMODE</b> structure are used to initialize the controls in the
    ///dialog box. On output, the dialog box sets <b>hDevMode</b> to a global memory handle to a <b>DEVMODE</b>
    ///structure that contains values specifying the user's selections. If the user's selections are not available, the
    ///dialog box sets <b>hDevMode</b> to <b>NULL</b>.
    ptrdiff_t       hDevMode;
    ///Type: <b>HGLOBAL</b> A handle to a global memory object that contains a DEVNAMES structure. This structure
    ///contains three strings that specify the driver name, the printer name, and the output port name. On input, if a
    ///handle is specified, the strings in the corresponding <b>DEVNAMES</b> structure are used to initialize controls
    ///in the dialog box. On output, the dialog box sets <b>hDevNames</b> to a global memory handle to a <b>DEVNAMES</b>
    ///structure that contains strings specifying the user's selections. If the user's selections are not available, the
    ///dialog box sets <b>hDevNames</b> to <b>NULL</b>.
    ptrdiff_t       hDevNames;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Page Setup</b> dialog box. When the
    ///dialog box returns, it sets these flags to indicate the user's input. This member can be one or more of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PSD_DEFAULTMINMARGINS"></a><a id="psd_defaultminmargins"></a><dl> <dt><b>PSD_DEFAULTMINMARGINS</b></dt>
    ///<dt>0x00000000</dt> </dl> </td> <td width="60%"> Sets the minimum values that the user can specify for the page
    ///margins to be the minimum margins allowed by the printer. This is the default. This flag is ignored if the
    ///<b>PSD_MARGINS</b> and <b>PSD_MINMARGINS</b> flags are also specified. </td> </tr> <tr> <td width="40%"><a
    ///id="PSD_DISABLEMARGINS"></a><a id="psd_disablemargins"></a><dl> <dt><b>PSD_DISABLEMARGINS</b></dt>
    ///<dt>0x00000010</dt> </dl> </td> <td width="60%"> Disables the margin controls, preventing the user from setting
    ///the margins. </td> </tr> <tr> <td width="40%"><a id="PSD_DISABLEORIENTATION"></a><a
    ///id="psd_disableorientation"></a><dl> <dt><b>PSD_DISABLEORIENTATION</b></dt> <dt>0x00000100</dt> </dl> </td> <td
    ///width="60%"> Disables the orientation controls, preventing the user from setting the page orientation. </td>
    ///</tr> <tr> <td width="40%"><a id="PSD_DISABLEPAGEPAINTING"></a><a id="psd_disablepagepainting"></a><dl>
    ///<dt><b>PSD_DISABLEPAGEPAINTING</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> Prevents the dialog box
    ///from drawing the contents of the sample page. If you enable a PagePaintHook hook procedure, you can still draw
    ///the contents of the sample page. </td> </tr> <tr> <td width="40%"><a id="PSD_DISABLEPAPER"></a><a
    ///id="psd_disablepaper"></a><dl> <dt><b>PSD_DISABLEPAPER</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%">
    ///Disables the paper controls, preventing the user from setting page parameters such as the paper size and source.
    ///</td> </tr> <tr> <td width="40%"><a id="PSD_DISABLEPRINTER"></a><a id="psd_disableprinter"></a><dl>
    ///<dt><b>PSD_DISABLEPRINTER</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Obsolete. <b>Windows XP/2000:
    ///</b>Disables the <b>Printer</b> button, preventing the user from invoking a dialog box that contains additional
    ///printer setup information. </td> </tr> <tr> <td width="40%"><a id="PSD_ENABLEPAGEPAINTHOOK"></a><a
    ///id="psd_enablepagepainthook"></a><dl> <dt><b>PSD_ENABLEPAGEPAINTHOOK</b></dt> <dt>0x00040000</dt> </dl> </td> <td
    ///width="60%"> Enables the hook procedure specified in the <b>lpfnPagePaintHook</b> member. </td> </tr> <tr> <td
    ///width="40%"><a id="PSD_ENABLEPAGESETUPHOOK"></a><a id="psd_enablepagesetuphook"></a><dl>
    ///<dt><b>PSD_ENABLEPAGESETUPHOOK</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> Enables the hook
    ///procedure specified in the <b>lpfnPageSetupHook</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="PSD_ENABLEPAGESETUPTEMPLATE"></a><a id="psd_enablepagesetuptemplate"></a><dl>
    ///<dt><b>PSD_ENABLEPAGESETUPTEMPLATE</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hInstance</b> and <b>lpPageSetupTemplateName</b> members specify a dialog box template to use in place of the
    ///default template. </td> </tr> <tr> <td width="40%"><a id="PSD_ENABLEPAGESETUPTEMPLATEHANDLE"></a><a
    ///id="psd_enablepagesetuptemplatehandle"></a><dl> <dt><b>PSD_ENABLEPAGESETUPTEMPLATEHANDLE</b></dt>
    ///<dt>0x00020000</dt> </dl> </td> <td width="60%"> Indicates that the <b>hPageSetupTemplate</b> member identifies a
    ///data block that contains a preloaded dialog box template. The system ignores the <b>lpPageSetupTemplateName</b>
    ///member if this flag is specified. </td> </tr> <tr> <td width="40%"><a id="PSD_INHUNDREDTHSOFMILLIMETERS"></a><a
    ///id="psd_inhundredthsofmillimeters"></a><dl> <dt><b>PSD_INHUNDREDTHSOFMILLIMETERS</b></dt> <dt>0x00000008</dt>
    ///</dl> </td> <td width="60%"> Indicates that hundredths of millimeters are the unit of measurement for margins and
    ///paper size. The values in the <b>rtMargin</b>, <b>rtMinMargin</b>, and <b>ptPaperSize</b> members are in
    ///hundredths of millimeters. You can set this flag on input to override the default unit of measurement for the
    ///user's locale. When the function returns, the dialog box sets this flag to indicate the units used. </td> </tr>
    ///<tr> <td width="40%"><a id="PSD_INTHOUSANDTHSOFINCHES"></a><a id="psd_inthousandthsofinches"></a><dl>
    ///<dt><b>PSD_INTHOUSANDTHSOFINCHES</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Indicates that
    ///thousandths of inches are the unit of measurement for margins and paper size. The values in the <b>rtMargin</b>,
    ///<b>rtMinMargin</b>, and <b>ptPaperSize</b> members are in thousandths of inches. You can set this flag on input
    ///to override the default unit of measurement for the user's locale. When the function returns, the dialog box sets
    ///this flag to indicate the units used. </td> </tr> <tr> <td width="40%"><a id="PSD_INWININIINTLMEASURE"></a><a
    ///id="psd_inwininiintlmeasure"></a><dl> <dt><b>PSD_INWININIINTLMEASURE</b></dt> <dt>0x00000000</dt> </dl> </td> <td
    ///width="60%"> Reserved. </td> </tr> <tr> <td width="40%"><a id="PSD_MARGINS"></a><a id="psd_margins"></a><dl>
    ///<dt><b>PSD_MARGINS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Causes the system to use the values
    ///specified in the <b>rtMargin</b> member as the initial widths for the left, top, right, and bottom margins. If
    ///<b>PSD_MARGINS</b> is not set, the system sets the initial widths to one inch for all margins. </td> </tr> <tr>
    ///<td width="40%"><a id="PSD_MINMARGINS"></a><a id="psd_minmargins"></a><dl> <dt><b>PSD_MINMARGINS</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> Causes the system to use the values specified in the
    ///<b>rtMinMargin</b> member as the minimum allowable widths for the left, top, right, and bottom margins. The
    ///system prevents the user from entering a width that is less than the specified minimum. If <b>PSD_MINMARGINS</b>
    ///is not specified, the system sets the minimum allowable widths to those allowed by the printer. </td> </tr> <tr>
    ///<td width="40%"><a id="PSD_NONETWORKBUTTON"></a><a id="psd_nonetworkbutton"></a><dl>
    ///<dt><b>PSD_NONETWORKBUTTON</b></dt> <dt>0x00200000</dt> </dl> </td> <td width="60%"> Hides and disables the
    ///<b>Network</b> button. </td> </tr> <tr> <td width="40%"><a id="PSD_NOWARNING"></a><a id="psd_nowarning"></a><dl>
    ///<dt><b>PSD_NOWARNING</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Prevents the system from
    ///displaying a warning message when there is no default printer. </td> </tr> <tr> <td width="40%"><a
    ///id="PSD_RETURNDEFAULT"></a><a id="psd_returndefault"></a><dl> <dt><b>PSD_RETURNDEFAULT</b></dt>
    ///<dt>0x00000400</dt> </dl> </td> <td width="60%"> PageSetupDlg does not display the dialog box. Instead, it sets
    ///the <b>hDevNames</b> and <b>hDevMode</b> members to handles to DEVMODE and DEVNAMES structures that are
    ///initialized for the system default printer. <b>PageSetupDlg</b> returns an error if either <b>hDevNames</b> or
    ///<b>hDevMode</b> is not <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="PSD_SHOWHELP"></a><a
    ///id="psd_showhelp"></a><dl> <dt><b>PSD_SHOWHELP</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> Causes
    ///the dialog box to display the <b>Help</b> button. The <b>hwndOwner</b> member must specify the window to receive
    ///the HELPMSGSTRING registered messages that the dialog box sends when the user clicks the <b>Help</b> button.
    ///</td> </tr> </table>
    uint            Flags;
    ///Type: <b>POINT</b> The dimensions of the paper selected by the user. The <b>PSD_INTHOUSANDTHSOFINCHES</b> or
    ///<b>PSD_INHUNDREDTHSOFMILLIMETERS</b> flag indicates the units of measurement.
    POINT           ptPaperSize;
    ///Type: <b>RECT</b> The minimum allowable widths for the left, top, right, and bottom margins. The system ignores
    ///this member if the <b>PSD_MINMARGINS</b> flag is not set. These values must be less than or equal to the values
    ///specified in the <b>rtMargin</b> member. The <b>PSD_INTHOUSANDTHSOFINCHES</b> or
    ///<b>PSD_INHUNDREDTHSOFMILLIMETERS</b> flag indicates the units of measurement.
    RECT            rtMinMargin;
    ///Type: <b>RECT</b> The widths of the left, top, right, and bottom margins. If you set the <b>PSD_MARGINS</b> flag,
    ///<b>rtMargin</b> specifies the initial margin values. When PageSetupDlg returns, <b>rtMargin</b> contains the
    ///margin widths selected by the user. The <b>PSD_INHUNDREDTHSOFMILLIMETERS</b> or <b>PSD_INTHOUSANDTHSOFINCHES</b>
    ///flag indicates the units of measurement.
    RECT            rtMargin;
    ///Type: <b>HINSTANCE</b> If the <b>PSD_ENABLEPAGESETUPTEMPLATE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to the application or module instance that contains the dialog box template named by
    ///the <b>lpPageSetupTemplateName</b> member.
    HINSTANCE       hInstance;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnPageSetupHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the
    ///message's <i>lParam</i> parameter is a pointer to the <b>PAGESETUPDLG</b> structure specified when the dialog was
    ///created. The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM          lCustData;
    ///Type: <b>LPPAGESETUPHOOK</b> A pointer to a PageSetupHook hook procedure that can process messages intended for
    ///the dialog box. This member is ignored unless the <b>PSD_ENABLEPAGESETUPHOOK</b> flag is set in the <b>Flags</b>
    ///member.
    LPPAGESETUPHOOK lpfnPageSetupHook;
    ///Type: <b>LPPAGEPAINTHOOK</b> A pointer to a PagePaintHook hook procedure that receives <b>WM_PSD_*</b> messages
    ///from the dialog box whenever the sample page is redrawn. By processing the messages, the hook procedure can
    ///customize the appearance of the sample page. This member is ignored unless the <b>PSD_ENABLEPAGEPAINTHOOK</b>
    ///flag is set in the <b>Flags</b> member.
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, <b>lpPageSetupTemplateName</b> can be a value returned by the MAKEINTRESOURCE macro. This member
    ///is ignored unless the <b>PSD_ENABLEPAGESETUPTEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PSTR)     lpPageSetupTemplateName;
    ///Type: <b>HGLOBAL</b> If the <b>PSD_ENABLEPAGESETUPTEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hPageSetupTemplate</b> is a handle to a memory object containing a dialog box template.
    ptrdiff_t       hPageSetupTemplate;
}

///Contains information the PageSetupDlg function uses to initialize the <b>Page Setup</b> dialog box. After the user
///closes the dialog box, the system returns information about the user-defined page parameters in this structure.
struct PAGESETUPDLGW
{
align (1):
    ///Type: <b>DWORD</b> The size, in bytes, of this structure.
    uint            lStructSize;
    ///Type: <b>HWND</b> A handle to the window that owns the dialog box. This member can be any valid window handle, or
    ///it can be <b>NULL</b> if the dialog box has no owner.
    HWND            hwndOwner;
    ///Type: <b>HGLOBAL</b> A handle to a global memory object that contains a DEVMODE structure. On input, if a handle
    ///is specified, the values in the corresponding <b>DEVMODE</b> structure are used to initialize the controls in the
    ///dialog box. On output, the dialog box sets <b>hDevMode</b> to a global memory handle to a <b>DEVMODE</b>
    ///structure that contains values specifying the user's selections. If the user's selections are not available, the
    ///dialog box sets <b>hDevMode</b> to <b>NULL</b>.
    ptrdiff_t       hDevMode;
    ///Type: <b>HGLOBAL</b> A handle to a global memory object that contains a DEVNAMES structure. This structure
    ///contains three strings that specify the driver name, the printer name, and the output port name. On input, if a
    ///handle is specified, the strings in the corresponding <b>DEVNAMES</b> structure are used to initialize controls
    ///in the dialog box. On output, the dialog box sets <b>hDevNames</b> to a global memory handle to a <b>DEVNAMES</b>
    ///structure that contains strings specifying the user's selections. If the user's selections are not available, the
    ///dialog box sets <b>hDevNames</b> to <b>NULL</b>.
    ptrdiff_t       hDevNames;
    ///Type: <b>DWORD</b> A set of bit flags that you can use to initialize the <b>Page Setup</b> dialog box. When the
    ///dialog box returns, it sets these flags to indicate the user's input. This member can be one or more of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PSD_DEFAULTMINMARGINS"></a><a id="psd_defaultminmargins"></a><dl> <dt><b>PSD_DEFAULTMINMARGINS</b></dt>
    ///<dt>0x00000000</dt> </dl> </td> <td width="60%"> Sets the minimum values that the user can specify for the page
    ///margins to be the minimum margins allowed by the printer. This is the default. This flag is ignored if the
    ///<b>PSD_MARGINS</b> and <b>PSD_MINMARGINS</b> flags are also specified. </td> </tr> <tr> <td width="40%"><a
    ///id="PSD_DISABLEMARGINS"></a><a id="psd_disablemargins"></a><dl> <dt><b>PSD_DISABLEMARGINS</b></dt>
    ///<dt>0x00000010</dt> </dl> </td> <td width="60%"> Disables the margin controls, preventing the user from setting
    ///the margins. </td> </tr> <tr> <td width="40%"><a id="PSD_DISABLEORIENTATION"></a><a
    ///id="psd_disableorientation"></a><dl> <dt><b>PSD_DISABLEORIENTATION</b></dt> <dt>0x00000100</dt> </dl> </td> <td
    ///width="60%"> Disables the orientation controls, preventing the user from setting the page orientation. </td>
    ///</tr> <tr> <td width="40%"><a id="PSD_DISABLEPAGEPAINTING"></a><a id="psd_disablepagepainting"></a><dl>
    ///<dt><b>PSD_DISABLEPAGEPAINTING</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> Prevents the dialog box
    ///from drawing the contents of the sample page. If you enable a PagePaintHook hook procedure, you can still draw
    ///the contents of the sample page. </td> </tr> <tr> <td width="40%"><a id="PSD_DISABLEPAPER"></a><a
    ///id="psd_disablepaper"></a><dl> <dt><b>PSD_DISABLEPAPER</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%">
    ///Disables the paper controls, preventing the user from setting page parameters such as the paper size and source.
    ///</td> </tr> <tr> <td width="40%"><a id="PSD_DISABLEPRINTER"></a><a id="psd_disableprinter"></a><dl>
    ///<dt><b>PSD_DISABLEPRINTER</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Obsolete. <b>Windows XP/2000:
    ///</b>Disables the <b>Printer</b> button, preventing the user from invoking a dialog box that contains additional
    ///printer setup information. </td> </tr> <tr> <td width="40%"><a id="PSD_ENABLEPAGEPAINTHOOK"></a><a
    ///id="psd_enablepagepainthook"></a><dl> <dt><b>PSD_ENABLEPAGEPAINTHOOK</b></dt> <dt>0x00040000</dt> </dl> </td> <td
    ///width="60%"> Enables the hook procedure specified in the <b>lpfnPagePaintHook</b> member. </td> </tr> <tr> <td
    ///width="40%"><a id="PSD_ENABLEPAGESETUPHOOK"></a><a id="psd_enablepagesetuphook"></a><dl>
    ///<dt><b>PSD_ENABLEPAGESETUPHOOK</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> Enables the hook
    ///procedure specified in the <b>lpfnPageSetupHook</b> member. </td> </tr> <tr> <td width="40%"><a
    ///id="PSD_ENABLEPAGESETUPTEMPLATE"></a><a id="psd_enablepagesetuptemplate"></a><dl>
    ///<dt><b>PSD_ENABLEPAGESETUPTEMPLATE</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> Indicates that the
    ///<b>hInstance</b> and <b>lpPageSetupTemplateName</b> members specify a dialog box template to use in place of the
    ///default template. </td> </tr> <tr> <td width="40%"><a id="PSD_ENABLEPAGESETUPTEMPLATEHANDLE"></a><a
    ///id="psd_enablepagesetuptemplatehandle"></a><dl> <dt><b>PSD_ENABLEPAGESETUPTEMPLATEHANDLE</b></dt>
    ///<dt>0x00020000</dt> </dl> </td> <td width="60%"> Indicates that the <b>hPageSetupTemplate</b> member identifies a
    ///data block that contains a preloaded dialog box template. The system ignores the <b>lpPageSetupTemplateName</b>
    ///member if this flag is specified. </td> </tr> <tr> <td width="40%"><a id="PSD_INHUNDREDTHSOFMILLIMETERS"></a><a
    ///id="psd_inhundredthsofmillimeters"></a><dl> <dt><b>PSD_INHUNDREDTHSOFMILLIMETERS</b></dt> <dt>0x00000008</dt>
    ///</dl> </td> <td width="60%"> Indicates that hundredths of millimeters are the unit of measurement for margins and
    ///paper size. The values in the <b>rtMargin</b>, <b>rtMinMargin</b>, and <b>ptPaperSize</b> members are in
    ///hundredths of millimeters. You can set this flag on input to override the default unit of measurement for the
    ///user's locale. When the function returns, the dialog box sets this flag to indicate the units used. </td> </tr>
    ///<tr> <td width="40%"><a id="PSD_INTHOUSANDTHSOFINCHES"></a><a id="psd_inthousandthsofinches"></a><dl>
    ///<dt><b>PSD_INTHOUSANDTHSOFINCHES</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Indicates that
    ///thousandths of inches are the unit of measurement for margins and paper size. The values in the <b>rtMargin</b>,
    ///<b>rtMinMargin</b>, and <b>ptPaperSize</b> members are in thousandths of inches. You can set this flag on input
    ///to override the default unit of measurement for the user's locale. When the function returns, the dialog box sets
    ///this flag to indicate the units used. </td> </tr> <tr> <td width="40%"><a id="PSD_INWININIINTLMEASURE"></a><a
    ///id="psd_inwininiintlmeasure"></a><dl> <dt><b>PSD_INWININIINTLMEASURE</b></dt> <dt>0x00000000</dt> </dl> </td> <td
    ///width="60%"> Reserved. </td> </tr> <tr> <td width="40%"><a id="PSD_MARGINS"></a><a id="psd_margins"></a><dl>
    ///<dt><b>PSD_MARGINS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Causes the system to use the values
    ///specified in the <b>rtMargin</b> member as the initial widths for the left, top, right, and bottom margins. If
    ///<b>PSD_MARGINS</b> is not set, the system sets the initial widths to one inch for all margins. </td> </tr> <tr>
    ///<td width="40%"><a id="PSD_MINMARGINS"></a><a id="psd_minmargins"></a><dl> <dt><b>PSD_MINMARGINS</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> Causes the system to use the values specified in the
    ///<b>rtMinMargin</b> member as the minimum allowable widths for the left, top, right, and bottom margins. The
    ///system prevents the user from entering a width that is less than the specified minimum. If <b>PSD_MINMARGINS</b>
    ///is not specified, the system sets the minimum allowable widths to those allowed by the printer. </td> </tr> <tr>
    ///<td width="40%"><a id="PSD_NONETWORKBUTTON"></a><a id="psd_nonetworkbutton"></a><dl>
    ///<dt><b>PSD_NONETWORKBUTTON</b></dt> <dt>0x00200000</dt> </dl> </td> <td width="60%"> Hides and disables the
    ///<b>Network</b> button. </td> </tr> <tr> <td width="40%"><a id="PSD_NOWARNING"></a><a id="psd_nowarning"></a><dl>
    ///<dt><b>PSD_NOWARNING</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Prevents the system from
    ///displaying a warning message when there is no default printer. </td> </tr> <tr> <td width="40%"><a
    ///id="PSD_RETURNDEFAULT"></a><a id="psd_returndefault"></a><dl> <dt><b>PSD_RETURNDEFAULT</b></dt>
    ///<dt>0x00000400</dt> </dl> </td> <td width="60%"> PageSetupDlg does not display the dialog box. Instead, it sets
    ///the <b>hDevNames</b> and <b>hDevMode</b> members to handles to DEVMODE and DEVNAMES structures that are
    ///initialized for the system default printer. <b>PageSetupDlg</b> returns an error if either <b>hDevNames</b> or
    ///<b>hDevMode</b> is not <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="PSD_SHOWHELP"></a><a
    ///id="psd_showhelp"></a><dl> <dt><b>PSD_SHOWHELP</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> Causes
    ///the dialog box to display the <b>Help</b> button. The <b>hwndOwner</b> member must specify the window to receive
    ///the HELPMSGSTRING registered messages that the dialog box sends when the user clicks the <b>Help</b> button.
    ///</td> </tr> </table>
    uint            Flags;
    ///Type: <b>POINT</b> The dimensions of the paper selected by the user. The <b>PSD_INTHOUSANDTHSOFINCHES</b> or
    ///<b>PSD_INHUNDREDTHSOFMILLIMETERS</b> flag indicates the units of measurement.
    POINT           ptPaperSize;
    ///Type: <b>RECT</b> The minimum allowable widths for the left, top, right, and bottom margins. The system ignores
    ///this member if the <b>PSD_MINMARGINS</b> flag is not set. These values must be less than or equal to the values
    ///specified in the <b>rtMargin</b> member. The <b>PSD_INTHOUSANDTHSOFINCHES</b> or
    ///<b>PSD_INHUNDREDTHSOFMILLIMETERS</b> flag indicates the units of measurement.
    RECT            rtMinMargin;
    ///Type: <b>RECT</b> The widths of the left, top, right, and bottom margins. If you set the <b>PSD_MARGINS</b> flag,
    ///<b>rtMargin</b> specifies the initial margin values. When PageSetupDlg returns, <b>rtMargin</b> contains the
    ///margin widths selected by the user. The <b>PSD_INHUNDREDTHSOFMILLIMETERS</b> or <b>PSD_INTHOUSANDTHSOFINCHES</b>
    ///flag indicates the units of measurement.
    RECT            rtMargin;
    ///Type: <b>HINSTANCE</b> If the <b>PSD_ENABLEPAGESETUPTEMPLATE</b> flag is set in the <b>Flags</b> member,
    ///<b>hInstance</b> is a handle to the application or module instance that contains the dialog box template named by
    ///the <b>lpPageSetupTemplateName</b> member.
    HINSTANCE       hInstance;
    ///Type: <b>LPARAM</b> Application-defined data that the system passes to the hook procedure identified by the
    ///<b>lpfnPageSetupHook</b> member. When the system sends the WM_INITDIALOG message to the hook procedure, the
    ///message's <i>lParam</i> parameter is a pointer to the <b>PAGESETUPDLG</b> structure specified when the dialog was
    ///created. The hook procedure can use this pointer to get the <b>lCustData</b> value.
    LPARAM          lCustData;
    ///Type: <b>LPPAGESETUPHOOK</b> A pointer to a PageSetupHook hook procedure that can process messages intended for
    ///the dialog box. This member is ignored unless the <b>PSD_ENABLEPAGESETUPHOOK</b> flag is set in the <b>Flags</b>
    ///member.
    LPPAGESETUPHOOK lpfnPageSetupHook;
    ///Type: <b>LPPAGEPAINTHOOK</b> A pointer to a PagePaintHook hook procedure that receives <b>WM_PSD_*</b> messages
    ///from the dialog box whenever the sample page is redrawn. By processing the messages, the hook procedure can
    ///customize the appearance of the sample page. This member is ignored unless the <b>PSD_ENABLEPAGEPAINTHOOK</b>
    ///flag is set in the <b>Flags</b> member.
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    ///Type: <b>LPCTSTR</b> The name of the dialog box template resource in the module identified by the
    ///<b>hInstance</b> member. This template is substituted for the standard dialog box template. For numbered dialog
    ///box resources, <b>lpPageSetupTemplateName</b> can be a value returned by the MAKEINTRESOURCE macro. This member
    ///is ignored unless the <b>PSD_ENABLEPAGESETUPTEMPLATE</b> flag is set in the <b>Flags</b> member.
    const(PWSTR)    lpPageSetupTemplateName;
    ///Type: <b>HGLOBAL</b> If the <b>PSD_ENABLEPAGESETUPTEMPLATEHANDLE</b> flag is set in the <b>Flags</b> member,
    ///<b>hPageSetupTemplate</b> is a handle to a memory object containing a dialog box template.
    ptrdiff_t       hPageSetupTemplate;
}

@RAIIFree!UnhookWindowsHookEx
struct HHOOK
{
    ptrdiff_t Value;
}

struct HWND
{
    ptrdiff_t Value;
}

struct LPARAM
{
    ptrdiff_t Value;
}

struct WPARAM
{
    size_t Value;
}

// Functions

///<p class="CCE_Message">[This function is not intended for general use. It may be altered or unavailable in subsequent
///versions of Windows.] Determines whether the system considers that a specified application is not responding. An
///application is considered to be not responding if it is not waiting for input, is not in startup processing, and has
///not called PeekMessage within the internal timeout period of 5 seconds.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> The return value is <b>TRUE</b> if the window stops responding; otherwise, it is <b>FALSE</b>.
///    Ghost windows always return <b>TRUE</b>.
///    
@DllImport("USER32")
BOOL IsHungAppWindow(HWND hwnd);

///Defines a new window message that is guaranteed to be unique throughout the system. The message value can be used
///when sending or posting messages.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The message to be registered.
///Returns:
///    Type: <b>UINT</b> If the message is successfully registered, the return value is a message identifier in the
///    range 0xC000 through 0xFFFF. If the function fails, the return value is zero. To get extended error information,
///    call GetLastError.
///    
@DllImport("USER32")
uint RegisterWindowMessageA(const(PSTR) lpString);

///Defines a new window message that is guaranteed to be unique throughout the system. The message value can be used
///when sending or posting messages.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The message to be registered.
///Returns:
///    Type: <b>UINT</b> If the message is successfully registered, the return value is a message identifier in the
///    range 0xC000 through 0xFFFF. If the function fails, the return value is zero. To get extended error information,
///    call GetLastError.
///    
@DllImport("USER32")
uint RegisterWindowMessageW(const(PWSTR) lpString);

///Retrieves a message from the calling thread's message queue. The function dispatches incoming sent messages until a
///posted message is available for retrieval. Unlike <b>GetMessage</b>, the PeekMessage function does not wait for a
///message to be posted before returning.
///Params:
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that receives message information from the thread's message
///            queue.
///    hWnd = Type: <b>HWND</b> A handle to the window whose messages are to be retrieved. The window must belong to the
///           current thread. If <i>hWnd</i> is <b>NULL</b>, <b>GetMessage</b> retrieves messages for any window that belongs
///           to the current thread, and any messages on the current thread's message queue whose <b>hwnd</b> value is
///           <b>NULL</b> (see the MSG structure). Therefore if hWnd is <b>NULL</b>, both window messages and thread messages
///           are processed. If <i>hWnd</i> is -1, <b>GetMessage</b> retrieves only messages on the current thread's message
///           queue whose <b>hwnd</b> value is <b>NULL</b>, that is, thread messages as posted by PostMessage (when the
///           <i>hWnd</i> parameter is <b>NULL</b>) or PostThreadMessage.
///    wMsgFilterMin = Type: <b>UINT</b> The integer value of the lowest message value to be retrieved. Use <b>WM_KEYFIRST</b> (0x0100)
///                    to specify the first keyboard message or <b>WM_MOUSEFIRST</b> (0x0200) to specify the first mouse message. Use
///                    WM_INPUT here and in <i>wMsgFilterMax</i> to specify only the <b>WM_INPUT</b> messages. If <i>wMsgFilterMin</i>
///                    and <i>wMsgFilterMax</i> are both zero, <b>GetMessage</b> returns all available messages (that is, no range
///                    filtering is performed).
///    wMsgFilterMax = Type: <b>UINT</b> The integer value of the highest message value to be retrieved. Use <b>WM_KEYLAST</b> to
///                    specify the last keyboard message or <b>WM_MOUSELAST</b> to specify the last mouse message. Use WM_INPUT here and
///                    in <i>wMsgFilterMin</i> to specify only the <b>WM_INPUT</b> messages. If <i>wMsgFilterMin</i> and
///                    <i>wMsgFilterMax</i> are both zero, <b>GetMessage</b> returns all available messages (that is, no range filtering
///                    is performed).
///Returns:
///    Type: <b>BOOL</b> If the function retrieves a message other than WM_QUIT, the return value is nonzero. If the
///    function retrieves the WM_QUIT message, the return value is zero. If there is an error, the return value is -1.
///    For example, the function fails if <i>hWnd</i> is an invalid window handle or <i>lpMsg</i> is an invalid pointer.
///    To get extended error information, call GetLastError. Because the return value can be nonzero, zero, or -1, avoid
///    code like this: ``` while (GetMessage( lpMsg, hWnd, 0, 0)) ... ``` The possibility of a -1 return value in the
///    case that hWnd is an invalid parameter (such as referring to a window that has already been destroyed) means that
///    such code can lead to fatal application errors. Instead, use code like this: ``` BOOL bRet; while( (bRet =
///    GetMessage( &msg, hWnd, 0, 0 )) != 0) { if (bRet == -1) { // handle the error and possibly exit } else {
///    TranslateMessage(&msg); DispatchMessage(&msg); } } ```
///    
@DllImport("USER32")
BOOL GetMessageA(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax);

///Retrieves a message from the calling thread's message queue. The function dispatches incoming sent messages until a
///posted message is available for retrieval. Unlike <b>GetMessage</b>, the PeekMessage function does not wait for a
///message to be posted before returning.
///Params:
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that receives message information from the thread's message
///            queue.
///    hWnd = Type: <b>HWND</b> A handle to the window whose messages are to be retrieved. The window must belong to the
///           current thread. If <i>hWnd</i> is <b>NULL</b>, <b>GetMessage</b> retrieves messages for any window that belongs
///           to the current thread, and any messages on the current thread's message queue whose <b>hwnd</b> value is
///           <b>NULL</b> (see the MSG structure). Therefore if hWnd is <b>NULL</b>, both window messages and thread messages
///           are processed. If <i>hWnd</i> is -1, <b>GetMessage</b> retrieves only messages on the current thread's message
///           queue whose <b>hwnd</b> value is <b>NULL</b>, that is, thread messages as posted by PostMessage (when the
///           <i>hWnd</i> parameter is <b>NULL</b>) or PostThreadMessage.
///    wMsgFilterMin = Type: <b>UINT</b> The integer value of the lowest message value to be retrieved. Use <b>WM_KEYFIRST</b> (0x0100)
///                    to specify the first keyboard message or <b>WM_MOUSEFIRST</b> (0x0200) to specify the first mouse message. Use
///                    WM_INPUT here and in <i>wMsgFilterMax</i> to specify only the <b>WM_INPUT</b> messages. If <i>wMsgFilterMin</i>
///                    and <i>wMsgFilterMax</i> are both zero, <b>GetMessage</b> returns all available messages (that is, no range
///                    filtering is performed).
///    wMsgFilterMax = Type: <b>UINT</b> The integer value of the highest message value to be retrieved. Use <b>WM_KEYLAST</b> to
///                    specify the last keyboard message or <b>WM_MOUSELAST</b> to specify the last mouse message. Use WM_INPUT here and
///                    in <i>wMsgFilterMin</i> to specify only the <b>WM_INPUT</b> messages. If <i>wMsgFilterMin</i> and
///                    <i>wMsgFilterMax</i> are both zero, <b>GetMessage</b> returns all available messages (that is, no range filtering
///                    is performed).
///Returns:
///    Type: <b>BOOL</b> If the function retrieves a message other than WM_QUIT, the return value is nonzero. If the
///    function retrieves the WM_QUIT message, the return value is zero. If there is an error, the return value is -1.
///    For example, the function fails if <i>hWnd</i> is an invalid window handle or <i>lpMsg</i> is an invalid pointer.
///    To get extended error information, call GetLastError. Because the return value can be nonzero, zero, or -1, avoid
///    code like this: ``` while (GetMessage( lpMsg, hWnd, 0, 0)) ... ``` The possibility of a -1 return value in the
///    case that hWnd is an invalid parameter (such as referring to a window that has already been destroyed) means that
///    such code can lead to fatal application errors. Instead, use code like this: ``` BOOL bRet; while( (bRet =
///    GetMessage( &msg, hWnd, 0, 0 )) != 0) { if (bRet == -1) { // handle the error and possibly exit } else {
///    TranslateMessage(&msg); DispatchMessage(&msg); } } ```
///    
@DllImport("USER32")
BOOL GetMessageW(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax);

///Translates virtual-key messages into character messages. The character messages are posted to the calling thread's
///message queue, to be read the next time the thread calls the GetMessage or PeekMessage function.
///Params:
///    lpMsg = Type: <b>const MSG*</b> A pointer to an MSG structure that contains message information retrieved from the
///            calling thread's message queue by using the GetMessage or PeekMessage function.
///Returns:
///    Type: <b>BOOL</b> If the message is translated (that is, a character message is posted to the thread's message
///    queue), the return value is nonzero. If the message is WM_KEYDOWN, WM_KEYUP, WM_SYSKEYDOWN, or WM_SYSKEYUP, the
///    return value is nonzero, regardless of the translation. If the message is not translated (that is, a character
///    message is not posted to the thread's message queue), the return value is zero.
///    
@DllImport("USER32")
BOOL TranslateMessage(const(MSG)* lpMsg);

///Dispatches a message to a window procedure. It is typically used to dispatch a message retrieved by the GetMessage
///function.
///Params:
///    lpMsg = Type: <b>const MSG*</b> A pointer to a structure that contains the message.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the value returned by the window procedure. Although its meaning
///    depends on the message being dispatched, the return value generally is ignored.
///    
@DllImport("USER32")
LRESULT DispatchMessageA(const(MSG)* lpMsg);

///Dispatches a message to a window procedure. It is typically used to dispatch a message retrieved by the GetMessage
///function.
///Params:
///    lpMsg = Type: <b>const MSG*</b> A pointer to a structure that contains the message.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the value returned by the window procedure. Although its meaning
///    depends on the message being dispatched, the return value generally is ignored.
///    
@DllImport("USER32")
LRESULT DispatchMessageW(const(MSG)* lpMsg);

///Dispatches incoming sent messages, checks the thread message queue for a posted message, and retrieves the message
///(if any exist).
///Params:
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that receives message information.
///    hWnd = Type: <b>HWND</b> A handle to the window whose messages are to be retrieved. The window must belong to the
///           current thread. If <i>hWnd</i> is <b>NULL</b>, <b>PeekMessage</b> retrieves messages for any window that belongs
///           to the current thread, and any messages on the current thread's message queue whose <b>hwnd</b> value is
///           <b>NULL</b> (see the MSG structure). Therefore if hWnd is <b>NULL</b>, both window messages and thread messages
///           are processed. If <i>hWnd</i> is -1, <b>PeekMessage</b> retrieves only messages on the current thread's message
///           queue whose <b>hwnd</b> value is <b>NULL</b>, that is, thread messages as posted by PostMessage (when the
///           <i>hWnd</i> parameter is <b>NULL</b>) or PostThreadMessage.
///    wMsgFilterMin = Type: <b>UINT</b> The value of the first message in the range of messages to be examined. Use <b>WM_KEYFIRST</b>
///                    (0x0100) to specify the first keyboard message or <b>WM_MOUSEFIRST</b> (0x0200) to specify the first mouse
///                    message. If <i>wMsgFilterMin</i> and <i>wMsgFilterMax</i> are both zero, <b>PeekMessage</b> returns all available
///                    messages (that is, no range filtering is performed).
///    wMsgFilterMax = Type: <b>UINT</b> The value of the last message in the range of messages to be examined. Use <b>WM_KEYLAST</b> to
///                    specify the last keyboard message or <b>WM_MOUSELAST</b> to specify the last mouse message. If
///                    <i>wMsgFilterMin</i> and <i>wMsgFilterMax</i> are both zero, <b>PeekMessage</b> returns all available messages
///                    (that is, no range filtering is performed).
///    wRemoveMsg = Type: <b>UINT</b> Specifies how messages are to be handled. This parameter can be one or more of the following
///                 values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PM_NOREMOVE"></a><a
///                 id="pm_noremove"></a><dl> <dt><b>PM_NOREMOVE</b></dt> <dt>0x0000</dt> </dl> </td> <td width="60%"> Messages are
///                 not removed from the queue after processing by <b>PeekMessage</b>. </td> </tr> <tr> <td width="40%"><a
///                 id="PM_REMOVE"></a><a id="pm_remove"></a><dl> <dt><b>PM_REMOVE</b></dt> <dt>0x0001</dt> </dl> </td> <td
///                 width="60%"> Messages are removed from the queue after processing by <b>PeekMessage</b>. </td> </tr> <tr> <td
///                 width="40%"><a id="PM_NOYIELD"></a><a id="pm_noyield"></a><dl> <dt><b>PM_NOYIELD</b></dt> <dt>0x0002</dt> </dl>
///                 </td> <td width="60%"> Prevents the system from releasing any thread that is waiting for the caller to go idle
///                 (see WaitForInputIdle). Combine this value with either <b>PM_NOREMOVE</b> or <b>PM_REMOVE</b>. </td> </tr>
///                 </table> By default, all message types are processed. To specify that only certain message should be processed,
///                 specify one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                 width="40%"><a id="PM_QS_INPUT"></a><a id="pm_qs_input"></a><dl> <dt><b>PM_QS_INPUT</b></dt> <dt>(QS_INPUT
///                 &lt;&lt; 16)</dt> </dl> </td> <td width="60%"> Process mouse and keyboard messages. </td> </tr> <tr> <td
///                 width="40%"><a id="PM_QS_PAINT"></a><a id="pm_qs_paint"></a><dl> <dt><b>PM_QS_PAINT</b></dt> <dt>(QS_PAINT
///                 &lt;&lt; 16)</dt> </dl> </td> <td width="60%"> Process paint messages. </td> </tr> <tr> <td width="40%"><a
///                 id="PM_QS_POSTMESSAGE"></a><a id="pm_qs_postmessage"></a><dl> <dt><b>PM_QS_POSTMESSAGE</b></dt>
///                 <dt>((QS_POSTMESSAGE | QS_HOTKEY | QS_TIMER) &lt;&lt; 16)</dt> </dl> </td> <td width="60%"> Process all posted
///                 messages, including timers and hotkeys. </td> </tr> <tr> <td width="40%"><a id="PM_QS_SENDMESSAGE"></a><a
///                 id="pm_qs_sendmessage"></a><dl> <dt><b>PM_QS_SENDMESSAGE</b></dt> <dt>(QS_SENDMESSAGE &lt;&lt; 16)</dt> </dl>
///                 </td> <td width="60%"> Process all sent messages. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If a message is available, the return value is nonzero. If no messages are available, the
///    return value is zero.
///    
@DllImport("USER32")
BOOL PeekMessageA(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg);

///Dispatches incoming sent messages, checks the thread message queue for a posted message, and retrieves the message
///(if any exist).
///Params:
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that receives message information.
///    hWnd = Type: <b>HWND</b> A handle to the window whose messages are to be retrieved. The window must belong to the
///           current thread. If <i>hWnd</i> is <b>NULL</b>, <b>PeekMessage</b> retrieves messages for any window that belongs
///           to the current thread, and any messages on the current thread's message queue whose <b>hwnd</b> value is
///           <b>NULL</b> (see the MSG structure). Therefore if hWnd is <b>NULL</b>, both window messages and thread messages
///           are processed. If <i>hWnd</i> is -1, <b>PeekMessage</b> retrieves only messages on the current thread's message
///           queue whose <b>hwnd</b> value is <b>NULL</b>, that is, thread messages as posted by PostMessage (when the
///           <i>hWnd</i> parameter is <b>NULL</b>) or PostThreadMessage.
///    wMsgFilterMin = Type: <b>UINT</b> The value of the first message in the range of messages to be examined. Use <b>WM_KEYFIRST</b>
///                    (0x0100) to specify the first keyboard message or <b>WM_MOUSEFIRST</b> (0x0200) to specify the first mouse
///                    message. If <i>wMsgFilterMin</i> and <i>wMsgFilterMax</i> are both zero, <b>PeekMessage</b> returns all available
///                    messages (that is, no range filtering is performed).
///    wMsgFilterMax = Type: <b>UINT</b> The value of the last message in the range of messages to be examined. Use <b>WM_KEYLAST</b> to
///                    specify the last keyboard message or <b>WM_MOUSELAST</b> to specify the last mouse message. If
///                    <i>wMsgFilterMin</i> and <i>wMsgFilterMax</i> are both zero, <b>PeekMessage</b> returns all available messages
///                    (that is, no range filtering is performed).
///    wRemoveMsg = Type: <b>UINT</b> Specifies how messages are to be handled. This parameter can be one or more of the following
///                 values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PM_NOREMOVE"></a><a
///                 id="pm_noremove"></a><dl> <dt><b>PM_NOREMOVE</b></dt> <dt>0x0000</dt> </dl> </td> <td width="60%"> Messages are
///                 not removed from the queue after processing by <b>PeekMessage</b>. </td> </tr> <tr> <td width="40%"><a
///                 id="PM_REMOVE"></a><a id="pm_remove"></a><dl> <dt><b>PM_REMOVE</b></dt> <dt>0x0001</dt> </dl> </td> <td
///                 width="60%"> Messages are removed from the queue after processing by <b>PeekMessage</b>. </td> </tr> <tr> <td
///                 width="40%"><a id="PM_NOYIELD"></a><a id="pm_noyield"></a><dl> <dt><b>PM_NOYIELD</b></dt> <dt>0x0002</dt> </dl>
///                 </td> <td width="60%"> Prevents the system from releasing any thread that is waiting for the caller to go idle
///                 (see WaitForInputIdle). Combine this value with either <b>PM_NOREMOVE</b> or <b>PM_REMOVE</b>. </td> </tr>
///                 </table> By default, all message types are processed. To specify that only certain message should be processed,
///                 specify one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                 width="40%"><a id="PM_QS_INPUT"></a><a id="pm_qs_input"></a><dl> <dt><b>PM_QS_INPUT</b></dt> <dt>(QS_INPUT
///                 &lt;&lt; 16)</dt> </dl> </td> <td width="60%"> Process mouse and keyboard messages. </td> </tr> <tr> <td
///                 width="40%"><a id="PM_QS_PAINT"></a><a id="pm_qs_paint"></a><dl> <dt><b>PM_QS_PAINT</b></dt> <dt>(QS_PAINT
///                 &lt;&lt; 16)</dt> </dl> </td> <td width="60%"> Process paint messages. </td> </tr> <tr> <td width="40%"><a
///                 id="PM_QS_POSTMESSAGE"></a><a id="pm_qs_postmessage"></a><dl> <dt><b>PM_QS_POSTMESSAGE</b></dt>
///                 <dt>((QS_POSTMESSAGE | QS_HOTKEY | QS_TIMER) &lt;&lt; 16)</dt> </dl> </td> <td width="60%"> Process all posted
///                 messages, including timers and hotkeys. </td> </tr> <tr> <td width="40%"><a id="PM_QS_SENDMESSAGE"></a><a
///                 id="pm_qs_sendmessage"></a><dl> <dt><b>PM_QS_SENDMESSAGE</b></dt> <dt>(QS_SENDMESSAGE &lt;&lt; 16)</dt> </dl>
///                 </td> <td width="60%"> Process all sent messages. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If a message is available, the return value is nonzero. If no messages are available, the
///    return value is zero.
///    
@DllImport("USER32")
BOOL PeekMessageW(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg);

///Retrieves the cursor position for the last message retrieved by the GetMessage function. To determine the current
///position of the cursor, use the GetCursorPos function.
///Returns:
///    Type: <b>DWORD</b> The return value specifies the x- and y-coordinates of the cursor position. The x-coordinate
///    is the low order <b>short</b> and the y-coordinate is the high-order <b>short</b>.
///    
@DllImport("USER32")
uint GetMessagePos();

///Retrieves the message time for the last message retrieved by the GetMessage function. The time is a long integer that
///specifies the elapsed time, in milliseconds, from the time the system was started to the time the message was created
///(that is, placed in the thread's message queue).
///Returns:
///    Type: <b>LONG</b> The return value specifies the message time.
///    
@DllImport("USER32")
int GetMessageTime();

///Retrieves the extra message information for the current thread. Extra message information is an application- or
///driver-defined value associated with the current thread's message queue.
///Returns:
///    Type: <b>LPARAM</b> The return value specifies the extra information. The meaning of the extra information is
///    device specific.
///    
@DllImport("USER32")
LPARAM GetMessageExtraInfo();

///Sets the extra message information for the current thread. Extra message information is an application- or
///driver-defined value associated with the current thread's message queue. An application can use the
///GetMessageExtraInfo function to retrieve a thread's extra message information.
///Params:
///    lParam = Type: <b>LPARAM</b> The value to be associated with the current thread.
///Returns:
///    Type: <b>LPARAM</b> The return value is the previous value associated with the current thread.
///    
@DllImport("USER32")
LPARAM SetMessageExtraInfo(LPARAM lParam);

///Sends the specified message to a window or windows. The <b>SendMessage</b> function calls the window procedure for
///the specified window and does not return until the window procedure has processed the message. To send a message and
///return immediately, use the SendMessageCallback or SendNotifyMessage function. To post a message to a thread's
///message queue and return immediately, use the PostMessage or PostThreadMessage function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows, overlapped windows, and pop-up windows; but the message is not sent to
///           child windows. Message sending is subject to UIPI. The thread of a process can send messages only to message
///           queues of threads in processes of lesser or equal integrity level.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing; it depends on the message
///    sent.
///    
@DllImport("USER32")
LRESULT SendMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Sends the specified message to a window or windows. The <b>SendMessage</b> function calls the window procedure for
///the specified window and does not return until the window procedure has processed the message. To send a message and
///return immediately, use the SendMessageCallback or SendNotifyMessage function. To post a message to a thread's
///message queue and return immediately, use the PostMessage or PostThreadMessage function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows, overlapped windows, and pop-up windows; but the message is not sent to
///           child windows. Message sending is subject to UIPI. The thread of a process can send messages only to message
///           queues of threads in processes of lesser or equal integrity level.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing; it depends on the message
///    sent.
///    
@DllImport("USER32")
LRESULT SendMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Sends the specified message to one or more windows.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows. The function does not return until each window has timed out. Therefore,
///           the total wait time can be up to the value of <i>uTimeout</i> multiplied by the number of top-level windows.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Any additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Any additional message-specific information.
///    fuFlags = Type: <b>UINT</b> The behavior of this function. This parameter can be one or more of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SMTO_ABORTIFHUNG"></a><a
///              id="smto_abortifhung"></a><dl> <dt><b>SMTO_ABORTIFHUNG</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> The
///              function returns without waiting for the time-out period to elapse if the receiving thread appears to not respond
///              or "hangs." </td> </tr> <tr> <td width="40%"><a id="SMTO_BLOCK"></a><a id="smto_block"></a><dl>
///              <dt><b>SMTO_BLOCK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Prevents the calling thread from
///              processing any other requests until the function returns. </td> </tr> <tr> <td width="40%"><a
///              id="SMTO_NORMAL"></a><a id="smto_normal"></a><dl> <dt><b>SMTO_NORMAL</b></dt> <dt>0x0000</dt> </dl> </td> <td
///              width="60%"> The calling thread is not prevented from processing other requests while waiting for the function to
///              return. </td> </tr> <tr> <td width="40%"><a id="SMTO_NOTIMEOUTIFNOTHUNG"></a><a
///              id="smto_notimeoutifnothung"></a><dl> <dt><b>SMTO_NOTIMEOUTIFNOTHUNG</b></dt> <dt>0x0008</dt> </dl> </td> <td
///              width="60%"> The function does not enforce the time-out period as long as the receiving thread is processing
///              messages. </td> </tr> <tr> <td width="40%"><a id="SMTO_ERRORONEXIT"></a><a id="smto_erroronexit"></a><dl>
///              <dt><b>SMTO_ERRORONEXIT</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> The function should return 0 if the
///              receiving window is destroyed or its owning thread dies while the message is being processed. </td> </tr>
///              </table>
///    uTimeout = Type: <b>UINT</b> The duration of the time-out period, in milliseconds. If the message is a broadcast message,
///               each window can use the full time-out period. For example, if you specify a five second time-out period and there
///               are three top-level windows that fail to process the message, you could have up to a 15 second delay.
///    lpdwResult = Type: <b>PDWORD_PTR</b> The result of the message processing. The value of this parameter depends on the message
///                 that is specified.
///Returns:
///    Type: <b>LRESULT</b> If the function succeeds, the return value is nonzero. <b>SendMessageTimeout</b> does not
///    provide information about individual windows timing out if <b>HWND_BROADCAST</b> is used. If the function fails
///    or times out, the return value is 0. To get extended error information, call GetLastError. If <b>GetLastError</b>
///    returns <b>ERROR_TIMEOUT</b>, then the function timed out. <b>Windows 2000: </b>If GetLastError returns 0, then
///    the function timed out.
///    
@DllImport("USER32")
LRESULT SendMessageTimeoutA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, uint fuFlags, uint uTimeout, 
                            size_t* lpdwResult);

///Sends the specified message to one or more windows.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows. The function does not return until each window has timed out. Therefore,
///           the total wait time can be up to the value of <i>uTimeout</i> multiplied by the number of top-level windows.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Any additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Any additional message-specific information.
///    fuFlags = Type: <b>UINT</b> The behavior of this function. This parameter can be one or more of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SMTO_ABORTIFHUNG"></a><a
///              id="smto_abortifhung"></a><dl> <dt><b>SMTO_ABORTIFHUNG</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> The
///              function returns without waiting for the time-out period to elapse if the receiving thread appears to not respond
///              or "hangs." </td> </tr> <tr> <td width="40%"><a id="SMTO_BLOCK"></a><a id="smto_block"></a><dl>
///              <dt><b>SMTO_BLOCK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Prevents the calling thread from
///              processing any other requests until the function returns. </td> </tr> <tr> <td width="40%"><a
///              id="SMTO_NORMAL"></a><a id="smto_normal"></a><dl> <dt><b>SMTO_NORMAL</b></dt> <dt>0x0000</dt> </dl> </td> <td
///              width="60%"> The calling thread is not prevented from processing other requests while waiting for the function to
///              return. </td> </tr> <tr> <td width="40%"><a id="SMTO_NOTIMEOUTIFNOTHUNG"></a><a
///              id="smto_notimeoutifnothung"></a><dl> <dt><b>SMTO_NOTIMEOUTIFNOTHUNG</b></dt> <dt>0x0008</dt> </dl> </td> <td
///              width="60%"> The function does not enforce the time-out period as long as the receiving thread is processing
///              messages. </td> </tr> <tr> <td width="40%"><a id="SMTO_ERRORONEXIT"></a><a id="smto_erroronexit"></a><dl>
///              <dt><b>SMTO_ERRORONEXIT</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> The function should return 0 if the
///              receiving window is destroyed or its owning thread dies while the message is being processed. </td> </tr>
///              </table>
///    uTimeout = Type: <b>UINT</b> The duration of the time-out period, in milliseconds. If the message is a broadcast message,
///               each window can use the full time-out period. For example, if you specify a five second time-out period and there
///               are three top-level windows that fail to process the message, you could have up to a 15 second delay.
///    lpdwResult = Type: <b>PDWORD_PTR</b> The result of the message processing. The value of this parameter depends on the message
///                 that is specified.
///Returns:
///    Type: <b>LRESULT</b> If the function succeeds, the return value is nonzero. <b>SendMessageTimeout</b> does not
///    provide information about individual windows timing out if <b>HWND_BROADCAST</b> is used. If the function fails
///    or times out, the return value is 0. To get extended error information, call GetLastError. If <b>GetLastError</b>
///    returns <b>ERROR_TIMEOUT</b>, then the function timed out. <b>Windows 2000: </b>If GetLastError returns 0, then
///    the function timed out.
///    
@DllImport("USER32")
LRESULT SendMessageTimeoutW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, uint fuFlags, uint uTimeout, 
                            size_t* lpdwResult);

///Sends the specified message to a window or windows. If the window was created by the calling thread,
///<b>SendNotifyMessage</b> calls the window procedure for the window and does not return until the window procedure has
///processed the message. If the window was created by a different thread, <b>SendNotifyMessage</b> passes the message
///to the window procedure and returns immediately; it does not wait for the window procedure to finish processing the
///message.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows, overlapped windows, and pop-up windows; but the message is not sent to
///           child windows.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SendNotifyMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Sends the specified message to a window or windows. If the window was created by the calling thread,
///<b>SendNotifyMessage</b> calls the window procedure for the window and does not return until the window procedure has
///processed the message. If the window was created by a different thread, <b>SendNotifyMessage</b> passes the message
///to the window procedure and returns immediately; it does not wait for the window procedure to finish processing the
///message.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows, overlapped windows, and pop-up windows; but the message is not sent to
///           child windows.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SendNotifyMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Sends the specified message to a window or windows. It calls the window procedure for the specified window and
///returns immediately if the window belongs to another thread. After the window procedure processes the message, the
///system calls the specified callback function, passing the result of the message processing and an application-defined
///value to the callback function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows, overlapped windows, and pop-up windows; but the message is not sent to
///           child windows.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///    lpResultCallBack = Type: <b>SENDASYNCPROC</b> A pointer to a callback function that the system calls after the window procedure
///                       processes the message. For more information, see SendAsyncProc. If <i>hWnd</i> is <b>HWND_BROADCAST</b>
///                       ((HWND)0xffff), the system calls the SendAsyncProc callback function once for each top-level window.
///    dwData = Type: <b>ULONG_PTR</b> An application-defined value to be sent to the callback function pointed to by the
///             <i>lpCallBack</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SendMessageCallbackA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpResultCallBack, 
                          size_t dwData);

///Sends the specified message to a window or windows. It calls the window procedure for the specified window and
///returns immediately if the window belongs to another thread. After the window procedure processes the message, the
///system calls the specified callback function, passing the result of the message processing and an application-defined
///value to the callback function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure will receive the message. If this parameter is
///           <b>HWND_BROADCAST</b> ((HWND)0xffff), the message is sent to all top-level windows in the system, including
///           disabled or invisible unowned windows, overlapped windows, and pop-up windows; but the message is not sent to
///           child windows.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///    lpResultCallBack = Type: <b>SENDASYNCPROC</b> A pointer to a callback function that the system calls after the window procedure
///                       processes the message. For more information, see SendAsyncProc. If <i>hWnd</i> is <b>HWND_BROADCAST</b>
///                       ((HWND)0xffff), the system calls the SendAsyncProc callback function once for each top-level window.
///    dwData = Type: <b>ULONG_PTR</b> An application-defined value to be sent to the callback function pointed to by the
///             <i>lpCallBack</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SendMessageCallbackW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpResultCallBack, 
                          size_t dwData);

///Sends a message to the specified recipients. The recipients can be applications, installable drivers, network
///drivers, system-level device drivers, or any combination of these system components. This function is similar to
///BroadcastSystemMessage except that this function can return more information from the recipients.
///Params:
///    flags = Type: <b>DWORD</b> The broadcast option. This parameter can be one or more of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BSF_ALLOWSFW"></a><a id="bsf_allowsfw"></a><dl>
///            <dt><b>BSF_ALLOWSFW</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Enables the recipient to set the
///            foreground window while processing the message. </td> </tr> <tr> <td width="40%"><a id="BSF_FLUSHDISK"></a><a
///            id="bsf_flushdisk"></a><dl> <dt><b>BSF_FLUSHDISK</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
///            Flushes the disk after each recipient processes the message. </td> </tr> <tr> <td width="40%"><a
///            id="BSF_FORCEIFHUNG"></a><a id="bsf_forceifhung"></a><dl> <dt><b>BSF_FORCEIFHUNG</b></dt> <dt>0x00000020</dt>
///            </dl> </td> <td width="60%"> Continues to broadcast the message, even if the time-out period elapses or one of
///            the recipients is not responding. </td> </tr> <tr> <td width="40%"><a id="BSF_IGNORECURRENTTASK"></a><a
///            id="bsf_ignorecurrenttask"></a><dl> <dt><b>BSF_IGNORECURRENTTASK</b></dt> <dt>0x00000002</dt> </dl> </td> <td
///            width="60%"> Does not send the message to windows that belong to the current task. This prevents an application
///            from receiving its own message. </td> </tr> <tr> <td width="40%"><a id="BSF_LUID"></a><a id="bsf_luid"></a><dl>
///            <dt><b>BSF_LUID</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> If <b>BSF_LUID</b> is set, the message
///            is sent to the window that has the same LUID as specified in the <b>luid</b> member of the BSMINFO structure.
///            <b>Windows 2000: </b>This flag is not supported. </td> </tr> <tr> <td width="40%"><a id="BSF_NOHANG"></a><a
///            id="bsf_nohang"></a><dl> <dt><b>BSF_NOHANG</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Forces a
///            nonresponsive application to time out. If one of the recipients times out, do not continue broadcasting the
///            message. </td> </tr> <tr> <td width="40%"><a id="BSF_NOTIMEOUTIFNOTHUNG"></a><a
///            id="bsf_notimeoutifnothung"></a><dl> <dt><b>BSF_NOTIMEOUTIFNOTHUNG</b></dt> <dt>0x00000040</dt> </dl> </td> <td
///            width="60%"> Waits for a response to the message, as long as the recipient is not being unresponsive. Does not
///            time out. </td> </tr> <tr> <td width="40%"><a id="BSF_POSTMESSAGE"></a><a id="bsf_postmessage"></a><dl>
///            <dt><b>BSF_POSTMESSAGE</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Posts the message. Do not use in
///            combination with <b>BSF_QUERY</b>. </td> </tr> <tr> <td width="40%"><a id="BSF_RETURNHDESK"></a><a
///            id="bsf_returnhdesk"></a><dl> <dt><b>BSF_RETURNHDESK</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> If
///            access is denied and both this and <b>BSF_QUERY</b> are set, BSMINFO returns both the desktop handle and the
///            window handle. If access is denied and only <b>BSF_QUERY</b> is set, only the window handle is returned by
///            <b>BSMINFO</b>. <b>Windows 2000: </b>This flag is not supported. </td> </tr> <tr> <td width="40%"><a
///            id="BSF_QUERY"></a><a id="bsf_query"></a><dl> <dt><b>BSF_QUERY</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///            width="60%"> Sends the message to one recipient at a time, sending to a subsequent recipient only if the current
///            recipient returns <b>TRUE</b>. </td> </tr> <tr> <td width="40%"><a id="BSF_SENDNOTIFYMESSAGE"></a><a
///            id="bsf_sendnotifymessage"></a><dl> <dt><b>BSF_SENDNOTIFYMESSAGE</b></dt> <dt>0x00000100</dt> </dl> </td> <td
///            width="60%"> Sends the message using SendNotifyMessage function. Do not use in combination with <b>BSF_QUERY</b>.
///            </td> </tr> </table>
///    lpInfo = Type: <b>LPDWORD</b> A pointer to a variable that contains and receives information about the recipients of the
///             message. When the function returns, this variable receives a combination of these values identifying which
///             recipients actually received the message. If this parameter is <b>NULL</b>, the function broadcasts to all
///             components. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BSM_ALLCOMPONENTS"></a><a id="bsm_allcomponents"></a><dl>
///             <dt><b>BSM_ALLCOMPONENTS</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> Broadcast to all system
///             components. </td> </tr> <tr> <td width="40%"><a id="BSM_ALLDESKTOPS"></a><a id="bsm_alldesktops"></a><dl>
///             <dt><b>BSM_ALLDESKTOPS</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Broadcast to all desktops.
///             Requires the SE_TCB_NAME privilege. </td> </tr> <tr> <td width="40%"><a id="BSM_APPLICATIONS"></a><a
///             id="bsm_applications"></a><dl> <dt><b>BSM_APPLICATIONS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
///             Broadcast to applications. </td> </tr> </table>
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///    pbsmInfo = Type: <b>PBSMINFO</b> A pointer to a BSMINFO structure that contains additional information if the request is
///               denied and <i>dwFlags</i> is set to <b>BSF_QUERY</b>.
///Returns:
///    Type: <b>long</b> If the function succeeds, the return value is a positive value. If the function is unable to
///    broadcast the message, the return value is –1. If the <i>dwFlags</i> parameter is <b>BSF_QUERY</b> and at least
///    one recipient returned <b>BROADCAST_QUERY_DENY</b> to the corresponding message, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
int BroadcastSystemMessageExA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

///Sends a message to the specified recipients. The recipients can be applications, installable drivers, network
///drivers, system-level device drivers, or any combination of these system components. This function is similar to
///BroadcastSystemMessage except that this function can return more information from the recipients.
///Params:
///    flags = Type: <b>DWORD</b> The broadcast option. This parameter can be one or more of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BSF_ALLOWSFW"></a><a id="bsf_allowsfw"></a><dl>
///            <dt><b>BSF_ALLOWSFW</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Enables the recipient to set the
///            foreground window while processing the message. </td> </tr> <tr> <td width="40%"><a id="BSF_FLUSHDISK"></a><a
///            id="bsf_flushdisk"></a><dl> <dt><b>BSF_FLUSHDISK</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
///            Flushes the disk after each recipient processes the message. </td> </tr> <tr> <td width="40%"><a
///            id="BSF_FORCEIFHUNG"></a><a id="bsf_forceifhung"></a><dl> <dt><b>BSF_FORCEIFHUNG</b></dt> <dt>0x00000020</dt>
///            </dl> </td> <td width="60%"> Continues to broadcast the message, even if the time-out period elapses or one of
///            the recipients is not responding. </td> </tr> <tr> <td width="40%"><a id="BSF_IGNORECURRENTTASK"></a><a
///            id="bsf_ignorecurrenttask"></a><dl> <dt><b>BSF_IGNORECURRENTTASK</b></dt> <dt>0x00000002</dt> </dl> </td> <td
///            width="60%"> Does not send the message to windows that belong to the current task. This prevents an application
///            from receiving its own message. </td> </tr> <tr> <td width="40%"><a id="BSF_LUID"></a><a id="bsf_luid"></a><dl>
///            <dt><b>BSF_LUID</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> If <b>BSF_LUID</b> is set, the message
///            is sent to the window that has the same LUID as specified in the <b>luid</b> member of the BSMINFO structure.
///            <b>Windows 2000: </b>This flag is not supported. </td> </tr> <tr> <td width="40%"><a id="BSF_NOHANG"></a><a
///            id="bsf_nohang"></a><dl> <dt><b>BSF_NOHANG</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Forces a
///            nonresponsive application to time out. If one of the recipients times out, do not continue broadcasting the
///            message. </td> </tr> <tr> <td width="40%"><a id="BSF_NOTIMEOUTIFNOTHUNG"></a><a
///            id="bsf_notimeoutifnothung"></a><dl> <dt><b>BSF_NOTIMEOUTIFNOTHUNG</b></dt> <dt>0x00000040</dt> </dl> </td> <td
///            width="60%"> Waits for a response to the message, as long as the recipient is not being unresponsive. Does not
///            time out. </td> </tr> <tr> <td width="40%"><a id="BSF_POSTMESSAGE"></a><a id="bsf_postmessage"></a><dl>
///            <dt><b>BSF_POSTMESSAGE</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Posts the message. Do not use in
///            combination with <b>BSF_QUERY</b>. </td> </tr> <tr> <td width="40%"><a id="BSF_RETURNHDESK"></a><a
///            id="bsf_returnhdesk"></a><dl> <dt><b>BSF_RETURNHDESK</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> If
///            access is denied and both this and <b>BSF_QUERY</b> are set, BSMINFO returns both the desktop handle and the
///            window handle. If access is denied and only <b>BSF_QUERY</b> is set, only the window handle is returned by
///            <b>BSMINFO</b>. <b>Windows 2000: </b>This flag is not supported. </td> </tr> <tr> <td width="40%"><a
///            id="BSF_QUERY"></a><a id="bsf_query"></a><dl> <dt><b>BSF_QUERY</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///            width="60%"> Sends the message to one recipient at a time, sending to a subsequent recipient only if the current
///            recipient returns <b>TRUE</b>. </td> </tr> <tr> <td width="40%"><a id="BSF_SENDNOTIFYMESSAGE"></a><a
///            id="bsf_sendnotifymessage"></a><dl> <dt><b>BSF_SENDNOTIFYMESSAGE</b></dt> <dt>0x00000100</dt> </dl> </td> <td
///            width="60%"> Sends the message using SendNotifyMessage function. Do not use in combination with <b>BSF_QUERY</b>.
///            </td> </tr> </table>
///    lpInfo = Type: <b>LPDWORD</b> A pointer to a variable that contains and receives information about the recipients of the
///             message. When the function returns, this variable receives a combination of these values identifying which
///             recipients actually received the message. If this parameter is <b>NULL</b>, the function broadcasts to all
///             components. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BSM_ALLCOMPONENTS"></a><a id="bsm_allcomponents"></a><dl>
///             <dt><b>BSM_ALLCOMPONENTS</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> Broadcast to all system
///             components. </td> </tr> <tr> <td width="40%"><a id="BSM_ALLDESKTOPS"></a><a id="bsm_alldesktops"></a><dl>
///             <dt><b>BSM_ALLDESKTOPS</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Broadcast to all desktops.
///             Requires the SE_TCB_NAME privilege. </td> </tr> <tr> <td width="40%"><a id="BSM_APPLICATIONS"></a><a
///             id="bsm_applications"></a><dl> <dt><b>BSM_APPLICATIONS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
///             Broadcast to applications. </td> </tr> </table>
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///    pbsmInfo = Type: <b>PBSMINFO</b> A pointer to a BSMINFO structure that contains additional information if the request is
///               denied and <i>dwFlags</i> is set to <b>BSF_QUERY</b>.
///Returns:
///    Type: <b>long</b> If the function succeeds, the return value is a positive value. If the function is unable to
///    broadcast the message, the return value is –1. If the <i>dwFlags</i> parameter is <b>BSF_QUERY</b> and at least
///    one recipient returned <b>BROADCAST_QUERY_DENY</b> to the corresponding message, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
int BroadcastSystemMessageExW(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

///Sends a message to the specified recipients. The recipients can be applications, installable drivers, network
///drivers, system-level device drivers, or any combination of these system components. To receive additional
///information if the request is defined, use the BroadcastSystemMessageEx function.
///Params:
///    flags = Type: <b>DWORD</b> The broadcast option. This parameter can be one or more of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BSF_ALLOWSFW"></a><a id="bsf_allowsfw"></a><dl>
///            <dt><b>BSF_ALLOWSFW</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Enables the recipient to set the
///            foreground window while processing the message. </td> </tr> <tr> <td width="40%"><a id="BSF_FLUSHDISK"></a><a
///            id="bsf_flushdisk"></a><dl> <dt><b>BSF_FLUSHDISK</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
///            Flushes the disk after each recipient processes the message. </td> </tr> <tr> <td width="40%"><a
///            id="BSF_FORCEIFHUNG"></a><a id="bsf_forceifhung"></a><dl> <dt><b>BSF_FORCEIFHUNG</b></dt> <dt>0x00000020</dt>
///            </dl> </td> <td width="60%"> Continues to broadcast the message, even if the time-out period elapses or one of
///            the recipients is not responding. </td> </tr> <tr> <td width="40%"><a id="BSF_IGNORECURRENTTASK"></a><a
///            id="bsf_ignorecurrenttask"></a><dl> <dt><b>BSF_IGNORECURRENTTASK</b></dt> <dt>0x00000002</dt> </dl> </td> <td
///            width="60%"> Does not send the message to windows that belong to the current task. This prevents an application
///            from receiving its own message. </td> </tr> <tr> <td width="40%"><a id="BSF_NOHANG"></a><a
///            id="bsf_nohang"></a><dl> <dt><b>BSF_NOHANG</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Forces a
///            nonresponsive application to time out. If one of the recipients times out, do not continue broadcasting the
///            message. </td> </tr> <tr> <td width="40%"><a id="BSF_NOTIMEOUTIFNOTHUNG"></a><a
///            id="bsf_notimeoutifnothung"></a><dl> <dt><b>BSF_NOTIMEOUTIFNOTHUNG</b></dt> <dt>0x00000040</dt> </dl> </td> <td
///            width="60%"> Waits for a response to the message, as long as the recipient is not being unresponsive. Does not
///            time out. </td> </tr> <tr> <td width="40%"><a id="BSF_POSTMESSAGE"></a><a id="bsf_postmessage"></a><dl>
///            <dt><b>BSF_POSTMESSAGE</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Posts the message. Do not use in
///            combination with <b>BSF_QUERY</b>. </td> </tr> <tr> <td width="40%"><a id="BSF_QUERY"></a><a
///            id="bsf_query"></a><dl> <dt><b>BSF_QUERY</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Sends the
///            message to one recipient at a time, sending to a subsequent recipient only if the current recipient returns
///            <b>TRUE</b>. </td> </tr> <tr> <td width="40%"><a id="BSF_SENDNOTIFYMESSAGE"></a><a
///            id="bsf_sendnotifymessage"></a><dl> <dt><b>BSF_SENDNOTIFYMESSAGE</b></dt> <dt>0x00000100</dt> </dl> </td> <td
///            width="60%"> Sends the message using SendNotifyMessage function. Do not use in combination with <b>BSF_QUERY</b>.
///            </td> </tr> </table>
///    lpInfo = Type: <b>LPDWORD</b> A pointer to a variable that contains and receives information about the recipients of the
///             message. When the function returns, this variable receives a combination of these values identifying which
///             recipients actually received the message. If this parameter is <b>NULL</b>, the function broadcasts to all
///             components. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BSM_ALLCOMPONENTS"></a><a id="bsm_allcomponents"></a><dl>
///             <dt><b>BSM_ALLCOMPONENTS</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> Broadcast to all system
///             components. </td> </tr> <tr> <td width="40%"><a id="BSM_ALLDESKTOPS"></a><a id="bsm_alldesktops"></a><dl>
///             <dt><b>BSM_ALLDESKTOPS</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Broadcast to all desktops.
///             Requires the SE_TCB_NAME privilege. </td> </tr> <tr> <td width="40%"><a id="BSM_APPLICATIONS"></a><a
///             id="bsm_applications"></a><dl> <dt><b>BSM_APPLICATIONS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
///             Broadcast to applications. </td> </tr> </table>
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>long</b> If the function succeeds, the return value is a positive value. If the function is unable to
///    broadcast the message, the return value is –1. If the <i>dwFlags</i> parameter is <b>BSF_QUERY</b> and at least
///    one recipient returned <b>BROADCAST_QUERY_DENY</b> to the corresponding message, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
int BroadcastSystemMessageW(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

///Places (posts) a message in the message queue associated with the thread that created the specified window and
///returns without waiting for the thread to process the message. To post a message in the message queue associated with
///a thread, use the PostThreadMessage function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure is to receive the message. The following values
///           have special meanings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id="HWND_BROADCAST"></a><a id="hwnd_broadcast"></a><dl> <dt><b>HWND_BROADCAST</b></dt> <dt>((HWND)0xffff)</dt>
///           </dl> </td> <td width="60%"> The message is posted to all top-level windows in the system, including disabled or
///           invisible unowned windows, overlapped windows, and pop-up windows. The message is not posted to child windows.
///           </td> </tr> <tr> <td width="40%"> <dl> <dt>NULL</dt> </dl> </td> <td width="60%"> The function behaves like a
///           call to PostThreadMessage with the <i>dwThreadId</i> parameter set to the identifier of the current thread. </td>
///           </tr> </table> Starting with Windows Vista, message posting is subject to UIPI. The thread of a process can post
///           messages only to message queues of threads in processes of lesser or equal integrity level.
///    Msg = Type: <b>UINT</b> The message to be posted. For lists of the system-provided messages, see System-Defined
///          Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. <b>GetLastError</b> returns
///    <b>ERROR_NOT_ENOUGH_QUOTA</b> when the limit is hit.
///    
@DllImport("USER32")
BOOL PostMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Places (posts) a message in the message queue associated with the thread that created the specified window and
///returns without waiting for the thread to process the message. To post a message in the message queue associated with
///a thread, use the PostThreadMessage function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose window procedure is to receive the message. The following values
///           have special meanings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id="HWND_BROADCAST"></a><a id="hwnd_broadcast"></a><dl> <dt><b>HWND_BROADCAST</b></dt> <dt>((HWND)0xffff)</dt>
///           </dl> </td> <td width="60%"> The message is posted to all top-level windows in the system, including disabled or
///           invisible unowned windows, overlapped windows, and pop-up windows. The message is not posted to child windows.
///           </td> </tr> <tr> <td width="40%"> <dl> <dt>NULL</dt> </dl> </td> <td width="60%"> The function behaves like a
///           call to PostThreadMessage with the <i>dwThreadId</i> parameter set to the identifier of the current thread. </td>
///           </tr> </table> Starting with Windows Vista, message posting is subject to UIPI. The thread of a process can post
///           messages only to message queues of threads in processes of lesser or equal integrity level.
///    Msg = Type: <b>UINT</b> The message to be posted. For lists of the system-provided messages, see System-Defined
///          Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. <b>GetLastError</b> returns
///    <b>ERROR_NOT_ENOUGH_QUOTA</b> when the limit is hit.
///    
@DllImport("USER32")
BOOL PostMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Posts a message to the message queue of the specified thread. It returns without waiting for the thread to process
///the message.
///Params:
///    idThread = Type: <b>DWORD</b> The identifier of the thread to which the message is to be posted. The function fails if the
///               specified thread does not have a message queue. The system creates a thread's message queue when the thread makes
///               its first call to one of the User or GDI functions. For more information, see the Remarks section. Message
///               posting is subject to UIPI. The thread of a process can post messages only to posted-message queues of threads in
///               processes of lesser or equal integrity level. This thread must have the <b>SE_TCB_NAME</b> privilege to post a
///               message to a thread that belongs to a process with the same locally unique identifier (LUID) but is in a
///               different desktop. Otherwise, the function fails and returns <b>ERROR_INVALID_THREAD_ID</b>. This thread must
///               either belong to the same desktop as the calling thread or to a process with the same LUID. Otherwise, the
///               function fails and returns <b>ERROR_INVALID_THREAD_ID</b>.
///    Msg = Type: <b>UINT</b> The type of message to be posted.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. <b>GetLastError</b> returns
///    <b>ERROR_INVALID_THREAD_ID</b> if <i>idThread</i> is not a valid thread identifier, or if the thread specified by
///    <i>idThread</i> does not have a message queue. <b>GetLastError</b> returns <b>ERROR_NOT_ENOUGH_QUOTA</b> when the
///    message limit is hit.
///    
@DllImport("USER32")
BOOL PostThreadMessageA(uint idThread, uint Msg, WPARAM wParam, LPARAM lParam);

///Posts a message to the message queue of the specified thread. It returns without waiting for the thread to process
///the message.
///Params:
///    idThread = Type: <b>DWORD</b> The identifier of the thread to which the message is to be posted. The function fails if the
///               specified thread does not have a message queue. The system creates a thread's message queue when the thread makes
///               its first call to one of the User or GDI functions. For more information, see the Remarks section. Message
///               posting is subject to UIPI. The thread of a process can post messages only to posted-message queues of threads in
///               processes of lesser or equal integrity level. This thread must have the <b>SE_TCB_NAME</b> privilege to post a
///               message to a thread that belongs to a process with the same locally unique identifier (LUID) but is in a
///               different desktop. Otherwise, the function fails and returns <b>ERROR_INVALID_THREAD_ID</b>. This thread must
///               either belong to the same desktop as the calling thread or to a process with the same LUID. Otherwise, the
///               function fails and returns <b>ERROR_INVALID_THREAD_ID</b>.
///    Msg = Type: <b>UINT</b> The type of message to be posted.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. <b>GetLastError</b> returns
///    <b>ERROR_INVALID_THREAD_ID</b> if <i>idThread</i> is not a valid thread identifier, or if the thread specified by
///    <i>idThread</i> does not have a message queue. <b>GetLastError</b> returns <b>ERROR_NOT_ENOUGH_QUOTA</b> when the
///    message limit is hit.
///    
@DllImport("USER32")
BOOL PostThreadMessageW(uint idThread, uint Msg, WPARAM wParam, LPARAM lParam);

///Replies to a message sent from another thread by the SendMessage function.
///Params:
///    lResult = Type: <b>LRESULT</b> The result of the message processing. The possible values are based on the message sent.
///Returns:
///    Type: <b>BOOL</b> If the calling thread was processing a message sent from another thread or process, the return
///    value is nonzero. If the calling thread was not processing a message sent from another thread or process, the
///    return value is zero.
///    
@DllImport("USER32")
BOOL ReplyMessage(LRESULT lResult);

///Yields control to other threads when a thread has no other messages in its message queue. The <b>WaitMessage</b>
///function suspends the thread and does not return until a new message is placed in the thread's message queue.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL WaitMessage();

///Calls the default window procedure to provide default processing for any window messages that an application does not
///process. This function ensures that every message is processed. <b>DefWindowProc</b> is called with the same
///parameters received by the window procedure.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window procedure that received the message.
///    Msg = Type: <b>UINT</b> The message.
///    wParam = Type: <b>WPARAM</b> Additional message information. The content of this parameter depends on the value of the
///             <i>Msg</i> parameter.
///    lParam = Type: <b>LPARAM</b> Additional message information. The content of this parameter depends on the value of the
///             <i>Msg</i> parameter.
///Returns:
///    Type: <b>LRESULT</b> The return value is the result of the message processing and depends on the message.
///    
@DllImport("USER32")
LRESULT DefWindowProcA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Calls the default window procedure to provide default processing for any window messages that an application does not
///process. This function ensures that every message is processed. <b>DefWindowProc</b> is called with the same
///parameters received by the window procedure.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window procedure that received the message.
///    Msg = Type: <b>UINT</b> The message.
///    wParam = Type: <b>WPARAM</b> Additional message information. The content of this parameter depends on the value of the
///             <i>Msg</i> parameter.
///    lParam = Type: <b>LPARAM</b> Additional message information. The content of this parameter depends on the value of the
///             <i>Msg</i> parameter.
///Returns:
///    Type: <b>LRESULT</b> The return value is the result of the message processing and depends on the message.
///    
@DllImport("USER32")
LRESULT DefWindowProcW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Indicates to the system that a thread has made a request to terminate (quit). It is typically used in response to a
///WM_DESTROY message.
///Params:
///    nExitCode = Type: <b>int</b> The application exit code. This value is used as the <i>wParam</i> parameter of the WM_QUIT
///                message.
@DllImport("USER32")
void PostQuitMessage(int nExitCode);

///Passes message information to the specified window procedure.
///Params:
///    lpPrevWndFunc = Type: <b>WNDPROC</b> The previous window procedure. If this value is obtained by calling the GetWindowLong
///                    function with the <i>nIndex</i> parameter set to <b>GWL_WNDPROC</b> or <b>DWL_DLGPROC</b>, it is actually either
///                    the address of a window or dialog box procedure, or a special internal value meaningful only to
///                    <b>CallWindowProc</b>.
///    hWnd = Type: <b>HWND</b> A handle to the window procedure to receive the message.
///    Msg = Type: <b>UINT</b> The message.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information. The contents of this parameter depend on the value
///             of the <i>Msg</i> parameter.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information. The contents of this parameter depend on the value
///             of the <i>Msg</i> parameter.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message
///    sent.
///    
@DllImport("USER32")
LRESULT CallWindowProcA(WNDPROC lpPrevWndFunc, HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Passes message information to the specified window procedure.
///Params:
///    lpPrevWndFunc = Type: <b>WNDPROC</b> The previous window procedure. If this value is obtained by calling the GetWindowLong
///                    function with the <i>nIndex</i> parameter set to <b>GWL_WNDPROC</b> or <b>DWL_DLGPROC</b>, it is actually either
///                    the address of a window or dialog box procedure, or a special internal value meaningful only to
///                    <b>CallWindowProc</b>.
///    hWnd = Type: <b>HWND</b> A handle to the window procedure to receive the message.
///    Msg = Type: <b>UINT</b> The message.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information. The contents of this parameter depend on the value
///             of the <i>Msg</i> parameter.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information. The contents of this parameter depend on the value
///             of the <i>Msg</i> parameter.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message
///    sent.
///    
@DllImport("USER32")
LRESULT CallWindowProcW(WNDPROC lpPrevWndFunc, HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

///Determines whether the current window procedure is processing a message that was sent from another thread (in the
///same process or a different process) by a call to the SendMessage function. To obtain additional information about
///how the message was sent, use the InSendMessageEx function.
///Returns:
///    Type: <b>BOOL</b> If the window procedure is processing a message sent to it from another thread using the
///    SendMessage function, the return value is nonzero. If the window procedure is not processing a message sent to it
///    from another thread using the SendMessage function, the return value is zero.
///    
@DllImport("USER32")
BOOL InSendMessage();

///Determines whether the current window procedure is processing a message that was sent from another thread (in the
///same process or a different process).
///Params:
///    lpReserved = Type: <b>LPVOID</b> Reserved; must be <b>NULL</b>.
///Returns:
///    Type: <b>DWORD</b> If the message was not sent, the return value is <b>ISMEX_NOSEND</b> (0x00000000). Otherwise,
///    the return value is one or more of the following values. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ISMEX_CALLBACK</b></dt> <dt>0x00000004</dt> </dl>
///    </td> <td width="60%"> The message was sent using the SendMessageCallback function. The thread that sent the
///    message is not blocked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ISMEX_NOTIFY</b></dt> <dt>0x00000002</dt>
///    </dl> </td> <td width="60%"> The message was sent using the SendNotifyMessage function. The thread that sent the
///    message is not blocked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ISMEX_REPLIED</b></dt> <dt>0x00000008</dt>
///    </dl> </td> <td width="60%"> The window procedure has processed the message. The thread that sent the message is
///    no longer blocked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ISMEX_SEND</b></dt> <dt>0x00000001</dt> </dl>
///    </td> <td width="60%"> The message was sent using the SendMessage or SendMessageTimeout function. If
///    <b>ISMEX_REPLIED</b> is not set, the thread that sent the message is blocked. </td> </tr> </table>
///    
@DllImport("USER32")
uint InSendMessageEx(void* lpReserved);

///Registers a window class for subsequent use in calls to the CreateWindow or CreateWindowEx function. <div
///class="alert"><b>Note</b> The <b>RegisterClass</b> function has been superseded by the RegisterClassEx function. You
///can still use <b>RegisterClass</b>, however, if you do not need to set the class small icon.</div><div> </div>
///Params:
///    lpWndClass = Type: <b>const WNDCLASS*</b> A pointer to a WNDCLASS structure. You must fill the structure with the appropriate
///                 class attributes before passing it to the function.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is a class atom that uniquely identifies the class
///    being registered. This atom can only be used by the CreateWindow, CreateWindowEx, GetClassInfo, GetClassInfoEx,
///    FindWindow, FindWindowEx, and UnregisterClass functions and the <b>IActiveIMMap::FilterClientWindows</b> method.
///    If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort RegisterClassA(const(WNDCLASSA)* lpWndClass);

///Registers a window class for subsequent use in calls to the CreateWindow or CreateWindowEx function. <div
///class="alert"><b>Note</b> The <b>RegisterClass</b> function has been superseded by the RegisterClassEx function. You
///can still use <b>RegisterClass</b>, however, if you do not need to set the class small icon.</div><div> </div>
///Params:
///    lpWndClass = Type: <b>const WNDCLASS*</b> A pointer to a WNDCLASS structure. You must fill the structure with the appropriate
///                 class attributes before passing it to the function.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is a class atom that uniquely identifies the class
///    being registered. This atom can only be used by the CreateWindow, CreateWindowEx, GetClassInfo, GetClassInfoEx,
///    FindWindow, FindWindowEx, and UnregisterClass functions and the <b>IActiveIMMap::FilterClientWindows</b> method.
///    If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort RegisterClassW(const(WNDCLASSW)* lpWndClass);

///Unregisters a window class, freeing the memory required for the class.
///Params:
///    lpClassName = Type: <b>LPCTSTR</b> A null-terminated string or a class atom. If <i>lpClassName</i> is a string, it specifies
///                  the window class name. This class name must have been registered by a previous call to the RegisterClass or
///                  RegisterClassEx function. System classes, such as dialog box controls, cannot be unregistered. If this parameter
///                  is an atom, it must be a class atom created by a previous call to the <b>RegisterClass</b> or
///                  <b>RegisterClassEx</b> function. The atom must be in the low-order word of <i>lpClassName</i>; the high-order
///                  word must be zero.
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the module that created the class.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the class could not be found or if a
///    window still exists that was created with the class, the return value is zero. To get extended error information,
///    call GetLastError.
///    
@DllImport("USER32")
BOOL UnregisterClassA(const(PSTR) lpClassName, HINSTANCE hInstance);

///Unregisters a window class, freeing the memory required for the class.
///Params:
///    lpClassName = Type: <b>LPCTSTR</b> A null-terminated string or a class atom. If <i>lpClassName</i> is a string, it specifies
///                  the window class name. This class name must have been registered by a previous call to the RegisterClass or
///                  RegisterClassEx function. System classes, such as dialog box controls, cannot be unregistered. If this parameter
///                  is an atom, it must be a class atom created by a previous call to the <b>RegisterClass</b> or
///                  <b>RegisterClassEx</b> function. The atom must be in the low-order word of <i>lpClassName</i>; the high-order
///                  word must be zero.
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the module that created the class.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the class could not be found or if a
///    window still exists that was created with the class, the return value is zero. To get extended error information,
///    call GetLastError.
///    
@DllImport("USER32")
BOOL UnregisterClassW(const(PWSTR) lpClassName, HINSTANCE hInstance);

///Retrieves information about a window class. <div class="alert"><b>Note</b> The <b>GetClassInfo</b> function has been
///superseded by the GetClassInfoEx function. You can still use <b>GetClassInfo</b>, however, if you do not need
///information about the class small icon.</div><div> </div>
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the application that created the class. To retrieve
///                information about classes defined by the system (such as buttons or list boxes), set this parameter to
///                <b>NULL</b>.
///    lpClassName = Type: <b>LPCTSTR</b> The class name. The name must be that of a preregistered class or a class registered by a
///                  previous call to the RegisterClass or RegisterClassEx function. Alternatively, this parameter can be an atom. If
///                  so, it must be a class atom created by a previous call to RegisterClass or RegisterClassEx. The atom must be in
///                  the low-order word of <i>lpClassName</i>; the high-order word must be zero.
///    lpWndClass = Type: <b>LPWNDCLASS</b> A pointer to a WNDCLASS structure that receives the information about the class.
///Returns:
///    Type: <b>BOOL</b> If the function finds a matching class and successfully copies the data, the return value is
///    nonzero. If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetClassInfoA(HINSTANCE hInstance, const(PSTR) lpClassName, WNDCLASSA* lpWndClass);

///Retrieves information about a window class. <div class="alert"><b>Note</b> The <b>GetClassInfo</b> function has been
///superseded by the GetClassInfoEx function. You can still use <b>GetClassInfo</b>, however, if you do not need
///information about the class small icon.</div><div> </div>
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the application that created the class. To retrieve
///                information about classes defined by the system (such as buttons or list boxes), set this parameter to
///                <b>NULL</b>.
///    lpClassName = Type: <b>LPCTSTR</b> The class name. The name must be that of a preregistered class or a class registered by a
///                  previous call to the RegisterClass or RegisterClassEx function. Alternatively, this parameter can be an atom. If
///                  so, it must be a class atom created by a previous call to RegisterClass or RegisterClassEx. The atom must be in
///                  the low-order word of <i>lpClassName</i>; the high-order word must be zero.
///    lpWndClass = Type: <b>LPWNDCLASS</b> A pointer to a WNDCLASS structure that receives the information about the class.
///Returns:
///    Type: <b>BOOL</b> If the function finds a matching class and successfully copies the data, the return value is
///    nonzero. If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetClassInfoW(HINSTANCE hInstance, const(PWSTR) lpClassName, WNDCLASSW* lpWndClass);

///Registers a window class for subsequent use in calls to the CreateWindow or CreateWindowEx function.
///Params:
///    Arg1 = Type: <b>const WNDCLASSEX*</b> A pointer to a WNDCLASSEX structure. You must fill the structure with the
///           appropriate class attributes before passing it to the function.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is a class atom that uniquely identifies the class
///    being registered. This atom can only be used by the CreateWindow, CreateWindowEx, GetClassInfo, GetClassInfoEx,
///    FindWindow, FindWindowEx, and UnregisterClass functions and the <b>IActiveIMMap::FilterClientWindows</b> method.
///    If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort RegisterClassExA(const(WNDCLASSEXA)* param0);

///Registers a window class for subsequent use in calls to the CreateWindow or CreateWindowEx function.
///Params:
///    Arg1 = Type: <b>const WNDCLASSEX*</b> A pointer to a WNDCLASSEX structure. You must fill the structure with the
///           appropriate class attributes before passing it to the function.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is a class atom that uniquely identifies the class
///    being registered. This atom can only be used by the CreateWindow, CreateWindowEx, GetClassInfo, GetClassInfoEx,
///    FindWindow, FindWindowEx, and UnregisterClass functions and the <b>IActiveIMMap::FilterClientWindows</b> method.
///    If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort RegisterClassExW(const(WNDCLASSEXW)* param0);

///Retrieves information about a window class, including a handle to the small icon associated with the window class.
///The GetClassInfo function does not retrieve a handle to the small icon.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the application that created the class. To retrieve
///                information about classes defined by the system (such as buttons or list boxes), set this parameter to
///                <b>NULL</b>.
///    lpszClass = Type: <b>LPCTSTR</b> The class name. The name must be that of a preregistered class or a class registered by a
///                previous call to the RegisterClass or RegisterClassEx function. Alternatively, this parameter can be a class atom
///                created by a previous call to <b>RegisterClass</b> or <b>RegisterClassEx</b>. The atom must be in the low-order
///                word of <i>lpszClass</i>; the high-order word must be zero.
///    lpwcx = Type: <b>LPWNDCLASSEX</b> A pointer to a WNDCLASSEX structure that receives the information about the class.
///Returns:
///    Type: <b>BOOL</b> If the function finds a matching class and successfully copies the data, the return value is
///    nonzero. If the function does not find a matching class and successfully copy the data, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetClassInfoExA(HINSTANCE hInstance, const(PSTR) lpszClass, WNDCLASSEXA* lpwcx);

///Retrieves information about a window class, including a handle to the small icon associated with the window class.
///The GetClassInfo function does not retrieve a handle to the small icon.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the application that created the class. To retrieve
///                information about classes defined by the system (such as buttons or list boxes), set this parameter to
///                <b>NULL</b>.
///    lpszClass = Type: <b>LPCTSTR</b> The class name. The name must be that of a preregistered class or a class registered by a
///                previous call to the RegisterClass or RegisterClassEx function. Alternatively, this parameter can be a class atom
///                created by a previous call to <b>RegisterClass</b> or <b>RegisterClassEx</b>. The atom must be in the low-order
///                word of <i>lpszClass</i>; the high-order word must be zero.
///    lpwcx = Type: <b>LPWNDCLASSEX</b> A pointer to a WNDCLASSEX structure that receives the information about the class.
///Returns:
///    Type: <b>BOOL</b> If the function finds a matching class and successfully copies the data, the return value is
///    nonzero. If the function does not find a matching class and successfully copy the data, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetClassInfoExW(HINSTANCE hInstance, const(PWSTR) lpszClass, WNDCLASSEXW* lpwcx);

///Creates an overlapped, pop-up, or child window with an extended window style; otherwise, this function is identical
///to the CreateWindow function. For more information about creating a window and for full descriptions of the other
///parameters of <b>CreateWindowEx</b>, see <b>CreateWindow</b>.
///Params:
///    dwExStyle = Type: <b>DWORD</b> The extended window style of the window being created. For a list of possible values, see
///                Extended Window Styles.
///    lpClassName = Type: <b>LPCTSTR</b> A <b>null</b>-terminated string or a class atom created by a previous call to the
///                  RegisterClass or RegisterClassEx function. The atom must be in the low-order word of <i>lpClassName</i>; the
///                  high-order word must be zero. If <i>lpClassName</i> is a string, it specifies the window class name. The class
///                  name can be any name registered with <b>RegisterClass</b> or <b>RegisterClassEx</b>, provided that the module
///                  that registers the class is also the module that creates the window. The class name can also be any of the
///                  predefined system class names.
///    lpWindowName = Type: <b>LPCTSTR</b> The window name. If the window style specifies a title bar, the window title pointed to by
///                   <i>lpWindowName</i> is displayed in the title bar. When using CreateWindow to create controls, such as buttons,
///                   check boxes, and static controls, use <i>lpWindowName</i> to specify the text of the control. When creating a
///                   static control with the <b>SS_ICON</b> style, use <i>lpWindowName</i> to specify the icon name or identifier. To
///                   specify an identifier, use the syntax "
///    dwStyle = Type: <b>DWORD</b> The style of the window being created. This parameter can be a combination of the window style
///              values, plus the control styles indicated in the Remarks section.
///    X = Type: <b>int</b> The initial horizontal position of the window. For an overlapped or pop-up window, the <i>x</i>
///        parameter is the initial x-coordinate of the window's upper-left corner, in screen coordinates. For a child
///        window, <i>x</i> is the x-coordinate of the upper-left corner of the window relative to the upper-left corner of
///        the parent window's client area. If <i>x</i> is set to <b>CW_USEDEFAULT</b>, the system selects the default
///        position for the window's upper-left corner and ignores the <i>y</i> parameter. <b>CW_USEDEFAULT</b> is valid
///        only for overlapped windows; if it is specified for a pop-up or child window, the <i>x</i> and <i>y</i>
///        parameters are set to zero.
///    Y = Type: <b>int</b> The initial vertical position of the window. For an overlapped or pop-up window, the <i>y</i>
///        parameter is the initial y-coordinate of the window's upper-left corner, in screen coordinates. For a child
///        window, <i>y</i> is the initial y-coordinate of the upper-left corner of the child window relative to the
///        upper-left corner of the parent window's client area. For a list box <i>y</i> is the initial y-coordinate of the
///        upper-left corner of the list box's client area relative to the upper-left corner of the parent window's client
///        area. If an overlapped window is created with the <b>WS_VISIBLE</b> style bit set and the <i>x</i> parameter is
///        set to <b>CW_USEDEFAULT</b>, then the <i>y</i> parameter determines how the window is shown. If the <i>y</i>
///        parameter is <b>CW_USEDEFAULT</b>, then the window manager calls ShowWindow with the <b>SW_SHOW</b> flag after
///        the window has been created. If the <i>y</i> parameter is some other value, then the window manager calls
///        <b>ShowWindow</b> with that value as the <i>nCmdShow</i> parameter.
///    nWidth = Type: <b>int</b> The width, in device units, of the window. For overlapped windows, <i>nWidth</i> is the window's
///             width, in screen coordinates, or <b>CW_USEDEFAULT</b>. If <i>nWidth</i> is <b>CW_USEDEFAULT</b>, the system
///             selects a default width and height for the window; the default width extends from the initial x-coordinates to
///             the right edge of the screen; the default height extends from the initial y-coordinate to the top of the icon
///             area. <b>CW_USEDEFAULT</b> is valid only for overlapped windows; if <b>CW_USEDEFAULT</b> is specified for a
///             pop-up or child window, the <i>nWidth</i> and <i>nHeight</i> parameter are set to zero.
///    nHeight = Type: <b>int</b> The height, in device units, of the window. For overlapped windows, <i>nHeight</i> is the
///              window's height, in screen coordinates. If the <i>nWidth</i> parameter is set to <b>CW_USEDEFAULT</b>, the system
///              ignores <i>nHeight</i>.
///    hWndParent = Type: <b>HWND</b> A handle to the parent or owner window of the window being created. To create a child window or
///                 an owned window, supply a valid window handle. This parameter is optional for pop-up windows. To create a
///                 message-only window, supply <b>HWND_MESSAGE</b> or a handle to an existing message-only window.
///    hMenu = Type: <b>HMENU</b> A handle to a menu, or specifies a child-window identifier, depending on the window style. For
///            an overlapped or pop-up window, <i>hMenu</i> identifies the menu to be used with the window; it can be
///            <b>NULL</b> if the class menu is to be used. For a child window, <i>hMenu</i> specifies the child-window
///            identifier, an integer value used by a dialog box control to notify its parent about events. The application
///            determines the child-window identifier; it must be unique for all child windows with the same parent window.
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the module to be associated with the window.
///    lpParam = Type: <b>LPVOID</b> Pointer to a value to be passed to the window through the CREATESTRUCT structure
///              (<b>lpCreateParams</b> member) pointed to by the <i>lParam</i> param of the <b>WM_CREATE</b> message. This
///              message is sent to the created window by this function before it returns. If an application calls CreateWindow to
///              create a MDI client window, <i>lpParam</i> should point to a CLIENTCREATESTRUCT structure. If an MDI client
///              window calls <b>CreateWindow</b> to create an MDI child window, <i>lpParam</i> should point to a MDICREATESTRUCT
///              structure. <i>lpParam</i> may be <b>NULL</b> if no additional data is needed.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the new window. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError. This function
///    typically fails for one of the following reasons: <ul> <li>an invalid parameter value</li> <li>the system class
///    was registered by a different module</li> <li>The <b>WH_CBT</b> hook is installed and returns a failure code</li>
///    <li>if one of the controls in the dialog template is not registered, or its window window procedure fails
///    WM_CREATE or WM_NCCREATE </li> </ul>
///    
@DllImport("USER32")
HWND CreateWindowExA(uint dwExStyle, const(PSTR) lpClassName, const(PSTR) lpWindowName, uint dwStyle, int X, int Y, 
                     int nWidth, int nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, void* lpParam);

///Creates an overlapped, pop-up, or child window with an extended window style; otherwise, this function is identical
///to the CreateWindow function. For more information about creating a window and for full descriptions of the other
///parameters of <b>CreateWindowEx</b>, see <b>CreateWindow</b>.
///Params:
///    dwExStyle = Type: <b>DWORD</b> The extended window style of the window being created. For a list of possible values, see
///                Extended Window Styles.
///    lpClassName = Type: <b>LPCTSTR</b> A <b>null</b>-terminated string or a class atom created by a previous call to the
///                  RegisterClass or RegisterClassEx function. The atom must be in the low-order word of <i>lpClassName</i>; the
///                  high-order word must be zero. If <i>lpClassName</i> is a string, it specifies the window class name. The class
///                  name can be any name registered with <b>RegisterClass</b> or <b>RegisterClassEx</b>, provided that the module
///                  that registers the class is also the module that creates the window. The class name can also be any of the
///                  predefined system class names.
///    lpWindowName = Type: <b>LPCTSTR</b> The window name. If the window style specifies a title bar, the window title pointed to by
///                   <i>lpWindowName</i> is displayed in the title bar. When using CreateWindow to create controls, such as buttons,
///                   check boxes, and static controls, use <i>lpWindowName</i> to specify the text of the control. When creating a
///                   static control with the <b>SS_ICON</b> style, use <i>lpWindowName</i> to specify the icon name or identifier. To
///                   specify an identifier, use the syntax "
///    dwStyle = Type: <b>DWORD</b> The style of the window being created. This parameter can be a combination of the window style
///              values, plus the control styles indicated in the Remarks section.
///    X = Type: <b>int</b> The initial horizontal position of the window. For an overlapped or pop-up window, the <i>x</i>
///        parameter is the initial x-coordinate of the window's upper-left corner, in screen coordinates. For a child
///        window, <i>x</i> is the x-coordinate of the upper-left corner of the window relative to the upper-left corner of
///        the parent window's client area. If <i>x</i> is set to <b>CW_USEDEFAULT</b>, the system selects the default
///        position for the window's upper-left corner and ignores the <i>y</i> parameter. <b>CW_USEDEFAULT</b> is valid
///        only for overlapped windows; if it is specified for a pop-up or child window, the <i>x</i> and <i>y</i>
///        parameters are set to zero.
///    Y = Type: <b>int</b> The initial vertical position of the window. For an overlapped or pop-up window, the <i>y</i>
///        parameter is the initial y-coordinate of the window's upper-left corner, in screen coordinates. For a child
///        window, <i>y</i> is the initial y-coordinate of the upper-left corner of the child window relative to the
///        upper-left corner of the parent window's client area. For a list box <i>y</i> is the initial y-coordinate of the
///        upper-left corner of the list box's client area relative to the upper-left corner of the parent window's client
///        area. If an overlapped window is created with the <b>WS_VISIBLE</b> style bit set and the <i>x</i> parameter is
///        set to <b>CW_USEDEFAULT</b>, then the <i>y</i> parameter determines how the window is shown. If the <i>y</i>
///        parameter is <b>CW_USEDEFAULT</b>, then the window manager calls ShowWindow with the <b>SW_SHOW</b> flag after
///        the window has been created. If the <i>y</i> parameter is some other value, then the window manager calls
///        <b>ShowWindow</b> with that value as the <i>nCmdShow</i> parameter.
///    nWidth = Type: <b>int</b> The width, in device units, of the window. For overlapped windows, <i>nWidth</i> is the window's
///             width, in screen coordinates, or <b>CW_USEDEFAULT</b>. If <i>nWidth</i> is <b>CW_USEDEFAULT</b>, the system
///             selects a default width and height for the window; the default width extends from the initial x-coordinates to
///             the right edge of the screen; the default height extends from the initial y-coordinate to the top of the icon
///             area. <b>CW_USEDEFAULT</b> is valid only for overlapped windows; if <b>CW_USEDEFAULT</b> is specified for a
///             pop-up or child window, the <i>nWidth</i> and <i>nHeight</i> parameter are set to zero.
///    nHeight = Type: <b>int</b> The height, in device units, of the window. For overlapped windows, <i>nHeight</i> is the
///              window's height, in screen coordinates. If the <i>nWidth</i> parameter is set to <b>CW_USEDEFAULT</b>, the system
///              ignores <i>nHeight</i>.
///    hWndParent = Type: <b>HWND</b> A handle to the parent or owner window of the window being created. To create a child window or
///                 an owned window, supply a valid window handle. This parameter is optional for pop-up windows. To create a
///                 message-only window, supply <b>HWND_MESSAGE</b> or a handle to an existing message-only window.
///    hMenu = Type: <b>HMENU</b> A handle to a menu, or specifies a child-window identifier, depending on the window style. For
///            an overlapped or pop-up window, <i>hMenu</i> identifies the menu to be used with the window; it can be
///            <b>NULL</b> if the class menu is to be used. For a child window, <i>hMenu</i> specifies the child-window
///            identifier, an integer value used by a dialog box control to notify its parent about events. The application
///            determines the child-window identifier; it must be unique for all child windows with the same parent window.
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the module to be associated with the window.
///    lpParam = Type: <b>LPVOID</b> Pointer to a value to be passed to the window through the CREATESTRUCT structure
///              (<b>lpCreateParams</b> member) pointed to by the <i>lParam</i> param of the <b>WM_CREATE</b> message. This
///              message is sent to the created window by this function before it returns. If an application calls CreateWindow to
///              create a MDI client window, <i>lpParam</i> should point to a CLIENTCREATESTRUCT structure. If an MDI client
///              window calls <b>CreateWindow</b> to create an MDI child window, <i>lpParam</i> should point to a MDICREATESTRUCT
///              structure. <i>lpParam</i> may be <b>NULL</b> if no additional data is needed.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the new window. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError. This function
///    typically fails for one of the following reasons: <ul> <li>an invalid parameter value</li> <li>the system class
///    was registered by a different module</li> <li>The <b>WH_CBT</b> hook is installed and returns a failure code</li>
///    <li>if one of the controls in the dialog template is not registered, or its window window procedure fails
///    WM_CREATE or WM_NCCREATE </li> </ul>
///    
@DllImport("USER32")
HWND CreateWindowExW(uint dwExStyle, const(PWSTR) lpClassName, const(PWSTR) lpWindowName, uint dwStyle, int X, 
                     int Y, int nWidth, int nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, 
                     void* lpParam);

///Determines whether the specified window handle identifies an existing window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> If the window handle identifies an existing window, the return value is nonzero. If the window
///    handle does not identify an existing window, the return value is zero.
///    
@DllImport("USER32")
BOOL IsWindow(HWND hWnd);

///Determines whether a window is a child window or descendant window of a specified parent window. A child window is
///the direct descendant of a specified parent window if that parent window is in the chain of parent windows; the chain
///of parent windows leads from the original overlapped or pop-up window to the child window.
///Params:
///    hWndParent = Type: <b>HWND</b> A handle to the parent window.
///    hWnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> If the window is a child or descendant window of the specified parent window, the return value
///    is nonzero. If the window is not a child or descendant window of the specified parent window, the return value is
///    zero.
///    
@DllImport("USER32")
BOOL IsChild(HWND hWndParent, HWND hWnd);

///Destroys the specified window. The function sends WM_DESTROY and WM_NCDESTROY messages to the window to deactivate it
///and remove the keyboard focus from it. The function also destroys the window's menu, flushes the thread message
///queue, destroys timers, removes clipboard ownership, and breaks the clipboard viewer chain (if the window is at the
///top of the viewer chain). If the specified window is a parent or owner window, <b>DestroyWindow</b> automatically
///destroys the associated child or owned windows when it destroys the parent or owner window. The function first
///destroys child or owned windows, and then it destroys the parent or owner window. <b>DestroyWindow</b> also destroys
///modeless dialog boxes created by the CreateDialog function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be destroyed.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DestroyWindow(HWND hWnd);

///Sets the specified window's show state.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    nCmdShow = Type: <b>int</b> Controls how the window is to be shown. This parameter is ignored the first time an application
///               calls <b>ShowWindow</b>, if the program that launched the application provides a STARTUPINFO structure.
///               Otherwise, the first time <b>ShowWindow</b> is called, the value should be the value obtained by the WinMain
///               function in its <i>nCmdShow</i> parameter. In subsequent calls, this parameter can be one of the following
///               values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SW_FORCEMINIMIZE"></a><a
///               id="sw_forceminimize"></a><dl> <dt><b>SW_FORCEMINIMIZE</b></dt> <dt>11</dt> </dl> </td> <td width="60%">
///               Minimizes a window, even if the thread that owns the window is not responding. This flag should only be used when
///               minimizing windows from a different thread. </td> </tr> <tr> <td width="40%"><a id="SW_HIDE"></a><a
///               id="sw_hide"></a><dl> <dt><b>SW_HIDE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Hides the window and
///               activates another window. </td> </tr> <tr> <td width="40%"><a id="SW_MAXIMIZE"></a><a id="sw_maximize"></a><dl>
///               <dt><b>SW_MAXIMIZE</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Maximizes the specified window. </td> </tr>
///               <tr> <td width="40%"><a id="SW_MINIMIZE"></a><a id="sw_minimize"></a><dl> <dt><b>SW_MINIMIZE</b></dt> <dt>6</dt>
///               </dl> </td> <td width="60%"> Minimizes the specified window and activates the next top-level window in the Z
///               order. </td> </tr> <tr> <td width="40%"><a id="SW_RESTORE"></a><a id="sw_restore"></a><dl>
///               <dt><b>SW_RESTORE</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> Activates and displays the window. If the
///               window is minimized or maximized, the system restores it to its original size and position. An application should
///               specify this flag when restoring a minimized window. </td> </tr> <tr> <td width="40%"><a id="SW_SHOW"></a><a
///               id="sw_show"></a><dl> <dt><b>SW_SHOW</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Activates the window and
///               displays it in its current size and position. </td> </tr> <tr> <td width="40%"><a id="SW_SHOWDEFAULT"></a><a
///               id="sw_showdefault"></a><dl> <dt><b>SW_SHOWDEFAULT</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> Sets the
///               show state based on the SW_ value specified in the STARTUPINFO structure passed to the CreateProcess function by
///               the program that started the application. </td> </tr> <tr> <td width="40%"><a id="SW_SHOWMAXIMIZED"></a><a
///               id="sw_showmaximized"></a><dl> <dt><b>SW_SHOWMAXIMIZED</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Activates
///               the window and displays it as a maximized window. </td> </tr> <tr> <td width="40%"><a
///               id="SW_SHOWMINIMIZED"></a><a id="sw_showminimized"></a><dl> <dt><b>SW_SHOWMINIMIZED</b></dt> <dt>2</dt> </dl>
///               </td> <td width="60%"> Activates the window and displays it as a minimized window. </td> </tr> <tr> <td
///               width="40%"><a id="SW_SHOWMINNOACTIVE"></a><a id="sw_showminnoactive"></a><dl> <dt><b>SW_SHOWMINNOACTIVE</b></dt>
///               <dt>7</dt> </dl> </td> <td width="60%"> Displays the window as a minimized window. This value is similar to
///               <b>SW_SHOWMINIMIZED</b>, except the window is not activated. </td> </tr> <tr> <td width="40%"><a
///               id="SW_SHOWNA"></a><a id="sw_showna"></a><dl> <dt><b>SW_SHOWNA</b></dt> <dt>8</dt> </dl> </td> <td width="60%">
///               Displays the window in its current size and position. This value is similar to <b>SW_SHOW</b>, except that the
///               window is not activated. </td> </tr> <tr> <td width="40%"><a id="SW_SHOWNOACTIVATE"></a><a
///               id="sw_shownoactivate"></a><dl> <dt><b>SW_SHOWNOACTIVATE</b></dt> <dt>4</dt> </dl> </td> <td width="60%">
///               Displays a window in its most recent size and position. This value is similar to <b>SW_SHOWNORMAL</b>, except
///               that the window is not activated. </td> </tr> <tr> <td width="40%"><a id="SW_SHOWNORMAL"></a><a
///               id="sw_shownormal"></a><dl> <dt><b>SW_SHOWNORMAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Activates and
///               displays a window. If the window is minimized or maximized, the system restores it to its original size and
///               position. An application should specify this flag when displaying the window for the first time. </td> </tr>
///               </table>
///Returns:
///    Type: <b>BOOL</b> If the window was previously visible, the return value is nonzero. If the window was previously
///    hidden, the return value is zero.
///    
@DllImport("USER32")
BOOL ShowWindow(HWND hWnd, int nCmdShow);

///Enables you to produce special effects when showing or hiding windows. There are four types of animation: roll,
///slide, collapse or expand, and alpha-blended fade.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to animate. The calling thread must own this window.
///    dwTime = Type: <b>DWORD</b> The time it takes to play the animation, in milliseconds. Typically, an animation takes 200
///             milliseconds to play.
///    dwFlags = Type: <b>DWORD</b> The type of animation. This parameter can be one or more of the following values. Note that,
///              by default, these flags take effect when showing a window. To take effect when hiding a window, use
///              <b>AW_HIDE</b> and a logical OR operator with the appropriate flags. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"><a id="AW_ACTIVATE"></a><a id="aw_activate"></a><dl> <dt><b>AW_ACTIVATE</b></dt>
///              <dt>0x00020000</dt> </dl> </td> <td width="60%"> Activates the window. Do not use this value with <b>AW_HIDE</b>.
///              </td> </tr> <tr> <td width="40%"><a id="AW_BLEND"></a><a id="aw_blend"></a><dl> <dt><b>AW_BLEND</b></dt>
///              <dt>0x00080000</dt> </dl> </td> <td width="60%"> Uses a fade effect. This flag can be used only if <i>hwnd</i> is
///              a top-level window. </td> </tr> <tr> <td width="40%"><a id="AW_CENTER"></a><a id="aw_center"></a><dl>
///              <dt><b>AW_CENTER</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Makes the window appear to collapse
///              inward if <b>AW_HIDE</b> is used or expand outward if the <b>AW_HIDE</b> is not used. The various direction flags
///              have no effect. </td> </tr> <tr> <td width="40%"><a id="AW_HIDE"></a><a id="aw_hide"></a><dl>
///              <dt><b>AW_HIDE</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> Hides the window. By default, the window
///              is shown. </td> </tr> <tr> <td width="40%"><a id="AW_HOR_POSITIVE"></a><a id="aw_hor_positive"></a><dl>
///              <dt><b>AW_HOR_POSITIVE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Animates the window from left to
///              right. This flag can be used with roll or slide animation. It is ignored when used with <b>AW_CENTER</b> or
///              <b>AW_BLEND</b>. </td> </tr> <tr> <td width="40%"><a id="AW_HOR_NEGATIVE"></a><a id="aw_hor_negative"></a><dl>
///              <dt><b>AW_HOR_NEGATIVE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Animates the window from right
///              to left. This flag can be used with roll or slide animation. It is ignored when used with <b>AW_CENTER</b> or
///              <b>AW_BLEND</b>. </td> </tr> <tr> <td width="40%"><a id="AW_SLIDE"></a><a id="aw_slide"></a><dl>
///              <dt><b>AW_SLIDE</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Uses slide animation. By default, roll
///              animation is used. This flag is ignored when used with <b>AW_CENTER</b>. </td> </tr> <tr> <td width="40%"><a
///              id="AW_VER_POSITIVE"></a><a id="aw_ver_positive"></a><dl> <dt><b>AW_VER_POSITIVE</b></dt> <dt>0x00000004</dt>
///              </dl> </td> <td width="60%"> Animates the window from top to bottom. This flag can be used with roll or slide
///              animation. It is ignored when used with <b>AW_CENTER</b> or <b>AW_BLEND</b>. </td> </tr> <tr> <td width="40%"><a
///              id="AW_VER_NEGATIVE"></a><a id="aw_ver_negative"></a><dl> <dt><b>AW_VER_NEGATIVE</b></dt> <dt>0x00000008</dt>
///              </dl> </td> <td width="60%"> Animates the window from bottom to top. This flag can be used with roll or slide
///              animation. It is ignored when used with <b>AW_CENTER</b> or <b>AW_BLEND</b>. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The function will fail in the following situations: <ul> <li>If the window is already visible and you
///    are trying to show the window.</li> <li>If the window is already hidden and you are trying to hide the
///    window.</li> <li>If there is no direction specified for the slide or roll animation.</li> <li>When trying to
///    animate a child window with <b>AW_BLEND</b>. </li> <li>If the thread does not own the window. Note that, in this
///    case, <b>AnimateWindow</b> fails but GetLastError returns <b>ERROR_SUCCESS</b>.</li> </ul> To get extended error
///    information, call the GetLastError function.
///    
@DllImport("USER32")
BOOL AnimateWindow(HWND hWnd, uint dwTime, uint dwFlags);

///Updates the position, size, shape, content, and translucency of a layered window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to a layered window. A layered window is created by specifying <b>WS_EX_LAYERED</b>
///           when creating the window with the CreateWindowEx function. <b>Windows 8: </b>The <b>WS_EX_LAYERED</b> style is
///           supported for top-level windows and child windows. Previous Windows versions support <b>WS_EX_LAYERED</b> only
///           for top-level windows.
///    hdcDst = Type: <b>HDC</b> A handle to a DC for the screen. This handle is obtained by specifying <b>NULL</b> when calling
///             the function. It is used for palette color matching when the window contents are updated. If <i>hdcDst</i>
///             is<b>NULL</b>, the default palette will be used. If <i>hdcSrc</i> is <b>NULL</b>, <i>hdcDst</i> must be
///             <b>NULL</b>.
///    pptDst = Type: <b>POINT*</b> A pointer to a structure that specifies the new screen position of the layered window. If the
///             current position is not changing, <i>pptDst</i> can be <b>NULL</b>.
///    psize = Type: <b>SIZE*</b> A pointer to a structure that specifies the new size of the layered window. If the size of the
///            window is not changing, <i>psize</i> can be <b>NULL</b>. If <i>hdcSrc</i> is <b>NULL</b>, <i>psize</i> must be
///            <b>NULL</b>.
///    hdcSrc = Type: <b>HDC</b> A handle to a DC for the surface that defines the layered window. This handle can be obtained by
///             calling the CreateCompatibleDC function. If the shape and visual context of the window are not changing,
///             <i>hdcSrc</i> can be <b>NULL</b>.
///    pptSrc = Type: <b>POINT*</b> A pointer to a structure that specifies the location of the layer in the device context. If
///             <i>hdcSrc</i> is <b>NULL</b>, <i>pptSrc</i> should be <b>NULL</b>.
///    crKey = Type: <b>COLORREF</b> A structure that specifies the color key to be used when composing the layered window. To
///            generate a COLORREF, use the RGB macro.
///    pblend = Type: <b>BLENDFUNCTION*</b> A pointer to a structure that specifies the transparency value to be used when
///             composing the layered window.
///    dwFlags = Type: <b>DWORD</b> This parameter can be one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ULW_ALPHA"></a><a id="ulw_alpha"></a><dl>
///              <dt><b>ULW_ALPHA</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Use <i>pblend</i> as the blend
///              function. If the display mode is 256 colors or less, the effect of this value is the same as the effect of
///              <b>ULW_OPAQUE</b>. </td> </tr> <tr> <td width="40%"><a id="ULW_COLORKEY"></a><a id="ulw_colorkey"></a><dl>
///              <dt><b>ULW_COLORKEY</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Use <i>crKey</i> as the
///              transparency color. </td> </tr> <tr> <td width="40%"><a id="ULW_OPAQUE"></a><a id="ulw_opaque"></a><dl>
///              <dt><b>ULW_OPAQUE</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Draw an opaque layered window. </td>
///              </tr> <tr> <td width="40%"><a id="ULW_EX_NORESIZE"></a><a id="ulw_ex_noresize"></a><dl>
///              <dt><b>ULW_EX_NORESIZE</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Force the
///              UpdateLayeredWindowIndirect function to fail if the current window size does not match the size specified in the
///              <i>psize</i>. </td> </tr> </table> If <i>hdcSrc</i> is <b>NULL</b>, <i>dwFlags</i> should be zero.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL UpdateLayeredWindow(HWND hWnd, HDC hdcDst, POINT* pptDst, SIZE* psize, HDC hdcSrc, POINT* pptSrc, uint crKey, 
                         BLENDFUNCTION* pblend, uint dwFlags);

///Retrieves the opacity and transparency color key of a layered window.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the layered window. A layered window is created by specifying <b>WS_EX_LAYERED</b>
///           when creating the window with the CreateWindowEx function or by setting <b>WS_EX_LAYERED</b> using SetWindowLong
///           after the window has been created.
///    pcrKey = Type: <b>COLORREF*</b> A pointer to a COLORREF value that receives the transparency color key to be used when
///             composing the layered window. All pixels painted by the window in this color will be transparent. This can be
///             <b>NULL</b> if the argument is not needed.
///    pbAlpha = Type: <b>BYTE*</b> The Alpha value used to describe the opacity of the layered window. Similar to the
///              <b>SourceConstantAlpha</b> member of the BLENDFUNCTION structure. When the variable referred to by <i>pbAlpha</i>
///              is 0, the window is completely transparent. When the variable referred to by <i>pbAlpha</i> is 255, the window is
///              opaque. This can be <b>NULL</b> if the argument is not needed.
///    pdwFlags = Type: <b>DWORD*</b> A layering flag. This parameter can be <b>NULL</b> if the value is not needed. The layering
///               flag can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="LWA_ALPHA"></a><a id="lwa_alpha"></a><dl> <dt><b>LWA_ALPHA</b></dt> <dt>0x00000002</dt> </dl>
///               </td> <td width="60%"> Use <i>pbAlpha</i> to determine the opacity of the layered window. </td> </tr> <tr> <td
///               width="40%"><a id="LWA_COLORKEY"></a><a id="lwa_colorkey"></a><dl> <dt><b>LWA_COLORKEY</b></dt>
///               <dt>0x00000001</dt> </dl> </td> <td width="60%"> Use <i>pcrKey</i> as the transparency color. </td> </tr>
///               </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetLayeredWindowAttributes(HWND hwnd, uint* pcrKey, ubyte* pbAlpha, uint* pdwFlags);

///Sets the opacity and transparency color key of a layered window.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the layered window. A layered window is created by specifying <b>WS_EX_LAYERED</b>
///           when creating the window with the CreateWindowEx function or by setting <b>WS_EX_LAYERED</b> via SetWindowLong
///           after the window has been created. <b>Windows 8: </b>The <b>WS_EX_LAYERED</b> style is supported for top-level
///           windows and child windows. Previous Windows versions support <b>WS_EX_LAYERED</b> only for top-level windows.
///    crKey = Type: <b>COLORREF</b> A COLORREF structure that specifies the transparency color key to be used when composing
///            the layered window. All pixels painted by the window in this color will be transparent. To generate a
///            <b>COLORREF</b>, use the RGB macro.
///    bAlpha = Type: <b>BYTE</b> Alpha value used to describe the opacity of the layered window. Similar to the
///             <b>SourceConstantAlpha</b> member of the BLENDFUNCTION structure. When <i>bAlpha</i> is 0, the window is
///             completely transparent. When <i>bAlpha</i> is 255, the window is opaque.
///    dwFlags = Type: <b>DWORD</b> An action to be taken. This parameter can be one or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LWA_ALPHA"></a><a id="lwa_alpha"></a><dl>
///              <dt><b>LWA_ALPHA</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Use <i>bAlpha</i> to determine the
///              opacity of the layered window. </td> </tr> <tr> <td width="40%"><a id="LWA_COLORKEY"></a><a
///              id="lwa_colorkey"></a><dl> <dt><b>LWA_COLORKEY</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Use
///              <i>crKey</i> as the transparency color. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetLayeredWindowAttributes(HWND hwnd, uint crKey, ubyte bAlpha, uint dwFlags);

///Sets the show state of a window without waiting for the operation to complete.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    nCmdShow = Type: <b>int</b> Controls how the window is to be shown. For a list of possible values, see the description of
///               the ShowWindow function.
///Returns:
///    Type: <b>BOOL</b> If the operation was successfully started, the return value is nonzero.
///    
@DllImport("USER32")
BOOL ShowWindowAsync(HWND hWnd, int nCmdShow);

///Shows or hides all pop-up windows owned by the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that owns the pop-up windows to be shown or hidden.
///    fShow = Type: <b>BOOL</b> If this parameter is <b>TRUE</b>, all hidden pop-up windows are shown. If this parameter is
///            <b>FALSE</b>, all visible pop-up windows are hidden.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ShowOwnedPopups(HWND hWnd, BOOL fShow);

///Restores a minimized (iconic) window to its previous size and position; it then activates the window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be restored and activated.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL OpenIcon(HWND hWnd);

///Minimizes (but does not destroy) the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be minimized.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL CloseWindow(HWND hWnd);

///Changes the position and dimensions of the specified window. For a top-level window, the position and dimensions are
///relative to the upper-left corner of the screen. For a child window, they are relative to the upper-left corner of
///the parent window's client area.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    X = Type: <b>int</b> The new position of the left side of the window.
///    Y = Type: <b>int</b> The new position of the top of the window.
///    nWidth = Type: <b>int</b> The new width of the window.
///    nHeight = Type: <b>int</b> The new height of the window.
///    bRepaint = Type: <b>BOOL</b> Indicates whether the window is to be repainted. If this parameter is <b>TRUE</b>, the window
///               receives a message. If the parameter is <b>FALSE</b>, no repainting of any kind occurs. This applies to the
///               client area, the nonclient area (including the title bar and scroll bars), and any part of the parent window
///               uncovered as a result of moving a child window.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL MoveWindow(HWND hWnd, int X, int Y, int nWidth, int nHeight, BOOL bRepaint);

///Changes the size, position, and Z order of a child, pop-up, or top-level window. These windows are ordered according
///to their appearance on the screen. The topmost window receives the highest rank and is the first window in the Z
///order.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    hWndInsertAfter = Type: <b>HWND</b> A handle to the window to precede the positioned window in the Z order. This parameter must be
///                      a window handle or one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                      width="40%"><a id="HWND_BOTTOM"></a><a id="hwnd_bottom"></a><dl> <dt><b>HWND_BOTTOM</b></dt> <dt>(HWND)1</dt>
///                      </dl> </td> <td width="60%"> Places the window at the bottom of the Z order. If the <i>hWnd</i> parameter
///                      identifies a topmost window, the window loses its topmost status and is placed at the bottom of all other
///                      windows. </td> </tr> <tr> <td width="40%"><a id="HWND_NOTOPMOST"></a><a id="hwnd_notopmost"></a><dl>
///                      <dt><b>HWND_NOTOPMOST</b></dt> <dt>(HWND)-2</dt> </dl> </td> <td width="60%"> Places the window above all
///                      non-topmost windows (that is, behind all topmost windows). This flag has no effect if the window is already a
///                      non-topmost window. </td> </tr> <tr> <td width="40%"><a id="HWND_TOP"></a><a id="hwnd_top"></a><dl>
///                      <dt><b>HWND_TOP</b></dt> <dt>(HWND)0</dt> </dl> </td> <td width="60%"> Places the window at the top of the Z
///                      order. </td> </tr> <tr> <td width="40%"><a id="HWND_TOPMOST"></a><a id="hwnd_topmost"></a><dl>
///                      <dt><b>HWND_TOPMOST</b></dt> <dt>(HWND)-1</dt> </dl> </td> <td width="60%"> Places the window above all
///                      non-topmost windows. The window maintains its topmost position even when it is deactivated. </td> </tr> </table>
///                      For more information about how this parameter is used, see the following Remarks section.
///    X = Type: <b>int</b> The new position of the left side of the window, in client coordinates.
///    Y = Type: <b>int</b> The new position of the top of the window, in client coordinates.
///    cx = Type: <b>int</b> The new width of the window, in pixels.
///    cy = Type: <b>int</b> The new height of the window, in pixels.
///    uFlags = Type: <b>UINT</b> The window sizing and positioning flags. This parameter can be a combination of the following
///             values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SWP_ASYNCWINDOWPOS"></a><a
///             id="swp_asyncwindowpos"></a><dl> <dt><b>SWP_ASYNCWINDOWPOS</b></dt> <dt>0x4000</dt> </dl> </td> <td width="60%">
///             If the calling thread and the thread that owns the window are attached to different input queues, the system
///             posts the request to the thread that owns the window. This prevents the calling thread from blocking its
///             execution while other threads process the request. </td> </tr> <tr> <td width="40%"><a id="SWP_DEFERERASE"></a><a
///             id="swp_defererase"></a><dl> <dt><b>SWP_DEFERERASE</b></dt> <dt>0x2000</dt> </dl> </td> <td width="60%"> Prevents
///             generation of the WM_SYNCPAINT message. </td> </tr> <tr> <td width="40%"><a id="SWP_DRAWFRAME"></a><a
///             id="swp_drawframe"></a><dl> <dt><b>SWP_DRAWFRAME</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> Draws a
///             frame (defined in the window's class description) around the window. </td> </tr> <tr> <td width="40%"><a
///             id="SWP_FRAMECHANGED"></a><a id="swp_framechanged"></a><dl> <dt><b>SWP_FRAMECHANGED</b></dt> <dt>0x0020</dt>
///             </dl> </td> <td width="60%"> Applies new frame styles set using the SetWindowLong function. Sends a WM_NCCALCSIZE
///             message to the window, even if the window's size is not being changed. If this flag is not specified,
///             <b>WM_NCCALCSIZE</b> is sent only when the window's size is being changed. </td> </tr> <tr> <td width="40%"><a
///             id="SWP_HIDEWINDOW"></a><a id="swp_hidewindow"></a><dl> <dt><b>SWP_HIDEWINDOW</b></dt> <dt>0x0080</dt> </dl>
///             </td> <td width="60%"> Hides the window. </td> </tr> <tr> <td width="40%"><a id="SWP_NOACTIVATE"></a><a
///             id="swp_noactivate"></a><dl> <dt><b>SWP_NOACTIVATE</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> Does not
///             activate the window. If this flag is not set, the window is activated and moved to the top of either the topmost
///             or non-topmost group (depending on the setting of the <i>hWndInsertAfter</i> parameter). </td> </tr> <tr> <td
///             width="40%"><a id="SWP_NOCOPYBITS"></a><a id="swp_nocopybits"></a><dl> <dt><b>SWP_NOCOPYBITS</b></dt>
///             <dt>0x0100</dt> </dl> </td> <td width="60%"> Discards the entire contents of the client area. If this flag is not
///             specified, the valid contents of the client area are saved and copied back into the client area after the window
///             is sized or repositioned. </td> </tr> <tr> <td width="40%"><a id="SWP_NOMOVE"></a><a id="swp_nomove"></a><dl>
///             <dt><b>SWP_NOMOVE</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Retains the current position (ignores
///             <i>X</i> and <i>Y</i> parameters). </td> </tr> <tr> <td width="40%"><a id="SWP_NOOWNERZORDER"></a><a
///             id="swp_noownerzorder"></a><dl> <dt><b>SWP_NOOWNERZORDER</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%">
///             Does not change the owner window's position in the Z order. </td> </tr> <tr> <td width="40%"><a
///             id="SWP_NOREDRAW"></a><a id="swp_noredraw"></a><dl> <dt><b>SWP_NOREDRAW</b></dt> <dt>0x0008</dt> </dl> </td> <td
///             width="60%"> Does not redraw changes. If this flag is set, no repainting of any kind occurs. This applies to the
///             client area, the nonclient area (including the title bar and scroll bars), and any part of the parent window
///             uncovered as a result of the window being moved. When this flag is set, the application must explicitly
///             invalidate or redraw any parts of the window and parent window that need redrawing. </td> </tr> <tr> <td
///             width="40%"><a id="SWP_NOREPOSITION"></a><a id="swp_noreposition"></a><dl> <dt><b>SWP_NOREPOSITION</b></dt>
///             <dt>0x0200</dt> </dl> </td> <td width="60%"> Same as the <b>SWP_NOOWNERZORDER</b> flag. </td> </tr> <tr> <td
///             width="40%"><a id="SWP_NOSENDCHANGING"></a><a id="swp_nosendchanging"></a><dl> <dt><b>SWP_NOSENDCHANGING</b></dt>
///             <dt>0x0400</dt> </dl> </td> <td width="60%"> Prevents the window from receiving the WM_WINDOWPOSCHANGING message.
///             </td> </tr> <tr> <td width="40%"><a id="SWP_NOSIZE"></a><a id="swp_nosize"></a><dl> <dt><b>SWP_NOSIZE</b></dt>
///             <dt>0x0001</dt> </dl> </td> <td width="60%"> Retains the current size (ignores the <i>cx</i> and <i>cy</i>
///             parameters). </td> </tr> <tr> <td width="40%"><a id="SWP_NOZORDER"></a><a id="swp_nozorder"></a><dl>
///             <dt><b>SWP_NOZORDER</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> Retains the current Z order (ignores
///             the <i>hWndInsertAfter</i> parameter). </td> </tr> <tr> <td width="40%"><a id="SWP_SHOWWINDOW"></a><a
///             id="swp_showwindow"></a><dl> <dt><b>SWP_SHOWWINDOW</b></dt> <dt>0x0040</dt> </dl> </td> <td width="60%"> Displays
///             the window. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

///Retrieves the show state and the restored, minimized, and maximized positions of the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    lpwndpl = Type: <b>WINDOWPLACEMENT*</b> A pointer to the WINDOWPLACEMENT structure that receives the show state and
///              position information. Before calling <b>GetWindowPlacement</b>, set the <b>length</b> member to
///              <code>sizeof(WINDOWPLACEMENT)</code>. <b>GetWindowPlacement</b> fails if <i>lpwndpl</i>-&gt; <i>length</i> is not
///              set correctly.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetWindowPlacement(HWND hWnd, WINDOWPLACEMENT* lpwndpl);

///Sets the show state and the restored, minimized, and maximized positions of the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    lpwndpl = Type: <b>const WINDOWPLACEMENT*</b> A pointer to a WINDOWPLACEMENT structure that specifies the new show state
///              and window positions. Before calling <b>SetWindowPlacement</b>, set the <b>length</b> member of the
///              WINDOWPLACEMENT structure to sizeof(<b>WINDOWPLACEMENT</b>). <b>SetWindowPlacement</b> fails if the <b>length</b>
///              member is not set correctly.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetWindowPlacement(HWND hWnd, const(WINDOWPLACEMENT)* lpwndpl);

///Retrieves the current display affinity setting, from any process, for a given window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    pdwAffinity = Type: <b>DWORD*</b> A pointer to a variable that receives the display affinity setting. See
///                  SetWindowDisplayAffinity for a list of affinity settings and their meanings.
///Returns:
///    Type: <b>BOOL</b> This function succeeds only when the window is layered and Desktop Windows Manager is composing
///    the desktop. If this function succeeds, it returns <b>TRUE</b>; otherwise, it returns <b>FALSE</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetWindowDisplayAffinity(HWND hWnd, uint* pdwAffinity);

///Specifies where the content of the window can be displayed.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the top-level window. The window must belong to the current process.
///    dwAffinity = Type: <b>DWORD</b> The display affinity setting that specifies where the content of the window can be displayed.
///                 This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                 width="40%"><a id="WDA_NONE"></a><a id="wda_none"></a><dl> <dt><b>WDA_NONE</b></dt> <dt>0x00000000</dt> </dl>
///                 </td> <td width="60%"> Imposes no restrictions on where the window can be displayed. </td> </tr> <tr> <td
///                 width="40%"><a id="WDA_MONITOR"></a><a id="wda_monitor"></a><dl> <dt><b>WDA_MONITOR</b></dt> <dt>0x00000001</dt>
///                 </dl> </td> <td width="60%"> The window content is displayed only on a monitor. Everywhere else, the window
///                 appears with no content. </td> </tr> <tr> <td width="40%"><a id="WDA_EXCLUDEFROMCAPTURE"></a><a
///                 id="wda_excludefromcapture"></a><dl> <dt><b>WDA_EXCLUDEFROMCAPTURE</b></dt> <dt>0x00000011</dt> </dl> </td> <td
///                 width="60%"> The window is displayed only on a monitor. Everywhere else, the window does not appear at all. One
///                 use for this affinity is for windows that show video recording controls, so that the controls are not included in
///                 the capture. Introduced in Windows 10 Version 2004. See remarks about compatibility regarding previous versions
///                 of Windows. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, it returns <b>TRUE</b>; otherwise, it returns <b>FALSE</b> when, for
///    example, the function call is made on a non top-level window. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
BOOL SetWindowDisplayAffinity(HWND hWnd, uint dwAffinity);

///Allocates memory for a multiple-window- position structure and returns the handle to the structure.
///Params:
///    nNumWindows = Type: <b>int</b> The initial number of windows for which to store position information. The DeferWindowPos
///                  function increases the size of the structure, if necessary.
///Returns:
///    Type: <b>HDWP</b> If the function succeeds, the return value identifies the multiple-window-position structure.
///    If insufficient system resources are available to allocate the structure, the return value is <b>NULL</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t BeginDeferWindowPos(int nNumWindows);

///Updates the specified multiple-window – position structure for the specified window. The function then returns a
///handle to the updated structure. The EndDeferWindowPos function uses the information in this structure to change the
///position and size of a number of windows simultaneously. The BeginDeferWindowPos function creates the structure.
///Params:
///    hWinPosInfo = Type: <b>HDWP</b> A handle to a multiple-window – position structure that contains size and position
///                  information for one or more windows. This structure is returned by BeginDeferWindowPos or by the most recent call
///                  to <b>DeferWindowPos</b>.
///    hWnd = Type: <b>HWND</b> A handle to the window for which update information is stored in the structure. All windows in
///           a multiple-window – position structure must have the same parent.
///    hWndInsertAfter = Type: <b>HWND</b> A handle to the window that precedes the positioned window in the Z order. This parameter must
///                      be a window handle or one of the following values. This parameter is ignored if the <b>SWP_NOZORDER</b> flag is
///                      set in the <i>uFlags</i> parameter. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                      id="HWND_BOTTOM"></a><a id="hwnd_bottom"></a><dl> <dt><b>HWND_BOTTOM</b></dt> <dt>((HWND)1)</dt> </dl> </td> <td
///                      width="60%"> Places the window at the bottom of the Z order. If the <i>hWnd</i> parameter identifies a topmost
///                      window, the window loses its topmost status and is placed at the bottom of all other windows. </td> </tr> <tr>
///                      <td width="40%"><a id="HWND_NOTOPMOST"></a><a id="hwnd_notopmost"></a><dl> <dt><b>HWND_NOTOPMOST</b></dt>
///                      <dt>((HWND)-2)</dt> </dl> </td> <td width="60%"> Places the window above all non-topmost windows (that is, behind
///                      all topmost windows). This flag has no effect if the window is already a non-topmost window. </td> </tr> <tr> <td
///                      width="40%"><a id="HWND_TOP"></a><a id="hwnd_top"></a><dl> <dt><b>HWND_TOP</b></dt> <dt>((HWND)0)</dt> </dl>
///                      </td> <td width="60%"> Places the window at the top of the Z order. </td> </tr> <tr> <td width="40%"><a
///                      id="HWND_TOPMOST"></a><a id="hwnd_topmost"></a><dl> <dt><b>HWND_TOPMOST</b></dt> <dt>((HWND)-1)</dt> </dl> </td>
///                      <td width="60%"> Places the window above all non-topmost windows. The window maintains its topmost position even
///                      when it is deactivated. </td> </tr> </table>
///    x = Type: <b>int</b> The x-coordinate of the window's upper-left corner.
///    y = Type: <b>int</b> The y-coordinate of the window's upper-left corner.
///    cx = Type: <b>int</b> The window's new width, in pixels.
///    cy = Type: <b>int</b> The window's new height, in pixels.
///    uFlags = Type: <b>UINT</b> A combination of the following values that affect the size and position of the window. <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SWP_DRAWFRAME"></a><a
///             id="swp_drawframe"></a><dl> <dt><b>SWP_DRAWFRAME</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> Draws a
///             frame (defined in the window's class description) around the window. </td> </tr> <tr> <td width="40%"><a
///             id="SWP_FRAMECHANGED"></a><a id="swp_framechanged"></a><dl> <dt><b>SWP_FRAMECHANGED</b></dt> <dt>0x0020</dt>
///             </dl> </td> <td width="60%"> Sends a WM_NCCALCSIZE message to the window, even if the window's size is not being
///             changed. If this flag is not specified, <b>WM_NCCALCSIZE</b> is sent only when the window's size is being
///             changed. </td> </tr> <tr> <td width="40%"><a id="SWP_HIDEWINDOW"></a><a id="swp_hidewindow"></a><dl>
///             <dt><b>SWP_HIDEWINDOW</b></dt> <dt>0x0080</dt> </dl> </td> <td width="60%"> Hides the window. </td> </tr> <tr>
///             <td width="40%"><a id="SWP_NOACTIVATE"></a><a id="swp_noactivate"></a><dl> <dt><b>SWP_NOACTIVATE</b></dt>
///             <dt>0x0010</dt> </dl> </td> <td width="60%"> Does not activate the window. If this flag is not set, the window is
///             activated and moved to the top of either the topmost or non-topmost group (depending on the setting of the
///             <i>hWndInsertAfter</i> parameter). </td> </tr> <tr> <td width="40%"><a id="SWP_NOCOPYBITS"></a><a
///             id="swp_nocopybits"></a><dl> <dt><b>SWP_NOCOPYBITS</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Discards
///             the entire contents of the client area. If this flag is not specified, the valid contents of the client area are
///             saved and copied back into the client area after the window is sized or repositioned. </td> </tr> <tr> <td
///             width="40%"><a id="SWP_NOMOVE"></a><a id="swp_nomove"></a><dl> <dt><b>SWP_NOMOVE</b></dt> <dt>0x0002</dt> </dl>
///             </td> <td width="60%"> Retains the current position (ignores the <i>x</i> and <i>y</i> parameters). </td> </tr>
///             <tr> <td width="40%"><a id="SWP_NOOWNERZORDER"></a><a id="swp_noownerzorder"></a><dl>
///             <dt><b>SWP_NOOWNERZORDER</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%"> Does not change the owner window's
///             position in the Z order. </td> </tr> <tr> <td width="40%"><a id="SWP_NOREDRAW"></a><a id="swp_noredraw"></a><dl>
///             <dt><b>SWP_NOREDRAW</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> Does not redraw changes. If this flag
///             is set, no repainting of any kind occurs. This applies to the client area, the nonclient area (including the
///             title bar and scroll bars), and any part of the parent window uncovered as a result of the window being moved.
///             When this flag is set, the application must explicitly invalidate or redraw any parts of the window and parent
///             window that need redrawing. </td> </tr> <tr> <td width="40%"><a id="SWP_NOREPOSITION"></a><a
///             id="swp_noreposition"></a><dl> <dt><b>SWP_NOREPOSITION</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%"> Same
///             as the <b>SWP_NOOWNERZORDER</b> flag. </td> </tr> <tr> <td width="40%"><a id="SWP_NOSENDCHANGING"></a><a
///             id="swp_nosendchanging"></a><dl> <dt><b>SWP_NOSENDCHANGING</b></dt> <dt>0x0400</dt> </dl> </td> <td width="60%">
///             Prevents the window from receiving the WM_WINDOWPOSCHANGING message. </td> </tr> <tr> <td width="40%"><a
///             id="SWP_NOSIZE"></a><a id="swp_nosize"></a><dl> <dt><b>SWP_NOSIZE</b></dt> <dt>0x0001</dt> </dl> </td> <td
///             width="60%"> Retains the current size (ignores the <i>cx</i> and <i>cy</i> parameters). </td> </tr> <tr> <td
///             width="40%"><a id="SWP_NOZORDER"></a><a id="swp_nozorder"></a><dl> <dt><b>SWP_NOZORDER</b></dt> <dt>0x0004</dt>
///             </dl> </td> <td width="60%"> Retains the current Z order (ignores the <i>hWndInsertAfter</i> parameter). </td>
///             </tr> <tr> <td width="40%"><a id="SWP_SHOWWINDOW"></a><a id="swp_showwindow"></a><dl>
///             <dt><b>SWP_SHOWWINDOW</b></dt> <dt>0x0040</dt> </dl> </td> <td width="60%"> Displays the window. </td> </tr>
///             </table>
///Returns:
///    Type: <b>HDWP</b> The return value identifies the updated multiple-window – position structure. The handle
///    returned by this function may differ from the handle passed to the function. The new handle that this function
///    returns should be passed during the next call to the <b>DeferWindowPos</b> or EndDeferWindowPos function. If
///    insufficient system resources are available for the function to succeed, the return value is <b>NULL</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t DeferWindowPos(ptrdiff_t hWinPosInfo, HWND hWnd, HWND hWndInsertAfter, int x, int y, int cx, int cy, 
                         uint uFlags);

///Simultaneously updates the position and size of one or more windows in a single screen-refreshing cycle.
///Params:
///    hWinPosInfo = Type: <b>HDWP</b> A handle to a multiple-window – position structure that contains size and position
///                  information for one or more windows. This internal structure is returned by the BeginDeferWindowPos function or
///                  by the most recent call to the DeferWindowPos function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL EndDeferWindowPos(ptrdiff_t hWinPosInfo);

///Determines the visibility state of the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> If the specified window, its parent window, its parent's parent window, and so forth, have the
///    <b>WS_VISIBLE</b> style, the return value is nonzero. Otherwise, the return value is zero. Because the return
///    value specifies whether the window has the <b>WS_VISIBLE</b> style, it may be nonzero even if the window is
///    totally obscured by other windows.
///    
@DllImport("USER32")
BOOL IsWindowVisible(HWND hWnd);

///Determines whether the specified window is minimized (iconic).
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> If the window is iconic, the return value is nonzero. If the window is not iconic, the return
///    value is zero.
///    
@DllImport("USER32")
BOOL IsIconic(HWND hWnd);

///Indicates whether an owned, visible, top-level pop-up, or overlapped window exists on the screen. The function
///searches the entire screen, not just the calling application's client area. This function is provided only for
///compatibility with 16-bit versions of Windows. It is generally not useful.
///Returns:
///    Type: <b>BOOL</b> If a pop-up window exists, the return value is nonzero, even if the pop-up window is completely
///    covered by other windows. If a pop-up window does not exist, the return value is zero.
///    
@DllImport("USER32")
BOOL AnyPopup();

///Brings the specified window to the top of the Z order. If the window is a top-level window, it is activated. If the
///window is a child window, the top-level parent window associated with the child window is activated.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to bring to the top of the Z order.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL BringWindowToTop(HWND hWnd);

///Determines whether a window is maximized.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> If the window is zoomed, the return value is nonzero. If the window is not zoomed, the return
///    value is zero.
///    
@DllImport("USER32")
BOOL IsZoomed(HWND hWnd);

///Creates a modeless dialog box from a dialog box template resource. Before displaying the dialog box, the function
///passes an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG
///message. An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module which contains the dialog box template. If this parameter is NULL,
///                then the current executable is used.
///    lpTemplateName = Type: <b>LPCTSTR</b> The dialog box template. This parameter is either the pointer to a null-terminated character
///                     string that specifies the name of the dialog box template or an integer value that specifies the resource
///                     identifier of the dialog box template. If the parameter specifies a resource identifier, its high-order word must
///                     be zero and low-order word must contain the identifier. You can use the MAKEINTRESOURCE macro to create this
///                     value.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to be passed to the dialog box procedure in the <i>lParam</i> parameter in the
///                  WM_INITDIALOG message.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND CreateDialogParamA(HINSTANCE hInstance, const(PSTR) lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                        LPARAM dwInitParam);

///Creates a modeless dialog box from a dialog box template resource. Before displaying the dialog box, the function
///passes an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG
///message. An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module which contains the dialog box template. If this parameter is NULL,
///                then the current executable is used.
///    lpTemplateName = Type: <b>LPCTSTR</b> The dialog box template. This parameter is either the pointer to a null-terminated character
///                     string that specifies the name of the dialog box template or an integer value that specifies the resource
///                     identifier of the dialog box template. If the parameter specifies a resource identifier, its high-order word must
///                     be zero and low-order word must contain the identifier. You can use the MAKEINTRESOURCE macro to create this
///                     value.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to be passed to the dialog box procedure in the <i>lParam</i> parameter in the
///                  WM_INITDIALOG message.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND CreateDialogParamW(HINSTANCE hInstance, const(PWSTR) lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                        LPARAM dwInitParam);

///Creates a modeless dialog box from a dialog box template in memory. Before displaying the dialog box, the function
///passes an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG
///message. An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module which contains the dialog box template. If this parameter is NULL,
///                then the current executable is used.
///    lpTemplate = Type: <b>LPCDLGTEMPLATE</b> The template <b>CreateDialogIndirectParam</b> uses to create the dialog box. A dialog
///                 box template consists of a header that describes the dialog box, followed by one or more additional blocks of
///                 data that describe each of the controls in the dialog box. The template can use either the standard format or the
///                 extended format. In a standard template, the header is a DLGTEMPLATE structure followed by additional
///                 variable-length arrays. The data for each control consists of a DLGITEMTEMPLATE structure followed by additional
///                 variable-length arrays. In an extended dialog box template, the header uses the DLGTEMPLATEEX format and the
///                 control definitions use the DLGITEMTEMPLATEEX format. After <b>CreateDialogIndirectParam</b> returns, you can
///                 free the template, which is only used to get the dialog box started.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to pass to the dialog box in the <i>lParam</i> parameter of the WM_INITDIALOG
///                  message.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND CreateDialogIndirectParamA(HINSTANCE hInstance, DLGTEMPLATE* lpTemplate, HWND hWndParent, 
                                DLGPROC lpDialogFunc, LPARAM dwInitParam);

///Creates a modeless dialog box from a dialog box template in memory. Before displaying the dialog box, the function
///passes an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG
///message. An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module which contains the dialog box template. If this parameter is NULL,
///                then the current executable is used.
///    lpTemplate = Type: <b>LPCDLGTEMPLATE</b> The template <b>CreateDialogIndirectParam</b> uses to create the dialog box. A dialog
///                 box template consists of a header that describes the dialog box, followed by one or more additional blocks of
///                 data that describe each of the controls in the dialog box. The template can use either the standard format or the
///                 extended format. In a standard template, the header is a DLGTEMPLATE structure followed by additional
///                 variable-length arrays. The data for each control consists of a DLGITEMTEMPLATE structure followed by additional
///                 variable-length arrays. In an extended dialog box template, the header uses the DLGTEMPLATEEX format and the
///                 control definitions use the DLGITEMTEMPLATEEX format. After <b>CreateDialogIndirectParam</b> returns, you can
///                 free the template, which is only used to get the dialog box started.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to pass to the dialog box in the <i>lParam</i> parameter of the WM_INITDIALOG
///                  message.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND CreateDialogIndirectParamW(HINSTANCE hInstance, DLGTEMPLATE* lpTemplate, HWND hWndParent, 
                                DLGPROC lpDialogFunc, LPARAM dwInitParam);

///Creates a modal dialog box from a dialog box template resource. Before displaying the dialog box, the function passes
///an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG message.
///An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module which contains the dialog box template. If this parameter is NULL,
///                then the current executable is used.
///    lpTemplateName = Type: <b>LPCTSTR</b> The dialog box template. This parameter is either the pointer to a null-terminated character
///                     string that specifies the name of the dialog box template or an integer value that specifies the resource
///                     identifier of the dialog box template. If the parameter specifies a resource identifier, its high-order word must
///                     be zero and its low-order word must contain the identifier. You can use the MAKEINTRESOURCE macro to create this
///                     value.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to pass to the dialog box in the <i>lParam</i> parameter of the WM_INITDIALOG
///                  message.
///Returns:
///    Type: <b>INT_PTR</b> If the function succeeds, the return value is the value of the <i>nResult</i> parameter
///    specified in the call to the EndDialog function used to terminate the dialog box. If the function fails because
///    the <i>hWndParent</i> parameter is invalid, the return value is zero. The function returns zero in this case for
///    compatibility with previous versions of Windows. If the function fails for any other reason, the return value is
///    –1. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t DialogBoxParamA(HINSTANCE hInstance, const(PSTR) lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                          LPARAM dwInitParam);

///Creates a modal dialog box from a dialog box template resource. Before displaying the dialog box, the function passes
///an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG message.
///An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module which contains the dialog box template. If this parameter is NULL,
///                then the current executable is used.
///    lpTemplateName = Type: <b>LPCTSTR</b> The dialog box template. This parameter is either the pointer to a null-terminated character
///                     string that specifies the name of the dialog box template or an integer value that specifies the resource
///                     identifier of the dialog box template. If the parameter specifies a resource identifier, its high-order word must
///                     be zero and its low-order word must contain the identifier. You can use the MAKEINTRESOURCE macro to create this
///                     value.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to pass to the dialog box in the <i>lParam</i> parameter of the WM_INITDIALOG
///                  message.
///Returns:
///    Type: <b>INT_PTR</b> If the function succeeds, the return value is the value of the <i>nResult</i> parameter
///    specified in the call to the EndDialog function used to terminate the dialog box. If the function fails because
///    the <i>hWndParent</i> parameter is invalid, the return value is zero. The function returns zero in this case for
///    compatibility with previous versions of Windows. If the function fails for any other reason, the return value is
///    –1. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t DialogBoxParamW(HINSTANCE hInstance, const(PWSTR) lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                          LPARAM dwInitParam);

///Creates a modal dialog box from a dialog box template in memory. Before displaying the dialog box, the function
///passes an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG
///message. An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module that creates the dialog box.
///    hDialogTemplate = Type: <b>LPCDLGTEMPLATE</b> The template that <b>DialogBoxIndirectParam</b> uses to create the dialog box. A
///                      dialog box template consists of a header that describes the dialog box, followed by one or more additional blocks
///                      of data that describe each of the controls in the dialog box. The template can use either the standard format or
///                      the extended format. In a standard template for a dialog box, the header is a DLGTEMPLATE structure followed by
///                      additional variable-length arrays. The data for each control consists of a DLGITEMTEMPLATE structure followed by
///                      additional variable-length arrays. In an extended template for a dialog box, the header uses the DLGTEMPLATEEX
///                      format and the control definitions use the DLGITEMTEMPLATEEX format.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to pass to the dialog box in the <i>lParam</i> parameter of the WM_INITDIALOG
///                  message.
///Returns:
///    Type: <b>INT_PTR</b> If the function succeeds, the return value is the <i>nResult</i> parameter specified in the
///    call to the EndDialog function that was used to terminate the dialog box. If the function fails because the
///    <i>hWndParent</i> parameter is invalid, the return value is zero. The function returns zero in this case for
///    compatibility with previous versions of Windows. If the function fails for any other reason, the return value is
///    –1. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t DialogBoxIndirectParamA(HINSTANCE hInstance, DLGTEMPLATE* hDialogTemplate, HWND hWndParent, 
                                  DLGPROC lpDialogFunc, LPARAM dwInitParam);

///Creates a modal dialog box from a dialog box template in memory. Before displaying the dialog box, the function
///passes an application-defined value to the dialog box procedure as the <i>lParam</i> parameter of the WM_INITDIALOG
///message. An application can use this value to initialize dialog box controls.
///Params:
///    hInstance = Type: <b>HINSTANCE</b> A handle to the module that creates the dialog box.
///    hDialogTemplate = Type: <b>LPCDLGTEMPLATE</b> The template that <b>DialogBoxIndirectParam</b> uses to create the dialog box. A
///                      dialog box template consists of a header that describes the dialog box, followed by one or more additional blocks
///                      of data that describe each of the controls in the dialog box. The template can use either the standard format or
///                      the extended format. In a standard template for a dialog box, the header is a DLGTEMPLATE structure followed by
///                      additional variable-length arrays. The data for each control consists of a DLGITEMTEMPLATE structure followed by
///                      additional variable-length arrays. In an extended template for a dialog box, the header uses the DLGTEMPLATEEX
///                      format and the control definitions use the DLGITEMTEMPLATEEX format.
///    hWndParent = Type: <b>HWND</b> A handle to the window that owns the dialog box.
///    lpDialogFunc = Type: <b>DLGPROC</b> A pointer to the dialog box procedure. For more information about the dialog box procedure,
///                   see DialogProc.
///    dwInitParam = Type: <b>LPARAM</b> The value to pass to the dialog box in the <i>lParam</i> parameter of the WM_INITDIALOG
///                  message.
///Returns:
///    Type: <b>INT_PTR</b> If the function succeeds, the return value is the <i>nResult</i> parameter specified in the
///    call to the EndDialog function that was used to terminate the dialog box. If the function fails because the
///    <i>hWndParent</i> parameter is invalid, the return value is zero. The function returns zero in this case for
///    compatibility with previous versions of Windows. If the function fails for any other reason, the return value is
///    –1. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t DialogBoxIndirectParamW(HINSTANCE hInstance, DLGTEMPLATE* hDialogTemplate, HWND hWndParent, 
                                  DLGPROC lpDialogFunc, LPARAM dwInitParam);

///Destroys a modal dialog box, causing the system to end any processing for the dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box to be destroyed.
///    nResult = Type: <b>INT_PTR</b> The value to be returned to the application from the function that created the dialog box.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL EndDialog(HWND hDlg, ptrdiff_t nResult);

///Retrieves a handle to a control in the specified dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The identifier of the control to be retrieved.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle of the specified control. If
///    the function fails, the return value is <b>NULL</b>, indicating an invalid dialog box handle or a nonexistent
///    control. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND GetDlgItem(HWND hDlg, int nIDDlgItem);

///Sets the text of a control in a dialog box to the string representation of a specified integer value.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The control to be changed.
///    uValue = Type: <b>UINT</b> The integer value used to generate the item text.
///    bSigned = Type: <b>BOOL</b> Indicates whether the <i>uValue</i> parameter is signed or unsigned. If this parameter is
///              <b>TRUE</b>, <i>uValue</i> is signed. If this parameter is <b>TRUE</b> and <i>uValue</i> is less than zero, a
///              minus sign is placed before the first digit in the string. If this parameter is <b>FALSE</b>, <i>uValue</i> is
///              unsigned.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetDlgItemInt(HWND hDlg, int nIDDlgItem, uint uValue, BOOL bSigned);

///Translates the text of a specified control in a dialog box into an integer value.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control of interest.
///    nIDDlgItem = Type: <b>int</b> The identifier of the control whose text is to be translated.
///    lpTranslated = Type: <b>BOOL*</b> Indicates success or failure (<b>TRUE</b> indicates success, <b>FALSE</b> indicates failure).
///                   If this parameter is <b>NULL</b>, the function returns no information about success or failure.
///    bSigned = Type: <b>BOOL</b> Indicates whether the function should examine the text for a minus sign at the beginning and
///              return a signed integer value if it finds one (<b>TRUE</b> specifies this should be done, <b>FALSE</b> that it
///              should not).
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the variable pointed to by <i>lpTranslated</i> is set to <b>TRUE</b>,
///    and the return value is the translated value of the control text. If the function fails, the variable pointed to
///    by <i>lpTranslated</i> is set to <b>FALSE</b>, and the return value is zero. Note that, because zero is a
///    possible translated value, a return value of zero does not by itself indicate failure. If <i>lpTranslated</i> is
///    <b>NULL</b>, the function returns no information about success or failure. Note that, if the <i>bSigned</i>
///    parameter is <b>TRUE</b> and there is a minus sign (–) at the beginning of the text, <b>GetDlgItemInt</b>
///    translates the text into a signed integer value. Otherwise, the function creates an unsigned integer value. To
///    obtain the proper value in this case, cast the return value to an <b>int</b> type. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
uint GetDlgItemInt(HWND hDlg, int nIDDlgItem, BOOL* lpTranslated, BOOL bSigned);

///Sets the title or text of a control in a dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The control with a title or text to be set.
///    lpString = Type: <b>LPCTSTR</b> The text to be copied to the control.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetDlgItemTextA(HWND hDlg, int nIDDlgItem, const(PSTR) lpString);

///Sets the title or text of a control in a dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The control with a title or text to be set.
///    lpString = Type: <b>LPCTSTR</b> The text to be copied to the control.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetDlgItemTextW(HWND hDlg, int nIDDlgItem, const(PWSTR) lpString);

///Retrieves the title or text associated with a control in a dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The identifier of the control whose title or text is to be retrieved.
///    lpString = Type: <b>LPTSTR</b> The buffer to receive the title or text.
///    cchMax = Type: <b>int</b> The maximum length, in characters, of the string to be copied to the buffer pointed to by
///             <i>lpString</i>. If the length of the string, including the null character, exceeds the limit, the string is
///             truncated.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value specifies the number of characters copied to the
///    buffer, not including the terminating null character. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
uint GetDlgItemTextA(HWND hDlg, int nIDDlgItem, PSTR lpString, int cchMax);

///Retrieves the title or text associated with a control in a dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The identifier of the control whose title or text is to be retrieved.
///    lpString = Type: <b>LPTSTR</b> The buffer to receive the title or text.
///    cchMax = Type: <b>int</b> The maximum length, in characters, of the string to be copied to the buffer pointed to by
///             <i>lpString</i>. If the length of the string, including the null character, exceeds the limit, the string is
///             truncated.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value specifies the number of characters copied to the
///    buffer, not including the terminating null character. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
uint GetDlgItemTextW(HWND hDlg, int nIDDlgItem, PWSTR lpString, int cchMax);

///Sends a message to the specified control in a dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The identifier of the control that receives the message.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message
///    sent.
///    
@DllImport("USER32")
LRESULT SendDlgItemMessageA(HWND hDlg, int nIDDlgItem, uint Msg, WPARAM wParam, LPARAM lParam);

///Sends a message to the specified control in a dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box that contains the control.
///    nIDDlgItem = Type: <b>int</b> The identifier of the control that receives the message.
///    Msg = Type: <b>UINT</b> The message to be sent. For lists of the system-provided messages, see System-Defined Messages.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message
///    sent.
///    
@DllImport("USER32")
LRESULT SendDlgItemMessageW(HWND hDlg, int nIDDlgItem, uint Msg, WPARAM wParam, LPARAM lParam);

///Retrieves a handle to the first control in a group of controls that precedes (or follows) the specified control in a
///dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box to be searched.
///    hCtl = Type: <b>HWND</b> A handle to the control to be used as the starting point for the search. If this parameter is
///           <b>NULL</b>, the function uses the last (or first) control in the dialog box as the starting point for the
///           search.
///    bPrevious = Type: <b>BOOL</b> Indicates how the function is to search the group of controls in the dialog box. If this
///                parameter is <b>TRUE</b>, the function searches for the previous control in the group. If it is <b>FALSE</b>, the
///                function searches for the next control in the group.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the previous (or next) control in the
///    group of controls. If the function fails, the return value is <b>NULL</b>. To get extended error information,
///    call GetLastError.
///    
@DllImport("USER32")
HWND GetNextDlgGroupItem(HWND hDlg, HWND hCtl, BOOL bPrevious);

///Retrieves a handle to the first control that has the WS_TABSTOP style that precedes (or follows) the specified
///control.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box to be searched.
///    hCtl = Type: <b>HWND</b> A handle to the control to be used as the starting point for the search. If this parameter is
///           <b>NULL</b>, the function fails.
///    bPrevious = Type: <b>BOOL</b> Indicates how the function is to search the dialog box. If this parameter is <b>TRUE</b>, the
///                function searches for the previous control in the dialog box. If this parameter is <b>FALSE</b>, the function
///                searches for the next control in the dialog box.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle of the previous (or next)
///    control that has the WS_TABSTOP style set. If the function fails, the return value is <b>NULL</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND GetNextDlgTabItem(HWND hDlg, HWND hCtl, BOOL bPrevious);

///Retrieves the identifier of the specified control.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the control.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the identifier of the control. If the function
///    fails, the return value is zero. An invalid value for the <i>hwndCtl</i> parameter, for example, will cause the
///    function to fail. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetDlgCtrlID(HWND hWnd);

///Retrieves the system's dialog base units, which are the average width and height of characters in the system font.
///For dialog boxes that use the system font, you can use these values to convert between dialog template units, as
///specified in dialog box templates, and pixels. For dialog boxes that do not use the system font, the conversion from
///dialog template units to pixels depends on the font used by the dialog box. For either type of dialog box, it is
///easier to use the MapDialogRect function to perform the conversion. <b>MapDialogRect</b> takes the font into account
///and correctly converts a rectangle from dialog template units into pixels.
///Returns:
///    Type: <b>LONG</b> The function returns the dialog base units. The low-order word of the return value contains the
///    horizontal dialog box base unit, and the high-order word contains the vertical dialog box base unit.
///    
@DllImport("USER32")
int GetDialogBaseUnits();

///Calls the default dialog box window procedure to provide default processing for any window messages that a dialog box
///with a private window class does not process.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box.
///    Msg = Type: <b>UINT</b> The message.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message
///    sent.
///    
@DllImport("USER32")
LRESULT DefDlgProcW(HWND hDlg, uint Msg, WPARAM wParam, LPARAM lParam);

///Passes the specified message and hook code to the hook procedures associated with the WH_SYSMSGFILTER and
///WH_MSGFILTER hooks. A <b>WH_SYSMSGFILTER</b> or <b>WH_MSGFILTER</b> hook procedure is an application-defined callback
///function that examines and, optionally, modifies messages for a dialog box, message box, menu, or scroll bar.
///Params:
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that contains the message to be passed to the hook procedures.
///    nCode = Type: <b>int</b> An application-defined code used by the hook procedure to determine how to process the message.
///            The code must not have the same value as system-defined hook codes (MSGF_ and HC_) associated with the
///            WH_SYSMSGFILTER and <b>WH_MSGFILTER</b> hooks.
///Returns:
///    Type: <b>BOOL</b> If the application should process the message further, the return value is zero. If the
///    application should not process the message further, the return value is nonzero.
///    
@DllImport("USER32")
BOOL CallMsgFilterA(MSG* lpMsg, int nCode);

///Passes the specified message and hook code to the hook procedures associated with the WH_SYSMSGFILTER and
///WH_MSGFILTER hooks. A <b>WH_SYSMSGFILTER</b> or <b>WH_MSGFILTER</b> hook procedure is an application-defined callback
///function that examines and, optionally, modifies messages for a dialog box, message box, menu, or scroll bar.
///Params:
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that contains the message to be passed to the hook procedures.
///    nCode = Type: <b>int</b> An application-defined code used by the hook procedure to determine how to process the message.
///            The code must not have the same value as system-defined hook codes (MSGF_ and HC_) associated with the
///            WH_SYSMSGFILTER and <b>WH_MSGFILTER</b> hooks.
///Returns:
///    Type: <b>BOOL</b> If the application should process the message further, the return value is zero. If the
///    application should not process the message further, the return value is nonzero.
///    
@DllImport("USER32")
BOOL CallMsgFilterW(MSG* lpMsg, int nCode);

///Determines whether there are mouse-button or keyboard messages in the calling thread's message queue.
///Returns:
///    Type: <b>BOOL</b> If the queue contains one or more new mouse-button or keyboard messages, the return value is
///    nonzero. If there are no new mouse-button or keyboard messages in the queue, the return value is zero.
///    
@DllImport("USER32")
BOOL GetInputState();

///Retrieves the type of messages found in the calling thread's message queue.
///Params:
///    flags = Type: <b>UINT</b> The types of messages for which to check. This parameter can be one or more of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="QS_ALLEVENTS"></a><a
///            id="qs_allevents"></a><dl> <dt><b>QS_ALLEVENTS</b></dt> <dt>(QS_INPUT | QS_POSTMESSAGE | QS_TIMER | QS_PAINT |
///            QS_HOTKEY)</dt> </dl> </td> <td width="60%"> An input, WM_TIMER, WM_PAINT, WM_HOTKEY, or posted message is in the
///            queue. </td> </tr> <tr> <td width="40%"><a id="QS_ALLINPUT"></a><a id="qs_allinput"></a><dl>
///            <dt><b>QS_ALLINPUT</b></dt> <dt>(QS_INPUT | QS_POSTMESSAGE | QS_TIMER | QS_PAINT | QS_HOTKEY |
///            QS_SENDMESSAGE)</dt> </dl> </td> <td width="60%"> Any message is in the queue. </td> </tr> <tr> <td
///            width="40%"><a id="QS_ALLPOSTMESSAGE"></a><a id="qs_allpostmessage"></a><dl> <dt><b>QS_ALLPOSTMESSAGE</b></dt>
///            <dt>0x0100</dt> </dl> </td> <td width="60%"> A posted message (other than those listed here) is in the queue.
///            </td> </tr> <tr> <td width="40%"><a id="QS_HOTKEY"></a><a id="qs_hotkey"></a><dl> <dt><b>QS_HOTKEY</b></dt>
///            <dt>0x0080</dt> </dl> </td> <td width="60%"> A WM_HOTKEY message is in the queue. </td> </tr> <tr> <td
///            width="40%"><a id="QS_INPUT"></a><a id="qs_input"></a><dl> <dt><b>QS_INPUT</b></dt> <dt>(QS_MOUSE | QS_KEY |
///            QS_RAWINPUT)</dt> </dl> </td> <td width="60%"> An input message is in the queue. </td> </tr> <tr> <td
///            width="40%"><a id="QS_KEY"></a><a id="qs_key"></a><dl> <dt><b>QS_KEY</b></dt> <dt>0x0001</dt> </dl> </td> <td
///            width="60%"> A WM_KEYUP, WM_KEYDOWN, WM_SYSKEYUP, or WM_SYSKEYDOWN message is in the queue. </td> </tr> <tr> <td
///            width="40%"><a id="QS_MOUSE"></a><a id="qs_mouse"></a><dl> <dt><b>QS_MOUSE</b></dt> <dt>(QS_MOUSEMOVE |
///            QS_MOUSEBUTTON)</dt> </dl> </td> <td width="60%"> A WM_MOUSEMOVE message or mouse-button message (WM_LBUTTONUP,
///            WM_RBUTTONDOWN, and so on). </td> </tr> <tr> <td width="40%"><a id="QS_MOUSEBUTTON"></a><a
///            id="qs_mousebutton"></a><dl> <dt><b>QS_MOUSEBUTTON</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> A
///            mouse-button message (WM_LBUTTONUP, WM_RBUTTONDOWN, and so on). </td> </tr> <tr> <td width="40%"><a
///            id="QS_MOUSEMOVE"></a><a id="qs_mousemove"></a><dl> <dt><b>QS_MOUSEMOVE</b></dt> <dt>0x0002</dt> </dl> </td> <td
///            width="60%"> A WM_MOUSEMOVE message is in the queue. </td> </tr> <tr> <td width="40%"><a id="QS_PAINT"></a><a
///            id="qs_paint"></a><dl> <dt><b>QS_PAINT</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> A WM_PAINT message
///            is in the queue. </td> </tr> <tr> <td width="40%"><a id="QS_POSTMESSAGE"></a><a id="qs_postmessage"></a><dl>
///            <dt><b>QS_POSTMESSAGE</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> A posted message (other than those
///            listed here) is in the queue. </td> </tr> <tr> <td width="40%"><a id="QS_RAWINPUT"></a><a
///            id="qs_rawinput"></a><dl> <dt><b>QS_RAWINPUT</b></dt> <dt>0x0400</dt> </dl> </td> <td width="60%"> A raw input
///            message is in the queue. For more information, see Raw Input. <b>Windows 2000: </b>This flag is not supported.
///            </td> </tr> <tr> <td width="40%"><a id="QS_SENDMESSAGE"></a><a id="qs_sendmessage"></a><dl>
///            <dt><b>QS_SENDMESSAGE</b></dt> <dt>0x0040</dt> </dl> </td> <td width="60%"> A message sent by another thread or
///            application is in the queue. </td> </tr> <tr> <td width="40%"><a id="QS_TIMER"></a><a id="qs_timer"></a><dl>
///            <dt><b>QS_TIMER</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> A WM_TIMER message is in the queue. </td>
///            </tr> </table>
///Returns:
///    Type: <b>DWORD</b> The high-order word of the return value indicates the types of messages currently in the
///    queue. The low-order word indicates the types of messages that have been added to the queue and that are still in
///    the queue since the last call to the <b>GetQueueStatus</b>, GetMessage, or PeekMessage function.
///    
@DllImport("USER32")
uint GetQueueStatus(uint flags);

///Creates a timer with the specified time-out value.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be associated with the timer. This window must be owned by the
///           calling thread. If a <b>NULL</b> value for <i>hWnd</i> is passed in along with an <i>nIDEvent</i> of an existing
///           timer, that timer will be replaced in the same way that an existing non-NULL <i>hWnd</i> timer will be.
///    nIDEvent = Type: <b>UINT_PTR</b> A nonzero timer identifier. If the <i>hWnd</i> parameter is <b>NULL</b>, and the
///               <i>nIDEvent</i> does not match an existing timer then it is ignored and a new timer ID is generated. If the
///               <i>hWnd</i> parameter is not <b>NULL</b> and the window specified by <i>hWnd</i> already has a timer with the
///               value <i>nIDEvent</i>, then the existing timer is replaced by the new timer. When <b>SetTimer</b> replaces a
///               timer, the timer is reset. Therefore, a message will be sent after the current time-out value elapses, but the
///               previously set time-out value is ignored. If the call is not intended to replace an existing timer,
///               <i>nIDEvent</i> should be 0 if the <i>hWnd</i> is <b>NULL</b>.
///    uElapse = Type: <b>UINT</b> The time-out value, in milliseconds. If <i>uElapse</i> is less than <b>USER_TIMER_MINIMUM</b>
///              (0x0000000A), the timeout is set to <b>USER_TIMER_MINIMUM</b>. If <i>uElapse</i> is greater than
///              <b>USER_TIMER_MAXIMUM</b> (0x7FFFFFFF), the timeout is set to <b>USER_TIMER_MAXIMUM</b>.
///    lpTimerFunc = Type: <b>TIMERPROC</b> A pointer to the function to be notified when the time-out value elapses. For more
///                  information about the function, see TimerProc. If <i>lpTimerFunc</i> is <b>NULL</b>, the system posts a WM_TIMER
///                  message to the application queue. The <b>hwnd</b> member of the message's MSG structure contains the value of the
///                  <i>hWnd</i> parameter.
///Returns:
///    Type: <b>UINT_PTR</b> If the function succeeds and the <i>hWnd</i> parameter is <b>NULL</b>, the return value is
///    an integer identifying the new timer. An application can pass this value to the KillTimer function to destroy the
///    timer. If the function succeeds and the <i>hWnd</i> parameter is not <b>NULL</b>, then the return value is a
///    nonzero integer. An application can pass the value of the <i>nIDEvent</i> parameter to the KillTimer function to
///    destroy the timer. If the function fails to create a timer, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
size_t SetTimer(HWND hWnd, size_t nIDEvent, uint uElapse, TIMERPROC lpTimerFunc);

///Creates a timer with the specified time-out value and coalescing tolerance delay.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be associated with the timer. This window must be owned by the
///           calling thread. If a <b>NULL</b> value for <i>hWnd</i> is passed in along with an <i>nIDEvent</i> of an existing
///           timer, that timer will be replaced in the same way that an existing non-NULL <i>hWnd</i> timer will be.
///    nIDEvent = Type: <b>UINT_PTR</b> A timer identifier. If the <i>hWnd</i> parameter is <b>NULL</b>, and the <i>nIDEvent</i>
///               does not match an existing timer, then the <i>nIDEvent</i> is ignored and a new timer ID is generated. If the
///               <i>hWnd</i> parameter is not <b>NULL</b> and the window specified by <i>hWnd</i> already has a timer with the
///               value <i>nIDEvent</i>, then the existing timer is replaced by the new timer. When <b>SetCoalescableTimer</b>
///               replaces a timer, the timer is reset. Therefore, a message will be sent after the current time-out value elapses,
///               but the previously set time-out value is ignored. If the call is not intended to replace an existing timer,
///               <i>nIDEvent</i> should be 0 if the <i>hWnd</i> is <b>NULL</b>.
///    uElapse = Type: <b>UINT</b> The time-out value, in milliseconds. If <i>uElapse</i> is less than <b>USER_TIMER_MINIMUM</b>
///              (0x0000000A), the timeout is set to <b>USER_TIMER_MINIMUM</b>. If <i>uElapse</i> is greater than
///              <b>USER_TIMER_MAXIMUM</b> (0x7FFFFFFF), the timeout is set to <b>USER_TIMER_MAXIMUM</b>. If the sum of
///              <i>uElapse</i> and <i>uToleranceDelay</i> exceeds <b>USER_TIMER_MAXIMUM</b>, an ERROR_INVALID_PARAMETER exception
///              occurs.
///    lpTimerFunc = Type: <b>TIMERPROC</b> A pointer to the function to be notified when the time-out value elapses. For more
///                  information about the function, see TimerProc. If <i>lpTimerFunc</i> is <b>NULL</b>, the system posts a WM_TIMER
///                  message to the application queue. The <b>hwnd</b> member of the message's MSG structure contains the value of the
///                  <i>hWnd</i> parameter.
///    uToleranceDelay = Type: <b>ULONG</b> It can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                      <td width="40%"><a id="TIMERV_DEFAULT_COALESCING"></a><a id="timerv_default_coalescing"></a><dl>
///                      <dt><b>TIMERV_DEFAULT_COALESCING</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> Uses the system
///                      default timer coalescing. </td> </tr> <tr> <td width="40%"><a id="TIMERV_NO_COALESCING"></a><a
///                      id="timerv_no_coalescing"></a><dl> <dt><b>TIMERV_NO_COALESCING</b></dt> <dt>0xFFFFFFFF</dt> </dl> </td> <td
///                      width="60%"> Uses no timer coalescing. When this value is used, the created timer is not coalesced, no matter
///                      what the system default timer coalescing is or the application compatiblity flags are. <div
///                      class="alert"><b>Note</b> Do not use this value unless you are certain that the timer requires no coalescing.
///                      </div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl> <dt>0x1 - 0x7FFFFFF5</dt> </dl> </td> <td width="60%">
///                      Specifies the coalescing tolerance delay, in milliseconds. Applications should set this value to the system
///                      default (<b>TIMERV_DEFAULT_COALESCING</b>) or the largest value possible. If the sum of <i>uElapse</i> and
///                      <i>uToleranceDelay</i> exceeds <b>USER_TIMER_MAXIMUM</b> (0x7FFFFFFF), an ERROR_INVALID_PARAMETER exception
///                      occurs. See Windows Timer Coalescing for more details and best practices. </td> </tr> <tr> <td width="40%"><a
///                      id="Any_other_value"></a><a id="any_other_value"></a><a id="ANY_OTHER_VALUE"></a><dl> <dt><b>Any other
///                      value</b></dt> </dl> </td> <td width="60%"> An invalid value. If <i>uToleranceDelay</i> is set to an invalid
///                      value, the function fails and returns zero. </td> </tr> </table>
///Returns:
///    Type: <b>UINT_PTR</b> If the function succeeds and the <i>hWnd</i> parameter is <b>NULL</b>, the return value is
///    an integer identifying the new timer. An application can pass this value to the KillTimer function to destroy the
///    timer. If the function succeeds and the <i>hWnd</i> parameter is not <b>NULL</b>, then the return value is a
///    nonzero integer. An application can pass the value of the <i>nIDEvent</i> parameter to the KillTimer function to
///    destroy the timer. If the function fails to create a timer, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
size_t SetCoalescableTimer(HWND hWnd, size_t nIDEvent, uint uElapse, TIMERPROC lpTimerFunc, uint uToleranceDelay);

///Destroys the specified timer.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window associated with the specified timer. This value must be the same as the
///           <i>hWnd</i> value passed to the SetTimer function that created the timer.
///    uIDEvent = Type: <b>UINT_PTR</b> The timer to be destroyed. If the window handle passed to SetTimer is valid, this parameter
///               must be the same as the <i>nIDEvent</i> value passed to <b>SetTimer</b>. If the application calls <b>SetTimer</b>
///               with <i>hWnd</i> set to <b>NULL</b>, this parameter must be the timer identifier returned by <b>SetTimer</b>.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL KillTimer(HWND hWnd, size_t uIDEvent);

///Determines whether the specified window is a native Unicode window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> If the window is a native Unicode window, the return value is nonzero. If the window is not a
///    native Unicode window, the return value is zero. The window is a native ANSI window.
///    
@DllImport("USER32")
BOOL IsWindowUnicode(HWND hWnd);

///Retrieves the specified system metric or system configuration setting. Note that all dimensions retrieved by
///<b>GetSystemMetrics</b> are in pixels.
///Params:
///    nIndex = Type: <b>int</b> The system metric or configuration setting to be retrieved. This parameter can be one of the
///             following values. Note that all SM_CX* values are widths and all SM_CY* values are heights. Also note that all
///             settings designed to return Boolean data represent <b>TRUE</b> as any nonzero value, and <b>FALSE</b> as a zero
///             value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SM_ARRANGE"></a><a
///             id="sm_arrange"></a><dl> <dt><b>SM_ARRANGE</b></dt> <dt>56</dt> </dl> </td> <td width="60%"> The flags that
///             specify how the system arranged minimized windows. For more information, see the Remarks section in this topic.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CLEANBOOT"></a><a id="sm_cleanboot"></a><dl>
///             <dt><b>SM_CLEANBOOT</b></dt> <dt>67</dt> </dl> </td> <td width="60%"> The value that specifies how the system is
///             started: <ul> <li>0 Normal boot</li> <li>1 Fail-safe boot</li> <li>2 Fail-safe with network boot</li> </ul> A
///             fail-safe boot (also called SafeBoot, Safe Mode, or Clean Boot) bypasses the user startup files. </td> </tr> <tr>
///             <td width="40%"><a id="SM_CMONITORS"></a><a id="sm_cmonitors"></a><dl> <dt><b>SM_CMONITORS</b></dt> <dt>80</dt>
///             </dl> </td> <td width="60%"> The number of display monitors on a desktop. For more information, see the Remarks
///             section in this topic. </td> </tr> <tr> <td width="40%"><a id="SM_CMOUSEBUTTONS"></a><a
///             id="sm_cmousebuttons"></a><dl> <dt><b>SM_CMOUSEBUTTONS</b></dt> <dt>43</dt> </dl> </td> <td width="60%"> The
///             number of buttons on a mouse, or zero if no mouse is installed. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CONVERTIBLESLATEMODE"></a><a id="sm_convertibleslatemode"></a><dl> <dt><b>SM_CONVERTIBLESLATEMODE</b></dt>
///             <dt>0x2003</dt> </dl> </td> <td width="60%"> Reflects the state of the laptop or slate mode, 0 for Slate Mode and
///             non-zero otherwise. When this system metric changes, the system sends a broadcast message via WM_SETTINGCHANGE
///             with "ConvertibleSlateMode" in the LPARAM. Note that this system metric doesn't apply to desktop PCs. In that
///             case, use GetAutoRotationState. </td> </tr> <tr> <td width="40%"><a id="SM_CXBORDER"></a><a
///             id="sm_cxborder"></a><dl> <dt><b>SM_CXBORDER</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The width of a
///             window border, in pixels. This is equivalent to the SM_CXEDGE value for windows with the 3-D look. </td> </tr>
///             <tr> <td width="40%"><a id="SM_CXCURSOR"></a><a id="sm_cxcursor"></a><dl> <dt><b>SM_CXCURSOR</b></dt> <dt>13</dt>
///             </dl> </td> <td width="60%"> The width of a cursor, in pixels. The system cannot create cursors of other sizes.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CXDLGFRAME"></a><a id="sm_cxdlgframe"></a><dl>
///             <dt><b>SM_CXDLGFRAME</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> This value is the same as SM_CXFIXEDFRAME.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CXDOUBLECLK"></a><a id="sm_cxdoubleclk"></a><dl>
///             <dt><b>SM_CXDOUBLECLK</b></dt> <dt>36</dt> </dl> </td> <td width="60%"> The width of the rectangle around the
///             location of a first click in a double-click sequence, in pixels. The second click must occur within the rectangle
///             that is defined by SM_CXDOUBLECLK and SM_CYDOUBLECLK for the system to consider the two clicks a double-click.
///             The two clicks must also occur within a specified time. To set the width of the double-click rectangle, call
///             SystemParametersInfo with SPI_SETDOUBLECLKWIDTH. </td> </tr> <tr> <td width="40%"><a id="SM_CXDRAG"></a><a
///             id="sm_cxdrag"></a><dl> <dt><b>SM_CXDRAG</b></dt> <dt>68</dt> </dl> </td> <td width="60%"> The number of pixels
///             on either side of a mouse-down point that the mouse pointer can move before a drag operation begins. This allows
///             the user to click and release the mouse button easily without unintentionally starting a drag operation. If this
///             value is negative, it is subtracted from the left of the mouse-down point and added to the right of it. </td>
///             </tr> <tr> <td width="40%"><a id="SM_CXEDGE"></a><a id="sm_cxedge"></a><dl> <dt><b>SM_CXEDGE</b></dt> <dt>45</dt>
///             </dl> </td> <td width="60%"> The width of a 3-D border, in pixels. This metric is the 3-D counterpart of
///             SM_CXBORDER. </td> </tr> <tr> <td width="40%"><a id="SM_CXFIXEDFRAME"></a><a id="sm_cxfixedframe"></a><dl>
///             <dt><b>SM_CXFIXEDFRAME</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The thickness of the frame around the
///             perimeter of a window that has a caption but is not sizable, in pixels. SM_CXFIXEDFRAME is the height of the
///             horizontal border, and SM_CYFIXEDFRAME is the width of the vertical border. This value is the same as
///             SM_CXDLGFRAME. </td> </tr> <tr> <td width="40%"><a id="SM_CXFOCUSBORDER"></a><a id="sm_cxfocusborder"></a><dl>
///             <dt><b>SM_CXFOCUSBORDER</b></dt> <dt>83</dt> </dl> </td> <td width="60%"> The width of the left and right edges
///             of the focus rectangle that the DrawFocusRect draws. This value is in pixels. <b>Windows 2000: </b>This value is
///             not supported. </td> </tr> <tr> <td width="40%"><a id="SM_CXFRAME"></a><a id="sm_cxframe"></a><dl>
///             <dt><b>SM_CXFRAME</b></dt> <dt>32</dt> </dl> </td> <td width="60%"> This value is the same as SM_CXSIZEFRAME.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CXFULLSCREEN"></a><a id="sm_cxfullscreen"></a><dl>
///             <dt><b>SM_CXFULLSCREEN</b></dt> <dt>16</dt> </dl> </td> <td width="60%"> The width of the client area for a
///             full-screen window on the primary display monitor, in pixels. To get the coordinates of the portion of the screen
///             that is not obscured by the system taskbar or by application desktop toolbars, call the SystemParametersInfo
///             function with the SPI_GETWORKAREA value. </td> </tr> <tr> <td width="40%"><a id="SM_CXHSCROLL"></a><a
///             id="sm_cxhscroll"></a><dl> <dt><b>SM_CXHSCROLL</b></dt> <dt>21</dt> </dl> </td> <td width="60%"> The width of the
///             arrow bitmap on a horizontal scroll bar, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CXHTHUMB"></a><a
///             id="sm_cxhthumb"></a><dl> <dt><b>SM_CXHTHUMB</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> The width of the
///             thumb box in a horizontal scroll bar, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CXICON"></a><a
///             id="sm_cxicon"></a><dl> <dt><b>SM_CXICON</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> The default width of
///             an icon, in pixels. The LoadIcon function can load only icons with the dimensions that SM_CXICON and SM_CYICON
///             specifies. </td> </tr> <tr> <td width="40%"><a id="SM_CXICONSPACING"></a><a id="sm_cxiconspacing"></a><dl>
///             <dt><b>SM_CXICONSPACING</b></dt> <dt>38</dt> </dl> </td> <td width="60%"> The width of a grid cell for items in
///             large icon view, in pixels. Each item fits into a rectangle of size SM_CXICONSPACING by SM_CYICONSPACING when
///             arranged. This value is always greater than or equal to SM_CXICON. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CXMAXIMIZED"></a><a id="sm_cxmaximized"></a><dl> <dt><b>SM_CXMAXIMIZED</b></dt> <dt>61</dt> </dl> </td>
///             <td width="60%"> The default width, in pixels, of a maximized top-level window on the primary display monitor.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CXMAXTRACK"></a><a id="sm_cxmaxtrack"></a><dl>
///             <dt><b>SM_CXMAXTRACK</b></dt> <dt>59</dt> </dl> </td> <td width="60%"> The default maximum width of a window that
///             has a caption and sizing borders, in pixels. This metric refers to the entire desktop. The user cannot drag the
///             window frame to a size larger than these dimensions. A window can override this value by processing the
///             WM_GETMINMAXINFO message. </td> </tr> <tr> <td width="40%"><a id="SM_CXMENUCHECK"></a><a
///             id="sm_cxmenucheck"></a><dl> <dt><b>SM_CXMENUCHECK</b></dt> <dt>71</dt> </dl> </td> <td width="60%"> The width of
///             the default menu check-mark bitmap, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CXMENUSIZE"></a><a
///             id="sm_cxmenusize"></a><dl> <dt><b>SM_CXMENUSIZE</b></dt> <dt>54</dt> </dl> </td> <td width="60%"> The width of
///             menu bar buttons, such as the child window close button that is used in the multiple document interface, in
///             pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CXMIN"></a><a id="sm_cxmin"></a><dl> <dt><b>SM_CXMIN</b></dt>
///             <dt>28</dt> </dl> </td> <td width="60%"> The minimum width of a window, in pixels. </td> </tr> <tr> <td
///             width="40%"><a id="SM_CXMINIMIZED"></a><a id="sm_cxminimized"></a><dl> <dt><b>SM_CXMINIMIZED</b></dt> <dt>57</dt>
///             </dl> </td> <td width="60%"> The width of a minimized window, in pixels. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CXMINSPACING"></a><a id="sm_cxminspacing"></a><dl> <dt><b>SM_CXMINSPACING</b></dt> <dt>47</dt> </dl> </td>
///             <td width="60%"> The width of a grid cell for a minimized window, in pixels. Each minimized window fits into a
///             rectangle this size when arranged. This value is always greater than or equal to SM_CXMINIMIZED. </td> </tr> <tr>
///             <td width="40%"><a id="SM_CXMINTRACK"></a><a id="sm_cxmintrack"></a><dl> <dt><b>SM_CXMINTRACK</b></dt>
///             <dt>34</dt> </dl> </td> <td width="60%"> The minimum tracking width of a window, in pixels. The user cannot drag
///             the window frame to a size smaller than these dimensions. A window can override this value by processing the
///             WM_GETMINMAXINFO message. </td> </tr> <tr> <td width="40%"><a id="SM_CXPADDEDBORDER"></a><a
///             id="sm_cxpaddedborder"></a><dl> <dt><b>SM_CXPADDEDBORDER</b></dt> <dt>92</dt> </dl> </td> <td width="60%"> The
///             amount of border padding for captioned windows, in pixels. <b>Windows XP/2000: </b>This value is not supported.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CXSCREEN"></a><a id="sm_cxscreen"></a><dl> <dt><b>SM_CXSCREEN</b></dt>
///             <dt>0</dt> </dl> </td> <td width="60%"> The width of the screen of the primary display monitor, in pixels. This
///             is the same value obtained by calling GetDeviceCaps as follows: <code>GetDeviceCaps( hdcPrimaryMonitor,
///             HORZRES)</code>. </td> </tr> <tr> <td width="40%"><a id="SM_CXSIZE"></a><a id="sm_cxsize"></a><dl>
///             <dt><b>SM_CXSIZE</b></dt> <dt>30</dt> </dl> </td> <td width="60%"> The width of a button in a window caption or
///             title bar, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CXSIZEFRAME"></a><a id="sm_cxsizeframe"></a><dl>
///             <dt><b>SM_CXSIZEFRAME</b></dt> <dt>32</dt> </dl> </td> <td width="60%"> The thickness of the sizing border around
///             the perimeter of a window that can be resized, in pixels. SM_CXSIZEFRAME is the width of the horizontal border,
///             and SM_CYSIZEFRAME is the height of the vertical border. This value is the same as SM_CXFRAME. </td> </tr> <tr>
///             <td width="40%"><a id="SM_CXSMICON"></a><a id="sm_cxsmicon"></a><dl> <dt><b>SM_CXSMICON</b></dt> <dt>49</dt>
///             </dl> </td> <td width="60%"> The recommended width of a small icon, in pixels. Small icons typically appear in
///             window captions and in small icon view. </td> </tr> <tr> <td width="40%"><a id="SM_CXSMSIZE"></a><a
///             id="sm_cxsmsize"></a><dl> <dt><b>SM_CXSMSIZE</b></dt> <dt>52</dt> </dl> </td> <td width="60%"> The width of small
///             caption buttons, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CXVIRTUALSCREEN"></a><a
///             id="sm_cxvirtualscreen"></a><dl> <dt><b>SM_CXVIRTUALSCREEN</b></dt> <dt>78</dt> </dl> </td> <td width="60%"> The
///             width of the virtual screen, in pixels. The virtual screen is the bounding rectangle of all display monitors. The
///             SM_XVIRTUALSCREEN metric is the coordinates for the left side of the virtual screen. </td> </tr> <tr> <td
///             width="40%"><a id="SM_CXVSCROLL"></a><a id="sm_cxvscroll"></a><dl> <dt><b>SM_CXVSCROLL</b></dt> <dt>2</dt> </dl>
///             </td> <td width="60%"> The width of a vertical scroll bar, in pixels. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYBORDER"></a><a id="sm_cyborder"></a><dl> <dt><b>SM_CYBORDER</b></dt> <dt>6</dt> </dl> </td> <td
///             width="60%"> The height of a window border, in pixels. This is equivalent to the SM_CYEDGE value for windows with
///             the 3-D look. </td> </tr> <tr> <td width="40%"><a id="SM_CYCAPTION"></a><a id="sm_cycaption"></a><dl>
///             <dt><b>SM_CYCAPTION</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The height of a caption area, in pixels.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CYCURSOR"></a><a id="sm_cycursor"></a><dl> <dt><b>SM_CYCURSOR</b></dt>
///             <dt>14</dt> </dl> </td> <td width="60%"> The height of a cursor, in pixels. The system cannot create cursors of
///             other sizes. </td> </tr> <tr> <td width="40%"><a id="SM_CYDLGFRAME"></a><a id="sm_cydlgframe"></a><dl>
///             <dt><b>SM_CYDLGFRAME</b></dt> <dt>8</dt> </dl> </td> <td width="60%"> This value is the same as SM_CYFIXEDFRAME.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CYDOUBLECLK"></a><a id="sm_cydoubleclk"></a><dl>
///             <dt><b>SM_CYDOUBLECLK</b></dt> <dt>37</dt> </dl> </td> <td width="60%"> The height of the rectangle around the
///             location of a first click in a double-click sequence, in pixels. The second click must occur within the rectangle
///             defined by SM_CXDOUBLECLK and SM_CYDOUBLECLK for the system to consider the two clicks a double-click. The two
///             clicks must also occur within a specified time. To set the height of the double-click rectangle, call
///             SystemParametersInfo with SPI_SETDOUBLECLKHEIGHT. </td> </tr> <tr> <td width="40%"><a id="SM_CYDRAG"></a><a
///             id="sm_cydrag"></a><dl> <dt><b>SM_CYDRAG</b></dt> <dt>69</dt> </dl> </td> <td width="60%"> The number of pixels
///             above and below a mouse-down point that the mouse pointer can move before a drag operation begins. This allows
///             the user to click and release the mouse button easily without unintentionally starting a drag operation. If this
///             value is negative, it is subtracted from above the mouse-down point and added below it. </td> </tr> <tr> <td
///             width="40%"><a id="SM_CYEDGE"></a><a id="sm_cyedge"></a><dl> <dt><b>SM_CYEDGE</b></dt> <dt>46</dt> </dl> </td>
///             <td width="60%"> The height of a 3-D border, in pixels. This is the 3-D counterpart of SM_CYBORDER. </td> </tr>
///             <tr> <td width="40%"><a id="SM_CYFIXEDFRAME"></a><a id="sm_cyfixedframe"></a><dl> <dt><b>SM_CYFIXEDFRAME</b></dt>
///             <dt>8</dt> </dl> </td> <td width="60%"> The thickness of the frame around the perimeter of a window that has a
///             caption but is not sizable, in pixels. SM_CXFIXEDFRAME is the height of the horizontal border, and
///             SM_CYFIXEDFRAME is the width of the vertical border. This value is the same as SM_CYDLGFRAME. </td> </tr> <tr>
///             <td width="40%"><a id="SM_CYFOCUSBORDER"></a><a id="sm_cyfocusborder"></a><dl> <dt><b>SM_CYFOCUSBORDER</b></dt>
///             <dt>84</dt> </dl> </td> <td width="60%"> The height of the top and bottom edges of the focus rectangle drawn by
///             DrawFocusRect. This value is in pixels. <b>Windows 2000: </b>This value is not supported. </td> </tr> <tr> <td
///             width="40%"><a id="SM_CYFRAME"></a><a id="sm_cyframe"></a><dl> <dt><b>SM_CYFRAME</b></dt> <dt>33</dt> </dl> </td>
///             <td width="60%"> This value is the same as SM_CYSIZEFRAME. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYFULLSCREEN"></a><a id="sm_cyfullscreen"></a><dl> <dt><b>SM_CYFULLSCREEN</b></dt> <dt>17</dt> </dl> </td>
///             <td width="60%"> The height of the client area for a full-screen window on the primary display monitor, in
///             pixels. To get the coordinates of the portion of the screen not obscured by the system taskbar or by application
///             desktop toolbars, call the SystemParametersInfo function with the SPI_GETWORKAREA value. </td> </tr> <tr> <td
///             width="40%"><a id="SM_CYHSCROLL"></a><a id="sm_cyhscroll"></a><dl> <dt><b>SM_CYHSCROLL</b></dt> <dt>3</dt> </dl>
///             </td> <td width="60%"> The height of a horizontal scroll bar, in pixels. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYICON"></a><a id="sm_cyicon"></a><dl> <dt><b>SM_CYICON</b></dt> <dt>12</dt> </dl> </td> <td width="60%">
///             The default height of an icon, in pixels. The LoadIcon function can load only icons with the dimensions SM_CXICON
///             and SM_CYICON. </td> </tr> <tr> <td width="40%"><a id="SM_CYICONSPACING"></a><a id="sm_cyiconspacing"></a><dl>
///             <dt><b>SM_CYICONSPACING</b></dt> <dt>39</dt> </dl> </td> <td width="60%"> The height of a grid cell for items in
///             large icon view, in pixels. Each item fits into a rectangle of size SM_CXICONSPACING by SM_CYICONSPACING when
///             arranged. This value is always greater than or equal to SM_CYICON. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYKANJIWINDOW"></a><a id="sm_cykanjiwindow"></a><dl> <dt><b>SM_CYKANJIWINDOW</b></dt> <dt>18</dt> </dl>
///             </td> <td width="60%"> For double byte character set versions of the system, this is the height of the Kanji
///             window at the bottom of the screen, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CYMAXIMIZED"></a><a
///             id="sm_cymaximized"></a><dl> <dt><b>SM_CYMAXIMIZED</b></dt> <dt>62</dt> </dl> </td> <td width="60%"> The default
///             height, in pixels, of a maximized top-level window on the primary display monitor. </td> </tr> <tr> <td
///             width="40%"><a id="SM_CYMAXTRACK"></a><a id="sm_cymaxtrack"></a><dl> <dt><b>SM_CYMAXTRACK</b></dt> <dt>60</dt>
///             </dl> </td> <td width="60%"> The default maximum height of a window that has a caption and sizing borders, in
///             pixels. This metric refers to the entire desktop. The user cannot drag the window frame to a size larger than
///             these dimensions. A window can override this value by processing the WM_GETMINMAXINFO message. </td> </tr> <tr>
///             <td width="40%"><a id="SM_CYMENU"></a><a id="sm_cymenu"></a><dl> <dt><b>SM_CYMENU</b></dt> <dt>15</dt> </dl>
///             </td> <td width="60%"> The height of a single-line menu bar, in pixels. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYMENUCHECK"></a><a id="sm_cymenucheck"></a><dl> <dt><b>SM_CYMENUCHECK</b></dt> <dt>72</dt> </dl> </td>
///             <td width="60%"> The height of the default menu check-mark bitmap, in pixels. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYMENUSIZE"></a><a id="sm_cymenusize"></a><dl> <dt><b>SM_CYMENUSIZE</b></dt> <dt>55</dt> </dl> </td> <td
///             width="60%"> The height of menu bar buttons, such as the child window close button that is used in the multiple
///             document interface, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CYMIN"></a><a id="sm_cymin"></a><dl>
///             <dt><b>SM_CYMIN</b></dt> <dt>29</dt> </dl> </td> <td width="60%"> The minimum height of a window, in pixels.
///             </td> </tr> <tr> <td width="40%"><a id="SM_CYMINIMIZED"></a><a id="sm_cyminimized"></a><dl>
///             <dt><b>SM_CYMINIMIZED</b></dt> <dt>58</dt> </dl> </td> <td width="60%"> The height of a minimized window, in
///             pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CYMINSPACING"></a><a id="sm_cyminspacing"></a><dl>
///             <dt><b>SM_CYMINSPACING</b></dt> <dt>48</dt> </dl> </td> <td width="60%"> The height of a grid cell for a
///             minimized window, in pixels. Each minimized window fits into a rectangle this size when arranged. This value is
///             always greater than or equal to SM_CYMINIMIZED. </td> </tr> <tr> <td width="40%"><a id="SM_CYMINTRACK"></a><a
///             id="sm_cymintrack"></a><dl> <dt><b>SM_CYMINTRACK</b></dt> <dt>35</dt> </dl> </td> <td width="60%"> The minimum
///             tracking height of a window, in pixels. The user cannot drag the window frame to a size smaller than these
///             dimensions. A window can override this value by processing the WM_GETMINMAXINFO message. </td> </tr> <tr> <td
///             width="40%"><a id="SM_CYSCREEN"></a><a id="sm_cyscreen"></a><dl> <dt><b>SM_CYSCREEN</b></dt> <dt>1</dt> </dl>
///             </td> <td width="60%"> The height of the screen of the primary display monitor, in pixels. This is the same value
///             obtained by calling GetDeviceCaps as follows: <code>GetDeviceCaps( hdcPrimaryMonitor, VERTRES)</code>. </td>
///             </tr> <tr> <td width="40%"><a id="SM_CYSIZE"></a><a id="sm_cysize"></a><dl> <dt><b>SM_CYSIZE</b></dt> <dt>31</dt>
///             </dl> </td> <td width="60%"> The height of a button in a window caption or title bar, in pixels. </td> </tr> <tr>
///             <td width="40%"><a id="SM_CYSIZEFRAME"></a><a id="sm_cysizeframe"></a><dl> <dt><b>SM_CYSIZEFRAME</b></dt>
///             <dt>33</dt> </dl> </td> <td width="60%"> The thickness of the sizing border around the perimeter of a window that
///             can be resized, in pixels. SM_CXSIZEFRAME is the width of the horizontal border, and SM_CYSIZEFRAME is the height
///             of the vertical border. This value is the same as SM_CYFRAME. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYSMCAPTION"></a><a id="sm_cysmcaption"></a><dl> <dt><b>SM_CYSMCAPTION</b></dt> <dt>51</dt> </dl> </td>
///             <td width="60%"> The height of a small caption, in pixels. </td> </tr> <tr> <td width="40%"><a
///             id="SM_CYSMICON"></a><a id="sm_cysmicon"></a><dl> <dt><b>SM_CYSMICON</b></dt> <dt>50</dt> </dl> </td> <td
///             width="60%"> The recommended height of a small icon, in pixels. Small icons typically appear in window captions
///             and in small icon view. </td> </tr> <tr> <td width="40%"><a id="SM_CYSMSIZE"></a><a id="sm_cysmsize"></a><dl>
///             <dt><b>SM_CYSMSIZE</b></dt> <dt>53</dt> </dl> </td> <td width="60%"> The height of small caption buttons, in
///             pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CYVIRTUALSCREEN"></a><a id="sm_cyvirtualscreen"></a><dl>
///             <dt><b>SM_CYVIRTUALSCREEN</b></dt> <dt>79</dt> </dl> </td> <td width="60%"> The height of the virtual screen, in
///             pixels. The virtual screen is the bounding rectangle of all display monitors. The SM_YVIRTUALSCREEN metric is the
///             coordinates for the top of the virtual screen. </td> </tr> <tr> <td width="40%"><a id="SM_CYVSCROLL"></a><a
///             id="sm_cyvscroll"></a><dl> <dt><b>SM_CYVSCROLL</b></dt> <dt>20</dt> </dl> </td> <td width="60%"> The height of
///             the arrow bitmap on a vertical scroll bar, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_CYVTHUMB"></a><a
///             id="sm_cyvthumb"></a><dl> <dt><b>SM_CYVTHUMB</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> The height of the
///             thumb box in a vertical scroll bar, in pixels. </td> </tr> <tr> <td width="40%"><a id="SM_DBCSENABLED"></a><a
///             id="sm_dbcsenabled"></a><dl> <dt><b>SM_DBCSENABLED</b></dt> <dt>42</dt> </dl> </td> <td width="60%"> Nonzero if
///             User32.dll supports DBCS; otherwise, 0. </td> </tr> <tr> <td width="40%"><a id="SM_DEBUG"></a><a
///             id="sm_debug"></a><dl> <dt><b>SM_DEBUG</b></dt> <dt>22</dt> </dl> </td> <td width="60%"> Nonzero if the debug
///             version of User.exe is installed; otherwise, 0. </td> </tr> <tr> <td width="40%"><a id="SM_DIGITIZER"></a><a
///             id="sm_digitizer"></a><dl> <dt><b>SM_DIGITIZER</b></dt> <dt>94</dt> </dl> </td> <td width="60%"> Nonzero if the
///             current operating system is Windows 7 or Windows Server 2008 R2 and the Tablet PC Input service is started;
///             otherwise, 0. The return value is a bitmask that specifies the type of digitizer input supported by the device.
///             For more information, see Remarks. <b>Windows Server 2008, Windows Vista and Windows XP/2000: </b>This value is
///             not supported. </td> </tr> <tr> <td width="40%"><a id="SM_IMMENABLED"></a><a id="sm_immenabled"></a><dl>
///             <dt><b>SM_IMMENABLED</b></dt> <dt>82</dt> </dl> </td> <td width="60%"> Nonzero if Input Method Manager/Input
///             Method Editor features are enabled; otherwise, 0. SM_IMMENABLED indicates whether the system is ready to use a
///             Unicode-based IME on a Unicode application. To ensure that a language-dependent IME works, check SM_DBCSENABLED
///             and the system ANSI code page. Otherwise the ANSI-to-Unicode conversion may not be performed correctly, or some
///             components like fonts or registry settings may not be present. </td> </tr> <tr> <td width="40%"><a
///             id="SM_MAXIMUMTOUCHES"></a><a id="sm_maximumtouches"></a><dl> <dt><b>SM_MAXIMUMTOUCHES</b></dt> <dt>95</dt> </dl>
///             </td> <td width="60%"> Nonzero if there are digitizers in the system; otherwise, 0. SM_MAXIMUMTOUCHES returns the
///             aggregate maximum of the maximum number of contacts supported by every digitizer in the system. If the system has
///             only single-touch digitizers, the return value is 1. If the system has multi-touch digitizers, the return value
///             is the number of simultaneous contacts the hardware can provide. <b>Windows Server 2008, Windows Vista and
///             Windows XP/2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="SM_MEDIACENTER"></a><a
///             id="sm_mediacenter"></a><dl> <dt><b>SM_MEDIACENTER</b></dt> <dt>87</dt> </dl> </td> <td width="60%"> Nonzero if
///             the current operating system is the Windows XP, Media Center Edition, 0 if not. </td> </tr> <tr> <td
///             width="40%"><a id="SM_MENUDROPALIGNMENT"></a><a id="sm_menudropalignment"></a><dl>
///             <dt><b>SM_MENUDROPALIGNMENT</b></dt> <dt>40</dt> </dl> </td> <td width="60%"> Nonzero if drop-down menus are
///             right-aligned with the corresponding menu-bar item; 0 if the menus are left-aligned. </td> </tr> <tr> <td
///             width="40%"><a id="SM_MIDEASTENABLED"></a><a id="sm_mideastenabled"></a><dl> <dt><b>SM_MIDEASTENABLED</b></dt>
///             <dt>74</dt> </dl> </td> <td width="60%"> Nonzero if the system is enabled for Hebrew and Arabic languages, 0 if
///             not. </td> </tr> <tr> <td width="40%"><a id="SM_MOUSEPRESENT"></a><a id="sm_mousepresent"></a><dl>
///             <dt><b>SM_MOUSEPRESENT</b></dt> <dt>19</dt> </dl> </td> <td width="60%"> Nonzero if a mouse is installed;
///             otherwise, 0. This value is rarely zero, because of support for virtual mice and because some systems detect the
///             presence of the port instead of the presence of a mouse. </td> </tr> <tr> <td width="40%"><a
///             id="SM_MOUSEHORIZONTALWHEELPRESENT"></a><a id="sm_mousehorizontalwheelpresent"></a><dl>
///             <dt><b>SM_MOUSEHORIZONTALWHEELPRESENT</b></dt> <dt>91</dt> </dl> </td> <td width="60%"> Nonzero if a mouse with a
///             horizontal scroll wheel is installed; otherwise 0. </td> </tr> <tr> <td width="40%"><a
///             id="SM_MOUSEWHEELPRESENT"></a><a id="sm_mousewheelpresent"></a><dl> <dt><b>SM_MOUSEWHEELPRESENT</b></dt>
///             <dt>75</dt> </dl> </td> <td width="60%"> Nonzero if a mouse with a vertical scroll wheel is installed; otherwise
///             0. </td> </tr> <tr> <td width="40%"><a id="SM_NETWORK"></a><a id="sm_network"></a><dl> <dt><b>SM_NETWORK</b></dt>
///             <dt>63</dt> </dl> </td> <td width="60%"> The least significant bit is set if a network is present; otherwise, it
///             is cleared. The other bits are reserved for future use. </td> </tr> <tr> <td width="40%"><a
///             id="SM_PENWINDOWS"></a><a id="sm_penwindows"></a><dl> <dt><b>SM_PENWINDOWS</b></dt> <dt>41</dt> </dl> </td> <td
///             width="60%"> Nonzero if the Microsoft Windows for Pen computing extensions are installed; zero otherwise. </td>
///             </tr> <tr> <td width="40%"><a id="SM_REMOTECONTROL"></a><a id="sm_remotecontrol"></a><dl>
///             <dt><b>SM_REMOTECONTROL</b></dt> <dt>0x2001</dt> </dl> </td> <td width="60%"> This system metric is used in a
///             Terminal Services environment to determine if the current Terminal Server session is being remotely controlled.
///             Its value is nonzero if the current session is remotely controlled; otherwise, 0. You can use terminal services
///             management tools such as Terminal Services Manager (tsadmin.msc) and shadow.exe to control a remote session. When
///             a session is being remotely controlled, another user can view the contents of that session and potentially
///             interact with it. </td> </tr> <tr> <td width="40%"><a id="SM_REMOTESESSION"></a><a id="sm_remotesession"></a><dl>
///             <dt><b>SM_REMOTESESSION</b></dt> <dt>0x1000</dt> </dl> </td> <td width="60%"> This system metric is used in a
///             Terminal Services environment. If the calling process is associated with a Terminal Services client session, the
///             return value is nonzero. If the calling process is associated with the Terminal Services console session, the
///             return value is 0. <b>Windows Server 2003 and Windows XP: </b>The console session is not necessarily the physical
///             console. For more information, see WTSGetActiveConsoleSessionId. </td> </tr> <tr> <td width="40%"><a
///             id="SM_SAMEDISPLAYFORMAT"></a><a id="sm_samedisplayformat"></a><dl> <dt><b>SM_SAMEDISPLAYFORMAT</b></dt>
///             <dt>81</dt> </dl> </td> <td width="60%"> Nonzero if all the display monitors have the same color format,
///             otherwise, 0. Two displays can have the same bit depth, but different color formats. For example, the red, green,
///             and blue pixels can be encoded with different numbers of bits, or those bits can be located in different places
///             in a pixel color value. </td> </tr> <tr> <td width="40%"><a id="SM_SECURE"></a><a id="sm_secure"></a><dl>
///             <dt><b>SM_SECURE</b></dt> <dt>44</dt> </dl> </td> <td width="60%"> This system metric should be ignored; it
///             always returns 0. </td> </tr> <tr> <td width="40%"><a id="SM_SERVERR2"></a><a id="sm_serverr2"></a><dl>
///             <dt><b>SM_SERVERR2</b></dt> <dt>89</dt> </dl> </td> <td width="60%"> The build number if the system is Windows
///             Server 2003 R2; otherwise, 0. </td> </tr> <tr> <td width="40%"><a id="SM_SHOWSOUNDS"></a><a
///             id="sm_showsounds"></a><dl> <dt><b>SM_SHOWSOUNDS</b></dt> <dt>70</dt> </dl> </td> <td width="60%"> Nonzero if the
///             user requires an application to present information visually in situations where it would otherwise present the
///             information only in audible form; otherwise, 0. </td> </tr> <tr> <td width="40%"><a id="SM_SHUTTINGDOWN"></a><a
///             id="sm_shuttingdown"></a><dl> <dt><b>SM_SHUTTINGDOWN</b></dt> <dt>0x2000</dt> </dl> </td> <td width="60%">
///             Nonzero if the current session is shutting down; otherwise, 0. <b>Windows 2000: </b>This value is not supported.
///             </td> </tr> <tr> <td width="40%"><a id="SM_SLOWMACHINE"></a><a id="sm_slowmachine"></a><dl>
///             <dt><b>SM_SLOWMACHINE</b></dt> <dt>73</dt> </dl> </td> <td width="60%"> Nonzero if the computer has a low-end
///             (slow) processor; otherwise, 0. </td> </tr> <tr> <td width="40%"><a id="SM_STARTER"></a><a
///             id="sm_starter"></a><dl> <dt><b>SM_STARTER</b></dt> <dt>88</dt> </dl> </td> <td width="60%"> Nonzero if the
///             current operating system is Windows 7 Starter Edition, Windows Vista Starter, or Windows XP Starter Edition;
///             otherwise, 0. </td> </tr> <tr> <td width="40%"><a id="SM_SWAPBUTTON"></a><a id="sm_swapbutton"></a><dl>
///             <dt><b>SM_SWAPBUTTON</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> Nonzero if the meanings of the left and
///             right mouse buttons are swapped; otherwise, 0. </td> </tr> <tr> <td width="40%"><a id="SM_SYSTEMDOCKED_"></a><a
///             id="sm_systemdocked_"></a><dl> <dt><b>SM_SYSTEMDOCKED </b></dt> <dt>0x2004</dt> </dl> </td> <td width="60%">
///             Reflects the state of the docking mode, 0 for Undocked Mode and non-zero otherwise. When this system metric
///             changes, the system sends a broadcast message via WM_SETTINGCHANGE with "SystemDockMode" in the LPARAM. </td>
///             </tr> <tr> <td width="40%"><a id="SM_TABLETPC"></a><a id="sm_tabletpc"></a><dl> <dt><b>SM_TABLETPC</b></dt>
///             <dt>86</dt> </dl> </td> <td width="60%"> Nonzero if the current operating system is the Windows XP Tablet PC
///             edition or if the current operating system is Windows Vista or Windows 7 and the Tablet PC Input service is
///             started; otherwise, 0. The SM_DIGITIZER setting indicates the type of digitizer input supported by a device
///             running Windows 7 or Windows Server 2008 R2. For more information, see Remarks. </td> </tr> <tr> <td
///             width="40%"><a id="SM_XVIRTUALSCREEN"></a><a id="sm_xvirtualscreen"></a><dl> <dt><b>SM_XVIRTUALSCREEN</b></dt>
///             <dt>76</dt> </dl> </td> <td width="60%"> The coordinates for the left side of the virtual screen. The virtual
///             screen is the bounding rectangle of all display monitors. The SM_CXVIRTUALSCREEN metric is the width of the
///             virtual screen. </td> </tr> <tr> <td width="40%"><a id="SM_YVIRTUALSCREEN"></a><a id="sm_yvirtualscreen"></a><dl>
///             <dt><b>SM_YVIRTUALSCREEN</b></dt> <dt>77</dt> </dl> </td> <td width="60%"> The coordinates for the top of the
///             virtual screen. The virtual screen is the bounding rectangle of all display monitors. The SM_CYVIRTUALSCREEN
///             metric is the height of the virtual screen. </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the requested system metric or configuration
///    setting. If the function fails, the return value is 0. GetLastError does not provide extended error information.
///    
@DllImport("USER32")
int GetSystemMetrics(int nIndex);

///Calculates an appropriate pop-up window position using the specified anchor point, pop-up window size, flags, and the
///optional exclude rectangle. When the specified pop-up window size is smaller than the desktop window size, use the
///<b>CalculatePopupWindowPosition</b> function to ensure that the pop-up window is fully visible on the desktop window,
///regardless of the specified anchor point.
///Params:
///    anchorPoint = Type: <b>const POINT*</b> The specified anchor point.
///    windowSize = Type: <b>const SIZE*</b> The specified window size.
///    flags = Type: <b>UINT</b> Use one of the following flags to specify how the function positions the pop-up window
///            horizontally and vertically. The flags are the same as the vertical and horizontal positioning flags of the
///            TrackPopupMenuEx function. Use one of the following flags to specify how the function positions the pop-up window
///            horizontally. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="TPM_CENTERALIGN"></a><a id="tpm_centeralign"></a><dl> <dt><b>TPM_CENTERALIGN</b></dt> <dt>0x0004L</dt> </dl>
///            </td> <td width="60%"> Centers pop-up window horizontally relative to the coordinate specified by the
///            anchorPoint-&gt;x parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_LEFTALIGN"></a><a
///            id="tpm_leftalign"></a><dl> <dt><b>TPM_LEFTALIGN</b></dt> <dt>0x0000L</dt> </dl> </td> <td width="60%"> Positions
///            the pop-up window so that its left edge is aligned with the coordinate specified by the anchorPoint-&gt;x
///            parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_RIGHTALIGN"></a><a id="tpm_rightalign"></a><dl>
///            <dt><b>TPM_RIGHTALIGN</b></dt> <dt>0x0008L</dt> </dl> </td> <td width="60%"> Positions the pop-up window so that
///            its right edge is aligned with the coordinate specified by the anchorPoint-&gt;x parameter. </td> </tr> </table>
///            Uses one of the following flags to specify how the function positions the pop-up window vertically. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_BOTTOMALIGN"></a><a
///            id="tpm_bottomalign"></a><dl> <dt><b>TPM_BOTTOMALIGN</b></dt> <dt>0x0020L</dt> </dl> </td> <td width="60%">
///            Positions the pop-up window so that its bottom edge is aligned with the coordinate specified by the
///            anchorPoint-&gt;y parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_TOPALIGN"></a><a
///            id="tpm_topalign"></a><dl> <dt><b>TPM_TOPALIGN</b></dt> <dt>0x0000L</dt> </dl> </td> <td width="60%"> Positions
///            the pop-up window so that its top edge is aligned with the coordinate specified by the anchorPoint-&gt;y
///            parameter. </td> </tr> <tr> <td width="40%"><a id="TPM_VCENTERALIGN"></a><a id="tpm_vcenteralign"></a><dl>
///            <dt><b>TPM_VCENTERALIGN</b></dt> <dt>0x0010L</dt> </dl> </td> <td width="60%"> Centers the pop-up window
///            vertically relative to the coordinate specified by the anchorPoint-&gt;y parameter. </td> </tr> </table> Use one
///            of the following flags to specify whether to accommodate horizontal or vertical alignment. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_HORIZONTAL"></a><a
///            id="tpm_horizontal"></a><dl> <dt><b>TPM_HORIZONTAL</b></dt> <dt>0x0000L</dt> </dl> </td> <td width="60%"> If the
///            pop-up window cannot be shown at the specified location without overlapping the excluded rectangle, the system
///            tries to accommodate the requested horizontal alignment before the requested vertical alignment. </td> </tr> <tr>
///            <td width="40%"><a id="TPM_VERTICAL"></a><a id="tpm_vertical"></a><dl> <dt><b>TPM_VERTICAL</b></dt>
///            <dt>0x0040L</dt> </dl> </td> <td width="60%"> If the pop-up window cannot be shown at the specified location
///            without overlapping the excluded rectangle, the system tries to accommodate the requested vertical alignment
///            before the requested horizontal alignment. </td> </tr> </table> The following flag is available starting with
///            Windows 7. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TPM_WORKAREA"></a><a
///            id="tpm_workarea"></a><dl> <dt><b>TPM_WORKAREA</b></dt> <dt>0x10000L</dt> </dl> </td> <td width="60%"> Restricts
///            the pop-up window to within the work area. If this flag is not set, the pop-up window is restricted to the work
///            area only if the input point is within the work area. For more information, see the <b>rcWork</b> and
///            <b>rcMonitor</b> members of the MONITORINFO structure. </td> </tr> </table>
///    excludeRect = Type: <b>RECT*</b> A pointer to a structure that specifies the exclude rectangle. It can be <b>NULL</b>.
///    popupWindowPosition = Type: <b>RECT*</b> A pointer to a structure that specifies the pop-up window position.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, it returns <b>TRUE</b>; otherwise, it returns <b>FALSE</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL CalculatePopupWindowPosition(const(POINT)* anchorPoint, const(SIZE)* windowSize, uint flags, 
                                  RECT* excludeRect, RECT* popupWindowPosition);

///Retrieves a handle to the foreground window (the window with which the user is currently working). The system assigns
///a slightly higher priority to the thread that creates the foreground window than it does to other threads.
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the foreground window. The foreground window can be <b>NULL</b>
///    in certain circumstances, such as when a window is losing activation.
///    
@DllImport("USER32")
HWND GetForegroundWindow();

///<p class="CCE_Message">[This function is not intended for general use. It may be altered or unavailable in subsequent
///versions of Windows.] Switches focus to the specified window and brings it to the foreground.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window.
///    fUnknown = Type: <b>BOOL</b> A <b>TRUE</b> for this parameter indicates that the window is being switched to using the
///               Alt/Ctl+Tab key sequence. This parameter should be <b>FALSE</b> otherwise.
@DllImport("USER32")
void SwitchToThisWindow(HWND hwnd, BOOL fUnknown);

///Brings the thread that created the specified window into the foreground and activates the window. Keyboard input is
///directed to the window, and various visual cues are changed for the user. The system assigns a slightly higher
///priority to the thread that created the foreground window than it does to other threads.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that should be activated and brought to the foreground.
///Returns:
///    Type: <b>BOOL</b> If the window was brought to the foreground, the return value is nonzero. If the window was not
///    brought to the foreground, the return value is zero.
///    
@DllImport("USER32")
BOOL SetForegroundWindow(HWND hWnd);

///Enables the specified process to set the foreground window using the SetForegroundWindow function. The calling
///process must already be able to set the foreground window. For more information, see Remarks later in this topic.
///Params:
///    dwProcessId = Type: <b>DWORD</b> The identifier of the process that will be enabled to set the foreground window. If this
///                  parameter is <b>ASFW_ANY</b>, all processes will be enabled to set the foreground window.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The function will fail if the calling process cannot set the foreground window. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
BOOL AllowSetForegroundWindow(uint dwProcessId);

///The foreground process can call the <b>LockSetForegroundWindow</b> function to disable calls to the
///SetForegroundWindow function.
///Params:
///    uLockCode = Type: <b>UINT</b> Specifies whether to enable or disable calls to SetForegroundWindow. This parameter can be one
///                of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="LSFW_LOCK"></a><a id="lsfw_lock"></a><dl> <dt><b>LSFW_LOCK</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
///                Disables calls to SetForegroundWindow. </td> </tr> <tr> <td width="40%"><a id="LSFW_UNLOCK"></a><a
///                id="lsfw_unlock"></a><dl> <dt><b>LSFW_UNLOCK</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Enables calls to
///                SetForegroundWindow. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL LockSetForegroundWindow(uint uLockCode);

///Adds a new entry or changes an existing entry in the property list of the specified window. The function adds a new
///entry to the list if the specified character string does not exist already in the list. The new entry contains the
///string and the handle. Otherwise, the function replaces the string's current handle with the specified handle.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list receives the new entry.
///    lpString = Type: <b>LPCTSTR</b> A null-terminated string or an atom that identifies a string. If this parameter is an atom,
///               it must be a global atom created by a previous call to the GlobalAddAtom function. The atom must be placed in the
///               low-order word of <i>lpString</i>; the high-order word must be zero.
///    hData = Type: <b>HANDLE</b> A handle to the data to be copied to the property list. The data handle can identify any
///            value useful to the application.
///Returns:
///    Type: <b>BOOL</b> If the data handle and string are added to the property list, the return value is nonzero. If
///    the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetPropA(HWND hWnd, const(PSTR) lpString, HANDLE hData);

///Adds a new entry or changes an existing entry in the property list of the specified window. The function adds a new
///entry to the list if the specified character string does not exist already in the list. The new entry contains the
///string and the handle. Otherwise, the function replaces the string's current handle with the specified handle.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list receives the new entry.
///    lpString = Type: <b>LPCTSTR</b> A null-terminated string or an atom that identifies a string. If this parameter is an atom,
///               it must be a global atom created by a previous call to the GlobalAddAtom function. The atom must be placed in the
///               low-order word of <i>lpString</i>; the high-order word must be zero.
///    hData = Type: <b>HANDLE</b> A handle to the data to be copied to the property list. The data handle can identify any
///            value useful to the application.
///Returns:
///    Type: <b>BOOL</b> If the data handle and string are added to the property list, the return value is nonzero. If
///    the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetPropW(HWND hWnd, const(PWSTR) lpString, HANDLE hData);

///Retrieves a data handle from the property list of the specified window. The character string identifies the handle to
///be retrieved. The string and handle must have been added to the property list by a previous call to the SetProp
///function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be searched.
///    lpString = Type: <b>LPCTSTR</b> An atom that identifies a string. If this parameter is an atom, it must have been created by
///               using the GlobalAddAtom function. The atom, a 16-bit value, must be placed in the low-order word of the
///               <i>lpString</i> parameter; the high-order word must be zero.
///Returns:
///    Type: <b>HANDLE</b> If the property list contains the string, the return value is the associated data handle.
///    Otherwise, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HANDLE GetPropA(HWND hWnd, const(PSTR) lpString);

///Retrieves a data handle from the property list of the specified window. The character string identifies the handle to
///be retrieved. The string and handle must have been added to the property list by a previous call to the SetProp
///function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be searched.
///    lpString = Type: <b>LPCTSTR</b> An atom that identifies a string. If this parameter is an atom, it must have been created by
///               using the GlobalAddAtom function. The atom, a 16-bit value, must be placed in the low-order word of the
///               <i>lpString</i> parameter; the high-order word must be zero.
///Returns:
///    Type: <b>HANDLE</b> If the property list contains the string, the return value is the associated data handle.
///    Otherwise, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HANDLE GetPropW(HWND hWnd, const(PWSTR) lpString);

///Removes an entry from the property list of the specified window. The specified character string identifies the entry
///to be removed.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be changed.
///    lpString = Type: <b>LPCTSTR</b> A null-terminated character string or an atom that identifies a string. If this parameter is
///               an atom, it must have been created using the GlobalAddAtom function. The atom, a 16-bit value, must be placed in
///               the low-order word of <i>lpString</i>; the high-order word must be zero.
///Returns:
///    Type: <b>HANDLE</b> The return value identifies the specified data. If the data cannot be found in the specified
///    property list, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HANDLE RemovePropA(HWND hWnd, const(PSTR) lpString);

///Removes an entry from the property list of the specified window. The specified character string identifies the entry
///to be removed.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be changed.
///    lpString = Type: <b>LPCTSTR</b> A null-terminated character string or an atom that identifies a string. If this parameter is
///               an atom, it must have been created using the GlobalAddAtom function. The atom, a 16-bit value, must be placed in
///               the low-order word of <i>lpString</i>; the high-order word must be zero.
///Returns:
///    Type: <b>HANDLE</b> The return value identifies the specified data. If the data cannot be found in the specified
///    property list, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HANDLE RemovePropW(HWND hWnd, const(PWSTR) lpString);

///Enumerates all entries in the property list of a window by passing them, one by one, to the specified callback
///function. <b>EnumPropsEx</b> continues until the last entry is enumerated or the callback function returns
///<b>FALSE</b>.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be enumerated.
///    lpEnumFunc = Type: <b>PROPENUMPROCEX</b> A pointer to the callback function. For more information about the callback function,
///                 see the PropEnumProcEx function.
///    lParam = Type: <b>LPARAM</b> Application-defined data to be passed to the callback function.
///Returns:
///    Type: <b>int</b> The return value specifies the last value returned by the callback function. It is -1 if the
///    function did not find a property for enumeration.
///    
@DllImport("USER32")
int EnumPropsExA(HWND hWnd, PROPENUMPROCEXA lpEnumFunc, LPARAM lParam);

///Enumerates all entries in the property list of a window by passing them, one by one, to the specified callback
///function. <b>EnumPropsEx</b> continues until the last entry is enumerated or the callback function returns
///<b>FALSE</b>.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be enumerated.
///    lpEnumFunc = Type: <b>PROPENUMPROCEX</b> A pointer to the callback function. For more information about the callback function,
///                 see the PropEnumProcEx function.
///    lParam = Type: <b>LPARAM</b> Application-defined data to be passed to the callback function.
///Returns:
///    Type: <b>int</b> The return value specifies the last value returned by the callback function. It is -1 if the
///    function did not find a property for enumeration.
///    
@DllImport("USER32")
int EnumPropsExW(HWND hWnd, PROPENUMPROCEXW lpEnumFunc, LPARAM lParam);

///Enumerates all entries in the property list of a window by passing them, one by one, to the specified callback
///function. <b>EnumProps</b> continues until the last entry is enumerated or the callback function returns
///<b>FALSE</b>. To pass application-defined data to the callback function, use EnumPropsEx function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be enumerated.
///    lpEnumFunc = Type: <b>PROPENUMPROC</b> A pointer to the callback function. For more information about the callback function,
///                 see the PropEnumProc function.
///Returns:
///    Type: <b>int</b> The return value specifies the last value returned by the callback function. It is -1 if the
///    function did not find a property for enumeration.
///    
@DllImport("USER32")
int EnumPropsA(HWND hWnd, PROPENUMPROCA lpEnumFunc);

///Enumerates all entries in the property list of a window by passing them, one by one, to the specified callback
///function. <b>EnumProps</b> continues until the last entry is enumerated or the callback function returns
///<b>FALSE</b>. To pass application-defined data to the callback function, use EnumPropsEx function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose property list is to be enumerated.
///    lpEnumFunc = Type: <b>PROPENUMPROC</b> A pointer to the callback function. For more information about the callback function,
///                 see the PropEnumProc function.
///Returns:
///    Type: <b>int</b> The return value specifies the last value returned by the callback function. It is -1 if the
///    function did not find a property for enumeration.
///    
@DllImport("USER32")
int EnumPropsW(HWND hWnd, PROPENUMPROCW lpEnumFunc);

///Changes the text of the specified window's title bar (if it has one). If the specified window is a control, the text
///of the control is changed. However, <b>SetWindowText</b> cannot change the text of a control in another application.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window or control whose text is to be changed.
///    lpString = Type: <b>LPCTSTR</b> The new title or control text.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetWindowTextA(HWND hWnd, const(PSTR) lpString);

///Changes the text of the specified window's title bar (if it has one). If the specified window is a control, the text
///of the control is changed. However, <b>SetWindowText</b> cannot change the text of a control in another application.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window or control whose text is to be changed.
///    lpString = Type: <b>LPCTSTR</b> The new title or control text.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetWindowTextW(HWND hWnd, const(PWSTR) lpString);

///Copies the text of the specified window's title bar (if it has one) into a buffer. If the specified window is a
///control, the text of the control is copied. However, <b>GetWindowText</b> cannot retrieve the text of a control in
///another application.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window or control containing the text.
///    lpString = Type: <b>LPTSTR</b> The buffer that will receive the text. If the string is as long or longer than the buffer,
///               the string is truncated and terminated with a null character.
///    nMaxCount = Type: <b>int</b> The maximum number of characters to copy to the buffer, including the null character. If the
///                text exceeds this limit, it is truncated.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the length, in characters, of the copied string,
///    not including the terminating null character. If the window has no title bar or text, if the title bar is empty,
///    or if the window or control handle is invalid, the return value is zero. To get extended error information, call
///    GetLastError. This function cannot retrieve the text of an edit control in another application.
///    
@DllImport("USER32")
int GetWindowTextA(HWND hWnd, PSTR lpString, int nMaxCount);

///Copies the text of the specified window's title bar (if it has one) into a buffer. If the specified window is a
///control, the text of the control is copied. However, <b>GetWindowText</b> cannot retrieve the text of a control in
///another application.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window or control containing the text.
///    lpString = Type: <b>LPTSTR</b> The buffer that will receive the text. If the string is as long or longer than the buffer,
///               the string is truncated and terminated with a null character.
///    nMaxCount = Type: <b>int</b> The maximum number of characters to copy to the buffer, including the null character. If the
///                text exceeds this limit, it is truncated.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the length, in characters, of the copied string,
///    not including the terminating null character. If the window has no title bar or text, if the title bar is empty,
///    or if the window or control handle is invalid, the return value is zero. To get extended error information, call
///    GetLastError. This function cannot retrieve the text of an edit control in another application.
///    
@DllImport("USER32")
int GetWindowTextW(HWND hWnd, PWSTR lpString, int nMaxCount);

///Retrieves the length, in characters, of the specified window's title bar text (if the window has a title bar). If the
///specified window is a control, the function retrieves the length of the text within the control. However,
///<b>GetWindowTextLength</b> cannot retrieve the length of the text of an edit control in another application.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window or control.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the length, in characters, of the text. Under
///    certain conditions, this value might be greater than the length of the text (see Remarks). If the window has no
///    text, the return value is zero. Function failure is indicated by a return value of zero and a GetLastError result
///    that is nonzero. > [!NOTE] > This function does not clear the most recent error information. To determine success
///    or failure, clear the most recent error information by calling SetLastError with 0, then call GetLastError.
///    
@DllImport("USER32")
int GetWindowTextLengthA(HWND hWnd);

///Retrieves the length, in characters, of the specified window's title bar text (if the window has a title bar). If the
///specified window is a control, the function retrieves the length of the text within the control. However,
///<b>GetWindowTextLength</b> cannot retrieve the length of the text of an edit control in another application.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window or control.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the length, in characters, of the text. Under
///    certain conditions, this value might be greater than the length of the text (see Remarks). If the window has no
///    text, the return value is zero. Function failure is indicated by a return value of zero and a GetLastError result
///    that is nonzero. > [!NOTE] > This function does not clear the most recent error information. To determine success
///    or failure, clear the most recent error information by calling SetLastError with 0, then call GetLastError.
///    
@DllImport("USER32")
int GetWindowTextLengthW(HWND hWnd);

///Retrieves the coordinates of a window's client area. The client coordinates specify the upper-left and lower-right
///corners of the client area. Because client coordinates are relative to the upper-left corner of a window's client
///area, the coordinates of the upper-left corner are (0,0).
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose client coordinates are to be retrieved.
///    lpRect = Type: <b>LPRECT</b> A pointer to a RECT structure that receives the client coordinates. The <b>left</b> and
///             <b>top</b> members are zero. The <b>right</b> and <b>bottom</b> members contain the width and height of the
///             window.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetClientRect(HWND hWnd, RECT* lpRect);

///Retrieves the dimensions of the bounding rectangle of the specified window. The dimensions are given in screen
///coordinates that are relative to the upper-left corner of the screen.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    lpRect = Type: <b>LPRECT</b> A pointer to a RECT structure that receives the screen coordinates of the upper-left and
///             lower-right corners of the window.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetWindowRect(HWND hWnd, RECT* lpRect);

///Calculates the required size of the window rectangle, based on the desired client-rectangle size. The window
///rectangle can then be passed to the CreateWindow function to create a window whose client area is the desired size.
///To specify an extended window style, use the AdjustWindowRectEx function.
///Params:
///    lpRect = Type: <b>LPRECT</b> A pointer to a RECT structure that contains the coordinates of the top-left and bottom-right
///             corners of the desired client area. When the function returns, the structure contains the coordinates of the
///             top-left and bottom-right corners of the window to accommodate the desired client area.
///    dwStyle = Type: <b>DWORD</b> The window style of the window whose required size is to be calculated. Note that you cannot
///              specify the <b>WS_OVERLAPPED</b> style.
///    bMenu = Type: <b>BOOL</b> Indicates whether the window has a menu.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL AdjustWindowRect(RECT* lpRect, uint dwStyle, BOOL bMenu);

///Calculates the required size of the window rectangle, based on the desired size of the client rectangle. The window
///rectangle can then be passed to the CreateWindowEx function to create a window whose client area is the desired size.
///Params:
///    lpRect = Type: <b>LPRECT</b> A pointer to a RECT structure that contains the coordinates of the top-left and bottom-right
///             corners of the desired client area. When the function returns, the structure contains the coordinates of the
///             top-left and bottom-right corners of the window to accommodate the desired client area.
///    dwStyle = Type: <b>DWORD</b> The window style of the window whose required size is to be calculated. Note that you cannot
///              specify the <b>WS_OVERLAPPED</b> style.
///    bMenu = Type: <b>BOOL</b> Indicates whether the window has a menu.
///    dwExStyle = Type: <b>DWORD</b> The extended window style of the window whose required size is to be calculated.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL AdjustWindowRectEx(RECT* lpRect, uint dwStyle, BOOL bMenu, uint dwExStyle);

///Displays a modal dialog box that contains a system icon, a set of buttons, and a brief application-specific message,
///such as status or error information. The message box returns an integer value that indicates which button the user
///clicked.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the owner window of the message box to be created. If this parameter is
///           <b>NULL</b>, the message box has no owner window.
///    lpText = Type: <b>LPCTSTR</b> The message to be displayed. If the string consists of more than one line, you can separate
///             the lines using a carriage return and/or linefeed character between each line.
///    lpCaption = Type: <b>LPCTSTR</b> The dialog box title. If this parameter is <b>NULL</b>, the default title is <b>Error</b>.
///    uType = Type: <b>UINT</b> The contents and behavior of the dialog box. This parameter can be a combination of flags from
///            the following groups of flags. To indicate the buttons displayed in the message box, specify one of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MB_ABORTRETRYIGNORE"></a><a id="mb_abortretryignore"></a><dl> <dt><b>MB_ABORTRETRYIGNORE</b></dt>
///            <dt>0x00000002L</dt> </dl> </td> <td width="60%"> The message box contains three push buttons: <b>Abort</b>,
///            <b>Retry</b>, and <b>Ignore</b>. </td> </tr> <tr> <td width="40%"><a id="MB_CANCELTRYCONTINUE"></a><a
///            id="mb_canceltrycontinue"></a><dl> <dt><b>MB_CANCELTRYCONTINUE</b></dt> <dt>0x00000006L</dt> </dl> </td> <td
///            width="60%"> The message box contains three push buttons: <b>Cancel</b>, <b>Try Again</b>, <b>Continue</b>. Use
///            this message box type instead of MB_ABORTRETRYIGNORE. </td> </tr> <tr> <td width="40%"><a id="MB_HELP"></a><a
///            id="mb_help"></a><dl> <dt><b>MB_HELP</b></dt> <dt>0x00004000L</dt> </dl> </td> <td width="60%"> Adds a
///            <b>Help</b> button to the message box. When the user clicks the <b>Help</b> button or presses F1, the system
///            sends a WM_HELP message to the owner. </td> </tr> <tr> <td width="40%"><a id="MB_OK"></a><a id="mb_ok"></a><dl>
///            <dt><b>MB_OK</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The message box contains one push button:
///            <b>OK</b>. This is the default. </td> </tr> <tr> <td width="40%"><a id="MB_OKCANCEL"></a><a
///            id="mb_okcancel"></a><dl> <dt><b>MB_OKCANCEL</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The
///            message box contains two push buttons: <b>OK</b> and <b>Cancel</b>. </td> </tr> <tr> <td width="40%"><a
///            id="MB_RETRYCANCEL"></a><a id="mb_retrycancel"></a><dl> <dt><b>MB_RETRYCANCEL</b></dt> <dt>0x00000005L</dt> </dl>
///            </td> <td width="60%"> The message box contains two push buttons: <b>Retry</b> and <b>Cancel</b>. </td> </tr>
///            <tr> <td width="40%"><a id="MB_YESNO"></a><a id="mb_yesno"></a><dl> <dt><b>MB_YESNO</b></dt> <dt>0x00000004L</dt>
///            </dl> </td> <td width="60%"> The message box contains two push buttons: <b>Yes</b> and <b>No</b>. </td> </tr>
///            <tr> <td width="40%"><a id="MB_YESNOCANCEL"></a><a id="mb_yesnocancel"></a><dl> <dt><b>MB_YESNOCANCEL</b></dt>
///            <dt>0x00000003L</dt> </dl> </td> <td width="60%"> The message box contains three push buttons: <b>Yes</b>,
///            <b>No</b>, and <b>Cancel</b>. </td> </tr> </table> To display an icon in the message box, specify one of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MB_ICONEXCLAMATION"></a><a id="mb_iconexclamation"></a><dl> <dt><b>MB_ICONEXCLAMATION</b></dt>
///            <dt>0x00000030L</dt> </dl> </td> <td width="60%"> An exclamation-point icon appears in the message box. </td>
///            </tr> <tr> <td width="40%"><a id="MB_ICONWARNING"></a><a id="mb_iconwarning"></a><dl>
///            <dt><b>MB_ICONWARNING</b></dt> <dt>0x00000030L</dt> </dl> </td> <td width="60%"> An exclamation-point icon
///            appears in the message box. </td> </tr> <tr> <td width="40%"><a id="MB_ICONINFORMATION"></a><a
///            id="mb_iconinformation"></a><dl> <dt><b>MB_ICONINFORMATION</b></dt> <dt>0x00000040L</dt> </dl> </td> <td
///            width="60%"> An icon consisting of a lowercase letter <i>i</i> in a circle appears in the message box. </td>
///            </tr> <tr> <td width="40%"><a id="MB_ICONASTERISK"></a><a id="mb_iconasterisk"></a><dl>
///            <dt><b>MB_ICONASTERISK</b></dt> <dt>0x00000040L</dt> </dl> </td> <td width="60%"> An icon consisting of a
///            lowercase letter <i>i</i> in a circle appears in the message box. </td> </tr> <tr> <td width="40%"><a
///            id="MB_ICONQUESTION"></a><a id="mb_iconquestion"></a><dl> <dt><b>MB_ICONQUESTION</b></dt> <dt>0x00000020L</dt>
///            </dl> </td> <td width="60%"> A question-mark icon appears in the message box. The question-mark message icon is
///            no longer recommended because it does not clearly represent a specific type of message and because the phrasing
///            of a message as a question could apply to any message type. In addition, users can confuse the message symbol
///            question mark with Help information. Therefore, do not use this question mark message symbol in your message
///            boxes. The system continues to support its inclusion only for backward compatibility. </td> </tr> <tr> <td
///            width="40%"><a id="MB_ICONSTOP"></a><a id="mb_iconstop"></a><dl> <dt><b>MB_ICONSTOP</b></dt> <dt>0x00000010L</dt>
///            </dl> </td> <td width="60%"> A stop-sign icon appears in the message box. </td> </tr> <tr> <td width="40%"><a
///            id="MB_ICONERROR"></a><a id="mb_iconerror"></a><dl> <dt><b>MB_ICONERROR</b></dt> <dt>0x00000010L</dt> </dl> </td>
///            <td width="60%"> A stop-sign icon appears in the message box. </td> </tr> <tr> <td width="40%"><a
///            id="MB_ICONHAND"></a><a id="mb_iconhand"></a><dl> <dt><b>MB_ICONHAND</b></dt> <dt>0x00000010L</dt> </dl> </td>
///            <td width="60%"> A stop-sign icon appears in the message box. </td> </tr> </table> To indicate the default
///            button, specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="MB_DEFBUTTON1"></a><a id="mb_defbutton1"></a><dl> <dt><b>MB_DEFBUTTON1</b></dt>
///            <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The first button is the default button. <b>MB_DEFBUTTON1</b> is
///            the default unless <b>MB_DEFBUTTON2</b>, <b>MB_DEFBUTTON3</b>, or <b>MB_DEFBUTTON4</b> is specified. </td> </tr>
///            <tr> <td width="40%"><a id="MB_DEFBUTTON2"></a><a id="mb_defbutton2"></a><dl> <dt><b>MB_DEFBUTTON2</b></dt>
///            <dt>0x00000100L</dt> </dl> </td> <td width="60%"> The second button is the default button. </td> </tr> <tr> <td
///            width="40%"><a id="MB_DEFBUTTON3"></a><a id="mb_defbutton3"></a><dl> <dt><b>MB_DEFBUTTON3</b></dt>
///            <dt>0x00000200L</dt> </dl> </td> <td width="60%"> The third button is the default button. </td> </tr> <tr> <td
///            width="40%"><a id="MB_DEFBUTTON4"></a><a id="mb_defbutton4"></a><dl> <dt><b>MB_DEFBUTTON4</b></dt>
///            <dt>0x00000300L</dt> </dl> </td> <td width="60%"> The fourth button is the default button. </td> </tr> </table>
///            To indicate the modality of the dialog box, specify one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MB_APPLMODAL"></a><a id="mb_applmodal"></a><dl>
///            <dt><b>MB_APPLMODAL</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The user must respond to the
///            message box before continuing work in the window identified by the <i>hWnd</i> parameter. However, the user can
///            move to the windows of other threads and work in those windows. Depending on the hierarchy of windows in the
///            application, the user may be able to move to other windows within the thread. All child windows of the parent of
///            the message box are automatically disabled, but pop-up windows are not. <b>MB_APPLMODAL</b> is the default if
///            neither <b>MB_SYSTEMMODAL</b> nor <b>MB_TASKMODAL</b> is specified. </td> </tr> <tr> <td width="40%"><a
///            id="MB_SYSTEMMODAL"></a><a id="mb_systemmodal"></a><dl> <dt><b>MB_SYSTEMMODAL</b></dt> <dt>0x00001000L</dt> </dl>
///            </td> <td width="60%"> Same as MB_APPLMODAL except that the message box has the <b>WS_EX_TOPMOST</b> style. Use
///            system-modal message boxes to notify the user of serious, potentially damaging errors that require immediate
///            attention (for example, running out of memory). This flag has no effect on the user's ability to interact with
///            windows other than those associated with <i>hWnd</i>. </td> </tr> <tr> <td width="40%"><a
///            id="MB_TASKMODAL"></a><a id="mb_taskmodal"></a><dl> <dt><b>MB_TASKMODAL</b></dt> <dt>0x00002000L</dt> </dl> </td>
///            <td width="60%"> Same as <b>MB_APPLMODAL</b> except that all the top-level windows belonging to the current
///            thread are disabled if the <i>hWnd</i> parameter is <b>NULL</b>. Use this flag when the calling application or
///            library does not have a window handle available but still needs to prevent input to other windows in the calling
///            thread without suspending other threads. </td> </tr> </table> To specify other options, use one or more of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MB_DEFAULT_DESKTOP_ONLY"></a><a id="mb_default_desktop_only"></a><dl> <dt><b>MB_DEFAULT_DESKTOP_ONLY</b></dt>
///            <dt>0x00020000L</dt> </dl> </td> <td width="60%"> Same as desktop of the interactive window station. For more
///            information, see Window Stations. If the current input desktop is not the default desktop, <b>MessageBox</b> does
///            not return until the user switches to the default desktop. </td> </tr> <tr> <td width="40%"><a
///            id="MB_RIGHT"></a><a id="mb_right"></a><dl> <dt><b>MB_RIGHT</b></dt> <dt>0x00080000L</dt> </dl> </td> <td
///            width="60%"> The text is right-justified. </td> </tr> <tr> <td width="40%"><a id="MB_RTLREADING"></a><a
///            id="mb_rtlreading"></a><dl> <dt><b>MB_RTLREADING</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%">
///            Displays message and caption text using right-to-left reading order on Hebrew and Arabic systems. </td> </tr>
///            <tr> <td width="40%"><a id="MB_SETFOREGROUND"></a><a id="mb_setforeground"></a><dl>
///            <dt><b>MB_SETFOREGROUND</b></dt> <dt>0x00010000L</dt> </dl> </td> <td width="60%"> The message box becomes the
///            foreground window. Internally, the system calls the SetForegroundWindow function for the message box. </td> </tr>
///            <tr> <td width="40%"><a id="MB_TOPMOST"></a><a id="mb_topmost"></a><dl> <dt><b>MB_TOPMOST</b></dt>
///            <dt>0x00040000L</dt> </dl> </td> <td width="60%"> The message box is created with the <b>WS_EX_TOPMOST</b> window
///            style. </td> </tr> <tr> <td width="40%"><a id="MB_SERVICE_NOTIFICATION"></a><a
///            id="mb_service_notification"></a><dl> <dt><b>MB_SERVICE_NOTIFICATION</b></dt> <dt>0x00200000L</dt> </dl> </td>
///            <td width="60%"> The caller is a service notifying the user of an event. The function displays a message box on
///            the current active desktop, even if there is no user logged on to the computer. <b>Terminal Services:</b> If the
///            calling thread has an impersonation token, the function directs the message box to the session specified in the
///            impersonation token. If this flag is set, the <i>hWnd</i> parameter must be <b>NULL</b>. This is so that the
///            message box can appear on a desktop other than the desktop corresponding to the <i>hWnd</i>. For information on
///            security considerations in regard to using this flag, see Interactive Services. In particular, be aware that this
///            flag can produce interactive content on a locked desktop and should therefore be used for only a very limited set
///            of scenarios, such as resource exhaustion. </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If a message box has a <b>Cancel</b> button, the function returns the <b>IDCANCEL</b> value if
///    either the ESC key is pressed or the <b>Cancel</b> button is selected. If the message box has no <b>Cancel</b>
///    button, pressing ESC will no effect - unless an MB_OK button is present. If an MB_OK button is displayed and the
///    user presses ESC, the return value will be <b>IDOK</b>. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. If the function succeeds, the return value is one of the following
///    menu-item values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDABORT</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The <b>Abort</b> button was selected. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>IDCANCEL</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The <b>Cancel</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDCONTINUE</b></dt> <dt>11</dt> </dl> </td>
///    <td width="60%"> The <b>Continue</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDIGNORE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The <b>Ignore</b> button was selected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IDNO</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The <b>No</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDOK</b></dt> <dt>1</dt> </dl> </td> <td
///    width="60%"> The <b>OK</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDRETRY</b></dt>
///    <dt>4</dt> </dl> </td> <td width="60%"> The <b>Retry</b> button was selected. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>IDTRYAGAIN</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> The <b>Try Again</b> button was
///    selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDYES</b></dt> <dt>6</dt> </dl> </td> <td width="60%">
///    The <b>Yes</b> button was selected. </td> </tr> </table>
///    
@DllImport("USER32")
int MessageBoxA(HWND hWnd, const(PSTR) lpText, const(PSTR) lpCaption, uint uType);

///Displays a modal dialog box that contains a system icon, a set of buttons, and a brief application-specific message,
///such as status or error information. The message box returns an integer value that indicates which button the user
///clicked.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the owner window of the message box to be created. If this parameter is
///           <b>NULL</b>, the message box has no owner window.
///    lpText = Type: <b>LPCTSTR</b> The message to be displayed. If the string consists of more than one line, you can separate
///             the lines using a carriage return and/or linefeed character between each line.
///    lpCaption = Type: <b>LPCTSTR</b> The dialog box title. If this parameter is <b>NULL</b>, the default title is <b>Error</b>.
///    uType = Type: <b>UINT</b> The contents and behavior of the dialog box. This parameter can be a combination of flags from
///            the following groups of flags. To indicate the buttons displayed in the message box, specify one of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MB_ABORTRETRYIGNORE"></a><a id="mb_abortretryignore"></a><dl> <dt><b>MB_ABORTRETRYIGNORE</b></dt>
///            <dt>0x00000002L</dt> </dl> </td> <td width="60%"> The message box contains three push buttons: <b>Abort</b>,
///            <b>Retry</b>, and <b>Ignore</b>. </td> </tr> <tr> <td width="40%"><a id="MB_CANCELTRYCONTINUE"></a><a
///            id="mb_canceltrycontinue"></a><dl> <dt><b>MB_CANCELTRYCONTINUE</b></dt> <dt>0x00000006L</dt> </dl> </td> <td
///            width="60%"> The message box contains three push buttons: <b>Cancel</b>, <b>Try Again</b>, <b>Continue</b>. Use
///            this message box type instead of MB_ABORTRETRYIGNORE. </td> </tr> <tr> <td width="40%"><a id="MB_HELP"></a><a
///            id="mb_help"></a><dl> <dt><b>MB_HELP</b></dt> <dt>0x00004000L</dt> </dl> </td> <td width="60%"> Adds a
///            <b>Help</b> button to the message box. When the user clicks the <b>Help</b> button or presses F1, the system
///            sends a WM_HELP message to the owner. </td> </tr> <tr> <td width="40%"><a id="MB_OK"></a><a id="mb_ok"></a><dl>
///            <dt><b>MB_OK</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The message box contains one push button:
///            <b>OK</b>. This is the default. </td> </tr> <tr> <td width="40%"><a id="MB_OKCANCEL"></a><a
///            id="mb_okcancel"></a><dl> <dt><b>MB_OKCANCEL</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The
///            message box contains two push buttons: <b>OK</b> and <b>Cancel</b>. </td> </tr> <tr> <td width="40%"><a
///            id="MB_RETRYCANCEL"></a><a id="mb_retrycancel"></a><dl> <dt><b>MB_RETRYCANCEL</b></dt> <dt>0x00000005L</dt> </dl>
///            </td> <td width="60%"> The message box contains two push buttons: <b>Retry</b> and <b>Cancel</b>. </td> </tr>
///            <tr> <td width="40%"><a id="MB_YESNO"></a><a id="mb_yesno"></a><dl> <dt><b>MB_YESNO</b></dt> <dt>0x00000004L</dt>
///            </dl> </td> <td width="60%"> The message box contains two push buttons: <b>Yes</b> and <b>No</b>. </td> </tr>
///            <tr> <td width="40%"><a id="MB_YESNOCANCEL"></a><a id="mb_yesnocancel"></a><dl> <dt><b>MB_YESNOCANCEL</b></dt>
///            <dt>0x00000003L</dt> </dl> </td> <td width="60%"> The message box contains three push buttons: <b>Yes</b>,
///            <b>No</b>, and <b>Cancel</b>. </td> </tr> </table> To display an icon in the message box, specify one of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MB_ICONEXCLAMATION"></a><a id="mb_iconexclamation"></a><dl> <dt><b>MB_ICONEXCLAMATION</b></dt>
///            <dt>0x00000030L</dt> </dl> </td> <td width="60%"> An exclamation-point icon appears in the message box. </td>
///            </tr> <tr> <td width="40%"><a id="MB_ICONWARNING"></a><a id="mb_iconwarning"></a><dl>
///            <dt><b>MB_ICONWARNING</b></dt> <dt>0x00000030L</dt> </dl> </td> <td width="60%"> An exclamation-point icon
///            appears in the message box. </td> </tr> <tr> <td width="40%"><a id="MB_ICONINFORMATION"></a><a
///            id="mb_iconinformation"></a><dl> <dt><b>MB_ICONINFORMATION</b></dt> <dt>0x00000040L</dt> </dl> </td> <td
///            width="60%"> An icon consisting of a lowercase letter <i>i</i> in a circle appears in the message box. </td>
///            </tr> <tr> <td width="40%"><a id="MB_ICONASTERISK"></a><a id="mb_iconasterisk"></a><dl>
///            <dt><b>MB_ICONASTERISK</b></dt> <dt>0x00000040L</dt> </dl> </td> <td width="60%"> An icon consisting of a
///            lowercase letter <i>i</i> in a circle appears in the message box. </td> </tr> <tr> <td width="40%"><a
///            id="MB_ICONQUESTION"></a><a id="mb_iconquestion"></a><dl> <dt><b>MB_ICONQUESTION</b></dt> <dt>0x00000020L</dt>
///            </dl> </td> <td width="60%"> A question-mark icon appears in the message box. The question-mark message icon is
///            no longer recommended because it does not clearly represent a specific type of message and because the phrasing
///            of a message as a question could apply to any message type. In addition, users can confuse the message symbol
///            question mark with Help information. Therefore, do not use this question mark message symbol in your message
///            boxes. The system continues to support its inclusion only for backward compatibility. </td> </tr> <tr> <td
///            width="40%"><a id="MB_ICONSTOP"></a><a id="mb_iconstop"></a><dl> <dt><b>MB_ICONSTOP</b></dt> <dt>0x00000010L</dt>
///            </dl> </td> <td width="60%"> A stop-sign icon appears in the message box. </td> </tr> <tr> <td width="40%"><a
///            id="MB_ICONERROR"></a><a id="mb_iconerror"></a><dl> <dt><b>MB_ICONERROR</b></dt> <dt>0x00000010L</dt> </dl> </td>
///            <td width="60%"> A stop-sign icon appears in the message box. </td> </tr> <tr> <td width="40%"><a
///            id="MB_ICONHAND"></a><a id="mb_iconhand"></a><dl> <dt><b>MB_ICONHAND</b></dt> <dt>0x00000010L</dt> </dl> </td>
///            <td width="60%"> A stop-sign icon appears in the message box. </td> </tr> </table> To indicate the default
///            button, specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="MB_DEFBUTTON1"></a><a id="mb_defbutton1"></a><dl> <dt><b>MB_DEFBUTTON1</b></dt>
///            <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The first button is the default button. <b>MB_DEFBUTTON1</b> is
///            the default unless <b>MB_DEFBUTTON2</b>, <b>MB_DEFBUTTON3</b>, or <b>MB_DEFBUTTON4</b> is specified. </td> </tr>
///            <tr> <td width="40%"><a id="MB_DEFBUTTON2"></a><a id="mb_defbutton2"></a><dl> <dt><b>MB_DEFBUTTON2</b></dt>
///            <dt>0x00000100L</dt> </dl> </td> <td width="60%"> The second button is the default button. </td> </tr> <tr> <td
///            width="40%"><a id="MB_DEFBUTTON3"></a><a id="mb_defbutton3"></a><dl> <dt><b>MB_DEFBUTTON3</b></dt>
///            <dt>0x00000200L</dt> </dl> </td> <td width="60%"> The third button is the default button. </td> </tr> <tr> <td
///            width="40%"><a id="MB_DEFBUTTON4"></a><a id="mb_defbutton4"></a><dl> <dt><b>MB_DEFBUTTON4</b></dt>
///            <dt>0x00000300L</dt> </dl> </td> <td width="60%"> The fourth button is the default button. </td> </tr> </table>
///            To indicate the modality of the dialog box, specify one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MB_APPLMODAL"></a><a id="mb_applmodal"></a><dl>
///            <dt><b>MB_APPLMODAL</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> The user must respond to the
///            message box before continuing work in the window identified by the <i>hWnd</i> parameter. However, the user can
///            move to the windows of other threads and work in those windows. Depending on the hierarchy of windows in the
///            application, the user may be able to move to other windows within the thread. All child windows of the parent of
///            the message box are automatically disabled, but pop-up windows are not. <b>MB_APPLMODAL</b> is the default if
///            neither <b>MB_SYSTEMMODAL</b> nor <b>MB_TASKMODAL</b> is specified. </td> </tr> <tr> <td width="40%"><a
///            id="MB_SYSTEMMODAL"></a><a id="mb_systemmodal"></a><dl> <dt><b>MB_SYSTEMMODAL</b></dt> <dt>0x00001000L</dt> </dl>
///            </td> <td width="60%"> Same as MB_APPLMODAL except that the message box has the <b>WS_EX_TOPMOST</b> style. Use
///            system-modal message boxes to notify the user of serious, potentially damaging errors that require immediate
///            attention (for example, running out of memory). This flag has no effect on the user's ability to interact with
///            windows other than those associated with <i>hWnd</i>. </td> </tr> <tr> <td width="40%"><a
///            id="MB_TASKMODAL"></a><a id="mb_taskmodal"></a><dl> <dt><b>MB_TASKMODAL</b></dt> <dt>0x00002000L</dt> </dl> </td>
///            <td width="60%"> Same as <b>MB_APPLMODAL</b> except that all the top-level windows belonging to the current
///            thread are disabled if the <i>hWnd</i> parameter is <b>NULL</b>. Use this flag when the calling application or
///            library does not have a window handle available but still needs to prevent input to other windows in the calling
///            thread without suspending other threads. </td> </tr> </table> To specify other options, use one or more of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="MB_DEFAULT_DESKTOP_ONLY"></a><a id="mb_default_desktop_only"></a><dl> <dt><b>MB_DEFAULT_DESKTOP_ONLY</b></dt>
///            <dt>0x00020000L</dt> </dl> </td> <td width="60%"> Same as desktop of the interactive window station. For more
///            information, see Window Stations. If the current input desktop is not the default desktop, <b>MessageBox</b> does
///            not return until the user switches to the default desktop. </td> </tr> <tr> <td width="40%"><a
///            id="MB_RIGHT"></a><a id="mb_right"></a><dl> <dt><b>MB_RIGHT</b></dt> <dt>0x00080000L</dt> </dl> </td> <td
///            width="60%"> The text is right-justified. </td> </tr> <tr> <td width="40%"><a id="MB_RTLREADING"></a><a
///            id="mb_rtlreading"></a><dl> <dt><b>MB_RTLREADING</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%">
///            Displays message and caption text using right-to-left reading order on Hebrew and Arabic systems. </td> </tr>
///            <tr> <td width="40%"><a id="MB_SETFOREGROUND"></a><a id="mb_setforeground"></a><dl>
///            <dt><b>MB_SETFOREGROUND</b></dt> <dt>0x00010000L</dt> </dl> </td> <td width="60%"> The message box becomes the
///            foreground window. Internally, the system calls the SetForegroundWindow function for the message box. </td> </tr>
///            <tr> <td width="40%"><a id="MB_TOPMOST"></a><a id="mb_topmost"></a><dl> <dt><b>MB_TOPMOST</b></dt>
///            <dt>0x00040000L</dt> </dl> </td> <td width="60%"> The message box is created with the <b>WS_EX_TOPMOST</b> window
///            style. </td> </tr> <tr> <td width="40%"><a id="MB_SERVICE_NOTIFICATION"></a><a
///            id="mb_service_notification"></a><dl> <dt><b>MB_SERVICE_NOTIFICATION</b></dt> <dt>0x00200000L</dt> </dl> </td>
///            <td width="60%"> The caller is a service notifying the user of an event. The function displays a message box on
///            the current active desktop, even if there is no user logged on to the computer. <b>Terminal Services:</b> If the
///            calling thread has an impersonation token, the function directs the message box to the session specified in the
///            impersonation token. If this flag is set, the <i>hWnd</i> parameter must be <b>NULL</b>. This is so that the
///            message box can appear on a desktop other than the desktop corresponding to the <i>hWnd</i>. For information on
///            security considerations in regard to using this flag, see Interactive Services. In particular, be aware that this
///            flag can produce interactive content on a locked desktop and should therefore be used for only a very limited set
///            of scenarios, such as resource exhaustion. </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If a message box has a <b>Cancel</b> button, the function returns the <b>IDCANCEL</b> value if
///    either the ESC key is pressed or the <b>Cancel</b> button is selected. If the message box has no <b>Cancel</b>
///    button, pressing ESC will no effect - unless an MB_OK button is present. If an MB_OK button is displayed and the
///    user presses ESC, the return value will be <b>IDOK</b>. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. If the function succeeds, the return value is one of the following
///    menu-item values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDABORT</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The <b>Abort</b> button was selected. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>IDCANCEL</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The <b>Cancel</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDCONTINUE</b></dt> <dt>11</dt> </dl> </td>
///    <td width="60%"> The <b>Continue</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDIGNORE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The <b>Ignore</b> button was selected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IDNO</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The <b>No</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDOK</b></dt> <dt>1</dt> </dl> </td> <td
///    width="60%"> The <b>OK</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDRETRY</b></dt>
///    <dt>4</dt> </dl> </td> <td width="60%"> The <b>Retry</b> button was selected. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>IDTRYAGAIN</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> The <b>Try Again</b> button was
///    selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDYES</b></dt> <dt>6</dt> </dl> </td> <td width="60%">
///    The <b>Yes</b> button was selected. </td> </tr> </table>
///    
@DllImport("USER32")
int MessageBoxW(HWND hWnd, const(PWSTR) lpText, const(PWSTR) lpCaption, uint uType);

///Creates, displays, and operates a message box. The message box contains an application-defined message and title,
///plus any combination of predefined icons and push buttons. The buttons are in the language of the system user
///interface. Currently <b>MessageBoxEx</b> and MessageBox work the same way.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the owner window of the message box to be created. If this parameter is
///           <b>NULL</b>, the message box has no owner window.
///    lpText = Type: <b>LPCTSTR</b> The message to be displayed.
///    lpCaption = Type: <b>LPCTSTR</b> The dialog box title. If this parameter is <b>NULL</b>, the default title <b>Error</b> is
///                used.
///    uType = Type: <b>UINT</b> The contents and behavior of the dialog box. For information on the supported flags, see
///            MessageBox.
///    wLanguageId = Type: <b>WORD</b> The language for the text displayed in the message box button(s). Specifying a value of zero
///                  (0) indicates to display the button text in the default system language. If this parameter is
///                  <code>MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL)</code>, the current language associated with the calling thread
///                  is used. To specify a language other than the current language, use the MAKELANGID macro to create this
///                  parameter. For more information, see <b>MAKELANGID</b>.
///Returns:
///    Type: <b>int</b> If a message box has a <b>Cancel</b> button, the function returns the <b>IDCANCEL</b> value if
///    either the ESC key is pressed or the <b>Cancel</b> button is selected. If the message box has no <b>Cancel</b>
///    button, pressing ESC will no effect - unless an MB_OK button is present. If an MB_OK button is displayed and the
///    user presses ESC, the return value will be <b>IDOK</b>. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. If the function succeeds, the return value is one of the following
///    menu-item values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDABORT</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The <b>Abort</b> button was selected. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>IDCANCEL</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The <b>Cancel</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDCONTINUE</b></dt> <dt>11</dt> </dl> </td>
///    <td width="60%"> The <b>Continue</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDIGNORE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The <b>Ignore</b> button was selected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IDNO</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The <b>No</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDOK</b></dt> <dt>1</dt> </dl> </td> <td
///    width="60%"> The <b>OK</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDRETRY</b></dt>
///    <dt>4</dt> </dl> </td> <td width="60%"> The <b>Retry</b> button was selected. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>IDTRYAGAIN</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> The <b>Try Again</b> button was
///    selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDYES</b></dt> <dt>6</dt> </dl> </td> <td width="60%">
///    The <b>Yes</b> button was selected. </td> </tr> </table>
///    
@DllImport("USER32")
int MessageBoxExA(HWND hWnd, const(PSTR) lpText, const(PSTR) lpCaption, uint uType, ushort wLanguageId);

///Creates, displays, and operates a message box. The message box contains an application-defined message and title,
///plus any combination of predefined icons and push buttons. The buttons are in the language of the system user
///interface. Currently <b>MessageBoxEx</b> and MessageBox work the same way.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the owner window of the message box to be created. If this parameter is
///           <b>NULL</b>, the message box has no owner window.
///    lpText = Type: <b>LPCTSTR</b> The message to be displayed.
///    lpCaption = Type: <b>LPCTSTR</b> The dialog box title. If this parameter is <b>NULL</b>, the default title <b>Error</b> is
///                used.
///    uType = Type: <b>UINT</b> The contents and behavior of the dialog box. For information on the supported flags, see
///            MessageBox.
///    wLanguageId = Type: <b>WORD</b> The language for the text displayed in the message box button(s). Specifying a value of zero
///                  (0) indicates to display the button text in the default system language. If this parameter is
///                  <code>MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL)</code>, the current language associated with the calling thread
///                  is used. To specify a language other than the current language, use the MAKELANGID macro to create this
///                  parameter. For more information, see <b>MAKELANGID</b>.
///Returns:
///    Type: <b>int</b> If a message box has a <b>Cancel</b> button, the function returns the <b>IDCANCEL</b> value if
///    either the ESC key is pressed or the <b>Cancel</b> button is selected. If the message box has no <b>Cancel</b>
///    button, pressing ESC will no effect - unless an MB_OK button is present. If an MB_OK button is displayed and the
///    user presses ESC, the return value will be <b>IDOK</b>. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. If the function succeeds, the return value is one of the following
///    menu-item values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDABORT</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The <b>Abort</b> button was selected. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>IDCANCEL</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The <b>Cancel</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDCONTINUE</b></dt> <dt>11</dt> </dl> </td>
///    <td width="60%"> The <b>Continue</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDIGNORE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The <b>Ignore</b> button was selected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IDNO</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The <b>No</b>
///    button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDOK</b></dt> <dt>1</dt> </dl> </td> <td
///    width="60%"> The <b>OK</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDRETRY</b></dt>
///    <dt>4</dt> </dl> </td> <td width="60%"> The <b>Retry</b> button was selected. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>IDTRYAGAIN</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> The <b>Try Again</b> button was
///    selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDYES</b></dt> <dt>6</dt> </dl> </td> <td width="60%">
///    The <b>Yes</b> button was selected. </td> </tr> </table>
///    
@DllImport("USER32")
int MessageBoxExW(HWND hWnd, const(PWSTR) lpText, const(PWSTR) lpCaption, uint uType, ushort wLanguageId);

///Creates, displays, and operates a message box. The message box contains application-defined message text and title,
///any icon, and any combination of predefined push buttons.
///Params:
///    lpmbp = Type: <b>const LPMSGBOXPARAMS</b> A pointer to a MSGBOXPARAMS structure that contains information used to display
///            the message box.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is one of the following menu-item values. If a
///    message box has a <b>Cancel</b> button, the function returns the <b>IDCANCEL</b> value if either the ESC key is
///    pressed or the <b>Cancel</b> button is selected. If the message box has no <b>Cancel</b> button, pressing ESC has
///    no effect. If there is not enough memory to create the message box, the return value is zero. <table> <tr>
///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>IDABORT</b></dt>
///    <dt>3</dt> </dl> </td> <td width="60%"> The <b>Abort</b> button was selected. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>IDCANCEL</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The <b>Cancel</b> button was selected.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDCONTINUE</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> The
///    <b>Continue</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDIGNORE</b></dt> <dt>5</dt>
///    </dl> </td> <td width="60%"> The <b>Ignore</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDNO</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The <b>No</b> button was selected. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>IDOK</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The <b>OK</b> button was
///    selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDRETRY</b></dt> <dt>4</dt> </dl> </td> <td width="60%">
///    The <b>Retry</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDTRYAGAIN</b></dt>
///    <dt>10</dt> </dl> </td> <td width="60%"> The <b>Try Again</b> button was selected. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>IDYES</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The <b>Yes</b> button was
///    selected. </td> </tr> </table>
///    
@DllImport("USER32")
int MessageBoxIndirectA(const(MSGBOXPARAMSA)* lpmbp);

///Creates, displays, and operates a message box. The message box contains application-defined message text and title,
///any icon, and any combination of predefined push buttons.
///Params:
///    lpmbp = Type: <b>const LPMSGBOXPARAMS</b> A pointer to a MSGBOXPARAMS structure that contains information used to display
///            the message box.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is one of the following menu-item values. If a
///    message box has a <b>Cancel</b> button, the function returns the <b>IDCANCEL</b> value if either the ESC key is
///    pressed or the <b>Cancel</b> button is selected. If the message box has no <b>Cancel</b> button, pressing ESC has
///    no effect. If there is not enough memory to create the message box, the return value is zero. <table> <tr>
///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>IDABORT</b></dt>
///    <dt>3</dt> </dl> </td> <td width="60%"> The <b>Abort</b> button was selected. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>IDCANCEL</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The <b>Cancel</b> button was selected.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDCONTINUE</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> The
///    <b>Continue</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDIGNORE</b></dt> <dt>5</dt>
///    </dl> </td> <td width="60%"> The <b>Ignore</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IDNO</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The <b>No</b> button was selected. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>IDOK</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The <b>OK</b> button was
///    selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDRETRY</b></dt> <dt>4</dt> </dl> </td> <td width="60%">
///    The <b>Retry</b> button was selected. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IDTRYAGAIN</b></dt>
///    <dt>10</dt> </dl> </td> <td width="60%"> The <b>Try Again</b> button was selected. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>IDYES</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The <b>Yes</b> button was
///    selected. </td> </tr> </table>
///    
@DllImport("USER32")
int MessageBoxIndirectW(const(MSGBOXPARAMSW)* lpmbp);

///Converts the logical coordinates of a point in a window to physical coordinates.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose transform is used for the conversion. Top level windows are fully
///           supported. In the case of child windows, only the area of overlap between the parent and the child window is
///           converted.
///    lpPoint = Type: <b>LPPOINT</b> A pointer to a POINT structure that specifies the logical coordinates to be converted. The
///              new physical coordinates are copied into this structure if the function succeeds.
@DllImport("USER32")
BOOL LogicalToPhysicalPoint(HWND hWnd, POINT* lpPoint);

///Converts the physical coordinates of a point in a window to logical coordinates.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose transform is used for the conversion. Top level windows are fully
///           supported. In the case of child windows, only the area of overlap between the parent and the child window is
///           converted.
///    lpPoint = Type: <b>LPPOINT</b> A pointer to a POINT structure that specifies the physical/screen coordinates to be
///              converted. The new logical coordinates are copied into this structure if the function succeeds.
@DllImport("USER32")
BOOL PhysicalToLogicalPoint(HWND hWnd, POINT* lpPoint);

///Retrieves a handle to the window that contains the specified point.
///Params:
///    Point = Type: <b>POINT</b> The point to be checked.
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the window that contains the point. If no window exists at the
///    given point, the return value is <b>NULL</b>. If the point is over a static text control, the return value is a
///    handle to the window under the static text control.
///    
@DllImport("USER32")
HWND WindowFromPoint(POINT Point);

///Retrieves a handle to the window that contains the specified physical point.
///Params:
///    Point = Type: <b>POINT</b> The physical coordinates of the point.
///Returns:
///    Type: <b>HWND</b> A handle to the window that contains the given physical point. If no window exists at the
///    point, this value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND WindowFromPhysicalPoint(POINT Point);

///Determines which, if any, of the child windows belonging to a parent window contains the specified point. The search
///is restricted to immediate child windows. Grandchildren, and deeper descendant windows are not searched. To skip
///certain child windows, use the ChildWindowFromPointEx function.
///Params:
///    hWndParent = Type: <b>HWND</b> A handle to the parent window.
///    Point = Type: <b>POINT</b> A structure that defines the client coordinates, relative to <i>hWndParent</i>, of the point
///            to be checked.
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the child window that contains the point, even if the child
///    window is hidden or disabled. If the point lies outside the parent window, the return value is <b>NULL</b>. If
///    the point is within the parent window but not within any child window, the return value is a handle to the parent
///    window.
///    
@DllImport("USER32")
HWND ChildWindowFromPoint(HWND hWndParent, POINT Point);

///Determines which, if any, of the child windows belonging to the specified parent window contains the specified point.
///The function can ignore invisible, disabled, and transparent child windows. The search is restricted to immediate
///child windows. Grandchildren and deeper descendants are not searched.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the parent window.
///    pt = Type: <b>POINT</b> A structure that defines the client coordinates (relative to <i>hwndParent</i>) of the point
///         to be checked.
///    flags = Type: <b>UINT</b> The child windows to be skipped. This parameter can be one or more of the following values.
///            <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CWP_ALL"></a><a
///            id="cwp_all"></a><dl> <dt><b>CWP_ALL</b></dt> <dt>0x0000</dt> </dl> </td> <td width="60%"> Does not skip any
///            child windows </td> </tr> <tr> <td width="40%"><a id="CWP_SKIPDISABLED"></a><a id="cwp_skipdisabled"></a><dl>
///            <dt><b>CWP_SKIPDISABLED</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Skips disabled child windows </td>
///            </tr> <tr> <td width="40%"><a id="CWP_SKIPINVISIBLE"></a><a id="cwp_skipinvisible"></a><dl>
///            <dt><b>CWP_SKIPINVISIBLE</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Skips invisible child windows
///            </td> </tr> <tr> <td width="40%"><a id="CWP_SKIPTRANSPARENT"></a><a id="cwp_skiptransparent"></a><dl>
///            <dt><b>CWP_SKIPTRANSPARENT</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> Skips transparent child windows
///            </td> </tr> </table>
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the first child window that contains the point and meets the
///    criteria specified by <i>uFlags</i>. If the point is within the parent window but not within any child window
///    that meets the criteria, the return value is a handle to the parent window. If the point lies outside the parent
///    window or if the function fails, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND ChildWindowFromPointEx(HWND hwnd, POINT pt, uint flags);

///Retrieves the current color of the specified display element. Display elements are the parts of a window and the
///display that appear on the system display screen.
///Params:
///    nIndex = Type: <b>int</b> The display element whose color is to be retrieved. This parameter can be one of the following
///             values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="COLOR_3DDKSHADOW"></a><a
///             id="color_3ddkshadow"></a><dl> <dt><b>COLOR_3DDKSHADOW</b></dt> <dt>21</dt> </dl> </td> <td width="60%"> Dark
///             shadow for three-dimensional display elements. </td> </tr> <tr> <td width="40%"><a id="COLOR_3DFACE"></a><a
///             id="color_3dface"></a><dl> <dt><b>COLOR_3DFACE</b></dt> <dt>15</dt> </dl> </td> <td width="60%"> Face color for
///             three-dimensional display elements and for dialog box backgrounds. </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_3DHIGHLIGHT"></a><a id="color_3dhighlight"></a><dl> <dt><b>COLOR_3DHIGHLIGHT</b></dt> <dt>20</dt> </dl>
///             </td> <td width="60%"> Highlight color for three-dimensional display elements (for edges facing the light
///             source.) </td> </tr> <tr> <td width="40%"><a id="COLOR_3DHILIGHT"></a><a id="color_3dhilight"></a><dl>
///             <dt><b>COLOR_3DHILIGHT</b></dt> <dt>20</dt> </dl> </td> <td width="60%"> Highlight color for three-dimensional
///             display elements (for edges facing the light source.) </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_3DLIGHT"></a><a id="color_3dlight"></a><dl> <dt><b>COLOR_3DLIGHT</b></dt> <dt>22</dt> </dl> </td> <td
///             width="60%"> Light color for three-dimensional display elements (for edges facing the light source.) </td> </tr>
///             <tr> <td width="40%"><a id="COLOR_3DSHADOW"></a><a id="color_3dshadow"></a><dl> <dt><b>COLOR_3DSHADOW</b></dt>
///             <dt>16</dt> </dl> </td> <td width="60%"> Shadow color for three-dimensional display elements (for edges facing
///             away from the light source). </td> </tr> <tr> <td width="40%"><a id="COLOR_ACTIVEBORDER"></a><a
///             id="color_activeborder"></a><dl> <dt><b>COLOR_ACTIVEBORDER</b></dt> <dt>10</dt> </dl> </td> <td width="60%">
///             Active window border. </td> </tr> <tr> <td width="40%"><a id="COLOR_ACTIVECAPTION"></a><a
///             id="color_activecaption"></a><dl> <dt><b>COLOR_ACTIVECAPTION</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
///             Active window title bar. The associated foreground color is <b>COLOR_CAPTIONTEXT</b>. Specifies the left side
///             color in the color gradient of an active window's title bar if the gradient effect is enabled. </td> </tr> <tr>
///             <td width="40%"><a id="COLOR_APPWORKSPACE"></a><a id="color_appworkspace"></a><dl>
///             <dt><b>COLOR_APPWORKSPACE</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> Background color of multiple document
///             interface (MDI) applications. </td> </tr> <tr> <td width="40%"><a id="COLOR_BACKGROUND"></a><a
///             id="color_background"></a><dl> <dt><b>COLOR_BACKGROUND</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Desktop.
///             </td> </tr> <tr> <td width="40%"><a id="COLOR_BTNFACE"></a><a id="color_btnface"></a><dl>
///             <dt><b>COLOR_BTNFACE</b></dt> <dt>15</dt> </dl> </td> <td width="60%"> Face color for three-dimensional display
///             elements and for dialog box backgrounds. The associated foreground color is <b>COLOR_BTNTEXT</b>. </td> </tr>
///             <tr> <td width="40%"><a id="_COLOR_BTNHIGHLIGHT"></a><a id="_color_btnhighlight"></a><dl> <dt><b>
///             COLOR_BTNHIGHLIGHT</b></dt> <dt>20</dt> </dl> </td> <td width="60%"> Highlight color for three-dimensional
///             display elements (for edges facing the light source.) </td> </tr> <tr> <td width="40%"><a
///             id="_COLOR_BTNHILIGHT"></a><a id="_color_btnhilight"></a><dl> <dt><b> COLOR_BTNHILIGHT</b></dt> <dt>20</dt> </dl>
///             </td> <td width="60%"> Highlight color for three-dimensional display elements (for edges facing the light
///             source.) </td> </tr> <tr> <td width="40%"><a id="COLOR_BTNSHADOW"></a><a id="color_btnshadow"></a><dl>
///             <dt><b>COLOR_BTNSHADOW</b></dt> <dt>16</dt> </dl> </td> <td width="60%"> Shadow color for three-dimensional
///             display elements (for edges facing away from the light source). </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_BTNTEXT"></a><a id="color_btntext"></a><dl> <dt><b>COLOR_BTNTEXT</b></dt> <dt>18</dt> </dl> </td> <td
///             width="60%"> Text on push buttons. The associated background color is COLOR_BTNFACE. </td> </tr> <tr> <td
///             width="40%"><a id="COLOR_CAPTIONTEXT"></a><a id="color_captiontext"></a><dl> <dt><b>COLOR_CAPTIONTEXT</b></dt>
///             <dt>9</dt> </dl> </td> <td width="60%"> Text in caption, size box, and scroll bar arrow box. The associated
///             background color is COLOR_ACTIVECAPTION. </td> </tr> <tr> <td width="40%"><a id="COLOR_DESKTOP"></a><a
///             id="color_desktop"></a><dl> <dt><b>COLOR_DESKTOP</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Desktop. </td>
///             </tr> <tr> <td width="40%"><a id="COLOR_GRADIENTACTIVECAPTION"></a><a id="color_gradientactivecaption"></a><dl>
///             <dt><b>COLOR_GRADIENTACTIVECAPTION</b></dt> <dt>27</dt> </dl> </td> <td width="60%"> Right side color in the
///             color gradient of an active window's title bar. COLOR_ACTIVECAPTION specifies the left side color. Use
///             SPI_GETGRADIENTCAPTIONS with the SystemParametersInfo function to determine whether the gradient effect is
///             enabled. </td> </tr> <tr> <td width="40%"><a id="COLOR_GRADIENTINACTIVECAPTION"></a><a
///             id="color_gradientinactivecaption"></a><dl> <dt><b>COLOR_GRADIENTINACTIVECAPTION</b></dt> <dt>28</dt> </dl> </td>
///             <td width="60%"> Right side color in the color gradient of an inactive window's title bar. COLOR_INACTIVECAPTION
///             specifies the left side color. </td> </tr> <tr> <td width="40%"><a id="COLOR_GRAYTEXT"></a><a
///             id="color_graytext"></a><dl> <dt><b>COLOR_GRAYTEXT</b></dt> <dt>17</dt> </dl> </td> <td width="60%"> Grayed
///             (disabled) text. This color is set to 0 if the current display driver does not support a solid gray color. </td>
///             </tr> <tr> <td width="40%"><a id="COLOR_HIGHLIGHT"></a><a id="color_highlight"></a><dl>
///             <dt><b>COLOR_HIGHLIGHT</b></dt> <dt>13</dt> </dl> </td> <td width="60%"> Item(s) selected in a control. The
///             associated foreground color is COLOR_HIGHLIGHTTEXT. </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_HIGHLIGHTTEXT"></a><a id="color_highlighttext"></a><dl> <dt><b>COLOR_HIGHLIGHTTEXT</b></dt> <dt>14</dt>
///             </dl> </td> <td width="60%"> Text of item(s) selected in a control. The associated background color is
///             COLOR_HIGHLIGHT. </td> </tr> <tr> <td width="40%"><a id="COLOR_HOTLIGHT"></a><a id="color_hotlight"></a><dl>
///             <dt><b>COLOR_HOTLIGHT</b></dt> <dt>26</dt> </dl> </td> <td width="60%"> Color for a hyperlink or hot-tracked
///             item. The associated background color is COLOR_WINDOW. </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_INACTIVEBORDER"></a><a id="color_inactiveborder"></a><dl> <dt><b>COLOR_INACTIVEBORDER</b></dt>
///             <dt>11</dt> </dl> </td> <td width="60%"> Inactive window border. </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_INACTIVECAPTION"></a><a id="color_inactivecaption"></a><dl> <dt><b>COLOR_INACTIVECAPTION</b></dt>
///             <dt>3</dt> </dl> </td> <td width="60%"> Inactive window caption. The associated foreground color is
///             COLOR_INACTIVECAPTIONTEXT. Specifies the left side color in the color gradient of an inactive window's title bar
///             if the gradient effect is enabled. </td> </tr> <tr> <td width="40%"><a id="COLOR_INACTIVECAPTIONTEXT"></a><a
///             id="color_inactivecaptiontext"></a><dl> <dt><b>COLOR_INACTIVECAPTIONTEXT</b></dt> <dt>19</dt> </dl> </td> <td
///             width="60%"> Color of text in an inactive caption. The associated background color is COLOR_INACTIVECAPTION.
///             </td> </tr> <tr> <td width="40%"><a id="COLOR_INFOBK"></a><a id="color_infobk"></a><dl>
///             <dt><b>COLOR_INFOBK</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> Background color for tooltip controls. The
///             associated foreground color is COLOR_INFOTEXT. </td> </tr> <tr> <td width="40%"><a id="COLOR_INFOTEXT"></a><a
///             id="color_infotext"></a><dl> <dt><b>COLOR_INFOTEXT</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> Text color
///             for tooltip controls. The associated background color is COLOR_INFOBK. </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_MENU"></a><a id="color_menu"></a><dl> <dt><b>COLOR_MENU</b></dt> <dt>4</dt> </dl> </td> <td
///             width="60%"> Menu background. The associated foreground color is COLOR_MENUTEXT. </td> </tr> <tr> <td
///             width="40%"><a id="COLOR_MENUHILIGHT"></a><a id="color_menuhilight"></a><dl> <dt><b>COLOR_MENUHILIGHT</b></dt>
///             <dt>29</dt> </dl> </td> <td width="60%"> The color used to highlight menu items when the menu appears as a flat
///             menu (see SystemParametersInfo). The highlighted menu item is outlined with COLOR_HIGHLIGHT. <b>Windows 2000:
///             </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="COLOR_MENUBAR"></a><a
///             id="color_menubar"></a><dl> <dt><b>COLOR_MENUBAR</b></dt> <dt>30</dt> </dl> </td> <td width="60%"> The background
///             color for the menu bar when menus appear as flat menus (see SystemParametersInfo). However, COLOR_MENU continues
///             to specify the background color of the menu popup. <b>Windows 2000: </b>This value is not supported. </td> </tr>
///             <tr> <td width="40%"><a id="COLOR_MENUTEXT"></a><a id="color_menutext"></a><dl> <dt><b>COLOR_MENUTEXT</b></dt>
///             <dt>7</dt> </dl> </td> <td width="60%"> Text in menus. The associated background color is COLOR_MENU. </td> </tr>
///             <tr> <td width="40%"><a id="COLOR_SCROLLBAR"></a><a id="color_scrollbar"></a><dl> <dt><b>COLOR_SCROLLBAR</b></dt>
///             <dt>0</dt> </dl> </td> <td width="60%"> Scroll bar gray area. </td> </tr> <tr> <td width="40%"><a
///             id="COLOR_WINDOW"></a><a id="color_window"></a><dl> <dt><b>COLOR_WINDOW</b></dt> <dt>5</dt> </dl> </td> <td
///             width="60%"> Window background. The associated foreground colors are COLOR_WINDOWTEXT and COLOR_HOTLITE. </td>
///             </tr> <tr> <td width="40%"><a id="COLOR_WINDOWFRAME"></a><a id="color_windowframe"></a><dl>
///             <dt><b>COLOR_WINDOWFRAME</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> Window frame. </td> </tr> <tr> <td
///             width="40%"><a id="COLOR_WINDOWTEXT"></a><a id="color_windowtext"></a><dl> <dt><b>COLOR_WINDOWTEXT</b></dt>
///             <dt>8</dt> </dl> </td> <td width="60%"> Text in windows. The associated background color is COLOR_WINDOW. </td>
///             </tr> </table>
///Returns:
///    Type: <b>DWORD</b> The function returns the red, green, blue (RGB) color value of the given element. If the
///    <i>nIndex</i> parameter is out of range, the return value is zero. Because zero is also a valid RGB value, you
///    cannot use <b>GetSysColor</b> to determine whether a system color is supported by the current platform. Instead,
///    use the GetSysColorBrush function, which returns <b>NULL</b> if the color is not supported.
///    
@DllImport("USER32")
uint GetSysColor(int nIndex);

///Sets the colors for the specified display elements. Display elements are the various parts of a window and the
///display that appear on the system display screen.
///Params:
///    cElements = Type: <b>int</b> The number of display elements in the <i>lpaElements</i> array.
///    lpaElements = Type: <b>const INT*</b> An array of integers that specify the display elements to be changed. For a list of
///                  display elements, see GetSysColor.
///    lpaRgbValues = Type: <b>const COLORREF*</b> An array of COLORREF values that contain the new red, green, blue (RGB) color values
///                   for the display elements in the array pointed to by the <i>lpaElements</i> parameter. To generate a COLORREF, use
///                   the RGB macro.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is a nonzero value. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetSysColors(int cElements, const(int)* lpaElements, const(uint)* lpaRgbValues);

///Retrieves information about the specified window. The function also retrieves the 32-bit (<b>DWORD</b>) value at the
///specified offset into the extra window memory. <div class="alert"><b>Note</b> If you are retrieving a pointer or a
///handle, this function has been superseded by the GetWindowLongPtr function. (Pointers and handles are 32 bits on
///32-bit Windows and 64 bits on 64-bit Windows.) To write code that is compatible with both 32-bit and 64-bit versions
///of Windows, use <b>GetWindowLongPtr</b>.</div> <div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The zero-based offset to the value to be retrieved. Valid values are in the range zero through
///             the number of bytes of extra window memory, minus four; for example, if you specified 12 or more bytes of extra
///             memory, a value of 8 would be an index to the third 32-bit integer. To retrieve any other value, specify one of
///             the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="GWL_EXSTYLE"></a><a id="gwl_exstyle"></a><dl> <dt><b>GWL_EXSTYLE</b></dt> <dt>-20</dt> </dl> </td> <td
///             width="60%"> Retrieves the extended window styles. </td> </tr> <tr> <td width="40%"><a id="GWL_HINSTANCE"></a><a
///             id="gwl_hinstance"></a><dl> <dt><b>GWL_HINSTANCE</b></dt> <dt>-6</dt> </dl> </td> <td width="60%"> Retrieves a
///             handle to the application instance. </td> </tr> <tr> <td width="40%"><a id="GWL_HWNDPARENT"></a><a
///             id="gwl_hwndparent"></a><dl> <dt><b>GWL_HWNDPARENT</b></dt> <dt>-8</dt> </dl> </td> <td width="60%"> Retrieves a
///             handle to the parent window, if any. </td> </tr> <tr> <td width="40%"><a id="GWL_ID"></a><a id="gwl_id"></a><dl>
///             <dt><b>GWL_ID</b></dt> <dt>-12</dt> </dl> </td> <td width="60%"> Retrieves the identifier of the window. </td>
///             </tr> <tr> <td width="40%"><a id="GWL_STYLE"></a><a id="gwl_style"></a><dl> <dt><b>GWL_STYLE</b></dt>
///             <dt>-16</dt> </dl> </td> <td width="60%"> Retrieves the window styles. </td> </tr> <tr> <td width="40%"><a
///             id="GWL_USERDATA"></a><a id="gwl_userdata"></a><dl> <dt><b>GWL_USERDATA</b></dt> <dt>-21</dt> </dl> </td> <td
///             width="60%"> Retrieves the user data associated with the window. This data is intended for use by the application
///             that created the window. Its value is initially zero. </td> </tr> <tr> <td width="40%"><a id="GWL_WNDPROC"></a><a
///             id="gwl_wndproc"></a><dl> <dt><b>GWL_WNDPROC</b></dt> <dt>-4</dt> </dl> </td> <td width="60%"> Retrieves the
///             address of the window procedure, or a handle representing the address of the window procedure. You must use the
///             CallWindowProc function to call the window procedure. </td> </tr> </table> The following values are also
///             available when the <i>hWnd</i> parameter identifies a dialog box. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="DWL_DLGPROC"></a><a id="dwl_dlgproc"></a><dl> <dt><b>DWL_DLGPROC</b></dt>
///             <dt>DWLP_MSGRESULT + sizeof(LRESULT)</dt> </dl> </td> <td width="60%"> Retrieves the address of the dialog box
///             procedure, or a handle representing the address of the dialog box procedure. You must use the CallWindowProc
///             function to call the dialog box procedure. </td> </tr> <tr> <td width="40%"><a id="DWL_MSGRESULT"></a><a
///             id="dwl_msgresult"></a><dl> <dt><b>DWL_MSGRESULT</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Retrieves the
///             return value of a message processed in the dialog box procedure. </td> </tr> <tr> <td width="40%"><a
///             id="DWL_USER"></a><a id="dwl_user"></a><dl> <dt><b>DWL_USER</b></dt> <dt>DWLP_DLGPROC + sizeof(DLGPROC)</dt>
///             </dl> </td> <td width="60%"> Retrieves extra information private to the application, such as handles or pointers.
///             </td> </tr> </table>
///Returns:
///    Type: <b>LONG</b> If the function succeeds, the return value is the requested value. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError. If SetWindowLong has not been called
///    previously, <b>GetWindowLong</b> returns zero for values in the extra window or class memory.
///    
@DllImport("USER32")
int GetWindowLongA(HWND hWnd, int nIndex);

///Retrieves information about the specified window. The function also retrieves the 32-bit (<b>DWORD</b>) value at the
///specified offset into the extra window memory. <div class="alert"><b>Note</b> If you are retrieving a pointer or a
///handle, this function has been superseded by the GetWindowLongPtr function. (Pointers and handles are 32 bits on
///32-bit Windows and 64 bits on 64-bit Windows.) To write code that is compatible with both 32-bit and 64-bit versions
///of Windows, use <b>GetWindowLongPtr</b>.</div> <div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The zero-based offset to the value to be retrieved. Valid values are in the range zero through
///             the number of bytes of extra window memory, minus four; for example, if you specified 12 or more bytes of extra
///             memory, a value of 8 would be an index to the third 32-bit integer. To retrieve any other value, specify one of
///             the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="GWL_EXSTYLE"></a><a id="gwl_exstyle"></a><dl> <dt><b>GWL_EXSTYLE</b></dt> <dt>-20</dt> </dl> </td> <td
///             width="60%"> Retrieves the extended window styles. </td> </tr> <tr> <td width="40%"><a id="GWL_HINSTANCE"></a><a
///             id="gwl_hinstance"></a><dl> <dt><b>GWL_HINSTANCE</b></dt> <dt>-6</dt> </dl> </td> <td width="60%"> Retrieves a
///             handle to the application instance. </td> </tr> <tr> <td width="40%"><a id="GWL_HWNDPARENT"></a><a
///             id="gwl_hwndparent"></a><dl> <dt><b>GWL_HWNDPARENT</b></dt> <dt>-8</dt> </dl> </td> <td width="60%"> Retrieves a
///             handle to the parent window, if any. </td> </tr> <tr> <td width="40%"><a id="GWL_ID"></a><a id="gwl_id"></a><dl>
///             <dt><b>GWL_ID</b></dt> <dt>-12</dt> </dl> </td> <td width="60%"> Retrieves the identifier of the window. </td>
///             </tr> <tr> <td width="40%"><a id="GWL_STYLE"></a><a id="gwl_style"></a><dl> <dt><b>GWL_STYLE</b></dt>
///             <dt>-16</dt> </dl> </td> <td width="60%"> Retrieves the window styles. </td> </tr> <tr> <td width="40%"><a
///             id="GWL_USERDATA"></a><a id="gwl_userdata"></a><dl> <dt><b>GWL_USERDATA</b></dt> <dt>-21</dt> </dl> </td> <td
///             width="60%"> Retrieves the user data associated with the window. This data is intended for use by the application
///             that created the window. Its value is initially zero. </td> </tr> <tr> <td width="40%"><a id="GWL_WNDPROC"></a><a
///             id="gwl_wndproc"></a><dl> <dt><b>GWL_WNDPROC</b></dt> <dt>-4</dt> </dl> </td> <td width="60%"> Retrieves the
///             address of the window procedure, or a handle representing the address of the window procedure. You must use the
///             CallWindowProc function to call the window procedure. </td> </tr> </table> The following values are also
///             available when the <i>hWnd</i> parameter identifies a dialog box. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="DWL_DLGPROC"></a><a id="dwl_dlgproc"></a><dl> <dt><b>DWL_DLGPROC</b></dt>
///             <dt>DWLP_MSGRESULT + sizeof(LRESULT)</dt> </dl> </td> <td width="60%"> Retrieves the address of the dialog box
///             procedure, or a handle representing the address of the dialog box procedure. You must use the CallWindowProc
///             function to call the dialog box procedure. </td> </tr> <tr> <td width="40%"><a id="DWL_MSGRESULT"></a><a
///             id="dwl_msgresult"></a><dl> <dt><b>DWL_MSGRESULT</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Retrieves the
///             return value of a message processed in the dialog box procedure. </td> </tr> <tr> <td width="40%"><a
///             id="DWL_USER"></a><a id="dwl_user"></a><dl> <dt><b>DWL_USER</b></dt> <dt>DWLP_DLGPROC + sizeof(DLGPROC)</dt>
///             </dl> </td> <td width="60%"> Retrieves extra information private to the application, such as handles or pointers.
///             </td> </tr> </table>
///Returns:
///    Type: <b>LONG</b> If the function succeeds, the return value is the requested value. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError. If SetWindowLong has not been called
///    previously, <b>GetWindowLong</b> returns zero for values in the extra window or class memory.
///    
@DllImport("USER32")
int GetWindowLongW(HWND hWnd, int nIndex);

///Changes an attribute of the specified window. The function also sets the 32-bit (long) value at the specified offset
///into the extra window memory. <div class="alert"><b>Note</b> This function has been superseded by the
///SetWindowLongPtr function. To write code that is compatible with both 32-bit and 64-bit versions of Windows, use the
///<b>SetWindowLongPtr</b> function.</div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The zero-based offset to the value to be set. Valid values are in the range zero through the
///             number of bytes of extra window memory, minus the size of an integer. To set any other value, specify one of the
///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="GWL_EXSTYLE"></a><a id="gwl_exstyle"></a><dl> <dt><b>GWL_EXSTYLE</b></dt> <dt>-20</dt> </dl> </td> <td
///             width="60%"> Sets a new extended window style. </td> </tr> <tr> <td width="40%"><a id="GWL_HINSTANCE"></a><a
///             id="gwl_hinstance"></a><dl> <dt><b>GWL_HINSTANCE</b></dt> <dt>-6</dt> </dl> </td> <td width="60%"> Sets a new
///             application instance handle. </td> </tr> <tr> <td width="40%"><a id="GWL_ID"></a><a id="gwl_id"></a><dl>
///             <dt><b>GWL_ID</b></dt> <dt>-12</dt> </dl> </td> <td width="60%"> Sets a new identifier of the child window. The
///             window cannot be a top-level window. </td> </tr> <tr> <td width="40%"><a id="GWL_STYLE"></a><a
///             id="gwl_style"></a><dl> <dt><b>GWL_STYLE</b></dt> <dt>-16</dt> </dl> </td> <td width="60%"> Sets a new window
///             style. </td> </tr> <tr> <td width="40%"><a id="GWL_USERDATA"></a><a id="gwl_userdata"></a><dl>
///             <dt><b>GWL_USERDATA</b></dt> <dt>-21</dt> </dl> </td> <td width="60%"> Sets the user data associated with the
///             window. This data is intended for use by the application that created the window. Its value is initially zero.
///             </td> </tr> <tr> <td width="40%"><a id="GWL_WNDPROC"></a><a id="gwl_wndproc"></a><dl> <dt><b>GWL_WNDPROC</b></dt>
///             <dt>-4</dt> </dl> </td> <td width="60%"> Sets a new address for the window procedure. You cannot change this
///             attribute if the window does not belong to the same process as the calling thread. </td> </tr> </table> The
///             following values are also available when the <i>hWnd</i> parameter identifies a dialog box. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DWL_DLGPROC"></a><a id="dwl_dlgproc"></a><dl>
///             <dt><b>DWL_DLGPROC</b></dt> <dt>DWLP_MSGRESULT + sizeof(LRESULT)</dt> </dl> </td> <td width="60%"> Sets the new
///             address of the dialog box procedure. </td> </tr> <tr> <td width="40%"><a id="DWL_MSGRESULT"></a><a
///             id="dwl_msgresult"></a><dl> <dt><b>DWL_MSGRESULT</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Sets the return
///             value of a message processed in the dialog box procedure. </td> </tr> <tr> <td width="40%"><a
///             id="DWL_USER"></a><a id="dwl_user"></a><dl> <dt><b>DWL_USER</b></dt> <dt>DWLP_DLGPROC + sizeof(DLGPROC)</dt>
///             </dl> </td> <td width="60%"> Sets new extra information that is private to the application, such as handles or
///             pointers. </td> </tr> </table>
///    dwNewLong = Type: <b>LONG</b> The replacement value.
///Returns:
///    Type: <b>LONG</b> If the function succeeds, the return value is the previous value of the specified 32-bit
///    integer. If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    If the previous value of the specified 32-bit integer is zero, and the function succeeds, the return value is
///    zero, but the function does not clear the last error information. This makes it difficult to determine success or
///    failure. To deal with this, you should clear the last error information by calling SetLastError with 0 before
///    calling <b>SetWindowLong</b>. Then, function failure will be indicated by a return value of zero and a
///    GetLastError result that is nonzero.
///    
@DllImport("USER32")
int SetWindowLongA(HWND hWnd, int nIndex, int dwNewLong);

///Changes an attribute of the specified window. The function also sets the 32-bit (long) value at the specified offset
///into the extra window memory. <div class="alert"><b>Note</b> This function has been superseded by the
///SetWindowLongPtr function. To write code that is compatible with both 32-bit and 64-bit versions of Windows, use the
///<b>SetWindowLongPtr</b> function.</div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The zero-based offset to the value to be set. Valid values are in the range zero through the
///             number of bytes of extra window memory, minus the size of an integer. To set any other value, specify one of the
///             following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="GWL_EXSTYLE"></a><a id="gwl_exstyle"></a><dl> <dt><b>GWL_EXSTYLE</b></dt> <dt>-20</dt> </dl> </td> <td
///             width="60%"> Sets a new extended window style. </td> </tr> <tr> <td width="40%"><a id="GWL_HINSTANCE"></a><a
///             id="gwl_hinstance"></a><dl> <dt><b>GWL_HINSTANCE</b></dt> <dt>-6</dt> </dl> </td> <td width="60%"> Sets a new
///             application instance handle. </td> </tr> <tr> <td width="40%"><a id="GWL_ID"></a><a id="gwl_id"></a><dl>
///             <dt><b>GWL_ID</b></dt> <dt>-12</dt> </dl> </td> <td width="60%"> Sets a new identifier of the child window. The
///             window cannot be a top-level window. </td> </tr> <tr> <td width="40%"><a id="GWL_STYLE"></a><a
///             id="gwl_style"></a><dl> <dt><b>GWL_STYLE</b></dt> <dt>-16</dt> </dl> </td> <td width="60%"> Sets a new window
///             style. </td> </tr> <tr> <td width="40%"><a id="GWL_USERDATA"></a><a id="gwl_userdata"></a><dl>
///             <dt><b>GWL_USERDATA</b></dt> <dt>-21</dt> </dl> </td> <td width="60%"> Sets the user data associated with the
///             window. This data is intended for use by the application that created the window. Its value is initially zero.
///             </td> </tr> <tr> <td width="40%"><a id="GWL_WNDPROC"></a><a id="gwl_wndproc"></a><dl> <dt><b>GWL_WNDPROC</b></dt>
///             <dt>-4</dt> </dl> </td> <td width="60%"> Sets a new address for the window procedure. You cannot change this
///             attribute if the window does not belong to the same process as the calling thread. </td> </tr> </table> The
///             following values are also available when the <i>hWnd</i> parameter identifies a dialog box. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DWL_DLGPROC"></a><a id="dwl_dlgproc"></a><dl>
///             <dt><b>DWL_DLGPROC</b></dt> <dt>DWLP_MSGRESULT + sizeof(LRESULT)</dt> </dl> </td> <td width="60%"> Sets the new
///             address of the dialog box procedure. </td> </tr> <tr> <td width="40%"><a id="DWL_MSGRESULT"></a><a
///             id="dwl_msgresult"></a><dl> <dt><b>DWL_MSGRESULT</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Sets the return
///             value of a message processed in the dialog box procedure. </td> </tr> <tr> <td width="40%"><a
///             id="DWL_USER"></a><a id="dwl_user"></a><dl> <dt><b>DWL_USER</b></dt> <dt>DWLP_DLGPROC + sizeof(DLGPROC)</dt>
///             </dl> </td> <td width="60%"> Sets new extra information that is private to the application, such as handles or
///             pointers. </td> </tr> </table>
///    dwNewLong = Type: <b>LONG</b> The replacement value.
///Returns:
///    Type: <b>LONG</b> If the function succeeds, the return value is the previous value of the specified 32-bit
///    integer. If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    If the previous value of the specified 32-bit integer is zero, and the function succeeds, the return value is
///    zero, but the function does not clear the last error information. This makes it difficult to determine success or
///    failure. To deal with this, you should clear the last error information by calling SetLastError with 0 before
///    calling <b>SetWindowLong</b>. Then, function failure will be indicated by a return value of zero and a
///    GetLastError result that is nonzero.
///    
@DllImport("USER32")
int SetWindowLongW(HWND hWnd, int nIndex, int dwNewLong);

///Retrieves the 16-bit (<b>WORD</b>) value at the specified offset into the extra class memory for the window class to
///which the specified window belongs. <div class="alert"><b>Note</b> This function is deprecated for any use other than
///<i>nIndex</i> set to <b>GCW_ATOM</b>. The function is provided only for compatibility with 16-bit versions of
///Windows. Applications should use the GetClassLongPtr or GetClassLongPtr function.</div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The zero-based byte offset of the value to be retrieved. Valid values are in the range zero
///             through the number of bytes of class memory, minus two; for example, if you specified 10 or more bytes of extra
///             class memory, a value of eight would be an index to the fifth 16-bit integer. There is an additional valid value
///             as shown in the following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="GCW_ATOM"></a><a id="gcw_atom"></a><dl> <dt><b>GCW_ATOM</b></dt> <dt>-32</dt> </dl> </td> <td width="60%">
///             Retrieves an <b>ATOM</b> value that uniquely identifies the window class. This is the same atom that the
///             RegisterClass or RegisterClassEx function returns. </td> </tr> </table>
///Returns:
///    Type: <b>WORD</b> If the function succeeds, the return value is the requested 16-bit value. If the function
///    fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort GetClassWord(HWND hWnd, int nIndex);

///Replaces the 16-bit (<b>WORD</b>) value at the specified offset into the extra class memory for the window class to
///which the specified window belongs. <div class="alert"><b>Note</b> This function is provided only for compatibility
///with 16-bit versions of Windows. Applications should use the SetClassLong function.</div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The zero-based byte offset of the value to be replaced. Valid values are in the range zero
///             through the number of bytes of class memory minus two; for example, if you specified 10 or more bytes of extra
///             class memory, a value of 8 would be an index to the fifth 16-bit integer.
///    wNewWord = Type: <b>WORD</b> The replacement value.
///Returns:
///    Type: <b>WORD</b> If the function succeeds, the return value is the previous value of the specified 16-bit
///    integer. If the value was not previously set, the return value is zero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort SetClassWord(HWND hWnd, int nIndex, ushort wNewWord);

///Retrieves the specified 32-bit (<b>DWORD</b>) value from the WNDCLASSEX structure associated with the specified
///window. <div class="alert"><b>Note</b> If you are retrieving a pointer or a handle, this function has been superseded
///by the GetClassLongPtr function. (Pointers and handles are 32 bits on 32-bit Windows and 64 bits on 64-bit
///Windows.)</div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The value to be retrieved. To retrieve a value from the extra class memory, specify the
///             positive, zero-based byte offset of the value to be retrieved. Valid values are in the range zero through the
///             number of bytes of extra class memory, minus four; for example, if you specified 12 or more bytes of extra class
///             memory, a value of 8 would be an index to the third integer. To retrieve any other value from the WNDCLASSEX
///             structure, specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///             width="40%"><a id="GCW_ATOM"></a><a id="gcw_atom"></a><dl> <dt><b>GCW_ATOM</b></dt> <dt>-32</dt> </dl> </td> <td
///             width="60%"> Retrieves an <b>ATOM</b> value that uniquely identifies the window class. This is the same atom that
///             the RegisterClassEx function returns. </td> </tr> <tr> <td width="40%"><a id="GCL_CBCLSEXTRA"></a><a
///             id="gcl_cbclsextra"></a><dl> <dt><b>GCL_CBCLSEXTRA</b></dt> <dt>-20</dt> </dl> </td> <td width="60%"> Retrieves
///             the size, in bytes, of the extra memory associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_CBWNDEXTRA"></a><a id="gcl_cbwndextra"></a><dl> <dt><b>GCL_CBWNDEXTRA</b></dt> <dt>-18</dt> </dl> </td>
///             <td width="60%"> Retrieves the size, in bytes, of the extra window memory associated with each window in the
///             class. For information on how to access this memory, see GetWindowLong. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HBRBACKGROUND"></a><a id="gcl_hbrbackground"></a><dl> <dt><b>GCL_HBRBACKGROUND</b></dt> <dt>-10</dt>
///             </dl> </td> <td width="60%"> Retrieves a handle to the background brush associated with the class. </td> </tr>
///             <tr> <td width="40%"><a id="GCL_HCURSOR"></a><a id="gcl_hcursor"></a><dl> <dt><b>GCL_HCURSOR</b></dt>
///             <dt>-12</dt> </dl> </td> <td width="60%"> Retrieves a handle to the cursor associated with the class. </td> </tr>
///             <tr> <td width="40%"><a id="GCL_HICON"></a><a id="gcl_hicon"></a><dl> <dt><b>GCL_HICON</b></dt> <dt>-14</dt>
///             </dl> </td> <td width="60%"> Retrieves a handle to the icon associated with the class. </td> </tr> <tr> <td
///             width="40%"><a id="GCL_HICONSM"></a><a id="gcl_hiconsm"></a><dl> <dt><b>GCL_HICONSM</b></dt> <dt>-34</dt> </dl>
///             </td> <td width="60%"> Retrieves a handle to the small icon associated with the class. </td> </tr> <tr> <td
///             width="40%"><a id="GCL_HMODULE"></a><a id="gcl_hmodule"></a><dl> <dt><b>GCL_HMODULE</b></dt> <dt>-16</dt> </dl>
///             </td> <td width="60%"> Retrieves a handle to the module that registered the class. </td> </tr> <tr> <td
///             width="40%"><a id="GCL_MENUNAME"></a><a id="gcl_menuname"></a><dl> <dt><b>GCL_MENUNAME</b></dt> <dt>-8</dt> </dl>
///             </td> <td width="60%"> Retrieves the address of the menu name string. The string identifies the menu resource
///             associated with the class. </td> </tr> <tr> <td width="40%"><a id="GCL_STYLE"></a><a id="gcl_style"></a><dl>
///             <dt><b>GCL_STYLE</b></dt> <dt>-26</dt> </dl> </td> <td width="60%"> Retrieves the window-class style bits. </td>
///             </tr> <tr> <td width="40%"><a id="GCL_WNDPROC"></a><a id="gcl_wndproc"></a><dl> <dt><b>GCL_WNDPROC</b></dt>
///             <dt>-24</dt> </dl> </td> <td width="60%"> Retrieves the address of the window procedure, or a handle representing
///             the address of the window procedure. You must use the CallWindowProc function to call the window procedure. </td>
///             </tr> </table>
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the requested value. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint GetClassLongA(HWND hWnd, int nIndex);

///Retrieves the specified 32-bit (<b>DWORD</b>) value from the WNDCLASSEX structure associated with the specified
///window. <div class="alert"><b>Note</b> If you are retrieving a pointer or a handle, this function has been superseded
///by the GetClassLongPtr function. (Pointers and handles are 32 bits on 32-bit Windows and 64 bits on 64-bit
///Windows.)</div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The value to be retrieved. To retrieve a value from the extra class memory, specify the
///             positive, zero-based byte offset of the value to be retrieved. Valid values are in the range zero through the
///             number of bytes of extra class memory, minus four; for example, if you specified 12 or more bytes of extra class
///             memory, a value of 8 would be an index to the third integer. To retrieve any other value from the WNDCLASSEX
///             structure, specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///             width="40%"><a id="GCW_ATOM"></a><a id="gcw_atom"></a><dl> <dt><b>GCW_ATOM</b></dt> <dt>-32</dt> </dl> </td> <td
///             width="60%"> Retrieves an <b>ATOM</b> value that uniquely identifies the window class. This is the same atom that
///             the RegisterClassEx function returns. </td> </tr> <tr> <td width="40%"><a id="GCL_CBCLSEXTRA"></a><a
///             id="gcl_cbclsextra"></a><dl> <dt><b>GCL_CBCLSEXTRA</b></dt> <dt>-20</dt> </dl> </td> <td width="60%"> Retrieves
///             the size, in bytes, of the extra memory associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_CBWNDEXTRA"></a><a id="gcl_cbwndextra"></a><dl> <dt><b>GCL_CBWNDEXTRA</b></dt> <dt>-18</dt> </dl> </td>
///             <td width="60%"> Retrieves the size, in bytes, of the extra window memory associated with each window in the
///             class. For information on how to access this memory, see GetWindowLong. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HBRBACKGROUND"></a><a id="gcl_hbrbackground"></a><dl> <dt><b>GCL_HBRBACKGROUND</b></dt> <dt>-10</dt>
///             </dl> </td> <td width="60%"> Retrieves a handle to the background brush associated with the class. </td> </tr>
///             <tr> <td width="40%"><a id="GCL_HCURSOR"></a><a id="gcl_hcursor"></a><dl> <dt><b>GCL_HCURSOR</b></dt>
///             <dt>-12</dt> </dl> </td> <td width="60%"> Retrieves a handle to the cursor associated with the class. </td> </tr>
///             <tr> <td width="40%"><a id="GCL_HICON"></a><a id="gcl_hicon"></a><dl> <dt><b>GCL_HICON</b></dt> <dt>-14</dt>
///             </dl> </td> <td width="60%"> Retrieves a handle to the icon associated with the class. </td> </tr> <tr> <td
///             width="40%"><a id="GCL_HICONSM"></a><a id="gcl_hiconsm"></a><dl> <dt><b>GCL_HICONSM</b></dt> <dt>-34</dt> </dl>
///             </td> <td width="60%"> Retrieves a handle to the small icon associated with the class. </td> </tr> <tr> <td
///             width="40%"><a id="GCL_HMODULE"></a><a id="gcl_hmodule"></a><dl> <dt><b>GCL_HMODULE</b></dt> <dt>-16</dt> </dl>
///             </td> <td width="60%"> Retrieves a handle to the module that registered the class. </td> </tr> <tr> <td
///             width="40%"><a id="GCL_MENUNAME"></a><a id="gcl_menuname"></a><dl> <dt><b>GCL_MENUNAME</b></dt> <dt>-8</dt> </dl>
///             </td> <td width="60%"> Retrieves the address of the menu name string. The string identifies the menu resource
///             associated with the class. </td> </tr> <tr> <td width="40%"><a id="GCL_STYLE"></a><a id="gcl_style"></a><dl>
///             <dt><b>GCL_STYLE</b></dt> <dt>-26</dt> </dl> </td> <td width="60%"> Retrieves the window-class style bits. </td>
///             </tr> <tr> <td width="40%"><a id="GCL_WNDPROC"></a><a id="gcl_wndproc"></a><dl> <dt><b>GCL_WNDPROC</b></dt>
///             <dt>-24</dt> </dl> </td> <td width="60%"> Retrieves the address of the window procedure, or a handle representing
///             the address of the window procedure. You must use the CallWindowProc function to call the window procedure. </td>
///             </tr> </table>
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the requested value. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint GetClassLongW(HWND hWnd, int nIndex);

///Replaces the specified 32-bit (<b>long</b>) value at the specified offset into the extra class memory or the
///WNDCLASSEX structure for the class to which the specified window belongs. <div class="alert"><b>Note</b> This
///function has been superseded by the SetClassLongPtr function. To write code that is compatible with both 32-bit and
///64-bit versions of Windows, use <b>SetClassLongPtr</b>. </div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The value to be replaced. To set a 32-bit value in the extra class memory, specify the positive,
///             zero-based byte offset of the value to be set. Valid values are in the range zero through the number of bytes of
///             extra class memory, minus four; for example, if you specified 12 or more bytes of extra class memory, a value of
///             8 would be an index to the third 32-bit integer. To set any other value from the WNDCLASSEX structure, specify
///             one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="GCL_CBCLSEXTRA"></a><a id="gcl_cbclsextra"></a><dl> <dt><b>GCL_CBCLSEXTRA</b></dt> <dt>-20</dt> </dl> </td>
///             <td width="60%"> Sets the size, in bytes, of the extra memory associated with the class. Setting this value does
///             not change the number of extra bytes already allocated. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_CBWNDEXTRA"></a><a id="gcl_cbwndextra"></a><dl> <dt><b>GCL_CBWNDEXTRA</b></dt> <dt>-18</dt> </dl> </td>
///             <td width="60%"> Sets the size, in bytes, of the extra window memory associated with each window in the class.
///             Setting this value does not change the number of extra bytes already allocated. For information on how to access
///             this memory, see SetWindowLong. </td> </tr> <tr> <td width="40%"><a id="GCL_HBRBACKGROUND"></a><a
///             id="gcl_hbrbackground"></a><dl> <dt><b>GCL_HBRBACKGROUND</b></dt> <dt>-10</dt> </dl> </td> <td width="60%">
///             Replaces a handle to the background brush associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HCURSOR"></a><a id="gcl_hcursor"></a><dl> <dt><b>GCL_HCURSOR</b></dt> <dt>-12</dt> </dl> </td> <td
///             width="60%"> Replaces a handle to the cursor associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HICON"></a><a id="gcl_hicon"></a><dl> <dt><b>GCL_HICON</b></dt> <dt>-14</dt> </dl> </td> <td width="60%">
///             Replaces a handle to the icon associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HICONSM"></a><a id="gcl_hiconsm"></a><dl> <dt><b>GCL_HICONSM</b></dt> <dt>-34</dt> </dl> </td> <td
///             width="60%"> Replace a handle to the small icon associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HMODULE"></a><a id="gcl_hmodule"></a><dl> <dt><b>GCL_HMODULE</b></dt> <dt>-16</dt> </dl> </td> <td
///             width="60%"> Replaces a handle to the module that registered the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_MENUNAME"></a><a id="gcl_menuname"></a><dl> <dt><b>GCL_MENUNAME</b></dt> <dt>-8</dt> </dl> </td> <td
///             width="60%"> Replaces the address of the menu name string. The string identifies the menu resource associated
///             with the class. </td> </tr> <tr> <td width="40%"><a id="GCL_STYLE"></a><a id="gcl_style"></a><dl>
///             <dt><b>GCL_STYLE</b></dt> <dt>-26</dt> </dl> </td> <td width="60%"> Replaces the window-class style bits. </td>
///             </tr> <tr> <td width="40%"><a id="GCL_WNDPROC"></a><a id="gcl_wndproc"></a><dl> <dt><b>GCL_WNDPROC</b></dt>
///             <dt>-24</dt> </dl> </td> <td width="60%"> Replaces the address of the window procedure associated with the class.
///             </td> </tr> </table>
///    dwNewLong = Type: <b>LONG</b> The replacement value.
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the previous value of the specified 32-bit
///    integer. If the value was not previously set, the return value is zero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint SetClassLongA(HWND hWnd, int nIndex, int dwNewLong);

///Replaces the specified 32-bit (<b>long</b>) value at the specified offset into the extra class memory or the
///WNDCLASSEX structure for the class to which the specified window belongs. <div class="alert"><b>Note</b> This
///function has been superseded by the SetClassLongPtr function. To write code that is compatible with both 32-bit and
///64-bit versions of Windows, use <b>SetClassLongPtr</b>. </div><div> </div>
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    nIndex = Type: <b>int</b> The value to be replaced. To set a 32-bit value in the extra class memory, specify the positive,
///             zero-based byte offset of the value to be set. Valid values are in the range zero through the number of bytes of
///             extra class memory, minus four; for example, if you specified 12 or more bytes of extra class memory, a value of
///             8 would be an index to the third 32-bit integer. To set any other value from the WNDCLASSEX structure, specify
///             one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="GCL_CBCLSEXTRA"></a><a id="gcl_cbclsextra"></a><dl> <dt><b>GCL_CBCLSEXTRA</b></dt> <dt>-20</dt> </dl> </td>
///             <td width="60%"> Sets the size, in bytes, of the extra memory associated with the class. Setting this value does
///             not change the number of extra bytes already allocated. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_CBWNDEXTRA"></a><a id="gcl_cbwndextra"></a><dl> <dt><b>GCL_CBWNDEXTRA</b></dt> <dt>-18</dt> </dl> </td>
///             <td width="60%"> Sets the size, in bytes, of the extra window memory associated with each window in the class.
///             Setting this value does not change the number of extra bytes already allocated. For information on how to access
///             this memory, see SetWindowLong. </td> </tr> <tr> <td width="40%"><a id="GCL_HBRBACKGROUND"></a><a
///             id="gcl_hbrbackground"></a><dl> <dt><b>GCL_HBRBACKGROUND</b></dt> <dt>-10</dt> </dl> </td> <td width="60%">
///             Replaces a handle to the background brush associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HCURSOR"></a><a id="gcl_hcursor"></a><dl> <dt><b>GCL_HCURSOR</b></dt> <dt>-12</dt> </dl> </td> <td
///             width="60%"> Replaces a handle to the cursor associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HICON"></a><a id="gcl_hicon"></a><dl> <dt><b>GCL_HICON</b></dt> <dt>-14</dt> </dl> </td> <td width="60%">
///             Replaces a handle to the icon associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HICONSM"></a><a id="gcl_hiconsm"></a><dl> <dt><b>GCL_HICONSM</b></dt> <dt>-34</dt> </dl> </td> <td
///             width="60%"> Replace a handle to the small icon associated with the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_HMODULE"></a><a id="gcl_hmodule"></a><dl> <dt><b>GCL_HMODULE</b></dt> <dt>-16</dt> </dl> </td> <td
///             width="60%"> Replaces a handle to the module that registered the class. </td> </tr> <tr> <td width="40%"><a
///             id="GCL_MENUNAME"></a><a id="gcl_menuname"></a><dl> <dt><b>GCL_MENUNAME</b></dt> <dt>-8</dt> </dl> </td> <td
///             width="60%"> Replaces the address of the menu name string. The string identifies the menu resource associated
///             with the class. </td> </tr> <tr> <td width="40%"><a id="GCL_STYLE"></a><a id="gcl_style"></a><dl>
///             <dt><b>GCL_STYLE</b></dt> <dt>-26</dt> </dl> </td> <td width="60%"> Replaces the window-class style bits. </td>
///             </tr> <tr> <td width="40%"><a id="GCL_WNDPROC"></a><a id="gcl_wndproc"></a><dl> <dt><b>GCL_WNDPROC</b></dt>
///             <dt>-24</dt> </dl> </td> <td width="60%"> Replaces the address of the window procedure associated with the class.
///             </td> </tr> </table>
///    dwNewLong = Type: <b>LONG</b> The replacement value.
///Returns:
///    Type: <b>DWORD</b> If the function succeeds, the return value is the previous value of the specified 32-bit
///    integer. If the value was not previously set, the return value is zero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint SetClassLongW(HWND hWnd, int nIndex, int dwNewLong);

///Retrieves the default layout that is used when windows are created with no parent or owner.
///Params:
///    pdwDefaultLayout = Type: <b>DWORD*</b> The current default process layout. For a list of values, see SetProcessDefaultLayout.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetProcessDefaultLayout(uint* pdwDefaultLayout);

///Changes the default layout when windows are created with no parent or owner only for the currently running process.
///Params:
///    dwDefaultLayout = Type: <b>DWORD</b> The default process layout. This parameter can be 0 or the following value. <table> <tr>
///                      <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LAYOUT_RTL"></a><a id="layout_rtl"></a><dl>
///                      <dt><b>LAYOUT_RTL</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Sets the default horizontal layout to
///                      be right to left. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetProcessDefaultLayout(uint dwDefaultLayout);

///Retrieves a handle to the desktop window. The desktop window covers the entire screen. The desktop window is the area
///on top of which other windows are painted.
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the desktop window.
///    
@DllImport("USER32")
HWND GetDesktopWindow();

///Retrieves a handle to the specified window's parent or owner. To retrieve a handle to a specified ancestor, use the
///GetAncestor function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window whose parent window handle is to be retrieved.
///Returns:
///    Type: <b>HWND</b> If the window is a child window, the return value is a handle to the parent window. If the
///    window is a top-level window with the <b>WS_POPUP</b> style, the return value is a handle to the owner window. If
///    the function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError. This
///    function typically fails for one of the following reasons: <ul> <li>The window is a top-level window that is
///    unowned or does not have the <b>WS_POPUP</b> style. </li> <li>The owner window has <b>WS_POPUP</b> style.</li>
///    </ul>
///    
@DllImport("USER32")
HWND GetParent(HWND hWnd);

///Changes the parent window of the specified child window.
///Params:
///    hWndChild = Type: <b>HWND</b> A handle to the child window.
///    hWndNewParent = Type: <b>HWND</b> A handle to the new parent window. If this parameter is <b>NULL</b>, the desktop window becomes
///                    the new parent window. If this parameter is <b>HWND_MESSAGE</b>, the child window becomes a message-only window.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the previous parent window. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND SetParent(HWND hWndChild, HWND hWndNewParent);

///Enumerates the child windows that belong to the specified parent window by passing the handle to each child window,
///in turn, to an application-defined callback function. <b>EnumChildWindows</b> continues until the last child window
///is enumerated or the callback function returns <b>FALSE</b>.
///Params:
///    hWndParent = Type: <b>HWND</b> A handle to the parent window whose child windows are to be enumerated. If this parameter is
///                 <b>NULL</b>, this function is equivalent to EnumWindows.
///    lpEnumFunc = Type: <b>WNDENUMPROC</b> A pointer to an application-defined callback function. For more information, see
///                 EnumChildProc.
///    lParam = Type: <b>LPARAM</b> An application-defined value to be passed to the callback function.
///Returns:
///    Type: <b>BOOL</b> The return value is not used.
///    
@DllImport("USER32")
BOOL EnumChildWindows(HWND hWndParent, WNDENUMPROC lpEnumFunc, LPARAM lParam);

///Retrieves a handle to the top-level window whose class name and window name match the specified strings. This
///function does not search child windows. This function does not perform a case-sensitive search. To search child
///windows, beginning with a specified child window, use the FindWindowEx function.
///Params:
///    lpClassName = Type: <b>LPCTSTR</b> The class name or a class atom created by a previous call to the RegisterClass or
///                  RegisterClassEx function. The atom must be in the low-order word of <i>lpClassName</i>; the high-order word must
///                  be zero. If <i>lpClassName</i> points to a string, it specifies the window class name. The class name can be any
///                  name registered with RegisterClass or RegisterClassEx, or any of the predefined control-class names. If
///                  <i>lpClassName</i> is <b>NULL</b>, it finds any window whose title matches the <i>lpWindowName</i> parameter.
///    lpWindowName = Type: <b>LPCTSTR</b> The window name (the window's title). If this parameter is <b>NULL</b>, all window names
///                   match.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the window that has the specified
///    class name and window name. If the function fails, the return value is <b>NULL</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
HWND FindWindowA(const(PSTR) lpClassName, const(PSTR) lpWindowName);

///Retrieves a handle to the top-level window whose class name and window name match the specified strings. This
///function does not search child windows. This function does not perform a case-sensitive search. To search child
///windows, beginning with a specified child window, use the FindWindowEx function.
///Params:
///    lpClassName = Type: <b>LPCTSTR</b> The class name or a class atom created by a previous call to the RegisterClass or
///                  RegisterClassEx function. The atom must be in the low-order word of <i>lpClassName</i>; the high-order word must
///                  be zero. If <i>lpClassName</i> points to a string, it specifies the window class name. The class name can be any
///                  name registered with RegisterClass or RegisterClassEx, or any of the predefined control-class names. If
///                  <i>lpClassName</i> is <b>NULL</b>, it finds any window whose title matches the <i>lpWindowName</i> parameter.
///    lpWindowName = Type: <b>LPCTSTR</b> The window name (the window's title). If this parameter is <b>NULL</b>, all window names
///                   match.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the window that has the specified
///    class name and window name. If the function fails, the return value is <b>NULL</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
HWND FindWindowW(const(PWSTR) lpClassName, const(PWSTR) lpWindowName);

///Retrieves a handle to a window whose class name and window name match the specified strings. The function searches
///child windows, beginning with the one following the specified child window. This function does not perform a
///case-sensitive search.
///Params:
///    hWndParent = Type: <b>HWND</b> A handle to the parent window whose child windows are to be searched. If <i>hwndParent</i> is
///                 <b>NULL</b>, the function uses the desktop window as the parent window. The function searches among windows that
///                 are child windows of the desktop. If <i>hwndParent</i> is <b>HWND_MESSAGE</b>, the function searches all
///                 message-only windows.
///    hWndChildAfter = Type: <b>HWND</b> A handle to a child window. The search begins with the next child window in the Z order. The
///                     child window must be a direct child window of <i>hwndParent</i>, not just a descendant window. If
///                     <i>hwndChildAfter</i> is <b>NULL</b>, the search begins with the first child window of <i>hwndParent</i>. Note
///                     that if both <i>hwndParent</i> and <i>hwndChildAfter</i> are <b>NULL</b>, the function searches all top-level and
///                     message-only windows.
///    lpszClass = Type: <b>LPCTSTR</b> The class name or a class atom created by a previous call to the RegisterClass or
///                RegisterClassEx function. The atom must be placed in the low-order word of <i>lpszClass</i>; the high-order word
///                must be zero. If <i>lpszClass</i> is a string, it specifies the window class name. The class name can be any name
///                registered with RegisterClass or RegisterClassEx, or any of the predefined control-class names, or it can be
///                <code>MAKEINTATOM(0x8000)</code>. In this latter case, 0x8000 is the atom for a menu class. For more information,
///                see the Remarks section of this topic.
///    lpszWindow = Type: <b>LPCTSTR</b> The window name (the window's title). If this parameter is <b>NULL</b>, all window names
///                 match.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the window that has the specified
///    class and window names. If the function fails, the return value is <b>NULL</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
HWND FindWindowExA(HWND hWndParent, HWND hWndChildAfter, const(PSTR) lpszClass, const(PSTR) lpszWindow);

///Retrieves a handle to a window whose class name and window name match the specified strings. The function searches
///child windows, beginning with the one following the specified child window. This function does not perform a
///case-sensitive search.
///Params:
///    hWndParent = Type: <b>HWND</b> A handle to the parent window whose child windows are to be searched. If <i>hwndParent</i> is
///                 <b>NULL</b>, the function uses the desktop window as the parent window. The function searches among windows that
///                 are child windows of the desktop. If <i>hwndParent</i> is <b>HWND_MESSAGE</b>, the function searches all
///                 message-only windows.
///    hWndChildAfter = Type: <b>HWND</b> A handle to a child window. The search begins with the next child window in the Z order. The
///                     child window must be a direct child window of <i>hwndParent</i>, not just a descendant window. If
///                     <i>hwndChildAfter</i> is <b>NULL</b>, the search begins with the first child window of <i>hwndParent</i>. Note
///                     that if both <i>hwndParent</i> and <i>hwndChildAfter</i> are <b>NULL</b>, the function searches all top-level and
///                     message-only windows.
///    lpszClass = Type: <b>LPCTSTR</b> The class name or a class atom created by a previous call to the RegisterClass or
///                RegisterClassEx function. The atom must be placed in the low-order word of <i>lpszClass</i>; the high-order word
///                must be zero. If <i>lpszClass</i> is a string, it specifies the window class name. The class name can be any name
///                registered with RegisterClass or RegisterClassEx, or any of the predefined control-class names, or it can be
///                <code>MAKEINTATOM(0x8000)</code>. In this latter case, 0x8000 is the atom for a menu class. For more information,
///                see the Remarks section of this topic.
///    lpszWindow = Type: <b>LPCTSTR</b> The window name (the window's title). If this parameter is <b>NULL</b>, all window names
///                 match.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the window that has the specified
///    class and window names. If the function fails, the return value is <b>NULL</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
HWND FindWindowExW(HWND hWndParent, HWND hWndChildAfter, const(PWSTR) lpszClass, const(PWSTR) lpszWindow);

///Retrieves a handle to the Shell's desktop window.
///Returns:
///    Type: <b>HWND</b> The return value is the handle of the Shell's desktop window. If no Shell process is present,
///    the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND GetShellWindow();

///<p class="CCE_Message">[This function is not intended for general use. It may be altered or unavailable in subsequent
///versions of Windows.] Registers a specified Shell window to receive certain messages for events or notifications that
///are useful to Shell applications. The event messages received are only those sent to the Shell window associated with
///the specified window's desktop. Many of the messages are the same as those that can be received after calling the
///SetWindowsHookEx function and specifying <b>WH_SHELL</b> for the hook type. The difference with
///<b>RegisterShellHookWindow</b> is that the messages are received through the specified window's WindowProc and not
///through a call back procedure.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window to register for Shell hook messages.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> if the function succeeds; otherwise, <b>FALSE</b>.
///    
@DllImport("USER32")
BOOL RegisterShellHookWindow(HWND hwnd);

///<p class="CCE_Message">[This function is not intended for general use. It may be altered or unavailable in subsequent
///versions of Windows.] Unregisters a specified Shell window that is registered to receive Shell hook messages.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window to be unregistered. The window was registered with a call to the
///           RegisterShellHookWindow function.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> if the function succeeds; <b>FALSE</b> if the function fails.
///    
@DllImport("USER32")
BOOL DeregisterShellHookWindow(HWND hwnd);

///Enumerates all top-level windows on the screen by passing the handle to each window, in turn, to an
///application-defined callback function. <b>EnumWindows</b> continues until the last top-level window is enumerated or
///the callback function returns <b>FALSE</b>.
///Params:
///    lpEnumFunc = Type: <b>WNDENUMPROC</b> A pointer to an application-defined callback function. For more information, see
///                 EnumWindowsProc.
///    lParam = Type: <b>LPARAM</b> An application-defined value to be passed to the callback function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. If EnumWindowsProc returns zero, the return value
///    is also zero. In this case, the callback function should call SetLastError to obtain a meaningful error code to
///    be returned to the caller of <b>EnumWindows</b>.
///    
@DllImport("USER32")
BOOL EnumWindows(WNDENUMPROC lpEnumFunc, LPARAM lParam);

///Enumerates all nonchild windows associated with a thread by passing the handle to each window, in turn, to an
///application-defined callback function. <b>EnumThreadWindows</b> continues until the last window is enumerated or the
///callback function returns <b>FALSE</b>. To enumerate child windows of a particular window, use the EnumChildWindows
///function.
///Params:
///    dwThreadId = Type: <b>DWORD</b> The identifier of the thread whose windows are to be enumerated.
///    lpfn = Type: <b>WNDENUMPROC</b> A pointer to an application-defined callback function. For more information, see
///           EnumThreadWndProc.
///    lParam = Type: <b>LPARAM</b> An application-defined value to be passed to the callback function.
///Returns:
///    Type: <b>BOOL</b> If the callback function returns <b>TRUE</b> for all windows in the thread specified by
///    <i>dwThreadId</i>, the return value is <b>TRUE</b>. If the callback function returns <b>FALSE</b> on any
///    enumerated window, or if there are no windows found in the thread specified by <i>dwThreadId</i>, the return
///    value is <b>FALSE</b>.
///    
@DllImport("USER32")
BOOL EnumThreadWindows(uint dwThreadId, WNDENUMPROC lpfn, LPARAM lParam);

///Retrieves the name of the class to which the specified window belongs.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    lpClassName = Type: <b>LPTSTR</b> The class name string.
///    nMaxCount = Type: <b>int</b> The length of the *lpClassName* buffer, in characters. The buffer must be large enough to
///                include the terminating null character; otherwise, the class name string is truncated to `nMaxCount-1`
///                characters.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of characters copied to the buffer, not
///    including the terminating null character. If the function fails, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
int GetClassNameA(HWND hWnd, PSTR lpClassName, int nMaxCount);

///Retrieves the name of the class to which the specified window belongs.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window and, indirectly, the class to which the window belongs.
///    lpClassName = Type: <b>LPTSTR</b> The class name string.
///    nMaxCount = Type: <b>int</b> The length of the *lpClassName* buffer, in characters. The buffer must be large enough to
///                include the terminating null character; otherwise, the class name string is truncated to `nMaxCount-1`
///                characters.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of characters copied to the buffer, not
///    including the terminating null character. If the function fails, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
int GetClassNameW(HWND hWnd, PWSTR lpClassName, int nMaxCount);

///Examines the Z order of the child windows associated with the specified parent window and retrieves a handle to the
///child window at the top of the Z order.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the parent window whose child windows are to be examined. If this parameter is
///           <b>NULL</b>, the function returns a handle to the window at the top of the Z order.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a handle to the child window at the top of the Z
///    order. If the specified window has no child windows, the return value is <b>NULL</b>. To get extended error
///    information, use the GetLastError function.
///    
@DllImport("USER32")
HWND GetTopWindow(HWND hWnd);

///Retrieves the identifier of the thread that created the specified window and, optionally, the identifier of the
///process that created the window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window.
///    lpdwProcessId = Type: <b>LPDWORD</b> A pointer to a variable that receives the process identifier. If this parameter is not
///                    <b>NULL</b>, <b>GetWindowThreadProcessId</b> copies the identifier of the process to the variable; otherwise, it
///                    does not.
///Returns:
///    Type: <b>DWORD</b> The return value is the identifier of the thread that created the window.
///    
@DllImport("USER32")
uint GetWindowThreadProcessId(HWND hWnd, uint* lpdwProcessId);

///Determines whether the calling thread is already a GUI thread. It can also optionally convert the thread to a GUI
///thread.
///Params:
///    bConvert = Type: <b>BOOL</b> If <b>TRUE</b> and the thread is not a GUI thread, convert the thread to a GUI thread.
///Returns:
///    Type: <b>BOOL</b> The function returns a nonzero value in the following situations: <ul> <li>If the calling
///    thread is already a GUI thread.</li> <li>If <i>bConvert</i> is <b>TRUE</b> and the function successfully converts
///    the thread to a GUI thread.</li> </ul> Otherwise, the function returns zero. If <i>bConvert</i> is <b>TRUE</b>
///    and the function cannot successfully convert the thread to a GUI thread, <b>IsGUIThread</b> returns
///    <b>ERROR_NOT_ENOUGH_MEMORY</b>.
///    
@DllImport("USER32")
BOOL IsGUIThread(BOOL bConvert);

///Determines which pop-up window owned by the specified window was most recently active.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the owner window.
///Returns:
///    Type: <b>HWND</b> The return value identifies the most recently active pop-up window. The return value is the
///    same as the <i>hWnd</i> parameter, if any of the following conditions are met: <ul> <li>The window identified by
///    hWnd was most recently active.</li> <li>The window identified by hWnd does not own any pop-up windows.</li>
///    <li>The window identifies by hWnd is not a top-level window, or it is owned by another window.</li> </ul>
///    
@DllImport("USER32")
HWND GetLastActivePopup(HWND hWnd);

///Retrieves a handle to a window that has the specified relationship (Z-Order or owner) to the specified window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to a window. The window handle retrieved is relative to this window, based on the
///           value of the <i>uCmd</i> parameter.
///    uCmd = Type: <b>UINT</b> The relationship between the specified window and the window whose handle is to be retrieved.
///           This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///           width="40%"><a id="GW_CHILD"></a><a id="gw_child"></a><dl> <dt><b>GW_CHILD</b></dt> <dt>5</dt> </dl> </td> <td
///           width="60%"> The retrieved handle identifies the child window at the top of the Z order, if the specified window
///           is a parent window; otherwise, the retrieved handle is <b>NULL</b>. The function examines only child windows of
///           the specified window. It does not examine descendant windows. </td> </tr> <tr> <td width="40%"><a
///           id="GW_ENABLEDPOPUP"></a><a id="gw_enabledpopup"></a><dl> <dt><b>GW_ENABLEDPOPUP</b></dt> <dt>6</dt> </dl> </td>
///           <td width="60%"> The retrieved handle identifies the enabled popup window owned by the specified window (the
///           search uses the first such window found using <b>GW_HWNDNEXT</b>); otherwise, if there are no enabled popup
///           windows, the retrieved handle is that of the specified window. </td> </tr> <tr> <td width="40%"><a
///           id="GW_HWNDFIRST"></a><a id="gw_hwndfirst"></a><dl> <dt><b>GW_HWNDFIRST</b></dt> <dt>0</dt> </dl> </td> <td
///           width="60%"> The retrieved handle identifies the window of the same type that is highest in the Z order. If the
///           specified window is a topmost window, the handle identifies a topmost window. If the specified window is a
///           top-level window, the handle identifies a top-level window. If the specified window is a child window, the handle
///           identifies a sibling window. </td> </tr> <tr> <td width="40%"><a id="GW_HWNDLAST"></a><a
///           id="gw_hwndlast"></a><dl> <dt><b>GW_HWNDLAST</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The retrieved
///           handle identifies the window of the same type that is lowest in the Z order. If the specified window is a topmost
///           window, the handle identifies a topmost window. If the specified window is a top-level window, the handle
///           identifies a top-level window. If the specified window is a child window, the handle identifies a sibling window.
///           </td> </tr> <tr> <td width="40%"><a id="GW_HWNDNEXT"></a><a id="gw_hwndnext"></a><dl> <dt><b>GW_HWNDNEXT</b></dt>
///           <dt>2</dt> </dl> </td> <td width="60%"> The retrieved handle identifies the window below the specified window in
///           the Z order. If the specified window is a topmost window, the handle identifies a topmost window. If the
///           specified window is a top-level window, the handle identifies a top-level window. If the specified window is a
///           child window, the handle identifies a sibling window. </td> </tr> <tr> <td width="40%"><a id="GW_HWNDPREV"></a><a
///           id="gw_hwndprev"></a><dl> <dt><b>GW_HWNDPREV</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The retrieved
///           handle identifies the window above the specified window in the Z order. If the specified window is a topmost
///           window, the handle identifies a topmost window. If the specified window is a top-level window, the handle
///           identifies a top-level window. If the specified window is a child window, the handle identifies a sibling window.
///           </td> </tr> <tr> <td width="40%"><a id="GW_OWNER"></a><a id="gw_owner"></a><dl> <dt><b>GW_OWNER</b></dt>
///           <dt>4</dt> </dl> </td> <td width="60%"> The retrieved handle identifies the specified window's owner window, if
///           any. For more information, see Owned Windows. </td> </tr> </table>
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is a window handle. If no window exists with the
///    specified relationship to the specified window, the return value is <b>NULL</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
HWND GetWindow(HWND hWnd, uint uCmd);

///Installs an application-defined hook procedure into a hook chain. You would install a hook procedure to monitor the
///system for certain types of events. These events are associated either with a specific thread or with all threads in
///the same desktop as the calling thread.
///Params:
///    idHook = Type: <b>int</b> The type of hook procedure to be installed. This parameter can be one of the following values.
///             <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WH_CALLWNDPROC"></a><a
///             id="wh_callwndproc"></a><dl> <dt><b>WH_CALLWNDPROC</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Installs a
///             hook procedure that monitors messages before the system sends them to the destination window procedure. For more
///             information, see the CallWndProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_CALLWNDPROCRET"></a><a id="wh_callwndprocret"></a><dl> <dt><b>WH_CALLWNDPROCRET</b></dt> <dt>12</dt> </dl>
///             </td> <td width="60%"> Installs a hook procedure that monitors messages after they have been processed by the
///             destination window procedure. For more information, see the CallWndRetProc hook procedure. </td> </tr> <tr> <td
///             width="40%"><a id="WH_CBT"></a><a id="wh_cbt"></a><dl> <dt><b>WH_CBT</b></dt> <dt>5</dt> </dl> </td> <td
///             width="60%"> Installs a hook procedure that receives notifications useful to a CBT application. For more
///             information, see the CBTProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_DEBUG"></a><a
///             id="wh_debug"></a><dl> <dt><b>WH_DEBUG</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> Installs a hook procedure
///             useful for debugging other hook procedures. For more information, see the DebugProc hook procedure. </td> </tr>
///             <tr> <td width="40%"><a id="WH_FOREGROUNDIDLE"></a><a id="wh_foregroundidle"></a><dl>
///             <dt><b>WH_FOREGROUNDIDLE</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> Installs a hook procedure that will be
///             called when the application's foreground thread is about to become idle. This hook is useful for performing low
///             priority tasks during idle time. For more information, see the ForegroundIdleProc hook procedure. </td> </tr>
///             <tr> <td width="40%"><a id="WH_GETMESSAGE"></a><a id="wh_getmessage"></a><dl> <dt><b>WH_GETMESSAGE</b></dt>
///             <dt>3</dt> </dl> </td> <td width="60%"> Installs a hook procedure that monitors messages posted to a message
///             queue. For more information, see the GetMsgProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_JOURNALPLAYBACK"></a><a id="wh_journalplayback"></a><dl> <dt><b>WH_JOURNALPLAYBACK</b></dt> <dt>1</dt>
///             </dl> </td> <td width="60%"> Installs a hook procedure that posts messages previously recorded by a
///             WH_JOURNALRECORD hook procedure. For more information, see the JournalPlaybackProc hook procedure. </td> </tr>
///             <tr> <td width="40%"><a id="WH_JOURNALRECORD"></a><a id="wh_journalrecord"></a><dl>
///             <dt><b>WH_JOURNALRECORD</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Installs a hook procedure that records
///             input messages posted to the system message queue. This hook is useful for recording macros. For more
///             information, see the JournalRecordProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_KEYBOARD"></a><a id="wh_keyboard"></a><dl> <dt><b>WH_KEYBOARD</b></dt> <dt>2</dt> </dl> </td> <td
///             width="60%"> Installs a hook procedure that monitors keystroke messages. For more information, see the
///             KeyboardProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_KEYBOARD_LL"></a><a
///             id="wh_keyboard_ll"></a><dl> <dt><b>WH_KEYBOARD_LL</b></dt> <dt>13</dt> </dl> </td> <td width="60%"> Installs a
///             hook procedure that monitors low-level keyboard input events. For more information, see the LowLevelKeyboardProc
///             hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_MOUSE"></a><a id="wh_mouse"></a><dl>
///             <dt><b>WH_MOUSE</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> Installs a hook procedure that monitors mouse
///             messages. For more information, see the MouseProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_MOUSE_LL"></a><a id="wh_mouse_ll"></a><dl> <dt><b>WH_MOUSE_LL</b></dt> <dt>14</dt> </dl> </td> <td
///             width="60%"> Installs a hook procedure that monitors low-level mouse input events. For more information, see the
///             LowLevelMouseProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_MSGFILTER"></a><a
///             id="wh_msgfilter"></a><dl> <dt><b>WH_MSGFILTER</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> Installs a hook
///             procedure that monitors messages generated as a result of an input event in a dialog box, message box, menu, or
///             scroll bar. For more information, see the MessageProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_SHELL"></a><a id="wh_shell"></a><dl> <dt><b>WH_SHELL</b></dt> <dt>10</dt> </dl> </td> <td width="60%">
///             Installs a hook procedure that receives notifications useful to shell applications. For more information, see the
///             ShellProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_SYSMSGFILTER"></a><a
///             id="wh_sysmsgfilter"></a><dl> <dt><b>WH_SYSMSGFILTER</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> Installs a
///             hook procedure that monitors messages generated as a result of an input event in a dialog box, message box, menu,
///             or scroll bar. The hook procedure monitors these messages for all applications in the same desktop as the calling
///             thread. For more information, see the SysMsgProc hook procedure. </td> </tr> </table>
///    lpfn = Type: <b>HOOKPROC</b> A pointer to the hook procedure. If the <i>dwThreadId</i> parameter is zero or specifies
///           the identifier of a thread created by a different process, the <i>lpfn</i> parameter must point to a hook
///           procedure in a DLL. Otherwise, <i>lpfn</i> can point to a hook procedure in the code associated with the current
///           process.
///    hmod = Type: <b>HINSTANCE</b> A handle to the DLL containing the hook procedure pointed to by the <i>lpfn</i> parameter.
///           The <i>hMod</i> parameter must be set to <b>NULL</b> if the <i>dwThreadId</i> parameter specifies a thread
///           created by the current process and if the hook procedure is within the code associated with the current process.
///    dwThreadId = Type: <b>DWORD</b> The identifier of the thread with which the hook procedure is to be associated. For desktop
///                 apps, if this parameter is zero, the hook procedure is associated with all existing threads running in the same
///                 desktop as the calling thread. For Windows Store apps, see the Remarks section.
///Returns:
///    Type: <b>HHOOK</b> If the function succeeds, the return value is the handle to the hook procedure. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HHOOK SetWindowsHookExA(int idHook, HOOKPROC lpfn, HINSTANCE hmod, uint dwThreadId);

///Installs an application-defined hook procedure into a hook chain. You would install a hook procedure to monitor the
///system for certain types of events. These events are associated either with a specific thread or with all threads in
///the same desktop as the calling thread.
///Params:
///    idHook = Type: <b>int</b> The type of hook procedure to be installed. This parameter can be one of the following values.
///             <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WH_CALLWNDPROC"></a><a
///             id="wh_callwndproc"></a><dl> <dt><b>WH_CALLWNDPROC</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Installs a
///             hook procedure that monitors messages before the system sends them to the destination window procedure. For more
///             information, see the CallWndProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_CALLWNDPROCRET"></a><a id="wh_callwndprocret"></a><dl> <dt><b>WH_CALLWNDPROCRET</b></dt> <dt>12</dt> </dl>
///             </td> <td width="60%"> Installs a hook procedure that monitors messages after they have been processed by the
///             destination window procedure. For more information, see the CallWndRetProc hook procedure. </td> </tr> <tr> <td
///             width="40%"><a id="WH_CBT"></a><a id="wh_cbt"></a><dl> <dt><b>WH_CBT</b></dt> <dt>5</dt> </dl> </td> <td
///             width="60%"> Installs a hook procedure that receives notifications useful to a CBT application. For more
///             information, see the CBTProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_DEBUG"></a><a
///             id="wh_debug"></a><dl> <dt><b>WH_DEBUG</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> Installs a hook procedure
///             useful for debugging other hook procedures. For more information, see the DebugProc hook procedure. </td> </tr>
///             <tr> <td width="40%"><a id="WH_FOREGROUNDIDLE"></a><a id="wh_foregroundidle"></a><dl>
///             <dt><b>WH_FOREGROUNDIDLE</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> Installs a hook procedure that will be
///             called when the application's foreground thread is about to become idle. This hook is useful for performing low
///             priority tasks during idle time. For more information, see the ForegroundIdleProc hook procedure. </td> </tr>
///             <tr> <td width="40%"><a id="WH_GETMESSAGE"></a><a id="wh_getmessage"></a><dl> <dt><b>WH_GETMESSAGE</b></dt>
///             <dt>3</dt> </dl> </td> <td width="60%"> Installs a hook procedure that monitors messages posted to a message
///             queue. For more information, see the GetMsgProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_JOURNALPLAYBACK"></a><a id="wh_journalplayback"></a><dl> <dt><b>WH_JOURNALPLAYBACK</b></dt> <dt>1</dt>
///             </dl> </td> <td width="60%"> Installs a hook procedure that posts messages previously recorded by a
///             WH_JOURNALRECORD hook procedure. For more information, see the JournalPlaybackProc hook procedure. </td> </tr>
///             <tr> <td width="40%"><a id="WH_JOURNALRECORD"></a><a id="wh_journalrecord"></a><dl>
///             <dt><b>WH_JOURNALRECORD</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Installs a hook procedure that records
///             input messages posted to the system message queue. This hook is useful for recording macros. For more
///             information, see the JournalRecordProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_KEYBOARD"></a><a id="wh_keyboard"></a><dl> <dt><b>WH_KEYBOARD</b></dt> <dt>2</dt> </dl> </td> <td
///             width="60%"> Installs a hook procedure that monitors keystroke messages. For more information, see the
///             KeyboardProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_KEYBOARD_LL"></a><a
///             id="wh_keyboard_ll"></a><dl> <dt><b>WH_KEYBOARD_LL</b></dt> <dt>13</dt> </dl> </td> <td width="60%"> Installs a
///             hook procedure that monitors low-level keyboard input events. For more information, see the LowLevelKeyboardProc
///             hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_MOUSE"></a><a id="wh_mouse"></a><dl>
///             <dt><b>WH_MOUSE</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> Installs a hook procedure that monitors mouse
///             messages. For more information, see the MouseProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_MOUSE_LL"></a><a id="wh_mouse_ll"></a><dl> <dt><b>WH_MOUSE_LL</b></dt> <dt>14</dt> </dl> </td> <td
///             width="60%"> Installs a hook procedure that monitors low-level mouse input events. For more information, see the
///             LowLevelMouseProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_MSGFILTER"></a><a
///             id="wh_msgfilter"></a><dl> <dt><b>WH_MSGFILTER</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> Installs a hook
///             procedure that monitors messages generated as a result of an input event in a dialog box, message box, menu, or
///             scroll bar. For more information, see the MessageProc hook procedure. </td> </tr> <tr> <td width="40%"><a
///             id="WH_SHELL"></a><a id="wh_shell"></a><dl> <dt><b>WH_SHELL</b></dt> <dt>10</dt> </dl> </td> <td width="60%">
///             Installs a hook procedure that receives notifications useful to shell applications. For more information, see the
///             ShellProc hook procedure. </td> </tr> <tr> <td width="40%"><a id="WH_SYSMSGFILTER"></a><a
///             id="wh_sysmsgfilter"></a><dl> <dt><b>WH_SYSMSGFILTER</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> Installs a
///             hook procedure that monitors messages generated as a result of an input event in a dialog box, message box, menu,
///             or scroll bar. The hook procedure monitors these messages for all applications in the same desktop as the calling
///             thread. For more information, see the SysMsgProc hook procedure. </td> </tr> </table>
///    lpfn = Type: <b>HOOKPROC</b> A pointer to the hook procedure. If the <i>dwThreadId</i> parameter is zero or specifies
///           the identifier of a thread created by a different process, the <i>lpfn</i> parameter must point to a hook
///           procedure in a DLL. Otherwise, <i>lpfn</i> can point to a hook procedure in the code associated with the current
///           process.
///    hmod = Type: <b>HINSTANCE</b> A handle to the DLL containing the hook procedure pointed to by the <i>lpfn</i> parameter.
///           The <i>hMod</i> parameter must be set to <b>NULL</b> if the <i>dwThreadId</i> parameter specifies a thread
///           created by the current process and if the hook procedure is within the code associated with the current process.
///    dwThreadId = Type: <b>DWORD</b> The identifier of the thread with which the hook procedure is to be associated. For desktop
///                 apps, if this parameter is zero, the hook procedure is associated with all existing threads running in the same
///                 desktop as the calling thread. For Windows Store apps, see the Remarks section.
///Returns:
///    Type: <b>HHOOK</b> If the function succeeds, the return value is the handle to the hook procedure. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HHOOK SetWindowsHookExW(int idHook, HOOKPROC lpfn, HINSTANCE hmod, uint dwThreadId);

///Removes a hook procedure installed in a hook chain by the SetWindowsHookEx function.
///Params:
///    hhk = Type: <b>HHOOK</b> A handle to the hook to be removed. This parameter is a hook handle obtained by a previous
///          call to SetWindowsHookEx.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL UnhookWindowsHookEx(HHOOK hhk);

///Passes the hook information to the next hook procedure in the current hook chain. A hook procedure can call this
///function either before or after processing the hook information.
///Params:
///    hhk = Type: <b>HHOOK</b> This parameter is ignored.
///    nCode = Type: <b>int</b> The hook code passed to the current hook procedure. The next hook procedure uses this code to
///            determine how to process the hook information.
///    wParam = Type: <b>WPARAM</b> The <i>wParam</i> value passed to the current hook procedure. The meaning of this parameter
///             depends on the type of hook associated with the current hook chain.
///    lParam = Type: <b>LPARAM</b> The <i>lParam</i> value passed to the current hook procedure. The meaning of this parameter
///             depends on the type of hook associated with the current hook chain.
///Returns:
///    Type: <b>LRESULT</b> This value is returned by the next hook procedure in the chain. The current hook procedure
///    must also return this value. The meaning of the return value depends on the hook type. For more information, see
///    the descriptions of the individual hook procedures.
///    
@DllImport("USER32")
LRESULT CallNextHookEx(HHOOK hhk, int nCode, WPARAM wParam, LPARAM lParam);

///Determines whether a message is intended for the specified dialog box and, if it is, processes the message.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box.
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that contains the message to be checked.
///Returns:
///    Type: <b>BOOL</b> If the message has been processed, the return value is nonzero. If the message has not been
///    processed, the return value is zero.
///    
@DllImport("USER32")
BOOL IsDialogMessageA(HWND hDlg, MSG* lpMsg);

///Determines whether a message is intended for the specified dialog box and, if it is, processes the message.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to the dialog box.
///    lpMsg = Type: <b>LPMSG</b> A pointer to an MSG structure that contains the message to be checked.
///Returns:
///    Type: <b>BOOL</b> If the message has been processed, the return value is nonzero. If the message has not been
///    processed, the return value is zero.
///    
@DllImport("USER32")
BOOL IsDialogMessageW(HWND hDlg, MSG* lpMsg);

///Converts the specified dialog box units to screen units (pixels). The function replaces the coordinates in the
///specified RECT structure with the converted coordinates, which allows the structure to be used to create a dialog box
///or position a control within a dialog box.
///Params:
///    hDlg = Type: <b>HWND</b> A handle to a dialog box. This function accepts only handles returned by one of the dialog box
///           creation functions; handles for other windows are not valid.
///    lpRect = Type: <b>LPRECT</b> A pointer to a RECT structure that contains the dialog box coordinates to be converted.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL MapDialogRect(HWND hDlg, RECT* lpRect);

///Provides default processing for any window messages that the window procedure of a multiple-document interface (MDI)
///frame window does not process. All window messages that are not explicitly processed by the window procedure must be
///passed to the <b>DefFrameProc</b> function, not the DefWindowProc function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the MDI frame window.
///    hWndMDIClient = Type: <b>HWND</b> A handle to the MDI client window.
///    uMsg = Type: <b>UINT</b> The message to be processed.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message.
///    If the <i>hWndMDIClient</i> parameter is <b>NULL</b>, the return value is the same as for the DefWindowProc
///    function.
///    
@DllImport("USER32")
LRESULT DefFrameProcA(HWND hWnd, HWND hWndMDIClient, uint uMsg, WPARAM wParam, LPARAM lParam);

///Provides default processing for any window messages that the window procedure of a multiple-document interface (MDI)
///frame window does not process. All window messages that are not explicitly processed by the window procedure must be
///passed to the <b>DefFrameProc</b> function, not the DefWindowProc function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the MDI frame window.
///    hWndMDIClient = Type: <b>HWND</b> A handle to the MDI client window.
///    uMsg = Type: <b>UINT</b> The message to be processed.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message.
///    If the <i>hWndMDIClient</i> parameter is <b>NULL</b>, the return value is the same as for the DefWindowProc
///    function.
///    
@DllImport("USER32")
LRESULT DefFrameProcW(HWND hWnd, HWND hWndMDIClient, uint uMsg, WPARAM wParam, LPARAM lParam);

///Provides default processing for any window message that the window procedure of a multiple-document interface (MDI)
///child window does not process. A window message not processed by the window procedure must be passed to the
///<b>DefMDIChildProc</b> function, not to the DefWindowProc function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the MDI child window.
///    uMsg = Type: <b>UINT</b> The message to be processed.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message.
///    
@DllImport("USER32")
LRESULT DefMDIChildProcA(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

///Provides default processing for any window message that the window procedure of a multiple-document interface (MDI)
///child window does not process. A window message not processed by the window procedure must be passed to the
///<b>DefMDIChildProc</b> function, not to the DefWindowProc function.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the MDI child window.
///    uMsg = Type: <b>UINT</b> The message to be processed.
///    wParam = Type: <b>WPARAM</b> Additional message-specific information.
///    lParam = Type: <b>LPARAM</b> Additional message-specific information.
///Returns:
///    Type: <b>LRESULT</b> The return value specifies the result of the message processing and depends on the message.
///    
@DllImport("USER32")
LRESULT DefMDIChildProcW(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

///Processes accelerator keystrokes for window menu commands of the multiple-document interface (MDI) child windows
///associated with the specified MDI client window. The function translates WM_KEYUP and WM_KEYDOWN messages to
///WM_SYSCOMMAND messages and sends them to the appropriate MDI child windows.
///Params:
///    hWndClient = Type: <b>HWND</b> A handle to the MDI client window.
///    lpMsg = Type: <b>LPMSG</b> A pointer to a message retrieved by using the GetMessage or PeekMessage function. The message
///            must be an MSG structure and contain message information from the application's message queue.
///Returns:
///    Type: <b>BOOL</b> If the message is translated into a system command, the return value is nonzero. If the message
///    is not translated into a system command, the return value is zero.
///    
@DllImport("USER32")
BOOL TranslateMDISysAccel(HWND hWndClient, MSG* lpMsg);

///Arranges all the minimized (iconic) child windows of the specified parent window.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the parent window.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the height of one row of icons. If the function
///    fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint ArrangeIconicWindows(HWND hWnd);

///Creates a multiple-document interface (MDI) child window.
///Params:
///    lpClassName = Type: <b>LPCTSTR</b> The window class of the MDI child window. The class name must have been registered by a call
///                  to the RegisterClassEx function.
///    lpWindowName = Type: <b>LPCTSTR</b> The window name. The system displays the name in the title bar of the child window.
///    dwStyle = Type: <b>DWORD</b> The style of the MDI child window. If the MDI client window is created with the
///              <b>MDIS_ALLCHILDSTYLES</b> window style, this parameter can be any combination of the window styles listed in the
///              Window Styles page. Otherwise, this parameter is limited to one or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WS_MINIMIZE"></a><a id="ws_minimize"></a><dl>
///              <dt><b>WS_MINIMIZE</b></dt> <dt>0x20000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
///              initially minimized. </td> </tr> <tr> <td width="40%"><a id="WS_MAXIMIZE"></a><a id="ws_maximize"></a><dl>
///              <dt><b>WS_MAXIMIZE</b></dt> <dt>0x01000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
///              initially maximized. </td> </tr> <tr> <td width="40%"><a id="WS_HSCROLL"></a><a id="ws_hscroll"></a><dl>
///              <dt><b>WS_HSCROLL</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
///              a horizontal scroll bar. </td> </tr> <tr> <td width="40%"><a id="WS_VSCROLL"></a><a id="ws_vscroll"></a><dl>
///              <dt><b>WS_VSCROLL</b></dt> <dt>0x00200000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
///              a vertical scroll bar. </td> </tr> </table>
///    X = Type: <b>int</b> The initial horizontal position, in client coordinates, of the MDI child window. If this
///        parameter is <b>CW_USEDEFAULT</b> ((int)0x80000000), the MDI child window is assigned the default horizontal
///        position.
///    Y = Type: <b>int</b> The initial vertical position, in client coordinates, of the MDI child window. If this parameter
///        is <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default vertical position.
///    nWidth = Type: <b>int</b> The initial width, in device units, of the MDI child window. If this parameter is
///             <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default width.
///    nHeight = Type: <b>int</b> The initial height, in device units, of the MDI child window. If this parameter is set to
///              <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default height.
///    hWndParent = Type: <b>HWND</b> A handle to the MDI client window that will be the parent of the new MDI child window.
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the application creating the MDI child window.
///    lParam = Type: <b>LPARAM</b> An application-defined value.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the handle to the created window. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND CreateMDIWindowA(const(PSTR) lpClassName, const(PSTR) lpWindowName, uint dwStyle, int X, int Y, int nWidth, 
                      int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);

///Creates a multiple-document interface (MDI) child window.
///Params:
///    lpClassName = Type: <b>LPCTSTR</b> The window class of the MDI child window. The class name must have been registered by a call
///                  to the RegisterClassEx function.
///    lpWindowName = Type: <b>LPCTSTR</b> The window name. The system displays the name in the title bar of the child window.
///    dwStyle = Type: <b>DWORD</b> The style of the MDI child window. If the MDI client window is created with the
///              <b>MDIS_ALLCHILDSTYLES</b> window style, this parameter can be any combination of the window styles listed in the
///              Window Styles page. Otherwise, this parameter is limited to one or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WS_MINIMIZE"></a><a id="ws_minimize"></a><dl>
///              <dt><b>WS_MINIMIZE</b></dt> <dt>0x20000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
///              initially minimized. </td> </tr> <tr> <td width="40%"><a id="WS_MAXIMIZE"></a><a id="ws_maximize"></a><dl>
///              <dt><b>WS_MAXIMIZE</b></dt> <dt>0x01000000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that is
///              initially maximized. </td> </tr> <tr> <td width="40%"><a id="WS_HSCROLL"></a><a id="ws_hscroll"></a><dl>
///              <dt><b>WS_HSCROLL</b></dt> <dt>0x00100000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
///              a horizontal scroll bar. </td> </tr> <tr> <td width="40%"><a id="WS_VSCROLL"></a><a id="ws_vscroll"></a><dl>
///              <dt><b>WS_VSCROLL</b></dt> <dt>0x00200000L</dt> </dl> </td> <td width="60%"> Creates an MDI child window that has
///              a vertical scroll bar. </td> </tr> </table>
///    X = Type: <b>int</b> The initial horizontal position, in client coordinates, of the MDI child window. If this
///        parameter is <b>CW_USEDEFAULT</b> ((int)0x80000000), the MDI child window is assigned the default horizontal
///        position.
///    Y = Type: <b>int</b> The initial vertical position, in client coordinates, of the MDI child window. If this parameter
///        is <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default vertical position.
///    nWidth = Type: <b>int</b> The initial width, in device units, of the MDI child window. If this parameter is
///             <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default width.
///    nHeight = Type: <b>int</b> The initial height, in device units, of the MDI child window. If this parameter is set to
///              <b>CW_USEDEFAULT</b>, the MDI child window is assigned the default height.
///    hWndParent = Type: <b>HWND</b> A handle to the MDI client window that will be the parent of the new MDI child window.
///    hInstance = Type: <b>HINSTANCE</b> A handle to the instance of the application creating the MDI child window.
///    lParam = Type: <b>LPARAM</b> An application-defined value.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the handle to the created window. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND CreateMDIWindowW(const(PWSTR) lpClassName, const(PWSTR) lpWindowName, uint dwStyle, int X, int Y, int nWidth, 
                      int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);

///Tiles the specified child windows of the specified parent window.
///Params:
///    hwndParent = Type: <b>HWND</b> A handle to the parent window. If this parameter is <b>NULL</b>, the desktop window is assumed.
///    wHow = Type: <b>UINT</b> The tiling flags. This parameter can be one of the following values—optionally combined with
///           <b>MDITILE_SKIPDISABLED</b> to prevent disabled MDI child windows from being tiled. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MDITILE_HORIZONTAL"></a><a id="mditile_horizontal"></a><dl>
///           <dt><b>MDITILE_HORIZONTAL</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Tiles windows horizontally. </td>
///           </tr> <tr> <td width="40%"><a id="MDITILE_VERTICAL"></a><a id="mditile_vertical"></a><dl>
///           <dt><b>MDITILE_VERTICAL</b></dt> <dt>0x0000</dt> </dl> </td> <td width="60%"> Tiles windows vertically. </td>
///           </tr> </table>
///    lpRect = Type: <b>const RECT*</b> A pointer to a structure that specifies the rectangular area, in client coordinates,
///             within which the windows are arranged. If this parameter is <b>NULL</b>, the client area of the parent window is
///             used.
///    cKids = Type: <b>UINT</b> The number of elements in the array specified by the <i>lpKids</i> parameter. This parameter is
///            ignored if <i>lpKids</i> is <b>NULL</b>.
///    lpKids = Type: <b>const HWND*</b> An array of handles to the child windows to arrange. If a specified child window is a
///             top-level window with the style <b>WS_EX_TOPMOST</b> or <b>WS_EX_TOOLWINDOW</b>, the child window is not
///             arranged. If this parameter is <b>NULL</b>, all child windows of the specified parent window (or of the desktop
///             window) are arranged.
///Returns:
///    Type: <b>WORD</b> If the function succeeds, the return value is the number of windows arranged. If the function
///    fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort TileWindows(HWND hwndParent, uint wHow, const(RECT)* lpRect, uint cKids, const(HWND)* lpKids);

///Cascades the specified child windows of the specified parent window.
///Params:
///    hwndParent = Type: <b>HWND</b> A handle to the parent window. If this parameter is <b>NULL</b>, the desktop window is assumed.
///    wHow = Type: <b>UINT</b> A cascade flag. This parameter can be one or more of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MDITILE_SKIPDISABLED"></a><a
///           id="mditile_skipdisabled"></a><dl> <dt><b>MDITILE_SKIPDISABLED</b></dt> <dt>0x0002</dt> </dl> </td> <td
///           width="60%"> Prevents disabled MDI child windows from being cascaded. </td> </tr> <tr> <td width="40%"><a
///           id="MDITILE_ZORDER"></a><a id="mditile_zorder"></a><dl> <dt><b>MDITILE_ZORDER</b></dt> <dt>0x0004</dt> </dl>
///           </td> <td width="60%"> Arranges the windows in Z order. If this value is not specified, the windows are arranged
///           using the order specified in the <i>lpKids</i> array. </td> </tr> </table>
///    lpRect = Type: <b>const RECT*</b> A pointer to a structure that specifies the rectangular area, in client coordinates,
///             within which the windows are arranged. This parameter can be <b>NULL</b>, in which case the client area of the
///             parent window is used.
///    cKids = Type: <b>UINT</b> The number of elements in the array specified by the <i>lpKids</i> parameter. This parameter is
///            ignored if <i>lpKids</i> is <b>NULL</b>.
///    lpKids = Type: <b>const HWND*</b> An array of handles to the child windows to arrange. If a specified child window is a
///             top-level window with the style <b>WS_EX_TOPMOST</b> or <b>WS_EX_TOOLWINDOW</b>, the child window is not
///             arranged. If this parameter is <b>NULL</b>, all child windows of the specified parent window (or of the desktop
///             window) are arranged.
///Returns:
///    Type: <b>WORD</b> If the function succeeds, the return value is the number of windows arranged. If the function
///    fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ushort CascadeWindows(HWND hwndParent, uint wHow, const(RECT)* lpRect, uint cKids, const(HWND)* lpKids);

///Retrieves or sets the value of one of the system-wide parameters. This function can also update the user profile
///while setting a parameter.
///Params:
///    uiAction = Type: <b>UINT</b> The system-wide parameter to be retrieved or set. The possible values are organized in the
///               following tables of related parameters: <ul> <li>Accessibility parameters</li> <li>Desktop parameters</li>
///               <li>Icon parameters</li> <li>Input parameters</li> <li>Menu parameters</li> <li>Power parameters</li> <li>Screen
///               saver parameters</li> <li>Time-out parameters</li> <li>UI effect parameters</li> <li>Window parameters</li> </ul>
///               The following are the accessibility parameters. <table> <tr> <th>Accessibility parameter</th> <th>Meaning</th>
///               </tr> <tr> <td width="40%"><a id="SPI_GETACCESSTIMEOUT"></a><a id="spi_getaccesstimeout"></a><dl>
///               <dt><b>SPI_GETACCESSTIMEOUT</b></dt> <dt>0x003C</dt> </dl> </td> <td width="60%"> Retrieves information about the
///               time-out period associated with the accessibility features. The <i>pvParam</i> parameter must point to an
///               ACCESSTIMEOUT structure that receives the information. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(ACCESSTIMEOUT)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETAUDIODESCRIPTION"></a><a id="spi_getaudiodescription"></a><dl> <dt><b>SPI_GETAUDIODESCRIPTION</b></dt>
///               <dt>0x0074</dt> </dl> </td> <td width="60%"> Determines whether audio descriptions are enabled or disabled. The
///               <i>pvParam</i> parameter is a pointer to an AUDIODESCRIPTION structure. Set the <b>cbSize</b> member of this
///               structure and the <i>uiParam</i> parameter to <code>sizeof(AUDIODESCRIPTION)</code>. While it is possible for
///               users who have visual impairments to hear the audio in video content, there is a lot of action in video that does
///               not have corresponding audio. Specific audio description of what is happening in a video helps these users
///               understand the content better. This flag enables you to determine whether audio descriptions have been enabled
///               and in which language. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_GETCLIENTAREAANIMATION"></a><a id="spi_getclientareaanimation"></a><dl>
///               <dt><b>SPI_GETCLIENTAREAANIMATION</b></dt> <dt>0x1042</dt> </dl> </td> <td width="60%"> Determines whether
///               animations are enabled or disabled. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that
///               receives <b>TRUE</b> if animations are enabled, or <b>FALSE</b> otherwise. Display features such as flashing,
///               blinking, flickering, and moving content can cause seizures in users with photo-sensitive epilepsy. This flag
///               enables you to determine whether such animations have been disabled in the client area. <b>Windows Server 2003
///               and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETDISABLEOVERLAPPEDCONTENT"></a><a id="spi_getdisableoverlappedcontent"></a><dl>
///               <dt><b>SPI_GETDISABLEOVERLAPPEDCONTENT</b></dt> <dt>0x1040</dt> </dl> </td> <td width="60%"> Determines whether
///               overlapped content is enabled or disabled. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that
///               receives <b>TRUE</b> if enabled, or <b>FALSE</b> otherwise. Display features such as background images, textured
///               backgrounds, water marks on documents, alpha blending, and transparency can reduce the contrast between the
///               foreground and background, making it harder for users with low vision to see objects on the screen. This flag
///               enables you to determine whether such overlapped content has been disabled. <b>Windows Server 2003 and Windows
///               XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFILTERKEYS"></a><a
///               id="spi_getfilterkeys"></a><dl> <dt><b>SPI_GETFILTERKEYS</b></dt> <dt>0x0032</dt> </dl> </td> <td width="60%">
///               Retrieves information about the FilterKeys accessibility feature. The <i>pvParam</i> parameter must point to a
///               FILTERKEYS structure that receives the information. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(FILTERKEYS)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETFOCUSBORDERHEIGHT"></a><a id="spi_getfocusborderheight"></a><dl>
///               <dt><b>SPI_GETFOCUSBORDERHEIGHT</b></dt> <dt>0x2010</dt> </dl> </td> <td width="60%"> Retrieves the height, in
///               pixels, of the top and bottom edges of the focus rectangle drawn with DrawFocusRect. The <i>pvParam</i> parameter
///               must point to a <b>UINT</b> value. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETFOCUSBORDERWIDTH"></a><a id="spi_getfocusborderwidth"></a><dl>
///               <dt><b>SPI_GETFOCUSBORDERWIDTH</b></dt> <dt>0x200E</dt> </dl> </td> <td width="60%"> Retrieves the width, in
///               pixels, of the left and right edges of the focus rectangle drawn with DrawFocusRect. The <i>pvParam</i> parameter
///               must point to a <b>UINT</b>. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETHIGHCONTRAST"></a><a id="spi_gethighcontrast"></a><dl>
///               <dt><b>SPI_GETHIGHCONTRAST</b></dt> <dt>0x0042</dt> </dl> </td> <td width="60%"> Retrieves information about the
///               HighContrast accessibility feature. The <i>pvParam</i> parameter must point to a HIGHCONTRAST structure that
///               receives the information. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(HIGHCONTRAST)</code>. For a general discussion, see Remarks. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETLOGICALDPIOVERRIDE"></a><a id="spi_getlogicaldpioverride"></a><dl>
///               <dt><b>SPI_GETLOGICALDPIOVERRIDE</b></dt> <dt>0x009E</dt> </dl> </td> <td width="60%"> Retrieves a value that
///               determines whether Windows 8 is displaying apps using the default scaling plateau for the hardware or going to
///               the next higher plateau. This value is based on the current "Make everything on your screen bigger" setting,
///               found in the <b>Ease of Access</b> section of <b>PC settings</b>: 1 is on, 0 is off. Apps can provide text and
///               image resources for each of several scaling plateaus: 100%, 140%, and 180%. Providing separate resources
///               optimized for a particular scale avoids distortion due to resizing. Windows 8 determines the appropriate scaling
///               plateau based on a number of factors, including screen size and pixel density. When "Make everything on your
///               screen bigger" is selected (SPI_GETLOGICALDPIOVERRIDE returns a value of 1), Windows uses resources from the next
///               higher plateau. For example, in the case of hardware that Windows determines should use a scale of
///               SCALE_100_PERCENT, this override causes Windows to use the SCALE_140_PERCENT scale value, assuming that it does
///               not violate other constraints. <div class="alert"><b>Note</b> You should not use this value. It might be altered
///               or unavailable in subsequent versions of Windows. Instead, use the GetScaleFactorForDevice function or the
///               DisplayProperties class to retrieve the preferred scaling factor. Desktop applications should use desktop logical
///               DPI rather than scale factor. Desktop logical DPI can be retrieved through the GetDeviceCaps function.</div>
///               <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_GETMESSAGEDURATION"></a><a
///               id="spi_getmessageduration"></a><dl> <dt><b>SPI_GETMESSAGEDURATION</b></dt> <dt>0x2016</dt> </dl> </td> <td
///               width="60%"> Retrieves the time that notification pop-ups should be displayed, in seconds. The <i>pvParam</i>
///               parameter must point to a <b>ULONG</b> that receives the message duration. Users with visual impairments or
///               cognitive conditions such as ADHD and dyslexia might need a longer time to read the text in notification
///               messages. This flag enables you to retrieve the message duration. <b>Windows Server 2003 and Windows XP/2000:
///               </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSECLICKLOCK"></a><a
///               id="spi_getmouseclicklock"></a><dl> <dt><b>SPI_GETMOUSECLICKLOCK</b></dt> <dt>0x101E</dt> </dl> </td> <td
///               width="60%"> Retrieves the state of the Mouse ClickLock feature. The <i>pvParam</i> parameter must point to a
///               <b>BOOL</b> variable that receives <b>TRUE</b> if enabled, or <b>FALSE</b> otherwise. For more information, see
///               About Mouse Input. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETMOUSECLICKLOCKTIME"></a><a id="spi_getmouseclicklocktime"></a><dl>
///               <dt><b>SPI_GETMOUSECLICKLOCKTIME</b></dt> <dt>0x2008</dt> </dl> </td> <td width="60%"> Retrieves the time delay
///               before the primary mouse button is locked. The <i>pvParam</i> parameter must point to <b>DWORD</b> that receives
///               the time delay, in milliseconds. This is only enabled if <b>SPI_SETMOUSECLICKLOCK</b> is set to <b>TRUE</b>. For
///               more information, see About Mouse Input. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr>
///               <td width="40%"><a id="SPI_GETMOUSEKEYS"></a><a id="spi_getmousekeys"></a><dl> <dt><b>SPI_GETMOUSEKEYS</b></dt>
///               <dt>0x0036</dt> </dl> </td> <td width="60%"> Retrieves information about the MouseKeys accessibility feature. The
///               <i>pvParam</i> parameter must point to a MOUSEKEYS structure that receives the information. Set the <b>cbSize</b>
///               member of this structure and the <i>uiParam</i> parameter to <code>sizeof(MOUSEKEYS)</code>. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETMOUSESONAR"></a><a id="spi_getmousesonar"></a><dl> <dt><b>SPI_GETMOUSESONAR</b></dt>
///               <dt>0x101C</dt> </dl> </td> <td width="60%"> Retrieves the state of the Mouse Sonar feature. The <i>pvParam</i>
///               parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if enabled or <b>FALSE</b> otherwise.
///               For more information, see About Mouse Input. <b>Windows 2000: </b>This parameter is not supported. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_GETMOUSEVANISH"></a><a id="spi_getmousevanish"></a><dl>
///               <dt><b>SPI_GETMOUSEVANISH</b></dt> <dt>0x1020</dt> </dl> </td> <td width="60%"> Retrieves the state of the Mouse
///               Vanish feature. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if
///               enabled or <b>FALSE</b> otherwise. For more information, see About Mouse Input. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETSCREENREADER"></a><a
///               id="spi_getscreenreader"></a><dl> <dt><b>SPI_GETSCREENREADER</b></dt> <dt>0x0046</dt> </dl> </td> <td
///               width="60%"> Determines whether a screen reviewer utility is running. A screen reviewer utility directs textual
///               information to an output device, such as a speech synthesizer or Braille display. When this flag is set, an
///               application should provide textual information in situations where it would otherwise present the information
///               graphically. The <i>pvParam</i> parameter is a pointer to a <b>BOOL</b>variable that receives <b>TRUE</b> if a
///               screen reviewer utility is running, or <b>FALSE</b> otherwise. <div class="alert"><b>Note</b> Narrator, the
///               screen reader that is included with Windows, does not set the <b>SPI_SETSCREENREADER</b> or
///               <b>SPI_GETSCREENREADER</b> flags.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSERIALKEYS"></a><a id="spi_getserialkeys"></a><dl> <dt><b>SPI_GETSERIALKEYS</b></dt> <dt>0x003E</dt>
///               </dl> </td> <td width="60%"> This parameter is not supported. <b>Windows Server 2003 and Windows XP/2000: </b>The
///               user should control this setting through the Control Panel. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSHOWSOUNDS"></a><a id="spi_getshowsounds"></a><dl> <dt><b>SPI_GETSHOWSOUNDS</b></dt> <dt>0x0038</dt>
///               </dl> </td> <td width="60%"> Determines whether the Show Sounds accessibility flag is on or off. If it is on, the
///               user requires an application to present information visually in situations where it would otherwise present the
///               information only in audible form. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives
///               <b>TRUE</b> if the feature is on, or <b>FALSE</b> if it is off. Using this value is equivalent to calling
///               GetSystemMetrics with <b>SM_SHOWSOUNDS</b>. That is the recommended call. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSOUNDSENTRY"></a><a id="spi_getsoundsentry"></a><dl> <dt><b>SPI_GETSOUNDSENTRY</b></dt>
///               <dt>0x0040</dt> </dl> </td> <td width="60%"> Retrieves information about the SoundSentry accessibility feature.
///               The <i>pvParam</i> parameter must point to a SOUNDSENTRY structure that receives the information. Set the
///               <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(SOUNDSENTRY)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETSTICKYKEYS"></a><a id="spi_getstickykeys"></a><dl>
///               <dt><b>SPI_GETSTICKYKEYS</b></dt> <dt>0x003A</dt> </dl> </td> <td width="60%"> Retrieves information about the
///               StickyKeys accessibility feature. The <i>pvParam</i> parameter must point to a STICKYKEYS structure that receives
///               the information. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(STICKYKEYS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_GETTOGGLEKEYS"></a><a
///               id="spi_gettogglekeys"></a><dl> <dt><b>SPI_GETTOGGLEKEYS</b></dt> <dt>0x0034</dt> </dl> </td> <td width="60%">
///               Retrieves information about the ToggleKeys accessibility feature. The <i>pvParam</i> parameter must point to a
///               TOGGLEKEYS structure that receives the information. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(TOGGLEKEYS)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETACCESSTIMEOUT"></a><a id="spi_setaccesstimeout"></a><dl> <dt><b>SPI_SETACCESSTIMEOUT</b></dt>
///               <dt>0x003D</dt> </dl> </td> <td width="60%"> Sets the time-out period associated with the accessibility features.
///               The <i>pvParam</i> parameter must point to an ACCESSTIMEOUT structure that contains the new parameters. Set the
///               <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(ACCESSTIMEOUT)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETAUDIODESCRIPTION"></a><a id="spi_setaudiodescription"></a><dl>
///               <dt><b>SPI_SETAUDIODESCRIPTION</b></dt> <dt>0x0075</dt> </dl> </td> <td width="60%"> Turns the audio descriptions
///               feature on or off. The <i>pvParam</i> parameter is a pointer to an AUDIODESCRIPTION structure. While it is
///               possible for users who are visually impaired to hear the audio in video content, there is a lot of action in
///               video that does not have corresponding audio. Specific audio description of what is happening in a video helps
///               these users understand the content better. This flag enables you to enable or disable audio descriptions in the
///               languages they are provided in. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETCLIENTAREAANIMATION"></a><a
///               id="spi_setclientareaanimation"></a><dl> <dt><b>SPI_SETCLIENTAREAANIMATION</b></dt> <dt>0x1043</dt> </dl> </td>
///               <td width="60%"> Turns client area animations on or off. The <i>pvParam</i> parameter is a <b>BOOL</b> variable.
///               Set <i>pvParam</i> to <b>TRUE</b> to enable animations and other transient effects in the client area, or
///               <b>FALSE</b> to disable them. Display features such as flashing, blinking, flickering, and moving content can
///               cause seizures in users with photo-sensitive epilepsy. This flag enables you to enable or disable all such
///               animations. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETDISABLEOVERLAPPEDCONTENT"></a><a id="spi_setdisableoverlappedcontent"></a><dl>
///               <dt><b>SPI_SETDISABLEOVERLAPPEDCONTENT</b></dt> <dt>0x1041</dt> </dl> </td> <td width="60%"> Turns overlapped
///               content (such as background images and watermarks) on or off. The <i>pvParam</i> parameter is a <b>BOOL</b>
///               variable. Set <i>pvParam</i> to <b>TRUE</b> to disable overlapped content, or <b>FALSE</b> to enable overlapped
///               content. Display features such as background images, textured backgrounds, water marks on documents, alpha
///               blending, and transparency can reduce the contrast between the foreground and background, making it harder for
///               users with low vision to see objects on the screen. This flag enables you to enable or disable all such
///               overlapped content. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETFILTERKEYS"></a><a id="spi_setfilterkeys"></a><dl>
///               <dt><b>SPI_SETFILTERKEYS</b></dt> <dt>0x0033</dt> </dl> </td> <td width="60%"> Sets the parameters of the
///               FilterKeys accessibility feature. The <i>pvParam</i> parameter must point to a FILTERKEYS structure that contains
///               the new parameters. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(FILTERKEYS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_SETFOCUSBORDERHEIGHT"></a><a
///               id="spi_setfocusborderheight"></a><dl> <dt><b>SPI_SETFOCUSBORDERHEIGHT</b></dt> <dt>0x2011</dt> </dl> </td> <td
///               width="60%"> Sets the height of the top and bottom edges of the focus rectangle drawn with DrawFocusRect to the
///               value of the <i>pvParam</i> parameter. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETFOCUSBORDERWIDTH"></a><a id="spi_setfocusborderwidth"></a><dl>
///               <dt><b>SPI_SETFOCUSBORDERWIDTH</b></dt> <dt>0x200F</dt> </dl> </td> <td width="60%"> Sets the height of the left
///               and right edges of the focus rectangle drawn with DrawFocusRect to the value of the <i>pvParam</i> parameter.
///               <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETHIGHCONTRAST"></a><a id="spi_sethighcontrast"></a><dl> <dt><b>SPI_SETHIGHCONTRAST</b></dt>
///               <dt>0x0043</dt> </dl> </td> <td width="60%"> Sets the parameters of the HighContrast accessibility feature. The
///               <i>pvParam</i> parameter must point to a HIGHCONTRAST structure that contains the new parameters. Set the
///               <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(HIGHCONTRAST)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETLOGICALDPIOVERRIDE"></a><a id="spi_setlogicaldpioverride"></a><dl>
///               <dt><b>SPI_SETLOGICALDPIOVERRIDE</b></dt> <dt>0x009F</dt> </dl> </td> <td width="60%"> Do not use. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETMESSAGEDURATION"></a><a id="spi_setmessageduration"></a><dl>
///               <dt><b>SPI_SETMESSAGEDURATION</b></dt> <dt>0x2017</dt> </dl> </td> <td width="60%"> Sets the time that
///               notification pop-ups should be displayed, in seconds. The <i>pvParam</i> parameter specifies the message
///               duration. Users with visual impairments or cognitive conditions such as ADHD and dyslexia might need a longer
///               time to read the text in notification messages. This flag enables you to set the message duration. <b>Windows
///               Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETMOUSECLICKLOCK"></a><a id="spi_setmouseclicklock"></a><dl> <dt><b>SPI_SETMOUSECLICKLOCK</b></dt>
///               <dt>0x101F</dt> </dl> </td> <td width="60%"> Turns the Mouse ClickLock accessibility feature on or off. This
///               feature temporarily locks down the primary mouse button when that button is clicked and held down for the time
///               specified by <b>SPI_SETMOUSECLICKLOCKTIME</b>. The <i>pvParam</i> parameter specifies <b>TRUE</b> for on, or
///               <b>FALSE</b> for off. The default is off. For more information, see Remarks and AboutMouse Input. <b>Windows
///               2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETMOUSECLICKLOCKTIME"></a><a id="spi_setmouseclicklocktime"></a><dl>
///               <dt><b>SPI_SETMOUSECLICKLOCKTIME</b></dt> <dt>0x2009</dt> </dl> </td> <td width="60%"> Adjusts the time delay
///               before the primary mouse button is locked. The <i>uiParam</i> parameter should be set to 0. The <i>pvParam</i>
///               parameter points to a <b>DWORD</b> that specifies the time delay in milliseconds. For example, specify 1000 for a
///               1 second delay. The default is 1200. For more information, see About Mouse Input. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETMOUSEKEYS"></a><a
///               id="spi_setmousekeys"></a><dl> <dt><b>SPI_SETMOUSEKEYS</b></dt> <dt>0x0037</dt> </dl> </td> <td width="60%"> Sets
///               the parameters of the MouseKeys accessibility feature. The <i>pvParam</i> parameter must point to a MOUSEKEYS
///               structure that contains the new parameters. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i>
///               parameter to <code>sizeof(MOUSEKEYS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_SETMOUSESONAR"></a><a
///               id="spi_setmousesonar"></a><dl> <dt><b>SPI_SETMOUSESONAR</b></dt> <dt>0x101D</dt> </dl> </td> <td width="60%">
///               Turns the Sonar accessibility feature on or off. This feature briefly shows several concentric circles around the
///               mouse pointer when the user presses and releases the CTRL key. The <i>pvParam</i> parameter specifies <b>TRUE</b>
///               for on and <b>FALSE</b> for off. The default is off. For more information, see About Mouse Input. <b>Windows
///               2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETMOUSEVANISH"></a><a
///               id="spi_setmousevanish"></a><dl> <dt><b>SPI_SETMOUSEVANISH</b></dt> <dt>0x1021</dt> </dl> </td> <td width="60%">
///               Turns the Vanish feature on or off. This feature hides the mouse pointer when the user types; the pointer
///               reappears when the user moves the mouse. The <i>pvParam</i> parameter specifies <b>TRUE</b> for on and
///               <b>FALSE</b> for off. The default is off. For more information, see About Mouse Input. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETSCREENREADER"></a><a
///               id="spi_setscreenreader"></a><dl> <dt><b>SPI_SETSCREENREADER</b></dt> <dt>0x0047</dt> </dl> </td> <td
///               width="60%"> Determines whether a screen review utility is running. The <i>uiParam</i> parameter specifies
///               <b>TRUE</b> for on, or <b>FALSE</b> for off. <div class="alert"><b>Note</b> Narrator, the screen reader that is
///               included with Windows, does not set the <b>SPI_SETSCREENREADER</b> or <b>SPI_GETSCREENREADER</b> flags.</div>
///               <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_SETSERIALKEYS"></a><a id="spi_setserialkeys"></a><dl>
///               <dt><b>SPI_SETSERIALKEYS</b></dt> <dt>0x003F</dt> </dl> </td> <td width="60%"> This parameter is not supported.
///               <b>Windows Server 2003 and Windows XP/2000: </b>The user should control this setting through the Control Panel.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETSHOWSOUNDS"></a><a id="spi_setshowsounds"></a><dl>
///               <dt><b>SPI_SETSHOWSOUNDS</b></dt> <dt>0x0039</dt> </dl> </td> <td width="60%"> Turns the ShowSounds accessibility
///               feature on or off. The <i>uiParam</i> parameter specifies <b>TRUE</b> for on, or <b>FALSE</b> for off. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_SETSOUNDSENTRY"></a><a id="spi_setsoundsentry"></a><dl>
///               <dt><b>SPI_SETSOUNDSENTRY</b></dt> <dt>0x0041</dt> </dl> </td> <td width="60%"> Sets the parameters of the
///               <b>SoundSentry</b> accessibility feature. The <i>pvParam</i> parameter must point to a SOUNDSENTRY structure that
///               contains the new parameters. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(SOUNDSENTRY)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_SETSTICKYKEYS"></a><a
///               id="spi_setstickykeys"></a><dl> <dt><b>SPI_SETSTICKYKEYS</b></dt> <dt>0x003B</dt> </dl> </td> <td width="60%">
///               Sets the parameters of the StickyKeys accessibility feature. The <i>pvParam</i> parameter must point to a
///               STICKYKEYS structure that contains the new parameters. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(STICKYKEYS)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETTOGGLEKEYS"></a><a id="spi_settogglekeys"></a><dl> <dt><b>SPI_SETTOGGLEKEYS</b></dt> <dt>0x0035</dt>
///               </dl> </td> <td width="60%"> Sets the parameters of the ToggleKeys accessibility feature. The <i>pvParam</i>
///               parameter must point to a TOGGLEKEYS structure that contains the new parameters. Set the <b>cbSize</b> member of
///               this structure and the <i>uiParam</i> parameter to <code>sizeof(TOGGLEKEYS)</code>. </td> </tr> </table> The
///               following are the desktop parameters. <table> <tr> <th>Desktop parameter</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="SPI_GETCLEARTYPE"></a><a id="spi_getcleartype"></a><dl> <dt><b>SPI_GETCLEARTYPE</b></dt>
///               <dt>0x1048</dt> </dl> </td> <td width="60%"> Determines whether ClearType is enabled. The <i>pvParam</i>
///               parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if ClearType is enabled, or <b>FALSE</b>
///               otherwise. ClearType is a software technology that improves the readability of text on liquid crystal display
///               (LCD) monitors. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr>
///               <td width="40%"><a id="SPI_GETDESKWALLPAPER"></a><a id="spi_getdeskwallpaper"></a><dl>
///               <dt><b>SPI_GETDESKWALLPAPER</b></dt> <dt>0x0073</dt> </dl> </td> <td width="60%"> Retrieves the full path of the
///               bitmap file for the desktop wallpaper. The <i>pvParam</i> parameter must point to a buffer to receive the
///               null-terminated path string. Set the <i>uiParam</i> parameter to the size, in characters, of the <i>pvParam</i>
///               buffer. The returned string will not exceed <b>MAX_PATH</b> characters. If there is no desktop wallpaper, the
///               returned string is empty. </td> </tr> <tr> <td width="40%"><a id="SPI_GETDROPSHADOW"></a><a
///               id="spi_getdropshadow"></a><dl> <dt><b>SPI_GETDROPSHADOW</b></dt> <dt>0x1024</dt> </dl> </td> <td width="60%">
///               Determines whether the drop shadow effect is enabled. The <i>pvParam</i> parameter must point to a <b>BOOL</b>
///               variable that returns <b>TRUE</b> if enabled or <b>FALSE</b> if disabled. <b>Windows 2000: </b>This parameter is
///               not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFLATMENU"></a><a id="spi_getflatmenu"></a><dl>
///               <dt><b>SPI_GETFLATMENU</b></dt> <dt>0x1022</dt> </dl> </td> <td width="60%"> Determines whether native User menus
///               have flat menu appearance. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that returns
///               <b>TRUE</b> if the flat menu appearance is set, or <b>FALSE</b> otherwise. <b>Windows 2000: </b>This parameter is
///               not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFONTSMOOTHING"></a><a
///               id="spi_getfontsmoothing"></a><dl> <dt><b>SPI_GETFONTSMOOTHING</b></dt> <dt>0x004A</dt> </dl> </td> <td
///               width="60%"> Determines whether the font smoothing feature is enabled. This feature uses font antialiasing to
///               make font curves appear smoother by painting pixels at different gray levels. The <i>pvParam</i> parameter must
///               point to a <b>BOOL</b> variable that receives <b>TRUE</b> if the feature is enabled, or <b>FALSE</b> if it is
///               not. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFONTSMOOTHINGCONTRAST"></a><a
///               id="spi_getfontsmoothingcontrast"></a><dl> <dt><b>SPI_GETFONTSMOOTHINGCONTRAST</b></dt> <dt>0x200C</dt> </dl>
///               </td> <td width="60%"> Retrieves a contrast value that is used in ClearType smoothing. The <i>pvParam</i>
///               parameter must point to a <b>UINT</b> that receives the information. Valid contrast values are from 1000 to 2200.
///               The default value is 1400. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETFONTSMOOTHINGORIENTATION"></a><a id="spi_getfontsmoothingorientation"></a><dl>
///               <dt><b>SPI_GETFONTSMOOTHINGORIENTATION</b></dt> <dt>0x2012</dt> </dl> </td> <td width="60%"> Retrieves the font
///               smoothing orientation. The <i>pvParam</i> parameter must point to a <b>UINT</b> that receives the information.
///               The possible values are <b>FE_FONTSMOOTHINGORIENTATIONBGR</b> (blue-green-red) and
///               <b>FE_FONTSMOOTHINGORIENTATIONRGB</b> (red-green-blue). <b>Windows XP/2000: </b>This parameter is not supported
///               until Windows XP with SP2. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFONTSMOOTHINGTYPE"></a><a
///               id="spi_getfontsmoothingtype"></a><dl> <dt><b>SPI_GETFONTSMOOTHINGTYPE</b></dt> <dt>0x200A</dt> </dl> </td> <td
///               width="60%"> Retrieves the type of font smoothing. The <i>pvParam</i> parameter must point to a <b>UINT</b> that
///               receives the information. The possible values are <b>FE_FONTSMOOTHINGSTANDARD</b> and
///               <b>FE_FONTSMOOTHINGCLEARTYPE</b>. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETWORKAREA"></a><a id="spi_getworkarea"></a><dl> <dt><b>SPI_GETWORKAREA</b></dt>
///               <dt>0x0030</dt> </dl> </td> <td width="60%"> Retrieves the size of the work area on the primary display monitor.
///               The work area is the portion of the screen not obscured by the system taskbar or by application desktop toolbars.
///               The <i>pvParam</i> parameter must point to a RECT structure that receives the coordinates of the work area,
///               expressed in physical pixel size. Any DPI virtualization mode of the caller has no effect on this output. To get
///               the work area of a monitor other than the primary display monitor, call the GetMonitorInfo function. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETCLEARTYPE"></a><a id="spi_setcleartype"></a><dl>
///               <dt><b>SPI_SETCLEARTYPE</b></dt> <dt>0x1049</dt> </dl> </td> <td width="60%"> Turns ClearType on or off. The
///               <i>pvParam</i> parameter is a <b>BOOL</b> variable. Set <i>pvParam</i> to <b>TRUE</b> to enable ClearType, or
///               <b>FALSE</b> to disable it. ClearType is a software technology that improves the readability of text on LCD
///               monitors. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETCURSORS"></a><a id="spi_setcursors"></a><dl> <dt><b>SPI_SETCURSORS</b></dt>
///               <dt>0x0057</dt> </dl> </td> <td width="60%"> Reloads the system cursors. Set the <i>uiParam</i> parameter to zero
///               and the <i>pvParam</i> parameter to <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETDESKPATTERN"></a><a id="spi_setdeskpattern"></a><dl> <dt><b>SPI_SETDESKPATTERN</b></dt>
///               <dt>0x0015</dt> </dl> </td> <td width="60%"> Sets the current desktop pattern by causing Windows to read the
///               <b>Pattern=</b> setting from the WIN.INI file. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETDESKWALLPAPER"></a><a id="spi_setdeskwallpaper"></a><dl> <dt><b>SPI_SETDESKWALLPAPER</b></dt>
///               <dt>0x0014</dt> </dl> </td> <td width="60%"> <div class="alert"><b>Note</b> When the <b>SPI_SETDESKWALLPAPER</b>
///               flag is used, <b>SystemParametersInfo</b> returns <b>TRUE</b> unless there is an error (like when the specified
///               file doesn't exist).</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_SETDROPSHADOW"></a><a
///               id="spi_setdropshadow"></a><dl> <dt><b>SPI_SETDROPSHADOW</b></dt> <dt>0x1025</dt> </dl> </td> <td width="60%">
///               Enables or disables the drop shadow effect. Set <i>pvParam</i> to <b>TRUE</b> to enable the drop shadow effect or
///               <b>FALSE</b> to disable it. You must also have <b>CS_DROPSHADOW</b> in the window class style. <b>Windows 2000:
///               </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETFLATMENU"></a><a
///               id="spi_setflatmenu"></a><dl> <dt><b>SPI_SETFLATMENU</b></dt> <dt>0x1023</dt> </dl> </td> <td width="60%">
///               Enables or disables flat menu appearance for native User menus. Set <i>pvParam</i> to <b>TRUE</b> to enable flat
///               menu appearance or <b>FALSE</b> to disable it. When enabled, the menu bar uses <b>COLOR_MENUBAR</b> for the
///               menubar background, <b>COLOR_MENU</b> for the menu-popup background, <b>COLOR_MENUHILIGHT</b> for the fill of the
///               current menu selection, and <b>COLOR_HILIGHT</b> for the outline of the current menu selection. If disabled,
///               menus are drawn using the same metrics and colors as in Windows 2000. <b>Windows 2000: </b>This parameter is not
///               supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETFONTSMOOTHING"></a><a
///               id="spi_setfontsmoothing"></a><dl> <dt><b>SPI_SETFONTSMOOTHING</b></dt> <dt>0x004B</dt> </dl> </td> <td
///               width="60%"> Enables or disables the font smoothing feature, which uses font antialiasing to make font curves
///               appear smoother by painting pixels at different gray levels. To enable the feature, set the <i>uiParam</i>
///               parameter to <b>TRUE</b>. To disable the feature, set <i>uiParam</i> to <b>FALSE</b>. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETFONTSMOOTHINGCONTRAST"></a><a id="spi_setfontsmoothingcontrast"></a><dl>
///               <dt><b>SPI_SETFONTSMOOTHINGCONTRAST</b></dt> <dt>0x200D</dt> </dl> </td> <td width="60%"> Sets the contrast value
///               used in ClearType smoothing. The <i>pvParam</i> parameter is the contrast value. Valid contrast values are from
///               1000 to 2200. The default value is 1400. <b>SPI_SETFONTSMOOTHINGTYPE</b> must also be set to
///               <b>FE_FONTSMOOTHINGCLEARTYPE</b>. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETFONTSMOOTHINGORIENTATION"></a><a id="spi_setfontsmoothingorientation"></a><dl>
///               <dt><b>SPI_SETFONTSMOOTHINGORIENTATION</b></dt> <dt>0x2013</dt> </dl> </td> <td width="60%"> Sets the font
///               smoothing orientation. The <i>pvParam</i> parameter is either <b>FE_FONTSMOOTHINGORIENTATIONBGR</b>
///               (blue-green-red) or <b>FE_FONTSMOOTHINGORIENTATIONRGB</b> (red-green-blue). <b>Windows XP/2000: </b>This
///               parameter is not supported until Windows XP with SP2. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETFONTSMOOTHINGTYPE"></a><a id="spi_setfontsmoothingtype"></a><dl>
///               <dt><b>SPI_SETFONTSMOOTHINGTYPE</b></dt> <dt>0x200B</dt> </dl> </td> <td width="60%"> Sets the font smoothing
///               type. The <i>pvParam</i> parameter is either <b>FE_FONTSMOOTHINGSTANDARD</b>, if standard anti-aliasing is used,
///               or <b>FE_FONTSMOOTHINGCLEARTYPE</b>, if ClearType is used. The default is <b>FE_FONTSMOOTHINGSTANDARD</b>.
///               <b>SPI_SETFONTSMOOTHING</b> must also be set. <b>Windows 2000: </b>This parameter is not supported. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETWORKAREA"></a><a id="spi_setworkarea"></a><dl> <dt><b>SPI_SETWORKAREA</b></dt>
///               <dt>0x002F</dt> </dl> </td> <td width="60%"> Sets the size of the work area. The work area is the portion of the
///               screen not obscured by the system taskbar or by application desktop toolbars. The <i>pvParam</i> parameter is a
///               pointer to a RECT structure that specifies the new work area rectangle, expressed in virtual screen coordinates.
///               In a system with multiple display monitors, the function sets the work area of the monitor that contains the
///               specified rectangle. </td> </tr> </table> The following are the icon parameters. <table> <tr> <th>Icon
///               parameter</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SPI_GETICONMETRICS"></a><a
///               id="spi_geticonmetrics"></a><dl> <dt><b>SPI_GETICONMETRICS</b></dt> <dt>0x002D</dt> </dl> </td> <td width="60%">
///               Retrieves the metrics associated with icons. The <i>pvParam</i> parameter must point to an ICONMETRICS structure
///               that receives the information. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(ICONMETRICS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_GETICONTITLELOGFONT"></a><a
///               id="spi_geticontitlelogfont"></a><dl> <dt><b>SPI_GETICONTITLELOGFONT</b></dt> <dt>0x001F</dt> </dl> </td> <td
///               width="60%"> Retrieves the logical font information for the current icon-title font. The <i>uiParam</i> parameter
///               specifies the size of a LOGFONT structure, and the <i>pvParam</i> parameter must point to the <b>LOGFONT</b>
///               structure to fill in. </td> </tr> <tr> <td width="40%"><a id="SPI_GETICONTITLEWRAP"></a><a
///               id="spi_geticontitlewrap"></a><dl> <dt><b>SPI_GETICONTITLEWRAP</b></dt> <dt>0x0019</dt> </dl> </td> <td
///               width="60%"> Determines whether icon-title wrapping is enabled. The <i>pvParam</i> parameter must point to a
///               <b>BOOL</b> variable that receives <b>TRUE</b> if enabled, or <b>FALSE</b> otherwise. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_ICONHORIZONTALSPACING"></a><a id="spi_iconhorizontalspacing"></a><dl>
///               <dt><b>SPI_ICONHORIZONTALSPACING</b></dt> <dt>0x000D</dt> </dl> </td> <td width="60%"> Sets or retrieves the
///               width, in pixels, of an icon cell. The system uses this rectangle to arrange icons in large icon view. To set
///               this value, set <i>uiParam</i> to the new value and set <i>pvParam</i> to <b>NULL</b>. You cannot set this value
///               to less than <b>SM_CXICON</b>. To retrieve this value, <i>pvParam</i> must point to an integer that receives the
///               current value. </td> </tr> <tr> <td width="40%"><a id="SPI_ICONVERTICALSPACING"></a><a
///               id="spi_iconverticalspacing"></a><dl> <dt><b>SPI_ICONVERTICALSPACING</b></dt> <dt>0x0018</dt> </dl> </td> <td
///               width="60%"> Sets or retrieves the height, in pixels, of an icon cell. To set this value, set <i>uiParam</i> to
///               the new value and set <i>pvParam</i> to <b>NULL</b>. You cannot set this value to less than <b>SM_CYICON</b>. To
///               retrieve this value, <i>pvParam</i> must point to an integer that receives the current value. </td> </tr> <tr>
///               <td width="40%"><a id="SPI_SETICONMETRICS"></a><a id="spi_seticonmetrics"></a><dl>
///               <dt><b>SPI_SETICONMETRICS</b></dt> <dt>0x002E</dt> </dl> </td> <td width="60%"> Sets the metrics associated with
///               icons. The <i>pvParam</i> parameter must point to an ICONMETRICS structure that contains the new parameters. Set
///               the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(ICONMETRICS)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETICONS"></a><a id="spi_seticons"></a><dl>
///               <dt><b>SPI_SETICONS</b></dt> <dt>0x0058</dt> </dl> </td> <td width="60%"> Reloads the system icons. Set the
///               <i>uiParam</i> parameter to zero and the <i>pvParam</i> parameter to <b>NULL</b>. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETICONTITLELOGFONT"></a><a id="spi_seticontitlelogfont"></a><dl>
///               <dt><b>SPI_SETICONTITLELOGFONT</b></dt> <dt>0x0022</dt> </dl> </td> <td width="60%"> Sets the font that is used
///               for icon titles. The <i>uiParam</i> parameter specifies the size of a LOGFONT structure, and the <i>pvParam</i>
///               parameter must point to a <b>LOGFONT</b> structure. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETICONTITLEWRAP"></a><a id="spi_seticontitlewrap"></a><dl> <dt><b>SPI_SETICONTITLEWRAP</b></dt>
///               <dt>0x001A</dt> </dl> </td> <td width="60%"> Turns icon-title wrapping on or off. The <i>uiParam</i> parameter
///               specifies <b>TRUE</b> for on, or <b>FALSE</b> for off. </td> </tr> </table> The following are the input
///               parameters. They include parameters related to the keyboard, mouse, pen, input language, and the warning beeper.
///               <table> <tr> <th>Input parameter</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SPI_GETBEEP"></a><a
///               id="spi_getbeep"></a><dl> <dt><b>SPI_GETBEEP</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Determines
///               whether the warning beeper is on. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives
///               <b>TRUE</b> if the beeper is on, or <b>FALSE</b> if it is off. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETBLOCKSENDINPUTRESETS"></a><a id="spi_getblocksendinputresets"></a><dl>
///               <dt><b>SPI_GETBLOCKSENDINPUTRESETS</b></dt> <dt>0x1026</dt> </dl> </td> <td width="60%"> Retrieves a <b>BOOL</b>
///               indicating whether an application can reset the screensaver's timer by calling the SendInput function to simulate
///               keyboard or mouse input. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives
///               <b>TRUE</b> if the simulated input will be blocked, or <b>FALSE</b> otherwise. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETCONTACTVISUALIZATION"></a><a id="spi_getcontactvisualization"></a><dl>
///               <dt><b>SPI_GETCONTACTVISUALIZATION</b></dt> <dt>0x2018</dt> </dl> </td> <td width="60%"> Retrieves the current
///               contact visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that receives
///               the setting. For more information, see Contact Visualization. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETDEFAULTINPUTLANG"></a><a id="spi_getdefaultinputlang"></a><dl> <dt><b>SPI_GETDEFAULTINPUTLANG</b></dt>
///               <dt>0x0059</dt> </dl> </td> <td width="60%"> Retrieves the input locale identifier for the system default input
///               language. The <i>pvParam</i> parameter must point to an <b>HKL</b> variable that receives this value. For more
///               information, see Languages, Locales, and Keyboard Layouts. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETGESTUREVISUALIZATION"></a><a id="spi_getgesturevisualization"></a><dl>
///               <dt><b>SPI_GETGESTUREVISUALIZATION</b></dt> <dt>0x201A</dt> </dl> </td> <td width="60%"> Retrieves the current
///               gesture visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that receives
///               the setting. For more information, see Gesture Visualization. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETKEYBOARDCUES"></a><a id="spi_getkeyboardcues"></a><dl> <dt><b>SPI_GETKEYBOARDCUES</b></dt>
///               <dt>0x100A</dt> </dl> </td> <td width="60%"> Determines whether menu access keys are always underlined. The
///               <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if menu access keys are
///               always underlined, and <b>FALSE</b> if they are underlined only when the menu is activated by the keyboard. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_GETKEYBOARDDELAY"></a><a id="spi_getkeyboarddelay"></a><dl>
///               <dt><b>SPI_GETKEYBOARDDELAY</b></dt> <dt>0x0016</dt> </dl> </td> <td width="60%"> Retrieves the keyboard
///               repeat-delay setting, which is a value in the range from 0 (approximately 250 ms delay) through 3 (approximately
///               1 second delay). The actual delay associated with each value may vary depending on the hardware. The
///               <i>pvParam</i> parameter must point to an integer variable that receives the setting. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETKEYBOARDPREF"></a><a id="spi_getkeyboardpref"></a><dl>
///               <dt><b>SPI_GETKEYBOARDPREF</b></dt> <dt>0x0044</dt> </dl> </td> <td width="60%"> Determines whether the user
///               relies on the keyboard instead of the mouse, and wants applications to display keyboard interfaces that would
///               otherwise be hidden. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b>
///               if the user relies on the keyboard; or <b>FALSE</b> otherwise. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETKEYBOARDSPEED"></a><a id="spi_getkeyboardspeed"></a><dl> <dt><b>SPI_GETKEYBOARDSPEED</b></dt>
///               <dt>0x000A</dt> </dl> </td> <td width="60%"> Retrieves the keyboard repeat-speed setting, which is a value in the
///               range from 0 (approximately 2.5 repetitions per second) through 31 (approximately 30 repetitions per second). The
///               actual repeat rates are hardware-dependent and may vary from a linear scale by as much as 20%. The <i>pvParam</i>
///               parameter must point to a <b>DWORD</b> variable that receives the setting. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETMOUSE"></a><a id="spi_getmouse"></a><dl> <dt><b>SPI_GETMOUSE</b></dt> <dt>0x0003</dt> </dl> </td> <td
///               width="60%"> Retrieves the two mouse threshold values and the mouse acceleration. The <i>pvParam</i> parameter
///               must point to an array of three integers that receives these values. See mouse_event for further information.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEHOVERHEIGHT"></a><a id="spi_getmousehoverheight"></a><dl>
///               <dt><b>SPI_GETMOUSEHOVERHEIGHT</b></dt> <dt>0x0064</dt> </dl> </td> <td width="60%"> Retrieves the height, in
///               pixels, of the rectangle within which the mouse pointer has to stay for TrackMouseEvent to generate a
///               WM_MOUSEHOVER message. The <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the
///               height. </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEHOVERTIME"></a><a id="spi_getmousehovertime"></a><dl>
///               <dt><b>SPI_GETMOUSEHOVERTIME</b></dt> <dt>0x0066</dt> </dl> </td> <td width="60%"> Retrieves the time, in
///               milliseconds, that the mouse pointer has to stay in the hover rectangle for TrackMouseEvent to generate a
///               WM_MOUSEHOVER message. The <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the time.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEHOVERWIDTH"></a><a id="spi_getmousehoverwidth"></a><dl>
///               <dt><b>SPI_GETMOUSEHOVERWIDTH</b></dt> <dt>0x0062</dt> </dl> </td> <td width="60%"> Retrieves the width, in
///               pixels, of the rectangle within which the mouse pointer has to stay for TrackMouseEvent to generate a
///               WM_MOUSEHOVER message. The <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the width.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSESPEED"></a><a id="spi_getmousespeed"></a><dl>
///               <dt><b>SPI_GETMOUSESPEED</b></dt> <dt>0x0070</dt> </dl> </td> <td width="60%"> Retrieves the current mouse speed.
///               The mouse speed determines how far the pointer will move based on the distance the mouse moves. The
///               <i>pvParam</i> parameter must point to an integer that receives a value which ranges between 1 (slowest) and 20
///               (fastest). A value of 10 is the default. The value can be set by an end-user using the mouse control panel
///               application or by an application using <b>SPI_SETMOUSESPEED</b>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETMOUSETRAILS"></a><a id="spi_getmousetrails"></a><dl> <dt><b>SPI_GETMOUSETRAILS</b></dt>
///               <dt>0x005E</dt> </dl> </td> <td width="60%"> Determines whether the Mouse Trails feature is enabled. This feature
///               improves the visibility of mouse cursor movements by briefly showing a trail of cursors and quickly erasing them.
///               The <i>pvParam</i> parameter must point to an integer variable that receives a value. if the value is zero or 1,
///               the feature is disabled. If the value is greater than 1, the feature is enabled and the value indicates the
///               number of cursors drawn in the trail. The <i>uiParam</i> parameter is not used. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEWHEELROUTING"></a><a
///               id="spi_getmousewheelrouting"></a><dl> <dt><b>SPI_GETMOUSEWHEELROUTING</b></dt> <dt>0x201C</dt> </dl> </td> <td
///               width="60%"> Retrieves the routing setting for wheel button input. The routing setting determines whether wheel
///               button input is sent to the app with focus (foreground) or the app under the mouse cursor. The <i>pvParam</i>
///               parameter must point to a <b>DWORD</b> variable that receives the routing option. If the value is zero or
///               MOUSEWHEEL_ROUTING_FOCUS, mouse wheel input is delivered to the app with focus. If the value is 1 or
///               MOUSEWHEEL_ROUTING_HYBRID (default), mouse wheel input is delivered to the app with focus (desktop apps) or the
///               app under the mouse cursor (Windows Store apps). The <i>uiParam</i> parameter is not used. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETPENVISUALIZATION"></a><a id="spi_getpenvisualization"></a><dl>
///               <dt><b>SPI_GETPENVISUALIZATION</b></dt> <dt>0x201E</dt> </dl> </td> <td width="60%"> Retrieves the current pen
///               gesture visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that receives
///               the setting. For more information, see Pen Visualization. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSNAPTODEFBUTTON"></a><a id="spi_getsnaptodefbutton"></a><dl> <dt><b>SPI_GETSNAPTODEFBUTTON</b></dt>
///               <dt>0x005F</dt> </dl> </td> <td width="60%"> Determines whether the snap-to-default-button feature is enabled. If
///               enabled, the mouse cursor automatically moves to the default button, such as <b>OK</b> or <b>Apply</b>, of a
///               dialog box. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if the
///               feature is on, or <b>FALSE</b> if it is off. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSYSTEMLANGUAGEBAR"></a><a id="spi_getsystemlanguagebar"></a><dl>
///               <dt><b>SPI_GETSYSTEMLANGUAGEBAR</b></dt> <dt>0x1050</dt> </dl> </td> <td width="60%"> <b>Starting with Windows
///               8:</b> Determines whether the system language bar is enabled or disabled. The <i>pvParam</i> parameter must point
///               to a <b>BOOL</b> variable that receives <b>TRUE</b> if the language bar is enabled, or <b>FALSE</b> otherwise.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETTHREADLOCALINPUTSETTINGS"></a><a
///               id="spi_getthreadlocalinputsettings"></a><dl> <dt><b>SPI_GETTHREADLOCALINPUTSETTINGS</b></dt> <dt>0x104E</dt>
///               </dl> </td> <td width="60%"> <b>Starting with Windows 8:</b> Determines whether the active input settings have
///               Local (per-thread, <b>TRUE</b>) or Global (session, <b>FALSE</b>) scope. The <i>pvParam</i> parameter must point
///               to a <b>BOOL</b> variable. </td> </tr> <tr> <td width="40%"><a id="SPI_GETWHEELSCROLLCHARS"></a><a
///               id="spi_getwheelscrollchars"></a><dl> <dt><b>SPI_GETWHEELSCROLLCHARS</b></dt> <dt>0x006C</dt> </dl> </td> <td
///               width="60%"> Retrieves the number of characters to scroll when the horizontal mouse wheel is moved. The
///               <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the number of lines. The default
///               value is 3. </td> </tr> <tr> <td width="40%"><a id="SPI_GETWHEELSCROLLLINES"></a><a
///               id="spi_getwheelscrolllines"></a><dl> <dt><b>SPI_GETWHEELSCROLLLINES</b></dt> <dt>0x0068</dt> </dl> </td> <td
///               width="60%"> Retrieves the number of lines to scroll when the vertical mouse wheel is moved. The <i>pvParam</i>
///               parameter must point to a <b>UINT</b> variable that receives the number of lines. The default value is 3. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_SETBEEP"></a><a id="spi_setbeep"></a><dl> <dt><b>SPI_SETBEEP</b></dt>
///               <dt>0x0002</dt> </dl> </td> <td width="60%"> Turns the warning beeper on or off. The <i>uiParam</i> parameter
///               specifies <b>TRUE</b> for on, or <b>FALSE</b> for off. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETBLOCKSENDINPUTRESETS"></a><a id="spi_setblocksendinputresets"></a><dl>
///               <dt><b>SPI_SETBLOCKSENDINPUTRESETS</b></dt> <dt>0x1027</dt> </dl> </td> <td width="60%"> Determines whether an
///               application can reset the screensaver's timer by calling the SendInput function to simulate keyboard or mouse
///               input. The <i>uiParam</i> parameter specifies <b>TRUE</b> if the screensaver will not be deactivated by simulated
///               input, or <b>FALSE</b> if the screensaver will be deactivated by simulated input. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETCONTACTVISUALIZATION"></a><a id="spi_setcontactvisualization"></a><dl>
///               <dt><b>SPI_SETCONTACTVISUALIZATION</b></dt> <dt>0x2019</dt> </dl> </td> <td width="60%"> Sets the current contact
///               visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that identifies the
///               setting. For more information, see Contact Visualization. <div class="alert"><b>Note</b> If contact
///               visualizations are disabled, gesture visualizations cannot be enabled.</div> <div> </div> </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETDEFAULTINPUTLANG"></a><a id="spi_setdefaultinputlang"></a><dl>
///               <dt><b>SPI_SETDEFAULTINPUTLANG</b></dt> <dt>0x005A</dt> </dl> </td> <td width="60%"> Sets the default input
///               language for the system shell and applications. The specified language must be displayable using the current
///               system character set. The <i>pvParam</i> parameter must point to an <b>HKL</b> variable that contains the input
///               locale identifier for the default language. For more information, see Languages, Locales, and Keyboard Layouts.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETDOUBLECLICKTIME"></a><a id="spi_setdoubleclicktime"></a><dl>
///               <dt><b>SPI_SETDOUBLECLICKTIME</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> Sets the double-click time
///               for the mouse to the value of the <i>uiParam</i> parameter. If the <i>uiParam</i> value is greater than 5000
///               milliseconds, the system sets the double-click time to 5000 milliseconds. The double-click time is the maximum
///               number of milliseconds that can occur between the first and second clicks of a double-click. You can also call
///               the SetDoubleClickTime function to set the double-click time. To get the current double-click time, call the
///               GetDoubleClickTime function. </td> </tr> <tr> <td width="40%"><a id="SPI_SETDOUBLECLKHEIGHT"></a><a
///               id="spi_setdoubleclkheight"></a><dl> <dt><b>SPI_SETDOUBLECLKHEIGHT</b></dt> <dt>0x001E</dt> </dl> </td> <td
///               width="60%"> Sets the height of the double-click rectangle to the value of the <i>uiParam</i> parameter. The
///               double-click rectangle is the rectangle within which the second click of a double-click must fall for it to be
///               registered as a double-click. To retrieve the height of the double-click rectangle, call GetSystemMetrics with
///               the <b>SM_CYDOUBLECLK</b> flag. </td> </tr> <tr> <td width="40%"><a id="SPI_SETDOUBLECLKWIDTH"></a><a
///               id="spi_setdoubleclkwidth"></a><dl> <dt><b>SPI_SETDOUBLECLKWIDTH</b></dt> <dt>0x001D</dt> </dl> </td> <td
///               width="60%"> Sets the width of the double-click rectangle to the value of the <i>uiParam</i> parameter. The
///               double-click rectangle is the rectangle within which the second click of a double-click must fall for it to be
///               registered as a double-click. To retrieve the width of the double-click rectangle, call GetSystemMetrics with the
///               <b>SM_CXDOUBLECLK</b> flag. </td> </tr> <tr> <td width="40%"><a id="SPI_SETGESTUREVISUALIZATION"></a><a
///               id="spi_setgesturevisualization"></a><dl> <dt><b>SPI_SETGESTUREVISUALIZATION</b></dt> <dt>0x201B</dt> </dl> </td>
///               <td width="60%"> Sets the current gesture visualization setting. The <i>pvParam</i> parameter must point to a
///               <b>ULONG</b> variable that identifies the setting. For more information, see Gesture Visualization. <div
///               class="alert"><b>Note</b> If contact visualizations are disabled, gesture visualizations cannot be enabled.</div>
///               <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_SETKEYBOARDCUES"></a><a
///               id="spi_setkeyboardcues"></a><dl> <dt><b>SPI_SETKEYBOARDCUES</b></dt> <dt>0x100B</dt> </dl> </td> <td
///               width="60%"> Sets the underlining of menu access key letters. The <i>pvParam</i> parameter is a <b>BOOL</b>
///               variable. Set <i>pvParam</i> to <b>TRUE</b> to always underline menu access keys, or <b>FALSE</b> to underline
///               menu access keys only when the menu is activated from the keyboard. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETKEYBOARDDELAY"></a><a id="spi_setkeyboarddelay"></a><dl> <dt><b>SPI_SETKEYBOARDDELAY</b></dt>
///               <dt>0x0017</dt> </dl> </td> <td width="60%"> Sets the keyboard repeat-delay setting. The <i>uiParam</i> parameter
///               must specify 0, 1, 2, or 3, where zero sets the shortest delay approximately 250 ms) and 3 sets the longest delay
///               (approximately 1 second). The actual delay associated with each value may vary depending on the hardware. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_SETKEYBOARDPREF"></a><a id="spi_setkeyboardpref"></a><dl>
///               <dt><b>SPI_SETKEYBOARDPREF</b></dt> <dt>0x0045</dt> </dl> </td> <td width="60%"> Sets the keyboard preference.
///               The <i>uiParam</i> parameter specifies <b>TRUE</b> if the user relies on the keyboard instead of the mouse, and
///               wants applications to display keyboard interfaces that would otherwise be hidden; <i>uiParam</i> is <b>FALSE</b>
///               otherwise. </td> </tr> <tr> <td width="40%"><a id="SPI_SETKEYBOARDSPEED"></a><a
///               id="spi_setkeyboardspeed"></a><dl> <dt><b>SPI_SETKEYBOARDSPEED</b></dt> <dt>0x000B</dt> </dl> </td> <td
///               width="60%"> Sets the keyboard repeat-speed setting. The <i>uiParam</i> parameter must specify a value in the
///               range from 0 (approximately 2.5 repetitions per second) through 31 (approximately 30 repetitions per second). The
///               actual repeat rates are hardware-dependent and may vary from a linear scale by as much as 20%. If <i>uiParam</i>
///               is greater than 31, the parameter is set to 31. </td> </tr> <tr> <td width="40%"><a id="SPI_SETLANGTOGGLE"></a><a
///               id="spi_setlangtoggle"></a><dl> <dt><b>SPI_SETLANGTOGGLE</b></dt> <dt>0x005B</dt> </dl> </td> <td width="60%">
///               Sets the hot key set for switching between input languages. The <i>uiParam</i> and <i>pvParam</i> parameters are
///               not used. The value sets the shortcut keys in the keyboard property sheets by reading the registry again. The
///               registry must be set before this flag is used. the path in the registry is <b>HKEY_CURRENT_USER</b>&
///    uiParam = Type: <b>UINT</b> A parameter whose usage and format depends on the system parameter being queried or set. For
///              more information about system-wide parameters, see the <i>uiAction</i> parameter. If not otherwise indicated, you
///              must specify zero for this parameter.
///    pvParam = Type: <b>PVOID</b> A parameter whose usage and format depends on the system parameter being queried or set. For
///              more information about system-wide parameters, see the <i>uiAction</i> parameter. If not otherwise indicated, you
///              must specify <b>NULL</b> for this parameter. For information on the <b>PVOID</b> datatype, see Windows Data
///              Types.
///    fWinIni = Type: <b>UINT</b> If a system parameter is being set, specifies whether the user profile is to be updated, and if
///              so, whether the WM_SETTINGCHANGE message is to be broadcast to all top-level windows to notify them of the
///              change. This parameter can be zero if you do not want to update the user profile or broadcast the
///              WM_SETTINGCHANGE message, or it can be one or more of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SPIF_UPDATEINIFILE"></a><a id="spif_updateinifile"></a><dl>
///              <dt><b>SPIF_UPDATEINIFILE</b></dt> </dl> </td> <td width="60%"> Writes the new system-wide parameter setting to
///              the user profile. </td> </tr> <tr> <td width="40%"><a id="SPIF_SENDCHANGE"></a><a id="spif_sendchange"></a><dl>
///              <dt><b>SPIF_SENDCHANGE</b></dt> </dl> </td> <td width="60%"> Broadcasts the WM_SETTINGCHANGE message after
///              updating the user profile. </td> </tr> <tr> <td width="40%"><a id="SPIF_SENDWININICHANGE"></a><a
///              id="spif_sendwininichange"></a><dl> <dt><b>SPIF_SENDWININICHANGE</b></dt> </dl> </td> <td width="60%"> Same as
///              <b>SPIF_SENDCHANGE</b>. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is a nonzero value. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SystemParametersInfoA(uint uiAction, uint uiParam, void* pvParam, uint fWinIni);

///Retrieves or sets the value of one of the system-wide parameters. This function can also update the user profile
///while setting a parameter.
///Params:
///    uiAction = Type: <b>UINT</b> The system-wide parameter to be retrieved or set. The possible values are organized in the
///               following tables of related parameters: <ul> <li>Accessibility parameters</li> <li>Desktop parameters</li>
///               <li>Icon parameters</li> <li>Input parameters</li> <li>Menu parameters</li> <li>Power parameters</li> <li>Screen
///               saver parameters</li> <li>Time-out parameters</li> <li>UI effect parameters</li> <li>Window parameters</li> </ul>
///               The following are the accessibility parameters. <table> <tr> <th>Accessibility parameter</th> <th>Meaning</th>
///               </tr> <tr> <td width="40%"><a id="SPI_GETACCESSTIMEOUT"></a><a id="spi_getaccesstimeout"></a><dl>
///               <dt><b>SPI_GETACCESSTIMEOUT</b></dt> <dt>0x003C</dt> </dl> </td> <td width="60%"> Retrieves information about the
///               time-out period associated with the accessibility features. The <i>pvParam</i> parameter must point to an
///               ACCESSTIMEOUT structure that receives the information. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(ACCESSTIMEOUT)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETAUDIODESCRIPTION"></a><a id="spi_getaudiodescription"></a><dl> <dt><b>SPI_GETAUDIODESCRIPTION</b></dt>
///               <dt>0x0074</dt> </dl> </td> <td width="60%"> Determines whether audio descriptions are enabled or disabled. The
///               <i>pvParam</i> parameter is a pointer to an AUDIODESCRIPTION structure. Set the <b>cbSize</b> member of this
///               structure and the <i>uiParam</i> parameter to <code>sizeof(AUDIODESCRIPTION)</code>. While it is possible for
///               users who have visual impairments to hear the audio in video content, there is a lot of action in video that does
///               not have corresponding audio. Specific audio description of what is happening in a video helps these users
///               understand the content better. This flag enables you to determine whether audio descriptions have been enabled
///               and in which language. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_GETCLIENTAREAANIMATION"></a><a id="spi_getclientareaanimation"></a><dl>
///               <dt><b>SPI_GETCLIENTAREAANIMATION</b></dt> <dt>0x1042</dt> </dl> </td> <td width="60%"> Determines whether
///               animations are enabled or disabled. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that
///               receives <b>TRUE</b> if animations are enabled, or <b>FALSE</b> otherwise. Display features such as flashing,
///               blinking, flickering, and moving content can cause seizures in users with photo-sensitive epilepsy. This flag
///               enables you to determine whether such animations have been disabled in the client area. <b>Windows Server 2003
///               and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETDISABLEOVERLAPPEDCONTENT"></a><a id="spi_getdisableoverlappedcontent"></a><dl>
///               <dt><b>SPI_GETDISABLEOVERLAPPEDCONTENT</b></dt> <dt>0x1040</dt> </dl> </td> <td width="60%"> Determines whether
///               overlapped content is enabled or disabled. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that
///               receives <b>TRUE</b> if enabled, or <b>FALSE</b> otherwise. Display features such as background images, textured
///               backgrounds, water marks on documents, alpha blending, and transparency can reduce the contrast between the
///               foreground and background, making it harder for users with low vision to see objects on the screen. This flag
///               enables you to determine whether such overlapped content has been disabled. <b>Windows Server 2003 and Windows
///               XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFILTERKEYS"></a><a
///               id="spi_getfilterkeys"></a><dl> <dt><b>SPI_GETFILTERKEYS</b></dt> <dt>0x0032</dt> </dl> </td> <td width="60%">
///               Retrieves information about the FilterKeys accessibility feature. The <i>pvParam</i> parameter must point to a
///               FILTERKEYS structure that receives the information. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(FILTERKEYS)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETFOCUSBORDERHEIGHT"></a><a id="spi_getfocusborderheight"></a><dl>
///               <dt><b>SPI_GETFOCUSBORDERHEIGHT</b></dt> <dt>0x2010</dt> </dl> </td> <td width="60%"> Retrieves the height, in
///               pixels, of the top and bottom edges of the focus rectangle drawn with DrawFocusRect. The <i>pvParam</i> parameter
///               must point to a <b>UINT</b> value. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETFOCUSBORDERWIDTH"></a><a id="spi_getfocusborderwidth"></a><dl>
///               <dt><b>SPI_GETFOCUSBORDERWIDTH</b></dt> <dt>0x200E</dt> </dl> </td> <td width="60%"> Retrieves the width, in
///               pixels, of the left and right edges of the focus rectangle drawn with DrawFocusRect. The <i>pvParam</i> parameter
///               must point to a <b>UINT</b>. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETHIGHCONTRAST"></a><a id="spi_gethighcontrast"></a><dl>
///               <dt><b>SPI_GETHIGHCONTRAST</b></dt> <dt>0x0042</dt> </dl> </td> <td width="60%"> Retrieves information about the
///               HighContrast accessibility feature. The <i>pvParam</i> parameter must point to a HIGHCONTRAST structure that
///               receives the information. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(HIGHCONTRAST)</code>. For a general discussion, see Remarks. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETLOGICALDPIOVERRIDE"></a><a id="spi_getlogicaldpioverride"></a><dl>
///               <dt><b>SPI_GETLOGICALDPIOVERRIDE</b></dt> <dt>0x009E</dt> </dl> </td> <td width="60%"> Retrieves a value that
///               determines whether Windows 8 is displaying apps using the default scaling plateau for the hardware or going to
///               the next higher plateau. This value is based on the current "Make everything on your screen bigger" setting,
///               found in the <b>Ease of Access</b> section of <b>PC settings</b>: 1 is on, 0 is off. Apps can provide text and
///               image resources for each of several scaling plateaus: 100%, 140%, and 180%. Providing separate resources
///               optimized for a particular scale avoids distortion due to resizing. Windows 8 determines the appropriate scaling
///               plateau based on a number of factors, including screen size and pixel density. When "Make everything on your
///               screen bigger" is selected (SPI_GETLOGICALDPIOVERRIDE returns a value of 1), Windows uses resources from the next
///               higher plateau. For example, in the case of hardware that Windows determines should use a scale of
///               SCALE_100_PERCENT, this override causes Windows to use the SCALE_140_PERCENT scale value, assuming that it does
///               not violate other constraints. <div class="alert"><b>Note</b> You should not use this value. It might be altered
///               or unavailable in subsequent versions of Windows. Instead, use the GetScaleFactorForDevice function or the
///               DisplayProperties class to retrieve the preferred scaling factor. Desktop applications should use desktop logical
///               DPI rather than scale factor. Desktop logical DPI can be retrieved through the GetDeviceCaps function.</div>
///               <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_GETMESSAGEDURATION"></a><a
///               id="spi_getmessageduration"></a><dl> <dt><b>SPI_GETMESSAGEDURATION</b></dt> <dt>0x2016</dt> </dl> </td> <td
///               width="60%"> Retrieves the time that notification pop-ups should be displayed, in seconds. The <i>pvParam</i>
///               parameter must point to a <b>ULONG</b> that receives the message duration. Users with visual impairments or
///               cognitive conditions such as ADHD and dyslexia might need a longer time to read the text in notification
///               messages. This flag enables you to retrieve the message duration. <b>Windows Server 2003 and Windows XP/2000:
///               </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSECLICKLOCK"></a><a
///               id="spi_getmouseclicklock"></a><dl> <dt><b>SPI_GETMOUSECLICKLOCK</b></dt> <dt>0x101E</dt> </dl> </td> <td
///               width="60%"> Retrieves the state of the Mouse ClickLock feature. The <i>pvParam</i> parameter must point to a
///               <b>BOOL</b> variable that receives <b>TRUE</b> if enabled, or <b>FALSE</b> otherwise. For more information, see
///               About Mouse Input. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETMOUSECLICKLOCKTIME"></a><a id="spi_getmouseclicklocktime"></a><dl>
///               <dt><b>SPI_GETMOUSECLICKLOCKTIME</b></dt> <dt>0x2008</dt> </dl> </td> <td width="60%"> Retrieves the time delay
///               before the primary mouse button is locked. The <i>pvParam</i> parameter must point to <b>DWORD</b> that receives
///               the time delay, in milliseconds. This is only enabled if <b>SPI_SETMOUSECLICKLOCK</b> is set to <b>TRUE</b>. For
///               more information, see About Mouse Input. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr>
///               <td width="40%"><a id="SPI_GETMOUSEKEYS"></a><a id="spi_getmousekeys"></a><dl> <dt><b>SPI_GETMOUSEKEYS</b></dt>
///               <dt>0x0036</dt> </dl> </td> <td width="60%"> Retrieves information about the MouseKeys accessibility feature. The
///               <i>pvParam</i> parameter must point to a MOUSEKEYS structure that receives the information. Set the <b>cbSize</b>
///               member of this structure and the <i>uiParam</i> parameter to <code>sizeof(MOUSEKEYS)</code>. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETMOUSESONAR"></a><a id="spi_getmousesonar"></a><dl> <dt><b>SPI_GETMOUSESONAR</b></dt>
///               <dt>0x101C</dt> </dl> </td> <td width="60%"> Retrieves the state of the Mouse Sonar feature. The <i>pvParam</i>
///               parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if enabled or <b>FALSE</b> otherwise.
///               For more information, see About Mouse Input. <b>Windows 2000: </b>This parameter is not supported. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_GETMOUSEVANISH"></a><a id="spi_getmousevanish"></a><dl>
///               <dt><b>SPI_GETMOUSEVANISH</b></dt> <dt>0x1020</dt> </dl> </td> <td width="60%"> Retrieves the state of the Mouse
///               Vanish feature. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if
///               enabled or <b>FALSE</b> otherwise. For more information, see About Mouse Input. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETSCREENREADER"></a><a
///               id="spi_getscreenreader"></a><dl> <dt><b>SPI_GETSCREENREADER</b></dt> <dt>0x0046</dt> </dl> </td> <td
///               width="60%"> Determines whether a screen reviewer utility is running. A screen reviewer utility directs textual
///               information to an output device, such as a speech synthesizer or Braille display. When this flag is set, an
///               application should provide textual information in situations where it would otherwise present the information
///               graphically. The <i>pvParam</i> parameter is a pointer to a <b>BOOL</b>variable that receives <b>TRUE</b> if a
///               screen reviewer utility is running, or <b>FALSE</b> otherwise. <div class="alert"><b>Note</b> Narrator, the
///               screen reader that is included with Windows, does not set the <b>SPI_SETSCREENREADER</b> or
///               <b>SPI_GETSCREENREADER</b> flags.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSERIALKEYS"></a><a id="spi_getserialkeys"></a><dl> <dt><b>SPI_GETSERIALKEYS</b></dt> <dt>0x003E</dt>
///               </dl> </td> <td width="60%"> This parameter is not supported. <b>Windows Server 2003 and Windows XP/2000: </b>The
///               user should control this setting through the Control Panel. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSHOWSOUNDS"></a><a id="spi_getshowsounds"></a><dl> <dt><b>SPI_GETSHOWSOUNDS</b></dt> <dt>0x0038</dt>
///               </dl> </td> <td width="60%"> Determines whether the Show Sounds accessibility flag is on or off. If it is on, the
///               user requires an application to present information visually in situations where it would otherwise present the
///               information only in audible form. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives
///               <b>TRUE</b> if the feature is on, or <b>FALSE</b> if it is off. Using this value is equivalent to calling
///               GetSystemMetrics with <b>SM_SHOWSOUNDS</b>. That is the recommended call. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSOUNDSENTRY"></a><a id="spi_getsoundsentry"></a><dl> <dt><b>SPI_GETSOUNDSENTRY</b></dt>
///               <dt>0x0040</dt> </dl> </td> <td width="60%"> Retrieves information about the SoundSentry accessibility feature.
///               The <i>pvParam</i> parameter must point to a SOUNDSENTRY structure that receives the information. Set the
///               <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(SOUNDSENTRY)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETSTICKYKEYS"></a><a id="spi_getstickykeys"></a><dl>
///               <dt><b>SPI_GETSTICKYKEYS</b></dt> <dt>0x003A</dt> </dl> </td> <td width="60%"> Retrieves information about the
///               StickyKeys accessibility feature. The <i>pvParam</i> parameter must point to a STICKYKEYS structure that receives
///               the information. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(STICKYKEYS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_GETTOGGLEKEYS"></a><a
///               id="spi_gettogglekeys"></a><dl> <dt><b>SPI_GETTOGGLEKEYS</b></dt> <dt>0x0034</dt> </dl> </td> <td width="60%">
///               Retrieves information about the ToggleKeys accessibility feature. The <i>pvParam</i> parameter must point to a
///               TOGGLEKEYS structure that receives the information. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(TOGGLEKEYS)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETACCESSTIMEOUT"></a><a id="spi_setaccesstimeout"></a><dl> <dt><b>SPI_SETACCESSTIMEOUT</b></dt>
///               <dt>0x003D</dt> </dl> </td> <td width="60%"> Sets the time-out period associated with the accessibility features.
///               The <i>pvParam</i> parameter must point to an ACCESSTIMEOUT structure that contains the new parameters. Set the
///               <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(ACCESSTIMEOUT)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETAUDIODESCRIPTION"></a><a id="spi_setaudiodescription"></a><dl>
///               <dt><b>SPI_SETAUDIODESCRIPTION</b></dt> <dt>0x0075</dt> </dl> </td> <td width="60%"> Turns the audio descriptions
///               feature on or off. The <i>pvParam</i> parameter is a pointer to an AUDIODESCRIPTION structure. While it is
///               possible for users who are visually impaired to hear the audio in video content, there is a lot of action in
///               video that does not have corresponding audio. Specific audio description of what is happening in a video helps
///               these users understand the content better. This flag enables you to enable or disable audio descriptions in the
///               languages they are provided in. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETCLIENTAREAANIMATION"></a><a
///               id="spi_setclientareaanimation"></a><dl> <dt><b>SPI_SETCLIENTAREAANIMATION</b></dt> <dt>0x1043</dt> </dl> </td>
///               <td width="60%"> Turns client area animations on or off. The <i>pvParam</i> parameter is a <b>BOOL</b> variable.
///               Set <i>pvParam</i> to <b>TRUE</b> to enable animations and other transient effects in the client area, or
///               <b>FALSE</b> to disable them. Display features such as flashing, blinking, flickering, and moving content can
///               cause seizures in users with photo-sensitive epilepsy. This flag enables you to enable or disable all such
///               animations. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETDISABLEOVERLAPPEDCONTENT"></a><a id="spi_setdisableoverlappedcontent"></a><dl>
///               <dt><b>SPI_SETDISABLEOVERLAPPEDCONTENT</b></dt> <dt>0x1041</dt> </dl> </td> <td width="60%"> Turns overlapped
///               content (such as background images and watermarks) on or off. The <i>pvParam</i> parameter is a <b>BOOL</b>
///               variable. Set <i>pvParam</i> to <b>TRUE</b> to disable overlapped content, or <b>FALSE</b> to enable overlapped
///               content. Display features such as background images, textured backgrounds, water marks on documents, alpha
///               blending, and transparency can reduce the contrast between the foreground and background, making it harder for
///               users with low vision to see objects on the screen. This flag enables you to enable or disable all such
///               overlapped content. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETFILTERKEYS"></a><a id="spi_setfilterkeys"></a><dl>
///               <dt><b>SPI_SETFILTERKEYS</b></dt> <dt>0x0033</dt> </dl> </td> <td width="60%"> Sets the parameters of the
///               FilterKeys accessibility feature. The <i>pvParam</i> parameter must point to a FILTERKEYS structure that contains
///               the new parameters. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(FILTERKEYS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_SETFOCUSBORDERHEIGHT"></a><a
///               id="spi_setfocusborderheight"></a><dl> <dt><b>SPI_SETFOCUSBORDERHEIGHT</b></dt> <dt>0x2011</dt> </dl> </td> <td
///               width="60%"> Sets the height of the top and bottom edges of the focus rectangle drawn with DrawFocusRect to the
///               value of the <i>pvParam</i> parameter. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETFOCUSBORDERWIDTH"></a><a id="spi_setfocusborderwidth"></a><dl>
///               <dt><b>SPI_SETFOCUSBORDERWIDTH</b></dt> <dt>0x200F</dt> </dl> </td> <td width="60%"> Sets the height of the left
///               and right edges of the focus rectangle drawn with DrawFocusRect to the value of the <i>pvParam</i> parameter.
///               <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETHIGHCONTRAST"></a><a id="spi_sethighcontrast"></a><dl> <dt><b>SPI_SETHIGHCONTRAST</b></dt>
///               <dt>0x0043</dt> </dl> </td> <td width="60%"> Sets the parameters of the HighContrast accessibility feature. The
///               <i>pvParam</i> parameter must point to a HIGHCONTRAST structure that contains the new parameters. Set the
///               <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(HIGHCONTRAST)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETLOGICALDPIOVERRIDE"></a><a id="spi_setlogicaldpioverride"></a><dl>
///               <dt><b>SPI_SETLOGICALDPIOVERRIDE</b></dt> <dt>0x009F</dt> </dl> </td> <td width="60%"> Do not use. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETMESSAGEDURATION"></a><a id="spi_setmessageduration"></a><dl>
///               <dt><b>SPI_SETMESSAGEDURATION</b></dt> <dt>0x2017</dt> </dl> </td> <td width="60%"> Sets the time that
///               notification pop-ups should be displayed, in seconds. The <i>pvParam</i> parameter specifies the message
///               duration. Users with visual impairments or cognitive conditions such as ADHD and dyslexia might need a longer
///               time to read the text in notification messages. This flag enables you to set the message duration. <b>Windows
///               Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETMOUSECLICKLOCK"></a><a id="spi_setmouseclicklock"></a><dl> <dt><b>SPI_SETMOUSECLICKLOCK</b></dt>
///               <dt>0x101F</dt> </dl> </td> <td width="60%"> Turns the Mouse ClickLock accessibility feature on or off. This
///               feature temporarily locks down the primary mouse button when that button is clicked and held down for the time
///               specified by <b>SPI_SETMOUSECLICKLOCKTIME</b>. The <i>pvParam</i> parameter specifies <b>TRUE</b> for on, or
///               <b>FALSE</b> for off. The default is off. For more information, see Remarks and AboutMouse Input. <b>Windows
///               2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETMOUSECLICKLOCKTIME"></a><a id="spi_setmouseclicklocktime"></a><dl>
///               <dt><b>SPI_SETMOUSECLICKLOCKTIME</b></dt> <dt>0x2009</dt> </dl> </td> <td width="60%"> Adjusts the time delay
///               before the primary mouse button is locked. The <i>uiParam</i> parameter should be set to 0. The <i>pvParam</i>
///               parameter points to a <b>DWORD</b> that specifies the time delay in milliseconds. For example, specify 1000 for a
///               1 second delay. The default is 1200. For more information, see About Mouse Input. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETMOUSEKEYS"></a><a
///               id="spi_setmousekeys"></a><dl> <dt><b>SPI_SETMOUSEKEYS</b></dt> <dt>0x0037</dt> </dl> </td> <td width="60%"> Sets
///               the parameters of the MouseKeys accessibility feature. The <i>pvParam</i> parameter must point to a MOUSEKEYS
///               structure that contains the new parameters. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i>
///               parameter to <code>sizeof(MOUSEKEYS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_SETMOUSESONAR"></a><a
///               id="spi_setmousesonar"></a><dl> <dt><b>SPI_SETMOUSESONAR</b></dt> <dt>0x101D</dt> </dl> </td> <td width="60%">
///               Turns the Sonar accessibility feature on or off. This feature briefly shows several concentric circles around the
///               mouse pointer when the user presses and releases the CTRL key. The <i>pvParam</i> parameter specifies <b>TRUE</b>
///               for on and <b>FALSE</b> for off. The default is off. For more information, see About Mouse Input. <b>Windows
///               2000: </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETMOUSEVANISH"></a><a
///               id="spi_setmousevanish"></a><dl> <dt><b>SPI_SETMOUSEVANISH</b></dt> <dt>0x1021</dt> </dl> </td> <td width="60%">
///               Turns the Vanish feature on or off. This feature hides the mouse pointer when the user types; the pointer
///               reappears when the user moves the mouse. The <i>pvParam</i> parameter specifies <b>TRUE</b> for on and
///               <b>FALSE</b> for off. The default is off. For more information, see About Mouse Input. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETSCREENREADER"></a><a
///               id="spi_setscreenreader"></a><dl> <dt><b>SPI_SETSCREENREADER</b></dt> <dt>0x0047</dt> </dl> </td> <td
///               width="60%"> Determines whether a screen review utility is running. The <i>uiParam</i> parameter specifies
///               <b>TRUE</b> for on, or <b>FALSE</b> for off. <div class="alert"><b>Note</b> Narrator, the screen reader that is
///               included with Windows, does not set the <b>SPI_SETSCREENREADER</b> or <b>SPI_GETSCREENREADER</b> flags.</div>
///               <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_SETSERIALKEYS"></a><a id="spi_setserialkeys"></a><dl>
///               <dt><b>SPI_SETSERIALKEYS</b></dt> <dt>0x003F</dt> </dl> </td> <td width="60%"> This parameter is not supported.
///               <b>Windows Server 2003 and Windows XP/2000: </b>The user should control this setting through the Control Panel.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETSHOWSOUNDS"></a><a id="spi_setshowsounds"></a><dl>
///               <dt><b>SPI_SETSHOWSOUNDS</b></dt> <dt>0x0039</dt> </dl> </td> <td width="60%"> Turns the ShowSounds accessibility
///               feature on or off. The <i>uiParam</i> parameter specifies <b>TRUE</b> for on, or <b>FALSE</b> for off. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_SETSOUNDSENTRY"></a><a id="spi_setsoundsentry"></a><dl>
///               <dt><b>SPI_SETSOUNDSENTRY</b></dt> <dt>0x0041</dt> </dl> </td> <td width="60%"> Sets the parameters of the
///               <b>SoundSentry</b> accessibility feature. The <i>pvParam</i> parameter must point to a SOUNDSENTRY structure that
///               contains the new parameters. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(SOUNDSENTRY)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_SETSTICKYKEYS"></a><a
///               id="spi_setstickykeys"></a><dl> <dt><b>SPI_SETSTICKYKEYS</b></dt> <dt>0x003B</dt> </dl> </td> <td width="60%">
///               Sets the parameters of the StickyKeys accessibility feature. The <i>pvParam</i> parameter must point to a
///               STICKYKEYS structure that contains the new parameters. Set the <b>cbSize</b> member of this structure and the
///               <i>uiParam</i> parameter to <code>sizeof(STICKYKEYS)</code>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETTOGGLEKEYS"></a><a id="spi_settogglekeys"></a><dl> <dt><b>SPI_SETTOGGLEKEYS</b></dt> <dt>0x0035</dt>
///               </dl> </td> <td width="60%"> Sets the parameters of the ToggleKeys accessibility feature. The <i>pvParam</i>
///               parameter must point to a TOGGLEKEYS structure that contains the new parameters. Set the <b>cbSize</b> member of
///               this structure and the <i>uiParam</i> parameter to <code>sizeof(TOGGLEKEYS)</code>. </td> </tr> </table> The
///               following are the desktop parameters. <table> <tr> <th>Desktop parameter</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="SPI_GETCLEARTYPE"></a><a id="spi_getcleartype"></a><dl> <dt><b>SPI_GETCLEARTYPE</b></dt>
///               <dt>0x1048</dt> </dl> </td> <td width="60%"> Determines whether ClearType is enabled. The <i>pvParam</i>
///               parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if ClearType is enabled, or <b>FALSE</b>
///               otherwise. ClearType is a software technology that improves the readability of text on liquid crystal display
///               (LCD) monitors. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr>
///               <td width="40%"><a id="SPI_GETDESKWALLPAPER"></a><a id="spi_getdeskwallpaper"></a><dl>
///               <dt><b>SPI_GETDESKWALLPAPER</b></dt> <dt>0x0073</dt> </dl> </td> <td width="60%"> Retrieves the full path of the
///               bitmap file for the desktop wallpaper. The <i>pvParam</i> parameter must point to a buffer to receive the
///               null-terminated path string. Set the <i>uiParam</i> parameter to the size, in characters, of the <i>pvParam</i>
///               buffer. The returned string will not exceed <b>MAX_PATH</b> characters. If there is no desktop wallpaper, the
///               returned string is empty. </td> </tr> <tr> <td width="40%"><a id="SPI_GETDROPSHADOW"></a><a
///               id="spi_getdropshadow"></a><dl> <dt><b>SPI_GETDROPSHADOW</b></dt> <dt>0x1024</dt> </dl> </td> <td width="60%">
///               Determines whether the drop shadow effect is enabled. The <i>pvParam</i> parameter must point to a <b>BOOL</b>
///               variable that returns <b>TRUE</b> if enabled or <b>FALSE</b> if disabled. <b>Windows 2000: </b>This parameter is
///               not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFLATMENU"></a><a id="spi_getflatmenu"></a><dl>
///               <dt><b>SPI_GETFLATMENU</b></dt> <dt>0x1022</dt> </dl> </td> <td width="60%"> Determines whether native User menus
///               have flat menu appearance. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that returns
///               <b>TRUE</b> if the flat menu appearance is set, or <b>FALSE</b> otherwise. <b>Windows 2000: </b>This parameter is
///               not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFONTSMOOTHING"></a><a
///               id="spi_getfontsmoothing"></a><dl> <dt><b>SPI_GETFONTSMOOTHING</b></dt> <dt>0x004A</dt> </dl> </td> <td
///               width="60%"> Determines whether the font smoothing feature is enabled. This feature uses font antialiasing to
///               make font curves appear smoother by painting pixels at different gray levels. The <i>pvParam</i> parameter must
///               point to a <b>BOOL</b> variable that receives <b>TRUE</b> if the feature is enabled, or <b>FALSE</b> if it is
///               not. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFONTSMOOTHINGCONTRAST"></a><a
///               id="spi_getfontsmoothingcontrast"></a><dl> <dt><b>SPI_GETFONTSMOOTHINGCONTRAST</b></dt> <dt>0x200C</dt> </dl>
///               </td> <td width="60%"> Retrieves a contrast value that is used in ClearType smoothing. The <i>pvParam</i>
///               parameter must point to a <b>UINT</b> that receives the information. Valid contrast values are from 1000 to 2200.
///               The default value is 1400. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETFONTSMOOTHINGORIENTATION"></a><a id="spi_getfontsmoothingorientation"></a><dl>
///               <dt><b>SPI_GETFONTSMOOTHINGORIENTATION</b></dt> <dt>0x2012</dt> </dl> </td> <td width="60%"> Retrieves the font
///               smoothing orientation. The <i>pvParam</i> parameter must point to a <b>UINT</b> that receives the information.
///               The possible values are <b>FE_FONTSMOOTHINGORIENTATIONBGR</b> (blue-green-red) and
///               <b>FE_FONTSMOOTHINGORIENTATIONRGB</b> (red-green-blue). <b>Windows XP/2000: </b>This parameter is not supported
///               until Windows XP with SP2. </td> </tr> <tr> <td width="40%"><a id="SPI_GETFONTSMOOTHINGTYPE"></a><a
///               id="spi_getfontsmoothingtype"></a><dl> <dt><b>SPI_GETFONTSMOOTHINGTYPE</b></dt> <dt>0x200A</dt> </dl> </td> <td
///               width="60%"> Retrieves the type of font smoothing. The <i>pvParam</i> parameter must point to a <b>UINT</b> that
///               receives the information. The possible values are <b>FE_FONTSMOOTHINGSTANDARD</b> and
///               <b>FE_FONTSMOOTHINGCLEARTYPE</b>. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETWORKAREA"></a><a id="spi_getworkarea"></a><dl> <dt><b>SPI_GETWORKAREA</b></dt>
///               <dt>0x0030</dt> </dl> </td> <td width="60%"> Retrieves the size of the work area on the primary display monitor.
///               The work area is the portion of the screen not obscured by the system taskbar or by application desktop toolbars.
///               The <i>pvParam</i> parameter must point to a RECT structure that receives the coordinates of the work area,
///               expressed in physical pixel size. Any DPI virtualization mode of the caller has no effect on this output. To get
///               the work area of a monitor other than the primary display monitor, call the GetMonitorInfo function. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETCLEARTYPE"></a><a id="spi_setcleartype"></a><dl>
///               <dt><b>SPI_SETCLEARTYPE</b></dt> <dt>0x1049</dt> </dl> </td> <td width="60%"> Turns ClearType on or off. The
///               <i>pvParam</i> parameter is a <b>BOOL</b> variable. Set <i>pvParam</i> to <b>TRUE</b> to enable ClearType, or
///               <b>FALSE</b> to disable it. ClearType is a software technology that improves the readability of text on LCD
///               monitors. <b>Windows Server 2003 and Windows XP/2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETCURSORS"></a><a id="spi_setcursors"></a><dl> <dt><b>SPI_SETCURSORS</b></dt>
///               <dt>0x0057</dt> </dl> </td> <td width="60%"> Reloads the system cursors. Set the <i>uiParam</i> parameter to zero
///               and the <i>pvParam</i> parameter to <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETDESKPATTERN"></a><a id="spi_setdeskpattern"></a><dl> <dt><b>SPI_SETDESKPATTERN</b></dt>
///               <dt>0x0015</dt> </dl> </td> <td width="60%"> Sets the current desktop pattern by causing Windows to read the
///               <b>Pattern=</b> setting from the WIN.INI file. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETDESKWALLPAPER"></a><a id="spi_setdeskwallpaper"></a><dl> <dt><b>SPI_SETDESKWALLPAPER</b></dt>
///               <dt>0x0014</dt> </dl> </td> <td width="60%"> <div class="alert"><b>Note</b> When the <b>SPI_SETDESKWALLPAPER</b>
///               flag is used, <b>SystemParametersInfo</b> returns <b>TRUE</b> unless there is an error (like when the specified
///               file doesn't exist).</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_SETDROPSHADOW"></a><a
///               id="spi_setdropshadow"></a><dl> <dt><b>SPI_SETDROPSHADOW</b></dt> <dt>0x1025</dt> </dl> </td> <td width="60%">
///               Enables or disables the drop shadow effect. Set <i>pvParam</i> to <b>TRUE</b> to enable the drop shadow effect or
///               <b>FALSE</b> to disable it. You must also have <b>CS_DROPSHADOW</b> in the window class style. <b>Windows 2000:
///               </b>This parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETFLATMENU"></a><a
///               id="spi_setflatmenu"></a><dl> <dt><b>SPI_SETFLATMENU</b></dt> <dt>0x1023</dt> </dl> </td> <td width="60%">
///               Enables or disables flat menu appearance for native User menus. Set <i>pvParam</i> to <b>TRUE</b> to enable flat
///               menu appearance or <b>FALSE</b> to disable it. When enabled, the menu bar uses <b>COLOR_MENUBAR</b> for the
///               menubar background, <b>COLOR_MENU</b> for the menu-popup background, <b>COLOR_MENUHILIGHT</b> for the fill of the
///               current menu selection, and <b>COLOR_HILIGHT</b> for the outline of the current menu selection. If disabled,
///               menus are drawn using the same metrics and colors as in Windows 2000. <b>Windows 2000: </b>This parameter is not
///               supported. </td> </tr> <tr> <td width="40%"><a id="SPI_SETFONTSMOOTHING"></a><a
///               id="spi_setfontsmoothing"></a><dl> <dt><b>SPI_SETFONTSMOOTHING</b></dt> <dt>0x004B</dt> </dl> </td> <td
///               width="60%"> Enables or disables the font smoothing feature, which uses font antialiasing to make font curves
///               appear smoother by painting pixels at different gray levels. To enable the feature, set the <i>uiParam</i>
///               parameter to <b>TRUE</b>. To disable the feature, set <i>uiParam</i> to <b>FALSE</b>. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETFONTSMOOTHINGCONTRAST"></a><a id="spi_setfontsmoothingcontrast"></a><dl>
///               <dt><b>SPI_SETFONTSMOOTHINGCONTRAST</b></dt> <dt>0x200D</dt> </dl> </td> <td width="60%"> Sets the contrast value
///               used in ClearType smoothing. The <i>pvParam</i> parameter is the contrast value. Valid contrast values are from
///               1000 to 2200. The default value is 1400. <b>SPI_SETFONTSMOOTHINGTYPE</b> must also be set to
///               <b>FE_FONTSMOOTHINGCLEARTYPE</b>. <b>Windows 2000: </b>This parameter is not supported. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETFONTSMOOTHINGORIENTATION"></a><a id="spi_setfontsmoothingorientation"></a><dl>
///               <dt><b>SPI_SETFONTSMOOTHINGORIENTATION</b></dt> <dt>0x2013</dt> </dl> </td> <td width="60%"> Sets the font
///               smoothing orientation. The <i>pvParam</i> parameter is either <b>FE_FONTSMOOTHINGORIENTATIONBGR</b>
///               (blue-green-red) or <b>FE_FONTSMOOTHINGORIENTATIONRGB</b> (red-green-blue). <b>Windows XP/2000: </b>This
///               parameter is not supported until Windows XP with SP2. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETFONTSMOOTHINGTYPE"></a><a id="spi_setfontsmoothingtype"></a><dl>
///               <dt><b>SPI_SETFONTSMOOTHINGTYPE</b></dt> <dt>0x200B</dt> </dl> </td> <td width="60%"> Sets the font smoothing
///               type. The <i>pvParam</i> parameter is either <b>FE_FONTSMOOTHINGSTANDARD</b>, if standard anti-aliasing is used,
///               or <b>FE_FONTSMOOTHINGCLEARTYPE</b>, if ClearType is used. The default is <b>FE_FONTSMOOTHINGSTANDARD</b>.
///               <b>SPI_SETFONTSMOOTHING</b> must also be set. <b>Windows 2000: </b>This parameter is not supported. </td> </tr>
///               <tr> <td width="40%"><a id="SPI_SETWORKAREA"></a><a id="spi_setworkarea"></a><dl> <dt><b>SPI_SETWORKAREA</b></dt>
///               <dt>0x002F</dt> </dl> </td> <td width="60%"> Sets the size of the work area. The work area is the portion of the
///               screen not obscured by the system taskbar or by application desktop toolbars. The <i>pvParam</i> parameter is a
///               pointer to a RECT structure that specifies the new work area rectangle, expressed in virtual screen coordinates.
///               In a system with multiple display monitors, the function sets the work area of the monitor that contains the
///               specified rectangle. </td> </tr> </table> The following are the icon parameters. <table> <tr> <th>Icon
///               parameter</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SPI_GETICONMETRICS"></a><a
///               id="spi_geticonmetrics"></a><dl> <dt><b>SPI_GETICONMETRICS</b></dt> <dt>0x002D</dt> </dl> </td> <td width="60%">
///               Retrieves the metrics associated with icons. The <i>pvParam</i> parameter must point to an ICONMETRICS structure
///               that receives the information. Set the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to
///               <code>sizeof(ICONMETRICS)</code>. </td> </tr> <tr> <td width="40%"><a id="SPI_GETICONTITLELOGFONT"></a><a
///               id="spi_geticontitlelogfont"></a><dl> <dt><b>SPI_GETICONTITLELOGFONT</b></dt> <dt>0x001F</dt> </dl> </td> <td
///               width="60%"> Retrieves the logical font information for the current icon-title font. The <i>uiParam</i> parameter
///               specifies the size of a LOGFONT structure, and the <i>pvParam</i> parameter must point to the <b>LOGFONT</b>
///               structure to fill in. </td> </tr> <tr> <td width="40%"><a id="SPI_GETICONTITLEWRAP"></a><a
///               id="spi_geticontitlewrap"></a><dl> <dt><b>SPI_GETICONTITLEWRAP</b></dt> <dt>0x0019</dt> </dl> </td> <td
///               width="60%"> Determines whether icon-title wrapping is enabled. The <i>pvParam</i> parameter must point to a
///               <b>BOOL</b> variable that receives <b>TRUE</b> if enabled, or <b>FALSE</b> otherwise. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_ICONHORIZONTALSPACING"></a><a id="spi_iconhorizontalspacing"></a><dl>
///               <dt><b>SPI_ICONHORIZONTALSPACING</b></dt> <dt>0x000D</dt> </dl> </td> <td width="60%"> Sets or retrieves the
///               width, in pixels, of an icon cell. The system uses this rectangle to arrange icons in large icon view. To set
///               this value, set <i>uiParam</i> to the new value and set <i>pvParam</i> to <b>NULL</b>. You cannot set this value
///               to less than <b>SM_CXICON</b>. To retrieve this value, <i>pvParam</i> must point to an integer that receives the
///               current value. </td> </tr> <tr> <td width="40%"><a id="SPI_ICONVERTICALSPACING"></a><a
///               id="spi_iconverticalspacing"></a><dl> <dt><b>SPI_ICONVERTICALSPACING</b></dt> <dt>0x0018</dt> </dl> </td> <td
///               width="60%"> Sets or retrieves the height, in pixels, of an icon cell. To set this value, set <i>uiParam</i> to
///               the new value and set <i>pvParam</i> to <b>NULL</b>. You cannot set this value to less than <b>SM_CYICON</b>. To
///               retrieve this value, <i>pvParam</i> must point to an integer that receives the current value. </td> </tr> <tr>
///               <td width="40%"><a id="SPI_SETICONMETRICS"></a><a id="spi_seticonmetrics"></a><dl>
///               <dt><b>SPI_SETICONMETRICS</b></dt> <dt>0x002E</dt> </dl> </td> <td width="60%"> Sets the metrics associated with
///               icons. The <i>pvParam</i> parameter must point to an ICONMETRICS structure that contains the new parameters. Set
///               the <b>cbSize</b> member of this structure and the <i>uiParam</i> parameter to <code>sizeof(ICONMETRICS)</code>.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETICONS"></a><a id="spi_seticons"></a><dl>
///               <dt><b>SPI_SETICONS</b></dt> <dt>0x0058</dt> </dl> </td> <td width="60%"> Reloads the system icons. Set the
///               <i>uiParam</i> parameter to zero and the <i>pvParam</i> parameter to <b>NULL</b>. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETICONTITLELOGFONT"></a><a id="spi_seticontitlelogfont"></a><dl>
///               <dt><b>SPI_SETICONTITLELOGFONT</b></dt> <dt>0x0022</dt> </dl> </td> <td width="60%"> Sets the font that is used
///               for icon titles. The <i>uiParam</i> parameter specifies the size of a LOGFONT structure, and the <i>pvParam</i>
///               parameter must point to a <b>LOGFONT</b> structure. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETICONTITLEWRAP"></a><a id="spi_seticontitlewrap"></a><dl> <dt><b>SPI_SETICONTITLEWRAP</b></dt>
///               <dt>0x001A</dt> </dl> </td> <td width="60%"> Turns icon-title wrapping on or off. The <i>uiParam</i> parameter
///               specifies <b>TRUE</b> for on, or <b>FALSE</b> for off. </td> </tr> </table> The following are the input
///               parameters. They include parameters related to the keyboard, mouse, pen, input language, and the warning beeper.
///               <table> <tr> <th>Input parameter</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SPI_GETBEEP"></a><a
///               id="spi_getbeep"></a><dl> <dt><b>SPI_GETBEEP</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Determines
///               whether the warning beeper is on. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives
///               <b>TRUE</b> if the beeper is on, or <b>FALSE</b> if it is off. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETBLOCKSENDINPUTRESETS"></a><a id="spi_getblocksendinputresets"></a><dl>
///               <dt><b>SPI_GETBLOCKSENDINPUTRESETS</b></dt> <dt>0x1026</dt> </dl> </td> <td width="60%"> Retrieves a <b>BOOL</b>
///               indicating whether an application can reset the screensaver's timer by calling the SendInput function to simulate
///               keyboard or mouse input. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives
///               <b>TRUE</b> if the simulated input will be blocked, or <b>FALSE</b> otherwise. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETCONTACTVISUALIZATION"></a><a id="spi_getcontactvisualization"></a><dl>
///               <dt><b>SPI_GETCONTACTVISUALIZATION</b></dt> <dt>0x2018</dt> </dl> </td> <td width="60%"> Retrieves the current
///               contact visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that receives
///               the setting. For more information, see Contact Visualization. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETDEFAULTINPUTLANG"></a><a id="spi_getdefaultinputlang"></a><dl> <dt><b>SPI_GETDEFAULTINPUTLANG</b></dt>
///               <dt>0x0059</dt> </dl> </td> <td width="60%"> Retrieves the input locale identifier for the system default input
///               language. The <i>pvParam</i> parameter must point to an <b>HKL</b> variable that receives this value. For more
///               information, see Languages, Locales, and Keyboard Layouts. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETGESTUREVISUALIZATION"></a><a id="spi_getgesturevisualization"></a><dl>
///               <dt><b>SPI_GETGESTUREVISUALIZATION</b></dt> <dt>0x201A</dt> </dl> </td> <td width="60%"> Retrieves the current
///               gesture visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that receives
///               the setting. For more information, see Gesture Visualization. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETKEYBOARDCUES"></a><a id="spi_getkeyboardcues"></a><dl> <dt><b>SPI_GETKEYBOARDCUES</b></dt>
///               <dt>0x100A</dt> </dl> </td> <td width="60%"> Determines whether menu access keys are always underlined. The
///               <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if menu access keys are
///               always underlined, and <b>FALSE</b> if they are underlined only when the menu is activated by the keyboard. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_GETKEYBOARDDELAY"></a><a id="spi_getkeyboarddelay"></a><dl>
///               <dt><b>SPI_GETKEYBOARDDELAY</b></dt> <dt>0x0016</dt> </dl> </td> <td width="60%"> Retrieves the keyboard
///               repeat-delay setting, which is a value in the range from 0 (approximately 250 ms delay) through 3 (approximately
///               1 second delay). The actual delay associated with each value may vary depending on the hardware. The
///               <i>pvParam</i> parameter must point to an integer variable that receives the setting. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETKEYBOARDPREF"></a><a id="spi_getkeyboardpref"></a><dl>
///               <dt><b>SPI_GETKEYBOARDPREF</b></dt> <dt>0x0044</dt> </dl> </td> <td width="60%"> Determines whether the user
///               relies on the keyboard instead of the mouse, and wants applications to display keyboard interfaces that would
///               otherwise be hidden. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b>
///               if the user relies on the keyboard; or <b>FALSE</b> otherwise. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETKEYBOARDSPEED"></a><a id="spi_getkeyboardspeed"></a><dl> <dt><b>SPI_GETKEYBOARDSPEED</b></dt>
///               <dt>0x000A</dt> </dl> </td> <td width="60%"> Retrieves the keyboard repeat-speed setting, which is a value in the
///               range from 0 (approximately 2.5 repetitions per second) through 31 (approximately 30 repetitions per second). The
///               actual repeat rates are hardware-dependent and may vary from a linear scale by as much as 20%. The <i>pvParam</i>
///               parameter must point to a <b>DWORD</b> variable that receives the setting. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETMOUSE"></a><a id="spi_getmouse"></a><dl> <dt><b>SPI_GETMOUSE</b></dt> <dt>0x0003</dt> </dl> </td> <td
///               width="60%"> Retrieves the two mouse threshold values and the mouse acceleration. The <i>pvParam</i> parameter
///               must point to an array of three integers that receives these values. See mouse_event for further information.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEHOVERHEIGHT"></a><a id="spi_getmousehoverheight"></a><dl>
///               <dt><b>SPI_GETMOUSEHOVERHEIGHT</b></dt> <dt>0x0064</dt> </dl> </td> <td width="60%"> Retrieves the height, in
///               pixels, of the rectangle within which the mouse pointer has to stay for TrackMouseEvent to generate a
///               WM_MOUSEHOVER message. The <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the
///               height. </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEHOVERTIME"></a><a id="spi_getmousehovertime"></a><dl>
///               <dt><b>SPI_GETMOUSEHOVERTIME</b></dt> <dt>0x0066</dt> </dl> </td> <td width="60%"> Retrieves the time, in
///               milliseconds, that the mouse pointer has to stay in the hover rectangle for TrackMouseEvent to generate a
///               WM_MOUSEHOVER message. The <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the time.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEHOVERWIDTH"></a><a id="spi_getmousehoverwidth"></a><dl>
///               <dt><b>SPI_GETMOUSEHOVERWIDTH</b></dt> <dt>0x0062</dt> </dl> </td> <td width="60%"> Retrieves the width, in
///               pixels, of the rectangle within which the mouse pointer has to stay for TrackMouseEvent to generate a
///               WM_MOUSEHOVER message. The <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the width.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSESPEED"></a><a id="spi_getmousespeed"></a><dl>
///               <dt><b>SPI_GETMOUSESPEED</b></dt> <dt>0x0070</dt> </dl> </td> <td width="60%"> Retrieves the current mouse speed.
///               The mouse speed determines how far the pointer will move based on the distance the mouse moves. The
///               <i>pvParam</i> parameter must point to an integer that receives a value which ranges between 1 (slowest) and 20
///               (fastest). A value of 10 is the default. The value can be set by an end-user using the mouse control panel
///               application or by an application using <b>SPI_SETMOUSESPEED</b>. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETMOUSETRAILS"></a><a id="spi_getmousetrails"></a><dl> <dt><b>SPI_GETMOUSETRAILS</b></dt>
///               <dt>0x005E</dt> </dl> </td> <td width="60%"> Determines whether the Mouse Trails feature is enabled. This feature
///               improves the visibility of mouse cursor movements by briefly showing a trail of cursors and quickly erasing them.
///               The <i>pvParam</i> parameter must point to an integer variable that receives a value. if the value is zero or 1,
///               the feature is disabled. If the value is greater than 1, the feature is enabled and the value indicates the
///               number of cursors drawn in the trail. The <i>uiParam</i> parameter is not used. <b>Windows 2000: </b>This
///               parameter is not supported. </td> </tr> <tr> <td width="40%"><a id="SPI_GETMOUSEWHEELROUTING"></a><a
///               id="spi_getmousewheelrouting"></a><dl> <dt><b>SPI_GETMOUSEWHEELROUTING</b></dt> <dt>0x201C</dt> </dl> </td> <td
///               width="60%"> Retrieves the routing setting for wheel button input. The routing setting determines whether wheel
///               button input is sent to the app with focus (foreground) or the app under the mouse cursor. The <i>pvParam</i>
///               parameter must point to a <b>DWORD</b> variable that receives the routing option. If the value is zero or
///               MOUSEWHEEL_ROUTING_FOCUS, mouse wheel input is delivered to the app with focus. If the value is 1 or
///               MOUSEWHEEL_ROUTING_HYBRID (default), mouse wheel input is delivered to the app with focus (desktop apps) or the
///               app under the mouse cursor (Windows Store apps). The <i>uiParam</i> parameter is not used. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_GETPENVISUALIZATION"></a><a id="spi_getpenvisualization"></a><dl>
///               <dt><b>SPI_GETPENVISUALIZATION</b></dt> <dt>0x201E</dt> </dl> </td> <td width="60%"> Retrieves the current pen
///               gesture visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that receives
///               the setting. For more information, see Pen Visualization. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSNAPTODEFBUTTON"></a><a id="spi_getsnaptodefbutton"></a><dl> <dt><b>SPI_GETSNAPTODEFBUTTON</b></dt>
///               <dt>0x005F</dt> </dl> </td> <td width="60%"> Determines whether the snap-to-default-button feature is enabled. If
///               enabled, the mouse cursor automatically moves to the default button, such as <b>OK</b> or <b>Apply</b>, of a
///               dialog box. The <i>pvParam</i> parameter must point to a <b>BOOL</b> variable that receives <b>TRUE</b> if the
///               feature is on, or <b>FALSE</b> if it is off. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_GETSYSTEMLANGUAGEBAR"></a><a id="spi_getsystemlanguagebar"></a><dl>
///               <dt><b>SPI_GETSYSTEMLANGUAGEBAR</b></dt> <dt>0x1050</dt> </dl> </td> <td width="60%"> <b>Starting with Windows
///               8:</b> Determines whether the system language bar is enabled or disabled. The <i>pvParam</i> parameter must point
///               to a <b>BOOL</b> variable that receives <b>TRUE</b> if the language bar is enabled, or <b>FALSE</b> otherwise.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_GETTHREADLOCALINPUTSETTINGS"></a><a
///               id="spi_getthreadlocalinputsettings"></a><dl> <dt><b>SPI_GETTHREADLOCALINPUTSETTINGS</b></dt> <dt>0x104E</dt>
///               </dl> </td> <td width="60%"> <b>Starting with Windows 8:</b> Determines whether the active input settings have
///               Local (per-thread, <b>TRUE</b>) or Global (session, <b>FALSE</b>) scope. The <i>pvParam</i> parameter must point
///               to a <b>BOOL</b> variable. </td> </tr> <tr> <td width="40%"><a id="SPI_GETWHEELSCROLLCHARS"></a><a
///               id="spi_getwheelscrollchars"></a><dl> <dt><b>SPI_GETWHEELSCROLLCHARS</b></dt> <dt>0x006C</dt> </dl> </td> <td
///               width="60%"> Retrieves the number of characters to scroll when the horizontal mouse wheel is moved. The
///               <i>pvParam</i> parameter must point to a <b>UINT</b> variable that receives the number of lines. The default
///               value is 3. </td> </tr> <tr> <td width="40%"><a id="SPI_GETWHEELSCROLLLINES"></a><a
///               id="spi_getwheelscrolllines"></a><dl> <dt><b>SPI_GETWHEELSCROLLLINES</b></dt> <dt>0x0068</dt> </dl> </td> <td
///               width="60%"> Retrieves the number of lines to scroll when the vertical mouse wheel is moved. The <i>pvParam</i>
///               parameter must point to a <b>UINT</b> variable that receives the number of lines. The default value is 3. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_SETBEEP"></a><a id="spi_setbeep"></a><dl> <dt><b>SPI_SETBEEP</b></dt>
///               <dt>0x0002</dt> </dl> </td> <td width="60%"> Turns the warning beeper on or off. The <i>uiParam</i> parameter
///               specifies <b>TRUE</b> for on, or <b>FALSE</b> for off. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETBLOCKSENDINPUTRESETS"></a><a id="spi_setblocksendinputresets"></a><dl>
///               <dt><b>SPI_SETBLOCKSENDINPUTRESETS</b></dt> <dt>0x1027</dt> </dl> </td> <td width="60%"> Determines whether an
///               application can reset the screensaver's timer by calling the SendInput function to simulate keyboard or mouse
///               input. The <i>uiParam</i> parameter specifies <b>TRUE</b> if the screensaver will not be deactivated by simulated
///               input, or <b>FALSE</b> if the screensaver will be deactivated by simulated input. </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETCONTACTVISUALIZATION"></a><a id="spi_setcontactvisualization"></a><dl>
///               <dt><b>SPI_SETCONTACTVISUALIZATION</b></dt> <dt>0x2019</dt> </dl> </td> <td width="60%"> Sets the current contact
///               visualization setting. The <i>pvParam</i> parameter must point to a <b>ULONG</b> variable that identifies the
///               setting. For more information, see Contact Visualization. <div class="alert"><b>Note</b> If contact
///               visualizations are disabled, gesture visualizations cannot be enabled.</div> <div> </div> </td> </tr> <tr> <td
///               width="40%"><a id="SPI_SETDEFAULTINPUTLANG"></a><a id="spi_setdefaultinputlang"></a><dl>
///               <dt><b>SPI_SETDEFAULTINPUTLANG</b></dt> <dt>0x005A</dt> </dl> </td> <td width="60%"> Sets the default input
///               language for the system shell and applications. The specified language must be displayable using the current
///               system character set. The <i>pvParam</i> parameter must point to an <b>HKL</b> variable that contains the input
///               locale identifier for the default language. For more information, see Languages, Locales, and Keyboard Layouts.
///               </td> </tr> <tr> <td width="40%"><a id="SPI_SETDOUBLECLICKTIME"></a><a id="spi_setdoubleclicktime"></a><dl>
///               <dt><b>SPI_SETDOUBLECLICKTIME</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> Sets the double-click time
///               for the mouse to the value of the <i>uiParam</i> parameter. If the <i>uiParam</i> value is greater than 5000
///               milliseconds, the system sets the double-click time to 5000 milliseconds. The double-click time is the maximum
///               number of milliseconds that can occur between the first and second clicks of a double-click. You can also call
///               the SetDoubleClickTime function to set the double-click time. To get the current double-click time, call the
///               GetDoubleClickTime function. </td> </tr> <tr> <td width="40%"><a id="SPI_SETDOUBLECLKHEIGHT"></a><a
///               id="spi_setdoubleclkheight"></a><dl> <dt><b>SPI_SETDOUBLECLKHEIGHT</b></dt> <dt>0x001E</dt> </dl> </td> <td
///               width="60%"> Sets the height of the double-click rectangle to the value of the <i>uiParam</i> parameter. The
///               double-click rectangle is the rectangle within which the second click of a double-click must fall for it to be
///               registered as a double-click. To retrieve the height of the double-click rectangle, call GetSystemMetrics with
///               the <b>SM_CYDOUBLECLK</b> flag. </td> </tr> <tr> <td width="40%"><a id="SPI_SETDOUBLECLKWIDTH"></a><a
///               id="spi_setdoubleclkwidth"></a><dl> <dt><b>SPI_SETDOUBLECLKWIDTH</b></dt> <dt>0x001D</dt> </dl> </td> <td
///               width="60%"> Sets the width of the double-click rectangle to the value of the <i>uiParam</i> parameter. The
///               double-click rectangle is the rectangle within which the second click of a double-click must fall for it to be
///               registered as a double-click. To retrieve the width of the double-click rectangle, call GetSystemMetrics with the
///               <b>SM_CXDOUBLECLK</b> flag. </td> </tr> <tr> <td width="40%"><a id="SPI_SETGESTUREVISUALIZATION"></a><a
///               id="spi_setgesturevisualization"></a><dl> <dt><b>SPI_SETGESTUREVISUALIZATION</b></dt> <dt>0x201B</dt> </dl> </td>
///               <td width="60%"> Sets the current gesture visualization setting. The <i>pvParam</i> parameter must point to a
///               <b>ULONG</b> variable that identifies the setting. For more information, see Gesture Visualization. <div
///               class="alert"><b>Note</b> If contact visualizations are disabled, gesture visualizations cannot be enabled.</div>
///               <div> </div> </td> </tr> <tr> <td width="40%"><a id="SPI_SETKEYBOARDCUES"></a><a
///               id="spi_setkeyboardcues"></a><dl> <dt><b>SPI_SETKEYBOARDCUES</b></dt> <dt>0x100B</dt> </dl> </td> <td
///               width="60%"> Sets the underlining of menu access key letters. The <i>pvParam</i> parameter is a <b>BOOL</b>
///               variable. Set <i>pvParam</i> to <b>TRUE</b> to always underline menu access keys, or <b>FALSE</b> to underline
///               menu access keys only when the menu is activated from the keyboard. </td> </tr> <tr> <td width="40%"><a
///               id="SPI_SETKEYBOARDDELAY"></a><a id="spi_setkeyboarddelay"></a><dl> <dt><b>SPI_SETKEYBOARDDELAY</b></dt>
///               <dt>0x0017</dt> </dl> </td> <td width="60%"> Sets the keyboard repeat-delay setting. The <i>uiParam</i> parameter
///               must specify 0, 1, 2, or 3, where zero sets the shortest delay approximately 250 ms) and 3 sets the longest delay
///               (approximately 1 second). The actual delay associated with each value may vary depending on the hardware. </td>
///               </tr> <tr> <td width="40%"><a id="SPI_SETKEYBOARDPREF"></a><a id="spi_setkeyboardpref"></a><dl>
///               <dt><b>SPI_SETKEYBOARDPREF</b></dt> <dt>0x0045</dt> </dl> </td> <td width="60%"> Sets the keyboard preference.
///               The <i>uiParam</i> parameter specifies <b>TRUE</b> if the user relies on the keyboard instead of the mouse, and
///               wants applications to display keyboard interfaces that would otherwise be hidden; <i>uiParam</i> is <b>FALSE</b>
///               otherwise. </td> </tr> <tr> <td width="40%"><a id="SPI_SETKEYBOARDSPEED"></a><a
///               id="spi_setkeyboardspeed"></a><dl> <dt><b>SPI_SETKEYBOARDSPEED</b></dt> <dt>0x000B</dt> </dl> </td> <td
///               width="60%"> Sets the keyboard repeat-speed setting. The <i>uiParam</i> parameter must specify a value in the
///               range from 0 (approximately 2.5 repetitions per second) through 31 (approximately 30 repetitions per second). The
///               actual repeat rates are hardware-dependent and may vary from a linear scale by as much as 20%. If <i>uiParam</i>
///               is greater than 31, the parameter is set to 31. </td> </tr> <tr> <td width="40%"><a id="SPI_SETLANGTOGGLE"></a><a
///               id="spi_setlangtoggle"></a><dl> <dt><b>SPI_SETLANGTOGGLE</b></dt> <dt>0x005B</dt> </dl> </td> <td width="60%">
///               Sets the hot key set for switching between input languages. The <i>uiParam</i> and <i>pvParam</i> parameters are
///               not used. The value sets the shortcut keys in the keyboard property sheets by reading the registry again. The
///               registry must be set before this flag is used. the path in the registry is <b>HKEY_CURRENT_USER</b>&
///    uiParam = Type: <b>UINT</b> A parameter whose usage and format depends on the system parameter being queried or set. For
///              more information about system-wide parameters, see the <i>uiAction</i> parameter. If not otherwise indicated, you
///              must specify zero for this parameter.
///    pvParam = Type: <b>PVOID</b> A parameter whose usage and format depends on the system parameter being queried or set. For
///              more information about system-wide parameters, see the <i>uiAction</i> parameter. If not otherwise indicated, you
///              must specify <b>NULL</b> for this parameter. For information on the <b>PVOID</b> datatype, see Windows Data
///              Types.
///    fWinIni = Type: <b>UINT</b> If a system parameter is being set, specifies whether the user profile is to be updated, and if
///              so, whether the WM_SETTINGCHANGE message is to be broadcast to all top-level windows to notify them of the
///              change. This parameter can be zero if you do not want to update the user profile or broadcast the
///              WM_SETTINGCHANGE message, or it can be one or more of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SPIF_UPDATEINIFILE"></a><a id="spif_updateinifile"></a><dl>
///              <dt><b>SPIF_UPDATEINIFILE</b></dt> </dl> </td> <td width="60%"> Writes the new system-wide parameter setting to
///              the user profile. </td> </tr> <tr> <td width="40%"><a id="SPIF_SENDCHANGE"></a><a id="spif_sendchange"></a><dl>
///              <dt><b>SPIF_SENDCHANGE</b></dt> </dl> </td> <td width="60%"> Broadcasts the WM_SETTINGCHANGE message after
///              updating the user profile. </td> </tr> <tr> <td width="40%"><a id="SPIF_SENDWININICHANGE"></a><a
///              id="spif_sendwininichange"></a><dl> <dt><b>SPIF_SENDWININICHANGE</b></dt> </dl> </td> <td width="60%"> Same as
///              <b>SPIF_SENDCHANGE</b>. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is a nonzero value. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SystemParametersInfoW(uint uiAction, uint uiParam, void* pvParam, uint fWinIni);

///Triggers a visual signal to indicate that a sound is playing.
///Returns:
///    Type: <b>BOOL</b> This function returns one of the following values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The
///    visual signal was or will be displayed correctly. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt>
///    </dl> </td> <td width="60%"> An error prevented the signal from being displayed. </td> </tr> </table>
///    
@DllImport("USER32")
BOOL SoundSentry();

///<p class="CCE_Message">[This function is not intended for general use. It may be altered or unavailable in subsequent
///versions of Windows.] Copies the text of the specified window's title bar (if it has one) into a buffer. This
///function is similar to the GetWindowText function. However, it obtains the window text directly from the window
///structure associated with the specified window's handle and then always provides the text as a Unicode string. This
///is unlike <b>GetWindowText</b> which obtains the text by sending the window a WM_GETTEXT message. If the specified
///window is a control, the text of the control is obtained.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window or control containing the text.
///    pString = Type: <b>LPWSTR</b> The buffer that is to receive the text. If the string is as long or longer than the buffer,
///              the string is truncated and terminated with a null character.
///    cchMaxCount = Type: <b>int</b> The maximum number of characters to be copied to the buffer, including the null character. If
///                  the text exceeds this limit, it is truncated.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the length, in characters, of the copied string,
///    not including the terminating null character. If the window has no title bar or text, if the title bar is empty,
///    or if the window or control handle is invalid, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
int InternalGetWindowText(HWND hWnd, PWSTR pString, int cchMaxCount);

///Retrieves information about the active window or a specified GUI thread.
///Params:
///    idThread = Type: <b>DWORD</b> The identifier for the thread for which information is to be retrieved. To retrieve this
///               value, use the GetWindowThreadProcessId function. If this parameter is <b>NULL</b>, the function returns
///               information for the foreground thread.
///    pgui = Type: <b>LPGUITHREADINFO</b> A pointer to a GUITHREADINFO structure that receives information describing the
///           thread. Note that you must set the <b>cbSize</b> member to <code>sizeof(GUITHREADINFO)</code> before calling this
///           function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetGUIThreadInfo(uint idThread, GUITHREADINFO* pgui);

///<div class="alert"><b>Note</b> It is recommended that you set the process-default DPI awareness via application
///manifest, not an API call. See Setting the default DPI awareness for a process for more information. Setting the
///process-default DPI awareness via API call can lead to unexpected application behavior.</div><div> </div>Sets the
///process-default DPI awareness to system-DPI awareness. This is equivalent to calling SetProcessDpiAwarenessContext
///with a DPI_AWARENESS_CONTEXT value of DPI_AWARENESS_CONTEXT_SYSTEM_AWARE.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. Otherwise, the return value is zero.
///    
@DllImport("USER32")
BOOL SetProcessDPIAware();

///<p class="CCE_Message"><p class="note">[IsProcessDPIAware is available for use in the operating systems specified in
///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
///GetProcessDPIAwareness.]</p> Determines whether the current process is dots per inch (dpi) aware such that it adjusts
///the sizes of UI elements to compensate for the dpi setting.
@DllImport("USER32")
BOOL IsProcessDPIAware();

///Retrieves the full path and file name of the module associated with the specified window handle.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window whose module file name is to be retrieved.
///    pszFileName = Type: <b>LPTSTR</b> The path and file name.
///    cchFileNameMax = Type: <b>UINT</b> The maximum number of characters that can be copied into the <i>lpszFileName</i> buffer.
///Returns:
///    Type: <b>UINT</b> The return value is the total number of characters copied into the buffer.
///    
@DllImport("USER32")
uint GetWindowModuleFileNameA(HWND hwnd, PSTR pszFileName, uint cchFileNameMax);

///Retrieves the full path and file name of the module associated with the specified window handle.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window whose module file name is to be retrieved.
///    pszFileName = Type: <b>LPTSTR</b> The path and file name.
///    cchFileNameMax = Type: <b>UINT</b> The maximum number of characters that can be copied into the <i>lpszFileName</i> buffer.
///Returns:
///    Type: <b>UINT</b> The return value is the total number of characters copied into the buffer.
///    
@DllImport("USER32")
uint GetWindowModuleFileNameW(HWND hwnd, PWSTR pszFileName, uint cchFileNameMax);

///Retrieves information about the specified window.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window whose information is to be retrieved.
///    pwi = Type: <b>PWINDOWINFO</b> A pointer to a WINDOWINFO structure to receive the information. Note that you must set
///          the <b>cbSize</b> member to <code>sizeof(WINDOWINFO)</code> before calling this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetWindowInfo(HWND hwnd, WINDOWINFO* pwi);

///Retrieves information about the specified title bar.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the title bar whose information is to be retrieved.
///    pti = Type: <b>PTITLEBARINFO</b> A pointer to a TITLEBARINFO structure to receive the information. Note that you must
///          set the <b>cbSize</b> member to <code>sizeof(TITLEBARINFO)</code> before calling this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetTitleBarInfo(HWND hwnd, TITLEBARINFO* pti);

///Retrieves the handle to the ancestor of the specified window.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window whose ancestor is to be retrieved. If this parameter is the desktop
///           window, the function returns <b>NULL</b>.
///    gaFlags = Type: <b>UINT</b> The ancestor to be retrieved. This parameter can be one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GA_PARENT"></a><a id="ga_parent"></a><dl>
///              <dt><b>GA_PARENT</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Retrieves the parent window. This does not
///              include the owner, as it does with the GetParent function. </td> </tr> <tr> <td width="40%"><a
///              id="GA_ROOT"></a><a id="ga_root"></a><dl> <dt><b>GA_ROOT</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
///              Retrieves the root window by walking the chain of parent windows. </td> </tr> <tr> <td width="40%"><a
///              id="GA_ROOTOWNER"></a><a id="ga_rootowner"></a><dl> <dt><b>GA_ROOTOWNER</b></dt> <dt>3</dt> </dl> </td> <td
///              width="60%"> Retrieves the owned root window by walking the chain of parent and owner windows returned by
///              GetParent. </td> </tr> </table>
///Returns:
///    Type: <b>HWND</b> The return value is the handle to the ancestor window.
///    
@DllImport("USER32")
HWND GetAncestor(HWND hwnd, uint gaFlags);

///Retrieves a handle to the child window at the specified point. The search is restricted to immediate child windows;
///grandchildren and deeper descendant windows are not searched.
///Params:
///    hwndParent = Type: <b>HWND</b> A handle to the window whose child is to be retrieved.
///    ptParentClientCoords = Type: <b>POINT</b> A POINT structure that defines the client coordinates of the point to be checked.
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the child window that contains the specified point.
///    
@DllImport("USER32")
HWND RealChildWindowFromPoint(HWND hwndParent, POINT ptParentClientCoords);

///Retrieves a string that specifies the window type.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window whose type will be retrieved.
///    ptszClassName = Type: <b>LPTSTR</b> A pointer to a string that receives the window type.
///    cchClassNameMax = Type: <b>UINT</b> The length, in characters, of the buffer pointed to by the <i>pszType</i> parameter.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the number of characters copied to the specified
///    buffer. If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint RealGetWindowClassW(HWND hwnd, PWSTR ptszClassName, uint cchClassNameMax);

///Retrieves status information for the specified window if it is the application-switching (ALT+TAB) window.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window for which status information will be retrieved. This window must be the
///           application-switching window.
///    iItem = Type: <b>int</b> The index of the icon in the application-switching window. If the <i>pszItemText</i> parameter
///            is not <b>NULL</b>, the name of the item is copied to the <i>pszItemText</i> string. If this parameter is –1,
///            the name of the item is not copied.
///    pati = Type: <b>PALTTABINFO</b> A pointer to an ALTTABINFO structure to receive the status information. Note that you
///           must set the <b>csSize</b> member to <code>sizeof(ALTTABINFO)</code> before calling this function.
///    pszItemText = Type: <b>LPTSTR</b> The name of the item. If this parameter is <b>NULL</b>, the name of the item is not copied.
///    cchItemText = Type: <b>UINT</b> The size, in characters, of the <i>pszItemText</i> buffer.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetAltTabInfoA(HWND hwnd, int iItem, ALTTABINFO* pati, PSTR pszItemText, uint cchItemText);

///Retrieves status information for the specified window if it is the application-switching (ALT+TAB) window.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window for which status information will be retrieved. This window must be the
///           application-switching window.
///    iItem = Type: <b>int</b> The index of the icon in the application-switching window. If the <i>pszItemText</i> parameter
///            is not <b>NULL</b>, the name of the item is copied to the <i>pszItemText</i> string. If this parameter is –1,
///            the name of the item is not copied.
///    pati = Type: <b>PALTTABINFO</b> A pointer to an ALTTABINFO structure to receive the status information. Note that you
///           must set the <b>csSize</b> member to <code>sizeof(ALTTABINFO)</code> before calling this function.
///    pszItemText = Type: <b>LPTSTR</b> The name of the item. If this parameter is <b>NULL</b>, the name of the item is not copied.
///    cchItemText = Type: <b>UINT</b> The size, in characters, of the <i>pszItemText</i> buffer.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetAltTabInfoW(HWND hwnd, int iItem, ALTTABINFO* pati, PWSTR pszItemText, uint cchItemText);

///<p class="CCE_Message">[Using the <b>ChangeWindowMessageFilter</b> function is not recommended, as it has
///process-wide scope. Instead, use the ChangeWindowMessageFilterEx function to control access to specific windows as
///needed. <b>ChangeWindowMessageFilter</b> may not be supported in future versions of Windows.] Adds or removes a
///message from the User Interface Privilege Isolation (UIPI) message filter.
///Params:
///    message = Type: <b>UINT</b> The message to add to or remove from the filter.
///    dwFlag = Type: <b>DWORD</b> The action to be performed. One of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MSGFLT_ADD"></a><a id="msgflt_add"></a><dl>
///             <dt><b>MSGFLT_ADD</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Adds the <i>message</i> to the filter. This
///             has the effect of allowing the message to be received. </td> </tr> <tr> <td width="40%"><a
///             id="MSGFLT_REMOVE"></a><a id="msgflt_remove"></a><dl> <dt><b>MSGFLT_REMOVE</b></dt> <dt>2</dt> </dl> </td> <td
///             width="60%"> Removes the <i>message</i> from the filter. This has the effect of blocking the message. </td> </tr>
///             </table>
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> if successful; otherwise, <b>FALSE</b>. To get extended error information, call
///    GetLastError. <div class="alert"><b>Note</b> A message can be successfully removed from the filter, but that is
///    not a guarantee that the message will be blocked. See the Remarks section for more details.</div> <div> </div>
///    
@DllImport("USER32")
BOOL ChangeWindowMessageFilter(uint message, uint dwFlag);

///Modifies the User Interface Privilege Isolation (UIPI) message filter for a specified window.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window whose UIPI message filter is to be modified.
///    message = Type: <b>UINT</b> The message that the message filter allows through or blocks.
///    action = Type: <b>DWORD</b> The action to be performed, and can take one of the following values: <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MSGFLT_ALLOW"></a><a id="msgflt_allow"></a><dl>
///             <dt><b>MSGFLT_ALLOW</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Allows the message through the filter. This
///             enables the message to be received by <i>hWnd</i>, regardless of the source of the message, even it comes from a
///             lower privileged process. </td> </tr> <tr> <td width="40%"><a id="MSGFLT_DISALLOW"></a><a
///             id="msgflt_disallow"></a><dl> <dt><b>MSGFLT_DISALLOW</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Blocks the
///             message to be delivered to <i>hWnd</i> if it comes from a lower privileged process, unless the message is allowed
///             process-wide by using the ChangeWindowMessageFilter function or globally. </td> </tr> <tr> <td width="40%"><a
///             id="MSGFLT_RESET"></a><a id="msgflt_reset"></a><dl> <dt><b>MSGFLT_RESET</b></dt> <dt>0</dt> </dl> </td> <td
///             width="60%"> Resets the window message filter for <i>hWnd</i> to the default. Any message allowed globally or
///             process-wide will get through, but any message not included in those two categories, and which comes from a lower
///             privileged process, will be blocked. </td> </tr> </table>
///    pChangeFilterStruct = Type: <b>PCHANGEFILTERSTRUCT</b> Optional pointer to a CHANGEFILTERSTRUCT structure.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, it returns <b>TRUE</b>; otherwise, it returns <b>FALSE</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ChangeWindowMessageFilterEx(HWND hwnd, uint message, uint action, CHANGEFILTERSTRUCT* pChangeFilterStruct);

///<p class="CCE_Message">[Starting with Windows Vista, the <b>Open</b> and <b>Save As</b> common dialog boxes have been
///superseded by the Common Item Dialog. We recommended that you use the Common Item Dialog API instead of these dialog
///boxes from the Common Dialog Box Library.] Creates an <b>Open</b> dialog box that lets the user specify the drive,
///directory, and the name of a file or set of files to be opened.
///Params:
///    Arg1 = Type: <b>LPOPENFILENAME</b> A pointer to an OPENFILENAME structure that contains information used to initialize
///           the dialog box. When <b>GetOpenFileName</b> returns, this structure contains information about the user's file
///           selection.
///Returns:
///    Type: <b>BOOL</b> If the user specifies a file name and clicks the <b>OK</b> button, the return value is nonzero.
///    The buffer pointed to by the <b>lpstrFile</b> member of the OPENFILENAME structure contains the full path and
///    file name specified by the user. If the user cancels or closes the <b>Open</b> dialog box or an error occurs, the
///    return value is zero. To get extended error information, call the CommDlgExtendedError function, which can return
///    one of the following values.
///    
@DllImport("COMDLG32")
BOOL GetOpenFileNameA(OPENFILENAMEA* param0);

///<p class="CCE_Message">[Starting with Windows Vista, the <b>Open</b> and <b>Save As</b> common dialog boxes have been
///superseded by the Common Item Dialog. We recommended that you use the Common Item Dialog API instead of these dialog
///boxes from the Common Dialog Box Library.] Creates an <b>Open</b> dialog box that lets the user specify the drive,
///directory, and the name of a file or set of files to be opened.
///Params:
///    Arg1 = Type: <b>LPOPENFILENAME</b> A pointer to an OPENFILENAME structure that contains information used to initialize
///           the dialog box. When <b>GetOpenFileName</b> returns, this structure contains information about the user's file
///           selection.
///Returns:
///    Type: <b>BOOL</b> If the user specifies a file name and clicks the <b>OK</b> button, the return value is nonzero.
///    The buffer pointed to by the <b>lpstrFile</b> member of the OPENFILENAME structure contains the full path and
///    file name specified by the user. If the user cancels or closes the <b>Open</b> dialog box or an error occurs, the
///    return value is zero. To get extended error information, call the CommDlgExtendedError function, which can return
///    one of the following values.
///    
@DllImport("COMDLG32")
BOOL GetOpenFileNameW(OPENFILENAMEW* param0);

///<p class="CCE_Message">[Starting with Windows Vista, the <b>Open</b> and <b>Save As</b> common dialog boxes have been
///superseded by the Common Item Dialog. We recommended that you use the Common Item Dialog API instead of these dialog
///boxes from the Common Dialog Box Library.] Creates a <b>Save</b> dialog box that lets the user specify the drive,
///directory, and name of a file to save.
///Params:
///    Arg1 = Type: <b>LPOPENFILENAME</b> A pointer to an OPENFILENAME structure that contains information used to initialize
///           the dialog box. When <b>GetSaveFileName</b> returns, this structure contains information about the user's file
///           selection.
///Returns:
///    Type: <b>BOOL</b> If the user specifies a file name and clicks the <b>OK</b> button and the function is
///    successful, the return value is nonzero. The buffer pointed to by the <b>lpstrFile</b> member of the OPENFILENAME
///    structure contains the full path and file name specified by the user. If the user cancels or closes the
///    <b>Save</b> dialog box or an error such as the file name buffer being too small occurs, the return value is zero.
///    To get extended error information, call the CommDlgExtendedError function, which can return one of the following
///    values:
///    
@DllImport("COMDLG32")
BOOL GetSaveFileNameA(OPENFILENAMEA* param0);

///<p class="CCE_Message">[Starting with Windows Vista, the <b>Open</b> and <b>Save As</b> common dialog boxes have been
///superseded by the Common Item Dialog. We recommended that you use the Common Item Dialog API instead of these dialog
///boxes from the Common Dialog Box Library.] Creates a <b>Save</b> dialog box that lets the user specify the drive,
///directory, and name of a file to save.
///Params:
///    Arg1 = Type: <b>LPOPENFILENAME</b> A pointer to an OPENFILENAME structure that contains information used to initialize
///           the dialog box. When <b>GetSaveFileName</b> returns, this structure contains information about the user's file
///           selection.
///Returns:
///    Type: <b>BOOL</b> If the user specifies a file name and clicks the <b>OK</b> button and the function is
///    successful, the return value is nonzero. The buffer pointed to by the <b>lpstrFile</b> member of the OPENFILENAME
///    structure contains the full path and file name specified by the user. If the user cancels or closes the
///    <b>Save</b> dialog box or an error such as the file name buffer being too small occurs, the return value is zero.
///    To get extended error information, call the CommDlgExtendedError function, which can return one of the following
///    values:
///    
@DllImport("COMDLG32")
BOOL GetSaveFileNameW(OPENFILENAMEW* param0);

///Retrieves the name of the specified file.
///Params:
///    arg1 = Type: <b>LPCTSTR</b> The name and location of a file.
///    Buf = Type: <b>LPTSTR</b> The buffer that receives the name of the file.
///    cchSize = Type: <b>WORD</b> The length, in characters, of the buffer pointed to by the <i>lpszTitle</i> parameter.
///Returns:
///    Type: <b>short</b> If the function succeeds, the return value is zero. If the file name is invalid, the return
///    value is unknown. If there is an error, the return value is a negative number. If the buffer pointed to by the
///    <i>lpszTitle</i> parameter is too small, the return value is a positive integer that specifies the required
///    buffer size, in characters. The required buffer size includes the terminating null character.
///    
@DllImport("COMDLG32")
short GetFileTitleA(const(PSTR) param0, PSTR Buf, ushort cchSize);

///Retrieves the name of the specified file.
///Params:
///    arg1 = Type: <b>LPCTSTR</b> The name and location of a file.
///    Buf = Type: <b>LPTSTR</b> The buffer that receives the name of the file.
///    cchSize = Type: <b>WORD</b> The length, in characters, of the buffer pointed to by the <i>lpszTitle</i> parameter.
///Returns:
///    Type: <b>short</b> If the function succeeds, the return value is zero. If the file name is invalid, the return
///    value is unknown. If there is an error, the return value is a negative number. If the buffer pointed to by the
///    <i>lpszTitle</i> parameter is too small, the return value is a positive integer that specifies the required
///    buffer size, in characters. The required buffer size includes the terminating null character.
///    
@DllImport("COMDLG32")
short GetFileTitleW(const(PWSTR) param0, PWSTR Buf, ushort cchSize);

@DllImport("COMDLG32")
BOOL ChooseColorA(CHOOSECOLORA* param0);

@DllImport("COMDLG32")
BOOL ChooseColorW(CHOOSECOLORW* param0);

///Creates a system-defined modeless <b>Find</b> dialog box that lets the user specify a string to search for and
///options to use when searching for text in a document.
///Params:
///    Arg1 = Type: <b>LPFINDREPLACE</b> A pointer to a FINDREPLACE structure that contains information used to initialize the
///           dialog box. The dialog box uses this structure to send information about the user's input to your application.
///           For more information, see the following Remarks section.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. You can use
///    the window handle to communicate with or to close the dialog box. If the function fails, the return value is
///    <b>NULL</b>. To get extended error information, call the CommDlgExtendedError function.
///    <b>CommDlgExtendedError</b> may return one of the following error codes:
///    
@DllImport("COMDLG32")
HWND FindTextA(FINDREPLACEA* param0);

///Creates a system-defined modeless <b>Find</b> dialog box that lets the user specify a string to search for and
///options to use when searching for text in a document.
///Params:
///    Arg1 = Type: <b>LPFINDREPLACE</b> A pointer to a FINDREPLACE structure that contains information used to initialize the
///           dialog box. The dialog box uses this structure to send information about the user's input to your application.
///           For more information, see the following Remarks section.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. You can use
///    the window handle to communicate with or to close the dialog box. If the function fails, the return value is
///    <b>NULL</b>. To get extended error information, call the CommDlgExtendedError function.
///    <b>CommDlgExtendedError</b> may return one of the following error codes:
///    
@DllImport("COMDLG32")
HWND FindTextW(FINDREPLACEW* param0);

///Creates a system-defined modeless dialog box that lets the user specify a string to search for and a replacement
///string, as well as options to control the find and replace operations.
///Params:
///    Arg1 = Type: <b>LPFINDREPLACE</b> A pointer to a FINDREPLACE structure that contains information used to initialize the
///           dialog box. The dialog box uses this structure to send information about the user's input to your application.
///           For more information, see the following Remarks section.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. You can use
///    the window handle to communicate with the dialog box or close it. If the function fails, the return value is
///    <b>NULL</b>. To get extended error information, call the CommDlgExtendedError function, which can return one of
///    the following error codes:
///    
@DllImport("COMDLG32")
HWND ReplaceTextA(FINDREPLACEA* param0);

///Creates a system-defined modeless dialog box that lets the user specify a string to search for and a replacement
///string, as well as options to control the find and replace operations.
///Params:
///    Arg1 = Type: <b>LPFINDREPLACE</b> A pointer to a FINDREPLACE structure that contains information used to initialize the
///           dialog box. The dialog box uses this structure to send information about the user's input to your application.
///           For more information, see the following Remarks section.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the window handle to the dialog box. You can use
///    the window handle to communicate with the dialog box or close it. If the function fails, the return value is
///    <b>NULL</b>. To get extended error information, call the CommDlgExtendedError function, which can return one of
///    the following error codes:
///    
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

///Returns a common dialog box error code. This code indicates the most recent error to occur during the execution of
///one of the common dialog box functions.
///Returns:
///    Type: <b>DWORD</b> If the most recent call to a common dialog box function succeeded, the return value is
///    undefined. If the common dialog box function returned <b>FALSE</b> because the user closed or canceled the dialog
///    box, the return value is zero. Otherwise, the return value is a nonzero error code. The
///    <b>CommDlgExtendedError</b> function can return general error codes for any of the common dialog box functions.
///    In addition, there are error codes that are returned only for a specific common dialog box. All of these error
///    codes are defined in Cderr.h. The following general error codes can be returned for any of the common dialog box
///    functions. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_DIALOGFAILURE</b></dt> <dt>0xFFFF</dt> </dl> </td> <td width="60%"> The dialog box could not be
///    created. The common dialog box function's call to the DialogBox function failed. For example, this error occurs
///    if the common dialog box call specifies an invalid window handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_FINDRESFAILURE</b></dt> <dt>0x0006</dt> </dl> </td> <td width="60%"> The common dialog box function
///    failed to find a specified resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CDERR_INITIALIZATION</b></dt>
///    <dt>0x0002</dt> </dl> </td> <td width="60%"> The common dialog box function failed during initialization. This
///    error often occurs when sufficient memory is not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_LOADRESFAILURE</b></dt> <dt>0x0007</dt> </dl> </td> <td width="60%"> The common dialog box function
///    failed to load a specified resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CDERR_LOADSTRFAILURE</b></dt>
///    <dt>0x0005</dt> </dl> </td> <td width="60%"> The common dialog box function failed to load a specified string.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CDERR_LOCKRESFAILURE</b></dt> <dt>0x0008</dt> </dl> </td> <td
///    width="60%"> The common dialog box function failed to lock a specified resource. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>CDERR_MEMALLOCFAILURE</b></dt> <dt>0x0009</dt> </dl> </td> <td width="60%"> The common
///    dialog box function was unable to allocate memory for internal structures. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_MEMLOCKFAILURE</b></dt> <dt>0x000A</dt> </dl> </td> <td width="60%"> The common dialog box function
///    was unable to lock the memory associated with a handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_NOHINSTANCE</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> The <b>ENABLETEMPLATE</b> flag was
///    set in the <b>Flags</b> member of the initialization structure for the corresponding common dialog box, but you
///    failed to provide a corresponding instance handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_NOHOOK</b></dt> <dt>0x000B</dt> </dl> </td> <td width="60%"> The <b>ENABLEHOOK</b> flag was set in
///    the <b>Flags</b> member of the initialization structure for the corresponding common dialog box, but you failed
///    to provide a pointer to a corresponding hook procedure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_NOTEMPLATE</b></dt> <dt>0x0003</dt> </dl> </td> <td width="60%"> The <b>ENABLETEMPLATE</b> flag was
///    set in the <b>Flags</b> member of the initialization structure for the corresponding common dialog box, but you
///    failed to provide a corresponding template. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CDERR_REGISTERMSGFAIL</b></dt> <dt>0x000C</dt> </dl> </td> <td width="60%"> The RegisterWindowMessage
///    function returned an error code when it was called by the common dialog box function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>CDERR_STRUCTSIZE</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> The
///    <b>lStructSize</b> member of the initialization structure for the corresponding common dialog box is invalid.
///    </td> </tr> </table> The following error codes can be returned for the PrintDlg function. <table> <tr> <th>Return
///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PDERR_CREATEICFAILURE</b></dt>
///    <dt>0x100A</dt> </dl> </td> <td width="60%"> The PrintDlg function failed when it attempted to create an
///    information context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDERR_DEFAULTDIFFERENT</b></dt>
///    <dt>0x100C</dt> </dl> </td> <td width="60%"> You called the PrintDlg function with the <b>DN_DEFAULTPRN</b> flag
///    specified in the <b>wDefault</b> member of the DEVNAMES structure, but the printer described by the other
///    structure members did not match the current default printer. This error occurs when you store the <b>DEVNAMES</b>
///    structure, and the user changes the default printer by using the Control Panel. To use the printer described by
///    the DEVNAMES structure, clear the <b>DN_DEFAULTPRN</b> flag and call PrintDlg again. To use the default printer,
///    replace the DEVNAMES structure (and the structure, if one exists) with <b>NULL</b>; and call PrintDlg again.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDERR_DNDMMISMATCH</b></dt> <dt>0x1009</dt> </dl> </td> <td
///    width="60%"> The data in the DEVMODE and DEVNAMES structures describes two different printers. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>PDERR_GETDEVMODEFAIL</b></dt> <dt>0x1005</dt> </dl> </td> <td width="60%"> The
///    printer driver failed to initialize a DEVMODE structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDERR_INITFAILURE</b></dt> <dt>0x1006</dt> </dl> </td> <td width="60%"> The PrintDlg function failed
///    during initialization, and there is no more specific extended error code to describe the failure. This is the
///    generic default error code for the function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDERR_LOADDRVFAILURE</b></dt> <dt>0x1004</dt> </dl> </td> <td width="60%"> The PrintDlg function failed to
///    load the device driver for the specified printer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDERR_NODEFAULTPRN</b></dt> <dt>0x1008</dt> </dl> </td> <td width="60%"> A default printer does not exist.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDERR_NODEVICES</b></dt> <dt>0x1007</dt> </dl> </td> <td
///    width="60%"> No printer drivers were found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDERR_PARSEFAILURE</b></dt> <dt>0x1002</dt> </dl> </td> <td width="60%"> The PrintDlg function failed to
///    parse the strings in the [devices] section of the WIN.INI file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDERR_PRINTERNOTFOUND</b></dt> <dt>0x100B</dt> </dl> </td> <td width="60%"> The [devices] section of the
///    WIN.INI file did not contain an entry for the requested printer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PDERR_RETDEFFAILURE</b></dt> <dt>0x1003</dt> </dl> </td> <td width="60%"> The PD_RETURNDEFAULT flag was
///    specified in the <b>Flags</b> member of the PRINTDLG structure, but the <b>hDevMode</b> or <b>hDevNames</b>
///    member was not <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PDERR_SETUPFAILURE</b></dt>
///    <dt>0x1001</dt> </dl> </td> <td width="60%"> The PrintDlg function failed to load the required resources. </td>
///    </tr> </table> The following error codes can be returned for the ChooseFont function. <table> <tr> <th>Return
///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>CFERR_MAXLESSTHANMIN</b></dt>
///    <dt>CFERR_MAXLESSTHANMIN</dt> </dl> </td> <td width="60%"> The size specified in the <b>nSizeMax</b> member of
///    the CHOOSEFONT structure is less than the size specified in the <b>nSizeMin</b> member. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>CFERR_NOFONTS</b></dt> <dt>0x2001</dt> </dl> </td> <td width="60%"> No fonts exist.
///    </td> </tr> </table> The following error codes can be returned for the GetOpenFileName and GetSaveFileName
///    functions. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FNERR_BUFFERTOOSMALL</b></dt> <dt>0x3003</dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <b>lpstrFile</b> member of the OPENFILENAME structure is too small for the file name specified by the user. The
///    first two bytes of the <b>lpstrFile</b> buffer contain an integer value specifying the size required to receive
///    the full name, in characters. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FNERR_INVALIDFILENAME</b></dt>
///    <dt>0x3002</dt> </dl> </td> <td width="60%"> A file name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FNERR_SUBCLASSFAILURE</b></dt> <dt>0x3001</dt> </dl> </td> <td width="60%"> An attempt to subclass a list
///    box failed because sufficient memory was not available. </td> </tr> </table> The following error code can be
///    returned for the FindText and ReplaceText functions. <table> <tr> <th>Return code/value</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>FRERR_BUFFERLENGTHZERO</b></dt> <dt>0x4001</dt> </dl> </td> <td
///    width="60%"> A member of the FINDREPLACE structure points to an invalid buffer. </td> </tr> </table>
///    
@DllImport("COMDLG32")
uint CommDlgExtendedError();

@DllImport("COMDLG32")
BOOL PageSetupDlgA(PAGESETUPDLGA* param0);

@DllImport("COMDLG32")
BOOL PageSetupDlgW(PAGESETUPDLGW* param0);


// Interfaces

///Provides methods that enable an application to receive notifications and messages from the PrintDlgEx function while
///the Print Property Sheet is displayed.
@GUID("5852A2C3-6530-11D1-B6A3-0000F8757BF9")
interface IPrintDialogCallback : IUnknown
{
    ///Called by PrintDlgEx when the system has finished initializing the <b>General</b> page of the Print Property
    ///Sheet.
    ///Returns:
    ///    Type: <b>HRESULT</b> Return <b>S_OK</b> to prevent the PrintDlgEx function from performing its default
    ///    actions. Return <b>S_FALSE</b> to allow PrintDlgEx to perform its default actions. Currently,
    ///    <b>PrintDlgEx</b> does not perform any default processing after the <b>InitDone</b> call.
    ///    
    HRESULT InitDone();
    ///Called by PrintDlgEx when the user selects a different printer from the list of installed printers on the
    ///<b>General</b> page of the Print Property Sheet.
    ///Returns:
    ///    Type: <b>HRESULT</b> Return <b>S_OK</b> to prevent the PrintDlgEx function from performing its default
    ///    actions. Return <b>S_FALSE</b> to allow PrintDlgEx to perform its default actions, which include adjustments
    ///    to the <b>Copies</b>, <b>Collate</b>, and <b>Print Range</b> items.
    ///    
    HRESULT SelectionChange();
    ///Called by PrintDlgEx to give your application an opportunity to handle messages sent to the child dialog box in
    ///the lower portion of the <b>General</b> page of the Print Property Sheet. The child dialog box contains controls
    ///similar to those of the <b>Print</b> dialog box.
    ///Params:
    ///    hDlg = Type: <b>HWND</b> A handle to the child dialog box in the lower portion of the <b>General</b> page.
    ///    uMsg = Type: <b>UINT</b> The identifier of the message being received.
    ///    wParam = Type: <b>WPARAM</b> Additional information about the message. The exact meaning depends on the value of the
    ///             <i>uMsg</i> parameter.
    ///    lParam = Type: <b>LPARAM</b> Additional information about the message. The exact meaning depends on the value of the
    ///             <i>uMsg</i> parameter. If the <i>uMsg</i> parameter indicates the WM_INITDIALOG message, <i>lParam</i> is a
    ///             pointer to a PRINTDLGEX structure containing the values specified when the property sheet was created.
    ///    pResult = Type: <b>LRESULT*</b> Indicates the result to be returned by the dialog box procedure for the message. The
    ///              value pointed to should be <b>TRUE</b> if you process the message, otherwise it should be <b>FALSE</b> or
    ///              whatever is an appropriate value according to the message type.
    ///Returns:
    ///    Type: <b>HRESULT</b> Return <b>S_OK</b> if your <b>IPrintDialogCallback::HandleMessage</b> implementation
    ///    handled the message. In this case, the PrintDlgEx function does not perform any default message handling.
    ///    Return <b>S_FALSE</b> if you want PrintDlgEx to perform its default message handling.
    ///    
    HRESULT HandleMessage(HWND hDlg, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* pResult);
}

///Provides methods that enable an application using the PrintDlgEx function to retrieve information about the currently
///selected printer.
@GUID("509AAEDA-5639-11D1-B6A1-0000F8757BF9")
interface IPrintDialogServices : IUnknown
{
    ///Fills a DEVMODE structure with information about the currently selected printer for use with PrintDlgEx.
    ///Params:
    ///    pDevMode = Type: <b>LPDEVMODE</b> A pointer to a buffer that receives a DEVMODE structure containing information about
    ///               the currently selected printer.
    ///    pcbSize = Type: <b>UINT*</b> On input, the variable specifies the size, in bytes, of the buffer pointed to by the
    ///              <i>lpDevMode</i> parameter. On output, the variable contains the number of bytes written to <i>lpDevMode</i>.
    ///              If the size is zero on input, the function returns the required buffer size (in bytes) in <i>pcbSize</i> and
    ///              does not use the <i>lpDevMode</i> buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method is successful, the return value is <b>S_OK</b>. If no printer is currently
    ///    selected, the return value is <b>S_OK</b>, the value returned in <i>pcbSize</i> is zero, and the
    ///    <i>lpDevMode</i> buffer is unchanged. If an error occurs, the return value is a COM error code. For more
    ///    information, see Error Handling.
    ///    
    HRESULT GetCurrentDevMode(DEVMODEA* pDevMode, uint* pcbSize);
    ///Retrieves the name of the currently selected printer, for use with PrintDlgEx.
    ///Params:
    ///    pPrinterName = Type: <b>LPTSTR</b> The name of the currently selected printer.
    ///    pcchSize = Type: <b>UINT*</b> On input, the variable specifies the size, in characters, of the buffer pointed to by the
    ///               <i>lpPrinterName</i> parameter. On output, the variable contains the number of bytes (ANSI) or characters
    ///               (Unicode), including the terminating null character, written to the buffer. If the size is zero on input, the
    ///               function returns the required buffer size (in bytes or characters) in <i>pcchSize</i> and does not use the
    ///               <i>lpPrinterName</i> buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method is successful, the return value is <b>S_OK</b>. If no printer is currently
    ///    selected, the return value is <b>S_OK</b>, the value returned in <i>pcchSize</i> is zero, and the
    ///    <i>lpPrinterName</i> buffer is unchanged. If an error occurs, the return value is a COM error code. For more
    ///    information, see Error Handling.
    ///    
    HRESULT GetCurrentPrinterName(PWSTR pPrinterName, uint* pcchSize);
    ///Retrieves the name of the current port for use with PrintDlgEx.
    ///Params:
    ///    pPortName = Type: <b>LPTSTR</b> The name of the current port.
    ///    pcchSize = Type: <b>UINT*</b> On input, the variable specifies the size, in characters, of the buffer pointed to by the
    ///               <i>lpPortName</i> parameter. On output, the variable contains the number of bytes (ANSI) or characters
    ///               (Unicode), including the terminating null character, written to the buffer. If the size is zero on input, the
    ///               function returns the required buffer size (in bytes or characters) in <i>pcchSize</i> and does not use the
    ///               <i>lpPortName</i> buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method is successful, the return value is <b>S_OK</b>. If there is no current
    ///    port, the return value is <b>S_OK</b>, the value returned in <i>pcchSize</i> is zero, and the
    ///    <i>lpPortName</i> buffer is unchanged. If an error occurs, the return value is a COM error code. For more
    ///    information, see Error Handling.
    ///    
    HRESULT GetCurrentPortName(PWSTR pPortName, uint* pcchSize);
}


// GUIDs


const GUID IID_IPrintDialogCallback = GUIDOF!IPrintDialogCallback;
const GUID IID_IPrintDialogServices = GUIDOF!IPrintDialogServices;
