// Written in the D programming language.

module windows.xblidp;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


///Reserved for Microsoft use.
alias XBL_IDP_AUTH_TOKEN_STATUS = int;
enum : int
{
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_SUCCESS                 = 0x00000000,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_SUCCESS         = 0x00000001,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_NO_ACCOUNT_SET          = 0x00000002,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_LOAD_MSA_ACCOUNT_FAILED = 0x00000003,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_XBOX_VETO               = 0x00000004,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_MSA_INTERRUPT           = 0x00000005,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_NO_CONSENT      = 0x00000006,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_VIEW_NOT_SET            = 0x00000007,
    ///Reserved for Microsoft use.
    XBL_IDP_AUTH_TOKEN_STATUS_UNKNOWN                 = 0xffffffff,
}

// Interfaces

@GUID("CE23534B-56D8-4978-86A2-7EE570640468")
struct XblIdpAuthManager;

@GUID("9F493441-744A-410C-AE2B-9A22F7C7731F")
struct XblIdpAuthTokenResult;

///Reserved for Microsoft use.
@GUID("EB5DDB08-8BBF-449B-AC21-B02DDEB3B136")
interface IXblIdpAuthManager : IUnknown
{
    ///Reserved for Microsoft use.
    ///Params:
    ///    msaAccountId = Type: <b>__RPC__in_opt_string</b>
    ///    xuid = Type: <b>__RPC__in_opt_string</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetGamerAccount(const(wchar)* msaAccountId, const(wchar)* xuid);
    ///Reserved for Microsoft use.
    ///Params:
    ///    msaAccountId = Type: <b>__RPC__deref_out_opt_string*</b>
    ///    xuid = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGamerAccount(ushort** msaAccountId, ushort** xuid);
    ///Reserved for Microsoft use.
    ///Params:
    ///    appSid = Type: <b>__RPC__in_string</b>
    ///    msaAccountId = Type: <b>__RPC__in_string</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetAppViewInitialized(const(wchar)* appSid, const(wchar)* msaAccountId);
    ///Reserved for Microsoft use.
    ///Params:
    ///    environment = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEnvironment(ushort** environment);
    ///Reserved for Microsoft use.
    ///Params:
    ///    sandbox = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSandbox(ushort** sandbox);
    ///Reserved for Microsoft use.
    ///Params:
    ///    msaAccountId = Type: <b>__RPC__in_opt_string</b>
    ///    appSid = Type: <b>__RPC__in_string</b>
    ///    msaTarget = Type: <b>__RPC__in_string</b>
    ///    msaPolicy = Type: <b>__RPC__in_string</b>
    ///    httpMethod = Type: <b>__RPC__in_string</b>
    ///    uri = Type: <b>__RPC__in_string</b>
    ///    headers = Type: <b>__RPC__in_opt_string</b>
    ///    body = Type: <b>BYTE*</b>
    ///    bodySize = Type: <b>__RPC__in_ecount_full_opt</b>
    ///    forceRefresh = Type: <b>BOOL</b>
    ///    result = Type: <b>IXblIdpAuthTokenResult**</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTokenAndSignatureWithTokenResult(const(wchar)* msaAccountId, const(wchar)* appSid, 
                                                const(wchar)* msaTarget, const(wchar)* msaPolicy, 
                                                const(wchar)* httpMethod, const(wchar)* uri, const(wchar)* headers, 
                                                char* body_, uint bodySize, BOOL forceRefresh, 
                                                IXblIdpAuthTokenResult* result);
}

///Reserved for Microsoft use.
@GUID("46CE0225-F267-4D68-B299-B2762552DEC1")
interface IXblIdpAuthTokenResult : IUnknown
{
    ///Reserved for Microsoft use.
    ///Params:
    ///    status = Type: <b>XBL_IDP_AUTH_TOKEN_STATUS*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStatus(XBL_IDP_AUTH_TOKEN_STATUS* status);
    ///Reserved for Microsoft use.
    ///Params:
    ///    errorCode = The error code.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetErrorCode(int* errorCode);
    ///Reserved for Microsoft use.
    ///Params:
    ///    token = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetToken(ushort** token);
    ///Reserved for Microsoft use.
    ///Params:
    ///    signature = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSignature(ushort** signature);
    ///Reserved for Microsoft use.
    ///Params:
    ///    sandbox = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSandbox(ushort** sandbox);
    ///Reserved for Microsoft use.
    ///Params:
    ///    environment = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEnvironment(ushort** environment);
    ///Reserved for Microsoft use.
    ///Params:
    ///    msaAccountId = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMsaAccountId(ushort** msaAccountId);
    ///Reserved for Microsoft use.
    ///Params:
    ///    xuid = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetXuid(ushort** xuid);
    ///Reserved for Microsoft use.
    ///Params:
    ///    gamertag = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGamertag(ushort** gamertag);
    ///Reserved for Microsoft use.
    ///Params:
    ///    ageGroup = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAgeGroup(ushort** ageGroup);
    ///Reserved for Microsoft use.
    ///Params:
    ///    privileges = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPrivileges(ushort** privileges);
    ///Reserved for Microsoft use.
    ///Params:
    ///    msaTarget = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMsaTarget(ushort** msaTarget);
    ///Reserved for Microsoft use.
    ///Params:
    ///    msaPolicy = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMsaPolicy(ushort** msaPolicy);
    ///Reserved for Microsoft use.
    ///Params:
    ///    msaAppId = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMsaAppId(ushort** msaAppId);
    ///Reserved for Microsoft use.
    ///Params:
    ///    redirect = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRedirect(ushort** redirect);
    HRESULT GetMessageA(ushort** message);
    ///Reserved for Microsoft use.
    ///Params:
    ///    helpId = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHelpId(ushort** helpId);
    ///Reserved for Microsoft use.
    ///Params:
    ///    enforcementBans = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEnforcementBans(ushort** enforcementBans);
    ///Reserved for Microsoft use.
    ///Params:
    ///    restrictions = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRestrictions(ushort** restrictions);
    ///Reserved for Microsoft use.
    ///Params:
    ///    titleRestrictions = Type: <b>__RPC__deref_out_opt_string*</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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
