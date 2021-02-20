// Written in the D programming language.

module windows.directcomposition;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct2d : D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE, D2D1_BLEND_MODE,
                                 D2D1_BORDER_MODE, D2D1_COLORMATRIX_ALPHA_MODE,
                                 D2D1_COMPOSITE_MODE, D2D1_TURBULENCE_NOISE,
                                 D2D_MATRIX_3X2_F, D2D_MATRIX_4X4_F,
                                 D2D_MATRIX_5X4_F, D2D_RECT_F, D2D_VECTOR_2F,
                                 D2D_VECTOR_4F;
public import windows.direct3d9 : D3DMATRIX;
public import windows.displaydevices : POINT, RECT;
public import windows.dxgi : DXGI_ALPHA_MODE, DXGI_FORMAT, DXGI_RATIONAL, DXGI_RGBA,
                             IDXGIDevice;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


///Specifies the interpolation mode to be used when a bitmap is composed with any transform where the pixels in the
///bitmap don't line up exactly one-to-one with pixels on screen.
alias DCOMPOSITION_BITMAP_INTERPOLATION_MODE = int;
enum : int
{
    ///Bitmaps are interpolated by using nearest-neighbor sampling.
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    ///Bitmaps are interpolated by using linear sampling.
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_LINEAR           = 0x00000001,
    ///Bitmaps are interpolated according to the mode established by the parent visual.
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_INHERIT          = 0xffffffff,
}

///Specifies the border mode to use when composing a bitmap or applying a clip with any transform such that the edges of
///the bitmap or clip are not axis-aligned with integer coordinates.
alias DCOMPOSITION_BORDER_MODE = int;
enum : int
{
    ///Bitmap and clip edges are antialiased.
    DCOMPOSITION_BORDER_MODE_SOFT    = 0x00000000,
    ///Bitmap and clip edges are aliased. See Remarks.
    DCOMPOSITION_BORDER_MODE_HARD    = 0x00000001,
    ///Bitmap and clip edges are drawn according to the mode established by the parent visual.
    DCOMPOSITION_BORDER_MODE_INHERIT = 0xffffffff,
}

///The mode to use to blend the bitmap content of a visual with the render target.
alias DCOMPOSITION_COMPOSITE_MODE = int;
enum : int
{
    ///The standard source-over-destination blend mode.
    DCOMPOSITION_COMPOSITE_MODE_SOURCE_OVER        = 0x00000000,
    ///The bitmap colors are inverted.
    DCOMPOSITION_COMPOSITE_MODE_DESTINATION_INVERT = 0x00000001,
    ///Bitmap colors subtract for color channels in the background.
    DCOMPOSITION_COMPOSITE_MODE_MIN_BLEND          = 0x00000002,
    ///Bitmaps are blended according to the mode established by the parent visual.
    DCOMPOSITION_COMPOSITE_MODE_INHERIT            = 0xffffffff,
}

///Specifies the backface visibility to be applied to a visual.
alias DCOMPOSITION_BACKFACE_VISIBILITY = int;
enum : int
{
    ///Surfaces in this visual's sub-tree are visible regardless of transformation.
    DCOMPOSITION_BACKFACE_VISIBILITY_VISIBLE = 0x00000000,
    ///Surfaces in this visual's sub-tree are only visible when facing the observer.
    DCOMPOSITION_BACKFACE_VISIBILITY_HIDDEN  = 0x00000001,
    ///The back face visibility is the same as that of the target visual's parent visual.
    DCOMPOSITION_BACKFACE_VISIBILITY_INHERIT = 0xffffffff,
}

///Specifies how the effective opacity value of a visual is applied to that visual’s content and children.
alias DCOMPOSITION_OPACITY_MODE = int;
enum : int
{
    ///The target visual defines a logical layer into which its entire sub-tree is composed with a starting effective
    ///opacity of 1.0. The original opacity value is then used to blend the layer onto the visual’s background.
    DCOMPOSITION_OPACITY_MODE_LAYER    = 0x00000000,
    ///The opacity value is multiplied with the effective opacity of the parent visual and the result is then
    ///individually applied to each piece of content in this visual’s sub-tree.
    DCOMPOSITION_OPACITY_MODE_MULTIPLY = 0x00000001,
    ///The opacity mode is the same as that of the target visual’s parent visual.
    DCOMPOSITION_OPACITY_MODE_INHERIT  = 0xffffffff,
}

alias DCOMPOSITION_DEPTH_MODE = int;
enum : int
{
    DCOMPOSITION_DEPTH_MODE_TREE    = 0x00000000,
    DCOMPOSITION_DEPTH_MODE_SPATIAL = 0x00000001,
    DCOMPOSITION_DEPTH_MODE_SORTED  = 0x00000003,
    DCOMPOSITION_DEPTH_MODE_INHERIT = 0xffffffff,
}

// Structs


///Describes timing and composition statistics for a frame.
struct DCOMPOSITION_FRAME_STATISTICS
{
    ///Type: <b>LARGE_INTEGER</b> The time stamp of the last batch of commands to be processed by the composition
    ///engine.
    LARGE_INTEGER lastFrameTime;
    ///Type: <b>DXGI_RATIONAL</b> The rate at which the composition engine is producing frames, in frames per second.
    DXGI_RATIONAL currentCompositionRate;
    ///Type: <b>LARGE_INTEGER</b> The current time as computed by the QueryPerformanceCounter function.
    LARGE_INTEGER currentTime;
    ///Type: <b>LARGE_INTEGER</b> The units in which the <b>lastFrameTime</b> and <b>currentTime</b> members are
    ///specified, in Hertz.
    LARGE_INTEGER timeFrequency;
    ///Type: <b>LARGE_INTEGER</b> The estimated time when the next frame will be displayed.
    LARGE_INTEGER nextEstimatedFrameTime;
}

// Functions

///Creates a new device object that can be used to create other Microsoft DirectComposition objects.
///Params:
///    dxgiDevice = Type: <b>IDXGIDevice*</b> The DXGI device to use to create DirectComposition surface objects.
///    iid = Type: <b>REFIID</b> The identifier of the interface to retrieve.
///    dcompositionDevice = Type: <b>void**</b> Receives an interface pointer to the newly created device object. The pointer is of the type
///                         specified by the <i>iid</i> parameter. This parameter must not be NULL.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
///    code. See DirectComposition Error Codes for a list of error codes.
///    
@DllImport("dcomp")
HRESULT DCompositionCreateDevice(IDXGIDevice dxgiDevice, const(GUID)* iid, void** dcompositionDevice);

///Creates a new device object that can be used to create other Microsoft DirectComposition objects.
///Params:
///    renderingDevice = An optional pointer to a DirectX device to be used to create DirectComposition surface objects. Must be a pointer
///                      to an object implementing the IDXGIDevice or ID2D1Device interfaces.
///    iid = The identifier of the interface to retrieve. This must be one of __uuidof(IDCompositionDevice) or
///          __uuidof(IDCompositionDesktopDevice).
///    dcompositionDevice = Receives an interface pointer to the newly created device object. The pointer is of the type specified by the
///                         <i>iid</i> parameter. This parameter must not be NULL.
///Returns:
///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
///    DirectComposition Error Codes for a list of error codes.
///    
@DllImport("dcomp")
HRESULT DCompositionCreateDevice2(IUnknown renderingDevice, const(GUID)* iid, void** dcompositionDevice);

///Creates a new DirectComposition device object, which can be used to create other DirectComposition objects.
///Params:
///    renderingDevice = Type: <b>IUnknown*</b> An optional pointer to a DirectX device to be used to create DirectComposition surface
///                      objects. Must be a pointer to an object implementing the IDXGIDevice or ID2D1Device interfaces.
///    iid = Type: <b>REFIID</b> The identifier of the interface to retrieve. This must be one of
///          __uuidof(IDCompositionDevice) or __uuidof(IDCompositionDesktopDevice).
///    dcompositionDevice = Type: <b>void**</b> Receives an interface pointer to the newly created device object. The pointer is of the type
///                         specified by the <i>iid</i> parameter. This parameter must not be NULL.
@DllImport("dcomp")
HRESULT DCompositionCreateDevice3(IUnknown renderingDevice, const(GUID)* iid, void** dcompositionDevice);

///Creates a new composition surface object that can be bound to a Microsoft DirectX swap chain or swap buffer and
///associated with a visual.
///Params:
///    desiredAccess = Type: <b>DWORD</b> The requested access to the composition surface object. It can be one of the following values:
///                    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt>
///                    <dt>0x0000L</dt> </dl> </td> <td width="60%"> No access. </td> </tr> <tr> <td width="40%"><a
///                    id="COMPOSITIONSURFACE_READ"></a><a id="compositionsurface_read"></a><dl> <dt><b>COMPOSITIONSURFACE_READ</b></dt>
///                    <dt>0x0001L</dt> </dl> </td> <td width="60%"> Read access. For internal use only. </td> </tr> <tr> <td
///                    width="40%"><a id="COMPOSITIONSURFACE_WRITE"></a><a id="compositionsurface_write"></a><dl>
///                    <dt><b>COMPOSITIONSURFACE_WRITE</b></dt> <dt>0x0002L</dt> </dl> </td> <td width="60%"> Write access. For internal
///                    use only. </td> </tr> <tr> <td width="40%"><a id="COMPOSITIONSURFACE_ALL_ACCESS"></a><a
///                    id="compositionsurface_all_access"></a><dl> <dt><b>COMPOSITIONSURFACE_ALL_ACCESS</b></dt> <dt>0x0003L</dt> </dl>
///                    </td> <td width="60%"> Read/write access. Always specify this flag except when duplicating a surface in another
///                    process, in which case set <i>desiredAccess</i> to 0. </td> </tr> </table>
///    securityAttributes = Type: <b>SECURITY_ATTRIBUTES*</b> Contains the security descriptor for the composition surface object, and
///                         specifies whether the handle of the composition surface object is inheritable when a child process is created. If
///                         this parameter is NULL, the composition surface object is created with default security attributes that grant
///                         read and write access to the current process, but do not enable child processes to inherit the handle.
///    surfaceHandle = Type: <b>HANDLE*</b> The handle of the new composition surface object. This parameter must not be NULL.
@DllImport("dcomp")
HRESULT DCompositionCreateSurfaceHandle(uint desiredAccess, SECURITY_ATTRIBUTES* securityAttributes, 
                                        HANDLE* surfaceHandle);

///Creates an Interaction/InputSink to route mouse wheel messages to the given HWND. This will fail if there is already
///an interaction attached to this visual. After calling this API, the device that owns the visual must be committed.
///Params:
///    visual = Type: <b>IDCompositionVisual*</b> The visual to route messages from.
///    hwnd = Type: <b>HWND</b> The HWND to route messages to.
///    enable = Type: <b>BOOL</b> Boolean value indicating whether to enable or disable routing.
@DllImport("dcomp")
HRESULT DCompositionAttachMouseWheelToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);

