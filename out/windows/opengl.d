// Written in the D programming language.

module windows.opengl;

public import windows.core;
public import windows.gdi : HDC;
public import windows.systemservices : BOOL, PROC;

extern(Windows):


// Structs


///The <b>PIXELFORMATDESCRIPTOR</b> structure describes the pixel format of a drawing surface.
struct PIXELFORMATDESCRIPTOR
{
    ///Specifies the size of this data structure. This value should be set to
    ///<b>sizeof</b>(<b>PIXELFORMATDESCRIPTOR</b>).
    ushort nSize;
    ///Specifies the version of this data structure. This value should be set to 1.
    ushort nVersion;
    ///A set of bit flags that specify properties of the pixel buffer. The properties are generally not mutually
    ///exclusive; you can set any combination of bit flags, with the exceptions noted. The following bit flag constants
    ///are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>PFD_DRAW_TO_WINDOW</td> <td>The buffer
    ///can draw to a window or device surface.</td> </tr> <tr> <td>PFD_DRAW_TO_BITMAP</td> <td>The buffer can draw to a
    ///memory bitmap.</td> </tr> <tr> <td>PFD_SUPPORT_GDI</td> <td>The buffer supports GDI drawing. This flag and
    ///PFD_DOUBLEBUFFER are mutually exclusive in the current generic implementation.</td> </tr> <tr>
    ///<td>PFD_SUPPORT_OPENGL</td> <td>The buffer supports OpenGL drawing.</td> </tr> <tr>
    ///<td>PFD_GENERIC_ACCELERATED</td> <td>The pixel format is supported by a device driver that accelerates the
    ///generic implementation. If this flag is clear and the PFD_GENERIC_FORMAT flag is set, the pixel format is
    ///supported by the generic implementation only.</td> </tr> <tr> <td>PFD_GENERIC_FORMAT</td> <td>The pixel format is
    ///supported by the GDI software implementation, which is also known as the generic implementation. If this bit is
    ///clear, the pixel format is supported by a device driver or hardware.</td> </tr> <tr> <td>PFD_NEED_PALETTE</td>
    ///<td>The buffer uses RGBA pixels on a palette-managed device. A logical palette is required to achieve the best
    ///results for this pixel type. Colors in the palette should be specified according to the values of the
    ///<b>cRedBits</b>, <b>cRedShift</b>, <b>cGreenBits</b>, <b>cGreenShift</b>, <b>cBluebits</b>, and <b>cBlueShift</b>
    ///members. The palette should be created and realized in the device context before calling wglMakeCurrent.</td>
    ///</tr> <tr> <td>PFD_NEED_SYSTEM_PALETTE</td> <td>Defined in the pixel format descriptors of hardware that supports
    ///one hardware palette in 256-color mode only. For such systems to use hardware acceleration, the hardware palette
    ///must be in a fixed order (for example, 3-3-2) when in RGBA mode or must match the logical palette when in
    ///color-index mode.When this flag is set, you must call <b>SetSystemPaletteUse</b> in your program to force a
    ///one-to-one mapping of the logical palette and the system palette. If your OpenGL hardware supports multiple
    ///hardware palettes and the device driver can allocate spare hardware palettes for OpenGL, this flag is typically
    ///clear. This flag is not set in the generic pixel formats. </td> </tr> <tr> <td>PFD_DOUBLEBUFFER</td> <td>The
    ///buffer is double-buffered. This flag and PFD_SUPPORT_GDI are mutually exclusive in the current generic
    ///implementation.</td> </tr> <tr> <td>PFD_STEREO</td> <td>The buffer is stereoscopic. This flag is not supported in
    ///the current generic implementation.</td> </tr> <tr> <td>PFD_SWAP_LAYER_BUFFERS</td> <td>Indicates whether a
    ///device can swap individual layer planes with pixel formats that include double-buffered overlay or underlay
    ///planes. Otherwise all layer planes are swapped together as a group. When this flag is set,
    ///<b>wglSwapLayerBuffers</b> is supported.</td> </tr> </table> You can specify the following bit flags when calling
    ///ChoosePixelFormat. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>PFD_DEPTH_DONTCARE</td> <td>The
    ///requested pixel format can either have or not have a depth buffer. To select a pixel format without a depth
    ///buffer, you must specify this flag. The requested pixel format can be with or without a depth buffer. Otherwise,
    ///only pixel formats with a depth buffer are considered.</td> </tr> <tr> <td>PFD_DOUBLEBUFFER<div>
    ///</div>_DONTCARE</td> <td>The requested pixel format can be either single- or double-buffered.</td> </tr> <tr>
    ///<td>PFD_STEREO_DONTCARE</td> <td>The requested pixel format can be either monoscopic or stereoscopic.</td> </tr>
    ///</table> With the <b>glAddSwapHintRectWIN</b> extension function, two new flags are included for the
    ///<b>PIXELFORMATDESCRIPTOR</b> pixel format structure. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PFD_SWAP_COPY</td> <td>Specifies the content of the back buffer in the double-buffered main color plane
    ///following a buffer swap. Swapping the color buffers causes the content of the back buffer to be copied to the
    ///front buffer. The content of the back buffer is not affected by the swap. PFD_SWAP_COPY is a hint only and might
    ///not be provided by a driver.</td> </tr> <tr> <td>PFD_SWAP_EXCHANGE</td> <td>Specifies the content of the back
    ///buffer in the double-buffered main color plane following a buffer swap. Swapping the color buffers causes the
    ///exchange of the back buffer's content with the front buffer's content. Following the swap, the back buffer's
    ///content contains the front buffer's content before the swap. PFD_SWAP_EXCHANGE is a hint only and might not be
    ///provided by a driver.</td> </tr> </table>
    uint   dwFlags;
    ///Specifies the type of pixel data. The following types are defined. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>PFD_TYPE_RGBA</td> <td>RGBA pixels. Each pixel has four components in this order: red, green,
    ///blue, and alpha.</td> </tr> <tr> <td>PFD_TYPE_COLORINDEX</td> <td>Color-index pixels. Each pixel uses a
    ///color-index value.</td> </tr> </table>
    ubyte  iPixelType;
    ///Specifies the number of color bitplanes in each color buffer. For RGBA pixel types, it is the size of the color
    ///buffer, excluding the alpha bitplanes. For color-index pixels, it is the size of the color-index buffer.
    ubyte  cColorBits;
    ///Specifies the number of red bitplanes in each RGBA color buffer.
    ubyte  cRedBits;
    ///Specifies the shift count for red bitplanes in each RGBA color buffer.
    ubyte  cRedShift;
    ///Specifies the number of green bitplanes in each RGBA color buffer.
    ubyte  cGreenBits;
    ///Specifies the shift count for green bitplanes in each RGBA color buffer.
    ubyte  cGreenShift;
    ///Specifies the number of blue bitplanes in each RGBA color buffer.
    ubyte  cBlueBits;
    ///Specifies the shift count for blue bitplanes in each RGBA color buffer.
    ubyte  cBlueShift;
    ///Specifies the number of alpha bitplanes in each RGBA color buffer. Alpha bitplanes are not supported.
    ubyte  cAlphaBits;
    ///Specifies the shift count for alpha bitplanes in each RGBA color buffer. Alpha bitplanes are not supported.
    ubyte  cAlphaShift;
    ///Specifies the total number of bitplanes in the accumulation buffer.
    ubyte  cAccumBits;
    ///Specifies the number of red bitplanes in the accumulation buffer.
    ubyte  cAccumRedBits;
    ///Specifies the number of green bitplanes in the accumulation buffer.
    ubyte  cAccumGreenBits;
    ///Specifies the number of blue bitplanes in the accumulation buffer.
    ubyte  cAccumBlueBits;
    ///Specifies the number of alpha bitplanes in the accumulation buffer.
    ubyte  cAccumAlphaBits;
    ///Specifies the depth of the depth (z-axis) buffer.
    ubyte  cDepthBits;
    ///Specifies the depth of the stencil buffer.
    ubyte  cStencilBits;
    ///Specifies the number of auxiliary buffers. Auxiliary buffers are not supported.
    ubyte  cAuxBuffers;
    ///Ignored. Earlier implementations of OpenGL used this member, but it is no longer used.
    ubyte  iLayerType;
    ///Specifies the number of overlay and underlay planes. Bits 0 through 3 specify up to 15 overlay planes and bits 4
    ///through 7 specify up to 15 underlay planes.
    ubyte  bReserved;
    ///Ignored. Earlier implementations of OpenGL used this member, but it is no longer used.
    uint   dwLayerMask;
    ///Specifies the transparent color or index of an underlay plane. When the pixel type is RGBA, <b>dwVisibleMask</b>
    ///is a transparent RGB color value. When the pixel type is color index, it is a transparent index value.
    uint   dwVisibleMask;
    ///Ignored. Earlier implementations of OpenGL used this member, but it is no longer used.
    uint   dwDamageMask;
}

