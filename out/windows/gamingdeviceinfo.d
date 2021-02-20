// Written in the D programming language.

module windows.gamingdeviceinfo;

public import windows.core;
public import windows.com : HRESULT;

extern(Windows) @nogc nothrow:


// Enums


///Indicates the vendor of the console that the game is running on.
alias GAMING_DEVICE_VENDOR_ID = int;
enum : int
{
    ///The vendor of the device is not known.
    GAMING_DEVICE_VENDOR_ID_NONE      = 0x00000000,
    ///The vendor of the device is Microsoft.
    GAMING_DEVICE_VENDOR_ID_MICROSOFT = 0xc2ec5032,
}

///Indicates the type of device that the game is running on.
alias GAMING_DEVICE_DEVICE_ID = int;
enum : int
{
    ///The device is not in the Xbox family.
    GAMING_DEVICE_DEVICE_ID_NONE              = 0x00000000,
    ///The device is an Xbox One (original).
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE          = 0x768bae26,
    ///The device is an Xbox One S.
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_S        = 0x2a7361d9,
    ///The device is an Xbox One X.
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X        = 0x5ad617c7,
    ///The device is an Xbox One X dev kit.
    GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X_DEVKIT = 0x10f7cde3,
}

// Structs


///Contains information about the device that the game is running on.
struct GAMING_DEVICE_MODEL_INFORMATION
{
    ///The vendor of the device.
    GAMING_DEVICE_VENDOR_ID vendorId;
    ///The type of device.
    GAMING_DEVICE_DEVICE_ID deviceId;
}

// Functions

///Gets information about the device that the game is running on.
///Params:
///    information = A structure containing information about the device that the game is running on.
///Returns:
///    This function does not return a value.
///    
@DllImport("api-ms-win-gaming-deviceinformation-l1-1-0")
HRESULT GetGamingDeviceModelInformation(GAMING_DEVICE_MODEL_INFORMATION* information);


