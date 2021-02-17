// Written in the D programming language.

module windows.touchinput;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : POINTS;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


///The <b>MANIPULATION_PROCESSOR_MANIPULATIONS</b> enumeration different kinds of manipulation which can be applied on a
///target object.
alias MANIPULATION_PROCESSOR_MANIPULATIONS = int;
enum : int
{
    ///Indicates that no manipulations are performed.
    MANIPULATION_NONE        = 0x00000000,
    ///Indicates manipulation by moving the target across the horizontal axis.
    MANIPULATION_TRANSLATE_X = 0x00000001,
    ///Indicates manipulation by moving the target across the vertical axis.
    MANIPULATION_TRANSLATE_Y = 0x00000002,
    ///Indicates manipulation by making the target larger or smaller.
    MANIPULATION_SCALE       = 0x00000004,
    ///Indicates manipulation by rotating the target.
    MANIPULATION_ROTATE      = 0x00000008,
    ///Indicates all manipulations are enabled.
    MANIPULATION_ALL         = 0x0000000f,
}

// Constants


enum float POSITIVE_INFINITY = float.infinity;
enum float NaN = -float.nan;

// Structs


///Encapsulates data for touch input.
struct TOUCHINPUT
{
    ///The x-coordinate (horizontal point) of the touch input. This member is indicated in hundredths of a pixel of
    ///physical screen coordinates.
    int    x;
    ///The y-coordinate (vertical point) of the touch input. This member is indicated in hundredths of a pixel of
    ///physical screen coordinates.
    int    y;
    ///A device handle for the source input device. Each device is given a unique provider at run time by the touch
    ///input provider. See **Examples** section below.
    HANDLE hSource;
    ///A touch point identifier that distinguishes a particular touch input. This value stays consistent in a touch
    ///contact sequence from the point a contact comes down until it comes back up. An ID may be reused later for
    ///subsequent contacts.
    uint   dwID;
    ///A set of bit flags that specify various aspects of touch point press, release, and motion. The bits in this
    ///member can be any reasonable combination of the values in the Remarks section.
    uint   dwFlags;
    ///A set of bit flags that specify which of the optional fields in the structure contain valid values. The
    ///availability of valid information in the optional fields is device-specific. Applications should use an optional
    ///field value only when the corresponding bit is set in <i>dwMask</i>. This field may contain a combination of the
    ///<i>dwMask</i> flags mentioned in the Remarks section.
    uint   dwMask;
    ///The time stamp for the event, in milliseconds. The consuming application should note that the system performs no
    ///validation on this field; when the <b>TOUCHINPUTMASKF_TIMEFROMSYSTEM</b> flag is not set, the accuracy and
    ///sequencing of values in this field are completely dependent on the touch input provider.
    uint   dwTime;
    ///An additional value associated with the touch event.
    size_t dwExtraInfo;
    ///The width of the touch contact area in hundredths of a pixel in physical screen coordinates. This value is only
    ///valid if the <b>dwMask</b> member has the <b>TOUCHEVENTFMASK_CONTACTAREA</b> flag set.
    uint   cxContact;
    ///The height of the touch contact area in hundredths of a pixel in physical screen coordinates. This value is only
    ///valid if the <b>dwMask</b> member has the <b>TOUCHEVENTFMASK_CONTACTAREA</b> flag set.
    uint   cyContact;
}

///Stores information about a gesture.
struct GESTUREINFO
{
    ///The size of the structure, in bytes. The caller must set this to <code>sizeof(GESTUREINFO)</code>.
    uint   cbSize;
    ///The state of the gesture. For additional information, see Remarks.
    uint   dwFlags;
    ///The identifier of the gesture command.
    uint   dwID;
    ///A handle to the window that is targeted by this gesture.
    HWND   hwndTarget;
    ///A <b>POINTS</b> structure containing the coordinates associated with the gesture. These coordinates are always
    ///relative to the origin of the screen.
    POINTS ptsLocation;
    ///An internally used identifier for the structure.
    uint   dwInstanceID;
    ///An internally used identifier for the sequence.
    uint   dwSequenceID;
    ///A 64-bit unsigned integer that contains the arguments for gestures that fit into 8 bytes.
    ulong  ullArguments;
    ///The size, in bytes, of extra arguments that accompany this gesture.
    uint   cbExtraArgs;
}

