// Written in the D programming language.

module windows.directmanipulation;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND, MSG;

extern(Windows) @nogc nothrow:


// Enums


///Defines the possible states of Direct Manipulation. The viewport can process input in any state unless otherwise
///noted.
alias DIRECTMANIPULATION_STATUS = int;
enum : int
{
    ///The viewport is being initialized and is not yet able to process input.
    DIRECTMANIPULATION_BUILDING  = 0x00000000,
    ///The viewport was successfully enabled.
    DIRECTMANIPULATION_ENABLED   = 0x00000001,
    ///The viewport is disabled and cannot process input or callbacks. The viewport can be enabled by calling Enable.
    DIRECTMANIPULATION_DISABLED  = 0x00000002,
    ///The viewport is currently processing input and updating content.
    DIRECTMANIPULATION_RUNNING   = 0x00000003,
    ///The viewport is moving content due to inertia.
    DIRECTMANIPULATION_INERTIA   = 0x00000004,
    ///The viewport has completed the previous interaction.
    DIRECTMANIPULATION_READY     = 0x00000005,
    ///The transient state of the viewport when input has been promoted to an ancestor in the SetContact chain.
    DIRECTMANIPULATION_SUSPENDED = 0x00000006,
}

///Defines how hit testing is handled by Direct Manipulation when using a dedicated hit-test thread registered through
///RegisterHitTestTarget.
alias DIRECTMANIPULATION_HITTEST_TYPE = int;
enum : int
{
    ///The hit-test thread receives WM_POINTERDOWN messages and specifies whether to call SetContact. If
    ///<b>SetContact</b> is not called, the contact will not be associated with a viewport.
    DIRECTMANIPULATION_HITTEST_TYPE_ASYNCHRONOUS     = 0x00000000,
    ///The UI thread always receives WM_POINTERDOWN messages after the hit-test thread. A call to SetContact is not
    ///required.
    DIRECTMANIPULATION_HITTEST_TYPE_SYNCHRONOUS      = 0x00000001,
    ///The UI thread receives WM_POINTERDOWN messages only when SetContact isn't called by the hit-test thread.
    DIRECTMANIPULATION_HITTEST_TYPE_AUTO_SYNCHRONOUS = 0x00000002,
}

///Defines the interaction configuration states available in Direct Manipulation.
alias DIRECTMANIPULATION_CONFIGURATION = int;
enum : int
{
    ///No interaction is defined.
    DIRECTMANIPULATION_CONFIGURATION_NONE                = 0x00000000,
    ///An interaction is defined. To enable interactions, this value must be included. Required when setting a
    ///configuration other than <b>DIRECTMANIPULATION_CONFIGURATION_NONE</b>.
    DIRECTMANIPULATION_CONFIGURATION_INTERACTION         = 0x00000001,
    ///Translation in the horizontal axis.
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_X       = 0x00000002,
    ///Translation in the vertical axis.
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_Y       = 0x00000004,
    ///Zoom.
    DIRECTMANIPULATION_CONFIGURATION_SCALING             = 0x00000010,
    ///Inertia for translation as defined by <b>DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_X</b> and
    ///<b>DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_Y</b>.
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_INERTIA = 0x00000020,
    ///Inertia for zoom as defined by <b>DIRECTMANIPULATION_CONFIGURATION _SCALING</b>.
    DIRECTMANIPULATION_CONFIGURATION_SCALING_INERTIA     = 0x00000080,
    ///Rails on the horizontal axis.
    DIRECTMANIPULATION_CONFIGURATION_RAILS_X             = 0x00000100,
    ///Rails on the vertical axis.
    DIRECTMANIPULATION_CONFIGURATION_RAILS_Y             = 0x00000200,
}

///Defines the gestures that can be passed to SetManualGesture.
alias DIRECTMANIPULATION_GESTURE_CONFIGURATION = int;
enum : int
{
    ///No gestures are defined.
    DIRECTMANIPULATION_GESTURE_NONE                   = 0x00000000,
    ///Only default gestures are supported. This is the default value.
    DIRECTMANIPULATION_GESTURE_DEFAULT                = 0x00000000,
    ///Vertical slide and swipe gestures are supported through the cross-slide interaction. For more information, see
    ///Guidelines for cross-slide.
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_VERTICAL   = 0x00000008,
    ///Horizontal slide and swipe gestures are supported through the cross-slide interaction. For more information, see
    ///Guidelines for cross-slide.
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_HORIZONTAL = 0x00000010,
    ///Pinch and stretch gestures for zooming.
    DIRECTMANIPULATION_GESTURE_PINCH_ZOOM             = 0x00000020,
}

///Defines the Direct Manipulation motion type.
alias DIRECTMANIPULATION_MOTION_TYPES = int;
enum : int
{
    ///None.
    DIRECTMANIPULATION_MOTION_NONE       = 0x00000000,
    ///Translation in the horizontal axis.
    DIRECTMANIPULATION_MOTION_TRANSLATEX = 0x00000001,
    ///Translation in the vertical axis.
    DIRECTMANIPULATION_MOTION_TRANSLATEY = 0x00000002,
    ///Zoom.
    DIRECTMANIPULATION_MOTION_ZOOM       = 0x00000004,
    ///The horizontal center of the manipulation.
    DIRECTMANIPULATION_MOTION_CENTERX    = 0x00000010,
    ///The vertical center of the manipulation.
    DIRECTMANIPULATION_MOTION_CENTERY    = 0x00000020,
    ///All manipulation motion.
    DIRECTMANIPULATION_MOTION_ALL        = 0x00000037,
}

///Defines the input behavior options for the viewport.
alias DIRECTMANIPULATION_VIEWPORT_OPTIONS = int;
enum : int
{
    ///No special behaviors. This is the default value used to set or revert to default behavior.
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DEFAULT              = 0x00000000,
    ///At the end of an interaction, the viewport transitions to DIRECTMANIPULATION_READY and then immediately to
    ///<b>DIRECTMANIPULATION_DISABLED</b>. The viewport must be explicitly enabled through the Enable method before the
    ///next interaction can be processed.
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_AUTODISABLE          = 0x00000001,
    ///Update must be called to redraw the content within the viewport. The content is not updated automatically during
    ///an input event.
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_MANUALUPDATE         = 0x00000002,
    ///All input from a contact associated with the viewport is passed to the UI thread for processing.
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_INPUT                = 0x00000004,
    ///If set, all WM_POINTERDOWN messages are passed to the application for hit testing. Otherwise, Direct Manipulation
    ///will process the messages for hit testing against the existing list of running viewports, and the application
    ///will not see the input. Applies only when viewport state is DIRECTMANIPULATION_RUNNING or
    ///<b>DIRECTMANIPULATION_INERTIA</b>.
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_EXPLICITHITTEST      = 0x00000008,
    ///Specifies that pixel snapping during a manipulation is disabled. Anti-aliasing can create irregular edge
    ///rendering. Artifacts, commonly seen as blurry, or semi-transparent, edges can occur when the location of an edge
    ///falls in the middle of a device pixel rather than between device pixels.
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DISABLEPIXELSNAPPING = 0x00000010,
}

