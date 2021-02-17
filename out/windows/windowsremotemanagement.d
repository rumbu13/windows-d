// Written in the D programming language.

module windows.windowsremotemanagement;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


///Specifies the current data type of the union in the WSMAN_DATA structure.
enum WSManDataType : int
{
    ///The structure is not valid yet.
    WSMAN_DATA_NONE        = 0x00000000,
    ///The structure contains text.
    WSMAN_DATA_TYPE_TEXT   = 0x00000001,
    ///The structure contains binary data.
    WSMAN_DATA_TYPE_BINARY = 0x00000002,
    WSMAN_DATA_TYPE_DWORD  = 0x00000004,
}

///Determines the authentication method for the operation.
enum WSManAuthenticationFlags : int
{
    ///Use the default authentication.
    WSMAN_FLAG_DEFAULT_AUTHENTICATION  = 0x00000000,
    ///Use no authentication for a remote operation.
    WSMAN_FLAG_NO_AUTHENTICATION       = 0x00000001,
    ///Use Digest authentication. Only the client computer can initiate a Digest authentication request. The client
    ///sends a request to the server to authenticate and receives from the server a token string. The client then sends
    ///the resource request, including the user name and a cryptographic hash of the password combined with the token
    ///string. Digest authentication is supported for HTTP and HTTPS. WinRM Shell client scripts and applications can
    ///specify Digest authentication, but the service cannot.
    WSMAN_FLAG_AUTH_DIGEST             = 0x00000002,
    ///Use Negotiate authentication. The client sends a request to the server to authenticate. The server determines
    ///whether to use Kerberos or NTLM. In general, Kerberos is selected to authenticate a domain account and NTLM is
    ///selected for local computer accounts. But there are also some special cases in which Kerberos/NTLM are selected.
    ///The user name should be specified in the form DOMAIN\username for a domain user or SERVERNAME\username for a
    ///local user on a server computer.
    WSMAN_FLAG_AUTH_NEGOTIATE          = 0x00000004,
    ///Use Basic authentication. The client presents credentials in the form of a user name and password that are
    ///directly transmitted in the request message. You can specify the credentials only of a local administrator
    ///account on the remote computer.
    WSMAN_FLAG_AUTH_BASIC              = 0x00000008,
    ///Use Kerberos authentication. The client and server mutually authenticate by using Kerberos certificates.
    WSMAN_FLAG_AUTH_KERBEROS           = 0x00000010,
    ///Use CredSSP authentication for a remote operation. If a certificate from the local machine is used to
    ///authenticate the server, the Network service must be allowed access to the private key of the certificate.
    WSMAN_FLAG_AUTH_CREDSSP            = 0x00000080,
    WSMAN_FLAG_AUTH_CLIENT_CERTIFICATE = 0x00000020,
}

///Defines the proxy access type.
enum WSManProxyAccessType : int
{
    ///Use the Internet Explorer proxy configuration for the current user. This is the default setting.
    WSMAN_OPTION_PROXY_IE_PROXY_CONFIG      = 0x00000001,
    ///Use the proxy settings configured for WinHTTP.
    WSMAN_OPTION_PROXY_WINHTTP_PROXY_CONFIG = 0x00000002,
    ///Force autodetection of a proxy.
    WSMAN_OPTION_PROXY_AUTO_DETECT          = 0x00000004,
    ///Do not use a proxy server. All host names are resolved locally.
    WSMAN_OPTION_PROXY_NO_PROXY_SERVER      = 0x00000008,
}

///Defines a set of extended options for the session. These options are used with the WSManSetSessionOption method.
enum WSManSessionOption : int
{
    ///Default time-out in milliseconds that applies to all operations on the client side.
    WSMAN_OPTION_DEFAULT_OPERATION_TIMEOUTMS          = 0x00000001,
    WSMAN_OPTION_MAX_RETRY_TIME                       = 0x0000000b,
    ///Time-out in milliseconds for WSManCreateShell operations.
    WSMAN_OPTION_TIMEOUTMS_CREATE_SHELL               = 0x0000000c,
    ///Time-out in milliseconds for WSManRunShellCommand operations.
    WSMAN_OPTION_TIMEOUTMS_RUN_SHELL_COMMAND          = 0x0000000d,
    ///Time-out in milliseconds for WSManReceiveShellOutput operations.
    WSMAN_OPTION_TIMEOUTMS_RECEIVE_SHELL_OUTPUT       = 0x0000000e,
    ///Time-out in milliseconds for WSManSendShellInput operations.
    WSMAN_OPTION_TIMEOUTMS_SEND_SHELL_INPUT           = 0x0000000f,
    ///Time-out in milliseconds for WSManSignalShell and WSManCloseCommand operations.
    WSMAN_OPTION_TIMEOUTMS_SIGNAL_SHELL               = 0x00000010,
    ///Time-out in milliseconds for WSManCloseShell operations connection options.
    WSMAN_OPTION_TIMEOUTMS_CLOSE_SHELL                = 0x00000011,
    ///Set to 1 to not validate the CA on the server certificate. The default is 0.
    WSMAN_OPTION_SKIP_CA_CHECK                        = 0x00000012,
    ///Set to 1 to not validate the CN on the server certificate. The default is 0.
    WSMAN_OPTION_SKIP_CN_CHECK                        = 0x00000013,
    ///Set to 1 to not encrypt messages. The default is 0.
    WSMAN_OPTION_UNENCRYPTED_MESSAGES                 = 0x00000014,
    ///Set to 1 to send all network packets for remote operations in UTF16. Default of 0 causes network packets to be
    ///sent in UTF8.
    WSMAN_OPTION_UTF16                                = 0x00000015,
    ///Set to 1 when using Negotiate authentication and the port number is included in the connection. Default is 0.
    WSMAN_OPTION_ENABLE_SPN_SERVER_PORT               = 0x00000016,
    ///Set to 1 to identify this machine to the server by including the MachineID. The default is 0.
    WSMAN_OPTION_MACHINE_ID                           = 0x00000017,
    ///The language locale options. For more information about the language locales, see the RFC 3066 specification from
    ///the Internet Engineering Task Force at http://www.ietf.org/rfc/rfc3066.txt.
    WSMAN_OPTION_LOCALE                               = 0x00000019,
    ///The UI language options. The UI language options are defined in RFC 3066 format. For more information about the
    ///UI language options, see the RFC 3066 specification from the Internet Engineering Task Force at
    ///http://www.ietf.org/rfc/rfc3066.txt.
    WSMAN_OPTION_UI_LANGUAGE                          = 0x0000001a,
    ///The maximum Simple Object Access Protocol (SOAP) envelope size. The default is 150 KB.
    WSMAN_OPTION_MAX_ENVELOPE_SIZE_KB                 = 0x0000001c,
    ///The maximum size of the data that is provided by the client.
    WSMAN_OPTION_SHELL_MAX_DATA_SIZE_PER_MESSAGE_KB   = 0x0000001d,
    ///The redirect location. <div class="alert"><b>Note</b> It is recommended that all redirection use Secure Sockets
    ///Layer (SSL) and that all applications validate the redirected URI before creating a new session.</div> <div>
    ///</div>
    WSMAN_OPTION_REDIRECT_LOCATION                    = 0x0000001e,
    ///Set to 1 to not validate the revocation status on the server certificate. The default is 0.
    WSMAN_OPTION_SKIP_REVOCATION_CHECK                = 0x0000001f,
    ///Set to 1 to allow default credentials for Negotiate. The default is 0.
    WSMAN_OPTION_ALLOW_NEGOTIATE_IMPLICIT_CREDENTIALS = 0x00000020,
    WSMAN_OPTION_USE_SSL                              = 0x00000021,
    WSMAN_OPTION_USE_INTEARACTIVE_TOKEN               = 0x00000022,
}

///Defines a set of flags used by all callback functions.
enum WSManCallbackFlags : int
{
    ///Indicates the end of a single step of a multi-step operation. This flag is used for optimization purposes if the
    ///shell cannot be determined.
    WSMAN_FLAG_CALLBACK_END_OF_OPERATION                       = 0x00000001,
    ///Indicates the end of a particular stream. This flag is used for optimization purposes if an indication has been
    ///provided to the shell that no more output will occur for this stream.
    WSMAN_FLAG_CALLBACK_END_OF_STREAM                          = 0x00000008,
    WSMAN_FLAG_CALLBACK_SHELL_SUPPORTS_DISCONNECT              = 0x00000020,
    WSMAN_FLAG_CALLBACK_SHELL_AUTODISCONNECTED                 = 0x00000040,
    WSMAN_FLAG_CALLBACK_NETWORK_FAILURE_DETECTED               = 0x00000100,
    WSMAN_FLAG_CALLBACK_RETRYING_AFTER_NETWORK_FAILURE         = 0x00000200,
    WSMAN_FLAG_CALLBACK_RECONNECTED_AFTER_NETWORK_FAILURE      = 0x00000400,
    WSMAN_FLAG_CALLBACK_SHELL_AUTODISCONNECTING                = 0x00000800,
    WSMAN_FLAG_CALLBACK_RETRY_ABORTED_DUE_TO_INTERNAL_ERROR    = 0x00001000,
    WSMAN_FLAG_CALLBACK_RECEIVE_DELAY_STREAM_REQUEST_PROCESSED = 0x00002000,
}

enum WSManShellFlag : int
{
    WSMAN_FLAG_NO_COMPRESSION              = 0x00000001,
    WSMAN_FLAG_DELETE_SERVER_SESSION       = 0x00000002,
    WSMAN_FLAG_SERVER_BUFFERING_MODE_DROP  = 0x00000004,
    WSMAN_FLAG_SERVER_BUFFERING_MODE_BLOCK = 0x00000008,
    WSMAN_FLAG_RECEIVE_DELAY_OUTPUT_STREAM = 0x00000010,
}

enum WSManSessionFlags : int
{
    WSManFlagUTF8                              = 0x00000001,
    WSManFlagCredUsernamePassword              = 0x00001000,
    WSManFlagSkipCACheck                       = 0x00002000,
    WSManFlagSkipCNCheck                       = 0x00004000,
    WSManFlagUseNoAuthentication               = 0x00008000,
    WSManFlagUseDigest                         = 0x00010000,
    WSManFlagUseNegotiate                      = 0x00020000,
    WSManFlagUseBasic                          = 0x00040000,
    WSManFlagUseKerberos                       = 0x00080000,
    WSManFlagNoEncryption                      = 0x00100000,
    WSManFlagUseClientCertificate              = 0x00200000,
    WSManFlagEnableSPNServerPort               = 0x00400000,
    WSManFlagUTF16                             = 0x00800000,
    WSManFlagUseCredSsp                        = 0x01000000,
    WSManFlagSkipRevocationCheck               = 0x02000000,
    WSManFlagAllowNegotiateImplicitCredentials = 0x04000000,
    WSManFlagUseSsl                            = 0x08000000,
}

enum WSManEnumFlags : int
{
    WSManFlagNonXmlText                 = 0x00000001,
    WSManFlagReturnObject               = 0x00000000,
    WSManFlagReturnEPR                  = 0x00000002,
    WSManFlagReturnObjectAndEPR         = 0x00000004,
    WSManFlagHierarchyDeep              = 0x00000000,
    WSManFlagHierarchyShallow           = 0x00000020,
    WSManFlagHierarchyDeepBasePropsOnly = 0x00000040,
    WSManFlagAssociatedInstance         = 0x00000000,
    WSManFlagAssociationInstance        = 0x00000080,
}

///Defines the proxy access type flags.
enum WSManProxyAccessTypeFlags : int
{
    ///Use the Internet Explorer proxy configuration for the current user.
    WSManProxyIEConfig      = 0x00000001,
    ///Use the proxy settings configured for WinHTTP. This is the default setting.
    WSManProxyWinHttpConfig = 0x00000002,
    ///Force autodetection of a proxy.
    WSManProxyAutoDetect    = 0x00000004,
    WSManProxyNoProxyServer = 0x00000008,
}

///Determines the proxy authentication mechanism.
enum WSManProxyAuthenticationFlags : int
{
    ///Use Negotiate authentication. The client sends a request to the server to authenticate. The server determines
    ///whether to use Kerberos or NTLM. In general, Kerberos is selected to authenticate a domain account and NTLM is
    ///selected for local computer accounts. But there are also some special cases in which Kerberos/NTLM are selected.
    ///The user name should be specified in the form DOMAIN\username for a domain user or SERVERNAME\username for a
    ///local user on a server computer.
    WSManFlagProxyAuthenticationUseNegotiate = 0x00000001,
    ///Use Basic authentication. The client presents credentials in the form of a user name and password that are
    ///directly transmitted in the request message.
    WSManFlagProxyAuthenticationUseBasic     = 0x00000002,
    WSManFlagProxyAuthenticationUseDigest    = 0x00000004,
}

// Callbacks

///The callback function that is called for shell operations, which result in a remote request.
///Params:
///    operationContext = Represents user-defined context passed to the WinRM (WinRM) Client Shell application programming interface (API)
///                       .
///    flags = Specifies one or more flags from the WSManCallbackFlags enumeration.
///    error = Defines the WSMAN_ERROR structure, which is valid in the callback only.
///    shell = Specifies the shell handle associated with the user context. The shell handle must be closed by calling the
///            WSManCloseShell method.
///    command = Specifies the command handle associated with the user context. The command handle must be closed by calling the
///              WSManCloseCommand API method.
///    operationHandle = Defines the operation handle associated with the user context. The operation handle is valid only for callbacks
///                      that are associated with WSManReceiveShellOutput, WSManSendShellInput, and WSManSignalShell calls. This handle
///                      must be closed by calling the WSManCloseOperation method.
alias WSMAN_SHELL_COMPLETION_FUNCTION = void function(void* operationContext, uint flags, WSMAN_ERROR* error, 
                                                      WSMAN_SHELL* shell, WSMAN_COMMAND* command, 
                                                      WSMAN_OPERATION* operationHandle, WSMAN_RESPONSE_DATA* data);
