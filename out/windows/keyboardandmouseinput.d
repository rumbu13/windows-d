module windows.keyboardandmouseinput;

public import windows.displaydevices;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

@DllImport("COMCTL32.dll")
BOOL _TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

@DllImport("USER32.dll")
int LoadKeyboardLayoutA(const(char)* pwszKLID, uint Flags);

@DllImport("USER32.dll")
int LoadKeyboardLayoutW(const(wchar)* pwszKLID, uint Flags);

@DllImport("USER32.dll")
int ActivateKeyboardLayout(int hkl, uint Flags);

@DllImport("USER32.dll")
int ToUnicodeEx(uint wVirtKey, uint wScanCode, char* lpKeyState, const(wchar)* pwszBuff, int cchBuff, uint wFlags, int dwhkl);

@DllImport("USER32.dll")
BOOL UnloadKeyboardLayout(int hkl);

@DllImport("USER32.dll")
BOOL GetKeyboardLayoutNameA(const(char)* pwszKLID);

@DllImport("USER32.dll")
BOOL GetKeyboardLayoutNameW(const(wchar)* pwszKLID);

@DllImport("USER32.dll")
int GetKeyboardLayoutList(int nBuff, char* lpList);

@DllImport("USER32.dll")
int GetKeyboardLayout(uint idThread);

@DllImport("USER32.dll")
int GetMouseMovePointsEx(uint cbSize, MOUSEMOVEPOINT* lppt, char* lpptBuf, int nBufPoints, uint resolution);

@DllImport("USER32.dll")
BOOL TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

@DllImport("USER32.dll")
BOOL RegisterHotKey(HWND hWnd, int id, uint fsModifiers, uint vk);

@DllImport("USER32.dll")
BOOL UnregisterHotKey(HWND hWnd, int id);

@DllImport("USER32.dll")
BOOL SwapMouseButton(BOOL fSwap);

@DllImport("USER32.dll")
uint GetDoubleClickTime();

@DllImport("USER32.dll")
BOOL SetDoubleClickTime(uint param0);

@DllImport("USER32.dll")
HWND SetFocus(HWND hWnd);

@DllImport("USER32.dll")
HWND GetActiveWindow();

@DllImport("USER32.dll")
HWND GetFocus();

@DllImport("USER32.dll")
uint GetKBCodePage();

@DllImport("USER32.dll")
short GetKeyState(int nVirtKey);

@DllImport("USER32.dll")
short GetAsyncKeyState(int vKey);

@DllImport("USER32.dll")
BOOL GetKeyboardState(char* lpKeyState);

@DllImport("USER32.dll")
BOOL SetKeyboardState(char* lpKeyState);

@DllImport("USER32.dll")
int GetKeyNameTextA(int lParam, const(char)* lpString, int cchSize);

@DllImport("USER32.dll")
int GetKeyNameTextW(int lParam, const(wchar)* lpString, int cchSize);

@DllImport("USER32.dll")
int GetKeyboardType(int nTypeFlag);

@DllImport("USER32.dll")
int ToAscii(uint uVirtKey, uint uScanCode, char* lpKeyState, ushort* lpChar, uint uFlags);

@DllImport("USER32.dll")
int ToAsciiEx(uint uVirtKey, uint uScanCode, char* lpKeyState, ushort* lpChar, uint uFlags, int dwhkl);

@DllImport("USER32.dll")
int ToUnicode(uint wVirtKey, uint wScanCode, char* lpKeyState, const(wchar)* pwszBuff, int cchBuff, uint wFlags);

@DllImport("USER32.dll")
uint OemKeyScan(ushort wOemChar);

@DllImport("USER32.dll")
short VkKeyScanA(byte ch);

@DllImport("USER32.dll")
short VkKeyScanW(ushort ch);

@DllImport("USER32.dll")
short VkKeyScanExA(byte ch, int dwhkl);

@DllImport("USER32.dll")
short VkKeyScanExW(ushort ch, int dwhkl);

@DllImport("USER32.dll")
void keybd_event(ubyte bVk, ubyte bScan, uint dwFlags, uint dwExtraInfo);

@DllImport("USER32.dll")
void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, uint dwExtraInfo);

@DllImport("USER32.dll")
uint SendInput(uint cInputs, char* pInputs, int cbSize);

@DllImport("USER32.dll")
BOOL GetLastInputInfo(LASTINPUTINFO* plii);

