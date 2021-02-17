// Written in the D programming language.

module windows.keyboardandmouseinput;

public import windows.core;
public import windows.displaydevices : POINT;
public import windows.systemservices : BOOL, HANDLE, LRESULT;
public import windows.windowsandmessaging : HWND, WPARAM;

extern(Windows):


// Structs


///Contains information about the mouse's location in screen coordinates.
struct MOUSEMOVEPOINT
{
    ///Type: <b>int</b> The x-coordinate of the mouse.
    int    x;
    ///Type: <b>int</b> The y-coordinate of the mouse.
    int    y;
    ///Type: <b>DWORD</b> The time stamp of the mouse coordinate.
    uint   time;
    ///Type: <b>ULONG_PTR</b> Additional information associated with this coordinate.
    size_t dwExtraInfo;
}

///Used by the TrackMouseEvent function to track when the mouse pointer leaves a window or hovers over a window for a
///specified amount of time.
struct TRACKMOUSEEVENT
{
    ///Type: <b>DWORD</b> The size of the <b>TRACKMOUSEEVENT</b> structure, in bytes.
    uint cbSize;
    ///Type: <b>DWORD</b> The services requested. This member can be a combination of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TME_CANCEL"></a><a id="tme_cancel"></a><dl>
    ///<dt><b>TME_CANCEL</b></dt> <dt>0x80000000</dt> </dl> </td> <td width="60%"> The caller wants to cancel a prior
    ///tracking request. The caller should also specify the type of tracking that it wants to cancel. For example, to
    ///cancel hover tracking, the caller must pass the <b>TME_CANCEL</b> and <b>TME_HOVER</b> flags. </td> </tr> <tr>
    ///<td width="40%"><a id="TME_HOVER"></a><a id="tme_hover"></a><dl> <dt><b>TME_HOVER</b></dt> <dt>0x00000001</dt>
    ///</dl> </td> <td width="60%"> The caller wants hover notification. Notification is delivered as a WM_MOUSEHOVER
    ///message. If the caller requests hover tracking while hover tracking is already active, the hover timer will be
    ///reset. This flag is ignored if the mouse pointer is not over the specified window or area. </td> </tr> <tr> <td
    ///width="40%"><a id="TME_LEAVE"></a><a id="tme_leave"></a><dl> <dt><b>TME_LEAVE</b></dt> <dt>0x00000002</dt> </dl>
    ///</td> <td width="60%"> The caller wants leave notification. Notification is delivered as a WM_MOUSELEAVE message.
    ///If the mouse is not over the specified window or area, a leave notification is generated immediately and no
    ///further tracking is performed. </td> </tr> <tr> <td width="40%"><a id="TME_NONCLIENT"></a><a
    ///id="tme_nonclient"></a><dl> <dt><b>TME_NONCLIENT</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The
    ///caller wants hover and leave notification for the nonclient areas. Notification is delivered as WM_NCMOUSEHOVER
    ///and WM_NCMOUSELEAVE messages. </td> </tr> <tr> <td width="40%"><a id="TME_QUERY"></a><a id="tme_query"></a><dl>
    ///<dt><b>TME_QUERY</b></dt> <dt>0x40000000</dt> </dl> </td> <td width="60%"> The function fills in the structure
    ///instead of treating it as a tracking request. The structure is filled such that had that structure been passed to
    ///TrackMouseEvent, it would generate the current tracking. The only anomaly is that the hover time-out returned is
    ///always the actual time-out and not <b>HOVER_DEFAULT</b>, if <b>HOVER_DEFAULT</b> was specified during the
    ///original <b>TrackMouseEvent</b> request. </td> </tr> </table>
    uint dwFlags;
    ///Type: <b>HWND</b> A handle to the window to track.
    HWND hwndTrack;
    ///Type: <b>DWORD</b> The hover time-out (if <b>TME_HOVER</b> was specified in <b>dwFlags</b>), in milliseconds. Can
    ///be <b>HOVER_DEFAULT</b>, which means to use the system default hover time-out.
    uint dwHoverTime;
}

///Contains information about a simulated mouse event.
struct MOUSEINPUT
{
    ///Type: <b>LONG</b> The absolute position of the mouse, or the amount of motion since the last mouse event was
    ///generated, depending on the value of the <b>dwFlags</b> member. Absolute data is specified as the x coordinate of
    ///the mouse; relative data is specified as the number of pixels moved.
    int    dx;
    ///Type: <b>LONG</b> The absolute position of the mouse, or the amount of motion since the last mouse event was
    ///generated, depending on the value of the <b>dwFlags</b> member. Absolute data is specified as the y coordinate of
    ///the mouse; relative data is specified as the number of pixels moved.
    int    dy;
    ///Type: <b>DWORD</b> If <b>dwFlags</b> contains <b>MOUSEEVENTF_WHEEL</b>, then <b>mouseData</b> specifies the
    ///amount of wheel movement. A positive value indicates that the wheel was rotated forward, away from the user; a
    ///negative value indicates that the wheel was rotated backward, toward the user. One wheel click is defined as
    ///<b>WHEEL_DELTA</b>, which is 120. Windows Vista: If <i>dwFlags</i> contains <b>MOUSEEVENTF_HWHEEL</b>, then
    ///<i>dwData</i> specifies the amount of wheel movement. A positive value indicates that the wheel was rotated to
    ///the right; a negative value indicates that the wheel was rotated to the left. One wheel click is defined as
    ///<b>WHEEL_DELTA</b>, which is 120. If <b>dwFlags</b> does not contain <b>MOUSEEVENTF_WHEEL</b>,
    ///<b>MOUSEEVENTF_XDOWN</b>, or <b>MOUSEEVENTF_XUP</b>, then <b>mouseData</b> should be zero. If <b>dwFlags</b>
    ///contains <b>MOUSEEVENTF_XDOWN</b> or <b>MOUSEEVENTF_XUP</b>, then <b>mouseData</b> specifies which X buttons were
    ///pressed or released. This value may be any combination of the following flags. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="XBUTTON1"></a><a id="xbutton1"></a><dl>
    ///<dt><b>XBUTTON1</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Set if the first X button is pressed or
    ///released. </td> </tr> <tr> <td width="40%"><a id="XBUTTON2"></a><a id="xbutton2"></a><dl>
    ///<dt><b>XBUTTON2</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Set if the second X button is pressed or
    ///released. </td> </tr> </table>
    uint   mouseData;
    ///Type: <b>DWORD</b> A set of bit flags that specify various aspects of mouse motion and button clicks. The bits in
    ///this member can be any reasonable combination of the following values. The bit flags that specify mouse button
    ///status are set to indicate changes in status, not ongoing conditions. For example, if the left mouse button is
    ///pressed and held down, <b>MOUSEEVENTF_LEFTDOWN</b> is set when the left button is first pressed, but not for
    ///subsequent motions. Similarly, <b>MOUSEEVENTF_LEFTUP</b> is set only when the button is first released. You
    ///cannot specify both the <b>MOUSEEVENTF_WHEEL</b> flag and either <b>MOUSEEVENTF_XDOWN</b> or
    ///<b>MOUSEEVENTF_XUP</b> flags simultaneously in the <b>dwFlags</b> parameter, because they both require use of the
    ///<b>mouseData</b> field. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MOUSEEVENTF_ABSOLUTE"></a><a id="mouseeventf_absolute"></a><dl> <dt><b>MOUSEEVENTF_ABSOLUTE</b></dt>
    ///<dt>0x8000</dt> </dl> </td> <td width="60%"> The <b>dx</b> and <b>dy</b> members contain normalized absolute
    ///coordinates. If the flag is not set, <b>dx</b>and <b>dy</b> contain relative data (the change in position since
    ///the last reported position). This flag can be set, or not set, regardless of what kind of mouse or other pointing
    ///device, if any, is connected to the system. For further information about relative mouse motion, see the
    ///following Remarks section. </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_HWHEEL"></a><a
    ///id="mouseeventf_hwheel"></a><dl> <dt><b>MOUSEEVENTF_HWHEEL</b></dt> <dt>0x01000</dt> </dl> </td> <td width="60%">
    ///The wheel was moved horizontally, if the mouse has a wheel. The amount of movement is specified in
    ///<b>mouseData</b>. <b>Windows XP/2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="MOUSEEVENTF_MOVE"></a><a id="mouseeventf_move"></a><dl> <dt><b>MOUSEEVENTF_MOVE</b></dt> <dt>0x0001</dt>
    ///</dl> </td> <td width="60%"> Movement occurred. </td> </tr> <tr> <td width="40%"><a
    ///id="MOUSEEVENTF_MOVE_NOCOALESCE"></a><a id="mouseeventf_move_nocoalesce"></a><dl>
    ///<dt><b>MOUSEEVENTF_MOVE_NOCOALESCE</b></dt> <dt>0x2000</dt> </dl> </td> <td width="60%"> The WM_MOUSEMOVE
    ///messages will not be coalesced. The default behavior is to coalesce <b>WM_MOUSEMOVE</b> messages. <b>Windows
    ///XP/2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_LEFTDOWN"></a><a
    ///id="mouseeventf_leftdown"></a><dl> <dt><b>MOUSEEVENTF_LEFTDOWN</b></dt> <dt>0x0002</dt> </dl> </td> <td
    ///width="60%"> The left button was pressed. </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_LEFTUP"></a><a
    ///id="mouseeventf_leftup"></a><dl> <dt><b>MOUSEEVENTF_LEFTUP</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%">
    ///The left button was released. </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_RIGHTDOWN"></a><a
    ///id="mouseeventf_rightdown"></a><dl> <dt><b>MOUSEEVENTF_RIGHTDOWN</b></dt> <dt>0x0008</dt> </dl> </td> <td
    ///width="60%"> The right button was pressed. </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_RIGHTUP"></a><a
    ///id="mouseeventf_rightup"></a><dl> <dt><b>MOUSEEVENTF_RIGHTUP</b></dt> <dt>0x0010</dt> </dl> </td> <td
    ///width="60%"> The right button was released. </td> </tr> <tr> <td width="40%"><a
    ///id="MOUSEEVENTF_MIDDLEDOWN"></a><a id="mouseeventf_middledown"></a><dl> <dt><b>MOUSEEVENTF_MIDDLEDOWN</b></dt>
    ///<dt>0x0020</dt> </dl> </td> <td width="60%"> The middle button was pressed. </td> </tr> <tr> <td width="40%"><a
    ///id="MOUSEEVENTF_MIDDLEUP"></a><a id="mouseeventf_middleup"></a><dl> <dt><b>MOUSEEVENTF_MIDDLEUP</b></dt>
    ///<dt>0x0040</dt> </dl> </td> <td width="60%"> The middle button was released. </td> </tr> <tr> <td width="40%"><a
    ///id="MOUSEEVENTF_VIRTUALDESK"></a><a id="mouseeventf_virtualdesk"></a><dl> <dt><b>MOUSEEVENTF_VIRTUALDESK</b></dt>
    ///<dt>0x4000</dt> </dl> </td> <td width="60%"> Maps coordinates to the entire desktop. Must be used with
    ///<b>MOUSEEVENTF_ABSOLUTE</b>. </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_WHEEL"></a><a
    ///id="mouseeventf_wheel"></a><dl> <dt><b>MOUSEEVENTF_WHEEL</b></dt> <dt>0x0800</dt> </dl> </td> <td width="60%">
    ///The wheel was moved, if the mouse has a wheel. The amount of movement is specified in <b>mouseData</b>. </td>
    ///</tr> <tr> <td width="40%"><a id="MOUSEEVENTF_XDOWN"></a><a id="mouseeventf_xdown"></a><dl>
    ///<dt><b>MOUSEEVENTF_XDOWN</b></dt> <dt>0x0080</dt> </dl> </td> <td width="60%"> An X button was pressed. </td>
    ///</tr> <tr> <td width="40%"><a id="MOUSEEVENTF_XUP"></a><a id="mouseeventf_xup"></a><dl>
    ///<dt><b>MOUSEEVENTF_XUP</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> An X button was released. </td>
    ///</tr> </table>
    uint   dwFlags;
    ///Type: <b>DWORD</b> The time stamp for the event, in milliseconds. If this parameter is 0, the system will provide
    ///its own time stamp.
    uint   time;
    ///Type: <b>ULONG_PTR</b> An additional value associated with the mouse event. An application calls
    ///GetMessageExtraInfo to obtain this extra information.
    size_t dwExtraInfo;
}

///Contains information about a simulated keyboard event.
struct KEYBDINPUT
{
    ///Type: <b>WORD</b> A virtual-key code. The code must be a value in the range 1 to 254. If the <b>dwFlags</b>
    ///member specifies <b>KEYEVENTF_UNICODE</b>, <b>wVk</b> must be 0.
    ushort wVk;
    ///Type: <b>WORD</b> A hardware scan code for the key. If <b>dwFlags</b> specifies <b>KEYEVENTF_UNICODE</b>,
    ///<b>wScan</b> specifies a Unicode character which is to be sent to the foreground application.
    ushort wScan;
    ///Type: <b>DWORD</b> Specifies various aspects of a keystroke. This member can be certain combinations of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="KEYEVENTF_EXTENDEDKEY"></a><a id="keyeventf_extendedkey"></a><dl> <dt><b>KEYEVENTF_EXTENDEDKEY</b></dt>
    ///<dt>0x0001</dt> </dl> </td> <td width="60%"> If specified, the scan code was preceded by a prefix byte that has
    ///the value 0xE0 (224). </td> </tr> <tr> <td width="40%"><a id="KEYEVENTF_KEYUP"></a><a
    ///id="keyeventf_keyup"></a><dl> <dt><b>KEYEVENTF_KEYUP</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> If
    ///specified, the key is being released. If not specified, the key is being pressed. </td> </tr> <tr> <td
    ///width="40%"><a id="KEYEVENTF_SCANCODE"></a><a id="keyeventf_scancode"></a><dl> <dt><b>KEYEVENTF_SCANCODE</b></dt>
    ///<dt>0x0008</dt> </dl> </td> <td width="60%"> If specified, <b>wScan</b> identifies the key and <b>wVk</b> is
    ///ignored. </td> </tr> <tr> <td width="40%"><a id="KEYEVENTF_UNICODE"></a><a id="keyeventf_unicode"></a><dl>
    ///<dt><b>KEYEVENTF_UNICODE</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> If specified, the system
    ///synthesizes a <b>VK_PACKET</b> keystroke. The <b>wVk</b> parameter must be zero. This flag can only be combined
    ///with the <b>KEYEVENTF_KEYUP</b> flag. For more information, see the Remarks section. </td> </tr> </table>
    uint   dwFlags;
    ///Type: <b>DWORD</b> The time stamp for the event, in milliseconds. If this parameter is zero, the system will
    ///provide its own time stamp.
    uint   time;
    ///Type: <b>ULONG_PTR</b> An additional value associated with the keystroke. Use the GetMessageExtraInfo function to
    ///obtain this information.
    size_t dwExtraInfo;
}