///Creates an Interaction/InputSink to route mouse button down and any subsequent move and up events to the given HWND.
///There is no move thresholding; when enabled, all events including and following the down are unconditionally
///redirected to the specified window. After calling this API, the device owning the visual must be committed.
///Params:
///    visual = Type: <b>IDCompositionVisual*</b> The visual to route messages from.
///    hwnd = Type: <b>HWND</b> The HWND to route messages to.
///    enable = Type: <b>BOOL</b> Boolean value indicating whether to enable or disable routing.
@DllImport("dcomp")
HRESULT DCompositionAttachMouseDragToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);


// Interfaces

///Represents a function for animating one or more properties of one or more Microsoft DirectComposition objects. Any
///object property that takes a scalar value can be animated.
@GUID("CBFD91D9-51B2-45E4-B3DE-D19CCFB863C5")
interface IDCompositionAnimation : IUnknown
{
    ///Resets the animation function so that it contains no segments.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT Reset();
    ///Sets the absolute time at which the animation function starts.
    ///Params:
    ///    beginTime = Type: <b>LARGE_INTEGER</b> The starting time for this animation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetAbsoluteBeginTime(LARGE_INTEGER beginTime);
    ///Adds a cubic polynomial segment to the animation function.
    ///Params:
    ///    beginOffset = Type: <b>double</b> The offset, in seconds, from the beginning of the animation function to the point when
    ///                  this segment should take effect.
    ///    constantCoefficient = Type: <b>float</b> The constant coefficient of the polynomial.
    ///    linearCoefficient = Type: <b>float</b> The linear coefficient of the polynomial.
    ///    quadraticCoefficient = Type: <b>float</b> The quadratic coefficient of the polynomial.
    ///    cubicCoefficient = Type: <b>float</b> The cubic coefficient of the polynomial.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT AddCubic(double beginOffset, float constantCoefficient, float linearCoefficient, 
                     float quadraticCoefficient, float cubicCoefficient);
    ///Adds a sinusoidal segment to the animation function.
    ///Params:
    ///    beginOffset = Type: <b>double</b> The offset, in seconds, from the beginning of the animation function to the point when
    ///                  this segment should take effect.
    ///    bias = Type: <b>float</b> A constant that is added to the sinusoidal.
    ///    amplitude = Type: <b>float</b> A scale factor that is applied to the sinusoidal.
    ///    frequency = Type: <b>float</b> A scale factor that is applied to the time offset, in Hertz.
    ///    phase = Type: <b>float</b> A constant that is added to the time offset, in degrees.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT AddSinusoidal(double beginOffset, float bias, float amplitude, float frequency, float phase);
    ///Adds a repeat segment that causes the specified portion of an animation function to be repeated.
    ///Params:
    ///    beginOffset = Type: <b>double</b> The offset, in seconds, from the beginning of the animation to the point at which the
    ///                  repeat should begin.
    ///    durationToRepeat = Type: <b>double</b> The duration, in seconds, of a portion of the animation immediately preceding the begin
    ///                       time that is specified by <i>beginOffset</i>. This is the portion that will be repeated.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT AddRepeat(double beginOffset, double durationToRepeat);
    ///Adds an end segment that marks the end of an animation function.
    ///Params:
    ///    endOffset = Type: <b>double</b> The offset, in seconds, from the beginning of the animation function to the point when
    ///                the function ends.
    ///    endValue = Type: <b>float</b> The final value of the animation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT End(double endOffset, float endValue);
}

///Serves as a factory for all other Microsoft DirectComposition objects and provides methods to control transactional
///composition.
@GUID("C37EA93A-E7AA-450D-B16F-9746CB0407F3")
interface IDCompositionDevice : IUnknown
{
    ///Commits all DirectComposition commands that are pending on this device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT Commit();
    ///Waits for the composition engine to finish processing the previous call to the IDCompositionDevice::Commit
    ///method.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code. See DirectComposition
    ///    Error Codes for a list of error codes.
    ///    
    HRESULT WaitForCommitCompletion();
    ///Retrieves information from the composition engine about composition times and the frame rate.
    ///Params:
    ///    statistics = Type: <b>DCOMPOSITION_FRAME_STATISTICS*</b> A structure that receives composition times and frame rate
    ///                 information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
    ///Creates a composition target object that is bound to the window that is represented by the specified window
    ///handle (HWND).
    ///Params:
    ///    hwnd = Type: <b>HWND</b> The window to which the composition target object should be bound. This parameter must not
    ///           be NULL.
    ///    topmost = Type: <b>BOOL</b> TRUE if the visual tree should be displayed on top of the children of the window specified
    ///              by the <i>hwnd</i> parameter; otherwise, the visual tree is displayed behind the children.
    ///    target = Type: <b>IDCompositionTarget**</b> The new composition target object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
    ///Creates a new visual object.
    ///Params:
    ///    visual = Type: <b>IDCompositionVisual**</b> The new visual object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateVisual(IDCompositionVisual* visual);
    ///Creates an updateable surface object that can be associated with one or more visuals for composition.
    ///Params:
    ///    width = Type: <b>UINT</b> The width of the surface, in pixels.
    ///    height = Type: <b>UINT</b> The height of the surface, in pixels.
    ///    pixelFormat = Type: <b>DXGI_FORMAT</b> The pixel format of the surface.
    ///    alphaMode = Type: <b>DXGI_ALPHA_MODE</b> The format of the alpha channel, if an alpha channel is included in the pixel
    ///                format. It can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                width="40%"><a id="DXGI_ALPHA_MODE_UNSPECIFIED"></a><a id="dxgi_alpha_mode_unspecified"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_UNSPECIFIED</b></dt> </dl> </td> <td width="60%"> The alpha channel is not specified.
    ///                This value has the same effect as <b>DXGI_ALPHA_MODE_IGNORE</b>. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_PREMULTIPLIED"></a><a id="dxgi_alpha_mode_premultiplied"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_PREMULTIPLIED</b></dt> </dl> </td> <td width="60%"> The color channels contain values
    ///                that are premultiplied with the alpha channel. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_IGNORE"></a><a id="dxgi_alpha_mode_ignore"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_IGNORE</b></dt> </dl> </td> <td width="60%"> The alpha channel should be ignored and
    ///                the bitmap should be rendered opaquely. </td> </tr> </table>
    ///    surface = Type: <b>IDCompositionSurface**</b> The newly created surface object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
    ///Creates a sparsely populated surface that can be associated with one or more visuals for composition.
    ///Params:
    ///    initialWidth = Type: <b>UINT</b> The width of the surface, in pixels. The maximum width is 16,777,216 pixels.
    ///    initialHeight = Type: <b>UINT</b> The height of the surface, in pixels. The maximum height is 16,777,216 pixels.
    ///    pixelFormat = Type: <b>DXGI_FORMAT</b> The pixel format of the surface.
    ///    alphaMode = Type: <b>DXGI_ALPHA_MODE</b> The meaning of the alpha channel, if the pixel format contains an alpha channel.
    ///                It can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                width="40%"><a id="DXGI_ALPHA_MODE_UNSPECIFIED"></a><a id="dxgi_alpha_mode_unspecified"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_UNSPECIFIED</b></dt> </dl> </td> <td width="60%"> The alpha channel is not specified.
    ///                This value has the same effect as <b>DXGI_ALPHA_MODE_IGNORE</b>. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_PREMULTIPLIED"></a><a id="dxgi_alpha_mode_premultiplied"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_PREMULTIPLIED</b></dt> </dl> </td> <td width="60%"> The color channels contain values
    ///                that are premultiplied with the alpha channel. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_IGNORE"></a><a id="dxgi_alpha_mode_ignore"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_IGNORE</b></dt> </dl> </td> <td width="60%"> The alpha channel should be ignored and
    ///                the bitmap should be rendered opaquely. </td> </tr> </table>
    ///    virtualSurface = Type: <b>IDCompositionVirtualSurface**</b> The newly created surface object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
    ///Creates a new composition surface object that wraps an existing composition surface.
    ///Params:
    ///    handle = Type: <b>HANDLE</b> The handle of an existing composition surface that was created by a call to the
    ///             DCompositionCreateSurfaceHandle function.
    ///    surface = Type: <b>IUnknown**</b> The new composition surface object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurfaceFromHandle(HANDLE handle, IUnknown* surface);
    ///Creates a wrapper object that represents the rasterization of a layered window, and that can be associated with a
    ///visual for composition.
    ///Params:
    ///    hwnd = Type: [in] <b>HWND</b> The handle of the layered window for which to create a wrapper. A layered window is
    ///           created by specifying <b>WS_EX_LAYERED</b> when creating the window with the CreateWindowEx function or by
    ///           setting <b>WS_EX_LAYERED</b> via SetWindowLong after the window has been created.
    ///    surface = Type: [out] <b>IUnknown**</b> The new composition surface object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurfaceFromHwnd(HWND hwnd, IUnknown* surface);
    ///Creates a 2D translation transform object.
    ///Params:
    ///    translateTransform = Type: <b>IDCompositionTranslateTransform**</b> The new 2D translation transform object. This parameter must
    ///                         not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTranslateTransform(IDCompositionTranslateTransform* translateTransform);
    ///Creates a 2D scale transform object.
    ///Params:
    ///    scaleTransform = Type: <b>IDCompositionScaleTransform**</b> The new 2D scale transform object. This parameter must not be
    ///                     NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateScaleTransform(IDCompositionScaleTransform* scaleTransform);
    ///Creates a 2D rotation transform object.
    ///Params:
    ///    rotateTransform = Type: <b>IDCompositionRotateTransform**</b> The new rotation transform object. This parameter must not be
    ///                      NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateRotateTransform(IDCompositionRotateTransform* rotateTransform);
    ///Creates a 2D skew transform object.
    ///Params:
    ///    skewTransform = Type: <b>IDCompositionSkewTransform**</b> The new 2D skew transform object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSkewTransform(IDCompositionSkewTransform* skewTransform);
    ///Creates a 2D 3-by-2 matrix transform object.
    ///Params:
    ///    matrixTransform = Type: <b>IDCompositionMatrixTransform**</b> The new matrix transform object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateMatrixTransform(IDCompositionMatrixTransform* matrixTransform);
    ///Creates a 2D transform group object that holds an array of 2D transform objects.
    ///Params:
    ///    transforms = Type: <b>IDCompositionTransform**</b> An array of 2D transform objects that make up this transform group.
    ///    elements = Type: <b>UINT</b> The number of elements in the <i>transforms</i> array.
    ///    transformGroup = Type: <b>IDCompositionTransform**</b> The new transform group object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTransformGroup(IDCompositionTransform* transforms, uint elements, 
                                 IDCompositionTransform* transformGroup);
    ///Creates a 3D translation transform object.
    ///Params:
    ///    translateTransform3D = Type: <b>IDCompositionTranslateTransform3D**</b> The new 3D translation transform object. This parameter must
    ///                           not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTranslateTransform3D(IDCompositionTranslateTransform3D* translateTransform3D);
    ///Creates a 3D scale transform object.
    ///Params:
    ///    scaleTransform3D = Type: <b>IDCompositionScaleTransform3D**</b> The new 3D scale transform object. This parameter must not be
    ///                       NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateScaleTransform3D(IDCompositionScaleTransform3D* scaleTransform3D);
    ///Creates a 3D rotation transform object.
    ///Params:
    ///    rotateTransform3D = Type: <b>IDCompositionRotateTransform3D**</b> The new 3D rotation transform object. This parameter must not
    ///                        be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateRotateTransform3D(IDCompositionRotateTransform3D* rotateTransform3D);
    ///Creates a 3D 4-by-4 matrix transform object.
    ///Params:
    ///    matrixTransform3D = Type: <b>IDCompositionMatrixTransform3D**</b> The new 3D matrix transform object. This parameter must not be
    ///                        NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateMatrixTransform3D(IDCompositionMatrixTransform3D* matrixTransform3D);
    ///Creates a 3D transform group object that holds an array of 3D transform objects.
    ///Params:
    ///    transforms3D = Type: <b>IDCompositionTransform3D**</b> An array of 3D transform objects that make up this transform group.
    ///    elements = Type: <b>UINT</b> The number of elements in the <i>transforms</i> array.
    ///    transform3DGroup = Type: <b>IDCompositionTransform3D**</b> The new 3D transform group object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTransform3DGroup(IDCompositionTransform3D* transforms3D, uint elements, 
                                   IDCompositionTransform3D* transform3DGroup);
    ///Creates an object that represents multiple effects to be applied to a visual subtree.
    ///Params:
    ///    effectGroup = Type: <b>IDCompositionEffectGroup**</b> The new effect group object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateEffectGroup(IDCompositionEffectGroup* effectGroup);
    ///Creates a clip object that can be used to restrict the rendering of a visual subtree to a rectangular area.
    ///Params:
    ///    clip = Type: <b>IDCompositionRectangleClip**</b> The new clip object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateRectangleClip(IDCompositionRectangleClip* clip);
    ///Creates an animation object that is used to animate one or more scalar properties of one or more Microsoft
    ///DirectComposition objects.
    ///Params:
    ///    animation = Type: <b>IDCompositionAnimation**</b> The new animation object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateAnimation(IDCompositionAnimation* animation);
    ///Determines whether the DirectComposition device object is still valid.
    ///Params:
    ///    pfValid = TRUE if the DirectComposition device object is still valid; otherwise FALSE.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CheckDeviceState(BOOL* pfValid);
}

