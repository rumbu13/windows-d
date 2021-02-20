// Written in the D programming language.

module windows.pointerinput;

public import windows.core;
public import windows.displaydevices : POINT, RECT;
public import windows.menusandresources : POINTER_INPUT_TYPE;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


///Identifies a change in the state of a button associated with a pointer.
alias POINTER_BUTTON_CHANGE_TYPE = int;
enum : int
{
    ///No change in button state.
    POINTER_CHANGE_NONE              = 0x00000000,
    ///The first button (see POINTER_FLAG_FIRSTBUTTON) transitioned to a pressed state.
    POINTER_CHANGE_FIRSTBUTTON_DOWN  = 0x00000001,
    ///The first button (see POINTER_FLAG_FIRSTBUTTON) transitioned to a released state.
    POINTER_CHANGE_FIRSTBUTTON_UP    = 0x00000002,
    ///The second button (see POINTER_FLAG_SECONDBUTTON) transitioned to a pressed state.
    POINTER_CHANGE_SECONDBUTTON_DOWN = 0x00000003,
    ///The second button (see POINTER_FLAG_SECONDBUTTON) transitioned to a released state.
    POINTER_CHANGE_SECONDBUTTON_UP   = 0x00000004,
    ///The third button (see POINTER_FLAG_THIRDBUTTON) transitioned to a pressed state.
    POINTER_CHANGE_THIRDBUTTON_DOWN  = 0x00000005,
    ///The third button (see POINTER_FLAG_THIRDBUTTON) transitioned to a released state.
    POINTER_CHANGE_THIRDBUTTON_UP    = 0x00000006,
    ///The fourth button (see POINTER_FLAG_FOURTHBUTTON) transitioned to a pressed state.
    POINTER_CHANGE_FOURTHBUTTON_DOWN = 0x00000007,
    ///The fourth button (see POINTER_FLAG_FOURTHBUTTON) transitioned to a released state.
    POINTER_CHANGE_FOURTHBUTTON_UP   = 0x00000008,
    ///The fifth button (see POINTER_FLAG_FIFTHBUTTON) transitioned to a pressed state.
    POINTER_CHANGE_FIFTHBUTTON_DOWN  = 0x00000009,
    ///The fifth button (see POINTER_FLAG_FIFTHBUTTON) transitioned to a released state.
    POINTER_CHANGE_FIFTHBUTTON_UP    = 0x0000000a,
}

// Structs