///Defines the release shell callback for the plug-in. This function is called to delete the plug-in shell context. The
///DLL entry point name must be WSManPluginReleaseCommandContext.
alias WSMAN_PLUGIN_RELEASE_SHELL_CONTEXT = void function(void* shellContext);
///Defines the release command callback for the plug-in. This function is called to delete the plug-in command context.
///The DLL entry point name must be <b>WSManPluginReleaseCommandContext</b>.
///Params:
///    shellContext = Specifies the context that was received when the shell was created.
alias WSMAN_PLUGIN_RELEASE_COMMAND_CONTEXT = void function(void* shellContext, void* commandContext);
///Defines the startup callback for the plug-in. Because multiple applications can be hosted in the same process, this
///method can be called multiple times, but only once for each application initialization. A plug-in can be initialized
///more than once within the same process but only once for each <i>applicationIdentification</i> value. The context
///that is returned from this method should be application specific. The returned context will be passed into all future
///plug-in calls that are specific to the application. All Windows Remote Management (WinRM) plug-ins must implement
///this callback function. The DLL entry point name for this method must be <b>WSManPluginStartup</b>.
///Params:
///    flags = Reserved for future use. Must be zero.
///    applicationIdentification = A unique identifier for the hosted application. For the main WinRM service, the default is <b>wsman</b>. For an
///                                Internet Information Services (IIS) host, this identifier is related to the application endpoint for that host.
///                                For example, <b>wsman/MyCompany/MyApplication</b>.
///    extraInfo = A string that contains configuration information, if any information was stored when the plug-in was registered.
///                When the plug-in is registered using the WinRM configuration, the plug-in can add extra configuration parameters
///                that are useful during initialization to an optional node. This information can be especially useful if a plug-in
///                is used in different IIS hosting scenarios and requires slightly different run-time semantics during
///                initialization. This string is a copy of the XML from the configuration, if one is present. Otherwise, this
///                parameter is set to <b>NULL</b>.
///    pluginContext = The context for the specific application initialization. This context is passed through to all other WinRM
///                    plug-in calls that are associated with this <i>applicationIdentifier</i>.
alias WSMAN_PLUGIN_STARTUP = uint function(uint flags, const(wchar)* applicationIdentification, 
                                           const(wchar)* extraInfo, void** pluginContext);
///Defines the shutdown callback for the plug-in. This function is called after all operations have been canceled and
///before the Windows Remote Management plug-in DLL is unloaded. All WinRM plug-ins must implement this callback
///function. The DLL entry point name must be <b>WSManPluginShutdown</b>.
///Params:
///    pluginContext = Specifies the context that was returned by a call to the WSManPluginStartup method. This parameter represents a
///                    specific application initialization of a WinRM plug-in. The shutdown entry point will be called for each
///                    application that initialized it.
///    flags = Reserved for future use. Must be set to zero.
///    reason = Specifies the reason that the plug-in is shutting down.
///Returns:
///    The method returns <b>NO_ERROR</b> if it succeeded; otherwise, it returns an error code. <div
///    class="alert"><b>Note</b> If this method fails, the plug-in will not call back in.</div> <div> </div>
///    
alias WSMAN_PLUGIN_SHUTDOWN = uint function(void* pluginContext, uint flags, uint reason);
///Defines the shell callback for a plug-in. This function is called when a request for a new shell is received. All
///Windows Remote Management plug-ins that support shell operations need to implement this callback. The DLL entry point
///name must be <b>WSManPluginShell</b>.
///Params:
///    pluginContext = Specifies the context that was returned by a call to the WSManPluginStartup method. This parameter represents a
///                    specific application initialization of a WinRM plug-in.
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be set to zero.
///    startupInfo = A pointer to a WSMAN_SHELL_STARTUP_INFO structure that contains startup information for the shell.
///    inboundShellInformation = A pointer to a WSMAN_DATA structure that specifies an optional inbound object that contains extra data for the
///                              shell.
alias WSMAN_PLUGIN_SHELL = void function(void* pluginContext, WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, 
                                         WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, 
                                         WSMAN_DATA* inboundShellInformation);
///Defines the command callback for a plug-in. This function is called when a request for a command is received. All
///Windows Remote Management plug-ins that support shell operations and need to create commands must implement this
///callback. The DLL entry point name must be <b>WSManPluginCommand</b>.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be set to zero.
///    shellContext = Specifies the context returned from creating the shell for which this command needs to be associated.
///    commandLine = Specifies the command line to be run.
///    arguments = A pointer to a WSMAN_COMMAND_ARG_SET structure that specifies the command-line arguments to be passed to the
///                command.
alias WSMAN_PLUGIN_COMMAND = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                           const(wchar)* commandLine, WSMAN_COMMAND_ARG_SET* arguments);
///Defines the send callback for a plug-in. This function is called for each object that is received from a client. Each
///object received causes the callback to be called once. After the data is processed, the Windows Remote Management
///(WinRM) plug-in calls WSManPluginOperationComplete to acknowledge receipt and to allow the next object to be
///delivered. The DLL entry point name must be <b>WSManPluginSend</b>.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = If this is the last object for the stream, this parameter is set to <b>WSMAN_FLAG_NO_MORE_DATA</b>. Otherwise, it
///            is set to zero.
///    shellContext = Specifies the context that was received when the shell was created.
///    commandContext = If this request is aimed at a command and not a shell, this is the context returned from the <b>winrm create</b>
///                     operation; otherwise, this parameter is <b>NULL</b>.
///    stream = Specifies the stream that is associated with the inbound object.
alias WSMAN_PLUGIN_SEND = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                        void* commandContext, const(wchar)* stream, WSMAN_DATA* inboundData);
///Defines the receive callback for a plug-in. This function is called when an inbound request to receive data is
///received. The DLL entry point name must be <b>WSManPluginReceive</b>.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be zero.
///    shellContext = Specifies the context that was received when the shell was created.
///    commandContext = If this request is aimed at a command and not a shell, this is the context returned from the <b>winrm create</b>
///                     operation; otherwise, this parameter is <b>NULL</b>.
///    streamSet = A WSMAN_STREAM_ID_SET structure that contains a list of streams for which data is to be received. If this list is
///                empty, all streams that were configured in the shell are implied, which means that all streams are available.
alias WSMAN_PLUGIN_RECEIVE = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                           void* commandContext, WSMAN_STREAM_ID_SET* streamSet);
///Defines the signal callback for a plug-in. This function is called when an inbound signal is received from a client
///call. The DLL entry point name for this method must be <b>WSManPluginSignal</b>.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be zero.
///    shellContext = Specifies the context that was received when the shell was created.
///    commandContext = If this request is aimed at a command and not a shell, this is the context returned from the <b>winrm create</b>
///                     operation; otherwise, this parameter is <b>NULL</b>.
///    code = Specifies the signal that is received from the client. The following codes are common.
alias WSMAN_PLUGIN_SIGNAL = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                          void* commandContext, const(wchar)* code);
///Defines the connect callback for a plug-in. The DLL entry point name must be <b>WSManPluginConnect</b>.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be set to zero.
///    shellContext = Specifies the context returned from creating the shell for which this connection request needs to be associated.
///    commandContext = If this request is aimed at a command and not a shell, this is the context returned from the <b>winrm create</b>
///                     operation; otherwise, this parameter is <b>NULL</b>.
alias WSMAN_PLUGIN_CONNECT = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                           void* commandContext, WSMAN_DATA* inboundConnectInformation);
///Authorizes a connection. The plug-in should verify that this user is allowed to perform any operations. If the user
///is allowed to perform operations, the plug-in must report a success. If the user is not allowed to carry out any type
///of operation, a failure must be returned. Every new connection does not need to be authorized. After a user has been
///authorized to connect, a user record is created to track the activities of the user. While that record exists, all
///new connections will automatically be authorized. The user record will time-out after a configurable amount of time
///after no activity is detected. The DLL entry point name for this method must be <b>WSManPluginAuthzUser</b>.
///Params:
///    pluginContext = Specifies the context that was returned by a call to WSManPluginStartup. This parameter represents a specific
///                    application initialization of a WinRM plug-in.
///    senderDetails = A pointer to the WSMAN_SENDER_DETAILS structure that specifies the identification information of the user to be
///                    authorized.
///    flags = Reserved for future use. Must be set to zero.
alias WSMAN_PLUGIN_AUTHORIZE_USER = void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, 
                                                  uint flags);
///Authorizes a specific operation. The DLL entry point name for this method must be <b>WSManPluginAuthzOperation</b>.
///Params:
///    pluginContext = Specifies the context that was returned by a call to WSManPluginStartup. This parameter represents a specific
///                    application initialization of a WinRM plug-in.
///    senderDetails = A pointer to the WSMAN_SENDER_DETAILS structure that specifies the identification information of the user.
///    flags = Reserved for future use. Must be set to zero.
///    operation = Represents the operation that is being performed. This parameter can be one of the following values:
///    action = Specifies the action of the request received. This parameter can be one of the following values:
///    resourceUri = Specifies the resource URI of the inbound operation.
alias WSMAN_PLUGIN_AUTHORIZE_OPERATION = void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, 
                                                       uint flags, uint operation, const(wchar)* action, 
                                                       const(wchar)* resourceUri);
///Retrieves quota information for the user after a connection has been authorized. This method will be called only if
///the configuration specifies that quotas are enabled within the authorization plug-in. The DLL entry point name for
///this method must be <b>WSManPluginAuthzQueryQuota</b>.
///Params:
///    pluginContext = Specifies the context that was returned by a call to WSManPluginStartup. This parameter represents a specific
///                    application initialization of a WinRM plug-in.
///    senderDetails = A pointer to the WSMAN_SENDER_DETAILS structure that specifies the identification information of the user.
///    flags = Reserved for future use. Must be zero.
alias WSMAN_PLUGIN_AUTHORIZE_QUERY_QUOTA = void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, 
                                                         uint flags);
///Releases the context that a plug-in reports from either WSManPluginAuthzUserComplete or
///WSManPluginAuthzOperationComplete. For a particular user, the context reported for both calls is allowed to be the
///same, as long as the plug-in infrastructure handles the scenario appropriately. This method is synchronous, and there
///are no callbacks that are called as a result. This method will be called under the following scenarios: <ul>
///<li>After the operation is complete, the WSManPluginAuthzOperationComplete context is released. For some operations,
///such as get, the context will be released after the response is sent for the get operation. For more complex
///operations, such as enumeration, the context will not be released until the enumeration has completed.</li> <li>When
///the user record times out due to inactivity, the WSManPluginAuthzUser method will be called again the next time a
///request comes in for that user.</li> <li>If re-authorization needs to occur, the old context will be released after
///the new one is acquired. The old context will always be released regardless of whether the authorization
///succeeds.</li> </ul>The DLL entry point name for this method must be <b>WSManPluginAuthzReleaseContext</b>.
alias WSMAN_PLUGIN_AUTHORIZE_RELEASE_CONTEXT = void function(void* userAuthorizationContext);

// Structs


///A WSMAN_DATA structure component that holds textual data for use with various Windows Remote Management functions.
struct WSMAN_DATA_TEXT
{
    ///Specifies the number of UNICODE characters stored in the buffer.
    uint          bufferLength;
    const(wchar)* buffer;
}

///A WSMAN_DATA structure component that holds binary data for use with various Windows Remote Management functions.
struct WSMAN_DATA_BINARY
{
    ///Represents the number of BYTEs stored in the data field.
    uint   dataLength;
    ubyte* data;
}

///Contains inbound and outbound data used in the Windows Remote Management (WinRM) API.
struct WSMAN_DATA
{
    ///Specifies the type of data currently stored in the union.
    WSManDataType type;
    union
    {
        WSMAN_DATA_TEXT   text;
        WSMAN_DATA_BINARY binaryData;
        uint              number;
    }
}

///Contains error information that is returned by a Windows Remote Management (WinRM) client. The WSMAN_ERROR structure
///is used by all callbacks to return error information and is valid only for the callback.
struct WSMAN_ERROR
{
    ///Specifies an error code. This error can be a general error code that is defined in winerror.h or a WinRM-specific
    ///error code.
    uint          code;
    ///Specifies extended error information that relates to a failed call. This field contains the fault detail text if
    ///it is present in the fault. If there is no fault detail, this field contains the fault reason text. This field
    ///can be set to <b>NULL</b>.
    const(wchar)* errorDetail;
    ///Specifies the language for the error description. This field can be set to <b>NULL</b>. For more information
    ///about the language format, see the RFC 3066 specification from the Internet Engineering Task Force at
    ///http://www.ietf.org/rfc/rfc3066.txt.
    const(wchar)* language;
    ///Specifies the name of the computer. This field can be set to <b>NULL</b>.
    const(wchar)* machineName;
    const(wchar)* pluginName;
}

///Defines the credentials used for authentication.
struct WSMAN_USERNAME_PASSWORD_CREDS
{
    ///Defines the user name for a local or domain account. It cannot be <b>NULL</b>.
    const(wchar)* username;
    ///Defines the password for a local or domain account. It cannot be <b>NULL</b>.
    const(wchar)* password;
}

///Defines the authentication method and the credentials used for server or proxy authentication.
struct WSMAN_AUTHENTICATION_CREDENTIALS
{
    ///Defines the authentication mechanism. This member can be set to zero. If it is set to zero, the WinRM client will
    ///choose between Kerberos and Negotiate. If it is not set to zero, this member must be one of the values of the
    ///WSManAuthenticationFlags enumeration.
    uint authenticationMechanism;
    union
    {
        WSMAN_USERNAME_PASSWORD_CREDS userAccount;
        const(wchar)* certificateThumbprint;
    }
}

