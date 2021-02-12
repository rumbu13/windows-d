module windows.directmanipulation;

public import system;
public import windows.com;
public import windows.displaydevices;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

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

const GUID CLSID_DirectManipulationViewport = {0x34E211B6, 0x3650, 0x4F75, [0x83, 0x34, 0xFA, 0x35, 0x95, 0x98, 0xE1, 0xC5]};
@GUID(0x34E211B6, 0x3650, 0x4F75, [0x83, 0x34, 0xFA, 0x35, 0x95, 0x98, 0xE1, 0xC5]);
struct DirectManipulationViewport;

const GUID CLSID_DirectManipulationUpdateManager = {0x9FC1BFD5, 0x1835, 0x441A, [0xB3, 0xB1, 0xB6, 0xCC, 0x74, 0xB7, 0x27, 0xD0]};
@GUID(0x9FC1BFD5, 0x1835, 0x441A, [0xB3, 0xB1, 0xB6, 0xCC, 0x74, 0xB7, 0x27, 0xD0]);
struct DirectManipulationUpdateManager;

const GUID CLSID_DirectManipulationPrimaryContent = {0xCAA02661, 0xD59E, 0x41C7, [0x83, 0x93, 0x3B, 0xA3, 0xBA, 0xCB, 0x6B, 0x57]};
@GUID(0xCAA02661, 0xD59E, 0x41C7, [0x83, 0x93, 0x3B, 0xA3, 0xBA, 0xCB, 0x6B, 0x57]);
struct DirectManipulationPrimaryContent;

const GUID CLSID_DirectManipulationManager = {0x54E211B6, 0x3650, 0x4F75, [0x83, 0x34, 0xFA, 0x35, 0x95, 0x98, 0xE1, 0xC5]};
@GUID(0x54E211B6, 0x3650, 0x4F75, [0x83, 0x34, 0xFA, 0x35, 0x95, 0x98, 0xE1, 0xC5]);
struct DirectManipulationManager;

const GUID CLSID_DirectManipulationSharedManager = {0x99793286, 0x77CC, 0x4B57, [0x96, 0xDB, 0x3B, 0x35, 0x4F, 0x6F, 0x9F, 0xB5]};
@GUID(0x99793286, 0x77CC, 0x4B57, [0x96, 0xDB, 0x3B, 0x35, 0x4F, 0x6F, 0x9F, 0xB5]);
struct DirectManipulationSharedManager;

const GUID CLSID_DCompManipulationCompositor = {0x79DEA627, 0xA08A, 0x43AC, [0x8E, 0xF5, 0x69, 0x00, 0xB9, 0x29, 0x91, 0x26]};
@GUID(0x79DEA627, 0xA08A, 0x43AC, [0x8E, 0xF5, 0x69, 0x00, 0xB9, 0x29, 0x91, 0x26]);
struct DCompManipulationCompositor;

enum DIRECTMANIPULATION_STATUS
{
    DIRECTMANIPULATION_BUILDING = 0,
    DIRECTMANIPULATION_ENABLED = 1,
    DIRECTMANIPULATION_DISABLED = 2,
    DIRECTMANIPULATION_RUNNING = 3,
    DIRECTMANIPULATION_INERTIA = 4,
    DIRECTMANIPULATION_READY = 5,
    DIRECTMANIPULATION_SUSPENDED = 6,
}

enum DIRECTMANIPULATION_HITTEST_TYPE
{
    DIRECTMANIPULATION_HITTEST_TYPE_ASYNCHRONOUS = 0,
    DIRECTMANIPULATION_HITTEST_TYPE_SYNCHRONOUS = 1,
    DIRECTMANIPULATION_HITTEST_TYPE_AUTO_SYNCHRONOUS = 2,
}

