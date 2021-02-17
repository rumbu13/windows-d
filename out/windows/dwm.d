// Written in the D programming language.

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


///Flags used by the [DwmGetWindowAttribute](/windows/desktop/api/dwmapi/nf-dwmapi-dwmgetwindowattribute) and
///[DwmSetWindowAttribute](/windows/desktop/api/dwmapi/nf-dwmapi-dwmsetwindowattribute) functions to specify window
///attributes for Desktop Window Manager (DWM) non-client rendering. For programming guidance, and code examples, see
///[Controlling non-client region
///rendering](/windows/desktop/dwm/composition-ovw#controlling-non-client-region-rendering).
alias DWMWINDOWATTRIBUTE = int;
enum : int
{
    ///Use with DwmGetWindowAttribute. Discovers whether non-client rendering is enabled. The retrieved value is of type
    ///<b>BOOL</b>. <b>TRUE</b> if non-client rendering is enabled; otherwise, <b>FALSE</b>.
    DWMWA_NCRENDERING_ENABLED         = 0x00000001,
    ///Use with DwmSetWindowAttribute. Sets the non-client rendering policy. The <i>pvAttribute</i> parameter points to
    ///a value from the DWMNCRENDERINGPOLICY enumeration.
    DWMWA_NCRENDERING_POLICY          = 0x00000002,
    ///Use with DwmSetWindowAttribute. Enables or forcibly disables DWM transitions. The <i>pvAttribute</i> parameter
    ///points to a value of type <b>BOOL</b>. <b>TRUE</b> to disable transitions, or <b>FALSE</b> to enable transitions.
    DWMWA_TRANSITIONS_FORCEDISABLED   = 0x00000003,
    ///Use with DwmSetWindowAttribute. Enables content rendered in the non-client area to be visible on the frame drawn
    ///by DWM. The <i>pvAttribute</i> parameter points to a value of type <b>BOOL</b>. <b>TRUE</b> to enable content
    ///rendered in the non-client area to be visible on the frame; otherwise, <b>FALSE</b>.
    DWMWA_ALLOW_NCPAINT               = 0x00000004,
    ///Use with DwmGetWindowAttribute. Retrieves the bounds of the caption button area in the window-relative space. The
    ///retrieved value is of type RECT. If the window is minimized or otherwise not visible to the user, then the value
    ///of the **RECT** retrieved is undefined. You should check whether the retrieved **RECT** contains a boundary that
    ///you can work with, and if it doesn't then you can conclude that the window is minimized or otherwise not visible.
    DWMWA_CAPTION_BUTTON_BOUNDS       = 0x00000005,
    ///Use with DwmSetWindowAttribute. Specifies whether non-client content is right-to-left (RTL) mirrored. The
    ///<i>pvAttribute</i> parameter points to a value of type <b>BOOL</b>. <b>TRUE</b> if the non-client content is
    ///right-to-left (RTL) mirrored; otherwise, <b>FALSE</b>.
    DWMWA_NONCLIENT_RTL_LAYOUT        = 0x00000006,
    ///Use with DwmSetWindowAttribute. Forces the window to display an iconic thumbnail or peek representation (a static
    ///bitmap), even if a live or snapshot representation of the window is available. This value is normally set during
    ///a window's creation, and not changed throughout the window's lifetime. Some scenarios, however, might require the
    ///value to change over time. The <i>pvAttribute</i> parameter points to a value of type <b>BOOL</b>. <b>TRUE</b> to
    ///require a iconic thumbnail or peek representation; otherwise, <b>FALSE</b>.
    DWMWA_FORCE_ICONIC_REPRESENTATION = 0x00000007,
    ///Use with DwmSetWindowAttribute. Sets how Flip3D treats the window. The <i>pvAttribute</i> parameter points to a
    ///value from the DWMFLIP3DWINDOWPOLICY enumeration.
    DWMWA_FLIP3D_POLICY               = 0x00000008,
    ///Use with DwmGetWindowAttribute. Retrieves the extended frame bounds rectangle in screen space. The retrieved
    ///value is of type RECT.
    DWMWA_EXTENDED_FRAME_BOUNDS       = 0x00000009,
    ///Use with DwmSetWindowAttribute. The window will provide a bitmap for use by DWM as an iconic thumbnail or peek
    ///representation (a static bitmap) for the window. <b>DWMWA_HAS_ICONIC_BITMAP</b> can be specified with
    ///<b>DWMWA_FORCE_ICONIC_REPRESENTATION</b>. <b>DWMWA_HAS_ICONIC_BITMAP</b> normally is set during a window's
    ///creation and not changed throughout the window's lifetime. Some scenarios, however, might require the value to
    ///change over time. The <i>pvAttribute</i> parameter points to a value of type <b>BOOL</b>. <b>TRUE</b> to inform
    ///DWM that the window will provide an iconic thumbnail or peek representation; otherwise, <b>FALSE</b>. <b>Windows
    ///Vista and earlier: </b>This value is not supported.
    DWMWA_HAS_ICONIC_BITMAP           = 0x0000000a,
    ///Use with DwmSetWindowAttribute. Do not show peek preview for the window. The peek view shows a full-sized preview
    ///of the window when the mouse hovers over the window's thumbnail in the taskbar. If this attribute is set,
    ///hovering the mouse pointer over the window's thumbnail dismisses peek (in case another window in the group has a
    ///peek preview showing). The <i>pvAttribute</i> parameter points to a value of type <b>BOOL</b>. <b>TRUE</b> to
    ///prevent peek functionality, or <b>FALSE</b> to allow it. <b>Windows Vista and earlier: </b>This value is not
    ///supported.
    DWMWA_DISALLOW_PEEK               = 0x0000000b,
    ///Use with DwmSetWindowAttribute. Prevents a window from fading to a glass sheet when peek is invoked. The
    ///<i>pvAttribute</i> parameter points to a value of type <b>BOOL</b>. <b>TRUE</b> to prevent the window from fading
    ///during another window's peek, or <b>FALSE</b> for normal behavior. <b>Windows Vista and earlier: </b>This value
    ///is not supported.
    DWMWA_EXCLUDED_FROM_PEEK          = 0x0000000c,
    ///Use with DwmSetWindowAttribute. Cloaks the window such that it is not visible to the user. The window is still
    ///composed by DWM. <b>Using with DirectComposition: </b>Use the DWMWA_CLOAK flag to cloak the layered child window
    ///when animating a representation of the window's content via a DirectComposition visual that has been associated
    ///with the layered child window. For more details on this usage case, see How to animate the bitmap of a layered
    ///child window. <b>Windows 7 and earlier: </b>This value is not supported.
    DWMWA_CLOAK                       = 0x0000000d,
    ///Use with DwmGetWindowAttribute. If the window is cloaked, provides one of the following values explaining why.
    ///<b>DWM_CLOAKED_APP</b> (value 0x0000001). The window was cloaked by its owner application.
    ///<b>DWM_CLOAKED_SHELL</b> (value 0x0000002). The window was cloaked by the Shell. <b>DWM_CLOAKED_INHERITED</b>
    ///(value 0x0000004). The cloak value was inherited from its owner window. <b>Windows 7 and earlier: </b>This value
    ///is not supported.
    DWMWA_CLOAKED                     = 0x0000000e,
    ///Use with DwmSetWindowAttribute. Freeze the window's thumbnail image with its current visuals. Do no further live
    ///updates on the thumbnail image to match the window's contents. <b>Windows 7 and earlier: </b>This value is not
    ///supported.
    DWMWA_FREEZE_REPRESENTATION       = 0x0000000f,
    DWMWA_PASSIVE_UPDATE_MODE         = 0x00000010,
    ///The maximum recognized <b>DWMWINDOWATTRIBUTE</b> value, used for validation purposes.
    DWMWA_LAST                        = 0x00000011,
}