///Represents a specific option name and value pair. An option that is not understood and has a <b>mustComply</b> value
///of <b>TRUE</b> should result in the plug-in operation failing the request with an error.
struct WSMAN_OPTION
{
    ///Specifies the name of the option.
    const(wchar)* name;
    ///Specifies the value of the option.
    const(wchar)* value;
    BOOL          mustComply;
}

///Represents a set of options. Additionally, this structure defines a flag that specifies whether all options must be
///understood.
struct WSMAN_OPTION_SET
{
    ///Specifies the number of options in the <b>options</b> array.
    uint          optionsCount;
    ///Specifies an array of option names and values
    WSMAN_OPTION* options;
    BOOL          optionsMustUnderstand;
}

struct WSMAN_OPTION_SETEX
{
    uint          optionsCount;
    WSMAN_OPTION* options;
    BOOL          optionsMustUnderstand;
    ushort**      optionTypes;
}

///Represents a key and value pair within a selector set and is used to identify a particular resource.
struct WSMAN_KEY
{
    ///Specifies the key name.
    const(wchar)* key;
    const(wchar)* value;
}

///Defines a set of keys that represent the identity of a resource.
struct WSMAN_SELECTOR_SET
{
    ///Specifies the number of keys (selectors).
    uint       numberKeys;
    WSMAN_KEY* keys;
}

///<p class="CCE_Message">[<b>WSMAN_FRAGMENT</b> is reserved for future use.] Defines the fragment information for an
///operation. Currently, this structure is reserved for future use.
struct WSMAN_FRAGMENT
{
    ///Reserved for future use. This parameter must be <b>NULL</b>.
    const(wchar)* path;
    const(wchar)* dialect;
}

///<p class="CCE_Message">[<b>WSMAN_FILTER</b> is reserved for future use.] Defines the filtering that is used for an
///operation.
struct WSMAN_FILTER
{
    ///Reserved for future use. This parameter must be <b>NULL</b>.
    const(wchar)* filter;
    const(wchar)* dialect;
}

///Represents a specific resource endpoint for which the plug-in must perform the request.
struct WSMAN_OPERATION_INFO
{
    ///A WSMAN_FRAGMENT structure that specifies the subset of data to be used for the operation. This parameter is
    ///reserved for future use and is ignored on receipt.
    WSMAN_FRAGMENT     fragment;
    ///A WSMAN_FILTER structure that specifies the filtering that is used for the operation. This parameter is reserved
    ///for future use and is ignored on receipt.
    WSMAN_FILTER       filter;
    ///A WSMAN_SELECTOR_SET structure that identifies the specific resource to use for the request.
    WSMAN_SELECTOR_SET selectorSet;
    ///A WSMAN_OPTION_SET structure that specifies the set of options for the request.
    WSMAN_OPTION_SET   optionSet;
    void*              reserved;
    uint               version_;
}

struct WSMAN_OPERATION_INFOEX
{
    WSMAN_FRAGMENT     fragment;
    WSMAN_FILTER       filter;
    WSMAN_SELECTOR_SET selectorSet;
    WSMAN_OPTION_SETEX optionSet;
    uint               version_;
    const(wchar)*      uiLocale;
    const(wchar)*      dataLocale;
}

struct WSMAN_API
{
}

///Specifies proxy information.
struct WSMAN_PROXY_INFO
{
    ///Specifies the access type for the proxy. This member must be set to one of the values defined in the
    ///WSManProxyAccessType enumeration.
    uint accessType;
    WSMAN_AUTHENTICATION_CREDENTIALS authenticationCredentials;
}

struct WSMAN_SESSION
{
}

struct WSMAN_OPERATION
{
}

struct WSMAN_SHELL
{
}

struct WSMAN_COMMAND
{
}

///Lists all the streams that are used for either input or output for the shell and commands.
struct WSMAN_STREAM_ID_SET
{
    ///Defines the number of stream IDs in <b>streamIDs</b>.
    uint     streamIDsCount;
    ushort** streamIDs;
}

///Defines an individual environment variable by using a name and value pair. This structure is used by the
///WSManCreateShell method. The representation of the <b>value</b> variable is shell specific. The client and server
///must agree on the format of the <b>value</b> variable.
struct WSMAN_ENVIRONMENT_VARIABLE
{
    ///Defines the environment variable name. This parameter cannot be <b>NULL</b>.
    const(wchar)* name;
    const(wchar)* value;
}

///Defines an array of environment variables.
struct WSMAN_ENVIRONMENT_VARIABLE_SET
{
    ///Specifies the number of environment variables contained within the <b>vars</b> array.
    uint varsCount;
    WSMAN_ENVIRONMENT_VARIABLE* vars;
}

///Defines the shell startup parameters to be used with the WSManCreateShell function. The structure must be allocated
///by the client and passed to the <b>WSManCreateShell</b> function. The configuration passed to the WSManCreateShell
///function can directly affect the behavior of a command executed within the shell. A typical example is the
///<i>workingDirectory</i> argument that describes the working directory associated with each process, which the
///operating system uses when attempting to locate files specified by using a relative path. In the absence of specific
///requirements for stream naming, clients and services should attempt to use <b>STDIN</b> for input streams,
///<b>STDOUT</b> for the default output stream, and <b>STDERR</b> for the error or status output stream.
struct WSMAN_SHELL_STARTUP_INFO_V10
{
    ///A pointer to a WSMAN_STREAM_ID_SET structure that specifies a set of input streams for the shell. Streams not
    ///present in the filter can be ignored by the shell implementation. For the Windows Cmd.exe shell, this value
    ///should be L"stdin". If the value is <b>NULL</b>, the implementation uses an array with L"stdin" as the default
    ///value.
    WSMAN_STREAM_ID_SET* inputStreamSet;
    ///A pointer to a WSMAN_STREAM_ID_SET structure that specifies a set of output streams for the shell. Streams not
    ///present in the filter can be ignored by the shell implementation. For the Windows cmd.exe shell, this value
    ///should be L"stdout stderr". If the value is <b>NULL</b>, the implementation uses an array with L"stdout" and
    ///L"stderr" as the default value.
    WSMAN_STREAM_ID_SET* outputStreamSet;
    ///Specifies the maximum duration, in milliseconds, the shell will stay open without any client request. When the
    ///maximum duration is exceeded, the shell is automatically deleted. Any value from 0 to 0xFFFFFFFF can be set. This
    ///duration has a maximum value specified by the Idle time-out GPO setting, if enabled, or by the IdleTimeout local
    ///configuration. The default value of the maximum duration in the GPO/local configuration is 15 minutes. However, a
    ///system administrator can change this value. To use the maximum value from the GPO/local configuration, the client
    ///should specify 0 (zero) in this field. If an explicit value between 0 to 0xFFFFFFFF is used, the minimum value
    ///between the explicit API value and the value from the GPO/local configuration is used.
    uint                 idleTimeoutMs;
    ///Specifies the starting directory for a shell. It is used with any execution command. If this member is a
    ///<b>NULL</b> value, a default directory will be used by the remote machine when executing the command. An empty
    ///value is treated by the underlying protocol as an omitted value.
    const(wchar)*        workingDirectory;
    ///A pointer to a WSMAN_ENVIRONMENT_VARIABLE_SET structure that specifies an array of variable name and value pairs,
    ///which describe the starting environment for the shell. The content of these elements is shell specific and can be
    ///defined in terms of other environment variables. If a <b>NULL</b> value is passed, the default environment is
    ///used on the server side.
    WSMAN_ENVIRONMENT_VARIABLE_SET* variableSet;
}

///Defines the shell startup parameters to be used with the WSManCreateShell function. The structure must be allocated
///by the client and passed to the <b>WSManCreateShell</b> function. The configuration passed to the WSManCreateShell
///function can directly affect the behavior of a command executed within the shell. A typical example is the
///<i>workingDirectory</i> argument that describes the working directory associated with each process, which the
///operating system uses when attempting to locate files specified by using a relative path. In the absence of specific
///requirements for stream naming, clients and services should attempt to use <b>STDIN</b> for input streams,
///<b>STDOUT</b> for the default output stream, and <b>STDERR</b> for the error or status output stream.
struct WSMAN_SHELL_STARTUP_INFO_V11
{
    WSMAN_SHELL_STARTUP_INFO_V10 __AnonymousBase_wsman_L665_C48;
    ///Specifies an optional friendly name to be associated with the shell. This parameter is only functional when the
    ///client passes the flag <b>WSMAN_FLAG_REQUESTED_API_VERSION_1_1</b> to WSManInitialize.
    const(wchar)* name;
}

///Specifies the maximum duration, in milliseconds, the shell will stay open after the client has disconnected.
struct WSMAN_SHELL_DISCONNECT_INFO
{
    ///Specifies the maximum time in milliseconds that the shell will stay open after the client has disconnected. When
    ///this maximum duration has been exceeded, the shell will be deleted. Specifying this value overrides the initial
    ///idle timeout value that is set as part of the WSMAN_SHELL_STARTUP_INFO structure in the WSManCreateShell method.
    uint idleTimeoutMs;
}

///Represents the output data received from a WSManReceiveShellOutput method.
struct WSMAN_RECEIVE_DATA_RESULT
{
    ///Represents the <b>streamId</b> for which <b>streamData</b> is defined.
    const(wchar)* streamId;
    ///Represents the data associated with <b>streamId</b>. The data can be stream text, binary content, or XML. For
    ///more information about the possible data, see WSMAN_DATA.
    WSMAN_DATA    streamData;
    ///Specifies the status of the command. If this member is set to <b>WSMAN_COMMAND_STATE_DONE</b>, the command should
    ///be immediately closed.
    const(wchar)* commandState;
    uint          exitCode;
}

struct WSMAN_CONNECT_DATA
{
    WSMAN_DATA data;
}

struct WSMAN_CREATE_SHELL_DATA
{
    WSMAN_DATA data;
}

///Represents the output data received from a WSMan operation.
union WSMAN_RESPONSE_DATA
{
    ///Represents the output data received from a WSManReceiveShellOutput method.
    WSMAN_RECEIVE_DATA_RESULT receiveData;
    ///Represents the output data received from a WSManConnectShell or WSManConnectShellCommand method.
    WSMAN_CONNECT_DATA connectData;
    WSMAN_CREATE_SHELL_DATA createData;
}

///Defines an asynchronous structure to be passed to all shell operations. It contains an optional user context and the
///callback function.
struct WSMAN_SHELL_ASYNC
{
    ///Specifies the optional user context associated with the operation.
    void* operationContext;
    WSMAN_SHELL_COMPLETION_FUNCTION completionFunction;
}

///Represents the set of arguments that are passed in to the command line.
struct WSMAN_COMMAND_ARG_SET
{
    ///Specifies the number of arguments in the array.
    uint     argsCount;
    ushort** args;
}

///Stores client information for an inbound request that was sent with a client certificate. The individual fields
///represent the fields within the client certificate.
struct WSMAN_CERTIFICATE_DETAILS
{
    ///Specifies the subject that is identified by the certificate.
    const(wchar)* subject;
    ///Specifies the name of the issuer of the certificate.
    const(wchar)* issuerName;
    ///Specifies the thumbprint of the issuer.
    const(wchar)* issuerThumbprint;
    const(wchar)* subjectName;
}

///Specifies the client details for every inbound request.
struct WSMAN_SENDER_DETAILS
{
    ///Specifies the user name of the client making the request. The content of this parameter varies depending on the
    ///type of authentication. The value of the <i>senderName</i> is formatted as follows: <table> <tr>
    ///<th>Authentication mechanism</th> <th>Value of <i>senderName</i></th> </tr> <tr> <td> Windows Authentication
    ///</td> <td> The domain and user name. </td> </tr> <tr> <td> Basic Authentication </td> <td> The user name
    ///specified. </td> </tr> <tr> <td> Client Certificates </td> <td> The subject of the certificate. </td> </tr> <tr>
    ///<td> LiveID </td> <td> The LiveID PUID as a string. </td> </tr> </table>
    const(wchar)* senderName;
    ///Specifies a string that indicates which authentication mechanism was used by the client. The following values are
    ///predefined: <ul> <li>Basic</li> <li>ClientCertificate</li> </ul> All other types are queried directly from the
    ///security package. For Internet Information Services (IIS) hosting, this string is retrieved from the IIS
    ///infrastructure.
    const(wchar)* authenticationMechanism;
    ///A pointer to a WSMAN_CERTIFICATE_DETAILS structure that specifies the details of the client's certificate. This
    ///parameter is valid only if the <i>authenticationMechanism</i>is set to ClientCertificate.
    WSMAN_CERTIFICATE_DETAILS* certificateDetails;
    ///Specifies the identity token of the user if a Windows security token is available for a user. This token will be
    ///used by the thread to impersonate this user for all calls into the plug-in. <div class="alert"><b>Note</b>
    ///Authorization plug-ins can change the user context and use a different impersonation token.</div> <div> </div>
    HANDLE        clientToken;
    const(wchar)* httpURL;
}

