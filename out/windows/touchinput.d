module windows.touchinput;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : POINTS;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    MANIPULATION_NONE        = 0x00000000,
    MANIPULATION_TRANSLATE_X = 0x00000001,
    MANIPULATION_TRANSLATE_Y = 0x00000002,
    MANIPULATION_SCALE       = 0x00000004,
    MANIPULATION_ROTATE      = 0x00000008,
    MANIPULATION_ALL         = 0x0000000f,
}
alias MANIPULATION_PROCESSOR_MANIPULATIONS = int;

// Constants


enum float POSITIVE_INFINITY = float.infinity;
enum float NaN = -float.nan;

// Structs


struct TOUCHINPUT
{
    int    x;
    int    y;
    HANDLE hSource;
    uint   dwID;
    uint   dwFlags;
    uint   dwMask;
    uint   dwTime;
    size_t dwExtraInfo;
    uint   cxContact;
    uint   cyContact;
}

struct GESTUREINFO
{
    uint   cbSize;
    uint   dwFlags;
    uint   dwID;
    HWND   hwndTarget;
    POINTS ptsLocation;
    uint   dwInstanceID;
    uint   dwSequenceID;
    ulong  ullArguments;
    uint   cbExtraArgs;
}

struct GESTURENOTIFYSTRUCT
{
    uint   cbSize;
    uint   dwFlags;
    HWND   hwndTarget;
    POINTS ptsLocation;
    uint   dwInstanceID;
}

struct GESTURECONFIG
{
    uint dwID;
    uint dwWant;
    uint dwBlock;
}

// Functions

@DllImport("USER32")
BOOL GetTouchInputInfo(ptrdiff_t hTouchInput, uint cInputs, char* pInputs, int cbSize);

@DllImport("USER32")
BOOL CloseTouchInputHandle(ptrdiff_t hTouchInput);

@DllImport("USER32")
BOOL RegisterTouchWindow(HWND hwnd, uint ulFlags);

@DllImport("USER32")
BOOL UnregisterTouchWindow(HWND hwnd);

@DllImport("USER32")
BOOL IsTouchWindow(HWND hwnd, uint* pulFlags);

@DllImport("USER32")
BOOL GetGestureInfo(ptrdiff_t hGestureInfo, GESTUREINFO* pGestureInfo);

@DllImport("USER32")
BOOL GetGestureExtraArgs(ptrdiff_t hGestureInfo, uint cbExtraArgs, char* pExtraArgs);

@DllImport("USER32")
BOOL CloseGestureInfoHandle(ptrdiff_t hGestureInfo);

@DllImport("USER32")
BOOL SetGestureConfig(HWND hwnd, uint dwReserved, uint cIDs, char* pGestureConfig, uint cbSize);

@DllImport("USER32")
BOOL GetGestureConfig(HWND hwnd, uint dwReserved, uint dwFlags, uint* pcIDs, char* pGestureConfig, uint cbSize);


// Interfaces

@GUID("ABB27087-4CE0-4E58-A0CB-E24DF96814BE")
struct InertiaProcessor;

@GUID("597D4FB0-47FD-4AFF-89B9-C6CFAE8CF08E")
struct ManipulationProcessor;

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

