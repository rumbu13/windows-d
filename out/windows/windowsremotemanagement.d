module windows.windowsremotemanagement;

public import windows.automation;
public import windows.com;
public import windows.systemservices;

extern(Windows):

struct WSMAN_DATA_TEXT
{
    uint bufferLength;
    const(wchar)* buffer;
}

struct WSMAN_DATA_BINARY
{
    uint dataLength;
    ubyte* data;
}

enum WSManDataType
{
    WSMAN_DATA_NONE = 0,
    WSMAN_DATA_TYPE_TEXT = 1,
    WSMAN_DATA_TYPE_BINARY = 2,
    WSMAN_DATA_TYPE_DWORD = 4,
}

struct WSMAN_DATA
{
    WSManDataType type;
    _Anonymous_e__Union Anonymous;
}

struct WSMAN_ERROR
{
    uint code;
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

enum WSManAuthenticationFlags
{
    WSMAN_FLAG_DEFAULT_AUTHENTICATION = 0,
    WSMAN_FLAG_NO_AUTHENTICATION = 1,
    WSMAN_FLAG_AUTH_DIGEST = 2,
    WSMAN_FLAG_AUTH_NEGOTIATE = 4,
    WSMAN_FLAG_AUTH_BASIC = 8,
    WSMAN_FLAG_AUTH_KERBEROS = 16,
    WSMAN_FLAG_AUTH_CREDSSP = 128,
    WSMAN_FLAG_AUTH_CLIENT_CERTIFICATE = 32,
}

struct WSMAN_AUTHENTICATION_CREDENTIALS
{
    uint authenticationMechanism;
    _Anonymous_e__Union Anonymous;
}

struct WSMAN_OPTION
{
    const(wchar)* name;
    const(wchar)* value;
    BOOL mustComply;
}

struct WSMAN_OPTION_SET
{
    uint optionsCount;
    WSMAN_OPTION* options;
    BOOL optionsMustUnderstand;
}

struct WSMAN_OPTION_SETEX
{
    uint optionsCount;
    WSMAN_OPTION* options;
    BOOL optionsMustUnderstand;
    ushort** optionTypes;
}

struct WSMAN_KEY
{
    const(wchar)* key;
    const(wchar)* value;
}

struct WSMAN_SELECTOR_SET
{
    uint numberKeys;
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
    WSMAN_FRAGMENT fragment;
    WSMAN_FILTER filter;
    WSMAN_SELECTOR_SET selectorSet;
    WSMAN_OPTION_SET optionSet;
    void* reserved;
    uint version;
}

struct WSMAN_OPERATION_INFOEX
{
    WSMAN_FRAGMENT fragment;
    WSMAN_FILTER filter;
    WSMAN_SELECTOR_SET selectorSet;
    WSMAN_OPTION_SETEX optionSet;
    uint version;
    const(wchar)* uiLocale;
    const(wchar)* dataLocale;
}

struct WSMAN_API
{
}

enum WSManProxyAccessType
{
    WSMAN_OPTION_PROXY_IE_PROXY_CONFIG = 1,
    WSMAN_OPTION_PROXY_WINHTTP_PROXY_CONFIG = 2,
    WSMAN_OPTION_PROXY_AUTO_DETECT = 4,
    WSMAN_OPTION_PROXY_NO_PROXY_SERVER = 8,
}

struct WSMAN_PROXY_INFO
{
    uint accessType;
    WSMAN_AUTHENTICATION_CREDENTIALS authenticationCredentials;
}

struct WSMAN_SESSION
{
}

enum WSManSessionOption
{
    WSMAN_OPTION_DEFAULT_OPERATION_TIMEOUTMS = 1,
    WSMAN_OPTION_MAX_RETRY_TIME = 11,
    WSMAN_OPTION_TIMEOUTMS_CREATE_SHELL = 12,
    WSMAN_OPTION_TIMEOUTMS_RUN_SHELL_COMMAND = 13,
    WSMAN_OPTION_TIMEOUTMS_RECEIVE_SHELL_OUTPUT = 14,
    WSMAN_OPTION_TIMEOUTMS_SEND_SHELL_INPUT = 15,
    WSMAN_OPTION_TIMEOUTMS_SIGNAL_SHELL = 16,
    WSMAN_OPTION_TIMEOUTMS_CLOSE_SHELL = 17,
    WSMAN_OPTION_SKIP_CA_CHECK = 18,
    WSMAN_OPTION_SKIP_CN_CHECK = 19,
    WSMAN_OPTION_UNENCRYPTED_MESSAGES = 20,
    WSMAN_OPTION_UTF16 = 21,
    WSMAN_OPTION_ENABLE_SPN_SERVER_PORT = 22,
    WSMAN_OPTION_MACHINE_ID = 23,
    WSMAN_OPTION_LOCALE = 25,
    WSMAN_OPTION_UI_LANGUAGE = 26,
    WSMAN_OPTION_MAX_ENVELOPE_SIZE_KB = 28,
    WSMAN_OPTION_SHELL_MAX_DATA_SIZE_PER_MESSAGE_KB = 29,
    WSMAN_OPTION_REDIRECT_LOCATION = 30,
    WSMAN_OPTION_SKIP_REVOCATION_CHECK = 31,
    WSMAN_OPTION_ALLOW_NEGOTIATE_IMPLICIT_CREDENTIALS = 32,
    WSMAN_OPTION_USE_SSL = 33,
    WSMAN_OPTION_USE_INTEARACTIVE_TOKEN = 34,
}

struct WSMAN_OPERATION
{
}

enum WSManCallbackFlags
{
    WSMAN_FLAG_CALLBACK_END_OF_OPERATION = 1,
    WSMAN_FLAG_CALLBACK_END_OF_STREAM = 8,
    WSMAN_FLAG_CALLBACK_SHELL_SUPPORTS_DISCONNECT = 32,
    WSMAN_FLAG_CALLBACK_SHELL_AUTODISCONNECTED = 64,
    WSMAN_FLAG_CALLBACK_NETWORK_FAILURE_DETECTED = 256,
    WSMAN_FLAG_CALLBACK_RETRYING_AFTER_NETWORK_FAILURE = 512,
    WSMAN_FLAG_CALLBACK_RECONNECTED_AFTER_NETWORK_FAILURE = 1024,
    WSMAN_FLAG_CALLBACK_SHELL_AUTODISCONNECTING = 2048,
    WSMAN_FLAG_CALLBACK_RETRY_ABORTED_DUE_TO_INTERNAL_ERROR = 4096,
    WSMAN_FLAG_CALLBACK_RECEIVE_DELAY_STREAM_REQUEST_PROCESSED = 8192,
}

struct WSMAN_SHELL
{
}

struct WSMAN_COMMAND
{
}

struct WSMAN_STREAM_ID_SET
{
    uint streamIDsCount;
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
    uint idleTimeoutMs;
    const(wchar)* workingDirectory;
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

enum WSManShellFlag
{
    WSMAN_FLAG_NO_COMPRESSION = 1,
    WSMAN_FLAG_DELETE_SERVER_SESSION = 2,
    WSMAN_FLAG_SERVER_BUFFERING_MODE_DROP = 4,
    WSMAN_FLAG_SERVER_BUFFERING_MODE_BLOCK = 8,
    WSMAN_FLAG_RECEIVE_DELAY_OUTPUT_STREAM = 16,
}

struct WSMAN_RECEIVE_DATA_RESULT
{
    const(wchar)* streamId;
    WSMAN_DATA streamData;
    const(wchar)* commandState;
    uint exitCode;
}

struct WSMAN_CONNECT_DATA
{
    WSMAN_DATA data;
}

struct WSMAN_CREATE_SHELL_DATA
{
    WSMAN_DATA data;
}

struct WSMAN_RESPONSE_DATA
{
    WSMAN_RECEIVE_DATA_RESULT receiveData;
    WSMAN_CONNECT_DATA connectData;
    WSMAN_CREATE_SHELL_DATA createData;
}

alias WSMAN_SHELL_COMPLETION_FUNCTION = extern(Windows) void function(void* operationContext, uint flags, WSMAN_ERROR* error, WSMAN_SHELL* shell, WSMAN_COMMAND* command, WSMAN_OPERATION* operationHandle, WSMAN_RESPONSE_DATA* data);
struct WSMAN_SHELL_ASYNC
{
    void* operationContext;
    WSMAN_SHELL_COMPLETION_FUNCTION completionFunction;
}

struct WSMAN_COMMAND_ARG_SET
{
    uint argsCount;
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
    HANDLE clientToken;
    const(wchar)* httpURL;
}

struct WSMAN_PLUGIN_REQUEST
{
    WSMAN_SENDER_DETAILS* senderDetails;
    const(wchar)* locale;
    const(wchar)* resourceUri;
    WSMAN_OPERATION_INFO* operationInfo;
    int shutdownNotification;
    HANDLE shutdownNotificationHandle;
    const(wchar)* dataLocale;
}

alias WSMAN_PLUGIN_RELEASE_SHELL_CONTEXT = extern(Windows) void function(void* shellContext);
alias WSMAN_PLUGIN_RELEASE_COMMAND_CONTEXT = extern(Windows) void function(void* shellContext, void* commandContext);
alias WSMAN_PLUGIN_STARTUP = extern(Windows) uint function(uint flags, const(wchar)* applicationIdentification, const(wchar)* extraInfo, void** pluginContext);
alias WSMAN_PLUGIN_SHUTDOWN = extern(Windows) uint function(void* pluginContext, uint flags, uint reason);
alias WSMAN_PLUGIN_SHELL = extern(Windows) void function(void* pluginContext, WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, WSMAN_DATA* inboundShellInformation);
alias WSMAN_PLUGIN_COMMAND = extern(Windows) void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, const(wchar)* commandLine, WSMAN_COMMAND_ARG_SET* arguments);
alias WSMAN_PLUGIN_SEND = extern(Windows) void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, void* commandContext, const(wchar)* stream, WSMAN_DATA* inboundData);
alias WSMAN_PLUGIN_RECEIVE = extern(Windows) void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, void* commandContext, WSMAN_STREAM_ID_SET* streamSet);
alias WSMAN_PLUGIN_SIGNAL = extern(Windows) void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, void* commandContext, const(wchar)* code);
alias WSMAN_PLUGIN_CONNECT = extern(Windows) void function(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* shellContext, void* commandContext, WSMAN_DATA* inboundConnectInformation);
struct WSMAN_AUTHZ_QUOTA
{
    uint maxAllowedConcurrentShells;
    uint maxAllowedConcurrentOperations;
    uint timeslotSize;
    uint maxAllowedOperationsPerTimeslot;
}