///Modifies how the final inertia end position is calculated.
alias DIRECTMANIPULATION_SNAPPOINT_TYPE = int;
enum : int
{
    ///Content always stops at the snap point closest to where inertia would naturally stop along the direction of
    ///inertia.
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY        = 0x00000000,
    ///Content stops at a snap point closest to where inertia would naturally stop along the direction of inertia,
    ///depending on how close the snap point is.
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL         = 0x00000001,
    ///Content always stops at the snap point closest to the release point along the direction of inertia.
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY_SINGLE = 0x00000002,
    ///Content stops at the next snap point, if the motion starts far from it.
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL_SINGLE  = 0x00000003,
}

///Defines the coordinate system for a collection of snap points.
alias DIRECTMANIPULATION_SNAPPOINT_COORDINATE = int;
enum : int
{
    ///Default. Snap points are specified relative to the top and left boundaries of the content unless
    ///<b>DIRECTMANIPULATION_COORDINATE_MIRRORED</b> is also specified, in which case they are relative to the bottom
    ///and right boundaries of the content. For zoom, the boundary is 1.0f.
    DIRECTMANIPULATION_COORDINATE_BOUNDARY = 0x00000000,
    ///Snap points are specified relative to the origin of the viewport.
    DIRECTMANIPULATION_COORDINATE_ORIGIN   = 0x00000001,
    ///Snap points are interpreted as specified in the negative direction of the origin. The origin is shifted to the
    ///bottom and right of the viewport or content. Cannot be set for zoom.
    DIRECTMANIPULATION_COORDINATE_MIRRORED = 0x00000010,
}

///Defines the horizontal alignment options for content within a viewport.
alias DIRECTMANIPULATION_HORIZONTALALIGNMENT = int;
enum : int
{
    ///No alignment. The object can be positioned anywhere within the viewport.
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_NONE         = 0x00000000,
    ///Align object along the left side of the viewport.
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_LEFT         = 0x00000001,
    ///Align object to the center of the viewport.
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_CENTER       = 0x00000002,
    ///Align object along the right side of the viewport.
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_RIGHT        = 0x00000004,
    ///Content zooms around the center point of the contacts, instead of being locked with the horizontal alignment.
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_UNLOCKCENTER = 0x00000008,
}

///Defines the vertical alignment settings for content within the viewport.
alias DIRECTMANIPULATION_VERTICALALIGNMENT = int;
enum : int
{
    ///No alignment. The object can be positioned anywhere within the viewport.
    DIRECTMANIPULATION_VERTICALALIGNMENT_NONE         = 0x00000000,
    ///Align object along the top of the viewport.
    DIRECTMANIPULATION_VERTICALALIGNMENT_TOP          = 0x00000001,
    ///Align object to the center of the viewport.
    DIRECTMANIPULATION_VERTICALALIGNMENT_CENTER       = 0x00000002,
    ///Align object along the bottom of the viewport.
    DIRECTMANIPULATION_VERTICALALIGNMENT_BOTTOM       = 0x00000004,
    ///Content zooms around the center point of the contacts, instead of being locked with the vertical alignment.
    DIRECTMANIPULATION_VERTICALALIGNMENT_UNLOCKCENTER = 0x00000008,
}

///Defines the threading behavior for SetInputMode or SetUpdateMode. The exact meaning of each constant depends on the
///method called.
alias DIRECTMANIPULATION_INPUT_MODE = int;
enum : int
{
    ///Input is automatically passed to the viewport in an independent thread.
    DIRECTMANIPULATION_INPUT_MODE_AUTOMATIC = 0x00000000,
    ///Input is manually passed by the app on its thread via the ProcessInput method.
    DIRECTMANIPULATION_INPUT_MODE_MANUAL    = 0x00000001,
}

///Defines the drag-and-drop interaction states for the viewport.
alias DIRECTMANIPULATION_DRAG_DROP_STATUS = int;
enum : int
{
    ///The viewport is at rest and ready for input.
    DIRECTMANIPULATION_DRAG_DROP_READY     = 0x00000000,
    ///The viewport is updating its content and the content is not selected.
    DIRECTMANIPULATION_DRAG_DROP_PRESELECT = 0x00000001,
    ///The viewport is updating its content and the content is selected.
    DIRECTMANIPULATION_DRAG_DROP_SELECTING = 0x00000002,
    ///The viewport is updating its content and the content is being dragged.
    DIRECTMANIPULATION_DRAG_DROP_DRAGGING  = 0x00000003,
    ///The viewport has concluded the interaction and requests a revert.
    DIRECTMANIPULATION_DRAG_DROP_CANCELLED = 0x00000004,
    ///The viewport has concluded the interaction and requests a commit.
    DIRECTMANIPULATION_DRAG_DROP_COMMITTED = 0x00000005,
}

///Defines behaviors for the drag-drop interaction.
alias DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION = int;
enum : int
{
    ///Specifies that vertical movement is applicable to the chosen gesture.
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_VERTICAL    = 0x00000001,
    ///Specifies that horizontal movement is applicable to the chosen gesture.
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HORIZONTAL  = 0x00000002,
    ///Specifies that the gesture is to be cross-slide only.
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_ONLY = 0x00000010,
    ///Specifies that the gesture is a drag initiated by cross-slide.
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_DRAG = 0x00000020,
    ///Specifies that the gesture a drag initiated by press-and-hold.
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HOLD_DRAG   = 0x00000040,
}