///The <b>POINTFLOAT</b> structure contains the x and y coordinates of a point.
struct POINTFLOAT
{
    ///Specifies the horizontal (x) coordinate of a point.
    float x;
    ///Specifies the vertical (y) coordinate of a point.
    float y;
}

///The <b>GLYPHMETRICSFLOAT</b> structure contains information about the placement and orientation of a glyph in a
///character cell.
struct GLYPHMETRICSFLOAT
{
    ///Specifies the width of the smallest rectangle (the glyph's black box) that completely encloses the glyph.
    float      gmfBlackBoxX;
    ///Specifies the height of the smallest rectangle (the glyph's black box) that completely encloses the glyph.
    float      gmfBlackBoxY;
    ///Specifies the x and y coordinates of the upper-left corner of the smallest rectangle that completely encloses the
    ///glyph.
    POINTFLOAT gmfptGlyphOrigin;
    ///Specifies the horizontal distance from the origin of the current character cell to the origin of the next
    ///character cell.
    float      gmfCellIncX;
    ///Specifies the vertical distance from the origin of the current character cell to the origin of the next character
    ///cell.
    float      gmfCellIncY;
}

///The <b>LAYERPLANEDESCRIPTOR</b> structure describes the pixel format of a drawing surface.
struct LAYERPLANEDESCRIPTOR
{
    ///Specifies the size of this data structure. Set this value to <b>sizeof</b>(<b>LAYERPLANEDESCRIPTOR</b>).
    ushort nSize;
    ///Specifies the version of this data structure. Set this value to 1.
    ushort nVersion;
    ///A set of bit flags that specify properties of the layer plane. The properties are generally not mutually
    ///exclusive; any combination of bit flags can be set, with the exceptions noted. The following bit flag constants
    ///are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>LPD_SUPPORT_OPENGL</td> <td>The layer
    ///plane supports OpenGL drawing.</td> </tr> <tr> <td>LPD_SUPPORT_GDI</td> <td>The layer plane supports GDI drawing.
    ///The current implementation of OpenGL doesn't support this flag.</td> </tr> <tr> <td>LPD_DOUBLEBUFFER</td> <td>The
    ///layer plane is double-buffered. A layer plane can be double-buffered even when the main plane is single-buffered
    ///and vice versa.</td> </tr> <tr> <td>LPD_STEREO</td> <td>The layer plane is stereoscopic. A layer plane can be
    ///stereoscopic even when the main plane is monoscopic and vice versa.</td> </tr> <tr> <td>LPD_SWAP_EXCHANGE</td>
    ///<td>In a double-buffered layer plane, swapping the color buffer exchanges the front buffer and back buffer
    ///contents. The back buffer then contains the contents of the front buffer before the swap. This flag is a hint
    ///only and might not be provided by a driver.</td> </tr> <tr> <td>LPD_SWAP_COPY</td> <td>In a double-buffered layer
    ///plane, swapping the color buffer copies the back buffer contents to the front buffer. The swap does not affect
    ///the back buffer contents. This flag is a hint only and might not be provided by a driver.</td> </tr> <tr>
    ///<td>LPD_TRANSPARENT</td> <td>The <b>crTransparent</b> member of this structure contains a transparent color or
    ///index value that enables underlying layers to show through this layer. All layer planes, except the
    ///lowest-numbered underlay layer, have a transparent color or index.</td> </tr> <tr> <td>LPD_SHARE_DEPTH</td>
    ///<td>The layer plane shares the depth buffer with the main plane.</td> </tr> <tr> <td>LPD_SHARE_STENCIL</td>
    ///<td>The layer plane shares the stencil buffer with the main plane.</td> </tr> <tr> <td>LPD_SHARE_ACCUM</td>
    ///<td>The layer plane shares the accumulation buffer with the main plane.</td> </tr> </table>
    uint   dwFlags;
    ///Specifies the type of pixel data. The following types are defined. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>LPD_TYPE_RGBA</td> <td>RGBA pixels. Each pixel has four components: red, green, blue, and
    ///alpha.</td> </tr> <tr> <td>LPD_TYPE_COLORINDEX</td> <td>Color-index pixels. Each pixel uses a color-index
    ///value.</td> </tr> </table>
    ubyte  iPixelType;
    ///Specifies the number of color bitplanes in each color buffer. For RGBA pixel types, it is the size of the color
    ///buffer, excluding the alpha bitplanes. For color-index pixels, it is the size of the color-index buffer.
    ubyte  cColorBits;
    ///Specifies the number of red bitplanes in each RGBA color buffer.
    ubyte  cRedBits;
    ///Specifies the shift count for red bitplanes in each RGBA color buffer.
    ubyte  cRedShift;
    ///Specifies the number of green bitplanes in each RGBA color buffer.
    ubyte  cGreenBits;
    ///Specifies the shift count for green bitplanes in each RGBA color buffer.
    ubyte  cGreenShift;
    ///Specifies the number of blue bitplanes in each RGBA color buffer.
    ubyte  cBlueBits;
    ///Specifies the shift count for blue bitplanes in each RGBA color buffer.
    ubyte  cBlueShift;
    ///Specifies the number of alpha bitplanes in each RGBA color buffer. Alpha bitplanes are not supported.
    ubyte  cAlphaBits;
    ///Specifies the shift count for alpha bitplanes in each RGBA color buffer. Alpha bitplanes are not supported.
    ubyte  cAlphaShift;
    ///Specifies the total number of bitplanes in the accumulation buffer.
    ubyte  cAccumBits;
    ///Specifies the number of red bitplanes in the accumulation buffer.
    ubyte  cAccumRedBits;
    ///Specifies the number of green bitplanes in the accumulation buffer.
    ubyte  cAccumGreenBits;
    ///Specifies the number of blue bitplanes in the accumulation buffer.
    ubyte  cAccumBlueBits;
    ///Specifies the number of alpha bitplanes in the accumulation buffer.
    ubyte  cAccumAlphaBits;
    ///Specifies the depth of the depth (z-axis) buffer.
    ubyte  cDepthBits;
    ///Specifies the depth of the stencil buffer.
    ubyte  cStencilBits;
    ///Specifies the number of auxiliary buffers. Auxiliary buffers are not supported.
    ubyte  cAuxBuffers;
    ubyte  iLayerPlane;
    ///Not used. Must be zero.
    ubyte  bReserved;
    ///When the LPD_TRANSPARENT flag is set, specifies the transparent color or index value. Typically the value is
    ///zero.
    uint   crTransparent;
}

