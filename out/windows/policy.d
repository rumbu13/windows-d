module windows.policy;

public import system;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.security;
public import windows.shell;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;
public import windows.wmi;

extern(Windows):

alias CriticalPolicySectionHandle = int;
enum GPO_LINK
{
    GPLinkUnknown = 0,
    GPLinkMachine = 1,
    GPLinkSite = 2,
    GPLinkDomain = 3,
    GPLinkOrganizationalUnit = 4,
}

struct GROUP_POLICY_OBJECTA
{
    uint dwOptions;
    uint dwVersion;
    const(char)* lpDSPath;
    const(char)* lpFileSysPath;
    const(char)* lpDisplayName;
    byte szGPOName;
    GPO_LINK GPOLink;
    LPARAM lParam;
    GROUP_POLICY_OBJECTA* pNext;
    GROUP_POLICY_OBJECTA* pPrev;
    const(char)* lpExtensions;
    LPARAM lParam2;
    const(char)* lpLink;
}

struct GROUP_POLICY_OBJECTW
{
    uint dwOptions;
    uint dwVersion;
    const(wchar)* lpDSPath;
    const(wchar)* lpFileSysPath;
    const(wchar)* lpDisplayName;
    ushort szGPOName;
    GPO_LINK GPOLink;
    LPARAM lParam;
    GROUP_POLICY_OBJECTW* pNext;
    GROUP_POLICY_OBJECTW* pPrev;
    const(wchar)* lpExtensions;
    LPARAM lParam2;
    const(wchar)* lpLink;
}

alias PFNSTATUSMESSAGECALLBACK = extern(Windows) uint function(BOOL bVerbose, const(wchar)* lpMessage);
alias PFNPROCESSGROUPPOLICY = extern(Windows) uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, GROUP_POLICY_OBJECTA* pDeletedGPOList, GROUP_POLICY_OBJECTA* pChangedGPOList, uint pHandle, int* pbAbort, PFNSTATUSMESSAGECALLBACK pStatusCallback);
alias PFNPROCESSGROUPPOLICYEX = extern(Windows) uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, GROUP_POLICY_OBJECTA* pDeletedGPOList, GROUP_POLICY_OBJECTA* pChangedGPOList, uint pHandle, int* pbAbort, PFNSTATUSMESSAGECALLBACK pStatusCallback, IWbemServices pWbemServices, int* pRsopStatus);
struct RSOP_TARGET
{
    ushort* pwszAccountName;
    ushort* pwszNewSOM;
    SAFEARRAY* psaSecurityGroups;
    void* pRsopToken;
    GROUP_POLICY_OBJECTA* pGPOList;
    IWbemServices pWbemServices;
}

alias PFNGENERATEGROUPPOLICY = extern(Windows) uint function(uint dwFlags, int* pbAbort, ushort* pwszSite, RSOP_TARGET* pComputerTarget, RSOP_TARGET* pUserTarget);
enum SETTINGSTATUS
{
    RSOPUnspecified = 0,
    RSOPApplied = 1,
    RSOPIgnored = 2,
    RSOPFailed = 3,
    RSOPSubsettingFailed = 4,
}

struct POLICYSETTINGSTATUSINFO
{
    const(wchar)* szKey;
    const(wchar)* szEventSource;
    const(wchar)* szEventLogName;
    uint dwEventID;
    uint dwErrorCode;
    SETTINGSTATUS status;
    SYSTEMTIME timeLogged;
}

enum INSTALLSPECTYPE
{
    APPNAME = 1,
    FILEEXT = 2,
    PROGID = 3,
    COMCLASS = 4,
}

struct INSTALLSPEC
{
    _AppName_e__Struct AppName;
    ushort* FileExt;
    ushort* ProgId;
    _COMClass_e__Struct COMClass;
}

struct INSTALLDATA
{
    INSTALLSPECTYPE Type;
    INSTALLSPEC Spec;
}

enum APPSTATE
{
    ABSENT = 0,
    ASSIGNED = 1,
    PUBLISHED = 2,
}

struct LOCALMANAGEDAPPLICATION
{
    const(wchar)* pszDeploymentName;
    const(wchar)* pszPolicyName;
    const(wchar)* pszProductId;
    uint dwState;
}

struct MANAGEDAPPLICATION
{
    const(wchar)* pszPackageName;
    const(wchar)* pszPublisher;
    uint dwVersionHi;
    uint dwVersionLo;
    uint dwRevision;
    Guid GpoId;
    const(wchar)* pszPolicyName;
    Guid ProductId;
    ushort Language;
    const(wchar)* pszOwner;
    const(wchar)* pszCompany;
    const(wchar)* pszComments;
    const(wchar)* pszContact;
    const(wchar)* pszSupportUrl;
    uint dwPathType;
    BOOL bInstalled;
}