alias WSMAN_PLUGIN_AUTHORIZE_USER = extern(Windows) void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, uint flags);
alias WSMAN_PLUGIN_AUTHORIZE_OPERATION = extern(Windows) void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, uint flags, uint operation, const(wchar)* action, const(wchar)* resourceUri);
alias WSMAN_PLUGIN_AUTHORIZE_QUERY_QUOTA = extern(Windows) void function(void* pluginContext, WSMAN_SENDER_DETAILS* senderDetails, uint flags);
alias WSMAN_PLUGIN_AUTHORIZE_RELEASE_CONTEXT = extern(Windows) void function(void* userAuthorizationContext);
const GUID CLSID_WSMan = {0xBCED617B, 0xEC03, 0x420B, [0x85, 0x08, 0x97, 0x7D, 0xC7, 0xA6, 0x86, 0xBD]};
@GUID(0xBCED617B, 0xEC03, 0x420B, [0x85, 0x08, 0x97, 0x7D, 0xC7, 0xA6, 0x86, 0xBD]);
struct WSMan;

const GUID CLSID_WSManInternal = {0x7DE087A5, 0x5DCB, 0x4DF7, [0xBB, 0x12, 0x09, 0x24, 0xAD, 0x8F, 0xBD, 0x9A]};
@GUID(0x7DE087A5, 0x5DCB, 0x4DF7, [0xBB, 0x12, 0x09, 0x24, 0xAD, 0x8F, 0xBD, 0x9A]);
struct WSManInternal;

