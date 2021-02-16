module windows.policy;

public import windows.core;
public import windows.automation : SAFEARRAY;
public import windows.com : HRESULT, IUnknown;
public import windows.controls : HPROPSHEETPAGE;
public import windows.security : GENERIC_MAPPING, OBJECT_TYPE_LIST, PRIVILEGE_SET;
public import windows.shell : APPCATEGORYINFOLIST;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND, LPARAM;
public import windows.windowsprogramming : HKEY, SYSTEMTIME;
public import windows.wmi : IWbemClassObject, IWbemServices;

extern(Windows):


// Enums


enum : int
{
    GPLinkUnknown            = 0x00000000,
    GPLinkMachine            = 0x00000001,
    GPLinkSite               = 0x00000002,
    GPLinkDomain             = 0x00000003,
    GPLinkOrganizationalUnit = 0x00000004,
}
alias GPO_LINK = int;

enum : int
{
    RSOPUnspecified      = 0x00000000,
    RSOPApplied          = 0x00000001,
    RSOPIgnored          = 0x00000002,
    RSOPFailed           = 0x00000003,
    RSOPSubsettingFailed = 0x00000004,
}
alias SETTINGSTATUS = int;

enum : int
{
    APPNAME  = 0x00000001,
    FILEEXT  = 0x00000002,
    PROGID   = 0x00000003,
    COMCLASS = 0x00000004,
}
alias INSTALLSPECTYPE = int;

enum : int
{
    ABSENT    = 0x00000000,
    ASSIGNED  = 0x00000001,
    PUBLISHED = 0x00000002,
}
alias APPSTATE = int;

enum : int
{
    GPOTypeLocal      = 0x00000000,
    GPOTypeRemote     = 0x00000001,
    GPOTypeDS         = 0x00000002,
    GPOTypeLocalUser  = 0x00000003,
    GPOTypeLocalGroup = 0x00000004,
}
alias GROUP_POLICY_OBJECT_TYPE = int;

enum : int
{
    GPHintUnknown            = 0x00000000,
    GPHintMachine            = 0x00000001,
    GPHintSite               = 0x00000002,
    GPHintDomain             = 0x00000003,
    GPHintOrganizationalUnit = 0x00000004,
}
alias GROUP_POLICY_HINT_TYPE = int;

// Callbacks

alias PFNSTATUSMESSAGECALLBACK = uint function(BOOL bVerbose, const(wchar)* lpMessage);
alias PFNPROCESSGROUPPOLICY = uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, 
                                            GROUP_POLICY_OBJECTA* pDeletedGPOList, 
                                            GROUP_POLICY_OBJECTA* pChangedGPOList, size_t pHandle, int* pbAbort, 
                                            PFNSTATUSMESSAGECALLBACK pStatusCallback);
alias PFNPROCESSGROUPPOLICYEX = uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, 
                                              GROUP_POLICY_OBJECTA* pDeletedGPOList, 
                                              GROUP_POLICY_OBJECTA* pChangedGPOList, size_t pHandle, int* pbAbort, 
                                              PFNSTATUSMESSAGECALLBACK pStatusCallback, IWbemServices pWbemServices, 
                                              int* pRsopStatus);
alias PFNGENERATEGROUPPOLICY = uint function(uint dwFlags, int* pbAbort, ushort* pwszSite, 
                                             RSOP_TARGET* pComputerTarget, RSOP_TARGET* pUserTarget);

// Structs


alias CriticalPolicySectionHandle = ptrdiff_t;

struct GROUP_POLICY_OBJECTA
{
    uint         dwOptions;
    uint         dwVersion;
    const(char)* lpDSPath;
    const(char)* lpFileSysPath;
    const(char)* lpDisplayName;
    byte[50]     szGPOName;
    GPO_LINK     GPOLink;
    LPARAM       lParam;
    GROUP_POLICY_OBJECTA* pNext;
    GROUP_POLICY_OBJECTA* pPrev;
    const(char)* lpExtensions;
    LPARAM       lParam2;
    const(char)* lpLink;
}