///Contains information about a simulated message generated by an input device other than a keyboard or mouse.
struct HARDWAREINPUT
{
    ///Type: <b>DWORD</b> The message generated by the input hardware.
    uint   uMsg;
    ///Type: <b>WORD</b> The low-order word of the <i>lParam </i> parameter for <b>uMsg</b>.
    ushort wParamL;
    ///Type: <b>WORD</b> The high-order word of the <i>lParam </i> parameter for <b>uMsg</b>.
    ushort wParamH;
}

///Used by SendInput to store information for synthesizing input events such as keystrokes, mouse movement, and mouse
///clicks.
struct INPUT
{
    ///Type: <b>DWORD</b> The type of the input event. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="INPUT_MOUSE"></a><a id="input_mouse"></a><dl>
    ///<dt><b>INPUT_MOUSE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The event is a mouse event. Use the <b>mi</b>
    ///structure of the union. </td> </tr> <tr> <td width="40%"><a id="INPUT_KEYBOARD"></a><a
    ///id="input_keyboard"></a><dl> <dt><b>INPUT_KEYBOARD</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The event is
    ///a keyboard event. Use the <b>ki</b> structure of the union. </td> </tr> <tr> <td width="40%"><a
    ///id="INPUT_HARDWARE"></a><a id="input_hardware"></a><dl> <dt><b>INPUT_HARDWARE</b></dt> <dt>2</dt> </dl> </td> <td
    ///width="60%"> The event is a hardware event. Use the <b>hi</b> structure of the union. </td> </tr> </table>
    uint type;
    union
    {
        MOUSEINPUT    mi;
        KEYBDINPUT    ki;
        HARDWAREINPUT hi;
    }
}

///Contains the time of the last input.
struct LASTINPUTINFO
{
    ///Type: <b>UINT</b> The size of the structure, in bytes. This member must be set to
    ///<code>sizeof(LASTINPUTINFO)</code>.
    uint cbSize;
    ///Type: <b>DWORD</b> The tick count when the last input event was received.
    uint dwTime;
}

///Contains the header information that is part of the raw input data.
struct RAWINPUTHEADER
{
    ///Type: <b>DWORD</b> The type of raw input. It can be one of the following values: | Value | Meaning |
    ///|-------------------------|---------------------------------------------------------------------| |
    ///**RIM\_TYPEMOUSE** 0 | Raw input comes from the mouse. | | **RIM\_TYPEKEYBOARD** 1 | Raw input comes from the
    ///keyboard. | | **RIM\_TYPEHID** 2 | Raw input comes from some device that is not a keyboard or a mouse. |
    uint   dwType;
    ///Type: <b>DWORD</b> The size, in bytes, of the entire input packet of data. This includes
    ///[RAWINPUT](ns-winuser-rawinput.md) plus possible extra input reports in the [RAWHID](ns-winuser-rawhid.md)
    ///variable length array.
    uint   dwSize;
    ///Type: <b>HANDLE</b> A handle to the device generating the raw input data.
    HANDLE hDevice;
    ///Type: <b>WPARAM</b> The value passed in the <i>wParam</i> parameter of the
    ///[WM_INPUT](/windows/win32/inputdev/wm-input) message.
    WPARAM wParam;
}

///Contains information about the state of the mouse.
struct RAWMOUSE
{
    ///Type: <b>USHORT</b> The mouse state. This member can be any reasonable combination of the following. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MOUSE_MOVE_RELATIVE"></a><a
    ///id="mouse_move_relative"></a><dl> <dt><b>MOUSE_MOVE_RELATIVE</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
    ///Mouse movement data is relative to the last mouse position. For further information about mouse motion, see the
    ///following Remarks section. </td> </tr> <tr> <td width="40%"><a id="MOUSE_MOVE_ABSOLUTE"></a><a
    ///id="mouse_move_absolute"></a><dl> <dt><b>MOUSE_MOVE_ABSOLUTE</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///Mouse movement data is based on absolute position. For further information about mouse motion, see the following
    ///Remarks section. </td> </tr> <tr> <td width="40%"><a id="MOUSE_VIRTUAL_DESKTOP"></a><a
    ///id="mouse_virtual_desktop"></a><dl> <dt><b>MOUSE_VIRTUAL_DESKTOP</b></dt> <dt>0x02</dt> </dl> </td> <td
    ///width="60%"> Mouse coordinates are mapped to the virtual desktop (for a multiple monitor system). For further
    ///information about mouse motion, see the following Remarks section. </td> </tr> <tr> <td width="40%"><a
    ///id="MOUSE_ATTRIBUTES_CHANGED"></a><a id="mouse_attributes_changed"></a><dl>
    ///<dt><b>MOUSE_ATTRIBUTES_CHANGED</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> Mouse attributes changed;
    ///application needs to query the mouse attributes. </td> </tr> <tr> <td width="40%"><a
    ///id="MOUSE_MOVE_NOCOALESCE"></a><a id="mouse_move_nocoalesce"></a><dl> <dt><b>MOUSE_MOVE_NOCOALESCE</b></dt>
    ///<dt>0x08</dt> </dl> </td> <td width="60%"> This mouse movement event was not coalesced. Mouse movement events can
    ///be coalescened by default.<br/> Windows XP/2000: This value is not supported. </td> </tr> </table>
    ushort usFlags;
    union
    {
        uint ulButtons;
        struct
        {
            ushort usButtonFlags;
            ushort usButtonData;
        }
    }
    ///Type: <b>ULONG</b> The raw state of the mouse buttons. The Win32 subsystem does not use this member.
    uint   ulRawButtons;
    ///Type: <b>LONG</b> The motion in the X direction. This is signed relative motion or absolute motion, depending on
    ///the value of <b>usFlags</b>.
    int    lLastX;
    ///Type: <b>LONG</b> The motion in the Y direction. This is signed relative motion or absolute motion, depending on
    ///the value of <b>usFlags</b>.
    int    lLastY;
    ///Type: <b>ULONG</b> The device-specific additional information for the event.
    uint   ulExtraInformation;
}

///Contains information about the state of the keyboard.
struct RAWKEYBOARD
{
    ///Type: <b>USHORT</b> Specifies the scan code (from Scan Code Set 1) associated with a key press. See Remarks.
    ushort MakeCode;
    ///Type: <b>USHORT</b> Flags for scan code information. It can be one or more of the following: | Value | Meaning |
    ///|----------------------|----------------------------------| | **RI\_KEY\_MAKE** 0 | The key is down. | |
    ///**RI\_KEY\_BREAK** 1 | The key is up. | | **RI\_KEY\_E0** 2 | The scan code has the E0 prefix. | |
    ///**RI\_KEY\_E1** 4 | The scan code has the E1 prefix. |
    ushort Flags;
    ///Type: <b>USHORT</b> Reserved; must be zero.
    ushort Reserved;
    ///Type: <b>USHORT</b> The corresponding [legacy virtual-key code](/windows/win32/inputdev/virtual-key-codes).
    ushort VKey;
    ///Type: <b>UINT</b> The corresponding [legacy keyboard window
    ///message](/windows/win32/inputdev/keyboard-input-notifications), for example
    ///[WM_KEYDOWN](/windows/win32/inputdev/wm-keydown), [WM_SYSKEYDOWN](/windows/win32/inputdev/wm-syskeydown), and so
    ///forth.
    uint   Message;
    ///Type: <b>ULONG</b> The device-specific additional information for the event.
    uint   ExtraInformation;
}

///Describes the format of the raw input from a Human Interface Device (HID).
struct RAWHID
{
    ///Type: <b>DWORD</b> The size, in bytes, of each HID input in <b>bRawData</b>.
    uint     dwSizeHid;
    ///Type: <b>DWORD</b> The number of HID inputs in <b>bRawData</b>.
    uint     dwCount;
    ///Type: <b>BYTE[1]</b> The raw input data, as an array of bytes.
    ubyte[1] bRawData;
}

///Contains the raw input from a device.
struct RAWINPUT
{
    ///Type: <b>RAWINPUTHEADER</b> The raw input data.
    RAWINPUTHEADER header;
    union data
    {
        RAWMOUSE    mouse;
        RAWKEYBOARD keyboard;
        RAWHID      hid;
    }
}

///Defines the raw input data coming from the specified mouse.
struct RID_DEVICE_INFO_MOUSE
{
    ///Type: <b>DWORD</b> The bitfield of the mouse device identification properties: | Value | ntddmou.h constant |
    ///Description |
    ///|:------:|----------------------------|----------------------------------------------------------------------------------------|
    ///| 0x0080 | MOUSE\_HID\_HARDWARE | [HID
    ///mouse](/windows-hardware/drivers/hid/keyboard-and-mouse-hid-client-drivers) | | 0x0100 |
    ///WHEELMOUSE\_HID\_HARDWARE | [HID wheel
    ///mouse](/windows-hardware/drivers/hid/keyboard-and-mouse-hid-client-drivers) | | 0x8000 |
    ///HORIZONTAL\_WHEEL\_PRESENT | Mouse with horizontal wheel |
    uint dwId;
    ///Type: <b>DWORD</b> The number of buttons for the mouse.
    uint dwNumberOfButtons;
    ///Type: <b>DWORD</b> The number of data points per second. This information may not be applicable for every mouse
    ///device.
    uint dwSampleRate;
    ///Type: <b>BOOL</b> <b>TRUE</b> if the mouse has a wheel for horizontal scrolling; otherwise, <b>FALSE</b>.
    ///<b>Windows XP:</b> This member is only supported starting with Windows Vista.
    BOOL fHasHorizontalWheel;
}

///Defines the raw input data coming from the specified keyboard.
struct RID_DEVICE_INFO_KEYBOARD
{
    ///Type: <b>DWORD</b> The type of the keyboard. See the Remarks section.
    uint dwType;
    ///Type: <b>DWORD</b> The subtype of the keyboard. See the Remarks section.
    uint dwSubType;
    ///Type: <b>DWORD</b> The scan code mode. See the Remarks section.
    uint dwKeyboardMode;
    ///Type: <b>DWORD</b> The number of function keys on the keyboard.
    uint dwNumberOfFunctionKeys;
    ///Type: <b>DWORD</b> The number of LED indicators on the keyboard.
    uint dwNumberOfIndicators;
    ///Type: <b>DWORD</b> The total number of keys on the keyboard.
    uint dwNumberOfKeysTotal;
}

///Defines the raw input data coming from the specified Human Interface Device (HID).
struct RID_DEVICE_INFO_HID
{
    ///Type: <b>DWORD</b> The vendor identifier for the HID.
    uint   dwVendorId;
    ///Type: <b>DWORD</b> The product identifier for the HID.
    uint   dwProductId;
    ///Type: <b>DWORD</b> The version number for the HID.
    uint   dwVersionNumber;
    ///Type: <b>USHORT</b> The top-level collection Usage Page for the device.
    ushort usUsagePage;
    ///Type: <b>USHORT</b> The top-level collection Usage for the device.
    ushort usUsage;
}

///Defines the raw input data coming from any device.
struct RID_DEVICE_INFO
{
    ///Type: <b>DWORD</b> The size, in bytes, of the <b>RID_DEVICE_INFO</b> structure.
    uint cbSize;
    ///Type: <b>DWORD</b> The type of raw input data. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RIM_TYPEMOUSE"></a><a
    ///id="rim_typemouse"></a><dl> <dt><b>RIM_TYPEMOUSE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Data comes from
    ///a mouse. </td> </tr> <tr> <td width="40%"><a id="RIM_TYPEKEYBOARD"></a><a id="rim_typekeyboard"></a><dl>
    ///<dt><b>RIM_TYPEKEYBOARD</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Data comes from a keyboard. </td> </tr>
    ///<tr> <td width="40%"><a id="RIM_TYPEHID"></a><a id="rim_typehid"></a><dl> <dt><b>RIM_TYPEHID</b></dt> <dt>2</dt>
    ///</dl> </td> <td width="60%"> Data comes from an HID that is not a keyboard or a mouse. </td> </tr> </table>
    uint dwType;
    union
    {
        RID_DEVICE_INFO_MOUSE mouse;
        RID_DEVICE_INFO_KEYBOARD keyboard;
        RID_DEVICE_INFO_HID hid;
    }
}

