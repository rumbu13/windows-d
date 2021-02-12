module windows.windowsinformationprotection;

public import system;
public import windows.appxpackaging;
public import windows.com;
public import windows.systemservices;
public import windows.winrt;
public import windows.windowsandmessaging;

extern(Windows):

const GUID IID_IProtectionPolicyManagerInterop = {0x4652651D, 0xC1FE, 0x4BA1, [0x9F, 0x0A, 0xC0, 0xF5, 0x65, 0x96, 0xF7, 0x21]};
@GUID(0x4652651D, 0xC1FE, 0x4BA1, [0x9F, 0x0A, 0xC0, 0xF5, 0x65, 0x96, 0xF7, 0x21]);
interface IProtectionPolicyManagerInterop : IInspectable
{
    HRESULT RequestAccessForWindowAsync(HWND appWindow, int sourceIdentity, int targetIdentity, const(Guid)* riid, void** asyncOperation);
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** result);
}

const GUID IID_IProtectionPolicyManagerInterop2 = {0x157CFBE4, 0xA78D, 0x4156, [0xB3, 0x84, 0x61, 0xFD, 0xAC, 0x41, 0xE6, 0x86]};
@GUID(0x157CFBE4, 0xA78D, 0x4156, [0xB3, 0x84, 0x61, 0xFD, 0xAC, 0x41, 0xE6, 0x86]);
interface IProtectionPolicyManagerInterop2 : IInspectable
{
    HRESULT RequestAccessForAppWithWindowAsync(HWND appWindow, int sourceIdentity, int appPackageFamilyName, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessWithAuditingInfoForWindowAsync(HWND appWindow, int sourceIdentity, int targetIdentity, IUnknown auditInfoUnk, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessWithMessageForWindowAsync(HWND appWindow, int sourceIdentity, int targetIdentity, IUnknown auditInfoUnk, int messageFromApp, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessForAppWithAuditingInfoForWindowAsync(HWND appWindow, int sourceIdentity, int appPackageFamilyName, IUnknown auditInfoUnk, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessForAppWithMessageForWindowAsync(HWND appWindow, int sourceIdentity, int appPackageFamilyName, IUnknown auditInfoUnk, int messageFromApp, const(Guid)* riid, void** asyncOperation);
}

const GUID IID_IProtectionPolicyManagerInterop3 = {0xC1C03933, 0xB398, 0x4D93, [0xB0, 0xFD, 0x29, 0x72, 0xAD, 0xF8, 0x02, 0xC2]};
@GUID(0xC1C03933, 0xB398, 0x4D93, [0xB0, 0xFD, 0x29, 0x72, 0xAD, 0xF8, 0x02, 0xC2]);
interface IProtectionPolicyManagerInterop3 : IInspectable
{
    HRESULT RequestAccessWithBehaviorForWindowAsync(HWND appWindow, int sourceIdentity, int targetIdentity, IUnknown auditInfoUnk, int messageFromApp, uint behavior, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessForAppWithBehaviorForWindowAsync(HWND appWindow, int sourceIdentity, int appPackageFamilyName, IUnknown auditInfoUnk, int messageFromApp, uint behavior, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForAppForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, int appPackageFamilyName, IUnknown auditInfoUnk, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForAppWithMessageAndBehaviorForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, int appPackageFamilyName, IUnknown auditInfoUnk, int messageFromApp, uint behavior, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForProcessForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, uint processId, IUnknown auditInfoUnk, const(Guid)* riid, void** asyncOperation);
    HRESULT RequestAccessToFilesForProcessWithMessageAndBehaviorForWindowAsync(HWND appWindow, IUnknown sourceItemListUnk, uint processId, IUnknown auditInfoUnk, int messageFromApp, uint behavior, const(Guid)* riid, void** asyncOperation);
}

struct HTHREAD_NETWORK_CONTEXT
{
    uint ThreadId;
    HANDLE ThreadContext;
}

enum ENTERPRISE_DATA_POLICIES
{
    ENTERPRISE_POLICY_NONE = 0,
    ENTERPRISE_POLICY_ALLOWED = 1,
    ENTERPRISE_POLICY_ENLIGHTENED = 2,
    ENTERPRISE_POLICY_EXEMPT = 4,
}

struct FILE_UNPROTECT_OPTIONS
{
    bool audit;
}

@DllImport("srpapi.dll")
HRESULT SrpCreateThreadNetworkContext(const(wchar)* enterpriseId, HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

@DllImport("srpapi.dll")
HRESULT SrpCloseThreadNetworkContext(HTHREAD_NETWORK_CONTEXT* threadNetworkContext);

@DllImport("srpapi.dll")
HRESULT SrpSetTokenEnterpriseId(HANDLE tokenHandle, const(wchar)* enterpriseId);

@DllImport("srpapi.dll")
HRESULT SrpGetEnterpriseIds(HANDLE tokenHandle, uint* numberOfBytes, char* enterpriseIds, uint* enterpriseIdCount);

@DllImport("srpapi.dll")
HRESULT SrpEnablePermissiveModeFileEncryption(const(wchar)* enterpriseId);

@DllImport("srpapi.dll")
HRESULT SrpDisablePermissiveModeFileEncryption();

@DllImport("srpapi.dll")
HRESULT SrpGetEnterprisePolicy(HANDLE tokenHandle, ENTERPRISE_DATA_POLICIES* policyFlags);

@DllImport("srpapi.dll")
NTSTATUS SrpIsTokenService(HANDLE TokenHandle, ubyte* IsTokenService);

@DllImport("srpapi.dll")
HRESULT SrpDoesPolicyAllowAppExecution(const(PACKAGE_ID)* packageId, int* isAllowed);

@DllImport("efswrt.dll")
HRESULT ProtectFileToEnterpriseIdentity(const(wchar)* fileOrFolderPath, const(wchar)* identity);

@DllImport("efswrt.dll")
HRESULT UnprotectFile(const(wchar)* fileOrFolderPath, const(FILE_UNPROTECT_OPTIONS)* options);

