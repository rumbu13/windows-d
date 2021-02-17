// Written in the D programming language.

module windows.windowsstationsanddesktops;

public import windows.core;
public import windows.displaydevices : DEVMODEW;
public import windows.menusandresources : DESKTOPENUMPROCA, DESKTOPENUMPROCW, WINSTAENUMPROCA,
                                          WINSTAENUMPROCW, WNDENUMPROC;
public import windows.systemservices : BOOL, HANDLE, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : LPARAM;
public import windows.xps : DEVMODEA;

extern(Windows):


// Structs


alias HDESK = ptrdiff_t;

///Contains information about a window station or desktop handle.
struct USEROBJECTFLAGS
{
    ///If this member is TRUE, new processes inherit the handle. Otherwise, the handle is not inherited.
    BOOL fInherit;
    ///Reserved for future use. This member must be FALSE.
    BOOL fReserved;
    ///For window stations, this member can contain the following window station attribute. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="WSF_VISIBLE"></a><a id="wsf_visible"></a><dl>
    ///<dt><b>WSF_VISIBLE</b></dt> <dt>0x0001L</dt> </dl> </td> <td width="60%"> Window station has visible display
    ///surfaces. </td> </tr> </table> For desktops, the <b>dwFlags</b> member can contain the following value. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a
    ///id="df_allowotheraccounthook"></a><dl> <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001L</dt> </dl> </td> <td
    ///width="60%"> Allows processes running in other accounts on the desktop to set hooks in this process. </td> </tr>
    ///</table>
    uint dwFlags;
}

// Functions

///Creates a new desktop, associates it with the current window station of the calling process, and assigns it to the
///calling thread. The calling process must have an associated window station, either assigned by the system at process
///creation time or set by the SetProcessWindowStation function. To specify the size of the heap for the desktop, use
///the CreateDesktopEx function.
///Params:
///    lpszDesktop = The name of the desktop to be created. Desktop names are case-insensitive and may not contain backslash
///                  characters (\\).
///    lpszDevice = Reserved; must be <b>NULL</b>.
///    pDevmode = Reserved; must be <b>NULL</b>.
///    dwFlags = This parameter can be zero or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a id="df_allowotheraccounthook"></a><dl>
///              <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Enables processes running
///              in other accounts on the desktop to set hooks in this process. </td> </tr> </table>
///    dwDesiredAccess = The access to the desktop. For a list of values, see Desktop Security and Access Rights. This parameter must
///                      include the <b>DESKTOP_CREATEWINDOW</b> access right, because internally <b>CreateDesktop</b> uses the handle to
///                      create a window.
///    lpsa = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///           child processes. If <i>lpsa</i> is NULL, the handle cannot be inherited. The <b>lpSecurityDescriptor</b> member
///           of the structure specifies a security descriptor for the new desktop. If this parameter is NULL, the desktop
///           inherits its security descriptor from the parent window station.
///Returns:
///    If the function succeeds, the return value is a handle to the newly created desktop. If the specified desktop
///    already exists, the function succeeds and returns a handle to the existing desktop. When you are finished using
///    the handle, call the CloseDesktop function to close it. If the function fails, the return value is <b>NULL</b>.
///    To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK CreateDesktopA(const(char)* lpszDesktop, const(char)* lpszDevice, DEVMODEA* pDevmode, uint dwFlags, 
                     uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

///Creates a new desktop, associates it with the current window station of the calling process, and assigns it to the
///calling thread. The calling process must have an associated window station, either assigned by the system at process
///creation time or set by the SetProcessWindowStation function. To specify the size of the heap for the desktop, use
///the CreateDesktopEx function.
///Params:
///    lpszDesktop = The name of the desktop to be created. Desktop names are case-insensitive and may not contain backslash
///                  characters (\\).
///    lpszDevice = Reserved; must be <b>NULL</b>.
///    pDevmode = Reserved; must be <b>NULL</b>.
///    dwFlags = This parameter can be zero or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a id="df_allowotheraccounthook"></a><dl>
///              <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Enables processes running
///              in other accounts on the desktop to set hooks in this process. </td> </tr> </table>
///    dwDesiredAccess = The access to the desktop. For a list of values, see Desktop Security and Access Rights. This parameter must
///                      include the <b>DESKTOP_CREATEWINDOW</b> access right, because internally <b>CreateDesktop</b> uses the handle to
///                      create a window.
///    lpsa = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///           child processes. If <i>lpsa</i> is NULL, the handle cannot be inherited. The <b>lpSecurityDescriptor</b> member
///           of the structure specifies a security descriptor for the new desktop. If this parameter is NULL, the desktop
///           inherits its security descriptor from the parent window station.
///Returns:
///    If the function succeeds, the return value is a handle to the newly created desktop. If the specified desktop
///    already exists, the function succeeds and returns a handle to the existing desktop. When you are finished using
///    the handle, call the CloseDesktop function to close it. If the function fails, the return value is <b>NULL</b>.
///    To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK CreateDesktopW(const(wchar)* lpszDesktop, const(wchar)* lpszDevice, DEVMODEW* pDevmode, uint dwFlags, 
                     uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