///Defines information for the raw input devices.
struct RAWINPUTDEVICE
{
    ///Type: <b>USHORT</b> [Top level collection](/windows-hardware/drivers/hid/top-level-collections) [Usage
    ///page](/windows-hardware/drivers/hid/hid-usages
    ushort usUsagePage;
    ///Type: <b>USHORT</b> [Top level collection](/windows-hardware/drivers/hid/top-level-collections) [Usage
    ///ID](/windows-hardware/drivers/hid/hid-usages
    ushort usUsage;
    ///Type: <b>DWORD</b> Mode flag that specifies how to interpret the information provided by <b>usUsagePage</b> and
    ///<b>usUsage</b>. It can be zero (the default) or one of the following values. By default, the operating system
    ///sends raw input from devices with the specified [top level
    ///collection](/windows-hardware/drivers/hid/top-level-collections) (TLC) to the registered application as long as
    ///it has the window focus. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RIDEV_REMOVE"></a><a id="ridev_remove"></a><dl> <dt><b>RIDEV_REMOVE</b></dt> <dt>0x00000001</dt> </dl> </td>
    ///<td width="60%"> If set, this removes the top level collection from the inclusion list. This tells the operating
    ///system to stop reading from a device which matches the top level collection. </td> </tr> <tr> <td width="40%"><a
    ///id="RIDEV_EXCLUDE"></a><a id="ridev_exclude"></a><dl> <dt><b>RIDEV_EXCLUDE</b></dt> <dt>0x00000010</dt> </dl>
    ///</td> <td width="60%"> If set, this specifies the top level collections to exclude when reading a complete usage
    ///page. This flag only affects a TLC whose usage page is already specified with <b>RIDEV_PAGEONLY</b>. </td> </tr>
    ///<tr> <td width="40%"><a id="RIDEV_PAGEONLY"></a><a id="ridev_pageonly"></a><dl> <dt><b>RIDEV_PAGEONLY</b></dt>
    ///<dt>0x00000020</dt> </dl> </td> <td width="60%"> If set, this specifies all devices whose top level collection is
    ///from the specified <b>usUsagePage</b>. Note that <b>usUsage</b> must be zero. To exclude a particular top level
    ///collection, use <b>RIDEV_EXCLUDE</b>. </td> </tr> <tr> <td width="40%"><a id="RIDEV_NOLEGACY"></a><a
    ///id="ridev_nolegacy"></a><dl> <dt><b>RIDEV_NOLEGACY</b></dt> <dt>0x00000030</dt> </dl> </td> <td width="60%"> If
    ///set, this prevents any devices specified by <b>usUsagePage</b> or <b>usUsage</b> from generating legacy messages.
    ///This is only for the mouse and keyboard. See Remarks. </td> </tr> <tr> <td width="40%"><a
    ///id="RIDEV_INPUTSINK"></a><a id="ridev_inputsink"></a><dl> <dt><b>RIDEV_INPUTSINK</b></dt> <dt>0x00000100</dt>
    ///</dl> </td> <td width="60%"> If set, this enables the caller to receive the input even when the caller is not in
    ///the foreground. Note that <b>hwndTarget</b> must be specified. </td> </tr> <tr> <td width="40%"><a
    ///id="RIDEV_CAPTUREMOUSE"></a><a id="ridev_capturemouse"></a><dl> <dt><b>RIDEV_CAPTUREMOUSE</b></dt>
    ///<dt>0x00000200</dt> </dl> </td> <td width="60%"> If set, the mouse button click does not activate the other
    ///window. <b>RIDEV_CAPTUREMOUSE</b> can be specified only if <b>RIDEV_NOLEGACY</b> is specified for a mouse device.
    ///</td> </tr> <tr> <td width="40%"><a id="RIDEV_NOHOTKEYS"></a><a id="ridev_nohotkeys"></a><dl>
    ///<dt><b>RIDEV_NOHOTKEYS</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> If set, the application-defined
    ///keyboard device hotkeys are not handled. However, the system hotkeys; for example, ALT+TAB and CTRL+ALT+DEL, are
    ///still handled. By default, all keyboard hotkeys are handled. <b>RIDEV_NOHOTKEYS</b> can be specified even if
    ///<b>RIDEV_NOLEGACY</b> is not specified and <b>hwndTarget</b> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="RIDEV_APPKEYS"></a><a id="ridev_appkeys"></a><dl> <dt><b>RIDEV_APPKEYS</b></dt> <dt>0x00000400</dt> </dl>
    ///</td> <td width="60%"> If set, the application command keys are handled. <b>RIDEV_APPKEYS</b> can be specified
    ///only if <b>RIDEV_NOLEGACY</b> is specified for a keyboard device. </td> </tr> <tr> <td width="40%"><a
    ///id="RIDEV_EXINPUTSINK"></a><a id="ridev_exinputsink"></a><dl> <dt><b>RIDEV_EXINPUTSINK</b></dt>
    ///<dt>0x00001000</dt> </dl> </td> <td width="60%"> If set, this enables the caller to receive input in the
    ///background only if the foreground application does not process it. In other words, if the foreground application
    ///is not registered for raw input, then the background application that is registered will receive the input.
    ///<br><b>Windows XP:</b> This flag is not supported until Windows Vista </td> </tr> <tr> <td width="40%"><a
    ///id="RIDEV_DEVNOTIFY"></a><a id="ridev_devnotify"></a><dl> <dt><b>RIDEV_DEVNOTIFY</b></dt> <dt>0x00002000</dt>
    ///</dl> </td> <td width="60%"> If set, this enables the caller to receive WM_INPUT_DEVICE_CHANGE notifications for
    ///device arrival and device removal. <br><b>Windows XP:</b> This flag is not supported until Windows Vista </td>
    ///</tr> </table>
    uint   dwFlags;
    ///Type: <b>HWND</b> A handle to the target window. If <b>NULL</b> it follows the keyboard focus.
    HWND   hwndTarget;
}

///Contains information about a raw input device.
struct RAWINPUTDEVICELIST
{
    ///Type: <b>HANDLE</b> A handle to the raw input device.
    HANDLE hDevice;
    ///Type: <b>DWORD</b> The type of device. This can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="RIM_TYPEHID"></a><a id="rim_typehid"></a><dl>
    ///<dt><b>RIM_TYPEHID</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The device is an HID that is not a keyboard
    ///and not a mouse. </td> </tr> <tr> <td width="40%"><a id="RIM_TYPEKEYBOARD"></a><a id="rim_typekeyboard"></a><dl>
    ///<dt><b>RIM_TYPEKEYBOARD</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The device is a keyboard. </td> </tr>
    ///<tr> <td width="40%"><a id="RIM_TYPEMOUSE"></a><a id="rim_typemouse"></a><dl> <dt><b>RIM_TYPEMOUSE</b></dt>
    ///<dt>0</dt> </dl> </td> <td width="60%"> The device is a mouse. </td> </tr> </table>
    uint   dwType;
}

// Functions

///Posts messages when the mouse pointer leaves a window or hovers over a window for a specified amount of time. This
///function calls TrackMouseEvent if it exists, otherwise it emulates it.
///Params:
///    lpEventTrack = Type: <b>LPTRACKMOUSEEVENT</b> A pointer to a TRACKMOUSEEVENT structure that contains tracking information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, return value is
///    zero.
///    
@DllImport("COMCTL32")
BOOL _TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

///Loads a new input locale identifier (formerly called the keyboard layout) into the system. <b>Prior to Windows 8:</b>
///Several input locale identifiers can be loaded at a time, but only one per process is active at a time. Loading
///multiple input locale identifiers makes it possible to rapidly switch between them. <b>Beginning in Windows 8:</b>
///The input locale identifier is loaded for the entire system. This function has no effect if the current process does
///not own the window with keyboard focus.
///Params:
///    pwszKLID = Type: <b>LPCTSTR</b> The name of the input locale identifier to load. This name is a string composed of the
///               hexadecimal value of the Language Identifier (low word) and a device identifier (high word). For example, U.S.
///               English has a language identifier of 0x0409, so the primary U.S. English layout is named "00000409". Variants of
///               U.S. English layout (such as the Dvorak layout) are named "00010409", "00020409", and so on.
///    Flags = Type: <b>UINT</b> Specifies how the input locale identifier is to be loaded. This parameter can be one or more of
///            the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="KLF_ACTIVATE"></a><a id="klf_activate"></a><dl> <dt><b>KLF_ACTIVATE</b></dt> <dt>0x00000001</dt> </dl> </td>
///            <td width="60%"> <b>Prior to Windows 8:</b> If the specified input locale identifier is not already loaded, the
///            function loads and activates the input locale identifier for the current thread. <b>Beginning in Windows 8:</b>
///            If the specified input locale identifier is not already loaded, the function loads and activates the input locale
///            identifier for the system. </td> </tr> <tr> <td width="40%"><a id="KLF_NOTELLSHELL"></a><a
///            id="klf_notellshell"></a><dl> <dt><b>KLF_NOTELLSHELL</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%">
///            <b>Prior to Windows 8:</b> Prevents a ShellProc hook procedure from receiving an <b>HSHELL_LANGUAGE</b> hook code
///            when the new input locale identifier is loaded. This value is typically used when an application loads multiple
///            input locale identifiers one after another. Applying this value to all but the last input locale identifier
///            delays the shell's processing until all input locale identifiers have been added. <b>Beginning in Windows 8:</b>
///            In this scenario, the last input locale identifier is set for the entire system. </td> </tr> <tr> <td
///            width="40%"><a id="KLF_REORDER"></a><a id="klf_reorder"></a><dl> <dt><b>KLF_REORDER</b></dt> <dt>0x00000008</dt>
///            </dl> </td> <td width="60%"> <b>Prior to Windows 8:</b> Moves the specified input locale identifier to the head
///            of the input locale identifier list, making that locale identifier the active locale identifier for the current
///            thread. This value reorders the input locale identifier list even if <b>KLF_ACTIVATE</b> is not provided.
///            <b>Beginning in Windows 8:</b> Moves the specified input locale identifier to the head of the input locale
///            identifier list, making that locale identifier the active locale identifier for the system. This value reorders
///            the input locale identifier list even if <b>KLF_ACTIVATE</b> is not provided. </td> </tr> <tr> <td width="40%"><a
///            id="KLF_REPLACELANG"></a><a id="klf_replacelang"></a><dl> <dt><b>KLF_REPLACELANG</b></dt> <dt>0x00000010</dt>
///            </dl> </td> <td width="60%"> If the new input locale identifier has the same language identifier as a current
///            input locale identifier, the new input locale identifier replaces the current one as the input locale identifier
///            for that language. If this value is not provided and the input locale identifiers have the same language
///            identifiers, the current input locale identifier is not replaced and the function returns <b>NULL</b>. </td>
///            </tr> <tr> <td width="40%"><a id="KLF_SUBSTITUTE_OK"></a><a id="klf_substitute_ok"></a><dl>
///            <dt><b>KLF_SUBSTITUTE_OK</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Substitutes the specified
///            input locale identifier with another locale preferred by the user. The system starts with this flag set, and it
///            is recommended that your application always use this flag. The substitution occurs only if the registry key
///            <b>HKEY_CURRENT_USER\Keyboard\Layout\Substitutes</b> explicitly defines a substitution locale. For example, if
///            the key includes the value name "00000409" with value "00010409", loading the U.S. English layout ("00000409")
///            causes the Dvorak U.S. English layout ("00010409") to be loaded instead. The system uses <b>KLF_SUBSTITUTE_OK</b>
///            when booting, and it is recommended that all applications use this value when loading input locale identifiers to
///            ensure that the user's preference is selected. </td> </tr> <tr> <td width="40%"><a id="KLF_SETFORPROCESS"></a><a
///            id="klf_setforprocess"></a><dl> <dt><b>KLF_SETFORPROCESS</b></dt> <dt>0x00000100</dt> </dl> </td> <td
///            width="60%"> <b>Prior to Windows 8:</b> This flag is valid only with <b>KLF_ACTIVATE</b>. Activates the specified
///            input locale identifier for the entire process and sends the WM_INPUTLANGCHANGE message to the current thread's
///            Focus or Active window. Typically, <b>LoadKeyboardLayout</b> activates an input locale identifier only for the
///            current thread. <b>Beginning in Windows 8:</b> This flag is not used. <b>LoadKeyboardLayout</b> always activates
///            an input locale identifier for the entire system if the current process owns the window with keyboard focus.
///            </td> </tr> <tr> <td width="40%"><a id="KLF_UNLOADPREVIOUS"></a><a id="klf_unloadprevious"></a><dl>
///            <dt><b>KLF_UNLOADPREVIOUS</b></dt> </dl> </td> <td width="60%"> This flag is unsupported. Use the
///            UnloadKeyboardLayout function instead. </td> </tr> </table>
///Returns:
///    Type: <b>HKL</b> If the function succeeds, the return value is the input locale identifier corresponding to the
///    name specified in <i>pwszKLID</i>. If no matching locale is available, the return value is the default language
///    of the system. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t LoadKeyboardLayoutA(const(char)* pwszKLID, uint Flags);

///Loads a new input locale identifier (formerly called the keyboard layout) into the system. <b>Prior to Windows 8:</b>
///Several input locale identifiers can be loaded at a time, but only one per process is active at a time. Loading
///multiple input locale identifiers makes it possible to rapidly switch between them. <b>Beginning in Windows 8:</b>
///The input locale identifier is loaded for the entire system. This function has no effect if the current process does
///not own the window with keyboard focus.
///Params:
///    pwszKLID = Type: <b>LPCTSTR</b> The name of the input locale identifier to load. This name is a string composed of the
///               hexadecimal value of the Language Identifier (low word) and a device identifier (high word). For example, U.S.
///               English has a language identifier of 0x0409, so the primary U.S. English layout is named "00000409". Variants of
///               U.S. English layout (such as the Dvorak layout) are named "00010409", "00020409", and so on.
///    Flags = Type: <b>UINT</b> Specifies how the input locale identifier is to be loaded. This parameter can be one of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="KLF_ACTIVATE"></a><a id="klf_activate"></a><dl> <dt><b>KLF_ACTIVATE</b></dt> <dt>0x00000001</dt> </dl> </td>
///            <td width="60%"> <b>Prior to Windows 8:</b> If the specified input locale identifier is not already loaded, the
///            function loads and activates the input locale identifier for the current thread. <b>Beginning in Windows 8:</b>
///            If the specified input locale identifier is not already loaded, the function loads and activates the input locale
///            identifier for the system. </td> </tr> <tr> <td width="40%"><a id="KLF_NOTELLSHELL"></a><a
///            id="klf_notellshell"></a><dl> <dt><b>KLF_NOTELLSHELL</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%">
///            <b>Prior to Windows 8:</b> Prevents a ShellProchook procedure from receiving an <b>HSHELL_LANGUAGE</b> hook code
///            when the new input locale identifier is loaded. This value is typically used when an application loads multiple
///            input locale identifiers one after another. Applying this value to all but the last input locale identifier
///            delays the shell's processing until all input locale identifiers have been added. <b>Beginning in Windows 8:</b>
///            In this scenario, the last input locale identifier is set for the entire system. </td> </tr> <tr> <td
///            width="40%"><a id="KLF_REORDER"></a><a id="klf_reorder"></a><dl> <dt><b>KLF_REORDER</b></dt> <dt>0x00000008</dt>
///            </dl> </td> <td width="60%"> <b>Prior to Windows 8:</b> Moves the specified input locale identifier to the head
///            of the input locale identifier list, making that locale identifier the active locale identifier for the current
///            thread. This value reorders the input locale identifier list even if <b>KLF_ACTIVATE</b> is not provided.
///            <b>Beginning in Windows 8:</b> Moves the specified input locale identifier to the head of the input locale
///            identifier list, making that locale identifier the active locale identifier for the system. This value reorders
///            the input locale identifier list even if <b>KLF_ACTIVATE</b> is not provided. </td> </tr> <tr> <td width="40%"><a
///            id="KLF_REPLACELANG"></a><a id="klf_replacelang"></a><dl> <dt><b>KLF_REPLACELANG</b></dt> <dt>0x00000010</dt>
///            </dl> </td> <td width="60%"> If the new input locale identifier has the same language identifier as a current
///            input locale identifier, the new input locale identifier replaces the current one as the input locale identifier
///            for that language. If this value is not provided and the input locale identifiers have the same language
///            identifiers, the current input locale identifier is not replaced and the function returns <b>NULL</b>. </td>
///            </tr> <tr> <td width="40%"><a id="KLF_SUBSTITUTE_OK"></a><a id="klf_substitute_ok"></a><dl>
///            <dt><b>KLF_SUBSTITUTE_OK</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Substitutes the specified
///            input locale identifier with another locale preferred by the user. The system starts with this flag set, and it
///            is recommended that your application always use this flag. The substitution occurs only if the registry key
///            <b>HKEY_CURRENT_USER\Keyboard\Layout\Substitutes</b> explicitly defines a substitution locale. For example, if
///            the key includes the value name "00000409" with value "00010409", loading the U.S. English layout ("00000409")
///            causes the Dvorak U.S. English layout ("00010409") to be loaded instead. The system uses <b>KLF_SUBSTITUTE_OK</b>
///            when booting, and it is recommended that all applications use this value when loading input locale identifiers to
///            ensure that the user's preference is selected. </td> </tr> <tr> <td width="40%"><a id="KLF_SETFORPROCESS"></a><a
///            id="klf_setforprocess"></a><dl> <dt><b>KLF_SETFORPROCESS</b></dt> <dt>0x00000100</dt> </dl> </td> <td
///            width="60%"> <b>Prior to Windows 8:</b> This flag is valid only with <b>KLF_ACTIVATE</b>. Activates the specified
///            input locale identifier for the entire process and sends the WM_INPUTLANGCHANGE message to the current thread's
///            Focus or Active window. Typically, <b>LoadKeyboardLayout</b> activates an input locale identifier only for the
///            current thread. <b>Beginning in Windows 8:</b> This flag is not used. <b>LoadKeyboardLayout</b> always activates
///            an input locale identifier for the entire system if the current process owns the window with keyboard focus.
///            </td> </tr> <tr> <td width="40%"><a id="KLF_UNLOADPREVIOUS"></a><a id="klf_unloadprevious"></a><dl>
///            <dt><b>KLF_UNLOADPREVIOUS</b></dt> </dl> </td> <td width="60%"> This flag is unsupported. Use the
///            UnloadKeyboardLayout function instead. </td> </tr> </table>
///Returns:
///    Type: <b>HKL</b> If the function succeeds, the return value is the input locale identifier corresponding to the
///    name specified in <i>pwszKLID</i>. If no matching locale is available, the return value is the default language
///    of the system. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
ptrdiff_t LoadKeyboardLayoutW(const(wchar)* pwszKLID, uint Flags);