enum GROUP_POLICY_OBJECT_TYPE
{
    GPOTypeLocal = 0,
    GPOTypeRemote = 1,
    GPOTypeDS = 2,
    GPOTypeLocalUser = 3,
    GPOTypeLocalGroup = 4,
}

enum GROUP_POLICY_HINT_TYPE
{
    GPHintUnknown = 0,
    GPHintMachine = 1,
    GPHintSite = 2,
    GPHintDomain = 3,
    GPHintOrganizationalUnit = 4,
}

interface IGPEInformation : IUnknown
{
    HRESULT GetName(char* pszName, int cchMaxLength);
    HRESULT GetDisplayName(char* pszName, int cchMaxLength);
    HRESULT GetRegistryKey(uint dwSection, HKEY* hKey);
    HRESULT GetDSPath(uint dwSection, char* pszPath, int cchMaxPath);
    HRESULT GetFileSysPath(uint dwSection, char* pszPath, int cchMaxPath);
    HRESULT GetOptions(uint* dwOptions);
    HRESULT GetType(GROUP_POLICY_OBJECT_TYPE* gpoType);
    HRESULT GetHint(GROUP_POLICY_HINT_TYPE* gpHint);
    HRESULT PolicyChanged(BOOL bMachine, BOOL bAdd, Guid* pGuidExtension, Guid* pGuidSnapin);
}

interface IGroupPolicyObject : IUnknown
{
    HRESULT New(ushort* pszDomainName, ushort* pszDisplayName, uint dwFlags);
    HRESULT OpenDSGPO(ushort* pszPath, uint dwFlags);
    HRESULT OpenLocalMachineGPO(uint dwFlags);
    HRESULT OpenRemoteMachineGPO(ushort* pszComputerName, uint dwFlags);
    HRESULT Save(BOOL bMachine, BOOL bAdd, Guid* pGuidExtension, Guid* pGuid);
    HRESULT Delete();
    HRESULT GetName(char* pszName, int cchMaxLength);
    HRESULT GetDisplayName(char* pszName, int cchMaxLength);
    HRESULT SetDisplayName(ushort* pszName);
    HRESULT GetPath(char* pszPath, int cchMaxLength);
    HRESULT GetDSPath(uint dwSection, char* pszPath, int cchMaxPath);
    HRESULT GetFileSysPath(uint dwSection, char* pszPath, int cchMaxPath);
    HRESULT GetRegistryKey(uint dwSection, HKEY* hKey);
    HRESULT GetOptions(uint* dwOptions);
    HRESULT SetOptions(uint dwOptions, uint dwMask);
    HRESULT GetType(GROUP_POLICY_OBJECT_TYPE* gpoType);
    HRESULT GetMachineName(char* pszName, int cchMaxLength);
    HRESULT GetPropertySheetPages(HPROPSHEETPAGE** hPages, uint* uPageCount);
}

interface IRSOPInformation : IUnknown
{
    HRESULT GetNamespace(uint dwSection, char* pszName, int cchMaxLength);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT GetEventLogEntryText(ushort* pszEventSource, ushort* pszEventLogName, ushort* pszEventTime, uint dwEventID, ushort** ppszText);
}

struct GPOBROWSEINFO
{
    uint dwSize;
    uint dwFlags;
    HWND hwndOwner;
    ushort* lpTitle;
    ushort* lpInitialOU;
    ushort* lpDSPath;
    uint dwDSPathSize;
    ushort* lpName;
    uint dwNameSize;
    GROUP_POLICY_OBJECT_TYPE gpoType;
    GROUP_POLICY_HINT_TYPE gpoHint;
}

@DllImport("USERENV.dll")
BOOL RefreshPolicy(BOOL bMachine);

@DllImport("USERENV.dll")
BOOL RefreshPolicyEx(BOOL bMachine, uint dwOptions);

@DllImport("USERENV.dll")
HANDLE EnterCriticalPolicySection(BOOL bMachine);

@DllImport("USERENV.dll")
BOOL LeaveCriticalPolicySection(HANDLE hSection);

@DllImport("USERENV.dll")
BOOL RegisterGPNotification(HANDLE hEvent, BOOL bMachine);

@DllImport("USERENV.dll")
BOOL UnregisterGPNotification(HANDLE hEvent);