///Flags used by the DwmSetWindowAttribute function to specify the non-client area rendering policy.
alias DWMNCRENDERINGPOLICY = int;
enum : int
{
    ///The non-client rendering area is rendered based on the window style.
    DWMNCRP_USEWINDOWSTYLE = 0x00000000,
    ///The non-client area rendering is disabled; the window style is ignored.
    DWMNCRP_DISABLED       = 0x00000001,
    ///The non-client area rendering is enabled; the window style is ignored.
    DWMNCRP_ENABLED        = 0x00000002,
    ///The maximum recognized DWMNCRENDERINGPOLICY value, used for validation purposes.
    DWMNCRP_LAST           = 0x00000003,
}

///Flags used by the DwmSetWindowAttribute function to specify the Flip3D window policy.
alias DWMFLIP3DWINDOWPOLICY = int;
enum : int
{
    ///Use the window's style and visibility settings to determine whether to hide or include the window in Flip3D
    ///rendering.
    DWMFLIP3D_DEFAULT      = 0x00000000,
    ///Exclude the window from Flip3D and display it below the Flip3D rendering.
    DWMFLIP3D_EXCLUDEBELOW = 0x00000001,
    ///Exclude the window from Flip3D and display it above the Flip3D rendering.
    DWMFLIP3D_EXCLUDEABOVE = 0x00000002,
    ///The maximum recognized DWMFLIP3DWINDOWPOLICY value, used for validation purposes.
    DWMFLIP3D_LAST         = 0x00000003,
}

///Flags used by the DwmSetPresentParameters function to specify the frame sampling type.
alias DWM_SOURCE_FRAME_SAMPLING = int;
enum : int
{
    ///Use the first source frame that includes the first refresh of the output frame.
    DWM_SOURCE_FRAME_SAMPLING_POINT    = 0x00000000,
    ///Use the source frame that includes the most refreshes of the output frame. In the case of multiple source frames
    ///with the same coverage, the last frame is used.
    DWM_SOURCE_FRAME_SAMPLING_COVERAGE = 0x00000001,
    DWM_SOURCE_FRAME_SAMPLING_LAST     = 0x00000002,
}

///Identifies the target.
alias DWMTRANSITION_OWNEDWINDOW_TARGET = int;
enum : int
{
    ///Indicates no animation.
    DWMTRANSITION_OWNEDWINDOW_NULL       = 0xffffffff,
    DWMTRANSITION_OWNEDWINDOW_REPOSITION = 0x00000000,
}

