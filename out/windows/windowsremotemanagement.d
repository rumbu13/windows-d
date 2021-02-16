module windows.windowsremotemanagement;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


enum WSManDataType : int
{
    WSMAN_DATA_NONE        = 0x00000000,
    WSMAN_DATA_TYPE_TEXT   = 0x00000001,
    WSMAN_DATA_TYPE_BINARY = 0x00000002,
    WSMAN_DATA_TYPE_DWORD  = 0x00000004,
}

enum WSManAuthenticationFlags : int
{
    WSMAN_FLAG_DEFAULT_AUTHENTICATION  = 0x00000000,
    WSMAN_FLAG_NO_AUTHENTICATION       = 0x00000001,
    WSMAN_FLAG_AUTH_DIGEST             = 0x00000002,
    WSMAN_FLAG_AUTH_NEGOTIATE          = 0x00000004,
    WSMAN_FLAG_AUTH_BASIC              = 0x00000008,
    WSMAN_FLAG_AUTH_KERBEROS           = 0x00000010,
    WSMAN_FLAG_AUTH_CREDSSP            = 0x00000080,
    WSMAN_FLAG_AUTH_CLIENT_CERTIFICATE = 0x00000020,
}

enum WSManProxyAccessType : int
{
    WSMAN_OPTION_PROXY_IE_PROXY_CONFIG      = 0x00000001,
    WSMAN_OPTION_PROXY_WINHTTP_PROXY_CONFIG = 0x00000002,
    WSMAN_OPTION_PROXY_AUTO_DETECT          = 0x00000004,
    WSMAN_OPTION_PROXY_NO_PROXY_SERVER      = 0x00000008,
}

enum WSManSessionOption : int
{
    WSMAN_OPTION_DEFAULT_OPERATION_TIMEOUTMS          = 0x00000001,
    WSMAN_OPTION_MAX_RETRY_TIME                       = 0x0000000b,
    WSMAN_OPTION_TIMEOUTMS_CREATE_SHELL               = 0x0000000c,
    WSMAN_OPTION_TIMEOUTMS_RUN_SHELL_COMMAND          = 0x0000000d,
    WSMAN_OPTION_TIMEOUTMS_RECEIVE_SHELL_OUTPUT       = 0x0000000e,
    WSMAN_OPTION_TIMEOUTMS_SEND_SHELL_INPUT           = 0x0000000f,
    WSMAN_OPTION_TIMEOUTMS_SIGNAL_SHELL               = 0x00000010,
    WSMAN_OPTION_TIMEOUTMS_CLOSE_SHELL                = 0x00000011,
    WSMAN_OPTION_SKIP_CA_CHECK                        = 0x00000012,
    WSMAN_OPTION_SKIP_CN_CHECK                        = 0x00000013,
    WSMAN_OPTION_UNENCRYPTED_MESSAGES                 = 0x00000014,
    WSMAN_OPTION_UTF16                                = 0x00000015,
    WSMAN_OPTION_ENABLE_SPN_SERVER_PORT               = 0x00000016,
    WSMAN_OPTION_MACHINE_ID                           = 0x00000017,
    WSMAN_OPTION_LOCALE                               = 0x00000019,
    WSMAN_OPTION_UI_LANGUAGE                          = 0x0000001a,
    WSMAN_OPTION_MAX_ENVELOPE_SIZE_KB                 = 0x0000001c,
    WSMAN_OPTION_SHELL_MAX_DATA_SIZE_PER_MESSAGE_KB   = 0x0000001d,
    WSMAN_OPTION_REDIRECT_LOCATION                    = 0x0000001e,
    WSMAN_OPTION_SKIP_REVOCATION_CHECK                = 0x0000001f,
    WSMAN_OPTION_ALLOW_NEGOTIATE_IMPLICIT_CREDENTIALS = 0x00000020,
    WSMAN_OPTION_USE_SSL                              = 0x00000021,
    WSMAN_OPTION_USE_INTEARACTIVE_TOKEN               = 0x00000022,
}