///Specifies information for a plug-in request. A pointer to a <b>WSMAN_PLUGIN_REQUEST</b> structure is passed to all
///operation entry points within the plug-in. All result notification methods use this pointer to match the result with
///the request. All information in the structure will stay valid until the plug-in calls WSManPluginOperationCompleteon
///the operation.
struct WSMAN_PLUGIN_REQUEST
{
    ///A pointer to a WSMAN_SENDER_DETAILS structure that specifies details about the client that initiated the request.
    WSMAN_SENDER_DETAILS* senderDetails;
    ///Specifies the locale that the user requested results to be in. If the requested locale is not available, the
    ///following options are available: <ul> <li>The system locale is used.</li> <li>The request is rejected with an
    ///invalid locale error.</li> </ul> Any call into the plug-in will have the locale on the thread set to the locale
    ///that is specified in this member. If the plug-in has other threads working on the request, the plug-in will need
    ///to set the locale accordingly on each thread that it uses.
    const(wchar)* locale;
    ///Specifies the resource URI for this operation.
    const(wchar)* resourceUri;
    ///A pointer to a WSMAN_OPERATION_INFO structure that contains extra information about the operation. Some of the
    ///information in this structure will be <b>NULL</b> because not all of the parameters are relevant to all
    ///operations.
    WSMAN_OPERATION_INFO* operationInfo;
    ///If the operation is canceled, the <b>shutdownNotification</b> member is set to <b>TRUE</b>.
    int           shutdownNotification;
    ///If the operation is canceled, <b>shutdownNotification</b> is signaled.
    HANDLE        shutdownNotificationHandle;
    const(wchar)* dataLocale;
}

///Reports quota information on a per-user basis for authorization plug-ins.
struct WSMAN_AUTHZ_QUOTA
{
    ///Specifies the maximum number of concurrent shells that a user is allowed to create.
    uint maxAllowedConcurrentShells;
    ///Specifies the maximum number of concurrent operations that a user is allowed to perform. Only top-level
    ///operations are counted. Simple operations such as get, put, and delete are counted as one operation each. More
    ///complex operations are also counted as one. For example, the enumeration operation and any associated operations
    ///that are related to enumeration are counted as one operation.
    uint maxAllowedConcurrentOperations;
    ///Time-slot length for determining the maximum number of operations per time slot. This value is specified in units
    ///of seconds.
    uint timeslotSize;
    uint maxAllowedOperationsPerTimeslot;
}

// Functions

///Initializes the Windows Remote Management Client API. <b>WSManInitialize</b> can be used by different clients on the
///same process.
///Params:
///    flags = A flag of type <b>WSMAN_FLAG_REQUESTED_API_VERSION_1_0</b> or <b>WSMAN_FLAG_REQUESTED_API_VERSION_1_1</b>. The
///            client that will use the disconnect-reconnect functionality should use the
///            <b>WSMAN_FLAG_REQUESTED_API_VERSION_1_1</b> flag.
///    apiHandle = Defines a handle that uniquely identifies the client. This parameter cannot be <b>NULL</b>. When you have
///                finished used the handle, close it by calling the WSManDeinitialize method.
@DllImport("WsmSvc")
uint WSManInitialize(uint flags, WSMAN_API** apiHandle);

///Deinitializes the Windows Remote Management client stack. All operations must be complete before a call to this
///function will return. This is a synchronous call. It is recommended that all operations are explicitly canceled and
///that all sessions are closed before calling this function.
///Params:
///    apiHandle = Specifies the API handle returned by a WSManInitialize call. This parameter cannot be <b>NULL</b>.
///    flags = Reserved for future use. Must be zero.
@DllImport("WsmSvc")
uint WSManDeinitialize(WSMAN_API* apiHandle, uint flags);

///Retrieves the error messages associated with a particular error and language codes.
///Params:
///    apiHandle = Specifies the API handle returned by a WSManInitialize call. This parameter cannot be <b>NULL</b>.
///    flags = Reserved for future use. Must be zero.
///    languageCode = Specifies the language code name that should be used to localize the error. For more information about the
///                   language code names, see the RFC 3066 specification from the Internet Engineering Task Force at
///                   http://www.ietf.org/rfc/rfc3066.txt. If a language code is not specified, the user interface language of the
///                   thread is used.
///    errorCode = Specifies the error code for the requested error message. This error code can be a hexadecimal or decimal error
///                code from a WinRM, WinHTTP, or other Windows operating system feature.
///    messageLength = Specifies the number of characters that can be stored in the output message buffer, including the <b>null</b>
///                    terminator. If this parameter is zero, the <i>message</i> parameter must be <b>NULL</b>.
///    message = Specifies the output buffer to store the message in. This buffer must be allocated and deallocated by the client.
///              The buffer must be large enough to store the message and the <b>null</b> terminator. If this parameter is
///              <b>NULL</b>, the <i>messageLength</i> parameter must be <b>NULL</b>.
///    messageLengthUsed = Specifies the actual number of characters written to the output buffer, including the <b>null</b> terminator.
///                        This parameter cannot be <b>NULL</b>. If either the <i>messageLength</i> or <i>message</i> parameters are zero,
///                        the function will return <b>ERROR_INSUFFICIENT_BUFFER</b> and this parameter will be set to the number of
///                        characters needed to store the message, including the <b>null</b> terminator.
@DllImport("WsmSvc")
uint WSManGetErrorMessage(WSMAN_API* apiHandle, uint flags, const(wchar)* languageCode, uint errorCode, 
                          uint messageLength, const(wchar)* message, uint* messageLengthUsed);

///Creates a session object.
///Params:
///    apiHandle = Specifies the API handle returned by the WSManInitialize call. This parameter cannot be <b>NULL</b>.
///    connection = Indicates to which protocol and agent to connect. If this parameter is <b>NULL</b>, the connection will default
///                 to localhost (127.0.0.1). This parameter can be a simple host name or a complete URL. The format is the
///                 following: [transport://]host[:port][/prefix] where: <table> <tr> <th>Element</th> <th>Description</th> </tr>
///                 <tr> <td> transport </td> <td> Either HTTP or HTTPS. Default is HTTP. </td> </tr> <tr> <td> host </td> <td> Can
///                 be in a DNS name, NetBIOS name, or IP address. </td> </tr> <tr> <td> port </td> <td> Defaults to 80 for HTTP and
///                 to 443 for HTTPS. The defaults can be changed in the local configuration. </td> </tr> <tr> <td> prefix </td> <td>
///                 Any string. Default is "wsman". The default can be changed in the local configuration. </td> </tr> </table>
///    flags = Reserved for future use. Must be zero.
///    serverAuthenticationCredentials = Defines the authentication method such as Negotiate, Kerberos, Digest, Basic, or client certificate. If the
///                                      authentication mechanism is Negotiate, Kerberos, Digest, or Basic, the structure can also contain the credentials
///                                      used for authentication. If client certificate authentication is used, the certificate thumbprint must be
///                                      specified. If credentials are specified, this parameter contains the user name and password of a local account or
///                                      domain account. If this parameter is <b>NULL</b>, the default credentials are used. The default credentials are
///                                      the credentials that the current thread is executing under. The client must explicitly specify the credentials
///                                      when Basic or Digest authentication is used. If explicit credentials are used, both the user name and the
///                                      password must be valid. For more information about the authentication credentials, see the
///                                      WSMAN_AUTHENTICATION_CREDENTIALS structure.
///    proxyInfo = A pointer to a WSMAN_PROXY_INFO structure that specifies proxy information. This value can be <b>NULL</b>.
///    session = Defines the session handle that uniquely identifies the session. This parameter cannot be <b>NULL</b>. This
///              handle should be closed by calling the WSManCloseSession method.
@DllImport("WsmSvc")
uint WSManCreateSession(WSMAN_API* apiHandle, const(wchar)* connection, uint flags, 
                        WSMAN_AUTHENTICATION_CREDENTIALS* serverAuthenticationCredentials, 
                        WSMAN_PROXY_INFO* proxyInfo, WSMAN_SESSION** session);

///Closes a session object.
///Params:
///    session = Specifies the session handle to close. This handle is returned by a WSManCreateSession call. This parameter
///              cannot be NULL.
///    flags = Reserved for future use. Must be zero.
///Returns:
///    This method returns zero on success. Otherwise, this method returns an error code.
///    
@DllImport("WsmSvc")
uint WSManCloseSession(WSMAN_SESSION* session, uint flags);

///Sets an extended set of options for the session.
///Params:
///    session = Specifies the session handle returned by a WSManCreateSession call. This parameter cannot be <b>NULL</b>.
///    option = Specifies the option to be set. This parameter must be set to one of the values in the WSManSessionOption
///             enumeration.
///    data = A pointer to a WSMAN_DATA structure that defines the option value.
///Returns:
///    This method returns zero on success. Otherwise, this method returns an error code.
///    
@DllImport("WsmSvc")
uint WSManSetSessionOption(WSMAN_SESSION* session, WSManSessionOption option, WSMAN_DATA* data);

///Gets the value of a session option.
///Params:
///    session = Specifies the handle returned by a WSManCreateSession call. This parameter cannot be <b>NULL</b>.
///    option = Specifies the option to get. Not all session options can be retrieved. The options are defined in the
///             WSManSessionOption enumeration.
///    value = Specifies the value of specified session option.
@DllImport("WsmSvc")
uint WSManGetSessionOptionAsDword(WSMAN_SESSION* session, WSManSessionOption option, uint* value);

///Gets the value of a session option.
///Params:
///    session = Specifies the session handle returned by a WSManCreateSession call. This parameter cannot be <b>NULL</b>.
///    option = Specifies the option to get. Not all session options can be retrieved. The values for the options are defined in
///             the WSManSessionOption enumeration.
///    stringLength = Specifies the length of the storage location for <i>string</i> parameter.
///    string = A pointer to the storage location for the value of the specified session option.
///    stringLengthUsed = Specifies the length of the string returned in the <i>string</i> parameter.
@DllImport("WsmSvc")
uint WSManGetSessionOptionAsString(WSMAN_SESSION* session, WSManSessionOption option, uint stringLength, 
                                   const(wchar)* string, uint* stringLengthUsed);

///Cancels or closes an asynchronous operation. All resources that are associated with the operation are freed.
///Params:
///    operationHandle = Specifies the operation handle to be closed.
///    flags = Reserved for future use. Set to zero.
///Returns:
///    This method returns zero on success. Otherwise, this method returns an error code.
///    
@DllImport("WsmSvc")
uint WSManCloseOperation(WSMAN_OPERATION* operationHandle, uint flags);

///Creates a shell object. The returned shell handle identifies an object that defines the context in which commands can
///be run. The context is defined by the environment variables, the input and output streams, and the working directory.
///The context can directly affect the behavior of a command. A shell context is created on the remote computer
///specified by the connection parameter and authenticated by using the credentials parameter.
///Params:
///    session = Specifies the session handle returned by a WSManCreateSession call. This parameter cannot be <b>NULL</b>.
///    flags = Reserved for future use. Must be zero.
///    resourceUri = Defines the shell type to create. The shell type is defined by a unique URI. The actual shell object returned by
///                  the call is dependent on the URI specified. This parameter cannot be <b>NULL</b>. To create a Windows cmd.exe
///                  shell, use the <b>WSMAN_CMDSHELL_URI</b> resource URI.
///    startupInfo = A pointer to a WSMAN_SHELL_STARTUP_INFO structure that specifies the input and output streams, working directory,
///                  idle time-out, and options for the shell. If this parameter is <b>NULL</b>, the default values will be used.
///    options = A pointer to a WSMAN_OPTION_SET structure that specifies a set of options for the shell.
///    createXml = A pointer to a WSMAN_DATA structure that defines an open context for the shell. The content should be a valid XML
///                string. This parameter can be <b>NULL</b>.
///    async = Defines an asynchronous structure. The asynchronous structure contains an optional user context and a mandatory
///            callback function. See the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be <b>NULL</b>
///            and should be closed by calling the WSManCloseShell method.
@DllImport("WsmSvc")
void WSManCreateShell(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, 
                      WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, WSMAN_OPTION_SET* options, WSMAN_DATA* createXml, 
                      WSMAN_SHELL_ASYNC* async, WSMAN_SHELL** shell);

///Starts the execution of a command within an existing shell and does not wait for the completion of the command.
///Params:
///    shell = Specifies the shell handle returned by the WSManCreateShell call. This parameter cannot be <b>NULL</b>.
///    flags = Reserved for future use. Must be zero.
///    commandLine = Defines a required <b>null</b>-terminated string that represents the command to be executed. Typically, the
///                  command is specified without any arguments, which are specified separately. However, a user can specify the
///                  command line and all of the arguments by using this parameter. If arguments are specified for the
///                  <i>commandLine</i> parameter, the <i>args</i> parameter should be <b>NULL</b>.
///    args = A pointer to a WSMAN_COMMAND_ARG_SET structure that defines an array of argument values, which are passed to the
///           command on creation. If no arguments are required, this parameter should be <b>NULL</b>.
///    options = Defines a set of options for the command. These options are passed to the service to modify or refine the command
///              execution. This parameter can be <b>NULL</b>. For more information about the options, see WSMAN_OPTION_SET.
///    async = Defines an asynchronous structure. The asynchronous structure contains an optional user context and a mandatory
///            callback function. See the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be <b>NULL</b>
///            and should be closed by calling the WSManCloseCommand method.
@DllImport("WsmSvc")
void WSManRunShellCommand(WSMAN_SHELL* shell, uint flags, const(wchar)* commandLine, WSMAN_COMMAND_ARG_SET* args, 
                          WSMAN_OPTION_SET* options, WSMAN_SHELL_ASYNC* async, WSMAN_COMMAND** command);

///Sends a control code to an existing command or to the shell itself.
///Params:
///    shell = Specifies the handle returned by a WSManCreateShell call. This parameter cannot be <b>NULL</b>.
///    command = Specifies the command handle returned by a WSManRunShellCommand call. If this value is <b>NULL</b>, the signal
///              code is sent to the shell.
///    flags = Reserved for future use. Must be set to zero.
///    code = Specifies the signal code to send to the command or shell. The following codes are common.
///    async = Defines an asynchronous structure. The asynchronous structure contains an optional user context and a mandatory
///            callback function. See the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be <b>NULL</b>
///            and should be closed by calling the WSManCloseOperation method.
@DllImport("WsmSvc")
void WSManSignalShell(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, const(wchar)* code, 
                      WSMAN_SHELL_ASYNC* async, WSMAN_OPERATION** signalOperation);