///Sets the input locale identifier (formerly called the keyboard layout handle) for the calling thread or the current
///process. The input locale identifier specifies a locale as well as the physical layout of the keyboard.
///Params:
///    hkl = Type: <b>HKL</b> Input locale identifier to be activated. The input locale identifier must have been loaded by a
///          previous call to the LoadKeyboardLayout function. This parameter must be either the handle to a keyboard layout
///          or one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///          id="HKL_NEXT"></a><a id="hkl_next"></a><dl> <dt><b>HKL_NEXT</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
///          Selects the next locale identifier in the circular list of loaded locale identifiers maintained by the system.
///          </td> </tr> <tr> <td width="40%"><a id="HKL_PREV"></a><a id="hkl_prev"></a><dl> <dt><b>HKL_PREV</b></dt>
///          <dt>0</dt> </dl> </td> <td width="60%"> Selects the previous locale identifier in the circular list of loaded
///          locale identifiers maintained by the system. </td> </tr> </table>
///    Flags = Type: <b>UINT</b> Specifies how the input locale identifier is to be activated. This parameter can be one of the
///            following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="KLF_REORDER"></a><a id="klf_reorder"></a><dl> <dt><b>KLF_REORDER</b></dt> <dt>0x00000008</dt> </dl> </td> <td
///            width="60%"> If this bit is set, the system's circular list of loaded locale identifiers is reordered by moving
///            the locale identifier to the head of the list. If this bit is not set, the list is rotated without a change of
///            order. For example, if a user had an English locale identifier active, as well as having French, German, and
///            Spanish locale identifiers loaded (in that order), then activating the German locale identifier with the
///            <b>KLF_REORDER</b> bit set would produce the following order: German, English, French, Spanish. Activating the
///            German locale identifier without the <b>KLF_REORDER</b> bit set would produce the following order: German,
///            Spanish, English, French. If less than three locale identifiers are loaded, the value of this flag is irrelevant.
///            </td> </tr> <tr> <td width="40%"><a id="KLF_RESET"></a><a id="klf_reset"></a><dl> <dt><b>KLF_RESET</b></dt>
///            <dt>0x40000000</dt> </dl> </td> <td width="60%"> If set but <b>KLF_SHIFTLOCK</b> is not set, the Caps Lock state
///            is turned off by pressing the Caps Lock key again. If set and <b>KLF_SHIFTLOCK</b> is also set, the Caps Lock
///            state is turned off by pressing either SHIFT key. These two methods are mutually exclusive, and the setting
///            persists as part of the User's profile in the registry. </td> </tr> <tr> <td width="40%"><a
///            id="KLF_SETFORPROCESS"></a><a id="klf_setforprocess"></a><dl> <dt><b>KLF_SETFORPROCESS</b></dt>
///            <dt>0x00000100</dt> </dl> </td> <td width="60%"> Activates the specified locale identifier for the entire process
///            and sends the WM_INPUTLANGCHANGE message to the current thread's focus or active window. </td> </tr> <tr> <td
///            width="40%"><a id="KLF_SHIFTLOCK"></a><a id="klf_shiftlock"></a><dl> <dt><b>KLF_SHIFTLOCK</b></dt>
///            <dt>0x00010000</dt> </dl> </td> <td width="60%"> This is used with <b>KLF_RESET</b>. See <b>KLF_RESET</b> for an
///            explanation. </td> </tr> <tr> <td width="40%"><a id="KLF_UNLOADPREVIOUS"></a><a id="klf_unloadprevious"></a><dl>
///            <dt><b>KLF_UNLOADPREVIOUS</b></dt> </dl> </td> <td width="60%"> This flag is unsupported. Use the
///            UnloadKeyboardLayout function instead. </td> </tr> </table>
///Returns:
///    Type: <b>HKL</b> The return value is of type <b>HKL</b>. If the function succeeds, the return value is the
///    previous input locale identifier. Otherwise, it is zero. To get extended error information, use the GetLastError
///    function.
///    
@DllImport("USER32")
ptrdiff_t ActivateKeyboardLayout(ptrdiff_t hkl, uint Flags);

///Translates the specified virtual-key code and keyboard state to the corresponding Unicode character or characters.
///Params:
///    wVirtKey = Type: <b>UINT</b> The virtual-key code to be translated. See Virtual-Key Codes.
///    wScanCode = Type: <b>UINT</b> The hardware scan code of the key to be translated. The high-order bit of this value is set if
///                the key is up.
///    lpKeyState = Type: <b>const BYTE*</b> A pointer to a 256-byte array that contains the current keyboard state. Each element
///                 (byte) in the array contains the state of one key. If the high-order bit of a byte is set, the key is down.
///    pwszBuff = Type: <b>LPWSTR</b> The buffer that receives the translated Unicode character or characters. However, this buffer
///               may be returned without being null-terminated even though the variable name suggests that it is null-terminated.
///    cchBuff = Type: <b>int</b> The size, in characters, of the buffer pointed to by the <i>pwszBuff</i> parameter.
///    wFlags = Type: <b>UINT</b> The behavior of the function. If bit 0 is set, a menu is active. If bit 2 is set, keyboard
///             state is not changed (Windows 10, version 1607 and newer) All other bits (through 31) are reserved.
///    dwhkl = Type: <b>HKL</b> The input locale identifier used to translate the specified code. This parameter can be any
///            input locale identifier previously returned by the LoadKeyboardLayout function.
///Returns:
///    Type: <b>int</b> The function returns one of the following values. <table> <tr> <th>Return value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> The specified
///    virtual key is a dead-key character (accent or diacritic). This value is returned regardless of the keyboard
///    layout, even if several characters have been typed and are stored in the keyboard state. If possible, even with
///    Unicode keyboard layouts, the function has written a spacing version of the dead-key character to the buffer
///    specified by <i>pwszBuff</i>. For example, the function writes the character SPACING ACUTE (0x00B4), rather than
///    the character NON_SPACING ACUTE (0x0301). </td> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td
///    width="60%"> The specified virtual key has no translation for the current state of the keyboard. Nothing was
///    written to the buffer specified by <i>pwszBuff</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td>
///    <td width="60%"> One character was written to the buffer specified by <i>pwszBuff</i>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt>2 ≤ <i>value</i> </dt> </dl> </td> <td width="60%"> Two or more characters were written
///    to the buffer specified by <i>pwszBuff</i>. The most common cause for this is that a dead-key character (accent
///    or diacritic) stored in the keyboard layout could not be combined with the specified virtual key to form a single
///    character. However, the buffer may contain more characters than the return value specifies. When this happens,
///    any extra characters are invalid and should be ignored. </td> </tr> </table>
///    
@DllImport("USER32")
int ToUnicodeEx(uint wVirtKey, uint wScanCode, char* lpKeyState, const(wchar)* pwszBuff, int cchBuff, uint wFlags, 
                ptrdiff_t dwhkl);

///Unloads an input locale identifier (formerly called a keyboard layout).
///Params:
///    hkl = Type: <b>HKL</b> The input locale identifier to be unloaded.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The function can fail for the following reasons: <ul> <li>An invalid input locale identifier was
///    passed.</li> <li>The input locale identifier was preloaded.</li> <li>The input locale identifier is in use.</li>
///    </ul> To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL UnloadKeyboardLayout(ptrdiff_t hkl);

///Retrieves the name of the active input locale identifier (formerly called the keyboard layout) for the system.
///Params:
///    pwszKLID = Type: <b>LPTSTR</b> The buffer (of at least <b>KL_NAMELENGTH</b> characters in length) that receives the name of
///               the input locale identifier, including the terminating null character. This will be a copy of the string provided
///               to the LoadKeyboardLayout function, unless layout substitution took place.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetKeyboardLayoutNameA(const(char)* pwszKLID);

///Retrieves the name of the active input locale identifier (formerly called the keyboard layout) for the system.
///Params:
///    pwszKLID = Type: <b>LPTSTR</b> The buffer (of at least <b>KL_NAMELENGTH</b> characters in length) that receives the name of
///               the input locale identifier, including the terminating null character. This will be a copy of the string provided
///               to the LoadKeyboardLayout function, unless layout substitution took place.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetKeyboardLayoutNameW(const(wchar)* pwszKLID);

///Retrieves the input locale identifiers (formerly called keyboard layout handles) corresponding to the current set of
///input locales in the system. The function copies the identifiers to the specified buffer.
///Params:
///    nBuff = Type: <b>int</b> The maximum number of handles that the buffer can hold.
///    lpList = Type: <b>HKL*</b> A pointer to the buffer that receives the array of input locale identifiers.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of input locale identifiers copied to
///    the buffer or, if <i>nBuff</i> is zero, the return value is the size, in array elements, of the buffer needed to
///    receive all current input locale identifiers. If the function fails, the return value is zero. To get extended
///    error information, call GetLastError.
///    
@DllImport("USER32")
int GetKeyboardLayoutList(int nBuff, char* lpList);

///Retrieves the active input locale identifier (formerly called the keyboard layout).
///Params:
///    idThread = Type: <b>DWORD</b> The identifier of the thread to query, or 0 for the current thread.
///Returns:
///    Type: <b>HKL</b> The return value is the input locale identifier for the thread. The low word contains a Language
///    Identifier for the input language and the high word contains a device handle to the physical layout of the
///    keyboard.
///    
@DllImport("USER32")
ptrdiff_t GetKeyboardLayout(uint idThread);

///Retrieves a history of up to 64 previous coordinates of the mouse or pen.
///Params:
///    cbSize = Type: <b>UINT</b> The size, in bytes, of the MOUSEMOVEPOINT structure.
///    lppt = Type: <b>LPMOUSEMOVEPOINT</b> A pointer to a MOUSEMOVEPOINT structure containing valid mouse coordinates (in
///           screen coordinates). It may also contain a time stamp. The <b>GetMouseMovePointsEx</b> function searches for the
///           point in the mouse coordinates history. If the function finds the point, it returns the last <i>nBufPoints</i>
///           prior to and including the supplied point. If your application supplies a time stamp, the
///           <b>GetMouseMovePointsEx</b> function will use it to differentiate between two equal points that were recorded at
///           different times. An application should call this function using the mouse coordinates received from the
///           WM_MOUSEMOVE message and convert them to screen coordinates.
///    lpptBuf = Type: <b>LPMOUSEMOVEPOINT</b> A pointer to a buffer that will receive the points. It should be at least
///              <i>cbSize</i>* <i>nBufPoints</i> in size.
///    nBufPoints = Type: <b>int</b> The number of points to be retrieved.
///    resolution = Type: <b>DWORD</b> The resolution desired. This parameter can be one of the following values. <table> <tr>
///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GMMP_USE_DISPLAY_POINTS"></a><a
///                 id="gmmp_use_display_points"></a><dl> <dt><b>GMMP_USE_DISPLAY_POINTS</b></dt> <dt>1</dt> </dl> </td> <td
///                 width="60%"> Retrieves the points using the display resolution. </td> </tr> <tr> <td width="40%"><a
///                 id="GMMP_USE_HIGH_RESOLUTION_POINTS"></a><a id="gmmp_use_high_resolution_points"></a><dl>
///                 <dt><b>GMMP_USE_HIGH_RESOLUTION_POINTS</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Retrieves high resolution
///                 points. Points can range from zero to 65,535 (0xFFFF) in both x- and y-coordinates. This is the resolution
///                 provided by absolute coordinate pointing devices such as drawing tablets. </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of points in the buffer. Otherwise, the
///    function returns –1. For extended error information, your application can call GetLastError.
///    
@DllImport("USER32")
int GetMouseMovePointsEx(uint cbSize, MOUSEMOVEPOINT* lppt, char* lpptBuf, int nBufPoints, uint resolution);

///Posts messages when the mouse pointer leaves a window or hovers over a window for a specified amount of time. <div
///class="alert"><b>Note</b> The _TrackMouseEvent function calls <b>TrackMouseEvent</b> if it exists, otherwise
///<b>_TrackMouseEvent</b> emulates <b>TrackMouseEvent</b>. </div><div> </div>
///Params:
///    lpEventTrack = Type: <b>LPTRACKMOUSEEVENT</b> A pointer to a TRACKMOUSEEVENT structure that contains tracking information.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero . If the function fails, return value is
///    zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