enum DIRECTMANIPULATION_CONFIGURATION
{
    DIRECTMANIPULATION_CONFIGURATION_NONE = 0,
    DIRECTMANIPULATION_CONFIGURATION_INTERACTION = 1,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_X = 2,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_Y = 4,
    DIRECTMANIPULATION_CONFIGURATION_SCALING = 16,
    DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_INERTIA = 32,
    DIRECTMANIPULATION_CONFIGURATION_SCALING_INERTIA = 128,
    DIRECTMANIPULATION_CONFIGURATION_RAILS_X = 256,
    DIRECTMANIPULATION_CONFIGURATION_RAILS_Y = 512,
}

enum DIRECTMANIPULATION_GESTURE_CONFIGURATION
{
    DIRECTMANIPULATION_GESTURE_NONE = 0,
    DIRECTMANIPULATION_GESTURE_DEFAULT = 0,
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_VERTICAL = 8,
    DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_HORIZONTAL = 16,
    DIRECTMANIPULATION_GESTURE_PINCH_ZOOM = 32,
}

enum DIRECTMANIPULATION_MOTION_TYPES
{
    DIRECTMANIPULATION_MOTION_NONE = 0,
    DIRECTMANIPULATION_MOTION_TRANSLATEX = 1,
    DIRECTMANIPULATION_MOTION_TRANSLATEY = 2,
    DIRECTMANIPULATION_MOTION_ZOOM = 4,
    DIRECTMANIPULATION_MOTION_CENTERX = 16,
    DIRECTMANIPULATION_MOTION_CENTERY = 32,
    DIRECTMANIPULATION_MOTION_ALL = 55,
}

enum DIRECTMANIPULATION_VIEWPORT_OPTIONS
{
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DEFAULT = 0,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_AUTODISABLE = 1,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_MANUALUPDATE = 2,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_INPUT = 4,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_EXPLICITHITTEST = 8,
    DIRECTMANIPULATION_VIEWPORT_OPTIONS_DISABLEPIXELSNAPPING = 16,
}

enum DIRECTMANIPULATION_SNAPPOINT_TYPE
{
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY = 0,
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL = 1,
    DIRECTMANIPULATION_SNAPPOINT_MANDATORY_SINGLE = 2,
    DIRECTMANIPULATION_SNAPPOINT_OPTIONAL_SINGLE = 3,
}

enum DIRECTMANIPULATION_SNAPPOINT_COORDINATE
{
    DIRECTMANIPULATION_COORDINATE_BOUNDARY = 0,
    DIRECTMANIPULATION_COORDINATE_ORIGIN = 1,
    DIRECTMANIPULATION_COORDINATE_MIRRORED = 16,
}

enum DIRECTMANIPULATION_HORIZONTALALIGNMENT
{
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_NONE = 0,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_LEFT = 1,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_CENTER = 2,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_RIGHT = 4,
    DIRECTMANIPULATION_HORIZONTALALIGNMENT_UNLOCKCENTER = 8,
}

enum DIRECTMANIPULATION_VERTICALALIGNMENT
{
    DIRECTMANIPULATION_VERTICALALIGNMENT_NONE = 0,
    DIRECTMANIPULATION_VERTICALALIGNMENT_TOP = 1,
    DIRECTMANIPULATION_VERTICALALIGNMENT_CENTER = 2,
    DIRECTMANIPULATION_VERTICALALIGNMENT_BOTTOM = 4,
    DIRECTMANIPULATION_VERTICALALIGNMENT_UNLOCKCENTER = 8,
}

enum DIRECTMANIPULATION_INPUT_MODE
{
    DIRECTMANIPULATION_INPUT_MODE_AUTOMATIC = 0,
    DIRECTMANIPULATION_INPUT_MODE_MANUAL = 1,
}