enum WSManSessionFlags
{
    WSManFlagUTF8 = 1,
    WSManFlagCredUsernamePassword = 4096,
    WSManFlagSkipCACheck = 8192,
    WSManFlagSkipCNCheck = 16384,
    WSManFlagUseNoAuthentication = 32768,
    WSManFlagUseDigest = 65536,
    WSManFlagUseNegotiate = 131072,
    WSManFlagUseBasic = 262144,
    WSManFlagUseKerberos = 524288,
    WSManFlagNoEncryption = 1048576,
    WSManFlagUseClientCertificate = 2097152,
    WSManFlagEnableSPNServerPort = 4194304,
    WSManFlagUTF16 = 8388608,
    WSManFlagUseCredSsp = 16777216,
    WSManFlagSkipRevocationCheck = 33554432,
    WSManFlagAllowNegotiateImplicitCredentials = 67108864,
    WSManFlagUseSsl = 134217728,
}

enum WSManEnumFlags
{
    WSManFlagNonXmlText = 1,
    WSManFlagReturnObject = 0,
    WSManFlagReturnEPR = 2,
    WSManFlagReturnObjectAndEPR = 4,
    WSManFlagHierarchyDeep = 0,
    WSManFlagHierarchyShallow = 32,
    WSManFlagHierarchyDeepBasePropsOnly = 64,
    WSManFlagAssociatedInstance = 0,
    WSManFlagAssociationInstance = 128,
}