///Defines a system-wide hot key.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window that will receive WM_HOTKEY messages generated by the hot key. If this
///           parameter is <b>NULL</b>, <b>WM_HOTKEY</b> messages are posted to the message queue of the calling thread and
///           must be processed in the message loop.
///    id = Type: <b>int</b> The identifier of the hot key. If the <i>hWnd</i> parameter is NULL, then the hot key is
///         associated with the current thread rather than with a particular window. If a hot key already exists with the
///         same <i>hWnd</i> and <i>id</i> parameters, see Remarks for the action taken.
///    fsModifiers = Type: <b>UINT</b> The keys that must be pressed in combination with the key specified by the <i>uVirtKey</i>
///                  parameter in order to generate the WM_HOTKEY message. The <i>fsModifiers</i> parameter can be a combination of
///                  the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="MOD_ALT"></a><a id="mod_alt"></a><dl> <dt><b>MOD_ALT</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
///                  Either ALT key must be held down. </td> </tr> <tr> <td width="40%"><a id="MOD_CONTROL"></a><a
///                  id="mod_control"></a><dl> <dt><b>MOD_CONTROL</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Either CTRL
///                  key must be held down. </td> </tr> <tr> <td width="40%"><a id="MOD_NOREPEAT"></a><a id="mod_norepeat"></a><dl>
///                  <dt><b>MOD_NOREPEAT</b></dt> <dt>0x4000</dt> </dl> </td> <td width="60%"> Changes the hotkey behavior so that the
///                  keyboard auto-repeat does not yield multiple hotkey notifications. <b>Windows Vista: </b>This flag is not
///                  supported. </td> </tr> <tr> <td width="40%"><a id="MOD_SHIFT"></a><a id="mod_shift"></a><dl>
///                  <dt><b>MOD_SHIFT</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> Either SHIFT key must be held down. </td>
///                  </tr> <tr> <td width="40%"><a id="MOD_WIN"></a><a id="mod_win"></a><dl> <dt><b>MOD_WIN</b></dt> <dt>0x0008</dt>
///                  </dl> </td> <td width="60%"> Either WINDOWS key was held down. These keys are labeled with the Windows logo.
///                  Keyboard shortcuts that involve the WINDOWS key are reserved for use by the operating system. </td> </tr>
///                  </table>
///    vk = Type: <b>UINT</b> The virtual-key code of the hot key. See Virtual Key Codes.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL RegisterHotKey(HWND hWnd, int id, uint fsModifiers, uint vk);

///Frees a hot key previously registered by the calling thread.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window associated with the hot key to be freed. This parameter should be
///           <b>NULL</b> if the hot key is not associated with a window.
///    id = Type: <b>int</b> The identifier of the hot key to be freed.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL UnregisterHotKey(HWND hWnd, int id);

///Reverses or restores the meaning of the left and right mouse buttons.
///Params:
///    fSwap = Type: <b>BOOL</b> If this parameter is <b>TRUE</b>, the left button generates right-button messages and the right
///            button generates left-button messages. If this parameter is <b>FALSE</b>, the buttons are restored to their
///            original meanings.
///Returns:
///    Type: <b>BOOL</b> If the meaning of the mouse buttons was reversed previously, before the function was called,
///    the return value is nonzero. If the meaning of the mouse buttons was not reversed, the return value is zero.
///    
@DllImport("USER32")
BOOL SwapMouseButton(BOOL fSwap);

///Retrieves the current double-click time for the mouse. A double-click is a series of two clicks of the mouse button,
///the second occurring within a specified time after the first. The double-click time is the maximum number of
///milliseconds that may occur between the first and second click of a double-click. The maximum double-click time is
///5000 milliseconds.
///Returns:
///    Type: <b>UINT</b> The return value specifies the current double-click time, in milliseconds. The maximum return
///    value is 5000 milliseconds.
///    
@DllImport("USER32")
uint GetDoubleClickTime();

///Sets the double-click time for the mouse. A double-click is a series of two clicks of a mouse button, the second
///occurring within a specified time after the first. The double-click time is the maximum number of milliseconds that
///may occur between the first and second clicks of a double-click.
///Params:
///    Arg1 = Type: <b>UINT</b> The number of milliseconds that may occur between the first and second clicks of a
///           double-click. If this parameter is set to 0, the system uses the default double-click time of 500 milliseconds.
///           If this parameter value is greater than 5000 milliseconds, the system sets the value to 5000 milliseconds.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetDoubleClickTime(uint param0);

///Sets the keyboard focus to the specified window. The window must be attached to the calling thread's message queue.
///Params:
///    hWnd = Type: **HWND** A handle to the window that will receive the keyboard input. If this parameter is NULL, keystrokes
///           are ignored.
///Returns:
///    Type: **HWND** If the function succeeds, the return value is the handle to the window that previously had the
///    keyboard focus. If the *hWnd* parameter is invalid or the window is not attached to the calling thread's message
///    queue, the return value is NULL. To get extended error information, call [GetLastError
///    function](../errhandlingapi/nf-errhandlingapi-getlasterror.md). Extended error ERROR_INVALID_PARAMETER (0x57)
///    means that window is in disabled state.
///    
@DllImport("USER32")
HWND SetFocus(HWND hWnd);

///Retrieves the window handle to the active window attached to the calling thread's message queue.
///Returns:
///    Type: <b>HWND</b> The return value is the handle to the active window attached to the calling thread's message
///    queue. Otherwise, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND GetActiveWindow();

///Retrieves the handle to the window that has the keyboard focus, if the window is attached to the calling thread's
///message queue.
///Returns:
///    Type: <b>HWND</b> The return value is the handle to the window with the keyboard focus. If the calling thread's
///    message queue does not have an associated window with the keyboard focus, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND GetFocus();

///Retrieves the current code page. <div class="alert"><b>Note</b> This function is provided only for compatibility with
///16-bit versions of Windows. Applications should use the GetOEMCP function to retrieve the OEM code-page identifier
///for the system.</div><div> </div>
///Returns:
///    Type: <b>UINT</b> The return value is an OEM code-page identifier, or it is the default identifier if the
///    registry value is not readable. For a list of OEM code-page identifiers, see Code Page Identifiers.
///    
@DllImport("USER32")
uint GetKBCodePage();

///Retrieves the status of the specified virtual key. The status specifies whether the key is up, down, or toggled (on,
///off—alternating each time the key is pressed).
///Params:
///    nVirtKey = Type: <b>int</b> A virtual key. If the desired virtual key is a letter or digit (A through Z, a through z, or 0
///               through 9), <i>nVirtKey</i> must be set to the ASCII value of that character. For other keys, it must be a
///               virtual-key code. If a non-English keyboard layout is used, virtual keys with values in the range ASCII A through
///               Z and 0 through 9 are used to specify most of the character keys. For example, for the German keyboard layout,
///               the virtual key of value ASCII O (0x4F) refers to the "o" key, whereas VK_OEM_1 refers to the "o with umlaut"
///               key.
///Returns:
///    Type: <b>SHORT</b> The return value specifies the status of the specified virtual key, as follows: <ul> <li>If
///    the high-order bit is 1, the key is down; otherwise, it is up.</li> <li>If the low-order bit is 1, the key is
///    toggled. A key, such as the CAPS LOCK key, is toggled if it is turned on. The key is off and untoggled if the
///    low-order bit is 0. A toggle key's indicator light (if any) on the keyboard will be on when the key is toggled,
///    and off when the key is untoggled.</li> </ul>
///    
@DllImport("USER32")
short GetKeyState(int nVirtKey);

///Determines whether a key is up or down at the time the function is called, and whether the key was pressed after a
///previous call to <b>GetAsyncKeyState</b>.
///Params:
///    vKey = Type: <b>int</b> The virtual-key code. For more information, see Virtual Key Codes. You can use left- and
///           right-distinguishing constants to specify certain keys. See the Remarks section for further information.
///Returns:
///    Type: <b>SHORT</b> If the function succeeds, the return value specifies whether the key was pressed since the
///    last call to <b>GetAsyncKeyState</b>, and whether the key is currently up or down. If the most significant bit is
///    set, the key is down, and if the least significant bit is set, the key was pressed after the previous call to
///    <b>GetAsyncKeyState</b>. However, you should not rely on this last behavior; for more information, see the
///    Remarks. The return value is zero for the following cases: <ul> <li>The current desktop is not the active
///    desktop</li> <li>The foreground thread belongs to another process and the desktop does not allow the hook or the
///    journal record.</li> </ul>
///    
@DllImport("USER32")
short GetAsyncKeyState(int vKey);

///Copies the status of the 256 virtual keys to the specified buffer.
///Params:
///    lpKeyState = Type: <b>PBYTE</b> The 256-byte array that receives the status data for each virtual key.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetKeyboardState(char* lpKeyState);

///Copies an array of keyboard key states into the calling thread's keyboard input-state table. This is the same table
///accessed by the GetKeyboardState and GetKeyState functions. Changes made to this table do not affect keyboard input
///to any other thread.
///Params:
///    lpKeyState = Type: <b>LPBYTE</b> A pointer to a 256-byte array that contains keyboard key states.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SetKeyboardState(char* lpKeyState);

///Retrieves a string that represents the name of a key.
///Params:
///    lParam = Type: <b>LONG</b> The second parameter of the keyboard message (such as WM_KEYDOWN) to be processed. The function
///             interprets the following bit positions in the <i>lParam</i>. <table> <tr> <th>Bits</th> <th>Meaning</th> </tr>
///             <tr> <td> 16-23 </td> <td> Scan code. </td> </tr> <tr> <td> 24 </td> <td> Extended-key flag. Distinguishes some
///             keys on an enhanced keyboard. </td> </tr> <tr> <td> 25 </td> <td> "Do not care" bit. The application calling this
///             function sets this bit to indicate that the function should not distinguish between left and right CTRL and SHIFT
///             keys, for example. </td> </tr> </table>
///    lpString = Type: <b>LPTSTR</b> The buffer that will receive the key name.
///    cchSize = Type: <b>int</b> The maximum length, in characters, of the key name, including the terminating null character.
///              (This parameter should be equal to the size of the buffer pointed to by the <i>lpString</i> parameter.)
///Returns:
///    Type: <b>int</b> If the function succeeds, a null-terminated string is copied into the specified buffer, and the
///    return value is the length of the string, in characters, not counting the terminating null character. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetKeyNameTextA(int lParam, const(char)* lpString, int cchSize);

///Retrieves a string that represents the name of a key.
///Params:
///    lParam = Type: <b>LONG</b> The second parameter of the keyboard message (such as WM_KEYDOWN) to be processed. The function
///             interprets the following bit positions in the <i>lParam</i>. <table> <tr> <th>Bits</th> <th>Meaning</th> </tr>
///             <tr> <td> 16-23 </td> <td> Scan code. </td> </tr> <tr> <td> 24 </td> <td> Extended-key flag. Distinguishes some
///             keys on an enhanced keyboard. </td> </tr> <tr> <td> 25 </td> <td> "Do not care" bit. The application calling this
///             function sets this bit to indicate that the function should not distinguish between left and right CTRL and SHIFT
///             keys, for example. </td> </tr> </table>
///    lpString = Type: <b>LPTSTR</b> The buffer that will receive the key name.
///    cchSize = Type: <b>int</b> The maximum length, in characters, of the key name, including the terminating null character.
///              (This parameter should be equal to the size of the buffer pointed to by the <i>lpString</i> parameter.)
///Returns:
///    Type: <b>int</b> If the function succeeds, a null-terminated string is copied into the specified buffer, and the
///    return value is the length of the string, in characters, not counting the terminating null character. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetKeyNameTextW(int lParam, const(wchar)* lpString, int cchSize);

///Retrieves information about the current keyboard.
///Params:
///    nTypeFlag = Type: <b>int</b> The type of keyboard information to be retrieved. This parameter can be one of the following
///                values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td
///                width="60%"> Keyboard type </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%">
///                Keyboard subtype </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> The number of
///                function keys on the keyboard </td> </tr> </table>
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value specifies the requested information. If the function
///    fails and <i>nTypeFlag</i> is not one, the return value is zero; zero is a valid return value when
///    <i>nTypeFlag</i> is one (keyboard subtype). To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetKeyboardType(int nTypeFlag);

///Translates the specified virtual-key code and keyboard state to the corresponding character or characters. The
///function translates the code using the input language and physical keyboard layout identified by the keyboard layout
///handle. To specify a handle to the keyboard layout to use to translate the specified code, use the ToAsciiEx
///function.
///Params:
///    uVirtKey = Type: <b>UINT</b> The virtual-key code to be translated. See Virtual-Key Codes.
///    uScanCode = Type: <b>UINT</b> The hardware scan code of the key to be translated. The high-order bit of this value is set if
///                the key is up (not pressed).
///    lpKeyState = Type: <b>const BYTE*</b> A pointer to a 256-byte array that contains the current keyboard state. Each element
///                 (byte) in the array contains the state of one key. If the high-order bit of a byte is set, the key is down
///                 (pressed). The low bit, if set, indicates that the key is toggled on. In this function, only the toggle bit of
///                 the CAPS LOCK key is relevant. The toggle state of the NUM LOCK and SCROLL LOCK keys is ignored.
///    lpChar = Type: <b>LPWORD</b> The buffer that receives the translated character or characters.
///    uFlags = Type: <b>UINT</b> This parameter must be 1 if a menu is active, or 0 otherwise.
///Returns:
///    Type: <b>int</b> If the specified key is a dead key, the return value is negative. Otherwise, it is one of the
///    following values. <table> <tr> <th>Return value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt>0</dt> </dl> </td> <td width="60%"> The specified virtual key has no translation for the current state of the
///    keyboard. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> One character was copied
///    to the buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Two characters were
///    copied to the buffer. This usually happens when a dead-key character (accent or diacritic) stored in the keyboard
///    layout cannot be composed with the specified virtual key to form a single character. </td> </tr> </table>
///    
@DllImport("USER32")
int ToAscii(uint uVirtKey, uint uScanCode, char* lpKeyState, ushort* lpChar, uint uFlags);