///Creates a new desktop with the specified heap, associates it with the current window station of the calling process,
///and assigns it to the calling thread. The calling process must have an associated window station, either assigned by
///the system at process creation time or set by the SetProcessWindowStation function.
///Params:
///    lpszDesktop = The name of the desktop to be created. Desktop names are case-insensitive and may not contain backslash
///                  characters (\\).
///    lpszDevice = This parameter is reserved and must be NULL.
///    pDevmode = This parameter is reserved and must be NULL.
///    dwFlags = This parameter can be zero or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a id="df_allowotheraccounthook"></a><dl>
///              <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Enables processes running
///              in other accounts on the desktop to set hooks in this process. </td> </tr> </table>
///    dwDesiredAccess = The requested access to the desktop. For a list of values, see Desktop Security and Access Rights. This parameter
///                      must include the DESKTOP_CREATEWINDOW access right, because internally CreateDesktop uses the handle to create a
///                      window.
///    lpsa = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///           child processes. If <i>lpsa</i> is NULL, the handle cannot be inherited. The <b>lpSecurityDescriptor</b> member
///           of the structure specifies a security descriptor for the new desktop. If this parameter is NULL, the desktop
///           inherits its security descriptor from the parent window station.
///    ulHeapSize = The size of the desktop heap, in kilobytes.
///    pvoid = This parameter is reserved and must be NULL.
///Returns:
///    If the function succeeds, the return value is a handle to the newly created desktop. If the specified desktop
///    already exists, the function succeeds and returns a handle to the existing desktop. When you are finished using
///    the handle, call the CloseDesktop function to close it. If the function fails, the return value is NULL. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK CreateDesktopExA(const(char)* lpszDesktop, const(char)* lpszDevice, DEVMODEA* pDevmode, uint dwFlags, 
                       uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, uint ulHeapSize, void* pvoid);

///Creates a new desktop with the specified heap, associates it with the current window station of the calling process,
///and assigns it to the calling thread. The calling process must have an associated window station, either assigned by
///the system at process creation time or set by the SetProcessWindowStation function.
///Params:
///    lpszDesktop = The name of the desktop to be created. Desktop names are case-insensitive and may not contain backslash
///                  characters (\\).
///    lpszDevice = This parameter is reserved and must be NULL.
///    pDevmode = This parameter is reserved and must be NULL.
///    dwFlags = This parameter can be zero or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a id="df_allowotheraccounthook"></a><dl>
///              <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Enables processes running
///              in other accounts on the desktop to set hooks in this process. </td> </tr> </table>
///    dwDesiredAccess = The requested access to the desktop. For a list of values, see Desktop Security and Access Rights. This parameter
///                      must include the DESKTOP_CREATEWINDOW access right, because internally CreateDesktop uses the handle to create a
///                      window.
///    lpsa = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///           child processes. If <i>lpsa</i> is NULL, the handle cannot be inherited. The <b>lpSecurityDescriptor</b> member
///           of the structure specifies a security descriptor for the new desktop. If this parameter is NULL, the desktop
///           inherits its security descriptor from the parent window station.
///    ulHeapSize = The size of the desktop heap, in kilobytes.
///    pvoid = This parameter is reserved and must be NULL.
///Returns:
///    If the function succeeds, the return value is a handle to the newly created desktop. If the specified desktop
///    already exists, the function succeeds and returns a handle to the existing desktop. When you are finished using
///    the handle, call the CloseDesktop function to close it. If the function fails, the return value is NULL. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK CreateDesktopExW(const(wchar)* lpszDesktop, const(wchar)* lpszDevice, DEVMODEW* pDevmode, uint dwFlags, 
                       uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, uint ulHeapSize, void* pvoid);

