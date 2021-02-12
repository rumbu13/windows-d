module windows.pointerinput;

public import windows.displaydevices;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

enum POINTER_BUTTON_CHANGE_TYPE
{
    POINTER_CHANGE_NONE = 0,
    POINTER_CHANGE_FIRSTBUTTON_DOWN = 1,
    POINTER_CHANGE_FIRSTBUTTON_UP = 2,
    POINTER_CHANGE_SECONDBUTTON_DOWN = 3,
    POINTER_CHANGE_SECONDBUTTON_UP = 4,
    POINTER_CHANGE_THIRDBUTTON_DOWN = 5,
    POINTER_CHANGE_THIRDBUTTON_UP = 6,
    POINTER_CHANGE_FOURTHBUTTON_DOWN = 7,
    POINTER_CHANGE_FOURTHBUTTON_UP = 8,
    POINTER_CHANGE_FIFTHBUTTON_DOWN = 9,
    POINTER_CHANGE_FIFTHBUTTON_UP = 10,
}

struct POINTER_INFO
{
    uint pointerType;
    uint pointerId;
    uint frameId;
    uint pointerFlags;
    HANDLE sourceDevice;
    HWND hwndTarget;
    POINT ptPixelLocation;
    POINT ptHimetricLocation;
    POINT ptPixelLocationRaw;
    POINT ptHimetricLocationRaw;
    uint dwTime;
    uint historyCount;
    int InputData;
    uint dwKeyStates;
    ulong PerformanceCount;
    POINTER_BUTTON_CHANGE_TYPE ButtonChangeType;
}

struct POINTER_TOUCH_INFO
{
    POINTER_INFO pointerInfo;
    uint touchFlags;
    uint touchMask;
    RECT rcContact;
    RECT rcContactRaw;
    uint orientation;
    uint pressure;
}

struct POINTER_PEN_INFO
{
    POINTER_INFO pointerInfo;
    uint penFlags;
    uint penMask;
    uint pressure;
    uint rotation;
    int tiltX;
    int tiltY;
}

struct INPUT_TRANSFORM
{
    _Anonymous_e__Union Anonymous;
}

@DllImport("USER32.dll")
uint GetUnpredictedMessagePos();

@DllImport("USER32.dll")
BOOL GetPointerType(uint pointerId, uint* pointerType);

@DllImport("USER32.dll")
BOOL GetPointerCursorId(uint pointerId, uint* cursorId);

@DllImport("USER32.dll")
BOOL GetPointerInfo(uint pointerId, POINTER_INFO* pointerInfo);

@DllImport("USER32.dll")
BOOL GetPointerInfoHistory(uint pointerId, uint* entriesCount, char* pointerInfo);

@DllImport("USER32.dll")
BOOL GetPointerFrameInfo(uint pointerId, uint* pointerCount, char* pointerInfo);

@DllImport("USER32.dll")
BOOL GetPointerFrameInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, char* pointerInfo);

@DllImport("USER32.dll")
BOOL GetPointerTouchInfo(uint pointerId, POINTER_TOUCH_INFO* touchInfo);

@DllImport("USER32.dll")
BOOL GetPointerTouchInfoHistory(uint pointerId, uint* entriesCount, char* touchInfo);

@DllImport("USER32.dll")
BOOL GetPointerFrameTouchInfo(uint pointerId, uint* pointerCount, char* touchInfo);

@DllImport("USER32.dll")
BOOL GetPointerFrameTouchInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, char* touchInfo);

@DllImport("USER32.dll")
BOOL GetPointerPenInfo(uint pointerId, POINTER_PEN_INFO* penInfo);

@DllImport("USER32.dll")
BOOL GetPointerPenInfoHistory(uint pointerId, uint* entriesCount, char* penInfo);

@DllImport("USER32.dll")
BOOL GetPointerFramePenInfo(uint pointerId, uint* pointerCount, char* penInfo);

@DllImport("USER32.dll")
BOOL GetPointerFramePenInfoHistory(uint pointerId, uint* entriesCount, uint* pointerCount, char* penInfo);

@DllImport("USER32.dll")
BOOL SkipPointerFrameMessages(uint pointerId);

@DllImport("USER32.dll")
BOOL EnableMouseInPointer(BOOL fEnable);

@DllImport("USER32.dll")
BOOL IsMouseInPointerEnabled();

@DllImport("USER32.dll")
BOOL GetPointerInputTransform(uint pointerId, uint historyCount, char* inputTransform);

