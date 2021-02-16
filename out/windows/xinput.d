module windows.xinput;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Structs


struct XINPUT_GAMEPAD
{
    ushort wButtons;
    ubyte  bLeftTrigger;
    ubyte  bRightTrigger;
    short  sThumbLX;
    short  sThumbLY;
    short  sThumbRX;
    short  sThumbRY;
}

struct XINPUT_STATE
{
    uint           dwPacketNumber;
    XINPUT_GAMEPAD Gamepad;
}

struct XINPUT_VIBRATION
{
    ushort wLeftMotorSpeed;
    ushort wRightMotorSpeed;
}

struct XINPUT_CAPABILITIES
{
    ubyte            Type;
    ubyte            SubType;
    ushort           Flags;
    XINPUT_GAMEPAD   Gamepad;
    XINPUT_VIBRATION Vibration;
}

struct XINPUT_BATTERY_INFORMATION
{
    ubyte BatteryType;
    ubyte BatteryLevel;
}

struct XINPUT_KEYSTROKE
{
    ushort VirtualKey;
    ushort Unicode;
    ushort Flags;
    ubyte  UserIndex;
    ubyte  HidCode;
}

// Functions

@DllImport("XINPUTUAP")
uint XInputGetState(uint dwUserIndex, XINPUT_STATE* pState);

@DllImport("XINPUTUAP")
uint XInputSetState(uint dwUserIndex, XINPUT_VIBRATION* pVibration);

@DllImport("XINPUTUAP")
uint XInputGetCapabilities(uint dwUserIndex, uint dwFlags, XINPUT_CAPABILITIES* pCapabilities);

@DllImport("XINPUTUAP")
void XInputEnable(BOOL enable);

@DllImport("XINPUTUAP")
uint XInputGetAudioDeviceIds(uint dwUserIndex, const(wchar)* pRenderDeviceId, uint* pRenderCount, 
                             const(wchar)* pCaptureDeviceId, uint* pCaptureCount);

@DllImport("XINPUTUAP")
uint XInputGetBatteryInformation(uint dwUserIndex, ubyte devType, XINPUT_BATTERY_INFORMATION* pBatteryInformation);

@DllImport("XINPUTUAP")
uint XInputGetKeystroke(uint dwUserIndex, uint dwReserved, XINPUT_KEYSTROKE* pKeystroke);


