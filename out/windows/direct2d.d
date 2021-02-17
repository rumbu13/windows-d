// Written in the D programming language.

module windows.direct2d;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct3d11 : D3D_FEATURE_LEVEL;
public import windows.direct3d9 : D3DADAPTER_IDENTIFIER9, D3DBACKBUFFER_TYPE, D3DBOX,
                                  D3DCLIPSTATUS9, D3DCOMPOSERECTSOP,
                                  D3DCUBEMAP_FACES, D3DDEVICE_CREATION_PARAMETERS,
                                  D3DDEVTYPE, D3DDISPLAYMODE, D3DDISPLAYMODEEX,
                                  D3DDISPLAYMODEFILTER, D3DDISPLAYROTATION,
                                  D3DFORMAT, D3DGAMMARAMP, D3DINDEXBUFFER_DESC,
                                  D3DLIGHT9, D3DLOCKED_BOX, D3DLOCKED_RECT,
                                  D3DMATERIAL9, D3DMATRIX, D3DMULTISAMPLE_TYPE,
                                  D3DPOOL, D3DPRESENTSTATS, D3DQUERYTYPE,
                                  D3DRASTER_STATUS, D3DRECTPATCH_INFO,
                                  D3DRESOURCETYPE, D3DSAMPLERSTATETYPE,
                                  D3DSURFACE_DESC, D3DTEXTUREFILTERTYPE,
                                  D3DTRIPATCH_INFO, D3DVERTEXBUFFER_DESC,
                                  D3DVERTEXELEMENT9, D3DVIEWPORT9, D3DVOLUME_DESC,
                                  _D3DPRESENT_PARAMETERS_;
public import windows.directwrite : DWRITE_GLYPH_IMAGE_FORMATS, DWRITE_GLYPH_RUN,
                                    DWRITE_GLYPH_RUN_DESCRIPTION, DWRITE_MEASURING_MODE,
                                    IDWriteFontFace, IDWriteRenderingParams,
                                    IDWriteTextFormat, IDWriteTextLayout;
public import windows.displaydevices : POINT, RECT;
public import windows.dxgi : DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT, DXGI_RGBA, IDXGIDevice,
                             IDXGISurface;
public import windows.gdi : HDC, RGNDATA;
public import windows.kernel : LUID;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, D3DPRIMITIVETYPE, D3DRECT, D3DRENDERSTATETYPE,
                                       D3DSTATEBLOCKTYPE, D3DTEXTURESTAGESTATETYPE,
                                       D3DTRANSFORMSTATETYPE, HANDLE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsimagingcomponent : IWICBitmap, IWICBitmapSource, IWICColorContext,
                                                IWICImagingFactory;
public import windows.xps : IPrintDocumentPackageTarget;

extern(Windows):


// Enums


///Specifies how the alpha value of a bitmap or render target should be treated.
alias D2D1_ALPHA_MODE = uint;
enum : uint
{
    ///The alpha value might not be meaningful.
    D2D1_ALPHA_MODE_UNKNOWN       = 0x00000000,
    ///The alpha value has been premultiplied. Each color is first scaled by the alpha value. The alpha value itself is
    ///the same in both straight and premultiplied alpha. Typically, no color channel value is greater than the alpha
    ///channel value. If a color channel value in a premultiplied format is greater than the alpha channel, the standard
    ///source-over blending math results in an additive blend.
    D2D1_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    ///The alpha value has not been premultiplied. The alpha channel indicates the transparency of the color.
    D2D1_ALPHA_MODE_STRAIGHT      = 0x00000002,
    ///The alpha value is ignored.
    D2D1_ALPHA_MODE_IGNORE        = 0x00000003,
    D2D1_ALPHA_MODE_FORCE_DWORD   = 0xffffffff,
}

alias D2D1_INTERPOLATION_MODE_DEFINITION = int;
enum : int
{
    D2D1_INTERPOLATION_MODE_DEFINITION_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_INTERPOLATION_MODE_DEFINITION_LINEAR              = 0x00000001,
    D2D1_INTERPOLATION_MODE_DEFINITION_CUBIC               = 0x00000002,
    D2D1_INTERPOLATION_MODE_DEFINITION_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_INTERPOLATION_MODE_DEFINITION_ANISOTROPIC         = 0x00000004,
    D2D1_INTERPOLATION_MODE_DEFINITION_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_INTERPOLATION_MODE_DEFINITION_FANT                = 0x00000006,
    D2D1_INTERPOLATION_MODE_DEFINITION_MIPMAP_LINEAR       = 0x00000007,
}

///Specifies which gamma is used for interpolation.
alias D2D1_GAMMA = uint;
enum : uint
{
    ///Interpolation is performed in the standard RGB (sRGB) gamma.
    D2D1_GAMMA_2_2         = 0x00000000,
    ///Interpolation is performed in the linear-gamma color space.
    D2D1_GAMMA_1_0         = 0x00000001,
    D2D1_GAMMA_FORCE_DWORD = 0xffffffff,
}

///Describes whether an opacity mask contains graphics or text. Direct2D uses this information to determine which gamma
///space to use when blending the opacity mask.
alias D2D1_OPACITY_MASK_CONTENT = uint;
enum : uint
{
    ///The opacity mask contains graphics. The opacity mask is blended in the gamma 2.2 color space.
    D2D1_OPACITY_MASK_CONTENT_GRAPHICS            = 0x00000000,
    ///The opacity mask contains non-GDI text. The gamma space used for blending is obtained from the render target's
    ///text rendering parameters. (ID2D1RenderTarget::SetTextRenderingParams).
    D2D1_OPACITY_MASK_CONTENT_TEXT_NATURAL        = 0x00000001,
    ///The opacity mask contains text rendered using the GDI-compatible rendering mode. The opacity mask is blended
    ///using the gamma for GDI rendering.
    D2D1_OPACITY_MASK_CONTENT_TEXT_GDI_COMPATIBLE = 0x00000002,
    D2D1_OPACITY_MASK_CONTENT_FORCE_DWORD         = 0xffffffff,
}

///Specifies how a brush paints areas outside of its normal content area.
alias D2D1_EXTEND_MODE = uint;
enum : uint
{
    ///Repeat the edge pixels of the brush's content for all regions outside the normal content area.
    D2D1_EXTEND_MODE_CLAMP       = 0x00000000,
    ///Repeat the brush's content.
    D2D1_EXTEND_MODE_WRAP        = 0x00000001,
    ///The same as D2D1_EXTEND_MODE_WRAP, except that alternate tiles of the brush's content are flipped. (The brush's
    ///normal content is drawn untransformed.)
    D2D1_EXTEND_MODE_MIRROR      = 0x00000002,
    D2D1_EXTEND_MODE_FORCE_DWORD = 0xffffffff,
}

///Specifies how the edges of nontext primitives are rendered.
alias D2D1_ANTIALIAS_MODE = uint;
enum : uint
{
    ///Edges are antialiased using the Direct2D per-primitive method of high-quality antialiasing.
    D2D1_ANTIALIAS_MODE_PER_PRIMITIVE = 0x00000000,
    ///Objects are aliased in most cases. Objects are antialiased only when they are drawn to a render target created by
    ///the CreateDxgiSurfaceRenderTarget method and Direct3D multisampling has been enabled on the backing DirectX
    ///Graphics Infrastructure (DXGI) surface.
    D2D1_ANTIALIAS_MODE_ALIASED       = 0x00000001,
    D2D1_ANTIALIAS_MODE_FORCE_DWORD   = 0xffffffff,
}

///Describes the antialiasing mode used for drawing text.
alias D2D1_TEXT_ANTIALIAS_MODE = uint;
enum : uint
{
    ///Use the system default. See Remarks.
    D2D1_TEXT_ANTIALIAS_MODE_DEFAULT     = 0x00000000,
    ///Use ClearType antialiasing.
    D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE   = 0x00000001,
    ///Use grayscale antialiasing.
    D2D1_TEXT_ANTIALIAS_MODE_GRAYSCALE   = 0x00000002,
    ///Do not use antialiasing.
    D2D1_TEXT_ANTIALIAS_MODE_ALIASED     = 0x00000003,
    D2D1_TEXT_ANTIALIAS_MODE_FORCE_DWORD = 0xffffffff,
}

///Specifies the algorithm that is used when images are scaled or rotated. <div class="alert"><b>Note</b> Starting in
///Windows 8, more interpolations modes are available. See D2D1_INTERPOLATION_MODE for more info.</div><div> </div>
alias D2D1_BITMAP_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Use the exact color of the nearest bitmap pixel to the current rendering pixel.
    D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    ///Interpolate a color from the four bitmap pixels that are the nearest to the rendering pixel.
    D2D1_BITMAP_INTERPOLATION_MODE_LINEAR           = 0x00000001,
    D2D1_BITMAP_INTERPOLATION_MODE_FORCE_DWORD      = 0xffffffff,
}

///Specifies whether text snapping is suppressed or clipping to the layout rectangle is enabled. This enumeration allows
///a bitwise combination of its member values.
alias D2D1_DRAW_TEXT_OPTIONS = uint;
enum : uint
{
    ///Text is not vertically snapped to pixel boundaries. This setting is recommended for text that is being animated.
    D2D1_DRAW_TEXT_OPTIONS_NO_SNAP                       = 0x00000001,
    ///Text is clipped to the layout rectangle.
    D2D1_DRAW_TEXT_OPTIONS_CLIP                          = 0x00000002,
    ///In Windows 8.1 and later, text is rendered using color versions of glyphs, if defined by the font.
    D2D1_DRAW_TEXT_OPTIONS_ENABLE_COLOR_FONT             = 0x00000004,
    ///Bitmap origins of color glyph bitmaps are not snapped.
    D2D1_DRAW_TEXT_OPTIONS_DISABLE_COLOR_BITMAP_SNAPPING = 0x00000008,
    ///Text is vertically snapped to pixel boundaries and is not clipped to the layout rectangle.
    D2D1_DRAW_TEXT_OPTIONS_NONE                          = 0x00000000,
    D2D1_DRAW_TEXT_OPTIONS_FORCE_DWORD                   = 0xffffffff,
}

///Specifies whether an arc should be greater than 180 degrees.
alias D2D1_ARC_SIZE = uint;
enum : uint
{
    ///An arc's sweep should be 180 degrees or less.
    D2D1_ARC_SIZE_SMALL       = 0x00000000,
    ///An arc's sweep should be 180 degrees or greater.
    D2D1_ARC_SIZE_LARGE       = 0x00000001,
    D2D1_ARC_SIZE_FORCE_DWORD = 0xffffffff,
}

///Describes the shape at the end of a line or segment.
alias D2D1_CAP_STYLE = uint;
enum : uint
{
    ///A cap that does not extend past the last point of the line. Comparable to cap used for objects other than lines.
    D2D1_CAP_STYLE_FLAT        = 0x00000000,
    ///Half of a square that has a length equal to the line thickness.
    D2D1_CAP_STYLE_SQUARE      = 0x00000001,
    ///A semicircle that has a diameter equal to the line thickness.
    D2D1_CAP_STYLE_ROUND       = 0x00000002,
    ///An isosceles right triangle whose hypotenuse is equal in length to the thickness of the line.
    D2D1_CAP_STYLE_TRIANGLE    = 0x00000003,
    D2D1_CAP_STYLE_FORCE_DWORD = 0xffffffff,
}

///Describes the sequence of dashes and gaps in a stroke.
alias D2D1_DASH_STYLE = uint;
enum : uint
{
    ///A solid line with no breaks.
    D2D1_DASH_STYLE_SOLID        = 0x00000000,
    ///A dash followed by a gap of equal length. The dash and the gap are each twice as long as the stroke thickness.
    ///The equivalent dash array for <b>D2D1_DASH_STYLE_DASH</b> is {2, 2}.
    D2D1_DASH_STYLE_DASH         = 0x00000001,
    ///A dot followed by a longer gap. The equivalent dash array for <b>D2D1_DASH_STYLE_DOT</b> is {0, 2}.
    D2D1_DASH_STYLE_DOT          = 0x00000002,
    ///A dash, followed by a gap, followed by a dot, followed by another gap. The equivalent dash array for
    ///<b>D2D1_DASH_STYLE_DASH_DOT</b> is {2, 2, 0, 2}.
    D2D1_DASH_STYLE_DASH_DOT     = 0x00000003,
    ///A dash, followed by a gap, followed by a dot, followed by another gap, followed by another dot, followed by
    ///another gap. The equivalent dash array for <b>D2D1_DASH_STYLE_DASH_DOT_DOT</b> is {2, 2, 0, 2, 0, 2}.
    D2D1_DASH_STYLE_DASH_DOT_DOT = 0x00000004,
    ///The dash pattern is specified by an array of floating-point values.
    D2D1_DASH_STYLE_CUSTOM       = 0x00000005,
    D2D1_DASH_STYLE_FORCE_DWORD  = 0xffffffff,
}

///Describes the shape that joins two lines or segments.
alias D2D1_LINE_JOIN = uint;
enum : uint
{
    ///Regular angular vertices.
    D2D1_LINE_JOIN_MITER          = 0x00000000,
    ///Beveled vertices.
    D2D1_LINE_JOIN_BEVEL          = 0x00000001,
    ///Rounded vertices.
    D2D1_LINE_JOIN_ROUND          = 0x00000002,
    ///Regular angular vertices unless the join would extend beyond the miter limit; otherwise, beveled vertices.
    D2D1_LINE_JOIN_MITER_OR_BEVEL = 0x00000003,
    D2D1_LINE_JOIN_FORCE_DWORD    = 0xffffffff,
}

///Specifies the different methods by which two geometries can be combined.
alias D2D1_COMBINE_MODE = uint;
enum : uint
{
    ///The two regions are combined by taking the union of both. Given two geometries, <i>A</i> and <i>B</i>, the
    ///resulting geometry is geometry <i>A</i> + geometry <i>B</i>.
    D2D1_COMBINE_MODE_UNION       = 0x00000000,
    ///The two regions are combined by taking their intersection. The new area consists of the overlapping region
    ///between the two geometries.
    D2D1_COMBINE_MODE_INTERSECT   = 0x00000001,
    ///The two regions are combined by taking the area that exists in the first region but not the second and the area
    ///that exists in the second region but not the first. Given two geometries, <i>A</i> and <i>B</i>, the new region
    ///consists of (<i>A</i>-<i>B</i>) + (<i>B</i>-<i>A</i>).
    D2D1_COMBINE_MODE_XOR         = 0x00000002,
    ///The second region is excluded from the first. Given two geometries, <i>A</i> and <i>B</i>, the area of geometry
    ///<i>B</i> is removed from the area of geometry <i>A</i>, producing a region that is <i>A</i>-<i>B</i>.
    D2D1_COMBINE_MODE_EXCLUDE     = 0x00000003,
    D2D1_COMBINE_MODE_FORCE_DWORD = 0xffffffff,
}

///Describes how one geometry object is spatially related to another geometry object.
alias D2D1_GEOMETRY_RELATION = uint;
enum : uint
{
    ///The relationship between the two geometries cannot be determined. This value is never returned by any D2D method.
    D2D1_GEOMETRY_RELATION_UNKNOWN      = 0x00000000,
    ///The two geometries do not intersect at all.
    D2D1_GEOMETRY_RELATION_DISJOINT     = 0x00000001,
    ///The instance geometry is entirely contained by the passed-in geometry.
    D2D1_GEOMETRY_RELATION_IS_CONTAINED = 0x00000002,
    ///The instance geometry entirely contains the passed-in geometry.
    D2D1_GEOMETRY_RELATION_CONTAINS     = 0x00000003,
    ///The two geometries overlap but neither completely contains the other.
    D2D1_GEOMETRY_RELATION_OVERLAP      = 0x00000004,
    D2D1_GEOMETRY_RELATION_FORCE_DWORD  = 0xffffffff,
}

///Specifies how a geometry is simplified to an ID2D1SimplifiedGeometrySink.
alias D2D1_GEOMETRY_SIMPLIFICATION_OPTION = uint;
enum : uint
{
    ///The output can contain cubic Bezier curves and line segments.
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES = 0x00000000,
    ///The output is flattened so that it contains only line segments.
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_LINES            = 0x00000001,
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_FORCE_DWORD      = 0xffffffff,
}

///Indicates whether a specific ID2D1SimplifiedGeometrySink figure is filled or hollow.
alias D2D1_FIGURE_BEGIN = uint;
enum : uint
{
    ///Indicates the figure will be filled by the FillGeometry (ID2D1CommandSink::FillGeometry or
    ///ID2D1RenderTarget::FillGeometry) method.
    D2D1_FIGURE_BEGIN_FILLED      = 0x00000000,
    ///Indicates the figure will not be filled by the FillGeometry (ID2D1CommandSink::FillGeometry or
    ///ID2D1RenderTarget::FillGeometry) method and will only consist of an outline. Moreover, the bounds of a hollow
    ///figure are zero. D2D1_FIGURE_BEGIN_HOLLOW should be used for stroking, or for other geometry operations.
    D2D1_FIGURE_BEGIN_HOLLOW      = 0x00000001,
    D2D1_FIGURE_BEGIN_FORCE_DWORD = 0xffffffff,
}

///Indicates whether a specific ID2D1SimplifiedGeometrySink figure is open or closed.
alias D2D1_FIGURE_END = uint;
enum : uint
{
    ///The figure is open.
    D2D1_FIGURE_END_OPEN        = 0x00000000,
    ///The figure is closed.
    D2D1_FIGURE_END_CLOSED      = 0x00000001,
    D2D1_FIGURE_END_FORCE_DWORD = 0xffffffff,
}

///Indicates whether a segment should be stroked and whether the join between this segment and the previous one should
///be smooth. This enumeration allows a bitwise combination of its member values.
alias D2D1_PATH_SEGMENT = uint;
enum : uint
{
    ///The segment is joined as specified by the ID2D1StrokeStyle interface, and it is stroked.
    D2D1_PATH_SEGMENT_NONE                  = 0x00000000,
    ///The segment is not stroked.
    D2D1_PATH_SEGMENT_FORCE_UNSTROKED       = 0x00000001,
    ///The segment is always joined with the one preceding it using a round line join, regardless of which
    ///D2D1_LINE_JOINenumeration is specified by the ID2D1StrokeStyle interface. If this segment is the first segment
    ///and the figure is closed, a round line join is used to connect the closing segment with the first segment. If the
    ///figure is not closed, this setting has no effect on the first segment of the figure. If
    ///ID2D1SimplifiedGeometrySink::SetSegmentFlags is called just before ID2D1SimplifiedGeometrySink::EndFigure, the
    ///join between the closing segment and the last explicitly specified segment is affected.
    D2D1_PATH_SEGMENT_FORCE_ROUND_LINE_JOIN = 0x00000002,
    D2D1_PATH_SEGMENT_FORCE_DWORD           = 0xffffffff,
}

///Defines the direction that an elliptical arc is drawn.
alias D2D1_SWEEP_DIRECTION = uint;
enum : uint
{
    ///Arcs are drawn in a counterclockwise (negative-angle) direction.
    D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE = 0x00000000,
    ///Arcs are drawn in a clockwise (positive-angle) direction.
    D2D1_SWEEP_DIRECTION_CLOCKWISE         = 0x00000001,
    D2D1_SWEEP_DIRECTION_FORCE_DWORD       = 0xffffffff,
}

///Specifies how the intersecting areas of geometries or figures are combined to form the area of the composite
///geometry.
alias D2D1_FILL_MODE = uint;
enum : uint
{
    ///Determines whether a point is in the fill region by drawing a ray from that point to infinity in any direction,
    ///and then counting the number of path segments within the given shape that the ray crosses. If this number is odd,
    ///the point is in the fill region; if even, the point is outside the fill region.
    D2D1_FILL_MODE_ALTERNATE   = 0x00000000,
    ///Determines whether a point is in the fill region of the path by drawing a ray from that point to infinity in any
    ///direction, and then examining the places where a segment of the shape crosses the ray. Starting with a count of
    ///zero, add one each time a segment crosses the ray from left to right and subtract one each time a path segment
    ///crosses the ray from right to left, as long as left and right are seen from the perspective of the ray. After
    ///counting the crossings, if the result is zero, then the point is outside the path. Otherwise, it is inside the
    ///path.
    D2D1_FILL_MODE_WINDING     = 0x00000001,
    D2D1_FILL_MODE_FORCE_DWORD = 0xffffffff,
}

///Specifies options that can be applied when a layer resource is applied to create a layer. <div
///class="alert"><b>Note</b> Starting in Windows 8, the <b>D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE</b> option is no
///longer supported. See D2D1_LAYER_OPTIONS1 for Windows 8 layer options.</div><div> </div>
alias D2D1_LAYER_OPTIONS = uint;
enum : uint
{
    ///The text in this layer does not use ClearType antialiasing.
    D2D1_LAYER_OPTIONS_NONE                     = 0x00000000,
    ///The layer renders correctly for ClearType text. If the render target is set to ClearType, the layer continues to
    ///render ClearType. If the render target is set to ClearType and this option is not specified, the render target
    ///will be set to render gray-scale until the layer is popped. The caller can override this default by calling
    ///SetTextAntialiasMode while within the layer. This flag is slightly slower than the default.
    D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE = 0x00000001,
    D2D1_LAYER_OPTIONS_FORCE_DWORD              = 0xffffffff,
}

///Describes whether a window is occluded.
alias D2D1_WINDOW_STATE = uint;
enum : uint
{
    ///The window is not occluded.
    D2D1_WINDOW_STATE_NONE        = 0x00000000,
    ///The window is occluded.
    D2D1_WINDOW_STATE_OCCLUDED    = 0x00000001,
    D2D1_WINDOW_STATE_FORCE_DWORD = 0xffffffff,
}

///Describes whether a render target uses hardware or software rendering, or if Direct2D should select the rendering
///mode.
alias D2D1_RENDER_TARGET_TYPE = uint;
enum : uint
{
    ///The render target uses hardware rendering, if available; otherwise, it uses software rendering.
    D2D1_RENDER_TARGET_TYPE_DEFAULT     = 0x00000000,
    ///The render target uses software rendering only.
    D2D1_RENDER_TARGET_TYPE_SOFTWARE    = 0x00000001,
    ///The render target uses hardware rendering only.
    D2D1_RENDER_TARGET_TYPE_HARDWARE    = 0x00000002,
    D2D1_RENDER_TARGET_TYPE_FORCE_DWORD = 0xffffffff,
}

///Describes the minimum DirectX support required for hardware rendering by a render target.
alias D2D1_FEATURE_LEVEL = uint;
enum : uint
{
    ///Direct2D determines whether the video card provides adequate hardware rendering support.
    D2D1_FEATURE_LEVEL_DEFAULT     = 0x00000000,
    ///The video card must support DirectX 9.
    D2D1_FEATURE_LEVEL_9           = 0x00009100,
    ///The video card must support DirectX 10.
    D2D1_FEATURE_LEVEL_10          = 0x0000a000,
    D2D1_FEATURE_LEVEL_FORCE_DWORD = 0xffffffff,
}

///Describes how a render target is remoted and whether it should be GDI-compatible. This enumeration allows a bitwise
///combination of its member values.
alias D2D1_RENDER_TARGET_USAGE = uint;
enum : uint
{
    ///The render target attempts to use Direct3D command-stream remoting and uses bitmap remoting if stream remoting
    ///fails. The render target is not GDI-compatible.
    D2D1_RENDER_TARGET_USAGE_NONE                  = 0x00000000,
    ///The render target renders content locally and sends it to the terminal services client as a bitmap.
    D2D1_RENDER_TARGET_USAGE_FORCE_BITMAP_REMOTING = 0x00000001,
    ///The render target can be used efficiently with GDI.
    D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE        = 0x00000002,
    D2D1_RENDER_TARGET_USAGE_FORCE_DWORD           = 0xffffffff,
}

///Describes how a render target behaves when it presents its content. This enumeration allows a bitwise combination of
///its member values.
alias D2D1_PRESENT_OPTIONS = uint;
enum : uint
{
    ///The render target waits until the display refreshes to present and discards the frame upon presenting.
    D2D1_PRESENT_OPTIONS_NONE            = 0x00000000,
    ///The render target does not discard the frame upon presenting.
    D2D1_PRESENT_OPTIONS_RETAIN_CONTENTS = 0x00000001,
    ///The render target does not wait until the display refreshes to present.
    D2D1_PRESENT_OPTIONS_IMMEDIATELY     = 0x00000002,
    D2D1_PRESENT_OPTIONS_FORCE_DWORD     = 0xffffffff,
}

///Specifies additional features supportable by a compatible render target when it is created. This enumeration allows a
///bitwise combination of its member values.
alias D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS = uint;
enum : uint
{
    ///The render target supports no additional features.
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE           = 0x00000000,
    ///The render target supports interoperability with the Windows Graphics Device Interface (GDI).
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_GDI_COMPATIBLE = 0x00000001,
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_FORCE_DWORD    = 0xffffffff,
}

///Specifies how a device context is initialized for GDI rendering when it is retrieved from the render target.
alias D2D1_DC_INITIALIZE_MODE = uint;
enum : uint
{
    ///The current contents of the render target are copied to the device context when it is initialized.
    D2D1_DC_INITIALIZE_MODE_COPY        = 0x00000000,
    ///The device context is cleared to transparent black when it is initialized.
    D2D1_DC_INITIALIZE_MODE_CLEAR       = 0x00000001,
    D2D1_DC_INITIALIZE_MODE_FORCE_DWORD = 0xffffffff,
}

///Indicates the type of information provided by the Direct2D Debug Layer.
alias D2D1_DEBUG_LEVEL = uint;
enum : uint
{
    ///Direct2D does not produce any debugging output.
    D2D1_DEBUG_LEVEL_NONE        = 0x00000000,
    ///Direct2D sends error messages to the debug layer.
    D2D1_DEBUG_LEVEL_ERROR       = 0x00000001,
    ///Direct2D sends error messages and warnings to the debug layer.
    D2D1_DEBUG_LEVEL_WARNING     = 0x00000002,
    ///Direct2D sends error messages, warnings, and additional diagnostic information that can help improve performance
    ///to the debug layer.
    D2D1_DEBUG_LEVEL_INFORMATION = 0x00000003,
    D2D1_DEBUG_LEVEL_FORCE_DWORD = 0xffffffff,
}

///Specifies whether Direct2D provides synchronization for an ID2D1Factory and the resources it creates, so that they
///may be safely accessed from multiple threads.
alias D2D1_FACTORY_TYPE = uint;
enum : uint
{
    ///No synchronization is provided for accessing or writing to the factory or the objects it creates. If the factory
    ///or the objects are called from multiple threads, it is up to the application to provide access locking.
    D2D1_FACTORY_TYPE_SINGLE_THREADED = 0x00000000,
    ///Direct2D provides synchronization for accessing and writing to the factory and the objects it creates, enabling
    ///safe access from multiple threads.
    D2D1_FACTORY_TYPE_MULTI_THREADED  = 0x00000001,
    D2D1_FACTORY_TYPE_FORCE_DWORD     = 0xffffffff,
}

///Specifies how the Crop effect handles the crop rectangle falling on fractional pixel coordinates.
alias D2D1_BORDER_MODE = uint;
enum : uint
{
    ///If the crop rectangle falls on fractional pixel coordinates, the effect applies antialiasing which results in a
    ///soft edge.
    D2D1_BORDER_MODE_SOFT        = 0x00000000,
    ///If the crop rectangle falls on fractional pixel coordinates, the effect clamps which results in a hard edge.
    D2D1_BORDER_MODE_HARD        = 0x00000001,
    D2D1_BORDER_MODE_FORCE_DWORD = 0xffffffff,
}

///Specifies the color channel the Displacement map effectextracts the intensity from and uses it to spatially displace
///the image in the X or Y direction.
alias D2D1_CHANNEL_SELECTOR = uint;
enum : uint
{
    ///The effect extracts the intensity output from the red channel.
    D2D1_CHANNEL_SELECTOR_R           = 0x00000000,
    ///The effect extracts the intensity output from the green channel.
    D2D1_CHANNEL_SELECTOR_G           = 0x00000001,
    ///The effect extracts the intensity output from the blue channel.
    D2D1_CHANNEL_SELECTOR_B           = 0x00000002,
    ///The effect extracts the intensity output from the alpha channel.
    D2D1_CHANNEL_SELECTOR_A           = 0x00000003,
    D2D1_CHANNEL_SELECTOR_FORCE_DWORD = 0xffffffff,
}

///Speficies whether a flip and/or rotation operation should be performed by the Bitmap source effect
alias D2D1_BITMAPSOURCE_ORIENTATION = uint;
enum : uint
{
    ///The effect doesn't change the orientation of the input.
    D2D1_BITMAPSOURCE_ORIENTATION_DEFAULT                             = 0x00000001,
    ///Flips the image horizontally.
    D2D1_BITMAPSOURCE_ORIENTATION_FLIP_HORIZONTAL                     = 0x00000002,
    ///Rotates the image clockwise 180 degrees.
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180                 = 0x00000003,
    ///Rotates the image clockwise 180 degrees and flips it horizontally.
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL = 0x00000004,
    ///Rotates the image clockwise 270 degrees and flips it horizontally.
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL = 0x00000005,
    ///Rotates the image clockwise 90 degrees.
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90                  = 0x00000006,
    ///Rotates the image clockwise 90 degrees and flips it horizontally.
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL  = 0x00000007,
    ///Rotates the image clockwise 270 degrees.
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270                 = 0x00000008,
    D2D1_BITMAPSOURCE_ORIENTATION_FORCE_DWORD                         = 0xffffffff,
}

///Identifiers for properties of the Gaussian blur effect.
alias D2D1_GAUSSIANBLUR_PROP = uint;
enum : uint
{
    ///The amount of blur to be applied to the image. You can compute the blur radius of the kernel by multiplying the
    ///standard deviation by 3. The units of both the standard deviation and blur radius are DIPs. A value of zero DIPs
    ///disables this effect entirely. The type is FLOAT. The default value is 3.0f.
    D2D1_GAUSSIANBLUR_PROP_STANDARD_DEVIATION = 0x00000000,
    ///The optimization mode. The type is D2D1_GAUSSIANBLUR_OPTIMIZATION. The default value is
    ///D2D1_GAUSSIANBLUR_OPTIMIZATION_BALANCED.
    D2D1_GAUSSIANBLUR_PROP_OPTIMIZATION       = 0x00000001,
    ///The mode used to calculate the border of the image, soft or hard. The type is D2D1_GAUSSIANBLUR_OPTIMIZATION. The
    ///default value is D2D1_BORDER_MODE_SOFT.
    D2D1_GAUSSIANBLUR_PROP_BORDER_MODE        = 0x00000002,
    D2D1_GAUSSIANBLUR_PROP_FORCE_DWORD        = 0xffffffff,
}

///The optimization mode for the Gaussian blur effect.
alias D2D1_GAUSSIANBLUR_OPTIMIZATION = uint;
enum : uint
{
    ///Applies internal optimizations such as pre-scaling at relatively small radii. Uses linear filtering.
    D2D1_GAUSSIANBLUR_OPTIMIZATION_SPEED       = 0x00000000,
    ///Uses the same optimization thresholds as Speed mode, but uses trilinear filtering.
    D2D1_GAUSSIANBLUR_OPTIMIZATION_BALANCED    = 0x00000001,
    ///Only uses internal optimizations with large blur radii, where approximations are less likely to be visible. Uses
    ///trilinear filtering.
    D2D1_GAUSSIANBLUR_OPTIMIZATION_QUALITY     = 0x00000002,
    D2D1_GAUSSIANBLUR_OPTIMIZATION_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Directional blur effect.
alias D2D1_DIRECTIONALBLUR_PROP = uint;
enum : uint
{
    ///The amount of blur to be applied to the image. You can compute the blur radius of the kernel by multiplying the
    ///standard deviation by 3. The units of both the standard deviation and blur radius are DIPs. A value of 0 DIPs
    ///disables this effect. The type is FLOAT. The default value is 3.0f.
    D2D1_DIRECTIONALBLUR_PROP_STANDARD_DEVIATION = 0x00000000,
    ///The angle of the blur relative to the x-axis, in the counterclockwise direction. The units are specified in
    ///degrees. The blur kernel is first generated using the same process as for the Gaussian blur effect. The kernel
    ///values are then transformed according to the blur angle. The type is FLOAT. The default value is 0.0f.
    D2D1_DIRECTIONALBLUR_PROP_ANGLE              = 0x00000001,
    ///The optimization mode. See Optimization modes for more info. The type is D2D1_DIRECTIONALBLUR_OPTIMIZATION. The
    ///default value is D2D1_DIRECTIONALBLUR_OPTIMIZATION_BALANCED.
    D2D1_DIRECTIONALBLUR_PROP_OPTIMIZATION       = 0x00000002,
    ///The mode used to calculate the border of the image, soft or hard. See Border modes for more info. The type is
    ///D2D1_BORDER_MODE. The default value is D2D1_BORDER_MODE_SOFT.
    D2D1_DIRECTIONALBLUR_PROP_BORDER_MODE        = 0x00000003,
    D2D1_DIRECTIONALBLUR_PROP_FORCE_DWORD        = 0xffffffff,
}

///Specifies the optimization mode for the Directional blur effect.
alias D2D1_DIRECTIONALBLUR_OPTIMIZATION = uint;
enum : uint
{
    ///Applies internal optimizations such as pre-scaling at relatively small radii. Uses linear filtering.
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_SPEED       = 0x00000000,
    ///Uses the same optimization thresholds as Speed mode, but uses trilinear filtering.
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_BALANCED    = 0x00000001,
    ///Only uses internal optimizations with large blur radii, where approximations are less likely to be visible. Uses
    ///trilinear filtering.
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_QUALITY     = 0x00000002,
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Shadow effect.
alias D2D1_SHADOW_PROP = uint;
enum : uint
{
    ///The amount of blur to be applied to the alpha channel of the image. You can compute the blur radius of the kernel
    ///by multiplying the standard deviation by 3. The units of both the standard deviation and blur radius are DIPs.
    ///This property is the same as the Gaussian Blur standard deviation property. The type is FLOAT. The default value
    ///is 3.0f.
    D2D1_SHADOW_PROP_BLUR_STANDARD_DEVIATION = 0x00000000,
    ///The color of the drop shadow. This property is a D2D1_VECTOR_4F defined as: (R, G, B, A). You must specify this
    ///color in straight alpha. The type is D2D1_VECTOR_4F. The default value is {0.0f, 0.0f, 0.0f, 1.0f}.
    D2D1_SHADOW_PROP_COLOR                   = 0x00000001,
    ///The level of performance optimization. The type is D2D1_SHADOW_OPTIMIZATION. The default value is
    ///D2D1_SHADOW_OPTIMIZATION_BALANCED.
    D2D1_SHADOW_PROP_OPTIMIZATION            = 0x00000002,
    D2D1_SHADOW_PROP_FORCE_DWORD             = 0xffffffff,
}

///The level of performance optimization for the Shadow effect.
alias D2D1_SHADOW_OPTIMIZATION = uint;
enum : uint
{
    ///Applies internal optimizations such as pre-scaling at relatively small radii. Uses linear filtering.
    D2D1_SHADOW_OPTIMIZATION_SPEED       = 0x00000000,
    ///Uses the same optimization thresholds as Speed mode, but uses trilinear filtering.
    D2D1_SHADOW_OPTIMIZATION_BALANCED    = 0x00000001,
    ///Only uses internal optimizations with large blur radii, where approximations are less likely to be visible. Uses
    ///trilinear filtering.
    D2D1_SHADOW_OPTIMIZATION_QUALITY     = 0x00000002,
    D2D1_SHADOW_OPTIMIZATION_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Blend effect.
alias D2D1_BLEND_PROP = uint;
enum : uint
{
    ///The blend mode used for the effect. The type is D2D1_BLEND_MODE. The default value is D2D1_BLEND_MODE_MULTIPLY.
    D2D1_BLEND_PROP_MODE        = 0x00000000,
    D2D1_BLEND_PROP_FORCE_DWORD = 0xffffffff,
}

///The blend mode used for the Blend effect.
alias D2D1_BLEND_MODE = uint;
enum : uint
{
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a mutiply effect."
    ///src="./images/blend_mode_multiply_1.png"/>
    D2D1_BLEND_MODE_MULTIPLY      = 0x00000000,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a screen effect."
    ///src="./images/blend_mode_screen_1.png"/>
    D2D1_BLEND_MODE_SCREEN        = 0x00000001,
    ///Basic blend formula for alpha only. <img alt="mathematical formula for a darken effect."
    ///src="./images/blend_mode_darken_1.png"/>
    D2D1_BLEND_MODE_DARKEN        = 0x00000002,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a lighten effect."
    ///src="./images/blend_mode_lighten_1.png"/>
    D2D1_BLEND_MODE_LIGHTEN       = 0x00000003,
    ///Given: <ul> <li>A scene coordinate XY for the current pixel</li> <li>A deterministic pseudo-random number
    ///generator rand(XY) based on seed coordinate XY, with unbiased distribution of values from [0, 1]</li> </ul> <img
    ///alt="Mathematical formula for a dissolve blend effect." src="./images/blend_mode_dissolve_1.png"/>
    D2D1_BLEND_MODE_DISSOLVE      = 0x00000004,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a coor
    ///burn effect." src="./images/blend_mode_colorburn_1.png"/>
    D2D1_BLEND_MODE_COLOR_BURN    = 0x00000005,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a
    ///linear burn effect." src="./images/blend_mode_linearburn_1.png"/>
    D2D1_BLEND_MODE_LINEAR_BURN   = 0x00000006,
    ///Basic blend formula for alpha only. <img alt="Mathematical formla for a darken color effect."
    ///src="./images/blend_mode_darkencolor_1.png"/>
    D2D1_BLEND_MODE_DARKER_COLOR  = 0x00000007,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a lighter color effect."
    ///src="./images/blend_mode_lightercolor_1.png"/>
    D2D1_BLEND_MODE_LIGHTER_COLOR = 0x00000008,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a color
    ///dodge effect." src="./images/blend_mode_colordodge_1.png"/>
    D2D1_BLEND_MODE_COLOR_DODGE   = 0x00000009,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a
    ///linear dodge effect." src="./images/blend_mode_lineardodge_1.png"/>
    D2D1_BLEND_MODE_LINEAR_DODGE  = 0x0000000a,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for an
    ///overlay effect." src="./images/blend_mode_overlay_1.png"/>
    D2D1_BLEND_MODE_OVERLAY       = 0x0000000b,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a soft
    ///light effect." src="./images/blend_mode_softlight_1.png"/>
    D2D1_BLEND_MODE_SOFT_LIGHT    = 0x0000000c,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a hard
    ///light effect." src="./images/blend_mode_hardlight_1.png"/>
    D2D1_BLEND_MODE_HARD_LIGHT    = 0x0000000d,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a vivid
    ///light effect." src="./images/blend_mode_vividlight_1.png"/>
    D2D1_BLEND_MODE_VIVID_LIGHT   = 0x0000000e,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a
    ///linear light effect." src="./images/blend_mode_linearlight_1.png"/>
    D2D1_BLEND_MODE_LINEAR_LIGHT  = 0x0000000f,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a pin
    ///light effect." src="./images/blend_mode_pinlight_1.png"/>
    D2D1_BLEND_MODE_PIN_LIGHT     = 0x00000010,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = <img alt="Mathematical formula for a hard
    ///mix effect." src="./images/blend_mode_hardmix_1.png"/>
    D2D1_BLEND_MODE_HARD_MIX      = 0x00000011,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = abs(F<sub>RGB</sub> - B<sub>RGB</sub>)
    D2D1_BLEND_MODE_DIFFERENCE    = 0x00000012,
    ///Basic blend formulas with <i>f</i>(F<sub>RGB</sub>, B<sub>RGB</sub>) = F<sub>RGB</sub> + B<sub>RGB</sub> – 2 *
    ///F<sub>RGB</sub> * B<sub>RGB</sub>
    D2D1_BLEND_MODE_EXCLUSION     = 0x00000013,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a hue blend effect."
    ///src="./images/blend_mode_hue_1.png"/>
    D2D1_BLEND_MODE_HUE           = 0x00000014,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a sturation blend effect."
    ///src="./images/blend_mode_saturation_1.png"/>
    D2D1_BLEND_MODE_SATURATION    = 0x00000015,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a color blend effect."
    ///src="./images/blend_mode_color_1.png"/>
    D2D1_BLEND_MODE_COLOR         = 0x00000016,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a luminosity blend effect."
    ///src="./images/blend_mode_luminosity_1.png"/>
    D2D1_BLEND_MODE_LUMINOSITY    = 0x00000017,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a subtract blend effect."
    ///src="./images/blend_mode_subtract_1.png"/>
    D2D1_BLEND_MODE_SUBTRACT      = 0x00000018,
    ///Basic blend formula for alpha only. <img alt="Mathematical formula for a division blend effect."
    ///src="./images/blend_mode_division_1.png"/>
    D2D1_BLEND_MODE_DIVISION      = 0x00000019,
    D2D1_BLEND_MODE_FORCE_DWORD   = 0xffffffff,
}

///Identifiers for properties of the Saturation effect.
alias D2D1_SATURATION_PROP = uint;
enum : uint
{
    ///The saturation of the image. You can set the saturation to a value between 0 and 1. If you set it to 1 the output
    ///image is fully saturated. If you set it to 0 the output image is monochrome. The saturation value is unitless.
    ///The type is FLOAT. The default is 0.5f.
    D2D1_SATURATION_PROP_SATURATION  = 0x00000000,
    D2D1_SATURATION_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Hue rotate effect.
alias D2D1_HUEROTATION_PROP = uint;
enum : uint
{
    ///The angle to rotate the hue, in degrees. The type is FLOAT. The default is 0.0f.
    D2D1_HUEROTATION_PROP_ANGLE       = 0x00000000,
    D2D1_HUEROTATION_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for the properties of the Color matrix effect.
alias D2D1_COLORMATRIX_PROP = uint;
enum : uint
{
    ///A 5x4 matrix of float values. The elements in the matrix are not bounded and are unitless. The type is
    ///D2D1_MATRIX_5X4_F. The default value is the identity matrix, Matrix5x4F(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0,
    ///0, 1, 0, 0, 0, 0).
    D2D1_COLORMATRIX_PROP_COLOR_MATRIX = 0x00000000,
    ///The alpha mode of the output. The type is D2D1_COLORMATRIX_ALPHA_MODE. The default value is
    ///D2D1_COLORMATRIX_ALPHA_MODE_PREMULTIPLIED.
    D2D1_COLORMATRIX_PROP_ALPHA_MODE   = 0x00000001,
    ///Whether the effect clamps color values to between 0 and 1 before the effect passes the values to the next effect
    ///in the graph. The effect clamps the values before it premultiplies the alpha. If you set this to TRUE the effect
    ///will clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects
    ///and the output surface may clamp the values if they are not of high enough precision. The type is BOOL. The
    ///default value is FALSE.
    D2D1_COLORMATRIX_PROP_CLAMP_OUTPUT = 0x00000002,
    D2D1_COLORMATRIX_PROP_FORCE_DWORD  = 0xffffffff,
}

///The alpha mode of the output of the Color matrix effect.
alias D2D1_COLORMATRIX_ALPHA_MODE = uint;
enum : uint
{
    ///The effect un-premultiplies the input, applies the color matrix, and premultiplies the output.
    D2D1_COLORMATRIX_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    ///The effect applies the color matrix directly to the input, and doesn't premultiply the output.
    D2D1_COLORMATRIX_ALPHA_MODE_STRAIGHT      = 0x00000002,
    D2D1_COLORMATRIX_ALPHA_MODE_FORCE_DWORD   = 0xffffffff,
}

///Identifiers for properties of the Bitmap source effect.
alias D2D1_BITMAPSOURCE_PROP = uint;
enum : uint
{
    ///The IWICBitmapSource containing the image data to be loaded. The type is IWICBitmapSource. The default value is
    ///NULL.
    D2D1_BITMAPSOURCE_PROP_WIC_BITMAP_SOURCE     = 0x00000000,
    ///The scale amount in the X and Y direction. The effect multiplies the width by the X value and the height by the Y
    ///value. This property is a D2D1_VECTOR_2F defined as: (X scale, Y scale). The scale amounts are FLOAT, unitless,
    ///and must be positive or 0. The type is D2D1_VECTOR_2F. The default value is {1.0f, 1.0f}.
    D2D1_BITMAPSOURCE_PROP_SCALE                 = 0x00000001,
    ///The interpolation mode used to scale the image. If the mode disables the mipmap, then BitmapSouce will cache the
    ///image at the resolution determined by the Scale and EnableDPICorrection properties. The type is
    ///D2D1_BITMAPSOURCE_INTERPOLATION_MODE. The default value is D2D1_BITMAPSOURCE_INTERPOLATION_MODE_LINEAR.
    D2D1_BITMAPSOURCE_PROP_INTERPOLATION_MODE    = 0x00000002,
    ///If you set this to TRUE, the effect will scale the input image to convert the DPI reported by IWICBitmapSource to
    ///the DPI of the device context. The effect uses the interpolation mode you set with the InterpolationMode
    ///property. If you set this to FALSE, the effect uses a DPI of 96.0 for the output image. The type is BOOL. The
    ///default value is FALSE.
    D2D1_BITMAPSOURCE_PROP_ENABLE_DPI_CORRECTION = 0x00000003,
    ///The alpha mode of the output. This can be either premultiplied or straight. The type is
    ///D2D1_BITMAPSOURCE_ALPHA_MODE. The default value is D2D1_BITMAPSOURCE_ALPHA_MODE_PREMULTIPLIED.
    D2D1_BITMAPSOURCE_PROP_ALPHA_MODE            = 0x00000004,
    ///A flip and/or rotation operation to be performed on the image. The type is D2D1_BITMAPSOURCE_ORIENTATION. The
    ///default value is D2D1_BITMAPSOURCE_ORIENTATION_DEFAULT.
    D2D1_BITMAPSOURCE_PROP_ORIENTATION           = 0x00000005,
    D2D1_BITMAPSOURCE_PROP_FORCE_DWORD           = 0xffffffff,
}

///The interpolation mode used to scale the image in the Bitmap source effect.If the mode disables the mipmap, then
///BitmapSouce will cache the image at the resolution determined by the Scale and EnableDPICorrection properties.
alias D2D1_BITMAPSOURCE_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. Doesn't generate a mipmap.
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    ///Uses a four point sample and linear interpolation. Doesn't generate a mipmap.
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_LINEAR           = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. Doesn't generate a mipmap.
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_CUBIC            = 0x00000002,
    ///Uses the WIC fant interpolation, the same as the IWICBitmapScaler interface. Doesn't generate a mipmap.
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_FANT             = 0x00000006,
    ///Generates mipmap chain in system memory using bilinear interpolation. For each mipmap the effect scales to the
    ///nearest multiple of 0.5 using bilinear interpolation and then scales the remaining amount using linear
    ///interpolation.
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_MIPMAP_LINEAR    = 0x00000007,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_FORCE_DWORD      = 0xffffffff,
}

///Specifies the alpha mode of the output of the Bitmap source effect.
alias D2D1_BITMAPSOURCE_ALPHA_MODE = uint;
enum : uint
{
    ///The effect output uses premultiplied alpha.
    D2D1_BITMAPSOURCE_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    ///The effect output uses straight alpha.
    D2D1_BITMAPSOURCE_ALPHA_MODE_STRAIGHT      = 0x00000002,
    D2D1_BITMAPSOURCE_ALPHA_MODE_FORCE_DWORD   = 0xffffffff,
}

///Identifiers for properties of the Composite effect.
alias D2D1_COMPOSITE_PROP = uint;
enum : uint
{
    ///The mode used for the effect. Type is D2D1_COMPOSITE_MODE. Default value is D2D1_COMPOSITE_MODE_SOURCE_OVER
    D2D1_COMPOSITE_PROP_MODE        = 0x00000000,
    D2D1_COMPOSITE_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the 3D transform effect.
alias D2D1_3DTRANSFORM_PROP = uint;
enum : uint
{
    ///The interpolation mode the effect uses on the image. There are 5 scale modes that range in quality and speed.
    ///Type is D2D1_3DTRANSFORM_INTERPOLATION_MODE. Default value is D2D1_3DTRANSFORM_INTERPOLATION_MODE_LINEAR.
    D2D1_3DTRANSFORM_PROP_INTERPOLATION_MODE = 0x00000000,
    ///The mode used to calculate the border of the image, soft or hard. See Border modes for more info. Type is
    ///D2D1_BORDER_MODE. Default value is D2D1_BORDER_MODE_SOFT.
    D2D1_3DTRANSFORM_PROP_BORDER_MODE        = 0x00000001,
    ///A 4x4 transform matrix applied to the projection plane. The following matrix calculation is used to map points
    ///from one 3D coordinate system to the transformed 2D coordinate system. <img alt="3D Depth Matrix"
    ///src="./images/3d_transform_matrix1.png"/> Where:<dl> <dd>X, Y, Z = Input projection plane coordinates</dd>
    ///<dd>M<sub>x,y</sub> = Transform Matrix elements </dd> <dd>X’, Y’, Z’ =Output projection plane
    ///coordinates</dd> </dl> The individual matrix elements are not bounded and are unitless. Type is
    ///D2D1_MATRIX_4X4_F. Default value is Matrix4x4F(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1).
    D2D1_3DTRANSFORM_PROP_TRANSFORM_MATRIX   = 0x00000002,
    D2D1_3DTRANSFORM_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the 3D transform effect uses on the image. There are 5 scale modes that range in quality and
///speed.
alias D2D1_3DTRANSFORM_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode uses more processing time than the nearest neighbor
    ///mode, but outputs a higher quality image.
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for the properties of the 3D perspective transform effect.
alias D2D1_3DPERSPECTIVETRANSFORM_PROP = uint;
enum : uint
{
    ///The interpolation mode the effect uses on the image. There are 5 scale modes that range in quality and speed.
    ///Type is D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE. Default value is
    ///D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_LINEAR.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_INTERPOLATION_MODE = 0x00000000,
    ///The mode used to calculate the border of the image, soft or hard. See Border modes for more info. Type is
    ///D2D1_BORDER_MODE. Default value is D2D1_BORDER_MODE_SOFT.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_BORDER_MODE        = 0x00000001,
    ///The distance from the PerspectiveOrigin to the projection plane. The value specified in DIPs and must be greater
    ///than 0. Type is FLOAT. Default value is 1000.0f.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_DEPTH              = 0x00000002,
    ///The X and Y location of the viewer in the 3D scene. This property is a D2D1_VECTOR_2F defined as: (point X, point
    ///Y). The units are in DIPs. You set the Z value with the Depth property. Type is D2D1_VECTOR_2F. Default value is
    ///{0.0f, 0.0f}.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_PERSPECTIVE_ORIGIN = 0x00000003,
    ///A translation the effect performs before it rotates the projection plane. This property is a D2D1_VECTOR_3F
    ///defined as: (X, Y, Z). The units are in DIPs. Type is D2D1_VECTOR_3F. Default value is {0.0f, 0.0f, 0.0f}.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_LOCAL_OFFSET       = 0x00000004,
    ///A translation the effect performs after it rotates the projection plane. This property is a D2D1_VECTOR_3F
    ///defined as: (X, Y, Z). The units are in DIPs. Type is D2D1_VECTOR_3F. Default value is {0.0f, 0.0f, 0.0f}.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_GLOBAL_OFFSET      = 0x00000005,
    ///The center point of the rotation the effect performs. This property is a D2D1_VECTOR_3F defined as: (X, Y, Z).
    ///The units are in DIPs. Type is D2D1_VECTOR_3F. Default value is {0.0f, 0.0f, 0.0f}.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION_ORIGIN    = 0x00000006,
    ///The angles of rotation for each axis. This property is a D2D1_VECTOR_3F defined as: (X, Y, Z). The units are in
    ///degrees. Type is D2D1_VECTOR_3F. Default value is {0.0f, 0.0f, 0.0f}.
    D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION           = 0x00000007,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the 3D perspective transform effect uses on the image. There are 5 scale modes that range in
///quality and speed.
alias D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode uses more processing time than the nearest neighbor
    ///mode, but outputs a higher quality image.
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the 2D affine transform effect.
alias D2D1_2DAFFINETRANSFORM_PROP = uint;
enum : uint
{
    ///The interpolation mode used to scale the image. There are 6 scale modes that range in quality and speed. Type is
    ///D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE. Default value is D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_LINEAR.
    D2D1_2DAFFINETRANSFORM_PROP_INTERPOLATION_MODE = 0x00000000,
    ///The mode used to calculate the border of the image, soft or hard. Type is D2D1_BORDER_MODE. Default value is
    ///D2D1_BORDER_MODE_SOFT.
    D2D1_2DAFFINETRANSFORM_PROP_BORDER_MODE        = 0x00000001,
    ///The 3x2 matrix to transform the image using the Direct2D matrix transform. Type is D2D1_MATRIX_3X2_F. Default
    ///value is Matrix3x2F::Identity().
    D2D1_2DAFFINETRANSFORM_PROP_TRANSFORM_MATRIX   = 0x00000002,
    ///In the high quality cubic interpolation mode, the sharpness level of the scaling filter as a float between 0 and
    ///1. The values are unitless. You can use sharpness to adjust the quality of an image when you scale the image. The
    ///sharpness factor affects the shape of the kernel. The higher the sharpness factor, the smaller the kernel. <div
    ///class="alert"><b>Note</b> This property affects only the high quality cubic interpolation mode.</div> <div>
    ///</div> Type is FLOAT. Default value is 1.0f.
    D2D1_2DAFFINETRANSFORM_PROP_SHARPNESS          = 0x00000003,
    D2D1_2DAFFINETRANSFORM_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode to be used with the 2D affine transform effect to scale the image. There are 6 scale modes
///that range in quality and speed.
alias D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode uses more processing time than the nearest neighbor
    ///mode, but outputs a higher quality image.
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the DPI compensation effect.
alias D2D1_DPICOMPENSATION_PROP = uint;
enum : uint
{
    ///The interpolation mode the effect uses to scale the image. The type is D2D1_DPICOMPENSATION_INTERPOLATION_MODE.
    ///The default value is D2D1_DPICOMPENSATION_INTERPOLATION_MODE_LINEAR.
    D2D1_DPICOMPENSATION_PROP_INTERPOLATION_MODE = 0x00000000,
    ///The mode used to calculate the border of the image, soft or hard. See Border modes for more info. The type is
    ///D2D1_BORDER_MODE. The default value is D2D1_BORDER_MODE_SOFT.
    D2D1_DPICOMPENSATION_PROP_BORDER_MODE        = 0x00000001,
    ///The DPI of the input image. The type is FLOAT. The default value is 96.0f.
    D2D1_DPICOMPENSATION_PROP_INPUT_DPI          = 0x00000002,
    D2D1_DPICOMPENSATION_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the DPI compensation effect uses to scale the image.
alias D2D1_DPICOMPENSATION_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode uses more processing time than the nearest neighbor
    ///mode, but outputs a higher quality image.
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Scale effect.
alias D2D1_SCALE_PROP = uint;
enum : uint
{
    ///The scale amount in the X and Y direction as a ratio of the output size to the input size. This property a
    ///D2D1_VECTOR_2F defined as: (X scale, Y scale). The scale amounts are FLOAT, unitless, and must be positive or 0.
    ///The type is D2D1_VECTOR_2F. The default value is {1.0f, 1.0f}.
    D2D1_SCALE_PROP_SCALE              = 0x00000000,
    ///The image scaling center point. This property is a D2D1_VECTOR_2F defined as: (point X, point Y). The units are
    ///in DIPs. Use the center point property to scale around a point other than the upper-left corner. The type is
    ///D2D1_VECTOR_2F. The default value is {0.0f, 0.0f}.
    D2D1_SCALE_PROP_CENTER_POINT       = 0x00000001,
    ///The interpolation mode the effect uses to scale the image. There are 6 scale modes that range in quality and
    ///speed. The type is D2D1_SCALE_INTERPOLATION_MODE. The default value is D2D1_SCALE_INTERPOLATION_MODE_LINEAR.
    D2D1_SCALE_PROP_INTERPOLATION_MODE = 0x00000002,
    ///The mode used to calculate the border of the image, soft or hard. The type is D2D1_BORDER_MODE. The default value
    ///is D2D1_BORDER_MODE_SOFT.
    D2D1_SCALE_PROP_BORDER_MODE        = 0x00000003,
    ///In the high quality cubic interpolation mode, the sharpness level of the scaling filter as a float between 0 and
    ///1. The values are unitless. You can use sharpness to adjust the quality of an image when you scale the image
    ///down. The sharpness factor affects the shape of the kernel. The higher the sharpness factor, the smaller the
    ///kernel. <div class="alert"><b>Note</b> This property affects only the high quality cubic interpolation
    ///mode.</div> <div> </div> The type is FLOAT. The default value is 0.0f.
    D2D1_SCALE_PROP_SHARPNESS          = 0x00000004,
    D2D1_SCALE_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the Scale effect uses to scale the image. There are 6 scale modes that range in quality and
///speed.
alias D2D1_SCALE_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_SCALE_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode uses more processing time than the nearest neighbor
    ///mode, but outputs a higher quality image.
    D2D1_SCALE_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_SCALE_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_SCALE_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_SCALE_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_SCALE_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_SCALE_INTERPOLATION_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Turbulence effect.
alias D2D1_TURBULENCE_PROP = uint;
enum : uint
{
    ///The coordinates where the turbulence output is generated. The algorithm used to generate the Perlin noise is
    ///position dependent, so a different offset results in a different output. This property is not bounded and the
    ///units are specified in DIPs. <div class="alert"><b>Note</b> The offset does not have the same effect as a
    ///translation because the noise function output is infinite and the function will wrap around the tile.</div> <div>
    ///</div> The type is D2D1_VECTOR_2F. The default value is {0.0f, 0.0f}.
    D2D1_TURBULENCE_PROP_OFFSET         = 0x00000000,
    D2D1_TURBULENCE_PROP_SIZE           = 0x00000001,
    ///The base frequencies in the X and Y direction. This property is a float and must be greater than 0. The units are
    ///specified in 1/DIPs. A value of 1 (1/DIPs) for the base frequency results in the Perlin noise completing an
    ///entire cycle between two pixels. The ease interpolation for these pixels results in completely random pixels,
    ///since there is no correlation between the pixels. A value of 0.1(1/DIPs) for the base frequency, the Perlin noise
    ///function repeats every 10 DIPs. This results in correlation between pixels and the typical turbulence effect is
    ///visible. The type is D2D1_VECTOR_2F. The default value is {0.01f, 0.01f}.
    D2D1_TURBULENCE_PROP_BASE_FREQUENCY = 0x00000002,
    ///The number of octaves for the noise function. This property is a UINT32 and must be greater than 0. The type is
    ///UINT32. The default value is 1.
    D2D1_TURBULENCE_PROP_NUM_OCTAVES    = 0x00000003,
    ///The seed for the pseudo random generator. This property is unbounded. The type is UINT32. The default value is 0.
    D2D1_TURBULENCE_PROP_SEED           = 0x00000004,
    ///The turbulence noise mode. This property can be either fractal sum or turbulence. Indicates whether to generate a
    ///bitmap based on Fractal Noise or the Turbulence function. The type is D2D1_TURBULENCE_NOISE. The default value is
    ///D2D1_TURBULENCE_NOISE_FRACTAL_SUM.
    D2D1_TURBULENCE_PROP_NOISE          = 0x00000005,
    ///Turns stitching on or off. The base frequency is adjusted so that output bitmap can be stitched. This is useful
    ///if you want to tile multiple copies of the turbulence effect output. True – The output bitmap can be tiled
    ///(using the tile effect) without the appearance of seams. The base frequency is adjusted so that output bitmap can
    ///be stitched. False – The base frequency is not adjusted, so seams may appear between tiles if the bitmap is
    ///tiled. The type is BOOL. The default value is FALSE.
    D2D1_TURBULENCE_PROP_STITCHABLE     = 0x00000006,
    D2D1_TURBULENCE_PROP_FORCE_DWORD    = 0xffffffff,
}

///The turbulence noise mode for the Turbulence effect. Indicates whether to generate a bitmap based on Fractal Noise or
///the Turbulence function.
alias D2D1_TURBULENCE_NOISE = uint;
enum : uint
{
    ///Computes a sum of the octaves, shifting the output range from [-1, 1], to [0, 1].
    D2D1_TURBULENCE_NOISE_FRACTAL_SUM = 0x00000000,
    ///Computes a sum of the absolute value of each octave.
    D2D1_TURBULENCE_NOISE_TURBULENCE  = 0x00000001,
    D2D1_TURBULENCE_NOISE_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Displacement map effect.
alias D2D1_DISPLACEMENTMAP_PROP = uint;
enum : uint
{
    ///Multiplies the intensity of the selected channel from the displacement image. The higher you set this property,
    ///the more the effect displaces the pixels. The type is FLOAT. The default value is 0.0f.
    D2D1_DISPLACEMENTMAP_PROP_SCALE            = 0x00000000,
    ///The effect extracts the intensity from this color channel and uses it to spatially displace the image in the X
    ///direction. The type is D2D1_CHANNEL_SELECTOR. The default value is D2D1_CHANNEL_SELECTOR_A
    D2D1_DISPLACEMENTMAP_PROP_X_CHANNEL_SELECT = 0x00000001,
    ///The effect extracts the intensity from this color channel and uses it to spatially displace the image in the Y
    ///direction. The type is D2D1_CHANNEL_SELECTOR. The default value is D2D1_CHANNEL_SELECTOR_A
    D2D1_DISPLACEMENTMAP_PROP_Y_CHANNEL_SELECT = 0x00000002,
    D2D1_DISPLACEMENTMAP_PROP_FORCE_DWORD      = 0xffffffff,
}

///Identifiers for the properties of the Color management effect.
alias D2D1_COLORMANAGEMENT_PROP = uint;
enum : uint
{
    ///The source color space information. The type is ID2D1ColorContext. The default value is NULL.
    D2D1_COLORMANAGEMENT_PROP_SOURCE_COLOR_CONTEXT         = 0x00000000,
    ///Which ICC rendering intent to use. The type is D2D1_COLORMANAGEMENT_RENDERING_INTENT. The default value is
    ///D2D1_COLORMANAGEMENT_RENDERING_INTENT_PERCEPTUAL.
    D2D1_COLORMANAGEMENT_PROP_SOURCE_RENDERING_INTENT      = 0x00000001,
    ///The destination color space information. The type is ID2D1ColorContext. The default value is NULL.
    D2D1_COLORMANAGEMENT_PROP_DESTINATION_COLOR_CONTEXT    = 0x00000002,
    ///Which ICC rendering intent to use. The type is D2D1_COLORMANAGEMENT_RENDERING_INTENT. The default value is
    ///D2D1_COLORMANAGEMENT_RENDERING_INTENT_PERCEPTUAL.
    D2D1_COLORMANAGEMENT_PROP_DESTINATION_RENDERING_INTENT = 0x00000003,
    ///How to interpret alpha data that is contained in the input image. The type is D2D1_COLORMANAGEMENT_ALPHA_MODE.
    ///The default value is D2D1_COLORMANAGEMENT_ALPHA_MODE_PREMULTIPLIED.
    D2D1_COLORMANAGEMENT_PROP_ALPHA_MODE                   = 0x00000004,
    ///The quality level of the transform. The type is D2D1_COLORMANAGEMENT_QUALITY. The default value is
    ///D2D1_COLORMANAGEMENT_QUALITY_NORMAL.
    D2D1_COLORMANAGEMENT_PROP_QUALITY                      = 0x00000005,
    D2D1_COLORMANAGEMENT_PROP_FORCE_DWORD                  = 0xffffffff,
}

///Indicates how the Color management effect should interpret alpha data that is contained in the input image.
alias D2D1_COLORMANAGEMENT_ALPHA_MODE = uint;
enum : uint
{
    ///The effect assumes the alpha mode is premultiplied.
    D2D1_COLORMANAGEMENT_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    ///The effect assumes the alpha mode is straight.
    D2D1_COLORMANAGEMENT_ALPHA_MODE_STRAIGHT      = 0x00000002,
    D2D1_COLORMANAGEMENT_ALPHA_MODE_FORCE_DWORD   = 0xffffffff,
}

///The quality level of the transform for the Color management effect.
alias D2D1_COLORMANAGEMENT_QUALITY = uint;
enum : uint
{
    ///The lowest quality mode. This mode requires feature level 9_1 or above.
    D2D1_COLORMANAGEMENT_QUALITY_PROOF       = 0x00000000,
    ///Normal quality mode. This mode requires feature level 9_1 or above.
    D2D1_COLORMANAGEMENT_QUALITY_NORMAL      = 0x00000001,
    ///The best quality mode. This mode requires feature level 10_0 or above, as well as floating point precision
    ///buffers. This mode supports floating point precision as well as extended range as defined in the ICC v4.3
    ///specification.
    D2D1_COLORMANAGEMENT_QUALITY_BEST        = 0x00000002,
    D2D1_COLORMANAGEMENT_QUALITY_FORCE_DWORD = 0xffffffff,
}

///Specifies which ICC rendering intent the Color management effect should use.
alias D2D1_COLORMANAGEMENT_RENDERING_INTENT = uint;
enum : uint
{
    ///The effect compresses or expands the full color gamut of the image to fill the color gamut of the device, so that
    ///gray balance is preserved but colorimetric accuracy may not be preserved.
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_PERCEPTUAL            = 0x00000000,
    ///The effect preserves the chroma of colors in the image at the possible expense of hue and lightness.
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_RELATIVE_COLORIMETRIC = 0x00000001,
    ///The effect adjusts colors that fall outside the range of colors the output device renders to the closest color
    ///available. It does not preserve the white point.
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_SATURATION            = 0x00000002,
    ///The effect adjusts any colors that fall outside the range that the output device can render to the closest color
    ///that can be rendered. The effect does not change the other colors and preserves the white point.
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_ABSOLUTE_COLORIMETRIC = 0x00000003,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_FORCE_DWORD           = 0xffffffff,
}

///Identifiers for properties of the Histogram effect.
alias D2D1_HISTOGRAM_PROP = uint;
enum : uint
{
    ///Specifies the number of bins used for the histogram. The range of intensity values that fall into a particular
    ///bucket depend on the number of specified buckets. The type is UINT32. The default is 256.
    D2D1_HISTOGRAM_PROP_NUM_BINS         = 0x00000000,
    ///Specifies the channel used to generate the histogram. This effect has a single data output corresponding to the
    ///specified channel. The type is D2D1_CHANNEL_SELECTOR. The default is D2D1_CHANNEL_SELECTOR_R.
    D2D1_HISTOGRAM_PROP_CHANNEL_SELECT   = 0x00000001,
    ///The output array. The type is FLOAT[].
    D2D1_HISTOGRAM_PROP_HISTOGRAM_OUTPUT = 0x00000002,
    D2D1_HISTOGRAM_PROP_FORCE_DWORD      = 0xffffffff,
}

///Identifiers for properties of the Point-specular lighting effect.
alias D2D1_POINTSPECULAR_PROP = uint;
enum : uint
{
    ///The light position of the point light source. The property is a D2D1_VECTOR_3F defined as (x, y, z). The units
    ///are in device-independent pixels (DIPs) and the values are unitless and unbounded. The type is D2D1_VECTOR_3F.
    ///The default value is {0.0f, 0.0f, 0.0f}.
    D2D1_POINTSPECULAR_PROP_LIGHT_POSITION     = 0x00000000,
    ///The exponent for the specular term in the Phong lighting equation. A larger value corresponds to a more
    ///reflective surface. This value is unitless and must be between 1.0 and 128. The type is FLOAT. The default value
    ///is 1.0f.
    D2D1_POINTSPECULAR_PROP_SPECULAR_EXPONENT  = 0x00000001,
    ///The ratio of specular reflection to the incoming light. The value is unitless and must be between 0 and 10,000.
    ///The type is FLOAT. The default value is 1.0f.
    D2D1_POINTSPECULAR_PROP_SPECULAR_CONSTANT  = 0x00000002,
    ///The scale factor in the Z direction for generating a height map. The value is unitless and must be between 0 and
    ///10,000. The type is FLOAT. The default value is 1.0f.
    D2D1_POINTSPECULAR_PROP_SURFACE_SCALE      = 0x00000003,
    ///The color of the incoming light. This property is exposed as a D2D1_VECTOR_3F – (R, G, B) and used to compute
    ///LR, LG, LB. The type is D2D1_VECTOR_3F. The default value is {1.0f, 1.0f, 1.0f}.
    D2D1_POINTSPECULAR_PROP_COLOR              = 0x00000004,
    ///The size of an element in the Sobel kernel used to generate the surface normal in the X and Y directions. This
    ///property maps to the dx and dy values in the Sobel gradient. This property is a D2D1_VECTOR_2F(Kernel Unit Length
    ///X, Kernel Unit Length Y) and is defined in (DIPs/Kernel Unit). The effect uses bilinear interpolation to scale
    ///the bitmap to match size of kernel elements. The type is D2D1_VECTOR_2F. The default value is {1.0f, 1.0f}.
    D2D1_POINTSPECULAR_PROP_KERNEL_UNIT_LENGTH = 0x00000005,
    ///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
    ///scale modes that range in quality and speed. The type is D2D1_POINTSPECULAR_SCALE_MODE. The default value is
    ///D2D1_POINTSPECULAR_SCALE_MODE_LINEAR.
    D2D1_POINTSPECULAR_PROP_SCALE_MODE         = 0x00000006,
    D2D1_POINTSPECULAR_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the Point-specular lighting effect uses to scale the image to the corresponding kernel unit
///length. There are six scale modes that range in quality and speed.
alias D2D1_POINTSPECULAR_SCALE_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_POINTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode outputs a higher quality image than nearest
    ///neighbor.
    D2D1_POINTSPECULAR_SCALE_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_POINTSPECULAR_SCALE_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_POINTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_POINTSPECULAR_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_POINTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_POINTSPECULAR_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Spot-specular lighting effect.
alias D2D1_SPOTSPECULAR_PROP = uint;
enum : uint
{
    ///The light position of the point light source. The property is a D2D1_VECTOR_3F defined as (x, y, z). The units
    ///are in device-independent pixels (DIPs) and are unbounded. The type is D2D1_VECTOR_3F. The default value is
    ///{0.0f, 0.0f, 0.0f}.
    D2D1_SPOTSPECULAR_PROP_LIGHT_POSITION      = 0x00000000,
    ///Where the spot light is focused. The property is exposed as a D2D1_VECTOR_3F with – (x, y, z). The units are in
    ///DIPs and the values are unbounded. The type is D2D1_VECTOR_3F. The default value is {0.0f, 0.0f, 0.0f}.
    D2D1_SPOTSPECULAR_PROP_POINTS_AT           = 0x00000001,
    ///The focus of the spot light. This property is unitless and is defined between 0 and 200. The type is FLOAT. The
    ///default value is 1.0f.
    D2D1_SPOTSPECULAR_PROP_FOCUS               = 0x00000002,
    ///The cone angle that restricts the region where the light is projected. No light is projected outside the cone.
    ///The limiting cone angle is the angle between the spot light axis (the axis between the LightPosition and PointsAt
    ///properties) and the spot light cone. This property is defined in degrees and must be between 0 to 90 degrees. The
    ///type is FLOAT. The default value is 90.0f.
    D2D1_SPOTSPECULAR_PROP_LIMITING_CONE_ANGLE = 0x00000003,
    ///The exponent for the specular term in the Phong lighting equation. A larger value corresponds to a more
    ///reflective surface. This value is unitless and must be between 1.0 and 128. The type is FLOAT. The default value
    ///is 1.0f.
    D2D1_SPOTSPECULAR_PROP_SPECULAR_EXPONENT   = 0x00000004,
    ///The ratio of specular reflection to the incoming light. The value is unitless and must be between 0 and 10,000.
    ///The type is FLOAT. The default value is 1.0f.
    D2D1_SPOTSPECULAR_PROP_SPECULAR_CONSTANT   = 0x00000005,
    ///The scale factor in the Z direction for generating a height map. The value is unitless and must be between 0 and
    ///10,000. The type is FLOAT. The default value is 1.0f.
    D2D1_SPOTSPECULAR_PROP_SURFACE_SCALE       = 0x00000006,
    ///The color of the incoming light. This property is exposed as a Vector 3 – (R, G, B) and used to compute LR, LG,
    ///LB. The type is D2D1_VECTOR_3F. The default value is {1.0f, 1.0f, 1.0f}.
    D2D1_SPOTSPECULAR_PROP_COLOR               = 0x00000007,
    ///The size of an element in the Sobel kernel used to generate the surface normal in the X and Y direction. This
    ///property maps to the dx and dy values in the Sobel gradient. This property is a D2D1_VECTOR_2F (Kernel Unit
    ///Length X, Kernel Unit Length Y) and is defined in (DIPs/Kernel Unit). The effect uses bilinear interpolation to
    ///scale the bitmap to match size of kernel elements. The type is D2D1_VECTOR_2F. The default value is {1.0f, 1.0f}.
    D2D1_SPOTSPECULAR_PROP_KERNEL_UNIT_LENGTH  = 0x00000008,
    ///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
    ///scale modes that range in quality and speed. The type is D2D1_SPOTSPECULAR_SCALE_MODE. The default value is
    ///D2D1_SPOTSPECULAR_SCALE_MODE_LINEAR.
    D2D1_SPOTSPECULAR_PROP_SCALE_MODE          = 0x00000009,
    D2D1_SPOTSPECULAR_PROP_FORCE_DWORD         = 0xffffffff,
}

///The interpolation mode the Spot-specular lighting effect uses to scale the image to the corresponding kernel unit
///length. There are six scale modes that range in quality and speed.
alias D2D1_SPOTSPECULAR_SCALE_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_SPOTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode outputs a higher quality image than nearest
    ///neighbor.
    D2D1_SPOTSPECULAR_SCALE_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_SPOTSPECULAR_SCALE_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_SPOTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_SPOTSPECULAR_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_SPOTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_SPOTSPECULAR_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Distant-specular lighting effect.
alias D2D1_DISTANTSPECULAR_PROP = uint;
enum : uint
{
    ///The direction angle of the light source in the XY plane relative to the X-axis in the counter clock wise
    ///direction. The units are in degrees and must be between 0 and 360 degrees. The type is FLOAT. The default value
    ///is 0.0f.
    D2D1_DISTANTSPECULAR_PROP_AZIMUTH            = 0x00000000,
    ///The direction angle of the light source in the YZ plane relative to the Y-axis in the counter clock wise
    ///direction. The units are in degrees and must be between 0 and 360 degrees. The type is FLOAT. The default value
    ///is 0.0f.
    D2D1_DISTANTSPECULAR_PROP_ELEVATION          = 0x00000001,
    ///The exponent for the specular term in the Phong lighting equation. A larger value corresponds to a more
    ///reflective surface. The value is unitless and must be between 1.0 and 128. The type is FLOAT. The default value
    ///is 1.0f.
    D2D1_DISTANTSPECULAR_PROP_SPECULAR_EXPONENT  = 0x00000002,
    ///The ratio of specular reflection to the incoming light. The value is unitless and must be between 0 and 10,000.
    ///The type is FLOAT. The default value is 1.0f.
    D2D1_DISTANTSPECULAR_PROP_SPECULAR_CONSTANT  = 0x00000003,
    ///The scale factor in the Z direction. The value is unitless and must be between 0 and 10,000. The type is FLOAT.
    ///The default value is 1.0f.
    D2D1_DISTANTSPECULAR_PROP_SURFACE_SCALE      = 0x00000004,
    ///The color of the incoming light. This property is exposed as a D2D1_VECTOR_3F – (R, G, B) and used to compute
    ///LR, LG, LB. The type is D2D1_VECTOR_3F. The default value is {1.0f, 1.0f, 1.0f}.
    D2D1_DISTANTSPECULAR_PROP_COLOR              = 0x00000005,
    ///The size of an element in the Sobel kernel used to generate the surface normal in the X and Y direction. This
    ///property is a D2D1_VECTOR_2F (Kernel Unit Length X, Kernel Unit Length Y) and is defined in (device-independent
    ///pixels (DIPs)/Kernel Unit). The effect uses bilinear interpolation to scale the bitmap to match size of kernel
    ///elements. The type is D2D1_VECTOR_2F. The default value is {1.0f, 1.0f}.
    D2D1_DISTANTSPECULAR_PROP_KERNEL_UNIT_LENGTH = 0x00000006,
    ///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
    ///scale modes that range in quality and speed. The type is D2D1_DISTANTSPECULAR_SCALE_MODE. The default value is
    ///D2D1_DISTANTSPECULAR_SCALE_MODE_LINEAR.
    D2D1_DISTANTSPECULAR_PROP_SCALE_MODE         = 0x00000007,
    D2D1_DISTANTSPECULAR_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the Distant-specular lighting effect uses to scale the image to the corresponding kernel unit
///length. There are six scale modes that range in quality and speed.
alias D2D1_DISTANTSPECULAR_SCALE_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_DISTANTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode outputs a higher quality image than nearest
    ///neighbor.
    D2D1_DISTANTSPECULAR_SCALE_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_DISTANTSPECULAR_SCALE_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_DISTANTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_DISTANTSPECULAR_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_DISTANTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_DISTANTSPECULAR_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Point-diffuse lighting effect.
alias D2D1_POINTDIFFUSE_PROP = uint;
enum : uint
{
    ///The light position of the point light source. The property is a D2D1_VECTOR_3F defined as (x, y, z). The units
    ///are in device-independent pixels (DIPs) and are unbounded. The type is D2D1_VECTOR_3F. The default value is
    ///{0.0f, 0.0f, 0.0f}.
    D2D1_POINTDIFFUSE_PROP_LIGHT_POSITION     = 0x00000000,
    ///The ratio of diffuse reflection to amount of incoming light. This property must be between 0 and 10,000 and is
    ///unitless. The type is FLOAT. The default value is 1.0f.
    D2D1_POINTDIFFUSE_PROP_DIFFUSE_CONSTANT   = 0x00000001,
    ///The scale factor in the Z direction. The surface scale is unitless and must be between 0 and 10,000. The type is
    ///FLOAT. The default value is 1.0f.
    D2D1_POINTDIFFUSE_PROP_SURFACE_SCALE      = 0x00000002,
    ///The color of the incoming light. This property is exposed as a Vector 3 – (R, G, B) and used to compute LR, LG,
    ///LB. The type is D2D1_VECTOR_3F. The default value is {1.0f, 1.0f, 1.0f}.
    D2D1_POINTDIFFUSE_PROP_COLOR              = 0x00000003,
    ///The size of an element in the Sobel kernel used to generate the surface normal in the X and Y direction. This
    ///property maps to the dx and dy values in the Sobel gradient. This property is a D2D1_VECTOR_2F (Kernel Unit
    ///Length X, Kernel Unit Length Y) and is defined in (DIPs/Kernel Unit). The effect uses bilinear interpolation to
    ///scale the bitmap to match size of kernel elements. The type is D2D1_VECTOR_2F. The default value is {1.0f, 1.0f}.
    D2D1_POINTDIFFUSE_PROP_KERNEL_UNIT_LENGTH = 0x00000004,
    ///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
    ///scale modes that range in quality and speed. The type is D2D1_POINTDIFFUSE_SCALE_MODE. The default value is
    ///D2D1_POINTDIFFUSE_SCALE_MODE_LINEAR.
    D2D1_POINTDIFFUSE_PROP_SCALE_MODE         = 0x00000005,
    D2D1_POINTDIFFUSE_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the Point-diffuse lighting effect uses to scale the image to the corresponding kernel unit
///length. There are six scale modes that range in quality and speed
alias D2D1_POINTDIFFUSE_SCALE_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_POINTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode outputs a higher quality image than nearest
    ///neighbor.
    D2D1_POINTDIFFUSE_SCALE_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_POINTDIFFUSE_SCALE_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_POINTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_POINTDIFFUSE_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_POINTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_POINTDIFFUSE_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Spot-diffuse lighting effect.
alias D2D1_SPOTDIFFUSE_PROP = uint;
enum : uint
{
    ///The light position of the point light source. The property is a D2D1_VECTOR_3F defined as (x, y, z). The units
    ///are in device-independent pixels (DIPs) and are unbounded. The type is D2D1_VECTOR_3F. The default value is
    ///{0.0f, 0.0f, 0.0f}.
    D2D1_SPOTDIFFUSE_PROP_LIGHT_POSITION      = 0x00000000,
    ///Where the spot light is focused. The property is exposed as a D2D1_VECTOR_3F with – (x, y, z). The units are in
    ///DIPs and the values are unbounded. The type is D2D1_VECTOR_3F. The default value is {0.0f, 0.0f, 0.0f}.
    D2D1_SPOTDIFFUSE_PROP_POINTS_AT           = 0x00000001,
    ///The focus of the spot light. This property is unitless and is defined between 0 and 200. The type is FLOAT. The
    ///default value is 1.0f.
    D2D1_SPOTDIFFUSE_PROP_FOCUS               = 0x00000002,
    ///The cone angle that restricts the region where the light is projected. No light is projected outside the cone.
    ///The limiting cone angle is the angle between the spot light axis (the axis between the LightPosition and PointsAt
    ///properties) and the spot light cone. This property is defined in degrees and must be between 0 to 90 degrees. The
    ///type is FLOAT. The default value is 90.0f.
    D2D1_SPOTDIFFUSE_PROP_LIMITING_CONE_ANGLE = 0x00000003,
    ///The ratio of diffuse reflection to amount of incoming light. This property must be between 0 and 10,000 and is
    ///unitless. The type is FLOAT. The default value is 1.0f.
    D2D1_SPOTDIFFUSE_PROP_DIFFUSE_CONSTANT    = 0x00000004,
    ///The scale factor in the Z direction. The surface scale is unitless and must be between 0 and 10,000. The type is
    ///FLOAT. The default value is 1.0f.
    D2D1_SPOTDIFFUSE_PROP_SURFACE_SCALE       = 0x00000005,
    ///The color of the incoming light. This property is exposed as a Vector 3 – (R, G, B) and used to compute
    ///L<sub>R</sub>, L<sub>G</sub>, L<sub>B</sub>. The type is D2D1_VECTOR_3F. The default value is {1.0f, 1.0f, 1.0f}
    D2D1_SPOTDIFFUSE_PROP_COLOR               = 0x00000006,
    ///The size of an element in the Sobel kernel used to generate the surface normal in the X and Y direction. This
    ///property maps to the dx and dy values in the Sobel gradient. This property is a D2D1_VECTOR_2F(Kernel Unit Length
    ///X, Kernel Unit Length Y) and is defined in (DIPs/Kernel Unit). The effect uses bilinear interpolation to scale
    ///the bitmap to match size of kernel elements. The type is D2D1_VECTOR_2F. The default value is {1.0f, 1.0f}.
    D2D1_SPOTDIFFUSE_PROP_KERNEL_UNIT_LENGTH  = 0x00000007,
    ///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
    ///scale modes that range in quality and speed. The type is D2D1_SPOTDIFFUSE_SCALE_MODE. The default value is
    ///D2D1_SPOTDIFFUSE_SCALE_MODE_LINEAR.
    D2D1_SPOTDIFFUSE_PROP_SCALE_MODE          = 0x00000008,
    D2D1_SPOTDIFFUSE_PROP_FORCE_DWORD         = 0xffffffff,
}

///The interpolation mode the Spot-diffuse lighting effect uses to scale the image to the corresponding kernel unit
///length. There are six scale modes that range in quality and speed.
alias D2D1_SPOTDIFFUSE_SCALE_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_SPOTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode outputs a higher quality image than nearest
    ///neighbor.
    D2D1_SPOTDIFFUSE_SCALE_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_SPOTDIFFUSE_SCALE_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_SPOTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_SPOTDIFFUSE_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_SPOTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_SPOTDIFFUSE_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Distant-diffuse lighting effect.
alias D2D1_DISTANTDIFFUSE_PROP = uint;
enum : uint
{
    ///The direction angle of the light source in the XY plane relative to the X-axis in the counter clock wise
    ///direction. The units are in degrees and must be between 0 and 360 degrees. The type is FLOAT. The default value
    ///is 0.0f.
    D2D1_DISTANTDIFFUSE_PROP_AZIMUTH            = 0x00000000,
    ///The direction angle of the light source in the YZ plane relative to the Y-axis in the counter clock wise
    ///direction. The units are in degrees and must be between 0 and 360 degrees. The type is FLOAT. The default value
    ///is 0.0f.
    D2D1_DISTANTDIFFUSE_PROP_ELEVATION          = 0x00000001,
    ///The ratio of diffuse reflection to amount of incoming light. This property must be between 0 and 10,000 and is
    ///unitless. The type is FLOAT. The default value is 1.0f.
    D2D1_DISTANTDIFFUSE_PROP_DIFFUSE_CONSTANT   = 0x00000002,
    ///The scale factor in the Z direction. The surface scale is unitless and must be between 0 and 10,000. The type is
    ///FLOAT. The default value is 1.0f.
    D2D1_DISTANTDIFFUSE_PROP_SURFACE_SCALE      = 0x00000003,
    ///The color of the incoming light. This property is exposed as a D2D1_VECTOR_3F – (R, G, B) and used to compute
    ///LR, LG, LB. The type is D2D1_VECTOR_3F. The default value is {1.0f, 1.0f, 1.0f}.
    D2D1_DISTANTDIFFUSE_PROP_COLOR              = 0x00000004,
    ///The size of an element in the Sobel kernel used to generate the surface normal in the X and Y direction. This
    ///property maps to the dx and dy values in the Sobel gradient. This property is a D2D1_VECTOR_2F (Kernel Unit
    ///Length X, Kernel Unit Length Y) and is defined in (device-independent pixels (DIPs)/Kernel Unit). The effect uses
    ///bilinear interpolation to scale the bitmap to match size of kernel elements. The type is D2D1_VECTOR_2F. The
    ///default value is {1.0f, 1.0f}.
    D2D1_DISTANTDIFFUSE_PROP_KERNEL_UNIT_LENGTH = 0x00000005,
    ///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
    ///scale modes that range in quality and speed. The type is D2D1_DISTANTDIFFUSE_SCALE_MODE. The default value is
    ///D2D1_DISTANTDIFFUSE_SCALE_MODE_LINEAR.
    D2D1_DISTANTDIFFUSE_PROP_SCALE_MODE         = 0x00000006,
    D2D1_DISTANTDIFFUSE_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
///scale modes that range in quality and speed.
alias D2D1_DISTANTDIFFUSE_SCALE_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_DISTANTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode outputs a higher quality image than nearest
    ///neighbor.
    D2D1_DISTANTDIFFUSE_SCALE_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_DISTANTDIFFUSE_SCALE_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_DISTANTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_DISTANTDIFFUSE_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_DISTANTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Flood effect.
alias D2D1_FLOOD_PROP = uint;
enum : uint
{
    ///The color and opacity of the bitmap. This property is a D2D1_VECTOR_4F. The individual values for each channel
    ///are of type FLOAT, unbounded and unitless. The effect doesn't modify the values for the channels. The RGBA values
    ///for each channel range from 0 to 1. The type is D2D1_VECTOR_4F. The default value is {0.0f, 0.0f, 0.0f, 1.0f}.
    D2D1_FLOOD_PROP_COLOR       = 0x00000000,
    D2D1_FLOOD_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Linear transfer effect.
alias D2D1_LINEARTRANSFER_PROP = uint;
enum : uint
{
    ///The Y-intercept of the linear function for the Red channel. The type is FLOAT. The default is 0.0f.
    D2D1_LINEARTRANSFER_PROP_RED_Y_INTERCEPT   = 0x00000000,
    ///The slope of the linear function for the Red channel. The type is FLOAT. The default is 1.0f.
    D2D1_LINEARTRANSFER_PROP_RED_SLOPE         = 0x00000001,
    ///If you set this to TRUE the effect does not apply the transfer function to the Red channel. If you set this to
    ///FALSE the effect applies the RedLinearTransfer function to the Red channel. The type is BOOL. The default is
    ///FALSE.
    D2D1_LINEARTRANSFER_PROP_RED_DISABLE       = 0x00000002,
    ///The Y-intercept of the linear function for the Green channel. The type is FLOAT. The default is 0.0f.
    D2D1_LINEARTRANSFER_PROP_GREEN_Y_INTERCEPT = 0x00000003,
    ///The slope of the linear function for the Green channel. The type is FLOAT. The default is 1.0f.
    D2D1_LINEARTRANSFER_PROP_GREEN_SLOPE       = 0x00000004,
    ///If you set this to TRUE the effect does not apply the transfer function to the Green channel. If you set this to
    ///FALSE the effect applies the GreenLinearTransfer function to the Green channel. The type is BOOL. The default is
    ///FALSE.
    D2D1_LINEARTRANSFER_PROP_GREEN_DISABLE     = 0x00000005,
    ///The Y-intercept of the linear function for the Blue channel. The type is FLOAT. The default is 0.0f.
    D2D1_LINEARTRANSFER_PROP_BLUE_Y_INTERCEPT  = 0x00000006,
    ///The slope of the linear function for the Blue channel. The type is FLOAT. The default is 1.0f.
    D2D1_LINEARTRANSFER_PROP_BLUE_SLOPE        = 0x00000007,
    ///If you set this to TRUE the effect does not apply the transfer function to the Blue channel. If you set this to
    ///FALSE the effect applies the BlueLinearTransfer function to the Blue channel. The type is BOOL. The default is
    ///FALSE.
    D2D1_LINEARTRANSFER_PROP_BLUE_DISABLE      = 0x00000008,
    ///The Y-intercept of the linear function for the Alpha channel. The type is FLOAT. The default is 0.0f.
    D2D1_LINEARTRANSFER_PROP_ALPHA_Y_INTERCEPT = 0x00000009,
    ///The slope of the linear function for the Alpha channel. The type is FLOAT. The default is 0.0f.
    D2D1_LINEARTRANSFER_PROP_ALPHA_SLOPE       = 0x0000000a,
    ///If you set this to TRUE the effect does not apply the transfer function to the Alpha channel. If you set this to
    ///FALSE the effect applies the AlphaLinearTransfer function to the Alpha channel. The type is BOOL. The default is
    ///FALSE.
    D2D1_LINEARTRANSFER_PROP_ALPHA_DISABLE     = 0x0000000b,
    ///Whether the effect clamps color values to between 0 and 1 before the effect passes the values to the next effect
    ///in the graph. The effect clamps the values before it premultiplies the alpha . If you set this to TRUE the effect
    ///will clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects
    ///and the output surface may clamp the values if they are not of high enough precision. The type is BOOL. The
    ///default is FALSE.
    D2D1_LINEARTRANSFER_PROP_CLAMP_OUTPUT      = 0x0000000c,
    D2D1_LINEARTRANSFER_PROP_FORCE_DWORD       = 0xffffffff,
}

///Identifiers for properties of the Gamma transfer effect.
alias D2D1_GAMMATRANSFER_PROP = uint;
enum : uint
{
    ///The amplitude of the gamma transfer function for the Red channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_RED_AMPLITUDE   = 0x00000000,
    ///The exponent of the gamma transfer function for the Red channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_RED_EXPONENT    = 0x00000001,
    ///The offset of the gamma transfer function for the Red channel. The type is FLOAT. The default value is 0.0f.
    D2D1_GAMMATRANSFER_PROP_RED_OFFSET      = 0x00000002,
    ///If you set this to TRUE it does not apply the transfer function to the Red channel. An identity transfer function
    ///is used. If you set this to FALSE it applies the gamma transfer function to the Red channel. The type is BOOL.
    ///The default value is FALSE.
    D2D1_GAMMATRANSFER_PROP_RED_DISABLE     = 0x00000003,
    ///The amplitude of the gamma transfer function for the Green channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_GREEN_AMPLITUDE = 0x00000004,
    ///The exponent of the gamma transfer function for the Green channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_GREEN_EXPONENT  = 0x00000005,
    ///The offset of the gamma transfer function for the Green channel. The type is FLOAT. The default value is 0.0f.
    D2D1_GAMMATRANSFER_PROP_GREEN_OFFSET    = 0x00000006,
    ///If you set this to TRUE it does not apply the transfer function to the Green channel. An identity transfer
    ///function is used. If you set this to FALSE it applies the gamma transfer function to the Green channel. The type
    ///is BOOL. The default value is FALSE.
    D2D1_GAMMATRANSFER_PROP_GREEN_DISABLE   = 0x00000007,
    ///The amplitude of the gamma transfer function for the Blue channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_BLUE_AMPLITUDE  = 0x00000008,
    ///The exponent of the gamma transfer function for the Blue channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_BLUE_EXPONENT   = 0x00000009,
    ///The offset of the gamma transfer function for the Blue channel. The type is FLOAT. The default value is 0.0f.
    D2D1_GAMMATRANSFER_PROP_BLUE_OFFSET     = 0x0000000a,
    ///If you set this to TRUE it does not apply the transfer function to the Blue channel. An identity transfer
    ///function is used. If you set this to FALSE it applies the gamma transfer function to the Blue channel. The type
    ///is BOOL. The default value is FALSE.
    D2D1_GAMMATRANSFER_PROP_BLUE_DISABLE    = 0x0000000b,
    ///The amplitude of the gamma transfer function for the Alpha channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_ALPHA_AMPLITUDE = 0x0000000c,
    ///The exponent of the gamma transfer function for the Alpha channel. The type is FLOAT. The default value is 1.0f.
    D2D1_GAMMATRANSFER_PROP_ALPHA_EXPONENT  = 0x0000000d,
    ///The offset of the gamma transfer function for the Alpha channel. The type is FLOAT. The default value is 0.0f.
    D2D1_GAMMATRANSFER_PROP_ALPHA_OFFSET    = 0x0000000e,
    ///If you set this to TRUE it does not apply the transfer function to the Alpha channel. An identity transfer
    ///function is used. If you set this to FALSE it applies the gamma transfer function to the Alpha channel. The type
    ///is BOOL. The default value is FALSE.
    D2D1_GAMMATRANSFER_PROP_ALPHA_DISABLE   = 0x0000000f,
    ///Whether the effect clamps color values to between 0 and 1 before the effect passes the values to the next effect
    ///in the graph. The effect clamps the values before it premultiplies the alpha. If you set this to TRUE the effect
    ///will clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects
    ///and the output surface may clamp the values if they are not of high enough precision. The type is BOOL. The
    ///default value is FALSE.
    D2D1_GAMMATRANSFER_PROP_CLAMP_OUTPUT    = 0x00000010,
    D2D1_GAMMATRANSFER_PROP_FORCE_DWORD     = 0xffffffff,
}

///Identifiers for properties of the Table transfer effect.
alias D2D1_TABLETRANSFER_PROP = uint;
enum : uint
{
    ///The list of values used to define the transfer function for the Red channel. The type is FLOAT[]. The default is
    ///{0.0f, 1.0f}.
    D2D1_TABLETRANSFER_PROP_RED_TABLE     = 0x00000000,
    ///If you set this to TRUE the effect does not apply the transfer function to the Red channel. If you set this to
    ///FALSE it applies the RedTableTransfer function to the Red channel. The type is BOOL. The default is FALSE.
    D2D1_TABLETRANSFER_PROP_RED_DISABLE   = 0x00000001,
    ///The list of values used to define the transfer function for the Green channel. The type is FLOAT[]. The default
    ///is {0.0f, 1.0f}.
    D2D1_TABLETRANSFER_PROP_GREEN_TABLE   = 0x00000002,
    ///If you set this to TRUE the effect does not apply the transfer function to the Green channel. If you set this to
    ///FALSE it applies the GreenTableTransfer function to the Green channel. The type is BOOL. The default is FALSE.
    D2D1_TABLETRANSFER_PROP_GREEN_DISABLE = 0x00000003,
    ///The list of values used to define the transfer function for the Blue channel. The type is FLOAT[]. The default is
    ///{0.0f, 1.0f}.
    D2D1_TABLETRANSFER_PROP_BLUE_TABLE    = 0x00000004,
    ///If you set this to TRUE the effect does not apply the transfer function to the Blue channel. If you set this to
    ///FALSE it applies the BlueTableTransfer function to the Blue channel. The type is BOOL. The default is FALSE.
    D2D1_TABLETRANSFER_PROP_BLUE_DISABLE  = 0x00000005,
    ///The list of values used to define the transfer function for the Alpha channel. The type is FLOAT[]. The default
    ///is {0.0f, 1.0f}.
    D2D1_TABLETRANSFER_PROP_ALPHA_TABLE   = 0x00000006,
    ///If you set this to TRUE the effect does not apply the transfer function to the Alpha channel. If you set this to
    ///FALSE it applies the AlphaTableTransfer function to the Alpha channel. The type is BOOL. The default is FALSE.
    D2D1_TABLETRANSFER_PROP_ALPHA_DISABLE = 0x00000007,
    ///Whether the effect clamps color values to between 0 and 1 before the effect passes the values to the next effect
    ///in the graph. The effect clamps the values before it premultiplies the alpha. If you set this to TRUE the effect
    ///will clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects
    ///and the output surface may clamp the values if they are not of high enough precision. The type is BOOL. The
    ///default is FALSE.
    D2D1_TABLETRANSFER_PROP_CLAMP_OUTPUT  = 0x00000008,
    D2D1_TABLETRANSFER_PROP_FORCE_DWORD   = 0xffffffff,
}

///Identifiers for properties of the Discrete transfer effect.
alias D2D1_DISCRETETRANSFER_PROP = uint;
enum : uint
{
    ///The list of values used to define the transfer function for the Red channel. The type is FLOAT[]. The default
    ///value is {0.0f, 1.0f}.
    D2D1_DISCRETETRANSFER_PROP_RED_TABLE     = 0x00000000,
    ///If you set this to TRUE the effect does not apply the transfer function to the Red channel. If you set this to
    ///FALSE the effect applies the RedDiscreteTransfer function to the Red channel. The type is BOOL. The default value
    ///if FALSE.
    D2D1_DISCRETETRANSFER_PROP_RED_DISABLE   = 0x00000001,
    ///The list of values used to define the transfer function for the Green channel. The type is FLOAT[]. The default
    ///value is {0.0f, 1.0f}.
    D2D1_DISCRETETRANSFER_PROP_GREEN_TABLE   = 0x00000002,
    ///If you set this to TRUE the effect does not apply the transfer function to the Green channel. If you set this to
    ///FALSE the effect applies the GreenDiscreteTransfer function to the Green channel. The type is BOOL. The default
    ///value if FALSE.
    D2D1_DISCRETETRANSFER_PROP_GREEN_DISABLE = 0x00000003,
    ///The list of values used to define the transfer function for the Blue channel. The type is FLOAT[]. The default
    ///value is {0.0f, 1.0f}.
    D2D1_DISCRETETRANSFER_PROP_BLUE_TABLE    = 0x00000004,
    ///If you set this to TRUE the effect does not apply the transfer function to the Blue channel. If you set this to
    ///FALSE the effect applies the BlueDiscreteTransfer function to the Blue channel. The type is BOOL. The default
    ///value if FALSE.
    D2D1_DISCRETETRANSFER_PROP_BLUE_DISABLE  = 0x00000005,
    ///The list of values used to define the transfer function for the Alpha channel. The type is FLOAT[]. The default
    ///value is {0.0f, 1.0f}.
    D2D1_DISCRETETRANSFER_PROP_ALPHA_TABLE   = 0x00000006,
    ///If you set this to TRUE the effect does not apply the transfer function to the Alpha channel. If you set this to
    ///FALSE the effect applies the AlphaDiscreteTransfer function to the Alpha channel. The type is BOOL. The default
    ///value if FALSE.
    D2D1_DISCRETETRANSFER_PROP_ALPHA_DISABLE = 0x00000007,
    ///Whether the effect clamps color values to between 0 and 1 before the effect passes the values to the next effect
    ///in the graph. The effect clamps the values before it premultiplies the alpha. If you set this to TRUE the effect
    ///will clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects
    ///and the output surface may clamp the values if they are not of high enough precision. The type is BOOL. The
    ///default value if FALSE.
    D2D1_DISCRETETRANSFER_PROP_CLAMP_OUTPUT  = 0x00000008,
    D2D1_DISCRETETRANSFER_PROP_FORCE_DWORD   = 0xffffffff,
}

///Identifiers for properties of the Convolve matrix effect.
alias D2D1_CONVOLVEMATRIX_PROP = uint;
enum : uint
{
    ///The size of one unit in the kernel. The units are in (DIPs/kernel unit), where a kernel unit is the size of the
    ///element in the convolution kernel. A value of 1 (DIP/kernel unit) corresponds to one pixel in a image at 96 DPI.
    ///The type is FLOAT. The default value is 1.0f.
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_UNIT_LENGTH = 0x00000000,
    ///The interpolation mode the effect uses to scale the image to the corresponding kernel unit length. There are six
    ///scale modes that range in quality and speed. The type is D2D1_CONVOLVEMATRIX_SCALE_MODE. The default value is
    ///D2D1_CONVOLVEMATRIX_SCALE_MODE_LINEAR.
    D2D1_CONVOLVEMATRIX_PROP_SCALE_MODE         = 0x00000001,
    ///The width of the kernel matrix. The units are specified in kernel units. The type is UINT32. The default value is
    ///3.
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_X      = 0x00000002,
    ///The height of the kernel matrix. The units are specified in kernel units. The type is UINT32. The default value
    ///is 3.
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_Y      = 0x00000003,
    ///The kernel matrix to be applied to the image. The kernel elements aren't bounded and are specified as floats. The
    ///first set of KernelSizeX numbers in the FLOAT[] corresponds to the first row in the kernel. The second set of
    ///KernelSizeX numbers correspond to the second row, and so on up to KernelSizeY rows. The type is FLOAT[]. The
    ///default value is {0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f}.
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_MATRIX      = 0x00000004,
    ///The kernel matrix is applied to a pixel and then the result is divided by this value. 0 behaves as a value of
    ///float epsilon. The type is FLOAT. The default value is 1.0f.
    D2D1_CONVOLVEMATRIX_PROP_DIVISOR            = 0x00000005,
    ///The effect applies the kernel matrix, the divisor, and then the bias is added to the result. The bias is
    ///unbounded and unitless. The type is FLOAT. The default value is 0.0f.
    D2D1_CONVOLVEMATRIX_PROP_BIAS               = 0x00000006,
    ///Shifts the convolution kernel from a centered position on the output pixel to a position you specify left/right
    ///and up/down. The offset is defined in kernel units. With some offsets and kernel sizes, the convolution
    ///kernel’s samples won't land on a pixel image center. The pixel values for the kernel sample are computed by
    ///bilinear interpolation. The type is D2D1_VECTOR_2F. The default value is {0.0f, 0.0f}.
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_OFFSET      = 0x00000007,
    ///Specifies whether the convolution kernel is applied to the alpha channel or only the color channels. If you set
    ///this to TRUE the convolution kernel is applied only to the color channels. If you set this to FALSE the
    ///convolution kernel is applied to all channels. The type is BOOL. The default value is FALSE.
    D2D1_CONVOLVEMATRIX_PROP_PRESERVE_ALPHA     = 0x00000008,
    ///The mode used to calculate the border of the image, soft or hard. The type is D2D1_BORDER_MODE. The default value
    ///is D2D1_BORDER_MODE_SOFT.
    D2D1_CONVOLVEMATRIX_PROP_BORDER_MODE        = 0x00000009,
    ///Whether the effect clamps color values to between 0 and 1 before the effect passes the values to the next effect
    ///in the graph. The effect clamps the values before it premultiplies the alpha. If you set this to TRUE the effect
    ///will clamp the values. If you set this to FALSE, the effect will not clamp the color values, but other effects
    ///and the output surface may clamp the values if they are not of high enough precision. The type is BOOL. The
    ///default value is FALSE.
    D2D1_CONVOLVEMATRIX_PROP_CLAMP_OUTPUT       = 0x0000000a,
    D2D1_CONVOLVEMATRIX_PROP_FORCE_DWORD        = 0xffffffff,
}

///The interpolation mode the Convolve matrix effect uses to scale the image to the corresponding kernel unit length.
///There are six scale modes that range in quality and speed.
alias D2D1_CONVOLVEMATRIX_SCALE_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_CONVOLVEMATRIX_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode outputs a higher quality image than nearest neighbor
    ///mode.
    D2D1_CONVOLVEMATRIX_SCALE_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_CONVOLVEMATRIX_SCALE_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_CONVOLVEMATRIX_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_CONVOLVEMATRIX_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_CONVOLVEMATRIX_SCALE_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for the properties of the Brightness effect.
alias D2D1_BRIGHTNESS_PROP = uint;
enum : uint
{
    ///The upper portion of the brightness transfer curve. The white point adjusts the appearance of the brighter
    ///portions of the image. This property is for both the x value and the y value, in that order. Each of the values
    ///of this property are between 0 and 1, inclusive. The type is D2D1_VECTOR_2F. The default value is (1.0f, 1.0f).
    D2D1_BRIGHTNESS_PROP_WHITE_POINT = 0x00000000,
    ///The lower portion of the brightness transfer curve. The black point adjusts the appearance of the darker portions
    ///of the image. This property is for both the x value and the y value, in that order. Each of the values of this
    ///property are between 0 and 1, inclusive. The type is D2D1_VECTOR_2F. The default value is (0.0f, 0.0f).
    D2D1_BRIGHTNESS_PROP_BLACK_POINT = 0x00000001,
    D2D1_BRIGHTNESS_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for the properties of the Arithmetic composite effect.
alias D2D1_ARITHMETICCOMPOSITE_PROP = uint;
enum : uint
{
    ///The coefficients for the equation used to composite the two input images. The coefficients are unitless and
    ///unbounded. Type is D2D1_VECTOR_4F. Default value is {1.0f, 0.0f, 0.0f, 0.0f}.
    D2D1_ARITHMETICCOMPOSITE_PROP_COEFFICIENTS = 0x00000000,
    ///The effect clamps color values to between 0 and 1 before the effect passes the values to the next effect in the
    ///graph. If you set this to TRUE the effect will clamp the values. If you set this to FALSE, the effect will not
    ///clamp the color values, but other effects and the output surface may clamp the values if they are not of high
    ///enough precision. Type is BOOL. Default value is FALSE.
    D2D1_ARITHMETICCOMPOSITE_PROP_CLAMP_OUTPUT = 0x00000001,
    D2D1_ARITHMETICCOMPOSITE_PROP_FORCE_DWORD  = 0xffffffff,
}

///Identifiers for properties of the Crop effect.
alias D2D1_CROP_PROP = uint;
enum : uint
{
    ///The region to be cropped specified as a vector in the form (left, top, width, height). Units are in DIPs. <div
    ///class="alert"><b>Note</b> The rectangle will be truncated if it overlaps the edge boundaries of the input
    ///image.</div> <div> </div> Type is D2D1_VECTOR_4F Default value is {-FLT_MAX, -FLT_MAX, FLT_MAX, FLT_MAX}
    D2D1_CROP_PROP_RECT        = 0x00000000,
    ///Indicates how the effect handles the crop rectangle falling on fractional pixel coordinates. Type is
    ///D2D1_BORDER_MODE. Default value is D2D1_BORDER_MODE_SOFT.
    D2D1_CROP_PROP_BORDER_MODE = 0x00000001,
    D2D1_CROP_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Border effect.
alias D2D1_BORDER_PROP = uint;
enum : uint
{
    ///The edge mode in the X direction for the effect. You can set this to clamp, wrap, or mirror. The type is
    ///D2D1_BORDER_EDGE_MODE. The default value is D2D1_BORDER_EDGE_MODE_CLAMP.
    D2D1_BORDER_PROP_EDGE_MODE_X = 0x00000000,
    ///The edge mode in the Y direction for the effect. You can set this to clamp, wrap, or mirror. The type is
    ///D2D1_BORDER_EDGE_MODE. The default value is D2D1_BORDER_EDGE_MODE_CLAMP.
    D2D1_BORDER_PROP_EDGE_MODE_Y = 0x00000001,
    D2D1_BORDER_PROP_FORCE_DWORD = 0xffffffff,
}

///The edge mode for the Border effect.
alias D2D1_BORDER_EDGE_MODE = uint;
enum : uint
{
    ///Repeats the pixels from the edges of the image.
    D2D1_BORDER_EDGE_MODE_CLAMP       = 0x00000000,
    ///Uses pixels from the opposite end edge of the image.
    D2D1_BORDER_EDGE_MODE_WRAP        = 0x00000001,
    ///Reflects pixels about the edge of the image.
    D2D1_BORDER_EDGE_MODE_MIRROR      = 0x00000002,
    D2D1_BORDER_EDGE_MODE_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Morphology effect.
alias D2D1_MORPHOLOGY_PROP = uint;
enum : uint
{
    ///The morphology mode. The type is D2D1_MORPHOLOGY_MODE. The default value is D2D1_MORPHOLOGY_MODE_ERODE.
    D2D1_MORPHOLOGY_PROP_MODE        = 0x00000000,
    ///Size of the kernel in the X direction. The units are in DIPs. Values must be between 1 and 100 inclusive. The
    ///type is UINT. The default value is 1.
    D2D1_MORPHOLOGY_PROP_WIDTH       = 0x00000001,
    ///Size of the kernel in the Y direction. The units are in DIPs. Values must be between 1 and 100 inclusive. The
    ///type is UINT. The default value is 1.
    D2D1_MORPHOLOGY_PROP_HEIGHT      = 0x00000002,
    D2D1_MORPHOLOGY_PROP_FORCE_DWORD = 0xffffffff,
}

///The mode for the Morphology effect.
alias D2D1_MORPHOLOGY_MODE = uint;
enum : uint
{
    ///The maximum value from each RGB channel in the kernel is used.
    D2D1_MORPHOLOGY_MODE_ERODE       = 0x00000000,
    ///The minimum value from each RGB channel in the kernel is used.
    D2D1_MORPHOLOGY_MODE_DILATE      = 0x00000001,
    D2D1_MORPHOLOGY_MODE_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Tile effect.
alias D2D1_TILE_PROP = uint;
enum : uint
{
    ///The region of the image to be tiled. This property is a D2D1_VECTOR_4F defined as: (left, top, right, bottom).
    ///The units are in DIPs. The type is D2D1_VECTOR_4F. The default is {0.0f, 0.0f, 100.0f, 100.0f}.
    D2D1_TILE_PROP_RECT        = 0x00000000,
    D2D1_TILE_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Atlas effect.
alias D2D1_ATLAS_PROP = uint;
enum : uint
{
    ///The portion of the image passed to the next effect. Type is D2D1_VECTOR_4F. Default value is (-FLT_MAX, -FLT_MAX,
    ///FLT_MAX, FLT_MAX).
    D2D1_ATLAS_PROP_INPUT_RECT         = 0x00000000,
    ///The maximum size sampled for the output rectangle. Type is D2D1_VECTOR_4F. Default value is (-FLT_MAX, -FLT_MAX,
    ///FLT_MAX, FLT_MAX).
    D2D1_ATLAS_PROP_INPUT_PADDING_RECT = 0x00000001,
    D2D1_ATLAS_PROP_FORCE_DWORD        = 0xffffffff,
}

///Identifiers for properties of the Opacity metadata effect.
alias D2D1_OPACITYMETADATA_PROP = uint;
enum : uint
{
    ///The portion of the source image that is opaque. The default is the entire input image. The type is
    ///D2D1_VECTOR_4F. The default is {-FLT_MAX, -FLT_MAX, FLT_MAX, FLT_MAX}.
    D2D1_OPACITYMETADATA_PROP_INPUT_OPAQUE_RECT = 0x00000000,
    D2D1_OPACITYMETADATA_PROP_FORCE_DWORD       = 0xffffffff,
}

///Specifies the types of properties supported by the Direct2D property interface.
alias D2D1_PROPERTY_TYPE = uint;
enum : uint
{
    ///An unknown property.
    D2D1_PROPERTY_TYPE_UNKNOWN       = 0x00000000,
    ///An arbitrary-length string.
    D2D1_PROPERTY_TYPE_STRING        = 0x00000001,
    ///A 32-bit integer value constrained to be either 0 or 1.
    D2D1_PROPERTY_TYPE_BOOL          = 0x00000002,
    ///An unsigned 32-bit integer.
    D2D1_PROPERTY_TYPE_UINT32        = 0x00000003,
    ///A signed 32-bit integer.
    D2D1_PROPERTY_TYPE_INT32         = 0x00000004,
    ///A 32-bit float.
    D2D1_PROPERTY_TYPE_FLOAT         = 0x00000005,
    ///Two 32-bit float values.
    D2D1_PROPERTY_TYPE_VECTOR2       = 0x00000006,
    ///Three 32-bit float values.
    D2D1_PROPERTY_TYPE_VECTOR3       = 0x00000007,
    ///Four 32-bit float values.
    D2D1_PROPERTY_TYPE_VECTOR4       = 0x00000008,
    ///An arbitrary number of bytes.
    D2D1_PROPERTY_TYPE_BLOB          = 0x00000009,
    ///A returned COM or nano-COM interface.
    D2D1_PROPERTY_TYPE_IUNKNOWN      = 0x0000000a,
    ///An enumeration. The value should be treated as a <b>UINT32</b> with a defined array of fields to specify the
    ///bindings to human-readable strings.
    D2D1_PROPERTY_TYPE_ENUM          = 0x0000000b,
    ///An enumeration. The value is the count of sub-properties in the array. The set of array elements will be
    ///contained in the sub-property.
    D2D1_PROPERTY_TYPE_ARRAY         = 0x0000000c,
    ///A CLSID.
    D2D1_PROPERTY_TYPE_CLSID         = 0x0000000d,
    ///A 3x2 matrix of float values.
    D2D1_PROPERTY_TYPE_MATRIX_3X2    = 0x0000000e,
    ///A 4x2 matrix of float values.
    D2D1_PROPERTY_TYPE_MATRIX_4X3    = 0x0000000f,
    ///A 4x4 matrix of float values.
    D2D1_PROPERTY_TYPE_MATRIX_4X4    = 0x00000010,
    ///A 5x4 matrix of float values.
    D2D1_PROPERTY_TYPE_MATRIX_5X4    = 0x00000011,
    ///A nano-COM color context interface pointer.
    D2D1_PROPERTY_TYPE_COLOR_CONTEXT = 0x00000012,
    D2D1_PROPERTY_TYPE_FORCE_DWORD   = 0xffffffff,
}

///Specifies the indices of the system properties present on the ID2D1Properties interface for an ID2D1Effect.
alias D2D1_PROPERTY = uint;
enum : uint
{
    ///The CLSID of the effect.
    D2D1_PROPERTY_CLSID       = 0x80000000,
    ///The name of the effect.
    D2D1_PROPERTY_DISPLAYNAME = 0x80000001,
    ///The author of the effect.
    D2D1_PROPERTY_AUTHOR      = 0x80000002,
    ///The category of the effect.
    D2D1_PROPERTY_CATEGORY    = 0x80000003,
    ///The description of the effect.
    D2D1_PROPERTY_DESCRIPTION = 0x80000004,
    ///The names of the effect's inputs.
    D2D1_PROPERTY_INPUTS      = 0x80000005,
    ///The output of the effect should be cached.
    D2D1_PROPERTY_CACHED      = 0x80000006,
    ///The buffer precision of the effect output.
    D2D1_PROPERTY_PRECISION   = 0x80000007,
    ///The minimum number of inputs supported by the effect.
    D2D1_PROPERTY_MIN_INPUTS  = 0x80000008,
    ///The maximum number of inputs supported by the effect.
    D2D1_PROPERTY_MAX_INPUTS  = 0x80000009,
    D2D1_PROPERTY_FORCE_DWORD = 0xffffffff,
}

///Specifies the indices of the system sub-properties that may be present in any property.
alias D2D1_SUBPROPERTY = uint;
enum : uint
{
    ///The name for the parent property.
    D2D1_SUBPROPERTY_DISPLAYNAME = 0x80000000,
    ///A Boolean indicating whether the parent property is writeable.
    D2D1_SUBPROPERTY_ISREADONLY  = 0x80000001,
    ///The minimum value that can be set to the parent property.
    D2D1_SUBPROPERTY_MIN         = 0x80000002,
    ///The maximum value that can be set to the parent property.
    D2D1_SUBPROPERTY_MAX         = 0x80000003,
    ///The default value of the parent property.
    D2D1_SUBPROPERTY_DEFAULT     = 0x80000004,
    ///An array of name/index pairs that indicate the possible values that can be set to the parent property.
    D2D1_SUBPROPERTY_FIELDS      = 0x80000005,
    ///An index sub-property used by the elements of the <b>D2D1_SUBPROPERTY_FIELDS</b> array.
    D2D1_SUBPROPERTY_INDEX       = 0x80000006,
    D2D1_SUBPROPERTY_FORCE_DWORD = 0xffffffff,
}

///Specifies how a bitmap can be used.
alias D2D1_BITMAP_OPTIONS = uint;
enum : uint
{
    ///The bitmap is created with default properties.
    D2D1_BITMAP_OPTIONS_NONE           = 0x00000000,
    ///The bitmap can be used as a device context target.
    D2D1_BITMAP_OPTIONS_TARGET         = 0x00000001,
    ///The bitmap cannot be used as an input.
    D2D1_BITMAP_OPTIONS_CANNOT_DRAW    = 0x00000002,
    ///The bitmap can be read from the CPU.
    D2D1_BITMAP_OPTIONS_CPU_READ       = 0x00000004,
    ///The bitmap works with ID2D1GdiInteropRenderTarget::GetDC. <div class="alert"><b>Note</b> This flag is not
    ///available in Windows Store apps.</div> <div> </div>
    D2D1_BITMAP_OPTIONS_GDI_COMPATIBLE = 0x00000008,
    D2D1_BITMAP_OPTIONS_FORCE_DWORD    = 0xffffffff,
}

///Used to specify the blend mode for all of the Direct2D blending operations.
alias D2D1_COMPOSITE_MODE = uint;
enum : uint
{
    ///The standard source-over-destination blend mode.
    D2D1_COMPOSITE_MODE_SOURCE_OVER         = 0x00000000,
    ///The destination is rendered over the source.
    D2D1_COMPOSITE_MODE_DESTINATION_OVER    = 0x00000001,
    ///Performs a logical clip of the source pixels against the destination pixels.
    D2D1_COMPOSITE_MODE_SOURCE_IN           = 0x00000002,
    ///The inverse of the <b>D2D1_COMPOSITE_MODE_SOURCE_IN</b> operation.
    D2D1_COMPOSITE_MODE_DESTINATION_IN      = 0x00000003,
    ///This is the logical inverse to <b>D2D1_COMPOSITE_MODE_SOURCE_IN</b>.
    D2D1_COMPOSITE_MODE_SOURCE_OUT          = 0x00000004,
    ///The is the logical inverse to <b>D2D1_COMPOSITE_MODE_DESTINATION_IN</b>.
    D2D1_COMPOSITE_MODE_DESTINATION_OUT     = 0x00000005,
    ///Writes the source pixels over the destination where there are destination pixels.
    D2D1_COMPOSITE_MODE_SOURCE_ATOP         = 0x00000006,
    ///The logical inverse of <b>D2D1_COMPOSITE_MODE_SOURCE_ATOP</b>.
    D2D1_COMPOSITE_MODE_DESTINATION_ATOP    = 0x00000007,
    ///The source is inverted with the destination.
    D2D1_COMPOSITE_MODE_XOR                 = 0x00000008,
    ///The channel components are summed.
    D2D1_COMPOSITE_MODE_PLUS                = 0x00000009,
    ///The source is copied to the destination; the destination pixels are ignored.
    D2D1_COMPOSITE_MODE_SOURCE_COPY         = 0x0000000a,
    ///Equivalent to <b>D2D1_COMPOSITE_MODE_SOURCE_COPY</b>, but pixels outside of the source bounds are unchanged.
    D2D1_COMPOSITE_MODE_BOUNDED_SOURCE_COPY = 0x0000000b,
    ///Destination colors are inverted according to a source mask.
    D2D1_COMPOSITE_MODE_MASK_INVERT         = 0x0000000c,
    D2D1_COMPOSITE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Represents the bit depth of the imaging pipeline in Direct2D.
alias D2D1_BUFFER_PRECISION = uint;
enum : uint
{
    ///The buffer precision is not specified.
    D2D1_BUFFER_PRECISION_UNKNOWN         = 0x00000000,
    ///Use 8-bit normalized integer per channel.
    D2D1_BUFFER_PRECISION_8BPC_UNORM      = 0x00000001,
    ///Use 8-bit normalized integer standard RGB data per channel.
    D2D1_BUFFER_PRECISION_8BPC_UNORM_SRGB = 0x00000002,
    ///Use 16-bit normalized integer per channel.
    D2D1_BUFFER_PRECISION_16BPC_UNORM     = 0x00000003,
    ///Use 16-bit floats per channel.
    D2D1_BUFFER_PRECISION_16BPC_FLOAT     = 0x00000004,
    ///Use 32-bit floats per channel.
    D2D1_BUFFER_PRECISION_32BPC_FLOAT     = 0x00000005,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. Do not use this value.
    D2D1_BUFFER_PRECISION_FORCE_DWORD     = 0xffffffff,
}

///Specifies how the memory to be mapped from the corresponding ID2D1Bitmap1 should be treated.
alias D2D1_MAP_OPTIONS = uint;
enum : uint
{
    D2D1_MAP_OPTIONS_NONE        = 0x00000000,
    ///Allow CPU Read access.
    D2D1_MAP_OPTIONS_READ        = 0x00000001,
    ///Allow CPU Write access.
    D2D1_MAP_OPTIONS_WRITE       = 0x00000002,
    ///Discard the previous contents of the resource when it is mapped.
    D2D1_MAP_OPTIONS_DISCARD     = 0x00000004,
    D2D1_MAP_OPTIONS_FORCE_DWORD = 0xffffffff,
}

///This is used to specify the quality of image scaling with ID2D1DeviceContext::DrawImage and with the 2D affine
///transform effect.
alias D2D1_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that exact color. This mode uses less processing time, but outputs the
    ///lowest quality image.
    D2D1_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode uses more processing time than the nearest neighbor
    ///mode, but outputs a higher quality image.
    D2D1_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_INTERPOLATION_MODE_FORCE_DWORD         = 0xffffffff,
}

///Specifies how units in Direct2D will be interpreted.
alias D2D1_UNIT_MODE = uint;
enum : uint
{
    ///Units will be interpreted as device-independent pixels (1/96").
    D2D1_UNIT_MODE_DIPS        = 0x00000000,
    ///Units will be interpreted as pixels.
    D2D1_UNIT_MODE_PIXELS      = 0x00000001,
    D2D1_UNIT_MODE_FORCE_DWORD = 0xffffffff,
}

///Defines options that should be applied to the color space.
alias D2D1_COLOR_SPACE = uint;
enum : uint
{
    ///The color space is otherwise described, such as with a color profile.
    D2D1_COLOR_SPACE_CUSTOM      = 0x00000000,
    ///The color space is sRGB.
    D2D1_COLOR_SPACE_SRGB        = 0x00000001,
    ///The color space is scRGB.
    D2D1_COLOR_SPACE_SCRGB       = 0x00000002,
    D2D1_COLOR_SPACE_FORCE_DWORD = 0xffffffff,
}

///This specifies options that apply to the device context for its lifetime.
alias D2D1_DEVICE_CONTEXT_OPTIONS = uint;
enum : uint
{
    ///The device context is created with default options.
    D2D1_DEVICE_CONTEXT_OPTIONS_NONE                               = 0x00000000,
    ///Distribute rendering work across multiple threads. Refer to Improving the performance of Direct2D apps for
    ///additional notes on the use of this flag.
    D2D1_DEVICE_CONTEXT_OPTIONS_ENABLE_MULTITHREADED_OPTIMIZATIONS = 0x00000001,
    D2D1_DEVICE_CONTEXT_OPTIONS_FORCE_DWORD                        = 0xffffffff,
}

///Defines how the world transform, dots per inch (dpi), and stroke width affect the shape of the pen used to stroke a
///primitive.
alias D2D1_STROKE_TRANSFORM_TYPE = uint;
enum : uint
{
    ///The stroke respects the currently set world transform, the dpi, and the stroke width.
    D2D1_STROKE_TRANSFORM_TYPE_NORMAL      = 0x00000000,
    ///The stroke does not respect the world transform but it does respect the dpi and stroke width.
    D2D1_STROKE_TRANSFORM_TYPE_FIXED       = 0x00000001,
    ///The stroke is forced to 1 pixel wide (in device space) and does not respect the world transform, the dpi, or the
    ///stroke width.
    D2D1_STROKE_TRANSFORM_TYPE_HAIRLINE    = 0x00000002,
    D2D1_STROKE_TRANSFORM_TYPE_FORCE_DWORD = 0xffffffff,
}

///Used to specify the geometric blend mode for all Direct2D primitives.
alias D2D1_PRIMITIVE_BLEND = uint;
enum : uint
{
    ///The standard source-over-destination blend mode.
    D2D1_PRIMITIVE_BLEND_SOURCE_OVER = 0x00000000,
    ///The source is copied to the destination; the destination pixels are ignored.
    D2D1_PRIMITIVE_BLEND_COPY        = 0x00000001,
    ///The resulting pixel values use the minimum of the source and destination pixel values. Available in Windows 8 and
    ///later.
    D2D1_PRIMITIVE_BLEND_MIN         = 0x00000002,
    ///The resulting pixel values are the sum of the source and destination pixel values. Available in Windows 8 and
    ///later.
    D2D1_PRIMITIVE_BLEND_ADD         = 0x00000003,
    ///The resulting pixel values use the maximum of the source and destination pixel values. Available in Windows 10
    ///and later (set using ID21CommandSink4::SetPrimitiveBlend2).
    D2D1_PRIMITIVE_BLEND_MAX         = 0x00000004,
    D2D1_PRIMITIVE_BLEND_FORCE_DWORD = 0xffffffff,
}

///Specifies the threading mode used while simultaneously creating the device, factory, and device context.
alias D2D1_THREADING_MODE = uint;
enum : uint
{
    ///Resources may only be invoked serially. Device context state is not protected from multi-threaded access.
    D2D1_THREADING_MODE_SINGLE_THREADED = 0x00000000,
    ///Resources may be invoked from multiple threads. Resources use interlocked reference counting and their state is
    ///protected.
    D2D1_THREADING_MODE_MULTI_THREADED  = 0x00000001,
    D2D1_THREADING_MODE_FORCE_DWORD     = 0xffffffff,
}

///Defines how to interpolate between colors.
alias D2D1_COLOR_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Colors are interpolated with straight alpha.
    D2D1_COLOR_INTERPOLATION_MODE_STRAIGHT      = 0x00000000,
    ///Colors are interpolated with premultiplied alpha.
    D2D1_COLOR_INTERPOLATION_MODE_PREMULTIPLIED = 0x00000001,
    D2D1_COLOR_INTERPOLATION_MODE_FORCE_DWORD   = 0xffffffff,
}

///Specifies how the layer contents should be prepared.
alias D2D1_LAYER_OPTIONS1 = uint;
enum : uint
{
    ///Default layer behavior. A premultiplied layer target is pushed and its contents are cleared to transparent black.
    D2D1_LAYER_OPTIONS1_NONE                       = 0x00000000,
    ///The layer is not cleared to transparent black.
    D2D1_LAYER_OPTIONS1_INITIALIZE_FROM_BACKGROUND = 0x00000001,
    ///The layer is always created as ignore alpha. All content rendered into the layer will be treated as opaque.
    D2D1_LAYER_OPTIONS1_IGNORE_ALPHA               = 0x00000002,
    D2D1_LAYER_OPTIONS1_FORCE_DWORD                = 0xffffffff,
}

///Defines when font resources should be subset during printing.
alias D2D1_PRINT_FONT_SUBSET_MODE = uint;
enum : uint
{
    ///Uses a heuristic strategy to decide when to subset fonts. > [!NOTE] > If the print driver has requested
    ///archive-optimized content, then Direct2D will subset fonts once, for the entire document.
    D2D1_PRINT_FONT_SUBSET_MODE_DEFAULT     = 0x00000000,
    ///Subsets and embeds font resources in each page, then discards that font subset after the page is printed out.
    D2D1_PRINT_FONT_SUBSET_MODE_EACHPAGE    = 0x00000001,
    ///Sends out the original font resources without subsetting along with the page that first uses the font, and
    ///re-uses the font resources for later pages without resending them.
    D2D1_PRINT_FONT_SUBSET_MODE_NONE        = 0x00000002,
    ///A value that's guaranteed to be a DWORD.
    D2D1_PRINT_FONT_SUBSET_MODE_FORCE_DWORD = 0xffffffff,
}

///Describes flags that influence how the renderer interacts with a custom vertex shader.
alias D2D1_CHANGE_TYPE = uint;
enum : uint
{
    ///There were no changes.
    D2D1_CHANGE_TYPE_NONE        = 0x00000000,
    ///The properties of the effect changed.
    D2D1_CHANGE_TYPE_PROPERTIES  = 0x00000001,
    ///The context state changed.
    D2D1_CHANGE_TYPE_CONTEXT     = 0x00000002,
    ///The effect’s transform graph has changed. This happens only when an effect supports a variable input count.
    D2D1_CHANGE_TYPE_GRAPH       = 0x00000003,
    D2D1_CHANGE_TYPE_FORCE_DWORD = 0xffffffff,
}

///Indicates how pixel shader sampling will be restricted. This indicates whether the vertex buffer is large and tends
///to change infrequently or smaller and changes frequently (typically frame over frame).
alias D2D1_PIXEL_OPTIONS = uint;
enum : uint
{
    ///The pixel shader is not restricted in its sampling.
    D2D1_PIXEL_OPTIONS_NONE             = 0x00000000,
    ///The pixel shader samples inputs only at the same scene coordinate as the output pixel and returns transparent
    ///black whenever the input pixels are also transparent black.
    D2D1_PIXEL_OPTIONS_TRIVIAL_SAMPLING = 0x00000001,
    D2D1_PIXEL_OPTIONS_FORCE_DWORD      = 0xffffffff,
}

///Describes flags that influence how the renderer interacts with a custom vertex shader.
alias D2D1_VERTEX_OPTIONS = uint;
enum : uint
{
    ///The logical equivalent of having no flags set.
    D2D1_VERTEX_OPTIONS_NONE              = 0x00000000,
    ///If this flag is set, the renderer assumes that the vertex shader will cover the entire region of interest with
    ///vertices and need not clear the destination render target. If this flag is not set, the renderer assumes that the
    ///vertices do not cover the entire region interest and must clear the render target to transparent black first.
    D2D1_VERTEX_OPTIONS_DO_NOT_CLEAR      = 0x00000001,
    ///The renderer will use a depth buffer when rendering custom vertices. The depth buffer will be used for
    ///calculating occlusion information. This can result in the renderer output being draw-order dependent if it
    ///contains transparency.
    D2D1_VERTEX_OPTIONS_USE_DEPTH_BUFFER  = 0x00000002,
    ///Indicates that custom vertices do not overlap each other.
    D2D1_VERTEX_OPTIONS_ASSUME_NO_OVERLAP = 0x00000004,
    D2D1_VERTEX_OPTIONS_FORCE_DWORD       = 0xffffffff,
}

///Indicates whether the vertex buffer changes infrequently or frequently.
alias D2D1_VERTEX_USAGE = uint;
enum : uint
{
    ///The created vertex buffer is updated infrequently.
    D2D1_VERTEX_USAGE_STATIC      = 0x00000000,
    ///The created vertex buffer is changed frequently.
    D2D1_VERTEX_USAGE_DYNAMIC     = 0x00000001,
    D2D1_VERTEX_USAGE_FORCE_DWORD = 0xffffffff,
}

///Specifies the blend operation on two color sources.
alias D2D1_BLEND_OPERATION = uint;
enum : uint
{
    ///Add source 1 and source 2.
    D2D1_BLEND_OPERATION_ADD          = 0x00000001,
    ///Subtract source 1 from source 2.
    D2D1_BLEND_OPERATION_SUBTRACT     = 0x00000002,
    ///Subtract source 2 from source 1.
    D2D1_BLEND_OPERATION_REV_SUBTRACT = 0x00000003,
    ///Find the minimum of source 1 and source 2.
    D2D1_BLEND_OPERATION_MIN          = 0x00000004,
    ///Find the maximum of source 1 and source 2.
    D2D1_BLEND_OPERATION_MAX          = 0x00000005,
    ///A value guaranteed to be a DWORD.
    D2D1_BLEND_OPERATION_FORCE_DWORD  = 0xffffffff,
}

///Specifies how one of the color sources is to be derived and optionally specifies a preblend operation on the color
///source.
alias D2D1_BLEND = uint;
enum : uint
{
    ///The data source is black (0, 0, 0, 0). There is no preblend operation.
    D2D1_BLEND_ZERO             = 0x00000001,
    ///The data source is white (1, 1, 1, 1). There is no preblend operation.
    D2D1_BLEND_ONE              = 0x00000002,
    ///The data source is color data (RGB) from the second input of the blend transform. There is not a preblend
    ///operation.
    D2D1_BLEND_SRC_COLOR        = 0x00000003,
    ///The data source is color data (RGB) from second input of the blend transform. The preblend operation inverts the
    ///data, generating 1 - RGB.
    D2D1_BLEND_INV_SRC_COLOR    = 0x00000004,
    ///The data source is alpha data (A) from second input of the blend transform. There is no preblend operation.
    D2D1_BLEND_SRC_ALPHA        = 0x00000005,
    ///The data source is alpha data (A) from the second input of the blend transform. The preblend operation inverts
    ///the data, generating 1 - A.
    D2D1_BLEND_INV_SRC_ALPHA    = 0x00000006,
    ///The data source is alpha data (A) from the first input of the blend transform. There is no preblend operation.
    D2D1_BLEND_DEST_ALPHA       = 0x00000007,
    ///The data source is alpha data (A) from the first input of the blend transform. The preblend operation inverts the
    ///data, generating 1 - A.
    D2D1_BLEND_INV_DEST_ALPHA   = 0x00000008,
    ///The data source is color data from the first input of the blend transform. There is no preblend operation.
    D2D1_BLEND_DEST_COLOR       = 0x00000009,
    ///The data source is color data from the first input of the blend transform. The preblend operation inverts the
    ///data, generating 1 - RGB.
    D2D1_BLEND_INV_DEST_COLOR   = 0x0000000a,
    ///The data source is alpha data from the second input of the blend transform. The preblend operation clamps the
    ///data to 1 or less.
    D2D1_BLEND_SRC_ALPHA_SAT    = 0x0000000b,
    ///The data source is the blend factor. There is no preblend operation.
    D2D1_BLEND_BLEND_FACTOR     = 0x0000000e,
    ///The data source is the blend factor. The preblend operation inverts the blend factor, generating 1 -
    ///blend_factor.
    D2D1_BLEND_INV_BLEND_FACTOR = 0x0000000f,
    D2D1_BLEND_FORCE_DWORD      = 0xffffffff,
}

///Allows a caller to control the channel depth of a stage in the rendering pipeline.
alias D2D1_CHANNEL_DEPTH = uint;
enum : uint
{
    ///The channel depth is the default. It is inherited from the inputs.
    D2D1_CHANNEL_DEPTH_DEFAULT     = 0x00000000,
    ///The channel depth is 1.
    D2D1_CHANNEL_DEPTH_1           = 0x00000001,
    ///The channel depth is 4.
    D2D1_CHANNEL_DEPTH_4           = 0x00000004,
    D2D1_CHANNEL_DEPTH_FORCE_DWORD = 0xffffffff,
}

///Represents filtering modes that a transform may select to use on input textures.
alias D2D1_FILTER = uint;
enum : uint
{
    ///Use point sampling for minification, magnification, and mip-level sampling.
    D2D1_FILTER_MIN_MAG_MIP_POINT               = 0x00000000,
    ///Use point sampling for minification and magnification; use linear interpolation for mip-level sampling.
    D2D1_FILTER_MIN_MAG_POINT_MIP_LINEAR        = 0x00000001,
    ///Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level
    ///sampling.
    D2D1_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT  = 0x00000004,
    ///Use point sampling for minification; use linear interpolation for magnification and mip-level sampling.
    D2D1_FILTER_MIN_POINT_MAG_MIP_LINEAR        = 0x00000005,
    ///Use linear interpolation for minification; use point sampling for magnification and mip-level sampling.
    D2D1_FILTER_MIN_LINEAR_MAG_MIP_POINT        = 0x00000010,
    ///Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for
    ///mip-level sampling.
    D2D1_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 0x00000011,
    ///Use linear interpolation for minification and magnification; use point sampling for mip-level sampling.
    D2D1_FILTER_MIN_MAG_LINEAR_MIP_POINT        = 0x00000014,
    ///Use linear interpolation for minification, magnification, and mip-level sampling.
    D2D1_FILTER_MIN_MAG_MIP_LINEAR              = 0x00000015,
    ///Use anisotropic interpolation for minification, magnification, and mip-level sampling.
    D2D1_FILTER_ANISOTROPIC                     = 0x00000055,
    D2D1_FILTER_FORCE_DWORD                     = 0xffffffff,
}

///Defines capabilities of the underlying Direct3D device which may be queried using
///ID2D1EffectContext::CheckFeatureSupport.
alias D2D1_FEATURE = uint;
enum : uint
{
    ///A D2D1_FEATURE_DATA_DOUBLES structure should be filled.
    D2D1_FEATURE_DOUBLES                  = 0x00000000,
    ///A D2D1_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS structure should be filled.
    D2D1_FEATURE_D3D10_X_HARDWARE_OPTIONS = 0x00000001,
    D2D1_FEATURE_FORCE_DWORD              = 0xffffffff,
}

///Identifiers for properties of the YCbCr effect.
alias D2D1_YCBCR_PROP = uint;
enum : uint
{
    ///Specifies the chroma subsampling of the input chroma image. The type is D2D1_YCBCR_CHROMA_SUBSAMPLING. The
    ///default value is D2D1_YCBCR_CHROMA_SUBSAMPLING_AUTO.
    D2D1_YCBCR_PROP_CHROMA_SUBSAMPLING = 0x00000000,
    ///A 3x2 Matrix specifying the axis-aligned affine transform of the image. Axis aligned transforms include Scale,
    ///Flips, and 90 degree rotations. The type is D2D1_MATRIX_3X2_F. The default value is Matrix3x2F::Identity().
    D2D1_YCBCR_PROP_TRANSFORM_MATRIX   = 0x00000001,
    ///The interpolation mode. The type is D2D1_YCBCR_INTERPOLATION_MODE.
    D2D1_YCBCR_PROP_INTERPOLATION_MODE = 0x00000002,
    D2D1_YCBCR_PROP_FORCE_DWORD        = 0xffffffff,
}

///Specifies the chroma subsampling of the input chroma image used by the YCbCr effect.
alias D2D1_YCBCR_CHROMA_SUBSAMPLING = uint;
enum : uint
{
    ///This mode attempts to infer the chroma subsampling from the bounds of the input images. When this option is
    ///selected, the smaller plane is upsampled to the size of the larger plane and this effect’s output rectangle is
    ///the intersection of the two planes. When using this mode, care should be taken when applying effects to the input
    ///planes that change the image bounds, such as the border transform, so that the desired size ratio between the
    ///planes is maintained.
    D2D1_YCBCR_CHROMA_SUBSAMPLING_AUTO        = 0x00000000,
    ///The chroma plane is horizontally subsampled by 1/2 and vertically subsampled by 1/2. When this option is
    ///selected, the chroma plane is horizontally and vertically upsampled by 2x and this effect's output rectangle is
    ///the intersection of the two planes.
    D2D1_YCBCR_CHROMA_SUBSAMPLING_420         = 0x00000001,
    ///The chroma plane is horizontally subsampled by 1/2. When this option is selected, the chroma plane is
    ///horizontally upsampled by 2x and this effect's output rectangle is the intersection of the two planes.
    D2D1_YCBCR_CHROMA_SUBSAMPLING_422         = 0x00000002,
    ///The chroma plane is not subsampled. When this option is selected this effect’s output rectangle is the
    ///intersection of the two planes.
    D2D1_YCBCR_CHROMA_SUBSAMPLING_444         = 0x00000003,
    ///The chroma plane is vertically subsampled by 1/2. When this option is selected, the chroma plane is vertically
    ///upsampled by 2x and this effect's output rectangle is the intersection of the two planes.
    D2D1_YCBCR_CHROMA_SUBSAMPLING_440         = 0x00000004,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_FORCE_DWORD = 0xffffffff,
}

///Specifies the interpolation mode for the YCbCr effect.
alias D2D1_YCBCR_INTERPOLATION_MODE = uint;
enum : uint
{
    ///Samples the nearest single point and uses that. This mode uses less processing time, but outputs the lowest
    ///quality image.
    D2D1_YCBCR_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Uses a four point sample and linear interpolation. This mode uses more processing time than the nearest neighbor
    ///mode, but outputs a higher quality image.
    D2D1_YCBCR_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    ///Uses a 16 sample cubic kernel for interpolation. This mode uses the most processing time, but outputs a higher
    ///quality image.
    D2D1_YCBCR_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    ///Uses 4 linear samples within a single pixel for good edge anti-aliasing. This mode is good for scaling down by
    ///small amounts on images with few pixels.
    D2D1_YCBCR_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Uses anisotropic filtering to sample a pattern according to the transformed shape of the bitmap.
    D2D1_YCBCR_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    ///Uses a variable size high quality cubic kernel to perform a pre-downscale the image if downscaling is involved in
    ///the transform matrix. Then uses the cubic interpolation mode for the final output.
    D2D1_YCBCR_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
    D2D1_YCBCR_INTERPOLATION_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Contrast effect.
alias D2D1_CONTRAST_PROP = uint;
enum : uint
{
    ///The D2D1_CONTRAST_PROP_CONTRAST property is a float value indicating the amount by which to adjust the contrast
    ///of the image. Negative values reduce contrast, while positive values increase contrast. Minimum value is -1.0f,
    ///maximum value is 1.0f. The default value for the property is 0.0f.
    D2D1_CONTRAST_PROP_CONTRAST    = 0x00000000,
    ///The D2D1_CONTRAST_PROP_CLAMP_INPUT property is a boolean value indicating whether or not to clamp the input to
    ///[0.0, 1.0]. The default value for the property is FALSE.
    D2D1_CONTRAST_PROP_CLAMP_INPUT = 0x00000001,
    D2D1_CONTRAST_PROP_FORCE_DWORD = 0xffffffff,
}

///Indentifiers for properties of the RGB to Hue effect.
alias D2D1_RGBTOHUE_PROP = uint;
enum : uint
{
    ///The D2D1_RGBTOHUE_PROP_OUTPUT_COLOR_SPACE property is an enumeration value which indicates the color space to
    ///convert to. The default value for the property is D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_VALUE. See the
    ///D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE enumeration for more information.
    D2D1_RGBTOHUE_PROP_OUTPUT_COLOR_SPACE = 0x00000000,
    D2D1_RGBTOHUE_PROP_FORCE_DWORD        = 0xffffffff,
}

///Values for the D2D1_RGBTOHUE_PROP_OUTPUT_COLOR_SPACE property of the RGB to Hue effect.
alias D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE = uint;
enum : uint
{
    ///The effect converts from RGB to Hue Saturation Value (HSV).
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_VALUE     = 0x00000000,
    ///The effect converts from RGB to Hue Saturation Lightness (HSL).
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS = 0x00000001,
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_FORCE_DWORD              = 0xffffffff,
}

///Identifiers for properties of the Hue to RGB effect.
alias D2D1_HUETORGB_PROP = uint;
enum : uint
{
    ///The D2D1_HUETORGB_PROP_INPUT_COLOR_SPACE property is an enumeration value which indicates which color space to
    ///convert from. The default value for the property is D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_VALUE. See
    ///D2D1_HUETORGB_INPUT_COLOR_SPACE enumeration for more information.
    D2D1_HUETORGB_PROP_INPUT_COLOR_SPACE = 0x00000000,
    D2D1_HUETORGB_PROP_FORCE_DWORD       = 0xffffffff,
}

///Values for the D2D1_HUETORGB_PROP_INPUT_COLOR_SPACE property of the Hue to RGB effect.
alias D2D1_HUETORGB_INPUT_COLOR_SPACE = uint;
enum : uint
{
    ///The effect converts from Hue Saturation Value (HSV) to RGB.
    D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_VALUE     = 0x00000000,
    ///The effect converts from Hue Saturation Lightness (HSL) to RGB.
    D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS = 0x00000001,
    D2D1_HUETORGB_INPUT_COLOR_SPACE_FORCE_DWORD              = 0xffffffff,
}

///Identifiers for properties of the Chroma-key effect.
alias D2D1_CHROMAKEY_PROP = uint;
enum : uint
{
    ///The D2D1_CHROMAKEY_PROP_COLOR property is a vector4 value indicating the color that should be converted to alpha.
    ///The default color is black.
    D2D1_CHROMAKEY_PROP_COLOR        = 0x00000000,
    ///The D2D1_CHROMAKEY_PROP_TOLERANCE property is a float value indicating the tolerance for matching the color
    ///specified in the D2D1_CHROMAKEY_PROP_COLOR property. The allowed range is 0.0 to 1.0. The default value is 0.1.
    D2D1_CHROMAKEY_PROP_TOLERANCE    = 0x00000001,
    ///The D2D1_CHROMAKEY_PROP_INVERT_ALPHA property is a boolean value indicating whether the alpha values should be
    ///inverted. The default value if False.
    D2D1_CHROMAKEY_PROP_INVERT_ALPHA = 0x00000002,
    ///The D2D1_CHROMAKEY_PROP_FEATHER property is a boolean value whether the edges of the output should be softened in
    ///the alpha channel. When set to False, the alpha output by the effect is 1-bit: either fully opaque or fully
    ///transparent. Setting to True results in a softening of edges in the alpha channel of the Chroma Key output. The
    ///default value is False.
    D2D1_CHROMAKEY_PROP_FEATHER      = 0x00000003,
    D2D1_CHROMAKEY_PROP_FORCE_DWORD  = 0xffffffff,
}

///Identifiers for properties of the Emboss effect.
alias D2D1_EMBOSS_PROP = uint;
enum : uint
{
    ///The D2D1_EMBOSS_PROP_HEIGHT property is a float value controlling the strength of the embossing effect. The
    ///allowed range is 0.0 to 10.0. The default value is 1.0.
    D2D1_EMBOSS_PROP_HEIGHT      = 0x00000000,
    ///The D2D1_EMBOSS_PROP_DIRECTION property is a float value specifying the light direction used to create the
    ///effect. The allowed range is 0.0 to 360.0. The default value is 0.0.
    D2D1_EMBOSS_PROP_DIRECTION   = 0x00000001,
    D2D1_EMBOSS_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the [Exposure effect](/windows/desktop/Direct2D/exposure-effect).
alias D2D1_EXPOSURE_PROP = uint;
enum : uint
{
    ///The D2D1_EXPOSURE_PROP_EXPOSURE_VALUE property is a float value that specifies how much to increase or decrease
    ///the exposure of the image. The allowed range is -2.0 to 2.0. The default value is 0.0 (no change).
    D2D1_EXPOSURE_PROP_EXPOSURE_VALUE = 0x00000000,
    D2D1_EXPOSURE_PROP_FORCE_DWORD    = 0xffffffff,
}

///Identifiers for properties of the Posterize effect.
alias D2D1_POSTERIZE_PROP = uint;
enum : uint
{
    ///The D2D1_POSTERIZE_PROP_RED_VALUE_COUNT property is an integer value specifying how many evenly spaced steps to
    ///divide the red channel range of 0.0 to 1.0 into. For example, a value of 4 generates a table with 4 steps, [0.0,
    ///0.33, 0.67, 1.0]. The allowed range for this property is 2 to 16. The default value is 4.
    D2D1_POSTERIZE_PROP_RED_VALUE_COUNT   = 0x00000000,
    ///The D2D1_POSTERIZE_PROP_GREEN_VALUE_COUNT property is an integer value specifying how many evenly spaced steps to
    ///divide the green channel range of 0.0 to 1.0 into. For example, a value of 4 generates a table with 4 steps,
    ///[0.0, 0.33, 0.67, 1.0]. The allowed range for this property is 2 to 16. The default value is 4.
    D2D1_POSTERIZE_PROP_GREEN_VALUE_COUNT = 0x00000001,
    ///The D2D1_POSTERIZE_PROP_BLUE_VALUE_COUNT property is an integer value specifying how many evenly spaced steps to
    ///divide the blue channel range of 0.0 to 1.0 into. For example, a value of 4 generates a table with 4 steps, [0.0,
    ///0.33, 0.67, 1.0]. The allowed range for this property is 2 to 16. The default value is 4.
    D2D1_POSTERIZE_PROP_BLUE_VALUE_COUNT  = 0x00000002,
    D2D1_POSTERIZE_PROP_FORCE_DWORD       = 0xffffffff,
}

///Identifiers for properties of the Sepia effect.
alias D2D1_SEPIA_PROP = uint;
enum : uint
{
    ///The D2D1_SEPIA_PROP_INTENSITY property is a float value indicating the intesity of the sepia effect. The allowed
    ///range is 0.0 to 1.0. The default value is 0.5.
    D2D1_SEPIA_PROP_INTENSITY   = 0x00000000,
    ///The D2D1_SEPIA_PROP_ALPHA_MODE property is a D2D1_ALPHA_MODE enumeration value indicating the alpha mode of the
    ///input file. See the About Alpha Modes section of the Supported Pixel Formats and Alpha Modes topic for additional
    ///information.. The default value is D2D1_ALPHA_MODE_PREMULTIPLIED.
    D2D1_SEPIA_PROP_ALPHA_MODE  = 0x00000001,
    D2D1_SEPIA_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Sharpen effect.
alias D2D1_SHARPEN_PROP = uint;
enum : uint
{
    ///The D2D1_SHARPEN_PROP_SHARPNESS property is a float value indicating how much to sharpen the input image. The
    ///allowed range is 0.0 to 10.0. The default value is 0.0.
    D2D1_SHARPEN_PROP_SHARPNESS   = 0x00000000,
    ///The D2D1_SHARPEN_PROP_THRESHOLD property is a float value. The allowed range is 0.0 to 1.0. The default value is
    ///0.0.
    D2D1_SHARPEN_PROP_THRESHOLD   = 0x00000001,
    D2D1_SHARPEN_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Straighten effect.
alias D2D1_STRAIGHTEN_PROP = uint;
enum : uint
{
    ///The D2D1_STRAIGHTEN_PROP_ANGLE property is a float value that specifies how much the image should be rotated. The
    ///allowed range is -45.0 to 45.0. The default value is 0.0.
    D2D1_STRAIGHTEN_PROP_ANGLE         = 0x00000000,
    ///The D2D1_STRAIGHTEN_PROP_MAINTAIN_SIZE property is a boolean value that specifies whether the image will be
    ///scaled such that the original size is maintained without any invalid regions. The default value is True.
    D2D1_STRAIGHTEN_PROP_MAINTAIN_SIZE = 0x00000001,
    ///The D2D1_STRAIGHTEN_PROP_SCALE_MODE property is a D2D1_STRAIGHTEN_SCALE_MODE enumeration value indicating the
    ///scaling mode that should be used.
    D2D1_STRAIGHTEN_PROP_SCALE_MODE    = 0x00000002,
    D2D1_STRAIGHTEN_PROP_FORCE_DWORD   = 0xffffffff,
}

///Values for the D2D1_STRAIGHTEN_PROP_SCALE_MODE property of the Straighten effect.
alias D2D1_STRAIGHTEN_SCALE_MODE = uint;
enum : uint
{
    ///Indicates nearest neighbor interpolation should be used.
    D2D1_STRAIGHTEN_SCALE_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    ///Indicates linear interpolation should be used.
    D2D1_STRAIGHTEN_SCALE_MODE_LINEAR              = 0x00000001,
    ///Indicates cubic interpolation should be used.
    D2D1_STRAIGHTEN_SCALE_MODE_CUBIC               = 0x00000002,
    ///Indicates multi-sample linear interpolation should be used.
    D2D1_STRAIGHTEN_SCALE_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    ///Indicates anisotropic filtering should be used.
    D2D1_STRAIGHTEN_SCALE_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_STRAIGHTEN_SCALE_MODE_FORCE_DWORD         = 0xffffffff,
}

///Identifiers for properties of the Temperature and Tint effect.
alias D2D1_TEMPERATUREANDTINT_PROP = uint;
enum : uint
{
    ///The D2D1_TEMPERATUREANDTINT_PROP_TEMPERATURE property is a float value specifying how much to increase or
    ///decrease the temperature of the input image. The allowed range is -1.0 to 1.0. The default value is 0.0.
    D2D1_TEMPERATUREANDTINT_PROP_TEMPERATURE = 0x00000000,
    ///The D2D1_TEMPERATUREANDTINT_PROP_TINT property is a float value specifying how much to increase or decrease the
    ///tint of the input image. The allowed range is -1.0 to 1.0. The default value is 0.0.
    D2D1_TEMPERATUREANDTINT_PROP_TINT        = 0x00000001,
    D2D1_TEMPERATUREANDTINT_PROP_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Vignette effect.
alias D2D1_VIGNETTE_PROP = uint;
enum : uint
{
    ///The D2D1_VIGNETTE_PROP_COLOR property is an RGB tripplet that specifies the color to fade the image's edges to.
    ///The default color is black.
    D2D1_VIGNETTE_PROP_COLOR           = 0x00000000,
    ///The D2D1_VIGNETTE_PROP_TRANSITION_SIZE property is a float value that specifies the size of the vignette region
    ///as a percentage of the full image region. A size of 0 means the unfaded region is the entire image, while a size
    ///of 1 means the faded region is the entire source image. The allowed range is 0.0 to 1.0. The default value is
    ///0.1.
    D2D1_VIGNETTE_PROP_TRANSITION_SIZE = 0x00000001,
    ///The D2D1_VIGNETTE_PROP_STRENGTH property is a float value that specifies how much the vignette color bleeds in
    ///for a given transition size. The allowed range is 0.0 to 1.0. The default value is 0.5.
    D2D1_VIGNETTE_PROP_STRENGTH        = 0x00000002,
    D2D1_VIGNETTE_PROP_FORCE_DWORD     = 0xffffffff,
}

///Identifiers for properties of the Edge Detection effect.
alias D2D1_EDGEDETECTION_PROP = uint;
enum : uint
{
    ///The D2D1_EDGEDETECTION_PROP_STRENGTH property is a float value modulating the response of the edge detection
    ///filter. A low strength value means that weaker edges will get filtered out, while a high value means stronger
    ///edges will get filtered out. The allowed range is 0.0 to 1.0. The default value is 0.5.
    D2D1_EDGEDETECTION_PROP_STRENGTH      = 0x00000000,
    ///The D2D1_EDGEDETECTION_PROP_BLUR_RADIUS property is a float value specifying the amount of blur to apply.
    ///Applying blur is used to remove high frequencies and reduce phantom edges. The allowed range is 0.0 to 10.0. The
    ///default value is 0.0 (no blur applied).
    D2D1_EDGEDETECTION_PROP_BLUR_RADIUS   = 0x00000001,
    ///The D2D1_EDGEDETECTION_PROP_MODE property is a D2D1_EDGEDETECTION_MODE enumeration value which mode to use for
    ///edge detection. The default value is D2D1_EDGEDETECTION_MODE_SOBEL.
    D2D1_EDGEDETECTION_PROP_MODE          = 0x00000002,
    ///The D2D1_EDGEDETECTION_PROP_OVERLAY_EDGES property is a boolean value. Edge detection only applies to the RGB
    ///channels, the alpha channel is ignored for purposes of detecting edges. If D2D1_EDGEDETECTION_PROP_OVERLAY_EDGES
    ///is false, the output edges is fully opaque. If D2D1_EDGEDETECTION_PROP_OVERLAY_EDGES is true, the input opacity
    ///is preserved. The default value is false.
    D2D1_EDGEDETECTION_PROP_OVERLAY_EDGES = 0x00000003,
    ///The D2D1_EDGEDETECTION_PROP_ALPHA_MODE property is a D2D1_ALPHA_MODE enumeration value indicating the alpha mode
    ///of the input file. If the input is not opaque, this value is used to determine whether to unpremultiply the
    ///inputs. See the About Alpha Modes section of the Supported Pixel Formats and Alpha Modes topic for additional
    ///information. The default value is D2D1_ALPHA_MODE_PREMULTIPLIED.
    D2D1_EDGEDETECTION_PROP_ALPHA_MODE    = 0x00000004,
    D2D1_EDGEDETECTION_PROP_FORCE_DWORD   = 0xffffffff,
}

///Values for the D2D1_EDGEDETECTION_PROP_MODE property of the Edge Detection effect.
alias D2D1_EDGEDETECTION_MODE = uint;
enum : uint
{
    ///Indicates the Sobel operator should be used for edge detection.
    D2D1_EDGEDETECTION_MODE_SOBEL       = 0x00000000,
    ///Indicates the Prewitt operator should be used for edge detection.
    D2D1_EDGEDETECTION_MODE_PREWITT     = 0x00000001,
    D2D1_EDGEDETECTION_MODE_FORCE_DWORD = 0xffffffff,
}

///Identifiers for properties of the Highlights and Shadows effect.
alias D2D1_HIGHLIGHTSANDSHADOWS_PROP = uint;
enum : uint
{
    ///The D2D1_HIGHLIGHTSANDSHADOWS_PROP_HIGHLIGHTS property is a float value indicating how much to increase or
    ///decrease highlights. The allowed range is -1.0 to 1.0. The default value is 0.0.
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_HIGHLIGHTS       = 0x00000000,
    ///The D2D1_HIGHLIGHTSANDSHADOWS_PROP_SHADOWS property is a float value indicating how much to increase or decrease
    ///shadows. The allowed range is -1.0 to 1.0. The default value is 0.0.
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_SHADOWS          = 0x00000001,
    ///The D2D1_HIGHLIGHTSANDSHADOWS_PROP_CLARITY property is a float value indicating how much to increase or decrease
    ///clarity. The allowed range is -1.0 to 1.0. The default value is 0.0.
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_CLARITY          = 0x00000002,
    ///The D2D1_HIGHLIGHTSANDSHADOWS_PROP_INPUT_GAMMA property is a D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA enumeration
    ///value indicating the gamma of the input image. The Highlights and Shadows effect works in linear gamma space, so
    ///if the input image is know to be linear, the D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_LINEAR value should be used to
    ///prevent sRGB to linear conversions from being performed.
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_INPUT_GAMMA      = 0x00000003,
    ///The D2D1_HIGHLIGHTSANDSHADOWS_PROP_MASK_BLUR_RADIUS property is a float value controlling the size of the region
    ///used around a pixel to classify the pixel as highlight or shadow. Lower values result in more localized
    ///adjustments. The allowed range is 0.0 to 10.0. The default value is 1.25.
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_MASK_BLUR_RADIUS = 0x00000004,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_FORCE_DWORD      = 0xffffffff,
}

///Values for the D2D1_HIGHLIGHTSANDSHADOWS_PROP_INPUT_GAMMA property of the Highlights and Shadows effect.
alias D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA = uint;
enum : uint
{
    ///Indicates the input image is in linear gamma space.
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_LINEAR      = 0x00000000,
    ///Indicates the input image is sRGB gamma space.
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_SRGB        = 0x00000001,
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_FORCE_DWORD = 0xffffffff,
}

///Identifiers for the properties of the 3D Lookup Table effect.
alias D2D1_LOOKUPTABLE3D_PROP = uint;
enum : uint
{
    ///The D2D1_LOOKUPTABLE3D_PROP_LUT property is a pointer to an ID2D1LookupTable3D object. The default value is null.
    D2D1_LOOKUPTABLE3D_PROP_LUT         = 0x00000000,
    ///The D2D1_LOOKUPTABLE3D_PROP_ALPHA_MODE property is a D2D1_ALPHA_MODE value indicating the alpha mode of the input
    ///file. See the About Alpha Modes section of the Supported Pixel Formats and Alpha Modes topic for additional
    ///information.
    D2D1_LOOKUPTABLE3D_PROP_ALPHA_MODE  = 0x00000001,
    D2D1_LOOKUPTABLE3D_PROP_FORCE_DWORD = 0xffffffff,
}

alias D2D1_OPACITY_PROP = uint;
enum : uint
{
    D2D1_OPACITY_PROP_OPACITY     = 0x00000000,
    D2D1_OPACITY_PROP_FORCE_DWORD = 0xffffffff,
}

alias D2D1_CROSSFADE_PROP = uint;
enum : uint
{
    D2D1_CROSSFADE_PROP_WEIGHT      = 0x00000000,
    D2D1_CROSSFADE_PROP_FORCE_DWORD = 0xffffffff,
}

alias D2D1_TINT_PROP = uint;
enum : uint
{
    D2D1_TINT_PROP_COLOR        = 0x00000000,
    D2D1_TINT_PROP_CLAMP_OUTPUT = 0x00000001,
    D2D1_TINT_PROP_FORCE_DWORD  = 0xffffffff,
}

///Defines constants that identify the top level properties of the [White level adjustment
///effect](/windows/desktop/Direct2D/white-level-adjustment-effect). The effect adjusts the white level of the source
///image by multiplying the source image color by the ratio of the input and output white levels. Input and output white
///levels are specified in nits.
alias D2D1_WHITELEVELADJUSTMENT_PROP = uint;
enum : uint
{
    ///Identifies the `InputWhiteLevel` property of the effect. The property is of type FLOAT, and is specified in nits.
    D2D1_WHITELEVELADJUSTMENT_PROP_INPUT_WHITE_LEVEL  = 0x00000000,
    ///Identifies the `OutputWhiteLevel` property of the effect. The property is of type FLOAT, and is specified in
    ///nits.
    D2D1_WHITELEVELADJUSTMENT_PROP_OUTPUT_WHITE_LEVEL = 0x00000001,
    D2D1_WHITELEVELADJUSTMENT_PROP_FORCE_DWORD        = 0xffffffff,
}

///Defines constants that identify the top level properties of the [HDR tone map
///effect](/windows/desktop/Direct2D/hdr-tone-map-effect). The effect adjusts the maximum luminance of the source image
///to fit within the maximum output luminance supported. Input and output luminance values are specified in nits. Note
///that the color space of the target image is assumed to be scRGB.
alias D2D1_HDRTONEMAP_PROP = uint;
enum : uint
{
    ///Identifies the `InputMaxLuminance` property of the effect. The property is of type FLOAT, and is specified in
    ///nits.
    D2D1_HDRTONEMAP_PROP_INPUT_MAX_LUMINANCE  = 0x00000000,
    ///Identifies the `OutputMaxLuminance` property of the effect. The property is of type FLOAT, and is specified in
    ///nits.
    D2D1_HDRTONEMAP_PROP_OUTPUT_MAX_LUMINANCE = 0x00000001,
    ///Identifies the `DisplayMode` property of the effect. The property is of type
    ///<strong>D2D1_HDRTONEMAP_DISPLAY_MODE</strong>.
    D2D1_HDRTONEMAP_PROP_DISPLAY_MODE         = 0x00000002,
    D2D1_HDRTONEMAP_PROP_FORCE_DWORD          = 0xffffffff,
}

///Defines constants that specify a value for the
///[D2D1_HDRTONEMAP_PROP_DISPLAY_MODE](/windows/desktop/api/d2d1effects_2/ne-d2d1effects_2-d2d1_hdrtonemap_prop)
///property of the [HDR tone map effect](/windows/desktop/Direct2D/hdr-tone-map-effect).
alias D2D1_HDRTONEMAP_DISPLAY_MODE = uint;
enum : uint
{
    ///Specifies that the tone mapper algorithm be optimized for best appearance on a standard dynamic range (SDR)
    ///display.
    D2D1_HDRTONEMAP_DISPLAY_MODE_SDR         = 0x00000000,
    ///Specifies that the tone mapper algorithm be optimized for best appearance on a high dynamic range (HDR) display.
    D2D1_HDRTONEMAP_DISPLAY_MODE_HDR         = 0x00000001,
    D2D1_HDRTONEMAP_DISPLAY_MODE_FORCE_DWORD = 0xffffffff,
}

///The rendering priority affects the extent to which Direct2D will throttle its rendering workload.
alias D2D1_RENDERING_PRIORITY = uint;
enum : uint
{
    ///No change in rendering workload priority.
    D2D1_RENDERING_PRIORITY_NORMAL      = 0x00000000,
    ///The device and its associated device contexts are given a lower priority than others.
    D2D1_RENDERING_PRIORITY_LOW         = 0x00000001,
    D2D1_RENDERING_PRIORITY_FORCE_DWORD = 0xffffffff,
}

///Specifies the paint type for an SVG fill or stroke.
alias D2D1_SVG_PAINT_TYPE = uint;
enum : uint
{
    ///The fill or stroke is not rendered.
    D2D1_SVG_PAINT_TYPE_NONE              = 0x00000000,
    ///A solid color is rendered.
    D2D1_SVG_PAINT_TYPE_COLOR             = 0x00000001,
    ///The current color is rendered.
    D2D1_SVG_PAINT_TYPE_CURRENT_COLOR     = 0x00000002,
    ///A paint server, defined by another element in the SVG document, is used.
    D2D1_SVG_PAINT_TYPE_URI               = 0x00000003,
    ///A paint server, defined by another element in the SVG document, is used. If the paint server reference is
    ///invalid, fall back to D2D1_SVG_PAINT_TYPE_NONE.
    D2D1_SVG_PAINT_TYPE_URI_NONE          = 0x00000004,
    ///A paint server, defined by another element in the SVG document, is used. If the paint server reference is
    ///invalid, fall back to D2D1_SVG_PAINT_TYPE_COLOR.
    D2D1_SVG_PAINT_TYPE_URI_COLOR         = 0x00000005,
    ///A paint server, defined by another element in the SVG document, is used. If the paint server reference is
    ///invalid, fall back to D2D1_SVG_PAINT_TYPE_CURRENT_COLOR.
    D2D1_SVG_PAINT_TYPE_URI_CURRENT_COLOR = 0x00000006,
    D2D1_SVG_PAINT_TYPE_FORCE_DWORD       = 0xffffffff,
}

///Specifies the units for an SVG length.
alias D2D1_SVG_LENGTH_UNITS = uint;
enum : uint
{
    ///The length is unitless.
    D2D1_SVG_LENGTH_UNITS_NUMBER      = 0x00000000,
    ///The length is a percentage value.
    D2D1_SVG_LENGTH_UNITS_PERCENTAGE  = 0x00000001,
    D2D1_SVG_LENGTH_UNITS_FORCE_DWORD = 0xffffffff,
}

///Specifies a value for the SVG display property.
alias D2D1_SVG_DISPLAY = uint;
enum : uint
{
    ///The element uses the default display behavior.
    D2D1_SVG_DISPLAY_INLINE      = 0x00000000,
    ///The element and all children are not rendered directly.
    D2D1_SVG_DISPLAY_NONE        = 0x00000001,
    D2D1_SVG_DISPLAY_FORCE_DWORD = 0xffffffff,
}

///Specifies a value for the SVG visibility property.
alias D2D1_SVG_VISIBILITY = uint;
enum : uint
{
    ///The element is visible.
    D2D1_SVG_VISIBILITY_VISIBLE     = 0x00000000,
    ///The element is invisible.
    D2D1_SVG_VISIBILITY_HIDDEN      = 0x00000001,
    D2D1_SVG_VISIBILITY_FORCE_DWORD = 0xffffffff,
}

///Specifies a value for the SVG overflow property.
alias D2D1_SVG_OVERFLOW = uint;
enum : uint
{
    ///The element is not clipped to its viewport.
    D2D1_SVG_OVERFLOW_VISIBLE     = 0x00000000,
    ///The element is clipped to its viewport.
    D2D1_SVG_OVERFLOW_HIDDEN      = 0x00000001,
    D2D1_SVG_OVERFLOW_FORCE_DWORD = 0xffffffff,
}

///Specifies a value for the SVG stroke-linecap property.
alias D2D1_SVG_LINE_CAP = uint;
enum : uint
{
    ///The property is set to SVG's 'butt' value.
    D2D1_SVG_LINE_CAP_BUTT        = 0x00000000,
    ///The property is set to SVG's 'square' value.
    D2D1_SVG_LINE_CAP_SQUARE      = 0x00000001,
    ///The property is set to SVG's 'round' value.
    D2D1_SVG_LINE_CAP_ROUND       = 0x00000002,
    D2D1_SVG_LINE_CAP_FORCE_DWORD = 0xffffffff,
}

///Specifies a value for the SVG stroke-linejoin property.
alias D2D1_SVG_LINE_JOIN = uint;
enum : uint
{
    ///The property is set to SVG's 'bevel' value.
    D2D1_SVG_LINE_JOIN_BEVEL       = 0x00000001,
    ///The property is set to SVG's 'miter' value. Note that this is equivalent to D2D1_LINE_JOIN_MITER_OR_BEVEL, not
    ///D2D1_LINE_JOIN_MITER.
    D2D1_SVG_LINE_JOIN_MITER       = 0x00000003,
    ///The property is set to SVG's 'round' value.
    D2D1_SVG_LINE_JOIN_ROUND       = 0x00000002,
    D2D1_SVG_LINE_JOIN_FORCE_DWORD = 0xffffffff,
}

///The alignment portion of the SVG preserveAspectRatio attribute.
alias D2D1_SVG_ASPECT_ALIGN = uint;
enum : uint
{
    ///The alignment is set to SVG's 'none' value.
    D2D1_SVG_ASPECT_ALIGN_NONE        = 0x00000000,
    ///The alignment is set to SVG's 'xMinYMin' value.
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MIN = 0x00000001,
    ///The alignment is set to SVG's 'xMidYMin' value.
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MIN = 0x00000002,
    ///The alignment is set to SVG's 'xMaxYMin' value.
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MIN = 0x00000003,
    ///The alignment is set to SVG's 'xMinYMid' value.
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MID = 0x00000004,
    ///The alignment is set to SVG's 'xMidYMid' value.
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MID = 0x00000005,
    ///The alignment is set to SVG's 'xMaxYMid' value.
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MID = 0x00000006,
    ///The alignment is set to SVG's 'xMinYMax' value.
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MAX = 0x00000007,
    ///The alignment is set to SVG's 'xMidYMax' value.
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MAX = 0x00000008,
    ///The alignment is set to SVG's 'xMaxYMax' value.
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MAX = 0x00000009,
    D2D1_SVG_ASPECT_ALIGN_FORCE_DWORD = 0xffffffff,
}

///The meetOrSlice portion of the SVG preserveAspectRatio attribute.
alias D2D1_SVG_ASPECT_SCALING = uint;
enum : uint
{
    ///Scale the viewBox up as much as possible such that the entire viewBox is visible within the viewport.
    D2D1_SVG_ASPECT_SCALING_MEET        = 0x00000000,
    ///Scale the viewBox down as much as possible such that the entire viewport is covered by the viewBox.
    D2D1_SVG_ASPECT_SCALING_SLICE       = 0x00000001,
    D2D1_SVG_ASPECT_SCALING_FORCE_DWORD = 0xffffffff,
}

///Represents a path commmand. Each command may reference floats from the segment data. Commands ending in _ABSOLUTE
///interpret data as absolute coordinate. Commands ending in _RELATIVE interpret data as being relative to the previous
///point.
alias D2D1_SVG_PATH_COMMAND = uint;
enum : uint
{
    ///Closes the current subpath. Uses no segment data.
    D2D1_SVG_PATH_COMMAND_CLOSE_PATH                = 0x00000000,
    ///Starts a new subpath at the coordinate (x y). Uses 2 floats of segment data.
    D2D1_SVG_PATH_COMMAND_MOVE_ABSOLUTE             = 0x00000001,
    ///Starts a new subpath at the coordinate (x y). Uses 2 floats of segment data.
    D2D1_SVG_PATH_COMMAND_MOVE_RELATIVE             = 0x00000002,
    ///Draws a line to the coordinate (x y). Uses 2 floats of segment data.
    D2D1_SVG_PATH_COMMAND_LINE_ABSOLUTE             = 0x00000003,
    ///Draws a line to the coordinate (x y). Uses 2 floats of segment data.
    D2D1_SVG_PATH_COMMAND_LINE_RELATIVE             = 0x00000004,
    ///Draws a cubic Bezier curve (x1 y1 x2 y2 x y). The curve ends at (x, y) and is defined by the two control points
    ///(x1, y1) and (x2, y2). Uses 6 floats of segment data.
    D2D1_SVG_PATH_COMMAND_CUBIC_ABSOLUTE            = 0x00000005,
    ///Draws a cubic Bezier curve (x1 y1 x2 y2 x y). The curve ends at (x, y) and is defined by the two control points
    ///(x1, y1) and (x2, y2). Uses 6 floats of segment data.
    D2D1_SVG_PATH_COMMAND_CUBIC_RELATIVE            = 0x00000006,
    ///Draws a quadratic Bezier curve (x1 y1 x y). The curve ends at (x, y) and is defined by the control point (x1 y1).
    ///Uses 4 floats of segment data.
    D2D1_SVG_PATH_COMMAND_QUADRADIC_ABSOLUTE        = 0x00000007,
    ///Draws a quadratic Bezier curve (x1 y1 x y). The curve ends at (x, y) and is defined by the control point (x1 y1).
    ///Uses 4 floats of segment data.
    D2D1_SVG_PATH_COMMAND_QUADRADIC_RELATIVE        = 0x00000008,
    ///Draws an elliptical arc (rx ry x-axis-rotation large-arc-flag sweep-flag x y). The curve ends at (x, y) and is
    ///defined by the arc parameters. The two flags are considered set if their values are non-zero. Uses 7 floats of
    ///segment data.
    D2D1_SVG_PATH_COMMAND_ARC_ABSOLUTE              = 0x00000009,
    ///Draws an elliptical arc (rx ry x-axis-rotation large-arc-flag sweep-flag x y). The curve ends at (x, y) and is
    ///defined by the arc parameters. The two flags are considered set if their values are non-zero. Uses 7 floats of
    ///segment data.
    D2D1_SVG_PATH_COMMAND_ARC_RELATIVE              = 0x0000000a,
    ///Draws a horizontal line to the coordinate (x). Uses 1 float of segment data.
    D2D1_SVG_PATH_COMMAND_HORIZONTAL_ABSOLUTE       = 0x0000000b,
    ///Draws a horizontal line to the coordinate (x). Uses 1 float of segment data.
    D2D1_SVG_PATH_COMMAND_HORIZONTAL_RELATIVE       = 0x0000000c,
    ///Draws a vertical line to the coordinate (y). Uses 1 float of segment data.
    D2D1_SVG_PATH_COMMAND_VERTICAL_ABSOLUTE         = 0x0000000d,
    ///Draws a vertical line to the coordinate (y). Uses 1 float of segment data.
    D2D1_SVG_PATH_COMMAND_VERTICAL_RELATIVE         = 0x0000000e,
    ///Draws a smooth cubic Bezier curve (x2 y2 x y). The curve ends at (x, y) and is defined by the control point (x2,
    ///y2). Uses 4 floats of segment data.
    D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_ABSOLUTE     = 0x0000000f,
    ///Draws a smooth cubic Bezier curve (x2 y2 x y). The curve ends at (x, y) and is defined by the control point (x2,
    ///y2). Uses 4 floats of segment data.
    D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_RELATIVE     = 0x00000010,
    ///Draws a smooth quadratic Bezier curve ending at (x, y). Uses 2 floats of segment data.
    D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_ABSOLUTE = 0x00000011,
    ///Draws a smooth quadratic Bezier curve ending at (x, y). Uses 2 floats of segment data.
    D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_RELATIVE = 0x00000012,
    D2D1_SVG_PATH_COMMAND_FORCE_DWORD               = 0xffffffff,
}

///Defines the coordinate system used for SVG gradient or clipPath elements.
alias D2D1_SVG_UNIT_TYPE = uint;
enum : uint
{
    ///The property is set to SVG's 'userSpaceOnUse' value.
    D2D1_SVG_UNIT_TYPE_USER_SPACE_ON_USE   = 0x00000000,
    ///The property is set to SVG's 'objectBoundingBox' value.
    D2D1_SVG_UNIT_TYPE_OBJECT_BOUNDING_BOX = 0x00000001,
    D2D1_SVG_UNIT_TYPE_FORCE_DWORD         = 0xffffffff,
}

///Defines the type of SVG string attribute to set or get.
alias D2D1_SVG_ATTRIBUTE_STRING_TYPE = uint;
enum : uint
{
    ///The attribute is a string in the same form as it would appear in the SVG XML. Note that when getting values of
    ///this type, the value returned may not exactly match the value that was set. Instead, the output value is a
    ///normalized version of the value. For example, an input color of 'red' may be output as '
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_SVG         = 0x00000000,
    ///The attribute is an element ID.
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_ID          = 0x00000001,
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_FORCE_DWORD = 0xffffffff,
}

///Defines the type of SVG POD attribute to set or get.
alias D2D1_SVG_ATTRIBUTE_POD_TYPE = uint;
enum : uint
{
    ///The attribute is a FLOAT.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FLOAT                 = 0x00000000,
    ///The attribute is a D2D1_COLOR_F.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_COLOR                 = 0x00000001,
    ///The attribute is a D2D1_FILL_MODE.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FILL_MODE             = 0x00000002,
    ///The attribute is a D2D1_SVG_DISPLAY.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_DISPLAY               = 0x00000003,
    ///The attribute is a D2D1_SVG_OVERFLOW.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_OVERFLOW              = 0x00000004,
    ///The attribute is a D2D1_SVG_LINE_CAP.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_CAP              = 0x00000005,
    ///The attribute is a D2D1_SVG_LINE_JOIN.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_JOIN             = 0x00000006,
    ///The attribute is a D2D1_SVG_VISIBILITY.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_VISIBILITY            = 0x00000007,
    ///The attribute is a D2D1_MATRIX_3X2_F.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_MATRIX                = 0x00000008,
    ///The attribute is a D2D1_SVG_UNIT_TYPE.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_UNIT_TYPE             = 0x00000009,
    ///The attribute is a D2D1_EXTEND_MODE.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_EXTEND_MODE           = 0x0000000a,
    ///The attribute is a D2D1_SVG_PRESERVE_ASPECT_RATIO.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_PRESERVE_ASPECT_RATIO = 0x0000000b,
    ///The attribute is a D2D1_SVG_VIEWBOX.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_VIEWBOX               = 0x0000000c,
    ///The attribute is a D2D1_SVG_LENGTH.
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LENGTH                = 0x0000000d,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FORCE_DWORD           = 0xffffffff,
}

///Specifies the appearance of the ink nib (pen tip) as part of an D2D1_INK_STYLE_PROPERTIES structure.
alias D2D1_INK_NIB_SHAPE = uint;
enum : uint
{
    ///The pen tip is circular.
    D2D1_INK_NIB_SHAPE_ROUND       = 0x00000000,
    ///The pen tip is square.
    D2D1_INK_NIB_SHAPE_SQUARE      = 0x00000001,
    D2D1_INK_NIB_SHAPE_FORCE_DWORD = 0xffffffff,
}

///Specifies the flip and rotation at which an image appears.
alias D2D1_ORIENTATION = uint;
enum : uint
{
    ///The orientation is unchanged.
    D2D1_ORIENTATION_DEFAULT                             = 0x00000001,
    ///The image is flipped horizontally.
    D2D1_ORIENTATION_FLIP_HORIZONTAL                     = 0x00000002,
    ///The image is rotated clockwise 180 degrees.
    D2D1_ORIENTATION_ROTATE_CLOCKWISE180                 = 0x00000003,
    ///The image is rotated clockwise 180 degrees, then flipped horizontally.
    D2D1_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL = 0x00000004,
    ///The image is rotated clockwise 90 degrees, then flipped horizontally.
    D2D1_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL  = 0x00000005,
    ///The image is rotated clockwise 270 degrees.
    D2D1_ORIENTATION_ROTATE_CLOCKWISE270                 = 0x00000006,
    ///The image is rotated clockwise 270 degrees, then flipped horizontally.
    D2D1_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL = 0x00000007,
    ///The image is rotated clockwise 90 degrees.
    D2D1_ORIENTATION_ROTATE_CLOCKWISE90                  = 0x00000008,
    D2D1_ORIENTATION_FORCE_DWORD                         = 0xffffffff,
}

///Controls option flags for a new ID2D1ImageSource when it is created.
alias D2D1_IMAGE_SOURCE_LOADING_OPTIONS = uint;
enum : uint
{
    ///No options are used.
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_NONE            = 0x00000000,
    ///Indicates the image source should release its reference to the WIC bitmap source after it has initialized. By
    ///default, the image source retains a reference to the WIC bitmap source for the lifetime of the object to enable
    ///quality and speed optimizations for printing. This option disables that optimization.
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_RELEASE_SOURCE  = 0x00000001,
    ///Indicates the image source should only populate subregions of the image cache on-demand. You can control this
    ///behavior using the EnsureCached and TrimCache methods. This options provides the ability to improve memory usage
    ///by only keeping needed portions of the image in memory. This option requires that the image source has a
    ///reference to the WIC bitmap source, and is incompatible with D2D1_IMAGE_SOURCE_LOADING_OPTIONS_RELEASE_SOURCE.
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_CACHE_ON_DEMAND = 0x00000002,
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_FORCE_DWORD     = 0xffffffff,
}

///Option flags controlling primary conversion performed by CreateImageSourceFromDxgi, if any.
alias D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS = uint;
enum : uint
{
    ///No primary conversion is performed.
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_NONE                           = 0x00000000,
    ///Low quality primary conversion is performed.
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_LOW_QUALITY_PRIMARY_CONVERSION = 0x00000001,
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_FORCE_DWORD                    = 0xffffffff,
}

///Option flags for transformed image sources.
alias D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS = uint;
enum : uint
{
    ///No option flags.
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_NONE              = 0x00000000,
    ///Prevents the image source from being automatically scaled (by a ratio of the context DPI divided by 96) while
    ///drawn.
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_DISABLE_DPI_SCALE = 0x00000001,
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_FORCE_DWORD       = 0xffffffff,
}

///Specifies how to render gradient mesh edges.
alias D2D1_PATCH_EDGE_MODE = uint;
enum : uint
{
    ///Render this patch edge aliased. Use this value for the internal edges of your gradient mesh.
    D2D1_PATCH_EDGE_MODE_ALIASED          = 0x00000000,
    ///Render this patch edge antialiased. Use this value for the external (boundary) edges of your mesh.
    D2D1_PATCH_EDGE_MODE_ANTIALIASED      = 0x00000001,
    ///Render this patch edge aliased and also slightly inflated. Use this for the internal edges of your gradient mesh
    ///when there could be t-junctions among patches. Inflating the internal edges mitigates seams that can appear along
    ///those junctions.
    D2D1_PATCH_EDGE_MODE_ALIASED_INFLATED = 0x00000002,
    D2D1_PATCH_EDGE_MODE_FORCE_DWORD      = 0xffffffff,
}

///Specifies additional aspects of how a sprite batch is to be drawn, as part of a call to
///ID2D1DeviceContext3::DrawSpriteBatch.
alias D2D1_SPRITE_OPTIONS = uint;
enum : uint
{
    ///Default value. No special drawing configuration. This option yields the best drawing performance.
    D2D1_SPRITE_OPTIONS_NONE                      = 0x00000000,
    ///Interpolation of bitmap pixels will be clamped to the sprite’s source rectangle. If the sub-images in your
    ///source bitmap have no pixels separating them, then you may see color bleeding when drawing them with
    ///D2D1_SPRITE_OPTIONS_NONE. In that case, consider adding borders between them with your sprite-packing tool, or
    ///use this option. Note that drawing sprites with this option enabled is slower than using
    ///D2D1_SPRITE_OPTIONS_NONE.
    D2D1_SPRITE_OPTIONS_CLAMP_TO_SOURCE_RECTANGLE = 0x00000001,
    D2D1_SPRITE_OPTIONS_FORCE_DWORD               = 0xffffffff,
}

///Specifies the pixel snapping policy when rendering color bitmap glyphs.
alias D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION = uint;
enum : uint
{
    ///Color bitmap glyph positions are snapped to the nearest pixel if the bitmap resolution matches that of the device
    ///context.
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DEFAULT     = 0x00000000,
    ///Color bitmap glyph positions are not snapped.
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DISABLE     = 0x00000001,
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_FORCE_DWORD = 0xffffffff,
}

///Determines what gamma is used for interpolation and blending.
alias D2D1_GAMMA1 = uint;
enum : uint
{
    ///Colors are manipulated in 2.2 gamma color space.
    D2D1_GAMMA1_G22         = 0x00000000,
    ///Colors are manipulated in 1.0 gamma color space.
    D2D1_GAMMA1_G10         = 0x00000001,
    ///Colors are manipulated in ST.2084 PQ gamma color space.
    D2D1_GAMMA1_G2084       = 0x00000002,
    D2D1_GAMMA1_FORCE_DWORD = 0xffffffff,
}

///Specifies which way a color profile is defined.
alias D2D1_COLOR_CONTEXT_TYPE = uint;
enum : uint
{
    D2D1_COLOR_CONTEXT_TYPE_ICC         = 0x00000000,
    D2D1_COLOR_CONTEXT_TYPE_SIMPLE      = 0x00000001,
    D2D1_COLOR_CONTEXT_TYPE_DXGI        = 0x00000002,
    D2D1_COLOR_CONTEXT_TYPE_FORCE_DWORD = 0xffffffff,
}

// Callbacks

///Describes the implementation of an effect.
///Params:
///    effectImpl = The effect implementation returned by the factory.
///Returns:
///    The effect factory is implemented by an effect author.
///    
alias PD2D1_EFFECT_FACTORY = HRESULT function(IUnknown* effectImpl);
///Sets a property on an effect.
///Params:
///    effect = A pointer to the IUnknown interface for the effect on which the property will be set.
///    data = A pointer to the data to be set on the property.
///    dataSize = The number of bytes in the property set by the function.
///Returns:
///    Returns S_OK if successful; otherwise, returns an <b>HRESULT</b> error code.
///    
alias PD2D1_PROPERTY_SET_FUNCTION = HRESULT function(IUnknown effect, char* data, uint dataSize);
///Gets a property from an effect.
///Params:
///    effect = A pointer to the IUnknown interface for the effect on which the property will be retrieved.
///    data = A pointer to a variable that stores the data that this function retrieves on the property.
///    dataSize = The number of bytes in the property to retrieve.
///    actualSize = A optional pointer to a variable that stores the actual number of bytes retrieved on the property. If not used,
///                 set to <b>NULL</b>.
///Returns:
///    Returns S_OK if successful; otherwise, returns an <b>HRESULT</b> error code.
///    
alias PD2D1_PROPERTY_GET_FUNCTION = HRESULT function(const(IUnknown) effect, char* data, uint dataSize, 
                                                     uint* actualSize);

// Structs


///Specifies the color and usage of an entry in a logical palette.
struct PALETTEENTRY
{
    ///Type: <b>BYTE</b> The red intensity value for the palette entry.
    ubyte peRed;
    ///Type: <b>BYTE</b> The green intensity value for the palette entry.
    ubyte peGreen;
    ///Type: <b>BYTE</b> The blue intensity value for the palette entry.
    ubyte peBlue;
    ///Type: <b>BYTE</b> The alpha intensity value for the palette entry. Note that as of DirectX 8, this member is
    ///treated differently than documented for Windows.
    ubyte peFlags;
}

///Contains the data format and alpha mode for a bitmap or render target.
struct D2D1_PIXEL_FORMAT
{
    ///Type: <b>DXGI_FORMAT</b> A value that specifies the size and arrangement of channels in each pixel.
    DXGI_FORMAT     format;
    ///Type: <b>D2D1_ALPHA_MODE</b> A value that specifies whether the alpha channel is using pre-multiplied alpha,
    ///straight alpha, whether it should be ignored and considered opaque, or whether it is unkown.
    D2D1_ALPHA_MODE alphaMode;
}

///Represents an x-coordinate and y-coordinate pair, expressed as an unsigned 32-bit integer value, in two-dimensional
///space.
struct D2D_POINT_2U
{
    ///Type: <b>UINT32</b> The x-coordinate value of the point.
    uint x;
    uint y;
}

///Represents an x-coordinate and y-coordinate pair, expressed as floating-point values, in two-dimensional space.
struct D2D_POINT_2F
{
    ///Type: <b>FLOAT</b> The x-coordinate of the point.
    float x;
    float y;
}

///A vector of 2 FLOAT values (x, y).
struct D2D_VECTOR_2F
{
    ///The x value of the vector.
    float x;
    float y;
}

///A vector of 3 FLOAT values (x, y, z).
struct D2D_VECTOR_3F
{
    ///The x value of the vector.
    float x;
    ///The y value of the vector.
    float y;
    float z;
}

///A vector of 4 FLOAT values (x, y, z, w).
struct D2D_VECTOR_4F
{
    ///The x value of the vector.
    float x;
    ///The y value of the vector.
    float y;
    ///The z value of the vector.
    float z;
    float w;
}

///Represents a rectangle defined by the coordinates of the upper-left corner (left, top) and the coordinates of the
///lower-right corner (right, bottom).
struct D2D_RECT_F
{
    ///Type: <b>FLOAT</b> The x-coordinate of the upper-left corner of the rectangle.
    float left;
    ///Type: <b>FLOAT</b> The y-coordinate of the upper-left corner of the rectangle.
    float top;
    ///Type: <b>FLOAT</b> The x-coordinate of the lower-right corner of the rectangle.
    float right;
    ///Type: <b>FLOAT</b> The y-coordinate of the lower-right corner of the rectangle.
    float bottom;
}

///Represents a rectangle defined by the upper-left corner pair of coordinates (left,top) and the lower-right corner
///pair of coordinates (right, bottom). These coordinates are expressed as a 32-bit integer values.
struct D2D_RECT_U
{
    ///Type: <b>UINT32</b> The x-coordinate of the upper-left corner of the rectangle.
    uint left;
    ///Type: <b>UINT32</b> The y-coordinate of the upper-left corner of the rectangle.
    uint top;
    ///Type: <b>UINT32</b> The x-coordinate of the lower-right corner of the rectangle.
    uint right;
    uint bottom;
}

///Stores an ordered pair of floating-point values, typically the width and height of a rectangle.
struct D2D_SIZE_F
{
    ///Type: <b>FLOAT</b> The horizontal component of this size.
    float width;
    float height;
}

///Stores an ordered pair of integers, typically the width and height of a rectangle.
struct D2D_SIZE_U
{
    ///Type: <b>UINT32</b> The horizontal component of this size.
    uint width;
    uint height;
}

///Represents a 3-by-2 matrix.
struct D2D_MATRIX_3X2_F
{
    union
    {
        struct
        {
            float m11;
            float m12;
            float m21;
            float m22;
            float dx;
            float dy;
        }
        struct
        {
            float _11;
            float _12;
            float _21;
            float _22;
            float _31;
            float _32;
        }
        float[6] m;
    }
}

///Describes a 4-by-3 floating point matrix.
struct D2D_MATRIX_4X3_F
{
    union
    {
        struct
        {
            float _11;
            float _12;
            float _13;
            float _21;
            float _22;
            float _23;
            float _31;
            float _32;
            float _33;
            float _41;
            float _42;
            float _43;
        }
        float[12] m;
    }
}

///Describes a 4-by-4 floating point matrix.
struct D2D_MATRIX_4X4_F
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

///Describes a 5-by-4 floating point matrix.
struct D2D_MATRIX_5X4_F
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
            float _51;
            float _52;
            float _53;
            float _54;
        }
        float[20] m;
    }
}

///Describes the pixel format and dpi of a bitmap.
struct D2D1_BITMAP_PROPERTIES
{
    ///Type: <b>D2D1_PIXEL_FORMAT</b> The bitmap's pixel format and alpha mode.
    D2D1_PIXEL_FORMAT pixelFormat;
    ///Type: <b>FLOAT</b> The horizontal dpi of the bitmap.
    float             dpiX;
    float             dpiY;
}

///Contains the position and color of a gradient stop.
struct D2D1_GRADIENT_STOP
{
    ///Type: <b>FLOAT</b> A value that indicates the relative position of the gradient stop in the brush. This value
    ///must be in the [0.0f, 1.0f] range if the gradient stop is to be seen explicitly.
    float     position;
    ///Type: <b>D2D1_COLOR_F</b> The color of the gradient stop.
    DXGI_RGBA color;
}

///Describes the opacity and transformation of a brush.
struct D2D1_BRUSH_PROPERTIES
{
    ///Type: <b>FLOAT</b> A value between 0.0f and 1.0f, inclusive, that specifies the degree of opacity of the brush.
    float            opacity;
    ///Type: <b>D2D1_MATRIX_3X2_F</b> The transformation that is applied to the brush.
    D2D_MATRIX_3X2_F transform;
}

///Describes the extend modes and the interpolation mode of an ID2D1BitmapBrush.
struct D2D1_BITMAP_BRUSH_PROPERTIES
{
    ///Type: <b>D2D1_EXTEND_MODE</b> A value that describes how the brush horizontally tiles those areas that extend
    ///past its bitmap.
    D2D1_EXTEND_MODE extendModeX;
    ///Type: <b>D2D1_EXTEND_MODE</b> A value that describes how the brush vertically tiles those areas that extend past
    ///its bitmap.
    D2D1_EXTEND_MODE extendModeY;
    ///Type: <b>D2D1_BITMAP_INTERPOLATION_MODE</b> A value that specifies how the bitmap is interpolated when it is
    ///scaled or rotated.
    D2D1_BITMAP_INTERPOLATION_MODE interpolationMode;
}

///Contains the starting point and endpoint of the gradient axis for an ID2D1LinearGradientBrush.
struct D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES
{
    ///Type: <b>D2D1_POINT_2F</b> In the brush's coordinate space, the starting point of the gradient axis.
    D2D_POINT_2F startPoint;
    ///Type: <b>D2D1_POINT_2F</b> In the brush's coordinate space, the endpoint of the gradient axis.
    D2D_POINT_2F endPoint;
}

///Contains the gradient origin offset and the size and position of the gradient ellipse for an
///ID2D1RadialGradientBrush.
struct D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES
{
    ///Type: <b>D2D1_POINT_2F</b> In the brush's coordinate space, the center of the gradient ellipse.
    D2D_POINT_2F center;
    ///Type: <b>D2D1_POINT_2F</b> In the brush's coordinate space, the offset of the gradient origin relative to the
    ///gradient ellipse's center.
    D2D_POINT_2F gradientOriginOffset;
    ///Type: <b>FLOAT</b> In the brush's coordinate space, the x-radius of the gradient ellipse.
    float        radiusX;
    ///Type: <b>FLOAT</b> In the brush's coordinate space, the y-radius of the gradient ellipse.
    float        radiusY;
}

///Represents a cubic bezier segment drawn between two points.
struct D2D1_BEZIER_SEGMENT
{
    ///Type: <b>D2D1_POINT_2F</b> The first control point for the Bezier segment.
    D2D_POINT_2F point1;
    ///Type: <b>D2D1_POINT_2F</b> The second control point for the Bezier segment.
    D2D_POINT_2F point2;
    ///Type: <b>D2D1_POINT_2F</b> The end point for the Bezier segment.
    D2D_POINT_2F point3;
}

///Contains the three vertices that describe a triangle.
struct D2D1_TRIANGLE
{
    ///Type: <b>D2D1_POINT_2F</b> The first vertex of a triangle.
    D2D_POINT_2F point1;
    ///Type: <b>D2D1_POINT_2F</b> The second vertex of a triangle.
    D2D_POINT_2F point2;
    D2D_POINT_2F point3;
}

///Describes an elliptical arc between two points.
struct D2D1_ARC_SEGMENT
{
    ///Type: <b>D2D1_POINT_2F</b> The end point of the arc.
    D2D_POINT_2F         point;
    ///Type: <b>D2D1_SIZE_F</b> The x-radius and y-radius of the arc.
    D2D_SIZE_F           size;
    ///Type: <b>FLOAT</b> A value that specifies how many degrees in the clockwise direction the ellipse is rotated
    ///relative to the current coordinate system.
    float                rotationAngle;
    ///Type: <b>D2D1_SWEEP_DIRECTION</b> A value that specifies whether the arc sweep is clockwise or counterclockwise.
    D2D1_SWEEP_DIRECTION sweepDirection;
    D2D1_ARC_SIZE        arcSize;
}

///Contains the control point and end point for a quadratic Bezier segment.
struct D2D1_QUADRATIC_BEZIER_SEGMENT
{
    ///Type: <b>D2D1_POINT_2F</b> The control point of the quadratic Bezier segment.
    D2D_POINT_2F point1;
    D2D_POINT_2F point2;
}

///Contains the center point, x-radius, and y-radius of an ellipse.
struct D2D1_ELLIPSE
{
    ///Type: <b>D2D1_POINT_2F</b> The center point of the ellipse.
    D2D_POINT_2F point;
    ///Type: <b>FLOAT</b> The X-radius of the ellipse.
    float        radiusX;
    ///Type: <b>FLOAT</b> The Y-radius of the ellipse.
    float        radiusY;
}

///Contains the dimensions and corner radii of a rounded rectangle.
struct D2D1_ROUNDED_RECT
{
    ///Type: <b>D2D1_RECT_F</b> The coordinates of the rectangle.
    D2D_RECT_F rect;
    ///Type: <b>FLOAT</b> The x-radius for the quarter ellipse that is drawn to replace every corner of the rectangle.
    float      radiusX;
    ///Type: <b>FLOAT</b> The y-radius for the quarter ellipse that is drawn to replace every corner of the rectangle.
    float      radiusY;
}

///Describes the stroke that outlines a shape.
struct D2D1_STROKE_STYLE_PROPERTIES
{
    ///Type: <b>D2D1_CAP_STYLE</b> The cap applied to the start of all the open figures in a stroked geometry.
    D2D1_CAP_STYLE  startCap;
    ///Type: <b>D2D1_CAP_STYLE</b> The cap applied to the end of all the open figures in a stroked geometry.
    D2D1_CAP_STYLE  endCap;
    ///Type: <b>D2D1_CAP_STYLE</b> The shape at either end of each dash segment.
    D2D1_CAP_STYLE  dashCap;
    ///Type: <b>D2D1_LINE_JOIN</b> A value that describes how segments are joined. This value is ignored for a vertex if
    ///the segment flags specify that the segment should have a smooth join.
    D2D1_LINE_JOIN  lineJoin;
    ///Type: <b>FLOAT</b> The limit of the thickness of the join on a mitered corner. This value is always treated as
    ///though it is greater than or equal to 1.0f.
    float           miterLimit;
    ///Type: <b>D2D1_DASH_STYLE</b> A value that specifies whether the stroke has a dash pattern and, if so, the dash
    ///style.
    D2D1_DASH_STYLE dashStyle;
    ///Type: <b>FLOAT</b> A value that specifies an offset in the dash sequence. A positive dash offset value shifts the
    ///dash pattern, in units of stroke width, toward the start of the stroked geometry. A negative dash offset value
    ///shifts the dash pattern, in units of stroke width, toward the end of the stroked geometry.
    float           dashOffset;
}

///Contains the content bounds, mask information, opacity settings, and other options for a layer resource.
struct D2D1_LAYER_PARAMETERS
{
    ///Type: <b>D2D1_RECT_F</b> The content bounds of the layer. Content outside these bounds is not guaranteed to
    ///render.
    D2D_RECT_F          contentBounds;
    ///Type: <b>ID2D1Geometry*</b> The geometric mask specifies the area of the layer that is composited into the render
    ///target.
    ID2D1Geometry       geometricMask;
    ///Type: <b>D2D1_ANTIALIAS_MODE</b> A value that specifies the antialiasing mode for the geometricMask.
    D2D1_ANTIALIAS_MODE maskAntialiasMode;
    ///Type: <b>D2D1_MATRIX_3X2_F</b> A value that specifies the transform that is applied to the geometric mask when
    ///composing the layer.
    D2D_MATRIX_3X2_F    maskTransform;
    ///Type: <b>FLOAT</b> An opacity value that is applied uniformly to all resources in the layer when compositing to
    ///the target.
    float               opacity;
    ///Type: <b>ID2D1Brush*</b> A brush that is used to modify the opacity of the layer. The brush is mapped to the
    ///layer, and the alpha channel of each mapped brush pixel is multiplied against the corresponding layer pixel.
    ID2D1Brush          opacityBrush;
    ///Type: <b>D2D1_LAYER_OPTIONS</b> A value that specifies whether the layer intends to render text with ClearType
    ///antialiasing.
    D2D1_LAYER_OPTIONS  layerOptions;
}

///Contains rendering options (hardware or software), pixel format, DPI information, remoting options, and Direct3D
///support requirements for a render target.
struct D2D1_RENDER_TARGET_PROPERTIES
{
    ///Type: <b>D2D1_RENDER_TARGET_TYPE</b> A value that specifies whether the render target should force hardware or
    ///software rendering. A value of D2D1_RENDER_TARGET_TYPE_DEFAULT specifies that the render target should use
    ///hardware rendering if it is available; otherwise, it uses software rendering. Note that WIC bitmap render targets
    ///do not support hardware rendering.
    D2D1_RENDER_TARGET_TYPE type;
    ///Type: <b>D2D1_PIXEL_FORMAT</b> The pixel format and alpha mode of the render target. You can use the
    ///D2D1::PixelFormat function to create a pixel format that specifies that Direct2D should select the pixel format
    ///and alpha mode for you. For a list of pixel formats and alpha modes supported by each render target, see
    ///Supported Pixel Formats and Alpha Modes.
    D2D1_PIXEL_FORMAT  pixelFormat;
    ///Type: <b>FLOAT</b> The horizontal DPI of the render target. To use the default DPI, set <i>dpiX</i> and
    ///<i>dpiY</i> to 0. For more information, see the Remarks section.
    float              dpiX;
    ///Type: <b>FLOAT</b> The vertical DPI of the render target. To use the default DPI, set <i>dpiX</i> and <i>dpiY</i>
    ///to 0. For more information, see the Remarks section.
    float              dpiY;
    ///Type: <b>D2D1_RENDER_TARGET_USAGE</b> A value that specifies how the render target is remoted and whether it
    ///should be GDI-compatible. Set to D2D1_RENDER_TARGET_USAGE_NONE to create a render target that is not compatible
    ///with GDI and uses Direct3D command-stream remoting if it is available.
    D2D1_RENDER_TARGET_USAGE usage;
    ///Type: <b>D2D1_FEATURE_LEVEL</b> A value that specifies the minimum Direct3D feature level required for hardware
    ///rendering. If the specified minimum level is not available, the render target uses software rendering if the
    ///<b>type </b> member is set to D2D1_RENDER_TARGET_TYPE_DEFAULT; if <b>type </b> is set to to
    ///<b>D2D1_RENDER_TARGET_TYPE_HARDWARE</b>, render target creation fails. A value of D2D1_FEATURE_LEVEL_DEFAULT
    ///indicates that Direct2D should determine whether the Direct3D feature level of the device is adequate. This field
    ///is used only when creating ID2D1HwndRenderTarget and ID2D1DCRenderTarget objects.
    D2D1_FEATURE_LEVEL minLevel;
}

///Contains the HWND, pixel size, and presentation options for an ID2D1HwndRenderTarget.
struct D2D1_HWND_RENDER_TARGET_PROPERTIES
{
    ///Type: <b>HWND</b> The HWND to which the render target issues the output from its drawing commands.
    HWND                 hwnd;
    ///Type: <b>D2D1_SIZE_U</b> The size of the render target, in pixels.
    D2D_SIZE_U           pixelSize;
    ///Type: <b>D2D1_PRESENT_OPTIONS</b> A value that specifies whether the render target retains the frame after it is
    ///presented and whether the render target waits for the device to refresh before presenting.
    D2D1_PRESENT_OPTIONS presentOptions;
}

///Describes the drawing state of a render target.
struct D2D1_DRAWING_STATE_DESCRIPTION
{
    ///Type: <b>D2D1_ANTIALIAS_MODE</b> The antialiasing mode for subsequent nontext drawing operations.
    D2D1_ANTIALIAS_MODE antialiasMode;
    ///Type: <b>D2D1_TEXT_ANTIALIAS_MODE</b> The antialiasing mode for subsequent text and glyph drawing operations.
    D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode;
    ///Type: <b>D2D1_TAG</b> A label for subsequent drawing operations.
    ulong               tag1;
    ///Type: <b>D2D1_TAG</b> A label for subsequent drawing operations.
    ulong               tag2;
    ///Type: <b>D2D1_MATRIX_3X2_F</b> The transformation to apply to subsequent drawing operations.
    D2D_MATRIX_3X2_F    transform;
}

///Contains the debugging level of an ID2D1Factory object.
struct D2D1_FACTORY_OPTIONS
{
    ///Type: <b>D2D1_DEBUG_LEVEL</b> The debugging level of the ID2D1Factory object.
    D2D1_DEBUG_LEVEL debugLevel;
}

///This structure allows a ID2D1Bitmap1 to be created with bitmap options and color context information available.
struct D2D1_BITMAP_PROPERTIES1
{
    ///Type: <b>D2D1_PIXEL_FORMAT</b> The DXGI format and alpha mode to create the bitmap with.
    D2D1_PIXEL_FORMAT   pixelFormat;
    ///Type: <b>FLOAT</b> The bitmap dpi in the x direction.
    float               dpiX;
    ///Type: <b>FLOAT</b> The bitmap dpi in the y direction.
    float               dpiY;
    ///Type: <b>D2D1_BITMAP_OPTIONS</b> The special creation options of the bitmap.
    D2D1_BITMAP_OPTIONS bitmapOptions;
    ///Type: <b>ID2D1ColorContext*</b> The optionally specified color context information.
    ID2D1ColorContext   colorContext;
}

///Describes mapped memory from the ID2D1Bitmap1::Map API.
struct D2D1_MAPPED_RECT
{
    ///The size in bytes of an individual scanline in the bitmap.
    uint   pitch;
    ///The data inside the bitmap.
    ubyte* bits;
}

///Describes limitations to be applied to an imaging effect renderer.
struct D2D1_RENDERING_CONTROLS
{
    ///The buffer precision used by default if the buffer precision is not otherwise specified by the effect or by the
    ///transform.
    D2D1_BUFFER_PRECISION bufferPrecision;
    ///The tile allocation size to be used by the imaging effect renderer.
    D2D_SIZE_U tileSize;
}

///Describes features of an effect.
struct D2D1_EFFECT_INPUT_DESCRIPTION
{
    ///The effect whose input connection is being specified.
    ID2D1Effect effect;
    ///The input index of the effect that is being considered.
    uint        inputIndex;
    ///The amount of data that would be available on the input. This can be used to query this information when the data
    ///is not yet available.
    D2D_RECT_F  inputRectangle;
}

///Describes a point on a path geometry.
struct D2D1_POINT_DESCRIPTION
{
    ///The end point after walking the path.
    D2D_POINT_2F point;
    ///A unit vector indicating the tangent point.
    D2D_POINT_2F unitTangentVector;
    ///The index of the segment on which point resides. This index is global to the entire path, not just to a
    ///particular figure.
    uint         endSegment;
    ///The index of the figure on which point resides.
    uint         endFigure;
    ///The length of the section of the path stretching from the start of the path to the start of <b>endSegment</b>.
    float        lengthToEndSegment;
}

///Describes image brush features.
struct D2D1_IMAGE_BRUSH_PROPERTIES
{
    ///Type: <b>D2D1_RECT_F</b> The source rectangle in the image space from which the image will be tiled or
    ///interpolated.
    D2D_RECT_F       sourceRectangle;
    ///Type: <b>D2D1_EXTEND_MODE</b> The extend mode in the image x-axis.
    D2D1_EXTEND_MODE extendModeX;
    ///Type: <b>D2D1_EXTEND_MODE</b> The extend mode in the image y-axis.
    D2D1_EXTEND_MODE extendModeY;
    ///Type: <b>D2D1_INTERPOLATION_MODE</b> The interpolation mode to use when scaling the image brush.
    D2D1_INTERPOLATION_MODE interpolationMode;
}

///Describes the extend modes and the interpolation mode of an ID2D1BitmapBrush.
struct D2D1_BITMAP_BRUSH_PROPERTIES1
{
    ///Type: <b>D2D1_EXTEND_MODE</b> A value that describes how the brush horizontally tiles those areas that extend
    ///past its bitmap.
    D2D1_EXTEND_MODE extendModeX;
    ///Type: <b>D2D1_EXTEND_MODE</b> A value that describes how the brush vertically tiles those areas that extend past
    ///its bitmap.
    D2D1_EXTEND_MODE extendModeY;
    ///Type: <b>D2D1_INTERPOLATION_MODE</b> A value that specifies how the bitmap is interpolated when it is scaled or
    ///rotated.
    D2D1_INTERPOLATION_MODE interpolationMode;
}

///Describes the stroke that outlines a shape.
struct D2D1_STROKE_STYLE_PROPERTIES1
{
    ///Type: <b>D2D1_CAP_STYLE</b> The cap to use at the start of each open figure.
    D2D1_CAP_STYLE  startCap;
    ///Type: <b>D2D1_CAP_STYLE</b> The cap to use at the end of each open figure.
    D2D1_CAP_STYLE  endCap;
    ///Type: <b>D2D1_CAP_STYLE</b> The cap to use at the start and end of each dash.
    D2D1_CAP_STYLE  dashCap;
    ///Type: <b>D2D1_LINE_JOIN</b> The line join to use.
    D2D1_LINE_JOIN  lineJoin;
    ///Type: <b>FLOAT</b> The limit beyond which miters are either clamped or converted to bevels.
    float           miterLimit;
    ///Type: <b>D2D1_DASH_STYLE</b> The type of dash to use.
    D2D1_DASH_STYLE dashStyle;
    ///Type: <b>FLOAT</b> The location of the first dash, relative to the start of the figure.
    float           dashOffset;
    ///Type: <b>D2D1_STROKE_TRANSFORM_TYPE</b> The rule that determines what render target properties affect the nib of
    ///the stroke.
    D2D1_STROKE_TRANSFORM_TYPE transformType;
}

///Contains the content bounds, mask information, opacity settings, and other options for a layer resource.
struct D2D1_LAYER_PARAMETERS1
{
    ///Type: <b>D2D1_RECT_F</b> The content bounds of the layer. Content outside these bounds is not guaranteed to
    ///render.
    D2D_RECT_F          contentBounds;
    ///Type: <b>ID2D1Geometry*</b> The geometric mask specifies the area of the layer that is composited into the render
    ///target.
    ID2D1Geometry       geometricMask;
    ///Type: <b>D2D1_ANTIALIAS_MODE</b> A value that specifies the antialiasing mode for the geometricMask.
    D2D1_ANTIALIAS_MODE maskAntialiasMode;
    ///Type: <b>D2D1_MATRIX_3X2_F</b> A value that specifies the transform that is applied to the geometric mask when
    ///composing the layer.
    D2D_MATRIX_3X2_F    maskTransform;
    ///Type: <b>FLOAT</b> An opacity value that is applied uniformly to all resources in the layer when compositing to
    ///the target.
    float               opacity;
    ///Type: <b>ID2D1Brush*</b> A brush that is used to modify the opacity of the layer. The brush is mapped to the
    ///layer, and the alpha channel of each mapped brush pixel is multiplied against the corresponding layer pixel.
    ID2D1Brush          opacityBrush;
    ///Type: <b>D2D1_LAYER_OPTIONS1</b> Additional options for the layer creation.
    D2D1_LAYER_OPTIONS1 layerOptions;
}

///Describes the drawing state of a device context.
struct D2D1_DRAWING_STATE_DESCRIPTION1
{
    ///Type: <b>D2D1_ANTIALIAS_MODE</b> The antialiasing mode for subsequent nontext drawing operations.
    D2D1_ANTIALIAS_MODE  antialiasMode;
    ///Type: <b>D2D1_TEXT_ANTIALIAS_MODE</b> The antialiasing mode for subsequent text and glyph drawing operations.
    D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode;
    ///Type: <b>D2D1_TAG</b> A label for subsequent drawing operations.
    ulong                tag1;
    ///Type: <b>D2D1_TAG</b> A label for subsequent drawing operations.
    ulong                tag2;
    ///Type: <b>D2D1_MATRIX_3X2_F</b> The transformation to apply to subsequent drawing operations.
    D2D_MATRIX_3X2_F     transform;
    ///Type: <b>D2D1_PRIMITIVE_BLEND</b> The blend mode for the device context to apply to subsequent drawing
    ///operations.
    D2D1_PRIMITIVE_BLEND primitiveBlend;
    ///Type: <b>D2D1_UNIT_MODE</b> D2D1_UNIT_MODE
    D2D1_UNIT_MODE       unitMode;
}

///The creation properties for a ID2D1PrintControl object.
struct D2D1_PRINT_CONTROL_PROPERTIES
{
    ///Type: <b>D2D1_PRINT_FONT_SUBSET_MODE</b> The mode to use for subsetting fonts for printing, defaults to
    ///D2D1_PRINT_FONT_SUBSET_MODE_DEFAULT.
    D2D1_PRINT_FONT_SUBSET_MODE fontSubset;
    ///Type: <b>FLOAT</b> DPI for rasterization of all unsupported Direct2D commands or options, defaults to 150.0.
    float            rasterDPI;
    D2D1_COLOR_SPACE colorSpace;
}

///Specifies the options with which the Direct2D device, factory, and device context are created.
struct D2D1_CREATION_PROPERTIES
{
    ///The threading mode with which the corresponding root objects will be created.
    D2D1_THREADING_MODE threadingMode;
    ///The debug level that the root objects should be created with.
    D2D1_DEBUG_LEVEL    debugLevel;
    ///The device context options that the root objects should be created with.
    D2D1_DEVICE_CONTEXT_OPTIONS options;
}

struct Matrix4x3F
{
    D2D_MATRIX_4X3_F __AnonymousBase_d2d1_1helper_L45_C31;
}

///The Matrix4x4F class represents a 4-by-4 matrix and provides convenience methods for creating matrices.
struct Matrix4x4F
{
    D2D_MATRIX_4X4_F __AnonymousBase_d2d1_1helper_L97_C31;
}

struct Matrix5x4F
{
    D2D_MATRIX_5X4_F __AnonymousBase_d2d1_1helper_L472_C31;
}

///Defines a property binding to a pair of functions which get and set the corresponding property.
struct D2D1_PROPERTY_BINDING
{
    ///The name of the property.
    const(wchar)* propertyName;
    ///The function that will receive the data to set.
    PD2D1_PROPERTY_SET_FUNCTION setFunction;
    ///The function that will be asked to write the output data.
    PD2D1_PROPERTY_GET_FUNCTION getFunction;
}

///Defines a resource texture when the original resource texture is created.
struct D2D1_RESOURCE_TEXTURE_PROPERTIES
{
    ///The extents of the resource table in each dimension.
    const(uint)*       extents;
    ///The number of dimensions in the resource texture. This must be a number from 1 to 3.
    uint               dimensions;
    ///The precision of the resource texture to create.
    D2D1_BUFFER_PRECISION bufferPrecision;
    ///The number of channels in the resource texture.
    D2D1_CHANNEL_DEPTH channelDepth;
    ///The filtering mode to use on the texture.
    D2D1_FILTER        filter;
    ///Specifies how pixel values beyond the extent of the texture will be sampled, in every dimension.
    const(D2D1_EXTEND_MODE)* extendModes;
}

///A description of a single element to the vertex layout.
struct D2D1_INPUT_ELEMENT_DESC
{
    ///The HLSL semantic associated with this element in a shader input-signature.
    const(char)* semanticName;
    ///The semantic index for the element. A semantic index modifies a semantic, with an integer index number. A
    ///semantic index is only needed in a case where there is more than one element with the same semantic. For example,
    ///a 4x4 matrix would have four components each with the semantic name matrix; however, each of the four components
    ///would have different semantic indices (0, 1, 2, and 3).
    uint         semanticIndex;
    ///The data type of the element data.
    DXGI_FORMAT  format;
    ///An integer value that identifies the input-assembler. Valid values are between 0 and 15.
    uint         inputSlot;
    ///The offset in bytes between each element.
    uint         alignedByteOffset;
}

///Defines the properties of a vertex buffer that are standard for all vertex shader definitions.
struct D2D1_VERTEX_BUFFER_PROPERTIES
{
    ///The number of inputs to the vertex shader.
    uint              inputCount;
    ///Indicates how frequently the vertex buffer is likely to be updated.
    D2D1_VERTEX_USAGE usage;
    ///The initial contents of the vertex buffer.
    const(ubyte)*     data;
    ///The size of the vertex buffer, in bytes.
    uint              byteWidth;
}

///Defines a vertex shader and the input element description to define the input layout. The combination is used to
///allow a custom vertex effect to create a custom vertex shader and pass it a custom layout.
struct D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES
{
    ///A pointer to the buffer.
    const(ubyte)* shaderBufferWithInputSignature;
    ///The size of the buffer.
    uint          shaderBufferSize;
    ///An array of input assembler stage data types.
    const(D2D1_INPUT_ELEMENT_DESC)* inputElements;
    ///The number of input elements in the vertex shader.
    uint          elementCount;
    ///The vertex stride.
    uint          stride;
}

///Defines a range of vertices that are used when rendering less than the full contents of a vertex buffer.
struct D2D1_VERTEX_RANGE
{
    ///The first vertex in the range to process.
    uint startVertex;
    ///The number of vertices to use.
    uint vertexCount;
}

///Defines a blend description to be used in a particular blend transform.
struct D2D1_BLEND_DESCRIPTION
{
    ///Specifies the first RGB data source and includes an optional preblend operation.
    D2D1_BLEND           sourceBlend;
    ///Specifies the second RGB data source and includes an optional preblend operation.
    D2D1_BLEND           destinationBlend;
    ///Specifies how to combine the RGB data sources.
    D2D1_BLEND_OPERATION blendOperation;
    ///Specifies the first alpha data source and includes an optional preblend operation. Blend options that end in
    ///_COLOR are not allowed.
    D2D1_BLEND           sourceBlendAlpha;
    ///Specifies the second alpha data source and includes an optional preblend operation. Blend options that end in
    ///_COLOR are not allowed.
    D2D1_BLEND           destinationBlendAlpha;
    ///Specifies how to combine the alpha data sources.
    D2D1_BLEND_OPERATION blendOperationAlpha;
    ///Parameters to the blend operations. The blend must use <b>D2D1_BLEND_BLEND_FACTOR</b> for this to be used.
    float[4]             blendFactor;
}

///Describes the options that transforms may set on input textures.
struct D2D1_INPUT_DESCRIPTION
{
    ///The type of filter to apply to the input texture.
    D2D1_FILTER filter;
    ///The mip level to retrieve from the upstream transform, if specified.
    uint        levelOfDetailCount;
}

///Describes the support for doubles in shaders.
struct D2D1_FEATURE_DATA_DOUBLES
{
    ///TRUE is doubles are supported within the shaders.
    BOOL doublePrecisionFloatShaderOps;
}

///Describes compute shader support, which is an option on D3D10 feature level.
struct D2D1_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS
{
    ///Shader model 4 compute shaders are supported.
    BOOL computeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x;
}

///Represents an SVG length.
struct D2D1_SVG_LENGTH
{
    float value;
    D2D1_SVG_LENGTH_UNITS units;
}

///Represents all SVG preserveAspectRatio settings.
struct D2D1_SVG_PRESERVE_ASPECT_RATIO
{
    ///Sets the 'defer' portion of the preserveAspectRatio settings. This field only has an effect on an 'image' element
    ///that references another SVG document. As this is not currently supported, the field has no impact on rendering.
    BOOL defer;
    ///Sets the align portion of the preserveAspectRatio settings.
    D2D1_SVG_ASPECT_ALIGN align_;
    D2D1_SVG_ASPECT_SCALING meetOrSlice;
}

///Represents an SVG viewBox.
struct D2D1_SVG_VIEWBOX
{
    ///X coordinate of the view box.
    float x;
    ///Y coordinate of the view box.
    float y;
    ///Width of the view box.
    float width;
    float height;
}

///Properties of a transformed image source.
struct D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES
{
    ///Type: <b>D2D1_ORIENTATION</b> The orientation at which the image source is drawn.
    D2D1_ORIENTATION orientation;
    ///Type: <b>FLOAT</b> The horizontal scale factor at which the image source is drawn.
    float            scaleX;
    ///Type: <b>FLOAT</b> The vertical scale factor at which the image source is drawn.
    float            scaleY;
    ///Type: <b>D2D1_INTERPOLATION_MODE</b> The interpolation mode used when the image source is drawn. This is ignored
    ///if the image source is drawn using the DrawImage method, or using an image brush.
    D2D1_INTERPOLATION_MODE interpolationMode;
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS options;
}

///Represents a point, radius pair that makes up part of a D2D1_INK_BEZIER_SEGMENT.
struct D2D1_INK_POINT
{
    ///The x-coordinate of the point.
    float x;
    ///The y-coordinate of the point.
    float y;
    float radius;
}

///Represents a Bezier segment to be used in the creation of an ID2D1Ink object. This structure differs from
///D2D1_BEZIER_SEGMENT in that it is composed of D2D1_INK_POINTs, which contain a radius in addition to x- and
///y-coordinates.
struct D2D1_INK_BEZIER_SEGMENT
{
    ///The first control point for the Bezier segment.
    D2D1_INK_POINT point1;
    ///The second control point for the Bezier segment.
    D2D1_INK_POINT point2;
    D2D1_INK_POINT point3;
}

///Defines the general pen tip shape and the transform used in an ID2D1InkStyle object.
struct D2D1_INK_STYLE_PROPERTIES
{
    ///The pre-transform shape of the nib (pen tip) used to draw a given ink object.
    D2D1_INK_NIB_SHAPE nibShape;
    D2D_MATRIX_3X2_F   nibTransform;
}

///Represents a tensor patch with 16 control points, 4 corner colors, and boundary flags. An ID2D1GradientMesh is made
///up of 1 or more gradient mesh patches. Use the GradientMeshPatch function or the GradientMeshPatchFromCoonsPatch
///function to create one.
struct D2D1_GRADIENT_MESH_PATCH
{
    ///The coordinate-space location of the control point in column 0 and row 0 of the tensor grid.
    D2D_POINT_2F         point00;
    ///The coordinate-space location of the control point in column 0 and row 1 of the tensor grid.
    D2D_POINT_2F         point01;
    ///The coordinate-space location of the control point in column 0 and row 2 of the tensor grid.
    D2D_POINT_2F         point02;
    ///The coordinate-space location of the control point in column 0 and row 3 of the tensor grid.
    D2D_POINT_2F         point03;
    ///The coordinate-space location of the control point in column 1 and row 0 of the tensor grid.
    D2D_POINT_2F         point10;
    ///The coordinate-space location of the control point in column 1 and row 1 of the tensor grid.
    D2D_POINT_2F         point11;
    ///The coordinate-space location of the control point in column 1 and row 2 of the tensor grid.
    D2D_POINT_2F         point12;
    ///The coordinate-space location of the control point in column 1 and row 3 of the tensor grid.
    D2D_POINT_2F         point13;
    ///The coordinate-space location of the control point in column 2 and row 0 of the tensor grid.
    D2D_POINT_2F         point20;
    ///The coordinate-space location of the control point in column 2 and row 1 of the tensor grid.
    D2D_POINT_2F         point21;
    ///The coordinate-space location of the control point in column 2 and row 2 of the tensor grid.
    D2D_POINT_2F         point22;
    ///The coordinate-space location of the control point in column 2 and row 3 of the tensor grid.
    D2D_POINT_2F         point23;
    ///The coordinate-space location of the control point in column 3 and row 0 of the tensor grid.
    D2D_POINT_2F         point30;
    ///The coordinate-space location of the control point in column 3 and row 1 of the tensor grid.
    D2D_POINT_2F         point31;
    ///The coordinate-space location of the control point in column 3 and row 2 of the tensor grid.
    D2D_POINT_2F         point32;
    ///The coordinate-space location of the control point in column 3 and row 3 of the tensor grid.
    D2D_POINT_2F         point33;
    ///The color associated with the control point in column 0 and row 0 of the tensor grid.
    DXGI_RGBA            color00;
    ///The color associated with the control point in column 0 and row 3 of the tensor grid.
    DXGI_RGBA            color03;
    ///The color associated with the control point in column 3 and row 0 of the tensor grid.
    DXGI_RGBA            color30;
    ///The color associated with the control point in column 3 and row 3 of the tensor grid.
    DXGI_RGBA            color33;
    ///Specifies how to render the top edge of the mesh.
    D2D1_PATCH_EDGE_MODE topEdgeMode;
    ///Specifies how to render the left edge of the mesh.
    D2D1_PATCH_EDGE_MODE leftEdgeMode;
    ///Specifies how to render the bottom edge of the mesh.
    D2D1_PATCH_EDGE_MODE bottomEdgeMode;
    ///Specifies how to render the right edge of the mesh.
    D2D1_PATCH_EDGE_MODE rightEdgeMode;
}

///Simple description of a color space.
struct D2D1_SIMPLE_COLOR_PROFILE
{
    ///The XY coordinates of the red primary in CIEXYZ space.
    D2D_POINT_2F redPrimary;
    ///The XY coordinates of the green primary in CIEXYZ space.
    D2D_POINT_2F greenPrimary;
    ///The XY coordinates of the blue primary in CIEXYZ space.
    D2D_POINT_2F bluePrimary;
    ///The X/Z tristimulus values for the whitepoint, normalized for relative luminance.
    D2D_POINT_2F whitePointXZ;
    D2D1_GAMMA1  gamma;
}

///Vertex shader caps.
struct D3DVSHADERCAPS2_0
{
    ///Type: <b>DWORD</b> Instruction predication is supported if this value is nonzero. See setp_comp - vs.
    uint Caps;
    ///Type: <b>INT</b> Either 0 or 24, which represents the depth of the dynamic flow control instruction nesting. See
    ///D3DVS20CAPS.
    int  DynamicFlowControlDepth;
    ///Type: <b>INT</b> The number of temporary registers supported. See D3DVS20CAPS.
    int  NumTemps;
    ///Type: <b>INT</b> The depth of nesting of the loop - vs/rep - vs and call - vs/callnz bool - vs instructions. See
    ///D3DVS20CAPS.
    int  StaticFlowControlDepth;
}

///Pixel shader driver caps.
struct D3DPSHADERCAPS2_0
{
    ///Type: <b>DWORD</b> Instruction predication is supported if this value is nonzero. See setp_comp - vs.
    uint Caps;
    ///Type: <b>INT</b> Either 0 or 24, which represents the depth of the dynamic flow control instruction nesting. See
    ///<b>D3DPSHADERCAPS2_0</b>.
    int  DynamicFlowControlDepth;
    ///Type: <b>INT</b> The number of temporary registers supported. See <b>D3DPSHADERCAPS2_0</b>.
    int  NumTemps;
    ///Type: <b>INT</b> The depth of nesting of the loop - vs/rep - vs and call - vs/callnz bool - vs instructions. See
    ///<b>D3DPSHADERCAPS2_0</b>.
    int  StaticFlowControlDepth;
    ///Type: <b>INT</b> The number of instruction slots supported. See <b>D3DPSHADERCAPS2_0</b>.
    int  NumInstructionSlots;
}

///Represents the capabilities of the hardware exposed through the Direct3D object.
struct D3DCAPS9
{
    ///Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, which identifies what type of resources are
    ///used for processing vertices.
    D3DDEVTYPE        DeviceType;
    ///Type: <b>UINT</b> Adapter on which this Direct3D device was created. This ordinal is valid only to pass to
    ///methods of the IDirect3D9 interface that created this Direct3D device. The <b>IDirect3D9</b> interface can always
    ///be retrieved by calling GetDirect3D.
    uint              AdapterOrdinal;
    ///Type: <b>DWORD</b> The following driver-specific capability. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="D3DCAPS_READ_SCANLINE"></a><a id="d3dcaps_read_scanline"></a><dl>
    ///<dt><b>D3DCAPS_READ_SCANLINE</b></dt> </dl> </td> <td width="60%"> Display hardware is capable of returning the
    ///current scan line. </td> </tr> <tr> <td width="40%"><a id="D3DCAPS_OVERLAY"></a><a id="d3dcaps_overlay"></a><dl>
    ///<dt><b>D3DCAPS_OVERLAY</b></dt> </dl> </td> <td width="60%"> The display driver supports an overlay DDI that
    ///allows for verification of overlay capabilities. For more information about the overlay DDI, see Overlay DDI.
    ///<table> <tr> <td> Differences between Direct3D 9 and Direct3D 9Ex: This flag is available in Direct3D 9Ex only.
    ///</td> </tr> </table> </td> </tr> </table>
    uint              Caps;
    ///Type: <b>DWORD</b> Driver-specific capabilities identified in D3DCAPS2.
    uint              Caps2;
    ///Type: <b>DWORD</b> Driver-specific capabilities identified in D3DCAPS3.
    uint              Caps3;
    ///Type: <b>DWORD</b> Bit mask of values representing what presentation swap intervals are available. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPRESENT_INTERVAL_IMMEDIATE"></a><a
    ///id="d3dpresent_interval_immediate"></a><dl> <dt><b>D3DPRESENT_INTERVAL_IMMEDIATE</b></dt> </dl> </td> <td
    ///width="60%"> The driver supports an immediate presentation swap interval. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRESENT_INTERVAL_ONE"></a><a id="d3dpresent_interval_one"></a><dl> <dt><b>D3DPRESENT_INTERVAL_ONE</b></dt>
    ///</dl> </td> <td width="60%"> The driver supports a presentation swap interval of every screen refresh. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPRESENT_INTERVAL_TWO"></a><a id="d3dpresent_interval_two"></a><dl>
    ///<dt><b>D3DPRESENT_INTERVAL_TWO</b></dt> </dl> </td> <td width="60%"> The driver supports a presentation swap
    ///interval of every second screen refresh. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRESENT_INTERVAL_THREE"></a><a id="d3dpresent_interval_three"></a><dl>
    ///<dt><b>D3DPRESENT_INTERVAL_THREE</b></dt> </dl> </td> <td width="60%"> The driver supports a presentation swap
    ///interval of every third screen refresh. </td> </tr> <tr> <td width="40%"><a id="D3DPRESENT_INTERVAL_FOUR"></a><a
    ///id="d3dpresent_interval_four"></a><dl> <dt><b>D3DPRESENT_INTERVAL_FOUR</b></dt> </dl> </td> <td width="60%"> The
    ///driver supports a presentation swap interval of every fourth screen refresh. </td> </tr> </table>
    uint              PresentationIntervals;
    ///Type: <b>DWORD</b> Bit mask indicating what hardware support is available for cursors. Direct3D 9 does not define
    ///alpha-blending cursor capabilities. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DCURSORCAPS_COLOR"></a><a id="d3dcursorcaps_color"></a><dl> <dt><b>D3DCURSORCAPS_COLOR</b></dt> </dl> </td>
    ///<td width="60%"> A full-color cursor is supported in hardware. Specifically, this flag indicates that the driver
    ///supports at least a hardware color cursor in high-resolution modes (with scan lines greater than or equal to
    ///400). </td> </tr> <tr> <td width="40%"><a id="D3DCURSORCAPS_LOWRES"></a><a id="d3dcursorcaps_lowres"></a><dl>
    ///<dt><b>D3DCURSORCAPS_LOWRES</b></dt> </dl> </td> <td width="60%"> A full-color cursor is supported in hardware.
    ///Specifically, this flag indicates that the driver supports a hardware color cursor in both high-resolution and
    ///low-resolution modes (with scan lines less than 400). </td> </tr> </table>
    uint              CursorCaps;
    ///Type: <b>DWORD</b> Flags identifying the capabilities of the device. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="D3DDEVCAPS_CANBLTSYSTONONLOCAL"></a><a
    ///id="d3ddevcaps_canbltsystononlocal"></a><dl> <dt><b>D3DDEVCAPS_CANBLTSYSTONONLOCAL</b></dt> </dl> </td> <td
    ///width="60%"> Device supports blits from system-memory textures to nonlocal video-memory textures. </td> </tr>
    ///<tr> <td width="40%"><a id="D3DDEVCAPS_CANRENDERAFTERFLIP"></a><a id="d3ddevcaps_canrenderafterflip"></a><dl>
    ///<dt><b>D3DDEVCAPS_CANRENDERAFTERFLIP</b></dt> </dl> </td> <td width="60%"> Device can queue rendering commands
    ///after a page flip. Applications do not change their behavior if this flag is set; this capability means that the
    ///device is relatively fast. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_DRAWPRIMITIVES2"></a><a
    ///id="d3ddevcaps_drawprimitives2"></a><dl> <dt><b>D3DDEVCAPS_DRAWPRIMITIVES2</b></dt> </dl> </td> <td width="60%">
    ///Device can support at least a DirectX 5-compliant driver. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_DRAWPRIMITIVES2EX"></a><a id="d3ddevcaps_drawprimitives2ex"></a><dl>
    ///<dt><b>D3DDEVCAPS_DRAWPRIMITIVES2EX</b></dt> </dl> </td> <td width="60%"> Device can support at least a DirectX
    ///7-compliant driver. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_DRAWPRIMTLVERTEX"></a><a
    ///id="d3ddevcaps_drawprimtlvertex"></a><dl> <dt><b>D3DDEVCAPS_DRAWPRIMTLVERTEX</b></dt> </dl> </td> <td
    ///width="60%"> Device exports an IDirect3DDevice9::DrawPrimitive-aware hal. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_EXECUTESYSTEMMEMORY"></a><a id="d3ddevcaps_executesystemmemory"></a><dl>
    ///<dt><b>D3DDEVCAPS_EXECUTESYSTEMMEMORY</b></dt> </dl> </td> <td width="60%"> Device can use execute buffers from
    ///system memory. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_EXECUTEVIDEOMEMORY"></a><a
    ///id="d3ddevcaps_executevideomemory"></a><dl> <dt><b>D3DDEVCAPS_EXECUTEVIDEOMEMORY</b></dt> </dl> </td> <td
    ///width="60%"> Device can use execute buffers from video memory. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_HWRASTERIZATION"></a><a id="d3ddevcaps_hwrasterization"></a><dl>
    ///<dt><b>D3DDEVCAPS_HWRASTERIZATION</b></dt> </dl> </td> <td width="60%"> Device has hardware acceleration for
    ///scene rasterization. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_HWTRANSFORMANDLIGHT"></a><a
    ///id="d3ddevcaps_hwtransformandlight"></a><dl> <dt><b>D3DDEVCAPS_HWTRANSFORMANDLIGHT</b></dt> </dl> </td> <td
    ///width="60%"> Device can support transformation and lighting in hardware. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_NPATCHES"></a><a id="d3ddevcaps_npatches"></a><dl> <dt><b>D3DDEVCAPS_NPATCHES</b></dt> </dl> </td>
    ///<td width="60%"> Device supports N patches. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_PUREDEVICE"></a><a
    ///id="d3ddevcaps_puredevice"></a><dl> <dt><b>D3DDEVCAPS_PUREDEVICE</b></dt> </dl> </td> <td width="60%"> Device can
    ///support rasterization, transform, lighting, and shading in hardware. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_QUINTICRTPATCHES"></a><a id="d3ddevcaps_quinticrtpatches"></a><dl>
    ///<dt><b>D3DDEVCAPS_QUINTICRTPATCHES</b></dt> </dl> </td> <td width="60%"> Device supports quintic Bézier curves
    ///and B-splines. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_RTPATCHES"></a><a
    ///id="d3ddevcaps_rtpatches"></a><dl> <dt><b>D3DDEVCAPS_RTPATCHES</b></dt> </dl> </td> <td width="60%"> Device
    ///supports rectangular and triangular patches. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_RTPATCHHANDLEZERO"></a><a id="d3ddevcaps_rtpatchhandlezero"></a><dl>
    ///<dt><b>D3DDEVCAPS_RTPATCHHANDLEZERO</b></dt> </dl> </td> <td width="60%"> When this device capability is set, the
    ///hardware architecture does not require caching of any information, and uncached patches (handle zero) will be
    ///drawn as efficiently as cached ones. Note that setting D3DDEVCAPS_RTPATCHHANDLEZERO does not mean that a patch
    ///with handle zero can be drawn. A handle-zero patch can always be drawn whether this cap is set or not. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DDEVCAPS_SEPARATETEXTUREMEMORIES"></a><a
    ///id="d3ddevcaps_separatetexturememories"></a><dl> <dt><b>D3DDEVCAPS_SEPARATETEXTUREMEMORIES</b></dt> </dl> </td>
    ///<td width="60%"> Device is texturing from separate memory pools. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_TEXTURENONLOCALVIDMEM"></a><a id="d3ddevcaps_texturenonlocalvidmem"></a><dl>
    ///<dt><b>D3DDEVCAPS_TEXTURENONLOCALVIDMEM</b></dt> </dl> </td> <td width="60%"> Device can retrieve textures from
    ///non-local video memory. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_TEXTURESYSTEMMEMORY"></a><a
    ///id="d3ddevcaps_texturesystemmemory"></a><dl> <dt><b>D3DDEVCAPS_TEXTURESYSTEMMEMORY</b></dt> </dl> </td> <td
    ///width="60%"> Device can retrieve textures from system memory. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DDEVCAPS_TEXTUREVIDEOMEMORY"></a><a id="d3ddevcaps_texturevideomemory"></a><dl>
    ///<dt><b>D3DDEVCAPS_TEXTUREVIDEOMEMORY</b></dt> </dl> </td> <td width="60%"> Device can retrieve textures from
    ///device memory. </td> </tr> <tr> <td width="40%"><a id="D3DDEVCAPS_TLVERTEXSYSTEMMEMORY"></a><a
    ///id="d3ddevcaps_tlvertexsystemmemory"></a><dl> <dt><b>D3DDEVCAPS_TLVERTEXSYSTEMMEMORY</b></dt> </dl> </td> <td
    ///width="60%"> Device can use buffers from system memory for transformed and lit vertices. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DDEVCAPS_TLVERTEXVIDEOMEMORY"></a><a id="d3ddevcaps_tlvertexvideomemory"></a><dl>
    ///<dt><b>D3DDEVCAPS_TLVERTEXVIDEOMEMORY</b></dt> </dl> </td> <td width="60%"> Device can use buffers from video
    ///memory for transformed and lit vertices. </td> </tr> </table>
    uint              DevCaps;
    ///Type: <b>DWORD</b> Miscellaneous driver primitive capabilities. See D3DPMISCCAPS.
    uint              PrimitiveMiscCaps;
    ///Type: <b>DWORD</b> Information on raster-drawing capabilities. This member can be one or more of the following
    ///flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_ANISOTROPY"></a><a id="d3dprastercaps_anisotropy"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_ANISOTROPY</b></dt> </dl> </td> <td width="60%"> Device supports anisotropic filtering.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_COLORPERSPECTIVE"></a><a
    ///id="d3dprastercaps_colorperspective"></a><dl> <dt><b>D3DPRASTERCAPS_COLORPERSPECTIVE</b></dt> </dl> </td> <td
    ///width="60%"> Device iterates colors perspective correctly. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_DITHER"></a><a id="d3dprastercaps_dither"></a><dl> <dt><b>D3DPRASTERCAPS_DITHER</b></dt> </dl>
    ///</td> <td width="60%"> Device can dither to improve color resolution. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_DEPTHBIAS"></a><a id="d3dprastercaps_depthbias"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_DEPTHBIAS</b></dt> </dl> </td> <td width="60%"> Device supports legacy depth bias. For true
    ///depth bias, see D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_FOGRANGE"></a><a id="d3dprastercaps_fogrange"></a><dl> <dt><b>D3DPRASTERCAPS_FOGRANGE</b></dt>
    ///</dl> </td> <td width="60%"> Device supports range-based fog. In range-based fog, the distance of an object from
    ///the viewer is used to compute fog effects, not the depth of the object (that is, the z-coordinate) in the scene.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_FOGTABLE"></a><a id="d3dprastercaps_fogtable"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_FOGTABLE</b></dt> </dl> </td> <td width="60%"> Device calculates the fog value by referring
    ///to a lookup table containing fog values that are indexed to the depth of a given pixel. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPRASTERCAPS_FOGVERTEX"></a><a id="d3dprastercaps_fogvertex"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_FOGVERTEX</b></dt> </dl> </td> <td width="60%"> Device calculates the fog value during the
    ///lighting operation and interpolates the fog value during rasterization. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_MIPMAPLODBIAS"></a><a id="d3dprastercaps_mipmaplodbias"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_MIPMAPLODBIAS</b></dt> </dl> </td> <td width="60%"> Device supports level-of-detail bias
    ///adjustments. These bias adjustments enable an application to make a mipmap appear crisper or less sharp than it
    ///normally would. For more information about level-of-detail bias in mipmaps, see D3DSAMP_MIPMAPLODBIAS. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_MULTISAMPLE_TOGGLE"></a><a
    ///id="d3dprastercaps_multisample_toggle"></a><dl> <dt><b>D3DPRASTERCAPS_MULTISAMPLE_TOGGLE</b></dt> </dl> </td> <td
    ///width="60%"> Device supports toggling multisampling on and off between IDirect3DDevice9::BeginScene and
    ///IDirect3DDevice9::EndScene (using D3DRS_MULTISAMPLEANTIALIAS). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPRASTERCAPS_SCISSORTEST"></a><a id="d3dprastercaps_scissortest"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_SCISSORTEST</b></dt> </dl> </td> <td width="60%"> Device supports scissor test. See Scissor
    ///Test (Direct3D 9). </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS"></a><a
    ///id="d3dprastercaps_slopescaledepthbias"></a><dl> <dt><b>D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS</b></dt> </dl> </td>
    ///<td width="60%"> Device performs true slope-scale based depth bias. This is in contrast to the legacy style depth
    ///bias. </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_WBUFFER"></a><a id="d3dprastercaps_wbuffer"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_WBUFFER</b></dt> </dl> </td> <td width="60%"> Device supports depth buffering using w.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_WFOG"></a><a id="d3dprastercaps_wfog"></a><dl>
    ///<dt><b>D3DPRASTERCAPS_WFOG</b></dt> </dl> </td> <td width="60%"> Device supports w-based fog. W-based fog is used
    ///when a perspective projection matrix is specified, but affine projections still use z-based fog. The system
    ///considers a projection matrix that contains a nonzero value in the [3][4] element to be a perspective projection
    ///matrix. </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_ZBUFFERLESSHSR"></a><a
    ///id="d3dprastercaps_zbufferlesshsr"></a><dl> <dt><b>D3DPRASTERCAPS_ZBUFFERLESSHSR</b></dt> </dl> </td> <td
    ///width="60%"> Device can perform hidden-surface removal (HSR) without requiring the application to sort polygons
    ///and without requiring the allocation of a depth-buffer. This leaves more video memory for textures. The method
    ///used to perform HSR is hardware-dependent and is transparent to the application. Z-bufferless HSR is performed if
    ///no depth-buffer surface is associated with the rendering-target surface and the depth-buffer comparison test is
    ///enabled (that is, when the state value associated with the D3DRS_ZENABLE enumeration constant is set to
    ///<b>TRUE</b>). </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_ZFOG"></a><a
    ///id="d3dprastercaps_zfog"></a><dl> <dt><b>D3DPRASTERCAPS_ZFOG</b></dt> </dl> </td> <td width="60%"> Device
    ///supports z-based fog. </td> </tr> <tr> <td width="40%"><a id="D3DPRASTERCAPS_ZTEST"></a><a
    ///id="d3dprastercaps_ztest"></a><dl> <dt><b>D3DPRASTERCAPS_ZTEST</b></dt> </dl> </td> <td width="60%"> Device can
    ///perform z-test operations. This effectively renders a primitive and indicates whether any z pixels have been
    ///rendered. </td> </tr> </table>
    uint              RasterCaps;
    ///Type: <b>DWORD</b> Z-buffer comparison capabilities. This member can be one or more of the following flags.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_ALWAYS"></a><a
    ///id="d3dpcmpcaps_always"></a><dl> <dt><b>D3DPCMPCAPS_ALWAYS</b></dt> </dl> </td> <td width="60%"> Always pass the
    ///z-test. </td> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_EQUAL"></a><a id="d3dpcmpcaps_equal"></a><dl>
    ///<dt><b>D3DPCMPCAPS_EQUAL</b></dt> </dl> </td> <td width="60%"> Pass the z-test if the new z equals the current z.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_GREATER"></a><a id="d3dpcmpcaps_greater"></a><dl>
    ///<dt><b>D3DPCMPCAPS_GREATER</b></dt> </dl> </td> <td width="60%"> Pass the z-test if the new z is greater than the
    ///current z. </td> </tr> <tr> <td width="40%"><a id="D3DPCMPCAPS_GREATEREQUAL"></a><a
    ///id="d3dpcmpcaps_greaterequal"></a><dl> <dt><b>D3DPCMPCAPS_GREATEREQUAL</b></dt> </dl> </td> <td width="60%"> Pass
    ///the z-test if the new z is greater than or equal to the current z. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPCMPCAPS_LESS"></a><a id="d3dpcmpcaps_less"></a><dl> <dt><b>D3DPCMPCAPS_LESS</b></dt> </dl> </td> <td
    ///width="60%"> Pass the z-test if the new z is less than the current z. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPCMPCAPS_LESSEQUAL"></a><a id="d3dpcmpcaps_lessequal"></a><dl> <dt><b>D3DPCMPCAPS_LESSEQUAL</b></dt> </dl>
    ///</td> <td width="60%"> Pass the z-test if the new z is less than or equal to the current z. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPCMPCAPS_NEVER"></a><a id="d3dpcmpcaps_never"></a><dl> <dt><b>D3DPCMPCAPS_NEVER</b></dt>
    ///</dl> </td> <td width="60%"> Always fail the z-test. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPCMPCAPS_NOTEQUAL"></a><a id="d3dpcmpcaps_notequal"></a><dl> <dt><b>D3DPCMPCAPS_NOTEQUAL</b></dt> </dl>
    ///</td> <td width="60%"> Pass the z-test if the new z does not equal the current z. </td> </tr> </table>
    uint              ZCmpCaps;
    ///Type: <b>DWORD</b> Source-blending capabilities. This member can be one or more of the following flags. (The RGBA
    ///values of the source and destination are indicated by the subscripts s and d.) <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_BLENDFACTOR"></a><a
    ///id="d3dpblendcaps_blendfactor"></a><dl> <dt><b>D3DPBLENDCAPS_BLENDFACTOR</b></dt> </dl> </td> <td width="60%">
    ///The driver supports both D3DBLEND_BLENDFACTOR and D3DBLEND_INVBLENDFACTOR. See D3DBLEND. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPBLENDCAPS_BOTHINVSRCALPHA"></a><a id="d3dpblendcaps_bothinvsrcalpha"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_BOTHINVSRCALPHA</b></dt> </dl> </td> <td width="60%"> Source blend factor is (1 - Aₛ, 1 -
    ///Aₛ, 1 - Aₛ, 1 - Aₛ) and destination blend factor is (Aₛ, Aₛ, Aₛ, Aₛ); the destination blend
    ///selection is overridden. </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_BOTHSRCALPHA"></a><a
    ///id="d3dpblendcaps_bothsrcalpha"></a><dl> <dt><b>D3DPBLENDCAPS_BOTHSRCALPHA</b></dt> </dl> </td> <td width="60%">
    ///The driver supports the D3DBLEND_BOTHSRCALPHA blend mode. (This blend mode is obsolete. For more information, see
    ///D3DBLEND.) </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_DESTALPHA"></a><a
    ///id="d3dpblendcaps_destalpha"></a><dl> <dt><b>D3DPBLENDCAPS_DESTALPHA</b></dt> </dl> </td> <td width="60%"> Blend
    ///factor is (A<sub>d</sub>, A<sub>d</sub>, A<sub>d</sub>, A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_DESTCOLOR"></a><a id="d3dpblendcaps_destcolor"></a><dl> <dt><b>D3DPBLENDCAPS_DESTCOLOR</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (R<sub>d</sub>, G<sub>d</sub>, B<sub>d</sub>, A<sub>d</sub>). </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_INVDESTALPHA"></a><a id="d3dpblendcaps_invdestalpha"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVDESTALPHA</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 - A<sub>d</sub>, 1 -
    ///A<sub>d</sub>, 1 - A<sub>d</sub>, 1 - A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_INVDESTCOLOR"></a><a id="d3dpblendcaps_invdestcolor"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVDESTCOLOR</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 - R<sub>d</sub>, 1 -
    ///G<sub>d</sub>, 1 - B<sub>d</sub>, 1 - A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_INVSRCALPHA"></a><a id="d3dpblendcaps_invsrcalpha"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVSRCALPHA</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 - Aₛ, 1 - Aₛ, 1 -
    ///Aₛ, 1 - Aₛ). </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_INVSRCCOLOR"></a><a
    ///id="d3dpblendcaps_invsrccolor"></a><dl> <dt><b>D3DPBLENDCAPS_INVSRCCOLOR</b></dt> </dl> </td> <td width="60%">
    ///Blend factor is (1 - Rₛ, 1 - Gₛ, 1 - Bₛ, 1 - Aₛ). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_INVSRCCOLOR2"></a><a id="d3dpblendcaps_invsrccolor2"></a><dl>
    ///<dt><b>D3DPBLENDCAPS_INVSRCCOLOR2</b></dt> </dl> </td> <td width="60%"> Blend factor is (1 -
    ///PSOutColor[1]<sub>r</sub>, 1 - PSOutColor[1]<sub>g</sub>, 1 - PSOutColor[1]<sub>b</sub>, not used)). See Render
    ///Target Blending. <table> <tr> <td> Differences between Direct3D 9 and Direct3D 9Ex: This flag is available in
    ///Direct3D 9Ex only. </td> </tr> </table> </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_ONE"></a><a
    ///id="d3dpblendcaps_one"></a><dl> <dt><b>D3DPBLENDCAPS_ONE</b></dt> </dl> </td> <td width="60%"> Blend factor is
    ///(1, 1, 1, 1). </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_SRCALPHA"></a><a
    ///id="d3dpblendcaps_srcalpha"></a><dl> <dt><b>D3DPBLENDCAPS_SRCALPHA</b></dt> </dl> </td> <td width="60%"> Blend
    ///factor is (Aₛ, Aₛ, Aₛ, Aₛ). </td> </tr> <tr> <td width="40%"><a id="D3DPBLENDCAPS_SRCALPHASAT"></a><a
    ///id="d3dpblendcaps_srcalphasat"></a><dl> <dt><b>D3DPBLENDCAPS_SRCALPHASAT</b></dt> </dl> </td> <td width="60%">
    ///Blend factor is (f, f, f, 1); f = min(Aₛ, 1 - A<sub>d</sub>). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_SRCCOLOR"></a><a id="d3dpblendcaps_srccolor"></a><dl> <dt><b>D3DPBLENDCAPS_SRCCOLOR</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (Rₛ, Gₛ, Bₛ, Aₛ). </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPBLENDCAPS_SRCCOLOR2"></a><a id="d3dpblendcaps_srccolor2"></a><dl> <dt><b>D3DPBLENDCAPS_SRCCOLOR2</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (PSOutColor[1]<sub>r</sub>, PSOutColor[1]<sub>g</sub>,
    ///PSOutColor[1]<sub>b</sub>, not used). See Render Target Blending. <table> <tr> <td> Differences between Direct3D
    ///9 and Direct3D 9Ex: This flag is available in Direct3D 9Ex only. </td> </tr> </table> </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPBLENDCAPS_ZERO"></a><a id="d3dpblendcaps_zero"></a><dl> <dt><b>D3DPBLENDCAPS_ZERO</b></dt>
    ///</dl> </td> <td width="60%"> Blend factor is (0, 0, 0, 0). </td> </tr> </table>
    uint              SrcBlendCaps;
    ///Type: <b>DWORD</b> Destination-blending capabilities. This member can be the same capabilities that are defined
    ///for the SrcBlendCaps member.
    uint              DestBlendCaps;
    ///Type: <b>DWORD</b> Alpha-test comparison capabilities. This member can include the same capability flags defined
    ///for the ZCmpCaps member. If this member contains only the D3DPCMPCAPS_ALWAYS capability or only the
    ///D3DPCMPCAPS_NEVER capability, the driver does not support alpha tests. Otherwise, the flags identify the
    ///individual comparisons that are supported for alpha testing.
    uint              AlphaCmpCaps;
    ///Type: <b>DWORD</b> Shading operations capabilities. It is assumed, in general, that if a device supports a given
    ///command at all, it supports the D3DSHADE_FLAT mode (as specified in the D3DSHADEMODE enumerated type). This flag
    ///specifies whether the driver can also support Gouraud shading and whether alpha color components are supported.
    ///When alpha components are not supported, the alpha value of colors generated is implicitly 255. This is the
    ///maximum possible alpha (that is, the alpha component is at full intensity). The color, specular highlights, fog,
    ///and alpha interpolants of a triangle each have capability flags that an application can use to find out how they
    ///are implemented by the device driver. This member can be one or more of the following flags. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DPSHADECAPS_ALPHAGOURAUDBLEND"></a><a
    ///id="d3dpshadecaps_alphagouraudblend"></a><dl> <dt><b>D3DPSHADECAPS_ALPHAGOURAUDBLEND</b></dt> </dl> </td> <td
    ///width="60%"> Device can support an alpha component for Gouraud-blended transparency (the D3DSHADE_GOURAUD state
    ///for the D3DSHADEMODE enumerated type). In this mode, the alpha color component of a primitive is provided at
    ///vertices and interpolated across a face along with the other color components. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPSHADECAPS_COLORGOURAUDRGB"></a><a id="d3dpshadecaps_colorgouraudrgb"></a><dl>
    ///<dt><b>D3DPSHADECAPS_COLORGOURAUDRGB</b></dt> </dl> </td> <td width="60%"> Device can support colored Gouraud
    ///shading. In this mode, the per-vertex color components (red, green, and blue) are interpolated across a triangle
    ///face. </td> </tr> <tr> <td width="40%"><a id="D3DPSHADECAPS_FOGGOURAUD"></a><a
    ///id="d3dpshadecaps_foggouraud"></a><dl> <dt><b>D3DPSHADECAPS_FOGGOURAUD</b></dt> </dl> </td> <td width="60%">
    ///Device can support fog in the Gouraud shading mode. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPSHADECAPS_SPECULARGOURAUDRGB"></a><a id="d3dpshadecaps_speculargouraudrgb"></a><dl>
    ///<dt><b>D3DPSHADECAPS_SPECULARGOURAUDRGB</b></dt> </dl> </td> <td width="60%"> Device supports Gouraud shading of
    ///specular highlights. </td> </tr> </table>
    uint              ShadeCaps;
    ///Type: <b>DWORD</b> Miscellaneous texture-mapping capabilities. This member can be one or more of the following
    ///flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_ALPHA"></a><a id="d3dptexturecaps_alpha"></a><dl> <dt><b>D3DPTEXTURECAPS_ALPHA</b></dt> </dl>
    ///</td> <td width="60%"> Alpha in texture pixels is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_ALPHAPALETTE"></a><a id="d3dptexturecaps_alphapalette"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_ALPHAPALETTE</b></dt> </dl> </td> <td width="60%"> Device can draw alpha from texture
    ///palettes. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_CUBEMAP"></a><a
    ///id="d3dptexturecaps_cubemap"></a><dl> <dt><b>D3DPTEXTURECAPS_CUBEMAP</b></dt> </dl> </td> <td width="60%">
    ///Supports cube textures. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_CUBEMAP_POW2"></a><a
    ///id="d3dptexturecaps_cubemap_pow2"></a><dl> <dt><b>D3DPTEXTURECAPS_CUBEMAP_POW2</b></dt> </dl> </td> <td
    ///width="60%"> Device requires that cube texture maps have dimensions specified as powers of two. </td> </tr> <tr>
    ///<td width="40%"><a id="D3DPTEXTURECAPS_MIPCUBEMAP"></a><a id="d3dptexturecaps_mipcubemap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_MIPCUBEMAP</b></dt> </dl> </td> <td width="60%"> Device supports mipmapped cube textures.
    ///</td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_MIPMAP"></a><a id="d3dptexturecaps_mipmap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_MIPMAP</b></dt> </dl> </td> <td width="60%"> Device supports mipmapped textures. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_MIPVOLUMEMAP"></a><a id="d3dptexturecaps_mipvolumemap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_MIPVOLUMEMAP</b></dt> </dl> </td> <td width="60%"> Device supports mipmapped volume
    ///textures. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_NONPOW2CONDITIONAL"></a><a
    ///id="d3dptexturecaps_nonpow2conditional"></a><dl> <dt><b>D3DPTEXTURECAPS_NONPOW2CONDITIONAL</b></dt> </dl> </td>
    ///<td width="60%"> D3DPTEXTURECAPS_POW2 is also set, conditionally supports the use of 2D textures with dimensions
    ///that are not powers of two. A device that exposes this capability can use such a texture if all of the following
    ///requirements are met. <ul> <li>The texture addressing mode for the texture stage is set to
    ///D3DTADDRESS_CLAMP.</li> <li>Texture wrapping for the texture stage is disabled (D3DRS_WRAP n set to 0).</li>
    ///<li>Mipmapping is not in use (use magnification filter only).</li> <li>Texture formats must not be D3DFMT_DXT1
    ///through D3DFMT_DXT5.</li> </ul> If this flag is not set, and D3DPTEXTURECAPS_POW2 is also not set, then
    ///unconditional support is provided for 2D textures with dimensions that are not powers of two. A texture that is
    ///not a power of two cannot be set at a stage that will be read based on a shader computation (such as the bem - ps
    ///and texm3x3 - ps instructions in pixel shaders versions 1_0 to 1_3). For example, these textures can be used to
    ///store bumps that will be fed into texture reads, but not the environment maps that are used in texbem - ps,
    ///texbeml - ps, and texm3x3spec - ps. This means that a texture with dimensions that are not powers of two cannot
    ///be addressed or sampled using texture coordinates computed within the shader. This type of operation is known as
    ///a dependent read and cannot be performed on these types of textures. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_NOPROJECTEDBUMPENV"></a><a id="d3dptexturecaps_noprojectedbumpenv"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_NOPROJECTEDBUMPENV</b></dt> </dl> </td> <td width="60%"> Device does not support a
    ///projected bump-environment loopkup operation in programmable and fixed function shaders. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPTEXTURECAPS_PERSPECTIVE"></a><a id="d3dptexturecaps_perspective"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_PERSPECTIVE</b></dt> </dl> </td> <td width="60%"> Perspective correction texturing is
    ///supported. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_POW2"></a><a
    ///id="d3dptexturecaps_pow2"></a><dl> <dt><b>D3DPTEXTURECAPS_POW2</b></dt> </dl> </td> <td width="60%"> If
    ///D3DPTEXTURECAPS_NONPOW2CONDITIONAL is not set, all textures must have widths and heights specified as powers of
    ///two. This requirement does not apply to either cube textures or volume textures. If
    ///D3DPTEXTURECAPS_NONPOW2CONDITIONAL is also set, conditionally supports the use of 2D textures with dimensions
    ///that are not powers of two. See D3DPTEXTURECAPS_NONPOW2CONDITIONAL description. If this flag is not set, and
    ///D3DPTEXTURECAPS_NONPOW2CONDITIONAL is also not set, then unconditional support is provided for 2D textures with
    ///dimensions that are not powers of two. </td> </tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_PROJECTED"></a><a
    ///id="d3dptexturecaps_projected"></a><dl> <dt><b>D3DPTEXTURECAPS_PROJECTED</b></dt> </dl> </td> <td width="60%">
    ///Supports the D3DTTFF_PROJECTED texture transformation flag. When applied, the device divides transformed texture
    ///coordinates by the last texture coordinate. If this capability is present, then the projective divide occurs per
    ///pixel. If this capability is not present, but the projective divide needs to occur anyway, then it is performed
    ///on a per-vertex basis by the Direct3D runtime. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTEXTURECAPS_SQUAREONLY"></a><a id="d3dptexturecaps_squareonly"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_SQUAREONLY</b></dt> </dl> </td> <td width="60%"> All textures must be square. </td> </tr>
    ///<tr> <td width="40%"><a id="D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE"></a><a
    ///id="d3dptexturecaps_texrepeatnotscaledbysize"></a><dl> <dt><b>D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE</b></dt>
    ///</dl> </td> <td width="60%"> Texture indices are not scaled by the texture size prior to interpolation. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_VOLUMEMAP"></a><a id="d3dptexturecaps_volumemap"></a><dl>
    ///<dt><b>D3DPTEXTURECAPS_VOLUMEMAP</b></dt> </dl> </td> <td width="60%"> Device supports volume textures. </td>
    ///</tr> <tr> <td width="40%"><a id="D3DPTEXTURECAPS_VOLUMEMAP_POW2"></a><a
    ///id="d3dptexturecaps_volumemap_pow2"></a><dl> <dt><b>D3DPTEXTURECAPS_VOLUMEMAP_POW2</b></dt> </dl> </td> <td
    ///width="60%"> Device requires that volume texture maps have dimensions specified as powers of two. </td> </tr>
    ///</table>
    uint              TextureCaps;
    ///Type: <b>DWORD</b> Texture-filtering capabilities for a texture. Per-stage filtering capabilities reflect which
    ///filtering modes are supported for texture stages when performing multiple-texture blending. This member can be
    ///any combination of the per-stage texture-filtering flags defined in D3DPTFILTERCAPS.
    uint              TextureFilterCaps;
    ///Type: <b>DWORD</b> Texture-filtering capabilities for a cube texture. Per-stage filtering capabilities reflect
    ///which filtering modes are supported for texture stages when performing multiple-texture blending. This member can
    ///be any combination of the per-stage texture-filtering flags defined in D3DPTFILTERCAPS.
    uint              CubeTextureFilterCaps;
    ///Type: <b>DWORD</b> Texture-filtering capabilities for a volume texture. Per-stage filtering capabilities reflect
    ///which filtering modes are supported for texture stages when performing multiple-texture blending. This member can
    ///be any combination of the per-stage texture-filtering flags defined in D3DPTFILTERCAPS.
    uint              VolumeTextureFilterCaps;
    ///Type: <b>DWORD</b> Texture-addressing capabilities for texture objects. This member can be one or more of the
    ///following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_BORDER"></a><a id="d3dptaddresscaps_border"></a><dl> <dt><b>D3DPTADDRESSCAPS_BORDER</b></dt>
    ///</dl> </td> <td width="60%"> Device supports setting coordinates outside the range [0.0, 1.0] to the border
    ///color, as specified by the D3DSAMP_BORDERCOLOR texture-stage state. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_CLAMP"></a><a id="d3dptaddresscaps_clamp"></a><dl> <dt><b>D3DPTADDRESSCAPS_CLAMP</b></dt>
    ///</dl> </td> <td width="60%"> Device can clamp textures to addresses. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_INDEPENDENTUV"></a><a id="d3dptaddresscaps_independentuv"></a><dl>
    ///<dt><b>D3DPTADDRESSCAPS_INDEPENDENTUV</b></dt> </dl> </td> <td width="60%"> Device can separate the
    ///texture-addressing modes of the u and v coordinates of the texture. This ability corresponds to the
    ///D3DSAMP_ADDRESSU and D3DSAMP_ADDRESSV render-state values. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_MIRROR"></a><a id="d3dptaddresscaps_mirror"></a><dl> <dt><b>D3DPTADDRESSCAPS_MIRROR</b></dt>
    ///</dl> </td> <td width="60%"> Device can mirror textures to addresses. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DPTADDRESSCAPS_MIRRORONCE"></a><a id="d3dptaddresscaps_mirroronce"></a><dl>
    ///<dt><b>D3DPTADDRESSCAPS_MIRRORONCE</b></dt> </dl> </td> <td width="60%"> Device can take the absolute value of
    ///the texture coordinate (thus, mirroring around 0) and then clamp to the maximum value. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DPTADDRESSCAPS_WRAP"></a><a id="d3dptaddresscaps_wrap"></a><dl>
    ///<dt><b>D3DPTADDRESSCAPS_WRAP</b></dt> </dl> </td> <td width="60%"> Device can wrap textures to addresses. </td>
    ///</tr> </table>
    uint              TextureAddressCaps;
    ///Type: <b>DWORD</b> Texture-addressing capabilities for a volume texture. This member can be one or more of the
    ///flags defined for the TextureAddressCaps member.
    uint              VolumeTextureAddressCaps;
    ///Type: <b>DWORD</b> Defines the capabilities for line-drawing primitives. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_ALPHACMP"></a><a
    ///id="d3dlinecaps_alphacmp"></a><dl> <dt><b>D3DLINECAPS_ALPHACMP</b></dt> </dl> </td> <td width="60%"> Supports
    ///alpha-test comparisons. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_ANTIALIAS"></a><a
    ///id="d3dlinecaps_antialias"></a><dl> <dt><b>D3DLINECAPS_ANTIALIAS</b></dt> </dl> </td> <td width="60%">
    ///Antialiased lines are supported. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_BLEND"></a><a
    ///id="d3dlinecaps_blend"></a><dl> <dt><b>D3DLINECAPS_BLEND</b></dt> </dl> </td> <td width="60%"> Supports
    ///source-blending. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_FOG"></a><a id="d3dlinecaps_fog"></a><dl>
    ///<dt><b>D3DLINECAPS_FOG</b></dt> </dl> </td> <td width="60%"> Supports fog. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DLINECAPS_TEXTURE"></a><a id="d3dlinecaps_texture"></a><dl> <dt><b>D3DLINECAPS_TEXTURE</b></dt> </dl> </td>
    ///<td width="60%"> Supports texture-mapping. </td> </tr> <tr> <td width="40%"><a id="D3DLINECAPS_ZTEST"></a><a
    ///id="d3dlinecaps_ztest"></a><dl> <dt><b>D3DLINECAPS_ZTEST</b></dt> </dl> </td> <td width="60%"> Supports z-buffer
    ///comparisons. </td> </tr> </table>
    uint              LineCaps;
    ///Type: <b>DWORD</b> Maximum texture width for this device.
    uint              MaxTextureWidth;
    ///Type: <b>DWORD</b> Maximum texture height for this device.
    uint              MaxTextureHeight;
    ///Type: <b>DWORD</b> Maximum value for any of the three dimensions (width, height, and depth) of a volume texture.
    uint              MaxVolumeExtent;
    ///Type: <b>DWORD</b> This number represents the maximum range of the integer bits of the post-normalized texture
    ///coordinates. A texture coordinate is stored as a 32-bit signed integer using 27 bits to store the integer part
    ///and 5 bits for the floating point fraction. The maximum integer index, 2²⁷, is used to determine the maximum
    ///texture coordinate, depending on how the hardware does texture-coordinate scaling. Some hardware reports the cap
    ///D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE. For this case, the device defers scaling texture coordinates by the
    ///texture size until after interpolation and application of the texture address mode, so the number of times a
    ///texture can be wrapped is given by the integer value in MaxTextureRepeat. Less desirably, on some hardware
    ///D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE is not set and the device scales the texture coordinates by the texture
    ///size (using the highest level of detail) prior to interpolation. This limits the number of times a texture can be
    ///wrapped to MaxTextureRepeat / texture size. For example, assume that MaxTextureRepeat is equal to 32k and the
    ///size of the texture is 4k. If the hardware sets D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE, then the number of
    ///times a texture can be wrapped is equal to MaxTextureRepeat, which is 32k in this example. Otherwise, the number
    ///of times a texture can be wrapped is equal to MaxTextureRepeat divided by texture size, which is 32k/4k in this
    ///example.
    uint              MaxTextureRepeat;
    ///Type: <b>DWORD</b> Maximum texture aspect ratio supported by the hardware, typically a power of 2.
    uint              MaxTextureAspectRatio;
    ///Type: <b>DWORD</b> Maximum valid value for the D3DSAMP_MAXANISOTROPY texture-stage state.
    uint              MaxAnisotropy;
    ///Type: <b>float</b> Maximum W-based depth value that the device supports.
    float             MaxVertexW;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandLeft;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandTop;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandRight;
    ///Type: <b>float</b> Screen-space coordinate of the guard-band clipping region. Coordinates inside this rectangle
    ///but outside the viewport rectangle are automatically clipped.
    float             GuardBandBottom;
    ///Type: <b>float</b> Number of pixels to adjust the extents rectangle outward to accommodate antialiasing kernels.
    float             ExtentsAdjust;
    ///Type: <b>DWORD</b> Flags specifying supported stencil-buffer operations. Stencil operations are assumed to be
    ///valid for all three stencil-buffer operation render states (D3DRS_STENCILFAIL, D3DRS_STENCILPASS, and
    ///D3DRS_STENCILZFAIL). For more information, see D3DSTENCILCAPS.
    uint              StencilCaps;
    ///Type: <b>DWORD</b> Flexible vertex format capabilities. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="D3DFVFCAPS_DONOTSTRIPELEMENTS"></a><a id="d3dfvfcaps_donotstripelements"></a><dl>
    ///<dt><b>D3DFVFCAPS_DONOTSTRIPELEMENTS</b></dt> </dl> </td> <td width="60%"> It is preferable that vertex elements
    ///not be stripped. That is, if the vertex format contains elements that are not used with the current render
    ///states, there is no need to regenerate the vertices. If this capability flag is not present, stripping extraneous
    ///elements from the vertex format provides better performance. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DFVFCAPS_PSIZE"></a><a id="d3dfvfcaps_psize"></a><dl> <dt><b>D3DFVFCAPS_PSIZE</b></dt> </dl> </td> <td
    ///width="60%"> Point size is determined by either the render state or the vertex data. If an FVF is used, point
    ///size can come from point size data in the vertex declaration. Otherwise, point size is determined by the render
    ///state D3DRS_POINTSIZE. If the application provides point size in both (the render state and the vertex
    ///declaration), the vertex data overrides the render-state data. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DFVFCAPS_TEXCOORDCOUNTMASK"></a><a id="d3dfvfcaps_texcoordcountmask"></a><dl>
    ///<dt><b>D3DFVFCAPS_TEXCOORDCOUNTMASK</b></dt> </dl> </td> <td width="60%"> Masks the low WORD of FVFCaps. These
    ///bits, cast to the WORD data type, describe the total number of texture coordinate sets that the device can
    ///simultaneously use for multiple texture blending. (You can use up to eight texture coordinate sets for any
    ///vertex, but the device can blend using only the specified number of texture coordinate sets.) </td> </tr>
    ///</table>
    uint              FVFCaps;
    ///Type: <b>DWORD</b> Combination of flags describing the texture operations supported by this device. The following
    ///flags are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_ADD"></a><a id="d3dtexopcaps_add"></a><dl> <dt><b>D3DTEXOPCAPS_ADD</b></dt> </dl> </td> <td
    ///width="60%"> The D3DTOP_ADD texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_ADDSIGNED"></a><a id="d3dtexopcaps_addsigned"></a><dl> <dt><b>D3DTEXOPCAPS_ADDSIGNED</b></dt>
    ///</dl> </td> <td width="60%"> The D3DTOP_ADDSIGNED texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_ADDSIGNED2X"></a><a id="d3dtexopcaps_addsigned2x"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_ADDSIGNED2X</b></dt> </dl> </td> <td width="60%"> The D3DTOP_ADDSIGNED2X texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_ADDSMOOTH"></a><a
    ///id="d3dtexopcaps_addsmooth"></a><dl> <dt><b>D3DTEXOPCAPS_ADDSMOOTH</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_ADDSMOOTH texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDCURRENTALPHA"></a><a id="d3dtexopcaps_blendcurrentalpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDCURRENTALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDCURRENTALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDDIFFUSEALPHA"></a><a id="d3dtexopcaps_blenddiffusealpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDDIFFUSEALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDDIFFUSEALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDFACTORALPHA"></a><a id="d3dtexopcaps_blendfactoralpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDFACTORALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDFACTORALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDTEXTUREALPHA"></a><a id="d3dtexopcaps_blendtexturealpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDTEXTUREALPHA</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDTEXTUREALPHA
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BLENDTEXTUREALPHAPM"></a><a id="d3dtexopcaps_blendtexturealphapm"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BLENDTEXTUREALPHAPM</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BLENDTEXTUREALPHAPM
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_BUMPENVMAP"></a><a
    ///id="d3dtexopcaps_bumpenvmap"></a><dl> <dt><b>D3DTEXOPCAPS_BUMPENVMAP</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_BUMPENVMAP texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_BUMPENVMAPLUMINANCE"></a><a id="d3dtexopcaps_bumpenvmapluminance"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_BUMPENVMAPLUMINANCE</b></dt> </dl> </td> <td width="60%"> The D3DTOP_BUMPENVMAPLUMINANCE
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_DISABLE"></a><a
    ///id="d3dtexopcaps_disable"></a><dl> <dt><b>D3DTEXOPCAPS_DISABLE</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_DISABLE texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_DOTPRODUCT3"></a><a id="d3dtexopcaps_dotproduct3"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_DOTPRODUCT3</b></dt> </dl> </td> <td width="60%"> The D3DTOP_DOTPRODUCT3 texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_LERP"></a><a
    ///id="d3dtexopcaps_lerp"></a><dl> <dt><b>D3DTEXOPCAPS_LERP</b></dt> </dl> </td> <td width="60%"> The D3DTOP_LERP
    ///texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_MODULATE"></a><a
    ///id="d3dtexopcaps_modulate"></a><dl> <dt><b>D3DTEXOPCAPS_MODULATE</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATE texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MODULATE2X"></a><a id="d3dtexopcaps_modulate2x"></a><dl> <dt><b>D3DTEXOPCAPS_MODULATE2X</b></dt>
    ///</dl> </td> <td width="60%"> The D3DTOP_MODULATE2X texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_MODULATE4X"></a><a id="d3dtexopcaps_modulate4x"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATE4X</b></dt> </dl> </td> <td width="60%"> The D3DTOP_MODULATE4X texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR"></a><a
    ///id="d3dtexopcaps_modulatealpha_addcolor"></a><dl> <dt><b>D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR</b></dt> </dl> </td>
    ///<td width="60%"> The D3DTOP_MODULATEALPHA_ADDCOLOR texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA"></a><a id="d3dtexopcaps_modulatecolor_addalpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATECOLOR_ADDALPHA texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR"></a><a id="d3dtexopcaps_modulateinvalpha_addcolor"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATEINVALPHA_ADDCOLOR texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA"></a><a id="d3dtexopcaps_modulateinvcolor_addalpha"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_MODULATEINVCOLOR_ADDALPHA texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_MULTIPLYADD"></a><a id="d3dtexopcaps_multiplyadd"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_MULTIPLYADD</b></dt> </dl> </td> <td width="60%"> The D3DTOP_MULTIPLYADD texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_PREMODULATE"></a><a
    ///id="d3dtexopcaps_premodulate"></a><dl> <dt><b>D3DTEXOPCAPS_PREMODULATE</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_PREMODULATE texture-blending operation is supported. </td> </tr> <tr> <td width="40%"><a
    ///id="D3DTEXOPCAPS_SELECTARG1"></a><a id="d3dtexopcaps_selectarg1"></a><dl> <dt><b>D3DTEXOPCAPS_SELECTARG1</b></dt>
    ///</dl> </td> <td width="60%"> The D3DTOP_SELECTARG1 texture-blending operation is supported. </td> </tr> <tr> <td
    ///width="40%"><a id="D3DTEXOPCAPS_SELECTARG2"></a><a id="d3dtexopcaps_selectarg2"></a><dl>
    ///<dt><b>D3DTEXOPCAPS_SELECTARG2</b></dt> </dl> </td> <td width="60%"> The D3DTOP_SELECTARG2 texture-blending
    ///operation is supported. </td> </tr> <tr> <td width="40%"><a id="D3DTEXOPCAPS_SUBTRACT"></a><a
    ///id="d3dtexopcaps_subtract"></a><dl> <dt><b>D3DTEXOPCAPS_SUBTRACT</b></dt> </dl> </td> <td width="60%"> The
    ///D3DTOP_SUBTRACT texture-blending operation is supported. </td> </tr> </table>
    uint              TextureOpCaps;
    ///Type: <b>DWORD</b> Maximum number of texture-blending stages supported in the fixed function pipeline. This value
    ///is the number of blenders available. In the programmable pixel pipeline, this corresponds to the number of unique
    ///texture registers used by pixel shader instructions.
    uint              MaxTextureBlendStages;
    ///Type: <b>DWORD</b> Maximum number of textures that can be simultaneously bound to the fixed-function pipeline
    ///sampler stages. If the same texture is bound to two sampler stages, it counts as two textures. This value has no
    ///meaning in the programmable pipeline where the number of sampler stages is determined by each pixel shader
    ///version. Each pixel shader version also determines the number of texture declaration instructions. See Pixel
    ///Shaders.
    uint              MaxSimultaneousTextures;
    ///Type: <b>DWORD</b> Vertex processing capabilities. For a given physical device, this capability might vary across
    ///Direct3D devices depending on the parameters supplied to CreateDevice. See D3DVTXPCAPS.
    uint              VertexProcessingCaps;
    ///Type: <b>DWORD</b> Maximum number of lights that can be active simultaneously. For a given physical device, this
    ///capability might vary across Direct3D devices depending on the parameters supplied to CreateDevice.
    uint              MaxActiveLights;
    ///Type: <b>DWORD</b> Maximum number of user-defined clipping planes supported. This member can be 0. For a given
    ///physical device, this capability may vary across Direct3D devices depending on the parameters supplied to
    ///CreateDevice.
    uint              MaxUserClipPlanes;
    ///Type: <b>DWORD</b> Maximum number of matrices that this device can apply when performing multimatrix vertex
    ///blending. For a given physical device, this capability may vary across Direct3D devices depending on the
    ///parameters supplied to CreateDevice.
    uint              MaxVertexBlendMatrices;
    ///Type: <b>DWORD</b> DWORD value that specifies the maximum matrix index that can be indexed into using the
    ///per-vertex indices. The number of matrices is MaxVertexBlendMatrixIndex + 1, which is the size of the matrix
    ///palette. If normals are present in the vertex data that needs to be blended for lighting, then the number of
    ///matrices is half the number specified by this capability flag. If MaxVertexBlendMatrixIndex is set to zero, the
    ///driver does not support indexed vertex blending. If this value is not zero then the valid range of indices is
    ///zero through MaxVertexBlendMatrixIndex. A zero value for MaxVertexBlendMatrixIndex indicates that the driver does
    ///not support indexed matrices. When software vertex processing is used, 256 matrices could be used for indexed
    ///vertex blending, with or without normal blending. For a given physical device, this capability may vary across
    ///Direct3D devices depending on the parameters supplied to CreateDevice.
    uint              MaxVertexBlendMatrixIndex;
    ///Type: <b>float</b> Maximum size of a point primitive. If set to 1.0f then device does not support point size
    ///control. The range is greater than or equal to 1.0f.
    float             MaxPointSize;
    ///Type: <b>DWORD</b> Maximum number of primitives for each DrawPrimitive call. There are two cases: <ul> <li>If
    ///MaxPrimitiveCount is not equal to 0xffff, you can draw at most MaxPrimitiveCount primitives with each draw
    ///call.</li> <li>However, if MaxPrimitiveCount equals 0xffff, you can still draw at most MaxPrimitiveCount
    ///primitive, but you may also use no more than MaxPrimitiveCount unique vertices (since each primitive can
    ///potentially use three different vertices).</li> </ul>
    uint              MaxPrimitiveCount;
    ///Type: <b>DWORD</b> Maximum size of indices supported for hardware vertex processing. It is possible to create
    ///32-bit index buffers; however, you will not be able to render with the index buffer unless this value is greater
    ///than 0x0000FFFF.
    uint              MaxVertexIndex;
    ///Type: <b>DWORD</b> Maximum number of concurrent data streams for SetStreamSource. The valid range is 1 to 16.
    ///Note that if this value is 0, then the driver is not a Direct3D 9 driver.
    uint              MaxStreams;
    ///Type: <b>DWORD</b> Maximum stride for SetStreamSource.
    uint              MaxStreamStride;
    ///Type: <b>DWORD</b> Two numbers that represent the vertex shader main and sub versions. For more information about
    ///the instructions supported for each vertex shader version, see Version 1_x, Version 2_0, Version 2_0 Extended, or
    ///Version 3_0.
    uint              VertexShaderVersion;
    ///Type: <b>DWORD</b> The number of vertex shader Vertex Shader Registers that are reserved for constants.
    uint              MaxVertexShaderConst;
    ///Type: <b>DWORD</b> Two numbers that represent the pixel shader main and sub versions. For more information about
    ///the instructions supported for each pixel shader version, see Version 1_x, Version 2_0, Version 2_0 Extended, or
    ///Version 3_0.
    uint              PixelShaderVersion;
    ///Type: <b>float</b> Maximum value of pixel shader arithmetic component. This value indicates the internal range of
    ///values supported for pixel color blending operations. Within the range that they report to, implementations must
    ///allow data to pass through pixel processing unmodified (unclamped). Normally, the value of this member is an
    ///absolute value. For example, a 1.0 indicates that the range is -1.0 to 1, and an 8.0 indicates that the range is
    ///-8.0 to 8.0. The value must be &gt;= 1.0 for any hardware that supports pixel shaders.
    float             PixelShader1xMaxValue;
    ///Type: <b>DWORD</b> Device driver capabilities for adaptive tessellation. For more information, see D3DDEVCAPS2
    uint              DevCaps2;
    ///TBD
    float             MaxNpatchTessellationLevel;
    ///TBD
    uint              Reserved5;
    ///Type: <b>UINT</b> This number indicates which device is the master for this subordinate. This number is taken
    ///from the same space as the adapter values. For multihead support, one head will be denoted the master head, and
    ///all other heads on the same card will be denoted subordinate heads. If more than one multihead adapter is present
    ///in a system, the master and its subordinates from one multihead adapter are called a group.
    uint              MasterAdapterOrdinal;
    ///Type: <b>UINT</b> This number indicates the order in which heads are referenced by the API. The value for the
    ///master adapter is always 0. These values do not correspond to the adapter ordinals. They apply only to heads
    ///within a group.
    uint              AdapterOrdinalInGroup;
    ///Type: <b>UINT</b> Number of adapters in this adapter group (only if master). This will be 1 for conventional
    ///adapters. The value will be greater than 1 for the master adapter of a multihead card. The value will be 0 for a
    ///subordinate adapter of a multihead card. Each card can have at most one master, but may have many subordinates.
    uint              NumberOfAdaptersInGroup;
    ///Type: <b>DWORD</b> A combination of one or more data types contained in a vertex declaration. See D3DDTCAPS.
    uint              DeclTypes;
    ///Type: <b>DWORD</b> Number of simultaneous render targets. This number must be at least one.
    uint              NumSimultaneousRTs;
    ///Type: <b>DWORD</b> Combination of constants that describe the operations supported by StretchRect. The flags that
    ///may be set in this field are: <table> <tr> <th>Constant</th> <th>Description</th> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MINFPOINT</td> <td>Device supports point-sample filtering for minifying rectangles. This
    ///filter type is requested by calling StretchRect using D3DTEXF_POINT.</td> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MAGFPOINT</td> <td>Device supports point-sample filtering for magnifying rectangles. This
    ///filter type is requested by calling StretchRect using D3DTEXF_POINT.</td> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MINFLINEAR</td> <td>Device supports bilinear interpolation filtering for minifying
    ///rectangles. This filter type is requested by calling StretchRect using D3DTEXF_LINEAR.</td> </tr> <tr>
    ///<td>D3DPTFILTERCAPS_MAGFLINEAR</td> <td>Device supports bilinear interpolation filtering for magnifying
    ///rectangles. This filter type is requested by calling StretchRect using D3DTEXF_LINEAR.</td> </tr> </table> For
    ///more information, see D3DTEXTUREFILTERTYPE and <b>D3DTEXTUREFILTERTYPE</b>.
    uint              StretchRectFilterCaps;
    ///Type: <b>D3DVSHADERCAPS2_0</b> Device supports vertex shader version 2_0 extended capability. See
    ///D3DVSHADERCAPS2_0.
    D3DVSHADERCAPS2_0 VS20Caps;
    ///Type: <b>D3DPSHADERCAPS2_0</b> Device supports pixel shader version 2_0 extended capability. See
    ///D3DPSHADERCAPS2_0.
    D3DPSHADERCAPS2_0 PS20Caps;
    ///Type: <b>DWORD</b> Device supports vertex shader texture filter capability. See D3DPTFILTERCAPS.
    uint              VertexTextureFilterCaps;
    ///Type: <b>DWORD</b> Maximum number of vertex shader instructions that can be run when using flow control. The
    ///maximum number of instructions that can be programmed is MaxVertexShader30InstructionSlots.
    uint              MaxVShaderInstructionsExecuted;
    ///Type: <b>DWORD</b> Maximum number of pixel shader instructions that can be run when using flow control. The
    ///maximum number of instructions that can be programmed is MaxPixelShader30InstructionSlots.
    uint              MaxPShaderInstructionsExecuted;
    ///Type: <b>DWORD</b> Maximum number of vertex shader instruction slots supported. The maximum value that can be set
    ///on this cap is 32768. Devices that support vs_3_0 are required to support at least 512 instruction slots.
    uint              MaxVertexShader30InstructionSlots;
    ///Type: <b>DWORD</b> Maximum number of pixel shader instruction slots supported. The maximum value that can be set
    ///on this cap is 32768. Devices that support ps_3_0 are required to support at least 512 instruction slots.
    uint              MaxPixelShader30InstructionSlots;
}

// Functions

///Creates a factory object that can be used to create Direct2D resources.
///Params:
///    factoryType = Type: <b>D2D1_FACTORY_TYPE</b> The threading model of the factory and the resources it creates.
///    riid = Type: <b>REFIID</b> A reference to the IID of ID2D1Factory that is obtained by using `__uuidof(ID2D1Factory)`.
///    pFactoryOptions = Type: <b>const D2D1_FACTORY_OPTIONS*</b> The level of detail provided to the debugging layer.
///    ppIFactory = Type: <b>void**</b> When this method returns, contains the address to a pointer to the new factory.
///Returns:
///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
///    code](/windows/win32/com/com-error-codes-10).
///    
@DllImport("d2d1")
HRESULT D2D1CreateFactory(D2D1_FACTORY_TYPE factoryType, const(GUID)* riid, 
                          const(D2D1_FACTORY_OPTIONS)* pFactoryOptions, void** ppIFactory);

///Creates a rotation transformation that rotates by the specified angle about the specified point.
///Params:
///    angle = Type: <b>FLOAT</b> The clockwise rotation angle, in degrees.
///    center = Type: <b>D2D1_POINT_2F</b> The point about which to rotate.
///    matrix = Type: <b>D2D1_MATRIX_3X2_F*</b> When this method returns, contains the new rotation transformation. You must
///             allocate storage for this parameter.
@DllImport("d2d1")
void D2D1MakeRotateMatrix(float angle, D2D_POINT_2F center, D2D_MATRIX_3X2_F* matrix);

///Creates a skew transformation that has the specified x-axis angle, y-axis angle, and center point.
///Params:
///    angleX = Type: <b>FLOAT</b> The x-axis skew angle, which is measured in degrees counterclockwise from the y-axis.
///    angleY = Type: <b>FLOAT</b> The y-axis skew angle, which is measured in degrees counterclockwise from the x-axis.
///    center = Type: <b>D2D1_POINT_2F</b> The center point of the skew operation.
@DllImport("d2d1")
void D2D1MakeSkewMatrix(float angleX, float angleY, D2D_POINT_2F center, D2D_MATRIX_3X2_F* matrix);

///Indicates whether the specified matrix is invertible.
///Params:
///    matrix = Type: <b>const D2D1_MATRIX_3X2_F*</b> The matrix to test.
@DllImport("d2d1")
BOOL D2D1IsMatrixInvertible(const(D2D_MATRIX_3X2_F)* matrix);

///Tries to invert the specified matrix.
///Params:
///    matrix = Type: <b>D2D1_MATRIX_3X2_F*</b> The matrix to invert.
@DllImport("d2d1")
BOOL D2D1InvertMatrix(D2D_MATRIX_3X2_F* matrix);

///Creates a new Direct2D device associated with the provided DXGI device.
///Params:
///    dxgiDevice = The DXGI device the Direct2D device is associated with.
///    creationProperties = The properties to apply to the Direct2D device.
///    d2dDevice = When this function returns, contains the address of a pointer to a Direct2D device.
///Returns:
///    The function returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error occurred.</td>
///    </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient memory to complete the call.</td>
///    </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the method.</td> </tr> </table>
///    
@DllImport("d2d1")
HRESULT D2D1CreateDevice(IDXGIDevice dxgiDevice, const(D2D1_CREATION_PROPERTIES)* creationProperties, 
                         ID2D1Device* d2dDevice);

///Creates a new Direct2D device context associated with a DXGI surface.
///Params:
///    dxgiSurface = The DXGI surface the Direct2D device context is associated with.
///    creationProperties = The properties to apply to the Direct2D device context.
///    d2dDeviceContext = When this function returns, contains the address of a pointer to a Direct2D device context.
///Returns:
///    The function returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error occurred.</td>
///    </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient memory to complete the call.</td>
///    </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the method.</td> </tr> </table>
///    
@DllImport("d2d1")
HRESULT D2D1CreateDeviceContext(IDXGISurface dxgiSurface, const(D2D1_CREATION_PROPERTIES)* creationProperties, 
                                ID2D1DeviceContext* d2dDeviceContext);

///Converts the given color from one colorspace to another.
///Params:
///    sourceColorSpace = Type: <b>D2D1_COLOR_SPACE</b> The source color space.
///    destinationColorSpace = Type: <b>D2D1_COLOR_SPACE</b> The destination color space.
///    color = Type: <b>const D2D1_COLOR_F*</b> The source color.
@DllImport("d2d1")
DXGI_RGBA D2D1ConvertColorSpace(D2D1_COLOR_SPACE sourceColorSpace, D2D1_COLOR_SPACE destinationColorSpace, 
                                const(DXGI_RGBA)* color);

///Returns the sine and cosine of an angle.
///Params:
///    angle = Type: <b>FLOAT</b> The angle to calculate.
///    s = Type: <b>FLOAT*</b> The sine of the angle.
@DllImport("d2d1")
void D2D1SinCos(float angle, float* s, float* c);

///Returns the tangent of an angle.
///Params:
///    angle = Type: <b>FLOAT</b> The angle to calculate the tangent for.
@DllImport("d2d1")
float D2D1Tan(float angle);

///Returns the length of a 3 dimensional vector.
///Params:
///    x = Type: <b>FLOAT</b> The x value of the vector.
///    y = Type: <b>FLOAT</b> The y value of the vector.
///    z = Type: <b>FLOAT</b> The z value of the vector.
@DllImport("d2d1")
float D2D1Vec3Length(float x, float y, float z);

///Computes the maximum factor by which a given transform can stretch any vector.
///Params:
///    matrix = The input transform matrix.
///Returns:
///    The scale factor.
///    
@DllImport("d2d1")
float D2D1ComputeMaximumScaleFactor(const(D2D_MATRIX_3X2_F)* matrix);

///Returns the interior points for a gradient mesh patch based on the points defining a Coons patch.<div
///class="alert"><b>Note</b> <p class="note">This function is called by the GradientMeshPatchFromCoonsPatch function and
///is not intended to be used directly. </div> <div> </div>
///Params:
///    pPoint0 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 0.
///    pPoint1 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 1.
///    pPoint2 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 2.
///    pPoint3 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 3.
///    pPoint4 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 4.
///    pPoint5 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 5.
///    pPoint6 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 6.
///    pPoint7 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 7.
///    pPoint8 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 8.
///    pPoint9 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 9.
///    pPoint10 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 10.
///    pPoint11 = Type: <b>D2D1_POINT_2F*</b> The coordinate-space location of the control point at position 11.
///    pTensorPoint11 = Type: <b>D2D1_POINT_2F*</b> Returns the interior point for the gradient mesh corresponding to point11 in the
///                     D2D1_GRADIENT_MESH_PATCH structure.
///    pTensorPoint12 = Type: <b>D2D1_POINT_2F*</b> Returns the interior point for the gradient mesh corresponding to point12 in the
///                     D2D1_GRADIENT_MESH_PATCH structure.
///    pTensorPoint21 = Type: <b>D2D1_POINT_2F*</b> Returns the interior point for the gradient mesh corresponding to point21 in the
///                     D2D1_GRADIENT_MESH_PATCH structure.
///    pTensorPoint22 = Type: <b>D2D1_POINT_2F*</b> Returns the interior point for the gradient mesh corresponding to point22 in the
///                     D2D1_GRADIENT_MESH_PATCH structure.
@DllImport("d2d1")
void D2D1GetGradientMeshInteriorPointsFromCoonsPatch(const(D2D_POINT_2F)* pPoint0, const(D2D_POINT_2F)* pPoint1, 
                                                     const(D2D_POINT_2F)* pPoint2, const(D2D_POINT_2F)* pPoint3, 
                                                     const(D2D_POINT_2F)* pPoint4, const(D2D_POINT_2F)* pPoint5, 
                                                     const(D2D_POINT_2F)* pPoint6, const(D2D_POINT_2F)* pPoint7, 
                                                     const(D2D_POINT_2F)* pPoint8, const(D2D_POINT_2F)* pPoint9, 
                                                     const(D2D_POINT_2F)* pPoint10, const(D2D_POINT_2F)* pPoint11, 
                                                     D2D_POINT_2F* pTensorPoint11, D2D_POINT_2F* pTensorPoint12, 
                                                     D2D_POINT_2F* pTensorPoint21, D2D_POINT_2F* pTensorPoint22);

///Create an IDirect3D9 object and return an interface to it.
///Params:
///    SDKVersion = Type: <b>UINT</b> The value of this parameter should be D3D_SDK_VERSION. See Remarks.
///Returns:
///    Type: <b>IDirect3D9*</b> If successful, this function returns a pointer to an IDirect3D9 interface; otherwise, a
///    <b>NULL</b> pointer is returned.
///    
@DllImport("d3d9")
IDirect3D9 Direct3DCreate9(uint SDKVersion);

///Creates an IDirect3D9Ex object and returns an interface to it.
///Params:
///    SDKVersion = Type: <b>UINT</b> The value of this parameter should be <b>D3D_SDK_VERSION</b>. See Remarks.
///    arg2 = Type: <b>IDirect3D9Ex**</b> Address of a pointer to an IDirect3D9Ex interface, representing the created
///           <b>IDirect3D9Ex</b> object. If the function fails, <b>NULL</b> is inserted here.
///Returns:
///    Type: <b>HRESULT</b> <ul> <li><b>D3DERR_NOTAVAILABLE</b> if Direct3DEx features are not supported (no WDDM driver
///    is installed) or if the <b>SDKVersion</b> does not match the version of the DLL.</li>
///    <li><b>D3DERR_OUTOFMEMORY</b> if out-of-memory conditions are detected when creating the enumerator object.</li>
///    <li><b>S_OK</b> if the creation of the enumerator object is successful.</li> </ul>
///    
@DllImport("d3d9")
HRESULT Direct3DCreate9Ex(uint SDKVersion, IDirect3D9Ex* param1);


// Interfaces

///Represents a Direct2D drawing resource.
@GUID("2CD90691-12E2-11DC-9FED-001143A055F9")
interface ID2D1Resource : IUnknown
{
    ///Retrieves the factory associated with this resource.
    ///Params:
    ///    factory = Type: <b>ID2D1Factory**</b> When this method returns, contains a pointer to a pointer to the factory that
    ///              created this resource. This parameter is passed uninitialized.
    void GetFactory(ID2D1Factory* factory);
}

///Represents a producer of pixels that can fill an arbitrary 2D plane.
@GUID("65019F75-8DA2-497C-B32C-DFA34E48EDE6")
interface ID2D1Image : ID2D1Resource
{
}

///Represents a bitmap that has been bound to an ID2D1RenderTarget.
@GUID("A2296057-EA42-4099-983B-539FB6505426")
interface ID2D1Bitmap : ID2D1Image
{
    ///Returns the size, in device-independent pixels (DIPs), of the bitmap.
    ///Returns:
    ///    Type: <b>D2D1_SIZE_F</b> The size, in DIPs, of the bitmap.
    ///    
    D2D_SIZE_F GetSize();
    ///Returns the size, in device-dependent units (pixels), of the bitmap.
    ///Returns:
    ///    Type: <b>D2D1_SIZE_U</b> The size, in pixels, of the bitmap.
    ///    
    D2D_SIZE_U GetPixelSize();
    ///Retrieves the pixel format and alpha mode of the bitmap.
    ///Returns:
    ///    Type: <b>D2D1_PIXEL_FORMAT</b> The pixel format and alpha mode of the bitmap.
    ///    
    D2D1_PIXEL_FORMAT GetPixelFormat();
    ///Return the dots per inch (DPI) of the bitmap.
    ///Params:
    ///    dpiX = Type: <b>FLOAT*</b> The horizontal DPI of the image. You must allocate storage for this parameter.
    ///    dpiY = Type: <b>FLOAT*</b> The vertical DPI of the image. You must allocate storage for this parameter.
    void    GetDpi(float* dpiX, float* dpiY);
    ///Copies the specified region from the specified bitmap into the current bitmap.
    ///Params:
    ///    destPoint = Type: <b>const D2D1_POINT_2U*</b> In the current bitmap, the upper-left corner of the area to which the
    ///                region specified by <i>srcRect</i> is copied.
    ///    bitmap = Type: <b>ID2D1Bitmap*</b> The bitmap to copy from.
    ///    srcRect = Type: <b>const D2D1_RECT_U*</b> The area of <i>bitmap</i> to copy.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CopyFromBitmap(const(D2D_POINT_2U)* destPoint, ID2D1Bitmap bitmap, const(D2D_RECT_U)* srcRect);
    ///Copies the specified region from the specified render target into the current bitmap.
    ///Params:
    ///    destPoint = Type: <b>const D2D1_POINT_2U*</b> In the current bitmap, the upper-left corner of the area to which the
    ///                region specified by <i>srcRect</i> is copied.
    ///    renderTarget = Type: <b>ID2D1RenderTarget*</b> The render target that contains the region to copy.
    ///    srcRect = Type: <b>const D2D1_RECT_U*</b> The area of <i>renderTarget</i> to copy.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CopyFromRenderTarget(const(D2D_POINT_2U)* destPoint, ID2D1RenderTarget renderTarget, 
                                 const(D2D_RECT_U)* srcRect);
    ///Copies the specified region from memory into the current bitmap.
    ///Params:
    ///    dstRect = Type: <b>const D2D1_RECT_U*</b> In the current bitmap, the rectangle to which the region specified by
    ///              <i>srcRect</i> is copied.
    ///    srcData = Type: <b>const void*</b> The data to copy.
    ///    pitch = Type: <b>UINT32</b> The stride, or pitch, of the source bitmap stored in <i>srcData</i>. The stride is the
    ///            byte count of a scanline (one row of pixels in memory). The stride can be computed from the following
    ///            formula: pixel width * bytes per pixel + memory padding.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CopyFromMemory(const(D2D_RECT_U)* dstRect, const(void)* srcData, uint pitch);
}

///Represents an collection of D2D1_GRADIENT_STOP objects for linear and radial gradient brushes.
@GUID("2CD906A7-12E2-11DC-9FED-001143A055F9")
interface ID2D1GradientStopCollection : ID2D1Resource
{
    ///Retrieves the number of gradient stops in the collection.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of gradient stops in the collection.
    ///    
    uint GetGradientStopCount();
    ///Copies the gradient stops from the collection into an array of D2D1_GRADIENT_STOP structures.
    ///Params:
    ///    gradientStops = Type: <b>D2D1_GRADIENT_STOP*</b> A pointer to a one-dimensional array of D2D1_GRADIENT_STOP structures. When
    ///                    this method returns, the array contains copies of the collection's gradient stops. You must allocate the
    ///                    memory for this array.
    ///    gradientStopsCount = Type: <b>UINT</b> A value indicating the number of gradient stops to copy. If the value is less than the
    ///                         number of gradient stops in the collection, the remaining gradient stops are omitted. If the value is larger
    ///                         than the number of gradient stops in the collection, the extra gradient stops are set to <b>NULL</b>. To
    ///                         obtain the number of gradient stops in the collection, use the GetGradientStopCount method.
    void GetGradientStops(char* gradientStops, uint gradientStopsCount);
    ///Indicates the gamma space in which the gradient stops are interpolated.
    ///Returns:
    ///    Type: <b>D2D1_GAMMA</b> The gamma space in which the gradient stops are interpolated.
    ///    
    D2D1_GAMMA GetColorInterpolationGamma();
    ///Indicates the behavior of the gradient outside the normalized gradient range.
    ///Returns:
    ///    Type: <b>D2D1_EXTEND_MODE</b> The behavior of the gradient outside the [0,1] normalized gradient range.
    ///    
    D2D1_EXTEND_MODE GetExtendMode();
}

///Defines an object that paints an area. Interfaces that derive from <b>ID2D1Brush</b> describe how the area is
///painted.
@GUID("2CD906A8-12E2-11DC-9FED-001143A055F9")
interface ID2D1Brush : ID2D1Resource
{
    ///Sets the degree of opacity of this brush.
    ///Params:
    ///    opacity = Type: <b>FLOAT</b> A value between zero and 1 that indicates the opacity of the brush. This value is a
    ///              constant multiplier that linearly scales the alpha value of all pixels filled by the brush. The opacity
    ///              values are clamped in the range 0–1 before they are multipled together.
    void  SetOpacity(float opacity);
    void  SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    ///Gets the degree of opacity of this brush.
    ///Returns:
    ///    Type: <b>FLOAT</b> A value between zero and 1 that indicates the opacity of the brush. This value is a
    ///    constant multiplier that linearly scales the alpha value of all pixels filled by the brush. The opacity
    ///    values are clamped in the range 0–1 before they are multipled together.
    ///    
    float GetOpacity();
    ///Gets the transform applied to this brush.
    ///Params:
    ///    transform = Type: <b>D2D1_MATRIX_3X2_F*</b> The transform applied to this brush.
    void  GetTransform(D2D_MATRIX_3X2_F* transform);
}

///Paints an area with a bitmap.
@GUID("2CD906AA-12E2-11DC-9FED-001143A055F9")
interface ID2D1BitmapBrush : ID2D1Brush
{
    ///Specifies how the brush horizontally tiles those areas that extend past its bitmap.
    ///Params:
    ///    extendModeX = Type: <b>D2D1_EXTEND_MODE</b> A value that specifies how the brush horizontally tiles those areas that extend
    ///                  past its bitmap.
    void SetExtendModeX(D2D1_EXTEND_MODE extendModeX);
    ///Specifies how the brush vertically tiles those areas that extend past its bitmap.
    ///Params:
    ///    extendModeY = Type: <b>D2D1_EXTEND_MODE</b> A value that specifies how the brush vertically tiles those areas that extend
    ///                  past its bitmap.
    void SetExtendModeY(D2D1_EXTEND_MODE extendModeY);
    ///Specifies the interpolation mode used when the brush bitmap is scaled or rotated.
    ///Params:
    ///    interpolationMode = Type: <b>D2D1_BITMAP_INTERPOLATION_MODE</b> The interpolation mode used when the brush bitmap is scaled or
    ///                        rotated.
    void SetInterpolationMode(D2D1_BITMAP_INTERPOLATION_MODE interpolationMode);
    ///Specifies the bitmap source that this brush uses to paint.
    ///Params:
    ///    bitmap = Type: <b>ID2D1Bitmap*</b> The bitmap source used by the brush.
    void SetBitmap(ID2D1Bitmap bitmap);
    ///Gets the method by which the brush horizontally tiles those areas that extend past its bitmap.
    ///Returns:
    ///    Type: <b>D2D1_EXTEND_MODE</b> A value that specifies how the brush horizontally tiles those areas that extend
    ///    past its bitmap.
    ///    
    D2D1_EXTEND_MODE GetExtendModeX();
    ///Gets the method by which the brush vertically tiles those areas that extend past its bitmap.
    ///Returns:
    ///    Type: <b>D2D1_EXTEND_MODE</b> A value that specifies how the brush vertically tiles those areas that extend
    ///    past its bitmap.
    ///    
    D2D1_EXTEND_MODE GetExtendModeY();
    ///Gets the interpolation method used when the brush bitmap is scaled or rotated.
    ///Returns:
    ///    Type: <b>D2D1_BITMAP_INTERPOLATION_MODE</b> The interpolation method used when the brush bitmap is scaled or
    ///    rotated.
    ///    
    D2D1_BITMAP_INTERPOLATION_MODE GetInterpolationMode();
    ///Gets the bitmap source that this brush uses to paint.
    ///Params:
    ///    bitmap = Type: <b>ID2D1Bitmap**</b> When this method returns, contains the address to a pointer to the bitmap with
    ///             which this brush paints.
    void GetBitmap(ID2D1Bitmap* bitmap);
}

///Paints an area with a solid color.
@GUID("2CD906A9-12E2-11DC-9FED-001143A055F9")
interface ID2D1SolidColorBrush : ID2D1Brush
{
    void SetColor(const(DXGI_RGBA)* color);
    ///Retrieves the color of the solid color brush.
    ///Returns:
    ///    Type: <b>D2D1_COLOR_F</b> The color of this solid color brush.
    ///    
    DXGI_RGBA GetColor();
}

///Paints an area with a linear gradient.
@GUID("2CD906AB-12E2-11DC-9FED-001143A055F9")
interface ID2D1LinearGradientBrush : ID2D1Brush
{
    ///Sets the starting coordinates of the linear gradient in the brush's coordinate space.
    ///Params:
    ///    startPoint = Type: <b>D2D1_POINT_2F</b> The starting two-dimensional coordinates of the linear gradient, in the brush's
    ///                 coordinate space.
    void SetStartPoint(D2D_POINT_2F startPoint);
    ///Sets the ending coordinates of the linear gradient in the brush's coordinate space.
    ///Params:
    ///    endPoint = Type: <b>D2D1_POINT_2F</b> The ending two-dimensional coordinates of the linear gradient, in the brush's
    ///               coordinate space.
    void SetEndPoint(D2D_POINT_2F endPoint);
    ///Retrieves the starting coordinates of the linear gradient.
    ///Returns:
    ///    Type: <b>D2D1_POINT_2F</b> The starting two-dimensional coordinates of the linear gradient, in the brush's
    ///    coordinate space.
    ///    
    D2D_POINT_2F GetStartPoint();
    ///Retrieves the ending coordinates of the linear gradient.
    ///Returns:
    ///    Type: <b>D2D1_POINT_2F</b> The ending two-dimensional coordinates of the linear gradient, in the brush's
    ///    coordinate space.
    ///    
    D2D_POINT_2F GetEndPoint();
    ///Retrieves the ID2D1GradientStopCollection associated with this linear gradient brush.
    ///Params:
    ///    gradientStopCollection = Type: <b>ID2D1GradientStopCollection**</b> The ID2D1GradientStopCollection object associated with this linear
    ///                             gradient brush object. This parameter is passed uninitialized.
    void GetGradientStopCollection(ID2D1GradientStopCollection* gradientStopCollection);
}

///Paints an area with a radial gradient.
@GUID("2CD906AC-12E2-11DC-9FED-001143A055F9")
interface ID2D1RadialGradientBrush : ID2D1Brush
{
    ///Specifies the center of the gradient ellipse in the brush's coordinate space.
    ///Params:
    ///    center = Type: <b>D2D1_POINT_2F</b> The center of the gradient ellipse, in the brush's coordinate space.
    void  SetCenter(D2D_POINT_2F center);
    ///Specifies the offset of the gradient origin relative to the gradient ellipse's center.
    ///Params:
    ///    gradientOriginOffset = Type: <b>D2D1_POINT_2F</b> The offset of the gradient origin from the center of the gradient ellipse.
    void  SetGradientOriginOffset(D2D_POINT_2F gradientOriginOffset);
    ///Specifies the x-radius of the gradient ellipse, in the brush's coordinate space.
    ///Params:
    ///    radiusX = Type: <b>FLOAT</b> The x-radius of the gradient ellipse. This value is in the brush's coordinate space.
    void  SetRadiusX(float radiusX);
    ///Specifies the y-radius of the gradient ellipse, in the brush's coordinate space.
    ///Params:
    ///    radiusY = Type: <b>FLOAT</b> The y-radius of the gradient ellipse. This value is in the brush's coordinate space.
    void  SetRadiusY(float radiusY);
    ///Retrieves the center of the gradient ellipse.
    ///Returns:
    ///    Type: <b>D2D1_POINT_2F</b> The center of the gradient ellipse. This value is expressed in the brush's
    ///    coordinate space.
    ///    
    D2D_POINT_2F GetCenter();
    ///Retrieves the offset of the gradient origin relative to the gradient ellipse's center.
    ///Returns:
    ///    Type: <b>D2D1_POINT_2F</b> The offset of the gradient origin from the center of the gradient ellipse. This
    ///    value is expressed in the brush's coordinate space.
    ///    
    D2D_POINT_2F GetGradientOriginOffset();
    ///Retrieves the x-radius of the gradient ellipse.
    ///Returns:
    ///    Type: <b>FLOAT</b> The x-radius of the gradient ellipse. This value is expressed in the brush's coordinate
    ///    space.
    ///    
    float GetRadiusX();
    ///Retrieves the y-radius of the gradient ellipse.
    ///Returns:
    ///    Type: <b>FLOAT</b> The y-radius of the gradient ellipse. This value is expressed in the brush's coordinate
    ///    space.
    ///    
    float GetRadiusY();
    ///Retrieves the ID2D1GradientStopCollection associated with this radial gradient brush object.
    ///Params:
    ///    gradientStopCollection = Type: <b>ID2D1GradientStopCollection**</b> The ID2D1GradientStopCollection object associated with this linear
    ///                             gradient brush object. This parameter is passed uninitialized.
    void  GetGradientStopCollection(ID2D1GradientStopCollection* gradientStopCollection);
}

///Describes the caps, miter limit, line join, and dash information for a stroke.
@GUID("2CD9069D-12E2-11DC-9FED-001143A055F9")
interface ID2D1StrokeStyle : ID2D1Resource
{
    ///Retrieves the type of shape used at the beginning of a stroke.
    ///Returns:
    ///    Type: <b>D2D1_CAP_STYLE</b> The type of shape used at the beginning of a stroke.
    ///    
    D2D1_CAP_STYLE GetStartCap();
    ///Retrieves the type of shape used at the end of a stroke.
    ///Returns:
    ///    Type: <b>D2D1_CAP_STYLE</b> The type of shape used at the end of a stroke.
    ///    
    D2D1_CAP_STYLE GetEndCap();
    ///Gets a value that specifies how the ends of each dash are drawn.
    ///Returns:
    ///    Type: <b>D2D1_CAP_STYLE</b> A value that specifies how the ends of each dash are drawn.
    ///    
    D2D1_CAP_STYLE GetDashCap();
    ///Retrieves the limit on the ratio of the miter length to half the stroke's thickness.
    ///Returns:
    ///    Type: <b>FLOAT</b> A positive number greater than or equal to 1.0f that describes the limit on the ratio of
    ///    the miter length to half the stroke's thickness.
    ///    
    float GetMiterLimit();
    ///Retrieves the type of joint used at the vertices of a shape's outline.
    ///Returns:
    ///    Type: <b>D2D1_LINE_JOIN</b> A value that specifies the type of joint used at the vertices of a shape's
    ///    outline.
    ///    
    D2D1_LINE_JOIN GetLineJoin();
    ///Retrieves a value that specifies how far in the dash sequence the stroke will start.
    ///Returns:
    ///    Type: <b>FLOAT</b> A value that specifies how far in the dash sequence the stroke will start.
    ///    
    float GetDashOffset();
    ///Gets a value that describes the stroke's dash pattern.
    ///Returns:
    ///    Type: <b>D2D1_DASH_STYLE</b> A value that describes the predefined dash pattern used, or
    ///    D2D1_DASH_STYLE_CUSTOM if a custom dash style is used.
    ///    
    D2D1_DASH_STYLE GetDashStyle();
    ///Retrieves the number of entries in the dashes array.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of entries in the dashes array if the stroke is dashed; otherwise, 0.
    ///    
    uint  GetDashesCount();
    ///Copies the dash pattern to the specified array.
    ///Params:
    ///    dashes = Type: <b>FLOAT*</b> A pointer to an array that will receive the dash pattern. The array must be able to
    ///             contain at least as many elements as specified by <i>dashesCount</i>. You must allocate storage for this
    ///             array.
    ///    dashesCount = Type: <b>UINT</b> The number of dashes to copy. If this value is less than the number of dashes in the stroke
    ///                  style's dashes array, the returned dashes are truncated to <i>dashesCount</i>. If this value is greater than
    ///                  the number of dashes in the stroke style's dashes array, the extra dashes are set to 0.0f. To obtain the
    ///                  actual number of dashes in the stroke style's dashes array, use the GetDashesCount method.
    void  GetDashes(char* dashes, uint dashesCount);
}

///Represents a geometry resource and defines a set of helper methods for manipulating and measuring geometric shapes.
///Interfaces that inherit from <b>ID2D1Geometry</b> define specific shapes.
@GUID("2CD906A1-12E2-11DC-9FED-001143A055F9")
interface ID2D1Geometry : ID2D1Resource
{
    HRESULT GetBounds(const(D2D_MATRIX_3X2_F)* worldTransform, D2D_RECT_F* bounds);
    HRESULT GetWidenedBounds(float strokeWidth, ID2D1StrokeStyle strokeStyle, 
                             const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, D2D_RECT_F* bounds);
    HRESULT StrokeContainsPoint(D2D_POINT_2F point, float strokeWidth, ID2D1StrokeStyle strokeStyle, 
                                const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, int* contains);
    HRESULT FillContainsPoint(D2D_POINT_2F point, const(D2D_MATRIX_3X2_F)* worldTransform, 
                              float flatteningTolerance, int* contains);
    HRESULT CompareWithGeometry(ID2D1Geometry inputGeometry, const(D2D_MATRIX_3X2_F)* inputGeometryTransform, 
                                float flatteningTolerance, D2D1_GEOMETRY_RELATION* relation);
    HRESULT Simplify(D2D1_GEOMETRY_SIMPLIFICATION_OPTION simplificationOption, 
                     const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                     ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT Tessellate(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                       ID2D1TessellationSink tessellationSink);
    HRESULT CombineWithGeometry(ID2D1Geometry inputGeometry, D2D1_COMBINE_MODE combineMode, 
                                const(D2D_MATRIX_3X2_F)* inputGeometryTransform, float flatteningTolerance, 
                                ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT Outline(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                    ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT ComputeArea(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, float* area);
    HRESULT ComputeLength(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, float* length);
    HRESULT ComputePointAtLength(float length, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                                 D2D_POINT_2F* point, D2D_POINT_2F* unitTangentVector);
    HRESULT Widen(float strokeWidth, ID2D1StrokeStyle strokeStyle, const(D2D_MATRIX_3X2_F)* worldTransform, 
                  float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
}

///Describes a two-dimensional rectangle.
@GUID("2CD906A2-12E2-11DC-9FED-001143A055F9")
interface ID2D1RectangleGeometry : ID2D1Geometry
{
    ///Retrieves the rectangle that describes the rectangle geometry's dimensions.
    ///Params:
    ///    rect = Type: <b>D2D1_RECT_F*</b> Contains a pointer to a rectangle that describes the rectangle geometry's
    ///           dimensions when this method returns. You must allocate storage for this parameter.
    void GetRect(D2D_RECT_F* rect);
}

///Describes a rounded rectangle.
@GUID("2CD906A3-12E2-11DC-9FED-001143A055F9")
interface ID2D1RoundedRectangleGeometry : ID2D1Geometry
{
    ///Retrieves a rounded rectangle that describes this rounded rectangle geometry.
    ///Params:
    ///    roundedRect = Type: <b>D2D1_ROUNDED_RECT*</b> A pointer that receives a rounded rectangle that describes this rounded
    ///                  rectangle geometry. You must allocate storage for this parameter.
    void GetRoundedRect(D2D1_ROUNDED_RECT* roundedRect);
}

///Represents an ellipse.
@GUID("2CD906A4-12E2-11DC-9FED-001143A055F9")
interface ID2D1EllipseGeometry : ID2D1Geometry
{
    ///Gets the D2D1_ELLIPSE structure that describes this ellipse geometry.
    ///Params:
    ///    ellipse = Type: <b>D2D1_ELLIPSE*</b> When this method returns, contains the D2D1_ELLIPSE that describes the size and
    ///              position of the ellipse. You must allocate storage for this parameter.
    void GetEllipse(D2D1_ELLIPSE* ellipse);
}

///Represents a composite geometry, composed of other ID2D1Geometry objects.
@GUID("2CD906A6-12E2-11DC-9FED-001143A055F9")
interface ID2D1GeometryGroup : ID2D1Geometry
{
    ///Indicates how the intersecting areas of the geometries contained in this geometry group are combined.
    ///Returns:
    ///    Type: <b>D2D1_FILL_MODE</b> A value that indicates how the intersecting areas of the geometries contained in
    ///    this geometry group are combined.
    ///    
    D2D1_FILL_MODE GetFillMode();
    ///Indicates the number of geometry objects in the geometry group.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of geometries in the ID2D1GeometryGroup.
    ///    
    uint GetSourceGeometryCount();
    ///Retrieves the geometries in the geometry group.
    ///Params:
    ///    geometries = Type: <b>const ID2D1Geometry**</b> When this method returns, contains the address of a pointer to an array of
    ///                 geometries to be filled by this method. The length of the array is specified by the <i>geometryCount</i>
    ///                 parameter. If the array is <b>NULL</b>, then this method performs no operation. You must allocate the memory
    ///                 for this array.
    ///    geometriesCount = Type: <b>UINT</b> A value indicating the number of geometries to return in the <i>geometries</i> array. If
    ///                      this value is less than the number of geometries in the geometry group, the remaining geometries are omitted.
    ///                      If this value is larger than the number of geometries in the geometry group, the extra geometries are set to
    ///                      <b>NULL</b>. To obtain the number of geometries currently in the geometry group, use the
    ///                      GetSourceGeometryCount method.
    void GetSourceGeometries(char* geometries, uint geometriesCount);
}

///Represents a geometry that has been transformed.
@GUID("2CD906BB-12E2-11DC-9FED-001143A055F9")
interface ID2D1TransformedGeometry : ID2D1Geometry
{
    ///Retrieves the source geometry of this transformed geometry object.
    ///Params:
    ///    sourceGeometry = Type: <b>ID2D1Geometry**</b> When this method returns, contains a pointer to a pointer to the source geometry
    ///                     for this transformed geometry object. This parameter is passed uninitialized.
    void GetSourceGeometry(ID2D1Geometry* sourceGeometry);
    ///Retrieves the matrix used to transform the ID2D1TransformedGeometry object's source geometry.
    ///Params:
    ///    transform = Type: <b>D2D1_MATRIX_3X2_F*</b> A pointer that receives the matrix used to transform the
    ///                ID2D1TransformedGeometry object's source geometry. You must allocate storage for this parameter.
    void GetTransform(D2D_MATRIX_3X2_F* transform);
}

///Describes a geometric path that does not contain quadratic bezier curves or arcs.
@GUID("2CD9069E-12E2-11DC-9FED-001143A055F9")
interface ID2D1SimplifiedGeometrySink : IUnknown
{
    ///Specifies the method used to determine which points are inside the geometry described by this geometry sink and
    ///which points are outside.
    ///Params:
    ///    fillMode = Type: <b>D2D1_FILL_MODE</b> The method used to determine whether a given point is part of the geometry.
    void    SetFillMode(D2D1_FILL_MODE fillMode);
    ///Specifies stroke and join options to be applied to new segments added to the geometry sink.
    ///Params:
    ///    vertexFlags = Type: <b>D2D1_PATH_SEGMENT</b> Stroke and join options to be applied to new segments added to the geometry
    ///                  sink.
    void    SetSegmentFlags(D2D1_PATH_SEGMENT vertexFlags);
    ///Starts a new figure at the specified point.
    ///Params:
    ///    startPoint = Type: <b>D2D1_POINT_2F</b> The point at which to begin the new figure.
    ///    figureBegin = Type: <b>D2D1_FIGURE_BEGIN</b> Whether the new figure should be hollow or filled.
    void    BeginFigure(D2D_POINT_2F startPoint, D2D1_FIGURE_BEGIN figureBegin);
    ///Creates a sequence of lines using the specified points and adds them to the geometry sink.
    ///Params:
    ///    points = Type: <b>const D2D1_POINT_2F*</b> A pointer to an array of one or more points that describe the lines to
    ///             draw. A line is drawn from the geometry sink's current point (the end point of the last segment drawn or the
    ///             location specified by BeginFigure) to the first point in the array. if the array contains additional points,
    ///             a line is drawn from the first point to the second point in the array, from the second point to the third
    ///             point, and so on.
    ///    pointsCount = Type: <b>UINT</b> The number of points in the <i>points</i> array.
    void    AddLines(char* points, uint pointsCount);
    ///Creates a sequence of cubic Bezier curves and adds them to the geometry sink.
    ///Params:
    ///    beziers = Type: <b>const D2D1_BEZIER_SEGMENT*</b> A pointer to an array of Bezier segments that describes the Bezier
    ///              curves to create. A curve is drawn from the geometry sink's current point (the end point of the last segment
    ///              drawn or the location specified by BeginFigure) to the end point of the first Bezier segment in the array. if
    ///              the array contains additional Bezier segments, each subsequent Bezier segment uses the end point of the
    ///              preceding Bezier segment as its start point.
    ///    beziersCount = Type: <b>UINT</b> The number of Bezier segments in the <i>beziers</i> array.
    void    AddBeziers(char* beziers, uint beziersCount);
    ///Ends the current figure; optionally, closes it.
    ///Params:
    ///    figureEnd = Type: <b>D2D1_FIGURE_END</b> A value that indicates whether the current figure is closed. If the figure is
    ///                closed, a line is drawn between the current point and the start point specified by BeginFigure.
    void    EndFigure(D2D1_FIGURE_END figureEnd);
    ///Closes the geometry sink, indicates whether it is in an error state, and resets the sink's error state.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT Close();
}

///Describes a geometric path that can contain lines, arcs, cubic Bezier curves, and quadratic Bezier curves.
@GUID("2CD9069F-12E2-11DC-9FED-001143A055F9")
interface ID2D1GeometrySink : ID2D1SimplifiedGeometrySink
{
    ///Creates a line segment between the current point and the specified end point and adds it to the geometry sink.
    ///Params:
    ///    point = Type: <b>D2D1_POINT_2F</b> The end point of the line to draw.
    void AddLine(D2D_POINT_2F point);
    void AddBezier(const(D2D1_BEZIER_SEGMENT)* bezier);
    void AddQuadraticBezier(const(D2D1_QUADRATIC_BEZIER_SEGMENT)* bezier);
    ///Adds a sequence of quadratic Bezier segments as an array in a single call.
    ///Params:
    ///    beziers = Type: <b>const D2D1_QUADRATIC_BEZIER_SEGMENT*</b> An array of a sequence of quadratic Bezier segments.
    ///    beziersCount = Type: <b>UINT</b> A value indicating the number of quadratic Bezier segments in <i>beziers</i>.
    void AddQuadraticBeziers(char* beziers, uint beziersCount);
    void AddArc(const(D2D1_ARC_SEGMENT)* arc);
}

///Populates an ID2D1Mesh object with triangles.
@GUID("2CD906C1-12E2-11DC-9FED-001143A055F9")
interface ID2D1TessellationSink : IUnknown
{
    ///Copies the specified triangles to the sink.
    ///Params:
    ///    triangles = Type: <b>const D2D1_TRIANGLE*</b> An array of D2D1_TRIANGLE structures that describe the triangles to add to
    ///                the sink.
    ///    trianglesCount = Type: <b>UINT</b> The number of triangles to copy from the <i>triangles</i> array.
    void    AddTriangles(char* triangles, uint trianglesCount);
    ///Closes the sink and returns its error status.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT Close();
}

///Represents a complex shape that may be composed of arcs, curves, and lines.
@GUID("2CD906A5-12E2-11DC-9FED-001143A055F9")
interface ID2D1PathGeometry : ID2D1Geometry
{
    ///Retrieves the geometry sink that is used to populate the path geometry with figures and segments.
    ///Params:
    ///    geometrySink = Type: <b>ID2D1GeometrySink**</b> When this method returns, <i>geometrySink</i> contains the address of a
    ///                   pointer to the geometry sink that is used to populate the path geometry with figures and segments. This
    ///                   parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT Open(ID2D1GeometrySink* geometrySink);
    ///Copies the contents of the path geometry to the specified ID2D1GeometrySink.
    ///Params:
    ///    geometrySink = Type: <b>ID2D1GeometrySink*</b> The sink to which the path geometry's contents are copied. Modifying this
    ///                   sink does not change the contents of this path geometry.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT Stream(ID2D1GeometrySink geometrySink);
    ///Retrieves the number of segments in the path geometry.
    ///Params:
    ///    count = Type: <b>UINT32*</b> A pointer that receives the number of segments in the path geometry when this method
    ///            returns. You must allocate storage for this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT GetSegmentCount(uint* count);
    ///Retrieves the number of figures in the path geometry.
    ///Params:
    ///    count = Type: <b>UINT32*</b> A pointer that receives the number of figures in the path geometry when this method
    ///            returns. You must allocate storage for this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT GetFigureCount(uint* count);
}

///Represents a set of vertices that form a list of triangles.
@GUID("2CD906C2-12E2-11DC-9FED-001143A055F9")
interface ID2D1Mesh : ID2D1Resource
{
    ///Opens the mesh for population.
    ///Params:
    ///    tessellationSink = Type: <b>ID2D1TessellationSink**</b> When this method returns, contains a pointer to a pointer to an
    ///                       ID2D1TessellationSink that is used to populate the mesh. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT Open(ID2D1TessellationSink* tessellationSink);
}

///Represents the backing store required to render a layer.
@GUID("2CD9069B-12E2-11DC-9FED-001143A055F9")
interface ID2D1Layer : ID2D1Resource
{
    ///Gets the size of the layer in device-independent pixels.
    ///Returns:
    ///    Type: <b>D2D1_SIZE_F</b> The size of the layer in device-independent pixels.
    ///    
    D2D_SIZE_F GetSize();
}

///Represents the drawing state of a render target: the antialiasing mode, transform, tags, and text-rendering options.
@GUID("28506E39-EBF6-46A1-BB47-FD85565AB957")
interface ID2D1DrawingStateBlock : ID2D1Resource
{
    ///Retrieves the antialiasing mode, transform, and tags portion of the drawing state.
    ///Params:
    ///    stateDescription = Type: <b>D2D1_DRAWING_STATE_DESCRIPTION*</b> When this method returns, contains the antialiasing mode,
    ///                       transform, and tags portion of the drawing state. You must allocate storage for this parameter.
    void GetDescription(D2D1_DRAWING_STATE_DESCRIPTION* stateDescription);
    void SetDescription(const(D2D1_DRAWING_STATE_DESCRIPTION)* stateDescription);
    ///Specifies the text-rendering configuration of the drawing state.
    ///Params:
    ///    textRenderingParams = Type: <b>IDWriteRenderingParams*</b> The text-rendering configuration of the drawing state, or NULL to use
    ///                          default settings.
    void SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    ///Retrieves the text-rendering configuration of the drawing state.
    ///Params:
    ///    textRenderingParams = Type: <b>IDWriteRenderingParams**</b> When this method returns, contains the address of a pointer to an
    ///                          IDWriteRenderingParams object that describes the text-rendering configuration of the drawing state.
    void GetTextRenderingParams(IDWriteRenderingParams* textRenderingParams);
}

///Represents an object that can receive drawing commands. Interfaces that inherit from <b>ID2D1RenderTarget</b> render
///the drawing commands they receive in different ways.
@GUID("2CD90694-12E2-11DC-9FED-001143A055F9")
interface ID2D1RenderTarget : ID2D1Resource
{
    HRESULT CreateBitmap(D2D_SIZE_U size, const(void)* srcData, uint pitch, 
                         const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, ID2D1Bitmap* bitmap);
    HRESULT CreateBitmapFromWicBitmap(IWICBitmapSource wicBitmapSource, 
                                      const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, ID2D1Bitmap* bitmap);
    ///Creates an ID2D1Bitmap whose data is shared with another resource.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The interface ID of the object supplying the source data.
    ///    data = Type: <b>void*</b> An ID2D1Bitmap, IDXGISurface, or an IWICBitmapLock that contains the data to share with
    ///           the new <b>ID2D1Bitmap</b>. For more information, see the Remarks section.
    ///    bitmapProperties = Type: <b>D2D1_BITMAP_PROPERTIES*</b> The pixel format and DPI of the bitmap to create . The DXGI_FORMAT
    ///                       portion of the pixel format must match the DXGI_FORMAT of <i>data</i> or the method will fail, but the alpha
    ///                       modes don't have to match. To prevent a mismatch, you can pass <b>NULL</b> or the value obtained from the
    ///                       D2D1::PixelFormat helper function. The DPI settings do not have to match those of <i>data</i>. If both
    ///                       <i>dpiX</i> and <i>dpiY</i> are 0.0f, the DPI of the render target is used.
    ///    bitmap = Type: <b>ID2D1Bitmap**</b> When this method returns, contains the address of a pointer to the new bitmap.
    ///             This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CreateSharedBitmap(const(GUID)* riid, void* data, const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, 
                               ID2D1Bitmap* bitmap);
    HRESULT CreateBitmapBrush(ID2D1Bitmap bitmap, const(D2D1_BITMAP_BRUSH_PROPERTIES)* bitmapBrushProperties, 
                              const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1BitmapBrush* bitmapBrush);
    HRESULT CreateSolidColorBrush(const(DXGI_RGBA)* color, const(D2D1_BRUSH_PROPERTIES)* brushProperties, 
                                  ID2D1SolidColorBrush* solidColorBrush);
    HRESULT CreateGradientStopCollection(char* gradientStops, uint gradientStopsCount, 
                                         D2D1_GAMMA colorInterpolationGamma, D2D1_EXTEND_MODE extendMode, 
                                         ID2D1GradientStopCollection* gradientStopCollection);
    HRESULT CreateLinearGradientBrush(const(D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES)* linearGradientBrushProperties, 
                                      const(D2D1_BRUSH_PROPERTIES)* brushProperties, 
                                      ID2D1GradientStopCollection gradientStopCollection, 
                                      ID2D1LinearGradientBrush* linearGradientBrush);
    HRESULT CreateRadialGradientBrush(const(D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES)* radialGradientBrushProperties, 
                                      const(D2D1_BRUSH_PROPERTIES)* brushProperties, 
                                      ID2D1GradientStopCollection gradientStopCollection, 
                                      ID2D1RadialGradientBrush* radialGradientBrush);
    HRESULT CreateCompatibleRenderTarget(const(D2D_SIZE_F)* desiredSize, const(D2D_SIZE_U)* desiredPixelSize, 
                                         const(D2D1_PIXEL_FORMAT)* desiredFormat, 
                                         D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS options, 
                                         ID2D1BitmapRenderTarget* bitmapRenderTarget);
    HRESULT CreateLayer(const(D2D_SIZE_F)* size, ID2D1Layer* layer);
    ///Create a mesh that uses triangles to describe a shape.
    ///Params:
    ///    mesh = Type: <b>ID2D1Mesh**</b> When this method returns, contains a pointer to a pointer to the new mesh.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CreateMesh(ID2D1Mesh* mesh);
    ///Draws a line between the specified points using the specified stroke style.
    ///Params:
    ///    point0 = Type: <b>D2D1_POINT_2F</b> The start point of the line, in device-independent pixels.
    ///    point1 = Type: <b>D2D1_POINT_2F</b> The end point of the line, in device-independent pixels.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush used to paint the line's stroke.
    ///    strokeWidth = Type: <b>FLOAT</b> The width of the stroke, in device-independent pixels. The value must be greater than or
    ///                  equal to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
    ///    strokeStyle = Type: <b>ID2D1StrokeStyle*</b> The style of stroke to paint, or <b>NULL</b> to paint a solid line.
    void    DrawLine(D2D_POINT_2F point0, D2D_POINT_2F point1, ID2D1Brush brush, float strokeWidth, 
                     ID2D1StrokeStyle strokeStyle);
    void    DrawRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush, float strokeWidth, 
                          ID2D1StrokeStyle strokeStyle);
    void    FillRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush);
    void    DrawRoundedRectangle(const(D2D1_ROUNDED_RECT)* roundedRect, ID2D1Brush brush, float strokeWidth, 
                                 ID2D1StrokeStyle strokeStyle);
    void    FillRoundedRectangle(const(D2D1_ROUNDED_RECT)* roundedRect, ID2D1Brush brush);
    void    DrawEllipse(const(D2D1_ELLIPSE)* ellipse, ID2D1Brush brush, float strokeWidth, 
                        ID2D1StrokeStyle strokeStyle);
    void    FillEllipse(const(D2D1_ELLIPSE)* ellipse, ID2D1Brush brush);
    ///Draws the outline of the specified geometry using the specified stroke style.
    ///Params:
    ///    geometry = Type: <b>ID2D1Geometry*</b> The geometry to draw.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush used to paint the geometry's stroke.
    ///    strokeWidth = Type: <b>FLOAT</b> The width of the stroke, in device-independent pixels. The value must be greater than or
    ///                  equal to 0.0f. If this parameter isn't specified, it defaults to 1.0f. The stroke is centered on the line.
    ///    strokeStyle = Type: <b>ID2D1StrokeStyle*</b> The style of stroke to apply to the geometry's outline, or <b>NULL</b> to
    ///                  paint a solid stroke.
    void    DrawGeometry(ID2D1Geometry geometry, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    ///Paints the interior of the specified geometry.
    ///Params:
    ///    geometry = Type: <b>ID2D1Geometry*</b> The geometry to paint.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush used to paint the geometry's interior.
    ///    opacityBrush = Type: <b>ID2D1Brush*</b> The opacity mask to apply to the geometry, or <b>NULL</b> for no opacity mask. If an
    ///                   opacity mask (the <i>opacityBrush</i> parameter) is specified, <i>brush</i> must be an ID2D1BitmapBrush that
    ///                   has its x- and y-extend modes set to D2D1_EXTEND_MODE_CLAMP. For more information, see the Remarks section.
    void    FillGeometry(ID2D1Geometry geometry, ID2D1Brush brush, ID2D1Brush opacityBrush);
    ///Paints the interior of the specified mesh.
    ///Params:
    ///    mesh = Type: <b>ID2D1Mesh*</b> The mesh to paint.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush used to paint the mesh.
    void    FillMesh(ID2D1Mesh mesh, ID2D1Brush brush);
    void    FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, D2D1_OPACITY_MASK_CONTENT content, 
                            const(D2D_RECT_F)* destinationRectangle, const(D2D_RECT_F)* sourceRectangle);
    void    DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, 
                       D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle);
    void    DrawTextA(const(wchar)* string, uint stringLength, IDWriteTextFormat textFormat, 
                      const(D2D_RECT_F)* layoutRect, ID2D1Brush defaultFillBrush, D2D1_DRAW_TEXT_OPTIONS options, 
                      DWRITE_MEASURING_MODE measuringMode);
    ///Draws the formatted text described by the specified IDWriteTextLayout object.
    ///Params:
    ///    origin = Type: <b>D2D1_POINT_2F</b> The point, described in device-independent pixels, at which the upper-left corner
    ///             of the text described by <i>textLayout</i> is drawn.
    ///    textLayout = Type: <b>IDWriteTextLayout*</b> The formatted text to draw. Any drawing effects that do not inherit from
    ///                 ID2D1Resource are ignored. If there are drawing effects that inherit from <b>ID2D1Resource</b> that are not
    ///                 brushes, this method fails and the render target is put in an error state.
    ///    defaultFillBrush = Type: <b>ID2D1Brush*</b> The brush used to paint any text in <i>textLayout</i> that does not already have a
    ///                       brush associated with it as a drawing effect (specified by the IDWriteTextLayout::SetDrawingEffect method).
    ///    options = Type: <b>D2D1_DRAW_TEXT_OPTIONS</b> A value that indicates whether the text should be snapped to pixel
    ///              boundaries and whether the text should be clipped to the layout rectangle. The default value is
    ///              D2D1_DRAW_TEXT_OPTIONS_NONE, which indicates that text should be snapped to pixel boundaries and it should
    ///              not be clipped to the layout rectangle.
    void    DrawTextLayout(D2D_POINT_2F origin, IDWriteTextLayout textLayout, ID2D1Brush defaultFillBrush, 
                           D2D1_DRAW_TEXT_OPTIONS options);
    ///Draws the specified glyphs.
    ///Params:
    ///    baselineOrigin = Type: <b>D2D1_POINT_2F</b> The origin, in device-independent pixels, of the glyphs' baseline.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> The glyphs to render.
    ///    foregroundBrush = Type: <b>ID2D1Brush*</b> The brush used to paint the specified glyphs.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> A value that indicates how glyph metrics are used to measure text when it
    ///                    is formatted. The default value is DWRITE_MEASURING_MODE_NATURAL.
    void    DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                         ID2D1Brush foregroundBrush, DWRITE_MEASURING_MODE measuringMode);
    void    SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    ///Gets the current transform of the render target.
    ///Params:
    ///    transform = Type: <b>D2D1_MATRIX_3X2_F*</b> When this returns, contains the current transform of the render target. This
    ///                parameter is passed uninitialized.
    void    GetTransform(D2D_MATRIX_3X2_F* transform);
    ///Sets the antialiasing mode of the render target. The antialiasing mode applies to all subsequent drawing
    ///operations, excluding text and glyph drawing operations.
    ///Params:
    ///    antialiasMode = Type: <b>D2D1_ANTIALIAS_MODE</b> The antialiasing mode for future drawing operations.
    void    SetAntialiasMode(D2D1_ANTIALIAS_MODE antialiasMode);
    ///Retrieves the current antialiasing mode for nontext drawing operations.
    ///Returns:
    ///    Type: <b>D2D1_ANTIALIAS_MODE</b> The current antialiasing mode for nontext drawing operations.
    ///    
    D2D1_ANTIALIAS_MODE GetAntialiasMode();
    ///Specifies the antialiasing mode to use for subsequent text and glyph drawing operations.
    ///Params:
    ///    textAntialiasMode = Type: <b>D2D1_TEXT_ANTIALIAS_MODE</b> The antialiasing mode to use for subsequent text and glyph drawing
    ///                        operations.
    void    SetTextAntialiasMode(D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode);
    ///Gets the current antialiasing mode for text and glyph drawing operations.
    ///Returns:
    ///    Type: <b>D2D1_TEXT_ANTIALIAS_MODE</b> The current antialiasing mode for text and glyph drawing operations.
    ///    
    D2D1_TEXT_ANTIALIAS_MODE GetTextAntialiasMode();
    ///Specifies text rendering options to be applied to all subsequent text and glyph drawing operations.
    ///Params:
    ///    textRenderingParams = Type: <b>IDWriteRenderingParams*</b> The text rendering options to be applied to all subsequent text and
    ///                          glyph drawing operations; <b>NULL</b> to clear current text rendering options.
    void    SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    ///Retrieves the render target's current text rendering options.
    ///Params:
    ///    textRenderingParams = Type: <b>IDWriteRenderingParams**</b> When this method returns, <i>textRenderingParams</i>contains the
    ///                          address of a pointer to the render target's current text rendering options.
    void    GetTextRenderingParams(IDWriteRenderingParams* textRenderingParams);
    ///Specifies a label for subsequent drawing operations.
    ///Params:
    ///    tag1 = Type: <b>D2D1_TAG</b> A label to apply to subsequent drawing operations.
    ///    tag2 = Type: <b>D2D1_TAG</b> A label to apply to subsequent drawing operations.
    void    SetTags(ulong tag1, ulong tag2);
    ///Gets the label for subsequent drawing operations.
    ///Params:
    ///    tag1 = Type: <b>D2D1_TAG*</b> When this method returns, contains the first label for subsequent drawing operations.
    ///           This parameter is passed uninitialized. If <b>NULL</b> is specified, no value is retrieved for this
    ///           parameter.
    ///    tag2 = Type: <b>D2D1_TAG*</b> When this method returns, contains the second label for subsequent drawing operations.
    ///           This parameter is passed uninitialized. If <b>NULL</b> is specified, no value is retrieved for this
    ///           parameter.
    void    GetTags(ulong* tag1, ulong* tag2);
    void    PushLayer(const(D2D1_LAYER_PARAMETERS)* layerParameters, ID2D1Layer layer);
    ///Stops redirecting drawing operations to the layer that is specified by the last PushLayer call.
    void    PopLayer();
    ///Executes all pending drawing commands.
    ///Params:
    ///    tag1 = Type: <b>D2D1_TAG*</b> When this method returns, contains the tag for drawing operations that caused errors
    ///           or 0 if there were no errors. This parameter is passed uninitialized.
    ///    tag2 = Type: <b>D2D1_TAG*</b> When this method returns, contains the tag for drawing operations that caused errors
    ///           or 0 if there were no errors. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b>
    ///    error code and sets <i>tag1</i> and <i>tag2</i> to the tags that were active when the error occurred. If no
    ///    error occurred, this method sets the error tag state to be (0,0).
    ///    
    HRESULT Flush(ulong* tag1, ulong* tag2);
    ///Saves the current drawing state to the specified ID2D1DrawingStateBlock.
    ///Params:
    ///    drawingStateBlock = Type: <b>ID2D1DrawingStateBlock*</b> When this method returns, contains the current drawing state of the
    ///                        render target. This parameter must be initialized before passing it to the method.
    void    SaveDrawingState(ID2D1DrawingStateBlock drawingStateBlock);
    ///Sets the render target's drawing state to that of the specified ID2D1DrawingStateBlock.
    ///Params:
    ///    drawingStateBlock = Type: <b>ID2D1DrawingStateBlock*</b> The new drawing state of the render target.
    void    RestoreDrawingState(ID2D1DrawingStateBlock drawingStateBlock);
    void    PushAxisAlignedClip(const(D2D_RECT_F)* clipRect, D2D1_ANTIALIAS_MODE antialiasMode);
    ///Removes the last axis-aligned clip from the render target. After this method is called, the clip is no longer
    ///applied to subsequent drawing operations.
    void    PopAxisAlignedClip();
    void    Clear(const(DXGI_RGBA)* clearColor);
    ///Initiates drawing on this render target.
    void    BeginDraw();
    ///Ends drawing operations on the render target and indicates the current error state and associated tags.
    ///Params:
    ///    tag1 = Type: <b>D2D1_TAG*</b> When this method returns, contains the tag for drawing operations that caused errors
    ///           or 0 if there were no errors. This parameter is passed uninitialized.
    ///    tag2 = Type: <b>D2D1_TAG*</b> When this method returns, contains the tag for drawing operations that caused errors
    ///           or 0 if there were no errors. This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b>
    ///    error code and sets <i>tag1</i> and <i>tag2</i> to the tags that were active when the error occurred.
    ///    
    HRESULT EndDraw(ulong* tag1, ulong* tag2);
    ///Retrieves the pixel format and alpha mode of the render target.
    ///Returns:
    ///    Type: <b>D2D1_PIXEL_FORMAT</b> The pixel format and alpha mode of the render target.
    ///    
    D2D1_PIXEL_FORMAT GetPixelFormat();
    ///Sets the dots per inch (DPI) of the render target.
    ///Params:
    ///    dpiX = Type: <b>FLOAT</b> A value greater than or equal to zero that specifies the horizontal DPI of the render
    ///           target.
    ///    dpiY = Type: <b>FLOAT</b> A value greater than or equal to zero that specifies the vertical DPI of the render
    ///           target.
    void    SetDpi(float dpiX, float dpiY);
    ///Return the render target's dots per inch (DPI).
    ///Params:
    ///    dpiX = Type: <b>FLOAT*</b> When this method returns, contains the horizontal DPI of the render target. This
    ///           parameter is passed uninitialized.
    ///    dpiY = Type: <b>FLOAT*</b> When this method returns, contains the vertical DPI of the render target. This parameter
    ///           is passed uninitialized.
    void    GetDpi(float* dpiX, float* dpiY);
    ///Returns the size of the render target in device-independent pixels.
    ///Returns:
    ///    Type: <b>D2D1_SIZE_F</b> The current size of the render target in device-independent pixels.
    ///    
    D2D_SIZE_F GetSize();
    ///Returns the size of the render target in device pixels.
    ///Returns:
    ///    Type: <b>D2D1_SIZE_U</b> The size of the render target in device pixels.
    ///    
    D2D_SIZE_U GetPixelSize();
    ///Gets the maximum size, in device-dependent units (pixels), of any one bitmap dimension supported by the render
    ///target.
    ///Returns:
    ///    Type: <b>UINT32</b> The maximum size, in pixels, of any one bitmap dimension supported by the render target.
    ///    
    uint    GetMaximumBitmapSize();
    BOOL    IsSupported(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties);
}

///Renders to an intermediate texture created by the CreateCompatibleRenderTarget method.
@GUID("2CD90695-12E2-11DC-9FED-001143A055F9")
interface ID2D1BitmapRenderTarget : ID2D1RenderTarget
{
    ///Retrieves the bitmap for this render target. The returned bitmap can be used for drawing operations.
    ///Params:
    ///    bitmap = Type: <b>ID2D1Bitmap**</b> When this method returns, contains the address of a pointer to the bitmap for this
    ///             render target. This bitmap can be used for drawing operations.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT GetBitmap(ID2D1Bitmap* bitmap);
}

///Renders drawing instructions to a window.
@GUID("2CD90698-12E2-11DC-9FED-001143A055F9")
interface ID2D1HwndRenderTarget : ID2D1RenderTarget
{
    ///Indicates whether the HWND associated with this render target is occluded.
    ///Returns:
    ///    Type: <b>D2D1_WINDOW_STATE</b> A value that indicates whether the HWND associated with this render target is
    ///    occluded.
    ///    
    D2D1_WINDOW_STATE CheckWindowState();
    HRESULT Resize(const(D2D_SIZE_U)* pixelSize);
    ///Returns the HWND associated with this render target.
    ///Returns:
    ///    Type: <b>HWND</b> The HWND associated with this render target.
    ///    
    HWND    GetHwnd();
}

///Provides access to an device context that can accept GDI drawing commands.
@GUID("E0DB51C3-6F77-4BAE-B3D5-E47509B35838")
interface ID2D1GdiInteropRenderTarget : IUnknown
{
    ///Retrieves the device context associated with this render target.
    ///Params:
    ///    mode = Type: <b>D2D1_DC_INITIALIZE_MODE</b> A value that specifies whether the device context should be cleared.
    ///    hdc = Type: <b>HDC*</b> When this method returns, contains the device context associated with this render target.
    ///          You must allocate storage for this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT GetDC(D2D1_DC_INITIALIZE_MODE mode, HDC* hdc);
    ///Indicates that drawing with the device context retrieved using the GetDC method is finished.
    ///Params:
    ///    update = Type: <b>RECT*</b> The modified region of the device context, or <b>NULL</b> to specify the entire render
    ///             target.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT ReleaseDC(const(RECT)* update);
}

///Issues drawing commands to a GDI device context.
@GUID("1C51BC64-DE61-46FD-9899-63A5D8F03950")
interface ID2D1DCRenderTarget : ID2D1RenderTarget
{
    ///Binds the render target to the device context to which it issues drawing commands.
    ///Params:
    ///    hDC = Type: <b>const HDC</b> The device context to which the render target issues drawing commands.
    ///    pSubRect = Type: <b>const RECT*</b> The dimensions of the handle to a device context (HDC) to which the render target is
    ///               bound.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT BindDC(const(ptrdiff_t) hDC, const(RECT)* pSubRect);
}

///Creates Direct2D resources.
@GUID("06152247-6F50-465A-9245-118BFD3B6007")
interface ID2D1Factory : IUnknown
{
    ///Forces the factory to refresh any system defaults that it might have changed since factory creation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT ReloadSystemMetrics();
    ///Retrieves the current desktop dots per inch (DPI). To refresh this value, call ReloadSystemMetrics.
    ///Params:
    ///    dpiX = Type: <b>FLOAT*</b> When this method returns, contains the horizontal DPI of the desktop. You must allocate
    ///           storage for this parameter.
    ///    dpiY = Type: <b>FLOAT*</b> When this method returns, contains the vertical DPI of the desktop. You must allocate
    ///           storage for this parameter.
    void    GetDesktopDpi(float* dpiX, float* dpiY);
    HRESULT CreateRectangleGeometry(const(D2D_RECT_F)* rectangle, ID2D1RectangleGeometry* rectangleGeometry);
    HRESULT CreateRoundedRectangleGeometry(const(D2D1_ROUNDED_RECT)* roundedRectangle, 
                                           ID2D1RoundedRectangleGeometry* roundedRectangleGeometry);
    HRESULT CreateEllipseGeometry(const(D2D1_ELLIPSE)* ellipse, ID2D1EllipseGeometry* ellipseGeometry);
    ///Creates an ID2D1GeometryGroup, which is an object that holds other geometries.
    ///Params:
    ///    fillMode = Type: <b>D2D1_FILL_MODE</b> A value that specifies the rule that a composite shape uses to determine whether
    ///               a given point is part of the geometry.
    ///    geometries = Type: <b>ID2D1Geometry**</b> An array containing the geometry objects to add to the geometry group. The
    ///                 number of elements in this array is indicated by the <i>geometriesCount</i> parameter.
    ///    geometriesCount = Type: <b>UINT</b> The number of elements in <i>geometries</i>.
    ///    geometryGroup = Type: <b>ID2D1GeometryGroup**</b> When this method returns, contains the address of a pointer to the geometry
    ///                    group created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CreateGeometryGroup(D2D1_FILL_MODE fillMode, char* geometries, uint geometriesCount, 
                                ID2D1GeometryGroup* geometryGroup);
    HRESULT CreateTransformedGeometry(ID2D1Geometry sourceGeometry, const(D2D_MATRIX_3X2_F)* transform, 
                                      ID2D1TransformedGeometry* transformedGeometry);
    ///Creates an empty ID2D1PathGeometry.
    ///Params:
    ///    pathGeometry = Type: <b>ID2D1PathGeometry**</b> When this method returns, contains the address to a pointer to the path
    ///                   geometry created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CreatePathGeometry(ID2D1PathGeometry* pathGeometry);
    HRESULT CreateStrokeStyle(const(D2D1_STROKE_STYLE_PROPERTIES)* strokeStyleProperties, char* dashes, 
                              uint dashesCount, ID2D1StrokeStyle* strokeStyle);
    HRESULT CreateDrawingStateBlock(const(D2D1_DRAWING_STATE_DESCRIPTION)* drawingStateDescription, 
                                    IDWriteRenderingParams textRenderingParams, 
                                    ID2D1DrawingStateBlock* drawingStateBlock);
    HRESULT CreateWicBitmapRenderTarget(IWICBitmap target, 
                                        const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                        ID2D1RenderTarget* renderTarget);
    HRESULT CreateHwndRenderTarget(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                   const(D2D1_HWND_RENDER_TARGET_PROPERTIES)* hwndRenderTargetProperties, 
                                   ID2D1HwndRenderTarget* hwndRenderTarget);
    ///Creates a render target that draws to a DirectX Graphics Infrastructure (DXGI) surface.
    ///Params:
    ///    dxgiSurface = Type: <b>IDXGISurface*</b> The IDXGISurface to which the render target will draw.
    ///    renderTargetProperties = Type: <b>const D2D1_RENDER_TARGET_PROPERTIES*</b> The rendering mode, pixel format, remoting options, DPI
    ///                             information, and the minimum DirectX support required for hardware rendering. For information about supported
    ///                             pixel formats, see Supported Pixel Formats and Alpha Modes.
    ///    renderTarget = Type: <b>ID2D1RenderTarget**</b> When this method returns, contains the address of the pointer to the
    ///                   ID2D1RenderTarget object created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CreateDxgiSurfaceRenderTarget(IDXGISurface dxgiSurface, 
                                          const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                          ID2D1RenderTarget* renderTarget);
    ///Creates a render target that draws to a Windows Graphics Device Interface (GDI) device context.
    ///Params:
    ///    renderTargetProperties = Type: <b>const D2D1_RENDER_TARGET_PROPERTIES*</b> The rendering mode, pixel format, remoting options, DPI
    ///                             information, and the minimum DirectX support required for hardware rendering. To enable the device context
    ///                             (DC) render target to work with GDI, set the DXGI format to DXGI_FORMAT_B8G8R8A8_UNORM and the alpha mode to
    ///                             D2D1_ALPHA_MODE_PREMULTIPLIED or <b>D2D1_ALPHA_MODE_IGNORE</b>. For more information about pixel formats, see
    ///                             Supported Pixel Formats and Alpha Modes.
    ///    dcRenderTarget = Type: <b>ID2D1DCRenderTarget**</b> When this method returns, <i>dcRenderTarget</i> contains the address of
    ///                     the pointer to the ID2D1DCRenderTarget created by the method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) error code.
    ///    
    HRESULT CreateDCRenderTarget(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, 
                                 ID2D1DCRenderTarget* dcRenderTarget);
}

///A developer implemented interface that allows a metafile to be replayed.
@GUID("82237326-8111-4F7C-BCF4-B5C1175564FE")
interface ID2D1GdiMetafileSink : IUnknown
{
    ///This method is called once for each record stored in a metafile.
    ///Params:
    ///    recordType = Type: <b>DWORD</b> The type of the record.
    ///    recordData = Type: <b>void*</b> The data for the record.
    ///    recordDataSize = Type: <b>UINT</b> The byte size of the record data.
    ///Returns:
    ///    Type: <b>BOOL</b> Return true if the record is successfully.
    ///    
    HRESULT ProcessRecord(uint recordType, const(void)* recordData, uint recordDataSize);
}

///A Direct2D resource that wraps a WMF, EMF, or EMF+ metafile.
@GUID("2F543DC3-CFC1-4211-864F-CFD91C6F3395")
interface ID2D1GdiMetafile : ID2D1Resource
{
    ///This method streams the contents of the command to the given metafile sink.
    ///Params:
    ///    sink = Type: <b>ID2D1GdiMetafileSink</b> The sink into which Direct2D will call back.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT Stream(ID2D1GdiMetafileSink sink);
    ///Gets the bounds of the metafile, in device-independent pixels (DIPs), as reported in the metafile’s header.
    ///Params:
    ///    bounds = Type: <b>D2D1_RECT_F*</b> The bounds, in DIPs, of the metafile.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT GetBounds(D2D_RECT_F* bounds);
}

///The command sink is implemented by you for an application when you want to receive a playback of the commands
///recorded in a command list. A typical usage will be for transforming the command list into another format such as XPS
///when some degree of conversion between the Direct2D primitives and the target format is required. The command sink
///interface doesn't have any resource creation methods on it. The resources are still logically bound to the Direct2D
///device on which the command list was created and will be passed in to the command sink implementation.
@GUID("54D7898A-A061-40A7-BEC7-E465BCBA2C4F")
interface ID2D1CommandSink : IUnknown
{
    ///Notifies the implementation of the command sink that drawing is about to commence.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method always returns <b>S_OK</b>.
    ///    
    HRESULT BeginDraw();
    ///Indicates when ID2D1CommandSink processing has completed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method/function succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT EndDraw();
    ///Sets the antialiasing mode that will be used to render any subsequent geometry.
    ///Params:
    ///    antialiasMode = Type: <b>D2D1_ANTIALIAS_MODE</b> The antialiasing mode selected for the command list.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetAntialiasMode(D2D1_ANTIALIAS_MODE antialiasMode);
    ///Sets the tags that correspond to the tags in the command sink.
    ///Params:
    ///    tag1 = Type: <b>D2D1_TAG</b> The first tag to associate with the primitive.
    ///    tag2 = Type: <b>D2D1_TAG</b> The second tag to associate with the primitive.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetTags(ulong tag1, ulong tag2);
    ///Indicates the new default antialiasing mode for text.
    ///Params:
    ///    textAntialiasMode = Type: <b>D2D1_TEXT_ANTIALIAS_MODE</b> The antialiasing mode for the text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetTextAntialiasMode(D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode);
    ///Indicates more detailed text rendering parameters.
    ///Params:
    ///    textRenderingParams = Type: <b>IDWriteRenderingParams*</b> The parameters to use for text rendering.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    ///Sets a new transform.
    ///Params:
    ///    transform = Type: <b>const D2D1_MATRIX_3X2_F*</b> The transform to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    ///Sets a new primitive blend mode.
    ///Params:
    ///    primitiveBlend = Type: <b>D2D1_PRIMITIVE_BLEND</b> The primitive blend that will apply to subsequent primitives.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetPrimitiveBlend(D2D1_PRIMITIVE_BLEND primitiveBlend);
    ///The unit mode changes the meaning of subsequent units from device-independent pixels (DIPs) to pixels or the
    ///other way. The command sink does not record a DPI, this is implied by the playback context or other playback
    ///interface such as ID2D1PrintControl.
    ///Params:
    ///    unitMode = Type: <b>D2D1_UNIT_MODE</b> The enumeration that specifies how units are to be interpreted.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetUnitMode(D2D1_UNIT_MODE unitMode);
    ///Clears the drawing area to the specified color.
    ///Params:
    ///    color = Type: <b>const D2D1_COLOR_F*</b> The color to which the command sink should be cleared.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT Clear(const(DXGI_RGBA)* color);
    ///Indicates the glyphs to be drawn.
    ///Params:
    ///    baselineOrigin = Type: <b>D2D1_POINT_2F</b> The upper left corner of the baseline.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> The glyphs to render.
    ///    glyphRunDescription = Type: <b>const DWRITE_GLYPH_RUN_DESCRIPTION*</b> Additional non-rendering information about the glyphs.
    ///    foregroundBrush = Type: <b>ID2D1Brush*</b> The brush used to fill the glyphs.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The measuring mode to apply to the glyphs.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                         const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, ID2D1Brush foregroundBrush, 
                         DWRITE_MEASURING_MODE measuringMode);
    ///Draws a line drawn between two points.
    ///Params:
    ///    point0 = Type: <b>D2D1_POINT_2F</b> The start point of the line.
    ///    point1 = Type: <b>D2D1_POINT_2F</b> The end point of the line.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush used to fill the line.
    ///    strokeWidth = Type: <b>FLOAT</b> The width of the stroke to fill the line.
    ///    strokeStyle = Type: <b>ID2D1StrokeStyle*</b> The style of the stroke. If not specified, the stroke is solid.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT DrawLine(D2D_POINT_2F point0, D2D_POINT_2F point1, ID2D1Brush brush, float strokeWidth, 
                     ID2D1StrokeStyle strokeStyle);
    ///Indicates the geometry to be drawn to the command sink.
    ///Params:
    ///    geometry = Type: <b>ID2D1Geometry *</b> The geometry to be stroked.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush that will be used to fill the stroked geometry.
    ///    strokeWidth = Type: <b>FLOAT</b> The width of the stroke.
    ///    strokeStyle = Type: <b>ID2D1StrokeStyle*</b> The style of the stroke.
    ///Returns:
    ///    Type: <b>HRESULT</b> An HRESULT.
    ///    
    HRESULT DrawGeometry(ID2D1Geometry geometry, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    ///Draws a rectangle.
    ///Params:
    ///    rect = Type: <b>const D2D1_RECT_F*</b> The rectangle to be drawn to the command sink.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush used to stroke the geometry.
    ///    strokeWidth = Type: <b>FLOAT</b> The width of the stroke.
    ///    strokeStyle = Type: <b>ID2D1StrokeStyle*</b> The style of the stroke.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT DrawRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush, float strokeWidth, 
                          ID2D1StrokeStyle strokeStyle);
    ///Draws a bitmap to the render target.
    ///Params:
    ///    bitmap = Type: <b>ID2D1Bitmap*</b> The bitmap to draw.
    ///    destinationRectangle = Type: <b>D2D1_RECT_F</b> The destination rectangle. The default is the size of the bitmap and the location is
    ///                           the upper left corner of the render target.
    ///    opacity = Type: <b>FLOAT</b> The opacity of the bitmap.
    ///    interpolationMode = Type: <b>D2D1_INTERPOLATION_MODE</b> The interpolation mode to use.
    ///    sourceRectangle = Type: <b>const D2D1_RECT_F</b> An optional source rectangle.
    ///    perspectiveTransform = Type: <b>const D2D1_MATRIX_4X4_F</b> An optional perspective transform.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, 
                       D2D1_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle, 
                       const(D2D_MATRIX_4X4_F)* perspectiveTransform);
    ///Draws the provided image to the command sink.
    ///Params:
    ///    image = Type: <b>ID2D1Image*</b> The image to be drawn to the command sink.
    ///    targetOffset = Type: <b>const D2D1_POINT_2F*</b> This defines the offset in the destination space that the image will be
    ///                   rendered to. The entire logical extent of the image will be rendered to the corresponding destination. If not
    ///                   specified, the destination origin will be (0, 0). The top-left corner of the image will be mapped to the
    ///                   target offset. This will not necessarily be the origin.
    ///    imageRectangle = Type: <b>const D2D1_RECT_F*</b> The corresponding rectangle in the image space will be mapped to the provided
    ///                     origins when processing the image.
    ///    interpolationMode = Type: <b>D2D1_INTERPOLATION_MODE</b> The interpolation mode to use to scale the image if necessary.
    ///    compositeMode = Type: <b>D2D1_COMPOSITE_MODE</b> If specified, the composite mode that will be applied to the limits of the
    ///                    currently selected clip.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT DrawImage(ID2D1Image image, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, 
                      D2D1_INTERPOLATION_MODE interpolationMode, D2D1_COMPOSITE_MODE compositeMode);
    ///Draw a metafile to the device context.
    ///Params:
    ///    gdiMetafile = Type: <b>ID2D1GdiMetafile*</b> The metafile to draw.
    ///    targetOffset = Type: <b>const D2D1_POINT_2F*</b> The offset from the upper left corner of the render target.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_POINT_2F)* targetOffset);
    ///Indicates a mesh to be filled by the command sink.
    ///Params:
    ///    mesh = Type: <b>ID2D1Mesh*</b> The mesh object to be filled.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush with which to fill the mesh.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT FillMesh(ID2D1Mesh mesh, ID2D1Brush brush);
    ///Fills an opacity mask on the command sink.
    ///Params:
    ///    opacityMask = Type: <b>ID2D1Bitmap*</b> The bitmap whose alpha channel will be sampled to define the opacity mask.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush with which to fill the mask.
    ///    destinationRectangle = Type: <b>const D2D1_RECT_F*</b> The destination rectangle in which to fill the mask. If not specified, this
    ///                           is the origin.
    ///    sourceRectangle = Type: <b>const D2D1_RECT_F*</b> The source rectangle within the opacity mask. If not specified, this is the
    ///                      entire mask.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
    ///Indicates to the command sink a geometry to be filled.
    ///Params:
    ///    geometry = Type: <b>ID2D1Geometry*</b> The geometry that should be filled.
    ///    brush = Type: <b>ID2D1Brush*</b> The primary brush used to fill the geometry.
    ///    opacityBrush = Type: <b>ID2D1Brush*</b> A brush whose alpha channel is used to modify the opacity of the primary fill brush.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT FillGeometry(ID2D1Geometry geometry, ID2D1Brush brush, ID2D1Brush opacityBrush);
    ///Indicates to the command sink a rectangle to be filled.
    ///Params:
    ///    rect = Type: <b>const D2D1_RECT_F*</b> The rectangle to fill.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush with which to fill the rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT FillRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush);
    ///Pushes a clipping rectangle onto the clip and layer stack.
    ///Params:
    ///    clipRect = Type: <b>const D2D1_RECT_F*</b> The rectangle that defines the clip.
    ///    antialiasMode = Type: <b>D2D1_ANTIALIAS_MODE</b> The antialias mode for the clip.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT PushAxisAlignedClip(const(D2D_RECT_F)* clipRect, D2D1_ANTIALIAS_MODE antialiasMode);
    ///Pushes a layer onto the clip and layer stack.
    ///Params:
    ///    layerParameters1 = Type: <b>const D2D1_LAYER_PARAMETERS1*</b> The parameters that define the layer.
    ///    layer = Type: <b>ID2D1Layer*</b> The layer resource that receives subsequent drawing operations.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT PushLayer(const(D2D1_LAYER_PARAMETERS1)* layerParameters1, ID2D1Layer layer);
    ///Removes an axis-aligned clip from the layer and clip stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT PopAxisAlignedClip();
    ///Removes a layer from the layer and clip stack.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT PopLayer();
}

///Represents a sequence of commands that can be recorded and played back.
@GUID("B4F34A19-2383-4D76-94F6-EC343657C3DC")
interface ID2D1CommandList : ID2D1Image
{
    ///Streams the contents of the command list to the specified command sink.
    ///Params:
    ///    sink = Type: <b>ID2D1CommandSink*</b> The sink into which the command list will be streamed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code. The return value indicates any failures the command sink implementation returns
    ///    through its EndDraw method.
    ///    
    HRESULT Stream(ID2D1CommandSink sink);
    ///Instructs the command list to stop accepting commands so that you can use it as an input to an effect or in a
    ///call to ID2D1DeviceContext::DrawImage. You should call the method after it has been attached to an
    ///ID2D1DeviceContext and written to but before the command list is used.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>D2DERR_WRONG_STATE </td> <td>Close has already been called on the
    ///    command list.</td> </tr> </table> <div class="alert"><b>Note</b> If the device context associated with the
    ///    command list has an error, the command list returns the same error.</div> <div> </div>
    ///    
    HRESULT Close();
}

///Converts Direct2D primitives stored in an ID2D1CommandList into a fixed page representation. The print sub-system
///then consumes the primitives.
@GUID("2C1D867D-C290-41C8-AE7E-34A98702E9A5")
interface ID2D1PrintControl : IUnknown
{
    ///Converts Direct2D primitives in the passed-in command list into a fixed page representation for use by the print
    ///subsystem.
    ///Params:
    ///    commandList = Type: <b>ID2D1CommandList*</b> The command list that contains the rendering operations.
    ///    pageSize = Type: <b>D2D_SIZE_F</b> The size of the page to add.
    ///    pagePrintTicketStream = Type: <b>IStream*</b> The print ticket stream.
    ///    tag1 = Type: <b>D2D1_TAG*</b> Contains the first label for subsequent drawing operations. This parameter is passed
    ///           uninitialized. If NULL is specified, no value is retrieved for this parameter.
    ///    tag2 = Type: <b>D2D1_TAG*</b> Contains the second label for subsequent drawing operations. This parameter is passed
    ///           uninitialized. If NULL is specified, no value is retrieved for this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> <tr> <td>D2DERR_PRINT_JOB_CLOSED</td> <td>The print job is already
    ///    finished.</td> </tr> </table>
    ///    
    HRESULT AddPage(ID2D1CommandList commandList, D2D_SIZE_F pageSize, IStream pagePrintTicketStream, ulong* tag1, 
                    ulong* tag2);
    ///Passes all remaining resources to the print sub-system, then clean up and close the current print job.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> <tr> <td>D2DERR_PRINT_JOB_CLOSED</td> <td>The print job is already
    ///    finished.</td> </tr> </table>
    ///    
    HRESULT Close();
}

///Represents a brush based on an ID2D1Image.
@GUID("FE9E984D-3F95-407C-B5DB-CB94D4E8F87C")
interface ID2D1ImageBrush : ID2D1Brush
{
    ///Sets the image associated with the provided image brush.
    ///Params:
    ///    image = Type: <b>ID2D1Image*</b> The image to be associated with the image brush.
    void SetImage(ID2D1Image image);
    ///Sets how the content inside the source rectangle in the image brush will be extended on the x-axis.
    ///Params:
    ///    extendModeX = Type: <b>D2D1_EXTEND_MODE</b> The extend mode on the x-axis of the image.
    void SetExtendModeX(D2D1_EXTEND_MODE extendModeX);
    ///Sets the extend mode on the y-axis.
    ///Params:
    ///    extendModeY = Type: <b>D2D1_EXTEND_MODE</b> The extend mode on the y-axis of the image.
    void SetExtendModeY(D2D1_EXTEND_MODE extendModeY);
    ///Sets the interpolation mode for the image brush.
    ///Params:
    ///    interpolationMode = Type: <b>D2D1_INTERPOLATION_MODE</b> How the contents of the image will be interpolated to handle the brush
    ///                        transform.
    void SetInterpolationMode(D2D1_INTERPOLATION_MODE interpolationMode);
    ///Sets the source rectangle in the image brush.
    ///Params:
    ///    sourceRectangle = Type: <b>const D2D1_RECT_F*</b> The source rectangle that defines the portion of the image to tile.
    void SetSourceRectangle(const(D2D_RECT_F)* sourceRectangle);
    ///Gets the image associated with the image brush.
    ///Params:
    ///    image = Type: <b>ID2D1Image**</b> When this method returns, contains the address of a pointer to the image associated
    ///            with this brush.
    void GetImage(ID2D1Image* image);
    ///Gets the extend mode of the image brush on the x-axis.
    ///Returns:
    ///    Type: <b>D2D1_EXTEND_MODE</b> This method returns the x-extend mode.
    ///    
    D2D1_EXTEND_MODE GetExtendModeX();
    ///Gets the extend mode of the image brush on the y-axis of the image.
    ///Returns:
    ///    Type: <b>D2D1_EXTEND_MODE</b> This method returns the y-extend mode.
    ///    
    D2D1_EXTEND_MODE GetExtendModeY();
    ///Gets the interpolation mode of the image brush.
    ///Returns:
    ///    Type: <b>D2D1_INTERPOLATION_MODE</b> This method returns the interpolation mode.
    ///    
    D2D1_INTERPOLATION_MODE GetInterpolationMode();
    ///Gets the rectangle that will be used as the bounds of the image when drawn as an image brush.
    ///Params:
    ///    sourceRectangle = Type: <b>D2D1_RECT_F*</b> When this method returns, contains the address of the output source rectangle.
    void GetSourceRectangle(D2D_RECT_F* sourceRectangle);
}

///Paints an area with a bitmap.
@GUID("41343A53-E41A-49A2-91CD-21793BBB62E5")
interface ID2D1BitmapBrush1 : ID2D1BitmapBrush
{
    ///Sets the interpolation mode for the brush.
    ///Params:
    ///    interpolationMode = Type: <b>D2D1_INTERPOLATION_MODE</b> The mode to use.
    ///Returns:
    ///    <div class="alert"><b>Note</b> If <i>interpolationMode</i> is not a valid member of D2D1_INTERPOLATION_MODE,
    ///    then this method silently ignores the call. </div> <div> </div>
    ///    
    void SetInterpolationMode1(D2D1_INTERPOLATION_MODE interpolationMode);
    ///Returns the current interpolation mode of the brush.
    ///Returns:
    ///    Type: <b>D2D1_INTERPOLATION_MODE</b> The current interpolation mode.
    ///    
    D2D1_INTERPOLATION_MODE GetInterpolationMode1();
}

///Describes the caps, miter limit, line join, and dash information for a stroke.
@GUID("10A72A66-E91C-43F4-993F-DDF4B82B0B4A")
interface ID2D1StrokeStyle1 : ID2D1StrokeStyle
{
    ///Gets the stroke transform type.
    ///Returns:
    ///    Type: <b>D2D1_STROKE_TRANSFORM_TYPE</b> This method returns the stroke transform type.
    ///    
    D2D1_STROKE_TRANSFORM_TYPE GetStrokeTransformType();
}

///The <b>ID2D1PathGeometry1</b> interface adds functionality to ID2D1PathGeometry. In particular, it provides the path
///geometry-specific ComputePointAndSegmentAtLength method.
@GUID("62BAA2D2-AB54-41B7-B872-787E0106A421")
interface ID2D1PathGeometry1 : ID2D1PathGeometry
{
    HRESULT ComputePointAndSegmentAtLength(float length, uint startSegment, 
                                           const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, 
                                           D2D1_POINT_DESCRIPTION* pointDescription);
}

///Represents a set of run-time bindable and discoverable properties that allow a data-driven application to modify the
///state of a Direct2D effect.
@GUID("483473D7-CD46-4F9D-9D3A-3112AA80159D")
interface ID2D1Properties : IUnknown
{
    ///Gets the number of top-level properties.
    ///Returns:
    ///    Type: <b>UINT32</b> This method returns the number of custom (non-system) properties that can be accessed by
    ///    the object.
    ///    
    uint    GetPropertyCount();
    HRESULT GetPropertyName(uint index, const(wchar)* name, uint nameCount);
    uint    GetPropertyNameLength(uint index);
    D2D1_PROPERTY_TYPE GetType(uint index);
    ///Gets the index corresponding to the given property name.
    ///Params:
    ///    name = Type: <b>PCWSTR</b> The name of the property to retrieve.
    ///Returns:
    ///    Type: <b>UINT32</b> The index of the corresponding property name.
    ///    
    uint    GetPropertyIndex(const(wchar)* name);
    HRESULT SetValueByName(const(wchar)* name, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    HRESULT SetValue(uint index, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    HRESULT GetValueByName(const(wchar)* name, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    HRESULT GetValue(uint index, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    uint    GetValueSize(uint index);
    HRESULT GetSubProperties(uint index, ID2D1Properties* subProperties);
}

///Represents a basic image-processing construct in Direct2D.
@GUID("28211A43-7D89-476F-8181-2D6159B220AD")
interface ID2D1Effect : ID2D1Properties
{
    ///Sets the given input image by index.
    ///Params:
    ///    index = Type: <b>UINT32</b> The index of the image to set.
    ///    input = Type: <b>ID2D1Image*</b> The input image to set.
    ///    invalidate = Type: <b>BOOL</b> Whether to invalidate the graph at the location of the effect input
    void    SetInput(uint index, ID2D1Image input, BOOL invalidate);
    ///Allows the application to change the number of inputs to an effect.
    ///Params:
    ///    inputCount = Type: <b>UINT32</b> The number of inputs to the effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>One or more arguments are invalid.</td>
    ///    </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Failed to allocate necessary memory.</td> </tr> </table>
    ///    
    HRESULT SetInputCount(uint inputCount);
    ///Gets the given input image by index.
    ///Params:
    ///    index = Type: <b>UINT32</b> The index of the image to retrieve.
    ///    input = Type: <b>ID2D1Image**</b> When this method returns, contains the address of a pointer to the image that is
    ///            identified by <i>Index</i>.
    void    GetInput(uint index, ID2D1Image* input);
    ///Gets the number of inputs to the effect.
    ///Returns:
    ///    Type: <b>UINT32</b> This method returns the number of inputs to the effect.
    ///    
    uint    GetInputCount();
    ///Gets the output image from the effect.
    ///Params:
    ///    outputImage = Type: <b>ID2D1Image**</b> When this method returns, contains the address of a pointer to the output image for
    ///                  the effect.
    void    GetOutput(ID2D1Image* outputImage);
}

///Represents a bitmap that can be used as a surface for an ID2D1DeviceContext or mapped into system memory, and can
///contain additional color context information.
@GUID("A898A84C-3873-4588-B08B-EBBF978DF041")
interface ID2D1Bitmap1 : ID2D1Bitmap
{
    ///Gets the color context information associated with the bitmap.
    ///Params:
    ///    colorContext = Type: <b>ID2D1ColorContext**</b> When this method returns, contains the address of a pointer to the color
    ///                   context interface associated with the bitmap.
    void    GetColorContext(ID2D1ColorContext* colorContext);
    ///Gets the options used in creating the bitmap.
    ///Returns:
    ///    Type: <b>D2D1_BITMAP_OPTIONS</b> This method returns the options used.
    ///    
    D2D1_BITMAP_OPTIONS GetOptions();
    ///Gets either the surface that was specified when the bitmap was created, or the default surface created when the
    ///bitmap was created.
    ///Params:
    ///    dxgiSurface = Type: <b>IDXGISurface**</b> The underlying DXGI surface for the bitmap.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>D2DERR_BITMAP_BOUND_AS_TARGET</td> <td>Cannot draw with a bitmap
    ///    that is currently bound as the target bitmap.</td> </tr> </table>
    ///    
    HRESULT GetSurface(IDXGISurface* dxgiSurface);
    ///Maps the given bitmap into memory.
    ///Params:
    ///    options = Type: <b>D2D1_MAP_OPTIONS</b> The options used in mapping the bitmap into memory.
    ///    mappedRect = Type: <b>D2D1_MAPPED_RECT*</b> When this method returns, contains a reference to the rectangle that is mapped
    ///                 into memory.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>One or more arguments are not valid</td>
    ///    </tr> <tr> <td>D3DERR_DEVICELOST</td> <td>The device has been lost but cannot be reset at this time.</td>
    ///    </tr> </table>
    ///    
    HRESULT Map(D2D1_MAP_OPTIONS options, D2D1_MAPPED_RECT* mappedRect);
    ///Unmaps the bitmap from memory.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>One or more arguments are not valid.</td>
    ///    </tr> <tr> <td>E_POINTER</td> <td>Pointer is not valid.</td> </tr> </table>
    ///    
    HRESULT Unmap();
}

///Represents a color context that can be used with an ID2D1Bitmap1 object.
@GUID("1C4820BB-5771-4518-A581-2FE4DD0EC657")
interface ID2D1ColorContext : ID2D1Resource
{
    ///Gets the color space of the color context.
    ///Returns:
    ///    Type: <b>D2D1_COLOR_SPACE</b> This method returns the color space of the contained ICC profile.
    ///    
    D2D1_COLOR_SPACE GetColorSpace();
    ///Gets the size of the color profile associated with the bitmap.
    ///Returns:
    ///    Type: <b>UINT32</b> This method returns the size of the profile in bytes.
    ///    
    uint    GetProfileSize();
    ///Gets the color profile bytes for an ID2D1ColorContext.
    ///Params:
    ///    profile = Type: <b>BYTE*</b> When this method returns, contains the color profile.
    ///    profileSize = Type: <b>UINT32</b> The size of the <i>profile</i> buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>D2DERR_INSUFFICIENT_BUFFER</td> <td>The supplied buffer was too
    ///    small to accomodate the data.</td> </tr> </table>
    ///    
    HRESULT GetProfile(char* profile, uint profileSize);
}

///Represents a collection of D2D1_GRADIENT_STOP objects for linear and radial gradient brushes. It provides get methods
///for all the new parameters added to the gradient stop collection.
@GUID("AE1572F4-5DD0-4777-998B-9279472AE63B")
interface ID2D1GradientStopCollection1 : ID2D1GradientStopCollection
{
    ///Copies the gradient stops from the collection into memory.
    ///Params:
    ///    gradientStops = Type: <b>D2D1_GRADIENT_STOP*</b> When this method returns, contains a pointer to a one-dimensional array of
    ///                    D2D1_GRADIENT_STOP structures.
    ///    gradientStopsCount = Type: <b>UINT</b> The number of gradient stops to copy.
    void GetGradientStops1(char* gradientStops, uint gradientStopsCount);
    ///Gets the color space of the input colors as well as the space in which gradient stops are interpolated.
    ///Returns:
    ///    Type: <b>D2D1_COLOR_SPACE</b> This method returns the color space.
    ///    
    D2D1_COLOR_SPACE GetPreInterpolationSpace();
    ///Gets the color space after interpolation has occurred.
    ///Returns:
    ///    Type: <b>D2D1_COLOR_SPACE</b> This method returns the color space.
    ///    
    D2D1_COLOR_SPACE GetPostInterpolationSpace();
    ///Gets the precision of the gradient buffer.
    ///Returns:
    ///    Type: <b>D2D1_BUFFER_PRECISION</b> The buffer precision of the gradient buffer.
    ///    
    D2D1_BUFFER_PRECISION GetBufferPrecision();
    ///Retrieves the color interpolation mode that the gradient stop collection uses.
    ///Returns:
    ///    Type: <b>D2D1_COLOR_INTERPOLATION_MODE</b> The color interpolation mode.
    ///    
    D2D1_COLOR_INTERPOLATION_MODE GetColorInterpolationMode();
}

///Implementation of a drawing state block that adds the functionality of primitive blend in addition to already
///existing antialias mode, transform, tags and text rendering mode.<div class="alert"><b>Note</b> You can get an
///<b>ID2D1DrawingStateBlock1</b> using the ID2D1Factory::CreateDrawingStateBlock method or you can use the
///QueryInterface method on an ID2D1DrawingStateBlock object.</div> <div> </div>
@GUID("689F1F85-C72E-4E33-8F19-85754EFD5ACE")
interface ID2D1DrawingStateBlock1 : ID2D1DrawingStateBlock
{
    ///Gets the antialiasing mode, transform, tags, primitive blend, and unit mode portion of the drawing state.
    ///Params:
    ///    stateDescription = Type: <b>D2D1_DRAWING_STATE_DESCRIPTION1*</b> When this method returns, contains the antialiasing mode,
    ///                       transform, tags, primitive blend, and unit mode portion of the drawing state. You must allocate storage for
    ///                       this parameter.
    void GetDescription(D2D1_DRAWING_STATE_DESCRIPTION1* stateDescription);
    ///Sets the D2D1_DRAWING_STATE_DESCRIPTION1 associated with this drawing state block.
    ///Params:
    ///    stateDescription = Type: <b>const D2D1_DRAWING_STATE_DESCRIPTION1</b> The D2D1_DRAWING_STATE_DESCRIPTION1 to be set associated
    ///                       with this drawing state block.
    void SetDescription(const(D2D1_DRAWING_STATE_DESCRIPTION1)* stateDescription);
}

///Represents a set of state and command buffers that are used to render to a target. The device context can render to a
///target bitmap or a command list.
@GUID("E8F7FE7A-191C-466D-AD95-975678BDA998")
interface ID2D1DeviceContext : ID2D1RenderTarget
{
    HRESULT CreateBitmap(D2D_SIZE_U size, const(void)* sourceData, uint pitch, 
                         const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, ID2D1Bitmap1* bitmap);
    HRESULT CreateBitmapFromWicBitmap(IWICBitmapSource wicBitmapSource, 
                                      const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, ID2D1Bitmap1* bitmap);
    ///Creates a color context.
    ///Params:
    ///    space = Type: <b>D2D1_COLOR_SPACE</b> The space of color context to create.
    ///    profile = Type: <b>const BYTE*</b> A buffer containing the ICC profile bytes used to initialize the color context when
    ///              <i>space</i> is D2D1_COLOR_SPACE_CUSTOM. For other types, the parameter is ignored and should be set to
    ///              <b>NULL</b>.
    ///    profileSize = Type: <b>UINT32</b> The size in bytes of <i>Profile</i>.
    ///    colorContext = Type: <b>ID2D1ColorContext**</b> When this method returns, contains the address of a pointer to a new color
    ///                   context object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateColorContext(D2D1_COLOR_SPACE space, char* profile, uint profileSize, 
                               ID2D1ColorContext* colorContext);
    ///Creates a color context by loading it from the specified filename. The profile bytes are the contents of the file
    ///specified by <i>Filename</i>.
    ///Params:
    ///    filename = Type: <b>PCWSTR</b> The path to the file containing the profile bytes to initialize the color context with.
    ///    colorContext = Type: <b>ID2D1ColorContext**</b> When this method returns, contains the address of a pointer to a new color
    ///                   context.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateColorContextFromFilename(const(wchar)* filename, ID2D1ColorContext* colorContext);
    ///Creates a color context from an IWICColorContext. The D2D1ColorContext space of the resulting context varies, see
    ///Remarks for more info.
    ///Params:
    ///    wicColorContext = Type: <b>IWICColorContext*</b> The IWICColorContext used to initialize the color context.
    ///    colorContext = Type: <b>ID2D1ColorContext**</b> When this method returns, contains the address of a pointer to a new color
    ///                   context.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateColorContextFromWicColorContext(IWICColorContext wicColorContext, 
                                                  ID2D1ColorContext* colorContext);
    HRESULT CreateBitmapFromDxgiSurface(IDXGISurface surface, const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, 
                                        ID2D1Bitmap1* bitmap);
    ///Creates an effect for the specified class ID.
    ///Params:
    ///    effectId = Type: <b>REFCLSID</b> The class ID of the effect to create. See Built-in Effects for a list of effect IDs.
    ///    effect = Type: <b>ID2D1Effect**</b> When this method returns, contains the address of a pointer to a new effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call. </td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> <tr> <td>D3DERR_OUTOFVIDEOMEMORY</td> <td>Direct3D does not have enough display memory to
    ///    perform the operation. </td> </tr> <tr> <td>D2DERR_EFFECT_IS_NOT_REGISTERED</td> <td>The specified effect is
    ///    not registered by the system.</td> </tr> <tr> <td>D2DERR_INSUFFICIENT_DEVICE_CAPABILITIES </td> <td>The
    ///    effect requires capabilities not supported by the D2D device.</td> </tr> </table>
    ///    
    HRESULT CreateEffect(const(GUID)* effectId, ID2D1Effect* effect);
    ///Creates a gradient stop collection, enabling the gradient to contain color channels with values outside of [0,1]
    ///and also enabling rendering to a high-color render target with interpolation in sRGB space.
    ///Params:
    ///    straightAlphaGradientStops = Type: <b>const D2D1_GRADIENT_STOP*</b> An array of color values and offsets.
    ///    straightAlphaGradientStopsCount = Type: <b>UINT</b> The number of elements in the <i>gradientStops</i> array.
    ///    preInterpolationSpace = Type: <b>D2D1_COLOR_SPACE</b> Specifies both the input color space and the space in which the color
    ///                            interpolation occurs.
    ///    postInterpolationSpace = Type: <b>D2D1_COLOR_SPACE</b> The color space that colors will be converted to after interpolation occurs.
    ///    bufferPrecision = Type: <b>D2D1_BUFFER_PRECISION</b> The precision of the texture used to hold interpolated values. <div
    ///                      class="alert"><b>Note</b> This method will fail if the underlying Direct3D device does not support the
    ///                      requested buffer precision. Use ID2D1DeviceContext::IsBufferPrecisionSupported to determine what is
    ///                      supported. </div> <div> </div>
    ///    extendMode = Type: <b>D2D1_EXTEND_MODE</b> Defines how colors outside of the range defined by the stop collection are
    ///                 determined.
    ///    colorInterpolationMode = Type: <b>D2D1_COLOR_INTERPOLATION_MODE</b> Defines how colors are interpolated.
    ///                             D2D1_COLOR_INTERPOLATION_MODE_PREMULTIPLIED is the default, see Remarks for more info.
    ///    gradientStopCollection1 = Type: <b>ID2D1GradientStopCollection1**</b> The new gradient stop collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateGradientStopCollection(char* straightAlphaGradientStops, uint straightAlphaGradientStopsCount, 
                                         D2D1_COLOR_SPACE preInterpolationSpace, 
                                         D2D1_COLOR_SPACE postInterpolationSpace, 
                                         D2D1_BUFFER_PRECISION bufferPrecision, D2D1_EXTEND_MODE extendMode, 
                                         D2D1_COLOR_INTERPOLATION_MODE colorInterpolationMode, 
                                         ID2D1GradientStopCollection1* gradientStopCollection1);
    HRESULT CreateImageBrush(ID2D1Image image, const(D2D1_IMAGE_BRUSH_PROPERTIES)* imageBrushProperties, 
                             const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1ImageBrush* imageBrush);
    HRESULT CreateBitmapBrush(ID2D1Bitmap bitmap, const(D2D1_BITMAP_BRUSH_PROPERTIES1)* bitmapBrushProperties, 
                              const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1BitmapBrush1* bitmapBrush);
    ///Creates a ID2D1CommandList object.
    ///Params:
    ///    commandList = Type: <b>ID2D1CommandList**</b> When this method returns, contains the address of a pointer to a command
    ///                  list.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> </table>
    ///    
    HRESULT CreateCommandList(ID2D1CommandList* commandList);
    ///Indicates whether the format is supported by the device context. The formats supported are usually determined by
    ///the underlying hardware.
    ///Params:
    ///    format = Type: <b>format</b> The DXGI format to check.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if the format is supported. Returns FALSE if the format is not supported.
    ///    
    BOOL    IsDxgiFormatSupported(DXGI_FORMAT format);
    ///Indicates whether the buffer precision is supported by the underlying Direct3D device.
    ///Params:
    ///    bufferPrecision = Type: <b>D2D1_BUFFER_PRECISION</b> The buffer precision to check.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if the buffer precision is supported. Returns FALSE if the buffer precision is
    ///    not supported.
    ///    
    BOOL    IsBufferPrecisionSupported(D2D1_BUFFER_PRECISION bufferPrecision);
    ///Gets the bounds of an image without the world transform of the context applied.
    ///Params:
    ///    image = Type: <b>ID2D1Image*</b> The image whose bounds will be calculated.
    ///    localBounds = Type: <b>D2D1_RECT_F[1]</b> When this method returns, contains a pointer to the bounds of the image in device
    ///                  independent pixels (DIPs) and in local space.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT GetImageLocalBounds(ID2D1Image image, D2D_RECT_F* localBounds);
    ///Gets the bounds of an image with the world transform of the context applied.
    ///Params:
    ///    image = Type: <b>ID2D1Image*</b> The image whose bounds will be calculated.
    ///    worldBounds = Type: <b>D2D1_RECT_F[1]</b> When this method returns, contains a pointer to the bounds of the image in device
    ///                  independent pixels (DIPs).
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT GetImageWorldBounds(ID2D1Image image, D2D_RECT_F* worldBounds);
    ///Gets the world-space bounds in DIPs of the glyph run using the device context DPI.
    ///Params:
    ///    baselineOrigin = Type: <b>D2D1_POINT_2F</b> The origin of the baseline for the glyph run.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> The glyph run to render.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The DirectWrite measuring mode that indicates how glyph metrics are used
    ///                    to measure text when it is formatted.
    ///    bounds = Type: <b>D2D1_RECT_F*</b> The bounds of the glyph run in DIPs and in world space.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT GetGlyphRunWorldBounds(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                                   DWRITE_MEASURING_MODE measuringMode, D2D_RECT_F* bounds);
    ///Gets the device associated with a device context.
    ///Params:
    ///    device = Type: <b>ID2D1Device**</b> When this method returns, contains the address of a pointer to a Direct2D device
    ///             associated with this device context.
    void    GetDevice(ID2D1Device* device);
    ///The bitmap or command list to which the Direct2D device context will now render.
    ///Params:
    ///    image = Type: <b>ID2D1Image*</b> The surface or command list to which the Direct2D device context will render.
    void    SetTarget(ID2D1Image image);
    ///Gets the target currently associated with the device context.
    ///Params:
    ///    image = Type: <b>ID2D1Image**</b> When this method returns, contains the address of a pointer to the target currently
    ///            associated with the device context.
    void    GetTarget(ID2D1Image* image);
    void    SetRenderingControls(const(D2D1_RENDERING_CONTROLS)* renderingControls);
    ///Gets the rendering controls that have been applied to the context.
    ///Params:
    ///    renderingControls = Type: <b>D2D1_RENDERING_CONTROLS*</b> When this method returns, contains a pointer to the rendering controls
    ///                        for this context.
    void    GetRenderingControls(D2D1_RENDERING_CONTROLS* renderingControls);
    ///Changes the primitive blend mode that is used for all rendering operations in the device context.
    ///Params:
    ///    primitiveBlend = Type: <b>D2D1_PRIMITIVE_BLEND</b> The primitive blend to use.
    void    SetPrimitiveBlend(D2D1_PRIMITIVE_BLEND primitiveBlend);
    ///Returns the currently set primitive blend used by the device context.
    ///Returns:
    ///    Type: <b>D2D1_PRIMITIVE_BLEND</b> The current primitive blend. The default value is
    ///    <b>D2D1_PRIMITIVE_BLEND_SOURCE_OVER</b>.
    ///    
    D2D1_PRIMITIVE_BLEND GetPrimitiveBlend();
    ///Sets what units will be used to interpret values passed into the device context.
    ///Params:
    ///    unitMode = Type: <b>D2D1_UNIT_MODE</b> An enumeration defining how passed-in units will be interpreted by the device
    ///               context.
    void    SetUnitMode(D2D1_UNIT_MODE unitMode);
    ///Gets the mode that is being used to interpret values by the device context.
    ///Returns:
    ///    Type: <b>D2D1_UNIT_MODE</b> The unit mode.
    ///    
    D2D1_UNIT_MODE GetUnitMode();
    ///Draws a series of glyphs to the device context.
    ///Params:
    ///    baselineOrigin = Type: <b>D2D1_POINT_2F</b> Origin of first glyph in the series.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> The glyphs to render.
    ///    glyphRunDescription = Type: <b>const DWRITE_GLYPH_RUN_DESCRIPTION*</b> Supplementary glyph series information.
    ///    foregroundBrush = Type: <b>ID2D1Brush*</b> The brush that defines the text color.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The measuring mode of the glyph series, used to determine the advances and
    ///                    offsets. The default value is DWRITE_MEASURING_MODE_NATURAL.
    void    DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                         const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, ID2D1Brush foregroundBrush, 
                         DWRITE_MEASURING_MODE measuringMode);
    void    DrawImage(ID2D1Image image, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, 
                      D2D1_INTERPOLATION_MODE interpolationMode, D2D1_COMPOSITE_MODE compositeMode);
    void    DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_POINT_2F)* targetOffset);
    void    DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, 
                       D2D1_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle, 
                       const(D2D_MATRIX_4X4_F)* perspectiveTransform);
    void    PushLayer(const(D2D1_LAYER_PARAMETERS1)* layerParameters, ID2D1Layer layer);
    ///This indicates that a portion of an effect's input is invalid. This method can be called many times. You can use
    ///this method to propagate invalid rectangles through an effect graph. You can query Direct2D using the
    ///GetEffectInvalidRectangles method. <div class="alert"><b>Note</b> Direct2D does not automatically use these
    ///invalid rectangles to reduce the region of an effect that is rendered.</div><div> </div>You can also use this
    ///method to invalidate caches that have accumulated while rendering effects that have the
    ///<b>D2D1_PROPERTY_CACHED</b> property set to true.
    ///Params:
    ///    effect = Type: <b>ID2D1Effect*</b> The effect to invalidate.
    ///    input = Type: <b>UINT32</b> The input index.
    ///    inputRectangle = Type: <b>const D2D1_RECT_F*</b> The rect to invalidate.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT InvalidateEffectInputRectangle(ID2D1Effect effect, uint input, const(D2D_RECT_F)* inputRectangle);
    ///Gets the number of invalid output rectangles that have accumulated on the effect.
    ///Params:
    ///    effect = Type: <b>ID2D1Effect*</b> The effect to count the invalid rectangles on.
    ///    rectangleCount = Type: <b>UINT32*</b> The returned rectangle count.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT GetEffectInvalidRectangleCount(ID2D1Effect effect, uint* rectangleCount);
    ///Gets the invalid rectangles that have accumulated since the last time the effect was drawn and EndDraw was then
    ///called on the device context.
    ///Params:
    ///    effect = Type: <b>ID2D1Effect*</b> The effect to get the invalid rectangles from.
    ///    rectangles = Type: <b>D2D1_RECT_F*</b> An array of D2D1_RECT_F structures. You must allocate this to the correct size. You
    ///                 can get the count of the invalid rectangles using the GetEffectInvalidRectangleCount method.
    ///    rectanglesCount = Type: <b>UINT32</b> The number of rectangles to get.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT GetEffectInvalidRectangles(ID2D1Effect effect, char* rectangles, uint rectanglesCount);
    ///Returns the input rectangles that are required to be supplied by the caller to produce the given output
    ///rectangle.
    ///Params:
    ///    renderEffect = Type: <b>ID2D1Effect*</b> The image whose output is being rendered.
    ///    renderImageRectangle = Type: <b>const D2D1_RECT_F*</b> The portion of the output image whose inputs are being inspected.
    ///    inputDescriptions = Type: <b>const D2D1_EFFECT_INPUT_DESCRIPTION*</b> A list of the inputs whos rectangles are being queried.
    ///    requiredInputRects = Type: <b>D2D1_RECT_F*</b> The input rectangles returned to the caller.
    ///    inputCount = Type: <b>UINT32</b> The number of inputs.
    ///Returns:
    ///    Type: <b>HRESULT</b> A failure code, this will typically only be because an effect in the chain returned some
    ///    error.
    ///    
    HRESULT GetEffectRequiredInputRectangles(ID2D1Effect renderEffect, const(D2D_RECT_F)* renderImageRectangle, 
                                             char* inputDescriptions, char* requiredInputRects, uint inputCount);
    void    FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
}

///Represents a resource domain whose objects and device contexts can be used together.
@GUID("47DD575D-AC05-4CDD-8049-9B02CD16F44C")
interface ID2D1Device : ID2D1Resource
{
    ///Creates a new device context from a Direct2D device.
    ///Params:
    ///    options = Type: <b>D2D1_DEVICE_CONTEXT_OPTIONS</b> The options to be applied to the created device context.
    ///    deviceContext = Type: <b>const ID2D1DeviceContext**</b> When this method returns, contains the address of a pointer to the
    ///                    new device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext* deviceContext);
    HRESULT CreatePrintControl(IWICImagingFactory wicFactory, IPrintDocumentPackageTarget documentTarget, 
                               const(D2D1_PRINT_CONTROL_PROPERTIES)* printControlProperties, 
                               ID2D1PrintControl* printControl);
    ///Sets the maximum amount of texture memory Direct2D accumulates before it purges the image caches and cached
    ///texture allocations.
    ///Params:
    ///    maximumInBytes = Type: <b>UINT64</b> The new maximum texture memory in bytes.
    void    SetMaximumTextureMemory(ulong maximumInBytes);
    ///Sets the maximum amount of texture memory Direct2D accumulates before it purges the image caches and cached
    ///texture allocations.
    ///Returns:
    ///    Type: <b>UINT64</b> The maximum amount of texture memory in bytes.
    ///    
    ulong   GetMaximumTextureMemory();
    ///Clears all of the rendering resources used by Direct2D.
    ///Params:
    ///    millisecondsSinceUse = Type: <b>UINT</b> Discards only resources that haven't been used for greater than the specified time in
    ///                           milliseconds. The default is 0 milliseconds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. Otherwise, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    void    ClearResources(uint millisecondsSinceUse);
}

///Creates Direct2D resources.
@GUID("BB12D362-DAEE-4B9A-AA1D-14BA401CFA1F")
interface ID2D1Factory1 : ID2D1Factory
{
    ///Creates a ID2D1Device object.
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice*</b> The IDXGIDevice object used when creating the ID2D1Device.
    ///    d2dDevice = Type: <b>ID2D1Device**</b> The requested ID2D1Device object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> <tr> <td>D3DERR_OUTOFVIDEOMEMORY</td> <td>Direct3D does not have enough
    ///    display memory to perform the operation.</td> </tr> </table>
    ///    
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device* d2dDevice);
    HRESULT CreateStrokeStyle(const(D2D1_STROKE_STYLE_PROPERTIES1)* strokeStyleProperties, char* dashes, 
                              uint dashesCount, ID2D1StrokeStyle1* strokeStyle);
    ///Creates an ID2D1PathGeometry1 object.
    ///Params:
    ///    pathGeometry = Type: <b>const **</b> When this method returns, contains the address of a pointer to the newly created path
    ///                   geometry.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> </table>
    ///    
    HRESULT CreatePathGeometry(ID2D1PathGeometry1* pathGeometry);
    HRESULT CreateDrawingStateBlock(const(D2D1_DRAWING_STATE_DESCRIPTION1)* drawingStateDescription, 
                                    IDWriteRenderingParams textRenderingParams, 
                                    ID2D1DrawingStateBlock1* drawingStateBlock);
    ///Creates a new ID2D1GdiMetafile object that you can use to replay metafile content.
    ///Params:
    ///    metafileStream = Type: <b>IStream*</b> A stream object that has the metafile data.
    ///    metafile = Type: <b>ID2D1GdiMetafile**</b> The address of the newly created GDI metafile object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateGdiMetafile(IStream metafileStream, ID2D1GdiMetafile* metafile);
    ///Registers an effect within the factory instance with the property XML specified as a stream.
    ///Params:
    ///    classId = Type: <b>REFCLSID</b> The identifier of the effect to be registered.
    ///    propertyXml = Type: <b>IStream</b> A list of the effect properties, types, and metadata.
    ///    bindings = Type: <b>const D2D1_PROPERTY_BINDING*</b> An array of properties and methods. This binds a property by name
    ///               to a particular method implemented by the effect author to handle the property. The name must be found in the
    ///               corresponding <i>propertyXml</i>.
    ///    bindingsCount = Type: <b>UINT32</b> The number of bindings in the binding array.
    ///    effectFactory = Type: <b>PD2D1_EFFECT_FACTORY</b> The static factory that is used to create the corresponding effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call. </td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to
    ///    the returning function.</td> </tr> </table>
    ///    
    HRESULT RegisterEffectFromStream(const(GUID)* classId, IStream propertyXml, char* bindings, uint bindingsCount, 
                                     const(ptrdiff_t) effectFactory);
    ///Registers an effect within the factory instance with the property XML specified as a string.
    ///Params:
    ///    classId = Type: <b>REFCLSID</b> The identifier of the effect to be registered.
    ///    propertyXml = Type: <b>PCWSTR</b> A list of the effect properties, types, and metadata.
    ///    bindings = Type: <b>const D2D1_PROPERTY_BINDING*</b> An array of properties and methods. This binds a property by name
    ///               to a particular method implemented by the effect author to handle the property. The name must be found in the
    ///               corresponding <i>propertyXml</i>.
    ///    bindingsCount = Type: <b>UINT32</b> The number of bindings in the binding array.
    ///    effectFactory = Type: <b>PD2D1_EFFECT_FACTORY</b> The static factory that is used to create the corresponding effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call. </td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to
    ///    the returning function.</td> </tr> </table>
    ///    
    HRESULT RegisterEffectFromString(const(GUID)* classId, const(wchar)* propertyXml, char* bindings, 
                                     uint bindingsCount, const(ptrdiff_t) effectFactory);
    ///Unregisters an effect within the factory instance that corresponds to the <i>classId</i> provided.
    ///Params:
    ///    classId = Type: <b>REFCLSID</b> The identifier of the effect to be unregistered.
    ///Returns:
    ///    Type: <b>HRESULT</b> D2DERR_EFFECT_IS_NOT_REGISTERED if the effect is not registered, S_OK otherwise.
    ///    
    HRESULT UnregisterEffect(const(GUID)* classId);
    ///Returns the class IDs of the currently registered effects and global effects on this factory.
    ///Params:
    ///    effects = Type: <b>CLSID*</b> When this method returns, contains an array of effects. <b>NULL</b> if no effects are
    ///              retrieved.
    ///    effectsCount = Type: <b>UINT32</b> The capacity of the <i>effects</i> array.
    ///    effectsReturned = Type: <b>UINT32*</b> When this method returns, contains the number of effects copied into <i>effects</i>.
    ///    effectsRegistered = Type: <b>UINT32*</b> When this method returns, contains the number of effects currently registered in the
    ///                        system.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</td>
    ///    <td><i>effectsRegistered</i> is larger than <i>effectCount</i>.</td> </tr> </table>
    ///    
    HRESULT GetRegisteredEffects(char* effects, uint effectsCount, uint* effectsReturned, uint* effectsRegistered);
    ///Retrieves the properties of an effect.
    ///Params:
    ///    effectId = Type: <b>REFCLSID</b> The ID of the effect to retrieve properties from.
    ///    properties = Type: <b>ID2D1Properties**</b> When this method returns, contains the address of a pointer to the property
    ///                 interface that can be used to query the metadata of the effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>D2DERR_EFFECT_IS_NOT_REGISTERED</td> <td>The requested effect
    ///    could not be found.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient memory
    ///    to complete the call.</td> </tr> </table>
    ///    
    HRESULT GetEffectProperties(const(GUID)* effectId, ID2D1Properties* properties);
}

///A locking mechanism from a Direct2D factory that Direct2D uses to control exclusive resource access in an app that is
///uses multiple threads.
@GUID("31E6E7BC-E0FF-4D46-8C64-A0A8C41C15D3")
interface ID2D1Multithread : IUnknown
{
    ///Returns whether the Direct2D factory was created with the D2D1_FACTORY_TYPE_MULTI_THREADED flag.
    ///Returns:
    ///    Returns true if the Direct2D factory was created as multi-threaded, or false if it was created as
    ///    single-threaded.
    ///    
    BOOL GetMultithreadProtected();
    ///Enters the Direct2D API critical section, if it exists.
    void Enter();
    ///Leaves the Direct2D API critical section, if it exists.
    void Leave();
}

///Defines a mappable single-dimensional vertex buffer.
@GUID("9B8B1336-00A5-4668-92B7-CED5D8BF9B7B")
interface ID2D1VertexBuffer : IUnknown
{
    ///Maps the provided data into user memory.
    ///Params:
    ///    data = Type: <b>const BYTE**</b> When this method returns, contains the address of a pointer to the available
    ///           buffer.
    ///    bufferSize = Type: <b>UINT32</b> The desired size of the buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the returning
    ///    function.</td> </tr> <tr> <td>D3DERR_DEVICELOST</td> <td>The device has been lost but cannot be reset at this
    ///    time.</td> </tr> </table>
    ///    
    HRESULT Map(ubyte** data, uint bufferSize);
    ///Unmaps the vertex buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td>D2DERR_WRONG_STATE</td> <td>The object was not in the correct state to process
    ///    the method.</td> </tr> </table>
    ///    
    HRESULT Unmap();
}

///Tracks a transform-created resource texture.
@GUID("688D15C3-02B0-438D-B13A-D1B44C32C39A")
interface ID2D1ResourceTexture : IUnknown
{
    ///Updates the specific resource texture inside the specific range or box using the supplied data.
    ///Params:
    ///    minimumExtents = Type: <b>const UINT32*</b> The "left" extent of the updates if specified; if <b>NULL</b>, the entire texture
    ///                     is updated.
    ///    maximimumExtents = Type: <b>const UINT32*</b> The "right" extent of the updates if specified; if <b>NULL</b>, the entire texture
    ///                       is updated.
    ///    strides = Type: <b>const UINT32*</b> The stride to advance through the input data, according to dimension.
    ///    dimensions = Type: <b>UINT32</b> The number of dimensions in the resource texture. This must match the number used to load
    ///                 the texture.
    ///    data = Type: <b>const BYTE*</b> The data to be placed into the resource texture.
    ///    dataCount = Type: <b>UINT32</b> The size of the data buffer to be used to update the resource texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td> E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient memory to
    ///    complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the returning
    ///    function.</td> </tr> </table>
    ///    
    HRESULT Update(char* minimumExtents, char* maximimumExtents, char* strides, uint dimensions, char* data, 
                   uint dataCount);
}

///Describes the render information common to all of the various transform implementations.
@GUID("519AE1BD-D19A-420D-B849-364F594776B7")
interface ID2D1RenderInfo : IUnknown
{
    ///Sets how a specific input to the transform should be handled by the renderer in terms of sampling.
    ///Params:
    ///    inputIndex = Type: <b>UINT32</b> The index of the input that will have the input description applied.
    ///    inputDescription = Type: <b>D2D1_INPUT_DESCRIPTION</b> The description of the input to be applied to the transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the returning
    ///    function.</td> </tr> </table>
    ///    
    HRESULT SetInputDescription(uint inputIndex, D2D1_INPUT_DESCRIPTION inputDescription);
    ///Allows a caller to control the output precision and channel-depth of the transform in which the render
    ///information is encapsulated.
    ///Params:
    ///    bufferPrecision = Type: <b>D2D1_BUFFER_PRECISION</b> The type of buffer that should be used as an output from this transform.
    ///    channelDepth = Type: <b>D2D1_CHANNEL_DEPTH</b> The number of channels that will be used on the output buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetOutputBuffer(D2D1_BUFFER_PRECISION bufferPrecision, D2D1_CHANNEL_DEPTH channelDepth);
    ///Specifies that the output of the transform in which the render information is encapsulated is or is not cached.
    ///Params:
    ///    isCached = Type: <b>BOOL</b> <b>TRUE</b> if the output of the transform is cached; otherwise, <b>FALSE</b>.
    void    SetCached(BOOL isCached);
    ///Provides an estimated hint of shader execution cost to D2D.
    ///Params:
    ///    instructionCount = Type: <b>UINT32</b> An approximate instruction count of the associated shader.
    void    SetInstructionCountHint(uint instructionCount);
}

///This interface is used to describe a GPU rendering pass on a vertex or pixel shader. It is passed to
///ID2D1DrawTransform.
@GUID("693CE632-7F2F-45DE-93FE-18D88B37AA21")
interface ID2D1DrawInfo : ID2D1RenderInfo
{
    ///Sets the constant buffer for this transform's pixel shader.
    ///Params:
    ///    buffer = Type: <b>const BYTE*</b> The data applied to the constant buffer.
    ///    bufferCount = Type: <b>UINT32</b> The number of bytes of data in the constant buffer
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetPixelShaderConstantBuffer(char* buffer, uint bufferCount);
    ///Sets the resource texture corresponding to the given shader texture index.
    ///Params:
    ///    textureIndex = Type: <b>UINT32</b> The index of the texture to be bound to the pixel shader.
    ///    resourceTexture = Type: <b>ID2D1ResourceTexture*</b> The created resource texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetResourceTexture(uint textureIndex, ID2D1ResourceTexture resourceTexture);
    ///Sets the constant buffer for this transform's vertex shader.
    ///Params:
    ///    buffer = Type: <b>const BYTE*</b> The data applied to the constant buffer
    ///    bufferCount = Type: <b>UINT32</b> The number of bytes of data in the constant buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetVertexShaderConstantBuffer(char* buffer, uint bufferCount);
    ///Set the shader instructions for this transform.
    ///Params:
    ///    shaderId = Type: <b>REFGUID</b> The resource id for the shader.
    ///    pixelOptions = Type: <b>D2D1_PIXEL_OPTIONS</b> Additional information provided to the renderer to indicate the operations
    ///                   the pixel shader does.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetPixelShader(const(GUID)* shaderId, D2D1_PIXEL_OPTIONS pixelOptions);
    ///Sets a vertex buffer, a corresponding vertex shader, and options to control how the vertices are to be handled by
    ///the Direct2D context.
    ///Params:
    ///    vertexBuffer = Type: <b>ID2D1VertexBuffer*</b> The vertex buffer, if this is cleared, the default vertex shader and mapping
    ///                   to the transform rectangles will be used.
    ///    vertexOptions = Type: <b>D2D1_VERTEX_OPTIONS</b> Options that influence how the renderer will interact with the vertex
    ///                    shader.
    ///    blendDescription = Type: <b>const D2D1_BLEND_DESCRIPTION*</b> How the vertices will be blended with the output texture.
    ///    vertexRange = Type: <b>const D2D1_VERTEX_RANGE*</b> The set of vertices to use from the buffer.
    ///    vertexShader = Type: <b>GUID*</b> The GUID of the vertex shader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetVertexProcessing(ID2D1VertexBuffer vertexBuffer, D2D1_VERTEX_OPTIONS vertexOptions, 
                                const(D2D1_BLEND_DESCRIPTION)* blendDescription, 
                                const(D2D1_VERTEX_RANGE)* vertexRange, const(GUID)* vertexShader);
}

///Enables specification of information for a compute-shader rendering pass.
@GUID("5598B14B-9FD7-48B7-9BDB-8F0964EB38BC")
interface ID2D1ComputeInfo : ID2D1RenderInfo
{
    ///Establishes or changes the constant buffer data for this transform.
    ///Params:
    ///    buffer = Type: <b>const BYTE*</b> The data applied to the constant buffer.
    ///    bufferCount = Type: <b>UINT32</b> The number of bytes of data in the constant buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetComputeShaderConstantBuffer(char* buffer, uint bufferCount);
    ///Sets the compute shader to the given shader resource. The resource must be loaded before this call is made.
    ///Params:
    ///    shaderId = Type: <b>REFGUID</b> The GUID of the shader.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT SetComputeShader(const(GUID)* shaderId);
    ///Sets the resource texture corresponding to the given shader texture index to the given texture resource. The
    ///texture resource must already have been loaded with ID2D1EffectContext::CreateResourceTexture method. This call
    ///will fail if the specified index overlaps with any input. The input indices always precede the texture LUT
    ///indices.
    ///Params:
    ///    textureIndex = Type: <b>UINT32</b> The index to set the resource texture on.
    ///    resourceTexture = Type: <b>ID2D1ResourceTexture*</b> The resource texture object to set on the shader texture index.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT SetResourceTexture(uint textureIndex, ID2D1ResourceTexture resourceTexture);
}

///Describes a node in a transform topology.
@GUID("B2EFE1E7-729F-4102-949F-505FA21BF666")
interface ID2D1TransformNode : IUnknown
{
    ///Gets the number of inputs to the transform node.
    ///Returns:
    ///    Type: <b>UINT32</b> This method returns the number of inputs to this transform node.
    ///    
    uint GetInputCount();
}

///Represents a graph of transform nodes.
@GUID("13D29038-C3E6-4034-9081-13B53A417992")
interface ID2D1TransformGraph : IUnknown
{
    ///Returns the number of inputs to the transform graph.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of inputs to this transform graph.
    ///    
    uint    GetInputCount();
    ///Sets a single transform node as being equivalent to the whole graph.
    ///Params:
    ///    node = Type: <b>ID2D1TransformNode*</b> The node to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> </table>
    ///    
    HRESULT SetSingleTransformNode(ID2D1TransformNode node);
    ///Adds the provided node to the transform graph.
    ///Params:
    ///    node = Type: <b>ID2D1TransformNode*</b> The node that will be added to the transform graph.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> </table>
    ///    
    HRESULT AddNode(ID2D1TransformNode node);
    ///Removes the provided node from the transform graph.
    ///Params:
    ///    node = Type: <b>ID2D1TransformNode*</b> The node that will be removed from the transform graph.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred</td> </tr> <tr> <td>D2DERR_NOT_FOUND = (HRESULT_FROM_WIN32(ERROR_NOT_FOUND))</td>
    ///    <td>Direct2D could not locate the specified node.</td> </tr> </table>
    ///    
    HRESULT RemoveNode(ID2D1TransformNode node);
    ///Sets the output node for the transform graph.
    ///Params:
    ///    node = Type: <b>ID2D1TransformNode*</b> The node that will be considered the output of the transform node.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred</td> </tr> <tr> <td>D2DERR_NOT_FOUND = (HRESULT_FROM_WIN32(ERROR_NOT_FOUND))</td>
    ///    <td>Direct2D could not locate the specified node.</td> </tr> </table>
    ///    
    HRESULT SetOutputNode(ID2D1TransformNode node);
    ///Connects two nodes inside the transform graph.
    ///Params:
    ///    fromNode = Type: <b>ID2D1TransformNode*</b> The node from which the connection will be made.
    ///    toNode = Type: <b>ID2D1TransformNode*</b> The node to which the connection will be made.
    ///    toNodeInputIndex = Type: <b>UINT32</b> The node input that will be connected.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred</td> </tr> <tr> <td>D2DERR_NOT_FOUND = (HRESULT_FROM_WIN32(ERROR_NOT_FOUND))</td>
    ///    <td>Direct2D could not locate the specified node.</td> </tr> </table>
    ///    
    HRESULT ConnectNode(ID2D1TransformNode fromNode, ID2D1TransformNode toNode, uint toNodeInputIndex);
    ///Connects a transform node inside the graph to the corresponding effect input of the encapsulating effect.
    ///Params:
    ///    toEffectInputIndex = Type: <b>UINT32</b> The effect input to which the transform node will be bound.
    ///    node = Type: <b>ID2D1TransformNode*</b> The node to which the connection will be made.
    ///    toNodeInputIndex = Type: <b>UINT32</b> The node input that will be connected.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred</td> </tr> <tr> <td>D2DERR_NOT_FOUND = (HRESULT_FROM_WIN32(ERROR_NOT_FOUND))</td>
    ///    <td>Direct2D could not locate the specified node.</td> </tr> </table>
    ///    
    HRESULT ConnectToEffectInput(uint toEffectInputIndex, ID2D1TransformNode node, uint toNodeInputIndex);
    ///Clears the transform nodes and all connections from the transform graph.
    void    Clear();
    ///Uses the specified input as the effect output.
    ///Params:
    ///    effectInputIndex = The index of the input to the effect.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error occurred</td>
    ///    </tr> <tr> <td>D2DERR_NOT_FOUND = (HRESULT_FROM_WIN32(ERROR_NOT_FOUND))</td> <td>Direct2D could not locate
    ///    the specified node.</td> </tr> </table>
    ///    
    HRESULT SetPassthroughGraph(uint effectInputIndex);
}

///Represents the base interface for all of the transforms implemented by the transform author.
@GUID("EF1A287D-342A-4F76-8FDB-DA0D6EA9F92B")
interface ID2D1Transform : ID2D1TransformNode
{
    ///Allows a transform to state how it would map a rectangle requested on its output to a set of sample rectangles on
    ///its input.
    ///Params:
    ///    outputRect = Type: <b>const D2D1_RECT_L*</b> The output rectangle from which the inputs must be mapped.
    ///    inputRects = Type: <b>D2D1_RECT_L*</b> The corresponding set of inputs. The inputs will directly correspond to the
    ///                 transform inputs.
    ///    inputRectsCount = Type: <b>UINT32</b> The number of inputs specified. Direct2D guarantees that this is equal to the number of
    ///                      inputs specified on the transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT MapOutputRectToInputRects(const(RECT)* outputRect, char* inputRects, uint inputRectsCount);
    ///Performs the inverse mapping to MapOutputRectToInputRects.
    ///Params:
    ///    inputRects = Type: <b>const D2D1_RECT_L*</b> An array of input rectangles to be mapped to the output rectangle. The
    ///                 <i>inputRects</i> parameter is always equal to the input bounds.
    ///    inputOpaqueSubRects = Type: <b>const D2D1_RECT_L*</b> An array of input rectangles to be mapped to the opaque output rectangle.
    ///    inputRectCount = Type: <b>UINT32</b> The number of inputs specified. The implementation guarantees that this is equal to the
    ///                     number of inputs specified on the transform.
    ///    outputRect = Type: <b>D2D1_RECT_L*</b> The output rectangle that maps to the corresponding input rectangle.
    ///    outputOpaqueSubRect = Type: <b>D2D1_RECT_L*</b> The output rectangle that maps to the corresponding opaque input rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT MapInputRectsToOutputRect(char* inputRects, char* inputOpaqueSubRects, uint inputRectCount, 
                                      RECT* outputRect, RECT* outputOpaqueSubRect);
    ///Sets the input rectangles for this rendering pass into the transform.
    ///Params:
    ///    inputIndex = Type: <b>UINT32</b> The index of the input rectangle.
    ///    invalidInputRect = Type: <b>D2D1_RECT_L</b> The invalid input rectangle.
    ///    invalidOutputRect = Type: <b>D2D1_RECT_L*</b> The output rectangle to which the input rectangle must be mapped.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT MapInvalidRect(uint inputIndex, RECT invalidInputRect, RECT* invalidOutputRect);
}

///A specialized implementation of the Shantzis calculations to a transform implemented on the GPU. These calculations
///are described in the paper A model for efficient and flexible image computing. The information required to specify a
///“Pass” in the rendering algorithm on a Pixel Shader is passed to the implementation through the SetDrawInfo
///method.
@GUID("36BFDCB6-9739-435D-A30D-A653BEFF6A6F")
interface ID2D1DrawTransform : ID2D1Transform
{
    ///Provides the GPU render info interface to the transform implementation.
    ///Params:
    ///    drawInfo = Type: <b>ID2D1DrawInfo*</b> The interface supplied back to the calling method to allow it to specify the GPU
    ///               based transform pass.
    ///Returns:
    ///    Type: <b>HRESULT</b> Any HRESULT value can be returned when implementing this method. A failure will be
    ///    returned from the corresponding ID2D1DeviceContext::EndDraw call.
    ///    
    HRESULT SetDrawInfo(ID2D1DrawInfo drawInfo);
}

///Defines a transform that uses a compute shader.
@GUID("0D85573C-01E3-4F7D-BFD9-0D60608BF3C3")
interface ID2D1ComputeTransform : ID2D1Transform
{
    ///Sets the render information used to specify the compute shader pass.
    ///Params:
    ///    computeInfo = Type: <b>ID2D1ComputeInfo*</b> The render information object to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetComputeInfo(ID2D1ComputeInfo computeInfo);
    ///This method allows a compute-shader–based transform to select the number of thread groups to execute based on
    ///the number of output pixels it needs to fill.
    ///Params:
    ///    outputRect = Type: <b>const D2D1_RECT_L*</b> The output rectangle that will be filled by the compute transform.
    ///    dimensionX = Type: <b>UINT32*</b> The number of threads in the x dimension.
    ///    dimensionY = Type: <b>UINT32*</b> The number of threads in the y dimension.
    ///    dimensionZ = Type: <b>UINT32*</b> The number of threads in the z dimension.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT CalculateThreadgroups(const(RECT)* outputRect, uint* dimensionX, uint* dimensionY, uint* dimensionZ);
}

///Supplies data to an analysis effect.
@GUID("0359DC30-95E6-4568-9055-27720D130E93")
interface ID2D1AnalysisTransform : IUnknown
{
    ///Supplies the analysis data to an analysis transform.
    ///Params:
    ///    analysisData = Type: <b>const BYTE*</b> The data that the transform will analyze.
    ///    analysisDataCount = Type: <b>UINT</b> The size of the analysis data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT ProcessAnalysisResults(char* analysisData, uint analysisDataCount);
}

///Represents a CPU-based rasterization stage in the transform pipeline graph.
@GUID("DB1800DD-0C34-4CF9-BE90-31CC0A5653E1")
interface ID2D1SourceTransform : ID2D1Transform
{
    ///Sets the render information for the transform.
    ///Params:
    ///    renderInfo = Type: <b>ID2D1RenderInfo*</b> The interface supplied to the transform to allow specifying the CPU based
    ///                 transform pass.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetRenderInfo(ID2D1RenderInfo renderInfo);
    ///Draws the transform to the graphics processing unit (GPU)–based Direct2D pipeline.
    ///Params:
    ///    target = Type: <b>ID2D1Bitmap1*</b> The target to which the transform should be written.
    ///    drawRect = Type: <b>const D2D1_RECT_L*</b> The area within the source from which the image should be drawn.
    ///    targetOrigin = Type: <b>D2D1_POINT_2U</b> The origin within the target bitmap to which the source data should be drawn.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT Draw(ID2D1Bitmap1 target, const(RECT)* drawRect, D2D_POINT_2U targetOrigin);
}

///Represents the set of transforms implemented by the effect-rendering system, which provides fixed-functionality.
@GUID("1A799D8A-69F7-4E4C-9FED-437CCC6684CC")
interface ID2D1ConcreteTransform : ID2D1TransformNode
{
    ///Sets the properties of the output buffer of the specified transform node.
    ///Params:
    ///    bufferPrecision = Type: <b>D2D1_BUFFER_PRECISION</b> The number of bits and the type of the output buffer.
    ///    channelDepth = Type: <b>D2D1_CHANNEL_DEPTH</b> The number of channels in the output buffer (1 or 4).
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>One or more arguments are not valid</td> </tr> </table>
    ///    
    HRESULT SetOutputBuffer(D2D1_BUFFER_PRECISION bufferPrecision, D2D1_CHANNEL_DEPTH channelDepth);
    ///Sets whether the output of the specified transform is cached.
    ///Params:
    ///    isCached = Type: <b>BOOL</b> <b>TRUE</b> if the output should be cached; otherwise, <b>FALSE</b>.
    void    SetCached(BOOL isCached);
}

///Provides methods to allow a blend operation to be inserted into a transform graph. The image output of the blend
///transform is the same as rendering an image effect graph with these steps: <ul> <li>Copy the first input to the
///destination image.</li> <li>Render the next input on top using the blend description.</li> <li>Continue for each
///additional input.</li> </ul>
@GUID("63AC0B32-BA44-450F-8806-7F4CA1FF2F1B")
interface ID2D1BlendTransform : ID2D1ConcreteTransform
{
    ///Changes the blend description of the corresponding blend transform object.
    ///Params:
    ///    description = Type: <b>const D2D1_BLEND_DESCRIPTION*</b> The new blend description specified for the blend transform.
    void SetDescription(const(D2D1_BLEND_DESCRIPTION)* description);
    ///Gets the blend description of the corresponding blend transform object.
    ///Params:
    ///    description = Type: <b>D2D1_BLEND_DESCRIPTION*</b> When this method returns, contains the blend description specified for
    ///                  the blend transform.
    void GetDescription(D2D1_BLEND_DESCRIPTION* description);
}

///Extends the input rectangle to infinity using the specified extend modes.
@GUID("4998735C-3A19-473C-9781-656847E3A347")
interface ID2D1BorderTransform : ID2D1ConcreteTransform
{
    ///Sets the extend mode in the x direction.
    ///Params:
    ///    extendMode = Type: <b>D2D1_EXTEND_MODE</b> The extend mode in the x direction.
    void SetExtendModeX(D2D1_EXTEND_MODE extendMode);
    ///Sets the extend mode in the y direction.
    ///Params:
    ///    extendMode = Type: <b>D2D1_EXTEND_MODE</b> The extend mode in the y direction.
    void SetExtendModeY(D2D1_EXTEND_MODE extendMode);
    ///Gets the extend mode in the x direction.
    ///Returns:
    ///    Type: <b>D2D1_EXTEND_MODE</b> This method returns the extend mode in the x direction.
    ///    
    D2D1_EXTEND_MODE GetExtendModeX();
    ///Gets the extend mode in the y direction.
    ///Returns:
    ///    Type: <b>D2D1_EXTEND_MODE</b> This method returns the extend mode in the y direction.
    ///    
    D2D1_EXTEND_MODE GetExtendModeY();
}

///Instructs the effect-rendering system to offset an input bitmap without inserting a rendering pass.
@GUID("3FE6ADEA-7643-4F53-BD14-A0CE63F24042")
interface ID2D1OffsetTransform : ID2D1TransformNode
{
    ///Sets the offset in the current offset transform.
    ///Params:
    ///    offset = Type: <b>D2D1_POINT_2L</b> The new offset to apply to the offset transform.
    void  SetOffset(POINT offset);
    ///Gets the offset currently in the offset transform.
    ///Returns:
    ///    Type: <b>D2D1_POINT_2L</b> The current transform offset.
    ///    
    POINT GetOffset();
}

///A support transform for effects to modify the output rectangle of the previous effect or bitmap.
@GUID("90F732E2-5092-4606-A819-8651970BACCD")
interface ID2D1BoundsAdjustmentTransform : ID2D1TransformNode
{
    ///This sets the output bounds for the support transform.
    ///Params:
    ///    outputBounds = Type: <b>const D2D1_RECT_L*</b> The output bounds.
    void SetOutputBounds(const(RECT)* outputBounds);
    ///Returns the output rectangle of the support transform.
    ///Params:
    ///    outputBounds = Type: <b>D2D1_RECT_L*</b> The output bounds.
    void GetOutputBounds(RECT* outputBounds);
}

///Allows a custom effect's interface and behavior to be specified by the effect author.
@GUID("A248FD3F-3E6C-4E63-9F03-7F68ECC91DB9")
interface ID2D1EffectImpl : IUnknown
{
    ///The effect can use this method to do one time initialization tasks. If this method is not needed, the method can
    ///just return <b>S_OK</b>.
    ///Params:
    ///    effectContext = Type: <b>ID2D1EffectContext*</b> An internal context interface that creates and returns effect
    ///                    author–centric types.
    ///    transformGraph = Type: <b>ID2D1TransformGraph*</b> The effect can populate the transform graph with a topology and can update
    ///                     it later.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT Initialize(ID2D1EffectContext effectContext, ID2D1TransformGraph transformGraph);
    ///Prepares an effect for the rendering process.
    ///Params:
    ///    changeType = Type: <b>D2D1_CHANGE_TYPE</b> Indicates the type of change the effect should expect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT PrepareForRender(D2D1_CHANGE_TYPE changeType);
    ///The renderer calls this method to provide the effect implementation with a way to specify its transform graph and
    ///transform graph changes. The renderer calls this method when: <ul> <li>When the effect is first initialized.</li>
    ///<li>If the number of inputs to the effect changes.</li> </ul>
    ///Params:
    ///    transformGraph = Type: <b>ID2D1TransformGraph*</b> The graph to which the effect describes its transform topology through the
    ///                     SetDescription call.
    ///Returns:
    ///    Type: <b>HRESULT</b> An error that prevents the effect from being initialized if called as part of the
    ///    CreateEffect call. If the effect fails a subsequent SetGraph call: <ul> <li>The error will be returned from
    ///    the property method that caused the number of inputs to the effect to change. </li> <li>The effect object
    ///    will be placed into an error state, if subsequently used to render, the context will be placed into a
    ///    temporary error state, that particular effect will fail to render and the failure will be returned on the
    ///    next EndDraw or Flush call.</li> </ul>
    ///    
    HRESULT SetGraph(ID2D1TransformGraph transformGraph);
}

///Provides factory methods and other state management for effect and transform authors.
@GUID("3D9F916B-27DC-4AD7-B4F1-64945340F563")
interface ID2D1EffectContext : IUnknown
{
    ///Gets the unit mapping that an effect will use for properties that could be in either dots per inch (dpi) or
    ///pixels.
    ///Params:
    ///    dpiX = Type: <b>FLOAT*</b> The dpi on the x-axis.
    ///    dpiY = Type: <b>FLOAT*</b> The dpi on the y-axis.
    void    GetDpi(float* dpiX, float* dpiY);
    ///Creates a Direct2D effect for the specified class ID. This is the same as ID2D1DeviceContext::CreateEffect so
    ///custom effects can create other effects and wrap them in a transform.
    ///Params:
    ///    effectId = Type: <b>REFCLSID</b> The built-in or registered effect ID to create the effect. See Built-in Effects for a
    ///               list of effect IDs.
    ///    effect = Type: <b>ID2D1Effect**</b> When this method returns, contains the address of a pointer to the effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient memory to
    ///    complete the call. </td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the method.</td>
    ///    </tr> <tr> <td>D3DERR_OUTOFVIDEOMEMORY</td> <td>Direct3D does not have enough display memory to perform the
    ///    operation. </td> </tr> <tr> <td>D2DERR_EFFECT_IS_NOT_REGISTERED</td> <td>The specified effect is not
    ///    registered by the system.</td> </tr> </table>
    ///    
    HRESULT CreateEffect(const(GUID)* effectId, ID2D1Effect* effect);
    ///This indicates the maximum feature level from the provided list which is supported by the device. If none of the
    ///provided levels are supported, then this API fails with D2DERR_INSUFFICIENT_DEVICE_CAPABILITIES.
    ///Params:
    ///    featureLevels = Type: <b>const D3D_FEATURE_LEVEL*</b> The feature levels provided by the application.
    ///    featureLevelsCount = Type: <b>UINT32</b> The count of feature levels provided by the application
    ///    maximumSupportedFeatureLevel = Type: <b>D3D_FEATURE_LEVEL*</b> The maximum feature level from the <i>featureLevels</i> list which is
    ///                                   supported by the D2D device.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> <tr> <td>D2DERR_INSUFFICIENT_DEVICE_CAPABILITIES</td> <td>None of the provided
    ///    levels are supported.</td> </tr> </table>
    ///    
    HRESULT GetMaximumSupportedFeatureLevel(char* featureLevels, uint featureLevelsCount, 
                                            D3D_FEATURE_LEVEL* maximumSupportedFeatureLevel);
    ///Wraps an effect graph into a single transform node and then inserted into a transform graph. This allows an
    ///effect to aggregate other effects. This will typically be done in order to allow the effect properties to be
    ///re-expressed with a different contract, or to allow different components to integrate each-other’s effects.
    ///Params:
    ///    effect = Type: <b>ID2D1Effect*</b> The effect to be wrapped in a transform node.
    ///    transformNode = Type: <b>ID2D1TransformNode**</b> The returned transform node that encapsulates the effect graph.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CreateTransformNodeFromEffect(ID2D1Effect effect, ID2D1TransformNode* transformNode);
    ///This creates a blend transform that can be inserted into a transform graph.
    ///Params:
    ///    numInputs = Type: <b>UINT32</b> The number of inputs to the blend transform.
    ///    blendDescription = Type: <b>const D2D1_BLEND_DESCRIPTION*</b> Describes the blend transform that is to be created.
    ///    transform = Type: <b>ID2D1BlendTransform**</b> The returned blend transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CreateBlendTransform(uint numInputs, const(D2D1_BLEND_DESCRIPTION)* blendDescription, 
                                 ID2D1BlendTransform* transform);
    ///Creates a transform that extends its input infinitely in every direction based on the passed in extend mode.
    ///Params:
    ///    extendModeX = Type: <b>D2D1_EXTEND_MODE</b> The extend mode in the X-axis direction.
    ///    extendModeY = Type: <b>D2D1_EXTEND_MODE</b> The extend mode in the Y-axis direction.
    ///    transform = Type: <b>ID2D1BorderTransform**</b> The returned transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CreateBorderTransform(D2D1_EXTEND_MODE extendModeX, D2D1_EXTEND_MODE extendModeY, 
                                  ID2D1BorderTransform* transform);
    ///Creates and returns an offset transform.
    ///Params:
    ///    offset = Type: <b>D2D1_POINT_2L</b> The offset amount.
    ///    transform = Type: <b>ID2D1OffsetTransform**</b> When this method returns, contains the address of a pointer to an offset
    ///                transform object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CreateOffsetTransform(POINT offset, ID2D1OffsetTransform* transform);
    ///Creates and returns a bounds adjustment transform.
    ///Params:
    ///    outputRectangle = Type: <b>const D2D1_RECT_L*</b> The initial output rectangle for the bounds adjustment transform.
    ///    transform = Type: <b>ID2D1BoundsAdjustmentTransform**</b> The returned bounds adjustment transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CreateBoundsAdjustmentTransform(const(RECT)* outputRectangle, 
                                            ID2D1BoundsAdjustmentTransform* transform);
    ///Loads the given shader by its unique ID. Loading the shader multiple times is ignored. When the shader is loaded
    ///it is also handed to the driver to JIT, if it hasn’t been already.
    ///Params:
    ///    shaderId = Type: <b>REFGUID</b> The unique id that identifies the shader.
    ///    shaderBuffer = Type: <b>const BYTE*</b> The buffer that contains the shader to register.
    ///    shaderBufferCount = Type: <b>UINT32</b> The size of the shader buffer in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT LoadPixelShader(const(GUID)* shaderId, char* shaderBuffer, uint shaderBufferCount);
    ///Loads the given shader by its unique ID. Loading the shader multiple times is ignored. When the shader is loaded
    ///it is also handed to the driver to JIT, if it hasn’t been already.
    ///Params:
    ///    resourceId = Type: <b>REFGUID</b> The unique id that identifies the shader.
    ///    shaderBuffer = Type: <b>BYTE*</b> The buffer that contains the shader to register.
    ///    shaderBufferCount = Type: <b>UINT32</b> The size of the shader buffer in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT LoadVertexShader(const(GUID)* resourceId, char* shaderBuffer, uint shaderBufferCount);
    ///Loads the given shader by its unique ID. Loading the shader multiple times is ignored. When the shader is loaded
    ///it is also handed to the driver to JIT, if it hasn’t been already.
    ///Params:
    ///    resourceId = Type: <b>REFGUID</b> The unique id that identifies the shader.
    ///    shaderBuffer = Type: <b>BYTE*</b> The buffer that contains the shader to register.
    ///    shaderBufferCount = Type: <b>UINT32</b> The size of the shader buffer in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT LoadComputeShader(const(GUID)* resourceId, char* shaderBuffer, uint shaderBufferCount);
    ///This tests to see if the given shader is loaded.
    ///Params:
    ///    shaderId = Type: <b>REFGUID</b> The unique id that identifies the shader.
    ///Returns:
    ///    Type: <b>BOOL</b> Whether the shader is loaded.
    ///    
    BOOL    IsShaderLoaded(const(GUID)* shaderId);
    ///Creates or finds the given resource texture, depending on whether a resource id is specified. It also optionally
    ///initializes the texture with the specified data.
    ///Params:
    ///    resourceId = Type: <b>const GUID*</b> An optional pointer to the unique id that identifies the lookup table.
    ///    resourceTextureProperties = Type: <b>const D2D1_RESOURCE_TEXTURE_PROPERTIES*</b> The properties used to create the resource texture.
    ///    data = Type: <b>const BYTE*</b> The optional data to be loaded into the resource texture.
    ///    strides = Type: <b>const UINT32*</b> An optional pointer to the stride to advance through the resource texture,
    ///              according to dimension.
    ///    dataSize = Type: <b>UINT32</b> The size, in bytes, of the data.
    ///    resourceTexture = Type: <b>ID2D1ResourceTexture**</b> The returned texture that can be used as a resource in a Direct2D effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CreateResourceTexture(const(GUID)* resourceId, 
                                  const(D2D1_RESOURCE_TEXTURE_PROPERTIES)* resourceTextureProperties, char* data, 
                                  char* strides, uint dataSize, ID2D1ResourceTexture* resourceTexture);
    ///Finds the given resource texture if it has already been created with ID2D1EffectContext::CreateResourceTexture
    ///with the same GUID.
    ///Params:
    ///    resourceId = Type: <b>const GUID*</b> The unique id that identifies the resource texture.
    ///    resourceTexture = Type: <b>ID2D1ResourceTexture**</b> The returned texture that can be used as a resource in a Direct2D effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td>E_NOTFOUND</td> <td>The requested resource texture was not found.</td> </tr>
    ///    </table>
    ///    
    HRESULT FindResourceTexture(const(GUID)* resourceId, ID2D1ResourceTexture* resourceTexture);
    ///Creates a vertex buffer or finds a standard vertex buffer and optionally initializes it with vertices. The
    ///returned buffer can be specified in the render info to specify both a vertex shader and or to pass custom
    ///vertices to the standard vertex shader used by Direct2D.
    ///Params:
    ///    vertexBufferProperties = Type: <b>const D2D1_VERTEX_BUFFER_PROPERTIES*</b> The properties used to describe the vertex buffer and
    ///                             vertex shader.
    ///    resourceId = Type: <b>const GUID*</b> The unique id that identifies the vertex buffer.
    ///    customVertexBufferProperties = Type: <b>const D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES*</b> The properties used to define a custom vertex
    ///                                   buffer. If you use a built-in vertex shader, you don't have to specify this property.
    ///    buffer = Type: <b>ID2D1VertexBuffer**</b> The returned vertex buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CreateVertexBuffer(const(D2D1_VERTEX_BUFFER_PROPERTIES)* vertexBufferProperties, 
                               const(GUID)* resourceId, 
                               const(D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES)* customVertexBufferProperties, 
                               ID2D1VertexBuffer* buffer);
    ///This finds the given vertex buffer if it has already been created with ID2D1EffectContext::CreateVertexBuffer
    ///with the same GUID.
    ///Params:
    ///    resourceId = Type: <b>const GUID*</b> The unique id that identifies the vertex buffer.
    ///    buffer = Type: <b>ID2D1VertexBuffer**</b> The returned vertex buffer that can be used as a resource in a Direct2D
    ///             effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an HRESULT. Possible values include, but are not limited to, those in
    ///    the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td> <td>No error
    ///    occurred.</td> </tr> <tr> <td>E_NOTFOUND</td> <td>The requested vertex buffer was not found.</td> </tr>
    ///    </table>
    ///    
    HRESULT FindVertexBuffer(const(GUID)* resourceId, ID2D1VertexBuffer* buffer);
    ///Creates a color context from a color space. If the color space is Custom, the context is initialized from the
    ///<i>profile</i> and <i>profileSize</i> parameters. If the color space is not Custom, the context is initialized
    ///with the profile bytes associated with the color space. The <i>profile</i> and <i>profileSize</i> parameters are
    ///ignored.
    ///Params:
    ///    space = Type: <b>D2D1_COLOR_SPACE</b> The space of color context to create.
    ///    profile = Type: <b>const BYTE*</b> A buffer containing the ICC profile bytes used to initialize the color context when
    ///              <i>space</i> is D2D1_COLOR_SPACE_CUSTOM. For other types, the parameter is ignored and should be set to
    ///              <b>NULL</b>.
    ///    profileSize = Type: <b>UINT32</b> The size in bytes of <i>Profile</i>.
    ///    colorContext = Type: <b>ID2D1ColorContext**</b> When this method returns, contains the address of a pointer to a new color
    ///                   context object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateColorContext(D2D1_COLOR_SPACE space, char* profile, uint profileSize, 
                               ID2D1ColorContext* colorContext);
    ///Creates a color context by loading it from the specified filename. The profile bytes are the contents of the file
    ///specified by <i>filename</i>.
    ///Params:
    ///    filename = Type: <b>PCWSTR</b> The path to the file containing the profile bytes to initialize the color context with.
    ///    colorContext = Type: <b>ID2D1ColorContext**</b> When this method returns, contains the address of a pointer to a new color
    ///                   context.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateColorContextFromFilename(const(wchar)* filename, ID2D1ColorContext* colorContext);
    ///Creates a color context from an IWICColorContext. The D2D1ColorContext space of the resulting context varies, see
    ///Remarks for more info.
    ///Params:
    ///    wicColorContext = Type: <b>IWICColorContext*</b> The IWICColorContext used to initialize the color context.
    ///    colorContext = Type: <b>ID2D1ColorContext**</b> When this method returns, contains the address of a pointer to a new color
    ///                   context.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateColorContextFromWicColorContext(IWICColorContext wicColorContext, 
                                                  ID2D1ColorContext* colorContext);
    ///This indicates whether an optional capability is supported by the D3D device.
    ///Params:
    ///    feature = Type: <b>D2D1_FEATURE</b> The feature to query support for.
    ///    featureSupportData = Type: <b>void*</b> A structure indicating information about how or if the feature is supported.
    ///    featureSupportDataSize = Type: <b>UINT32</b> The size of the <i>featureSupportData</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    HRESULT CheckFeatureSupport(D2D1_FEATURE feature, char* featureSupportData, uint featureSupportDataSize);
    ///Indicates whether the buffer precision is supported by the underlying Direct2D device.
    ///Params:
    ///    bufferPrecision = Type: <b>D2D1_BUFFER_PRECISION</b> The buffer precision to check.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if the buffer precision is supported. Returns FALSE if the buffer precision is
    ///    not supported.
    ///    
    BOOL    IsBufferPrecisionSupported(D2D1_BUFFER_PRECISION bufferPrecision);
}

///Encapsulates a device- and transform-dependent representation of a filled or stroked geometry. Callers should
///consider creating a geometry realization when they wish to accelerate repeated rendering of a given geometry. This
///interface exposes no methods.
@GUID("A16907D7-BC02-4801-99E8-8CF7F485F774")
interface ID2D1GeometryRealization : ID2D1Resource
{
}

///Enables creation and drawing of geometry realization objects.
@GUID("D37F57E4-6908-459F-A199-E72F24F79987")
interface ID2D1DeviceContext1 : ID2D1DeviceContext
{
    ///Creates a device-dependent representation of the fill of the geometry that can be subsequently rendered.
    ///Params:
    ///    geometry = Type: <b>ID2D1Geometry*</b> The geometry to realize.
    ///    flatteningTolerance = Type: <b>FLOAT</b> The flattening tolerance to use when converting Beziers to line segments. This parameter
    ///                          shares the same units as the coordinates of the geometry.
    ///    geometryRealization = Type: <b>ID2D1GeometryRealization**</b> When this method returns, contains the address of a pointer to a new
    ///                          geometry realization object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateFilledGeometryRealization(ID2D1Geometry geometry, float flatteningTolerance, 
                                            ID2D1GeometryRealization* geometryRealization);
    ///Creates a device-dependent representation of the stroke of a geometry that can be subsequently rendered.
    ///Params:
    ///    geometry = Type: <b>ID2D1Geometry*</b> The geometry to realize.
    ///    flatteningTolerance = Type: <b>FLOAT </b> The flattening tolerance to use when converting Beziers to line segments. This parameter
    ///                          shares the same units as the coordinates of the geometry.
    ///    strokeWidth = Type: <b>FLOAT </b> The width of the stroke. This parameter shares the same units as the coordinates of the
    ///                  geometry.
    ///    strokeStyle = Type: <b>ID2D1StrokeStyle*</b> The stroke style (optional).
    ///    geometryRealization = Type: <b>ID2D1GeometryRealization**</b> When this method returns, contains the address of a pointer to a new
    ///                          geometry realization object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    HRESULT CreateStrokedGeometryRealization(ID2D1Geometry geometry, float flatteningTolerance, float strokeWidth, 
                                             ID2D1StrokeStyle strokeStyle, 
                                             ID2D1GeometryRealization* geometryRealization);
    ///Renders a given geometry realization to the target with the specified brush.
    ///Params:
    ///    geometryRealization = Type: <b>ID2D1GeometryRealization*</b> The geometry realization to be rendered.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush to render the realization with.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call. </td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid value was passed to the
    ///    method.</td> </tr> </table>
    ///    
    void    DrawGeometryRealization(ID2D1GeometryRealization geometryRealization, ID2D1Brush brush);
}

///Represents a resource domain whose objects and device contexts can be used together. This interface performs all the
///same functions as the existing ID2D1Device interface. It also enables control of the device's rendering priority.
@GUID("D21768E1-23A4-4823-A14B-7C3EBA85D658")
interface ID2D1Device1 : ID2D1Device
{
    ///Retrieves the current rendering priority of the device.
    ///Returns:
    ///    Type: <b>D2D1_RENDERING_PRIORITY</b> The current rendering priority of the device.
    ///    
    D2D1_RENDERING_PRIORITY GetRenderingPriority();
    ///Sets the priority of Direct2D rendering operations performed on any device context associated with the device.
    ///Params:
    ///    renderingPriority = Type: <b>D2D1_RENDERING_PRIORITY</b> The desired rendering priority for the device and associated contexts.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> </table>
    ///    
    void    SetRenderingPriority(D2D1_RENDERING_PRIORITY renderingPriority);
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext1* deviceContext1);
}

///Creates Direct2D resources. This interface also enables the creation of ID2D1Device1 objects.
@GUID("94F81A73-9212-4376-9C58-B16A3A0D3992")
interface ID2D1Factory2 : ID2D1Factory1
{
    ///Creates an ID2D1Device1 object.
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice*</b> The IDXGIDevice object used when creating the ID2D1Device1.
    ///    d2dDevice1 = Type: <b>ID2D1Device1**</b> The requested ID2D1Device1 object.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns an <b>HRESULT</b>. Possible values include, but are not limited to,
    ///    those in the following table. <table> <tr> <th>HRESULT</th> <th>Description</th> </tr> <tr> <td>S_OK</td>
    ///    <td>No error occurred.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>Direct2D could not allocate sufficient
    ///    memory to complete the call.</td> </tr> <tr> <td>E_INVALIDARG</td> <td>An invalid parameter was passed to the
    ///    returning function.</td> </tr> <tr> <td>D3DERR_OUTOFVIDEOMEMORY</td> <td>Direct3D does not have enough
    ///    display memory to perform the operation.</td> </tr> </table>
    ///    
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device1* d2dDevice1);
}

///This interface performs all the same functions as the existing ID2D1CommandSink interface. It also enables access to
///the new primitive blend modes, MIN and ADD, through its SetPrimitiveBlend1 method.
@GUID("9EB767FD-4269-4467-B8C2-EB30CB305743")
interface ID2D1CommandSink1 : ID2D1CommandSink
{
    ///Sets a new primitive blend mode.
    ///Params:
    ///    primitiveBlend = Type: <b>D2D1_PRIMITIVE_BLEND</b> The primitive blend that will apply to subsequent primitives.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns <b>S_OK</b>. If it fails, it returns an
    ///    <b>HRESULT</b> error code.
    ///    
    HRESULT SetPrimitiveBlend1(D2D1_PRIMITIVE_BLEND primitiveBlend);
}

///Interface describing an SVG attribute.
@GUID("C9CDB0DD-F8C9-4E70-B7C2-301C80292C5E")
interface ID2D1SvgAttribute : ID2D1Resource
{
    ///Returns the element on which this attribute is set. Returns null if the attribute is not set on any element.
    ///Params:
    ///    element = Type: <b>ID2D1SvgElement**</b> When this method completes, this will contain a pointer to the element on
    ///              which this attribute is set.
    void    GetElement(ID2D1SvgElement* element);
    ///Creates a clone of this attribute value. On creation, the cloned attribute is not set on any element.
    ///Params:
    ///    attribute = Type: <b>ID2D1SvgAttribute**</b> Specifies the attribute value to clone.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT Clone(ID2D1SvgAttribute* attribute);
}

///Interface describing an SVG fill or stroke value.
@GUID("D59BAB0A-68A2-455B-A5DC-9EB2854E2490")
interface ID2D1SvgPaint : ID2D1SvgAttribute
{
    ///Sets the paint type.
    ///Params:
    ///    paintType = Type: <b>D2D1_SVG_PAINT_TYPE</b> The new paint type.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetPaintType(D2D1_SVG_PAINT_TYPE paintType);
    ///Gets the paint type.
    ///Returns:
    ///    Type: <b>D2D1_SVG_PAINT_TYPE</b> Returns the paint type.
    ///    
    D2D1_SVG_PAINT_TYPE GetPaintType();
    HRESULT SetColor(const(DXGI_RGBA)* color);
    ///Gets the paint color that is used if the paint type is D2D1_SVG_PAINT_TYPE_COLOR.
    ///Params:
    ///    color = Type: <b>D2D1_COLOR_F*</b> The paint color that is used if the paint type is D2D1_SVG_PAINT_TYPE_COLOR.
    void    GetColor(DXGI_RGBA* color);
    ///Sets the element id which acts as the paint server. This id is used if the paint type is D2D1_SVG_PAINT_TYPE_URI.
    ///Params:
    ///    id = Type: <b>PCWSTR</b> The element id which acts as the paint server. This id is used if the paint type is
    ///         D2D1_SVG_PAINT_TYPE_URI.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetId(const(wchar)* id);
    ///Gets the element id which acts as the paint server. This id is used if the paint type is D2D1_SVG_PAINT_TYPE_URI.
    ///Params:
    ///    id = Type: <b>PWSTR</b> The element id which acts as the paint server.
    ///    idCount = Type: <b>UINT32</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetId(const(wchar)* id, uint idCount);
    ///Gets the string length of the element id which acts as the paint server. This id is used if the paint type is
    ///D2D1_SVG_PAINT_TYPE_URI.
    ///Returns:
    ///    Type: <b>UINT32</b> the string length of the element id which acts as the paint server. The returned string
    ///    length does not include room for the null terminator.
    ///    
    uint    GetIdLength();
}

///Interface describing an SVG stroke-dasharray value.
@GUID("F1C0CA52-92A3-4F00-B4CE-F35691EFD9D9")
interface ID2D1SvgStrokeDashArray : ID2D1SvgAttribute
{
    ///Removes dashes from the end of the array.
    ///Params:
    ///    dashesCount = Type: <b>UINT32</b> Specifies how many dashes to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT RemoveDashesAtEnd(uint dashesCount);
    HRESULT UpdateDashes(char* dashes, uint dashesCount, uint startIndex);
    HRESULT UpdateDashes(char* dashes, uint dashesCount, uint startIndex);
    HRESULT GetDashes(char* dashes, uint dashesCount, uint startIndex);
    HRESULT GetDashes(char* dashes, uint dashesCount, uint startIndex);
    ///Gets the number of the dashes in the array.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of the dashes in the array.
    ///    
    uint    GetDashesCount();
}

///Interface describing an SVG points value in a polyline or polygon element.
@GUID("9DBE4C0D-3572-4DD9-9825-5530813BB712")
interface ID2D1SvgPointCollection : ID2D1SvgAttribute
{
    ///Removes points from the end of the array.
    ///Params:
    ///    pointsCount = Type: <b>UINT32</b> Specifies how many points to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT RemovePointsAtEnd(uint pointsCount);
    ///Updates the points array. Existing points not updated by this method are preserved. The array is resized larger
    ///if necessary to accomodate the new points.
    ///Params:
    ///    points = Type: <b>const D2D1_POINT_2F*</b> The points array.
    ///    pointsCount = Type: <b>UINT32</b> The number of points to update.
    ///    startIndex = Type: <b>UINT32</b> The index at which to begin updating points. Must be less than or equal to the size of
    ///                 the array.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT UpdatePoints(char* points, uint pointsCount, uint startIndex);
    ///Gets points from the points array.
    ///Params:
    ///    points = Type: <b>D2D1_POINT_2F*</b> Buffer to contain the points.
    ///    pointsCount = Type: <b>UINT32</b> The element count of the buffer.
    ///    startIndex = Type: <b>UINT32</b> The index of the first point to retrieve.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetPoints(char* points, uint pointsCount, uint startIndex);
    ///Gets the number of points in the array.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of points in the array.
    ///    
    uint    GetPointsCount();
}

///Interface describing SVG path data. Path data can be set as the 'd' attribute on a 'path' element. The path data set
///is factored into two arrays. The segment data array stores all numbers and the commands array stores the set of
///commands. Unlike the string data set in the d attribute, each command in this representation uses a fixed number of
///elements in the segment data array. Therefore, the path 'M 0,0 100,0 0,100 Z' is represented as: 'M0,0 L100,0 L0,100
///Z'. This is split into two arrays, with the segment data containing '0,0 100,0 0,100', and the commands containing 'M
///L L Z'.
@GUID("C095E4F4-BB98-43D6-9745-4D1B84EC9888")
interface ID2D1SvgPathData : ID2D1SvgAttribute
{
    ///Removes data from the end of the segment data array.
    ///Params:
    ///    dataCount = Type: <b>UINT32</b> Specifies how much data to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT RemoveSegmentDataAtEnd(uint dataCount);
    ///Updates the segment data array. Existing segment data not updated by this method are preserved. The array is
    ///resized larger if necessary to accomodate the new segment data.
    ///Params:
    ///    data = Type: <b>const FLOAT*</b> The data array.
    ///    dataCount = Type: <b>UINT32</b> The number of data to update.
    ///    startIndex = Type: <b>UINT32</b> The index at which to begin updating segment data. Must be less than or equal to the size
    ///                 of the segment data array.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT UpdateSegmentData(char* data, uint dataCount, uint startIndex);
    ///Gets data from the segment data array.
    ///Params:
    ///    data = Type: <b>FLOAT*</b> Buffer to contain the segment data array.
    ///    dataCount = Type: <b>UINT32</b> The element count of the buffer.
    ///    startIndex = Type: <b>UINT32</b> The index of the first segment data to retrieve.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetSegmentData(char* data, uint dataCount, uint startIndex);
    ///Gets the size of the segment data array.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the size of the segment data array.
    ///    
    uint    GetSegmentDataCount();
    ///Removes commands from the end of the commands array.
    ///Params:
    ///    commandsCount = Type: <b>UINT32</b> Specifies how many commands to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT RemoveCommandsAtEnd(uint commandsCount);
    ///Updates the commands array. Existing commands not updated by this method are preserved. The array is resized
    ///larger if necessary to accomodate the new commands.
    ///Params:
    ///    commands = Type: <b>const D2D1_SVG_PATH_COMMAND*</b> The commands array.
    ///    commandsCount = Type: <b>UINT32</b> The number of commands to update.
    ///    startIndex = Type: <b>UINT32</b> The index at which to begin updating commands. Must be less than or equal to the size of
    ///                 the commands array.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT UpdateCommands(char* commands, uint commandsCount, uint startIndex);
    ///Gets commands from the commands array.
    ///Params:
    ///    commands = Type: <b>D2D1_SVG_PATH_COMMAND*</b> Buffer to contain the commands.
    ///    commandsCount = Type: <b>UINT32</b> The element count of the buffer.
    ///    startIndex = Type: <b>UINT32</b> The index of the first commands to retrieve.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetCommands(char* commands, uint commandsCount, uint startIndex);
    ///Gets the size of the commands array.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the size of the commands array.
    ///    
    uint    GetCommandsCount();
    ///Creates a path geometry object representing the path data.
    ///Params:
    ///    fillMode = Type: <b>D2D1_FILL_MODE</b> Fill mode for the path geometry object.
    ///    pathGeometry = Type: <b>ID2D1PathGeometry1**</b> On completion, pathGeometry will contain a point to the created
    ///                   ID2D1PathGeometry1 object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreatePathGeometry(D2D1_FILL_MODE fillMode, ID2D1PathGeometry1* pathGeometry);
}

///Interface for all SVG elements.
@GUID("AC7B67A6-183E-49C1-A823-0EBE40B0DB29")
interface ID2D1SvgElement : ID2D1Resource
{
    ///Gets the document that contains this element.
    ///Params:
    ///    document = Type: <b>ID2D1SvgDocument**</b> Ouputs the document that contains this element. This argument will be null if
    ///               the element has been removed from the tree.
    void    GetDocument(ID2D1SvgDocument* document);
    ///Gets the tag name.
    ///Params:
    ///    name = Type: <b>PWSTR</b> The tag name.
    ///    nameCount = Type: <b>UINT32</b> Length of the value in the name argument.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetTagName(const(wchar)* name, uint nameCount);
    ///Gets the string length of the tag name.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the string length of the tag name. The returned string length does not include
    ///    room for the null terminator.
    ///    
    uint    GetTagNameLength();
    ///Returns a boolean indicating wether this element represents text content.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if this element represents text content, e.g. the content of a 'title' or
    ///    'desc' element. Text content does not have a tag name.
    ///    
    BOOL    IsTextContent();
    ///Gets the parent element.
    ///Params:
    ///    parent = Type: <b>ID2D1SvgElement**</b> Outputs the parent element.
    void    GetParent(ID2D1SvgElement* parent);
    ///Returns a boolean indicating whether this element has children.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if this element has children.
    ///    
    BOOL    HasChildren();
    ///Gets the first child of this element.
    ///Params:
    ///    child = Type: <b>ID2D1SvgElement**</b> Outputs the first child of this element.
    void    GetFirstChild(ID2D1SvgElement* child);
    ///Gets the last child of this element.
    ///Params:
    ///    child = Type: <b>ID2D1SvgElement**</b> Outputs the last child of this element.
    void    GetLastChild(ID2D1SvgElement* child);
    ///Gets the previous sibling of the referenceChild element.
    ///Params:
    ///    referenceChild = Type: <b>ID2D1SvgElement*</b> The referenceChild must be an immediate child of this element.
    ///    previousChild = Type: <b>ID2D1SvgElement**</b> The output previousChild element will be non-null if the referenceChild has a
    ///                    previous sibling. If the referenceChild is the first child, the output is null.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetPreviousChild(ID2D1SvgElement referenceChild, ID2D1SvgElement* previousChild);
    ///Gets the next sibling of the referenceChild element.
    ///Params:
    ///    referenceChild = Type: <b>ID2D1SvgElement*</b> The referenceChild must be an immediate child of this element.
    ///    nextChild = Type: <b>ID2D1SvgElement**</b> The output nextChild element will be non-null if the referenceChild has a next
    ///                sibling. If the referenceChild is the last child, the output is null.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetNextChild(ID2D1SvgElement referenceChild, ID2D1SvgElement* nextChild);
    ///Inserts newChild as a child of this element, before the referenceChild element. If the newChild element already
    ///has a parent, it is removed from this parent as part of the insertion.
    ///Params:
    ///    newChild = Type: <b>ID2D1SvgElement*</b> The element to be inserted.
    ///    referenceChild = Type: <b>ID2D1SvgElement*</b> The element that the child should be inserted before. If referenceChild is
    ///                     null, the newChild is placed as the last child. If referenceChild is non-null, it must be an immediate child
    ///                     of this element.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code. Returns an error if this element
    ///    cannot accept children of the type of newChild. Returns an error if the newChild is an ancestor of this
    ///    element.
    ///    
    HRESULT InsertChildBefore(ID2D1SvgElement newChild, ID2D1SvgElement referenceChild);
    ///Appends an element to the list of children. If the element already has a parent, it is removed from this parent
    ///as part of the append operation.
    ///Params:
    ///    newChild = Type: <b>ID2D1SvgElement*</b> The element to append.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code. Returns an error if this element
    ///    cannot accept children of the type of newChild. Returns an error if the newChild is an ancestor of this
    ///    element.
    ///    
    HRESULT AppendChild(ID2D1SvgElement newChild);
    ///Replaces the oldChild element with the newChild. This operation removes the oldChild from the tree. If the
    ///newChild element already has a parent, it is removed from this parent as part of the replace operation.
    ///Params:
    ///    newChild = Type: <b>ID2D1SvgElement*</b> The element to be inserted.
    ///    oldChild = Type: <b>ID2D1SvgElement*</b> The child element to be replaced. The oldChild element must be an immediate
    ///               child of this element.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code. Returns an error if this element
    ///    cannot accept children of the type of newChild. Returns an error if the newChild is an ancestor of this
    ///    element.
    ///    
    HRESULT ReplaceChild(ID2D1SvgElement newChild, ID2D1SvgElement oldChild);
    ///Removes the oldChild from the tree. Children of oldChild remain children of oldChild.
    ///Params:
    ///    oldChild = Type: <b>ID2D1SvgElement*</b> The child element to be removed. The oldChild element must be an immediate
    ///               child of this element.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT RemoveChild(ID2D1SvgElement oldChild);
    ///Creates an element from a tag name. The element is appended to the list of children.
    ///Params:
    ///    tagName = Type: <b>PCWSTR</b> The tag name of the new child. An empty string is interpreted to be a text content
    ///              element.
    ///    newChild = Type: <b>ID2D1SvgElement**</b> The new child element.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code. Returns an error if this element
    ///    cannot accept children of the specified type.
    ///    
    HRESULT CreateChild(const(wchar)* tagName, ID2D1SvgElement* newChild);
    ///Returns a boolean indicating if the attribute is explicitly set on the element.
    ///Params:
    ///    name = Type: <b>PCWSTR</b> The name of the attribute.
    ///    inherited = Type: <b>BOOL*</b> Outputs whether the attribute is set to the inherit value.
    ///Returns:
    ///    Type: <b>BOOL</b> TReturns true if the attribute is explicitly set on the element or if it is present within
    ///    an inline style. Returns FALSE if the attribute is not a valid attribute on this element.
    ///    
    BOOL    IsAttributeSpecified(const(wchar)* name, int* inherited);
    ///Returns the number of specified attributes on this element. Attributes are only considered specified if they are
    ///explicitly set on the element or present within an inline style. Properties that receive their value through CSS
    ///inheritance are not considered specified. An attribute can become specified if it is set through a method call.
    ///It can become unspecified if it is removed via RemoveAttribute.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of specified attributes on this element.
    ///    
    uint    GetSpecifiedAttributeCount();
    ///Gets the name of the attribute at the given index.
    ///Params:
    ///    index = Type: <b>UINT32</b> The index of the attribute.
    ///    name = Type: <b>PWSTR</b> Outputs the name of the attribute.
    ///    nameCount = Type: <b>UINT32</b> Length of the string returned in the name argument.
    ///    inherited = Type: <b>BOOL*</b> Outputs whether the attribute is set to the inherit value.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetSpecifiedAttributeName(uint index, const(wchar)* name, uint nameCount, int* inherited);
    ///Gets the string length of the name of the specified attribute at the given index. The output string length does
    ///not include room for the null terminator.
    ///Params:
    ///    index = Type: <b>UINT32</b> The index of the attribute.
    ///    nameLength = Type: <b>UINT32*</b> Outputs the string length of the name of the specified attribute.
    ///    inherited = Type: <b>BOOL*</b> Indicates whether the attribute is set to the inherit value.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetSpecifiedAttributeNameLength(uint index, uint* nameLength, int* inherited);
    ///Removes the attribute from this element. Also removes this attribute from within an inline style if present.
    ///Params:
    ///    name = Type: <b>PCWSTR</b> The name of the attribute to remove.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code. Returns an error if the attribute
    ///    name is not valid on this element.
    ///    
    HRESULT RemoveAttribute(const(wchar)* name);
    ///Sets the value of a text content element.
    ///Params:
    ///    name = Type: <b>const WCHAR*</b> The new value of the text content element.
    ///    nameCount = Type: <b>UINT32</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetTextValue(const(wchar)* name, uint nameCount);
    ///Gets the value of a text content element.
    ///Params:
    ///    name = Type: <b>PWSTR</b> The value of the text content element.
    ///    nameCount = Type: <b>UINT32</b> The length of the value in the name argument.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetTextValue(const(wchar)* name, uint nameCount);
    ///Gets the length of the text content value.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the length of the text content value. The returned string length does not include
    ///    room for the null terminator.
    ///    
    uint    GetTextValueLength();
    HRESULT SetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, const(wchar)* value);
    HRESULT GetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, const(wchar)* value, 
                              uint valueCount);
    ///Gets the string length of an attribute of this element.
    ///Params:
    ///    name = Type: <b>PCWSTR</b> The name of the attribute.
    ///    type = Type: <b>D2D1_SVG_ATTRIBUTE_STRING_TYPE</b> The string type of the attribute.
    ///    valueLength = Type: <b>UINT32*</b> The lengthe of the attribute. The returned string length does not include room for the
    ///                  null terminator.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code. Returns an error if the attribute
    ///    is not specified. Returns an error if the attribute name is not valid on this element. Returns an error if
    ///    the attribute cannot be expressed as the specified string type.
    ///    
    HRESULT GetAttributeValueLength(const(wchar)* name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, uint* valueLength);
    HRESULT SetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_POD_TYPE type, char* value, 
                              uint valueSizeInBytes);
    HRESULT GetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_POD_TYPE type, char* value, 
                              uint valueSizeInBytes);
    HRESULT SetAttributeValue(const(wchar)* name, ID2D1SvgAttribute value);
    HRESULT GetAttributeValue(const(wchar)* name, const(GUID)* riid, void** value);
}

///Represents an SVG document.
@GUID("86B88E4D-AFA4-4D7B-88E4-68A51C4A0AEC")
interface ID2D1SvgDocument : ID2D1Resource
{
    ///Sets the size of the initial viewport.
    ///Params:
    ///    viewportSize = Type: <b>D2D1_SIZE_F</b> The size of the viewport.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetViewportSize(D2D_SIZE_F viewportSize);
    ///Returns the size of the initial viewport.
    ///Returns:
    ///    Type: <b>D2D1_SIZE_F</b> Returns the size of the initial viewport
    ///    
    D2D_SIZE_F GetViewportSize();
    ///Sets the root element of the document.The root element must be an svg element. If the element already exists
    ///within an svg tree, it is first removed.
    ///Params:
    ///    root = Type: <b>ID2D1SvgElement*</b> The new root element of the document.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetRoot(ID2D1SvgElement root);
    ///Gets the root element of the document.
    ///Params:
    ///    root = Type: <b>ID2D1SvgElement**</b> Outputs the root element of the document.
    void    GetRoot(ID2D1SvgElement* root);
    ///Gets the SVG element with the specified ID.
    ///Params:
    ///    id = Type: <b>PCWSTR</b> ID of the element to retrieve.
    ///    svgElement = Type: <b>ID2D1SvgElement**</b> The element matching the specified ID. If the element cannot be found, the
    ///                 returned element will be null.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT FindElementById(const(wchar)* id, ID2D1SvgElement* svgElement);
    ///Serializes an element and its subtree to XML. The output XML is encoded as UTF-8.
    ///Params:
    ///    outputXmlStream = Type: <b>IStream*</b> An output stream to contain the SVG XML subtree.
    ///    subtree = Type: <b>ID2D1SvgElement*</b> The root of the subtree. If null, the entire document is serialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT Serialize(IStream outputXmlStream, ID2D1SvgElement subtree);
    ///Deserializes a subtree from the stream. The stream must have only one root element, but that root element need
    ///not be an 'svg' element. The output element is not inserted into this document tree.
    ///Params:
    ///    inputXmlStream = Type: <b>IStream*</b> An input stream containing the SVG XML subtree.
    ///    subtree = Type: <b>ID2D1SvgElement**</b> The root of the subtree.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT Deserialize(IStream inputXmlStream, ID2D1SvgElement* subtree);
    HRESULT CreatePaint(D2D1_SVG_PAINT_TYPE paintType, const(DXGI_RGBA)* color, const(wchar)* id, 
                        ID2D1SvgPaint* paint);
    ///Creates a dash array object which can be used to set the stroke-dasharray property.
    ///Params:
    ///    dashes = Type: <b>const D2D1_SVG_LENGTH*</b> An array of dashes.
    ///    dashesCount = Type: <b>UINT32</b> Size of the array in th dashes argument.
    ///    strokeDashArray = Type: <b>ID2D1SvgStrokeDashArray**</b> The created ID2D1SvgStrokeDashArray.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateStrokeDashArray(char* dashes, uint dashesCount, ID2D1SvgStrokeDashArray* strokeDashArray);
    ///Creates a points object which can be used to set a points attribute on a polygon or polyline element.
    ///Params:
    ///    points = Type: <b>const D2D1_POINT_2F*</b> The points in the point collection.
    ///    pointsCount = Type: <b>UINT32</b> The number of points in the points argument.
    ///    pointCollection = Type: <b>ID2D1SvgPointCollection**</b> The created ID2D1SvgPointCollection object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreatePointCollection(char* points, uint pointsCount, ID2D1SvgPointCollection* pointCollection);
    ///Creates a path data object which can be used to set a 'd' attribute on a 'path' element.
    ///Params:
    ///    segmentData = Type: <b>const FLOAT*</b> An array of segment data.
    ///    segmentDataCount = Type: <b>UINT32</b> Number of items in segmentData.
    ///    commands = Type: <b>const D2D1_SVG_PATH_COMMAND*</b> An array of path commands.
    ///    commandsCount = Type: <b>UINT32</b> The number of items in commands.
    ///    pathData = Type: <b>ID2D1SvgPathData**</b> When this method completes, this points to the created path data.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreatePathData(char* segmentData, uint segmentDataCount, char* commands, uint commandsCount, 
                           ID2D1SvgPathData* pathData);
}

///Represents a collection of style properties to be used by methods like ID2D1DeviceContext2::DrawInkwhen rendering
///ink. The ink style defines the nib (pen tip) shape and transform.
@GUID("BAE8B344-23FC-4071-8CB5-D05D6F073848")
interface ID2D1InkStyle : ID2D1Resource
{
    void SetNibTransform(const(D2D_MATRIX_3X2_F)* transform);
    ///Retrieves the transform to be applied to this style's nib shape.
    ///Params:
    ///    transform = Type: <b>D2D1_MATRIX_3X2_F*</b> When this method returns, contains a pointer to the transform to be applied
    ///                to this style's nib shape.
    void GetNibTransform(D2D_MATRIX_3X2_F* transform);
    ///Sets the pre-transform nib shape for this style.
    ///Params:
    ///    nibShape = Type: <b>D2D1_INK_NIB_SHAPE</b> The pre-transform nib shape to use in this style.
    void SetNibShape(D2D1_INK_NIB_SHAPE nibShape);
    ///Retrieves the pre-transform nib shape for this style.
    ///Returns:
    ///    Type: <b>D2D1_INK_NIB_SHAPE</b> Returns the pre-transform nib shape for this style.
    ///    
    D2D1_INK_NIB_SHAPE GetNibShape();
}

///Represents a single continuous stroke of variable-width ink, as defined by a series of Bezier segments and widths.
@GUID("B499923B-7029-478F-A8B3-432C7C5F5312")
interface ID2D1Ink : ID2D1Resource
{
    void    SetStartPoint(const(D2D1_INK_POINT)* startPoint);
    ///Retrieves the starting point for this ink object.
    ///Returns:
    ///    Type: <b>D2D1_INK_POINT</b> The starting point for this ink object.
    ///    
    D2D1_INK_POINT GetStartPoint();
    ///Adds the given segments to the end of this ink object.
    ///Params:
    ///    segments = Type: <b>const D2D1_INK_BEZIER_SEGMENT*</b> A pointer to an array of segments to be added to this ink object.
    ///    segmentsCount = Type: <b>UINT32</b> The number of segments to be added to this ink object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddSegments(char* segments, uint segmentsCount);
    ///Removes the given number of segments from the end of this ink object.
    ///Params:
    ///    segmentsCount = Type: <b>UINT32</b> The number of segments to be removed from the end of this ink object. Note that
    ///                    segmentsCount must be less or equal to the number of segments in the ink object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveSegmentsAtEnd(uint segmentsCount);
    ///Updates the specified segments in this ink object with new control points.
    ///Params:
    ///    startSegment = Type: <b>UINT32</b> The index of the first segment in this ink object to update.
    ///    segments = Type: <b>const D2D1_INK_BEZIER_SEGMENT*</b> A pointer to the array of segment data to be used in the update.
    ///    segmentsCount = Type: <b>UINT32</b> The number of segments in this ink object that will be updated with new data. Note that
    ///                    segmentsCount must be less than or equal to the number of segments in the ink object minus startSegment.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSegments(uint startSegment, char* segments, uint segmentsCount);
    HRESULT SetSegmentAtEnd(const(D2D1_INK_BEZIER_SEGMENT)* segment);
    ///Returns the number of segments in this ink object.
    ///Returns:
    ///    Type: <b>UINT32 </b> Returns the number of segments in this ink object.
    ///    
    uint    GetSegmentCount();
    ///Retrieves the specified subset of segments stored in this ink object.
    ///Params:
    ///    startSegment = Type: <b>UINT32</b> The index of the first segment in this ink object to retrieve.
    ///    segments = Type: <b>D2D1_INK_BEZIER_SEGMENT*</b> When this method returns, contains a pointer to an array of retrieved
    ///               segments.
    ///    segmentsCount = Type: <b>UINT32</b> The number of segments to retrieve. Note that segmentsCount must be less than or equal to
    ///                    the number of segments in the ink object minus startSegment.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSegments(uint startSegment, char* segments, uint segmentsCount);
    HRESULT StreamAsGeometry(ID2D1InkStyle inkStyle, const(D2D_MATRIX_3X2_F)* worldTransform, 
                             float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
    ///Retrieve the bounds of the geometry, with an optional applied transform.
    ///Params:
    ///    inkStyle = Type: <b>ID2D1InkStyle*</b> The ink style to be used in determining the bounds of this ink object.
    ///    worldTransform = Type: <b>const D2D1_MATRIX_3X2_F*</b> The world transform to be used in determining the bounds of this ink
    ///                     object.
    ///    bounds = Type: <b>D2D1_RECT_F*</b> When this method returns, contains the bounds of this ink object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBounds(ID2D1InkStyle inkStyle, const(D2D_MATRIX_3X2_F)* worldTransform, D2D_RECT_F* bounds);
}

///Represents a device-dependent representation of a gradient mesh composed of patches. Use the
///ID2D1DeviceContext2::CreateGradientMesh method to create an instance of ID2D1GradientMesh.
@GUID("F292E401-C050-4CDE-83D7-04962D3B23C2")
interface ID2D1GradientMesh : ID2D1Resource
{
    ///Returns the number of patches that make up this gradient mesh.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of patches that make up this gradient mesh.
    ///    
    uint    GetPatchCount();
    ///Returns a subset of the patches that make up this gradient mesh.
    ///Params:
    ///    startIndex = Type: <b>UINT32</b> Index of the first patch to return.
    ///    patches = Type: <b>D2D1_GRADIENT_MESH_PATCH*</b> A pointer to the array to be filled with the patch data.
    ///    patchesCount = Type: <b>UINT32</b> The number of patches to be returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK if successful, otherwise a failure HRESULT.
    ///    
    HRESULT GetPatches(uint startIndex, char* patches, uint patchesCount);
}

///Represents a producer of pixels that can fill an arbitrary 2D plane.
@GUID("C9B664E5-74A1-4378-9AC2-EEFC37A3F4D8")
interface ID2D1ImageSource : ID2D1Image
{
    ///Allows the operating system to free the video memory of resources by discarding their content.
    ///Returns:
    ///    Type: <b>HRESULT</b> <b>OfferResources</b> returns: <ul> <li><b>S_OK</b> if resources were successfully
    ///    offered </li> <li><b>E_INVALIDARG</b> if a resource in the array or the priority is invalid </li> </ul>
    ///    
    HRESULT OfferResources();
    ///Restores access to resources that were previously offered by calling OfferResources.
    ///Params:
    ///    resourcesDiscarded = Type: <b>BOOL*</b> Returns with TRUE if the corresponding resource’s content was discarded and is now
    ///                         undefined, or FALSE if the corresponding resource’s old content is still intact. The caller can pass in
    ///                         NULL, if the caller intends to fill the resources with new content regardless of whether the old content was
    ///                         discarded.
    ///Returns:
    ///    Type: <b>HRESULT</b> <b>ReclaimResources</b> returns: <ul> <li><b>S_OK</b> if resources were successfully
    ///    reclaimed </li> <li><b>E_INVALIDARG</b> if the resources are invalid </li> </ul>
    ///    
    HRESULT TryReclaimResources(int* resourcesDiscarded);
}

///Produces 2D pixel data that has been sourced from WIC.
@GUID("77395441-1C8F-4555-8683-F50DAB0FE792")
interface ID2D1ImageSourceFromWic : ID2D1ImageSource
{
    HRESULT EnsureCached(const(D2D_RECT_U)* rectangleToFill);
    HRESULT TrimCache(const(D2D_RECT_U)* rectangleToPreserve);
    ///Retrieves the underlying bitmap image source from the Windows Imaging Component (WIC).
    ///Params:
    ///    wicBitmapSource = Type: <b>IWICBitmapSource**</b> On return contains the bitmap image source.
    void    GetSource(IWICBitmapSource* wicBitmapSource);
}

///Represents an image source which shares resources with an original image source.
@GUID("7F1F79E5-2796-416C-8F55-700F911445E5")
interface ID2D1TransformedImageSource : ID2D1Image
{
    ///Retrieves the source image used to create the transformed image source. This value corresponds to the value
    ///passed to CreateTransformedImageSource.
    ///Params:
    ///    imageSource = Type: <b>_Outptr_result_maybenull_**</b> Retrieves the source image used to create the transformed image
    ///                  source.
    void GetSource(ID2D1ImageSource* imageSource);
    ///Retrieves the properties specified when the transformed image source was created. This value corresponds to the
    ///value passed to CreateTransformedImageSource.
    ///Params:
    ///    properties = Type: <b>D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES*</b> the properties specified when the transformed image
    ///                 source was created.
    void GetProperties(D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES* properties);
}

///A container for 3D lookup table data that can be passed to the LookupTable3D effect.
@GUID("53DD9855-A3B0-4D5B-82E1-26E25C5E5797")
interface ID2D1LookupTable3D : ID2D1Resource
{
}

///This interface performs all the same functions as the ID2D1DeviceContext1 interface, plus it enables functionality
///such as ink rendering, gradient mesh rendering, and improved image loading.
@GUID("394EA6A3-0C34-4321-950B-6CA20F0BE6C7")
interface ID2D1DeviceContext2 : ID2D1DeviceContext1
{
    HRESULT CreateInk(const(D2D1_INK_POINT)* startPoint, ID2D1Ink* ink);
    HRESULT CreateInkStyle(const(D2D1_INK_STYLE_PROPERTIES)* inkStyleProperties, ID2D1InkStyle* inkStyle);
    ///Creates a new ID2D1GradientMesh instance using the given array of patches.
    ///Params:
    ///    patches = Type: <b>const D2D1_GRADIENT_MESH_PATCH*</b> A pointer to the array containing the patches to be used in this
    ///              mesh.
    ///    patchesCount = Type: <b>UINT32</b> The number of patches in the patches argument to read.
    ///    gradientMesh = Type: <b>ID2D1GradientMesh**</b> When this method returns, contains the address of a pointer to the new
    ///                   gradient mesh.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK if successful, otherwise a failure HRESULT.
    ///    
    HRESULT CreateGradientMesh(char* patches, uint patchesCount, ID2D1GradientMesh* gradientMesh);
    HRESULT CreateImageSourceFromWic(IWICBitmapSource wicBitmapSource, 
                                     D2D1_IMAGE_SOURCE_LOADING_OPTIONS loadingOptions, D2D1_ALPHA_MODE alphaMode, 
                                     ID2D1ImageSourceFromWic* imageSource);
    ///Creates a 3D lookup table for mapping a 3-channel input to a 3-channel output. The table data must be provided in
    ///4-channel format.
    ///Params:
    ///    precision = Type: <b>D2D1_BUFFER_PRECISION</b> Precision of the input lookup table data.
    ///    extents = Type: <b>const UINT32*</b> Number of lookup table elements per dimension (X, Y, Z).
    ///    data = Type: <b>const BYTE*</b> Buffer holding the lookup table data.
    ///    dataCount = Type: <b>UINT32</b> Size of the lookup table data buffer.
    ///    strides = Type: <b>const UINT32*</b> An array containing two values. The first value is the size in bytes from one row
    ///              (X dimension) of LUT data to the next. The second value is the size in bytes from one LUT data plane (X and Y
    ///              dimensions) to the next.
    ///    lookupTable = Type: <b>ID2D1LookupTable3D**</b> Receives the new lookup table instance.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK if successful, otherwise a failure HRESULT.
    ///    
    HRESULT CreateLookupTable3D(D2D1_BUFFER_PRECISION precision, char* extents, char* data, uint dataCount, 
                                char* strides, ID2D1LookupTable3D* lookupTable);
    ///Creates an image source from a set of DXGI surface(s). The YCbCr surface(s) are converted to RGBA automatically
    ///during subsequent drawing.
    ///Params:
    ///    surfaces = Type: [in] <b>IDXGISurface**</b> The DXGI surfaces to create the image source from.
    ///    surfaceCount = Type: <b>UINT32</b> The number of surfaces provided; must be between one and three.
    ///    colorSpace = Type: <b>DXGI_COLOR_SPACE_TYPE</b> The color space of the input.
    ///    options = Type: <b>D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS</b> Options controlling color space conversions.
    ///    imageSource = Type: [out] <b>ID2D1ImageSource**</b> Receives the new image source instance.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK if successful, otherwise a failure HRESULT.
    ///    
    HRESULT CreateImageSourceFromDxgi(char* surfaces, uint surfaceCount, DXGI_COLOR_SPACE_TYPE colorSpace, 
                                      D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS options, ID2D1ImageSource* imageSource);
    ///Returns the world bounds of a given gradient mesh.
    ///Params:
    ///    gradientMesh = Type: <b>ID2D1GradientMesh*</b> The gradient mesh whose world bounds will be calculated.
    ///    pBounds = Type: <b>D2D1_RECT_F*</b> When this method returns, contains a pointer to the bounds of the gradient mesh, in
    ///              device independent pixels (DIPs).
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK if successful, otherwise a failure HRESULT.
    ///    
    HRESULT GetGradientMeshWorldBounds(ID2D1GradientMesh gradientMesh, D2D_RECT_F* pBounds);
    ///Renders the given ink object using the given brush and ink style.
    ///Params:
    ///    ink = Type: <b>ID2D1Ink*</b> The ink object to be rendered.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush with which to render the ink object.
    ///    inkStyle = Type: <b>ID2D1InkStyle*</b> The ink style to use when rendering the ink object.
    void    DrawInk(ID2D1Ink ink, ID2D1Brush brush, ID2D1InkStyle inkStyle);
    ///Renders a given gradient mesh to the target.
    ///Params:
    ///    gradientMesh = Type: <b>ID2D1GradientMesh*</b> The gradient mesh to be rendered.
    void    DrawGradientMesh(ID2D1GradientMesh gradientMesh);
    void    DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
    ///Creates an image source which shares resources with an original.
    ///Params:
    ///    imageSource = Type: <b>ID2D1ImageSource*</b> The original image.
    ///    properties = Type: <b>const D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES*</b> Properties for the source image.
    ///    transformedImageSource = Type: <b>ID2D1TransformedImageSource**</b> Receives the new image source.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTransformedImageSource(ID2D1ImageSource imageSource, 
                                         const(D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES)* properties, 
                                         ID2D1TransformedImageSource* transformedImageSource);
}

///Represents a resource domain whose objects and device contexts can be used together. This interface performs all the
///same functions as the existing ID2D1Device1 interface. It also enables the creation of ID2D1DeviceContext2 objects.
@GUID("A44472E1-8DFB-4E60-8492-6E2861C9CA8B")
interface ID2D1Device2 : ID2D1Device1
{
    ///Creates a new ID2D1DeviceContext2 from a Direct2D device.
    ///Params:
    ///    options = Type: <b>D2D1_DEVICE_CONTEXT_OPTIONS</b> The options to be applied to the created device context.
    ///    deviceContext2 = Type: <b>ID2D1DeviceContext2**</b> When this method returns, contains the address of a pointer to the new
    ///                     device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext2* deviceContext2);
    ///Flush all device contexts that reference a given bitmap.
    ///Params:
    ///    bitmap = Type: <b>ID2D1Bitmap*</b> The bitmap, created on this device, for which all referencing device contexts will
    ///             be flushed.
    void    FlushDeviceContexts(ID2D1Bitmap bitmap);
    ///Returns the DXGI device associated with this Direct2D device.
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice**</b> The DXGI device associated with this Direct2D device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDxgiDevice(IDXGIDevice* dxgiDevice);
}

///Creates Direct2D resources. This interface also enables the creation of ID2D1Device2 objects.
@GUID("0869759F-4F00-413F-B03E-2BDA45404D0F")
interface ID2D1Factory3 : ID2D1Factory2
{
    ///Creates an ID2D1Device2 object.
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice*</b> The IDXGIDevice object used when creating the ID2D1Device2.
    ///    d2dDevice2 = Type: <b>ID2D1Device2**</b> The requested ID2D1Device2 object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device2* d2dDevice2);
}

///This interface performs all the same functions as the existing ID2D1CommandSink1 interface. It also enables access to
///ink rendering and gradient mesh rendering.
@GUID("3BAB440E-417E-47DF-A2E2-BC0BE6A00916")
interface ID2D1CommandSink2 : ID2D1CommandSink1
{
    ///Renders the given ink object using the given brush and ink style.
    ///Params:
    ///    ink = Type: <b>ID2D1Ink*</b> The ink object to be rendered.
    ///    brush = Type: <b>ID2D1Brush*</b> The brush with which to render the ink object.
    ///    inkStyle = Type: <b>ID2D1InkStyle*</b> The ink style to use when rendering the ink object.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT DrawInk(ID2D1Ink ink, ID2D1Brush brush, ID2D1InkStyle inkStyle);
    ///Renders a given gradient mesh to the target.
    ///Params:
    ///    gradientMesh = Type: <b>ID2D1GradientMesh*</b> The gradient mesh to be rendered.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT DrawGradientMesh(ID2D1GradientMesh gradientMesh);
    ///Draws a metafile to the command sink using the given source and destination rectangles.
    ///Params:
    ///    gdiMetafile = Type: <b>ID2D1GdiMetafile*</b> The metafile to draw.
    ///    destinationRectangle = Type: <b>const D2D1_RECT_F*</b> The rectangle in the target where the metafile will be drawn, relative to the
    ///                           upper left corner (defined in DIPs). If NULL is specified, the destination rectangle is the size of the
    ///                           target.
    ///    sourceRectangle = Type: <b>const D2D1_RECT_F*</b> The rectangle of the source metafile that will be drawn, relative to the
    ///                      upper left corner (defined in DIPs). If NULL is specified, the source rectangle is the value returned by
    ///                      ID2D1GdiMetafile1::GetSourceBounds.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_RECT_F)* destinationRectangle, 
                            const(D2D_RECT_F)* sourceRectangle);
}

///This interface performs all the same functions as the existing ID2D1GdiMetafile interface. It also enables accessing
///the metafile DPI and bounds.
@GUID("2E69F9E8-DD3F-4BF9-95BA-C04F49D788DF")
interface ID2D1GdiMetafile1 : ID2D1GdiMetafile
{
    ///Gets the DPI reported by the metafile.
    ///Params:
    ///    dpiX = Type: <b>FLOAT*</b> Receives the horizontal DPI reported by the metafile.
    ///    dpiY = Type: <b>FLOAT*</b> Receives the vertical DPI reported by the metafile.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDpi(float* dpiX, float* dpiY);
    ///Gets the bounds of the metafile in source space in DIPs. This corresponds to the frame rect in an EMF/EMF+.
    ///Params:
    ///    bounds = Type: <b>D2D1_RECT_F*</b> The bounds, in DIPs, of the metafile.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK if successful, otherwise a failure HRESULT.
    ///    
    HRESULT GetSourceBounds(D2D_RECT_F* bounds);
}

///This interface performs all the same functions as the existing ID2D1GdiMetafileSink interface. It also enables access
///to metafile records.
@GUID("FD0ECB6B-91E6-411E-8655-395E760F91B4")
interface ID2D1GdiMetafileSink1 : ID2D1GdiMetafileSink
{
    ///Provides access to metafile records, including their type, data, and flags.
    ///Params:
    ///    recordType = Type: <b>DWORD</b> The type of metafile record being processed. Please see MS-EMF and MS-EMFPLUS for a list
    ///                 of record types.
    ///    recordData = Type: <b>const void*</b> The data contained in this record. Please see MS-EMF and MS-EMFPLUS for information
    ///                 on record data layouts.
    ///    recordDataSize = Type: <b>UINT</b> TThe size of the data pointed to by recordData.
    ///    flags = Type: <b>UINT32</b> The set of flags set for this record. Please see MS-EMF and MS-EMFPLUS for information on
    ///            record flags.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK if successful, otherwise a failure HRESULT.
    ///    
    HRESULT ProcessRecord(uint recordType, const(void)* recordData, uint recordDataSize, uint flags);
}

///Represents a single group of sprites with their associated drawing properties.
@GUID("4DC583BF-3A10-438A-8722-E9765224F1F1")
interface ID2D1SpriteBatch : ID2D1Resource
{
    ///Adds the given sprites to the end of this sprite batch.
    ///Params:
    ///    spriteCount = Type: <b>UINT32</b> The number of sprites to be added. This determines how many strides into each given array
    ///                  Direct2D will read.
    ///    destinationRectangles = Type: <b>const D2D1_RECT_F*</b> A pointer to an array containing the destination rectangles specifying where
    ///                            to draw the sprites on the destination device context.
    ///    sourceRectangles = Type: <b>const D2D1_RECT_U*</b> A pointer to an array containing the source rectangles specifying the regions
    ///                       of the source bitmap to draw as sprites. Direct2D will use the entire source bitmap for sprites that are
    ///                       assigned a null value or the InfiniteRectU. If this parameter is omitted entirely or set to a null value,
    ///                       then Direct2D will use the entire source bitmap for all the added sprites.
    ///    colors = Type: <b>const D2D1_COLOR_F*</b> A pointer to an array containing the colors to apply to each sprite. The
    ///             output color is the result of component-wise multiplication of the source bitmap color and the provided
    ///             color. The output color is not clamped. Direct2D will not change the color of sprites that are assigned a
    ///             null value. If this parameter is omitted entirely or set to a null value, then Direct2D will not change the
    ///             color of any of the added sprites.
    ///    transforms = Type: <b>const D2D1_MATRIX_3X2_F*</b> A pointer to an array containing the transforms to apply to each
    ///                 sprite’s destination rectangle. Direct2D will not transform the destination rectangle of any sprites that
    ///                 are assigned a null value. If this parameter is omitted entirely or set to a null value, then Direct2D will
    ///                 not transform the destination rectangle of any of the added sprites.
    ///    destinationRectanglesStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each rectangle in the destinationRectangles
    ///                                  array. If you provide a stride of 0, then the same destination rectangle will be used for each added sprite.
    ///    sourceRectanglesStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each rectangle in the sourceRectangles array
    ///                             (if that array is given). If you provide a stride of 0, then the same source rectangle will be used for each
    ///                             added sprite.
    ///    colorsStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each color in the colors array (if that array
    ///                   is given). If you provide a stride of 0, then the same color will be used for each added sprite.
    ///    transformsStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each transform in the transforms array (if that
    ///                       array is given). If you provide a stride of 0, then the same transform will be used for each added sprite.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddSprites(uint spriteCount, char* destinationRectangles, char* sourceRectangles, char* colors, 
                       char* transforms, uint destinationRectanglesStride, uint sourceRectanglesStride, 
                       uint colorsStride, uint transformsStride);
    ///Updates the properties of the specified sprites in this sprite batch.Providing a null value for any property will
    ///leave that property unmodified for that sprite.
    ///Params:
    ///    startIndex = Type: <b>UINT32</b> The index of the first sprite in this sprite batch to update.
    ///    spriteCount = Type: <b>UINT32</b> The number of sprites to update with new properties. This determines how many strides
    ///                  into each given array Direct2D will read.
    ///    destinationRectangles = Type: <b>const D2D1_RECT_F*</b> A pointer to an array containing the destination rectangles specifying where
    ///                            to draw the sprites on the destination device context.
    ///    sourceRectangles = Type: <b>const D2D1_RECT_U*</b> A pointer to an array containing the source rectangles specifying the regions
    ///                       of the source bitmap to draw as sprites. Direct2D will use the entire source bitmap for sprites that are
    ///                       assigned a null value or the InfiniteRectU. If this parameter is omitted entirely or set to a null value,
    ///                       then Direct2D will use the entire source bitmap for all the updated sprites.
    ///    colors = Type: <b>const D2D1_COLOR_F*</b> A pointer to an array containing the colors to apply to each sprite. The
    ///             output color is the result of component-wise multiplication of the source bitmap color and the provided
    ///             color. The output color is not clamped. Direct2D will not change the color of sprites that are assigned a
    ///             null value. If this parameter is omitted entirely or set to a null value, then Direct2D will not change the
    ///             color of any of the updated sprites.
    ///    transforms = Type: <b>const D2D1_MATRIX_3X2_F*</b> A pointer to an array containing the transforms to apply to each
    ///                 sprite’s destination rectangle. Direct2D will not transform the destination rectangle of any sprites that
    ///                 are assigned a null value. If this parameter is omitted entirely or set to a null value, then Direct2D will
    ///                 not transform the destination rectangle of any of the updated sprites.
    ///    destinationRectanglesStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each rectangle in the destinationRectangles
    ///                                  array. If you provide a stride of 0, then the same destination rectangle will be used for each updated
    ///                                  sprite.
    ///    sourceRectanglesStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each rectangle in the sourceRectangles array
    ///                             (if that array is given). If you provide a stride of 0, then the same source rectangle will be used for each
    ///                             updated sprite.
    ///    colorsStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each color in the colors array (if that array
    ///                   is given). If you provide a stride of 0, then the same color will be used for each updated sprite.
    ///    transformsStride = Type: <b>UINT32</b> Specifies the distance, in bytes, between each transform in the transforms array (if that
    ///                       array is given). If you provide a stride of 0, then the same transform will be used for each updated sprite.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK on success. Returns E_INVALIDARG if an invalid value was passed to the
    ///    method. In this case, no sprites are modified by this call to SetSprites.
    ///    
    HRESULT SetSprites(uint startIndex, uint spriteCount, char* destinationRectangles, char* sourceRectangles, 
                       char* colors, char* transforms, uint destinationRectanglesStride, uint sourceRectanglesStride, 
                       uint colorsStride, uint transformsStride);
    ///Retrieves the specified subset of sprites from this sprite batch. For the best performance, use nullptr for
    ///properties that you do not need to retrieve.
    ///Params:
    ///    startIndex = Type: <b>UINT32</b> The index of the first sprite in this sprite batch to retrieve.
    ///    spriteCount = Type: <b>UINT32</b> The number of sprites to retrieve.
    ///    destinationRectangles = Type: <b>D2D1_RECT_F*</b> When this method returns, contains a pointer to an array containing the destination
    ///                            rectangles for the retrieved sprites.
    ///    sourceRectangles = Type: <b>D2D1_RECT_U*</b> When this method returns, contains a pointer to an array containing the source
    ///                       rectangles for the retrieved sprites. The InfiniteRectU is returned for any sprites that were not assigned a
    ///                       source rectangle.
    ///    colors = Type: <b>D2D1_COLOR_F*</b> When this method returns, contains a pointer to an array containing the colors to
    ///             be applied to the retrieved sprites. The color {1.0f, 1.0f, 1.0f, 1.0f} is returned for any sprites that were
    ///             not assigned a color.
    ///    transforms = Type: <b>D2D1_MATRIX_3X2_F*</b> When this method returns, contains a pointer to an array containing the
    ///                 transforms to be applied to the retrieved sprites. The identity matrix is returned for any sprites that were
    ///                 not assigned a transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSprites(uint startIndex, uint spriteCount, char* destinationRectangles, char* sourceRectangles, 
                       char* colors, char* transforms);
    ///Retrieves the number of sprites in this sprite batch.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of sprites in this sprite batch
    ///    
    uint    GetSpriteCount();
    ///Removes all sprites from this sprite batch.
    void    Clear();
}

///This interface performs all the same functions as the ID2D1DeviceContext2 interface, plus it enables functionality
///for creating and drawing sprite batches.
@GUID("235A7496-8351-414C-BCD4-6672AB2D8E00")
interface ID2D1DeviceContext3 : ID2D1DeviceContext2
{
    ///Creates a new, empty sprite batch. After creating a sprite batch, use ID2D1SpriteBatch::AddSprites to add sprites
    ///to it, then use ID2D1DeviceContext3::DrawSpriteBatch to draw it.
    ///Params:
    ///    spriteBatch = Type: <b>ID2D1SpriteBatch**</b> When this method returns, contains a pointer to a new, empty sprite batch to
    ///                  be populated by the app.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateSpriteBatch(ID2D1SpriteBatch* spriteBatch);
    void    DrawSpriteBatch(ID2D1SpriteBatch spriteBatch, uint startIndex, uint spriteCount, ID2D1Bitmap bitmap, 
                            D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, D2D1_SPRITE_OPTIONS spriteOptions);
}

///Represents a resource domain whose objects and device contexts can be used together. This interface performs all the
///same functions as the ID2D1Device2 interface. It also enables the creation of ID2D1DeviceContext3 objects.
@GUID("852F2087-802C-4037-AB60-FF2E7EE6FC01")
interface ID2D1Device3 : ID2D1Device2
{
    ///Creates a new ID2D1DeviceContext3 from this Direct2D device.
    ///Params:
    ///    options = Type: <b>D2D1_DEVICE_CONTEXT_OPTIONS</b> The options to be applied to the created device context.
    ///    deviceContext3 = Type: <b>ID2D1DeviceContext3**</b> When this method returns, contains a pointer to the new device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext3* deviceContext3);
}

///Creates Direct2D resources. This interface also enables the creation of ID2D1Device3 objects.
@GUID("BD4EC2D2-0662-4BEE-BA8E-6F29F032E096")
interface ID2D1Factory4 : ID2D1Factory3
{
    ///Creates an ID2D1Device3 object.
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice*</b> The IDXGIDevice object used when creating the ID2D1Device3.
    ///    d2dDevice3 = Type: <b>ID2D1Device3**</b> The requested ID2D1Device3 object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device3* d2dDevice3);
}

///This interface performs all the same functions as the existing ID2D1CommandSink2 interface. It also enables access to
///sprite batch rendering.
@GUID("18079135-4CF3-4868-BC8E-06067E6D242D")
interface ID2D1CommandSink3 : ID2D1CommandSink2
{
    ///Renders part or all of the given sprite batch to the device context using the specified drawing options.
    ///Params:
    ///    spriteBatch = Type: <b>ID2D1SpriteBatch*</b> The sprite batch to draw.
    ///    startIndex = Type: <b>UINT32</b> The index of the first sprite in the sprite batch to draw.
    ///    spriteCount = Type: <b>UINT32</b> The number of sprites to draw.
    ///    bitmap = Type: <b>ID2D1Bitmap*</b> The bitmap from which the sprites are to be sourced. Each sprite’s source
    ///             rectangle refers to a portion of this bitmap.
    ///    interpolationMode = Type: <b>D2D1_BITMAP_INTERPOLATION_MODE</b> The interpolation mode to use when drawing this sprite batch.
    ///                        This determines how Direct2D interpolates pixels within the drawn sprites if scaling is performed.
    ///    spriteOptions = Type: <b>D2D1_SPRITE_OPTIONS</b> The additional drawing options, if any, to be used for this sprite batch.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawSpriteBatch(ID2D1SpriteBatch spriteBatch, uint startIndex, uint spriteCount, ID2D1Bitmap bitmap, 
                            D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, D2D1_SPRITE_OPTIONS spriteOptions);
}

///This object supplies the values for context-fill, context-stroke, and context-value that are used when rendering SVG
///glyphs.
@GUID("AF671749-D241-4DB8-8E41-DCC2E5C1A438")
interface ID2D1SvgGlyphStyle : ID2D1Resource
{
    ///Provides values to an SVG glyph for fill.
    ///Params:
    ///    brush = Type: <b>ID2D1Brush*</b> Describes how the area is painted. A null brush will cause the context-fill value to
    ///            come from the defaultFillBrush. If the defaultFillBrush is also null, the context-fill value will be 'none'.
    ///            To set the ‘context-fill’ value, this method uses the provided brush with its opacity set to 1. To set
    ///            the ‘context-fill-opacity’ value, this method uses the opacity of the provided brush.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetFill(ID2D1Brush brush);
    ///Returns the requested fill parameters.
    ///Params:
    ///    brush = Type: <b>ID2D1Brush**</b> Describes how the area is painted.
    void    GetFill(ID2D1Brush* brush);
    ///Provides values to an SVG glyph for stroke properties. The brush with opacity set to 1 is used as the
    ///'context-stroke'. The opacity of the brush is used as the 'context-stroke-opacity' value.
    ///Params:
    ///    brush = Type: <b>ID2D1Brush*</b> Describes how the stroke is painted. A null brush will cause the context-stroke
    ///            value to be none.
    ///    strokeWidth = Type: <b>FLOAT</b> Specifies the 'context-value' for the 'stroke-width' property.
    ///    dashes = Type: <b>const FLOAT*</b> Specifies the 'context-value' for the 'stroke-dasharray' property. A null value
    ///             will cause the stroke-dasharray to be set to 'none'.
    ///    dashesCount = Type: <b>UINT32</b> The the number of dashes in the dash array.
    ///    dashOffset = Type: <b>FLOAT</b> Specifies the 'context-value' for the 'stroke-dashoffset' property.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetStroke(ID2D1Brush brush, float strokeWidth, char* dashes, uint dashesCount, float dashOffset);
    ///Returns the number of dashes in the dash array.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of dashes in the dash array.
    ///    
    uint    GetStrokeDashesCount();
    ///Returns the requested stroke parameters. Any parameters that are non-null will receive the value of the requested
    ///parameter.
    ///Params:
    ///    brush = Type: <b>ID2D1Brush**</b> Describes how the stroke is painted.
    ///    strokeWidth = Type: <b>FLOAT*</b> The 'context-value' for the 'stroke-width' property.
    ///    dashes = Type: <b>FLOAT*</b> The 'context-value' for the 'stroke-dasharray' property.
    ///    dashesCount = Type: <b>UINT32</b> The the number of dashes in the dash array.
    ///    dashOffset = Type: <b>FLOAT*</b> The 'context-value' for the 'stroke-dashoffset' property.
    void    GetStroke(ID2D1Brush* brush, float* strokeWidth, char* dashes, uint dashesCount, float* dashOffset);
}

///This interface performs all the same functions as the ID2D1DeviceContext3 interface, plus it enables functionality
///for handling new types of color font glyphs.
@GUID("8C427831-3D90-4476-B647-C4FAE349E4DB")
interface ID2D1DeviceContext4 : ID2D1DeviceContext3
{
    ///Creates an SVG glyph style object.
    ///Params:
    ///    svgGlyphStyle = Type: <b>ID2D1SvgGlyphStyle**</b> On completion points to the created ID2D1SvgGlyphStyle object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateSvgGlyphStyle(ID2D1SvgGlyphStyle* svgGlyphStyle);
    void    DrawTextA(const(wchar)* string, uint stringLength, IDWriteTextFormat textFormat, 
                      const(D2D_RECT_F)* layoutRect, ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, 
                      uint colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS options, DWRITE_MEASURING_MODE measuringMode);
    ///Draws a text layout object. If the layout is not subsequently changed, this can be more efficient than DrawText
    ///when drawing the same layout repeatedly.
    ///Params:
    ///    origin = Type: <b>D2D1_POINT_2F</b> The point, described in device-independent pixels, at which the upper-left corner
    ///             of the text described by <i>textLayout</i> is drawn.
    ///    textLayout = Type: <b>IDWriteTextLayout*</b> The formatted text to draw. Any drawing effects that do not inherit from
    ///                 ID2D1Resource are ignored. If there are drawing effects that inherit from <b>ID2D1Resource</b> that are not
    ///                 brushes, this method fails and the render target is put in an error state.
    ///    defaultFillBrush = Type: <b>ID2D1Brush*</b> The brush used to paint the text.
    ///    svgGlyphStyle = Type: <b>ID2D1SvgGlyphStyle*</b> The values for context-fill, context-stroke, and context-value that are used
    ///                    when rendering SVG glyphs.
    ///    colorPaletteIndex = Type: <b>UINT32</b> The index used to select a color palette within a color font.
    ///    options = Type: <b>D2D1_DRAW_TEXT_OPTIONS</b> A value that indicates whether the text should be snapped to pixel
    ///              boundaries and whether the text should be clipped to the layout rectangle. The default value is
    ///              D2D1_DRAW_TEXT_OPTIONS_NONE, which indicates that text should be snapped to pixel boundaries and it should
    ///              not be clipped to the layout rectangle.
    void    DrawTextLayout(D2D_POINT_2F origin, IDWriteTextLayout textLayout, ID2D1Brush defaultFillBrush, 
                           ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS options);
    ///Draws a color bitmap glyph run using one of the bitmap formats.
    ///Params:
    ///    glyphImageFormat = Type: <b>DWRITE_GLYPH_IMAGE_FORMATS</b> Specifies the format of the glyph image. Supported formats are
    ///                       DWRITE_GLYPH_IMAGE_FORMATS_PNG, DWRITE_GLYPH_IMAGE_FORMATS_JPEG, DWRITE_GLYPH_IMAGE_FORMATS_TIFF, or
    ///                       DWRITE_GLYPH_IMAGE_FORMATS_PREMULTIPLIED_B8G8R8A8. This method will result in an error if the color glyph run
    ///                       does not contain the requested format. Only one format can be specified at a time, combinations of flags are
    ///                       not valid input.
    ///    baselineOrigin = Type: <b>D2D1_POINT_2F</b> The origin of the baseline for the glyph run.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> The glyphs to render.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> Indicates the measuring method.
    ///    bitmapSnapOption = Type: <b>D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION</b> Specifies the pixel snapping policy when rendering color
    ///                       bitmap glyphs.
    void    DrawColorBitmapGlyphRun(DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, D2D_POINT_2F baselineOrigin, 
                                    const(DWRITE_GLYPH_RUN)* glyphRun, DWRITE_MEASURING_MODE measuringMode, 
                                    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION bitmapSnapOption);
    ///Draws a color glyph run that has the format of DWRITE_GLYPH_IMAGE_FORMATS_SVG.
    ///Params:
    ///    baselineOrigin = Type: <b>D2D1_POINT_2F</b> The origin of the baseline for the glyph run.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> The glyphs to render.
    ///    defaultFillBrush = Type: <b>ID2D1Brush*</b> The brush used to paint the specified glyphs.
    ///    svgGlyphStyle = Type: <b>ID2D1SvgGlyphStyle*</b> Values for context-fill, context-stroke, and context-value that are used
    ///                    when rendering SVG glyphs.
    ///    colorPaletteIndex = Type: <b>UINT32</b> The index used to select a color palette within a color font. Note that this not the same
    ///                        as the paletteIndex in the DWRITE_COLOR_GLYPH_RUN struct, which is not relevant for SVG glyphs.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> Indicates the measuring method used for text layout.
    void    DrawSvgGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                            ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, 
                            DWRITE_MEASURING_MODE measuringMode);
    ///Retrieves an image of the color bitmap glyph from the color glyph cache. If the cache does not already contain
    ///the requested resource, it will be created. This method may be used to extend the lifetime of a glyph image even
    ///after it is evicted from the color glyph cache.
    ///Params:
    ///    glyphImageFormat = Type: <b>DWRITE_GLYPH_IMAGE_FORMATS</b> The format for the glyph image. If there is no image data in the
    ///                       requested format for the requested glyph, this method will return an error.
    ///    glyphOrigin = Type: <b>D2D1_POINT_2F</b> The origin for the glyph.
    ///    fontFace = Type: <b>IDWriteFontFace*</b> Reference to a font face which contains font face type, appropriate file
    ///               references, face identification data and various font data such as metrics, names and glyph outlines.
    ///    fontEmSize = Type: <b>FLOAT</b> The specified font size affects the choice of which bitmap to use from the font. It also
    ///                 affects the output glyphTransform, causing it to properly scale the glyph.
    ///    glyphIndex = Type: <b>UINT16</b> Index of the glyph.
    ///    isSideways = Type: <b>BOOL</b> If true, specifies that glyphs are rotated 90 degrees to the left and vertical metrics are
    ///                 used. Vertical writing is achieved by specifying isSideways as true and rotating the entire run 90 degrees to
    ///                 the right via a rotate transform.
    ///    worldTransform = Type: <b>const D2D1_MATRIX_3X2_F*</b> The transform to apply to the image. This input transform affects the
    ///                     choice of which bitmap to use from the font. It is also factored into the output glyphTransform.
    ///    dpiX = Type: <b>FLOAT</b> Dots per inch along the x-axis.
    ///    dpiY = Type: <b>FLOAT</b> Dots per inch along the y-axis.
    ///    glyphTransform = Type: <b>D2D1_MATRIX_3X2_F*</b> Output transform, which transforms from the glyph's space to the same output
    ///                     space as the worldTransform. This includes the input glyphOrigin, the glyph's offset from the glyphOrigin,
    ///                     and any other required transformations.
    ///    glyphImage = Type: <b>ID2D1Image**</b> On completion contains the retrieved glyph image.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetColorBitmapGlyphImage(DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, D2D_POINT_2F glyphOrigin, 
                                     IDWriteFontFace fontFace, float fontEmSize, ushort glyphIndex, BOOL isSideways, 
                                     const(D2D_MATRIX_3X2_F)* worldTransform, float dpiX, float dpiY, 
                                     D2D_MATRIX_3X2_F* glyphTransform, ID2D1Image* glyphImage);
    ///Retrieves an image of the SVG glyph from the color glyph cache. If the cache does not already contain the
    ///requested resource, it will be created. This method may be used to extend the lifetime of a glyph image even
    ///after it is evicted from the color glyph cache.
    ///Params:
    ///    glyphOrigin = Type: <b>D2D1_POINT_2F</b> Origin of the glyph.
    ///    fontFace = Type: <b>IDWriteFontFace*</b> Reference to a font face which contains font face type, appropriate file
    ///               references, face identification data and various font data such as metrics, names and glyph outlines.
    ///    fontEmSize = Type: <b>FLOAT</b> The specified font size affects the output glyphTransform, causing it to properly scale
    ///                 the glyph.
    ///    glyphIndex = Type: <b>UINT16</b> Index of the glyph to retrieve.
    ///    isSideways = Type: <b>BOOL</b> If true, specifies that glyphs are rotated 90 degrees to the left and vertical metrics are
    ///                 used. Vertical writing is achieved by specifying isSideways as true and rotating the entire run 90 degrees to
    ///                 the right via a rotate transform.
    ///    worldTransform = Type: <b>const D2D1_MATRIX_3X2_F*</b> The transform to apply to the image.
    ///    defaultFillBrush = Type: <b>ID2D1Brush*</b> Describes how the area is painted.
    ///    svgGlyphStyle = Type: <b>ID2D1SvgGlyphStyle*</b> The values for context-fill, context-stroke, and context-value that are used
    ///                    when rendering SVG glyphs.
    ///    colorPaletteIndex = Type: <b>UINT32</b> The index used to select a color palette within a color font. Note that this not the same
    ///                        as the paletteIndex in the DWRITE_COLOR_GLYPH_RUN struct, which is not relevant for SVG glyphs.
    ///    glyphTransform = Type: <b>D2D1_MATRIX_3X2_F*</b> Output transform, which transforms from the glyph's space to the same output
    ///                     space as the worldTransform. This includes the input glyphOrigin, the glyph's offset from the glyphOrigin,
    ///                     and any other required transformations.
    ///    glyphImage = Type: <b>ID2D1CommandList**</b> On completion, contains the retrieved glyph image.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetSvgGlyphImage(D2D_POINT_2F glyphOrigin, IDWriteFontFace fontFace, float fontEmSize, 
                             ushort glyphIndex, BOOL isSideways, const(D2D_MATRIX_3X2_F)* worldTransform, 
                             ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, 
                             D2D_MATRIX_3X2_F* glyphTransform, ID2D1CommandList* glyphImage);
}

///Represents a resource domain whose objects and device contexts can be used together. This interface performs all the
///same functions as the ID2D1Device3 interface. It also enables the creation of ID2D1DeviceContext4 objects.
@GUID("D7BDB159-5683-4A46-BC9C-72DC720B858B")
interface ID2D1Device4 : ID2D1Device3
{
    ///Creates a new ID2D1DeviceContext4 from this Direct2D device.
    ///Params:
    ///    options = Type: <b>D2D1_DEVICE_CONTEXT_OPTIONS</b> The options to be applied to the created device context.
    ///    deviceContext4 = Type: <b>ID2D1DeviceContext4**</b> When this method returns, contains a pointer to the new device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b>
    ///    error code.
    ///    
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext4* deviceContext4);
    ///Sets the maximum capacity of the color glyph cache.
    ///Params:
    ///    maximumInBytes = Type: <b>UINT64</b> The maximum capacity of the color glyph cache.
    void    SetMaximumColorGlyphCacheMemory(ulong maximumInBytes);
    ///Gets the maximum capacity of the color glyph cache.
    ///Returns:
    ///    Type: <b>UINT64</b> Returns the maximum capacity of the color glyph cache in bytes.
    ///    
    ulong   GetMaximumColorGlyphCacheMemory();
}

///Creates Direct2D resources. This interface also enables the creation of ID2D1Device4 objects.
@GUID("C4349994-838E-4B0F-8CAB-44997D9EEACC")
interface ID2D1Factory5 : ID2D1Factory4
{
    ///Creates an ID2D1Device4 object.
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice*</b> The IDXGIDevice object used when creating the ID2D1Device4.
    ///    d2dDevice4 = Type: <b>ID2D1Device4**</b> The requested ID2D1Device4 object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device4* d2dDevice4);
}

///This interface performs all the same functions as the existing ID2D1CommandSink3 interface. It also enables access to
///the new primitive blend mode, MAX, through the SetPrimitiveBlend2 method.
@GUID("C78A6519-40D6-4218-B2DE-BEEEB744BB3E")
interface ID2D1CommandSink4 : ID2D1CommandSink3
{
    ///Sets a new primitive blend mode. Allows access to the MAX primitive blend mode.
    ///Params:
    ///    primitiveBlend = Type: <b>D2D1_PRIMITIVE_BLEND</b> The primitive blend that will apply to subsequent primitives.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, it returns S_OK. If it fails, it returns an HRESULT error code.
    ///    
    HRESULT SetPrimitiveBlend2(D2D1_PRIMITIVE_BLEND primitiveBlend);
}

///Represents a color context to be used with the Color Management Effect.
@GUID("1AB42875-C57F-4BE9-BD85-9CD78D6F55EE")
interface ID2D1ColorContext1 : ID2D1ColorContext
{
    ///Retrieves the color context type.
    ///Returns:
    ///    Type: <b>D2D1_COLOR_CONTEXT_TYPE</b> This method returns color context type.
    ///    
    D2D1_COLOR_CONTEXT_TYPE GetColorContextType();
    ///Retrieves the DXGI color space of this context. Returns DXGI_COLOR_SPACE_CUSTOM when color context type is ICC.
    ///Returns:
    ///    Type: <b>DXGI_COLOR_SPACE_TYPE</b> This method returns the DXGI color space of this context.
    ///    
    DXGI_COLOR_SPACE_TYPE GetDXGIColorSpace();
    ///Retrieves a set simple color profile.
    ///Params:
    ///    simpleProfile = Type: <b>D2D1_SIMPLE_COLOR_PROFILE*</b> Pointer to a D2D1_SIMPLE_COLOR_PROFILE that will contain the simple
    ///                    color profile when the method returns.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetSimpleColorProfile(D2D1_SIMPLE_COLOR_PROFILE* simpleProfile);
}

///This interface performs all the same functions as the ID2D1DeviceContext4 interface, plus it enables the creation of
///color contexts and Svg documents.
@GUID("7836D248-68CC-4DF6-B9E8-DE991BF62EB7")
interface ID2D1DeviceContext5 : ID2D1DeviceContext4
{
    ///Creates an SVG document from a stream.
    ///Params:
    ///    inputXmlStream = Type: <b>IStream*</b> An input stream containing the SVG XML document. If null, an empty document is created.
    ///    viewportSize = Type: <b>D2D1_SIZE_F</b> Size of the initial viewport of the document.
    ///    svgDocument = Type: <b>ID2D1SvgDocument**</b> When this method returns, contains a pointer to the created SVG document.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateSvgDocument(IStream inputXmlStream, D2D_SIZE_F viewportSize, ID2D1SvgDocument* svgDocument);
    ///Draws an SVG document.
    ///Params:
    ///    svgDocument = Type: <b>ID2D1SvgDocument*</b> The SVG document to draw.
    void    DrawSvgDocument(ID2D1SvgDocument svgDocument);
    ///Creates a color context from a DXGI color space type. It is only valid to use this with the Color Management
    ///Effect in 'Best' mode.
    ///Params:
    ///    colorSpace = Type: <b>DXGI_COLOR_SPACE_TYPE</b> The color space to create the color context from.
    ///    colorContext = Type: <b>ID2D1ColorContext1**</b> The created color context.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateColorContextFromDxgiColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace, 
                                                 ID2D1ColorContext1* colorContext);
    HRESULT CreateColorContextFromSimpleColorProfile(const(D2D1_SIMPLE_COLOR_PROFILE)* simpleProfile, 
                                                     ID2D1ColorContext1* colorContext);
}

///Represents a resource domain whose objects and device contexts can be used together. This interface performs all the
///same functions as the ID2D1Device4 interface. It also enables the creation of ID2D1DeviceContext5 objects.
@GUID("D55BA0A4-6405-4694-AEF5-08EE1A4358B4")
interface ID2D1Device5 : ID2D1Device4
{
    ///Creates a new device context with no initially assigned target.
    ///Params:
    ///    options = Type: <b>D2D1_DEVICE_CONTEXT_OPTIONS</b> Options for creating the device context.
    ///    deviceContext5 = Type: <b>ID2D1DeviceContext5**</b> The created device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext5* deviceContext5);
}

///Creates Direct2D resources. This interface also enables the creation of ID2D1Device5 objects.
@GUID("F9976F46-F642-44C1-97CA-DA32EA2A2635")
interface ID2D1Factory6 : ID2D1Factory5
{
    ///Creates a new Direct2D device from the given IDXGIDevice.
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice*</b> The IDXGIDevice to create the Direct2D device from.
    ///    d2dDevice5 = Type: <b>ID2D1Device5**</b> The created device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device5* d2dDevice5);
}

///This interface performs all the same functions as the existing ID2D1CommandSink4 interface, plus it enables access to
///the BlendImage method.
@GUID("7047DD26-B1E7-44A7-959A-8349E2144FA8")
interface ID2D1CommandSink5 : ID2D1CommandSink4
{
    ///Draws an image to the device context using the specified blend mode. Results are equivalent to using Direct2D's
    ///built-in Blend effect.
    ///Params:
    ///    image = Type: <b>ID2D1Image*</b> The image to be drawn to the device context.
    ///    blendMode = Type: <b>D2D1_BLEND_MODE</b> The blend mode to be used. See Blend modes for more info.
    ///    targetOffset = Type: <b>const D2D1_POINT_2F*</b> The offset in the destination space that the image will be rendered to. The
    ///                   entire logical extent of the image will be rendered to the corresponding destination. If not specified, the
    ///                   destination origin will be (0, 0). The top-left corner of the image will be mapped to the target offset. This
    ///                   will not necessarily be the origin. The default value is NULL.
    ///    imageRectangle = Type: <b>const D2D1_RECT_F*</b> The corresponding rectangle in the image space will be mapped to the given
    ///                     origins when processing the image. The default value is NULL.
    ///    interpolationMode = Type: <b>D2D1_INTERPOLATION_MODE</b> The interpolation mode that will be used to scale the image if
    ///                        necessary. The default value is D2D1_INTERPOLATION_MODE_LINEAR.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT BlendImage(ID2D1Image image, D2D1_BLEND_MODE blendMode, const(D2D_POINT_2F)* targetOffset, 
                       const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode);
}

///This interface performs all the same functions as the existing ID2D1DeviceContext5 interface, plus it enables access
///to the BlendImage method.
@GUID("985F7E37-4ED0-4A19-98A3-15B0EDFDE306")
interface ID2D1DeviceContext6 : ID2D1DeviceContext5
{
    ///Draws an image to the device context using the specified blend mode. Results are equivalent to using Direct2D's
    ///built-in Blend effect.
    ///Params:
    ///    image = Type: <b>ID2D1Image*</b> The image to be drawn to the device context.
    ///    blendMode = Type: <b>D2D1_BLEND_MODE</b> The blend mode to be used. See Blend modes for more info.
    ///    targetOffset = Type: <b>const D2D1_POINT_2F*</b> The offset in the destination space that the image will be rendered to. The
    ///                   entire logical extent of the image will be rendered to the corresponding destination. If not specified, the
    ///                   destination origin will be (0, 0). The top-left corner of the image will be mapped to the target offset. This
    ///                   will not necessarily be the origin. The default value is NULL.
    ///    imageRectangle = Type: <b>const D2D1_RECT_F*</b> The corresponding rectangle in the image space will be mapped to the given
    ///                     origins when processing the image. The default value is NULL.
    ///    interpolationMode = Type: <b>D2D1_INTERPOLATION_MODE</b> The interpolation mode that will be used to scale the image if
    ///                        necessary. The default value is D2D1_INTERPOLATION_MODE_LINEAR.
    void BlendImage(ID2D1Image image, D2D1_BLEND_MODE blendMode, const(D2D_POINT_2F)* targetOffset, 
                    const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode);
}

///Represents a resource domain whose objects and device contexts can be used together. This interface performs all the
///same functions as the ID2D1Device5 interface, plus it enables the creation of ID2D1DeviceContext6 objects.
@GUID("7BFEF914-2D75-4BAD-BE87-E18DDB077B6D")
interface ID2D1Device6 : ID2D1Device5
{
    ///Creates a new device context with no initially assigned target.
    ///Params:
    ///    options = Type: <b>D2D1_DEVICE_CONTEXT_OPTIONS</b> Options for creating the device context.
    ///    deviceContext6 = Type: <b>ID2D1DeviceContext6**</b> The created device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext6* deviceContext6);
}

///Creates Direct2D resources. This interface performs all the same functions as the ID2D1Factory6 interface, plus it
///enables the creation of ID2D1Device6 objects.
@GUID("BDC2BDD3-B96C-4DE6-BDF7-99D4745454DE")
interface ID2D1Factory7 : ID2D1Factory6
{
    ///Creates a new Direct2D device from the given IDXGIDevice
    ///Params:
    ///    dxgiDevice = Type: <b>IDXGIDevice*</b> The IDXGIDevice from which to create the Direct2D device.
    ///    d2dDevice6 = Type: <b>ID2D1Device6**</b> The created device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device6* d2dDevice6);
}

///Provides factory methods and other state management for effect and transform authors.
@GUID("84AB595A-FC81-4546-BACD-E8EF4D8ABE7A")
interface ID2D1EffectContext1 : ID2D1EffectContext
{
    ///Creates a 3D lookup table for mapping a 3-channel input to a 3-channel output. The table data must be provided in
    ///4-channel format.
    ///Params:
    ///    precision = Type: <b>D2D1_BUFFER_PRECISION</b> Precision of the input lookup table data.
    ///    extents = Type: <b>const UINT32*</b> Number of lookup table elements per dimension (X, Y, Z).
    ///    data = Type: <b>const BYTE*</b> Buffer holding the lookup table data.
    ///    dataCount = Type: <b>UINT32</b> Size of the lookup table data buffer.
    ///    strides = Type: <b>const UINT32*</b> An array containing two values. The first value is the size in bytes from one row
    ///              (X dimension) of LUT data to the next. The second value is the size in bytes from one LUT data plane (X and Y
    ///              dimensions) to the next.
    ///    lookupTable = Type: <b>ID2D1LookupTable3D**</b> Receives the new lookup table instance.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateLookupTable3D(D2D1_BUFFER_PRECISION precision, char* extents, char* data, uint dataCount, 
                                char* strides, ID2D1LookupTable3D* lookupTable);
}

@GUID("577AD2A0-9FC7-4DDA-8B18-DAB810140052")
interface ID2D1EffectContext2 : ID2D1EffectContext1
{
    HRESULT CreateColorContextFromDxgiColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace, 
                                                 ID2D1ColorContext1* colorContext);
    HRESULT CreateColorContextFromSimpleColorProfile(const(D2D1_SIMPLE_COLOR_PROFILE)* simpleProfile, 
                                                     ID2D1ColorContext1* colorContext);
}

///Applications use the methods of the IDirect3D9 interface to create Microsoft Direct3D objects and set up the
///environment. This interface includes methods for enumerating and retrieving capabilities of the device.
@GUID("81BDCBCA-64D4-426D-AE8D-AD0147F4275C")
interface IDirect3D9 : IUnknown
{
    ///Registers a pluggable software device. Software devices provide software rasterization enabling applications to
    ///access a variety of software rasterizers.
    ///Params:
    ///    pInitializeFunction = Type: <b>void*</b> Pointer to the initialization function for the software device to be registered.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL. The method call is invalid. For example, a method's
    ///    parameter may have an invalid value: D3DERR_OUTOFVIDEOMEMORY.
    ///    
    HRESULT RegisterSoftwareDevice(void* pInitializeFunction);
    ///Returns the number of adapters on the system.
    ///Returns:
    ///    Type: <b>UINT</b> A UINT value that denotes the number of adapters on the system at the time this IDirect3D9
    ///    interface was instantiated.
    ///    
    uint    GetAdapterCount();
    ///Describes the physical display adapters present in the system when the IDirect3D9 interface was instantiated.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter. The minimum value for this parameter is 0, and the maximum value for this parameter is one
    ///              less than the value returned by GetAdapterCount.
    ///    Flags = Type: <b>DWORD</b> Flags sets the <b>WHQLLevel</b> member of D3DADAPTER_IDENTIFIER9. Flags can be set to
    ///            either 0 or D3DENUM_WHQL_LEVEL. If D3DENUM_WHQL_LEVEL is specified, this call can connect to the Internet to
    ///            download new Microsoft Windows Hardware Quality Labs (WHQL) certificates. Differences between Direct3D 9 and
    ///            Direct3D 9Ex: D3DENUM_WHQL_LEVEL is deprecated for Direct3D9Ex running on Windows Vista, Windows Server 2008,
    ///            Windows 7, and Windows Server 2008 R2 (or more current operating system). Any of these operating systems
    ///            return 1 in the <b>WHQLLevel</b> member of D3DADAPTER_IDENTIFIER9 without checking the status of the driver.
    ///    pIdentifier = Type: <b>D3DADAPTER_IDENTIFIER9*</b> Pointer to a D3DADAPTER_IDENTIFIER9 structure to be filled with
    ///                  information describing this adapter. If <i>Adapter</i> is greater than or equal to the number of adapters in
    ///                  the system, this structure will be zeroed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    Adapter is out of range, if Flags contains unrecognized parameters, or if pIdentifier is <b>NULL</b> or
    ///    points to unwriteable memory.
    ///    
    HRESULT GetAdapterIdentifier(uint Adapter, uint Flags, D3DADAPTER_IDENTIFIER9* pIdentifier);
    ///Returns the number of display modes available on this adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    Format = Type: <b>D3DFORMAT</b> Identifies the format of the surface type using D3DFORMAT. Use EnumAdapterModes to see
    ///             the valid formats.
    ///Returns:
    ///    Type: <b>UINT</b> This method returns the number of display modes on this adapter or zero if Adapter is
    ///    greater than or equal to the number of adapters on the system.
    ///    
    uint    GetAdapterModeCount(uint Adapter, D3DFORMAT Format);
    ///Queries the device to determine whether the specified adapter supports the requested format and display mode.
    ///This method could be used in a loop to enumerate all the available adapter modes.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to enumerate. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///              of display adapters in the system.
    ///    Format = Type: <b>D3DFORMAT</b> Allowable pixel formats. See Remarks.
    ///    Mode = Type: <b>UINT</b> Represents the display-mode index which is an unsigned integer between zero and the value
    ///           returned by GetAdapterModeCount minus one.
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> A pointer to the available display mode of type D3DDISPLAYMODE. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> <ul> <li>If the device can be used on this adapter, D3D_OK is returned.</li> <li>If the
    ///    Adapter equals or exceeds the number of display adapters in the system, D3DERR_INVALIDCALL is returned.</li>
    ///    <li>If either surface format is not supported or if hardware acceleration is not available for the specified
    ///    formats, D3DERR_NOTAVAILABLE is returned.</li> </ul>
    ///    
    HRESULT EnumAdapterModes(uint Adapter, D3DFORMAT Format, uint Mode, D3DDISPLAYMODE* pMode);
    ///Retrieves the current display mode of the adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter.
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> Pointer to a D3DDISPLAYMODE structure, to be filled with information describing
    ///            the current adapter's mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If Adapter is out of range or pMode
    ///    is invalid, this method returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetAdapterDisplayMode(uint Adapter, D3DDISPLAYMODE* pMode);
    ///Verifies whether a hardware accelerated device type can be used on this adapter.
    ///Params:
    ///    iAdapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to enumerate. D3DADAPTER_DEFAULT is always the
    ///               primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///               of display adapters in the system.
    ///    DevType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, indicating the device type to check.
    ///    DisplayFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, indicating the format of the adapter display
    ///                    mode for which the device type is to be checked. For example, some devices will operate only in
    ///                    16-bits-per-pixel modes.
    ///    BackBufferFormat = Type: <b>D3DFORMAT</b> Back buffer format. For more information about formats, see D3DFORMAT. This value must
    ///                       be one of the render-target formats. You can use GetAdapterDisplayMode to obtain the current format. For
    ///                       windowed applications, the back buffer format does not need to match the display mode format if the hardware
    ///                       supports color conversion. The set of possible back buffer formats is constrained, but the runtime will allow
    ///                       any valid back buffer format to be presented to any desktop format. There is the additional requirement that
    ///                       the device be operable in the desktop because devices typically do not operate in 8 bits per pixel modes.
    ///                       Full-screen applications cannot do color conversion. D3DFMT_UNKNOWN is allowed for windowed mode.
    ///    bWindowed = Type: <b>BOOL</b> Value indicating whether the device type will be used in full-screen or windowed mode. If
    ///                set to <b>TRUE</b>, the query is performed for windowed applications; otherwise, this value should be set
    ///                <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the device can be used on this adapter, D3D_OK is returned. D3DERR_INVALIDCALL is
    ///    returned if Adapter equals or exceeds the number of display adapters in the system. D3DERR_INVALIDCALL is
    ///    also returned if <b>CheckDeviceType</b> specified a device that does not exist. D3DERR_NOTAVAILABLE is
    ///    returned if the requested back buffer format is not supported, or if hardware acceleration is not available
    ///    for the specified formats.
    ///    
    HRESULT CheckDeviceType(uint Adapter, D3DDEVTYPE DevType, D3DFORMAT AdapterFormat, D3DFORMAT BackBufferFormat, 
                            BOOL bWindowed);
    ///Determines whether a surface format is available as a specified resource type and can be used as a texture,
    ///depth-stencil buffer, or render target, or any combination of the three, on a device representing this adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///              of display adapters in the system.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, identifying the device type.
    ///    AdapterFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the display mode
    ///                    into which the adapter will be placed.
    ///    Usage = Type: <b>DWORD</b> Requested usage options for the surface. Usage options are any combination of D3DUSAGE and
    ///            D3DUSAGE_QUERY constants (only a subset of the D3DUSAGE constants are valid for <b>CheckDeviceFormat</b>; see
    ///            the table on the D3DUSAGE page).
    ///    RType = Type: <b>D3DRESOURCETYPE</b> Resource type requested for use with the queried format. Member of
    ///            D3DRESOURCETYPE.
    ///    CheckFormat = Type: <b>D3DFORMAT</b> Format of the surfaces which may be used, as defined by Usage. Member of D3DFORMAT.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the format is compatible with the specified device for the requested usage, this
    ///    method returns D3D_OK. D3DERR_INVALIDCALL is returned if Adapter equals or exceeds the number of display
    ///    adapters in the system, or if DeviceType is unsupported. D3DERR_NOTAVAILABLE is returned if the format is not
    ///    acceptable to the device for this usage.
    ///    
    HRESULT CheckDeviceFormat(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, uint Usage, 
                              D3DRESOURCETYPE RType, D3DFORMAT CheckFormat);
    ///Determines if a multisampling technique is available on this device.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns <b>FALSE</b> when this value equals or exceeds the number of
    ///              display adapters in the system. See Remarks.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, identifying the device type.
    ///    SurfaceFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type that specifies the format of the surface to be
    ///                    multisampled. For more information, see Remarks.
    ///    Windowed = Type: <b>BOOL</b> bool value. Specify <b>TRUE</b> to inquire about windowed multisampling, and specify
    ///               <b>FALSE</b> to inquire about full-screen multisampling.
    ///    MultiSampleType = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, identifying the
    ///                      multisampling technique to test.
    ///    pQualityLevels = Type: <b>DWORD*</b> <b>pQualityLevels</b> returns the number of device-specific sampling variations available
    ///                     with the given sample type. For example, if the returned value is 3, then quality levels 0, 1 and 2 can be
    ///                     used when creating resources with the given sample count. The meanings of these quality levels are defined by
    ///                     the device manufacturer and cannot be queried through D3D. For example, for a particular device different
    ///                     quality levels at a fixed sample count might refer to different spatial layouts of the sample locations or
    ///                     different methods of resolving. This can be <b>NULL</b> if it is not necessary to return the quality levels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the device can perform the specified multisampling method, this method returns
    ///    D3D_OK. D3DERR_INVALIDCALL is returned if the Adapter or MultiSampleType parameters are invalid. This method
    ///    returns D3DERR_NOTAVAILABLE if the queried multisampling technique is not supported by this device.
    ///    D3DERR_INVALIDDEVICE is returned if DeviceType does not apply to this adapter.
    ///    
    HRESULT CheckDeviceMultiSampleType(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SurfaceFormat, BOOL Windowed, 
                                       D3DMULTISAMPLE_TYPE MultiSampleType, uint* pQualityLevels);
    ///Determines whether a depth-stencil format is compatible with a render-target format in a particular display mode.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type, identifying the device type.
    ///    AdapterFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the display mode
    ///                    into which the adapter will be placed.
    ///    RenderTargetFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the render-target
    ///                         surface to be tested.
    ///    DepthStencilFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, identifying the format of the depth-stencil
    ///                         surface to be tested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the depth-stencil format is compatible with the render-target format in the display
    ///    mode, this method returns D3D_OK. D3DERR_INVALIDCALL can be returned if one or more of the parameters is
    ///    invalid. If a depth-stencil format is not compatible with the render target in the display mode, then this
    ///    method returns D3DERR_NOTAVAILABLE.
    ///    
    HRESULT CheckDepthStencilMatch(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, 
                                   D3DFORMAT RenderTargetFormat, D3DFORMAT DepthStencilFormat);
    ///Tests the device to see if it supports conversion from one display format to another.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Display adapter ordinal number. D3DADAPTER_DEFAULT is always the primary display adapter.
    ///              This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number of display adapters in
    ///              the system.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Device type. Member of the D3DDEVTYPE enumerated type.
    ///    SourceFormat = Type: <b>D3DFORMAT</b> Source adapter format. Member of the D3DFORMAT enumerated type.
    ///    TargetFormat = Type: <b>D3DFORMAT</b> Target adapter format. Member of the D3DFORMAT enumerated type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value is D3DERR_INVALIDCALL. The method will return D3DERR_NOTAVAILABLE when the hardware does not support
    ///    conversion between the two formats.
    ///    
    HRESULT CheckDeviceFormatConversion(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SourceFormat, 
                                        D3DFORMAT TargetFormat);
    ///Retrieves device-specific information about a device.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type. Denotes the device type.
    ///    pCaps = Type: <b>D3DCAPS9*</b> Pointer to a D3DCAPS9 structure to be filled with information describing the
    ///            capabilities of the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_INVALIDDEVICE, D3DERR_OUTOFVIDEOMEMORY, and
    ///    D3DERR_NOTAVAILABLE.
    ///    
    HRESULT GetDeviceCaps(uint Adapter, D3DDEVTYPE DeviceType, D3DCAPS9* pCaps);
    ///Returns the handle of the monitor associated with the Direct3D object.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///Returns:
    ///    Type: <b>HMONITOR</b> Handle of the monitor associated with the Direct3D object.
    ///    
    ptrdiff_t GetAdapterMonitor(uint Adapter);
    ///Creates a device to represent the display adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Member of the D3DDEVTYPE enumerated type that denotes the desired device type. If the
    ///                 desired device type is not available, the method will fail.
    ///    hFocusWindow = Type: <b>HWND</b> The focus window alerts Direct3D when an application switches from foreground mode to
    ///                   background mode. See Remarks. <ul> <li>For full-screen mode, the window specified must be a top-level
    ///                   window.</li> <li>For windowed mode, this parameter may be <b>NULL</b> only if the hDeviceWindow member of
    ///                   <i>pPresentationParameters</i> is set to a valid, non-<b>NULL</b> value.</li> </ul>
    ///    BehaviorFlags = Type: <b>DWORD</b> Combination of one or more options that control device creation. For more information, see
    ///                    D3DCREATE.
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the presentation
    ///                              parameters for the device to be created. If BehaviorFlags specifies D3DCREATE_ADAPTERGROUP_DEVICE,
    ///                              pPresentationParameters is an array. Regardless of the number of heads that exist, only one depth/stencil
    ///                              surface is automatically created. For Windows 2000 and Windows XP, the full-screen device display refresh
    ///                              rate is set in the following order: <ol> <li>User-specified nonzero ForcedRefreshRate registry key, if
    ///                              supported by the device.</li> <li>Application-specified nonzero refresh rate value in the presentation
    ///                              parameter.</li> <li>Refresh rate of the latest desktop, if supported by the device.</li> <li>75 hertz if
    ///                              supported by the device.</li> <li>60 hertz if supported by the device.</li> <li>Device default.</li> </ol> An
    ///                              unsupported refresh rate will default to the closest supported refresh rate below it. For example, if the
    ///                              application specifies 63 hertz, 60 hertz will be used. There are no supported refresh rates below 57 hertz.
    ///                              pPresentationParameters is both an input and an output parameter. Calling this method may change several
    ///                              members including: <ul> <li>If BackBufferCount, BackBufferWidth, and BackBufferHeight are 0 before the method
    ///                              is called, they will be changed when the method returns.</li> <li>If BackBufferFormat equals D3DFMT_UNKNOWN
    ///                              before the method is called, it will be changed when the method returns.</li> </ul>
    ///    ppReturnedDeviceInterface = Type: <b>IDirect3DDevice9**</b> Address of a pointer to the returned IDirect3DDevice9 interface, which
    ///                                represents the created device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DEVICELOST, D3DERR_INVALIDCALL, D3DERR_NOTAVAILABLE,
    ///    D3DERR_OUTOFVIDEOMEMORY.
    ///    
    HRESULT CreateDevice(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, 
                         _D3DPRESENT_PARAMETERS_* pPresentationParameters, 
                         IDirect3DDevice9* ppReturnedDeviceInterface);
}

///Applications use the methods of the IDirect3DDevice9 interface to perform DrawPrimitive-based rendering, create
///resources, work with system-level variables, adjust gamma ramp levels, work with palettes, and create shaders.
@GUID("D0223B96-BF7A-43FD-92BD-A43B0D82B9EB")
interface IDirect3DDevice9 : IUnknown
{
    ///Reports the current cooperative-level status of the Direct3D device for a windowed or full-screen application.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK, indicating that the device is
    ///    operational and the calling application can continue. If the method fails, the return value can be one of the
    ///    following values: D3DERR_DEVICELOST, D3DERR_DEVICENOTRESET, D3DERR_DRIVERINTERNALERROR.
    ///    
    HRESULT TestCooperativeLevel();
    ///Returns an estimate of the amount of available texture memory.
    ///Returns:
    ///    Type: <b>UINT</b> The function returns an estimate of the available texture memory.
    ///    
    uint    GetAvailableTextureMem();
    ///Evicts all managed resources, including both Direct3D and driver-managed resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_OUTOFVIDEOMEMORY, D3DERR_COMMAND_UNPARSED.
    ///    
    HRESULT EvictManagedResources();
    ///Returns an interface to the instance of the Direct3D object that created the device.
    ///Params:
    ///    ppD3D9 = Type: <b>IDirect3D9**</b> Address of a pointer to an IDirect3D9 interface, representing the interface of the
    ///             Direct3D object that created the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDirect3D(IDirect3D9* ppD3D9);
    ///Retrieves the capabilities of the rendering device.
    ///Params:
    ///    pCaps = Type: <b>D3DCAPS9*</b> Pointer to a D3DCAPS9 structure, describing the returned device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDeviceCaps(D3DCAPS9* pCaps);
    ///Retrieves the display mode's spatial resolution, color resolution, and refresh frequency.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> Pointer to a D3DDISPLAYMODE structure containing data about the display mode of
    ///            the adapter. As opposed to the display mode of the device, which may not be active if the device does not own
    ///            full-screen mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayMode(uint iSwapChain, D3DDISPLAYMODE* pMode);
    ///Retrieves the creation parameters of the device.
    ///Params:
    ///    pParameters = Type: <b>D3DDEVICE_CREATION_PARAMETERS*</b> Pointer to a D3DDEVICE_CREATION_PARAMETERS structure, describing
    ///                  the creation parameters of the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetCreationParameters(D3DDEVICE_CREATION_PARAMETERS* pParameters);
    ///Sets properties for the cursor.
    ///Params:
    ///    XHotSpot = Type: <b>UINT</b> X-coordinate offset (in pixels) that marks the center of the cursor. The offset is relative
    ///               to the upper-left corner of the cursor. When the cursor is given a new position, the image is drawn at an
    ///               offset from this new position determined by subtracting the hot spot coordinates from the position.
    ///    YHotSpot = Type: <b>UINT</b> Y-coordinate offset (in pixels) that marks the center of the cursor. The offset is relative
    ///               to the upper-left corner of the cursor. When the cursor is given a new position, the image is drawn at an
    ///               offset from this new position determined by subtracting the hot spot coordinates from the position.
    ///    pCursorBitmap = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface. This parameter must point to an
    ///                    8888 ARGB surface (format D3DFMT_A8R8G8B8). The contents of this surface will be copied and potentially
    ///                    format-converted into an internal buffer from which the cursor is displayed. The dimensions of this surface
    ///                    must be less than the dimensions of the display mode, and must be a power of two in each direction, although
    ///                    not necessarily the same power of two. The alpha channel must be either 0.0 or 1.0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetCursorProperties(uint XHotSpot, uint YHotSpot, IDirect3DSurface9 pCursorBitmap);
    ///Sets the cursor position and update options.
    ///Params:
    ///    X = Type: <b>INT</b> The new X-position of the cursor in virtual desktop coordinates. See Remarks.
    ///    Y = Type: <b>INT</b> The new Y-position of the cursor in virtual desktop coordinates. See Remarks.
    ///    Flags = Type: <b>DWORD</b> Specifies the update options for the cursor. Currently, only one flag is defined. <table>
    ///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="D3DCURSOR_IMMEDIATE_UPDATE"></a><a
    ///            id="d3dcursor_immediate_update"></a><dl> <dt><b>D3DCURSOR_IMMEDIATE_UPDATE</b></dt> </dl> </td> <td
    ///            width="60%"> Update cursor at the refresh rate. If this flag is specified, the system guarantees that the
    ///            cursor will be updated at a minimum of half the display refresh rate, but never more frequently than the
    ///            display refresh rate. Otherwise, the method delays cursor updates until the next IDirect3DDevice9::Present
    ///            call. Not setting this flag usually results in better performance than if the flag is set. However,
    ///            applications should set this flag if the rate of calls to Present is low enough that users would notice a
    ///            significant delay in cursor motion. This flag has no effect in a windowed-mode application. Some video cards
    ///            implement hardware color cursors. This flag does not have an effect on these cards. </td> </tr> </table>
    void    SetCursorPosition(int X, int Y, uint Flags);
    ///Displays or hides the cursor.
    ///Params:
    ///    bShow = Type: <b>BOOL</b> If bShow is <b>TRUE</b>, the cursor is shown. If bShow is <b>FALSE</b>, the cursor is
    ///            hidden.
    ///Returns:
    ///    Type: <b>BOOL</b> Value indicating whether the cursor was previously visible. <b>TRUE</b> if the cursor was
    ///    previously visible, or <b>FALSE</b> if the cursor was not previously visible.
    ///    
    BOOL    ShowCursor(BOOL bShow);
    ///Creates an additional swap chain for rendering multiple views.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, containing the presentation
    ///                              parameters for the new swap chain. This value cannot be <b>NULL</b>. Calling this method changes the value of
    ///                              members of the D3DPRESENT_PARAMETERS structure. <ul> <li>If BackBufferCount == 0, calling
    ///                              CreateAdditionalSwapChain will increase it to 1.</li> <li>If the application is in windowed mode, and if
    ///                              either the BackBufferWidth or the BackBufferHeight == 0, they will be set to the client area width and height
    ///                              of the hwnd.</li> </ul>
    ///    pSwapChain = Type: <b>IDirect3DSwapChain9**</b> Address of a pointer to an IDirect3DSwapChain9 interface, representing the
    ///                 additional swap chain.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_DEVICELOST, D3DERR_INVALIDCALL,
    ///    D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateAdditionalSwapChain(_D3DPRESENT_PARAMETERS_* pPresentationParameters, 
                                      IDirect3DSwapChain9* pSwapChain);
    ///Gets a pointer to a swap chain.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> The swap chain ordinal value. For more information, see NumberOfAdaptersInGroup in
    ///                 D3DCAPS9.
    ///    pSwapChain = Type: <b>IDirect3DSwapChain9**</b> Pointer to an IDirect3DSwapChain9 interface that will receive a copy of
    ///                 swap chain.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetSwapChain(uint iSwapChain, IDirect3DSwapChain9* pSwapChain);
    ///Gets the number of implicit swap chains.
    ///Returns:
    ///    Type: <b>UINT</b> Number of implicit swap chains. See Remarks.
    ///    
    uint    GetNumberOfSwapChains();
    ///Resets the type, size, and format of the swap chain.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the new
    ///                              presentation parameters. This value cannot be <b>NULL</b>. When switching to full-screen mode, Direct3D will
    ///                              try to find a desktop format that matches the back buffer format, so that back buffer and front buffer
    ///                              formats will be identical (to eliminate the need for color conversion). When this method returns: <ul>
    ///                              <li>BackBufferCount, BackBufferWidth, and BackBufferHeight are set to zero.</li> <li>BackBufferFormat is set
    ///                              to D3DFMT_UNKNOWN for windowed mode only; a full-screen mode must specify a format.</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_DEVICELOST, D3DERR_DEVICEREMOVED,
    ///    D3DERR_DRIVERINTERNALERROR, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR).
    ///    
    HRESULT Reset(_D3DPRESENT_PARAMETERS_* pPresentationParameters);
    ///Presents the contents of the next buffer in the sequence of back buffers owned by the device.
    ///Params:
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to a value that must be <b>NULL</b> unless the swap chain was created with
    ///                  D3DSWAPEFFECT_COPY. pSourceRect is a pointer to a RECT structure containing the source rectangle. If
    ///                  <b>NULL</b>, the entire source surface is presented. If the rectangle exceeds the source surface, the
    ///                  rectangle is clipped to the source surface.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to a value that must be <b>NULL</b> unless the swap chain was created with
    ///                D3DSWAPEFFECT_COPY. pDestRect is a pointer to a RECT structure containing the destination rectangle, in
    ///                window client coordinates. If <b>NULL</b>, the entire client area is filled. If the rectangle exceeds the
    ///                destination client area, the rectangle is clipped to the destination client area.
    ///    hDestWindowOverride = Type: <b>HWND</b> Pointer to a destination window whose client area is taken as the target for this
    ///                          presentation. If this value is <b>NULL</b>, the runtime uses the <b>hDeviceWindow</b> member of
    ///                          D3DPRESENT_PARAMETERS for the presentation.
    ///    pDirtyRegion = Type: <b>const RGNDATA*</b> Value must be <b>NULL</b> unless the swap chain was created with
    ///                   D3DSWAPEFFECT_COPY. For more information about swap chains, see Flipping Surfaces (Direct3D 9) and
    ///                   D3DSWAPEFFECT. If this value is non-<b>NULL</b>, the contained region is expressed in back buffer
    ///                   coordinates. The rectangles within the region are the minimal set of pixels that need to be updated. This
    ///                   method takes these rectangles into account when optimizing the presentation by copying only the pixels within
    ///                   the region, or some suitably expanded set of rectangles. This is an aid to optimization only, and the
    ///                   application should not rely on the region being copied exactly. The implementation can choose to copy the
    ///                   whole source rectangle.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK or D3DERR_DEVICEREMOVED (see D3DERR).
    ///    
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                    const(RGNDATA)* pDirtyRegion);
    ///Retrieves a back buffer from the device's swap chain.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    iBackBuffer = Type: <b>UINT</b> Index of the back buffer object to return. Back buffers are numbered from 0 to the total
    ///                  number of back buffers minus one. A value of 0 returns the first back buffer, not the front buffer. The front
    ///                  buffer is not accessible through this method. Use IDirect3DDevice9::GetFrontBufferData to retrieve a copy of
    ///                  the front buffer.
    ///    Type = Type: <b>D3DBACKBUFFER_TYPE</b> Stereo view is not supported in Direct3D 9, so the only valid value for this
    ///           parameter is D3DBACKBUFFER_TYPE_MONO.
    ///    ppBackBuffer = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                   returned back buffer surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If BackBuffer equals or exceeds the
    ///    total number of back buffers, then the function fails and returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetBackBuffer(uint iSwapChain, uint iBackBuffer, D3DBACKBUFFER_TYPE Type, 
                          IDirect3DSurface9* ppBackBuffer);
    ///Returns information describing the raster of the monitor on which the swap chain is presented.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pRasterStatus = Type: <b>D3DRASTER_STATUS*</b> Pointer to a D3DRASTER_STATUS structure filled with information about the
    ///                    position or other status of the raster on the monitor driven by this adapter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    pRasterStatus is invalid or if the device does not support reading the current scan line. To determine if the
    ///    device supports reading the scan line, check for the D3DCAPS_READ_SCANLINE flag in the Caps member of
    ///    D3DCAPS9.
    ///    
    HRESULT GetRasterStatus(uint iSwapChain, D3DRASTER_STATUS* pRasterStatus);
    ///This method allows the use of GDI dialog boxes in full-screen mode applications.
    ///Params:
    ///    bEnableDialogs = Type: <b>BOOL</b> <b>TRUE</b> to enable GDI dialog boxes, and <b>FALSE</b> to disable them.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL unless all of the following are true. <ul> <li>The application specified a
    ///    back buffer format compatible with GDI, in other words, one of D3DFMT_X1R5G5B5, D3DFMT_R5G6B5, or
    ///    D3DFMT_X8R8G8B8.</li> <li>The application specified no multisampling.</li> <li>The application specified
    ///    D3DSWAPEFFECT_DISCARD.</li> <li>The application specified D3DPRESENTFLAG_LOCKABLE_BACKBUFFER.</li> <li>The
    ///    application did not specify D3DCREATE_ADAPTERGROUP_DEVICE.</li> <li>The application is not between BeginScene
    ///    and EndScene.</li> </ul>
    ///    
    HRESULT SetDialogBoxMode(BOOL bEnableDialogs);
    ///Sets the gamma correction ramp for the implicit swap chain. This method will affect the entire screen (not just
    ///the active window if you are running in windowed mode).
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> Unsigned integer specifying the swap chain.
    ///    Flags = Type: <b>DWORD</b> Indicates whether correction should be applied. Gamma correction results in a more
    ///            consistent display, but can incur processing overhead and should not be used frequently. Short-duration
    ///            effects, such as flashing the whole screen red, should not be calibrated, but long-duration gamma changes
    ///            should be calibrated. One of the following values can be set: <table> <tr> <th>Item</th> <th>Description</th>
    ///            </tr> <tr> <td width="40%"> <a id="D3DSGR_CALIBRATE"></a><a id="d3dsgr_calibrate"></a>D3DSGR_CALIBRATE </td>
    ///            <td width="60%"> If a gamma calibrator is installed, the ramp will be modified before being sent to the
    ///            device to account for the system and monitor response curves. If a calibrator is not installed, the ramp will
    ///            be passed directly to the device. </td> </tr> <tr> <td width="40%"> <a id="D3DSGR_NO_CALIBRATION"></a><a
    ///            id="d3dsgr_no_calibration"></a>D3DSGR_NO_CALIBRATION </td> <td width="60%"> No gamma correction is applied.
    ///            The supplied gamma table is transferred directly to the device. </td> </tr> </table>
    ///    pRamp = Type: <b>const D3DGAMMARAMP*</b> Pointer to a D3DGAMMARAMP structure, representing the gamma correction ramp
    ///            to be set for the implicit swap chain.
    void    SetGammaRamp(uint iSwapChain, uint Flags, const(D3DGAMMARAMP)* pRamp);
    ///Retrieves the gamma correction ramp for the swap chain.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pRamp = Type: <b>D3DGAMMARAMP*</b> Pointer to an application-supplied D3DGAMMARAMP structure to fill with the gamma
    ///            correction ramp.
    void    GetGammaRamp(uint iSwapChain, D3DGAMMARAMP* pRamp);
    ///Creates a texture resource.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the top-level of the texture, in pixels. The pixel dimensions of subsequent levels
    ///            will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///            clamps at a size of 1 pixel. Thus, if the division by 2 results in 0, 1 will be taken instead.
    ///    Height = Type: <b>UINT</b> Height of the top-level of the texture, in pixels. The pixel dimensions of subsequent
    ///             levels will be the truncated value of half of the previous level's pixel dimension (independently). Each
    ///             dimension clamps at a size of 1 pixel. Thus, if the division by 2 results in 0, 1 will be taken instead.
    ///    Levels = Type: <b>UINT</b> Number of levels in the texture. If this is zero, Direct3D will generate all texture
    ///             sublevels down to 1 by 1 pixels for hardware that supports mipmapped textures. Call
    ///             IDirect3DBaseTexture9::GetLevelCount to see the number of levels generated.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter with the
    ///            behavior flags in IDirect3D9::CreateDevice.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of all levels in the
    ///             texture.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing the memory class into which the
    ///           texture should be placed.
    ///    ppTexture = Type: <b>IDirect3DTexture9**</b> Pointer to an IDirect3DTexture9 interface, representing the created texture
    ///                resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateTexture(uint Width, uint Height, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                          IDirect3DTexture9* ppTexture, HANDLE* pSharedHandle);
    ///Creates a volume texture resource.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the top-level of the volume texture, in pixels. This value must be a power of two
    ///            if the D3DPTEXTURECAPS_VOLUMEMAP_POW2 member of D3DCAPS9 is set. The pixel dimensions of subsequent levels
    ///            will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///            clamps at a size of 1 pixel. Thus, if the division by two results in 0 (zero), 1 will be taken instead. The
    ///            maximum dimension that a driver supports (for width, height, and depth) can be found in MaxVolumeExtent in
    ///            <b>D3DCAPS9</b>.
    ///    Height = Type: <b>UINT</b> Height of the top-level of the volume texture, in pixels. This value must be a power of two
    ///             if the D3DPTEXTURECAPS_VOLUMEMAP_POW2 member of D3DCAPS9 is set. The pixel dimensions of subsequent levels
    ///             will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///             clamps at a size of 1 pixel. Thus, if the division by 2 results in 0 (zero), 1 will be taken instead. The
    ///             maximum dimension that a driver supports (for width, height, and depth) can be found in MaxVolumeExtent in
    ///             <b>D3DCAPS9</b>.
    ///    Depth = Type: <b>UINT</b> Depth of the top-level of the volume texture, in pixels. This value must be a power of two
    ///            if the D3DPTEXTURECAPS_VOLUMEMAP_POW2 member of D3DCAPS9 is set. The pixel dimensions of subsequent levels
    ///            will be the truncated value of half of the previous level's pixel dimension (independently). Each dimension
    ///            clamps at a size of 1 pixel. Thus, if the division by 2 results in 0 (zero), 1 will be taken instead. The
    ///            maximum dimension that a driver supports (for width, height, and depth) can be found in MaxVolumeExtent in
    ///            <b>D3DCAPS9</b>.
    ///    Levels = Type: <b>UINT</b> Number of levels in the texture. If this is zero, Direct3D will generate all texture
    ///             sublevels down to 1x1 pixels for hardware that supports mipmapped volume textures. Call
    ///             IDirect3DBaseTexture9::GetLevelCount to see the number of levels generated.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. If usage is desired, use D3DUSAGE_DYNAMIC
    ///            or D3DUSAGE_SOFTWAREPROCESSING. For more information, see D3DUSAGE.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of all levels in the
    ///             volume texture.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing the memory class into which the volume
    ///           texture should be placed.
    ///    ppVolumeTexture = Type: <b>IDirect3DVolumeTexture9**</b> Address of a pointer to an IDirect3DVolumeTexture9 interface,
    ///                      representing the created volume texture resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateVolumeTexture(uint Width, uint Height, uint Depth, uint Levels, uint Usage, D3DFORMAT Format, 
                                D3DPOOL Pool, IDirect3DVolumeTexture9* ppVolumeTexture, HANDLE* pSharedHandle);
    ///Creates a cube texture resource.
    ///Params:
    ///    EdgeLength = Type: <b>UINT</b> Size of the edges of all the top-level faces of the cube texture. The pixel dimensions of
    ///                 subsequent levels of each face will be the truncated value of half of the previous level's pixel dimension
    ///                 (independently). Each dimension clamps at a size of 1 pixel. Thus, if the division by 2 results in 0 (zero),
    ///                 1 will be taken instead.
    ///    Levels = Type: <b>UINT</b> Number of levels in each face of the cube texture. If this is zero, Direct3D will generate
    ///             all cube texture sublevels down to 1x1 pixels for each face for hardware that supports mipmapped cube
    ///             textures. Call IDirect3DBaseTexture9::GetLevelCount to see the number of levels generated.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter in
    ///            CreateCubeTexture with the behavior flags in IDirect3D9::CreateDevice. For more information, see Remarks.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of all levels in all
    ///             faces of the cube texture.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing the memory class into which the cube
    ///           texture should be placed.
    ///    ppCubeTexture = Type: <b>IDirect3DCubeTexture9**</b> Address of a pointer to an IDirect3DCubeTexture9 interface, representing
    ///                    the created cube texture resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateCubeTexture(uint EdgeLength, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                              IDirect3DCubeTexture9* ppCubeTexture, HANDLE* pSharedHandle);
    ///Creates a vertex buffer.
    ///Params:
    ///    Length = Type: <b>UINT</b> Size of the vertex buffer, in bytes. For FVF vertex buffers, Length must be large enough to
    ///             contain at least one vertex, but it need not be a multiple of the vertex size. Length is not validated for
    ///             non-FVF buffers. See Remarks.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter in
    ///            CreateVertexBuffer with the behavior flags in IDirect3D9::CreateDevice. For more information, see Remarks.
    ///    FVF = Type: <b>DWORD</b> Combination of D3DFVF, a usage specifier that describes the vertex format of the vertices
    ///          in this buffer. If this parameter is set to a valid FVF code, the created vertex buffer is an FVF vertex
    ///          buffer (see Remarks). Otherwise, if this parameter is set to zero, the vertex buffer is a non-FVF vertex
    ///          buffer.
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing a valid memory class into which to
    ///           place the resource. Do not set to D3DPOOL_SCRATCH.
    ///    ppVertexBuffer = Type: <b>IDirect3DVertexBuffer9**</b> Address of a pointer to an IDirect3DVertexBuffer9 interface,
    ///                     representing the created vertex buffer resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateVertexBuffer(uint Length, uint Usage, uint FVF, D3DPOOL Pool, 
                               IDirect3DVertexBuffer9* ppVertexBuffer, HANDLE* pSharedHandle);
    ///Creates an index buffer.
    ///Params:
    ///    Length = Type: <b>UINT</b> Size of the index buffer, in bytes.
    ///    Usage = Type: <b>DWORD</b> Usage can be 0, which indicates no usage value. However, if usage is desired, use a
    ///            combination of one or more D3DUSAGE constants. It is good practice to match the usage parameter in
    ///            CreateIndexBuffer with the behavior flags in IDirect3D9::CreateDevice. For more information, see Remarks.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the index buffer.
    ///             For more information, see Remarks. The valid settings are the following: <table> <tr> <th>Item</th>
    ///             <th>Description</th> </tr> <tr> <td width="40%"> <a id="D3DFMT_INDEX16"></a><a
    ///             id="d3dfmt_index16"></a>D3DFMT_INDEX16 </td> <td width="60%"> Indices are 16 bits each. </td> </tr> <tr> <td
    ///             width="40%"> <a id="D3DFMT_INDEX32"></a><a id="d3dfmt_index32"></a>D3DFMT_INDEX32 </td> <td width="60%">
    ///             Indices are 32 bits each. </td> </tr> </table>
    ///    Pool = Type: <b>D3DPOOL</b> Member of the D3DPOOL enumerated type, describing a valid memory class into which to
    ///           place the resource.
    ///    ppIndexBuffer = Type: <b>IDirect3DIndexBuffer9**</b> Address of a pointer to an IDirect3DIndexBuffer9 interface, representing
    ///                    the created index buffer resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> This parameter can be used in Direct3D 9 for Windows Vista to share resources; set it to
    ///                    <b>NULL</b> to not share a resource. This parameter is not used in Direct3D 9 for operating systems earlier
    ///                    than Windows Vista; set it to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, D3DXERR_INVALIDDATA,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateIndexBuffer(uint Length, uint Usage, D3DFORMAT Format, D3DPOOL Pool, 
                              IDirect3DIndexBuffer9* ppIndexBuffer, HANDLE* pSharedHandle);
    ///Creates a render-target surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the render-target surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the render-target surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the render target.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, which describes the
    ///                  multisampling buffer type. This parameter specifies the antialiasing type for this render target. When this
    ///                  surface is passed to IDirect3DDevice9::SetRenderTarget, its multisample type must be the same as that of the
    ///                  depth-stencil set by IDirect3DDevice9::SetDepthStencilSurface.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error,
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         multisample type must all match.
    ///    Lockable = Type: <b>BOOL</b> Render targets are not lockable unless the application specifies <b>TRUE</b> for Lockable.
    ///               Note that lockable render targets reduce performance on some graphics hardware. The readback performance
    ///               (moving data from video memory to system memory) depends on the type of hardware used (AGP vs. PCI Express)
    ///               and is usually far lower than upload performance (moving data from system to video memory). If you need read
    ///               access to render targets, use GetRenderTargetData instead of lockable render targets.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateRenderTarget(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                               uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, 
                               HANDLE* pSharedHandle);
    ///Creates a depth-stencil resource.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the depth-stencil surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the depth-stencil surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the depth-stencil
    ///             surface. This value must be one of the enumerated depth-stencil formats for this device.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, describing the
    ///                  multisampling buffer type. This value must be one of the allowed multisample types. When this surface is
    ///                  passed to IDirect3DDevice9::SetDepthStencilSurface, its multisample type must be the same as that of the
    ///                  render target set by IDirect3DDevice9::SetRenderTarget.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         MultiSample type must all match.
    ///    Discard = Type: <b>BOOL</b> Set this flag to <b>TRUE</b> to enable z-buffer discarding, and <b>FALSE</b> otherwise. If
    ///              this flag is set, the contents of the depth stencil buffer will be invalid after calling either
    ///              IDirect3DDevice9::Present or IDirect3DDevice9::SetDepthStencilSurface with a different depth surface. This
    ///              flag has the same behavior as the constant, D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL, in D3DPRESENTFLAG.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                created depth-stencil surface resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateDepthStencilSurface(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                      uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, 
                                      HANDLE* pSharedHandle);
    ///Copies rectangular subsets of pixels from one surface to another.
    ///Params:
    ///    pSourceSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface, representing the source surface.
    ///                     This parameter must point to a different surface than pDestinationSurface.
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to a rectangle on the source surface. Specifying <b>NULL</b> for this
    ///                  parameter causes the entire surface to be copied.
    ///    pDestinationSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface, representing the destination
    ///                          surface.
    ///    pDestPoint = Type: <b>const POINT*</b> Pointer to the upper left corner of the destination rectangle. Specifying
    ///                 <b>NULL</b> for this parameter causes the entire surface to be copied.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT UpdateSurface(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, 
                          IDirect3DSurface9 pDestinationSurface, const(POINT)* pDestPoint);
    ///Updates the dirty portions of a texture.
    ///Params:
    ///    pSourceTexture = Type: <b>IDirect3DBaseTexture9*</b> Pointer to an IDirect3DBaseTexture9 interface, representing the source
    ///                     texture. The source texture must be in system memory (D3DPOOL_SYSTEMMEM).
    ///    pDestinationTexture = Type: <b>IDirect3DBaseTexture9*</b> Pointer to an IDirect3DBaseTexture9 interface, representing the
    ///                          destination texture. The destination texture must be in the D3DPOOL_DEFAULT memory pool.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UpdateTexture(IDirect3DBaseTexture9 pSourceTexture, IDirect3DBaseTexture9 pDestinationTexture);
    ///Copies the render-target data from device memory to system memory.
    ///Params:
    ///    pRenderTarget = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 object, representing a render target.
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 object, representing a destination surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DRIVERINTERNALERROR, D3DERR_DEVICELOST, D3DERR_INVALIDCALL.
    ///    
    HRESULT GetRenderTargetData(IDirect3DSurface9 pRenderTarget, IDirect3DSurface9 pDestSurface);
    ///Generates a copy of the device's front buffer and places that copy in a system memory buffer provided by the
    ///application.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface that will receive a copy of the
    ///                   contents of the front buffer. The data is returned in successive rows with no intervening space, starting
    ///                   from the vertically highest row on the device's output to the lowest. For windowed mode, the size of the
    ///                   destination surface should be the size of the desktop. For full-screen mode, the size of the destination
    ///                   surface should be the screen size.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DRIVERINTERNALERROR, D3DERR_DEVICELOST, D3DERR_INVALIDCALL
    ///    
    HRESULT GetFrontBufferData(uint iSwapChain, IDirect3DSurface9 pDestSurface);
    ///Copy the contents of the source rectangle to the destination rectangle. The source rectangle can be stretched and
    ///filtered by the copy. This function is often used to change the aspect ratio of a video stream.
    ///Params:
    ///    pSourceSurface = Type: <b>IDirect3DSurface9*</b> Pointer to the source surface. See IDirect3DSurface9.
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to the source rectangle. A <b>NULL</b> for this parameter causes the entire
    ///                  source surface to be used.
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to the destination surface. See IDirect3DSurface9.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to the destination rectangle. A <b>NULL</b> for this parameter causes the
    ///                entire destination surface to be used.
    ///    Filter = Type: <b>D3DTEXTUREFILTERTYPE</b> Filter type. Allowable values are D3DTEXF_NONE, D3DTEXF_POINT, or
    ///             D3DTEXF_LINEAR. For more information, see D3DTEXTUREFILTERTYPE.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT StretchRect(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, IDirect3DSurface9 pDestSurface, 
                        const(RECT)* pDestRect, D3DTEXTUREFILTERTYPE Filter);
    ///Allows an application to fill a rectangular area of a D3DPOOL_DEFAULT surface with a specified color.
    ///Params:
    ///    pSurface = Type: <b>IDirect3DSurface9*</b> Pointer to the surface to be filled.
    ///    pRect = Type: <b>const RECT*</b> Pointer to the source rectangle. Using <b>NULL</b> means that the entire surface
    ///            will be filled.
    ///    color = Type: <b>D3DCOLOR</b> Color used for filling.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT ColorFill(IDirect3DSurface9 pSurface, const(RECT)* pRect, uint color);
    ///Create an off-screen surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the surface.
    ///    Height = Type: <b>UINT</b> Height of the surface.
    ///    Format = Type: <b>D3DFORMAT</b> Format of the surface. See D3DFORMAT.
    ///    Pool = Type: <b>D3DPOOL</b> Surface pool type. See D3DPOOL.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Pointer to the IDirect3DSurface9 interface created.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT CreateOffscreenPlainSurface(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, 
                                        IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle);
    ///Sets a new color buffer for the device.
    ///Params:
    ///    RenderTargetIndex = Type: <b>DWORD</b> Index of the render target. See Remarks.
    ///    pRenderTarget = Type: <b>IDirect3DSurface9*</b> Pointer to a new color buffer. If <b>NULL</b>, the color buffer for the
    ///                    corresponding RenderTargetIndex is disabled. Devices always must be associated with a color buffer. The new
    ///                    render-target surface must have at least D3DUSAGE_RENDERTARGET specified.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. This method will return
    ///    D3DERR_INVALIDCALL if either: <ul> <li>pRenderTarget = <b>NULL</b> and RenderTargetIndex = 0</li>
    ///    <li>pRenderTarget is != <b>NULL</b> and the render target is invalid.</li> </ul>
    ///    
    HRESULT SetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9 pRenderTarget);
    ///Retrieves a render-target surface.
    ///Params:
    ///    RenderTargetIndex = Type: <b>DWORD</b> Index of the render target. See Remarks.
    ///    ppRenderTarget = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                     returned render-target surface for this device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL if one of the arguments is invalid, or D3DERR_NOTFOUND if there's no render
    ///    target available for the given index.
    ///    
    HRESULT GetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9* ppRenderTarget);
    ///Sets the depth stencil surface.
    ///Params:
    ///    pNewZStencil = Type: <b>IDirect3DSurface9*</b> Address of a pointer to an IDirect3DSurface9 interface representing the depth
    ///                   stencil surface. Setting this to <b>NULL</b> disables the depth stencil operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If pZStencilSurface is other than
    ///    <b>NULL</b>, the return value is D3DERR_INVALIDCALL when the stencil surface is invalid.
    ///    
    HRESULT SetDepthStencilSurface(IDirect3DSurface9 pNewZStencil);
    ///Gets the depth-stencil surface owned by the Direct3DDevice object.
    ///Params:
    ///    ppZStencilSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                        returned depth-stencil surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.If the device doesn't have a depth
    ///    stencil buffer associated with it, the return value will be D3DERR_NOTFOUND. Otherwise, if the method fails,
    ///    the return value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDepthStencilSurface(IDirect3DSurface9* ppZStencilSurface);
    ///Begins a scene.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The method will fail with
    ///    D3DERR_INVALIDCALL if <b>IDirect3DDevice9::BeginScene</b> is called while already in a
    ///    <b>IDirect3DDevice9::BeginScene</b>/IDirect3DDevice9::EndScene pair. This happens only when
    ///    <b>IDirect3DDevice9::BeginScene</b> is called twice without first calling <b>IDirect3DDevice9::EndScene</b>.
    ///    
    HRESULT BeginScene();
    ///Ends a scene that was begun by calling IDirect3DDevice9::BeginScene.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The method will fail with
    ///    D3DERR_INVALIDCALL if IDirect3DDevice9::BeginScene is called while already in a
    ///    <b>IDirect3DDevice9::BeginScene</b>/<b>IDirect3DDevice9::EndScene</b> pair. This happens only when
    ///    <b>IDirect3DDevice9::BeginScene</b> is called twice without first calling <b>IDirect3DDevice9::EndScene</b>.
    ///    
    HRESULT EndScene();
    ///Clears one or more surfaces such as a render target, multiple render targets, a stencil buffer, and a depth
    ///buffer.
    ///Params:
    ///    Count = Type: <b>DWORD</b> Number of rectangles in the array at pRects. Must be set to 0 if pRects is <b>NULL</b>.
    ///            May not be 0 if pRects is a valid pointer.
    ///    pRects = Type: <b>const D3DRECT*</b> Pointer to an array of D3DRECT structures that describe the rectangles to clear.
    ///             Set a rectangle to the dimensions of the rendering target to clear the entire surface. Each rectangle uses
    ///             screen coordinates that correspond to points on the render target. Coordinates are clipped to the bounds of
    ///             the viewport rectangle. To indicate that the entire viewport rectangle is to be cleared, set this parameter
    ///             to <b>NULL</b> and Count to 0.
    ///    Flags = Type: <b>DWORD</b> Combination of one or more D3DCLEAR flags that specify the surface(s) that will be
    ///            cleared.
    ///    Color = Type: <b>D3DCOLOR</b> Clear a render target to this ARGB color.
    ///    Z = Type: <b>float</b> Clear the depth buffer to this new z value which ranges from 0 to 1. See remarks.
    ///    Stencil = Type: <b>DWORD</b> Clear the stencil buffer to this new value which ranges from 0 to 2ⁿ-1 (n is the bit
    ///              depth of the stencil buffer). See remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT Clear(uint Count, const(D3DRECT)* pRects, uint Flags, uint Color, float Z, uint Stencil);
    ///Sets a single device transformation-related state.
    ///Params:
    ///    State = Type: <b>D3DTRANSFORMSTATETYPE</b> Device-state variable that is being modified. This parameter can be any
    ///            member of the D3DTRANSFORMSTATETYPE enumerated type, or the D3DTS_WORLDMATRIX macro.
    ///    pMatrix = Type: <b>const D3DMATRIX*</b> Pointer to a D3DMATRIX structure that modifies the current transformation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one of the arguments is invalid.
    ///    
    HRESULT SetTransform(D3DTRANSFORMSTATETYPE State, const(D3DMATRIX)* pMatrix);
    ///Retrieves a matrix describing a transformation state.
    ///Params:
    ///    State = Type: <b>D3DTRANSFORMSTATETYPE</b> Device state variable that is being modified. This parameter can be any
    ///            member of the D3DTRANSFORMSTATETYPE enumerated type, or the D3DTS_WORLDMATRIX macro.
    ///    pMatrix = Type: <b>D3DMATRIX*</b> Pointer to a D3DMATRIX structure, describing the returned transformation state.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if one of the
    ///    arguments is invalid.
    ///    
    HRESULT GetTransform(D3DTRANSFORMSTATETYPE State, D3DMATRIX* pMatrix);
    ///Multiplies a device's world, view, or projection matrices by a specified matrix.
    ///Params:
    ///    arg1 = Type: <b>D3DTRANSFORMSTATETYPE</b> Member of the D3DTRANSFORMSTATETYPE enumerated type, or the
    ///           D3DTS_WORLDMATRIX macro that identifies which device matrix is to be modified. The most common setting,
    ///           <b>D3DTS_WORLDMATRIX</b>(0), modifies the world matrix, but you can specify that the method modify the view
    ///           or projection matrices, if needed.
    ///    arg2 = Type: <b>const D3DMATRIX*</b> Pointer to a D3DMATRIX structure that modifies the current transformation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if one of the
    ///    arguments is invalid.
    ///    
    HRESULT MultiplyTransform(D3DTRANSFORMSTATETYPE param0, const(D3DMATRIX)* param1);
    ///Sets the viewport parameters for the device.
    ///Params:
    ///    pViewport = Type: <b>const D3DVIEWPORT9*</b> Pointer to a D3DVIEWPORT9 structure, specifying the viewport parameters to
    ///                set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, it will return
    ///    D3DERR_INVALIDCALL. This will happen if pViewport is invalid, or if pViewport describes a region that cannot
    ///    exist within the render target surface.
    ///    
    HRESULT SetViewport(const(D3DVIEWPORT9)* pViewport);
    ///Retrieves the viewport parameters currently set for the device.
    ///Params:
    ///    pViewport = Type: <b>D3DVIEWPORT9*</b> Pointer to a D3DVIEWPORT9 structure, representing the returned viewport
    ///                parameters.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the pViewport parameter is invalid.
    ///    
    HRESULT GetViewport(D3DVIEWPORT9* pViewport);
    ///Sets the material properties for the device.
    ///Params:
    ///    pMaterial = Type: <b>const D3DMATERIAL9*</b> Pointer to a D3DMATERIAL9 structure, describing the material properties to
    ///                set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if the pMaterial
    ///    parameter is invalid.
    ///    
    HRESULT SetMaterial(const(D3DMATERIAL9)* pMaterial);
    ///Retrieves the current material properties for the device.
    ///Params:
    ///    pMaterial = Type: <b>D3DMATERIAL9*</b> Pointer to a D3DMATERIAL9 structure to fill with the currently set material
    ///                properties.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if the pMaterial
    ///    parameter is invalid.
    ///    
    HRESULT GetMaterial(D3DMATERIAL9* pMaterial);
    ///Assigns a set of lighting properties for this device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the set of lighting properties to set. If a set of lighting properties
    ///            exists at this index, it is overwritten by the new properties specified in pLight.
    ///    arg2 = Type: <b>const D3DLIGHT9*</b> Pointer to a D3DLIGHT9 structure, containing the lighting parameters to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetLight(uint Index, const(D3DLIGHT9)* param1);
    ///Retrieves a set of lighting properties that this device uses.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the lighting property set to retrieve. This method will fail if a
    ///            lighting property has not been set for this index by calling the IDirect3DDevice9::SetLight method.
    ///    arg2 = Type: <b>D3DLight9*</b> Pointer to a D3DLIGHT9 structure that is filled with the retrieved lighting-parameter
    ///           set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetLight(uint Index, D3DLIGHT9* param1);
    ///Enables or disables a set of lighting parameters within a device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the set of lighting parameters that are the target of this method.
    ///    Enable = Type: <b>BOOL</b> Value that indicates if the set of lighting parameters are being enabled or disabled. Set
    ///             this parameter to <b>TRUE</b> to enable lighting with the parameters at the specified index, or <b>FALSE</b>
    ///             to disable it.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LightEnable(uint Index, BOOL Enable);
    ///Retrieves the activity status - enabled or disabled - for a set of lighting parameters within a device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Zero-based index of the set of lighting parameters that are the target of this method.
    ///    pEnable = Type: <b>BOOL*</b> Pointer to a variable to fill with the status of the specified lighting parameters. After
    ///              the call, a nonzero value at this address indicates that the specified lighting parameters are enabled; a
    ///              value of 0 indicates that they are disabled.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetLightEnable(uint Index, int* pEnable);
    ///Sets the coefficients of a user-defined clipping plane for the device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Index of the clipping plane for which the plane equation coefficients are to be set.
    ///    pPlane = Type: <b>const float*</b> Pointer to an address of a four-element array of values that represent the clipping
    ///             plane coefficients to be set, in the form of the general plane equation. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value is D3DERR_INVALIDCALL. This error indicates that the value in Index exceeds the maximum clipping plane
    ///    index supported by the device or that the array at pPlane is not large enough to contain four floating-point
    ///    values.
    ///    
    HRESULT SetClipPlane(uint Index, const(float)* pPlane);
    ///Retrieves the coefficients of a user-defined clipping plane for the device.
    ///Params:
    ///    Index = Type: <b>DWORD</b> Index of the clipping plane for which the plane equation coefficients are retrieved.
    ///    pPlane = Type: <b>float*</b> Pointer to a four-element array of values that represent the coefficients of the clipping
    ///             plane in the form of the general plane equation. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value is D3DERR_INVALIDCALL. This error indicates that the value in Index exceeds the maximum clipping plane
    ///    index supported by the device, or that the array at pPlane is not large enough to contain four floating-point
    ///    values.
    ///    
    HRESULT GetClipPlane(uint Index, float* pPlane);
    ///Sets a single device render-state parameter.
    ///Params:
    ///    State = Type: <b>D3DRENDERSTATETYPE</b> Device state variable that is being modified. This parameter can be any
    ///            member of the D3DRENDERSTATETYPE enumerated type.
    ///    Value = Type: <b>DWORD</b> New value for the device render state to be set. The meaning of this parameter is
    ///            dependent on the value specified for <i>State</i>. For example, if <i>State</i> were D3DRS_SHADEMODE, the
    ///            second parameter would be one member of the D3DSHADEMODE enumerated type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one of the arguments is invalid.
    ///    
    HRESULT SetRenderState(D3DRENDERSTATETYPE State, uint Value);
    ///Retrieves a render-state value for a device.
    ///Params:
    ///    State = Type: <b>D3DRENDERSTATETYPE</b> Device state variable that is being queried. This parameter can be any member
    ///            of the D3DRENDERSTATETYPE enumerated type.
    ///    pValue = Type: <b>DWORD*</b> Pointer to a variable that receives the value of the queried render state variable when
    ///             the method returns.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL if one of the
    ///    arguments is invalid.
    ///    
    HRESULT GetRenderState(D3DRENDERSTATETYPE State, uint* pValue);
    ///Creates a new state block that contains the values for all device states, vertex-related states, or pixel-related
    ///states.
    ///Params:
    ///    Type = Type: <b>D3DSTATEBLOCKTYPE</b> Type of state data that the method should capture. This parameter can be set
    ///           to a value defined in the D3DSTATEBLOCKTYPE enumerated type.
    ///    ppSB = Type: <b>IDirect3DStateBlock9**</b> Pointer to a state block interface. See IDirect3DStateBlock9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateStateBlock(D3DSTATEBLOCKTYPE Type, IDirect3DStateBlock9* ppSB);
    ///Signals Direct3D to begin recording a device-state block.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, E_OUTOFMEMORY.
    ///    
    HRESULT BeginStateBlock();
    ///Signals Direct3D to stop recording a device-state block and retrieve a pointer to the state block interface.
    ///Params:
    ///    ppSB = Type: <b>IDirect3DStateBlock9**</b> Pointer to a state block interface. See IDirect3DStateBlock9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT EndStateBlock(IDirect3DStateBlock9* ppSB);
    ///Sets the clip status.
    ///Params:
    ///    pClipStatus = Type: <b>const D3DCLIPSTATUS9*</b> Pointer to a D3DCLIPSTATUS9 structure, describing the clip status settings
    ///                  to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If one of the arguments is invalid,
    ///    the return value is D3DERR_INVALIDCALL.
    ///    
    HRESULT SetClipStatus(const(D3DCLIPSTATUS9)* pClipStatus);
    ///Retrieves the clip status.
    ///Params:
    ///    pClipStatus = Type: <b>D3DCLIPSTATUS9*</b> Pointer to a D3DCLIPSTATUS9 structure that describes the clip status.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetClipStatus(D3DCLIPSTATUS9* pClipStatus);
    ///Retrieves a texture assigned to a stage for a device.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Stage identifier of the texture to retrieve. Stage identifiers are zero-based.
    ///    ppTexture = Type: <b>IDirect3DBaseTexture9**</b> Address of a pointer to an IDirect3DBaseTexture9 interface, representing
    ///                the returned texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetTexture(uint Stage, IDirect3DBaseTexture9* ppTexture);
    ///Assigns a texture to a stage for a device.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Zero based sampler number. Textures are bound to samplers; samplers define sampling state
    ///            such as the filtering mode and the address wrapping mode. Textures are referenced differently by the
    ///            programmable and the fixed function pipeline: <ul> <li>Programmable shaders reference textures using the
    ///            sampler number. The number of samplers available to a programmable shader is dependent on the shader version.
    ///            For vertex shaders, see Sampler (Direct3D 9 asm-vs). For pixel shaders see Sampler (Direct3D 9 asm-ps).</li>
    ///            <li>The fixed function pipeline on the other hand, references textures by texture stage number. The maximum
    ///            number of samplers is determined from two caps: MaxSimultaneousTextures and MaxTextureBlendStages of the
    ///            D3DCAPS9 structure.</li> </ul> There are two other special cases for stage/sampler numbers. <ul> <li>A
    ///            special number called D3DDMAPSAMPLER is used for Displacement Mapping (Direct3D 9).</li> <li>A programmable
    ///            vertex shader uses a special number defined by a D3DVERTEXTEXTURESAMPLER when accessing Vertex Textures in
    ///            vs_3_0 (DirectX HLSL).</li> </ul>
    ///    pTexture = Type: <b>IDirect3DBaseTexture9*</b> Pointer to an IDirect3DBaseTexture9 interface, representing the texture
    ///               being set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetTexture(uint Stage, IDirect3DBaseTexture9 pTexture);
    ///Retrieves a state value for an assigned texture.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Stage identifier of the texture for which the state is retrieved. Stage identifiers are
    ///            zero-based. Devices can have up to eight set textures, so the maximum value allowed for Stage is 7.
    ///    Type = Type: <b>D3DTEXTURESTAGESTATETYPE</b> Texture state to retrieve. This parameter can be any member of the
    ///           D3DTEXTURESTAGESTATETYPE enumerated type.
    ///    pValue = Type: <b>DWORD*</b> Pointer a variable to fill with the retrieved state value. The meaning of the retrieved
    ///             value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint* pValue);
    ///Sets the state value for the currently assigned texture.
    ///Params:
    ///    Stage = Type: <b>DWORD</b> Stage identifier of the texture for which the state value is set. Stage identifiers are
    ///            zero-based. Devices can have up to eight set textures, so the maximum value allowed for Stage is 7.
    ///    Type = Type: <b>D3DTEXTURESTAGESTATETYPE</b> Texture state to set. This parameter can be any member of the
    ///           D3DTEXTURESTAGESTATETYPE enumerated type.
    ///    Value = Type: <b>DWORD</b> State value to set. The meaning of this value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint Value);
    ///Gets the sampler state value.
    ///Params:
    ///    Sampler = Type: <b>DWORD</b> The sampler stage index.
    ///    Type = Type: <b>D3DSAMPLERSTATETYPE</b> This parameter can be any member of the D3DSAMPLERSTATETYPE enumerated type.
    ///    pValue = Type: <b>DWORD*</b> State value to get. The meaning of this value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint* pValue);
    ///Sets the sampler state value.
    ///Params:
    ///    Sampler = Type: <b>DWORD</b> The sampler stage index. For more info about sampler stage, see Sampling Stage Registers
    ///              in vs_3_0 (DirectX HLSL).
    ///    Type = Type: <b>D3DSAMPLERSTATETYPE</b> This parameter can be any member of the D3DSAMPLERSTATETYPE enumerated type.
    ///    Value = Type: <b>DWORD</b> State value to set. The meaning of this value is determined by the Type parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint Value);
    ///Reports the device's ability to render the current texture-blending operations and arguments in a single pass.
    ///Params:
    ///    pNumPasses = Type: <b>DWORD*</b> Pointer to a DWORD value to fill with the number of rendering passes needed to complete
    ///                 the desired effect through multipass rendering.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_CONFLICTINGRENDERSTATE, D3DERR_CONFLICTINGTEXTUREFILTER,
    ///    D3DERR_DEVICELOST, D3DERR_DRIVERINTERNALERROR, D3DERR_TOOMANYOPERATIONS, D3DERR_UNSUPPORTEDALPHAARG,
    ///    D3DERR_UNSUPPORTEDALPHAOPERATION, D3DERR_UNSUPPORTEDCOLORARG, D3DERR_UNSUPPORTEDCOLOROPERATION,
    ///    D3DERR_UNSUPPORTEDFACTORVALUE, D3DERR_UNSUPPORTEDTEXTUREFILTER, D3DERR_WRONGTEXTUREFORMAT,.
    ///    
    HRESULT ValidateDevice(uint* pNumPasses);
    ///Sets palette entries.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT</b> An ordinal value identifying the particular palette upon which the operation is to be
    ///                    performed.
    ///    pEntries = Type: <b>const PALETTEENTRY*</b> Pointer to a PALETTEENTRY structure, representing the palette entries to
    ///               set. The number of <b>PALETTEENTRY</b> structures pointed to by pEntries is assumed to be 256. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPaletteEntries(uint PaletteNumber, const(PALETTEENTRY)* pEntries);
    ///Retrieves palette entries.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT</b> An ordinal value identifying the particular palette to retrieve.
    ///    pEntries = Type: <b>PALETTEENTRY*</b> Pointer to a PALETTEENTRY structure, representing the returned palette entries.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPaletteEntries(uint PaletteNumber, PALETTEENTRY* pEntries);
    ///Sets the current texture palette.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT</b> Value that specifies the texture palette to set as the current texture palette.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetCurrentTexturePalette(uint PaletteNumber);
    ///Retrieves the current texture palette.
    ///Params:
    ///    PaletteNumber = Type: <b>UINT*</b> Pointer to a returned value that identifies the current texture palette.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetCurrentTexturePalette(uint* PaletteNumber);
    ///Sets the scissor rectangle.
    ///Params:
    ///    pRect = Type: <b>const RECT*</b> Pointer to a RECT structure that defines the rendering area within the render target
    ///            if scissor test is enabled. This parameter may not be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetScissorRect(const(RECT)* pRect);
    ///Gets the scissor rectangle.
    ///Params:
    ///    pRect = Type: <b>RECT*</b> Returns a pointer to a RECT structure that defines the rendering area within the render
    ///            target if scissor test is enabled.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetScissorRect(RECT* pRect);
    ///Use this method to switch between software and hardware vertex processing.
    ///Params:
    ///    bSoftware = Type: <b>BOOL</b> <b>TRUE</b> to specify software vertex processing; <b>FALSE</b> to specify hardware vertex
    ///                processing.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetSoftwareVertexProcessing(BOOL bSoftware);
    ///Gets the vertex processing (hardware or software) mode.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns <b>TRUE</b> if software vertex processing is set. Otherwise, it returns
    ///    <b>FALSE</b>.
    ///    
    BOOL    GetSoftwareVertexProcessing();
    ///Enable or disable N-patches.
    ///Params:
    ///    nSegments = Type: <b>float</b> Specifies the number of subdivision segments. If the number of segments is less than 1.0,
    ///                N-patches are disabled. The default value is 0.0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.
    ///    
    HRESULT SetNPatchMode(float nSegments);
    ///Gets the N-patch mode segments.
    ///Returns:
    ///    Type: <b>FLOAT</b> Specifies the number of subdivision segments. If the number of segments is less than 1.0,
    ///    N-patches are disabled. The default value is 0.0.
    ///    
    float   GetNPatchMode();
    ///Renders a sequence of nonindexed, geometric primitives of the specified type from the current set of data input
    ///streams.
    ///Params:
    ///    PrimitiveType = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///                    primitive to render.
    ///    StartVertex = Type: <b>UINT</b> Index of the first vertex to load. Beginning at StartVertex the correct number of vertices
    ///                  will be read out of the vertex buffer.
    ///    PrimitiveCount = Type: <b>UINT</b> Number of primitives to render. The maximum number of primitives allowed is determined by
    ///                     checking the MaxPrimitiveCount member of the D3DCAPS9 structure. PrimitiveCount is the number of primitives
    ///                     as determined by the primitive type. If it is a line list, each primitive has two vertices. If it is a
    ///                     triangle list, each primitive has three vertices.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawPrimitive(D3DPRIMITIVETYPE PrimitiveType, uint StartVertex, uint PrimitiveCount);
    ///Based on indexing, renders the specified geometric primitive into an array of vertices.
    ///Params:
    ///    arg1 = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///           primitive to render. D3DPT_POINTLIST is not supported with this method. See Remarks.
    ///    BaseVertexIndex = Type: <b>INT</b> Offset from the start of the vertex buffer to the first vertex. See Scenario 4.
    ///    MinVertexIndex = Type: <b>UINT</b> Minimum vertex index for vertices used during this call. This is a zero based index
    ///                     relative to BaseVertexIndex.
    ///    NumVertices = Type: <b>UINT</b> Number of vertices used during this call. The first vertex is located at index:
    ///                  BaseVertexIndex + MinIndex.
    ///    startIndex = Type: <b>UINT</b> Index of the first index to use when accesssing the vertex buffer. Beginning at StartIndex
    ///                 to index vertices from the vertex buffer.
    ///    primCount = Type: <b>UINT</b> Number of primitives to render. The number of vertices used is a function of the primitive
    ///                count and the primitive type. The maximum number of primitives allowed is determined by checking the
    ///                MaxPrimitiveCount member of the D3DCAPS9 structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE param0, int BaseVertexIndex, uint MinVertexIndex, 
                                 uint NumVertices, uint startIndex, uint primCount);
    ///Renders data specified by a user memory pointer as a sequence of geometric primitives of the specified type.
    ///Params:
    ///    PrimitiveType = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///                    primitive to render.
    ///    PrimitiveCount = Type: <b>UINT</b> Number of primitives to render. The maximum number of primitives allowed is determined by
    ///                     checking the MaxPrimitiveCount member of the D3DCAPS9 structure.
    ///    pVertexStreamZeroData = Type: <b>const void*</b> User memory pointer to the vertex data.
    ///    VertexStreamZeroStride = Type: <b>UINT</b> The number of bytes of data for each vertex. This value may not be 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint PrimitiveCount, 
                            const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    ///Renders the specified geometric primitive with data specified by a user memory pointer.
    ///Params:
    ///    PrimitiveType = Type: <b>D3DPRIMITIVETYPE</b> Member of the D3DPRIMITIVETYPE enumerated type, describing the type of
    ///                    primitive to render.
    ///    MinVertexIndex = Type: <b>UINT</b> Minimum vertex index. This is a zero-based index.
    ///    NumVertices = Type: <b>UINT</b> Number of vertices used during this call. The first vertex is located at index:
    ///                  MinVertexIndex.
    ///    PrimitiveCount = Type: <b>UINT</b> Number of primitives to render. The maximum number of primitives allowed is determined by
    ///                     checking the MaxPrimitiveCount member of the D3DCAPS9 structure (the number of indices is a function of the
    ///                     primitive count and the primitive type).
    ///    pIndexData = Type: <b>const void*</b> User memory pointer to the index data.
    ///    IndexDataFormat = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the index data. The
    ///                      valid settings are either: <ul> <li> D3DFMT_INDEX16 </li> <li> D3DFMT_INDEX32 </li> </ul>
    ///    pVertexStreamZeroData = Type: <b>const void*</b> User memory pointer to the vertex data. The vertex data must be in stream 0.
    ///    VertexStreamZeroStride = Type: <b>UINT</b> The number of bytes of data for each vertex. This value may not be 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawIndexedPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint MinVertexIndex, uint NumVertices, 
                                   uint PrimitiveCount, const(void)* pIndexData, D3DFORMAT IndexDataFormat, 
                                   const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    ///Applies the vertex processing defined by the vertex shader to the set of input data streams, generating a single
    ///stream of interleaved vertex data to the destination vertex buffer.
    ///Params:
    ///    SrcStartIndex = Type: <b>UINT</b> Index of first vertex to load.
    ///    DestIndex = Type: <b>UINT</b> Index of first vertex in the destination vertex buffer into which the results are placed.
    ///    VertexCount = Type: <b>UINT</b> Number of vertices to process.
    ///    pDestBuffer = Type: <b>IDirect3DVertexBuffer9*</b> Pointer to an IDirect3DVertexBuffer9 interface, the destination vertex
    ///                  buffer representing the stream of interleaved vertex data.
    ///    pVertexDecl = Type: <b>IDirect3DVertexDeclaration9*</b> Pointer to an IDirect3DVertexDeclaration9 interface that represents
    ///                  the output vertex data declaration. When vertex shader 3.0 or above is set as the current vertex shader, the
    ///                  output vertex declaration must be present.
    ///    Flags = Type: <b>DWORD</b> Processing options. Set this parameter to 0 for default processing. Set to
    ///            D3DPV_DONOTCOPYDATA to prevent the system from copying vertex data not affected by the vertex operation into
    ///            the destination buffer. The D3DPV_DONOTCOPYDATA value may be combined with one or more D3DLOCK values
    ///            appropriate for the destination buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT ProcessVertices(uint SrcStartIndex, uint DestIndex, uint VertexCount, 
                            IDirect3DVertexBuffer9 pDestBuffer, IDirect3DVertexDeclaration9 pVertexDecl, uint Flags);
    ///Create a vertex shader declaration from the device and the vertex elements.
    ///Params:
    ///    pVertexElements = Type: <b>const D3DVERTEXELEMENT9*</b> An array of D3DVERTEXELEMENT9 vertex elements.
    ///    ppDecl = Type: <b>IDirect3DVertexDeclaration9**</b> Pointer to an IDirect3DVertexDeclaration9 pointer that returns the
    ///             created vertex shader declaration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT CreateVertexDeclaration(const(D3DVERTEXELEMENT9)* pVertexElements, IDirect3DVertexDeclaration9* ppDecl);
    ///Sets a Vertex Declaration (Direct3D 9).
    ///Params:
    ///    pDecl = Type: <b>IDirect3DVertexDeclaration9*</b> Pointer to an IDirect3DVertexDeclaration9 object, which contains
    ///            the vertex declaration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The return value can be
    ///    D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexDeclaration(IDirect3DVertexDeclaration9 pDecl);
    ///Gets a vertex shader declaration.
    ///Params:
    ///    ppDecl = Type: <b>IDirect3DVertexDeclaration9**</b> Pointer to an IDirect3DVertexDeclaration9 object that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. The return value can be
    ///    D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexDeclaration(IDirect3DVertexDeclaration9* ppDecl);
    ///Sets the current vertex stream declaration.
    ///Params:
    ///    FVF = Type: <b>DWORD</b> DWORD containing the fixed function vertex type. For more information, see D3DFVF.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT SetFVF(uint FVF);
    ///Gets the fixed vertex function declaration.
    ///Params:
    ///    pFVF = Type: <b>DWORD*</b> A DWORD pointer to the fixed function vertex type. For more information, see D3DFVF.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFVF(uint* pFVF);
    ///Creates a vertex shader.
    ///Params:
    ///    pFunction = Type: <b>const DWORD*</b> Pointer to an array of tokens that represents the vertex shader, including any
    ///                embedded debug and symbol table information. <ul> <li>Use a function such as D3DXCompileShader to create the
    ///                array from a HLSL shader.</li> <li>Use a function like D3DXAssembleShader to create the token array from an
    ///                assembly language shader.</li> <li>Use a function like ID3DXEffectCompiler::CompileShader to create the array
    ///                from an effect.</li> </ul>
    ///    ppShader = Type: <b>IDirect3DVertexShader9**</b> Pointer to the returned vertex shader interface (see
    ///               IDirect3DVertexShader9).
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreateVertexShader(const(uint)* pFunction, IDirect3DVertexShader9* ppShader);
    ///Sets the vertex shader.
    ///Params:
    ///    pShader = Type: <b>IDirect3DVertexShader9*</b> Vertex shader interface. For more information, see
    ///              IDirect3DVertexShader9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShader(IDirect3DVertexShader9 pShader);
    ///Retrieves the currently set vertex shader.
    ///Params:
    ///    ppShader = Type: <b>IDirect3DVertexShader9**</b> Pointer to a vertex shader interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If ppShader is invalid,
    ///    D3DERR_INVALIDCALL is returned.
    ///    
    HRESULT GetVertexShader(IDirect3DVertexShader9* ppShader);
    ///Sets a floating-point vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    ///Gets a floating-point vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    ///Sets an integer vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    ///Gets an integer vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    ///Sets a Boolean vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetVertexShaderConstantB(uint StartRegister, const(int)* pConstantData, uint BoolCount);
    ///Gets a Boolean vertex shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of Boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVertexShaderConstantB(uint StartRegister, int* pConstantData, uint BoolCount);
    ///Binds a vertex buffer to a device data stream. For more information, see Setting the Stream Source (Direct3D 9).
    ///Params:
    ///    StreamNumber = Type: <b>UINT</b> Specifies the data stream, in the range from 0 to the maximum number of streams -1.
    ///    pStreamData = Type: <b>IDirect3DVertexBuffer9*</b> Pointer to an IDirect3DVertexBuffer9 interface, representing the vertex
    ///                  buffer to bind to the specified data stream.
    ///    OffsetInBytes = Type: <b>UINT</b> Offset from the beginning of the stream to the beginning of the vertex data, in bytes. To
    ///                    find out if the device supports stream offsets, see the D3DDEVCAPS2_STREAMOFFSET constant in D3DDEVCAPS2.
    ///    Stride = Type: <b>UINT</b> Stride of the component, in bytes. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9 pStreamData, uint OffsetInBytes, uint Stride);
    ///Retrieves a vertex buffer bound to the specified data stream.
    ///Params:
    ///    StreamNumber = Type: [in] <b>UINT</b> Specifies the data stream, in the range from 0 to the maximum number of streams minus
    ///                   one.
    ///    ppStreamData = Type: [in, out] <b>IDirect3DVertexBuffer9**</b> Address of a pointer to an IDirect3DVertexBuffer9 interface,
    ///                   representing the returned vertex buffer bound to the specified data stream.
    ///    OffsetInBytes = Type: [out] <b>UINT*</b> Pointer containing the offset from the beginning of the stream to the beginning of
    ///                    the vertex data. The offset is measured in bytes. See Remarks.
    ///    pStride = Type: [out] <b>UINT*</b> Pointer to a returned stride of the component, in bytes. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9* ppStreamData, uint* pOffsetInBytes, 
                            uint* pStride);
    ///Sets the stream source frequency divider value. This may be used to draw several instances of geometry.
    ///Params:
    ///    StreamNumber = Type: [in] <b>UINT</b> Stream source number.
    ///    Divider = Type: [in] <b>UINT</b> This parameter may have two different values. See remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetStreamSourceFreq(uint StreamNumber, uint Setting);
    ///Gets the stream source frequency divider value.
    ///Params:
    ///    StreamNumber = Type: [in] <b>UINT</b> Stream source number.
    ///    Divider = Type: [out] <b>UINT*</b> Returns the frequency divider value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetStreamSourceFreq(uint StreamNumber, uint* pSetting);
    ///Sets index data.
    ///Params:
    ///    pIndexData = Type: <b>IDirect3DIndexBuffer9*</b> Pointer to an IDirect3DIndexBuffer9 interface, representing the index
    ///                 data to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT SetIndices(IDirect3DIndexBuffer9 pIndexData);
    ///Retrieves index data.
    ///Params:
    ///    ppIndexData = Type: [out] <b>IDirect3DIndexBuffer9**</b> Address of a pointer to an IDirect3DIndexBuffer9 interface,
    ///                  representing the returned index data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetIndices(IDirect3DIndexBuffer9* ppIndexData);
    ///Creates a pixel shader.
    ///Params:
    ///    pFunction = Type: <b>const DWORD*</b> Pointer to the pixel shader function token array, specifying the blending
    ///                operations. This value cannot be <b>NULL</b>.
    ///    ppShader = Type: <b>IDirect3DPixelShader9**</b> Pointer to the returned pixel shader interface. See
    ///               IDirect3DPixelShader9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT CreatePixelShader(const(uint)* pFunction, IDirect3DPixelShader9* ppShader);
    ///Sets the current pixel shader to a previously created pixel shader.
    ///Params:
    ///    pShader = Type: <b>IDirect3DPixelShader9*</b> Pixel shader interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShader(IDirect3DPixelShader9 pShader);
    ///Retrieves the currently set pixel shader.
    ///Params:
    ///    ppShader = Type: <b>IDirect3DPixelShader9**</b> Pointer to a pixel shader interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShader(IDirect3DPixelShader9* ppShader);
    ///Sets a floating-point shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    ///Gets a floating-point shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>float*</b> Pointer to an array of constants.
    ///    Vector4fCount = Type: <b>UINT</b> Number of four float vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    ///Sets an integer shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    ///Gets an integer shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>int*</b> Pointer to an array of constants.
    ///    Vector4iCount = Type: <b>UINT</b> Number of four integer vectors in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    ///Sets a Boolean shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>const BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetPixelShaderConstantB(uint StartRegister, const(int)* pConstantData, uint BoolCount);
    ///Gets a Boolean shader constant.
    ///Params:
    ///    StartRegister = Type: <b>UINT</b> Register number that will contain the first constant value.
    ///    pConstantData = Type: <b>BOOL*</b> Pointer to an array of constants.
    ///    BoolCount = Type: <b>UINT</b> Number of Boolean values in the array of constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPixelShaderConstantB(uint StartRegister, int* pConstantData, uint BoolCount);
    ///Draws a rectangular patch using the currently set streams.
    ///Params:
    ///    Handle = Type: <b>UINT</b> Handle to the rectangular patch to draw.
    ///    pNumSegs = Type: <b>const float*</b> Pointer to an array of four floating-point values that identify the number of
    ///               segments each edge of the rectangle patch should be divided into when tessellated. See D3DRECTPATCH_INFO.
    ///    pRectPatchInfo = Type: <b>const D3DRECTPATCH_INFO*</b> Pointer to a D3DRECTPATCH_INFO structure, describing the rectangular
    ///                     patch to draw.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawRectPatch(uint Handle, const(float)* pNumSegs, const(D3DRECTPATCH_INFO)* pRectPatchInfo);
    ///Draws a triangular patch using the currently set streams.
    ///Params:
    ///    Handle = Type: <b>UINT</b> Handle to the triangular patch to draw.
    ///    pNumSegs = Type: <b>const float*</b> Pointer to an array of three floating-point values that identify the number of
    ///               segments each edge of the triangle patch should be divided into when tessellated. See D3DTRIPATCH_INFO.
    ///    pTriPatchInfo = Type: <b>const D3DTRIPATCH_INFO*</b> Pointer to a D3DTRIPATCH_INFO structure, describing the triangular
    ///                    high-order patch to draw.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DrawTriPatch(uint Handle, const(float)* pNumSegs, const(D3DTRIPATCH_INFO)* pTriPatchInfo);
    ///Frees a cached high-order patch.
    ///Params:
    ///    Handle = Type: <b>UINT</b> Handle of the cached high-order patch to delete.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT DeletePatch(uint Handle);
    ///Creates a status query.
    ///Params:
    ///    Type = Type: <b>D3DQUERYTYPE</b> Identifies the query type. For more information, see D3DQUERYTYPE.
    ///    ppQuery = Type: <b>IDirect3DQuery9**</b> Returns a pointer to the query interface that manages the query object. See
    ///              IDirect3DQuery9. This parameter can be set to <b>NULL</b> to see if a query is supported. If the query is not
    ///              supported, the method returns D3DERR_NOTAVAILABLE.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_NOTAVAILABLE or E_OUTOFMEMORY.
    ///    
    HRESULT CreateQuery(D3DQUERYTYPE Type, IDirect3DQuery9* ppQuery);
}

///Applications use the methods of the IDirect3DStateBlock9 interface to encapsulate render states.
@GUID("B07C4FE5-310D-4BA8-A23C-4F0F206F218B")
interface IDirect3DStateBlock9 : IUnknown
{
    ///Gets the device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Capture the current value of states that are included in a stateblock.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails because capture
    ///    cannot be done while in record mode, the return value is D3DERR_INVALIDCALL.
    ///    
    HRESULT Capture();
    ///Apply the state block to the current device state.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails while in record
    ///    mode, the return value is D3DERR_INVALIDCALL.
    ///    
    HRESULT Apply();
}

///Applications use the methods of the IDirect3DSwapChain9 interface to manipulate a swap chain.
@GUID("794950F2-ADFC-458A-905E-10A10B0B503B")
interface IDirect3DSwapChain9 : IUnknown
{
    ///Presents the contents of the next buffer in the sequence of back buffers owned by the swap chain.
    ///Params:
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to the source rectangle (see RECT). Use <b>NULL</b> to present the entire
    ///                  surface. This value must be <b>NULL</b> unless the swap chain was created with D3DSWAPEFFECT_COPY. If the
    ///                  rectangle exceeds the source surface, the rectangle is clipped to the source surface.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to the destination rectangle in client coordinates (see RECT). This value
    ///                must be <b>NULL</b> unless the swap chain was created with D3DSWAPEFFECT_COPY. Use <b>NULL</b> to fill the
    ///                entire client area. If the rectangle exceeds the destination client area, the rectangle is clipped to the
    ///                destination client area.
    ///    hDestWindowOverride = Type: <b>HWND</b> Destination window whose client area is taken as the target for this presentation. If this
    ///                          value is <b>NULL</b>, the runtime uses the <b>hDeviceWindow</b> member of D3DPRESENT_PARAMETERS for the
    ///                          presentation.
    ///    pDirtyRegion = Type: <b>const RGNDATA*</b> This value must be <b>NULL</b> unless the swap chain was created with
    ///                   D3DSWAPEFFECT_COPY. See Flipping Surfaces (Direct3D 9). If this value is non-<b>NULL</b>, the contained
    ///                   region is expressed in back buffer coordinates. The rectangles within the region are the minimal set of
    ///                   pixels that need to be updated. This method takes these rectangles into account when optimizing the
    ///                   presentation by copying only the pixels within the region, or some suitably expanded set of rectangles. This
    ///                   is an aid to optimization only, and the application should not rely on the region being copied exactly. The
    ///                   implementation may choose to copy the whole source rectangle.
    ///    dwFlags = Type: <b>DWORD</b> Allows the application to request that the method return immediately when the driver
    ///              reports that it cannot schedule a presentation. Valid values are 0, or any combination of
    ///              D3DPRESENT_DONOTWAIT or D3DPRESENT_LINEAR_CONTENT. <ul> <li>If dwFlags = 0, this method behaves as it did
    ///              prior to Direct3D 9. Present will spin until the hardware is free, without returning an error.</li> <li>If
    ///              dwFlags = D3DPRESENT_DONOTWAIT, and the hardware is busy processing or waiting for a vertical sync interval,
    ///              the method will return D3DERR_WASSTILLDRAWING.</li> <li>If dwFlags = D3DPRESENT_LINEAR_CONTENT, gamma
    ///              correction is performed from linear space to sRGB for windowed swap chains. This flag will take effect only
    ///              when the driver exposes D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION (see Gamma (Direct3D 9)). Appliations should
    ///              specify this flag if the backbuffer format is 16-bit floating point in order to match windowed mode present
    ///              to fullscreen gamma behavior.</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_DEVICELOST, D3DERR_DRIVERINTERNALERROR, D3DERR_INVALIDCALL,
    ///    D3DERR_OUTOFVIDEOMEMORY, E_OUTOFMEMORY.
    ///    
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                    const(RGNDATA)* pDirtyRegion, uint dwFlags);
    ///Generates a copy of the swapchain's front buffer and places that copy in a system memory buffer provided by the
    ///application.
    ///Params:
    ///    pDestSurface = Type: <b>IDirect3DSurface9*</b> Pointer to an IDirect3DSurface9 interface that will receive a copy of the
    ///                   swapchain's front buffer. The data is returned in successive rows with no intervening space, starting from
    ///                   the vertically highest row to the lowest. For windowed mode, the size of the destination surface should be
    ///                   the size of the desktop. For full screen mode, the size of the destination surface should be the screen size.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If BackBuffer exceeds or equals the
    ///    total number of back buffers, the function fails and returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFrontBufferData(IDirect3DSurface9 pDestSurface);
    ///Retrieves a back buffer from the swap chain of the device.
    ///Params:
    ///    iBackBuffer = Type: <b>UINT</b> Index of the back buffer object to return. Back buffers are numbered from 0 to the total
    ///                  number of back buffers - 1. A value of 0 returns the first back buffer, not the front buffer. The front
    ///                  buffer is not accessible through this method. Use IDirect3DSwapChain9::GetFrontBufferData to retrieve a copy
    ///                  of the front buffer.
    ///    Type = Type: <b>D3DBACKBUFFER_TYPE</b> Stereo view is not supported in Direct3D 9, so the only valid value for this
    ///           parameter is D3DBACKBUFFER_TYPE_MONO.
    ///    ppBackBuffer = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                   returned back buffer surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If BackBuffer exceeds or equals the
    ///    total number of back buffers, then the function fails and returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetBackBuffer(uint iBackBuffer, D3DBACKBUFFER_TYPE Type, IDirect3DSurface9* ppBackBuffer);
    ///Returns information describing the raster of the monitor on which the swap chain is presented.
    ///Params:
    ///    pRasterStatus = Type: <b>D3DRASTER_STATUS*</b> Pointer to a D3DRASTER_STATUS structure filled with information about the
    ///                    position or other status of the raster on the monitor driven by this adapter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    pRasterStatus is invalid or if the device does not support reading the current scan line. To determine if the
    ///    device supports reading the scan line, check for the D3DCAPS_READ_SCANLINE flag in the Caps member of
    ///    D3DCAPS9.
    ///    
    HRESULT GetRasterStatus(D3DRASTER_STATUS* pRasterStatus);
    ///Retrieves the display mode's spatial resolution, color resolution, and refresh frequency.
    ///Params:
    ///    pMode = Type: <b>D3DDISPLAYMODE*</b> Pointer to a D3DDISPLAYMODE structure containing data about the display mode of
    ///            the adapter. As opposed to the display mode of the device, which may not be active if the device does not own
    ///            full-screen mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayMode(D3DDISPLAYMODE* pMode);
    ///Retrieves the device associated with the swap chain.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Address of a pointer to an IDirect3DDevice9 interface to fill with the device
    ///               pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Retrieves the presentation parameters associated with a swap chain.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to the presentation parameters. See D3DPRESENT_PARAMETERS.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetPresentParameters(_D3DPRESENT_PARAMETERS_* pPresentationParameters);
}

///Applications use the methods of the <b>IDirect3DResource9</b> interface to query and prepare resources.
@GUID("05EEC05D-8F7D-4362-B999-D1BAF357C704")
interface IDirect3DResource9 : IUnknown
{
    ///Retrieves the device associated with a resource.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Address of a pointer to an IDirect3DDevice9 interface to fill with the device
    ///               pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Associates data with the resource that is intended for use by the application, not by Direct3D. Data is passed by
    ///value, and multiple sets of data can be associated with a single resource.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to set.
    ///    pData = Type: <b>const void*</b> Pointer to a buffer that contains the data to be associated with the resource.
    ///    SizeOfData = Type: <b>DWORD</b> Size of the buffer at pData, in bytes.
    ///    Flags = Type: <b>DWORD</b> Value that describes the type of data being passed, or indicates to the application that
    ///            the data should be invalidated when the resource changes. <table> <tr> <th>Item</th> <th>Description</th>
    ///            </tr> <tr> <td width="40%"> <a id="_none_"></a><a id="_NONE_"></a>(none) </td> <td width="60%"> If no flags
    ///            are specified, Direct3D allocates memory to hold the data within the buffer and copies the data into the new
    ///            buffer. The buffer allocated by Direct3D is automatically freed, as appropriate. </td> </tr> <tr> <td
    ///            width="40%"> <a id="D3DSPD_IUNKNOWN"></a><a id="d3dspd_iunknown"></a>D3DSPD_IUNKNOWN </td> <td width="60%">
    ///            The data at pData is a pointer to an IUnknown interface. SizeOfData must be set to the size of a pointer to
    ///            IUnknown, that is, sizeof(IUnknown*). Direct3D automatically callsIUnknown through pData when the private
    ///            data is destroyed. Private data will be destroyed by a subsequent call to
    ///            <b>IDirect3DResource9::SetPrivateData</b> with the same GUID, a subsequent call to
    ///            IDirect3DResource9::FreePrivateData, or when the IDirect3D9 object is released. For more information, see
    ///            Remarks. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, E_OUTOFMEMORY.
    ///    
    HRESULT SetPrivateData(const(GUID)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    ///Copies the private data associated with the resource to a provided buffer.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> The globally unique identifier that identifies the private data to retrieve.
    ///    pData = Type: <b>void*</b> Pointer to a previously allocated buffer to fill with the requested private data if the
    ///            call succeeds. The application calling this method is responsible for allocating and releasing this buffer.
    ///            If this parameter is <b>NULL</b>, this method will return the buffer size in pSizeOfData.
    ///    pSizeOfData = Type: <b>DWORD*</b> Pointer to the size of the buffer at pData, in bytes. If this value is less than the
    ///                  actual size of the private data (such as 0), the method sets this parameter to the required buffer size and
    ///                  the method returns D3DERR_MOREDATA.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_MOREDATA, D3DERR_NOTFOUND.
    ///    
    HRESULT GetPrivateData(const(GUID)* refguid, void* pData, uint* pSizeOfData);
    ///Frees the specified private data associated with this resource.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to free.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_NOTFOUND.
    ///    
    HRESULT FreePrivateData(const(GUID)* refguid);
    ///Assigns the priority of a resource for scheduling purposes.
    ///Params:
    ///    PriorityNew = Type: <b>DWORD</b> Priority to assign to a resource. <table> <tr> <td> Differences between Direct3D 9 and
    ///                  Direct3D 9 for Windows Vista The priority can be any DWORD value; Direct3D 9 for Windows Vista also supports
    ///                  any of these pre-defined values D3D9_RESOURCE_PRIORITY. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>DWORD</b> Returns the previous priority value for the resource.
    ///    
    uint    SetPriority(uint PriorityNew);
    ///Retrieves the priority for this resource.
    ///Returns:
    ///    Type: <b>DWORD</b> Returns a DWORD value, indicating the priority of the resource.
    ///    
    uint    GetPriority();
    ///Preloads a managed resource.
    void    PreLoad();
    ///Returns the type of the resource.
    ///Returns:
    ///    Type: <b>D3DRESOURCETYPE</b> Returns a member of the D3DRESOURCETYPE enumerated type, identifying the type of
    ///    the resource.
    ///    
    D3DRESOURCETYPE GetType();
}

///Applications use the methods of the IDirect3DVertexDeclaration9 interface to encapsulate the vertex shader
///declaration.
@GUID("DD13C59C-36FA-4098-A8FB-C7ED39DC8546")
interface IDirect3DVertexDeclaration9 : IUnknown
{
    ///Gets the current device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets the vertex shader declaration.
    ///Params:
    ///    pElement = Type: [in, out] <b>D3DVERTEXELEMENT9*</b> Array of vertex elements (see D3DVERTEXELEMENT9) that make up a
    ///               vertex shader declaration. The application needs to allocate enough room for this. The vertex element array
    ///               ends with the D3DDECL_END macro.
    ///    pNumElements = Type: [out] <b>UINT*</b> Number of elements in the array. The application needs to allocate enough room for
    ///                   this.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDeclaration(D3DVERTEXELEMENT9* pElement, uint* pNumElements);
}

///Applications use the methods of the IDirect3DVertexShader9 interface to encapsulate the functionality of a vertex
///shader.
@GUID("EFC5557E-6265-4613-8A94-43857889EB36")
interface IDirect3DVertexShader9 : IUnknown
{
    ///Gets the device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets a pointer to the shader data.
    ///Params:
    ///    arg1 = Type: <b>void*</b> Pointer to a buffer that contains the shader data. The application needs to allocate
    ///           enough room for this.
    ///    pSizeOfData = Type: <b>UINT*</b> Size of the data, in bytes. To get the buffer size that is needed to retrieve the data,
    ///                  set pData = <b>NULL</b> when calling GetFunction. Then call GetFunction with the returned size, to get the
    ///                  buffer data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

///Applications use the methods of the IDirect3DPixelShader9 interface to encapsulate the functionality of a pixel
///shader.
@GUID("6D3BDBDC-5B02-4415-B852-CE5E8BCCB289")
interface IDirect3DPixelShader9 : IUnknown
{
    ///Gets the device.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the IDirect3DDevice9 interface that is returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets a pointer to the shader data.
    ///Params:
    ///    arg1 = Type: <b>void*</b> Pointer to a buffer that contains the shader data. The application needs to allocate
    ///           enough room for this.
    ///    pSizeOfData = Type: <b>UINT*</b> Size of the data, in bytes. To get the buffer size that is needed to retrieve the data,
    ///                  set pData = <b>NULL</b> when calling GetFunction. Then call GetFunction with the returned size, to get the
    ///                  buffer data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

///Applications use the methods of the IDirect3DBaseTexture9 interface to manipulate texture resources including cube
///and volume textures.
@GUID("580CA87E-1D3C-4D54-991D-B7D3E3C298CE")
interface IDirect3DBaseTexture9 : IDirect3DResource9
{
    ///Sets the most detailed level-of-detail for a managed texture.
    ///Params:
    ///    LODNew = Type: <b>DWORD</b> Most detailed level-of-detail value to set for the mipmap chain.
    ///Returns:
    ///    Type: <b>DWORD</b> A DWORD value, clamped to the maximum level-of-detail value (one less than the total
    ///    number of levels). Subsequent calls to this method will return the clamped value, not the level-of-detail
    ///    value that was previously set.
    ///    
    uint    SetLOD(uint LODNew);
    ///Returns a value clamped to the maximum level-of-detail set for a managed texture (this method is not supported
    ///for an unmanaged texture).
    ///Returns:
    ///    Type: <b>DWORD</b> A DWORD value, clamped to the maximum level-of-detail value (one less than the total
    ///    number of levels). Calling <b>GetLOD</b> on an unmanaged texture is not supported and will result in a D3DERR
    ///    error code being returned.
    ///    
    uint    GetLOD();
    ///Returns the number of texture levels in a multilevel texture.
    ///Returns:
    ///    Type: <b>DWORD</b> A DWORD value that indicates the number of texture levels in a multilevel texture.
    ///    
    uint    GetLevelCount();
    ///Set the filter type that is used for automatically generated mipmap sublevels.
    ///Params:
    ///    FilterType = Type: <b>D3DTEXTUREFILTERTYPE</b> Filter type. See D3DTEXTUREFILTERTYPE. This method will fail if the filter
    ///                 type is invalid or not supported.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT SetAutoGenFilterType(D3DTEXTUREFILTERTYPE FilterType);
    ///Get the filter type that is used for automatically generated mipmap sublevels.
    ///Returns:
    ///    Type: <b>D3DTEXTUREFILTERTYPE</b> Filter type. See D3DTEXTUREFILTERTYPE. A texture must be created with
    ///    D3DUSAGE_AUTOGENMIPMAP to use this method. Any other usage value will cause this method to return
    ///    D3DTEXF_NONE.
    ///    
    D3DTEXTUREFILTERTYPE GetAutoGenFilterType();
    ///Generate mipmap sublevels.
    void    GenerateMipSubLevels();
}

///Applications use the methods of the IDirect3DTexture9 interface to manipulate a texture resource.
@GUID("85C31227-3DE5-4F00-9B3A-F11AC38C18B5")
interface IDirect3DTexture9 : IDirect3DBaseTexture9
{
    ///Retrieves a level description of a texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the texture resource. This method returns a surface description for
    ///            the level specified by this parameter.
    ///    pDesc = Type: <b>D3DSURFACE_DESC*</b> Pointer to a D3DSURFACE_DESC structure, describing the returned level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one of the arguments is invalid.
    ///    
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    ///Retrieves the specified texture surface level.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the texture resource. This method returns a surface for the level
    ///            specified by this parameter. The top-level surface is denoted by 0.
    ///    ppSurfaceLevel = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                     returned surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one D3DERR_INVALIDCALL.
    ///    
    HRESULT GetSurfaceLevel(uint Level, IDirect3DSurface9* ppSurfaceLevel);
    ///Locks a rectangle on a texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the texture resource to lock.
    ///    pLockedRect = Type: <b>D3DLOCKED_RECT*</b> Pointer to a D3DLOCKED_RECT structure, describing the locked region.
    ///    pRect = Type: <b>const RECT*</b> Pointer to a rectangle to lock. Specified by a pointer to a RECT structure.
    ///            Specifying <b>NULL</b> for this parameter expands the dirty region to cover the entire texture.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> You may not specify a subrect when using
    ///            D3DLOCK_DISCARD. For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LockRect(uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    ///Unlocks a rectangle on a texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the texture resource to unlock.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockRect(uint Level);
    ///Adds a dirty region to a texture resource.
    ///Params:
    ///    pDirtyRect = Type: <b>const RECT*</b> Pointer to a RECT structure, specifying the dirty region to add. Specifying
    ///                 <b>NULL</b> expands the dirty region to cover the entire texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT AddDirtyRect(const(RECT)* pDirtyRect);
}

///Applications use the methods of the IDirect3DVolumeTexture9 interface to manipulate a volume texture resource.
@GUID("2518526C-E789-4111-A7B9-47EF328D13E6")
interface IDirect3DVolumeTexture9 : IDirect3DBaseTexture9
{
    ///Retrieves a level description of a volume texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the volume texture resource. This method returns a volume description
    ///            for the level specified by this parameter.
    ///    pDesc = Type: <b>D3DVOLUME_DESC*</b> Pointer to a D3DVOLUME_DESC structure, describing the returned volume texture
    ///            level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one or more of the arguments are invalid.
    ///    
    HRESULT GetLevelDesc(uint Level, D3DVOLUME_DESC* pDesc);
    ///Retrieves the specified volume texture level.
    ///Params:
    ///    Level = Type: <b>UINT</b> Identifies a level of the volume texture resource. This method returns a volume for the
    ///            level specified by this parameter.
    ///    ppVolumeLevel = Type: <b>IDirect3DVolume9**</b> Address of a pointer to an IDirect3DVolume9 interface, representing the
    ///                    returned volume level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetVolumeLevel(uint Level, IDirect3DVolume9* ppVolumeLevel);
    ///Locks a box on a volume texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the volume texture resource to lock.
    ///    pLockedVolume = Type: <b>D3DLOCKED_BOX*</b> Pointer to a D3DLOCKED_BOX structure, describing the locked region.
    ///    pBox = Type: <b>const D3DBOX*</b> Pointer to the volume to lock. This parameter is specified by a pointer to a
    ///           D3DBOX structure. Specifying <b>NULL</b> for this parameter locks the entire volume level.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LockBox(uint Level, D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    ///Unlocks a box on a volume texture resource.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies the level of the volume texture resource to unlock.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockBox(uint Level);
    ///Adds a dirty region to a volume texture resource.
    ///Params:
    ///    pDirtyBox = Type: <b>const D3DBOX*</b> Pointer to a D3DBOX structure, specifying the dirty region to add. Specifying
    ///                <b>NULL</b> expands the dirty region to cover the entire volume texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT AddDirtyBox(const(D3DBOX)* pDirtyBox);
}

///Applications use the methods of the IDirect3DCubeTexture9 interface to manipulate a cube texture resource.
@GUID("FFF32F81-D953-473A-9223-93D652ABA93F")
interface IDirect3DCubeTexture9 : IDirect3DBaseTexture9
{
    ///Retrieves a description of one face of the specified cube texture level.
    ///Params:
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///    pDesc = Type: <b>D3DSURFACE_DESC*</b> Pointer to a D3DSURFACE_DESC structure, describing one face of the specified
    ///            cube texture level.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    ///Retrieves a cube texture map surface.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying a cube map face.
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///    ppCubeMapSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                       returned cube texture map surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT GetCubeMapSurface(D3DCUBEMAP_FACES FaceType, uint Level, IDirect3DSurface9* ppCubeMapSurface);
    ///Locks a rectangle on a cube texture resource.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying a cube map face.
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///    pLockedRect = Type: <b>D3DLOCKED_RECT*</b> Pointer to a D3DLOCKED_RECT structure, describing the region to lock.
    ///    pRect = Type: <b>const RECT*</b> Pointer to a rectangle to lock. Specified by a pointer to a RECT structure.
    ///            Specifying <b>NULL</b> for this parameter expands the dirty region to cover the entire cube texture.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> You may not specify a subrect when using
    ///            D3DLOCK_DISCARD. For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    one or more of the arguments is invalid.
    ///    
    HRESULT LockRect(D3DCUBEMAP_FACES FaceType, uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, 
                     uint Flags);
    ///Unlocks a rectangle on a cube texture resource.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying a cube map face.
    ///    Level = Type: <b>UINT</b> Specifies a level of a mipmapped cube texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockRect(D3DCUBEMAP_FACES FaceType, uint Level);
    ///Adds a dirty region to a cube texture resource.
    ///Params:
    ///    FaceType = Type: <b>D3DCUBEMAP_FACES</b> Member of the D3DCUBEMAP_FACES enumerated type, identifying the cube map face.
    ///    pDirtyRect = Type: <b>const RECT*</b> Pointer to a RECT structure, specifying the dirty region. Specifying <b>NULL</b>
    ///                 expands the dirty region to cover the entire cube texture.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be: D3DERR_INVALIDCALL.
    ///    
    HRESULT AddDirtyRect(D3DCUBEMAP_FACES FaceType, const(RECT)* pDirtyRect);
}

///Applications use the methods of the IDirect3DVertexBuffer9 interface to manipulate vertex buffer resources.
@GUID("B64BB1B5-FD70-4DF6-BF91-19D0A12455E3")
interface IDirect3DVertexBuffer9 : IDirect3DResource9
{
    ///Locks a range of vertex data and obtains a pointer to the vertex buffer memory.
    ///Params:
    ///    OffsetToLock = Type: <b>UINT</b> Offset into the vertex data to lock, in bytes. To lock the entire vertex buffer, specify 0
    ///                   for both parameters, SizeToLock and OffsetToLock.
    ///    SizeToLock = Type: <b>UINT</b> Size of the vertex data to lock, in bytes. To lock the entire vertex buffer, specify 0 for
    ///                 both parameters, SizeToLock and OffsetToLock.
    ///    ppbData = Type: <b>VOID**</b> VOID* pointer to a memory buffer containing the returned vertex data.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> <li>D3DLOCK_NOOVERWRITE</li> </ul> For a description of
    ///            the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    ///Unlocks vertex data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Unlock();
    ///Retrieves a description of the vertex buffer resource.
    ///Params:
    ///    pDesc = Type: <b>D3DVERTEXBUFFER_DESC*</b> Pointer to a D3DVERTEXBUFFER_DESC structure, describing the returned
    ///            vertex buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DVERTEXBUFFER_DESC* pDesc);
}

///Applications use the methods of the IDirect3DIndexBuffer9 interface to manipulate an index buffer resource.
@GUID("7C9DD65E-D3F7-4529-ACEE-785830ACDE35")
interface IDirect3DIndexBuffer9 : IDirect3DResource9
{
    ///Locks a range of index data and obtains a pointer to the index buffer memory.
    ///Params:
    ///    OffsetToLock = Type: <b>UINT</b> Offset into the index data to lock, in bytes. Lock the entire index buffer by specifying 0
    ///                   for both parameters, SizeToLock and OffsetToLock.
    ///    SizeToLock = Type: <b>UINT</b> Size of the index data to lock, in bytes. Lock the entire index buffer by specifying 0 for
    ///                 both parameters, SizeToLock and OffsetToLock.
    ///    ppbData = Type: <b>VOID**</b> VOID* pointer to a memory buffer containing the returned index data.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> <li>D3DLOCK_NOOVERWRITE</li> </ul> For a description of
    ///            the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    ///Unlocks index data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Unlock();
    ///Retrieves a description of the index buffer resource.
    ///Params:
    ///    pDesc = Type: <b>D3DINDEXBUFFER_DESC*</b> Pointer to a D3DINDEXBUFFER_DESC structure, describing the returned index
    ///            buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DINDEXBUFFER_DESC* pDesc);
}

///Applications use the methods of the IDirect3DSurface9 interface to query and prepare surfaces.
@GUID("0CFBAF3A-9FF6-429A-99B3-A2796AF8B89B")
interface IDirect3DSurface9 : IDirect3DResource9
{
    ///Provides access to the parent cube texture or texture (mipmap) object, if this surface is a child level of a cube
    ///texture or a mipmap. This method can also provide access to the parent swap chain if the surface is a back-buffer
    ///child.
    ///Params:
    ///    riid = Type: <b>REFIID</b> Reference identifier of the container being requested.
    ///    ppContainer = Type: <b>void**</b> Address of a pointer to fill with the container pointer if the query succeeds. See
    ///                  Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetContainer(const(GUID)* riid, void** ppContainer);
    ///Retrieves a description of the surface.
    ///Params:
    ///    pDesc = Type: <b>D3DSURFACE_DESC*</b> Pointer to a D3DSURFACE_DESC structure, describing the surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DSURFACE_DESC* pDesc);
    ///Locks a rectangle on a surface.
    ///Params:
    ///    pLockedRect = Type: <b>D3DLOCKED_RECT*</b> Pointer to a D3DLOCKED_RECT structure that describes the locked region.
    ///    pRect = Type: <b>const RECT*</b> Pointer to a rectangle to lock. Specified by a pointer to a RECT structure.
    ///            Specifying <b>NULL</b> for this parameter expands the dirty region to cover the entire surface.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_DONOTWAIT</li>
    ///            <li>D3DLOCK_NO_DIRTY_UPDATE</li> <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> You may not
    ///            specify a subrect when using D3DLOCK_DISCARD. For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL or D3DERR_WASSTILLDRAWING.
    ///    
    HRESULT LockRect(D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    ///Unlocks a rectangle on a surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockRect();
    ///Retrieves a device context.
    ///Params:
    ///    phdc = Type: <b>HDC*</b> Pointer to the device context for the surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDC(HDC* phdc);
    ///Release a device context handle.
    ///Params:
    ///    hdc = Type: <b>HDC</b> Handle to a device context.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT ReleaseDC(HDC hdc);
}

///Applications use the methods of the <b>IDirect3DVolume9</b> interface to manipulate volume resources.
@GUID("24F416E6-1F67-4AA7-B88E-D33F6F3128A1")
interface IDirect3DVolume9 : IUnknown
{
    ///Retrieves the device associated with a volume.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Address of a pointer to an IDirect3DDevice9 interface to fill with the device
    ///               pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Associates data with the volume that is intended for use by the application, not by Direct3D.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to set.
    ///    pData = Type: <b>const void*</b> Pointer to a buffer that contains the data to associate with the volume.
    ///    SizeOfData = Type: <b>DWORD</b> Size of the buffer at pData in bytes.
    ///    Flags = Type: <b>DWORD</b> Value that describes the type of data being passed, or indicates to the application that
    ///            the data should be invalidated when the resource changes. <table> <tr> <th>Item</th> <th>Description</th>
    ///            </tr> <tr> <td width="40%"> <a id="_none_"></a><a id="_NONE_"></a>(none) </td> <td width="60%"> If no flags
    ///            are specified, Direct3D allocates memory to hold the data within the buffer and copies the data into the new
    ///            buffer. The buffer allocated by Direct3D is automatically freed, as appropriate. </td> </tr> <tr> <td
    ///            width="40%"> <a id="D3DSPD_IUNKNOWN"></a><a id="d3dspd_iunknown"></a>D3DSPD_IUNKNOWN </td> <td width="60%">
    ///            The data at pData is a pointer to an IUnknown interface. SizeOfData must be set to the size of a pointer to
    ///            an <b>IUnknown</b> interface, sizeof(IUnknown*). Direct3D automatically calls <b>IUnknown</b> through pData
    ///            and IUnknown when the private data is destroyed. Private data will be destroyed by a subsequent call to
    ///            <b>IDirect3DVolume9::SetPrivateData</b> with the same GUID, a subsequent call to
    ///            IDirect3DVolume9::FreePrivateData, or when the IDirect3D9 object is released. For more information, see
    ///            Remarks. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, E_OUTOFMEMORY.
    ///    
    HRESULT SetPrivateData(const(GUID)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    ///Copies the private data associated with the volume to a provided buffer.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to (C++) or address of (C) the globally unique identifier that identifies the
    ///              private data to retrieve.
    ///    pData = Type: <b>void*</b> Pointer to a previously allocated buffer to fill with the requested private data if the
    ///            call succeeds. The application calling this method is responsible for allocating and releasing this buffer.
    ///            If this parameter is <b>NULL</b>, this method will return the buffer size in pSizeOfData.
    ///    pSizeOfData = Type: <b>DWORD*</b> Pointer to the size of the buffer at pData, in bytes. If this value is less than the
    ///                  actual size of the private data, such as 0, the method sets this parameter to the required buffer size, and
    ///                  the method returns D3DERR_MOREDATA.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_MOREDATA, D3DERR_NOTFOUND.
    ///    
    HRESULT GetPrivateData(const(GUID)* refguid, void* pData, uint* pSizeOfData);
    ///Frees the specified private data associated with this volume.
    ///Params:
    ///    refguid = Type: <b>REFGUID</b> Reference to the globally unique identifier that identifies the private data to free.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_INVALIDCALL, D3DERR_NOTFOUND.
    ///    
    HRESULT FreePrivateData(const(GUID)* refguid);
    ///Provides access to the parent volume texture object, if this surface is a child level of a volume texture.
    ///Params:
    ///    riid = Type: <b>REFIID</b> Reference identifier of the volume being requested.
    ///    ppContainer = Type: <b>void**</b> Address of a pointer to fill with the container pointer, if the query succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetContainer(const(GUID)* riid, void** ppContainer);
    ///Retrieves a description of the volume.
    ///Params:
    ///    pDesc = Type: <b>D3DVOLUME_DESC*</b> Pointer to a D3DVOLUME_DESC structure, describing the volume.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. D3DERR_INVALIDCALL is returned if
    ///    the argument is invalid.
    ///    
    HRESULT GetDesc(D3DVOLUME_DESC* pDesc);
    ///Locks a box on a volume resource.
    ///Params:
    ///    pLockedVolume = Type: <b>D3DLOCKED_BOX*</b> Pointer to a D3DLOCKED_BOX structure, describing the locked region.
    ///    pBox = Type: <b>const D3DBOX*</b> Pointer to a box to lock. Specified by a pointer to a D3DBOX structure. Specifying
    ///           <b>NULL</b> for this parameter locks the entire volume.
    ///    Flags = Type: <b>DWORD</b> Combination of zero or more locking flags that describe the type of lock to perform. For
    ///            this method, the valid flags are: <ul> <li>D3DLOCK_DISCARD</li> <li>D3DLOCK_NO_DIRTY_UPDATE</li>
    ///            <li>D3DLOCK_NOSYSLOCK</li> <li>D3DLOCK_READONLY</li> </ul> For a description of the flags, see D3DLOCK.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT LockBox(D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    ///Unlocks a box on a volume resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT UnlockBox();
}

///Applications use the methods of the IDirect3DQuery9 interface to perform asynchronous queries on a driver.
@GUID("D9771460-A695-4F26-BBD3-27B840B541CC")
interface IDirect3DQuery9 : IUnknown
{
    ///Gets the device that is being queried.
    ///Params:
    ///    ppDevice = Type: <b>IDirect3DDevice9**</b> Pointer to the device being queried. See IDirect3DDevice9.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    ///Gets the query type.
    ///Returns:
    ///    Type: <b>D3DQUERYTYPE</b> Returns the query type. See D3DQUERYTYPE.
    ///    
    D3DQUERYTYPE GetType();
    ///Gets the number of bytes in the query data.
    ///Returns:
    ///    Type: <b>DWORD</b> Returns the number of bytes of query data.
    ///    
    uint    GetDataSize();
    ///Issue a query.
    ///Params:
    ///    dwIssueFlags = Type: <b>DWORD</b> Query flags specify the type of state change for the query. See D3DISSUE_BEGIN and
    ///                   D3DISSUE_END.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT Issue(uint dwIssueFlags);
    ///Polls a queried resource to get the query state or a query result. For more information about queries, see
    ///Queries (Direct3D 9).
    ///Params:
    ///    pData = Type: <b>void*</b> Pointer to a buffer containing the query data. The user is responsible for allocating
    ///            this. <i>pData</i> may be <b>NULL</b> only if dwSize is 0.
    ///    dwSize = Type: <b>DWORD</b> Number of bytes of data in <i>pData</i>. If you set dwSize to zero, you can use this
    ///             method to poll the resource for the query status. See remarks.
    ///    dwGetDataFlags = Type: <b>DWORD</b> Data flags specifying the query type. Valid values are either 0 or D3DGETDATA_FLUSH. Use 0
    ///                     to avoid flushing batched queries to the driver and use D3DGETDATA_FLUSH to go ahead and flush them. For
    ///                     applications writing their own version of waiting, a query result is not realized until the driver receives a
    ///                     flush.
    ///Returns:
    ///    Type: <b>HRESULT</b> The return type identifies the query state (see Queries (Direct3D 9)). The method
    ///    returns S_OK if the query data is available and S_FALSE if it is not. These are considered successful return
    ///    values. If the method fails when D3DGETDATA_FLUSH is used, the return value can be D3DERR_DEVICELOST.
    ///    
    HRESULT GetData(void* pData, uint dwSize, uint dwGetDataFlags);
}

///Applications use the methods of the <b>IDirect3D9Ex</b> interface (which inherits from IDirect3D9) to create
///Microsoft Direct3D 9Ex objects and set up the environment. This interface includes methods for enumerating and
///retrieving capabilities of the device and is available when the underlying device implementation is compliant with
///Windows Vista.
@GUID("02177241-69FC-400C-8FF1-93A44DF6861D")
interface IDirect3D9Ex : IDirect3D9
{
    ///Returns the number of display modes available.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter from which to retrieve the display mode count.
    ///    pFilter = Type: <b>const D3DDISPLAYMODEFILTER*</b> Specifies the characteristics of the desired display mode. See
    ///              D3DDISPLAYMODEFILTER.
    ///Returns:
    ///    Type: <b>UINT</b> The number of display modes available. A return of value zero from this method is an
    ///    indication that no such display mode is supported or simply this monitor is no longer available.
    ///    
    uint    GetAdapterModeCountEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter);
    ///This method returns the actual display mode info based on the given mode index.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter to enumerate. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter. This method returns D3DERR_INVALIDCALL when this value equals or exceeds the number
    ///              of display adapters in the system.
    ///    pFilter = Type: <b>const D3DDISPLAYMODEFILTER*</b> See D3DDISPLAYMODEFILTER.
    ///    Mode = Type: <b>UINT</b> Represents the display-mode index which is an unsigned integer between zero and the value
    ///           returned by GetAdapterModeCount minus one.
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> A pointer to the available display mode of type D3DDISPLAYMODEEX.
    ///Returns:
    ///    Type: <b>HRESULT</b> <ul> <li>If the device can be used on this adapter, D3D_OK is returned.</li> <li>If the
    ///    Adapter equals or exceeds the number of display adapters in the system, D3DERR_INVALIDCALL is returned.</li>
    ///    </ul>
    ///    
    HRESULT EnumAdapterModesEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter, uint Mode, 
                               D3DDISPLAYMODEEX* pMode);
    ///Retrieves the current display mode and rotation settings of the adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter to query. D3DADAPTER_DEFAULT is always the
    ///              primary display adapter.
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure containing data about the display mode
    ///            of the adapter. As opposed to the display mode of the device, which may not be active if the device does not
    ///            own full-screen mode. Can be set to <b>NULL</b>.
    ///    pRotation = Type: <b>D3DDISPLAYROTATION*</b> Pointer to a D3DDISPLAYROTATION structure indicating the type of screen
    ///                rotation the application will do. The value returned through this pointer is important when the
    ///                D3DPRESENTFLAG_NOAUTOROTATE flag is used; otherwise, it can be set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If <i>Adapter</i> is out of range or
    ///    <i>pMode</i> is invalid, this method returns D3DERR_INVALIDCALL.
    ///    
    HRESULT GetAdapterDisplayModeEx(uint Adapter, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
    ///Creates a device to represent the display adapter.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number that denotes the display adapter. D3DADAPTER_DEFAULT is always the primary
    ///              display adapter.
    ///    DeviceType = Type: <b>D3DDEVTYPE</b> Specifies the type of device. See D3DDEVTYPE. If the desired device type is not
    ///                 available, the method will fail.
    ///    hFocusWindow = Type: <b>HWND</b> The focus window alerts Direct3D when an application switches from foreground mode to
    ///                   background mode. For full-screen mode, the window specified must be a top-level window. For windowed mode,
    ///                   this parameter may be <b>NULL</b> only if the hDeviceWindow member of pPresentationParameters is set to a
    ///                   valid, non-<b>NULL</b> value.
    ///    BehaviorFlags = Type: <b>DWORD</b> Combination of one or more options (see D3DCREATE) that control device creation.
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the presentation
    ///                              parameters for the device to be created. If <i>BehaviorFlags</i> specifies D3DCREATE_ADAPTERGROUP_DEVICE,
    ///                              this parameter is an array. Regardless of the number of heads that exist, only one depth/stencil surface is
    ///                              automatically created. This parameter is both an input and an output parameter. Calling this method may
    ///                              change several members including: <ul> <li>If BackBufferCount, BackBufferWidth, and BackBufferHeight are 0
    ///                              before the method is called, they will be changed when the method returns.</li> <li>If BackBufferFormat
    ///                              equals D3DFMT_UNKNOWN before the method is called, it will be changed when the method returns.</li> </ul>
    ///    pFullscreenDisplayMode = Type: <b>D3DDISPLAYMODEEX*</b> The display mode for when the device is set to fullscreen. See
    ///                             D3DDISPLAYMODEEX. If <i>BehaviorFlags</i> specifies D3DCREATE_ADAPTERGROUP_DEVICE, this parameter is an
    ///                             array. This parameter must be <b>NULL</b> for windowed mode.
    ///    ppReturnedDeviceInterface = Type: <b>IDirect3DDevice9Ex**</b> Address of a pointer to the returned IDirect3DDevice9Ex, which represents
    ///                                the created device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns S_OK when rendering device along with swapchain buffers are created
    ///    successfully. D3DERR_DEVICELOST is returned when any error other than invalid caller input is encountered.
    ///    
    HRESULT CreateDeviceEx(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, 
                           _D3DPRESENT_PARAMETERS_* pPresentationParameters, 
                           D3DDISPLAYMODEEX* pFullscreenDisplayMode, IDirect3DDevice9Ex* ppReturnedDeviceInterface);
    ///This method returns a unique identifier for the adapter that is specific to the adapter hardware. Applications
    ///can use this identifier to define robust mappings across various APIs (Direct3D 9, DXGI).
    ///Params:
    ///    Adapter = Type: <b>UINT</b> Ordinal number denoting the display adapter from which to retrieve the LUID.
    ///    pLUID = Type: <b>LUID*</b> A unique identifier for the given adapter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAdapterLUID(uint Adapter, LUID* pLUID);
}

///Applications use the methods of the IDirect3DDevice9Ex interface to render primitives, create resources, work with
///system-level variables, adjust gamma ramp levels, work with palettes, and create shaders. The IDirect3DDevice9Ex
///interface derives from the IDirect3DDevice9 interface.
@GUID("B18B10CE-2649-405A-870F-95F777D4313A")
interface IDirect3DDevice9Ex : IDirect3DDevice9
{
    ///Prepare the texture sampler for monochrome convolution filtering on a single-color texture.
    ///Params:
    ///    width = Type: <b>UINT</b> The width of the filter kernel; ranging from 1 - D3DCONVOLUTIONMONO_MAXWIDTH. The default
    ///            value is 1.
    ///    height = Type: <b>UINT</b> The height of the filter kernel; ranging from 1 - D3DCONVOLUTIONMONO_MAXHEIGHT. The default
    ///             value is 1.
    ///    rows = Type: <b>float*</b> An array of weights, one weight for each kernel sub-element in the width. This parameter
    ///           must be <b>NULL</b>, which will set the weights equal to the default value.
    ///    columns = Type: <b>float*</b> An array of weights, one weight for each kernel sub-element in the height. This parameter
    ///              must be <b>NULL</b>, which will set the weights equal to the default value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.
    ///    
    HRESULT SetConvolutionMonoKernel(uint width, uint height, float* rows, float* columns);
    ///Copy a text string to one surface using an alphabet of glyphs on another surface. Composition is done by the GPU
    ///using bitwise operations.
    ///Params:
    ///    pSrc = Type: <b>IDirect3DSurface9*</b> A pointer to a source surface (prepared by IDirect3DSurface9) that supplies
    ///           the alphabet glyphs. This surface must be created with the D3DUSAGE_TEXTAPI flag.
    ///    pDst = Type: <b>IDirect3DSurface9*</b> A pointer to the destination surface (prepared by IDirect3DSurface9) that
    ///           receives the glyph data. The surface must be part of a texture.
    ///    pSrcRectDescs = Type: <b>IDirect3DVertexBuffer9*</b> A pointer to a vertex buffer (see IDirect3DVertexBuffer9) containing
    ///                    rectangles (see D3DCOMPOSERECTDESC) that enclose the desired glyphs in the source surface.
    ///    NumRects = Type: <b>UINT</b> The number of rectangles or glyphs that are used in the operation. The number applies to
    ///               both the source and destination surfaces. The range is 0 to D3DCOMPOSERECTS_MAXNUMRECTS.
    ///    pDstRectDescs = Type: <b>IDirect3DVertexBuffer9*</b> A pointer to a vertex buffer (see IDirect3DVertexBuffer9) containing
    ///                    rectangles (see D3DCOMPOSERECTDESTINATION) that describe the destination to which the indicated glyph from
    ///                    the source surface will be copied.
    ///    Operation = Type: <b>D3DCOMPOSERECTSOP</b> Specifies how to combine the source and destination surfaces. See
    ///                D3DCOMPOSERECTSOP.
    ///    Xoffset = Type: <b>INT</b> A value added to the <i>x</i> coordinates of all destination rectangles. This value can be
    ///              negative, which may cause the glyph to be rejected or clipped if the result is beyond the bounds of the
    ///              surface.
    ///    Yoffset = Type: <b>INT</b> A value added to the <i>y</i> coordinates of all destination rectangles. This value can be
    ///              negative, which may cause the glyph to be rejected or clipped if the result is beyond the bounds of the
    ///              surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK.
    ///    
    HRESULT ComposeRects(IDirect3DSurface9 pSrc, IDirect3DSurface9 pDst, IDirect3DVertexBuffer9 pSrcRectDescs, 
                         uint NumRects, IDirect3DVertexBuffer9 pDstRectDescs, D3DCOMPOSERECTSOP Operation, 
                         int Xoffset, int Yoffset);
    ///Swap the swapchain's next buffer with the front buffer.
    ///Params:
    ///    pSourceRect = Type: <b>const RECT*</b> Pointer to a RECT structure indicating region on the source surface to copy in
    ///                  window client coordinates. Only applies when the swapchain was created with the D3DSWAPEFFECT_COPY flag. If
    ///                  <b>NULL</b>, the entire source surface is presented. If the rectangle exceeds the source surface, it is
    ///                  clipped to the source surface.
    ///    pDestRect = Type: <b>const RECT*</b> Pointer to RECT structure indicating the target region on the destination surface in
    ///                window client coordinates. Only applies when the swapchain was created with the D3DSWAPEFFECT_COPY flag. If
    ///                <b>NULL</b>, the entire client area is filled. If the rectangle exceeds the destination client area, it is
    ///                clipped to the destination client area.
    ///    hDestWindowOverride = Type: <b>HWND</b> Pointer to a destination window whose client area is taken as the target for this
    ///                          presentation. If this value is <b>NULL</b>, the runtime uses the <b>hDeviceWindow</b> member of
    ///                          D3DPRESENT_PARAMETERS for the presentation. <div class="alert"><b>Note</b> If you create a swap chain with
    ///                          D3DSWAPEFFECT_FLIPEX, you must pass <b>NULL</b> to <i>hDestWindowOverride</i></div> <div> </div>
    ///    pDirtyRegion = Type: <b>const RGNDATA*</b> Pointer to a RGNDATA structure indicating the smallest set of pixels that need to
    ///                   be transferred. This value must be <b>NULL</b> unless the swapchain was created with the D3DSWAPEFFECT_COPY
    ///                   flag. For more information about swapchains, see Flipping Surfaces (Direct3D 9). If this value is
    ///                   non-<b>NULL</b>, the contained region is expressed in back buffer coordinates. The method takes these
    ///                   rectangles into account when optimizing the presentation by copying only the pixels within the region, or
    ///                   some suitably expanded set of rectangles. This is an aid to optimization only, and the application should not
    ///                   rely on the region being copied exactly. The implementation can choose to copy the whole source rectangle.
    ///    dwFlags = Type: <b>DWORD</b> Allows the application to request that the method return immediately when the driver
    ///              reports that it cannot schedule a presentation. Valid values are 0, or any combination of D3DPRESENT flags.
    ///              <ul> <li>If dwFlags = 0, this method behaves as it did prior to Direct3D 9. Present will spin until the
    ///              hardware is free, without returning an error.</li> <li>If dwFlags = D3DPRESENT_DONOTFLIP the display driver
    ///              is called with the front buffer as both the source and target surface. The driver responds by scheduling a
    ///              frame synch, but not changing the displayed surface. This flag is only available in full-screen mode or when
    ///              using D3DSWAPEFFECT_FLIPEX in windowed mode.</li> <li>If dwFlags = D3DPRESENT_DONOTWAIT, and the hardware is
    ///              busy processing or waiting for a vertical sync interval, the method will return D3DERR_WASSTILLDRAWING.</li>
    ///              <li>If dwFlags = D3DPRESENT_FORCEIMMEDIATE, D3DPRESENT_INTERVAL_IMMEDIATE is enforced on this Present call.
    ///              This flag can only be specified when using D3DSWAPEFFECT_FLIPEX. This behavior is the same for windowed and
    ///              full-screen modes.</li> <li>If dwFlags = D3DPRESENT_LINEAR_CONTENT, gamma correction is performed from linear
    ///              space to sRGB for windowed swap chains. This flag will take effect only when the driver exposes
    ///              D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION (see Gamma (Direct3D 9)).</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: S_OK, D3DERR_DEVICELOST, D3DERR_DEVICEHUNG,
    ///    D3DERR_DEVICEREMOVED, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR). See Lost Device Behavior Changes for more
    ///    information about lost, hung, and removed devices. <table> <tr> <td> Differences between Direct3D 9 and
    ///    Direct3D 9Ex: D3DSWAPEFFECT_FLIPEX is only available in Direct3D9Ex running on Windows 7 (or more current
    ///    operating system). </td> </tr> </table>
    ///    
    HRESULT PresentEx(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, 
                      const(RGNDATA)* pDirtyRegion, uint dwFlags);
    ///Get the priority of the GPU thread.
    ///Params:
    ///    pPriority = Type: <b>INT*</b> Current GPU priority. Valid values range from -7 to 7.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK or D3DERR_DEVICEREMOVED (see D3DERR).
    ///    
    HRESULT GetGPUThreadPriority(int* pPriority);
    ///Set the priority on the GPU thread.
    ///Params:
    ///    Priority = Type: <b>INT</b> The thread priority, ranging from -7 to 7.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_INVALIDCALL, or D3DERR_DEVICEREMOVED (see
    ///    D3DERR).
    ///    
    HRESULT SetGPUThreadPriority(int Priority);
    ///Suspend execution of the calling thread until the next vertical blank signal.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> Swap chain index. This is an optional, zero-based index used to specify a swap chain on a
    ///                 multihead card.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method will always return D3D_OK.
    ///    
    HRESULT WaitForVBlank(uint iSwapChain);
    ///Checks an array of resources to determine if it is likely that they will cause a large stall at Draw time because
    ///the system must make the resources GPU-accessible.
    ///Params:
    ///    pResourceArray = Type: <b>IDirect3DResource9**</b> An array of IDirect3DResource9 pointers that indicate the resources to
    ///                     check.
    ///    NumResources = Type: <b>UINT32</b> A value indicating the number of resources passed into the <i>pResourceArray</i>
    ///                   parameter up to a maximum of 65535.
    ///Returns:
    ///    Type: <b>HRESULT</b> If all the resources are in GPU-accessible memory, the method will return S_OK. The
    ///    system may need to perform a remapping operation to promote the resources, but will not have to copy data. If
    ///    no allocation that comprises the resources is on disk, but at least one allocation is not in GPU-accessible
    ///    memory, the method will return S_RESIDENT_IN_SHARED_MEMORY. The system may need to perform a copy to promote
    ///    the resource. If at least one allocation that comprises the resources is on disk, this method will return
    ///    S_NOT_RESIDENT. The system may need to perform a copy to promote the resource.
    ///    
    HRESULT CheckResourceResidency(IDirect3DResource9* pResourceArray, uint NumResources);
    ///Set the number of frames that the system is allowed to queue for rendering.
    ///Params:
    ///    MaxLatency = Type: <b>UINT</b> The maximum number of back buffer frames that a driver can queue. The value is typically 3,
    ///                 but can range from 1 to 20. A value of 0 will reset latency to the default. For multi-head devices,
    ///                 <i>MaxLatency</i> is specified per-head.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK or D3DERR_DEVICEREMOVED (see D3DERR).
    ///    
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    ///Retrieves the number of frames of data that the system is allowed to queue.
    ///Params:
    ///    pMaxLatency = Type: <b>UINT*</b> Returns the number of frames that can be queued for render. The value is typically 3, but
    ///                  can range from 1 to 20.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_DEVICELOST, D3DERR_DEVICEREMOVED,
    ///    D3DERR_DRIVERINTERNALERROR, D3DERR_INVALIDCALL, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR).
    ///    
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
    ///Reports the current cooperative-level status of the Direct3D device for a windowed or full-screen application.
    ///Params:
    ///    hDestinationWindow = Type: <b>HWND</b> The destination window handle to check for occlusion. When this parameter is <b>NULL</b>,
    ///                         S_PRESENT_OCCLUDED is returned when another device has fullscreen ownership. When the window handle is not
    ///                         <b>NULL</b>, window's client area is checked for occlusion. A window is occluded if any part of it is
    ///                         obscured by another application.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: D3D_OK, D3DERR_DEVICELOST, D3DERR_DEVICEHUNG,
    ///    D3DERR_DEVICEREMOVED, or D3DERR_OUTOFVIDEOMEMORY (see D3DERR), or S_PRESENT_MODE_CHANGED, or
    ///    S_PRESENT_OCCLUDED (see S_PRESENT).
    ///    
    HRESULT CheckDeviceState(HWND hDestinationWindow);
    ///Creates a render-target surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the render-target surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the render-target surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the render target.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, which describes the
    ///                  multisampling buffer type. This parameter specifies the antialiasing type for this render target. When this
    ///                  surface is passed to IDirect3DDevice9::SetRenderTarget, its multisample type must be the same as that of the
    ///                  depth-stencil set by IDirect3DDevice9::SetDepthStencilSurface.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error,
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         multisample type must all match.
    ///    Lockable = Type: <b>BOOL</b> Render targets are not lockable unless the application specifies <b>TRUE</b> for Lockable.
    ///               Note that lockable render targets reduce performance on some graphics hardware. The readback performance
    ///               (moving data from video memory to system memory) depends on the type of hardware used (AGP vs. PCI Express)
    ///               and is usually far lower than upload performance (moving data from system to video memory). If you need read
    ///               access to render targets, use GetRenderTargetData instead of lockable render targets.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///    Usage = Type: <b>DWORD</b> Combination of one or more D3DUSAGE constants which can be OR'd together. Value of 0
    ///            indicates no usage.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateRenderTargetEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                 uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, 
                                 HANDLE* pSharedHandle, uint Usage);
    ///Create an off-screen surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the surface.
    ///    Height = Type: <b>UINT</b> Height of the surface.
    ///    Format = Type: <b>D3DFORMAT</b> Format of the surface. See D3DFORMAT.
    ///    Pool = Type: <b>D3DPOOL</b> Surface pool type. See D3DPOOL.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Pointer to the IDirect3DSurface9 interface created.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///    Usage = Type: <b>DWORD</b> Combination of one or more D3DUSAGE constants which can be OR'd together. Value of 0
    ///            indicates no usage.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be the following: D3DERR_INVALIDCALL.
    ///    
    HRESULT CreateOffscreenPlainSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, 
                                          IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle, uint Usage);
    ///Creates a depth-stencil surface.
    ///Params:
    ///    Width = Type: <b>UINT</b> Width of the depth-stencil surface, in pixels.
    ///    Height = Type: <b>UINT</b> Height of the depth-stencil surface, in pixels.
    ///    Format = Type: <b>D3DFORMAT</b> Member of the D3DFORMAT enumerated type, describing the format of the depth-stencil
    ///             surface. This value must be one of the enumerated depth-stencil formats for this device.
    ///    MultiSample = Type: <b>D3DMULTISAMPLE_TYPE</b> Member of the D3DMULTISAMPLE_TYPE enumerated type, describing the
    ///                  multisampling buffer type. This value must be one of the allowed multisample types. When this surface is
    ///                  passed to IDirect3DDevice9::SetDepthStencilSurface, its multisample type must be the same as that of the
    ///                  render target set by IDirect3DDevice9::SetRenderTarget.
    ///    MultisampleQuality = Type: <b>DWORD</b> Quality level. The valid range is between zero and one less than the level returned by
    ///                         pQualityLevels used by IDirect3D9::CheckDeviceMultiSampleType. Passing a larger value returns the error
    ///                         D3DERR_INVALIDCALL. The MultisampleQuality values of paired render targets, depth stencil surfaces, and the
    ///                         MultiSample type must all match.
    ///    Discard = Type: <b>BOOL</b> Set this flag to <b>TRUE</b> to enable z-buffer discarding, and <b>FALSE</b> otherwise. If
    ///              this flag is set, the contents of the depth stencil buffer will be invalid after calling either
    ///              IDirect3DDevice9::Present or IDirect3DDevice9::SetDepthStencilSurface with a different depth surface. This
    ///              flag has the same behavior as the constant, D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL, in D3DPRESENTFLAG.
    ///    ppSurface = Type: <b>IDirect3DSurface9**</b> Address of a pointer to an IDirect3DSurface9 interface, representing the
    ///                created depth-stencil surface resource.
    ///    pSharedHandle = Type: <b>HANDLE*</b> Reserved. Set this parameter to <b>NULL</b>. This parameter can be used in Direct3D 9
    ///                    for Windows Vista to share resources.
    ///    Usage = Type: <b>DWORD</b> Combination of one or more D3DUSAGE constants which can be OR'd together. Value of 0
    ///            indicates no usage.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be one of the following: D3DERR_NOTAVAILABLE, D3DERR_INVALIDCALL, D3DERR_OUTOFVIDEOMEMORY,
    ///    E_OUTOFMEMORY.
    ///    
    HRESULT CreateDepthStencilSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, 
                                        uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, 
                                        HANDLE* pSharedHandle, uint Usage);
    ///Resets the type, size, and format of the swap chain with all other surfaces persistent.
    ///Params:
    ///    pPresentationParameters = Type: <b>D3DPRESENT_PARAMETERS*</b> Pointer to a D3DPRESENT_PARAMETERS structure, describing the new
    ///                              presentation parameters. This value cannot be <b>NULL</b>. When switching to full-screen mode, Direct3D will
    ///                              try to find a desktop format that matches the back buffer format, so that back buffer and front buffer
    ///                              formats will be identical (to eliminate the need for color conversion). When this method returns: <ul>
    ///                              <li>BackBufferCount, BackBufferWidth, and BackBufferHeight are set to zero.</li> <li>BackBufferFormat is set
    ///                              to D3DFORMAT for windowed mode only; a full-screen mode must specify a format.</li> </ul>
    ///    pFullscreenDisplayMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure that describes the properties of the
    ///                             desired display mode. This value must be provided for fullscreen applications, but can be <b>NULL</b> for
    ///                             windowed applications.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method can return: D3D_OK, D3DERR_DEVICELOST or D3DERR_DEVICEHUNG (see D3DERR). If
    ///    this method returns D3DERR_DEVICELOST or D3DERR_DEVICEHUNG then the application can only call
    ///    <b>IDirect3DDevice9Ex::ResetEx</b>, IDirect3DDevice9Ex::CheckDeviceState or release the interface pointer;
    ///    any other API call will cause an exception.
    ///    
    HRESULT ResetEx(_D3DPRESENT_PARAMETERS_* pPresentationParameters, D3DDISPLAYMODEEX* pFullscreenDisplayMode);
    ///Retrieves the display mode's spatial resolution, color resolution, refresh frequency, and rotation settings.
    ///Params:
    ///    iSwapChain = Type: <b>UINT</b> An unsigned integer specifying the swap chain.
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure containing data about the display mode
    ///            of the adapter. As opposed to the display mode of the device, which may not be active if the device does not
    ///            own full-screen mode. Can be set to <b>NULL</b>.
    ///    pRotation = Type: <b>D3DDISPLAYROTATION*</b> Pointer to a D3DDISPLAYROTATION indicating the type of screen rotation the
    ///                application will do. The value returned through this pointer is important when the
    ///                D3DPRESENTFLAG_NOAUTOROTATE flag is used; otherwise, it can be set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayModeEx(uint iSwapChain, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
}

///Applications use the methods of the <b>IDirect3DSwapChain9Ex</b> interface to manipulate a swap chain.
@GUID("91886CAF-1C3D-4D2E-A0AB-3E4C7D8D3303")
interface IDirect3DSwapChain9Ex : IDirect3DSwapChain9
{
    ///Returns the number of times the swapchain has been processed.
    ///Params:
    ///    pLastPresentCount = Type: <b>UINT*</b> Pointer to a UINT to be filled with the number of times the IDirect3DDevice9Ex::PresentEx
    ///                        method has been called. The count will also be incremented by calling some other APIs such as
    ///                        IDirect3DDevice9::SetDialogBoxMode.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK the method was successful.
    ///    
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
    HRESULT GetPresentStats(D3DPRESENTSTATS* pPresentationStatistics);
    ///Retrieves the display mode's spatial resolution, color resolution, refresh frequency, and rotation settings.
    ///Params:
    ///    pMode = Type: <b>D3DDISPLAYMODEEX*</b> Pointer to a D3DDISPLAYMODEEX structure containing data about the display mode
    ///            of the adapter. As opposed to the display mode of the device, which may not be active if the device does not
    ///            own full-screen mode.
    ///    pRotation = Type: <b>D3DDISPLAYROTATION*</b> Pointer to a D3DDISPLAYROTATION indicating the type of screen rotation the
    ///                application will do. The value returned through this pointer is important when the
    ///                D3DPRESENTFLAG_NOAUTOROTATE flag is used; otherwise, it can be set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the return value is D3D_OK. If the method fails, the return
    ///    value can be D3DERR_INVALIDCALL.
    ///    
    HRESULT GetDisplayModeEx(D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
}


// GUIDs


const GUID IID_ID2D1AnalysisTransform         = GUIDOF!ID2D1AnalysisTransform;
const GUID IID_ID2D1Bitmap                    = GUIDOF!ID2D1Bitmap;
const GUID IID_ID2D1Bitmap1                   = GUIDOF!ID2D1Bitmap1;
const GUID IID_ID2D1BitmapBrush               = GUIDOF!ID2D1BitmapBrush;
const GUID IID_ID2D1BitmapBrush1              = GUIDOF!ID2D1BitmapBrush1;
const GUID IID_ID2D1BitmapRenderTarget        = GUIDOF!ID2D1BitmapRenderTarget;
const GUID IID_ID2D1BlendTransform            = GUIDOF!ID2D1BlendTransform;
const GUID IID_ID2D1BorderTransform           = GUIDOF!ID2D1BorderTransform;
const GUID IID_ID2D1BoundsAdjustmentTransform = GUIDOF!ID2D1BoundsAdjustmentTransform;
const GUID IID_ID2D1Brush                     = GUIDOF!ID2D1Brush;
const GUID IID_ID2D1ColorContext              = GUIDOF!ID2D1ColorContext;
const GUID IID_ID2D1ColorContext1             = GUIDOF!ID2D1ColorContext1;
const GUID IID_ID2D1CommandList               = GUIDOF!ID2D1CommandList;
const GUID IID_ID2D1CommandSink               = GUIDOF!ID2D1CommandSink;
const GUID IID_ID2D1CommandSink1              = GUIDOF!ID2D1CommandSink1;
const GUID IID_ID2D1CommandSink2              = GUIDOF!ID2D1CommandSink2;
const GUID IID_ID2D1CommandSink3              = GUIDOF!ID2D1CommandSink3;
const GUID IID_ID2D1CommandSink4              = GUIDOF!ID2D1CommandSink4;
const GUID IID_ID2D1CommandSink5              = GUIDOF!ID2D1CommandSink5;
const GUID IID_ID2D1ComputeInfo               = GUIDOF!ID2D1ComputeInfo;
const GUID IID_ID2D1ComputeTransform          = GUIDOF!ID2D1ComputeTransform;
const GUID IID_ID2D1ConcreteTransform         = GUIDOF!ID2D1ConcreteTransform;
const GUID IID_ID2D1DCRenderTarget            = GUIDOF!ID2D1DCRenderTarget;
const GUID IID_ID2D1Device                    = GUIDOF!ID2D1Device;
const GUID IID_ID2D1Device1                   = GUIDOF!ID2D1Device1;
const GUID IID_ID2D1Device2                   = GUIDOF!ID2D1Device2;
const GUID IID_ID2D1Device3                   = GUIDOF!ID2D1Device3;
const GUID IID_ID2D1Device4                   = GUIDOF!ID2D1Device4;
const GUID IID_ID2D1Device5                   = GUIDOF!ID2D1Device5;
const GUID IID_ID2D1Device6                   = GUIDOF!ID2D1Device6;
const GUID IID_ID2D1DeviceContext             = GUIDOF!ID2D1DeviceContext;
const GUID IID_ID2D1DeviceContext1            = GUIDOF!ID2D1DeviceContext1;
const GUID IID_ID2D1DeviceContext2            = GUIDOF!ID2D1DeviceContext2;
const GUID IID_ID2D1DeviceContext3            = GUIDOF!ID2D1DeviceContext3;
const GUID IID_ID2D1DeviceContext4            = GUIDOF!ID2D1DeviceContext4;
const GUID IID_ID2D1DeviceContext5            = GUIDOF!ID2D1DeviceContext5;
const GUID IID_ID2D1DeviceContext6            = GUIDOF!ID2D1DeviceContext6;
const GUID IID_ID2D1DrawInfo                  = GUIDOF!ID2D1DrawInfo;
const GUID IID_ID2D1DrawTransform             = GUIDOF!ID2D1DrawTransform;
const GUID IID_ID2D1DrawingStateBlock         = GUIDOF!ID2D1DrawingStateBlock;
const GUID IID_ID2D1DrawingStateBlock1        = GUIDOF!ID2D1DrawingStateBlock1;
const GUID IID_ID2D1Effect                    = GUIDOF!ID2D1Effect;
const GUID IID_ID2D1EffectContext             = GUIDOF!ID2D1EffectContext;
const GUID IID_ID2D1EffectContext1            = GUIDOF!ID2D1EffectContext1;
const GUID IID_ID2D1EffectContext2            = GUIDOF!ID2D1EffectContext2;
const GUID IID_ID2D1EffectImpl                = GUIDOF!ID2D1EffectImpl;
const GUID IID_ID2D1EllipseGeometry           = GUIDOF!ID2D1EllipseGeometry;
const GUID IID_ID2D1Factory                   = GUIDOF!ID2D1Factory;
const GUID IID_ID2D1Factory1                  = GUIDOF!ID2D1Factory1;
const GUID IID_ID2D1Factory2                  = GUIDOF!ID2D1Factory2;
const GUID IID_ID2D1Factory3                  = GUIDOF!ID2D1Factory3;
const GUID IID_ID2D1Factory4                  = GUIDOF!ID2D1Factory4;
const GUID IID_ID2D1Factory5                  = GUIDOF!ID2D1Factory5;
const GUID IID_ID2D1Factory6                  = GUIDOF!ID2D1Factory6;
const GUID IID_ID2D1Factory7                  = GUIDOF!ID2D1Factory7;
const GUID IID_ID2D1GdiInteropRenderTarget    = GUIDOF!ID2D1GdiInteropRenderTarget;
const GUID IID_ID2D1GdiMetafile               = GUIDOF!ID2D1GdiMetafile;
const GUID IID_ID2D1GdiMetafile1              = GUIDOF!ID2D1GdiMetafile1;
const GUID IID_ID2D1GdiMetafileSink           = GUIDOF!ID2D1GdiMetafileSink;
const GUID IID_ID2D1GdiMetafileSink1          = GUIDOF!ID2D1GdiMetafileSink1;
const GUID IID_ID2D1Geometry                  = GUIDOF!ID2D1Geometry;
const GUID IID_ID2D1GeometryGroup             = GUIDOF!ID2D1GeometryGroup;
const GUID IID_ID2D1GeometryRealization       = GUIDOF!ID2D1GeometryRealization;
const GUID IID_ID2D1GeometrySink              = GUIDOF!ID2D1GeometrySink;
const GUID IID_ID2D1GradientMesh              = GUIDOF!ID2D1GradientMesh;
const GUID IID_ID2D1GradientStopCollection    = GUIDOF!ID2D1GradientStopCollection;
const GUID IID_ID2D1GradientStopCollection1   = GUIDOF!ID2D1GradientStopCollection1;
const GUID IID_ID2D1HwndRenderTarget          = GUIDOF!ID2D1HwndRenderTarget;
const GUID IID_ID2D1Image                     = GUIDOF!ID2D1Image;
const GUID IID_ID2D1ImageBrush                = GUIDOF!ID2D1ImageBrush;
const GUID IID_ID2D1ImageSource               = GUIDOF!ID2D1ImageSource;
const GUID IID_ID2D1ImageSourceFromWic        = GUIDOF!ID2D1ImageSourceFromWic;
const GUID IID_ID2D1Ink                       = GUIDOF!ID2D1Ink;
const GUID IID_ID2D1InkStyle                  = GUIDOF!ID2D1InkStyle;
const GUID IID_ID2D1Layer                     = GUIDOF!ID2D1Layer;
const GUID IID_ID2D1LinearGradientBrush       = GUIDOF!ID2D1LinearGradientBrush;
const GUID IID_ID2D1LookupTable3D             = GUIDOF!ID2D1LookupTable3D;
const GUID IID_ID2D1Mesh                      = GUIDOF!ID2D1Mesh;
const GUID IID_ID2D1Multithread               = GUIDOF!ID2D1Multithread;
const GUID IID_ID2D1OffsetTransform           = GUIDOF!ID2D1OffsetTransform;
const GUID IID_ID2D1PathGeometry              = GUIDOF!ID2D1PathGeometry;
const GUID IID_ID2D1PathGeometry1             = GUIDOF!ID2D1PathGeometry1;
const GUID IID_ID2D1PrintControl              = GUIDOF!ID2D1PrintControl;
const GUID IID_ID2D1Properties                = GUIDOF!ID2D1Properties;
const GUID IID_ID2D1RadialGradientBrush       = GUIDOF!ID2D1RadialGradientBrush;
const GUID IID_ID2D1RectangleGeometry         = GUIDOF!ID2D1RectangleGeometry;
const GUID IID_ID2D1RenderInfo                = GUIDOF!ID2D1RenderInfo;
const GUID IID_ID2D1RenderTarget              = GUIDOF!ID2D1RenderTarget;
const GUID IID_ID2D1Resource                  = GUIDOF!ID2D1Resource;
const GUID IID_ID2D1ResourceTexture           = GUIDOF!ID2D1ResourceTexture;
const GUID IID_ID2D1RoundedRectangleGeometry  = GUIDOF!ID2D1RoundedRectangleGeometry;
const GUID IID_ID2D1SimplifiedGeometrySink    = GUIDOF!ID2D1SimplifiedGeometrySink;
const GUID IID_ID2D1SolidColorBrush           = GUIDOF!ID2D1SolidColorBrush;
const GUID IID_ID2D1SourceTransform           = GUIDOF!ID2D1SourceTransform;
const GUID IID_ID2D1SpriteBatch               = GUIDOF!ID2D1SpriteBatch;
const GUID IID_ID2D1StrokeStyle               = GUIDOF!ID2D1StrokeStyle;
const GUID IID_ID2D1StrokeStyle1              = GUIDOF!ID2D1StrokeStyle1;
const GUID IID_ID2D1SvgAttribute              = GUIDOF!ID2D1SvgAttribute;
const GUID IID_ID2D1SvgDocument               = GUIDOF!ID2D1SvgDocument;
const GUID IID_ID2D1SvgElement                = GUIDOF!ID2D1SvgElement;
const GUID IID_ID2D1SvgGlyphStyle             = GUIDOF!ID2D1SvgGlyphStyle;
const GUID IID_ID2D1SvgPaint                  = GUIDOF!ID2D1SvgPaint;
const GUID IID_ID2D1SvgPathData               = GUIDOF!ID2D1SvgPathData;
const GUID IID_ID2D1SvgPointCollection        = GUIDOF!ID2D1SvgPointCollection;
const GUID IID_ID2D1SvgStrokeDashArray        = GUIDOF!ID2D1SvgStrokeDashArray;
const GUID IID_ID2D1TessellationSink          = GUIDOF!ID2D1TessellationSink;
const GUID IID_ID2D1Transform                 = GUIDOF!ID2D1Transform;
const GUID IID_ID2D1TransformGraph            = GUIDOF!ID2D1TransformGraph;
const GUID IID_ID2D1TransformNode             = GUIDOF!ID2D1TransformNode;
const GUID IID_ID2D1TransformedGeometry       = GUIDOF!ID2D1TransformedGeometry;
const GUID IID_ID2D1TransformedImageSource    = GUIDOF!ID2D1TransformedImageSource;
const GUID IID_ID2D1VertexBuffer              = GUIDOF!ID2D1VertexBuffer;
const GUID IID_IDirect3D9                     = GUIDOF!IDirect3D9;
const GUID IID_IDirect3D9Ex                   = GUIDOF!IDirect3D9Ex;
const GUID IID_IDirect3DBaseTexture9          = GUIDOF!IDirect3DBaseTexture9;
const GUID IID_IDirect3DCubeTexture9          = GUIDOF!IDirect3DCubeTexture9;
const GUID IID_IDirect3DDevice9               = GUIDOF!IDirect3DDevice9;
const GUID IID_IDirect3DDevice9Ex             = GUIDOF!IDirect3DDevice9Ex;
const GUID IID_IDirect3DIndexBuffer9          = GUIDOF!IDirect3DIndexBuffer9;
const GUID IID_IDirect3DPixelShader9          = GUIDOF!IDirect3DPixelShader9;
const GUID IID_IDirect3DQuery9                = GUIDOF!IDirect3DQuery9;
const GUID IID_IDirect3DResource9             = GUIDOF!IDirect3DResource9;
const GUID IID_IDirect3DStateBlock9           = GUIDOF!IDirect3DStateBlock9;
const GUID IID_IDirect3DSurface9              = GUIDOF!IDirect3DSurface9;
const GUID IID_IDirect3DSwapChain9            = GUIDOF!IDirect3DSwapChain9;
const GUID IID_IDirect3DSwapChain9Ex          = GUIDOF!IDirect3DSwapChain9Ex;
const GUID IID_IDirect3DTexture9              = GUIDOF!IDirect3DTexture9;
const GUID IID_IDirect3DVertexBuffer9         = GUIDOF!IDirect3DVertexBuffer9;
const GUID IID_IDirect3DVertexDeclaration9    = GUIDOF!IDirect3DVertexDeclaration9;
const GUID IID_IDirect3DVertexShader9         = GUIDOF!IDirect3DVertexShader9;
const GUID IID_IDirect3DVolume9               = GUIDOF!IDirect3DVolume9;
const GUID IID_IDirect3DVolumeTexture9        = GUIDOF!IDirect3DVolumeTexture9;