// Functions

///The <b>ChoosePixelFormat</b> function attempts to match an appropriate pixel format supported by a device context to
///a given pixel format specification.
///Params:
///    hdc = Specifies the device context that the function examines to determine the best match for the pixel format
///          descriptor pointed to by <i>ppfd</i>.
///    ppfd = Pointer to a PIXELFORMATDESCRIPTOR structure that specifies the requested pixel format. In this context, the
///           members of the <b>PIXELFORMATDESCRIPTOR</b> structure that <i>ppfd</i> points to are used as follows: <table>
///           <tr> <td><i>nSize</i></td> <td>Specifies the size of the PIXELFORMATDESCRIPTOR data structure. Set this member to
///           <code>sizeof(PIXELFORMATDESCRIPTOR)</code>.</td> </tr> <tr> <td><i>nVersion</i></td> <td>Specifies the version
///           number of the PIXELFORMATDESCRIPTOR data structure. Set this member to 1.</td> </tr> <tr> <td><i>dwFlags</i></td>
///           <td>A set of bit flags that specify properties of the pixel buffer. You can combine the following bit flag
///           constants by using bitwise-OR. If any of the following flags are set, the <b>ChoosePixelFormat</b> function
///           attempts to match pixel formats that also have that flag or flags set. Otherwise, <b>ChoosePixelFormat</b>
///           ignores that flag in the pixel formats: <b>PFD_DRAW_TO_WINDOW</b>, <b>PFD_DRAW_TO_BITMAP</b>,
///           <b>PFD_SUPPORT_GDI</b>, <b>PFD_SUPPORT_OPENGL</b> If any of the following flags are set, <b>ChoosePixelFormat</b>
///           attempts to match pixel formats that also have that flag or flags set. Otherwise, it attempts to match pixel
///           formats without that flag set: <b>PFD_DOUBLEBUFFER PFD_STEREO</b> If the following flag is set, the function
///           ignores the <b>PFD_DOUBLEBUFFER</b> flag in the pixel formats: <b>PFD_DOUBLEBUFFER_DONTCARE</b> If the following
///           flag is set, the function ignores the <b>PFD_STEREO</b> flag in the pixel formats:
///           <b>PFD_STEREO_DONTCARE</b></td> </tr> <tr> <td><i>iPixelType</i></td> <td>Specifies the type of pixel format for
///           the function to consider: <b>PFD_TYPE_RGBA</b>, <b>PFD_TYPE_COLORINDEX</b></td> </tr> <tr>
///           <td><i>cColorBits</i></td> <td>Zero or greater.</td> </tr> <tr> <td><i>cRedBits</i></td> <td>Not used.</td> </tr>
///           <tr> <td><i>cRedShift</i></td> <td>Not used.</td> </tr> <tr> <td><i>cGreenBits</i></td> <td>Not used.</td> </tr>
///           <tr> <td><i>cGreenShift</i></td> <td>Not used.</td> </tr> <tr> <td><i>cBlueBits</i></td> <td>Not used.</td> </tr>
///           <tr> <td><i>cBlueShift</i></td> <td>Not used.</td> </tr> <tr> <td><i>cAlphaBits</i></td> <td>Zero or
///           greater.</td> </tr> <tr> <td><i>cAlphaShift</i></td> <td>Not used.</td> </tr> <tr> <td><i>cAccumBits</i></td>
///           <td>Zero or greater.</td> </tr> <tr> <td><i>cAccumRedBits</i></td> <td>Not used.</td> </tr> <tr>
///           <td><i>cAccumGreenBits</i></td> <td>Not used.</td> </tr> <tr> <td><i>cAccumBlueBits</i></td> <td>Not used.</td>
///           </tr> <tr> <td><i>cAccumAlphaBits</i></td> <td>Not used.</td> </tr> <tr> <td><i>cDepthBits</i></td> <td>Zero or
///           greater.</td> </tr> <tr> <td><i>cStencilBits</i></td> <td>Zero or greater.</td> </tr> <tr>
///           <td><i>cAuxBuffers</i></td> <td>Zero or greater.</td> </tr> <tr> <td><i>iLayerType</i></td> <td>Specifies one of
///           the following layer type values: <b>PFD_MAIN_PLANE</b>, <b>PFD_OVERLAY_PLANE</b>, <b>PFD_UNDERLAY_PLANE</b></td>
///           </tr> <tr> <td><i>bReserved</i></td> <td>Not used.</td> </tr> <tr> <td><i>dwLayerMask</i></td> <td>Not used.</td>
///           </tr> <tr> <td><i>dwVisibleMask</i></td> <td>Not used.</td> </tr> <tr> <td><i>dwDamageMask</i></td> <td>Not
///           used.</td> </tr> </table> <i></i>
///Returns:
///    If the function succeeds, the return value is a pixel format index (one-based) that is the closest match to the
///    given pixel format descriptor. If the function fails, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("GDI32")
int ChoosePixelFormat(HDC hdc, const(PIXELFORMATDESCRIPTOR)* ppfd);

