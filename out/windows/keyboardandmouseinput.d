module windows.keyboardandmouseinput;

public import windows.core;
public import windows.displaydevices : POINT;
public import windows.systemservices : BOOL, HANDLE, LRESULT;
public import windows.windowsandmessaging : HWND, WPARAM;

extern(Windows):


// Structs


struct MOUSEMOVEPOINT
{
    int    x;
    int    y;
    uint   time;
    size_t dwExtraInfo;
}

struct TRACKMOUSEEVENT
{
    uint cbSize;
    uint dwFlags;
    HWND hwndTrack;
    uint dwHoverTime;
}

struct MOUSEINPUT
{
    int    dx;
    int    dy;
    uint   mouseData;
    uint   dwFlags;
    uint   time;
    size_t dwExtraInfo;
}

struct KEYBDINPUT
{
    ushort wVk;
    ushort wScan;
    uint   dwFlags;
    uint   time;
    size_t dwExtraInfo;
}

struct HARDWAREINPUT
{
    uint   uMsg;
    ushort wParamL;
    ushort wParamH;
}

struct INPUT
{
    uint type;
    union
    {
        MOUSEINPUT    mi;
        KEYBDINPUT    ki;
        HARDWAREINPUT hi;
    }
}

struct LASTINPUTINFO
{
    uint cbSize;
    uint dwTime;
}

struct RAWINPUTHEADER
{
    uint   dwType;
    uint   dwSize;
    HANDLE hDevice;
    WPARAM wParam;
}

struct RAWMOUSE
{
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
    uint   ulRawButtons;
    int    lLastX;
    int    lLastY;
    uint   ulExtraInformation;
}

struct RAWKEYBOARD
{
    ushort MakeCode;
    ushort Flags;
    ushort Reserved;
    ushort VKey;
    uint   Message;
    uint   ExtraInformation;
}

struct RAWHID
{
    uint     dwSizeHid;
    uint     dwCount;
    ubyte[1] bRawData;
}

struct RAWINPUT
{
    RAWINPUTHEADER header;
    union data
    {
        RAWMOUSE    mouse;
        RAWKEYBOARD keyboard;
        RAWHID      hid;
    }
}

struct RID_DEVICE_INFO_MOUSE
{
    uint dwId;
    uint dwNumberOfButtons;
    uint dwSampleRate;
    BOOL fHasHorizontalWheel;
}

struct RID_DEVICE_INFO_KEYBOARD
{
    uint dwType;
    uint dwSubType;
    uint dwKeyboardMode;
    uint dwNumberOfFunctionKeys;
    uint dwNumberOfIndicators;
    uint dwNumberOfKeysTotal;
}

struct RID_DEVICE_INFO_HID
{
    uint   dwVendorId;
    uint   dwProductId;
    uint   dwVersionNumber;
    ushort usUsagePage;
    ushort usUsage;
}

struct RID_DEVICE_INFO
{
    uint cbSize;
    uint dwType;
    union
    {
        RID_DEVICE_INFO_MOUSE mouse;
        RID_DEVICE_INFO_KEYBOARD keyboard;
        RID_DEVICE_INFO_HID hid;
    }
}

struct RAWINPUTDEVICE
{
    ushort usUsagePage;
    ushort usUsage;
    uint   dwFlags;
    HWND   hwndTarget;
}

struct RAWINPUTDEVICELIST
{
    HANDLE hDevice;
    uint   dwType;
}

// Functions

@DllImport("COMCTL32")
BOOL _TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

@DllImport("USER32")
ptrdiff_t LoadKeyboardLayoutA(const(char)* pwszKLID, uint Flags);

@DllImport("USER32")
ptrdiff_t LoadKeyboardLayoutW(const(wchar)* pwszKLID, uint Flags);

@DllImport("USER32")
ptrdiff_t ActivateKeyboardLayout(ptrdiff_t hkl, uint Flags);

@DllImport("USER32")
int ToUnicodeEx(uint wVirtKey, uint wScanCode, char* lpKeyState, const(wchar)* pwszBuff, int cchBuff, uint wFlags, 
                ptrdiff_t dwhkl);

@DllImport("USER32")
BOOL UnloadKeyboardLayout(ptrdiff_t hkl);

@DllImport("USER32")
BOOL GetKeyboardLayoutNameA(const(char)* pwszKLID);

@DllImport("USER32")
BOOL GetKeyboardLayoutNameW(const(wchar)* pwszKLID);

@DllImport("USER32")
int GetKeyboardLayoutList(int nBuff, char* lpList);

@DllImport("USER32")
ptrdiff_t GetKeyboardLayout(uint idThread);

@DllImport("USER32")
int GetMouseMovePointsEx(uint cbSize, MOUSEMOVEPOINT* lppt, char* lpptBuf, int nBufPoints, uint resolution);

@DllImport("USER32")
BOOL TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

