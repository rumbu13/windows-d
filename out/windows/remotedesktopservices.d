// Written in the D programming language.

module windows.remotedesktopservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IPropertyBag, SAFEARRAY,
                                   VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.multimedia : WAVEFORMATEX;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///Defines the buffer validation flags for the APO_CONNECTION_PROPERTY structure associated with each APO connection.
alias APO_BUFFER_FLAGS = int;
enum : int
{
    ///There is no valid data in the connection buffer. The buffer pointer is valid and the buffer is capable of holding
    ///the amount of valid audio data specified in the APO_CONNECTION_PROPERTY structure. While processing audio data,
    ///the audio engine marks every connection as BUFFER_INVALID before calling
    ///IAudioOutputEndpoint::GetOutputDataPointer or IAudioInputEndpointRT::GetInputDataPointer.
    BUFFER_INVALID = 0x00000000,
    ///The connection buffer contains valid data. This is the operational state of the connection buffer. The APO sets
    ///this flag after it starts writing valid data into the buffer. Capture endpoints should set this flag in the
    ///GetInputDataPointer method upon successful completion of the call.
    BUFFER_VALID   = 0x00000001,
    ///The connection buffer must be treated as if it contains silence. If the endpoint receives an input connection
    ///buffer that is identified as BUFFER_SILENT, then the endpoint can assume the data represents silence. When
    ///capturing, the endpoint can also set this flag, if necessary for a capture buffer.
    BUFFER_SILENT  = 0x00000002,
}

///Defines constants for the AE_CURRENT_POSITION structure. These constants describe the degree of validity of the
///current position.
alias AE_POSITION_FLAGS = int;
enum : int
{
    ///The position is not valid and must not be used.
    POSITION_INVALID       = 0x00000000,
    ///The position is valid; however, there has been a disruption such as a glitch or state transition. This current
    ///position is not correlated with the previous position. The start of a stream should not reflect a discontinuity.
    POSITION_DISCONTINUOUS = 0x00000001,
    ///The position is valid. The previous packet and the current packet are both synchronized with the timeline.
    POSITION_CONTINUOUS    = 0x00000002,
    ///The quality performance counter (QPC) timer value associated with this position is not accurate. This flag is set
    ///when a position error is encountered and the implementation is unable to compute an accurate QPC value that
    ///correlates with the position.
    POSITION_QPC_ERROR     = 0x00000004,
}

///Specifies the type of authentication used to connect to Remote Desktop Gateway (RD Gateway).
enum AAAuthSchemes : int
{
    ///This value is reserved.
    AA_AUTH_MIN                 = 0x00000000,
    ///Basic protocol authentication.
    AA_AUTH_BASIC               = 0x00000001,
    ///NTLM protocol authentication.
    AA_AUTH_NTLM                = 0x00000002,
    ///Standard authentication.
    AA_AUTH_SC                  = 0x00000003,
    ///Windows logon credentials authentication.
    AA_AUTH_LOGGEDONCREDENTIALS = 0x00000004,
    ///Microsoft Negotiate authentication.
    AA_AUTH_NEGOTIATE           = 0x00000005,
    ///This value is reserved.
    AA_AUTH_ANY                 = 0x00000006,
    ///Cookie-based authentication.
    AA_AUTH_COOKIE              = 0x00000007,
    ///Digest access authentication.
    AA_AUTH_DIGEST              = 0x00000008,
    ///Claims-based authentication. <b>Windows Server 2012, Windows 8, Windows Server 2008 R2 and Windows 7: </b>Not
    ///supported.
    AA_AUTH_ORGID               = 0x00000009,
    ///Authentication by reverse connection ID. <b>Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8,
    ///Windows Server 2008 R2 and Windows 7: </b>Not supported.
    AA_AUTH_CONID               = 0x0000000a,
    AA_AUTH_SSPI_NTLM           = 0x0000000b,
    ///This value is reserved.
    AA_AUTH_MAX                 = 0x0000000c,
}

///Specifies the type of event that the ITSGAccountingEngine::DoAccounting method is being notified of.
enum AAAccountingDataType : int
{
    ///A new session was created. The following fields in the AAAccountingData structure represented by the
    ///<i>accountingData</i> parameter are valid: <ul> <li><b>userName</b></li> <li><b>clientName</b></li>
    ///<li><b>authType</b></li> <li><b>mainSessionId</b></li> </ul>
    AA_MAIN_SESSION_CREATION = 0x00000000,
    ///A new subsession was created by an existing connection. The following fields in the AAAccountingData structure
    ///represented by the <i>accountingData</i> parameter are valid: <ul> <li><b>userName</b></li>
    ///<li><b>resourceName</b></li> <li><b>portNumber</b></li> <li><b>protocolName</b></li>
    ///<li><b>mainSessionId</b></li> <li><b>subSessionId</b></li> </ul>
    AA_SUB_SESSION_CREATION  = 0x00000001,
    ///A subsession was closed. The following fields in the AAAccountingData structure represented by the
    ///<i>accountingData</i> parameter are valid: <ul> <li><b>numberOfBytesTransfered</b></li>
    ///<li><b>numberOfBytesReceived</b></li> <li><b>mainSessionId</b></li> <li><b>subSessionId</b></li> </ul>
    AA_SUB_SESSION_CLOSED    = 0x00000002,
    ///A connection was closed. The following fields in the AAAccountingData structure represented by the
    ///<i>accountingData</i> parameter are valid: <ul> <li><b>mainSessionId</b></li> </ul>
    AA_MAIN_SESSION_CLOSED   = 0x00000003,
}

alias __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0004 = int;
enum : int
{
    SESSION_TIMEOUT_ACTION_DISCONNECT    = 0x00000000,
    SESSION_TIMEOUT_ACTION_SILENT_REAUTH = 0x00000001,
}

///Specifies the redirection settings associated with a connection.
enum PolicyAttributeType : int
{
    ///Enable device redirection for all devices.
    EnableAllRedirections        = 0x00000000,
    ///Disable device redirection for all devices.
    DisableAllRedirections       = 0x00000001,
    ///Disable drive redirection.
    DriveRedirectionDisabled     = 0x00000002,
    ///Disable printer redirection.
    PrinterRedirectionDisabled   = 0x00000003,
    ///Disable port redirection.
    PortRedirectionDisabled      = 0x00000004,
    ///Disable clipboard redirection.
    ClipboardRedirectionDisabled = 0x00000005,
    ///Disable Plug and Play device redirection.
    PnpRedirectionDisabled       = 0x00000006,
    AllowOnlySDRServers          = 0x00000007,
}

alias __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0006 = int;
enum : int
{
    AA_UNTRUSTED                   = 0x00000000,
    AA_TRUSTEDUSER_UNTRUSTEDCLIENT = 0x00000001,
    AA_TRUSTEDUSER_TRUSTEDCLIENT   = 0x00000002,
}

///Specifies the connection state of a Remote Desktop Services session.
alias WTS_CONNECTSTATE_CLASS = int;
enum : int
{
    ///A user is logged on to the WinStation. This state occurs when a user is signed in and actively connected to the
    ///device.
    WTSActive       = 0x00000000,
    ///The WinStation is connected to the client.
    WTSConnected    = 0x00000001,
    ///The WinStation is in the process of connecting to the client.
    WTSConnectQuery = 0x00000002,
    ///The WinStation is shadowing another WinStation.
    WTSShadow       = 0x00000003,
    ///The WinStation is active but the client is disconnected. This state occurs when a user is signed in but not
    ///actively connected to the device, such as when the user has chosen to exit to the lock screen.
    WTSDisconnected = 0x00000004,
    ///The WinStation is waiting for a client to connect.
    WTSIdle         = 0x00000005,
    ///The WinStation is listening for a connection. A listener session waits for requests for new client connections.
    ///No user is logged on a listener session. A listener session cannot be reset, shadowed, or changed to a regular
    ///client session.
    WTSListen       = 0x00000006,
    ///The WinStation is being reset.
    WTSReset        = 0x00000007,
    ///The WinStation is down due to an error.
    WTSDown         = 0x00000008,
    ///The WinStation is initializing.
    WTSInit         = 0x00000009,
}

///Contains values that indicate the type of session information to retrieve in a call to the WTSQuerySessionInformation
///function.
alias WTS_INFO_CLASS = int;
enum : int
{
    ///A null-terminated string that contains the name of the initial program that Remote Desktop Services runs when the
    ///user logs on.
    WTSInitialProgram     = 0x00000000,
    ///A null-terminated string that contains the published name of the application that the session is running.
    ///<b>Windows Server 2008 R2, Windows 7, Windows Server 2008 and Windows Vista: </b>This value is not supported
    WTSApplicationName    = 0x00000001,
    ///A null-terminated string that contains the default directory used when launching the initial program.
    WTSWorkingDirectory   = 0x00000002,
    ///This value is not used.
    WTSOEMId              = 0x00000003,
    ///A <b>ULONG</b> value that contains the session identifier.
    WTSSessionId          = 0x00000004,
    ///A null-terminated string that contains the name of the user associated with the session.
    WTSUserName           = 0x00000005,
    ///A null-terminated string that contains the name of the Remote Desktop Services session. <div
    ///class="alert"><b>Note</b> Despite its name, specifying this type does not return the window station name. Rather,
    ///it returns the name of the Remote Desktop Services session. Each Remote Desktop Services session is associated
    ///with an interactive window station. Because the only supported window station name for an interactive window
    ///station is "WinSta0", each session is associated with its own "WinSta0" window station. For more information, see
    ///Window Stations.</div> <div> </div>
    WTSWinStationName     = 0x00000006,
    ///A null-terminated string that contains the name of the domain to which the logged-on user belongs.
    WTSDomainName         = 0x00000007,
    ///The session's current connection state. For more information, see WTS_CONNECTSTATE_CLASS.
    WTSConnectState       = 0x00000008,
    ///A <b>ULONG</b> value that contains the build number of the client.
    WTSClientBuildNumber  = 0x00000009,
    ///A null-terminated string that contains the name of the client.
    WTSClientName         = 0x0000000a,
    ///A null-terminated string that contains the directory in which the client is installed.
    WTSClientDirectory    = 0x0000000b,
    ///A <b>USHORT</b> client-specific product identifier.
    WTSClientProductId    = 0x0000000c,
    ///A <b>ULONG</b> value that contains a client-specific hardware identifier. This option is reserved for future use.
    ///WTSQuerySessionInformation will always return a value of 0.
    WTSClientHardwareId   = 0x0000000d,
    ///The network type and network address of the client. For more information, see WTS_CLIENT_ADDRESS. The IP address
    ///is offset by two bytes from the start of the <b>Address</b> member of the WTS_CLIENT_ADDRESS structure.
    WTSClientAddress      = 0x0000000e,
    ///Information about the display resolution of the client. For more information, see WTS_CLIENT_DISPLAY.
    WTSClientDisplay      = 0x0000000f,
    ///A <b>USHORT</b> value that specifies information about the protocol type for the session. This is one of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The console session.
    ///</td> </tr> <tr> <td> 1 </td> <td> This value is retained for legacy purposes. </td> </tr> <tr> <td> 2 </td> <td>
    ///The RDP protocol. </td> </tr> </table>
    WTSClientProtocolType = 0x00000010,
    ///This value returns <b>FALSE</b>. If you call GetLastError to get extended error information, <b>GetLastError</b>
    ///returns <b>ERROR_NOT_SUPPORTED</b>. <b>Windows Server 2008 and Windows Vista: </b>This value is not used.
    WTSIdleTime           = 0x00000011,
    ///This value returns <b>FALSE</b>. If you call GetLastError to get extended error information, <b>GetLastError</b>
    ///returns <b>ERROR_NOT_SUPPORTED</b>. <b>Windows Server 2008 and Windows Vista: </b>This value is not used.
    WTSLogonTime          = 0x00000012,
    ///This value returns <b>FALSE</b>. If you call GetLastError to get extended error information, <b>GetLastError</b>
    ///returns <b>ERROR_NOT_SUPPORTED</b>. <b>Windows Server 2008 and Windows Vista: </b>This value is not used.
    WTSIncomingBytes      = 0x00000013,
    ///This value returns <b>FALSE</b>. If you call GetLastError to get extended error information, <b>GetLastError</b>
    ///returns <b>ERROR_NOT_SUPPORTED</b>. <b>Windows Server 2008 and Windows Vista: </b>This value is not used.
    WTSOutgoingBytes      = 0x00000014,
    ///This value returns <b>FALSE</b>. If you call GetLastError to get extended error information, <b>GetLastError</b>
    ///returns <b>ERROR_NOT_SUPPORTED</b>. <b>Windows Server 2008 and Windows Vista: </b>This value is not used.
    WTSIncomingFrames     = 0x00000015,
    ///This value returns <b>FALSE</b>. If you call GetLastError to get extended error information, <b>GetLastError</b>
    ///returns <b>ERROR_NOT_SUPPORTED</b>. <b>Windows Server 2008 and Windows Vista: </b>This value is not used.
    WTSOutgoingFrames     = 0x00000016,
    ///Information about a Remote Desktop Connection (RDC) client. For more information, see WTSCLIENT.
    WTSClientInfo         = 0x00000017,
    ///Information about a client session on a RD Session Host server. For more information, see WTSINFO.
    WTSSessionInfo        = 0x00000018,
    ///Extended information about a session on a RD Session Host server. For more information, see WTSINFOEX. <b>Windows
    ///Server 2008 and Windows Vista: </b>This value is not supported.
    WTSSessionInfoEx      = 0x00000019,
    ///A WTSCONFIGINFO structure that contains information about the configuration of a RD Session Host server.
    ///<b>Windows Server 2008 and Windows Vista: </b>This value is not supported.
    WTSConfigInfo         = 0x0000001a,
    ///This value is not supported.
    WTSValidationInfo     = 0x0000001b,
    ///A WTS_SESSION_ADDRESS structure that contains the IPv4 address assigned to the session. If the session does not
    ///have a virtual IP address, the WTSQuerySessionInformation function returns <b>ERROR_NOT_SUPPORTED</b>. <b>Windows
    ///Server 2008 and Windows Vista: </b>This value is not supported.
    WTSSessionAddressV4   = 0x0000001c,
    ///Determines whether the current session is a remote session. The WTSQuerySessionInformation function returns a
    ///value of <b>TRUE</b> to indicate that the current session is a remote session, and <b>FALSE</b> to indicate that
    ///the current session is a local session. This value can only be used for the local machine, so the <i>hServer</i>
    ///parameter of the <b>WTSQuerySessionInformation</b> function must contain <b>WTS_CURRENT_SERVER_HANDLE</b>.
    ///<b>Windows Server 2008 and Windows Vista: </b>This value is not supported.
    WTSIsRemoteSession    = 0x0000001d,
}

///Contains values that indicate the type of user configuration information to set or retrieve in a call to the
///WTSQueryUserConfig and WTSSetUserConfig functions.
alias WTS_CONFIG_CLASS = int;
enum : int
{
    ///A null-terminated string that contains the path of the initial program that Remote Desktop Services runs when the
    ///user logs on. If the <b>WTSUserConfigfInheritInitialProgram</b> value is 1, the initial program can be any
    ///program specified by the client.
    WTSUserConfigInitialProgram                = 0x00000000,
    ///A null-terminated string that contains the path of the working directory for the initial program.
    WTSUserConfigWorkingDirectory              = 0x00000001,
    ///A value that indicates whether the client can specify the initial program. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The client cannot specify the initial program. Instead, the
    ///<b>WTSUserConfigInitialProgram</b> string identifies an initial program that runs automatically when the user
    ///logs on to a remote computer. Remote Desktop Services logs the user off when the user exits that program. </td>
    ///</tr> <tr> <td> 1 </td> <td> The client can specify the initial program. </td> </tr> </table>
    WTSUserConfigfInheritInitialProgram        = 0x00000002,
    ///A value that indicates whether the user account is permitted to log on to an RD Session Host server. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The user cannot log on. </td> </tr> <tr> <td> 1
    ///</td> <td> The user can log on. </td> </tr> </table>
    WTSUserConfigfAllowLogonTerminalServer     = 0x00000003,
    ///A <b>DWORD</b> value that specifies the maximum connection duration, in milliseconds. One minute before the
    ///connection time-out interval expires, the user is notified of the pending disconnection. The user's session is
    ///disconnected or terminated depending on the <b>WTSUserConfigBrokenTimeoutSettings</b> value. Every time the user
    ///logs on, the timer is reset. A value of zero indicates that the connection timer is disabled.
    WTSUserConfigTimeoutSettingsConnections    = 0x00000004,
    ///A <b>DWORD</b> value that specifies the maximum duration, in milliseconds, that an RD Session Host server retains
    ///a disconnected session before the logon is terminated. A value of zero indicates that the disconnection timer is
    ///disabled.
    WTSUserConfigTimeoutSettingsDisconnections = 0x00000005,
    ///A <b>DWORD</b> value that specifies the maximum idle time, in milliseconds. If there is no keyboard or mouse
    ///activity for the specified interval, the user's session is disconnected or terminated depending on the
    ///<b>WTSUserConfigBrokenTimeoutSettings</b> value. A value of zero indicates that the idle timer is disabled.
    WTSUserConfigTimeoutSettingsIdle           = 0x00000006,
    ///This constant currently is not used by Remote Desktop Services. A value that indicates whether the RD Session
    ///Host server automatically reestablishes client drive mappings at logon. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The server does not automatically connect to previously mapped
    ///client drives. </td> </tr> <tr> <td> 1 </td> <td> The server automatically connects to previously mapped client
    ///drives at logon. </td> </tr> </table>
    WTSUserConfigfDeviceClientDrives           = 0x00000007,
    ///RDP 5.0 and later clients: A value that indicates whether the RD Session Host server automatically reestablishes
    ///client printer mappings at logon. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The
    ///server does not automatically connect to previously mapped client printers. </td> </tr> <tr> <td> 1 </td> <td>
    ///The server automatically connects to previously mapped client printers at logon. </td> </tr> </table>
    WTSUserConfigfDeviceClientPrinters         = 0x00000008,
    ///RDP 5.0 and later clients: A value that indicates whether the client printer is the default printer. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The client printer is not the default printer. </td>
    ///</tr> <tr> <td> 1 </td> <td> The client printer is the default printer. </td> </tr> </table>
    WTSUserConfigfDeviceClientDefaultPrinter   = 0x00000009,
    ///A value that indicates what happens when the connection or idle timers expire or when a connection is lost due to
    ///a connection error. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The session is
    ///disconnected. </td> </tr> <tr> <td> 1 </td> <td> The session is terminated. </td> </tr> </table>
    WTSUserConfigBrokenTimeoutSettings         = 0x0000000a,
    ///A value that indicates how a disconnected session for this user can be reconnected. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The user can log on to any client computer to reconnect to a
    ///disconnected session. </td> </tr> <tr> <td> 1 </td> <td> The user can reconnect to a disconnected session by
    ///logging on to the client computer used to establish the disconnected session. If the user logs on from a
    ///different client computer, the user gets a new logon session. </td> </tr> </table>
    WTSUserConfigReconnectSettings             = 0x0000000b,
    ///This constant currently is not used by Remote Desktop Services. A value that indicates the configuration for
    ///dial-up connections in which the RD Session Host server stops responding and then calls back the client to
    ///establish the connection. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0 </td> <td> Callback
    ///connections are disabled. </td> </tr> <tr> <td> 1 </td> <td> The server prompts the user to enter a phone number
    ///and calls the user back at that phone number. You can use the <b>WTSUserConfigModemCallbackPhoneNumber</b> value
    ///to specify a default phone number. </td> </tr> <tr> <td> 2 </td> <td> The server automatically calls the user
    ///back at the phone number specified by the <b>WTSUserConfigModemCallbackPhoneNumber</b> value. </td> </tr>
    ///</table>
    WTSUserConfigModemCallbackSettings         = 0x0000000c,
    ///This constant currently is not used by Remote Desktop Services. A null-terminated string that contains the phone
    ///number to use for callback connections.
    WTSUserConfigModemCallbackPhoneNumber      = 0x0000000d,
    ///RDP 5.0 and later clients: A value that indicates whether the user session can be shadowed. Shadowing allows a
    ///user to remotely monitor the on-screen operations of another user. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td> 0 </td> <td> Disable </td> </tr> <tr> <td> 1 </td> <td> Enable input, notify </td> </tr> <tr>
    ///<td> 2 </td> <td> Enable input, no notify </td> </tr> <tr> <td> 3 </td> <td> Enable no input, notify </td> </tr>
    ///<tr> <td> 4 </td> <td> Enable no input, no notify </td> </tr> </table>
    WTSUserConfigShadowingSettings             = 0x0000000e,
    ///A null-terminated string that contains the path of the user's profile for RD Session Host server logon. The
    ///directory the path identifies must be created manually, and must exist prior to the logon. WTSSetUserConfig will
    ///not create the directory if it does not already exist.
    WTSUserConfigTerminalServerProfilePath     = 0x0000000f,
    ///A null-terminated string that contains the path of the user's root directory for RD Session Host server logon.
    ///This string can specify a local path or a UNC path (<i>\\ComputerName\Share\Path</i>). For more information, see
    ///<b>WTSUserConfigfTerminalServerRemoteHomeDir</b>.
    WTSUserConfigTerminalServerHomeDir         = 0x00000010,
    ///A null-terminated string that contains a drive name (a drive letter followed by a colon) to which the UNC path
    ///specified in the <b>WTSUserConfigTerminalServerHomeDir</b> string is mapped. For more information, see
    ///<b>WTSUserConfigfTerminalServerRemoteHomeDir</b>.
    WTSUserConfigTerminalServerHomeDirDrive    = 0x00000011,
    ///A value that indicates whether the user's root directory for RD Session Host server logon is a local path or a
    ///mapped drive letter. Note that this value cannot be used with WTSSetUserConfig. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> 0 </td> <td> The <b>WTSUserConfigTerminalServerHomeDir</b> string contains the
    ///local path of the user's RD Session Host server logon root directory. </td> </tr> <tr> <td> 1 </td> <td> The
    ///<b>WTSUserConfigTerminalServerHomeDir</b> string contains the UNC path of the user's RD Session Host server logon
    ///root directory, and the <b>WTSUserConfigTerminalServerHomeDirDrive</b> string contains a drive letter to which
    ///the UNC path is mapped. </td> </tr> </table>
    WTSUserConfigfTerminalServerRemoteHomeDir  = 0x00000012,
    ///A WTSUSERCONFIG structure that contains configuration data for the session. <b>Windows Server 2008 and Windows
    ///Vista: </b>This value is not supported.
    WTSUserConfigUser                          = 0x00000013,
}

///Specifies the source of configuration information returned by the WTSQueryUserConfig function. This enumeration type
///is used in the WTSUSERCONFIG structure.
alias WTS_CONFIG_SOURCE = int;
enum : int
{
    ///The configuration information came from the Security Accounts Manager (SAM) database.
    WTSUserConfigSourceSAM = 0x00000000,
}

///Contains values that indicate the type of virtual channel information to retrieve.
alias WTS_VIRTUAL_CLASS = int;
enum : int
{
    ///This value is not currently supported.
    WTSVirtualClientData = 0x00000000,
    ///Indicates a request for the file handle of a virtual channel that can be used for asynchronous I/O.
    WTSVirtualFileHandle = 0x00000001,
}

///Specifies the type of structure that a Remote Desktop Services function has returned in a buffer.
alias WTS_TYPE_CLASS = int;
enum : int
{
    ///The buffer contains one or more WTS_PROCESS_INFO structures.
    WTSTypeProcessInfoLevel0 = 0x00000000,
    ///The buffer contains one or more WTS_PROCESS_INFO_EX structures.
    WTSTypeProcessInfoLevel1 = 0x00000001,
    ///The buffer contains one or more WTS_SESSION_INFO_1 structures.
    WTSTypeSessionInfoLevel1 = 0x00000002,
}

///Contains values that indicate the drain state of a Remote Desktop Session Host (RD Session Host) server. The drain
///state indicates whether an RD Session Host server is accepting new connections. If the RD Session Host server is
///currently accepting new connections, its drain state is off. If it is not accepting new connections, its drain state
///is on.
alias WTSSBX_MACHINE_DRAIN = int;
enum : int
{
    ///The drain state of the server is unspecified.
    WTSSBX_MACHINE_DRAIN_UNSPEC = 0x00000000,
    ///The server is accepting new user sessions.
    WTSSBX_MACHINE_DRAIN_OFF    = 0x00000001,
    WTSSBX_MACHINE_DRAIN_ON     = 0x00000002,
}

///Contains values that indicate the session mode of a Remote Desktop Session Host (RD Session Host) server.
alias WTSSBX_MACHINE_SESSION_MODE = int;
enum : int
{
    ///The session mode of the server is unspecified.
    WTSSBX_MACHINE_SESSION_MODE_UNSPEC   = 0x00000000,
    ///The server is in single session mode. It can only accept one session per user.
    WTSSBX_MACHINE_SESSION_MODE_SINGLE   = 0x00000001,
    WTSSBX_MACHINE_SESSION_MODE_MULTIPLE = 0x00000002,
}

///Contains values that indicate the address family of a network address that is being used for redirection.
alias WTSSBX_ADDRESS_FAMILY = int;
enum : int
{
    ///An unspecified address family.
    WTSSBX_ADDRESS_FAMILY_AF_UNSPEC  = 0x00000000,
    ///An IPv4 address.
    WTSSBX_ADDRESS_FAMILY_AF_INET    = 0x00000001,
    ///An IPv6 address.
    WTSSBX_ADDRESS_FAMILY_AF_INET6   = 0x00000002,
    ///An IPX address.
    WTSSBX_ADDRESS_FAMILY_AF_IPX     = 0x00000003,
    WTSSBX_ADDRESS_FAMILY_AF_NETBIOS = 0x00000004,
}

///Contains values that indicate the current state of a server.
alias WTSSBX_MACHINE_STATE = int;
enum : int
{
    ///The server state is unspecified.
    WTSSBX_MACHINE_STATE_UNSPEC        = 0x00000000,
    ///The server state is ready.
    WTSSBX_MACHINE_STATE_READY         = 0x00000001,
    WTSSBX_MACHINE_STATE_SYNCHRONIZING = 0x00000002,
}

///Contains values that indicate the connection state of a user session.
alias WTSSBX_SESSION_STATE = int;
enum : int
{
    ///The session state is unspecified.
    WTSSBX_SESSION_STATE_UNSPEC       = 0x00000000,
    ///The user session is active.
    WTSSBX_SESSION_STATE_ACTIVE       = 0x00000001,
    WTSSBX_SESSION_STATE_DISCONNECTED = 0x00000002,
}

///Contains values that indicate the type of status change that occurred on a Remote Desktop Session Host (RD Session
///Host) server or a user session. Remote Desktop Connection Broker (RD Connection Broker) uses this enumeration type in
///the WTSSBX_MachineChangeNotification and WTSSBX_SessionChangeNotification methods to notify the plug-in about changes
///that have occurred.
alias WTSSBX_NOTIFICATION_TYPE = int;
enum : int
{
    ///RD Connection Broker received a Removed notification. This indicates that a user has logged off an RD Session
    ///Host server or that an RD Session Host server left a farm in RD Connection Broker.
    WTSSBX_NOTIFICATION_REMOVED = 0x00000001,
    ///RD Connection Broker received a Changed notification. This indicates that the session state of the RD Session
    ///Host server changed or that an RD Session Host server setting, such as the IP address or the maximum session
    ///limit, changed.
    WTSSBX_NOTIFICATION_CHANGED = 0x00000002,
    ///RD Connection Broker received an Added notification. This indicates that a user logged into an RD Session Host
    ///server or that an RD Session Host server joined a farm in RD Connection Broker.
    WTSSBX_NOTIFICATION_ADDED   = 0x00000004,
    ///RD Connection Broker received a Resync notification. This indicates that an RD Session Host server joined a farm
    ///in RD Connection Broker and the new RD Session Host server is now synchronizing its session information with the
    ///RD Connection Broker server.
    WTSSBX_NOTIFICATION_RESYNC  = 0x00000008,
}

///Indicates the IP address type.
alias TSSD_AddrV46Type = int;
enum : int
{
    ///The IP address is not valid.
    TSSD_ADDR_UNDEFINED = 0x00000000,
    ///The address is in IPv4 format.
    TSSD_ADDR_IPv4      = 0x00000004,
    ///The address is in IPv6 format.
    TSSD_ADDR_IPv6      = 0x00000006,
}

alias TSSB_NOTIFICATION_TYPE = int;
enum : int
{
    TSSB_NOTIFY_INVALID                   = 0x00000000,
    TSSB_NOTIFY_TARGET_CHANGE             = 0x00000001,
    TSSB_NOTIFY_SESSION_CHANGE            = 0x00000002,
    TSSB_NOTIFY_CONNECTION_REQUEST_CHANGE = 0x00000004,
}

///Indicates the state of a target.
alias TARGET_STATE = int;
enum : int
{
    ///The target state is unknown.
    TARGET_UNKNOWN      = 0x00000001,
    ///The target is initializing.
    TARGET_INITIALIZING = 0x00000002,
    ///The target is running.
    TARGET_RUNNING      = 0x00000003,
    ///The target is not running. If a resource plug-in calls <b>OnStateChange</b> and the target is in this state, RD
    ///Connection Broker will delete the target object from its database.
    TARGET_DOWN         = 0x00000004,
    ///The target is hibernated.
    TARGET_HIBERNATED   = 0x00000005,
    ///The target is checked out.
    TARGET_CHECKED_OUT  = 0x00000006,
    ///The target is stopped.
    TARGET_STOPPED      = 0x00000007,
    TARGET_INVALID      = 0x00000008,
    TARGET_STARTING     = 0x00000009,
    TARGET_STOPPING     = 0x0000000a,
    TARGET_MAXSTATE     = 0x0000000b,
}

///Specifies the type of change that occurred in a target.
alias TARGET_CHANGE_TYPE = int;
enum : int
{
    ///Unspecified change in the target.
    TARGET_CHANGE_UNSPEC           = 0x00000001,
    ///The target's external IP address changed.
    TARGET_EXTERNALIP_CHANGED      = 0x00000002,
    ///The target's internal IP address changed.
    TARGET_INTERNALIP_CHANGED      = 0x00000004,
    ///The target was reported to RD Connection Broker.
    TARGET_JOINED                  = 0x00000008,
    ///The target was deleted from the store in RD Connection Broker.
    TARGET_REMOVED                 = 0x00000010,
    ///The target's state changed. To determine the current state of the target, check the TargetState property of
    ///ITsSbTarget.
    TARGET_STATE_CHANGED           = 0x00000020,
    ///The target is not hosting any sessions currently.
    TARGET_IDLE                    = 0x00000040,
    TARGET_PENDING                 = 0x00000080,
    TARGET_INUSE                   = 0x00000100,
    TARGET_PATCH_STATE_CHANGED     = 0x00000200,
    TARGET_FARM_MEMBERSHIP_CHANGED = 0x00000400,
}

///Indicates whether a target belongs to a pool or farm.
alias TARGET_TYPE = int;
enum : int
{
    ///The target type is unknown.
    UNKNOWN = 0x00000000,
    ///The target is a virtual machine that belongs to a pool or an RD Session Host server that belongs to a farm.
    FARM    = 0x00000001,
    NONFARM = 0x00000002,
}

alias TARGET_PATCH_STATE = int;
enum : int
{
    TARGET_PATCH_UNKNOWN     = 0x00000000,
    TARGET_PATCH_NOT_STARTED = 0x00000001,
    TARGET_PATCH_IN_PROGRESS = 0x00000002,
    TARGET_PATCH_COMPLETED   = 0x00000003,
    TARGET_PATCH_FAILED      = 0x00000004,
}

alias CLIENT_MESSAGE_TYPE = int;
enum : int
{
    CLIENT_MESSAGE_CONNECTION_INVALID = 0x00000000,
    CLIENT_MESSAGE_CONNECTION_STATUS  = 0x00000001,
    CLIENT_MESSAGE_CONNECTION_ERROR   = 0x00000002,
}

alias CONNECTION_CHANGE_NOTIFICATION = int;
enum : int
{
    CONNECTION_REQUEST_INVALID            = 0x00000000,
    CONNECTION_REQUEST_PENDING            = 0x00000001,
    CONNECTION_REQUEST_FAILED             = 0x00000002,
    CONNECTION_REQUEST_TIMEDOUT           = 0x00000003,
    CONNECTION_REQUEST_SUCCEEDED          = 0x00000004,
    CONNECTION_REQUEST_CANCELLED          = 0x00000005,
    CONNECTION_REQUEST_LB_COMPLETED       = 0x00000006,
    CONNECTION_REQUEST_QUERY_PL_COMPLETED = 0x00000007,
    CONNECTION_REQUEST_ORCH_COMPLETED     = 0x00000008,
}

alias RD_FARM_TYPE = int;
enum : int
{
    RD_FARM_RDSH                 = 0x00000000,
    RD_FARM_TEMP_VM              = 0x00000001,
    RD_FARM_MANUAL_PERSONAL_VM   = 0x00000002,
    RD_FARM_AUTO_PERSONAL_VM     = 0x00000003,
    RD_FARM_MANUAL_PERSONAL_RDSH = 0x00000004,
    RD_FARM_AUTO_PERSONAL_RDSH   = 0x00000005,
    RD_FARM_TYPE_UNKNOWN         = 0xffffffff,
}

alias PLUGIN_TYPE = int;
enum : int
{
    UNKNOWN_PLUGIN        = 0x00000000,
    POLICY_PLUGIN         = 0x00000001,
    RESOURCE_PLUGIN       = 0x00000002,
    LOAD_BALANCING_PLUGIN = 0x00000004,
    PLACEMENT_PLUGIN      = 0x00000008,
    ORCHESTRATION_PLUGIN  = 0x00000010,
    PROVISIONING_PLUGIN   = 0x00000020,
    TASK_PLUGIN           = 0x00000040,
}

///Indicates the state of a session.
alias TSSESSION_STATE = int;
enum : int
{
    ///The session state is not valid.
    STATE_INVALID      = 0xffffffff,
    ///The user is logged on to WinStation.
    STATE_ACTIVE       = 0x00000000,
    ///WinStation is connected to the client (session reconnected).
    STATE_CONNECTED    = 0x00000001,
    ///In the process of connecting to the client (session reconnect pending).
    STATE_CONNECTQUERY = 0x00000002,
    ///Shadowing another WinStation.
    STATE_SHADOW       = 0x00000003,
    ///WinStation is active but the client is disconnected.
    STATE_DISCONNECTED = 0x00000004,
    ///Waiting for the client to connect.
    STATE_IDLE         = 0x00000005,
    ///WinStation is listening for a connection.
    STATE_LISTEN       = 0x00000006,
    ///WinStation is being reset (session logged off).
    STATE_RESET        = 0x00000007,
    ///WinStation is down due to error.
    STATE_DOWN         = 0x00000008,
    ///WinStation is initializing.
    STATE_INIT         = 0x00000009,
    STATE_MAX          = 0x0000000a,
}

alias TARGET_OWNER = int;
enum : int
{
    OWNER_UNKNOWN      = 0x00000000,
    OWNER_MS_TS_PLUGIN = 0x00000001,
    OWNER_MS_VM_PLUGIN = 0x00000002,
}

alias VM_NOTIFY_STATUS = int;
enum : int
{
    VM_NOTIFY_STATUS_PENDING     = 0x00000000,
    VM_NOTIFY_STATUS_IN_PROGRESS = 0x00000001,
    VM_NOTIFY_STATUS_COMPLETE    = 0x00000002,
    VM_NOTIFY_STATUS_FAILED      = 0x00000003,
    VM_NOTIFY_STATUS_CANCELED    = 0x00000004,
}

alias VM_HOST_NOTIFY_STATUS = int;
enum : int
{
    VM_HOST_STATUS_INIT_PENDING     = 0x00000000,
    VM_HOST_STATUS_INIT_IN_PROGRESS = 0x00000001,
    VM_HOST_STATUS_INIT_COMPLETE    = 0x00000002,
    VM_HOST_STATUS_INIT_FAILED      = 0x00000003,
}

///Used with the IRDVTaskPluginNotifySink::OnTaskStateChange method to indicate the status of a task.
alias RDV_TASK_STATUS = int;
enum : int
{
    ///The task state cannot be determined.
    RDV_TASK_STATUS_UNKNOWN     = 0x00000000,
    ///Searching for applicable tasks.
    RDV_TASK_STATUS_SEARCHING   = 0x00000001,
    ///Downloading tasks.
    RDV_TASK_STATUS_DOWNLOADING = 0x00000002,
    ///Performing tasks.
    RDV_TASK_STATUS_APPLYING    = 0x00000003,
    ///Rebooting. The task may or may not be complete.
    RDV_TASK_STATUS_REBOOTING   = 0x00000004,
    ///Reboot completed. The task may or may not be complete.
    RDV_TASK_STATUS_REBOOTED    = 0x00000005,
    ///Task completed successfully.
    RDV_TASK_STATUS_SUCCESS     = 0x00000006,
    ///Task failed.
    RDV_TASK_STATUS_FAILED      = 0x00000007,
    ///Task did not finish in the allotted time.
    RDV_TASK_STATUS_TIMEOUT     = 0x00000008,
}

///Specifies sort order. It is used as a parameter in the EnumerateTargets method.
alias TS_SB_SORT_BY = int;
enum : int
{
    ///Do not sort.
    TS_SB_SORT_BY_NONE = 0x00000000,
    ///Sort by target name.
    TS_SB_SORT_BY_NAME = 0x00000001,
    ///Sort by a specified property.
    TS_SB_SORT_BY_PROP = 0x00000002,
}

///Specifies the type of personal desktop resolution being requested.
alias TSPUB_PLUGIN_PD_RESOLUTION_TYPE = int;
enum : int
{
    ///Resolve an existing personal desktop for the user. If no personal desktop exists, the ResolvePersonalDesktop
    ///method should create a new one.
    TSPUB_PLUGIN_PD_QUERY_OR_CREATE = 0x00000000,
    ///Resolve an existing personal desktop for the user. If no personal desktop exists, the ResolvePersonalDesktop
    ///method should return an error code.
    TSPUB_PLUGIN_PD_QUERY_EXISTING  = 0x00000001,
}

///Specifies the type of assignment for a personal desktop resolution.
alias TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE = int;
enum : int
{
    ///A new personal desktop was created for the user.
    TSPUB_PLUGIN_PD_ASSIGNMENT_NEW      = 0x00000000,
    TSPUB_PLUGIN_PD_ASSIGNMENT_EXISTING = 0x00000001,
}

///Used to specify the type of graphics virtual channel to create in the IWRdsGraphicsChannelManager::CreateChannel
///method.
enum WRdsGraphicsChannelType : int
{
    ///The channel delivery must be guaranteed.
    WRdsGraphicsChannelType_GuaranteedDelivery = 0x00000000,
    ///The channel delivery can be lossy.
    WRdsGraphicsChannelType_BestEffortDelivery = 0x00000001,
}

///Contains information about the state of the Remote Desktop Services service.
alias WTS_RCM_SERVICE_STATE = int;
enum : int
{
    ///There has been no change in the state of the service.
    WTS_SERVICE_NONE  = 0x00000000,
    ///The RCM service is starting.
    WTS_SERVICE_START = 0x00000001,
    ///The RCM service is stopping.
    WTS_SERVICE_STOP  = 0x00000002,
}

///Contains information about the drain state of the Remote Desktop Session Host (RD Session Host) server. A server in
///drain mode will not accept new connections, but it will reconnect users to existing sessions.
alias WTS_RCM_DRAIN_STATE = int;
enum : int
{
    ///There has been no change in the drain state.
    WTS_DRAIN_STATE_NONE   = 0x00000000,
    ///The server is in drain mode, or it is entering drain mode. (It is not accepting new connections.)
    WTS_DRAIN_IN_DRAIN     = 0x00000001,
    ///The server is not in drain mode, or it is exiting drain mode. (It is accepting new connections.)
    WTS_DRAIN_NOT_IN_DRAIN = 0x00000002,
}

///Contains values that specify the preferred response of the protocol to a logon error.
alias WTS_LOGON_ERROR_REDIRECTOR_RESPONSE = int;
enum : int
{
    ///This value is used for safe initialization.
    WTS_LOGON_ERR_INVALID                      = 0x00000000,
    ///Specifies that the client logon was not handled by the redirector and should be handled by the logon user
    ///interface.
    WTS_LOGON_ERR_NOT_HANDLED                  = 0x00000001,
    ///Specifies that the client logon was handled by the redirector and that the logon user interface should display
    ///itself normally.
    WTS_LOGON_ERR_HANDLED_SHOW                 = 0x00000002,
    ///Specifies that the client logon was handled by the redirector and should not be passed to the next redirector.
    ///The logon user interface should not display an error message but should attempt to collect credentials again.
    WTS_LOGON_ERR_HANDLED_DONT_SHOW            = 0x00000003,
    ///Specifies that the client logon was handled by the redirector and should not be passed to the next redirector.
    ///The logon user interface should not be displayed and should not attempt to collect credentials again.
    WTS_LOGON_ERR_HANDLED_DONT_SHOW_START_OVER = 0x00000004,
}

///Contains values that specify the type of certificate used to obtain a license.
alias WTS_CERT_TYPE = int;
enum : int
{
    ///The certificate is not valid.
    WTS_CERT_TYPE_INVALID     = 0x00000000,
    ///The certificate is a custom type.
    WTS_CERT_TYPE_PROPRIETORY = 0x00000001,
    ///The certificate adheres to the X.509 standard.
    WTS_CERT_TYPE_X509        = 0x00000002,
}

///Specifies the type of structure contained in the <b>WRdsConnectionSetting</b> member of the WRDS_CONNECTION_SETTINGS
///structure.
alias WRDS_CONNECTION_SETTING_LEVEL = int;
enum : int
{
    ///The type of structure is not defined.
    WRDS_CONNECTION_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_CONNECTION_SETTING_LEVEL_1       = 0x00000001,
}

///Used to specify the type of structure that is contained in the <b>WRdsListenerSetting</b> member of the
///WRDS_LISTENER_SETTINGS structure.
alias WRDS_LISTENER_SETTING_LEVEL = int;
enum : int
{
    ///The type of structure is not defined.
    WRDS_LISTENER_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_LISTENER_SETTING_LEVEL_1       = 0x00000001,
}

///Specifies the category of settings being stored in a WRDS_SETTINGS structure.
alias WRDS_SETTING_TYPE = int;
enum : int
{
    ///The setting type is not defined.
    WRDS_SETTING_TYPE_INVALID = 0x00000000,
    ///The settings apply to group policy for the computer.
    WRDS_SETTING_TYPE_MACHINE = 0x00000001,
    ///The settings apply to group policy for the user.
    WRDS_SETTING_TYPE_USER    = 0x00000002,
    WRDS_SETTING_TYPE_SAM     = 0x00000003,
}

///Specifies the status of a policy setting for various members of the WRDS_SETTINGS_1 structure.
alias WRDS_SETTING_STATUS = int;
enum : int
{
    ///The setting status has not been defined.
    WRDS_SETTING_STATUS_NOTAPPLICABLE = 0xffffffff,
    ///The setting is disabled.
    WRDS_SETTING_STATUS_DISABLED      = 0x00000000,
    ///The setting is enabled.
    WRDS_SETTING_STATUS_ENABLED       = 0x00000001,
    ///The setting is not configured.
    WRDS_SETTING_STATUS_NOTCONFIGURED = 0x00000002,
}

///Specifies the type of structure contained in the <b>WRdsSetting</b> member of the WRDS_SETTINGS structure.
alias WRDS_SETTING_LEVEL = int;
enum : int
{
    ///The type of structure is not defined.
    WRDS_SETTING_LEVEL_INVALID = 0x00000000,
    WRDS_SETTING_LEVEL_1       = 0x00000001,
}

alias __MIDL_IRemoteDesktopClientSettings_0001 = int;
enum : int
{
    PasswordEncodingUTF8    = 0x00000000,
    PasswordEncodingUTF16LE = 0x00000001,
    PasswordEncodingUTF16BE = 0x00000002,
}

///The action to send to the remote session.
enum RemoteActionType : int
{
    ///Displays the charms in the remote session.
    RemoteActionCharms      = 0x00000000,
    ///Displays the app bar in the remote session.
    RemoteActionAppbar      = 0x00000001,
    ///Docks the application in the remote session.
    RemoteActionSnap        = 0x00000002,
    ///Causes the start screen to be displayed in the remote session.
    RemoteActionStartScreen = 0x00000003,
    ///Causes the application switch window to be displayed in the remote session. This is the same as the user pressing
    ///Alt+Tab.
    RemoteActionAppSwitch   = 0x00000004,
}

///The type of encoding used for a Remote Desktop Protocol (RDP) app container client snapshot.
enum SnapshotEncodingType : int
{
    ///The snapshot will be taken and a data URI that contains the snapshot will be returned.
    SnapshotEncodingDataUri = 0x00000000,
}

///The data format used for a Remote Desktop Protocol (RDP) app container client snapshot.
enum SnapshotFormatType : int
{
    SnapshotFormatPng  = 0x00000000,
    SnapshotFormatJpeg = 0x00000001,
    SnapshotFormatBmp  = 0x00000002,
}

alias __MIDL_IRemoteDesktopClient_0001 = int;
enum : int
{
    KeyCombinationHome   = 0x00000000,
    KeyCombinationLeft   = 0x00000001,
    KeyCombinationUp     = 0x00000002,
    KeyCombinationRight  = 0x00000003,
    KeyCombinationDown   = 0x00000004,
    KeyCombinationScroll = 0x00000005,
}

// Callbacks

///An application-defined callback function that Remote Desktop Services calls to notify the client DLL of virtual
///channel events. The <b>PCHANNEL_INIT_EVENT_FN</b> type defines a pointer to this callback function.
///<b>VirtualChannelInitEvent</b> is a placeholder for the application-defined or library-defined function name.
///Params:
///    pInitHandle = Handle to the client connection. This is the handle returned in the <i>ppInitHandle</i> parameter of the
///                  VirtualChannelInit function.
///    event = Indicates the event that caused the notification. This parameter can be one of the following values.
///    pData = Pointer to additional data for the event. The type of data depends on the event, as described previously in the
///            event descriptions.
///    dataLength = Specifies the size, in bytes, of the data in the <i>pData</i> buffer.
///Returns:
///    This function does not return a value.
///    
alias CHANNEL_INIT_EVENT_FN = void function(void* pInitHandle, uint event, void* pData, uint dataLength);
alias PCHANNEL_INIT_EVENT_FN = void function();
///An application-defined callback function that Remote Desktop Services calls to notify the client DLL of events for a
///specific virtual channel. The <b>PCHANNEL_OPEN_EVENT_FN</b> type defines a pointer to this callback function.
///<b>VirtualChannelOpenEvent</b> is a placeholder for the application-defined or library-defined function name.
///Params:
///    openHandle = Handle to the virtual channel. This is the handle returned in the <i>pOpenHandle</i> parameter of the
///                 VirtualChannelOpen function.
///    event = Indicates the event that caused the notification. This parameter can be one of the following values.
///    pData = Pointer to additional data for the event. The type of data depends on the event, as described previously in the
///            event descriptions. If <i>event</i> is <b>CHANNEL_EVENT_DATA_RECEIVED</b>, the data written by the server is
///            broken into chunks of not more than <b>CHANNEL_CHUNK_LENGTH</b> bytes. The <i>dataFlags</i> parameter indicates
///            whether the current chunk is at the beginning, middle, or end of the block of data written by the server. Note
///            that the size of this parameter can be greater than the value specified by the <i>dataLength</i> parameter. The
///            application should read only the number of bytes specified by <i>dataLength</i>.
///    dataLength = Specifies the size, in bytes, of the data in the <i>pData</i> buffer.
///    totalLength = Specifies the total size, in bytes, of the data written by a single write operation to the server end of the
///                  virtual channel.
///    dataFlags = Provides information about the chunk of data being received in a <b>CHANNEL_EVENT_DATA_RECEIVED</b> event. The
///                following bit flags will be set. Note that you should not make direct comparisons using the '==' operator when
///                comparing the values in the following list; instead, use the comparison methods described.
///Returns:
///    This function has no return values.
///    
alias CHANNEL_OPEN_EVENT_FN = void function(uint openHandle, uint event, void* pData, uint dataLength, 
                                            uint totalLength, uint dataFlags);
alias PCHANNEL_OPEN_EVENT_FN = void function();
///Initializes a client DLL's access to Remote Desktop Services virtual channels. The client calls
///<b>VirtualChannelInit</b> to register the names of its virtual channels. Remote Desktop Services provides a pointer
///to a <b>VirtualChannelInit</b> function in the CHANNEL_ENTRY_POINTS structure passed to your VirtualChannelEntry
///entry point.
///Params:
///    ppInitHandle = Pointer to a variable that receives a handle that identifies the client connection. Use this handle to identify
///                   the client in subsequent calls to the VirtualChannelOpen function.
///    pChannel = Pointer to an array of CHANNEL_DEF structures. Each structure contains the name and initialization options of a
///               virtual channel that the client DLL will open. Note that the <b>VirtualChannelInit</b> call does not open these
///               virtual channels; it only reserves the names for use by this application.
///    channelCount = Specifies the number of entries in the <i>pChannel</i> array.
///    versionRequested = Specifies the level of virtual channel support. Set this parameter to <b>VIRTUAL_CHANNEL_VERSION_WIN2000</b>.
///    pChannelInitEventProc = Pointer to an application-defined VirtualChannelInitEvent function that Remote Desktop Services calls to notify
///                            the client DLL of virtual channel events.
///Returns:
///    If the function succeeds, the return value is <b>CHANNEL_RC_OK</b>. If an error occurs, the function returns one
///    of the following values.
///    
alias VIRTUALCHANNELINIT = uint function(void** ppInitHandle, CHANNEL_DEF* pChannel, int channelCount, 
                                         uint versionRequested, PCHANNEL_INIT_EVENT_FN pChannelInitEventProc);
alias PVIRTUALCHANNELINIT = uint function();
///Opens the client end of a virtual channel. Remote Desktop Services provides a pointer to a <b>VirtualChannelOpen</b>
///function in the CHANNEL_ENTRY_POINTS structure passed to your VirtualChannelEntry entry point.
///Params:
///    pInitHandle = Handle to the client connection. This is the handle returned in the <i>ppInitHandle</i> parameter of the
///                  VirtualChannelInit function.
///    pOpenHandle = Pointer to a variable that receives a handle that identifies the open virtual channel in subsequent calls to the
///                  VirtualChannelWrite and VirtualChannelClose functions.
///    pChannelName = Pointer to a null-terminated ANSI character string containing the name of the virtual channel to open. The name
///                   must have been registered when the client called the <b>VirtualChannelInit</b> function.
///    pChannelOpenEventProc = Pointer to an application-defined VirtualChannelOpenEvent function that Remote Desktop Services calls to notify
///                            the client DLL of events for this virtual channel.
///Returns:
///    If the function succeeds, the return value is CHANNEL_RC_OK. If an error occurs, the function returns one of the
///    following values.
///    
alias VIRTUALCHANNELOPEN = uint function(void* pInitHandle, uint* pOpenHandle, const(char)* pChannelName, 
                                         PCHANNEL_OPEN_EVENT_FN pChannelOpenEventProc);
alias PVIRTUALCHANNELOPEN = uint function();
///Closes the client end of a virtual channel. Remote Desktop Services provides a pointer to a
///<b>VirtualChannelClose</b> function in the CHANNEL_ENTRY_POINTS structure passed to your VirtualChannelEntry entry
///point.
///Params:
///    openHandle = Handle to the virtual channel. This is the handle returned in the <i>pOpenHandle</i> parameter of the
///                 VirtualChannelOpen function.
///Returns:
///    If the function succeeds, the return value is CHANNEL_RC_OK. If an error occurs, the function returns one of the
///    following values.
///    
alias VIRTUALCHANNELCLOSE = uint function(uint openHandle);
alias PVIRTUALCHANNELCLOSE = uint function();
///Sends data from the client end of a virtual channel to a partner application on the server end. Remote Desktop
///Services provides a pointer to a <b>VirtualChannelWrite</b> function in the CHANNEL_ENTRY_POINTS structure passed to
///your VirtualChannelEntry entry point.
///Params:
///    openHandle = Handle to the virtual channel. This is the handle returned in the <i>pOpenHandle</i> parameter of the
///                 VirtualChannelOpen function.
///    pData = Pointer to a buffer containing the data to write.
///    dataLength = Specifies the number of bytes of the data in the <i>pData</i> buffer to write.
///    pUserData = An application-defined value. This value is passed to your VirtualChannelOpenEvent function when the write
///                operation is completed or canceled.
///Returns:
///    If the function succeeds, the return value is CHANNEL_RC_OK. If an error occurs, the function returns one of the
///    following values.
///    
alias VIRTUALCHANNELWRITE = uint function(uint openHandle, void* pData, uint dataLength, void* pUserData);
alias PVIRTUALCHANNELWRITE = uint function();
///An application-defined entry point for the client-side DLL of an application that uses Remote Desktop Services
///virtual channels. Remote Desktop Services calls this entry point to pass a set of function pointers to the client
///DLL. The client calls these functions to work with virtual channels. Your <b>VirtualChannelEntry</b> implementation
///must call the VirtualChannelInit function to initialize access to virtual channels.
///Params:
///    pEntryPoints = Pointer to a CHANNEL_ENTRY_POINTS structure that contains pointers to the client-side virtual channel functions.
///                   This pointer is no longer valid after the <b>VirtualChannelEntry</b> function returns. You must make a copy of
///                   this structure in extension-allocated memory for later use.
///Returns:
///    Return <b>TRUE</b> if the function is successful. Return <b>FALSE</b> if an error occurs. In this case, Remote
///    Desktop Services unloads your DLL.
///    
alias VIRTUALCHANNELENTRY = BOOL function(CHANNEL_ENTRY_POINTS* pEntryPoints);
alias PVIRTUALCHANNELENTRY = BOOL function();

// Structs


alias HwtsVirtualChannelHandle = ptrdiff_t;

///Contains the dynamically changing connection properties.
struct APO_CONNECTION_PROPERTY
{
    ///A pointer to the connection buffer. Endpoints use this buffer to read and write audio data.
    size_t           pBuffer;
    ///The number of valid frames in the connection buffer. An APO uses the valid frame count to determine the amount of
    ///data to read and process in the input buffer. An APO sets the valid frame count after writing data into its
    ///output connection.
    uint             u32ValidFrameCount;
    ///The connection flags for this buffer. This indicates the validity status of the APOs. For more information about
    ///these flags, see APO_BUFFER_FLAGS.
    APO_BUFFER_FLAGS u32BufferFlags;
    ///A tag that identifies a valid <b>APO_CONNECTION_PROPERTY</b> structure. A valid structure is marked as
    ///<b>APO_CONNECTION_PROPERTY_SIGNATURE</b>.
    uint             u32Signature;
}

///Reports the current frame position from the device to the clients.
struct AE_CURRENT_POSITION
{
    ///The device position, in frames.
    ulong             u64DevicePosition;
    ///The stream position, in frames, used to determine the starting point for audio capture and the render device
    ///position relative to the stream.
    ulong             u64StreamPosition;
    ///The amount of padding, in frames, between the current position and the stream fill point.
    ulong             u64PaddingFrames;
    ///A translated quality performance counter (QPC) timer value taken at the time that the <b>u64DevicePosition</b>
    ///member was checked.
    long              hnsQPCPosition;
    ///The calculated data rate at the point at the time the position was set.
    float             f32FramesPerSecond;
    ///A value of the AE_POSITION_FLAGS enumeration that indicates the validity of the position information.
    AE_POSITION_FLAGS Flag;
}

///Provides information about the session change notification. A service receives this structure in its HandlerEx
///function in response to a session change event.
struct WTSSESSION_NOTIFICATION
{
    ///Size, in bytes, of this structure.
    uint cbSize;
    ///Session identifier that triggered the session change event.
    uint dwSessionId;
}

///This structure contains information about a connection event.
struct AAAccountingData
{
    ///The user name.
    BSTR          userName;
    ///The name of the client computer.
    BSTR          clientName;
    ///A value of the AAAuthSchemes enumeration type that specifies the type of authentication used to connect to RD
    ///Gateway.
    AAAuthSchemes authType;
    ///The name of the remote computer.
    BSTR          resourceName;
    ///The port number of the remote computer used by the connection.
    int           portNumber;
    ///The name of the protocol used by the connection.
    BSTR          protocolName;
    ///The number of bytes sent from the client to the remote computer.
    int           numberOfBytesReceived;
    ///The number of bytes sent from the remote computer to the client.
    int           numberOfBytesTransfered;
    ///The reason the connection was disconnected.
    BSTR          reasonForDisconnect;
    ///A unique identifier assigned to the connection by RD Gateway.
    GUID          mainSessionId;
    int           subSessionId;
}

///Contains information about a specific Remote Desktop Services server.
struct WTS_SERVER_INFOW
{
    ///Name of the server.
    const(wchar)* pServerName;
}

///Contains information about a specific Remote Desktop Services server.
struct WTS_SERVER_INFOA
{
    ///Name of the server.
    const(char)* pServerName;
}

///Contains information about a client session on a Remote Desktop Session Host (RD Session Host) server.
struct WTS_SESSION_INFOW
{
    ///Session identifier of the session.
    uint          SessionId;
    ///Pointer to a null-terminated string that contains the WinStation name of this session. The WinStation name is a
    ///name that Windows associates with the session, for example, "services", "console", or "RDP-Tcp
    const(wchar)* pWinStationName;
    ///A value from the WTS_CONNECTSTATE_CLASS enumeration type that indicates the session's current connection state.
    WTS_CONNECTSTATE_CLASS State;
}

///Contains information about a client session on a Remote Desktop Session Host (RD Session Host) server.
struct WTS_SESSION_INFOA
{
    ///Session identifier of the session.
    uint         SessionId;
    ///Pointer to a null-terminated string that contains the WinStation name of this session. The WinStation name is a
    ///name that Windows associates with the session, for example, "services", "console", or "RDP-Tcp
    const(char)* pWinStationName;
    ///A value from the WTS_CONNECTSTATE_CLASS enumeration type that indicates the session's current connection state.
    WTS_CONNECTSTATE_CLASS State;
}

///Contains extended information about a client session on a Remote Desktop Session Host (RD Session Host) server or
///Remote Desktop Virtualization Host (RD Virtualization Host) server.
struct WTS_SESSION_INFO_1W
{
    ///An identifier that uniquely identifies the session within the list of sessions returned by the
    ///WTSEnumerateSessionsEx function. For more information, see Remarks.
    uint          ExecEnvId;
    ///A value of the WTS_CONNECTSTATE_CLASS enumeration type that specifies the connection state of a Remote Desktop
    ///Services session.
    WTS_CONNECTSTATE_CLASS State;
    ///A session identifier assigned by the RD Session Host server, RD Virtualization Host server, or virtual machine.
    uint          SessionId;
    ///A pointer to a null-terminated string that contains the name of this session. For example, "services", "console",
    ///or "RDP-Tcp
    const(wchar)* pSessionName;
    ///A pointer to a null-terminated string that contains the name of the computer that the session is running on. If
    ///the session is running directly on an RD Session Host server or RD Virtualization Host server, the string
    ///contains <b>NULL</b>. If the session is running on a virtual machine, the string contains the name of the virtual
    ///machine.
    const(wchar)* pHostName;
    ///A pointer to a null-terminated string that contains the name of the user who is logged on to the session. If no
    ///user is logged on to the session, the string contains <b>NULL</b>.
    const(wchar)* pUserName;
    ///A pointer to a null-terminated string that contains the domain name of the user who is logged on to the session.
    ///If no user is logged on to the session, the string contains <b>NULL</b>.
    const(wchar)* pDomainName;
    ///A pointer to a null-terminated string that contains the name of the farm that the virtual machine is joined to.
    ///If the session is not running on a virtual machine that is joined to a farm, the string contains <b>NULL</b>.
    const(wchar)* pFarmName;
}

///Contains extended information about a client session on a Remote Desktop Session Host (RD Session Host) server or
///Remote Desktop Virtualization Host (RD Virtualization Host) server.
struct WTS_SESSION_INFO_1A
{
    ///An identifier that uniquely identifies the session within the list of sessions returned by the
    ///WTSEnumerateSessionsEx function. For more information, see Remarks.
    uint         ExecEnvId;
    ///A value of the WTS_CONNECTSTATE_CLASS enumeration type that specifies the connection state of a Remote Desktop
    ///Services session.
    WTS_CONNECTSTATE_CLASS State;
    ///A session identifier assigned by the RD Session Host server, RD Virtualization Host server, or virtual machine.
    uint         SessionId;
    ///A pointer to a null-terminated string that contains the name of this session. For example, "services", "console",
    ///or "RDP-Tcp
    const(char)* pSessionName;
    ///A pointer to a null-terminated string that contains the name of the computer that the session is running on. If
    ///the session is running directly on an RD Session Host server or RD Virtualization Host server, the string
    ///contains <b>NULL</b>. If the session is running on a virtual machine, the string contains the name of the virtual
    ///machine.
    const(char)* pHostName;
    ///A pointer to a null-terminated string that contains the name of the user who is logged on to the session. If no
    ///user is logged on to the session, the string contains <b>NULL</b>.
    const(char)* pUserName;
    ///A pointer to a null-terminated string that contains the domain name of the user who is logged on to the session.
    ///If no user is logged on to the session, the string contains <b>NULL</b>.
    const(char)* pDomainName;
    ///A pointer to a null-terminated string that contains the name of the farm that the virtual machine is joined to.
    ///If the session is not running on a virtual machine that is joined to a farm, the string contains <b>NULL</b>.
    const(char)* pFarmName;
}

///Contains information about a process running on a Remote Desktop Session Host (RD Session Host) server.
struct WTS_PROCESS_INFOW
{
    ///Remote Desktop Services session identifier for the session associated with the process.
    uint          SessionId;
    ///Process identifier that uniquely identifies the process on the RD Session Host server.
    uint          ProcessId;
    ///Pointer to a null-terminated string containing the name of the executable file associated with the process.
    const(wchar)* pProcessName;
    ///Pointer to the user Security Identifiers in the process's primary access token. For more information about SIDs
    ///and access tokens, see Access Control.
    void*         pUserSid;
}

///Contains information about a process running on a Remote Desktop Session Host (RD Session Host) server.
struct WTS_PROCESS_INFOA
{
    ///Remote Desktop Services session identifier for the session associated with the process.
    uint         SessionId;
    ///Process identifier that uniquely identifies the process on the RD Session Host server.
    uint         ProcessId;
    ///Pointer to a null-terminated string containing the name of the executable file associated with the process.
    const(char)* pProcessName;
    ///Pointer to the user Security Identifiers in the process's primary access token. For more information about SIDs
    ///and access tokens, see Access Control.
    void*        pUserSid;
}

///Contains information about a Remote Desktop Services session. This structure is returned by the
///WTSQuerySessionInformation function when you specify "WTSConfigInfo" for the <i>WTSInfoClass</i> parameter.
struct WTSCONFIGINFOW
{
    ///This member is reserved.
    uint        version_;
    ///This member is reserved.
    uint        fConnectClientDrivesAtLogon;
    ///This member is reserved.
    uint        fConnectPrinterAtLogon;
    ///Specifies whether the client can use printer redirection.
    uint        fDisablePrinterRedirection;
    ///Specifies whether the printer connected to the client is the default printer for the user.
    uint        fDisableDefaultMainClientPrinter;
    ///The remote control setting. Remote control allows a user to remotely monitor the on-screen operations of another
    ///user. This member can be one of the following values.
    uint        ShadowSettings;
    ///A null-terminated string that contains the user name used in automatic logon scenarios.
    ushort[21]  LogonUserName;
    ///A null-terminated string that contains the domain name used in automatic logon scenarios.
    ushort[18]  LogonDomain;
    ///A null-terminated string that contains the path of the working directory of the initial program.
    ushort[261] WorkDirectory;
    ///A null-terminated string that contains the name of the program to start immediately after the user logs on to the
    ///server.
    ushort[261] InitialProgram;
    ///This member is reserved.
    ushort[261] ApplicationName;
}

///Contains information about a Remote Desktop Services session. This structure is returned by the
///WTSQuerySessionInformation function when you specify "WTSConfigInfo" for the <i>WTSInfoClass</i> parameter.
struct WTSCONFIGINFOA
{
    ///This member is reserved.
    uint      version_;
    ///This member is reserved.
    uint      fConnectClientDrivesAtLogon;
    ///This member is reserved.
    uint      fConnectPrinterAtLogon;
    ///Specifies whether the client can use printer redirection.
    uint      fDisablePrinterRedirection;
    ///Specifies whether the printer connected to the client is the default printer for the user.
    uint      fDisableDefaultMainClientPrinter;
    ///The remote control setting. Remote control allows a user to remotely monitor the on-screen operations of another
    ///user. This member can be one of the following values.
    uint      ShadowSettings;
    ///A null-terminated string that contains the user name used in automatic logon scenarios.
    byte[21]  LogonUserName;
    ///A null-terminated string that contains the domain name used in automatic logon scenarios.
    byte[18]  LogonDomain;
    ///A null-terminated string that contains the path of the working directory of the initial program.
    byte[261] WorkDirectory;
    ///A null-terminated string that contains the name of the program to start immediately after the user logs on to the
    ///server.
    byte[261] InitialProgram;
    ///This member is reserved.
    byte[261] ApplicationName;
}

///Contains information about a Remote Desktop Services session.
struct WTSINFOW
{
    ///A value of the WTS_CONNECTSTATE_CLASS enumeration type that indicates the session's current connection state.
    WTS_CONNECTSTATE_CLASS State;
    ///The session identifier.
    uint          SessionId;
    ///Uncompressed Remote Desktop Protocol (RDP) data from the client to the server.
    uint          IncomingBytes;
    ///Uncompressed RDP data from the server to the client.
    uint          OutgoingBytes;
    ///The number of frames of RDP data sent from the client to the server since the client connected.
    uint          IncomingFrames;
    ///The number of frames of RDP data sent from the server to the client since the client connected.
    uint          OutgoingFrames;
    ///Compressed RDP data from the client to the server.
    uint          IncomingCompressedBytes;
    ///Compressed RDP data from the server to the client.
    uint          OutgoingCompressedBytes;
    ///A null-terminated string that contains the name of the WinStation for the session.
    ushort[32]    WinStationName;
    ///A null-terminated string that contains the name of the domain that the user belongs to.
    ushort[17]    Domain;
    ///A null-terminated string that contains the name of the user who owns the session.
    ushort[21]    UserName;
    ///The most recent client connection time.
    LARGE_INTEGER ConnectTime;
    ///The last client disconnection time.
    LARGE_INTEGER DisconnectTime;
    ///The time of the last user input in the session.
    LARGE_INTEGER LastInputTime;
    ///The time that the user logged on to the session.
    LARGE_INTEGER LogonTime;
    ///The time that the <b>WTSINFO</b> data structure was called.
    LARGE_INTEGER CurrentTime;
}

///Contains information about a Remote Desktop Services session.
struct WTSINFOA
{
    ///A value of the WTS_CONNECTSTATE_CLASS enumeration type that indicates the session's current connection state.
    WTS_CONNECTSTATE_CLASS State;
    ///The session identifier.
    uint          SessionId;
    ///Uncompressed Remote Desktop Protocol (RDP) data from the client to the server.
    uint          IncomingBytes;
    ///Uncompressed RDP data from the server to the client.
    uint          OutgoingBytes;
    ///The number of frames of RDP data sent from the client to the server since the client connected.
    uint          IncomingFrames;
    ///The number of frames of RDP data sent from the server to the client since the client connected.
    uint          OutgoingFrames;
    ///Compressed RDP data from the client to the server.
    uint          IncomingCompressedBytes;
    uint          OutgoingCompressedBy;
    ///A null-terminated string that contains the name of the WinStation for the session.
    byte[32]      WinStationName;
    ///A null-terminated string that contains the name of the domain that the user belongs to.
    byte[17]      Domain;
    ///A null-terminated string that contains the name of the user who owns the session.
    byte[21]      UserName;
    ///The most recent client connection time.
    LARGE_INTEGER ConnectTime;
    ///The last client disconnection time.
    LARGE_INTEGER DisconnectTime;
    ///The time of the last user input in the session.
    LARGE_INTEGER LastInputTime;
    ///The time that the user logged on to the session.
    LARGE_INTEGER LogonTime;
    ///The time that the <b>WTSINFO</b> data structure was called.
    LARGE_INTEGER CurrentTime;
}

///Contains extended information about a Remote Desktop Services session.
struct WTSINFOEX_LEVEL1_W
{
    ///The session identifier.
    uint          SessionId;
    ///A value of the WTS_CONNECTSTATE_CLASS enumeration type that specifies the connection state of a Remote Desktop
    ///Services session.
    WTS_CONNECTSTATE_CLASS SessionState;
    ///The state of the session. This can be one or more of the following values.
    int           SessionFlags;
    ///A null-terminated string that contains the name of the window station for the session.
    ushort[33]    WinStationName;
    ///A null-terminated string that contains the name of the user who owns the session.
    ushort[21]    UserName;
    ///A null-terminated string that contains the name of the domain that the user belongs to.
    ushort[18]    DomainName;
    ///The time that the user logged on to the session. This value is stored as a large integer that represents the
    ///number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time (Greenwich Mean Time).
    LARGE_INTEGER LogonTime;
    ///The time of the most recent client connection to the session. This value is stored as a large integer that
    ///represents the number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER ConnectTime;
    ///The time of the most recent client disconnection to the session. This value is stored as a large integer that
    ///represents the number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER DisconnectTime;
    ///The time of the last user input in the session. This value is stored as a large integer that represents the
    ///number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER LastInputTime;
    ///The time that this structure was filled. This value is stored as a large integer that represents the number of
    ///100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER CurrentTime;
    ///The number of bytes of uncompressed Remote Desktop Protocol (RDP) data sent from the client to the server since
    ///the client connected.
    uint          IncomingBytes;
    ///The number of bytes of uncompressed RDP data sent from the server to the client since the client connected.
    uint          OutgoingBytes;
    ///The number of frames of RDP data sent from the client to the server since the client connected.
    uint          IncomingFrames;
    ///The number of frames of RDP data sent from the server to the client since the client connected.
    uint          OutgoingFrames;
    ///The number of bytes of compressed RDP data sent from the client to the server since the client connected.
    uint          IncomingCompressedBytes;
    ///The number of bytes of compressed RDP data sent from the server to the client since the client connected.
    uint          OutgoingCompressedBytes;
}

///Contains extended information about a Remote Desktop Services session.
struct WTSINFOEX_LEVEL1_A
{
    ///The session identifier.
    uint          SessionId;
    ///A value of the WTS_CONNECTSTATE_CLASS enumeration type that specifies the connection state of a Remote Desktop
    ///Services session.
    WTS_CONNECTSTATE_CLASS SessionState;
    ///The state of the session. This can be one or more of the following values.
    int           SessionFlags;
    ///A null-terminated string that contains the name of the window station for the session.
    byte[33]      WinStationName;
    ///A null-terminated string that contains the name of the user who owns the session.
    byte[21]      UserName;
    ///A null-terminated string that contains the name of the domain that the user belongs to.
    byte[18]      DomainName;
    ///The time that the user logged on to the session. This value is stored as a large integer that represents the
    ///number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time (Greenwich Mean Time).
    LARGE_INTEGER LogonTime;
    ///The time of the most recent client connection to the session. This value is stored as a large integer that
    ///represents the number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER ConnectTime;
    ///The time of the most recent client disconnection to the session. This value is stored as a large integer that
    ///represents the number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER DisconnectTime;
    ///The time of the last user input in the session. This value is stored as a large integer that represents the
    ///number of 100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER LastInputTime;
    ///The time that this structure was filled. This value is stored as a large integer that represents the number of
    ///100-nanosecond intervals since January 1, 1601 Coordinated Universal Time.
    LARGE_INTEGER CurrentTime;
    ///The number of bytes of uncompressed Remote Desktop Protocol (RDP) data sent from the client to the server since
    ///the client connected.
    uint          IncomingBytes;
    ///The number of bytes of uncompressed RDP data sent from the server to the client since the client connected.
    uint          OutgoingBytes;
    ///The number of frames of RDP data sent from the client to the server since the client connected.
    uint          IncomingFrames;
    ///The number of frames of RDP data sent from the server to the client since the client connected.
    uint          OutgoingFrames;
    ///The number of bytes of compressed RDP data sent from the client to the server since the client connected.
    uint          IncomingCompressedBytes;
    ///The number of bytes of compressed RDP data sent from the server to the client since the client connected.
    uint          OutgoingCompressedBytes;
}

///Contains a WTSINFOEX_LEVEL1 structure that contains extended information about a Remote Desktop Services session.
union WTSINFOEX_LEVEL_W
{
    ///A WTSINFOEX_LEVEL1 structure that contains extended session information.
    WTSINFOEX_LEVEL1_W WTSInfoExLevel1;
}

///Contains a WTSINFOEX_LEVEL1 structure that contains extended information about a Remote Desktop Services session.
union WTSINFOEX_LEVEL_A
{
    ///A WTSINFOEX_LEVEL1 structure that contains extended session information.
    WTSINFOEX_LEVEL1_A WTSInfoExLevel1;
}

///Contains a WTSINFOEX_LEVEL union that contains extended information about a Remote Desktop Services session. This
///structure is returned by the WTSQuerySessionInformation function when you specify "WTSSessionInfoEx" for the
///<i>WTSInfoClass</i> parameter.
struct WTSINFOEXW
{
    ///Specifies the level of information contained in the <b>Data</b> member. This can be the following value.
    uint              Level;
    ///A WTSINFOEX_LEVEL union. The type of structure contained here is specified by the <b>Level</b> member.
    WTSINFOEX_LEVEL_W Data;
}

///Contains a WTSINFOEX_LEVEL union that contains extended information about a Remote Desktop Services session. This
///structure is returned by the WTSQuerySessionInformation function when you specify "WTSSessionInfoEx" for the
///<i>WTSInfoClass</i> parameter.
struct WTSINFOEXA
{
    ///Specifies the level of information contained in the <b>Data</b> member. This can be the following value.
    uint              Level;
    ///A WTSINFOEX_LEVEL union. The type of structure contained here is specified by the <b>Level</b> member.
    WTSINFOEX_LEVEL_A Data;
}

///Contains information about a Remote Desktop Connection (RDC) client.
struct WTSCLIENTW
{
    ///The NetBIOS name of the client computer.
    ushort[21]  ClientName;
    ///The domain name of the client computer.
    ushort[18]  Domain;
    ///The client user name.
    ushort[21]  UserName;
    ///The folder for the initial program.
    ushort[261] WorkDirectory;
    ///The program to start on connection.
    ushort[261] InitialProgram;
    ///The security level of encryption.
    ubyte       EncryptionLevel;
    ///The address family. This member can be <b>AF_INET</b>, <b>AF_INET6</b>, <b>AF_IPX</b>, <b>AF_NETBIOS</b>, or
    ///<b>AF_UNSPEC</b>.
    uint        ClientAddressFamily;
    ///The client network address.
    ushort[31]  ClientAddress;
    ///Horizontal dimension, in pixels, of the client's display.
    ushort      HRes;
    ///Vertical dimension, in pixels, of the client's display.
    ushort      VRes;
    ///Color depth of the client's display. For possible values, see the <b>ColorDepth</b> member of the
    ///WTS_CLIENT_DISPLAY structure.
    ushort      ColorDepth;
    ///The location of the client ActiveX control DLL.
    ushort[261] ClientDirectory;
    ///The client build number.
    uint        ClientBuildNumber;
    ///Reserved.
    uint        ClientHardwareId;
    ///Reserved.
    ushort      ClientProductId;
    ///The number of output buffers on the server per session.
    ushort      OutBufCountHost;
    ///The number of output buffers on the client.
    ushort      OutBufCountClient;
    ///The length of the output buffers, in bytes.
    ushort      OutBufLength;
    ///The device ID of the network adapter.
    ushort[261] DeviceId;
}

///Contains information about a Remote Desktop Connection (RDC) client.
struct WTSCLIENTA
{
    ///The NetBIOS name of the client computer.
    byte[21]   ClientName;
    ///The domain name of the client computer.
    byte[18]   Domain;
    ///The client user name.
    byte[21]   UserName;
    ///The folder for the initial program.
    byte[261]  WorkDirectory;
    ///The program to start on connection.
    byte[261]  InitialProgram;
    ///The security level of encryption.
    ubyte      EncryptionLevel;
    ///The address family. This member can be <b>AF_INET</b>, <b>AF_INET6</b>, <b>AF_IPX</b>, <b>AF_NETBIOS</b>, or
    ///<b>AF_UNSPEC</b>.
    uint       ClientAddressFamily;
    ///The client network address.
    ushort[31] ClientAddress;
    ///Horizontal dimension, in pixels, of the client's display.
    ushort     HRes;
    ///Vertical dimension, in pixels, of the client's display.
    ushort     VRes;
    ///Color depth of the client's display. For possible values, see the <b>ColorDepth</b> member of the
    ///WTS_CLIENT_DISPLAY structure.
    ushort     ColorDepth;
    ///The location of the client ActiveX control DLL.
    byte[261]  ClientDirectory;
    ///The client build number.
    uint       ClientBuildNumber;
    ///Reserved.
    uint       ClientHardwareId;
    ///Reserved.
    ushort     ClientProductId;
    ///The number of output buffers on the server per session.
    ushort     OutBufCountHost;
    ///The number of output buffers on the client.
    ushort     OutBufCountClient;
    ///The length of the output buffers, in bytes.
    ushort     OutBufLength;
    ///The device ID of the network adapter.
    byte[261]  DeviceId;
}

struct _WTS_PRODUCT_INFOA
{
    byte[256] CompanyName;
    byte[4]   ProductID;
}

struct _WTS_PRODUCT_INFOW
{
    ushort[256] CompanyName;
    ushort[4]   ProductID;
}

struct WTS_VALIDATION_INFORMATIONA
{
    _WTS_PRODUCT_INFOA ProductInfo;
    ubyte[16384]       License;
    uint               LicenseLength;
    ubyte[20]          HardwareID;
    uint               HardwareIDLength;
}

struct WTS_VALIDATION_INFORMATIONW
{
    _WTS_PRODUCT_INFOW ProductInfo;
    ubyte[16384]       License;
    uint               LicenseLength;
    ubyte[20]          HardwareID;
    uint               HardwareIDLength;
}

///Contains the client network address of a Remote Desktop Services session.
struct WTS_CLIENT_ADDRESS
{
    ///Address family. This member can be <b>AF_INET</b>, <b>AF_INET6</b>, <b>AF_IPX</b>, <b>AF_NETBIOS</b>, or
    ///<b>AF_UNSPEC</b>.
    uint      AddressFamily;
    ///Client network address. The format of the field of <b>Address</b> depends on the address type as specified by the
    ///<b>AddressFamily</b> member. For an address family <b>AF_INET</b>: <b>Address </b> contains the IPV4 address of
    ///the client as a null-terminated string. For an family <b>AF_INET6</b>: <b>Address </b> contains the IPV6 address
    ///of the client as raw byte values. (For example, the address "FFFF::1" would be represented as the following
    ///series of byte values: "0xFF 0xFF 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x01")
    ubyte[20] Address;
}

///Contains information about the display of a Remote Desktop Connection (RDC) client.
struct WTS_CLIENT_DISPLAY
{
    ///Horizontal dimension, in pixels, of the client's display.
    uint HorizontalResolution;
    ///Vertical dimension, in pixels, of the client's display.
    uint VerticalResolution;
    ///Color depth of the client's display. This member can be one of the following values.
    uint ColorDepth;
}

///Contains configuration information for a user on a domain controller or Remote Desktop Session Host (RD Session Host)
///server. This structure is used by the WTSQueryUserConfig and WTSSetUserConfig functions.
struct WTSUSERCONFIGA
{
    ///A value of the WTS_CONFIG_SOURCE enumeration type that specifies the source of configuration information returned
    ///by the WTSQueryUserConfig function.
    uint      Source;
    ///A value that indicates whether the client can specify the initial program. This member can be one of the
    ///following values.
    uint      InheritInitialProgram;
    ///A value that indicates whether the user account is permitted to log on to an RD Session Host server. This member
    ///can be one of the following values.
    uint      AllowLogonTerminalServer;
    ///The maximum connection duration, in milliseconds. One minute before the connection expires, the server notifies
    ///the user about the pending disconnection. When the connection times out, the server takes the action specified by
    ///the <b>BrokenTimeoutSettings</b> member. Every time the user logs on, the timer is reset. A value of zero
    ///indicates that the connection timer is disabled.
    uint      TimeoutSettingsConnections;
    ///The maximum duration, in milliseconds, that the server retains a disconnected session before the logon is
    ///terminated. A value of zero indicates that the disconnection timer is disabled.
    uint      TimeoutSettingsDisconnections;
    ///The amount of time, in milliseconds, that a connection can remain idle. If there is no keyboard or mouse activity
    ///for this period of time, the server takes the action specified by the <b>BrokenTimeoutSettings</b> member. A
    ///value of zero indicates that the idle timer is disabled.
    uint      TimeoutSettingsIdle;
    ///This member is reserved.
    uint      DeviceClientDrives;
    ///A value that indicates whether the server automatically connects to previously mapped client printers when the
    ///user logs on to the server. This member can be one of the following values.
    uint      DeviceClientPrinters;
    ///A value that indicates whether the client printer is the default printer. This member can be one of the following
    ///values.
    uint      ClientDefaultPrinter;
    ///The action the server takes when the connection or idle timers expire, or when a connection is lost due to a
    ///connection error. This member can be one of the following values.
    uint      BrokenTimeoutSettings;
    ///A value that indicates how a disconnected session for this user can be reconnected. This member can be one of the
    ///following values.
    uint      ReconnectSettings;
    ///The remote control setting. Remote control allows a user to remotely monitor the on-screen operations of another
    ///user. This member can be one of the following values.
    uint      ShadowingSettings;
    ///A value that indicates whether the <b>TerminalServerHomeDir</b> member contains a path to a local directory or a
    ///network share. You cannot set this member by using the WTSSetUserConfig function. This member can be one of the
    ///following values.
    uint      TerminalServerRemoteHomeDir;
    ///A null-terminated string that contains the name of the program to start immediately after the user logs on to the
    ///server.
    byte[261] InitialProgram;
    ///A null-terminated string that contains the path of the working directory for the initial program.
    byte[261] WorkDirectory;
    ///A null-terminated string that contains the profile path that is assigned to the user when the user connects to
    ///the server. The directory specified by the path must be created manually, and must exist prior to the logon.
    byte[261] TerminalServerProfilePath;
    ///A null-terminated string that contains the path to the home folder of the user's Remote Desktop Services
    ///sessions. The folder can be a local folder or a network share.
    byte[261] TerminalServerHomeDir;
    ///A null-terminated string that contains the drive name (a drive letter followed by a colon) to which the path
    ///specified in the <b>TerminalServerHomeDir</b> member is mapped. This member is only valid when the
    ///<b>TerminalServerRemoteHomeDir</b> member is set to one.
    byte[4]   TerminalServerHomeDirDrive;
}

///Contains configuration information for a user on a domain controller or Remote Desktop Session Host (RD Session Host)
///server. This structure is used by the WTSQueryUserConfig and WTSSetUserConfig functions.
struct WTSUSERCONFIGW
{
    ///A value of the WTS_CONFIG_SOURCE enumeration type that specifies the source of configuration information returned
    ///by the WTSQueryUserConfig function.
    uint        Source;
    ///A value that indicates whether the client can specify the initial program. This member can be one of the
    ///following values.
    uint        InheritInitialProgram;
    ///A value that indicates whether the user account is permitted to log on to an RD Session Host server. This member
    ///can be one of the following values.
    uint        AllowLogonTerminalServer;
    ///The maximum connection duration, in milliseconds. One minute before the connection expires, the server notifies
    ///the user about the pending disconnection. When the connection times out, the server takes the action specified by
    ///the <b>BrokenTimeoutSettings</b> member. Every time the user logs on, the timer is reset. A value of zero
    ///indicates that the connection timer is disabled.
    uint        TimeoutSettingsConnections;
    ///The maximum duration, in milliseconds, that the server retains a disconnected session before the logon is
    ///terminated. A value of zero indicates that the disconnection timer is disabled.
    uint        TimeoutSettingsDisconnections;
    ///The amount of time, in milliseconds, that a connection can remain idle. If there is no keyboard or mouse activity
    ///for this period of time, the server takes the action specified by the <b>BrokenTimeoutSettings</b> member. A
    ///value of zero indicates that the idle timer is disabled.
    uint        TimeoutSettingsIdle;
    ///This member is reserved.
    uint        DeviceClientDrives;
    ///A value that indicates whether the server automatically connects to previously mapped client printers when the
    ///user logs on to the server. This member can be one of the following values.
    uint        DeviceClientPrinters;
    ///A value that indicates whether the client printer is the default printer. This member can be one of the following
    ///values.
    uint        ClientDefaultPrinter;
    ///The action the server takes when the connection or idle timers expire, or when a connection is lost due to a
    ///connection error. This member can be one of the following values.
    uint        BrokenTimeoutSettings;
    ///A value that indicates how a disconnected session for this user can be reconnected. This member can be one of the
    ///following values.
    uint        ReconnectSettings;
    ///The remote control setting. Remote control allows a user to remotely monitor the on-screen operations of another
    ///user. This member can be one of the following values.
    uint        ShadowingSettings;
    ///A value that indicates whether the <b>TerminalServerHomeDir</b> member contains a path to a local directory or a
    ///network share. You cannot set this member by using the WTSSetUserConfig function. This member can be one of the
    ///following values.
    uint        TerminalServerRemoteHomeDir;
    ///A null-terminated string that contains the name of the program to start immediately after the user logs on to the
    ///server.
    ushort[261] InitialProgram;
    ///A null-terminated string that contains the path of the working directory for the initial program.
    ushort[261] WorkDirectory;
    ///A null-terminated string that contains the profile path that is assigned to the user when the user connects to
    ///the server. The directory specified by the path must be created manually, and must exist prior to the logon.
    ushort[261] TerminalServerProfilePath;
    ///A null-terminated string that contains the path to the home folder of the user's Remote Desktop Services
    ///sessions. The folder can be a local folder or a network share.
    ushort[261] TerminalServerHomeDir;
    ///A null-terminated string that contains the drive name (a drive letter followed by a colon) to which the path
    ///specified in the <b>TerminalServerHomeDir</b> member is mapped. This member is only valid when the
    ///<b>TerminalServerRemoteHomeDir</b> member is set to one.
    ushort[4]   TerminalServerHomeDirDrive;
}

///Contains the virtual IP address assigned to a session. This structure is returned by the WTSQuerySessionInformation
///function when you specify "WTSSessionAddressV4" for the <i>WTSInfoClass</i> parameter.
struct WTS_SESSION_ADDRESS
{
    ///A null-terminated string that contains the address family. Always set this member to "AF_INET".
    uint      AddressFamily;
    ///The virtual IP address assigned to the session. The format of this address is identical to that used in the
    ///WTS_CLIENT_ADDRESS structure.
    ubyte[20] Address;
}

///Contains extended information about a process running on a Remote Desktop Session Host (RD Session Host) server. This
///structure is returned by the WTSEnumerateProcessesEx function when you set the <i>pLevel</i> parameter to one.
struct WTS_PROCESS_INFO_EXW
{
    ///The Remote Desktop Services session identifier for the session associated with the process.
    uint          SessionId;
    ///The process identifier that uniquely identifies the process on the RD Session Host server.
    uint          ProcessId;
    ///A pointer to a null-terminated string that contains the name of the executable file associated with the process.
    const(wchar)* pProcessName;
    ///A pointer to the user security identifiers (SIDs) in the primary access token of the process. For more
    ///information about SIDs and access tokens, see Access Control and Security Identifiers.
    void*         pUserSid;
    ///The number of threads in the process.
    uint          NumberOfThreads;
    ///The number of handles in the process.
    uint          HandleCount;
    ///The page file usage of the process, in bytes.
    uint          PagefileUsage;
    ///The peak page file usage of the process, in bytes.
    uint          PeakPagefileUsage;
    ///The working set size of the process, in bytes.
    uint          WorkingSetSize;
    ///The peak working set size of the process, in bytes.
    uint          PeakWorkingSetSize;
    ///The amount of time, in milliseconds, the process has been running in user mode.
    LARGE_INTEGER UserTime;
    ///The amount of time, in milliseconds, the process has been running in kernel mode.
    LARGE_INTEGER KernelTime;
}

///Contains extended information about a process running on a Remote Desktop Session Host (RD Session Host) server. This
///structure is returned by the WTSEnumerateProcessesEx function when you set the <i>pLevel</i> parameter to one.
struct WTS_PROCESS_INFO_EXA
{
    ///The Remote Desktop Services session identifier for the session associated with the process.
    uint          SessionId;
    ///The process identifier that uniquely identifies the process on the RD Session Host server.
    uint          ProcessId;
    ///A pointer to a null-terminated string that contains the name of the executable file associated with the process.
    const(char)*  pProcessName;
    ///A pointer to the user security identifiers (SIDs) in the primary access token of the process. For more
    ///information about SIDs and access tokens, see Access Control and Security Identifiers.
    void*         pUserSid;
    ///The number of threads in the process.
    uint          NumberOfThreads;
    ///The number of handles in the process.
    uint          HandleCount;
    ///The page file usage of the process, in bytes.
    uint          PagefileUsage;
    ///The peak page file usage of the process, in bytes.
    uint          PeakPagefileUsage;
    ///The working set size of the process, in bytes.
    uint          WorkingSetSize;
    ///The peak working set size of the process, in bytes.
    uint          PeakWorkingSetSize;
    ///The amount of time, in milliseconds, the process has been running in user mode.
    LARGE_INTEGER UserTime;
    ///The amount of time, in milliseconds, the process has been running in kernel mode.
    LARGE_INTEGER KernelTime;
}

///Contains information about a Remote Desktop Services listener. This structure is used by the WTSCreateListener
///function.
struct WTSLISTENERCONFIGW
{
    ///This member is reserved.
    uint        version_;
    ///Specifies whether the listener is enabled. This member can be one of the following values.
    uint        fEnableListener;
    ///The maximum number of active connections that the listener accepts.
    uint        MaxConnectionCount;
    ///Specifies whether the listener always prompts the user for a password. This member can be one of the following
    ///values.
    uint        fPromptForPassword;
    ///Specifies whether the listener should use the color depth specified by the user. This member can be one of the
    ///following values.
    uint        fInheritColorDepth;
    ///The color depth setting for the listener. This setting only applies when the <b>fInheritColorDepth</b> member is
    ///zero. This can be one of the following values.
    uint        ColorDepth;
    ///Specifies whether the listener should use the <b>BrokenTimeoutSettings</b> value specified by the user. This
    ///member can be one of the following values.
    uint        fInheritBrokenTimeoutSettings;
    ///The action the listener takes when a connection or idle timer expires, or when a connection is lost due to a
    ///connection error. This setting only applies when the <b>fInheritBrokenTimeoutSettings</b> member is zero. This
    ///member can be one of the following values.
    uint        BrokenTimeoutSettings;
    ///Specifies whether printer redirection is disabled. This member can be one of the following values.
    uint        fDisablePrinterRedirection;
    ///Specifies whether drive redirection is disabled. This member can be one of the following values.
    uint        fDisableDriveRedirection;
    ///Specifies whether COM port redirection is disabled. This member can be one of the following values.
    uint        fDisableComPortRedirection;
    ///Specifies whether LPT port redirection is disabled. This member can be one of the following values.
    uint        fDisableLPTPortRedirection;
    ///Specifies whether clipboard redirection is disabled. This member can be one of the following values.
    uint        fDisableClipboardRedirection;
    ///Specifies whether audio redirection is disabled. This member can be one of the following values.
    uint        fDisableAudioRedirection;
    ///Specifies whether Plug and Play redirection is disabled. This member can be one of the following values.
    uint        fDisablePNPRedirection;
    ///Specifies whether the client printer is the default printer. This member can be one of the following values.
    uint        fDisableDefaultMainClientPrinter;
    ///The network adapter that the listener uses.
    uint        LanAdapter;
    ///The port number of the listener.
    uint        PortNumber;
    ///Specifies whether the listener should use the <b>ShadowSettings</b> value specified by the user. This member can
    ///be one of the following values.
    uint        fInheritShadowSettings;
    ///The remote control setting for the listener. Remote control allows a user to remotely monitor the on-screen
    ///operations of another user. This setting only applies when the <b>fInheritShadowSettings</b> member is zero. This
    ///member can be one of the following values.
    uint        ShadowSettings;
    ///The maximum connection duration, in milliseconds. Every time the user logs on, the timer is reset. A value of
    ///zero indicates that the connection timer is disabled.
    uint        TimeoutSettingsConnection;
    ///The maximum duration, in milliseconds, that a server retains a disconnected session before the logon is
    ///terminated. A value of zero indicates that the disconnection timer is disabled.
    uint        TimeoutSettingsDisconnection;
    ///The maximum idle time, in milliseconds. A value of zero indicates that the idle timer is disabled.
    uint        TimeoutSettingsIdle;
    ///The security layer of the listener. This member can be one of the following values.
    uint        SecurityLayer;
    ///Encryption level of the listener. This member can be one of the following values.
    uint        MinEncryptionLevel;
    ///Specifies whether network-level user authentication is required before the connection is established. This member
    ///can be one of the following values.
    uint        UserAuthentication;
    ///A null-terminated string that contains a description of the listener.
    ushort[61]  Comment;
    ///A null-terminated string that contains the user name used in automatic logon scenarios.
    ushort[21]  LogonUserName;
    ///A null-terminated string that contains the domain name used in automatic logon scenarios.
    ushort[18]  LogonDomain;
    ///A null-terminated string that contains the path of the working directory of the initial program.
    ushort[261] WorkDirectory;
    ///A null-terminated string that contains the name of the program to start immediately after the user logs on to the
    ///server.
    ushort[261] InitialProgram;
}

///Contains information about a Remote Desktop Services listener. This structure is used by the WTSCreateListener
///function.
struct WTSLISTENERCONFIGA
{
    ///This member is reserved.
    uint      version_;
    ///Specifies whether the listener is enabled. This member can be one of the following values.
    uint      fEnableListener;
    ///The maximum number of active connections that the listener accepts.
    uint      MaxConnectionCount;
    ///Specifies whether the listener always prompts the user for a password. This member can be one of the following
    ///values.
    uint      fPromptForPassword;
    ///Specifies whether the listener should use the color depth specified by the user. This member can be one of the
    ///following values.
    uint      fInheritColorDepth;
    ///The color depth setting for the listener. This setting only applies when the <b>fInheritColorDepth</b> member is
    ///zero. This can be one of the following values.
    uint      ColorDepth;
    ///Specifies whether the listener should use the <b>BrokenTimeoutSettings</b> value specified by the user. This
    ///member can be one of the following values.
    uint      fInheritBrokenTimeoutSettings;
    ///The action the listener takes when a connection or idle timer expires, or when a connection is lost due to a
    ///connection error. This setting only applies when the <b>fInheritBrokenTimeoutSettings</b> member is zero. This
    ///member can be one of the following values.
    uint      BrokenTimeoutSettings;
    ///Specifies whether printer redirection is disabled. This member can be one of the following values.
    uint      fDisablePrinterRedirection;
    ///Specifies whether drive redirection is disabled. This member can be one of the following values.
    uint      fDisableDriveRedirection;
    ///Specifies whether COM port redirection is disabled. This member can be one of the following values.
    uint      fDisableComPortRedirection;
    ///Specifies whether LPT port redirection is disabled. This member can be one of the following values.
    uint      fDisableLPTPortRedirection;
    ///Specifies whether clipboard redirection is disabled. This member can be one of the following values.
    uint      fDisableClipboardRedirection;
    ///Specifies whether audio redirection is disabled. This member can be one of the following values.
    uint      fDisableAudioRedirection;
    ///Specifies whether Plug and Play redirection is disabled. This member can be one of the following values.
    uint      fDisablePNPRedirection;
    ///Specifies whether the client printer is the default printer. This member can be one of the following values.
    uint      fDisableDefaultMainClientPrinter;
    ///The network adapter that the listener uses.
    uint      LanAdapter;
    ///The port number of the listener.
    uint      PortNumber;
    ///Specifies whether the listener should use the <b>ShadowSettings</b> value specified by the user. This member can
    ///be one of the following values.
    uint      fInheritShadowSettings;
    ///The remote control setting for the listener. Remote control allows a user to remotely monitor the on-screen
    ///operations of another user. This setting only applies when the <b>fInheritShadowSettings</b> member is zero. This
    ///member can be one of the following values.
    uint      ShadowSettings;
    ///The maximum connection duration, in milliseconds. Every time the user logs on, the timer is reset. A value of
    ///zero indicates that the connection timer is disabled.
    uint      TimeoutSettingsConnection;
    ///The maximum duration, in milliseconds, that a server retains a disconnected session before the logon is
    ///terminated. A value of zero indicates that the disconnection timer is disabled.
    uint      TimeoutSettingsDisconnection;
    ///The maximum idle time, in milliseconds. A value of zero indicates that the idle timer is disabled.
    uint      TimeoutSettingsIdle;
    ///The security layer of the listener. This member can be one of the following values.
    uint      SecurityLayer;
    ///Encryption level of the listener. This member can be one of the following values.
    uint      MinEncryptionLevel;
    ///Specifies whether network-level user authentication is required before the connection is established. This member
    ///can be one of the following values.
    uint      UserAuthentication;
    ///A null-terminated string that contains a description of the listener.
    byte[61]  Comment;
    ///A null-terminated string that contains the user name used in automatic logon scenarios.
    byte[21]  LogonUserName;
    ///A null-terminated string that contains the domain name used in automatic logon scenarios.
    byte[18]  LogonDomain;
    ///A null-terminated string that contains the path of the working directory of the initial program.
    byte[261] WorkDirectory;
    ///A null-terminated string that contains the name of the program to start immediately after the user logs on to the
    ///server.
    byte[261] InitialProgram;
}

///Contains information about the IP address of a network resource.
struct WTSSBX_IP_ADDRESS
{
    ///A value of the WTSSBX_ADDRESS_FAMILY enumeration type that indicates the address family of the network address.
    WTSSBX_ADDRESS_FAMILY AddressFamily;
    ///The network address of the resource.
    ubyte[16] Address;
    ///The port number of the resource that is configured for Remote Desktop Protocol (RDP).
    ushort    PortNumber;
    ///The scope of the address. This member is used only for IPv6 addresses.
    uint      dwScope;
}

///Contains information about a computer that is accepting remote connections.
struct WTSSBX_MACHINE_CONNECT_INFO
{
    ///The fully qualified domain name (FQDN) of the computer. The name cannot exceed 256 characters.
    ushort[257] wczMachineFQDN;
    ///The NetBIOS name of the computer. The name cannot exceed 16 characters.
    ushort[17]  wczMachineNetBiosName;
    ///The number of IP addresses that are configured on the computer.
    uint        dwNumOfIPAddr;
    ///An array of WTSSBX_IP_ADDRESS structures that indicate the IP addresses on this computer that are visible to
    ///Remote Desktop Connection (RDC) clients. This array cannot exceed 12 elements.
    WTSSBX_IP_ADDRESS[12] IPaddr;
}

///Contains information about a computer and its current state.
struct WTSSBX_MACHINE_INFO
{
    ///A WTSSBX_MACHINE_CONNECT_INFO structure that contains information about the computer.
    WTSSBX_MACHINE_CONNECT_INFO ClientConnectInfo;
    ///A Unicode string that contains the name of the farm in RD Connection Broker that this computer belongs to. This
    ///string cannot exceed 256 characters.
    ushort[257]          wczFarmName;
    ///A WTSSBX_IP_ADDRESS structure that contains the internal IP address of this computer. RD Connection Broker uses
    ///this IP address for redirection purposes.
    WTSSBX_IP_ADDRESS    InternalIPAddress;
    ///The maximum number of sessions that this computer can accept.
    uint                 dwMaxSessionsLimit;
    ///The server weight value of this computer. RD Connection Broker uses this value for load balancing.
    uint                 ServerWeight;
    ///A value of the WTSSBX_MACHINE_SESSION_MODE enumeration type that indicates the computer's session mode.
    WTSSBX_MACHINE_SESSION_MODE SingleSessionMode;
    ///A value of the WTSSBX_MACHINE_DRAIN enumeration type that indicates whether the computer is accepting new user
    ///sessions.
    WTSSBX_MACHINE_DRAIN InDrain;
    ///A value of the WTSSBX_MACHINE_STATE enumeration type that indicates the state of the computer.
    WTSSBX_MACHINE_STATE MachineState;
}

///Contains information about sessions that are available to Remote Desktop Connection Broker (RD Connection Broker).
struct WTSSBX_SESSION_INFO
{
    ///The user name that is associated with the session. The name cannot exceed 104 characters.
    ushort[105]          wszUserName;
    ///The domain name of the user. The name cannot exceed 256 characters.
    ushort[257]          wszDomainName;
    ///The name of the program that should be run after the session is created. The name cannot exceed 256 characters.
    ushort[257]          ApplicationType;
    ///The session identifier.
    uint                 dwSessionId;
    ///The time that the session was initiated.
    FILETIME             CreateTime;
    ///The time that the user disconnected from the session.
    FILETIME             DisconnectTime;
    ///A value of the WTSSBX_SESSION_STATE enumeration type that indicates the state of the session.
    WTSSBX_SESSION_STATE SessionState;
}

struct CHANNEL_DEF
{
align (1):
    byte[8] name;
    uint    options;
}

///Contains information about a data block being received by the server end of a virtual channel.
struct CHANNEL_PDU_HEADER
{
    ///Size, in bytes, of the data block, excluding this header.
    uint length;
    ///Information about the data block. The following bit flags will be set. Note that you should not make direct
    ///comparisons using the '==' operator when comparing the values in the following list; instead, use the comparison
    ///methods described in the list.
    uint flags;
}

///Contains pointers to the functions called by a client-side DLL to access virtual channels.Remote Desktop Services
///calls your VirtualChannelEntry function to pass this structure.
struct CHANNEL_ENTRY_POINTS
{
    ///Size, in bytes, of this structure.
    uint                 cbSize;
    ///Protocol version. Remote Desktop Services sets this member to <b>VIRTUAL_CHANNEL_VERSION_WIN2000</b>.
    uint                 protocolVersion;
    ///Pointer to a VirtualChannelInit function.
    PVIRTUALCHANNELINIT  pVirtualChannelInit;
    ///Pointer to a VirtualChannelOpen function.
    PVIRTUALCHANNELOPEN  pVirtualChannelOpen;
    ///Pointer to a VirtualChannelClose function.
    PVIRTUALCHANNELCLOSE pVirtualChannelClose;
    ///Pointer to a VirtualChannelWrite function.
    PVIRTUALCHANNELWRITE pVirtualChannelWrite;
}

///Contains information about the display of a Remote Desktop Connection (RDC) client.
struct CLIENT_DISPLAY
{
    ///The horizontal dimension, in pixels, of the client's display.
    uint HorizontalResolution;
    ///The vertical dimension, in pixels, of the client's display.
    uint VerticalResolution;
    uint ColorDepth;
}

///Defines the IP address of a target.
struct TSSD_ConnectionPoint
{
    ///The server address.
    ubyte[16]        ServerAddressB;
    ///A value of the TSSD_AddrV46Type enumeration that indicates the IP address type.
    TSSD_AddrV46Type AddressType;
    ///The IP port number.
    ushort           PortNumber;
    ///The scope of the address.
    uint             AddressScope;
}

struct VM_NOTIFY_ENTRY
{
    ushort[128] VmName;
    ushort[128] VmHost;
}

struct VM_PATCH_INFO
{
    uint     dwNumEntries;
    ushort** pVmNames;
}

struct VM_NOTIFY_INFO
{
    uint              dwNumEntries;
    VM_NOTIFY_ENTRY** ppVmEntries;
}

///Contains information about a resource that can be assigned to users in RemoteApp and Desktop Connection.
struct pluginResource
{
    ///The alias of the resource.
    ushort[256] alias_;
    ///The name of the resource.
    ushort[256] name;
    ///The contents of the resource file. The plug-in should allocate memory for this member by calling the
    ///CoTaskMemAlloc function.
    ushort*     resourceFileContents;
    ///The file name extension of the resource file. If this member is set to ".rdp", RD Web Access opens the file by
    ///using the ActiveX control.
    ushort[256] fileExtension;
    ///A unique identifier that identifies the resource plug-in.
    ushort[256] resourcePluginType;
    ///A Boolean value that indicates whether the resource should be displayed in RD Web Access or RemoteApp and Desktop
    ///Connections.
    ubyte       isDiscoverable;
    ///The type of resource.
    int         resourceType;
    ///The size, in bytes, of the icon.
    uint        pceIconSize;
    ///A byte array that defines the icon to be displayed for the resource.
    ubyte*      iconContents;
    ///The size, in bytes, of the <b>blobContents</b> member.
    uint        pcePluginBlobSize;
    ///This member is reserved. Set it to <b>NULL</b>.
    ubyte*      blobContents;
}

///Contains information about a file association in RemoteApp and Desktop Connection.
struct pluginResource2FileAssociation
{
    ///A null-terminated string that contains the file name extension. The length of this string is limited to
    ///<b>MAX_FILE_ASSOC_EXTENSION_SIZE</b> characters, including the terminating <b>NULL</b> character.
    ushort[256] extName;
    ///Indicates if this is the primary handler for the file association.
    ubyte       primaryHandler;
    ///The size, in bytes, of the <b>iconContents</b> buffer.
    uint        pceIconSize;
    ///A byte array that contains the icon to display for files with the specified extension.
    ubyte*      iconContents;
}

///Contains additional information about a resource that can be assigned to users in RemoteApp and Desktop Connection.
struct pluginResource2
{
    ///A pluginResource structure that contains the basic information about the resource.
    pluginResource resourceV1;
    ///Reserved for future use. This member must be zero.
    uint           pceFileAssocListSize;
    ///Reserved for future use. This member must be <b>NULL</b>.
    pluginResource2FileAssociation* fileAssocList;
    ///A string representation of a security descriptor used to specify the domain users and groups that have access to
    ///the resource. For more information about security descriptor strings, see Security Descriptor String Format.
    ushort*        securityDescriptor;
    ///The number of strings in the <b>folderList</b> array.
    uint           pceFolderListSize;
    ///An array of pointers to null-terminated strings that contain the names of the folders that the resource should be
    ///displayed in. You must use the CoTaskMemAlloc function to allocate these strings. The caller is responsible for
    ///freeing these strings.
    ushort**       folderList;
}

///Contains statistics for the RemoteFX media redirection bitmap renderer.
struct BITMAP_RENDERER_STATISTICS
{
    ///The number of frames delivered.
    uint dwFramesDelivered;
    ///The number of frames dropped.
    uint dwFramesDropped;
}

struct RFX_GFX_RECT
{
align (1):
    int left;
    int top;
    int right;
    int bottom;
}

struct RFX_GFX_MSG_HEADER
{
align (1):
    ushort uMSGType;
    ushort cbSize;
}

struct RFX_GFX_MONITOR_INFO
{
align (1):
    int  left;
    int  top;
    int  right;
    int  bottom;
    uint physicalWidth;
    uint physicalHeight;
    uint orientation;
    BOOL primary;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_RESPONSE
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               reserved;
    uint               monitorCount;
    RFX_GFX_MONITOR_INFO[16] MonitorData;
    ushort[32]         clientUniqueId;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_NOTIFY
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               ulWidth;
    uint               ulHeight;
    uint               ulBpp;
    uint               Reserved;
}

struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_CONFIRM
{
    RFX_GFX_MSG_HEADER channelHdr;
}

struct RFX_GFX_MSG_DESKTOP_INPUT_RESET
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               ulWidth;
    uint               ulHeight;
}

struct RFX_GFX_MSG_DISCONNECT_NOTIFY
{
align (1):
    RFX_GFX_MSG_HEADER channelHdr;
    uint               DisconnectReason;
}

struct RFX_GFX_MSG_DESKTOP_RESEND_REQUEST
{
    RFX_GFX_MSG_HEADER channelHdr;
    RFX_GFX_RECT       RedrawRect;
}

struct RFX_GFX_MSG_RDP_DATA
{
    RFX_GFX_MSG_HEADER channelHdr;
    ubyte[1]           rdpData;
}

///Contains a socket address.
struct WTS_SOCKADDR
{
    ///An integer index into the following structure members.
    ushort sin_family;
    union u
    {
        struct ipv4
        {
            ushort   sin_port;
            uint     in_addr;
            ubyte[8] sin_zero;
        }
        struct ipv6
        {
            ushort    sin6_port;
            uint      sin6_flowinfo;
            ushort[8] sin6_addr;
            uint      sin6_scope_id;
        }
    }
}

///Contains client window coordinates.
struct WTS_SMALL_RECT
{
    ///Specifies the upper left x-coordinate.
    short Left;
    ///Specifies the upper left y-coordinate.
    short Top;
    ///Specifies the lower right x-coordinate.
    short Right;
    ///Specifies the lower right y-coordinate.
    short Bottom;
}

///Contains information about changes in the state of the Remote Desktop Services service.
struct WTS_SERVICE_STATE
{
    ///A value of the WTS_RCM_SERVICE_STATE enumeration type that specifies whether the service is starting or stopping.
    WTS_RCM_SERVICE_STATE RcmServiceState;
    ///A value of the WTS_RCM_DRAIN_STATE enumeration type that specifies whether the RD Session Host server is changing
    ///its drain state.
    WTS_RCM_DRAIN_STATE RcmDrainState;
}

///Contains a <b>GUID</b> that uniquely identifies a session.
struct WTS_SESSION_ID
{
    ///A GUID that specifies the client connection.
    GUID SessionUniqueGuid;
    ///An integer that specifies the session associated with the client connection.
    uint SessionId;
}

///Contains credential information for a user. This structure is used by the GetUserCredentials method.
struct WTS_USER_CREDENTIAL
{
    ///A string that contains the name of the user.
    ushort[256] UserName;
    ///A string that contains the user password.
    ushort[256] Password;
    ///A string that contains the domain name for the user.
    ushort[256] Domain;
}

///Specifies date and time information for transitions between standard time and daylight saving time.
struct WTS_SYSTEMTIME
{
    ///The year from 1601 to 30827.
    ushort wYear;
    ///The month when transition from standard to daylight saving time occurs. This can be one of the following values.
    ushort wMonth;
    ///The day of the week when the transition occurs. This can be one of the following values.
    ushort wDayOfWeek;
    ///The day of the month when the transition occurs.
    ushort wDay;
    ///The hour when the transition occurs.
    ushort wHour;
    ///The minute when the transition occurs.
    ushort wMinute;
    ///The second when the transition occurs.
    ushort wSecond;
    ushort wMilliseconds;
}

///Contains client time zone information.
struct WTS_TIME_ZONE_INFORMATION
{
    ///An integer that contains the bias for local time translation. Bias is the difference, in minutes, between
    ///Coordinated Universal Time (Greenwich Mean Time) and local time.
    int            Bias;
    ///A string that contains a descriptive name for standard time on the client. Examples include "Pacific Standard
    ///Time".
    ushort[32]     StandardName;
    ///A WTS_SYSTEMTIME structure that contains the date and local time when the transition from daylight saving time to
    ///standard time occurs on the client. If this field is specified, the <b>DaylightDate</b> member should also be
    ///specified.
    WTS_SYSTEMTIME StandardDate;
    ///An integer that defines the bias, in minutes, to be used during local time translations that occur during
    ///standard time. This value is added to the value of the <b>Bias</b> member to form the bias used during standard
    ///time. In most time zones, the value of this field is zero.
    int            StandardBias;
    ///A string that contains a descriptive name for daylight saving time on the client. Examples include "Pacific
    ///Daylight Time".
    ushort[32]     DaylightName;
    ///A WTS_SYSTEMTIME structure that contains the date and local time when the transition from standard time to
    ///daylight saving time occurs on the client. If this field is specified, the <b>StandardDate</b> member should also
    ///be specified.
    WTS_SYSTEMTIME DaylightDate;
    int            DaylightBias;
}

///Contains dynamic time zone information.
struct WRDS_DYNAMIC_TIME_ZONE_INFORMATION
{
    ///An integer that contains the bias for local time translation. Bias is the difference, in minutes, between
    ///Coordinated Universal Time (Greenwich Mean Time) and local time.
    int            Bias;
    ///A string that contains a descriptive name for standard time on the client. Examples include "Pacific Standard
    ///Time".
    ushort[32]     StandardName;
    ///A WTS_SYSTEMTIME structure that contains the date and local time when the transition from daylight saving time to
    ///standard time occurs on the client. If this field is specified, the <b>DaylightDate</b> member should also be
    ///specified.
    WTS_SYSTEMTIME StandardDate;
    ///An integer that defines the bias, in minutes, to be used during local time translations that occur during
    ///standard time. This value is added to the value of the <b>Bias</b> member to form the bias used during standard
    ///time. In most time zones, the value of this field is zero.
    int            StandardBias;
    ///A string that contains a descriptive name for daylight saving time on the client. Examples include "Pacific
    ///Daylight Time".
    ushort[32]     DaylightName;
    ///A WTS_SYSTEMTIME structure that contains the date and local time when the transition from standard time to
    ///daylight saving time occurs on the client. If this field is specified, the <b>StandardDate</b> member should also
    ///be specified.
    WTS_SYSTEMTIME DaylightDate;
    ///An integer that defines the bias, in minutes, to be used during local time translations that occur during
    ///daylight saving time. This value is added to the value of the <b>Bias</b> member to form the bias used during
    ///daylight saving time. In most time zones, the value of this field is 60.
    int            DaylightBias;
    ///Key name for the TimeZone information.
    ushort[128]    TimeZoneKeyName;
    ///Whether DynamicDaylightTime is disabled.
    ushort         DynamicDaylightTimeDisabled;
}

///Contains information about the client connection.
struct WTS_CLIENT_DATA
{
    ///Specifies whether the logon (CTRL+ALT+DELETE) key sequence is disabled.
    ubyte        fDisableCtrlAltDel;
    ///Specifies whether the client can double-click.
    ubyte        fDoubleClickDetect;
    ///Specifies whether the Windows key is enabled.
    ubyte        fEnableWindowsKey;
    ///Specifies whether the title bar is hidden.
    ubyte        fHideTitleBar;
    ///Specifies whether the logon process is automatic. This value overwrites the <b>fInheritAutoLogon</b> listener
    ///registry value.
    BOOL         fInheritAutoLogon;
    ///Specifies whether to prompt the user for a password. If this value is <b>TRUE</b>, the user will be prompted even
    ///if the <b>fInheritAutoLogon</b> registry value is <b>TRUE</b> and the "Always ask for a password" policy is not
    ///set.
    ubyte        fPromptForPassword;
    ///Specifies whether the client is using saved credentials during the logon process.
    ubyte        fUsingSavedCreds;
    ///A string value that specifies the domain of the user. This value is used if <b>fInheritAutoLogon</b> is set to
    ///<b>TRUE</b>.
    ushort[256]  Domain;
    ///A string value that specifies the user name. This value is used if <b>fInheritAutoLogon</b> is set to
    ///<b>TRUE</b>.
    ushort[256]  UserName;
    ///A string value that specifies the user password. This value is used if <b>fInheritAutoLogon</b> is set to
    ///<b>TRUE</b>.
    ushort[256]  Password;
    ///Specifies that a smart card was used during the logon process. The smart card PIN is the password. This value is
    ///used if <b>fInheritAutoLogon</b> is set to <b>TRUE</b>.
    ubyte        fPasswordIsScPin;
    ///Specifies whether the initial program to start in the Remote Desktop Services shell is inherited. This value
    ///overwrites the <b>fInheritInitialProgram</b> listener registry value.
    BOOL         fInheritInitialProgram;
    ///A string value that specifies the directory where the initial program resides. This value is used if
    ///<b>fInheritInitialProgram</b> is set to <b>TRUE</b>.
    ushort[257]  WorkDirectory;
    ///A string value that specifies the name of the initial program. This value is used if
    ///<b>fInheritInitialProgram</b> is set to <b>TRUE</b>.
    ushort[257]  InitialProgram;
    ///Specifies whether the initial program is displayed maximized. This value is used if <b>fInheritInitialProgram</b>
    ///is set to <b>TRUE</b>.
    ubyte        fMaximizeShell;
    ///Specifies the encryption level.
    ubyte        EncryptionLevel;
    ///Specifies a list of features that can be disabled to increase performance.
    uint         PerformanceFlags;
    ///A string value that contains the protocol name.
    ushort[9]    ProtocolName;
    ///Specifies the protocol type.
    ushort       ProtocolType;
    ///Specifies whether to inherit the monitor color depth. This value overwrites the <b>fInheritColorDepth</b>
    ///listener registry value.
    BOOL         fInheritColorDepth;
    ///Specifies the client monitor horizontal resolution.
    ushort       HRes;
    ///Specifies the client monitor vertical resolution.
    ushort       VRes;
    ///Specifies the client monitor color depth. For possible values, see the <b>ColorDepth</b> member of the
    ///WTS_CLIENT_DISPLAY structure.
    ushort       ColorDepth;
    ///A string value that specifies the name of the display driver to load.
    ushort[9]    DisplayDriverName;
    ///A string value that specifies the name of the display device. For example, if a protocol creates a display device
    ///with the name "\\Device\VideoDev0", this field must contain the string "VideoDev".
    ushort[20]   DisplayDeviceName;
    ///Specifies whether mouse input is enabled.
    ubyte        fMouse;
    ///Specifies the keyboard layout.
    uint         KeyboardLayout;
    ///Specifies the keyboard type.
    uint         KeyboardType;
    ///Specifies the keyboard subtype.
    uint         KeyboardSubType;
    ///Specifies the function key.
    uint         KeyboardFunctionKey;
    ///Specifies the input method editor name.
    ushort[33]   imeFileName;
    ///Specifies the input locale identifier. The low word contains a language identifier and the high word contains a
    ///device handle to the physical layout of the keyboard.
    uint         ActiveInputLocale;
    ///Specifies whether to turn on audio. A value of <b>TRUE</b> specifies no audio.
    ubyte        fNoAudioPlayback;
    ///Specifies whether to leave audio playback on the remote computer.
    ubyte        fRemoteConsoleAudio;
    ///A string value that contains the name of the audio driver to load.
    ushort[9]    AudioDriverName;
    ///A WTS_TIME_ZONE_INFORMATION structure that contains client time zone information.
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    ///A string value that contains the fully qualified name of the client computer.
    ushort[21]   ClientName;
    ///Client computer serial number.
    uint         SerialNumber;
    ///The client IP address family.
    uint         ClientAddressFamily;
    ///A string value that contains the client IP address in dotted decimal format.
    ushort[31]   ClientAddress;
    ///A WTS_SOCKADDR structure that contains information about the client socket.
    WTS_SOCKADDR ClientSockAddress;
    ///A string value that contains the client directory.
    ushort[257]  ClientDirectory;
    ///Client build number.
    uint         ClientBuildNumber;
    ///Client product ID.
    ushort       ClientProductId;
    ///Number of output buffers on the host computer.
    ushort       OutBufCountHost;
    ///Number of output buffers on the client computer.
    ushort       OutBufCountClient;
    ///Output buffer length.
    ushort       OutBufLength;
    ///Client session ID.
    uint         ClientSessionId;
    ///A string value that contains a client product identifier.
    ushort[33]   ClientDigProductId;
    ///Specifies whether printer mapping is enabled. This value is initially set from policy information. If you reset
    ///the value, the policy will be overwritten.
    ubyte        fDisableCpm;
    ///Specifies whether drive mapping is enabled. This value is initially set from policy information. If you reset the
    ///value, the policy will be overwritten.
    ubyte        fDisableCdm;
    ///Specifies whether COM port mapping is enabled. This value is initially set from policy information. If you reset
    ///the value, the policy will be overwritten.
    ubyte        fDisableCcm;
    ///Specifies whether LPT printer redirection is enabled. This value is initially set from policy information. If you
    ///reset the value, the policy will be overwritten.
    ubyte        fDisableLPT;
    ///Specifies whether clipboard redirection is enabled. This value is initially set from policy information. If you
    ///reset the value, the policy will be overwritten.
    ubyte        fDisableClip;
    ubyte        fDisablePNP;
}

///Contains select client property values.
struct WTS_USER_DATA
{
    ///A string value that specifies the directory where the client startup program resides. This value corresponds to
    ///the <b>WorkDirectory</b> member of the WTS_CLIENT_DATA structure.
    ushort[257] WorkDirectory;
    ///A string value that specifies the name of the initial program. This value corresponds to the
    ///<b>InitialProgram</b> member of the WTS_CLIENT_DATA structure.
    ushort[257] InitialProgram;
    ///A WTS_TIME_ZONE_INFORMATION structure that contains client time zone information. This value corresponds to the
    ///<b>ClientTimeZone</b> member of the WTS_CLIENT_DATA structure.
    WTS_TIME_ZONE_INFORMATION UserTimeZone;
}

///Contains policy information that is passed by the Remote Desktop Services service to the protocol.
struct WTS_POLICY_DATA
{
    ///Specifies whether to disable encryption for communication between the client and server.
    ubyte fDisableEncryption;
    ///Specifies whether to disable automatic reconnect of the client.
    ubyte fDisableAutoReconnect;
    ///Specifies the monitor color depth policy. This can be one of the following values.
    uint  ColorDepth;
    ///Specifies the minimum permitted encryption level.
    ubyte MinEncryptionLevel;
    ///Specifies whether to disable printer mapping.
    ubyte fDisableCpm;
    ///Specifies whether to disable drive mapping.
    ubyte fDisableCdm;
    ///Specifies whether to disable COM communication port mapping.
    ubyte fDisableCcm;
    ///Specifies whether to disable LPT (line print terminal) printer redirection.
    ubyte fDisableLPT;
    ///Specifies whether to disable clipboard redirection.
    ubyte fDisableClip;
    ///Specifies whether to disable Plug and Play redirection.
    ubyte fDisablePNPRedir;
}

///Contains the number of cache reads and cache hits.
struct WTS_PROTOCOL_CACHE
{
    ///An integer that contains the number of times cached data was read.
    uint CacheReads;
    uint CacheHits;
}

///Contains cache statistics.
union WTS_CACHE_STATS_UN
{
    ///A WTS_PROTOCOL_CACHE structure that contains information about the number of times that requested data is found
    ///in and read from the cache.
    WTS_PROTOCOL_CACHE[4] ProtocolCache;
    ///Share cache statistics.
    uint     TShareCacheStats;
    ///Reserved protocol specific data. The maximum size, in bytes, of this data is WTS_MAX_CACHE_RESERVED multiplied by
    ///the length of an unsigned long integer.
    uint[20] Reserved;
}

///Contains protocol cache statistics.
struct WTS_CACHE_STATS
{
    ///An integer index that specifies the WTS_CACHE_STATS_UN union member that contains the cache data. This can be one
    ///of the following values.
    uint               Specific;
    ///A WTS_CACHE_STATS_UN union that contains the cache statistics.
    WTS_CACHE_STATS_UN Data;
    ///An integer that specifies the protocol type. This is not currently used by the Remote Desktop Services service.
    ushort             ProtocolType;
    ///An integer that contains the length of the data in the <b>Reserved</b> member of the WTS_CACHE_STATS_UN union.
    ///The maximum size is WTS_MAX_CACHE_RESERVED multiplied by the length of an unsigned long integer.
    ushort             Length;
}

///Contains protocol performance counters.
struct WTS_PROTOCOL_COUNTERS
{
    ///The number of bytes sent and received.
    uint      WdBytes;
    ///The number of frames sent and received.
    uint      WdFrames;
    ///The number of times the protocol waited for an output buffer to become available.
    uint      WaitForOutBuf;
    ///Transport driver number of frames sent and received.
    uint      Frames;
    ///Transport driver number of bytes sent and received.
    uint      Bytes;
    ///The number of compressed bytes.
    uint      CompressedBytes;
    ///The number of compressed flushes. A compressed flush occurs when compression for a packet fails and is replaced
    ///by the original uncompressed packet.
    uint      CompressFlushes;
    ///The number of packets that were in error during the session.
    uint      Errors;
    ///The number of timeouts during the session.
    uint      Timeouts;
    ///The number of asynchronous framing errors during the session.
    uint      AsyncFramingError;
    ///The number of asynchronous overrun errors during the session.
    uint      AsyncOverrunError;
    ///The number of asynchronous overflow errors during the session.
    uint      AsyncOverflowError;
    ///The number of asynchronous parity errors during the session.
    uint      AsyncParityError;
    ///The number of transport protocol errors during the session.
    uint      TdErrors;
    ///The type of the protocol.
    ushort    ProtocolType;
    ///The length of data in the <b>Reserved</b> field.
    ushort    Length;
    ///Specifies the type of counter that can be queried. This can be <b>TShareCounters</b> or <b>Reserved</b>.
    ushort    Specific;
    ///An array of protocol specific data. The maximum length can be WTS_MAX_RESERVED multiplied by the size of an
    ///unsigned long integer.
    uint[100] Reserved;
}

///Contains information about the status of the protocol.
struct WTS_PROTOCOL_STATUS
{
    ///A WTS_PROTOCOL_COUNTERS structure that contains the output protocol counters.
    WTS_PROTOCOL_COUNTERS Output;
    ///A WTS_PROTOCOL_COUNTERS structure that contains the input protocol counters.
    WTS_PROTOCOL_COUNTERS Input;
    ///A WTS_CACHE_STATS structure that contains protocol cache statistics.
    WTS_CACHE_STATS    Cache;
    ///An integer that identifies an asynchronous signal for asynchronous protocols.
    uint               AsyncSignal;
    ///An asynchronous signal mask.
    uint               AsyncSignalMask;
    ///An array of up to 100 counters.
    LARGE_INTEGER[100] Counters;
}

///Contains information about the client display.
struct WTS_DISPLAY_IOCTL
{
    ///A byte array that contains information about the client display.
    ubyte[256] pDisplayIOCtlData;
    uint       cbDisplayIOCtlData;
}

///Contains information about a property value to retrieve from the protocol. The <b>WTS_PROPERTY_VALUE</b> structure is
///used by the QueryProperty method.
struct WTS_PROPERTY_VALUE
{
    ///An integer that specifies which member of the union contains the property value information. This can be one of
    ///the following values.
    ushort Type;
    union u
    {
        uint ulVal;
        struct strVal
        {
            uint    size;
            ushort* pstrVal;
        }
        struct bVal
        {
            uint  size;
            byte* pbVal;
        }
        GUID guidVal;
    }
}

///Contains information about the licensing capabilities of the client.
struct WTS_LICENSE_CAPABILITIES
{
    ///Contains an integer that specifies the encryption algorithm. This can be one of the following values.
    uint          KeyExchangeAlg;
    ///An integer that specifies the supported licensing protocol. This must be
    ///<b>WTS_LICENSE_CURRENT_PROTOCOL_VERSION</b>.
    uint          ProtocolVer;
    ///A Boolean value that specifies whether the client will authenticate the server.
    BOOL          fAuthenticateServer;
    ///A WTS_CERT_TYPE enumeration value that specifies the type of the certificate used to obtain the license.
    WTS_CERT_TYPE CertType;
    ///An integer that contains the size, in bytes, of the client name specified by the <b>rgbClientName</b> member.
    uint          cbClientName;
    ///The client name, including a terminating null character.
    ubyte[42]     rgbClientName;
}

///Contains listener settings for a remote session.
struct WRDS_LISTENER_SETTINGS_1
{
    ///The maximum number of protocol listener connections allowed. <b>ULONG_MAX</b> specifies the maximum number of
    ///connections.
    uint   MaxProtocolListenerConnectionCount;
    uint   SecurityDescriptorSize;
    ubyte* pSecurityDescriptor;
}

///Contains different levels of listener settings for a remote desktop connection.
union WRDS_LISTENER_SETTING
{
    ///A WRDS_LISTENER_SETTINGS_1 structure.
    WRDS_LISTENER_SETTINGS_1 WRdsListenerSettings1;
}

///Contains listener setting information for a remote session.
struct WRDS_LISTENER_SETTINGS
{
    ///A value of the WRDS_LISTENER_SETTING_LEVEL enumeration that specifies the type of structure that is contained in
    ///the <b>WRdsListenerSetting</b> member.
    WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel;
    WRDS_LISTENER_SETTING WRdsListenerSetting;
}

///Contains connection setting information for a remote session.
struct WRDS_CONNECTION_SETTINGS_1
{
    ///Specifies whether the initial program to start in the Remote Desktop Services shell is inherited. This value
    ///overwrites the <b>fInheritInitialProgram</b> listener registry value.
    ubyte        fInheritInitialProgram;
    ///Specifies whether to inherit the monitor color depth. This value overwrites the <b>fInheritColorDepth</b>
    ///listener registry value.
    ubyte        fInheritColorDepth;
    ///Specifies whether the title bar is hidden.
    ubyte        fHideTitleBar;
    ///Specifies whether the logon process is automatic. This value overwrites the <b>fInheritAutoLogon</b> listener
    ///registry value.
    ubyte        fInheritAutoLogon;
    ///Specifies whether the initial program is displayed maximized. This value is used if <b>fInheritInitialProgram</b>
    ///is set to <b>TRUE</b>.
    ubyte        fMaximizeShell;
    ///Specifies whether PNP redirection is enabled. This value is initially set from policy information. If you reset
    ///the value, the policy will be overwritten.
    ubyte        fDisablePNP;
    ///Specifies that a smart card was used during the logon process. The smart card PIN is the password. This value is
    ///used if <b>fInheritAutoLogon</b> is set to <b>TRUE</b>.
    ubyte        fPasswordIsScPin;
    ///Specifies whether to prompt the user for a password. If this value is <b>TRUE</b>, the user will be prompted even
    ///if the <b>fInheritAutoLogon</b> registry value is <b>TRUE</b> and the "Always ask for a password" policy is not
    ///set.
    ubyte        fPromptForPassword;
    ///Specifies whether printer mapping is enabled. This value is initially set from policy information. If you reset
    ///the value, the policy will be overwritten.
    ubyte        fDisableCpm;
    ///Specifies whether drive mapping is enabled. This value is initially set from policy information. If you reset the
    ///value, the policy will be overwritten.
    ubyte        fDisableCdm;
    ///Specifies whether COM port mapping is enabled. This value is initially set from policy information. If you reset
    ///the value, the policy will be overwritten.
    ubyte        fDisableCcm;
    ///Specifies whether LPT printer redirection is enabled. This value is initially set from policy information. If you
    ///reset the value, the policy will be overwritten.
    ubyte        fDisableLPT;
    ///Specifies whether clipboard redirection is enabled. This value is initially set from policy information. If you
    ///reset the value, the policy will be overwritten.
    ubyte        fDisableClip;
    ///Specifies the action the server takes when the connection or idle timers expire, or when a connection is lost due
    ///to a connection error.
    ubyte        fResetBroken;
    ///Specifies whether to disable encryption for communication between the client and server.
    ubyte        fDisableEncryption;
    ///Specifies whether to disable automatic reconnect of the client.
    ubyte        fDisableAutoReconnect;
    ///Specifies whether the Ctrl+Alt+Delete keyboard shortcut is disabled.
    ubyte        fDisableCtrlAltDel;
    ///Specifies whether the client can double-click.
    ubyte        fDoubleClickDetect;
    ///Specifies whether the Windows key is enabled.
    ubyte        fEnableWindowsKey;
    ///Specifies whether the client is using saved credentials during the logon process.
    ubyte        fUsingSavedCreds;
    ///Specifies whether mouse input is enabled.
    ubyte        fMouse;
    ///Specifies whether to turn on audio playback. A value of <b>TRUE</b> specifies no audio.
    ubyte        fNoAudioPlayback;
    ///Specifies whether to leave audio playback on the remote computer.
    ubyte        fRemoteConsoleAudio;
    ///Specifies the encryption level.
    ubyte        EncryptionLevel;
    ///Specifies the client monitor color depth. For possible values, see the <b>ColorDepth</b> member of the
    ///WTS_CLIENT_DISPLAY structure.
    ushort       ColorDepth;
    ///Specifies the protocol type.
    ushort       ProtocolType;
    ///Specifies the client monitor horizontal resolution.
    ushort       HRes;
    ///Specifies the client monitor vertical resolution.
    ushort       VRes;
    ///The client software product id.
    ushort       ClientProductId;
    ///The number of output buffers on the host.
    ushort       OutBufCountHost;
    ///The number of output buffers on the client.
    ushort       OutBufCountClient;
    ///The length of output buffers, in bytes.
    ushort       OutBufLength;
    ///Specifies the keyboard layout.
    uint         KeyboardLayout;
    ///The maximum duration of the Remote Desktop Services session, in minutes.
    uint         MaxConnectionTime;
    ///The maximum amount of time, in minutes, that a disconnected Remote Desktop Services session remains active on the
    ///RD Session Host server.
    uint         MaxDisconnectionTime;
    ///The maximum amount of time, in minutes, that the Remote Desktop Services session can remain idle.
    uint         MaxIdleTime;
    ///Specifies a set of features that can be set at the server to improve performance. This can be a combination of
    ///one or more of the following values.
    uint         PerformanceFlags;
    ///Specifies the keyboard type.
    uint         KeyboardType;
    ///Specifies the keyboard subtype.
    uint         KeyboardSubType;
    ///Specifies the function key.
    uint         KeyboardFunctionKey;
    ///Specifies the input locale identifier. The low word contains a language identifier and the high word contains a
    ///device handle to the physical layout of the keyboard.
    uint         ActiveInputLocale;
    ///The client computer's unique serial number.
    uint         SerialNumber;
    ///The client IP address family.
    uint         ClientAddressFamily;
    ///The client build number.
    uint         ClientBuildNumber;
    ///The client session Id.
    uint         ClientSessionId;
    ///A string that contains the directory where the initial program resides. This value is used if
    ///<b>fInheritInitialProgram</b> is set to <b>TRUE</b>.
    ushort[257]  WorkDirectory;
    ///A string value that specifies the name of the initial program. This value is used if
    ///<b>fInheritInitialProgram</b> is set to <b>TRUE</b>.
    ushort[257]  InitialProgram;
    ///A string that specifies the user name. This value is used if <b>fInheritAutoLogon</b> is set to <b>TRUE</b>.
    ushort[256]  UserName;
    ///A string that specifies the domain of the user. This value is used if <b>fInheritAutoLogon</b> is set to
    ///<b>TRUE</b>.
    ushort[256]  Domain;
    ///A string that specifies the user password. This value is used if <b>fInheritAutoLogon</b> is set to <b>TRUE</b>.
    ushort[256]  Password;
    ///A string that contains the protocol name.
    ushort[9]    ProtocolName;
    ///A string that specifies the name of the display driver to load.
    ushort[9]    DisplayDriverName;
    ///A string that specifies the name of the display device.
    ushort[20]   DisplayDeviceName;
    ///Specifies the input method editor name.
    ushort[33]   imeFileName;
    ///A string that contains the name of the audio driver to load.
    ushort[9]    AudioDriverName;
    ///A string that contains the fully qualified name of the client computer.
    ushort[21]   ClientName;
    ///A string that contains the client IP address in dotted decimal format.
    ushort[31]   ClientAddress;
    ///The client directory. A string that contains the client directory.
    ushort[257]  ClientDirectory;
    ///A string that contains a client product identifier.
    ushort[33]   ClientDigProductId;
    ///A WRDS_SOCKADDR structure that contains socket address information.
    WTS_SOCKADDR ClientSockAddress;
    ///A WRDS_TIME_ZONE_INFORMATION structure that contains client time zone information.
    WTS_TIME_ZONE_INFORMATION ClientTimeZone;
    ///A WRDS_LISTENER_SETTINGS structure that contains listener settings.
    WRDS_LISTENER_SETTINGS WRdsListenerSettings;
    GUID         EventLogActivityId;
    uint         ContextSize;
    ubyte*       ContextData;
}

///Contains policy-related settings for a remote session. This structure is mostly a subset of the
///WRDS_CONNECTION_SETTINGS_1 structure. The settings correspond to policy settings that can be found in the group
///policy editor (Gpedit.exe). The settings in this structure overwrite the initial policy settings.
struct WRDS_SETTINGS_1
{
    ///The clipboard redirection state (not applicable, disabled, enabled, or not configured). For more information, see
    ///the group policy node topic for Device and Resource Redirection.
    WRDS_SETTING_STATUS WRdsDisableClipStatus;
    ///The clipboard redirection value. A value of 1 indicates that clipboard functionality is disabled (clipboard
    ///redirection is enabled); any other value means clipboard functionality is enabled. This value only takes effect
    ///if the <b>WRdsDisableClipStatus</b> member is set to enabled.
    uint                WRdsDisableClipValue;
    ///The LPT printer redirection state (not applicable, disabled, enabled, or not configured). For more information,
    ///see the group policy node topic for Device and Resource Redirection.
    WRDS_SETTING_STATUS WRdsDisableLPTStatus;
    ///The LPT printer redirection value. A value of 1 indicates that LPT printer redirection is enabled; any other
    ///value means LPT printer redirection is disabled. This value only takes effect if the <b>WRdsDisableLPTStatus</b>
    ///member is set to enabled.
    uint                WRdsDisableLPTValue;
    ///The COM port mapping state (not applicable, disabled, enabled, or not configured). For more information, see the
    ///group policy node topic for Device and Resource Redirection.
    WRDS_SETTING_STATUS WRdsDisableCcmStatus;
    ///The COM port mapping value. A value of 1 indicates that COM port mapping is enabled; any other value means COM
    ///port mapping is disabled. This value only takes effect if the <b>WRdsDisableCcmStatus</b> member is set to
    ///enabled.
    uint                WRdsDisableCcmValue;
    ///The drive mapping state (not applicable, disabled, enabled, or not configured). For more information, see the
    ///group policy node topic for Device and Resource Redirection.
    WRDS_SETTING_STATUS WRdsDisableCdmStatus;
    ///The drive mapping value. A value of 1 indicates that drive mapping is enabled; any other value means drive
    ///mapping is disabled. This value only takes effect if the <b>WRdsDisableCdmStatus</b> member is set to enabled.
    uint                WRdsDisableCdmValue;
    ///The printer mapping state (not applicable, disabled, enabled, or not configured). For more information, see the
    ///group policy node topic for Printer Redirection.
    WRDS_SETTING_STATUS WRdsDisableCpmStatus;
    ///The printer mapping value. A value of 1 indicates that printer mapping is enabled; any other value means printer
    ///mapping is disabled. This value only takes effect if the <b>WRdsDisableCpmStatus</b> member is set to enabled.
    uint                WRdsDisableCpmValue;
    ///The state of the setting that controls Plug and Play (PNP) redirection (not applicable, disabled, enabled, or not
    ///configured). For more information, see the group policy node topic for Device and Resource Redirection.
    WRDS_SETTING_STATUS WRdsDisablePnpStatus;
    ///The PNP redirection value. A value of 1 indicates that PNP redirection is enabled; any other value means PNP
    ///redirection is disabled. This value only takes effect if the <b>WRdsDisablePnpStatus</b> member is set to
    ///enabled.
    uint                WRdsDisablePnpValue;
    ///The encryption level state (not applicable, disabled, enabled, or not configured). For more information, see the
    ///group policy node topic for Security.
    WRDS_SETTING_STATUS WRdsEncryptionLevelStatus;
    ///The encryption level value. This value only takes effect if the <b>WRdsEncryptionLevelStatus</b> member is set to
    ///enabled.
    uint                WRdsEncryptionValue;
    ///The color depth state (not applicable, disabled, enabled, or not configured). For more information, see the group
    ///policy node topic for Remote Session Environment.
    WRDS_SETTING_STATUS WRdsColorDepthStatus;
    ///The color depth value. For possible values, see the <b>ColorDepth</b> member of the WTS_CLIENT_DISPLAY structure.
    ///This value only takes effect if the <b>WRdsColorDepthStatus</b> member is set to enabled.
    uint                WRdsColorDepthValue;
    ///The automatic client reconnection state (not applicable, disabled, enabled, or not configured). For more
    ///information, see the group policy node topic for Connections.
    WRDS_SETTING_STATUS WRdsDisableAutoReconnecetStatus;
    ///The automatic client reconnection value. A value of 1 indicates that automatic client reconnection is disabled;
    ///any other value means automatic client reconnection is enabled. This value only takes effect if the
    ///<b>WRdsDisableAutoReconnecetStatus</b> member is set to enabled.
    uint                WRdsDisableAutoReconnecetValue;
    ///The state (not applicable, disabled, enabled, or not configured) of the setting that controls whether to disable
    ///encryption for communication between the client and the server. For more information, see the group policy node
    ///topic for Security.
    WRDS_SETTING_STATUS WRdsDisableEncryptionStatus;
    ///The encryption disabling value. A value of 1 indicates that encryption is disabled; any other value means
    ///encryption is required. This value only takes effect if the <b>WRdsDisableEncryptionStatus</b> member is set to
    ///enabled.
    uint                WRdsDisableEncryptionValue;
    ///The state (not applicable, disabled, enabled, or not configured) of the setting that controls how the server
    ///reacts when the connection or idle timers expire, or when a connection is lost due to a connection error. For
    ///more information, see the group policy node topic for Session Time Limits.
    WRDS_SETTING_STATUS WRdsResetBrokenStatus;
    ///The value of the setting that controls the server reaction. A value of 1 indicates that the session is terminated
    ///whenever the time-out limit is reached; any other value means the session is disconnected but remains on the
    ///server. This value only takes effect if the <b>WRdsResetBrokenStatus</b> member is set to enabled.
    uint                WRdsResetBrokenValue;
    ///The maximum idle time state (not applicable, disabled, enabled, or not configured). For more information, see the
    ///group policy node topic for Session Time Limits.
    WRDS_SETTING_STATUS WRdsMaxIdleTimeStatus;
    ///The maximum amount of time, in minutes, that the Remote Desktop Services session can remain idle. This value only
    ///takes effect if the <b>WRdsMaxIdleTimeStatus</b> member is set to enabled.
    uint                WRdsMaxIdleTimeValue;
    ///The maximum disconnection time state (not applicable, disabled, enabled, or not configured). For more
    ///information, see the group policy node topic for Session Time Limits.
    WRDS_SETTING_STATUS WRdsMaxDisconnectTimeStatus;
    ///The maximum amount of time, in minutes, that a disconnected Remote Desktop Services session remains active on the
    ///RD Session Host server. This value only takes effect if the <b>WRdsMaxDisconnectTimeStatus</b> member is set to
    ///enabled.
    uint                WRdsMaxDisconnectTimeValue;
    ///The maximum connection time state (not applicable, disabled, enabled, or not configured). For more information,
    ///see the group policy node topic for Session Time Limits.
    WRDS_SETTING_STATUS WRdsMaxConnectTimeStatus;
    ///The maximum duration of the Remote Desktop Services session, in minutes. This value only takes effect if the
    ///<b>WRdsMaxConnectTimeStatus</b> member is set to enabled.
    uint                WRdsMaxConnectTimeValue;
    ///The state (not applicable, disabled, enabled, or not configured) of the <i>keep alive</i> setting. The keep alive
    ///setting controls whether to check to keep a Remote Desktop Services session active. For more information, see the
    ///group policy node topic for Connections.
    WRDS_SETTING_STATUS WRdsKeepAliveStatus;
    ///Specifies whether or not the keep alive setting is enabled.
    ubyte               WRdsKeepAliveStartValue;
    ///The amount of time, in minutes, of idle time before the state of the Remote Desktop Services session is checked.
    ///This value only takes effect if the <b>WRdsKeepAliveStatus</b> member is set to enabled.
    uint                WRdsKeepAliveIntervalValue;
}

///Contains different levels of settings for a remote desktop connection.
union WRDS_CONNECTION_SETTING
{
    ///A WRDS_CONNECTION_SETTINGS_1 structure.
    WRDS_CONNECTION_SETTINGS_1 WRdsConnectionSettings1;
}

///Contains connection setting information for a remote session.
struct WRDS_CONNECTION_SETTINGS
{
    ///A value of the WRDS_CONNECTION_SETTING_LEVEL enumeration that specifies the type of structure that is contained
    ///in the <b>WRdsConnectionSetting</b> member.
    WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel;
    ///A WRDS_CONNECTION_SETTING structure that specifies the connection settings.
    WRDS_CONNECTION_SETTING WRdsConnectionSetting;
}

///Contains different levels of policy-related settings for a remote desktop connection.
union WRDS_SETTING
{
    ///A WRDS_SETTINGS_1 structure.
    WRDS_SETTINGS_1 WRdsSettings1;
}

///Contains policy-related setting information for a remote session. This structure is used in the IWRdsProtocolSettings
///interface and the Initialize method of the IWRdsProtocolManager interface.
struct WRDS_SETTINGS
{
    ///The category of settings contained (machine group policy, user group policy, or user security accounts manager).
    WRDS_SETTING_TYPE  WRdsSettingType;
    ///The setting level.
    WRDS_SETTING_LEVEL WRdsSettingLevel;
    WRDS_SETTING       WRdsSetting;
}

// Functions

///Retrieves the Remote Desktop Services session associated with a specified process.
///Params:
///    dwProcessId = Specifies a process identifier. Use the GetCurrentProcessId function to retrieve the process identifier for the
///                  current process.
///    pSessionId = Pointer to a variable that receives the identifier of the Remote Desktop Services session under which the
///                 specified process is running. To retrieve the identifier of the session currently attached to the console, use
///                 the WTSGetActiveConsoleSessionId function.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL ProcessIdToSessionId(uint dwProcessId, uint* pSessionId);

///Retrieves the session identifier of the console session. The console session is the session that is currently
///attached to the physical console. Note that it is not necessary that Remote Desktop Services be running for this
///function to succeed.
///Returns:
///    The session identifier of the session that is attached to the physical console. If there is no session attached
///    to the physical console, (for example, if the physical console session is in the process of being attached or
///    detached), this function returns 0xFFFFFFFF.
///    
@DllImport("KERNEL32")
uint WTSGetActiveConsoleSessionId();

///Stops a remote control session.
///Params:
///    LogonId = The logon ID of the session that you want to stop the remote control of.
@DllImport("WTSAPI32")
BOOL WTSStopRemoteControlSession(uint LogonId);

///Starts the remote control of another Remote Desktop Services session. You must call this function from a remote
///session.
///Params:
///    pTargetServerName = A pointer to the name of the server where the session that you want remote control of exists.
///    TargetLogonId = The logon ID of the session that you want remote control of.
///    HotkeyVk = The virtual-key code that represents the key to press to stop remote control of the session. The key that is
///               defined in this parameter is used with the <i>HotkeyModifiers</i> parameter.
///    HotkeyModifiers = The virtual modifier that represents the key to press to stop remote control of the session. The virtual modifier
///                      is used with the <i>HotkeyVk</i> parameter. For example, if the <b>WTSStartRemoteControlSession</b> function is
///                      called with <i>HotkeyVk</i> set to <b>VK_MULTIPLY</b> and <i>HotkeyModifiers</i> set to
///                      <b>REMOTECONTROL_KBDCTRL_HOTKEY</b>, the user who has remote control of the target session can press CTRL + * to
///                      stop remote control of the session and return to their own session.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSStartRemoteControlSessionW(const(wchar)* pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, 
                                   ushort HotkeyModifiers);

///Starts the remote control of another Remote Desktop Services session. You must call this function from a remote
///session.
///Params:
///    pTargetServerName = A pointer to the name of the server where the session that you want remote control of exists.
///    TargetLogonId = The logon ID of the session that you want remote control of.
///    HotkeyVk = The virtual-key code that represents the key to press to stop remote control of the session. The key that is
///               defined in this parameter is used with the <i>HotkeyModifiers</i> parameter.
///    HotkeyModifiers = The virtual modifier that represents the key to press to stop remote control of the session. The virtual modifier
///                      is used with the <i>HotkeyVk</i> parameter. For example, if the <b>WTSStartRemoteControlSession</b> function is
///                      called with <i>HotkeyVk</i> set to <b>VK_MULTIPLY</b> and <i>HotkeyModifiers</i> set to
///                      <b>REMOTECONTROL_KBDCTRL_HOTKEY</b>, the user who has remote control of the target session can press CTRL + * to
///                      stop remote control of the session and return to their own session.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSStartRemoteControlSessionA(const(char)* pTargetServerName, uint TargetLogonId, ubyte HotkeyVk, 
                                   ushort HotkeyModifiers);

///Connects a Remote Desktop Services session to an existing session on the local computer.
///Params:
///    LogonId = The logon ID of the session to connect to. The user of that session must have permissions to connect to an
///              existing session. The output of this session will be routed to the session identified by the <i>TargetLogonId</i>
///              parameter. This can be <b>LOGONID_CURRENT</b> to use the current session.
///    TargetLogonId = The logon ID of the session to receive the output of the session represented by the <i>LogonId</i> parameter. The
///                    output of the session identified by the <i>LogonId</i> parameter will be routed to this session. This can be
///                    <b>LOGONID_CURRENT</b> to use the current session.
///    pPassword = A pointer to the password for the user account that is specified in the <i>LogonId</i> parameter. The value of
///                <i>pPassword</i> can be an empty string if the caller is logged on using the same domain name and user name as
///                the logon ID. The value of <i>pPassword</i> cannot be <b>NULL</b>.
///    bWait = Indicates whether the operation is synchronous. Specify <b>TRUE</b> to wait for the operation to complete, or
///            <b>FALSE</b> to return immediately.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSConnectSessionA(uint LogonId, uint TargetLogonId, const(char)* pPassword, BOOL bWait);

///Connects a Remote Desktop Services session to an existing session on the local computer.
///Params:
///    LogonId = The logon ID of the session to connect to. The user of that session must have permissions to connect to an
///              existing session. The output of this session will be routed to the session identified by the <i>TargetLogonId</i>
///              parameter. This can be <b>LOGONID_CURRENT</b> to use the current session.
///    TargetLogonId = The logon ID of the session to receive the output of the session represented by the <i>LogonId</i> parameter. The
///                    output of the session identified by the <i>LogonId</i> parameter will be routed to this session. This can be
///                    <b>LOGONID_CURRENT</b> to use the current session.
///    pPassword = A pointer to the password for the user account that is specified in the <i>LogonId</i> parameter. The value of
///                <i>pPassword</i> can be an empty string if the caller is logged on using the same domain name and user name as
///                the logon ID. The value of <i>pPassword</i> cannot be <b>NULL</b>.
///    bWait = Indicates whether the operation is synchronous. Specify <b>TRUE</b> to wait for the operation to complete, or
///            <b>FALSE</b> to return immediately.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSConnectSessionW(uint LogonId, uint TargetLogonId, const(wchar)* pPassword, BOOL bWait);

///Returns a list of all Remote Desktop Session Host (RD Session Host) servers within the specified domain.
///Params:
///    pDomainName = Pointer to the name of the domain to be queried. If the value of this parameter is <b>NULL</b>, the specified
///                  domain is the current domain.
///    Reserved = Reserved. The value of this parameter must be 0.
///    Version = Version of the enumeration request. The value of the parameter must be 1.
///    ppServerInfo = Points to an array of WTS_SERVER_INFO structures, which contains the returned results of the enumeration. After
///                   use, the memory used by this buffer should be freed by calling WTSFreeMemory.
///    pCount = Pointer to a variable that receives the number of WTS_SERVER_INFO structures returned in the <i>ppServerInfo</i>
///             buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateServersW(const(wchar)* pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOW** ppServerInfo, 
                          uint* pCount);

///Returns a list of all Remote Desktop Session Host (RD Session Host) servers within the specified domain.
///Params:
///    pDomainName = Pointer to the name of the domain to be queried. If the value of this parameter is <b>NULL</b>, the specified
///                  domain is the current domain.
///    Reserved = Reserved. The value of this parameter must be 0.
///    Version = Version of the enumeration request. The value of the parameter must be 1.
///    ppServerInfo = Points to an array of WTS_SERVER_INFO structures, which contains the returned results of the enumeration. After
///                   use, the memory used by this buffer should be freed by calling WTSFreeMemory.
///    pCount = Pointer to a variable that receives the number of WTS_SERVER_INFO structures returned in the <i>ppServerInfo</i>
///             buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateServersA(const(char)* pDomainName, uint Reserved, uint Version, WTS_SERVER_INFOA** ppServerInfo, 
                          uint* pCount);

///Opens a handle to the specified Remote Desktop Session Host (RD Session Host) server.
///Params:
///    pServerName = Pointer to a null-terminated string specifying the NetBIOS name of the RD Session Host server.
///Returns:
///    If the function succeeds, the return value is a handle to the specified server. If the function fails, it returns
///    a handle that is not valid. You can test the validity of the handle by using it in another function call.
///    
@DllImport("WTSAPI32")
HANDLE WTSOpenServerW(const(wchar)* pServerName);

///Opens a handle to the specified Remote Desktop Session Host (RD Session Host) server.
///Params:
///    pServerName = Pointer to a null-terminated string specifying the NetBIOS name of the RD Session Host server.
///Returns:
///    If the function succeeds, the return value is a handle to the specified server. If the function fails, it returns
///    a handle that is not valid. You can test the validity of the handle by using it in another function call.
///    
@DllImport("WTSAPI32")
HANDLE WTSOpenServerA(const(char)* pServerName);

///Opens a handle to the specified Remote Desktop Session Host (RD Session Host) server or Remote Desktop Virtualization
///Host (RD Virtualization Host) server.
///Params:
///    pServerName = A pointer to a null-terminated string that contains the NetBIOS name of the server.
///Returns:
///    If the function succeeds, the return value is a handle to the specified server. If the function fails, it returns
///    an invalid handle. You can test the validity of the handle by using it in another function call.
///    
@DllImport("WTSAPI32")
HANDLE WTSOpenServerExW(const(wchar)* pServerName);

///Opens a handle to the specified Remote Desktop Session Host (RD Session Host) server or Remote Desktop Virtualization
///Host (RD Virtualization Host) server.
///Params:
///    pServerName = A pointer to a null-terminated string that contains the NetBIOS name of the server.
///Returns:
///    If the function succeeds, the return value is a handle to the specified server. If the function fails, it returns
///    an invalid handle. You can test the validity of the handle by using it in another function call.
///    
@DllImport("WTSAPI32")
HANDLE WTSOpenServerExA(const(char)* pServerName);

///Closes an open handle to a Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = A handle to an RD Session Host server opened by a call to the WTSOpenServer or WTSOpenServerEx function. Do not
///              pass <b>WTS_CURRENT_SERVER_HANDLE</b> for this parameter.
@DllImport("WTSAPI32")
void WTSCloseServer(HANDLE hServer);

///Retrieves a list of sessions on a Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = A handle to the RD Session Host server. <div class="alert"><b>Note</b> You can use the WTSOpenServer or
///              WTSOpenServerEx functions to retrieve a handle to a specific server, or <b>WTS_CURRENT_SERVER_HANDLE</b> to use
///              the RD Session Host server that hosts your application.</div> <div> </div>
///    Reserved = This parameter is reserved. It must be zero.
///    Version = The version of the enumeration request. This parameter must be 1.
///    ppSessionInfo = A pointer to an array of WTS_SESSION_INFO structures that represent the retrieved sessions. To free the returned
///                    buffer, call the WTSFreeMemory function. <b>Session permissions: </b><ul> <li>To enumerate a session, you must
///                    enable the query information permission. For more information, see Remote Desktop Services Permissions.</li>
///                    <li>To change permissions on a session, use the Remote Desktop Services Configuration administrative tool.</li>
///                    <li>To enumerate sessions running on a virtual machine hosted on a RD Virtualization Host server, you must be a
///                    member of the Administrators group on the RD Virtualization Host server.</li> </ul>
///    pCount = A pointer to the number of <b>WTS_SESSION_INFO</b> structures returned in the <i>ppSessionInfo</i> parameter.
///Returns:
///    Returns zero if this function fails. If this function succeeds, a nonzero value is returned. To get extended
///    error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsW(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOW** ppSessionInfo, 
                           uint* pCount);

///Retrieves a list of sessions on a Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = A handle to the RD Session Host server. <div class="alert"><b>Note</b> You can use the WTSOpenServer or
///              WTSOpenServerEx functions to retrieve a handle to a specific server, or <b>WTS_CURRENT_SERVER_HANDLE</b> to use
///              the RD Session Host server that hosts your application.</div> <div> </div>
///    Reserved = This parameter is reserved. It must be zero.
///    Version = The version of the enumeration request. This parameter must be 1.
///    ppSessionInfo = A pointer to an array of WTS_SESSION_INFO structures that represent the retrieved sessions. To free the returned
///                    buffer, call the WTSFreeMemory function. <b>Session permissions: </b><ul> <li>To enumerate a session, you must
///                    enable the query information permission. For more information, see Remote Desktop Services Permissions.</li>
///                    <li>To change permissions on a session, use the Remote Desktop Services Configuration administrative tool.</li>
///                    <li>To enumerate sessions running on a virtual machine hosted on a RD Virtualization Host server, you must be a
///                    member of the Administrators group on the RD Virtualization Host server.</li> </ul>
///    pCount = A pointer to the number of <b>WTS_SESSION_INFO</b> structures returned in the <i>ppSessionInfo</i> parameter.
///Returns:
///    Returns zero if this function fails. If this function succeeds, a nonzero value is returned. To get extended
///    error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsA(HANDLE hServer, uint Reserved, uint Version, WTS_SESSION_INFOA** ppSessionInfo, 
                           uint* pCount);

///Retrieves a list of sessions on a specified Remote Desktop Session Host (RD Session Host) server or Remote Desktop
///Virtualization Host (RD Virtualization Host) server.
///Params:
///    hServer = A handle to the target server. Specify a handle returned by the WTSOpenServer or WTSOpenServerEx function. To
///              enumerate sessions on the RD Session Host server on which the application is running, specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pLevel = This parameter is reserved. Always set this parameter to one. On output, <b>WTSEnumerateSessionsEx</b> does not
///             change the value of this parameter.
///    Filter = This parameter is reserved. Always set this parameter to zero.
///    ppSessionInfo = A pointer to a <b>PWTS_SESSION_INFO_1</b> variable that receives a pointer to an array of WTS_SESSION_INFO_1
///                    structures. Each structure in the array contains information about a session on the specified RD Session Host
///                    server. If you obtained a handle to an RD Virtualization Host server by calling the WTSOpenServerEx function, the
///                    array contains information about sessions on virtual machines on the server. When you have finished using the
///                    array, free it by calling the WTSFreeMemoryEx function. You should also set the pointer to <b>NULL</b>.
///    pCount = A pointer to a <b>DWORD</b> variable that receives the number of WTS_SESSION_INFO_1 structures returned in the
///             <i>ppSessionInfo</i> buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsExW(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1W** ppSessionInfo, 
                             uint* pCount);

///Retrieves a list of sessions on a specified Remote Desktop Session Host (RD Session Host) server or Remote Desktop
///Virtualization Host (RD Virtualization Host) server.
///Params:
///    hServer = A handle to the target server. Specify a handle returned by the WTSOpenServer or WTSOpenServerEx function. To
///              enumerate sessions on the RD Session Host server on which the application is running, specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pLevel = This parameter is reserved. Always set this parameter to one. On output, <b>WTSEnumerateSessionsEx</b> does not
///             change the value of this parameter.
///    Filter = This parameter is reserved. Always set this parameter to zero.
///    ppSessionInfo = A pointer to a <b>PWTS_SESSION_INFO_1</b> variable that receives a pointer to an array of WTS_SESSION_INFO_1
///                    structures. Each structure in the array contains information about a session on the specified RD Session Host
///                    server. If you obtained a handle to an RD Virtualization Host server by calling the WTSOpenServerEx function, the
///                    array contains information about sessions on virtual machines on the server. When you have finished using the
///                    array, free it by calling the WTSFreeMemoryEx function. You should also set the pointer to <b>NULL</b>.
///    pCount = A pointer to a <b>DWORD</b> variable that receives the number of WTS_SESSION_INFO_1 structures returned in the
///             <i>ppSessionInfo</i> buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateSessionsExA(HANDLE hServer, uint* pLevel, uint Filter, WTS_SESSION_INFO_1A** ppSessionInfo, 
                             uint* pCount);

///Retrieves information about the active processes on a specified Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = Handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is running.
///    Reserved = Reserved; must be zero.
///    Version = Specifies the version of the enumeration request. Must be 1.
///    ppProcessInfo = Pointer to a variable that receives a pointer to an array of WTS_PROCESS_INFO structures. Each structure in the
///                    array contains information about an active process on the specified RD Session Host server. To free the returned
///                    buffer, call the WTSFreeMemory function.
///    pCount = Pointer to a variable that receives the number of <b>WTS_PROCESS_INFO</b> structures returned in the
///             <i>ppProcessInfo</i> buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesW(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOW** ppProcessInfo, 
                            uint* pCount);

///Retrieves information about the active processes on a specified Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = Handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is running.
///    Reserved = Reserved; must be zero.
///    Version = Specifies the version of the enumeration request. Must be 1.
///    ppProcessInfo = Pointer to a variable that receives a pointer to an array of WTS_PROCESS_INFO structures. Each structure in the
///                    array contains information about an active process on the specified RD Session Host server. To free the returned
///                    buffer, call the WTSFreeMemory function.
///    pCount = Pointer to a variable that receives the number of <b>WTS_PROCESS_INFO</b> structures returned in the
///             <i>ppProcessInfo</i> buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesA(HANDLE hServer, uint Reserved, uint Version, WTS_PROCESS_INFOA** ppProcessInfo, 
                            uint* pCount);

///Terminates the specified process on the specified Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = Handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              WTS_CURRENT_SERVER_HANDLE to indicate the RD Session Host server on which your application is running.
///    ProcessId = Specifies the process identifier of the process to terminate.
///    ExitCode = Specifies the exit code for the terminated process.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSTerminateProcess(HANDLE hServer, uint ProcessId, uint ExitCode);

///Retrieves session information for the specified session on the specified Remote Desktop Session Host (RD Session
///Host) server. It can be used to query session information on local and remote RD Session Host servers.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is running.
///    SessionId = A Remote Desktop Services session identifier. To indicate the session in which the calling application is running
///                (or the current session) specify <b>WTS_CURRENT_SESSION</b>. Only specify <b>WTS_CURRENT_SESSION</b> when
///                obtaining session information on the local server. If <b>WTS_CURRENT_SESSION</b> is specified when querying
///                session information on a remote server, the returned session information will be inconsistent. Do not use the
///                returned data. You can use the WTSEnumerateSessions function to retrieve the identifiers of all sessions on a
///                specified RD Session Host server. To query information for another user's session, you must have Query
///                Information permission. For more information, see <a
///                href="/windows/desktop/TermServ/terminal-services-permissions">Remote Desktop Services Permissions</a>. To modify
///                permissions on a session, use the Remote Desktop Services Configuration administrative tool.
///    WTSInfoClass = A value of the WTS_INFO_CLASS enumeration that indicates the type of session information to retrieve in a call to
///                   the <b>WTSQuerySessionInformation</b> function.
///    ppBuffer = A pointer to a variable that receives a pointer to the requested information. The format and contents of the data
///               depend on the information class specified in the <i>WTSInfoClass</i> parameter. To free the returned buffer, call
///               the WTSFreeMemory function.
///    pBytesReturned = A pointer to a variable that receives the size, in bytes, of the data returned in <i>ppBuffer</i>.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSQuerySessionInformationW(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, ushort** ppBuffer, 
                                 uint* pBytesReturned);

///Retrieves session information for the specified session on the specified Remote Desktop Session Host (RD Session
///Host) server. It can be used to query session information on local and remote RD Session Host servers.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is running.
///    SessionId = A Remote Desktop Services session identifier. To indicate the session in which the calling application is running
///                (or the current session) specify <b>WTS_CURRENT_SESSION</b>. Only specify <b>WTS_CURRENT_SESSION</b> when
///                obtaining session information on the local server. If <b>WTS_CURRENT_SESSION</b> is specified when querying
///                session information on a remote server, the returned session information will be inconsistent. Do not use the
///                returned data. You can use the WTSEnumerateSessions function to retrieve the identifiers of all sessions on a
///                specified RD Session Host server. To query information for another user's session, you must have Query
///                Information permission. For more information, see <a
///                href="/windows/desktop/TermServ/terminal-services-permissions">Remote Desktop Services Permissions</a>. To modify
///                permissions on a session, use the Remote Desktop Services Configuration administrative tool.
///    WTSInfoClass = A value of the WTS_INFO_CLASS enumeration that indicates the type of session information to retrieve in a call to
///                   the <b>WTSQuerySessionInformation</b> function.
///    ppBuffer = A pointer to a variable that receives a pointer to the requested information. The format and contents of the data
///               depend on the information class specified in the <i>WTSInfoClass</i> parameter. To free the returned buffer, call
///               the WTSFreeMemory function.
///    pBytesReturned = A pointer to a variable that receives the size, in bytes, of the data returned in <i>ppBuffer</i>.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSQuerySessionInformationA(HANDLE hServer, uint SessionId, WTS_INFO_CLASS WTSInfoClass, byte** ppBuffer, 
                                 uint* pBytesReturned);

///Retrieves configuration information for the specified user on the specified domain controller or Remote Desktop
///Session Host (RD Session Host) server.
///Params:
///    pServerName = Pointer to a null-terminated string containing the name of a domain controller or an RD Session Host server.
///                  Specify <b>WTS_CURRENT_SERVER_NAME</b> to indicate the RD Session Host server on which your application is
///                  running.
///    pUserName = Pointer to a null-terminated string containing the user name to query. To retrieve the default user settings for
///                the RD Session Host server, set this parameter to <b>NULL</b>. <b>Windows Server 2008 and Windows Vista:
///                </b>Setting this parameter to <b>NULL</b> returns an error.
///    WTSConfigClass = Specifies the type of information to retrieve. This parameter can be one of the values from the WTS_CONFIG_CLASS
///                     enumeration type. The documentation for <b>WTS_CONFIG_CLASS</b> describes the format of the data returned in
///                     <i>ppBuffer</i> for each of the information types.
///    ppBuffer = Pointer to a variable that receives a pointer to the requested information. The format and contents of the data
///               depend on the information class specified in the <i>WTSConfigClass</i> parameter. To free the returned buffer,
///               call the WTSFreeMemory function.
///    pBytesReturned = Pointer to a variable that receives the size, in bytes, of the data returned in <i>ppBuffer</i>.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSQueryUserConfigW(const(wchar)* pServerName, const(wchar)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                         ushort** ppBuffer, uint* pBytesReturned);

///Retrieves configuration information for the specified user on the specified domain controller or Remote Desktop
///Session Host (RD Session Host) server.
///Params:
///    pServerName = Pointer to a null-terminated string containing the name of a domain controller or an RD Session Host server.
///                  Specify <b>WTS_CURRENT_SERVER_NAME</b> to indicate the RD Session Host server on which your application is
///                  running.
///    pUserName = Pointer to a null-terminated string containing the user name to query. To retrieve the default user settings for
///                the RD Session Host server, set this parameter to <b>NULL</b>. <b>Windows Server 2008 and Windows Vista:
///                </b>Setting this parameter to <b>NULL</b> returns an error.
///    WTSConfigClass = Specifies the type of information to retrieve. This parameter can be one of the values from the WTS_CONFIG_CLASS
///                     enumeration type. The documentation for <b>WTS_CONFIG_CLASS</b> describes the format of the data returned in
///                     <i>ppBuffer</i> for each of the information types.
///    ppBuffer = Pointer to a variable that receives a pointer to the requested information. The format and contents of the data
///               depend on the information class specified in the <i>WTSConfigClass</i> parameter. To free the returned buffer,
///               call the WTSFreeMemory function.
///    pBytesReturned = Pointer to a variable that receives the size, in bytes, of the data returned in <i>ppBuffer</i>.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSQueryUserConfigA(const(char)* pServerName, const(char)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                         byte** ppBuffer, uint* pBytesReturned);

///Modifies configuration information for the specified user on the specified domain controller or Remote Desktop
///Session Host (RD Session Host) server.
///Params:
///    pServerName = Pointer to a null-terminated string containing the name of a domain controller or RD Session Host server. Specify
///                  <b>WTS_CURRENT_SERVER_NAME</b> to indicate the RD Session Host server on which your application is running.
///    pUserName = Pointer to a null-terminated string containing the name of the user whose configuration is being set.
///    WTSConfigClass = Specifies the type of information to set for the user. This parameter can be one of the values from the
///                     WTS_CONFIG_CLASS enumeration type. The documentation for <b>WTS_CONFIG_CLASS</b> describes the format of the data
///                     specified in <i>ppBuffer</i> for each of the information types.
///    pBuffer = Pointer to the data used to modify the specified user's configuration.
///    DataLength = Size, in <b>TCHARs</b>, of the <i>pBuffer</i> buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSSetUserConfigW(const(wchar)* pServerName, const(wchar)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                       const(wchar)* pBuffer, uint DataLength);

///Modifies configuration information for the specified user on the specified domain controller or Remote Desktop
///Session Host (RD Session Host) server.
///Params:
///    pServerName = Pointer to a null-terminated string containing the name of a domain controller or RD Session Host server. Specify
///                  <b>WTS_CURRENT_SERVER_NAME</b> to indicate the RD Session Host server on which your application is running.
///    pUserName = Pointer to a null-terminated string containing the name of the user whose configuration is being set.
///    WTSConfigClass = Specifies the type of information to set for the user. This parameter can be one of the values from the
///                     WTS_CONFIG_CLASS enumeration type. The documentation for <b>WTS_CONFIG_CLASS</b> describes the format of the data
///                     specified in <i>ppBuffer</i> for each of the information types.
///    pBuffer = Pointer to the data used to modify the specified user's configuration.
///    DataLength = Size, in <b>TCHARs</b>, of the <i>pBuffer</i> buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSSetUserConfigA(const(char)* pServerName, const(char)* pUserName, WTS_CONFIG_CLASS WTSConfigClass, 
                       const(char)* pBuffer, uint DataLength);

///Displays a message box on the client desktop of a specified Remote Desktop Services session.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is running.
///    SessionId = A Remote Desktop Services session identifier. To indicate the current session, specify
///                <b>WTS_CURRENT_SESSION</b>. You can use the WTSEnumerateSessions function to retrieve the identifiers of all
///                sessions on a specified RD Session Host server. To send a message to another user's session, you need to have the
///                Message permission. For more information, see <a
///                href="/windows/desktop/TermServ/terminal-services-permissions">Remote Desktop Services Permissions</a>. To modify
///                permissions on a session, use the Remote Desktop Services Configuration administrative tool.
///    pTitle = A pointer to a null-terminated string for the title bar of the message box.
///    TitleLength = The length, in bytes, of the title bar string.
///    pMessage = A pointer to a null-terminated string that contains the message to display.
///    MessageLength = The length, in bytes, of the message string.
///    Style = The contents and behavior of the message box. This value is typically <b>MB_OK</b>. For a complete list of
///            values, see the <i>uType</i> parameter of the MessageBox function.
///    Timeout = The time, in seconds, that the <b>WTSSendMessage</b> function waits for the user's response. If the user does not
///              respond within the time-out interval, the <i>pResponse</i> parameter returns <b>IDTIMEOUT</b>. If the
///              <i>Timeout</i> parameter is zero, <b>WTSSendMessage</b> waits indefinitely for the user to respond.
///    pResponse = A pointer to a variable that receives the user's response, which can be one of the following values.
///    bWait = If <b>TRUE</b>, <b>WTSSendMessage</b> does not return until the user responds or the time-out interval elapses.
///            If the <i>Timeout</i> parameter is zero, the function does not return until the user responds. If <b>FALSE</b>,
///            the function returns immediately and the <i>pResponse</i> parameter returns <b>IDASYNC</b>. Use this method for
///            simple information messages (such as print job–notification messages) that do not need to return the user's
///            response to the calling program.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSSendMessageW(HANDLE hServer, uint SessionId, const(wchar)* pTitle, uint TitleLength, 
                     const(wchar)* pMessage, uint MessageLength, uint Style, uint Timeout, uint* pResponse, 
                     BOOL bWait);

///Displays a message box on the client desktop of a specified Remote Desktop Services session.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is running.
///    SessionId = A Remote Desktop Services session identifier. To indicate the current session, specify
///                <b>WTS_CURRENT_SESSION</b>. You can use the WTSEnumerateSessions function to retrieve the identifiers of all
///                sessions on a specified RD Session Host server. To send a message to another user's session, you need to have the
///                Message permission. For more information, see <a
///                href="/windows/desktop/TermServ/terminal-services-permissions">Remote Desktop Services Permissions</a>. To modify
///                permissions on a session, use the Remote Desktop Services Configuration administrative tool.
///    pTitle = A pointer to a null-terminated string for the title bar of the message box.
///    TitleLength = The length, in bytes, of the title bar string.
///    pMessage = A pointer to a null-terminated string that contains the message to display.
///    MessageLength = The length, in bytes, of the message string.
///    Style = The contents and behavior of the message box. This value is typically <b>MB_OK</b>. For a complete list of
///            values, see the <i>uType</i> parameter of the MessageBox function.
///    Timeout = The time, in seconds, that the <b>WTSSendMessage</b> function waits for the user's response. If the user does not
///              respond within the time-out interval, the <i>pResponse</i> parameter returns <b>IDTIMEOUT</b>. If the
///              <i>Timeout</i> parameter is zero, <b>WTSSendMessage</b> waits indefinitely for the user to respond.
///    pResponse = A pointer to a variable that receives the user's response, which can be one of the following values.
///    bWait = If <b>TRUE</b>, <b>WTSSendMessage</b> does not return until the user responds or the time-out interval elapses.
///            If the <i>Timeout</i> parameter is zero, the function does not return until the user responds. If <b>FALSE</b>,
///            the function returns immediately and the <i>pResponse</i> parameter returns <b>IDASYNC</b>. Use this method for
///            simple information messages (such as print job–notification messages) that do not need to return the user's
///            response to the calling program.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSSendMessageA(HANDLE hServer, uint SessionId, const(char)* pTitle, uint TitleLength, const(char)* pMessage, 
                     uint MessageLength, uint Style, uint Timeout, uint* pResponse, BOOL bWait);

///Disconnects the logged-on user from the specified Remote Desktop Services session without closing the session. If the
///user subsequently logs on to the same Remote Desktop Session Host (RD Session Host) server, the user is reconnected
///to the same session.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer or WTSOpenServerEx function,
///              or specify <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is
///              running.
///    SessionId = A Remote Desktop Services session identifier. To indicate the current session, specify
///                <b>WTS_CURRENT_SESSION</b>. To retrieve the identifiers of all sessions on a specified RD Session Host server,
///                use the WTSEnumerateSessions function. To be able to disconnect another user's session, you need to have the
///                Disconnect permission. For more information, see Remote Desktop Services Permissions. To modify permissions on a
///                session, use the Remote Desktop Services Configuration administrative tool. To disconnect sessions running on a
///                virtual machine hosted on a RD Virtualization Host server, you must be a member of the Administrators group on
///                the RD Virtualization Host server.
///    bWait = Indicates whether the operation is synchronous. Specify <b>TRUE</b> to wait for the operation to complete, or
///            <b>FALSE</b> to return immediately.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSDisconnectSession(HANDLE hServer, uint SessionId, BOOL bWait);

///Logs off a specified Remote Desktop Services session.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer or WTSOpenServerEx function,
///              or specify <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is
///              running.
///    SessionId = A Remote Desktop Services session identifier. To indicate the current session, specify
///                <b>WTS_CURRENT_SESSION</b>. You can use the WTSEnumerateSessions function to retrieve the identifiers of all
///                sessions on a specified RD Session Host server. To be able to log off another user's session, you need to have
///                the Reset permission. For more information, see Remote Desktop Services Permissions. To modify permissions on a
///                session, use the Remote Desktop Services Configuration administrative tool. To log off sessions running on a
///                virtual machine hosted on a RD Virtualization Host server, you must be a member of the Administrators group on
///                the RD Virtualization Host server.
///    bWait = Indicates whether the operation is synchronous. If <i>bWait</i> is <b>TRUE</b>, the function returns when the
///            session is logged off. If <i>bWait</i> is <b>FALSE</b>, the function returns immediately. To verify that the
///            session has been logged off, specify the session identifier in a call to the WTSQuerySessionInformation function.
///            <b>WTSQuerySessionInformation</b> returns zero if the session is logged off.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSLogoffSession(HANDLE hServer, uint SessionId, BOOL bWait);

///Shuts down (and optionally restarts) the specified Remote Desktop Session Host (RD Session Host) server. To shut down
///or restart the system, the calling process must have the <b>SE_SHUTDOWN_NAME</b> privilege enabled. For more
///information about security privileges, see Privileges and Authorization Constants.
///Params:
///    hServer = Handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the RD Session Host server on which your application is running.
///    ShutdownFlag = Indicates the type of shutdown. This parameter can be one of the following values.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSShutdownSystem(HANDLE hServer, uint ShutdownFlag);

///Waits for a Remote Desktop Services event before returning to the caller.
///Params:
///    hServer = Handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              WTS_CURRENT_SERVER_HANDLE to indicate the RD Session Host server on which your application is running.
///    EventMask = Bitmask that specifies the set of events to wait for. This mask can be WTS_EVENT_FLUSH to cause all pending
///                <b>WTSWaitSystemEvent</b> calls on the specified RD Session Host server handle to return. Or, the mask can be a
///                combination of the following values.
///    pEventFlags = Pointer to a variable that receives a bitmask of the event or events that occurred. The returned mask can be a
///                  combination of the values from the previous list, or it can be <b>WTS_EVENT_NONE</b> if the wait terminated
///                  because of a <b>WTSWaitSystemEvent</b> call with <b>WTS_EVENT_FLUSH</b>.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSWaitSystemEvent(HANDLE hServer, uint EventMask, uint* pEventFlags);

///Opens a handle to the server end of a specified virtual channel. This function is obsolete. Instead, use the
///WTSVirtualChannelOpenEx function.
///Params:
///    hServer = This parameter must be WTS_CURRENT_SERVER_HANDLE.
///    SessionId = A Remote Desktop Services session identifier. To indicate the current session, specify
///                <b>WTS_CURRENT_SESSION</b>. You can use the WTSEnumerateSessions function to retrieve the identifiers of all
///                sessions on a specified RD Session Host server. To open a virtual channel on another user's session, you need to
///                have permission from the Virtual Channel. For more information, see Remote Desktop Services Permissions. To
///                modify permissions on a session, use the Remote Desktop Services Configuration administrative tool.
///    pVirtualName = A pointer to a <b>null</b>-terminated string containing the virtual channel name. Note that this is an ANSI
///                   string even when UNICODE is defined. The virtual channel name consists of one to CHANNEL_NAME_LEN characters, not
///                   including the terminating <b>null</b>.
///Returns:
///    If the function succeeds, the return value is a handle to the specified virtual channel. If the function fails,
///    the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
HwtsVirtualChannelHandle WTSVirtualChannelOpen(HANDLE hServer, uint SessionId, const(char)* pVirtualName);

///Creates a virtual channel in a manner similar to WTSVirtualChannelOpen. This API supports both static virtual channel
///(SVC) and dynamic virtual channel (DVC) creation. If the <i>flags</i> parameter is zero, it behaves the same as
///WTSVirtualChannelOpen. A DVC can be opened by specifying the appropriate flag. After a DVC is created, you can use
///the same functions for Read, Write, Query, or Close that are used for the SVC.
///Params:
///    SessionId = A Remote Desktop Services session identifier. To indicate the current session, specify
///                <b>WTS_CURRENT_SESSION</b>. You can use the WTSEnumerateSessions function to retrieve the identifiers of all
///                sessions on a specified RD Session Host server. To be able to open a virtual channel on another user's session,
///                you must have the Virtual Channels permission. For more information, see Remote Desktop Services Permissions. To
///                modify permissions on a session, use the Remote Desktop Services Configuration administrative tool.
///    pVirtualName = In the case of an SVC, points to a null-terminated string that contains the virtual channel name. The length of
///                   an SVC name is limited to <b>CHANNEL_NAME_LEN</b> characters, not including the terminating null. In the case of
///                   a DVC, points to a null-terminated string that contains the endpoint name of the listener. The length of a DVC
///                   name is limited to <b>MAX_PATH</b> characters.
///    flags = To open the channel as an SVC, specify zero for this parameter. To open the channel as a DVC, specify
///            <b>WTS_CHANNEL_OPTION_DYNAMIC</b>. When opening a DVC, you can specify a priority setting for the data that is
///            being transferred by specifying one of the <b>WTS_CHANNEL_OPTION_DYNAMIC_PRI_<i>XXX</i></b> values in combination
///            with the <b>WTS_CHANNEL_OPTION_DYNAMIC</b> value.
///Returns:
///    <b>NULL</b> on error with GetLastError set.
///    
@DllImport("WTSAPI32")
HwtsVirtualChannelHandle WTSVirtualChannelOpenEx(uint SessionId, const(char)* pVirtualName, uint flags);

///Closes an open virtual channel handle.
///Params:
///    hChannelHandle = Handle to a virtual channel opened by the WTSVirtualChannelOpen function.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSVirtualChannelClose(HANDLE hChannelHandle);

///Reads data from the server end of a virtual channel. <b>WTSVirtualChannelRead</b> reads the data written by a
///VirtualChannelWrite call at the client end of the virtual channel.
///Params:
///    hChannelHandle = Handle to a virtual channel opened by the WTSVirtualChannelOpen function.
///    TimeOut = Specifies the time-out, in milliseconds. If <i>TimeOut</i> is zero, <b>WTSVirtualChannelRead</b> returns
///              immediately if there is no data to read. If <i>TimeOut</i> is INFINITE (defined in Winbase.h), the function waits
///              indefinitely until there is data to read.
///    Buffer = Pointer to a buffer that receives a chunk of data read from the server end of the virtual channel. The maximum
///             amount of data that the server can receive in a single <b>WTSVirtualChannelRead</b> call is
///             <b>CHANNEL_CHUNK_LENGTH</b> bytes. If the client's VirtualChannelWrite call writes a larger block of data, the
///             server must make multiple <b>WTSVirtualChannelRead</b> calls. In certain cases, Remote Desktop Services places a
///             <b>CHANNEL_PDU_HEADER</b> structure at the beginning of each chunk of data read by the
///             <b>WTSVirtualChannelRead</b> function. This will occur if the client DLL sets the
///             <b>CHANNEL_OPTION_SHOW_PROTOCOL</b> option when it calls the VirtualChannelInit function to initialize the
///             virtual channel. This will also occur if the channel is a dynamic virtual channel written to by using the
///             IWTSVirtualChannel::Write method. Otherwise, the buffer receives only the data written in the VirtualChannelWrite
///             call.
///    BufferSize = Specifies the size, in bytes, of <i>Buffer</i>. If the chunk of data in <i>Buffer</i> will be preceded by a
///                 <b>CHANNEL_PDU_HEADER</b> structure, the value of this parameter should be at least <b>CHANNEL_PDU_LENGTH</b>.
///                 Otherwise, the value of this parameter should be at least <b>CHANNEL_CHUNK_LENGTH</b>.
///    pBytesRead = Pointer to a variable that receives the number of bytes read.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSVirtualChannelRead(HANDLE hChannelHandle, uint TimeOut, const(char)* Buffer, uint BufferSize, 
                           uint* pBytesRead);

///Writes data to the server end of a virtual channel.
///Params:
///    hChannelHandle = Handle to a virtual channel opened by the WTSVirtualChannelOpen function.
///    Buffer = Pointer to a buffer containing the data to write to the virtual channel.
///    Length = Specifies the size, in bytes, of the data to write.
///    pBytesWritten = Pointer to a variable that receives the number of bytes written.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSVirtualChannelWrite(HANDLE hChannelHandle, const(char)* Buffer, uint Length, uint* pBytesWritten);

///Deletes all queued input data sent from the client to the server on a specified virtual channel.<div
///class="alert"><b>Note</b> This function currently is not used by Remote Desktop Services.</div> <div> </div>
///Params:
///    hChannelHandle = Handle to a virtual channel opened by the WTSVirtualChannelOpen function.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSVirtualChannelPurgeInput(HANDLE hChannelHandle);

///Deletes all queued output data sent from the server to the client on a specified virtual channel.<div
///class="alert"><b>Note</b> This function currently is not used by Remote Desktop Services.</div> <div> </div>
///Params:
///    hChannelHandle = Handle to a virtual channel opened by the WTSVirtualChannelOpen function.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSVirtualChannelPurgeOutput(HANDLE hChannelHandle);

///Returns information about a specified virtual channel.
///Params:
///    hChannelHandle = Handle to a virtual channel opened by the WTSVirtualChannelOpen function.
///    WTS_VIRTUAL_CLASS = Specifies the type of information returned in the <i>ppBuffer</i> parameter. This parameter can be a value from
///                        the WTS_VIRTUAL_CLASS enumeration type.
///    ppBuffer = Pointer to a buffer that receives the requested information.
///    pBytesReturned = Pointer to a variable that receives the number of bytes returned in the <i>ppBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is a nonzero value. Call the WTSFreeMemory function with the value
///    returned in the <i>ppBuffer</i> parameter to free the temporary memory allocated by
///    <b>WTSVirtualChannelQuery</b>. If the function fails, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSVirtualChannelQuery(HANDLE hChannelHandle, WTS_VIRTUAL_CLASS param1, void** ppBuffer, uint* pBytesReturned);

///Frees memory allocated by a Remote Desktop Services function.
///Params:
///    pMemory = Pointer to the memory to free.
@DllImport("WTSAPI32")
void WTSFreeMemory(void* pMemory);

///Registers the specified window to receive session change notifications.
///Params:
///    hWnd = Handle of the window to receive session change notifications.
///    dwFlags = Specifies which session notifications are to be received. This parameter can be one of the following values.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. Otherwise, it is <b>FALSE</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSRegisterSessionNotification(HWND hWnd, uint dwFlags);

///Unregisters the specified window so that it receives no further session change notifications.
///Params:
///    hWnd = Handle of the window to be unregistered from receiving session notifications.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. Otherwise, it is <b>FALSE</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSUnRegisterSessionNotification(HWND hWnd);

///Registers the specified window to receive session change notifications.
///Params:
///    hServer = Handle of the server returned from WTSOpenServer or <b>WTS_CURRENT_SERVER</b>.
///    hWnd = Handle of the window to receive session change notifications.
///    dwFlags = Specifies which session notifications are to be received. This parameter can only be
///              <b>NOTIFY_FOR_THIS_SESSION</b> if <i>hServer</i> is a remote server.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. Otherwise, it is <b>FALSE</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("WINSTA")
BOOL WTSRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd, uint dwFlags);

///Unregisters the specified window so that it receives no further session change notifications.
///Params:
///    hServer = Handle of the server returned from WTSOpenServer or <b>WTS_CURRENT_SERVER</b>.
///    hWnd = Handle of the window to be unregistered from receiving session notifications.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. Otherwise, it is <b>FALSE</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("WINSTA")
BOOL WTSUnRegisterSessionNotificationEx(HANDLE hServer, HWND hWnd);

///Obtains the primary access token of the logged-on user specified by the session ID. To call this function
///successfully, the calling application must be running within the context of the LocalSystem account and have the
///<b>SE_TCB_NAME</b> privilege. <div class="alert"><b>Caution</b> <b>WTSQueryUserToken</b> is intended for highly
///trusted services. Service providers must use caution that they do not leak user tokens when calling this function.
///Service providers must close token handles after they have finished using them.</div><div> </div>
///Params:
///    SessionId = A Remote Desktop Services session identifier. Any program running in the context of a service will have a session
///                identifier of zero (0). You can use the WTSEnumerateSessions function to retrieve the identifiers of all sessions
///                on a specified RD Session Host server. To be able to query information for another user's session, you need to
///                have the Query Information permission. For more information, see <a
///                href="/windows/desktop/TermServ/terminal-services-permissions">Remote Desktop Services Permissions</a>. To modify
///                permissions on a session, use the Remote Desktop Services Configuration administrative tool.
///    phToken = If the function succeeds, receives a pointer to the token handle for the logged-on user. Note that you must call
///              the CloseHandle function to close this handle.
///Returns:
///    If the function succeeds, the return value is a nonzero value, and the <i>phToken</i> parameter points to the
///    primary token of the user. If the function fails, the return value is zero. To get extended error information,
///    call GetLastError. Among other errors, <b>GetLastError</b> can return one of the following errors.
///    
@DllImport("WTSAPI32")
BOOL WTSQueryUserToken(uint SessionId, ptrdiff_t* phToken);

///Frees memory that contains WTS_PROCESS_INFO_EX or WTS_SESSION_INFO_1 structures allocated by a Remote Desktop
///Services function.
///Params:
///    WTSTypeClass = A value of the WTS_TYPE_CLASS enumeration type that specifies the type of structures contained in the buffer
///                   referenced by the <i>pMemory</i> parameter.
///    pMemory = A pointer to the buffer to free.
///    NumberOfEntries = The number of elements in the buffer referenced by the <i>pMemory</i> parameter.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSFreeMemoryExW(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

///Frees memory that contains WTS_PROCESS_INFO_EX or WTS_SESSION_INFO_1 structures allocated by a Remote Desktop
///Services function.
///Params:
///    WTSTypeClass = A value of the WTS_TYPE_CLASS enumeration type that specifies the type of structures contained in the buffer
///                   referenced by the <i>pMemory</i> parameter.
///    pMemory = A pointer to the buffer to free.
///    NumberOfEntries = The number of elements in the buffer referenced by the <i>pMemory</i> parameter.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSFreeMemoryExA(WTS_TYPE_CLASS WTSTypeClass, void* pMemory, uint NumberOfEntries);

///Retrieves information about the active processes on the specified Remote Desktop Session Host (RD Session Host)
///server or Remote Desktop Virtualization Host (RD Virtualization Host) server.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the server on which your application is running.
///    pLevel = A pointer to a <b>DWORD</b> variable that, on input, specifies the type of information to return. To return an
///             array of WTS_PROCESS_INFO structures, specify zero. To return an array of WTS_PROCESS_INFO_EX structures, specify
///             one. If you do not specify a valid value for this parameter, on output, <b>WTSEnumerateProcessesEx</b> sets this
///             parameter to one and returns an error. Otherwise, on output, <b>WTSEnumerateProcessesEx</b> does not change the
///             value of this parameter.
///    SessionId = The session for which to enumerate processes. To enumerate processes for all sessions on the server, specify
///                <b>WTS_ANY_SESSION</b>.
///    ppProcessInfo = A pointer to a variable that receives a pointer to an array of WTS_PROCESS_INFO or WTS_PROCESS_INFO_EX
///                    structures. The type of structure is determined by the value passed to the <i>pLevel</i> parameter. Each
///                    structure in the array contains information about an active process. When you have finished using the array, free
///                    it by calling the WTSFreeMemoryEx function. You should also set the pointer to <b>NULL</b>.
///    pCount = A pointer to a variable that receives the number of structures returned in the buffer referenced by the
///             <i>ppProcessInfo</i> parameter.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesExW(HANDLE hServer, uint* pLevel, uint SessionId, ushort** ppProcessInfo, uint* pCount);

///Retrieves information about the active processes on the specified Remote Desktop Session Host (RD Session Host)
///server or Remote Desktop Virtualization Host (RD Virtualization Host) server.
///Params:
///    hServer = A handle to an RD Session Host server. Specify a handle opened by the WTSOpenServer function, or specify
///              <b>WTS_CURRENT_SERVER_HANDLE</b> to indicate the server on which your application is running.
///    pLevel = A pointer to a <b>DWORD</b> variable that, on input, specifies the type of information to return. To return an
///             array of WTS_PROCESS_INFO structures, specify zero. To return an array of WTS_PROCESS_INFO_EX structures, specify
///             one. If you do not specify a valid value for this parameter, on output, <b>WTSEnumerateProcessesEx</b> sets this
///             parameter to one and returns an error. Otherwise, on output, <b>WTSEnumerateProcessesEx</b> does not change the
///             value of this parameter.
///    SessionId = The session for which to enumerate processes. To enumerate processes for all sessions on the server, specify
///                <b>WTS_ANY_SESSION</b>.
///    ppProcessInfo = A pointer to a variable that receives a pointer to an array of WTS_PROCESS_INFO or WTS_PROCESS_INFO_EX
///                    structures. The type of structure is determined by the value passed to the <i>pLevel</i> parameter. Each
///                    structure in the array contains information about an active process. When you have finished using the array, free
///                    it by calling the WTSFreeMemoryEx function. You should also set the pointer to <b>NULL</b>.
///    pCount = A pointer to a variable that receives the number of structures returned in the buffer referenced by the
///             <i>ppProcessInfo</i> parameter.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateProcessesExA(HANDLE hServer, uint* pLevel, uint SessionId, byte** ppProcessInfo, uint* pCount);

///Enumerates all the Remote Desktop Services listeners on a Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListeners = A pointer to an array of <b>WTSLISTENERNAME</b> variables that receive the names of the listeners.
///    pCount = A pointer to a <b>DWORD</b> variable that contains the number of listener names in the array referenced by the
///             <i>pListeners</i> parameter. If the number of listener names is unknown, pass <i>pListeners</i> as <b>NULL</b>.
///             The function will return the number of <b>WTSLISTENERNAME</b> variables necessary to allocate for the array
///             pointed to by the <i>pListeners</i> parameter.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateListenersW(HANDLE hServer, void* pReserved, uint Reserved, char* pListeners, uint* pCount);

///Enumerates all the Remote Desktop Services listeners on a Remote Desktop Session Host (RD Session Host) server.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListeners = A pointer to an array of <b>WTSLISTENERNAME</b> variables that receive the names of the listeners.
///    pCount = A pointer to a <b>DWORD</b> variable that contains the number of listener names in the array referenced by the
///             <i>pListeners</i> parameter. If the number of listener names is unknown, pass <i>pListeners</i> as <b>NULL</b>.
///             The function will return the number of <b>WTSLISTENERNAME</b> variables necessary to allocate for the array
///             pointed to by the <i>pListeners</i> parameter.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("WTSAPI32")
BOOL WTSEnumerateListenersA(HANDLE hServer, void* pReserved, uint Reserved, char* pListeners, uint* pCount);

///Retrieves configuration information for a Remote Desktop Services listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener to query.
///    pBuffer = A pointer to a WTSLISTENERCONFIG structure that receives the retrieved listener configuration information.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSQueryListenerConfigW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                             WTSLISTENERCONFIGW* pBuffer);

///Retrieves configuration information for a Remote Desktop Services listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener to query.
///    pBuffer = A pointer to a WTSLISTENERCONFIG structure that receives the retrieved listener configuration information.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSQueryListenerConfigA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                             WTSLISTENERCONFIGA* pBuffer);

///Creates a new Remote Desktop Services listener or configures an existing listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener to create or configure.
///    pBuffer = A pointer to a WTSLISTENERCONFIG structure that contains configuration information for the listener.
///    flag = The purpose of the call. This parameter can be one of the following values.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSCreateListenerW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                        WTSLISTENERCONFIGW* pBuffer, uint flag);

///Creates a new Remote Desktop Services listener or configures an existing listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener to create or configure.
///    pBuffer = A pointer to a WTSLISTENERCONFIG structure that contains configuration information for the listener.
///    flag = The purpose of the call. This parameter can be one of the following values.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSCreateListenerA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                        WTSLISTENERCONFIGA* pBuffer, uint flag);

///Configures the security descriptor of a Remote Desktop Services listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener.
///    SecurityInformation = A SECURITY_INFORMATION value that specifies the security information to set. Always enable the
///                          <b>DACL_SECURITY_INFORMATION</b> and <b>SACL_SECURITY_INFORMATION</b> flags. For more information about possible
///                          values, see SECURITY_INFORMATION.
///    pSecurityDescriptor = A pointer to a SECURITY_DESCRIPTOR structure that contains the security information associated with the listener.
///                          For more information about possible values, see <b>SECURITY_DESCRIPTOR</b>. For information about
///                          <b>STANDARD_RIGHTS_REQUIRED</b>, see Standard Access Rights. The discretionary access control list (DACL) of the
///                          security descriptor can contain one or more of the following values.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSSetListenerSecurityW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor);

///Configures the security descriptor of a Remote Desktop Services listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener.
///    SecurityInformation = A SECURITY_INFORMATION value that specifies the security information to set. Always enable the
///                          <b>DACL_SECURITY_INFORMATION</b> and <b>SACL_SECURITY_INFORMATION</b> flags. For more information about possible
///                          values, see SECURITY_INFORMATION.
///    pSecurityDescriptor = A pointer to a SECURITY_DESCRIPTOR structure that contains the security information associated with the listener.
///                          For more information about possible values, see <b>SECURITY_DESCRIPTOR</b>. For information about
///                          <b>STANDARD_RIGHTS_REQUIRED</b>, see Standard Access Rights. The discretionary access control list (DACL) of the
///                          security descriptor can contain one or more of the following values.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSSetListenerSecurityA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor);

///Retrieves the security descriptor of a Remote Desktop Services listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener.
///    SecurityInformation = A SECURITY_INFORMATION value that specifies the security information to retrieve. Always enable the
///                          <b>DACL_SECURITY_INFORMATION</b> and <b>SACL_SECURITY_INFORMATION</b> flags. For more information about possible
///                          values, see SECURITY_INFORMATION.
///    pSecurityDescriptor = A pointer to a SECURITY_DESCRIPTOR structure that receives the security information associated with the listener
///                          referenced by the <i>pListenerName</i> parameter. The <b>SECURITY_DESCRIPTOR</b> structure is returned in
///                          self-relative format. For more information about possible values, see <b>SECURITY_DESCRIPTOR</b>. The
///                          discretionary access control list (DACL) of the security descriptor can contain one or more of the following
///                          values.
///    nLength = The size, in bytes, of the SECURITY_DESCRIPTOR structure referenced by the <i>pSecurityDescriptor</i> parameter.
///    lpnLengthNeeded = A pointer to a variable that receives the number of bytes required to store the complete security descriptor. If
///                      this number is less than or equal to the value of the <i>nLength</i> parameter, the security descriptor is copied
///                      to the SECURITY_DESCRIPTOR structure referenced by the <i>pSecurityDescriptor</i> parameter; otherwise, no action
///                      is taken.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSGetListenerSecurityW(HANDLE hServer, void* pReserved, uint Reserved, const(wchar)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor, uint nLength, 
                             uint* lpnLengthNeeded);

///Retrieves the security descriptor of a Remote Desktop Services listener.
///Params:
///    hServer = A handle to an RD Session Host server. Always set this parameter to <b>WTS_CURRENT_SERVER_HANDLE</b>.
///    pReserved = This parameter is reserved. Always set this parameter to <b>NULL</b>.
///    Reserved = This parameter is reserved. Always set this parameter to zero.
///    pListenerName = A pointer to a null-terminated string that contains the name of the listener.
///    SecurityInformation = A SECURITY_INFORMATION value that specifies the security information to retrieve. Always enable the
///                          <b>DACL_SECURITY_INFORMATION</b> and <b>SACL_SECURITY_INFORMATION</b> flags. For more information about possible
///                          values, see SECURITY_INFORMATION.
///    pSecurityDescriptor = A pointer to a SECURITY_DESCRIPTOR structure that receives the security information associated with the listener
///                          referenced by the <i>pListenerName</i> parameter. The <b>SECURITY_DESCRIPTOR</b> structure is returned in
///                          self-relative format. For more information about possible values, see <b>SECURITY_DESCRIPTOR</b>. The
///                          discretionary access control list (DACL) of the security descriptor can contain one or more of the following
///                          values.
///    nLength = The size, in bytes, of the SECURITY_DESCRIPTOR structure referenced by the <i>pSecurityDescriptor</i> parameter.
///    lpnLengthNeeded = A pointer to a variable that receives the number of bytes required to store the complete security descriptor. If
///                      this number is less than or equal to the value of the <i>nLength</i> parameter, the security descriptor is copied
///                      to the SECURITY_DESCRIPTOR structure referenced by the <i>pSecurityDescriptor</i> parameter; otherwise, no action
///                      is taken.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call the GetLastError function.
///    
@DllImport("WTSAPI32")
BOOL WTSGetListenerSecurityA(HANDLE hServer, void* pReserved, uint Reserved, const(char)* pListenerName, 
                             uint SecurityInformation, void* pSecurityDescriptor, uint nLength, 
                             uint* lpnLengthNeeded);

///Enables or disables Child Sessions.
///Params:
///    bEnable = Indicates whether to enable or disable child sessions. Pass <b>TRUE</b> if child sessions are to be enabled or
///              <b>FALSE</b> otherwise.
///Returns:
///    Returns nonzero if the function succeeds or zero otherwise.
///    
@DllImport("WTSAPI32")
BOOL WTSEnableChildSessions(BOOL bEnable);

///Determines whether child sessions are enabled.
///Params:
///    pbEnabled = The address of a <b>BOOL</b> variable that receives a nonzero value if child sessions are enabled or zero
///                otherwise.
///Returns:
///    Returns nonzero if the function succeeds or zero otherwise.
///    
@DllImport("WTSAPI32")
BOOL WTSIsChildSessionsEnabled(int* pbEnabled);

///Retrieves the child session identifier, if present.
///Params:
///    pSessionId = The address of a <b>ULONG</b> variable that receives the child session identifier. This will be
///                 (<b>ULONG</b>)–1 if there is no child session for the current session.
///Returns:
///    Returns nonzero if the function succeeds or zero otherwise.
///    
@DllImport("WTSAPI32")
BOOL WTSGetChildSessionId(uint* pSessionId);

///Used by an application that is displaying content that can be optimized for displaying in a remote session to
///identify the region of a window that is the actual content. In the remote session, this content will be encoded, sent
///to the client, then decoded and displayed.
///Params:
///    pRenderHintID = The address of a value that identifies the rendering hint affected by this call. If a new hint is being created,
///                    this value must contain zero. This function will return a unique rendering hint identifier which is used for
///                    subsequent calls, such as clearing the hint.
///    hwndOwner = The handle of window linked to lifetime of the rendering hint. This window is used in situations where a hint
///                target is removed without the hint being explicitly cleared.
///    renderHintType = Specifies the type of hint represented by this call.
///    cbHintDataLength = The size, in <b>BYTE</b>s, of the <i>pHintData</i> buffer.
///    pHintData = Additional data for the hint. The format of this data is dependent upon the value passed in the
///                <i>renderHintType</i> parameter.
@DllImport("WTSAPI32")
HRESULT WTSSetRenderHint(ulong* pRenderHintID, HWND hwndOwner, uint renderHintType, uint cbHintDataLength, 
                         char* pHintData);


// Interfaces

@GUID("0910DD01-DF8C-11D1-AE27-00C04FA35813")
struct TSUserExInterfaces;

@GUID("E2E9CAE6-1E7B-4B8E-BABD-E9BF6292AC29")
struct ADsTSUserEx;

@GUID("4F1DFCA6-3AAD-48E1-8406-4BC21A501D7C")
struct Workspace;

///Provides information to the audio engine about an audio endpoint. This interface is implemented by an audio endpoint.
@GUID("30A99515-1527-4451-AF9F-00C5F0234DAF")
interface IAudioEndpoint : IUnknown
{
    ///The <b>GetFrameFormat</b> method retrieves the format of the audio endpoint.
    ///Params:
    ///    ppFormat = Receives a pointer to a <b>WAVEFORMATEX</b> structure that contains the format information for the device
    ///               that the audio endpoint represents. The implementation must allocate memory for the structure by using
    ///               <b>CoTaskMemAlloc</b>. The caller must free the buffer by using <b>CoTaskMemFree</b>. For information about
    ///               CoTaskMemAlloc and CoTaskMemFree, see the Windows SDK documentation.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetFrameFormat(WAVEFORMATEX** ppFormat);
    ///The <b>GetFramesPerPacket</b> method gets the maximum number of frames per packet that the audio endpoint can
    ///support, based on the endpoint's period and the sample rate.
    ///Params:
    ///    pFramesPerPacket = Receives the maximum number of frames per packet that the endpoint can support.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetFramesPerPacket(uint* pFramesPerPacket);
    ///The <b>GetLatency</b> method gets the latency of the audio endpoint.
    ///Params:
    ///    pLatency = A pointer to an <b>HNSTIME</b> variable that receives the latency that is added to the stream by the audio
    ///               endpoint.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetLatency(long* pLatency);
    ///The <b>SetStreamFlags</b> method sets the stream configuration flags on the audio endpoint.
    ///Params:
    ///    streamFlags = A bitwise <b>OR</b> of one or more of the AUDCLNT_STREAMFLAGS_XXX constants.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT SetStreamFlags(uint streamFlags);
    ///The <b>SetEventHandle</b> method sets the handle for the event that the endpoint uses to signal that it has
    ///completed processing of a buffer.
    ///Params:
    ///    eventHandle = The event handle used to invoke a buffer completion callback.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. If it fails, possible return codes include, but are not
    ///    limited to, the following.
    ///    
    HRESULT SetEventHandle(HANDLE eventHandle);
}

///Gets the difference between the current read and write positions in the endpoint buffer. The <b>IAudioEndpointRT</b>
///interface is used by the audio engine. <b>IAudioEndpointRT</b> methods can be called from a real-time processing
///thread. The implementation of the methods of this interface must not block, access paged memory, or call any blocking
///system routines.
@GUID("DFD2005F-A6E5-4D39-A265-939ADA9FBB4D")
interface IAudioEndpointRT : IUnknown
{
    ///The <b>GetCurrentPadding</b> method gets the amount, in 100-nanosecond units, of data that is queued up in the
    ///endpoint.
    ///Params:
    ///    pPadding = Receives the number of frames available in the endpoint buffer.
    ///    pAeCurrentPosition = Receives information about the position of the current frame in the endpoint buffer in an AE_CURRENT_POSITION
    ///                         structure specified by the caller.
    void    GetCurrentPadding(long* pPadding, AE_CURRENT_POSITION* pAeCurrentPosition);
    ///The <b>ProcessingComplete</b> method notifies the endpoint that a processing pass has been completed.
    void    ProcessingComplete();
    ///The <b>SetPinInactive</b> method notifies the endpoint that it must change the state of the underlying stream
    ///resources to an inactive state.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT SetPinInactive();
    ///The <b>SetPinActive</b> method notifies the endpoint that it must change the state of the underlying streaming
    ///resources to an active state.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT SetPinActive();
}

///Gets the input buffer for each processing pass.The <b>IAudioInputEndpointRT</b> interface is used by the audio
///engine.
@GUID("8026AB61-92B2-43C1-A1DF-5C37EBD08D82")
interface IAudioInputEndpointRT : IUnknown
{
    ///The <b>GetInputDataPointer</b> method gets a pointer to the buffer from which data will be read by the audio
    ///engine.
    ///Params:
    ///    pConnectionProperty = A pointer to an APO_CONNECTION_PROPERTYstructure. The caller sets the member values as follows: <ul>
    ///                          <li><b>pBuffer</b> is set to <b>NULL</b>.</li> <li><b>u32ValidFrameCount</b> contains the number of frames
    ///                          that need to be in the retrieved data pointer. The endpoint object must not cache this information. The audio
    ///                          engine can change this number depending on its processing needs.</li> <li><b>u32BufferFlags</b> is set to
    ///                          <b>BUFFER_INVALID</b>.</li> </ul> If this call completes successfully, the endpoint must set the member
    ///                          values as follows: <ul> <li><b>pBuffer</b> points to valid memory where the data has been read. This could
    ///                          include silence depending on the flags that were set in the <b>u32BufferFlags</b> member.</li>
    ///                          <li><b>u32ValidFrameCount</b> is unchanged.</li> <li><b>u32BufferFlags</b> is set to <b>BUFFER_VALID</b> if
    ///                          the data pointer contains valid data or to <b>BUFFER_SILENT</b> if the data pointer contains only silent
    ///                          data. The data in the buffer does not actually need to be silence, but the buffer specified in <b>pBuffer</b>
    ///                          must be capable of holding all the frames of silence contained in <b>u32ValidFrameCount</b> to match the
    ///                          required frame count.</li> </ul>
    ///    pAeTimeStamp = A pointer to an AE_CURRENT_POSITION structure that contains the time stamp of the data that is captured in
    ///                   the buffer. This parameter is optional.
    void GetInputDataPointer(APO_CONNECTION_PROPERTY* pConnectionProperty, AE_CURRENT_POSITION* pAeTimeStamp);
    ///The <b>ReleaseInputDataPointer</b> method releases the acquired data pointer.
    ///Params:
    ///    u32FrameCount = The number of frames that have been consumed by the audio engine. This count might not be the same as the
    ///                    value returned by the IAudioInputEndpointRT::GetInputDataPointer method in the
    ///                    <i>pConnectionProperty</i>-&gt;<b>u32ValidFrameCount</b> member.
    ///    pDataPointer = The pointer to the buffer retrieved by the GetInputDataPointer method received in the
    ///                   <i>pConnectionProperty</i>-&gt;<b>pBuffer</b> member.
    void ReleaseInputDataPointer(uint u32FrameCount, size_t pDataPointer);
    ///The <b>PulseEndpoint</b> method is reserved.
    void PulseEndpoint();
}

///Gets the output buffer for each processing pass. The <b>IAudioOutputEndpointRT</b> interface is used by the audio
///engine.
@GUID("8FA906E4-C31C-4E31-932E-19A66385E9AA")
interface IAudioOutputEndpointRT : IUnknown
{
    ///The <b>GetOutputDataPointer</b> method returns a pointer to the output buffer in which data will be written by
    ///the audio engine.
    ///Params:
    ///    u32FrameCount = The number of frames in the output buffer pointed to by the data pointer that is returned by this method. The
    ///                    endpoint must not cache this information because this can be changed by the audio engine depending on its
    ///                    processing requirements. For more information, see Remarks.
    ///    pAeTimeStamp = A pointer to an AE_CURRENT_POSITION structure that specifies the time stamp of the data that is rendered.
    ///                   This parameter is optional.
    ///Returns:
    ///    A pointer to the buffer to which data will be written.
    ///    
    size_t GetOutputDataPointer(uint u32FrameCount, AE_CURRENT_POSITION* pAeTimeStamp);
    ///The <b>ReleaseOutputDataPointer</b> method releases the pointer to the output buffer.
    ///Params:
    ///    pConnectionProperty = A pointer to an APO_CONNECTION_PROPERTYstructure. The values in the structure must not be changed. The caller
    ///                          sets the members as follows: <ul> <li><b>pBuffer</b> is set to the pointer to the output data buffer returned
    ///                          by the IAudioOutputEndpointRT::GetOutputDataPointer method.</li> <li><b>u32ValidFrameCount</b> is set to the
    ///                          actual number of frames that have been generated by the audio engine. The value might not be the same as the
    ///                          frame count passed in the <i>u32FrameCount</i> parameter of the GetOutputDataPointer method.</li>
    ///                          <li><b>u32BufferFlags</b> is set to <b>BUFFER_VALID</b> if the output buffer pointed to by the <b>pBuffer</b>
    ///                          member contains valid data. <b>u32BufferFlags</b> is set to <b>BUFFER_SILENT</b> if the output buffer
    ///                          contains only silent data. The data in the buffer does not actually need to be silence, but the buffer
    ///                          specified in the <b>pBuffer</b> member must be capable of holding all the frames of silence contained in the
    ///                          <b>u32ValidFrameCount</b> member. Therefore, if <b>BUFFER_SILENT</b> is specified, the endpoint should write
    ///                          silence in the output buffer.</li> </ul>
    void   ReleaseOutputDataPointer(const(APO_CONNECTION_PROPERTY)* pConnectionProperty);
    ///The <b>PulseEndpoint</b> method is reserved. This method is called by the audio engine at the end of a processing
    ///pass. The event handle is set by calling the IAudioEndpoint::SetEventHandle method.
    void   PulseEndpoint();
}

///Initializes a device endpoint object and gets the capabilities of the device that it represents. A <i>device
///endpoint</i> abstracts an audio device. The device can be a rendering device such as a speaker or a capture device
///such as a microphone. A device endpoint must implement the <b>IAudioDeviceEndpoint</b> interface. To a get a
///reference to the <b>IAudioDeviceEndpoint</b> interface of the device, the audio engine calls <b>QueryInterface</b> on
///the audio endpoint (IAudioInputEndpointRT or IAudioOutputEndpointRT) for the device.
@GUID("D4952F5A-A0B2-4CC4-8B82-9358488DD8AC")
interface IAudioDeviceEndpoint : IUnknown
{
    ///The <b>SetBuffer</b> method initializes the endpoint and creates a buffer based on the format of the endpoint
    ///into which the audio data is streamed.
    ///Params:
    ///    MaxPeriod = The processing time, in 100-nanosecond units, of the audio endpoint.
    ///    u32LatencyCoefficient = The latency coefficient for the audio device. This value is used to calculate the latency. Latency =
    ///                            <i>u32LatencyCoefficient</i> * <i>MaxPeriod</i>. <div class="alert"><b>Note</b> The device that the endpoint
    ///                            represents has a minimum latency value. If the value of this parameter is less than the minimum latency of
    ///                            the device or is zero, the endpoint object applies the minimum latency. The audio engine can obtain the
    ///                            actual latency of the endpoint by calling the IAudioEndpoint::GetLatency method.</div> <div> </div>
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. If it fails, possible return codes include, but are not
    ///    limited to, the following.
    ///    
    HRESULT SetBuffer(long MaxPeriod, uint u32LatencyCoefficient);
    ///The <b>GetRTCaps</b> method queries whether the audio device is real-time (RT)-capable. This method is not used
    ///in Remote Desktop Services implementations of IAudioDeviceEndpoint.
    ///Params:
    ///    pbIsRTCapable = Receives <b>TRUE</b> if the audio device is RT-capable, or <b>FALSE</b> otherwise. Remote Desktop Services
    ///                    implementations should always return <b>FALSE</b>.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetRTCaps(int* pbIsRTCapable);
    ///The <b>GetEventDrivenCapable</b> method indicates whether the device endpoint is event driven. The device
    ///endpoint controls the period of the audio engine by setting events that signal buffer availability.
    ///Params:
    ///    pbisEventCapable = A value of <b>TRUE</b> indicates that the device endpoint is event driven. A value of <b>FALSE</b> indicates
    ///                       that it is not event driven. If the endpoint device is event driven, the audio engine can receive events from
    ///                       an audio device endpoint.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT GetEventDrivenCapable(int* pbisEventCapable);
    ///The <b>WriteExclusiveModeParametersToSharedMemory</b> method creates and writes the exclusive-mode parameters to
    ///shared memory.
    ///Params:
    ///    hTargetProcess = The handle of the process for which the handles will be duplicated.
    ///    hnsPeriod = The periodicity, in 100-nanosecond units, of the device. This value must fall within the range of the minimum
    ///                and maximum periodicity of the device represented by the endpoint.
    ///    hnsBufferDuration = The buffer duration, in 100-nanosecond units, requested by the client.
    ///    u32LatencyCoefficient = The latency coefficient of the audio endpoint. A client can obtain the actual latency of the endpoint by
    ///                            calling the IAudioEndpoint::GetLatency method.
    ///    pu32SharedMemorySize = Receives the size of the memory area shared by the service and the process.
    ///    phSharedMemory = Receives a handle to the memory area shared by the service and the process.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT WriteExclusiveModeParametersToSharedMemory(size_t hTargetProcess, long hnsPeriod, 
                                                       long hnsBufferDuration, uint u32LatencyCoefficient, 
                                                       uint* pu32SharedMemorySize, size_t* phSharedMemory);
}

///Controls the stream state of an endpoint.
@GUID("C684B72A-6DF4-4774-BDF9-76B77509B653")
interface IAudioEndpointControl : IUnknown
{
    ///The <b>Start</b> method starts the endpoint stream.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT Start();
    ///The <b>Reset</b> method resets the endpoint stream.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT Reset();
    ///The <b>Stop</b> method stops the endpoint stream.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>.
    ///    
    HRESULT Stop();
}

///The property methods of the <b>IADsTSUserEx</b> interface can be used to examine and configure Remote Desktop
///Services user properties. Properties include logon, TerminalServicesHomeDirectory, remote control, session, and
///environment properties of the <b>IADsTSUserEx</b> class. Before calling the methods of this interface, you must call
///the IADs::GetInfo method or the IADs::GetInfoEx method to load the property values of the ADSI object from the
///underlying directory store into the property cache. Call <b>IADs::GetInfo</b> to refresh all the property values for
///the class; call <b>IADs::GetInfoEx</b> to refresh the values of selected properties in the property cache. After
///calling the methods of this interface, you must call the IADs::SetInfo method to save the property value changes in
///the persistent store of the underlying directory store. For more information, see The ADSI Attribute Cache and the
///reference section for the ADSI Interfaces. For a general discussion on property methods, see Interface Property
///Methods. The following table lists the property methods of the <b>IADsTSUserEx</b> interface in vtable order.
@GUID("C4930E79-2989-4462-8A60-2FCF2F2955EF")
interface IADsTSUserEx : IDispatch
{
    ///The roaming or mandatory profile path to be used when the user logs on to the Remote Desktop Session Host (RD
    ///Session Host) server. This property is read/write.
    HRESULT get_TerminalServicesProfilePath(BSTR* pVal);
    ///The roaming or mandatory profile path to be used when the user logs on to the Remote Desktop Session Host (RD
    ///Session Host) server. This property is read/write.
    HRESULT put_TerminalServicesProfilePath(BSTR pNewVal);
    ///The root directory for the user. Each user on a Remote Desktop Session Host (RD Session Host) server has a unique
    ///root directory. This ensures that application information is stored separately for each user in a multiuser
    ///environment. This property is read/write.
    HRESULT get_TerminalServicesHomeDirectory(BSTR* pVal);
    ///The root directory for the user. Each user on a Remote Desktop Session Host (RD Session Host) server has a unique
    ///root directory. This ensures that application information is stored separately for each user in a multiuser
    ///environment. This property is read/write.
    HRESULT put_TerminalServicesHomeDirectory(BSTR pNewVal);
    ///The root drive for the user. In a network environment, this property is a string that contains a drive
    ///specification (a drive letter followed by a colon) to which the UNC path specified as the root directory is
    ///mapped. This property is read/write.
    HRESULT get_TerminalServicesHomeDrive(BSTR* pVal);
    ///The root drive for the user. In a network environment, this property is a string that contains a drive
    ///specification (a drive letter followed by a colon) to which the UNC path specified as the root directory is
    ///mapped. This property is read/write.
    HRESULT put_TerminalServicesHomeDrive(BSTR pNewVal);
    ///A value that specifies whether the user is allowed to log on to the Remote Desktop Session Host (RD Session Host)
    ///server. This property is read/write.
    HRESULT get_AllowLogon(int* pVal);
    ///A value that specifies whether the user is allowed to log on to the Remote Desktop Session Host (RD Session Host)
    ///server. This property is read/write.
    HRESULT put_AllowLogon(int NewVal);
    ///A value that specifies whether to allow remote observation or remote control of the user's Remote Desktop
    ///Services session. This property is read/write.
    HRESULT get_EnableRemoteControl(int* pVal);
    ///A value that specifies whether to allow remote observation or remote control of the user's Remote Desktop
    ///Services session. This property is read/write.
    HRESULT put_EnableRemoteControl(int NewVal);
    ///The maximum amount of time that a disconnected Remote Desktop Services session remains active on the Remote
    ///Desktop Session Host (RD Session Host) server. After the specified number of minutes have elapsed, the session is
    ///terminated. This property is read/write.
    HRESULT get_MaxDisconnectionTime(int* pVal);
    ///The maximum amount of time that a disconnected Remote Desktop Services session remains active on the Remote
    ///Desktop Session Host (RD Session Host) server. After the specified number of minutes have elapsed, the session is
    ///terminated. This property is read/write.
    HRESULT put_MaxDisconnectionTime(int NewVal);
    ///The maximum duration of the Remote Desktop Services session. After the specified number of minutes have elapsed,
    ///the session can be disconnected or terminated. This property is read/write.
    HRESULT get_MaxConnectionTime(int* pVal);
    ///The maximum duration of the Remote Desktop Services session. After the specified number of minutes have elapsed,
    ///the session can be disconnected or terminated. This property is read/write.
    HRESULT put_MaxConnectionTime(int NewVal);
    ///The maximum amount of time that the Remote Desktop Services session can remain idle. After the specified number
    ///of minutes has elapsed, the session can be disconnected or terminated. This property is read/write.
    HRESULT get_MaxIdleTime(int* pVal);
    ///The maximum amount of time that the Remote Desktop Services session can remain idle. After the specified number
    ///of minutes has elapsed, the session can be disconnected or terminated. This property is read/write.
    HRESULT put_MaxIdleTime(int NewVal);
    ///A value that specifies if reconnection to a disconnected Remote Desktop Services session is allowed. <div
    ///class="alert"><b>Note</b> This property is not used by Remote Desktop Services.</div><div> </div>This property is
    ///read/write.
    HRESULT get_ReconnectionAction(int* pNewVal);
    ///A value that specifies if reconnection to a disconnected Remote Desktop Services session is allowed. <div
    ///class="alert"><b>Note</b> This property is not used by Remote Desktop Services.</div><div> </div>This property is
    ///read/write.
    HRESULT put_ReconnectionAction(int NewVal);
    ///A value that specifies the action to take when a Remote Desktop Services session limit is reached. This property
    ///is read/write.
    HRESULT get_BrokenConnectionAction(int* pNewVal);
    ///A value that specifies the action to take when a Remote Desktop Services session limit is reached. This property
    ///is read/write.
    HRESULT put_BrokenConnectionAction(int NewVal);
    ///A value that specifies if mapped client drives should be reconnected when a Remote Desktop Services session is
    ///started. <div class="alert"><b>Note</b> This property is not used by Remote Desktop Services.</div><div>
    ///</div>This property is read/write.
    HRESULT get_ConnectClientDrivesAtLogon(int* pNewVal);
    ///A value that specifies if mapped client drives should be reconnected when a Remote Desktop Services session is
    ///started. <div class="alert"><b>Note</b> This property is not used by Remote Desktop Services.</div><div>
    ///</div>This property is read/write.
    HRESULT put_ConnectClientDrivesAtLogon(int NewVal);
    ///A value that specifies whether to reconnect to mapped client printers at logon. This property is read/write.
    HRESULT get_ConnectClientPrintersAtLogon(int* pVal);
    ///A value that specifies whether to reconnect to mapped client printers at logon. This property is read/write.
    HRESULT put_ConnectClientPrintersAtLogon(int NewVal);
    ///A value that specifies whether to print automatically to the client's default printer. This property is
    ///read/write.
    HRESULT get_DefaultToMainPrinter(int* pVal);
    ///A value that specifies whether to print automatically to the client's default printer. This property is
    ///read/write.
    HRESULT put_DefaultToMainPrinter(int NewVal);
    ///The working directory path for the user. This property is read/write.
    HRESULT get_TerminalServicesWorkDirectory(BSTR* pVal);
    ///The working directory path for the user. This property is read/write.
    HRESULT put_TerminalServicesWorkDirectory(BSTR pNewVal);
    ///The path and file name of the application that the user wants to start automatically when the user logs on to the
    ///Remote Desktop Session Host (RD Session Host) server. This property is read/write.
    HRESULT get_TerminalServicesInitialProgram(BSTR* pVal);
    ///The path and file name of the application that the user wants to start automatically when the user logs on to the
    ///Remote Desktop Session Host (RD Session Host) server. This property is read/write.
    HRESULT put_TerminalServicesInitialProgram(BSTR pNewVal);
}

///Exposes methods that notify Remote Desktop Gateway (RD Gateway) about the result of an attempt to authorize a
///connection. The authorization plug-in should not implement this interface because it is already implemented. A
///pointer to this interface is passed to the authorization plug-in when RD Gateway calls the AuthorizeConnection
///method.
@GUID("C27ECE33-7781-4318-98EF-1CF2DA7B7005")
interface ITSGAuthorizeConnectionSink : IUnknown
{
    ///Notifies Remote Desktop Gateway (RD Gateway) about the result of an attempt to authorize a connection.
    ///Params:
    ///    hrIn = The result of the authorization attempt. Specify <b>S_OK</b> to indicate that the attempt succeeded. Specify
    ///           any other value to indicate that the attempt failed.
    ///    mainSessionId = A unique identifier assigned to the connection request by RD Gateway.
    ///    cbSoHResponse = The number of bytes referenced by the <i>pbSoHResponse</i> parameter.
    ///    pbSoHResponse = A pointer to a <b>BYTE</b> that specifies the response to the request for a statement of health (SoH). If the
    ///                    <i>hrIn</i> parameter is not <b>S_OK</b>, this parameter is ignored.
    ///    idleTimeout = The number of minutes that the connection can remain idle before being disconnected. If the <i>hrIn</i>
    ///                  parameter is not <b>S_OK</b>, this parameter is ignored.
    ///    sessionTimeout = The maximum number of minutes allotted to the session. If the <i>hrIn</i> parameter is not <b>S_OK</b>, this
    ///                     parameter is ignored.
    ///    sessionTimeoutAction = The action to be taken when the session times out. If the <i>hrIn</i> parameter is not <b>S_OK</b>, this
    ///                           parameter is ignored. This parameter can be one of the following values.
    ///    trustClass = This parameter is reserved. Always set it to <b>AA_TRUSTEDUSER_TRUSTEDCLIENT</b>. If the <i>hrIn</i>
    ///                 parameter is not <b>S_OK</b>, this parameter is ignored.
    ///    policyAttributes = An array of Boolean values that specify the redirection settings associated with the connection. Each element
    ///                       of the array corresponds to a value of the PolicyAttributeType enumeration. If the <i>hrIn</i> parameter is
    ///                       not <b>S_OK</b>, this parameter is ignored.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnConnectionAuthorized(HRESULT hrIn, GUID mainSessionId, uint cbSoHResponse, char* pbSoHResponse, 
                                   uint idleTimeout, uint sessionTimeout, 
                                   __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0004 sessionTimeoutAction, 
                                   __MIDL___MIDL_itf_tsgpolicyengine_0000_0000_0006 trustClass, 
                                   char* policyAttributes);
}

///Exposes methods that notify Remote Desktop Gateway (RD Gateway) about the result of an attempt to authorize a
///resource. The authorization plug-in should not implement this interface because it is already implemented. A pointer
///to this interface is passed to the authorization plug-in when RD Gateway calls the AuthorizeResource method.
@GUID("FEDDFCD4-FA12-4435-AE55-7AD1A9779AF7")
interface ITSGAuthorizeResourceSink : IUnknown
{
    ///Notifies Remote Desktop Gateway (RD Gateway) about the result of an attempt to authorize a resource.
    ///Params:
    ///    hrIn = The result of the authorization attempt. Specify <b>S_OK</b> to indicate that the attempt succeeded. Specify
    ///           any other value to indicate that the attempt failed.
    ///    mainSessionId = A unique identifier assigned to the connection request by RD Gateway.
    ///    subSessionId = A unique identifier assigned to the subsession by RD Gateway. A subsession is a session launched from another
    ///                   session.
    ///    allowedResourceNames = A pointer to a <b>BSTR</b> that contains a list of resources that were successfully authorized.
    ///    numAllowedResourceNames = The number of resources referenced by the <i>allowedResourceNames</i> parameter. If the function succeeds,
    ///                              this parameter must be one or more.
    ///    failedResourceNames = A pointer to a <b>BSTR</b> that contains a list of resources that failed authorization.
    ///    numFailedResourceNames = The number of resources referenced by the <i>failedResourceNames</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnChannelAuthorized(HRESULT hrIn, GUID mainSessionId, int subSessionId, char* allowedResourceNames, 
                                uint numAllowedResourceNames, char* failedResourceNames, uint numFailedResourceNames);
}

///Exposes methods that authorize connections and resources. Implement this interface when you want to override the
///default authorization logic of Remote Desktop Gateway (RD Gateway).
@GUID("8BC24F08-6223-42F4-A5B4-8E37CD135BBD")
interface ITSGPolicyEngine : IUnknown
{
    ///Determines whether the specified connection is authorized to connect to Remote Desktop Gateway (RD Gateway). RD
    ///Gateway calls this method after a user has been successfully authenticated. The authorization plug-in should then
    ///use the ITSGAuthorizeConnectionSink interface to notify RD Gateway about the result of authorization.
    ///Params:
    ///    mainSessionId = A unique identifier assigned to the connection request by RD Gateway.
    ///    username = The user name.
    ///    authType = A value of the AAAuthSchemes enumeration type that specifies the type of authentication used to connect to RD
    ///               Gateway.
    ///    clientMachineIP = The IP address of the user's computer.
    ///    clientMachineName = The name of the user's computer.
    ///    sohData = A pointer to a <b>BYTE</b> that contains the statement of health (SoH) provided by the user's computer. If
    ///              the authorization plug-in does not require a statement of health, this parameter is <b>NULL</b>. For more
    ///              information, see the IsQuarantineEnabled method.
    ///    numSOHBytes = The number of bytes referenced by the <i>sohData</i> parameter.
    ///    cookieData = A pointer to a <b>BYTE</b> that contains the cookie provided by the user. If the <b>authType</b> parameter is
    ///                 not set to <b>AA_AUTH_COOKIE</b>, this parameter is <b>NULL</b>.
    ///    numCookieBytes = The number of bytes referenced by the <i>cookieData</i> parameter.
    ///    userToken = A pointer to a <b>HANDLE</b> that specifies the user token of the user. If the user is not running Windows,
    ///                this parameter is <b>NULL</b>.
    ///    pSink = A pointer to an ITSGAuthorizeConnectionSink interface that the authorization plug-in must use to notify RD
    ///            Gateway about the result of authorization.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AuthorizeConnection(GUID mainSessionId, BSTR username, AAAuthSchemes authType, BSTR clientMachineIP, 
                                BSTR clientMachineName, char* sohData, uint numSOHBytes, char* cookieData, 
                                uint numCookieBytes, size_t userToken, ITSGAuthorizeConnectionSink pSink);
    ///Determines which resources the specified connection is authorized to connect to. Remote Desktop Gateway (RD
    ///Gateway) calls this method after a user has been successfully authenticated. The authorization plug-in should
    ///then use the ITSGAuthorizeConnectionSink interface to notify RD Gateway about the result of authorization.
    ///Params:
    ///    mainSessionId = A unique identifier assigned to the connection request by RD Gateway.
    ///    subSessionId = A unique identifier assigned to the subsession by RD Gateway. A subsession is a session launched from another
    ///                   session.
    ///    username = The user name.
    ///    resourceNames = A list of resources to authorize.
    ///    numResources = The number of resources referenced by the <i>resourceNames</i> parameter.
    ///    alternateResourceNames = A pointer to a <b>BSTR</b> that contains a list of alternate resource names. This parameter is only valid
    ///                             when RD Connection Broker is in use.
    ///    numAlternateResourceName = The number of alternate resource names referenced by the <i>alternateResourceNames</i> parameter.
    ///    portNumber = The port number specified by the user.
    ///    operation = The operation that the user is attempting on the resource. This parameter is always set to "RDP".
    ///    cookie = A pointer to a <b>BYTE</b> that contains the cookie provided by the user. If the user did not authenticate by
    ///             using a cookie, this parameter is <b>NULL</b>.
    ///    numBytesInCookie = The number of bytes referenced by the <i>cookie</i> parameter.
    ///    pSink = A pointer to an ITSGAuthorizeResourceSink interface that the authorization plug-in must use to notify RD
    ///            Gateway about the result of authorization.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AuthorizeResource(GUID mainSessionId, int subSessionId, BSTR username, char* resourceNames, 
                              uint numResources, char* alternateResourceNames, uint numAlternateResourceName, 
                              uint portNumber, BSTR operation, char* cookie, uint numBytesInCookie, 
                              ITSGAuthorizeResourceSink pSink);
    ///This method is reserved. It should always return <b>S_OK</b>.
    ///Returns:
    ///    Always returns <b>S_OK</b>.
    ///    
    HRESULT Refresh();
    ///Indicates whether the authorization plug-in requires a statement of health (SoH) from the user's computer.
    ///Params:
    ///    quarantineEnabled = Indicates whether the authorization plug-in requires a statement of health from the user's computer.
    ///                        <b>TRUE</b> to use RD Gateway to request an SoH from the user's computer; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. If an
    ///    error code is returned, RD Gateway assumes that an SoH is not required.
    ///    
    HRESULT IsQuarantineEnabled(int* quarantineEnabled);
}

///Exposes methods that provide information about the creation or closing of sessions for a connection. Implement this
///interface when you want to receive this information from Remote Desktop Gateway (RD Gateway).
@GUID("4CE2A0C9-E874-4F1A-86F4-06BBB9115338")
interface ITSGAccountingEngine : IUnknown
{
    ///Provides information about the creation or closing of sessions for a connection. Remote Desktop Gateway (RD
    ///Gateway) calls this method to pass information to an authorization plug-in.
    ///Params:
    ///    accountingDataType = A value of the AAAccountingDataType enumeration type that specifies the type of event that occurred.
    ///    accountingData = An AAAccountingData structure that contains information about the event that occurred.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DoAccounting(AAAccountingDataType accountingDataType, AAAccountingData accountingData);
}

///Exposes methods that notify Remote Desktop Gateway (RD Gateway) about authentication events. The authentication
///plug-in should not implement this interface because it is already implemented. A pointer to this interface is passed
///to the authentication plug-in when RD Gateway calls the AuthenticateUser method.
@GUID("2C3E2E73-A782-47F9-8DFB-77EE1ED27A03")
interface ITSGAuthenticateUserSink : IUnknown
{
    ///Notifies Remote Desktop Gateway (RD Gateway) that the authentication plug-in has successfully authenticated the
    ///user.
    ///Params:
    ///    userName = The name of the user who initiated the connection.
    ///    userDomain = The domain of the user who initiated the connection.
    ///    context = A pointer to a <b>ULONG</b> that contains a value that identifies this connection. Use the value that was
    ///              passed by the AuthenticateUser method.
    ///    userToken = A pointer to a <b>HANDLE</b> that specifies the user token of the user. If the user is not running Windows,
    ///                set this parameter to <b>NULL</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnUserAuthenticated(BSTR userName, BSTR userDomain, size_t context, size_t userToken);
    ///Notifies Remote Desktop Gateway (RD Gateway) that the authentication plug-in failed to authenticate the user.
    ///Params:
    ///    context = A pointer to a <b>ULONG</b> that contains a value that identifies this connection. Use the value that was
    ///              passed by the AuthenticateUser method.
    ///    genericErrorCode = A Windows error code that specifies the cause of the authentication failure.
    ///    specificErrorCode = This parameter is reserved. Always set this parameter to zero.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnUserAuthenticationFailed(size_t context, HRESULT genericErrorCode, HRESULT specificErrorCode);
    ///Notifies Remote Desktop Gateway (RD Gateway) that it should silently reauthenticate and reauthorize the user.
    ///Params:
    ///    context = A pointer to a <b>ULONG</b> that contains a value specific to this connection. Use the value that was passed
    ///              by the AuthenticateUser method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReauthenticateUser(size_t context);
    ///Notifies Remote Desktop Gateway (RD Gateway) that it should disconnect the client.
    ///Params:
    ///    context = A pointer to a <b>ULONG</b> that contains a value that identifies the connection to disconnect. Use the value
    ///              that was passed by the AuthenticateUser method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DisconnectUser(size_t context);
}

///Exposes methods that authenticate users for Remote Desktop Gateway (RD Gateway). Implement this interface when you
///want to override the default authentication process in RD Gateway.
@GUID("9EE3E5BF-04AB-4691-998C-D7F622321A56")
interface ITSGAuthenticationEngine : IUnknown
{
    ///Authenticates a user. Remote Desktop Gateway (RD Gateway) calls this method when it receives a new connection
    ///request. The authentication plug-in should authenticate the user based on the cookie referenced by the
    ///<i>cookieData</i> parameter. The authentication plug-in should then use the ITSGAuthenticateUserSink interface to
    ///notify RD Gateway about the result of authentication.
    ///Params:
    ///    mainSessionId = A unique identifier assigned to the connection request by RD Gateway.
    ///    cookieData = A pointer to a <b>BYTE</b> that contains the cookie provided by the user.
    ///    numCookieBytes = The number of bytes referenced by the <i>cookieData</i> parameter.
    ///    context = A pointer to a <b>ULONG</b> that contains a value specific to this connection. This value should be passed
    ///              back to RD Gateway by using the methods of the ITSGAuthenticateUserSink interface.
    ///    pSink = A pointer to a ITSGAuthenticateUserSink interface that the authentication plug-in must use to notify RD
    ///            Gateway about the result of authentication.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AuthenticateUser(GUID mainSessionId, ubyte* cookieData, uint numCookieBytes, size_t context, 
                             ITSGAuthenticateUserSink pSink);
    ///Cancels an existing authentication request. Remote Desktop Gateway (RD Gateway) calls this method when the user
    ///who initiated the connection terminates the connection, or when the connection fails.
    ///Params:
    ///    mainSessionId = An identifier assigned to the connection request.
    ///    context = A pointer to a <b>ULONG</b> that contains a value that identifies this connection. This value should be
    ///              passed back to RD Gateway by using the methods of the ITSGAuthenticateUserSink interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CancelAuthentication(GUID mainSessionId, size_t context);
}

///<p class="CCE_Message">[The <b>IWTSSBPlugin</b> interface is not supported after Windows Server 2008 R2. Starting
///with Windows Server 2012 please use the ITsSbPlugin interface.] Used to extend the capabilities of Terminal Services
///Session Broker (TS Session Broker). Implement this interface when you want to provide a plug-in that overrides the
///redirection logic of TS Session Broker.
@GUID("DC44BE78-B18D-4399-B210-641BF67A002C")
interface IWTSSBPlugin : IUnknown
{
    ///<p class="CCE_Message">[The IWTSSBPlugin interface is not supported after Windows Server 2008 R2. Starting with
    ///Windows Server 2012 please use the ITsSbPlugin interface.] Initializes the plug-in and returns a value that
    ///indicates the redirection capabilities of the plug-in. Terminal Services Session Broker (TS Session Broker) calls
    ///this method immediately after it instantiates the plug-in class.
    ///Params:
    ///    PluginCapabilities = A pointer to a value that indicates the redirection capabilities of the plug-in.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT Initialize(uint* PluginCapabilities);
    ///<p class="CCE_Message">[The IWTSSBPlugin interface is not supported after Windows Server 2008 R2. Starting with
    ///Windows Server 2012 please use the ITsSbPlugin interface.] Notifies the plug-in that a change occurred in the
    ///server environment.
    ///Params:
    ///    NotificationType = A value of the WTSSBX_NOTIFICATION_TYPE enumeration type that indicates the type of event that occurred.
    ///    MachineId = The ID of the server on which the change occurred.
    ///    pMachineInfo = A pointer to a WTSSBX_MACHINE_INFO structure that contains information about the server that changed. Only
    ///                   the members that changed are reported in this structure. The other members are set to zero.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT WTSSBX_MachineChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, 
                                             WTSSBX_MACHINE_INFO* pMachineInfo);
    ///<p class="CCE_Message">[The IWTSSBPlugin interface is not supported after Windows Server 2008 R2. Starting with
    ///Windows Server 2012 please use the ITsSbPlugin interface.] Notifies the plug-in that a change, such as a logon,
    ///logoff, disconnect, or reconnect, occurred in the session.
    ///Params:
    ///    NotificationType = A WTSSBX_NOTIFICATION_TYPE type that specifies the type of change that occurred.
    ///    MachineId = The ID of the server on which the session change occurred.
    ///    NumOfSessions = The number of elements in the <i>SessionInfo</i> array.
    ///    SessionInfo = An array of WTSSBX_SESSION_INFO structures that contain information about sessions. Only the members that
    ///                  have changed are reported in this structure. The others are set to zero.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT WTSSBX_SessionChangeNotification(WTSSBX_NOTIFICATION_TYPE NotificationType, int MachineId, 
                                             uint NumOfSessions, char* SessionInfo);
    ///<p class="CCE_Message">[The IWTSSBPlugin interface is not supported after Windows Server 2008 R2. Starting with
    ///Windows Server 2012 please use the ITsSbPlugin interface.] Returns the ID of the server to which Terminal
    ///Services Session Broker (TS Session Broker) should direct the incoming connection. The redirection logic of the
    ///plug-in determines the preferred server.
    ///Params:
    ///    UserName = A pointer to a Unicode string that contains the user name of the incoming connection.
    ///    DomainName = A pointer to a Unicode string that contains the domain name that is associated with the incoming connection.
    ///    ApplicationType = A pointer to a Unicode string that contains the name of the program that Remote Desktop Services runs after
    ///                      it creates the session.
    ///    FarmName = A pointer to a Unicode string that contains the name of the farm in TS Session Broker that the user is
    ///               connecting to.
    ///    pMachineId = A pointer to the ID of the server to which TS Session Broker will redirect the incoming connection. This
    ///                 value is initially set to the ID of the server provided by the load balancing logic of TS Session Broker.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT WTSSBX_GetMostSuitableServer(ushort* UserName, ushort* DomainName, ushort* ApplicationType, 
                                         ushort* FarmName, int* pMachineId);
    ///<p class="CCE_Message">[The IWTSSBPlugin interface is not supported after Windows Server 2008 R2. Starting with
    ///Windows Server 2012 please use the ITsSbPlugin interface.] Notifies the plug-in that it is about to be destroyed
    ///by Terminal Services Session Broker (TS Session Broker).
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT Terminated();
    ///<p class="CCE_Message">[The IWTSSBPlugin interface is not supported after Windows Server 2008 R2. Starting with
    ///Windows Server 2012 please use the ITsSbPlugin interface.] Redirects an incoming connection to a computing
    ///resource, such as a virtual machine, a blade server, or even the user's own corporate desktop by providing a
    ///WTSSBX_MACHINE_CONNECT_INFO structure that contains information about the resource.
    ///Params:
    ///    UserName = A pointer to a Unicode string that contains the user name of the incoming connection.
    ///    DomainName = A pointer to a Unicode string that contains the domain name of the incoming connection.
    ///    ApplicationType = A pointer to a Unicode string that contains the program that Remote Desktop Services runs after the user
    ///                      session is created.
    ///    RedirectorInternalIP = A pointer to the internal IP address of the RD Session Host server that first accepted the connection.
    ///    pSessionId = A pointer to the session ID of the session to which the plug-in is redirecting the incoming connection.
    ///    pMachineConnectInfo = A pointer to a WTSSBX_MACHINE_CONNECT_INFO structure that contains information about the computer to which
    ///                          the plug-in is directing the incoming connection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT WTSSBX_GetUserExternalSession(ushort* UserName, ushort* DomainName, ushort* ApplicationType, 
                                          WTSSBX_IP_ADDRESS* RedirectorInternalIP, uint* pSessionId, 
                                          WTSSBX_MACHINE_CONNECT_INFO* pMachineConnectInfo);
}

///Exposes methods that allow the runtime to disconnect a custom client in RemoteApp and Desktop Connection. This
///interface is the outbound interface of the custom client.
@GUID("12B952F4-41CA-4F21-A829-A6D07D9A16E5")
interface IWorkspaceClientExt : IUnknown
{
    ///Returns the ID of the custom client in RemoteApp and Desktop Connection.
    ///Params:
    ///    bstrWorkspaceId = A pointer to a <b>BSTR</b> variable to receive the ID of the custom client.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetResourceId(BSTR* bstrWorkspaceId);
    ///Returns the display name of the custom client in RemoteApp and Desktop Connection.
    ///Params:
    ///    bstrWorkspaceDisplayName = A pointer to a <b>BSTR</b> variable to receive the display name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetResourceDisplayName(BSTR* bstrWorkspaceDisplayName);
    ///Disconnects the custom client in RemoteApp and Desktop Connection. The RemoteApp and Desktop Connection runtime
    ///calls this method to disconnect the client.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IssueDisconnect();
}

///Exposes methods that provide information about a connection in RemoteApp and Desktop Connection. This interface is
///implemented by the Remote Desktop Services workspace runtime. These methods are called by custom clients that
///implement the IWorkspaceClientExt interface.
@GUID("B922BBB8-4C55-4FEA-8496-BEB0B44285E5")
interface IWorkspace : IUnknown
{
    ///Retrieves the names of the connections in the current process.
    ///Params:
    ///    psaWkspNames = A pointer to an array of <b>BSTR</b> variables to receive the names of the connections.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetWorkspaceNames(SAFEARRAY** psaWkspNames);
    ///Starts a RemoteApp program.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the ID of the connection in which to the start the application.
    ///    psaParams = A pointer to an array of <b>BSTR</b> values that contains parameters to pass to the workspace runtime. For
    ///                RDP connections, this parameter contains two strings: <ul> <li>Serialized RDP file</li> <li>Command line
    ///                parameters for Remote Desktop Connection client</li> </ul>
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StartRemoteApplication(BSTR bstrWorkspaceId, SAFEARRAY* psaParams);
    ///Retrieves the process ID of the current connection in RemoteApp and Desktop Connection.
    ///Params:
    ///    pulProcessId = A pointer to a <b>ULONG</b> variable to receive the process ID.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetProcessId(uint* pulProcessId);
}

///Not supported. Exposes additional methods that provide information about a connection in RemoteApp and Desktop
///Connection. This interface is implemented by the Remote Desktop Services workspace runtime. These methods are called
///by custom clients that implement the IWorkspaceClientExt interface.
@GUID("96D8D7CF-783E-4286-834C-EBC0E95F783C")
interface IWorkspace2 : IWorkspace
{
    ///Not supported. Starts a RemoteApp program with additional options and features.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the ID of the connection in which to the start the application.
    ///    bstrRequestingAppId = A string that contains the ID of an application to launch on the remote desktop.
    ///    bstrRequestingAppFamilyName = A string that contains the family name of the application to launch.
    ///    bLaunchIntoImmersiveClient = <b>VARIANT_TRUE</b> to make the remote application launch as though it were accessed via the web client,
    ///                                 using the modern Remote Desktop protocol. <b>VARIANT_FALSE</b> to make the remote application launch using
    ///                                 classic Terminal Server methodology.
    ///    bstrImmersiveClientActivationContext = A string containing the context for the specific remote desktop client.
    ///    psaParams = A pointer to an array of <b>BSTR</b> values that contains parameters to pass to the workspace runtime. For
    ///                RDP connections, this parameter contains two strings: <ul> <li>Serialized RDP file</li> <li>Command line
    ///                parameters for Remote Desktop Connection client</li> </ul>
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StartRemoteApplicationEx(BSTR bstrWorkspaceId, BSTR bstrRequestingAppId, 
                                     BSTR bstrRequestingAppFamilyName, short bLaunchIntoImmersiveClient, 
                                     BSTR bstrImmersiveClientActivationContext, SAFEARRAY* psaParams);
}

///Exposes methods that provide information about a connection in RemoteApp and Desktop Connection, and adds the ability
///to retrieve or set a claims token.
@GUID("1BECBE4A-D654-423B-AFEB-BE8D532C13C6")
interface IWorkspace3 : IWorkspace2
{
    ///Retrieves a claims token.
    ///Params:
    ///    bstrClaimsHint = String containing the claims hint.
    ///    bstrUserHint = String containing the user hint.
    ///    claimCookie = The claim cookie.
    ///    hwndCredUiParent = Handle of the parent UI element the request came from.
    ///    rectCredUiParent = Pointer to a RECT structure that contains the X and Y coordinates of the parent UI.
    ///    pbstrAccessToken = On success, return a pointer to a string containing the access token.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetClaimsToken2(BSTR bstrClaimsHint, BSTR bstrUserHint, uint claimCookie, uint hwndCredUiParent, 
                            RECT rectCredUiParent, BSTR* pbstrAccessToken);
    ///Sets the claims token.
    ///Params:
    ///    bstrAccessToken = A string containing the access token.
    ///    ullAccessTokenExpiration = The time, in milliseconds, until the access token expires.
    ///    bstrRefreshToken = A string containing the refresh token.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetClaimsToken(BSTR bstrAccessToken, ulong ullAccessTokenExpiration, BSTR bstrRefreshToken);
}

///Exposes methods that add and remove references to custom clients in RemoteApp and Desktop Connection. These methods
///are called by custom clients that implement the IWorkspaceClientExt interface.
@GUID("B922BBB8-4C55-4FEA-8496-BEB0B44285E6")
interface IWorkspaceRegistration : IUnknown
{
    ///Adds a resource to the connection in RemoteApp and Desktop Connection.
    ///Params:
    ///    pUnk = A pointer to the IWorkspaceClientExt object that called this method.
    ///    pdwCookie = A pointer to a <b>DWORD</b> variable to receive the connection cookie for a new resource.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddResource(IWorkspaceClientExt pUnk, uint* pdwCookie);
    ///Notifies the RemoteApp and Desktop Connection runtime that the client is disconnecting the connection.
    ///Params:
    ///    dwCookieConnection = A <b>DWORD</b> value that contains a connection cookie returned by the AddResource method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveResource(uint dwCookieConnection);
}

///Not implemented. Exposes methods that add and remove references to custom clients in RemoteApp and Desktop
///Connection. These methods are called by custom clients that implement the IWorkspaceClientExt interface.
@GUID("CF59F654-39BB-44D8-94D0-4635728957E9")
interface IWorkspaceRegistration2 : IWorkspaceRegistration
{
    ///Not implemented. Adds a resource to the connection in RemoteApp and Desktop Connection.
    ///Params:
    ///    pUnk = A pointer to the IWorkspaceClientExt object that called this method.
    ///    bstrEventLogUploadAddress = TBD
    ///    pdwCookie = A pointer to a <b>DWORD</b> variable to receive the connection cookie for a new resource.
    ///    correlationId = TBD
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddResourceEx(IWorkspaceClientExt pUnk, BSTR bstrEventLogUploadAddress, uint* pdwCookie, 
                          GUID correlationId);
    ///Not implemented. Notifies the RemoteApp and Desktop Connection runtime that the client is disconnecting the
    ///connection.
    ///Params:
    ///    dwCookieConnection = A <b>DWORD</b> value that contains a connection cookie returned by the AddResourceEx method.
    ///    correlationId = TBD
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveResourceEx(uint dwCookieConnection, GUID correlationId);
}

///Exposes methods that manage RemoteApp and Desktop Connection credentials and connections. This interface is
///implemented by the RemoteApp and Desktop Connection runtime. These methods are called by custom clients that
///implement the IWorkspaceClientExt interface.
@GUID("EFEA49A2-DDA5-429D-8F42-B23B92C4C347")
interface IWorkspaceScriptable : IDispatch
{
    ///Disconnects all existing connections associated with the specified connection ID. It also deletes the
    ///corresponding entries from the credential store.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the connection ID of the connection to disconnect.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DisconnectWorkspace(BSTR bstrWorkspaceId);
    ///Associates user credentials and certificates with a connection ID.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the connection ID.
    ///    bstrUserName = A string that contains a user name.
    ///    bstrPassword = A string that contains a password.
    ///    bstrWorkspaceParams = A string that contains one or more Secure Hash Algorithm 1 (SHA-1) hashes of signing certificates to
    ///                          associate with the specified connection ID. The hash values should be in hexadecimal string format and
    ///                          delimited by semicolons.
    ///    lTimeout = The time period, in minutes, after which the credentials are deleted.
    ///    lFlags = A flag that specifies properties of the user credentials. This can be a bitwise <b>OR</b> of the following
    ///             values.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> value that indicates
    ///    the error. Possible values include, but are not limited to, those in the following list.
    ///    
    HRESULT StartWorkspace(BSTR bstrWorkspaceId, BSTR bstrUserName, BSTR bstrPassword, BSTR bstrWorkspaceParams, 
                           int lTimeout, int lFlags);
    ///Determines whether user credentials exist for the specified connection ID.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the connection ID.
    ///    bCountUnauthenticatedCredentials = <b>VARIANT_TRUE</b> to specify that the <i>pbCredExist</i> parameter should return <b>VARIANT_TRUE</b> if
    ///                                       credentials (authenticated or unauthenticated) exist for the connection ID specified in the
    ///                                       <i>bstrWorkspaceId</i> parameter. <b>VARIANT_FALSE</b> to specify that the <i>pbCredExist</i> parameter
    ///                                       should return <b>VARIANT_TRUE</b> only if authenticated credentials exist for the connection ID specified in
    ///                                       the <i>bstrWorkspaceId</i> parameter.
    ///    pbCredExist = A pointer to a <b>VARIANT_BOOL</b> variable to receive whether credentials exist for the connection ID
    ///                  specified in the <i>bstrWorkspaceId</i> parameter. This value is <b>VARIANT_TRUE</b> if credentials exist;
    ///                  otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsWorkspaceCredentialSpecified(BSTR bstrWorkspaceId, short bCountUnauthenticatedCredentials, 
                                           short* pbCredExist);
    ///Determines whether single sign on (SSO) is enabled for RemoteApp and Desktop Connection.
    ///Params:
    ///    pbSSOEnabled = A pointer to a <b>VARIANT_BOOL</b> variable to receive whether SSO is enabled. This value is
    ///                   <b>VARIANT_TRUE</b> if SSO is enabled; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsWorkspaceSSOEnabled(short* pbSSOEnabled);
    ///Deletes the user credentials associated with the specified connection ID.
    ///Params:
    ///    bstrWorkspaceId = A string that contains a connection ID.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ClearWorkspaceCredential(BSTR bstrWorkspaceId);
    ///Marks the authentication of user credentials for the connection ID, and subsequently shows the connect
    ///notification in the taskbar notification area. The <b>OnAuthenticated</b> method also resets the credential
    ///time-out.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the connection ID.
    ///    bstrUserName = A string that contains a user name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnAuthenticated(BSTR bstrWorkspaceId, BSTR bstrUserName);
    ///Disconnects all existing connections associated with the connection that has the specified name. It also deletes
    ///the corresponding entries from the RemoteApp and Desktop Connection store.
    ///Params:
    ///    bstrWorkspaceFriendlyName = A string that contains the friendly name of the connection to disconnect.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DisconnectWorkspaceByFriendlyName(BSTR bstrWorkspaceFriendlyName);
}

///Exposes methods that manage RemoteApp and Desktop Connection credentials and connections. This interface is
///implemented by the RemoteApp and Desktop Connection runtime. These methods are called by custom clients that
///implement the IWorkspaceClientExt interface.
@GUID("EFEA49A2-DDA5-429D-8F42-B33BA2C4C348")
interface IWorkspaceScriptable2 : IWorkspaceScriptable
{
    ///Associates user credentials and certificates with a connection ID; also contains additional security and UI
    ///elements.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the connection ID.
    ///    bstrWorkspaceFriendlyName = The friendly name of the workspace to display in the UI.
    ///    bstrRedirectorName = String containing the name of the redirector.
    ///    bstrUserName = A string that contains a user name.
    ///    bstrPassword = A string that contains a password.
    ///    bstrAppContainer = A string containing the app container for the workspace.
    ///    bstrWorkspaceParams = A string that contains one or more Secure Hash Algorithm 1 (SHA-1) hashes of signing certificates to
    ///                          associate with the specified connection ID. The hash values should be in hexadecimal string format and
    ///                          delimited by semicolons.
    ///    lTimeout = The time period, in minutes, after which the credentials are deleted.
    ///    lFlags = A flag that specifies properties of the user credentials. This can be a bitwise <b>OR</b> of the following
    ///             values.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> value that indicates
    ///    the error. Possible values include, but are not limited to, those in the following list.
    ///    
    HRESULT StartWorkspaceEx(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, 
                             BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, 
                             int lTimeout, int lFlags);
    ///Alerts the user that a resource has been disabled or otherwise dismissed.
    ///Params:
    ///    bstrWorkspaceId = String containing the ID of the workspace that contains the unavailable resource.
    ///    bstrWorkspaceFriendlyName = String containing the friendly name of the workspace that holds the unavailable resource.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResourceDismissed(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName);
}

///Not implemented. Exposes methods that manage RemoteApp and Desktop Connection credentials and connections. This
///interface is implemented by the RemoteApp and Desktop Connection runtime. These methods are called by custom clients
///that implement the IWorkspaceClientExt interface.
@GUID("531E6512-2CBF-4BD2-80A5-D90A71636A9A")
interface IWorkspaceScriptable3 : IWorkspaceScriptable2
{
    ///Not implemented. Associates user credentials and certificates with a connection ID.
    ///Params:
    ///    bstrWorkspaceId = A string that contains the connection ID.
    ///    bstrWorkspaceFriendlyName = TBD
    ///    bstrRedirectorName = TBD
    ///    bstrUserName = A string that contains a user name.
    ///    bstrPassword = A string that contains a password.
    ///    bstrAppContainer = TBD
    ///    bstrWorkspaceParams = A string that contains one or more Secure Hash Algorithm 1 (SHA-1) hashes of signing certificates to
    ///                          associate with the specified connection ID. The hash values should be in hexadecimal string format and
    ///                          delimited by semicolons.
    ///    lTimeout = The time period, in minutes, after which the credentials are deleted.
    ///    lFlags = A flag that specifies properties of the user credentials. This can be a bitwise <b>OR</b> of the following
    ///             values.
    ///    bstrEventLogUploadAddress = TBD
    ///    correlationId = TBD
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> value that indicates
    ///    the error. Possible values include, but are not limited to, those in the following list.
    ///    
    HRESULT StartWorkspaceEx2(BSTR bstrWorkspaceId, BSTR bstrWorkspaceFriendlyName, BSTR bstrRedirectorName, 
                              BSTR bstrUserName, BSTR bstrPassword, BSTR bstrAppContainer, BSTR bstrWorkspaceParams, 
                              int lTimeout, int lFlags, BSTR bstrEventLogUploadAddress, GUID correlationId);
}

///Exposes methods that support error message handling for remote workspaces.
@GUID("A7C06739-500F-4E8C-99A8-2BD6955899EB")
interface IWorkspaceReportMessage : IUnknown
{
    ///Registers the specified error message to use in the UI.
    ///Params:
    ///    bstrMessage = A string containing the error message to use in the UI.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterErrorLogMessage(BSTR bstrMessage);
    ///Determines whether a specified error message is registered in a specified workspace.
    ///Params:
    ///    bstrWkspId = A string containing the ID of the workspace to check.
    ///    dwErrorType = The error type associated with the error message.
    ///    bstrErrorMessageType = A string containing the error message type.
    ///    dwErrorCode = The error code of the event.
    ///    pfErrorExist = On success, returns a pointer to <b>VARIANT_TRUE</b> if the error message is registered in the specified
    ///                   workspace; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsErrorMessageRegistered(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, 
                                     uint dwErrorCode, short* pfErrorExist);
    ///Registers the specified error event message to use in the UI.
    ///Params:
    ///    bstrWkspId = A string containing the workspace ID in which the error event is to be registered.
    ///    dwErrorType = The error type of the event.
    ///    bstrErrorMessageType = A string containing the error message.
    ///    dwErrorCode = The error code for the event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterErrorEvent(BSTR bstrWkspId, uint dwErrorType, BSTR bstrErrorMessageType, uint dwErrorCode);
}

@GUID("B922BBB8-4C55-4FEA-8496-BEB0B44285E9")
interface _ITSWkspEvents : IDispatch
{
}

///Exposes methods that initialize and terminate plug-ins. This is the base interface for all plug-ins to Remote Desktop
///Connection Broker (RD Connection Broker). Derive from this interface to create plug-ins for load balancing,
///placement, or orchestration.
@GUID("48CD7406-CAAB-465F-A5D6-BAA863B9EA4F")
interface ITsSbPlugin : IUnknown
{
    ///Initializes the plug-in. Remote Desktop Connection Broker (RD Connection Broker) calls this method immediately
    ///after the RD Connection Broker service starts. Plug-ins can use this method to add information about existing
    ///environments and targets in the RD Connection Broker store. ITsSbResourcePlugin ITsSbLoadBalancing ITsSbPlacement
    ///ITsSbOrchestration ITsSbTaskPlugin
    ///Params:
    ///    pProvider = A pointer to an ITsSbProvider provider object.
    ///    pNotifySink = A pointer to an ITsSbPluginNotifySink notify sink object.
    ///    pPropertySet = A pointer to an ITsSbPluginPropertySet plug-in property set object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Initialize(ITsSbProvider pProvider, ITsSbPluginNotifySink pNotifySink, 
                       ITsSbPluginPropertySet pPropertySet);
    ///Performs clean-up and unloads the plug-in. Remote Desktop Connection Broker (RD Connection Broker) calls this
    ///method when it stops the RD Connection Broker service.
    ///Params:
    ///    hr = Specifies the reason for termination. The plug-in should specify a standard <b>HRESULT</b> error code.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Terminate(HRESULT hr);
}

///Exposes methods that extend the capabilities of Remote Desktop Connection Broker (RD Connection Broker). Implement
///this interface when you want to add support for a new resource type.
@GUID("EA8DB42C-98ED-4535-A88B-2A164F35490F")
interface ITsSbResourcePlugin : ITsSbPlugin
{
}

///Exposes methods that Remote Desktop Connection Broker (RD Connection Broker) uses to notify plug-ins of state changes
///that occur in the RD Connection Broker itself.
@GUID("86CB68AE-86E0-4F57-8A64-BB7406BC5550")
interface ITsSbServiceNotification : IUnknown
{
    ///Notifies registered plug-ins that the Remote Desktop Connection Broker (RD Connection Broker) service has
    ///stopped.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifyServiceFailure();
    ///Notifies registered plug-ins that the Remote Desktop Connection Broker (RD Connection Broker) service has
    ///started.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifyServiceSuccess();
}

///Exposes methods you can use to provide a custom load-balancing algorithm. The GetMostSuitableTarget method should
///return an endpoint (target) to which the client connects.
@GUID("24329274-9EB7-11DC-AE98-F2B456D89593")
interface ITsSbLoadBalancing : ITsSbPlugin
{
    ///Determines the most suitable target to which to direct an incoming client connection. Remote Desktop Connection
    ///Broker (RD Connection Broker) calls this method when it needs to redirect an incoming client connection.
    ///Params:
    ///    pConnection = A pointer to an ITsSbClientConnection object. Information specific to a client connection, such as user name
    ///                  and farm name, can be obtained from this object.
    ///    pLBSink = A pointer to an ITsSbLoadBalancingNotifySink object. If the plug-in successfully determines where to redirect
    ///              the connection, it should return the load balancing result by using this sink object. For more information,
    ///              see ITsSbLoadBalanceResult.
    ///Returns:
    ///    This method can return one of these values. If the method succeeds, it returns <b>S_OK</b>. Otherwise, it
    ///    returns an <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to,
    ///    those in the following list.
    ///    
    HRESULT GetMostSuitableTarget(ITsSbClientConnection pConnection, ITsSbLoadBalancingNotifySink pLBSink);
}

///Exposes methods that prepare the environment (the computer that hosts the virtual machine). After Remote Desktop
///Connection Broker (RD Connection Broker) receives a load-balancing result, it calls QueryEnvironmentForTarget to
///determine whether the environment is present and ready.
@GUID("DAADEE5F-6D32-480E-9E36-DDAB2329F06D")
interface ITsSbPlacement : ITsSbPlugin
{
    ///Determines whether the specified environment is ready to host the target that was returned by load balancing.
    ///Params:
    ///    pConnection = A pointer to an ITsSbClientConnection client connection object.
    ///    pPlacementSink = A pointer to an ITsSbPlacementNotifySink placement sink object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QueryEnvironmentForTarget(ITsSbClientConnection pConnection, ITsSbPlacementNotifySink pPlacementSink);
}

///Exposes methods that Remote Desktop Connection Broker (RD Connection Broker) uses to ensure that the target is ready
///before a client is redirected to it.
@GUID("64FC1172-9EB7-11DC-8B00-3ABA56D89593")
interface ITsSbOrchestration : ITsSbPlugin
{
    ///Prepares the target for a client connection.
    ///Params:
    ///    pConnection = A pointer to an ITsSbClientConnection client connection object.
    ///    pOrchestrationNotifySink = A pointer to an ITsSbOrchestrationNotifySink orchestration notify sink object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PrepareTargetForConnect(ITsSbClientConnection pConnection, 
                                    ITsSbOrchestrationNotifySink pOrchestrationNotifySink);
}

///Exposes methods and properties that contain information about the environment that hosts the target computer. This
///interface can be used to store information about a physical server that hosts virtual machines.
@GUID("8C87F7F7-BF51-4A5C-87BF-8E94FB6E2256")
interface ITsSbEnvironment : IUnknown
{
    ///Retrieves a value that indicates the name of the environment that hosts the target computer. This property is
    ///read-only.
    HRESULT get_Name(BSTR* pVal);
    ///Retrieves a value that indicates the server weight of the environment that hosts the target computer. This
    ///property is read-only.
    HRESULT get_ServerWeight(uint* pVal);
    ///Retrieves or specifies the property set for the environment that hosts the target computer. This property is
    ///read/write.
    HRESULT get_EnvironmentPropertySet(ITsSbEnvironmentPropertySet* ppPropertySet);
    ///Retrieves or specifies the property set for the environment that hosts the target computer. This property is
    ///read/write.
    HRESULT put_EnvironmentPropertySet(ITsSbEnvironmentPropertySet pVal);
}

///Exposes methods and properties that store the target name returned by a load-balancing algorithm. Remote Desktop
///Connection Broker (RD Connection Broker) and plug-ins can use this interface to query for the target name returned by
///a load-balancing algorithm.
@GUID("24FDB7AC-FEA6-11DC-9672-9A8956D89593")
interface ITsSbLoadBalanceResult : IUnknown
{
    ///Retrieves the target name returned by a load-balancing algorithm. This property is read-only.
    HRESULT get_TargetName(BSTR* pVal);
}

///Exposes properties that store configuration and state information about a target.
@GUID("16616ECC-272D-411D-B324-126893033856")
interface ITsSbTarget : IUnknown
{
    ///Specifies or retrieves the name of the target. This property is read/write.
    HRESULT get_TargetName(BSTR* pVal);
    ///Specifies or retrieves the name of the target. This property is read/write.
    HRESULT put_TargetName(BSTR Val);
    ///Retrieves or specifies the name of the farm to which this target is joined. This property is read/write.
    HRESULT get_FarmName(BSTR* pVal);
    ///Retrieves or specifies the name of the farm to which this target is joined. This property is read/write.
    HRESULT put_FarmName(BSTR Val);
    ///Retrieves or specifies the fully qualified domain name of the target. This property is read/write.
    HRESULT get_TargetFQDN(BSTR* TargetFqdnName);
    ///Retrieves or specifies the fully qualified domain name of the target. This property is read/write.
    HRESULT put_TargetFQDN(BSTR Val);
    ///Retrieves or specifies the NetBIOS name of the target. This property is read/write.
    HRESULT get_TargetNetbios(BSTR* TargetNetbiosName);
    ///Retrieves or specifies the NetBIOS name of the target. This property is read/write.
    HRESULT put_TargetNetbios(BSTR Val);
    ///Retrieves or specifies the external IP addresses of the target. This property is read/write.
    HRESULT get_IpAddresses(char* SOCKADDR, uint* numAddresses);
    ///Retrieves or specifies the external IP addresses of the target. This property is read/write.
    HRESULT put_IpAddresses(char* SOCKADDR, uint numAddresses);
    ///Retrieves or specifies the target state. This property is read/write.
    HRESULT get_TargetState(TARGET_STATE* pState);
    ///Retrieves or specifies the target state. This property is read/write.
    HRESULT put_TargetState(TARGET_STATE State);
    ///Retrieves or specifies the set of properties for the target. This property is read/write.
    HRESULT get_TargetPropertySet(ITsSbTargetPropertySet* ppPropertySet);
    ///Retrieves or specifies the set of properties for the target. This property is read/write.
    HRESULT put_TargetPropertySet(ITsSbTargetPropertySet pVal);
    ///Retrieves or specifies the name of the environment associated with the target. This property is read/write.
    HRESULT get_EnvironmentName(BSTR* pVal);
    ///Retrieves or specifies the name of the environment associated with the target. This property is read/write.
    HRESULT put_EnvironmentName(BSTR Val);
    ///Retrieves the number of sessions maintained by broker for the target. This property is read-only.
    HRESULT get_NumSessions(uint* pNumSessions);
    ///Retrieves the number of pending user connections for the target. This property is read-only.
    HRESULT get_NumPendingConnections(uint* pNumPendingConnections);
    ///Retrieves the relative load on a target. This value is based on the number of existing and pending sessions. By
    ///default a pending session has the same value as an existing session. This property is read-only.
    HRESULT get_TargetLoad(uint* pTargetLoad);
}

///Exposes properties that store information about a user session.
@GUID("D453AAC7-B1D8-4C5E-BA34-9AFB4C8C5510")
interface ITsSbSession : IUnknown
{
    ///Retrieves the session ID. This property is read-only.
    HRESULT get_SessionId(uint* pVal);
    ///Retrieves the name of the target on which this session was created. This property is read-only.
    HRESULT get_TargetName(BSTR* targetName);
    HRESULT put_TargetName(BSTR targetName);
    ///Retrieves the user name for this session. This property is read-only.
    HRESULT get_Username(BSTR* userName);
    ///Retrieves the domain name of the user. This property is read-only.
    HRESULT get_Domain(BSTR* domain);
    ///Retrieves or specifies the session state. This property is read/write.
    HRESULT get_State(TSSESSION_STATE* pState);
    ///Retrieves or specifies the session state. This property is read/write.
    HRESULT put_State(TSSESSION_STATE State);
    ///Retrieves or specifies the time the session was created. This property is read/write.
    HRESULT get_CreateTime(FILETIME* pTime);
    ///Retrieves or specifies the time the session was created. This property is read/write.
    HRESULT put_CreateTime(FILETIME Time);
    ///Retrieves or specifies the time the session was disconnected. This property is read/write.
    HRESULT get_DisconnectTime(FILETIME* pTime);
    ///Retrieves or specifies the time the session was disconnected. This property is read/write.
    HRESULT put_DisconnectTime(FILETIME Time);
    ///Retrieves or specifies the initial program for this session. The initial program is the program that is launched
    ///when the user session starts. This property is read/write.
    HRESULT get_InitialProgram(BSTR* app);
    ///Retrieves or specifies the initial program for this session. The initial program is the program that is launched
    ///when the user session starts. This property is read/write.
    HRESULT put_InitialProgram(BSTR Application);
    ///Retrieves or specifies information about the display device of the client computer. This property is read/write.
    HRESULT get_ClientDisplay(CLIENT_DISPLAY* pClientDisplay);
    ///Retrieves or specifies information about the display device of the client computer. This property is read/write.
    HRESULT put_ClientDisplay(CLIENT_DISPLAY pClientDisplay);
    ///Retrieves or specifies the protocol type for the session. This property is read/write.
    HRESULT get_ProtocolType(uint* pVal);
    ///Retrieves or specifies the protocol type for the session. This property is read/write.
    HRESULT put_ProtocolType(uint Val);
}

///Exposes methods that Remote Desktop Connection Broker (RD Connection Broker) uses to notify plug-ins of any state
///changes that occur in the session, target, and client connection objects. Plug-ins can use these notifications in
///many ways. For example, they can implement load-balancing algorithms.
@GUID("65D3E85A-C39B-11DC-B92D-3CD255D89593")
interface ITsSbResourceNotification : IUnknown
{
    ///Notifies registered plug-ins about state changes in a session object.
    ///Params:
    ///    changeType = The type of change that occurred.
    ///    pSession = A pointer to a session object. This object is a copy of the object present in the RD Connection Broker store.
    ///               Any changes to this object do not affect the object in the store.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifySessionChange(TSSESSION_STATE changeType, ITsSbSession pSession);
    ///Notifies registered plug-ins about state changes in a target object.
    ///Params:
    ///    TargetChangeType = A value of the TARGET_CHANGE_TYPE enumeration that specifies the type of change that occurred in a target.
    ///    pTarget = A pointer to a target object. This object is a copy of the object present in the RD Connection Broker store.
    ///              Any changes to this object do not affect the object in the store.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifyTargetChange(uint TargetChangeType, ITsSbTarget pTarget);
    ///Notifies registered plug-ins about state changes in a client connection.
    ///Params:
    ///    ChangeType = The type of change that has occurred. This parameter can be one of the following values.
    ///    pConnection = A pointer to an ITsSbClientConnection connection object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifyClientConnectionStateChange(CONNECTION_CHANGE_NOTIFICATION ChangeType, 
                                              ITsSbClientConnection pConnection);
}

///Exposes methods that Remote Desktop Connection Broker (RD Connection Broker) uses to notify plug-ins of any state
///changes that occur in the session, target, and client connection objects. Plug-ins can use these notifications in
///many ways. For example, they can implement load-balancing algorithms.
@GUID("A8A47FDE-CA91-44D2-B897-3AA28A43B2B7")
interface ITsSbResourceNotificationEx : IUnknown
{
    ///Notifies registered plug-ins about state changes in a session object.
    ///Params:
    ///    targetName = The name of the target.
    ///    userName = The user name.
    ///    domain = The user domain.
    ///    sessionId = Identifies the session that changed.
    ///    sessionState = A TSSESSION_STATE value specifying he type of change that occurred.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifySessionChangeEx(BSTR targetName, BSTR userName, BSTR domain, uint sessionId, 
                                  TSSESSION_STATE sessionState);
    ///Notifies registered plug-ins about state changes in a target object.
    ///Params:
    ///    targetName = The name of the target.
    ///    targetChangeType = A value of the TARGET_CHANGE_TYPE enumeration that specifies the type of change that occurred in a target.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifyTargetChangeEx(BSTR targetName, uint targetChangeType);
    ///Notifies registered plug-ins about state changes in a client connection.
    ///Params:
    ///    userName = The user name.
    ///    domain = The user domain.
    ///    initialProgram = The initial program.
    ///    poolName = The name of the pool.
    ///    targetName = The name of the target.
    ///    connectionChangeType = The type of change that has occurred. This parameter can be one of the following values.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifyClientConnectionStateChangeEx(BSTR userName, BSTR domain, BSTR initialProgram, BSTR poolName, 
                                                BSTR targetName, CONNECTION_CHANGE_NOTIFICATION connectionChangeType);
}

///Exposes properties that the Remote Desktop Connection Broker uses to set a plugin’s queue.
@GUID("523D1083-89BE-48DD-99EA-04E82FFA7265")
interface ITsSbTaskInfo : IUnknown
{
    ///Retrieves the target identifier. This property is read-only.
    HRESULT get_TargetId(BSTR* pName);
    ///Retrieves the earliest time the task agent can start the task. This property is read-only.
    HRESULT get_StartTime(FILETIME* pStartTime);
    ///Retrieves the latest time the task agent can start the task. This property is read-only.
    HRESULT get_EndTime(FILETIME* pEndTime);
    ///Retrieves the time by which the task must be initiated. This is used to prioritize patches. The patch with the
    ///earliest deadline will get initiated first. This property is read-only.
    HRESULT get_Deadline(FILETIME* pDeadline);
    ///Retrieves a GUID that is used as a unique identifier by the task agent. This property is read-only.
    HRESULT get_Identifier(BSTR* pIdentifier);
    ///Retrieves the label that describes the purpose of the task. This property is read-only.
    HRESULT get_Label(BSTR* pLabel);
    ///Retrieves the context bytes associated with the task. This property is read-only.
    HRESULT get_Context(SAFEARRAY** pContext);
    ///Retrieves the display name of the task agent. This property is read-only.
    HRESULT get_Plugin(BSTR* pPlugin);
    ///Retrieves an RDV_TASK_STATUS enumeration value that represents the state of the task. This property is read-only.
    HRESULT get_Status(RDV_TASK_STATUS* pStatus);
}

///Exposes methods that update the queue of tasks for Remote Desktop Connection Broker plugins.
@GUID("FA22EF0F-8705-41BE-93BC-44BDBCF1C9C4")
interface ITsSbTaskPlugin : ITsSbPlugin
{
    ///Initializes a task that is in the queue of a Remote Desktop Connection Broker plugin.
    ///Params:
    ///    pITsSbTaskPluginNotifySink = A pointer to an ITsSbTaskPluginNotifySink object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InitializeTaskPlugin(ITsSbTaskPluginNotifySink pITsSbTaskPluginNotifySink);
    ///Updates a task in the queue of a Remote Desktop Connection Broker plugin.
    ///Params:
    ///    pszHostName = 
    ///    SbTaskInfoSize = 
    ///    pITsSbTaskInfo = An array of pointers to ITsSbTaskInfo objects.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTaskQueue(BSTR pszHostName, uint SbTaskInfoSize, char* pITsSbTaskInfo);
}

///Can be used to define custom properties as appropriate.
@GUID("5C025171-BB1E-4BAF-A212-6D5E9774B33B")
interface ITsSbPropertySet : IPropertyBag
{
}

///Can be used to define custom plug-in properties as appropriate.
@GUID("95006E34-7EFF-4B6C-BB40-49A4FDA7CEA6")
interface ITsSbPluginPropertySet : ITsSbPropertySet
{
}

///Can be used to define custom properties of a client connection as appropriate.
@GUID("E51995B0-46D6-11DD-AA21-CEDC55D89593")
interface ITsSbClientConnectionPropertySet : ITsSbPropertySet
{
}

///Derive from this interface to define a custom target property set.
@GUID("F7BDA5D6-994C-4E11-A079-2763B61830AC")
interface ITsSbTargetPropertySet : ITsSbPropertySet
{
}

///Can be used to define custom properties of an environment that hosts target computers as appropriate.
@GUID("D0D1BF7E-7ACF-11DD-A243-E51156D89593")
interface ITsSbEnvironmentPropertySet : ITsSbPropertySet
{
}

///Exposes methods that report status and error messages to Remote Desktop Connection Broker (RD Connection Broker).
@GUID("808A6537-1282-4989-9E09-F43938B71722")
interface ITsSbBaseNotifySink : IUnknown
{
    ///Reports an error condition to Remote Desktop Connection Broker (RD Connection Broker).
    ///Params:
    ///    hrError = The error condition.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnError(HRESULT hrError);
    ///Sends status messages to the Remote Desktop Connection (RDC) client regarding the processing of a client
    ///connection.
    ///Params:
    ///    messageType = The message type. This parameter must be one of the following values.
    ///    messageID = The message ID. This parameter must be one of the following values.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnReportStatus(CLIENT_MESSAGE_TYPE messageType, uint messageID);
}

///Exposes methods that notify Remote Desktop Connection Broker (RD Connection Broker) about initialization or
///termination of a plug-in.
@GUID("44DFE30B-C3BE-40F5-BF82-7A95BB795ADF")
interface ITsSbPluginNotifySink : ITsSbBaseNotifySink
{
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the plug-in has completed a call of
    ///Initialize.
    ///Params:
    ///    hr = Specifies the result of the call to Initialize.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnInitialized(HRESULT hr);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the plug-in has completed a call of
    ///Terminate.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnTerminated();
}

///Exposes methods that return the result of a load-balancing algorithm to Remote Desktop Connection Broker (RD
///Connection Broker).
@GUID("5F8A8297-3244-4E6A-958A-27C822C1E141")
interface ITsSbLoadBalancingNotifySink : ITsSbBaseNotifySink
{
    ///Returns a load-balancing result to Remote Desktop Connection Broker (RD Connection Broker).
    ///Params:
    ///    pLBResult = A pointer to a ITsSbLoadBalanceResult object that includes the name of the target to which the connection
    ///                should be redirected.
    ///    fIsNewConnection = Indicates whether this is a new connection. <b>TRUE</b> if it is a new connection; <b>FALSE</b> otherwise.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> value that indicates
    ///    the error. Possible values include, but are not limited to, those in the following list.
    ///    
    HRESULT OnGetMostSuitableTarget(ITsSbLoadBalanceResult pLBResult, BOOL fIsNewConnection);
}

///Exposes methods that return information about environments to Remote Desktop Connection Broker (RD Connection
///Broker).
@GUID("68A0C487-2B4F-46C2-94A1-6CE685183634")
interface ITsSbPlacementNotifySink : ITsSbBaseNotifySink
{
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the environment specified by the
    ///ITsSbClientConnection object is already hosting the correct target.
    ///Params:
    ///    pEnvironment = A pointer to an ITsSbEnvironment environment object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnQueryEnvironmentCompleted(ITsSbEnvironment pEnvironment);
}

///Exposes methods that return an ITsSbTarget object to Remote Desktop Connection Broker (RD Connection Broker) after
///the target is successfully prepared for a connection.
@GUID("36C37D61-926B-442F-BCA5-118C6D50DCF2")
interface ITsSbOrchestrationNotifySink : ITsSbBaseNotifySink
{
    ///Returns an ITsSbTarget object to Remote Desktop Connection Broker (RD Connection Broker) after the target is
    ///successfully prepared for a connection.
    ///Params:
    ///    pTarget = A pointer to an ITsSbTarget target object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnReadyToConnect(ITsSbTarget pTarget);
}

///Exposes methods that report status and error messages about tasks to Remote Desktop Connection Broker (RD Connection
///Broker).
@GUID("6AAF899E-C2EC-45EE-AA37-45E60895261A")
interface ITsSbTaskPluginNotifySink : ITsSbBaseNotifySink
{
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that a task has been scheduled.
    ///Params:
    ///    szTargetName = The name of the target.
    ///    TaskStartTime = A <b>FILETIME</b> structure specifying the start time (UTC).
    ///    TaskEndTime = A <b>FILETIME</b> structure specifying the end time (UTC).
    ///    TaskDeadline = A <b>FILETIME</b> structure specifying the deadline (UTC).
    ///    szTaskLabel = A label describing the purpose of the task.
    ///    szTaskIdentifier = Identifies the target.
    ///    szTaskPlugin = The display name of the task agent.
    ///    dwTaskStatus = An RDV_TASK_STATUS enumeration value that represents the state of the task.
    ///    saContext = The context bytes associated with the task.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnSetTaskTime(BSTR szTargetName, FILETIME TaskStartTime, FILETIME TaskEndTime, FILETIME TaskDeadline, 
                          BSTR szTaskLabel, BSTR szTaskIdentifier, BSTR szTaskPlugin, uint dwTaskStatus, 
                          SAFEARRAY* saContext);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that a task has been removed from the queue.
    ///Params:
    ///    szTargetName = The name of the target.
    ///    szTaskIdentifier = The GUID that identifies the task.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnDeleteTaskTime(BSTR szTargetName, BSTR szTaskIdentifier);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the status of a task has changed.
    ///Params:
    ///    szTargetName = The name of the target.
    ///    TaskIdentifier = The GUID that identifies the task.
    ///    TaskStatus = An RDV_TASK_STATUS enumeration value representing the new state of the task.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnUpdateTaskStatus(BSTR szTargetName, BSTR TaskIdentifier, RDV_TASK_STATUS TaskStatus);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) of a new task report.
    ///Params:
    ///    szHostName = The name of the host where the report is located.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnReportTasks(BSTR szHostName);
}

///Exposes methods and properties that store state information about an incoming connection request from a Remote
///Desktop Connection (RDC) client. This information does not need to be stored on the resource or filter plug-ins,
///which allows the plug-ins to be stateless. Plug-ins can use this interface to obtain information about a connection
///request initiated by a client, and then make decisions about load balancing, placement, and orchestration. This
///interface also stores the results of all these operations. A <b>ITsSbClientConnection</b> object should persist until
///the client successfully logs on to a target computer.
@GUID("18857499-AD61-4B1B-B7DF-CBCD41FB8338")
interface ITsSbClientConnection : IUnknown
{
    ///Retrieves a value that indicates the name of the user who initiated the connection. This property is read-only.
    HRESULT get_UserName(BSTR* pVal);
    ///Retrieves a value that indicates the domain name of the Remote Desktop Connection (RDC) client. This property is
    ///read-only.
    HRESULT get_Domain(BSTR* pVal);
    ///Retrieves a value that indicates the program that is launched when the user logs on to the target computer. This
    ///property is read-only.
    HRESULT get_InitialProgram(BSTR* pVal);
    ///Retrieves a value that indicates the name of the target computer returned by load balancing. This property is
    ///read-only.
    HRESULT get_LoadBalanceResult(ITsSbLoadBalanceResult* ppVal);
    ///Farm name. This property is read-only.
    HRESULT get_FarmName(BSTR* pVal);
    ///Can be used by plug-ins to store context information specific to the connection.
    ///Params:
    ///    contextId = A <b>BSTR</b> variable that contains the context ID. We recommend using unique identifiers as context IDs to
    ///                avoid collisions between plug-ins. A client connection object can be used by more than one plug-in.
    ///    context = The context information to store.
    ///    existingContext = Existing context information for the supplied context ID, if any, is returned in this parameter. The existing
    ///                      information is overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PutContext(BSTR contextId, VARIANT context, VARIANT* existingContext);
    ///Retrieves context information that was stored by a plug-in by using the PutContext method.
    ///Params:
    ///    contextId = A <b>BSTR</b> variable that contains the context ID.
    ///    context = A pointer to the context information.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetContext(BSTR contextId, VARIANT* context);
    ///Retrieves an object that contains information about the environment that hosts the target computer. For example,
    ///in a virtual desktop scenario, this object would contain information about the computer that hosts the virtual
    ///machine. This property is read-only.
    HRESULT get_Environment(ITsSbEnvironment* ppEnvironment);
    ///Retrieves a value that indicates the error that occurred while a client connection was being processed. This
    ///property is read-only.
    HRESULT get_ConnectionError();
    ///Retrieves a value that indicates the domain name and user name of the user who initiated the connection. This
    ///property is read-only.
    HRESULT get_SamUserAccount(BSTR* pVal);
    ///Retrieves an object that contains properties associated with the client connection. This property is read-only.
    HRESULT get_ClientConnectionPropertySet(ITsSbClientConnectionPropertySet* ppPropertySet);
    ///Whether this is the first assignment. This property is read-only.
    HRESULT get_IsFirstAssignment(int* ppVal);
    ///Rd Farm Type. This property is read-only.
    HRESULT get_RdFarmType(RD_FARM_TYPE* pRdFarmType);
    ///User SID as a string. This property is read-only.
    HRESULT get_UserSidString(byte** pszUserSidString);
    ///Gets a disconnected session.
    ///Params:
    ///    ppSession = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDisconnectedSession(ITsSbSession* ppSession);
}

///Exposes methods that create default implementations of objects that are used in Remote Desktop Virtualization. The
///<b>ITsSbProvider</b> interface is a helper interface, aimed at reducing the amount of code that the plug-in
///implementer needs to write. It provides a default implementation of some objects, such as environment, target, and
///session objects.
@GUID("87A4098F-6D7B-44DD-BC17-8CE44E370D52")
interface ITsSbProvider : IUnknown
{
    ///Creates an ITsSbTarget target object.
    ///Params:
    ///    TargetName = A <b>BSTR</b> variable that contains the target name.
    ///    EnvironmentName = A <b>BSTR</b> variable that contains the environment name.
    ///    ppTarget = A pointer to a pointer to the specified target object. When you have finished using the object, release it by
    ///               calling the Release method.
    ///Returns:
    ///    This method can return one of these values. If the method succeeds, it returns <b>S_OK</b>. Otherwise, it
    ///    returns an <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to,
    ///    those in the following list.
    ///    
    HRESULT CreateTargetObject(BSTR TargetName, BSTR EnvironmentName, ITsSbTarget* ppTarget);
    ///Creates an ITsSbLoadBalanceResult load-balancing result object.
    ///Params:
    ///    TargetName = A <b>BSTR</b> variable that contains the target name.
    ///    ppLBResult = A pointer to a pointer to an ITsSbLoadBalanceResult object. When you have finished using the object, release
    ///                 it by calling the Release method.
    ///Returns:
    ///    This method can return one of these values. If the method succeeds, it returns <b>S_OK</b>. Otherwise, it
    ///    returns an <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to,
    ///    those in the following list.
    ///    
    HRESULT CreateLoadBalanceResultObject(BSTR TargetName, ITsSbLoadBalanceResult* ppLBResult);
    ///Plug-ins can use the <b>CreateSessionObject</b> method to create an ITsSbSession session object.
    ///Params:
    ///    TargetName = A <b>BSTR</b> variable that contains the target name.
    ///    UserName = A <b>BSTR</b> variable that contains the user name.
    ///    Domain = A <b>BSTR</b> variable that contains the domain.
    ///    SessionId = A <b>DWORD</b> variable that contains the session ID.
    ///    ppSession = A pointer to a pointer to the new session object. When you have finished using the object, release it by
    ///                calling the Release method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateSessionObject(BSTR TargetName, BSTR UserName, BSTR Domain, uint SessionId, 
                                ITsSbSession* ppSession);
    ///Creates an ITsSbPluginPropertySet plug-in property set object.
    ///Params:
    ///    ppPropertySet = A pointer to a pointer to an ITsSbPluginPropertySet property set object. When you have finished using the
    ///                    object, release it by calling the Release method. Because RD Connection Broker is unaware of the contents of
    ///                    the property set object, you should clean the object before calling its <b>Release</b> method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreatePluginPropertySet(ITsSbPluginPropertySet* ppPropertySet);
    ///Creates an ITsSbTargetPropertySet target property set object.
    ///Params:
    ///    ppPropertySet = A pointer to a pointer to an ITsSbTargetPropertySet property set object. When you have finished using the
    ///                    object, release it by calling the Release method. Because RD Connection Broker is unaware of the contents of
    ///                    the property set object, you should clean the object before calling its <b>Release</b> method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTargetPropertySetObject(ITsSbTargetPropertySet* ppPropertySet);
    ///Creates an ITsSbEnvironment environment object.
    ///Params:
    ///    Name = A <b>BSTR</b> variable that contains the name of the object to create.
    ///    ServerWeight = A <b>DWORD</b> variable that contains the server weight of the object to create.
    ///    ppEnvironment = A pointer to a pointer to the newly created environment object. When you have finished using the object,
    ///                    release it by calling the Release method.
    ///Returns:
    ///    This method can return one of these values. If the method succeeds, it returns <b>S_OK</b>. Otherwise, it
    ///    returns an <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to,
    ///    those in the following list.
    ///    
    HRESULT CreateEnvironmentObject(BSTR Name, uint ServerWeight, ITsSbEnvironment* ppEnvironment);
    ///Retrieves an ITsSbResourcePluginStore instance of the resource plug-in store. Plug-ins can call this method if
    ///they have access to the ITsSbProvider and ITsSbResourcePlugin objects that own the store. This method returns an
    ///instance of the resource plug-in store.
    ///Params:
    ///    ppStore = A pointer to a pointer to an ITsSbResourcePluginStore resource plug-in store object. When you have finished
    ///              using the object, release it by calling the Release method.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> value that indicates
    ///    the error. Possible values include, but are not limited to, those in the following list.
    ///    
    HRESULT GetResourcePluginStore(ITsSbResourcePluginStore* ppStore);
    ///Retrieves a FilterPluginStore instance of the filter plugin store.
    ///Params:
    ///    ppStore = The address of an ITsSbFilterPluginStore interface pointer.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFilterPluginStore(ITsSbFilterPluginStore* ppStore);
    ///Requests that Remote Desktop Connection Broker (RD Connection Broker) send notifications about specified events.
    ///Plug-ins can use this method to request notifications about events.
    ///Params:
    ///    notificationType = The type of notification to receive. To receive notifications for more than one type, specify the
    ///                       enumerations by using a logical <b>OR</b>.
    ///    ResourceToMonitor = This parameter is reserved.
    ///    pPluginNotification = A pointer to an ITsSbResourceNotification plug-in notification object that RD Connection Broker should use
    ///                          for notifications.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterForNotification(uint notificationType, BSTR ResourceToMonitor, 
                                    ITsSbResourceNotification pPluginNotification);
    ///Requests that Remote Desktop Connection Broker (RD Connection Broker) not send notifications about specified
    ///events.
    ///Params:
    ///    notificationType = Specifies the type of notification. To specify more than one type, use a logical <b>OR</b>.
    ///    ResourceToMonitor = This parameter is reserved.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UnRegisterForNotification(uint notificationType, BSTR ResourceToMonitor);
    ///Retrieves an ITsSbGlobalStore instance of the global store object. Plug-ins can use this method to get an
    ///instance of the global store object. The global store object is designed for use by filter plug-ins that do not
    ///have access to the resource plug-in store.
    ///Params:
    ///    ppGlobalStore = A pointer to a pointer to a global store object. When you have finished using the object, release it by
    ///                    calling the Release method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetInstanceOfGlobalStore(ITsSbGlobalStore* ppGlobalStore);
    ///Creates an ITsSbEnvironmentPropertySet environment property set object.
    ///Params:
    ///    ppPropertySet = A pointer to the created ITsSbEnvironmentPropertySet environment property set object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEnvironmentPropertySetObject(ITsSbEnvironmentPropertySet* ppPropertySet);
}

///Exposes methods that enable resource plug-ins to store objects such as sessions and targets. These methods add,
///delete, and query these objects.
@GUID("5C38F65F-BCF1-4036-A6BF-9E3CCCAE0B63")
interface ITsSbResourcePluginStore : IUnknown
{
    ///Returns the target that has the specified target name and farm name.
    ///Params:
    ///    TargetName = The target name.
    ///    FarmName = The farm name. If this parameter is <b>NULL</b>, the method returns the first target it finds.
    ///    ppTarget = A pointer to a pointer to an ITsSbTarget target object. When you have finished using the object, release it
    ///               by calling the Release method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QueryTarget(BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    ///Returns the session object that has the specified session ID.
    ///Params:
    ///    dwSessionId = The session ID.
    ///    TargetName = The target name.
    ///    ppSession = A pointer to a pointer to an ITsSbSession session object. When you have finished using the object, release it
    ///                by calling the Release method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QuerySessionBySessionId(uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    ///Adds a target to the resource plug-in store.
    ///Params:
    ///    pTarget = A pointer to an ITsSbTarget target object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddTargetToStore(ITsSbTarget pTarget);
    ///Adds a new session to the resource plug-in store. Call this method when a user has logged on to a new session.
    ///Params:
    ///    pSession = A pointer to an ITsSbSession session object. The target name, user name, domain name, and session ID are
    ///               required fields.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddSessionToStore(ITsSbSession pSession);
    ///Adds an environment to the resource plug-in store.
    ///Params:
    ///    pEnvironment = A pointer to an ITsSbEnvironment environment object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddEnvironmentToStore(ITsSbEnvironment pEnvironment);
    ///Removes the specified environment from the resource plug-in store.
    ///Params:
    ///    EnvironmentName = The name of the environment to remove.
    ///    bIgnoreOwner = Set <b>TRUE</b> to ignore ownership of the environment; <b>FALSE</b> otherwise. <b>Windows Server 2012 R2 and
    ///                   Windows Server 2012: </b>This parameter is not supported before Windows Server 2016.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveEnvironmentFromStore(BSTR EnvironmentName, BOOL bIgnoreOwner);
    ///Enumerates all the farms that have been added to the resource plug-in store.
    ///Params:
    ///    pdwCount = The number of farms retrieved.
    ///    pVal = An array of farm names. The <i>pdwCount</i> parameter contains the number of elements in this array. When you
    ///           have finished using the array, free the allocated memory by calling the SafeArrayDestroy function.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateFarms(uint* pdwCount, SAFEARRAY** pVal);
    ///Returns the specified environment object.
    ///Params:
    ///    EnvironmentName = The name of the environment.
    ///    ppEnvironment = A pointer to the retrieved ITsSbEnvironment environment object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QueryEnvironment(BSTR EnvironmentName, ITsSbEnvironment* ppEnvironment);
    ///Returns an array that contains the environments present in the resource plug-in store.
    ///Params:
    ///    pdwCount = A pointer to the number of targets retrieved.
    ///    pVal = A pointer to an array that contains references to the environments present. When you have finished using the
    ///           array, release each element and free the array by calling the CoTaskMemFree function.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateEnvironments(uint* pdwCount, char* pVal);
    ///Saves a target.
    ///Params:
    ///    pTarget = Pointer to the ITsSbTarget object to save.
    ///    bForceWrite = Set to TRUE to force writing the saved object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveTarget(ITsSbTarget pTarget, BOOL bForceWrite);
    ///Saves an environment.
    ///Params:
    ///    pEnvironment = Pointer to the ITsSbEnvironment object to save.
    ///    bForceWrite = Set to <b>TRUE</b> to force writing the saved object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveEnvironment(ITsSbEnvironment pEnvironment, BOOL bForceWrite);
    ///Saves a session.
    ///Params:
    ///    pSession = A Pointer to the ITsSbSession object to save.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveSession(ITsSbSession pSession);
    ///Sets the value of a property of a target.
    ///Params:
    ///    TargetName = The name of the target.
    ///    PropertyName = The name of the property.
    ///    pProperty = A pointer to the value to set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTargetProperty(BSTR TargetName, BSTR PropertyName, VARIANT* pProperty);
    ///Sets a property of an environment.
    ///Params:
    ///    EnvironmentName = The name of the environment.
    ///    PropertyName = The name of the property to set.
    ///    pProperty = A pointer to the value to set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetEnvironmentProperty(BSTR EnvironmentName, BSTR PropertyName, VARIANT* pProperty);
    ///Sets the state of a target object.
    ///Params:
    ///    targetName = The name of the target.
    ///    newState = The TARGET_STATE value to set.
    ///    pOldState = The previous state of the target.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTargetState(BSTR targetName, TARGET_STATE newState, TARGET_STATE* pOldState);
    ///Sets the session state.
    ///Params:
    ///    sbSession = A pointer to the session to modify.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSessionState(ITsSbSession sbSession);
    ///Returns an array that contains the specified targets that are present in the resource plug-in store.
    ///Params:
    ///    FarmName = The farm name.
    ///    EnvName = The environment name.
    ///    sortByFieldId = Specifies sort order.
    ///    sortyByPropName = The property name to sort by if <i>sortByFieldId</i> is set to <b>TS_SB_SORT_BY_PROP</b>.
    ///    pdwCount = The number of targets retrieved.
    ///    pVal = Pointer to the retrieved ITsSbTargetobjects.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateTargets(BSTR FarmName, BSTR EnvName, TS_SB_SORT_BY sortByFieldId, BSTR sortyByPropName, 
                             uint* pdwCount, char* pVal);
    ///Enumerates a specified set of sessions.
    ///Params:
    ///    targetName = The name of the target.
    ///    userName = The name of the user account.
    ///    userDomain = The domain name of the user account.
    ///    poolName = The name of the pool.
    ///    initialProgram = The name of the published remote application.
    ///    pSessionState = A pointer to the TSSESSION_STATE value of the sessions to enumerate.
    ///    pdwCount = Returns a pointer to the number of sessions returned.
    ///    ppVal = Returns the list of sessions requested.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateSessions(BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, BSTR initialProgram, 
                              TSSESSION_STATE* pSessionState, uint* pdwCount, char* ppVal);
    ///Retrieves a property of a farm.
    ///Params:
    ///    farmName = The name of the farm.
    ///    propertyName = The name of the property to retrieve.
    ///    pVarValue = Returns a pointer to the value of the property.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
    ///Deletes a target.
    ///Params:
    ///    targetName = The name of the target.
    ///    hostName = The name of the computer that hosts the target.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteTarget(BSTR targetName, BSTR hostName);
    ///Sets the value of a property of a target.
    ///Params:
    ///    pTarget = A pointer to the target.
    ///    PropertyName = The name of the property.
    ///    pProperty = A pointer to the value to set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTargetPropertyWithVersionCheck(ITsSbTarget pTarget, BSTR PropertyName, VARIANT* pProperty);
    ///Sets a property of an environment.
    ///Params:
    ///    pEnvironment = A pointer to the environment.
    ///    PropertyName = The name of the property to set.
    ///    pProperty = A pointer to the value to set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetEnvironmentPropertyWithVersionCheck(ITsSbEnvironment pEnvironment, BSTR PropertyName, 
                                                   VARIANT* pProperty);
    ///Locks a target.
    ///Params:
    ///    targetName = The name of the target to lock.
    ///    dwTimeout = The timeout for the operation, in milliseconds.
    ///    ppContext = Returns a pointer to the context of the lock. To release the lock, supply this pointer to the
    ///                ReleaseTargetLock method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AcquireTargetLock(BSTR targetName, uint dwTimeout, IUnknown* ppContext);
    ///Releases a lock on a target.
    ///Params:
    ///    pContext = A pointer to the context returned by the AcquireTargetLock method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReleaseTargetLock(IUnknown pContext);
    ///Conditionally sets a new state on a server.
    ///Params:
    ///    PoolName = Name of the pool.
    ///    ServerFQDN = Fully qualified domain name (FQDN) of the server.
    ///    NewState = The state to set.
    ///    TestState = If set to <b>TARGET_UNKNOWN</b> or the current state of the server, the server will be set as specified in
    ///                the <i>NewState</i> parameter.
    ///    pInitState = On return, points to the previous state of the server.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT TestAndSetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE NewState, TARGET_STATE TestState, 
                                  TARGET_STATE* pInitState);
    ///Indicates to the session host that the server is waiting to start.
    ///Params:
    ///    PoolName = Name of the pool.
    ///    serverName = Name of the server.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetServerWaitingToStart(BSTR PoolName, BSTR serverName);
    ///Retrieves the state of a specified server.
    ///Params:
    ///    PoolName = Name of the pool.
    ///    ServerFQDN = Fully qualified domain name (FQDN) of the server.
    ///    pState = On return, points to the state of the server.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetServerState(BSTR PoolName, BSTR ServerFQDN, TARGET_STATE* pState);
    ///Sets the drain mode of the specified server.
    ///Params:
    ///    ServerFQDN = The fully qualified domain name of the server.
    ///    DrainMode = The mode to set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetServerDrainMode(BSTR ServerFQDN, uint DrainMode);
}

///Filter Plugin Store
@GUID("85B44B0F-ED78-413F-9702-FA6D3B5EE755")
interface ITsSbFilterPluginStore : IUnknown
{
    ///Saves a property set.
    ///Params:
    ///    pPropertySet = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveProperties(ITsSbPropertySet pPropertySet);
    ///Enumerates a property set.
    ///Params:
    ///    ppPropertySet = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateProperties(ITsSbPropertySet* ppPropertySet);
    ///Deletes a property.
    ///Params:
    ///    propertyName = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteProperties(BSTR propertyName);
}

///Exposes methods that query for target computers, sessions, environments, and farms that have been added to the Remote
///Desktop Connection Broker (RD Connection Broker) store. Plug-ins can obtain an instance of the global store from the
///ITsSbProvider object that they retrieve during initialization.
@GUID("9AB60F7B-BD72-4D9F-8A3A-A0EA5574E635")
interface ITsSbGlobalStore : IUnknown
{
    ///Retrieves the ITsSbTarget object for the given parameters.
    ///Params:
    ///    ProviderName = The name of the resource plug-in provider.
    ///    TargetName = The target name.
    ///    FarmName = The farm name to which the target belongs. If <b>NULL</b>, the first target found is returned.
    ///    ppTarget = A pointer to a pointer to a target ITsSbTarget object. When you have finished using the object, release it by
    ///               calling the Release method.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> value that indicates
    ///    the error. Possible values include, but are not limited to, those in the following list.
    ///    
    HRESULT QueryTarget(BSTR ProviderName, BSTR TargetName, BSTR FarmName, ITsSbTarget* ppTarget);
    ///Retrieves the ITsSbSession object associated with the given session ID.
    ///Params:
    ///    ProviderName = The resource plug-in provider name that owns the target.
    ///    dwSessionId = The session ID.
    ///    TargetName = The name of the target computer on which this session is present.
    ///    ppSession = A pointer to a pointer to a session object. When you have finished using the object, release it by calling
    ///                the Release method.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT QuerySessionBySessionId(BSTR ProviderName, uint dwSessionId, BSTR TargetName, ITsSbSession* ppSession);
    ///Enumerates all the farms that have been added by the specified resource plug-in.
    ///Params:
    ///    ProviderName = The provider name of the resource plug-in.
    ///    pdwCount = The count of farms retrieved.
    ///    pVal = A pointer to an array of farm names. The number of elements in this array is specified by the <i>pdwCount</i>
    ///           parameter. When you have finished using the array, free the allocated memory by calling the SafeArrayDestroy
    ///           function.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateFarms(BSTR ProviderName, uint* pdwCount, SAFEARRAY** pVal);
    ///Returns an array that contains the specified targets present in the global store.
    ///Params:
    ///    ProviderName = The provider name.
    ///    FarmName = The farm name.
    ///    EnvName = The environment name.
    ///    pdwCount = The number of targets retrieved.
    ///    pVal = Pointer to the retrieved ITsSbTargetobjects.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateTargets(BSTR ProviderName, BSTR FarmName, BSTR EnvName, uint* pdwCount, char* pVal);
    ///Returns an array that contains the environments present on the specified provider.
    ///Params:
    ///    ProviderName = The name of the provider.
    ///    pdwCount = A pointer to the number of environments retrieved.
    ///    ppVal = A pointer to an array that contains references to the environments present. When you have finished using the
    ///            array, release each element and free the array by calling the CoTaskMemFree function.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateEnvironmentsByProvider(BSTR ProviderName, uint* pdwCount, char* ppVal);
    ///Returns an array that contains sessions on the specified provider.
    ///Params:
    ///    ProviderName = The name of the provider.
    ///    targetName = The name of the target.
    ///    userName = The name of the user account.
    ///    userDomain = The domain name of the user account.
    ///    poolName = The name of the pool.
    ///    initialProgram = The name of the published remote application.
    ///    pSessionState = A pointer to the TSSESSION_STATE value of the sessions to enumerate.
    ///    pdwCount = Returns a pointer to the number of sessions returned.
    ///    ppVal = Returns the list of sessions requested.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerateSessions(BSTR ProviderName, BSTR targetName, BSTR userName, BSTR userDomain, BSTR poolName, 
                              BSTR initialProgram, TSSESSION_STATE* pSessionState, uint* pdwCount, char* ppVal);
    ///Retrieves a property of a farm.
    ///Params:
    ///    farmName = The name of the farm.
    ///    propertyName = The name of the property to retrieve.
    ///    pVarValue = Returns a pointer to the value of the property.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFarmProperty(BSTR farmName, BSTR propertyName, VARIANT* pVarValue);
}

///Exposes methods that notify Remote Desktop Connection Broker (RD Connection Broker) about the provisioning of virtual
///machines.
@GUID("ACA87A8E-818B-4581-A032-49C3DFB9C701")
interface ITsSbProvisioningPluginNotifySink : IUnknown
{
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that a provisioning job is created.
    ///Params:
    ///    pVmNotifyInfo = Notification info.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnJobCreated(VM_NOTIFY_INFO* pVmNotifyInfo);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the status of a virtual machine is changed.
    ///Params:
    ///    pVmNotifyEntry = Notification entry.
    ///    VmNotifyStatus = Notification status.
    ///    ErrorCode = A standard <b>HRESULT</b> error code describing the reason for the status change.
    ///    ErrorDescr = A text description of the reason for the change.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnVirtualMachineStatusChanged(VM_NOTIFY_ENTRY* pVmNotifyEntry, VM_NOTIFY_STATUS VmNotifyStatus, 
                                          HRESULT ErrorCode, BSTR ErrorDescr);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the job is complete.
    ///Params:
    ///    ResultCode = The <b>HRESULT</b> returned by the job.
    ///    ResultDescription = A text description of the <i>ResultCode</i>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnJobCompleted(HRESULT ResultCode, BSTR ResultDescription);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the job is cancelled.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnJobCancelled();
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the virtual machine is locked.
    ///Params:
    ///    pVmNotifyEntry = Notification entry.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LockVirtualMachine(VM_NOTIFY_ENTRY* pVmNotifyEntry);
    ///Notifies Remote Desktop Connection Broker (RD Connection Broker) that the status of the host of a virtual machine
    ///is changed.
    ///Params:
    ///    VmHost = The name of the host.
    ///    VmHostNotifyStatus = The new status of the host.
    ///    ErrorCode = A standard <b>HRESULT</b> error code describing the reason for the status change.
    ///    ErrorDescr = A text description of the reason for the change.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnVirtualMachineHostStatusChanged(BSTR VmHost, VM_HOST_NOTIFY_STATUS VmHostNotifyStatus, 
                                              HRESULT ErrorCode, BSTR ErrorDescr);
}

///Exposes methods that create and maintain virtual machines.
@GUID("2F6F0DBB-9E4F-462B-9C3F-FCCC3DCB6232")
interface ITsSbProvisioning : ITsSbPlugin
{
    ///Creates a virtual machine asynchronously.
    ///Params:
    ///    JobXmlString = Defines the job.
    ///    JobGuid = A <b>GUID</b> that identifies the job.
    ///    pSink = The ITsSbProvisioningPluginNotifySink object that notifies the RD Connection Broker about the job.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    ///Patches a virtual machine asynchronously.
    ///Params:
    ///    JobXmlString = Defines the job.
    ///    JobGuid = A <b>GUID</b> that identifies the job.
    ///    pSink = The ITsSbProvisioningPluginNotifySink object that notifies the RD Connection Broker about the job.
    ///    pVMPatchInfo = Patch information.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PatchVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink, 
                                 VM_PATCH_INFO* pVMPatchInfo);
    ///Deletes a virtual machine asynchronously.
    ///Params:
    ///    JobXmlString = Defines the job.
    ///    JobGuid = A <b>GUID</b> that identifies the job.
    ///    pSink = The ITsSbProvisioningPluginNotifySink object that notifies the RD Connection Broker about the job.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteVirtualMachines(BSTR JobXmlString, BSTR JobGuid, ITsSbProvisioningPluginNotifySink pSink);
    ///Cancels a provisioning job.
    ///Params:
    ///    JobGuid = A <b>GUID</b> that identifies the job.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CancelJob(BSTR JobGuid);
}

///Exposes methods that reports completion to and gets wait time from the Remote Desktop Connection Broker (RD
///Connection Broker).
@GUID("4C4C8C4F-300B-46AD-9164-8468A7E7568C")
interface ITsSbGenericNotifySink : IUnknown
{
    ///Reports completion to Remote Desktop Connection Broker (RD Connection Broker).
    ///Params:
    ///    Status = The status to report.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnCompleted(HRESULT Status);
    ///Retrieves the wait timeout.
    ///Params:
    ///    pftTimeout = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetWaitTimeout(FILETIME* pftTimeout);
}

///Exposes properties and methods that provide information about resources available to users of RemoteApp and Desktop
///Connections. The methods in this interface are called by the RemoteApp and Desktop Connection Management service in
///Remote Desktop Web Access (RD Web Access) and Remote Desktop Connection Broker (RD Connection Broker). Resources that
///can be exposed through <b>ItsPubPlugin</b> typically include RemoteApp programs, virtual machine pools, and personal
///virtual desktops. By implementing this interface and registering it in the Registry, these resources can be displayed
///to users in RD Web Access and RemoteApp and Desktop Connections. Your interface can perform custom filtering of
///resources and provide support for file types that are not currently supported. (Only .rdp files are supported by
///default.)
@GUID("70C04B05-F347-412B-822F-36C99C54CA45")
interface ItsPubPlugin : IUnknown
{
    ///Retrieves a list of resources assigned to the specified user. The RemoteApp and Desktop Connection Management
    ///service calls this method in the following situations: <ul> <li>When the user has no cache in Remote Desktop Web
    ///Access (RD Web Access).</li> <li>When the user has a cache, but it has expired.</li> <li>When a call to
    ///GetCacheLastUpdateTime returns a time that is later than the time stored in the user's cache.</li> </ul>
    ///Params:
    ///    userID = The user security identifier (SID).
    ///    pceAppListSize = A pointer to a <b>LONG</b> variable to receive the number of elements in the <i>resourceList</i>.
    ///    resourceList = The address of a pointer to an array of pluginResource structures that receive the resources assigned to the
    ///                   specified user. You must use the CoTaskMemAlloc function to allocate this memory. The caller is responsible
    ///                   for freeing this memory.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetResourceList(const(wchar)* userID, int* pceAppListSize, pluginResource** resourceList);
    ///This method is reserved and should always return <b>E_NOTIMPL</b>.
    ///Params:
    ///    alias = This parameter is reserved.
    ///    flags = This parameter is reserved.
    ///    resource = This parameter is reserved.
    ///Returns:
    ///    This method must always return <b>E_NOTIMPL</b>.
    ///    
    HRESULT GetResource(const(wchar)* alias_, int flags, pluginResource* resource);
    ///Returns the time that the cache was last updated. The RemoteApp and Desktop Connection Management service calls
    ///this method to determine whether the data in the Remote Desktop Web Access (RD Web Access) cache should be
    ///refreshed.
    ///Params:
    ///    lastUpdateTime = A pointer to an <b>unsigned long long</b> variable that receives the time that the cache was last updated.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCacheLastUpdateTime(ulong* lastUpdateTime);
    ///Retrieves the name of the plug-in. This property is read-only.
    HRESULT get_pluginName(BSTR* pVal);
    ///Retrieves the version of the plug-in. This property is read-only.
    HRESULT get_pluginVersion(BSTR* pVal);
    ///Provides information about how to connect to a user's assigned personal virtual desktop. Implement this method if
    ///you want to provide a custom implementation of the personal virtual desktop functionality. Otherwise, this method
    ///should return <b>E_NOTIMPL</b>. This method is called by the RemoteApp and Desktop Connection Management service
    ///when Remote Desktop Connection Broker (RD Connection Broker) is connecting a user to a personal virtual desktop.
    ///Params:
    ///    resourceType = A pointer to a <b>DWORD</b> variable to receive the type of resource. This can be one of the following
    ///                   values.
    ///    resourceLocation = The name of the resource plug-in.
    ///    endPointName = The name of the endpoint. For personal virtual desktops, specify the name of the desktop assigned to the
    ///                   user. For virtual desktop pools, specify the name of the pool.
    ///    userID = A pointer to a string that contains the user security identifier (SID).
    ///    alias = A pointer to a string that contains the alias of the user.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResolveResource(uint* resourceType, char* resourceLocation, char* endPointName, ushort* userID, 
                            ushort* alias_);
}

///Specifies methods that provide information about resources available to users of RemoteApp and Desktop Connections.
///This interface is an enhancement to the ItsPubPlugin interface. The methods in this interface are called by the
///RemoteApp and Desktop Connection Management service in Remote Desktop Web Access (RD Web Access) and Remote Desktop
///Connection Broker (RD Connection Broker).
@GUID("FA4CE418-AAD7-4EC6-BAD1-0A321BA465D5")
interface ItsPubPlugin2 : ItsPubPlugin
{
    ///Retrieves a list of resources assigned to the specified user. The RemoteApp and Desktop Connection Management
    ///service calls this method in the following situations: <ul> <li>When the user has no cache in Remote Desktop Web
    ///Access (RD Web Access).</li> <li>When the user has a cache, but it has expired.</li> <li>When a call to
    ///GetCacheLastUpdateTime returns a time that is later than the time stored in the user's cache.</li> </ul>
    ///Params:
    ///    userID = A null-terminated string that contains the security identifier (SID) of the user. If this parameter is
    ///             <b>NULL</b>, this method should return the resources for all users.
    ///    pceAppListSize = The address of a <b>LONG</b> variable that receives the number of elements in the <i>resourceList</i> array.
    ///    resourceList = The address of an array of pluginResource2 structures that contains the resources for the specified user. You
    ///                   must use the CoTaskMemAlloc function to allocate this memory. The caller is responsible for freeing this
    ///                   memory.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetResource2List(const(wchar)* userID, int* pceAppListSize, pluginResource2** resourceList);
    ///This method is reserved and should always return <b>E_NOTIMPL</b>.
    ///Params:
    ///    alias = This parameter is reserved.
    ///    flags = This parameter is reserved.
    ///    resource = This parameter is reserved.
    ///Returns:
    ///    This method must always return <b>E_NOTIMPL</b>.
    ///    
    HRESULT GetResource2(const(wchar)* alias_, int flags, pluginResource2* resource);
    ///Called to resolve a mapping between the specified user and a virtual machine in a personal virtual desktop
    ///collection.
    ///Params:
    ///    userId = A null-terminated string that contains the security identifier (SID) of the user.
    ///    poolId = A null-terminated string that contains the identifier of the collection to obtain the personal desktop from
    ///             or create the personal desktop in.
    ///    ePdResolutionType = A value of the TSPUB_PLUGIN_PD_RESOLUTION_TYPE enumeration that specifies the type of resolution being
    ///                        requested.
    ///    pPdAssignmentType = A value of the TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE enumeration that specifies what type of assignment was made
    ///                        for the personal desktop.
    ///    endPointName = A null-terminated string that receives the name of the end point for the desktop. The length of this string
    ///                   is limited to <b>MAX_ENDPOINT_SIZE</b> characters, including the terminating <b>NULL</b> character.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResolvePersonalDesktop(const(ushort)* userId, const(ushort)* poolId, 
                                   TSPUB_PLUGIN_PD_RESOLUTION_TYPE ePdResolutionType, 
                                   TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE* pPdAssignmentType, char* endPointName);
    ///Called to delete a mapping between the specified user and a virtual machine in a personal virtual desktop
    ///collection.
    ///Params:
    ///    userId = A null-terminated string that contains the security identifier (SID) of the user.
    ///    poolId = A null-terminated string that contains the identifier of the collection that the personal desktop exists in.
    ///    endpointName = A null-terminated string that contains the name of the desktop end point to be deleted.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeletePersonalDesktopAssignment(const(ushort)* userId, const(ushort)* poolId, 
                                            const(ushort)* endpointName);
}

///Exposes methods that allow a plug-in to manage third-party file name extensions in RemoteApp and Desktop Connection
///runtime. This interface is implemented by the Remote Desktop Services workspace runtime. These methods are called by
///custom clients.
@GUID("1D428C79-6E2E-4351-A361-C0401A03A0BA")
interface IWorkspaceResTypeRegistry : IDispatch
{
    ///Registers a third-party file name extension with the RemoteApp and Desktop Connections runtime.
    ///Params:
    ///    fMachineWide = Specifies whether the resource is to be registered per user or per machine.
    ///    bstrFileExtension = A string that contains the file name extension to register. The period must be included in the extension, for
    ///                        example, ".txt".
    ///    bstrLauncher = A string that contains the fully qualified path and file name of the application to use to launch files with
    ///                   the extension specified by the <i>bstrFileExtension</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddResourceType(short fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
    ///Unregisters a third-party file name extension with the RemoteApp and Desktop Connections runtime.
    ///Params:
    ///    fMachineWide = Specifies whether the resource is registered per user or per machine.
    ///    bstrFileExtension = A string that contains the file name extension to unregister. The period must be included in the extension,
    ///                        for example, ".txt".
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteResourceType(short fMachineWide, BSTR bstrFileExtension);
    ///Retrieves the third-party file name extensions that are registered with the RemoteApp and Desktop Connections
    ///runtime.
    ///Params:
    ///    fMachineWide = Specifies whether the resource is registered per user or per machine.
    ///    psaFileExtensions = The address of a pointer to a <b>SAFEARRAY</b> variable that receives an array of <b>BSTR</b>s that contain
    ///                        the registered file name extensions.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRegisteredFileExtensions(short fMachineWide, SAFEARRAY** psaFileExtensions);
    ///Retrieves information about a third-party file name extension that is registered with the RemoteApp and Desktop
    ///Connections runtime.
    ///Params:
    ///    fMachineWide = Specifies whether the resource is registered per user or per machine.
    ///    bstrFileExtension = A string that contains the file name extension to retrieve the information for. The period must be included
    ///                        in the extension, for example, ".txt".
    ///    pbstrLauncher = A pointer to a <b>BSTR</b> variable that receives the fully qualified path and file name of the application
    ///                    to use to launch files with the extension specified by the <i>bstrFileExtension</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetResourceTypeInfo(short fMachineWide, BSTR bstrFileExtension, BSTR* pbstrLauncher);
    ///Modifies a third-party file name extension that is registered with the RemoteApp and Desktop Connections runtime.
    ///Params:
    ///    fMachineWide = Specifies whether the resource is registered per user or per machine.
    ///    bstrFileExtension = A string that contains the file name extension to update. The period must be included in the extension, for
    ///                        example, ".txt".
    ///    bstrLauncher = A string that contains the new fully qualified path and file name of the application to use to launch files
    ///                   with the extension specified by the <i>bstrFileExtension</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ModifyResourceType(short fMachineWide, BSTR bstrFileExtension, BSTR bstrLauncher);
}

///Allows for the Remote Desktop Connection (RDC) client plug-in to be loaded by the Remote Desktop Connection (RDC)
///client. The interface is implemented by the plug-in, and is obtained by and managed by the RDC client. The RDC client
///obtains an instance of this interface by either instantiating the COM object, or by calling the
///VirtualChannelGetInstance function implemented by the plug-in. For more information about how the instances are
///obtained, see DVC plug-in registration. In all cases, this instance is kept for the lifetime of the Remote Desktop
///Connection (RDC) client. As a COM object, the plug-in must be implemented in a free-threading model. Because the
///<b>IWTSPlugin</b> methods are implemented by the plug-in, the plug-in must be aware that the call may arrive on
///different threads. The calls will always arrive serially, so it is impossible to have any two calls that are executed
///in parallel. Implementation should not block these calls because this may block other incoming connections or data on
///existing connections.
@GUID("A1230201-1439-4E62-A414-190D0AC3D40E")
interface IWTSPlugin : IUnknown
{
    ///Used for the first call that is made from the client to the plug-in. Any plug-in initialization should occur in
    ///this interface. Initialization occurs only once per plug-in.
    ///Params:
    ///    pChannelMgr = Passed instance to the channel manager (IWTSVirtualChannelManager) for the client.
    ///Returns:
    ///    Returns <b>S_OK</b> if the call completes successfully. If the call fails, the plug-in will be released by
    ///    the Remote Desktop Connection (RDC) client.
    ///    
    HRESULT Initialize(IWTSVirtualChannelManager pChannelMgr);
    ///Notifies the plug-in that the Remote Desktop Connection (RDC) client has successfully connected to the Remote
    ///Desktop Session Host (RD Session Host) server.
    ///Returns:
    ///    Returns <b>S_OK</b> if the call completes successfully. Returns <b>E_FAIL</b> if the call fails, but the
    ///    plug-in will continue to work.
    ///    
    HRESULT Connected();
    ///Notifies the plug-in that the Remote Desktop Connection (RDC) client has disconnected from the Remote Desktop
    ///Session Host (RD Session Host) server.
    ///Params:
    ///    dwDisconnectCode = Code that identifies the disconnect reason. For the possible codes, see IMsTscAxEvents::OnDisconnected.
    ///Returns:
    ///    Returns <b>S_OK</b> if the call completes successfully. Results in no action if the call fails.
    ///    
    HRESULT Disconnected(uint dwDisconnectCode);
    ///Notifies the plug-in that the Remote Desktop Connection (RDC) client has terminated. After a call is made to
    ///<b>IWTSPlugin::Terminated</b>, no other calls to the plug-in are expected. Any plug-in cleanup should be done
    ///here.
    ///Returns:
    ///    Returns <b>S_OK</b> if the call completes successfully. Results in no action if the call fails.
    ///    
    HRESULT Terminated();
}

///Manages configuration settings for each listener for the dynamic virtual channel (DVC) connection. This interface is
///implemented by the Remote Desktop Connection (RDC) client. A reference is kept typically by the Remote Desktop
///Connection (RDC) client plug-in. The methods can be executed in any thread that the plug-in chooses. An instance is
///retrieved by calling the IWTSVirtualChannelManager::CreateListener method.
@GUID("A1230206-9A39-4D58-8674-CDB4DFF4E73B")
interface IWTSListener : IUnknown
{
    ///Retrieves the listener-specific configuration. This configuration is supplied as a <b>BSTR</b> property of the
    ///property bag, under the name of <b>WTS_PROPERTY_DEFAULT_CONFIG</b> (which equals the string "DefaultConfig").
    ///Params:
    ///    ppPropertyBag = Output parameter that receives the property bag.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT GetConfiguration(IPropertyBag* ppPropertyBag);
}

///Used to notify the Remote Desktop Connection (RDC) client plug-in about incoming requests on a particular listener.
///This interface is implemented by the Remote Desktop Connection (RDC) client plug-in. Calls will always be made on the
///same thread, with the exception of an out-of-process plug-in, where the calls will arrive on a remote procedure call
///(RPC) thread pool. Implementation should not block these calls because this may block other incoming connections or
///data on existing connections.
@GUID("A1230203-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSListenerCallback : IUnknown
{
    ///Allows the Remote Desktop Connection (RDC) client plug-in to accept or deny a connection request for an incoming
    ///connection.
    ///Params:
    ///    pChannel = An IWTSVirtualChannel object that represents the incoming connection. This object will only be connected if
    ///               the connection is accepted by this method.
    ///    data = This parameter is not implemented and is reserved for future use.
    ///    pbAccept = Indicates whether the connection should be accepted. Receives <b>TRUE</b> if the connection should be
    ///               accepted or <b>FALSE</b> otherwise.
    ///    ppCallback = Receives an IWTSVirtualChannelCallback object that receives notifications for the connection. This object is
    ///                 created by the plug-in.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnNewChannelConnection(IWTSVirtualChannel pChannel, BSTR data, int* pbAccept, 
                                   IWTSVirtualChannelCallback* ppCallback);
}

///Receives notifications about channel state changes or data received. This interface is implemented by the user. Each
///instance of this interface is associated with one instance of IWTSVirtualChannel. Implementation of this interface
///should not block these calls, because this may suppress other callbacks. It is not guaranteed that these calls will
///always arrive on the same thread, even for in-process COM implementation of the plug-in. Calls to the Write and Close
///methods of IWTSVirtualChannel are permitted within these callbacks.
@GUID("A1230204-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSVirtualChannelCallback : IUnknown
{
    ///Notifies the user about data that is being received. The data has the same size and content as a corresponding
    ///WTSVirtualChannelWrite() call from the remote side. There is no hard limit on the size of the data that can be
    ///sent. All packet reconstruction is handled by the dynamic virtual channel (DVC) framework.
    ///Params:
    ///    cbSize = The size, in bytes, of the buffer to receive the data.
    ///    pBuffer = A pointer to a buffer to receive the data. This buffer is valid only until this call is complete.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Results in no action if the call fails.
    ///    
    HRESULT OnDataReceived(uint cbSize, char* pBuffer);
    ///Notifies the user that the channel has been closed. There are three ways for the channel to be closed: <ul>
    ///<li>The user has called the IWTSVirtualChannel::Close method.</li> <li>The Remote Desktop Connection (RDC) client
    ///has disconnected from the Remote Desktop Session Host (RD Session Host) server.</li> <li>The server has called
    ///the WTSVirtualChannel::Close method on the channel.</li> </ul>Regardless of how the channel has been closed,
    ///there is no need to call IWTSVirtualChannel::Close() when this call is received. If such a call is made, it is
    ///possible that if the plug-in is running out of process, that a call to <b>IWTSVirtualChannel::Close()</b> may
    ///cause a deadlock. A deadlock may occur because the caller of <b>OnClose()</b> holds a channel list lock, and the
    ///<b>Close()</b> method will try to acquire the same lock on a different thread.
    ///Returns:
    ///    Returns <b>S_OK</b> on success. Results in no action if the call fails.
    ///    
    HRESULT OnClose();
}

///Manages all Remote Desktop Connection (RDC) client plug-ins and dynamic virtual channel (DVC) listeners. This
///interface is implemented by the Remote Desktop Connection (RDC) client. Methods of this interface can be called from
///any thread.
@GUID("A1230205-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSVirtualChannelManager : IUnknown
{
    ///Returns an instance of a listener object that listens on a specific endpoint.
    ///Params:
    ///    pszChannelName = The endpoint name on which the listener will listen. This is a string value, the length of which is limited
    ///                     to <b>MAX_PATH</b> number of characters.
    ///    uFlags = This parameter is reserved and must be set to zero.
    ///    pListenerCallback = Returns a listener callback (IWTSListenerCallback) that will receive notifications for incoming connections.
    ///    ppListener = An instance of the IWTSListener object.
    ///Returns:
    ///    Returns <b>S_OK</b> on success.
    ///    
    HRESULT CreateListener(const(byte)* pszChannelName, uint uFlags, IWTSListenerCallback pListenerCallback, 
                           IWTSListener* ppListener);
}

///Used to control the channel state, and writes on the channel. This interface is implemented by the framework. Methods
///of this interface can be called from any thread.
@GUID("A1230207-D6A7-11D8-B9FD-000BDBD1F198")
interface IWTSVirtualChannel : IUnknown
{
    ///Starts a write request on the channel. All writes are considered asynchronous. Calling this method copies the
    ///contents of <i>pBuffer</i> and returns immediately, so the buffer can be reclaimed. Because of the memory copy,
    ///too many <b>Write()</b> calls may result in allocating too much memory by the client. A Close() call on this
    ///channel will cancel any pending writes.
    ///Params:
    ///    cbSize = The size, in bytes, of the buffer to which to write.
    ///    pBuffer = A pointer to a buffer on the channel to which to write the data. You can reuse this buffer as soon as the
    ///              call returns.
    ///    pReserved = Reserved for future use. The value must be <b>NULL</b>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT Write(uint cbSize, char* pBuffer, IUnknown pReserved);
    ///Closes the channel. If the channel has not already been closed, the <b>Close()</b> method will call the
    ///IWTSVirtualChannelCallback::OnClose() method into the associated virtual channel callback interface. After a
    ///channel is closed, any Write() call on it will fail.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful.
    ///    
    HRESULT Close();
}

///Provides a way for Dynamic Virtual Channel plug-ins to query various Remote Desktop Client services. This interface
///is implemented by the Remote Desktop Connection (RDC) client. You obtain an instance of this interface by calling
///QueryInterface on the IWTSVirtualChannelManager instance obtained in the plug-in's IWTSPlugin::Initialize method.
@GUID("D3E07363-087C-476C-86A7-DBB15F46DDB4")
interface IWTSPluginServiceProvider : IUnknown
{
    ///Obtains the specified service.
    ///Params:
    ///    ServiceId = Specifies the service to retrieve. This can be the following values.
    ///    ppunkObject = The address of a pointer to an IUnknown interface that receives the service object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetService(GUID ServiceId, IUnknown* ppunkObject);
}

///Used by a dynamic virtual channel plug-in to render bitmaps. This interface is implemented by the rendering service.
///The plug-in obtains a pointer to this interface by using the IWTSBitmapRenderService::GetMappedRenderer method.
@GUID("5B7ACC97-F3C9-46F7-8C5B-FA685D3441B1")
interface IWTSBitmapRenderer : IUnknown
{
    ///Called by a dynamic virtual channel plug-in to render bitmaps.
    ///Params:
    ///    imageFormat = Specifies the format of the data in the <i>pImageBuffer</i> buffer. This parameter is ignored and only
    ///                  bitmaps can be rendered.
    ///    dwWidth = The width of the bitmap.
    ///    dwHeight = The height of the bitmap.
    ///    cbStride = The stride width of the bitmap.
    ///    cbImageBuffer = The size, in bytes, of the <i>pImageBuffer</i> buffer.
    ///    pImageBuffer = An array of bytes that contains the data to render.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Render(GUID imageFormat, uint dwWidth, uint dwHeight, int cbStride, uint cbImageBuffer, 
                   char* pImageBuffer);
    ///Retrieves statistics for the RemoteFX media redirection bitmap renderer.
    ///Params:
    ///    pStatistics = Type: <b>BITMAP_RENDERER_STATISTICS*</b> The address of a BITMAP_RENDERER_STATISTICS structure that receives
    ///                  the bitmap rendering statistics.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRendererStatistics(BITMAP_RENDERER_STATISTICS* pStatistics);
    ///Called by a dynamic virtual channel plug-in to remove a render mapping.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveMapping();
}

///A dynamic virtual channel plug-in implements this interface to be notified when the size of the rendering area
///changes. A pointer to this interface is provided to the rendering service by using the
///IWTSBitmapRenderService::GetMappedRenderer method.
@GUID("D782928E-FE4E-4E77-AE90-9CD0B3E3B353")
interface IWTSBitmapRendererCallback : IUnknown
{
    ///Called when the size of the render target has changed. The image passed to IWTSBitmapRenderer::Render must
    ///conform to this size.
    ///Params:
    ///    rcNewSize = A <b>RECT</b> structure that contains the new size of the render target.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnTargetSizeChanged(RECT rcNewSize);
}

///This service is used to create a visual mapping on the client corresponding to a mapped window on the server. The
///server-side mapped window is set using the WTSSetRenderHint API. This interface is implemented by the Remote Desktop
///Connection (RDC) client. You obtain an instance of this interface by calling the
///IWTSPluginServiceProvider::GetService method, passing <b>RDCLIENT_BITMAP_RENDER_SERVICE</b>.
@GUID("EA326091-05FE-40C1-B49C-3D2EF4626A0E")
interface IWTSBitmapRenderService : IUnknown
{
    ///Obtains the bitmap rendering object used to render media on the server.
    ///Params:
    ///    mappingId = A 64-bit number that uniquely identifies the render mapping.
    ///    pMappedRendererCallback = The address of the caller's IWTSBitmapRendererCallback interface.
    ///    ppMappedRenderer = The address of an IWTSBitmapRenderer interface pointer that receives the bitmap renderer. When you have
    ///                       finished using pointer, release it by calling the IUnknown::Release() method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMappedRenderer(ulong mappingId, IWTSBitmapRendererCallback pMappedRendererCallback, 
                              IWTSBitmapRenderer* ppMappedRenderer);
}

///This interface receives notifications that relate to a graphics virtual channel. This interface is implemented by the
///RemoteFX graphics services and a pointer to this interface is provided to the graphics virtual channel in the
///IWRdsGraphicsChannel::Open method.
@GUID("67F2368C-D674-4FAE-66A5-D20628A640D2")
interface IWRdsGraphicsChannelEvents : IUnknown
{
    ///Called when a full message is received from the server.
    ///Params:
    ///    cbSize = The length, in bytes, of the data in <i>pBuffer</i>.
    ///    pBuffer = A pointer to a buffer that contains the data that was received. The <i>cbSize</i> parameter contains the
    ///              length of this buffer.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnDataReceived(uint cbSize, ubyte* pBuffer);
    ///Called when the channel has been closed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnClose();
    ///Called when the channel has been opened and is ready for use, or when an error occurs when a channel is opened.
    ///The RemoteFX graphics services calls the IWRdsGraphicsChannel::Open method to open a channel. You must call the
    ///<b>OnChannelOpened</b> method to notify the RemoteFX graphics services that the channel is open and ready for
    ///use, or if an error occurs.
    ///Params:
    ///    OpenResult = An <b>HRESULT</b> value that specifies the result of the open operation. If this parameter contains
    ///                 <b>S_OK</b>, <i>pOpenContext</i> is valid.
    ///    pOpenContext = A user-defined interface pointer that is passed as the <i>pOpenContext</i> parameter in the
    ///                   IWRdsGraphicsChannel::Open method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnChannelOpened(HRESULT OpenResult, IUnknown pOpenContext);
    ///Called when the IWRdsGraphicsChannel::Write method is called and the data has been sent. After this method has
    ///been called, the <i>pBuffer</i> parameter passed to the IWRdsGraphicsChannel::Write method is no longer needed
    ///and can be freed or reused.
    ///Params:
    ///    pWriteContext = A user-defined interface pointer that is passed as the <i>pContext</i> parameter in the
    ///                    IWRdsGraphicsChannel::Write method.
    ///    bCancelled = Contains <b>TRUE</b> if the connection was dropped during the write, or <b>FALSE</b> otherwise.
    ///    pBuffer = A pointer to a buffer that contains the data that was sent. The <i>cbBuffer</i> parameter contains the length
    ///              of this buffer.
    ///    cbBuffer = The length, in bytes, of the data in <i>pBuffer</i>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnDataSent(IUnknown pWriteContext, BOOL bCancelled, ubyte* pBuffer, uint cbBuffer);
    ///Called to notify the RemoteFX graphics services that network conditions have changed.
    ///Params:
    ///    bandwidth = The expected bandwidth, in bytes per second. If this parameter contains
    ///                <b>WRdsGraphicsChannels_Bandwidth_Unavailable</b>, bandwidth statistics are not available.
    ///    RTT = The round trip time (RTT) of the link, in milliseconds. If this parameter contains
    ///          <b>WRdsGraphicsChannels_RTT_Unavailable</b>, latency statistics are not available.
    ///    lastSentByteIndex = The byte index of the last byte that was sent from this channel at this time. This value begins at zero and
    ///                        increases for the lifetime of the connection. This value will roll back to zero when an overflow occurs.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnMetricsUpdate(uint bandwidth, uint RTT, ulong lastSentByteIndex);
}

///This interface is used by the RemoteFX graphics services to send and receive data to a virtual graphics channel. An
///instance of this interface is provided to the RemoteFX graphics services in response to the
///IWRdsGraphicsChannelManager::CreateChannel method.
@GUID("684B7A0B-EDFF-43AD-D5A2-4A8D5388F401")
interface IWRdsGraphicsChannel : IUnknown
{
    ///Called to send data to the virtual channel.
    ///Params:
    ///    cbSize = The length, in bytes, of the data in <i>pBuffer</i>.
    ///    pBuffer = A pointer to a buffer that contains the data that was sent. The <i>cbBuffer</i> parameter contains the length
    ///              of this buffer. The implementation will take ownership of this buffer until the
    ///              IWRdsGraphicsChannelEvents::OnDataSent method is called. Before that time, this buffer must not be modified
    ///              or freed.
    ///    pContext = A user-defined interface pointer that is passed as the <i>pWriteContext</i> parameter in the
    ///               IWRdsGraphicsChannelEvents::OnDataSent method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Write(uint cbSize, ubyte* pBuffer, IUnknown pContext);
    ///Called to close the channel. The IWRdsGraphicsChannelEvents::OnClose method will be called when the channel is
    ///completely closed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///Called to open a channel. When the channel is completely open and ready for use, you must call the
    ///IWRdsGraphicsChannelEvents::OnChannelOpened method.
    ///Params:
    ///    pChannelEvents = Type: <b>IWRdsGraphicsChannelEvents*</b> A pointer to an IWRdsGraphicsChannelEvents interface that will
    ///                     receive notifications relating to the channel created.
    ///    pOpenContext = Type: <b>IUnknown*</b> A user-defined interface pointer that is passed as the <i>pOpenContext</i> parameter
    ///                   in the IWRdsGraphicsChannelEvents::OnChannelOpened method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Open(IWRdsGraphicsChannelEvents pChannelEvents, IUnknown pOpenContext);
}

///This interface is used by the RemoteFX graphics services API to create the graphics virtual channels necessary for
///remoting graphics data. The channel implementer provides a pointer to this interface in the
///IWRdsRemoteFXGraphicsConnection::GetVirtualChannelTransport method.
@GUID("0FD57159-E83E-476A-A8B9-4A7976E71E18")
interface IWRdsGraphicsChannelManager : IUnknown
{
    ///Used to create a graphics virtual channel.
    ///Params:
    ///    pszChannelName = Type: <b>const char*</b> The name of the channel to create. This will be one of the following values.
    ///    channelType = Type: <b>WRdsGraphicsChannelType</b> A value of the WRdsGraphicsChannelType enumeration that specifies what
    ///                  type of channel to create. If the specified type of channel cannot be created, this method should return a
    ///                  channel object rather than fail.
    ///    ppVirtualChannel = Type: <b>IWRdsGraphicsChannel**</b> The address of an IWRdsGraphicsChannel interface pointer that receives
    ///                       the channel object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateChannel(const(byte)* pszChannelName, WRdsGraphicsChannelType channelType, 
                          IWRdsGraphicsChannel* ppVirtualChannel);
}

///<p class="CCE_Message">[<b>IWTSProtocolManager</b> is no longer available for use as of Windows Server 2012. Instead,
///use IWRdsProtocolManager.] Exposes methods that the Remote Desktop Services service uses to communicate with the
///protocol provider. It is the only interface in the protocol provider for which the Remote Desktop Services service
///calls CoCreateInstanceEx. In addition, the first call the Remote Desktop Services service makes into the protocol
///provider is to the CreateListener method.
@GUID("F9EAF6CC-ED79-4F01-821D-1F881B9F66CC")
interface IWTSProtocolManager : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolManager::CreateListener</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolManager::CreateListener.] Requests the creation of an IWTSProtocolListener
    ///object that listens for incoming client connection requests. The protocol provider must add a reference to the
    ///<b>IWTSProtocolListener</b> object before returning. The Remote Desktop Services service releases the reference
    ///when the service stops or the listener object is deleted.
    ///Params:
    ///    wszListenerName = A pointer to a string that contains the registry GUID that specifies the listener to create.
    ///    pProtocolListener = The address of a pointer to the IWTSProtocolListener object.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT CreateListener(ushort* wszListenerName, IWTSProtocolListener* pProtocolListener);
    ///<p class="CCE_Message">[<b>IWTSProtocolManager::NotifyServiceStateChange</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolManager::NotifyServiceStateChange.] Notifies the protocol provider
    ///that the state of the Remote Desktop Services service is changing.
    ///Params:
    ///    pTSServiceStateChange = A pointer to a WTS_SERVICE_STATE structure that specifies whether the service is starting, stopping, or
    ///                            changing its drain state.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    ///<p class="CCE_Message">[<b>IWTSProtocolManager::NotifySessionOfServiceStart</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolManager::NotifySessionOfServiceStart.] Notifies the protocol
    ///provider that the Remote Desktop Services service has started for a given session.
    ///Params:
    ///    SessionId = A pointer to a WTS_SESSION_ID structure that uniquely identifies the session.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    ///<p class="CCE_Message">[<b>IWTSProtocolManager::NotifySessionOfServiceStop</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolManager::NotifySessionOfServiceStop.] Notifies the protocol
    ///provider that the Remote Desktop Services service has stopped for a given session.
    ///Params:
    ///    SessionId = A pointer to a WTS_SESSION_ID structure that uniquely identifies the session.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    ///<p class="CCE_Message">[<b>IWTSProtocolManager::NotifySessionStateChange</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolManager::NotifySessionStateChange.] Notifies the protocol provider
    ///of changes in the state of a session.
    ///Params:
    ///    SessionId = A pointer to a WTS_SESSION_ID structure that uniquely identifies the session.
    ///    EventId = An integer that contains the event ID. The following IDs can be found in Winuser.h.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
}

///<p class="CCE_Message">[<b>IWTSProtocolListener</b> is no longer available for use as of Windows Server 2012.
///Instead, use IWRdsProtocolListener.] Exposes methods that request that the protocol start and stop listening for
///client connection requests. The interface is implemented by the protocol and its methods are called by the Remote
///Desktop Services service.
@GUID("23083765-45F0-4394-8F69-32B2BC0EF4CA")
interface IWTSProtocolListener : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolListener::StartListen</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolListener::StartListen.] Notifies the protocol to start listening for
    ///client connection requests.
    ///Params:
    ///    pCallback = A pointer to an IWTSProtocolListenerCallback object implemented by the Remote Desktop Servicesservice. The
    ///                protocol uses the <b>IWTSProtocolListenerCallback</b> object to notify the Remote Desktop Services service
    ///                about incoming connection requests. The protocol must add a reference to this object and release it when
    ///                StopListen is called.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StartListen(IWTSProtocolListenerCallback pCallback);
    ///<p class="CCE_Message">[<b>IWTSProtocolListener::StopListen</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolListener::StopListen.] Notifies the protocol to stop listening for client
    ///connection requests.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StopListen();
}

///<p class="CCE_Message">[<b>IWTSProtocolListenerCallback</b> is no longer available for use as of Windows Server 2012.
///Instead, use IWRdsProtocolListenerCallback.] Exposes methods that notify the Remote Desktop Services service that a
///client has connected. This interface is the callback object for the IWTSProtocolListener interface. It is implemented
///by the Remote Desktop Services service and called by the protocol.
@GUID("23083765-1A2D-4DE2-97DE-4A35F260F0B3")
interface IWTSProtocolListenerCallback : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolListenerCallback::OnConnected</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolListenerCallback::OnConnected.] Notifies the Remote Desktop
    ///Services service that a client connection request has been received. After this method is called, the Remote
    ///Desktop Services service begins the client connection sequence.
    ///Params:
    ///    pConnection = A pointer to an IWTSProtocolConnection interface that represents a client connection. The Remote Desktop
    ///                  Services service adds a reference to this object and releases it when it closes the connection.
    ///    pCallback = The address of a pointer to an IWTSProtocolConnectionCallback interface used by the protocol to notify the
    ///                Remote Desktop Services service about the status of a client connection. The Remote Desktop Services service
    ///                adds a reference to this object and the protocol must release it when the connection is closed.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT OnConnected(IWTSProtocolConnection pConnection, IWTSProtocolConnectionCallback* pCallback);
}

///<p class="CCE_Message">[<b>IWTSProtocolConnection</b> is no longer available for use as of Windows Server 2012.
///Instead, use IWRdsProtocolConnection.] Exposes methods called by the Remote Desktop Services service to configure a
///client connection. Your protocol must implement this interface to handle connection requests from clients. When the
///protocol listener receives a connection request from a client, it must create an <b>IWTSProtocolConnection</b> object
///and pass it to the Remote Desktop Services service by calling the OnConnected method. In response, the service adds a
///reference to the IWTSProtocolConnectionCallback object and returns a pointer to it. When the connection is no longer
///needed, the protocol must release the pointer. During a connection sequence, the following methods are called by the
///Remote Desktop Services service in the order listed. <ol> <li> GetLogonErrorRedirector </li> <li> SendPolicyData
///</li> <li> AcceptConnection </li> <li> GetClientData </li> <li> GetUserCredentials </li> <li> GetLicenseConnection
///</li> <li> AuthenticateClientToSession </li> <li> NotifySessionId </li> <li> GetProtocolHandles </li> <li>
///ConnectNotify </li> <li> IsUserAllowedToLogon </li> <li> SessionArbitrationEnumeration </li> <li> LogonNotify </li>
///<li> GetUserData </li> </ol>If the Remote Desktop Services service needs to reconnect after calling
///SessionArbitrationEnumeration, it reconnects by calling the following methods in the order listed: <ol> <li>
///DisconnectNotify (Called on the new session that was created.)</li> <li> NotifySessionId (Called on the existing
///session.)</li> <li> GetProtocolHandles </li> <li> ConnectNotify </li> <li> LogonNotify </li> </ol>To disconnect, the
///Remote Desktop Services service calls the following methods in the order listed: <ol> <li> DisconnectNotify </li>
///<li> Close </li> </ol>The Remote Desktop Services service can call the following methods at any time after a
///connection has been established: <ul> <li> GetProtocolStatus </li> <li> GetLastInputTime </li> <li> SetErrorInfo
///</li> <li> SendBeep </li> <li> CreateVirtualChannel </li> <li> QueryProperty </li> <li> GetShadowConnection </li>
///</ul>
@GUID("23083765-9095-4648-98BF-EF81C914032D")
interface IWTSProtocolConnection : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetLogonErrorRedirector</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolConnection::GetLogonErrorRedirector.] Retrieves an
    ///IWTSProtocolLogonErrorRedirector interface that specifies how the protocol should handle client logon errors. The
    ///protocol must add a reference to this object before returning, and the Remote Desktop Services service releases
    ///the reference when the connection is closed.
    ///Params:
    ///    ppLogonErrorRedir = Address of a pointer to an IWTSProtocolLogonErrorRedirector interface.
    HRESULT GetLogonErrorRedirector(IWTSProtocolLogonErrorRedirector* ppLogonErrorRedir);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::SendPolicyData</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolManager::NotifySettingsChange.] Sends computer policy settings to
    ///the custom protocol. These settings are a combination of listener policies and Group Policy settings.
    ///Params:
    ///    pPolicyData = A pointer to a WTS_POLICY_DATA structure that contains computer policy settings.
    HRESULT SendPolicyData(WTS_POLICY_DATA* pPolicyData);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::AcceptConnection</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::AcceptConnection.] Directs the protocol to continue
    ///with the connection request.
    HRESULT AcceptConnection();
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetClientData</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolConnection::GetClientData.] Requests client settings from the protocol.
    ///Params:
    ///    pClientData = A pointer to a WTS_CLIENT_DATA structure that contains the client settings.
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetUserCredentials</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::GetUserCredentials.] Returns user credentials.
    ///Params:
    ///    pUserCreds = A pointer to a WTS_USER_CREDENTIAL structure that contains the credentials. Currently, only the user name,
    ///                 password, and domain are supported. The user name and password are plaintext.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetLicenseConnection</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::GetLicenseConnection.] Retrieves an
    ///IWTSProtocolLicenseConnection object that is used to begin the client licensing process. The protocol must add a
    ///reference to this object before returning. When the Remote Desktop Services service has finished the licensing
    ///process, it will release the reference.
    ///Params:
    ///    ppLicenseConnection = The address of a pointer to an IWTSProtocolLicenseConnection interface.
    HRESULT GetLicenseConnection(IWTSProtocolLicenseConnection* ppLicenseConnection);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::AuthenticateClientToSession</b> is no longer available for use
    ///as of Windows Server 2012. Instead, use IWRdsProtocolConnection::AuthenticateClientToSession.] Specifies a
    ///session that the connection should be reconnected to.
    ///Params:
    ///    SessionId = A pointer to a WTS_SESSION_ID structure that uniquely identifies the session.
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::NotifySessionId</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::NotifySessionId.] Sends the ID of the new session to
    ///the protocol.
    ///Params:
    ///    SessionId = A pointer to a WTS_SESSION_ID structure that contains a connection GUID and the associated session ID.
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetProtocolHandles</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::GetInputHandles and
    ///IWRdsProtocolConnection::GetVideoHandle.] Retrieves keyboard, mouse, sound, and beep handles supported by the
    ///protocol.
    ///Params:
    ///    pKeyboardHandle = A pointer to a keyboard handle. This is a handle to an I8042prt keyboard driver.
    ///    pMouseHandle = A pointer to a mouse handle. This is a handle to a Mouclass driver.
    ///    pBeepHandle = A pointer to a beep device handle. This handle is not used and must be set to <b>NULL</b>.
    ///    pVideoHandle = A pointer to a video device handle. This is a handle to the video miniport driver for the remote session
    ///                   associated with the protocol.
    HRESULT GetProtocolHandles(size_t* pKeyboardHandle, size_t* pMouseHandle, size_t* pBeepHandle, 
                               size_t* pVideoHandle);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::ConnectNotify</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolConnection::ConnectNotify.] Signals that the session has been initialized.
    ///Params:
    ///    SessionId = An integer that contains the session ID associated with the client.
    HRESULT ConnectNotify(uint SessionId);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::IsUserAllowedToLogon</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::IsUserAllowedToLogon.] Determines whether a user is
    ///allowed to log on to a session.
    ///Params:
    ///    SessionId = An integer that contains the session ID associated with the user.
    ///    UserToken = A pointer to the user token handle.
    ///    pDomainName = A pointer to a string that contains the domain name for the user.
    ///    pUserName = A pointer to a string that contains the user name.
    HRESULT IsUserAllowedToLogon(uint SessionId, size_t UserToken, ushort* pDomainName, ushort* pUserName);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::SessionArbitrationEnumeration</b> is no longer available for
    ///use as of Windows Server 2012. Instead, use IWRdsProtocolConnection::SessionArbitrationEnumeration.] Retrieves a
    ///collection of session IDs for reconnection.
    ///Params:
    ///    hUserToken = A pointer to a user token handle.
    ///    bSingleSessionPerUserEnabled = A Boolean value that specifies whether a user can be associated with, at most, one session.
    ///    pSessionIdArray = A pointer to an array of integers that contains the disconnected session IDs for the user.
    ///    pdwSessionIdentifierCount = A pointer to an integer that specifies the number of disconnected session IDs referenced by the
    ///                                <i>pSessionIdArray</i> parameter.
    HRESULT SessionArbitrationEnumeration(size_t hUserToken, BOOL bSingleSessionPerUserEnabled, 
                                          char* pSessionIdArray, uint* pdwSessionIdentifierCount);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::LogonNotify</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolConnection::LogonNotify.] Specifies that the user has logged on to the
    ///session.
    ///Params:
    ///    hClientToken = A pointer to a user token handle.
    ///    wszUserName = A pointer to a string that contains the user name.
    ///    wszDomainName = A pointer to a string that contains the domain name for the user.
    ///    SessionId = A pointer to a WTS_SESSION_ID structure that contains the session ID associated with the user.
    HRESULT LogonNotify(size_t hClientToken, ushort* wszUserName, ushort* wszDomainName, WTS_SESSION_ID* SessionId);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetUserData</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolSettings::MergeSettings.] Sends merged policy settings to the protocol and
    ///requests user policy settings from the protocol.
    ///Params:
    ///    pPolicyData = A pointer to a WTS_POLICY_DATA structure that contains the merged Group Policy values.
    ///    pClientData = A pointer to a WTS_USER_DATA structure that contains client property information.
    HRESULT GetUserData(WTS_POLICY_DATA* pPolicyData, WTS_USER_DATA* pClientData);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::DisconnectNotify</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::DisconnectNotify.] Notifies the protocol that the
    ///session has been disconnected.
    HRESULT DisconnectNotify();
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::Close</b> is no longer available for use as of Windows Server
    ///2012. Instead, use IWRdsProtocolConnection::Close.] Closes a connection after the session is disconnected.
    HRESULT Close();
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetProtocolStatus</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::GetProtocolStatus.] Retrieves information about the
    ///protocol status.
    ///Params:
    ///    pProtocolStatus = A pointer to a WTS_PROTOCOL_STATUS structure that contains counter, signal, and cache information for the
    ///                      protocol.
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetLastInputTime</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::GetLastInputTime.] Returns the last time the protocol
    ///received input data.
    ///Params:
    ///    pLastInputTime = An integer that contains the elapsed time, in milliseconds.
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::SetErrorInfo</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolConnection::SetErrorInfo.] Sends an error code to the client.
    ///Params:
    ///    ulError = An integer that contains the error code.
    HRESULT SetErrorInfo(uint ulError);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::SendBeep</b> is no longer available for use as of Windows
    ///Server 2012.] Sends a sound pulse to the console speaker on the client. The beep() function does not cause
    ///<b>SendBeep</b> to be called. To work around this issue, the user must enable Remote Desktop Services audio
    ///redirection capabilities to remotely hear beep sounds.
    ///Params:
    ///    Frequency = An integer that contains the pulse frequency ranging from 37 to 32,767 Hertz.
    ///    Duration = An integer that contains the pulse duration, in milliseconds.
    HRESULT SendBeep(uint Frequency, uint Duration);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::CreateVirtualChannel</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::CreateVirtualChannel.] Creates a static or dynamic
    ///virtual channel.
    ///Params:
    ///    szEndpointName = A string value that contains the endpoint data that uniquely identifies the connection.
    ///    bStatic = A Boolean value that specifies whether the virtual channel is static or dynamic. A value of <b>TRUE</b>
    ///              specifies a static channel.
    ///    RequestedPriority = An integer that contains the priority.
    ///    phChannel = A pointer to the channel handle.
    HRESULT CreateVirtualChannel(byte* szEndpointName, BOOL bStatic, uint RequestedPriority, size_t* phChannel);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::QueryProperty</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolConnection::QueryProperty.] Retrieves the specified property from the
    ///protocol. This method can be used by other Windows modules to request data from or send data to the protocol.
    ///Params:
    ///    QueryType = A <b>GUID</b> that specifies the property. This can be one of the following values.
    ///    ulNumEntriesIn = An integer that contains the number of WTS_PROPERTY_VALUE structures passed in the <i>pPropertyEntriesIn</i>
    ///                     argument.
    ///    ulNumEntriesOut = An integer that contains the number of WTS_PROPERTY_VALUE structures passed in the <i>pPropertyEntriesOut</i>
    ///                      argument.
    ///    pPropertyEntriesIn = One or more WTS_PROPERTY_VALUE structures that can be used to help find the requested property information.
    ///    pPropertyEntriesOut = One or more WTS_PROPERTY_VALUE structures that contain the requested property information.
    HRESULT QueryProperty(GUID QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, char* pPropertyEntriesIn, 
                          char* pPropertyEntriesOut);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnection::GetShadowConnection</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnection::GetShadowConnection.] Retrieves a
    ///IWTSProtocolShadowConnection object from the protocol. The method must add a reference to the object before
    ///returning. When the Remote Desktop Services service has finished the licensing process, it will release the
    ///reference.
    ///Params:
    ///    ppShadowConnection = The address of a pointer to an IWTSProtocolShadowConnection interface.
    HRESULT GetShadowConnection(IWTSProtocolShadowConnection* ppShadowConnection);
}

///<p class="CCE_Message">[<b>IWTSProtocolConnectionCallback</b> is no longer available for use as of Windows Server
///2012. Instead, use IWRdsProtocolConnectionCallback.] Exposes methods that provide information about the status of a
///client connection and that perform actions for the client. This interface is implemented by the Remote Desktop
///Services service and called by the protocol. An instance of this interface is associated with a specific instance of
///the IWTSProtocolConnection interface. When the following documentation refers to a connection, it is therefore
///referring to the specific connection for which the <b>IWTSProtocolConnection</b> object was created.
@GUID("23083765-75EB-41FE-B4FB-E086242AFA0F")
interface IWTSProtocolConnectionCallback : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolConnectionCallback::OnReady</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnectionCallback::OnReady.] Requests that the Remote Desktop
    ///Services service continue the connection process for that client.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT OnReady();
    ///<p class="CCE_Message">[<b>IWTSProtocolConnectionCallback::BrokenConnection</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolConnectionCallback::BrokenConnection.] Informs the Remote
    ///Desktop Services service that the client connection has been lost.
    ///Params:
    ///    Reason = This parameter is not used.
    ///    Source = This parameter is not used.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT BrokenConnection(uint Reason, uint Source);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnectionCallback::StopScreenUpdates</b> is no longer available for use
    ///as of Windows Server 2012. Instead, use IWRdsProtocolConnectionCallback::StopScreenUpdates.] Requests that the
    ///Remote Desktop Services service stop updating the client screen.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StopScreenUpdates();
    ///<p class="CCE_Message">[<b>IWTSProtocolConnectionCallback::RedrawWindow</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolConnectionCallback::RedrawWindow.] Requests that the Remote
    ///Desktop Services service redraw the client window.
    ///Params:
    ///    rect = A WTS_SMALL_RECT structure that contains the x and y coordinates of the screen to redraw. A value of
    ///           <b>NULL</b> requests that the entire screen be redrawn.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    ///<p class="CCE_Message">[<b>IWTSProtocolConnectionCallback::DisplayIOCtl</b> is no longer available for use as of
    ///Windows Server 2012.] Requests that the Remote Desktop Services service send data to the display driver loaded in
    ///the session.
    ///Params:
    ///    DisplayIOCtl = A WTS_DISPLAY_IOCTL structure that contains data to be sent to the display driver loaded in the session.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT DisplayIOCtl(WTS_DISPLAY_IOCTL* DisplayIOCtl);
}

///<p class="CCE_Message">[<b>IWTSProtocolShadowConnection</b> is no longer available for use as of Windows Server 2012.
///Instead, use IWRdsProtocolShadowConnection.] Exposes methods that notify the protocol provider about the status of
///session shadowing. The <b>IWTSProtocolShadowConnection</b> interface can also be used to exchange information between
///the shadow client and the shadow target. This interface is implemented by the protocol provider, and its methods are
///called by the Remote Desktop Services service.
@GUID("EE3B0C14-37FB-456B-BAB3-6D6CD51E13BF")
interface IWTSProtocolShadowConnection : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolShadowConnection::Start</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolShadowConnection::Start.] Notifies the protocol that shadowing has
    ///started.
    ///Params:
    ///    pTargetServerName = A pointer to a string that contains the name of the shadowing server.
    ///    TargetSessionId = An integer that specifies the ID of the target session to shadow.
    ///    HotKeyVk = The virtual key code of the key that must be pressed to stop shadowing. This key is used in combination with
    ///               the <i>HotkeyModifiers</i> parameter.
    ///    HotkeyModifiers = The virtual modifier that specifies the modifier key to press to stop shadowing. Modifier keys include the
    ///                      Shift, Alt, and Ctrl keys. The modifier key is used in combination with the key signified by the
    ///                      <i>HotKeyVk</i> parameter.
    ///    pShadowCallback = A pointer to an IWTSProtocolShadowCallback interface that the protocol can use to call back into the Remote
    ///                      Desktop Services service.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT Start(ushort* pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, 
                  IWTSProtocolShadowCallback pShadowCallback);
    ///<p class="CCE_Message">[<b>IWTSProtocolShadowConnection::Stop</b> is no longer available for use as of Windows
    ///Server 2012. Instead, use IWRdsProtocolShadowConnection::Stop.] Notifies the protocol that shadowing has stopped.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    The Remote Desktop Services service drops the connection if an error is returned.
    ///    
    HRESULT Stop();
    ///<p class="CCE_Message">[<b>IWTSProtocolShadowConnection::DoTarget</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolShadowConnection::DoTarget.] Requests that the protocol start the
    ///target side of a shadow connection.
    ///Params:
    ///    pParam1 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param1Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam1</i> parameter.
    ///    pParam2 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param2Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam2</i> parameter.
    ///    pParam3 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param3Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam3</i> parameter.
    ///    pParam4 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param4Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam4</i> parameter.
    ///    pClientName = A pointer to a string that contains the name of the shadow client.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT DoTarget(char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, 
                     uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

///<p class="CCE_Message">[<b>IWTSProtocolShadowCallback</b> is no longer available for use as of Windows Server 2012.
///Instead, use IWRdsProtocolShadowCallback.] Exposes methods called by the protocol to notify the Remote Desktop
///Services service to start or stop the target side of a shadow. This interface is the callback interface for the
///IWTSProtocolShadowConnection interface. It is implemented by the Remote Desktop Services service and called by the
///protocol provider.
@GUID("503A2504-AAE5-4AB1-93E0-6D1C4BC6F71A")
interface IWTSProtocolShadowCallback : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolShadowCallback::StopShadow</b> is no longer available for use as of
    ///Windows Server 2012. Instead, use IWRdsProtocolShadowCallback::StopShadow.] Instructs the Remote Desktop Services
    ///service to stop shadowing a target. This method is called in response to a call of DoTarget by the shadow client.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StopShadow();
    ///<p class="CCE_Message">[<b>IWTSProtocolShadowCallback::InvokeTargetShadow</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolShadowCallback::InvokeTargetShadow.] Instructs the Remote
    ///Desktop Services service to begin the target side of the shadow and passes any information that must be exchanged
    ///between the client and the target.
    ///Params:
    ///    pTargetServerName = A pointer to a string that contains the name of the shadow target server.
    ///    TargetSessionId = An integer that specifies the ID of the target session to shadow.
    ///    pParam1 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param1Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam1</i> parameter.
    ///    pParam2 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param2Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam2</i> parameter.
    ///    pParam3 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param3Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam3</i> parameter.
    ///    pParam4 = A pointer to a byte that contains an arbitrary parameter.
    ///    Param4Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam4</i> parameter.
    ///    pClientName = A pointer to a string that contains the name of the shadow client.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT InvokeTargetShadow(ushort* pTargetServerName, uint TargetSessionId, char* pParam1, uint Param1Size, 
                               char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, 
                               uint Param4Size, ushort* pClientName);
}

///<p class="CCE_Message">[<b>IWTSProtocolLicenseConnection</b> is no longer available for use as of Windows Server
///2012. Instead, use IWRdsProtocolLicenseConnection.] Exposes methods used by the Remote Desktop Services service to
///perform the licensing handshake during a connection sequence. This interface is implemented by the protocol, and its
///methods are called by the Remote Desktop Services service.
@GUID("23083765-178C-4079-8E4A-FEA6496A4D70")
interface IWTSProtocolLicenseConnection : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolLicenseConnection::RequestLicensingCapabilities</b> is no longer available
    ///for use as of Windows Server 2012. Instead, use IWRdsProtocolLicenseConnection::RequestLicensingCapabilities.]
    ///Requests license capabilities from the client.
    ///Params:
    ///    ppLicenseCapabilities = A pointer to a WTS_LICENSE_CAPABILITIES structure that contains information about the client license
    ///                            capabilities.
    ///    pcbLicenseCapabilities = A pointer to an integer that contains the size of the structure specified by the
    ///                             <i>ppLicensingCapabilities</i> parameter.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, 
                                         uint* pcbLicenseCapabilities);
    ///<p class="CCE_Message">[<b>IWTSProtocolLicenseConnection::SendClientLicense</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolLicenseConnection::SendClientLicense.] Sends a license to the
    ///client.
    ///Params:
    ///    pClientLicense = A pointer to a byte array that contains the license.
    ///    cbClientLicense = An integer that contains the size, in bytes, of the license.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    The remote connection manager logs any errors that you return.
    ///    
    HRESULT SendClientLicense(char* pClientLicense, uint cbClientLicense);
    ///<p class="CCE_Message">[<b>IWTSProtocolLicenseConnection::RequestClientLicense</b> is no longer available for use
    ///as of Windows Server 2012. Instead, use IWRdsProtocolLicenseConnection::RequestClientLicense.] Requests a license
    ///from the client.
    ///Params:
    ///    Reserve1 = A pointer to a byte array that contains additional data that can be acted upon by the client.
    ///    Reserve2 = An integer that contains the size, in bytes, of the data specified by the <i>Reserve1</i> parameter.
    ///    ppClientLicense = A pointer to a byte array that contains the license request.
    ///    pcbClientLicense = An integer that contains the size, in bytes, of the request specified by the <i>ppClientLicense</i>
    ///                       parameter.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RequestClientLicense(char* Reserve1, uint Reserve2, char* ppClientLicense, uint* pcbClientLicense);
    ///<p class="CCE_Message">[<b>IWTSProtocolLicenseConnection::ProtocolComplete</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolLicenseConnection::ProtocolComplete.] Notifies the protocol
    ///whether the licensing process completed successfully.
    ///Params:
    ///    ulComplete = An integer that specifies whether the licensing process ended successfully. A value of one (1) means success.
    ///                 All other values indicate failure.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT ProtocolComplete(uint ulComplete);
}

///<p class="CCE_Message">[<b>IWTSProtocolLogonErrorRedirector</b> is no longer available for use as of Windows Server
///2012. Instead, use IWRdsProtocolLogonErrorRedirector.] Exposes methods called by the Remote Desktop Services service
///to update logon status and determine how to direct logon error messages. This interface is implemented by the
///protocol.
@GUID("FD9B61A7-2916-4627-8DEE-4328711AD6CB")
interface IWTSProtocolLogonErrorRedirector : IUnknown
{
    ///<p class="CCE_Message">[<b>IWTSProtocolLogonErrorRedirector::OnBeginPainting</b> is no longer available for use
    ///as of Windows Server 2012. Instead, use IWRdsProtocolLogonErrorRedirector::OnBeginPainting.] Notifies the
    ///protocol that the logon user interface is ready to begin painting.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT OnBeginPainting();
    ///<p class="CCE_Message">[<b>IWTSProtocolLogonErrorRedirector::RedirectStatus</b> is no longer available for use as
    ///of Windows Server 2012. Instead, use IWRdsProtocolLogonErrorRedirector::RedirectStatus.] Queries the protocol
    ///regarding how to redirect the client logon status update.
    ///Params:
    ///    pszMessage = A pointer to a string that contains the logon status message.
    ///    pResponse = A pointer to a WTS_LOGON_ERROR_REDIRECTOR_RESPONSE enumeration that contains the response. This can be one of
    ///                the following values.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedirectStatus(const(wchar)* pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    ///<p class="CCE_Message">[<b>IWTSProtocolLogonErrorRedirector::RedirectMessage</b> is no longer available for use
    ///as of Windows Server 2012. Instead, use IWRdsProtocolLogonErrorRedirector::RedirectMessage.] Queries the protocol
    ///regarding how to redirect the logon message.
    ///Params:
    ///    pszCaption = A pointer to a string that contains the message box caption.
    ///    pszMessage = A pointer to a string that contains the logon message.
    ///    uType = An integer that contains the message box type. For more information, see the <b>MessageBox</b> function.
    ///    pResponse = A pointer to a WTS_LOGON_ERROR_REDIRECTOR_RESPONSE enumeration that specifies to the Remote Desktop Services
    ///                service the preferred response for redirecting the logon message.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedirectMessage(const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, 
                            WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    ///<p class="CCE_Message">[<b>IWTSProtocolLogonErrorRedirector::RedirectLogonError</b> is no longer available for
    ///use as of Windows Server 2012. Instead, use IWRdsProtocolLogonErrorRedirector::RedirectLogonError.] Queries the
    ///protocol for the action to take in response to a logon error. The RedirectStatus method is called by the Remote
    ///Desktop Services service to query the protocol for the action to take in response to a logon error.
    ///Params:
    ///    ntsStatus = An integer that contains information about the logon failure. This can be one of the following values.
    ///    ntsSubstatus = An integer that contains information about why a logon attempt failed. This value is set only if the account
    ///                   information of the user is valid and the logon is rejected. This can contain one of the following values.
    ///    pszCaption = A pointer to a string that contains the message box caption.
    ///    pszMessage = A pointer to a string that contains the message.
    ///    uType = An integer that contains the message box type. For more information, see the <b>MessageBox</b> function.
    ///    pResponse = A pointer to a WTS_LOGON_ERROR_REDIRECTOR_RESPONSE enumeration that specifies to the Remote Desktop Services
    ///                service the preferred response to the logon error.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(wchar)* pszCaption, const(wchar)* pszMessage, 
                               uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

///<p class="CCE_Message">[The IWRdsRemoteFXGraphicsConnection interface is deprecated and should not be used. ] Exposes
///methods relating to the manipulation and understanding of graphics on the client connection.
@GUID("0FAD5DCF-C6D3-423C-B097-163D6A676151")
interface IWRdsRemoteFXGraphicsConnection : IUnknown
{
    ///<p class="CCE_Message">[The EnableRemoteFXGraphics method is deprecated and should not be used. ] Queries the
    ///protocol if RemoteFX graphics should be enabled for the connection.
    ///Params:
    ///    pEnableRemoteFXGraphics = The address of a <b>BOOL</b> variable that receives <b>TRUE</b> to enable remote FX graphics; otherwise,
    ///                              <b>FALSE</b>.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT EnableRemoteFXGraphics(int* pEnableRemoteFXGraphics);
    ///<p class="CCE_Message">[The GetVirtualChannelTransport method is deprecated and should not be used. ] Retrieves
    ///the virtual channel transport object.
    ///Params:
    ///    ppTransport = A pointer to a returned object pointer that represents the virtual channel transport. This is a pointer to
    ///                  the IWRdsGraphicsChannelManager interface.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT GetVirtualChannelTransport(IUnknown* ppTransport);
}

///Exposes methods for retrieving and adding policy-related settings.
@GUID("654A5A6A-2550-47EB-B6F7-EBD637475265")
interface IWRdsProtocolSettings : IUnknown
{
    ///Retrieves the settings for a particular policy.
    ///Params:
    ///    WRdsSettingType = A value of the WRDS_SETTING_TYPE enumeration that specifies the area in which to retrieve the settings
    ///                      (machine group policy, user group policy, or user security accounts manager).
    ///    WRdsSettingLevel = A value of the WRDS_SETTING_LEVEL enumeration that specifies the type of structure contained in the
    ///                       <b>WRdsSetting</b> member of the WRDS_SETTINGS structure.
    ///    pWRdsSettings = A pointer to a WRDS_SETTINGS structure that contains the returned settings.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT GetSettings(WRDS_SETTING_TYPE WRdsSettingType, WRDS_SETTING_LEVEL WRdsSettingLevel, 
                        WRDS_SETTINGS* pWRdsSettings);
    ///Adds (merges) the specified policy-related settings into the larger group of connection settings.
    ///Params:
    ///    pWRdsSettings = A pointer to a WRDS_SETTINGS structure that contains the policy-related settings to add.
    ///    WRdsConnectionSettingLevel = A value of the WRDS_CONNECTION_SETTING_LEVEL enumeration that specifies the type of structure contained in
    ///                                 the <b>WRdsConnectionSetting</b> member of the WRDS_CONNECTION_SETTINGS structure.
    ///    pWRdsConnectionSettings = A pointer to a WRDS_CONNECTION_SETTINGS structure that contains the existing connection settings. When the
    ///                              method returns, this structure is updated to include the merged settings.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT MergeSettings(WRDS_SETTINGS* pWRdsSettings, WRDS_CONNECTION_SETTING_LEVEL WRdsConnectionSettingLevel, 
                          WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
}

///Exposes methods that the Remote Desktop Services service uses to communicate with the protocol provider. It is the
///only interface in the protocol provider for which the Remote Desktop Services service calls CoCreateInstanceEx. In
///addition, the first call the Remote Desktop Services service makes into the protocol provider is to the
///CreateListener method.
@GUID("DC796967-3ABB-40CD-A446-105276B58950")
interface IWRdsProtocolManager : IUnknown
{
    ///Initializes the protocol manager.
    ///Params:
    ///    pIWRdsSettings = A pointer to an object that implements the IWRdsProtocolSettings interface.
    ///    pWRdsSettings = A pointer to a WRDS_SETTINGS structure that contains the settings to use.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT Initialize(IWRdsProtocolSettings pIWRdsSettings, WRDS_SETTINGS* pWRdsSettings);
    ///Requests the creation of an IWRdsProtocolListener object that listens for incoming client connection requests.
    ///The protocol provider must add a reference to the IWRdsProtocolListener object before returning. The Remote
    ///Desktop Services service releases the reference when the service stops or the listener object is deleted.
    ///Params:
    ///    wszListenerName = A pointer to a string that contains the registry GUID that specifies the listener to create.
    ///    pProtocolListener = The address of a pointer to the IWRdsProtocolListener object.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT CreateListener(ushort* wszListenerName, IWRdsProtocolListener* pProtocolListener);
    ///Notifies the protocol provider that the state of the Remote Desktop Services service is changing.
    ///Params:
    ///    pTSServiceStateChange = A pointer to a WRDS_SERVICE_STATE structure that specifies whether the service is starting, stopping, or
    ///                            changing its drain state.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifyServiceStateChange(WTS_SERVICE_STATE* pTSServiceStateChange);
    ///Notifies the protocol provider that the Remote Desktop Services service has started for a given session.
    ///Params:
    ///    SessionId = A pointer to a WRDS_SESSION_ID structure that uniquely identifies the session.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifySessionOfServiceStart(WTS_SESSION_ID* SessionId);
    ///Notifies the protocol provider that the Remote Desktop Services service has stopped for a given session.
    ///Params:
    ///    SessionId = A pointer to a WRDS_SESSION_ID structure that uniquely identifies the session.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifySessionOfServiceStop(WTS_SESSION_ID* SessionId);
    ///Notifies the protocol provider of changes in the state of a session.
    ///Params:
    ///    SessionId = A pointer to a WRDS_SESSION_ID structure that uniquely identifies the session.
    ///    EventId = An integer that contains the event ID. The following IDs can be found in Winuser.h.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifySessionStateChange(WTS_SESSION_ID* SessionId, uint EventId);
    ///Notifies the protocol provider of changes in the settings within the Remote Desktop Services service.
    ///Params:
    ///    pWRdsSettings = A pointer to a WRDS_SETTINGS structure that contains the setting changes.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT NotifySettingsChange(WRDS_SETTINGS* pWRdsSettings);
    ///Uninitializes the protocol manager.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT Uninitialize();
}

///Exposes methods that request that the protocol start and stop listening for client connection requests. The interface
///is implemented by the protocol, and its methods are called by the Remote Desktop Services service.
@GUID("FCBC131B-C686-451D-A773-E279E230F540")
interface IWRdsProtocolListener : IUnknown
{
    ///Gets the listener setting information for client connection requests.
    ///Params:
    ///    WRdsListenerSettingLevel = The listener setting level to use.
    ///    pWRdsListenerSettings = A pointer to a WRDS_LISTENER_SETTINGS structure that contains the returned listener settings.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT GetSettings(WRDS_LISTENER_SETTING_LEVEL WRdsListenerSettingLevel, 
                        WRDS_LISTENER_SETTINGS* pWRdsListenerSettings);
    ///Notifies the protocol to start listening for client connection requests.
    ///Params:
    ///    pCallback = A pointer to an IWRdsProtocolListenerCallback object implemented by the Remote Desktop Servicesservice. The
    ///                protocol uses the <b>IWRdsProtocolListenerCallback</b> object to notify the Remote Desktop Services service
    ///                about incoming connection requests. The protocol must add a reference to this object and release it when
    ///                StopListen is called.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StartListen(IWRdsProtocolListenerCallback pCallback);
    ///Notifies the protocol to stop listening for client connection requests.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StopListen();
}

///Exposes methods that notify the Remote Desktop Services service that a client has connected. This interface is the
///callback object for the IWRdsProtocolListener interface. It is implemented by the Remote Desktop Services service and
///called by the protocol.
@GUID("3AB27E5B-4449-4DC1-B74A-91621D4FE984")
interface IWRdsProtocolListenerCallback : IUnknown
{
    ///Notifies the Remote Desktop Services service that a client connection request has been received. After this
    ///method is called, the Remote Desktop Services service begins the client connection sequence.
    ///Params:
    ///    pConnection = A pointer to an IWRdsProtocolConnection interface that represents a client connection. The Remote Desktop
    ///                  Services service adds a reference to this object and releases it when it closes the connection.
    ///    pWRdsConnectionSettings = A pointer to a WRDS_CONNECTION_SETTINGS structure that contains the connection settings for the remote
    ///                              session.
    ///    pCallback = The address of a pointer to an IWRdsProtocolConnectionCallback interface used by the protocol to notify the
    ///                Remote Desktop Services service about the status of a client connection. The Remote Desktop Services service
    ///                adds a reference to this object and the protocol must release it when the connection is closed.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT OnConnected(IWRdsProtocolConnection pConnection, WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings, 
                        IWRdsProtocolConnectionCallback* pCallback);
}

///Exposes methods called by the Remote Desktop Services service to configure a client connection. Your protocol must
///implement this interface to handle connection requests from clients. When the protocol listener receives a connection
///request from a client, it must create an <b>IWRdsProtocolConnection</b> object and pass it to the Remote Desktop
///Services service by calling the IWRdsProtocolListenerCallback::OnConnected method. In response, the service adds a
///reference to the IWRdsProtocolConnectionCallback object and returns a pointer to it. When the connection is no longer
///needed, the protocol must release the pointer. During a connection sequence, the following methods are called by the
///Remote Desktop Services service in the order listed. <ol> <li> GetLogonErrorRedirector </li> <li> AcceptConnection
///</li> <li> GetClientData </li> <li> GetClientMonitorData </li> <li> GetUserCredentials </li> <li>
///GetLicenseConnection </li> <li> AuthenticateClientToSession </li> <li> NotifySessionId </li> <li> GetInputHandles
///</li> <li> GetVideoHandle </li> <li> ConnectNotify </li> <li> NotifyCommandProcessCreated </li> <li>
///IsUserAllowedToLogon </li> <li> SessionArbitrationEnumeration </li> <li> LogonNotify </li> </ol>If the Remote Desktop
///Services service needs to reconnect after calling SessionArbitrationEnumeration, it reconnects by calling the
///following methods in the order listed: <ol> <li> DisconnectNotify (Called on the new session that was created.)</li>
///<li> NotifySessionId (Called on the existing session.)</li> <li> GetInputHandles </li> <li> GetVideoHandle </li> <li>
///ConnectNotify </li> <li> LogonNotify </li> </ol>To disconnect, the Remote Desktop Services service calls the
///following methods in the order listed: <ol> <li> PreDisconnect </li> <li> DisconnectNotify </li> <li> Close </li>
///</ol>The Remote Desktop Services service can call the following methods at any time after a connection has been
///established: <ul> <li> GetProtocolStatus </li> <li> GetLastInputTime </li> <li> SetErrorInfo </li> <li>
///CreateVirtualChannel </li> <li> QueryProperty </li> <li> GetShadowConnection </li> </ul>
@GUID("324ED94F-FDAF-4FF6-81A8-42ABE755830B")
interface IWRdsProtocolConnection : IUnknown
{
    ///Retrieves an IWRdsProtocolLogonErrorRedirector interface that specifies how the protocol should handle client
    ///logon errors. The protocol must add a reference to this object before returning, and the Remote Desktop Services
    ///service releases the reference when the connection is closed.
    ///Params:
    ///    ppLogonErrorRedir = Address of a pointer to an IWRdsProtocolLogonErrorRedirector interface.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. If you
    ///    do not implement this function, return <b>E_NOTIMPL</b> to indicate that logon errors should not be
    ///    redirected.
    ///    
    HRESULT GetLogonErrorRedirector(IWRdsProtocolLogonErrorRedirector* ppLogonErrorRedir);
    ///Directs the protocol to continue with the connection request.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. Upon
    ///    receiving an error, the Remote Desktop Services service will drop the connection.
    ///    
    HRESULT AcceptConnection();
    ///Requests client settings from the protocol.
    ///Params:
    ///    pClientData = A pointer to a WRDS_CLIENT_DATA structure that contains the client settings.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. Upon
    ///    receiving an error, the Remote Desktop Services service will drop the connection.
    ///    
    HRESULT GetClientData(WTS_CLIENT_DATA* pClientData);
    ///Retrieves the number of monitors and the primary monitor number on the client.
    ///Params:
    ///    pNumMonitors = A pointer to a <b>UINT</b> variable to receive the number of monitors counted.
    ///    pPrimaryMonitor = A pointer to a <b>UINT</b> variable to receive the number of the primary monitor on the client.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetClientMonitorData(uint* pNumMonitors, uint* pPrimaryMonitor);
    ///Returns user credentials.
    ///Params:
    ///    pUserCreds = A pointer to a WRDS_USER_CREDENTIAL structure that contains the credentials. Currently, only the user name,
    ///                 password, and domain are supported. The user name and password are plaintext.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetUserCredentials(WTS_USER_CREDENTIAL* pUserCreds);
    ///Retrieves an IWRdsProtocolLicenseConnection object that is used to begin the client licensing process. The
    ///protocol must add a reference to this object before returning. When the Remote Desktop Services service has
    ///finished the licensing process, it will release the reference.
    ///Params:
    ///    ppLicenseConnection = The address of a pointer to an IWRdsProtocolLicenseConnection interface the receives the license connection
    ///                          object.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. Upon
    ///    receiving an error, the Remote Desktop Services service will drop the connection.
    ///    
    HRESULT GetLicenseConnection(IWRdsProtocolLicenseConnection* ppLicenseConnection);
    ///Specifies a session that the connection should be reconnected to.
    ///Params:
    ///    SessionId = A pointer to a WRDS_SESSION_ID structure that uniquely identifies the session.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. Upon
    ///    receiving an error, the Remote Desktop Services service continues the connection sequence.
    ///    
    HRESULT AuthenticateClientToSession(WTS_SESSION_ID* SessionId);
    ///Sends the identifier of the new session to the protocol.
    ///Params:
    ///    SessionId = A pointer to a WRDS_SESSION_ID structure that uniquely identifies the session.
    ///    SessionHandle = The session handle.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifySessionId(WTS_SESSION_ID* SessionId, size_t SessionHandle);
    ///Obtains the handles to input/output devices for the protocol.
    ///Params:
    ///    pKeyboardHandle = A pointer to a handle that receives the handle of the keyboard device. This is a handle to an I8042prt
    ///                      keyboard driver.
    ///    pMouseHandle = A pointer to a handle that receives the handle of the mouse device. This is a handle to a Mouclass driver.
    ///    pBeepHandle = A pointer to a handle that receives the handle of the beep or sound device. This handle is not used and must
    ///                  be set to <b>NULL</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetInputHandles(size_t* pKeyboardHandle, size_t* pMouseHandle, size_t* pBeepHandle);
    ///Obtains the handle of the video device for the protocol.
    ///Params:
    ///    pVideoHandle = A pointer to a handle that receives the handle of the video device. If the protocol object is using the
    ///                   IWRdsRemoteFXGraphicsConnection interface, this method should set the contents of <i>pVideoHandle</i> to
    ///                   <b>NULL</b> and return <b>E_NOTIMPL</b>. If the protocol is not using the IWRdsRemoteFXGraphicsConnection
    ///                   interface, this method should return a handle to the video miniport driver for the remote session associated
    ///                   with the protocol.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetVideoHandle(size_t* pVideoHandle);
    ///Signals the protocol that the session has been initialized.
    ///Params:
    ///    SessionId = The session identifier.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ConnectNotify(uint SessionId);
    ///Determines from the protocol whether a user is allowed to log on to a session.
    ///Params:
    ///    SessionId = The session identifier.
    ///    UserToken = A handle that represents the user token.
    ///    pDomainName = A pointer to a null-terminated string that contains the user's domain name.
    ///    pUserName = A pointer to a null-terminated string that contains the user name.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsUserAllowedToLogon(uint SessionId, size_t UserToken, ushort* pDomainName, ushort* pUserName);
    ///Called after arbitration to allow the protocol to specify the sessions to be reconnected. The protocol extension
    ///should return <b>E_NOTIMPL</b> to use the default session arbitration.
    ///Params:
    ///    hUserToken = A handle that represents the user token.
    ///    bSingleSessionPerUserEnabled = Specifies whether a user can only be associated with a single session.
    ///    pSessionIdArray = A pointer to a <b>ULONG</b> array that receives the disconnected session identifiers for the user. If this
    ///                      parameter is <b>NULL</b>, the Remote Desktop Services service is requesting the number of elements to
    ///                      allocate this array. Place the number of identifiers in the value pointed to by
    ///                      <i>pdwSessionIdentifierCount</i>.
    ///    pdwSessionIdentifierCount = A pointer to a <b>ULONG</b> value that receives the number of elements in the <i>pSessionIdArray</i> array.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionArbitrationEnumeration(size_t hUserToken, BOOL bSingleSessionPerUserEnabled, 
                                          char* pSessionIdArray, uint* pdwSessionIdentifierCount);
    ///Called when the user has logged on to the session.
    ///Params:
    ///    hClientToken = A handle that represents the user token.
    ///    wszUserName = A pointer to a null-terminated string that contains the user name.
    ///    wszDomainName = A pointer to a null-terminated string that contains the user's domain name.
    ///    SessionId = A pointer to a WRDS_SESSION_ID structure that uniquely identifies the session.
    ///    pWRdsConnectionSettings = A pointer to a WRDS_CONNECTION_SETTINGS structure that contains connection settings for the session.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LogonNotify(size_t hClientToken, ushort* wszUserName, ushort* wszDomainName, WTS_SESSION_ID* SessionId, 
                        WRDS_CONNECTION_SETTINGS* pWRdsConnectionSettings);
    ///Notifies the protocol that the session is about to be disconnected.
    ///Params:
    ///    DisconnectReason = A numeric value that indicates the reason for the disconnection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PreDisconnect(uint DisconnectReason);
    ///Notifies the protocol that the session has been disconnected.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DisconnectNotify();
    ///Closes a connection after the session is disconnected.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///Retrieves information about the protocol status.
    ///Params:
    ///    pProtocolStatus = A pointer to a WRDS_PROTOCOL_STATUS structure that receives counter, signal, and cache information for the
    ///                      protocol.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetProtocolStatus(WTS_PROTOCOL_STATUS* pProtocolStatus);
    ///Retrieves the last time the protocol received user input.
    ///Params:
    ///    pLastInputTime = A pointer to a <b>ULONG64</b> value that receives the number of milliseconds that has elapsed since the
    ///                     protocol last received input.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLastInputTime(ulong* pLastInputTime);
    ///Sets error information in the protocol.
    ///Params:
    ///    ulError = The error code.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetErrorInfo(uint ulError);
    ///Requests that the protocol create a virtual channel.
    ///Params:
    ///    szEndpointName = A null-terminated string that contains the endpoint data that uniquely identifies the connection.
    ///    bStatic = Specifies whether the virtual channel is static or dynamic.
    ///    RequestedPriority = Specifies the requested priority for the channel.
    ///    phChannel = A pointer to a <b>ULONG</b> value that receives the handle for the channel created.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateVirtualChannel(byte* szEndpointName, BOOL bStatic, uint RequestedPriority, size_t* phChannel);
    ///Retrieves a property value from the protocol. This method can be used by other Windows modules to request data
    ///from or send data to the protocol.
    ///Params:
    ///    QueryType = A <b>GUID</b> that specifies the requested property. This can be one of the following values.
    ///    ulNumEntriesIn = The number of entries in the <i>pPropertyEntriesIn</i> array.
    ///    ulNumEntriesOut = The number of entries in the <i>pPropertyEntriesOut</i> array.
    ///    pPropertyEntriesIn = An array of pointers to WRDS_PROPERTY_VALUE structures that can be used to help find the requested property
    ///                         information.
    ///    pPropertyEntriesOut = An array of pointers to WRDS_PROPERTY_VALUE structures that receive the requested property values.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT QueryProperty(GUID QueryType, uint ulNumEntriesIn, uint ulNumEntriesOut, char* pPropertyEntriesIn, 
                          char* pPropertyEntriesOut);
    ///Retrieves a reference to the shadow connection object from the protocol.
    ///Params:
    ///    ppShadowConnection = The address of IWRdsProtocolShadowConnection interface pointer that receives the reference to the shadow
    ///                         connection object. This method must add a reference to the object before returning. When the Remote Desktop
    ///                         Services service no longer needs the object, it will release it.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetShadowConnection(IWRdsProtocolShadowConnection* ppShadowConnection);
    ///Notifies the protocol that the Winlogon.exe process has been created and initialized.
    ///Params:
    ///    SessionId = The session identifier.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT NotifyCommandProcessCreated(uint SessionId);
}

///Exposes methods that provide information about the status of a client connection and that perform actions for the
///client. This interface is implemented by the Remote Desktop Services service and called by the protocol. An instance
///of this interface is associated with a specific instance of the IWRdsProtocolConnection interface. When the following
///documentation refers to a connection, it is therefore referring to the specific connection for which the
///<b>IWRdsProtocolConnection</b> object was created.
@GUID("F1D70332-D070-4EF1-A088-78313536C2D6")
interface IWRdsProtocolConnectionCallback : IUnknown
{
    ///Requests that the Remote Desktop Services service continue the connection process for that client.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT OnReady();
    ///Informs the Remote Desktop Services service that the client connection has been lost.
    ///Params:
    ///    Reason = This parameter is not used.
    ///    Source = This parameter is not used.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT BrokenConnection(uint Reason, uint Source);
    ///Requests that the Remote Desktop Services service stop updating the client screen.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StopScreenUpdates();
    ///Requests that the Remote Desktop Services service redraw the client window.
    ///Params:
    ///    rect = A WRDS_SMALL_RECT structure that contains the x and y coordinates of the screen to redraw. A value of
    ///           <b>NULL</b> requests that the entire screen be redrawn.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedrawWindow(WTS_SMALL_RECT* rect);
    ///Retrieves the connection identifier.
    ///Params:
    ///    pConnectionId = The address of a <b>ULONG</b> variable that receives the connection identifier.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetConnectionId(uint* pConnectionId);
}

///Exposes methods that notify the protocol provider about the status of session shadowing. The
///<b>IWRdsProtocolShadowConnection</b> interface can also be used to exchange information between the shadow client and
///the shadow target. This interface is implemented by the protocol provider, and its methods are called by the Remote
///Desktop Services service.
@GUID("9AE85CE6-CADE-4548-8FEB-99016597F60A")
interface IWRdsProtocolShadowConnection : IUnknown
{
    ///Notifies the protocol that shadowing has started.
    ///Params:
    ///    pTargetServerName = A pointer to a string that contains the name of the shadowing server.
    ///    TargetSessionId = An integer that specifies the ID of the target session to shadow.
    ///    HotKeyVk = The virtual key code of the key that must be pressed to stop shadowing. This key is used in combination with
    ///               the <i>HotkeyModifiers</i> parameter.
    ///    HotkeyModifiers = The virtual modifier that specifies the modifier key to press to stop shadowing. Modifier keys include the
    ///                      Shift, Alt, and Ctrl keys. The modifier key is used in combination with the key signified by the
    ///                      <i>HotKeyVk</i> parameter.
    ///    pShadowCallback = A pointer to an IWRdsProtocolShadowCallback interface that the protocol can use to call back into the Remote
    ///                      Desktop Services service.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT Start(ushort* pTargetServerName, uint TargetSessionId, ubyte HotKeyVk, ushort HotkeyModifiers, 
                  IWRdsProtocolShadowCallback pShadowCallback);
    ///Notifies the protocol that shadowing has stopped.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    The Remote Desktop Services service drops the connection if an error is returned.
    ///    
    HRESULT Stop();
    ///Requests that the protocol start the target side of a shadow connection.
    ///Params:
    ///    pParam1 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param1Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam1</i> parameter.
    ///    pParam2 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param2Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam2</i> parameter.
    ///    pParam3 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param3Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam3</i> parameter.
    ///    pParam4 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param4Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam4</i> parameter.
    ///    pClientName = A pointer to a string that contains the name of the shadow client.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT DoTarget(char* pParam1, uint Param1Size, char* pParam2, uint Param2Size, char* pParam3, 
                     uint Param3Size, char* pParam4, uint Param4Size, ushort* pClientName);
}

///Exposes methods called by the protocol to notify the Remote Desktop Services service to start or stop the target side
///of a shadow. This interface is the callback interface for the IWRdsProtocolShadowConnection interface. It is
///implemented by the Remote Desktop Services service and called by the protocol provider.
@GUID("E0667CE0-0372-40D6-ADB2-A0F3322674D6")
interface IWRdsProtocolShadowCallback : IUnknown
{
    ///Instructs the Remote Desktop Services service to stop shadowing a target. This method is called in response to a
    ///call of DoTarget by the shadow client.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT StopShadow();
    ///Instructs the Remote Desktop Services service to begin the target side of the shadow and passes any information
    ///that must be exchanged between the client and the target.
    ///Params:
    ///    pTargetServerName = A pointer to a string that contains the name of the shadow target server.
    ///    TargetSessionId = An integer that specifies the ID of the target session to shadow.
    ///    pParam1 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param1Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam1</i> parameter.
    ///    pParam2 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param2Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam2</i> parameter.
    ///    pParam3 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param3Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam3</i> parameter.
    ///    pParam4 = A pointer to a buffer that contains an arbitrary parameter.
    ///    Param4Size = An integer that contains the size, in bytes, of the value referenced by the <i>pParam4</i> parameter.
    ///    pClientName = A pointer to a string that contains the name of the shadow client.
    ///Returns:
    ///    If the function succeeds, the function returns <b>S_OK</b>. If the function fails, it returns an
    ///    <b>HRESULT</b> value that indicates the error. Possible values include, but are not limited to, those in the
    ///    following list. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT InvokeTargetShadow(ushort* pTargetServerName, uint TargetSessionId, char* pParam1, uint Param1Size, 
                               char* pParam2, uint Param2Size, char* pParam3, uint Param3Size, char* pParam4, 
                               uint Param4Size, ushort* pClientName);
}

///Exposes methods used by the Remote Desktop Services service to perform the licensing handshake during a connection
///sequence. This interface is implemented by the protocol, and its methods are called by the Remote Desktop Services
///service.
@GUID("1D6A145F-D095-4424-957A-407FAE822D84")
interface IWRdsProtocolLicenseConnection : IUnknown
{
    ///Requests license capabilities from the client.
    ///Params:
    ///    ppLicenseCapabilities = A pointer to a WRDS_LICENSE_CAPABILITIES structure that contains information about the client license
    ///                            capabilities.
    ///    pcbLicenseCapabilities = A pointer to an integer that contains the size of the structure specified by the
    ///                             <i>ppLicensingCapabilities</i> parameter.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RequestLicensingCapabilities(WTS_LICENSE_CAPABILITIES* ppLicenseCapabilities, 
                                         uint* pcbLicenseCapabilities);
    ///Sends a license to the client.
    ///Params:
    ///    pClientLicense = A pointer to a byte array that contains the license.
    ///    cbClientLicense = An integer that contains the size, in bytes, of the license.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    The remote connection manager logs any errors that you return.
    ///    
    HRESULT SendClientLicense(char* pClientLicense, uint cbClientLicense);
    ///Requests a license from the client.
    ///Params:
    ///    Reserve1 = A pointer to a byte array that contains additional data that can be acted upon by the client.
    ///    Reserve2 = An integer that contains the size, in bytes, of the data specified by the <i>Reserve1</i> parameter.
    ///    ppClientLicense = A pointer to a byte array that contains the license request.
    ///    pcbClientLicense = An integer that contains the size, in bytes, of the request specified by the <i>ppClientLicense</i>
    ///                       parameter.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RequestClientLicense(char* Reserve1, uint Reserve2, char* ppClientLicense, uint* pcbClientLicense);
    ///Notifies the protocol whether the licensing process completed successfully.
    ///Params:
    ///    ulComplete = An integer that specifies whether the licensing process ended successfully. A value of 1 means success. All
    ///                 other values indicate failure.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT ProtocolComplete(uint ulComplete);
}

///Exposes methods called by the Remote Desktop Services service to update logon status and determine how to direct
///logon error messages. This interface is implemented by the protocol.
@GUID("519FE83B-142A-4120-A3D5-A405D315281A")
interface IWRdsProtocolLogonErrorRedirector : IUnknown
{
    ///Notifies the protocol that the logon user interface is ready to begin painting.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT OnBeginPainting();
    ///Queries the protocol regarding how to redirect the client logon status update.
    ///Params:
    ///    pszMessage = A pointer to a string that contains the logon status message.
    ///    pResponse = A pointer to a WRDS_LOGON_ERROR_REDIRECTOR_RESPONSE enumeration that contains the response.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedirectStatus(const(wchar)* pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    ///Queries the protocol regarding how to redirect the logon message.
    ///Params:
    ///    pszCaption = A pointer to a string that contains the message box caption.
    ///    pszMessage = A pointer to a string that contains the logon message.
    ///    uType = An integer that contains the message box type. For more information, see the MessageBox function.
    ///    pResponse = A pointer to a WRDS_LOGON_ERROR_REDIRECTOR_RESPONSE enumeration that specifies to the Remote Desktop Services
    ///                service the preferred response for redirecting the logon message.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedirectMessage(const(wchar)* pszCaption, const(wchar)* pszMessage, uint uType, 
                            WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
    ///Queries the protocol for the action to take in response to a logon error. The RedirectStatus method is called by
    ///the Remote Desktop Services service to query the protocol for the action to take in response to a logon error.
    ///Params:
    ///    ntsStatus = An integer that contains information about the logon failure. This can be one of the following values.
    ///    ntsSubstatus = An integer that contains information about why a logon attempt failed. This value is set only if the account
    ///                   information of the user is valid and the logon is rejected. This can contain one of the following values.
    ///    pszCaption = A pointer to a string that contains the message box caption.
    ///    pszMessage = A pointer to a string that contains the message.
    ///    uType = An integer that contains the message box type. For more information, see the MessageBox function.
    ///    pResponse = A pointer to a WRDS_LOGON_ERROR_REDIRECTOR_RESPONSE enumeration that specifies to the Remote Desktop Services
    ///                service the preferred response to the logon error.
    ///Returns:
    ///    When you are implementing this method, return <b>S_OK</b> if the function succeeds. If it fails, return an
    ///    <b>HRESULT</b> value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RedirectLogonError(int ntsStatus, int ntsSubstatus, const(wchar)* pszCaption, const(wchar)* pszMessage, 
                               uint uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE* pResponse);
}

///This interface allows a custom IDD driver to be loaded in a remote session.
@GUID("1382DF4D-A289-43D1-A184-144726F9AF90")
interface IWRdsWddmIddProps : IUnknown
{
    ///Protocol stack uses this method to return hardware Id of WDDM ID driver.
    ///Params:
    ///    pDisplayDriverHardwareId = Pointer to an array that contains the hardware ID.
    ///    Count = Size in elements of the hardware ID string.
    ///Returns:
    ///    S_OK or error code
    ///    
    HRESULT GetHardwareId(char* pDisplayDriverHardwareId, uint Count);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] Termsrv uses this method to return a handle of the loaded WDDM ID driver to the
    ///protocol stack. From this point the stack owns the handle and needs to call CloseHandle() after communication
    ///with the driver is no longer needed.
    ///Params:
    ///    SessionId = ID of the session that the driver is loaded for.
    ///    DriverHandle = Opened handle of the WDDM ID driver.
    ///Returns:
    ///    S_OK or error code
    ///    
    HRESULT OnDriverLoad(uint SessionId, size_t DriverHandle);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] Termsrv uses this method to tell the protocol stack that PnP unloaded the WDDM ID
    ///driver.
    ///Params:
    ///    SessionId = ID of a session driver is unloaded from.
    ///Returns:
    ///    Returns S_OK or error code
    ///    
    HRESULT OnDriverUnload(uint SessionId);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] Termsrv uses this method to tell protocol stack which mode it is operating.
    ///Params:
    ///    Enabled = Boolean flag that instructs protocol stack that termsrv supports WDDM IDD mode.
    ///Returns:
    ///    S_OK or error code.
    ///    
    HRESULT EnableWddmIdd(BOOL Enabled);
}

@GUID("83FCF5D3-F6F4-EA94-9CD2-32F280E1E510")
interface IWRdsProtocolConnectionSettings : IUnknown
{
    HRESULT SetConnectionSetting(GUID PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesIn);
    HRESULT GetConnectionSetting(GUID PropertyID, WTS_PROPERTY_VALUE* pPropertyEntriesOut);
}

///Provides the methods needed to configure the connection settings for the Remote Desktop Protocol (RDP) app container
///client control. Use the IRemoteDesktopClient Settings property to obtain a pointer to this interface.
@GUID("48A0F2A7-2713-431F-BBAC-6F4558E7D64D")
interface IRemoteDesktopClientSettings : IDispatch
{
    ///Stores the specified contents in the RDP file.
    ///Params:
    ///    rdpFileContents = Specifies the entire contents of the RDP file.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ApplySettings(BSTR rdpFileContents);
    ///Retrieves the entire RDP file as a string.
    ///Params:
    ///    rdpFileContents = The entire contents of the RDP file.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RetrieveSettings(BSTR* rdpFileContents);
    ///Retrieves a single named RDP property value. If the specified property has not been set, a default value is
    ///retrieved.
    ///Params:
    ///    propertyName = 
    ///    value = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRdpProperty(BSTR propertyName, VARIANT* value);
    ///Sets the value of a single named RDP property.
    ///Params:
    ///    propertyName = A string that specifies the name of the property. <div class="alert"><b>Note</b> These string values are not
    ///                   case-sensitive.</div> <div> </div> The possible values are.
    ///    value = The new property value.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetRdpProperty(BSTR propertyName, VARIANT value);
}

///Provides the methods used to interact with the Remote Desktop Protocol (RDP) app container client control.
@GUID("7D54BC4E-1028-45D4-8B0A-B9B6BFFBA176")
interface IRemoteDesktopClientActions : IDispatch
{
    ///Suspends screen updates being sent to the client. Use the ResumeScreenUpdates method to resume screen updates.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SuspendScreenUpdates();
    ///Resumes screen updates being sent to the client. Use the SuspendScreenUpdates method to suspend screen updates.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResumeScreenUpdates();
    ///Causes an action to be performed in the remote session.
    ///Params:
    ///    remoteAction = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ExecuteRemoteAction(RemoteActionType remoteAction);
    ///Causes a snapshot of the Remote Desktop Protocol (RDP) app container client's in-session desktop to be taken.
    ///Params:
    ///    snapshotEncoding = Specifies the encoding type for the snapshot.
    ///    snapshotFormat = Specifies the data format type for the snapshot
    ///    snapshotWidth = The width, in pixels, of the snapshot.
    ///    snapshotHeight = The height, in pixels, of the snapshot.
    ///    snapshotData = On return points to the snapshot.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSnapshot(SnapshotEncodingType snapshotEncoding, SnapshotFormatType snapshotFormat, 
                        uint snapshotWidth, uint snapshotHeight, BSTR* snapshotData);
}

///Provides the properties needed to control the touch pointer feature of the Remote Desktop Protocol (RDP) app
///container client control. The touch pointer feature allows the Remote Desktop Protocol (RDP) app container client
///control to translate touch screen actions on the client into equivalent mouse actions in the remote session. This
///feature is useful when the remote session is running an operating system or application that is not optimized for
///touch screen. When the Enabled property is set, the RDP app container client control will interpret certain touch
///gestures and translate them into mouse events in the remote session. These translations make it easier for the user
///to simulate certain mouse actions that do not readily translate to touch screen gestures, such as right-click and
///drag. The following is a list of client touch-screen gestures and their corresponding remote session mouse events.
///<table> <tr> <th>Client touch-screen gesture</th> <th>Remote session mouse event</th> </tr> <tr> <td> Tap </td> <td>
///Left button click </td> </tr> <tr> <td> Drag </td> <td> Cursor move </td> </tr> <tr> <td> Press and hold with one
///finger, then tap with another finger to the right of the first finger </td> <td> Right button click </td> </tr> <tr>
///<td> Press and hold with one finger, then press and hold with another finger to the left of the first finger </td>
///<td> Left button click and hold </td> </tr> <tr> <td> Press and hold with one finger, then press and hold with
///another finger to the right of the first finger </td> <td> Right button click and hold </td> </tr> </table>
@GUID("260EC22D-8CBC-44B5-9E88-2A37F6C93AE9")
interface IRemoteDesktopClientTouchPointer : IDispatch
{
    ///Whether the touch pointer feature is enabled on the RDP app container client control. This property is
    ///read/write.
    HRESULT put_Enabled(short enabled);
    ///Whether the touch pointer feature is enabled on the RDP app container client control. This property is
    ///read/write.
    HRESULT get_Enabled(short* enabled);
    ///Whether touch pointer event notifications are enabled for the RDP app container client control. If this property
    ///is enabled, the OnTouchPointerCursorMoved method will handle events when the touch pointer cursor is moved. This
    ///property is read/write.
    HRESULT put_EventsEnabled(short eventsEnabled);
    ///Whether touch pointer event notifications are enabled for the RDP app container client control. If this property
    ///is enabled, the OnTouchPointerCursorMoved method will handle events when the touch pointer cursor is moved. This
    ///property is read/write.
    HRESULT get_EventsEnabled(short* eventsEnabled);
    HRESULT put_PointerSpeed(uint pointerSpeed);
    ///How fast the touch pointer cursor will move on the virtual desktop relative to the speed of the gesture on the
    ///client. This property is read-only.
    HRESULT get_PointerSpeed(uint* pointerSpeed);
}

///Provides methods and properties used to configure and use the Remote Desktop Protocol (RDP) app container client
///control.
@GUID("57D25668-625A-4905-BE4E-304CAA13F89C")
interface IRemoteDesktopClient : IDispatch
{
    ///Initiates a connection by using the properties currently set on the Remote Desktop Protocol (RDP) app container
    ///client control.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Connect();
    ///Disconnects the active connection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Disconnect();
    ///Initiates an automatic reconnection of the Remote Desktop Protocol (RDP) app container client control to fit the
    ///session to the new width and height.
    ///Params:
    ///    width = 
    ///    height = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reconnect(uint width, uint height);
    ///Retrieves the settings object for the Remote Desktop Protocol (RDP) app container client. This property is
    ///read-only.
    HRESULT get_Settings(IRemoteDesktopClientSettings* settings);
    ///Retrieves the actions object for the Remote Desktop Protocol (RDP) app container client. This property is
    ///read-only.
    HRESULT get_Actions(IRemoteDesktopClientActions* actions);
    ///Contains the RemoteDesktopClientTouchPointer object for the Remote Desktop Protocol (RDP) app container client.
    ///This property is read-only.
    HRESULT get_TouchPointer(IRemoteDesktopClientTouchPointer* touchPointer);
    ///Deletes saved credentials for the specified remote computer.
    ///Params:
    ///    serverName = The name of the remote computer. This can be a DNS name or an IP address.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteSavedCredentials(BSTR serverName);
    ///Updates the width and height settings for the Remote Desktop Protocol (RDP) app container client control.
    ///Params:
    ///    width = 
    ///    height = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UpdateSessionDisplaySettings(uint width, uint height);
    ///Attaches an event handler to an event.
    ///Params:
    ///    eventName = 
    ///    callback = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT attachEvent(BSTR eventName, IDispatch callback);
    ///Detaches an event handler from an event.
    ///Params:
    ///    eventName = 
    ///    callback = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT detachEvent(BSTR eventName, IDispatch callback);
}


// GUIDs

const GUID CLSID_ADsTSUserEx        = GUIDOF!ADsTSUserEx;
const GUID CLSID_TSUserExInterfaces = GUIDOF!TSUserExInterfaces;
const GUID CLSID_Workspace          = GUIDOF!Workspace;

const GUID IID_IADsTSUserEx                      = GUIDOF!IADsTSUserEx;
const GUID IID_IAudioDeviceEndpoint              = GUIDOF!IAudioDeviceEndpoint;
const GUID IID_IAudioEndpoint                    = GUIDOF!IAudioEndpoint;
const GUID IID_IAudioEndpointControl             = GUIDOF!IAudioEndpointControl;
const GUID IID_IAudioEndpointRT                  = GUIDOF!IAudioEndpointRT;
const GUID IID_IAudioInputEndpointRT             = GUIDOF!IAudioInputEndpointRT;
const GUID IID_IAudioOutputEndpointRT            = GUIDOF!IAudioOutputEndpointRT;
const GUID IID_IRemoteDesktopClient              = GUIDOF!IRemoteDesktopClient;
const GUID IID_IRemoteDesktopClientActions       = GUIDOF!IRemoteDesktopClientActions;
const GUID IID_IRemoteDesktopClientSettings      = GUIDOF!IRemoteDesktopClientSettings;
const GUID IID_IRemoteDesktopClientTouchPointer  = GUIDOF!IRemoteDesktopClientTouchPointer;
const GUID IID_ITSGAccountingEngine              = GUIDOF!ITSGAccountingEngine;
const GUID IID_ITSGAuthenticateUserSink          = GUIDOF!ITSGAuthenticateUserSink;
const GUID IID_ITSGAuthenticationEngine          = GUIDOF!ITSGAuthenticationEngine;
const GUID IID_ITSGAuthorizeConnectionSink       = GUIDOF!ITSGAuthorizeConnectionSink;
const GUID IID_ITSGAuthorizeResourceSink         = GUIDOF!ITSGAuthorizeResourceSink;
const GUID IID_ITSGPolicyEngine                  = GUIDOF!ITSGPolicyEngine;
const GUID IID_ITsSbBaseNotifySink               = GUIDOF!ITsSbBaseNotifySink;
const GUID IID_ITsSbClientConnection             = GUIDOF!ITsSbClientConnection;
const GUID IID_ITsSbClientConnectionPropertySet  = GUIDOF!ITsSbClientConnectionPropertySet;
const GUID IID_ITsSbEnvironment                  = GUIDOF!ITsSbEnvironment;
const GUID IID_ITsSbEnvironmentPropertySet       = GUIDOF!ITsSbEnvironmentPropertySet;
const GUID IID_ITsSbFilterPluginStore            = GUIDOF!ITsSbFilterPluginStore;
const GUID IID_ITsSbGenericNotifySink            = GUIDOF!ITsSbGenericNotifySink;
const GUID IID_ITsSbGlobalStore                  = GUIDOF!ITsSbGlobalStore;
const GUID IID_ITsSbLoadBalanceResult            = GUIDOF!ITsSbLoadBalanceResult;
const GUID IID_ITsSbLoadBalancing                = GUIDOF!ITsSbLoadBalancing;
const GUID IID_ITsSbLoadBalancingNotifySink      = GUIDOF!ITsSbLoadBalancingNotifySink;
const GUID IID_ITsSbOrchestration                = GUIDOF!ITsSbOrchestration;
const GUID IID_ITsSbOrchestrationNotifySink      = GUIDOF!ITsSbOrchestrationNotifySink;
const GUID IID_ITsSbPlacement                    = GUIDOF!ITsSbPlacement;
const GUID IID_ITsSbPlacementNotifySink          = GUIDOF!ITsSbPlacementNotifySink;
const GUID IID_ITsSbPlugin                       = GUIDOF!ITsSbPlugin;
const GUID IID_ITsSbPluginNotifySink             = GUIDOF!ITsSbPluginNotifySink;
const GUID IID_ITsSbPluginPropertySet            = GUIDOF!ITsSbPluginPropertySet;
const GUID IID_ITsSbPropertySet                  = GUIDOF!ITsSbPropertySet;
const GUID IID_ITsSbProvider                     = GUIDOF!ITsSbProvider;
const GUID IID_ITsSbProvisioning                 = GUIDOF!ITsSbProvisioning;
const GUID IID_ITsSbProvisioningPluginNotifySink = GUIDOF!ITsSbProvisioningPluginNotifySink;
const GUID IID_ITsSbResourceNotification         = GUIDOF!ITsSbResourceNotification;
const GUID IID_ITsSbResourceNotificationEx       = GUIDOF!ITsSbResourceNotificationEx;
const GUID IID_ITsSbResourcePlugin               = GUIDOF!ITsSbResourcePlugin;
const GUID IID_ITsSbResourcePluginStore          = GUIDOF!ITsSbResourcePluginStore;
const GUID IID_ITsSbServiceNotification          = GUIDOF!ITsSbServiceNotification;
const GUID IID_ITsSbSession                      = GUIDOF!ITsSbSession;
const GUID IID_ITsSbTarget                       = GUIDOF!ITsSbTarget;
const GUID IID_ITsSbTargetPropertySet            = GUIDOF!ITsSbTargetPropertySet;
const GUID IID_ITsSbTaskInfo                     = GUIDOF!ITsSbTaskInfo;
const GUID IID_ITsSbTaskPlugin                   = GUIDOF!ITsSbTaskPlugin;
const GUID IID_ITsSbTaskPluginNotifySink         = GUIDOF!ITsSbTaskPluginNotifySink;
const GUID IID_IWRdsGraphicsChannel              = GUIDOF!IWRdsGraphicsChannel;
const GUID IID_IWRdsGraphicsChannelEvents        = GUIDOF!IWRdsGraphicsChannelEvents;
const GUID IID_IWRdsGraphicsChannelManager       = GUIDOF!IWRdsGraphicsChannelManager;
const GUID IID_IWRdsProtocolConnection           = GUIDOF!IWRdsProtocolConnection;
const GUID IID_IWRdsProtocolConnectionCallback   = GUIDOF!IWRdsProtocolConnectionCallback;
const GUID IID_IWRdsProtocolConnectionSettings   = GUIDOF!IWRdsProtocolConnectionSettings;
const GUID IID_IWRdsProtocolLicenseConnection    = GUIDOF!IWRdsProtocolLicenseConnection;
const GUID IID_IWRdsProtocolListener             = GUIDOF!IWRdsProtocolListener;
const GUID IID_IWRdsProtocolListenerCallback     = GUIDOF!IWRdsProtocolListenerCallback;
const GUID IID_IWRdsProtocolLogonErrorRedirector = GUIDOF!IWRdsProtocolLogonErrorRedirector;
const GUID IID_IWRdsProtocolManager              = GUIDOF!IWRdsProtocolManager;
const GUID IID_IWRdsProtocolSettings             = GUIDOF!IWRdsProtocolSettings;
const GUID IID_IWRdsProtocolShadowCallback       = GUIDOF!IWRdsProtocolShadowCallback;
const GUID IID_IWRdsProtocolShadowConnection     = GUIDOF!IWRdsProtocolShadowConnection;
const GUID IID_IWRdsRemoteFXGraphicsConnection   = GUIDOF!IWRdsRemoteFXGraphicsConnection;
const GUID IID_IWRdsWddmIddProps                 = GUIDOF!IWRdsWddmIddProps;
const GUID IID_IWTSBitmapRenderService           = GUIDOF!IWTSBitmapRenderService;
const GUID IID_IWTSBitmapRenderer                = GUIDOF!IWTSBitmapRenderer;
const GUID IID_IWTSBitmapRendererCallback        = GUIDOF!IWTSBitmapRendererCallback;
const GUID IID_IWTSListener                      = GUIDOF!IWTSListener;
const GUID IID_IWTSListenerCallback              = GUIDOF!IWTSListenerCallback;
const GUID IID_IWTSPlugin                        = GUIDOF!IWTSPlugin;
const GUID IID_IWTSPluginServiceProvider         = GUIDOF!IWTSPluginServiceProvider;
const GUID IID_IWTSProtocolConnection            = GUIDOF!IWTSProtocolConnection;
const GUID IID_IWTSProtocolConnectionCallback    = GUIDOF!IWTSProtocolConnectionCallback;
const GUID IID_IWTSProtocolLicenseConnection     = GUIDOF!IWTSProtocolLicenseConnection;
const GUID IID_IWTSProtocolListener              = GUIDOF!IWTSProtocolListener;
const GUID IID_IWTSProtocolListenerCallback      = GUIDOF!IWTSProtocolListenerCallback;
const GUID IID_IWTSProtocolLogonErrorRedirector  = GUIDOF!IWTSProtocolLogonErrorRedirector;
const GUID IID_IWTSProtocolManager               = GUIDOF!IWTSProtocolManager;
const GUID IID_IWTSProtocolShadowCallback        = GUIDOF!IWTSProtocolShadowCallback;
const GUID IID_IWTSProtocolShadowConnection      = GUIDOF!IWTSProtocolShadowConnection;
const GUID IID_IWTSSBPlugin                      = GUIDOF!IWTSSBPlugin;
const GUID IID_IWTSVirtualChannel                = GUIDOF!IWTSVirtualChannel;
const GUID IID_IWTSVirtualChannelCallback        = GUIDOF!IWTSVirtualChannelCallback;
const GUID IID_IWTSVirtualChannelManager         = GUIDOF!IWTSVirtualChannelManager;
const GUID IID_IWorkspace                        = GUIDOF!IWorkspace;
const GUID IID_IWorkspace2                       = GUIDOF!IWorkspace2;
const GUID IID_IWorkspace3                       = GUIDOF!IWorkspace3;
const GUID IID_IWorkspaceClientExt               = GUIDOF!IWorkspaceClientExt;
const GUID IID_IWorkspaceRegistration            = GUIDOF!IWorkspaceRegistration;
const GUID IID_IWorkspaceRegistration2           = GUIDOF!IWorkspaceRegistration2;
const GUID IID_IWorkspaceReportMessage           = GUIDOF!IWorkspaceReportMessage;
const GUID IID_IWorkspaceResTypeRegistry         = GUIDOF!IWorkspaceResTypeRegistry;
const GUID IID_IWorkspaceScriptable              = GUIDOF!IWorkspaceScriptable;
const GUID IID_IWorkspaceScriptable2             = GUIDOF!IWorkspaceScriptable2;
const GUID IID_IWorkspaceScriptable3             = GUIDOF!IWorkspaceScriptable3;
const GUID IID_ItsPubPlugin                      = GUIDOF!ItsPubPlugin;
const GUID IID_ItsPubPlugin2                     = GUIDOF!ItsPubPlugin2;
const GUID IID__ITSWkspEvents                    = GUIDOF!_ITSWkspEvents;