///Represents a binding between a Microsoft DirectComposition visual tree and a destination on top of which the visual
///tree should be composed.
@GUID("EACDD04C-117E-4E17-88F4-D1B12B0E3D89")
interface IDCompositionTarget : IUnknown
{
    ///Sets a visual object as the new root object of a visual tree.
    ///Params:
    ///    visual = Type: <b>IDCompositionVisual*</b> The visual object that is the new root of this visual tree. This parameter
    ///             can be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetRoot(IDCompositionVisual visual);
}

///Represents a Microsoft DirectComposition visual.
@GUID("4D93059D-097B-4651-9A60-F0F25116E2F3")
interface IDCompositionVisual : IUnknown
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
    HRESULT SetTransform(const(D2D_MATRIX_3X2_F)* matrix);
    HRESULT SetTransform(IDCompositionTransform transform);
    ///Sets the TransformParent property of this visual. The TransformParent property establishes the coordinate system
    ///relative to which this visual is composed.
    ///Params:
    ///    visual = Type: <b>IDCompositionVisual*</b> The new visual that establishes the base coordinate system for this visual.
    ///             This parameter can be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetTransformParent(IDCompositionVisual visual);
    ///Sets the Effect property of this visual. The Effect property modifies how the subtree that is rooted at this
    ///visual is blended with the background, and can apply a 3D perspective transform to the visual.
    ///Params:
    ///    effect = Type: <b>IDCompositionEffect*</b> A pointer to an effect object. This parameter can be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetEffect(IDCompositionEffect effect);
    ///Sets the BitmapInterpolationMode property, which specifies the mode for Microsoft DirectComposition to use when
    ///interpolating pixels from bitmaps that are not axis-aligned or drawn exactly at scale.
    ///Params:
    ///    interpolationMode = Type: <b>DCOMPOSITION_BITMAP_INTERPOLATION_MODE</b> The interpolation mode to use.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetBitmapInterpolationMode(DCOMPOSITION_BITMAP_INTERPOLATION_MODE interpolationMode);
    ///Sets the BorderMode property, which specifies how to compose the edges of bitmaps and clips associated with this
    ///visual, or with visuals in the subtree rooted at this visual.
    ///Params:
    ///    borderMode = Type: <b>DCOMPOSITION_BORDER_MODE</b> The border mode to use.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetBorderMode(DCOMPOSITION_BORDER_MODE borderMode);
    HRESULT SetClip(const(D2D_RECT_F)* rect);
    HRESULT SetClip(IDCompositionClip clip);
    ///Sets the Content property of this visual to the specified bitmap or window wrapper.
    ///Params:
    ///    content = Type: <b>IUnknown*</b> The object that is the new content of this visual. This parameter can be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetContent(IUnknown content);
    ///Adds a new child visual to the children list of this visual.
    ///Params:
    ///    visual = Type: <b>IDCompositionVisual*</b> The child visual to add. This parameter must not be NULL.
    ///    insertAbove = Type: <b>BOOL</b> TRUE to place the new child visual in front of the visual specified by the
    ///                  <i>referenceVisual</i> parameter, or FALSE to place it behind <i>referenceVisual</i>.
    ///    referenceVisual = Type: <b>IDCompositionVisual*</b> The existing child visual next to which the new visual should be added.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT AddVisual(IDCompositionVisual visual, BOOL insertAbove, IDCompositionVisual referenceVisual);
    ///Removes a child visual from the children list of this visual.
    ///Params:
    ///    visual = Type: <b>IDCompositionVisual*</b> The child visual to remove from the children list. This parameter must not
    ///             be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT RemoveVisual(IDCompositionVisual visual);
    ///Removes all visuals from the children list of this visual.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT RemoveAllVisuals();
    ///Sets the blending mode for this visual.
    ///Params:
    ///    compositeMode = Type: <b>DCOMPOSITION_COMPOSITE_MODE</b> The blending mode to use when composing the visual to the screen.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetCompositeMode(DCOMPOSITION_COMPOSITE_MODE compositeMode);
}

///Represents a bitmap effect that modifies the rasterization of a visual's subtree.
@GUID("EC81B08F-BFCB-4E8D-B193-A915587999E8")
interface IDCompositionEffect : IUnknown
{
}

///Represents a 3D transformation effect that can be used to modify the rasterization of a visual subtree.
@GUID("71185722-246B-41F2-AAD1-0443F7F4BFC2")
interface IDCompositionTransform3D : IDCompositionEffect
{
}

///Represents a 2D transformation that can be used to modify the coordinate space of a visual subtree.
@GUID("FD55FAA7-37E0-4C20-95D2-9BE45BC33F55")
interface IDCompositionTransform : IDCompositionTransform3D
{
}

///Represents a 2D transformation that affects only the offset of a visual along the x-axis and y-axis.
@GUID("06791122-C6F0-417D-8323-269E987F5954")
interface IDCompositionTranslateTransform : IDCompositionTransform
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
}