///The <b>DescribePixelFormat</b> function obtains information about the pixel format identified by <i>iPixelFormat</i>
///of the device associated with <i>hdc</i>. The function sets the members of the PIXELFORMATDESCRIPTOR structure
///pointed to by <i>ppfd</i> with that pixel format data.
///Params:
///    hdc = Specifies the device context.
///    iPixelFormat = Index that specifies the pixel format. The pixel formats that a device context supports are identified by
///                   positive one-based integer indexes.
///    nBytes = The size, in bytes, of the structure pointed to by <i>ppfd</i>. The <b>DescribePixelFormat</b> function stores no
///             more than <i>nBytes</i> bytes of data to that structure. Set this value to
///             <b>sizeof</b>(<b>PIXELFORMATDESCRIPTOR</b>).
///    ppfd = Pointer to a <b>PIXELFORMATDESCRIPTOR</b> structure whose members the function sets with pixel format data. The
///           function stores the number of bytes copied to the structure in the structure's <b>nSize</b> member. If, upon
///           entry, <i>ppfd</i> is <b>NULL</b>, the function writes no data to the structure. This is useful when you only
///           want to obtain the maximum pixel format index of a device context.
///Returns:
///    If the function succeeds, the return value is the maximum pixel format index of the device context. In addition,
///    the function sets the members of the <b>PIXELFORMATDESCRIPTOR</b> structure pointed to by <i>ppfd</i> according
///    to the specified pixel format. If the function fails, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("GDI32")
int DescribePixelFormat(HDC hdc, int iPixelFormat, uint nBytes, char* ppfd);

///The <b>GetPixelFormat</b> function obtains the index of the currently selected pixel format of the specified device
///context.
///Params:
///    hdc = Specifies the device context of the currently selected pixel format index returned by the function.
///Returns:
///    If the function succeeds, the return value is the currently selected pixel format index of the specified device
///    context. This is a positive, one-based index value. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("GDI32")
int GetPixelFormat(HDC hdc);

