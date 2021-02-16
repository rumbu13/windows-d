module windows.wininet;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.filesystem : WIN32_FIND_DATAA, WIN32_FIND_DATAW;
public import windows.gdi : HBITMAP;
public import windows.security : CERT_CHAIN_CONTEXT, CERT_CONTEXT, SecPkgContext_Bindings, SecPkgContext_CipherInfo,
                                 SecPkgContext_ConnectionInfo;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    INTERNET_SCHEME_PARTIAL    = 0xfffffffe,
    INTERNET_SCHEME_UNKNOWN    = 0xffffffff,
    INTERNET_SCHEME_DEFAULT    = 0x00000000,
    INTERNET_SCHEME_FTP        = 0x00000001,
    INTERNET_SCHEME_GOPHER     = 0x00000002,
    INTERNET_SCHEME_HTTP       = 0x00000003,
    INTERNET_SCHEME_HTTPS      = 0x00000004,
    INTERNET_SCHEME_FILE       = 0x00000005,
    INTERNET_SCHEME_NEWS       = 0x00000006,
    INTERNET_SCHEME_MAILTO     = 0x00000007,
    INTERNET_SCHEME_SOCKS      = 0x00000008,
    INTERNET_SCHEME_JAVASCRIPT = 0x00000009,
    INTERNET_SCHEME_VBSCRIPT   = 0x0000000a,
    INTERNET_SCHEME_RES        = 0x0000000b,
    INTERNET_SCHEME_FIRST      = 0x00000001,
    INTERNET_SCHEME_LAST       = 0x0000000b,
}
alias INTERNET_SCHEME = int;

enum InternetCookieState : int
{
    COOKIE_STATE_UNKNOWN   = 0x00000000,
    COOKIE_STATE_ACCEPT    = 0x00000001,
    COOKIE_STATE_PROMPT    = 0x00000002,
    COOKIE_STATE_LEASH     = 0x00000003,
    COOKIE_STATE_DOWNGRADE = 0x00000004,
    COOKIE_STATE_REJECT    = 0x00000005,
    COOKIE_STATE_MAX       = 0x00000005,
}

enum : int
{
    WPAD_CACHE_DELETE_CURRENT = 0x00000000,
    WPAD_CACHE_DELETE_ALL     = 0x00000001,
}
alias WPAD_CACHE_DELETE = int;

enum : int
{
    FORTCMD_LOGON           = 0x00000001,
    FORTCMD_LOGOFF          = 0x00000002,
    FORTCMD_CHG_PERSONALITY = 0x00000003,
}
alias FORTCMD = int;

enum : int
{
    FORTSTAT_INSTALLED = 0x00000001,
    FORTSTAT_LOGGEDON  = 0x00000002,
}
alias FORTSTAT = int;

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
alias REQUEST_TIMES = int;

enum : int
{
    HttpPushWaitEnableComplete  = 0x00000000,
    HttpPushWaitReceiveComplete = 0x00000001,
    HttpPushWaitSendComplete    = 0x00000002,
}
alias HTTP_PUSH_WAIT_TYPE = int;

enum : int
{
    WININET_SYNC_MODE_NEVER            = 0x00000000,
    WININET_SYNC_MODE_ON_EXPIRY        = 0x00000001,
    WININET_SYNC_MODE_ONCE_PER_SESSION = 0x00000002,
    WININET_SYNC_MODE_ALWAYS           = 0x00000003,
    WININET_SYNC_MODE_AUTOMATIC        = 0x00000004,
    WININET_SYNC_MODE_DEFAULT          = 0x00000004,
}
alias WININET_SYNC_MODE = int;

enum : int
{
    AppCacheStateNoUpdateNeeded         = 0x00000000,
    AppCacheStateUpdateNeeded           = 0x00000001,
    AppCacheStateUpdateNeededNew        = 0x00000002,
    AppCacheStateUpdateNeededMasterOnly = 0x00000003,
}
alias APP_CACHE_STATE = int;

enum : int
{
    AppCacheFinalizeStateIncomplete     = 0x00000000,
    AppCacheFinalizeStateManifestChange = 0x00000001,
    AppCacheFinalizeStateComplete       = 0x00000002,
}
alias APP_CACHE_FINALIZE_STATE = int;

enum : int
{
    UrlCacheLimitTypeIE                = 0x00000000,
    UrlCacheLimitTypeIETotal           = 0x00000001,
    UrlCacheLimitTypeAppContainer      = 0x00000002,
    UrlCacheLimitTypeAppContainerTotal = 0x00000003,
    UrlCacheLimitTypeNum               = 0x00000004,
}
alias URL_CACHE_LIMIT_TYPE = int;

enum : int
{
    HTTP_WEB_SOCKET_SEND_OPERATION     = 0x00000000,
    HTTP_WEB_SOCKET_RECEIVE_OPERATION  = 0x00000001,
    HTTP_WEB_SOCKET_CLOSE_OPERATION    = 0x00000002,
    HTTP_WEB_SOCKET_SHUTDOWN_OPERATION = 0x00000003,
}
alias HTTP_WEB_SOCKET_OPERATION = int;

enum : int
{
    HTTP_WEB_SOCKET_BINARY_MESSAGE_TYPE  = 0x00000000,
    HTTP_WEB_SOCKET_BINARY_FRAGMENT_TYPE = 0x00000001,
    HTTP_WEB_SOCKET_UTF8_MESSAGE_TYPE    = 0x00000002,
    HTTP_WEB_SOCKET_UTF8_FRAGMENT_TYPE   = 0x00000003,
    HTTP_WEB_SOCKET_CLOSE_TYPE           = 0x00000004,
    HTTP_WEB_SOCKET_PING_TYPE            = 0x00000005,
}
alias HTTP_WEB_SOCKET_BUFFER_TYPE = int;

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
alias HTTP_WEB_SOCKET_CLOSE_STATUS = int;

// Callbacks

alias INTERNET_STATUS_CALLBACK = void function(void* hInternet, size_t dwContext, uint dwInternetStatus, 
                                               void* lpvStatusInformation, uint dwStatusInformationLength);
alias LPINTERNET_STATUS_CALLBACK = void function();
alias GOPHER_ATTRIBUTE_ENUMERATOR = BOOL function(GOPHER_ATTRIBUTE_TYPE* lpAttributeInfo, uint dwError);
alias PFN_AUTH_NOTIFY = uint function(size_t param0, uint param1, void* param2);
alias pfnInternetInitializeAutoProxyDll = BOOL function(uint dwVersion, const(char)* lpszDownloadedTempFile, 
                                                        const(char)* lpszMime, 
                                                        AutoProxyHelperFunctions* lpAutoProxyCallbacks, 
                                                        AUTO_PROXY_SCRIPT_BUFFER* lpAutoProxyScriptBuffer);
alias pfnInternetDeInitializeAutoProxyDll = BOOL function(const(char)* lpszMime, uint dwReserved);
alias pfnInternetGetProxyInfo = BOOL function(const(char)* lpszUrl, uint dwUrlLength, const(char)* lpszUrlHostName, 
                                              uint dwUrlHostNameLength, byte** lplpszProxyHostName, 
                                              uint* lpdwProxyHostNameLength);
alias PFN_DIAL_HANDLER = uint function(HWND param0, const(char)* param1, uint param2, uint* param3);
alias CACHE_OPERATOR = BOOL function(INTERNET_CACHE_ENTRY_INFOA* pcei, uint* pcbcei, void* pOpData);

// Structs


struct HTTP_VERSION_INFO
{
    uint dwMajorVersion;
    uint dwMinorVersion;
}

struct INTERNET_ASYNC_RESULT
{
    size_t dwResult;
    uint   dwError;
}

struct INTERNET_DIAGNOSTIC_SOCKET_INFO
{
    size_t Socket;
    uint   SourcePort;
    uint   DestPort;
    uint   Flags;
}

struct INTERNET_PROXY_INFO
{
    uint  dwAccessType;
    byte* lpszProxy;
    byte* lpszProxyBypass;
}

struct INTERNET_PER_CONN_OPTIONA
{
    uint dwOption;
    union Value
    {
        uint         dwValue;
        const(char)* pszValue;
        FILETIME     ftValue;
    }
}

struct INTERNET_PER_CONN_OPTIONW
{
    uint dwOption;
    union Value
    {
        uint          dwValue;
        const(wchar)* pszValue;
        FILETIME      ftValue;
    }
}