///Identifies the gesture type specified in DwmRenderGesture.
alias GESTURE_TYPE = int;
enum : int
{
    ///A pen tap.
    GT_PEN_TAP                 = 0x00000000,
    ///A pen double tap.
    GT_PEN_DOUBLETAP           = 0x00000001,
    ///A pen right tap.
    GT_PEN_RIGHTTAP            = 0x00000002,
    ///A pen press and hold.
    GT_PEN_PRESSANDHOLD        = 0x00000003,
    ///An abort of the pen press and hold.
    GT_PEN_PRESSANDHOLDABORT   = 0x00000004,
    ///A touch tap.
    GT_TOUCH_TAP               = 0x00000005,
    ///A touch double tap.
    GT_TOUCH_DOUBLETAP         = 0x00000006,
    ///A touch right tap.
    GT_TOUCH_RIGHTTAP          = 0x00000007,
    ///A touch press and hold.
    GT_TOUCH_PRESSANDHOLD      = 0x00000008,
    ///An abort of the pen press and hold.
    GT_TOUCH_PRESSANDHOLDABORT = 0x00000009,
    GT_TOUCH_PRESSANDTAP       = 0x0000000a,
}

alias DWM_SHOWCONTACT = int;
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

///Returned by DwmGetUnmetTabRequirements to indicate the requirements needed for a window to put tabs in the
///application title bar.
alias DWM_TAB_WINDOW_REQUIREMENTS = int;
enum : int
{
    ///The window meets all requirements requested.
    DWMTWR_NONE                  = 0x00000000,
    ///In some configurations, the admin/user setting or mode of the system means that windows won't be tabbed. This
    ///requirement indicates that the system mode must implement tabbing. If the system does not implement tabbing,
    ///nothing can be done to change this.
    DWMTWR_IMPLEMENTED_BY_SYSTEM = 0x00000001,
    ///The window has an owner or parent, and is therefore ineligible for tabbing.
    DWMTWR_WINDOW_RELATIONSHIP   = 0x00000002,
    ///The window has one or more styles that make it ineligible for tabbing. To be eligible for tabbing, a window must:
    ///<ul> <li>Have the <b>WS_OVERLAPPEDWINDOW</b> (such as <b>WS_CAPTION</b>, <b>WS_THICKFRAME</b>, etc.) styles
    ///set.</li> <li>Not have <b>WS_POPUP</b>, <b>WS_CHILD</b> or <b>WS_DLGFRAME</b> set.</li> <li>Not have
    ///<b>WS_EX_TOPMOST</b> or <b>WS_EX_TOOLWINDOW</b> set. </li> </ul>
    DWMTWR_WINDOW_STYLES         = 0x00000004,
    ///The window has a region (set using SetWindowRgn) making it ineligible.
    DWMTWR_WINDOW_REGION         = 0x00000008,
    ///The window is ineligible due to its Dwm configuration. To resolve this issue, the window must not extended its
    ///client area into the title bar using DwmExtendFrameIntoClientArea. In addition, the window must not have
    ///<b>DWMWA_NCRENDERING_POLICY</b> set to <b>DWMNCRP_ENABLED</b>.
    DWMTWR_WINDOW_DWM_ATTRIBUTES = 0x00000010,
    ///The window is ineligible due to its margins, most likely due to custom handling in <b>WM_NCCALCSIZE</b>. To
    ///resolve this issue, the window must use the default window margins for the non-client area.
    DWMTWR_WINDOW_MARGINS        = 0x00000020,
    ///The window has been explicitly opted out by setting <b>DWMWA_TABBING_ENABLED</b> to false.
    DWMTWR_TABBING_ENABLED       = 0x00000040,
    ///The user has configured this application to not participate in tabbing.
    DWMTWR_USER_POLICY           = 0x00000080,
    DWMTWR_GROUP_POLICY          = 0x00000100,
    DWMTWR_APP_COMPAT            = 0x00000200,
}

// Constants


enum uint c_DwmMaxQueuedBuffers = 0x00000008;
enum uint c_DwmMaxAdapters = 0x00000010;

// Structs


///Specifies Desktop Window Manager (DWM) blur-behind properties. Used by the DwmEnableBlurBehindWindow function.
struct DWM_BLURBEHIND
{
align (1):
    ///A bitwise combination of DWM Blur Behind constant values that indicates which of the members of this structure
    ///have been set.
    uint dwFlags;
    ///<b>TRUE</b> to register the window handle to DWM blur behind; <b>FALSE</b> to unregister the window handle from
    ///DWM blur behind.
    BOOL fEnable;
    ///The region within the client area where the blur behind will be applied. A <b>NULL</b> value will apply the blur
    ///behind the entire client area.
    HRGN hRgnBlur;
    BOOL fTransitionOnMaximized;
}

