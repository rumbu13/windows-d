// Written in the D programming language.

module windows.xinput;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows):


// Structs


///Describes the current state of the Xbox 360 Controller.
struct XINPUT_GAMEPAD
{
    ///Bitmask of the device digital buttons, as follows. A set bit indicates that the corresponding button is pressed.
    ///<table> <tr> <th>Device button</th> <th>Bitmask</th> </tr> <tr> <td>XINPUT_GAMEPAD_DPAD_UP</td> <td> 0x0001</td>
    ///</tr> <tr> <td>XINPUT_GAMEPAD_DPAD_DOWN</td> <td> 0x0002</td> </tr> <tr> <td>XINPUT_GAMEPAD_DPAD_LEFT</td> <td>
    ///0x0004</td> </tr> <tr> <td>XINPUT_GAMEPAD_DPAD_RIGHT</td> <td> 0x0008</td> </tr> <tr>
    ///<td>XINPUT_GAMEPAD_START</td> <td> 0x0010</td> </tr> <tr> <td>XINPUT_GAMEPAD_BACK</td> <td> 0x0020</td> </tr>
    ///<tr> <td>XINPUT_GAMEPAD_LEFT_THUMB</td> <td> 0x0040</td> </tr> <tr> <td>XINPUT_GAMEPAD_RIGHT_THUMB</td> <td>
    ///0x0080</td> </tr> <tr> <td>XINPUT_GAMEPAD_LEFT_SHOULDER</td> <td> 0x0100</td> </tr> <tr>
    ///<td>XINPUT_GAMEPAD_RIGHT_SHOULDER</td> <td> 0x0200</td> </tr> <tr> <td>XINPUT_GAMEPAD_A</td> <td> 0x1000</td>
    ///</tr> <tr> <td>XINPUT_GAMEPAD_B</td> <td> 0x2000</td> </tr> <tr> <td>XINPUT_GAMEPAD_X</td> <td> 0x4000</td> </tr>
    ///<tr> <td>XINPUT_GAMEPAD_Y</td> <td> 0x8000</td> </tr> </table> Bits that are set but not defined above are
    ///reserved, and their state is undefined.
    ushort wButtons;
    ///The current value of the left trigger analog control. The value is between 0 and 255.
    ubyte  bLeftTrigger;
    ///The current value of the right trigger analog control. The value is between 0 and 255.
    ubyte  bRightTrigger;
    ///Left thumbstick x-axis value. Each of the thumbstick axis members is a signed value between -32768 and 32767
    ///describing the position of the thumbstick. A value of 0 is centered. Negative values signify down or to the left.
    ///Positive values signify up or to the right. The constants XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE or
    ///XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE can be used as a positive and negative value to filter a thumbstick input.
    short  sThumbLX;
    ///Left thumbstick y-axis value. The value is between -32768 and 32767.
    short  sThumbLY;
    ///Right thumbstick x-axis value. The value is between -32768 and 32767.
    short  sThumbRX;
    ///Right thumbstick y-axis value. The value is between -32768 and 32767.
    short  sThumbRY;
}

///Represents the state of a controller.
struct XINPUT_STATE
{
    ///State packet number. The packet number indicates whether there have been any changes in the state of the
    ///controller. If the <i>dwPacketNumber</i> member is the same in sequentially returned <b>XINPUT_STATE</b>
    ///structures, the controller state has not changed.
    uint           dwPacketNumber;
    ///XINPUT_GAMEPAD structure containing the current state of an Xbox 360 Controller.
    XINPUT_GAMEPAD Gamepad;
}

///Specifies motor speed levels for the vibration function of a controller.
struct XINPUT_VIBRATION
{
    ///Speed of the left motor. Valid values are in the range 0 to 65,535. Zero signifies no motor use; 65,535 signifies
    ///100 percent motor use.
    ushort wLeftMotorSpeed;
    ///Speed of the right motor. Valid values are in the range 0 to 65,535. Zero signifies no motor use; 65,535
    ///signifies 100 percent motor use.
    ushort wRightMotorSpeed;
}

