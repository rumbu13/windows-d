module windows.directmanipulation;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND, MSG;

extern(Windows):


// Enums


enum : int
{
    DIRECTMANIPULATION_BUILDING  = 0x00000000,
    DIRECTMANIPULATION_ENABLED   = 0x00000001,
    DIRECTMANIPULATION_DISABLED  = 0x00000002,
    DIRECTMANIPULATION_RUNNING   = 0x00000003,
    DIRECTMANIPULATION_INERTIA   = 0x00000004,
    DIRECTMANIPULATION_READY     = 0x00000005,
    DIRECTMANIPULATION_SUSPENDED = 0x00000006,
}
alias DIRECTMANIPULATION_STATUS = int;

enum : int
{
    DIRECTMANIPULATION_HITTEST_TYPE_ASYNCHRONOUS     = 0x00000000,
    DIRECTMANIPULATION_HITTEST_TYPE_SYNCHRONOUS      = 0x00000001,
    DIRECTMANIPULATION_HITTEST_TYPE_AUTO_SYNCHRONOUS = 0x00000002,
}
alias DIRECTMANIPULATION_HITTEST_TYPE = int;

enum : int
{
    DIRECTMANIPULATION_CONFIGURATION_NONE                = 0x00000000,
    DIRECTMANIPULATION_CONFIGURATION_INTERACTION         = 0x00000001,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_X       = 0x00000002,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_Y       = 0x00000004,
    DIRECTMANIPULATION_CONFIGURATION_SCALING             = 0x00000010,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_INERTIA = 0x00000020,
    DIRECTMANIPULATION_CONFIGURATION_SCALING_INERTIA     = 0x00000080,
    DIRECTMANIPULATION_CONFIGURATION_RAILS_X             = 0x00000100,
    DIRECTMANIPULATION_CONFIGURATION_RAILS_Y             = 0x00000200,
}
alias DIRECTMANIPULATION_CONFIGURATION = int;

enum : int
{
    DIRECTMANIPULATION_GESTURE_NONE                   = 0x00000000,
    DIRECTMANIPULATION_GESTURE_DEFAULT                = 0x00000000,
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_VERTICAL   = 0x00000008,
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_HORIZONTAL = 0x00000010,
    DIRECTMANIPULATION_GESTURE_PINCH_ZOOM             = 0x00000020,
}
alias DIRECTMANIPULATION_GESTURE_CONFIGURATION = int;

enum : int
{
    DIRECTMANIPULATION_MOTION_NONE       = 0x00000000,
    DIRECTMANIPULATION_MOTION_TRANSLATEX = 0x00000001,
    DIRECTMANIPULATION_MOTION_TRANSLATEY = 0x00000002,
    DIRECTMANIPULATION_MOTION_ZOOM       = 0x00000004,
    DIRECTMANIPULATION_MOTION_CENTERX    = 0x00000010,
    DIRECTMANIPULATION_MOTION_CENTERY    = 0x00000020,
    DIRECTMANIPULATION_MOTION_ALL        = 0x00000037,
}
alias DIRECTMANIPULATION_MOTION_TYPES = int;

enum : int
{
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DEFAULT              = 0x00000000,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_AUTODISABLE          = 0x00000001,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_MANUALUPDATE         = 0x00000002,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_INPUT                = 0x00000004,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_EXPLICITHITTEST      = 0x00000008,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DISABLEPIXELSNAPPING = 0x00000010,
}
alias DIRECTMANIPULATION_VIEWPORT_OPTIONS = int;

enum : int
{
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY        = 0x00000000,
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL         = 0x00000001,
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY_SINGLE = 0x00000002,
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL_SINGLE  = 0x00000003,
}
alias DIRECTMANIPULATION_SNAPPOINT_TYPE = int;

enum : int
{
    DIRECTMANIPULATION_COORDINATE_BOUNDARY = 0x00000000,
    DIRECTMANIPULATION_COORDINATE_ORIGIN   = 0x00000001,
    DIRECTMANIPULATION_COORDINATE_MIRRORED = 0x00000010,
}
alias DIRECTMANIPULATION_SNAPPOINT_COORDINATE = int;

enum : int
{
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_NONE         = 0x00000000,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_LEFT         = 0x00000001,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_CENTER       = 0x00000002,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_RIGHT        = 0x00000004,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_UNLOCKCENTER = 0x00000008,
}
alias DIRECTMANIPULATION_HORIZONTALALIGNMENT = int;