enum WSManProxyAccessTypeFlags
{
    WSManProxyIEConfig = 1,
    WSManProxyWinHttpConfig = 2,
    WSManProxyAutoDetect = 4,
    WSManProxyNoProxyServer = 8,
}

enum WSManProxyAuthenticationFlags
{
    WSManFlagProxyAuthenticationUseNegotiate = 1,
    WSManFlagProxyAuthenticationUseBasic = 2,
    WSManFlagProxyAuthenticationUseDigest = 4,
}

const GUID IID_IWSMan = {0x190D8637, 0x5CD3, 0x496D, [0xAD, 0x24, 0x69, 0x63, 0x6B, 0xB5, 0xA3, 0xB5]};
@GUID(0x190D8637, 0x5CD3, 0x496D, [0xAD, 0x24, 0x69, 0x63, 0x6B, 0xB5, 0xA3, 0xB5]);
interface IWSMan : IDispatch
{
    HRESULT CreateSession(BSTR connection, int flags, IDispatch connectionOptions, IDispatch* session);
    HRESULT CreateConnectionOptions(IDispatch* connectionOptions);
    HRESULT get_CommandLine(BSTR* value);
    HRESULT get_Error(BSTR* value);
}

const GUID IID_IWSManEx = {0x2D53BDAA, 0x798E, 0x49E6, [0xA1, 0xAA, 0x74, 0xD0, 0x12, 0x56, 0xF4, 0x11]};
@GUID(0x2D53BDAA, 0x798E, 0x49E6, [0xA1, 0xAA, 0x74, 0xD0, 0x12, 0x56, 0xF4, 0x11]);
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