///Opens the specified desktop object.
///Params:
///    lpszDesktop = The name of the desktop to be opened. Desktop names are case-insensitive. This desktop must belong to the current
///                  window station.
///    dwFlags = This parameter can be zero or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a id="df_allowotheraccounthook"></a><dl>
///              <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Allows processes running in
///              other accounts on the desktop to set hooks in this process. </td> </tr> </table>
///    fInherit = If this value is <b>TRUE</b>, processes created by this process will inherit the handle. Otherwise, the processes
///               do not inherit this handle.
///    dwDesiredAccess = The access to the desktop. For a list of access rights, see Desktop Security and Access Rights.
///Returns:
///    If the function succeeds, the return value is a handle to the opened desktop. When you are finished using the
///    handle, call the CloseDesktop function to close it. If the function fails, the return value is <b>NULL</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK OpenDesktopA(const(char)* lpszDesktop, uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

///Opens the specified desktop object.
///Params:
///    lpszDesktop = The name of the desktop to be opened. Desktop names are case-insensitive. This desktop must belong to the current
///                  window station.
///    dwFlags = This parameter can be zero or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a id="df_allowotheraccounthook"></a><dl>
///              <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Allows processes running in
///              other accounts on the desktop to set hooks in this process. </td> </tr> </table>
///    fInherit = If this value is <b>TRUE</b>, processes created by this process will inherit the handle. Otherwise, the processes
///               do not inherit this handle.
///    dwDesiredAccess = The access to the desktop. For a list of access rights, see Desktop Security and Access Rights.
///Returns:
///    If the function succeeds, the return value is a handle to the opened desktop. When you are finished using the
///    handle, call the CloseDesktop function to close it. If the function fails, the return value is <b>NULL</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK OpenDesktopW(const(wchar)* lpszDesktop, uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

///Opens the desktop that receives user input.
///Params:
///    dwFlags = This parameter can be zero or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DF_ALLOWOTHERACCOUNTHOOK"></a><a id="df_allowotheraccounthook"></a><dl>
///              <dt><b>DF_ALLOWOTHERACCOUNTHOOK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Allows processes running in
///              other accounts on the desktop to set hooks in this process. </td> </tr> </table>
///    fInherit = If this value is <b>TRUE</b>, processes created by this process will inherit the handle. Otherwise, the processes
///               do not inherit this handle.
///    dwDesiredAccess = The access to the desktop. For a list of access rights, see Desktop Security and Access Rights.
///Returns:
///    If the function succeeds, the return value is a handle to the desktop that receives user input. When you are
///    finished using the handle, call the CloseDesktop function to close it. If the function fails, the return value is
///    <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK OpenInputDesktop(uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

///Enumerates all desktops associated with the specified window station of the calling process. The function passes the
///name of each desktop, in turn, to an application-defined callback function.
///Params:
///    hwinsta = A handle to the window station whose desktops are to be enumerated. This handle is returned by the
///              CreateWindowStation, GetProcessWindowStation, or OpenWindowStation function, and must have the
///              WINSTA_ENUMDESKTOPS access right. For more information, see Window Station Security and Access Rights. If this
///              parameter is NULL, the current window station is used.
///    lpEnumFunc = A pointer to an application-defined EnumDesktopProc callback function.
///    lParam = An application-defined value to be passed to the callback function.
///Returns:
///    If the function succeeds, it returns the nonzero value returned by the callback function that was pointed to by
///    <i>lpEnumFunc</i>. If the function is unable to perform the enumeration, the return value is zero. Call
///    GetLastError to get extended error information. If the callback function fails, the return value is zero. The
///    callback function can call SetLastError to set an error code for the caller to retrieve by calling GetLastError.
///    
@DllImport("USER32")
BOOL EnumDesktopsA(ptrdiff_t hwinsta, DESKTOPENUMPROCA lpEnumFunc, LPARAM lParam);

