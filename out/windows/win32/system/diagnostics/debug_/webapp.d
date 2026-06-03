// Written in the D programming language.

module windows.win32.system.diagnostics.debug_.webapp;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, HWND, PWSTR;
public import windows.win32.system.com : IServiceProvider, IUnknown;
public import windows.win32.system.diagnostics.debug_.activescript : IActiveScriptError;
public import windows.win32.web.mshtml : IHTMLDocument2, IHTMLWindow2;

extern(Windows) @nogc nothrow:


// Callbacks

alias RegisterAuthoringClientFunctionType = HRESULT function(IWebApplicationAuthoringMode authoringModeObject, 
                                                             IWebApplicationHost host);
alias UnregisterAuthoringClientFunctionType = HRESULT function(IWebApplicationHost host);

// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nn-webapplication-iwebapplicationscriptevents
@GUID("7c3f6998-1567-4bba-b52b-48d32141d613")
interface IWebApplicationScriptEvents : IUnknown
{
    HRESULT BeforeScriptExecute(IHTMLWindow2 htmlWindow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationscriptevents-scripterror
    HRESULT ScriptError(IHTMLWindow2 htmlWindow, IActiveScriptError scriptError, const(PWSTR) url, 
                        BOOL errorHandled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nn-webapplication-iwebapplicationnavigationevents
@GUID("c22615d2-d318-4da2-8422-1fcaf77b10e4")
interface IWebApplicationNavigationEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationnavigationevents-beforenavigate
    HRESULT BeforeNavigate(IHTMLWindow2 htmlWindow, const(PWSTR) url, uint navigationFlags, 
                           const(PWSTR) targetFrameName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationnavigationevents-navigatecomplete
    HRESULT NavigateComplete(IHTMLWindow2 htmlWindow, const(PWSTR) url);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationnavigationevents-navigateerror
    HRESULT NavigateError(IHTMLWindow2 htmlWindow, const(PWSTR) url, const(PWSTR) targetFrameName, uint statusCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationnavigationevents-documentcomplete
    HRESULT DocumentComplete(IHTMLWindow2 htmlWindow, const(PWSTR) url);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationnavigationevents-downloadbegin
    HRESULT DownloadBegin();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationnavigationevents-downloadcomplete
    HRESULT DownloadComplete();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nn-webapplication-iwebapplicationuievents
@GUID("5b2b3f99-328c-41d5-a6f7-7483ed8e71dd")
interface IWebApplicationUIEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationuievents-securityproblem
    HRESULT SecurityProblem(uint securityProblem, HRESULT* result);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nn-webapplication-iwebapplicationupdateevents
@GUID("3e59e6b7-c652-4daf-ad5e-16feb350cde3")
interface IWebApplicationUpdateEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationupdateevents-onpaint
    HRESULT OnPaint();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationupdateevents-oncsschanged
    HRESULT OnCssChanged();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nn-webapplication-iwebapplicationhost
@GUID("cecbd2c3-a3a5-4749-9681-20e9161c6794")
interface IWebApplicationHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationhost-get_hwnd
    HRESULT get_HWND(HWND* hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationhost-get_document
    HRESULT get_Document(IHTMLDocument2* htmlDocument);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationhost-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationhost-advise
    HRESULT Advise(const(GUID)* interfaceId, IUnknown callback, uint* cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationhost-unadvise
    HRESULT Unadvise(uint cookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nn-webapplication-iwebapplicationactivation
@GUID("bcdcd0de-330e-481b-b843-4898a6a8ebac")
interface IWebApplicationActivation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationactivation-cancelpendingactivation
    HRESULT CancelPendingActivation();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nn-webapplication-iwebapplicationauthoringmode
@GUID("720aea93-1964-4db0-b005-29eb9e2b18a9")
interface IWebApplicationAuthoringMode : IServiceProvider
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/webapplication/nf-webapplication-iwebapplicationauthoringmode-get_authoringclientbinary
    HRESULT get_AuthoringClientBinary(BSTR* designModeDllPath);
}


// GUIDs


const GUID IID_IWebApplicationActivation       = GUIDOF!IWebApplicationActivation;
const GUID IID_IWebApplicationAuthoringMode    = GUIDOF!IWebApplicationAuthoringMode;
const GUID IID_IWebApplicationHost             = GUIDOF!IWebApplicationHost;
const GUID IID_IWebApplicationNavigationEvents = GUIDOF!IWebApplicationNavigationEvents;
const GUID IID_IWebApplicationScriptEvents     = GUIDOF!IWebApplicationScriptEvents;
const GUID IID_IWebApplicationUIEvents         = GUIDOF!IWebApplicationUIEvents;
const GUID IID_IWebApplicationUpdateEvents     = GUIDOF!IWebApplicationUpdateEvents;