///Retrieves output from a running command or from the shell.
///Params:
///    shell = Specifies the shell handle returned by a WSManCreateShell call. This parameter cannot be <b>NULL</b>.
///    command = Specifies the command handle returned by a WSManRunShellCommand call.
///    flags = Reserved for future use. Must be set to zero.
///    desiredStreamSet = Specifies the requested output from a particular stream or a list of streams.
///    async = Defines an asynchronous structure. The asynchronous structure contains an optional user context and a mandatory
///            callback function. See the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be <b>NULL</b>
///            and should be closed by calling the WSManCloseOperation method.
@DllImport("WsmSvc")
void WSManReceiveShellOutput(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, 
                             WSMAN_STREAM_ID_SET* desiredStreamSet, WSMAN_SHELL_ASYNC* async, 
                             WSMAN_OPERATION** receiveOperation);

///Pipes the input stream to a running command or to the shell.
///Params:
///    shell = Specifies the shell handle returned by a WSManCreateShell call. This parameter cannot be <b>NULL</b>.
///    command = Specifies the command handle returned by a WSManRunShellCommand call. This handle should be closed by calling the
///              WSManCloseCommand method.
///    flags = Reserved for future use. Must be set to zero.
///    streamId = Specifies the input stream ID. This parameter cannot be <b>NULL</b>.
///    streamData = Uses the WSMAN_DATA structure to specify the stream data to be sent to the command or shell. This structure
///                 should be allocated by the calling client and must remain allocated until <b>WSManSendShellInput</b> completes.
///                 If the end of the stream has been reached, the <i>endOfStream</i> parameter should be set to <b>TRUE</b>.
///    endOfStream = Set to <b>TRUE</b>, if the end of the stream has been reached. Otherwise, this parameter is set to <b>FALSE</b>.
///    async = Defines an asynchronous structure. The asynchronous structure contains an optional user context and a mandatory
///            callback function. See the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be <b>NULL</b>
///            and should be closed by calling the WSManCloseCommand method.
@DllImport("WsmSvc")
void WSManSendShellInput(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, const(wchar)* streamId, 
                         WSMAN_DATA* streamData, BOOL endOfStream, WSMAN_SHELL_ASYNC* async, 
                         WSMAN_OPERATION** sendOperation);

///Deletes a command and frees the resources that are associated with it.
///Params:
///    commandHandle = Specifies the command handle to be closed. This handle is returned by a WSManRunShellCommand call.
///    flags = Reserved for future use. Must be set to zero.
@DllImport("WsmSvc")
void WSManCloseCommand(WSMAN_COMMAND* commandHandle, uint flags, WSMAN_SHELL_ASYNC* async);

///Deletes a shell object and frees the resources associated with the shell.
///Params:
///    shellHandle = Specifies the shell handle to close. This handle is returned by a WSManCreateShell call. This parameter cannot be
///                  <b>NULL</b>.
///    flags = Reserved for future use. Must be set to zero.
@DllImport("WsmSvc")
void WSManCloseShell(WSMAN_SHELL* shellHandle, uint flags, WSMAN_SHELL_ASYNC* async);

///Creates a shell object by using the same functionality as the WSManCreateShell function, with the addition of a
///client-specified shell ID. The returned shell handle identifies an object that defines the context in which commands
///can be run. The context is defined by the environment variables, the input and output streams, and the working
///directory. The context can directly affect the behavior of a command. A shell context is created on the remote
///computer specified by the connection parameter and authenticated by using the credentials parameter.
///Params:
///    session = Specifies the session handle returned by a WSManCreateSession call. This parameter cannot be <b>NULL</b>.
///    flags = Reserved for future use. Must be 0.
///    resourceUri = Defines the shell type to create. The shell type is defined by a unique URI. The actual shell object returned by
///                  the call is dependent on the URI specified. This parameter cannot be <b>NULL</b>. To create a Windows cmd.exe
///                  shell, use the <b>WSMAN_CMDSHELL_URI</b> resource URI.
///    shellId = The client specified <i>shellID</i>.
///    startupInfo = A pointer to a WSMAN_SHELL_STARTUP_INFO structure that specifies the input and output streams, working directory,
///                  idle timeout, and options for the shell. If this parameter is <b>NULL</b>, the default values will be used.
///    options = A pointer to a WSMAN_OPTION_SET structure that specifies a set of options for the shell.
///    createXml = A pointer to a WSMAN_DATA structure that defines an open context for the shell. The content should be a valid XML
///                string. This parameter can be <b>NULL</b>.
///    async = Defines an asynchronous structure. The asynchronous structure contains an optional user context and a mandatory
///            callback function. See the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be <b>NULL</b>
///            and should be closed by calling the WSManCloseShell method.
@DllImport("WsmSvc")
void WSManCreateShellEx(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, const(wchar)* shellId, 
                        WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, WSMAN_OPTION_SET* options, WSMAN_DATA* createXml, 
                        WSMAN_SHELL_ASYNC* async, WSMAN_SHELL** shell);

///Provides the same functionality as the WSManRunShellCommand function, with the addition of a command ID option. If
///the server supports the protocol, it will create the command instance using the ID specified by the client. If a
///command with the specified ID already exists, the server will fail to create the command instance. This new
///functionality is only available when the client application passes the <b>WSMAN_FLAG_REQUESTED_API_VERSION_1_1</b>
///flag as part of the call to the WSManInitialize function.
///Params:
///    shell = Specifies the shell handle returned by the WSManCreateShell call. This parameter cannot be <b>NULL</b>.
///    flags = Reserved for future use. Must be 0.
///    commandId = The client specified command Id.
///    commandLine = Defines a required null-terminated string that represents the command to be executed. Typically, the command is
///                  specified without any arguments, which are specified separately. However, a user can specify the command line and
///                  all of the arguments by using this parameter. If arguments are specified for the commandLine parameter, the args
///                  parameter should be <b>NULL</b>.
///    args = A pointer to a WSMAN_COMMAND_ARG_SET structure that defines an array of argument values, which are passed to the
///           command on creation. If no arguments are required, this parameter should be <b>NULL</b>.
///    options = Defines a set of options for the command. These options are passed to the service to modify or refine the command
///              execution. This parameter can be <b>NULL</b>. For more information about the options, see WSMAN_OPTION_SET.
///    async = Defines an asynchronous structure. The asynchronous structure contains an optional user context and a mandatory
///            callback function. See the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be <b>NULL</b>
///            and should be closed by calling the WSManCloseCommand method.
@DllImport("WsmSvc")
void WSManRunShellCommandEx(WSMAN_SHELL* shell, uint flags, const(wchar)* commandId, const(wchar)* commandLine, 
                            WSMAN_COMMAND_ARG_SET* args, WSMAN_OPTION_SET* options, WSMAN_SHELL_ASYNC* async, 
                            WSMAN_COMMAND** command);

///Disconnects the network connection of an active shell and its associated commands.
///Params:
///    shell = Specifies the handle returned by a call to the WSManCreateShell function. This parameter cannot be <b>NULL</b>.
///    flags = Can be a <b>WSMAN_FLAG_SERVER_BUFFERING_MODE_DROP</b> flag or a <b>WSMAN_FLAG_SERVER_BUFFERING_MODE_BLOCK</b>
///            flag.
///    disconnectInfo = A pointer to a WSMAN_SHELL_DISCONNECT_INFO structure that specifies an idle time-out that the server session may
///                     enforce. If this parameter is <b>NULL</b>, the server session idle time-out will not be changed.
///    async = Defines an asynchronous structure to contain an optional user context and a mandatory callback function. For more
///            information, see WSMAN_SHELL_ASYNC. This parameter cannot be <b>NULL</b>.
@DllImport("WsmSvc")
void WSManDisconnectShell(WSMAN_SHELL* shell, uint flags, WSMAN_SHELL_DISCONNECT_INFO* disconnectInfo, 
                          WSMAN_SHELL_ASYNC* async);

///Reconnects a previously disconnected shell session. To reconnect the shell session's associated commands, use
///WSManReconnectShellCommand.
///Params:
///    shell = Specifies the handle returned by a call to the WSManCreateShell function. This parameter cannot be <b>NULL</b>.
///    flags = This parameter is reserved for future use and must be set to zero.
@DllImport("WsmSvc")
void WSManReconnectShell(WSMAN_SHELL* shell, uint flags, WSMAN_SHELL_ASYNC* async);

///Reconnects a previously disconnected command.
///Params:
///    commandHandle = Specifies the handle returned by a WSManRunShellCommand call or a WSManConnectShellCommand call. This parameter
///                    cannot be NULL.
///    flags = Reserved for future use. Must be set to zero.
@DllImport("WsmSvc")
void WSManReconnectShellCommand(WSMAN_COMMAND* commandHandle, uint flags, WSMAN_SHELL_ASYNC* async);

///Connects to an existing server session.
///Params:
///    session = Specifies the session handle returned by a WSManCreateSession function. This parameter cannot be NULL.
///    flags = Reserved for future use. Must be zero.
///    resourceUri = Defines the shell type to which the connection will be made. The shell type is defined by a unique URI, therefore
///                  the shell object returned by the call is dependent on the URI that is specified by this parameter. The
///                  <i>resourceUri</i> parameter cannot be NULL and it is a null-terminated string.
///    shellID = Specifies the shell identifier that is associated with the server shell session to which the client intends to
///              connect.
///    options = A pointer to a WSMAN_OPTION_SET structure that specifies a set of options for the shell. This parameter is
///              optional.
///    connectXml = A pointer to a WSMAN_DATA structure that defines an open context for the connect shell operation. The content
///                 should be a valid XML string. This parameter can be NULL.
///    async = Defines an asynchronous structure that contains an optional user context and a mandatory callback function. See
///            the WSMAN_SHELL_ASYNC structure for more information. This parameter cannot be NULL.
///    shell = Specifies a shell handle that uniquely identifies the shell object that was returned by <i>resourceURI</i>. The
///            resource handle tracks the client endpoint for the shell and is used by other WinRM methods to interact with the
///            shell object. The shell object should be deleted by calling the WSManCloseShell method. This parameter cannot be
///            NULL.
@DllImport("WsmSvc")
void WSManConnectShell(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, const(wchar)* shellID, 
                       WSMAN_OPTION_SET* options, WSMAN_DATA* connectXml, WSMAN_SHELL_ASYNC* async, 
                       WSMAN_SHELL** shell);

///Connects to an existing command running in a shell.
///Params:
///    shell = Specifies the shell handle returned by the WSManCreateShell call. This parameter cannot be <b>NULL</b>.
///    flags = Reserved for future use. Must be zero.
///    commandID = A null-terminated string that identifies a specific command, currently running in the server session, that the
///                client intends to connect to.
///    options = Defines a set of options for the command. These options are passed to the service to modify or refine the command
///              execution. This parameter can be <b>NULL</b>. For more information about the options, see WSMAN_OPTION_SET.
///    connectXml = A pointer to a WSMAN_DATA structure that defines an open context for the connect shell operation. The content
///                 must be a valid XML string. This parameter can be <b>NULL</b>.
///    async = Defines an asynchronous structure to contain an optional user context and a mandatory callback function. For more
///            information, see WSMAN_SHELL_ASYNC. This parameter cannot be <b>NULL</b>.
@DllImport("WsmSvc")
void WSManConnectShellCommand(WSMAN_SHELL* shell, uint flags, const(wchar)* commandID, WSMAN_OPTION_SET* options, 
                              WSMAN_DATA* connectXml, WSMAN_SHELL_ASYNC* async, WSMAN_COMMAND** command);

///Reports shell and command context back to the Windows Remote Management (WinRM) infrastructure so that further
///operations can be performed against the shell and/or command. This method is called only for WSManPluginShell and
///WSManPluginCommand plug-in entry points.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be set to zero.
///    context = Defines the value to pass into all future shell and command operations. Represents either the shell or the
///              command. This value should be unique for all shells, and it should also be unique for all commands associated
///              with a shell.
@DllImport("WsmSvc")
uint WSManPluginReportContext(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* context);

///Reports results for the WSMAN_PLUGIN_RECEIVE plug-in call and is used by most shell plug-ins that return results.
///After all of the data is received, the WSManPluginOperationComplete method must be called.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be set to zero.
///    stream = Specifies the stream that the data is associated with. Any stream can be used, but the standard streams are
///             STDIN, STDOUT, and STDERR.
///    streamResult = A pointer to a WSMAN_DATA structure that specifies the result object that is returned to the client. The result
///                   can be in either binary or XML format.
///    commandState = Specifies the state of the command. This parameter must be set either to one of the following values or to a
///                   value defined by the plug-in.
@DllImport("WsmSvc")
uint WSManPluginReceiveResult(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, const(wchar)* stream, 
                              WSMAN_DATA* streamResult, const(wchar)* commandState, uint exitCode);

///Reports the completion of an operation by all operation entry points except for the WSManPluginStartup and
///WSManPluginShutdown methods.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Reserved for future use. Must be zero.
///    errorCode = Reports any failure in the operation. If this parameter is not <b>NO_ERROR</b>, any result data that has not been
///                sent will be discarded and the error will be sent.
///    extendedInformation = Specifies an XML document that contains any extra error information that needs to be reported to the client. This
///                          parameter is ignored if <i>errorCode</i> is <b>NO_ERROR</b>. The user interface language of the thread should be
///                          used for localization.
///Returns:
///    The method returns <b>NO_ERROR</b> if it succeeded; otherwise, it returns an error code. If the operation is
///    unsuccessful, the plug-in must stop the current operation and clean up any data associated with this operation.
///    The <i>requestDetails</i> structure is not valid if an error is received and must not be passed to any other
///    WinRM (WinRM) method.
///    
@DllImport("WsmSvc")
uint WSManPluginOperationComplete(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, uint errorCode, 
                                  const(wchar)* extendedInformation);