///Contains basic pointer information common to all pointer types. Applications can retrieve this information using the
///GetPointerInfo, GetPointerFrameInfo, GetPointerInfoHistory and GetPointerFrameInfoHistory functions.
struct POINTER_INFO
{
    ///Type: <b>POINTER_INPUT_TYPE</b> A value from the POINTER_INPUT_TYPE enumeration that specifies the pointer type.
    POINTER_INPUT_TYPE pointerType;
    ///Type: <b>UINT32</b> An identifier that uniquely identifies a pointer during its lifetime. A pointer comes into
    ///existence when it is first detected and ends its existence when it goes out of detection range. Note that if a
    ///physical entity (finger or pen) goes out of detection range and then returns to be detected again, it is treated
    ///as a new pointer and may be assigned a new pointer identifier.
    uint               pointerId;
    ///Type: <b>UINT32</b> An identifier common to multiple pointers for which the source device reported an update in a
    ///single input frame. For example, a parallel-mode multi-touch digitizer may report the positions of multiple touch
    ///contacts in a single update to the system. Note that frame identifier is assigned as input is reported to the
    ///system for all pointers across all devices. Therefore, this field may not contain strictly sequential values in a
    ///single series of messages that a window receives. However, this field will contain the same numerical value for
    ///all input updates that were reported in the same input frame by a single device.
    uint               frameId;
    ///Type: <b>POINTER_FLAGS</b> May be any reasonable combination of flags from the Pointer Flags constants.
    uint               pointerFlags;
    ///Type: <b>HANDLE</b> Handle to the source device that can be used in calls to the raw input device API and the
    ///digitizer device API.
    HANDLE             sourceDevice;
    ///Type: <b>HWND</b> Window to which this message was targeted. If the pointer is captured, either implicitly by
    ///virtue of having made contact over this window or explicitly using the pointer capture API, this is the capture
    ///window. If the pointer is uncaptured, this is the window over which the pointer was when this message was
    ///generated.
    HWND               hwndTarget;
    ///Type: <b>POINT</b> The predicted screen coordinates of the pointer, in pixels. The predicted value is based on
    ///the pointer position reported by the digitizer and the motion of the pointer. This correction can compensate for
    ///visual lag due to inherent delays in sensing and processing the pointer location on the digitizer. This is
    ///applicable to pointers of type PT_TOUCH. For other pointer types, the predicted value will be the same as the
    ///non-predicted value (see <b>ptPixelLocationRaw</b>).
    POINT              ptPixelLocation;
    ///Type: <b>POINT</b> The predicted screen coordinates of the pointer, in HIMETRIC units. The predicted value is
    ///based on the pointer position reported by the digitizer and the motion of the pointer. This correction can
    ///compensate for visual lag due to inherent delays in sensing and processing the pointer location on the digitizer.
    ///This is applicable to pointers of type PT_TOUCH. For other pointer types, the predicted value will be the same as
    ///the non-predicted value (see <b>ptHimetricLocationRaw</b>).
    POINT              ptHimetricLocation;
    ///Type: <b>POINT</b> The screen coordinates of the pointer, in pixels. For adjusted screen coordinates, see
    ///<b>ptPixelLocation</b>.
    POINT              ptPixelLocationRaw;
    ///Type: <b>POINT</b> The screen coordinates of the pointer, in HIMETRIC units. For adjusted screen coordinates, see
    ///<b>ptHimetricLocation</b>.
    POINT              ptHimetricLocationRaw;
    ///Type: <b>DWORD</b> 0 or the time stamp of the message, based on the system tick count when the message was
    ///received. The application can specify the input time stamp in either <b>dwTime</b> or <b>PerformanceCount</b>.
    ///The value cannot be more recent than the current tick count or <b>QueryPerformanceCount (QPC)</b> value of the
    ///injection thread. Once a frame is injected with a time stamp, all subsequent frames must include a timestamp
    ///until all contacts in the frame go to an UP state. The custom timestamp value must also be provided for the first
    ///element in the contacts array. The time stamp values after the first element are ignored. The custom timestamp
    ///value must increment in every injection frame. When <b>PerformanceCount</b> is specified, the time stamp will be
    ///converted to the current time in .1 millisecond resolution upon actual injection. If a custom
    ///<b>PerformanceCount</b> resulted in the same .1 millisecond window from the previous injection,
    ///<b>ERROR_NOT_READY</b> is returned and injection will not occur. While injection will not be invalidated
    ///immediately by the error, the next successful injection must have a <b>PerformanceCount</b> value that is at
    ///least 0.1 millisecond from the previously successful injection. This is also true if <b>dwTime</b> is used. If
    ///both <b>dwTime</b> and <b>PerformanceCount</b> are specified in InjectTouchInput, ERROR_INVALID_PARAMETER is
    ///returned. InjectTouchInput cannot switch between <b>dwTime</b> and <b>PerformanceCount</b> once injection has
    ///started. If neither <b>dwTime</b> and <b>PerformanceCount</b> are specified, InjectTouchInput allocates the
    ///timestamp based on the timing of the call. If <b>InjectTouchInput</b> calls are repeatedly less than 0.1
    ///millisecond apart, ERROR_NOT_READY might be returned. The error will not invalidate the input immediately, but
    ///the injection application needs to retry the same frame again for injection to succeed.
    uint               dwTime;
    ///Type: <b>UINT32</b> Count of inputs that were coalesced into this message. This count matches the total count of
    ///entries that can be returned by a call to GetPointerInfoHistory. If no coalescing occurred, this count is 1 for
    ///the single input represented by the message.
    uint               historyCount;
    int                InputData;
    ///Type: <b>DWORD</b> Indicates which keyboard modifier keys were pressed at the time the input was generated. May
    ///be zero or a combination of the following values. POINTER_MOD_SHIFT – A SHIFT key was pressed. POINTER_MOD_CTRL
    ///– A CTRL key was pressed.
    uint               dwKeyStates;
    ///Type: <b>UINT64</b> The value of the high-resolution performance counter when the pointer message was received
    ///(high-precision, 64 bit alternative to <b>dwTime</b>). The value can be calibrated when the touch digitizer
    ///hardware supports the scan timestamp information in its input report.
    ulong              PerformanceCount;
    ///Type: <b>POINTER_BUTTON_CHANGE_TYPE</b> A value from the POINTER_BUTTON_CHANGE_TYPE enumeration that specifies
    ///the change in button state between this input and the previous input.
    POINTER_BUTTON_CHANGE_TYPE ButtonChangeType;
}