///Specifies Desktop Window Manager (DWM) thumbnail properties. Used by the DwmUpdateThumbnailProperties function.
struct DWM_THUMBNAIL_PROPERTIES
{
align (1):
    ///A bitwise combination of DWM thumbnail constant values that indicates which members of this structure are set.
    uint  dwFlags;
    ///The area in the destination window where the thumbnail will be rendered.
    RECT  rcDestination;
    ///The region of the source window to use as the thumbnail. By default, the entire window is used as the thumbnail.
    RECT  rcSource;
    ///The opacity with which to render the thumbnail. 0 is fully transparent while 255 is fully opaque. The default
    ///value is 255.
    ubyte opacity;
    ///<b>TRUE</b> to make the thumbnail visible; otherwise, <b>FALSE</b>. The default is <b>FALSE</b>.
    BOOL  fVisible;
    BOOL  fSourceClientAreaOnly;
}

///Defines a data type used by the Desktop Window Manager (DWM) APIs. It represents a generic ratio and is used for
///different purposes and units even within a single API.
struct UNSIGNED_RATIO
{
align (1):
    ///The ratio numerator.
    uint uiNumerator;
    uint uiDenominator;
}

///Specifies Desktop Window Manager (DWM) composition timing information. Used by the DwmGetCompositionTimingInfo
///function.
struct DWM_TIMING_INFO
{
align (1):
    ///The size of this <b>DWM_TIMING_INFO</b> structure.
    uint           cbSize;
    ///The monitor refresh rate.
    UNSIGNED_RATIO rateRefresh;
    ///The monitor refresh period.
    ulong          qpcRefreshPeriod;
    ///The composition rate.
    UNSIGNED_RATIO rateCompose;
    ///The query performance counter value before the vertical blank.
    ulong          qpcVBlank;
    ///The DWM refresh counter.
    ulong          cRefresh;
    ///The DirectX refresh counter.
    uint           cDXRefresh;
    ///The query performance counter value for a frame composition.
    ulong          qpcCompose;
    ///The frame number that was composed at <b>qpcCompose</b>.
    ulong          cFrame;
    ///The DirectX present number used to identify rendering frames.
    uint           cDXPresent;
    ///The refresh count of the frame that was composed at <b>qpcCompose</b>.
    ulong          cRefreshFrame;
    ///The DWM frame number that was last submitted.
    ulong          cFrameSubmitted;
    ///The DirectX present number that was last submitted.
    uint           cDXPresentSubmitted;
    ///The DWM frame number that was last confirmed as presented.
    ulong          cFrameConfirmed;
    ///The DirectX present number that was last confirmed as presented.
    uint           cDXPresentConfirmed;
    ///The target refresh count of the last frame confirmed as completed by the GPU.
    ulong          cRefreshConfirmed;
    ///The DirectX refresh count when the frame was confirmed as presented.
    uint           cDXRefreshConfirmed;
    ///The number of frames the DWM presented late.
    ulong          cFramesLate;
    ///The number of composition frames that have been issued but have not been confirmed as completed.
    uint           cFramesOutstanding;
    ///The last frame displayed.
    ulong          cFrameDisplayed;
    ///The QPC time of the composition pass when the frame was displayed.
    ulong          qpcFrameDisplayed;
    ///The vertical refresh count when the frame should have become visible.
    ulong          cRefreshFrameDisplayed;
    ///The ID of the last frame marked as completed.
    ulong          cFrameComplete;
    ///The QPC time when the last frame was marked as completed.
    ulong          qpcFrameComplete;
    ///The ID of the last frame marked as pending.
    ulong          cFramePending;
    ///The QPC time when the last frame was marked as pending.
    ulong          qpcFramePending;
    ///The number of unique frames displayed. This value is valid only after a second call to the
    ///DwmGetCompositionTimingInfo function.
    ulong          cFramesDisplayed;
    ///The number of new completed frames that have been received.
    ulong          cFramesComplete;
    ///The number of new frames submitted to DirectX but not yet completed.
    ulong          cFramesPending;
    ///The number of frames available but not displayed, used, or dropped. This value is valid only after a second call
    ///to DwmGetCompositionTimingInfo.
    ulong          cFramesAvailable;
    ///The number of rendered frames that were never displayed because composition occurred too late. This value is
    ///valid only after a second call to DwmGetCompositionTimingInfo.
    ulong          cFramesDropped;
    ///The number of times an old frame was composed when a new frame should have been used but was not available.
    ulong          cFramesMissed;
    ///The frame count at which the next frame is scheduled to be displayed.
    ulong          cRefreshNextDisplayed;
    ///The frame count at which the next DirectX present is scheduled to be displayed.
    ulong          cRefreshNextPresented;
    ///The total number of refreshes that have been displayed for the application since the DwmSetPresentParameters
    ///function was last called.
    ulong          cRefreshesDisplayed;
    ///The total number of refreshes that have been presented by the application since DwmSetPresentParameters was last
    ///called.
    ulong          cRefreshesPresented;
    ///The refresh number when content for this window started to be displayed.
    ulong          cRefreshStarted;
    ///The total number of pixels DirectX redirected to the DWM.
    ulong          cPixelsReceived;
    ///The number of pixels drawn.
    ulong          cPixelsDrawn;
    ///The number of empty buffers in the flip chain.
    ulong          cBuffersEmpty;
}