const GUID IID_IDirectManipulationManager = {0xFBF5D3B4, 0x70C7, 0x4163, [0x93, 0x22, 0x5A, 0x6F, 0x66, 0x0D, 0x6F, 0xBC]};
@GUID(0xFBF5D3B4, 0x70C7, 0x4163, [0x93, 0x22, 0x5A, 0x6F, 0x66, 0x0D, 0x6F, 0xBC]);
interface IDirectManipulationManager : IUnknown
{
    HRESULT Activate(HWND window);
    HRESULT Deactivate(HWND window);
    HRESULT RegisterHitTestTarget(HWND window, HWND hitTestWindow, DIRECTMANIPULATION_HITTEST_TYPE type);
    HRESULT ProcessInput(const(MSG)* message, int* handled);
    HRESULT GetUpdateManager(const(Guid)* riid, void** object);
    HRESULT CreateViewport(IDirectManipulationFrameInfoProvider frameInfo, HWND window, const(Guid)* riid, void** object);
    HRESULT CreateContent(IDirectManipulationFrameInfoProvider frameInfo, const(Guid)* clsid, const(Guid)* riid, void** object);
}

const GUID IID_IDirectManipulationManager2 = {0xFA1005E9, 0x3D16, 0x484C, [0xBF, 0xC9, 0x62, 0xB6, 0x1E, 0x56, 0xEC, 0x4E]};
@GUID(0xFA1005E9, 0x3D16, 0x484C, [0xBF, 0xC9, 0x62, 0xB6, 0x1E, 0x56, 0xEC, 0x4E]);
interface IDirectManipulationManager2 : IDirectManipulationManager
{
    HRESULT CreateBehavior(const(Guid)* clsid, const(Guid)* riid, void** object);
}

const GUID IID_IDirectManipulationManager3 = {0x2CB6B33D, 0xFFE8, 0x488C, [0xB7, 0x50, 0xFB, 0xDF, 0xE8, 0x8D, 0xCA, 0x8C]};
@GUID(0x2CB6B33D, 0xFFE8, 0x488C, [0xB7, 0x50, 0xFB, 0xDF, 0xE8, 0x8D, 0xCA, 0x8C]);
interface IDirectManipulationManager3 : IDirectManipulationManager2
{
    HRESULT GetService(const(Guid)* clsid, const(Guid)* riid, void** object);
}

