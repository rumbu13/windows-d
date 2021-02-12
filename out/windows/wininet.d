module windows.wininet;

public import system;
public import windows.automation;
public import windows.com;
public import windows.filesystem;
public import windows.gdi;
public import windows.security;
public import windows.systemservices;
public import windows.winrt;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct HTTP_VERSION_INFO
{
    uint dwMajorVersion;
    uint dwMinorVersion;
}

enum INTERNET_SCHEME
{
    INTERNET_SCHEME_PARTIAL = -2,
    INTERNET_SCHEME_UNKNOWN = -1,
    INTERNET_SCHEME_DEFAULT = 0,
    INTERNET_SCHEME_FTP = 1,
    INTERNET_SCHEME_GOPHER = 2,
    INTERNET_SCHEME_HTTP = 3,
    INTERNET_SCHEME_HTTPS = 4,
    INTERNET_SCHEME_FILE = 5,
    INTERNET_SCHEME_NEWS = 6,
    INTERNET_SCHEME_MAILTO = 7,
    INTERNET_SCHEME_SOCKS = 8,
    INTERNET_SCHEME_JAVASCRIPT = 9,
    INTERNET_SCHEME_VBSCRIPT = 10,
    INTERNET_SCHEME_RES = 11,
    INTERNET_SCHEME_FIRST = 1,
    INTERNET_SCHEME_LAST = 11,
}

struct INTERNET_ASYNC_RESULT
{
    uint dwResult;
    uint dwError;
}

struct INTERNET_DIAGNOSTIC_SOCKET_INFO
{
    uint Socket;
    uint SourcePort;
    uint DestPort;
    uint Flags;
}

struct INTERNET_PROXY_INFO
{
    uint dwAccessType;
    byte* lpszProxy;
    byte* lpszProxyBypass;
}

struct INTERNET_PER_CONN_OPTIONA
{
    uint dwOption;
    _Value_e__Union Value;
}

struct INTERNET_PER_CONN_OPTIONW
{
    uint dwOption;
    _Value_e__Union Value;
}

struct INTERNET_PER_CONN_OPTION_LISTA
{
    uint dwSize;
    const(char)* pszConnection;
    uint dwOptionCount;
    uint dwOptionError;
    INTERNET_PER_CONN_OPTIONA* pOptions;
}

struct INTERNET_PER_CONN_OPTION_LISTW
{
    uint dwSize;
    const(wchar)* pszConnection;
    uint dwOptionCount;
    uint dwOptionError;
    INTERNET_PER_CONN_OPTIONW* pOptions;
}

struct INTERNET_VERSION_INFO
{
    uint dwMajorVersion;
    uint dwMinorVersion;
}

struct INTERNET_CONNECTED_INFO
{
    uint dwConnectedState;
    uint dwFlags;
}

struct URL_COMPONENTSA
{
    uint dwStructSize;
    const(char)* lpszScheme;
    uint dwSchemeLength;
    INTERNET_SCHEME nScheme;
    const(char)* lpszHostName;
    uint dwHostNameLength;
    ushort nPort;
    const(char)* lpszUserName;
    uint dwUserNameLength;
    const(char)* lpszPassword;
    uint dwPasswordLength;
    const(char)* lpszUrlPath;
    uint dwUrlPathLength;
    const(char)* lpszExtraInfo;
    uint dwExtraInfoLength;
}

struct URL_COMPONENTSW
{
    uint dwStructSize;
    const(wchar)* lpszScheme;
    uint dwSchemeLength;
    INTERNET_SCHEME nScheme;
    const(wchar)* lpszHostName;
    uint dwHostNameLength;
    ushort nPort;
    const(wchar)* lpszUserName;
    uint dwUserNameLength;
    const(wchar)* lpszPassword;
    uint dwPasswordLength;
    const(wchar)* lpszUrlPath;
    uint dwUrlPathLength;
    const(wchar)* lpszExtraInfo;
    uint dwExtraInfoLength;
}

struct INTERNET_CERTIFICATE_INFO
{
    FILETIME ftExpiry;
    FILETIME ftStart;
    byte* lpszSubjectInfo;
    byte* lpszIssuerInfo;
    byte* lpszProtocolName;
    byte* lpszSignatureAlgName;
    byte* lpszEncryptionAlgName;
    uint dwKeySize;
}

struct INTERNET_BUFFERSA
{
    uint dwStructSize;
    INTERNET_BUFFERSA* Next;
    const(char)* lpcszHeader;
    uint dwHeadersLength;
    uint dwHeadersTotal;
    void* lpvBuffer;
    uint dwBufferLength;
    uint dwBufferTotal;
    uint dwOffsetLow;
    uint dwOffsetHigh;
}

struct INTERNET_BUFFERSW
{
    uint dwStructSize;
    INTERNET_BUFFERSW* Next;
    const(wchar)* lpcszHeader;
    uint dwHeadersLength;
    uint dwHeadersTotal;
    void* lpvBuffer;
    uint dwBufferLength;
    uint dwBufferTotal;
    uint dwOffsetLow;
    uint dwOffsetHigh;
}

alias INTERNET_STATUS_CALLBACK = extern(Windows) void function(void* hInternet, uint dwContext, uint dwInternetStatus, void* lpvStatusInformation, uint dwStatusInformationLength);
alias LPINTERNET_STATUS_CALLBACK = extern(Windows) void function();
enum InternetCookieState
{
    COOKIE_STATE_UNKNOWN = 0,
    COOKIE_STATE_ACCEPT = 1,
    COOKIE_STATE_PROMPT = 2,
    COOKIE_STATE_LEASH = 3,
    COOKIE_STATE_DOWNGRADE = 4,
    COOKIE_STATE_REJECT = 5,
    COOKIE_STATE_MAX = 5,
}

struct IncomingCookieState
{
    int cSession;
    int cPersistent;
    int cAccepted;
    int cLeashed;
    int cDowngraded;
    int cBlocked;
    const(byte)* pszLocation;
}

struct OutgoingCookieState
{
    int cSent;
    int cSuppressed;
    const(byte)* pszLocation;
}

struct InternetCookieHistory
{
    BOOL fAccepted;
    BOOL fLeashed;
    BOOL fDowngraded;
    BOOL fRejected;
}

struct CookieDecision
{
    uint dwCookieState;
    BOOL fAllowSession;
}

struct GOPHER_FIND_DATAA
{
    byte DisplayString;
    uint GopherType;
    uint SizeLow;
    uint SizeHigh;
    FILETIME LastModificationTime;
    byte Locator;
}

