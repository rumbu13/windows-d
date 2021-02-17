// Written in the D programming language.

module windows.windowsinformationprotection;

public import windows.core;
public import windows.appxpackaging : PACKAGE_ID;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : HANDLE, NTSTATUS;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows
///10, version 1607.</div> <div> </div>Indicates whether the app is enlightened for Windows Information Protection (WIP)
///and whether the app is managed by policy.
alias ENTERPRISE_DATA_POLICIES = int;
enum : int
{
    ///The app is not managed by enterprise policy.
    ENTERPRISE_POLICY_NONE        = 0x00000000,
    ///The app is allowed to access enterprise resources according to the enterprise policy.
    ENTERPRISE_POLICY_ALLOWED     = 0x00000001,
    ///The app is enlightened (self-declared in the app's resource file).
    ENTERPRISE_POLICY_ENLIGHTENED = 0x00000002,
    ENTERPRISE_POLICY_EXEMPT      = 0x00000004,
}

// Structs


struct HTHREAD_NETWORK_CONTEXT
{
    uint   ThreadId;
    HANDLE ThreadContext;
}

struct FILE_UNPROTECT_OPTIONS
{
    bool audit;
}

// Functions

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Sets the enterprise ID as the data context of the current thread. This is allowed only if the
///process already has the same enterprise ID present in its process context. It optionally returns the existing thread
///token.
///Params:
///    enterpriseId = The enterprise ID to set in the current thread's token.
///    threadNetworkContext = On success, holds the existing thread token.
@DllImport("srpapi")
HRESULT SrpCreateThreadNetworkContext(const(wchar)* enterpriseId, HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Restores a thread back to the original context, which may have been optionally returned from
///SrpCreateThreadNetworkContext.
///Params:
///    threadNetworkContext = A handle to the original context’s token.
@DllImport("srpapi")
HRESULT SrpCloseThreadNetworkContext(HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Sets a data intent on a token. The caller process should be enterprise allowed for the
///provided enterprise ID. If the caller intends to set a personal intent on the token, then NULL should be passed as
///enterprise ID.
///Params:
///    tokenHandle = The token handle on which the intent is to be set.
///    enterpriseId = The enterprise ID to set as intent.
@DllImport("srpapi")
HRESULT SrpSetTokenEnterpriseId(HANDLE tokenHandle, const(wchar)* enterpriseId);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy cannot be applied on Windows 10, version
///1511 (build 10586) or earlier.</div> <div> </div>Gets the list of enterprise identifiers for the given token. The
///enterprise IDs are returned only for those applications explicitly allowed by management.
///Params:
///    tokenHandle = Token Handle to be checked.
///    numberOfBytes = If <i>enterpriseIds</i> is provided, then this supplies the size of the <i>enterpriseIds</i> buffer. If you
///                    provide a buffer size, and it's too small, the output will contain the required size of the <i>enterpriseIds</i>
///                    buffer.
///    enterpriseIds = An array of enterprise ID string pointers.
///    enterpriseIdCount = The enterprise ID count on the token. Zero if the token is not explicitly enterprise allowed.
@DllImport("srpapi")
HRESULT SrpGetEnterpriseIds(HANDLE tokenHandle, uint* numberOfBytes, char* enterpriseIds, uint* enterpriseIdCount);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Enables permissive mode for file encryption on the current thread and all threads this thread
///will create or post work to. Use SrpDisablePermissiveModeFileEncryption to disable the mode. This API does not
///attempt to handle nested calls by reference counting or such. Subsequent calls to
///<b>SrpEnablePermissiveModeFileEncryption</b> after the first successful call to this API will not have any effect.
///Params:
///    enterpriseId = Contains enterprise ID string. In TH2 this is not used.
@DllImport("srpapi")
HRESULT SrpEnablePermissiveModeFileEncryption(const(wchar)* enterpriseId);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Disables permissive mode for file encryption on the current thread. Use
///SrpEnablePermissiveModeFileEncryption to enable the mode. This API does not attempt to handle nested calls by
///reference counting or such. The first call to <b>SrpDisablePermissiveModeFileEncryption</b> will disable the
///permissive mode.
@DllImport("srpapi")
HRESULT SrpDisablePermissiveModeFileEncryption();

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Gets information about the enterprise policy of an app.
///Params:
///    tokenHandle = Token Handle to be checked.
///    policyFlags = A collection of flags that indicate among other things whether the host app is allowed by the managing enterprise
///                  policy, and has been enlightened for Windows Information Protection.
@DllImport("srpapi")
HRESULT SrpGetEnterprisePolicy(HANDLE tokenHandle, ENTERPRISE_DATA_POLICIES* policyFlags);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy cannot be applied on Windows 10, version
///1511 (build 10586) or earlier.</div> <div> </div>Identifies whether a service is a token service.
///Params:
///    TokenHandle = Token Handle to be checked.
///    IsTokenService = A boolean value that indicates whether the service is a token service.
@DllImport("srpapi")
NTSTATUS SrpIsTokenService(HANDLE TokenHandle, ubyte* IsTokenService);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Evaluates whether a packaged app will be allowed to execute based on software restriction
///policies.
///Params:
///    packageId = Provides package name, publisher name, and version of the packaged app.
///    isAllowed = A boolean value that indicates whether the app is allowed to execute.
@DllImport("srpapi")
HRESULT SrpDoesPolicyAllowAppExecution(const(PACKAGE_ID)* packageId, int* isAllowed);

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Protects the data in a file to an enterprise identity, so that only users who are associated
///with that enterprise identity can access the data. The application can then use standard APIs to read or write from
///the file.
///Params:
///    fileOrFolderPath = The path for the file or folder that you want to protect.
///    identity = The enterprise identity for which the data is protected. This identity is an email address or domain that is
///               managed.
@DllImport("efswrt")
HRESULT ProtectFileToEnterpriseIdentity(const(wchar)* fileOrFolderPath, const(wchar)* identity);

@DllImport("efswrt")
HRESULT UnprotectFile(const(wchar)* fileOrFolderPath, const(FILE_UNPROTECT_OPTIONS)* options);


// Interfaces

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Manages enterprise protection policy on protected content.
@GUID("4652651D-C1FE-4BA1-9F0A-C0F56596F721")
interface IProtectionPolicyManagerInterop : IInspectable
{
    ///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
    ///1607.</div> <div> </div>Request access to enterprise protected content for an identity.
    ///Params:
    ///    appWindow = A handle to the current window.
    ///    sourceIdentity = The enterprise identity to which the content is protected. This is an email address or domain that is
    ///                     managed.
    ///    targetIdentity = The enterprise identity to which the content is being disclosed. This is an email address or domain.
    ///    riid = Reference to the identifier of the interface describing the type of interface pointer to return in
    ///           <i>asyncOperation</i>.
    ///    asyncOperation = An IAsyncOperation<ProtectionPolicyEvaluationResult> with a value of the ProtectionPolicyEvaluationResult
    ///                     enumeration that is the result of the request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RequestAccessForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, ptrdiff_t targetIdentity, 
                                        const(GUID)* riid, void** asyncOperation);
    ///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
    ///1607.</div> <div> </div>Returns the protection policy manager object associated with the current app window.
    ///Params:
    ///    appWindow = A handle to the current window.
    ///    riid = Reference to the identifier of the interface describing the type of interface pointer to return in
    ///           <i>result</i>.
    ///    result = The protection policy manager object for the current window.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** result);
}

///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
///1607.</div> <div> </div>Manages enterprise protection policy on protected content.
@GUID("157CFBE4-A78D-4156-B384-61FDAC41E686")
interface IProtectionPolicyManagerInterop2 : IInspectable
{
    ///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
    ///1607.</div> <div> </div>Request access to enterprise-protected content for a specific target app.
    ///Params:
    ///    appWindow = A handle to the current window.
    ///    sourceIdentity = The enterprise identity to which the content is protected. This is an email address or domain that is
    ///                     managed.
    ///    appPackageFamilyName = The enterprise identity to which the content is being disclosed. This is an email address or domain.
    ///    riid = Reference to the identifier of the interface describing the type of interface pointer to return in
    ///           <i>asyncOperation</i>.
    ///    asyncOperation = An IAsyncOperation<ProtectionPolicyEvaluationResult> with a value of the ProtectionPolicyEvaluationResult
    ///                     enumeration that is the result of the request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RequestAccessForAppWithWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                               ptrdiff_t appPackageFamilyName, const(GUID)* riid, 
                                               void** asyncOperation);
    ///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
    ///1607.</div> <div> </div>Request access to enterprise protected content for an identity.
    ///Params:
    ///    appWindow = A handle to the current window.
    ///    sourceIdentity = The enterprise identity to which the content is protected. This is an email address or domain that is
    ///                     managed.
    ///    targetIdentity = The enterprise identity to which the content is being disclosed. This is an email address or domain.
    ///    auditInfoUnk = An audit info object; an instance of ProtectionPolicyAuditInfo.
    ///    riid = Reference to the identifier of the interface describing the type of interface pointer to return in
    ///           <i>asyncOperation</i>.
    ///    asyncOperation = An IAsyncOperation<ProtectionPolicyEvaluationResult> with a value of the ProtectionPolicyEvaluationResult
    ///                     enumeration that is the result of the request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RequestAccessWithAuditingInfoForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                        ptrdiff_t targetIdentity, IUnknown auditInfoUnk, 
                                                        const(GUID)* riid, void** asyncOperation);
    ///Request access to enterprise protected content for an identity.
    ///Params:
    ///    appWindow = A handle to the current window.
    ///    sourceIdentity = The enterprise identity to which the content is protected. This is an email address or domain that is
    ///                     managed.
    ///    targetIdentity = The enterprise identity to which the content is being disclosed. This is an email address or domain.
    ///    auditInfoUnk = An audit info object; an instance of ProtectionPolicyAuditInfo.
    ///    messageFromApp = A message that will be displayed in the consent dialog so that the user can make a consent decision.
    ///    riid = Reference to the identifier of the interface describing the type of interface pointer to return in
    ///           <i>asyncOperation</i>.
    ///    asyncOperation = An IAsyncOperation<ProtectionPolicyEvaluationResult> with a value of the ProtectionPolicyEvaluationResult
    ///                     enumeration that is the result of the request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RequestAccessWithMessageForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                   ptrdiff_t targetIdentity, IUnknown auditInfoUnk, 
                                                   ptrdiff_t messageFromApp, const(GUID)* riid, 
                                                   void** asyncOperation);
    ///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
    ///1607.</div> <div> </div>Request access to enterprise-protected content for a specific target app.
    ///Params:
    ///    appWindow = A handle to the current window.
    ///    sourceIdentity = The enterprise identity to which the content is protected. This is an email address or domain that is
    ///                     managed.
    ///    appPackageFamilyName = The enterprise identity to which the content is being disclosed. This is an email address or domain.
    ///    auditInfoUnk = An audit info object; an instance of ProtectionPolicyAuditInfo.
    ///    riid = Reference to the identifier of the interface describing the type of interface pointer to return in
    ///           <i>asyncOperation</i>.
    ///    asyncOperation = An IAsyncOperation<ProtectionPolicyEvaluationResult> with a value of the ProtectionPolicyEvaluationResult
    ///                     enumeration that is the result of the request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RequestAccessForAppWithAuditingInfoForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                              ptrdiff_t appPackageFamilyName, IUnknown auditInfoUnk, 
                                                              const(GUID)* riid, void** asyncOperation);
    ///<div class="alert"><b>Note</b> Windows Information Protection (WIP) policy can be applied on Windows 10, version
    ///1607.</div> <div> </div>Request access to enterprise-protected content for a specific target app.
    ///Params:
    ///    appWindow = A handle to the current window.
    ///    sourceIdentity = The enterprise identity to which the content is protected. This is an email address or domain that is
    ///                     managed.
    ///    appPackageFamilyName = The enterprise identity to which the content is being disclosed. This is an email address or domain.
    ///    auditInfoUnk = An audit info object; an instance of ProtectionPolicyAuditInfo.
    ///    messageFromApp = A message that will be displayed in the consent dialog so that the user can make a consent decision.
    ///    riid = Reference to the identifier of the interface describing the type of interface pointer to return in
    ///           <i>asyncOperation</i>.
    ///    asyncOperation = An IAsyncOperation<ProtectionPolicyEvaluationResult> with a value of the ProtectionPolicyEvaluationResult
    ///                     enumeration that is the result of the request.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RequestAccessForAppWithMessageForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                         ptrdiff_t appPackageFamilyName, IUnknown auditInfoUnk, 
                                                         ptrdiff_t messageFromApp, const(GUID)* riid, 
                                                         void** asyncOperation);
}

