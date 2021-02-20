// Written in the D programming language.

module windows.mobiledevicemanagementregistration;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL, HANDLE, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Contains information about the device registration.
alias REGISTRATION_INFORMATION_CLASS = int;
enum : int
{
    ///Information about the device registration.
    DeviceRegistrationBasicInfo = 0x00000001,
    MaxDeviceInfoClass          = 0x00000002,
}

// Structs


///Contains the endpoints and information about the management service.
struct MANAGEMENT_SERVICE_INFO
{
    ///The URI of the Mobile Device Management service.
    PWSTR pszMDMServiceUri;
    ///The URI of the Authentication service.
    PWSTR pszAuthenticationUri;
}

struct MANAGEMENT_REGISTRATION_INFO
{
    BOOL  fDeviceRegisteredWithManagement;
    uint  dwDeviceRegistionKind;
    PWSTR pszUPN;
    PWSTR pszMDMServiceUri;
}

// Functions

///Retrieves the device registration information.
///Params:
///    DeviceInformationClass = Contains the maximum length that can be returned through the <i>pszHyperlink</i> parameter.
///    ppDeviceRegistrationInfo = Details of the device registration.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. .
///    
@DllImport("MDMRegistration")
HRESULT GetDeviceRegistrationInfo(REGISTRATION_INFORMATION_CLASS DeviceInformationClass, 
                                  void** ppDeviceRegistrationInfo);

///Checks whether the device is registered with an MDM service. If the device is registered, it also returns the user
///principal name (UPN) of the registered user.
///Params:
///    pfIsDeviceRegisteredWithManagement = Address of a <b>BOOL</b> indicates whether the device is registered.
///    cchUPN = Contains the maximum length that can be returned through the <i>pszUPN</i> parameter.
///    pszUPN = Optional address of a buffer that receives the <b>NULL</b>-terminated Unicode string containing the UPN of the
///             user registered with the management service. If <i>pszUPN</i> is <b>NULL</b> then the <b>BOOL</b> pointed to by
///             the <i>pfIsDeviceRegisteredWithManagement</i> parameter is updated to indicate whether the device is registered
///             and the function returns <b>ERROR_SUCCESS</b>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the <b>BOOL</b> pointed to by the
///    <i>pfIsDeviceRegisteredWithManagement</i> parameter contains <b>TRUE</b> or <b>FALSE</b>. If <b>TRUE</b>, the
///    Unicode string pointed to by the <i>pszUPN</i> parameter contains the UPN of the registered user. If the function
///    fails, the returned value describes the error. Possible values include those listed at MDM Registration Error
///    Values. If the buffer size indicated by the <i>cchUPN</i> parameter is too small then the call will fail with
///    <b>STRSAFE_E_INSUFFICIENT_BUFFER</b> but the <b>BOOL</b> pointed to by the
///    <i>pfIsDeviceRegisteredWithManagement</i> parameter will be updated to indicate whether the device is registered.
///    
@DllImport("MDMRegistration")
HRESULT IsDeviceRegisteredWithManagement(BOOL* pfIsDeviceRegisteredWithManagement, uint cchUPN, PWSTR pszUPN);

///Checks whether MDM registration is allowed by local policy.
///Params:
///    pfIsManagementRegistrationAllowed = Address of a <b>BOOL</b> that receives a value indication whether registration is allowed.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> and the <b>BOOL</b> pointed to by the
///    <i>pfIsManagementRegistrationAllowed</i> parameter contains <b>TRUE</b> or <b>FALSE</b>. If the function fails,
///    the returned value describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT IsManagementRegistrationAllowed(BOOL* pfIsManagementRegistrationAllowed);

@DllImport("MDMRegistration")
HRESULT IsMdmUxWithoutAadAllowed(BOOL* isEnrollmentAllowed);

///Indicates to the MDM agent that the device is managed externally and is not to be registered with an MDM service.
///Params:
///    IsManagedExternally = If <b>TRUE</b> this device is not to be registered with an MDM service. If <b>FALSE</b> this device can be
///                          registered with an MDM service.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT SetManagedExternally(BOOL IsManagedExternally);

///Discovers the MDM service. The discovery process uses the [MS-MDE]: Mobile Device Enrollment Protocol protocol.
///Params:
///    pszUPN = Address of a <b>NULL</b>-terminated Unicode string containing the user principal name (UPN) of the user
///             requesting registration.
///    ppMgmtInfo = Address of a MANAGEMENT_SERVICE_INFO structure that contains pointers to the URIs of the management and
///                 authentication services.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT DiscoverManagementService(const(PWSTR) pszUPN, MANAGEMENT_SERVICE_INFO** ppMgmtInfo);

///Registers a device with a MDM service, using Azure Active Directory (AAD) credentials.
///Params:
///    UserToken = The User to impersonate when attempting to get AAD token
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT RegisterDeviceWithManagementUsingAADCredentials(HANDLE UserToken);

///Registers a device with a MDM service, using Azure Active Directory (AAD) device credentials.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT RegisterDeviceWithManagementUsingAADDeviceCredentials();

///Registers a device with a MDM service, using the [MS-MDE]: Mobile Device Enrollment Protocol.
///Params:
///    pszUPN = Address of a <b>NULL</b>-terminated Unicode string containing the user principal name (UPN) of the user
///             requesting the registration. <b>Windows 8.1: </b>This parameter was located after the <i>ppszMDMServiceUri</i>
///             parameter in Windows 8.1.
///    ppszMDMServiceUri = Address of a <b>NULL</b>-terminated Unicode string containing the URI of the MDM service.
///    ppzsAccessToken = Address of a <b>NULL</b>-terminated Unicode string containing a token acquired from a Secure Token Service which
///                      the management service will use to validate the user.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT RegisterDeviceWithManagement(const(PWSTR) pszUPN, const(PWSTR) ppszMDMServiceUri, 
                                     const(PWSTR) ppzsAccessToken);

///Unregisters a device with the MDM service
///Params:
///    RemoveEnterpriseData = <b>TRUE</b> if resources are to be removed during unregistration, <b>FALSE</b> otherwise.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT UnregisterDeviceWithManagement(const(PWSTR) enrollmentID);

///Retrieves the management app hyperlink associated with the MDM service.
///Params:
///    cchHyperlink = Contains the maximum length that can be returned through the <i>pszHyperlink</i> parameter.
///    pszHyperlink = Address of a buffer that receives the <b>NULL</b>-terminated Unicode string with the hyperlink of the management
///                   app associated with the management service.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT GetManagementAppHyperlink(uint cchHyperlink, PWSTR pszHyperlink);

///Discovers the MDM service using a candidate server. The discovery process uses the [MS-MDE]: Mobile Device Enrollment
///Protocol protocol.
///Params:
///    pszUPN = Address of a <b>NULL</b>-terminated Unicode string containing the user principal name (UPN) of the user
///             requesting registration.
///    pszDiscoveryServiceCandidate = Address of a <b>NULL</b>-terminated Unicode string containing the discovery service candidate to use in lieu of
///                                   automatic discovery.
///    ppMgmtInfo = Address of a MANAGEMENT_SERVICE_INFO structure that contains pointers to the URIs of the management and
///                 authentication services.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the returned value
///    describes the error. Possible values include those listed at MDM Registration Error Values.
///    
@DllImport("MDMRegistration")
HRESULT DiscoverManagementServiceEx(const(PWSTR) pszUPN, const(PWSTR) pszDiscoveryServiceCandidate, 
                                    MANAGEMENT_SERVICE_INFO** ppMgmtInfo);