///Enumerates all desktops associated with the specified window station of the calling process. The function passes the
///name of each desktop, in turn, to an application-defined callback function.
///Params:
///    hwinsta = A handle to the window station whose desktops are to be enumerated. This handle is returned by the
///              CreateWindowStation, GetProcessWindowStation, or OpenWindowStation function, and must have the
///              WINSTA_ENUMDESKTOPS access right. For more information, see Window Station Security and Access Rights. If this
///              parameter is NULL, the current window station is used.
///    lpEnumFunc = A pointer to an application-defined EnumDesktopProc callback function.
///    lParam = An application-defined value to be passed to the callback function.
///Returns:
///    If the function succeeds, it returns the nonzero value returned by the callback function that was pointed to by
///    <i>lpEnumFunc</i>. If the function is unable to perform the enumeration, the return value is zero. Call
///    GetLastError to get extended error information. If the callback function fails, the return value is zero. The
///    callback function can call SetLastError to set an error code for the caller to retrieve by calling GetLastError.
///    
@DllImport("USER32")
BOOL EnumDesktopsW(ptrdiff_t hwinsta, DESKTOPENUMPROCW lpEnumFunc, LPARAM lParam);

///Enumerates all top-level windows associated with the specified desktop. It passes the handle to each window, in turn,
///to an application-defined callback function.
///Params:
///    hDesktop = A handle to the desktop whose top-level windows are to be enumerated. This handle is returned by the
///               CreateDesktop, GetThreadDesktop, OpenDesktop, or OpenInputDesktop function, and must have the
///               <b>DESKTOP_READOBJECTS</b> access right. For more information, see Desktop Security and Access Rights. If this
///               parameter is NULL, the current desktop is used.
///    lpfn = A pointer to an application-defined EnumWindowsProc callback function.
///    lParam = An application-defined value to be passed to the callback function.
///Returns:
///    If the function fails or is unable to perform the enumeration, the return value is zero. To get extended error
///    information, call GetLastError. You must ensure that the callback function sets SetLastError if it fails.
///    <b>Windows Server 2003 and Windows XP/2000: </b>If there are no windows on the desktop, GetLastError returns
///    <b>ERROR_INVALID_HANDLE</b>.
///    
@DllImport("USER32")
BOOL EnumDesktopWindows(HDESK hDesktop, WNDENUMPROC lpfn, LPARAM lParam);

///Makes the specified desktop visible and activates it. This enables the desktop to receive input from the user. The
///calling process must have DESKTOP_SWITCHDESKTOP access to the desktop for the <b>SwitchDesktop</b> function to
///succeed.
///Params:
///    hDesktop = A handle to the desktop. This handle is returned by the CreateDesktop and OpenDesktop functions. This desktop
///               must be associated with the current window station for the process.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. However, <b>SwitchDesktop</b> only sets the last error for the
///    following cases: <ul> <li>When the desktop belongs to an invisible window station</li> <li>When <i>hDesktop</i>
///    is an invalid handle, refers to a destroyed desktop, or belongs to a different session than that of the calling
///    process</li> </ul>
///    
@DllImport("USER32")
BOOL SwitchDesktop(HDESK hDesktop);

///Assigns the specified desktop to the calling thread. All subsequent operations on the desktop use the access rights
///granted to the desktop.
///Params:
///    hDesktop = A handle to the desktop to be assigned to the calling thread. This handle is returned by the CreateDesktop,
///               GetThreadDesktop, OpenDesktop, or OpenInputDesktop function. This desktop must be associated with the current
///               window station for the process.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetThreadDesktop(HDESK hDesktop);

///Closes an open handle to a desktop object.
///Params:
///    hDesktop = A handle to the desktop to be closed. This can be a handle returned by the CreateDesktop, OpenDesktop, or
///               OpenInputDesktop functions. Do not specify the handle returned by the GetThreadDesktop function.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL CloseDesktop(HDESK hDesktop);

///Retrieves a handle to the desktop assigned to the specified thread.
///Params:
///    dwThreadId = The thread identifier. The GetCurrentThreadId and CreateProcess functions return thread identifiers.
///Returns:
///    If the function succeeds, the return value is a handle to the desktop associated with the specified thread. You
///    do not need to call the CloseDesktop function to close the returned handle. If the function fails, the return
///    value is NULL. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HDESK GetThreadDesktop(uint dwThreadId);

