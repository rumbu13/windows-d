module windows.windowsmedialibrarysharingservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT;

extern(Windows):


// Enums


enum WindowsMediaLibrarySharingDeviceAuthorizationStatus : int
{
    DEVICE_AUTHORIZATION_UNKNOWN = 0x00000000,
    DEVICE_AUTHORIZATION_ALLOWED = 0x00000001,
    DEVICE_AUTHORIZATION_DENIED  = 0x00000002,
}

// Interfaces

@GUID("AD581B00-7B64-4E59-A38D-D2C5BF51DDB3")
struct WindowsMediaLibrarySharingServices;

@GUID("81E26927-7A7D-40A7-81D4-BDDC02960E3E")
interface IWindowsMediaLibrarySharingDeviceProperty : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_Value(VARIANT* value);
}

@GUID("C4623214-6B06-40C5-A623-B2FF4C076BFD")
interface IWindowsMediaLibrarySharingDeviceProperties : IDispatch
{
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDeviceProperty* property);
    HRESULT get_Count(int* count);
    HRESULT GetProperty(BSTR name, IWindowsMediaLibrarySharingDeviceProperty* property);
}

@GUID("3DCCC293-4FD9-4191-A25B-8E57C5D27BD4")
interface IWindowsMediaLibrarySharingDevice : IDispatch
{
    HRESULT get_DeviceID(BSTR* deviceID);
    HRESULT get_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus* authorization);
    HRESULT put_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus authorization);
    HRESULT get_Properties(IWindowsMediaLibrarySharingDeviceProperties* deviceProperties);
}

@GUID("1803F9D6-FE6D-4546-BF5B-992FE8EC12D1")
interface IWindowsMediaLibrarySharingDevices : IDispatch
{
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDevice* device);
    HRESULT get_Count(int* count);
    HRESULT GetDevice(BSTR deviceID, IWindowsMediaLibrarySharingDevice* device);
}

@GUID("01F5F85E-0A81-40DA-A7C8-21EF3AF8440C")
interface IWindowsMediaLibrarySharingServices : IDispatch
{
    HRESULT showShareMediaCPL(BSTR device);
    HRESULT get_userHomeMediaSharingState(short* sharingEnabled);
    HRESULT put_userHomeMediaSharingState(short sharingEnabled);
    HRESULT get_userHomeMediaSharingLibraryName(BSTR* libraryName);
    HRESULT put_userHomeMediaSharingLibraryName(BSTR libraryName);
    HRESULT get_computerHomeMediaSharingAllowedState(short* sharingAllowed);
    HRESULT put_computerHomeMediaSharingAllowedState(short sharingAllowed);
    HRESULT get_userInternetMediaSharingState(short* sharingEnabled);
    HRESULT put_userInternetMediaSharingState(short sharingEnabled);
    HRESULT get_computerInternetMediaSharingAllowedState(short* sharingAllowed);
    HRESULT put_computerInternetMediaSharingAllowedState(short sharingAllowed);
    HRESULT get_internetMediaSharingSecurityGroup(BSTR* securityGroup);
    HRESULT put_internetMediaSharingSecurityGroup(BSTR securityGroup);
    HRESULT get_allowSharingToAllDevices(short* sharingEnabled);
    HRESULT put_allowSharingToAllDevices(short sharingEnabled);
    HRESULT setDefaultAuthorization(BSTR MACAddresses, BSTR friendlyName, short authorization);
    HRESULT setAuthorizationState(BSTR MACAddress, short authorizationState);
    HRESULT getAllDevices(IWindowsMediaLibrarySharingDevices* devices);
    HRESULT get_customSettingsApplied(short* customSettingsApplied);
}


// GUIDs

const GUID CLSID_WindowsMediaLibrarySharingServices = GUIDOF!WindowsMediaLibrarySharingServices;

const GUID IID_IWindowsMediaLibrarySharingDevice           = GUIDOF!IWindowsMediaLibrarySharingDevice;
const GUID IID_IWindowsMediaLibrarySharingDeviceProperties = GUIDOF!IWindowsMediaLibrarySharingDeviceProperties;
const GUID IID_IWindowsMediaLibrarySharingDeviceProperty   = GUIDOF!IWindowsMediaLibrarySharingDeviceProperty;
const GUID IID_IWindowsMediaLibrarySharingDevices          = GUIDOF!IWindowsMediaLibrarySharingDevices;
const GUID IID_IWindowsMediaLibrarySharingServices         = GUIDOF!IWindowsMediaLibrarySharingServices;
