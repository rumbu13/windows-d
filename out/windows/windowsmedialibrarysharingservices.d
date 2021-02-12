module windows.windowsmedialibrarysharingservices;

public import windows.automation;
public import windows.com;

extern(Windows):

const GUID CLSID_WindowsMediaLibrarySharingServices = {0xAD581B00, 0x7B64, 0x4E59, [0xA3, 0x8D, 0xD2, 0xC5, 0xBF, 0x51, 0xDD, 0xB3]};
@GUID(0xAD581B00, 0x7B64, 0x4E59, [0xA3, 0x8D, 0xD2, 0xC5, 0xBF, 0x51, 0xDD, 0xB3]);
struct WindowsMediaLibrarySharingServices;

enum WindowsMediaLibrarySharingDeviceAuthorizationStatus
{
    DEVICE_AUTHORIZATION_UNKNOWN = 0,
    DEVICE_AUTHORIZATION_ALLOWED = 1,
    DEVICE_AUTHORIZATION_DENIED = 2,
}

const GUID IID_IWindowsMediaLibrarySharingDeviceProperty = {0x81E26927, 0x7A7D, 0x40A7, [0x81, 0xD4, 0xBD, 0xDC, 0x02, 0x96, 0x0E, 0x3E]};
@GUID(0x81E26927, 0x7A7D, 0x40A7, [0x81, 0xD4, 0xBD, 0xDC, 0x02, 0x96, 0x0E, 0x3E]);
interface IWindowsMediaLibrarySharingDeviceProperty : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_Value(VARIANT* value);
}

const GUID IID_IWindowsMediaLibrarySharingDeviceProperties = {0xC4623214, 0x6B06, 0x40C5, [0xA6, 0x23, 0xB2, 0xFF, 0x4C, 0x07, 0x6B, 0xFD]};
@GUID(0xC4623214, 0x6B06, 0x40C5, [0xA6, 0x23, 0xB2, 0xFF, 0x4C, 0x07, 0x6B, 0xFD]);
interface IWindowsMediaLibrarySharingDeviceProperties : IDispatch
{
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDeviceProperty* property);
    HRESULT get_Count(int* count);
    HRESULT GetProperty(BSTR name, IWindowsMediaLibrarySharingDeviceProperty* property);
}

const GUID IID_IWindowsMediaLibrarySharingDevice = {0x3DCCC293, 0x4FD9, 0x4191, [0xA2, 0x5B, 0x8E, 0x57, 0xC5, 0xD2, 0x7B, 0xD4]};
@GUID(0x3DCCC293, 0x4FD9, 0x4191, [0xA2, 0x5B, 0x8E, 0x57, 0xC5, 0xD2, 0x7B, 0xD4]);
interface IWindowsMediaLibrarySharingDevice : IDispatch
{
    HRESULT get_DeviceID(BSTR* deviceID);
    HRESULT get_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus* authorization);
    HRESULT put_Authorization(WindowsMediaLibrarySharingDeviceAuthorizationStatus authorization);
    HRESULT get_Properties(IWindowsMediaLibrarySharingDeviceProperties* deviceProperties);
}

const GUID IID_IWindowsMediaLibrarySharingDevices = {0x1803F9D6, 0xFE6D, 0x4546, [0xBF, 0x5B, 0x99, 0x2F, 0xE8, 0xEC, 0x12, 0xD1]};
@GUID(0x1803F9D6, 0xFE6D, 0x4546, [0xBF, 0x5B, 0x99, 0x2F, 0xE8, 0xEC, 0x12, 0xD1]);
interface IWindowsMediaLibrarySharingDevices : IDispatch
{
    HRESULT get_Item(int index, IWindowsMediaLibrarySharingDevice* device);
    HRESULT get_Count(int* count);
    HRESULT GetDevice(BSTR deviceID, IWindowsMediaLibrarySharingDevice* device);
}

const GUID IID_IWindowsMediaLibrarySharingServices = {0x01F5F85E, 0x0A81, 0x40DA, [0xA7, 0xC8, 0x21, 0xEF, 0x3A, 0xF8, 0x44, 0x0C]};
@GUID(0x01F5F85E, 0x0A81, 0x40DA, [0xA7, 0xC8, 0x21, 0xEF, 0x3A, 0xF8, 0x44, 0x0C]);
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

