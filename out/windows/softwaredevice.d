module windows.softwaredevice;

public import windows.core;
public import windows.com : HRESULT;
public import windows.security : SECURITY_DESCRIPTOR;
public import windows.systemservices : BOOL, DEVPROPERTY;

extern(Windows):


// Enums


enum : int
{
    SWDeviceCapabilitiesNone           = 0x00000000,
    SWDeviceCapabilitiesRemovable      = 0x00000001,
    SWDeviceCapabilitiesSilentInstall  = 0x00000002,
    SWDeviceCapabilitiesNoDisplayInUI  = 0x00000004,
    SWDeviceCapabilitiesDriverRequired = 0x00000008,
}
alias SW_DEVICE_CAPABILITIES = int;

enum : int
{
    SWDeviceLifetimeHandle        = 0x00000000,
    SWDeviceLifetimeParentPresent = 0x00000001,
    SWDeviceLifetimeMax           = 0x00000002,
}
alias SW_DEVICE_LIFETIME = int;

// Callbacks

alias SW_DEVICE_CREATE_CALLBACK = void function(HSWDEVICE__* hSwDevice, HRESULT CreateResult, void* pContext, 
                                                const(wchar)* pszDeviceInstanceId);

// Structs


struct SW_DEVICE_CREATE_INFO
{
    uint          cbSize;
    const(wchar)* pszInstanceId;
    const(wchar)* pszzHardwareIds;
    const(wchar)* pszzCompatibleIds;
    const(GUID)*  pContainerId;
    uint          CapabilityFlags;
    const(wchar)* pszDeviceDescription;
    const(wchar)* pszDeviceLocation;
    const(SECURITY_DESCRIPTOR)* pSecurityDescriptor;
}

struct HSWDEVICE__
{
    int unused;
}

// Functions

@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceCreate(const(wchar)* pszEnumeratorName, const(wchar)* pszParentDeviceInstance, 
                       const(SW_DEVICE_CREATE_INFO)* pCreateInfo, uint cPropertyCount, char* pProperties, 
                       SW_DEVICE_CREATE_CALLBACK pCallback, void* pContext, HSWDEVICE__** phSwDevice);

@DllImport("api-ms-win-devices-swdevice-l1-1-0")
void SwDeviceClose(HSWDEVICE__* hSwDevice);

@DllImport("api-ms-win-devices-swdevice-l1-1-1")
HRESULT SwDeviceSetLifetime(HSWDEVICE__* hSwDevice, SW_DEVICE_LIFETIME Lifetime);

@DllImport("api-ms-win-devices-swdevice-l1-1-1")
HRESULT SwDeviceGetLifetime(HSWDEVICE__* hSwDevice, SW_DEVICE_LIFETIME* pLifetime);

@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDevicePropertySet(HSWDEVICE__* hSwDevice, uint cPropertyCount, char* pProperties);

@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceInterfaceRegister(HSWDEVICE__* hSwDevice, const(GUID)* pInterfaceClassGuid, 
                                  const(wchar)* pszReferenceString, uint cPropertyCount, char* pProperties, 
                                  BOOL fEnabled, ushort** ppszDeviceInterfaceId);

@DllImport("api-ms-win-devices-swdevice-l1-1-0")
void SwMemFree(void* pMem);

@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceInterfaceSetState(HSWDEVICE__* hSwDevice, const(wchar)* pszDeviceInterfaceId, BOOL fEnabled);

@DllImport("api-ms-win-devices-swdevice-l1-1-0")
HRESULT SwDeviceInterfacePropertySet(HSWDEVICE__* hSwDevice, const(wchar)* pszDeviceInterfaceId, 
                                     uint cPropertyCount, char* pProperties);