///The <b>SetPixelFormat</b> function sets the pixel format of the specified device context to the format specified by
///the <i>iPixelFormat</i> index.
///Params:
///    hdc = Specifies the device context whose pixel format the function attempts to set.
///    format = Index that identifies the pixel format to set. The various pixel formats supported by a device context are
///             identified by one-based indexes.
///    ppfd = Pointer to a PIXELFORMATDESCRIPTOR structure that contains the logical pixel format specification. The system's
///           metafile component uses this structure to record the logical pixel format specification. The structure has no
///           other effect upon the behavior of the <b>SetPixelFormat</b> function.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("GDI32")
BOOL SetPixelFormat(HDC hdc, int format, const(PIXELFORMATDESCRIPTOR)* ppfd);

///The <b>GetEnhMetaFilePixelFormat</b> function retrieves pixel format information for an enhanced metafile.
///Params:
///    hemf = Identifies the enhanced metafile.
///    cbBuffer = Specifies the size, in bytes, of the buffer into which the pixel format information is copied.
///    ppfd = Pointer to a PIXELFORMATDESCRIPTOR structure that contains the logical pixel format specification. The metafile
///           uses this structure to record the logical pixel format specification.
///Returns:
///    If the function succeeds and finds a pixel format, the return value is the size of the metafile's pixel format.
///    If no pixel format is present, the return value is zero. If an error occurs and the function fails, the return
///    value is GDI_ERROR. To get extended error information, call GetLastError.
///    
@DllImport("GDI32")
uint GetEnhMetaFilePixelFormat(ptrdiff_t hemf, uint cbBuffer, char* ppfd);

///The <b>wglCopyContext</b> function copies selected groups of rendering states from one OpenGL rendering context to
///another.
///Params:
///    arg1 = Specifies the source OpenGL rendering context whose state information is to be copied.
///    arg2 = Specifies the destination OpenGL rendering context to which state information is to be copied.
///    arg3 = Specifies which groups of the <i>hglrcSrc</i> rendering state are to be copied to <i>hglrcDst</i>. It contains
///           the bitwise-OR of the same symbolic names that are passed to the <b>glPushAttrib</b> function. You can use
///           GL_ALL_ATTRIB_BITS to copy all the rendering state information.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglCopyContext(ptrdiff_t param0, ptrdiff_t param1, uint param2);

///The <b>wglCreateContext</b> function creates a new OpenGL rendering context, which is suitable for drawing on the
///device referenced by <i>hdc</i>. The rendering context has the same pixel format as the device context.
///Params:
///    Arg1 = Handle to a device context for which the function creates a suitable OpenGL rendering context.
///Returns:
///    If the function succeeds, the return value is a valid handle to an OpenGL rendering context. If the function
///    fails, the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
ptrdiff_t wglCreateContext(HDC param0);

///The <b>wglCreateLayerContext</b> function creates a new OpenGL rendering context for drawing to a specified layer
///plane on a device context.
///Params:
///    arg1 = Specifies the device context for a new rendering context.
///    arg2 = Specifies the layer plane to which you want to bind a rendering context. The value 0 identifies the main plane.
///           Positive values of <i>iLayerPlane</i> identify overlay planes, where 1 is the first overlay plane over the main
///           plane, 2 is the second overlay plane over the first overlay plane, and so on. Negative values identify underlay
///           planes, where 1 is the first underlay plane under the main plane, 2 is the second underlay plane under the first
///           underlay plane, and so on. The number of overlay and underlay planes is given in the <b>bReserved</b> member of
///           the PIXELFORMATDESCRIPTOR structure.
///Returns:
///    If the function succeeds, the return value is a handle to an OpenGL rendering context. If the function fails, the
///    return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
ptrdiff_t wglCreateLayerContext(HDC param0, int param1);

///The <b>wglDeleteContext</b> function deletes a specified OpenGL rendering context.
///Params:
///    Arg1 = Handle to an OpenGL rendering context that the function will delete.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglDeleteContext(ptrdiff_t param0);

///The <b>wglGetCurrentContext</b> function obtains a handle to the current OpenGL rendering context of the calling
///thread.
///Returns:
///    If the calling thread has a current OpenGL rendering context, <b>wglGetCurrentContext</b> returns a handle to
///    that rendering context. Otherwise, the return value is <b>NULL</b>.
///    
@DllImport("OPENGL32")
ptrdiff_t wglGetCurrentContext();

///The <b>wglGetCurrentDC</b> function obtains a handle to the device context that is associated with the current OpenGL
///rendering context of the calling thread.
///Returns:
///    If the calling thread has a current OpenGL rendering context, the function returns a handle to the device context
///    associated with that rendering context by means of the <b>wglMakeCurrent</b> function. Otherwise, the return
///    value is <b>NULL</b>.
///    
@DllImport("OPENGL32")
HDC wglGetCurrentDC();

///The <b>wglGetProcAddress</b> function returns the address of an OpenGL extension function for use with the current
///OpenGL rendering context.
///Params:
///    Arg1 = Points to a <b>null</b>-terminated string that is the name of the extension function. The name of the extension
///           function must be identical to a corresponding function implemented by OpenGL.
///Returns:
///    When the function succeeds, the return value is the address of the extension function. When no current rendering
///    context exists or the function fails, the return value is <b>NULL</b>. To get extended error information, call
///    GetLastError.
///    
@DllImport("OPENGL32")
PROC wglGetProcAddress(const(char)* param0);