///Creates a window station object, associates it with the calling process, and assigns it to the current session.
///Params:
///    lpwinsta = The name of the window station to be created. Window station names are case-insensitive and cannot contain
///               backslash characters (\\). Only members of the Administrators group are allowed to specify a name. If
///               <i>lpwinsta</i> is <b>NULL</b> or an empty string, the system forms a window station name using the logon session
///               identifier for the calling process. To get this name, call the GetUserObjectInformation function.
///    dwFlags = If this parameter is <b>CWF_CREATE_ONLY</b> and the window station already exists, the call fails. If this flag
///              is not specified and the window station already exists, the function succeeds and returns a new handle to the
///              existing window station. <b>Windows XP/2000: </b>This parameter is reserved and must be zero.
///    dwDesiredAccess = The type of access the returned handle has to the window station. In addition, you can specify any of the
///                      standard access rights, such as <b>READ_CONTROL</b> or <b>WRITE_DAC</b>, and a combination of the window
///                      station-specific access rights. For more information, see Window Station Security and Access Rights.
///    lpsa = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///           child processes. If <i>lpsa</i> is <b>NULL</b>, the handle cannot be inherited. The <b>lpSecurityDescriptor</b>
///           member of the structure specifies a security descriptor for the new window station. If <i>lpsa</i> is
///           <b>NULL</b>, the window station (and any desktops created within the window) gets a security descriptor that
///           grants <b>GENERIC_ALL</b> access to all users.
///Returns:
///    If the function succeeds, the return value is a handle to the newly created window station. If the specified
///    window station already exists, the function succeeds and returns a handle to the existing window station. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t CreateWindowStationA(const(char)* lpwinsta, uint dwFlags, uint dwDesiredAccess, 
                               SECURITY_ATTRIBUTES* lpsa);

///Creates a window station object, associates it with the calling process, and assigns it to the current session.
///Params:
///    lpwinsta = The name of the window station to be created. Window station names are case-insensitive and cannot contain
///               backslash characters (\\). Only members of the Administrators group are allowed to specify a name. If
///               <i>lpwinsta</i> is <b>NULL</b> or an empty string, the system forms a window station name using the logon session
///               identifier for the calling process. To get this name, call the GetUserObjectInformation function.
///    dwFlags = If this parameter is <b>CWF_CREATE_ONLY</b> and the window station already exists, the call fails. If this flag
///              is not specified and the window station already exists, the function succeeds and returns a new handle to the
///              existing window station. <b>Windows XP/2000: </b>This parameter is reserved and must be zero.
///    dwDesiredAccess = The type of access the returned handle has to the window station. In addition, you can specify any of the
///                      standard access rights, such as <b>READ_CONTROL</b> or <b>WRITE_DAC</b>, and a combination of the window
///                      station-specific access rights. For more information, see Window Station Security and Access Rights.
///    lpsa = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///           child processes. If <i>lpsa</i> is <b>NULL</b>, the handle cannot be inherited. The <b>lpSecurityDescriptor</b>
///           member of the structure specifies a security descriptor for the new window station. If <i>lpsa</i> is
///           <b>NULL</b>, the window station (and any desktops created within the window) gets a security descriptor that
///           grants <b>GENERIC_ALL</b> access to all users.
///Returns:
///    If the function succeeds, the return value is a handle to the newly created window station. If the specified
///    window station already exists, the function succeeds and returns a handle to the existing window station. If the
///    function fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t CreateWindowStationW(const(wchar)* lpwinsta, uint dwFlags, uint dwDesiredAccess, 
                               SECURITY_ATTRIBUTES* lpsa);

///Opens the specified window station.
///Params:
///    lpszWinSta = The name of the window station to be opened. Window station names are case-insensitive. This window station must
///                 belong to the current session.
///    fInherit = If this value is <b>TRUE</b>, processes created by this process will inherit the handle. Otherwise, the processes
///               do not inherit this handle.
///    dwDesiredAccess = The access to the window station. For a list of access rights, see Window Station Security and Access Rights.
///Returns:
///    If the function succeeds, the return value is the handle to the specified window station. If the function fails,
///    the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t OpenWindowStationA(const(char)* lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

///Opens the specified window station.
///Params:
///    lpszWinSta = The name of the window station to be opened. Window station names are case-insensitive. This window station must
///                 belong to the current session.
///    fInherit = If this value is <b>TRUE</b>, processes created by this process will inherit the handle. Otherwise, the processes
///               do not inherit this handle.
///    dwDesiredAccess = The access to the window station. For a list of access rights, see Window Station Security and Access Rights.
///Returns:
///    If the function succeeds, the return value is the handle to the specified window station. If the function fails,
///    the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t OpenWindowStationW(const(wchar)* lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