enum : int
{
    DIRECTMANIPULATION_VERTICALALIGNMENT_NONE         = 0x00000000,
    DIRECTMANIPULATION_VERTICALALIGNMENT_TOP          = 0x00000001,
    DIRECTMANIPULATION_VERTICALALIGNMENT_CENTER       = 0x00000002,
    DIRECTMANIPULATION_VERTICALALIGNMENT_BOTTOM       = 0x00000004,
    DIRECTMANIPULATION_VERTICALALIGNMENT_UNLOCKCENTER = 0x00000008,
}
alias DIRECTMANIPULATION_VERTICALALIGNMENT = int;

enum : int
{
    DIRECTMANIPULATION_INPUT_MODE_AUTOMATIC = 0x00000000,
    DIRECTMANIPULATION_INPUT_MODE_MANUAL    = 0x00000001,
}
alias DIRECTMANIPULATION_INPUT_MODE = int;

enum : int
{
    DIRECTMANIPULATION_DRAG_DROP_READY     = 0x00000000,
    DIRECTMANIPULATION_DRAG_DROP_PRESELECT = 0x00000001,
    DIRECTMANIPULATION_DRAG_DROP_SELECTING = 0x00000002,
    DIRECTMANIPULATION_DRAG_DROP_DRAGGING  = 0x00000003,
    DIRECTMANIPULATION_DRAG_DROP_CANCELLED = 0x00000004,
    DIRECTMANIPULATION_DRAG_DROP_COMMITTED = 0x00000005,
}
alias DIRECTMANIPULATION_DRAG_DROP_STATUS = int;

enum : int
{
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_VERTICAL    = 0x00000001,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HORIZONTAL  = 0x00000002,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_ONLY = 0x00000010,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_DRAG = 0x00000020,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HOLD_DRAG   = 0x00000040,
}
alias DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION = int;

enum : int
{
    DIRECTMANIPULATION_INTERACTION_BEGIN                    = 0x00000000,
    DIRECTMANIPULATION_INTERACTION_TYPE_MANIPULATION        = 0x00000001,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_TAP         = 0x00000002,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_HOLD        = 0x00000003,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_CROSS_SLIDE = 0x00000004,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_PINCH_ZOOM  = 0x00000005,
    DIRECTMANIPULATION_INTERACTION_END                      = 0x00000064,
}
alias DIRECTMANIPULATION_INTERACTION_TYPE = int;

enum : int
{
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_STOP    = 0x00000000,
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_FORWARD = 0x00000001,
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_REVERSE = 0x00000002,
}
alias DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION = int;

// Structs


struct IDirectManipulationSnapPointsInertiaBehavior
{
}

struct IDirectManipulationContent2
{
}

struct IDirectManipulationViewport3
{
}

struct IDirectManipulationPrimaryContent2
{
}

struct IDirectManipulationParametricMotionBehavior
{
}

struct IDirectManipulationParametricMotionCurve
{
}

struct IDirectManipulationParametricRestPointList
{
}

struct IDirectManipulationParametricRestPointBehavior
{
}

struct IDirectManipulationCompositorPartner
{
}

struct IDirectManipulationManagerPartner
{
}

