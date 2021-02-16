module windows.xblidp;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    XBL_IDP_AUTH_TOKEN_STATUS_SUCCESS                 = 0x00000000,
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_SUCCESS         = 0x00000001,
    XBL_IDP_AUTH_TOKEN_STATUS_NO_ACCOUNT_SET          = 0x00000002,
    XBL_IDP_AUTH_TOKEN_STATUS_LOAD_MSA_ACCOUNT_FAILED = 0x00000003,
    XBL_IDP_AUTH_TOKEN_STATUS_XBOX_VETO               = 0x00000004,
    XBL_IDP_AUTH_TOKEN_STATUS_MSA_INTERRUPT           = 0x00000005,
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_NO_CONSENT      = 0x00000006,
    XBL_IDP_AUTH_TOKEN_STATUS_VIEW_NOT_SET            = 0x00000007,
    XBL_IDP_AUTH_TOKEN_STATUS_UNKNOWN                 = 0xffffffff,
}
alias XBL_IDP_AUTH_TOKEN_STATUS = int;

// Interfaces

@GUID("CE23534B-56D8-4978-86A2-7EE570640468")
struct XblIdpAuthManager;

@GUID("9F493441-744A-410C-AE2B-9A22F7C7731F")
struct XblIdpAuthTokenResult;

@GUID("EB5DDB08-8BBF-449B-AC21-B02DDEB3B136")
interface IXblIdpAuthManager : IUnknown
{
    HRESULT SetGamerAccount(const(wchar)* msaAccountId, const(wchar)* xuid);
    HRESULT GetGamerAccount(ushort** msaAccountId, ushort** xuid);
    HRESULT SetAppViewInitialized(const(wchar)* appSid, const(wchar)* msaAccountId);
    HRESULT GetEnvironment(ushort** environment);
    HRESULT GetSandbox(ushort** sandbox);
    HRESULT GetTokenAndSignatureWithTokenResult(const(wchar)* msaAccountId, const(wchar)* appSid, 
                                                const(wchar)* msaTarget, const(wchar)* msaPolicy, 
                                                const(wchar)* httpMethod, const(wchar)* uri, const(wchar)* headers, 
                                                char* body_, uint bodySize, BOOL forceRefresh, 
                                                IXblIdpAuthTokenResult* result);
}

@GUID("46CE0225-F267-4D68-B299-B2762552DEC1")
interface IXblIdpAuthTokenResult : IUnknown
{
    HRESULT GetStatus(XBL_IDP_AUTH_TOKEN_STATUS* status);
    HRESULT GetErrorCode(int* errorCode);
    HRESULT GetToken(ushort** token);
    HRESULT GetSignature(ushort** signature);
    HRESULT GetSandbox(ushort** sandbox);
    HRESULT GetEnvironment(ushort** environment);
    HRESULT GetMsaAccountId(ushort** msaAccountId);
    HRESULT GetXuid(ushort** xuid);
    HRESULT GetGamertag(ushort** gamertag);
    HRESULT GetAgeGroup(ushort** ageGroup);
    HRESULT GetPrivileges(ushort** privileges);
    HRESULT GetMsaTarget(ushort** msaTarget);
    HRESULT GetMsaPolicy(ushort** msaPolicy);
    HRESULT GetMsaAppId(ushort** msaAppId);
    HRESULT GetRedirect(ushort** redirect);
    HRESULT GetMessageA(ushort** message);
    HRESULT GetHelpId(ushort** helpId);
    HRESULT GetEnforcementBans(ushort** enforcementBans);
    HRESULT GetRestrictions(ushort** restrictions);
    HRESULT GetTitleRestrictions(ushort** titleRestrictions);
}

@GUID("75D760B0-60B9-412D-994F-26B2CD5F7812")
interface IXblIdpAuthTokenResult2 : IUnknown
{
    HRESULT GetModernGamertag(ushort** value);
    HRESULT GetModernGamertagSuffix(ushort** value);
    HRESULT GetUniqueModernGamertag(ushort** value);
}


// GUIDs

const GUID CLSID_XblIdpAuthManager     = GUIDOF!XblIdpAuthManager;
const GUID CLSID_XblIdpAuthTokenResult = GUIDOF!XblIdpAuthTokenResult;

const GUID IID_IXblIdpAuthManager      = GUIDOF!IXblIdpAuthManager;
const GUID IID_IXblIdpAuthTokenResult  = GUIDOF!IXblIdpAuthTokenResult;
const GUID IID_IXblIdpAuthTokenResult2 = GUIDOF!IXblIdpAuthTokenResult2;
