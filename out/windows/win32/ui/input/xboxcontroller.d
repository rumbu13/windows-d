// Written in the D programming language.

module windows.win32.ui.input.xboxcontroller;

public import windows.core;
public import windows.win32.foundation : BOOL, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias XINPUT_VIRTUAL_KEY = ushort;
enum : ushort
{
    VK_PAD_A                = cast(ushort) 0x5800,
    VK_PAD_B                = cast(ushort) 0x5801,
    VK_PAD_X                = cast(ushort) 0x5802,
    VK_PAD_Y                = cast(ushort) 0x5803,
    VK_PAD_RSHOULDER        = cast(ushort) 0x5804,
    VK_PAD_LSHOULDER        = cast(ushort) 0x5805,
    VK_PAD_LTRIGGER         = cast(ushort) 0x5806,
    VK_PAD_RTRIGGER         = cast(ushort) 0x5807,
    VK_PAD_DPAD_UP          = cast(ushort) 0x5810,
    VK_PAD_DPAD_DOWN        = cast(ushort) 0x5811,
    VK_PAD_DPAD_LEFT        = cast(ushort) 0x5812,
    VK_PAD_DPAD_RIGHT       = cast(ushort) 0x5813,
    VK_PAD_START            = cast(ushort) 0x5814,
    VK_PAD_BACK             = cast(ushort) 0x5815,
    VK_PAD_LTHUMB_PRESS     = cast(ushort) 0x5816,
    VK_PAD_RTHUMB_PRESS     = cast(ushort) 0x5817,
    VK_PAD_LTHUMB_UP        = cast(ushort) 0x5820,
    VK_PAD_LTHUMB_DOWN      = cast(ushort) 0x5821,
    VK_PAD_LTHUMB_RIGHT     = cast(ushort) 0x5822,
    VK_PAD_LTHUMB_LEFT      = cast(ushort) 0x5823,
    VK_PAD_LTHUMB_UPLEFT    = cast(ushort) 0x5824,
    VK_PAD_LTHUMB_UPRIGHT   = cast(ushort) 0x5825,
    VK_PAD_LTHUMB_DOWNRIGHT = cast(ushort) 0x5826,
    VK_PAD_LTHUMB_DOWNLEFT  = cast(ushort) 0x5827,
    VK_PAD_RTHUMB_UP        = cast(ushort) 0x5830,
    VK_PAD_RTHUMB_DOWN      = cast(ushort) 0x5831,
    VK_PAD_RTHUMB_RIGHT     = cast(ushort) 0x5832,
    VK_PAD_RTHUMB_LEFT      = cast(ushort) 0x5833,
    VK_PAD_RTHUMB_UPLEFT    = cast(ushort) 0x5834,
    VK_PAD_RTHUMB_UPRIGHT   = cast(ushort) 0x5835,
    VK_PAD_RTHUMB_DOWNRIGHT = cast(ushort) 0x5836,
    VK_PAD_RTHUMB_DOWNLEFT  = cast(ushort) 0x5837,
}

alias BATTERY_TYPE = ubyte;
enum : ubyte
{
    BATTERY_TYPE_DISCONNECTED = cast(ubyte) 0x00,
    BATTERY_TYPE_WIRED        = cast(ubyte) 0x01,
    BATTERY_TYPE_ALKALINE     = cast(ubyte) 0x02,
    BATTERY_TYPE_NIMH         = cast(ubyte) 0x03,
    BATTERY_TYPE_UNKNOWN      = cast(ubyte) 0xff,
}

alias BATTERY_LEVEL = ubyte;
enum : ubyte
{
    BATTERY_LEVEL_EMPTY  = cast(ubyte) 0x00,
    BATTERY_LEVEL_LOW    = cast(ubyte) 0x01,
    BATTERY_LEVEL_MEDIUM = cast(ubyte) 0x02,
    BATTERY_LEVEL_FULL   = cast(ubyte) 0x03,
}