///Defines basic touch information common to all pointer types.
struct POINTER_TOUCH_INFO
{
    ///Type: <b>POINTER_INFO</b> An embedded POINTER_INFO header structure.
    POINTER_INFO pointerInfo;
    ///Type: <b>Touch Flags</b> Currently none.
    uint         touchFlags;
    ///Type: <b>Touch Mask</b> Indicates which of the optional fields contain valid values. The member can be zero or
    ///any combination of the values from the Touch Mask constants.
    uint         touchMask;
    ///Type: <b>RECT</b> The predicted screen coordinates of the contact area, in pixels. By default, if the device does
    ///not report a contact area, this field defaults to a 0-by-0 rectangle centered around the pointer location. The
    ///predicted value is based on the pointer position reported by the digitizer and the motion of the pointer. This
    ///correction can compensate for visual lag due to inherent delays in sensing and processing the pointer location on
    ///the digitizer. This is applicable to pointers of type PT_TOUCH.
    RECT         rcContact;
    ///Type: <b>RECT</b> The raw screen coordinates of the contact area, in pixels. For adjusted screen coordinates, see
    ///<b>rcContact</b>.
    RECT         rcContactRaw;
    ///Type: <b>UINT32</b> A pointer orientation, with a value between 0 and 359, where 0 indicates a touch pointer
    ///aligned with the x-axis and pointing from left to right; increasing values indicate degrees of rotation in the
    ///clockwise direction. This field defaults to 0 if the device does not report orientation.
    uint         orientation;
    ///Type: <b>UINT32</b> A pen pressure normalized to a range between 0 and 1024. The default is 0 if the device does
    ///not report pressure.
    uint         pressure;
}

///Defines basic pen information common to all pointer types.
struct POINTER_PEN_INFO
{
    ///Type: <b>POINTER_INFO</b> An embedded POINTER_INFO structure.
    POINTER_INFO pointerInfo;
    ///Type: <b>PEN_FLAGS</b> The pen flag. This member can be zero or any reasonable combination of the values from the
    ///Pen Flags constants.
    uint         penFlags;
    ///Type: <b>PEN_MASK</b> The pen mask. This member can be zero or any reasonable combination of the values from the
    ///Pen Mask constants.
    uint         penMask;
    ///Type: <b>UINT32</b> A pen pressure normalized to a range between 0 and 1024. The default is 0 if the device does
    ///not report pressure.
    uint         pressure;
    ///Type: <b>UINT32</b> The clockwise rotation, or twist, of the pointer normalized in a range of 0 to 359. The
    ///default is 0.
    uint         rotation;
    ///Type: <b>INT32</b> The angle of tilt of the pointer along the x-axis in a range of -90 to +90, with a positive
    ///value indicating a tilt to the right. The default is 0.
    int          tiltX;
    ///Type: <b>INT32</b> The angle of tilt of the pointer along the y-axis in a range of -90 to +90, with a positive
    ///value indicating a tilt toward the user. The default is 0.
    int          tiltY;
}