///Specifies Desktop Window Manager (DWM) video frame parameters for frame composition. Used by the
///DwmSetPresentParameters function.
struct DWM_PRESENT_PARAMETERS
{
align (1):
    ///The size of the <b>DWM_PRESENT_PARAMETERS</b> structure.
    uint           cbSize;
    ///<b>TRUE</b> if the caller is requesting queued presents; otherwise, <b>FALSE</b>. If <b>TRUE</b>, the remaining
    ///parameters must be specified. If <b>FALSE</b>, queued presentation is disabled for this window and present
    ///behavior returns to the default behavior.
    BOOL           fQueue;
    ///A <b>ULONGLONG</b> value that provides the refresh number that the next presented frame should begin to display.
    ulong          cRefreshStart;
    ///The number of frames the application is instructing DWM to queue. The valid range is 2-8.
    uint           cBuffer;
    ///<b>TRUE</b> if the application wants DWM to schedule presentation based on source rate. <b>FALSE</b> if the
    ///application will decide how many refreshes to display for each frame. If <b>TRUE</b>, <b>rateSource</b> must be
    ///specified. If <b>FALSE</b>, <b>cRefreshesPerFrame</b> must be specified.
    BOOL           fUseSourceRate;
    ///The rate, in frames per second, of the source material being displayed.
    UNSIGNED_RATIO rateSource;
    ///The number of monitor refreshes through which each frame should be displayed on the screen.
    uint           cRefreshesPerFrame;
    ///The frame sampling type to use for composition.
    DWM_SOURCE_FRAME_SAMPLING eSampling;
}

// Functions

///Default window procedure for Desktop Window Manager (DWM) hit testing within the non-client area. You also need to
///ensure that <b>DwmDefWindowProc</b> is called for the WM_NCMOUSELEAVE message. If <b>DwmDefWindowProc</b> is not
///called for the <b>WM_NCMOUSELEAVE</b> message, DWM does not remove the highlighting from the <b>Maximize</b>,
///<b>Minimize</b>, and <b>Close</b> buttons when the cursor leaves the window.
///Params:
///    hWnd = A handle to the window procedure that received the message.
///    msg = The message.
///    wParam = Specifies additional message information. The content of this parameter depends on the value of the <i>msg</i>
///             parameter.
///    lParam = Specifies additional message information. The content of this parameter depends on the value of the <i>msg</i>
///             parameter.
///    plResult = A pointer to an <b>LRESULT</b> value that, when this method returns successfully,receives the result of the hit
///               test.
///Returns:
///    <b>TRUE</b> if <b>DwmDefWindowProc</b> handled the message; otherwise, <b>FALSE</b>.
///    
@DllImport("dwmapi")
BOOL DwmDefWindowProc(HWND hWnd, uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);

///Enables the blur effect on a specified window.
///Params:
///    hWnd = The handle to the window on which the blur-behind data is applied.
///    pBlurBehind = `[in]` A pointer to a DWM_BLURBEHIND structure that provides blur-behind data.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmEnableBlurBehindWindow(HWND hWnd, const(DWM_BLURBEHIND)* pBlurBehind);

///Enables or disables Desktop Window Manager (DWM) composition. <div class="alert"><b>Note</b> This function is
///deprecated as of Windows 8. DWM can no longer be programmatically disabled.</div><div> </div>
///Params:
///    uCompositionAction = <b>DWM_EC_ENABLECOMPOSITION</b> to enable DWM composition; <b>DWM_EC_DISABLECOMPOSITION</b> to disable
///                         composition. <div class="alert"><b>Note</b> As of Windows 8, calling this function with
///                         <b>DWM_EC_DISABLECOMPOSITION</b> has no effect. However, the function will still return a success code.</div>
///                         <div> </div>
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmEnableComposition(uint uCompositionAction);

///Notifies the Desktop Window Manager (DWM) to opt in to or out of Multimedia Class Schedule Service (MMCSS) scheduling
///while the calling process is alive.
///Params:
///    fEnableMMCSS = <b>TRUE</b> to instruct DWM to participate in MMCSS scheduling; <b>FALSE</b> to opt out or end participation in
///                   MMCSS scheduling.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmEnableMMCSS(BOOL fEnableMMCSS);

///Extends the window frame into the client area.
///Params:
///    hWnd = The handle to the window in which the frame will be extended into the client area.
///    pMarInset = A pointer to a MARGINS structure that describes the margins to use when extending the frame into the client area.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmExtendFrameIntoClientArea(HWND hWnd, const(MARGINS)* pMarInset);

///Retrieves the current color used for Desktop Window Manager (DWM) glass composition. This value is based on the
///current color scheme and can be modified by the user. Applications can listen for color changes by handling the
///WM_DWMCOLORIZATIONCOLORCHANGED notification.
///Params:
///    pcrColorization = A pointer to a value that, when this function returns successfully, receives the current color used for glass
///                      composition. The color format of the value is 0xAARRGGBB.
///    pfOpaqueBlend = A pointer to a value that, when this function returns successfully, indicates whether the color is an opaque
///                    blend. <b>TRUE</b> if the color is an opaque blend; otherwise, <b>FALSE</b>.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmGetColorizationColor(uint* pcrColorization, int* pfOpaqueBlend);