struct GOPHER_FIND_DATAW
{
    ushort DisplayString;
    uint GopherType;
    uint SizeLow;
    uint SizeHigh;
    FILETIME LastModificationTime;
    ushort Locator;
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
    uint Size;
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

struct GOPHER_ATTRIBUTE_TYPE
{
    uint CategoryId;
    uint AttributeId;
    _AttributeType_e__Union AttributeType;
}

alias GOPHER_ATTRIBUTE_ENUMERATOR = extern(Windows) BOOL function(GOPHER_ATTRIBUTE_TYPE* lpAttributeInfo, uint dwError);
struct INTERNET_COOKIE2
{
    const(wchar)* pwszName;
    const(wchar)* pwszValue;
    const(wchar)* pwszDomain;
    const(wchar)* pwszPath;
    uint dwFlags;
    FILETIME ftExpires;
    BOOL fExpiresSet;
}

alias PFN_AUTH_NOTIFY = extern(Windows) uint function(uint param0, uint param1, void* param2);
struct INTERNET_AUTH_NOTIFY_DATA
{
    uint cbStruct;
    uint dwOptions;
    PFN_AUTH_NOTIFY pfnNotify;
    uint dwContext;
}

struct INTERNET_CACHE_ENTRY_INFOA
{
    uint dwStructSize;
    const(char)* lpszSourceUrlName;
    const(char)* lpszLocalFileName;
    uint CacheEntryType;
    uint dwUseCount;
    uint dwHitRate;
    uint dwSizeLow;
    uint dwSizeHigh;
    FILETIME LastModifiedTime;
    FILETIME ExpireTime;
    FILETIME LastAccessTime;
    FILETIME LastSyncTime;
    const(char)* lpHeaderInfo;
    uint dwHeaderInfoSize;
    const(char)* lpszFileExtension;
    _Anonymous_e__Union Anonymous;
}

struct INTERNET_CACHE_ENTRY_INFOW
{
    uint dwStructSize;
    const(wchar)* lpszSourceUrlName;
    const(wchar)* lpszLocalFileName;
    uint CacheEntryType;
    uint dwUseCount;
    uint dwHitRate;
    uint dwSizeLow;
    uint dwSizeHigh;
    FILETIME LastModifiedTime;
    FILETIME ExpireTime;
    FILETIME LastAccessTime;
    FILETIME LastSyncTime;
    const(wchar)* lpHeaderInfo;
    uint dwHeaderInfoSize;
    const(wchar)* lpszFileExtension;
    _Anonymous_e__Union Anonymous;
}

struct INTERNET_CACHE_TIMESTAMPS
{
    FILETIME ftExpires;
    FILETIME ftLastModified;
}

struct INTERNET_CACHE_GROUP_INFOA
{
    uint dwGroupSize;
    uint dwGroupFlags;
    uint dwGroupType;
    uint dwDiskUsage;
    uint dwDiskQuota;
    uint dwOwnerStorage;
    byte szGroupName;
}

struct INTERNET_CACHE_GROUP_INFOW
{
    uint dwGroupSize;
    uint dwGroupFlags;
    uint dwGroupType;
    uint dwDiskUsage;
    uint dwDiskQuota;
    uint dwOwnerStorage;
    ushort szGroupName;
}

struct AutoProxyHelperVtbl
{
    BOOL********** IsResolvable;
    int GetIPAddress;
    int ResolveHostName;
    BOOL********** IsInNet;
    BOOL********** IsResolvableEx;
    int GetIPAddressEx;
    int ResolveHostNameEx;
    BOOL********** IsInNetEx;
    int SortIpList;
}

struct AUTO_PROXY_SCRIPT_BUFFER
{
    uint dwStructSize;
    const(char)* lpszScriptBuffer;
    uint dwScriptBufferSize;
}

struct AutoProxyHelperFunctions
{
    const(AutoProxyHelperVtbl)* lpVtbl;
}

alias pfnInternetInitializeAutoProxyDll = extern(Windows) BOOL function(uint dwVersion, const(char)* lpszDownloadedTempFile, const(char)* lpszMime, AutoProxyHelperFunctions* lpAutoProxyCallbacks, AUTO_PROXY_SCRIPT_BUFFER* lpAutoProxyScriptBuffer);
alias pfnInternetDeInitializeAutoProxyDll = extern(Windows) BOOL function(const(char)* lpszMime, uint dwReserved);
alias pfnInternetGetProxyInfo = extern(Windows) BOOL function(const(char)* lpszUrl, uint dwUrlLength, const(char)* lpszUrlHostName, uint dwUrlHostNameLength, byte** lplpszProxyHostName, uint* lpdwProxyHostNameLength);
enum WPAD_CACHE_DELETE
{
    WPAD_CACHE_DELETE_CURRENT = 0,
    WPAD_CACHE_DELETE_ALL = 1,
}

alias PFN_DIAL_HANDLER = extern(Windows) uint function(HWND param0, const(char)* param1, uint param2, uint* param3);
const GUID IID_IDialEventSink = {0x2D86F4FF, 0x6E2D, 0x4488, [0xB2, 0xE9, 0x69, 0x34, 0xAF, 0xD4, 0x1B, 0xEA]};
@GUID(0x2D86F4FF, 0x6E2D, 0x4488, [0xB2, 0xE9, 0x69, 0x34, 0xAF, 0xD4, 0x1B, 0xEA]);
interface IDialEventSink : IUnknown
{
    HRESULT OnEvent(uint dwEvent, uint dwStatus);
}

const GUID IID_IDialEngine = {0x39FD782B, 0x7905, 0x40D5, [0x91, 0x48, 0x3C, 0x9B, 0x19, 0x04, 0x23, 0xD5]};
@GUID(0x39FD782B, 0x7905, 0x40D5, [0x91, 0x48, 0x3C, 0x9B, 0x19, 0x04, 0x23, 0xD5]);
interface IDialEngine : IUnknown
{
    HRESULT Initialize(const(wchar)* pwzConnectoid, IDialEventSink pIDES);
    HRESULT GetProperty(const(wchar)* pwzProperty, const(wchar)* pwzValue, uint dwBufSize);
    HRESULT SetProperty(const(wchar)* pwzProperty, const(wchar)* pwzValue);
    HRESULT Dial();
    HRESULT HangUp();
    HRESULT GetConnectedState(uint* pdwState);
    HRESULT GetConnectHandle(uint* pdwHandle);
}

const GUID IID_IDialBranding = {0x8AECAFA9, 0x4306, 0x43CC, [0x8C, 0x5A, 0x76, 0x5F, 0x29, 0x79, 0xCC, 0x16]};
@GUID(0x8AECAFA9, 0x4306, 0x43CC, [0x8C, 0x5A, 0x76, 0x5F, 0x29, 0x79, 0xCC, 0x16]);
interface IDialBranding : IUnknown
{
    HRESULT Initialize(const(wchar)* pwzConnectoid);
    HRESULT GetBitmap(uint dwIndex, HBITMAP* phBitmap);
}

struct INTERNET_PREFETCH_STATUS
{
    uint dwStatus;
    uint dwSize;
}

struct INTERNET_SECURITY_INFO
{
    uint dwSize;
    CERT_CONTEXT* pCertificate;
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

enum FORTCMD
{
    FORTCMD_LOGON = 1,
    FORTCMD_LOGOFF = 2,
    FORTCMD_CHG_PERSONALITY = 3,
}

enum FORTSTAT
{
    FORTSTAT_INSTALLED = 1,
    FORTSTAT_LOGGEDON = 2,
}

struct INTERNET_DOWNLOAD_MODE_HANDLE
{
    const(wchar)* pcwszFileName;
    HANDLE* phFile;
}

enum REQUEST_TIMES
{
    NameResolutionStart = 0,
    NameResolutionEnd = 1,
    ConnectionEstablishmentStart = 2,
    ConnectionEstablishmentEnd = 3,
    TLSHandshakeStart = 4,
    TLSHandshakeEnd = 5,
    HttpRequestTimeMax = 32,
}

struct HTTP_REQUEST_TIMES
{
    uint cTimes;
    ulong rgTimes;
}

struct INTERNET_SERVER_CONNECTION_STATE
{
    const(wchar)* lpcwszHostName;
    BOOL fProxy;
    uint dwCounter;
    uint dwConnectionLimit;
    uint dwAvailableCreates;
    uint dwAvailableKeepAlives;
    uint dwActiveConnections;
    uint dwWaiters;
}

struct INTERNET_END_BROWSER_SESSION_DATA
{
    void* lpBuffer;
    uint dwBufferLength;
}

struct INTERNET_CALLBACK_COOKIE
{
    const(wchar)* pcwszName;
    const(wchar)* pcwszValue;
    const(wchar)* pcwszDomain;
    const(wchar)* pcwszPath;
    FILETIME ftExpires;
    uint dwFlags;
}

struct INTERNET_CREDENTIALS
{
    const(wchar)* lpcwszHostName;
    uint dwPort;
    uint dwScheme;
    const(wchar)* lpcwszUrl;
    const(wchar)* lpcwszRealm;
    BOOL fAuthIdentity;
    _Anonymous_e__Union Anonymous;
}

struct HTTP_PUSH_WAIT_HANDLE__
{
    int unused;
}

struct HTTP_PUSH_TRANSPORT_SETTING
{
    Guid TransportSettingId;
    Guid BrokerEventId;
}

struct HTTP_PUSH_NOTIFICATION_STATUS
{
    BOOL ChannelStatusValid;
    uint ChannelStatus;
}

enum HTTP_PUSH_WAIT_TYPE
{
    HttpPushWaitEnableComplete = 0,
    HttpPushWaitReceiveComplete = 1,
    HttpPushWaitSendComplete = 2,
}

struct INTERNET_COOKIE
{
    uint cbSize;
    const(char)* pszName;
    const(char)* pszData;
    const(char)* pszDomain;
    const(char)* pszPath;
    FILETIME* pftExpires;
    uint dwFlags;
    const(char)* pszUrl;
    const(char)* pszP3PPolicy;
}

struct COOKIE_DLG_INFO
{
    const(wchar)* pszServer;
    INTERNET_COOKIE* pic;
    uint dwStopWarning;
    int cx;
    int cy;
    const(wchar)* pszHeader;
    uint dwOperation;
}

struct INTERNET_CACHE_CONFIG_PATH_ENTRYA
{
    byte CachePath;
    uint dwCacheSize;
}

struct INTERNET_CACHE_CONFIG_PATH_ENTRYW
{
    ushort CachePath;
    uint dwCacheSize;
}

struct INTERNET_CACHE_CONFIG_INFOA
{
    uint dwStructSize;
    uint dwContainer;
    uint dwQuota;
    uint dwReserved4;
    BOOL fPerUser;
    uint dwSyncMode;
    uint dwNumCachePaths;
    _Anonymous_e__Union Anonymous;
    uint dwNormalUsage;
    uint dwExemptUsage;
}

struct INTERNET_CACHE_CONFIG_INFOW
{
    uint dwStructSize;
    uint dwContainer;
    uint dwQuota;
    uint dwReserved4;
    BOOL fPerUser;
    uint dwSyncMode;
    uint dwNumCachePaths;
    _Anonymous_e__Union Anonymous;
    uint dwNormalUsage;
    uint dwExemptUsage;
}

struct INTERNET_CACHE_CONTAINER_INFOA
{
    uint dwCacheVersion;
    const(char)* lpszName;
    const(char)* lpszCachePrefix;
    const(char)* lpszVolumeLabel;
    const(char)* lpszVolumeTitle;
}

struct INTERNET_CACHE_CONTAINER_INFOW
{
    uint dwCacheVersion;
    const(wchar)* lpszName;
    const(wchar)* lpszCachePrefix;
    const(wchar)* lpszVolumeLabel;
    const(wchar)* lpszVolumeTitle;
}

enum WININET_SYNC_MODE
{
    WININET_SYNC_MODE_NEVER = 0,
    WININET_SYNC_MODE_ON_EXPIRY = 1,
    WININET_SYNC_MODE_ONCE_PER_SESSION = 2,
    WININET_SYNC_MODE_ALWAYS = 3,
    WININET_SYNC_MODE_AUTOMATIC = 4,
    WININET_SYNC_MODE_DEFAULT = 4,
}

enum APP_CACHE_STATE
{
    AppCacheStateNoUpdateNeeded = 0,
    AppCacheStateUpdateNeeded = 1,
    AppCacheStateUpdateNeededNew = 2,
    AppCacheStateUpdateNeededMasterOnly = 3,
}

struct APP_CACHE_DOWNLOAD_ENTRY
{
    const(wchar)* pwszUrl;
    uint dwEntryType;
}

struct APP_CACHE_DOWNLOAD_LIST
{
    uint dwEntryCount;
    APP_CACHE_DOWNLOAD_ENTRY* pEntries;
}

enum APP_CACHE_FINALIZE_STATE
{
    AppCacheFinalizeStateIncomplete = 0,
    AppCacheFinalizeStateManifestChange = 1,
    AppCacheFinalizeStateComplete = 2,
}

struct APP_CACHE_GROUP_INFO
{
    const(wchar)* pwszManifestUrl;
    FILETIME ftLastAccessTime;
    ulong ullSize;
}

struct APP_CACHE_GROUP_LIST
{
    uint dwAppCacheGroupCount;
    APP_CACHE_GROUP_INFO* pAppCacheGroups;
}

struct URLCACHE_ENTRY_INFO
{
    const(wchar)* pwszSourceUrlName;
    const(wchar)* pwszLocalFileName;
    uint dwCacheEntryType;
    uint dwUseCount;
    uint dwHitRate;
    uint dwSizeLow;
    uint dwSizeHigh;
    FILETIME ftLastModifiedTime;
    FILETIME ftExpireTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastSyncTime;
    ubyte* pbHeaderInfo;
    uint cbHeaderInfoSize;
    ubyte* pbExtraData;
    uint cbExtraDataSize;
}

enum URL_CACHE_LIMIT_TYPE
{
    UrlCacheLimitTypeIE = 0,
    UrlCacheLimitTypeIETotal = 1,
    UrlCacheLimitTypeAppContainer = 2,
    UrlCacheLimitTypeAppContainerTotal = 3,
    UrlCacheLimitTypeNum = 4,
}

struct WININET_PROXY_INFO
{
    BOOL fProxy;
    BOOL fBypass;
    INTERNET_SCHEME ProxyScheme;
    const(wchar)* pwszProxy;
    ushort ProxyPort;
}

struct WININET_PROXY_INFO_LIST
{
    uint dwProxyInfoCount;
    WININET_PROXY_INFO* pProxyInfo;
}

alias CACHE_OPERATOR = extern(Windows) BOOL function(INTERNET_CACHE_ENTRY_INFOA* pcei, uint* pcbcei, void* pOpData);
enum HTTP_WEB_SOCKET_OPERATION
{
    HTTP_WEB_SOCKET_SEND_OPERATION = 0,
    HTTP_WEB_SOCKET_RECEIVE_OPERATION = 1,
    HTTP_WEB_SOCKET_CLOSE_OPERATION = 2,
    HTTP_WEB_SOCKET_SHUTDOWN_OPERATION = 3,
}

enum HTTP_WEB_SOCKET_BUFFER_TYPE
{
    HTTP_WEB_SOCKET_BINARY_MESSAGE_TYPE = 0,
    HTTP_WEB_SOCKET_BINARY_FRAGMENT_TYPE = 1,
    HTTP_WEB_SOCKET_UTF8_MESSAGE_TYPE = 2,
    HTTP_WEB_SOCKET_UTF8_FRAGMENT_TYPE = 3,
    HTTP_WEB_SOCKET_CLOSE_TYPE = 4,
    HTTP_WEB_SOCKET_PING_TYPE = 5,
}

enum HTTP_WEB_SOCKET_CLOSE_STATUS
{
    HTTP_WEB_SOCKET_SUCCESS_CLOSE_STATUS = 1000,
    HTTP_WEB_SOCKET_ENDPOINT_TERMINATED_CLOSE_STATUS = 1001,
    HTTP_WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS = 1002,
    HTTP_WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS = 1003,
    HTTP_WEB_SOCKET_EMPTY_CLOSE_STATUS = 1005,
    HTTP_WEB_SOCKET_ABORTED_CLOSE_STATUS = 1006,
    HTTP_WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS = 1007,
    HTTP_WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS = 1008,
    HTTP_WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS = 1009,
    HTTP_WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 1010,
    HTTP_WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS = 1011,
    HTTP_WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 1015,
}

struct HTTP_WEB_SOCKET_ASYNC_RESULT
{
    INTERNET_ASYNC_RESULT AsyncResult;
    HTTP_WEB_SOCKET_OPERATION Operation;
    HTTP_WEB_SOCKET_BUFFER_TYPE BufferType;
    uint dwBytesTransferred;
}

const GUID CLSID_ProofOfPossessionCookieInfoManager = {0xA9927F85, 0xA304, 0x4390, [0x8B, 0x23, 0xA7, 0x5F, 0x1C, 0x66, 0x86, 0x00]};
@GUID(0xA9927F85, 0xA304, 0x4390, [0x8B, 0x23, 0xA7, 0x5F, 0x1C, 0x66, 0x86, 0x00]);
struct ProofOfPossessionCookieInfoManager;

struct ProofOfPossessionCookieInfo
{
    const(wchar)* name;
    const(wchar)* data;
    uint flags;
    const(wchar)* p3pHeader;
}

const GUID IID_IProofOfPossessionCookieInfoManager = {0xCDAECE56, 0x4EDF, 0x43DF, [0xB1, 0x13, 0x88, 0xE4, 0x55, 0x6F, 0xA1, 0xBB]};
@GUID(0xCDAECE56, 0x4EDF, 0x43DF, [0xB1, 0x13, 0x88, 0xE4, 0x55, 0x6F, 0xA1, 0xBB]);
interface IProofOfPossessionCookieInfoManager : IUnknown
{
    HRESULT GetCookieInfoForUri(const(wchar)* uri, uint* cookieInfoCount, char* cookieInfo);
}

const GUID IID_IProofOfPossessionCookieInfoManager2 = {0x15E41407, 0xB42F, 0x4AE7, [0x99, 0x66, 0x34, 0xA0, 0x87, 0xB2, 0xD7, 0x13]};
@GUID(0x15E41407, 0xB42F, 0x4AE7, [0x99, 0x66, 0x34, 0xA0, 0x87, 0xB2, 0xD7, 0x13]);
interface IProofOfPossessionCookieInfoManager2 : IUnknown
{
    HRESULT GetCookieInfoWithUriForAccount(IInspectable webAccount, const(wchar)* uri, uint* cookieInfoCount, char* cookieInfo);
}

@DllImport("WININET.dll")
BOOL InternetTimeFromSystemTimeA(const(SYSTEMTIME)* pst, uint dwRFC, const(char)* lpszTime, uint cbTime);

@DllImport("WININET.dll")
BOOL InternetTimeFromSystemTimeW(const(SYSTEMTIME)* pst, uint dwRFC, const(wchar)* lpszTime, uint cbTime);

@DllImport("WININET.dll")
BOOL InternetTimeFromSystemTime(const(SYSTEMTIME)* pst, uint dwRFC, const(char)* lpszTime, uint cbTime);

@DllImport("WININET.dll")
BOOL InternetTimeToSystemTimeA(const(char)* lpszTime, SYSTEMTIME* pst, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetTimeToSystemTimeW(const(wchar)* lpszTime, SYSTEMTIME* pst, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetTimeToSystemTime(const(char)* lpszTime, SYSTEMTIME* pst, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetCrackUrlA(const(char)* lpszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTSA* lpUrlComponents);

@DllImport("WININET.dll")
BOOL InternetCrackUrlW(const(wchar)* lpszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTSW* lpUrlComponents);

@DllImport("WININET.dll")
BOOL InternetCreateUrlA(URL_COMPONENTSA* lpUrlComponents, uint dwFlags, const(char)* lpszUrl, uint* lpdwUrlLength);

@DllImport("WININET.dll")
BOOL InternetCreateUrlW(URL_COMPONENTSW* lpUrlComponents, uint dwFlags, const(wchar)* lpszUrl, uint* lpdwUrlLength);

@DllImport("WININET.dll")
BOOL InternetCanonicalizeUrlA(const(char)* lpszUrl, const(char)* lpszBuffer, uint* lpdwBufferLength, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetCanonicalizeUrlW(const(wchar)* lpszUrl, const(wchar)* lpszBuffer, uint* lpdwBufferLength, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetCombineUrlA(const(char)* lpszBaseUrl, const(char)* lpszRelativeUrl, const(char)* lpszBuffer, uint* lpdwBufferLength, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetCombineUrlW(const(wchar)* lpszBaseUrl, const(wchar)* lpszRelativeUrl, const(wchar)* lpszBuffer, uint* lpdwBufferLength, uint dwFlags);

@DllImport("WININET.dll")
void* InternetOpenA(const(char)* lpszAgent, uint dwAccessType, const(char)* lpszProxy, const(char)* lpszProxyBypass, uint dwFlags);

@DllImport("WININET.dll")
void* InternetOpenW(const(wchar)* lpszAgent, uint dwAccessType, const(wchar)* lpszProxy, const(wchar)* lpszProxyBypass, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetCloseHandle(void* hInternet);

@DllImport("WININET.dll")
void* InternetConnectA(void* hInternet, const(char)* lpszServerName, ushort nServerPort, const(char)* lpszUserName, const(char)* lpszPassword, uint dwService, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* InternetConnectW(void* hInternet, const(wchar)* lpszServerName, ushort nServerPort, const(wchar)* lpszUserName, const(wchar)* lpszPassword, uint dwService, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* InternetOpenUrlA(void* hInternet, const(char)* lpszUrl, const(char)* lpszHeaders, uint dwHeadersLength, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* InternetOpenUrlW(void* hInternet, const(wchar)* lpszUrl, const(wchar)* lpszHeaders, uint dwHeadersLength, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL InternetReadFile(void* hFile, char* lpBuffer, uint dwNumberOfBytesToRead, uint* lpdwNumberOfBytesRead);

@DllImport("WININET.dll")
BOOL InternetReadFileExA(void* hFile, INTERNET_BUFFERSA* lpBuffersOut, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL InternetReadFileExW(void* hFile, INTERNET_BUFFERSW* lpBuffersOut, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
uint InternetSetFilePointer(void* hFile, int lDistanceToMove, int* lpDistanceToMoveHigh, uint dwMoveMethod, uint dwContext);

@DllImport("WININET.dll")
BOOL InternetWriteFile(void* hFile, char* lpBuffer, uint dwNumberOfBytesToWrite, uint* lpdwNumberOfBytesWritten);

@DllImport("WININET.dll")
BOOL InternetQueryDataAvailable(void* hFile, uint* lpdwNumberOfBytesAvailable, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL InternetFindNextFileA(void* hFind, void* lpvFindData);

@DllImport("WININET.dll")
BOOL InternetFindNextFileW(void* hFind, void* lpvFindData);

@DllImport("WININET.dll")
BOOL InternetQueryOptionA(void* hInternet, uint dwOption, char* lpBuffer, uint* lpdwBufferLength);

@DllImport("WININET.dll")
BOOL InternetQueryOptionW(void* hInternet, uint dwOption, char* lpBuffer, uint* lpdwBufferLength);

@DllImport("WININET.dll")
BOOL InternetSetOptionA(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength);

@DllImport("WININET.dll")
BOOL InternetSetOptionW(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength);

@DllImport("WININET.dll")
BOOL InternetSetOptionExA(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetSetOptionExW(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetLockRequestFile(void* hInternet, HANDLE* lphLockRequestInfo);

@DllImport("WININET.dll")
BOOL InternetUnlockRequestFile(HANDLE hLockRequestInfo);

@DllImport("WININET.dll")
BOOL InternetGetLastResponseInfoA(uint* lpdwError, const(char)* lpszBuffer, uint* lpdwBufferLength);

@DllImport("WININET.dll")
BOOL InternetGetLastResponseInfoW(uint* lpdwError, const(wchar)* lpszBuffer, uint* lpdwBufferLength);

@DllImport("WININET.dll")
INTERNET_STATUS_CALLBACK InternetSetStatusCallbackA(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

@DllImport("WININET.dll")
INTERNET_STATUS_CALLBACK InternetSetStatusCallbackW(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

@DllImport("WININET.dll")
INTERNET_STATUS_CALLBACK InternetSetStatusCallback(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

@DllImport("WININET.dll")
void* FtpFindFirstFileA(void* hConnect, const(char)* lpszSearchFile, WIN32_FIND_DATAA* lpFindFileData, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* FtpFindFirstFileW(void* hConnect, const(wchar)* lpszSearchFile, WIN32_FIND_DATAW* lpFindFileData, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpGetFileA(void* hConnect, const(char)* lpszRemoteFile, const(char)* lpszNewFile, BOOL fFailIfExists, uint dwFlagsAndAttributes, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpGetFileW(void* hConnect, const(wchar)* lpszRemoteFile, const(wchar)* lpszNewFile, BOOL fFailIfExists, uint dwFlagsAndAttributes, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpPutFileA(void* hConnect, const(char)* lpszLocalFile, const(char)* lpszNewRemoteFile, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpPutFileW(void* hConnect, const(wchar)* lpszLocalFile, const(wchar)* lpszNewRemoteFile, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpGetFileEx(void* hFtpSession, const(char)* lpszRemoteFile, const(wchar)* lpszNewFile, BOOL fFailIfExists, uint dwFlagsAndAttributes, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpPutFileEx(void* hFtpSession, const(wchar)* lpszLocalFile, const(char)* lpszNewRemoteFile, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpDeleteFileA(void* hConnect, const(char)* lpszFileName);

@DllImport("WININET.dll")
BOOL FtpDeleteFileW(void* hConnect, const(wchar)* lpszFileName);

@DllImport("WININET.dll")
BOOL FtpRenameFileA(void* hConnect, const(char)* lpszExisting, const(char)* lpszNew);

@DllImport("WININET.dll")
BOOL FtpRenameFileW(void* hConnect, const(wchar)* lpszExisting, const(wchar)* lpszNew);

@DllImport("WININET.dll")
void* FtpOpenFileA(void* hConnect, const(char)* lpszFileName, uint dwAccess, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* FtpOpenFileW(void* hConnect, const(wchar)* lpszFileName, uint dwAccess, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL FtpCreateDirectoryA(void* hConnect, const(char)* lpszDirectory);

@DllImport("WININET.dll")
BOOL FtpCreateDirectoryW(void* hConnect, const(wchar)* lpszDirectory);

@DllImport("WININET.dll")
BOOL FtpRemoveDirectoryA(void* hConnect, const(char)* lpszDirectory);

@DllImport("WININET.dll")
BOOL FtpRemoveDirectoryW(void* hConnect, const(wchar)* lpszDirectory);

@DllImport("WININET.dll")
BOOL FtpSetCurrentDirectoryA(void* hConnect, const(char)* lpszDirectory);

@DllImport("WININET.dll")
BOOL FtpSetCurrentDirectoryW(void* hConnect, const(wchar)* lpszDirectory);

@DllImport("WININET.dll")
BOOL FtpGetCurrentDirectoryA(void* hConnect, const(char)* lpszCurrentDirectory, uint* lpdwCurrentDirectory);

@DllImport("WININET.dll")
BOOL FtpGetCurrentDirectoryW(void* hConnect, const(wchar)* lpszCurrentDirectory, uint* lpdwCurrentDirectory);

@DllImport("WININET.dll")
BOOL FtpCommandA(void* hConnect, BOOL fExpectResponse, uint dwFlags, const(char)* lpszCommand, uint dwContext, void** phFtpCommand);

@DllImport("WININET.dll")
BOOL FtpCommandW(void* hConnect, BOOL fExpectResponse, uint dwFlags, const(wchar)* lpszCommand, uint dwContext, void** phFtpCommand);

@DllImport("WININET.dll")
uint FtpGetFileSize(void* hFile, uint* lpdwFileSizeHigh);

@DllImport("WININET.dll")
BOOL GopherCreateLocatorA(const(char)* lpszHost, ushort nServerPort, const(char)* lpszDisplayString, const(char)* lpszSelectorString, uint dwGopherType, const(char)* lpszLocator, uint* lpdwBufferLength);

@DllImport("WININET.dll")
BOOL GopherCreateLocatorW(const(wchar)* lpszHost, ushort nServerPort, const(wchar)* lpszDisplayString, const(wchar)* lpszSelectorString, uint dwGopherType, const(wchar)* lpszLocator, uint* lpdwBufferLength);

@DllImport("WININET.dll")
BOOL GopherGetLocatorTypeA(const(char)* lpszLocator, uint* lpdwGopherType);

@DllImport("WININET.dll")
BOOL GopherGetLocatorTypeW(const(wchar)* lpszLocator, uint* lpdwGopherType);

@DllImport("WININET.dll")
void* GopherFindFirstFileA(void* hConnect, const(char)* lpszLocator, const(char)* lpszSearchString, GOPHER_FIND_DATAA* lpFindData, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* GopherFindFirstFileW(void* hConnect, const(wchar)* lpszLocator, const(wchar)* lpszSearchString, GOPHER_FIND_DATAW* lpFindData, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* GopherOpenFileA(void* hConnect, const(char)* lpszLocator, const(char)* lpszView, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* GopherOpenFileW(void* hConnect, const(wchar)* lpszLocator, const(wchar)* lpszView, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL GopherGetAttributeA(void* hConnect, const(char)* lpszLocator, const(char)* lpszAttributeName, char* lpBuffer, uint dwBufferLength, uint* lpdwCharactersReturned, GOPHER_ATTRIBUTE_ENUMERATOR lpfnEnumerator, uint dwContext);

@DllImport("WININET.dll")
BOOL GopherGetAttributeW(void* hConnect, const(wchar)* lpszLocator, const(wchar)* lpszAttributeName, char* lpBuffer, uint dwBufferLength, uint* lpdwCharactersReturned, GOPHER_ATTRIBUTE_ENUMERATOR lpfnEnumerator, uint dwContext);

@DllImport("WININET.dll")
void* HttpOpenRequestA(void* hConnect, const(char)* lpszVerb, const(char)* lpszObjectName, const(char)* lpszVersion, const(char)* lpszReferrer, byte** lplpszAcceptTypes, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
void* HttpOpenRequestW(void* hConnect, const(wchar)* lpszVerb, const(wchar)* lpszObjectName, const(wchar)* lpszVersion, const(wchar)* lpszReferrer, ushort** lplpszAcceptTypes, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL HttpAddRequestHeadersA(void* hRequest, const(char)* lpszHeaders, uint dwHeadersLength, uint dwModifiers);

@DllImport("WININET.dll")
BOOL HttpAddRequestHeadersW(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, uint dwModifiers);

@DllImport("WININET.dll")
BOOL HttpSendRequestA(void* hRequest, const(char)* lpszHeaders, uint dwHeadersLength, char* lpOptional, uint dwOptionalLength);

@DllImport("WININET.dll")
BOOL HttpSendRequestW(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, char* lpOptional, uint dwOptionalLength);

@DllImport("WININET.dll")
BOOL HttpSendRequestExA(void* hRequest, INTERNET_BUFFERSA* lpBuffersIn, INTERNET_BUFFERSA* lpBuffersOut, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL HttpSendRequestExW(void* hRequest, INTERNET_BUFFERSW* lpBuffersIn, INTERNET_BUFFERSW* lpBuffersOut, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL HttpEndRequestA(void* hRequest, INTERNET_BUFFERSA* lpBuffersOut, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL HttpEndRequestW(void* hRequest, INTERNET_BUFFERSW* lpBuffersOut, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL HttpQueryInfoA(void* hRequest, uint dwInfoLevel, char* lpBuffer, uint* lpdwBufferLength, uint* lpdwIndex);

@DllImport("WININET.dll")
BOOL HttpQueryInfoW(void* hRequest, uint dwInfoLevel, char* lpBuffer, uint* lpdwBufferLength, uint* lpdwIndex);

@DllImport("WININET.dll")
BOOL InternetSetCookieA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData);

@DllImport("WININET.dll")
BOOL InternetSetCookieW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData);

@DllImport("WININET.dll")
BOOL InternetGetCookieA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData, uint* lpdwSize);

@DllImport("WININET.dll")
BOOL InternetGetCookieW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData, uint* lpdwSize);

@DllImport("WININET.dll")
uint InternetSetCookieExA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData, uint dwFlags, uint dwReserved);

@DllImport("WININET.dll")
uint InternetSetCookieExW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData, uint dwFlags, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetGetCookieExA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData, uint* lpdwSize, uint dwFlags, void* lpReserved);

@DllImport("WININET.dll")
BOOL InternetGetCookieExW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData, uint* lpdwSize, uint dwFlags, void* lpReserved);

@DllImport("WININET.dll")
void InternetFreeCookies(INTERNET_COOKIE2* pCookies, uint dwCookieCount);

@DllImport("WININET.dll")
uint InternetGetCookieEx2(const(wchar)* pcwszUrl, const(wchar)* pcwszCookieName, uint dwFlags, INTERNET_COOKIE2** ppCookies, uint* pdwCookieCount);

@DllImport("WININET.dll")
uint InternetSetCookieEx2(const(wchar)* pcwszUrl, const(INTERNET_COOKIE2)* pCookie, const(wchar)* pcwszP3PPolicy, uint dwFlags, uint* pdwCookieState);

@DllImport("WININET.dll")
uint InternetAttemptConnect(uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetCheckConnectionA(const(char)* lpszUrl, uint dwFlags, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetCheckConnectionW(const(wchar)* lpszUrl, uint dwFlags, uint dwReserved);

@DllImport("WININET.dll")
BOOL ResumeSuspendedDownload(void* hRequest, uint dwResultCode);

@DllImport("WININET.dll")
uint InternetErrorDlg(HWND hWnd, void* hRequest, uint dwError, uint dwFlags, void** lppvData);

@DllImport("WININET.dll")
uint InternetConfirmZoneCrossingA(HWND hWnd, const(char)* szUrlPrev, const(char)* szUrlNew, BOOL bPost);

@DllImport("WININET.dll")
uint InternetConfirmZoneCrossingW(HWND hWnd, const(wchar)* szUrlPrev, const(wchar)* szUrlNew, BOOL bPost);

@DllImport("WININET.dll")
uint InternetConfirmZoneCrossing(HWND hWnd, const(char)* szUrlPrev, const(char)* szUrlNew, BOOL bPost);

@DllImport("WININET.dll")
BOOL CreateUrlCacheEntryA(const(char)* lpszUrlName, uint dwExpectedFileSize, const(char)* lpszFileExtension, const(char)* lpszFileName, uint dwReserved);

@DllImport("WININET.dll")
BOOL CreateUrlCacheEntryW(const(wchar)* lpszUrlName, uint dwExpectedFileSize, const(wchar)* lpszFileExtension, const(wchar)* lpszFileName, uint dwReserved);

@DllImport("WININET.dll")
BOOL CommitUrlCacheEntryA(const(char)* lpszUrlName, const(char)* lpszLocalFileName, FILETIME ExpireTime, FILETIME LastModifiedTime, uint CacheEntryType, char* lpHeaderInfo, uint cchHeaderInfo, const(char)* lpszFileExtension, const(char)* lpszOriginalUrl);

@DllImport("WININET.dll")
BOOL CommitUrlCacheEntryW(const(wchar)* lpszUrlName, const(wchar)* lpszLocalFileName, FILETIME ExpireTime, FILETIME LastModifiedTime, uint CacheEntryType, const(wchar)* lpszHeaderInfo, uint cchHeaderInfo, const(wchar)* lpszFileExtension, const(wchar)* lpszOriginalUrl);

@DllImport("WININET.dll")
BOOL RetrieveUrlCacheEntryFileA(const(char)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, uint dwReserved);

@DllImport("WININET.dll")
BOOL RetrieveUrlCacheEntryFileW(const(wchar)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, uint dwReserved);

@DllImport("WININET.dll")
BOOL UnlockUrlCacheEntryFileA(const(char)* lpszUrlName, uint dwReserved);

@DllImport("WININET.dll")
BOOL UnlockUrlCacheEntryFileW(const(wchar)* lpszUrlName, uint dwReserved);

@DllImport("WININET.dll")
BOOL UnlockUrlCacheEntryFile(const(char)* lpszUrlName, uint dwReserved);

@DllImport("WININET.dll")
HANDLE RetrieveUrlCacheEntryStreamA(const(char)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, BOOL fRandomRead, uint dwReserved);

@DllImport("WININET.dll")
HANDLE RetrieveUrlCacheEntryStreamW(const(wchar)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, BOOL fRandomRead, uint dwReserved);

@DllImport("WININET.dll")
BOOL ReadUrlCacheEntryStream(HANDLE hUrlCacheStream, uint dwLocation, char* lpBuffer, uint* lpdwLen, uint Reserved);

@DllImport("WININET.dll")
BOOL ReadUrlCacheEntryStreamEx(HANDLE hUrlCacheStream, ulong qwLocation, char* lpBuffer, uint* lpdwLen);

@DllImport("WININET.dll")
BOOL UnlockUrlCacheEntryStream(HANDLE hUrlCacheStream, uint Reserved);

@DllImport("WININET.dll")
BOOL GetUrlCacheEntryInfoA(const(char)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET.dll")
BOOL GetUrlCacheEntryInfoW(const(wchar)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET.dll")
HANDLE FindFirstUrlCacheGroup(uint dwFlags, uint dwFilter, void* lpSearchCondition, uint dwSearchCondition, long* lpGroupId, void* lpReserved);

@DllImport("WININET.dll")
BOOL FindNextUrlCacheGroup(HANDLE hFind, long* lpGroupId, void* lpReserved);

@DllImport("WININET.dll")
BOOL GetUrlCacheGroupAttributeA(long gid, uint dwFlags, uint dwAttributes, char* lpGroupInfo, uint* lpcbGroupInfo, void* lpReserved);

@DllImport("WININET.dll")
BOOL GetUrlCacheGroupAttributeW(long gid, uint dwFlags, uint dwAttributes, char* lpGroupInfo, uint* lpcbGroupInfo, void* lpReserved);

@DllImport("WININET.dll")
BOOL SetUrlCacheGroupAttributeA(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOA* lpGroupInfo, void* lpReserved);

@DllImport("WININET.dll")
BOOL SetUrlCacheGroupAttributeW(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOW* lpGroupInfo, void* lpReserved);

@DllImport("WININET.dll")
BOOL GetUrlCacheEntryInfoExA(const(char)* lpszUrl, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, const(char)* lpszRedirectUrl, uint* lpcbRedirectUrl, void* lpReserved, uint dwFlags);

@DllImport("WININET.dll")
BOOL GetUrlCacheEntryInfoExW(const(wchar)* lpszUrl, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, const(wchar)* lpszRedirectUrl, uint* lpcbRedirectUrl, void* lpReserved, uint dwFlags);

@DllImport("WININET.dll")
BOOL SetUrlCacheEntryInfoA(const(char)* lpszUrlName, INTERNET_CACHE_ENTRY_INFOA* lpCacheEntryInfo, uint dwFieldControl);

@DllImport("WININET.dll")
BOOL SetUrlCacheEntryInfoW(const(wchar)* lpszUrlName, INTERNET_CACHE_ENTRY_INFOW* lpCacheEntryInfo, uint dwFieldControl);

@DllImport("WININET.dll")
long CreateUrlCacheGroup(uint dwFlags, void* lpReserved);

@DllImport("WININET.dll")
BOOL DeleteUrlCacheGroup(long GroupId, uint dwFlags, void* lpReserved);

@DllImport("WININET.dll")
BOOL SetUrlCacheEntryGroupA(const(char)* lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, uint cbGroupAttributes, void* lpReserved);

@DllImport("WININET.dll")
BOOL SetUrlCacheEntryGroupW(const(wchar)* lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, uint cbGroupAttributes, void* lpReserved);

@DllImport("WININET.dll")
BOOL SetUrlCacheEntryGroup(const(char)* lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, uint cbGroupAttributes, void* lpReserved);

@DllImport("WININET.dll")
HANDLE FindFirstUrlCacheEntryExA(const(char)* lpszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, char* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo, void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET.dll")
HANDLE FindFirstUrlCacheEntryExW(const(wchar)* lpszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, char* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo, void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET.dll")
BOOL FindNextUrlCacheEntryExA(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo, void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET.dll")
BOOL FindNextUrlCacheEntryExW(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo, void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET.dll")
HANDLE FindFirstUrlCacheEntryA(const(char)* lpszUrlSearchPattern, char* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET.dll")
HANDLE FindFirstUrlCacheEntryW(const(wchar)* lpszUrlSearchPattern, char* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET.dll")
BOOL FindNextUrlCacheEntryA(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET.dll")
BOOL FindNextUrlCacheEntryW(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET.dll")
BOOL FindCloseUrlCache(HANDLE hEnumHandle);

@DllImport("WININET.dll")
BOOL DeleteUrlCacheEntryA(const(char)* lpszUrlName);

@DllImport("WININET.dll")
BOOL DeleteUrlCacheEntryW(const(wchar)* lpszUrlName);

@DllImport("WININET.dll")
BOOL DeleteUrlCacheEntry(const(char)* lpszUrlName);

@DllImport("WININET.dll")
uint InternetDialA(HWND hwndParent, const(char)* lpszConnectoid, uint dwFlags, uint* lpdwConnection, uint dwReserved);

@DllImport("WININET.dll")
uint InternetDialW(HWND hwndParent, const(wchar)* lpszConnectoid, uint dwFlags, uint* lpdwConnection, uint dwReserved);

@DllImport("WININET.dll")
uint InternetDial(HWND hwndParent, const(char)* lpszConnectoid, uint dwFlags, uint* lpdwConnection, uint dwReserved);

@DllImport("WININET.dll")
uint InternetHangUp(uint dwConnection, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetGoOnlineA(const(char)* lpszURL, HWND hwndParent, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetGoOnlineW(const(wchar)* lpszURL, HWND hwndParent, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetGoOnline(const(char)* lpszURL, HWND hwndParent, uint dwFlags);

@DllImport("WININET.dll")
BOOL InternetAutodial(uint dwFlags, HWND hwndParent);

@DllImport("WININET.dll")
BOOL InternetAutodialHangup(uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetGetConnectedState(uint* lpdwFlags, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetGetConnectedStateExA(uint* lpdwFlags, const(char)* lpszConnectionName, uint cchNameLen, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetGetConnectedStateExW(uint* lpdwFlags, const(wchar)* lpszConnectionName, uint cchNameLen, uint dwReserved);

@DllImport("WININET.dll")
BOOL DeleteWpadCacheForNetworks(WPAD_CACHE_DELETE param0);

@DllImport("WININET.dll")
BOOL InternetInitializeAutoProxyDll(uint dwReserved);

@DllImport("WININET.dll")
BOOL DetectAutoProxyUrl(const(char)* pszAutoProxyUrl, uint cchAutoProxyUrl, uint dwDetectFlags);

@DllImport("WININET.dll")
BOOL CreateMD5SSOHash(const(wchar)* pszChallengeInfo, const(wchar)* pwszRealm, const(wchar)* pwszTarget, ubyte* pbHexHash);

@DllImport("WININET.dll")
BOOL InternetGetConnectedStateEx(uint* lpdwFlags, const(char)* lpszConnectionName, uint dwNameLen, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetSetDialStateA(const(char)* lpszConnectoid, uint dwState, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetSetDialStateW(const(wchar)* lpszConnectoid, uint dwState, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetSetDialState(const(char)* lpszConnectoid, uint dwState, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetSetPerSiteCookieDecisionA(const(char)* pchHostName, uint dwDecision);

@DllImport("WININET.dll")
BOOL InternetSetPerSiteCookieDecisionW(const(wchar)* pchHostName, uint dwDecision);

@DllImport("WININET.dll")
BOOL InternetGetPerSiteCookieDecisionA(const(char)* pchHostName, uint* pResult);

@DllImport("WININET.dll")
BOOL InternetGetPerSiteCookieDecisionW(const(wchar)* pchHostName, uint* pResult);

@DllImport("WININET.dll")
BOOL InternetClearAllPerSiteCookieDecisions();

@DllImport("WININET.dll")
BOOL InternetEnumPerSiteCookieDecisionA(const(char)* pszSiteName, uint* pcSiteNameSize, uint* pdwDecision, uint dwIndex);

@DllImport("WININET.dll")
BOOL InternetEnumPerSiteCookieDecisionW(const(wchar)* pszSiteName, uint* pcSiteNameSize, uint* pdwDecision, uint dwIndex);

@DllImport("WININET.dll")
uint PrivacySetZonePreferenceW(uint dwZone, uint dwType, uint dwTemplate, const(wchar)* pszPreference);

@DllImport("WININET.dll")
uint PrivacyGetZonePreferenceW(uint dwZone, uint dwType, uint* pdwTemplate, const(wchar)* pszBuffer, uint* pdwBufferLength);

@DllImport("WININET.dll")
uint HttpIsHostHstsEnabled(const(wchar)* pcwszUrl, int* pfIsHsts);

@DllImport("WININET.dll")
BOOL InternetAlgIdToStringA(uint ai, const(char)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetAlgIdToStringW(uint ai, const(wchar)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetSecurityProtocolToStringA(uint dwProtocol, const(char)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetSecurityProtocolToStringW(uint dwProtocol, const(wchar)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetGetSecurityInfoByURLA(const(char)* lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET.dll")
BOOL InternetGetSecurityInfoByURLW(const(wchar)* lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET.dll")
BOOL InternetGetSecurityInfoByURL(const(char)* lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET.dll")
uint ShowSecurityInfo(HWND hWndParent, INTERNET_SECURITY_INFO* pSecurityInfo);

@DllImport("WININET.dll")
uint ShowX509EncodedCertificate(HWND hWndParent, char* lpCert, uint cbCert);

@DllImport("WININET.dll")
uint ShowClientAuthCerts(HWND hWndParent);

@DllImport("WININET.dll")
uint ParseX509EncodedCertificateForListBoxEntry(char* lpCert, uint cbCert, const(char)* lpszListBoxEntry, uint* lpdwListBoxEntry);

@DllImport("WININET.dll")
BOOL InternetShowSecurityInfoByURLA(const(char)* lpszURL, HWND hwndParent);

@DllImport("WININET.dll")
BOOL InternetShowSecurityInfoByURLW(const(wchar)* lpszURL, HWND hwndParent);

@DllImport("WININET.dll")
BOOL InternetShowSecurityInfoByURL(const(char)* lpszURL, HWND hwndParent);

@DllImport("WININET.dll")
BOOL InternetFortezzaCommand(uint dwCommand, HWND hwnd, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetQueryFortezzaStatus(uint* pdwStatus, uint dwReserved);

@DllImport("WININET.dll")
BOOL InternetWriteFileExA(void* hFile, INTERNET_BUFFERSA* lpBuffersIn, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
BOOL InternetWriteFileExW(void* hFile, INTERNET_BUFFERSW* lpBuffersIn, uint dwFlags, uint dwContext);

@DllImport("WININET.dll")
int FindP3PPolicySymbol(const(byte)* pszSymbol);

@DllImport("WININET.dll")
uint HttpGetServerCredentials(const(wchar)* pwszUrl, ushort** ppwszUserName, ushort** ppwszPassword);

@DllImport("WININET.dll")
uint HttpPushEnable(void* hRequest, HTTP_PUSH_TRANSPORT_SETTING* pTransportSetting, HTTP_PUSH_WAIT_HANDLE__** phWait);

@DllImport("WININET.dll")
uint HttpPushWait(HTTP_PUSH_WAIT_HANDLE__* hWait, HTTP_PUSH_WAIT_TYPE eType, HTTP_PUSH_NOTIFICATION_STATUS* pNotificationStatus);

@DllImport("WININET.dll")
void HttpPushClose(HTTP_PUSH_WAIT_HANDLE__* hWait);

@DllImport("WININET.dll")
BOOL HttpCheckDavComplianceA(const(char)* lpszUrl, const(char)* lpszComplianceToken, int* lpfFound, HWND hWnd, void* lpvReserved);

@DllImport("WININET.dll")
BOOL HttpCheckDavComplianceW(const(wchar)* lpszUrl, const(wchar)* lpszComplianceToken, int* lpfFound, HWND hWnd, void* lpvReserved);

@DllImport("WININET.dll")
BOOL IsUrlCacheEntryExpiredA(const(char)* lpszUrlName, uint dwFlags, FILETIME* pftLastModified);

@DllImport("WININET.dll")
BOOL IsUrlCacheEntryExpiredW(const(wchar)* lpszUrlName, uint dwFlags, FILETIME* pftLastModified);

@DllImport("WININET.dll")
BOOL CreateUrlCacheEntryExW(const(wchar)* lpszUrlName, uint dwExpectedFileSize, const(wchar)* lpszFileExtension, const(wchar)* lpszFileName, uint dwReserved, BOOL fPreserveIncomingFileName);

@DllImport("WININET.dll")
uint GetUrlCacheEntryBinaryBlob(const(wchar)* pwszUrlName, uint* dwType, FILETIME* pftExpireTime, FILETIME* pftAccessTime, FILETIME* pftModifiedTime, char* ppbBlob, uint* pcbBlob);

@DllImport("WININET.dll")
uint CommitUrlCacheEntryBinaryBlob(const(wchar)* pwszUrlName, uint dwType, FILETIME ftExpireTime, FILETIME ftModifiedTime, char* pbBlob, uint cbBlob);

@DllImport("WININET.dll")
BOOL CreateUrlCacheContainerA(const(char)* Name, const(char)* lpCachePrefix, const(char)* lpszCachePath, uint KBCacheLimit, uint dwContainerType, uint dwOptions, void* pvBuffer, uint* cbBuffer);

@DllImport("WININET.dll")
BOOL CreateUrlCacheContainerW(const(wchar)* Name, const(wchar)* lpCachePrefix, const(wchar)* lpszCachePath, uint KBCacheLimit, uint dwContainerType, uint dwOptions, void* pvBuffer, uint* cbBuffer);

@DllImport("WININET.dll")
BOOL DeleteUrlCacheContainerA(const(char)* Name, uint dwOptions);

@DllImport("WININET.dll")
BOOL DeleteUrlCacheContainerW(const(wchar)* Name, uint dwOptions);

@DllImport("WININET.dll")
HANDLE FindFirstUrlCacheContainerA(uint* pdwModified, char* lpContainerInfo, uint* lpcbContainerInfo, uint dwOptions);

@DllImport("WININET.dll")
HANDLE FindFirstUrlCacheContainerW(uint* pdwModified, char* lpContainerInfo, uint* lpcbContainerInfo, uint dwOptions);

@DllImport("WININET.dll")
BOOL FindNextUrlCacheContainerA(HANDLE hEnumHandle, char* lpContainerInfo, uint* lpcbContainerInfo);

@DllImport("WININET.dll")
BOOL FindNextUrlCacheContainerW(HANDLE hEnumHandle, char* lpContainerInfo, uint* lpcbContainerInfo);

@DllImport("WININET.dll")
BOOL FreeUrlCacheSpaceA(const(char)* lpszCachePath, uint dwSize, uint dwFilter);

@DllImport("WININET.dll")
BOOL FreeUrlCacheSpaceW(const(wchar)* lpszCachePath, uint dwSize, uint dwFilter);

@DllImport("WININET.dll")
uint UrlCacheFreeGlobalSpace(ulong ullTargetSize, uint dwFilter);

@DllImport("WININET.dll")
uint UrlCacheGetGlobalCacheSize(uint dwFilter, ulong* pullSize, ulong* pullLimit);

@DllImport("WININET.dll")
BOOL GetUrlCacheConfigInfoA(INTERNET_CACHE_CONFIG_INFOA* lpCacheConfigInfo, uint* lpcbCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET.dll")
BOOL GetUrlCacheConfigInfoW(INTERNET_CACHE_CONFIG_INFOW* lpCacheConfigInfo, uint* lpcbCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET.dll")
BOOL SetUrlCacheConfigInfoA(INTERNET_CACHE_CONFIG_INFOA* lpCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET.dll")
BOOL SetUrlCacheConfigInfoW(INTERNET_CACHE_CONFIG_INFOW* lpCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET.dll")
uint RunOnceUrlCache(HWND hwnd, HINSTANCE hinst, const(char)* lpszCmd, int nCmdShow);

@DllImport("WININET.dll")
uint DeleteIE3Cache(HWND hwnd, HINSTANCE hinst, const(char)* lpszCmd, int nCmdShow);

@DllImport("WININET.dll")
BOOL UpdateUrlCacheContentPath(const(char)* szNewPath);

@DllImport("WININET.dll")
BOOL RegisterUrlCacheNotification(HWND hWnd, uint uMsg, long gid, uint dwOpsFilter, uint dwReserved);

@DllImport("WININET.dll")
BOOL GetUrlCacheHeaderData(uint nIdx, uint* lpdwData);

@DllImport("WININET.dll")
BOOL SetUrlCacheHeaderData(uint nIdx, uint dwData);

@DllImport("WININET.dll")
BOOL IncrementUrlCacheHeaderData(uint nIdx, uint* lpdwData);

@DllImport("WININET.dll")
BOOL LoadUrlCacheContent();

@DllImport("WININET.dll")
uint AppCacheLookup(const(wchar)* pwszUrl, uint dwFlags, void** phAppCache);

@DllImport("WININET.dll")
uint AppCacheCheckManifest(const(wchar)* pwszMasterUrl, const(wchar)* pwszManifestUrl, char* pbManifestData, uint dwManifestDataSize, char* pbManifestResponseHeaders, uint dwManifestResponseHeadersSize, APP_CACHE_STATE* peState, void** phNewAppCache);

@DllImport("WININET.dll")
uint AppCacheGetDownloadList(void* hAppCache, APP_CACHE_DOWNLOAD_LIST* pDownloadList);

@DllImport("WININET.dll")
void AppCacheFreeDownloadList(APP_CACHE_DOWNLOAD_LIST* pDownloadList);

@DllImport("WININET.dll")
uint AppCacheFinalize(void* hAppCache, char* pbManifestData, uint dwManifestDataSize, APP_CACHE_FINALIZE_STATE* peState);

@DllImport("WININET.dll")
uint AppCacheGetFallbackUrl(void* hAppCache, const(wchar)* pwszUrl, ushort** ppwszFallbackUrl);

@DllImport("WININET.dll")
uint AppCacheGetManifestUrl(void* hAppCache, ushort** ppwszManifestUrl);

@DllImport("WININET.dll")
uint AppCacheDuplicateHandle(void* hAppCache, void** phDuplicatedAppCache);

@DllImport("WININET.dll")
void AppCacheCloseHandle(void* hAppCache);

@DllImport("WININET.dll")
void AppCacheFreeGroupList(APP_CACHE_GROUP_LIST* pAppCacheGroupList);

@DllImport("WININET.dll")
uint AppCacheGetGroupList(APP_CACHE_GROUP_LIST* pAppCacheGroupList);

@DllImport("WININET.dll")
uint AppCacheGetInfo(void* hAppCache, APP_CACHE_GROUP_INFO* pAppCacheInfo);

@DllImport("WININET.dll")
uint AppCacheDeleteGroup(const(wchar)* pwszManifestUrl);

@DllImport("WININET.dll")
uint AppCacheFreeSpace(FILETIME ftCutOff);

@DllImport("WININET.dll")
uint AppCacheGetIEGroupList(APP_CACHE_GROUP_LIST* pAppCacheGroupList);

@DllImport("WININET.dll")
uint AppCacheDeleteIEGroup(const(wchar)* pwszManifestUrl);

@DllImport("WININET.dll")
uint AppCacheFreeIESpace(FILETIME ftCutOff);

@DllImport("WININET.dll")
uint AppCacheCreateAndCommitFile(void* hAppCache, const(wchar)* pwszSourceFilePath, const(wchar)* pwszUrl, char* pbResponseHeaders, uint dwResponseHeadersSize);

@DllImport("WININET.dll")
uint HttpOpenDependencyHandle(void* hRequestHandle, BOOL fBackground, void** phDependencyHandle);

@DllImport("WININET.dll")
void HttpCloseDependencyHandle(void* hDependencyHandle);

@DllImport("WININET.dll")
uint HttpDuplicateDependencyHandle(void* hDependencyHandle, void** phDuplicatedDependencyHandle);

@DllImport("WININET.dll")
uint HttpIndicatePageLoadComplete(void* hDependencyHandle);

@DllImport("WININET.dll")
void UrlCacheFreeEntryInfo(URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET.dll")
uint UrlCacheGetEntryInfo(void* hAppCache, const(wchar)* pcwszUrl, URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET.dll")
void UrlCacheCloseEntryHandle(void* hEntryFile);

@DllImport("WININET.dll")
uint UrlCacheRetrieveEntryFile(void* hAppCache, const(wchar)* pcwszUrl, URLCACHE_ENTRY_INFO* pCacheEntryInfo, void** phEntryFile);

@DllImport("WININET.dll")
uint UrlCacheReadEntryStream(void* hUrlCacheStream, ulong ullLocation, void* pBuffer, uint dwBufferLen, uint* pdwBufferLen);

@DllImport("WININET.dll")
uint UrlCacheRetrieveEntryStream(void* hAppCache, const(wchar)* pcwszUrl, BOOL fRandomRead, URLCACHE_ENTRY_INFO* pCacheEntryInfo, void** phEntryStream);

@DllImport("WININET.dll")
uint UrlCacheUpdateEntryExtraData(void* hAppCache, const(wchar)* pcwszUrl, char* pbExtraData, uint cbExtraData);

@DllImport("WININET.dll")
uint UrlCacheCreateContainer(const(wchar)* pwszName, const(wchar)* pwszPrefix, const(wchar)* pwszDirectory, ulong ullLimit, uint dwOptions);

@DllImport("WININET.dll")
uint UrlCacheCheckEntriesExist(char* rgpwszUrls, uint cEntries, char* rgfExist);

@DllImport("WININET.dll")
uint UrlCacheGetContentPaths(ushort*** pppwszDirectories, uint* pcDirectories);

@DllImport("WININET.dll")
uint UrlCacheGetGlobalLimit(URL_CACHE_LIMIT_TYPE limitType, ulong* pullLimit);

@DllImport("WININET.dll")
uint UrlCacheSetGlobalLimit(URL_CACHE_LIMIT_TYPE limitType, ulong ullLimit);

@DllImport("WININET.dll")
uint UrlCacheReloadSettings();

@DllImport("WININET.dll")
uint UrlCacheContainerSetEntryMaximumAge(const(wchar)* pwszPrefix, uint dwEntryMaxAge);

@DllImport("WININET.dll")
uint UrlCacheFindFirstEntry(const(wchar)* pwszPrefix, uint dwFlags, uint dwFilter, long GroupId, URLCACHE_ENTRY_INFO* pCacheEntryInfo, HANDLE* phFind);

@DllImport("WININET.dll")
uint UrlCacheFindNextEntry(HANDLE hFind, URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET.dll")
uint UrlCacheServer();

@DllImport("WININET.dll")
BOOL ReadGuidsForConnectedNetworks(uint* pcNetworks, ushort*** pppwszNetworkGuids, BSTR** pppbstrNetworkNames, ushort*** pppwszGWMacs, uint* pcGatewayMacs, uint* pdwFlags);

@DllImport("WININET.dll")
BOOL IsHostInProxyBypassList(INTERNET_SCHEME tScheme, const(char)* lpszHost, uint cchHost);

@DllImport("WININET.dll")
void InternetFreeProxyInfoList(WININET_PROXY_INFO_LIST* pProxyInfoList);

@DllImport("WININET.dll")
uint InternetGetProxyForUrl(void* hInternet, const(wchar)* pcwszUrl, WININET_PROXY_INFO_LIST* pProxyInfoList);

@DllImport("WININET.dll")
BOOL DoConnectoidsExist();

@DllImport("WININET.dll")
BOOL GetDiskInfoA(const(char)* pszPath, uint* pdwClusterSize, ulong* pdlAvail, ulong* pdlTotal);

@DllImport("WININET.dll")
BOOL PerformOperationOverUrlCacheA(const(char)* pszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, void* pReserved1, uint* pdwReserved2, void* pReserved3, CACHE_OPERATOR op, void* pOperatorData);

@DllImport("WININET.dll")
BOOL IsProfilesEnabled();

@DllImport("WININET.dll")
uint InternalInternetGetCookie(const(char)* lpszUrl, const(char)* lpszCookieData, uint* lpdwDataSize);

@DllImport("WININET.dll")
BOOL ImportCookieFileA(const(char)* szFilename);

@DllImport("WININET.dll")
BOOL ImportCookieFileW(const(wchar)* szFilename);

@DllImport("WININET.dll")
BOOL ExportCookieFileA(const(char)* szFilename, BOOL fAppend);

@DllImport("WININET.dll")
BOOL ExportCookieFileW(const(wchar)* szFilename, BOOL fAppend);

@DllImport("WININET.dll")
BOOL IsDomainLegalCookieDomainA(const(char)* pchDomain, const(char)* pchFullDomain);

@DllImport("WININET.dll")
BOOL IsDomainLegalCookieDomainW(const(wchar)* pchDomain, const(wchar)* pchFullDomain);

@DllImport("WININET.dll")
void* HttpWebSocketCompleteUpgrade(void* hRequest, uint dwContext);

@DllImport("WININET.dll")
BOOL HttpWebSocketSend(void* hWebSocket, HTTP_WEB_SOCKET_BUFFER_TYPE BufferType, char* pvBuffer, uint dwBufferLength);

@DllImport("WININET.dll")
BOOL HttpWebSocketReceive(void* hWebSocket, char* pvBuffer, uint dwBufferLength, uint* pdwBytesRead, HTTP_WEB_SOCKET_BUFFER_TYPE* pBufferType);

@DllImport("WININET.dll")
BOOL HttpWebSocketClose(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WININET.dll")
BOOL HttpWebSocketShutdown(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WININET.dll")
BOOL HttpWebSocketQueryCloseStatus(void* hWebSocket, ushort* pusStatus, char* pvReason, uint dwReasonLength, uint* pdwReasonLengthConsumed);

@DllImport("WININET.dll")
uint InternetConvertUrlFromWireToWideChar(const(char)* pcszUrl, uint cchUrl, const(wchar)* pcwszBaseUrl, uint dwCodePageHost, uint dwCodePagePath, BOOL fEncodePathExtra, uint dwCodePageExtra, ushort** ppwszConvertedUrl);