@DllImport("USER32.dll")
uint MapVirtualKeyA(uint uCode, uint uMapType);

@DllImport("USER32.dll")
uint MapVirtualKeyW(uint uCode, uint uMapType);

@DllImport("USER32.dll")
uint MapVirtualKeyExA(uint uCode, uint uMapType, int dwhkl);

@DllImport("USER32.dll")
uint MapVirtualKeyExW(uint uCode, uint uMapType, int dwhkl);

@DllImport("USER32.dll")
HWND GetCapture();

@DllImport("USER32.dll")
HWND SetCapture(HWND hWnd);

@DllImport("USER32.dll")
BOOL ReleaseCapture();

@DllImport("USER32.dll")
BOOL EnableWindow(HWND hWnd, BOOL bEnable);

@DllImport("USER32.dll")
BOOL IsWindowEnabled(HWND hWnd);

@DllImport("USER32.dll")
BOOL DragDetect(HWND hwnd, POINT pt);

@DllImport("USER32.dll")
HWND SetActiveWindow(HWND hWnd);

@DllImport("USER32.dll")
BOOL BlockInput(BOOL fBlockIt);

@DllImport("USER32.dll")
uint GetRawInputData(int hRawInput, uint uiCommand, char* pData, uint* pcbSize, uint cbSizeHeader);

@DllImport("USER32.dll")
uint GetRawInputDeviceInfoA(HANDLE hDevice, uint uiCommand, char* pData, uint* pcbSize);

@DllImport("USER32.dll")
uint GetRawInputDeviceInfoW(HANDLE hDevice, uint uiCommand, char* pData, uint* pcbSize);

@DllImport("USER32.dll")
uint GetRawInputBuffer(char* pData, uint* pcbSize, uint cbSizeHeader);

@DllImport("USER32.dll")
BOOL RegisterRawInputDevices(char* pRawInputDevices, uint uiNumDevices, uint cbSize);

@DllImport("USER32.dll")
uint GetRegisteredRawInputDevices(char* pRawInputDevices, uint* puiNumDevices, uint cbSize);

@DllImport("USER32.dll")
uint GetRawInputDeviceList(char* pRawInputDeviceList, uint* puiNumDevices, uint cbSize);

@DllImport("USER32.dll")
LRESULT DefRawInputProc(char* paRawInput, int nInput, uint cbSizeHeader);

struct MOUSEMOVEPOINT
{
    int x;
    int y;
    uint time;
    uint dwExtraInfo;
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
    int dx;
    int dy;
    uint mouseData;
    uint dwFlags;
    uint time;
    uint dwExtraInfo;
}

struct KEYBDINPUT
{
    ushort wVk;
    ushort wScan;
    uint dwFlags;
    uint time;
    uint dwExtraInfo;
}

struct HARDWAREINPUT
{
    uint uMsg;
    ushort wParamL;
    ushort wParamH;
}

struct INPUT
{
    uint type;
    _Anonymous_e__Union Anonymous;
}

struct LASTINPUTINFO
{
    uint cbSize;
    uint dwTime;
}

struct RAWINPUTHEADER
{
    uint dwType;
    uint dwSize;
    HANDLE hDevice;
    WPARAM wParam;
}

struct RAWMOUSE
{
    ushort usFlags;
    _Anonymous_e__Union Anonymous;
    uint ulRawButtons;
    int lLastX;
    int lLastY;
    uint ulExtraInformation;
}

struct RAWKEYBOARD
{
    ushort MakeCode;
    ushort Flags;
    ushort Reserved;
    ushort VKey;
    uint Message;
    uint ExtraInformation;
}

struct RAWHID
{
    uint dwSizeHid;
    uint dwCount;
    ubyte bRawData;
}

struct RAWINPUT
{
    RAWINPUTHEADER header;
    _data_e__Union data;
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
    uint dwVendorId;
    uint dwProductId;
    uint dwVersionNumber;
    ushort usUsagePage;
    ushort usUsage;
}

struct RID_DEVICE_INFO
{
    uint cbSize;
    uint dwType;
    _Anonymous_e__Union Anonymous;
}

struct RAWINPUTDEVICE
{
    ushort usUsagePage;
    ushort usUsage;
    uint dwFlags;
    HWND hwndTarget;
}

struct RAWINPUTDEVICELIST
{
    HANDLE hDevice;
    uint dwType;
}