const GUID IID_IWSManEx2 = {0x1D1B5AE0, 0x42D9, 0x4021, [0x82, 0x61, 0x39, 0x87, 0x61, 0x95, 0x12, 0xE9]};
@GUID(0x1D1B5AE0, 0x42D9, 0x4021, [0x82, 0x61, 0x39, 0x87, 0x61, 0x95, 0x12, 0xE9]);
interface IWSManEx2 : IWSManEx
{
    HRESULT SessionFlagUseClientCertificate(int* flags);
}

const GUID IID_IWSManEx3 = {0x6400E966, 0x011D, 0x4EAC, [0x84, 0x74, 0x04, 0x9E, 0x08, 0x48, 0xAF, 0xAD]};
@GUID(0x6400E966, 0x011D, 0x4EAC, [0x84, 0x74, 0x04, 0x9E, 0x08, 0x48, 0xAF, 0xAD]);
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

const GUID IID_IWSManConnectionOptions = {0xF704E861, 0x9E52, 0x464F, [0xB7, 0x86, 0xDA, 0x5E, 0xB2, 0x32, 0x0F, 0xDD]};
@GUID(0xF704E861, 0x9E52, 0x464F, [0xB7, 0x86, 0xDA, 0x5E, 0xB2, 0x32, 0x0F, 0xDD]);
interface IWSManConnectionOptions : IDispatch
{
    HRESULT get_UserName(BSTR* name);
    HRESULT put_UserName(BSTR name);
    HRESULT put_Password(BSTR password);
}

const GUID IID_IWSManConnectionOptionsEx = {0xEF43EDF7, 0x2A48, 0x4D93, [0x95, 0x26, 0x8B, 0xD6, 0xAB, 0x6D, 0x4A, 0x6B]};
@GUID(0xEF43EDF7, 0x2A48, 0x4D93, [0x95, 0x26, 0x8B, 0xD6, 0xAB, 0x6D, 0x4A, 0x6B]);
interface IWSManConnectionOptionsEx : IWSManConnectionOptions
{
    HRESULT get_CertificateThumbprint(BSTR* thumbprint);
    HRESULT put_CertificateThumbprint(BSTR thumbprint);
}

const GUID IID_IWSManConnectionOptionsEx2 = {0xF500C9EC, 0x24EE, 0x48AB, [0xB3, 0x8D, 0xFC, 0x9A, 0x16, 0x4C, 0x65, 0x8E]};
@GUID(0xF500C9EC, 0x24EE, 0x48AB, [0xB3, 0x8D, 0xFC, 0x9A, 0x16, 0x4C, 0x65, 0x8E]);
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

const GUID IID_IWSManSession = {0xFC84FC58, 0x1286, 0x40C4, [0x9D, 0xA0, 0xC8, 0xEF, 0x6E, 0xC2, 0x41, 0xE0]};
@GUID(0xFC84FC58, 0x1286, 0x40C4, [0x9D, 0xA0, 0xC8, 0xEF, 0x6E, 0xC2, 0x41, 0xE0]);
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

const GUID IID_IWSManEnumerator = {0xF3457CA9, 0xABB9, 0x4FA5, [0xB8, 0x50, 0x90, 0xE8, 0xCA, 0x30, 0x0E, 0x7F]};
@GUID(0xF3457CA9, 0xABB9, 0x4FA5, [0xB8, 0x50, 0x90, 0xE8, 0xCA, 0x30, 0x0E, 0x7F]);
interface IWSManEnumerator : IDispatch
{
    HRESULT ReadItem(BSTR* resource);
    HRESULT get_AtEndOfStream(short* eos);
    HRESULT get_Error(BSTR* value);
}

const GUID IID_IWSManResourceLocator = {0xA7A1BA28, 0xDE41, 0x466A, [0xAD, 0x0A, 0xC4, 0x05, 0x9E, 0xAD, 0x74, 0x28]};
@GUID(0xA7A1BA28, 0xDE41, 0x466A, [0xAD, 0x0A, 0xC4, 0x05, 0x9E, 0xAD, 0x74, 0x28]);
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