///Describes the capabilities of a connected controller. The XInputGetCapabilities function returns
///<b>XINPUT_CAPABILITIES</b>.
struct XINPUT_CAPABILITIES
{
    ///Controller type. It must be one of the following values. <table> <tr> <th>Value</th> <th>Description</th> </tr>
    ///<tr> <td>XINPUT_DEVTYPE_GAMEPAD</td> <td>The device is a game controller. </td> </tr> </table>
    ubyte            Type;
    ///Subtype of the game controller. See XINPUT and Controller Subtypes for a list of allowed subtypes. <div
    ///class="alert"><b>Note</b> For restrictions on the use of this subtype value, see Remarks. More subtypes may be
    ///added in the future.</div> <div> </div>
    ubyte            SubType;
    ///Features of the controller. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///<td>XINPUT_CAPS_VOICE_SUPPORTED</td> <td>Device has an integrated voice device.</td> </tr> <tr>
    ///<td>XINPUT_CAPS_FFB_SUPPORTED</td> <td>Device supports force feedback functionality. Note that these
    ///force-feedback features beyond rumble are not currently supported through XINPUT on Windows.</td> </tr> <tr>
    ///<td>XINPUT_CAPS_WIRELESS</td> <td>Device is wireless.</td> </tr> <tr> <td>XINPUT_CAPS_PMD_SUPPORTED</td>
    ///<td>Device supports plug-in modules. Note that plug-in modules like the text input device (TID) are not supported
    ///currently through XINPUT on Windows.</td> </tr> <tr> <td>XINPUT_CAPS_NO_NAVIGATION</td> <td>Device lacks menu
    ///navigation buttons (START, BACK, DPAD).</td> </tr> </table>
    ushort           Flags;
    ///XINPUT_GAMEPAD structure that describes available controller features and control resolutions.
    XINPUT_GAMEPAD   Gamepad;
    ///XINPUT_VIBRATION structure that describes available vibration functionality and resolutions.
    XINPUT_VIBRATION Vibration;
}

///Contains information on battery type and charge state.
struct XINPUT_BATTERY_INFORMATION
{
    ///The type of battery. <i>BatteryType</i> will be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Description</th> </tr> <tr> <td>BATTERY_TYPE_DISCONNECTED</td> <td>The device is not connected. </td> </tr>
    ///<tr> <td>BATTERY_TYPE_WIRED</td> <td>The device is a wired device and does not have a battery. </td> </tr> <tr>
    ///<td>BATTERY_TYPE_ALKALINE</td> <td>The device has an alkaline battery. </td> </tr> <tr>
    ///<td>BATTERY_TYPE_NIMH</td> <td>The device has a nickel metal hydride battery. </td> </tr> <tr>
    ///<td>BATTERY_TYPE_UNKNOWN</td> <td>The device has an unknown battery type. </td> </tr> </table>
    ubyte BatteryType;
    ///The charge state of the battery. This value is only valid for wireless devices with a known battery type.
    ///<i>BatteryLevel</i> will be one of the following values. <table> <tr> <th>Value</th> </tr> <tr>
    ///<td>BATTERY_LEVEL_EMPTY</td> </tr> <tr> <td>BATTERY_LEVEL_LOW</td> </tr> <tr> <td>BATTERY_LEVEL_MEDIUM</td> </tr>
    ///<tr> <td>BATTERY_LEVEL_FULL</td> </tr> </table>
    ubyte BatteryLevel;
}

///Specifies keystroke data returned by XInputGetKeystroke.
struct XINPUT_KEYSTROKE
{
    ///Virtual-key code of the key, button, or stick movement. See XInput.h for a list of valid virtual-key (VK_xxx)
    ///codes. Also, see Remarks.
    ushort VirtualKey;
    ///This member is unused and the value is zero.
    ushort Unicode;
    ///Flags that indicate the keyboard state at the time of the input event. This member can be any combination of the
    ///following flags: <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>XINPUT_KEYSTROKE_KEYDOWN</td>
    ///<td>The key was pressed. </td> </tr> <tr> <td>XINPUT_KEYSTROKE_KEYUP</td> <td>The key was released. </td> </tr>
    ///<tr> <td>XINPUT_KEYSTROKE_REPEAT</td> <td>A repeat of a held key. </td> </tr> </table>
    ushort Flags;
    ///Index of the signed-in gamer associated with the device. Can be a value in the range 0–3.
    ubyte  UserIndex;
    ///HID code corresponding to the input. If there is no corresponding HID code, this value is zero.
    ubyte  HidCode;
}

// Functions

///Retrieves the current state of the specified controller.
///Params:
///    dwUserIndex = Index of the user's controller. Can be a value from 0 to 3. For information about how this value is determined
///                  and how the value maps to indicators on the controller, see Multiple Controllers.
///    pState = Pointer to an XINPUT_STATE structure that receives the current state of the controller.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the controller is not connected, the
///    return value is <b>ERROR_DEVICE_NOT_CONNECTED</b>. If the function fails, the return value is an error code
///    defined in Winerror.h. The function does not use <b>SetLastError</b> to set the calling thread's last-error code.
///    
@DllImport("XINPUTUAP")
uint XInputGetState(uint dwUserIndex, XINPUT_STATE* pState);

///Sends data to a connected controller. This function is used to activate the vibration function of a controller.
///Params:
///    dwUserIndex = Index of the user's controller. Can be a value from 0 to 3. For information about how this value is determined
///                  and how the value maps to indicators on the controller, see Multiple Controllers.
///    pVibration = Pointer to an XINPUT_VIBRATION structure containing the vibration information to send to the controller.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the controller is not connected, the
///    return value is <b>ERROR_DEVICE_NOT_CONNECTED</b>. If the function fails, the return value is an error code
///    defined in WinError.h. The function does not use <i>SetLastError</i> to set the calling thread's last-error code.
///    
@DllImport("XINPUTUAP")
uint XInputSetState(uint dwUserIndex, XINPUT_VIBRATION* pVibration);