///When transmitted with WM_GESTURENOTIFY messages, passes information about a gesture.
struct GESTURENOTIFYSTRUCT
{
    ///The size of the structure.
    uint   cbSize;
    ///Reserved for future use.
    uint   dwFlags;
    ///The target window for the gesture notification.
    HWND   hwndTarget;
    ///The location of the gesture in physical screen coordinates.
    POINTS ptsLocation;
    ///A specific gesture instance with gesture messages starting with <b>GID_START</b> and ending with <b>GID_END</b>.
    uint   dwInstanceID;
}

///Gets and sets the configuration for enabling gesture messages and the type of this configuration.
struct GESTURECONFIG
{
    ///The identifier for the type of configuration that will have messages enabled or disabled. For more information,
    ///see Remarks.
    uint dwID;
    ///The messages to enable.
    uint dwWant;
    ///The messages to disable.
    uint dwBlock;
}

// Functions

///Retrieves detailed information about touch inputs associated with a particular touch input handle.
///Params:
///    hTouchInput = The touch input handle received in the <b>LPARAM</b> of a touch message. The function fails with
///                  <b>ERROR_INVALID_HANDLE</b> if this handle is not valid. Note that the handle is not valid after it has been used
///                  in a successful call to CloseTouchInputHandle or after it has been passed to DefWindowProc, PostMessage,
///                  SendMessage or one of their variants.
///    cInputs = The number of structures in the <i>pInputs</i> array. This should ideally be at least equal to the number of
///              touch points associated with the message as indicated in the message <b>WPARAM</b>. If <i>cInputs</i> is less
///              than the number of touch points, the function will still succeed and populate the <i>pInputs</i> buffer with
///              information about <i>cInputs</i> touch points.
///    pInputs = A pointer to an array of TOUCHINPUT structures to receive information about the touch points associated with the
///              specified touch input handle.
///    cbSize = The size, in bytes, of a single TOUCHINPUT structure. If <i>cbSize</i> is not the size of a single
///             <b>TOUCHINPUT</b> structure, the function fails with <b>ERROR_INVALID_PARAMETER</b>.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL GetTouchInputInfo(ptrdiff_t hTouchInput, uint cInputs, char* pInputs, int cbSize);

///Closes a touch input handle, frees process memory associated with it, and invalidates the handle.
///Params:
///    hTouchInput = The touch input handle received in the <b>LPARAM</b> of a touch message. The function fails with
///                  <b>ERROR_INVALID_HANDLE</b> if this handle is not valid. Note that the handle is not valid after it has been used
///                  in a successful call to <b>CloseTouchInputHandle</b> or after it has been passed to DefWindowProc, PostMessage,
///                  SendMessage or one of their variants.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL CloseTouchInputHandle(ptrdiff_t hTouchInput);

///Registers a window as being touch-capable.
///Params:
///    hwnd = The handle of the window being registered. The function fails with <b>ERROR_ACCESS_DENIED</b> if the calling
///           thread does not own the specified window.
///    ulFlags = A set of bit flags that specify optional modifications. This field may contain 0 or one of the following values.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TWF_FINETOUCH"></a><a
///              id="twf_finetouch"></a><dl> <dt><b>TWF_FINETOUCH</b></dt> </dl> </td> <td width="60%"> Specifies that <i>hWnd</i>
///              prefers noncoalesced touch input. </td> </tr> <tr> <td width="40%"><a id="TWF_WANTPALM"></a><a
///              id="twf_wantpalm"></a><dl> <dt><b>TWF_WANTPALM</b></dt> </dl> </td> <td width="60%"> Setting this flag disables
///              palm rejection which reduces delays for getting WM_TOUCH messages. This is useful if you want as quick of a
///              response as possible when a user touches your application. By default, palm detection is enabled and some
///              WM_TOUCH messages are prevented from being sent to your application. This is useful if you do not want to receive
///              <b>WM_TOUCH</b> messages that are from palm contact. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL RegisterTouchWindow(HWND hwnd, uint ulFlags);