///Defines gestures recognized by Direct Manipulation.
alias DIRECTMANIPULATION_INTERACTION_TYPE = int;
enum : int
{
    ///Marks the beginning of an interaction.
    DIRECTMANIPULATION_INTERACTION_BEGIN                    = 0x00000000,
    ///A compound gesture that supports translation, rotation and scaling.
    DIRECTMANIPULATION_INTERACTION_TYPE_MANIPULATION        = 0x00000001,
    ///A tap gesture.
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_TAP         = 0x00000002,
    ///A hold gesture.
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_HOLD        = 0x00000003,
    ///Select or move through slide or swipe gestures.
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_CROSS_SLIDE = 0x00000004,
    ///A zoom gesture.
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_PINCH_ZOOM  = 0x00000005,
    ///Marks the end of an interaction.
    DIRECTMANIPULATION_INTERACTION_END                      = 0x00000064,
}

///Determines the type and direction of automatic scrolling animation to apply.
alias DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION = int;
enum : int
{
    ///If content is scrolling, slowly stop along the direction of the motion.
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_STOP    = 0x00000000,
    ///Scroll towards the positive boundary of the content.
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_FORWARD = 0x00000001,
    ///Scroll towards the origin of the content.
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_REVERSE = 0x00000002,
}

// Interfaces

@GUID("34E211B6-3650-4F75-8334-FA359598E1C5")
struct DirectManipulationViewport;

@GUID("9FC1BFD5-1835-441A-B3B1-B6CC74B727D0")
struct DirectManipulationUpdateManager;

@GUID("CAA02661-D59E-41C7-8393-3BA3BACB6B57")
struct DirectManipulationPrimaryContent;

@GUID("54E211B6-3650-4F75-8334-FA359598E1C5")
struct DirectManipulationManager;

@GUID("99793286-77CC-4B57-96DB-3B354F6F9FB5")
struct DirectManipulationSharedManager;

@GUID("79DEA627-A08A-43AC-8EF5-6900B9299126")
struct DCompManipulationCompositor;

///Provides access to all the Direct Manipulation features and APIs available to the client application. This is the
///first COM object (the object factory) created by the application to retrieve other COM objects in the Direct
///Manipulation API surface. It also serves to activate and deactivate Direct Manipulation functionality on a per-HWND
///basis.
@GUID("FBF5D3B4-70C7-4163-9322-5A6F660D6FBC")
interface IDirectManipulationManager : IUnknown
{
    ///Activates Direct Manipulation for processing input and handling callbacks on the specified window.
    ///Params:
    ///    window = The window in which to activate Direct Manipulation.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Activate(HWND window);
    ///Deactivates Direct Manipulation for processing input and handling callbacks on the specified window.
    ///Params:
    ///    window = The window in which to deactivate input.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Deactivate(HWND window);
    ///Registers a dedicated thread for hit testing.
    ///Params:
    ///    window = The handle of the main app window (typically created from the UI thread).
    ///    hitTestWindow = The handle of the window in which hit testing is registered (should be created from the hit testing thread).
    ///                    Pass in nullptr to unregister a previously registered hit-test target.
    ///    type = One of the values from DIRECTMANIPULATION_HITTEST_TYPE. Specifies whether the UI window or the hit testing
    ///           window (or both) receives the hit testing WM_POINTERDOWN message , and in what order.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RegisterHitTestTarget(HWND window, HWND hitTestWindow, DIRECTMANIPULATION_HITTEST_TYPE type);
    ///Passes keyboard and mouse messages to the manipulation manager on the app's UI thread.
    ///Params:
    ///    message = The input message to process.
    ///    handled = <b>TRUE</b> if no further processing should be done with this message; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ProcessInput(const(MSG)* message, BOOL* handled);
    ///Gets a pointer to an IDirectManipulationUpdateManager object that receives compositor updates.
    ///Params:
    ///    riid = IID to the interface.
    ///    object = Pointer to the new IDirectManipulationUpdateManager object.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetUpdateManager(const(GUID)* riid, void** object);
    ///The factory method that is used to create a new IDirectManipulationViewport object. The viewport manages the
    ///interaction state and mapping of input to output actions.
    ///Params:
    ///    frameInfo = The frame info provider for the viewport.
    ///    window = The handle of the main app window to associate with the viewport.
    ///    riid = IID to the interface.
    ///    object = The new IDirectManipulationViewport object.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CreateViewport(IDirectManipulationFrameInfoProvider frameInfo, HWND window, const(GUID)* riid, 
                           void** object);
    ///The factory method that is used to create an instance of secondary content (such as a panning indicator) inside a
    ///viewport.
    ///Params:
    ///    frameInfo = The frame info provider for the secondary content. This should match the frame info provider used to create
    ///                the viewport.
    ///    clsid = Class identifier (CLSID) of the secondary content. This ID specifies the content type.
    ///    riid = IID of the interface.
    ///    object = The secondary content object that implements the specified interface.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CreateContent(IDirectManipulationFrameInfoProvider frameInfo, const(GUID)* clsid, const(GUID)* riid, 
                          void** object);
}

///Extends the IDirectManipulationManager interface that provides access to all the Direct Manipulation features and
///APIs available to the client application. The <b>IDirectManipulationManager2</b> interface adds support for
///configuration behaviors that can be attached to a viewport. <div class="alert"><b>Note</b> To obtain an
///<b>IDirectManipulationManager2</b> interface pointer, QueryInterface on an existing IDirectManipulationManager
///interface pointer. </div><div> </div>
@GUID("FA1005E9-3D16-484C-BFC9-62B61E56EC4E")
interface IDirectManipulationManager2 : IDirectManipulationManager
{
    ///Factory method to create a behavior.
    ///Params:
    ///    clsid = CLSID of the behavior. The CLSID specifies the type of behavior.
    ///    riid = The IID of the behavior interface to create.
    ///    object = The new behavior object that implements the specified interface.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CreateBehavior(const(GUID)* clsid, const(GUID)* riid, void** object);
}

///Extends the IDirectManipulationManager2 interface that provides access to all the Direct Manipulation features and
///APIs available to the client application. The <b>IDirectManipulationManager3</b> interface adds support for
///retrieving an IDirectManipulationDeferContactService object. <div class="alert"><b>Note</b> To obtain an
///<b>IDirectManipulationManager3</b> interface pointer, QueryInterface on an existing IDirectManipulationManager
///interface pointer. </div><div> </div>
@GUID("2CB6B33D-FFE8-488C-B750-FBDFE88DCA8C")
interface IDirectManipulationManager3 : IDirectManipulationManager2
{
    ///Retrieves an IDirectManipulationDeferContactService object.
    ///Params:
    ///    clsid = The IDirectManipulationDeferContactService CLSID.
    ///    riid = The IID of the IDirectManipulationDeferContactService to retrieve.
    ///    object = The IDirectManipulationDeferContactService object.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetService(const(GUID)* clsid, const(GUID)* riid, void** object);
}

