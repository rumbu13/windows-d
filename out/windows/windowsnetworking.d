// Written in the D programming language.

module windows.windowsnetworking;

public import windows.core;
public import windows.security : NETCONNECTINFOSTRUCT, NETRESOURCEA, NETRESOURCEW;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Structs


alias NetEnumHandle = ptrdiff_t;

///The <b>CONNECTDLGSTRUCT</b> structure is used by the WNetConnectionDialog1 function to establish browsing dialog box
///parameters.
struct CONNECTDLGSTRUCTA
{
    ///Type: <b>DWORD</b> The size, in bytes, of the <b>CONNECTDLGSTRUCT</b> structure. The caller must supply this
    ///value.
    uint          cbStructure;
    ///Type: <b>HWND</b> The handle to the owner window for the dialog box.
    HWND          hwndOwner;
    ///Type: <b>LPNETRESOURCE</b> A pointer to a NETRESOURCE structure. If the <b>lpRemoteName</b> member of
    ///<b>NETRESOURCE</b> is specified, it will be entered into the path field of the dialog box. With the exception of
    ///the <b>dwType</b> member, all other members of the <b>NETRESOURCE</b> structure must be set to <b>NULL</b>. The
    ///<b>dwType</b> member must be equal to RESOURCETYPE_DISK. The system does not support the
    ///<b>RESOURCETYPE_PRINT</b> flag for browsing and connecting to print resources.
    NETRESOURCEA* lpConnRes;
    ///Type: <b>DWORD</b> A set of bit flags that describe options for the dialog box display. This member can be a
    ///combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SidTypeUser"></a><a id="sidtypeuser"></a><a id="SIDTYPEUSER"></a><dl> <dt><b>SidTypeUser</b></dt> </dl> </td>
    ///<td width="60%"> The account is a user account. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_RO_PATH"></a><a
    ///id="conndlg_ro_path"></a><dl> <dt><b>CONNDLG_RO_PATH</b></dt> </dl> </td> <td width="60%"> Display a read-only
    ///path instead of allowing the user to type in a path. This flag should be set only if the <b>lpRemoteName</b>
    ///member of the NETRESOURCE structure pointed to by <b>lpConnRes</b> member is not <b>NULL</b> (or an empty
    ///string), and the <b>CONNDLG_USE_MRU</b> flag is not set. </td> </tr> <tr> <td width="40%"><a
    ///id="CONNDLG_CONN_POINT"></a><a id="conndlg_conn_point"></a><dl> <dt><b>CONNDLG_CONN_POINT</b></dt> </dl> </td>
    ///<td width="60%"> Internal flag. Do not use. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_USE_MRU"></a><a
    ///id="conndlg_use_mru"></a><dl> <dt><b>CONNDLG_USE_MRU</b></dt> </dl> </td> <td width="60%"> Enter the most
    ///recently used paths into the combination box. Set this value to simulate the WNetConnectionDialog function. </td>
    ///</tr> <tr> <td width="40%"><a id="CONNDLG_HIDE_BOX"></a><a id="conndlg_hide_box"></a><dl>
    ///<dt><b>CONNDLG_HIDE_BOX</b></dt> </dl> </td> <td width="60%"> Show the check box allowing the user to restore the
    ///connection at logon. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_PERSIST"></a><a
    ///id="conndlg_persist"></a><dl> <dt><b>CONNDLG_PERSIST</b></dt> </dl> </td> <td width="60%"> Restore the connection
    ///at logon. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_NOT_PERSIST"></a><a id="conndlg_not_persist"></a><dl>
    ///<dt><b>CONNDLG_NOT_PERSIST</b></dt> </dl> </td> <td width="60%"> Do not restore the connection at logon. </td>
    ///</tr> </table> For more information, see the following Remarks section.
    uint          dwFlags;
    ///Type: <b>DWORD</b> If the call to the WNetConnectionDialog1 function is successful, this member returns the
    ///number of the connected device. The value is 1 for A:, 2 for B:, 3 for C:, and so on. If the user made a
    ///deviceless connection, the value is –1.
    uint          dwDevNum;
}

///The <b>CONNECTDLGSTRUCT</b> structure is used by the WNetConnectionDialog1 function to establish browsing dialog box
///parameters.
struct CONNECTDLGSTRUCTW
{
    ///Type: <b>DWORD</b> The size, in bytes, of the <b>CONNECTDLGSTRUCT</b> structure. The caller must supply this
    ///value.
    uint          cbStructure;
    ///Type: <b>HWND</b> The handle to the owner window for the dialog box.
    HWND          hwndOwner;
    ///Type: <b>LPNETRESOURCE</b> A pointer to a NETRESOURCE structure. If the <b>lpRemoteName</b> member of
    ///<b>NETRESOURCE</b> is specified, it will be entered into the path field of the dialog box. With the exception of
    ///the <b>dwType</b> member, all other members of the <b>NETRESOURCE</b> structure must be set to <b>NULL</b>. The
    ///<b>dwType</b> member must be equal to RESOURCETYPE_DISK. The system does not support the
    ///<b>RESOURCETYPE_PRINT</b> flag for browsing and connecting to print resources.
    NETRESOURCEW* lpConnRes;
    ///Type: <b>DWORD</b> A set of bit flags that describe options for the dialog box display. This member can be a
    ///combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SidTypeUser"></a><a id="sidtypeuser"></a><a id="SIDTYPEUSER"></a><dl> <dt><b>SidTypeUser</b></dt> </dl> </td>
    ///<td width="60%"> The account is a user account. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_RO_PATH"></a><a
    ///id="conndlg_ro_path"></a><dl> <dt><b>CONNDLG_RO_PATH</b></dt> </dl> </td> <td width="60%"> Display a read-only
    ///path instead of allowing the user to type in a path. This flag should be set only if the <b>lpRemoteName</b>
    ///member of the NETRESOURCE structure pointed to by <b>lpConnRes</b> member is not <b>NULL</b> (or an empty
    ///string), and the <b>CONNDLG_USE_MRU</b> flag is not set. </td> </tr> <tr> <td width="40%"><a
    ///id="CONNDLG_CONN_POINT"></a><a id="conndlg_conn_point"></a><dl> <dt><b>CONNDLG_CONN_POINT</b></dt> </dl> </td>
    ///<td width="60%"> Internal flag. Do not use. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_USE_MRU"></a><a
    ///id="conndlg_use_mru"></a><dl> <dt><b>CONNDLG_USE_MRU</b></dt> </dl> </td> <td width="60%"> Enter the most
    ///recently used paths into the combination box. Set this value to simulate the WNetConnectionDialog function. </td>
    ///</tr> <tr> <td width="40%"><a id="CONNDLG_HIDE_BOX"></a><a id="conndlg_hide_box"></a><dl>
    ///<dt><b>CONNDLG_HIDE_BOX</b></dt> </dl> </td> <td width="60%"> Show the check box allowing the user to restore the
    ///connection at logon. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_PERSIST"></a><a
    ///id="conndlg_persist"></a><dl> <dt><b>CONNDLG_PERSIST</b></dt> </dl> </td> <td width="60%"> Restore the connection
    ///at logon. </td> </tr> <tr> <td width="40%"><a id="CONNDLG_NOT_PERSIST"></a><a id="conndlg_not_persist"></a><dl>
    ///<dt><b>CONNDLG_NOT_PERSIST</b></dt> </dl> </td> <td width="60%"> Do not restore the connection at logon. </td>
    ///</tr> </table> For more information, see the following Remarks section.
    uint          dwFlags;
    ///Type: <b>DWORD</b> If the call to the WNetConnectionDialog1 function is successful, this member returns the
    ///number of the connected device. The value is 1 for A:, 2 for B:, 3 for C:, and so on. If the user made a
    ///deviceless connection, the value is –1.
    uint          dwDevNum;
}

///The <b>DISCDLGSTRUCT</b> structure is used in the WNetDisconnectDialog1 function. The structure contains required
///information for the disconnect attempt.
struct DISCDLGSTRUCTA
{
    ///Type: <b>DWORD</b> The size, in bytes, of the <b>DISCDLGSTRUCT</b> structure. The caller must supply this value.
    uint         cbStructure;
    ///Type: <b>HWND</b> A handle to the owner window of the dialog box.
    HWND         hwndOwner;
    ///Type: <b>LPTSTR</b> A pointer to a <b>NULL</b>-terminated string that specifies the local device name that is
    ///redirected to the network resource, such as "F:" or "LPT1".
    const(char)* lpLocalName;
    ///Type: <b>LPTSTR</b> A pointer to a <b>NULL</b>-terminated string that specifies the name of the network resource
    ///to disconnect. This member can be NULL if the <b>lpLocalName</b> member is specified. When <b>lpLocalName</b> is
    ///specified, the connection to the network resource redirected from <b>lpLocalName</b> is disconnected.
    const(char)* lpRemoteName;
    ///Type: <b>DWORD</b> A set of bit flags describing the connection. This member can be a combination of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DISC_UPDATE_PROFILE"></a><a id="disc_update_profile"></a><dl> <dt><b>DISC_UPDATE_PROFILE</b></dt> </dl> </td>
    ///<td width="60%"> If this value is set, the specified connection is no longer a persistent one (automatically
    ///restored every time the user logs on). This flag is valid only if the <b>lpLocalName</b> member specifies a local
    ///device. </td> </tr> <tr> <td width="40%"><a id="DISC_NO_FORCE"></a><a id="disc_no_force"></a><dl>
    ///<dt><b>DISC_NO_FORCE</b></dt> </dl> </td> <td width="60%"> If this value is not set, the system applies force
    ///when attempting to disconnect from the network resource. This situation typically occurs when the user has files
    ///open over the connection. This value means that the user will be informed if there are open files on the
    ///connection, and asked if he or she still wants to disconnect. If the user wants to proceed, the disconnect
    ///procedure re-attempts with additional force. </td> </tr> </table>
    uint         dwFlags;
}

///The <b>DISCDLGSTRUCT</b> structure is used in the WNetDisconnectDialog1 function. The structure contains required
///information for the disconnect attempt.
struct DISCDLGSTRUCTW
{
    ///Type: <b>DWORD</b> The size, in bytes, of the <b>DISCDLGSTRUCT</b> structure. The caller must supply this value.
    uint          cbStructure;
    ///Type: <b>HWND</b> A handle to the owner window of the dialog box.
    HWND          hwndOwner;
    ///Type: <b>LPTSTR</b> A pointer to a <b>NULL</b>-terminated string that specifies the local device name that is
    ///redirected to the network resource, such as "F:" or "LPT1".
    const(wchar)* lpLocalName;
    ///Type: <b>LPTSTR</b> A pointer to a <b>NULL</b>-terminated string that specifies the name of the network resource
    ///to disconnect. This member can be NULL if the <b>lpLocalName</b> member is specified. When <b>lpLocalName</b> is
    ///specified, the connection to the network resource redirected from <b>lpLocalName</b> is disconnected.
    const(wchar)* lpRemoteName;
    ///Type: <b>DWORD</b> A set of bit flags describing the connection. This member can be a combination of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DISC_UPDATE_PROFILE"></a><a id="disc_update_profile"></a><dl> <dt><b>DISC_UPDATE_PROFILE</b></dt> </dl> </td>
    ///<td width="60%"> If this value is set, the specified connection is no longer a persistent one (automatically
    ///restored every time the user logs on). This flag is valid only if the <b>lpLocalName</b> member specifies a local
    ///device. </td> </tr> <tr> <td width="40%"><a id="DISC_NO_FORCE"></a><a id="disc_no_force"></a><dl>
    ///<dt><b>DISC_NO_FORCE</b></dt> </dl> </td> <td width="60%"> If this value is not set, the system applies force
    ///when attempting to disconnect from the network resource. This situation typically occurs when the user has files
    ///open over the connection. This value means that the user will be informed if there are open files on the
    ///connection, and asked if he or she still wants to disconnect. If the user wants to proceed, the disconnect
    ///procedure re-attempts with additional force. </td> </tr> </table>
    uint          dwFlags;
}

///The <b>NETINFOSTRUCT</b> structure contains information describing the network provider returned by the
///WNetGetNetworkInformation function.
struct NETINFOSTRUCT
{
    ///Type: <b>DWORD</b> The size, in bytes, of the <b>NETINFOSTRUCT</b> structure. The caller must supply this value
    ///to indicate the size of the structure passed in. Upon return, it has the size of the structure filled in.
    uint   cbStructure;
    ///Type: <b>DWORD</b> The version number of the network provider software.
    uint   dwProviderVersion;
    ///Type: <b>DWORD</b> The current status of the network provider software. This member can be one of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NO_ERROR"></a><a
    ///id="no_error"></a><dl> <dt><b>NO_ERROR</b></dt> </dl> </td> <td width="60%"> The network is running. </td> </tr>
    ///<tr> <td width="40%"><a id="ERROR_NO_NETWORK"></a><a id="error_no_network"></a><dl>
    ///<dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr> <tr> <td
    ///width="40%"><a id="ERROR_BUSY"></a><a id="error_busy"></a><dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td
    ///width="60%"> The network is not currently able to service requests, but it should become available shortly. (This
    ///value typically indicates that the network is starting up.) </td> </tr> </table>
    uint   dwStatus;
    ///Type: <b>DWORD</b> Characteristics of the network provider software. This value is zero. <b>Windows Me/98/95:
    ///</b>This member can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="NETINFO_DLL16"></a><a id="netinfo_dll16"></a><dl> <dt><b>NETINFO_DLL16</b></dt> </dl>
    ///</td> <td width="60%"> The network provider is running as a 16-bit Windows network driver. </td> </tr> <tr> <td
    ///width="40%"><a id="NETINFO_DISKRED"></a><a id="netinfo_diskred"></a><dl> <dt><b>NETINFO_DISKRED</b></dt> </dl>
    ///</td> <td width="60%"> The network provider requires a redirected local disk drive device to access server file
    ///systems. </td> </tr> <tr> <td width="40%"><a id="NETINFO_PRINTERRED"></a><a id="netinfo_printerred"></a><dl>
    ///<dt><b>NETINFO_PRINTERRED</b></dt> </dl> </td> <td width="60%"> The network provider requires a redirected local
    ///printer port to access server file systems. </td> </tr> </table>
    uint   dwCharacteristics;
    ///Type: <b>ULONG_PTR</b> An instance handle for the network provider or for the 16-bit Windows network driver.
    size_t dwHandle;
    ///Type: <b>WORD</b> The network type unique to the running network. This value associates resources with a specific
    ///network when the resources are persistent or stored in links. You can find a complete list of network types in
    ///the header file Winnetwk.h.
    ushort wNetType;
    ///Type: <b>DWORD</b> A set of bit flags indicating the valid print numbers for redirecting local printer devices,
    ///with the low-order bit corresponding to LPT1. <b>Windows Me/98/95: </b>This value is always set to –1.
    uint   dwPrinters;
    ///Type: <b>DWORD</b> A set of bit flags indicating the valid local disk devices for redirecting disk drives, with
    ///the low-order bit corresponding to A:. <b>Windows Me/98/95: </b>This value is always set to –1.
    uint   dwDrives;
}

// Functions

///The <b>WNetAddConnection</b> function enables the calling application to connect a local device to a network
///resource. A successful connection is persistent, meaning that the system automatically restores the connection during
///subsequent logon operations. <div class="alert"><b>Note</b> This function is provided only for compatibility with
///16-bit versions of Windows. Other Windows-based applications should call the WNetAddConnection2 or the
///WNetAddConnection3 function.</div><div> </div>
///Params:
///    lpRemoteName = A pointer to a constant <b>null</b>-terminated string that specifies the network resource to connect to.
///    lpPassword = A pointer to a constant <b>null</b>-terminated string that specifies the password to be used to make a
///                 connection. This parameter is usually the password associated with the current user. If this parameter is
///                 <b>NULL</b>, the default password is used. If the string is empty, no password is used. <b>Windows Me/98/95:
///                 </b>This parameter must be <b>NULL</b> or an empty string.
///    lpLocalName = A pointer to a constant <b>null</b>-terminated string that specifies the name of a local device to be redirected,
///                  such as "F:" or "LPT1". The string is treated in a case-insensitive manner. If the string is <b>NULL</b>, a
///                  connection to the network resource is made without redirecting the local device.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_ASSIGNED</b></dt>
///    </dl> </td> <td width="60%"> The device specified in the <i>lpLocalName</i> parameter is already connected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td width="60%"> The device type
///    and the resource type do not match. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl>
///    </td> <td width="60%"> The value specified in the <i>lpLocalName</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The value specified in the
///    <i>lpRemoteName</i> parameter is not valid or cannot be located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user profile is in an incorrect format. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td> <td width="60%"> The
///    system is unable to open the user profile to process persistent connections. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DEVICE_ALREADY_REMEMBERED</b></dt> </dl> </td> <td width="60%"> An entry for the device
///    specified in the <i>lpLocalName</i> parameter is already in the user profile. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To
///    obtain a description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%"> The specified password is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The
///    operation cannot be performed because a network component is not started or because a specified name cannot be
///    used. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The
///    network is unavailable. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetAddConnectionA(const(char)* lpRemoteName, const(char)* lpPassword, const(char)* lpLocalName);

///The <b>WNetAddConnection</b> function enables the calling application to connect a local device to a network
///resource. A successful connection is persistent, meaning that the system automatically restores the connection during
///subsequent logon operations. <div class="alert"><b>Note</b> This function is provided only for compatibility with
///16-bit versions of Windows. Other Windows-based applications should call the WNetAddConnection2 or the
///WNetAddConnection3 function.</div><div> </div>
///Params:
///    lpRemoteName = A pointer to a constant <b>null</b>-terminated string that specifies the network resource to connect to.
///    lpPassword = A pointer to a constant <b>null</b>-terminated string that specifies the password to be used to make a
///                 connection. This parameter is usually the password associated with the current user. If this parameter is
///                 <b>NULL</b>, the default password is used. If the string is empty, no password is used. <b>Windows Me/98/95:
///                 </b>This parameter must be <b>NULL</b> or an empty string.
///    lpLocalName = A pointer to a constant <b>null</b>-terminated string that specifies the name of a local device to be redirected,
///                  such as "F:" or "LPT1". The string is treated in a case-insensitive manner. If the string is <b>NULL</b>, a
///                  connection to the network resource is made without redirecting the local device.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_ASSIGNED</b></dt>
///    </dl> </td> <td width="60%"> The device specified in the <i>lpLocalName</i> parameter is already connected. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td width="60%"> The device type
///    and the resource type do not match. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl>
///    </td> <td width="60%"> The value specified in the <i>lpLocalName</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The value specified in the
///    <i>lpRemoteName</i> parameter is not valid or cannot be located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user profile is in an incorrect format. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td> <td width="60%"> The
///    system is unable to open the user profile to process persistent connections. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DEVICE_ALREADY_REMEMBERED</b></dt> </dl> </td> <td width="60%"> An entry for the device
///    specified in the <i>lpLocalName</i> parameter is already in the user profile. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To
///    obtain a description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%"> The specified password is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The
///    operation cannot be performed because a network component is not started or because a specified name cannot be
///    used. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The
///    network is unavailable. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetAddConnectionW(const(wchar)* lpRemoteName, const(wchar)* lpPassword, const(wchar)* lpLocalName);