///Registers a window as no longer being touch-capable.
///Params:
///    hwnd = The handle of the window. The function fails with <b>ERROR_ACCESS_DENIED</b> if the calling thread does not own
///           the specified window.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL UnregisterTouchWindow(HWND hwnd);

///Checks whether a specified window is touch-capable and, optionally, retrieves the modifier flags set for the window's
///touch capability.
///Params:
///    hwnd = The handle of the window. The function fails with <b>ERROR_ACCESS_DENIED</b> if the calling thread is not on the
///           same desktop as the specified window.
///    pulFlags = The address of the <b>ULONG</b> variable to receive the modifier flags for the specified window's touch
///               capability.
///Returns:
///    Returns <b>TRUE</b> if the window supports Windows Touch; returns <b>FALSE</b> if the window does not support
///    Windows Touch.
///    
@DllImport("USER32")
BOOL IsTouchWindow(HWND hwnd, uint* pulFlags);

///Retrieves a GESTUREINFO structure given a handle to the gesture information.
///Params:
///    hGestureInfo = The gesture information handle.
///    pGestureInfo = A pointer to the gesture information structure.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL GetGestureInfo(ptrdiff_t hGestureInfo, GESTUREINFO* pGestureInfo);

///Retrieves additional information about a gesture from its GESTUREINFO handle.
///Params:
///    hGestureInfo = The handle to the gesture information that is passed in the <i>lParam</i> of a WM_GESTURE message.
///    cbExtraArgs = A count of the bytes of data stored in the extra arguments.
///    pExtraArgs = A pointer to the extra argument information.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL GetGestureExtraArgs(ptrdiff_t hGestureInfo, uint cbExtraArgs, char* pExtraArgs);

///Closes resources associated with a gesture information handle.
///Params:
///    hGestureInfo = The gesture information handle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL CloseGestureInfoHandle(ptrdiff_t hGestureInfo);

///Configures the messages that are sent from a window for Windows Touch gestures.
///Params:
///    hwnd = A handle to the window to set the gesture configuration on.
///    dwReserved = This value is reserved and must be set to 0.
///    cIDs = A count of the gesture configuration structures that are being passed.
///    pGestureConfig = An array of gesture configuration structures that specify the gesture configuration.
///    cbSize = The size of the gesture configuration (GESTURECONFIG) structure.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL SetGestureConfig(HWND hwnd, uint dwReserved, uint cIDs, char* pGestureConfig, uint cbSize);

///Retrieves the configuration for which Windows Touch gesture messages are sent from a window.
///Params:
///    hwnd = A handle to the window to get the gesture configuration from.
///    dwReserved = This value is reserved and must be set to 0.
///    dwFlags = A gesture command flag value indicating options for retrieving the gesture configuration. See Remarks for
///              additional information and supported values.
///    pcIDs = The size, in number of gesture configuration structures, that is in the <i>pGestureConfig</i> buffer.
///    pGestureConfig = An array of gesture configuration structures that specify the gesture configuration.
///    cbSize = The size of the gesture configuration (GESTURECONFIG) structure.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("USER32")
BOOL GetGestureConfig(HWND hwnd, uint dwReserved, uint dwFlags, uint* pcIDs, char* pGestureConfig, uint cbSize);


// Interfaces

@GUID("ABB27087-4CE0-4E58-A0CB-E24DF96814BE")
struct InertiaProcessor;

@GUID("597D4FB0-47FD-4AFF-89B9-C6CFAE8CF08E")
struct ManipulationProcessor;

///Handles manipulation and inertia events.
@GUID("4F62C8DA-9C53-4B22-93DF-927A862BBB03")
interface _IManipulationEvents : IUnknown
{
    HRESULT ManipulationStarted(float x, float y);
    HRESULT ManipulationDelta(float x, float y, float translationDeltaX, float translationDeltaY, float scaleDelta, 
                              float expansionDelta, float rotationDelta, float cumulativeTranslationX, 
                              float cumulativeTranslationY, float cumulativeScale, float cumulativeExpansion, 
                              float cumulativeRotation);
    HRESULT ManipulationCompleted(float x, float y, float cumulativeTranslationX, float cumulativeTranslationY, 
                                  float cumulativeScale, float cumulativeExpansion, float cumulativeRotation);
}