struct INTERNET_PER_CONN_OPTION_LISTA
{
    uint         dwSize;
    const(char)* pszConnection;
    uint         dwOptionCount;
    uint         dwOptionError;
    INTERNET_PER_CONN_OPTIONA* pOptions;
}

struct INTERNET_PER_CONN_OPTION_LISTW
{
    uint          dwSize;
    const(wchar)* pszConnection;
    uint          dwOptionCount;
    uint          dwOptionError;
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
    uint            dwStructSize;
    const(char)*    lpszScheme;
    uint            dwSchemeLength;
    INTERNET_SCHEME nScheme;
    const(char)*    lpszHostName;
    uint            dwHostNameLength;
    ushort          nPort;
    const(char)*    lpszUserName;
    uint            dwUserNameLength;
    const(char)*    lpszPassword;
    uint            dwPasswordLength;
    const(char)*    lpszUrlPath;
    uint            dwUrlPathLength;
    const(char)*    lpszExtraInfo;
    uint            dwExtraInfoLength;
}

struct URL_COMPONENTSW
{
    uint            dwStructSize;
    const(wchar)*   lpszScheme;
    uint            dwSchemeLength;
    INTERNET_SCHEME nScheme;
    const(wchar)*   lpszHostName;
    uint            dwHostNameLength;
    ushort          nPort;
    const(wchar)*   lpszUserName;
    uint            dwUserNameLength;
    const(wchar)*   lpszPassword;
    uint            dwPasswordLength;
    const(wchar)*   lpszUrlPath;
    uint            dwUrlPathLength;
    const(wchar)*   lpszExtraInfo;
    uint            dwExtraInfoLength;
}

struct INTERNET_CERTIFICATE_INFO
{
    FILETIME ftExpiry;
    FILETIME ftStart;
    byte*    lpszSubjectInfo;
    byte*    lpszIssuerInfo;
    byte*    lpszProtocolName;
    byte*    lpszSignatureAlgName;
    byte*    lpszEncryptionAlgName;
    uint     dwKeySize;
}

struct INTERNET_BUFFERSA
{
    uint               dwStructSize;
    INTERNET_BUFFERSA* Next;
    const(char)*       lpcszHeader;
    uint               dwHeadersLength;
    uint               dwHeadersTotal;
    void*              lpvBuffer;
    uint               dwBufferLength;
    uint               dwBufferTotal;
    uint               dwOffsetLow;
    uint               dwOffsetHigh;
}

struct INTERNET_BUFFERSW
{
    uint               dwStructSize;
    INTERNET_BUFFERSW* Next;
    const(wchar)*      lpcszHeader;
    uint               dwHeadersLength;
    uint               dwHeadersTotal;
    void*              lpvBuffer;
    uint               dwBufferLength;
    uint               dwBufferTotal;
    uint               dwOffsetLow;
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
    byte[129] DisplayString;
    uint      GopherType;
    uint      SizeLow;
    uint      SizeHigh;
    FILETIME  LastModificationTime;
    byte[654] Locator;
}

