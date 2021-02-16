module windows.mobiledevicemanagementregistration;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows):


// Enums


enum : int
{
    DeviceRegistrationBasicInfo = 0x00000001,
    MaxDeviceInfoClass          = 0x00000002,
}
alias REGISTRATION_INFORMATION_CLASS = int;

// Structs


struct MANAGEMENT_SERVICE_INFO
{
    const(wchar)* pszMDMServiceUri;
    const(wchar)* pszAuthenticationUri;
}

struct MANAGEMENT_REGISTRATION_INFO
{
    BOOL          fDeviceRegisteredWithManagement;
    uint          dwDeviceRegistionKind;
    const(wchar)* pszUPN;
    const(wchar)* pszMDMServiceUri;
}

// Functions

@DllImport("MDMRegistration")
HRESULT GetDeviceRegistrationInfo(REGISTRATION_INFORMATION_CLASS DeviceInformationClass, 
                                  void** ppDeviceRegistrationInfo);

@DllImport("MDMRegistration")
HRESULT IsDeviceRegisteredWithManagement(int* pfIsDeviceRegisteredWithManagement, uint cchUPN, 
                                         const(wchar)* pszUPN);

@DllImport("MDMRegistration")
HRESULT IsManagementRegistrationAllowed(int* pfIsManagementRegistrationAllowed);

@DllImport("MDMRegistration")
HRESULT IsMdmUxWithoutAadAllowed(int* isEnrollmentAllowed);

@DllImport("MDMRegistration")
HRESULT SetManagedExternally(BOOL IsManagedExternally);

@DllImport("MDMRegistration")
HRESULT DiscoverManagementService(const(wchar)* pszUPN, MANAGEMENT_SERVICE_INFO** ppMgmtInfo);

@DllImport("MDMRegistration")
HRESULT RegisterDeviceWithManagementUsingAADCredentials(HANDLE UserToken);

@DllImport("MDMRegistration")
HRESULT RegisterDeviceWithManagementUsingAADDeviceCredentials();

@DllImport("MDMRegistration")
HRESULT RegisterDeviceWithManagement(const(wchar)* pszUPN, const(wchar)* ppszMDMServiceUri, 
                                     const(wchar)* ppzsAccessToken);

@DllImport("MDMRegistration")
HRESULT UnregisterDeviceWithManagement(const(wchar)* enrollmentID);

@DllImport("MDMRegistration")
HRESULT GetManagementAppHyperlink(uint cchHyperlink, const(wchar)* pszHyperlink);

@DllImport("MDMRegistration")
HRESULT DiscoverManagementServiceEx(const(wchar)* pszUPN, const(wchar)* pszDiscoveryServiceCandidate, 
                                    MANAGEMENT_SERVICE_INFO** ppMgmtInfo);