///The IInertiaProcessor interface handles calculations regarding object motion for Windows Touch.
@GUID("18B00C6D-C5EE-41B1-90A9-9D4A929095AD")
interface IInertiaProcessor : IUnknown
{
    ///The <b>InitialOriginX</b> property specifies the starting horizontal location for a target with inertia. This
    ///property is read/write.
    HRESULT get_InitialOriginX(float* x);
    ///The <b>InitialOriginX</b> property specifies the starting horizontal location for a target with inertia. This
    ///property is read/write.
    HRESULT put_InitialOriginX(float x);
    ///The <b>InitialOriginY</b> property specifies the starting vertical location for a target with inertia. This
    ///property is read/write.
    HRESULT get_InitialOriginY(float* y);
    ///The <b>InitialOriginY</b> property specifies the starting vertical location for a target with inertia. This
    ///property is read/write.
    HRESULT put_InitialOriginY(float y);
    ///The <b>InitialVelocityX</b> property specifies the initial movement of the target object on the horizontal axis.
    ///This property is read/write.
    HRESULT get_InitialVelocityX(float* x);
    ///The <b>InitialVelocityX</b> property specifies the initial movement of the target object on the horizontal axis.
    ///This property is read/write.
    HRESULT put_InitialVelocityX(float x);
    ///The <b>InitialVelocityY</b> property specifies the initial movement of the target object on the vertical axis.
    ///This property is read/write.
    HRESULT get_InitialVelocityY(float* y);
    ///The <b>InitialVelocityY</b> property specifies the initial movement of the target object on the vertical axis.
    ///This property is read/write.
    HRESULT put_InitialVelocityY(float y);
    ///The <b>InitialAngularVelocity</b> property specifies the rotational (angular) velocity of the target when
    ///movement begins. This property is read/write.
    HRESULT get_InitialAngularVelocity(float* velocity);
    ///The <b>InitialAngularVelocity</b> property specifies the rotational (angular) velocity of the target when
    ///movement begins. This property is read/write.
    HRESULT put_InitialAngularVelocity(float velocity);
    ///The <b>InitialExpansionVelocity</b> property specifies the rate of radius expansion for a target when the target
    ///was affected by inertia. This property is read/write.
    HRESULT get_InitialExpansionVelocity(float* velocity);
    ///The <b>InitialExpansionVelocity</b> property specifies the rate of radius expansion for a target when the target
    ///was affected by inertia. This property is read/write.
    HRESULT put_InitialExpansionVelocity(float velocity);
    ///The <b>InitialRadius</b> property specifies the distance from the edge of the target to its center before the
    ///object was changed. This property is read/write.
    HRESULT get_InitialRadius(float* radius);
    ///The <b>InitialRadius</b> property specifies the distance from the edge of the target to its center before the
    ///object was changed. This property is read/write.
    HRESULT put_InitialRadius(float radius);
    ///The <b>BoundaryLeft</b> property limits how far towards the left of the screen the target object can move. This
    ///property is read/write.
    HRESULT get_BoundaryLeft(float* left);
    ///The <b>BoundaryLeft</b> property limits how far towards the left of the screen the target object can move. This
    ///property is read/write.
    HRESULT put_BoundaryLeft(float left);
    ///The <b>BoundaryTop</b> property limits how far towards the top of the screen the target object can move. This
    ///property is read/write.
    HRESULT get_BoundaryTop(float* top);
    ///The <b>BoundaryTop</b> property limits how far towards the top of the screen the target object can move. This
    ///property is read/write.
    HRESULT put_BoundaryTop(float top);
    ///The <b>BoundaryRight</b> property limits how far towards the right of the screen the target object can move. This
    ///property is read/write.
    HRESULT get_BoundaryRight(float* right);
    ///The <b>BoundaryRight</b> property limits how far towards the right of the screen the target object can move. This
    ///property is read/write.
    HRESULT put_BoundaryRight(float right);
    ///The <b>BoundaryBottom</b> property limits how far towards the bottom of the screen the target object can move.
    ///This property is read/write.
    HRESULT get_BoundaryBottom(float* bottom);
    ///The <b>BoundaryBottom</b> property limits how far towards the bottom of the screen the target object can move.
    ///This property is read/write.
    HRESULT put_BoundaryBottom(float bottom);
    ///The <b>ElasticMarginLeft</b> property specifies the leftmost region for bouncing the target object. This property
    ///is read/write.
    HRESULT get_ElasticMarginLeft(float* left);
    ///The <b>ElasticMarginLeft</b> property specifies the leftmost region for bouncing the target object. This property
    ///is read/write.
    HRESULT put_ElasticMarginLeft(float left);
    ///The <b>ElasticMarginTop</b> property specifies the topmost region for bouncing the target object. This property
    ///is read/write.
    HRESULT get_ElasticMarginTop(float* top);
    ///The <b>ElasticMarginTop</b> property specifies the topmost region for bouncing the target object. This property
    ///is read/write.
    HRESULT put_ElasticMarginTop(float top);
    ///The <b>ElasticMarginRight</b> property specifies the rightmost region for bouncing the target object. This
    ///property is read/write.
    HRESULT get_ElasticMarginRight(float* right);
    ///The <b>ElasticMarginRight</b> property specifies the rightmost region for bouncing the target object. This
    ///property is read/write.
    HRESULT put_ElasticMarginRight(float right);
    ///The <b>ElasticMarginBottom</b> property specifies the bottom region for bouncing the target object. This property
    ///is read/write.
    HRESULT get_ElasticMarginBottom(float* bottom);
    ///The <b>ElasticMarginBottom</b> property specifies the bottom region for bouncing the target object. This property
    ///is read/write.
    HRESULT put_ElasticMarginBottom(float bottom);
    ///The <b>DesiredDisplacement</b> property specifies the desired distance that the object will travel. This property
    ///is read/write.
    HRESULT get_DesiredDisplacement(float* displacement);
    ///The <b>DesiredDisplacement</b> property specifies the desired distance that the object will travel. This property
    ///is read/write.
    HRESULT put_DesiredDisplacement(float displacement);
    ///The DesiredRotation property specifies how far the current inertia processor object should manipulate the target
    ///object in radians. This property is read/write.
    HRESULT get_DesiredRotation(float* rotation);
    ///The DesiredRotation property specifies how far the current inertia processor object should manipulate the target
    ///object in radians. This property is read/write.
    HRESULT put_DesiredRotation(float rotation);
    ///The <b>DesiredExpansion</b> property specifies the desired change in the object's average radius. This property
    ///is read/write.
    HRESULT get_DesiredExpansion(float* expansion);
    ///The <b>DesiredExpansion</b> property specifies the desired change in the object's average radius. This property
    ///is read/write.
    HRESULT put_DesiredExpansion(float expansion);
    ///The <b>DesiredDeceleration</b> property specifies the desired rate at which translation operations will
    ///decelerate. This property is read/write.
    HRESULT get_DesiredDeceleration(float* deceleration);
    ///The <b>DesiredDeceleration</b> property specifies the desired rate at which translation operations will
    ///decelerate. This property is read/write.
    HRESULT put_DesiredDeceleration(float deceleration);
    ///The <b>DesiredAngularDeceleration</b> property specifies the desired rate that the target object will stop
    ///spinning in radians per msec squared. This property is read/write.
    HRESULT get_DesiredAngularDeceleration(float* deceleration);
    ///The <b>DesiredAngularDeceleration</b> property specifies the desired rate that the target object will stop
    ///spinning in radians per msec squared. This property is read/write.
    HRESULT put_DesiredAngularDeceleration(float deceleration);
    ///The <b>DesiredExpansionDeceleration</b> property specifies the rate at which the object will stop expanding. This
    ///property is read/write.
    HRESULT get_DesiredExpansionDeceleration(float* deceleration);
    ///The <b>DesiredExpansionDeceleration</b> property specifies the rate at which the object will stop expanding. This
    ///property is read/write.
    HRESULT put_DesiredExpansionDeceleration(float deceleration);
    ///The <b>InitialTimestamp</b> property specifies the starting time stamp for a target object with inertia. This
    ///property is read/write.
    HRESULT get_InitialTimestamp(uint* timestamp);
    ///The <b>InitialTimestamp</b> property specifies the starting time stamp for a target object with inertia. This
    ///property is read/write.
    HRESULT put_InitialTimestamp(uint timestamp);
    ///The <b>Reset</b> method initializes the processor with initial timestamp and restarts inertia.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT Reset();
    ///The <b>Process</b> method performs calculations and can raise the <b>Started</b>, <b>Delta</b>, or
    ///<b>Completed</b> event depending on whether extrapolation is completed or not. If extrapolation finished at the
    ///previous tick, the method is no-op.
    ///Params:
    ///    completed = Indicates whether an operation was performed. A value of false indicates extrapolation was finished at a
    ///                previous tick and the operation was a no-op.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT Process(int* completed);
    ///The <b>ProcessTime</b> method performs calculations for the given tick and can raise the <b>Started</b>,
    ///<b>Delta</b>, or <b>Completed</b> event depending on whether extrapolation is completed or not. If extrapolation
    ///finished at the previous tick, the method is no-op.
    ///Params:
    ///    timestamp = A parameter that contains a timestamp (in millisecs) to process.
    ///    completed = Indicates whether an operation was performed. A value of false indicates extrapolation was finished at a
    ///                previous tick and the operation was a no-op.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT ProcessTime(uint timestamp, int* completed);
    ///The <b>Complete</b> method finishes the current manipulation and stops inertia on the inertia processor.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT Complete();
    ///Finishes the current manipulation at the given tick, stops inertia on the inertia processor, and raises the
    ///ManipulationCompleted event.
    ///Params:
    ///    timestamp = A parameter containing a timestamp (in milliseconds) to process.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT CompleteTime(uint timestamp);
}

