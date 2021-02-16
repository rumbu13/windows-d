module windows.dwm;

public import windows.core;
public import windows.com : HRESULT;
public import windows.controls : MARGINS;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : HBITMAP, HRGN;
public import windows.systemservices : BOOL, LRESULT;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;
public import windows.wpfbitmapeffects : MilMatrix3x2D;

extern(Windows):


// Enums


enum : int
{
    DWMWA_NCRENDERING_ENABLED         = 0x00000001,
    DWMWA_NCRENDERING_POLICY          = 0x00000002,
    DWMWA_TRANSITIONS_FORCEDISABLED   = 0x00000003,
    DWMWA_ALLOW_NCPAINT               = 0x00000004,
    DWMWA_CAPTION_BUTTON_BOUNDS       = 0x00000005,
    DWMWA_NONCLIENT_RTL_LAYOUT        = 0x00000006,
    DWMWA_FORCE_ICONIC_REPRESENTATION = 0x00000007,
    DWMWA_FLIP3D_POLICY               = 0x00000008,
    DWMWA_EXTENDED_FRAME_BOUNDS       = 0x00000009,
    DWMWA_HAS_ICONIC_BITMAP           = 0x0000000a,
    DWMWA_DISALLOW_PEEK               = 0x0000000b,
    DWMWA_EXCLUDED_FROM_PEEK          = 0x0000000c,
    DWMWA_CLOAK                       = 0x0000000d,
    DWMWA_CLOAKED                     = 0x0000000e,
    DWMWA_FREEZE_REPRESENTATION       = 0x0000000f,
    DWMWA_PASSIVE_UPDATE_MODE         = 0x00000010,
    DWMWA_LAST                        = 0x00000011,
}
alias DWMWINDOWATTRIBUTE = int;

enum : int
{
    DWMNCRP_USEWINDOWSTYLE = 0x00000000,
    DWMNCRP_DISABLED       = 0x00000001,
    DWMNCRP_ENABLED        = 0x00000002,
    DWMNCRP_LAST           = 0x00000003,
}
alias DWMNCRENDERINGPOLICY = int;

enum : int
{
    DWMFLIP3D_DEFAULT      = 0x00000000,
    DWMFLIP3D_EXCLUDEBELOW = 0x00000001,
    DWMFLIP3D_EXCLUDEABOVE = 0x00000002,
    DWMFLIP3D_LAST         = 0x00000003,
}
alias DWMFLIP3DWINDOWPOLICY = int;

enum : int
{
    DWM_SOURCE_FRAME_SAMPLING_POINT    = 0x00000000,
    DWM_SOURCE_FRAME_SAMPLING_COVERAGE = 0x00000001,
    DWM_SOURCE_FRAME_SAMPLING_LAST     = 0x00000002,
}
alias DWM_SOURCE_FRAME_SAMPLING = int;

enum : int
{
    DWMTRANSITION_OWNEDWINDOW_NULL       = 0xffffffff,
    DWMTRANSITION_OWNEDWINDOW_REPOSITION = 0x00000000,
}
alias DWMTRANSITION_OWNEDWINDOW_TARGET = int;

enum : int
{
    GT_PEN_TAP                 = 0x00000000,
    GT_PEN_DOUBLETAP           = 0x00000001,
    GT_PEN_RIGHTTAP            = 0x00000002,
    GT_PEN_PRESSANDHOLD        = 0x00000003,
    GT_PEN_PRESSANDHOLDABORT   = 0x00000004,
    GT_TOUCH_TAP               = 0x00000005,
    GT_TOUCH_DOUBLETAP         = 0x00000006,
    GT_TOUCH_RIGHTTAP          = 0x00000007,
    GT_TOUCH_PRESSANDHOLD      = 0x00000008,
    GT_TOUCH_PRESSANDHOLDABORT = 0x00000009,
    GT_TOUCH_PRESSANDTAP       = 0x0000000a,
}
alias GESTURE_TYPE = int;