///Gets operational information for items such as time-outs and data restrictions that are associated with the
///operation. A plug-in should not use these parameters for anything other than informational purposes.
///Params:
///    requestDetails = A pointer to a WSMAN_PLUGIN_REQUEST structure that specifies the resource URI, options, locale, shutdown flag,
///                     and handle for the request.
///    flags = Specifies the options that are available for retrieval. This parameter must be set to either one of the following
///            values or to a value defined by the plug-in.
///    data = A pointer to a WSMAN_DATA structure that specifies the result object.
@DllImport("WsmSvc")
uint WSManPluginGetOperationParameters(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, WSMAN_DATA* data);

@DllImport("WsmSvc")
uint WSManPluginGetConfiguration(void* pluginContext, uint flags, WSMAN_DATA* data);

@DllImport("WsmSvc")
uint WSManPluginReportCompletion(void* pluginContext, uint flags);

///Releases memory that is allocated for the WSMAN_PLUGIN_REQUEST structure, which is passed into operation plug-in
///entry points. This method is optional and can be called at any point after a plug-in entry point is called and before
///the entry point calls the WSManPluginOperationComplete method. After this method is called, the memory will be
///released and the plug-in will be unable to access any of the parameters in the WSMAN_PLUGIN_REQUEST structure.
@DllImport("WsmSvc")
uint WSManPluginFreeRequestDetails(WSMAN_PLUGIN_REQUEST* requestDetails);

///Called from the WSManPluginAuthzUser plug-in entry point and reports either a successful or failed user connection
///authorization.
///Params:
///    senderDetails = A pointer to the WSMAN_SENDER_DETAILS structure that was passed into the WSManPluginAuthzUser plug-in call.
///    flags = Reserved for future use. Must be set to zero.
///    userAuthorizationContext = Specifies a plug-in defined context that is used to help track user context information. This context can be
///                               returned to multiple calls, to this call, or to an operation call. The plug-in manages reference counting for all
///                               calls. If the user record times out or re-authorization is required, the WinRM infrastructure calls
///                               WSManPluginAuthzReleaseContext.
///    impersonationToken = Specifies the identity of the user. This parameter is the <i>clientToken</i> that was passed into
///                         <i>senderDetails</i>. If the plug-in changes the user context, a new impersonation token should be returned. <div
///                         class="alert"><b>Note</b> This token is released after the operation has been completed.</div> <div> </div>
///    userIsAdministrator = Set to <b>TRUE</b> if the user is an administrator. Otherwise, this parameter is <b>FALSE</b>.
///    errorCode = Reports either a successful or failed authorization. If the authorization is successful, the code should be
///                <b>ERROR_SUCCESS</b>. If the user is not authorized to perform the operation, the error should be
///                <b>ERROR_ACCESS_DENIED</b>. If a failure happens for any other reason, an appropriate error code should be used.
///                Any error from this call will be sent back as a SOAP fault packet.
///    extendedErrorInformation = Specifies an XML document that contains any extra error information that needs to be reported to the client. This
///                               parameter is ignored if <i>errorCode</i> is <b>NO_ERROR</b>. The user interface language of the thread should be
///                               used for localization.
///Returns:
///    The method returns <b>ERROR_SUCCESS</b> if it succeeded; otherwise, it returns <b>ERROR_INVALID_PARAMETER</b>. If
///    <b>ERROR_INVALID_PARAMETER</b> is returned, either the <i>senderDetails</i> parameter was <b>NULL</b> or the
///    <i>flags</i> parameter was not zero.
///    
@DllImport("WsmSvc")
uint WSManPluginAuthzUserComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, void* userAuthorizationContext, 
                                  HANDLE impersonationToken, BOOL userIsAdministrator, uint errorCode, 
                                  const(wchar)* extendedErrorInformation);

///Called from the WSManPluginAuthzOperation plug-in entry point. It reports either a successful or failed authorization
///for a user operation.
///Params:
///    senderDetails = A pointer to the WSMAN_SENDER_DETAILS structure that was passed into the WSManPluginAuthzOperation plug-in call.
///    flags = Reserved for future use. Must be zero.
///    userAuthorizationContext = Specifies a plug-in defined context that is used to help track user context information. This context can be
///                               returned to multiple calls, to this call, or to an operation call. The plug-in manages reference counting for all
///                               calls. If the user record times out or re-authorization is required, the WinRM (WinRM) infrastructure calls
///                               WSManPluginAuthzReleaseContext.
///    errorCode = Reports either a successful or failed authorization. If the authorization is successful, the code should be
///                <b>ERROR_SUCCESS</b>. If the user is not authorized to perform the operation, the error should be
///                <b>ERROR_ACCESS_DENIED</b>. If a failure happens for any other reason, an appropriate error code should be used.
///                Any error from this call will be sent back as a Simple Object Access Protocol (SOAP) fault packet.
///    extendedErrorInformation = Specifies an XML document that contains any extra error information that needs to be reported to the client. This
///                               parameter is ignored if <i>errorCode</i> is <b>NO_ERROR</b>. The user interface language of the thread should be
///                               used for localization.
@DllImport("WsmSvc")
uint WSManPluginAuthzOperationComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, 
                                       void* userAuthorizationContext, uint errorCode, 
                                       const(wchar)* extendedErrorInformation);

///Called from the WSManPluginAuthzQueryQuota plug-in entry point and must be called whether or not the plug-in can
///carry out the request.
///Params:
///    senderDetails = A pointer to the WSMAN_SENDER_DETAILS structure that was passed into the WSManPluginAuthzQueryQuota plug-in call.
///    flags = Reserved for future use. Must be zero.
///    quota = A pointer to a WSMAN_AUTHZ_QUOTA structure that specifies quota information for a specific user.
///    errorCode = Reports either a successful or failed authorization. If the authorization is successful, the code should be
///                <b>ERROR_SUCCESS</b>. If a failure happens for any other reason, an appropriate error code should be used. Any
///                error from this call will be sent back as a Simple Object Access Protocol (SOAP) fault packet.
///    extendedErrorInformation = Specifies an XML document that contains any extra error information that needs to be reported to the client. This
///                               parameter is ignored if <i>errorCode</i> is <b>NO_ERROR</b>. The user interface language of the thread should be
///                               used for localization.
///Returns:
///    The method returns <b>ERROR_SUCCESS</b> if it succeeded; otherwise, it returns <b>ERROR_INVALID_PARAMETER</b>. If
///    <b>ERROR_INVALID_PARAMETER</b> is returned, either the <i>senderDetails</i> parameter was <b>NULL</b> or the
///    <i>flags</i> parameter was not zero. If the method fails, the default quota is used.
///    
@DllImport("WsmSvc")
uint WSManPluginAuthzQueryQuotaComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, WSMAN_AUTHZ_QUOTA* quota, 
                                        uint errorCode, const(wchar)* extendedErrorInformation);


// Interfaces

@GUID("BCED617B-EC03-420B-8508-977DC7A686BD")
struct WSMan;

@GUID("7DE087A5-5DCB-4DF7-BB12-0924AD8FBD9A")
struct WSManInternal;

///Provides methods and properties used to create a session, represented by a Session object. Any Windows Remote
///Management operations require creation of a Session that connects to a remote computer, base management controller
///(BMC), or the local computer. Operations include getting, writing, or enumerating data, or invoking methods.
@GUID("190D8637-5CD3-496D-AD24-69636BB5A3B5")
interface IWSMan : IDispatch
{
    ///Creates a Session object that can then be used for subsequent network operations.
    ///Params:
    ///    connection = The protocol and service to connect to, including either IPv4 or IPv6. The format of the connection
    ///                 information is as follows: &lt;<i>Transport</i>&gt;&lt;<i>Address</i>&gt;&lt;<i>Suffix</i>&gt;. For examples,
    ///                 see Remarks. If no connection information is provided, the local computer is used.
    ///    flags = The session flags that specify the authentication method, such as Negotiate authentication or Digest
    ///            authentication, for connecting to a remote computer. These flags also specify other session connection
    ///            information, such as encoding or encryption. This parameter must contain one or more of the flags in
    ///            <b>__WSManSessionFlags</b> for a remote connection. For more information, see Session Constants. No flag
    ///            settings are required for a connection to the WinRM service on the local computer. If no authentication flags
    ///            are specified, Kerberos is used unless one of the following conditions is true, in which case Negotiate is
    ///            used: <ul> <li>explicit credentials are supplied and the destination host is trusted</li> <li>the destination
    ///            host is "localhost", "127.0.0.1" or "[::1]"</li> <li>the client computer is in a workgroup and the
    ///            destination host is trusted</li> </ul> For more information, see Authentication for Remote Connections and
    ///            the <i>connectionOptions</i> parameter.
    ///    connectionOptions = A pointer to an IWSManConnectionOptions object that contains a user name and password. The default is
    ///                        <b>NULL</b>.
    ///    session = A pointer to a new IWSManSession object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateSession(BSTR connection, int flags, IDispatch connectionOptions, IDispatch* session);
    ///Creates an IWSManConnectionOptions object that specifies the user name and password used when creating a session.
    ///Params:
    ///    connectionOptions = A pointer to a new IWSManConnectionOptions object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateConnectionOptions(IDispatch* connectionOptions);
    ///Gets the command line of the process that loads the automation component. This property is read-only.
    HRESULT get_CommandLine(BSTR* value);
    ///Gets additional error information, in an XML stream, for the preceding call to an IWSMan method if Windows Remote
    ///Management service was unable to create an IWSManSession object, an IWSManConnectionOptions object, or an
    ///IWSManResourceLocator object. This property is read-only.
    HRESULT get_Error(BSTR* value);
}