///Retrieves the current composition timing information for a specified window.
///Params:
///    hwnd = The handle to the window for which the composition timing information should be retrieved. Starting with Windows
///           8.1, this parameter must be set to <b>NULL</b>. If this parameter is not set to <b>NULL</b>,
///           <b>DwmGetCompositionTimingInfo</b> returns E_INVALIDARG.
///    pTimingInfo = A pointer to a DWM_TIMING_INFO structure that, when this function returns successfully, receives the current
///                  composition timing information for the window. The <b>cbSize</b> member of this structure must be set before this
///                  function is called.
@DllImport("dwmapi")
HRESULT DwmGetCompositionTimingInfo(HWND hwnd, DWM_TIMING_INFO* pTimingInfo);

///Retrieves the current value of a specified Desktop Window Manager (DWM) attribute applied to a window. For
///programming guidance, and code examples, see [Controlling non-client region
///rendering](/windows/desktop/dwm/composition-ovw#controlling-non-client-region-rendering).
///Params:
///    hwnd = The handle to the window from which the attribute value is to be retrieved.
///    dwAttribute = A flag describing which value to retrieve, specified as a value of the
///                  [DWMWINDOWATTRIBUTE](/windows/desktop/api/dwmapi/ne-dwmapi-dwmwindowattribute) enumeration. This parameter
///                  specifies which attribute to retrieve, and the *pvAttribute* parameter points to an object into which the
///                  attribute value is retrieved.
///    pvAttribute = A pointer to a value which, when this function returns successfully, receives the current value of the attribute.
///                  The type of the retrieved value depends on the value of the *dwAttribute* parameter. The
///                  [**DWMWINDOWATTRIBUTE**](/windows/desktop/api/Dwmapi/ne-dwmapi-dwmwindowattribute) enumeration topic indicates,
///                  in the row for each flag, what type of value you should pass a pointer to in the *pvAttribute* parameter.
///    cbAttribute = The size, in bytes, of the attribute value being received via the *pvAttribute* parameter. The type of the
///                  retrieved value, and therefore its size in bytes, depends on the value of the *dwAttribute* parameter.
///Returns:
///    Type: **[HRESULT](/windows/desktop/com/structure-of-com-error-codes)** If the function succeeds, it returns
///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
///    code](/windows/desktop/com/com-error-codes-10).
///    
@DllImport("dwmapi")
HRESULT DwmGetWindowAttribute(HWND hwnd, uint dwAttribute, char* pvAttribute, uint cbAttribute);

///Obtains a value that indicates whether Desktop Window Manager (DWM) composition is enabled. Applications on machines
///running Windows 7 or earlier can listen for composition state changes by handling the WM_DWMCOMPOSITIONCHANGED
///notification.
///Params:
///    pfEnabled = A pointer to a value that, when this function returns successfully, receives <b>TRUE</b> if DWM composition is
///                enabled; otherwise, <b>FALSE</b>. <div class="alert"><b>Note</b> As of Windows 8, DWM composition is always
///                enabled. If an app declares Windows 8 compatibility in their manifest, this function will receive a value of
///                <b>TRUE</b> through <i>pfEnabled</i>. If no such manifest entry is found, Windows 8 compatibility is not assumed
///                and this function receives a value of <b>FALSE</b> through <i>pfEnabled</i>. This is done so that older programs
///                that interpret a value of <b>TRUE</b> to imply that high contrast mode is off can continue to make the correct
///                decisions about rendering their images. (Note that this is a bad practice—you should use the
///                SystemParametersInfo function with the <b>SPI_GETHIGHCONTRAST</b> flag to determine the state of high contrast
///                mode.)</div> <div> </div> For more information, see Supporting High Contrast Themes.
@DllImport("dwmapi")
HRESULT DwmIsCompositionEnabled(int* pfEnabled);

///Changes the number of monitor refreshes through which the previous frame will be displayed.
///<b>DwmModifyPreviousDxFrameDuration</b> is no longer supported. Starting with Windows 8.1, calls to
///<b>DwmModifyPreviousDxFrameDuration</b> always return E_NOTIMPL.
///Params:
///    hwnd = The handle to the window for which the new duration is applied to the previous frame.
///    cRefreshes = The number of refreshes to apply to the previous frame.
///    fRelative = <b>TRUE</b> if the value given in <i>cRefreshes</i> is relative to the current value (added to or subtracted from
///                it); <b>FALSE</b> if the value replaces the current value.
@DllImport("dwmapi")
HRESULT DwmModifyPreviousDxFrameDuration(HWND hwnd, int cRefreshes, BOOL fRelative);

///Retrieves the source size of the Desktop Window Manager (DWM) thumbnail.
///Params:
///    hThumbnail = A handle to the thumbnail to retrieve the source window size from.
///    pSize = A pointer to a SIZE structure that, when this function returns successfully, receives the size of the source
///            thumbnail.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmQueryThumbnailSourceSize(ptrdiff_t hThumbnail, SIZE* pSize);

///Creates a Desktop Window Manager (DWM) thumbnail relationship between the destination and source windows.
///Params:
///    hwndDestination = The handle to the window that will use the DWM thumbnail. Setting the destination window handle to anything other
///                      than a top-level window type will result in a return value of E_INVALIDARG.
///    hwndSource = The handle to the window to use as the thumbnail source. Setting the source window handle to anything other than
///                 a top-level window type will result in a return value of E_INVALIDARG.
///    phThumbnailId = A pointer to a handle that, when this function returns successfully, represents the registration of the DWM
///                    thumbnail.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmRegisterThumbnail(HWND hwndDestination, HWND hwndSource, ptrdiff_t* phThumbnailId);