struct GROUP_POLICY_OBJECTW
{
    uint          dwOptions;
    uint          dwVersion;
    const(wchar)* lpDSPath;
    const(wchar)* lpFileSysPath;
    const(wchar)* lpDisplayName;
    ushort[50]    szGPOName;
    GPO_LINK      GPOLink;
    LPARAM        lParam;
    GROUP_POLICY_OBJECTW* pNext;
    GROUP_POLICY_OBJECTW* pPrev;
    const(wchar)* lpExtensions;
    LPARAM        lParam2;
    const(wchar)* lpLink;
}

struct RSOP_TARGET
{
    ushort*       pwszAccountName;
    ushort*       pwszNewSOM;
    SAFEARRAY*    psaSecurityGroups;
    void*         pRsopToken;
    GROUP_POLICY_OBJECTA* pGPOList;
    IWbemServices pWbemServices;
}

struct POLICYSETTINGSTATUSINFO
{
    const(wchar)* szKey;
    const(wchar)* szEventSource;
    const(wchar)* szEventLogName;
    uint          dwEventID;
    uint          dwErrorCode;
    SETTINGSTATUS status;
    SYSTEMTIME    timeLogged;
}

union INSTALLSPEC
{
    struct AppName
    {
        ushort* Name;
        GUID    GPOId;
    }
    ushort* FileExt;
    ushort* ProgId;
    struct COMClass
    {
        GUID Clsid;
        uint ClsCtx;
    }
}

struct INSTALLDATA
{
    INSTALLSPECTYPE Type;
    INSTALLSPEC     Spec;
}

struct LOCALMANAGEDAPPLICATION
{
    const(wchar)* pszDeploymentName;
    const(wchar)* pszPolicyName;
    const(wchar)* pszProductId;
    uint          dwState;
}

struct MANAGEDAPPLICATION
{
    const(wchar)* pszPackageName;
    const(wchar)* pszPublisher;
    uint          dwVersionHi;
    uint          dwVersionLo;
    uint          dwRevision;
    GUID          GpoId;
    const(wchar)* pszPolicyName;
    GUID          ProductId;
    ushort        Language;
    const(wchar)* pszOwner;
    const(wchar)* pszCompany;
    const(wchar)* pszComments;
    const(wchar)* pszContact;
    const(wchar)* pszSupportUrl;
    uint          dwPathType;
    BOOL          bInstalled;
}

struct GPOBROWSEINFO
{
    uint    dwSize;
    uint    dwFlags;
    HWND    hwndOwner;
    ushort* lpTitle;
    ushort* lpInitialOU;
    ushort* lpDSPath;
    uint    dwDSPathSize;
    ushort* lpName;
    uint    dwNameSize;
    GROUP_POLICY_OBJECT_TYPE gpoType;
    GROUP_POLICY_HINT_TYPE gpoHint;
}

// Functions

@DllImport("USERENV")
BOOL RefreshPolicy(BOOL bMachine);

@DllImport("USERENV")
BOOL RefreshPolicyEx(BOOL bMachine, uint dwOptions);

@DllImport("USERENV")
HANDLE EnterCriticalPolicySection(BOOL bMachine);

@DllImport("USERENV")
BOOL LeaveCriticalPolicySection(HANDLE hSection);

@DllImport("USERENV")
BOOL RegisterGPNotification(HANDLE hEvent, BOOL bMachine);

@DllImport("USERENV")
BOOL UnregisterGPNotification(HANDLE hEvent);

@DllImport("USERENV")
BOOL GetGPOListA(HANDLE hToken, const(char)* lpName, const(char)* lpHostName, const(char)* lpComputerName, 
                 uint dwFlags, GROUP_POLICY_OBJECTA** pGPOList);

@DllImport("USERENV")
BOOL GetGPOListW(HANDLE hToken, const(wchar)* lpName, const(wchar)* lpHostName, const(wchar)* lpComputerName, 
                 uint dwFlags, GROUP_POLICY_OBJECTW** pGPOList);

@DllImport("USERENV")
BOOL FreeGPOListA(GROUP_POLICY_OBJECTA* pGPOList);

@DllImport("USERENV")
BOOL FreeGPOListW(GROUP_POLICY_OBJECTW* pGPOList);

@DllImport("USERENV")
uint GetAppliedGPOListA(uint dwFlags, const(char)* pMachineName, void* pSidUser, GUID* pGuidExtension, 
                        GROUP_POLICY_OBJECTA** ppGPOList);

@DllImport("USERENV")
uint GetAppliedGPOListW(uint dwFlags, const(wchar)* pMachineName, void* pSidUser, GUID* pGuidExtension, 
                        GROUP_POLICY_OBJECTW** ppGPOList);

