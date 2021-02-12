module windows.touchinput;

public import windows.com;
public import windows.displaydevices;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct TOUCHINPUT
{
    int x;
    int y;
    HANDLE hSource;
    uint dwID;
    uint dwFlags;
    uint dwMask;
    uint dwTime;
    uint dwExtraInfo;
    uint cxContact;
    uint cyContact;
}

struct GESTUREINFO
{
    uint cbSize;
    uint dwFlags;
    uint dwID;
    HWND hwndTarget;
    POINTS ptsLocation;
    uint dwInstanceID;
    uint dwSequenceID;
    ulong ullArguments;
    uint cbExtraArgs;
}

struct GESTURENOTIFYSTRUCT
{
    uint cbSize;
    uint dwFlags;
    HWND hwndTarget;
    POINTS ptsLocation;
    uint dwInstanceID;
}

struct GESTURECONFIG
{
    uint dwID;
    uint dwWant;
    uint dwBlock;
}

@DllImport("USER32.dll")
BOOL GetTouchInputInfo(int hTouchInput, uint cInputs, char* pInputs, int cbSize);

@DllImport("USER32.dll")
BOOL CloseTouchInputHandle(int hTouchInput);

@DllImport("USER32.dll")
BOOL RegisterTouchWindow(HWND hwnd, uint ulFlags);

@DllImport("USER32.dll")
BOOL UnregisterTouchWindow(HWND hwnd);

@DllImport("USER32.dll")
BOOL IsTouchWindow(HWND hwnd, uint* pulFlags);

@DllImport("USER32.dll")
BOOL GetGestureInfo(int hGestureInfo, GESTUREINFO* pGestureInfo);

@DllImport("USER32.dll")
BOOL GetGestureExtraArgs(int hGestureInfo, uint cbExtraArgs, char* pExtraArgs);

@DllImport("USER32.dll")
BOOL CloseGestureInfoHandle(int hGestureInfo);

@DllImport("USER32.dll")
BOOL SetGestureConfig(HWND hwnd, uint dwReserved, uint cIDs, char* pGestureConfig, uint cbSize);

@DllImport("USER32.dll")
BOOL GetGestureConfig(HWND hwnd, uint dwReserved, uint dwFlags, uint* pcIDs, char* pGestureConfig, uint cbSize);

const GUID CLSID_InertiaProcessor = {0xABB27087, 0x4CE0, 0x4E58, [0xA0, 0xCB, 0xE2, 0x4D, 0xF9, 0x68, 0x14, 0xBE]};
@GUID(0xABB27087, 0x4CE0, 0x4E58, [0xA0, 0xCB, 0xE2, 0x4D, 0xF9, 0x68, 0x14, 0xBE]);
struct InertiaProcessor;

const GUID CLSID_ManipulationProcessor = {0x597D4FB0, 0x47FD, 0x4AFF, [0x89, 0xB9, 0xC6, 0xCF, 0xAE, 0x8C, 0xF0, 0x8E]};
@GUID(0x597D4FB0, 0x47FD, 0x4AFF, [0x89, 0xB9, 0xC6, 0xCF, 0xAE, 0x8C, 0xF0, 0x8E]);
struct ManipulationProcessor;

enum MANIPULATION_PROCESSOR_MANIPULATIONS
{
    MANIPULATION_NONE = 0,
    MANIPULATION_TRANSLATE_X = 1,
    MANIPULATION_TRANSLATE_Y = 2,
    MANIPULATION_SCALE = 4,
    MANIPULATION_ROTATE = 8,
    MANIPULATION_ALL = 15,
}

const GUID IID__IManipulationEvents = {0x4F62C8DA, 0x9C53, 0x4B22, [0x93, 0xDF, 0x92, 0x7A, 0x86, 0x2B, 0xBB, 0x03]};
@GUID(0x4F62C8DA, 0x9C53, 0x4B22, [0x93, 0xDF, 0x92, 0x7A, 0x86, 0x2B, 0xBB, 0x03]);
interface _IManipulationEvents : IUnknown
{
    HRESULT ManipulationStarted(float x, float y);
    HRESULT ManipulationDelta(float x, float y, float translationDeltaX, float translationDeltaY, float scaleDelta, float expansionDelta, float rotationDelta, float cumulativeTranslationX, float cumulativeTranslationY, float cumulativeScale, float cumulativeExpansion, float cumulativeRotation);
    HRESULT ManipulationCompleted(float x, float y, float cumulativeTranslationX, float cumulativeTranslationY, float cumulativeScale, float cumulativeExpansion, float cumulativeRotation);
}

const GUID IID_IInertiaProcessor = {0x18B00C6D, 0xC5EE, 0x41B1, [0x90, 0xA9, 0x9D, 0x4A, 0x92, 0x90, 0x95, 0xAD]};
@GUID(0x18B00C6D, 0xC5EE, 0x41B1, [0x90, 0xA9, 0x9D, 0x4A, 0x92, 0x90, 0x95, 0xAD]);
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

const GUID IID_IManipulationProcessor = {0xA22AC519, 0x8300, 0x48A0, [0xBE, 0xF4, 0xF1, 0xBE, 0x87, 0x37, 0xDB, 0xA4]};
@GUID(0xA22AC519, 0x8300, 0x48A0, [0xBE, 0xF4, 0xF1, 0xBE, 0x87, 0x37, 0xDB, 0xA4]);
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

