module windows.dwm;

public import system;
public import windows.com;
public import windows.controls;
public import windows.displaydevices;
public import windows.gdi;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.wpfbitmapeffects;

extern(Windows):

struct DWM_BLURBEHIND
{
    uint dwFlags;
    BOOL fEnable;
    HRGN hRgnBlur;
    BOOL fTransitionOnMaximized;
}

enum DWMWINDOWATTRIBUTE
{
    DWMWA_NCRENDERING_ENABLED = 1,
    DWMWA_NCRENDERING_POLICY = 2,
    DWMWA_TRANSITIONS_FORCEDISABLED = 3,
    DWMWA_ALLOW_NCPAINT = 4,
    DWMWA_CAPTION_BUTTON_BOUNDS = 5,
    DWMWA_NONCLIENT_RTL_LAYOUT = 6,
    DWMWA_FORCE_ICONIC_REPRESENTATION = 7,
    DWMWA_FLIP3D_POLICY = 8,
    DWMWA_EXTENDED_FRAME_BOUNDS = 9,
    DWMWA_HAS_ICONIC_BITMAP = 10,
    DWMWA_DISALLOW_PEEK = 11,
    DWMWA_EXCLUDED_FROM_PEEK = 12,
    DWMWA_CLOAK = 13,
    DWMWA_CLOAKED = 14,
    DWMWA_FREEZE_REPRESENTATION = 15,
    DWMWA_PASSIVE_UPDATE_MODE = 16,
    DWMWA_LAST = 17,
}

enum DWMNCRENDERINGPOLICY
{
    DWMNCRP_USEWINDOWSTYLE = 0,
    DWMNCRP_DISABLED = 1,
    DWMNCRP_ENABLED = 2,
    DWMNCRP_LAST = 3,
}

enum DWMFLIP3DWINDOWPOLICY
{
    DWMFLIP3D_DEFAULT = 0,
    DWMFLIP3D_EXCLUDEBELOW = 1,
    DWMFLIP3D_EXCLUDEABOVE = 2,
    DWMFLIP3D_LAST = 3,
}

struct DWM_THUMBNAIL_PROPERTIES
{
    uint dwFlags;
    RECT rcDestination;
    RECT rcSource;
    ubyte opacity;
    BOOL fVisible;
    BOOL fSourceClientAreaOnly;
}

struct UNSIGNED_RATIO
{
    uint uiNumerator;
    uint uiDenominator;
}

struct DWM_TIMING_INFO
{
    uint cbSize;
    UNSIGNED_RATIO rateRefresh;
    ulong qpcRefreshPeriod;
    UNSIGNED_RATIO rateCompose;
    ulong qpcVBlank;
    ulong cRefresh;
    uint cDXRefresh;
    ulong qpcCompose;
    ulong cFrame;
    uint cDXPresent;
    ulong cRefreshFrame;
    ulong cFrameSubmitted;
    uint cDXPresentSubmitted;
    ulong cFrameConfirmed;
    uint cDXPresentConfirmed;
    ulong cRefreshConfirmed;
    uint cDXRefreshConfirmed;
    ulong cFramesLate;
    uint cFramesOutstanding;
    ulong cFrameDisplayed;
    ulong qpcFrameDisplayed;
    ulong cRefreshFrameDisplayed;
    ulong cFrameComplete;
    ulong qpcFrameComplete;
    ulong cFramePending;
    ulong qpcFramePending;
    ulong cFramesDisplayed;
    ulong cFramesComplete;
    ulong cFramesPending;
    ulong cFramesAvailable;
    ulong cFramesDropped;
    ulong cFramesMissed;
    ulong cRefreshNextDisplayed;
    ulong cRefreshNextPresented;
    ulong cRefreshesDisplayed;
    ulong cRefreshesPresented;
    ulong cRefreshStarted;
    ulong cPixelsReceived;
    ulong cPixelsDrawn;
    ulong cBuffersEmpty;
}

enum DWM_SOURCE_FRAME_SAMPLING
{
    DWM_SOURCE_FRAME_SAMPLING_POINT = 0,
    DWM_SOURCE_FRAME_SAMPLING_COVERAGE = 1,
    DWM_SOURCE_FRAME_SAMPLING_LAST = 2,
}

struct DWM_PRESENT_PARAMETERS
{
    uint cbSize;
    BOOL fQueue;
    ulong cRefreshStart;
    uint cBuffer;
    BOOL fUseSourceRate;
    UNSIGNED_RATIO rateSource;
    uint cRefreshesPerFrame;
    DWM_SOURCE_FRAME_SAMPLING eSampling;
}

enum DWMTRANSITION_OWNEDWINDOW_TARGET
{
    DWMTRANSITION_OWNEDWINDOW_NULL = -1,
    DWMTRANSITION_OWNEDWINDOW_REPOSITION = 0,
}

enum GESTURE_TYPE
{
    GT_PEN_TAP = 0,
    GT_PEN_DOUBLETAP = 1,
    GT_PEN_RIGHTTAP = 2,
    GT_PEN_PRESSANDHOLD = 3,
    GT_PEN_PRESSANDHOLDABORT = 4,
    GT_TOUCH_TAP = 5,
    GT_TOUCH_DOUBLETAP = 6,
    GT_TOUCH_RIGHTTAP = 7,
    GT_TOUCH_PRESSANDHOLD = 8,
    GT_TOUCH_PRESSANDHOLDABORT = 9,
    GT_TOUCH_PRESSANDTAP = 10,
}

