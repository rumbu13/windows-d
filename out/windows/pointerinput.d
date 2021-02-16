module windows.pointerinput;

public import windows.core;
public import windows.displaydevices : POINT, RECT;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    POINTER_CHANGE_NONE              = 0x00000000,
    POINTER_CHANGE_FIRSTBUTTON_DOWN  = 0x00000001,
    POINTER_CHANGE_FIRSTBUTTON_UP    = 0x00000002,
    POINTER_CHANGE_SECONDBUTTON_DOWN = 0x00000003,
    POINTER_CHANGE_SECONDBUTTON_UP   = 0x00000004,
    POINTER_CHANGE_THIRDBUTTON_DOWN  = 0x00000005,
    POINTER_CHANGE_THIRDBUTTON_UP    = 0x00000006,
    POINTER_CHANGE_FOURTHBUTTON_DOWN = 0x00000007,
    POINTER_CHANGE_FOURTHBUTTON_UP   = 0x00000008,
    POINTER_CHANGE_FIFTHBUTTON_DOWN  = 0x00000009,
    POINTER_CHANGE_FIFTHBUTTON_UP    = 0x0000000a,
}
alias POINTER_BUTTON_CHANGE_TYPE = int;

// Structs


struct POINTER_INFO
{
    uint   pointerType;
    uint   pointerId;
    uint   frameId;
    uint   pointerFlags;
    HANDLE sourceDevice;
    HWND   hwndTarget;
    POINT  ptPixelLocation;
    POINT  ptHimetricLocation;
    POINT  ptPixelLocationRaw;
    POINT  ptHimetricLocationRaw;
    uint   dwTime;
    uint   historyCount;
    int    InputData;
    uint   dwKeyStates;
    ulong  PerformanceCount;
    POINTER_BUTTON_CHANGE_TYPE ButtonChangeType;
}

struct POINTER_TOUCH_INFO
{
    POINTER_INFO pointerInfo;
    uint         touchFlags;
    uint         touchMask;
    RECT         rcContact;
    RECT         rcContactRaw;
    uint         orientation;
    uint         pressure;
}

struct POINTER_PEN_INFO
{
    POINTER_INFO pointerInfo;
    uint         penFlags;
    uint         penMask;
    uint         pressure;
    uint         rotation;
    int          tiltX;
    int          tiltY;
}

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

@DllImport("USER32")
uint GetUnpredictedMessagePos();

@DllImport("USER32")
BOOL GetPointerType(uint pointerId, uint* pointerType);

@DllImport("USER32")
BOOL GetPointerCursorId(uint pointerId, uint* cursorId);

@DllImport("USER32")
BOOL GetPointerInfo(uint pointerId, POINTER_INFO* pointerInfo);

@DllImport("USER32")
BOOL GetPointerInfoHistory(uint pointerId, uint* entriesCount, char* pointerInfo);

@DllImport("USER32")
BOOL GetPointerFrameInfo(uint pointerId, uint* pointerCount, char* pointerInfo);

@DllImport("USER32")
BOOL GetPointerFrameInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, char* pointerInfo);

@DllImport("USER32")
BOOL GetPointerTouchInfo(uint pointerId, POINTER_TOUCH_INFO* touchInfo);

@DllImport("USER32")
BOOL GetPointerTouchInfoHistory(uint pointerId, uint* entriesCount, char* touchInfo);

@DllImport("USER32")
BOOL GetPointerFrameTouchInfo(uint pointerId, uint* pointerCount, char* touchInfo);

@DllImport("USER32")
BOOL GetPointerFrameTouchInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, char* touchInfo);

@DllImport("USER32")
BOOL GetPointerPenInfo(uint pointerId, POINTER_PEN_INFO* penInfo);

@DllImport("USER32")
BOOL GetPointerPenInfoHistory(uint pointerId, uint* entriesCount, char* penInfo);

@DllImport("USER32")
BOOL GetPointerFramePenInfo(uint pointerId, uint* pointerCount, char* penInfo);

@DllImport("USER32")
BOOL GetPointerFramePenInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, char* penInfo);

@DllImport("USER32")
BOOL SkipPointerFrameMessages(uint pointerId);

@DllImport("USER32")
BOOL EnableMouseInPointer(BOOL fEnable);

@DllImport("USER32")
BOOL IsMouseInPointerEnabled();

@DllImport("USER32")
BOOL GetPointerInputTransform(uint pointerId, uint historyCount, char* inputTransform);