///The <b>wglMakeCurrent</b> function makes a specified OpenGL rendering context the calling thread's current rendering
///context. All subsequent OpenGL calls made by the thread are drawn on the device identified by <i>hdc</i>. You can
///also use <b>wglMakeCurrent</b> to change the calling thread's current rendering context so it's no longer current.
///Params:
///    arg1 = Handle to a device context. Subsequent OpenGL calls made by the calling thread are drawn on the device identified
///           by <i>hdc</i>.
///    arg2 = Handle to an OpenGL rendering context that the function sets as the calling thread's rendering context. If
///           <i>hglrc</i> is <b>NULL</b>, the function makes the calling thread's current rendering context no longer current,
///           and releases the device context that is used by the rendering context. In this case, <i>hdc</i> is ignored.
///Returns:
///    When the <b>wglMakeCurrent</b> function succeeds, the return value is <b>TRUE</b>; otherwise the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglMakeCurrent(HDC param0, ptrdiff_t param1);

///The <b>wglShareLists</b> function enables multiple OpenGL rendering contexts to share a single display-list space.
///Params:
///    arg1 = Specifies the OpenGL rendering context with which to share display lists.
///    arg2 = Specifies the OpenGL rendering context to share display lists with <i>hglrc1</i>. The <i>hglrc2</i> parameter
///           should not contain any existing display lists when <b>wglShareLists</b> is called.
///Returns:
///    When the function succeeds, the return value is <b>TRUE</b>. When the function fails, the return value is
///    <b>FALSE</b> and the display lists are not shared. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglShareLists(ptrdiff_t param0, ptrdiff_t param1);

///The <b>wglUseFontBitmaps</b> function creates a set of bitmap display lists for use in the current OpenGL rendering
///context. The set of bitmap display lists is based on the glyphs in the currently selected font in the device context.
///You can then use bitmaps to draw characters in an OpenGL image. The <b>wglUseFontBitmaps</b> function creates
///<i>count</i> display lists, one for each of a run of <i>count</i> glyphs that begins with the first glyph in the
///<i>hdc</i> parameter's selected fonts.
///Params:
///    arg1 = Specifies the device context whose currently selected font will be used to form the glyph bitmap display lists in
///           the current OpenGL rendering context.
///    arg2 = Specifies the first glyph in the run of glyphs that will be used to form glyph bitmap display lists.
///    arg3 = Specifies the number of glyphs in the run of glyphs that will be used to form glyph bitmap display lists. The
///           function creates <i>count</i> display lists, one for each glyph in the run.
///    arg4 = Specifies a starting display list.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglUseFontBitmapsA(HDC param0, uint param1, uint param2, uint param3);

///The <b>wglUseFontBitmaps</b> function creates a set of bitmap display lists for use in the current OpenGL rendering
///context. The set of bitmap display lists is based on the glyphs in the currently selected font in the device context.
///You can then use bitmaps to draw characters in an OpenGL image. The <b>wglUseFontBitmaps</b> function creates
///<i>count</i> display lists, one for each of a run of <i>count</i> glyphs that begins with the first glyph in the
///<i>hdc</i> parameter's selected fonts.
///Params:
///    arg1 = Specifies the device context whose currently selected font will be used to form the glyph bitmap display lists in
///           the current OpenGL rendering context.
///    arg2 = Specifies the first glyph in the run of glyphs that will be used to form glyph bitmap display lists.
///    arg3 = Specifies the number of glyphs in the run of glyphs that will be used to form glyph bitmap display lists. The
///           function creates <i>count</i> display lists, one for each glyph in the run.
///    arg4 = Specifies a starting display list.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglUseFontBitmapsW(HDC param0, uint param1, uint param2, uint param3);

///The <b>SwapBuffers</b> function exchanges the front and back buffers if the current pixel format for the window
///referenced by the specified device context includes a back buffer.
///Params:
///    Arg1 = Specifies a device context. If the current pixel format for the window referenced by this device context includes
///           a back buffer, the function exchanges the front and back buffers.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("GDI32")
BOOL SwapBuffers(HDC param0);

///The <b>wglUseFontOutlines</b> function creates a set of display lists, one for each glyph of the currently selected
///outline font of a device context, for use with the current rendering context. The display lists are used to draw 3-D
///characters of TrueType fonts. Each display list describes a glyph outline in floating-point coordinates. The run of
///glyphs begins with thefirstglyph of the font of the specified device context. The em square size of the font, the
///notional grid size of the original font outline from which the font is fitted, is mapped to 1.0 in the x- and
///y-coordinates in the display lists. The extrusion parameter sets how much depth the font has in the z direction.
///Thelpgmfparameter returns a GLYPHMETRICSFLOAT structure that contains information about the placement and orientation
///of each glyph in a character cell.
///Params:
///    arg1 = Specifies the device context with the desired outline font. The outline font of <i>hdc</i> is used to create the
///           display lists in the current rendering context.
///    arg2 = Specifies the first of the set of glyphs that form the font outline display lists.
///    arg3 = Specifies the number of glyphs in the set of glyphs used to form the font outline display lists. The
///           <b>wglUseFontOutlines</b> function creates <i>count</i> display lists, one display list for each glyph in a set
///           of glyphs.
///    arg4 = Specifies a starting display list.
///    arg5 = Specifies the maximum chordal deviation from the original outlines. When deviation is zero, the chordal deviation
///           is equivalent to one design unit of the original font. The value of <i>deviation</i> must be equal to or greater
///           than 0.
///    arg6 = Specifies how much a font is extruded in the negative <i>z</i> direction. The value must be equal to or greater
///           than 0. When <i>extrusion</i> is 0, the display lists are not extruded.
///    arg7 = Specifies the format, either WGL_FONT_LINES or WGL_FONT_POLYGONS, to use in the display lists. When <i>format</i>
///           is WGL_FONT_LINES, the <b>wglUseFontOutlines</b> function creates fonts with line segments. When <i>format</i> is
///           WGL_FONT_POLYGONS, <b>wglUseFontOutlines</b> creates fonts with polygons.
///    arg8 = Points to an array of <i>count</i>GLYPHMETRICSFLOAT structures that is to receive the metrics of the glyphs. When
///           <i>lpgmf</i> is <b>NULL</b>, no glyph metrics are returned.
///Returns:
///    When the function succeeds, the return value is <b>TRUE</b>. When the function fails, the return value is
///    <b>FALSE</b> and no display lists are generated. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglUseFontOutlinesA(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, 
                         GLYPHMETRICSFLOAT* param7);