const GUID IID_IDirectManipulationViewport = {0x28B85A3D, 0x60A0, 0x48BD, [0x9B, 0xA1, 0x5C, 0xE8, 0xD9, 0xEA, 0x3A, 0x6D]};
@GUID(0x28B85A3D, 0x60A0, 0x48BD, [0x9B, 0xA1, 0x5C, 0xE8, 0xD9, 0xEA, 0x3A, 0x6D]);
interface IDirectManipulationViewport : IUnknown
{
    HRESULT Enable();
    HRESULT Disable();
    HRESULT SetContact(uint pointerId);
    HRESULT ReleaseContact(uint pointerId);
    HRESULT ReleaseAllContacts();
    HRESULT GetStatus(DIRECTMANIPULATION_STATUS* status);
    HRESULT GetTag(const(Guid)* riid, void** object, uint* id);
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetViewportRect(RECT* viewport);
    HRESULT SetViewportRect(const(RECT)* viewport);
    HRESULT ZoomToRect(const(float) left, const(float) top, const(float) right, const(float) bottom, BOOL animate);
    HRESULT SetViewportTransform(char* matrix, uint pointCount);
    HRESULT SyncDisplayTransform(char* matrix, uint pointCount);
    HRESULT GetPrimaryContent(const(Guid)* riid, void** object);
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

const GUID IID_IDirectManipulationViewport2 = {0x923CCAAC, 0x61E1, 0x4385, [0xB7, 0x26, 0x01, 0x7A, 0xF1, 0x89, 0x88, 0x2A]};
@GUID(0x923CCAAC, 0x61E1, 0x4385, [0xB7, 0x26, 0x01, 0x7A, 0xF1, 0x89, 0x88, 0x2A]);
interface IDirectManipulationViewport2 : IDirectManipulationViewport
{
    HRESULT AddBehavior(IUnknown behavior, uint* cookie);
    HRESULT RemoveBehavior(uint cookie);
    HRESULT RemoveAllBehaviors();
}

const GUID IID_IDirectManipulationViewportEventHandler = {0x952121DA, 0xD69F, 0x45F9, [0xB0, 0xF9, 0xF2, 0x39, 0x44, 0x32, 0x1A, 0x6D]};
@GUID(0x952121DA, 0xD69F, 0x45F9, [0xB0, 0xF9, 0xF2, 0x39, 0x44, 0x32, 0x1A, 0x6D]);
interface IDirectManipulationViewportEventHandler : IUnknown
{
    HRESULT OnViewportStatusChanged(IDirectManipulationViewport viewport, DIRECTMANIPULATION_STATUS current, DIRECTMANIPULATION_STATUS previous);
    HRESULT OnViewportUpdated(IDirectManipulationViewport viewport);
    HRESULT OnContentUpdated(IDirectManipulationViewport viewport, IDirectManipulationContent content);
}

const GUID IID_IDirectManipulationContent = {0xB89962CB, 0x3D89, 0x442B, [0xBB, 0x58, 0x50, 0x98, 0xFA, 0x0F, 0x9F, 0x16]};
@GUID(0xB89962CB, 0x3D89, 0x442B, [0xBB, 0x58, 0x50, 0x98, 0xFA, 0x0F, 0x9F, 0x16]);
interface IDirectManipulationContent : IUnknown
{
    HRESULT GetContentRect(RECT* contentSize);
    HRESULT SetContentRect(const(RECT)* contentSize);
    HRESULT GetViewport(const(Guid)* riid, void** object);
    HRESULT GetTag(const(Guid)* riid, void** object, uint* id);
    HRESULT SetTag(IUnknown object, uint id);
    HRESULT GetOutputTransform(char* matrix, uint pointCount);
    HRESULT GetContentTransform(char* matrix, uint pointCount);
    HRESULT SyncContentTransform(char* matrix, uint pointCount);
}

const GUID IID_IDirectManipulationPrimaryContent = {0xC12851E4, 0x1698, 0x4625, [0xB9, 0xB1, 0x7C, 0xA3, 0xEC, 0x18, 0x63, 0x0B]};
@GUID(0xC12851E4, 0x1698, 0x4625, [0xB9, 0xB1, 0x7C, 0xA3, 0xEC, 0x18, 0x63, 0x0B]);
interface IDirectManipulationPrimaryContent : IUnknown
{
    HRESULT SetSnapInterval(DIRECTMANIPULATION_MOTION_TYPES motion, float interval, float offset);
    HRESULT SetSnapPoints(DIRECTMANIPULATION_MOTION_TYPES motion, char* points, uint pointCount);
    HRESULT SetSnapType(DIRECTMANIPULATION_MOTION_TYPES motion, DIRECTMANIPULATION_SNAPPOINT_TYPE type);
    HRESULT SetSnapCoordinate(DIRECTMANIPULATION_MOTION_TYPES motion, DIRECTMANIPULATION_SNAPPOINT_COORDINATE coordinate, float origin);
    HRESULT SetZoomBoundaries(float zoomMinimum, float zoomMaximum);
    HRESULT SetHorizontalAlignment(DIRECTMANIPULATION_HORIZONTALALIGNMENT alignment);
    HRESULT SetVerticalAlignment(DIRECTMANIPULATION_VERTICALALIGNMENT alignment);
    HRESULT GetInertiaEndTransform(char* matrix, uint pointCount);
    HRESULT GetCenterPoint(float* centerX, float* centerY);
}

enum DIRECTMANIPULATION_DRAG_DROP_STATUS
{
    DIRECTMANIPULATION_DRAG_DROP_READY = 0,
    DIRECTMANIPULATION_DRAG_DROP_PRESELECT = 1,
    DIRECTMANIPULATION_DRAG_DROP_SELECTING = 2,
    DIRECTMANIPULATION_DRAG_DROP_DRAGGING = 3,
    DIRECTMANIPULATION_DRAG_DROP_CANCELLED = 4,
    DIRECTMANIPULATION_DRAG_DROP_COMMITTED = 5,
}

const GUID IID_IDirectManipulationDragDropEventHandler = {0x1FA11B10, 0x701B, 0x41AE, [0xB5, 0xF2, 0x49, 0xE3, 0x6B, 0xD5, 0x95, 0xAA]};
@GUID(0x1FA11B10, 0x701B, 0x41AE, [0xB5, 0xF2, 0x49, 0xE3, 0x6B, 0xD5, 0x95, 0xAA]);
interface IDirectManipulationDragDropEventHandler : IUnknown
{
    HRESULT OnDragDropStatusChange(IDirectManipulationViewport2 viewport, DIRECTMANIPULATION_DRAG_DROP_STATUS current, DIRECTMANIPULATION_DRAG_DROP_STATUS previous);
}

enum DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION
{
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_VERTICAL = 1,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HORIZONTAL = 2,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_ONLY = 16,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_DRAG = 32,
    DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HOLD_DRAG = 64,
}

const GUID IID_IDirectManipulationDragDropBehavior = {0x814B5AF5, 0xC2C8, 0x4270, [0xA9, 0xB7, 0xA1, 0x98, 0xCE, 0x8D, 0x02, 0xFA]};
@GUID(0x814B5AF5, 0xC2C8, 0x4270, [0xA9, 0xB7, 0xA1, 0x98, 0xCE, 0x8D, 0x02, 0xFA]);
interface IDirectManipulationDragDropBehavior : IUnknown
{
    HRESULT SetConfiguration(DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION configuration);
    HRESULT GetStatus(DIRECTMANIPULATION_DRAG_DROP_STATUS* status);
}

enum DIRECTMANIPULATION_INTERACTION_TYPE
{
    DIRECTMANIPULATION_INTERACTION_BEGIN = 0,
    DIRECTMANIPULATION_INTERACTION_TYPE_MANIPULATION = 1,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_TAP = 2,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_HOLD = 3,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_CROSS_SLIDE = 4,
    DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_PINCH_ZOOM = 5,
    DIRECTMANIPULATION_INTERACTION_END = 100,
}

const GUID IID_IDirectManipulationInteractionEventHandler = {0xE43F45B8, 0x42B4, 0x403E, [0xB1, 0xF2, 0x27, 0x3B, 0x8F, 0x51, 0x08, 0x30]};
@GUID(0xE43F45B8, 0x42B4, 0x403E, [0xB1, 0xF2, 0x27, 0x3B, 0x8F, 0x51, 0x08, 0x30]);
interface IDirectManipulationInteractionEventHandler : IUnknown
{
    HRESULT OnInteraction(IDirectManipulationViewport2 viewport, DIRECTMANIPULATION_INTERACTION_TYPE interaction);
}

const GUID IID_IDirectManipulationFrameInfoProvider = {0xFB759DBA, 0x6F4C, 0x4C01, [0x87, 0x4E, 0x19, 0xC8, 0xA0, 0x59, 0x07, 0xF9]};
@GUID(0xFB759DBA, 0x6F4C, 0x4C01, [0x87, 0x4E, 0x19, 0xC8, 0xA0, 0x59, 0x07, 0xF9]);
interface IDirectManipulationFrameInfoProvider : IUnknown
{
    HRESULT GetNextFrameInfo(ulong* time, ulong* processTime, ulong* compositionTime);
}

const GUID IID_IDirectManipulationCompositor = {0x537A0825, 0x0387, 0x4EFA, [0xB6, 0x2F, 0x71, 0xEB, 0x1F, 0x08, 0x5A, 0x7E]};
@GUID(0x537A0825, 0x0387, 0x4EFA, [0xB6, 0x2F, 0x71, 0xEB, 0x1F, 0x08, 0x5A, 0x7E]);
interface IDirectManipulationCompositor : IUnknown
{
    HRESULT AddContent(IDirectManipulationContent content, IUnknown device, IUnknown parentVisual, IUnknown childVisual);
    HRESULT RemoveContent(IDirectManipulationContent content);
    HRESULT SetUpdateManager(IDirectManipulationUpdateManager updateManager);
    HRESULT Flush();
}

const GUID IID_IDirectManipulationCompositor2 = {0xD38C7822, 0xF1CB, 0x43CB, [0xB4, 0xB9, 0xAC, 0x0C, 0x76, 0x7A, 0x41, 0x2E]};
@GUID(0xD38C7822, 0xF1CB, 0x43CB, [0xB4, 0xB9, 0xAC, 0x0C, 0x76, 0x7A, 0x41, 0x2E]);
interface IDirectManipulationCompositor2 : IDirectManipulationCompositor
{
    HRESULT AddContentWithCrossProcessChaining(IDirectManipulationPrimaryContent content, IUnknown device, IUnknown parentVisual, IUnknown childVisual);
}

const GUID IID_IDirectManipulationUpdateHandler = {0x790B6337, 0x64F8, 0x4FF5, [0xA2, 0x69, 0xB3, 0x2B, 0xC2, 0xAF, 0x27, 0xA7]};
@GUID(0x790B6337, 0x64F8, 0x4FF5, [0xA2, 0x69, 0xB3, 0x2B, 0xC2, 0xAF, 0x27, 0xA7]);
interface IDirectManipulationUpdateHandler : IUnknown
{
    HRESULT Update();
}

const GUID IID_IDirectManipulationUpdateManager = {0xB0AE62FD, 0xBE34, 0x46E7, [0x9C, 0xAA, 0xD3, 0x61, 0xFA, 0xCB, 0xB9, 0xCC]};
@GUID(0xB0AE62FD, 0xBE34, 0x46E7, [0x9C, 0xAA, 0xD3, 0x61, 0xFA, 0xCB, 0xB9, 0xCC]);
interface IDirectManipulationUpdateManager : IUnknown
{
    HRESULT RegisterWaitHandleCallback(HANDLE handle, IDirectManipulationUpdateHandler eventHandler, uint* cookie);
    HRESULT UnregisterWaitHandleCallback(uint cookie);
    HRESULT Update(IDirectManipulationFrameInfoProvider frameInfo);
}

enum DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION
{
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_STOP = 0,
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_FORWARD = 1,
    DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_REVERSE = 2,
}

const GUID IID_IDirectManipulationAutoScrollBehavior = {0x6D5954D4, 0x2003, 0x4356, [0x9B, 0x31, 0xD0, 0x51, 0xC9, 0xFF, 0x0A, 0xF7]};
@GUID(0x6D5954D4, 0x2003, 0x4356, [0x9B, 0x31, 0xD0, 0x51, 0xC9, 0xFF, 0x0A, 0xF7]);
interface IDirectManipulationAutoScrollBehavior : IUnknown
{
    HRESULT SetConfiguration(DIRECTMANIPULATION_MOTION_TYPES motionTypes, DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION scrollMotion);
}

const GUID IID_IDirectManipulationDeferContactService = {0x652D5C71, 0xFE60, 0x4A98, [0xBE, 0x70, 0xE5, 0xF2, 0x12, 0x91, 0xE7, 0xF1]};
@GUID(0x652D5C71, 0xFE60, 0x4A98, [0xBE, 0x70, 0xE5, 0xF2, 0x12, 0x91, 0xE7, 0xF1]);
interface IDirectManipulationDeferContactService : IUnknown
{
    HRESULT DeferContact(uint pointerId, uint timeout);
    HRESULT CancelContact(uint pointerId);
    HRESULT CancelDeferral(uint pointerId);
}