enum : int
{
    DWMSC_DOWN      = 0x00000001,
    DWMSC_UP        = 0x00000002,
    DWMSC_DRAG      = 0x00000004,
    DWMSC_HOLD      = 0x00000008,
    DWMSC_PENBARREL = 0x00000010,
    DWMSC_NONE      = 0x00000000,
    DWMSC_ALL       = 0xffffffff,
}
alias DWM_SHOWCONTACT = int;

enum : int
{
    DWMTWR_NONE                  = 0x00000000,
    DWMTWR_IMPLEMENTED_BY_SYSTEM = 0x00000001,
    DWMTWR_WINDOW_RELATIONSHIP   = 0x00000002,
    DWMTWR_WINDOW_STYLES         = 0x00000004,
    DWMTWR_WINDOW_REGION         = 0x00000008,
    DWMTWR_WINDOW_DWM_ATTRIBUTES = 0x00000010,
    DWMTWR_WINDOW_MARGINS        = 0x00000020,
    DWMTWR_TABBING_ENABLED       = 0x00000040,
    DWMTWR_USER_POLICY           = 0x00000080,
    DWMTWR_GROUP_POLICY          = 0x00000100,
    DWMTWR_APP_COMPAT            = 0x00000200,
}
alias DWM_TAB_WINDOW_REQUIREMENTS = int;

// Constants


enum uint c_DwmMaxQueuedBuffers = 0x00000008;
enum uint c_DwmMaxAdapters = 0x00000010;

// Structs


struct DWM_BLURBEHIND
{
align (1):
    uint dwFlags;
    BOOL fEnable;
    HRGN hRgnBlur;
    BOOL fTransitionOnMaximized;
}

struct DWM_THUMBNAIL_PROPERTIES
{
align (1):
    uint  dwFlags;
    RECT  rcDestination;
    RECT  rcSource;
    ubyte opacity;
    BOOL  fVisible;
    BOOL  fSourceClientAreaOnly;
}

struct UNSIGNED_RATIO
{
align (1):
    uint uiNumerator;
    uint uiDenominator;
}

struct DWM_TIMING_INFO
{
align (1):
    uint           cbSize;
    UNSIGNED_RATIO rateRefresh;
    ulong          qpcRefreshPeriod;
    UNSIGNED_RATIO rateCompose;
    ulong          qpcVBlank;
    ulong          cRefresh;
    uint           cDXRefresh;
    ulong          qpcCompose;
    ulong          cFrame;
    uint           cDXPresent;
    ulong          cRefreshFrame;
    ulong          cFrameSubmitted;
    uint           cDXPresentSubmitted;
    ulong          cFrameConfirmed;
    uint           cDXPresentConfirmed;
    ulong          cRefreshConfirmed;
    uint           cDXRefreshConfirmed;
    ulong          cFramesLate;
    uint           cFramesOutstanding;
    ulong          cFrameDisplayed;
    ulong          qpcFrameDisplayed;
    ulong          cRefreshFrameDisplayed;
    ulong          cFrameComplete;
    ulong          qpcFrameComplete;
    ulong          cFramePending;
    ulong          qpcFramePending;
    ulong          cFramesDisplayed;
    ulong          cFramesComplete;
    ulong          cFramesPending;
    ulong          cFramesAvailable;
    ulong          cFramesDropped;
    ulong          cFramesMissed;
    ulong          cRefreshNextDisplayed;
    ulong          cRefreshNextPresented;
    ulong          cRefreshesDisplayed;
    ulong          cRefreshesPresented;
    ulong          cRefreshStarted;
    ulong          cPixelsReceived;
    ulong          cPixelsDrawn;
    ulong          cBuffersEmpty;
}

struct DWM_PRESENT_PARAMETERS
{
align (1):
    uint           cbSize;
    BOOL           fQueue;
    ulong          cRefreshStart;
    uint           cBuffer;
    BOOL           fUseSourceRate;
    UNSIGNED_RATIO rateSource;
    uint           cRefreshesPerFrame;
    DWM_SOURCE_FRAME_SAMPLING eSampling;
}

// Functions

@DllImport("dwmapi")
BOOL DwmDefWindowProc(HWND hWnd, uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);

@DllImport("dwmapi")
HRESULT DwmEnableBlurBehindWindow(HWND hWnd, const(DWM_BLURBEHIND)* pBlurBehind);