///The <b>wglUseFontOutlines</b> function creates a set of display lists, one for each glyph of the currently selected
///outline font of a device context, for use with the current rendering context. The display lists are used to draw 3-D
///characters of TrueType fonts. Each display list describes a glyph outline in floating-point coordinates. The run of
///glyphs begins with thefirstglyph of the font of the specified device context. The em square size of the font, the
///notional grid size of the original font outline from which the font is fitted, is mapped to 1.0 in the x- and
///y-coordinates in the display lists. The extrusion parameter sets how much depth the font has in the z direction.
///Thelpgmfparameter returns a GLYPHMETRICSFLOAT structure that contains information about the placement and orientation
///of each glyph in a character cell.
///Params:
///    arg1 = Specifies the device context with the desired outline font. The outline font of <i>hdc</i> is used to create the
///           display lists in the current rendering context.
///    arg2 = Specifies the first of the set of glyphs that form the font outline display lists.
///    arg3 = Specifies the number of glyphs in the set of glyphs used to form the font outline display lists. The
///           <b>wglUseFontOutlines</b> function creates <i>count</i> display lists, one display list for each glyph in a set
///           of glyphs.
///    arg4 = Specifies a starting display list.
///    arg5 = Specifies the maximum chordal deviation from the original outlines. When deviation is zero, the chordal deviation
///           is equivalent to one design unit of the original font. The value of <i>deviation</i> must be equal to or greater
///           than 0.
///    arg6 = Specifies how much a font is extruded in the negative <i>z</i> direction. The value must be equal to or greater
///           than 0. When <i>extrusion</i> is 0, the display lists are not extruded.
///    arg7 = Specifies the format, either WGL_FONT_LINES or WGL_FONT_POLYGONS, to use in the display lists. When <i>format</i>
///           is WGL_FONT_LINES, the <b>wglUseFontOutlines</b> function creates fonts with line segments. When <i>format</i> is
///           WGL_FONT_POLYGONS, <b>wglUseFontOutlines</b> creates fonts with polygons.
///    arg8 = Points to an array of <i>count</i>GLYPHMETRICSFLOAT structures that is to receive the metrics of the glyphs. When
///           <i>lpgmf</i> is <b>NULL</b>, no glyph metrics are returned.
///Returns:
///    When the function succeeds, the return value is <b>TRUE</b>. When the function fails, the return value is
///    <b>FALSE</b> and no display lists are generated. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglUseFontOutlinesW(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, 
                         GLYPHMETRICSFLOAT* param7);

///The <b>wglDescribeLayerPlane</b> function obtains information about the layer planes of a given pixel format.
///Params:
///    arg1 = Specifies the device context of a window whose layer planes are to be described.
///    arg2 = Specifies which layer planes of a pixel format are being described.
///    arg3 = Specifies the overlay or underlay plane. Positive values of <i>iLayerPlane</i> identify overlay planes, where 1
///           is the first overlay plane over the main plane, 2 is the second overlay plane over the first overlay plane, and
///           so on. Negative values identify underlay planes, where 1 is the first underlay plane under the main plane, 2 is
///           the second underlay plane under the first underlay plane, and so on. The number of overlay and underlay planes is
///           given in the <b>bReserved</b> member of the PIXELFORMATDESCRIPTOR structure.
///    arg4 = Specifies the size, in bytes, of the structure pointed to by <i>plpd</i>. The <b>wglDescribeLayerPlane</b>
///           function stores layer plane data in a LAYERPLANEDESCRIPTOR structure, and stores no more than <i>nBytes</i> of
///           data. Set the value of <i>nBytes</i> to the size of <b>LAYERPLANEDESCRIPTOR</b>.
///    arg5 = Points to a <b>LAYERPLANEDESCRIPTOR</b> structure. The <b>wglDescribeLayerPlane</b> function sets the value of
///           the structure's data members. The function stores the number of bytes of data copied to the structure in the
///           <b>nSize</b> member.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. In addition, the <b>wglDescribeLayerPlane</b> function
///    sets the members of the <b>LAYERPLANEDESCRIPTOR</b> structure pointed to by <i>plpd</i> according to the
///    specified layer plane (<i>iLayerPlane</i> ) of the specified pixel format (<i>iPixelFormat</i> ). If the function
///    fails, the return value is <b>FALSE</b>.
///    
@DllImport("OPENGL32")
BOOL wglDescribeLayerPlane(HDC param0, int param1, int param2, uint param3, LAYERPLANEDESCRIPTOR* param4);