@GUID("C1C03933-B398-4D93-B0FD-2972ADF802C2")
interface IProtectionPolicyManagerInterop3 : IInspectable
{
    HRESULT RequestAccessWithBehaviorForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                    ptrdiff_t targetIdentity, IUnknown auditInfoUnk, 
                                                    ptrdiff_t messageFromApp, uint behavior, const(GUID)* riid, 
                                                    void** asyncOperation);
    HRESULT RequestAccessForAppWithBehaviorForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                          ptrdiff_t appPackageFamilyName, IUnknown auditInfoUnk, 
                                                          ptrdiff_t messageFromApp, uint behavior, const(GUID)* riid, 
                                                          void** asyncOperation);
    HRESULT RequestAccessToFilesForAppForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, 
                                                     ptrdiff_t appPackageFamilyName, IUnknown auditInfoUnk, 
                                                     const(GUID)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForAppWithMessageAndBehaviorForWindowAsync(HWND appWindow, 
                                                                           IUnknown sourceItemListUnk, 
                                                                           ptrdiff_t appPackageFamilyName, 
                                                                           IUnknown auditInfoUnk, 
                                                                           ptrdiff_t messageFromApp, uint behavior, 
                                                                           const(GUID)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForProcessForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, 
                                                         uint processId, IUnknown auditInfoUnk, const(GUID)* riid, 
                                                         void** asyncOperation);
    HRESULT RequestAccessToFilesForProcessWithMessageAndBehaviorForWindowAsync(HWND appWindow, 
                                                                               IUnknown sourceItemListUnk, 
                                                                               uint processId, IUnknown auditInfoUnk, 
                                                                               ptrdiff_t messageFromApp, 
                                                                               uint behavior, const(GUID)* riid, 
                                                                               void** asyncOperation);
}


// GUIDs


const GUID IID_IProtectionPolicyManagerInterop  = GUIDOF!IProtectionPolicyManagerInterop;
const GUID IID_IProtectionPolicyManagerInterop2 = GUIDOF!IProtectionPolicyManagerInterop2;
const GUID IID_IProtectionPolicyManagerInterop3 = GUIDOF!IProtectionPolicyManagerInterop3;