///The IManipulationProcessor provides functionality for monitoring and responding to multitouch input.
@GUID("A22AC519-8300-48A0-BEF4-F1BE8737DBA4")
interface IManipulationProcessor : IUnknown
{
    ///The <b>SupportedManipulations</b> property is used to indicate which manipulations are supported by an object.
    ///This property is read/write.
    HRESULT get_SupportedManipulations(MANIPULATION_PROCESSOR_MANIPULATIONS* manipulations);
    ///The <b>SupportedManipulations</b> property is used to indicate which manipulations are supported by an object.
    ///This property is read/write.
    HRESULT put_SupportedManipulations(MANIPULATION_PROCESSOR_MANIPULATIONS manipulations);
    ///The <b>PivotPointX</b> property is the horizontal center of the object. This property is read/write.
    HRESULT get_PivotPointX(float* pivotPointX);
    ///The <b>PivotPointX</b> property is the horizontal center of the object. This property is read/write.
    HRESULT put_PivotPointX(float pivotPointX);
    ///The <b>PivotPointY</b> property is the vertical center of the object. This property is read/write.
    HRESULT get_PivotPointY(float* pivotPointY);
    ///The <b>PivotPointY</b> property is the vertical center of the object. This property is read/write.
    HRESULT put_PivotPointY(float pivotPointY);
    ///The <b>PivotRadius</b> property is used to determine how much rotation is used in single finger manipulation.
    ///This property is read/write.
    HRESULT get_PivotRadius(float* pivotRadius);
    ///The <b>PivotRadius</b> property is used to determine how much rotation is used in single finger manipulation.
    ///This property is read/write.
    HRESULT put_PivotRadius(float pivotRadius);
    ///The <b>CompleteManipulation</b> method is called when the developer chooses to end the manipulation.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT CompleteManipulation();
    ///The <b>ProcessDown</b> method feeds touch down data to the manipulation processor associated with a target.
    ///Params:
    ///    manipulatorId = The identifier for the touch contact that you want to process.
    ///    x = The horizontal coordinate data associated with the target.
    ///    y = The vertical coordinate data associated with the target.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT ProcessDown(uint manipulatorId, float x, float y);
    ///The <b>ProcessMove</b> method feeds movement data for the target object to its manipulation processor.
    ///Params:
    ///    manipulatorId = The identifier for the touch contact that you want to process.
    ///    x = The horizontal coordinate data associated with the target.
    ///    y = The vertical coordinate data associated with the target.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT ProcessMove(uint manipulatorId, float x, float y);
    ///The <b>ProcessUp</b> method feeds data to a target's manipulation processor for touch up sequences.
    ///Params:
    ///    manipulatorId = The identifier for the touch contact that you want to process.
    ///    x = The horizontal coordinate data associated with the target.
    ///    y = The vertical coordinate data associated with the target.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT ProcessUp(uint manipulatorId, float x, float y);
    ///Feeds touch down data, including a timestamp, to the manipulation processor associated with a target.
    ///Params:
    ///    manipulatorId = The identifier for the touch contact to be processed.
    ///    x = The horizontal coordinate data associated with the target.
    ///    y = The vertical coordinate data associated with the target.
    ///    timestamp = The time of the data event.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an HRESULT error code such as <b>E_FAIL</b>.
    ///    
    HRESULT ProcessDownWithTime(uint manipulatorId, float x, float y, uint timestamp);
    ///Feeds movement data, including a time stamp, for the target object to its manipulation processor.
    ///Params:
    ///    manipulatorId = The identifier for the touch contact to be processed.
    ///    x = The horizontal coordinate data associated with the target.
    ///    y = The vertical coordinate data associated with the target.
    ///    timestamp = The time of the data event.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an HRESULT error code such as <b>E_FAIL</b>.
    ///    
    HRESULT ProcessMoveWithTime(uint manipulatorId, float x, float y, uint timestamp);
    ///Feeds data, including a timestamp, to a target's manipulation processor for touch-up sequences.
    ///Params:
    ///    manipulatorId = The identifier for the touch contact to be processed.
    ///    x = The horizontal coordinate data associated with the target.
    ///    y = The vertical coordinate data associated with the target.
    ///    timestamp = The time of the data event.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an HRESULT error code such as <b>E_FAIL</b>.
    ///    
    HRESULT ProcessUpWithTime(uint manipulatorId, float x, float y, uint timestamp);
    ///Calculates and returns the horizontal velocity for the target object.
    ///Params:
    ///    velocityX = The calculated horizontal velocity.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an HRESULT error code such as <b>E_FAIL</b>.
    ///    
    HRESULT GetVelocityX(float* velocityX);
    ///Calculates and returns the vertical velocity.
    ///Params:
    ///    velocityY = The calculated vertical velocity.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an HRESULT error code such as <b>E_FAIL</b>.
    ///    
    HRESULT GetVelocityY(float* velocityY);
    ///The <b>GetExpansionVelocity</b> method calculates the rate that the target object is expanding at.
    ///Params:
    ///    expansionVelocity = The rate of expansion.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT GetExpansionVelocity(float* expansionVelocity);
    ///The <b>GetAngularVelocity</b> method calculates the rotational velocity that the target object is moving at.
    ///Params:
    ///    angularVelocity = The calculated rotational velocity.
    ///Returns:
    ///    Returns <b>S_OK</b> on success, otherwise returns an error code such as <b>E_FAIL</b>.
    ///    
    HRESULT GetAngularVelocity(float* angularVelocity);
    ///Specifies how large the distance contacts on a scale or rotate gesture need to be to trigger manipulation. This
    ///property is read/write.
    HRESULT get_MinimumScaleRotateRadius(float* minRadius);
    ///Specifies how large the distance contacts on a scale or rotate gesture need to be to trigger manipulation. This
    ///property is read/write.
    HRESULT put_MinimumScaleRotateRadius(float minRadius);
}


// GUIDs

const GUID CLSID_InertiaProcessor      = GUIDOF!InertiaProcessor;
const GUID CLSID_ManipulationProcessor = GUIDOF!ManipulationProcessor;

const GUID IID_IInertiaProcessor      = GUIDOF!IInertiaProcessor;
const GUID IID_IManipulationProcessor = GUIDOF!IManipulationProcessor;
const GUID IID__IManipulationEvents   = GUIDOF!_IManipulationEvents;