///Extends the methods and properties of the IWSMan interface to include creating IWSManResourceLocator objects, methods
///that return enumeration and session flag values, and a method to get extended error information.
@GUID("2D53BDAA-798E-49E6-A1AA-74D01256F411")
interface IWSManEx : IWSMan
{
    ///Creates a ResourceLocator object that can be used instead of a resource URI in Session object operations such as
    ///IWSManSession.Get, IWSManSession.Put, or Session.Enumerate.
    ///Params:
    ///    strResourceLocator = The resource URI for the resource. For more information about URI strings, see Resource URIs.
    ///    newResourceLocator = A pointer to a new instance of IWSManResourceLocator.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateResourceLocator(BSTR strResourceLocator, IDispatch* newResourceLocator);
    ///The WSMan.SessionFlagUTF8 method returns the value of the authentication flag <b>WSManFlagUTF8</b> for use in the
    ///<i>flags</i> parameter of IWSMan::CreateSession. <b>WSManFlagUTF8</b> is a constant in the
    ///<b>__WSManSessionFlags</b> enumeration. For more information, see Other Session Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagUTF8(int* flags);
    ///The <b>IWSMan.SessionFlagCredUsernamePassword</b> method returns the value of the authentication flag
    ///<b>WSManFlagCredUsernamePassword</b> for use in the <i>flags</i> parameter of IWSMan::CreateSession.
    ///<b>WSManFlagCredUsernamePassword</b> is a constant in the <b>__WSManSessionFlags</b> enumeration. For more
    ///information, see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagCredUsernamePassword(int* flags);
    ///The WSMan.SessionFlagSkipCACheck method returns the value of the <b>WSManFlagSkipCACheck</b> authentication flag
    ///for use in the <i>flags</i> parameter of the IWSMan::CreateSession method. <b>WSManFlagSkipCACheck</b> is a
    ///constant in the <b>__WSManSessionFlags</b> enumeration. For more information, see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagSkipCACheck(int* flags);
    ///The WSMan.SessionFlagSkipCNCheck method returns the value of the authentication flag <b>WSManFlagSkipCNCheck</b>
    ///for use in the <i>flags</i> parameter of IWSMan::CreateSession. <b>WSManFlagSkipCNCheck</b> is a constant in the
    ///<b>__WSManSessionFlags</b> enumeration. For more information, see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagSkipCNCheck(int* flags);
    ///The WSMan.SessionFlagUseDigest method returns the value of the authentication flag <b>WSManFlagUseDigest</b> for
    ///use in the <i>flags</i> parameter of IWSMan::CreateSession. <b>WSManFlagUseDigest</b> is a constant in the
    ///<b>__WSManSessionFlags</b> enumeration. For more information, see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagUseDigest(int* flags);
    ///The WSMan.SessionFlagUseNegotiate method returns the value of the authentication flag
    ///<b>WSManFlagUseNegotiate</b> for use in the <i>flags</i> parameter of IWSMan::CreateSession.
    ///<b>WSManFlagUseNegotiate</b> is a constant in the <b>__WSManSessionFlags</b> enumeration. For more information,
    ///see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagUseNegotiate(int* flags);
    ///The WSMan.SessionFlagUseBasic method returns the value of the authentication flag <b>WSManFlagUseBasic</b> for
    ///use in the <i>flags</i> parameter of IWSMan::CreateSession. <b>WSManFlagUseBasic</b> is a constant in the
    ///<b>__WSManSessionFlags</b> enumeration. For more information, see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagUseBasic(int* flags);
    ///The WSMan.WSMan.SessionFlagUseKerberos method returns the value of the authentication flag
    ///<b>WSManFlagUseKerberos</b> for use in the <i>flags</i> parameter of IWSMan::CreateSession.
    ///<b>WSManFlagUseKerberos</b> is a constant in the <b>__WSManSessionFlags</b> enumeration. For more information,
    ///see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagUseKerberos(int* flags);
    ///The WSMan.SessionFlagNoEncryption method returns the value of the authentication flag
    ///<b>WSManFlagNoEncryption</b> for use in the <i>flags</i> parameter of IWSMan::CreateSession.
    ///<b>WSManFlagNoEncryption</b> is a constant in the <b>__WSManSessionFlags</b> enumeration. For more information,
    ///see Other Session Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagNoEncryption(int* flags);
    ///The WSMan.SessionFlagEnableSPNServerPort method returns the value of the authentication flag
    ///<b>WSManFlagEnableSPNServerPort</b> for use in the <i>flags</i> parameter of IWSMan::CreateSession.
    ///<b>WSManFlagEnableSPNServerPort</b> is a constant in the <b>__WSManSessionFlags</b> enumeration. For more
    ///information, see Other Session Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagEnableSPNServerPort(int* flags);
    ///The WSMan.SessionFlagUseNoAuthentication method returns the value of the authentication flag
    ///<b>WSManFlagUseNoAuthentication</b> for use in the <i>flags</i> parameter of IWSMan::CreateSession.
    ///<b>WSManFlagUseNoAuthentication</b> is a constant in the <b>__WSManSessionFlags</b> enumeration. For more
    ///information, see Authentication Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SessionFlagUseNoAuthentication(int* flags);
    ///The <b>IWSManEx::EnumerationFlagNonXmlText</b> method returns the value of the enumeration constant
    ///<b>WSManFlagNonXmlText</b> for use in the <i>flags</i> parameter of the IWSManSession::Enumerate method.
    ///<b>WSManFlagNonXmlText</b> is a constant in the <b>__WSManEnumFlags</b> enumeration. For more information, see
    ///Enumeration Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerationFlagNonXmlText(int* flags);
    ///The <b>IWSManEx::EnumerationFlagReturnEPR</b> method returns the value of the enumeration constant
    ///<b>EnumerationFlagReturnEPR</b> for use in the <i>flags</i> parameter of the IWSManSession::Enumerate method.
    ///<b>EnumerationFlagReturnEPR</b> is a constant in the <b>_WSManEnumFlags</b> enumeration and is described in
    ///Enumeration Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerationFlagReturnEPR(int* flags);
    ///The <b>IWSManEx::EnumerationFlagReturnObjectAndEPR</b> method returns the value of the enumeration constant
    ///<b>EnumerationFlagReturnObjectAndEPR</b> for use in the <i>flags</i> parameter of the IWSManSession::Enumerate
    ///method. <b>EnumerationFlagReturnObjectAndEPR</b> is a constant in the <b>_WSManEnumFlags</b> enumeration and is
    ///described in Enumeration Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerationFlagReturnObjectAndEPR(int* flags);
    ///Returns a formatted string containing the text of an error number. This method performs the same operation as the
    ///<b>Winrm</b> command-line <b>winrm helpmsg </b><i>error number</i>.
    ///Params:
    ///    errorNumber = Error message number in decimal or hexadecimal from WinRM, WinHTTP, or other operating system components.
    ///    errorMessage = Error message string formatted like messages returned from the <b>Winrm</b> command.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetErrorMessage(uint errorNumber, BSTR* errorMessage);
    ///The <b>IWSManEx::EnumerationFlagHierarchyDeep</b> method returns the value of the enumeration constant
    ///<b>EnumerationFlagHierarchyDeep</b> for use in the <i>flags</i> parameter of the IWSManSession::Enumerate method.
    ///<b>EnumerationFlagHierarchyDeep</b> is a constant in the <b>_WSManEnumFlags</b> enumeration and is described in
    ///Enumeration Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerationFlagHierarchyDeep(int* flags);
    ///The <b>IWSManEx::EnumerationFlagHierarchyShallow</b> method returns the value of the enumeration constant
    ///<b>EnumerationFlagHierarchyShallow</b> for use in the <i>flags</i> parameter of the IWSManSession::Enumerate
    ///method. <b>EnumerationFlagHierarchyShallow</b> is a constant in the <b>_WSManEnumFlags</b> enumeration and is
    ///described in Enumeration Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerationFlagHierarchyShallow(int* flags);
    ///The <b>IWSManEx::EnumerationFlagHierarchyDeepBasePropsOnly</b> method returns the value of the enumeration
    ///constant <b>EnumerationFlagHierarchyDeepBasePropsOnly</b> for use in the <i>flags</i> parameter of the
    ///IWSManSession::Enumerate method. <b>EnumerationFlagHierarchyDeepBasePropsOnly</b> is a constant in the
    ///<b>_WSManEnumFlags</b> enumeration and is described in Enumeration Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerationFlagHierarchyDeepBasePropsOnly(int* flags);
    ///The <b>IWSManEx::EnumerationFlagReturnObject</b> method returns the value of the enumeration constant
    ///<b>EnumerationFlagReturnObject</b> for use in the <i>flags</i> parameter of the IWSManSession::Enumerate method.
    ///<b>EnumerationFlagReturnObject</b> is a constant in the <b>_WSManEnumFlags</b> enumeration and is described in
    ///Enumeration Constants.
    ///Params:
    ///    flags = The value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumerationFlagReturnObject(int* flags);
}

///Extends the methods and properties of the IWSManEx interface to include a method that returns a session flag value
///related to authentication using client certificates.
@GUID("1D1B5AE0-42D9-4021-8261-3987619512E9")
interface IWSManEx2 : IWSManEx
{
    ///Returns the value of the authentication flag <b>WSManFlagUseClientCertificate</b> for use in the <i>flags</i>
    ///parameter of IWSMan::CreateSession. <b>WSManFlagUseClientCertificate</b> is a constant in the
    ///<b>__WSManSessionFlags</b> enumeration. For more information, see Authentication Constants.
    ///Params:
    ///    flags = The session flags to use.
    HRESULT SessionFlagUseClientCertificate(int* flags);
}

///Extends the methods and properties of the IWSManEx interface to include a method that returns a session flag value
///related to authentication using the Credential Security Support Provider (CredSSP).
@GUID("6400E966-011D-4EAC-8474-049E0848AFAD")
interface IWSManEx3 : IWSManEx2
{
    HRESULT SessionFlagUTF16(int* flags);
    ///Returns the value of the authentication flag <b>WSManFlagUseCredSsp</b> for use in the <i>flags</i> parameter of
    ///IWSMan::CreateSession. <b>WSManFlagUseCredSsp</b> is a constant in the <b>__WSManSessionFlags</b> enumeration.
    ///For more information, see Authentication Constants.
    ///Params:
    ///    flags = Specifies the authentication flag to use.
    ///Returns:
    ///    If the method succeeds, it returns the authentication flag. Otherwise, it returns an HRESULT error code.
    ///    
    HRESULT SessionFlagUseCredSsp(int* flags);
    HRESULT EnumerationFlagAssociationInstance(int* flags);
    HRESULT EnumerationFlagAssociatedInstance(int* flags);
    HRESULT SessionFlagSkipRevocationCheck(int* flags);
    HRESULT SessionFlagAllowNegotiateImplicitCredentials(int* flags);
    HRESULT SessionFlagUseSsl(int* flags);
}

///The <b>IWSManConnectionOptions</b> object is passed to the IWSMan::CreateSession method to provide the user name and
///password associated with the local account on the remote computer. If no parameters are supplied, then the
///credentials of the account running the script are the default values.
@GUID("F704E861-9E52-464F-B786-DA5EB2320FDD")
interface IWSManConnectionOptions : IDispatch
{
    ///Sets and gets the user name of a local or a domain account on the remote computer. This property determines the
    ///user name for authentication. If no value is supplied and the <b>WSManFlagCredUsernamePassword</b> flag is not
    ///set, then the user name of the account that is running the script is used. If the
    ///<b>WSManFlagCredUsernamePassword</b> flag is set but no user name is specified, the script prompts the user to
    ///enter the user name and password. If no user name and password are entered then an access denied error is
    ///returned. For more information, see Authentication for Remote Connections. This property is read/write.
    HRESULT get_UserName(BSTR* name);
    ///Sets and gets the user name of a local or a domain account on the remote computer. This property determines the
    ///user name for authentication. If no value is supplied and the <b>WSManFlagCredUsernamePassword</b> flag is not
    ///set, then the user name of the account that is running the script is used. If the
    ///<b>WSManFlagCredUsernamePassword</b> flag is set but no user name is specified, the script prompts the user to
    ///enter the user name and password. If no user name and password are entered then an access denied error is
    ///returned. For more information, see Authentication for Remote Connections. This property is read/write.
    HRESULT put_UserName(BSTR name);
    ///Sets the password of a local or a domain account on the remote computer. For more information, see Authentication
    ///for Remote Connections. This property is write-only.
    HRESULT put_Password(BSTR password);
}

///The <b>IWSManConnectionOptionsEx</b> object is passed to the IWSMan::CreateSession method to provide the thumbprint
///of the client certificate used for authentication.
@GUID("EF43EDF7-2A48-4D93-9526-8BD6AB6D4A6B")
interface IWSManConnectionOptionsEx : IWSManConnectionOptions
{
    ///Sets or gets the certificate thumbprint to use when authenticating by using client certificate authentication.
    ///This property is read/write.
    HRESULT get_CertificateThumbprint(BSTR* thumbprint);
    ///Sets or gets the certificate thumbprint to use when authenticating by using client certificate authentication.
    ///This property is read/write.
    HRESULT put_CertificateThumbprint(BSTR thumbprint);
}

///The <b>IWSManConnectionOptionsEx2</b> object is passed to the IWSMan::CreateSession method to provide the
///authentication mechanism, access type, and credentials to connect to a proxy server.
@GUID("F500C9EC-24EE-48AB-B38D-FC9A164C658E")
interface IWSManConnectionOptionsEx2 : IWSManConnectionOptionsEx
{
    ///Sets the proxy information for the session.
    ///Params:
    ///    accessType = Specifies the proxy access type. This parameter must be set to one of the values in the
    ///                 WSManProxyAccessTypeFlags enumeration. The default value is <b>WSManProxyWinHttpConfig</b>.
    ///    authenticationMechanism = Specifies the authentication mechanism to use for the proxy. This parameter is optional and the default value
    ///                              is 0. If this parameter is set to 0, the WinRM client chooses either Kerberos or Negotiate. Otherwise, this
    ///                              parameter must be set to one of the values in the WSManProxyAuthenticationFlags enumeration. The default
    ///                              value from the enumeration is <b>WSManFlagProxyAuthenticationUseNegotiate</b>.
    ///    userName = Specifies the user name for proxy authentication. This parameter is optional. If a value is not specified for
    ///               this parameter, the default credentials are used.
    ///    password = Specifies the password for proxy authentication. This parameter is optional. If a value is not specified for
    ///               this parameter, the default credentials are used.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetProxy(int accessType, int authenticationMechanism, BSTR userName, BSTR password);
    ///Returns the value of the proxy access type flag <b>WSManProxyIEConfig</b> for use in the <i>accessType</i>
    ///parameter of the IWSManConnectionOptionsEx2::SetProxy method.
    ///Params:
    ///    value = Specifies the value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProxyIEConfig(int* value);
    ///Returns the value of the proxy access type flag <b>WSManProxyWinHttpConfig</b> for use in the <i>accessType</i>
    ///parameter of the IWSManConnectionOptionsEx2::SetProxy method.
    ///Params:
    ///    value = Specifies the value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProxyWinHttpConfig(int* value);
    ///Returns the value of the proxy access type flag <b>WSManProxyAutoDetect</b> for use in the <i>accessType</i>
    ///parameter of the IWSManConnectionOptionsEx2::SetProxy method.
    ///Params:
    ///    value = Specifies the value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProxyAutoDetect(int* value);
    ///Returns the value of the proxy access type flag <b>WSManProxyNoProxyServer</b> for use in the <i>accessType</i>
    ///parameter of the IWSManConnectionOptionsEx2::SetProxy method.
    ///Params:
    ///    value = Specifies the value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProxyNoProxyServer(int* value);
    ///Returns the value of the proxy authentication flag <b>WSManFlagProxyAuthenticationUseNegotiate</b> for use in the
    ///<i>authenticationMechanism</i> parameter of the IWSManConnectionOptionsEx2::SetProxy method.
    ///Params:
    ///    value = Specifies the value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProxyAuthenticationUseNegotiate(int* value);
    ///Returns the value of the proxy authentication flag <b>WSManFlagProxyAuthenticationUseBasic</b> for use in the
    ///<i>authenticationMechanism</i> parameter of the IWSManConnectionOptionsEx2::SetProxy method.
    ///Params:
    ///    value = Specifies the value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProxyAuthenticationUseBasic(int* value);
    ///Returns the value of the proxy authentication flag <b>WSManFlagProxyAuthenticationUseDigest</b> for use in the
    ///<i>authenticationMechanism</i> parameter of the IWSManConnectionOptionsEx2::SetProxy method.
    ///Params:
    ///    value = Specifies the value of the constant.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ProxyAuthenticationUseDigest(int* value);
}