const GUID IID_IWSManResourceLocatorInternal = {0xEFFAEAD7, 0x7EC8, 0x4716, [0xB9, 0xBE, 0xF2, 0xE7, 0xE9, 0xFB, 0x4A, 0xDB]};
@GUID(0xEFFAEAD7, 0x7EC8, 0x4716, [0xB9, 0xBE, 0xF2, 0xE7, 0xE9, 0xFB, 0x4A, 0xDB]);
interface IWSManResourceLocatorInternal : IUnknown
{
}

const GUID IID_IWSManInternal = {0x04AE2B1D, 0x9954, 0x4D99, [0x94, 0xA9, 0xA9, 0x61, 0xE7, 0x2C, 0x3A, 0x13]};
@GUID(0x04AE2B1D, 0x9954, 0x4D99, [0x94, 0xA9, 0xA9, 0x61, 0xE7, 0x2C, 0x3A, 0x13]);
interface IWSManInternal : IDispatch
{
    HRESULT ConfigSDDL(IDispatch session, VARIANT resourceUri, int flags, BSTR* resource);
}

@DllImport("WsmSvc.dll")
uint WSManInitialize(uint flags, WSMAN_API** apiHandle);

@DllImport("WsmSvc.dll")
uint WSManDeinitialize(WSMAN_API* apiHandle, uint flags);

@DllImport("WsmSvc.dll")
uint WSManGetErrorMessage(WSMAN_API* apiHandle, uint flags, const(wchar)* languageCode, uint errorCode, uint messageLength, const(wchar)* message, uint* messageLengthUsed);

@DllImport("WsmSvc.dll")
uint WSManCreateSession(WSMAN_API* apiHandle, const(wchar)* connection, uint flags, WSMAN_AUTHENTICATION_CREDENTIALS* serverAuthenticationCredentials, WSMAN_PROXY_INFO* proxyInfo, WSMAN_SESSION** session);

@DllImport("WsmSvc.dll")
uint WSManCloseSession(WSMAN_SESSION* session, uint flags);

@DllImport("WsmSvc.dll")
uint WSManSetSessionOption(WSMAN_SESSION* session, WSManSessionOption option, WSMAN_DATA* data);

@DllImport("WsmSvc.dll")
uint WSManGetSessionOptionAsDword(WSMAN_SESSION* session, WSManSessionOption option, uint* value);

@DllImport("WsmSvc.dll")
uint WSManGetSessionOptionAsString(WSMAN_SESSION* session, WSManSessionOption option, uint stringLength, const(wchar)* string, uint* stringLengthUsed);

@DllImport("WsmSvc.dll")
uint WSManCloseOperation(WSMAN_OPERATION* operationHandle, uint flags);

@DllImport("WsmSvc.dll")
void WSManCreateShell(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, WSMAN_OPTION_SET* options, WSMAN_DATA* createXml, WSMAN_SHELL_ASYNC* async, WSMAN_SHELL** shell);

@DllImport("WsmSvc.dll")
void WSManRunShellCommand(WSMAN_SHELL* shell, uint flags, const(wchar)* commandLine, WSMAN_COMMAND_ARG_SET* args, WSMAN_OPTION_SET* options, WSMAN_SHELL_ASYNC* async, WSMAN_COMMAND** command);

@DllImport("WsmSvc.dll")
void WSManSignalShell(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, const(wchar)* code, WSMAN_SHELL_ASYNC* async, WSMAN_OPERATION** signalOperation);

@DllImport("WsmSvc.dll")
void WSManReceiveShellOutput(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, WSMAN_STREAM_ID_SET* desiredStreamSet, WSMAN_SHELL_ASYNC* async, WSMAN_OPERATION** receiveOperation);

@DllImport("WsmSvc.dll")
void WSManSendShellInput(WSMAN_SHELL* shell, WSMAN_COMMAND* command, uint flags, const(wchar)* streamId, WSMAN_DATA* streamData, BOOL endOfStream, WSMAN_SHELL_ASYNC* async, WSMAN_OPERATION** sendOperation);

