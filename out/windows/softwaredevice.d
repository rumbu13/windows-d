module windows.softwaredevice;

public import system;
public import windows.com;
public import windows.security;
public import windows.systemservices;

extern(Windows):

enum SW_DEVICE_CAPABILITIES
{
    SWDeviceCapabilitiesNone = 0,
    SWDeviceCapabilitiesRemovable = 1,
    SWDeviceCapabilitiesSilentInstall = 2,
    SWDeviceCapabilitiesNoDisplayInUI = 4,
    SWDeviceCapabilitiesDriverRequired = 8,
}

struct SW_DEVICE_CREATE_INFO
{
    uint cbSize;
    const(wchar)* pszInstanceId;
    const(wchar)* pszzHardwareIds;
    const(wchar)* pszzCompatibleIds;
    const(Guid)* pContainerId;
    uint CapabilityFlags;
    const(wchar)* pszDeviceDescription;
    const(wchar)* pszDeviceLocation;
    const(SECURITY_DESCRIPTOR)* pSecurityDescriptor;
}

enum SW_DEVICE_LIFETIME
{
    SWDeviceLifetimeHandle = 0,
    SWDeviceLifetimeParentPresent = 1,
    SWDeviceLifetimeMax = 2,
}

struct HSWDEVICE__
{
    int unused;
}

alias SW_DEVICE_CREATE_CALLBACK = extern(Windows) void function(HSWDEVICE__* hSwDevice, HRESULT CreateResult, void* pContext, const(wchar)* pszDeviceInstanceId);
@DllImport("api-ms-win-devices-swdevice-l1-1-0.dll")
HRESULT SwDeviceCreate(const(wchar)* pszEnumeratorName, const(wchar)* pszParentDeviceInstance, const(SW_DEVICE_CREATE_INFO)* pCreateInfo, uint cPropertyCount, char* pProperties, SW_DEVICE_CREATE_CALLBACK pCallback, void* pContext, HSWDEVICE__** phSwDevice);

@DllImport("api-ms-win-devices-swdevice-l1-1-0.dll")
void SwDeviceClose(HSWDEVICE__* hSwDevice);

@DllImport("api-ms-win-devices-swdevice-l1-1-1.dll")
HRESULT SwDeviceSetLifetime(HSWDEVICE__* hSwDevice, SW_DEVICE_LIFETIME Lifetime);

@DllImport("api-ms-win-devices-swdevice-l1-1-1.dll")
HRESULT SwDeviceGetLifetime(HSWDEVICE__* hSwDevice, SW_DEVICE_LIFETIME* pLifetime);

@DllImport("api-ms-win-devices-swdevice-l1-1-0.dll")
HRESULT SwDevicePropertySet(HSWDEVICE__* hSwDevice, uint cPropertyCount, char* pProperties);

@DllImport("api-ms-win-devices-swdevice-l1-1-0.dll")
HRESULT SwDeviceInterfaceRegister(HSWDEVICE__* hSwDevice, const(Guid)* pInterfaceClassGuid, const(wchar)* pszReferenceString, uint cPropertyCount, char* pProperties, BOOL fEnabled, ushort** ppszDeviceInterfaceId);

@DllImport("api-ms-win-devices-swdevice-l1-1-0.dll")
void SwMemFree(void* pMem);

@DllImport("api-ms-win-devices-swdevice-l1-1-0.dll")
HRESULT SwDeviceInterfaceSetState(HSWDEVICE__* hSwDevice, const(wchar)* pszDeviceInterfaceId, BOOL fEnabled);

@DllImport("api-ms-win-devices-swdevice-l1-1-0.dll")
HRESULT SwDeviceInterfacePropertySet(HSWDEVICE__* hSwDevice, const(wchar)* pszDeviceInterfaceId, uint cPropertyCount, char* pProperties);