///Sets the number of monitor refreshes through which to display the presented frame. <b>DwmSetDxFrameDuration</b> is no
///longer supported. Starting with Windows 8.1, calls to <b>DwmSetDxFrameDuration</b> always return E_NOTIMPL.
///Params:
///    hwnd = The handle to the window that displays the presented frame.
///    cRefreshes = The number of refreshes through which to display the presented frame.
///Returns:
///    This function always returns S_OK, even when the frame duration is not changed or DWM is not running.
///    
@DllImport("dwmapi")
HRESULT DwmSetDxFrameDuration(HWND hwnd, int cRefreshes);

///Sets the present parameters for frame composition. <b>DwmSetPresentParameters</b> is no longer supported. Starting
///with Windows 8.1, calls to <b>DwmSetPresentParameters</b> always return E_NOTIMPL.
///Params:
///    hwnd = The handle to the window where the present parameters are applied.
///    pPresentParams = A pointer to a DWM_PRESENT_PARAMETERS structure that contains DWM video frame parameters for frame composition.
@DllImport("dwmapi")
HRESULT DwmSetPresentParameters(HWND hwnd, DWM_PRESENT_PARAMETERS* pPresentParams);

///Sets the value of Desktop Window Manager (DWM) non-client rendering attributes for a window. For programming
///guidance, and code examples, see [Controlling non-client region
///rendering](/windows/desktop/dwm/composition-ovw#controlling-non-client-region-rendering).
///Params:
///    hwnd = The handle to the window for which the attribute value is to be set.
///    dwAttribute = A flag describing which value to set, specified as a value of the
///                  [DWMWINDOWATTRIBUTE](/windows/desktop/api/dwmapi/ne-dwmapi-dwmwindowattribute) enumeration. This parameter
///                  specifies which attribute to set, and the *pvAttribute* parameter points to an object containing the attribute
///                  value.
///    pvAttribute = A pointer to an object containing the attribute value to set. The type of the value set depends on the value of
///                  the *dwAttribute* parameter. The
///                  [**DWMWINDOWATTRIBUTE**](/windows/desktop/api/Dwmapi/ne-dwmapi-dwmwindowattribute) enumeration topic indicates,
///                  in the row for each flag, what type of value you should pass a pointer to in the *pvAttribute* parameter.
///    cbAttribute = The size, in bytes, of the attribute value being set via the *pvAttribute* parameter. The type of the value set,
///                  and therefore its size in bytes, depends on the value of the *dwAttribute* parameter.
///Returns:
///    Type: **[HRESULT](/windows/desktop/com/structure-of-com-error-codes)** If the function succeeds, it returns
///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
///    code](/windows/desktop/com/com-error-codes-10). If Desktop Composition has been disabled (Windows 7 and earlier),
///    then this function returns **DWM_E_COMPOSITIONDISABLED**.
///    
@DllImport("dwmapi")
HRESULT DwmSetWindowAttribute(HWND hwnd, uint dwAttribute, char* pvAttribute, uint cbAttribute);

///Removes a Desktop Window Manager (DWM) thumbnail relationship created by the DwmRegisterThumbnail function.
///Params:
///    hThumbnailId = The handle to the thumbnail relationship to be removed. Null or non-existent handles will result in a return
///                   value of E_INVALIDARG.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmUnregisterThumbnail(ptrdiff_t hThumbnailId);

///Updates the properties for a Desktop Window Manager (DWM) thumbnail.
///Params:
///    hThumbnailId = The handle to the DWM thumbnail to be updated. Null or invalid thumbnails, as well as thumbnails owned by other
///                   processes will result in a return value of E_INVALIDARG.
///    ptnProperties = A pointer to a DWM_THUMBNAIL_PROPERTIES structure that contains the new thumbnail properties.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmUpdateThumbnailProperties(ptrdiff_t hThumbnailId, const(DWM_THUMBNAIL_PROPERTIES)* ptnProperties);

///Sets a static, iconic bitmap on a window or tab to use as a thumbnail representation. The taskbar can use this bitmap
///as a thumbnail switch target for the window or tab.
///Params:
///    hwnd = A handle to the window or tab. This window must belong to the calling process.
///    hbmp = A handle to the bitmap to represent the window that <i>hwnd</i> specifies.
///    dwSITFlags = The display options for the thumbnail. One of the following values:
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmSetIconicThumbnail(HWND hwnd, HBITMAP hbmp, uint dwSITFlags);

