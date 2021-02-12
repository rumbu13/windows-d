module windows.mobiledevicemanagementregistration;

public import windows.com;
public import windows.systemservices;

extern(Windows):

struct MANAGEMENT_SERVICE_INFO
{
    const(wchar)* pszMDMServiceUri;
    const(wchar)* pszAuthenticationUri;
}

struct MANAGEMENT_REGISTRATION_INFO
{
    BOOL fDeviceRegisteredWithManagement;
    uint dwDeviceRegistionKind;
    const(wchar)* pszUPN;
    const(wchar)* pszMDMServiceUri;
}

enum REGISTRATION_INFORMATION_CLASS
{
    DeviceRegistrationBasicInfo = 1,
    MaxDeviceInfoClass = 2,
}

@DllImport("MDMRegistration.dll")
HRESULT GetDeviceRegistrationInfo(REGISTRATION_INFORMATION_CLASS DeviceInformationClass, void** ppDeviceRegistrationInfo);

@DllImport("MDMRegistration.dll")
HRESULT IsDeviceRegisteredWithManagement(int* pfIsDeviceRegisteredWithManagement, uint cchUPN, const(wchar)* pszUPN);

@DllImport("MDMRegistration.dll")
HRESULT IsManagementRegistrationAllowed(int* pfIsManagementRegistrationAllowed);

@DllImport("MDMRegistration.dll")
HRESULT IsMdmUxWithoutAadAllowed(int* isEnrollmentAllowed);

@DllImport("MDMRegistration.dll")
HRESULT SetManagedExternally(BOOL IsManagedExternally);

@DllImport("MDMRegistration.dll")
HRESULT DiscoverManagementService(const(wchar)* pszUPN, MANAGEMENT_SERVICE_INFO** ppMgmtInfo);

@DllImport("MDMRegistration.dll")
HRESULT RegisterDeviceWithManagementUsingAADCredentials(HANDLE UserToken);

@DllImport("MDMRegistration.dll")
HRESULT RegisterDeviceWithManagementUsingAADDeviceCredentials();

@DllImport("MDMRegistration.dll")
HRESULT RegisterDeviceWithManagement(const(wchar)* pszUPN, const(wchar)* ppszMDMServiceUri, const(wchar)* ppzsAccessToken);

@DllImport("MDMRegistration.dll")
HRESULT UnregisterDeviceWithManagement(const(wchar)* enrollmentID);

@DllImport("MDMRegistration.dll")
HRESULT GetManagementAppHyperlink(uint cchHyperlink, const(wchar)* pszHyperlink);

@DllImport("MDMRegistration.dll")
HRESULT DiscoverManagementServiceEx(const(wchar)* pszUPN, const(wchar)* pszDiscoveryServiceCandidate, MANAGEMENT_SERVICE_INFO** ppMgmtInfo);