///Defines a region within a window (referred to as a viewport) that is able to receive and process input from user
///interactions. The viewport contains content that moves in response to a user interaction.
@GUID("28B85A3D-60A0-48BD-9BA1-5CE8D9EA3A6D")
interface IDirectManipulationViewport : IUnknown
{
    ///Starts or resumes input processing by the viewport.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>, or <b>S_FALSE</b> if there is no work to do (for example, the
    ///    viewport is already enabled). Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Enable();
    ///Stops input processing by the viewport.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Disable();
    ///Specifies an association between a contact and the viewport.
    ///Params:
    ///    pointerId = The ID of the pointer.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContact(uint pointerId);
    ///Removes a contact that is associated with a viewport.
    ///Params:
    ///    pointerId = The ID of the pointer.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ReleaseContact(uint pointerId);
    ///Removes all contacts that are associated with the viewport. Inertia is started if the viewport supports inertia.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ReleaseAllContacts();
    ///Gets the state of the viewport.
    ///Params:
    ///    status = One of the values from DIRECTMANIPULATION_STATUS.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetStatus(DIRECTMANIPULATION_STATUS* status);
    ///Gets the tag value of a viewport.
    ///Params:
    ///    riid = IID to the interface.
    ///    object = The object portion of the tag.
    ///    id = The identifier portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetTag(const(GUID)* riid, void** object, uint* id);
    ///Sets a viewport tag.
    ///Params:
    ///    object = The object portion of the tag.
    ///    id = The ID portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetTag(IUnknown object, uint id);
    ///Retrieves the rectangle for the viewport relative to the origin of the viewport coordinate system specified by
    ///SetViewportRect.
    ///Params:
    ///    viewport = The bounding rectangle relative to the viewport coordinate system.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetViewportRect(RECT* viewport);
    ///Sets the bounding rectangle for the viewport, relative to the origin of the viewport coordinate system.
    ///Params:
    ///    viewport = The bounding rectangle.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetViewportRect(const(RECT)* viewport);
    ///Moves the viewport to a specific area of the primary content and specifies whether to animate the transition.
    ///Params:
    ///    left = The leftmost coordinate of the rectangle in the primary content coordinate space.
    ///    top = The topmost coordinate of the rectangle in the primary content coordinate space.
    ///    right = The rightmost coordinate of the rectangle in the primary content coordinate space.
    ///    bottom = The bottommost coordinate of the rectangle in the primary content coordinate space.
    ///    animate = Specifies whether to animate the zoom behavior.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ZoomToRect(const(float) left, const(float) top, const(float) right, const(float) bottom, BOOL animate);
    ///Specifies the transform from the viewport coordinate system to the window client coordinate system.
    ///Params:
    ///    matrix = The transform matrix, in row-wise order: _11, _12, _21, _22, _31, _32.
    ///    pointCount = The size of the transform matrix. This value is always 6, because a 3x2 matrix is used for all direct
    ///                 manipulation transforms.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetViewportTransform(const(float)* matrix, uint pointCount);
    ///Specifies a display transform for the viewport, and synchronizes the output transform with the new value of the
    ///display transform.
    ///Params:
    ///    matrix = The transform matrix, in row-wise order: _11, _12, _21, _22, _31, _32.
    ///    pointCount = The size of the transform matrix. This value is always 6, because a 3x2 matrix is used for all direct
    ///                 manipulation transforms.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SyncDisplayTransform(const(float)* matrix, uint pointCount);
    ///Gets the primary content of a viewport that implements IDirectManipulationContent and
    ///IDirectManipulationPrimaryContent. Primary content is an element that gets transformed (e.g. moved, scaled,
    ///rotated) in response to a user interaction. Primary content is created at the same time as the viewport and
    ///cannot be added or removed.
    ///Params:
    ///    riid = IID to the interface.
    ///    object = The primary content object.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPrimaryContent(const(GUID)* riid, void** object);
    ///Adds secondary content, such as a panning indicator, to a viewport.
    ///Params:
    ///    content = The content to add to the viewport.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddContent(IDirectManipulationContent content);
    ///Removes secondary content from a viewport.
    ///Params:
    ///    content = The content object to remove.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveContent(IDirectManipulationContent content);
    ///Sets how the viewport handles input and output. Calling this method overrides all settings previously specified
    ///with SetUpdateMode or SetInputMode.
    ///Params:
    ///    options = One or more of the values from DIRECTMANIPULATION_VIEWPORT_OPTIONS.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetViewportOptions(DIRECTMANIPULATION_VIEWPORT_OPTIONS options);
    ///Adds an interaction configuration for the viewport.
    ///Params:
    ///    configuration = One of the values from DIRECTMANIPULATION_CONFIGURATION that specifies the interaction configuration for the
    ///                    viewport.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AddConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    ///Removes an interaction configuration for the viewport.
    ///Params:
    ///    configuration = One of the values from DIRECTMANIPULATION_CONFIGURATION that specifies the interaction configuration for the
    ///                    viewport.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    ///Sets the configuration for input interaction.
    ///Params:
    ///    configuration = One or more values from DIRECTMANIPULATION_CONFIGURATION that specify the interaction configuration for the
    ///                    viewport.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ActivateConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    ///Sets which gestures are ignored by Direct Manipulation.
    ///Params:
    ///    configuration = One of the values from DIRECTMANIPULATION_GESTURE_CONFIGURATION.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetManualGesture(DIRECTMANIPULATION_GESTURE_CONFIGURATION configuration);
    ///Specifies the motion types supported in a viewport that can be chained to a parent viewport.
    ///Params:
    ///    enabledTypes = One of the values from DIRECTMANIPULATION_MOTION_TYPES that specifies the motion types that are enabled for
    ///                   this viewport.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetChaining(DIRECTMANIPULATION_MOTION_TYPES enabledTypes);
    ///Adds a new event handler to listen for viewport events.
    ///Params:
    ///    window = The handle of a window owned by the thread for the event callback.
    ///    eventHandler = The handler that is called when viewport status and update events occur. The specified object must implement
    ///                   the IDirectManipulationViewportEventHandler interface.
    ///    cookie = The handle that represents this event handler callback.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddEventHandler(HWND window, IDirectManipulationViewportEventHandler eventHandler, uint* cookie);
    ///Removes an existing event handler from the viewport.
    ///Params:
    ///    cookie = A value that was returned by a previous call to AddEventHandler.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveEventHandler(uint cookie);
    ///Specifies if input is visible to the UI thread.
    ///Params:
    ///    mode = One of the values from DIRECTMANIPULATION_INPUT_MODE.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetInputMode(DIRECTMANIPULATION_INPUT_MODE mode);
    ///Specifies whether a viewport updates content manually instead of during an input event.
    ///Params:
    ///    mode = One of the values from DIRECTMANIPULATION_INPUT_MODE.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetUpdateMode(DIRECTMANIPULATION_INPUT_MODE mode);
    ///Stops the manipulation and returns the viewport to a ready state.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Stop();
    ///Releases all resources that are used by the viewport and prepares it for destruction from memory.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Abandon();
}