///Translates the specified virtual-key code and keyboard state to the corresponding character or characters. The
///function translates the code using the input language and physical keyboard layout identified by the input locale
///identifier.
///Params:
///    uVirtKey = Type: <b>UINT</b> The virtual-key code to be translated. See Virtual-Key Codes.
///    uScanCode = Type: <b>UINT</b> The hardware scan code of the key to be translated. The high-order bit of this value is set if
///                the key is up (not pressed).
///    lpKeyState = Type: <b>const BYTE*</b> A pointer to a 256-byte array that contains the current keyboard state. Each element
///                 (byte) in the array contains the state of one key. If the high-order bit of a byte is set, the key is down
///                 (pressed). The low bit, if set, indicates that the key is toggled on. In this function, only the toggle bit of
///                 the CAPS LOCK key is relevant. The toggle state of the NUM LOCK and SCOLL LOCK keys is ignored.
///    lpChar = Type: <b>LPWORD</b> A pointer to the buffer that receives the translated character or characters.
///    uFlags = Type: <b>UINT</b> This parameter must be 1 if a menu is active, zero otherwise.
///    dwhkl = Type: <b>HKL</b> Input locale identifier to use to translate the code. This parameter can be any input locale
///            identifier previously returned by the LoadKeyboardLayout function.
///Returns:
///    Type: <b>int</b> If the specified key is a dead key, the return value is negative. Otherwise, it is one of the
///    following values. <table> <tr> <th>Return value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt>0</dt> </dl> </td> <td width="60%"> The specified virtual key has no translation for the current state of the
///    keyboard. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> One character was copied
///    to the buffer. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Two characters were
///    copied to the buffer. This usually happens when a dead-key character (accent or diacritic) stored in the keyboard
///    layout cannot be composed with the specified virtual key to form a single character. </td> </tr> </table>
///    
@DllImport("USER32")
int ToAsciiEx(uint uVirtKey, uint uScanCode, char* lpKeyState, ushort* lpChar, uint uFlags, ptrdiff_t dwhkl);

///Translates the specified virtual-key code and keyboard state to the corresponding Unicode character or characters. To
///specify a handle to the keyboard layout to use to translate the specified code, use the ToUnicodeEx function.
///Params:
///    wVirtKey = Type: <b>UINT</b> The virtual-key code to be translated. See Virtual-Key Codes.
///    wScanCode = Type: <b>UINT</b> The hardware scan code of the key to be translated. The high-order bit of this value is set if
///                the key is up.
///    lpKeyState = Type: <b>const BYTE*</b> A pointer to a 256-byte array that contains the current keyboard state. Each element
///                 (byte) in the array contains the state of one key. If the high-order bit of a byte is set, the key is down.
///    pwszBuff = Type: <b>LPWSTR</b> The buffer that receives the translated Unicode character or characters. However, this buffer
///               may be returned without being null-terminated even though the variable name suggests that it is null-terminated.
///    cchBuff = Type: <b>int</b> The size, in characters, of the buffer pointed to by the <i>pwszBuff</i> parameter.
///    wFlags = Type: <b>UINT</b> The behavior of the function. If bit 0 is set, a menu is active. If bit 2 is set, keyboard
///             state is not changed (Windows 10, version 1607 and newer) All other bits (through 31) are reserved.
///Returns:
///    Type: <b>int</b> The function returns one of the following values. <table> <tr> <th>Return value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> The specified
///    virtual key is a dead-key character (accent or diacritic). This value is returned regardless of the keyboard
///    layout, even if several characters have been typed and are stored in the keyboard state. If possible, even with
///    Unicode keyboard layouts, the function has written a spacing version of the dead-key character to the buffer
///    specified by <i>pwszBuff</i>. For example, the function writes the character SPACING ACUTE (0x00B4), rather than
///    the character NON_SPACING ACUTE (0x0301). </td> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td
///    width="60%"> The specified virtual key has no translation for the current state of the keyboard. Nothing was
///    written to the buffer specified by <i>pwszBuff</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td>
///    <td width="60%"> One character was written to the buffer specified by <i>pwszBuff</i>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt>2 ≤ <i>value</i> </dt> </dl> </td> <td width="60%"> Two or more characters were written
///    to the buffer specified by <i>pwszBuff</i>. The most common cause for this is that a dead-key character (accent
///    or diacritic) stored in the keyboard layout could not be combined with the specified virtual key to form a single
///    character. However, the buffer may contain more characters than the return value specifies. When this happens,
///    any extra characters are invalid and should be ignored. </td> </tr> </table>
///    
@DllImport("USER32")
int ToUnicode(uint wVirtKey, uint wScanCode, char* lpKeyState, const(wchar)* pwszBuff, int cchBuff, uint wFlags);

///Maps OEMASCII codes 0 through 0x0FF into the OEM scan codes and shift states. The function provides information that
///allows a program to send OEM text to another program by simulating keyboard input.
///Params:
///    wOemChar = Type: <b>WORD</b> The ASCII value of the OEM character.
///Returns:
///    Type: <b>DWORD</b> The low-order word of the return value contains the scan code of the OEM character, and the
///    high-order word contains the shift state, which can be a combination of the following bits. <table> <tr>
///    <th>Bit</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Either
///    SHIFT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Either CTRL
///    key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Either ALT key is
///    pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>8</dt> </dl> </td> <td width="60%"> The Hankaku key is
///    pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>16</dt> </dl> </td> <td width="60%"> Reserved (defined by the
///    keyboard layout driver). </td> </tr> <tr> <td width="40%"> <dl> <dt>32</dt> </dl> </td> <td width="60%"> Reserved
///    (defined by the keyboard layout driver). </td> </tr> </table> If the character cannot be produced by a single
///    keystroke using the current keyboard layout, the return value is –1.
///    
@DllImport("USER32")
uint OemKeyScan(ushort wOemChar);

///<p class="CCE_Message">[This function has been superseded by the VkKeyScanEx function. You can still use
///<b>VkKeyScan</b>, however, if you do not need to specify a keyboard layout.] Translates a character to the
///corresponding virtual-key code and shift state for the current keyboard.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be translated into a virtual-key code.
///Returns:
///    Type: <b>SHORT</b> If the function succeeds, the low-order byte of the return value contains the virtual-key code
///    and the high-order byte contains the shift state, which can be a combination of the following flag bits. <table>
///    <tr> <th>Return value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///    width="60%"> Either SHIFT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td
///    width="60%"> Either CTRL key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td
///    width="60%"> Either ALT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>8</dt> </dl> </td> <td
///    width="60%"> The Hankaku key is pressed </td> </tr> <tr> <td width="40%"> <dl> <dt>16</dt> </dl> </td> <td
///    width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> <tr> <td width="40%"> <dl> <dt>32</dt>
///    </dl> </td> <td width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> </table> If the
///    function finds no key that translates to the passed character code, both the low-order and high-order bytes
///    contain –1.
///    
@DllImport("USER32")
short VkKeyScanA(byte ch);

///<p class="CCE_Message">[This function has been superseded by the VkKeyScanEx function. You can still use
///<b>VkKeyScan</b>, however, if you do not need to specify a keyboard layout.] Translates a character to the
///corresponding virtual-key code and shift state for the current keyboard.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be translated into a virtual-key code.
///Returns:
///    Type: <b>SHORT</b> If the function succeeds, the low-order byte of the return value contains the virtual-key code
///    and the high-order byte contains the shift state, which can be a combination of the following flag bits. <table>
///    <tr> <th>Return value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///    width="60%"> Either SHIFT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td
///    width="60%"> Either CTRL key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td
///    width="60%"> Either ALT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>8</dt> </dl> </td> <td
///    width="60%"> The Hankaku key is pressed </td> </tr> <tr> <td width="40%"> <dl> <dt>16</dt> </dl> </td> <td
///    width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> <tr> <td width="40%"> <dl> <dt>32</dt>
///    </dl> </td> <td width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> </table> If the
///    function finds no key that translates to the passed character code, both the low-order and high-order bytes
///    contain –1.
///    
@DllImport("USER32")
short VkKeyScanW(ushort ch);

///Translates a character to the corresponding virtual-key code and shift state. The function translates the character
///using the input language and physical keyboard layout identified by the input locale identifier.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be translated into a virtual-key code.
///    dwhkl = Type: <b>HKL</b> Input locale identifier used to translate the character. This parameter can be any input locale
///            identifier previously returned by the LoadKeyboardLayout function.
///Returns:
///    Type: <b>SHORT</b> If the function succeeds, the low-order byte of the return value contains the virtual-key code
///    and the high-order byte contains the shift state, which can be a combination of the following flag bits. <table>
///    <tr> <th>Return value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///    width="60%"> Either SHIFT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td
///    width="60%"> Either CTRL key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td
///    width="60%"> Either ALT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>8</dt> </dl> </td> <td
///    width="60%"> The Hankaku key is pressed </td> </tr> <tr> <td width="40%"> <dl> <dt>16</dt> </dl> </td> <td
///    width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> <tr> <td width="40%"> <dl> <dt>32</dt>
///    </dl> </td> <td width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> </table> If the
///    function finds no key that translates to the passed character code, both the low-order and high-order bytes
///    contain –1.
///    
@DllImport("USER32")
short VkKeyScanExA(byte ch, ptrdiff_t dwhkl);

///Translates a character to the corresponding virtual-key code and shift state. The function translates the character
///using the input language and physical keyboard layout identified by the input locale identifier.
///Params:
///    ch = Type: <b>TCHAR</b> The character to be translated into a virtual-key code.
///    dwhkl = Type: <b>HKL</b> Input locale identifier used to translate the character. This parameter can be any input locale
///            identifier previously returned by the LoadKeyboardLayout function.
///Returns:
///    Type: <b>SHORT</b> If the function succeeds, the low-order byte of the return value contains the virtual-key code
///    and the high-order byte contains the shift state, which can be a combination of the following flag bits. <table>
///    <tr> <th>Return value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///    width="60%"> Either SHIFT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td
///    width="60%"> Either CTRL key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td
///    width="60%"> Either ALT key is pressed. </td> </tr> <tr> <td width="40%"> <dl> <dt>8</dt> </dl> </td> <td
///    width="60%"> The Hankaku key is pressed </td> </tr> <tr> <td width="40%"> <dl> <dt>16</dt> </dl> </td> <td
///    width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> <tr> <td width="40%"> <dl> <dt>32</dt>
///    </dl> </td> <td width="60%"> Reserved (defined by the keyboard layout driver). </td> </tr> </table> If the
///    function finds no key that translates to the passed character code, both the low-order and high-order bytes
///    contain –1.
///    
@DllImport("USER32")
short VkKeyScanExW(ushort ch, ptrdiff_t dwhkl);

///Synthesizes a keystroke. The system can use such a synthesized keystroke to generate a WM_KEYUP or WM_KEYDOWN
///message. The keyboard driver's interrupt handler calls the <b>keybd_event</b> function. <div
///class="alert"><b>Note</b> This function has been superseded. Use SendInput instead.</div><div> </div>
///Params:
///    bVk = Type: <b>BYTE</b> A virtual-key code. The code must be a value in the range 1 to 254. For a complete list, see
///          Virtual Key Codes.
///    bScan = Type: <b>BYTE</b> A hardware scan code for the key.
///    dwFlags = Type: <b>DWORD</b> Controls various aspects of function operation. This parameter can be one or more of the
///              following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="KEYEVENTF_EXTENDEDKEY"></a><a id="keyeventf_extendedkey"></a><dl> <dt><b>KEYEVENTF_EXTENDEDKEY</b></dt>
///              <dt>0x0001</dt> </dl> </td> <td width="60%"> If specified, the scan code was preceded by a prefix byte having the
///              value 0xE0 (224). </td> </tr> <tr> <td width="40%"><a id="KEYEVENTF_KEYUP"></a><a id="keyeventf_keyup"></a><dl>
///              <dt><b>KEYEVENTF_KEYUP</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> If specified, the key is being
///              released. If not specified, the key is being depressed. </td> </tr> </table>
///    dwExtraInfo = Type: <b>ULONG_PTR</b> An additional value associated with the key stroke.
@DllImport("USER32")
void keybd_event(ubyte bVk, ubyte bScan, uint dwFlags, size_t dwExtraInfo);