///Defines the matrix that represents a transform on a message consumer. This matrix can be used to transform pointer
///input data from client coordinates to screen coordinates, while the inverse can be used to transform pointer input
///data from screen coordinates to client coordinates.
struct INPUT_TRANSFORM
{
union
    {
struct
        {
            float _11;
            float _12;
            float _13;
            float _14;
            float _21;
            float _22;
            float _23;
            float _24;
            float _31;
            float _32;
            float _33;
            float _34;
            float _41;
            float _42;
            float _43;
            float _44;
        }
        float[16] m;
    }
}

// Functions

///Gets pointer data before it has gone through touch prediction processing.
///Returns:
///    The screen location of the pointer input.
///    
@DllImport("USER32")
uint GetUnpredictedMessagePos();

///Retrieves the pointer type for a specified pointer.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve pointer type.
///    pointerType = An address of a POINTER_INPUT_TYPE type to receive a pointer input type.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerType(uint pointerId, uint* pointerType);

///Retrieves the cursor identifier associated with the specified pointer.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve the cursor identifier.
///    cursorId = An address of a <b>UINT32</b> to receive the tablet cursor identifier, if any, associated with the specified
///               pointer.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerCursorId(uint pointerId, uint* cursorId);

///Gets the information for the specified pointer associated with the current message. <div class="alert"><b>Note</b>
///Use GetPointerType if you don't need the additional information exposed by <b>GetPointerInfo</b>.</div><div> </div>
///Params:
///    pointerId = The pointer identifier.
///    pointerInfo = Address of a POINTER_INFO structure that receives the pointer information.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerInfo(uint pointerId, POINTER_INFO* pointerInfo);

///Gets the information associated with the individual inputs, if any, that were coalesced into the current message for
///the specified pointer. The most recent input is included in the returned history and is the same as the most recent
///input returned by the GetPointerInfo function.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve information.
///    entriesCount = A pointer to a variable that specifies the count of structures in the buffer to which pointerInfo points. If
///                   <b>GetPointerInfoHistory</b> succceeds, <i>entriesCount</i> is updated with the total count of structures
///                   available. The total count of structures available is the same as the <b>historyCount</b> field of the
///                   POINTER_INFO structure returned by a call to GetPointerInfo.
///    pointerInfo = Address of an array of POINTER_INFO structures to receive the pointer information. This parameter can be NULL if
///                  <i>*entriesCount</i> is zero.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerInfoHistory(uint pointerId, uint* entriesCount, POINTER_INFO* pointerInfo);

///Gets the entire frame of information for the specified pointers associated with the current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve frame information.
///    pointerCount = A pointer to a variable that specifies the count of structures in the buffer to which pointerInfo points. If
///                   <b>GetPointerFrameInfo</b> succeeds, <i>pointerCount</i> is updated with the total count of pointers in the
///                   frame.
///    pointerInfo = Address of an array of POINTER_INFO structures to receive the pointer information. This parameter can be
///                  <b>NULL</b> if <i>*pointerCount</i> is zero.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerFrameInfo(uint pointerId, uint* pointerCount, POINTER_INFO* pointerInfo);

///Gets the entire frame of information (including coalesced input frames) for the specified pointers associated with
///the current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve frame information.
///    entriesCount = A pointer to a variable that specifies the count of rows in the two-dimensional array to which pointerInfo
///                   points. If <b>GetPointerFrameInfoHistory</b> succeeds, <i>entriesCount</i> is updated with the total count of
///                   frames available in the history.
///    pointerCount = A pointer to a variable that specifies the count of columns in the two-dimensional array to which pointerInfo
///                   points. If <b>GetPointerFrameInfoHistory</b> succeeds, <i>pointerCount</i> is updated with the total count of
///                   pointers in each frame.
///    pointerInfo = Address of a two-dimensional array of POINTER_INFO structures to receive the pointer information. This parameter
///                  can be NULL if <i>*entriesCount</i> and <i>*pointerCount</i> are both zero. This array is interpreted as
///                  <code>POINTER_INFO[*entriesCount][*pointerCount]</code>.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerFrameInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, POINTER_INFO* pointerInfo);