///The <b>WNetAddConnection2</b> function makes a connection to a network resource and can redirect a local device to
///the network resource. The <b>WNetAddConnection2</b> function supersedes the WNetAddConnection function. If you can
///pass a handle to a window that the provider of network resources can use as an owner window for dialog boxes, call
///the WNetAddConnection3 function instead.
///Params:
///    lpNetResource = A pointer to a NETRESOURCE structure that specifies details of the proposed connection, such as information about
///                    the network resource, the local device, and the network resource provider. You must specify the following members
///                    of the <b>NETRESOURCE</b> structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl> <dt><b><b>dwType</b></b></dt> </dl> </td> <td
///                    width="60%"> The type of network resource to connect to. If the <b>lpLocalName</b> member points to a nonempty
///                    string, this member can be equal to RESOURCETYPE_DISK or RESOURCETYPE_PRINT. If <b>lpLocalName</b> is
///                    <b>NULL</b>, or if it points to an empty string, <b>dwType</b> can be equal to RESOURCETYPE_DISK,
///                    RESOURCETYPE_PRINT, or RESOURCETYPE_ANY. Although this member is required, its information may be ignored by the
///                    network service provider. </td> </tr> <tr> <td width="40%"><a id="lpLocalName"></a><a id="lplocalname"></a><a
///                    id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a
///                    <b>null</b>-terminated string that specifies the name of a local device to redirect, such as "F:" or "LPT1". The
///                    string is treated in a case-insensitive manner. If the string is empty, or if <b>lpLocalName</b> is <b>NULL</b>,
///                    the function makes a connection to the network resource without redirecting a local device. </td> </tr> <tr> <td
///                    width="40%"><a id="lpRemoteName"></a><a id="lpremotename"></a><a id="LPREMOTENAME"></a><dl>
///                    <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a <b>null</b>-terminated string
///                    that specifies the network resource to connect to. The string can be up to MAX_PATH characters in length, and
///                    must follow the network provider's naming conventions. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a
///                    id="lpprovider"></a><a id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> A
///                    pointer to a <b>null</b>-terminated string that specifies the network provider to connect to. If
///                    <b>lpProvider</b> is <b>NULL</b>, or if it points to an empty string, the operating system attempts to determine
///                    the correct provider by parsing the string pointed to by the <b>lpRemoteName</b> member. If this member is not
///                    <b>NULL</b>, the operating system attempts to make a connection only to the named network provider. You should
///                    set this member only if you know the network provider you want to use. Otherwise, let the operating system
///                    determine which provider the network name maps to. </td> </tr> </table> The <b>WNetAddConnection2</b> function
///                    ignores the other members of the NETRESOURCE structure.
///    lpPassword = A pointer to a constant <b>null</b>-terminated string that specifies a password to be used in making the network
///                 connection. If <i>lpPassword</i> is <b>NULL</b>, the function uses the current default password associated with
///                 the user specified by the <i>lpUserName</i> parameter. If <i>lpPassword</i> points to an empty string, the
///                 function does not use a password. If the connection fails because of an invalid password and the
///                 CONNECT_INTERACTIVE value is set in the <i>dwFlags</i> parameter, the function displays a dialog box asking the
///                 user to type the password. <b>Windows Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    lpUserName = A pointer to a constant <b>null</b>-terminated string that specifies a user name for making the connection. If
///                 <i>lpUserName</i> is <b>NULL</b>, the function uses the default user name. (The user context for the process
///                 provides the default user name.) The <i>lpUserName</i> parameter is specified when users want to connect to a
///                 network resource for which they have been assigned a user name or account other than the default user name or
///                 account. The user-name string represents a security context. It may be specific to a network provider. <b>Windows
///                 Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    dwFlags = A set of connection options. The possible values for the connection options are defined in the <i>Winnetwk.h</i>
///              header file. The following values can currently be used. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="CONNECT_UPDATE_PROFILE"></a><a id="connect_update_profile"></a><dl>
///              <dt><b>CONNECT_UPDATE_PROFILE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The network resource
///              connection should be remembered. If this bit flag is set, the operating system automatically attempts to restore
///              the connection when the user logs on. The operating system remembers only successful connections that redirect
///              local devices. It does not remember connections that are unsuccessful or deviceless connections. (A deviceless
///              connection occurs when the <b>lpLocalName</b> member is <b>NULL</b> or points to an empty string.) If this bit
///              flag is clear, the operating system does not try to restore the connection when the user logs on. </td> </tr>
///              <tr> <td width="40%"><a id="CONNECT_UPDATE_RECENT"></a><a id="connect_update_recent"></a><dl>
///              <dt><b>CONNECT_UPDATE_RECENT</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The network resource
///              connection should not be put in the recent connection list. If this flag is set and the connection is
///              successfully added, the network resource connection will be put in the recent connection list only if it has a
///              redirected local device associated with it. </td> </tr> <tr> <td width="40%"><a id="CONNECT_TEMPORARY"></a><a
///              id="connect_temporary"></a><dl> <dt><b>CONNECT_TEMPORARY</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///              width="60%"> The network resource connection should not be remembered. If this flag is set, the operating system
///              will not attempt to restore the connection when the user logs on again. </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_INTERACTIVE"></a><a id="connect_interactive"></a><dl> <dt><b>CONNECT_INTERACTIVE</b></dt>
///              <dt>0x00000008</dt> </dl> </td> <td width="60%"> If this flag is set, the operating system may interact with the
///              user for authentication purposes. </td> </tr> <tr> <td width="40%"><a id="CONNECT_PROMPT"></a><a
///              id="connect_prompt"></a><dl> <dt><b>CONNECT_PROMPT</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> This
///              flag instructs the system not to use any default settings for user names or passwords without offering the user
///              the opportunity to supply an alternative. This flag is ignored unless CONNECT_INTERACTIVE is also set. </td>
///              </tr> <tr> <td width="40%"><a id="CONNECT_REDIRECT"></a><a id="connect_redirect"></a><dl>
///              <dt><b>CONNECT_REDIRECT</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> This flag forces the
///              redirection of a local device when making the connection. If the <b>lpLocalName</b> member of NETRESOURCE
///              specifies a local device to redirect, this flag has no effect, because the operating system still attempts to
///              redirect the specified device. When the operating system automatically chooses a local device, the <b>dwType</b>
///              member must not be equal to RESOURCETYPE_ANY. If this flag is not set, a local device is automatically chosen for
///              redirection only if the network requires a local device to be redirected. <b>Windows Server 2003 and Windows XP:
///              </b>When the system automatically assigns network drive letters, letters are assigned beginning with Z:, then Y:,
///              and ending with C:. This reduces collision between per-logon drive letters (such as network drive letters) and
///              global drive letters (such as disk drives). Note that earlier versions of Windows assigned drive letters
///              beginning with C: and ending with Z:. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CURRENT_MEDIA"></a><a
///              id="connect_current_media"></a><dl> <dt><b>CONNECT_CURRENT_MEDIA</b></dt> <dt>0x00000200</dt> </dl> </td> <td
///              width="60%"> If this flag is set, then the operating system does not start to use a new media to try to establish
///              the connection (initiate a new dial up connection, for example). </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_COMMANDLINE"></a><a id="connect_commandline"></a><dl> <dt><b>CONNECT_COMMANDLINE</b></dt>
///              <dt>0x00000800</dt> </dl> </td> <td width="60%"> If this flag is set, the operating system prompts the user for
///              authentication using the command line instead of a graphical user interface (GUI). This flag is ignored unless
///              CONNECT_INTERACTIVE is also set. <b>Windows XP: </b>This value is supported on Windows XP and later. </td> </tr>
///              <tr> <td width="40%"><a id="CONNECT_CMD_SAVECRED"></a><a id="connect_cmd_savecred"></a><dl>
///              <dt><b>CONNECT_CMD_SAVECRED</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> If this flag is set, and
///              the operating system prompts for a credential, the credential should be saved by the credential manager. If the
///              credential manager is disabled for the caller's logon session, or if the network provider does not support saving
///              credentials, this flag is ignored. This flag is ignored unless CONNECT_INTERACTIVE is also set. This flag is also
///              ignored unless you set the CONNECT_COMMANDLINE flag. <b>Windows XP: </b>This value is supported on Windows XP and
///              later. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CRED_RESET"></a><a id="connect_cred_reset"></a><dl>
///              <dt><b>CONNECT_CRED_RESET</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> If this flag is set, and the
///              operating system prompts for a credential, the credential is reset by the credential manager. If the credential
///              manager is disabled for the caller's logon session, or if the network provider does not support saving
///              credentials, this flag is ignored. This flag is also ignored unless you set the CONNECT_COMMANDLINE flag.
///              <b>Windows Vista: </b>This value is supported on Windows Vista and later. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value can be one of the
///    following error codes or one of the system error codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does
///    not have access to the network resource. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ALREADY_ASSIGNED</b></dt> </dl> </td> <td width="60%"> The local device specified by the
///    <b>lpLocalName</b> member is already connected to a network resource. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td width="60%"> The type of local device and the type of network
///    resource do not match. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td
///    width="60%"> The specified device name is not valid. This error is returned if the <b>lpLocalName</b> member of
///    the NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter specifies a device that is not
///    redirectable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td
///    width="60%"> The network name cannot be found. This value is returned if the <b>lpRemoteName</b> member of the
///    NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter specifies a resource that is not
///    acceptable to any network resource provider, either because the resource name is empty, not valid, or because the
///    named resource cannot be located. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl>
///    </td> <td width="60%"> The user profile is in an incorrect format. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl> </td> <td width="60%"> The specified network provider name is not valid.
///    This error is returned if the <b>lpProvider</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter specifies a value that does not match any network provider. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_USERNAME</b></dt> </dl> </td> <td width="60%"> The specified user name is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td width="60%"> The router
///    or provider is busy, possibly initializing. The caller should retry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The attempt to make the connection was canceled by
///    the user through a dialog box from one of the network resource providers, or by a called resource. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td> <td width="60%"> The system is
///    unable to open the user profile to process persistent connections. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEVICE_ALREADY_REMEMBERED</b></dt> </dl> </td> <td width="60%"> The local device name has a
///    remembered connection to another network resource. This error is returned if an entry for the device specified by
///    <b>lpLocalName</b> member of the NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter specifies
///    a value that is already in the user profile for a different connection than that specified in the
///    <i>lpNetResource</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl>
///    </td> <td width="60%"> A network-specific error occurred. Call the WNetGetLastError function to obtain a
///    description of the error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl>
///    </td> <td width="60%"> An attempt was made to access an invalid address. This error is returned if the
///    <i>dwFlags</i> parameter specifies a value of CONNECT_REDIRECT, but the <b>lpLocalName</b> member of the
///    NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter was unspecified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect.
///    This error is returned if the <b>dwType</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter specifies a value other than RESOURCETYPE_DISK, RESOURCETYPE_PRINT, or
///    RESOURCETYPE_ANY. This error is also returned if the <i>dwFlags</i> parameter specifies an incorrect or unknown
///    value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%">
///    The specified password is invalid and the CONNECT_INTERACTIVE flag is not set. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_LOGON_FAILURE</b></dt> </dl> </td> <td width="60%"> A logon failure because of an unknown user
///    name or a bad password. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl>
///    </td> <td width="60%"> No network provider accepted the given network path. This error is returned if no network
///    provider recognized the <b>lpRemoteName</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl>
///    </td> <td width="60%"> The network is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("MPR")
uint WNetAddConnection2A(NETRESOURCEA* lpNetResource, const(char)* lpPassword, const(char)* lpUserName, 
                         uint dwFlags);

///The <b>WNetAddConnection2</b> function makes a connection to a network resource and can redirect a local device to
///the network resource. The <b>WNetAddConnection2</b> function supersedes the WNetAddConnection function. If you can
///pass a handle to a window that the provider of network resources can use as an owner window for dialog boxes, call
///the WNetAddConnection3 function instead.
///Params:
///    lpNetResource = A pointer to a NETRESOURCE structure that specifies details of the proposed connection, such as information about
///                    the network resource, the local device, and the network resource provider. You must specify the following members
///                    of the <b>NETRESOURCE</b> structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl> <dt><b><b>dwType</b></b></dt> </dl> </td> <td
///                    width="60%"> The type of network resource to connect to. If the <b>lpLocalName</b> member points to a nonempty
///                    string, this member can be equal to RESOURCETYPE_DISK or RESOURCETYPE_PRINT. If <b>lpLocalName</b> is
///                    <b>NULL</b>, or if it points to an empty string, <b>dwType</b> can be equal to RESOURCETYPE_DISK,
///                    RESOURCETYPE_PRINT, or RESOURCETYPE_ANY. Although this member is required, its information may be ignored by the
///                    network service provider. </td> </tr> <tr> <td width="40%"><a id="lpLocalName"></a><a id="lplocalname"></a><a
///                    id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a
///                    <b>null</b>-terminated string that specifies the name of a local device to redirect, such as "F:" or "LPT1". The
///                    string is treated in a case-insensitive manner. If the string is empty, or if <b>lpLocalName</b> is <b>NULL</b>,
///                    the function makes a connection to the network resource without redirecting a local device. </td> </tr> <tr> <td
///                    width="40%"><a id="lpRemoteName"></a><a id="lpremotename"></a><a id="LPREMOTENAME"></a><dl>
///                    <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a <b>null</b>-terminated string
///                    that specifies the network resource to connect to. The string can be up to MAX_PATH characters in length, and
///                    must follow the network provider's naming conventions. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a
///                    id="lpprovider"></a><a id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> A
///                    pointer to a <b>null</b>-terminated string that specifies the network provider to connect to. If
///                    <b>lpProvider</b> is <b>NULL</b>, or if it points to an empty string, the operating system attempts to determine
///                    the correct provider by parsing the string pointed to by the <b>lpRemoteName</b> member. If this member is not
///                    <b>NULL</b>, the operating system attempts to make a connection only to the named network provider. You should
///                    set this member only if you know the network provider you want to use. Otherwise, let the operating system
///                    determine which provider the network name maps to. </td> </tr> </table> The <b>WNetAddConnection2</b> function
///                    ignores the other members of the NETRESOURCE structure.
///    lpPassword = A pointer to a constant <b>null</b>-terminated string that specifies a password to be used in making the network
///                 connection. If <i>lpPassword</i> is <b>NULL</b>, the function uses the current default password associated with
///                 the user specified by the <i>lpUserName</i> parameter. If <i>lpPassword</i> points to an empty string, the
///                 function does not use a password. If the connection fails because of an invalid password and the
///                 CONNECT_INTERACTIVE value is set in the <i>dwFlags</i> parameter, the function displays a dialog box asking the
///                 user to type the password. <b>Windows Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    lpUserName = A pointer to a constant <b>null</b>-terminated string that specifies a user name for making the connection. If
///                 <i>lpUserName</i> is <b>NULL</b>, the function uses the default user name. (The user context for the process
///                 provides the default user name.) The <i>lpUserName</i> parameter is specified when users want to connect to a
///                 network resource for which they have been assigned a user name or account other than the default user name or
///                 account. The user-name string represents a security context. It may be specific to a network provider. <b>Windows
///                 Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    dwFlags = A set of connection options. The possible values for the connection options are defined in the <i>Winnetwk.h</i>
///              header file. The following values can currently be used. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="CONNECT_UPDATE_PROFILE"></a><a id="connect_update_profile"></a><dl>
///              <dt><b>CONNECT_UPDATE_PROFILE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The network resource
///              connection should be remembered. If this bit flag is set, the operating system automatically attempts to restore
///              the connection when the user logs on. The operating system remembers only successful connections that redirect
///              local devices. It does not remember connections that are unsuccessful or deviceless connections. (A deviceless
///              connection occurs when the <b>lpLocalName</b> member is <b>NULL</b> or points to an empty string.) If this bit
///              flag is clear, the operating system does not try to restore the connection when the user logs on. </td> </tr>
///              <tr> <td width="40%"><a id="CONNECT_UPDATE_RECENT"></a><a id="connect_update_recent"></a><dl>
///              <dt><b>CONNECT_UPDATE_RECENT</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The network resource
///              connection should not be put in the recent connection list. If this flag is set and the connection is
///              successfully added, the network resource connection will be put in the recent connection list only if it has a
///              redirected local device associated with it. </td> </tr> <tr> <td width="40%"><a id="CONNECT_TEMPORARY"></a><a
///              id="connect_temporary"></a><dl> <dt><b>CONNECT_TEMPORARY</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///              width="60%"> The network resource connection should not be remembered. If this flag is set, the operating system
///              will not attempt to restore the connection when the user logs on again. </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_INTERACTIVE"></a><a id="connect_interactive"></a><dl> <dt><b>CONNECT_INTERACTIVE</b></dt>
///              <dt>0x00000008</dt> </dl> </td> <td width="60%"> If this flag is set, the operating system may interact with the
///              user for authentication purposes. </td> </tr> <tr> <td width="40%"><a id="CONNECT_PROMPT"></a><a
///              id="connect_prompt"></a><dl> <dt><b>CONNECT_PROMPT</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> This
///              flag instructs the system not to use any default settings for user names or passwords without offering the user
///              the opportunity to supply an alternative. This flag is ignored unless CONNECT_INTERACTIVE is also set. </td>
///              </tr> <tr> <td width="40%"><a id="CONNECT_REDIRECT"></a><a id="connect_redirect"></a><dl>
///              <dt><b>CONNECT_REDIRECT</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> This flag forces the
///              redirection of a local device when making the connection. If the <b>lpLocalName</b> member of NETRESOURCE
///              specifies a local device to redirect, this flag has no effect, because the operating system still attempts to
///              redirect the specified device. When the operating system automatically chooses a local device, the <b>dwType</b>
///              member must not be equal to RESOURCETYPE_ANY. If this flag is not set, a local device is automatically chosen for
///              redirection only if the network requires a local device to be redirected. <b>Windows Server 2003 and Windows XP:
///              </b>When the system automatically assigns network drive letters, letters are assigned beginning with Z:, then Y:,
///              and ending with C:. This reduces collision between per-logon drive letters (such as network drive letters) and
///              global drive letters (such as disk drives). Note that earlier versions of Windows assigned drive letters
///              beginning with C: and ending with Z:. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CURRENT_MEDIA"></a><a
///              id="connect_current_media"></a><dl> <dt><b>CONNECT_CURRENT_MEDIA</b></dt> <dt>0x00000200</dt> </dl> </td> <td
///              width="60%"> If this flag is set, then the operating system does not start to use a new media to try to establish
///              the connection (initiate a new dial up connection, for example). </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_COMMANDLINE"></a><a id="connect_commandline"></a><dl> <dt><b>CONNECT_COMMANDLINE</b></dt>
///              <dt>0x00000800</dt> </dl> </td> <td width="60%"> If this flag is set, the operating system prompts the user for
///              authentication using the command line instead of a graphical user interface (GUI). This flag is ignored unless
///              CONNECT_INTERACTIVE is also set. <b>Windows XP: </b>This value is supported on Windows XP and later. </td> </tr>
///              <tr> <td width="40%"><a id="CONNECT_CMD_SAVECRED"></a><a id="connect_cmd_savecred"></a><dl>
///              <dt><b>CONNECT_CMD_SAVECRED</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> If this flag is set, and
///              the operating system prompts for a credential, the credential should be saved by the credential manager. If the
///              credential manager is disabled for the caller's logon session, or if the network provider does not support saving
///              credentials, this flag is ignored. This flag is ignored unless CONNECT_INTERACTIVE is also set. This flag is also
///              ignored unless you set the CONNECT_COMMANDLINE flag. <b>Windows XP: </b>This value is supported on Windows XP and
///              later. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CRED_RESET"></a><a id="connect_cred_reset"></a><dl>
///              <dt><b>CONNECT_CRED_RESET</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> If this flag is set, and the
///              operating system prompts for a credential, the credential is reset by the credential manager. If the credential
///              manager is disabled for the caller's logon session, or if the network provider does not support saving
///              credentials, this flag is ignored. This flag is also ignored unless you set the CONNECT_COMMANDLINE flag.
///              <b>Windows Vista: </b>This value is supported on Windows Vista and later. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value can be one of the
///    following error codes or one of the system error codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does
///    not have access to the network resource. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ALREADY_ASSIGNED</b></dt> </dl> </td> <td width="60%"> The local device specified by the
///    <b>lpLocalName</b> member is already connected to a network resource. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td width="60%"> The type of local device and the type of network
///    resource do not match. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td
///    width="60%"> The specified device name is not valid. This error is returned if the <b>lpLocalName</b> member of
///    the NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter specifies a device that is not
///    redirectable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td
///    width="60%"> The network name cannot be found. This value is returned if the <b>lpRemoteName</b> member of the
///    NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter specifies a resource that is not
///    acceptable to any network resource provider, either because the resource name is empty, not valid, or because the
///    named resource cannot be located. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl>
///    </td> <td width="60%"> The user profile is in an incorrect format. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl> </td> <td width="60%"> The specified network provider name is not valid.
///    This error is returned if the <b>lpProvider</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter specifies a value that does not match any network provider. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_USERNAME</b></dt> </dl> </td> <td width="60%"> The specified user name is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td width="60%"> The router
///    or provider is busy, possibly initializing. The caller should retry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The attempt to make the connection was canceled by
///    the user through a dialog box from one of the network resource providers, or by a called resource. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td> <td width="60%"> The system is
///    unable to open the user profile to process persistent connections. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEVICE_ALREADY_REMEMBERED</b></dt> </dl> </td> <td width="60%"> The local device name has a
///    remembered connection to another network resource. This error is returned if an entry for the device specified by
///    <b>lpLocalName</b> member of the NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter specifies
///    a value that is already in the user profile for a different connection than that specified in the
///    <i>lpNetResource</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl>
///    </td> <td width="60%"> A network-specific error occurred. Call the WNetGetLastError function to obtain a
///    description of the error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl>
///    </td> <td width="60%"> An attempt was made to access an invalid address. This error is returned if the
///    <i>dwFlags</i> parameter specifies a value of CONNECT_REDIRECT, but the <b>lpLocalName</b> member of the
///    NETRESOURCE structure pointed to by the <i>lpNetResource</i> parameter was unspecified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect.
///    This error is returned if the <b>dwType</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter specifies a value other than RESOURCETYPE_DISK, RESOURCETYPE_PRINT, or
///    RESOURCETYPE_ANY. This error is also returned if the <i>dwFlags</i> parameter specifies an incorrect or unknown
///    value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%">
///    The specified password is invalid and the CONNECT_INTERACTIVE flag is not set. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_LOGON_FAILURE</b></dt> </dl> </td> <td width="60%"> A logon failure because of an unknown user
///    name or a bad password. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl>
///    </td> <td width="60%"> No network provider accepted the given network path. This error is returned if no network
///    provider recognized the <b>lpRemoteName</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl>
///    </td> <td width="60%"> The network is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("MPR")
uint WNetAddConnection2W(NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName, 
                         uint dwFlags);