enum DWM_SHOWCONTACT
{
    DWMSC_DOWN = 1,
    DWMSC_UP = 2,
    DWMSC_DRAG = 4,
    DWMSC_HOLD = 8,
    DWMSC_PENBARREL = 16,
    DWMSC_NONE = 0,
    DWMSC_ALL = -1,
}

enum DWM_TAB_WINDOW_REQUIREMENTS
{
    DWMTWR_NONE = 0,
    DWMTWR_IMPLEMENTED_BY_SYSTEM = 1,
    DWMTWR_WINDOW_RELATIONSHIP = 2,
    DWMTWR_WINDOW_STYLES = 4,
    DWMTWR_WINDOW_REGION = 8,
    DWMTWR_WINDOW_DWM_ATTRIBUTES = 16,
    DWMTWR_WINDOW_MARGINS = 32,
    DWMTWR_TABBING_ENABLED = 64,
    DWMTWR_USER_POLICY = 128,
    DWMTWR_GROUP_POLICY = 256,
    DWMTWR_APP_COMPAT = 512,
}

@DllImport("dwmapi.dll")
BOOL DwmDefWindowProc(HWND hWnd, uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);

@DllImport("dwmapi.dll")
HRESULT DwmEnableBlurBehindWindow(HWND hWnd, const(DWM_BLURBEHIND)* pBlurBehind);

@DllImport("dwmapi.dll")
HRESULT DwmEnableComposition(uint uCompositionAction);

@DllImport("dwmapi.dll")
HRESULT DwmEnableMMCSS(BOOL fEnableMMCSS);

@DllImport("dwmapi.dll")
HRESULT DwmExtendFrameIntoClientArea(HWND hWnd, const(MARGINS)* pMarInset);

@DllImport("dwmapi.dll")
HRESULT DwmGetColorizationColor(uint* pcrColorization, int* pfOpaqueBlend);

@DllImport("dwmapi.dll")
HRESULT DwmGetCompositionTimingInfo(HWND hwnd, DWM_TIMING_INFO* pTimingInfo);

@DllImport("dwmapi.dll")
HRESULT DwmGetWindowAttribute(HWND hwnd, uint dwAttribute, char* pvAttribute, uint cbAttribute);

@DllImport("dwmapi.dll")
HRESULT DwmIsCompositionEnabled(int* pfEnabled);

@DllImport("dwmapi.dll")
HRESULT DwmModifyPreviousDxFrameDuration(HWND hwnd, int cRefreshes, BOOL fRelative);

@DllImport("dwmapi.dll")
HRESULT DwmQueryThumbnailSourceSize(int hThumbnail, SIZE* pSize);

@DllImport("dwmapi.dll")
HRESULT DwmRegisterThumbnail(HWND hwndDestination, HWND hwndSource, int* phThumbnailId);

@DllImport("dwmapi.dll")
HRESULT DwmSetDxFrameDuration(HWND hwnd, int cRefreshes);

@DllImport("dwmapi.dll")
HRESULT DwmSetPresentParameters(HWND hwnd, DWM_PRESENT_PARAMETERS* pPresentParams);

@DllImport("dwmapi.dll")
HRESULT DwmSetWindowAttribute(HWND hwnd, uint dwAttribute, char* pvAttribute, uint cbAttribute);

@DllImport("dwmapi.dll")
HRESULT DwmUnregisterThumbnail(int hThumbnailId);

@DllImport("dwmapi.dll")
HRESULT DwmUpdateThumbnailProperties(int hThumbnailId, const(DWM_THUMBNAIL_PROPERTIES)* ptnProperties);

@DllImport("dwmapi.dll")
HRESULT DwmSetIconicThumbnail(HWND hwnd, HBITMAP hbmp, uint dwSITFlags);

@DllImport("dwmapi.dll")
HRESULT DwmSetIconicLivePreviewBitmap(HWND hwnd, HBITMAP hbmp, POINT* pptClient, uint dwSITFlags);

@DllImport("dwmapi.dll")
HRESULT DwmInvalidateIconicBitmaps(HWND hwnd);

@DllImport("dwmapi.dll")
HRESULT DwmAttachMilContent(HWND hwnd);

@DllImport("dwmapi.dll")
HRESULT DwmDetachMilContent(HWND hwnd);

@DllImport("dwmapi.dll")
HRESULT DwmFlush();

@DllImport("dwmapi.dll")
HRESULT DwmGetGraphicsStreamTransformHint(uint uIndex, MilMatrix3x2D* pTransform);

@DllImport("dwmapi.dll")
HRESULT DwmGetGraphicsStreamClient(uint uIndex, Guid* pClientUuid);

@DllImport("dwmapi.dll")
HRESULT DwmGetTransportAttributes(int* pfIsRemoting, int* pfIsConnected, uint* pDwGeneration);

@DllImport("dwmapi.dll")
HRESULT DwmTransitionOwnedWindow(HWND hwnd, DWMTRANSITION_OWNEDWINDOW_TARGET target);

@DllImport("dwmapi.dll")
HRESULT DwmRenderGesture(GESTURE_TYPE gt, uint cContacts, char* pdwPointerID, char* pPoints);

@DllImport("dwmapi.dll")
HRESULT DwmTetherContact(uint dwPointerID, BOOL fEnable, POINT ptTether);

@DllImport("dwmapi.dll")
HRESULT DwmShowContact(uint dwPointerID, DWM_SHOWCONTACT eShowContact);

@DllImport("dwmapi.dll")
HRESULT DwmGetUnmetTabRequirements(HWND appWindow, DWM_TAB_WINDOW_REQUIREMENTS* value);