///Provides management of behaviors on a viewport. A behavior affects the functionality of a particular part of the
///Direct Manipulation workflow.
@GUID("923CCAAC-61E1-4385-B726-017AF189882A")
interface IDirectManipulationViewport2 : IDirectManipulationViewport
{
    ///Adds a behavior to the viewport and returns a cookie to the caller.
    ///Params:
    ///    behavior = A behavior created using the CreateBehavior method.
    ///    cookie = A cookie is returned so the caller can remove this behavior later. This allows the caller to release any
    ///             reference on the behavior and let Direct Manipulation maintain an appropriate lifetime, similar to event
    ///             handlers.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. Attaching
    ///    a behavior that is already attached to this viewport or another viewport results in a failure.
    ///    
    HRESULT AddBehavior(IUnknown behavior, uint* cookie);
    ///Removes a behavior from the viewport that matches the given cookie.
    ///Params:
    ///    cookie = A valid cookie returned from the AddBehavior call on the same viewport.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. If the
    ///    behavior has already been removed or if the behavior is not attached to this viewport a failure is returned.
    ///    
    HRESULT RemoveBehavior(uint cookie);
    ///Removes all behaviors added to the viewport.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveAllBehaviors();
}

///Defines methods for handling status and update events for the viewport. <div class="alert"><b>Note</b> When
///implementing a Direct Manipulation object, ensure that the IUnknown implementation supports multithreading through
///thread-safe reference counting. For more information, see InterlockedIncrement and InterlockedDecrement.</div><div>
///</div>
@GUID("952121DA-D69F-45F9-B0F9-F23944321A6D")
interface IDirectManipulationViewportEventHandler : IUnknown
{
    ///Called when the status of a viewport changes.
    ///Params:
    ///    viewport = The viewport for which status has changed.
    ///    current = The new status of the viewport.
    ///    previous = The previous status of the viewport.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT OnViewportStatusChanged(IDirectManipulationViewport viewport, DIRECTMANIPULATION_STATUS current, 
                                    DIRECTMANIPULATION_STATUS previous);
    ///Called after all content in the viewport has been updated.
    ///Params:
    ///    viewport = The viewport that has been updated.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT OnViewportUpdated(IDirectManipulationViewport viewport);
    ///Called when content inside a viewport is updated.
    ///Params:
    ///    viewport = The viewport that is updated.
    ///    content = The content in the viewport that has changed.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT OnContentUpdated(IDirectManipulationViewport viewport, IDirectManipulationContent content);
}

///Encapsulates content inside a viewport, where content represents a visual surface clipped inside the viewport. The
///content has a set of transforms that controls the visual movement of the surface during manipulation and inertia.
///<div class="alert"><b>Note</b> When implementing a Direct Manipulation object, ensure that the IUnknown
///implementation supports multithreading through thread-safe reference counting. For more information, see
///InterlockedIncrement and InterlockedDecrement.</div><div> </div>
@GUID("B89962CB-3D89-442B-BB58-5098FA0F9F16")
interface IDirectManipulationContent : IUnknown
{
    ///Retrieves the bounding rectangle of the content, relative to the bounding rectangle of the viewport (if defined).
    ///Params:
    ///    contentSize = The bounding rectangle of the content.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetContentRect(RECT* contentSize);
    ///Specifies the bounding rectangle of the content, relative to its viewport.
    ///Params:
    ///    contentSize = The bounding rectangle of the content.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContentRect(const(RECT)* contentSize);
    ///Retrieves the viewport that contains the content.
    ///Params:
    ///    riid = A reference to the identifier of the interface to use.
    ///    object = The viewport object.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetViewport(const(GUID)* riid, void** object);
    ///Retrieves the tag object set on this content.
    ///Params:
    ///    riid = A reference to the identifier of the interface to use. The tag object typically implements this interface.
    ///    object = The tag object.
    ///    id = The ID portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetTag(const(GUID)* riid, void** object, uint* id);
    ///Specifies the tag object for the content.
    ///Params:
    ///    object = The object portion of the tag.
    ///    id = The ID portion of the tag.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetTag(IUnknown object, uint id);
    ///Gets the final transform applied to the content.
    ///Params:
    ///    matrix = The transform matrix.
    ///    pointCount = The size of the transform matrix. This value is always 6, because a 3x2 matrix is used for all direct
    ///                 manipulation transforms.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOutputTransform(float* matrix, uint pointCount);
    ///Retrieves the transform applied to the content.
    ///Params:
    ///    matrix = The transform matrix.
    ///    pointCount = The size of the transform matrix. This value is always 6, because a 3x2 matrix is used for all direct
    ///                 manipulation transforms.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetContentTransform(float* matrix, uint pointCount);
    ///Modifies the content transform while maintaining the output transform.
    ///Params:
    ///    matrix = The transform matrix.
    ///    pointCount = The size of the transform matrix. This value is always 6, because a 3x2 matrix is used for all direct
    ///                 manipulation transforms.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SyncContentTransform(const(float)* matrix, uint pointCount);
}