enum WSManCallbackFlags : int
{
    WSMAN_FLAG_CALLBACK_END_OF_OPERATION                       = 0x00000001,
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

enum WSManProxyAccessTypeFlags : int
{
    WSManProxyIEConfig      = 0x00000001,
    WSManProxyWinHttpConfig = 0x00000002,
    WSManProxyAutoDetect    = 0x00000004,
    WSManProxyNoProxyServer = 0x00000008,
}

enum WSManProxyAuthenticationFlags : int
{
    WSManFlagProxyAuthenticationUseNegotiate = 0x00000001,
    WSManFlagProxyAuthenticationUseBasic     = 0x00000002,
    WSManFlagProxyAuthenticationUseDigest    = 0x00000004,
}

// Callbacks

alias WSMAN_SHELL_COMPLETION_FUNCTION = void function(void* operationContext, uint flags, WSMAN_ERROR* error, 
                                                      WSMAN_SHELL* shell, WSMAN_COMMAND* command, 
                                                      WSMAN_OPERATION* operationHandle, WSMAN_RESPONSE_DATA* data);
alias WSMAN_PLUGIN_RELEASE_SHELL_CONTEXT = void function(void* shellContext);
alias WSMAN_PLUGIN_RELEASE_COMMAND_CONTEXT = void function(void* shellContext, void* commandContext);
alias WSMAN_PLUGIN_STARTUP = uint function(uint flags, const(wchar)* applicationIdentification, 
                                           const(wchar)* extraInfo, void** pluginContext);
alias WSMAN_PLUGIN_SHUTDOWN = uint function(void* pluginContext, uint flags, uint reason);
alias WSMAN_PLUGIN_SHELL = void function(void* pluginContext, WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, 
                                         WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, 
                                         WSMAN_DATA* inboundShellInformation);
alias WSMAN_PLUGIN_COMMAND = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                           const(wchar)* commandLine, WSMAN_COMMAND_ARG_SET* arguments);
alias WSMAN_PLUGIN_SEND = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                        void* commandContext, const(wchar)* stream, WSMAN_DATA* inboundData);
alias WSMAN_PLUGIN_RECEIVE = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                           void* commandContext, WSMAN_STREAM_ID_SET* streamSet);
alias WSMAN_PLUGIN_SIGNAL = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                          void* commandContext, const(wchar)* code);
alias WSMAN_PLUGIN_CONNECT = void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, 
                                           void* commandContext, WSMAN_DATA* inboundConnectInformation);
alias WSMAN_PLUGIN_AUTHORIZE_USER = void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, 
                                                  uint flags);
alias WSMAN_PLUGIN_AUTHORIZE_OPERATION = void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, 
                                                       uint flags, uint operation, const(wchar)* action, 
                                                       const(wchar)* resourceUri);
alias WSMAN_PLUGIN_AUTHORIZE_QUERY_QUOTA = void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, 
                                                         uint flags);
alias WSMAN_PLUGIN_AUTHORIZE_RELEASE_CONTEXT = void function(void* userAuthorizationContext);

// Structs


struct WSMAN_DATA_TEXT
{
    uint          bufferLength;
    const(wchar)* buffer;
}

struct WSMAN_DATA_BINARY
{
    uint   dataLength;
    ubyte* data;
}

struct WSMAN_DATA
{
    WSManDataType type;
    union
    {
        WSMAN_DATA_TEXT   text;
        WSMAN_DATA_BINARY binaryData;
        uint              number;
    }
}

struct WSMAN_ERROR
{
    uint          code;
    const(wchar)* errorDetail;
    const(wchar)* language;
    const(wchar)* machineName;
    const(wchar)* pluginName;
}

struct WSMAN_USERNAME_PASSWORD_CREDS
{
    const(wchar)* username;
    const(wchar)* password;
}

struct WSMAN_AUTHENTICATION_CREDENTIALS
{
    uint authenticationMechanism;
    union
    {
        WSMAN_USERNAME_PASSWORD_CREDS userAccount;
        const(wchar)* certificateThumbprint;
    }
}

struct WSMAN_OPTION
{
    const(wchar)* name;
    const(wchar)* value;
    BOOL          mustComply;
}