///The <b>mouse_event</b> function synthesizes mouse motion and button clicks. <div class="alert"><b>Note</b> This
///function has been superseded. Use SendInput instead.</div><div> </div>
///Params:
///    dwFlags = Type: <b>DWORD</b> Controls various aspects of mouse motion and button clicking. This parameter can be certain
///              combinations of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MOUSEEVENTF_ABSOLUTE"></a><a id="mouseeventf_absolute"></a><dl> <dt><b>MOUSEEVENTF_ABSOLUTE</b></dt>
///              <dt>0x8000</dt> </dl> </td> <td width="60%"> The <i>dx</i> and <i>dy</i> parameters contain normalized absolute
///              coordinates. If not set, those parameters contain relative data: the change in position since the last reported
///              position. This flag can be set, or not set, regardless of what kind of mouse or mouse-like device, if any, is
///              connected to the system. For further information about relative mouse motion, see the following Remarks section.
///              </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_LEFTDOWN"></a><a id="mouseeventf_leftdown"></a><dl>
///              <dt><b>MOUSEEVENTF_LEFTDOWN</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> The left button is down. </td>
///              </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_LEFTUP"></a><a id="mouseeventf_leftup"></a><dl>
///              <dt><b>MOUSEEVENTF_LEFTUP</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> The left button is up. </td>
///              </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_MIDDLEDOWN"></a><a id="mouseeventf_middledown"></a><dl>
///              <dt><b>MOUSEEVENTF_MIDDLEDOWN</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> The middle button is down.
///              </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_MIDDLEUP"></a><a id="mouseeventf_middleup"></a><dl>
///              <dt><b>MOUSEEVENTF_MIDDLEUP</b></dt> <dt>0x0040</dt> </dl> </td> <td width="60%"> The middle button is up. </td>
///              </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_MOVE"></a><a id="mouseeventf_move"></a><dl>
///              <dt><b>MOUSEEVENTF_MOVE</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Movement occurred. </td> </tr> <tr>
///              <td width="40%"><a id="MOUSEEVENTF_RIGHTDOWN"></a><a id="mouseeventf_rightdown"></a><dl>
///              <dt><b>MOUSEEVENTF_RIGHTDOWN</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> The right button is down.
///              </td> </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_RIGHTUP"></a><a id="mouseeventf_rightup"></a><dl>
///              <dt><b>MOUSEEVENTF_RIGHTUP</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> The right button is up. </td>
///              </tr> <tr> <td width="40%"><a id="MOUSEEVENTF_WHEEL"></a><a id="mouseeventf_wheel"></a><dl>
///              <dt><b>MOUSEEVENTF_WHEEL</b></dt> <dt>0x0800</dt> </dl> </td> <td width="60%"> The wheel has been moved, if the
///              mouse has a wheel. The amount of movement is specified in <i>dwData</i> </td> </tr> <tr> <td width="40%"><a
///              id="MOUSEEVENTF_XDOWN"></a><a id="mouseeventf_xdown"></a><dl> <dt><b>MOUSEEVENTF_XDOWN</b></dt> <dt>0x0080</dt>
///              </dl> </td> <td width="60%"> An X button was pressed. </td> </tr> <tr> <td width="40%"><a
///              id="MOUSEEVENTF_XUP"></a><a id="mouseeventf_xup"></a><dl> <dt><b>MOUSEEVENTF_XUP</b></dt> <dt>0x0100</dt> </dl>
///              </td> <td width="60%"> An X button was released. </td> </tr> <tr> <td width="40%"><a
///              id="MOUSEEVENTF_WHEEL"></a><a id="mouseeventf_wheel"></a><dl> <dt><b>MOUSEEVENTF_WHEEL</b></dt> <dt>0x0800</dt>
///              </dl> </td> <td width="60%"> The wheel button is rotated. </td> </tr> <tr> <td width="40%"><a
///              id="MOUSEEVENTF_HWHEEL"></a><a id="mouseeventf_hwheel"></a><dl> <dt><b>MOUSEEVENTF_HWHEEL</b></dt>
///              <dt>0x01000</dt> </dl> </td> <td width="60%"> The wheel button is tilted. </td> </tr> </table> The values that
///              specify mouse button status are set to indicate changes in status, not ongoing conditions. For example, if the
///              left mouse button is pressed and held down, <b>MOUSEEVENTF_LEFTDOWN</b> is set when the left button is first
///              pressed, but not for subsequent motions. Similarly, <b>MOUSEEVENTF_LEFTUP</b> is set only when the button is
///              first released. You cannot specify both <b>MOUSEEVENTF_WHEEL</b> and either <b>MOUSEEVENTF_XDOWN</b> or
///              <b>MOUSEEVENTF_XUP</b> simultaneously in the <i>dwFlags</i> parameter, because they both require use of the
///              <i>dwData</i> field.
///    dx = Type: <b>DWORD</b> The mouse's absolute position along the x-axis or its amount of motion since the last mouse
///         event was generated, depending on the setting of <b>MOUSEEVENTF_ABSOLUTE</b>. Absolute data is specified as the
///         mouse's actual x-coordinate; relative data is specified as the number of mickeys moved. A <i>mickey</i> is the
///         amount that a mouse has to move for it to report that it has moved.
///    dy = Type: <b>DWORD</b> The mouse's absolute position along the y-axis or its amount of motion since the last mouse
///         event was generated, depending on the setting of <b>MOUSEEVENTF_ABSOLUTE</b>. Absolute data is specified as the
///         mouse's actual y-coordinate; relative data is specified as the number of mickeys moved.
///    dwData = Type: <b>DWORD</b> If <i>dwFlags</i> contains <b>MOUSEEVENTF_WHEEL</b>, then <i>dwData</i> specifies the amount
///             of wheel movement. A positive value indicates that the wheel was rotated forward, away from the user; a negative
///             value indicates that the wheel was rotated backward, toward the user. One wheel click is defined as
///             <b>WHEEL_DELTA</b>, which is 120. If <i>dwFlags</i> contains <b>MOUSEEVENTF_HWHEEL</b>, then <i>dwData</i>
///             specifies the amount of wheel movement. A positive value indicates that the wheel was tilted to the right; a
///             negative value indicates that the wheel was tilted to the left. If <i>dwFlags</i> contains
///             <b>MOUSEEVENTF_XDOWN</b> or <b>MOUSEEVENTF_XUP</b>, then <i>dwData</i> specifies which X buttons were pressed or
///             released. This value may be any combination of the following flags. If <i>dwFlags</i> is not
///             <b>MOUSEEVENTF_WHEEL</b>, <b>MOUSEEVENTF_XDOWN</b>, or <b>MOUSEEVENTF_XUP</b>, then <i>dwData</i> should be zero.
///             <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="XBUTTON1"></a><a
///             id="xbutton1"></a><dl> <dt><b>XBUTTON1</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Set if the first X
///             button was pressed or released. </td> </tr> <tr> <td width="40%"><a id="XBUTTON2"></a><a id="xbutton2"></a><dl>
///             <dt><b>XBUTTON2</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Set if the second X button was pressed or
///             released. </td> </tr> </table>
///    dwExtraInfo = Type: <b>ULONG_PTR</b> An additional value associated with the mouse event. An application calls
///                  GetMessageExtraInfo to obtain this extra information.
@DllImport("USER32")
void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, size_t dwExtraInfo);

///Synthesizes keystrokes, mouse motions, and button clicks.
///Params:
///    cInputs = Type: <b>UINT</b> The number of structures in the <i>pInputs</i> array.
///    pInputs = Type: <b>LPINPUT</b> An array of INPUT structures. Each structure represents an event to be inserted into the
///              keyboard or mouse input stream.
///    cbSize = Type: <b>int</b> The size, in bytes, of an INPUT structure. If <i>cbSize</i> is not the size of an <b>INPUT</b>
///             structure, the function fails.
///Returns:
///    Type: <b>UINT</b> The function returns the number of events that it successfully inserted into the keyboard or
///    mouse input stream. If the function returns zero, the input was already blocked by another thread. To get
///    extended error information, call GetLastError. This function fails when it is blocked by UIPI. Note that neither
///    GetLastError nor the return value will indicate the failure was caused by UIPI blocking.
///    
@DllImport("USER32")
uint SendInput(uint cInputs, char* pInputs, int cbSize);

///Retrieves the time of the last input event.
///Params:
///    plii = Type: <b>PLASTINPUTINFO</b> A pointer to a LASTINPUTINFO structure that receives the time of the last input
///           event.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL GetLastInputInfo(LASTINPUTINFO* plii);

///Translates (maps) a virtual-key code into a scan code or character value, or translates a scan code into a
///virtual-key code. To specify a handle to the keyboard layout to use for translating the specified code, use the
///[MapVirtualKeyEx](nf-winuser-mapvirtualkeyexa.md) function.
///Params:
///    uCode = Type: **UINT** The [virtual key code](/windows/desktop/inputdev/virtual-key-codes) or scan code for a key. How
///            this value is interpreted depends on the value of the *uMapType* parameter.
///    uMapType = Type: **UINT** The translation to be performed. The value of this parameter depends on the value of the *uCode*
///               parameter. | Value | Meaning | |-------|---------| | **MAPVK\_VK\_TO\_VSC**<br>0 | The *uCode* parameter is a
///               virtual-key code and is translated into a scan code. If it is a virtual-key code that does not distinguish
///               between left- and right-hand keys, the left-hand scan code is returned. If there is no translation, the function
///               returns 0. | | **MAPVK\_VSC\_TO\_VK**<br>1 | The *uCode* parameter is a scan code and is translated into a
///               virtual-key code that does not distinguish between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VSC\_TO\_VK\_EX**<br>3 | The *uCode* parameter is a scan code and is translated
///               into a virtual-key code that distinguishes between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VK\_TO\_CHAR**<br>2 | The *uCode* parameter is a virtual-key code and is
///               translated into an unshifted character value in the low order word of the return value. Dead keys (diacritics)
///               are indicated by setting the top bit of the return value. If there is no translation, the function returns 0. |
///Returns:
///    Type: **UINT** The return value is either a scan code, a virtual-key code, or a character value, depending on the
///    value of *uCode* and *uMapType*. If there is no translation, the return value is zero.
///    
@DllImport("USER32")
uint MapVirtualKeyA(uint uCode, uint uMapType);

///Translates (maps) a virtual-key code into a scan code or character value, or translates a scan code into a
///virtual-key code. To specify a handle to the keyboard layout to use for translating the specified code, use the
///[MapVirtualKeyEx](nf-winuser-mapvirtualkeyexw.md) function.
///Params:
///    uCode = Type: **UINT** The [virtual key code](/windows/desktop/inputdev/virtual-key-codes) or scan code for a key. How
///            this value is interpreted depends on the value of the *uMapType* parameter.
///    uMapType = Type: **UINT** The translation to be performed. The value of this parameter depends on the value of the *uCode*
///               parameter. | Value | Meaning | |-------|---------| | **MAPVK\_VK\_TO\_VSC**<br>0 | The *uCode* parameter is a
///               virtual-key code and is translated into a scan code. If it is a virtual-key code that does not distinguish
///               between left- and right-hand keys, the left-hand scan code is returned. If there is no translation, the function
///               returns 0. | | **MAPVK\_VSC\_TO\_VK**<br>1 | The *uCode* parameter is a scan code and is translated into a
///               virtual-key code that does not distinguish between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VSC\_TO\_VK\_EX**<br>3 | The *uCode* parameter is a scan code and is translated
///               into a virtual-key code that distinguishes between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VK\_TO\_CHAR**<br>2 | The *uCode* parameter is a virtual-key code and is
///               translated into an unshifted character value in the low order word of the return value. Dead keys (diacritics)
///               are indicated by setting the top bit of the return value. If there is no translation, the function returns 0. |
///Returns:
///    Type: **UINT** The return value is either a scan code, a virtual-key code, or a character value, depending on the
///    value of *uCode* and *uMapType*. If there is no translation, the return value is zero.
///    
@DllImport("USER32")
uint MapVirtualKeyW(uint uCode, uint uMapType);

///Translates (maps) a virtual-key code into a scan code or character value, or translates a scan code into a
///virtual-key code. The function translates the codes using the input language and an input locale identifier.
///Params:
///    uCode = Type: **UINT** The [virtual key code](/windows/desktop/inputdev/virtual-key-codes) or scan code for a key. How
///            this value is interpreted depends on the value of the *uMapType* parameter. Starting with Windows Vista, the high
///            byte of the *uCode* value can contain either 0xe0 or 0xe1 to specify the extended scan code.
///    uMapType = Type: **UINT** The translation to perform. The value of this parameter depends on the value of the <i>uCode</i>
///               parameter. | Value | Meaning | |-------|---------| | **MAPVK\_VK\_TO\_VSC**<br>0 | The *uCode* parameter is a
///               virtual-key code and is translated into a scan code. If it is a virtual-key code that does not distinguish
///               between left- and right-hand keys, the left-hand scan code is returned. If there is no translation, the function
///               returns 0. | | **MAPVK\_VSC\_TO\_VK**<br>1 | The *uCode* parameter is a scan code and is translated into a
///               virtual-key code that does not distinguish between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VSC\_TO\_VK\_EX**<br>3 | The *uCode* parameter is a scan code and is translated
///               into a virtual-key code that distinguishes between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VK\_TO\_CHAR**<br>2 | The *uCode* parameter is a virtual-key code and is
///               translated into an unshifted character value in the low order word of the return value. Dead keys (diacritics)
///               are indicated by setting the top bit of the return value. If there is no translation, the function returns 0. | |
///               **MAPVK\_VK\_TO\_VSC\_EX**<br>4 | The *uCode* parameter is a virtual-key code and is translated into a scan code.
///               If it is a virtual-key code that does not distinguish between left- and right-hand keys, the left-hand scan code
///               is returned. If the scan code is an extended scan code, the high byte of the *uCode* value can contain either
///               0xe0 or 0xe1 to specify the extended scan code. If there is no translation, the function returns 0. |
///    dwhkl = Type: **HKL** Input locale identifier to use for translating the specified code. This parameter can be any input
///            locale identifier previously returned by the [LoadKeyboardLayout](nf-winuser-loadkeyboardlayouta.md) function.
///Returns:
///    Type: **UINT** The return value is either a scan code, a virtual-key code, or a character value, depending on the
///    value of *uCode* and *uMapType*. If there is no translation, the return value is zero.
///    
@DllImport("USER32")
uint MapVirtualKeyExA(uint uCode, uint uMapType, ptrdiff_t dwhkl);

///Translates (maps) a virtual-key code into a scan code or character value, or translates a scan code into a
///virtual-key code. The function translates the codes using the input language and an input locale identifier.
///Params:
///    uCode = Type: **UINT** The [virtual key code](/windows/desktop/inputdev/virtual-key-codes) or scan code for a key. How
///            this value is interpreted depends on the value of the *uMapType* parameter. Starting with Windows Vista, the high
///            byte of the *uCode* value can contain either 0xe0 or 0xe1 to specify the extended scan code.
///    uMapType = Type: **UINT** The translation to perform. The value of this parameter depends on the value of the <i>uCode</i>
///               parameter. | Value | Meaning | |-------|---------| | **MAPVK\_VK\_TO\_VSC**<br>0 | The *uCode* parameter is a
///               virtual-key code and is translated into a scan code. If it is a virtual-key code that does not distinguish
///               between left- and right-hand keys, the left-hand scan code is returned. If there is no translation, the function
///               returns 0. | | **MAPVK\_VSC\_TO\_VK**<br>1 | The *uCode* parameter is a scan code and is translated into a
///               virtual-key code that does not distinguish between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VSC\_TO\_VK\_EX**<br>3 | The *uCode* parameter is a scan code and is translated
///               into a virtual-key code that distinguishes between left- and right-hand keys. If there is no translation, the
///               function returns 0. | | **MAPVK\_VK\_TO\_CHAR**<br>2 | The *uCode* parameter is a virtual-key code and is
///               translated into an unshifted character value in the low order word of the return value. Dead keys (diacritics)
///               are indicated by setting the top bit of the return value. If there is no translation, the function returns 0. | |
///               **MAPVK\_VK\_TO\_VSC\_EX**<br>4 | The *uCode* parameter is a virtual-key code and is translated into a scan code.
///               If it is a virtual-key code that does not distinguish between left- and right-hand keys, the left-hand scan code
///               is returned. If the scan code is an extended scan code, the high byte of the *uCode* value can contain either
///               0xe0 or 0xe1 to specify the extended scan code. If there is no translation, the function returns 0. |
///    dwhkl = Type: **HKL** Input locale identifier to use for translating the specified code. This parameter can be any input
///            locale identifier previously returned by the [LoadKeyboardLayout](nf-winuser-loadkeyboardlayoutw.md) function.
///Returns:
///    Type: **UINT** The return value is either a scan code, a virtual-key code, or a character value, depending on the
///    value of *uCode* and *uMapType*. If there is no translation, the return value is zero.
///    
@DllImport("USER32")
uint MapVirtualKeyExW(uint uCode, uint uMapType, ptrdiff_t dwhkl);

///Retrieves a handle to the window (if any) that has captured the mouse. Only one window at a time can capture the
///mouse; this window receives mouse input whether or not the cursor is within its borders.
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the capture window associated with the current thread. If no
///    window in the thread has captured the mouse, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND GetCapture();