///Enumerates all window stations in the current session. The function passes the name of each window station, in turn,
///to an application-defined callback function.
///Params:
///    lpEnumFunc = A pointer to an application-defined EnumWindowStationProc callback function.
///    lParam = An application-defined value to be passed to the callback function.
///Returns:
///    If the function succeeds, it returns the nonzero value returned by the callback function that was pointed to by
///    <i>lpEnumFunc</i>. If the function is unable to perform the enumeration, the return value is zero. Call
///    GetLastError to get extended error information. If the callback function fails, the return value is zero. The
///    callback function can call SetLastError to set an error code for the caller to retrieve by calling GetLastError.
///    
@DllImport("USER32")
BOOL EnumWindowStationsA(WINSTAENUMPROCA lpEnumFunc, LPARAM lParam);

///Enumerates all window stations in the current session. The function passes the name of each window station, in turn,
///to an application-defined callback function.
///Params:
///    lpEnumFunc = A pointer to an application-defined EnumWindowStationProc callback function.
///    lParam = An application-defined value to be passed to the callback function.
///Returns:
///    If the function succeeds, it returns the nonzero value returned by the callback function that was pointed to by
///    <i>lpEnumFunc</i>. If the function is unable to perform the enumeration, the return value is zero. Call
///    GetLastError to get extended error information. If the callback function fails, the return value is zero. The
///    callback function can call SetLastError to set an error code for the caller to retrieve by calling GetLastError.
///    
@DllImport("USER32")
BOOL EnumWindowStationsW(WINSTAENUMPROCW lpEnumFunc, LPARAM lParam);

///Closes an open window station handle.
///Params:
///    hWinSta = A handle to the window station to be closed. This handle is returned by the CreateWindowStation or
///              OpenWindowStation function. Do not specify the handle returned by the GetProcessWindowStation function.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. <b>Windows Server 2003 and Windows XP/2000: </b>This function does
///    not set the last error code on failure.
///    
@DllImport("USER32")
BOOL CloseWindowStation(ptrdiff_t hWinSta);

///Assigns the specified window station to the calling process. This enables the process to access objects in the window
///station such as desktops, the clipboard, and global atoms. All subsequent operations on the window station use the
///access rights granted to <i>hWinSta</i>.
///Params:
///    hWinSta = A handle to the window station. This can be a handle returned by the CreateWindowStation, OpenWindowStation, or
///              GetProcessWindowStation function. This window station must be associated with the current session.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetProcessWindowStation(ptrdiff_t hWinSta);

///Retrieves a handle to the current window station for the calling process.
///Returns:
///    If the function succeeds, the return value is a handle to the window station. If the function fails, the return
///    value is NULL. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t GetProcessWindowStation();