@DllImport("USERENV")
uint ProcessGroupPolicyCompleted(GUID* extensionId, size_t pAsyncHandle, uint dwStatus);

@DllImport("USERENV")
uint ProcessGroupPolicyCompletedEx(GUID* extensionId, size_t pAsyncHandle, uint dwStatus, HRESULT RsopStatus);

@DllImport("USERENV")
HRESULT RsopAccessCheckByType(void* pSecurityDescriptor, void* pPrincipalSelfSid, void* pRsopToken, 
                              uint dwDesiredAccessMask, char* pObjectTypeList, uint ObjectTypeListLength, 
                              GENERIC_MAPPING* pGenericMapping, char* pPrivilegeSet, uint* pdwPrivilegeSetLength, 
                              uint* pdwGrantedAccessMask, int* pbAccessStatus);

@DllImport("USERENV")
HRESULT RsopFileAccessCheck(const(wchar)* pszFileName, void* pRsopToken, uint dwDesiredAccessMask, 
                            uint* pdwGrantedAccessMask, int* pbAccessStatus);

@DllImport("USERENV")
HRESULT RsopSetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance, 
                                   uint nInfo, char* pStatus);

@DllImport("USERENV")
HRESULT RsopResetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance);

@DllImport("USERENV")
uint GenerateGPNotification(BOOL bMachine, const(wchar)* lpwszMgmtProduct, uint dwMgmtProductOptions);

@DllImport("ADVAPI32")
uint InstallApplication(INSTALLDATA* pInstallInfo);

@DllImport("ADVAPI32")
uint UninstallApplication(const(wchar)* ProductCode, uint dwStatus);

@DllImport("ADVAPI32")
uint CommandLineFromMsiDescriptor(const(wchar)* Descriptor, const(wchar)* CommandLine, uint* CommandLineLength);

@DllImport("ADVAPI32")
uint GetManagedApplications(GUID* pCategory, uint dwQueryFlags, uint dwInfoLevel, uint* pdwApps, 
                            MANAGEDAPPLICATION** prgManagedApps);

@DllImport("ADVAPI32")
uint GetLocalManagedApplications(BOOL bUserApps, uint* pdwApps, LOCALMANAGEDAPPLICATION** prgLocalApps);

@DllImport("ADVAPI32")
void GetLocalManagedApplicationData(const(wchar)* ProductCode, ushort** DisplayName, ushort** SupportUrl);

@DllImport("ADVAPI32")
uint GetManagedApplicationCategories(uint dwReserved, APPCATEGORYINFOLIST* pAppCategory);

@DllImport("GPEDIT")
HRESULT CreateGPOLink(ushort* lpGPO, ushort* lpContainer, BOOL fHighPriority);

@DllImport("GPEDIT")
HRESULT DeleteGPOLink(ushort* lpGPO, ushort* lpContainer);

@DllImport("GPEDIT")
HRESULT DeleteAllGPOLinks(ushort* lpContainer);

@DllImport("GPEDIT")
HRESULT BrowseForGPO(GPOBROWSEINFO* lpBrowseInfo);

@DllImport("GPEDIT")
HRESULT ImportRSoPData(ushort* lpNameSpace, ushort* lpFileName);

@DllImport("GPEDIT")
HRESULT ExportRSoPData(ushort* lpNameSpace, ushort* lpFileName);


// Interfaces

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
    HRESULT PolicyChanged(BOOL bMachine, BOOL bAdd, GUID* pGuidExtension, GUID* pGuidSnapin);
}

interface IGroupPolicyObject : IUnknown
{
    HRESULT New(ushort* pszDomainName, ushort* pszDisplayName, uint dwFlags);
    HRESULT OpenDSGPO(ushort* pszPath, uint dwFlags);
    HRESULT OpenLocalMachineGPO(uint dwFlags);
    HRESULT OpenRemoteMachineGPO(ushort* pszComputerName, uint dwFlags);
    HRESULT Save(BOOL bMachine, BOOL bAdd, GUID* pGuidExtension, GUID* pGuid);
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
    HRESULT GetEventLogEntryText(ushort* pszEventSource, ushort* pszEventLogName, ushort* pszEventTime, 
                                 uint dwEventID, ushort** ppszText);
}