///Encapsulates the primary content inside a viewport. Primary content is the content specified during the creation of a
///viewport.
@GUID("C12851E4-1698-4625-B9B1-7CA3EC18630B")
interface IDirectManipulationPrimaryContent : IUnknown
{
    ///Specifies snap points for the inertia end position at uniform intervals.
    ///Params:
    ///    motion = One of the DIRECTMANIPULATION_MOTION_TYPES enumeration values.
    ///    interval = The interval between each snap point.
    ///    offset = The offset from the coordinate specified in SetSnapCoordinate.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSnapInterval(DIRECTMANIPULATION_MOTION_TYPES motion, float interval, float offset);
    ///Specifies the snap points for the inertia rest position.
    ///Params:
    ///    motion = One or more of the DIRECTMANIPULATION_MOTION_TYPES enumeration values. Only
    ///             <b>DIRECTMANIPULATION_MOTION_TRANSLATE_X</b>, <b>DIRECTMANIPULATION_MOTION_TRANSLATE_Y</b>, or
    ///             <b>DIRECTMANIPULATION_MOTION_ZOOM</b> are allowed.
    ///    points = An array of snap points within the boundaries of the content to snap to. Should be specified in increasing
    ///             order relative to the origin set in SetSnapCoordinate.
    ///    pointCount = The size of the array of snap points. Should be greater than 0.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. If there is no change in the snap points, this method can
    ///    return <b>S_FALSE</b>. Otherwise, it returns an <b>HRESULT</b> error code. If invalid snap points are
    ///    specified, existing snap points might be affected.
    ///    
    HRESULT SetSnapPoints(DIRECTMANIPULATION_MOTION_TYPES motion, const(float)* points, uint pointCount);
    ///Specifies the type of snap point.
    ///Params:
    ///    motion = One or more of the DIRECTMANIPULATION_MOTION_TYPES enumeration values.
    ///    type = One of the DIRECTMANIPULATION_SNAPPOINT_TYPE enumeration values. If set to
    ///           <b>DIRECTMANIPULATION_SNAPPOINT_TYPE_NONE</b>, snap points specified through SetSnapPoints or SetSnapInterval
    ///           are cleared.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSnapType(DIRECTMANIPULATION_MOTION_TYPES motion, DIRECTMANIPULATION_SNAPPOINT_TYPE type);
    ///Specifies the coordinate system for snap points or snap intervals.
    ///Params:
    ///    motion = One of the values from DIRECTMANIPULATION_MOTION_TYPES.
    ///    coordinate = One of the values from DIRECTMANIPULATION_SNAPPOINT_COORDINATE. If <i>motion</i> is set to translation
    ///                 (<b>DIRECTMANIPULATION_MOTION_TRANSLATEX</b> or <b>DIRECTMANIPULATION_MOTION_TRANSLATEY</b>), all values of
    ///                 DIRECTMANIPULATION_SNAPPOINT_COORDINATE are valid. If <i>motion</i> is set to
    ///                 <b>DIRECTMANIPULATION_MOTION_ZOOM</b>, only <b>DIRECTMANIPULATION_COORDINATE_ORIGIN</b> of
    ///                 DIRECTMANIPULATION_SNAPPOINT_COORDINATE is valid (<i>origin</i> must be set to 0.0f).
    ///    origin = The initial, or starting, snap point. All snap points are relative to this one. Only used when
    ///             DIRECTMANIPULATION_COORDINATE_ORIGIN is set. If <i>motion</i> is set to
    ///             <b>DIRECTMANIPULATION_MOTION_ZOOM</b>, then <i>origin</i> must be set to 0.0f.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSnapCoordinate(DIRECTMANIPULATION_MOTION_TYPES motion, 
                              DIRECTMANIPULATION_SNAPPOINT_COORDINATE coordinate, float origin);
    ///Specifies the minimum and maximum boundaries for zoom.
    ///Params:
    ///    zoomMinimum = The minimum zoom level allowed. Must be greater than or equal to 0.1f, which corresponds to 100% zoom.
    ///    zoomMaximum = The maximum zoom allowed. Must be greater than <i>zoomMinimum</i> and less than FLT_MAX.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetZoomBoundaries(float zoomMinimum, float zoomMaximum);
    ///Sets the horizontal alignment of the primary content relative to the viewport.
    ///Params:
    ///    alignment = One or more values from DIRECTMANIPULATION_HORIZONTALALIGNMENT. The default is
    ///                <b>DIRECTMANIPULATION_HORIZONTALALIGNMENT_NONE</b>. <div class="alert"><b>Note</b> You cannot combine the
    ///                following options: DIRECTMANIPULATION_HORIZONTALALIGNMENT_LEFT,
    ///                DIRECTMANIPULATION-HORIZONTALALIGNMENT_CENTER, DIRECTMANIPULATION_HORIZONTALALIGNMENT_RIGHT.
    ///                DIRECTMANIPULATION_HORIZONTALALIGNMENT_UNLOCKCENTER can be combined with any option but cannot be configured
    ///                by itself.</div> <div> </div>
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetHorizontalAlignment(DIRECTMANIPULATION_HORIZONTALALIGNMENT alignment);
    ///Specifies the vertical alignment of the primary content in the viewport.
    ///Params:
    ///    alignment = One or more values from DIRECTMANIPULATION_VERTICALALIGNMENT. <div class="alert"><b>Note</b> You cannot
    ///                combine <b>DIRECTMANIPULATION_VERTICALALIGNMENT_TOP</b>, <b>DIRECTMANIPULATION_VERTICALALIGNMENT_CENTER</b>,
    ///                or <b>DIRECTMANIPULATION_VERTICALALIGNMENT_BOTTOM</b>.
    ///                <b>DIRECTMANIPULATION_VERTICALALIGNMENT_UNLOCKCENTER</b> can be combined with any option but cannot be
    ///                configured by itself.</div> <div> </div>
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetVerticalAlignment(DIRECTMANIPULATION_VERTICALALIGNMENT alignment);
    ///Gets the final transform, including inertia, of the primary content.
    ///Params:
    ///    matrix = The transformed matrix that represents the inertia ending position.
    ///    pointCount = The size of the matrix. This value is always 6, because a 3x2 matrix is used for all direct manipulation
    ///                 transforms.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetInertiaEndTransform(float* matrix, uint pointCount);
    ///Retrieves the center point of the manipulation in content coordinates. If there is no manipulation in progress,
    ///retrieves the center point of the viewport.
    ///Params:
    ///    centerX = The center on the horizontal axis.
    ///    centerY = The center on the vertical axis.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCenterPoint(float* centerX, float* centerY);
}

///Defines methods to handle drag-drop behavior events. <div class="alert"><b>Note</b> When implementing this interface,
///ensure that the IUnknown implementation supports multithreading through thread-safe reference counting. For more
///information, see InterlockedIncrement and InterlockedDecrement.</div><div> </div>
@GUID("1FA11B10-701B-41AE-B5F2-49E36BD595AA")
interface IDirectManipulationDragDropEventHandler : IUnknown
{
    ///Called when a status change happens in the viewport that the drag-and-drop behavior is attached to.
    ///Params:
    ///    viewport = The updated viewport.
    ///    current = The current state of the drag-drop interaction from DIRECTMANIPULATION_DRAG_DROP_STATUS.
    ///    previous = The previous state of the drag-drop interaction from DIRECTMANIPULATION_DRAG_DROP_STATUS.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnDragDropStatusChange(IDirectManipulationViewport2 viewport, 
                                   DIRECTMANIPULATION_DRAG_DROP_STATUS current, 
                                   DIRECTMANIPULATION_DRAG_DROP_STATUS previous);
}