///Gets the touch-based information for the specified pointer (of type PT_TOUCH) associated with the current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve information.
///    touchInfo = Address of a POINTER_TOUCH_INFO structure to receive the touch-specific pointer information.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerTouchInfo(uint pointerId, POINTER_TOUCH_INFO* touchInfo);

///Gets the touch-based information associated with the individual inputs, if any, that were coalesced into the current
///message for the specified pointer (of type PT_TOUCH). The most recent input is included in the returned history and
///is the same as the most recent input returned by the GetPointerTouchInfo function.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve information.
///    entriesCount = A pointer to a variable that specifies the count of structures in the buffer to which touchInfo points. If
///                   <b>GetPointerTouchInfoHistory</b> succeeds, <i>entriesCount</i> is updated with the total count of structures
///                   available. The total count of structures available is the same as the <i>historyCount</i> field in the
///                   POINTER_INFO structure returned by a call to GetPointerInfo or GetPointerTouchInfo.
///    touchInfo = Address of an array of POINTER_TOUCH_INFO structures to receive the pointer information. This parameter can be
///                NULL if *entriesCount is zero.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerTouchInfoHistory(uint pointerId, uint* entriesCount, POINTER_TOUCH_INFO* touchInfo);

///Gets the entire frame of touch-based information for the specified pointers (of type PT_TOUCH) associated with the
///current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve frame information.
///    pointerCount = A pointer to a variable that specifies the count of structures in the buffer to which touchInfo points. If
///                   <b>GetPointerFrameTouchInfo</b> succeeds, <i>pointerCount</i> is updated with the total count of pointers in the
///                   frame.
///    touchInfo = Address of an array of POINTER_TOUCH_INFO structures to receive the pointer information. This parameter can be
///                NULL if <i>*pointerCount</i> is zero.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerFrameTouchInfo(uint pointerId, uint* pointerCount, POINTER_TOUCH_INFO* touchInfo);

///Gets the entire frame of touch-based information (including coalesced input frames) for the specified pointers (of
///type PT_TOUCH) associated with the current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve frame information.
///    entriesCount = A pointer to variable that specifies the count of rows in the two-dimensional array to which touchInfo points. If
///                   <b>GetPointerFrameTouchInfoHistory</b> succeeds, <i>entriesCount</i> is updated with the total count of frames
///                   available in the history.
///    pointerCount = A pointer to a variable that specifies the count of columns in the two-dimensional array to which touchInfo
///                   points. If <b>GetPointerFrameTouchInfoHistory</b> succeeds, <i>pointerCount</i> is updated with the total count
///                   of pointers in each frame.
///    touchInfo = Address of a two-dimensional array of POINTER_TOUCH_INFO structures to receive the pointer information. This
///                parameter can be NULL if <i>*entriesCount</i> and <i>*pointerCount</i> are both zero. This array is interpreted
///                as <code>POINTER_TOUCH_INFO[*entriesCount][*pointerCount]</code>.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerFrameTouchInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, 
                                     POINTER_TOUCH_INFO* touchInfo);

///Gets the pen-based information for the specified pointer (of type PT_PEN) associated with the current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve information.
///    penInfo = Address of a POINTER_PEN_INFO structure to receive the pen-specific pointer information.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerPenInfo(uint pointerId, POINTER_PEN_INFO* penInfo);

///Gets the pen-based information associated with the individual inputs, if any, that were coalesced into the current
///message for the specified pointer (of type PT_PEN). The most recent input is included in the returned history and is
///the same as the most recent input returned by the GetPointerPenInfo function.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve information.
///    entriesCount = A pointer to a variable that specifies the count of structures in the buffer to which <i>penInfo</i> points. If
///                   <b>GetPointerPenInfoHistory</b> succeeds, <i>entriesCount</i> is updated with the total count of structures
///                   available. The total count of structures available is the same as the <i>historyCount</i> field in the
///                   POINTER_PEN_INFO structure returned by a call to GetPointerPenInfo.
///    penInfo = Address of an array of POINTER_PEN_INFO structures to receive the pointer information. This parameter can be NULL
///              if <i>*entriesCount</i> is zero.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerPenInfoHistory(uint pointerId, uint* entriesCount, POINTER_PEN_INFO* penInfo);