///The <b>WNetAddConnection3</b> function makes a connection to a network resource. The function can redirect a local
///device to the network resource. The <b>WNetAddConnection3</b> function is similar to the WNetAddConnection2 function.
///The main difference is that <b>WNetAddConnection3</b> has an additional parameter, a handle to a window that the
///provider of network resources can use as an owner window for dialog boxes. The <b>WNetAddConnection2</b> function and
///the <b>WNetAddConnection3</b> function supersede the WNetAddConnection function.
///Params:
///    hwndOwner = A handle to a window that the provider of network resources can use as an owner window for dialog boxes. Use this
///                parameter if you set the CONNECT_INTERACTIVE value in the <i>dwFlags</i> parameter. The <i>hwndOwner</i>
///                parameter can be <b>NULL</b>. If it is, a call to <b>WNetAddConnection3</b> is equivalent to calling the
///                WNetAddConnection2 function.
///    lpNetResource = A pointer to a NETRESOURCE structure that specifies details of the proposed connection, such as information about
///                    the network resource, the local device, and the network resource provider. You must specify the following members
///                    of the NETRESOURCE structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl> <dt><b><b>dwType</b></b></dt> </dl> </td> <td
///                    width="60%"> The type of network resource to connect to. If the <b>lpLocalName</b> member points to a nonempty
///                    string, this member can be equal to RESOURCETYPE_DISK or RESOURCETYPE_PRINT. If <b>lpLocalName</b> is
///                    <b>NULL</b>, or if it points to an empty string, <b>dwType</b> can be equal to RESOURCETYPE_DISK,
///                    RESOURCETYPE_PRINT, or RESOURCETYPE_ANY. Although this member is required, its information may be ignored by the
///                    network service provider. </td> </tr> <tr> <td width="40%"><a id="lpLocalName"></a><a id="lplocalname"></a><a
///                    id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a
///                    <b>null</b>-terminated string that specifies the name of a local device to redirect, such as "F:" or "LPT1". The
///                    string is treated in a case-insensitive manner. If the string is empty or if <b>lpLocalName</b> is <b>NULL</b>,
///                    the function makes a connection to the network resource without redirecting a local device. </td> </tr> <tr> <td
///                    width="40%"><a id="lpRemoteName"></a><a id="lpremotename"></a><a id="LPREMOTENAME"></a><dl>
///                    <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a <b>null</b>-terminated string
///                    that specifies the network resource to connect to. The string can be up to MAX_PATH characters in length, and
///                    must follow the network provider's naming conventions. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a
///                    id="lpprovider"></a><a id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> A
///                    pointer to a <b>null</b>-terminated string that specifies the network provider to connect to. If
///                    <b>lpProvider</b> is <b>NULL</b>, or if it points to an empty string, the operating system attempts to determine
///                    the correct provider by parsing the string pointed to by the <b>lpRemoteName</b> member. If this member is not
///                    <b>NULL</b>, the operating system attempts to make a connection only to the named network provider. You should
///                    set this member only if you know which network provider you want to use. Otherwise, let the operating system
///                    determine which network provider the network name maps to. </td> </tr> </table> The <b>WNetAddConnection3</b>
///                    function ignores the other members of the NETRESOURCE structure.
///    lpPassword = A pointer to a <b>null</b>-terminated string that specifies a password to be used in making the network
///                 connection. If <i>lpPassword</i> is <b>NULL</b>, the function uses the current default password associated with
///                 the user specified by the <i>lpUserName</i> parameter. If <i>lpPassword</i> points to an empty string, the
///                 function does not use a password. If the connection fails because of an invalid password and the
///                 CONNECT_INTERACTIVE value is set in the <i>dwFlags</i> parameter, the function displays a dialog box asking the
///                 user to type the password. <b>Windows Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    lpUserName = A pointer to a <b>null</b>-terminated string that specifies a user name for making the connection. If
///                 <i>lpUserName</i> is <b>NULL</b>, the function uses the default user name. (The user context for the process
///                 provides the default user name.) The <i>lpUserName</i> parameter is specified when users want to connect to a
///                 network resource for which they have been assigned a user name or account other than the default user name or
///                 account. The user-name string represents a security context. It may be specific to a network provider. <b>Windows
///                 Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    dwFlags = A set of connection options. The following values are currently defined. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CONNECT_INTERACTIVE"></a><a id="connect_interactive"></a><dl>
///              <dt><b>CONNECT_INTERACTIVE</b></dt> </dl> </td> <td width="60%"> If this flag is set, the operating system may
///              interact with the user for authentication purposes. </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_PROMPT"></a><a id="connect_prompt"></a><dl> <dt><b>CONNECT_PROMPT</b></dt> </dl> </td> <td
///              width="60%"> This flag instructs the system not to use any default settings for user names or passwords without
///              offering the user the opportunity to supply an alternative. This flag is ignored unless CONNECT_INTERACTIVE is
///              also set. </td> </tr> <tr> <td width="40%"><a id="CONNECT_REDIRECT"></a><a id="connect_redirect"></a><dl>
///              <dt><b>CONNECT_REDIRECT</b></dt> </dl> </td> <td width="60%"> This flag forces the redirection of a local device
///              when making the connection. If the <b>lpLocalName</b> member of NETRESOURCE specifies a local device to redirect,
///              this flag has no effect, because the operating system still attempts to redirect the specified device. When the
///              operating system automatically chooses a local device, the <b>dwType</b> member must not be equal to
///              RESOURCETYPE_ANY. If this flag is not set, a local device is automatically chosen for redirection only if the
///              network requires a local device to be redirected. <b>Windows Server 2003 and Windows XP: </b>When the system
///              automatically assigns network drive letters, letters are assigned beginning with Z:, then Y:, and ending with C:.
///              This reduces collision between per-logon drive letters (such as network drive letters) and global drive letters
///              (such as disk drives). Note that earlier versions of Windows assigned drive letters beginning with C: and ending
///              with Z:. </td> </tr> <tr> <td width="40%"><a id="CONNECT_UPDATE_PROFILE"></a><a
///              id="connect_update_profile"></a><dl> <dt><b>CONNECT_UPDATE_PROFILE</b></dt> </dl> </td> <td width="60%"> The
///              network resource connection should be remembered. If this bit flag is set, the operating system automatically
///              attempts to restore the connection when the user logs on. The operating system remembers only successful
///              connections that redirect local devices. It does not remember connections that are unsuccessful or deviceless
///              connections. (A deviceless connection occurs when the <b>lpLocalName</b> member is <b>NULL</b> or when it points
///              to an empty string.) If this bit flag is clear, the operating system does not automatically restore the
///              connection at logon. </td> </tr> <tr> <td width="40%"><a id="CONNECT_COMMANDLINE"></a><a
///              id="connect_commandline"></a><dl> <dt><b>CONNECT_COMMANDLINE</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, the operating system prompts the user for authentication using the command line instead of a graphical
///              user interface (GUI). This flag is ignored unless CONNECT_INTERACTIVE is also set. <b>Windows 2000/NT and Windows
///              Me/98/95: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CMD_SAVECRED"></a><a
///              id="connect_cmd_savecred"></a><dl> <dt><b>CONNECT_CMD_SAVECRED</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, and the operating system prompts for a credential, the credential should be saved by the credential
///              manager. If the credential manager is disabled for the caller's logon session, or if the network provider does
///              not support saving credentials, this flag is ignored. This flag is also ignored unless you set the
///              CONNECT_COMMANDLINE flag. <b>Windows 2000/NT and Windows Me/98/95: </b>This value is not supported. </td> </tr>
///              </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_ASSIGNED</b></dt>
///    </dl> </td> <td width="60%"> The local device specified by the <b>lpLocalName</b> member is already connected to
///    a network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td
///    width="60%"> The type of local device and the type of network resource do not match. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The value specified by
///    <b>lpLocalName</b> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl>
///    </td> <td width="60%"> The value specified by the <b>lpRemoteName</b> member is not acceptable to any network
///    resource provider, either because the resource name is invalid, or because the named resource cannot be located.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user
///    profile is in an incorrect format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt>
///    </dl> </td> <td width="60%"> The value specified by the <b>lpProvider</b> member does not match any provider.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td width="60%"> The router or
///    provider is busy, possibly initializing. The caller should retry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The attempt to make the connection was canceled by
///    the user through a dialog box from one of the network resource providers, or by a called resource. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td> <td width="60%"> The system is
///    unable to open the user profile to process persistent connections. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEVICE_ALREADY_REMEMBERED</b></dt> </dl> </td> <td width="60%"> An entry for the device specified by
///    the <b>lpLocalName</b> member is already in the user profile. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Call the
///    WNetGetLastError function to obtain a description of the error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%"> The specified password is invalid and the
///    CONNECT_INTERACTIVE flag is not set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The operation cannot be performed because a
///    network component is not started or because a specified name cannot be used. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr>
///    </table>
///    
@DllImport("MPR")
uint WNetAddConnection3A(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(char)* lpPassword, 
                         const(char)* lpUserName, uint dwFlags);

///The <b>WNetAddConnection3</b> function makes a connection to a network resource. The function can redirect a local
///device to the network resource. The <b>WNetAddConnection3</b> function is similar to the WNetAddConnection2 function.
///The main difference is that <b>WNetAddConnection3</b> has an additional parameter, a handle to a window that the
///provider of network resources can use as an owner window for dialog boxes. The <b>WNetAddConnection2</b> function and
///the <b>WNetAddConnection3</b> function supersede the WNetAddConnection function.
///Params:
///    hwndOwner = A handle to a window that the provider of network resources can use as an owner window for dialog boxes. Use this
///                parameter if you set the CONNECT_INTERACTIVE value in the <i>dwFlags</i> parameter. The <i>hwndOwner</i>
///                parameter can be <b>NULL</b>. If it is, a call to <b>WNetAddConnection3</b> is equivalent to calling the
///                WNetAddConnection2 function.
///    lpNetResource = A pointer to a NETRESOURCE structure that specifies details of the proposed connection, such as information about
///                    the network resource, the local device, and the network resource provider. You must specify the following members
///                    of the NETRESOURCE structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl> <dt><b><b>dwType</b></b></dt> </dl> </td> <td
///                    width="60%"> The type of network resource to connect to. If the <b>lpLocalName</b> member points to a nonempty
///                    string, this member can be equal to RESOURCETYPE_DISK or RESOURCETYPE_PRINT. If <b>lpLocalName</b> is
///                    <b>NULL</b>, or if it points to an empty string, <b>dwType</b> can be equal to RESOURCETYPE_DISK,
///                    RESOURCETYPE_PRINT, or RESOURCETYPE_ANY. Although this member is required, its information may be ignored by the
///                    network service provider. </td> </tr> <tr> <td width="40%"><a id="lpLocalName"></a><a id="lplocalname"></a><a
///                    id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a
///                    <b>null</b>-terminated string that specifies the name of a local device to redirect, such as "F:" or "LPT1". The
///                    string is treated in a case-insensitive manner. If the string is empty or if <b>lpLocalName</b> is <b>NULL</b>,
///                    the function makes a connection to the network resource without redirecting a local device. </td> </tr> <tr> <td
///                    width="40%"><a id="lpRemoteName"></a><a id="lpremotename"></a><a id="LPREMOTENAME"></a><dl>
///                    <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td width="60%"> A pointer to a <b>null</b>-terminated string
///                    that specifies the network resource to connect to. The string can be up to MAX_PATH characters in length, and
///                    must follow the network provider's naming conventions. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a
///                    id="lpprovider"></a><a id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> A
///                    pointer to a <b>null</b>-terminated string that specifies the network provider to connect to. If
///                    <b>lpProvider</b> is <b>NULL</b>, or if it points to an empty string, the operating system attempts to determine
///                    the correct provider by parsing the string pointed to by the <b>lpRemoteName</b> member. If this member is not
///                    <b>NULL</b>, the operating system attempts to make a connection only to the named network provider. You should
///                    set this member only if you know which network provider you want to use. Otherwise, let the operating system
///                    determine which network provider the network name maps to. </td> </tr> </table> The <b>WNetAddConnection3</b>
///                    function ignores the other members of the NETRESOURCE structure.
///    lpPassword = A pointer to a <b>null</b>-terminated string that specifies a password to be used in making the network
///                 connection. If <i>lpPassword</i> is <b>NULL</b>, the function uses the current default password associated with
///                 the user specified by the <i>lpUserName</i> parameter. If <i>lpPassword</i> points to an empty string, the
///                 function does not use a password. If the connection fails because of an invalid password and the
///                 CONNECT_INTERACTIVE value is set in the <i>dwFlags</i> parameter, the function displays a dialog box asking the
///                 user to type the password. <b>Windows Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    lpUserName = A pointer to a <b>null</b>-terminated string that specifies a user name for making the connection. If
///                 <i>lpUserName</i> is <b>NULL</b>, the function uses the default user name. (The user context for the process
///                 provides the default user name.) The <i>lpUserName</i> parameter is specified when users want to connect to a
///                 network resource for which they have been assigned a user name or account other than the default user name or
///                 account. The user-name string represents a security context. It may be specific to a network provider. <b>Windows
///                 Me/98/95: </b>This parameter must be <b>NULL</b> or an empty string.
///    dwFlags = A set of connection options. The following values are currently defined. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CONNECT_INTERACTIVE"></a><a id="connect_interactive"></a><dl>
///              <dt><b>CONNECT_INTERACTIVE</b></dt> </dl> </td> <td width="60%"> If this flag is set, the operating system may
///              interact with the user for authentication purposes. </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_PROMPT"></a><a id="connect_prompt"></a><dl> <dt><b>CONNECT_PROMPT</b></dt> </dl> </td> <td
///              width="60%"> This flag instructs the system not to use any default settings for user names or passwords without
///              offering the user the opportunity to supply an alternative. This flag is ignored unless CONNECT_INTERACTIVE is
///              also set. </td> </tr> <tr> <td width="40%"><a id="CONNECT_REDIRECT"></a><a id="connect_redirect"></a><dl>
///              <dt><b>CONNECT_REDIRECT</b></dt> </dl> </td> <td width="60%"> This flag forces the redirection of a local device
///              when making the connection. If the <b>lpLocalName</b> member of NETRESOURCE specifies a local device to redirect,
///              this flag has no effect, because the operating system still attempts to redirect the specified device. When the
///              operating system automatically chooses a local device, the <b>dwType</b> member must not be equal to
///              RESOURCETYPE_ANY. If this flag is not set, a local device is automatically chosen for redirection only if the
///              network requires a local device to be redirected. <b>Windows Server 2003 and Windows XP: </b>When the system
///              automatically assigns network drive letters, letters are assigned beginning with Z:, then Y:, and ending with C:.
///              This reduces collision between per-logon drive letters (such as network drive letters) and global drive letters
///              (such as disk drives). Note that earlier versions of Windows assigned drive letters beginning with C: and ending
///              with Z:. </td> </tr> <tr> <td width="40%"><a id="CONNECT_UPDATE_PROFILE"></a><a
///              id="connect_update_profile"></a><dl> <dt><b>CONNECT_UPDATE_PROFILE</b></dt> </dl> </td> <td width="60%"> The
///              network resource connection should be remembered. If this bit flag is set, the operating system automatically
///              attempts to restore the connection when the user logs on. The operating system remembers only successful
///              connections that redirect local devices. It does not remember connections that are unsuccessful or deviceless
///              connections. (A deviceless connection occurs when the <b>lpLocalName</b> member is <b>NULL</b> or when it points
///              to an empty string.) If this bit flag is clear, the operating system does not automatically restore the
///              connection at logon. </td> </tr> <tr> <td width="40%"><a id="CONNECT_COMMANDLINE"></a><a
///              id="connect_commandline"></a><dl> <dt><b>CONNECT_COMMANDLINE</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, the operating system prompts the user for authentication using the command line instead of a graphical
///              user interface (GUI). This flag is ignored unless CONNECT_INTERACTIVE is also set. <b>Windows 2000/NT and Windows
///              Me/98/95: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CMD_SAVECRED"></a><a
///              id="connect_cmd_savecred"></a><dl> <dt><b>CONNECT_CMD_SAVECRED</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, and the operating system prompts for a credential, the credential should be saved by the credential
///              manager. If the credential manager is disabled for the caller's logon session, or if the network provider does
///              not support saving credentials, this flag is ignored. This flag is also ignored unless you set the
///              CONNECT_COMMANDLINE flag. <b>Windows 2000/NT and Windows Me/98/95: </b>This value is not supported. </td> </tr>
///              </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_ASSIGNED</b></dt>
///    </dl> </td> <td width="60%"> The local device specified by the <b>lpLocalName</b> member is already connected to
///    a network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td
///    width="60%"> The type of local device and the type of network resource do not match. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The value specified by
///    <b>lpLocalName</b> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl>
///    </td> <td width="60%"> The value specified by the <b>lpRemoteName</b> member is not acceptable to any network
///    resource provider, either because the resource name is invalid, or because the named resource cannot be located.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user
///    profile is in an incorrect format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt>
///    </dl> </td> <td width="60%"> The value specified by the <b>lpProvider</b> member does not match any provider.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td width="60%"> The router or
///    provider is busy, possibly initializing. The caller should retry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The attempt to make the connection was canceled by
///    the user through a dialog box from one of the network resource providers, or by a called resource. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td> <td width="60%"> The system is
///    unable to open the user profile to process persistent connections. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEVICE_ALREADY_REMEMBERED</b></dt> </dl> </td> <td width="60%"> An entry for the device specified by
///    the <b>lpLocalName</b> member is already in the user profile. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Call the
///    WNetGetLastError function to obtain a description of the error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%"> The specified password is invalid and the
///    CONNECT_INTERACTIVE flag is not set. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The operation cannot be performed because a
///    network component is not started or because a specified name cannot be used. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr>
///    </table>
///    
@DllImport("MPR")
uint WNetAddConnection3W(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, 
                         const(wchar)* lpUserName, uint dwFlags);