@DllImport("USERENV.dll")
BOOL GetGPOListA(HANDLE hToken, const(char)* lpName, const(char)* lpHostName, const(char)* lpComputerName, uint dwFlags, GROUP_POLICY_OBJECTA** pGPOList);

@DllImport("USERENV.dll")
BOOL GetGPOListW(HANDLE hToken, const(wchar)* lpName, const(wchar)* lpHostName, const(wchar)* lpComputerName, uint dwFlags, GROUP_POLICY_OBJECTW** pGPOList);

@DllImport("USERENV.dll")
BOOL FreeGPOListA(GROUP_POLICY_OBJECTA* pGPOList);

@DllImport("USERENV.dll")
BOOL FreeGPOListW(GROUP_POLICY_OBJECTW* pGPOList);

@DllImport("USERENV.dll")
uint GetAppliedGPOListA(uint dwFlags, const(char)* pMachineName, void* pSidUser, Guid* pGuidExtension, GROUP_POLICY_OBJECTA** ppGPOList);

@DllImport("USERENV.dll")
uint GetAppliedGPOListW(uint dwFlags, const(wchar)* pMachineName, void* pSidUser, Guid* pGuidExtension, GROUP_POLICY_OBJECTW** ppGPOList);

@DllImport("USERENV.dll")
uint ProcessGroupPolicyCompleted(Guid* extensionId, uint pAsyncHandle, uint dwStatus);

@DllImport("USERENV.dll")
uint ProcessGroupPolicyCompletedEx(Guid* extensionId, uint pAsyncHandle, uint dwStatus, HRESULT RsopStatus);

@DllImport("USERENV.dll")
HRESULT RsopAccessCheckByType(void* pSecurityDescriptor, void* pPrincipalSelfSid, void* pRsopToken, uint dwDesiredAccessMask, char* pObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* pGenericMapping, char* pPrivilegeSet, uint* pdwPrivilegeSetLength, uint* pdwGrantedAccessMask, int* pbAccessStatus);

@DllImport("USERENV.dll")
HRESULT RsopFileAccessCheck(const(wchar)* pszFileName, void* pRsopToken, uint dwDesiredAccessMask, uint* pdwGrantedAccessMask, int* pbAccessStatus);

@DllImport("USERENV.dll")
HRESULT RsopSetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance, uint nInfo, char* pStatus);

@DllImport("USERENV.dll")
HRESULT RsopResetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance);

@DllImport("USERENV.dll")
uint GenerateGPNotification(BOOL bMachine, const(wchar)* lpwszMgmtProduct, uint dwMgmtProductOptions);

@DllImport("ADVAPI32.dll")
uint InstallApplication(INSTALLDATA* pInstallInfo);

@DllImport("ADVAPI32.dll")
uint UninstallApplication(const(wchar)* ProductCode, uint dwStatus);

@DllImport("ADVAPI32.dll")
uint CommandLineFromMsiDescriptor(const(wchar)* Descriptor, const(wchar)* CommandLine, uint* CommandLineLength);

@DllImport("ADVAPI32.dll")
uint GetManagedApplications(Guid* pCategory, uint dwQueryFlags, uint dwInfoLevel, uint* pdwApps, MANAGEDAPPLICATION** prgManagedApps);

@DllImport("ADVAPI32.dll")
uint GetLocalManagedApplications(BOOL bUserApps, uint* pdwApps, LOCALMANAGEDAPPLICATION** prgLocalApps);

@DllImport("ADVAPI32.dll")
void GetLocalManagedApplicationData(const(wchar)* ProductCode, ushort** DisplayName, ushort** SupportUrl);

@DllImport("ADVAPI32.dll")
uint GetManagedApplicationCategories(uint dwReserved, APPCATEGORYINFOLIST* pAppCategory);

@DllImport("GPEDIT.dll")
HRESULT CreateGPOLink(ushort* lpGPO, ushort* lpContainer, BOOL fHighPriority);

@DllImport("GPEDIT.dll")
HRESULT DeleteGPOLink(ushort* lpGPO, ushort* lpContainer);

@DllImport("GPEDIT.dll")
HRESULT DeleteAllGPOLinks(ushort* lpContainer);

@DllImport("GPEDIT.dll")
HRESULT BrowseForGPO(GPOBROWSEINFO* lpBrowseInfo);

@DllImport("GPEDIT.dll")
HRESULT ImportRSoPData(ushort* lpNameSpace, ushort* lpFileName);

@DllImport("GPEDIT.dll")
HRESULT ExportRSoPData(ushort* lpNameSpace, ushort* lpFileName);