///Defines operations and session settings. Any Windows Remote Management operations require creation of an
///<b>IWSManSession</b> object that connects to a remote computer, base management controller (BMC), or the local
///computer. WinRM network operations include getting, writing, enumerating data, or invoking methods. The methods of
///the <b>IWSManSession</b> object mirror the basic operations defined in the WS-Management protocol.
@GUID("FC84FC58-1286-40C4-9DA0-C8EF6EC241E0")
interface IWSManSession : IDispatch
{
    ///Retrieves the resource specified by the URI and returns an XML representation of the current instance of the
    ///resource.
    ///Params:
    ///    resourceUri = The identifier of the resource to be retrieved. This parameter can contain one of the following: <ul> <li>URI
    ///                  with or without selectors. When calling the Get method to obtain a WMI resource, use the key property or
    ///                  properties of the object.</li> <li> ResourceLocator object which may contain selectors, fragments, or
    ///                  options.</li> <li>WS-Addressing endpoint reference as described in the WS-Management protocol standard. For
    ///                  more information about the public specification for the WS-Management protocol, see Management Specifications
    ///                  Index Page.</li> </ul>
    ///    flags = Reserved for future use. Must be set to 0.
    ///    resource = A value that, upon success, is an XML representation of the resource.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Get(VARIANT resourceUri, int flags, BSTR* resource);
    ///Updates a resource.
    ///Params:
    ///    resourceUri = The identifier of the resource to be updated. This parameter can contain one of the following: <ul> <li>URI
    ///                  with or without selectors. When calling the <b>Put</b> method to obtain a WMI resource, use the key property
    ///                  or properties of the object.</li> <li> ResourceLocator object which may contain selectors, fragments, or
    ///                  options.</li> <li>WS-Addressing endpoint reference as described in the WS-Management protocol standard. For
    ///                  more information about the public specification for the WS-Management protocol, see Management Specifications
    ///                  Index Page.</li> </ul>
    ///    resource = The updated resource content.
    ///    flags = Reserved for future use. Must be set to 0.
    ///    resultResource = The XML stream that contains the updated resource content.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Put(VARIANT resourceUri, BSTR resource, int flags, BSTR* resultResource);
    ///Creates a new instance of a resource and returns the endpoint reference (EPR) of the new object.
    ///Params:
    ///    resourceUri = The identifier of the resource to create. This parameter can contain one of the following: <ul> <li>URI with
    ///                  one or more selectors. Be aware that the WMI plug-in does not support creating any resource other than a
    ///                  WS-Management protocol listener.</li> <li> ResourceLocator object which may contain selectors, fragments, or
    ///                  options.</li> <li>WS-Addressing endpoint reference as described in the WS-Management protocol standard. For
    ///                  more information about the public specification for the WS-Management protocol, see Management Specifications
    ///                  Index Page.</li> </ul>
    ///    resource = An XML string that contains resource content.
    ///    flags = Reserved. Must be set to 0.
    ///    newUri = The EPR of the new resource.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Create(VARIANT resourceUri, BSTR resource, int flags, BSTR* newUri);
    ///Deletes the resource specified in the resource URI.
    ///Params:
    ///    resourceUri = The URI of the resource to be deleted. You can also use an IWSManResourceLocator object to specify the
    ///                  resource.
    ///    flags = Reserved for future use. Must be set to 0.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Delete(VARIANT resourceUri, int flags);
    ///Invokes a method and returns the results of the method call.
    ///Params:
    ///    actionUri = The URI of the method to invoke.
    ///    resourceUri = The identifier of the resource to invoke a method. This parameter can contain one of the following: <ul>
    ///                  <li>URI with or without selectors.</li> <li> ResourceLocator object which may contain selectors, fragments,
    ///                  or options.</li> <li>WS-Addressing endpoint reference as described in the WS-Management protocol standard.
    ///                  For more information about the public specification for the WS-Management protocol, see Management
    ///                  Specifications Index Page.</li> </ul>
    ///    parameters = An XML representation of the input for the method. This string must be supplied or this method will fail.
    ///    flags = Reserved for future use. Must be set to 0.
    ///    result = An XML representation of the method output.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Invoke(BSTR actionUri, VARIANT resourceUri, BSTR parameters, int flags, BSTR* result);
    ///Enumerates a table, data collection, or log resource. To create a query, include a <i>filter</i> parameter and a
    ///<i>dialect</i> parameter in an enumeration. You can also use an IWSManResourceLocator object to create queries.
    ///For more information, see Enumerating or Listing All the Instances of a Resource.
    ///Params:
    ///    resourceUri = The identifier of the resource to be retrieved. The following list contains identifiers that this parameter
    ///                  can contain: <ul> <li>URI with one or more selectors. When calling the <b>Enumerate</b> method to obtain a
    ///                  WMI resource, use the key property or properties of the object.</li> <li>You can use selectors, fragments, or
    ///                  options. For more information, see IWSManResourceLocator.</li> <li>WS-Addressing endpoint reference as
    ///                  described in the WS-Management protocol standard. For more information about the public specification for the
    ///                  WS-Management protocol, see the Management Specifications Index Page.</li> </ul>
    ///    filter = A filter that defines what items in the resource are returned by the enumeration. When the resource is
    ///             enumerated, only those items that match the filter criteria are returned. Including a <i>filter</i> parameter
    ///             and a <i>dialect</i> parameter in an enumeration converts the enumeration into a query. If you have an
    ///             IWSManResourceLocator object for the <i>resourceURI</i> parameter, then this parameter should not be used.
    ///             Instead, use the selector and fragment functionality of <b>IWSManResourceLocator</b>.
    ///    dialect = The language used by the filter. WQL, a subset of SQL used by WMI, is the only language supported. If you
    ///              have a IWSManResourceLocator object for the <i>resourceURI</i> parameter, then this parameter should not be
    ///              used. Instead, use the selector and fragment functionality of <b>IWSManResourceLocator</b>.
    ///    flags = This parameter must contain a flag in the <b>__WSManEnumFlags</b> enumeration. For more information, see
    ///            Enumeration Constants.
    ///    resultSet = An IWSManEnumerator object that contains the results of the enumeration.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Enumerate(VARIANT resourceUri, BSTR filter, BSTR dialect, int flags, IDispatch* resultSet);
    ///The <b>IWSManSession::Identify</b> method queries a remote computer to determine if it supports the WS-Management
    ///protocol. For more information, see Detecting Whether a Remote Computer Supports WS-Management Protocol.
    ///Params:
    ///    flags = The only flag that is accepted is <b>WSManFlagUseNoAuthentication</b>.
    ///    result = A value that, upon success, is an XML string that specifies the WS-Management protocol version, the operating
    ///             system vendor and, if the request was sent authenticated, the operating system version.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Identify(int flags, BSTR* result);
    ///Gets additional error information in an XML stream for the preceding call to an IWSManSession object method. This
    ///property is read-only.
    HRESULT get_Error(BSTR* value);
    ///Sets and gets the number of items in each enumeration batch. This value cannot be changed during an enumeration.
    ///The resource provider may set a limit. This property is read/write.
    HRESULT get_BatchItems(int* value);
    ///Sets and gets the number of items in each enumeration batch. This value cannot be changed during an enumeration.
    ///The resource provider may set a limit. This property is read/write.
    HRESULT put_BatchItems(int value);
    ///Sets and gets the maximum amount of time, in milliseconds, that the client application waits for Windows Remote
    ///Management to complete its operations. This property is read/write.
    HRESULT get_Timeout(int* value);
    ///Sets and gets the maximum amount of time, in milliseconds, that the client application waits for Windows Remote
    ///Management to complete its operations. This property is read/write.
    HRESULT put_Timeout(int value);
}

///Represents a stream of results returned from operations such as a WS-Management protocol WS-Enumeration:Enumerate
///operation.
@GUID("F3457CA9-ABB9-4FA5-B850-90E8CA300E7F")
interface IWSManEnumerator : IDispatch
{
    ///Retrieves an item from the resource and returns an XML representation of the item.
    ///Params:
    ///    resource = The XML representation of the item.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReadItem(BSTR* resource);
    ///Indicates that the end of items in the IWSManEnumerator object has been reached by calls to
    ///IWSManEnumerator::ReadItem. This property is read-only.
    HRESULT get_AtEndOfStream(short* eos);
    ///Gets an XML representation of additional error information. This property is read-only.
    HRESULT get_Error(BSTR* value);
}

///Supplies the path to a resource. You can use an <b>IWSManResourceLocator</b> object instead of a resource URI in
///IWSManSession object operations such as IWSManSession.Get, IWSManSession.Put, or IWSManSession.Enumerate.
@GUID("A7A1BA28-DE41-466A-AD0A-C4059EAD7428")
interface IWSManResourceLocator : IDispatch
{
    ///The resource URI of the requested resource. This property can contain only the path, not a query string for
    ///specific instances. This property is read/write.
    HRESULT put_ResourceURI(BSTR uri);
    ///The resource URI of the requested resource. This property can contain only the path, not a query string for
    ///specific instances. This property is read/write.
    HRESULT get_ResourceURI(BSTR* uri);
    ///Adds a selector to the ResourceLocator object. The selector specifies a particular instance of a <i>resource</i>.
    ///You can provide an IWSManResourceLocator object instead of specifying a resource URI in IWSManSession object
    ///operations such as Get, Put, or Enumerate.
    ///Params:
    ///    resourceSelName = The selector name. For example, when requesting WMI data, this parameter is the key property for a WMI class.
    ///    selValue = The selector value. For example, for WMI data, this parameter contains a value for a key property that
    ///               identifies a specific instance.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddSelector(BSTR resourceSelName, VARIANT selValue);
    ///Removes all the selectors from a ResourceLocator object. You can provide a ResourceLocator object instead of
    ///specifying a resource URI in IWSManSession object operations such as Get, Put, or Enumerate.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ClearSelectors();
    ///Gets or sets the path for a resource fragment or property when ResourceLocator is used in IWSManSession object
    ///methods such as Get, Put, or Enumerate. A fragment represents one property or part of a resource. You can provide
    ///an IWSManResourceLocator object instead of specifying a resource URI in IWSManSession object operations. This
    ///property is read/write.
    HRESULT get_FragmentPath(BSTR* text);
    ///Gets or sets the path for a resource fragment or property when ResourceLocator is used in IWSManSession object
    ///methods such as Get, Put, or Enumerate. A fragment represents one property or part of a resource. You can provide
    ///an IWSManResourceLocator object instead of specifying a resource URI in IWSManSession object operations. This
    ///property is read/write.
    HRESULT put_FragmentPath(BSTR text);
    ///Gets or sets the language dialect for a resource fragment <i>dialect</i> when IWSManResourceLocator is used in
    ///IWSManSession object methods such as Get, Put, or Enumerate. A fragment represents one property or part of a
    ///resource. You can provide an IWSManResourceLocator object instead of specifying a resource URI in IWSManSession
    ///object operations. This property is read/write.
    HRESULT get_FragmentDialect(BSTR* text);
    ///Gets or sets the language dialect for a resource fragment <i>dialect</i> when IWSManResourceLocator is used in
    ///IWSManSession object methods such as Get, Put, or Enumerate. A fragment represents one property or part of a
    ///resource. You can provide an IWSManResourceLocator object instead of specifying a resource URI in IWSManSession
    ///object operations. This property is read/write.
    HRESULT put_FragmentDialect(BSTR text);
    ///Adds data required to process the request. For example, some WMI providers may require an IWbemContext or
    ///SWbemNamedValueSet object with provider-specific information. You can provide a ResourceLocator object instead of
    ///specifying a resource URI in IWSManSession object operations such as Get, Put, or Enumerate.
    ///Params:
    ///    OptionName = The name of the optional data object.
    ///    OptionValue = A value supplied for the optional data object.
    ///    mustComply = A flag that indicates the option must be processed. The default is <b>False</b> (0).
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddOption(BSTR OptionName, VARIANT OptionValue, BOOL mustComply);
    ///Gets or sets the <b>MustUnderstandOptions</b> value for the ResourceLocator object. You can provide an
    ///IWSManResourceLocator object instead of specifying a resource URI in IWSManSession object operations such as Get,
    ///Put, or Enumerate. This property is read/write.
    HRESULT put_MustUnderstandOptions(BOOL mustUnderstand);
    ///Gets or sets the <b>MustUnderstandOptions</b> value for the ResourceLocator object. You can provide an
    ///IWSManResourceLocator object instead of specifying a resource URI in IWSManSession object operations such as Get,
    ///Put, or Enumerate. This property is read/write.
    HRESULT get_MustUnderstandOptions(int* mustUnderstand);
    ///Removes any options from the ResourceLocator object. You can provide a ResourceLocator object instead of
    ///specifying a resource URI in IWSManSession object operations such as Get, Put, or Enumerate.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ClearOptions();
    ///Gets an XML representation of additional error information. This property is read-only.
    HRESULT get_Error(BSTR* value);
}

@GUID("EFFAEAD7-7EC8-4716-B9BE-F2E7E9FB4ADB")
interface IWSManResourceLocatorInternal : IUnknown
{
}

@GUID("04AE2B1D-9954-4D99-94A9-A961E72C3A13")
interface IWSManInternal : IDispatch
{
    HRESULT ConfigSDDL(IDispatch session, VARIANT resourceUri, int flags, BSTR* resource);
}


// GUIDs

const GUID CLSID_WSMan         = GUIDOF!WSMan;
const GUID CLSID_WSManInternal = GUIDOF!WSManInternal;

const GUID IID_IWSMan                        = GUIDOF!IWSMan;
const GUID IID_IWSManConnectionOptions       = GUIDOF!IWSManConnectionOptions;
const GUID IID_IWSManConnectionOptionsEx     = GUIDOF!IWSManConnectionOptionsEx;
const GUID IID_IWSManConnectionOptionsEx2    = GUIDOF!IWSManConnectionOptionsEx2;
const GUID IID_IWSManEnumerator              = GUIDOF!IWSManEnumerator;
const GUID IID_IWSManEx                      = GUIDOF!IWSManEx;
const GUID IID_IWSManEx2                     = GUIDOF!IWSManEx2;
const GUID IID_IWSManEx3                     = GUIDOF!IWSManEx3;
const GUID IID_IWSManInternal                = GUIDOF!IWSManInternal;
const GUID IID_IWSManResourceLocator         = GUIDOF!IWSManResourceLocator;
const GUID IID_IWSManResourceLocatorInternal = GUIDOF!IWSManResourceLocatorInternal;
const GUID IID_IWSManSession                 = GUIDOF!IWSManSession;