///Sets the mouse capture to the specified window belonging to the current thread.<b>SetCapture</b> captures mouse input
///either when the mouse is over the capturing window, or when the mouse button was pressed while the mouse was over the
///capturing window and the button is still down. Only one window at a time can capture the mouse. If the mouse cursor
///is over a window created by another thread, the system will direct mouse input to the specified window only if a
///mouse button is down.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window in the current thread that is to capture the mouse.
///Returns:
///    Type: <b>HWND</b> The return value is a handle to the window that had previously captured the mouse. If there is
///    no such window, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND SetCapture(HWND hWnd);

///Releases the mouse capture from a window in the current thread and restores normal mouse input processing. A window
///that has captured the mouse receives all mouse input, regardless of the position of the cursor, except when a mouse
///button is clicked while the cursor hot spot is in the window of another thread.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ReleaseCapture();

///Enables or disables mouse and keyboard input to the specified window or control. When input is disabled, the window
///does not receive input such as mouse clicks and key presses. When input is enabled, the window receives all input.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be enabled or disabled.
///    bEnable = Type: <b>BOOL</b> Indicates whether to enable or disable the window. If this parameter is <b>TRUE</b>, the window
///              is enabled. If the parameter is <b>FALSE</b>, the window is disabled.
///Returns:
///    Type: <b>BOOL</b> If the window was previously disabled, the return value is nonzero. If the window was not
///    previously disabled, the return value is zero.
///    
@DllImport("USER32")
BOOL EnableWindow(HWND hWnd, BOOL bEnable);

///Determines whether the specified window is enabled for mouse and keyboard input.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the window to be tested.
///Returns:
///    Type: <b>BOOL</b> If the window is enabled, the return value is nonzero. If the window is not enabled, the return
///    value is zero.
///    
@DllImport("USER32")
BOOL IsWindowEnabled(HWND hWnd);

///Captures the mouse and tracks its movement until the user releases the left button, presses the ESC key, or moves the
///mouse outside the drag rectangle around the specified point. The width and height of the drag rectangle are specified
///by the <b>SM_CXDRAG</b> and <b>SM_CYDRAG</b> values returned by the GetSystemMetrics function.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window receiving mouse input.
///    pt = Type: <b>POINT</b> Initial position of the mouse, in screen coordinates. The function determines the coordinates
///         of the drag rectangle by using this point.
///Returns:
///    Type: <b>BOOL</b> If the user moved the mouse outside of the drag rectangle while holding down the left button,
///    the return value is nonzero. If the user did not move the mouse outside of the drag rectangle while holding down
///    the left button, the return value is zero.
///    
@DllImport("USER32")
BOOL DragDetect(HWND hwnd, POINT pt);

///Activates a window. The window must be attached to the calling thread's message queue.
///Params:
///    hWnd = Type: <b>HWND</b> A handle to the top-level window to be activated.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the handle to the window that was previously
///    active. If the function fails, the return value is <b>NULL</b>. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
HWND SetActiveWindow(HWND hWnd);

///Blocks keyboard and mouse input events from reaching applications.
///Params:
///    fBlockIt = Type: <b>BOOL</b> The function's purpose. If this parameter is <b>TRUE</b>, keyboard and mouse input events are
///               blocked. If this parameter is <b>FALSE</b>, keyboard and mouse events are unblocked. Note that only the thread
///               that blocked input can successfully unblock input.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If input is already blocked, the return
///    value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL BlockInput(BOOL fBlockIt);

///Retrieves the raw input from the specified device.
///Params:
///    hRawInput = Type: <b>HRAWINPUT</b> A handle to the RAWINPUT structure. This comes from the <i>lParam</i> in WM_INPUT.
///    uiCommand = Type: <b>UINT</b> The command flag. This parameter can be one of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RID_HEADER"></a><a id="rid_header"></a><dl>
///                <dt><b>RID_HEADER</b></dt> <dt>0x10000005</dt> </dl> </td> <td width="60%"> Get the header information from the
///                RAWINPUT structure. </td> </tr> <tr> <td width="40%"><a id="RID_INPUT"></a><a id="rid_input"></a><dl>
///                <dt><b>RID_INPUT</b></dt> <dt>0x10000003</dt> </dl> </td> <td width="60%"> Get the raw data from the RAWINPUT
///                structure. </td> </tr> </table>
///    pData = Type: <b>LPVOID</b> A pointer to the data that comes from the RAWINPUT structure. This depends on the value of
///            <i>uiCommand</i>. If <i>pData</i> is <b>NULL</b>, the required size of the buffer is returned in *<i>pcbSize</i>.
///    pcbSize = Type: <b>PUINT</b> The size, in bytes, of the data in <i>pData</i>.
///    cbSizeHeader = Type: <b>UINT</b> The size, in bytes, of the RAWINPUTHEADER structure.
///Returns:
///    Type: <b>UINT</b> If <i>pData</i> is <b>NULL</b> and the function is successful, the return value is 0. If
///    <i>pData</i> is not <b>NULL</b> and the function is successful, the return value is the number of bytes copied
///    into pData. If there is an error, the return value is (<b>UINT</b>)-1.
///    
@DllImport("USER32")
uint GetRawInputData(ptrdiff_t hRawInput, uint uiCommand, char* pData, uint* pcbSize, uint cbSizeHeader);

///Retrieves information about the raw input device.
///Params:
///    hDevice = Type: <b>HANDLE</b> A handle to the raw input device. This comes from the <b>hDevice</b> member of RAWINPUTHEADER
///              or from GetRawInputDeviceList.
///    uiCommand = Type: <b>UINT</b> Specifies what data will be returned in <i>pData</i>. This parameter can be one of the
///                following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="RIDI_PREPARSEDDATA"></a><a id="ridi_preparseddata"></a><dl> <dt><b>RIDI_PREPARSEDDATA</b></dt>
///                <dt>0x20000005</dt> </dl> </td> <td width="60%"> <i>pData</i> is a PHIDP_PREPARSED_DATA pointer to a buffer for a
///                top-level collection's preparsed data. </td> </tr> <tr> <td width="40%"><a id="RIDI_DEVICENAME"></a><a
///                id="ridi_devicename"></a><dl> <dt><b>RIDI_DEVICENAME</b></dt> <dt>0x20000007</dt> </dl> </td> <td width="60%">
///                <i>pData</i> points to a string that contains the device interface name. If this device is <a
///                href="/windows-hardware/drivers/hid/hid-architecture
///    pData = Type: <b>LPVOID</b> A pointer to a buffer that contains the information specified by <i>uiCommand</i>. If
///            <i>uiCommand</i> is <b>RIDI_DEVICEINFO</b>, set the <b>cbSize</b> member of RID_DEVICE_INFO to
///            <code>sizeof(RID_DEVICE_INFO)</code> before calling <b>GetRawInputDeviceInfo</b>.
///    pcbSize = Type: <b>PUINT</b> The size, in bytes, of the data in <i>pData</i>.
///Returns:
///    Type: <b>UINT</b> If successful, this function returns a non-negative number indicating the number of bytes
///    copied to <i>pData</i>. If <i>pData</i> is not large enough for the data, the function returns -1. If
///    <i>pData</i> is <b>NULL</b>, the function returns a value of zero. In both of these cases, <i>pcbSize</i> is set
///    to the minimum size required for the <i>pData</i> buffer. Call GetLastError to identify any other errors.
///    
@DllImport("USER32")
uint GetRawInputDeviceInfoA(HANDLE hDevice, uint uiCommand, char* pData, uint* pcbSize);

///Retrieves information about the raw input device.
///Params:
///    hDevice = Type: <b>HANDLE</b> A handle to the raw input device. This comes from the <b>hDevice</b> member of RAWINPUTHEADER
///              or from GetRawInputDeviceList.
///    uiCommand = Type: <b>UINT</b> Specifies what data will be returned in <i>pData</i>. This parameter can be one of the
///                following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="RIDI_PREPARSEDDATA"></a><a id="ridi_preparseddata"></a><dl> <dt><b>RIDI_PREPARSEDDATA</b></dt>
///                <dt>0x20000005</dt> </dl> </td> <td width="60%"> <i>pData</i> is a PHIDP_PREPARSED_DATA pointer to a buffer for a
///                top-level collection's preparsed data. </td> </tr> <tr> <td width="40%"><a id="RIDI_DEVICENAME"></a><a
///                id="ridi_devicename"></a><dl> <dt><b>RIDI_DEVICENAME</b></dt> <dt>0x20000007</dt> </dl> </td> <td width="60%">
///                <i>pData</i> points to a string that contains the device interface name. If this device is <a
///                href="/windows-hardware/drivers/hid/hid-architecture
///    pData = Type: <b>LPVOID</b> A pointer to a buffer that contains the information specified by <i>uiCommand</i>. If
///            <i>uiCommand</i> is <b>RIDI_DEVICEINFO</b>, set the <b>cbSize</b> member of RID_DEVICE_INFO to
///            <code>sizeof(RID_DEVICE_INFO)</code> before calling <b>GetRawInputDeviceInfo</b>.
///    pcbSize = Type: <b>PUINT</b> The size, in bytes, of the data in <i>pData</i>.
///Returns:
///    Type: <b>UINT</b> If successful, this function returns a non-negative number indicating the number of bytes
///    copied to <i>pData</i>. If <i>pData</i> is not large enough for the data, the function returns -1. If
///    <i>pData</i> is <b>NULL</b>, the function returns a value of zero. In both of these cases, <i>pcbSize</i> is set
///    to the minimum size required for the <i>pData</i> buffer. Call GetLastError to identify any other errors.
///    
@DllImport("USER32")
uint GetRawInputDeviceInfoW(HANDLE hDevice, uint uiCommand, char* pData, uint* pcbSize);

///Performs a buffered read of the raw input messages data found in the calling thread's message queue.
///Params:
///    pData = Type: **PRAWINPUT** A pointer to a buffer of [RAWINPUT](ns-winuser-rawinput.md) structures that contain the raw
///            input data. If **NULL**, size of the first raw input message data (minimum required buffer), in bytes, is
///            returned in \**pcbSize*.
///    pcbSize = Type: **PUINT** The size, in bytes, of the provided [RAWINPUT](ns-winuser-rawinput.md) buffer.
///    cbSizeHeader = Type: **UINT** The size, in bytes, of the [RAWINPUTHEADER](ns-winuser-rawinputheader.md) structure.
///Returns:
///    Type: **UINT** If *pData* is **NULL** and the function is successful, the return value is zero. If *pData* is not
///    **NULL** and the function is successful, the return value is the number of [RAWINPUT](ns-winuser-rawinput.md)
///    structures written to *pData*. If an error occurs, the return value is (**UINT**)-1. Call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) for the error code.
///    
@DllImport("USER32")
uint GetRawInputBuffer(char* pData, uint* pcbSize, uint cbSizeHeader);

///Registers the devices that supply the raw input data.
///Params:
///    pRawInputDevices = Type: <b>PCRAWINPUTDEVICE</b> An array of RAWINPUTDEVICE structures that represent the devices that supply the
///                       raw input.
///    uiNumDevices = Type: <b>UINT</b> The number of RAWINPUTDEVICE structures pointed to by <i>pRawInputDevices</i>.
///    cbSize = Type: <b>UINT</b> The size, in bytes, of a RAWINPUTDEVICE structure.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b> if the function succeeds; otherwise, <b>FALSE</b>. If the function fails, call
///    GetLastError for more information.
///    
@DllImport("USER32")
BOOL RegisterRawInputDevices(char* pRawInputDevices, uint uiNumDevices, uint cbSize);

///Retrieves the information about the raw input devices for the current application.
///Params:
///    pRawInputDevices = Type: <b>PRAWINPUTDEVICE</b> An array of RAWINPUTDEVICE structures for the application.
///    puiNumDevices = Type: <b>PUINT</b> The number of RAWINPUTDEVICE structures in *<i>pRawInputDevices</i>.
///    cbSize = Type: <b>UINT</b> The size, in bytes, of a RAWINPUTDEVICE structure.
///Returns:
///    Type: <b>UINT</b> If successful, the function returns a non-negative number that is the number of RAWINPUTDEVICE
///    structures written to the buffer. If the <i>pRawInputDevices</i> buffer is too small or <b>NULL</b>, the function
///    sets the last error as <b>ERROR_INSUFFICIENT_BUFFER</b>, returns -1, and sets <i>puiNumDevices</i> to the
///    required number of devices. If the function fails for any other reason, it returns -1. For more details, call
///    GetLastError.
///    
@DllImport("USER32")
uint GetRegisteredRawInputDevices(char* pRawInputDevices, uint* puiNumDevices, uint cbSize);

///Enumerates the raw input devices attached to the system.
///Params:
///    pRawInputDeviceList = Type: <b>PRAWINPUTDEVICELIST</b> An array of RAWINPUTDEVICELIST structures for the devices attached to the
///                          system. If <b>NULL</b>, the number of devices are returned in *<i>puiNumDevices</i>.
///    puiNumDevices = Type: <b>PUINT</b> If <i>pRawInputDeviceList</i> is <b>NULL</b>, the function populates this variable with the
///                    number of devices attached to the system; otherwise, this variable specifies the number of RAWINPUTDEVICELIST
///                    structures that can be contained in the buffer to which <i>pRawInputDeviceList</i> points. If this value is less
///                    than the number of devices attached to the system, the function returns the actual number of devices in this
///                    variable and fails with <b>ERROR_INSUFFICIENT_BUFFER</b>.
///    cbSize = Type: <b>UINT</b> The size of a RAWINPUTDEVICELIST structure, in bytes.
///Returns:
///    Type: <b>UINT</b> If the function is successful, the return value is the number of devices stored in the buffer
///    pointed to by <i>pRawInputDeviceList</i>. On any other error, the function returns (<b>UINT</b>) -1 and
///    GetLastError returns the error indication.
///    
@DllImport("USER32")
uint GetRawInputDeviceList(char* pRawInputDeviceList, uint* puiNumDevices, uint cbSize);

///Unlike DefWindowProcA and DefWindowProcW, this function doesn't do any processing. <b>DefRawInputProc</b> only checks
///whether <b>cbSizeHeader</b>'s value corresponds to the expected size of RAWINPUTHEADER.
///Params:
///    paRawInput = Type: <b>PRAWINPUT*</b> Ignored.
///    nInput = Type: <b>INT</b> Ignored.
///    cbSizeHeader = Type: <b>UINT</b> The size, in bytes, of the RAWINPUTHEADER structure.
///Returns:
///    Type: <b>LRESULT</b> If successful, the function returns <b>0</b>. Otherwise it returns <b>-1</b>.
///    
@DllImport("USER32")
LRESULT DefRawInputProc(char* paRawInput, int nInput, uint cbSizeHeader);