///Sets the palette entries in a given color-index layer plane for a specified device context.
///Params:
///    arg1 = Type: <b>HDC</b> The device context of a window whose layer palette is to be set.
///    arg2 = Type: <b>int</b> An overlay or underlay plane. Positive values of <i>iLayerPlane</i> identify overlay planes,
///           where 1 is the first overlay plane over the main plane, 2 is the second overlay plane over the first overlay
///           plane, and so on. Negative values identify underlay planes, where 1 is the first underlay plane under the main
///           plane, 2 is the second underlay plane under the first underlay plane, and so on. The number of overlay and
///           underlay planes is given in the <b>bReserved</b> member of the PIXELFORMATDESCRIPTOR structure.
///    arg3 = Type: <b>int</b> The first palette entry to be set.
///    arg4 = Type: <b>int</b> The number of palette entries to be set.
///    arg5 = Type: <b>const COLORREF*</b> A pointer to the first member of an array of <i>cEntries</i> structures that contain
///           RGB color information.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of entries that were set in the palette
///    in the specified layer plane of the window. If the function fails or no pixel format is selected, the return
///    value is zero. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
int wglSetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, const(uint)* param4);

///Retrieves the palette entries from a given color-index layer plane for a specified device context.
///Params:
///    arg1 = Type: <b>HDC</b> The device context of a window whose layer planes are to be described.
///    arg2 = Type: <b>int</b> The overlay or underlay plane. Positive values of <i>iLayerPlane</i> identify overlay planes,
///           where 1 is the first overlay plane over the main plane, 2 is the second overlay plane over the first overlay
///           plane, and so on. Negative values identify underlay planes, where 1 is the first underlay plane under the main
///           plane, 2 is the second underlay plane under the first underlay plane, and so on. The number of overlay and
///           underlay planes is given in the <b>bReserved</b> member of the PIXELFORMATDESCRIPTOR structure.
///    arg3 = Type: <b>int</b> The first palette entry to be retrieved.
///    arg4 = Type: <b>int</b> The number of palette entries to be retrieved.
///    arg5 = Type: <b>COLORREF*</b> An array of structures that contain palette RGB color values. The array must contain at
///           least as many structures as specified by <i>cEntries</i>.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of entries that were set in the palette
///    in the specified layer plane of the window. If the function fails or when no pixel format is selected, the return
///    value is zero. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
int wglGetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, uint* param4);

///The <b>wglRealizeLayerPalette</b> function maps palette entries from a given color-index layer plane into the
///physical palette or initializes the palette of an RGBA layer plane.
///Params:
///    arg1 = Specifies the device context of a window whose layer plane palette is to be realized into the physical palette.
///    arg2 = Specifies the overlay or underlay plane. Positive values of <i>iLayerPlane</i> identify overlay planes, where 1
///           is the first overlay plane over the main plane, 2 is the second overlay plane over the first overlay plane, and
///           so on. Negative values identify underlay planes, where 1 is the first underlay plane under the main plane, 2 is
///           the second underlay plane under the first underlay plane, and so on. The number of overlay and underlay planes is
///           given in the <b>bReserved</b> member of the PIXELFORMATDESCRIPTOR structure.
///    arg3 = Indicates whether the palette is to be realized into the physical palette. When <i>bRealize</i> is <b>TRUE</b>,
///           the palette entries are mapped into the physical palette where available. When <i>bRealize</i> is <b>FALSE</b>,
///           the palette entries for the layer plane of the window are no longer needed and might be released for use by
///           another foreground window.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>, even if <i>bRealize</i> is <b>TRUE</b> and the
///    physical palette is not available. If the function fails or when no pixel format is selected, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglRealizeLayerPalette(HDC param0, int param1, BOOL param2);

///The <b>wglSwapLayerBuffers</b> function swaps the front and back buffers in the overlay, underlay, and main planes of
///the window referenced by a specified device context.
///Params:
///    arg1 = Specifies the device context of a window whose layer plane palette is to be realized into the physical palette.
///    arg2 = Specifies the overlay, underlay, and main planes whose front and back buffers are to be swapped. The
///           <b>bReserved</b> member of the PIXELFORMATDESCRIPTOR structure specifies the number of overlay and underlay
///           planes. The <i>fuPlanes</i> parameter is a bitwise combination of the following values.<div> </div> <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WGL_SWAP_MAIN_PLANE"></a><a
///           id="wgl_swap_main_plane"></a><dl> <dt><b>WGL_SWAP_MAIN_PLANE</b></dt> </dl> </td> <td width="60%"> Swaps the
///           front and back buffers of the main plane. </td> </tr> <tr> <td width="40%"><a id="WGL_SWAP_OVERLAYi"></a><a
///           id="wgl_swap_overlayi"></a><a id="WGL_SWAP_OVERLAYI"></a><dl> <dt><b>WGL_SWAP_OVERLAYi</b></dt> </dl> </td> <td
///           width="60%"> Swaps the front and back buffers of the overlay plane <i>i</i>, where <i>i</i> is an integer between
///           1 and 15. WGL_SWAP_OVERLAY1 identifies the first overlay plane over the main plane, WGL_SWAP_OVERLAY2 identifies
///           the second overlay plane over the first overlay plane, and so on. </td> </tr> <tr> <td width="40%"><a
///           id="WGL_SWAP_UNDERLAYi"></a><a id="wgl_swap_underlayi"></a><a id="WGL_SWAP_UNDERLAYI"></a><dl>
///           <dt><b>WGL_SWAP_UNDERLAYi</b></dt> </dl> </td> <td width="60%"> Swaps the front and back buffers of the underlay
///           plane <i>i</i>, where <i>i</i> is an integer between 1 and 15. WGL_SWAP_UNDERLAY1 identifies the first underlay
///           plane under the main plane, WGL_SWAP_UNDERLAY2 identifies the second underlay plane under the first underlay
///           plane, and so on. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("OPENGL32")
BOOL wglSwapLayerBuffers(HDC param0, uint param1);