///Gets the entire frame of pen-based information for the specified pointers (of type PT_PEN) associated with the
///current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve frame information.
///    pointerCount = A pointer to a variable that specifies the count of structures in the buffer to which penInfo points. If
///                   <b>GetPointerFramePenInfo</b> succeeds, <i>pointerCount</i> is updated with the total count of pointers in the
///                   frame.
///    penInfo = Address of an array of POINTER_PEN_INFO structures to receive the pointer information. This parameter can be NULL
///              if <i>*pointerCount</i> is zero.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerFramePenInfo(uint pointerId, uint* pointerCount, POINTER_PEN_INFO* penInfo);

///Gets the entire frame of pen-based information (including coalesced input frames) for the specified pointers (of type
///PT_PEN) associated with the current message.
///Params:
///    pointerId = The identifier of the pointer for which to retrieve frame information.
///    entriesCount = A pointer to a variable that specifies the count of rows in the two-dimensional array to which penInfo points. If
///                   <b>GetPointerFramePenInfoHistory</b> succeeds, <i>entriesCount</i> is updated with the total count of frames
///                   available in the history.
///    pointerCount = A pointer to a variaable that specifies the count of columns in the two-dimensional array to which penInfo
///                   points. If <b>GetPointerFramePenInfoHistory</b> succeeds, <i>pointerCount</i> is updated with the total count of
///                   pointers in each frame.
///    penInfo = Address of a two-dimensional array of POINTER_PEN_INFO structures to receive the pointer information. This
///              parameter can be NULL if *entriesCount and *pointerCount are both zero. This array is interpreted as
///              POINTER_PEN_INFO[*entriesCount][*pointerCount].
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerFramePenInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, 
                                   POINTER_PEN_INFO* penInfo);

///Determines which pointer input frame generated the most recently retrieved message for the specified pointer and
///discards any queued (unretrieved) pointer input messages generated from the same pointer input frame. If an
///application has retrieved information for an entire frame using the GetPointerFrameInfo function, the
///GetPointerFrameInfoHistory function or one of their type-specific variants, it can use this function to avoid
///retrieving and discarding remaining messages from that frame one by one.
///Params:
///    pointerId = Identifier of the pointer. Pending messages will be skipped for the frame that includes the most recently
///                retrieved input for this pointer.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SkipPointerFrameMessages(uint pointerId);

///Enables the mouse to act as a pointer input device and send WM_POINTER messages.
///Params:
///    fEnable = <b>TRUE</b> to turn on mouse input support in WM_POINTER.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL EnableMouseInPointer(BOOL fEnable);

///Indicates whether EnableMouseInPointer is set for the mouse to act as a pointer input device and send WM_POINTER
///messages.
///Returns:
///    If EnableMouseInPointer is set, the return value is nonzero. If EnableMouseInPointer is not set, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL IsMouseInPointerEnabled();

///Gets one or more transforms for the pointer information coordinates associated with the current message.
///Params:
///    pointerId = An identifier of the pointer for which to retrieve information.
///    historyCount = The number of INPUT_TRANSFORM structures that <i>inputTransform</i> can point to. This value must be no less than
///                   1 and no greater than the value specified in <b>historyCount</b> of the POINTER_INFO structure returned by
///                   GetPointerInfo, GetPointerTouchInfo, or GetPointerPenInfo (for a single input transform) or
///                   GetPointerInfoHistory, GetPointerTouchInfoHistory, or GetPointerPenInfoHistory (for an array of input
///                   transforms). If <b>GetPointerInputTransform</b> succeeds, <i>inputTransform</i> is updated with the total count
///                   of structures available. The total count of structures available is the same as the <b>historyCount</b> field of
///                   the POINTER_INFO structure.
///    inputTransform = Address of an array of INPUT_TRANSFORM structures to receive the transform information. This parameter cannot be
///                     NULL.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL GetPointerInputTransform(uint pointerId, uint historyCount, INPUT_TRANSFORM* inputTransform);