///Represents behaviors for drag and drop interactions, which are triggered by cross-slide or press-and-hold gestures.
///Call AddBehavior to apply the behavior on a viewport and RemoveBehavior to remove it.
@GUID("814B5AF5-C2C8-4270-A9B7-A198CE8D02FA")
interface IDirectManipulationDragDropBehavior : IUnknown
{
    ///Sets the configuration of the drag-drop interaction for the viewport this behavior is attached to.
    ///Params:
    ///    configuration = Combination of values from DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION. For the configuration to be valid,
    ///                    <i>configuration</i> must contain exactly one of the following three values: <ul>
    ///                    <li><b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_ONLY</b></li>
    ///                    <li><b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_DRAG</b></li>
    ///                    <li><b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HOLD_DRAG</b></li> </ul> If
    ///                    <b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_ONLY</b> or
    ///                    <b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_DRAG</b> is specified, one of
    ///                    <b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_VERTICAL</b> or
    ///                    <b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HORIZONTAL</b> is required. If
    ///                    <b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HOLD_DRAG</b> is specified, both
    ///                    <b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_VERTICAL</b> and
    ///                    <b>DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HORIZONTAL</b> are required.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetConfiguration(DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION configuration);
    ///Gets the status of the drag-drop interaction for the viewport this behavior is attached to.
    ///Params:
    ///    status = One of the values from DIRECTMANIPULATION_DRAG_DROP_STATUS.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStatus(DIRECTMANIPULATION_DRAG_DROP_STATUS* status);
}

///Defines methods to handle interactions when they are detected. <div class="alert"><b>Note</b> When implementing this
///interface, ensure that the IUnknown implementation supports multithreading through thread-safe reference counting.
///For more information, see InterlockedIncrement and InterlockedDecrement.</div><div> </div>
@GUID("E43F45B8-42B4-403E-B1F2-273B8F510830")
interface IDirectManipulationInteractionEventHandler : IUnknown
{
    ///Called when an interaction is detected.
    ///Params:
    ///    viewport = The viewport on which the interaction was detected.
    ///    interaction = One of the values from DIRECTMANIPULATION_INTERACTION_TYPE.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnInteraction(IDirectManipulationViewport2 viewport, DIRECTMANIPULATION_INTERACTION_TYPE interaction);
}

///Represents a time-keeping object that measures the latency of the composition infrastructure used by the application
///and provides this data to Direct Manipulation.
@GUID("FB759DBA-6F4C-4C01-874E-19C8A05907F9")
interface IDirectManipulationFrameInfoProvider : IUnknown
{
    ///Retrieves the composition timing information from the compositor.
    ///Params:
    ///    time = The current time, in milliseconds.
    ///    processTime = The time, in milliseconds, when the compositor begins constructing the next frame.
    ///    compositionTime = The time, in milliseconds, when the compositor finishes composing and drawing the next frame on the screen.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetNextFrameInfo(ulong* time, ulong* processTime, ulong* compositionTime);
}

///Represents a compositor object that associates manipulated content with a drawing surface, such as canvas (Windows
///app using JavaScript) or <a href="/previous-versions/windows/silverlight/dotnet-windows-silverlight/ms609101(v=vs.95)
///">Canvas</a> (Windows Store app using C++, C#, or Visual Basic).
@GUID("537A0825-0387-4EFA-B62F-71EB1F085A7E")
interface IDirectManipulationCompositor : IUnknown
{
    ///Associates content (owned by the caller) with the compositor, assigns a composition device to the content, and
    ///specifies the position of the content in the composition tree relative to other composition visuals.
    ///Params:
    ///    content = The content to add to the composition tree. <i>content</i> is placed between <i>parentVisual</i> and
    ///              <i>childVisual</i> in the composition tree.
    ///    device = The device used to compose the content. <div class="alert"><b>Note</b> <i>device</i> is created by the
    ///             application.</div> <div> </div>
    ///    parentVisual = The parent visuals in the composition tree of the content being added. <i>parentVisual</i> must also be a
    ///                   parent of <i>childVisual</i> in the composition tree.
    ///    childVisual = The child visuals in the composition tree of the content being added. <i>parentVisual</i> must also be a
    ///                  parent of <i>childVisual</i> in the composition tree.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AddContent(IDirectManipulationContent content, IUnknown device, IUnknown parentVisual, 
                       IUnknown childVisual);
    ///Removes content from the compositor.
    ///Params:
    ///    content = The content to remove from the composition tree.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveContent(IDirectManipulationContent content);
    ///Sets the update manager used to send compositor updates to Direct Manipulation.
    ///Params:
    ///    updateManager = The update manager.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetUpdateManager(IDirectManipulationUpdateManager updateManager);
    ///Commits all pending updates in the compositor to the system for rendering.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Flush();
}

///Represents a compositor object that associates manipulated content with drawing surfaces across multiple processes.
@GUID("D38C7822-F1CB-43CB-B4B9-AC0C767A412E")
interface IDirectManipulationCompositor2 : IDirectManipulationCompositor
{
    ///Associates content (owned by the component host) with the compositor, assigns a composition device to the
    ///content, and specifies the position of the content in the composition tree relative to other composition visuals.
    ///Represents a compositor object that associates manipulated content with drawing surfaces across multiple
    ///processes.
    ///Params:
    ///    content = The content to add to the composition tree. <i>content</i> is placed between <i>parentVisual</i> and
    ///              <i>childVisual</i> in the composition tree. Only primary content, created at the same time as the viewport,
    ///              is valid.
    ///    device = The device used to compose the content. <div class="alert"><b>Note</b> <i>device</i> is created by the
    ///             application.</div> <div> </div>
    ///    parentVisual = The parent visuals in the composition tree of the content being added. <i>parentVisual</i> must also be a
    ///                   parent of <i>childVisual</i> in the composition tree.
    ///    childVisual = The child visuals in the composition tree of the content being added. <i>parentVisual</i> must also be a
    ///                  parent of <i>childVisual</i> in the composition tree.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AddContentWithCrossProcessChaining(IDirectManipulationPrimaryContent content, IUnknown device, 
                                               IUnknown parentVisual, IUnknown childVisual);
}

