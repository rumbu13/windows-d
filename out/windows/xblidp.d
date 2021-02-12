module windows.xblidp;

public import windows.com;
public import windows.systemservices;

extern(Windows):

const GUID CLSID_XblIdpAuthManager = {0xCE23534B, 0x56D8, 0x4978, [0x86, 0xA2, 0x7E, 0xE5, 0x70, 0x64, 0x04, 0x68]};
@GUID(0xCE23534B, 0x56D8, 0x4978, [0x86, 0xA2, 0x7E, 0xE5, 0x70, 0x64, 0x04, 0x68]);
struct XblIdpAuthManager;

const GUID CLSID_XblIdpAuthTokenResult = {0x9F493441, 0x744A, 0x410C, [0xAE, 0x2B, 0x9A, 0x22, 0xF7, 0xC7, 0x73, 0x1F]};
@GUID(0x9F493441, 0x744A, 0x410C, [0xAE, 0x2B, 0x9A, 0x22, 0xF7, 0xC7, 0x73, 0x1F]);
struct XblIdpAuthTokenResult;

enum XBL_IDP_AUTH_TOKEN_STATUS
{
    XBL_IDP_AUTH_TOKEN_STATUS_SUCCESS = 0,
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_SUCCESS = 1,
    XBL_IDP_AUTH_TOKEN_STATUS_NO_ACCOUNT_SET = 2,
    XBL_IDP_AUTH_TOKEN_STATUS_LOAD_MSA_ACCOUNT_FAILED = 3,
    XBL_IDP_AUTH_TOKEN_STATUS_XBOX_VETO = 4,
    XBL_IDP_AUTH_TOKEN_STATUS_MSA_INTERRUPT = 5,
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_NO_CONSENT = 6,
    XBL_IDP_AUTH_TOKEN_STATUS_VIEW_NOT_SET = 7,
    XBL_IDP_AUTH_TOKEN_STATUS_UNKNOWN = -1,
}

const GUID IID_IXblIdpAuthManager = {0xEB5DDB08, 0x8BBF, 0x449B, [0xAC, 0x21, 0xB0, 0x2D, 0xDE, 0xB3, 0xB1, 0x36]};
@GUID(0xEB5DDB08, 0x8BBF, 0x449B, [0xAC, 0x21, 0xB0, 0x2D, 0xDE, 0xB3, 0xB1, 0x36]);
interface IXblIdpAuthManager : IUnknown
{
    HRESULT SetGamerAccount(const(wchar)* msaAccountId, const(wchar)* xuid);
    HRESULT GetGamerAccount(ushort** msaAccountId, ushort** xuid);
    HRESULT SetAppViewInitialized(const(wchar)* appSid, const(wchar)* msaAccountId);
    HRESULT GetEnvironment(ushort** environment);
    HRESULT GetSandbox(ushort** sandbox);
    HRESULT GetTokenAndSignatureWithTokenResult(const(wchar)* msaAccountId, const(wchar)* appSid, const(wchar)* msaTarget, const(wchar)* msaPolicy, const(wchar)* httpMethod, const(wchar)* uri, const(wchar)* headers, char* body, uint bodySize, BOOL forceRefresh, IXblIdpAuthTokenResult* result);
}

const GUID IID_IXblIdpAuthTokenResult = {0x46CE0225, 0xF267, 0x4D68, [0xB2, 0x99, 0xB2, 0x76, 0x25, 0x52, 0xDE, 0xC1]};
@GUID(0x46CE0225, 0xF267, 0x4D68, [0xB2, 0x99, 0xB2, 0x76, 0x25, 0x52, 0xDE, 0xC1]);
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

const GUID IID_IXblIdpAuthTokenResult2 = {0x75D760B0, 0x60B9, 0x412D, [0x99, 0x4F, 0x26, 0xB2, 0xCD, 0x5F, 0x78, 0x12]};
@GUID(0x75D760B0, 0x60B9, 0x412D, [0x99, 0x4F, 0x26, 0xB2, 0xCD, 0x5F, 0x78, 0x12]);
interface IXblIdpAuthTokenResult2 : IUnknown
{
    HRESULT GetModernGamertag(ushort** value);
    HRESULT GetModernGamertagSuffix(ushort** value);
    HRESULT GetUniqueModernGamertag(ushort** value);
}