struct WSMAN_OPTION_SET
{
    uint          optionsCount;
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

struct WSMAN_KEY
{
    const(wchar)* key;
    const(wchar)* value;
}

struct WSMAN_SELECTOR_SET
{
    uint       numberKeys;
    WSMAN_KEY* keys;
}

struct WSMAN_FRAGMENT
{
    const(wchar)* path;
    const(wchar)* dialect;
}

struct WSMAN_FILTER
{
    const(wchar)* filter;
    const(wchar)* dialect;
}

struct WSMAN_OPERATION_INFO
{
    WSMAN_FRAGMENT     fragment;
    WSMAN_FILTER       filter;
    WSMAN_SELECTOR_SET selectorSet;
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

struct WSMAN_PROXY_INFO
{
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

struct WSMAN_STREAM_ID_SET
{
    uint     streamIDsCount;
    ushort** streamIDs;
}

struct WSMAN_ENVIRONMENT_VARIABLE
{
    const(wchar)* name;
    const(wchar)* value;
}

struct WSMAN_ENVIRONMENT_VARIABLE_SET
{
    uint varsCount;
    WSMAN_ENVIRONMENT_VARIABLE* vars;
}

struct WSMAN_SHELL_STARTUP_INFO_V10
{
    WSMAN_STREAM_ID_SET* inputStreamSet;
    WSMAN_STREAM_ID_SET* outputStreamSet;
    uint                 idleTimeoutMs;
    const(wchar)*        workingDirectory;
    WSMAN_ENVIRONMENT_VARIABLE_SET* variableSet;
}

struct WSMAN_SHELL_STARTUP_INFO_V11
{
    WSMAN_SHELL_STARTUP_INFO_V10 __AnonymousBase_wsman_L665_C48;
    const(wchar)* name;
}

struct WSMAN_SHELL_DISCONNECT_INFO
{
    uint idleTimeoutMs;
}

struct WSMAN_RECEIVE_DATA_RESULT
{
    const(wchar)* streamId;
    WSMAN_DATA    streamData;
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

union WSMAN_RESPONSE_DATA
{
    WSMAN_RECEIVE_DATA_RESULT receiveData;
    WSMAN_CONNECT_DATA connectData;
    WSMAN_CREATE_SHELL_DATA createData;
}

struct WSMAN_SHELL_ASYNC
{
    void* operationContext;
    WSMAN_SHELL_COMPLETION_FUNCTION completionFunction;
}

struct WSMAN_COMMAND_ARG_SET
{
    uint     argsCount;
    ushort** args;
}

struct WSMAN_CERTIFICATE_DETAILS
{
    const(wchar)* subject;
    const(wchar)* issuerName;
    const(wchar)* issuerThumbprint;
    const(wchar)* subjectName;
}

struct WSMAN_SENDER_DETAILS
{
    const(wchar)* senderName;
    const(wchar)* authenticationMechanism;
    WSMAN_CERTIFICATE_DETAILS* certificateDetails;
    HANDLE        clientToken;
    const(wchar)* httpURL;
}

struct WSMAN_PLUGIN_REQUEST
{
    WSMAN_SENDER_DETAILS* senderDetails;
    const(wchar)* locale;
    const(wchar)* resourceUri;
    WSMAN_OPERATION_INFO* operationInfo;
    int           shutdownNotification;
    HANDLE        shutdownNotificationHandle;
    const(wchar)* dataLocale;
}

struct WSMAN_AUTHZ_QUOTA
{
    uint maxAllowedConcurrentShells;
    uint maxAllowedConcurrentOperations;
    uint timeslotSize;
    uint maxAllowedOperationsPerTimeslot;
}

// Functions

@DllImport("WsmSvc")
uint WSManInitialize(uint flags, WSMAN_API** apiHandle);

@DllImport("WsmSvc")
uint WSManDeinitialize(WSMAN_API* apiHandle, uint flags);

@DllImport("WsmSvc")
uint WSManGetErrorMessage(WSMAN_API* apiHandle, uint flags, const(wchar)* languageCode, uint errorCode, 
                          uint messageLength, const(wchar)* message, uint* messageLengthUsed);

@DllImport("WsmSvc")
uint WSManCreateSession(WSMAN_API* apiHandle, const(wchar)* connection, uint flags, 
                        WSMAN_AUTHENTICATION_CREDENTIALS* serverAuthenticationCredentials, 
                        WSMAN_PROXY_INFO* proxyInfo, WSMAN_SESSION** session);

@DllImport("WsmSvc")
uint WSManCloseSession(WSMAN_SESSION* session, uint flags);

@DllImport("WsmSvc")
uint WSManSetSessionOption(WSMAN_SESSION* session, WSManSessionOption option, WSMAN_DATA* data);

@DllImport("WsmSvc")
uint WSManGetSessionOptionAsDword(WSMAN_SESSION* session, WSManSessionOption option, uint* value);

@DllImport("WsmSvc")
uint WSManGetSessionOptionAsString(WSMAN_SESSION* session, WSManSessionOption option, uint stringLength, 
                                   const(wchar)* string, uint* stringLengthUsed);

@DllImport("WsmSvc")
uint WSManCloseOperation(WSMAN_OPERATION* operationHandle, uint flags);

@DllImport("WsmSvc")
void WSManCreateShell(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, 
                      WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, WSMAN_OPTION_SET* options, WSMAN_DATA* createXml, 
                      WSMAN_SHELL_ASYNC* async, WSMAN_SHELL** shell);

@DllImport("WsmSvc")
void WSManRunShellCommand(WSMAN_SHELL* shell, uint flags, const(wchar)* commandLine, WSMAN_COMMAND_ARG_SET* args, 
                          WSMAN_OPTION_SET* options, WSMAN_SHELL_ASYNC* async, WSMAN_COMMAND** command);

@DllImport("WsmSvc")
void WSManSignalShell(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, const(wchar)* code, 
                      WSMAN_SHELL_ASYNC* async, WSMAN_OPERATION** signalOperation);

@DllImport("WsmSvc")
void WSManReceiveShellOutput(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, 
                             WSMAN_STREAM_ID_SET* desiredStreamSet, WSMAN_SHELL_ASYNC* async, 
                             WSMAN_OPERATION** receiveOperation);

@DllImport("WsmSvc")
void WSManSendShellInput(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, const(wchar)* streamId, 
                         WSMAN_DATA* streamData, BOOL endOfStream, WSMAN_SHELL_ASYNC* async, 
                         WSMAN_OPERATION** sendOperation);

@DllImport("WsmSvc")
void WSManCloseCommand(WSMAN_COMMAND* commandHandle, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc")
void WSManCloseShell(WSMAN_SHELL* shellHandle, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc")
void WSManCreateShellEx(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, const(wchar)* shellId, 
                        WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, WSMAN_OPTION_SET* options, WSMAN_DATA* createXml, 
                        WSMAN_SHELL_ASYNC* async, WSMAN_SHELL** shell);

@DllImport("WsmSvc")
void WSManRunShellCommandEx(WSMAN_SHELL* shell, uint flags, const(wchar)* commandId, const(wchar)* commandLine, 
                            WSMAN_COMMAND_ARG_SET* args, WSMAN_OPTION_SET* options, WSMAN_SHELL_ASYNC* async, 
                            WSMAN_COMMAND** command);

@DllImport("WsmSvc")
void WSManDisconnectShell(WSMAN_SHELL* shell, uint flags, WSMAN_SHELL_DISCONNECT_INFO* disconnectInfo, 
                          WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc")
void WSManReconnectShell(WSMAN_SHELL* shell, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc")
void WSManReconnectShellCommand(WSMAN_COMMAND* commandHandle, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc")
void WSManConnectShell(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, const(wchar)* shellID, 
                       WSMAN_OPTION_SET* options, WSMAN_DATA* connectXml, WSMAN_SHELL_ASYNC* async, 
                       WSMAN_SHELL** shell);

@DllImport("WsmSvc")
void WSManConnectShellCommand(WSMAN_SHELL* shell, uint flags, const(wchar)* commandID, WSMAN_OPTION_SET* options, 
                              WSMAN_DATA* connectXml, WSMAN_SHELL_ASYNC* async, WSMAN_COMMAND** command);

@DllImport("WsmSvc")
uint WSManPluginReportContext(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* context);

@DllImport("WsmSvc")
uint WSManPluginReceiveResult(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, const(wchar)* stream, 
                              WSMAN_DATA* streamResult, const(wchar)* commandState, uint exitCode);

@DllImport("WsmSvc")
uint WSManPluginOperationComplete(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, uint errorCode, 
                                  const(wchar)* extendedInformation);

@DllImport("WsmSvc")
uint WSManPluginGetOperationParameters(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, WSMAN_DATA* data);

@DllImport("WsmSvc")
uint WSManPluginGetConfiguration(void* pluginContext, uint flags, WSMAN_DATA* data);

@DllImport("WsmSvc")
uint WSManPluginReportCompletion(void* pluginContext, uint flags);

@DllImport("WsmSvc")
uint WSManPluginFreeRequestDetails(WSMAN_PLUGIN_REQUEST* requestDetails);

@DllImport("WsmSvc")
uint WSManPluginAuthzUserComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, void* userAuthorizationContext, 
                                  HANDLE impersonationToken, BOOL userIsAdministrator, uint errorCode, 
                                  const(wchar)* extendedErrorInformation);

@DllImport("WsmSvc")
uint WSManPluginAuthzOperationComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, 
                                       void* userAuthorizationContext, uint errorCode, 
                                       const(wchar)* extendedErrorInformation);

@DllImport("WsmSvc")
uint WSManPluginAuthzQueryQuotaComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, WSMAN_AUTHZ_QUOTA* quota, 
                                        uint errorCode, const(wchar)* extendedErrorInformation);


// Interfaces

@GUID("BCED617B-EC03-420B-8508-977DC7A686BD")
struct WSMan;

@GUID("7DE087A5-5DCB-4DF7-BB12-0924AD8FBD9A")
struct WSManInternal;

@GUID("190D8637-5CD3-496D-AD24-69636BB5A3B5")
interface IWSMan : IDispatch
{
    HRESULT CreateSession(BSTR connection, int flags, IDispatch connectionOptions, IDispatch* session);
    HRESULT CreateConnectionOptions(IDispatch* connectionOptions);
    HRESULT get_CommandLine(BSTR* value);
    HRESULT get_Error(BSTR* value);
}

@GUID("2D53BDAA-798E-49E6-A1AA-74D01256F411")
interface IWSManEx : IWSMan
{
    HRESULT CreateResourceLocator(BSTR strResourceLocator, IDispatch* newResourceLocator);
    HRESULT SessionFlagUTF8(int* flags);
    HRESULT SessionFlagCredUsernamePassword(int* flags);
    HRESULT SessionFlagSkipCACheck(int* flags);
    HRESULT SessionFlagSkipCNCheck(int* flags);
    HRESULT SessionFlagUseDigest(int* flags);
    HRESULT SessionFlagUseNegotiate(int* flags);
    HRESULT SessionFlagUseBasic(int* flags);
    HRESULT SessionFlagUseKerberos(int* flags);
    HRESULT SessionFlagNoEncryption(int* flags);
    HRESULT SessionFlagEnableSPNServerPort(int* flags);
    HRESULT SessionFlagUseNoAuthentication(int* flags);
    HRESULT EnumerationFlagNonXmlText(int* flags);
    HRESULT EnumerationFlagReturnEPR(int* flags);
    HRESULT EnumerationFlagReturnObjectAndEPR(int* flags);
    HRESULT GetErrorMessage(uint errorNumber, BSTR* errorMessage);
    HRESULT EnumerationFlagHierarchyDeep(int* flags);
    HRESULT EnumerationFlagHierarchyShallow(int* flags);
    HRESULT EnumerationFlagHierarchyDeepBasePropsOnly(int* flags);
    HRESULT EnumerationFlagReturnObject(int* flags);
}

@GUID("1D1B5AE0-42D9-4021-8261-3987619512E9")
interface IWSManEx2 : IWSManEx
{
    HRESULT SessionFlagUseClientCertificate(int* flags);
}

@GUID("6400E966-011D-4EAC-8474-049E0848AFAD")
interface IWSManEx3 : IWSManEx2
{
    HRESULT SessionFlagUTF16(int* flags);
    HRESULT SessionFlagUseCredSsp(int* flags);
    HRESULT EnumerationFlagAssociationInstance(int* flags);
    HRESULT EnumerationFlagAssociatedInstance(int* flags);
    HRESULT SessionFlagSkipRevocationCheck(int* flags);
    HRESULT SessionFlagAllowNegotiateImplicitCredentials(int* flags);
    HRESULT SessionFlagUseSsl(int* flags);
}

@GUID("F704E861-9E52-464F-B786-DA5EB2320FDD")
interface IWSManConnectionOptions : IDispatch
{
    HRESULT get_UserName(BSTR* name);
    HRESULT put_UserName(BSTR name);
    HRESULT put_Password(BSTR password);
}

@GUID("EF43EDF7-2A48-4D93-9526-8BD6AB6D4A6B")
interface IWSManConnectionOptionsEx : IWSManConnectionOptions
{
    HRESULT get_CertificateThumbprint(BSTR* thumbprint);
    HRESULT put_CertificateThumbprint(BSTR thumbprint);
}

@GUID("F500C9EC-24EE-48AB-B38D-FC9A164C658E")
interface IWSManConnectionOptionsEx2 : IWSManConnectionOptionsEx
{
    HRESULT SetProxy(int accessType, int authenticationMechanism, BSTR userName, BSTR password);
    HRESULT ProxyIEConfig(int* value);
    HRESULT ProxyWinHttpConfig(int* value);
    HRESULT ProxyAutoDetect(int* value);
    HRESULT ProxyNoProxyServer(int* value);
    HRESULT ProxyAuthenticationUseNegotiate(int* value);
    HRESULT ProxyAuthenticationUseBasic(int* value);
    HRESULT ProxyAuthenticationUseDigest(int* value);
}

@GUID("FC84FC58-1286-40C4-9DA0-C8EF6EC241E0")
interface IWSManSession : IDispatch
{
    HRESULT Get(VARIANT resourceUri, int flags, BSTR* resource);
    HRESULT Put(VARIANT resourceUri, BSTR resource, int flags, BSTR* resultResource);
    HRESULT Create(VARIANT resourceUri, BSTR resource, int flags, BSTR* newUri);
    HRESULT Delete(VARIANT resourceUri, int flags);
    HRESULT Invoke(BSTR actionUri, VARIANT resourceUri, BSTR parameters, int flags, BSTR* result);
    HRESULT Enumerate(VARIANT resourceUri, BSTR filter, BSTR dialect, int flags, IDispatch* resultSet);
    HRESULT Identify(int flags, BSTR* result);
    HRESULT get_Error(BSTR* value);
    HRESULT get_BatchItems(int* value);
    HRESULT put_BatchItems(int value);
    HRESULT get_Timeout(int* value);
    HRESULT put_Timeout(int value);
}

@GUID("F3457CA9-ABB9-4FA5-B850-90E8CA300E7F")
interface IWSManEnumerator : IDispatch
{
    HRESULT ReadItem(BSTR* resource);
    HRESULT get_AtEndOfStream(short* eos);
    HRESULT get_Error(BSTR* value);
}

@GUID("A7A1BA28-DE41-466A-AD0A-C4059EAD7428")
interface IWSManResourceLocator : IDispatch
{
    HRESULT put_ResourceURI(BSTR uri);
    HRESULT get_ResourceURI(BSTR* uri);
    HRESULT AddSelector(BSTR resourceSelName, VARIANT selValue);
    HRESULT ClearSelectors();
    HRESULT get_FragmentPath(BSTR* text);
    HRESULT put_FragmentPath(BSTR text);
    HRESULT get_FragmentDialect(BSTR* text);
    HRESULT put_FragmentDialect(BSTR text);
    HRESULT AddOption(BSTR OptionName, VARIANT OptionValue, BOOL mustComply);
    HRESULT put_MustUnderstandOptions(BOOL mustUnderstand);
    HRESULT get_MustUnderstandOptions(int* mustUnderstand);
    HRESULT ClearOptions();
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