@DllImport("dwmapi")
HRESULT DwmEnableComposition(uint uCompositionAction);

@DllImport("dwmapi")
HRESULT DwmEnableMMCSS(BOOL fEnableMMCSS);

@DllImport("dwmapi")
HRESULT DwmExtendFrameIntoClientArea(HWND hWnd, const(MARGINS)* pMarInset);

@DllImport("dwmapi")
HRESULT DwmGetColorizationColor(uint* pcrColorization, int* pfOpaqueBlend);

@DllImport("dwmapi")
HRESULT DwmGetCompositionTimingInfo(HWND hwnd, DWM_TIMING_INFO* pTimingInfo);

@DllImport("dwmapi")
HRESULT DwmGetWindowAttribute(HWND hwnd, uint dwAttribute, char* pvAttribute, uint cbAttribute);

@DllImport("dwmapi")
HRESULT DwmIsCompositionEnabled(int* pfEnabled);

@DllImport("dwmapi")
HRESULT DwmModifyPreviousDxFrameDuration(HWND hwnd, int cRefreshes, BOOL fRelative);

@DllImport("dwmapi")
HRESULT DwmQueryThumbnailSourceSize(ptrdiff_t hThumbnail, SIZE* pSize);

@DllImport("dwmapi")
HRESULT DwmRegisterThumbnail(HWND hwndDestination, HWND hwndSource, ptrdiff_t* phThumbnailId);

@DllImport("dwmapi")
HRESULT DwmSetDxFrameDuration(HWND hwnd, int cRefreshes);

@DllImport("dwmapi")
HRESULT DwmSetPresentParameters(HWND hwnd, DWM_PRESENT_PARAMETERS* pPresentParams);

@DllImport("dwmapi")
HRESULT DwmSetWindowAttribute(HWND hwnd, uint dwAttribute, char* pvAttribute, uint cbAttribute);

@DllImport("dwmapi")
HRESULT DwmUnregisterThumbnail(ptrdiff_t hThumbnailId);

@DllImport("dwmapi")
HRESULT DwmUpdateThumbnailProperties(ptrdiff_t hThumbnailId, const(DWM_THUMBNAIL_PROPERTIES)* ptnProperties);

@DllImport("dwmapi")
HRESULT DwmSetIconicThumbnail(HWND hwnd, HBITMAP hbmp, uint dwSITFlags);

@DllImport("dwmapi")
HRESULT DwmSetIconicLivePreviewBitmap(HWND hwnd, HBITMAP hbmp, POINT* pptClient, uint dwSITFlags);

@DllImport("dwmapi")
HRESULT DwmInvalidateIconicBitmaps(HWND hwnd);

@DllImport("dwmapi")
HRESULT DwmAttachMilContent(HWND hwnd);

@DllImport("dwmapi")
HRESULT DwmDetachMilContent(HWND hwnd);

@DllImport("dwmapi")
HRESULT DwmFlush();

@DllImport("dwmapi")
HRESULT DwmGetGraphicsStreamTransformHint(uint uIndex, MilMatrix3x2D* pTransform);

@DllImport("dwmapi")
HRESULT DwmGetGraphicsStreamClient(uint uIndex, GUID* pClientUuid);

@DllImport("dwmapi")
HRESULT DwmGetTransportAttributes(int* pfIsRemoting, int* pfIsConnected, uint* pDwGeneration);

@DllImport("dwmapi")
HRESULT DwmTransitionOwnedWindow(HWND hwnd, DWMTRANSITION_OWNEDWINDOW_TARGET target);

@DllImport("dwmapi")
HRESULT DwmRenderGesture(GESTURE_TYPE gt, uint cContacts, char* pdwPointerID, char* pPoints);

@DllImport("dwmapi")
HRESULT DwmTetherContact(uint dwPointerID, BOOL fEnable, POINT ptTether);

@DllImport("dwmapi")
HRESULT DwmShowContact(uint dwPointerID, DWM_SHOWCONTACT eShowContact);

@DllImport("dwmapi")
HRESULT DwmGetUnmetTabRequirements(HWND appWindow, DWM_TAB_WINDOW_REQUIREMENTS* value);