///Retrieves information about the specified window station or desktop object.
///Params:
///    hObj = A handle to the window station or desktop object. This handle is returned by the CreateWindowStation,
///           OpenWindowStation, CreateDesktop, or OpenDesktop function.
///    nIndex = The information to be retrieved. The parameter can be one of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UOI_FLAGS"></a><a id="uoi_flags"></a><dl>
///             <dt><b>UOI_FLAGS</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The handle flags. The <i>pvInfo</i> parameter
///             must point to a USEROBJECTFLAGS structure. </td> </tr> <tr> <td width="40%"><a id="UOI_HEAPSIZE"></a><a
///             id="uoi_heapsize"></a><dl> <dt><b>UOI_HEAPSIZE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The size of the
///             desktop heap, in KB, as a <b>ULONG</b> value. The <i>hObj</i> parameter must be a handle to a desktop object,
///             otherwise, the function fails. <b>Windows Server 2003 and Windows XP/2000: </b>This value is not supported. </td>
///             </tr> <tr> <td width="40%"><a id="UOI_IO"></a><a id="uoi_io"></a><dl> <dt><b>UOI_IO</b></dt> <dt>6</dt> </dl>
///             </td> <td width="60%"> <b>TRUE</b> if the <i>hObj</i> parameter is a handle to the desktop object that is
///             receiving input from the user. <b>FALSE</b> otherwise. <b>Windows Server 2003 and Windows XP/2000: </b>This value
///             is not supported. </td> </tr> <tr> <td width="40%"><a id="UOI_NAME"></a><a id="uoi_name"></a><dl>
///             <dt><b>UOI_NAME</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The name of the object, as a string. </td> </tr>
///             <tr> <td width="40%"><a id="UOI_TYPE"></a><a id="uoi_type"></a><dl> <dt><b>UOI_TYPE</b></dt> <dt>3</dt> </dl>
///             </td> <td width="60%"> The type name of the object, as a string. </td> </tr> <tr> <td width="40%"><a
///             id="UOI_USER_SID"></a><a id="uoi_user_sid"></a><dl> <dt><b>UOI_USER_SID</b></dt> <dt>4</dt> </dl> </td> <td
///             width="60%"> The SID structure that identifies the user that is currently associated with the specified object.
///             If no user is associated with the object, the value returned in the buffer pointed to by <i>lpnLengthNeeded</i>
///             is zero. Note that <b>SID</b> is a variable length structure. You will usually make a call to
///             <b>GetUserObjectInformation</b> to determine the length of the <b>SID</b> before retrieving its value. </td>
///             </tr> </table>
///    pvInfo = A pointer to a buffer to receive the object information.
///    nLength = The size of the buffer pointed to by the <i>pvInfo</i> parameter, in bytes.
///    lpnLengthNeeded = A pointer to a variable receiving the number of bytes required to store the requested information. If this
///                      variable's value is greater than the value of the <i>nLength</i> parameter when the function returns, the
///                      function returns FALSE, and none of the information is copied to the <i>pvInfo</i> buffer. If the value of the
///                      variable pointed to by <i>lpnLengthNeeded</i> is less than or equal to the value of <i>nLength</i>, the entire
///                      information block is copied.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetUserObjectInformationA(HANDLE hObj, int nIndex, char* pvInfo, uint nLength, uint* lpnLengthNeeded);

///Retrieves information about the specified window station or desktop object.
///Params:
///    hObj = A handle to the window station or desktop object. This handle is returned by the CreateWindowStation,
///           OpenWindowStation, CreateDesktop, or OpenDesktop function.
///    nIndex = The information to be retrieved. The parameter can be one of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UOI_FLAGS"></a><a id="uoi_flags"></a><dl>
///             <dt><b>UOI_FLAGS</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The handle flags. The <i>pvInfo</i> parameter
///             must point to a USEROBJECTFLAGS structure. </td> </tr> <tr> <td width="40%"><a id="UOI_HEAPSIZE"></a><a
///             id="uoi_heapsize"></a><dl> <dt><b>UOI_HEAPSIZE</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The size of the
///             desktop heap, in KB, as a <b>ULONG</b> value. The <i>hObj</i> parameter must be a handle to a desktop object,
///             otherwise, the function fails. <b>Windows Server 2003 and Windows XP/2000: </b>This value is not supported. </td>
///             </tr> <tr> <td width="40%"><a id="UOI_IO"></a><a id="uoi_io"></a><dl> <dt><b>UOI_IO</b></dt> <dt>6</dt> </dl>
///             </td> <td width="60%"> <b>TRUE</b> if the <i>hObj</i> parameter is a handle to the desktop object that is
///             receiving input from the user. <b>FALSE</b> otherwise. <b>Windows Server 2003 and Windows XP/2000: </b>This value
///             is not supported. </td> </tr> <tr> <td width="40%"><a id="UOI_NAME"></a><a id="uoi_name"></a><dl>
///             <dt><b>UOI_NAME</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The name of the object, as a string. </td> </tr>
///             <tr> <td width="40%"><a id="UOI_TYPE"></a><a id="uoi_type"></a><dl> <dt><b>UOI_TYPE</b></dt> <dt>3</dt> </dl>
///             </td> <td width="60%"> The type name of the object, as a string. </td> </tr> <tr> <td width="40%"><a
///             id="UOI_USER_SID"></a><a id="uoi_user_sid"></a><dl> <dt><b>UOI_USER_SID</b></dt> <dt>4</dt> </dl> </td> <td
///             width="60%"> The SID structure that identifies the user that is currently associated with the specified object.
///             If no user is associated with the object, the value returned in the buffer pointed to by <i>lpnLengthNeeded</i>
///             is zero. Note that <b>SID</b> is a variable length structure. You will usually make a call to
///             <b>GetUserObjectInformation</b> to determine the length of the <b>SID</b> before retrieving its value. </td>
///             </tr> </table>
///    pvInfo = A pointer to a buffer to receive the object information.
///    nLength = The size of the buffer pointed to by the <i>pvInfo</i> parameter, in bytes.
///    lpnLengthNeeded = A pointer to a variable receiving the number of bytes required to store the requested information. If this
///                      variable's value is greater than the value of the <i>nLength</i> parameter when the function returns, the
///                      function returns FALSE, and none of the information is copied to the <i>pvInfo</i> buffer. If the value of the
///                      variable pointed to by <i>lpnLengthNeeded</i> is less than or equal to the value of <i>nLength</i>, the entire
///                      information block is copied.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetUserObjectInformationW(HANDLE hObj, int nIndex, char* pvInfo, uint nLength, uint* lpnLengthNeeded);