alias BATTERY_DEVTYPE = ubyte;
enum : ubyte
{
    BATTERY_DEVTYPE_GAMEPAD = cast(ubyte) 0x00,
    BATTERY_DEVTYPE_HEADSET = cast(ubyte) 0x01,
}

alias XINPUT_DEVTYPE = ubyte;
enum : ubyte
{
    XINPUT_DEVTYPE_GAMEPAD = cast(ubyte) 0x01,
}

alias XINPUT_DEVSUBTYPE = ubyte;
enum : ubyte
{
    XINPUT_DEVSUBTYPE_GAMEPAD          = cast(ubyte) 0x01,
    XINPUT_DEVSUBTYPE_UNKNOWN          = cast(ubyte) 0x00,
    XINPUT_DEVSUBTYPE_WHEEL            = cast(ubyte) 0x02,
    XINPUT_DEVSUBTYPE_ARCADE_STICK     = cast(ubyte) 0x03,
    XINPUT_DEVSUBTYPE_FLIGHT_STICK     = cast(ubyte) 0x04,
    XINPUT_DEVSUBTYPE_DANCE_PAD        = cast(ubyte) 0x05,
    XINPUT_DEVSUBTYPE_GUITAR           = cast(ubyte) 0x06,
    XINPUT_DEVSUBTYPE_GUITAR_ALTERNATE = cast(ubyte) 0x07,
    XINPUT_DEVSUBTYPE_DRUM_KIT         = cast(ubyte) 0x08,
    XINPUT_DEVSUBTYPE_GUITAR_BASS      = cast(ubyte) 0x0b,
    XINPUT_DEVSUBTYPE_ARCADE_PAD       = cast(ubyte) 0x13,
}

alias XINPUT_CAPABILITIES_FLAGS = ushort;
enum : ushort
{
    XINPUT_CAPS_VOICE_SUPPORTED = cast(ushort) 0x0004,
    XINPUT_CAPS_FFB_SUPPORTED   = cast(ushort) 0x0001,
    XINPUT_CAPS_WIRELESS        = cast(ushort) 0x0002,
    XINPUT_CAPS_PMD_SUPPORTED   = cast(ushort) 0x0008,
    XINPUT_CAPS_NO_NAVIGATION   = cast(ushort) 0x0010,
}

alias XINPUT_GAMEPAD_BUTTON_FLAGS = ushort;
enum : ushort
{
    XINPUT_GAMEPAD_DPAD_UP              = cast(ushort) 0x0001,
    XINPUT_GAMEPAD_DPAD_DOWN            = cast(ushort) 0x0002,
    XINPUT_GAMEPAD_DPAD_LEFT            = cast(ushort) 0x0004,
    XINPUT_GAMEPAD_DPAD_RIGHT           = cast(ushort) 0x0008,
    XINPUT_GAMEPAD_START                = cast(ushort) 0x0010,
    XINPUT_GAMEPAD_BACK                 = cast(ushort) 0x0020,
    XINPUT_GAMEPAD_LEFT_THUMB           = cast(ushort) 0x0040,
    XINPUT_GAMEPAD_RIGHT_THUMB          = cast(ushort) 0x0080,
    XINPUT_GAMEPAD_LEFT_SHOULDER        = cast(ushort) 0x0100,
    XINPUT_GAMEPAD_RIGHT_SHOULDER       = cast(ushort) 0x0200,
    XINPUT_GAMEPAD_A                    = cast(ushort) 0x1000,
    XINPUT_GAMEPAD_B                    = cast(ushort) 0x2000,
    XINPUT_GAMEPAD_X                    = cast(ushort) 0x4000,
    XINPUT_GAMEPAD_Y                    = cast(ushort) 0x8000,
    XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE  = cast(ushort) 0x1ea9,
    XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE = cast(ushort) 0x21f1,
    XINPUT_GAMEPAD_TRIGGER_THRESHOLD    = cast(ushort) 0x001e,
}