///Defines methods for handling manipulation update events. <div class="alert"><b>Note</b> When implementing a Direct
///Manipulation object, ensure that the IUnknown implementation supports multithreading through thread-safe reference
///counting. For more information, see InterlockedIncrement and InterlockedDecrement.</div><div> </div>
@GUID("790B6337-64F8-4FF5-A269-B32BC2AF27A7")
interface IDirectManipulationUpdateHandler : IUnknown
{
    ///Notifies the compositor when to update inertia animation.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Update();
}

///Manages how compositor updates are sent to Direct Manipulation. This interface enables the compositor to trigger an
///update on Direct Manipulation whenever there is a compositor update. The application should not call the methods of
///this interface directly.
@GUID("B0AE62FD-BE34-46E7-9CAA-D361FACBB9CC")
interface IDirectManipulationUpdateManager : IUnknown
{
    ///Registers a callback that is triggered by a handle.
    ///Params:
    ///    handle = The event handle that triggers the callback.
    ///    eventHandler = The event handler to call when the event is fired.
    ///    cookie = The unique ID of the event callback instance.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RegisterWaitHandleCallback(HANDLE handle, IDirectManipulationUpdateHandler eventHandler, uint* cookie);
    ///Deregisters a callback.
    ///Params:
    ///    cookie = The unique ID of the event callback instance.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT UnregisterWaitHandleCallback(uint cookie);
    ///Updates Direct Manipulation at the current time.
    ///Params:
    ///    frameInfo = The frame info provider used to predict the position of the content and compensate for latency during
    ///                composition.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Update(IDirectManipulationFrameInfoProvider frameInfo);
}

///Represents the auto-scroll animation behavior of content as it approaches the boundary of a given axis or axes.
@GUID("6D5954D4-2003-4356-9B31-D051C9FF0AF7")
interface IDirectManipulationAutoScrollBehavior : IUnknown
{
    ///Performs the auto-scroll animation for the viewport this behavior is attached to.
    ///Params:
    ///    motionTypes = A combination of <b>DIRECTMANIPULATION_MOTION_TRANSLATEX</b> and <b>DIRECTMANIPULATION_MOTION_TRANSLATEY</b>
    ///                  from DIRECTMANIPULATION_MOTION_TYPES. <b>DIRECTMANIPULATION_MOTION_NONE</b> cannot be specified.
    ///    scrollMotion = One of the values from DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetConfiguration(DIRECTMANIPULATION_MOTION_TYPES motionTypes, 
                             DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION scrollMotion);
}

///Represents a service for managing associations between a contact and a viewport. SetContact is called when a
///WM_POINTERDOWN message is received. Upon receiving a <b>WM_POINTERDOWN</b>, the application can use the coordinates
///of the input to hit-test and determine the viewports to which the contact is associated.
@GUID("652D5C71-FE60-4A98-BE70-E5F21291E7F1")
interface IDirectManipulationDeferContactService : IUnknown
{
    ///Specifies the amount of time to defer the execution of a call to SetContact for this <i>pointerId</i>.
    ///<b>DeferContact</b> must be called before SetContact.
    ///Params:
    ///    pointerId = The ID of the pointer.
    ///    timeout = The duration of the deferral, in milliseconds. The maximum value is 500.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT DeferContact(uint pointerId, uint timeout);
    ///Cancel all scheduled calls to SetContact for this <i>pointerId</i>.
    ///Params:
    ///    pointerId = The ID of the pointer.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CancelContact(uint pointerId);
    ///Cancel the deferral set in DeferContact and process the scheduled SetContact call for this <i>pointerId</i>.
    ///Params:
    ///    pointerId = The ID of the pointer.
    ///Returns:
    ///    If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CancelDeferral(uint pointerId);
}


// GUIDs

const GUID CLSID_DCompManipulationCompositor      = GUIDOF!DCompManipulationCompositor;
const GUID CLSID_DirectManipulationManager        = GUIDOF!DirectManipulationManager;
const GUID CLSID_DirectManipulationPrimaryContent = GUIDOF!DirectManipulationPrimaryContent;
const GUID CLSID_DirectManipulationSharedManager  = GUIDOF!DirectManipulationSharedManager;
const GUID CLSID_DirectManipulationUpdateManager  = GUIDOF!DirectManipulationUpdateManager;
const GUID CLSID_DirectManipulationViewport       = GUIDOF!DirectManipulationViewport;

const GUID IID_IDirectManipulationAutoScrollBehavior      = GUIDOF!IDirectManipulationAutoScrollBehavior;
const GUID IID_IDirectManipulationCompositor              = GUIDOF!IDirectManipulationCompositor;
const GUID IID_IDirectManipulationCompositor2             = GUIDOF!IDirectManipulationCompositor2;
const GUID IID_IDirectManipulationContent                 = GUIDOF!IDirectManipulationContent;
const GUID IID_IDirectManipulationDeferContactService     = GUIDOF!IDirectManipulationDeferContactService;
const GUID IID_IDirectManipulationDragDropBehavior        = GUIDOF!IDirectManipulationDragDropBehavior;
const GUID IID_IDirectManipulationDragDropEventHandler    = GUIDOF!IDirectManipulationDragDropEventHandler;
const GUID IID_IDirectManipulationFrameInfoProvider       = GUIDOF!IDirectManipulationFrameInfoProvider;
const GUID IID_IDirectManipulationInteractionEventHandler = GUIDOF!IDirectManipulationInteractionEventHandler;
const GUID IID_IDirectManipulationManager                 = GUIDOF!IDirectManipulationManager;
const GUID IID_IDirectManipulationManager2                = GUIDOF!IDirectManipulationManager2;
const GUID IID_IDirectManipulationManager3                = GUIDOF!IDirectManipulationManager3;
const GUID IID_IDirectManipulationPrimaryContent          = GUIDOF!IDirectManipulationPrimaryContent;
const GUID IID_IDirectManipulationUpdateHandler           = GUIDOF!IDirectManipulationUpdateHandler;
const GUID IID_IDirectManipulationUpdateManager           = GUIDOF!IDirectManipulationUpdateManager;
const GUID IID_IDirectManipulationViewport                = GUIDOF!IDirectManipulationViewport;
const GUID IID_IDirectManipulationViewport2               = GUIDOF!IDirectManipulationViewport2;
const GUID IID_IDirectManipulationViewportEventHandler    = GUIDOF!IDirectManipulationViewportEventHandler;