@DllImport("WsmSvc.dll")
void WSManCloseCommand(WSMAN_COMMAND* commandHandle, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc.dll")
void WSManCloseShell(WSMAN_SHELL* shellHandle, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc.dll")
void WSManCreateShellEx(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, const(wchar)* shellId, WSMAN_SHELL_STARTUP_INFO_V11* startupInfo, WSMAN_OPTION_SET* options, WSMAN_DATA* createXml, WSMAN_SHELL_ASYNC* async, WSMAN_SHELL** shell);

@DllImport("WsmSvc.dll")
void WSManRunShellCommandEx(WSMAN_SHELL* shell, uint flags, const(wchar)* commandId, const(wchar)* commandLine, WSMAN_COMMAND_ARG_SET* args, WSMAN_OPTION_SET* options, WSMAN_SHELL_ASYNC* async, WSMAN_COMMAND** command);

@DllImport("WsmSvc.dll")
void WSManDisconnectShell(WSMAN_SHELL* shell, uint flags, WSMAN_SHELL_DISCONNECT_INFO* disconnectInfo, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc.dll")
void WSManReconnectShell(WSMAN_SHELL* shell, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc.dll")
void WSManReconnectShellCommand(WSMAN_COMMAND* commandHandle, uint flags, WSMAN_SHELL_ASYNC* async);

@DllImport("WsmSvc.dll")
void WSManConnectShell(WSMAN_SESSION* session, uint flags, const(wchar)* resourceUri, const(wchar)* shellID, WSMAN_OPTION_SET* options, WSMAN_DATA* connectXml, WSMAN_SHELL_ASYNC* async, WSMAN_SHELL** shell);

@DllImport("WsmSvc.dll")
void WSManConnectShellCommand(WSMAN_SHELL* shell, uint flags, const(wchar)* commandID, WSMAN_OPTION_SET* options, WSMAN_DATA* connectXml, WSMAN_SHELL_ASYNC* async, WSMAN_COMMAND** command);

@DllImport("WsmSvc.dll")
uint WSManPluginReportContext(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, void* context);

@DllImport("WsmSvc.dll")
uint WSManPluginReceiveResult(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, const(wchar)* stream, WSMAN_DATA* streamResult, const(wchar)* commandState, uint exitCode);

@DllImport("WsmSvc.dll")
uint WSManPluginOperationComplete(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, uint errorCode, const(wchar)* extendedInformation);

@DllImport("WsmSvc.dll")
uint WSManPluginGetOperationParameters(WSMAN_PLUGIN_REQUEST* requestDetails, uint flags, WSMAN_DATA* data);

@DllImport("WsmSvc.dll")
uint WSManPluginGetConfiguration(void* pluginContext, uint flags, WSMAN_DATA* data);

@DllImport("WsmSvc.dll")
uint WSManPluginReportCompletion(void* pluginContext, uint flags);

@DllImport("WsmSvc.dll")
uint WSManPluginFreeRequestDetails(WSMAN_PLUGIN_REQUEST* requestDetails);

@DllImport("WsmSvc.dll")
uint WSManPluginAuthzUserComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, void* userAuthorizationContext, HANDLE impersonationToken, BOOL userIsAdministrator, uint errorCode, const(wchar)* extendedErrorInformation);

@DllImport("WsmSvc.dll")
uint WSManPluginAuthzOperationComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, void* userAuthorizationContext, uint errorCode, const(wchar)* extendedErrorInformation);

@DllImport("WsmSvc.dll")
uint WSManPluginAuthzQueryQuotaComplete(WSMAN_SENDER_DETAILS* senderDetails, uint flags, WSMAN_AUTHZ_QUOTA* quota, uint errorCode, const(wchar)* extendedErrorInformation);