struct GOPHER_FIND_DATAW
{
    ushort[129] DisplayString;
    uint        GopherType;
    uint        SizeLow;
    uint        SizeHigh;
    FILETIME    LastModificationTime;
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

struct GOPHER_ATTRIBUTE_TYPE
{
    uint CategoryId;
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

struct INTERNET_COOKIE2
{
    const(wchar)* pwszName;
    const(wchar)* pwszValue;
    const(wchar)* pwszDomain;
    const(wchar)* pwszPath;
    uint          dwFlags;
    FILETIME      ftExpires;
    BOOL          fExpiresSet;
}

struct INTERNET_AUTH_NOTIFY_DATA
{
    uint            cbStruct;
    uint            dwOptions;
    PFN_AUTH_NOTIFY pfnNotify;
    size_t          dwContext;
}

struct INTERNET_CACHE_ENTRY_INFOA
{
    uint         dwStructSize;
    const(char)* lpszSourceUrlName;
    const(char)* lpszLocalFileName;
    uint         CacheEntryType;
    uint         dwUseCount;
    uint         dwHitRate;
    uint         dwSizeLow;
    uint         dwSizeHigh;
    FILETIME     LastModifiedTime;
    FILETIME     ExpireTime;
    FILETIME     LastAccessTime;
    FILETIME     LastSyncTime;
    const(char)* lpHeaderInfo;
    uint         dwHeaderInfoSize;
    const(char)* lpszFileExtension;
    union
    {
        uint dwReserved;
        uint dwExemptDelta;
    }
}

struct INTERNET_CACHE_ENTRY_INFOW
{
    uint          dwStructSize;
    const(wchar)* lpszSourceUrlName;
    const(wchar)* lpszLocalFileName;
    uint          CacheEntryType;
    uint          dwUseCount;
    uint          dwHitRate;
    uint          dwSizeLow;
    uint          dwSizeHigh;
    FILETIME      LastModifiedTime;
    FILETIME      ExpireTime;
    FILETIME      LastAccessTime;
    FILETIME      LastSyncTime;
    const(wchar)* lpHeaderInfo;
    uint          dwHeaderInfoSize;
    const(wchar)* lpszFileExtension;
    union
    {
        uint dwReserved;
        uint dwExemptDelta;
    }
}

struct INTERNET_CACHE_TIMESTAMPS
{
    FILETIME ftExpires;
    FILETIME ftLastModified;
}

struct INTERNET_CACHE_GROUP_INFOA
{
    uint      dwGroupSize;
    uint      dwGroupFlags;
    uint      dwGroupType;
    uint      dwDiskUsage;
    uint      dwDiskQuota;
    uint[4]   dwOwnerStorage;
    byte[120] szGroupName;
}

struct INTERNET_CACHE_GROUP_INFOW
{
    uint        dwGroupSize;
    uint        dwGroupFlags;
    uint        dwGroupType;
    uint        dwDiskUsage;
    uint        dwDiskQuota;
    uint[4]     dwOwnerStorage;
    ushort[120] szGroupName;
}

struct AutoProxyHelperVtbl
{
    BOOL********** IsResolvable;
    ptrdiff_t      GetIPAddress;
    ptrdiff_t      ResolveHostName;
    BOOL********** IsInNet;
    BOOL********** IsResolvableEx;
    ptrdiff_t      GetIPAddressEx;
    ptrdiff_t      ResolveHostNameEx;
    BOOL********** IsInNetEx;
    ptrdiff_t      SortIpList;
}

struct AUTO_PROXY_SCRIPT_BUFFER
{
    uint         dwStructSize;
    const(char)* lpszScriptBuffer;
    uint         dwScriptBufferSize;
}

struct AutoProxyHelperFunctions
{
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
    const(wchar)* pcwszFileName;
    HANDLE*       phFile;
}

struct HTTP_REQUEST_TIMES
{
    uint      cTimes;
    ulong[32] rgTimes;
}

struct INTERNET_SERVER_CONNECTION_STATE
{
    const(wchar)* lpcwszHostName;
    BOOL          fProxy;
    uint          dwCounter;
    uint          dwConnectionLimit;
    uint          dwAvailableCreates;
    uint          dwAvailableKeepAlives;
    uint          dwActiveConnections;
    uint          dwWaiters;
}

struct INTERNET_END_BROWSER_SESSION_DATA
{
    void* lpBuffer;
    uint  dwBufferLength;
}

struct INTERNET_CALLBACK_COOKIE
{
    const(wchar)* pcwszName;
    const(wchar)* pcwszValue;
    const(wchar)* pcwszDomain;
    const(wchar)* pcwszPath;
    FILETIME      ftExpires;
    uint          dwFlags;
}

struct INTERNET_CREDENTIALS
{
    const(wchar)* lpcwszHostName;
    uint          dwPort;
    uint          dwScheme;
    const(wchar)* lpcwszUrl;
    const(wchar)* lpcwszRealm;
    BOOL          fAuthIdentity;
    union
    {
        struct
        {
            const(wchar)* lpcwszUserName;
            const(wchar)* lpcwszPassword;
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
    uint         cbSize;
    const(char)* pszName;
    const(char)* pszData;
    const(char)* pszDomain;
    const(char)* pszPath;
    FILETIME*    pftExpires;
    uint         dwFlags;
    const(char)* pszUrl;
    const(char)* pszP3PPolicy;
}

struct COOKIE_DLG_INFO
{
    const(wchar)*    pszServer;
    INTERNET_COOKIE* pic;
    uint             dwStopWarning;
    int              cx;
    int              cy;
    const(wchar)*    pszHeader;
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

struct INTERNET_CACHE_CONFIG_INFOA
{
    uint dwStructSize;
    uint dwContainer;
    uint dwQuota;
    uint dwReserved4;
    BOOL fPerUser;
    uint dwSyncMode;
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
    union
    {
        struct
        {
            ushort[260] CachePath;
            uint        dwCacheSize;
        }
        INTERNET_CACHE_CONFIG_PATH_ENTRYW[1] CachePaths;
    }
    uint dwNormalUsage;
    uint dwExemptUsage;
}

struct INTERNET_CACHE_CONTAINER_INFOA
{
    uint         dwCacheVersion;
    const(char)* lpszName;
    const(char)* lpszCachePrefix;
    const(char)* lpszVolumeLabel;
    const(char)* lpszVolumeTitle;
}

struct INTERNET_CACHE_CONTAINER_INFOW
{
    uint          dwCacheVersion;
    const(wchar)* lpszName;
    const(wchar)* lpszCachePrefix;
    const(wchar)* lpszVolumeLabel;
    const(wchar)* lpszVolumeTitle;
}

struct APP_CACHE_DOWNLOAD_ENTRY
{
    const(wchar)* pwszUrl;
    uint          dwEntryType;
}

struct APP_CACHE_DOWNLOAD_LIST
{
    uint dwEntryCount;
    APP_CACHE_DOWNLOAD_ENTRY* pEntries;
}

struct APP_CACHE_GROUP_INFO
{
    const(wchar)* pwszManifestUrl;
    FILETIME      ftLastAccessTime;
    ulong         ullSize;
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
    uint          dwCacheEntryType;
    uint          dwUseCount;
    uint          dwHitRate;
    uint          dwSizeLow;
    uint          dwSizeHigh;
    FILETIME      ftLastModifiedTime;
    FILETIME      ftExpireTime;
    FILETIME      ftLastAccessTime;
    FILETIME      ftLastSyncTime;
    ubyte*        pbHeaderInfo;
    uint          cbHeaderInfoSize;
    ubyte*        pbExtraData;
    uint          cbExtraDataSize;
}

struct WININET_PROXY_INFO
{
    BOOL            fProxy;
    BOOL            fBypass;
    INTERNET_SCHEME ProxyScheme;
    const(wchar)*   pwszProxy;
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
    const(wchar)* name;
    const(wchar)* data;
    uint          flags;
    const(wchar)* p3pHeader;
}

// Functions

@DllImport("WININET")
BOOL InternetTimeFromSystemTimeA(const(SYSTEMTIME)* pst, uint dwRFC, const(char)* lpszTime, uint cbTime);

@DllImport("WININET")
BOOL InternetTimeFromSystemTimeW(const(SYSTEMTIME)* pst, uint dwRFC, const(wchar)* lpszTime, uint cbTime);

@DllImport("WININET")
BOOL InternetTimeFromSystemTime(const(SYSTEMTIME)* pst, uint dwRFC, const(char)* lpszTime, uint cbTime);

@DllImport("WININET")
BOOL InternetTimeToSystemTimeA(const(char)* lpszTime, SYSTEMTIME* pst, uint dwReserved);

@DllImport("WININET")
BOOL InternetTimeToSystemTimeW(const(wchar)* lpszTime, SYSTEMTIME* pst, uint dwReserved);

@DllImport("WININET")
BOOL InternetTimeToSystemTime(const(char)* lpszTime, SYSTEMTIME* pst, uint dwReserved);

@DllImport("WININET")
BOOL InternetCrackUrlA(const(char)* lpszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTSA* lpUrlComponents);

@DllImport("WININET")
BOOL InternetCrackUrlW(const(wchar)* lpszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTSW* lpUrlComponents);

@DllImport("WININET")
BOOL InternetCreateUrlA(URL_COMPONENTSA* lpUrlComponents, uint dwFlags, const(char)* lpszUrl, uint* lpdwUrlLength);

@DllImport("WININET")
BOOL InternetCreateUrlW(URL_COMPONENTSW* lpUrlComponents, uint dwFlags, const(wchar)* lpszUrl, uint* lpdwUrlLength);

@DllImport("WININET")
BOOL InternetCanonicalizeUrlA(const(char)* lpszUrl, const(char)* lpszBuffer, uint* lpdwBufferLength, uint dwFlags);

@DllImport("WININET")
BOOL InternetCanonicalizeUrlW(const(wchar)* lpszUrl, const(wchar)* lpszBuffer, uint* lpdwBufferLength, 
                              uint dwFlags);

@DllImport("WININET")
BOOL InternetCombineUrlA(const(char)* lpszBaseUrl, const(char)* lpszRelativeUrl, const(char)* lpszBuffer, 
                         uint* lpdwBufferLength, uint dwFlags);

@DllImport("WININET")
BOOL InternetCombineUrlW(const(wchar)* lpszBaseUrl, const(wchar)* lpszRelativeUrl, const(wchar)* lpszBuffer, 
                         uint* lpdwBufferLength, uint dwFlags);

@DllImport("WININET")
void* InternetOpenA(const(char)* lpszAgent, uint dwAccessType, const(char)* lpszProxy, 
                    const(char)* lpszProxyBypass, uint dwFlags);

@DllImport("WININET")
void* InternetOpenW(const(wchar)* lpszAgent, uint dwAccessType, const(wchar)* lpszProxy, 
                    const(wchar)* lpszProxyBypass, uint dwFlags);

@DllImport("WININET")
BOOL InternetCloseHandle(void* hInternet);

@DllImport("WININET")
void* InternetConnectA(void* hInternet, const(char)* lpszServerName, ushort nServerPort, const(char)* lpszUserName, 
                       const(char)* lpszPassword, uint dwService, uint dwFlags, size_t dwContext);

@DllImport("WININET")
void* InternetConnectW(void* hInternet, const(wchar)* lpszServerName, ushort nServerPort, 
                       const(wchar)* lpszUserName, const(wchar)* lpszPassword, uint dwService, uint dwFlags, 
                       size_t dwContext);

@DllImport("WININET")
void* InternetOpenUrlA(void* hInternet, const(char)* lpszUrl, const(char)* lpszHeaders, uint dwHeadersLength, 
                       uint dwFlags, size_t dwContext);

@DllImport("WININET")
void* InternetOpenUrlW(void* hInternet, const(wchar)* lpszUrl, const(wchar)* lpszHeaders, uint dwHeadersLength, 
                       uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL InternetReadFile(void* hFile, char* lpBuffer, uint dwNumberOfBytesToRead, uint* lpdwNumberOfBytesRead);

@DllImport("WININET")
BOOL InternetReadFileExA(void* hFile, INTERNET_BUFFERSA* lpBuffersOut, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL InternetReadFileExW(void* hFile, INTERNET_BUFFERSW* lpBuffersOut, uint dwFlags, size_t dwContext);

@DllImport("WININET")
uint InternetSetFilePointer(void* hFile, int lDistanceToMove, int* lpDistanceToMoveHigh, uint dwMoveMethod, 
                            size_t dwContext);

@DllImport("WININET")
BOOL InternetWriteFile(void* hFile, char* lpBuffer, uint dwNumberOfBytesToWrite, uint* lpdwNumberOfBytesWritten);

@DllImport("WININET")
BOOL InternetQueryDataAvailable(void* hFile, uint* lpdwNumberOfBytesAvailable, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL InternetFindNextFileA(void* hFind, void* lpvFindData);

@DllImport("WININET")
BOOL InternetFindNextFileW(void* hFind, void* lpvFindData);

@DllImport("WININET")
BOOL InternetQueryOptionA(void* hInternet, uint dwOption, char* lpBuffer, uint* lpdwBufferLength);

@DllImport("WININET")
BOOL InternetQueryOptionW(void* hInternet, uint dwOption, char* lpBuffer, uint* lpdwBufferLength);

@DllImport("WININET")
BOOL InternetSetOptionA(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength);

@DllImport("WININET")
BOOL InternetSetOptionW(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength);

@DllImport("WININET")
BOOL InternetSetOptionExA(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength, uint dwFlags);

@DllImport("WININET")
BOOL InternetSetOptionExW(void* hInternet, uint dwOption, void* lpBuffer, uint dwBufferLength, uint dwFlags);

@DllImport("WININET")
BOOL InternetLockRequestFile(void* hInternet, HANDLE* lphLockRequestInfo);

@DllImport("WININET")
BOOL InternetUnlockRequestFile(HANDLE hLockRequestInfo);

@DllImport("WININET")
BOOL InternetGetLastResponseInfoA(uint* lpdwError, const(char)* lpszBuffer, uint* lpdwBufferLength);

@DllImport("WININET")
BOOL InternetGetLastResponseInfoW(uint* lpdwError, const(wchar)* lpszBuffer, uint* lpdwBufferLength);

@DllImport("WININET")
INTERNET_STATUS_CALLBACK InternetSetStatusCallbackA(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

@DllImport("WININET")
INTERNET_STATUS_CALLBACK InternetSetStatusCallbackW(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

@DllImport("WININET")
INTERNET_STATUS_CALLBACK InternetSetStatusCallback(void* hInternet, INTERNET_STATUS_CALLBACK lpfnInternetCallback);

@DllImport("WININET")
void* FtpFindFirstFileA(void* hConnect, const(char)* lpszSearchFile, WIN32_FIND_DATAA* lpFindFileData, 
                        uint dwFlags, size_t dwContext);

@DllImport("WININET")
void* FtpFindFirstFileW(void* hConnect, const(wchar)* lpszSearchFile, WIN32_FIND_DATAW* lpFindFileData, 
                        uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL FtpGetFileA(void* hConnect, const(char)* lpszRemoteFile, const(char)* lpszNewFile, BOOL fFailIfExists, 
                 uint dwFlagsAndAttributes, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL FtpGetFileW(void* hConnect, const(wchar)* lpszRemoteFile, const(wchar)* lpszNewFile, BOOL fFailIfExists, 
                 uint dwFlagsAndAttributes, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL FtpPutFileA(void* hConnect, const(char)* lpszLocalFile, const(char)* lpszNewRemoteFile, uint dwFlags, 
                 size_t dwContext);

@DllImport("WININET")
BOOL FtpPutFileW(void* hConnect, const(wchar)* lpszLocalFile, const(wchar)* lpszNewRemoteFile, uint dwFlags, 
                 size_t dwContext);

@DllImport("WININET")
BOOL FtpGetFileEx(void* hFtpSession, const(char)* lpszRemoteFile, const(wchar)* lpszNewFile, BOOL fFailIfExists, 
                  uint dwFlagsAndAttributes, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL FtpPutFileEx(void* hFtpSession, const(wchar)* lpszLocalFile, const(char)* lpszNewRemoteFile, uint dwFlags, 
                  size_t dwContext);

@DllImport("WININET")
BOOL FtpDeleteFileA(void* hConnect, const(char)* lpszFileName);

@DllImport("WININET")
BOOL FtpDeleteFileW(void* hConnect, const(wchar)* lpszFileName);

@DllImport("WININET")
BOOL FtpRenameFileA(void* hConnect, const(char)* lpszExisting, const(char)* lpszNew);

@DllImport("WININET")
BOOL FtpRenameFileW(void* hConnect, const(wchar)* lpszExisting, const(wchar)* lpszNew);

@DllImport("WININET")
void* FtpOpenFileA(void* hConnect, const(char)* lpszFileName, uint dwAccess, uint dwFlags, size_t dwContext);

@DllImport("WININET")
void* FtpOpenFileW(void* hConnect, const(wchar)* lpszFileName, uint dwAccess, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL FtpCreateDirectoryA(void* hConnect, const(char)* lpszDirectory);

@DllImport("WININET")
BOOL FtpCreateDirectoryW(void* hConnect, const(wchar)* lpszDirectory);

@DllImport("WININET")
BOOL FtpRemoveDirectoryA(void* hConnect, const(char)* lpszDirectory);

@DllImport("WININET")
BOOL FtpRemoveDirectoryW(void* hConnect, const(wchar)* lpszDirectory);

@DllImport("WININET")
BOOL FtpSetCurrentDirectoryA(void* hConnect, const(char)* lpszDirectory);

@DllImport("WININET")
BOOL FtpSetCurrentDirectoryW(void* hConnect, const(wchar)* lpszDirectory);

@DllImport("WININET")
BOOL FtpGetCurrentDirectoryA(void* hConnect, const(char)* lpszCurrentDirectory, uint* lpdwCurrentDirectory);

@DllImport("WININET")
BOOL FtpGetCurrentDirectoryW(void* hConnect, const(wchar)* lpszCurrentDirectory, uint* lpdwCurrentDirectory);

@DllImport("WININET")
BOOL FtpCommandA(void* hConnect, BOOL fExpectResponse, uint dwFlags, const(char)* lpszCommand, size_t dwContext, 
                 void** phFtpCommand);

@DllImport("WININET")
BOOL FtpCommandW(void* hConnect, BOOL fExpectResponse, uint dwFlags, const(wchar)* lpszCommand, size_t dwContext, 
                 void** phFtpCommand);

@DllImport("WININET")
uint FtpGetFileSize(void* hFile, uint* lpdwFileSizeHigh);

@DllImport("WININET")
BOOL GopherCreateLocatorA(const(char)* lpszHost, ushort nServerPort, const(char)* lpszDisplayString, 
                          const(char)* lpszSelectorString, uint dwGopherType, const(char)* lpszLocator, 
                          uint* lpdwBufferLength);

@DllImport("WININET")
BOOL GopherCreateLocatorW(const(wchar)* lpszHost, ushort nServerPort, const(wchar)* lpszDisplayString, 
                          const(wchar)* lpszSelectorString, uint dwGopherType, const(wchar)* lpszLocator, 
                          uint* lpdwBufferLength);

@DllImport("WININET")
BOOL GopherGetLocatorTypeA(const(char)* lpszLocator, uint* lpdwGopherType);

@DllImport("WININET")
BOOL GopherGetLocatorTypeW(const(wchar)* lpszLocator, uint* lpdwGopherType);

@DllImport("WININET")
void* GopherFindFirstFileA(void* hConnect, const(char)* lpszLocator, const(char)* lpszSearchString, 
                           GOPHER_FIND_DATAA* lpFindData, uint dwFlags, size_t dwContext);

@DllImport("WININET")
void* GopherFindFirstFileW(void* hConnect, const(wchar)* lpszLocator, const(wchar)* lpszSearchString, 
                           GOPHER_FIND_DATAW* lpFindData, uint dwFlags, size_t dwContext);

@DllImport("WININET")
void* GopherOpenFileA(void* hConnect, const(char)* lpszLocator, const(char)* lpszView, uint dwFlags, 
                      size_t dwContext);

@DllImport("WININET")
void* GopherOpenFileW(void* hConnect, const(wchar)* lpszLocator, const(wchar)* lpszView, uint dwFlags, 
                      size_t dwContext);

@DllImport("WININET")
BOOL GopherGetAttributeA(void* hConnect, const(char)* lpszLocator, const(char)* lpszAttributeName, char* lpBuffer, 
                         uint dwBufferLength, uint* lpdwCharactersReturned, 
                         GOPHER_ATTRIBUTE_ENUMERATOR lpfnEnumerator, size_t dwContext);

@DllImport("WININET")
BOOL GopherGetAttributeW(void* hConnect, const(wchar)* lpszLocator, const(wchar)* lpszAttributeName, 
                         char* lpBuffer, uint dwBufferLength, uint* lpdwCharactersReturned, 
                         GOPHER_ATTRIBUTE_ENUMERATOR lpfnEnumerator, size_t dwContext);

@DllImport("WININET")
void* HttpOpenRequestA(void* hConnect, const(char)* lpszVerb, const(char)* lpszObjectName, 
                       const(char)* lpszVersion, const(char)* lpszReferrer, byte** lplpszAcceptTypes, uint dwFlags, 
                       size_t dwContext);

@DllImport("WININET")
void* HttpOpenRequestW(void* hConnect, const(wchar)* lpszVerb, const(wchar)* lpszObjectName, 
                       const(wchar)* lpszVersion, const(wchar)* lpszReferrer, ushort** lplpszAcceptTypes, 
                       uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL HttpAddRequestHeadersA(void* hRequest, const(char)* lpszHeaders, uint dwHeadersLength, uint dwModifiers);

@DllImport("WININET")
BOOL HttpAddRequestHeadersW(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, uint dwModifiers);

@DllImport("WININET")
BOOL HttpSendRequestA(void* hRequest, const(char)* lpszHeaders, uint dwHeadersLength, char* lpOptional, 
                      uint dwOptionalLength);

@DllImport("WININET")
BOOL HttpSendRequestW(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, char* lpOptional, 
                      uint dwOptionalLength);

@DllImport("WININET")
BOOL HttpSendRequestExA(void* hRequest, INTERNET_BUFFERSA* lpBuffersIn, INTERNET_BUFFERSA* lpBuffersOut, 
                        uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL HttpSendRequestExW(void* hRequest, INTERNET_BUFFERSW* lpBuffersIn, INTERNET_BUFFERSW* lpBuffersOut, 
                        uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL HttpEndRequestA(void* hRequest, INTERNET_BUFFERSA* lpBuffersOut, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL HttpEndRequestW(void* hRequest, INTERNET_BUFFERSW* lpBuffersOut, uint dwFlags, size_t dwContext);

@DllImport("WININET")
BOOL HttpQueryInfoA(void* hRequest, uint dwInfoLevel, char* lpBuffer, uint* lpdwBufferLength, uint* lpdwIndex);

@DllImport("WININET")
BOOL HttpQueryInfoW(void* hRequest, uint dwInfoLevel, char* lpBuffer, uint* lpdwBufferLength, uint* lpdwIndex);

@DllImport("WININET")
BOOL InternetSetCookieA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData);

@DllImport("WININET")
BOOL InternetSetCookieW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData);

@DllImport("WININET")
BOOL InternetGetCookieA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData, 
                        uint* lpdwSize);

@DllImport("WININET")
BOOL InternetGetCookieW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData, 
                        uint* lpdwSize);

@DllImport("WININET")
uint InternetSetCookieExA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData, 
                          uint dwFlags, size_t dwReserved);

@DllImport("WININET")
uint InternetSetCookieExW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData, 
                          uint dwFlags, size_t dwReserved);

@DllImport("WININET")
BOOL InternetGetCookieExA(const(char)* lpszUrl, const(char)* lpszCookieName, const(char)* lpszCookieData, 
                          uint* lpdwSize, uint dwFlags, void* lpReserved);

@DllImport("WININET")
BOOL InternetGetCookieExW(const(wchar)* lpszUrl, const(wchar)* lpszCookieName, const(wchar)* lpszCookieData, 
                          uint* lpdwSize, uint dwFlags, void* lpReserved);

@DllImport("WININET")
void InternetFreeCookies(INTERNET_COOKIE2* pCookies, uint dwCookieCount);

@DllImport("WININET")
uint InternetGetCookieEx2(const(wchar)* pcwszUrl, const(wchar)* pcwszCookieName, uint dwFlags, 
                          INTERNET_COOKIE2** ppCookies, uint* pdwCookieCount);

@DllImport("WININET")
uint InternetSetCookieEx2(const(wchar)* pcwszUrl, const(INTERNET_COOKIE2)* pCookie, const(wchar)* pcwszP3PPolicy, 
                          uint dwFlags, uint* pdwCookieState);

@DllImport("WININET")
uint InternetAttemptConnect(uint dwReserved);

@DllImport("WININET")
BOOL InternetCheckConnectionA(const(char)* lpszUrl, uint dwFlags, uint dwReserved);

@DllImport("WININET")
BOOL InternetCheckConnectionW(const(wchar)* lpszUrl, uint dwFlags, uint dwReserved);

@DllImport("WININET")
BOOL ResumeSuspendedDownload(void* hRequest, uint dwResultCode);

@DllImport("WININET")
uint InternetErrorDlg(HWND hWnd, void* hRequest, uint dwError, uint dwFlags, void** lppvData);

@DllImport("WININET")
uint InternetConfirmZoneCrossingA(HWND hWnd, const(char)* szUrlPrev, const(char)* szUrlNew, BOOL bPost);

@DllImport("WININET")
uint InternetConfirmZoneCrossingW(HWND hWnd, const(wchar)* szUrlPrev, const(wchar)* szUrlNew, BOOL bPost);

@DllImport("WININET")
uint InternetConfirmZoneCrossing(HWND hWnd, const(char)* szUrlPrev, const(char)* szUrlNew, BOOL bPost);

@DllImport("WININET")
BOOL CreateUrlCacheEntryA(const(char)* lpszUrlName, uint dwExpectedFileSize, const(char)* lpszFileExtension, 
                          const(char)* lpszFileName, uint dwReserved);

@DllImport("WININET")
BOOL CreateUrlCacheEntryW(const(wchar)* lpszUrlName, uint dwExpectedFileSize, const(wchar)* lpszFileExtension, 
                          const(wchar)* lpszFileName, uint dwReserved);

@DllImport("WININET")
BOOL CommitUrlCacheEntryA(const(char)* lpszUrlName, const(char)* lpszLocalFileName, FILETIME ExpireTime, 
                          FILETIME LastModifiedTime, uint CacheEntryType, char* lpHeaderInfo, uint cchHeaderInfo, 
                          const(char)* lpszFileExtension, const(char)* lpszOriginalUrl);

@DllImport("WININET")
BOOL CommitUrlCacheEntryW(const(wchar)* lpszUrlName, const(wchar)* lpszLocalFileName, FILETIME ExpireTime, 
                          FILETIME LastModifiedTime, uint CacheEntryType, const(wchar)* lpszHeaderInfo, 
                          uint cchHeaderInfo, const(wchar)* lpszFileExtension, const(wchar)* lpszOriginalUrl);

@DllImport("WININET")
BOOL RetrieveUrlCacheEntryFileA(const(char)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                                uint dwReserved);

@DllImport("WININET")
BOOL RetrieveUrlCacheEntryFileW(const(wchar)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                                uint dwReserved);

@DllImport("WININET")
BOOL UnlockUrlCacheEntryFileA(const(char)* lpszUrlName, uint dwReserved);

@DllImport("WININET")
BOOL UnlockUrlCacheEntryFileW(const(wchar)* lpszUrlName, uint dwReserved);

@DllImport("WININET")
BOOL UnlockUrlCacheEntryFile(const(char)* lpszUrlName, uint dwReserved);

@DllImport("WININET")
HANDLE RetrieveUrlCacheEntryStreamA(const(char)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                                    BOOL fRandomRead, uint dwReserved);

@DllImport("WININET")
HANDLE RetrieveUrlCacheEntryStreamW(const(wchar)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                                    BOOL fRandomRead, uint dwReserved);

@DllImport("WININET")
BOOL ReadUrlCacheEntryStream(HANDLE hUrlCacheStream, uint dwLocation, char* lpBuffer, uint* lpdwLen, uint Reserved);

@DllImport("WININET")
BOOL ReadUrlCacheEntryStreamEx(HANDLE hUrlCacheStream, ulong qwLocation, char* lpBuffer, uint* lpdwLen);

@DllImport("WININET")
BOOL UnlockUrlCacheEntryStream(HANDLE hUrlCacheStream, uint Reserved);

@DllImport("WININET")
BOOL GetUrlCacheEntryInfoA(const(char)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET")
BOOL GetUrlCacheEntryInfoW(const(wchar)* lpszUrlName, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET")
HANDLE FindFirstUrlCacheGroup(uint dwFlags, uint dwFilter, void* lpSearchCondition, uint dwSearchCondition, 
                              long* lpGroupId, void* lpReserved);

@DllImport("WININET")
BOOL FindNextUrlCacheGroup(HANDLE hFind, long* lpGroupId, void* lpReserved);

@DllImport("WININET")
BOOL GetUrlCacheGroupAttributeA(long gid, uint dwFlags, uint dwAttributes, char* lpGroupInfo, uint* lpcbGroupInfo, 
                                void* lpReserved);

@DllImport("WININET")
BOOL GetUrlCacheGroupAttributeW(long gid, uint dwFlags, uint dwAttributes, char* lpGroupInfo, uint* lpcbGroupInfo, 
                                void* lpReserved);

@DllImport("WININET")
BOOL SetUrlCacheGroupAttributeA(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOA* lpGroupInfo, 
                                void* lpReserved);

@DllImport("WININET")
BOOL SetUrlCacheGroupAttributeW(long gid, uint dwFlags, uint dwAttributes, INTERNET_CACHE_GROUP_INFOW* lpGroupInfo, 
                                void* lpReserved);

@DllImport("WININET")
BOOL GetUrlCacheEntryInfoExA(const(char)* lpszUrl, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                             const(char)* lpszRedirectUrl, uint* lpcbRedirectUrl, void* lpReserved, uint dwFlags);

@DllImport("WININET")
BOOL GetUrlCacheEntryInfoExW(const(wchar)* lpszUrl, char* lpCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                             const(wchar)* lpszRedirectUrl, uint* lpcbRedirectUrl, void* lpReserved, uint dwFlags);

@DllImport("WININET")
BOOL SetUrlCacheEntryInfoA(const(char)* lpszUrlName, INTERNET_CACHE_ENTRY_INFOA* lpCacheEntryInfo, 
                           uint dwFieldControl);

@DllImport("WININET")
BOOL SetUrlCacheEntryInfoW(const(wchar)* lpszUrlName, INTERNET_CACHE_ENTRY_INFOW* lpCacheEntryInfo, 
                           uint dwFieldControl);

@DllImport("WININET")
long CreateUrlCacheGroup(uint dwFlags, void* lpReserved);

@DllImport("WININET")
BOOL DeleteUrlCacheGroup(long GroupId, uint dwFlags, void* lpReserved);

@DllImport("WININET")
BOOL SetUrlCacheEntryGroupA(const(char)* lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, 
                            uint cbGroupAttributes, void* lpReserved);

@DllImport("WININET")
BOOL SetUrlCacheEntryGroupW(const(wchar)* lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, 
                            uint cbGroupAttributes, void* lpReserved);

@DllImport("WININET")
BOOL SetUrlCacheEntryGroup(const(char)* lpszUrlName, uint dwFlags, long GroupId, ubyte* pbGroupAttributes, 
                           uint cbGroupAttributes, void* lpReserved);

@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryExA(const(char)* lpszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, 
                                 char* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo, void* lpGroupAttributes, 
                                 uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryExW(const(wchar)* lpszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, 
                                 char* lpFirstCacheEntryInfo, uint* lpcbCacheEntryInfo, void* lpGroupAttributes, 
                                 uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET")
BOOL FindNextUrlCacheEntryExA(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                              void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET")
BOOL FindNextUrlCacheEntryExW(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo, 
                              void* lpGroupAttributes, uint* lpcbGroupAttributes, void* lpReserved);

@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryA(const(char)* lpszUrlSearchPattern, char* lpFirstCacheEntryInfo, 
                               uint* lpcbCacheEntryInfo);

@DllImport("WININET")
HANDLE FindFirstUrlCacheEntryW(const(wchar)* lpszUrlSearchPattern, char* lpFirstCacheEntryInfo, 
                               uint* lpcbCacheEntryInfo);

@DllImport("WININET")
BOOL FindNextUrlCacheEntryA(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET")
BOOL FindNextUrlCacheEntryW(HANDLE hEnumHandle, char* lpNextCacheEntryInfo, uint* lpcbCacheEntryInfo);

@DllImport("WININET")
BOOL FindCloseUrlCache(HANDLE hEnumHandle);

@DllImport("WININET")
BOOL DeleteUrlCacheEntryA(const(char)* lpszUrlName);

@DllImport("WININET")
BOOL DeleteUrlCacheEntryW(const(wchar)* lpszUrlName);

@DllImport("WININET")
BOOL DeleteUrlCacheEntry(const(char)* lpszUrlName);

@DllImport("WININET")
uint InternetDialA(HWND hwndParent, const(char)* lpszConnectoid, uint dwFlags, size_t* lpdwConnection, 
                   uint dwReserved);

@DllImport("WININET")
uint InternetDialW(HWND hwndParent, const(wchar)* lpszConnectoid, uint dwFlags, size_t* lpdwConnection, 
                   uint dwReserved);

@DllImport("WININET")
uint InternetDial(HWND hwndParent, const(char)* lpszConnectoid, uint dwFlags, uint* lpdwConnection, 
                  uint dwReserved);

@DllImport("WININET")
uint InternetHangUp(size_t dwConnection, uint dwReserved);

@DllImport("WININET")
BOOL InternetGoOnlineA(const(char)* lpszURL, HWND hwndParent, uint dwFlags);

@DllImport("WININET")
BOOL InternetGoOnlineW(const(wchar)* lpszURL, HWND hwndParent, uint dwFlags);

@DllImport("WININET")
BOOL InternetGoOnline(const(char)* lpszURL, HWND hwndParent, uint dwFlags);

@DllImport("WININET")
BOOL InternetAutodial(uint dwFlags, HWND hwndParent);

@DllImport("WININET")
BOOL InternetAutodialHangup(uint dwReserved);

@DllImport("WININET")
BOOL InternetGetConnectedState(uint* lpdwFlags, uint dwReserved);

@DllImport("WININET")
BOOL InternetGetConnectedStateExA(uint* lpdwFlags, const(char)* lpszConnectionName, uint cchNameLen, 
                                  uint dwReserved);

@DllImport("WININET")
BOOL InternetGetConnectedStateExW(uint* lpdwFlags, const(wchar)* lpszConnectionName, uint cchNameLen, 
                                  uint dwReserved);

@DllImport("WININET")
BOOL DeleteWpadCacheForNetworks(WPAD_CACHE_DELETE param0);

@DllImport("WININET")
BOOL InternetInitializeAutoProxyDll(uint dwReserved);

@DllImport("WININET")
BOOL DetectAutoProxyUrl(const(char)* pszAutoProxyUrl, uint cchAutoProxyUrl, uint dwDetectFlags);

@DllImport("WININET")
BOOL CreateMD5SSOHash(const(wchar)* pszChallengeInfo, const(wchar)* pwszRealm, const(wchar)* pwszTarget, 
                      ubyte* pbHexHash);

@DllImport("WININET")
BOOL InternetGetConnectedStateEx(uint* lpdwFlags, const(char)* lpszConnectionName, uint dwNameLen, uint dwReserved);

@DllImport("WININET")
BOOL InternetSetDialStateA(const(char)* lpszConnectoid, uint dwState, uint dwReserved);

@DllImport("WININET")
BOOL InternetSetDialStateW(const(wchar)* lpszConnectoid, uint dwState, uint dwReserved);

@DllImport("WININET")
BOOL InternetSetDialState(const(char)* lpszConnectoid, uint dwState, uint dwReserved);

@DllImport("WININET")
BOOL InternetSetPerSiteCookieDecisionA(const(char)* pchHostName, uint dwDecision);

@DllImport("WININET")
BOOL InternetSetPerSiteCookieDecisionW(const(wchar)* pchHostName, uint dwDecision);

@DllImport("WININET")
BOOL InternetGetPerSiteCookieDecisionA(const(char)* pchHostName, uint* pResult);

@DllImport("WININET")
BOOL InternetGetPerSiteCookieDecisionW(const(wchar)* pchHostName, uint* pResult);

@DllImport("WININET")
BOOL InternetClearAllPerSiteCookieDecisions();

@DllImport("WININET")
BOOL InternetEnumPerSiteCookieDecisionA(const(char)* pszSiteName, uint* pcSiteNameSize, uint* pdwDecision, 
                                        uint dwIndex);

@DllImport("WININET")
BOOL InternetEnumPerSiteCookieDecisionW(const(wchar)* pszSiteName, uint* pcSiteNameSize, uint* pdwDecision, 
                                        uint dwIndex);

@DllImport("WININET")
uint PrivacySetZonePreferenceW(uint dwZone, uint dwType, uint dwTemplate, const(wchar)* pszPreference);

@DllImport("WININET")
uint PrivacyGetZonePreferenceW(uint dwZone, uint dwType, uint* pdwTemplate, const(wchar)* pszBuffer, 
                               uint* pdwBufferLength);

@DllImport("WININET")
uint HttpIsHostHstsEnabled(const(wchar)* pcwszUrl, int* pfIsHsts);

@DllImport("WININET")
BOOL InternetAlgIdToStringA(uint ai, const(char)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetAlgIdToStringW(uint ai, const(wchar)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetSecurityProtocolToStringA(uint dwProtocol, const(char)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetSecurityProtocolToStringW(uint dwProtocol, const(wchar)* lpstr, uint* lpdwstrLength, uint dwReserved);

@DllImport("WININET")
BOOL InternetGetSecurityInfoByURLA(const(char)* lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET")
BOOL InternetGetSecurityInfoByURLW(const(wchar)* lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET")
BOOL InternetGetSecurityInfoByURL(const(char)* lpszURL, CERT_CHAIN_CONTEXT** ppCertChain, uint* pdwSecureFlags);

@DllImport("WININET")
uint ShowSecurityInfo(HWND hWndParent, INTERNET_SECURITY_INFO* pSecurityInfo);

@DllImport("WININET")
uint ShowX509EncodedCertificate(HWND hWndParent, char* lpCert, uint cbCert);

@DllImport("WININET")
uint ShowClientAuthCerts(HWND hWndParent);

@DllImport("WININET")
uint ParseX509EncodedCertificateForListBoxEntry(char* lpCert, uint cbCert, const(char)* lpszListBoxEntry, 
                                                uint* lpdwListBoxEntry);

@DllImport("WININET")
BOOL InternetShowSecurityInfoByURLA(const(char)* lpszURL, HWND hwndParent);

@DllImport("WININET")
BOOL InternetShowSecurityInfoByURLW(const(wchar)* lpszURL, HWND hwndParent);

@DllImport("WININET")
BOOL InternetShowSecurityInfoByURL(const(char)* lpszURL, HWND hwndParent);

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
uint HttpGetServerCredentials(const(wchar)* pwszUrl, ushort** ppwszUserName, ushort** ppwszPassword);

@DllImport("WININET")
uint HttpPushEnable(void* hRequest, HTTP_PUSH_TRANSPORT_SETTING* pTransportSetting, 
                    HTTP_PUSH_WAIT_HANDLE__** phWait);

@DllImport("WININET")
uint HttpPushWait(HTTP_PUSH_WAIT_HANDLE__* hWait, HTTP_PUSH_WAIT_TYPE eType, 
                  HTTP_PUSH_NOTIFICATION_STATUS* pNotificationStatus);

@DllImport("WININET")
void HttpPushClose(HTTP_PUSH_WAIT_HANDLE__* hWait);

@DllImport("WININET")
BOOL HttpCheckDavComplianceA(const(char)* lpszUrl, const(char)* lpszComplianceToken, int* lpfFound, HWND hWnd, 
                             void* lpvReserved);

@DllImport("WININET")
BOOL HttpCheckDavComplianceW(const(wchar)* lpszUrl, const(wchar)* lpszComplianceToken, int* lpfFound, HWND hWnd, 
                             void* lpvReserved);

@DllImport("WININET")
BOOL IsUrlCacheEntryExpiredA(const(char)* lpszUrlName, uint dwFlags, FILETIME* pftLastModified);

@DllImport("WININET")
BOOL IsUrlCacheEntryExpiredW(const(wchar)* lpszUrlName, uint dwFlags, FILETIME* pftLastModified);

@DllImport("WININET")
BOOL CreateUrlCacheEntryExW(const(wchar)* lpszUrlName, uint dwExpectedFileSize, const(wchar)* lpszFileExtension, 
                            const(wchar)* lpszFileName, uint dwReserved, BOOL fPreserveIncomingFileName);

@DllImport("WININET")
uint GetUrlCacheEntryBinaryBlob(const(wchar)* pwszUrlName, uint* dwType, FILETIME* pftExpireTime, 
                                FILETIME* pftAccessTime, FILETIME* pftModifiedTime, char* ppbBlob, uint* pcbBlob);

@DllImport("WININET")
uint CommitUrlCacheEntryBinaryBlob(const(wchar)* pwszUrlName, uint dwType, FILETIME ftExpireTime, 
                                   FILETIME ftModifiedTime, char* pbBlob, uint cbBlob);

@DllImport("WININET")
BOOL CreateUrlCacheContainerA(const(char)* Name, const(char)* lpCachePrefix, const(char)* lpszCachePath, 
                              uint KBCacheLimit, uint dwContainerType, uint dwOptions, void* pvBuffer, 
                              uint* cbBuffer);

@DllImport("WININET")
BOOL CreateUrlCacheContainerW(const(wchar)* Name, const(wchar)* lpCachePrefix, const(wchar)* lpszCachePath, 
                              uint KBCacheLimit, uint dwContainerType, uint dwOptions, void* pvBuffer, 
                              uint* cbBuffer);

@DllImport("WININET")
BOOL DeleteUrlCacheContainerA(const(char)* Name, uint dwOptions);

@DllImport("WININET")
BOOL DeleteUrlCacheContainerW(const(wchar)* Name, uint dwOptions);

@DllImport("WININET")
HANDLE FindFirstUrlCacheContainerA(uint* pdwModified, char* lpContainerInfo, uint* lpcbContainerInfo, 
                                   uint dwOptions);

@DllImport("WININET")
HANDLE FindFirstUrlCacheContainerW(uint* pdwModified, char* lpContainerInfo, uint* lpcbContainerInfo, 
                                   uint dwOptions);

@DllImport("WININET")
BOOL FindNextUrlCacheContainerA(HANDLE hEnumHandle, char* lpContainerInfo, uint* lpcbContainerInfo);

@DllImport("WININET")
BOOL FindNextUrlCacheContainerW(HANDLE hEnumHandle, char* lpContainerInfo, uint* lpcbContainerInfo);

@DllImport("WININET")
BOOL FreeUrlCacheSpaceA(const(char)* lpszCachePath, uint dwSize, uint dwFilter);

@DllImport("WININET")
BOOL FreeUrlCacheSpaceW(const(wchar)* lpszCachePath, uint dwSize, uint dwFilter);

@DllImport("WININET")
uint UrlCacheFreeGlobalSpace(ulong ullTargetSize, uint dwFilter);

@DllImport("WININET")
uint UrlCacheGetGlobalCacheSize(uint dwFilter, ulong* pullSize, ulong* pullLimit);

@DllImport("WININET")
BOOL GetUrlCacheConfigInfoA(INTERNET_CACHE_CONFIG_INFOA* lpCacheConfigInfo, uint* lpcbCacheConfigInfo, 
                            uint dwFieldControl);

@DllImport("WININET")
BOOL GetUrlCacheConfigInfoW(INTERNET_CACHE_CONFIG_INFOW* lpCacheConfigInfo, uint* lpcbCacheConfigInfo, 
                            uint dwFieldControl);

@DllImport("WININET")
BOOL SetUrlCacheConfigInfoA(INTERNET_CACHE_CONFIG_INFOA* lpCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET")
BOOL SetUrlCacheConfigInfoW(INTERNET_CACHE_CONFIG_INFOW* lpCacheConfigInfo, uint dwFieldControl);

@DllImport("WININET")
uint RunOnceUrlCache(HWND hwnd, HINSTANCE hinst, const(char)* lpszCmd, int nCmdShow);

@DllImport("WININET")
uint DeleteIE3Cache(HWND hwnd, HINSTANCE hinst, const(char)* lpszCmd, int nCmdShow);

@DllImport("WININET")
BOOL UpdateUrlCacheContentPath(const(char)* szNewPath);

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
uint AppCacheLookup(const(wchar)* pwszUrl, uint dwFlags, void** phAppCache);

@DllImport("WININET")
uint AppCacheCheckManifest(const(wchar)* pwszMasterUrl, const(wchar)* pwszManifestUrl, char* pbManifestData, 
                           uint dwManifestDataSize, char* pbManifestResponseHeaders, 
                           uint dwManifestResponseHeadersSize, APP_CACHE_STATE* peState, void** phNewAppCache);

@DllImport("WININET")
uint AppCacheGetDownloadList(void* hAppCache, APP_CACHE_DOWNLOAD_LIST* pDownloadList);

@DllImport("WININET")
void AppCacheFreeDownloadList(APP_CACHE_DOWNLOAD_LIST* pDownloadList);

@DllImport("WININET")
uint AppCacheFinalize(void* hAppCache, char* pbManifestData, uint dwManifestDataSize, 
                      APP_CACHE_FINALIZE_STATE* peState);

@DllImport("WININET")
uint AppCacheGetFallbackUrl(void* hAppCache, const(wchar)* pwszUrl, ushort** ppwszFallbackUrl);

@DllImport("WININET")
uint AppCacheGetManifestUrl(void* hAppCache, ushort** ppwszManifestUrl);

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
uint AppCacheDeleteGroup(const(wchar)* pwszManifestUrl);

@DllImport("WININET")
uint AppCacheFreeSpace(FILETIME ftCutOff);

@DllImport("WININET")
uint AppCacheGetIEGroupList(APP_CACHE_GROUP_LIST* pAppCacheGroupList);

@DllImport("WININET")
uint AppCacheDeleteIEGroup(const(wchar)* pwszManifestUrl);

@DllImport("WININET")
uint AppCacheFreeIESpace(FILETIME ftCutOff);

@DllImport("WININET")
uint AppCacheCreateAndCommitFile(void* hAppCache, const(wchar)* pwszSourceFilePath, const(wchar)* pwszUrl, 
                                 char* pbResponseHeaders, uint dwResponseHeadersSize);

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
uint UrlCacheGetEntryInfo(void* hAppCache, const(wchar)* pcwszUrl, URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET")
void UrlCacheCloseEntryHandle(void* hEntryFile);

@DllImport("WININET")
uint UrlCacheRetrieveEntryFile(void* hAppCache, const(wchar)* pcwszUrl, URLCACHE_ENTRY_INFO* pCacheEntryInfo, 
                               void** phEntryFile);

@DllImport("WININET")
uint UrlCacheReadEntryStream(void* hUrlCacheStream, ulong ullLocation, void* pBuffer, uint dwBufferLen, 
                             uint* pdwBufferLen);

@DllImport("WININET")
uint UrlCacheRetrieveEntryStream(void* hAppCache, const(wchar)* pcwszUrl, BOOL fRandomRead, 
                                 URLCACHE_ENTRY_INFO* pCacheEntryInfo, void** phEntryStream);

@DllImport("WININET")
uint UrlCacheUpdateEntryExtraData(void* hAppCache, const(wchar)* pcwszUrl, char* pbExtraData, uint cbExtraData);

@DllImport("WININET")
uint UrlCacheCreateContainer(const(wchar)* pwszName, const(wchar)* pwszPrefix, const(wchar)* pwszDirectory, 
                             ulong ullLimit, uint dwOptions);

@DllImport("WININET")
uint UrlCacheCheckEntriesExist(char* rgpwszUrls, uint cEntries, char* rgfExist);

@DllImport("WININET")
uint UrlCacheGetContentPaths(ushort*** pppwszDirectories, uint* pcDirectories);

@DllImport("WININET")
uint UrlCacheGetGlobalLimit(URL_CACHE_LIMIT_TYPE limitType, ulong* pullLimit);

@DllImport("WININET")
uint UrlCacheSetGlobalLimit(URL_CACHE_LIMIT_TYPE limitType, ulong ullLimit);

@DllImport("WININET")
uint UrlCacheReloadSettings();

@DllImport("WININET")
uint UrlCacheContainerSetEntryMaximumAge(const(wchar)* pwszPrefix, uint dwEntryMaxAge);

@DllImport("WININET")
uint UrlCacheFindFirstEntry(const(wchar)* pwszPrefix, uint dwFlags, uint dwFilter, long GroupId, 
                            URLCACHE_ENTRY_INFO* pCacheEntryInfo, HANDLE* phFind);

@DllImport("WININET")
uint UrlCacheFindNextEntry(HANDLE hFind, URLCACHE_ENTRY_INFO* pCacheEntryInfo);

@DllImport("WININET")
uint UrlCacheServer();

@DllImport("WININET")
BOOL ReadGuidsForConnectedNetworks(uint* pcNetworks, ushort*** pppwszNetworkGuids, BSTR** pppbstrNetworkNames, 
                                   ushort*** pppwszGWMacs, uint* pcGatewayMacs, uint* pdwFlags);

@DllImport("WININET")
BOOL IsHostInProxyBypassList(INTERNET_SCHEME tScheme, const(char)* lpszHost, uint cchHost);

@DllImport("WININET")
void InternetFreeProxyInfoList(WININET_PROXY_INFO_LIST* pProxyInfoList);

@DllImport("WININET")
uint InternetGetProxyForUrl(void* hInternet, const(wchar)* pcwszUrl, WININET_PROXY_INFO_LIST* pProxyInfoList);

@DllImport("WININET")
BOOL DoConnectoidsExist();

@DllImport("WININET")
BOOL GetDiskInfoA(const(char)* pszPath, uint* pdwClusterSize, ulong* pdlAvail, ulong* pdlTotal);

@DllImport("WININET")
BOOL PerformOperationOverUrlCacheA(const(char)* pszUrlSearchPattern, uint dwFlags, uint dwFilter, long GroupId, 
                                   void* pReserved1, uint* pdwReserved2, void* pReserved3, CACHE_OPERATOR op, 
                                   void* pOperatorData);

@DllImport("WININET")
BOOL IsProfilesEnabled();

@DllImport("WININET")
uint InternalInternetGetCookie(const(char)* lpszUrl, const(char)* lpszCookieData, uint* lpdwDataSize);

@DllImport("WININET")
BOOL ImportCookieFileA(const(char)* szFilename);

@DllImport("WININET")
BOOL ImportCookieFileW(const(wchar)* szFilename);

@DllImport("WININET")
BOOL ExportCookieFileA(const(char)* szFilename, BOOL fAppend);

@DllImport("WININET")
BOOL ExportCookieFileW(const(wchar)* szFilename, BOOL fAppend);

@DllImport("WININET")
BOOL IsDomainLegalCookieDomainA(const(char)* pchDomain, const(char)* pchFullDomain);

@DllImport("WININET")
BOOL IsDomainLegalCookieDomainW(const(wchar)* pchDomain, const(wchar)* pchFullDomain);

@DllImport("WININET")
void* HttpWebSocketCompleteUpgrade(void* hRequest, size_t dwContext);

@DllImport("WININET")
BOOL HttpWebSocketSend(void* hWebSocket, HTTP_WEB_SOCKET_BUFFER_TYPE BufferType, char* pvBuffer, 
                       uint dwBufferLength);

@DllImport("WININET")
BOOL HttpWebSocketReceive(void* hWebSocket, char* pvBuffer, uint dwBufferLength, uint* pdwBytesRead, 
                          HTTP_WEB_SOCKET_BUFFER_TYPE* pBufferType);

@DllImport("WININET")
BOOL HttpWebSocketClose(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WININET")
BOOL HttpWebSocketShutdown(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WININET")
BOOL HttpWebSocketQueryCloseStatus(void* hWebSocket, ushort* pusStatus, char* pvReason, uint dwReasonLength, 
                                   uint* pdwReasonLengthConsumed);

@DllImport("WININET")
uint InternetConvertUrlFromWireToWideChar(const(char)* pcszUrl, uint cchUrl, const(wchar)* pcwszBaseUrl, 
                                          uint dwCodePageHost, uint dwCodePagePath, BOOL fEncodePathExtra, 
                                          uint dwCodePageExtra, ushort** ppwszConvertedUrl);


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
    HRESULT Initialize(const(wchar)* pwzConnectoid, IDialEventSink pIDES);
    HRESULT GetProperty(const(wchar)* pwzProperty, const(wchar)* pwzValue, uint dwBufSize);
    HRESULT SetProperty(const(wchar)* pwzProperty, const(wchar)* pwzValue);
    HRESULT Dial();
    HRESULT HangUp();
    HRESULT GetConnectedState(uint* pdwState);
    HRESULT GetConnectHandle(size_t* pdwHandle);
}

@GUID("8AECAFA9-4306-43CC-8C5A-765F2979CC16")
interface IDialBranding : IUnknown
{
    HRESULT Initialize(const(wchar)* pwzConnectoid);
    HRESULT GetBitmap(uint dwIndex, HBITMAP* phBitmap);
}

@GUID("CDAECE56-4EDF-43DF-B113-88E4556FA1BB")
interface IProofOfPossessionCookieInfoManager : IUnknown
{
    HRESULT GetCookieInfoForUri(const(wchar)* uri, uint* cookieInfoCount, char* cookieInfo);
}

@GUID("15E41407-B42F-4AE7-9966-34A087B2D713")
interface IProofOfPossessionCookieInfoManager2 : IUnknown
{
    HRESULT GetCookieInfoWithUriForAccount(IInspectable webAccount, const(wchar)* uri, uint* cookieInfoCount, 
                                           char* cookieInfo);
}


// GUIDs

const GUID CLSID_ProofOfPossessionCookieInfoManager = GUIDOF!ProofOfPossessionCookieInfoManager;

const GUID IID_IDialBranding                        = GUIDOF!IDialBranding;
const GUID IID_IDialEngine                          = GUIDOF!IDialEngine;
const GUID IID_IDialEventSink                       = GUIDOF!IDialEventSink;
const GUID IID_IProofOfPossessionCookieInfoManager  = GUIDOF!IProofOfPossessionCookieInfoManager;
const GUID IID_IProofOfPossessionCookieInfoManager2 = GUIDOF!IProofOfPossessionCookieInfoManager2;