///Sets a static, iconic bitmap to display a <i>live preview</i> (also known as a <i>Peek preview</i>) of a window or
///tab. The taskbar can use this bitmap to show a full-sized preview of a window or tab.
///Params:
///    hwnd = A handle to the window. This window must belong to the calling process.
///    hbmp = A handle to the bitmap to represent the window that <i>hwnd</i> specifies.
///    pptClient = The offset of a tab window's <i>client region</i> (the content area inside the client window frame) from the host
///                window's frame. This offset enables the tab window's contents to be drawn correctly in a live preview when it is
///                drawn without its frame.
///    dwSITFlags = The display options for the live preview. This parameter can be 0 or the following value.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds, or an error value otherwise. Note that because this bitmap is not
///    cached, if the window is not being previewed when an application calls this function, the function returns a
///    success code but the bitmap is discarded and not used.
///    
@DllImport("dwmapi")
HRESULT DwmSetIconicLivePreviewBitmap(HWND hwnd, HBITMAP hbmp, POINT* pptClient, uint dwSITFlags);

///Called by an application to indicate that all previously provided iconic bitmaps from a window, both thumbnails and
///peek representations, should be refreshed.
///Params:
///    hwnd = A handle to the window or tab whose bitmaps are being invalidated through this call. This window must belong to
///           the calling process.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmInvalidateIconicBitmaps(HWND hwnd);

///This function is deprecated and only returns DWM_E_COMPOSITIONDISABLED in Windows 7 and later. It may be removed in
///future versions of Windows.
///Params:
///    hwnd = 
@DllImport("dwmapi")
HRESULT DwmAttachMilContent(HWND hwnd);

///This function is deprecated and only returns DWM_E_COMPOSITIONDISABLED in Windows 7 and later. It may be removed in
///future versions of Windows.
///Params:
///    hwnd = 
@DllImport("dwmapi")
HRESULT DwmDetachMilContent(HWND hwnd);

///Issues a flush call that blocks the caller until the next present, when all of the Microsoft DirectX surface updates
///that are currently outstanding have been made. This compensates for very complex scenes or calling processes with
///very low priority.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dwmapi")
HRESULT DwmFlush();

///This function is deprecated and only returns DWM_E_COMPOSITIONDISABLED in Windows 7 and later. It may be removed in
///future versions of Windows.
///Params:
///    uIndex = 
///    pTransform = 
@DllImport("dwmapi")
HRESULT DwmGetGraphicsStreamTransformHint(uint uIndex, MilMatrix3x2D* pTransform);

///This function is deprecated and only returns DWM_E_COMPOSITIONDISABLED in Windows 7 and later. It may be removed in
///future versions of Windows.
///Params:
///    uIndex = 
///    pClientUuid = 
@DllImport("dwmapi")
HRESULT DwmGetGraphicsStreamClient(uint uIndex, GUID* pClientUuid);

///Retrieves transport attributes.
///Params:
///    pfIsRemoting = A pointer to a <b>BOOL</b> value that indicates whether the transport supports remoting. <b>TRUE</b> if the
///                   transport supports remoting; otherwise, <b>FALSE</b>.
///    pfIsConnected = A pointer to a <b>BOOL</b> value that indicates whether the transport is connected. <b>TRUE</b> if the transport
///                    is connected; otherwise, <b>FALSE</b>.
///    pDwGeneration = A pointer to a <b>DWORD</b> that receives a generation value for the transport.
@DllImport("dwmapi")
HRESULT DwmGetTransportAttributes(int* pfIsRemoting, int* pfIsConnected, uint* pDwGeneration);

///Coordinates the animations of tool windows with the Desktop Window Manager (DWM).
///Params:
///    hwnd = Handle to the window.
@DllImport("dwmapi")
HRESULT DwmTransitionOwnedWindow(HWND hwnd, DWMTRANSITION_OWNEDWINDOW_TARGET target);

///Notifies Desktop Window Manager (DWM) that a touch contact has been recognized as a gesture, and that DWM should draw
///feedback for that gesture.
///Params:
///    arg1 = The type of gesture, specified as one of the GESTURE_TYPE values.
///    cContacts = The number of contact points.
///    pdwPointerID = The pointer ID.
@DllImport("dwmapi")
HRESULT DwmRenderGesture(GESTURE_TYPE gt, uint cContacts, char* pdwPointerID, char* pPoints);

///Enables the graphical feedback of touch and drag interactions to the user.
///Params:
///    dwPointerID = The pointer ID.
///    fEnable = Indicates whether the contact is enabled.
@DllImport("dwmapi")
HRESULT DwmTetherContact(uint dwPointerID, BOOL fEnable, POINT ptTether);

///Called by an app or framework to specify the visual feedback type to draw in response to a particular touch or pen
///contact.
///Params:
///    dwPointerID = The pointer ID of the contact. Each touch or pen contact is given a unique ID when it is detected.
///    arg2 = One or more of the following DWM_SHOWCONTACT visualizations that DWM should show for this contact.
///Returns:
///    If <i>dwPointerID</i> does not match that of a contact currently present on the screen, this function returns
///    E_INVALIDARG; otherwise, it returns S_OK.
///    
@DllImport("dwmapi")
HRESULT DwmShowContact(uint dwPointerID, DWM_SHOWCONTACT eShowContact);

///<b>Note</b> This function is publically available, but nonfunctional, for Windows 10, version 1803.</p>Checks the
///requirements needed to get tabs in the application title bar for the specified window.
///Params:
///    appWindow = The handle of the window to check.
@DllImport("dwmapi")
HRESULT DwmGetUnmetTabRequirements(HWND appWindow, DWM_TAB_WINDOW_REQUIREMENTS* value);