@DllImport("MPR")
uint WNetAddConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions);

@DllImport("MPR")
uint WNetAddConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions);

///The <b>WNetCancelConnection</b> function cancels an existing network connection. The <b>WNetCancelConnection</b>
///function is provided for compatibility with 16-bit versions of Windows. Other Windows-based applications should call
///the WNetCancelConnection2 function.
///Params:
///    lpName = Pointer to a constant null-terminated string that specifies the name of either the redirected local device or the
///             remote network resource to disconnect from. When this parameter specifies a redirected local device, the function
///             cancels only the specified device redirection. If the parameter specifies a remote network resource, only the
///             connections to remote networks without devices are canceled.
///    fForce = Specifies whether or not the disconnection should occur if there are open files or jobs on the connection. If
///             this parameter is <b>FALSE</b>, the function fails if there are open files or jobs.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user profile is in an
///    incorrect format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td>
///    <td width="60%"> The system is unable to open the user profile to process persistent connections. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_IN_USE</b></dt> </dl> </td> <td width="60%"> The device is in use
///    by an active process and cannot be disconnected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The name specified by the <i>lpName</i>
///    parameter is not a redirected device, or the system is not currently connected to the device specified by the
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OPEN_FILES</b></dt> </dl> </td> <td width="60%">
///    There are open files, and the <i>fForce</i> parameter is <b>FALSE</b>. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetCancelConnectionA(const(char)* lpName, BOOL fForce);

///The <b>WNetCancelConnection</b> function cancels an existing network connection. The <b>WNetCancelConnection</b>
///function is provided for compatibility with 16-bit versions of Windows. Other Windows-based applications should call
///the WNetCancelConnection2 function.
///Params:
///    lpName = Pointer to a constant null-terminated string that specifies the name of either the redirected local device or the
///             remote network resource to disconnect from. When this parameter specifies a redirected local device, the function
///             cancels only the specified device redirection. If the parameter specifies a remote network resource, only the
///             connections to remote networks without devices are canceled.
///    fForce = Specifies whether or not the disconnection should occur if there are open files or jobs on the connection. If
///             this parameter is <b>FALSE</b>, the function fails if there are open files or jobs.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user profile is in an
///    incorrect format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td>
///    <td width="60%"> The system is unable to open the user profile to process persistent connections. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_IN_USE</b></dt> </dl> </td> <td width="60%"> The device is in use
///    by an active process and cannot be disconnected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The name specified by the <i>lpName</i>
///    parameter is not a redirected device, or the system is not currently connected to the device specified by the
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OPEN_FILES</b></dt> </dl> </td> <td width="60%">
///    There are open files, and the <i>fForce</i> parameter is <b>FALSE</b>. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetCancelConnectionW(const(wchar)* lpName, BOOL fForce);

///The <b>WNetCancelConnection2</b> function cancels an existing network connection. You can also call the function to
///remove remembered network connections that are not currently connected. The <b>WNetCancelConnection2</b> function
///supersedes the WNetCancelConnection function.
///Params:
///    lpName = Pointer to a constant <b>null</b>-terminated string that specifies the name of either the redirected local device
///             or the remote network resource to disconnect from. If this parameter specifies a redirected local device, the
///             function cancels only the specified device redirection. If the parameter specifies a remote network resource, all
///             connections without devices are canceled.
///    dwFlags = Connection type. The following values are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The system does not update
///              information about the connection. If the connection was marked as persistent in the registry, the system
///              continues to restore the connection at the next logon. If the connection was not marked as persistent, the
///              function ignores the setting of the CONNECT_UPDATE_PROFILE flag. </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_UPDATE_PROFILE"></a><a id="connect_update_profile"></a><dl> <dt><b>CONNECT_UPDATE_PROFILE</b></dt>
///              </dl> </td> <td width="60%"> The system updates the user profile with the information that the connection is no
///              longer a persistent one. The system will not restore this connection during subsequent logon operations.
///              (Disconnecting resources using remote names has no effect on persistent connections.) </td> </tr> </table>
///    fForce = Specifies whether the disconnection should occur if there are open files or jobs on the connection. If this
///             parameter is <b>FALSE</b>, the function fails if there are open files or jobs.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user profile is in an
///    incorrect format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td>
///    <td width="60%"> The system is unable to open the user profile to process persistent connections. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_IN_USE</b></dt> </dl> </td> <td width="60%"> The device is in use
///    by an active process and cannot be disconnected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The name specified by the <i>lpName</i>
///    parameter is not a redirected device, or the system is not currently connected to the device specified by the
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OPEN_FILES</b></dt> </dl> </td> <td width="60%">
///    There are open files, and the <i>fForce</i> parameter is <b>FALSE</b>. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetCancelConnection2A(const(char)* lpName, uint dwFlags, BOOL fForce);

///The <b>WNetCancelConnection2</b> function cancels an existing network connection. You can also call the function to
///remove remembered network connections that are not currently connected. The <b>WNetCancelConnection2</b> function
///supersedes the WNetCancelConnection function.
///Params:
///    lpName = Pointer to a constant <b>null</b>-terminated string that specifies the name of either the redirected local device
///             or the remote network resource to disconnect from. If this parameter specifies a redirected local device, the
///             function cancels only the specified device redirection. If the parameter specifies a remote network resource, all
///             connections without devices are canceled.
///    dwFlags = Connection type. The following values are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The system does not update
///              information about the connection. If the connection was marked as persistent in the registry, the system
///              continues to restore the connection at the next logon. If the connection was not marked as persistent, the
///              function ignores the setting of the CONNECT_UPDATE_PROFILE flag. </td> </tr> <tr> <td width="40%"><a
///              id="CONNECT_UPDATE_PROFILE"></a><a id="connect_update_profile"></a><dl> <dt><b>CONNECT_UPDATE_PROFILE</b></dt>
///              </dl> </td> <td width="60%"> The system updates the user profile with the information that the connection is no
///              longer a persistent one. The system will not restore this connection during subsequent logon operations.
///              (Disconnecting resources using remote names has no effect on persistent connections.) </td> </tr> </table>
///    fForce = Specifies whether the disconnection should occur if there are open files or jobs on the connection. If this
///             parameter is <b>FALSE</b>, the function fails if there are open files or jobs.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_PROFILE</b></dt> </dl> </td> <td width="60%"> The user profile is in an
///    incorrect format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANNOT_OPEN_PROFILE</b></dt> </dl> </td>
///    <td width="60%"> The system is unable to open the user profile to process persistent connections. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_IN_USE</b></dt> </dl> </td> <td width="60%"> The device is in use
///    by an active process and cannot be disconnected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The name specified by the <i>lpName</i>
///    parameter is not a redirected device, or the system is not currently connected to the device specified by the
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OPEN_FILES</b></dt> </dl> </td> <td width="60%">
///    There are open files, and the <i>fForce</i> parameter is <b>FALSE</b>. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetCancelConnection2W(const(wchar)* lpName, uint dwFlags, BOOL fForce);

///The <b>WNetGetConnection</b> function retrieves the name of the network resource associated with a local device.
///Params:
///    lpLocalName = Pointer to a constant null-terminated string that specifies the name of the local device to get the network name
///                  for.
///    lpRemoteName = Pointer to a null-terminated string that receives the remote name used to make the connection.
///    lpnLength = Pointer to a variable that specifies the size of the buffer pointed to by the <i>lpRemoteName</i> parameter, in
///                characters. If the function fails because the buffer is not large enough, this parameter returns the required
///                buffer size.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The string pointed to by the
///    <i>lpLocalName</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The device specified by <i>lpLocalName</i> is
///    not a redirected device. For more information, see the following Remarks section. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer is too small. The
///    <i>lpnLength</i> parameter points to a variable that contains the required buffer size. More entries are
///    available with subsequent calls. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CONNECTION_UNAVAIL</b></dt>
///    </dl> </td> <td width="60%"> The device is not currently connected, but it is a persistent connection. For more
///    information, see the following Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error
///    occurred. To obtain a description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> None of the providers
///    recognize the local name as having a connection. However, the network is not available for at least one provider
///    to whom the connection may belong. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetConnectionA(const(char)* lpLocalName, const(char)* lpRemoteName, uint* lpnLength);

///The <b>WNetGetConnection</b> function retrieves the name of the network resource associated with a local device.
///Params:
///    lpLocalName = Pointer to a constant null-terminated string that specifies the name of the local device to get the network name
///                  for.
///    lpRemoteName = Pointer to a null-terminated string that receives the remote name used to make the connection.
///    lpnLength = Pointer to a variable that specifies the size of the buffer pointed to by the <i>lpRemoteName</i> parameter, in
///                characters. If the function fails because the buffer is not large enough, this parameter returns the required
///                buffer size.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The string pointed to by the
///    <i>lpLocalName</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The device specified by <i>lpLocalName</i> is
///    not a redirected device. For more information, see the following Remarks section. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer is too small. The
///    <i>lpnLength</i> parameter points to a variable that contains the required buffer size. More entries are
///    available with subsequent calls. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CONNECTION_UNAVAIL</b></dt>
///    </dl> </td> <td width="60%"> The device is not currently connected, but it is a persistent connection. For more
///    information, see the following Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error
///    occurred. To obtain a description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> None of the providers
///    recognize the local name as having a connection. However, the network is not available for at least one provider
///    to whom the connection may belong. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetConnectionW(const(wchar)* lpLocalName, const(wchar)* lpRemoteName, uint* lpnLength);