alias XINPUT_KEYSTROKE_FLAGS = ushort;
enum : ushort
{
    XINPUT_KEYSTROKE_KEYDOWN = cast(ushort) 0x0001,
    XINPUT_KEYSTROKE_KEYUP   = cast(ushort) 0x0002,
    XINPUT_KEYSTROKE_REPEAT  = cast(ushort) 0x0004,
}

alias XINPUT_FLAG = uint;
enum : uint
{
    XINPUT_FLAG_ALL     = 0x00000000U,
    XINPUT_FLAG_GAMEPAD = 0x00000001U,
}

// Constants


enum : const(wchar)*
{
    // Native encoding: ansi
    XINPUT_DLL_A = "xinput1_4.dll",
    XINPUT_DLL_W = "xinput1_4.dll",
    XINPUT_DLL   = "xinput1_4.dll",
}

enum uint XUSER_MAX_COUNT = 0x00000004U;
enum uint XUSER_INDEX_ANY = 0x000000ffU;

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/ns-xinput-xinput_gamepad
struct XINPUT_GAMEPAD
{
    XINPUT_GAMEPAD_BUTTON_FLAGS wButtons;
    ubyte bLeftTrigger;
    ubyte bRightTrigger;
    short sThumbLX;
    short sThumbLY;
    short sThumbRX;
    short sThumbRY;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/ns-xinput-xinput_state
struct XINPUT_STATE
{
    uint           dwPacketNumber;
    XINPUT_GAMEPAD Gamepad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/ns-xinput-xinput_vibration
struct XINPUT_VIBRATION
{
    ushort wLeftMotorSpeed;
    ushort wRightMotorSpeed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/ns-xinput-xinput_capabilities
struct XINPUT_CAPABILITIES
{
    XINPUT_DEVTYPE    Type;
    XINPUT_DEVSUBTYPE SubType;
    XINPUT_CAPABILITIES_FLAGS Flags;
    XINPUT_GAMEPAD    Gamepad;
    XINPUT_VIBRATION  Vibration;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/ns-xinput-xinput_battery_information
struct XINPUT_BATTERY_INFORMATION
{
    BATTERY_TYPE  BatteryType;
    BATTERY_LEVEL BatteryLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/ns-xinput-xinput_keystroke
struct XINPUT_KEYSTROKE
{
    XINPUT_VIRTUAL_KEY VirtualKey;
    wchar              Unicode;
    XINPUT_KEYSTROKE_FLAGS Flags;
    ubyte              UserIndex;
    ubyte              HidCode;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/nf-xinput-xinputgetstate
@DllImport("xinput1_4.dll")
uint XInputGetState(uint dwUserIndex, XINPUT_STATE* pState);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/nf-xinput-xinputsetstate
@DllImport("xinput1_4.dll")
uint XInputSetState(uint dwUserIndex, XINPUT_VIBRATION* pVibration);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/nf-xinput-xinputgetcapabilities
@DllImport("xinput1_4.dll")
uint XInputGetCapabilities(uint dwUserIndex, XINPUT_FLAG dwFlags, XINPUT_CAPABILITIES* pCapabilities);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/nf-xinput-xinputenable
@DllImport("xinput1_4.dll")
void XInputEnable(BOOL enable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/nf-xinput-xinputgetaudiodeviceids
@DllImport("xinput1_4.dll")
uint XInputGetAudioDeviceIds(uint dwUserIndex, PWSTR pRenderDeviceId, uint* pRenderCount, PWSTR pCaptureDeviceId, 
                             uint* pCaptureCount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/nf-xinput-xinputgetbatteryinformation
@DllImport("xinput1_4.dll")
uint XInputGetBatteryInformation(uint dwUserIndex, BATTERY_DEVTYPE devType, 
                                 XINPUT_BATTERY_INFORMATION* pBatteryInformation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xinput/nf-xinput-xinputgetkeystroke
@DllImport("xinput1_4.dll")
uint XInputGetKeystroke(uint dwUserIndex, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                        XINPUT_KEYSTROKE* pKeystroke);