@DllImport("USER32")
BOOL RegisterHotKey(HWND hWnd, int id, uint fsModifiers, uint vk);

@DllImport("USER32")
BOOL UnregisterHotKey(HWND hWnd, int id);

@DllImport("USER32")
BOOL SwapMouseButton(BOOL fSwap);

@DllImport("USER32")
uint GetDoubleClickTime();

@DllImport("USER32")
BOOL SetDoubleClickTime(uint param0);

@DllImport("USER32")
HWND SetFocus(HWND hWnd);

@DllImport("USER32")
HWND GetActiveWindow();

@DllImport("USER32")
HWND GetFocus();

@DllImport("USER32")
uint GetKBCodePage();

@DllImport("USER32")
short GetKeyState(int nVirtKey);

@DllImport("USER32")
short GetAsyncKeyState(int vKey);

@DllImport("USER32")
BOOL GetKeyboardState(char* lpKeyState);

@DllImport("USER32")
BOOL SetKeyboardState(char* lpKeyState);

@DllImport("USER32")
int GetKeyNameTextA(int lParam, const(char)* lpString, int cchSize);

@DllImport("USER32")
int GetKeyNameTextW(int lParam, const(wchar)* lpString, int cchSize);

@DllImport("USER32")
int GetKeyboardType(int nTypeFlag);

@DllImport("USER32")
int ToAscii(uint uVirtKey, uint uScanCode, char* lpKeyState, ushort* lpChar, uint uFlags);

@DllImport("USER32")
int ToAsciiEx(uint uVirtKey, uint uScanCode, char* lpKeyState, ushort* lpChar, uint uFlags, ptrdiff_t dwhkl);

@DllImport("USER32")
int ToUnicode(uint wVirtKey, uint wScanCode, char* lpKeyState, const(wchar)* pwszBuff, int cchBuff, uint wFlags);

@DllImport("USER32")
uint OemKeyScan(ushort wOemChar);

@DllImport("USER32")
short VkKeyScanA(byte ch);

@DllImport("USER32")
short VkKeyScanW(ushort ch);

@DllImport("USER32")
short VkKeyScanExA(byte ch, ptrdiff_t dwhkl);

@DllImport("USER32")
short VkKeyScanExW(ushort ch, ptrdiff_t dwhkl);

@DllImport("USER32")
void keybd_event(ubyte bVk, ubyte bScan, uint dwFlags, size_t dwExtraInfo);

@DllImport("USER32")
void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, size_t dwExtraInfo);

@DllImport("USER32")
uint SendInput(uint cInputs, char* pInputs, int cbSize);

@DllImport("USER32")
BOOL GetLastInputInfo(LASTINPUTINFO* plii);

@DllImport("USER32")
uint MapVirtualKeyA(uint uCode, uint uMapType);

@DllImport("USER32")
uint MapVirtualKeyW(uint uCode, uint uMapType);

@DllImport("USER32")
uint MapVirtualKeyExA(uint uCode, uint uMapType, ptrdiff_t dwhkl);

@DllImport("USER32")
uint MapVirtualKeyExW(uint uCode, uint uMapType, ptrdiff_t dwhkl);

@DllImport("USER32")
HWND GetCapture();

@DllImport("USER32")
HWND SetCapture(HWND hWnd);

@DllImport("USER32")
BOOL ReleaseCapture();

@DllImport("USER32")
BOOL EnableWindow(HWND hWnd, BOOL bEnable);

@DllImport("USER32")
BOOL IsWindowEnabled(HWND hWnd);

@DllImport("USER32")
BOOL DragDetect(HWND hwnd, POINT pt);

@DllImport("USER32")
HWND SetActiveWindow(HWND hWnd);

@DllImport("USER32")
BOOL BlockInput(BOOL fBlockIt);

@DllImport("USER32")
uint GetRawInputData(ptrdiff_t hRawInput, uint uiCommand, char* pData, uint* pcbSize, uint cbSizeHeader);

@DllImport("USER32")
uint GetRawInputDeviceInfoA(HANDLE hDevice, uint uiCommand, char* pData, uint* pcbSize);

@DllImport("USER32")
uint GetRawInputDeviceInfoW(HANDLE hDevice, uint uiCommand, char* pData, uint* pcbSize);

@DllImport("USER32")
uint GetRawInputBuffer(char* pData, uint* pcbSize, uint cbSizeHeader);

@DllImport("USER32")
BOOL RegisterRawInputDevices(char* pRawInputDevices, uint uiNumDevices, uint cbSize);

@DllImport("USER32")
uint GetRegisteredRawInputDevices(char* pRawInputDevices, uint* puiNumDevices, uint cbSize);

@DllImport("USER32")
uint GetRawInputDeviceList(char* pRawInputDeviceList, uint* puiNumDevices, uint cbSize);

@DllImport("USER32")
LRESULT DefRawInputProc(char* paRawInput, int nInput, uint cbSizeHeader);