///Represents a 2D transformation that affects the scale of a visual along the x-axis and y-axis. The coordinate system
///is scaled from the specified center point.
@GUID("71FDE914-40EF-45EF-BD51-68B037C339F9")
interface IDCompositionScaleTransform : IDCompositionTransform
{
    HRESULT SetScaleX(float scaleX);
    HRESULT SetScaleX(IDCompositionAnimation animation);
    HRESULT SetScaleY(float scaleY);
    HRESULT SetScaleY(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
}

///Represents a 2D transformation that affects the rotation of a visual around the z-axis. The coordinate system is
///rotated around the specified center point.
@GUID("641ED83C-AE96-46C5-90DC-32774CC5C6D5")
interface IDCompositionRotateTransform : IDCompositionTransform
{
    HRESULT SetAngle(float angle);
    HRESULT SetAngle(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
}

///Represents a 2D transformation that affects the skew of a visual along the x-axis and y-axis. The coordinate system
///is skewed around the specified center point.
@GUID("E57AA735-DCDB-4C72-9C61-0591F58889EE")
interface IDCompositionSkewTransform : IDCompositionTransform
{
    HRESULT SetAngleX(float angleX);
    HRESULT SetAngleX(IDCompositionAnimation animation);
    HRESULT SetAngleY(float angleY);
    HRESULT SetAngleY(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
}

///Represents an arbitrary affine 2D transformation defined by a 3-by-2 matrix.
@GUID("16CDFF07-C503-419C-83F2-0965C7AF1FA6")
interface IDCompositionMatrixTransform : IDCompositionTransform
{
    ///Changes all values of the matrix of this 2D transform.
    ///Params:
    ///    matrix = Type: <b>const D2D_MATRIX_3X2_F</b> The new matrix for this 2D transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetMatrix(const(D2D_MATRIX_3X2_F)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
}

///Represents a group of bitmap effects that are applied together to modify the rasterization of a visual's subtree.
@GUID("A7929A74-E6B2-4BD6-8B95-4040119CA34D")
interface IDCompositionEffectGroup : IDCompositionEffect
{
    HRESULT SetOpacity(float opacity);
    HRESULT SetOpacity(IDCompositionAnimation animation);
    ///Sets the 3D transformation effect object that modifies the rasterization of the visuals that this effect group is
    ///applied to.
    ///Params:
    ///    transform3D = Type: <b>IDCompositionTransform3D*</b> Pointer to an IDCompositionTransform3D interface or one of its derived
    ///                  interfaces. This parameter can be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetTransform3D(IDCompositionTransform3D transform3D);
}

///Represents a 3D transformation that affects the offset of a visual along the x-axis, y-axis, and z-axis.
@GUID("91636D4B-9BA1-4532-AAF7-E3344994D788")
interface IDCompositionTranslateTransform3D : IDCompositionTransform3D
{
    HRESULT SetOffsetX(float offsetX);
    HRESULT SetOffsetX(IDCompositionAnimation animation);
    HRESULT SetOffsetY(float offsetY);
    HRESULT SetOffsetY(IDCompositionAnimation animation);
    HRESULT SetOffsetZ(float offsetZ);
    HRESULT SetOffsetZ(IDCompositionAnimation animation);
}

///Represents a 3D transformation effect that affects the scale of a visual along the x-axis, y-axis, and z-axis. The
///coordinate system is scaled from the specified center point.
@GUID("2A9E9EAD-364B-4B15-A7C4-A1997F78B389")
interface IDCompositionScaleTransform3D : IDCompositionTransform3D
{
    HRESULT SetScaleX(float scaleX);
    HRESULT SetScaleX(IDCompositionAnimation animation);
    HRESULT SetScaleY(float scaleY);
    HRESULT SetScaleY(IDCompositionAnimation animation);
    HRESULT SetScaleZ(float scaleZ);
    HRESULT SetScaleZ(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
    HRESULT SetCenterZ(float centerZ);
    HRESULT SetCenterZ(IDCompositionAnimation animation);
}

///Represents a 3D transformation that affects the rotation of a visual along an arbitrary axis in 3D space. The
///coordinate system is rotated around the specified center point.
@GUID("D8F5B23F-D429-4A91-B55A-D2F45FD75B18")
interface IDCompositionRotateTransform3D : IDCompositionTransform3D
{
    HRESULT SetAngle(float angle);
    HRESULT SetAngle(IDCompositionAnimation animation);
    HRESULT SetAxisX(float axisX);
    HRESULT SetAxisX(IDCompositionAnimation animation);
    HRESULT SetAxisY(float axisY);
    HRESULT SetAxisY(IDCompositionAnimation animation);
    HRESULT SetAxisZ(float axisZ);
    HRESULT SetAxisZ(IDCompositionAnimation animation);
    HRESULT SetCenterX(float centerX);
    HRESULT SetCenterX(IDCompositionAnimation animation);
    HRESULT SetCenterY(float centerY);
    HRESULT SetCenterY(IDCompositionAnimation animation);
    HRESULT SetCenterZ(float centerZ);
    HRESULT SetCenterZ(IDCompositionAnimation animation);
}

///Represents an arbitrary 3D transformation defined by a 4-by-4 matrix.
@GUID("4B3363F0-643B-41B7-B6E0-CCF22D34467C")
interface IDCompositionMatrixTransform3D : IDCompositionTransform3D
{
    ///Changes all values of the matrix of this 3D transformation effect.
    ///Params:
    ///    matrix = Type: <b>const D3DMATRIX</b> The new matrix for this 3D transformation effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetMatrix(const(D3DMATRIX)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
}

///Represents a clip object that is used to restrict the rendering of a visual subtree to a rectangular area.
@GUID("64AC3703-9D3F-45EC-A109-7CAC0E7A13A7")
interface IDCompositionClip : IUnknown
{
}

///Represents a clip object that restricts the rendering of a visual subtree to the specified rectangular region.
///Optionally, the clip object may have rounded corners specified.
@GUID("9842AD7D-D9CF-4908-AED7-48B51DA5E7C2")
interface IDCompositionRectangleClip : IDCompositionClip
{
    HRESULT SetLeft(float left);
    HRESULT SetLeft(IDCompositionAnimation animation);
    HRESULT SetTop(float top);
    HRESULT SetTop(IDCompositionAnimation animation);
    HRESULT SetRight(float right);
    HRESULT SetRight(IDCompositionAnimation animation);
    HRESULT SetBottom(float bottom);
    HRESULT SetBottom(IDCompositionAnimation animation);
    HRESULT SetTopLeftRadiusX(float radius);
    HRESULT SetTopLeftRadiusX(IDCompositionAnimation animation);
    HRESULT SetTopLeftRadiusY(float radius);
    HRESULT SetTopLeftRadiusY(IDCompositionAnimation animation);
    HRESULT SetTopRightRadiusX(float radius);
    HRESULT SetTopRightRadiusX(IDCompositionAnimation animation);
    HRESULT SetTopRightRadiusY(float radius);
    HRESULT SetTopRightRadiusY(IDCompositionAnimation animation);
    HRESULT SetBottomLeftRadiusX(float radius);
    HRESULT SetBottomLeftRadiusX(IDCompositionAnimation animation);
    HRESULT SetBottomLeftRadiusY(float radius);
    HRESULT SetBottomLeftRadiusY(IDCompositionAnimation animation);
    HRESULT SetBottomRightRadiusX(float radius);
    HRESULT SetBottomRightRadiusX(IDCompositionAnimation animation);
    HRESULT SetBottomRightRadiusY(float radius);
    HRESULT SetBottomRightRadiusY(IDCompositionAnimation animation);
}

///Represents a physical bitmap that can be associated with a visual for composition in a visual tree. This interface
///can also be used to update the bitmap contents.
@GUID("BB8A4953-2C99-4F5A-96F5-4819027FA3AC")
interface IDCompositionSurface : IUnknown
{
    ///Initiates drawing on this Microsoft DirectComposition surface object. The update rectangle must be within the
    ///boundaries of the surface; otherwise, this method fails.
    ///Params:
    ///    updateRect = Type: <b>const RECT*</b> The rectangle to be updated. If this parameter is NULL, the entire bitmap is
    ///                 updated.
    ///    iid = Type: <b>REFIID</b> The identifier of the interface to retrieve.
    ///    updateObject = Type: <b>void**</b> Receives an interface pointer of the type specified in the <i>iid</i> parameter. This
    ///                   parameter must not be NULL. <div class="alert"><b>Note</b> In Windows 8, this parameter was
    ///                   <i>surface</i>.</div> <div> </div>
    ///    updateOffset = Type: <b>POINT*</b> The offset into the surface where the application should draw updated content. This
    ///                   offset will reference the upper left corner of the update rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code.
    ///    
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* updateOffset);
    ///Marks the end of drawing on this Microsoft DirectComposition surface object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code, which can include DCOMPOSITION_ERROR_SURFACE_NOT_BEING_RENDERED.
    ///    
    HRESULT EndDraw();
    ///Suspends the drawing on this Microsoft DirectComposition surface object.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code, which can
    ///    include DCOMPOSITION_ERROR_SURFACE_BEING_RENDERED and DCOMPOSITION_ERROR_SURFACE_NOT_BEING_RENDERED.
    ///    
    HRESULT SuspendDraw();
    ///Resumes drawing on this Microsoft DirectComposition surface object.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code, which can
    ///    include DCOMPOSITION_ERROR_SURFACE_BEING_RENDERED and DCOMPOSITION_ERROR_SURFACE_NOT_BEING_RENDERED.
    ///    
    HRESULT ResumeDraw();
    ///Scrolls a rectangular area of a Microsoft DirectComposition logical surface.
    ///Params:
    ///    scrollRect = The rectangular area of the surface to be scrolled, relative to the upper-left corner of the surface. If this
    ///                 parameter is NULL, the entire surface is scrolled.
    ///    clipRect = The <i>clipRect</i> clips the destination (<i>scrollRect</i> after offset) of the scroll. The only bitmap
    ///               content that will be scrolled are those that remain inside the clip rectangle after the scroll is completed.
    ///    offsetX = The amount of horizontal scrolling, in pixels. Use positive values to scroll right, and negative values to
    ///              scroll left.
    ///    offsetY = The amount of vertical scrolling, in pixels. Use positive values to scroll down, and negative values to
    ///              scroll up.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT Scroll(const(RECT)* scrollRect, const(RECT)* clipRect, int offsetX, int offsetY);
}

///Represents a sparsely allocated bitmap that can be associated with a visual for composition in a visual tree.
@GUID("AE471C51-5F53-4A24-8D3E-D0C39C30B3F0")
interface IDCompositionVirtualSurface : IDCompositionSurface
{
    ///Changes the logical size of this virtual surface object.
    ///Params:
    ///    width = Type: <b>UINT</b> The new width of the virtual surface, in pixels. The maximum width is 16,777,216 pixels.
    ///    height = Type: <b>UINT</b> The new height of the virtual surface, in pixels. The maximum height is 16,777,216 pixels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT Resize(uint width, uint height);
    ///Discards pixels that fall outside of the specified trim rectangles.
    ///Params:
    ///    rectangles = Type: <b>const RECT*</b> An array of rectangles to keep.
    ///    count = Type: <b>UINT</b> The number of rectangles in the <i>rectangles</i> array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT Trim(const(RECT)* rectangles, uint count);
}

///Serves as a factory for all other Microsoft DirectComposition objects and provides methods to control transactional
///composition.
@GUID("75F6468D-1B8E-447C-9BC6-75FEA80B5B25")
interface IDCompositionDevice2 : IUnknown
{
    ///Commits all DirectComposition commands that are pending on this device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT Commit();
    ///Waits for the composition engine to finish processing the previous call to the IDCompositionDevice2::Commit
    ///method.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code. See DirectComposition
    ///    Error Codes for a list of error codes.
    ///    
    HRESULT WaitForCommitCompletion();
    ///Retrieves information from the composition engine about composition times and the frame rate.
    ///Params:
    ///    statistics = Type: <b>DCOMPOSITION_FRAME_STATISTICS*</b> A structure that receives composition times and frame rate
    ///                 information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
    ///Creates a new visual object.
    ///Params:
    ///    visual = Type: <b>IDCompositionVisual**</b> The new visual object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateVisual(IDCompositionVisual2* visual);
    ///Creates a Microsoft DirectComposition surface factory object, which can be used to create other DirectComposition
    ///surface or virtual surface objects
    ///Params:
    ///    renderingDevice = A pointer to a DirectX device to be used to create DirectComposition surface objects. Must be a pointer to an
    ///                      object implementing the IDXGIDevice or ID2D1Device interfaces. This parameter must not be NULL.
    ///    surfaceFactory = The newly created surface factory object. This parameter must not be NULL.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code. See DirectComposition
    ///    Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurfaceFactory(IUnknown renderingDevice, IDCompositionSurfaceFactory* surfaceFactory);
    ///Creates an updateable surface object that can be associated with one or more visuals for composition.
    ///Params:
    ///    width = Type: <b>UINT</b> The width of the surface, in pixels. Constrained by the feature level of the rendering
    ///            device that was passed in at the time the DirectComposition device was created.
    ///    height = Type: <b>UINT</b> The height of the surface, in pixels. Constrained by the feature level of the rendering
    ///             device that was passed in at the time the DirectComposition device was created.
    ///    pixelFormat = Type: <b>DXGI_FORMAT</b> The pixel format of the surface.
    ///    alphaMode = Type: <b>DXGI_ALPHA_MODE</b> The format of the alpha channel, if an alpha channel is included in the pixel
    ///                format. It can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                width="40%"><a id="DXGI_ALPHA_MODE_UNSPECIFIED"></a><a id="dxgi_alpha_mode_unspecified"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_UNSPECIFIED</b></dt> </dl> </td> <td width="60%"> The alpha channel is not specified.
    ///                This value has the same effect as <b>DXGI_ALPHA_MODE_IGNORE</b>. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_PREMULTIPLIED"></a><a id="dxgi_alpha_mode_premultiplied"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_PREMULTIPLIED</b></dt> </dl> </td> <td width="60%"> The color channels contain values
    ///                that are premultiplied with the alpha channel. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_IGNORE"></a><a id="dxgi_alpha_mode_ignore"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_IGNORE</b></dt> </dl> </td> <td width="60%"> The alpha channel should be ignored and
    ///                the bitmap should be rendered opaquely. </td> </tr> </table>
    ///    surface = Type: <b>IDCompositionSurface**</b> The newly created surface object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
    ///Creates a sparsely populated surface that can be associated with one or more visuals for composition.
    ///Params:
    ///    initialWidth = Type: <b>UINT</b> The width of the surface, in pixels. The maximum width is 16,777,216 pixels.
    ///    initialHeight = Type: <b>UINT</b> The height of the surface, in pixels. The maximum height is 16,777,216 pixels.
    ///    pixelFormat = Type: <b>DXGI_FORMAT</b> The pixel format of the surface.
    ///    alphaMode = Type: <b>DXGI_ALPHA_MODE</b> The meaning of the alpha channel, if the pixel format contains an alpha channel.
    ///                It can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                width="40%"><a id="DXGI_ALPHA_MODE_UNSPECIFIED"></a><a id="dxgi_alpha_mode_unspecified"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_UNSPECIFIED</b></dt> </dl> </td> <td width="60%"> The alpha channel is not specified.
    ///                This value has the same effect as <b>DXGI_ALPHA_MODE_IGNORE</b>. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_PREMULTIPLIED"></a><a id="dxgi_alpha_mode_premultiplied"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_PREMULTIPLIED</b></dt> </dl> </td> <td width="60%"> The color channels contain values
    ///                that are premultiplied with the alpha channel. </td> </tr> <tr> <td width="40%"><a
    ///                id="DXGI_ALPHA_MODE_IGNORE"></a><a id="dxgi_alpha_mode_ignore"></a><dl>
    ///                <dt><b>DXGI_ALPHA_MODE_IGNORE</b></dt> </dl> </td> <td width="60%"> The alpha channel should be ignored and
    ///                the bitmap should be rendered opaquely. </td> </tr> </table>
    ///    virtualSurface = Type: <b>IDCompositionVirtualSurface**</b> The newly created surface object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
    ///Creates a 2D translation transform object.
    ///Params:
    ///    translateTransform = Type: <b>IDCompositionTranslateTransform**</b> The new 2D translation transform object. This parameter must
    ///                         not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTranslateTransform(IDCompositionTranslateTransform* translateTransform);
    ///Creates a 2D scale transform object.
    ///Params:
    ///    scaleTransform = Type: <b>IDCompositionScaleTransform**</b> The new 2D scale transform object. This parameter must not be
    ///                     NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateScaleTransform(IDCompositionScaleTransform* scaleTransform);
    ///Creates a 2D rotation transform object.
    ///Params:
    ///    rotateTransform = Type: <b>IDCompositionRotateTransform**</b> The new rotation transform object. This parameter must not be
    ///                      NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateRotateTransform(IDCompositionRotateTransform* rotateTransform);
    ///Creates a 2D skew transform object.
    ///Params:
    ///    skewTransform = Type: <b>IDCompositionSkewTransform**</b> The new 2D skew transform object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSkewTransform(IDCompositionSkewTransform* skewTransform);
    ///Creates a 2D 3-by-2 matrix transform object.
    ///Params:
    ///    matrixTransform = Type: <b>IDCompositionMatrixTransform**</b> The new matrix transform object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateMatrixTransform(IDCompositionMatrixTransform* matrixTransform);
    ///Creates a 2D transform group object that holds an array of 2D transform objects.
    ///Params:
    ///    transforms = Type: <b>IDCompositionTransform**</b> An array of 2D transform objects that make up this transform group.
    ///    elements = Type: <b>UINT</b> The number of elements in the <i>transforms</i> array.
    ///    transformGroup = Type: <b>IDCompositionTransform**</b> The new transform group object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTransformGroup(IDCompositionTransform* transforms, uint elements, 
                                 IDCompositionTransform* transformGroup);
    ///Creates a 3D translation transform object.
    ///Params:
    ///    translateTransform3D = Type: <b>IDCompositionTranslateTransform3D**</b> The new 3D translation transform object. This parameter must
    ///                           not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTranslateTransform3D(IDCompositionTranslateTransform3D* translateTransform3D);
    ///Creates a 3D scale transform object.
    ///Params:
    ///    scaleTransform3D = Type: <b>IDCompositionScaleTransform3D**</b> The new 3D scale transform object. This parameter must not be
    ///                       NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateScaleTransform3D(IDCompositionScaleTransform3D* scaleTransform3D);
    ///Creates a 3D rotation transform object.
    ///Params:
    ///    rotateTransform3D = Type: <b>IDCompositionRotateTransform3D**</b> The new 3D rotation transform object. This parameter must not
    ///                        be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateRotateTransform3D(IDCompositionRotateTransform3D* rotateTransform3D);
    ///Creates a 3D 4-by-4 matrix transform object.
    ///Params:
    ///    matrixTransform3D = Type: <b>IDCompositionMatrixTransform3D**</b> The new 3D matrix transform object. This parameter must not be
    ///                        NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateMatrixTransform3D(IDCompositionMatrixTransform3D* matrixTransform3D);
    ///Creates a 3D transform group object that holds an array of 3D transform objects.
    ///Params:
    ///    transforms3D = Type: <b>IDCompositionTransform3D**</b> An array of 3D transform objects that make up this transform group.
    ///    elements = Type: <b>UINT</b> The number of elements in the <i>transforms</i> array.
    ///    transform3DGroup = Type: <b>IDCompositionTransform3D**</b> The new 3D transform group object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTransform3DGroup(IDCompositionTransform3D* transforms3D, uint elements, 
                                   IDCompositionTransform3D* transform3DGroup);
    ///Creates an object that represents multiple effects to be applied to a visual subtree.
    ///Params:
    ///    effectGroup = Type: <b>IDCompositionEffectGroup**</b> The new effect group object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateEffectGroup(IDCompositionEffectGroup* effectGroup);
    ///Creates a clip object that can be used to restrict the rendering of a visual subtree to a rectangular area.
    ///Params:
    ///    clip = Type: <b>IDCompositionRectangleClip**</b> The new clip object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateRectangleClip(IDCompositionRectangleClip* clip);
    ///Creates an animation object that is used to animate one or more scalar properties of one or more Microsoft
    ///DirectComposition objects.
    ///Params:
    ///    animation = Type: <b>IDCompositionAnimation**</b> The new animation object. This parameter must not be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error
    ///    code. See DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateAnimation(IDCompositionAnimation* animation);
}

///An application must use the IDCompositionDesktopDevice interface in order to use DirectComposition in a Win32 desktop
///application. This interface allows the application to connect a visual tree to a window and to host layered child
///windows for composition
@GUID("5F4633FE-1E08-4CB8-8C75-CE24333F5602")
interface IDCompositionDesktopDevice : IDCompositionDevice2
{
    ///Creates a composition target object that is bound to the window that is represented by the specified window
    ///handle.
    ///Params:
    ///    hwnd = The window to which the composition target object should be bound. This parameter must not be NULL.
    ///    topmost = TRUE if the visual tree should be displayed on top of the children of the window specified by the hwnd
    ///              parameter; otherwise, the visual tree is displayed behind the children.
    ///    target = The new composition target object. This parameter must not be NULL.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
    ///Creates a new composition surface object that wraps an existing composition surface.
    ///Params:
    ///    handle = The handle of an existing composition surface that was created by a call to the
    ///             DCompositionCreateSurfaceHandle function.
    ///    surface = The new composition surface object. This parameter must not be NULL.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurfaceFromHandle(HANDLE handle, IUnknown* surface);
    ///Creates a wrapper object that represents the rasterization of a layered window, and that can be associated with a
    ///visual for composition.
    ///Params:
    ///    hwnd = The handle of the layered window for which to create a wrapper. A layered window is created by specifying
    ///           WS_EX_LAYERED when creating the window with the CreateWindowEx function or by setting WS_EX_LAYERED via
    ///           SetWindowLong after the window has been created.
    ///    surface = The new composition surface object. This parameter must not be NULL.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurfaceFromHwnd(HWND hwnd, IUnknown* surface);
}

///Provides access to rendering features that help with application debugging and performance tuning. This interface can
///be queried from the DirectComposition device interface.
@GUID("A1A3C64A-224F-4A81-9773-4F03A89D3C6C")
interface IDCompositionDeviceDebug : IUnknown
{
    ///Enables display of performance debugging counters.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT EnableDebugCounters();
    ///Disables display of performance debugging counters.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT DisableDebugCounters();
}

///Creates surface and virtual surface objects associated with an application-provided rendering device.
@GUID("E334BC12-3937-4E02-85EB-FCF4EB30D2C8")
interface IDCompositionSurfaceFactory : IUnknown
{
    ///Creates a surface object that can be associated with one or more visuals for composition.
    ///Params:
    ///    width = The width of the surface, in pixels.
    ///    height = The height of the surface, in pixels.
    ///    pixelFormat = The pixel format of the surface.
    ///    alphaMode = The format of the alpha channel, if an alpha channel is included in the pixel format. This can be one of
    ///                DXGI_ALPHA_MODE_PREMULTIPLIED or DXGI_ALPHA_MODE_IGNORE. It can also be DXGI_ALPHA_MODE_UNSPECIFIED, which is
    ///                interpreted as DXGI_ALPHA_MODE_IGNORE.
    ///    surface = The newly created surface object. This parameter must not be NULL.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
    ///Creates a sparsely populated surface that can be associated with one or more visuals for composition.
    ///Params:
    ///    initialWidth = The width of the surface, in pixels. The maximum width is 16,777,216 pixels.
    ///    initialHeight = The height of the surface, in pixels. The maximum height is 16,777,216 pixels.
    ///    pixelFormat = The pixel format of the surface.
    ///    alphaMode = The format of the alpha channel, if an alpha channel is included in the pixel format. This can be one of
    ///                DXGI_ALPHA_MODE_PREMULTIPLIED or DXGI_ALPHA_MODE_IGNORE. It can also be DXGI_ALPHA_MODE_UNSPECIFIED, which is
    ///                interpreted as DXGI_ALPHA_MODE_IGNORE.
    ///    virtualSurface = The newly created virtual surface object. This parameter must not be NULL.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
}

///Represents one DirectComposition visual in a visual tree.
@GUID("E8DE1639-4331-4B26-BC5F-6A321D347A85")
interface IDCompositionVisual2 : IDCompositionVisual
{
    ///Sets the opacity mode for this visual.
    ///Params:
    ///    mode = The opacity mode to use when composing the visual to the screen.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetOpacityMode(DCOMPOSITION_OPACITY_MODE mode);
    ///Specifies whether or not surfaces that have 3D transformations applied to them should be displayed when facing
    ///away from the observer.
    ///Params:
    ///    visibility = [in] The back face visibility to use when composing surfaces in this visual’s sub-tree to the screen.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT SetBackFaceVisibility(DCOMPOSITION_BACKFACE_VISIBILITY visibility);
}

///Represents a debug visual.
@GUID("FED2B808-5EB4-43A0-AEA3-35F65280F91B")
interface IDCompositionVisualDebug : IDCompositionVisual2
{
    ///Enables a visual heatmap that represents overdraw regions.
    ///Params:
    ///    color = 
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT EnableHeatMap(const(DXGI_RGBA)* color);
    ///Disables visual heatmaps.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT DisableHeatMap();
    ///Enables highlighting visuals when content is being redrawn.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT EnableRedrawRegions();
    ///Disables visual redraw regions.
    ///Returns:
    ///    If the function succeeds, it returns S_OK. Otherwise, it returns an <b>HRESULT</b> error code. See
    ///    DirectComposition Error Codes for a list of error codes.
    ///    
    HRESULT DisableRedrawRegions();
}

///Represents one DirectComposition visual in a visual tree.
@GUID("2775F462-B6C1-4015-B0BE-B3E7D6A4976D")
interface IDCompositionVisual3 : IDCompositionVisualDebug
{
    ///Sets the depth mode property associated with this visual.
    ///Params:
    ///    mode = Type: <b>DCOMPOSITION_DEPTH_MODE</b> The new depth mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetDepthMode(DCOMPOSITION_DEPTH_MODE mode);
    HRESULT SetOffsetZ(float offsetZ);
    HRESULT SetOffsetZ(IDCompositionAnimation animation);
    HRESULT SetOpacity(float opacity);
    HRESULT SetOpacity(IDCompositionAnimation animation);
    HRESULT SetTransform(const(D2D_MATRIX_4X4_F)* matrix);
    HRESULT SetTransform(IDCompositionTransform3D transform);
    ///Changes the value of the visual's Visible property.
    ///Params:
    ///    visible = Type: <b>BOOL</b> The new value for the visible property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetVisible(BOOL visible);
}

///Serves as a factory for all other Microsoft DirectComposition objects and provides methods to control transactional
///composition.
@GUID("0987CB06-F916-48BF-8D35-CE7641781BD9")
interface IDCompositionDevice3 : IDCompositionDevice2
{
    ///Creates an instance of IDCompositionGaussianBlurEffect.
    ///Params:
    ///    gaussianBlurEffect = Type: <b>IDCompositionGaussianBlurEffect**</b> Receives the created instance of
    ///                         IDCompositionGaussianBlurEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateGaussianBlurEffect(IDCompositionGaussianBlurEffect* gaussianBlurEffect);
    ///Creates an instance of IDCompositionBrightnessEffect.
    ///Params:
    ///    brightnessEffect = Type: <b>IDCompositionBrightnessEffect**</b> Receives the created instance of IDCompositionBrightnessEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBrightnessEffect(IDCompositionBrightnessEffect* brightnessEffect);
    ///Creates an instance of IDCompositionColorMatrixEffect.
    ///Params:
    ///    colorMatrixEffect = Type: <b>IDCompositionColorMatrixEffect**</b> Receives the created instance of
    ///                        IDCompositionColorMatrixEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateColorMatrixEffect(IDCompositionColorMatrixEffect* colorMatrixEffect);
    ///Creates an instance of IDCompositionShadowEffect.
    ///Params:
    ///    shadowEffect = Type: <b>IDCompositionShadowEffect**</b> Receives the created instance of IDCompositionShadowEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateShadowEffect(IDCompositionShadowEffect* shadowEffect);
    ///Creates an instance of IDCompositionHueRotationEffect.
    ///Params:
    ///    hueRotationEffect = Type: <b>IDCompositionHueRotationEffect**</b> Receives the created instance of
    ///                        IDCompositionHueRotationEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateHueRotationEffect(IDCompositionHueRotationEffect* hueRotationEffect);
    ///Creates an instance of IDCompositionSaturationEffect.
    ///Params:
    ///    saturationEffect = Type: <b>IDCompositionSaturationEffect**</b> Receives the created instance of IDCompositionSaturationEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateSaturationEffect(IDCompositionSaturationEffect* saturationEffect);
    ///Creates an instance of IDCompositionTurbulenceEffect.
    ///Params:
    ///    turbulenceEffect = Type: <b>IDCompositionTurbulenceEffect**</b> Receives the created instance of IDCompositionTurbulenceEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTurbulenceEffect(IDCompositionTurbulenceEffect* turbulenceEffect);
    ///Creates an instance of IDCompositionLinearTransferEffect.
    ///Params:
    ///    linearTransferEffect = Type: <b>IDCompositionLinearTransferEffect**</b> Receives the created instance of
    ///                           IDCompositionLinearTransferEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateLinearTransferEffect(IDCompositionLinearTransferEffect* linearTransferEffect);
    ///Creates an instance of IDCompositionTableTransferEffect.
    ///Params:
    ///    tableTransferEffect = Type: <b>IDCompositionTableTransferEffect**</b> Receives the created instance of
    ///                          IDCompositionTableTransferEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTableTransferEffect(IDCompositionTableTransferEffect* tableTransferEffect);
    ///Creates an instance of IDCompositionCompositeEffect.
    ///Params:
    ///    compositeEffect = Type: <b>IDCompositionCompositeEffect**</b> Receives the created instance of IDCompositionCompositeEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCompositeEffect(IDCompositionCompositeEffect* compositeEffect);
    ///Creates an instance of IDCompositionBlendEffect.
    ///Params:
    ///    blendEffect = Type: <b>IDCompositionBlendEffect**</b> Receives the created instance of IDCompositionBlendEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBlendEffect(IDCompositionBlendEffect* blendEffect);
    ///Creates an instance of IDCompositionArithmeticCompositeEffect.
    ///Params:
    ///    arithmeticCompositeEffect = Type: <b>IDCompositionArithmeticCompositeEffect**</b> Receives the created instance of
    ///                                IDCompositionArithmeticCompositeEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateArithmeticCompositeEffect(IDCompositionArithmeticCompositeEffect* arithmeticCompositeEffect);
    ///Creates an instance of IDCompositionAffineTransform2DEffect.
    ///Params:
    ///    affineTransform2dEffect = Type: <b>IDCompositionAffineTransform2DEffect**</b> Recieves the created instance of
    ///                              IDCompositionAffineTransform2DEffect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateAffineTransform2DEffect(IDCompositionAffineTransform2DEffect* affineTransform2dEffect);
}

///Represents a filter effect. IDCompositionFilterEffect exposes a subset of Direct2D's image effects through
///DirectComposition for use in CSS filters in the browser platform.
@GUID("30C421D5-8CB2-4E9F-B133-37BE270D4AC2")
interface IDCompositionFilterEffect : IDCompositionEffect
{
    ///Sets the the input at an index to the specified filter effect.
    ///Params:
    ///    index = Type: <b>UINT</b> Specifies the index the to apply the filter effect at.
    ///    input = Type: <b>IUnknown*</b> The filter effect to apply. The following effects are available: <ul> <li>
    ///            IDCompositionAffineTransform2DEffect </li> <li> IDCompositionArithmeticCompositeEffect </li> <li>
    ///            IDCompositionBlendEffect </li> <li> IDCompositionBrightnessEffect </li> <li> IDCompositionColorNatrixEffect
    ///            </li> <li> IDCompositionCompositeEffect </li> <li> IDCompositionFloodEffect </li> <li>
    ///            IDCompositionGaussianBlurEffect </li> <li> IDCompositionHueRotationEffect </li> <li>
    ///            IDCompositionLinearTransferRffect </li> <li> IDCompositionSaturationRffect </li> <li>
    ///            IDCompositionShadowEffect </li> <li> IDCompositionTableTransferEffect </li> <li>
    ///            IDCompositionTurbulenceEffect </li> </ul>
    ///    flags = Type: <b>UINT</b> Flags to apply to the filter effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetInput(uint index, IUnknown input, uint flags);
}

///The Gaussian blur effect is used to blur an image by a Gaussian function, typically to reduce image noise and reduce
///detail.
@GUID("45D4D0B7-1BD4-454E-8894-2BFA68443033")
interface IDCompositionGaussianBlurEffect : IDCompositionFilterEffect
{
    HRESULT SetStandardDeviation(float amount);
    HRESULT SetStandardDeviation(IDCompositionAnimation animation);
    ///Sets the mode used to calculate the border of the image.
    ///Params:
    ///    mode = Type: <b>D2D1_BORDER_MODE</b> The mode used to calculate the border of the image.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetBorderMode(D2D1_BORDER_MODE mode);
}

///The brightness effect controls the brightness of the image.
@GUID("6027496E-CB3A-49AB-934F-D798DA4F7DA6")
interface IDCompositionBrightnessEffect : IDCompositionFilterEffect
{
    ///Sets the upper portion of the brightness transfer curve.
    ///Params:
    ///    whitePoint = Type: <b>const D2D1_VECTOR_2F</b> The upper portion of the brightness transfer curve. The white point adjusts
    ///                 the appearance of the brighter portions of the image. This vector is for both the x value and the y value, in
    ///                 that order. Each of the values must be between 0 and 1, inclusive.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetWhitePoint(const(D2D_VECTOR_2F)* whitePoint);
    ///Specifies the lower portion of the brightness transfer curve for the brightness effect.
    ///Params:
    ///    blackPoint = Type: <b>const D2D1_VECTOR_2F</b> The lower portion of the brightness transfer curve. The black point adjusts
    ///                 the appearance of the darker portions of the image. The vector is for both the x value and the y value, in
    ///                 that order. Each of the values must be between 0 and 1, inclusive.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetBlackPoint(const(D2D_VECTOR_2F)* blackPoint);
    HRESULT SetWhitePointX(float whitePointX);
    HRESULT SetWhitePointX(IDCompositionAnimation animation);
    HRESULT SetWhitePointY(float whitePointY);
    HRESULT SetWhitePointY(IDCompositionAnimation animation);
    HRESULT SetBlackPointX(float blackPointX);
    HRESULT SetBlackPointX(IDCompositionAnimation animation);
    HRESULT SetBlackPointY(float blackPointY);
    HRESULT SetBlackPointY(IDCompositionAnimation animation);
}

///The color matrix effect alters the RGBA values of a bitmap.
@GUID("C1170A22-3CE2-4966-90D4-55408BFC84C4")
interface IDCompositionColorMatrixEffect : IDCompositionFilterEffect
{
    ///Sets the matrix used by the effect to multiply the RGBA values of the image.
    ///Params:
    ///    matrix = Type: <b>const D2D1_MATRIX_5X4_F</b> The matrix used by the effect to multiply the RGBA values of the image.
    ///             The matrix is column major and is applied as shown in the following equation: <img alt="Matrix equation"
    ///             src="./images/color_matrix_formula.png"/>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetMatrix(const(D2D_MATRIX_5X4_F)* matrix);
    HRESULT SetMatrixElement(int row, int column, float value);
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
    ///Sets the alpha mode of the output for the color matrix effect.
    ///Params:
    ///    mode = Type: <b>D2D1_COLORMATRIX_ALPHA_MODE</b> The alpha mode of the output for the color matrix effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetAlphaMode(D2D1_COLORMATRIX_ALPHA_MODE mode);
    ///Specifies whether the effect clamps color values to between 0 and 1 before the effects passes the values to the
    ///next effect in the chain.
    ///Params:
    ///    clamp = Type: <b>BOOL</b> A boolean value indicating whether the effect clamps color values to between 0 and 1 before
    ///            the effects passes the values to the next effect in the chain.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetClampOutput(BOOL clamp);
}

///The shadow effect is used to generate a shadow from the alpha channel of an image. The shadow is more opaque for
///higher alpha values and more transparent for lower alpha values. You can set the amount of blur and the color of the
///shadow.
@GUID("4AD18AC0-CFD2-4C2F-BB62-96E54FDB6879")
interface IDCompositionShadowEffect : IDCompositionFilterEffect
{
    HRESULT SetStandardDeviation(float amount);
    HRESULT SetStandardDeviation(IDCompositionAnimation animation);
    ///Sets color of the shadow.
    ///Params:
    ///    color = Type: <b>const D2D1_VECTOR_4F</b> The color of the shadow.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetColor(const(D2D_VECTOR_4F)* color);
    HRESULT SetRed(float amount);
    HRESULT SetRed(IDCompositionAnimation animation);
    HRESULT SetGreen(float amount);
    HRESULT SetGreen(IDCompositionAnimation animation);
    HRESULT SetBlue(float amount);
    HRESULT SetBlue(IDCompositionAnimation animation);
    HRESULT SetAlpha(float amount);
    HRESULT SetAlpha(IDCompositionAnimation animation);
}

///The hue rotate effect alters the hue of an image by applying a color matrix based on the rotation angle.
@GUID("6DB9F920-0770-4781-B0C6-381912F9D167")
interface IDCompositionHueRotationEffect : IDCompositionFilterEffect
{
    HRESULT SetAngle(float amountDegrees);
    HRESULT SetAngle(IDCompositionAnimation animation);
}

///This effect is used to alter the saturation of an image. The saturation effect is a specialization of the color
///matrix effect.
@GUID("A08DEBDA-3258-4FA4-9F16-9174D3FE93B1")
interface IDCompositionSaturationEffect : IDCompositionFilterEffect
{
    HRESULT SetSaturation(float ratio);
    HRESULT SetSaturation(IDCompositionAnimation animation);
}

///The turbulence effect is used to generate a bitmap based on the Perlin noise function. The turbulence effect has no
///input image.
@GUID("A6A55BDA-C09C-49F3-9193-A41922C89715")
interface IDCompositionTurbulenceEffect : IDCompositionFilterEffect
{
    ///Sets the coordinates where the turbulence output is generated.
    ///Params:
    ///    offset = Type: <b>const D2D1_VECTOR_2F</b> The coordinates where the turbulence output is generated. The algorithm
    ///             used to generate the Perlin noise is position dependent, so a different offset results in a different output.
    ///             This value is not bounded and the units are specified in DIPs <div class="alert"><b>Note</b> Note The offset
    ///             does not have the same effect as a translation because the noise function output is infinite and the function
    ///             will wrap around the tile.</div> <div> </div>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOffset(const(D2D_VECTOR_2F)* offset);
    ///Sets the base frequencies in the X and Y direction.
    ///Params:
    ///    frequency = Type: <b>const D2D1_VECTOR_2F</b> The base frequencies in the X and Y direction. This must be greater than 0.
    ///                The units are specified in 1/DIPs. A value of 1 (1/DIPs) for the base frequency results in the Perlin noise
    ///                completing an entire cycle between two pixels. The ease interpolation for these pixels results in completely
    ///                random pixels, since there is no correlation between the pixels. A value of 0.1(1/DIPs) for the base
    ///                frequency results in the Perlin noise function repeating every 10 DIPs. This results in correlation between
    ///                pixels and the typical turbulence effect is visible.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetBaseFrequency(const(D2D_VECTOR_2F)* frequency);
    ///Sets the size of the turbulence output.
    ///Params:
    ///    size = Type: <b>const D2D1_VECTOR_2F</b> The size of the turbulence output
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSize(const(D2D_VECTOR_2F)* size);
    ///Sets the number of octaves for the noise function.
    ///Params:
    ///    numOctaves = Type: <b>UINT</b> The number of octaves for the noise function. This value must be greater than 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetNumOctaves(uint numOctaves);
    ///Sets the seed for the pseudo random generator.
    ///Params:
    ///    seed = Type: <b>UINT</b> The seed for the pseudo random generator. This value is unbounded.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSeed(uint seed);
    ///Sets the turbulence noise mode.
    ///Params:
    ///    noise = Type: <b>D2D1_TURBULENCE_NOISE</b> The turbulence noise mode. Indicates whether to generate a bitmap based on
    ///            Fractal Noise or the Turbulence function.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetNoise(D2D1_TURBULENCE_NOISE noise);
    ///Specifies whether stitching is on or off.
    ///Params:
    ///    stitchable = Type: <b>BOOL</b> A boolean value that specifies whether stitching is on or off. The base frequency is
    ///                 adjusted so that the output bitmap can be stitched. This is useful if you want to tile multiple copies of the
    ///                 turbulence effect output. If this value is TRUE, the output bitmap can be tiled (using the tile effect)
    ///                 without the appearance of seams and the base frequency is adjusted so that output bitmap can be stitched. If
    ///                 this value is FALSE, the base frequency is not adjusted, so seams may appear between tiles if the bitmap is
    ///                 tiled.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetStitchable(BOOL stitchable);
}

///The linear transfer effect is used to map the color intensities of an image using a linear function created from a
///list of values you provide for each channel.
@GUID("4305EE5B-C4A0-4C88-9385-67124E017683")
interface IDCompositionLinearTransferEffect : IDCompositionFilterEffect
{
    HRESULT SetRedYIntercept(float redYIntercept);
    HRESULT SetRedYIntercept(IDCompositionAnimation animation);
    HRESULT SetRedSlope(float redSlope);
    HRESULT SetRedSlope(IDCompositionAnimation animation);
    ///Specifies whether to apply the transfer function to the red channel.
    ///Params:
    ///    redDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the red channel.
    ///                 If you set this to TRUE the effect does not apply the transfer function to the red channel. If you set this
    ///                 to FALSE the effect applies the RedLinearTransfer function to the red channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetRedDisable(BOOL redDisable);
    HRESULT SetGreenYIntercept(float greenYIntercept);
    HRESULT SetGreenYIntercept(IDCompositionAnimation animation);
    HRESULT SetGreenSlope(float greenSlope);
    HRESULT SetGreenSlope(IDCompositionAnimation animation);
    ///Specifies whether to apply the transfer function to the green channel.
    ///Params:
    ///    greenDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the green channel.
    ///                   If you set this to TRUE the effect does not apply the transfer function to the green channel. If you set this
    ///                   to FALSE it applies the GreenLinearTransfer function to the green channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetGreenDisable(BOOL greenDisable);
    HRESULT SetBlueYIntercept(float blueYIntercept);
    HRESULT SetBlueYIntercept(IDCompositionAnimation animation);
    HRESULT SetBlueSlope(float blueSlope);
    HRESULT SetBlueSlope(IDCompositionAnimation animation);
    ///Specifies whether to apply the transfer function to the blue channel.
    ///Params:
    ///    blueDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the blue channel.
    ///                  If you set this to TRUE the effect does not apply the transfer function to the blue channel. If you set this
    ///                  to FALSE it applies the BlueLinearTransfer function to the blue channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetBlueDisable(BOOL blueDisable);
    HRESULT SetAlphaYIntercept(float alphaYIntercept);
    HRESULT SetAlphaYIntercept(IDCompositionAnimation animation);
    HRESULT SetAlphaSlope(float alphaSlope);
    HRESULT SetAlphaSlope(IDCompositionAnimation animation);
    ///Specifies whether to apply the transfer function to the alpha channel.
    ///Params:
    ///    alphaDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the alpha channel.
    ///                   If you set this to TRUE the effect does not apply the transfer function to the Alpha channel. If you set this
    ///                   to FALSE it applies the AlphaLinearTransfer function to the Alpha channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetAlphaDisable(BOOL alphaDisable);
    ///Specifies whether the effect clamps color values to between 0 and 1 before the effect passes the values to the
    ///next effect in the graph.
    ///Params:
    ///    clampOutput = Type: <b>BOOL</b> A boolean value that specifies whether the effect clamps color values to between 0 and 1
    ///                  before the effect passes the values to the next effect in the graph. If you set this to TRUE the effect will
    ///                  clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects and
    ///                  the output surface may clamp the values if they are not of high enough precision.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetClampOutput(BOOL clampOutput);
}

///The table transfer effect is used to map the color intensities of an image using a transfer function created from
///interpolating a list of values you provide.
@GUID("9B7E82E2-69C5-4EB4-A5F5-A7033F5132CD")
interface IDCompositionTableTransferEffect : IDCompositionFilterEffect
{
    ///Sets the list of values used to define the transfer function for the red channel.
    ///Params:
    ///    tableValues = Type: <b>const float*</b> The list of values used to define the transfer function for the red channel.
    ///    count = Type: <b>UINT</b> The number of values in the tableValues parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetRedTable(const(float)* tableValues, uint count);
    ///Sets the list of values used to define the transfer function for the green channel.
    ///Params:
    ///    tableValues = Type: <b>const float*</b> The list of values used to define the transfer function for the green channel.
    ///    count = Type: <b>UINT</b> The number of values in the tableValues parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetGreenTable(const(float)* tableValues, uint count);
    ///Sets the list of values used to define the transfer function for the blue channel.
    ///Params:
    ///    tableValues = Type: <b>const float*</b> The list of values used to define the transfer function for the blue channel.
    ///    count = Type: <b>UINT</b> The number of values in the tableValues parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetBlueTable(const(float)* tableValues, uint count);
    ///Sets the list of values used to define the transfer function for the alpha channel.
    ///Params:
    ///    tableValues = Type: <b>const float*</b> The list of values used to define the transfer function for the alpha channel.
    ///    count = Type: <b>UINT</b> The number of values in the tableValues parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetAlphaTable(const(float)* tableValues, uint count);
    ///Specifies whether to apply the transfer function to the red channel.
    ///Params:
    ///    redDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the red channel.
    ///                 If you set this to TRUE the effect does not apply the transfer function to the red channel. If you set this
    ///                 to FALSE it applies the RedTableTransfer function to the red channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetRedDisable(BOOL redDisable);
    ///Specifies whether to apply the transfer function to the green channel.
    ///Params:
    ///    greenDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the green channel.
    ///                   If you set this to TRUE the effect does not apply the transfer function to the green channel. If you set this
    ///                   to FALSE it applies the GreenTableTransfer function to the green channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetGreenDisable(BOOL greenDisable);
    ///Specifies whether to apply the transfer function to the blue channel.
    ///Params:
    ///    blueDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the blue channel.
    ///                  If you set this to TRUE the effect does not apply the transfer function to the blue channel. If you set this
    ///                  to FALSE it applies the BlueTableTransfer function to the Blue channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetBlueDisable(BOOL blueDisable);
    ///Specifies whether to apply the transfer function to the Alpha channel.
    ///Params:
    ///    alphaDisable = Type: <b>BOOL</b> A boolean value that specifies whether to apply the transfer function to the alpha channel.
    ///                   If you set this to TRUE the effect does not apply the transfer function to the Alpha channel. If you set this
    ///                   to FALSE it applies the AlphaTableTransfer function to the Alpha channel.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetAlphaDisable(BOOL alphaDisable);
    ///Specifies whether the effect clamps color values to between 0 and 1 before the effect passes the values to the
    ///next effect in the graph.
    ///Params:
    ///    clampOutput = Type: <b>BOOL</b> A boolean value that specifies whether the effect clamps color values to between 0 and 1
    ///                  before the effect passes the values to the next effect in the graph. If you set this to TRUE the effect will
    ///                  clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects and
    ///                  the output surface may clamp the values if they are not of high enough precision. The effect clamps the
    ///                  values before it premultiplies the alpha.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetClampOutput(BOOL clampOutput);
    HRESULT SetRedTableValue(uint index, float value);
    HRESULT SetRedTableValue(uint index, IDCompositionAnimation animation);
    HRESULT SetGreenTableValue(uint index, float value);
    HRESULT SetGreenTableValue(uint index, IDCompositionAnimation animation);
    HRESULT SetBlueTableValue(uint index, float value);
    HRESULT SetBlueTableValue(uint index, IDCompositionAnimation animation);
    HRESULT SetAlphaTableValue(uint index, float value);
    HRESULT SetAlphaTableValue(uint index, IDCompositionAnimation animation);
}

///The composite effect is used to combine 2 or more images. This effect has 13 different composite modes. The composite
///effect accepts 2 or more inputs. When you specify 2 images, destination is the first input (index 0) and the source
///is the second input (index 1). If you specify more than 2 inputs, the images are composited starting with the first
///input and the second and so on.
@GUID("576616C0-A231-494D-A38D-00FD5EC4DB46")
interface IDCompositionCompositeEffect : IDCompositionFilterEffect
{
    ///Sets the mode for the composite effect.
    ///Params:
    ///    mode = Type: <b>D2D1_COMPOSITE_MODE</b> The mode for the composite effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetMode(D2D1_COMPOSITE_MODE mode);
}

///The Blend Effect is used to combine 2 images.
@GUID("33ECDC0A-578A-4A11-9C14-0CB90517F9C5")
interface IDCompositionBlendEffect : IDCompositionFilterEffect
{
    ///Sets the blend mode to use when the blend effect combines the two images.
    ///Params:
    ///    mode = Type: <b>D2D1_BLEND_MODE</b> The blend mode to use when the blend effect combines the two images.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetMode(D2D1_BLEND_MODE mode);
}

///The arithmetic composite effect is used to combine 2 images using a weighted sum of pixels from the input images.
@GUID("3B67DFA8-E3DD-4E61-B640-46C2F3D739DC")
interface IDCompositionArithmeticCompositeEffect : IDCompositionFilterEffect
{
    ///Sets the coefficients for the equation used to composite the two input images.
    ///Params:
    ///    coefficients = Type: <b>const D2D1_VECTOR_4F</b> The coefficients for the equation used to composite the two input images.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCoefficients(const(D2D_VECTOR_4F)* coefficients);
    ///Specifies whether to clamp color values before the effect passes the values to the next effect in the graph.
    ///Params:
    ///    clampoutput = Type: <b>BOOL</b> A boolean value indicating whether to clamp the color values. A value of TRUE causes color
    ///                  values to be clamped between 0 and 1.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetClampOutput(BOOL clampoutput);
    HRESULT SetCoefficient1(float Coeffcient1);
    HRESULT SetCoefficient1(IDCompositionAnimation animation);
    HRESULT SetCoefficient2(float Coefficient2);
    HRESULT SetCoefficient2(IDCompositionAnimation animation);
    HRESULT SetCoefficient3(float Coefficient3);
    HRESULT SetCoefficient3(IDCompositionAnimation animation);
    HRESULT SetCoefficient4(float Coefficient4);
    HRESULT SetCoefficient4(IDCompositionAnimation animation);
}

///The arithmetic composite effect is used to combine 2 images using a weighted sum of pixels from the input images.
@GUID("0B74B9E8-CDD6-492F-BBBC-5ED32157026D")
interface IDCompositionAffineTransform2DEffect : IDCompositionFilterEffect
{
    ///Sets the interpolation mode of the effect.
    ///Params:
    ///    interpolationMode = Type: <b>D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE</b> Specifies the interpolation mode of the effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetInterpolationMode(D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE interpolationMode);
    ///Sets the border mode to use with the effect.
    ///Params:
    ///    borderMode = Type: <b>D2D1_BORDER_MODE</b> Specifies the border mode to use with the effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetBorderMode(D2D1_BORDER_MODE borderMode);
    ///Sets the transform matrix of the effect.
    ///Params:
    ///    transformMatrix = Type: <b>const D2D1_MATRIX_3X2_F</b> Specifies the transform matrix for the effect to use.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTransformMatrix(const(D2D_MATRIX_3X2_F)* transformMatrix);
    HRESULT SetTransformMatrixElement(int row, int column, float value);
    HRESULT SetTransformMatrixElement(int row, int column, IDCompositionAnimation animation);
    HRESULT SetSharpness(float sharpness);
    HRESULT SetSharpness(IDCompositionAnimation animation);
}


// GUIDs


const GUID IID_IDCompositionAffineTransform2DEffect   = GUIDOF!IDCompositionAffineTransform2DEffect;
const GUID IID_IDCompositionAnimation                 = GUIDOF!IDCompositionAnimation;
const GUID IID_IDCompositionArithmeticCompositeEffect = GUIDOF!IDCompositionArithmeticCompositeEffect;
const GUID IID_IDCompositionBlendEffect               = GUIDOF!IDCompositionBlendEffect;
const GUID IID_IDCompositionBrightnessEffect          = GUIDOF!IDCompositionBrightnessEffect;
const GUID IID_IDCompositionClip                      = GUIDOF!IDCompositionClip;
const GUID IID_IDCompositionColorMatrixEffect         = GUIDOF!IDCompositionColorMatrixEffect;
const GUID IID_IDCompositionCompositeEffect           = GUIDOF!IDCompositionCompositeEffect;
const GUID IID_IDCompositionDesktopDevice             = GUIDOF!IDCompositionDesktopDevice;
const GUID IID_IDCompositionDevice                    = GUIDOF!IDCompositionDevice;
const GUID IID_IDCompositionDevice2                   = GUIDOF!IDCompositionDevice2;
const GUID IID_IDCompositionDevice3                   = GUIDOF!IDCompositionDevice3;
const GUID IID_IDCompositionDeviceDebug               = GUIDOF!IDCompositionDeviceDebug;
const GUID IID_IDCompositionEffect                    = GUIDOF!IDCompositionEffect;
const GUID IID_IDCompositionEffectGroup               = GUIDOF!IDCompositionEffectGroup;
const GUID IID_IDCompositionFilterEffect              = GUIDOF!IDCompositionFilterEffect;
const GUID IID_IDCompositionGaussianBlurEffect        = GUIDOF!IDCompositionGaussianBlurEffect;
const GUID IID_IDCompositionHueRotationEffect         = GUIDOF!IDCompositionHueRotationEffect;
const GUID IID_IDCompositionLinearTransferEffect      = GUIDOF!IDCompositionLinearTransferEffect;
const GUID IID_IDCompositionMatrixTransform           = GUIDOF!IDCompositionMatrixTransform;
const GUID IID_IDCompositionMatrixTransform3D         = GUIDOF!IDCompositionMatrixTransform3D;
const GUID IID_IDCompositionRectangleClip             = GUIDOF!IDCompositionRectangleClip;
const GUID IID_IDCompositionRotateTransform           = GUIDOF!IDCompositionRotateTransform;
const GUID IID_IDCompositionRotateTransform3D         = GUIDOF!IDCompositionRotateTransform3D;
const GUID IID_IDCompositionSaturationEffect          = GUIDOF!IDCompositionSaturationEffect;
const GUID IID_IDCompositionScaleTransform            = GUIDOF!IDCompositionScaleTransform;
const GUID IID_IDCompositionScaleTransform3D          = GUIDOF!IDCompositionScaleTransform3D;
const GUID IID_IDCompositionShadowEffect              = GUIDOF!IDCompositionShadowEffect;
const GUID IID_IDCompositionSkewTransform             = GUIDOF!IDCompositionSkewTransform;
const GUID IID_IDCompositionSurface                   = GUIDOF!IDCompositionSurface;
const GUID IID_IDCompositionSurfaceFactory            = GUIDOF!IDCompositionSurfaceFactory;
const GUID IID_IDCompositionTableTransferEffect       = GUIDOF!IDCompositionTableTransferEffect;
const GUID IID_IDCompositionTarget                    = GUIDOF!IDCompositionTarget;
const GUID IID_IDCompositionTransform                 = GUIDOF!IDCompositionTransform;
const GUID IID_IDCompositionTransform3D               = GUIDOF!IDCompositionTransform3D;
const GUID IID_IDCompositionTranslateTransform        = GUIDOF!IDCompositionTranslateTransform;
const GUID IID_IDCompositionTranslateTransform3D      = GUIDOF!IDCompositionTranslateTransform3D;
const GUID IID_IDCompositionTurbulenceEffect          = GUIDOF!IDCompositionTurbulenceEffect;
const GUID IID_IDCompositionVirtualSurface            = GUIDOF!IDCompositionVirtualSurface;
const GUID IID_IDCompositionVisual                    = GUIDOF!IDCompositionVisual;
const GUID IID_IDCompositionVisual2                   = GUIDOF!IDCompositionVisual2;
const GUID IID_IDCompositionVisual3                   = GUIDOF!IDCompositionVisual3;
const GUID IID_IDCompositionVisualDebug               = GUIDOF!IDCompositionVisualDebug;