///The <b>WNetUseConnection</b> function makes a connection to a network resource. The function can redirect a local
///device to a network resource. The <b>WNetUseConnection</b> function is similar to the WNetAddConnection3 function.
///The main difference is that <b>WNetUseConnection</b> can automatically select an unused local device to redirect to
///the network resource.
///Params:
///    hwndOwner = Handle to a window that the provider of network resources can use as an owner window for dialog boxes. Use this
///                parameter if you set the CONNECT_INTERACTIVE value in the <i>dwFlags</i> parameter.
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies details of the proposed connection. The structure contains
///                    information about the network resource, the local device, and the network resource provider. You must specify the
///                    following members of the <b>NETRESOURCE</b> structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr>
///                    <td width="40%"><a id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl> <dt><b><b>dwType</b></b></dt> </dl>
///                    </td> <td width="60%"> Specifies the type of resource to connect to. It is most efficient to specify a resource
///                    type in this member, such as RESOURCETYPE_DISK or RESOURCETYPE_PRINT. However, if the <b>lpLocalName</b> member
///                    is <b>NULL</b>, or if it points to an empty string and CONNECT_REDIRECT is not set, <b>dwType</b> can be
///                    RESOURCETYPE_ANY. This method works only if the function does not automatically choose a device to redirect to
///                    the network resource. Although this member is required, its information may be ignored by the network service
///                    provider. </td> </tr> <tr> <td width="40%"><a id="lpLocalName"></a><a id="lplocalname"></a><a
///                    id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt> </dl> </td> <td width="60%"> Pointer to a
///                    <b>null</b>-terminated string that specifies the name of a local device to be redirected, such as "F:" or "LPT1".
///                    The string is treated in a case-insensitive manner. If the string is empty, or if <b>lpLocalName</b> is
///                    <b>NULL</b>, a connection to the network occurs without redirection. If the CONNECT_REDIRECT value is set in the
///                    <i>dwFlags</i> parameter, or if the network requires a redirected local device, the function chooses a local
///                    device to redirect and returns the name of the device in the <i>lpAccessName</i> parameter. </td> </tr> <tr> <td
///                    width="40%"><a id="lpRemoteName"></a><a id="lpremotename"></a><a id="LPREMOTENAME"></a><dl>
///                    <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td width="60%"> Pointer to a <b>null</b>-terminated string that
///                    specifies the network resource to connect to. The string can be up to MAX_PATH characters in length, and it must
///                    follow the network provider's naming conventions. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a
///                    id="lpprovider"></a><a id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%">
///                    Pointer to a <b>null</b>-terminated string that specifies the network provider to connect to. If
///                    <b>lpProvider</b> is <b>NULL</b>, or if it points to an empty string, the operating system attempts to determine
///                    the correct provider by parsing the string pointed to by the <b>lpRemoteName</b> member. If this member is not
///                    <b>NULL</b>, the operating system attempts to make a connection only to the named network provider. You should
///                    set this member only if you know the network provider you want to use. Otherwise, let the operating system
///                    determine which provider the network name maps to. </td> </tr> </table> The <b>WNetUseConnection</b> function
///                    ignores the other members of the NETRESOURCE structure. For more information, see the descriptions following for
///                    the <i>dwFlags</i> parameter.
///    lpPassword = Pointer to a constant <b>null</b>-terminated string that specifies a password to be used in making the network
///                 connection. If <i>lpPassword</i> is <b>NULL</b>, the function uses the current default password associated with
///                 the user specified by <i>lpUserID</i>. If <i>lpPassword</i> points to an empty string, the function does not use
///                 a password. If the connection fails because of an invalid password and the CONNECT_INTERACTIVE value is set in
///                 the <i>dwFlags</i> parameter, the function displays a dialog box asking the user to type the password.
///    lpUserId = Pointer to a constant <b>null</b>-terminated string that specifies a user name for making the connection. If
///               <i>lpUserID</i> is <b>NULL</b>, the function uses the default user name. (The user context for the process
///               provides the default user name.) The <i>lpUserID</i> parameter is specified when users want to connect to a
///               network resource for which they have been assigned a user name or account other than the default user name or
///               account. The user-name string represents a security context. It may be specific to a network provider.
///    dwFlags = Set of bit flags describing the connection. This parameter can be any combination of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CONNECT_INTERACTIVE"></a><a
///              id="connect_interactive"></a><dl> <dt><b>CONNECT_INTERACTIVE</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, the operating system may interact with the user for authentication purposes. </td> </tr> <tr> <td
///              width="40%"><a id="CONNECT_PROMPT"></a><a id="connect_prompt"></a><dl> <dt><b>CONNECT_PROMPT</b></dt> </dl> </td>
///              <td width="60%"> This flag instructs the system not to use any default settings for user names or passwords
///              without offering the user the opportunity to supply an alternative. This flag is ignored unless
///              CONNECT_INTERACTIVE is also set. </td> </tr> <tr> <td width="40%"><a id="CONNECT_REDIRECT"></a><a
///              id="connect_redirect"></a><dl> <dt><b>CONNECT_REDIRECT</b></dt> </dl> </td> <td width="60%"> This flag forces the
///              redirection of a local device when making the connection. If the <b>lpLocalName</b> member of NETRESOURCE
///              specifies a local device to redirect, this flag has no effect, because the operating system still attempts to
///              redirect the specified device. When the operating system automatically chooses a local device, the <b>dwType</b>
///              member must not be equal to RESOURCETYPE_ANY. If this flag is not set, a local device is automatically chosen for
///              redirection only if the network requires a local device to be redirected. <b>Windows XP: </b>When the system
///              automatically assigns network drive letters, letters are assigned beginning with Z:, then Y:, and ending with C:.
///              This reduces collision between per-logon drive letters (such as network drive letters) and global drive letters
///              (such as disk drives). Note that previous releases assigned drive letters beginning with C: and ending with Z:.
///              </td> </tr> <tr> <td width="40%"><a id="CONNECT_UPDATE_PROFILE"></a><a id="connect_update_profile"></a><dl>
///              <dt><b>CONNECT_UPDATE_PROFILE</b></dt> </dl> </td> <td width="60%"> This flag instructs the operating system to
///              store the network resource connection. If this bit flag is set, the operating system automatically attempts to
///              restore the connection when the user logs on. The system remembers only successful connections that redirect
///              local devices. It does not remember connections that are unsuccessful or deviceless connections. (A deviceless
///              connection occurs when <b>lpLocalName</b> is <b>NULL</b> or when it points to an empty string.) If this bit flag
///              is clear, the operating system does not automatically restore the connection at logon. </td> </tr> <tr> <td
///              width="40%"><a id="CONNECT_COMMANDLINE"></a><a id="connect_commandline"></a><dl>
///              <dt><b>CONNECT_COMMANDLINE</b></dt> </dl> </td> <td width="60%"> If this flag is set, the operating system
///              prompts the user for authentication using the command line instead of a graphical user interface (GUI). This flag
///              is ignored unless CONNECT_INTERACTIVE is also set. <b>Windows 2000/NT and Windows Me/98/95: </b>This value is not
///              supported. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CMD_SAVECRED"></a><a
///              id="connect_cmd_savecred"></a><dl> <dt><b>CONNECT_CMD_SAVECRED</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, and the operating system prompts for a credential, the credential should be saved by the credential
///              manager. If the credential manager is disabled for the caller's logon session, or if the network provider does
///              not support saving credentials, this flag is ignored. This flag is also ignored unless you set the
///              CONNECT_COMMANDLINE flag. <b>Windows 2000/NT and Windows Me/98/95: </b>This value is not supported. </td> </tr>
///              </table>
///    lpAccessName = Pointer to a buffer that receives system requests on the connection. This parameter can be <b>NULL</b>. If this
///                   parameter is specified, and the <b>lpLocalName</b> member of the <b>NETRESOURCE</b> structure specifies a local
///                   device, this buffer receives the local device name. If <b>lpLocalName</b> does not specify a device and the
///                   network requires a local device redirection, or if the CONNECT_REDIRECT value is set, this buffer receives the
///                   name of the redirected local device. Otherwise, the name copied into the buffer is that of a remote resource. If
///                   specified, this buffer must be at least as large as the string pointed to by the <b>lpRemoteName</b> member.
///    lpBufferSize = Pointer to a variable that specifies the size of the <i>lpAccessName</i> buffer, in characters. If the call fails
///                   because the buffer is not large enough, the function returns the required buffer size in this location. For more
///                   information, see the descriptions of the <i>lpAccessName</i> parameter and the ERROR_MORE_DATA error code in the
///                   Return Values section.
///    lpResult = Pointer to a variable that receives additional information about the connection. This parameter can be the
///               following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="CONNECT_LOCALDRIVE"></a><a id="connect_localdrive"></a><dl> <dt><b>CONNECT_LOCALDRIVE</b></dt> </dl> </td>
///               <td width="60%"> If this flag is set, the connection was made using a local device redirection. If the
///               <i>lpAccessName</i> parameter points to a buffer, the local device name is copied to the buffer. </td> </tr>
///               </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_ASSIGNED</b></dt>
///    </dl> </td> <td width="60%"> The local device specified by the <b>lpLocalName</b> member is already connected to
///    a network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td
///    width="60%"> The value specified by <b>lpLocalName</b> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The value specified by the <b>lpRemoteName</b>
///    member is not acceptable to any network resource provider because the resource name is invalid, or because the
///    named resource cannot be located. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl>
///    </td> <td width="60%"> The value specified by the <b>lpProvider</b> member does not match any provider. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The attempt to make
///    the connection was canceled by the user through a dialog box from one of the network resource providers, or by a
///    called resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td
///    width="60%"> A network-specific error occurred. To obtain a description of the error, call the WNetGetLastError
///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td
///    width="60%"> The caller passed in a pointer to a buffer that could not be accessed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> This error is a result of
///    one of the following conditions: <ol> <li>The <b>lpRemoteName</b> member is <b>NULL</b>. In addition,
///    <i>lpAccessName</i> is not <b>NULL</b>, but <i>lpBufferSize</i> is either <b>NULL</b> or points to zero.</li>
///    <li>The <b>dwType</b> member is neither RESOURCETYPE_DISK nor RESOURCETYPE_PRINT. In addition, either
///    CONNECT_REDIRECT is set in <i>dwFlags</i> and <b>lpLocalName</b> is <b>NULL</b>, or the connection is to a
///    network that requires the redirecting of a local device.</li> </ol> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%"> The specified password is invalid and the
///    CONNECT_INTERACTIVE flag is not set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>lpAccessName</i> buffer is too small. If a local device is redirected, the buffer
///    needs to be large enough to contain the local device name. Otherwise, the buffer needs to be large enough to
///    contain either the string pointed to by <b>lpRemoteName</b>, or the name of the connectable resource whose alias
///    is pointed to by <b>lpRemoteName</b>. If this error is returned, then no connection has been made. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The operating system
///    cannot automatically choose a local redirection because all the valid local devices are in use. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The operation could
///    not be completed, either because a network component is not started, or because the specified resource name is
///    not recognized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetUseConnectionA(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(char)* lpPassword, 
                        const(char)* lpUserId, uint dwFlags, const(char)* lpAccessName, uint* lpBufferSize, 
                        uint* lpResult);

///The <b>WNetUseConnection</b> function makes a connection to a network resource. The function can redirect a local
///device to a network resource. The <b>WNetUseConnection</b> function is similar to the WNetAddConnection3 function.
///The main difference is that <b>WNetUseConnection</b> can automatically select an unused local device to redirect to
///the network resource.
///Params:
///    hwndOwner = Handle to a window that the provider of network resources can use as an owner window for dialog boxes. Use this
///                parameter if you set the CONNECT_INTERACTIVE value in the <i>dwFlags</i> parameter.
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies details of the proposed connection. The structure contains
///                    information about the network resource, the local device, and the network resource provider. You must specify the
///                    following members of the <b>NETRESOURCE</b> structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr>
///                    <td width="40%"><a id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl> <dt><b><b>dwType</b></b></dt> </dl>
///                    </td> <td width="60%"> Specifies the type of resource to connect to. It is most efficient to specify a resource
///                    type in this member, such as RESOURCETYPE_DISK or RESOURCETYPE_PRINT. However, if the <b>lpLocalName</b> member
///                    is <b>NULL</b>, or if it points to an empty string and CONNECT_REDIRECT is not set, <b>dwType</b> can be
///                    RESOURCETYPE_ANY. This method works only if the function does not automatically choose a device to redirect to
///                    the network resource. Although this member is required, its information may be ignored by the network service
///                    provider. </td> </tr> <tr> <td width="40%"><a id="lpLocalName"></a><a id="lplocalname"></a><a
///                    id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt> </dl> </td> <td width="60%"> Pointer to a
///                    <b>null</b>-terminated string that specifies the name of a local device to be redirected, such as "F:" or "LPT1".
///                    The string is treated in a case-insensitive manner. If the string is empty, or if <b>lpLocalName</b> is
///                    <b>NULL</b>, a connection to the network occurs without redirection. If the CONNECT_REDIRECT value is set in the
///                    <i>dwFlags</i> parameter, or if the network requires a redirected local device, the function chooses a local
///                    device to redirect and returns the name of the device in the <i>lpAccessName</i> parameter. </td> </tr> <tr> <td
///                    width="40%"><a id="lpRemoteName"></a><a id="lpremotename"></a><a id="LPREMOTENAME"></a><dl>
///                    <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td width="60%"> Pointer to a <b>null</b>-terminated string that
///                    specifies the network resource to connect to. The string can be up to MAX_PATH characters in length, and it must
///                    follow the network provider's naming conventions. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a
///                    id="lpprovider"></a><a id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%">
///                    Pointer to a <b>null</b>-terminated string that specifies the network provider to connect to. If
///                    <b>lpProvider</b> is <b>NULL</b>, or if it points to an empty string, the operating system attempts to determine
///                    the correct provider by parsing the string pointed to by the <b>lpRemoteName</b> member. If this member is not
///                    <b>NULL</b>, the operating system attempts to make a connection only to the named network provider. You should
///                    set this member only if you know the network provider you want to use. Otherwise, let the operating system
///                    determine which provider the network name maps to. </td> </tr> </table> The <b>WNetUseConnection</b> function
///                    ignores the other members of the NETRESOURCE structure. For more information, see the descriptions following for
///                    the <i>dwFlags</i> parameter.
///    lpPassword = Pointer to a constant <b>null</b>-terminated string that specifies a password to be used in making the network
///                 connection. If <i>lpPassword</i> is <b>NULL</b>, the function uses the current default password associated with
///                 the user specified by <i>lpUserID</i>. If <i>lpPassword</i> points to an empty string, the function does not use
///                 a password. If the connection fails because of an invalid password and the CONNECT_INTERACTIVE value is set in
///                 the <i>dwFlags</i> parameter, the function displays a dialog box asking the user to type the password.
///    lpUserId = Pointer to a constant <b>null</b>-terminated string that specifies a user name for making the connection. If
///               <i>lpUserID</i> is <b>NULL</b>, the function uses the default user name. (The user context for the process
///               provides the default user name.) The <i>lpUserID</i> parameter is specified when users want to connect to a
///               network resource for which they have been assigned a user name or account other than the default user name or
///               account. The user-name string represents a security context. It may be specific to a network provider.
///    dwFlags = Set of bit flags describing the connection. This parameter can be any combination of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CONNECT_INTERACTIVE"></a><a
///              id="connect_interactive"></a><dl> <dt><b>CONNECT_INTERACTIVE</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, the operating system may interact with the user for authentication purposes. </td> </tr> <tr> <td
///              width="40%"><a id="CONNECT_PROMPT"></a><a id="connect_prompt"></a><dl> <dt><b>CONNECT_PROMPT</b></dt> </dl> </td>
///              <td width="60%"> This flag instructs the system not to use any default settings for user names or passwords
///              without offering the user the opportunity to supply an alternative. This flag is ignored unless
///              CONNECT_INTERACTIVE is also set. </td> </tr> <tr> <td width="40%"><a id="CONNECT_REDIRECT"></a><a
///              id="connect_redirect"></a><dl> <dt><b>CONNECT_REDIRECT</b></dt> </dl> </td> <td width="60%"> This flag forces the
///              redirection of a local device when making the connection. If the <b>lpLocalName</b> member of NETRESOURCE
///              specifies a local device to redirect, this flag has no effect, because the operating system still attempts to
///              redirect the specified device. When the operating system automatically chooses a local device, the <b>dwType</b>
///              member must not be equal to RESOURCETYPE_ANY. If this flag is not set, a local device is automatically chosen for
///              redirection only if the network requires a local device to be redirected. <b>Windows XP: </b>When the system
///              automatically assigns network drive letters, letters are assigned beginning with Z:, then Y:, and ending with C:.
///              This reduces collision between per-logon drive letters (such as network drive letters) and global drive letters
///              (such as disk drives). Note that previous releases assigned drive letters beginning with C: and ending with Z:.
///              </td> </tr> <tr> <td width="40%"><a id="CONNECT_UPDATE_PROFILE"></a><a id="connect_update_profile"></a><dl>
///              <dt><b>CONNECT_UPDATE_PROFILE</b></dt> </dl> </td> <td width="60%"> This flag instructs the operating system to
///              store the network resource connection. If this bit flag is set, the operating system automatically attempts to
///              restore the connection when the user logs on. The system remembers only successful connections that redirect
///              local devices. It does not remember connections that are unsuccessful or deviceless connections. (A deviceless
///              connection occurs when <b>lpLocalName</b> is <b>NULL</b> or when it points to an empty string.) If this bit flag
///              is clear, the operating system does not automatically restore the connection at logon. </td> </tr> <tr> <td
///              width="40%"><a id="CONNECT_COMMANDLINE"></a><a id="connect_commandline"></a><dl>
///              <dt><b>CONNECT_COMMANDLINE</b></dt> </dl> </td> <td width="60%"> If this flag is set, the operating system
///              prompts the user for authentication using the command line instead of a graphical user interface (GUI). This flag
///              is ignored unless CONNECT_INTERACTIVE is also set. <b>Windows 2000/NT and Windows Me/98/95: </b>This value is not
///              supported. </td> </tr> <tr> <td width="40%"><a id="CONNECT_CMD_SAVECRED"></a><a
///              id="connect_cmd_savecred"></a><dl> <dt><b>CONNECT_CMD_SAVECRED</b></dt> </dl> </td> <td width="60%"> If this flag
///              is set, and the operating system prompts for a credential, the credential should be saved by the credential
///              manager. If the credential manager is disabled for the caller's logon session, or if the network provider does
///              not support saving credentials, this flag is ignored. This flag is also ignored unless you set the
///              CONNECT_COMMANDLINE flag. <b>Windows 2000/NT and Windows Me/98/95: </b>This value is not supported. </td> </tr>
///              </table>
///    lpAccessName = Pointer to a buffer that receives system requests on the connection. This parameter can be <b>NULL</b>. If this
///                   parameter is specified, and the <b>lpLocalName</b> member of the <b>NETRESOURCE</b> structure specifies a local
///                   device, this buffer receives the local device name. If <b>lpLocalName</b> does not specify a device and the
///                   network requires a local device redirection, or if the CONNECT_REDIRECT value is set, this buffer receives the
///                   name of the redirected local device. Otherwise, the name copied into the buffer is that of a remote resource. If
///                   specified, this buffer must be at least as large as the string pointed to by the <b>lpRemoteName</b> member.
///    lpBufferSize = Pointer to a variable that specifies the size of the <i>lpAccessName</i> buffer, in characters. If the call fails
///                   because the buffer is not large enough, the function returns the required buffer size in this location. For more
///                   information, see the descriptions of the <i>lpAccessName</i> parameter and the ERROR_MORE_DATA error code in the
///                   Return Values section.
///    lpResult = Pointer to a variable that receives additional information about the connection. This parameter can be the
///               following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="CONNECT_LOCALDRIVE"></a><a id="connect_localdrive"></a><dl> <dt><b>CONNECT_LOCALDRIVE</b></dt> </dl> </td>
///               <td width="60%"> If this flag is set, the connection was made using a local device redirection. If the
///               <i>lpAccessName</i> parameter points to a buffer, the local device name is copied to the buffer. </td> </tr>
///               </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_ASSIGNED</b></dt>
///    </dl> </td> <td width="60%"> The local device specified by the <b>lpLocalName</b> member is already connected to
///    a network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td
///    width="60%"> The value specified by <b>lpLocalName</b> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The value specified by the <b>lpRemoteName</b>
///    member is not acceptable to any network resource provider because the resource name is invalid, or because the
///    named resource cannot be located. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl>
///    </td> <td width="60%"> The value specified by the <b>lpProvider</b> member does not match any provider. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The attempt to make
///    the connection was canceled by the user through a dialog box from one of the network resource providers, or by a
///    called resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td
///    width="60%"> A network-specific error occurred. To obtain a description of the error, call the WNetGetLastError
///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td
///    width="60%"> The caller passed in a pointer to a buffer that could not be accessed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> This error is a result of
///    one of the following conditions: <ol> <li>The <b>lpRemoteName</b> member is <b>NULL</b>. In addition,
///    <i>lpAccessName</i> is not <b>NULL</b>, but <i>lpBufferSize</i> is either <b>NULL</b> or points to zero.</li>
///    <li>The <b>dwType</b> member is neither RESOURCETYPE_DISK nor RESOURCETYPE_PRINT. In addition, either
///    CONNECT_REDIRECT is set in <i>dwFlags</i> and <b>lpLocalName</b> is <b>NULL</b>, or the connection is to a
///    network that requires the redirecting of a local device.</li> </ol> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%"> The specified password is invalid and the
///    CONNECT_INTERACTIVE flag is not set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>lpAccessName</i> buffer is too small. If a local device is redirected, the buffer
///    needs to be large enough to contain the local device name. Otherwise, the buffer needs to be large enough to
///    contain either the string pointed to by <b>lpRemoteName</b>, or the name of the connectable resource whose alias
///    is pointed to by <b>lpRemoteName</b>. If this error is returned, then no connection has been made. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The operating system
///    cannot automatically choose a local redirection because all the valid local devices are in use. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The operation could
///    not be completed, either because a network component is not started, or because the specified resource name is
///    not recognized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetUseConnectionW(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, 
                        const(wchar)* lpUserId, uint dwFlags, const(wchar)* lpAccessName, uint* lpBufferSize, 
                        uint* lpResult);

@DllImport("MPR")
uint WNetUseConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions, const(char)* lpAccessName, 
                         uint* lpBufferSize, uint* lpResult);

@DllImport("MPR")
uint WNetUseConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, 
                         uint dwFlags, char* lpUseOptions, uint cbUseOptions, const(wchar)* lpAccessName, 
                         uint* lpBufferSize, uint* lpResult);

///The <b>WNetConnectionDialog</b> function starts a general browsing dialog box for connecting to network resources.
///The function requires a handle to the owner window for the dialog box.
///Params:
///    hwnd = Handle to the owner window for the dialog box.
///    dwType = Resource type to allow connections to. This parameter can be the following value. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCETYPE_DISK"></a><a id="resourcetype_disk"></a><dl>
///             <dt><b>RESOURCETYPE_DISK</b></dt> </dl> </td> <td width="60%"> Connections to disk resources. </td> </tr>
///             </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the user cancels the dialog box, the function returns
///    –1. If the function fails, the return value is a system error code, such as one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td> <td width="60%"> The specified password is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is
///    unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There is insufficient memory to start the dialog box. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetConnectionDialog(HWND hwnd, uint dwType);

///The <b>WNetDisconnectDialog</b> function starts a general browsing dialog box for disconnecting from network
///resources. The function requires a handle to the owner window for the dialog box.
///Params:
///    hwnd = Handle to the owner window for the dialog box.
///    dwType = Resource type to disconnect from. This parameter can have the following value. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCETYPE_DISK"></a><a id="resourcetype_disk"></a><dl>
///             <dt><b>RESOURCETYPE_DISK</b></dt> </dl> </td> <td width="60%"> Disconnects from disk resources. </td> </tr>
///             </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the user cancels the dialog box, the return value is
///    –1. If the function fails, the return value is a system error code, such as one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call the WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient
///    memory to start the dialog box. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetDisconnectDialog(HWND hwnd, uint dwType);