@GUID("18B00C6D-C5EE-41B1-90A9-9D4A929095AD")
interface IInertiaProcessor : IUnknown
{
    HRESULT get_InitialOriginX(float* x);
    HRESULT put_InitialOriginX(float x);
    HRESULT get_InitialOriginY(float* y);
    HRESULT put_InitialOriginY(float y);
    HRESULT get_InitialVelocityX(float* x);
    HRESULT put_InitialVelocityX(float x);
    HRESULT get_InitialVelocityY(float* y);
    HRESULT put_InitialVelocityY(float y);
    HRESULT get_InitialAngularVelocity(float* velocity);
    HRESULT put_InitialAngularVelocity(float velocity);
    HRESULT get_InitialExpansionVelocity(float* velocity);
    HRESULT put_InitialExpansionVelocity(float velocity);
    HRESULT get_InitialRadius(float* radius);
    HRESULT put_InitialRadius(float radius);
    HRESULT get_BoundaryLeft(float* left);
    HRESULT put_BoundaryLeft(float left);
    HRESULT get_BoundaryTop(float* top);
    HRESULT put_BoundaryTop(float top);
    HRESULT get_BoundaryRight(float* right);
    HRESULT put_BoundaryRight(float right);
    HRESULT get_BoundaryBottom(float* bottom);
    HRESULT put_BoundaryBottom(float bottom);
    HRESULT get_ElasticMarginLeft(float* left);
    HRESULT put_ElasticMarginLeft(float left);
    HRESULT get_ElasticMarginTop(float* top);
    HRESULT put_ElasticMarginTop(float top);
    HRESULT get_ElasticMarginRight(float* right);
    HRESULT put_ElasticMarginRight(float right);
    HRESULT get_ElasticMarginBottom(float* bottom);
    HRESULT put_ElasticMarginBottom(float bottom);
    HRESULT get_DesiredDisplacement(float* displacement);
    HRESULT put_DesiredDisplacement(float displacement);
    HRESULT get_DesiredRotation(float* rotation);
    HRESULT put_DesiredRotation(float rotation);
    HRESULT get_DesiredExpansion(float* expansion);
    HRESULT put_DesiredExpansion(float expansion);
    HRESULT get_DesiredDeceleration(float* deceleration);
    HRESULT put_DesiredDeceleration(float deceleration);
    HRESULT get_DesiredAngularDeceleration(float* deceleration);
    HRESULT put_DesiredAngularDeceleration(float deceleration);
    HRESULT get_DesiredExpansionDeceleration(float* deceleration);
    HRESULT put_DesiredExpansionDeceleration(float deceleration);
    HRESULT get_InitialTimestamp(uint* timestamp);
    HRESULT put_InitialTimestamp(uint timestamp);
    HRESULT Reset();
    HRESULT Process(int* completed);
    HRESULT ProcessTime(uint timestamp, int* completed);
    HRESULT Complete();
    HRESULT CompleteTime(uint timestamp);
}

@GUID("A22AC519-8300-48A0-BEF4-F1BE8737DBA4")
interface IManipulationProcessor : IUnknown
{
    HRESULT get_SupportedManipulations(MANIPULATION_PROCESSOR_MANIPULATIONS* manipulations);
    HRESULT put_SupportedManipulations(MANIPULATION_PROCESSOR_MANIPULATIONS manipulations);
    HRESULT get_PivotPointX(float* pivotPointX);
    HRESULT put_PivotPointX(float pivotPointX);
    HRESULT get_PivotPointY(float* pivotPointY);
    HRESULT put_PivotPointY(float pivotPointY);
    HRESULT get_PivotRadius(float* pivotRadius);
    HRESULT put_PivotRadius(float pivotRadius);
    HRESULT CompleteManipulation();
    HRESULT ProcessDown(uint manipulatorId, float x, float y);
    HRESULT ProcessMove(uint manipulatorId, float x, float y);
    HRESULT ProcessUp(uint manipulatorId, float x, float y);
    HRESULT ProcessDownWithTime(uint manipulatorId, float x, float y, uint timestamp);
    HRESULT ProcessMoveWithTime(uint manipulatorId, float x, float y, uint timestamp);
    HRESULT ProcessUpWithTime(uint manipulatorId, float x, float y, uint timestamp);
    HRESULT GetVelocityX(float* velocityX);
    HRESULT GetVelocityY(float* velocityY);
    HRESULT GetExpansionVelocity(float* expansionVelocity);
    HRESULT GetAngularVelocity(float* angularVelocity);
    HRESULT get_MinimumScaleRotateRadius(float* minRadius);
    HRESULT put_MinimumScaleRotateRadius(float minRadius);
}


// GUIDs

const GUID CLSID_InertiaProcessor      = GUIDOF!InertiaProcessor;
const GUID CLSID_ManipulationProcessor = GUIDOF!ManipulationProcessor;

const GUID IID_IInertiaProcessor      = GUIDOF!IInertiaProcessor;
const GUID IID_IManipulationProcessor = GUIDOF!IManipulationProcessor;
const GUID IID__IManipulationEvents   = GUIDOF!_IManipulationEvents;