///Sets information about the specified window station or desktop object.
///Params:
///    hObj = A handle to the window station, desktop object or a current process pseudo handle. This handle can be returned by
///           the CreateWindowStation, OpenWindowStation, CreateDesktop, OpenDesktop or GetCurrentProcess function.
///    nIndex = The object information to be set. This parameter can be the following value. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UOI_FLAGS"></a><a id="uoi_flags"></a><dl>
///             <dt><b>UOI_FLAGS</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Sets the object's handle flags. The
///             <i>pvInfo</i> parameter must point to a USEROBJECTFLAGS structure. </td> </tr> <tr> <td width="40%"><a
///             id="UOI_TIMERPROC_EXCEPTION_SUPPRESSION"></a><a id="uoi_timerproc_exception_suppression"></a><dl>
///             <dt><b>UOI_TIMERPROC_EXCEPTION_SUPPRESSION</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> Sets the exception
///             handling behavior when calling TimerProc. <i>hObj</i> must be the process handle returned by the
///             GetCurrentProcess function. The <i>pvInfo</i> parameter must point to a BOOL. If TRUE, Windows will enclose its
///             calls to TimerProc with an exception handler that consumes and discards all exceptions. This has been the default
///             behavior since Windows 2000, although that may change in future versions of Windows. If <i>pvInfo</i> points to
///             FALSE, Windows will not enclose its calls to TimerProc with an exception handler. A setting of FALSE is
///             recommended. Otherwise, the application could behave unpredictably, and could be more vulnerable to security
///             exploits. </td> </tr> </table>
///    pvInfo = A pointer to a buffer containing the object information, or a BOOL.
///    nLength = The size of the information contained in the buffer pointed to by <i>pvInfo</i>, in bytes.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetUserObjectInformationA(HANDLE hObj, int nIndex, char* pvInfo, uint nLength);

///Sets information about the specified window station or desktop object.
///Params:
///    hObj = A handle to the window station, desktop object or a current process pseudo handle. This handle can be returned by
///           the CreateWindowStation, OpenWindowStation, CreateDesktop, OpenDesktop or GetCurrentProcess function.
///    nIndex = The object information to be set. This parameter can be the following value. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UOI_FLAGS"></a><a id="uoi_flags"></a><dl>
///             <dt><b>UOI_FLAGS</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Sets the object's handle flags. The
///             <i>pvInfo</i> parameter must point to a USEROBJECTFLAGS structure. </td> </tr> <tr> <td width="40%"><a
///             id="UOI_TIMERPROC_EXCEPTION_SUPPRESSION"></a><a id="uoi_timerproc_exception_suppression"></a><dl>
///             <dt><b>UOI_TIMERPROC_EXCEPTION_SUPPRESSION</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> Sets the exception
///             handling behavior when calling TimerProc. <i>hObj</i> must be the process handle returned by the
///             GetCurrentProcess function. The <i>pvInfo</i> parameter must point to a BOOL. If TRUE, Windows will enclose its
///             calls to TimerProc with an exception handler that consumes and discards all exceptions. This has been the default
///             behavior since Windows 2000, although that may change in future versions of Windows. If <i>pvInfo</i> points to
///             FALSE, Windows will not enclose its calls to TimerProc with an exception handler. A setting of FALSE is
///             recommended. Otherwise, the application could behave unpredictably, and could be more vulnerable to security
///             exploits. </td> </tr> </table>
///    pvInfo = A pointer to a buffer containing the object information, or a BOOL.
///    nLength = The size of the information contained in the buffer pointed to by <i>pvInfo</i>, in bytes.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetUserObjectInformationW(HANDLE hObj, int nIndex, char* pvInfo, uint nLength);