///The <b>WNetConnectionDialog1</b> function brings up a general browsing dialog for connecting to network resources.
///The function requires a CONNECTDLGSTRUCT to establish the dialog box parameters.
///Params:
///    lpConnDlgStruct = Pointer to a <b>CONNECTDLGSTRUCT</b> structure. The structure establishes the browsing dialog parameters.
///Returns:
///    If the user cancels the dialog box, the function returns –1. If the function is successful, it returns
///    NO_ERROR. Also, if the call is successful, the <b>dwDevNum</b> member of the <b>CONNECTDLGSTRUCT</b> structure
///    contains the number of the connected device. Typically this dialog returns an error only if the user cannot enter
///    a dialog session. This is because errors that occur after a dialog session are reported to the user directly. If
///    the function fails, the return value is a system error code, such as one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Both the CONNDLG_RO_PATH and the
///    CONNDLG_USE_MRU dialog box options are set. (Dialog box options are specified by the <b>dwFlags</b> member of the
///    CONNECTDLGSTRUCT structure.) -or- Both the CONNDLG_PERSIST and the CONNDLG_NOT_PERSIST dialog box options are
///    set. -or- The CONNDLG_RO_PATH dialog box option is set and the <b>lpRemoteName</b> member of the NETRESOURCE
///    structure does not point to a remote network. (The <b>CONNECTDLGSTRUCT</b> structure points to a
///    <b>NETRESOURCE</b> structure.) </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl>
///    </td> <td width="60%"> The <b>dwType</b> member of the <b>NETRESOURCE</b> structure is not set to
///    RESOURCETYPE_DISK. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td width="60%">
///    The network provider is busy (possibly initializing). The caller should retry. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient
///    memory to display the dialog box. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt>
///    </dl> </td> <td width="60%"> A network-specific error occurred. Call WNetGetLastError to obtain a description of
///    the error. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetConnectionDialog1A(CONNECTDLGSTRUCTA* lpConnDlgStruct);

///The <b>WNetConnectionDialog1</b> function brings up a general browsing dialog for connecting to network resources.
///The function requires a CONNECTDLGSTRUCT to establish the dialog box parameters.
///Params:
///    lpConnDlgStruct = Pointer to a <b>CONNECTDLGSTRUCT</b> structure. The structure establishes the browsing dialog parameters.
///Returns:
///    If the user cancels the dialog box, the function returns –1. If the function is successful, it returns
///    NO_ERROR. Also, if the call is successful, the <b>dwDevNum</b> member of the <b>CONNECTDLGSTRUCT</b> structure
///    contains the number of the connected device. Typically this dialog returns an error only if the user cannot enter
///    a dialog session. This is because errors that occur after a dialog session are reported to the user directly. If
///    the function fails, the return value is a system error code, such as one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Both the CONNDLG_RO_PATH and the
///    CONNDLG_USE_MRU dialog box options are set. (Dialog box options are specified by the <b>dwFlags</b> member of the
///    CONNECTDLGSTRUCT structure.) -or- Both the CONNDLG_PERSIST and the CONNDLG_NOT_PERSIST dialog box options are
///    set. -or- The CONNDLG_RO_PATH dialog box option is set and the <b>lpRemoteName</b> member of the NETRESOURCE
///    structure does not point to a remote network. (The <b>CONNECTDLGSTRUCT</b> structure points to a
///    <b>NETRESOURCE</b> structure.) </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl>
///    </td> <td width="60%"> The <b>dwType</b> member of the <b>NETRESOURCE</b> structure is not set to
///    RESOURCETYPE_DISK. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td width="60%">
///    The network provider is busy (possibly initializing). The caller should retry. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient
///    memory to display the dialog box. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt>
///    </dl> </td> <td width="60%"> A network-specific error occurred. Call WNetGetLastError to obtain a description of
///    the error. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetConnectionDialog1W(CONNECTDLGSTRUCTW* lpConnDlgStruct);

///The <b>WNetDisconnectDialog1</b> function attempts to disconnect a network resource. If the underlying network
///returns ERROR_OPEN_FILES, the function prompts the user for confirmation. If there is any error, the function informs
///the user. The function requires a DISCDLGSTRUCT to specify the parameters for the disconnect attempt.
///Params:
///    lpConnDlgStruct = Pointer to a <b>DISCDLGSTRUCT</b> structure. The structure specifies the behavior for the disconnect attempt.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the user cancels the dialog box, the return value is
///    –1. If the function fails, the return value is a system error code, such as one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> When the system prompted the user for a decision
///    about disconnecting, the user elected not to disconnect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OPEN_FILES</b></dt> </dl> </td> <td width="60%"> Unable to disconnect because the user is actively
///    using the connection. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td
///    width="60%"> The network provider is busy (possibly initializing). The caller should retry. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is
///    insufficient memory to start the dialog box. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Call the
///    WNetGetLastError function to obtain a description of the error. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetDisconnectDialog1A(DISCDLGSTRUCTA* lpConnDlgStruct);

///The <b>WNetDisconnectDialog1</b> function attempts to disconnect a network resource. If the underlying network
///returns ERROR_OPEN_FILES, the function prompts the user for confirmation. If there is any error, the function informs
///the user. The function requires a DISCDLGSTRUCT to specify the parameters for the disconnect attempt.
///Params:
///    lpConnDlgStruct = Pointer to a <b>DISCDLGSTRUCT</b> structure. The structure specifies the behavior for the disconnect attempt.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the user cancels the dialog box, the return value is
///    –1. If the function fails, the return value is a system error code, such as one of the following values.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> When the system prompted the user for a decision
///    about disconnecting, the user elected not to disconnect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OPEN_FILES</b></dt> </dl> </td> <td width="60%"> Unable to disconnect because the user is actively
///    using the connection. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUSY</b></dt> </dl> </td> <td
///    width="60%"> The network provider is busy (possibly initializing). The caller should retry. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is
///    insufficient memory to start the dialog box. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Call the
///    WNetGetLastError function to obtain a description of the error. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetDisconnectDialog1W(DISCDLGSTRUCTW* lpConnDlgStruct);

///The <b>WNetOpenEnum</b> function starts an enumeration of network resources or existing connections. You can continue
///the enumeration by calling the WNetEnumResource function.
///Params:
///    dwScope = Scope of the enumeration. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCE_CONNECTED"></a><a id="resource_connected"></a><dl>
///              <dt><b>RESOURCE_CONNECTED</b></dt> </dl> </td> <td width="60%"> Enumerate all currently connected resources. The
///              function ignores the <i>dwUsage</i> parameter. For more information, see the following Remarks section. </td>
///              </tr> <tr> <td width="40%"><a id="RESOURCE_CONTEXT"></a><a id="resource_context"></a><dl>
///              <dt><b>RESOURCE_CONTEXT</b></dt> </dl> </td> <td width="60%"> Enumerate only resources in the network context of
///              the caller. Specify this value for a Network Neighborhood view. The function ignores the <i>dwUsage</i>
///              parameter. </td> </tr> <tr> <td width="40%"><a id="RESOURCE_GLOBALNET"></a><a id="resource_globalnet"></a><dl>
///              <dt><b>RESOURCE_GLOBALNET</b></dt> </dl> </td> <td width="60%"> Enumerate all resources on the network. </td>
///              </tr> <tr> <td width="40%"><a id="RESOURCE_REMEMBERED"></a><a id="resource_remembered"></a><dl>
///              <dt><b>RESOURCE_REMEMBERED</b></dt> </dl> </td> <td width="60%"> Enumerate all remembered (persistent)
///              connections. The function ignores the <i>dwUsage</i> parameter. </td> </tr> </table>
///    dwType = Resource types to be enumerated. This parameter can be a combination of the following values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCETYPE_ANY"></a><a
///             id="resourcetype_any"></a><dl> <dt><b>RESOURCETYPE_ANY</b></dt> </dl> </td> <td width="60%"> All resources. This
///             value cannot be combined with RESOURCETYPE_DISK or RESOURCETYPE_PRINT. </td> </tr> <tr> <td width="40%"><a
///             id="RESOURCETYPE_DISK"></a><a id="resourcetype_disk"></a><dl> <dt><b>RESOURCETYPE_DISK</b></dt> </dl> </td> <td
///             width="60%"> All disk resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCETYPE_PRINT"></a><a
///             id="resourcetype_print"></a><dl> <dt><b>RESOURCETYPE_PRINT</b></dt> </dl> </td> <td width="60%"> All print
///             resources. </td> </tr> </table> If a network provider cannot distinguish between print and disk resources, it can
///             enumerate all resources.
///    dwUsage = Resource usage type to be enumerated. This parameter can be a combination of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///              width="60%"> All resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCEUSAGE_CONNECTABLE"></a><a
///              id="resourceusage_connectable"></a><dl> <dt><b>RESOURCEUSAGE_CONNECTABLE</b></dt> </dl> </td> <td width="60%">
///              All connectable resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCEUSAGE_CONTAINER"></a><a
///              id="resourceusage_container"></a><dl> <dt><b>RESOURCEUSAGE_CONTAINER</b></dt> </dl> </td> <td width="60%"> All
///              container resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCEUSAGE_ATTACHED"></a><a
///              id="resourceusage_attached"></a><dl> <dt><b>RESOURCEUSAGE_ATTACHED</b></dt> </dl> </td> <td width="60%"> Setting
///              this value forces <b>WNetOpenEnum</b> to fail if the user is not authenticated. The function fails even if the
///              network allows enumeration without authentication. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCEUSAGE_ALL"></a><a id="resourceusage_all"></a><dl> <dt><b>RESOURCEUSAGE_ALL</b></dt> </dl> </td> <td
///              width="60%"> Setting this value is equivalent to setting RESOURCEUSAGE_CONNECTABLE, RESOURCEUSAGE_CONTAINER, and
///              RESOURCEUSAGE_ATTACHED. </td> </tr> </table> This parameter is ignored unless the <i>dwScope</i> parameter is
///              equal to RESOURCE_GLOBALNET. For more information, see the following Remarks section.
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies the container to enumerate. If the <i>dwScope</i> parameter is
///                    not RESOURCE_GLOBALNET, this parameter must be <b>NULL</b>. If this parameter is <b>NULL</b>, the root of the
///                    network is assumed. (The system organizes a network as a hierarchy; the root is the topmost container in the
///                    network.) If this parameter is not <b>NULL</b>, it must point to a <b>NETRESOURCE</b> structure. This structure
///                    can be filled in by the application or it can be returned by a call to the WNetEnumResource function. The
///                    <b>NETRESOURCE</b> structure must specify a container resource; that is, the RESOURCEUSAGE_CONTAINER value must
///                    be specified in the <i>dwUsage</i> parameter. To enumerate all network resources, an application can begin the
///                    enumeration by calling <b>WNetOpenEnum</b> with the <i>lpNetResource</i> parameter set to <b>NULL</b>, and then
///                    use the returned handle to call <b>WNetEnumResource</b> to enumerate resources. If one of the resources in the
///                    <b>NETRESOURCE</b> array returned by the <b>WNetEnumResource</b> function is a container resource, you can call
///                    <b>WNetOpenEnum</b> to open the resource for further enumeration.
///    lphEnum = Pointer to an enumeration handle that can be used in a subsequent call to WNetEnumResource.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_CONTAINER</b></dt> </dl> </td> <td width="60%"> The <i>lpNetResource</i>
///    parameter does not point to a container. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Either the <i>dwScope</i> or the
///    <i>dwType</i> parameter is invalid, or there is an invalid combination of parameters. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A
///    network-specific error occurred. To obtain a description of the error, call the WNetGetLastError function. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td width="60%"> A remote
///    network resource name supplied in the <b>NETRESOURCE</b> structure resolved to an invalid network address. </td>
///    </tr> </table>
///    
@DllImport("MPR")
uint WNetOpenEnumA(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEA* lpNetResource, NetEnumHandle* lphEnum);

///The <b>WNetOpenEnum</b> function starts an enumeration of network resources or existing connections. You can continue
///the enumeration by calling the WNetEnumResource function.
///Params:
///    dwScope = Scope of the enumeration. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCE_CONNECTED"></a><a id="resource_connected"></a><dl>
///              <dt><b>RESOURCE_CONNECTED</b></dt> </dl> </td> <td width="60%"> Enumerate all currently connected resources. The
///              function ignores the <i>dwUsage</i> parameter. For more information, see the following Remarks section. </td>
///              </tr> <tr> <td width="40%"><a id="RESOURCE_CONTEXT"></a><a id="resource_context"></a><dl>
///              <dt><b>RESOURCE_CONTEXT</b></dt> </dl> </td> <td width="60%"> Enumerate only resources in the network context of
///              the caller. Specify this value for a Network Neighborhood view. The function ignores the <i>dwUsage</i>
///              parameter. </td> </tr> <tr> <td width="40%"><a id="RESOURCE_GLOBALNET"></a><a id="resource_globalnet"></a><dl>
///              <dt><b>RESOURCE_GLOBALNET</b></dt> </dl> </td> <td width="60%"> Enumerate all resources on the network. </td>
///              </tr> <tr> <td width="40%"><a id="RESOURCE_REMEMBERED"></a><a id="resource_remembered"></a><dl>
///              <dt><b>RESOURCE_REMEMBERED</b></dt> </dl> </td> <td width="60%"> Enumerate all remembered (persistent)
///              connections. The function ignores the <i>dwUsage</i> parameter. </td> </tr> </table>
///    dwType = Resource types to be enumerated. This parameter can be a combination of the following values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RESOURCETYPE_ANY"></a><a
///             id="resourcetype_any"></a><dl> <dt><b>RESOURCETYPE_ANY</b></dt> </dl> </td> <td width="60%"> All resources. This
///             value cannot be combined with RESOURCETYPE_DISK or RESOURCETYPE_PRINT. </td> </tr> <tr> <td width="40%"><a
///             id="RESOURCETYPE_DISK"></a><a id="resourcetype_disk"></a><dl> <dt><b>RESOURCETYPE_DISK</b></dt> </dl> </td> <td
///             width="60%"> All disk resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCETYPE_PRINT"></a><a
///             id="resourcetype_print"></a><dl> <dt><b>RESOURCETYPE_PRINT</b></dt> </dl> </td> <td width="60%"> All print
///             resources. </td> </tr> </table> If a network provider cannot distinguish between print and disk resources, it can
///             enumerate all resources.
///    dwUsage = Resource usage type to be enumerated. This parameter can be a combination of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///              width="60%"> All resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCEUSAGE_CONNECTABLE"></a><a
///              id="resourceusage_connectable"></a><dl> <dt><b>RESOURCEUSAGE_CONNECTABLE</b></dt> </dl> </td> <td width="60%">
///              All connectable resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCEUSAGE_CONTAINER"></a><a
///              id="resourceusage_container"></a><dl> <dt><b>RESOURCEUSAGE_CONTAINER</b></dt> </dl> </td> <td width="60%"> All
///              container resources. </td> </tr> <tr> <td width="40%"><a id="RESOURCEUSAGE_ATTACHED"></a><a
///              id="resourceusage_attached"></a><dl> <dt><b>RESOURCEUSAGE_ATTACHED</b></dt> </dl> </td> <td width="60%"> Setting
///              this value forces <b>WNetOpenEnum</b> to fail if the user is not authenticated. The function fails even if the
///              network allows enumeration without authentication. </td> </tr> <tr> <td width="40%"><a
///              id="RESOURCEUSAGE_ALL"></a><a id="resourceusage_all"></a><dl> <dt><b>RESOURCEUSAGE_ALL</b></dt> </dl> </td> <td
///              width="60%"> Setting this value is equivalent to setting RESOURCEUSAGE_CONNECTABLE, RESOURCEUSAGE_CONTAINER, and
///              RESOURCEUSAGE_ATTACHED. </td> </tr> </table> This parameter is ignored unless the <i>dwScope</i> parameter is
///              equal to RESOURCE_GLOBALNET. For more information, see the following Remarks section.
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies the container to enumerate. If the <i>dwScope</i> parameter is
///                    not RESOURCE_GLOBALNET, this parameter must be <b>NULL</b>. If this parameter is <b>NULL</b>, the root of the
///                    network is assumed. (The system organizes a network as a hierarchy; the root is the topmost container in the
///                    network.) If this parameter is not <b>NULL</b>, it must point to a <b>NETRESOURCE</b> structure. This structure
///                    can be filled in by the application or it can be returned by a call to the WNetEnumResource function. The
///                    <b>NETRESOURCE</b> structure must specify a container resource; that is, the RESOURCEUSAGE_CONTAINER value must
///                    be specified in the <i>dwUsage</i> parameter. To enumerate all network resources, an application can begin the
///                    enumeration by calling <b>WNetOpenEnum</b> with the <i>lpNetResource</i> parameter set to <b>NULL</b>, and then
///                    use the returned handle to call <b>WNetEnumResource</b> to enumerate resources. If one of the resources in the
///                    <b>NETRESOURCE</b> array returned by the <b>WNetEnumResource</b> function is a container resource, you can call
///                    <b>WNetOpenEnum</b> to open the resource for further enumeration.
///    lphEnum = Pointer to an enumeration handle that can be used in a subsequent call to WNetEnumResource.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_CONTAINER</b></dt> </dl> </td> <td width="60%"> The <i>lpNetResource</i>
///    parameter does not point to a container. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Either the <i>dwScope</i> or the
///    <i>dwType</i> parameter is invalid, or there is an invalid combination of parameters. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A
///    network-specific error occurred. To obtain a description of the error, call the WNetGetLastError function. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td width="60%"> A remote
///    network resource name supplied in the <b>NETRESOURCE</b> structure resolved to an invalid network address. </td>
///    </tr> </table>
///    
@DllImport("MPR")
uint WNetOpenEnumW(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, NetEnumHandle* lphEnum);