///Retrieves the capabilities and features of a connected controller.
///Params:
///    dwUserIndex = Index of the user's controller. Can be a value in the range 0–3. For information about how this value is
///                  determined and how the value maps to indicators on the controller, see Multiple Controllers.
///    dwFlags = Input flags that identify the controller type. If this value is 0, then the capabilities of all controllers
///              connected to the system are returned. Currently, only one value is supported: <table> <tr> <th>Value</th>
///              <th>Description</th> </tr> <tr> <td><b>XINPUT_FLAG_GAMEPAD</b></td> <td>Limit query to devices of Xbox 360
///              Controller type.</td> </tr> </table> Any value of <i>dwflags</i> other than the above or 0 is illegal and will
///              result in an error break when debugging.
///    pCapabilities = Pointer to an XINPUT_CAPABILITIES structure that receives the controller capabilities.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the controller is not connected, the
///    return value is <b>ERROR_DEVICE_NOT_CONNECTED</b>. If the function fails, the return value is an error code
///    defined in WinError.h. The function does not use <i>SetLastError</i> to set the calling thread's last-error code.
///    
@DllImport("XINPUTUAP")
uint XInputGetCapabilities(uint dwUserIndex, uint dwFlags, XINPUT_CAPABILITIES* pCapabilities);

///Sets the reporting state of XInput.
///Params:
///    enable = If enable is <b>FALSE</b>, XInput will only send neutral data in response to XInputGetState (all buttons up, axes
///             centered, and triggers at 0). XInputSetState calls will be registered but not sent to the device. Sending any
///             value other than <b>FALSE </b>will restore reading and writing functionality to normal.
@DllImport("XINPUTUAP")
void XInputEnable(BOOL enable);

///Retrieves the sound rendering and sound capture audio device IDs that are associated with the headset connected to
///the specified controller.
///Params:
///    dwUserIndex = Index of the gamer associated with the device.
///    pRenderDeviceId = Windows Core Audio device ID string for render (speakers).
///    pRenderCount = Size, in wide-chars, of the render device ID string buffer.
///    pCaptureDeviceId = Windows Core Audio device ID string for capture (microphone).
///    pCaptureCount = Size, in wide-chars, of capture device ID string buffer.
///Returns:
///    If the function successfully retrieves the device IDs for render and capture, the return code is
///    <b>ERROR_SUCCESS</b>. If there is no headset connected to the controller, the function will also retrieve
///    <b>ERROR_SUCCESS</b> with <b>NULL</b> as the values for <i>pRenderDeviceId</i> and <i>pCaptureDeviceId</i>. If
///    the controller port device is not physically connected, the function will return
///    <b>ERROR_DEVICE_NOT_CONNECTED</b>. If the function fails, it will return a valid Win32 error code.
///    
@DllImport("XINPUTUAP")
uint XInputGetAudioDeviceIds(uint dwUserIndex, const(wchar)* pRenderDeviceId, uint* pRenderCount, 
                             const(wchar)* pCaptureDeviceId, uint* pCaptureCount);

///Retrieves the battery type and charge status of a wireless controller.
///Params:
///    dwUserIndex = Index of the signed-in gamer associated with the device. Can be a value in the range 0–XUSER_MAX_COUNT − 1.
///    devType = Specifies which device associated with this user index should be queried. Must be <b>BATTERY_DEVTYPE_GAMEPAD</b>
///              or <b>BATTERY_DEVTYPE_HEADSET</b>.
///    pBatteryInformation = Pointer to an XINPUT_BATTERY_INFORMATION structure that receives the battery information.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("XINPUTUAP")
uint XInputGetBatteryInformation(uint dwUserIndex, ubyte devType, XINPUT_BATTERY_INFORMATION* pBatteryInformation);

///Retrieves a gamepad input event.
///Params:
///    dwUserIndex = [in] Index of the signed-in gamer associated with the device. Can be a value in the range 0–XUSER_MAX_COUNT −
///                  1, or XUSER_INDEX_ANY to fetch the next available input event from any user.
///    dwReserved = [in] Reserved
///    pKeystroke = [out] Pointer to an XINPUT_KEYSTROKE structure that receives an input event.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If no new keys have been pressed, the return
///    value is <b>ERROR_EMPTY</b>. If the controller is not connected or the user has not activated it, the return
///    value is <b>ERROR_DEVICE_NOT_CONNECTED</b>. See the Remarks section below. If the function fails, the return
///    value is an error code defined in Winerror.h. The function does not use SetLastError to set the calling thread's
///    last-error code.
///    
@DllImport("XINPUTUAP")
uint XInputGetKeystroke(uint dwUserIndex, uint dwReserved, XINPUT_KEYSTROKE* pKeystroke);


