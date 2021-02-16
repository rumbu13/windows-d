module windows.windowsinformationprotection;

public import windows.core;
public import windows.appxpackaging : PACKAGE_ID;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : HANDLE, NTSTATUS;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    ENTERPRISE_POLICY_NONE        = 0x00000000,
    ENTERPRISE_POLICY_ALLOWED     = 0x00000001,
    ENTERPRISE_POLICY_ENLIGHTENED = 0x00000002,
    ENTERPRISE_POLICY_EXEMPT      = 0x00000004,
}
alias ENTERPRISE_DATA_POLICIES = int;

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

@DllImport("srpapi")
HRESULT SrpCreateThreadNetworkContext(const(wchar)* enterpriseId, HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

@DllImport("srpapi")
HRESULT SrpCloseThreadNetworkContext(HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

@DllImport("srpapi")
HRESULT SrpSetTokenEnterpriseId(HANDLE tokenHandle, const(wchar)* enterpriseId);

@DllImport("srpapi")
HRESULT SrpGetEnterpriseIds(HANDLE tokenHandle, uint* numberOfBytes, char* enterpriseIds, uint* enterpriseIdCount);

@DllImport("srpapi")
HRESULT SrpEnablePermissiveModeFileEncryption(const(wchar)* enterpriseId);

@DllImport("srpapi")
HRESULT SrpDisablePermissiveModeFileEncryption();

@DllImport("srpapi")
HRESULT SrpGetEnterprisePolicy(HANDLE tokenHandle, ENTERPRISE_DATA_POLICIES* policyFlags);

@DllImport("srpapi")
NTSTATUS SrpIsTokenService(HANDLE TokenHandle, ubyte* IsTokenService);

@DllImport("srpapi")
HRESULT SrpDoesPolicyAllowAppExecution(const(PACKAGE_ID)* packageId, int* isAllowed);

@DllImport("efswrt")
HRESULT ProtectFileToEnterpriseIdentity(const(wchar)* fileOrFolderPath, const(wchar)* identity);

@DllImport("efswrt")
HRESULT UnprotectFile(const(wchar)* fileOrFolderPath, const(FILE_UNPROTECT_OPTIONS)* options);


// Interfaces

@GUID("4652651D-C1FE-4BA1-9F0A-C0F56596F721")
interface IProtectionPolicyManagerInterop : IInspectable
{
    HRESULT RequestAccessForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, ptrdiff_t targetIdentity, 
                                        const(GUID)* riid, void** asyncOperation);
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** result);
}

@GUID("157CFBE4-A78D-4156-B384-61FDAC41E686")
interface IProtectionPolicyManagerInterop2 : IInspectable
{
    HRESULT RequestAccessForAppWithWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                               ptrdiff_t appPackageFamilyName, const(GUID)* riid, 
                                               void** asyncOperation);
    HRESULT RequestAccessWithAuditingInfoForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                        ptrdiff_t targetIdentity, IUnknown auditInfoUnk, 
                                                        const(GUID)* riid, void** asyncOperation);
    HRESULT RequestAccessWithMessageForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                   ptrdiff_t targetIdentity, IUnknown auditInfoUnk, 
                                                   ptrdiff_t messageFromApp, const(GUID)* riid, 
                                                   void** asyncOperation);
    HRESULT RequestAccessForAppWithAuditingInfoForWindowAsync(HWND appWindow, ptrdiff_t sourceIdentity, 
                                                              ptrdiff_t appPackageFamilyName, IUnknown auditInfoUnk, 
                                                              const(GUID)* riid, void** asyncOperation);
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
