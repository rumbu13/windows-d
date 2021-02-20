// Written in the D programming language.

module windows.wininet;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.filesystem : WIN32_FIND_DATAA, WIN32_FIND_DATAW;
public import windows.gdi : HBITMAP;
public import windows.security : CERT_CHAIN_CONTEXT, CERT_CONTEXT, SecPkgContext_Bindings,
                                 SecPkgContext_CipherInfo, SecPkgContext_ConnectionInfo;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, PSTR, PWSTR;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///Defines the flags used with the <b>nScheme</b> member of the URL_COMPONENTS structure.
alias INTERNET_SCHEME = int;
enum : int
{
    ///Partial URL.
    INTERNET_SCHEME_PARTIAL    = 0xfffffffe,
    ///Unknown URL scheme.
    INTERNET_SCHEME_UNKNOWN    = 0xffffffff,
    ///Default URL scheme.
    INTERNET_SCHEME_DEFAULT    = 0x00000000,
    ///FTP URL scheme (ftp:).
    INTERNET_SCHEME_FTP        = 0x00000001,
    ///Gopher URL scheme (gopher:). <div class="alert"><b>Note</b> Windows XP and Windows Server 2003 R2 and earlier
    ///only.</div> <div> </div>
    INTERNET_SCHEME_GOPHER     = 0x00000002,
    ///HTTP URL scheme (http:).
    INTERNET_SCHEME_HTTP       = 0x00000003,
    ///HTTPS URL scheme (https:).
    INTERNET_SCHEME_HTTPS      = 0x00000004,
    ///File URL scheme (file:).
    INTERNET_SCHEME_FILE       = 0x00000005,
    ///News URL scheme (news:).
    INTERNET_SCHEME_NEWS       = 0x00000006,
    ///Mail URL scheme (mailto:).
    INTERNET_SCHEME_MAILTO     = 0x00000007,
    ///Socks URL scheme (socks:).
    INTERNET_SCHEME_SOCKS      = 0x00000008,
    ///JScript URL scheme (javascript:).
    INTERNET_SCHEME_JAVASCRIPT = 0x00000009,
    ///VBScript URL scheme (vbscript:).
    INTERNET_SCHEME_VBSCRIPT   = 0x0000000a,
    ///Resource URL scheme (res:).
    INTERNET_SCHEME_RES        = 0x0000000b,
    ///Lowest known scheme value.
    INTERNET_SCHEME_FIRST      = 0x00000001,
    ///Highest known scheme value.
    INTERNET_SCHEME_LAST       = 0x0000000b,
}

///The <b>InternetCookieState</b> enumeration defines the state of the cookie.
enum InternetCookieState : int
{
    ///Reserved.
    COOKIE_STATE_UNKNOWN   = 0x00000000,
    ///The cookies are accepted.
    COOKIE_STATE_ACCEPT    = 0x00000001,
    ///The user is prompted to accept or deny the cookie.
    COOKIE_STATE_PROMPT    = 0x00000002,
    ///Cookies are accepted only in the first-party context.
    COOKIE_STATE_LEASH     = 0x00000003,
    ///Cookies are accepted and become session cookies.
    COOKIE_STATE_DOWNGRADE = 0x00000004,
    ///The cookies are rejected.
    COOKIE_STATE_REJECT    = 0x00000005,
    ///Same as <b>COOKIE_STATE_REJECT</b>.
    COOKIE_STATE_MAX       = 0x00000005,
}

alias WPAD_CACHE_DELETE = int;
enum : int
{
    WPAD_CACHE_DELETE_CURRENT = 0x00000000,
    WPAD_CACHE_DELETE_ALL     = 0x00000001,
}

alias FORTCMD = int;
enum : int
{
    FORTCMD_LOGON           = 0x00000001,
    FORTCMD_LOGOFF          = 0x00000002,
    FORTCMD_CHG_PERSONALITY = 0x00000003,
}

alias FORTSTAT = int;
enum : int
{
    FORTSTAT_INSTALLED = 0x00000001,
    FORTSTAT_LOGGEDON  = 0x00000002,
}

alias REQUEST_TIMES = int;
enum : int
{
    NameResolutionStart          = 0x00000000,
    NameResolutionEnd            = 0x00000001,
    ConnectionEstablishmentStart = 0x00000002,
    ConnectionEstablishmentEnd   = 0x00000003,
    TLSHandshakeStart            = 0x00000004,
    TLSHandshakeEnd              = 0x00000005,
    HttpRequestTimeMax           = 0x00000020,
}

alias HTTP_PUSH_WAIT_TYPE = int;
enum : int
{
    HttpPushWaitEnableComplete  = 0x00000000,
    HttpPushWaitReceiveComplete = 0x00000001,
    HttpPushWaitSendComplete    = 0x00000002,
}

alias WININET_SYNC_MODE = int;
enum : int
{
    WININET_SYNC_MODE_NEVER            = 0x00000000,
    WININET_SYNC_MODE_ON_EXPIRY        = 0x00000001,
    WININET_SYNC_MODE_ONCE_PER_SESSION = 0x00000002,
    WININET_SYNC_MODE_ALWAYS           = 0x00000003,
    WININET_SYNC_MODE_AUTOMATIC        = 0x00000004,
    WININET_SYNC_MODE_DEFAULT          = 0x00000004,
}

alias APP_CACHE_STATE = int;
enum : int
{
    AppCacheStateNoUpdateNeeded         = 0x00000000,
    AppCacheStateUpdateNeeded           = 0x00000001,
    AppCacheStateUpdateNeededNew        = 0x00000002,
    AppCacheStateUpdateNeededMasterOnly = 0x00000003,
}

alias APP_CACHE_FINALIZE_STATE = int;
enum : int
{
    AppCacheFinalizeStateIncomplete     = 0x00000000,
    AppCacheFinalizeStateManifestChange = 0x00000001,
    AppCacheFinalizeStateComplete       = 0x00000002,
}

alias URL_CACHE_LIMIT_TYPE = int;
enum : int
{
    UrlCacheLimitTypeIE                = 0x00000000,
    UrlCacheLimitTypeIETotal           = 0x00000001,
    UrlCacheLimitTypeAppContainer      = 0x00000002,
    UrlCacheLimitTypeAppContainerTotal = 0x00000003,
    UrlCacheLimitTypeNum               = 0x00000004,
}

alias HTTP_WEB_SOCKET_OPERATION = int;
enum : int
{
    HTTP_WEB_SOCKET_SEND_OPERATION     = 0x00000000,
    HTTP_WEB_SOCKET_RECEIVE_OPERATION  = 0x00000001,
    HTTP_WEB_SOCKET_CLOSE_OPERATION    = 0x00000002,
    HTTP_WEB_SOCKET_SHUTDOWN_OPERATION = 0x00000003,
}

alias HTTP_WEB_SOCKET_BUFFER_TYPE = int;
enum : int
{
    HTTP_WEB_SOCKET_BINARY_MESSAGE_TYPE  = 0x00000000,
    HTTP_WEB_SOCKET_BINARY_FRAGMENT_TYPE = 0x00000001,
    HTTP_WEB_SOCKET_UTF8_MESSAGE_TYPE    = 0x00000002,
    HTTP_WEB_SOCKET_UTF8_FRAGMENT_TYPE   = 0x00000003,
    HTTP_WEB_SOCKET_CLOSE_TYPE           = 0x00000004,
    HTTP_WEB_SOCKET_PING_TYPE            = 0x00000005,
}

alias HTTP_WEB_SOCKET_CLOSE_STATUS = int;
enum : int
{
    HTTP_WEB_SOCKET_SUCCESS_CLOSE_STATUS                = 0x000003e8,
    HTTP_WEB_SOCKET_ENDPOINT_TERMINATED_CLOSE_STATUS    = 0x000003e9,
    HTTP_WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS         = 0x000003ea,
    HTTP_WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS      = 0x000003eb,
    HTTP_WEB_SOCKET_EMPTY_CLOSE_STATUS                  = 0x000003ed,
    HTTP_WEB_SOCKET_ABORTED_CLOSE_STATUS                = 0x000003ee,
    HTTP_WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS        = 0x000003ef,
    HTTP_WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS       = 0x000003f0,
    HTTP_WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS        = 0x000003f1,
    HTTP_WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 0x000003f2,
    HTTP_WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS           = 0x000003f3,
    HTTP_WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 0x000003f7,
}

// Callbacks

///Prototype for an application-defined status callback function. The <b>INTERNET_STATUS_CALLBACK</b> type defines a
///pointer to this callback function.<i>InternetStatusCallback</i> is a placeholder for the application-defined function
///name.
///Params:
///    hInternet = The handle for which the callback function is called.
///    dwContext = A pointer to a variable that specifies the application-defined context value associated with <i>hInternet</i>.
///    dwInternetStatus = A status code that indicates why the callback function is called. This parameter can be one of the following
///                       values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_CLOSING_CONNECTION"></a><a id="internet_status_closing_connection"></a><dl>
///                       <dt><b>INTERNET_STATUS_CLOSING_CONNECTION</b></dt> </dl> </td> <td width="60%"> Closing the connection to the
///                       server. The <i>lpvStatusInformation</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_CONNECTED_TO_SERVER"></a><a id="internet_status_connected_to_server"></a><dl>
///                       <dt><b>INTERNET_STATUS_CONNECTED_TO_SERVER</b></dt> </dl> </td> <td width="60%"> Successfully connected to the
///                       socket address (SOCKADDR) pointed to by <i>lpvStatusInformation</i>. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_CONNECTING_TO_SERVER"></a><a id="internet_status_connecting_to_server"></a><dl>
///                       <dt><b>INTERNET_STATUS_CONNECTING_TO_SERVER</b></dt> </dl> </td> <td width="60%"> Connecting to the socket
///                       address (SOCKADDR) pointed to by <i>lpvStatusInformation</i>. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_CONNECTION_CLOSED"></a><a id="internet_status_connection_closed"></a><dl>
///                       <dt><b>INTERNET_STATUS_CONNECTION_CLOSED</b></dt> </dl> </td> <td width="60%"> Successfully closed the connection
///                       to the server. The <i>lpvStatusInformation</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_COOKIE_HISTORY"></a><a id="internet_status_cookie_history"></a><dl>
///                       <dt><b>INTERNET_STATUS_COOKIE_HISTORY</b></dt> </dl> </td> <td width="60%"> Retrieving content from the cache.
///                       Contains data about past cookie events for the URL such as if cookies were accepted, rejected, downgraded, or
///                       leashed. The <i>lpvStatusInformation</i> parameter is a pointer to an InternetCookieHistory structure. </td>
///                       </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_COOKIE_RECEIVED"></a><a
///                       id="internet_status_cookie_received"></a><dl> <dt><b>INTERNET_STATUS_COOKIE_RECEIVED</b></dt> </dl> </td> <td
///                       width="60%"> Indicates the number of cookies that were accepted, rejected, downgraded (changed from persistent to
///                       session cookies), or leashed (will be sent out only in 1st party context). The <i>lpvStatusInformation</i>
///                       parameter is a <b>DWORD</b> with the number of cookies received. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_COOKIE_SENT"></a><a id="internet_status_cookie_sent"></a><dl>
///                       <dt><b>INTERNET_STATUS_COOKIE_SENT</b></dt> </dl> </td> <td width="60%"> Indicates the number of cookies that
///                       were either sent or suppressed, when a request is sent. The <i>lpvStatusInformation</i> parameter is a
///                       <b>DWORD</b> with the number of cookies sent or suppressed. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_CTL_RESPONSE_RECEIVED"></a><a id="internet_status_ctl_response_received"></a><dl>
///                       <dt><b>INTERNET_STATUS_CTL_RESPONSE_RECEIVED</b></dt> </dl> </td> <td width="60%"> Not implemented. </td> </tr>
///                       <tr> <td width="40%"><a id="INTERNET_STATUS_DETECTING_PROXY"></a><a id="internet_status_detecting_proxy"></a><dl>
///                       <dt><b>INTERNET_STATUS_DETECTING_PROXY</b></dt> </dl> </td> <td width="60%"> Notifies the client application that
///                       a proxy has been detected. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_HANDLE_CLOSING"></a><a
///                       id="internet_status_handle_closing"></a><dl> <dt><b>INTERNET_STATUS_HANDLE_CLOSING</b></dt> </dl> </td> <td
///                       width="60%"> This handle value has been terminated. pvStatusInformation contains the address of the handle being
///                       closed. The <i>lpvStatusInformation</i> parameter contains the address of the handle being closed. </td> </tr>
///                       <tr> <td width="40%"><a id="INTERNET_STATUS_HANDLE_CREATED"></a><a id="internet_status_handle_created"></a><dl>
///                       <dt><b>INTERNET_STATUS_HANDLE_CREATED</b></dt> </dl> </td> <td width="60%"> Used by InternetConnect to indicate
///                       it has created the new handle. This lets the application call InternetCloseHandle from another thread, if the
///                       connect is taking too long. The <i>lpvStatusInformation</i> parameter contains the address of an HINTERNET
///                       handle. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_INTERMEDIATE_RESPONSE"></a><a
///                       id="internet_status_intermediate_response"></a><dl> <dt><b>INTERNET_STATUS_INTERMEDIATE_RESPONSE</b></dt> </dl>
///                       </td> <td width="60%"> Received an intermediate (100 level) status code message from the server. </td> </tr> <tr>
///                       <td width="40%"><a id="INTERNET_STATUS_NAME_RESOLVED"></a><a id="internet_status_name_resolved"></a><dl>
///                       <dt><b>INTERNET_STATUS_NAME_RESOLVED</b></dt> </dl> </td> <td width="60%"> Successfully found the IP address of
///                       the name contained in <i>lpvStatusInformation</i>. The <i>lpvStatusInformation</i> parameter points to a
///                       <b>PCTSTR</b> containing the host name. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_P3P_HEADER"></a><a id="internet_status_p3p_header"></a><dl>
///                       <dt><b>INTERNET_STATUS_P3P_HEADER</b></dt> </dl> </td> <td width="60%"> The response has a P3P header in it.
///                       </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_P3P_POLICYREF"></a><a
///                       id="internet_status_p3p_policyref"></a><dl> <dt><b>INTERNET_STATUS_P3P_POLICYREF</b></dt> </dl> </td> <td
///                       width="60%"> Not implemented. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_PREFETCH"></a><a
///                       id="internet_status_prefetch"></a><dl> <dt><b>INTERNET_STATUS_PREFETCH</b></dt> </dl> </td> <td width="60%"> Not
///                       implemented. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_PRIVACY_IMPACTED_"></a><a
///                       id="internet_status_privacy_impacted_"></a><dl> <dt><b>INTERNET_STATUS_PRIVACY_IMPACTED </b></dt> </dl> </td> <td
///                       width="60%"> Not implemented. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_RECEIVING_RESPONSE"></a><a
///                       id="internet_status_receiving_response"></a><dl> <dt><b>INTERNET_STATUS_RECEIVING_RESPONSE</b></dt> </dl> </td>
///                       <td width="60%"> Waiting for the server to respond to a request. The <i>lpvStatusInformation</i> parameter is
///                       <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_REDIRECT"></a><a
///                       id="internet_status_redirect"></a><dl> <dt><b>INTERNET_STATUS_REDIRECT</b></dt> </dl> </td> <td width="60%"> An
///                       HTTP request is about to automatically redirect the request. The <i>lpvStatusInformation</i> parameter points to
///                       the new URL. At this point, the application can read any data returned by the server with the redirect response
///                       and can query the response headers. It can also cancel the operation by closing the handle. This callback is not
///                       made if the original request specified INTERNET_FLAG_NO_AUTO_REDIRECT. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_REQUEST_COMPLETE"></a><a id="internet_status_request_complete"></a><dl>
///                       <dt><b>INTERNET_STATUS_REQUEST_COMPLETE</b></dt> </dl> </td> <td width="60%"> An asynchronous operation has been
///                       completed. The <i>lpvStatusInformation</i> parameter contains the address of an INTERNET_ASYNC_RESULT structure.
///                       </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_REQUEST_SENT"></a><a
///                       id="internet_status_request_sent"></a><dl> <dt><b>INTERNET_STATUS_REQUEST_SENT</b></dt> </dl> </td> <td
///                       width="60%"> Successfully sent the information request to the server. The <i>lpvStatusInformation</i> parameter
///                       points to a <b>DWORD</b> value that contains the number of bytes sent. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_RESOLVING_NAME"></a><a id="internet_status_resolving_name"></a><dl>
///                       <dt><b>INTERNET_STATUS_RESOLVING_NAME</b></dt> </dl> </td> <td width="60%"> Looking up the IP address of the name
///                       contained in <i>lpvStatusInformation</i>. The <i>lpvStatusInformation</i> parameter points to a <b>PCTSTR</b>
///                       containing the host name. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_RESPONSE_RECEIVED"></a><a
///                       id="internet_status_response_received"></a><dl> <dt><b>INTERNET_STATUS_RESPONSE_RECEIVED</b></dt> </dl> </td> <td
///                       width="60%"> Successfully received a response from the server. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_SENDING_REQUEST"></a><a id="internet_status_sending_request"></a><dl>
///                       <dt><b>INTERNET_STATUS_SENDING_REQUEST</b></dt> </dl> </td> <td width="60%"> Sending the information request to
///                       the server. The <i>lpvStatusInformation</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a
///                       id="INTERNET_STATUS_STATE_CHANGE"></a><a id="internet_status_state_change"></a><dl>
///                       <dt><b>INTERNET_STATUS_STATE_CHANGE</b></dt> </dl> </td> <td width="60%"> Moved between a secure (HTTPS) and a
///                       nonsecure (HTTP) site. The user must be informed of this change; otherwise, the user is at risk of disclosing
///                       sensitive information involuntarily. When this flag is set, the <i>lpvStatusInformation</i> parameter points to a
///                       status DWORD that contains additional flags. </td> </tr> </table>
///    lpvStatusInformation = A pointer to additional status information. When the <b>INTERNET_STATUS_STATE_CHANGE</b> flag is set,
///                           <i>lpvStatusInformation</i> points to a <b>DWORD</b> that contains one or more of the following flags: <table>
///                           <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_STATE_CONNECTED"></a><a
///                           id="internet_state_connected"></a><dl> <dt><b>INTERNET_STATE_CONNECTED</b></dt> </dl> </td> <td width="60%">
///                           Connected state. Mutually exclusive with disconnected state. </td> </tr> <tr> <td width="40%"><a
///                           id="INTERNET_STATE_DISCONNECTED"></a><a id="internet_state_disconnected"></a><dl>
///                           <dt><b>INTERNET_STATE_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> Disconnected state. No network
///                           connection could be established. </td> </tr> <tr> <td width="40%"><a
///                           id="INTERNET_STATE_DISCONNECTED_BY_USER"></a><a id="internet_state_disconnected_by_user"></a><dl>
///                           <dt><b>INTERNET_STATE_DISCONNECTED_BY_USER</b></dt> </dl> </td> <td width="60%"> Disconnected by user request.
///                           </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATE_IDLE"></a><a id="internet_state_idle"></a><dl>
///                           <dt><b>INTERNET_STATE_IDLE</b></dt> </dl> </td> <td width="60%"> No network requests are being made by Windows
///                           Internet. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATE_BUSY"></a><a id="internet_state_busy"></a><dl>
///                           <dt><b>INTERNET_STATE_BUSY</b></dt> </dl> </td> <td width="60%"> Network requests are being made by Windows
///                           Internet. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATUS_USER_INPUT_REQUIRED"></a><a
///                           id="internet_status_user_input_required"></a><dl> <dt><b>INTERNET_STATUS_USER_INPUT_REQUIRED</b></dt> </dl> </td>
///                           <td width="60%"> The request requires user input to be completed. </td> </tr> </table>
///    dwStatusInformationLength = The size, in bytes, of the data pointed to by <i>lpvStatusInformation</i>.
alias INTERNET_STATUS_CALLBACK = void function(void* hInternet, size_t dwContext, uint dwInternetStatus, 
                                               void* lpvStatusInformation, uint dwStatusInformationLength);
alias LPINTERNET_STATUS_CALLBACK = void function();
///<p class="CCE_Message">[The <i>GopherAttributeEnumerator</i> function is available for use in the operating systems
///specified in the Requirements section.] Prototype for a callback function that processes attribute information from a
///Gopher server. This callback function is installed by a call to the GopherGetAttribute function. The
///<b>GOPHER_ATTRIBUTE_ENUMERATOR</b> type defines a pointer to this callback function. <i>GopherAttributeEnumerator</i>
///is a placeholder for the application-defined function name.
///Params:
///    lpAttributeInfo = Pointer to a GOPHER_ATTRIBUTE_TYPE structure. The <i>lpBuffer</i> parameter of GopherGetAttribute is used for
///                      storing this structure. The <i>lpBuffer</i> size must be equal to or greater than the value of
///                      MIN_GOPHER_ATTRIBUTE_LENGTH.
///    dwError = Error value. This parameter is NO_ERROR if the attribute was parsed and written to the buffer successfully. If a
///              problem was encountered, an error value is returned.
///Returns:
///    Return <b>TRUE</b> to continue the enumeration, or <b>FALSE</b> to stop it immediately. This function is
///    primarily used for returning the results of a Gopher+ ASK item.
///    
alias GOPHER_ATTRIBUTE_ENUMERATOR = BOOL function(GOPHER_ATTRIBUTE_TYPE* lpAttributeInfo, uint dwError);
alias PFN_AUTH_NOTIFY = uint function(size_t param0, uint param1, void* param2);
alias pfnInternetInitializeAutoProxyDll = BOOL function(uint dwVersion, PSTR lpszDownloadedTempFile, PSTR lpszMime, 
                                                        AutoProxyHelperFunctions* lpAutoProxyCallbacks, 
                                                        AUTO_PROXY_SCRIPT_BUFFER* lpAutoProxyScriptBuffer);
alias pfnInternetDeInitializeAutoProxyDll = BOOL function(PSTR lpszMime, uint dwReserved);
alias pfnInternetGetProxyInfo = BOOL function(const(PSTR) lpszUrl, uint dwUrlLength, PSTR lpszUrlHostName, 
                                              uint dwUrlHostNameLength, PSTR* lplpszProxyHostName, 
                                              uint* lpdwProxyHostNameLength);
alias PFN_DIAL_HANDLER = uint function(HWND param0, const(PSTR) param1, uint param2, uint* param3);
alias CACHE_OPERATOR = BOOL function(INTERNET_CACHE_ENTRY_INFOA* pcei, uint* pcbcei, void* pOpData);

// Structs


///Contains the global HTTP version.
struct HTTP_VERSION_INFO
{
    ///The major version number. Must be 1.
    uint dwMajorVersion;
    ///The minor version number. Can be either 1 or zero.
    uint dwMinorVersion;
}

///Contains the result of a call to an asynchronous function. This structure is used with InternetStatusCallback.
struct INTERNET_ASYNC_RESULT
{
    ///Result. This parameter can be an HINTERNET handle, unsigned long integer, or Boolean return code from an
    ///asynchronous function.
    size_t dwResult;
    ///Error code, if <b>dwResult</b> indicates that the function failed. If the operation succeeded, this member
    ///usually contains ERROR_SUCCESS.
    uint   dwError;
}

///The <b>INTERNET_DIAGNOSTIC_SOCKET_INFO</b> structure is returned by the InternetQueryOption function when the
///INTERNET_OPTION_DIAGNOSTIC_SOCKET_INFO flag is passed to it together with a handle to an HTTP Request. The
///<b>INTERNET_DIAGNOSTIC_SOCKET_INFO</b> structure contains information about the socket associated with that HTTP
///Request.
struct INTERNET_DIAGNOSTIC_SOCKET_INFO
{
    ///Descriptor that identifies the socket associated with the specified HTTP Request.
    size_t Socket;
    ///The address of the port at which the HTTP Request and response was received.
    uint   SourcePort;
    ///The address of the port at which the response was sent.
    uint   DestPort;
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IDSI_FLAG_KEEP_ALIVE"></a><a
    ///id="idsi_flag_keep_alive"></a><dl> <dt><b>IDSI_FLAG_KEEP_ALIVE</b></dt> </dl> </td> <td width="60%"> Set if the
    ///connection is from the "keep-alive" pool. </td> </tr> <tr> <td width="40%"><a id="IDSI_FLAG_SECURE"></a><a
    ///id="idsi_flag_secure"></a><dl> <dt><b>IDSI_FLAG_SECURE</b></dt> </dl> </td> <td width="60%"> Set if the HTTP
    ///Request is using a secure socket. </td> </tr> <tr> <td width="40%"><a id="IDSI_FLAG_PROXY"></a><a
    ///id="idsi_flag_proxy"></a><dl> <dt><b>IDSI_FLAG_PROXY</b></dt> </dl> </td> <td width="60%"> Set if a proxy is
    ///being used to reach the server. </td> </tr> <tr> <td width="40%"><a id="IDSI_FLAG_TUNNEL"></a><a
    ///id="idsi_flag_tunnel"></a><dl> <dt><b>IDSI_FLAG_TUNNEL</b></dt> </dl> </td> <td width="60%"> Set if a proxy is
    ///being used to create a tunnel. </td> </tr> </table>
    uint   Flags;
}

///Contains information that is supplied with the INTERNET_OPTION_PROXY value to get or set proxy information on a
///handle obtained from a call to the InternetOpen function.
struct INTERNET_PROXY_INFO
{
    ///Access type. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="INTERNET_OPEN_TYPE_DIRECT"></a><a id="internet_open_type_direct"></a><dl>
    ///<dt><b>INTERNET_OPEN_TYPE_DIRECT</b></dt> </dl> </td> <td width="60%"> Internet accessed through a direct
    ///connection. </td> </tr> <tr> <td width="40%"><a id="INTERNET_OPEN_TYPE_PRECONFIG"></a><a
    ///id="internet_open_type_preconfig"></a><dl> <dt><b>INTERNET_OPEN_TYPE_PRECONFIG</b></dt> </dl> </td> <td
    ///width="60%"> Applies only when setting proxy information. </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_OPEN_TYPE_PROXY"></a><a id="internet_open_type_proxy"></a><dl>
    ///<dt><b>INTERNET_OPEN_TYPE_PROXY</b></dt> </dl> </td> <td width="60%"> Internet accessed using a proxy. </td>
    ///</tr> </table>
    uint  dwAccessType;
    ///Pointer to a string that contains the proxy server list.
    byte* lpszProxy;
    ///Pointer to a string that contains the proxy bypass list.
    byte* lpszProxyBypass;
}

///Contains the value of an option.
struct INTERNET_PER_CONN_OPTIONA
{
    ///Option to be queried or set. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_URL"></a><a
    ///id="internet_per_conn_autoconfig_url"></a><dl> <dt><b>INTERNET_PER_CONN_AUTOCONFIG_URL</b></dt> </dl> </td> <td
    ///width="60%"> Sets or retrieves a string containing the URL to the automatic configuration script. </td> </tr>
    ///<tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTODISCOVERY_FLAGS"></a><a
    ///id="internet_per_conn_autodiscovery_flags"></a><dl> <dt><b>INTERNET_PER_CONN_AUTODISCOVERY_FLAGS</b></dt> </dl>
    ///</td> <td width="60%"> Sets or retrieves the automatic discovery settings. The <b>Value</b> member will contain
    ///one or more of the following values: <dl> <dt>AUTO_PROXY_FLAG_ALWAYS_DETECT</dt> <dd> Always automatically detect
    ///settings. </dd> <dt>AUTO_PROXY_FLAG_CACHE_INIT_RUN</dt> <dd> Indicates that the cached results of the automatic
    ///proxy configuration script should be used, instead of actually running the script, unless the cached file has
    ///expired. </dd> <dt>AUTO_PROXY_FLAG_DETECTION_RUN</dt> <dd> Automatic detection has been run at least once on this
    ///connection. </dd> <dt>AUTO_PROXY_FLAG_DETECTION_SUSPECT</dt> <dd> Not currently supported. </dd>
    ///<dt>AUTO_PROXY_FLAG_DONT_CACHE_PROXY_RESULT</dt> <dd> Do not allow the caching of the result of the automatic
    ///proxy configuration script. </dd> <dt>AUTO_PROXY_FLAG_MIGRATED</dt> <dd> The setting was migrated from a
    ///Microsoft Internet Explorer 4.0 installation, and automatic detection should be attempted once. </dd>
    ///<dt>AUTO_PROXY_FLAG_USER_SET</dt> <dd> The user has explicitly set the automatic detection. </dd> </dl> </td>
    ///</tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_FLAGS"></a><a id="internet_per_conn_flags"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_FLAGS</b></dt> </dl> </td> <td width="60%"> Sets or retrieves the connection type. The
    ///<b>Value</b> member will contain one or more of the following values: <dl> <dt>PROXY_TYPE_DIRECT</dt> <dd> The
    ///connection does not use a proxy server. </dd> <dt>PROXY_TYPE_PROXY</dt> <dd> The connection uses an explicitly
    ///set proxy server. </dd> <dt>PROXY_TYPE_AUTO_PROXY_URL</dt> <dd> The connection downloads and processes an
    ///automatic configuration script at a specified URL. </dd> <dt>PROXY_TYPE_AUTO_DETECT</dt> <dd> The connection
    ///automatically detects settings. </dd> </dl> </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_PER_CONN_PROXY_BYPASS"></a><a id="internet_per_conn_proxy_bypass"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_PROXY_BYPASS</b></dt> </dl> </td> <td width="60%"> Sets or retrieves a string containing
    ///the URLs that do not use the proxy server. </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_PER_CONN_PROXY_SERVER"></a><a id="internet_per_conn_proxy_server"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_PROXY_SERVER</b></dt> </dl> </td> <td width="60%"> Sets or retrieves a string containing
    ///the proxy servers. </td> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_SECONDARY_URL"></a><a
    ///id="internet_per_conn_autoconfig_secondary_url"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_SECONDARY_URL</b></dt> </dl> </td> <td width="60%"> Chained autoconfig URL.
    ///Used when the primary autoconfig URL points to an INS file that sets a second autoconfig URL for proxy
    ///information. </td> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_RELOAD_DELAY_MINS"></a><a
    ///id="internet_per_conn_autoconfig_reload_delay_mins"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_RELOAD_DELAY_MINS</b></dt> </dl> </td> <td width="60%"> of minutes until
    ///automatic refresh of autoconfig URL by autodiscovery. </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_TIME"></a><a
    ///id="internet_per_conn_autoconfig_last_detect_time"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_TIME</b></dt> </dl> </td> <td width="60%"> Read only option.
    ///Returns the time the last known good autoconfig URL was found using autodiscovery. </td> </tr> <tr> <td
    ///width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_URL"></a><a
    ///id="internet_per_conn_autoconfig_last_detect_url"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_URL</b></dt> </dl> </td> <td width="60%"> Read only option.
    ///Returns the last known good URL found using autodiscovery. </td> </tr> </table> <b>Windows 7 and later: </b><p
    ///class="note">Clients that support Internet Explorer 8 should query the connection type using
    ///<b>INTERNET_PER_CONN_FLAGS_UI</b>. If this query fails, then the system is running a previous version of Internet
    ///Explorer and the client should query again with <b>INTERNET_PER_CONN_FLAGS</b>. <p class="note">Restore the
    ///connection type using <b>INTERNET_PER_CONN_FLAGS</b> regardless of the version of Internet Explorer. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_FLAGS_UI"></a><a
    ///id="internet_per_conn_flags_ui"></a><dl> <dt><b>INTERNET_PER_CONN_FLAGS_UI</b></dt> </dl> </td> <td width="60%">
    ///Sets or retrieves the connection type. The <b>Value</b> member will contain one or more of the following values:
    ///<dl> <dt>PROXY_TYPE_DIRECT</dt> <dd> The connection does not use a proxy server. </dd> <dt>PROXY_TYPE_PROXY</dt>
    ///<dd> The connection uses an explicitly set proxy server. </dd> <dt>PROXY_TYPE_AUTO_PROXY_URL</dt> <dd> The
    ///connection downloads and processes an automatic configuration script at a specified URL. </dd>
    ///<dt>PROXY_TYPE_AUTO_DETECT</dt> <dd> The connection automatically detects settings. </dd> </dl> </td> </tr>
    ///</table>
    uint dwOption;
union Value
    {
        uint     dwValue;
        PSTR     pszValue;
        FILETIME ftValue;
    }
}

///Contains the value of an option.
struct INTERNET_PER_CONN_OPTIONW
{
    ///Option to be queried or set. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_URL"></a><a
    ///id="internet_per_conn_autoconfig_url"></a><dl> <dt><b>INTERNET_PER_CONN_AUTOCONFIG_URL</b></dt> </dl> </td> <td
    ///width="60%"> Sets or retrieves a string containing the URL to the automatic configuration script. </td> </tr>
    ///<tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTODISCOVERY_FLAGS"></a><a
    ///id="internet_per_conn_autodiscovery_flags"></a><dl> <dt><b>INTERNET_PER_CONN_AUTODISCOVERY_FLAGS</b></dt> </dl>
    ///</td> <td width="60%"> Sets or retrieves the automatic discovery settings. The <b>Value</b> member will contain
    ///one or more of the following values: <dl> <dt>AUTO_PROXY_FLAG_ALWAYS_DETECT</dt> <dd> Always automatically detect
    ///settings. </dd> <dt>AUTO_PROXY_FLAG_CACHE_INIT_RUN</dt> <dd> Indicates that the cached results of the automatic
    ///proxy configuration script should be used, instead of actually running the script, unless the cached file has
    ///expired. </dd> <dt>AUTO_PROXY_FLAG_DETECTION_RUN</dt> <dd> Automatic detection has been run at least once on this
    ///connection. </dd> <dt>AUTO_PROXY_FLAG_DETECTION_SUSPECT</dt> <dd> Not currently supported. </dd>
    ///<dt>AUTO_PROXY_FLAG_DONT_CACHE_PROXY_RESULT</dt> <dd> Do not allow the caching of the result of the automatic
    ///proxy configuration script. </dd> <dt>AUTO_PROXY_FLAG_MIGRATED</dt> <dd> The setting was migrated from a
    ///Microsoft Internet Explorer 4.0 installation, and automatic detection should be attempted once. </dd>
    ///<dt>AUTO_PROXY_FLAG_USER_SET</dt> <dd> The user has explicitly set the automatic detection. </dd> </dl> </td>
    ///</tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_FLAGS"></a><a id="internet_per_conn_flags"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_FLAGS</b></dt> </dl> </td> <td width="60%"> Sets or retrieves the connection type. The
    ///<b>Value</b> member will contain one or more of the following values: <dl> <dt>PROXY_TYPE_DIRECT</dt> <dd> The
    ///connection does not use a proxy server. </dd> <dt>PROXY_TYPE_PROXY</dt> <dd> The connection uses an explicitly
    ///set proxy server. </dd> <dt>PROXY_TYPE_AUTO_PROXY_URL</dt> <dd> The connection downloads and processes an
    ///automatic configuration script at a specified URL. </dd> <dt>PROXY_TYPE_AUTO_DETECT</dt> <dd> The connection
    ///automatically detects settings. </dd> </dl> </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_PER_CONN_PROXY_BYPASS"></a><a id="internet_per_conn_proxy_bypass"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_PROXY_BYPASS</b></dt> </dl> </td> <td width="60%"> Sets or retrieves a string containing
    ///the URLs that do not use the proxy server. </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_PER_CONN_PROXY_SERVER"></a><a id="internet_per_conn_proxy_server"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_PROXY_SERVER</b></dt> </dl> </td> <td width="60%"> Sets or retrieves a string containing
    ///the proxy servers. </td> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_SECONDARY_URL"></a><a
    ///id="internet_per_conn_autoconfig_secondary_url"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_SECONDARY_URL</b></dt> </dl> </td> <td width="60%"> Chained autoconfig URL.
    ///Used when the primary autoconfig URL points to an INS file that sets a second autoconfig URL for proxy
    ///information. </td> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_RELOAD_DELAY_MINS"></a><a
    ///id="internet_per_conn_autoconfig_reload_delay_mins"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_RELOAD_DELAY_MINS</b></dt> </dl> </td> <td width="60%"> of minutes until
    ///automatic refresh of autoconfig URL by autodiscovery. </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_TIME"></a><a
    ///id="internet_per_conn_autoconfig_last_detect_time"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_TIME</b></dt> </dl> </td> <td width="60%"> Read only option.
    ///Returns the time the last known good autoconfig URL was found using autodiscovery. </td> </tr> <tr> <td
    ///width="40%"><a id="INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_URL"></a><a
    ///id="internet_per_conn_autoconfig_last_detect_url"></a><dl>
    ///<dt><b>INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_URL</b></dt> </dl> </td> <td width="60%"> Read only option.
    ///Returns the last known good URL found using autodiscovery. </td> </tr> </table> <b>Windows 7 and later: </b><p
    ///class="note">Clients that support Internet Explorer 8 should query the connection type using
    ///<b>INTERNET_PER_CONN_FLAGS_UI</b>. If this query fails, then the system is running a previous version of Internet
    ///Explorer and the client should query again with <b>INTERNET_PER_CONN_FLAGS</b>. <p class="note">Restore the
    ///connection type using <b>INTERNET_PER_CONN_FLAGS</b> regardless of the version of Internet Explorer. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_PER_CONN_FLAGS_UI"></a><a
    ///id="internet_per_conn_flags_ui"></a><dl> <dt><b>INTERNET_PER_CONN_FLAGS_UI</b></dt> </dl> </td> <td width="60%">
    ///Sets or retrieves the connection type. The <b>Value</b> member will contain one or more of the following values:
    ///<dl> <dt>PROXY_TYPE_DIRECT</dt> <dd> The connection does not use a proxy server. </dd> <dt>PROXY_TYPE_PROXY</dt>
    ///<dd> The connection uses an explicitly set proxy server. </dd> <dt>PROXY_TYPE_AUTO_PROXY_URL</dt> <dd> The
    ///connection downloads and processes an automatic configuration script at a specified URL. </dd>
    ///<dt>PROXY_TYPE_AUTO_DETECT</dt> <dd> The connection automatically detects settings. </dd> </dl> </td> </tr>
    ///</table>
    uint dwOption;
union Value
    {
        uint     dwValue;
        PWSTR    pszValue;
        FILETIME ftValue;
    }
}

///Contains the list of options for a particular Internet connection.
struct INTERNET_PER_CONN_OPTION_LISTA
{
    ///Size of the structure, in bytes.
    uint dwSize;
    ///Pointer to a string that contains the name of the RAS connection or <b>NULL</b>, which indicates the default or
    ///LAN connection, to set or query options on.
    PSTR pszConnection;
    ///Number of options to query or set.
    uint dwOptionCount;
    ///Options that failed, if an error occurs.
    uint dwOptionError;
    ///Pointer to an array of INTERNET_PER_CONN_OPTION structures containing the options to query or set.
    INTERNET_PER_CONN_OPTIONA* pOptions;
}

///Contains the list of options for a particular Internet connection.
struct INTERNET_PER_CONN_OPTION_LISTW
{
    ///Size of the structure, in bytes.
    uint  dwSize;
    ///Pointer to a string that contains the name of the RAS connection or <b>NULL</b>, which indicates the default or
    ///LAN connection, to set or query options on.
    PWSTR pszConnection;
    ///Number of options to query or set.
    uint  dwOptionCount;
    ///Options that failed, if an error occurs.
    uint  dwOptionError;
    ///Pointer to an array of INTERNET_PER_CONN_OPTION structures containing the options to query or set.
    INTERNET_PER_CONN_OPTIONW* pOptions;
}

///Contains the HTTP version number of the server. This structure is used when passing the INTERNET_OPTION_VERSION flag
///to the InternetQueryOption function.
struct INTERNET_VERSION_INFO
{
    ///Major version number.
    uint dwMajorVersion;
    ///Minor version number.
    uint dwMinorVersion;
}

///Contains the information to set the global online/offline state.
struct INTERNET_CONNECTED_INFO
{
    ///State information. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="INTERNET_STATE_CONNECTED"></a><a id="internet_state_connected"></a><dl>
    ///<dt><b>INTERNET_STATE_CONNECTED</b></dt> </dl> </td> <td width="60%"> Connected to network. Replaces
    ///INTERNET_STATE_ONLINE. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATE_DISCONNECTED"></a><a
    ///id="internet_state_disconnected"></a><dl> <dt><b>INTERNET_STATE_DISCONNECTED</b></dt> </dl> </td> <td
    ///width="60%"> Disconnected from network. Replaces INTERNET_STATE_OFFLINE. </td> </tr> <tr> <td width="40%"><a
    ///id="INTERNET_STATE_DISCONNECTED_BY_USER"></a><a id="internet_state_disconnected_by_user"></a><dl>
    ///<dt><b>INTERNET_STATE_DISCONNECTED_BY_USER</b></dt> </dl> </td> <td width="60%"> Disconnected by user request.
    ///Replaces INTERNET_STATE_OFFLINE_USER. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATE_IDLE"></a><a
    ///id="internet_state_idle"></a><dl> <dt><b>INTERNET_STATE_IDLE</b></dt> </dl> </td> <td width="60%"> No network
    ///requests are being made. </td> </tr> <tr> <td width="40%"><a id="INTERNET_STATE_BUSY"></a><a
    ///id="internet_state_busy"></a><dl> <dt><b>INTERNET_STATE_BUSY</b></dt> </dl> </td> <td width="60%"> Network
    ///requests are being made. </td> </tr> </table>
    uint dwConnectedState;
    ///Controls the transition between states. This member can be ISO_FORCE_DISCONNECTED, which puts WinINet into
    ///offline mode. All outstanding requests will be aborted with a canceled error.
    uint dwFlags;
}

///Contains the constituent parts of a URL. This structure is used with the InternetCrackUrl and InternetCreateUrl
///functions.
struct URL_COMPONENTSA
{
    ///Size of this structure, in bytes.
    uint            dwStructSize;
    ///Pointer to a string that contains the scheme name.
    PSTR            lpszScheme;
    ///Size of the scheme name, in <b>TCHARs</b>.
    uint            dwSchemeLength;
    ///INTERNET_SCHEME value that indicates the Internet protocol scheme.
    INTERNET_SCHEME nScheme;
    ///Pointer to a string that contains the host name.
    PSTR            lpszHostName;
    ///Size of the host name, in <b>TCHARs</b>.
    uint            dwHostNameLength;
    ///Converted port number.
    ushort          nPort;
    ///Pointer to a string value that contains the user name.
    PSTR            lpszUserName;
    ///Size of the user name, in <b>TCHARs</b>.
    uint            dwUserNameLength;
    ///Pointer to a string that contains the password.
    PSTR            lpszPassword;
    ///Size of the password, in <b>TCHARs</b>.
    uint            dwPasswordLength;
    ///Pointer to a string that contains the URL path.
    PSTR            lpszUrlPath;
    ///Size of the URL path, in <b>TCHARs</b>.
    uint            dwUrlPathLength;
    ///Pointer to a string that contains the extra information (for example, ?something or
    PSTR            lpszExtraInfo;
    ///Size of the extra information, in <b>TCHARs</b>.
    uint            dwExtraInfoLength;
}

///Contains the constituent parts of a URL. This structure is used with the InternetCrackUrl and InternetCreateUrl
///functions.
struct URL_COMPONENTSW
{
    ///Size of this structure, in bytes.
    uint            dwStructSize;
    ///Pointer to a string that contains the scheme name.
    PWSTR           lpszScheme;
    ///Size of the scheme name, in <b>TCHARs</b>.
    uint            dwSchemeLength;
    ///INTERNET_SCHEME value that indicates the Internet protocol scheme.
    INTERNET_SCHEME nScheme;
    ///Pointer to a string that contains the host name.
    PWSTR           lpszHostName;
    ///Size of the host name, in <b>TCHARs</b>.
    uint            dwHostNameLength;
    ///Converted port number.
    ushort          nPort;
    ///Pointer to a string value that contains the user name.
    PWSTR           lpszUserName;
    ///Size of the user name, in <b>TCHARs</b>.
    uint            dwUserNameLength;
    ///Pointer to a string that contains the password.
    PWSTR           lpszPassword;
    ///Size of the password, in <b>TCHARs</b>.
    uint            dwPasswordLength;
    ///Pointer to a string that contains the URL path.
    PWSTR           lpszUrlPath;
    ///Size of the URL path, in <b>TCHARs</b>.
    uint            dwUrlPathLength;
    ///Pointer to a string that contains the extra information (for example, ?something or
    PWSTR           lpszExtraInfo;
    ///Size of the extra information, in <b>TCHARs</b>.
    uint            dwExtraInfoLength;
}

///Contains certificate information returned from the server. This structure is used by the InternetQueryOption
///function.
struct INTERNET_CERTIFICATE_INFO
{
    ///FILETIME structure that contains the date the certificate expires.
    FILETIME ftExpiry;
    ///FILETIME structure that contains the date the certificate becomes valid.
    FILETIME ftStart;
    ///Pointer to a buffer that contains the name of the organization, site, and server for which the certificate was
    ///issued. The application must call LocalFree to release the resources allocated for this parameter.
    byte*    lpszSubjectInfo;
    ///Pointer to a buffer that contains the name of the organization, site, and server that issued the certificate. The
    ///application must call LocalFree to release the resources allocated for this parameter.
    byte*    lpszIssuerInfo;
    ///Pointer to a buffer that contains the name of the protocol used to provide the secure connection. The application
    ///must call LocalFree to release the resources allocated for this parameter.
    byte*    lpszProtocolName;
    ///Pointer to a buffer that contains the name of the algorithm used for signing the certificate. The application
    ///must call LocalFree to release the resources allocated for this parameter.
    byte*    lpszSignatureAlgName;
    ///Pointer to a buffer that contains the name of the algorithm used for doing encryption over the secure channel
    ///(SSL/PCT) connection. The application must call LocalFree to release the resources allocated for this parameter.
    byte*    lpszEncryptionAlgName;
    ///Size, in <b>TCHAR</b>s, of the key.
    uint     dwKeySize;
}

///Contains both the data and header information.
struct INTERNET_BUFFERSA
{
    ///Size of the structure, in bytes.
    uint               dwStructSize;
    ///Pointer to the next <b>INTERNET_BUFFERS</b> structure.
    INTERNET_BUFFERSA* Next;
    ///Pointer to a string value that contains the headers. This member can be <b>NULL</b>.
    const(PSTR)        lpcszHeader;
    ///Size of the headers, in <b>TCHARs</b>, if <b>lpcszHeader</b> is not <b>NULL</b>.
    uint               dwHeadersLength;
    ///Size of the headers, if there is not enough memory in the buffer.
    uint               dwHeadersTotal;
    ///Pointer to the data buffer.
    void*              lpvBuffer;
    ///Size of the buffer, in bytes, if <b>lpvBuffer</b> is not <b>NULL</b>.
    uint               dwBufferLength;
    ///Total size of the resource, in bytes.
    uint               dwBufferTotal;
    ///Reserved; do not use.
    uint               dwOffsetLow;
    ///Reserved; do not use.
    uint               dwOffsetHigh;
}

///Contains both the data and header information.
struct INTERNET_BUFFERSW
{
    ///Size of the structure, in bytes.
    uint               dwStructSize;
    ///Pointer to the next <b>INTERNET_BUFFERS</b> structure.
    INTERNET_BUFFERSW* Next;
    ///Pointer to a string value that contains the headers. This member can be <b>NULL</b>.
    const(PWSTR)       lpcszHeader;
    ///Size of the headers, in <b>TCHARs</b>, if <b>lpcszHeader</b> is not <b>NULL</b>.
    uint               dwHeadersLength;
    ///Size of the headers, if there is not enough memory in the buffer.
    uint               dwHeadersTotal;
    ///Pointer to the data buffer.
    void*              lpvBuffer;
    ///Size of the buffer, in bytes, if <b>lpvBuffer</b> is not <b>NULL</b>.
    uint               dwBufferLength;
    ///Total size of the resource, in bytes.
    uint               dwBufferTotal;
    ///Reserved; do not use.
    uint               dwOffsetLow;
    ///Reserved; do not use.
    uint               dwOffsetHigh;
}

struct IncomingCookieState
{
    int          cSession;
    int          cPersistent;
    int          cAccepted;
    int          cLeashed;
    int          cDowngraded;
    int          cBlocked;
    const(byte)* pszLocation;
}

struct OutgoingCookieState
{
    int          cSent;
    int          cSuppressed;
    const(byte)* pszLocation;
}

///The <b>InternetCookieHistory</b> structure contains the cookie history.
struct InternetCookieHistory
{
    ///If true, the cookie was accepted.
    BOOL fAccepted;
    ///If true, the cookie was leashed.
    BOOL fLeashed;
    ///If true, the cookie was downgraded.
    BOOL fDowngraded;
    ///If true, the cookie was rejected.
    BOOL fRejected;
}

struct CookieDecision
{
    uint dwCookieState;
    BOOL fAllowSession;
}

///<p class="CCE_Message">[The <b>GOPHER_FIND_DATA</b> structure is available for use in the operating systems specified
///in the Requirements section.] Contains information retrieved by the GopherFindFirstFile and InternetFindNextFile
///functions.
struct GOPHER_FIND_DATAA
{
    ///Friendly name of an object. An application can display this string to allow the user to select the object.
    byte[129] DisplayString;
    ///Describes the item returned. This parameter can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_ASK"></a><a id="gopher_type_ask"></a><dl>
    ///<dt><b>GOPHER_TYPE_ASK</b></dt> </dl> </td> <td width="60%"> Ask+ item. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_BINARY"></a><a id="gopher_type_binary"></a><dl> <dt><b>GOPHER_TYPE_BINARY</b></dt> </dl> </td>
    ///<td width="60%"> Binary file. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_BITMAP"></a><a
    ///id="gopher_type_bitmap"></a><dl> <dt><b>GOPHER_TYPE_BITMAP</b></dt> </dl> </td> <td width="60%"> Bitmap file.
    ///</td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_CALENDAR"></a><a id="gopher_type_calendar"></a><dl>
    ///<dt><b>GOPHER_TYPE_CALENDAR</b></dt> </dl> </td> <td width="60%"> Calendar file. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_CSO"></a><a id="gopher_type_cso"></a><dl> <dt><b>GOPHER_TYPE_CSO</b></dt> </dl>
    ///</td> <td width="60%"> CSO telephone book server. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_DIRECTORY"></a><a id="gopher_type_directory"></a><dl> <dt><b>GOPHER_TYPE_DIRECTORY</b></dt> </dl>
    ///</td> <td width="60%"> Directory of additional Gopher items. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_DOS_ARCHIVE"></a><a id="gopher_type_dos_archive"></a><dl> <dt><b>GOPHER_TYPE_DOS_ARCHIVE</b></dt>
    ///</dl> </td> <td width="60%"> MS-DOS archive file. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_ERROR"></a><a id="gopher_type_error"></a><dl> <dt><b>GOPHER_TYPE_ERROR</b></dt> </dl> </td> <td
    ///width="60%"> Indicator of an error condition. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_GIF"></a><a
    ///id="gopher_type_gif"></a><dl> <dt><b>GOPHER_TYPE_GIF</b></dt> </dl> </td> <td width="60%"> GIF graphics file.
    ///</td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_GOPHER_PLUS"></a><a id="gopher_type_gopher_plus"></a><dl>
    ///<dt><b>GOPHER_TYPE_GOPHER_PLUS</b></dt> </dl> </td> <td width="60%"> Gopher+ item. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_HTML"></a><a id="gopher_type_html"></a><dl> <dt><b>GOPHER_TYPE_HTML</b></dt> </dl>
    ///</td> <td width="60%"> HTML document. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_IMAGE"></a><a
    ///id="gopher_type_image"></a><dl> <dt><b>GOPHER_TYPE_IMAGE</b></dt> </dl> </td> <td width="60%"> Image file. </td>
    ///</tr> <tr> <td width="40%"><a id="GOPHER_TYPE_INDEX_SERVER"></a><a id="gopher_type_index_server"></a><dl>
    ///<dt><b>GOPHER_TYPE_INDEX_SERVER</b></dt> </dl> </td> <td width="60%"> Index server. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_INLINE"></a><a id="gopher_type_inline"></a><dl> <dt><b>GOPHER_TYPE_INLINE</b></dt>
    ///</dl> </td> <td width="60%"> Inline file. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_MAC_BINHEX"></a><a
    ///id="gopher_type_mac_binhex"></a><dl> <dt><b>GOPHER_TYPE_MAC_BINHEX</b></dt> </dl> </td> <td width="60%">
    ///Macintosh file in BINHEX format. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_MOVIE"></a><a
    ///id="gopher_type_movie"></a><dl> <dt><b>GOPHER_TYPE_MOVIE</b></dt> </dl> </td> <td width="60%"> Movie file. </td>
    ///</tr> <tr> <td width="40%"><a id="GOPHER_TYPE_PDF"></a><a id="gopher_type_pdf"></a><dl>
    ///<dt><b>GOPHER_TYPE_PDF</b></dt> </dl> </td> <td width="60%"> PDF file. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_REDUNDANT"></a><a id="gopher_type_redundant"></a><dl> <dt><b>GOPHER_TYPE_REDUNDANT</b></dt> </dl>
    ///</td> <td width="60%"> Indicator of a duplicated server. The information contained within is a duplicate of the
    ///primary server. The primary server is defined as the last directory entry that did not have a
    ///GOPHER_TYPE_REDUNDANT type. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_SOUND"></a><a
    ///id="gopher_type_sound"></a><dl> <dt><b>GOPHER_TYPE_SOUND</b></dt> </dl> </td> <td width="60%"> Sound file. </td>
    ///</tr> <tr> <td width="40%"><a id="GOPHER_TYPE_TELNET"></a><a id="gopher_type_telnet"></a><dl>
    ///<dt><b>GOPHER_TYPE_TELNET</b></dt> </dl> </td> <td width="60%"> Telnet server. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_TEXT_FILE"></a><a id="gopher_type_text_file"></a><dl>
    ///<dt><b>GOPHER_TYPE_TEXT_FILE</b></dt> </dl> </td> <td width="60%"> ASCII text file. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_TN3270"></a><a id="gopher_type_tn3270"></a><dl> <dt><b>GOPHER_TYPE_TN3270</b></dt>
    ///</dl> </td> <td width="60%"> TN3270 server. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_UNIX_UUENCODED"></a><a id="gopher_type_unix_uuencoded"></a><dl>
    ///<dt><b>GOPHER_TYPE_UNIX_UUENCODED</b></dt> </dl> </td> <td width="60%"> UUENCODED file. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_UNKNOWN"></a><a id="gopher_type_unknown"></a><dl>
    ///<dt><b>GOPHER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%"> Item type is unknown. </td> </tr> </table>
    uint      GopherType;
    ///Low 32 bits of the file size.
    uint      SizeLow;
    ///High 32 bits of the file size.
    uint      SizeHigh;
    ///FILETIME structure that contains the time when the file was last modified.
    FILETIME  LastModificationTime;
    ///File locator. An application can pass the locator string to GopherOpenFile or GopherFindFirstFile.
    byte[654] Locator;
}

///<p class="CCE_Message">[The <b>GOPHER_FIND_DATA</b> structure is available for use in the operating systems specified
///in the Requirements section.] Contains information retrieved by the GopherFindFirstFile and InternetFindNextFile
///functions.
struct GOPHER_FIND_DATAW
{
    ///Friendly name of an object. An application can display this string to allow the user to select the object.
    ushort[129] DisplayString;
    ///Describes the item returned. This parameter can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_ASK"></a><a id="gopher_type_ask"></a><dl>
    ///<dt><b>GOPHER_TYPE_ASK</b></dt> </dl> </td> <td width="60%"> Ask+ item. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_BINARY"></a><a id="gopher_type_binary"></a><dl> <dt><b>GOPHER_TYPE_BINARY</b></dt> </dl> </td>
    ///<td width="60%"> Binary file. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_BITMAP"></a><a
    ///id="gopher_type_bitmap"></a><dl> <dt><b>GOPHER_TYPE_BITMAP</b></dt> </dl> </td> <td width="60%"> Bitmap file.
    ///</td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_CALENDAR"></a><a id="gopher_type_calendar"></a><dl>
    ///<dt><b>GOPHER_TYPE_CALENDAR</b></dt> </dl> </td> <td width="60%"> Calendar file. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_CSO"></a><a id="gopher_type_cso"></a><dl> <dt><b>GOPHER_TYPE_CSO</b></dt> </dl>
    ///</td> <td width="60%"> CSO telephone book server. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_DIRECTORY"></a><a id="gopher_type_directory"></a><dl> <dt><b>GOPHER_TYPE_DIRECTORY</b></dt> </dl>
    ///</td> <td width="60%"> Directory of additional Gopher items. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_DOS_ARCHIVE"></a><a id="gopher_type_dos_archive"></a><dl> <dt><b>GOPHER_TYPE_DOS_ARCHIVE</b></dt>
    ///</dl> </td> <td width="60%"> MS-DOS archive file. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_ERROR"></a><a id="gopher_type_error"></a><dl> <dt><b>GOPHER_TYPE_ERROR</b></dt> </dl> </td> <td
    ///width="60%"> Indicator of an error condition. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_GIF"></a><a
    ///id="gopher_type_gif"></a><dl> <dt><b>GOPHER_TYPE_GIF</b></dt> </dl> </td> <td width="60%"> GIF graphics file.
    ///</td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_GOPHER_PLUS"></a><a id="gopher_type_gopher_plus"></a><dl>
    ///<dt><b>GOPHER_TYPE_GOPHER_PLUS</b></dt> </dl> </td> <td width="60%"> Gopher+ item. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_HTML"></a><a id="gopher_type_html"></a><dl> <dt><b>GOPHER_TYPE_HTML</b></dt> </dl>
    ///</td> <td width="60%"> HTML document. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_IMAGE"></a><a
    ///id="gopher_type_image"></a><dl> <dt><b>GOPHER_TYPE_IMAGE</b></dt> </dl> </td> <td width="60%"> Image file. </td>
    ///</tr> <tr> <td width="40%"><a id="GOPHER_TYPE_INDEX_SERVER"></a><a id="gopher_type_index_server"></a><dl>
    ///<dt><b>GOPHER_TYPE_INDEX_SERVER</b></dt> </dl> </td> <td width="60%"> Index server. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_INLINE"></a><a id="gopher_type_inline"></a><dl> <dt><b>GOPHER_TYPE_INLINE</b></dt>
    ///</dl> </td> <td width="60%"> Inline file. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_MAC_BINHEX"></a><a
    ///id="gopher_type_mac_binhex"></a><dl> <dt><b>GOPHER_TYPE_MAC_BINHEX</b></dt> </dl> </td> <td width="60%">
    ///Macintosh file in BINHEX format. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_MOVIE"></a><a
    ///id="gopher_type_movie"></a><dl> <dt><b>GOPHER_TYPE_MOVIE</b></dt> </dl> </td> <td width="60%"> Movie file. </td>
    ///</tr> <tr> <td width="40%"><a id="GOPHER_TYPE_PDF"></a><a id="gopher_type_pdf"></a><dl>
    ///<dt><b>GOPHER_TYPE_PDF</b></dt> </dl> </td> <td width="60%"> PDF file. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_REDUNDANT"></a><a id="gopher_type_redundant"></a><dl> <dt><b>GOPHER_TYPE_REDUNDANT</b></dt> </dl>
    ///</td> <td width="60%"> Indicator of a duplicated server. The information contained within is a duplicate of the
    ///primary server. The primary server is defined as the last directory entry that did not have a
    ///GOPHER_TYPE_REDUNDANT type. </td> </tr> <tr> <td width="40%"><a id="GOPHER_TYPE_SOUND"></a><a
    ///id="gopher_type_sound"></a><dl> <dt><b>GOPHER_TYPE_SOUND</b></dt> </dl> </td> <td width="60%"> Sound file. </td>
    ///</tr> <tr> <td width="40%"><a id="GOPHER_TYPE_TELNET"></a><a id="gopher_type_telnet"></a><dl>
    ///<dt><b>GOPHER_TYPE_TELNET</b></dt> </dl> </td> <td width="60%"> Telnet server. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_TEXT_FILE"></a><a id="gopher_type_text_file"></a><dl>
    ///<dt><b>GOPHER_TYPE_TEXT_FILE</b></dt> </dl> </td> <td width="60%"> ASCII text file. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_TN3270"></a><a id="gopher_type_tn3270"></a><dl> <dt><b>GOPHER_TYPE_TN3270</b></dt>
    ///</dl> </td> <td width="60%"> TN3270 server. </td> </tr> <tr> <td width="40%"><a
    ///id="GOPHER_TYPE_UNIX_UUENCODED"></a><a id="gopher_type_unix_uuencoded"></a><dl>
    ///<dt><b>GOPHER_TYPE_UNIX_UUENCODED</b></dt> </dl> </td> <td width="60%"> UUENCODED file. </td> </tr> <tr> <td
    ///width="40%"><a id="GOPHER_TYPE_UNKNOWN"></a><a id="gopher_type_unknown"></a><dl>
    ///<dt><b>GOPHER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%"> Item type is unknown. </td> </tr> </table>
    uint        GopherType;
    ///Low 32 bits of the file size.
    uint        SizeLow;
    ///High 32 bits of the file size.
    uint        SizeHigh;
    ///FILETIME structure that contains the time when the file was last modified.
    FILETIME    LastModificationTime;
    ///File locator. An application can pass the locator string to GopherOpenFile or GopherFindFirstFile.
    ushort[654] Locator;
}

struct GOPHER_ADMIN_ATTRIBUTE_TYPE
{
    byte* Comment;
    byte* EmailAddress;
}

struct GOPHER_MOD_DATE_ATTRIBUTE_TYPE
{
    FILETIME DateAndTime;
}

struct GOPHER_TTL_ATTRIBUTE_TYPE
{
    uint Ttl;
}

struct GOPHER_SCORE_ATTRIBUTE_TYPE
{
    int Score;
}

struct GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE
{
    int LowerBound;
    int UpperBound;
}

struct GOPHER_SITE_ATTRIBUTE_TYPE
{
    byte* Site;
}

struct GOPHER_ORGANIZATION_ATTRIBUTE_TYPE
{
    byte* Organization;
}

struct GOPHER_LOCATION_ATTRIBUTE_TYPE
{
    byte* Location;
}

struct GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE
{
    int DegreesNorth;
    int MinutesNorth;
    int SecondsNorth;
    int DegreesEast;
    int MinutesEast;
    int SecondsEast;
}

struct GOPHER_TIMEZONE_ATTRIBUTE_TYPE
{
    int Zone;
}

struct GOPHER_PROVIDER_ATTRIBUTE_TYPE
{
    byte* Provider;
}

struct GOPHER_VERSION_ATTRIBUTE_TYPE
{
    byte* Version;
}

struct GOPHER_ABSTRACT_ATTRIBUTE_TYPE
{
    byte* ShortAbstract;
    byte* AbstractFile;
}

struct GOPHER_VIEW_ATTRIBUTE_TYPE
{
    byte* ContentType;
    byte* Language;
    uint  Size;
}

struct GOPHER_VERONICA_ATTRIBUTE_TYPE
{
    BOOL TreeWalk;
}

struct GOPHER_ASK_ATTRIBUTE_TYPE
{
    byte* QuestionType;
    byte* QuestionText;
}

struct GOPHER_UNKNOWN_ATTRIBUTE_TYPE
{
    byte* Text;
}

///<p class="CCE_Message">[The <b>GOPHER_ATTRIBUTE_TYPE</b> structure is available for use in the operating systems
///specified in the Requirements section.] Contains the relevant information of a single Gopher attribute for an object.
struct GOPHER_ATTRIBUTE_TYPE
{
    ///Name of the Gopher category for the attribute. The possible values include: <a
    ///id="GOPHER_CATEGORY_ID_ABSTRACT"></a> <a id="gopher_category_id_abstract"></a>
    uint CategoryId;
    ///Attribute type. The possible values include: <a id="GOPHER_ATTRIBUTE_ID_ABSTRACT"></a> <a
    ///id="gopher_attribute_id_abstract"></a>
    uint AttributeId;
union AttributeType
    {
        GOPHER_ADMIN_ATTRIBUTE_TYPE Admin;
        GOPHER_MOD_DATE_ATTRIBUTE_TYPE ModDate;
        GOPHER_TTL_ATTRIBUTE_TYPE Ttl;
        GOPHER_SCORE_ATTRIBUTE_TYPE Score;
        GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE ScoreRange;
        GOPHER_SITE_ATTRIBUTE_TYPE Site;
        GOPHER_ORGANIZATION_ATTRIBUTE_TYPE Organization;
        GOPHER_LOCATION_ATTRIBUTE_TYPE Location;
        GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE GeographicalLocation;
        GOPHER_TIMEZONE_ATTRIBUTE_TYPE TimeZone;
        GOPHER_PROVIDER_ATTRIBUTE_TYPE Provider;
        GOPHER_VERSION_ATTRIBUTE_TYPE Version;
        GOPHER_ABSTRACT_ATTRIBUTE_TYPE Abstract;
        GOPHER_VIEW_ATTRIBUTE_TYPE View;
        GOPHER_VERONICA_ATTRIBUTE_TYPE Veronica;
        GOPHER_ASK_ATTRIBUTE_TYPE Ask;
        GOPHER_UNKNOWN_ATTRIBUTE_TYPE Unknown;
    }
}

///The **INTERNET\_COOKIE2** contains the constituent parts of a cookie. This structure is used with the
///[InternetGetCookieEx2](nf-wininet-internetgetcookieex2.md) and
///[InternetSetCookieEx2](nf-wininet-internetsetcookieex2.md) functions.
struct INTERNET_COOKIE2
{
    ///Pointer to a string containing the cookie name. May be NULL if value is not NULL.
    PWSTR    pwszName;
    ///Pointer to a string containing the cookie value. May be NULL if name is not NULL.
    PWSTR    pwszValue;
    ///Pointer to a string containing the cookie domain. May be NULL.
    PWSTR    pwszDomain;
    ///Pointer to a string containing the cookie path. May be NULL.
    PWSTR    pwszPath;
    ///Flags for additional cookie details. The following flags are available. | Value | Meaning | |-------|---------| |
    ///INTERNET_COOKIE_IS_SECURE | This is a secure cookie. | | INTERNET_COOKIE_IS_SESSION | This is a session cookie. |
    ///| INTERNET_COOKIE_IS_RESTRICTED | This cookie is restricted to first-party contexts. | | INTERNET_COOKIE_HTTPONLY
    ///| This is an HTTP-only cookie. | | INTERNET_COOKIE_HOST_ONLY | This is a host-only cookie. | |
    ///INTERNET_COOKIE_HOST_ONLY_APPLIED | The host-only setting has been applied to this cookie. | |
    ///INTERNET_COOKIE_SAME_SITE_STRICT | The SameSite security level for this cookie is "strict". | |
    ///INTERNET_COOKIE_SAME_SITE_LAX | The SameSite security level for this cookie is "lax". |
    uint     dwFlags;
    ///The expiry time of the cookie.
    FILETIME ftExpires;
    ///Whether or not the expiry time is set.
    BOOL     fExpiresSet;
}

///Contains the notification data for an authentication request.
struct INTERNET_AUTH_NOTIFY_DATA
{
    ///Size of the structure, in bytes.
    uint            cbStruct;
    uint            dwOptions;
    ///Notification callback to retry InternetErrorDlg.
    PFN_AUTH_NOTIFY pfnNotify;
    ///Pointer to a variable that contains an application-defined value used to identify the application context to pass
    ///to the notification function.
    size_t          dwContext;
}

///Contains information about an entry in the Internet cache.
struct INTERNET_CACHE_ENTRY_INFOA
{
    ///Size of this structure, in bytes. This value can be used to help determine the version of the cache system.
    uint     dwStructSize;
    ///Pointer to a null-terminated string that contains the URL name. The string occupies the memory area at the end of
    ///this structure.
    PSTR     lpszSourceUrlName;
    ///Pointer to a null-terminated string that contains the local file name. The string occupies the memory area at the
    ///end of this structure.
    PSTR     lpszLocalFileName;
    ///A bitmask indicating the type of cache entry and its properties. The cache entry types include: history entries
    ///(URLHISTORY_CACHE_ENTRY), cookie entries (COOKIE_CACHE_ENTRY), and normal cached content (NORMAL_CACHE_ENTRY).
    ///This member can be zero or more of the following property flags, and cache type flags listed below. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EDITED_CACHE_ENTRY"></a><a
    ///id="edited_cache_entry"></a><dl> <dt><b>EDITED_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Cache entry file
    ///that has been edited externally. This cache entry type is exempt from scavenging. </td> </tr> <tr> <td
    ///width="40%"><a id="SPARSE_CACHE_ENTRY"></a><a id="sparse_cache_entry"></a><dl> <dt><b>SPARSE_CACHE_ENTRY</b></dt>
    ///</dl> </td> <td width="60%"> Partial response cache entry. </td> </tr> <tr> <td width="40%"><a
    ///id="STICKY_CACHE_ENTRY"></a><a id="sticky_cache_entry"></a><dl> <dt><b>STICKY_CACHE_ENTRY</b></dt> </dl> </td>
    ///<td width="60%"> Sticky cache entry that is exempt from scavenging for the amount of time specified by
    ///<b>dwExemptDelta</b>. The default value set by CommitUrlCacheEntryA and CommitUrlCacheEntryW is one day. </td>
    ///</tr> <tr> <td width="40%"><a id="TRACK_OFFLINE_CACHE_ENTRY"></a><a id="track_offline_cache_entry"></a><dl>
    ///<dt><b>TRACK_OFFLINE_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Not currently implemented. </td> </tr>
    ///<tr> <td width="40%"><a id="TRACK_ONLINE_CACHE_ENTRY"></a><a id="track_online_cache_entry"></a><dl>
    ///<dt><b>TRACK_ONLINE_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Not currently implemented. </td> </tr>
    ///</table> The following list contains the cache type flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="COOKIE_CACHE_ENTRY"></a><a id="cookie_cache_entry"></a><dl>
    ///<dt><b>COOKIE_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Cookie cache entry. </td> </tr> <tr> <td
    ///width="40%"><a id="NORMAL_CACHE_ENTRY"></a><a id="normal_cache_entry"></a><dl> <dt><b>NORMAL_CACHE_ENTRY</b></dt>
    ///</dl> </td> <td width="60%"> Normal cache entry; can be deleted to recover space for new entries. </td> </tr>
    ///<tr> <td width="40%"><a id="URLHISTORY_CACHE_ENTRY"></a><a id="urlhistory_cache_entry"></a><dl>
    ///<dt><b>URLHISTORY_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Visited link cache entry. </td> </tr>
    ///</table>
    uint     CacheEntryType;
    ///Current number of WinINEet callers using the cache entry.
    uint     dwUseCount;
    ///Number of times the cache entry was retrieved.
    uint     dwHitRate;
    ///Low-order portion of the file size, in <b>bytes</b>.
    uint     dwSizeLow;
    ///High-order portion of the file size, in <b>bytes</b>.
    uint     dwSizeHigh;
    ///FILETIME structure that contains the last modified time of this URL, in Greenwich mean time format.
    FILETIME LastModifiedTime;
    ///FILETIME structure that contains the expiration time of this file, in Greenwich mean time format.
    FILETIME ExpireTime;
    ///FILETIME structure that contains the last accessed time, in Greenwich mean time format.
    FILETIME LastAccessTime;
    ///FILETIME structure that contains the last time the cache was synchronized.
    FILETIME LastSyncTime;
    ///Pointer to a buffer that contains the header information. The buffer occupies the memory at the end of this
    ///structure.
    PSTR     lpHeaderInfo;
    ///Size of the <b>lpHeaderInfo</b> buffer, in <b>TCHARs</b>.
    uint     dwHeaderInfoSize;
    ///Pointer to a string that contains the file name extension used to retrieve the data as a file. The string
    ///occupies the memory area at the end of this structure.
    PSTR     lpszFileExtension;
union
    {
        uint dwReserved;
        uint dwExemptDelta;
    }
}

///Contains information about an entry in the Internet cache.
struct INTERNET_CACHE_ENTRY_INFOW
{
    ///Size of this structure, in bytes. This value can be used to help determine the version of the cache system.
    uint     dwStructSize;
    ///Pointer to a null-terminated string that contains the URL name. The string occupies the memory area at the end of
    ///this structure.
    PWSTR    lpszSourceUrlName;
    ///Pointer to a null-terminated string that contains the local file name. The string occupies the memory area at the
    ///end of this structure.
    PWSTR    lpszLocalFileName;
    ///A bitmask indicating the type of cache entry and its properties. The cache entry types include: history entries
    ///(URLHISTORY_CACHE_ENTRY), cookie entries (COOKIE_CACHE_ENTRY), and normal cached content (NORMAL_CACHE_ENTRY).
    ///This member can be zero or more of the following property flags, and cache type flags listed below. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EDITED_CACHE_ENTRY"></a><a
    ///id="edited_cache_entry"></a><dl> <dt><b>EDITED_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Cache entry file
    ///that has been edited externally. This cache entry type is exempt from scavenging. </td> </tr> <tr> <td
    ///width="40%"><a id="SPARSE_CACHE_ENTRY"></a><a id="sparse_cache_entry"></a><dl> <dt><b>SPARSE_CACHE_ENTRY</b></dt>
    ///</dl> </td> <td width="60%"> Partial response cache entry. </td> </tr> <tr> <td width="40%"><a
    ///id="STICKY_CACHE_ENTRY"></a><a id="sticky_cache_entry"></a><dl> <dt><b>STICKY_CACHE_ENTRY</b></dt> </dl> </td>
    ///<td width="60%"> Sticky cache entry that is exempt from scavenging for the amount of time specified by
    ///<b>dwExemptDelta</b>. The default value set by CommitUrlCacheEntryA and CommitUrlCacheEntryW is one day. </td>
    ///</tr> <tr> <td width="40%"><a id="TRACK_OFFLINE_CACHE_ENTRY"></a><a id="track_offline_cache_entry"></a><dl>
    ///<dt><b>TRACK_OFFLINE_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Not currently implemented. </td> </tr>
    ///<tr> <td width="40%"><a id="TRACK_ONLINE_CACHE_ENTRY"></a><a id="track_online_cache_entry"></a><dl>
    ///<dt><b>TRACK_ONLINE_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Not currently implemented. </td> </tr>
    ///</table> The following list contains the cache type flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="COOKIE_CACHE_ENTRY"></a><a id="cookie_cache_entry"></a><dl>
    ///<dt><b>COOKIE_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Cookie cache entry. </td> </tr> <tr> <td
    ///width="40%"><a id="NORMAL_CACHE_ENTRY"></a><a id="normal_cache_entry"></a><dl> <dt><b>NORMAL_CACHE_ENTRY</b></dt>
    ///</dl> </td> <td width="60%"> Normal cache entry; can be deleted to recover space for new entries. </td> </tr>
    ///<tr> <td width="40%"><a id="URLHISTORY_CACHE_ENTRY"></a><a id="urlhistory_cache_entry"></a><dl>
    ///<dt><b>URLHISTORY_CACHE_ENTRY</b></dt> </dl> </td> <td width="60%"> Visited link cache entry. </td> </tr>
    ///</table>
    uint     CacheEntryType;
    ///Current number of WinINEet callers using the cache entry.
    uint     dwUseCount;
    ///Number of times the cache entry was retrieved.
    uint     dwHitRate;
    ///Low-order portion of the file size, in <b>bytes</b>.
    uint     dwSizeLow;
    ///High-order portion of the file size, in <b>bytes</b>.
    uint     dwSizeHigh;
    ///FILETIME structure that contains the last modified time of this URL, in Greenwich mean time format.
    FILETIME LastModifiedTime;
    ///FILETIME structure that contains the expiration time of this file, in Greenwich mean time format.
    FILETIME ExpireTime;
    ///FILETIME structure that contains the last accessed time, in Greenwich mean time format.
    FILETIME LastAccessTime;
    ///FILETIME structure that contains the last time the cache was synchronized.
    FILETIME LastSyncTime;
    ///Pointer to a buffer that contains the header information. The buffer occupies the memory at the end of this
    ///structure.
    PWSTR    lpHeaderInfo;
    ///Size of the <b>lpHeaderInfo</b> buffer, in <b>TCHARs</b>.
    uint     dwHeaderInfoSize;
    ///Pointer to a string that contains the file name extension used to retrieve the data as a file. The string
    ///occupies the memory area at the end of this structure.
    PWSTR    lpszFileExtension;
union
    {
        uint dwReserved;
        uint dwExemptDelta;
    }
}

///Contains the LastModified and Expire times for a resource stored in the Internet cache.
struct INTERNET_CACHE_TIMESTAMPS
{
    ///FILETIME structure that contains the Expires time.
    FILETIME ftExpires;
    ///FILETIME structure that contains the LastModified time.
    FILETIME ftLastModified;
}

///Contains the information for a particular cache group.
struct INTERNET_CACHE_GROUP_INFOA
{
    ///Size of the structure, <b>TCHARs</b>.
    uint      dwGroupSize;
    ///Group flags. Currently, the only value defined is CACHEGROUP_FLAG_NONPURGEABLE, which indicates that the cache
    ///entries in this group will not be removed by the cache manager.
    uint      dwGroupFlags;
    ///Group type. Currently, the only value defined is CACHEGROUP_TYPE_INVALID.
    uint      dwGroupType;
    ///Current disk usage of this cache group, in kilobytes.
    uint      dwDiskUsage;
    ///Disk quota for this cache group, in kilobytes.
    uint      dwDiskQuota;
    ///Array that can be used by a client application to store information related to the group.
    uint[4]   dwOwnerStorage;
    ///Group name.
    byte[120] szGroupName;
}

///Contains the information for a particular cache group.
struct INTERNET_CACHE_GROUP_INFOW
{
    ///Size of the structure, <b>TCHARs</b>.
    uint        dwGroupSize;
    ///Group flags. Currently, the only value defined is CACHEGROUP_FLAG_NONPURGEABLE, which indicates that the cache
    ///entries in this group will not be removed by the cache manager.
    uint        dwGroupFlags;
    ///Group type. Currently, the only value defined is CACHEGROUP_TYPE_INVALID.
    uint        dwGroupType;
    ///Current disk usage of this cache group, in kilobytes.
    uint        dwDiskUsage;
    ///Disk quota for this cache group, in kilobytes.
    uint        dwDiskQuota;
    ///Array that can be used by a client application to store information related to the group.
    uint[4]     dwOwnerStorage;
    ///Group name.
    ushort[120] szGroupName;
}

///The <b>AutoProxyHelperVtbl</b> structure creates a v-table of pointers to Proxy AutoConfig (PAC) helper functions.
///See the Navigator Proxy Auto-Config (PAC) File Format documentation for a specification of the form and use of Proxy
///Auto-Config helper functions.
struct AutoProxyHelperVtbl
{
    ///Tries to resolve a specified host name. This PAC function is described in the specification under the same name.
    ///Returns <b>TRUE</b> if the host name can be resolved, or <b>FALSE</b> otherwise.
    BOOL********** IsResolvable;
    ///Places the IP address of the local machine in a specified buffer. This PAC functions is described in the
    ///specification under the name <b>myIPAddress</b>. Returns zero if successful, or an error code if not.
    ptrdiff_t      GetIPAddress;
    ///Places an IP address that corresponds to a host-name string in a specified buffer. This PAC function is described
    ///in the specification under the name, <b>dnsResolve</b>. Returns <b>TRUE</b> if successful, or <b>FALSE</b>
    ///otherwise.
    ptrdiff_t      ResolveHostName;
    ///Determines whether a specified IP address masked by a specified mask value matches a specified destination
    ///address. This PAC function is described in the specification under the same name. The comparison is performed by
    ///converting the string representations to binary, logically ANDing the mask and the address specified in
    ///<i>lpszIPAddress</i>, and comparing the result with the address specified in <i>lpszDest</i>.
    BOOL********** IsInNet;
    ///Tries to resolve a specified host name. This PAC function is described in the specification under the same name.
    ///Returns <b>TRUE</b> if the host name can be resolved, or <b>FALSE</b> otherwise. <b>Windows XP and earlier:
    ///</b>Available only in Windows XP with SP2 with Internet Explorer 7. Otherwise, not available.
    BOOL********** IsResolvableEx;
    ///Places the IP address of the local machine in a specified buffer. This PAC functions is described in the
    ///specification under the name <b>myIPAddress</b>. Returns zero if successful, or an error code if not. <b>Windows
    ///XP and earlier: </b>Available only in Windows XP with SP2 with Internet Explorer 7. Otherwise, not available.
    ptrdiff_t      GetIPAddressEx;
    ///Places an IP address that corresponds to a host-name string in a specified buffer. This PAC function is described
    ///in the specification under the name, <b>dnsResolve</b>. Returns <b>TRUE</b> if successful, or <b>FALSE</b>
    ///otherwise. <b>Windows XP and earlier: </b>Available only in Windows XP with SP2 with Internet Explorer 7.
    ///Otherwise, not available.
    ptrdiff_t      ResolveHostNameEx;
    ///Determines whether a specified IP address masked by a specified mask value matches a specified destination
    ///address. This PAC function is described in the specification under the same name. <b>Windows XP and earlier:
    ///</b>Available only in Windows XP with SP2 with Internet Explorer 7. Otherwise, not available.
    BOOL********** IsInNetEx;
    ///Sorts a list of IP addresses. <b>Windows XP and earlier: </b>Available only in Windows XP with SP2 with Internet
    ///Explorer 7. Otherwise, not available.
    ptrdiff_t      SortIpList;
}

///The <b>AUTO_PROXY_SCRIPT_BUFFER</b> structure is used to pass an autoproxy script in a buffer to
///InternetInitializeAutoProxyDll , instead of identifying a file that <b>InternetInitializeAutoProxyDll</b> opens.
struct AUTO_PROXY_SCRIPT_BUFFER
{
    ///Size of this structure. Always set to "sizeof(AUTO_PROXY_SCRIPT_BUFFER)".
    uint dwStructSize;
    ///Pointer to the script buffer being passed using this structure.
    PSTR lpszScriptBuffer;
    ///Size of the script buffer pointed to by <b>lpszScriptBuffer</b>.
    uint dwScriptBufferSize;
}

///The <b>AutoProxyHelperFunctions</b> structure is used to create a v-table of Proxy Auto-Config (PAC) functions that
///can be passed to InternetInitializeAutoProxyDll. See the Navigator Proxy Auto-Config (PAC) File Format documentation
///for a specification of the form and use of Proxy Auto-Config helper functions.
struct AutoProxyHelperFunctions
{
    ///Pointer to an AutoProxyHelperVtbl structure that contains an array of pointers to autoproxy helper functions.
    const(AutoProxyHelperVtbl)* lpVtbl;
}

struct INTERNET_PREFETCH_STATUS
{
    uint dwStatus;
    uint dwSize;
}

struct INTERNET_SECURITY_INFO
{
    uint                dwSize;
    CERT_CONTEXT*       pCertificate;
    CERT_CHAIN_CONTEXT* pcCertChain;
    SecPkgContext_ConnectionInfo connectionInfo;
    SecPkgContext_CipherInfo cipherInfo;
    CERT_CHAIN_CONTEXT* pcUnverifiedCertChain;
    SecPkgContext_Bindings channelBindingToken;
}

struct INTERNET_SECURITY_CONNECTION_INFO
{
    uint dwSize;
    BOOL fSecure;
    SecPkgContext_ConnectionInfo connectionInfo;
    SecPkgContext_CipherInfo cipherInfo;
}

struct INTERNET_DOWNLOAD_MODE_HANDLE
{
    const(PWSTR) pcwszFileName;
    HANDLE*      phFile;
}

struct HTTP_REQUEST_TIMES
{
    uint      cTimes;
    ulong[32] rgTimes;
}

struct INTERNET_SERVER_CONNECTION_STATE
{
    const(PWSTR) lpcwszHostName;
    BOOL         fProxy;
    uint         dwCounter;
    uint         dwConnectionLimit;
    uint         dwAvailableCreates;
    uint         dwAvailableKeepAlives;
    uint         dwActiveConnections;
    uint         dwWaiters;
}

struct INTERNET_END_BROWSER_SESSION_DATA
{
    void* lpBuffer;
    uint  dwBufferLength;
}

struct INTERNET_CALLBACK_COOKIE
{
    const(PWSTR) pcwszName;
    const(PWSTR) pcwszValue;
    const(PWSTR) pcwszDomain;
    const(PWSTR) pcwszPath;
    FILETIME     ftExpires;
    uint         dwFlags;
}

struct INTERNET_CREDENTIALS
{
    const(PWSTR) lpcwszHostName;
    uint         dwPort;
    uint         dwScheme;
    const(PWSTR) lpcwszUrl;
    const(PWSTR) lpcwszRealm;
    BOOL         fAuthIdentity;
union
    {
struct
        {
            const(PWSTR) lpcwszUserName;
            const(PWSTR) lpcwszPassword;
        }
        void* pAuthIdentityOpaque;
    }
}

struct HTTP_PUSH_WAIT_HANDLE__
{
    int unused;
}

struct HTTP_PUSH_TRANSPORT_SETTING
{
    GUID TransportSettingId;
    GUID BrokerEventId;
}

struct HTTP_PUSH_NOTIFICATION_STATUS
{
    BOOL ChannelStatusValid;
    uint ChannelStatus;
}

struct INTERNET_COOKIE
{
    uint      cbSize;
    PSTR      pszName;
    PSTR      pszData;
    PSTR      pszDomain;
    PSTR      pszPath;
    FILETIME* pftExpires;
    uint      dwFlags;
    PSTR      pszUrl;
    PSTR      pszP3PPolicy;
}

struct COOKIE_DLG_INFO
{
    PWSTR            pszServer;
    INTERNET_COOKIE* pic;
    uint             dwStopWarning;
    int              cx;
    int              cy;
    PWSTR            pszHeader;
    uint             dwOperation;
}

struct INTERNET_CACHE_CONFIG_PATH_ENTRYA
{
    byte[260] CachePath;
    uint      dwCacheSize;
}

struct INTERNET_CACHE_CONFIG_PATH_ENTRYW
{
    ushort[260] CachePath;
    uint        dwCacheSize;
}

///Contains information about the configuration of the Internet cache.
struct INTERNET_CACHE_CONFIG_INFOA
{
    ///Size of this structure, in bytes. This value can be used to help determine the version of the cache system.
    uint dwStructSize;
    ///The container that the rest of the data in the struct applies to. 0 (zero) indicates the content container.
    uint dwContainer;
    ///The cache quota limit of the container specified in kilobytes.
    uint dwQuota;
    ///Reserved.
    uint dwReserved4;
    ///Reserved.
    BOOL fPerUser;
    ///Reserved.
    uint dwSyncMode;
    ///Reserved.
    uint dwNumCachePaths;
union
    {
struct
        {
            byte[260] CachePath;
            uint      dwCacheSize;
        }
        INTERNET_CACHE_CONFIG_PATH_ENTRYA[1] CachePaths;
    }
    ///The cache size of the container specified in kilobytes.
    uint dwNormalUsage;
    ///The number of kilobytes for this container exempt from scavenging.
    uint dwExemptUsage;
}

///Contains information about the configuration of the Internet cache.
struct INTERNET_CACHE_CONFIG_INFOW
{
    ///Size of this structure, in bytes. This value can be used to help determine the version of the cache system.
    uint dwStructSize;
    ///The container that the rest of the data in the struct applies to. 0 (zero) indicates the content container.
    uint dwContainer;
    ///The cache quota limit of the container specified in kilobytes.
    uint dwQuota;
    ///Reserved.
    uint dwReserved4;
    ///Reserved.
    BOOL fPerUser;
    ///Reserved.
    uint dwSyncMode;
    ///Reserved.
    uint dwNumCachePaths;
union
    {
struct
        {
            ushort[260] CachePath;
            uint        dwCacheSize;
        }
        INTERNET_CACHE_CONFIG_PATH_ENTRYW[1] CachePaths;
    }
    ///The cache size of the container specified in kilobytes.
    uint dwNormalUsage;
    ///The number of kilobytes for this container exempt from scavenging.
    uint dwExemptUsage;
}

struct INTERNET_CACHE_CONTAINER_INFOA
{
    uint dwCacheVersion;
    PSTR lpszName;
    PSTR lpszCachePrefix;
    PSTR lpszVolumeLabel;
    PSTR lpszVolumeTitle;
}

struct INTERNET_CACHE_CONTAINER_INFOW
{
    uint  dwCacheVersion;
    PWSTR lpszName;
    PWSTR lpszCachePrefix;
    PWSTR lpszVolumeLabel;
    PWSTR lpszVolumeTitle;
}

struct APP_CACHE_DOWNLOAD_ENTRY
{
    PWSTR pwszUrl;
    uint  dwEntryType;
}

struct APP_CACHE_DOWNLOAD_LIST
{
    uint dwEntryCount;
    APP_CACHE_DOWNLOAD_ENTRY* pEntries;
}

struct APP_CACHE_GROUP_INFO
{
    PWSTR    pwszManifestUrl;
    FILETIME ftLastAccessTime;
    ulong    ullSize;
}

struct APP_CACHE_GROUP_LIST
{
    uint dwAppCacheGroupCount;
    APP_CACHE_GROUP_INFO* pAppCacheGroups;
}

struct URLCACHE_ENTRY_INFO
{
    PWSTR    pwszSourceUrlName;
    PWSTR    pwszLocalFileName;
    uint     dwCacheEntryType;
    uint     dwUseCount;
    uint     dwHitRate;
    uint     dwSizeLow;
    uint     dwSizeHigh;
    FILETIME ftLastModifiedTime;
    FILETIME ftExpireTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastSyncTime;
    ubyte*   pbHeaderInfo;
    uint     cbHeaderInfoSize;
    ubyte*   pbExtraData;
    uint     cbExtraDataSize;
}

struct WININET_PROXY_INFO
{
    BOOL            fProxy;
    BOOL            fBypass;
    INTERNET_SCHEME ProxyScheme;
    PWSTR           pwszProxy;
    ushort          ProxyPort;
}

struct WININET_PROXY_INFO_LIST
{
    uint                dwProxyInfoCount;
    WININET_PROXY_INFO* pProxyInfo;
}

struct HTTP_WEB_SOCKET_ASYNC_RESULT
{
    INTERNET_ASYNC_RESULT AsyncResult;
    HTTP_WEB_SOCKET_OPERATION Operation;
    HTTP_WEB_SOCKET_BUFFER_TYPE BufferType;
    uint dwBytesTransferred;
}

struct ProofOfPossessionCookieInfo
{
    PWSTR name;
    PWSTR data;
    uint  flags;
    PWSTR p3pHeader;
}

// Functions

///Formats a date and time according to the HTTP version 1.0 specification.
///Params:
///    pst = Pointer to a SYSTEMTIME structure that contains the date and time to format.
///    dwRFC = RFC format used. Currently, the only valid format is INTERNET_RFC1123_FORMAT.
///    lpszTime = Pointer to a string buffer that receives the formatted date and time. The buffer should be of size
///               INTERNET_RFC1123_BUFSIZE.
///    cbTime = Size of the <i>lpszTime</i> buffer, in bytes.
///Returns:
///    Returns TRUE if the function succeeds, or FALSE otherwise. To get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetTimeFromSystemTimeA(const(SYSTEMTIME)* pst, uint dwRFC, PSTR lpszTime, uint cbTime);

///Formats a date and time according to the HTTP version 1.0 specification.
///Params:
///    pst = Pointer to a SYSTEMTIME structure that contains the date and time to format.
///    dwRFC = RFC format used. Currently, the only valid format is INTERNET_RFC1123_FORMAT.
///    lpszTime = Pointer to a string buffer that receives the formatted date and time. The buffer should be of size
///               INTERNET_RFC1123_BUFSIZE.
///    cbTime = Size of the <i>lpszTime</i> buffer, in bytes.
///Returns:
///    Returns TRUE if the function succeeds, or FALSE otherwise. To get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetTimeFromSystemTimeW(const(SYSTEMTIME)* pst, uint dwRFC, PWSTR lpszTime, uint cbTime);

///Formats a date and time according to the HTTP version 1.0 specification.
///Params:
///    pst = Pointer to a SYSTEMTIME structure that contains the date and time to format.
///    dwRFC = RFC format used. Currently, the only valid format is INTERNET_RFC1123_FORMAT.
///    lpszTime = Pointer to a string buffer that receives the formatted date and time. The buffer should be of size
///               INTERNET_RFC1123_BUFSIZE.
///    cbTime = Size of the <i>lpszTime</i> buffer, in bytes.
///Returns:
///    Returns TRUE if the function succeeds, or FALSE otherwise. To get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetTimeFromSystemTime(const(SYSTEMTIME)* pst, uint dwRFC, PSTR lpszTime, uint cbTime);

///Converts an HTTP time/date string to a SYSTEMTIME structure.
///Params:
///    lpszTime = Pointer to a null-terminated string that specifies the date/time to be converted.
///    pst = Pointer to a SYSTEMTIME structure that receives the converted time.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if the string was converted, or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError.
///    
@DllImport("WININET")
BOOL InternetTimeToSystemTimeA(const(PSTR) lpszTime, SYSTEMTIME* pst, uint dwReserved);

///Converts an HTTP time/date string to a SYSTEMTIME structure.
///Params:
///    lpszTime = Pointer to a null-terminated string that specifies the date/time to be converted.
///    pst = Pointer to a SYSTEMTIME structure that receives the converted time.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if the string was converted, or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError.
///    
@DllImport("WININET")
BOOL InternetTimeToSystemTimeW(const(PWSTR) lpszTime, SYSTEMTIME* pst, uint dwReserved);

///Converts an HTTP time/date string to a SYSTEMTIME structure.
///Params:
///    lpszTime = Pointer to a null-terminated string that specifies the date/time to be converted.
///    pst = Pointer to a SYSTEMTIME structure that receives the converted time.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if the string was converted, or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError.
///    
@DllImport("WININET")
BOOL InternetTimeToSystemTime(const(PSTR) lpszTime, SYSTEMTIME* pst, uint dwReserved);

///Cracks a URL into its component parts.
///Params:
///    lpszUrl = Pointer to a string that contains the canonical URL to be cracked.
///    dwUrlLength = Size of the <i>lpszUrl</i> string, in <b>TCHARs</b>, or zero if <i>lpszUrl</i> is an ASCIIZ string.
///    dwFlags = Controls the operation. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ICU_DECODE"></a><a id="icu_decode"></a><dl>
///              <dt><b>ICU_DECODE</b></dt> </dl> </td> <td width="60%"> Converts encoded characters back to their normal form.
///              This can be used only if the user provides buffers in the URL_COMPONENTS structure to copy the components into.
///              </td> </tr> <tr> <td width="40%"><a id="ICU_ESCAPE"></a><a id="icu_escape"></a><dl> <dt><b>ICU_ESCAPE</b></dt>
///              </dl> </td> <td width="60%"> Converts all escape sequences (%xx) to their corresponding characters. This can be
///              used only if the user provides buffers in the URL_COMPONENTS structure to copy the components into. </td> </tr>
///              </table>
///    lpUrlComponents = Pointer to a URL_COMPONENTS structure that receives the URL components.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL InternetCrackUrlA(const(PSTR) lpszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTSA* lpUrlComponents);

///Cracks a URL into its component parts.
///Params:
///    lpszUrl = Pointer to a string that contains the canonical URL to be cracked.
///    dwUrlLength = Size of the <i>lpszUrl</i> string, in <b>TCHARs</b>, or zero if <i>lpszUrl</i> is an ASCIIZ string.
///    dwFlags = Controls the operation. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ICU_DECODE"></a><a id="icu_decode"></a><dl>
///              <dt><b>ICU_DECODE</b></dt> </dl> </td> <td width="60%"> Converts encoded characters back to their normal form.
///              This can be used only if the user provides buffers in the URL_COMPONENTS structure to copy the components into.
///              </td> </tr> <tr> <td width="40%"><a id="ICU_ESCAPE"></a><a id="icu_escape"></a><dl> <dt><b>ICU_ESCAPE</b></dt>
///              </dl> </td> <td width="60%"> Converts all escape sequences (%xx) to their corresponding characters. This can be
///              used only if the user provides buffers in the URL_COMPONENTS structure to copy the components into. </td> </tr>
///              </table>
///    lpUrlComponents = Pointer to a URL_COMPONENTS structure that receives the URL components.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL InternetCrackUrlW(const(PWSTR) lpszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTSW* lpUrlComponents);

///Creates a URL from its component parts.
///Params:
///    lpUrlComponents = Pointer to a URL_COMPONENTS structure that contains the components from which to create the URL.
///    dwFlags = Controls the operation of this function. This parameter can be one or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>ICU_ESCAPE</dt> </dl> </td> <td width="60%">
///              Converts all unsafe characters to their corresponding escape sequences in the path string pointed to by the
///              <b>lpszUrlPath</b> member and in <b>lpszExtraInfo</b> the extra-information string pointed to by the member of
///              the URL_COMPONENTS structure pointed to by the <i>lpUrlComponents</i> parameter. The Unicode version of
///              <b>InternetCreateUrl</b> will first try to convert using the system code page. If that fails it falls back to
///              UTF-8. </td> </tr> <tr> <td width="40%"> <dl> <dt>ICU_USERNAME</dt> </dl> </td> <td width="60%"> Obsolete —
///              ignored. </td> </tr> </table>
///    lpszUrl = Pointer to a buffer that receives the URL.
///    lpdwUrlLength = Pointer to a variable that specifies the size of the URL<i>lpszUrl</i> buffer, in <b>TCHARs</b>. When the
///                    function returns, this parameter receives the size of the URL string, excluding the NULL terminator. If
///                    GetLastError returns ERROR_INSUFFICIENT_BUFFER, this parameter receives the number of bytes required to hold the
///                    created URL.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL InternetCreateUrlA(URL_COMPONENTSA* lpUrlComponents, uint dwFlags, PSTR lpszUrl, uint* lpdwUrlLength);

///Creates a URL from its component parts.
///Params:
///    lpUrlComponents = Pointer to a URL_COMPONENTS structure that contains the components from which to create the URL.
///    dwFlags = Controls the operation of this function. This parameter can be one or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>ICU_ESCAPE</dt> </dl> </td> <td width="60%">
///              Converts all unsafe characters to their corresponding escape sequences in the path string pointed to by the
///              <b>lpszUrlPath</b> member and in <b>lpszExtraInfo</b> the extra-information string pointed to by the member of
///              the URL_COMPONENTS structure pointed to by the <i>lpUrlComponents</i> parameter. The Unicode version of
///              <b>InternetCreateUrl</b> will first try to convert using the system code page. If that fails it falls back to
///              UTF-8. </td> </tr> <tr> <td width="40%"> <dl> <dt>ICU_USERNAME</dt> </dl> </td> <td width="60%"> Obsolete —
///              ignored. </td> </tr> </table>
///    lpszUrl = Pointer to a buffer that receives the URL.
///    lpdwUrlLength = Pointer to a variable that specifies the size of the URL<i>lpszUrl</i> buffer, in <b>TCHARs</b>. When the
///                    function returns, this parameter receives the size of the URL string, excluding the NULL terminator. If
///                    GetLastError returns ERROR_INSUFFICIENT_BUFFER, this parameter receives the number of bytes required to hold the
///                    created URL.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL InternetCreateUrlW(URL_COMPONENTSW* lpUrlComponents, uint dwFlags, PWSTR lpszUrl, uint* lpdwUrlLength);

///Canonicalizes a URL, which includes converting unsafe characters and spaces into escape sequences.
///Params:
///    lpszUrl = A pointer to the string that contains the URL to canonicalize.
///    lpszBuffer = A pointer to the buffer that receives the resulting canonicalized URL.
///    lpdwBufferLength = A pointer to a variable that contains the size, in characters, of the <i>lpszBuffer</i> buffer. If the function
///                       succeeds, this parameter receives the number of characters actually copied to the <i>lpszBuffer</i> buffer, which
///                       does not include the terminating null character. If the function fails, this parameter receives the required size
///                       of the buffer, in characters, which includes the terminating null character.
///    dwFlags = Controls canonicalization. If no flags are specified, the function converts all unsafe characters and meta
///              sequences (such as \.,\ .., and \...) to escape sequences. This parameter can be one of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>ICU_BROWSER_MODE</dt> </dl>
///              </td> <td width="60%"> Does not encode or decode characters after "
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call the
///    GetLastError function. Possible errors include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl> </td> <td
///    width="60%"> The URL could not be canonicalized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The canonicalized URL is too large to fit
///    in the buffer provided. The <i>lpdwBufferLength</i> parameter is set to the size, in bytes, of the buffer
///    required to hold the canonicalized URL. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERNET_INVALID_URL</b></dt> </dl> </td> <td width="60%"> The format of the URL is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> There is an
///    invalid string, buffer, buffer size, or flags parameter. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetCanonicalizeUrlA(const(PSTR) lpszUrl, PSTR lpszBuffer, uint* lpdwBufferLength, uint dwFlags);

///Canonicalizes a URL, which includes converting unsafe characters and spaces into escape sequences.
///Params:
///    lpszUrl = A pointer to the string that contains the URL to canonicalize.
///    lpszBuffer = A pointer to the buffer that receives the resulting canonicalized URL.
///    lpdwBufferLength = A pointer to a variable that contains the size, in characters, of the <i>lpszBuffer</i> buffer. If the function
///                       succeeds, this parameter receives the number of characters actually copied to the <i>lpszBuffer</i> buffer, which
///                       does not include the terminating null character. If the function fails, this parameter receives the required size
///                       of the buffer, in characters, which includes the terminating null character.
///    dwFlags = Controls canonicalization. If no flags are specified, the function converts all unsafe characters and meta
///              sequences (such as \.,\ .., and \...) to escape sequences. This parameter can be one of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>ICU_BROWSER_MODE</dt> </dl>
///              </td> <td width="60%"> Does not encode or decode characters after "
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call the
///    GetLastError function. Possible errors include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl> </td> <td
///    width="60%"> The URL could not be canonicalized. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The canonicalized URL is too large to fit
///    in the buffer provided. The <i>lpdwBufferLength</i> parameter is set to the size, in bytes, of the buffer
///    required to hold the canonicalized URL. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERNET_INVALID_URL</b></dt> </dl> </td> <td width="60%"> The format of the URL is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> There is an
///    invalid string, buffer, buffer size, or flags parameter. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetCanonicalizeUrlW(const(PWSTR) lpszUrl, PWSTR lpszBuffer, uint* lpdwBufferLength, uint dwFlags);

///Combines a base and relative URL into a single URL. The resultant URL is canonicalized (see InternetCanonicalizeUrl).
///Params:
///    lpszBaseUrl = Pointer to a null-terminated string that contains the base URL.
///    lpszRelativeUrl = Pointer to a null-terminated string that contains the relative URL.
///    lpszBuffer = Pointer to a buffer that receives the combined URL.
///    lpdwBufferLength = Pointer to a variable that contains the size of the <i>lpszBuffer</i> buffer, in characters. If the function
///                       succeeds, this parameter receives the size of the combined URL, in characters, not including the null-terminating
///                       character. If the function fails, this parameter receives the size of the required buffer, in characters
///                       (including the null-terminating character).
///    dwFlags = Controls the operation of the function. This parameter can be one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>ICU_BROWSER_MODE</dt> </dl> </td> <td
///              width="60%"> Does not encode or decode characters after "
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible errors include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl> </td> <td width="60%"> The URLs could not be
///    combined. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer supplied to the function was insufficient or <b>NULL</b>. The value indicated by the
///    <i>lpdwBufferLength</i> parameter will contain the number of bytes required to hold the combined URL. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERNET_INVALID_URL</b></dt> </dl> </td> <td width="60%"> The format of
///    the URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> There is an invalid string, buffer, buffer size, or flags parameter. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetCombineUrlA(const(PSTR) lpszBaseUrl, const(PSTR) lpszRelativeUrl, PSTR lpszBuffer, 
                         uint* lpdwBufferLength, uint dwFlags);

///Combines a base and relative URL into a single URL. The resultant URL is canonicalized (see InternetCanonicalizeUrl).
///Params:
///    lpszBaseUrl = Pointer to a null-terminated string that contains the base URL.
///    lpszRelativeUrl = Pointer to a null-terminated string that contains the relative URL.
///    lpszBuffer = Pointer to a buffer that receives the combined URL.
///    lpdwBufferLength = Pointer to a variable that contains the size of the <i>lpszBuffer</i> buffer, in characters. If the function
///                       succeeds, this parameter receives the size of the combined URL, in characters, not including the null-terminating
///                       character. If the function fails, this parameter receives the size of the required buffer, in characters
///                       (including the null-terminating character).
///    dwFlags = Controls the operation of the function. This parameter can be one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>ICU_BROWSER_MODE</dt> </dl> </td> <td
///              width="60%"> Does not encode or decode characters after "
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible errors include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_PATHNAME</b></dt> </dl> </td> <td width="60%"> The URLs could not be
///    combined. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer supplied to the function was insufficient or <b>NULL</b>. The value indicated by the
///    <i>lpdwBufferLength</i> parameter will contain the number of bytes required to hold the combined URL. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INTERNET_INVALID_URL</b></dt> </dl> </td> <td width="60%"> The format of
///    the URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> There is an invalid string, buffer, buffer size, or flags parameter. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetCombineUrlW(const(PWSTR) lpszBaseUrl, const(PWSTR) lpszRelativeUrl, PWSTR lpszBuffer, 
                         uint* lpdwBufferLength, uint dwFlags);

///Initializes an application's use of the WinINet functions.
///Params:
///    lpszAgent = Pointer to a <b>null</b>-terminated string that specifies the name of the application or entity calling the
///                WinINet functions. This name is used as the user agent in the HTTP protocol.
///    dwAccessType = Type of access required. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_DIRECT</dt> </dl> </td> <td width="60%">
///                   Resolves all host names locally. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_PRECONFIG</dt>
///                   </dl> </td> <td width="60%"> Retrieves the proxy or direct configuration from the registry. </td> </tr> <tr> <td
///                   width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY</dt> </dl> </td> <td width="60%"> Retrieves
///                   the proxy or direct configuration from the registry and prevents the use of a startup Microsoft JScript or
///                   Internet Setup (INS) file. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_PROXY</dt> </dl> </td>
///                   <td width="60%"> Passes requests to the proxy unless a proxy bypass list is supplied and the name to be resolved
///                   bypasses the proxy. In this case, the function uses <b>INTERNET_OPEN_TYPE_DIRECT</b>. </td> </tr> </table>
///    lpszProxy = Pointer to a <b>null</b>-terminated string that specifies the name of the proxy server(s) to use when proxy
///                access is specified by setting <i>dwAccessType</i> to <b>INTERNET_OPEN_TYPE_PROXY</b>. Do not use an empty
///                string, because <b>InternetOpen</b> will use it as the proxy name. The WinINet functions recognize only CERN type
///                proxies (HTTP only) and the TIS FTP gateway (FTP only). If Microsoft Internet Explorer is installed, these
///                functions also support SOCKS proxies. FTP requests can be made through a CERN type proxy either by changing them
///                to an HTTP request or by using InternetOpenUrl. If <i>dwAccessType</i> is not set to
///                <b>INTERNET_OPEN_TYPE_PROXY</b>, this parameter is ignored and should be <b>NULL</b>. For more information about
///                listing proxy servers, see the Listing Proxy Servers section of Enabling Internet Functionality.
///    lpszProxyBypass = Pointer to a <b>null</b>-terminated string that specifies an optional list of host names or IP addresses, or
///                      both, that should not be routed through the proxy when <i>dwAccessType</i> is set to
///                      <b>INTERNET_OPEN_TYPE_PROXY</b>. The list can contain wildcards. Do not use an empty string, because
///                      <b>InternetOpen</b> will use it as the proxy bypass list. If this parameter specifies the "&lt;local&gt;" macro,
///                      the function bypasses the proxy for any host name that does not contain a period. By default, WinINet will bypass
///                      the proxy for requests that use the host names "localhost", "loopback", "127.0.0.1", or "[::1]". This behavior
///                      exists because a remote proxy server typically will not resolve these addresses properly.<b>Internet Explorer 9:
///                      </b>You can remove the local computer from the proxy bypass list using the "&lt;-loopback&gt;" macro. If
///                      <i>dwAccessType</i> is not set to <b>INTERNET_OPEN_TYPE_PROXY</b>, this parameter is ignored and should be
///                      <b>NULL</b>.
///    dwFlags = Options. This parameter can be a combination of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_ASYNC</dt> </dl> </td> <td width="60%"> Makes
///              only asynchronous requests on handles descended from the handle returned from this function. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_FROM_CACHE</dt> </dl> </td> <td width="60%"> Does not make network requests.
///              All entities are returned from the cache. If the requested item is not in the cache, a suitable error, such as
///              ERROR_FILE_NOT_FOUND, is returned. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_OFFLINE</dt> </dl>
///              </td> <td width="60%"> Identical to <b>INTERNET_FLAG_FROM_CACHE</b>. Does not make network requests. All entities
///              are returned from the cache. If the requested item is not in the cache, a suitable error, such as
///              ERROR_FILE_NOT_FOUND, is returned. </td> </tr> </table>
///Returns:
///    Returns a valid handle that the application passes to subsequent WinINet functions. If <b>InternetOpen</b> fails,
///    it returns <b>NULL</b>. To retrieve a specific error message, call GetLastError.
///    
@DllImport("WININET")
void* InternetOpenA(const(PSTR) lpszAgent, uint dwAccessType, const(PSTR) lpszProxy, const(PSTR) lpszProxyBypass, 
                    uint dwFlags);

///Initializes an application's use of the WinINet functions.
///Params:
///    lpszAgent = Pointer to a <b>null</b>-terminated string that specifies the name of the application or entity calling the
///                WinINet functions. This name is used as the user agent in the HTTP protocol.
///    dwAccessType = Type of access required. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_DIRECT</dt> </dl> </td> <td width="60%">
///                   Resolves all host names locally. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_PRECONFIG</dt>
///                   </dl> </td> <td width="60%"> Retrieves the proxy or direct configuration from the registry. </td> </tr> <tr> <td
///                   width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY</dt> </dl> </td> <td width="60%"> Retrieves
///                   the proxy or direct configuration from the registry and prevents the use of a startup Microsoft JScript or
///                   Internet Setup (INS) file. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_OPEN_TYPE_PROXY</dt> </dl> </td>
///                   <td width="60%"> Passes requests to the proxy unless a proxy bypass list is supplied and the name to be resolved
///                   bypasses the proxy. In this case, the function uses <b>INTERNET_OPEN_TYPE_DIRECT</b>. </td> </tr> </table>
///    lpszProxy = Pointer to a <b>null</b>-terminated string that specifies the name of the proxy server(s) to use when proxy
///                access is specified by setting <i>dwAccessType</i> to <b>INTERNET_OPEN_TYPE_PROXY</b>. Do not use an empty
///                string, because <b>InternetOpen</b> will use it as the proxy name. The WinINet functions recognize only CERN type
///                proxies (HTTP only) and the TIS FTP gateway (FTP only). If Microsoft Internet Explorer is installed, these
///                functions also support SOCKS proxies. FTP requests can be made through a CERN type proxy either by changing them
///                to an HTTP request or by using InternetOpenUrl. If <i>dwAccessType</i> is not set to
///                <b>INTERNET_OPEN_TYPE_PROXY</b>, this parameter is ignored and should be <b>NULL</b>. For more information about
///                listing proxy servers, see the Listing Proxy Servers section of Enabling Internet Functionality.
///    lpszProxyBypass = Pointer to a <b>null</b>-terminated string that specifies an optional list of host names or IP addresses, or
///                      both, that should not be routed through the proxy when <i>dwAccessType</i> is set to
///                      <b>INTERNET_OPEN_TYPE_PROXY</b>. The list can contain wildcards. Do not use an empty string, because
///                      <b>InternetOpen</b> will use it as the proxy bypass list. If this parameter specifies the "&lt;local&gt;" macro,
///                      the function bypasses the proxy for any host name that does not contain a period. By default, WinINet will bypass
///                      the proxy for requests that use the host names "localhost", "loopback", "127.0.0.1", or "[::1]". This behavior
///                      exists because a remote proxy server typically will not resolve these addresses properly.<b>Internet Explorer 9:
///                      </b>You can remove the local computer from the proxy bypass list using the "&lt;-loopback&gt;" macro. If
///                      <i>dwAccessType</i> is not set to <b>INTERNET_OPEN_TYPE_PROXY</b>, this parameter is ignored and should be
///                      <b>NULL</b>.
///    dwFlags = Options. This parameter can be a combination of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_ASYNC</dt> </dl> </td> <td width="60%"> Makes
///              only asynchronous requests on handles descended from the handle returned from this function. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_FROM_CACHE</dt> </dl> </td> <td width="60%"> Does not make network requests.
///              All entities are returned from the cache. If the requested item is not in the cache, a suitable error, such as
///              ERROR_FILE_NOT_FOUND, is returned. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_OFFLINE</dt> </dl>
///              </td> <td width="60%"> Identical to <b>INTERNET_FLAG_FROM_CACHE</b>. Does not make network requests. All entities
///              are returned from the cache. If the requested item is not in the cache, a suitable error, such as
///              ERROR_FILE_NOT_FOUND, is returned. </td> </tr> </table>
///Returns:
///    Returns a valid handle that the application passes to subsequent WinINet functions. If <b>InternetOpen</b> fails,
///    it returns <b>NULL</b>. To retrieve a specific error message, call GetLastError.
///    
@DllImport("WININET")
void* InternetOpenW(const(PWSTR) lpszAgent, uint dwAccessType, const(PWSTR) lpszProxy, 
                    const(PWSTR) lpszProxyBypass, uint dwFlags);

///Closes a single Internet handle.
///Params:
///    hInternet = Handle to be closed.
///Returns:
///    Returns <b>TRUE</b> if the handle is successfully closed, or <b>FALSE</b> otherwise. To get extended error
///    information, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetCloseHandle(void* hInternet);

///Opens an File Transfer Protocol (FTP) or HTTP session for a given site.
///Params:
///    hInternet = Handle returned by a previous call to InternetOpen.
///    lpszServerName = Pointer to a <b>null</b>-terminated string that specifies the host name of an Internet server. Alternately, the
///                     string can contain the IP number of the site, in ASCII dotted-decimal format (for example, 11.0.1.45).
///    nServerPort = Transmission Control Protocol/Internet Protocol (TCP/IP) port on the server. These flags set only the port that
///                  is used. The service is set by the value of <i>dwService</i>. This parameter can be one of the following values.
///                  <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DEFAULT_FTP_PORT</dt>
///                  </dl> </td> <td width="60%"> Uses the default port for FTP servers (port 21). </td> </tr> <tr> <td width="40%">
///                  <dl> <dt>INTERNET_DEFAULT_GOPHER_PORT</dt> </dl> </td> <td width="60%"> Uses the default port for Gopher servers
///                  (port 70).<div class="alert"><b>Note</b> Windows XP and Windows Server 2003 R2 and earlier only.</div> <div>
///                  </div> </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DEFAULT_HTTP_PORT</dt> </dl> </td> <td width="60%">
///                  Uses the default port for HTTP servers (port 80). </td> </tr> <tr> <td width="40%"> <dl>
///                  <dt>INTERNET_DEFAULT_HTTPS_PORT</dt> </dl> </td> <td width="60%"> Uses the default port for Secure Hypertext
///                  Transfer Protocol (HTTPS) servers (port 443). </td> </tr> <tr> <td width="40%"> <dl>
///                  <dt>INTERNET_DEFAULT_SOCKS_PORT</dt> </dl> </td> <td width="60%"> Uses the default port for SOCKS firewall
///                  servers (port 1080). </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_INVALID_PORT_NUMBER</dt> </dl> </td> <td
///                  width="60%"> Uses the default port for the service specified by <i>dwService</i>. </td> </tr> </table>
///    lpszUserName = Pointer to a <b>null</b>-terminated string that specifies the name of the user to log on. If this parameter is
///                   <b>NULL</b>, the function uses an appropriate default. For the FTP protocol, the default is "anonymous".
///    lpszPassword = Pointer to a <b>null</b>-terminated string that contains the password to use to log on. If both
///                   <i>lpszPassword</i> and <i>lpszUsername</i> are <b>NULL</b>, the function uses the default "anonymous" password.
///                   In the case of FTP, the default password is the user's email name. If <i>lpszPassword</i> is <b>NULL</b>, but
///                   <i>lpszUsername</i> is not <b>NULL</b>, the function uses a blank password.
///    dwService = Type of service to access. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_SERVICE_FTP</dt> </dl> </td> <td width="60%"> FTP
///                service. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_SERVICE_GOPHER</dt> </dl> </td> <td width="60%">
///                Gopher service.<div class="alert"><b>Note</b> Windows XP and Windows Server 2003 R2 and earlier only.</div> <div>
///                </div> </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_SERVICE_HTTP</dt> </dl> </td> <td width="60%"> HTTP
///                service. </td> </tr> </table>
///    dwFlags = Options specific to the service used. If <i>dwService</i> is INTERNET_SERVICE_FTP, INTERNET_FLAG_PASSIVE causes
///              the application to use passive FTP semantics.
///    dwContext = Pointer to a variable that contains an application-defined value that is used to identify the application context
///                for the returned handle in callbacks.
///Returns:
///    Returns a valid handle to the session if the connection is successful, or <b>NULL</b> otherwise. To retrieve
///    extended error information, call GetLastError. An application can also use InternetGetLastResponseInfo to
///    determine why access to the service was denied.
///    
@DllImport("WININET")
void* InternetConnectA(void* hInternet, const(PSTR) lpszServerName, ushort nServerPort, const(PSTR) lpszUserName, 
                       const(PSTR) lpszPassword, uint dwService, uint dwFlags, size_t dwContext);

///Opens an File Transfer Protocol (FTP) or HTTP session for a given site.
///Params:
///    hInternet = Handle returned by a previous call to InternetOpen.
///    lpszServerName = Pointer to a <b>null</b>-terminated string that specifies the host name of an Internet server. Alternately, the
///                     string can contain the IP number of the site, in ASCII dotted-decimal format (for example, 11.0.1.45).
///    nServerPort = Transmission Control Protocol/Internet Protocol (TCP/IP) port on the server. These flags set only the port that
///                  is used. The service is set by the value of <i>dwService</i>. This parameter can be one of the following values.
///                  <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DEFAULT_FTP_PORT</dt>
///                  </dl> </td> <td width="60%"> Uses the default port for FTP servers (port 21). </td> </tr> <tr> <td width="40%">
///                  <dl> <dt>INTERNET_DEFAULT_GOPHER_PORT</dt> </dl> </td> <td width="60%"> Uses the default port for Gopher servers
///                  (port 70).<div class="alert"><b>Note</b> Windows XP and Windows Server 2003 R2 and earlier only.</div> <div>
///                  </div> </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DEFAULT_HTTP_PORT</dt> </dl> </td> <td width="60%">
///                  Uses the default port for HTTP servers (port 80). </td> </tr> <tr> <td width="40%"> <dl>
///                  <dt>INTERNET_DEFAULT_HTTPS_PORT</dt> </dl> </td> <td width="60%"> Uses the default port for Secure Hypertext
///                  Transfer Protocol (HTTPS) servers (port 443). </td> </tr> <tr> <td width="40%"> <dl>
///                  <dt>INTERNET_DEFAULT_SOCKS_PORT</dt> </dl> </td> <td width="60%"> Uses the default port for SOCKS firewall
///                  servers (port 1080). </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_INVALID_PORT_NUMBER</dt> </dl> </td> <td
///                  width="60%"> Uses the default port for the service specified by <i>dwService</i>. </td> </tr> </table>
///    lpszUserName = Pointer to a <b>null</b>-terminated string that specifies the name of the user to log on. If this parameter is
///                   <b>NULL</b>, the function uses an appropriate default. For the FTP protocol, the default is "anonymous".
///    lpszPassword = Pointer to a <b>null</b>-terminated string that contains the password to use to log on. If both
///                   <i>lpszPassword</i> and <i>lpszUsername</i> are <b>NULL</b>, the function uses the default "anonymous" password.
///                   In the case of FTP, the default password is the user's email name. If <i>lpszPassword</i> is <b>NULL</b>, but
///                   <i>lpszUsername</i> is not <b>NULL</b>, the function uses a blank password.
///    dwService = Type of service to access. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_SERVICE_FTP</dt> </dl> </td> <td width="60%"> FTP
///                service. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_SERVICE_GOPHER</dt> </dl> </td> <td width="60%">
///                Gopher service.<div class="alert"><b>Note</b> Windows XP and Windows Server 2003 R2 and earlier only.</div> <div>
///                </div> </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_SERVICE_HTTP</dt> </dl> </td> <td width="60%"> HTTP
///                service. </td> </tr> </table>
///    dwFlags = Options specific to the service used. If <i>dwService</i> is INTERNET_SERVICE_FTP, INTERNET_FLAG_PASSIVE causes
///              the application to use passive FTP semantics.
///    dwContext = Pointer to a variable that contains an application-defined value that is used to identify the application context
///                for the returned handle in callbacks.
///Returns:
///    Returns a valid handle to the session if the connection is successful, or <b>NULL</b> otherwise. To retrieve
///    extended error information, call GetLastError. An application can also use InternetGetLastResponseInfo to
///    determine why access to the service was denied.
///    
@DllImport("WININET")
void* InternetConnectW(void* hInternet, const(PWSTR) lpszServerName, ushort nServerPort, const(PWSTR) lpszUserName, 
                       const(PWSTR) lpszPassword, uint dwService, uint dwFlags, size_t dwContext);

///Opens a resource specified by a complete FTP or HTTP URL.
///Params:
///    hInternet = The handle to the current Internet session. The handle must have been returned by a previous call to
///                InternetOpen.
///    lpszUrl = A pointer to a <b>null</b>-terminated string variable that specifies the URL to begin reading. Only URLs
///              beginning with ftp:, http:, or https: are supported.
///    lpszHeaders = A pointer to a <b>null</b>-terminated string that specifies the headers to be sent to the HTTP server. For more
///                  information, see the description of the <i>lpszHeaders</i> parameter in the HttpSendRequest function.
///    dwHeadersLength = The size of the additional headers, in <b>TCHARs</b>. If this parameter is -1L and <i>lpszHeaders</i> is not
///                      <b>NULL</b>, <i>lpszHeaders</i> is assumed to be zero-terminated (ASCIIZ) and the length is calculated.
///    dwFlags = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_EXISTING_CONNECT</dt> </dl> </td> <td width="60%"> Attempts to use an
///              existing InternetConnect object if one exists with the same attributes required to make the request. This is
///              useful only with FTP operations, since FTP is the only protocol that typically performs multiple operations
///              during the same session. The WinINet API caches a single connection handle for each <b>HINTERNET</b> handle
///              generated by InternetOpen. <b>InternetOpenUrl</b> uses this flag for HTTP and FTP connections. </td> </tr> <tr>
///              <td width="40%"> <dl> <dt>INTERNET_FLAG_HYPERLINK</dt> </dl> </td> <td width="60%"> Forces a reload if there was
///              no Expires time and no LastModified time returned from the server when determining whether to reload the item
///              from the network. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_CERT_CN_INVALID</dt> </dl>
///              </td> <td width="60%"> Disables checking of SSL/PCT-based certificates that are returned from the server against
///              the host name given in the request. WinINet functions use a simple check against certificates by comparing for
///              matching host names and simple wildcarding rules. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_IGNORE_CERT_DATE_INVALID</dt> </dl> </td> <td width="60%"> Disables checking of SSL/PCT-based
///              certificates for proper validity dates. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP</dt> </dl> </td> <td width="60%"> Disables detection of this special
///              type of redirect. When this flag is used, WinINet transparently allows redirects from HTTPS to HTTP URLs. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS</dt> </dl> </td> <td width="60%">
///              Disables the detection of this special type of redirect. When this flag is used, WinINet transparently allows
///              redirects from HTTP to HTTPS URLs. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_KEEP_CONNECTION</dt>
///              </dl> </td> <td width="60%"> Uses keep-alive semantics, if available, for the connection. This flag is required
///              for Microsoft Network (MSN), NTLM, and other types of authentication. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_AUTH</dt> </dl> </td> <td
///              width="60%"> Does not attempt authentication automatically. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_AUTO_REDIRECT</dt> </dl> </td> <td width="60%"> Does not automatically handle redirection in
///              HttpSendRequest. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_COOKIES</dt> </dl> </td> <td width="60%"> Does not automatically add cookie headers to
///              requests, and does not automatically add returned cookies to the cookie database. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_NO_UI</dt> </dl> </td> <td width="60%"> Disables the cookie dialog box. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_PASSIVE</dt> </dl> </td> <td width="60%"> Uses passive FTP
///              semantics. <b>InternetOpenUrl</b> uses this flag for FTP files and directories. </td> </tr> <tr> <td width="40%">
///              <dl> <dt>INTERNET_FLAG_PRAGMA_NOCACHE</dt> </dl> </td> <td width="60%"> Forces the request to be resolved by the
///              origin server, even if a cached copy exists on the proxy. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RAW_DATA</dt> </dl> </td> <td width="60%"> Returns the data as a WIN32_FIND_DATA structure when
///              retrieving FTP directory information. If this flag is not specified or if the call was made through a CERN proxy,
///              <b>InternetOpenUrl</b> returns the HTML version of the directory. <b>Windows XP and Windows Server 2003 R2 and
///              earlier: </b>Also returns data as a GOPHER_FIND_DATA structure when retrieving Gopher directory information.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a
///              download of the requested file, object, or directory listing from the origin server, not from the cache. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP
///              resources if the resource has been modified since the last time it was downloaded. All FTP resources are
///              reloaded. <b>Windows XP and Windows Server 2003 R2 and earlier: </b>Gopher resources are also reloaded. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_SECURE</dt> </dl> </td> <td width="60%"> Uses secure
///              transaction semantics. This translates to using Secure Sockets Layer/Private Communications Technology (SSL/PCT)
///              and is only meaningful in HTTP requests. </td> </tr> </table>
///    dwContext = A pointer to a variable that specifies the application-defined value that is passed, along with the returned
///                handle, to any callback functions.
///Returns:
///    Returns a valid handle to the URL if the connection is successfully established, or <b>NULL</b> if the connection
///    fails. To retrieve a specific error message, call GetLastError. To determine why access to the service was
///    denied, call InternetGetLastResponseInfo.
///    
@DllImport("WININET")
void* InternetOpenUrlA(void* hInternet, const(PSTR) lpszUrl, const(PSTR) lpszHeaders, uint dwHeadersLength, 
                       uint dwFlags, size_t dwContext);

///Opens a resource specified by a complete FTP or HTTP URL.
///Params:
///    hInternet = The handle to the current Internet session. The handle must have been returned by a previous call to
///                InternetOpen.
///    lpszUrl = A pointer to a <b>null</b>-terminated string variable that specifies the URL to begin reading. Only URLs
///              beginning with ftp:, http:, or https: are supported.
///    lpszHeaders = A pointer to a <b>null</b>-terminated string that specifies the headers to be sent to the HTTP server. For more
///                  information, see the description of the <i>lpszHeaders</i> parameter in the HttpSendRequest function.
///    dwHeadersLength = The size of the additional headers, in <b>TCHARs</b>. If this parameter is -1L and <i>lpszHeaders</i> is not
///                      <b>NULL</b>, <i>lpszHeaders</i> is assumed to be zero-terminated (ASCIIZ) and the length is calculated.
///    dwFlags = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_EXISTING_CONNECT</dt> </dl> </td> <td width="60%"> Attempts to use an
///              existing InternetConnect object if one exists with the same attributes required to make the request. This is
///              useful only with FTP operations, since FTP is the only protocol that typically performs multiple operations
///              during the same session. The WinINet API caches a single connection handle for each <b>HINTERNET</b> handle
///              generated by InternetOpen. <b>InternetOpenUrl</b> uses this flag for HTTP and FTP connections. </td> </tr> <tr>
///              <td width="40%"> <dl> <dt>INTERNET_FLAG_HYPERLINK</dt> </dl> </td> <td width="60%"> Forces a reload if there was
///              no Expires time and no LastModified time returned from the server when determining whether to reload the item
///              from the network. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_CERT_CN_INVALID</dt> </dl>
///              </td> <td width="60%"> Disables checking of SSL/PCT-based certificates that are returned from the server against
///              the host name given in the request. WinINet functions use a simple check against certificates by comparing for
///              matching host names and simple wildcarding rules. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_IGNORE_CERT_DATE_INVALID</dt> </dl> </td> <td width="60%"> Disables checking of SSL/PCT-based
///              certificates for proper validity dates. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP</dt> </dl> </td> <td width="60%"> Disables detection of this special
///              type of redirect. When this flag is used, WinINet transparently allows redirects from HTTPS to HTTP URLs. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS</dt> </dl> </td> <td width="60%">
///              Disables the detection of this special type of redirect. When this flag is used, WinINet transparently allows
///              redirects from HTTP to HTTPS URLs. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_KEEP_CONNECTION</dt>
///              </dl> </td> <td width="60%"> Uses keep-alive semantics, if available, for the connection. This flag is required
///              for Microsoft Network (MSN), NTLM, and other types of authentication. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_AUTH</dt> </dl> </td> <td
///              width="60%"> Does not attempt authentication automatically. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_AUTO_REDIRECT</dt> </dl> </td> <td width="60%"> Does not automatically handle redirection in
///              HttpSendRequest. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_COOKIES</dt> </dl> </td> <td width="60%"> Does not automatically add cookie headers to
///              requests, and does not automatically add returned cookies to the cookie database. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_NO_UI</dt> </dl> </td> <td width="60%"> Disables the cookie dialog box. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_PASSIVE</dt> </dl> </td> <td width="60%"> Uses passive FTP
///              semantics. <b>InternetOpenUrl</b> uses this flag for FTP files and directories. </td> </tr> <tr> <td width="40%">
///              <dl> <dt>INTERNET_FLAG_PRAGMA_NOCACHE</dt> </dl> </td> <td width="60%"> Forces the request to be resolved by the
///              origin server, even if a cached copy exists on the proxy. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RAW_DATA</dt> </dl> </td> <td width="60%"> Returns the data as a WIN32_FIND_DATA structure when
///              retrieving FTP directory information. If this flag is not specified or if the call was made through a CERN proxy,
///              <b>InternetOpenUrl</b> returns the HTML version of the directory. <b>Windows XP and Windows Server 2003 R2 and
///              earlier: </b>Also returns data as a GOPHER_FIND_DATA structure when retrieving Gopher directory information.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a
///              download of the requested file, object, or directory listing from the origin server, not from the cache. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP
///              resources if the resource has been modified since the last time it was downloaded. All FTP resources are
///              reloaded. <b>Windows XP and Windows Server 2003 R2 and earlier: </b>Gopher resources are also reloaded. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_SECURE</dt> </dl> </td> <td width="60%"> Uses secure
///              transaction semantics. This translates to using Secure Sockets Layer/Private Communications Technology (SSL/PCT)
///              and is only meaningful in HTTP requests. </td> </tr> </table>
///    dwContext = A pointer to a variable that specifies the application-defined value that is passed, along with the returned
///                handle, to any callback functions.
///Returns:
///    Returns a valid handle to the URL if the connection is successfully established, or <b>NULL</b> if the connection
///    fails. To retrieve a specific error message, call GetLastError. To determine why access to the service was
///    denied, call InternetGetLastResponseInfo.
///    
@DllImport("WININET")
void* InternetOpenUrlW(void* hInternet, const(PWSTR) lpszUrl, const(PWSTR) lpszHeaders, uint dwHeadersLength, 
                       uint dwFlags, size_t dwContext);

///Reads data from a handle opened by the InternetOpenUrl, FtpOpenFile, or HttpOpenRequest function.
///Params:
///    hFile = Handle returned from a previous call to InternetOpenUrl, FtpOpenFile, or HttpOpenRequest.
///    lpBuffer = Pointer to a buffer that receives the data.
///    dwNumberOfBytesToRead = Number of bytes to be read.
///    lpdwNumberOfBytesRead = Pointer to a variable that receives the number of bytes read. <b>InternetReadFile</b> sets this value to zero
///                            before doing any work or error checking.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. An application can also use InternetGetLastResponseInfo when necessary.
///    
@DllImport("WININET")
BOOL InternetReadFile(void* hFile, void* lpBuffer, uint dwNumberOfBytesToRead, uint* lpdwNumberOfBytesRead);

///Reads data from a handle opened by the InternetOpenUrl or HttpOpenRequest function.
///Params:
///    hFile = Handle returned by the InternetOpenUrl or HttpOpenRequest function.
///    lpBuffersOut = Pointer to an INTERNET_BUFFERS structure that receives the data downloaded.
///    dwFlags = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"> <dl> <dt>IRF_ASYNC</dt> </dl> </td> <td width="60%"> Identical to WININET_API_FLAG_ASYNC. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>IRF_SYNC</dt> </dl> </td> <td width="60%"> Identical to
///              WININET_API_FLAG_SYNC. </td> </tr> <tr> <td width="40%"> <dl> <dt>IRF_USE_CONTEXT</dt> </dl> </td> <td
///              width="60%"> Identical to WININET_API_FLAG_USE_CONTEXT. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>IRF_NO_WAIT</dt> </dl> </td> <td width="60%"> Do not wait for data. If there is data available, the function
///              returns either the amount of data requested or the amount of data available (whichever is smaller). </td> </tr>
///              </table>
///    dwContext = A caller supplied context value used for asynchronous operations.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. An application can also use InternetGetLastResponseInfo when necessary.
///    
@DllImport("WININET")
BOOL InternetReadFileExA(void* hFile, INTERNET_BUFFERSA* lpBuffersOut, uint dwFlags, size_t dwContext);

///Reads data from a handle opened by the InternetOpenUrl or HttpOpenRequest function.
///Params:
///    hFile = Handle returned by the InternetOpenUrl or HttpOpenRequest function.
///    lpBuffersOut = Pointer to an INTERNET_BUFFERS structure that receives the data downloaded.
///    dwFlags = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"> <dl> <dt>IRF_ASYNC</dt> </dl> </td> <td width="60%"> Identical to WININET_API_FLAG_ASYNC. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>IRF_SYNC</dt> </dl> </td> <td width="60%"> Identical to
///              WININET_API_FLAG_SYNC. </td> </tr> <tr> <td width="40%"> <dl> <dt>IRF_USE_CONTEXT</dt> </dl> </td> <td
///              width="60%"> Identical to WININET_API_FLAG_USE_CONTEXT. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>IRF_NO_WAIT</dt> </dl> </td> <td width="60%"> Do not wait for data. If there is data available, the function
///              returns either the amount of data requested or the amount of data available (whichever is smaller). </td> </tr>
///              </table>
///    dwContext = A caller supplied context value used for asynchronous operations.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. An application can also use InternetGetLastResponseInfo when necessary.
///    
@DllImport("WININET")
BOOL InternetReadFileExW(void* hFile, INTERNET_BUFFERSW* lpBuffersOut, uint dwFlags, size_t dwContext);

///Sets a file position for InternetReadFile. This is a synchronous call; however, subsequent calls to InternetReadFile
///might block or return pending if the data is not available from the cache and the server does not support random
///access.
///Params:
///    hFile = Handle returned from a previous call to InternetOpenUrl (on an HTTP or HTTPS URL) or HttpOpenRequest (using the
///            GET or HEAD HTTP verb and passed to HttpSendRequest or HttpSendRequestEx). This handle must not have been created
///            with the INTERNET_FLAG_DONT_CACHE or INTERNET_FLAG_NO_CACHE_WRITE value set.
///    lDistanceToMove = The low order 32-bits of a signed 64-bit number of bytes to move the file pointer. <b>Internet Explorer 7 and
///                      earlier: </b><b>InternetSetFilePointer</b> used to move the pointer only within the bounds of a LONG. When
///                      calling this older version of the function, <i>lpDistanceToMoveHigh</i> is reserved and should be set to
///                      <b>0</b>. A positive value moves the pointer forward in the file; a negative value moves it backward.
///    lpDistanceToMoveHigh = A pointer to the high order 32-bits of the signed 64-bit distance to move. If you do not need the high order
///                           32-bits, this pointer must be set to <b>NULL</b>. When not <b>NULL</b>, this parameter also receives the high
///                           order DWORD of the new value of the file pointer. A positive value moves the pointer forward in the file; a
///                           negative value moves it backward.<b>Internet Explorer 7 and earlier: </b><b>InternetSetFilePointer</b> used to
///                           move the pointer only within the bounds of a LONG. When calling this older version of the function,
///                           <i>lpDistanceToMoveHigh</i> is reserved and should be set to <b>0</b>.
///    dwMoveMethod = Starting point for the file pointer move. This parameter can be one of the following values. <table> <tr>
///                   <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>FILE_BEGIN</dt> </dl> </td> <td width="60%">
///                   Starting point is zero or the beginning of the file. If FILE_BEGIN is specified, <i>lDistanceToMove</i> is
///                   interpreted as an unsigned location for the new file pointer. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>FILE_CURRENT</dt> </dl> </td> <td width="60%"> Current value of the file pointer is the starting point. </td>
///                   </tr> <tr> <td width="40%"> <dl> <dt>FILE_END</dt> </dl> </td> <td width="60%"> Current end-of-file position is
///                   the starting point. This method fails if the content length is unknown. </td> </tr> </table>
///    dwContext = This parameter is reserved and must be 0.
///Returns:
///    I the function succeeds, it returns the current file position. A return value of <b>INVALID_SET_FILE_POINTER</b>
///    indicates a potential failure and needs to be followed by be a call to GetLastError. Since
///    <b>INVALID_SET_FILE_POINTER</b> is a valid value for the low-order DWORD of the new file pointer, the caller must
///    check both the return value of the function and the error code returned by GetLastError to determine whether or
///    not an error has occurred. If an error has occurred, the return value of InternetSetFilePointer is
///    <b>INVALID_SET_FILE_POINTER</b> and <b>GetLastError</b> returns a value other than <b>NO_ERROR</b>. If the
///    function succeeds and <i>lpDistanceToMoveHigh</i> is <b>NULL</b>, the return value is the low-order <b>DWORD</b>
///    of the new file pointer. Note that if the function returns a value other than <b>INVALID_SET_FILE_POINTER</b>,
///    the call to <b>InternetSetFilePointer</b>has succeeded and there is no need to call GetLastError. If the function
///    succeeds and <i>lpDistanceToMoveHigh</i> is not <b>NULL</b>, the return value is the lower-order <b>DWORD</b> of
///    the new file pointer and <i>lpDistanceToMoveHigh</i> contains the high order <b>DWORD</b> of the new file
///    pointer. If a new file pointer is a negative value, the function fails, the file pointer is not moved, and the
///    code returned by GetLastError is <b>ERROR_NEGATIVE_SEEK</b>. If <i>lpDistanceToMoveHigh</i> is <b>NULL</b> and
///    the new file position does not fit in a 32-bit value the function fails and returns
///    <b>INVALID_SET_FILE_POINTER</b>.
///    
@DllImport("WININET")
uint InternetSetFilePointer(void* hFile, int lDistanceToMove, int* lpDistanceToMoveHigh, uint dwMoveMethod, 
                            size_t dwContext);

///Writes data to an open Internet file.
///Params:
///    hFile = Handle returned from a previous call to FtpOpenFile or an HINTERNET handle sent by HttpSendRequestEx.
///    lpBuffer = Pointer to a buffer that contains the data to be written to the file.
///    dwNumberOfBytesToWrite = Number of bytes to be written to the file.
///    lpdwNumberOfBytesWritten = Pointer to a variable that receives the number of bytes written to the file. <b>InternetWriteFile</b> sets this
///                               value to zero before doing any work or error checking.
///Returns:
///    Returns TRUE if the function succeeds, or FALSE otherwise. To get extended error information, call GetLastError.
///    An application can also use InternetGetLastResponseInfo when necessary.
///    
@DllImport("WININET")
BOOL InternetWriteFile(void* hFile, const(void)* lpBuffer, uint dwNumberOfBytesToWrite, 
                       uint* lpdwNumberOfBytesWritten);

///Queries the server to determine the amount of data available.
///Params:
///    hFile = Handle returned by the InternetOpenUrl, FtpOpenFile, GopherOpenFile, or HttpOpenRequest function.
///    lpdwNumberOfBytesAvailable = Pointer to a variable that receives the number of available bytes. May be <b>NULL</b>.
///    dwFlags = This parameter is reserved and must be 0.
///    dwContext = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. If the function finds no matching files, <b>GetLastError</b> returns ERROR_NO_MORE_FILES.
///    
@DllImport("WININET")
BOOL InternetQueryDataAvailable(void* hFile, uint* lpdwNumberOfBytesAvailable, uint dwFlags, size_t dwContext);

///Continues a file search started as a result of a previous call to FtpFindFirstFile. <b>Windows XP and Windows Server
///2003 R2 and earlier: </b>Or continues a file search as a result of a previous call to GopherFindFirstFile.
///Params:
///    hFind = Handle returned from either FtpFindFirstFile or InternetOpenUrl (directories only). <b>Windows XP and Windows
///            Server 2003 R2 and earlier: </b>Also a handle returned from GopherFindFirstFile.
///    lpvFindData = Pointer to the buffer that receives information about the file or directory. The format of the information placed
///                  in the buffer depends on the protocol in use. The FTP protocol returns a WIN32_FIND_DATA structure. <b>Windows XP
///                  and Windows Server 2003 R2 and earlier: </b>The Gopher protocol returns a GOPHER_FIND_DATA structure.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. If the function finds no matching files, <b>GetLastError</b> returns <b>ERROR_NO_MORE_FILES</b>.
///    
@DllImport("WININET")
BOOL InternetFindNextFileA(void* hFind, void* lpvFindData);

///Continues a file search started as a result of a previous call to FtpFindFirstFile. <b>Windows XP and Windows Server
///2003 R2 and earlier: </b>Or continues a file search as a result of a previous call to GopherFindFirstFile.
///Params:
///    hFind = Handle returned from either FtpFindFirstFile or InternetOpenUrl (directories only). <b>Windows XP and Windows
///            Server 2003 R2 and earlier: </b>Also a handle returned from GopherFindFirstFile.
///    lpvFindData = Pointer to the buffer that receives information about the file or directory. The format of the information placed
///                  in the buffer depends on the protocol in use. The FTP protocol returns a WIN32_FIND_DATA structure. <b>Windows XP
///                  and Windows Server 2003 R2 and earlier: </b>The Gopher protocol returns a GOPHER_FIND_DATA structure.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. If the function finds no matching files, <b>GetLastError</b> returns <b>ERROR_NO_MORE_FILES</b>.
///    
@DllImport("WININET")
BOOL InternetFindNextFileW(void* hFind, void* lpvFindData);

///Queries an Internet option on the specified handle.
///Params:
///    hInternet = Handle on which to query information.
///    dwOption = Internet option to be queried. This can be one of the Option Flags values.
///    lpBuffer = Pointer to a buffer that receives the option setting. Strings returned by <b>InternetQueryOption</b> are globally
///               allocated, so the calling application must free them when it is finished using them.
///    lpdwBufferLength = Pointer to a variable that contains the size of <i>lpBuffer</i>, in bytes. When <b>InternetQueryOption</b>
///                       returns, <i>lpdwBufferLength</i> specifies the size of the data placed into <i>lpBuffer</i>. If GetLastError
///                       returns ERROR_INSUFFICIENT_BUFFER, this parameter points to the number of bytes required to hold the requested
///                       information.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetQueryOptionA(void* hInternet, uint dwOption, void* lpBuffer, uint* lpdwBufferLength);

///Queries an Internet option on the specified handle.
///Params:
///    hInternet = Handle on which to query information.
///    dwOption = Internet option to be queried. This can be one of the Option Flags values.
///    lpBuffer = Pointer to a buffer that receives the option setting. Strings returned by <b>InternetQueryOption</b> are globally
///               allocated, so the calling application must free them when it is finished using them.
///    lpdwBufferLength = Pointer to a variable that contains the size of <i>lpBuffer</i>, in bytes. When <b>InternetQueryOption</b>
///                       returns, <i>lpdwBufferLength</i> specifies the size of the data placed into <i>lpBuffer</i>. If GetLastError
///                       returns ERROR_INSUFFICIENT_BUFFER, this parameter points to the number of bytes required to hold the requested
///                       information.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetQueryOptionW(void* hInternet, uint dwOption, void* lpBuffer, uint* lpdwBufferLength);

///Sets an Internet option.
///Params:
///    hInternet = Handle on which to set information.
///    dwOption = Internet option to be set. This can be one of the Option Flags values.
///    lpBuffer = Pointer to a buffer that contains the option setting.
///    dwBufferLength = Size of the <i>lpBuffer</i> buffer. If <i>lpBuffer</i> contains a string, the size is in <b>TCHARs</b>. If
///                     <i>lpBuffer</i> contains anything other than a string, the size is in bytes.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetSetOptionA(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength);

///Sets an Internet option.
///Params:
///    hInternet = Handle on which to set information.
///    dwOption = Internet option to be set. This can be one of the Option Flags values.
///    lpBuffer = Pointer to a buffer that contains the option setting.
///    dwBufferLength = Size of the <i>lpBuffer</i> buffer. If <i>lpBuffer</i> contains a string, the size is in <b>TCHARs</b>. If
///                     <i>lpBuffer</i> contains anything other than a string, the size is in bytes.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetSetOptionW(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength);

///Not supported. Implemented only as a stub that calls the InternetSetOption function; <b>InternetSetOptionEx</b> has
///no functionality of its own. Do not use this function at this time.
///Params:
///    hInternet = Unused.
///    dwOption = Unused.
///    lpBuffer = Unused.
///    dwBufferLength = Unused.
///    dwFlags = Unused.
///Returns:
///    This function does not return a value.
///    
@DllImport("WININET")
BOOL InternetSetOptionExA(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength, uint dwFlags);

///Not supported. Implemented only as a stub that calls the InternetSetOption function; <b>InternetSetOptionEx</b> has
///no functionality of its own. Do not use this function at this time.
///Params:
///    hInternet = Unused.
///    dwOption = Unused.
///    lpBuffer = Unused.
///    dwBufferLength = Unused.
///    dwFlags = Unused.
///Returns:
///    This function does not return a value.
///    
@DllImport("WININET")
BOOL InternetSetOptionExW(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength, uint dwFlags);

///Places a lock on the file that is being used.
///Params:
///    hInternet = Handle returned by the FtpOpenFile, GopherOpenFile, HttpOpenRequest, or InternetOpenUrl function.
///    lphLockRequestInfo = Pointer to a handle that receives the lock request handle.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetLockRequestFile(void* hInternet, HANDLE* lphLockRequestInfo);

///Unlocks a file that was locked using InternetLockRequestFile.
///Params:
///    hLockRequestInfo = Handle to a lock request that was returned by InternetLockRequestFile.
///Returns:
///    Returns TRUE if successful, or FALSE otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetUnlockRequestFile(HANDLE hLockRequestInfo);

///Retrieves the last error description or server response on the thread calling this function.
///Params:
///    lpdwError = Pointer to a variable that receives an error message pertaining to the operation that failed.
///    lpszBuffer = Pointer to a buffer that receives the error text.
///    lpdwBufferLength = Pointer to a variable that contains the size of the <i>lpszBuffer</i> buffer, in <b>TCHARs</b>. When the function
///                       returns, this parameter contains the size of the string written to the buffer, not including the terminating
///                       zero.
///Returns:
///    Returns <b>TRUE</b> if error text was successfully written to the buffer, or <b>FALSE</b> otherwise. To get
///    extended error information, call GetLastError. If the buffer is too small to hold all the error text,
///    <b>GetLastError</b> returns <b>ERROR_INSUFFICIENT_BUFFER</b>, and the <i>lpdwBufferLength</i> parameter contains
///    the minimum buffer size required to return all the error text.
///    
@DllImport("WININET")
BOOL InternetGetLastResponseInfoA(uint* lpdwError, PSTR lpszBuffer, uint* lpdwBufferLength);

///Retrieves the last error description or server response on the thread calling this function.
///Params:
///    lpdwError = Pointer to a variable that receives an error message pertaining to the operation that failed.
///    lpszBuffer = Pointer to a buffer that receives the error text.
///    lpdwBufferLength = Pointer to a variable that contains the size of the <i>lpszBuffer</i> buffer, in <b>TCHARs</b>. When the function
///                       returns, this parameter contains the size of the string written to the buffer, not including the terminating
///                       zero.
///Returns:
///    Returns <b>TRUE</b> if error text was successfully written to the buffer, or <b>FALSE</b> otherwise. To get
///    extended error information, call GetLastError. If the buffer is too small to hold all the error text,
///    <b>GetLastError</b> returns <b>ERROR_INSUFFICIENT_BUFFER</b>, and the <i>lpdwBufferLength</i> parameter contains
///    the minimum buffer size required to return all the error text.
///    
@DllImport("WININET")
BOOL InternetGetLastResponseInfoW(uint* lpdwError, PWSTR lpszBuffer, uint* lpdwBufferLength);

///The InternetSetStatusCallback function sets up a callback function that WinINet functions can call as progress is
///made during an operation.
///Params:
///    hInternet = The handle for which the callback is set.
///    lpfnInternetCallback = A pointer to the callback function to call when progress is made, or <b>NULL</b> to remove the existing callback
///                           function. For more information about the callback function, see InternetStatusCallback.
///Returns:
///    Returns the previously defined status callback function if successful, <b>NULL</b> if there was no previously
///    defined status callback function, or INTERNET_INVALID_STATUS_CALLBACK if the callback function is not valid.
///    
@DllImport("WININET")
INTERNET_STATUS_CALLBACK InternetSetStatusCallbackA(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

///The InternetSetStatusCallback function sets up a callback function that WinINet functions can call as progress is
///made during an operation.
///Params:
///    hInternet = The handle for which the callback is set.
///    lpfnInternetCallback = A pointer to the callback function to call when progress is made, or <b>NULL</b> to remove the existing callback
///                           function. For more information about the callback function, see InternetStatusCallback.
///Returns:
///    Returns the previously defined status callback function if successful, <b>NULL</b> if there was no previously
///    defined status callback function, or INTERNET_INVALID_STATUS_CALLBACK if the callback function is not valid.
///    
@DllImport("WININET")
INTERNET_STATUS_CALLBACK InternetSetStatusCallbackW(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

///The InternetSetStatusCallback function sets up a callback function that WinINet functions can call as progress is
///made during an operation.
///Params:
///    hInternet = The handle for which the callback is set.
///    lpfnInternetCallback = A pointer to the callback function to call when progress is made, or <b>NULL</b> to remove the existing callback
///                           function. For more information about the callback function, see InternetStatusCallback.
///Returns:
///    Returns the previously defined status callback function if successful, <b>NULL</b> if there was no previously
///    defined status callback function, or INTERNET_INVALID_STATUS_CALLBACK if the callback function is not valid.
///    
@DllImport("WININET")
INTERNET_STATUS_CALLBACK InternetSetStatusCallback(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

///Searches the specified directory of the given FTP session. File and directory entries are returned to the application
///in the WIN32_FIND_DATA structure.
///Params:
///    hConnect = Handle to an FTP session returned from InternetConnect.
///    lpszSearchFile = Pointer to a <b>null</b>-terminated string that specifies a valid directory path or file name for the FTP
///                     server's file system. The string can contain wildcards, but no blank spaces are allowed. If the value of
///                     <i>lpszSearchFile</i> is <b>NULL</b> or if it is an empty string, the function finds the first file in the
///                     current directory on the server.
///    lpFindFileData = Pointer to a WIN32_FIND_DATA structure that receives information about the found file or directory.
///    dwFlags = Controls the behavior of this function. This parameter can be a combination of the following values. <p
///              class="indent">INTERNET_FLAG_HYPERLINK <p class="indent">INTERNET_FLAG_NEED_FILE <p
///              class="indent">INTERNET_FLAG_NO_CACHE_WRITE <p class="indent">INTERNET_FLAG_RELOAD <p
///              class="indent">INTERNET_FLAG_RESYNCHRONIZE
///    dwContext = Pointer to a variable that specifies the application-defined value that associates this search with any
///                application data. This parameter is used only if the application has already called InternetSetStatusCallback to
///                set up a status callback function.
///Returns:
///    Returns a valid handle for the request if the directory enumeration was started successfully, or returns
///    <b>NULL</b> otherwise. To get a specific error message, call GetLastError. If <b>GetLastError</b> returns
///    ERROR_INTERNET_EXTENDED_ERROR, as in the case where the function finds no matching files, call the
///    InternetGetLastResponseInfo function to retrieve the extended error text, as documented in Handling Errors.
///    
@DllImport("WININET")
void* FtpFindFirstFileA(void* hConnect, const(PSTR) lpszSearchFile, WIN32_FIND_DATAA* lpFindFileData, uint dwFlags, 
                        size_t dwContext);

///Searches the specified directory of the given FTP session. File and directory entries are returned to the application
///in the WIN32_FIND_DATA structure.
///Params:
///    hConnect = Handle to an FTP session returned from InternetConnect.
///    lpszSearchFile = Pointer to a <b>null</b>-terminated string that specifies a valid directory path or file name for the FTP
///                     server's file system. The string can contain wildcards, but no blank spaces are allowed. If the value of
///                     <i>lpszSearchFile</i> is <b>NULL</b> or if it is an empty string, the function finds the first file in the
///                     current directory on the server.
///    lpFindFileData = Pointer to a WIN32_FIND_DATA structure that receives information about the found file or directory.
///    dwFlags = Controls the behavior of this function. This parameter can be a combination of the following values. <p
///              class="indent">INTERNET_FLAG_HYPERLINK <p class="indent">INTERNET_FLAG_NEED_FILE <p
///              class="indent">INTERNET_FLAG_NO_CACHE_WRITE <p class="indent">INTERNET_FLAG_RELOAD <p
///              class="indent">INTERNET_FLAG_RESYNCHRONIZE
///    dwContext = Pointer to a variable that specifies the application-defined value that associates this search with any
///                application data. This parameter is used only if the application has already called InternetSetStatusCallback to
///                set up a status callback function.
///Returns:
///    Returns a valid handle for the request if the directory enumeration was started successfully, or returns
///    <b>NULL</b> otherwise. To get a specific error message, call GetLastError. If <b>GetLastError</b> returns
///    ERROR_INTERNET_EXTENDED_ERROR, as in the case where the function finds no matching files, call the
///    InternetGetLastResponseInfo function to retrieve the extended error text, as documented in Handling Errors.
///    
@DllImport("WININET")
void* FtpFindFirstFileW(void* hConnect, const(PWSTR) lpszSearchFile, WIN32_FIND_DATAW* lpFindFileData, 
                        uint dwFlags, size_t dwContext);

///Retrieves a file from the FTP server and stores it under the specified file name, creating a new local file in the
///process.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszRemoteFile = Pointer to a null-terminated string that contains the name of the file to be retrieved.
///    lpszNewFile = Pointer to a null-terminated string that contains the name of the file to be created on the local system.
///    fFailIfExists = Indicates whether the function should proceed if a local file of the specified name already exists. If
///                    <i>fFailIfExists</i> is <b>TRUE</b> and the local file exists, <b>FtpGetFile</b> fails.
///    dwFlagsAndAttributes = File attributes for the new file. This parameter can be any combination of the FILE_ATTRIBUTE_* flags used by the
///                           CreateFile function.
///    dwFlags = Controls how the function will handle the file download. The first set of flag values indicates the conditions
///              under which the transfer occurs. These transfer type flags can be used in combination with the second set of
///              flags that control caching. The application can select one of these transfer type values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_ASCII"></a><a
///              id="ftp_transfer_type_ascii"></a><dl> <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt> </dl> </td> <td width="60%">
///              Transfers the file using FTP's ASCII (Type A) transfer method. Control and formatting information is converted to
///              local equivalents. </td> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_BINARY"></a><a
///              id="ftp_transfer_type_binary"></a><dl> <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%">
///              Transfers the file using FTP's Image (Type I) transfer method. The file is transferred exactly as it exists with
///              no changes. This is the default transfer method. </td> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_UNKNOWN"></a><a id="ftp_transfer_type_unknown"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%"> Defaults to FTP_TRANSFER_TYPE_BINARY.
///              </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_TRANSFER_ASCII"></a><a
///              id="internet_flag_transfer_ascii"></a><dl> <dt><b>INTERNET_FLAG_TRANSFER_ASCII</b></dt> </dl> </td> <td
///              width="60%"> Transfers the file as ASCII. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_TRANSFER_BINARY"></a><a id="internet_flag_transfer_binary"></a><dl>
///              <dt><b>INTERNET_FLAG_TRANSFER_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file as binary. </td>
///              </tr> </table> The following flags determine how the caching of this file will be done. Any combination of the
///              following flags can be used with the transfer type flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="INTERNET_FLAG_HYPERLINK"></a><a id="internet_flag_hyperlink"></a><dl>
///              <dt><b>INTERNET_FLAG_HYPERLINK</b></dt> </dl> </td> <td width="60%"> Forces a reload if there was no Expires time
///              and no LastModified time returned from the server when determining whether to reload the item from the network.
///              </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_NEED_FILE"></a><a id="internet_flag_need_file"></a><dl>
///              <dt><b>INTERNET_FLAG_NEED_FILE</b></dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the
///              file cannot be cached. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RELOAD"></a><a
///              id="internet_flag_reload"></a><dl> <dt><b>INTERNET_FLAG_RELOAD</b></dt> </dl> </td> <td width="60%"> Forces a
///              download of the requested file, object, or directory listing from the origin server, not from the cache. </td>
///              </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESYNCHRONIZE"></a><a id="internet_flag_resynchronize"></a><dl>
///              <dt><b>INTERNET_FLAG_RESYNCHRONIZE</b></dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource
///              has been modified since the last time it was downloaded. All FTP resources are reloaded. <b>Windows XP and
///              Windows Server 2003 R2 and earlier: </b>Gopher resources are also reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data. This is used only if the application has already called InternetSetStatusCallback to set up a
///                status callback function.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpGetFileA(void* hConnect, const(PSTR) lpszRemoteFile, const(PSTR) lpszNewFile, BOOL fFailIfExists, 
                 uint dwFlagsAndAttributes, uint dwFlags, size_t dwContext);

///Retrieves a file from the FTP server and stores it under the specified file name, creating a new local file in the
///process.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszRemoteFile = Pointer to a null-terminated string that contains the name of the file to be retrieved.
///    lpszNewFile = Pointer to a null-terminated string that contains the name of the file to be created on the local system.
///    fFailIfExists = Indicates whether the function should proceed if a local file of the specified name already exists. If
///                    <i>fFailIfExists</i> is <b>TRUE</b> and the local file exists, <b>FtpGetFile</b> fails.
///    dwFlagsAndAttributes = File attributes for the new file. This parameter can be any combination of the FILE_ATTRIBUTE_* flags used by the
///                           CreateFile function.
///    dwFlags = Controls how the function will handle the file download. The first set of flag values indicates the conditions
///              under which the transfer occurs. These transfer type flags can be used in combination with the second set of
///              flags that control caching. The application can select one of these transfer type values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_ASCII"></a><a
///              id="ftp_transfer_type_ascii"></a><dl> <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt> </dl> </td> <td width="60%">
///              Transfers the file using FTP's ASCII (Type A) transfer method. Control and formatting information is converted to
///              local equivalents. </td> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_BINARY"></a><a
///              id="ftp_transfer_type_binary"></a><dl> <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%">
///              Transfers the file using FTP's Image (Type I) transfer method. The file is transferred exactly as it exists with
///              no changes. This is the default transfer method. </td> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_UNKNOWN"></a><a id="ftp_transfer_type_unknown"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%"> Defaults to FTP_TRANSFER_TYPE_BINARY.
///              </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_TRANSFER_ASCII"></a><a
///              id="internet_flag_transfer_ascii"></a><dl> <dt><b>INTERNET_FLAG_TRANSFER_ASCII</b></dt> </dl> </td> <td
///              width="60%"> Transfers the file as ASCII. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_TRANSFER_BINARY"></a><a id="internet_flag_transfer_binary"></a><dl>
///              <dt><b>INTERNET_FLAG_TRANSFER_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file as binary. </td>
///              </tr> </table> The following flags determine how the caching of this file will be done. Any combination of the
///              following flags can be used with the transfer type flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="INTERNET_FLAG_HYPERLINK"></a><a id="internet_flag_hyperlink"></a><dl>
///              <dt><b>INTERNET_FLAG_HYPERLINK</b></dt> </dl> </td> <td width="60%"> Forces a reload if there was no Expires time
///              and no LastModified time returned from the server when determining whether to reload the item from the network.
///              </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_NEED_FILE"></a><a id="internet_flag_need_file"></a><dl>
///              <dt><b>INTERNET_FLAG_NEED_FILE</b></dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the
///              file cannot be cached. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RELOAD"></a><a
///              id="internet_flag_reload"></a><dl> <dt><b>INTERNET_FLAG_RELOAD</b></dt> </dl> </td> <td width="60%"> Forces a
///              download of the requested file, object, or directory listing from the origin server, not from the cache. </td>
///              </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESYNCHRONIZE"></a><a id="internet_flag_resynchronize"></a><dl>
///              <dt><b>INTERNET_FLAG_RESYNCHRONIZE</b></dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource
///              has been modified since the last time it was downloaded. All FTP resources are reloaded. <b>Windows XP and
///              Windows Server 2003 R2 and earlier: </b>Gopher resources are also reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data. This is used only if the application has already called InternetSetStatusCallback to set up a
///                status callback function.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpGetFileW(void* hConnect, const(PWSTR) lpszRemoteFile, const(PWSTR) lpszNewFile, BOOL fFailIfExists, 
                 uint dwFlagsAndAttributes, uint dwFlags, size_t dwContext);

///Stores a file on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszLocalFile = Pointer to a null-terminated string that contains the name of the file to be sent from the local system.
///    lpszNewRemoteFile = Pointer to a null-terminated string that contains the name of the file to be created on the remote system.
///    dwFlags = Conditions under which the transfers occur. The application should select one transfer type and any of the flags
///              that control how the caching of the file will be controlled. The transfer type can be any one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_ASCII"></a><a id="ftp_transfer_type_ascii"></a><dl> <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt>
///              </dl> </td> <td width="60%"> Transfers the file using FTP's ASCII (Type A) transfer method. Control and
///              formatting information is converted to local equivalents. </td> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_BINARY"></a><a id="ftp_transfer_type_binary"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file using FTP's Image (Type
///              I) transfer method. The file is transferred exactly as it exists with no changes. This is the default transfer
///              method. </td> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_UNKNOWN"></a><a
///              id="ftp_transfer_type_unknown"></a><dl> <dt><b>FTP_TRANSFER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%">
///              Defaults to FTP_TRANSFER_TYPE_BINARY. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_TRANSFER_ASCII"></a><a id="internet_flag_transfer_ascii"></a><dl>
///              <dt><b>INTERNET_FLAG_TRANSFER_ASCII</b></dt> </dl> </td> <td width="60%"> Transfers the file as ASCII. </td>
///              </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_TRANSFER_BINARY"></a><a
///              id="internet_flag_transfer_binary"></a><dl> <dt><b>INTERNET_FLAG_TRANSFER_BINARY</b></dt> </dl> </td> <td
///              width="60%"> Transfers the file as binary. </td> </tr> </table> The following values are used to control the
///              caching of the file. The application can use one or more of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_HYPERLINK"></a><a
///              id="internet_flag_hyperlink"></a><dl> <dt><b>INTERNET_FLAG_HYPERLINK</b></dt> </dl> </td> <td width="60%"> Forces
///              a reload if there was no Expires time and no LastModified time returned from the server when determining whether
///              to reload the item from the network. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_NEED_FILE"></a><a
///              id="internet_flag_need_file"></a><dl> <dt><b>INTERNET_FLAG_NEED_FILE</b></dt> </dl> </td> <td width="60%"> Causes
///              a temporary file to be created if the file cannot be cached. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_RELOAD"></a><a id="internet_flag_reload"></a><dl> <dt><b>INTERNET_FLAG_RELOAD</b></dt> </dl>
///              </td> <td width="60%"> Forces a download of the requested file, object, or directory listing from the origin
///              server, not from the cache. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESYNCHRONIZE"></a><a
///              id="internet_flag_resynchronize"></a><dl> <dt><b>INTERNET_FLAG_RESYNCHRONIZE</b></dt> </dl> </td> <td
///              width="60%"> Reloads HTTP resources if the resource has been modified since the last time it was downloaded. All
///              FTP resources are reloaded. <b>Windows XP and Windows Server 2003 R2 and earlier: </b>Gopher resources are also
///              reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data. This parameter is used only if the application has already called InternetSetStatusCallback to
///                set up a status callback.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpPutFileA(void* hConnect, const(PSTR) lpszLocalFile, const(PSTR) lpszNewRemoteFile, uint dwFlags, 
                 size_t dwContext);

///Stores a file on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszLocalFile = Pointer to a null-terminated string that contains the name of the file to be sent from the local system.
///    lpszNewRemoteFile = Pointer to a null-terminated string that contains the name of the file to be created on the remote system.
///    dwFlags = Conditions under which the transfers occur. The application should select one transfer type and any of the flags
///              that control how the caching of the file will be controlled. The transfer type can be any one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_ASCII"></a><a id="ftp_transfer_type_ascii"></a><dl> <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt>
///              </dl> </td> <td width="60%"> Transfers the file using FTP's ASCII (Type A) transfer method. Control and
///              formatting information is converted to local equivalents. </td> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_BINARY"></a><a id="ftp_transfer_type_binary"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file using FTP's Image (Type
///              I) transfer method. The file is transferred exactly as it exists with no changes. This is the default transfer
///              method. </td> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_UNKNOWN"></a><a
///              id="ftp_transfer_type_unknown"></a><dl> <dt><b>FTP_TRANSFER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%">
///              Defaults to FTP_TRANSFER_TYPE_BINARY. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_TRANSFER_ASCII"></a><a id="internet_flag_transfer_ascii"></a><dl>
///              <dt><b>INTERNET_FLAG_TRANSFER_ASCII</b></dt> </dl> </td> <td width="60%"> Transfers the file as ASCII. </td>
///              </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_TRANSFER_BINARY"></a><a
///              id="internet_flag_transfer_binary"></a><dl> <dt><b>INTERNET_FLAG_TRANSFER_BINARY</b></dt> </dl> </td> <td
///              width="60%"> Transfers the file as binary. </td> </tr> </table> The following values are used to control the
///              caching of the file. The application can use one or more of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_HYPERLINK"></a><a
///              id="internet_flag_hyperlink"></a><dl> <dt><b>INTERNET_FLAG_HYPERLINK</b></dt> </dl> </td> <td width="60%"> Forces
///              a reload if there was no Expires time and no LastModified time returned from the server when determining whether
///              to reload the item from the network. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_NEED_FILE"></a><a
///              id="internet_flag_need_file"></a><dl> <dt><b>INTERNET_FLAG_NEED_FILE</b></dt> </dl> </td> <td width="60%"> Causes
///              a temporary file to be created if the file cannot be cached. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_RELOAD"></a><a id="internet_flag_reload"></a><dl> <dt><b>INTERNET_FLAG_RELOAD</b></dt> </dl>
///              </td> <td width="60%"> Forces a download of the requested file, object, or directory listing from the origin
///              server, not from the cache. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESYNCHRONIZE"></a><a
///              id="internet_flag_resynchronize"></a><dl> <dt><b>INTERNET_FLAG_RESYNCHRONIZE</b></dt> </dl> </td> <td
///              width="60%"> Reloads HTTP resources if the resource has been modified since the last time it was downloaded. All
///              FTP resources are reloaded. <b>Windows XP and Windows Server 2003 R2 and earlier: </b>Gopher resources are also
///              reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data. This parameter is used only if the application has already called InternetSetStatusCallback to
///                set up a status callback.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpPutFileW(void* hConnect, const(PWSTR) lpszLocalFile, const(PWSTR) lpszNewRemoteFile, uint dwFlags, 
                 size_t dwContext);

@DllImport("WININET")
BOOL FtpGetFileEx(void* hFtpSession, const(PSTR) lpszRemoteFile, const(PWSTR) lpszNewFile, BOOL fFailIfExists, 
                  uint dwFlagsAndAttributes, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL FtpPutFileEx(void* hFtpSession, const(PWSTR) lpszLocalFile, const(PSTR) lpszNewRemoteFile, uint dwFlags, 
                  size_t dwContext);

///Deletes a file stored on the FTP server.
///Params:
///    hConnect = Handle returned by a previous call to InternetConnect using <b>INTERNET_SERVICE_FTP</b>.
///    lpszFileName = Pointer to a null-terminated string that contains the name of the file to be deleted.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpDeleteFileA(void* hConnect, const(PSTR) lpszFileName);

///Deletes a file stored on the FTP server.
///Params:
///    hConnect = Handle returned by a previous call to InternetConnect using <b>INTERNET_SERVICE_FTP</b>.
///    lpszFileName = Pointer to a null-terminated string that contains the name of the file to be deleted.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpDeleteFileW(void* hConnect, const(PWSTR) lpszFileName);

///Renames a file stored on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszExisting = Pointer to a null-terminated string that contains the name of the file to be renamed.
///    lpszNew = Pointer to a null-terminated string that contains the new name for the remote file.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpRenameFileA(void* hConnect, const(PSTR) lpszExisting, const(PSTR) lpszNew);

///Renames a file stored on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszExisting = Pointer to a null-terminated string that contains the name of the file to be renamed.
///    lpszNew = Pointer to a null-terminated string that contains the new name for the remote file.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpRenameFileW(void* hConnect, const(PWSTR) lpszExisting, const(PWSTR) lpszNew);

///Initiates access to a remote file on an FTP server for reading or writing.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszFileName = Pointer to a null-terminated string that contains the name of the file to be accessed.
///    dwAccess = File access. This parameter can be <b>GENERIC_READ</b> or <b>GENERIC_WRITE</b>, but not both.
///    dwFlags = Conditions under which the transfers occur. The application should select one transfer type and any of the flags
///              that indicate how the caching of the file will be controlled. The transfer type can be one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_ASCII"></a><a id="ftp_transfer_type_ascii"></a><dl> <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt>
///              </dl> </td> <td width="60%"> Transfers the file using FTP's ASCII (Type A) transfer method. Control and
///              formatting information is converted to local equivalents. </td> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_BINARY"></a><a id="ftp_transfer_type_binary"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file using FTP's Image (Type
///              I) transfer method. The file is transferred exactly as it exists with no changes. This is the default transfer
///              method. </td> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_UNKNOWN"></a><a
///              id="ftp_transfer_type_unknown"></a><dl> <dt><b>FTP_TRANSFER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%">
///              Defaults to FTP_TRANSFER_TYPE_BINARY. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_TRANSFER_ASCII"></a><a id="internet_flag_transfer_ascii"></a><dl>
///              <dt><b>INTERNET_FLAG_TRANSFER_ASCII</b></dt> </dl> </td> <td width="60%"> Transfers the file as ASCII. </td>
///              </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_TRANSFER_BINARY"></a><a
///              id="internet_flag_transfer_binary"></a><dl> <dt><b>INTERNET_FLAG_TRANSFER_BINARY</b></dt> </dl> </td> <td
///              width="60%"> Transfers the file as binary. </td> </tr> </table> The following values are used to control the
///              caching of the file. The application can use one or more of these values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_HYPERLINK"></a><a
///              id="internet_flag_hyperlink"></a><dl> <dt><b>INTERNET_FLAG_HYPERLINK</b></dt> </dl> </td> <td width="60%"> Forces
///              a reload if there was no Expires time and no LastModified time returned from the server when determining whether
///              to reload the item from the network. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_NEED_FILE"></a><a
///              id="internet_flag_need_file"></a><dl> <dt><b>INTERNET_FLAG_NEED_FILE</b></dt> </dl> </td> <td width="60%"> Causes
///              a temporary file to be created if the file cannot be cached. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_RELOAD"></a><a id="internet_flag_reload"></a><dl> <dt><b>INTERNET_FLAG_RELOAD</b></dt> </dl>
///              </td> <td width="60%"> Forces a download of the requested file, object, or directory listing from the origin
///              server, not from the cache. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESYNCHRONIZE"></a><a
///              id="internet_flag_resynchronize"></a><dl> <dt><b>INTERNET_FLAG_RESYNCHRONIZE</b></dt> </dl> </td> <td
///              width="60%"> Reloads HTTP resources if the resource has been modified since the last time it was downloaded. All
///              FTP resources are reloaded. <b>Windows XP and Windows Server 2003 R2 and earlier: </b>Gopher resources are also
///              reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data. This is only used if the application has already called InternetSetStatusCallback to set up a
///                status callback function.
///Returns:
///    Returns a handle if successful, or <b>NULL</b> otherwise. To retrieve a specific error message, call
///    GetLastError.
///    
@DllImport("WININET")
void* FtpOpenFileA(void* hConnect, const(PSTR) lpszFileName, uint dwAccess, uint dwFlags, size_t dwContext);

///Initiates access to a remote file on an FTP server for reading or writing.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszFileName = Pointer to a null-terminated string that contains the name of the file to be accessed.
///    dwAccess = File access. This parameter can be <b>GENERIC_READ</b> or <b>GENERIC_WRITE</b>, but not both.
///    dwFlags = Conditions under which the transfers occur. The application should select one transfer type and any of the flags
///              that indicate how the caching of the file will be controlled. The transfer type can be one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_ASCII"></a><a id="ftp_transfer_type_ascii"></a><dl> <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt>
///              </dl> </td> <td width="60%"> Transfers the file using FTP's ASCII (Type A) transfer method. Control and
///              formatting information is converted to local equivalents. </td> </tr> <tr> <td width="40%"><a
///              id="FTP_TRANSFER_TYPE_BINARY"></a><a id="ftp_transfer_type_binary"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file using FTP's Image (Type
///              I) transfer method. The file is transferred exactly as it exists with no changes. This is the default transfer
///              method. </td> </tr> <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_UNKNOWN"></a><a
///              id="ftp_transfer_type_unknown"></a><dl> <dt><b>FTP_TRANSFER_TYPE_UNKNOWN</b></dt> </dl> </td> <td width="60%">
///              Defaults to FTP_TRANSFER_TYPE_BINARY. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_TRANSFER_ASCII"></a><a id="internet_flag_transfer_ascii"></a><dl>
///              <dt><b>INTERNET_FLAG_TRANSFER_ASCII</b></dt> </dl> </td> <td width="60%"> Transfers the file as ASCII. </td>
///              </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_TRANSFER_BINARY"></a><a
///              id="internet_flag_transfer_binary"></a><dl> <dt><b>INTERNET_FLAG_TRANSFER_BINARY</b></dt> </dl> </td> <td
///              width="60%"> Transfers the file as binary. </td> </tr> </table> The following values are used to control the
///              caching of the file. The application can use one or more of these values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_HYPERLINK"></a><a
///              id="internet_flag_hyperlink"></a><dl> <dt><b>INTERNET_FLAG_HYPERLINK</b></dt> </dl> </td> <td width="60%"> Forces
///              a reload if there was no Expires time and no LastModified time returned from the server when determining whether
///              to reload the item from the network. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_NEED_FILE"></a><a
///              id="internet_flag_need_file"></a><dl> <dt><b>INTERNET_FLAG_NEED_FILE</b></dt> </dl> </td> <td width="60%"> Causes
///              a temporary file to be created if the file cannot be cached. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_RELOAD"></a><a id="internet_flag_reload"></a><dl> <dt><b>INTERNET_FLAG_RELOAD</b></dt> </dl>
///              </td> <td width="60%"> Forces a download of the requested file, object, or directory listing from the origin
///              server, not from the cache. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESYNCHRONIZE"></a><a
///              id="internet_flag_resynchronize"></a><dl> <dt><b>INTERNET_FLAG_RESYNCHRONIZE</b></dt> </dl> </td> <td
///              width="60%"> Reloads HTTP resources if the resource has been modified since the last time it was downloaded. All
///              FTP resources are reloaded. <b>Windows XP and Windows Server 2003 R2 and earlier: </b>Gopher resources are also
///              reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data. This is only used if the application has already called InternetSetStatusCallback to set up a
///                status callback function.
///Returns:
///    Returns a handle if successful, or <b>NULL</b> otherwise. To retrieve a specific error message, call
///    GetLastError.
///    
@DllImport("WININET")
void* FtpOpenFileW(void* hConnect, const(PWSTR) lpszFileName, uint dwAccess, uint dwFlags, size_t dwContext);

///Creates a new directory on the FTP server.
///Params:
///    hConnect = Handle returned by a previous call to InternetConnect using <b>INTERNET_SERVICE_FTP</b>.
///    lpszDirectory = Pointer to a null-terminated string that contains the name of the directory to be created. This can be either a
///                    fully qualified path or a name relative to the current directory.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    If the error message indicates that the FTP server denied the request to create a directory, use
///    InternetGetLastResponseInfo to determine why.
///    
@DllImport("WININET")
BOOL FtpCreateDirectoryA(void* hConnect, const(PSTR) lpszDirectory);

///Creates a new directory on the FTP server.
///Params:
///    hConnect = Handle returned by a previous call to InternetConnect using <b>INTERNET_SERVICE_FTP</b>.
///    lpszDirectory = Pointer to a null-terminated string that contains the name of the directory to be created. This can be either a
///                    fully qualified path or a name relative to the current directory.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    If the error message indicates that the FTP server denied the request to create a directory, use
///    InternetGetLastResponseInfo to determine why.
///    
@DllImport("WININET")
BOOL FtpCreateDirectoryW(void* hConnect, const(PWSTR) lpszDirectory);

///Removes the specified directory on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszDirectory = Pointer to a null-terminated string that contains the name of the directory to be removed. This can be either a
///                    fully qualified path or a name relative to the current directory.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    If the error message indicates that the FTP server denied the request to remove a directory, use
///    InternetGetLastResponseInfo to determine why.
///    
@DllImport("WININET")
BOOL FtpRemoveDirectoryA(void* hConnect, const(PSTR) lpszDirectory);

///Removes the specified directory on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszDirectory = Pointer to a null-terminated string that contains the name of the directory to be removed. This can be either a
///                    fully qualified path or a name relative to the current directory.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    If the error message indicates that the FTP server denied the request to remove a directory, use
///    InternetGetLastResponseInfo to determine why.
///    
@DllImport("WININET")
BOOL FtpRemoveDirectoryW(void* hConnect, const(PWSTR) lpszDirectory);

///Changes to a different working directory on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszDirectory = Pointer to a null-terminated string that contains the name of the directory to become the current working
///                    directory. This can be either a fully qualified path or a name relative to the current directory.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    If the error message indicates that the FTP server denied the request to change a directory, use
///    InternetGetLastResponseInfo to determine why.
///    
@DllImport("WININET")
BOOL FtpSetCurrentDirectoryA(void* hConnect, const(PSTR) lpszDirectory);

///Changes to a different working directory on the FTP server.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszDirectory = Pointer to a null-terminated string that contains the name of the directory to become the current working
///                    directory. This can be either a fully qualified path or a name relative to the current directory.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    If the error message indicates that the FTP server denied the request to change a directory, use
///    InternetGetLastResponseInfo to determine why.
///    
@DllImport("WININET")
BOOL FtpSetCurrentDirectoryW(void* hConnect, const(PWSTR) lpszDirectory);

///Retrieves the current directory for the specified FTP session.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszCurrentDirectory = Pointer to a null-terminated string that receives the absolute path of the current directory.
///    lpdwCurrentDirectory = Pointer to a variable that specifies the length of the buffer, in <b>TCHARs</b>. The buffer length must include
///                           room for a terminating null character. Using a length of <b>MAX_PATH</b> is sufficient for all paths. When the
///                           function returns, the variable receives the number of characters copied into the buffer.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpGetCurrentDirectoryA(void* hConnect, PSTR lpszCurrentDirectory, uint* lpdwCurrentDirectory);

///Retrieves the current directory for the specified FTP session.
///Params:
///    hConnect = Handle to an FTP session.
///    lpszCurrentDirectory = Pointer to a null-terminated string that receives the absolute path of the current directory.
///    lpdwCurrentDirectory = Pointer to a variable that specifies the length of the buffer, in <b>TCHARs</b>. The buffer length must include
///                           room for a terminating null character. Using a length of <b>MAX_PATH</b> is sufficient for all paths. When the
///                           function returns, the variable receives the number of characters copied into the buffer.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpGetCurrentDirectoryW(void* hConnect, PWSTR lpszCurrentDirectory, uint* lpdwCurrentDirectory);

///The <b>FtpCommand</b> function sends commands directly to an FTP server.
///Params:
///    hConnect = A handle returned from a call to InternetConnect.
///    fExpectResponse = A Boolean value that indicates whether the application expects a data connection to be established by the FTP
///                      server. This must be set to <b>TRUE</b> if a data connection is expected, or <b>FALSE</b> otherwise.
///    dwFlags = A parameter that can be set to one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_ASCII"></a><a id="ftp_transfer_type_ascii"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt> </dl> </td> <td width="60%"> Transfers the file using the FTP ASCII (Type
///              A) transfer method. Control and formatting data is converted to local equivalents. </td> </tr> <tr> <td
///              width="40%"><a id="FTP_TRANSFER_TYPE_BINARY"></a><a id="ftp_transfer_type_binary"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file using the FTP Image
///              (Type I) transfer method. The file is transferred exactly with no changes. This is the default transfer method.
///              </td> </tr> </table>
///    lpszCommand = A pointer to a string that contains the command to send to the FTP server.
///    dwContext = A pointer to a variable that contains an application-defined value used to identify the application context in
///                callback operations.
///    phFtpCommand = A pointer to a handle that is created if a valid data socket is opened. The <i>fExpectResponse</i> parameter must
///                   be set to <b>TRUE</b> for <i>phFtpCommand</i> to be filled.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpCommandA(void* hConnect, BOOL fExpectResponse, uint dwFlags, const(PSTR) lpszCommand, size_t dwContext, 
                 void** phFtpCommand);

///The <b>FtpCommand</b> function sends commands directly to an FTP server.
///Params:
///    hConnect = A handle returned from a call to InternetConnect.
///    fExpectResponse = A Boolean value that indicates whether the application expects a data connection to be established by the FTP
///                      server. This must be set to <b>TRUE</b> if a data connection is expected, or <b>FALSE</b> otherwise.
///    dwFlags = A parameter that can be set to one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="FTP_TRANSFER_TYPE_ASCII"></a><a id="ftp_transfer_type_ascii"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_ASCII</b></dt> </dl> </td> <td width="60%"> Transfers the file using the FTP ASCII (Type
///              A) transfer method. Control and formatting data is converted to local equivalents. </td> </tr> <tr> <td
///              width="40%"><a id="FTP_TRANSFER_TYPE_BINARY"></a><a id="ftp_transfer_type_binary"></a><dl>
///              <dt><b>FTP_TRANSFER_TYPE_BINARY</b></dt> </dl> </td> <td width="60%"> Transfers the file using the FTP Image
///              (Type I) transfer method. The file is transferred exactly with no changes. This is the default transfer method.
///              </td> </tr> </table>
///    lpszCommand = A pointer to a string that contains the command to send to the FTP server.
///    dwContext = A pointer to a variable that contains an application-defined value used to identify the application context in
///                callback operations.
///    phFtpCommand = A pointer to a handle that is created if a valid data socket is opened. The <i>fExpectResponse</i> parameter must
///                   be set to <b>TRUE</b> for <i>phFtpCommand</i> to be filled.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL FtpCommandW(void* hConnect, BOOL fExpectResponse, uint dwFlags, const(PWSTR) lpszCommand, size_t dwContext, 
                 void** phFtpCommand);

///Retrieves the file size of the requested FTP resource.
///Params:
///    hFile = Handle returned from a call to FtpOpenFile.
///    lpdwFileSizeHigh = Pointer to the high-order unsigned long integer of the file size of the requested FTP resource.
///Returns:
///    Returns the low-order unsigned long integer of the file size of the requested FTP resource.
///    
@DllImport("WININET")
uint FtpGetFileSize(void* hFile, uint* lpdwFileSizeHigh);

///<p class="CCE_Message">[The <b>GopherCreateLocator</b> function is available for use in the operating systems
///specified in the Requirements section.] Creates a Gopher or Gopher+ locator string from the selector string's
///component parts.
///Params:
///    lpszHost = Pointer to a <b>null</b>-terminated string that contains the name of the host, or a dotted-decimal IP address
///               (such as 198.105.232.1).
///    nServerPort = Port number on which the Gopher server at <i>lpszHost</i> lives, in host byte order. If <i>nServerPort</i> is
///                  <b>INTERNET_INVALID_PORT_NUMBER</b>, the default Gopher port is used.
///    lpszDisplayString = Pointer to a <b>null</b>-terminated string that contains the Gopher document or directory to be displayed. If
///                        this parameter is <b>NULL</b>, the function returns the default directory for the Gopher server.
///    lpszSelectorString = Pointer to the selector string to send to the Gopher server in order to retrieve information. This parameter can
///                         be <b>NULL</b>.
///    dwGopherType = Determines whether <i>lpszSelectorString</i> refers to a directory or document, and whether the request is
///                   Gopher+ or Gopher. The default value, GOPHER_TYPE_DIRECTORY, is used if the value of <i>dwGopherType</i> is zero.
///                   This can be one of the gopher type values.
///    lpszLocator = Pointer to a buffer that receives the locator string. If <i>lpszLocator</i> is <b>NULL</b>,
///                  <i>lpdwBufferLength</i> receives the necessary buffer length, but the function performs no other processing.
///    lpdwBufferLength = Pointer to a variable that contains the length of the <i>lpszLocator</i> buffer, in characters. When the function
///                       returns, this parameter receives the number of characters written to the buffer. If GetLastError returns
///                       <b>ERROR_INSUFFICIENT_BUFFER</b>, this parameter receives the number of characters required.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
BOOL GopherCreateLocatorA(const(PSTR) lpszHost, ushort nServerPort, const(PSTR) lpszDisplayString, 
                          const(PSTR) lpszSelectorString, uint dwGopherType, PSTR lpszLocator, 
                          uint* lpdwBufferLength);

///<p class="CCE_Message">[The <b>GopherCreateLocator</b> function is available for use in the operating systems
///specified in the Requirements section.] Creates a Gopher or Gopher+ locator string from the selector string's
///component parts.
///Params:
///    lpszHost = Pointer to a <b>null</b>-terminated string that contains the name of the host, or a dotted-decimal IP address
///               (such as 198.105.232.1).
///    nServerPort = Port number on which the Gopher server at <i>lpszHost</i> lives, in host byte order. If <i>nServerPort</i> is
///                  <b>INTERNET_INVALID_PORT_NUMBER</b>, the default Gopher port is used.
///    lpszDisplayString = Pointer to a <b>null</b>-terminated string that contains the Gopher document or directory to be displayed. If
///                        this parameter is <b>NULL</b>, the function returns the default directory for the Gopher server.
///    lpszSelectorString = Pointer to the selector string to send to the Gopher server in order to retrieve information. This parameter can
///                         be <b>NULL</b>.
///    dwGopherType = Determines whether <i>lpszSelectorString</i> refers to a directory or document, and whether the request is
///                   Gopher+ or Gopher. The default value, GOPHER_TYPE_DIRECTORY, is used if the value of <i>dwGopherType</i> is zero.
///                   This can be one of the gopher type values.
///    lpszLocator = Pointer to a buffer that receives the locator string. If <i>lpszLocator</i> is <b>NULL</b>,
///                  <i>lpdwBufferLength</i> receives the necessary buffer length, but the function performs no other processing.
///    lpdwBufferLength = Pointer to a variable that contains the length of the <i>lpszLocator</i> buffer, in characters. When the function
///                       returns, this parameter receives the number of characters written to the buffer. If GetLastError returns
///                       <b>ERROR_INSUFFICIENT_BUFFER</b>, this parameter receives the number of characters required.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
BOOL GopherCreateLocatorW(const(PWSTR) lpszHost, ushort nServerPort, const(PWSTR) lpszDisplayString, 
                          const(PWSTR) lpszSelectorString, uint dwGopherType, PWSTR lpszLocator, 
                          uint* lpdwBufferLength);

///<p class="CCE_Message">[The <b>GopherGetLocatorType</b> function is available for use in the operating systems
///specified in the Requirements section.] Parses a Gopher locator and determines its attributes.
///Params:
///    lpszLocator = Pointer to a null-terminated string that specifies the Gopher locator to be parsed.
///    lpdwGopherType = Pointer to a variable that receives the type of the locator. The type is a bitmask that consists of a combination
///                     of the gopher type values.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL GopherGetLocatorTypeA(const(PSTR) lpszLocator, uint* lpdwGopherType);

///<p class="CCE_Message">[The <b>GopherGetLocatorType</b> function is available for use in the operating systems
///specified in the Requirements section.] Parses a Gopher locator and determines its attributes.
///Params:
///    lpszLocator = Pointer to a null-terminated string that specifies the Gopher locator to be parsed.
///    lpdwGopherType = Pointer to a variable that receives the type of the locator. The type is a bitmask that consists of a combination
///                     of the gopher type values.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL GopherGetLocatorTypeW(const(PWSTR) lpszLocator, uint* lpdwGopherType);

///<p class="CCE_Message">[The <b>GopherFindFirstFile</b> function is available for use in the operating systems
///specified in the Requirements section.] Uses a Gopher locator and search criteria to create a session with the server
///and locate the requested documents, binary files, index servers, or directory trees.
///Params:
///    hConnect = Handle to a Gopher session returned by InternetConnect.
///    lpszLocator = Pointer to a <b>null</b>-terminated string that contains the name of the item to locate. This can be one of the
///                  following: <ul> <li>Gopher locator returned by a previous call to this function or the InternetFindNextFile
///                  function.</li> <li><b>NULL</b> pointer or empty string indicating that the topmost information from a Gopher
///                  server is being returned.</li> <li>Locator created by the GopherCreateLocator function.</li> </ul>
///    lpszSearchString = Pointer to a buffer that contains the strings to search, if this request is to an index server. Otherwise, this
///                       parameter should be <b>NULL</b>.
///    lpFindData = Pointer to a GOPHER_FIND_DATA structure that receives the information retrieved by this function.
///    dwFlags = Controls the function behavior. This parameter can be a combination of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_HYPERLINK</dt> </dl> </td> <td
///              width="60%"> Forces a reload if there was no Expires time and no LastModified time returned from the server when
///              determining whether to reload the item from the network. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a download of the requested file, object, or
///              directory listing from the origin server, not from the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource has been
///              modified since the last time it was downloaded. All FTP and Gopher resources are reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data.
///Returns:
///    Returns a valid search handle if successful, or <b>NULL</b> otherwise. To retrieve extended error information,
///    call GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
void* GopherFindFirstFileA(void* hConnect, const(PSTR) lpszLocator, const(PSTR) lpszSearchString, 
                           GOPHER_FIND_DATAA* lpFindData, uint dwFlags, size_t dwContext);

///<p class="CCE_Message">[The <b>GopherFindFirstFile</b> function is available for use in the operating systems
///specified in the Requirements section.] Uses a Gopher locator and search criteria to create a session with the server
///and locate the requested documents, binary files, index servers, or directory trees.
///Params:
///    hConnect = Handle to a Gopher session returned by InternetConnect.
///    lpszLocator = Pointer to a <b>null</b>-terminated string that contains the name of the item to locate. This can be one of the
///                  following: <ul> <li>Gopher locator returned by a previous call to this function or the InternetFindNextFile
///                  function.</li> <li><b>NULL</b> pointer or empty string indicating that the topmost information from a Gopher
///                  server is being returned.</li> <li>Locator created by the GopherCreateLocator function.</li> </ul>
///    lpszSearchString = Pointer to a buffer that contains the strings to search, if this request is to an index server. Otherwise, this
///                       parameter should be <b>NULL</b>.
///    lpFindData = Pointer to a GOPHER_FIND_DATA structure that receives the information retrieved by this function.
///    dwFlags = Controls the function behavior. This parameter can be a combination of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_HYPERLINK</dt> </dl> </td> <td
///              width="60%"> Forces a reload if there was no Expires time and no LastModified time returned from the server when
///              determining whether to reload the item from the network. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a download of the requested file, object, or
///              directory listing from the origin server, not from the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource has been
///              modified since the last time it was downloaded. All FTP and Gopher resources are reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains the application-defined value that associates this search with any
///                application data.
///Returns:
///    Returns a valid search handle if successful, or <b>NULL</b> otherwise. To retrieve extended error information,
///    call GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
void* GopherFindFirstFileW(void* hConnect, const(PWSTR) lpszLocator, const(PWSTR) lpszSearchString, 
                           GOPHER_FIND_DATAW* lpFindData, uint dwFlags, size_t dwContext);

///<p class="CCE_Message">[The <b>GopherOpenFile</b> function is available for use in the operating systems specified in
///the Requirements section.] Begins reading a Gopher data file from a Gopher server.
///Params:
///    hConnect = Handle to a Gopher session returned by InternetConnect.
///    lpszLocator = Pointer to a <b>null</b>-terminated string that specifies the file to be opened. Generally, this locator is
///                  returned from a call to GopherFindFirstFile or InternetFindNextFile. Because the Gopher protocol has no concept
///                  of a current directory, the locator is always fully qualified.
///    lpszView = Pointer to a <b>null</b>-terminated string that describes the view to open if several views of the file exist on
///               the server. If <i>lpszView</i> is <b>NULL</b>, the function uses the default file view.
///    dwFlags = Conditions under which subsequent transfers occur. This parameter can be any of the following values. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_HYPERLINK</dt> </dl>
///              </td> <td width="60%"> Forces a reload if there was no Expires time and no LastModified time returned from the
///              server when determining whether to reload the item from the network. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a download of the requested file, object, or
///              directory listing from the origin server, not from the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource has been
///              modified since the last time it was downloaded. All FTP and Gopher resources are reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains an application-defined value that associates this operation with any
///                application data.
///Returns:
///    Returns a handle if successful, or <b>NULL</b> if the file cannot be opened. To retrieve extended error
///    information, call GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
void* GopherOpenFileA(void* hConnect, const(PSTR) lpszLocator, const(PSTR) lpszView, uint dwFlags, 
                      size_t dwContext);

///<p class="CCE_Message">[The <b>GopherOpenFile</b> function is available for use in the operating systems specified in
///the Requirements section.] Begins reading a Gopher data file from a Gopher server.
///Params:
///    hConnect = Handle to a Gopher session returned by InternetConnect.
///    lpszLocator = Pointer to a <b>null</b>-terminated string that specifies the file to be opened. Generally, this locator is
///                  returned from a call to GopherFindFirstFile or InternetFindNextFile. Because the Gopher protocol has no concept
///                  of a current directory, the locator is always fully qualified.
///    lpszView = Pointer to a <b>null</b>-terminated string that describes the view to open if several views of the file exist on
///               the server. If <i>lpszView</i> is <b>NULL</b>, the function uses the default file view.
///    dwFlags = Conditions under which subsequent transfers occur. This parameter can be any of the following values. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_HYPERLINK</dt> </dl>
///              </td> <td width="60%"> Forces a reload if there was no Expires time and no LastModified time returned from the
///              server when determining whether to reload the item from the network. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a download of the requested file, object, or
///              directory listing from the origin server, not from the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource has been
///              modified since the last time it was downloaded. All FTP and Gopher resources are reloaded. </td> </tr> </table>
///    dwContext = Pointer to a variable that contains an application-defined value that associates this operation with any
///                application data.
///Returns:
///    Returns a handle if successful, or <b>NULL</b> if the file cannot be opened. To retrieve extended error
///    information, call GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
void* GopherOpenFileW(void* hConnect, const(PWSTR) lpszLocator, const(PWSTR) lpszView, uint dwFlags, 
                      size_t dwContext);

///<p class="CCE_Message">[The <b>GopherGetAttribute</b> function is available for use in the operating systems
///specified in the Requirements section.] Retrieves the specific attribute information from the server.
///Params:
///    hConnect = Handle to a Gopher session returned by InternetConnect.
///    lpszLocator = Pointer to a <b>null</b>-terminated string that identifies the item at the Gopher server on which to return
///                  attribute information.
///    lpszAttributeName = Pointer to a space-delimited string specifying the names of attributes to return. If <i>lpszAttributeName</i> is
///                        <b>NULL</b>, <b>GopherGetAttribute</b> returns information about all attributes.
///    lpBuffer = Pointer to an application-defined buffer from which attribute information is retrieved.
///    dwBufferLength = Size of the <i>lpBuffer</i> buffer, in <b>TCHARs</b>.
///    lpdwCharactersReturned = Pointer to a variable that contains the number of characters read into the <i>lpBuffer</i> buffer.
///    lpfnEnumerator = Pointer to a GopherAttributeEnumerator callback function that enumerates each attribute of the locator. This
///                     parameter is optional. If it is <b>NULL</b>, all Gopher attribute information is placed into <i>lpBuffer</i>. If
///                     <i>lpfnEnumerator</i> is specified, the callback function is called once for each attribute of the object. The
///                     callback function receives the address of a single GOPHER_ATTRIBUTE_TYPE structure with each call. The
///                     enumeration callback function allows the application to avoid having to parse the Gopher attribute information.
///    dwContext = Application-defined value that associates this operation with any application data.
///Returns:
///    Returns <b>TRUE</b> if the request is satisfied, or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
BOOL GopherGetAttributeA(void* hConnect, const(PSTR) lpszLocator, const(PSTR) lpszAttributeName, ubyte* lpBuffer, 
                         uint dwBufferLength, uint* lpdwCharactersReturned, 
                         GOPHER_ATTRIBUTE_ENUMERATOR lpfnEnumerator, size_t dwContext);

///<p class="CCE_Message">[The <b>GopherGetAttribute</b> function is available for use in the operating systems
///specified in the Requirements section.] Retrieves the specific attribute information from the server.
///Params:
///    hConnect = Handle to a Gopher session returned by InternetConnect.
///    lpszLocator = Pointer to a <b>null</b>-terminated string that identifies the item at the Gopher server on which to return
///                  attribute information.
///    lpszAttributeName = Pointer to a space-delimited string specifying the names of attributes to return. If <i>lpszAttributeName</i> is
///                        <b>NULL</b>, <b>GopherGetAttribute</b> returns information about all attributes.
///    lpBuffer = Pointer to an application-defined buffer from which attribute information is retrieved.
///    dwBufferLength = Size of the <i>lpBuffer</i> buffer, in <b>TCHARs</b>.
///    lpdwCharactersReturned = Pointer to a variable that contains the number of characters read into the <i>lpBuffer</i> buffer.
///    lpfnEnumerator = Pointer to a GopherAttributeEnumerator callback function that enumerates each attribute of the locator. This
///                     parameter is optional. If it is <b>NULL</b>, all Gopher attribute information is placed into <i>lpBuffer</i>. If
///                     <i>lpfnEnumerator</i> is specified, the callback function is called once for each attribute of the object. The
///                     callback function receives the address of a single GOPHER_ATTRIBUTE_TYPE structure with each call. The
///                     enumeration callback function allows the application to avoid having to parse the Gopher attribute information.
///    dwContext = Application-defined value that associates this operation with any application data.
///Returns:
///    Returns <b>TRUE</b> if the request is satisfied, or <b>FALSE</b> otherwise. To get extended error information,
///    call GetLastError or InternetGetLastResponseInfo.
///    
@DllImport("WININET")
BOOL GopherGetAttributeW(void* hConnect, const(PWSTR) lpszLocator, const(PWSTR) lpszAttributeName, ubyte* lpBuffer, 
                         uint dwBufferLength, uint* lpdwCharactersReturned, 
                         GOPHER_ATTRIBUTE_ENUMERATOR lpfnEnumerator, size_t dwContext);

///Creates an HTTP request handle.
///Params:
///    hConnect = A handle to an HTTP session returned by InternetConnect.
///    lpszVerb = A pointer to a <b>null</b>-terminated string that contains the HTTP verb to use in the request. If this parameter
///               is <b>NULL</b>, the function uses GET as the HTTP verb.
///    lpszObjectName = A pointer to a <b>null</b>-terminated string that contains the name of the target object of the specified HTTP
///                     verb. This is generally a file name, an executable module, or a search specifier.
///    lpszVersion = A pointer to a <b>null</b>-terminated string that contains the HTTP version to use in the request. Settings in
///                  Internet Explorer will override the value specified in this parameter. If this parameter is <b>NULL</b>, the
///                  function uses an HTTP version of 1.1 or 1.0, depending on the value of the Internet Explorer settings. <table>
///                  <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="HTTP_1.0"></a><a id="http_1.0"></a><dl>
///                  <dt><b>HTTP/1.0</b></dt> </dl> </td> <td width="60%"> HTTP version 1.0 </td> </tr> <tr> <td width="40%"><a
///                  id="HTTP_1.1"></a><a id="http_1.1"></a><dl> <dt><b>HTTP/1.1</b></dt> </dl> </td> <td width="60%"> HTTP version
///                  1.1 </td> </tr> </table>
///    lpszReferrer = A pointer to a <b>null</b>-terminated string that specifies the URL of the document from which the URL in the
///                   request (<i>lpszObjectName</i>) was obtained. If this parameter is <b>NULL</b>, no referrer is specified.
///    lplpszAcceptTypes = A pointer to a <b>null</b>-terminated array of strings that indicates media types accepted by the client. Here is
///                        an example. <code>PCTSTR rgpszAcceptTypes[] = {_T("text/*"), NULL};</code> Failing to properly terminate the
///                        array with a NULL pointer will cause a crash. If this parameter is <b>NULL</b>, no types are accepted by the
///                        client. Servers generally interpret a lack of accept types to indicate that the client accepts only documents of
///                        type "text/*" (that is, only text documents—no pictures or other binary files).<!-- For more information and a
///                        list of valid media types, see ftp://ftp.isi.edu/in-notes/iana/assignments/media-types/media-types. -->
///    dwFlags = Internet options. This parameter can be any of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_CACHE_IF_NET_FAIL</dt> </dl> </td> <td width="60%"> Returns
///              the resource from the cache if the network request for the resource fails due to an
///              ERROR_INTERNET_CONNECTION_RESET (the connection with the server has been reset) or ERROR_INTERNET_CANNOT_CONNECT
///              (the attempt to connect to the server failed). </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_HYPERLINK</dt> </dl> </td> <td width="60%"> Forces a reload if there was no Expires time and no
///              LastModified time returned from the server when determining whether to reload the item from the network. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_CERT_CN_INVALID</dt> </dl> </td> <td width="60%">
///              Disables checking of SSL/PCT-based certificates that are returned from the server against the host name given in
///              the request. WinINet functions use a simple check against certificates by comparing for matching host names and
///              simple wildcarding rules. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_CERT_DATE_INVALID</dt>
///              </dl> </td> <td width="60%"> Disables checking of SSL/PCT-based certificates for proper validity dates. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP</dt> </dl> </td> <td width="60%">
///              Disables detection of this special type of redirect. When this flag is used, WinINet functions transparently
///              allow redirects from HTTPS to HTTP URLs. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS</dt> </dl> </td> <td width="60%"> Disables detection of this special
///              type of redirect. When this flag is used, WinINet functions transparently allow redirects from HTTP to HTTPS
///              URLs. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_KEEP_CONNECTION</dt> </dl> </td> <td width="60%">
///              Uses keep-alive semantics, if available, for the connection. This flag is required for Microsoft Network (MSN),
///              NT LAN Manager (NTLM), and other types of authentication. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_AUTH</dt> </dl> </td> <td
///              width="60%"> Does not attempt authentication automatically. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_AUTO_REDIRECT</dt> </dl> </td> <td width="60%"> Does not automatically handle redirection in
///              HttpSendRequest. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_COOKIES</dt> </dl> </td> <td width="60%"> Does not automatically add cookie headers to
///              requests, and does not automatically add returned cookies to the cookie database. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_NO_UI</dt> </dl> </td> <td width="60%"> Disables the cookie dialog box. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_PRAGMA_NOCACHE</dt> </dl> </td> <td width="60%"> Forces the
///              request to be resolved by the origin server, even if a cached copy exists on the proxy. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a download of the requested
///              file, object, or directory listing from the origin server, not from the cache. </td> </tr> <tr> <td width="40%">
///              <dl> <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource has
///              been modified since the last time it was downloaded. All FTP resources are reloaded. <b>Windows XP and Windows
///              Server 2003 R2 and earlier: </b>Gopher resources are also reloaded. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_SECURE</dt> </dl> </td> <td width="60%"> Uses secure transaction semantics. This translates to
///              using Secure Sockets Layer/Private Communications Technology (SSL/PCT) and is only meaningful in HTTP requests.
///              </td> </tr> </table>
///    dwContext = A pointer to a variable that contains the application-defined value that associates this operation with any
///                application data.
///Returns:
///    Returns an HTTP request handle if successful, or <b>NULL</b> otherwise. To retrieve extended error information,
///    call GetLastError.
///    
@DllImport("WININET")
void* HttpOpenRequestA(void* hConnect, const(PSTR) lpszVerb, const(PSTR) lpszObjectName, const(PSTR) lpszVersion, 
                       const(PSTR) lpszReferrer, PSTR* lplpszAcceptTypes, uint dwFlags, size_t dwContext);

///Creates an HTTP request handle.
///Params:
///    hConnect = A handle to an HTTP session returned by InternetConnect.
///    lpszVerb = A pointer to a <b>null</b>-terminated string that contains the HTTP verb to use in the request. If this parameter
///               is <b>NULL</b>, the function uses GET as the HTTP verb.
///    lpszObjectName = A pointer to a <b>null</b>-terminated string that contains the name of the target object of the specified HTTP
///                     verb. This is generally a file name, an executable module, or a search specifier.
///    lpszVersion = A pointer to a <b>null</b>-terminated string that contains the HTTP version to use in the request. Settings in
///                  Internet Explorer will override the value specified in this parameter. If this parameter is <b>NULL</b>, the
///                  function uses an HTTP version of 1.1 or 1.0, depending on the value of the Internet Explorer settings. <table>
///                  <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="HTTP_1.0"></a><a id="http_1.0"></a><dl>
///                  <dt><b>HTTP/1.0</b></dt> </dl> </td> <td width="60%"> HTTP version 1.0 </td> </tr> <tr> <td width="40%"><a
///                  id="HTTP_1.1"></a><a id="http_1.1"></a><dl> <dt><b>HTTP/1.1</b></dt> </dl> </td> <td width="60%"> HTTP version
///                  1.1 </td> </tr> </table>
///    lpszReferrer = A pointer to a <b>null</b>-terminated string that specifies the URL of the document from which the URL in the
///                   request (<i>lpszObjectName</i>) was obtained. If this parameter is <b>NULL</b>, no referrer is specified.
///    lplpszAcceptTypes = A pointer to a <b>null</b>-terminated array of strings that indicates media types accepted by the client. Here is
///                        an example. <code>PCTSTR rgpszAcceptTypes[] = {_T("text/*"), NULL};</code> Failing to properly terminate the
///                        array with a NULL pointer will cause a crash. If this parameter is <b>NULL</b>, no types are accepted by the
///                        client. Servers generally interpret a lack of accept types to indicate that the client accepts only documents of
///                        type "text/*" (that is, only text documents—no pictures or other binary files). <!--For more information and a
///                        list of valid media types, see ftp://ftp.isi.edu/in-notes/iana/assignments/media-types/media-types. -->
///    dwFlags = Internet options. This parameter can be any of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_CACHE_IF_NET_FAIL</dt> </dl> </td> <td width="60%"> Returns
///              the resource from the cache if the network request for the resource fails due to an
///              ERROR_INTERNET_CONNECTION_RESET (the connection with the server has been reset) or ERROR_INTERNET_CANNOT_CONNECT
///              (the attempt to connect to the server failed). </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_HYPERLINK</dt> </dl> </td> <td width="60%"> Forces a reload if there was no Expires time and no
///              LastModified time returned from the server when determining whether to reload the item from the network. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_CERT_CN_INVALID</dt> </dl> </td> <td width="60%">
///              Disables checking of SSL/PCT-based certificates that are returned from the server against the host name given in
///              the request. WinINet functions use a simple check against certificates by comparing for matching host names and
///              simple wildcarding rules. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_CERT_DATE_INVALID</dt>
///              </dl> </td> <td width="60%"> Disables checking of SSL/PCT-based certificates for proper validity dates. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP</dt> </dl> </td> <td width="60%">
///              Disables detection of this special type of redirect. When this flag is used, WinINet functions transparently
///              allow redirects from HTTPS to HTTP URLs. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS</dt> </dl> </td> <td width="60%"> Disables detection of this special
///              type of redirect. When this flag is used, WinINet functions transparently allow redirects from HTTP to HTTPS
///              URLs. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_KEEP_CONNECTION</dt> </dl> </td> <td width="60%">
///              Uses keep-alive semantics, if available, for the connection. This flag is required for Microsoft Network (MSN),
///              NT LAN Manager (NTLM), and other types of authentication. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NEED_FILE</dt> </dl> </td> <td width="60%"> Causes a temporary file to be created if the file
///              cannot be cached. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_AUTH</dt> </dl> </td> <td
///              width="60%"> Does not attempt authentication automatically. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_AUTO_REDIRECT</dt> </dl> </td> <td width="60%"> Does not automatically handle redirection in
///              HttpSendRequest. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_NO_CACHE_WRITE</dt> </dl> </td> <td
///              width="60%"> Does not add the returned entity to the cache. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_NO_COOKIES</dt> </dl> </td> <td width="60%"> Does not automatically add cookie headers to
///              requests, and does not automatically add returned cookies to the cookie database. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_NO_UI</dt> </dl> </td> <td width="60%"> Disables the cookie dialog box. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_FLAG_PRAGMA_NOCACHE</dt> </dl> </td> <td width="60%"> Forces the
///              request to be resolved by the origin server, even if a cached copy exists on the proxy. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_FLAG_RELOAD</dt> </dl> </td> <td width="60%"> Forces a download of the requested
///              file, object, or directory listing from the origin server, not from the cache. </td> </tr> <tr> <td width="40%">
///              <dl> <dt>INTERNET_FLAG_RESYNCHRONIZE</dt> </dl> </td> <td width="60%"> Reloads HTTP resources if the resource has
///              been modified since the last time it was downloaded. All FTP resources are reloaded. <b>Windows XP and Windows
///              Server 2003 R2 and earlier: </b>Gopher resources are also reloaded. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_FLAG_SECURE</dt> </dl> </td> <td width="60%"> Uses secure transaction semantics. This translates to
///              using Secure Sockets Layer/Private Communications Technology (SSL/PCT) and is only meaningful in HTTP requests.
///              </td> </tr> </table>
///    dwContext = A pointer to a variable that contains the application-defined value that associates this operation with any
///                application data.
///Returns:
///    Returns an HTTP request handle if successful, or <b>NULL</b> otherwise. To retrieve extended error information,
///    call GetLastError.
///    
@DllImport("WININET")
void* HttpOpenRequestW(void* hConnect, const(PWSTR) lpszVerb, const(PWSTR) lpszObjectName, 
                       const(PWSTR) lpszVersion, const(PWSTR) lpszReferrer, PWSTR* lplpszAcceptTypes, uint dwFlags, 
                       size_t dwContext);

///Adds one or more HTTP request headers to the HTTP request handle.
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest function.
///    lpszHeaders = A pointer to a string variable containing the headers to append to the request. Each header must be terminated by
///                  a CR/LF (carriage return/line feed) pair.
///    dwHeadersLength = The size of <i>lpszHeaders</i>, in <b>TCHARs</b>. If this parameter is -1L, the function assumes that
///                      <i>lpszHeaders</i> is zero-terminated (ASCIIZ), and the length is computed.
///    dwModifiers = A set of modifiers that control the semantics of this function. This parameter can be a combination of the
///                  following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="HTTP_ADDREQ_FLAG_ADD"></a><a id="http_addreq_flag_add"></a><dl> <dt><b>HTTP_ADDREQ_FLAG_ADD</b></dt> </dl>
///                  </td> <td width="60%"> Adds the header if it does not exist. Used with <b>HTTP_ADDREQ_FLAG_REPLACE</b>. </td>
///                  </tr> <tr> <td width="40%"><a id="HTTP_ADDREQ_FLAG_ADD_IF_NEW"></a><a id="http_addreq_flag_add_if_new"></a><dl>
///                  <dt><b>HTTP_ADDREQ_FLAG_ADD_IF_NEW</b></dt> </dl> </td> <td width="60%"> Adds the header only if it does not
///                  already exist; otherwise, an error is returned. </td> </tr> <tr> <td width="40%"><a
///                  id="HTTP_ADDREQ_FLAG_COALESCE"></a><a id="http_addreq_flag_coalesce"></a><dl>
///                  <dt><b>HTTP_ADDREQ_FLAG_COALESCE</b></dt> </dl> </td> <td width="60%"> Coalesces headers of the same name. </td>
///                  </tr> <tr> <td width="40%"><a id="HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA"></a><a
///                  id="http_addreq_flag_coalesce_with_comma"></a><dl> <dt><b>HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA</b></dt> </dl>
///                  </td> <td width="60%"> Coalesces headers of the same name. For example, adding "Accept: text/*" followed by
///                  "Accept: audio/*" with this flag results in the formation of the single header "Accept: text/*, audio/*". This
///                  causes the first header found to be coalesced. It is up to the calling application to ensure a cohesive scheme
///                  with respect to coalesced/separate headers. </td> </tr> <tr> <td width="40%"><a
///                  id="HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON"></a><a id="http_addreq_flag_coalesce_with_semicolon"></a><dl>
///                  <dt><b>HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON</b></dt> </dl> </td> <td width="60%"> Coalesces headers of the
///                  same name using a semicolon. </td> </tr> <tr> <td width="40%"><a id="HTTP_ADDREQ_FLAG_REPLACE"></a><a
///                  id="http_addreq_flag_replace"></a><dl> <dt><b>HTTP_ADDREQ_FLAG_REPLACE</b></dt> </dl> </td> <td width="60%">
///                  Replaces or removes a header. If the header value is empty and the header is found, it is removed. If not empty,
///                  the header value is replaced. </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL HttpAddRequestHeadersA(void* hRequest, const(PSTR) lpszHeaders, uint dwHeadersLength, uint dwModifiers);

///Adds one or more HTTP request headers to the HTTP request handle.
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest function.
///    lpszHeaders = A pointer to a string variable containing the headers to append to the request. Each header must be terminated by
///                  a CR/LF (carriage return/line feed) pair.
///    dwHeadersLength = The size of <i>lpszHeaders</i>, in <b>TCHARs</b>. If this parameter is -1L, the function assumes that
///                      <i>lpszHeaders</i> is zero-terminated (ASCIIZ), and the length is computed.
///    dwModifiers = A set of modifiers that control the semantics of this function. This parameter can be a combination of the
///                  following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="HTTP_ADDREQ_FLAG_ADD"></a><a id="http_addreq_flag_add"></a><dl> <dt><b>HTTP_ADDREQ_FLAG_ADD</b></dt> </dl>
///                  </td> <td width="60%"> Adds the header if it does not exist. Used with <b>HTTP_ADDREQ_FLAG_REPLACE</b>. </td>
///                  </tr> <tr> <td width="40%"><a id="HTTP_ADDREQ_FLAG_ADD_IF_NEW"></a><a id="http_addreq_flag_add_if_new"></a><dl>
///                  <dt><b>HTTP_ADDREQ_FLAG_ADD_IF_NEW</b></dt> </dl> </td> <td width="60%"> Adds the header only if it does not
///                  already exist; otherwise, an error is returned. </td> </tr> <tr> <td width="40%"><a
///                  id="HTTP_ADDREQ_FLAG_COALESCE"></a><a id="http_addreq_flag_coalesce"></a><dl>
///                  <dt><b>HTTP_ADDREQ_FLAG_COALESCE</b></dt> </dl> </td> <td width="60%"> Coalesces headers of the same name. </td>
///                  </tr> <tr> <td width="40%"><a id="HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA"></a><a
///                  id="http_addreq_flag_coalesce_with_comma"></a><dl> <dt><b>HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA</b></dt> </dl>
///                  </td> <td width="60%"> Coalesces headers of the same name. For example, adding "Accept: text/*" followed by
///                  "Accept: audio/*" with this flag results in the formation of the single header "Accept: text/*, audio/*". This
///                  causes the first header found to be coalesced. It is up to the calling application to ensure a cohesive scheme
///                  with respect to coalesced/separate headers. </td> </tr> <tr> <td width="40%"><a
///                  id="HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON"></a><a id="http_addreq_flag_coalesce_with_semicolon"></a><dl>
///                  <dt><b>HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON</b></dt> </dl> </td> <td width="60%"> Coalesces headers of the
///                  same name using a semicolon. </td> </tr> <tr> <td width="40%"><a id="HTTP_ADDREQ_FLAG_REPLACE"></a><a
///                  id="http_addreq_flag_replace"></a><dl> <dt><b>HTTP_ADDREQ_FLAG_REPLACE</b></dt> </dl> </td> <td width="60%">
///                  Replaces or removes a header. If the header value is empty and the header is found, it is removed. If not empty,
///                  the header value is replaced. </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL HttpAddRequestHeadersW(void* hRequest, const(PWSTR) lpszHeaders, uint dwHeadersLength, uint dwModifiers);

///Sends the specified request to the HTTP server, allowing callers to send extra data beyond what is normally passed to
///HttpSendRequestEx.
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest function.
///    lpszHeaders = A pointer to a <b>null</b>-terminated string that contains the additional headers to be appended to the request.
///                  This parameter can be <b>NULL</b> if there are no additional headers to be appended.
///    dwHeadersLength = The size of the additional headers, in <b>TCHARs</b>. If this parameter is -1L and <i>lpszHeaders</i> is not
///                      <b>NULL</b>, the function assumes that <i>lpszHeaders</i> is zero-terminated (ASCIIZ), and the length is
///                      calculated. See Remarks for specifics.
///    lpOptional = A pointer to a buffer containing any optional data to be sent immediately after the request headers. This
///                 parameter is generally used for POST and PUT operations. The optional data can be the resource or information
///                 being posted to the server. This parameter can be <b>NULL</b> if there is no optional data to send.
///    dwOptionalLength = The size of the optional data, in bytes. This parameter can be zero if there is no optional data to send.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL HttpSendRequestA(void* hRequest, const(PSTR) lpszHeaders, uint dwHeadersLength, void* lpOptional, 
                      uint dwOptionalLength);

///Sends the specified request to the HTTP server, allowing callers to send extra data beyond what is normally passed to
///HttpSendRequestEx.
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest function.
///    lpszHeaders = A pointer to a <b>null</b>-terminated string that contains the additional headers to be appended to the request.
///                  This parameter can be <b>NULL</b> if there are no additional headers to be appended.
///    dwHeadersLength = The size of the additional headers, in <b>TCHARs</b>. If this parameter is -1L and <i>lpszHeaders</i> is not
///                      <b>NULL</b>, the function assumes that <i>lpszHeaders</i> is zero-terminated (ASCIIZ), and the length is
///                      calculated. See Remarks for specifics.
///    lpOptional = A pointer to a buffer containing any optional data to be sent immediately after the request headers. This
///                 parameter is generally used for POST and PUT operations. The optional data can be the resource or information
///                 being posted to the server. This parameter can be <b>NULL</b> if there is no optional data to send.
///    dwOptionalLength = The size of the optional data, in bytes. This parameter can be zero if there is no optional data to send.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL HttpSendRequestW(void* hRequest, const(PWSTR) lpszHeaders, uint dwHeadersLength, void* lpOptional, 
                      uint dwOptionalLength);

///Sends the specified request to the HTTP server. <div class="alert"><b>Note</b> Callers that need to send extra data
///beyond what is normally passed to <b>HttpSendRequestEx</b> can do so by calling HttpSendRequest instead.</div><div>
///</div>
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest function.
///    lpBuffersIn = Optional. A pointer to an INTERNET_BUFFERS structure.
///    lpBuffersOut = Reserved. Must be <b>NULL</b>.
///    dwFlags = Reserved. Must be zero.
///    dwContext = Application-defined context value, if a status callback function has been registered.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL HttpSendRequestExA(void* hRequest, INTERNET_BUFFERSA* lpBuffersIn, INTERNET_BUFFERSA* lpBuffersOut, 
                        uint dwFlags, size_t dwContext);

///Sends the specified request to the HTTP server. <div class="alert"><b>Note</b> Callers that need to send extra data
///beyond what is normally passed to <b>HttpSendRequestEx</b> can do so by calling HttpSendRequest instead.</div><div>
///</div>
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest function.
///    lpBuffersIn = Optional. A pointer to an INTERNET_BUFFERS structure.
///    lpBuffersOut = Reserved. Must be <b>NULL</b>.
///    dwFlags = Reserved. Must be zero.
///    dwContext = Application-defined context value, if a status callback function has been registered.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL HttpSendRequestExW(void* hRequest, INTERNET_BUFFERSW* lpBuffersIn, INTERNET_BUFFERSW* lpBuffersOut, 
                        uint dwFlags, size_t dwContext);

///Ends an HTTP request that was initiated by HttpSendRequestEx.
///Params:
///    hRequest = Handle returned by HttpOpenRequest and sent by HttpSendRequestEx.
///    lpBuffersOut = This parameter is reserved and must be <b>NULL</b>.
///    dwFlags = This parameter is reserved and must be set to 0.
///    dwContext = This parameter is reserved and must be set to 0.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL HttpEndRequestA(void* hRequest, INTERNET_BUFFERSA* lpBuffersOut, uint dwFlags, size_t dwContext);

///Ends an HTTP request that was initiated by HttpSendRequestEx.
///Params:
///    hRequest = Handle returned by HttpOpenRequest and sent by HttpSendRequestEx.
///    lpBuffersOut = This parameter is reserved and must be <b>NULL</b>.
///    dwFlags = This parameter is reserved and must be set to 0.
///    dwContext = This parameter is reserved and must be set to 0.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL HttpEndRequestW(void* hRequest, INTERNET_BUFFERSW* lpBuffersOut, uint dwFlags, size_t dwContext);

///Retrieves header information associated with an HTTP request.
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest or InternetOpenUrl function.
///    dwInfoLevel = A combination of an attribute to be retrieved and flags that modify the request. For a list of possible attribute
///                  and modifier values, see Query Info Flags.
///    lpBuffer = A pointer to a buffer to receive the requested information. This parameter must not be <b>NULL</b>.
///    lpdwBufferLength = A pointer to a variable that contains, on entry, the size in bytes of the buffer pointed to by <i>lpvBuffer</i>.
///                       When the function returns successfully, this variable contains the number of bytes of information written to the
///                       buffer. In the case of a string, the byte count does not include the string's terminating <b>null</b> character.
///                       When the function fails with an extended error code of <b>ERROR_INSUFFICIENT_BUFFER</b>, the variable pointed to
///                       by <i>lpdwBufferLength</i> contains on exit the size, in bytes, of a buffer large enough to receive the requested
///                       information. The calling application can then allocate a buffer of this size or larger, and call the function
///                       again.
///    lpdwIndex = A pointer to a zero-based header index used to enumerate multiple headers with the same name. When calling the
///                function, this parameter is the index of the specified header to return. When the function returns, this
///                parameter is the index of the next header. If the next index cannot be found, <b>ERROR_HTTP_HEADER_NOT_FOUND</b>
///                is returned.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL HttpQueryInfoA(void* hRequest, uint dwInfoLevel, void* lpBuffer, uint* lpdwBufferLength, uint* lpdwIndex);

///Retrieves header information associated with an HTTP request.
///Params:
///    hRequest = A handle returned by a call to the HttpOpenRequest or InternetOpenUrl function.
///    dwInfoLevel = A combination of an attribute to be retrieved and flags that modify the request. For a list of possible attribute
///                  and modifier values, see Query Info Flags.
///    lpBuffer = A pointer to a buffer to receive the requested information. This parameter must not be <b>NULL</b>.
///    lpdwBufferLength = A pointer to a variable that contains, on entry, the size in bytes of the buffer pointed to by <i>lpvBuffer</i>.
///                       When the function returns successfully, this variable contains the number of bytes of information written to the
///                       buffer. In the case of a string, the byte count does not include the string's terminating <b>null</b> character.
///                       When the function fails with an extended error code of <b>ERROR_INSUFFICIENT_BUFFER</b>, the variable pointed to
///                       by <i>lpdwBufferLength</i> contains on exit the size, in bytes, of a buffer large enough to receive the requested
///                       information. The calling application can then allocate a buffer of this size or larger, and call the function
///                       again.
///    lpdwIndex = A pointer to a zero-based header index used to enumerate multiple headers with the same name. When calling the
///                function, this parameter is the index of the specified header to return. When the function returns, this
///                parameter is the index of the next header. If the next index cannot be found, <b>ERROR_HTTP_HEADER_NOT_FOUND</b>
///                is returned.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL HttpQueryInfoW(void* hRequest, uint dwInfoLevel, void* lpBuffer, uint* lpdwBufferLength, uint* lpdwIndex);

///Creates a cookie associated with the specified URL.
///Params:
///    lpszUrl = Pointer to a <b>null</b>-terminated string that specifies the URL for which the cookie should be set.
///    lpszCookieName = Pointer to a <b>null</b>-terminated string that specifies the name to be associated with the cookie data. If this
///                     parameter is <b>NULL</b>, no name is associated with the cookie.
///    lpszCookieData = Pointer to the actual data to be associated with the URL.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetSetCookieA(const(PSTR) lpszUrl, const(PSTR) lpszCookieName, const(PSTR) lpszCookieData);

///Creates a cookie associated with the specified URL.
///Params:
///    lpszUrl = Pointer to a <b>null</b>-terminated string that specifies the URL for which the cookie should be set.
///    lpszCookieName = Pointer to a <b>null</b>-terminated string that specifies the name to be associated with the cookie data. If this
///                     parameter is <b>NULL</b>, no name is associated with the cookie.
///    lpszCookieData = Pointer to the actual data to be associated with the URL.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get a specific error message, call GetLastError.
///    
@DllImport("WININET")
BOOL InternetSetCookieW(const(PWSTR) lpszUrl, const(PWSTR) lpszCookieName, const(PWSTR) lpszCookieData);

///Retrieves the cookie for the specified URL.
///Params:
///    lpszUrl = A pointer to a <b>null</b>-terminated string that specifies the URL for which cookies are to be retrieved.
///    lpszCookieName = Not implemented.
///    lpszCookieData = A pointer to a buffer that receives the cookie data. This parameter can be <b>NULL</b>.
///    lpdwSize = A pointer to a variable that specifies the size of the <i>lpszCookieData</i> parameter buffer, in TCHARs. If the
///               function succeeds, the buffer receives the amount of data copied to the <i>lpszCookieData</i> buffer. If
///               <i>lpszCookieData</i> is <b>NULL</b>, this parameter receives a value that specifies the size of the buffer
///               necessary to copy all the cookie data, expressed as a byte count.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error data, call GetLastError. The following error values apply to <b>InternetGetCookie</b>. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There is no cookie for the specified URL and all
///    its parents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The value passed in <i>lpdwSize</i> is insufficient to copy all the cookie data. The value returned
///    in <i>lpdwSize</i> is the size of the buffer necessary to get all the data. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is
///    invalid. The <i>lpszUrl</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetGetCookieA(const(PSTR) lpszUrl, const(PSTR) lpszCookieName, PSTR lpszCookieData, uint* lpdwSize);

///Retrieves the cookie for the specified URL.
///Params:
///    lpszUrl = A pointer to a <b>null</b>-terminated string that specifies the URL for which cookies are to be retrieved.
///    lpszCookieName = Not implemented.
///    lpszCookieData = A pointer to a buffer that receives the cookie data. This parameter can be <b>NULL</b>.
///    lpdwSize = A pointer to a variable that specifies the size of the <i>lpszCookieData</i> parameter buffer, in TCHARs. If the
///               function succeeds, the buffer receives the amount of data copied to the <i>lpszCookieData</i> buffer. If
///               <i>lpszCookieData</i> is <b>NULL</b>, this parameter receives a value that specifies the size of the buffer
///               necessary to copy all the cookie data, expressed as a byte count.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error data, call GetLastError. The following error values apply to <b>InternetGetCookie</b>. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There is no cookie for the specified URL and all
///    its parents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The value passed in <i>lpdwSize</i> is insufficient to copy all the cookie data. The value returned
///    in <i>lpdwSize</i> is the size of the buffer necessary to get all the data. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is
///    invalid. The <i>lpszUrl</i> parameter is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetGetCookieW(const(PWSTR) lpszUrl, const(PWSTR) lpszCookieName, PWSTR lpszCookieData, uint* lpdwSize);

///The <b>InternetSetCookieEx</b> function creates a cookie with a specified name that is associated with a specified
///URL. This function differs from the InternetSetCookie function by being able to create third-party cookies.
///Params:
///    lpszUrl = Pointer to a <b>null</b>-terminated string that contains the URL for which the cookie should be set. If this
///              pointer is <b>NULL</b>, <b>InternetSetCookieEx</b> fails with an <b>ERROR_INVALID_PARAMETER</b> error.
///    lpszCookieName = Pointer to a <b>null</b>-terminated string that contains the name to associate with this cookie. If this pointer
///                     is <b>NULL</b>, then no name is associated with the cookie.
///    lpszCookieData = Pointer to a <b>null</b>-terminated string that contains the data to be associated with the new cookie. If this
///                     pointer is <b>NULL</b>, <b>InternetSetCookieEx</b> fails with an <b>ERROR_INVALID_PARAMETER</b> error.
///    dwFlags = Flags that control how the function retrieves cookie data: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="INTERNET_COOKIE_EVALUATE_P3P"></a><a id="internet_cookie_evaluate_p3p"></a><dl>
///              <dt><b>INTERNET_COOKIE_EVALUATE_P3P</b></dt> </dl> </td> <td width="60%"> If this flag is set and the
///              <i>dwReserved</i> parameter is not <b>NULL</b>, then the <i>dwReserved</i> parameter is cast to an <b>LPCTSTR</b>
///              that points to a Platform-for-Privacy-Protection (P3P) header for the cookie in question. </td> </tr> <tr> <td
///              width="40%"><a id="INTERNET_COOKIE_HTTPONLY"></a><a id="internet_cookie_httponly"></a><dl>
///              <dt><b>INTERNET_COOKIE_HTTPONLY</b></dt> </dl> </td> <td width="60%"> Enables the retrieval of cookies that are
///              marked as "HTTPOnly". Do not use this flag if you expose a scriptable interface, because this has security
///              implications. If you expose a scriptable interface, you can become an attack vector for cross-site scripting
///              attacks. It is utterly imperative that you use this flag only if they can guarantee that you will never permit
///              third-party code to set a cookie using this flag by way of an extensibility mechanism you provide. <b>Version:
///              </b>Requires Internet Explorer 8.0 or later. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_COOKIE_THIRD_PARTY"></a><a id="internet_cookie_third_party"></a><dl>
///              <dt><b>INTERNET_COOKIE_THIRD_PARTY</b></dt> </dl> </td> <td width="60%"> Indicates that the cookie being set is a
///              third-party cookie. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESTRICTED_ZONE"></a><a
///              id="internet_flag_restricted_zone"></a><dl> <dt><b>INTERNET_FLAG_RESTRICTED_ZONE</b></dt> </dl> </td> <td
///              width="60%"> Indicates that the cookie being set is associated with an untrusted site. </td> </tr> </table>
///    dwReserved = <b>NULL</b>, or contains a pointer to a Platform-for-Privacy-Protection (P3P) header to be associated with the
///                 cookie.
///Returns:
///    Returns a member of the InternetCookieState enumeration if successful, or <b>FALSE</b> if the function fails. On
///    failure, if a call to GetLastError returns ERROR_NOT_ENOUGH_MEMORY, insufficient system memory was available.
///    
@DllImport("WININET")
uint InternetSetCookieExA(const(PSTR) lpszUrl, const(PSTR) lpszCookieName, const(PSTR) lpszCookieData, 
                          uint dwFlags, size_t dwReserved);

///The <b>InternetSetCookieEx</b> function creates a cookie with a specified name that is associated with a specified
///URL. This function differs from the InternetSetCookie function by being able to create third-party cookies.
///Params:
///    lpszUrl = Pointer to a <b>null</b>-terminated string that contains the URL for which the cookie should be set. If this
///              pointer is <b>NULL</b>, <b>InternetSetCookieEx</b> fails with an <b>ERROR_INVALID_PARAMETER</b> error.
///    lpszCookieName = Pointer to a <b>null</b>-terminated string that contains the name to associate with this cookie. If this pointer
///                     is <b>NULL</b>, then no name is associated with the cookie.
///    lpszCookieData = Pointer to a <b>null</b>-terminated string that contains the data to be associated with the new cookie. If this
///                     pointer is <b>NULL</b>, <b>InternetSetCookieEx</b> fails with an <b>ERROR_INVALID_PARAMETER</b> error.
///    dwFlags = Flags that control how the function retrieves cookie data: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="INTERNET_COOKIE_EVALUATE_P3P"></a><a id="internet_cookie_evaluate_p3p"></a><dl>
///              <dt><b>INTERNET_COOKIE_EVALUATE_P3P</b></dt> </dl> </td> <td width="60%"> If this flag is set and the
///              <i>dwReserved</i> parameter is not <b>NULL</b>, then the <i>dwReserved</i> parameter is cast to an <b>LPCTSTR</b>
///              that points to a Platform-for-Privacy-Protection (P3P) header for the cookie in question. </td> </tr> <tr> <td
///              width="40%"><a id="INTERNET_COOKIE_HTTPONLY"></a><a id="internet_cookie_httponly"></a><dl>
///              <dt><b>INTERNET_COOKIE_HTTPONLY</b></dt> </dl> </td> <td width="60%"> Enables the retrieval of cookies that are
///              marked as "HTTPOnly". Do not use this flag if you expose a scriptable interface, because this has security
///              implications. If you expose a scriptable interface, you can become an attack vector for cross-site scripting
///              attacks. It is utterly imperative that you use this flag only if they can guarantee that you will never permit
///              third-party code to set a cookie using this flag by way of an extensibility mechanism you provide. <b>Version:
///              </b>Requires Internet Explorer 8.0 or later. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_COOKIE_THIRD_PARTY"></a><a id="internet_cookie_third_party"></a><dl>
///              <dt><b>INTERNET_COOKIE_THIRD_PARTY</b></dt> </dl> </td> <td width="60%"> Indicates that the cookie being set is a
///              third-party cookie. </td> </tr> <tr> <td width="40%"><a id="INTERNET_FLAG_RESTRICTED_ZONE"></a><a
///              id="internet_flag_restricted_zone"></a><dl> <dt><b>INTERNET_FLAG_RESTRICTED_ZONE</b></dt> </dl> </td> <td
///              width="60%"> Indicates that the cookie being set is associated with an untrusted site. </td> </tr> </table>
///    dwReserved = <b>NULL</b>, or contains a pointer to a Platform-for-Privacy-Protection (P3P) header to be associated with the
///                 cookie.
///Returns:
///    Returns a member of the InternetCookieState enumeration if successful, or <b>FALSE</b> if the function fails. On
///    failure, if a call to GetLastError returns ERROR_NOT_ENOUGH_MEMORY, insufficient system memory was available.
///    
@DllImport("WININET")
uint InternetSetCookieExW(const(PWSTR) lpszUrl, const(PWSTR) lpszCookieName, const(PWSTR) lpszCookieData, 
                          uint dwFlags, size_t dwReserved);

///The <b>InternetGetCookieEx</b> function retrieves data stored in cookies associated with a specified URL. Unlike
///InternetGetCookie, <b>InternetGetCookieEx</b> can be used to restrict data retrieved to a single cookie name or, by
///policy, associated with untrusted sites or third-party cookies.
///Params:
///    lpszUrl = A pointer to a <b>null</b>-terminated string that contains the URL with which the cookie to retrieve is
///              associated. This parameter cannot be <b>NULL</b> or <b>InternetGetCookieEx</b> fails and returns an
///              <b>ERROR_INVALID_PARAMETER</b> error.
///    lpszCookieName = A pointer to a <b>null</b>-terminated string that contains the name of the cookie to retrieve. This name is
///                     case-sensitive.
///    lpszCookieData = A pointer to a buffer to receive the cookie data.
///    lpdwSize = A pointer to a DWORD variable. On entry, the variable must contain the size, in TCHARs, of the buffer pointed to
///               by the <i>pchCookieData</i> parameter. On exit, if the function is successful, this variable contains the number
///               of TCHARs of cookie data copied into the buffer. If <b>NULL</b> was passed as the <i>lpszCookieData</i>
///               parameter, or if the function fails with an error of <b>ERROR_INSUFFICIENT_BUFFER</b>, the variable contains the
///               size, in BYTEs, of buffer required to receive the cookie data. This parameter cannot be <b>NULL</b> or
///               <b>InternetGetCookieEx</b> fails and returns an <b>ERROR_INVALID_PARAMETER</b> error.
///    dwFlags = A flag that controls how the function retrieves cookie data. This parameter can be one of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_COOKIE_HTTPONLY"></a><a
///              id="internet_cookie_httponly"></a><dl> <dt><b>INTERNET_COOKIE_HTTPONLY</b></dt> </dl> </td> <td width="60%">
///              Enables the retrieval of cookies that are marked as "HTTPOnly". Do not use this flag if you expose a scriptable
///              interface, because this has security implications. It is imperative that you use this flag only if you can
///              guarantee that you will never expose the cookie to third-party code by way of an extensibility mechanism you
///              provide. <b>Version: </b>Requires Internet Explorer 8.0 or later. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_COOKIE_THIRD_PARTY"></a><a id="internet_cookie_third_party"></a><dl>
///              <dt><b>INTERNET_COOKIE_THIRD_PARTY</b></dt> </dl> </td> <td width="60%"> Retrieves only third-party cookies if
///              policy explicitly allows all cookies for the specified URL to be retrieved. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_RESTRICTED_ZONE"></a><a id="internet_flag_restricted_zone"></a><dl>
///              <dt><b>INTERNET_FLAG_RESTRICTED_ZONE</b></dt> </dl> </td> <td width="60%"> Retrieves only cookies that would be
///              allowed if the specified URL were untrusted; that is, if it belonged to the URLZONE_UNTRUSTED zone. </td> </tr>
///              </table>
///    lpReserved = Reserved for future use. Set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get a specific error value, call GetLastError. If <b>NULL</b> is passed to <i>lpszCookieData</i>, the call will
///    succeed and the function will not set <b>ERROR_INSUFFICIENT_BUFFER</b>. The following error codes may be set by
///    this function. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Returned if cookie data retrieved is
///    larger than the buffer size pointed to by the <i>pcchCookieData</i> parameter or if that parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> Returned if either the <i>pchURL</i> or the <i>pcchCookieData</i> parameter is <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> Returned if no
///    cookied data as specified could be retrieved. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetGetCookieExA(const(PSTR) lpszUrl, const(PSTR) lpszCookieName, PSTR lpszCookieData, uint* lpdwSize, 
                          uint dwFlags, void* lpReserved);

///The <b>InternetGetCookieEx</b> function retrieves data stored in cookies associated with a specified URL. Unlike
///InternetGetCookie, <b>InternetGetCookieEx</b> can be used to restrict data retrieved to a single cookie name or, by
///policy, associated with untrusted sites or third-party cookies.
///Params:
///    lpszUrl = A pointer to a <b>null</b>-terminated string that contains the URL with which the cookie to retrieve is
///              associated. This parameter cannot be <b>NULL</b> or <b>InternetGetCookieEx</b> fails and returns an
///              <b>ERROR_INVALID_PARAMETER</b> error.
///    lpszCookieName = A pointer to a <b>null</b>-terminated string that contains the name of the cookie to retrieve. This name is
///                     case-sensitive.
///    lpszCookieData = A pointer to a buffer to receive the cookie data.
///    lpdwSize = A pointer to a DWORD variable. On entry, the variable must contain the size, in TCHARs, of the buffer pointed to
///               by the <i>pchCookieData</i> parameter. On exit, if the function is successful, this variable contains the number
///               of TCHARs of cookie data copied into the buffer. If <b>NULL</b> was passed as the <i>lpszCookieData</i>
///               parameter, or if the function fails with an error of <b>ERROR_INSUFFICIENT_BUFFER</b>, the variable contains the
///               size, in BYTEs, of buffer required to receive the cookie data. This parameter cannot be <b>NULL</b> or
///               <b>InternetGetCookieEx</b> fails and returns an <b>ERROR_INVALID_PARAMETER</b> error.
///    dwFlags = A flag that controls how the function retrieves cookie data. This parameter can be one of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_COOKIE_HTTPONLY"></a><a
///              id="internet_cookie_httponly"></a><dl> <dt><b>INTERNET_COOKIE_HTTPONLY</b></dt> </dl> </td> <td width="60%">
///              Enables the retrieval of cookies that are marked as "HTTPOnly". Do not use this flag if you expose a scriptable
///              interface, because this has security implications. It is imperative that you use this flag only if you can
///              guarantee that you will never expose the cookie to third-party code by way of an extensibility mechanism you
///              provide. <b>Version: </b>Requires Internet Explorer 8.0 or later. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_COOKIE_THIRD_PARTY"></a><a id="internet_cookie_third_party"></a><dl>
///              <dt><b>INTERNET_COOKIE_THIRD_PARTY</b></dt> </dl> </td> <td width="60%"> Retrieves only third-party cookies if
///              policy explicitly allows all cookies for the specified URL to be retrieved. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_FLAG_RESTRICTED_ZONE"></a><a id="internet_flag_restricted_zone"></a><dl>
///              <dt><b>INTERNET_FLAG_RESTRICTED_ZONE</b></dt> </dl> </td> <td width="60%"> Retrieves only cookies that would be
///              allowed if the specified URL were untrusted; that is, if it belonged to the URLZONE_UNTRUSTED zone. </td> </tr>
///              </table>
///    lpReserved = Reserved for future use. Set to <b>NULL</b>.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get a specific error value, call GetLastError. If <b>NULL</b> is passed to <i>lpszCookieData</i>, the call will
///    succeed and the function will not set <b>ERROR_INSUFFICIENT_BUFFER</b>. The following error codes may be set by
///    this function. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Returned if cookie data retrieved is
///    larger than the buffer size pointed to by the <i>pcchCookieData</i> parameter or if that parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> Returned if either the <i>pchURL</i> or the <i>pcchCookieData</i> parameter is <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> Returned if no
///    cookied data as specified could be retrieved. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL InternetGetCookieExW(const(PWSTR) lpszUrl, const(PWSTR) lpszCookieName, PWSTR lpszCookieData, uint* lpdwSize, 
                          uint dwFlags, void* lpReserved);

///Frees an array of [INTERNET\_COOKIE2](ns-wininet-internet-cookie2.md) structures returned by
///[InternetGetCookieEx2](nf-wininet-internetgetcookieex2.md).
///Params:
///    pCookies = Pointer to an array of [**INTERNET\_COOKIE2**](wininet/ns-wininet-internet-cookie2.md) structures.
///    dwCookieCount = The number of structures in the array.
@DllImport("WININET")
void InternetFreeCookies(INTERNET_COOKIE2* pCookies, uint dwCookieCount);

///Retrieves one or more cookies associated with the specified URL.
///Params:
///    pcwszUrl = The URL for which to retrieve cookies.
///    pcwszCookieName = The name of the cookie to retrieve. May be NULL.
///    dwFlags = Flags of the cookie to retrieve. The following flags are available. | Value | Meaning | |-------|---------| |
///              INTERNET_COOKIE_THIRD_PARTY | Retrieve cookies as a third party, causing first-party-only cookies to be excluded.
///              | | INTERNET_COOKIE_NON_SCRIPT | Indicate that this query was not triggered via JavaScript, allowing retrieval of
///              HTTP-only cookies. | | INTERNET_COOKIE_SAME_SITE_LEVEL_CROSS_SITE | Retrieve cookies as if in a cross site
///              context, excluding cookies with the SameSite property set. | | INTERNET_FLAG_RESTRICTED_ZONE | Retrieve only
///              cookies that would be allowed if the specified URL were untrusted; that is, if it belonged to the
///              URLZONE_UNTRUSTED zone. |
///    ppCookies = Pointer that receives an array of [INTERNET\_COOKIE2](ns-wininet-internet_cookie2.md) structures. The returned
///                array must be freed by [InternetFreeCookies](nf-wininet-internetfreecookies.md).
///    pdwCookieCount = Pointer to a DWORD that receives the number of structures in the array.
///Returns:
///    Returns ERROR_SUCCESS if successful, or a [system error code](/windows/desktop/debug/system-error-codes) on
///    failure.
///    
@DllImport("WININET")
uint InternetGetCookieEx2(const(PWSTR) pcwszUrl, const(PWSTR) pcwszCookieName, uint dwFlags, 
                          INTERNET_COOKIE2** ppCookies, uint* pdwCookieCount);

///Creates a cookie associated with the specified URL.
///Params:
///    pcwszUrl = The URL for which to set the cookie.
///    pCookie = Pointer to an [INTERNET\_COOKIE2](ns-wininet-internet_cookie2.md) structure containing the cookie data.
///    pcwszP3PPolicy = String containing the Platform-for-Privacy-Protection (P3P) policy for the cookie. May be NULL.
///    dwFlags = Flags for the cookie to be set. The following flags are available. | Value | Meaning | |-------|---------| |
///              INTERNET_COOKIE_THIRD_PARTY | Set this cookie in a third-party context. | | INTERNET_COOKIE_PROMPT_REQUIRED |
///              Show a UI prompt for the user to accept or reject this cookie. | | INTERNET_COOKIE_EVALUATE_P3P | Evaluate the
///              provided P3P policy for this cookie. This will evaluate default policy when *pcwszP3PPolicy* is NULL. | |
///              INTERNET_COOKIE_NON_SCRIPT | Indicate that this cookie is not being set via JavaScript, allowing HTTP-only
///              cookies to be set. | | INTERNET_COOKIE_APPLY_HOST_ONLY | Apply host-only policy to this cookie. If the domain
///              attribute is not set, then this cookie will be marked host-only. |
///    pdwCookieState = Pointer to a DWORD that receives the result of setting the cookie. For a list of possible values, see
///                     [InternetCookieState](/windows/desktop/wininet/ne-wininet.internetcookiestate).
///Returns:
///    Returns ERROR_SUCCESS if successful, or a [system error code](/windows/desktop/debug/system-error-codes) on
///    failure.
///    
@DllImport("WININET")
uint InternetSetCookieEx2(const(PWSTR) pcwszUrl, const(INTERNET_COOKIE2)* pCookie, const(PWSTR) pcwszP3PPolicy, 
                          uint dwFlags, uint* pdwCookieState);

///Attempts to make a connection to the Internet.
///Params:
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns ERROR_SUCCESS if successful, or a system error code otherwise.
///    
@DllImport("WININET")
uint InternetAttemptConnect(uint dwReserved);

///<p class="CCE_Message">[<b>InternetCheckConnection</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
///NetworkInformation.GetInternetConnectionProfile or the NLM Interfaces. ] Allows an application to check if a
///connection to the Internet can be established.
///Params:
///    lpszUrl = Pointer to a <b>null</b>-terminated string that specifies the URL to use to check the connection. This value can
///              be <b>NULL</b>.
///    dwFlags = Options. FLAG_ICC_FORCE_CONNECTION is the only flag that is currently available. If this flag is set, it forces a
///              connection. A sockets connection is attempted in the following order: <ul> <li>If <i>lpszUrl</i> is
///              non-<b>NULL</b>, the host value is extracted from it and used to ping that specific host.</li> <li>If
///              <i>lpszUrl</i> is <b>NULL</b> and there is an entry in the internal server database for the nearest server, the
///              host value is extracted from the entry and used to ping that server.</li> </ul>
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if a connection is made successfully, or <b>FALSE</b> otherwise. Use GetLastError to retrieve
///    the error code. ERROR_NOT_CONNECTED is returned by <b>GetLastError</b> if a connection cannot be made or if the
///    sockets database is unconditionally offline.
///    
@DllImport("WININET")
BOOL InternetCheckConnectionA(const(PSTR) lpszUrl, uint dwFlags, uint dwReserved);

///<p class="CCE_Message">[<b>InternetCheckConnection</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
///NetworkInformation.GetInternetConnectionProfile or the NLM Interfaces. ] Allows an application to check if a
///connection to the Internet can be established.
///Params:
///    lpszUrl = Pointer to a <b>null</b>-terminated string that specifies the URL to use to check the connection. This value can
///              be <b>NULL</b>.
///    dwFlags = Options. FLAG_ICC_FORCE_CONNECTION is the only flag that is currently available. If this flag is set, it forces a
///              connection. A sockets connection is attempted in the following order: <ul> <li>If <i>lpszUrl</i> is
///              non-<b>NULL</b>, the host value is extracted from it and used to ping that specific host.</li> <li>If
///              <i>lpszUrl</i> is <b>NULL</b> and there is an entry in the internal server database for the nearest server, the
///              host value is extracted from the entry and used to ping that server.</li> </ul>
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if a connection is made successfully, or <b>FALSE</b> otherwise. Use GetLastError to retrieve
///    the error code. ERROR_NOT_CONNECTED is returned by <b>GetLastError</b> if a connection cannot be made or if the
///    sockets database is unconditionally offline.
///    
@DllImport("WININET")
BOOL InternetCheckConnectionW(const(PWSTR) lpszUrl, uint dwFlags, uint dwReserved);

///The <b>ResumeSuspendedDownload</b> function resumes a request that is suspended by a user interface dialog box.
///Params:
///    hRequest = Handle of the request that is suspended by a user interface dialog box.
///    dwResultCode = The error result returned from InternetErrorDlg, or zero if a different dialog is invoked.
///Returns:
///    Returns <b>TRUE</b> if successful; otherwise <b>FALSE</b>. Call GetLastError for extended error information.
///    
@DllImport("WININET")
BOOL ResumeSuspendedDownload(void* hRequest, uint dwResultCode);

///Displays a dialog box for the error that is passed to <b>InternetErrorDlg</b>, if an appropriate dialog box exists.
///If the <b>FLAGS_ERROR_UI_FILTER_FOR_ERRORS</b> flag is used, the function also checks the headers for any hidden
///errors and displays a dialog box if needed.
///Params:
///    hWnd = Handle to the parent window for any needed dialog box. If no dialog box is needed and
///           <b>FLAGS_ERROR_UI_FLAGS_NO_UI</b> is passed to <i>dwFlags</i>, then this parameter can be <b>NULL</b>.
///    hRequest = Handle to the Internet connection used in the call to HttpSendRequest.
///    dwError = Error value for which to display a dialog box. This parameter can be one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION</dt>
///              </dl> </td> <td width="60%"> Allows the user to confirm the redirect. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT</dt> </dl> </td> <td width="60%"> Displays a dialog indicating that the
///              auto proxy script is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_CHG_POST_IS_NON_SECURE</dt> </dl> </td> <td width="60%"> Displays a dialog asking the user
///              whether to post the given data on a non-secure channel. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED</dt> </dl> </td> <td width="60%"> The server is requesting a client
///              certificate. The return value for this error is always ERROR_SUCCESS, regardless of whether or not the user has
///              selected a certificate. If the user has not selected a certificate then anonymous client authentication will be
///              attempted on the subsequent request. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR</dt> </dl> </td> <td width="60%"> Notifies the user of the zone
///              crossing to a secure site. </td> </tr> <tr> <td width="40%"> <dl> <dt>ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR</dt>
///              </dl> </td> <td width="60%"> Notifies the user of the zone crossing from a secure site. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR</dt> </dl> </td> <td width="60%"> Notifies the user
///              that the data being posted is now being redirected to a non-secure site. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_INCORRECT_PASSWORD</dt> </dl> </td> <td width="60%"> Displays a dialog box requesting the
///              user's name and password. </td> </tr> <tr> <td width="40%"> <dl> <dt>ERROR_INTERNET_INVALID_CA</dt> </dl> </td>
///              <td width="60%"> Indicates that the SSL certificate Common Name (host name field) is incorrect. Displays an
///              Invalid SSL Common Name dialog box and lets the user view the incorrect certificate. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>ERROR_INTERNET_MIXED_SECURITY</dt> </dl> </td> <td width="60%"> Displays a warning to the
///              user concerning mixed secure and non-secure content. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_POST_IS_NON_SECURE</dt> </dl> </td> <td width="60%"> Displays a dialog asking the user whether
///              to post the given data on a non-secure channel. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_SEC_CERT_CN_INVALID</dt> </dl> </td> <td width="60%"> Indicates that the SSL certificate
///              Common Name (host name field) is incorrect. Displays an Invalid SSL Common Name dialog box and lets the user view
///              the incorrect certificate. Also allows the user to select a certificate in response to a server request. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>ERROR_INTERNET_SEC_CERT_ERRORS</dt> </dl> </td> <td width="60%"> Displays a
///              warning to the user showing the issues with the server certificate. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>ERROR_INTERNET_SEC_CERT_DATE_INVALID</dt> </dl> </td> <td width="60%"> Tells the user that the SSL
///              certificate has expired. </td> </tr> <tr> <td width="40%"> <dl> <dt>ERROR_INTERNET_SEC_CERT_REV_FAILED</dt> </dl>
///              </td> <td width="60%"> Displays a warning to the user showing that the server certificate’s revocation check
///              failed. </td> </tr> <tr> <td width="40%"> <dl> <dt>ERROR_INTERNET_SEC_CERT_REVOKED</dt> </dl> </td> <td
///              width="60%"> Displays a dialog indicating that the server certificate is revoked. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT</dt> </dl> </td> <td width="60%"> Displays a
///              dialog indicating that the auto proxy script could not be downloaded. </td> </tr> </table>
///    dwFlags = Actions. This parameter can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"> <dl> <dt>FLAGS_ERROR_UI_FILTER_FOR_ERRORS</dt> </dl> </td> <td width="60%"> Scans the
///              returned headers for errors. Call <b>InternetErrorDlg</b> with this flag set following a call to HttpSendRequest
///              so as to detect hidden errors. Authentication errors, for example, are normally hidden because the call to
///              HttpSendRequest completes successfully, but by scanning the status codes, <b>InternetErrorDlg</b> can determine
///              that the proxy or server requires authentication. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS</dt> </dl> </td> <td width="60%"> If the function succeeds, stores the
///              results of the dialog box in the Internet handle. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>FLAGS_ERROR_UI_FLAGS_GENERATE_DATA</dt> </dl> </td> <td width="60%"> Queries the Internet handle for needed
///              information. The function constructs the appropriate data structure for the error. (For example, for Cert CN
///              failures, the function grabs the certificate.) </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>FLAGS_ERROR_UI_SERIALIZE_DIALOGS</dt> </dl> </td> <td width="60%"> Serializes authentication dialog boxes for
///              concurrent requests on a password cache entry. The <i>lppvData</i> parameter should contain the address of a
///              pointer to an INTERNET_AUTH_NOTIFY_DATA structure, and the client should implement a thread-safe, non-blocking
///              callback function. </td> </tr> <tr> <td width="40%"> <dl> <dt>FLAGS_ERROR_UI_FLAGS_NO_UI</dt> </dl> </td> <td
///              width="60%"> Allows the caller to pass <b>NULL</b> to the <i>hWnd</i> parameter without error. To be used in
///              circumstances in which no user interface is required. </td> </tr> </table>
///    lppvData = Pointer to the address of a data structure. The structure can be different for each error that needs to be
///               handled.
///Returns:
///    Returns one of the following values, or an error value otherwise. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The function completed successfully. For more information, see <b>ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED</b> in
///    the <i>dwError</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl> </td>
///    <td width="60%"> The function was canceled by the user. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INTERNET_FORCE_RETRY</b></dt> </dl> </td> <td width="60%"> This indicates that the function needs to
///    redo its request. In the case of authentication this indicates that the user clicked the <b>OK</b> button. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The handle to
///    the parent window is invalid. </td> </tr> </table>
///    
@DllImport("WININET")
uint InternetErrorDlg(HWND hWnd, void* hRequest, uint dwError, uint dwFlags, void** lppvData);

///Checks for changes between secure and nonsecure URLs. Always inform the user when a change occurs in security between
///two URLs. Typically, an application should allow the user to acknowledge the change through interaction with a dialog
///box.
///Params:
///    hWnd = Handle to the parent window for any required dialog box.
///    szUrlPrev = Pointer to a null-terminated string that specifies the URL that was viewed before the current request was made.
///    szUrlNew = Pointer to a null-terminated string that specifies the new URL that the user has requested to view.
///    bPost = Not implemented.
///Returns:
///    Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The user confirmed that it was okay
///    to continue, or there was no user input required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The user canceled the request. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    to carry out the request. </td> </tr> </table>
///    
@DllImport("WININET")
uint InternetConfirmZoneCrossingA(HWND hWnd, PSTR szUrlPrev, PSTR szUrlNew, BOOL bPost);

///Checks for changes between secure and nonsecure URLs. Always inform the user when a change occurs in security between
///two URLs. Typically, an application should allow the user to acknowledge the change through interaction with a dialog
///box.
///Params:
///    hWnd = Handle to the parent window for any required dialog box.
///    szUrlPrev = Pointer to a null-terminated string that specifies the URL that was viewed before the current request was made.
///    szUrlNew = Pointer to a null-terminated string that specifies the new URL that the user has requested to view.
///    bPost = Not implemented.
///Returns:
///    Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The user confirmed that it was okay
///    to continue, or there was no user input required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The user canceled the request. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    to carry out the request. </td> </tr> </table>
///    
@DllImport("WININET")
uint InternetConfirmZoneCrossingW(HWND hWnd, PWSTR szUrlPrev, PWSTR szUrlNew, BOOL bPost);

///Checks for changes between secure and nonsecure URLs. Always inform the user when a change occurs in security between
///two URLs. Typically, an application should allow the user to acknowledge the change through interaction with a dialog
///box.
///Params:
///    hWnd = Handle to the parent window for any required dialog box.
///    szUrlPrev = Pointer to a null-terminated string that specifies the URL that was viewed before the current request was made.
///    szUrlNew = Pointer to a null-terminated string that specifies the new URL that the user has requested to view.
///    bPost = Not implemented.
///Returns:
///    Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The user confirmed that it was okay
///    to continue, or there was no user input required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The user canceled the request. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory
///    to carry out the request. </td> </tr> </table>
///    
@DllImport("WININET")
uint InternetConfirmZoneCrossing(HWND hWnd, PSTR szUrlPrev, PSTR szUrlNew, BOOL bPost);

///Creates a local file name for saving the cache entry based on the specified URL and the file name extension.
///Params:
///    lpszUrlName = Pointer to a string value that contains the name of the URL. The string must contain a value; an empty string
///                  will cause <b>CreateUrlCacheEntry</b> to fail. In addition, the string must not contain any escape characters.
///    dwExpectedFileSize = Expected size of the file needed to store the data that corresponds to the source entity, in <b>TCHARs</b>. If
///                         the expected size is unknown, set this value to zero.
///    lpszFileExtension = Pointer to a string value that contains an extension name of the file in the local storage.
///    lpszFileName = Pointer to a buffer that receives the file name. The buffer should be large enough to store the path of the
///                   created file (at least MAX_PATH characters in length).
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL CreateUrlCacheEntryA(const(PSTR) lpszUrlName, uint dwExpectedFileSize, const(PSTR) lpszFileExtension, 
                          PSTR lpszFileName, uint dwReserved);

///Creates a local file name for saving the cache entry based on the specified URL and the file name extension.
///Params:
///    lpszUrlName = Pointer to a string value that contains the name of the URL. The string must contain a value; an empty string
///                  will cause <b>CreateUrlCacheEntry</b> to fail. In addition, the string must not contain any escape characters.
///    dwExpectedFileSize = Expected size of the file needed to store the data that corresponds to the source entity, in <b>TCHARs</b>. If
///                         the expected size is unknown, set this value to zero.
///    lpszFileExtension = Pointer to a string value that contains an extension name of the file in the local storage.
///    lpszFileName = Pointer to a buffer that receives the file name. The buffer should be large enough to store the path of the
///                   created file (at least MAX_PATH characters in length).
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    If the function succeeds, the function returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To
///    get extended error information, call GetLastError.
///    
@DllImport("WININET")
BOOL CreateUrlCacheEntryW(const(PWSTR) lpszUrlName, uint dwExpectedFileSize, const(PWSTR) lpszFileExtension, 
                          PWSTR lpszFileName, uint dwReserved);

///Stores data in the specified file in the Internet cache and associates it with the specified URL.
///Params:
///    lpszUrlName = Pointer to a string variable that contains the source name of the cache entry. The name string must be unique and
///                  should not contain any escape characters.
///    lpszLocalFileName = Pointer to a string variable that contains the name of the local file that is being cached. This should be the
///                        same name as that returned by <b>CreateUrlCacheEntryA</b>.
///    ExpireTime = FILETIME structure that contains the expire date and time (in Greenwich mean time) of the file that is being
///                 cached. If the expire date and time is unknown, set this parameter to zero.
///    LastModifiedTime = FILETIME structure that contains the last modified date and time (in Greenwich mean time) of the URL that is
///                       being cached. If the last modified date and time is unknown, set this parameter to zero.
///    CacheEntryType = A bitmask indicating the type of cache entry and its properties. The cache entry types include: history entries
///                     (URLHISTORY_CACHE_ENTRY), cookie entries (COOKIE_CACHE_ENTRY), and normal cached content (NORMAL_CACHE_ENTRY).
///                     This parameter can be zero or more of the following property flags, and cache type flags listed below. <table>
///                     <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>COOKIE_CACHE_ENTRY</dt> </dl> </td> <td
///                     width="60%"> Cookie cache entry. </td> </tr> <tr> <td width="40%"> <dl> <dt>EDITED_CACHE_ENTRY</dt> </dl> </td>
///                     <td width="60%"> Cache entry file that has been edited externally. This cache entry type is exempt from
///                     scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>NORMAL_CACHE_ENTRY</dt> </dl> </td> <td width="60%">
///                     Normal cache entry; can be deleted to recover space for new entries. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>SPARSE_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Partial response cache entry. </td> </tr> <tr> <td
///                     width="40%"> <dl> <dt>STICKY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Sticky cache entry; exempt from
///                     scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_OFFLINE_CACHE_ENTRY</dt> </dl> </td> <td
///                     width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_ONLINE_CACHE_ENTRY</dt>
///                     </dl> </td> <td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>URLHISTORY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Visited link cache entry. </td> </tr> </table>
///    lpHeaderInfo = Pointer to the buffer that contains the header information. If this parameter is not <b>NULL</b>, the header
///                   information is treated as extended attributes of the URL that are returned in the <b>lpHeaderInfo</b> member of
///                   the INTERNET_CACHE_ENTRY_INFO structure.
///    cchHeaderInfo = Size of the header information, in <b>TCHARs</b>. If <i>lpHeaderInfo</i> is not <b>NULL</b>, this value is
///                    assumed to indicate the size of the buffer that stores the header information. An application can maintain
///                    headers as part of the data and provide <i>cchHeaderInfo</i> together with a <b>NULL</b> value for
///                    <i>lpHeaderInfo</i>.
///    lpszFileExtension = This parameter is reserved and must be <b>NULL</b>.
///    lpszOriginalUrl = Pointer to a string that contains the original URL, if redirection has occurred.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. The following are possible error values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DISK_FULL</b></dt> </dl> </td> <td width="60%"> The cache storage
///    is full. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The specified local file is not found. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL CommitUrlCacheEntryA(const(PSTR) lpszUrlName, const(PSTR) lpszLocalFileName, FILETIME ExpireTime, 
                          FILETIME LastModifiedTime, uint CacheEntryType, ubyte* lpHeaderInfo, uint cchHeaderInfo, 
                          const(PSTR) lpszFileExtension, const(PSTR) lpszOriginalUrl);

///Stores data in the specified file in the Internet cache and associates it with the specified URL.
///Params:
///    lpszUrlName = Pointer to a string variable that contains the source name of the cache entry. The name string must be unique and
///                  should not contain any escape characters.
///    lpszLocalFileName = Pointer to a string variable that contains the name of the local file that is being cached. This should be the
///                        same name as that returned by <b>CreateUrlCacheEntryW</b>.
///    ExpireTime = FILETIME structure that contains the expire date and time (in Greenwich mean time) of the file that is being
///                 cached. If the expire date and time is unknown, set this parameter to zero.
///    LastModifiedTime = FILETIME structure that contains the last modified date and time (in Greenwich mean time) of the URL that is
///                       being cached. If the last modified date and time is unknown, set this parameter to zero.
///    CacheEntryType = A bitmask indicating the type of cache entry and its properties. The cache entry types include: history entries
///                     (URLHISTORY_CACHE_ENTRY), cookie entries (COOKIE_CACHE_ENTRY), and normal cached content (NORMAL_CACHE_ENTRY).
///                     This parameter can be zero or more of the following property flags, and cache type flags listed below. <table>
///                     <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>COOKIE_CACHE_ENTRY</dt> </dl> </td> <td
///                     width="60%"> Cookie cache entry. </td> </tr> <tr> <td width="40%"> <dl> <dt>EDITED_CACHE_ENTRY</dt> </dl> </td>
///                     <td width="60%"> Cache entry file that has been edited externally. This cache entry type is exempt from
///                     scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>NORMAL_CACHE_ENTRY</dt> </dl> </td> <td width="60%">
///                     Normal cache entry; can be deleted to recover space for new entries. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>SPARSE_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Partial response cache entry. </td> </tr> <tr> <td
///                     width="40%"> <dl> <dt>STICKY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Sticky cache entry; exempt from
///                     scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_OFFLINE_CACHE_ENTRY</dt> </dl> </td> <td
///                     width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_ONLINE_CACHE_ENTRY</dt>
///                     </dl> </td> <td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>URLHISTORY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Visited link cache entry. </td> </tr> </table>
///    lpszHeaderInfo = Pointer to the buffer that contains the header information. If this parameter is not <b>NULL</b>, the header
///                     information is treated as extended attributes of the URL that are returned in the <b>lpHeaderInfo</b> member of
///                     the INTERNET_CACHE_ENTRY_INFO structure.
///    cchHeaderInfo = Size of the header information, in <b>TCHARs</b>. If <i>lpHeaderInfo</i> is not <b>NULL</b>, this value is
///                    assumed to indicate the size of the buffer that stores the header information. An application can maintain
///                    headers as part of the data and provide <i>cchHeaderInfo</i> together with a <b>NULL</b> value for
///                    <i>lpHeaderInfo</i>.
///    lpszFileExtension = This parameter is reserved and must be <b>NULL</b>.
///    lpszOriginalUrl = Pointer to a string that contains the original URL, if redirection has occurred.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. The following are possible error values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DISK_FULL</b></dt> </dl> </td> <td width="60%"> The cache storage
///    is full. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The specified local file is not found. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL CommitUrlCacheEntryW(const(PWSTR) lpszUrlName, const(PWSTR) lpszLocalFileName, FILETIME ExpireTime, 
                          FILETIME LastModifiedTime, uint CacheEntryType, PWSTR lpszHeaderInfo, uint cchHeaderInfo, 
                          const(PWSTR) lpszFileExtension, const(PWSTR) lpszOriginalUrl);

///Locks the cache entry file associated with the specified URL.
///Params:
///    lpszUrlName = Pointer to a string that contains the URL of the resource associated with the cache entry. This must be a unique
///                  name. The name string should not contain any escape characters.
///    lpCacheEntryInfo = Pointer to a cache entry information buffer. If the buffer is not sufficient, this function returns
///                       ERROR_INSUFFICIENT_BUFFER and sets <i>lpdwCacheEntryInfoBufferSize</i> to the number of bytes required.
///    lpcbCacheEntryInfo = Pointer to an unsigned long integer variable that specifies the size of the <i>lpCacheEntryInfo</i> buffer, in
///                         bytes. When the function returns, the variable contains the size, in bytes, of the actual buffer used or the
///                         number of bytes required to retrieve the cache entry file. The caller should check the return value in this
///                         parameter. If the return size is less than or equal to the size passed in, all the relevant data has been
///                         returned.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The cache entry specified
///    by the source name is not found in the cache storage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>lpCacheEntryInfo</i>
///    buffer as specified by <i>lpdwCacheEntryInfoBufferSize</i> is not sufficient to contain all the information. The
///    value returned in <i>lpdwCacheEntryInfoBufferSize</i> indicates the buffer size necessary to get all the
///    information. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL RetrieveUrlCacheEntryFileA(const(PSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOA* lpCacheEntryInfo, 
                                uint* lpcbCacheEntryInfo, uint dwReserved);

///Locks the cache entry file associated with the specified URL.
///Params:
///    lpszUrlName = Pointer to a string that contains the URL of the resource associated with the cache entry. This must be a unique
///                  name. The name string should not contain any escape characters.
///    lpCacheEntryInfo = Pointer to a cache entry information buffer. If the buffer is not sufficient, this function returns
///                       ERROR_INSUFFICIENT_BUFFER and sets <i>lpdwCacheEntryInfoBufferSize</i> to the number of bytes required.
///    lpcbCacheEntryInfo = Pointer to an unsigned long integer variable that specifies the size of the <i>lpCacheEntryInfo</i> buffer, in
///                         bytes. When the function returns, the variable contains the size, in bytes, of the actual buffer used or the
///                         number of bytes required to retrieve the cache entry file. The caller should check the return value in this
///                         parameter. If the return size is less than or equal to the size passed in, all the relevant data has been
///                         returned.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The cache entry specified
///    by the source name is not found in the cache storage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the <i>lpCacheEntryInfo</i>
///    buffer as specified by <i>lpdwCacheEntryInfoBufferSize</i> is not sufficient to contain all the information. The
///    value returned in <i>lpdwCacheEntryInfoBufferSize</i> indicates the buffer size necessary to get all the
///    information. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL RetrieveUrlCacheEntryFileW(const(PWSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOW* lpCacheEntryInfo, 
                                uint* lpcbCacheEntryInfo, uint dwReserved);

///Unlocks the cache entry that was locked while the file was retrieved for use from the cache.
///Params:
///    lpszUrlName = Pointer to a <b>null</b>-terminated string that specifies the source name of the cache entry that is being
///                  unlocked. The name string should not contain any escape characters.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. ERROR_FILE_NOT_FOUND indicates that the cache entry specified by the source name is not found in
///    the cache storage.
///    
@DllImport("WININET")
BOOL UnlockUrlCacheEntryFileA(const(PSTR) lpszUrlName, uint dwReserved);

///Unlocks the cache entry that was locked while the file was retrieved for use from the cache.
///Params:
///    lpszUrlName = Pointer to a <b>null</b>-terminated string that specifies the source name of the cache entry that is being
///                  unlocked. The name string should not contain any escape characters.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. ERROR_FILE_NOT_FOUND indicates that the cache entry specified by the source name is not found in
///    the cache storage.
///    
@DllImport("WININET")
BOOL UnlockUrlCacheEntryFileW(const(PWSTR) lpszUrlName, uint dwReserved);

///Unlocks the cache entry that was locked while the file was retrieved for use from the cache.
///Params:
///    lpszUrlName = Pointer to a <b>null</b>-terminated string that specifies the source name of the cache entry that is being
///                  unlocked. The name string should not contain any escape characters.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. ERROR_FILE_NOT_FOUND indicates that the cache entry specified by the source name is not found in
///    the cache storage.
///    
@DllImport("WININET")
BOOL UnlockUrlCacheEntryFile(const(PSTR) lpszUrlName, uint dwReserved);

///Provides the most efficient and implementation-independent way to access the cache data.
///Params:
///    lpszUrlName = Pointer to a null-terminated string that contains the source name of the cache entry. This must be a unique name.
///                  The name string should not contain any escape characters.
///    lpCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size, in bytes, of the <i>lpCacheEntryInfo</i> buffer. When the function
///                         returns, the variable receives the number of bytes copied to the buffer or the required size, in bytes, of the
///                         buffer. Note that this buffer size must accommodate both the INTERNET_CACHE_ENTRY_INFO structure and the
///                         associated strings that are stored immediately following it.
///    fRandomRead = Whether the stream is open for random access. Set the flag to <b>TRUE</b> to open the stream for random access.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    If the function succeeds, the function returns a valid handle for use in the ReadUrlCacheEntryStream and
///    UnlockUrlCacheEntryStream functions. If the function fails, it returns <b>NULL</b>. To get extended error
///    information, call GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The cache entry specified by the source name is not found in the cache storage. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of
///    <i>lpCacheEntryInfo</i> as specified by <i>lpdwCacheEntryInfoBufferSize</i> is not sufficient to contain all the
///    information. The value returned in <i>lpdwCacheEntryInfoBufferSize</i> indicates the buffer size necessary to
///    contain all the information. </td> </tr> </table>
///    
@DllImport("WININET")
HANDLE RetrieveUrlCacheEntryStreamA(const(PSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOA* lpCacheEntryInfo, 
                                    uint* lpcbCacheEntryInfo, BOOL fRandomRead, uint dwReserved);

///Provides the most efficient and implementation-independent way to access the cache data.
///Params:
///    lpszUrlName = Pointer to a null-terminated string that contains the source name of the cache entry. This must be a unique name.
///                  The name string should not contain any escape characters.
///    lpCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size, in bytes, of the <i>lpCacheEntryInfo</i> buffer. When the function
///                         returns, the variable receives the number of bytes copied to the buffer or the required size, in bytes, of the
///                         buffer. Note that this buffer size must accommodate both the INTERNET_CACHE_ENTRY_INFO structure and the
///                         associated strings that are stored immediately following it.
///    fRandomRead = Whether the stream is open for random access. Set the flag to <b>TRUE</b> to open the stream for random access.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    If the function succeeds, the function returns a valid handle for use in the ReadUrlCacheEntryStream and
///    UnlockUrlCacheEntryStream functions. If the function fails, it returns <b>NULL</b>. To get extended error
///    information, call GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The cache entry specified by the source name is not found in the cache storage. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of
///    <i>lpCacheEntryInfo</i> as specified by <i>lpdwCacheEntryInfoBufferSize</i> is not sufficient to contain all the
///    information. The value returned in <i>lpdwCacheEntryInfoBufferSize</i> indicates the buffer size necessary to
///    contain all the information. </td> </tr> </table>
///    
@DllImport("WININET")
HANDLE RetrieveUrlCacheEntryStreamW(const(PWSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOW* lpCacheEntryInfo, 
                                    uint* lpcbCacheEntryInfo, BOOL fRandomRead, uint dwReserved);

///Reads the cached data from a stream that has been opened using the RetrieveUrlCacheEntryStream function.
///Params:
///    hUrlCacheStream = Handle that was returned by the RetrieveUrlCacheEntryStream function.
///    dwLocation = Offset to be read from.
///    lpBuffer = Pointer to a buffer that receives the data.
///    lpdwLen = Pointer to a variable that specifies the size of the <i>lpBuffer</i> buffer, in bytes. When the function returns,
///              the variable contains the number of bytes copied to the buffer, or the required size of the buffer, in bytes.
///    Reserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL ReadUrlCacheEntryStream(HANDLE hUrlCacheStream, uint dwLocation, void* lpBuffer, uint* lpdwLen, uint Reserved);

@DllImport("WININET")
BOOL ReadUrlCacheEntryStreamEx(HANDLE hUrlCacheStream, ulong qwLocation, void* lpBuffer, uint* lpdwLen);

///Closes the stream that has been retrieved using the RetrieveUrlCacheEntryStream function.
///Params:
///    hUrlCacheStream = Handle that was returned by the RetrieveUrlCacheEntryStream function.
///    Reserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL UnlockUrlCacheEntryStream(HANDLE hUrlCacheStream, uint Reserved);

///Retrieves information about a cache entry.
///Params:
///    lpszUrlName = A pointer to a null-terminated string that contains the name of the cache entry. The name string should not
///                  contain any escape characters.
///    lpCacheEntryInfo = A pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry. A buffer
///                       should be allocated for this parameter. Since the required size of the buffer is not known in advance, it is best
///                       to allocate a buffer adequate to handle the size of most INTERNET_CACHE_ENTRY_INFO entries. There is no cache
///                       entry size limit, so applications that need to enumerate the cache must be prepared to allocate variable-sized
///                       buffers.
///    lpcbCacheEntryInfo = A pointer to a variable that specifies the size of the <i>lpCacheEntryInfo</i> buffer, in bytes. When the
///                         function returns, the variable contains the number of bytes copied to the buffer, or the required size of the
///                         buffer, in bytes.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified
///    cache entry is not found in the cache. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of <i>lpCacheEntryInfo</i> as
///    specified by <i>lpdwCacheEntryInfoBufferSize</i> is not sufficient to contain all the information. The value
///    returned in <i>lpdwCacheEntryInfoBufferSize</i> indicates the buffer size necessary to contain all the
///    information. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL GetUrlCacheEntryInfoA(const(PSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOA* lpCacheEntryInfo, 
                           uint* lpcbCacheEntryInfo);

///Retrieves information about a cache entry.
///Params:
///    lpszUrlName = A pointer to a null-terminated string that contains the name of the cache entry. The name string should not
///                  contain any escape characters.
///    lpCacheEntryInfo = A pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry. A buffer
///                       should be allocated for this parameter. Since the required size of the buffer is not known in advance, it is best
///                       to allocate a buffer adequate to handle the size of most INTERNET_CACHE_ENTRY_INFO entries. There is no cache
///                       entry size limit, so applications that need to enumerate the cache must be prepared to allocate variable-sized
///                       buffers.
///    lpcbCacheEntryInfo = A pointer to a variable that specifies the size of the <i>lpCacheEntryInfo</i> buffer, in bytes. When the
///                         function returns, the variable contains the number of bytes copied to the buffer, or the required size of the
///                         buffer, in bytes.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified
///    cache entry is not found in the cache. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of <i>lpCacheEntryInfo</i> as
///    specified by <i>lpdwCacheEntryInfoBufferSize</i> is not sufficient to contain all the information. The value
///    returned in <i>lpdwCacheEntryInfoBufferSize</i> indicates the buffer size necessary to contain all the
///    information. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL GetUrlCacheEntryInfoW(const(PWSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOW* lpCacheEntryInfo, 
                           uint* lpcbCacheEntryInfo);

///Initiates the enumeration of the cache groups in the Internet cache.
///Params:
///    dwFlags = This parameter is reserved and must be 0.
///    dwFilter = Filters to be used. This parameter can be zero or one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_SEARCH_ALL</dt> </dl> </td> <td width="60%">
///               Search all cache groups. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_SEARCH_BYURL</dt> </dl> </td> <td
///               width="60%"> Not currently implemented. </td> </tr> </table>
///    lpSearchCondition = This parameter is reserved and must be <b>NULL</b>.
///    dwSearchCondition = This parameter is reserved and must be 0.
///    lpGroupId = Pointer to the ID of the first cache group that matches the search criteria.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns a valid handle to the first item in the enumeration if successful, or <b>NULL</b> otherwise. To get
///    specific error information, call GetLastError. If the function finds no matching files, <b>GetLastError</b>
///    returns ERROR_NO_MORE_FILES.
///    
@DllImport("WININET")
HANDLE FindFirstUrlCacheGroup(uint dwFlags, uint dwFilter, void* lpSearchCondition, uint dwSearchCondition, 
                              long* lpGroupId, void* lpReserved);

///Retrieves the next cache group in a cache group enumeration started by FindFirstUrlCacheGroup.
///Params:
///    hFind = The cache group enumeration handle, which is returned by FindFirstUrlCacheGroup.
///    lpGroupId = Pointer to a variable that receives the cache group identifier.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL FindNextUrlCacheGroup(HANDLE hFind, long* lpGroupId, void* lpReserved);

///Retrieves the attribute information of the specified cache group.
///Params:
///    gid = Identifier of the cache group.
///    dwFlags = This parameter is reserved and must be 0.
///    dwAttributes = Attributes to be retrieved. This can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                   </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_BASIC</dt> </dl> </td> <td width="60%"> Retrieves the
///                   flags, type, and disk quota attributes of the cache group. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_ATTRIBUTE_FLAG</dt> </dl> </td> <td width="60%"> Sets or retrieves the flags associated with the
///                   cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_GET_ALL</dt> </dl> </td> <td
///                   width="60%"> Retrieves all the attributes of the cache group. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_ATTRIBUTE_GROUPNAME</dt> </dl> </td> <td width="60%"> Sets or retrieves the group name of the
///                   cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_QUOTA</dt> </dl> </td> <td
///                   width="60%"> Sets or retrieves the disk quota associated with the cache group. </td> </tr> <tr> <td width="40%">
///                   <dl> <dt>CACHEGROUP_ATTRIBUTE_STORAGE</dt> </dl> </td> <td width="60%"> Sets or retrieves the group owner storage
///                   associated with the cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_TYPE</dt> </dl>
///                   </td> <td width="60%"> Sets or retrieves the cache group type. </td> </tr> </table>
///    lpGroupInfo = Pointer to an INTERNET_CACHE_GROUP_INFO structure that receives the requested information.
///    lpcbGroupInfo = Pointer to a variable that contains the size of the <i>lpGroupInfo</i> buffer. When the function returns, the
///                    variable contains the number of bytes copied to the buffer, or the required size of the buffer, in bytes.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL GetUrlCacheGroupAttributeA(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOA* lpGroupInfo, 
                                uint* lpcbGroupInfo, void* lpReserved);

///Retrieves the attribute information of the specified cache group.
///Params:
///    gid = Identifier of the cache group.
///    dwFlags = This parameter is reserved and must be 0.
///    dwAttributes = Attributes to be retrieved. This can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                   </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_BASIC</dt> </dl> </td> <td width="60%"> Retrieves the
///                   flags, type, and disk quota attributes of the cache group. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_ATTRIBUTE_FLAG</dt> </dl> </td> <td width="60%"> Sets or retrieves the flags associated with the
///                   cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_GET_ALL</dt> </dl> </td> <td
///                   width="60%"> Retrieves all the attributes of the cache group. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_ATTRIBUTE_GROUPNAME</dt> </dl> </td> <td width="60%"> Sets or retrieves the group name of the
///                   cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_QUOTA</dt> </dl> </td> <td
///                   width="60%"> Sets or retrieves the disk quota associated with the cache group. </td> </tr> <tr> <td width="40%">
///                   <dl> <dt>CACHEGROUP_ATTRIBUTE_STORAGE</dt> </dl> </td> <td width="60%"> Sets or retrieves the group owner storage
///                   associated with the cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_TYPE</dt> </dl>
///                   </td> <td width="60%"> Sets or retrieves the cache group type. </td> </tr> </table>
///    lpGroupInfo = Pointer to an INTERNET_CACHE_GROUP_INFO structure that receives the requested information.
///    lpcbGroupInfo = Pointer to a variable that contains the size of the <i>lpGroupInfo</i> buffer. When the function returns, the
///                    variable contains the number of bytes copied to the buffer, or the required size of the buffer, in bytes.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL GetUrlCacheGroupAttributeW(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOW* lpGroupInfo, 
                                uint* lpcbGroupInfo, void* lpReserved);

///Sets the attribute information of the specified cache group.
///Params:
///    gid = Identifier of the cache group.
///    dwFlags = This parameter is reserved and must be 0.
///    dwAttributes = Attributes to be set. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_FLAG</dt> </dl> </td> <td width="60%">
///                   Sets or retrieves the flags associated with the cache group. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_ATTRIBUTE_GROUPNAME</dt> </dl> </td> <td width="60%"> Sets or retrieves the group name of the
///                   cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_QUOTA</dt> </dl> </td> <td
///                   width="60%"> Sets or retrieves the disk quota associated with the cache group. </td> </tr> <tr> <td width="40%">
///                   <dl> <dt>CACHEGROUP_ATTRIBUTE_STORAGE</dt> </dl> </td> <td width="60%"> Sets or retrieves the group owner storage
///                   associated with the cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_TYPE</dt> </dl>
///                   </td> <td width="60%"> Sets or retrieves the cache group type. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_READWRITE_MASK</dt> </dl> </td> <td width="60%"> Sets the type, disk quota, group name, and owner
///                   storage attributes of the cache group. </td> </tr> </table>
///    lpGroupInfo = Pointer to an INTERNET_CACHE_GROUP_INFO structure that specifies the attribute information to be stored.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL SetUrlCacheGroupAttributeA(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOA* lpGroupInfo, 
                                void* lpReserved);

///Sets the attribute information of the specified cache group.
///Params:
///    gid = Identifier of the cache group.
///    dwFlags = This parameter is reserved and must be 0.
///    dwAttributes = Attributes to be set. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_FLAG</dt> </dl> </td> <td width="60%">
///                   Sets or retrieves the flags associated with the cache group. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_ATTRIBUTE_GROUPNAME</dt> </dl> </td> <td width="60%"> Sets or retrieves the group name of the
///                   cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_QUOTA</dt> </dl> </td> <td
///                   width="60%"> Sets or retrieves the disk quota associated with the cache group. </td> </tr> <tr> <td width="40%">
///                   <dl> <dt>CACHEGROUP_ATTRIBUTE_STORAGE</dt> </dl> </td> <td width="60%"> Sets or retrieves the group owner storage
///                   associated with the cache group. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHEGROUP_ATTRIBUTE_TYPE</dt> </dl>
///                   </td> <td width="60%"> Sets or retrieves the cache group type. </td> </tr> <tr> <td width="40%"> <dl>
///                   <dt>CACHEGROUP_READWRITE_MASK</dt> </dl> </td> <td width="60%"> Sets the type, disk quota, group name, and owner
///                   storage attributes of the cache group. </td> </tr> </table>
///    lpGroupInfo = Pointer to an INTERNET_CACHE_GROUP_INFO structure that specifies the attribute information to be stored.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL SetUrlCacheGroupAttributeW(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOW* lpGroupInfo, 
                                void* lpReserved);

///Retrieves information on the cache entry associated with the specified URL, taking into account any redirections that
///are applied in offline mode by the HttpSendRequest function.
///Params:
///    lpszUrl = A pointer to a <b>null</b>-terminated string that contains the name of the cache entry. The name string should
///              not contain any escape characters.
///    lpCacheEntryInfo = A pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry. A buffer
///                       should be allocated for this parameter. Since the required size of the buffer is not known in advance, it is best
///                       to allocate a buffer adequate to handle the size of most INTERNET_CACHE_ENTRY_INFO entries. There is no cache
///                       entry size limit, so applications that need to enumerate the cache must be prepared to allocate variable-sized
///                       buffers.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size of the <i>lpCacheEntryInfo</i> buffer, in bytes. When the function
///                         returns, the variable contains the number of bytes copied to the buffer, or the required size of the buffer in
///                         bytes.
///    lpszRedirectUrl = This parameter is reserved and must be <b>NULL</b>.
///    lpcbRedirectUrl = This parameter is reserved and must be <b>NULL</b>.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    dwFlags = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if the URL was located, or <b>FALSE</b> otherwise. Call GetLastError for specific error
///    information. Possible errors include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The URL was not
///    found in the cache index, even after taking any cached redirections into account. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer referenced by
///    <i>lpCacheEntryInfo</i> was not large enough to hold the requested information. The size of the buffer needed
///    will be returned to <i>lpdwCacheEntryInfoBufSize</i>. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL GetUrlCacheEntryInfoExA(const(PSTR) lpszUrl, INTERNET_CACHE_ENTRY_INFOA* lpCacheEntryInfo, 
                             uint* lpcbCacheEntryInfo, PSTR lpszRedirectUrl, uint* lpcbRedirectUrl, void* lpReserved, 
                             uint dwFlags);

///Retrieves information on the cache entry associated with the specified URL, taking into account any redirections that
///are applied in offline mode by the HttpSendRequest function.
///Params:
///    lpszUrl = A pointer to a <b>null</b>-terminated string that contains the name of the cache entry. The name string should
///              not contain any escape characters.
///    lpCacheEntryInfo = A pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry. A buffer
///                       should be allocated for this parameter. Since the required size of the buffer is not known in advance, it is best
///                       to allocate a buffer adequate to handle the size of most INTERNET_CACHE_ENTRY_INFO entries. There is no cache
///                       entry size limit, so applications that need to enumerate the cache must be prepared to allocate variable-sized
///                       buffers.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size of the <i>lpCacheEntryInfo</i> buffer, in bytes. When the function
///                         returns, the variable contains the number of bytes copied to the buffer, or the required size of the buffer in
///                         bytes.
///    lpszRedirectUrl = This parameter is reserved and must be <b>NULL</b>.
///    lpcbRedirectUrl = This parameter is reserved and must be <b>NULL</b>.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    dwFlags = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if the URL was located, or <b>FALSE</b> otherwise. Call GetLastError for specific error
///    information. Possible errors include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The URL was not
///    found in the cache index, even after taking any cached redirections into account. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer referenced by
///    <i>lpCacheEntryInfo</i> was not large enough to hold the requested information. The size of the buffer needed
///    will be returned to <i>lpdwCacheEntryInfoBufSize</i>. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL GetUrlCacheEntryInfoExW(const(PWSTR) lpszUrl, INTERNET_CACHE_ENTRY_INFOW* lpCacheEntryInfo, 
                             uint* lpcbCacheEntryInfo, PWSTR lpszRedirectUrl, uint* lpcbRedirectUrl, 
                             void* lpReserved, uint dwFlags);

///Sets the specified members of the INTERNET_CACHE_ENTRY_INFO structure.
///Params:
///    lpszUrlName = Pointer to a null-terminated string that specifies the name of the cache entry. The name string should not
///                  contain any escape characters.
///    lpCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure containing the values to be assigned to the cache entry
///                       designated by <i>lpszUrlName</i>.
///    dwFieldControl = Indicates the members that are to be set. This parameter can be a combination of the following values. <table>
///                     <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_ACCTIME_FC</dt> </dl> </td>
///                     <td width="60%"> Sets the last access time. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>CACHE_ENTRY_ATTRIBUTE_FC</dt> </dl> </td> <td width="60%"> Sets the cache entry type. </td> </tr> <tr> <td
///                     width="40%"> <dl> <dt>CACHE_ENTRY_EXEMPT_DELTA_FC</dt> </dl> </td> <td width="60%"> Sets the exempt delta. </td>
///                     </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_EXPTIME_FC</dt> </dl> </td> <td width="60%"> Sets the expire
///                     time. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_HEADERINFO_FC</dt> </dl> </td> <td width="60%"> Not
///                     currently implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_HITRATE_FC</dt> </dl> </td> <td
///                     width="60%"> Sets the hit rate. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_MODTIME_FC</dt> </dl>
///                     </td> <td width="60%"> Sets the last modified time. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>CACHE_ENTRY_SYNCTIME_FC</dt> </dl> </td> <td width="60%"> Sets the last sync time. </td> </tr> </table>
///Returns:
///    Returns TRUE if successful, or FALSE otherwise. To get extended error information, call GetLastError. Possible
///    error values include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified cache entry is
///    not found in the cache. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The value(s) to be set is invalid. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL SetUrlCacheEntryInfoA(const(PSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOA* lpCacheEntryInfo, 
                           uint dwFieldControl);

///Sets the specified members of the INTERNET_CACHE_ENTRY_INFO structure.
///Params:
///    lpszUrlName = Pointer to a null-terminated string that specifies the name of the cache entry. The name string should not
///                  contain any escape characters.
///    lpCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure containing the values to be assigned to the cache entry
///                       designated by <i>lpszUrlName</i>.
///    dwFieldControl = Indicates the members that are to be set. This parameter can be a combination of the following values. <table>
///                     <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_ACCTIME_FC</dt> </dl> </td>
///                     <td width="60%"> Sets the last access time. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>CACHE_ENTRY_ATTRIBUTE_FC</dt> </dl> </td> <td width="60%"> Sets the cache entry type. </td> </tr> <tr> <td
///                     width="40%"> <dl> <dt>CACHE_ENTRY_EXEMPT_DELTA_FC</dt> </dl> </td> <td width="60%"> Sets the exempt delta. </td>
///                     </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_EXPTIME_FC</dt> </dl> </td> <td width="60%"> Sets the expire
///                     time. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_HEADERINFO_FC</dt> </dl> </td> <td width="60%"> Not
///                     currently implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_HITRATE_FC</dt> </dl> </td> <td
///                     width="60%"> Sets the hit rate. </td> </tr> <tr> <td width="40%"> <dl> <dt>CACHE_ENTRY_MODTIME_FC</dt> </dl>
///                     </td> <td width="60%"> Sets the last modified time. </td> </tr> <tr> <td width="40%"> <dl>
///                     <dt>CACHE_ENTRY_SYNCTIME_FC</dt> </dl> </td> <td width="60%"> Sets the last sync time. </td> </tr> </table>
///Returns:
///    Returns TRUE if successful, or FALSE otherwise. To get extended error information, call GetLastError. Possible
///    error values include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified cache entry is
///    not found in the cache. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The value(s) to be set is invalid. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL SetUrlCacheEntryInfoW(const(PWSTR) lpszUrlName, INTERNET_CACHE_ENTRY_INFOW* lpCacheEntryInfo, 
                           uint dwFieldControl);

///Generates cache group identifications.
///Params:
///    dwFlags = Controls the creation of the cache group. This parameter can be set to CACHEGROUP_FLAG_GIDONLY, which causes
///              <b>CreateUrlCacheGroup</b> to generate a unique GROUPID, but does not create a physical group.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns a valid <b>GROUPID</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
long CreateUrlCacheGroup(uint dwFlags, void* lpReserved);

///Releases the specified <b>GROUPID</b> and any associated state in the cache index file.
///Params:
///    GroupId = ID of the cache group to be released.
///    dwFlags = Controls the cache group deletion. This can be set to any member of the cache group constants. When this
///              parameter is set to CACHEGROUP_FLAG_FLUSHURL_ONDELETE, it causes <b>DeleteUrlCacheGroup</b> to delete all of the
///              cache entries associated with this group, unless the entry belongs to another group.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL DeleteUrlCacheGroup(long GroupId, uint dwFlags, void* lpReserved);

///Adds entries to or removes entries from a cache group.
///Params:
///    lpszUrlName = Pointer to a <b>null</b>-terminated string value that specifies the URL of the cached resource.
///    dwFlags = Determines whether the entry is added to or removed from a cache group. This parameter can be one of the
///              following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_CACHE_GROUP_ADD</dt> </dl> </td> <td width="60%"> Adds the cache entry to the cache group. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_CACHE_GROUP_REMOVE</dt> </dl> </td> <td width="60%"> Removes the
///              entry from the cache group. </td> </tr> </table>
///    GroupId = Identifier of the cache group that the entry will be added to or removed from.
///    pbGroupAttributes = This parameter is reserved and must be <b>NULL</b>.
///    cbGroupAttributes = This parameter is reserved and must be 0.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL SetUrlCacheEntryGroupA(const(PSTR) lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, 
                            uint cbGroupAttributes, void* lpReserved);

///Adds entries to or removes entries from a cache group.
///Params:
///    lpszUrlName = Pointer to a <b>null</b>-terminated string value that specifies the URL of the cached resource.
///    dwFlags = Determines whether the entry is added to or removed from a cache group. This parameter can be one of the
///              following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_CACHE_GROUP_ADD</dt> </dl> </td> <td width="60%"> Adds the cache entry to the cache group. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_CACHE_GROUP_REMOVE</dt> </dl> </td> <td width="60%"> Removes the
///              entry from the cache group. </td> </tr> </table>
///    GroupId = Identifier of the cache group that the entry will be added to or removed from.
///    pbGroupAttributes = This parameter is reserved and must be <b>NULL</b>.
///    cbGroupAttributes = This parameter is reserved and must be 0.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL SetUrlCacheEntryGroupW(const(PWSTR) lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, 
                            uint cbGroupAttributes, void* lpReserved);

///Adds entries to or removes entries from a cache group.
///Params:
///    lpszUrlName = Pointer to a <b>null</b>-terminated string value that specifies the URL of the cached resource.
///    dwFlags = Determines whether the entry is added to or removed from a cache group. This parameter can be one of the
///              following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///              <dt>INTERNET_CACHE_GROUP_ADD</dt> </dl> </td> <td width="60%"> Adds the cache entry to the cache group. </td>
///              </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_CACHE_GROUP_REMOVE</dt> </dl> </td> <td width="60%"> Removes the
///              entry from the cache group. </td> </tr> </table>
///    GroupId = Identifier of the cache group that the entry will be added to or removed from.
///    pbGroupAttributes = This parameter is reserved and must be <b>NULL</b>.
///    cbGroupAttributes = This parameter is reserved and must be 0.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL SetUrlCacheEntryGroup(const(PSTR) lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, 
                           uint cbGroupAttributes, void* lpReserved);

///Starts a filtered enumeration of the Internet cache.
///Params:
///    lpszUrlSearchPattern = A pointer to a string that contains the source name pattern to search for. This parameter can only be set to
///                           "cookie:", "visited:", or NULL. Set this parameter to "cookie:" to enumerate the cookies or "visited:" to
///                           enumerate the URL History entries in the cache. If this parameter is NULL, <b>FindFirstUrlCacheEntryEx</b>
///                           returns all content entries in the cache.
///    dwFlags = Controls the enumeration. No flags are currently implemented; this parameter must be set to zero.
///    dwFilter = A bitmask indicating the type of cache entry and its properties. The cache entry types include: history entries
///               (URLHISTORY_CACHE_ENTRY), cookie entries (COOKIE_CACHE_ENTRY), and normal cached content (NORMAL_CACHE_ENTRY).
///               This parameter can be zero or more of the following property flags, and cache type flags listed below. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>COOKIE_CACHE_ENTRY</dt> </dl> </td> <td
///               width="60%"> Cookie cache entry. </td> </tr> <tr> <td width="40%"> <dl> <dt>EDITED_CACHE_ENTRY</dt> </dl> </td>
///               <td width="60%"> Cache entry file that has been edited externally. This cache entry type is exempt from
///               scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>NORMAL_CACHE_ENTRY</dt> </dl> </td> <td width="60%">
///               Normal cache entry; can be deleted to recover space for new entries. </td> </tr> <tr> <td width="40%"> <dl>
///               <dt>SPARSE_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Partial response cache entry. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>STICKY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Sticky cache entry; exempt from
///               scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_OFFLINE_CACHE_ENTRY</dt> </dl> </td> <td
///               width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_ONLINE_CACHE_ENTRY</dt>
///               </dl> </td> <td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl>
///               <dt>URLHISTORY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Visited link cache entry. </td> </tr> </table>
///    GroupId = ID of the cache group to be enumerated. Set this parameter to zero to enumerate all entries that are not grouped.
///    lpFirstCacheEntryInfo = Pointer to a INTERNET_CACHE_ENTRY_INFO structure to receive the cache entry information.
///    lpcbCacheEntryInfo = Pointer to variable that indicates the size of the structure referenced by the <i>lpFirstCacheEntryInfo</i>
///                         parameter, in bytes.
///    lpGroupAttributes = This parameter is reserved and must be NULL.
///    lpcbGroupAttributes = This parameter is reserved and must be NULL.
///    lpReserved = This parameter is reserved and must be NULL.
///Returns:
///    Returns a valid handle if successful, or NULL otherwise. To get specific error information, call GetLastError. If
///    the function finds no matching files, <b>GetLastError</b> returns ERROR_NO_MORE_FILES.
///    
@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryExA(const(PSTR) lpszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, 
                                 INTERNET_CACHE_ENTRY_INFOA* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                                 void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

///Starts a filtered enumeration of the Internet cache.
///Params:
///    lpszUrlSearchPattern = A pointer to a string that contains the source name pattern to search for. This parameter can only be set to
///                           "cookie:", "visited:", or NULL. Set this parameter to "cookie:" to enumerate the cookies or "visited:" to
///                           enumerate the URL History entries in the cache. If this parameter is NULL, <b>FindFirstUrlCacheEntryEx</b>
///                           returns all content entries in the cache.
///    dwFlags = Controls the enumeration. No flags are currently implemented; this parameter must be set to zero.
///    dwFilter = A bitmask indicating the type of cache entry and its properties. The cache entry types include: history entries
///               (URLHISTORY_CACHE_ENTRY), cookie entries (COOKIE_CACHE_ENTRY), and normal cached content (NORMAL_CACHE_ENTRY).
///               This parameter can be zero or more of the following property flags, and cache type flags listed below. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>COOKIE_CACHE_ENTRY</dt> </dl> </td> <td
///               width="60%"> Cookie cache entry. </td> </tr> <tr> <td width="40%"> <dl> <dt>EDITED_CACHE_ENTRY</dt> </dl> </td>
///               <td width="60%"> Cache entry file that has been edited externally. This cache entry type is exempt from
///               scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>NORMAL_CACHE_ENTRY</dt> </dl> </td> <td width="60%">
///               Normal cache entry; can be deleted to recover space for new entries. </td> </tr> <tr> <td width="40%"> <dl>
///               <dt>SPARSE_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Partial response cache entry. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>STICKY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Sticky cache entry; exempt from
///               scavenging. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_OFFLINE_CACHE_ENTRY</dt> </dl> </td> <td
///               width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt>TRACK_ONLINE_CACHE_ENTRY</dt>
///               </dl> </td> <td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"> <dl>
///               <dt>URLHISTORY_CACHE_ENTRY</dt> </dl> </td> <td width="60%"> Visited link cache entry. </td> </tr> </table>
///    GroupId = ID of the cache group to be enumerated. Set this parameter to zero to enumerate all entries that are not grouped.
///    lpFirstCacheEntryInfo = Pointer to a INTERNET_CACHE_ENTRY_INFO structure to receive the cache entry information.
///    lpcbCacheEntryInfo = Pointer to variable that indicates the size of the structure referenced by the <i>lpFirstCacheEntryInfo</i>
///                         parameter, in bytes.
///    lpGroupAttributes = This parameter is reserved and must be NULL.
///    lpcbGroupAttributes = This parameter is reserved and must be NULL.
///    lpReserved = This parameter is reserved and must be NULL.
///Returns:
///    Returns a valid handle if successful, or NULL otherwise. To get specific error information, call GetLastError. If
///    the function finds no matching files, <b>GetLastError</b> returns ERROR_NO_MORE_FILES.
///    
@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryExW(const(PWSTR) lpszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, 
                                 INTERNET_CACHE_ENTRY_INFOW* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                                 void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

///Finds the next cache entry in a cache enumeration started by the FindFirstUrlCacheEntryEx function.
///Params:
///    hEnumHandle = Handle returned by FindFirstUrlCacheEntryEx, which started a cache enumeration.
///    lpNextCacheEntryInfo = Pointer to the INTERNET_CACHE_ENTRY_INFO structure that receives the cache entry information.
///    lpcbCacheEntryInfo = Pointer to a variable that indicates the size of the buffer, in bytes.
///    lpGroupAttributes = This parameter is reserved and must be <b>NULL</b>.
///    lpcbGroupAttributes = This parameter is reserved and must be <b>NULL</b>.
///    lpReserved = This parameter is reserved.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL FindNextUrlCacheEntryExA(HANDLE hEnumHandle, INTERNET_CACHE_ENTRY_INFOA* lpNextCacheEntryInfo, 
                              uint* lpcbCacheEntryInfo, void* lpGroupAttributes, uint* lpcbGroupAttributes, 
                              void* lpReserved);

///Finds the next cache entry in a cache enumeration started by the FindFirstUrlCacheEntryEx function.
///Params:
///    hEnumHandle = Handle returned by FindFirstUrlCacheEntryEx, which started a cache enumeration.
///    lpNextCacheEntryInfo = Pointer to the INTERNET_CACHE_ENTRY_INFO structure that receives the cache entry information.
///    lpcbCacheEntryInfo = Pointer to a variable that indicates the size of the buffer, in bytes.
///    lpGroupAttributes = This parameter is reserved and must be <b>NULL</b>.
///    lpcbGroupAttributes = This parameter is reserved and must be <b>NULL</b>.
///    lpReserved = This parameter is reserved.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get specific error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL FindNextUrlCacheEntryExW(HANDLE hEnumHandle, INTERNET_CACHE_ENTRY_INFOW* lpNextCacheEntryInfo, 
                              uint* lpcbCacheEntryInfo, void* lpGroupAttributes, uint* lpcbGroupAttributes, 
                              void* lpReserved);

///Begins the enumeration of the Internet cache.
///Params:
///    lpszUrlSearchPattern = A pointer to a string that contains the source name pattern to search for. This parameter can only be set to
///                           "cookie:", "visited:", or <b>NULL</b>. Set this parameter to "cookie:" to enumerate the cookies or "visited:" to
///                           enumerate the URL History entries in the cache. If this parameter is <b>NULL</b>, <b>FindFirstUrlCacheEntry</b>
///                           returns all content entries in the cache.
///    lpFirstCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size of the <i>lpFirstCacheEntryInfo</i> buffer, in bytes. When the
///                         function returns, the variable contains the number of bytes copied to the buffer, or the required size needed to
///                         retrieve the cache entry, in bytes.
///Returns:
///    Returns a handle that the application can use in the FindNextUrlCacheEntry function to retrieve subsequent
///    entries in the cache. If the function fails, the return value is <b>NULL</b>. To get extended error information,
///    call GetLastError. ERROR_INSUFFICIENT_BUFFER indicates that the size of <i>lpFirstCacheEntryInfo</i> as specified
///    by <i>lpdwFirstCacheEntryInfoBufferSize</i> is not sufficient to contain all the information. The value returned
///    in <i>lpdwFirstCacheEntryInfoBufferSize</i> indicates the buffer size necessary to contain all the information.
///    
@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryA(const(PSTR) lpszUrlSearchPattern, INTERNET_CACHE_ENTRY_INFOA* lpFirstCacheEntryInfo, 
                               uint* lpcbCacheEntryInfo);

///Begins the enumeration of the Internet cache.
///Params:
///    lpszUrlSearchPattern = A pointer to a string that contains the source name pattern to search for. This parameter can only be set to
///                           "cookie:", "visited:", or <b>NULL</b>. Set this parameter to "cookie:" to enumerate the cookies or "visited:" to
///                           enumerate the URL History entries in the cache. If this parameter is <b>NULL</b>, <b>FindFirstUrlCacheEntry</b>
///                           returns all content entries in the cache.
///    lpFirstCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size of the <i>lpFirstCacheEntryInfo</i> buffer, in bytes. When the
///                         function returns, the variable contains the number of bytes copied to the buffer, or the required size needed to
///                         retrieve the cache entry, in bytes.
///Returns:
///    Returns a handle that the application can use in the FindNextUrlCacheEntry function to retrieve subsequent
///    entries in the cache. If the function fails, the return value is <b>NULL</b>. To get extended error information,
///    call GetLastError. ERROR_INSUFFICIENT_BUFFER indicates that the size of <i>lpFirstCacheEntryInfo</i> as specified
///    by <i>lpdwFirstCacheEntryInfoBufferSize</i> is not sufficient to contain all the information. The value returned
///    in <i>lpdwFirstCacheEntryInfoBufferSize</i> indicates the buffer size necessary to contain all the information.
///    
@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryW(const(PWSTR) lpszUrlSearchPattern, 
                               INTERNET_CACHE_ENTRY_INFOW* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo);

///Retrieves the next entry in the Internet cache.
///Params:
///    hEnumHandle = Handle to the enumeration obtained from a previous call to FindFirstUrlCacheEntry.
///    lpNextCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size of the <i>lpNextCacheEntryInfo</i> buffer, in bytes. When the
///                         function returns, the variable contains the number of bytes copied to the buffer, or the size of the buffer
///                         required to retrieve the cache entry, in bytes.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size
///    of <i>lpNextCacheEntryInfo</i> as specified by <i>lpdwNextCacheEntryInfoBufferSize</i> is not sufficient to
///    contain all the information. The value returned in <i>lpdwNextCacheEntryInfoBufferSize</i> indicates the buffer
///    size necessary to contain all the information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The enumeration completed. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL FindNextUrlCacheEntryA(HANDLE hEnumHandle, INTERNET_CACHE_ENTRY_INFOA* lpNextCacheEntryInfo, 
                            uint* lpcbCacheEntryInfo);

///Retrieves the next entry in the Internet cache.
///Params:
///    hEnumHandle = Handle to the enumeration obtained from a previous call to FindFirstUrlCacheEntry.
///    lpNextCacheEntryInfo = Pointer to an INTERNET_CACHE_ENTRY_INFO structure that receives information about the cache entry.
///    lpcbCacheEntryInfo = Pointer to a variable that specifies the size of the <i>lpNextCacheEntryInfo</i> buffer, in bytes. When the
///                         function returns, the variable contains the number of bytes copied to the buffer, or the size of the buffer
///                         required to retrieve the cache entry, in bytes.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size
///    of <i>lpNextCacheEntryInfo</i> as specified by <i>lpdwNextCacheEntryInfoBufferSize</i> is not sufficient to
///    contain all the information. The value returned in <i>lpdwNextCacheEntryInfoBufferSize</i> indicates the buffer
///    size necessary to contain all the information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The enumeration completed. </td> </tr> </table>
///    
@DllImport("WININET")
BOOL FindNextUrlCacheEntryW(HANDLE hEnumHandle, INTERNET_CACHE_ENTRY_INFOW* lpNextCacheEntryInfo, 
                            uint* lpcbCacheEntryInfo);

///Closes the specified cache enumeration handle.
///Params:
///    hEnumHandle = Handle returned by a previous call to the FindFirstUrlCacheEntry function.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL FindCloseUrlCache(HANDLE hEnumHandle);

///Removes the file associated with the source name from the cache, if the file exists.
///Params:
///    lpszUrlName = Pointer to a string that contains the name of the source that corresponds to the cache entry.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The file is
///    locked or in use. The entry is marked and deleted when the file is unlocked. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The file is not in the cache. </td> </tr>
///    </table>
///    
@DllImport("WININET")
BOOL DeleteUrlCacheEntryA(const(PSTR) lpszUrlName);

///Removes the file associated with the source name from the cache, if the file exists.
///Params:
///    lpszUrlName = Pointer to a string that contains the name of the source that corresponds to the cache entry.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The file is
///    locked or in use. The entry is marked and deleted when the file is unlocked. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The file is not in the cache. </td> </tr>
///    </table>
///    
@DllImport("WININET")
BOOL DeleteUrlCacheEntryW(const(PWSTR) lpszUrlName);

///Removes the file associated with the source name from the cache, if the file exists.
///Params:
///    lpszUrlName = Pointer to a string that contains the name of the source that corresponds to the cache entry.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError. Possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The file is
///    locked or in use. The entry is marked and deleted when the file is unlocked. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The file is not in the cache. </td> </tr>
///    </table>
///    
@DllImport("WININET")
BOOL DeleteUrlCacheEntry(const(PSTR) lpszUrlName);

///Initiates a connection to the Internet using a modem.
///Params:
///    hwndParent = Handle to the parent window.
///    lpszConnectoid = Pointer to a <b>null</b>-terminated string that specifies the name of the dial-up connection to be used. If this
///                     parameter contains the empty string (""), the user chooses the connection. If this parameter is <b>NULL</b>, the
///                     function connects to the autodial connection.
///    dwFlags = Options. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"> <dl> <dt>INTERNET_AUTODIAL_FORCE_ONLINE</dt> </dl> </td> <td width="60%"> Forces an online
///              connection. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_AUTODIAL_FORCE_UNATTENDED</dt> </dl> </td> <td
///              width="60%"> Forces an unattended Internet dial-up. If user intervention is required, the function will fail.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DIAL_FORCE_PROMPT</dt> </dl> </td> <td width="60%"> Ignores
///              the "dial automatically" setting and forces the dialing user interface to be displayed. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_DIAL_UNATTENDED</dt> </dl> </td> <td width="60%"> Connects to the Internet through
///              a modem, without displaying a user interface, if possible. Otherwise, the function will wait for user input.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DIAL_SHOW_OFFLINE</dt> </dl> </td> <td width="60%"> Shows the
///              <b>Work Offline</b> button instead of the <b>Cancel</b> button in the dialing user interface. </td> </tr>
///              </table>
///    lpdwConnection = Pointer to a variable that specifies the connection number. This number is a unique indentifier for the
///                     connection that can be used in other functions, such as InternetHangUp.
///    dwReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns ERROR_SUCCESS if successful, or an error value otherwise. The error code can be one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters are incorrect.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_CONNECTION</b></dt> </dl> </td> <td width="60%"> There is
///    a problem with the dial-up connection. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_USER_DISCONNECTION</b></dt> </dl> </td> <td width="60%"> The user clicked either the <b>Work
///    Offline</b> or <b>Cancel</b> button on the Internet connection dialog box. </td> </tr> </table>
///    
@DllImport("WININET")
uint InternetDialA(HWND hwndParent, PSTR lpszConnectoid, uint dwFlags, size_t* lpdwConnection, uint dwReserved);

///Initiates a connection to the Internet using a modem.
///Params:
///    hwndParent = Handle to the parent window.
///    lpszConnectoid = Pointer to a <b>null</b>-terminated string that specifies the name of the dial-up connection to be used. If this
///                     parameter contains the empty string (""), the user chooses the connection. If this parameter is <b>NULL</b>, the
///                     function connects to the autodial connection.
///    dwFlags = Options. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"> <dl> <dt>INTERNET_AUTODIAL_FORCE_ONLINE</dt> </dl> </td> <td width="60%"> Forces an online
///              connection. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_AUTODIAL_FORCE_UNATTENDED</dt> </dl> </td> <td
///              width="60%"> Forces an unattended Internet dial-up. If user intervention is required, the function will fail.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DIAL_FORCE_PROMPT</dt> </dl> </td> <td width="60%"> Ignores
///              the "dial automatically" setting and forces the dialing user interface to be displayed. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_DIAL_UNATTENDED</dt> </dl> </td> <td width="60%"> Connects to the Internet through
///              a modem, without displaying a user interface, if possible. Otherwise, the function will wait for user input.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DIAL_SHOW_OFFLINE</dt> </dl> </td> <td width="60%"> Shows the
///              <b>Work Offline</b> button instead of the <b>Cancel</b> button in the dialing user interface. </td> </tr>
///              </table>
///    lpdwConnection = Pointer to a variable that specifies the connection number. This number is a unique indentifier for the
///                     connection that can be used in other functions, such as InternetHangUp.
///    dwReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns ERROR_SUCCESS if successful, or an error value otherwise. The error code can be one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters are incorrect.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_CONNECTION</b></dt> </dl> </td> <td width="60%"> There is
///    a problem with the dial-up connection. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_USER_DISCONNECTION</b></dt> </dl> </td> <td width="60%"> The user clicked either the <b>Work
///    Offline</b> or <b>Cancel</b> button on the Internet connection dialog box. </td> </tr> </table>
///    
@DllImport("WININET")
uint InternetDialW(HWND hwndParent, PWSTR lpszConnectoid, uint dwFlags, size_t* lpdwConnection, uint dwReserved);

///Initiates a connection to the Internet using a modem.
///Params:
///    hwndParent = Handle to the parent window.
///    lpszConnectoid = Pointer to a <b>null</b>-terminated string that specifies the name of the dial-up connection to be used. If this
///                     parameter contains the empty string (""), the user chooses the connection. If this parameter is <b>NULL</b>, the
///                     function connects to the autodial connection.
///    dwFlags = Options. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"> <dl> <dt>INTERNET_AUTODIAL_FORCE_ONLINE</dt> </dl> </td> <td width="60%"> Forces an online
///              connection. </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_AUTODIAL_FORCE_UNATTENDED</dt> </dl> </td> <td
///              width="60%"> Forces an unattended Internet dial-up. If user intervention is required, the function will fail.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DIAL_FORCE_PROMPT</dt> </dl> </td> <td width="60%"> Ignores
///              the "dial automatically" setting and forces the dialing user interface to be displayed. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>INTERNET_DIAL_UNATTENDED</dt> </dl> </td> <td width="60%"> Connects to the Internet through
///              a modem, without displaying a user interface, if possible. Otherwise, the function will wait for user input.
///              </td> </tr> <tr> <td width="40%"> <dl> <dt>INTERNET_DIAL_SHOW_OFFLINE</dt> </dl> </td> <td width="60%"> Shows the
///              <b>Work Offline</b> button instead of the <b>Cancel</b> button in the dialing user interface. </td> </tr>
///              </table>
///    lpdwConnection = Pointer to a variable that specifies the connection number. This number is a unique indentifier for the
///                     connection that can be used in other functions, such as InternetHangUp.
///    dwReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns ERROR_SUCCESS if successful, or an error value otherwise. The error code can be one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters are incorrect.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_CONNECTION</b></dt> </dl> </td> <td width="60%"> There is
///    a problem with the dial-up connection. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_USER_DISCONNECTION</b></dt> </dl> </td> <td width="60%"> The user clicked either the <b>Work
///    Offline</b> or <b>Cancel</b> button on the Internet connection dialog box. </td> </tr> </table>
///    
@DllImport("WININET")
uint InternetDial(HWND hwndParent, PSTR lpszConnectoid, uint dwFlags, uint* lpdwConnection, uint dwReserved);

///Instructs the modem to disconnect from the Internet.
///Params:
///    dwConnection = Connection number of the connection to be disconnected.
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns ERROR_SUCCESS if successful, or an error value otherwise.
///    
@DllImport("WININET")
uint InternetHangUp(size_t dwConnection, uint dwReserved);

///Prompts the user for permission to initiate connection to a URL.
///Params:
///    lpszURL = Pointer to a null-terminated string that specifies the URL of the website for the connection.
///    hwndParent = Handle to the parent window.
///    dwFlags = This parameter can be zero or the following flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="INTERNET_GOONLINE_REFRESH"></a><a id="internet_goonline_refresh"></a><dl>
///              <dt><b>INTERNET_GOONLINE_REFRESH</b></dt> </dl> </td> <td width="60%"> This flag is not used. </td> </tr>
///              </table>
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. Applications
///    can call GetLastError to retrieve the error code. If the functions fails, it can return the following error code:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is incorrect.
///    The <i>dwFlags</i> parameter contains a value other than zero or <b>INTERNET_GOONLINE_REFRESH</b>. </td> </tr>
///    </table>
///    
@DllImport("WININET")
BOOL InternetGoOnlineA(const(PSTR) lpszURL, HWND hwndParent, uint dwFlags);

///Prompts the user for permission to initiate connection to a URL.
///Params:
///    lpszURL = Pointer to a null-terminated string that specifies the URL of the website for the connection.
///    hwndParent = Handle to the parent window.
///    dwFlags = This parameter can be zero or the following flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="INTERNET_GOONLINE_REFRESH"></a><a id="internet_goonline_refresh"></a><dl>
///              <dt><b>INTERNET_GOONLINE_REFRESH</b></dt> </dl> </td> <td width="60%"> This flag is not used. </td> </tr>
///              </table>
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. Applications
///    can call GetLastError to retrieve the error code. If the functions fails, it can return the following error code:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is incorrect.
///    The <i>dwFlags</i> parameter contains a value other than zero or <b>INTERNET_GOONLINE_REFRESH</b>. </td> </tr>
///    </table>
///    
@DllImport("WININET")
BOOL InternetGoOnlineW(const(PWSTR) lpszURL, HWND hwndParent, uint dwFlags);

///Prompts the user for permission to initiate connection to a URL.
///Params:
///    lpszURL = Pointer to a null-terminated string that specifies the URL of the website for the connection.
///    hwndParent = Handle to the parent window.
///    dwFlags = This parameter can be zero or the following flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="INTERNET_GOONLINE_REFRESH"></a><a id="internet_goonline_refresh"></a><dl>
///              <dt><b>INTERNET_GOONLINE_REFRESH</b></dt> </dl> </td> <td width="60%"> This flag is not used. </td> </tr>
///              </table>
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. Applications
///    can call GetLastError to retrieve the error code. If the functions fails, it can return the following error code:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is incorrect.
///    The <i>dwFlags</i> parameter contains a value other than zero or <b>INTERNET_GOONLINE_REFRESH</b>. </td> </tr>
///    </table>
///    
@DllImport("WININET")
BOOL InternetGoOnline(PSTR lpszURL, HWND hwndParent, uint dwFlags);

///Causes the modem to automatically dial the default Internet connection.
///Params:
///    dwFlags = Controls this operation. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_AUTODIAL_FAILIFSECURITYCHECK"></a><a
///              id="internet_autodial_failifsecuritycheck"></a><dl> <dt><b>INTERNET_AUTODIAL_FAILIFSECURITYCHECK</b></dt>
///              <dt>0x04</dt> </dl> </td> <td width="60%"> Causes <b>InternetAutodial</b> to fail if file and printer sharing is
///              disabled for Windows 95 or later. <b>Windows Server 2008 and Windows Vista: </b>This flag is obsolete. </td>
///              </tr> <tr> <td width="40%"><a id="INTERNET_AUTODIAL_FORCE_ONLINE"></a><a
///              id="internet_autodial_force_online"></a><dl> <dt><b>INTERNET_AUTODIAL_FORCE_ONLINE</b></dt> <dt> 0x01</dt> </dl>
///              </td> <td width="60%"> Forces an online Internet connection. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_AUTODIAL_FORCE_UNATTENDED"></a><a id="internet_autodial_force_unattended"></a><dl>
///              <dt><b>INTERNET_AUTODIAL_FORCE_UNATTENDED</b></dt> <dt> 0x02</dt> </dl> </td> <td width="60%"> Forces an
///              unattended Internet dial-up. </td> </tr> <tr> <td width="40%"><a
///              id="INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT"></a><a id="internet_autodial_override_net_present"></a><dl>
///              <dt><b>INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT</b></dt> <dt> 0x08</dt> </dl> </td> <td width="60%"> Causes
///              <b>InternetAutodial</b> to dial the modem connection even when a network connection to the Internet is present.
///              </td> </tr> </table>
///    hwndParent = Handle to the parent window.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. Applications
///    can call GetLastError to retrieve the error code.
///    
@DllImport("WININET")
BOOL InternetAutodial(uint dwFlags, HWND hwndParent);

///Disconnects an automatic dial-up connection.
///Params:
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. Applications
///    can call GetLastError to retrieve the error code.
///    
@DllImport("WININET")
BOOL InternetAutodialHangup(uint dwReserved);

///<div class="alert"><b>Note</b> Using this API is not recommended, use the INetworkListManager::GetConnectivity method
///instead.</div><div> </div>Retrieves the connected state of the local system.
///Params:
///    lpdwFlags = Pointer to a variable that receives the connection description. This parameter may return a valid flag even when
///                the function returns <b>FALSE</b>. This parameter can be one or more of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_CONFIGURED"></a><a
///                id="internet_connection_configured"></a><dl> <dt><b>INTERNET_CONNECTION_CONFIGURED</b></dt> <dt>0x40</dt> </dl>
///                </td> <td width="60%"> Local system has a valid connection to the Internet, but it might or might not be
///                currently connected. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_LAN_"></a><a
///                id="internet_connection_lan_"></a><dl> <dt><b>INTERNET_CONNECTION_LAN </b></dt> <dt>0x02</dt> </dl> </td> <td
///                width="60%"> Local system uses a local area network to connect to the Internet. </td> </tr> <tr> <td
///                width="40%"><a id="INTERNET_CONNECTION_MODEM"></a><a id="internet_connection_modem"></a><dl>
///                <dt><b>INTERNET_CONNECTION_MODEM</b></dt> <dt> 0x01</dt> </dl> </td> <td width="60%"> Local system uses a modem
///                to connect to the Internet. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_MODEM_BUSY"></a><a
///                id="internet_connection_modem_busy"></a><dl> <dt><b>INTERNET_CONNECTION_MODEM_BUSY</b></dt> <dt> 0x08</dt> </dl>
///                </td> <td width="60%"> No longer used. </td> </tr> <tr> <td width="40%"><a
///                id="INTERNET_CONNECTION_OFFLINE_"></a><a id="internet_connection_offline_"></a><dl>
///                <dt><b>INTERNET_CONNECTION_OFFLINE </b></dt> <dt>0x20</dt> </dl> </td> <td width="60%"> Local system is in
///                offline mode. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_PROXY"></a><a
///                id="internet_connection_proxy"></a><dl> <dt><b>INTERNET_CONNECTION_PROXY</b></dt> <dt> 0x04</dt> </dl> </td> <td
///                width="60%"> Local system uses a proxy server to connect to the Internet. </td> </tr> <tr> <td width="40%"><a
///                id="INTERNET_RAS_INSTALLED"></a><a id="internet_ras_installed"></a><dl> <dt><b>INTERNET_RAS_INSTALLED</b></dt>
///                <dt> 0x10</dt> </dl> </td> <td width="60%"> Local system has RAS installed. </td> </tr> </table>
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if there is an active modem or a LAN Internet connection, or <b>FALSE</b> if there is no
///    Internet connection, or if all possible Internet connections are not currently active. For more information, see
///    the Remarks section. When <b>InternetGetConnectedState</b> returns <b>FALSE</b>, the application can call
///    GetLastError to retrieve the error code.
///    
@DllImport("WININET")
BOOL InternetGetConnectedState(uint* lpdwFlags, uint dwReserved);

///<div class="alert"><b>Note</b> Using this API is not recommended, use the INetworkListManager::GetConnectivity method
///instead.</div><div> </div>Retrieves the connected state of the specified Internet connection.
///Params:
///    lpdwFlags = Pointer to a variable that receives the connection description. This parameter may return a valid flag even when
///                the function returns <b>FALSE</b>. This parameter can be a combination of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_CONFIGURED"></a><a
///                id="internet_connection_configured"></a><dl> <dt><b>INTERNET_CONNECTION_CONFIGURED</b></dt> <dt>0x40</dt> </dl>
///                </td> <td width="60%"> Local system has a valid connection to the Internet, but it might or might not be
///                currently connected. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_LAN_"></a><a
///                id="internet_connection_lan_"></a><dl> <dt><b>INTERNET_CONNECTION_LAN </b></dt> <dt>0x02</dt> </dl> </td> <td
///                width="60%"> Local system uses a local area network to connect to the Internet. </td> </tr> <tr> <td
///                width="40%"><a id="INTERNET_CONNECTION_MODEM"></a><a id="internet_connection_modem"></a><dl>
///                <dt><b>INTERNET_CONNECTION_MODEM</b></dt> <dt> 0x01</dt> </dl> </td> <td width="60%"> Local system uses a modem
///                to connect to the Internet. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_MODEM_BUSY"></a><a
///                id="internet_connection_modem_busy"></a><dl> <dt><b>INTERNET_CONNECTION_MODEM_BUSY</b></dt> <dt> 0x08</dt> </dl>
///                </td> <td width="60%"> No longer used. </td> </tr> <tr> <td width="40%"><a
///                id="INTERNET_CONNECTION_OFFLINE_"></a><a id="internet_connection_offline_"></a><dl>
///                <dt><b>INTERNET_CONNECTION_OFFLINE </b></dt> <dt>0x20</dt> </dl> </td> <td width="60%"> Local system is in
///                offline mode. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_PROXY"></a><a
///                id="internet_connection_proxy"></a><dl> <dt><b>INTERNET_CONNECTION_PROXY</b></dt> <dt> 0x04</dt> </dl> </td> <td
///                width="60%"> Local system uses a proxy server to connect to the Internet. </td> </tr> </table>
///    lpszConnectionName = Pointer to a string value that receives the connection name.
///    cchNameLen = TBD
///    dwReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if there is an Internet connection, or <b>FALSE</b> if there is no Internet connection, or if
///    all possible Internet connections are not currently active. For more information, see the Remarks section. When
///    InternetGetConnectedState returns <b>FALSE</b>, the application can call GetLastError to retrieve the error code.
///    
@DllImport("WININET")
BOOL InternetGetConnectedStateExA(uint* lpdwFlags, PSTR lpszConnectionName, uint cchNameLen, uint dwReserved);

///<div class="alert"><b>Note</b> Using this API is not recommended, use the INetworkListManager::GetConnectivity method
///instead.</div><div> </div>Retrieves the connected state of the specified Internet connection.
///Params:
///    lpdwFlags = Pointer to a variable that receives the connection description. This parameter may return a valid flag even when
///                the function returns <b>FALSE</b>. This parameter can be a combination of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_CONFIGURED"></a><a
///                id="internet_connection_configured"></a><dl> <dt><b>INTERNET_CONNECTION_CONFIGURED</b></dt> <dt>0x40</dt> </dl>
///                </td> <td width="60%"> Local system has a valid connection to the Internet, but it might or might not be
///                currently connected. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_LAN_"></a><a
///                id="internet_connection_lan_"></a><dl> <dt><b>INTERNET_CONNECTION_LAN </b></dt> <dt>0x02</dt> </dl> </td> <td
///                width="60%"> Local system uses a local area network to connect to the Internet. </td> </tr> <tr> <td
///                width="40%"><a id="INTERNET_CONNECTION_MODEM"></a><a id="internet_connection_modem"></a><dl>
///                <dt><b>INTERNET_CONNECTION_MODEM</b></dt> <dt> 0x01</dt> </dl> </td> <td width="60%"> Local system uses a modem
///                to connect to the Internet. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_MODEM_BUSY"></a><a
///                id="internet_connection_modem_busy"></a><dl> <dt><b>INTERNET_CONNECTION_MODEM_BUSY</b></dt> <dt> 0x08</dt> </dl>
///                </td> <td width="60%"> No longer used. </td> </tr> <tr> <td width="40%"><a
///                id="INTERNET_CONNECTION_OFFLINE_"></a><a id="internet_connection_offline_"></a><dl>
///                <dt><b>INTERNET_CONNECTION_OFFLINE </b></dt> <dt>0x20</dt> </dl> </td> <td width="60%"> Local system is in
///                offline mode. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_PROXY"></a><a
///                id="internet_connection_proxy"></a><dl> <dt><b>INTERNET_CONNECTION_PROXY</b></dt> <dt> 0x04</dt> </dl> </td> <td
///                width="60%"> Local system uses a proxy server to connect to the Internet. </td> </tr> </table>
///    lpszConnectionName = Pointer to a string value that receives the connection name.
///    cchNameLen = TBD
///    dwReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if there is an Internet connection, or <b>FALSE</b> if there is no Internet connection, or if
///    all possible Internet connections are not currently active. For more information, see the Remarks section. When
///    InternetGetConnectedState returns <b>FALSE</b>, the application can call GetLastError to retrieve the error code.
///    
@DllImport("WININET")
BOOL InternetGetConnectedStateExW(uint* lpdwFlags, PWSTR lpszConnectionName, uint cchNameLen, uint dwReserved);

@DllImport("WININET")
BOOL DeleteWpadCacheForNetworks(WPAD_CACHE_DELETE param0);

///There are two WinINet functions named <b>InternetInitializeAutoProxyDll</b>. The first, which merely refreshes the
///internal state of proxy configuration information from the registry, has a single parameter as documented directly
///below. The second function, prototyped as <b>pfnInternetInitializeAutoProxyDll</b>, is part of WinINet's limited
///autoproxy support, and must be called by dynamically linking to "JSProxy.dll". For autoproxy support, use Windows
///HTTP Services (WinHTTP) version 5.1. For more information, see WinHTTP AutoProxy Support.
///Params:
///    dwReserved = This parameter is reserved and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL InternetInitializeAutoProxyDll(uint dwReserved);

///Attempts to determine the location of a WPAD autoproxy script.
///Params:
///    pszAutoProxyUrl = Pointer to a buffer to receive the URL from which a WPAD autoproxy script can be downloaded.
///    cchAutoProxyUrl = Size of the buffer pointed to by <i>lpszAutoProxyUrl</i>, in bytes.
///    dwDetectFlags = Automation detection type. This parameter can be one or both of the following values. <table> <tr> <th>Value</th>
///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PROXY_AUTO_DETECT_TYPE_DHCP"></a><a
///                    id="proxy_auto_detect_type_dhcp"></a><dl> <dt><b>PROXY_AUTO_DETECT_TYPE_DHCP</b></dt> </dl> </td> <td
///                    width="60%"> Use a Dynamic Host Configuration Protocol (DHCP) search to identify the proxy. </td> </tr> <tr> <td
///                    width="40%"><a id="PROXY_AUTO_DETECT_TYPE_DNS_A"></a><a id="proxy_auto_detect_type_dns_a"></a><dl>
///                    <dt><b>PROXY_AUTO_DETECT_TYPE_DNS_A</b></dt> </dl> </td> <td width="60%"> Use a well qualified name search to
///                    identify the proxy. </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL DetectAutoProxyUrl(PSTR pszAutoProxyUrl, uint cchAutoProxyUrl, uint dwDetectFlags);

///The <b>CreateMD5SSOHash</b> function obtains the default Microsoft Passport password for a specified account or
///realm, creates an MD5 hash from it using a specified wide-character challenge string, and returns the result as a
///string of hexadecimal digit bytes.
///Params:
///    pszChallengeInfo = Pointer to the wide-character challenge string to use for the MD5 hash.
///    pwszRealm = Pointer to a string that names a realm for which to obtain the password. This parameter is ignored unless
///                <i>pwszTarget</i> is <b>NULL</b>. If both <i>pwszTarget</i> and <i>pwszRealm</i> are <b>NULL</b>, the default
///                realm is used.
///    pwszTarget = Pointer to a string that names an account for which to obtain the password. If <i>pwszTarget</i> is <b>NULL</b>,
///                 the realm indicated by <i>pwszRealm</i> is used.
///    pbHexHash = Pointer to an output buffer into which the MD5 hash is returned in hex string format. This buffer must be at
///                least 33 bytes long.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL CreateMD5SSOHash(PWSTR pszChallengeInfo, PWSTR pwszRealm, PWSTR pwszTarget, ubyte* pbHexHash);

///<div class="alert"><b>Note</b> Using this API is not recommended, use the INetworkListManager::GetConnectivity method
///instead.</div><div> </div>Retrieves the connected state of the specified Internet connection.
///Params:
///    lpdwFlags = Pointer to a variable that receives the connection description. This parameter may return a valid flag even when
///                the function returns <b>FALSE</b>. This parameter can be a combination of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_CONFIGURED"></a><a
///                id="internet_connection_configured"></a><dl> <dt><b>INTERNET_CONNECTION_CONFIGURED</b></dt> <dt>0x40</dt> </dl>
///                </td> <td width="60%"> Local system has a valid connection to the Internet, but it might or might not be
///                currently connected. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_LAN_"></a><a
///                id="internet_connection_lan_"></a><dl> <dt><b>INTERNET_CONNECTION_LAN </b></dt> <dt>0x02</dt> </dl> </td> <td
///                width="60%"> Local system uses a local area network to connect to the Internet. </td> </tr> <tr> <td
///                width="40%"><a id="INTERNET_CONNECTION_MODEM"></a><a id="internet_connection_modem"></a><dl>
///                <dt><b>INTERNET_CONNECTION_MODEM</b></dt> <dt> 0x01</dt> </dl> </td> <td width="60%"> Local system uses a modem
///                to connect to the Internet. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_MODEM_BUSY"></a><a
///                id="internet_connection_modem_busy"></a><dl> <dt><b>INTERNET_CONNECTION_MODEM_BUSY</b></dt> <dt> 0x08</dt> </dl>
///                </td> <td width="60%"> No longer used. </td> </tr> <tr> <td width="40%"><a
///                id="INTERNET_CONNECTION_OFFLINE_"></a><a id="internet_connection_offline_"></a><dl>
///                <dt><b>INTERNET_CONNECTION_OFFLINE </b></dt> <dt>0x20</dt> </dl> </td> <td width="60%"> Local system is in
///                offline mode. </td> </tr> <tr> <td width="40%"><a id="INTERNET_CONNECTION_PROXY"></a><a
///                id="internet_connection_proxy"></a><dl> <dt><b>INTERNET_CONNECTION_PROXY</b></dt> <dt> 0x04</dt> </dl> </td> <td
///                width="60%"> Local system uses a proxy server to connect to the Internet. </td> </tr> </table>
///    lpszConnectionName = Pointer to a string value that receives the connection name.
///    dwNameLen = Size of the <i>lpszConnectionName</i> string, in <b>TCHARs</b>.
///    dwReserved = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if there is an Internet connection, or <b>FALSE</b> if there is no Internet connection, or if
///    all possible Internet connections are not currently active. For more information, see the Remarks section. When
///    InternetGetConnectedState returns <b>FALSE</b>, the application can call GetLastError to retrieve the error code.
///    
@DllImport("WININET")
BOOL InternetGetConnectedStateEx(uint* lpdwFlags, PSTR lpszConnectionName, uint dwNameLen, uint dwReserved);

///Not supported. This function is obsolete. Do not use.
///Params:
///    lpszConnectoid = Unused.
///    dwState = Unused.
///    dwReserved = Unused.
///Returns:
///    This function does not return a value.
///    
@DllImport("WININET")
BOOL InternetSetDialStateA(const(PSTR) lpszConnectoid, uint dwState, uint dwReserved);

///Not supported. This function is obsolete. Do not use.
///Params:
///    lpszConnectoid = Unused.
///    dwState = Unused.
///    dwReserved = Unused.
///Returns:
///    This function does not return a value.
///    
@DllImport("WININET")
BOOL InternetSetDialStateW(const(PWSTR) lpszConnectoid, uint dwState, uint dwReserved);

///Not supported. This function is obsolete. Do not use.
///Params:
///    lpszConnectoid = Unused.
///    dwState = Unused.
///    dwReserved = Unused.
///Returns:
///    This function does not return a value.
///    
@DllImport("WININET")
BOOL InternetSetDialState(const(PSTR) lpszConnectoid, uint dwState, uint dwReserved);

///Sets a decision on cookies for a given domain.
///Params:
///    pchHostName = An <b>LPCTSTR</b> that points to a string containing a domain.
///    dwDecision = A value of type <b>DWORD</b> that contains one of the InternetCookieState enumeration values.
///Returns:
///    Returns <b>TRUE</b> if the decision is set and <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL InternetSetPerSiteCookieDecisionA(const(PSTR) pchHostName, uint dwDecision);

///Sets a decision on cookies for a given domain.
///Params:
///    pchHostName = An <b>LPCTSTR</b> that points to a string containing a domain.
///    dwDecision = A value of type <b>DWORD</b> that contains one of the InternetCookieState enumeration values.
///Returns:
///    Returns <b>TRUE</b> if the decision is set and <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL InternetSetPerSiteCookieDecisionW(const(PWSTR) pchHostName, uint dwDecision);

///Retrieves a decision on cookies for a given domain.
///Params:
///    pchHostName = An <b>LPCTSTR</b> that points to a string containing a domain.
///    pResult = A pointer to an <b>unsigned long</b> that contains one of the InternetCookieState enumeration values.
///Returns:
///    Returns <b>TRUE</b> if the decision was retrieved and <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL InternetGetPerSiteCookieDecisionA(const(PSTR) pchHostName, uint* pResult);

///Retrieves a decision on cookies for a given domain.
///Params:
///    pchHostName = An <b>LPCTSTR</b> that points to a string containing a domain.
///    pResult = A pointer to an <b>unsigned long</b> that contains one of the InternetCookieState enumeration values.
///Returns:
///    Returns <b>TRUE</b> if the decision was retrieved and <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL InternetGetPerSiteCookieDecisionW(const(PWSTR) pchHostName, uint* pResult);

///Clears all decisions that were made about cookies on a site by site basis.
///Returns:
///    Returns <b>TRUE</b> if all decisions were cleared and <b>FALSE</b> otherwise.
///    
@DllImport("WININET")
BOOL InternetClearAllPerSiteCookieDecisions();

///Retrieves the domains and cookie settings of websites for which site-specific cookie regulations are set.
///Params:
///    pszSiteName = An <b>LPSTR</b> that receives a string specifying a website domain.
///    pcSiteNameSize = A pointer to an unsigned long that specifies the size of the <i>pcSiteNameSize</i> parameter provided to the
///                     InternetEnumPerSiteCookieDecision function when it is called. When <b>InternetEnumPerSiteCookieDecision</b>
///                     returns, <i>pcSiteNameSize</i> receives the actual length of the domain string returned in <i>pszSiteName</i>.
///    pdwDecision = Pointer to an unsigned long that receives the InternetCookieState enumeration value corresponding to
///                  <i>pszSiteName</i>.
///    dwIndex = An unsigned long that specifies the index of the website and corresponding cookie setting to retrieve.
///Returns:
///    <b>TRUE</b> if the function retrieved the cookie setting for the given domain; otherwise, false. <b>FALSE</b>.
///    
@DllImport("WININET")
BOOL InternetEnumPerSiteCookieDecisionA(PSTR pszSiteName, uint* pcSiteNameSize, uint* pdwDecision, uint dwIndex);

///Retrieves the domains and cookie settings of websites for which site-specific cookie regulations are set.
///Params:
///    pszSiteName = An <b>LPSTR</b> that receives a string specifying a website domain.
///    pcSiteNameSize = A pointer to an unsigned long that specifies the size of the <i>pcSiteNameSize</i> parameter provided to the
///                     InternetEnumPerSiteCookieDecision function when it is called. When <b>InternetEnumPerSiteCookieDecision</b>
///                     returns, <i>pcSiteNameSize</i> receives the actual length of the domain string returned in <i>pszSiteName</i>.
///    pdwDecision = Pointer to an unsigned long that receives the InternetCookieState enumeration value corresponding to
///                  <i>pszSiteName</i>.
///    dwIndex = An unsigned long that specifies the index of the website and corresponding cookie setting to retrieve.
///Returns:
///    <b>TRUE</b> if the function retrieved the cookie setting for the given domain; otherwise, false. <b>FALSE</b>.
///    
@DllImport("WININET")
BOOL InternetEnumPerSiteCookieDecisionW(PWSTR pszSiteName, uint* pcSiteNameSize, uint* pdwDecision, uint dwIndex);

///Sets the privacy settings for a given URLZONE and PrivacyType.
///Params:
///    dwZone = Value of type <b>DWORD</b> that specifies the URLZONEfor which privacy settings are being set.
///    dwType = Value of type <b>DWORD</b> that specifies the PrivacyType for which privacy settings are being set.
///    dwTemplate = Value of type <b>DWORD</b> that specifies which of the privacy templates is to be used to set the privacy
///                 settings.
///    pszPreference = If <i>dwTemplate</i> is set to <b>PRIVACY_TEMPLATE_CUSTOM</b>, this parameter is the string representation of the
///                    custom preferences. Otherwise, it should be set to <b>NULL</b>. A description of this string representation is
///                    included in the Remarks section.
///Returns:
///    Returns zero if successful. Otherwise, one of the errors defined in winerr.h is returned.
///    
@DllImport("WININET")
uint PrivacySetZonePreferenceW(uint dwZone, uint dwType, uint dwTemplate, const(PWSTR) pszPreference);

///Retrieves the privacy settings for a given URLZONE and PrivacyType.
///Params:
///    dwZone = A value of type <i>DWORD</i> that specifies the URLZONE for which privacy settings are being retrieved.
///    dwType = A value of type <i>DWORD</i> that specifies the PrivacyType for which privacy settings are being retrieved.
///    pdwTemplate = An <b>LPDWORD</b> that returns a pointer to a <b>DWORD</b> containing which of the PrivacyTemplates is in use for
///                  this <i>dwZone</i> and <i>dwType</i>.
///    pszBuffer = An <b>LPWSTR</b> that points to a buffer containing a <b>LPCWSTR</b> representing a string version of the
///                <i>pdwTemplate</i> or a customized string if the <i>pdwTemplate</i> is set to <b>PRIVACY_TEMPLATE_CUSTOM</b>. See
///                PrivacySetZonePreferenceW for a description of a customized privacy preferences string.
///    pdwBufferLength = An <b>LPDWORD</b> that contains the buffer length in characters. If the buffer length is not sufficient,
///                      <b>PrivacyGetZonePreferenceW</b> returns with this parameter set to the number of characters required and with a
///                      return value of <b>ERROR_MORE_DATA</b>.
///Returns:
///    Returns zero if successful. Otherwise, one of the Error Messages defined in winerr.h is returned.
///    
@DllImport("WININET")
uint PrivacyGetZonePreferenceW(uint dwZone, uint dwType, uint* pdwTemplate, PWSTR pszBuffer, uint* pdwBufferLength);

@DllImport("WININET")
uint HttpIsHostHstsEnabled(const(PWSTR) pcwszUrl, BOOL* pfIsHsts);

@DllImport("WININET")
BOOL InternetAlgIdToStringA(uint ai, PSTR lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetAlgIdToStringW(uint ai, PWSTR lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetSecurityProtocolToStringA(uint dwProtocol, PSTR lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetSecurityProtocolToStringW(uint dwProtocol, PWSTR lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetGetSecurityInfoByURLA(PSTR lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET")
BOOL InternetGetSecurityInfoByURLW(const(PWSTR) lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET")
BOOL InternetGetSecurityInfoByURL(PSTR lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET")
uint ShowSecurityInfo(HWND hWndParent, INTERNET_SECURITY_INFO* pSecurityInfo);

@DllImport("WININET")
uint ShowX509EncodedCertificate(HWND hWndParent, ubyte* lpCert, uint cbCert);

@DllImport("WININET")
uint ShowClientAuthCerts(HWND hWndParent);

@DllImport("WININET")
uint ParseX509EncodedCertificateForListBoxEntry(ubyte* lpCert, uint cbCert, PSTR lpszListBoxEntry, 
                                                uint* lpdwListBoxEntry);

@DllImport("WININET")
BOOL InternetShowSecurityInfoByURLA(PSTR lpszURL, HWND hwndParent);

@DllImport("WININET")
BOOL InternetShowSecurityInfoByURLW(const(PWSTR) lpszURL, HWND hwndParent);

@DllImport("WININET")
BOOL InternetShowSecurityInfoByURL(PSTR lpszURL, HWND hwndParent);

@DllImport("WININET")
BOOL InternetFortezzaCommand(uint dwCommand, HWND hwnd, size_t dwReserved);

@DllImport("WININET")
BOOL InternetQueryFortezzaStatus(uint* pdwStatus, size_t dwReserved);

@DllImport("WININET")
BOOL InternetWriteFileExA(void* hFile, INTERNET_BUFFERSA* lpBuffersIn, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL InternetWriteFileExW(void* hFile, INTERNET_BUFFERSW* lpBuffersIn, uint dwFlags, size_t dwContext);

@DllImport("WININET")
int FindP3PPolicySymbol(const(byte)* pszSymbol);

@DllImport("WININET")
uint HttpGetServerCredentials(PWSTR pwszUrl, PWSTR* ppwszUserName, PWSTR* ppwszPassword);

@DllImport("WININET")
uint HttpPushEnable(void* hRequest, HTTP_PUSH_TRANSPORT_SETTING* pTransportSetting, 
                    HTTP_PUSH_WAIT_HANDLE__** phWait);

@DllImport("WININET")
uint HttpPushWait(HTTP_PUSH_WAIT_HANDLE__* hWait, HTTP_PUSH_WAIT_TYPE eType, 
                  HTTP_PUSH_NOTIFICATION_STATUS* pNotificationStatus);

@DllImport("WININET")
void HttpPushClose(HTTP_PUSH_WAIT_HANDLE__* hWait);

@DllImport("WININET")
BOOL HttpCheckDavComplianceA(const(PSTR) lpszUrl, const(PSTR) lpszComplianceToken, int* lpfFound, HWND hWnd, 
                             void* lpvReserved);

@DllImport("WININET")
BOOL HttpCheckDavComplianceW(const(PWSTR) lpszUrl, const(PWSTR) lpszComplianceToken, int* lpfFound, HWND hWnd, 
                             void* lpvReserved);

@DllImport("WININET")
BOOL IsUrlCacheEntryExpiredA(const(PSTR) lpszUrlName, uint dwFlags, FILETIME* pftLastModified);

@DllImport("WININET")
BOOL IsUrlCacheEntryExpiredW(const(PWSTR) lpszUrlName, uint dwFlags, FILETIME* pftLastModified);

@DllImport("WININET")
BOOL CreateUrlCacheEntryExW(const(PWSTR) lpszUrlName, uint dwExpectedFileSize, const(PWSTR) lpszFileExtension, 
                            PWSTR lpszFileName, uint dwReserved, BOOL fPreserveIncomingFileName);

@DllImport("WININET")
uint GetUrlCacheEntryBinaryBlob(const(PWSTR) pwszUrlName, uint* dwType, FILETIME* pftExpireTime, 
                                FILETIME* pftAccessTime, FILETIME* pftModifiedTime, ubyte** ppbBlob, uint* pcbBlob);

@DllImport("WININET")
uint CommitUrlCacheEntryBinaryBlob(const(PWSTR) pwszUrlName, uint dwType, FILETIME ftExpireTime, 
                                   FILETIME ftModifiedTime, const(ubyte)* pbBlob, uint cbBlob);

///Creates a cache container in the specified cache path to hold cache entries based on the specified name, cache
///prefix, and container type. <div class="alert"><b>Note</b> Note: This API is deprecated. Please use the Extensible
///Storage Engine instead.</div><div> </div>
///Params:
///    Name = The name to give to the cache.
///    lpCachePrefix = The cache prefix to base the cache on.
///    lpszCachePath = The cache prefix to create the cache in.
///    KBCacheLimit = The size limit of the cache in whole kilobytes, or 0 for the default size.
///    dwContainerType = The container type to base the cache on.
///    dwOptions = This parameter is reserved and must be 0.
///    pvBuffer = This parameter is reserved and must be <b>NULL</b>.
///    cbBuffer = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL CreateUrlCacheContainerA(const(PSTR) Name, const(PSTR) lpCachePrefix, const(PSTR) lpszCachePath, 
                              uint KBCacheLimit, uint dwContainerType, uint dwOptions, void* pvBuffer, 
                              uint* cbBuffer);

///Creates a cache container in the specified cache path to hold cache entries based on the specified name, cache
///prefix, and container type. <div class="alert"><b>Note</b> Note: This API is deprecated. Please use the Extensible
///Storage Engine instead.</div><div> </div>
///Params:
///    Name = The name to give to the cache.
///    lpCachePrefix = The cache prefix to base the cache on.
///    lpszCachePath = The cache prefix to create the cache in.
///    KBCacheLimit = The size limit of the cache in whole kilobytes, or 0 for the default size.
///    dwContainerType = The container type to base the cache on.
///    dwOptions = This parameter is reserved and must be 0.
///    pvBuffer = This parameter is reserved and must be <b>NULL</b>.
///    cbBuffer = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL CreateUrlCacheContainerW(const(PWSTR) Name, const(PWSTR) lpCachePrefix, const(PWSTR) lpszCachePath, 
                              uint KBCacheLimit, uint dwContainerType, uint dwOptions, void* pvBuffer, 
                              uint* cbBuffer);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Deletes a cache container (which contains cache entries) based on the specified name.<div
///class="alert"><b>Note</b> This API is deprecated. Please use the Extensible Storage Engine instead.</div> <div>
///</div>
///Params:
///    Name = The name of the cache container to be deleted.
///    dwOptions = This parameter is reserved, and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL DeleteUrlCacheContainerA(const(PSTR) Name, uint dwOptions);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Deletes a cache container (which contains cache entries) based on the specified name.<div
///class="alert"><b>Note</b> This API is deprecated. Please use the Extensible Storage Engine instead.</div> <div>
///</div>
///Params:
///    Name = The name of the cache container to be deleted.
///    dwOptions = This parameter is reserved, and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL DeleteUrlCacheContainerW(const(PWSTR) Name, uint dwOptions);

@DllImport("WININET")
HANDLE FindFirstUrlCacheContainerA(uint* pdwModified, INTERNET_CACHE_CONTAINER_INFOA* lpContainerInfo, 
                                   uint* lpcbContainerInfo, uint dwOptions);

@DllImport("WININET")
HANDLE FindFirstUrlCacheContainerW(uint* pdwModified, INTERNET_CACHE_CONTAINER_INFOW* lpContainerInfo, 
                                   uint* lpcbContainerInfo, uint dwOptions);

@DllImport("WININET")
BOOL FindNextUrlCacheContainerA(HANDLE hEnumHandle, INTERNET_CACHE_CONTAINER_INFOA* lpContainerInfo, 
                                uint* lpcbContainerInfo);

@DllImport("WININET")
BOOL FindNextUrlCacheContainerW(HANDLE hEnumHandle, INTERNET_CACHE_CONTAINER_INFOW* lpContainerInfo, 
                                uint* lpcbContainerInfo);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Frees space in the cache.<div class="alert"><b>Note</b> This API is deprecated. Please use the
///Extensible Storage Engine instead.</div> <div> </div>
///Params:
///    lpszCachePath = The path for the cache.
///    dwSize = The percentage of the cache to free (in the range 1 to 100, inclusive).
///    dwFilter = This parameter is reserved, and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL FreeUrlCacheSpaceA(const(PSTR) lpszCachePath, uint dwSize, uint dwFilter);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Frees space in the cache.<div class="alert"><b>Note</b> This API is deprecated. Please use the
///Extensible Storage Engine instead.</div> <div> </div>
///Params:
///    lpszCachePath = The path for the cache.
///    dwSize = The percentage of the cache to free (in the range 1 to 100, inclusive).
///    dwFilter = This parameter is reserved, and must be 0.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL FreeUrlCacheSpaceW(const(PWSTR) lpszCachePath, uint dwSize, uint dwFilter);

@DllImport("WININET")
uint UrlCacheFreeGlobalSpace(ulong ullTargetSize, uint dwFilter);

@DllImport("WININET")
uint UrlCacheGetGlobalCacheSize(uint dwFilter, ulong* pullSize, ulong* pullLimit);

///Retrieves information about cache configuration.
///Params:
///    lpCacheConfigInfo = A pointer to an INTERNET_CACHE_CONFIG_INFO structure that receives information about the cache configuration. The
///                        <b>dwStructSize</b> field of the structure should be initialized to the size of
///                        <b>INTERNET_CACHE_CONFIG_INFO</b>.
///    lpcbCacheConfigInfo = This parameter is reserved and must be <b>NULL</b>.
///    dwFieldControl = Determines the behavior of the function, as one of the following values. <table> <tr> <th>Value</th>
///                     <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CACHE_CONFIG_FORCE_CLEANUP_FC"></a><a
///                     id="cache_config_force_cleanup_fc"></a><dl> <dt><b>CACHE_CONFIG_FORCE_CLEANUP_FC</b></dt> <dt>0x00000020</dt>
///                     </dl> </td> <td width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a
///                     id="CACHE_CONFIG_DISK_CACHE_PATHS_FC"></a><a id="cache_config_disk_cache_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_DISK_CACHE_PATHS_FC</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Not used. </td>
///                     </tr> <tr> <td width="40%"><a id="CACHE_CONFIG_SYNC_MODE_FC"></a><a id="cache_config_sync_mode_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_SYNC_MODE_FC</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Reserved. </td> </tr>
///                     <tr> <td width="40%"><a id="CACHE_CONFIG_CONTENT_PATHS_FC"></a><a id="cache_config_content_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_CONTENT_PATHS_FC</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> The
///                     <b>CachePath</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     parameter is filled with a pointer to a string identifying the content path. This cannot be used at the same time
///                     as <b>CACHE_CONFIG_HISTORY_PATHS_FC</b> or <b>CACHE_CONFIG_COOKIES_PATHS_FC</b>. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_HISTORY_PATHS_FC"></a><a id="cache_config_history_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_HISTORY_PATHS_FC</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> The
///                     <b>CachePath</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     parameter is filled with a pointer to a string identifying the history path. This cannot be used at the same time
///                     as <b>CACHE_CONFIG_CONTENT_PATHS_FC</b> or <b>CACHE_CONFIG_COOKIES_PATHS_FC</b>. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_COOKIES_PATHS_FC"></a><a id="cache_config_cookies_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_COOKIES_PATHS_FC</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> The
///                     <b>CachePath</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     parameter is filled with a pointer to a string identifying the cookie path. This cannot be used at the same time
///                     as <b>CACHE_CONFIG_CONTENT_PATHS_FC</b> or <b>CACHE_CONFIG_HISTORY_PATHS_FC</b>. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_QUOTA_FC"></a><a id="cache_config_quota_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_QUOTA_FC</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> The <b>dwQuota</b> field
///                     of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i> is set to the cache limit
///                     for the container specified in the <b>dwContainer</b> field. </td> </tr> <tr> <td width="40%"><a
///                     id="CACHE_CONFIG_USER_MODE_FC"></a><a id="cache_config_user_mode_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_USER_MODE_FC</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> Reserved. </td> </tr>
///                     <tr> <td width="40%"><a id="CACHE_CONFIG_CONTENT_USAGE_FC"></a><a id="cache_config_content_usage_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_CONTENT_USAGE_FC</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> The
///                     <b>dwNormalUsage</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     is set to the cache size for the container specified in the <b>dwContainer</b> field. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_STICKY_CONTENT_USAGE_FC"></a><a
///                     id="cache_config_sticky_content_usage_fc"></a><dl> <dt><b>CACHE_CONFIG_STICKY_CONTENT_USAGE_FC</b></dt>
///                     <dt>0x00004000</dt> </dl> </td> <td width="60%"> The <b>dwExemptUsage</b> field of the INTERNET_CACHE_CONFIG_INFO
///                     structure specified in the <i>lpCachedConfigInfo</i> is set to the exempt usage, the amount of bytes exempt from
///                     scavenging, for the container specified in the <b>dwContainer</b> field. (This field must be the content
///                     container.) </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL GetUrlCacheConfigInfoA(INTERNET_CACHE_CONFIG_INFOA* lpCacheConfigInfo, uint* lpcbCacheConfigInfo, 
                            uint dwFieldControl);

///Retrieves information about cache configuration.
///Params:
///    lpCacheConfigInfo = A pointer to an INTERNET_CACHE_CONFIG_INFO structure that receives information about the cache configuration. The
///                        <b>dwStructSize</b> field of the structure should be initialized to the size of
///                        <b>INTERNET_CACHE_CONFIG_INFO</b>.
///    lpcbCacheConfigInfo = This parameter is reserved and must be <b>NULL</b>.
///    dwFieldControl = Determines the behavior of the function, as one of the following values. <table> <tr> <th>Value</th>
///                     <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CACHE_CONFIG_FORCE_CLEANUP_FC"></a><a
///                     id="cache_config_force_cleanup_fc"></a><dl> <dt><b>CACHE_CONFIG_FORCE_CLEANUP_FC</b></dt> <dt>0x00000020</dt>
///                     </dl> </td> <td width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a
///                     id="CACHE_CONFIG_DISK_CACHE_PATHS_FC"></a><a id="cache_config_disk_cache_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_DISK_CACHE_PATHS_FC</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Not used. </td>
///                     </tr> <tr> <td width="40%"><a id="CACHE_CONFIG_SYNC_MODE_FC"></a><a id="cache_config_sync_mode_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_SYNC_MODE_FC</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Reserved. </td> </tr>
///                     <tr> <td width="40%"><a id="CACHE_CONFIG_CONTENT_PATHS_FC"></a><a id="cache_config_content_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_CONTENT_PATHS_FC</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> The
///                     <b>CachePath</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     parameter is filled with a pointer to a string identifying the content path. This cannot be used at the same time
///                     as <b>CACHE_CONFIG_HISTORY_PATHS_FC</b> or <b>CACHE_CONFIG_COOKIES_PATHS_FC</b>. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_HISTORY_PATHS_FC"></a><a id="cache_config_history_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_HISTORY_PATHS_FC</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> The
///                     <b>CachePath</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     parameter is filled with a pointer to a string identifying the history path. This cannot be used at the same time
///                     as <b>CACHE_CONFIG_CONTENT_PATHS_FC</b> or <b>CACHE_CONFIG_COOKIES_PATHS_FC</b>. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_COOKIES_PATHS_FC"></a><a id="cache_config_cookies_paths_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_COOKIES_PATHS_FC</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> The
///                     <b>CachePath</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     parameter is filled with a pointer to a string identifying the cookie path. This cannot be used at the same time
///                     as <b>CACHE_CONFIG_CONTENT_PATHS_FC</b> or <b>CACHE_CONFIG_HISTORY_PATHS_FC</b>. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_QUOTA_FC"></a><a id="cache_config_quota_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_QUOTA_FC</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> The <b>dwQuota</b> field
///                     of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i> is set to the cache limit
///                     for the container specified in the <b>dwContainer</b> field. </td> </tr> <tr> <td width="40%"><a
///                     id="CACHE_CONFIG_USER_MODE_FC"></a><a id="cache_config_user_mode_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_USER_MODE_FC</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> Reserved. </td> </tr>
///                     <tr> <td width="40%"><a id="CACHE_CONFIG_CONTENT_USAGE_FC"></a><a id="cache_config_content_usage_fc"></a><dl>
///                     <dt><b>CACHE_CONFIG_CONTENT_USAGE_FC</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> The
///                     <b>dwNormalUsage</b> field of the INTERNET_CACHE_CONFIG_INFO structure specified in the <i>lpCachedConfigInfo</i>
///                     is set to the cache size for the container specified in the <b>dwContainer</b> field. </td> </tr> <tr> <td
///                     width="40%"><a id="CACHE_CONFIG_STICKY_CONTENT_USAGE_FC"></a><a
///                     id="cache_config_sticky_content_usage_fc"></a><dl> <dt><b>CACHE_CONFIG_STICKY_CONTENT_USAGE_FC</b></dt>
///                     <dt>0x00004000</dt> </dl> </td> <td width="60%"> The <b>dwExemptUsage</b> field of the INTERNET_CACHE_CONFIG_INFO
///                     structure specified in the <i>lpCachedConfigInfo</i> is set to the exempt usage, the amount of bytes exempt from
///                     scavenging, for the container specified in the <b>dwContainer</b> field. (This field must be the content
///                     container.) </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise. To get extended error information, call
///    GetLastError.
///    
@DllImport("WININET")
BOOL GetUrlCacheConfigInfoW(INTERNET_CACHE_CONFIG_INFOW* lpCacheConfigInfo, uint* lpcbCacheConfigInfo, 
                            uint dwFieldControl);

@DllImport("WININET")
BOOL SetUrlCacheConfigInfoA(INTERNET_CACHE_CONFIG_INFOA* lpCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET")
BOOL SetUrlCacheConfigInfoW(INTERNET_CACHE_CONFIG_INFOW* lpCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET")
uint RunOnceUrlCache(HWND hwnd, HINSTANCE hinst, PSTR lpszCmd, int nCmdShow);

@DllImport("WININET")
uint DeleteIE3Cache(HWND hwnd, HINSTANCE hinst, PSTR lpszCmd, int nCmdShow);

@DllImport("WININET")
BOOL UpdateUrlCacheContentPath(const(PSTR) szNewPath);

@DllImport("WININET")
BOOL RegisterUrlCacheNotification(HWND hWnd, uint uMsg, long gid, uint dwOpsFilter, uint dwReserved);

@DllImport("WININET")
BOOL GetUrlCacheHeaderData(uint nIdx, uint* lpdwData);

@DllImport("WININET")
BOOL SetUrlCacheHeaderData(uint nIdx, uint dwData);

@DllImport("WININET")
BOOL IncrementUrlCacheHeaderData(uint nIdx, uint* lpdwData);

@DllImport("WININET")
BOOL LoadUrlCacheContent();

@DllImport("WININET")
uint AppCacheLookup(const(PWSTR) pwszUrl, uint dwFlags, void** phAppCache);

@DllImport("WININET")
uint AppCacheCheckManifest(const(PWSTR) pwszMasterUrl, const(PWSTR) pwszManifestUrl, const(ubyte)* pbManifestData, 
                           uint dwManifestDataSize, const(ubyte)* pbManifestResponseHeaders, 
                           uint dwManifestResponseHeadersSize, APP_CACHE_STATE* peState, void** phNewAppCache);

@DllImport("WININET")
uint AppCacheGetDownloadList(void* hAppCache, APP_CACHE_DOWNLOAD_LIST* pDownloadList);

@DllImport("WININET")
void AppCacheFreeDownloadList(APP_CACHE_DOWNLOAD_LIST* pDownloadList);

@DllImport("WININET")
uint AppCacheFinalize(void* hAppCache, const(ubyte)* pbManifestData, uint dwManifestDataSize, 
                      APP_CACHE_FINALIZE_STATE* peState);

@DllImport("WININET")
uint AppCacheGetFallbackUrl(void* hAppCache, const(PWSTR) pwszUrl, PWSTR* ppwszFallbackUrl);

@DllImport("WININET")
uint AppCacheGetManifestUrl(void* hAppCache, PWSTR* ppwszManifestUrl);

@DllImport("WININET")
uint AppCacheDuplicateHandle(void* hAppCache, void** phDuplicatedAppCache);

@DllImport("WININET")
void AppCacheCloseHandle(void* hAppCache);

@DllImport("WININET")
void AppCacheFreeGroupList(APP_CACHE_GROUP_LIST* pAppCacheGroupList);

@DllImport("WININET")
uint AppCacheGetGroupList(APP_CACHE_GROUP_LIST* pAppCacheGroupList);

@DllImport("WININET")
uint AppCacheGetInfo(void* hAppCache, APP_CACHE_GROUP_INFO* pAppCacheInfo);

@DllImport("WININET")
uint AppCacheDeleteGroup(const(PWSTR) pwszManifestUrl);

@DllImport("WININET")
uint AppCacheFreeSpace(FILETIME ftCutOff);

@DllImport("WININET")
uint AppCacheGetIEGroupList(APP_CACHE_GROUP_LIST* pAppCacheGroupList);

@DllImport("WININET")
uint AppCacheDeleteIEGroup(const(PWSTR) pwszManifestUrl);

@DllImport("WININET")
uint AppCacheFreeIESpace(FILETIME ftCutOff);

@DllImport("WININET")
uint AppCacheCreateAndCommitFile(void* hAppCache, const(PWSTR) pwszSourceFilePath, const(PWSTR) pwszUrl, 
                                 const(ubyte)* pbResponseHeaders, uint dwResponseHeadersSize);

@DllImport("WININET")
uint HttpOpenDependencyHandle(void* hRequestHandle, BOOL fBackground, void** phDependencyHandle);

@DllImport("WININET")
void HttpCloseDependencyHandle(void* hDependencyHandle);

@DllImport("WININET")
uint HttpDuplicateDependencyHandle(void* hDependencyHandle, void** phDuplicatedDependencyHandle);

@DllImport("WININET")
uint HttpIndicatePageLoadComplete(void* hDependencyHandle);

@DllImport("WININET")
void UrlCacheFreeEntryInfo(URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET")
uint UrlCacheGetEntryInfo(void* hAppCache, const(PWSTR) pcwszUrl, URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET")
void UrlCacheCloseEntryHandle(void* hEntryFile);

@DllImport("WININET")
uint UrlCacheRetrieveEntryFile(void* hAppCache, const(PWSTR) pcwszUrl, URLCACHE_ENTRY_INFO* pCacheEntryInfo, 
                               void** phEntryFile);

@DllImport("WININET")
uint UrlCacheReadEntryStream(void* hUrlCacheStream, ulong ullLocation, void* pBuffer, uint dwBufferLen, 
                             uint* pdwBufferLen);

@DllImport("WININET")
uint UrlCacheRetrieveEntryStream(void* hAppCache, const(PWSTR) pcwszUrl, BOOL fRandomRead, 
                                 URLCACHE_ENTRY_INFO* pCacheEntryInfo, void** phEntryStream);

@DllImport("WININET")
uint UrlCacheUpdateEntryExtraData(void* hAppCache, const(PWSTR) pcwszUrl, const(ubyte)* pbExtraData, 
                                  uint cbExtraData);

@DllImport("WININET")
uint UrlCacheCreateContainer(const(PWSTR) pwszName, const(PWSTR) pwszPrefix, const(PWSTR) pwszDirectory, 
                             ulong ullLimit, uint dwOptions);

@DllImport("WININET")
uint UrlCacheCheckEntriesExist(PWSTR* rgpwszUrls, uint cEntries, BOOL* rgfExist);

@DllImport("WININET")
uint UrlCacheGetContentPaths(PWSTR** pppwszDirectories, uint* pcDirectories);

@DllImport("WININET")
uint UrlCacheGetGlobalLimit(URL_CACHE_LIMIT_TYPE limitType, ulong* pullLimit);

@DllImport("WININET")
uint UrlCacheSetGlobalLimit(URL_CACHE_LIMIT_TYPE limitType, ulong ullLimit);

@DllImport("WININET")
uint UrlCacheReloadSettings();

@DllImport("WININET")
uint UrlCacheContainerSetEntryMaximumAge(const(PWSTR) pwszPrefix, uint dwEntryMaxAge);

@DllImport("WININET")
uint UrlCacheFindFirstEntry(const(PWSTR) pwszPrefix, uint dwFlags, uint dwFilter, long GroupId, 
                            URLCACHE_ENTRY_INFO* pCacheEntryInfo, HANDLE* phFind);

@DllImport("WININET")
uint UrlCacheFindNextEntry(HANDLE hFind, URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET")
uint UrlCacheServer();

@DllImport("WININET")
BOOL ReadGuidsForConnectedNetworks(uint* pcNetworks, PWSTR** pppwszNetworkGuids, BSTR** pppbstrNetworkNames, 
                                   PWSTR** pppwszGWMacs, uint* pcGatewayMacs, uint* pdwFlags);

@DllImport("WININET")
BOOL IsHostInProxyBypassList(INTERNET_SCHEME tScheme, const(PSTR) lpszHost, uint cchHost);

@DllImport("WININET")
void InternetFreeProxyInfoList(WININET_PROXY_INFO_LIST* pProxyInfoList);

@DllImport("WININET")
uint InternetGetProxyForUrl(void* hInternet, const(PWSTR) pcwszUrl, WININET_PROXY_INFO_LIST* pProxyInfoList);

@DllImport("WININET")
BOOL DoConnectoidsExist();

@DllImport("WININET")
BOOL GetDiskInfoA(const(PSTR) pszPath, uint* pdwClusterSize, ulong* pdlAvail, ulong* pdlTotal);

@DllImport("WININET")
BOOL PerformOperationOverUrlCacheA(const(PSTR) pszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, 
                                   void* pReserved1, uint* pdwReserved2, void* pReserved3, CACHE_OPERATOR op, 
                                   void* pOperatorData);

@DllImport("WININET")
BOOL IsProfilesEnabled();

@DllImport("WININET")
uint InternalInternetGetCookie(const(PSTR) lpszUrl, PSTR lpszCookieData, uint* lpdwDataSize);

@DllImport("WININET")
BOOL ImportCookieFileA(const(PSTR) szFilename);

@DllImport("WININET")
BOOL ImportCookieFileW(const(PWSTR) szFilename);

@DllImport("WININET")
BOOL ExportCookieFileA(const(PSTR) szFilename, BOOL fAppend);

@DllImport("WININET")
BOOL ExportCookieFileW(const(PWSTR) szFilename, BOOL fAppend);

@DllImport("WININET")
BOOL IsDomainLegalCookieDomainA(const(PSTR) pchDomain, const(PSTR) pchFullDomain);

@DllImport("WININET")
BOOL IsDomainLegalCookieDomainW(const(PWSTR) pchDomain, const(PWSTR) pchFullDomain);

@DllImport("WININET")
void* HttpWebSocketCompleteUpgrade(void* hRequest, size_t dwContext);

@DllImport("WININET")
BOOL HttpWebSocketSend(void* hWebSocket, HTTP_WEB_SOCKET_BUFFER_TYPE BufferType, void* pvBuffer, 
                       uint dwBufferLength);

@DllImport("WININET")
BOOL HttpWebSocketReceive(void* hWebSocket, void* pvBuffer, uint dwBufferLength, uint* pdwBytesRead, 
                          HTTP_WEB_SOCKET_BUFFER_TYPE* pBufferType);

@DllImport("WININET")
BOOL HttpWebSocketClose(void* hWebSocket, ushort usStatus, void* pvReason, uint dwReasonLength);

@DllImport("WININET")
BOOL HttpWebSocketShutdown(void* hWebSocket, ushort usStatus, void* pvReason, uint dwReasonLength);

@DllImport("WININET")
BOOL HttpWebSocketQueryCloseStatus(void* hWebSocket, ushort* pusStatus, void* pvReason, uint dwReasonLength, 
                                   uint* pdwReasonLengthConsumed);

@DllImport("WININET")
uint InternetConvertUrlFromWireToWideChar(const(PSTR) pcszUrl, uint cchUrl, const(PWSTR) pcwszBaseUrl, 
                                          uint dwCodePageHost, uint dwCodePagePath, BOOL fEncodePathExtra, 
                                          uint dwCodePageExtra, PWSTR* ppwszConvertedUrl);


// Interfaces

@GUID("A9927F85-A304-4390-8B23-A75F1C668600")
struct ProofOfPossessionCookieInfoManager;

@GUID("2D86F4FF-6E2D-4488-B2E9-6934AFD41BEA")
interface IDialEventSink : IUnknown
{
    HRESULT OnEvent(uint dwEvent, uint dwStatus);
}

@GUID("39FD782B-7905-40D5-9148-3C9B190423D5")
interface IDialEngine : IUnknown
{
    HRESULT Initialize(const(PWSTR) pwzConnectoid, IDialEventSink pIDES);
    HRESULT GetProperty(const(PWSTR) pwzProperty, PWSTR pwzValue, uint dwBufSize);
    HRESULT SetProperty(const(PWSTR) pwzProperty, const(PWSTR) pwzValue);
    HRESULT Dial();
    HRESULT HangUp();
    HRESULT GetConnectedState(uint* pdwState);
    HRESULT GetConnectHandle(size_t* pdwHandle);
}

@GUID("8AECAFA9-4306-43CC-8C5A-765F2979CC16")
interface IDialBranding : IUnknown
{
    HRESULT Initialize(const(PWSTR) pwzConnectoid);
    HRESULT GetBitmap(uint dwIndex, HBITMAP* phBitmap);
}

///Supports the creation of proof of possession cookies.
@GUID("CDAECE56-4EDF-43DF-B113-88E4556FA1BB")
interface IProofOfPossessionCookieInfoManager : IUnknown
{
    ///Gets cookie information for the supplied URI to be used for proof of possession cookies.
    ///Params:
    ///    uri = The URI to get cookie information for. The URI is case-sensitive.
    ///    cookieInfoCount = The number of cookies found for the <i>uri</i>.
    ///    cookieInfo = The cookie information for the <i>uri</i>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCookieInfoForUri(const(PWSTR) uri, uint* cookieInfoCount, ProofOfPossessionCookieInfo** cookieInfo);
}

@GUID("15E41407-B42F-4AE7-9966-34A087B2D713")
interface IProofOfPossessionCookieInfoManager2 : IUnknown
{
    HRESULT GetCookieInfoWithUriForAccount(IInspectable webAccount, const(PWSTR) uri, uint* cookieInfoCount, 
                                           ProofOfPossessionCookieInfo** cookieInfo);
}


// GUIDs

const GUID CLSID_ProofOfPossessionCookieInfoManager = GUIDOF!ProofOfPossessionCookieInfoManager;

const GUID IID_IDialBranding                        = GUIDOF!IDialBranding;
const GUID IID_IDialEngine                          = GUIDOF!IDialEngine;
const GUID IID_IDialEventSink                       = GUIDOF!IDialEventSink;
const GUID IID_IProofOfPossessionCookieInfoManager  = GUIDOF!IProofOfPossessionCookieInfoManager;
const GUID IID_IProofOfPossessionCookieInfoManager2 = GUIDOF!IProofOfPossessionCookieInfoManager2;
