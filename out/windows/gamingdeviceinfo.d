module windows.gamingdeviceinfo;

public import windows.core;
public import windows.com : HRESULT;

extern(Windows):


// Enums


enum : int
{
    GAMING_DEVICE_VENDOR_ID_NONE      = 0x00000000,
    GAMING_DEVICE_VENDOR_ID_MICROSOFT = 0xc2ec5032,
}
alias GAMING_DEVICE_VENDOR_ID = int;

enum : int
{
    GAMING_DEVICE_DEVICE_ID_NONE              = 0x00000000,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE          = 0x768bae26,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_S        = 0x2a7361d9,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X        = 0x5ad617c7,
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X_DEVKIT = 0x10f7cde3,
}
alias GAMING_DEVICE_DEVICE_ID = int;

// Structs


struct GAMING_DEVICE_MODEL_INFORMATION
{
    GAMING_DEVICE_VENDOR_ID vendorId;
    GAMING_DEVICE_DEVICE_ID deviceId;
}

// Functions

@DllImport("api-ms-win-gaming-deviceinformation-l1-1-0")
HRESULT GetGamingDeviceModelInformation(GAMING_DEVICE_MODEL_INFORMATION* information);