struct IDirectManipulationViewportPartner
{
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

@GUID("FBF5D3B4-70C7-4163-9322-5A6F660D6FBC")
interface IDirectManipulationManager : IUnknown
{
    HRESULT Activate(HWND window);
    HRESULT Deactivate(HWND window);
    HRESULT RegisterHitTestTarget(HWND window, HWND hitTestWindow, DIRECTMANIPULATION_HITTEST_TYPE type);
    HRESULT ProcessInput(const(MSG)* message, int* handled);
    HRESULT GetUpdateManager(const(GUID)* riid, void** object);
    HRESULT CreateViewport(IDirectManipulationFrameInfoProvider frameInfo, HWND window, const(GUID)* riid, 
                           void** object);
    HRESULT CreateContent(IDirectManipulationFrameInfoProvider frameInfo, const(GUID)* clsid, const(GUID)* riid, 
                          void** object);
}

@GUID("FA1005E9-3D16-484C-BFC9-62B61E56EC4E")
interface IDirectManipulationManager2 : IDirectManipulationManager
{
    HRESULT CreateBehavior(const(GUID)* clsid, const(GUID)* riid, void** object);
}

@GUID("2CB6B33D-FFE8-488C-B750-FBDFE88DCA8C")
interface IDirectManipulationManager3 : IDirectManipulationManager2
{
    HRESULT GetService(const(GUID)* clsid, const(GUID)* riid, void** object);
}

@GUID("28B85A3D-60A0-48BD-9BA1-5CE8D9EA3A6D")
interface IDirectManipulationViewport : IUnknown
{
    HRESULT Enable();
    HRESULT Disable();
    HRESULT SetContact(uint pointerId);
    HRESULT ReleaseContact(uint pointerId);
    HRESULT ReleaseAllContacts();
    HRESULT GetStatus(DIRECTMANIPULATION_STATUS* status);
    HRESULT GetTag(const(GUID)* riid, void** object, uint* id);
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetViewportRect(RECT* viewport);
    HRESULT SetViewportRect(const(RECT)* viewport);
    HRESULT ZoomToRect(const(float) left, const(float) top, const(float) right, const(float) bottom, BOOL animate);
    HRESULT SetViewportTransform(char* matrix, uint pointCount);
    HRESULT SyncDisplayTransform(char* matrix, uint pointCount);
    HRESULT GetPrimaryContent(const(GUID)* riid, void** object);
    HRESULT AddContent(IDirectManipulationContent content);
    HRESULT RemoveContent(IDirectManipulationContent content);
    HRESULT SetViewportOptions(DIRECTMANIPULATION_VIEWPORT_OPTIONS options);
    HRESULT AddConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    HRESULT RemoveConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    HRESULT ActivateConfiguration(DIRECTMANIPULATION_CONFIGURATION configuration);
    HRESULT SetManualGesture(DIRECTMANIPULATION_GESTURE_CONFIGURATION configuration);
    HRESULT SetChaining(DIRECTMANIPULATION_MOTION_TYPES enabledTypes);
    HRESULT AddEventHandler(HWND window, IDirectManipulationViewportEventHandler eventHandler, uint* cookie);
    HRESULT RemoveEventHandler(uint cookie);
    HRESULT SetInputMode(DIRECTMANIPULATION_INPUT_MODE mode);
    HRESULT SetUpdateMode(DIRECTMANIPULATION_INPUT_MODE mode);
    HRESULT Stop();
    HRESULT Abandon();
}

@GUID("923CCAAC-61E1-4385-B726-017AF189882A")
interface IDirectManipulationViewport2 : IDirectManipulationViewport
{
    HRESULT AddBehavior(IUnknown behavior, uint* cookie);
    HRESULT RemoveBehavior(uint cookie);
    HRESULT RemoveAllBehaviors();
}

@GUID("952121DA-D69F-45F9-B0F9-F23944321A6D")
interface IDirectManipulationViewportEventHandler : IUnknown
{
    HRESULT OnViewportStatusChanged(IDirectManipulationViewport viewport, DIRECTMANIPULATION_STATUS current, 
                                    DIRECTMANIPULATION_STATUS previous);
    HRESULT OnViewportUpdated(IDirectManipulationViewport viewport);
    HRESULT OnContentUpdated(IDirectManipulationViewport viewport, IDirectManipulationContent content);
}

@GUID("B89962CB-3D89-442B-BB58-5098FA0F9F16")
interface IDirectManipulationContent : IUnknown
{
    HRESULT GetContentRect(RECT* contentSize);
    HRESULT SetContentRect(const(RECT)* contentSize);
    HRESULT GetViewport(const(GUID)* riid, void** object);
    HRESULT GetTag(const(GUID)* riid, void** object, uint* id);
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetOutputTransform(char* matrix, uint pointCount);
    HRESULT GetContentTransform(char* matrix, uint pointCount);
    HRESULT SyncContentTransform(char* matrix, uint pointCount);
}

@GUID("C12851E4-1698-4625-B9B1-7CA3EC18630B")
interface IDirectManipulationPrimaryContent : IUnknown
{
    HRESULT SetSnapInterval(DIRECTMANIPULATION_MOTION_TYPES motion, float interval, float offset);
    HRESULT SetSnapPoints(DIRECTMANIPULATION_MOTION_TYPES motion, char* points, uint pointCount);
    HRESULT SetSnapType(DIRECTMANIPULATION_MOTION_TYPES motion, DIRECTMANIPULATION_SNAPPOINT_TYPE type);
    HRESULT SetSnapCoordinate(DIRECTMANIPULATION_MOTION_TYPES motion, 
                              DIRECTMANIPULATION_SNAPPOINT_COORDINATE coordinate, float origin);
    HRESULT SetZoomBoundaries(float zoomMinimum, float zoomMaximum);
    HRESULT SetHorizontalAlignment(DIRECTMANIPULATION_HORIZONTALALIGNMENT alignment);
    HRESULT SetVerticalAlignment(DIRECTMANIPULATION_VERTICALALIGNMENT alignment);
    HRESULT GetInertiaEndTransform(char* matrix, uint pointCount);
    HRESULT GetCenterPoint(float* centerX, float* centerY);
}

@GUID("1FA11B10-701B-41AE-B5F2-49E36BD595AA")
interface IDirectManipulationDragDropEventHandler : IUnknown
{
    HRESULT OnDragDropStatusChange(IDirectManipulationViewport2 viewport, 
                                   DIRECTMANIPULATION_DRAG_DROP_STATUS current, 
                                   DIRECTMANIPULATION_DRAG_DROP_STATUS previous);
}

@GUID("814B5AF5-C2C8-4270-A9B7-A198CE8D02FA")
interface IDirectManipulationDragDropBehavior : IUnknown
{
    HRESULT SetConfiguration(DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION configuration);
    HRESULT GetStatus(DIRECTMANIPULATION_DRAG_DROP_STATUS* status);
}

@GUID("E43F45B8-42B4-403E-B1F2-273B8F510830")
interface IDirectManipulationInteractionEventHandler : IUnknown
{
    HRESULT OnInteraction(IDirectManipulationViewport2 viewport, DIRECTMANIPULATION_INTERACTION_TYPE interaction);
}

@GUID("FB759DBA-6F4C-4C01-874E-19C8A05907F9")
interface IDirectManipulationFrameInfoProvider : IUnknown
{
    HRESULT GetNextFrameInfo(ulong* time, ulong* processTime, ulong* compositionTime);
}

@GUID("537A0825-0387-4EFA-B62F-71EB1F085A7E")
interface IDirectManipulationCompositor : IUnknown
{
    HRESULT AddContent(IDirectManipulationContent content, IUnknown device, IUnknown parentVisual, 
                       IUnknown childVisual);
    HRESULT RemoveContent(IDirectManipulationContent content);
    HRESULT SetUpdateManager(IDirectManipulationUpdateManager updateManager);
    HRESULT Flush();
}

@GUID("D38C7822-F1CB-43CB-B4B9-AC0C767A412E")
interface IDirectManipulationCompositor2 : IDirectManipulationCompositor
{
    HRESULT AddContentWithCrossProcessChaining(IDirectManipulationPrimaryContent content, IUnknown device, 
                                               IUnknown parentVisual, IUnknown childVisual);
}

@GUID("790B6337-64F8-4FF5-A269-B32BC2AF27A7")
interface IDirectManipulationUpdateHandler : IUnknown
{
    HRESULT Update();
}

@GUID("B0AE62FD-BE34-46E7-9CAA-D361FACBB9CC")
interface IDirectManipulationUpdateManager : IUnknown
{
    HRESULT RegisterWaitHandleCallback(HANDLE handle, IDirectManipulationUpdateHandler eventHandler, uint* cookie);
    HRESULT UnregisterWaitHandleCallback(uint cookie);
    HRESULT Update(IDirectManipulationFrameInfoProvider frameInfo);
}

@GUID("6D5954D4-2003-4356-9B31-D051C9FF0AF7")
interface IDirectManipulationAutoScrollBehavior : IUnknown
{
    HRESULT SetConfiguration(DIRECTMANIPULATION_MOTION_TYPES motionTypes, 
                             DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION scrollMotion);
}

@GUID("652D5C71-FE60-4A98-BE70-E5F21291E7F1")
interface IDirectManipulationDeferContactService : IUnknown
{
    HRESULT DeferContact(uint pointerId, uint timeout);
    HRESULT CancelContact(uint pointerId);
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