///The <b>WNetEnumResource</b> function continues an enumeration of network resources that was started by a call to the
///WNetOpenEnum function.
///Params:
///    hEnum = Handle that identifies an enumeration instance. This handle must be returned by the WNetOpenEnum function.
///    lpcCount = Pointer to a variable specifying the number of entries requested. If the number requested is –1, the function
///               returns as many entries as possible. If the function succeeds, on return the variable pointed to by this
///               parameter contains the number of entries actually read.
///    lpBuffer = Pointer to the buffer that receives the enumeration results. The results are returned as an array of NETRESOURCE
///               structures. Note that the buffer you allocate must be large enough to hold the structures, plus the strings to
///               which their members point. For more information, see the following Remarks section. The buffer is valid until the
///               next call using the handle specified by the <i>hEnum</i> parameter. The order of <b>NETRESOURCE</b> structures in
///               the array is not predictable.
///    lpBufferSize = Pointer to a variable that specifies the size of the <i>lpBuffer</i> parameter, in bytes. If the buffer is too
///                   small to receive even one entry, this parameter receives the required size of the buffer.
///Returns:
///    If the function succeeds, the return value is one of the following values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl> </td> <td width="60%"> The
///    enumeration succeeded, and the buffer contains the requested data. The calling application can continue to call
///    <b>WNetEnumResource</b> to complete the enumeration. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more entries. The buffer contents
///    are undefined. </td> </tr> </table> If the function fails, the return value is a system error code, such as one
///    of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available with subsequent calls.
///    For more information, see the following Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified by the <i>hEnum</i>
///    parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. (This condition is tested before <i>hEnum</i> is tested for validity.)
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A
///    network-specific error occurred. To obtain a description of the error, call the WNetGetLastError function. </td>
///    </tr> </table>
///    
@DllImport("MPR")
uint WNetEnumResourceA(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

///The <b>WNetEnumResource</b> function continues an enumeration of network resources that was started by a call to the
///WNetOpenEnum function.
///Params:
///    hEnum = Handle that identifies an enumeration instance. This handle must be returned by the WNetOpenEnum function.
///    lpcCount = Pointer to a variable specifying the number of entries requested. If the number requested is –1, the function
///               returns as many entries as possible. If the function succeeds, on return the variable pointed to by this
///               parameter contains the number of entries actually read.
///    lpBuffer = Pointer to the buffer that receives the enumeration results. The results are returned as an array of NETRESOURCE
///               structures. Note that the buffer you allocate must be large enough to hold the structures, plus the strings to
///               which their members point. For more information, see the following Remarks section. The buffer is valid until the
///               next call using the handle specified by the <i>hEnum</i> parameter. The order of <b>NETRESOURCE</b> structures in
///               the array is not predictable.
///    lpBufferSize = Pointer to a variable that specifies the size of the <i>lpBuffer</i> parameter, in bytes. If the buffer is too
///                   small to receive even one entry, this parameter receives the required size of the buffer.
///Returns:
///    If the function succeeds, the return value is one of the following values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl> </td> <td width="60%"> The
///    enumeration succeeded, and the buffer contains the requested data. The calling application can continue to call
///    <b>WNetEnumResource</b> to complete the enumeration. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more entries. The buffer contents
///    are undefined. </td> </tr> </table> If the function fails, the return value is a system error code, such as one
///    of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available with subsequent calls.
///    For more information, see the following Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle specified by the <i>hEnum</i>
///    parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. (This condition is tested before <i>hEnum</i> is tested for validity.)
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A
///    network-specific error occurred. To obtain a description of the error, call the WNetGetLastError function. </td>
///    </tr> </table>
///    
@DllImport("MPR")
uint WNetEnumResourceW(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

///The <b>WNetCloseEnum</b> function ends a network resource enumeration started by a call to the WNetOpenEnum function.
///Params:
///    hEnum = Handle that identifies an enumeration instance. This handle must be returned by the <b>WNetOpenEnum</b> function.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. (This
///    condition is tested before the handle specified in the <i>hEnum</i> parameter is tested for validity.) </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hEnum</i> parameter does not specifiy a valid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call the WNetGetLastError function. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetCloseEnum(HANDLE hEnum);

///The <b>WNetGetResourceParent</b> function returns the parent of a network resource in the network browse hierarchy.
///Browsing begins at the location of the specified network resource. Call the WNetGetResourceInformation and
///<b>WNetGetResourceParent</b> functions to move up the network hierarchy. Call the WNetOpenEnum function to move down
///the hierarchy.
///Params:
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies the network resource for which the parent name is required.
///                    Specify the members of the input <b>NETRESOURCE</b> structure as follows. The caller typically knows the values
///                    to provide for the <b>lpProvider</b> and <b>dwType</b> members after previous calls to
///                    <b>WNetGetResourceInformation</b> or <b>WNetGetResourceParent</b>. <table> <tr> <th>Member</th> <th>Meaning</th>
///                    </tr> <tr> <td width="40%"><a id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl>
///                    <dt><b><b>dwType</b></b></dt> </dl> </td> <td width="60%"> This member should be filled in if known; otherwise,
///                    it should be set to <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="lpRemoteName"></a><a
///                    id="lpremotename"></a><a id="LPREMOTENAME"></a><dl> <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td
///                    width="60%"> This member should specify the remote name of the network resource whose parent is required. </td>
///                    </tr> <tr> <td width="40%"><a id="lpProvider"></a><a id="lpprovider"></a><a id="LPPROVIDER"></a><dl>
///                    <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> This member should specify the network provider
///                    that owns the resource. This member is required; otherwise, the function could produce incorrect results. </td>
///                    </tr> </table> All other members of the <b>NETRESOURCE</b> structure are ignored.
///    lpBuffer = Pointer to a buffer to receive a single <b>NETRESOURCE</b> structure that represents the parent resource. The
///               function returns the <b>lpRemoteName</b>, <b>lpProvider</b>, <b>dwType</b>, <b>dwDisplayType</b>, and
///               <b>dwUsage</b> members of the structure; all other members are set to <b>NULL</b>. The <b>lpRemoteName</b> member
///               points to the remote name for the parent resource. This name uses the same syntax as the one returned from an
///               enumeration by the WNetEnumResource function. The caller can perform a string comparison to determine whether the
///               <b>WNetGetResourceParent</b> resource is the same as that returned by <b>WNetEnumResource</b>. If the input
///               resource has no parent on any of the networks, the <b>lpRemoteName</b> member is returned as <b>NULL</b>. The
///               presence of the RESOURCEUSAGE_CONNECTABLE bit in the <b>dwUsage</b> member indicates that you can connect to the
///               parent resource, but only when it is available on the network.
///    lpcbBuffer = Pointer to a location that, on entry, specifies the size of the <i>lpBuffer</i> buffer, in bytes. If the buffer
///                 is too small to hold the result, this location receives the required buffer size, and the function returns
///                 ERROR_MORE_DATA.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl>
///    </td> <td width="60%"> The input <b>lpRemoteName</b> member is not an existing network resource for any network.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl> </td> <td width="60%"> The input
///    <b>lpProvider</b> member does not match any installed network provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the <i>lpBuffer</i>
///    parameter is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_AUTHENTICATED</b></dt> </dl>
///    </td> <td width="60%"> The caller does not have the necessary permissions to obtain the name of the parent. </td>
///    </tr> </table>
///    
@DllImport("MPR")
uint WNetGetResourceParentA(NETRESOURCEA* lpNetResource, char* lpBuffer, uint* lpcbBuffer);

///The <b>WNetGetResourceParent</b> function returns the parent of a network resource in the network browse hierarchy.
///Browsing begins at the location of the specified network resource. Call the WNetGetResourceInformation and
///<b>WNetGetResourceParent</b> functions to move up the network hierarchy. Call the WNetOpenEnum function to move down
///the hierarchy.
///Params:
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies the network resource for which the parent name is required.
///                    Specify the members of the input <b>NETRESOURCE</b> structure as follows. The caller typically knows the values
///                    to provide for the <b>lpProvider</b> and <b>dwType</b> members after previous calls to
///                    <b>WNetGetResourceInformation</b> or <b>WNetGetResourceParent</b>. <table> <tr> <th>Member</th> <th>Meaning</th>
///                    </tr> <tr> <td width="40%"><a id="dwType"></a><a id="dwtype"></a><a id="DWTYPE"></a><dl>
///                    <dt><b><b>dwType</b></b></dt> </dl> </td> <td width="60%"> This member should be filled in if known; otherwise,
///                    it should be set to <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="lpRemoteName"></a><a
///                    id="lpremotename"></a><a id="LPREMOTENAME"></a><dl> <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td
///                    width="60%"> This member should specify the remote name of the network resource whose parent is required. </td>
///                    </tr> <tr> <td width="40%"><a id="lpProvider"></a><a id="lpprovider"></a><a id="LPPROVIDER"></a><dl>
///                    <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> This member should specify the network provider
///                    that owns the resource. This member is required; otherwise, the function could produce incorrect results. </td>
///                    </tr> </table> All other members of the <b>NETRESOURCE</b> structure are ignored.
///    lpBuffer = Pointer to a buffer to receive a single <b>NETRESOURCE</b> structure that represents the parent resource. The
///               function returns the <b>lpRemoteName</b>, <b>lpProvider</b>, <b>dwType</b>, <b>dwDisplayType</b>, and
///               <b>dwUsage</b> members of the structure; all other members are set to <b>NULL</b>. The <b>lpRemoteName</b> member
///               points to the remote name for the parent resource. This name uses the same syntax as the one returned from an
///               enumeration by the WNetEnumResource function. The caller can perform a string comparison to determine whether the
///               <b>WNetGetResourceParent</b> resource is the same as that returned by <b>WNetEnumResource</b>. If the input
///               resource has no parent on any of the networks, the <b>lpRemoteName</b> member is returned as <b>NULL</b>. The
///               presence of the RESOURCEUSAGE_CONNECTABLE bit in the <b>dwUsage</b> member indicates that you can connect to the
///               parent resource, but only when it is available on the network.
///    lpcbBuffer = Pointer to a location that, on entry, specifies the size of the <i>lpBuffer</i> buffer, in bytes. If the buffer
///                 is too small to hold the result, this location receives the required buffer size, and the function returns
///                 ERROR_MORE_DATA.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access to the network resource. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl>
///    </td> <td width="60%"> The input <b>lpRemoteName</b> member is not an existing network resource for any network.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl> </td> <td width="60%"> The input
///    <b>lpProvider</b> member does not match any installed network provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the <i>lpBuffer</i>
///    parameter is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_AUTHENTICATED</b></dt> </dl>
///    </td> <td width="60%"> The caller does not have the necessary permissions to obtain the name of the parent. </td>
///    </tr> </table>
///    
@DllImport("MPR")
uint WNetGetResourceParentW(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpcbBuffer);

///When provided with a remote path to a network resource, the <b>WNetGetResourceInformation</b> function identifies the
///network provider that owns the resource and obtains information about the type of the resource. The function is
///typically used in conjunction with the WNetGetResourceParent function to parse and interpret a network path typed in
///by a user.
///Params:
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies the network resource for which information is required. The
///                    <b>lpRemoteName</b> member of the structure should specify the remote path name of the resource, typically one
///                    typed in by a user. The <b>lpProvider</b> and <b>dwType</b> members should also be filled in if known, because
///                    this operation can be memory intensive, especially if you do not specify the <b>dwType</b> member. If you do not
///                    know the values for these members, you should set them to <b>NULL</b>. All other members of the
///                    <b>NETRESOURCE</b> structure are ignored.
///    lpBuffer = Pointer to the buffer to receive the result. On successful return, the first portion of the buffer is a
///               NETRESOURCE structure representing that portion of the input resource path that is accessed through the WNet
///               functions, rather than through system functions specific to the input resource type. (The remainder of the buffer
///               contains the variable-length strings to which the members of the <b>NETRESOURCE</b> structure point.) For
///               example, if the input remote resource path is \\server\share\dir1\dir2, then the output <b>NETRESOURCE</b>
///               structure contains information about the resource \\server\share. The \dir1\dir2 portion of the path is accessed
///               through the file management functions. The <b>lpRemoteName</b>, <b>lpProvider</b>, <b>dwType</b>,
///               <b>dwDisplayType</b>, and <b>dwUsage</b> members of <b>NETRESOURCE</b> are returned, with all other members set
///               to <b>NULL</b>. The <b>lpRemoteName</b> member is returned in the same syntax as the one returned from an
///               enumeration by the WNetEnumResource function. This allows the caller to perform a string comparison to determine
///               whether the resource passed to <b>WNetGetResourceInformation</b> is the same as the resource returned by a
///               separate call to <b>WNetEnumResource</b>.
///    lpcbBuffer = Pointer to a location that, on entry, specifies the size of the <i>lpBuffer</i> buffer, in bytes. The buffer you
///                 allocate must be large enough to hold the <b>NETRESOURCE</b> structure, plus the strings to which its members
///                 point. If the buffer is too small for the result, this location receives the required buffer size, and the
///                 function returns ERROR_MORE_DATA.
///    lplpSystem = If the function returns successfully, this parameter points to a string in the output buffer that specifies the
///                 part of the resource that is accessed through system functions. (This applies only to functions specific to the
///                 resource type rather than the WNet functions.) For example, if the input remote resource name is
///                 \\server\share\dir1\dir2, the <b>lpRemoteName</b> member of the output NETRESOURCE structure points to
///                 \\server\share. Also, the <i>lplpSystem</i> parameter points to \dir1\dir2. Both strings are stored in the buffer
///                 pointed to by the <i>lpBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The input <b>lpRemoteName</b>
///    member is not an existing network resource for any network. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td width="60%"> The input <b>dwType</b> member does not match the
///    type of resource specified by the <b>lpRemoteName</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Call
///    WNetGetLastError to obtain a description of the error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the <i>lpBuffer</i>
///    parameter is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetResourceInformationA(NETRESOURCEA* lpNetResource, char* lpBuffer, uint* lpcbBuffer, byte** lplpSystem);

///When provided with a remote path to a network resource, the <b>WNetGetResourceInformation</b> function identifies the
///network provider that owns the resource and obtains information about the type of the resource. The function is
///typically used in conjunction with the WNetGetResourceParent function to parse and interpret a network path typed in
///by a user.
///Params:
///    lpNetResource = Pointer to a NETRESOURCE structure that specifies the network resource for which information is required. The
///                    <b>lpRemoteName</b> member of the structure should specify the remote path name of the resource, typically one
///                    typed in by a user. The <b>lpProvider</b> and <b>dwType</b> members should also be filled in if known, because
///                    this operation can be memory intensive, especially if you do not specify the <b>dwType</b> member. If you do not
///                    know the values for these members, you should set them to <b>NULL</b>. All other members of the
///                    <b>NETRESOURCE</b> structure are ignored.
///    lpBuffer = Pointer to the buffer to receive the result. On successful return, the first portion of the buffer is a
///               NETRESOURCE structure representing that portion of the input resource path that is accessed through the WNet
///               functions, rather than through system functions specific to the input resource type. (The remainder of the buffer
///               contains the variable-length strings to which the members of the <b>NETRESOURCE</b> structure point.) For
///               example, if the input remote resource path is \\server\share\dir1\dir2, then the output <b>NETRESOURCE</b>
///               structure contains information about the resource \\server\share. The \dir1\dir2 portion of the path is accessed
///               through the file management functions. The <b>lpRemoteName</b>, <b>lpProvider</b>, <b>dwType</b>,
///               <b>dwDisplayType</b>, and <b>dwUsage</b> members of <b>NETRESOURCE</b> are returned, with all other members set
///               to <b>NULL</b>. The <b>lpRemoteName</b> member is returned in the same syntax as the one returned from an
///               enumeration by the WNetEnumResource function. This allows the caller to perform a string comparison to determine
///               whether the resource passed to <b>WNetGetResourceInformation</b> is the same as the resource returned by a
///               separate call to <b>WNetEnumResource</b>.
///    lpcbBuffer = Pointer to a location that, on entry, specifies the size of the <i>lpBuffer</i> buffer, in bytes. The buffer you
///                 allocate must be large enough to hold the <b>NETRESOURCE</b> structure, plus the strings to which its members
///                 point. If the buffer is too small for the result, this location receives the required buffer size, and the
///                 function returns ERROR_MORE_DATA.
///    lplpSystem = If the function returns successfully, this parameter points to a string in the output buffer that specifies the
///                 part of the resource that is accessed through system functions. (This applies only to functions specific to the
///                 resource type rather than the WNet functions.) For example, if the input remote resource name is
///                 \\server\share\dir1\dir2, the <b>lpRemoteName</b> member of the output NETRESOURCE structure points to
///                 \\server\share. Also, the <i>lplpSystem</i> parameter points to \dir1\dir2. Both strings are stored in the buffer
///                 pointed to by the <i>lpBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The input <b>lpRemoteName</b>
///    member is not an existing network resource for any network. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_DEV_TYPE</b></dt> </dl> </td> <td width="60%"> The input <b>dwType</b> member does not match the
///    type of resource specified by the <b>lpRemoteName</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Call
///    WNetGetLastError to obtain a description of the error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the <i>lpBuffer</i>
///    parameter is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetResourceInformationW(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpcbBuffer, 
                                 ushort** lplpSystem);

///The <b>WNetGetUniversalName</b> function takes a drive-based path for a network resource and returns an information
///structure that contains a more universal form of the name.
///Params:
///    lpLocalPath = A pointer to a constant null-terminated string that is a drive-based path for a network resource. For example, if
///                  drive H has been mapped to a network drive share, and the network resource of interest is a file named Sample.doc
///                  in the directory \Win32\Examples on that share, the drive-based path is H:\Win32\Examples\Sample.doc.
///    dwInfoLevel = The type of structure that the function stores in the buffer pointed to by the <i>lpBuffer</i> parameter. This
///                  parameter can be one of the following values defined in the <i>Winnetwk.h</i> header file. <table> <tr>
///                  <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UNIVERSAL_NAME_INFO_LEVEL"></a><a
///                  id="universal_name_info_level"></a><dl> <dt><b>UNIVERSAL_NAME_INFO_LEVEL</b></dt> </dl> </td> <td width="60%">
///                  The function stores a UNIVERSAL_NAME_INFO structure in the buffer. </td> </tr> <tr> <td width="40%"><a
///                  id="REMOTE_NAME_INFO_LEVEL"></a><a id="remote_name_info_level"></a><dl> <dt><b>REMOTE_NAME_INFO_LEVEL</b></dt>
///                  </dl> </td> <td width="60%"> The function stores a REMOTE_NAME_INFO structure in the buffer. </td> </tr> </table>
///                  The UNIVERSAL_NAME_INFO structure points to a Universal Naming Convention (UNC) name string. The REMOTE_NAME_INFO
///                  structure points to a UNC name string and two additional connection information strings. For more information,
///                  see the following Remarks section.
///    lpBuffer = A pointer to a buffer that receives the structure specified by the <i>dwInfoLevel</i> parameter.
///    lpBufferSize = A pointer to a variable that specifies the size, in bytes, of the buffer pointed to by the <i>lpBuffer</i>
///                   parameter. If the function succeeds, it sets the variable pointed to by <i>lpBufferSize</i> to the number of
///                   bytes stored in the buffer. If the function fails because the buffer is too small, this location receives the
///                   required buffer size, and the function returns ERROR_MORE_DATA.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The string pointed to by the
///    <i>lpLocalPath</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CONNECTION_UNAVAIL</b></dt> </dl> </td> <td width="60%"> There is no current connection to the
///    remote device, but there is a remembered (persistent) connection to it. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Use the
///    WNetGetLastError function to obtain a description of the error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the <i>lpBuffer</i>
///    parameter is too small. The function sets the variable pointed to by the <i>lpBufferSize</i> parameter to the
///    required buffer size. More entries are available with subsequent calls. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwInfoLevel</i> parameter is set to
///    UNIVERSAL_NAME_INFO_LEVEL, but the network provider does not support UNC names. (None of the network providers
///    support this function.) </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl>
///    </td> <td width="60%"> None of the network providers recognize the local name as having a connection. However,
///    the network is not available for at least one provider to whom the connection may belong. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The device
///    specified by the <i>lpLocalPath</i> parameter is not redirected. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetUniversalNameA(const(char)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

///The <b>WNetGetUniversalName</b> function takes a drive-based path for a network resource and returns an information
///structure that contains a more universal form of the name.
///Params:
///    lpLocalPath = A pointer to a constant null-terminated string that is a drive-based path for a network resource. For example, if
///                  drive H has been mapped to a network drive share, and the network resource of interest is a file named Sample.doc
///                  in the directory \Win32\Examples on that share, the drive-based path is H:\Win32\Examples\Sample.doc.
///    dwInfoLevel = The type of structure that the function stores in the buffer pointed to by the <i>lpBuffer</i> parameter. This
///                  parameter can be one of the following values defined in the <i>Winnetwk.h</i> header file. <table> <tr>
///                  <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UNIVERSAL_NAME_INFO_LEVEL"></a><a
///                  id="universal_name_info_level"></a><dl> <dt><b>UNIVERSAL_NAME_INFO_LEVEL</b></dt> </dl> </td> <td width="60%">
///                  The function stores a UNIVERSAL_NAME_INFO structure in the buffer. </td> </tr> <tr> <td width="40%"><a
///                  id="REMOTE_NAME_INFO_LEVEL"></a><a id="remote_name_info_level"></a><dl> <dt><b>REMOTE_NAME_INFO_LEVEL</b></dt>
///                  </dl> </td> <td width="60%"> The function stores a REMOTE_NAME_INFO structure in the buffer. </td> </tr> </table>
///                  The UNIVERSAL_NAME_INFO structure points to a Universal Naming Convention (UNC) name string. The REMOTE_NAME_INFO
///                  structure points to a UNC name string and two additional connection information strings. For more information,
///                  see the following Remarks section.
///    lpBuffer = A pointer to a buffer that receives the structure specified by the <i>dwInfoLevel</i> parameter.
///    lpBufferSize = A pointer to a variable that specifies the size, in bytes, of the buffer pointed to by the <i>lpBuffer</i>
///                   parameter. If the function succeeds, it sets the variable pointed to by <i>lpBufferSize</i> to the number of
///                   bytes stored in the buffer. If the function fails because the buffer is too small, this location receives the
///                   required buffer size, and the function returns ERROR_MORE_DATA.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The string pointed to by the
///    <i>lpLocalPath</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CONNECTION_UNAVAIL</b></dt> </dl> </td> <td width="60%"> There is no current connection to the
///    remote device, but there is a remembered (persistent) connection to it. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. Use the
///    WNetGetLastError function to obtain a description of the error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the <i>lpBuffer</i>
///    parameter is too small. The function sets the variable pointed to by the <i>lpBufferSize</i> parameter to the
///    required buffer size. More entries are available with subsequent calls. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <i>dwInfoLevel</i> parameter is set to
///    UNIVERSAL_NAME_INFO_LEVEL, but the network provider does not support UNC names. (None of the network providers
///    support this function.) </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl>
///    </td> <td width="60%"> None of the network providers recognize the local name as having a connection. However,
///    the network is not available for at least one provider to whom the connection may belong. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The network is unavailable. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The device
///    specified by the <i>lpLocalPath</i> parameter is not redirected. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetUniversalNameW(const(wchar)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

///The <b>WNetGetUser</b> function retrieves the current default user name, or the user name used to establish a network
///connection.
///Params:
///    lpName = A pointer to a constant <b>null</b>-terminated string that specifies either the name of a local device that has
///             been redirected to a network resource, or the remote name of a network resource to which a connection has been
///             made without redirecting a local device. If this parameter is <b>NULL</b> or the empty string, the system returns
///             the name of the current user for the process.
///    lpUserName = A pointer to a buffer that receives the <b>null</b>-terminated user name.
///    lpnLength = A pointer to a variable that specifies the size of the <i>lpUserName</i> buffer, in characters. If the call fails
///                because the buffer is not large enough, this variable contains the required buffer size.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The device specified by the
///    <i>lpName</i> parameter is not a redirected device or a connected network name. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available with subsequent
///    calls. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The
///    network is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td>
///    <td width="60%"> A network-specific error occurred. To obtain a description of the error, call the
///    WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl>
///    </td> <td width="60%"> None of the providers recognize the local name as having a connection. However, the
///    network is not available for at least one provider to whom the connection may belong. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetUserA(const(char)* lpName, const(char)* lpUserName, uint* lpnLength);

///The <b>WNetGetUser</b> function retrieves the current default user name, or the user name used to establish a network
///connection.
///Params:
///    lpName = A pointer to a constant <b>null</b>-terminated string that specifies either the name of a local device that has
///             been redirected to a network resource, or the remote name of a network resource to which a connection has been
///             made without redirecting a local device. If this parameter is <b>NULL</b> or the empty string, the system returns
///             the name of the current user for the process.
///    lpUserName = A pointer to a buffer that receives the <b>null</b>-terminated user name.
///    lpnLength = A pointer to a variable that specifies the size of the <i>lpUserName</i> buffer, in characters. If the call fails
///                because the buffer is not large enough, this variable contains the required buffer size.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The device specified by the
///    <i>lpName</i> parameter is not a redirected device or a connected network name. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available with subsequent
///    calls. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td width="60%"> The
///    network is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td>
///    <td width="60%"> A network-specific error occurred. To obtain a description of the error, call the
///    WNetGetLastError function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl>
///    </td> <td width="60%"> None of the providers recognize the local name as having a connection. However, the
///    network is not available for at least one provider to whom the connection may belong. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetUserW(const(wchar)* lpName, const(wchar)* lpUserName, uint* lpnLength);

///The <b>WNetGetProviderName</b> function obtains the provider name for a specific type of network.
///Params:
///    dwNetType = Network type that is unique to the network. If two networks claim the same type, the function returns the name of
///                the provider loaded first. Only the high word of the network type is used. If a network reports a subtype in the
///                low word, it is ignored. You can find a complete list of network types in the header file Winnetwk.h.
///    lpProviderName = Pointer to a buffer that receives the network provider name.
///    lpBufferSize = Size of the buffer passed to the function, in characters. If the return value is ERROR_MORE_DATA,
///                   <i>lpBufferSize</i> returns the buffer size required (in characters) to hold the provider name. <b>Windows
///                   Me/98/95: </b>The size of the buffer is in bytes, not characters. Also, the buffer must be at least 1 byte long.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer is too small to hold
///    the network provider name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td>
///    <td width="60%"> The network is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td width="60%"> The <i>lpProviderName</i> parameter or the
///    <i>lpBufferSize</i> parameter is invalid. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetProviderNameA(uint dwNetType, const(char)* lpProviderName, uint* lpBufferSize);

///The <b>WNetGetProviderName</b> function obtains the provider name for a specific type of network.
///Params:
///    dwNetType = Network type that is unique to the network. If two networks claim the same type, the function returns the name of
///                the provider loaded first. Only the high word of the network type is used. If a network reports a subtype in the
///                low word, it is ignored. You can find a complete list of network types in the header file Winnetwk.h.
///    lpProviderName = Pointer to a buffer that receives the network provider name.
///    lpBufferSize = Size of the buffer passed to the function, in characters. If the return value is ERROR_MORE_DATA,
///                   <i>lpBufferSize</i> returns the buffer size required (in characters) to hold the provider name. <b>Windows
///                   Me/98/95: </b>The size of the buffer is in bytes, not characters. Also, the buffer must be at least 1 byte long.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The buffer is too small to hold
///    the network provider name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td>
///    <td width="60%"> The network is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td width="60%"> The <i>lpProviderName</i> parameter or the
///    <i>lpBufferSize</i> parameter is invalid. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetProviderNameW(uint dwNetType, const(wchar)* lpProviderName, uint* lpBufferSize);

///The <b>WNetGetNetworkInformation</b> function returns extended information about a specific network provider whose
///name was returned by a previous network enumeration.
///Params:
///    lpProvider = Pointer to a constant null-terminated string that contains the name of the network provider for which information
///                 is required.
///    lpNetInfoStruct = Pointer to a NETINFOSTRUCT structure. The structure describes characteristics of the network.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl> </td> <td width="60%"> The <i>lpProvider</i> parameter
///    does not match any running network provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_VALUE</b></dt> </dl> </td> <td width="60%"> The <b>cbStructure</b> member of the
///    <b>NETINFOSTRUCT</b> structure does not contain a valid structure size. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetNetworkInformationA(const(char)* lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

///The <b>WNetGetNetworkInformation</b> function returns extended information about a specific network provider whose
///name was returned by a previous network enumeration.
///Params:
///    lpProvider = Pointer to a constant null-terminated string that contains the name of the network provider for which information
///                 is required.
///    lpNetInfoStruct = Pointer to a NETINFOSTRUCT structure. The structure describes characteristics of the network.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_PROVIDER</b></dt> </dl> </td> <td width="60%"> The <i>lpProvider</i> parameter
///    does not match any running network provider. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_VALUE</b></dt> </dl> </td> <td width="60%"> The <b>cbStructure</b> member of the
///    <b>NETINFOSTRUCT</b> structure does not contain a valid structure size. </td> </tr> </table>
///    
@DllImport("MPR")
uint WNetGetNetworkInformationW(const(wchar)* lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

///The <b>WNetGetLastError</b> function retrieves the most recent extended error code set by a WNet function. The
///network provider reported this error code; it will not generally be one of the errors included in the SDK header file
///WinError.h.
///Params:
///    lpError = Pointer to a variable that receives the error code reported by the network provider. The error code is specific
///              to the network provider.
///    lpErrorBuf = Pointer to the buffer that receives the null-terminated string describing the error.
///    nErrorBufSize = Size of the buffer pointed to by the <i>lpErrorBuf</i> parameter, in characters. If the buffer is too small for
///                    the error string, the string is truncated but still null-terminated. A buffer of at least 256 characters is
///                    recommended.
///    lpNameBuf = Pointer to the buffer that receives the null-terminated string identifying the network provider that raised the
///                error.
///    nNameBufSize = Size of the buffer pointed to by the <i>lpNameBuf</i> parameter, in characters. If the buffer is too small for
///                   the error string, the string is truncated but still null-terminated.
///Returns:
///    If the function succeeds, and it obtains the last error that the network provider reported, the return value is
///    NO_ERROR. If the caller supplies an invalid buffer, the return value is ERROR_INVALID_ADDRESS.
///    
@DllImport("MPR")
uint WNetGetLastErrorA(uint* lpError, const(char)* lpErrorBuf, uint nErrorBufSize, const(char)* lpNameBuf, 
                       uint nNameBufSize);

///The <b>WNetGetLastError</b> function retrieves the most recent extended error code set by a WNet function. The
///network provider reported this error code; it will not generally be one of the errors included in the SDK header file
///WinError.h.
///Params:
///    lpError = Pointer to a variable that receives the error code reported by the network provider. The error code is specific
///              to the network provider.
///    lpErrorBuf = Pointer to the buffer that receives the null-terminated string describing the error.
///    nErrorBufSize = Size of the buffer pointed to by the <i>lpErrorBuf</i> parameter, in characters. If the buffer is too small for
///                    the error string, the string is truncated but still null-terminated. A buffer of at least 256 characters is
///                    recommended.
///    lpNameBuf = Pointer to the buffer that receives the null-terminated string identifying the network provider that raised the
///                error.
///    nNameBufSize = Size of the buffer pointed to by the <i>lpNameBuf</i> parameter, in characters. If the buffer is too small for
///                   the error string, the string is truncated but still null-terminated.
///Returns:
///    If the function succeeds, and it obtains the last error that the network provider reported, the return value is
///    NO_ERROR. If the caller supplies an invalid buffer, the return value is ERROR_INVALID_ADDRESS.
///    
@DllImport("MPR")
uint WNetGetLastErrorW(uint* lpError, const(wchar)* lpErrorBuf, uint nErrorBufSize, const(wchar)* lpNameBuf, 
                       uint nNameBufSize);

///The <b>MultinetGetConnectionPerformance</b> function returns information about the expected performance of a
///connection used to access a network resource.
///Params:
///    lpNetResource = A pointer to a NETRESOURCE structure that specifies the network resource. The following members have specific
///                    meanings in this context. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="lpLocalName"></a><a id="lplocalname"></a><a id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt>
///                    </dl> </td> <td width="60%"> A pointer to a buffer that specifies a local device, such as "F:" or "LPT1", that is
///                    redirected to a network resource to be queried. If this member is <b>NULL</b> or an empty string, the network
///                    resource is specified in the <i>lpRemoteName</i> member. If this flag specifies a local device,
///                    <i>lpRemoteName</i> is ignored. </td> </tr> <tr> <td width="40%"><a id="lpRemoteName"></a><a
///                    id="lpremotename"></a><a id="LPREMOTENAME"></a><dl> <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td
///                    width="60%"> A pointer to a network resource to query. The resource must currently have an established
///                    connection. For example, if the resource is a file on a file server, then having the file open will ensure the
///                    connection. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a id="lpprovider"></a><a
///                    id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> Usually set to
///                    <b>NULL</b>, but can be a pointer to the owner (provider) of the resource if the network on which the resource
///                    resides is known. If the <i>lpProvider</i> member is not <b>NULL</b>, the system attempts to return information
///                    only about the named network. </td> </tr> </table>
///    lpNetConnectInfoStruct = A pointer to the NETCONNECTINFOSTRUCT structure that receives the data.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The network resource does not
///    supply this information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td>
///    <td width="60%"> The <b>lpLocalName</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter does not specify a redirected device, or the <i>lpRemoteName</i> member does not
///    specify the name of a resource that is currently connected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The operation could not be completed,
///    either because a network component is not started, or because the specified resource name is not recognized.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The local
///    device specified by the <i>lpLocalName</i> member is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The network name cannot be found. This error is
///    returned if the <b>lpLocalName</b> member of the NETRESOURCE structure pointed to by the <i>lpNetResource</i>
///    parameter was <b>NULL</b> and the <b>lpRemoteName</b> member of the <b>NETRESOURCE</b> structure pointed to by
///    the <i>lpNetResource</i> was also or <b>NULL</b> or could not recognized by any network. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td width="60%"> An attempt to access an
///    invalid address. This error is returned if the <i>lpNetResource</i> or <i>lpNetConnectInfoStruct</i> parameters
///    were <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A bad parameter was passed. This error is returned if the <i>lpNetConnectInfoStruct</i> parameter
///    does not point to a NETCONNECTINFOSTRUCT structure in which the <b>cbStructure</b> member is filled with the
///    proper structure size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call WNetGetLastError. </td> </tr> </table>
///    
@DllImport("MPR")
uint MultinetGetConnectionPerformanceA(NETRESOURCEA* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

///The <b>MultinetGetConnectionPerformance</b> function returns information about the expected performance of a
///connection used to access a network resource.
///Params:
///    lpNetResource = A pointer to a NETRESOURCE structure that specifies the network resource. The following members have specific
///                    meanings in this context. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="lpLocalName"></a><a id="lplocalname"></a><a id="LPLOCALNAME"></a><dl> <dt><b><b>lpLocalName</b></b></dt>
///                    </dl> </td> <td width="60%"> A pointer to a buffer that specifies a local device, such as "F:" or "LPT1", that is
///                    redirected to a network resource to be queried. If this member is <b>NULL</b> or an empty string, the network
///                    resource is specified in the <i>lpRemoteName</i> member. If this flag specifies a local device,
///                    <i>lpRemoteName</i> is ignored. </td> </tr> <tr> <td width="40%"><a id="lpRemoteName"></a><a
///                    id="lpremotename"></a><a id="LPREMOTENAME"></a><dl> <dt><b><b>lpRemoteName</b></b></dt> </dl> </td> <td
///                    width="60%"> A pointer to a network resource to query. The resource must currently have an established
///                    connection. For example, if the resource is a file on a file server, then having the file open will ensure the
///                    connection. </td> </tr> <tr> <td width="40%"><a id="lpProvider"></a><a id="lpprovider"></a><a
///                    id="LPPROVIDER"></a><dl> <dt><b><b>lpProvider</b></b></dt> </dl> </td> <td width="60%"> Usually set to
///                    <b>NULL</b>, but can be a pointer to the owner (provider) of the resource if the network on which the resource
///                    resides is known. If the <i>lpProvider</i> member is not <b>NULL</b>, the system attempts to return information
///                    only about the named network. </td> </tr> </table>
///    lpNetConnectInfoStruct = A pointer to the NETCONNECTINFOSTRUCT structure that receives the data.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is a system error
///    code, such as one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The network resource does not
///    supply this information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td>
///    <td width="60%"> The <b>lpLocalName</b> member of the NETRESOURCE structure pointed to by the
///    <i>lpNetResource</i> parameter does not specify a redirected device, or the <i>lpRemoteName</i> member does not
///    specify the name of a resource that is currently connected. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_NET_OR_BAD_PATH</b></dt> </dl> </td> <td width="60%"> The operation could not be completed,
///    either because a network component is not started, or because the specified resource name is not recognized.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> The local
///    device specified by the <i>lpLocalName</i> member is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The network name cannot be found. This error is
///    returned if the <b>lpLocalName</b> member of the NETRESOURCE structure pointed to by the <i>lpNetResource</i>
///    parameter was <b>NULL</b> and the <b>lpRemoteName</b> member of the <b>NETRESOURCE</b> structure pointed to by
///    the <i>lpNetResource</i> was also or <b>NULL</b> or could not recognized by any network. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS</b></dt> </dl> </td> <td width="60%"> An attempt to access an
///    invalid address. This error is returned if the <i>lpNetResource</i> or <i>lpNetConnectInfoStruct</i> parameters
///    were <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A bad parameter was passed. This error is returned if the <i>lpNetConnectInfoStruct</i> parameter
///    does not point to a NETCONNECTINFOSTRUCT structure in which the <b>cbStructure</b> member is filled with the
///    proper structure size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_NETWORK</b></dt> </dl> </td> <td
///    width="60%"> The network is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_EXTENDED_ERROR</b></dt> </dl> </td> <td width="60%"> A network-specific error occurred. To obtain a
///    description of the error, call WNetGetLastError. </td> </tr> </table>
///    
@DllImport("MPR")
uint MultinetGetConnectionPerformanceW(NETRESOURCEW* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);


