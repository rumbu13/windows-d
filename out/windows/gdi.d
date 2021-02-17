// Written in the D programming language.

module windows.gdi;

public import windows.core;
public import windows.dataexchange : METAFILEPICT;
public import windows.direct2d : PALETTEENTRY;
public import windows.directshow : BITMAPINFOHEADER;
public import windows.displaydevices : DEVMODEW, DISPLAYCONFIG_DEVICE_INFO_HEADER,
                                       POINT, POINTL, POINTS, RECT, RECTL, SIZE;
public import windows.intl : FONTSIGNATURE;
public import windows.opengl : PIXELFORMATDESCRIPTOR;
public import windows.shell : LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;
public import windows.windowscolorsystem : CIEXYZTRIPLE, LOGCOLORSPACEA, LOGCOLORSPACEW;
public import windows.xps : DEVMODEA;

extern(Windows):


// Enums


alias DISPLAYCONFIG_COLOR_ENCODING = int;
enum : int
{
    DISPLAYCONFIG_COLOR_ENCODING_RGB          = 0x00000000,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR444     = 0x00000001,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR422     = 0x00000002,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR420     = 0x00000003,
    DISPLAYCONFIG_COLOR_ENCODING_INTENSITY    = 0x00000004,
    DISPLAYCONFIG_COLOR_ENCODING_FORCE_UINT32 = 0xffffffff,
}

alias tagMxdcLandscapeRotationEnums = int;
enum : int
{
    MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_90_DEGREES  = 0x0000005a,
    MXDC_LANDSCAPE_ROTATE_NONE                         = 0x00000000,
    MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_270_DEGREES = 0xffffffa6,
}

alias tagMxdcImageTypeEnums = int;
enum : int
{
    MXDC_IMAGETYPE_JPEGHIGH_COMPRESSION   = 0x00000001,
    MXDC_IMAGETYPE_JPEGMEDIUM_COMPRESSION = 0x00000002,
    MXDC_IMAGETYPE_JPEGLOW_COMPRESSION    = 0x00000003,
    MXDC_IMAGETYPE_PNG                    = 0x00000004,
}

alias tagMxdcS0PageEnums = int;
enum : int
{
    MXDC_RESOURCE_TTF            = 0x00000000,
    MXDC_RESOURCE_JPEG           = 0x00000001,
    MXDC_RESOURCE_PNG            = 0x00000002,
    MXDC_RESOURCE_TIFF           = 0x00000003,
    MXDC_RESOURCE_WDP            = 0x00000004,
    MXDC_RESOURCE_DICTIONARY     = 0x00000005,
    MXDC_RESOURCE_ICC_PROFILE    = 0x00000006,
    MXDC_RESOURCE_JPEG_THUMBNAIL = 0x00000007,
    MXDC_RESOURCE_PNG_THUMBNAIL  = 0x00000008,
    MXDC_RESOURCE_MAX            = 0x00000009,
}

// Callbacks

alias OLDFONTENUMPROCA = int function(const(LOGFONTA)* param0, const(TEXTMETRICA)* param1, uint param2, 
                                      LPARAM param3);
alias OLDFONTENUMPROCW = int function(const(LOGFONTW)* param0, const(TEXTMETRICW)* param1, uint param2, 
                                      LPARAM param3);
alias FONTENUMPROCA = int function();
alias FONTENUMPROCW = int function();
alias FONTENUMPROC = int function();
///The <b>EnumObjectsProc</b> function is an application-defined callback function used with the EnumObjects function.
///It is used to process the object data. The <b>GOBJENUMPROC</b> type defines a pointer to this callback function.
///<b>EnumObjectsProc</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///Returns:
///    To continue enumeration, the callback function must return a nonzero value. This value is user-defined. To stop
///    enumeration, the callback function must return zero.
///    
alias GOBJENUMPROC = int function(void* param0, LPARAM param1);
///The <b>LineDDAProc</b> function is an application-defined callback function used with the LineDDA function. It is
///used to process coordinates. The <b>LINEDDAPROC</b> type defines a pointer to this callback function.
///<b>LineDDAProc</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
alias LINEDDAPROC = void function(int param0, int param1, LPARAM param2);
alias LPFNDEVMODE = uint function(HWND param0, ptrdiff_t param1, DEVMODEA* param2, const(char)* param3, 
                                  const(char)* param4, DEVMODEA* param5, const(char)* param6, uint param7);
alias LPFNDEVCAPS = uint function(const(char)* param0, const(char)* param1, uint param2, const(char)* param3, 
                                  DEVMODEA* param4);
///The <b>EnumMetaFileProc</b> function is an application-defined callback function that processes Windows-format
///metafile records. This function is called by the EnumMetaFile function. The <b>MFENUMPROC</b> type defines a pointer
///to this callback function. <b>EnumMetaFileProc</b> is a placeholder for the application-defined function name. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is EnhMetaFileProc.</div><div> </div>
///Params:
///    hdc = 
///    lpht = 
///    lpMR = 
///    nObj = Specifies the number of objects with associated handles in the handle table.
///    param = 
///    hDC = Handle to the device context passed to EnumMetaFile.
///Returns:
///    This function must return a nonzero value to continue enumeration; to stop enumeration, it must return zero.
///    
alias MFENUMPROC = int function(HDC hdc, char* lpht, METARECORD* lpMR, int nObj, LPARAM param4);
///The <b>EnhMetaFileProc</b> function is an application-defined callback function used with the EnumEnhMetaFile
///function. The <b>ENHMFENUMPROC</b> type defines a pointer to this callback function. <b>EnhMetaFileProc</b> is a
///placeholder for the application-defined function name.
///Params:
///    hdc = 
///    lpht = 
///    lpmr = 
///    nHandles = 
///    data = 
///    hDC = Handle to the device context passed to EnumEnhMetaFile.
///Returns:
///    This function must return a nonzero value to continue enumeration; to stop enumeration, it must return zero.
///    
alias ENHMFENUMPROC = int function(HDC hdc, char* lpht, const(ENHMETARECORD)* lpmr, int nHandles, LPARAM data);
///Client-provided callback function, used by CreateFontPackage and MergeFontPackage to allocate memory.
///Params:
///    Arg1 = Number of bytes to allocate.
///Returns:
///    Returns a void pointer to the allocated space, or <b>NULL</b> if there is insufficient memory available.
///    
alias CFP_ALLOCPROC = void* function(size_t param0);
///Client-provided callback function, used by CreateFontPackage and MergeFontPackage to reallocate memory when the size
///of an allocated buffer needs to change.
///Params:
///    Arg1 = Pointer to previously allocated memory block.
///    Arg2 = New size in bytes.
///Returns:
///    Returns a void pointer to the reallocated (and possibly moved) memory block. The return value should be
///    <b>NULL</b> if the size is zero and the <i>memblock</i> argument is not <b>NULL</b>, or if there is not enough
///    available memory to expand the block to the given size. In the first case, the original block should be freed. In
///    the second, the original block should be unchanged.
///    
alias CFP_REALLOCPROC = void* function(void* param0, size_t param1);
///Client-provided callback function, used by CreateFontPackage and MergeFontPackage to free memory.
///Params:
///    Arg1 = Previously allocated memory block to be freed.
///Returns:
///    Deallocates a memory block (<i>memblock</i>) that was previously allocated by a call to a CFP_ALLOCPROC or
///    CFP_REALLOCPROC callback function. If memblock is <b>NULL</b>, the pointer should be ignored and the function
///    should return immediately. The function is not required to correctly handle being passed an invalid pointer (a
///    pointer to a memory block that was not allocated by the appropriate CFP_ALLOCPROC or CFP_REALLOCPROC callback
///    function).
///    
alias CFP_FREEPROC = void function(void* param0);
alias READEMBEDPROC = uint function(void* param0, void* param1, const(uint) param2);
alias WRITEEMBEDPROC = uint function(void* param0, const(void)* param1, const(uint) param2);
///The <b>OutputProc</b> function is an application-defined callback function used with the GrayString function. It is
///used to draw a string. The <b>GRAYSTRINGPROC</b> type defines a pointer to this callback function. <b>OutputProc</b>
///is a placeholder for the application-defined or library-defined function name.
///Params:
///    Arg1 = A handle to a device context with a bitmap of at least the width and height specified by the <i>nWidth</i> and
///           <i>nHeight</i> parameters passed to GrayString.
///    Arg2 = A pointer to the string to be drawn.
///    Arg3 = The length, in characters, of the string.
///Returns:
///    If it succeeds, the callback function should return <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>.
///    
alias GRAYSTRINGPROC = BOOL function(HDC param0, LPARAM param1, int param2);
///The <b>DrawStateProc</b> function is an application-defined callback function that renders a complex image for the
///DrawState function. The <b>DRAWSTATEPROC</b> type defines a pointer to this callback function. <b>DrawStateProc</b>
///is a placeholder for the application-defined function name.
///Params:
///    hdc = A handle to the device context to draw in. The device context is a memory device context with a bitmap selected,
///          the dimensions of which are at least as great as those specified by the <i>cx</i> and <i>cy</i> parameters.
///    lData = Specifies information about the image, which the application passed to DrawState.
///    wData = Specifies information about the image, which the application passed to DrawState.
///    cx = The image width, in device units, as specified by the call to DrawState.
///    cy = The image height, in device units, as specified by the call to DrawState.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>.
///    
alias DRAWSTATEPROC = BOOL function(HDC hdc, LPARAM lData, WPARAM wData, int cx, int cy);
///A <b>MonitorEnumProc</b> function is an application-defined callback function that is called by the
///EnumDisplayMonitors function. A value of type <b>MONITORENUMPROC</b> is a pointer to a <b>MonitorEnumProc</b>
///function.
///Params:
///    Arg1 = A handle to the display monitor. This value will always be non-<b>NULL</b>.
///    Arg2 = A handle to a device context. The device context has color attributes that are appropriate for the display
///           monitor identified by <i>hMonitor</i>. The clipping area of the device context is set to the intersection of the
///           visible region of the device context identified by the <i>hdc</i> parameter of EnumDisplayMonitors, the rectangle
///           pointed to by the <i>lprcClip</i> parameter of <b>EnumDisplayMonitors</b>, and the display monitor rectangle.
///           This value is <b>NULL</b> if the <i>hdc</i> parameter of EnumDisplayMonitors was <b>NULL</b>.
///    Arg3 = A pointer to a RECT structure. If <i>hdcMonitor</i> is non-<b>NULL</b>, this rectangle is the intersection of the
///           clipping area of the device context identified by <i>hdcMonitor</i> and the display monitor rectangle. The
///           rectangle coordinates are device-context coordinates. If <i>hdcMonitor</i> is <b>NULL</b>, this rectangle is the
///           display monitor rectangle. The rectangle coordinates are virtual-screen coordinates.
///    Arg4 = Application-defined data that EnumDisplayMonitors passes directly to the enumeration function.
///Returns:
///    To continue the enumeration, return <b>TRUE</b>. To stop the enumeration, return <b>FALSE</b>.
///    
alias MONITORENUMPROC = BOOL function(ptrdiff_t param0, HDC param1, RECT* param2, LPARAM param3);

// Structs


///The <b>XFORM</b> structure specifies a world-space to page-space transformation.
struct XFORM
{
    ///The following. <table> <tr> <th>Operation</th> <th>Meaning</th> </tr> <tr> <td>Scaling</td> <td>Horizontal
    ///scaling component</td> </tr> <tr> <td>Rotation</td> <td>Cosine of rotation angle</td> </tr> <tr>
    ///<td>Reflection</td> <td>Horizontal component</td> </tr> </table>
    float eM11;
    ///The following. <table> <tr> <th>Operation</th> <th>Meaning</th> </tr> <tr> <td>Shear</td> <td>Horizontal
    ///proportionality constant</td> </tr> <tr> <td>Rotation</td> <td>Sine of the rotation angle</td> </tr> </table>
    float eM12;
    ///The following. <table> <tr> <th>Operation</th> <th>Meaning</th> </tr> <tr> <td>Shear</td> <td>Vertical
    ///proportionality constant</td> </tr> <tr> <td>Rotation</td> <td>Negative sine of the rotation angle</td> </tr>
    ///</table>
    float eM21;
    ///The following. <table> <tr> <th>Operation</th> <th>Meaning</th> </tr> <tr> <td>Scaling</td> <td>Vertical scaling
    ///component</td> </tr> <tr> <td>Rotation</td> <td>Cosine of rotation angle</td> </tr> <tr> <td>Reflection</td>
    ///<td>Vertical reflection component</td> </tr> </table>
    float eM22;
    ///The horizontal translation component, in logical units.
    float eDx;
    ///The vertical translation component, in logical units.
    float eDy;
}

///The <b>BITMAP</b> structure defines the type, width, height, color format, and bit values of a bitmap.
struct BITMAP
{
    ///The bitmap type. This member must be zero.
    int    bmType;
    ///The width, in pixels, of the bitmap. The width must be greater than zero.
    int    bmWidth;
    ///The height, in pixels, of the bitmap. The height must be greater than zero.
    int    bmHeight;
    ///The number of bytes in each scan line. This value must be divisible by 2, because the system assumes that the bit
    ///values of a bitmap form an array that is word aligned.
    int    bmWidthBytes;
    ///The count of color planes.
    ushort bmPlanes;
    ///The number of bits required to indicate the color of a pixel.
    ushort bmBitsPixel;
    ///A pointer to the location of the bit values for the bitmap. The <b>bmBits</b> member must be a pointer to an
    ///array of character (1-byte) values.
    void*  bmBits;
}

///The <b>RGBTRIPLE</b> structure describes a color consisting of relative intensities of red, green, and blue. The
///<b>bmciColors</b> member of the BITMAPCOREINFO structure consists of an array of <b>RGBTRIPLE</b> structures.
struct RGBTRIPLE
{
    ///The intensity of blue in the color.
    ubyte rgbtBlue;
    ///The intensity of green in the color.
    ubyte rgbtGreen;
    ///The intensity of red in the color.
    ubyte rgbtRed;
}

///The <b>RGBQUAD</b> structure describes a color consisting of relative intensities of red, green, and blue.
struct RGBQUAD
{
    ///The intensity of blue in the color.
    ubyte rgbBlue;
    ///The intensity of green in the color.
    ubyte rgbGreen;
    ///The intensity of red in the color.
    ubyte rgbRed;
    ///This member is reserved and must be zero.
    ubyte rgbReserved;
}

///The <b>BITMAPCOREHEADER</b> structure contains information about the dimensions and color format of a DIB.
struct BITMAPCOREHEADER
{
    ///The number of bytes required by the structure.
    uint   bcSize;
    ///The width of the bitmap, in pixels.
    ushort bcWidth;
    ///The height of the bitmap, in pixels.
    ushort bcHeight;
    ///The number of planes for the target device. This value must be 1.
    ushort bcPlanes;
    ///The number of bits-per-pixel. This value must be 1, 4, 8, or 24.
    ushort bcBitCount;
}

///The <b>BITMAPV4HEADER</b> structure is the bitmap information header file. It is an extended version of the
///BITMAPINFOHEADER structure. Applications can use the BITMAPV5HEADER structure for added functionality.
struct BITMAPV4HEADER
{
    ///The number of bytes required by the structure. Applications should use this member to determine which bitmap
    ///information header structure is being used.
    uint         bV4Size;
    ///The width of the bitmap, in pixels. If <b>bV4Compression</b> is BI_JPEG or BI_PNG, <b>bV4Width</b> specifies the
    ///width of the JPEG or PNG image in pixels.
    int          bV4Width;
    ///The height of the bitmap, in pixels. If <b>bV4Height</b> is positive, the bitmap is a bottom-up DIB and its
    ///origin is the lower-left corner. If <b>bV4Height</b> is negative, the bitmap is a top-down DIB and its origin is
    ///the upper-left corner. If <b>bV4Height</b> is negative, indicating a top-down DIB, <b>bV4Compression</b> must be
    ///either BI_RGB or BI_BITFIELDS. Top-down DIBs cannot be compressed. If <b>bV4Compression</b> is BI_JPEG or BI_PNG,
    ///<b>bV4Height</b> specifies the height of the JPEG or PNG image in pixels.
    int          bV4Height;
    ///The number of planes for the target device. This value must be set to 1.
    ushort       bV4Planes;
    ///The number of bits-per-pixel. The <b>bV4BitCount</b> member of the <b>BITMAPV4HEADER</b> structure determines the
    ///number of bits that define each pixel and the maximum number of colors in the bitmap. This member must be one of
    ///the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>0</td> <td> The number of
    ///bits-per-pixel is specified or is implied by the JPEG or PNG file format.</td> </tr> <tr> <td>1</td> <td>The
    ///bitmap is monochrome, and the <b>bmiColors</b> member of BITMAPINFO contains two entries. Each bit in the bitmap
    ///array represents a pixel. If the bit is clear, the pixel is displayed with the color of the first entry in the
    ///<b>bmiColors</b> table; if the bit is set, the pixel has the color of the second entry in the table.</td> </tr>
    ///<tr> <td>4</td> <td>The bitmap has a maximum of 16 colors, and the <b>bmiColors</b> member of BITMAPINFO contains
    ///up to 16 entries. Each pixel in the bitmap is represented by a 4-bit index into the color table. For example, if
    ///the first byte in the bitmap is 0x1F, the byte represents two pixels. The first pixel contains the color in the
    ///second table entry, and the second pixel contains the color in the sixteenth table entry.</td> </tr> <tr>
    ///<td>8</td> <td>The bitmap has a maximum of 256 colors, and the <b>bmiColors</b> member of BITMAPINFO contains up
    ///to 256 entries. In this case, each byte in the array represents a single pixel.</td> </tr> <tr> <td>16</td>
    ///<td>The bitmap has a maximum of 2^16 colors. If the <b>bV4Compression</b> member of the <b>BITMAPV4HEADER</b>
    ///structure is BI_RGB, the <b>bmiColors</b> member of BITMAPINFO is <b>NULL</b>. Each <b>WORD</b> in the bitmap
    ///array represents a single pixel. The relative intensities of red, green, and blue are represented with five bits
    ///for each color component. The value for blue is in the least significant five bits, followed by five bits each
    ///for green and red, respectively. The most significant bit is not used. The <b>bmiColors</b> color table is used
    ///for optimizing colors used on palette-based devices, and must contain the number of entries specified by the
    ///<b>bV4ClrUsed</b> member of the <b>BITMAPV4HEADER</b>.If the <b>bV4Compression</b> member of the
    ///<b>BITMAPV4HEADER</b> is BI_BITFIELDS, the <b>bmiColors</b> member contains three <b>DWORD</b> color masks that
    ///specify the red, green, and blue components of each pixel. Each <b>WORD</b> in the bitmap array represents a
    ///single pixel. </td> </tr> <tr> <td>24</td> <td>The bitmap has a maximum of 2^24 colors, and the <b>bmiColors</b>
    ///member of BITMAPINFO is <b>NULL</b>. Each 3-byte triplet in the bitmap array represents the relative intensities
    ///of blue, green, and red for a pixel. The <b>bmiColors</b> color table is used for optimizing colors used on
    ///palette-based devices, and must contain the number of entries specified by the <b>bV4ClrUsed</b> member of the
    ///<b>BITMAPV4HEADER</b>.</td> </tr> <tr> <td>32</td> <td>The bitmap has a maximum of 2^32 colors. If the
    ///<b>bV4Compression</b> member of the <b>BITMAPV4HEADER</b> is BI_RGB, the <b>bmiColors</b> member of BITMAPINFO is
    ///<b>NULL</b>. Each <b>DWORD</b> in the bitmap array represents the relative intensities of blue, green, and red
    ///for a pixel. The value for blue is in the least significant 8 bits, followed by 8 bits each for green and red.
    ///The high byte in each <b>DWORD</b> is not used. The <b>bmiColors</b> color table is used for optimizing colors
    ///used on palette-based devices, and must contain the number of entries specified by the <b>bV4ClrUsed</b> member
    ///of the <b>BITMAPV4HEADER</b>.If the <b>bV4Compression</b> member of the <b>BITMAPV4HEADER</b> is BI_BITFIELDS,
    ///the <b>bmiColors</b> member contains three <b>DWORD</b> color masks that specify the red, green, and blue
    ///components of each pixel. Each <b>DWORD</b> in the bitmap array represents a single pixel. </td> </tr> </table>
    ushort       bV4BitCount;
    ///The type of compression for a compressed bottom-up bitmap (top-down DIBs cannot be compressed). This member can
    ///be one of the following values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>BI_RGB</td>
    ///<td>An uncompressed format.</td> </tr> <tr> <td>BI_RLE8</td> <td>A run-length encoded (RLE) format for bitmaps
    ///with 8 bpp. The compression format is a 2-byte format consisting of a count byte followed by a byte containing a
    ///color index. For more information, see Bitmap Compression.</td> </tr> <tr> <td>BI_RLE4</td> <td>An RLE format for
    ///bitmaps with 4 bpp. The compression format is a 2-byte format consisting of a count byte followed by two
    ///word-length color indexes. For more information, see Bitmap Compression.</td> </tr> <tr> <td>BI_BITFIELDS</td>
    ///<td>Specifies that the bitmap is not compressed. The members <b>bV4RedMask</b>, <b>bV4GreenMask</b>, and
    ///<b>bV4BlueMask</b> specify the red, green, and blue components for each pixel. This is valid when used with 16-
    ///and 32-bpp bitmaps.</td> </tr> <tr> <td>BI_JPEG</td> <td> Specifies that the image is compressed using the JPEG
    ///file interchange format. JPEG compression trades off compression against loss; it can achieve a compression ratio
    ///of 20:1 with little noticeable loss.</td> </tr> <tr> <td>BI_PNG</td> <td> Specifies that the image is compressed
    ///using the PNG file interchange format.</td> </tr> </table>
    uint         bV4V4Compression;
    ///The size, in bytes, of the image. This may be set to zero for BI_RGB bitmaps. If <b>bV4Compression</b> is BI_JPEG
    ///or BI_PNG, <b>bV4SizeImage</b> is the size of the JPEG or PNG image buffer.
    uint         bV4SizeImage;
    ///The horizontal resolution, in pixels-per-meter, of the target device for the bitmap. An application can use this
    ///value to select a bitmap from a resource group that best matches the characteristics of the current device.
    int          bV4XPelsPerMeter;
    ///The vertical resolution, in pixels-per-meter, of the target device for the bitmap.
    int          bV4YPelsPerMeter;
    ///The number of color indexes in the color table that are actually used by the bitmap. If this value is zero, the
    ///bitmap uses the maximum number of colors corresponding to the value of the <b>bV4BitCount</b> member for the
    ///compression mode specified by <b>bV4Compression</b>. If <b>bV4ClrUsed</b> is nonzero and the <b>bV4BitCount</b>
    ///member is less than 16, the <b>bV4ClrUsed</b> member specifies the actual number of colors the graphics engine or
    ///device driver accesses. If <b>bV4BitCount</b> is 16 or greater, the <b>bV4ClrUsed</b> member specifies the size
    ///of the color table used to optimize performance of the system color palettes. If <b>bV4BitCount</b> equals 16 or
    ///32, the optimal color palette starts immediately following the <b>BITMAPV4HEADER</b>.
    uint         bV4ClrUsed;
    ///The number of color indexes that are required for displaying the bitmap. If this value is zero, all colors are
    ///important.
    uint         bV4ClrImportant;
    ///Color mask that specifies the red component of each pixel, valid only if <b>bV4Compression</b> is set to
    ///BI_BITFIELDS.
    uint         bV4RedMask;
    ///Color mask that specifies the green component of each pixel, valid only if <b>bV4Compression</b> is set to
    ///BI_BITFIELDS.
    uint         bV4GreenMask;
    ///Color mask that specifies the blue component of each pixel, valid only if <b>bV4Compression</b> is set to
    ///BI_BITFIELDS.
    uint         bV4BlueMask;
    ///Color mask that specifies the alpha component of each pixel.
    uint         bV4AlphaMask;
    ///The color space of the DIB. The following table lists the value for <b>bV4CSType</b>. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>LCS_CALIBRATED_RGB</td> <td>This value indicates that endpoints and gamma values
    ///are given in the appropriate fields.</td> </tr> </table> See the LOGCOLORSPACE structure for information that
    ///defines a logical color space.
    uint         bV4CSType;
    ///A CIEXYZTRIPLE structure that specifies the x, y, and z coordinates of the three colors that correspond to the
    ///red, green, and blue endpoints for the logical color space associated with the bitmap. This member is ignored
    ///unless the <b>bV4CSType</b> member specifies LCS_CALIBRATED_RGB. <div class="alert"><b>Note</b> A <i>color
    ///space</i> is a model for representing color numerically in terms of three or more coordinates. For example, the
    ///RGB color space represents colors in terms of the red, green, and blue coordinates.</div> <div> </div>
    CIEXYZTRIPLE bV4Endpoints;
    ///Tone response curve for red. This member is ignored unless color values are calibrated RGB values and
    ///<b>bV4CSType</b> is set to LCS_CALIBRATED_RGB. Specify in unsigned fixed 16.16 format. The upper 16 bits are the
    ///unsigned integer value. The lower 16 bits are the fractional part.
    uint         bV4GammaRed;
    ///Tone response curve for green. Used if <b>bV4CSType</b> is set to LCS_CALIBRATED_RGB. Specify in unsigned fixed
    ///16.16 format. The upper 16 bits are the unsigned integer value. The lower 16 bits are the fractional part.
    uint         bV4GammaGreen;
    ///Tone response curve for blue. Used if <b>bV4CSType</b> is set to LCS_CALIBRATED_RGB. Specify in unsigned fixed
    ///16.16 format. The upper 16 bits are the unsigned integer value. The lower 16 bits are the fractional part.
    uint         bV4GammaBlue;
}

///The <b>BITMAPV5HEADER</b> structure is the bitmap information header file. It is an extended version of the
///BITMAPINFOHEADER structure.
struct BITMAPV5HEADER
{
    ///The number of bytes required by the structure. Applications should use this member to determine which bitmap
    ///information header structure is being used.
    uint         bV5Size;
    ///The width of the bitmap, in pixels. If <b>bV5Compression</b> is BI_JPEG or BI_PNG, the <b>bV5Width</b> member
    ///specifies the width of the decompressed JPEG or PNG image in pixels.
    int          bV5Width;
    ///The height of the bitmap, in pixels. If the value of <b>bV5Height</b> is positive, the bitmap is a bottom-up DIB
    ///and its origin is the lower-left corner. If <b>bV5Height</b> value is negative, the bitmap is a top-down DIB and
    ///its origin is the upper-left corner. If <b>bV5Height</b> is negative, indicating a top-down DIB,
    ///<b>bV5Compression</b> must be either BI_RGB or BI_BITFIELDS. Top-down DIBs cannot be compressed. If
    ///<b>bV5Compression</b> is BI_JPEG or BI_PNG, the <b>bV5Height</b> member specifies the height of the decompressed
    ///JPEG or PNG image in pixels.
    int          bV5Height;
    ///The number of planes for the target device. This value must be set to 1.
    ushort       bV5Planes;
    ///The number of bits that define each pixel and the maximum number of colors in the bitmap. This member can be one
    ///of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>0</td> <td>The number of
    ///bits per pixel is specified or is implied by the JPEG or PNG file format.</td> </tr> <tr> <td>1</td> <td>The
    ///bitmap is monochrome, and the <b>bmiColors</b> member of BITMAPINFO contains two entries. Each bit in the bitmap
    ///array represents a pixel. If the bit is clear, the pixel is displayed with the color of the first entry in the
    ///<b>bmiColors</b> color table. If the bit is set, the pixel has the color of the second entry in the table.</td>
    ///</tr> <tr> <td>4</td> <td>The bitmap has a maximum of 16 colors, and the <b>bmiColors</b> member of BITMAPINFO
    ///contains up to 16 entries. Each pixel in the bitmap is represented by a 4-bit index into the color table. For
    ///example, if the first byte in the bitmap is 0x1F, the byte represents two pixels. The first pixel contains the
    ///color in the second table entry, and the second pixel contains the color in the sixteenth table entry.</td> </tr>
    ///<tr> <td>8</td> <td>The bitmap has a maximum of 256 colors, and the <b>bmiColors</b> member of BITMAPINFO
    ///contains up to 256 entries. In this case, each byte in the array represents a single pixel.</td> </tr> <tr>
    ///<td>16</td> <td>The bitmap has a maximum of 2^16 colors. If the <b>bV5Compression</b> member of the
    ///<b>BITMAPV5HEADER</b> structure is BI_RGB, the <b>bmiColors</b> member of BITMAPINFO is <b>NULL</b>. Each
    ///<b>WORD</b> in the bitmap array represents a single pixel. The relative intensities of red, green, and blue are
    ///represented with five bits for each color component. The value for blue is in the least significant five bits,
    ///followed by five bits each for green and red. The most significant bit is not used. The <b>bmiColors</b> color
    ///table is used for optimizing colors used on palette-based devices, and must contain the number of entries
    ///specified by the <b>bV5ClrUsed</b> member of the <b>BITMAPV5HEADER</b>.If the <b>bV5Compression</b> member of the
    ///<b>BITMAPV5HEADER</b> is BI_BITFIELDS, the <b>bmiColors</b> member contains three <b>DWORD</b> color masks that
    ///specify the red, green, and blue components, respectively, of each pixel. Each <b>WORD</b> in the bitmap array
    ///represents a single pixel. When the <b>bV5Compression</b> member is BI_BITFIELDS, bits set in each <b>DWORD</b>
    ///mask must be contiguous and should not overlap the bits of another mask. All the bits in the pixel do not need to
    ///be used. </td> </tr> <tr> <td>24</td> <td>The bitmap has a maximum of 2^24 colors, and the <b>bmiColors</b>
    ///member of BITMAPINFO is <b>NULL</b>. Each 3-byte triplet in the bitmap array represents the relative intensities
    ///of blue, green, and red, respectively, for a pixel. The <b>bmiColors</b> color table is used for optimizing
    ///colors used on palette-based devices, and must contain the number of entries specified by the <b>bV5ClrUsed</b>
    ///member of the <b>BITMAPV5HEADER</b> structure.</td> </tr> <tr> <td>32</td> <td>The bitmap has a maximum of 2^32
    ///colors. If the <b>bV5Compression</b> member of the <b>BITMAPV5HEADER</b> is BI_RGB, the <b>bmiColors</b> member
    ///of BITMAPINFO is <b>NULL</b>. Each <b>DWORD</b> in the bitmap array represents the relative intensities of blue,
    ///green, and red for a pixel. The value for blue is in the least significant 8 bits, followed by 8 bits each for
    ///green and red. The high byte in each <b>DWORD</b> is not used. The <b>bmiColors</b> color table is used for
    ///optimizing colors used on palette-based devices, and must contain the number of entries specified by the
    ///<b>bV5ClrUsed</b> member of the <b>BITMAPV5HEADER</b>.If the <b>bV5Compression</b> member of the
    ///<b>BITMAPV5HEADER</b> is BI_BITFIELDS, the <b>bmiColors</b> member contains three <b>DWORD</b> color masks that
    ///specify the red, green, and blue components of each pixel. Each <b>DWORD</b> in the bitmap array represents a
    ///single pixel. </td> </tr> </table>
    ushort       bV5BitCount;
    ///Specifies that the bitmap is not compressed. The <b>bV5RedMask</b>, <b>bV5GreenMask</b>, and <b>bV5BlueMask</b>
    ///members specify the red, green, and blue components of each pixel. This is valid when used with 16- and 32-bpp
    ///bitmaps. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>BI_RGB</td> <td>An uncompressed format.</td> </tr> <tr> <td>BI_RLE8</td> <td>A run-length encoded (RLE)
    ///format for bitmaps with 8 bpp. The compression format is a two-byte format consisting of a count byte followed by
    ///a byte containing a color index. If <b>bV5Compression</b> is BI_RGB and the <b>bV5BitCount</b> member is 16, 24,
    ///or 32, the bitmap array specifies the actual intensities of blue, green, and red rather than using color table
    ///indexes. For more information, see Bitmap Compression.</td> </tr> <tr> <td>BI_RLE4</td> <td>An RLE format for
    ///bitmaps with 4 bpp. The compression format is a two-byte format consisting of a count byte followed by two
    ///word-length color indexes. For more information, see Bitmap Compression.</td> </tr> <tr> <td>BI_BITFIELDS</td>
    ///<td>Specifies that the bitmap is not compressed and that the color masks for the red, green, and blue components
    ///of each pixel are specified in the <b>bV5RedMask</b>, <b>bV5GreenMask</b>, and <b>bV5BlueMask</b> members. This
    ///is valid when used with 16- and 32-bpp bitmaps.</td> </tr> <tr> <td>BI_JPEG</td> <td>Specifies that the image is
    ///compressed using the JPEG file Interchange Format. JPEG compression trades off compression against loss; it can
    ///achieve a compression ratio of 20:1 with little noticeable loss.</td> </tr> <tr> <td>BI_PNG</td> <td>Specifies
    ///that the image is compressed using the PNG file Interchange Format.</td> </tr> </table>
    uint         bV5Compression;
    ///The size, in bytes, of the image. This may be set to zero for BI_RGB bitmaps. If <b>bV5Compression</b> is BI_JPEG
    ///or BI_PNG, <b>bV5SizeImage</b> is the size of the JPEG or PNG image buffer.
    uint         bV5SizeImage;
    ///The horizontal resolution, in pixels-per-meter, of the target device for the bitmap. An application can use this
    ///value to select a bitmap from a resource group that best matches the characteristics of the current device.
    int          bV5XPelsPerMeter;
    ///The vertical resolution, in pixels-per-meter, of the target device for the bitmap.
    int          bV5YPelsPerMeter;
    ///The number of color indexes in the color table that are actually used by the bitmap. If this value is zero, the
    ///bitmap uses the maximum number of colors corresponding to the value of the <b>bV5BitCount</b> member for the
    ///compression mode specified by <b>bV5Compression</b>. If <b>bV5ClrUsed</b> is nonzero and <b>bV5BitCount</b> is
    ///less than 16, the <b>bV5ClrUsed</b> member specifies the actual number of colors the graphics engine or device
    ///driver accesses. If <b>bV5BitCount</b> is 16 or greater, the <b>bV5ClrUsed</b> member specifies the size of the
    ///color table used to optimize performance of the system color palettes. If <b>bV5BitCount</b> equals 16 or 32, the
    ///optimal color palette starts immediately following the <b>BITMAPV5HEADER</b>. If <b>bV5ClrUsed</b> is nonzero,
    ///the color table is used on palettized devices, and <b>bV5ClrUsed</b> specifies the number of entries.
    uint         bV5ClrUsed;
    ///The number of color indexes that are required for displaying the bitmap. If this value is zero, all colors are
    ///required.
    uint         bV5ClrImportant;
    ///Color mask that specifies the red component of each pixel, valid only if <b>bV5Compression</b> is set to
    ///BI_BITFIELDS.
    uint         bV5RedMask;
    ///Color mask that specifies the green component of each pixel, valid only if <b>bV5Compression</b> is set to
    ///BI_BITFIELDS.
    uint         bV5GreenMask;
    ///Color mask that specifies the blue component of each pixel, valid only if <b>bV5Compression</b> is set to
    ///BI_BITFIELDS.
    uint         bV5BlueMask;
    ///Color mask that specifies the alpha component of each pixel.
    uint         bV5AlphaMask;
    ///The color space of the DIB. The following table specifies the values for <b>bV5CSType</b>. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td>LCS_CALIBRATED_RGB</td> <td>This value implies that endpoints and
    ///gamma values are given in the appropriate fields.</td> </tr> <tr> <td>LCS_sRGB</td> <td>Specifies that the bitmap
    ///is in sRGB color space.</td> </tr> <tr> <td>LCS_WINDOWS_COLOR_SPACE</td> <td>This value indicates that the bitmap
    ///is in the system default color space, sRGB.</td> </tr> <tr> <td>PROFILE_LINKED</td> <td>This value indicates that
    ///<b>bV5ProfileData</b> points to the file name of the profile to use (gamma and endpoints values are
    ///ignored).</td> </tr> <tr> <td>PROFILE_EMBEDDED</td> <td>This value indicates that <b>bV5ProfileData</b> points to
    ///a memory buffer that contains the profile to be used (gamma and endpoints values are ignored).</td> </tr>
    ///</table> See the LOGCOLORSPACE structure for information that defines a logical color space.
    uint         bV5CSType;
    ///A CIEXYZTRIPLE structure that specifies the x, y, and z coordinates of the three colors that correspond to the
    ///red, green, and blue endpoints for the logical color space associated with the bitmap. This member is ignored
    ///unless the <b>bV5CSType</b> member specifies LCS_CALIBRATED_RGB.
    CIEXYZTRIPLE bV5Endpoints;
    ///Toned response curve for red. Used if <b>bV5CSType</b> is set to LCS_CALIBRATED_RGB. Specify in unsigned fixed
    ///16.16 format. The upper 16 bits are the unsigned integer value. The lower 16 bits are the fractional part.
    uint         bV5GammaRed;
    ///Toned response curve for green. Used if <b>bV5CSType</b> is set to LCS_CALIBRATED_RGB. Specify in unsigned fixed
    ///16.16 format. The upper 16 bits are the unsigned integer value. The lower 16 bits are the fractional part.
    uint         bV5GammaGreen;
    ///Toned response curve for blue. Used if <b>bV5CSType</b> is set to LCS_CALIBRATED_RGB. Specify in unsigned fixed
    ///16.16 format. The upper 16 bits are the unsigned integer value. The lower 16 bits are the fractional part.
    uint         bV5GammaBlue;
    ///Rendering intent for bitmap. This can be one of the following values. <table> <tr> <th>Value</th> <th>Intent</th>
    ///<th>ICC name</th> <th>Meaning</th> </tr> <tr> <td>LCS_GM_ABS_COLORIMETRIC</td> <td>Match</td> <td>Absolute
    ///Colorimetric</td> <td>Maintains the white point. Matches the colors to their nearest color in the destination
    ///gamut.</td> </tr> <tr> <td>LCS_GM_BUSINESS</td> <td>Graphic</td> <td>Saturation</td> <td>Maintains saturation.
    ///Used for business charts and other situations in which undithered colors are required.</td> </tr> <tr>
    ///<td>LCS_GM_GRAPHICS</td> <td>Proof</td> <td>Relative Colorimetric</td> <td>Maintains colorimetric match. Used for
    ///graphic designs and named colors.</td> </tr> <tr> <td>LCS_GM_IMAGES</td> <td>Picture</td> <td>Perceptual</td>
    ///<td>Maintains contrast. Used for photographs and natural images.</td> </tr> </table>
    uint         bV5Intent;
    ///The offset, in bytes, from the beginning of the <b>BITMAPV5HEADER</b> structure to the start of the profile data.
    ///If the profile is embedded, profile data is the actual profile, and it is linked. (The profile data is the
    ///null-terminated file name of the profile.) This cannot be a Unicode string. It must be composed exclusively of
    ///characters from the Windows character set (code page 1252). These profile members are ignored unless the
    ///<b>bV5CSType</b> member specifies PROFILE_LINKED or PROFILE_EMBEDDED.
    uint         bV5ProfileData;
    ///Size, in bytes, of embedded profile data.
    uint         bV5ProfileSize;
    ///This member has been reserved. Its value should be set to zero.
    uint         bV5Reserved;
}

///The <b>BITMAPINFO</b> structure defines the dimensions and color information for a DIB.
struct BITMAPINFO
{
    ///A BITMAPINFOHEADER structure that contains information about the dimensions of color format. .
    BITMAPINFOHEADER bmiHeader;
    ///The <b>bmiColors</b> member contains one of the following: <ul> <li>An array of RGBQUAD. The elements of the
    ///array that make up the color table.</li> <li>An array of 16-bit unsigned integers that specifies indexes into the
    ///currently realized logical palette. This use of <b>bmiColors</b> is allowed for functions that use DIBs. When
    ///<b>bmiColors</b> elements contain indexes to a realized logical palette, they must also call the following bitmap
    ///functions: CreateDIBitmap CreateDIBPatternBrush CreateDIBSection The <i>iUsage</i> parameter of CreateDIBSection
    ///must be set to DIB_PAL_COLORS. </li> </ul> The number of entries in the array depends on the values of the
    ///<b>biBitCount</b> and <b>biClrUsed</b> members of the BITMAPINFOHEADER structure. The colors in the
    ///<b>bmiColors</b> table appear in order of importance. For more information, see the Remarks section.
    RGBQUAD[1]       bmiColors;
}

///The <b>BITMAPCOREINFO</b> structure defines the dimensions and color information for a DIB.
struct BITMAPCOREINFO
{
    ///A BITMAPCOREHEADER structure that contains information about the dimensions and color format of a DIB.
    BITMAPCOREHEADER bmciHeader;
    ///Specifies an array of RGBTRIPLE structures that define the colors in the bitmap.
    RGBTRIPLE[1]     bmciColors;
}

///The <b>BITMAPFILEHEADER</b> structure contains information about the type, size, and layout of a file that contains a
///DIB.
struct BITMAPFILEHEADER
{
align (2):
    ///The file type; must be BM.
    ushort bfType;
    ///The size, in bytes, of the bitmap file.
    uint   bfSize;
    ///Reserved; must be zero.
    ushort bfReserved1;
    ///Reserved; must be zero.
    ushort bfReserved2;
    ///The offset, in bytes, from the beginning of the <b>BITMAPFILEHEADER</b> structure to the bitmap bits.
    uint   bfOffBits;
}

///The <b>HANDLETABLE</b> structure is an array of handles, each of which identifies a graphics device interface (GDI)
///object.
struct HANDLETABLE
{
    ///An array of handles.
    ptrdiff_t[1] objectHandle;
}

///The <b>METARECORD</b> structure contains a Windows-format metafile record.
struct METARECORD
{
    ///The size, in words, of the record.
    uint      rdSize;
    ///The function number.
    ushort    rdFunction;
    ///An array of words containing the function parameters, in reverse of the order they are passed to the function.
    ushort[1] rdParm;
}

///The <b>METAHEADER</b> structure contains information about a Windows-format metafile.
struct METAHEADER
{
align (2):
    ///Specifies whether the metafile is in memory or recorded in a disk file. This member can be one of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>1</td> <td>Metafile is in memory.</td> </tr>
    ///<tr> <td>2</td> <td>Metafile is in a disk file.</td> </tr> </table>
    ushort mtType;
    ///The size, in words, of the metafile header.
    ushort mtHeaderSize;
    ///The system version number. The version number for metafiles that support device-independent bitmaps (DIBs) is
    ///0x0300. Otherwise, the version number is 0x0100.
    ushort mtVersion;
    ///The size, in words, of the file.
    uint   mtSize;
    ///The maximum number of objects that exist in the metafile at the same time.
    ushort mtNoObjects;
    ///The size, in words, of the largest record in the metafile.
    uint   mtMaxRecord;
    ///Reserved.
    ushort mtNoParameters;
}

///The <b>ENHMETARECORD</b> structure contains data that describes a graphics device interface (GDI) function used to
///create part of a picture in an enhanced-format metafile.
struct ENHMETARECORD
{
    ///The record type.
    uint    iType;
    ///The size of the record, in bytes.
    uint    nSize;
    ///An array of parameters passed to the GDI function identified by the record.
    uint[1] dParm;
}

///The <b>ENHMETAHEADER</b> structure contains enhanced-metafile data such as the dimensions of the picture stored in
///the enhanced metafile, the count of records in the enhanced metafile, the resolution of the device on which the
///picture was created, and so on. This structure is always the first record in an enhanced metafile.
struct ENHMETAHEADER
{
    ///The record type. This member must specify the value assigned to the EMR_HEADER constant.
    uint   iType;
    ///The structure size, in bytes.
    uint   nSize;
    ///The dimensions, in device units, of the smallest rectangle that can be drawn around the picture stored in the
    ///metafile. This rectangle is supplied by graphics device interface (GDI). Its dimensions include the right and
    ///bottom edges.
    RECTL  rclBounds;
    ///The dimensions, in .01 millimeter units, of a rectangle that surrounds the picture stored in the metafile. This
    ///rectangle must be supplied by the application that creates the metafile. Its dimensions include the right and
    ///bottom edges.
    RECTL  rclFrame;
    ///A signature. This member must specify the value assigned to the ENHMETA_SIGNATURE constant.
    uint   dSignature;
    ///The metafile version. The current version value is 0x10000.
    uint   nVersion;
    ///The size of the enhanced metafile, in bytes.
    uint   nBytes;
    ///The number of records in the enhanced metafile.
    uint   nRecords;
    ///The number of handles in the enhanced-metafile handle table. (Index zero in this table is reserved.)
    ushort nHandles;
    ///Reserved; must be zero.
    ushort sReserved;
    ///The number of characters in the array that contains the description of the enhanced metafile's contents. This
    ///member should be set to zero if the enhanced metafile does not contain a description string.
    uint   nDescription;
    ///The offset from the beginning of the <b>ENHMETAHEADER</b> structure to the array that contains the description of
    ///the enhanced metafile's contents. This member should be set to zero if the enhanced metafile does not contain a
    ///description string.
    uint   offDescription;
    ///The number of entries in the enhanced metafile's palette.
    uint   nPalEntries;
    ///The resolution of the reference device, in pixels.
    SIZE   szlDevice;
    ///The resolution of the reference device, in millimeters.
    SIZE   szlMillimeters;
    ///The size of the last recorded pixel format in a metafile. If a pixel format is set in a reference DC at the start
    ///of recording, <i>cbPixelFormat</i> is set to the size of the PIXELFORMATDESCRIPTOR. When no pixel format is set
    ///when a metafile is recorded, this member is set to zero. If more than a single pixel format is set, the header
    ///points to the last pixel format.
    uint   cbPixelFormat;
    ///The offset of pixel format used when recording a metafile. If a pixel format is set in a reference DC at the
    ///start of recording or during recording, <i>offPixelFormat</i> is set to the offset of the PIXELFORMATDESCRIPTOR
    ///in the metafile. If no pixel format is set when a metafile is recorded, this member is set to zero. If more than
    ///a single pixel format is set, the header points to the last pixel format.
    uint   offPixelFormat;
    ///Indicates whether any OpenGL records are present in a metafile. <i>bOpenGL</i> is a simple Boolean flag that you
    ///can use to determine whether an enhanced metafile requires OpenGL handling. When a metafile contains OpenGL
    ///records, <i>bOpenGL</i> is <b>TRUE</b>; otherwise it is <b>FALSE</b>.
    uint   bOpenGL;
    ///The size of the reference device, in micrometers.
    SIZE   szlMicrometers;
}

///The <b>TEXTMETRIC</b> structure contains basic information about a physical font. All sizes are specified in logical
///units; that is, they depend on the current mapping mode of the display context.
struct TEXTMETRICA
{
    ///The height (ascent + descent) of characters.
    int   tmHeight;
    ///The ascent (units above the base line) of characters.
    int   tmAscent;
    ///The descent (units below the base line) of characters.
    int   tmDescent;
    ///The amount of leading (space) inside the bounds set by the <b>tmHeight</b> member. Accent marks and other
    ///diacritical characters may occur in this area. The designer may set this member to zero.
    int   tmInternalLeading;
    ///The amount of extra leading (space) that the application adds between rows. Since this area is outside the font,
    ///it contains no marks and is not altered by text output calls in either OPAQUE or TRANSPARENT mode. The designer
    ///may set this member to zero.
    int   tmExternalLeading;
    ///The average width of characters in the font (generally defined as the width of the letter <i>x</i> ). This value
    ///does not include the overhang required for bold or italic characters.
    int   tmAveCharWidth;
    ///The width of the widest character in the font.
    int   tmMaxCharWidth;
    ///The weight of the font.
    int   tmWeight;
    ///The extra width per string that may be added to some synthesized fonts. When synthesizing some attributes, such
    ///as bold or italic, graphics device interface (GDI) or a device may have to add width to a string on both a
    ///per-character and per-string basis. For example, GDI makes a string bold by expanding the spacing of each
    ///character and overstriking by an offset value; it italicizes a font by shearing the string. In either case, there
    ///is an overhang past the basic string. For bold strings, the overhang is the distance by which the overstrike is
    ///offset. For italic strings, the overhang is the amount the top of the font is sheared past the bottom of the
    ///font. The <b>tmOverhang</b> member enables the application to determine how much of the character width returned
    ///by a GetTextExtentPoint32 function call on a single character is the actual character width and how much is the
    ///per-string extra width. The actual width is the extent minus the overhang.
    int   tmOverhang;
    ///The horizontal aspect of the device for which the font was designed.
    int   tmDigitizedAspectX;
    ///The vertical aspect of the device for which the font was designed. The ratio of the <b>tmDigitizedAspectX</b> and
    ///<b>tmDigitizedAspectY</b> members is the aspect ratio of the device for which the font was designed.
    int   tmDigitizedAspectY;
    ///The value of the first character defined in the font.
    ubyte tmFirstChar;
    ///The value of the last character defined in the font.
    ubyte tmLastChar;
    ///The value of the character to be substituted for characters not in the font.
    ubyte tmDefaultChar;
    ///The value of the character that will be used to define word breaks for text justification.
    ubyte tmBreakChar;
    ///Specifies an italic font if it is nonzero.
    ubyte tmItalic;
    ///Specifies an underlined font if it is nonzero.
    ubyte tmUnderlined;
    ///A strikeout font if it is nonzero.
    ubyte tmStruckOut;
    ///Specifies information about the pitch, the technology, and the family of a physical font. The four low-order bits
    ///of this member specify information about the pitch and the technology of the font. A constant is defined for each
    ///of the four bits. <table> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td>TMPF_FIXED_PITCH</td> <td>If
    ///this bit is set the font is a variable pitch font. If this bit is clear the font is a fixed pitch font. Note very
    ///carefully that those meanings are the opposite of what the constant name implies.</td> </tr> <tr>
    ///<td>TMPF_VECTOR</td> <td>If this bit is set the font is a vector font.</td> </tr> <tr> <td>TMPF_TRUETYPE</td>
    ///<td>If this bit is set the font is a TrueType font.</td> </tr> <tr> <td>TMPF_DEVICE</td> <td>If this bit is set
    ///the font is a device font.</td> </tr> </table> An application should carefully test for qualities encoded in
    ///these low-order bits, making no arbitrary assumptions. For example, besides having their own bits set, TrueType
    ///and PostScript fonts set the TMPF_VECTOR bit. A monospace bitmap font has all of these low-order bits clear; a
    ///proportional bitmap font sets the TMPF_FIXED_PITCH bit. A Postscript printer device font sets the TMPF_DEVICE,
    ///TMPF_VECTOR, and TMPF_FIXED_PITCH bits. The four high-order bits of <b>tmPitchAndFamily</b> designate the font's
    ///font family. An application can use the value 0xF0 and the bitwise AND operator to mask out the four low-order
    ///bits of <b>tmPitchAndFamily</b>, thus obtaining a value that can be directly compared with font family names to
    ///find an identical match. For information about font families, see the description of the LOGFONT structure.
    ubyte tmPitchAndFamily;
    ///The character set of the font. The character set can be one of the following values. <ul> <li>ANSI_CHARSET</li>
    ///<li>BALTIC_CHARSET</li> <li>CHINESEBIG5_CHARSET</li> <li>DEFAULT_CHARSET</li> <li>EASTEUROPE_CHARSET</li>
    ///<li>GB2312_CHARSET</li> <li>GREEK_CHARSET</li> <li>HANGUL_CHARSET</li> <li>MAC_CHARSET</li> <li>OEM_CHARSET</li>
    ///<li>RUSSIAN_CHARSET</li> <li>SHIFTJIS_CHARSET</li> <li>SYMBOL_CHARSET</li> <li>TURKISH_CHARSET</li>
    ///<li>VIETNAMESE_CHARSET</li> </ul> <b>Korean language edition of Windows:</b> <ul> <li> JOHAB_CHARSET </li> </ul>
    ///<b>Middle East language edition of Windows:</b> <ul> <li> ARABIC_CHARSET </li> <li> HEBREW_CHARSET </li> </ul>
    ///<b>Thai language edition of Windows:</b> <ul> <li> THAI_CHARSET </li> </ul>
    ubyte tmCharSet;
}

///The <b>TEXTMETRIC</b> structure contains basic information about a physical font. All sizes are specified in logical
///units; that is, they depend on the current mapping mode of the display context.
struct TEXTMETRICW
{
    ///The height (ascent + descent) of characters.
    int    tmHeight;
    ///The ascent (units above the base line) of characters.
    int    tmAscent;
    ///The descent (units below the base line) of characters.
    int    tmDescent;
    ///The amount of leading (space) inside the bounds set by the <b>tmHeight</b> member. Accent marks and other
    ///diacritical characters may occur in this area. The designer may set this member to zero.
    int    tmInternalLeading;
    ///The amount of extra leading (space) that the application adds between rows. Since this area is outside the font,
    ///it contains no marks and is not altered by text output calls in either OPAQUE or TRANSPARENT mode. The designer
    ///may set this member to zero.
    int    tmExternalLeading;
    ///The average width of characters in the font (generally defined as the width of the letter <i>x</i> ). This value
    ///does not include the overhang required for bold or italic characters.
    int    tmAveCharWidth;
    ///The width of the widest character in the font.
    int    tmMaxCharWidth;
    ///The weight of the font.
    int    tmWeight;
    ///The extra width per string that may be added to some synthesized fonts. When synthesizing some attributes, such
    ///as bold or italic, graphics device interface (GDI) or a device may have to add width to a string on both a
    ///per-character and per-string basis. For example, GDI makes a string bold by expanding the spacing of each
    ///character and overstriking by an offset value; it italicizes a font by shearing the string. In either case, there
    ///is an overhang past the basic string. For bold strings, the overhang is the distance by which the overstrike is
    ///offset. For italic strings, the overhang is the amount the top of the font is sheared past the bottom of the
    ///font. The <b>tmOverhang</b> member enables the application to determine how much of the character width returned
    ///by a GetTextExtentPoint32 function call on a single character is the actual character width and how much is the
    ///per-string extra width. The actual width is the extent minus the overhang.
    int    tmOverhang;
    ///The horizontal aspect of the device for which the font was designed.
    int    tmDigitizedAspectX;
    ///The vertical aspect of the device for which the font was designed. The ratio of the <b>tmDigitizedAspectX</b> and
    ///<b>tmDigitizedAspectY</b> members is the aspect ratio of the device for which the font was designed.
    int    tmDigitizedAspectY;
    ///The value of the first character defined in the font.
    ushort tmFirstChar;
    ///The value of the last character defined in the font.
    ushort tmLastChar;
    ///The value of the character to be substituted for characters not in the font.
    ushort tmDefaultChar;
    ///The value of the character that will be used to define word breaks for text justification.
    ushort tmBreakChar;
    ///Specifies an italic font if it is nonzero.
    ubyte  tmItalic;
    ///Specifies an underlined font if it is nonzero.
    ubyte  tmUnderlined;
    ///A strikeout font if it is nonzero.
    ubyte  tmStruckOut;
    ///Specifies information about the pitch, the technology, and the family of a physical font. The four low-order bits
    ///of this member specify information about the pitch and the technology of the font. A constant is defined for each
    ///of the four bits. <table> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td>TMPF_FIXED_PITCH</td> <td>If
    ///this bit is set the font is a variable pitch font. If this bit is clear the font is a fixed pitch font. Note very
    ///carefully that those meanings are the opposite of what the constant name implies.</td> </tr> <tr>
    ///<td>TMPF_VECTOR</td> <td>If this bit is set the font is a vector font.</td> </tr> <tr> <td>TMPF_TRUETYPE</td>
    ///<td>If this bit is set the font is a TrueType font.</td> </tr> <tr> <td>TMPF_DEVICE</td> <td>If this bit is set
    ///the font is a device font.</td> </tr> </table> An application should carefully test for qualities encoded in
    ///these low-order bits, making no arbitrary assumptions. For example, besides having their own bits set, TrueType
    ///and PostScript fonts set the TMPF_VECTOR bit. A monospace bitmap font has all of these low-order bits clear; a
    ///proportional bitmap font sets the TMPF_FIXED_PITCH bit. A Postscript printer device font sets the TMPF_DEVICE,
    ///TMPF_VECTOR, and TMPF_FIXED_PITCH bits. The four high-order bits of <b>tmPitchAndFamily</b> designate the font's
    ///font family. An application can use the value 0xF0 and the bitwise AND operator to mask out the four low-order
    ///bits of <b>tmPitchAndFamily</b>, thus obtaining a value that can be directly compared with font family names to
    ///find an identical match. For information about font families, see the description of the LOGFONT structure.
    ubyte  tmPitchAndFamily;
    ///The character set of the font. The character set can be one of the following values. <ul> <li>ANSI_CHARSET</li>
    ///<li>BALTIC_CHARSET</li> <li>CHINESEBIG5_CHARSET</li> <li>DEFAULT_CHARSET</li> <li>EASTEUROPE_CHARSET</li>
    ///<li>GB2312_CHARSET</li> <li>GREEK_CHARSET</li> <li>HANGUL_CHARSET</li> <li>MAC_CHARSET</li> <li>OEM_CHARSET</li>
    ///<li>RUSSIAN_CHARSET</li> <li>SHIFTJIS_CHARSET</li> <li>SYMBOL_CHARSET</li> <li>TURKISH_CHARSET</li>
    ///<li>VIETNAMESE_CHARSET</li> </ul> <b>Korean language edition of Windows:</b> <ul> <li> JOHAB_CHARSET </li> </ul>
    ///<b>Middle East language edition of Windows:</b> <ul> <li> ARABIC_CHARSET </li> <li> HEBREW_CHARSET </li> </ul>
    ///<b>Thai language edition of Windows:</b> <ul> <li> THAI_CHARSET </li> </ul>
    ubyte  tmCharSet;
}

///The <b>NEWTEXTMETRIC</b> structure contains data that describes a physical font.
struct NEWTEXTMETRICA
{
    ///The height (ascent + descent) of characters.
    int   tmHeight;
    ///The ascent (units above the base line) of characters.
    int   tmAscent;
    ///The descent (units below the base line) of characters.
    int   tmDescent;
    ///The amount of leading (space) inside the bounds set by the <b>tmHeight</b> member. Accent marks and other
    ///diacritical characters may occur in this area. The designer may set this member to zero.
    int   tmInternalLeading;
    ///The amount of extra leading (space) that the application adds between rows. Since this area is outside the font,
    ///it contains no marks and is not altered by text output calls in either OPAQUE or TRANSPARENT mode. The designer
    ///may set this member to zero.
    int   tmExternalLeading;
    ///The average width of characters in the font (generally defined as the width of the letter x). This value does not
    ///include overhang required for bold or italic characters.
    int   tmAveCharWidth;
    ///The width of the widest character in the font.
    int   tmMaxCharWidth;
    ///The weight of the font.
    int   tmWeight;
    ///The extra width per string that may be added to some synthesized fonts. When synthesizing some attributes, such
    ///as bold or italic, graphics device interface (GDI) or a device may have to add width to a string on both a
    ///per-character and per-string basis. For example, GDI makes a string bold by expanding the spacing of each
    ///character and overstriking by an offset value; it italicizes a font by shearing the string. In either case, there
    ///is an overhang past the basic string. For bold strings, the overhang is the distance by which the overstrike is
    ///offset. For italic strings, the overhang is the amount the top of the font is sheared past the bottom of the
    ///font. The <b>tmOverhang</b> member enables the application to determine how much of the character width returned
    ///by a GetTextExtentPoint32 function call on a single character is the actual character width and how much is the
    ///per-string extra width. The actual width is the extent minus the overhang.
    int   tmOverhang;
    ///The horizontal aspect of the device for which the font was designed.
    int   tmDigitizedAspectX;
    ///The vertical aspect of the device for which the font was designed. The ratio of the <b>tmDigitizedAspectX</b> and
    ///<b>tmDigitizedAspectY</b> members is the aspect ratio of the device for which the font was designed.
    int   tmDigitizedAspectY;
    ///The value of the first character defined in the font.
    ubyte tmFirstChar;
    ///The value of the last character defined in the font.
    ubyte tmLastChar;
    ///The value of the character to be substituted for characters that are not in the font.
    ubyte tmDefaultChar;
    ///The value of the character to be used to define word breaks for text justification.
    ubyte tmBreakChar;
    ///An italic font if it is nonzero.
    ubyte tmItalic;
    ///An underlined font if it is nonzero.
    ubyte tmUnderlined;
    ///A strikeout font if it is nonzero.
    ubyte tmStruckOut;
    ///The pitch and family of the selected font. The low-order bit (bit 0) specifies the pitch of the font. If it is 1,
    ///the font is variable pitch (or proportional). If it is 0, the font is fixed pitch (or monospace). Bits 1 and 2
    ///specify the font type. If both bits are 0, the font is a raster font; if bit 1 is 1 and bit 2 is 0, the font is a
    ///vector font; if bit 1 is 0 and bit 2 is set, or if both bits are 1, the font is some other type. Bit 3 is 1 if
    ///the font is a device font; otherwise, it is 0. The four high-order bits designate the font family. The
    ///<b>tmPitchAndFamily</b> member can be combined with the hexadecimal value 0xF0 by using the bitwise AND operator
    ///and can then be compared with the font family names for an identical match. For more information about the font
    ///families, see LOGFONT.
    ubyte tmPitchAndFamily;
    ///The character set of the font.
    ubyte tmCharSet;
    ///Specifies whether the font is italic, underscored, outlined, bold, and so forth. May be any reasonable
    ///combination of the following values. <table> <tr> <th>Bit</th> <th>Name</th> <th>Meaning</th> </tr> <tr>
    ///<td>0</td> <td>NTM_ITALIC</td> <td>italic</td> </tr> <tr> <td>5</td> <td>NTM_BOLD</td> <td>bold</td> </tr> <tr>
    ///<td>8</td> <td>NTM_REGULAR</td> <td>regular</td> </tr> <tr> <td>16</td> <td>NTM_NONNEGATIVE_AC</td> <td> no glyph
    ///in a font at any size has a negative A or C space.</td> </tr> <tr> <td>17</td> <td>NTM_PS_OPENTYPE</td> <td>
    ///PostScript OpenType font</td> </tr> <tr> <td>18</td> <td>NTM_TT_OPENTYPE</td> <td> TrueType OpenType font</td>
    ///</tr> <tr> <td>19</td> <td>NTM_MULTIPLEMASTER</td> <td> multiple master font</td> </tr> <tr> <td>20</td>
    ///<td>NTM_TYPE1</td> <td> Type 1 font</td> </tr> <tr> <td>21</td> <td>NTM_DSIG</td> <td> font with a digital
    ///signature. This allows traceability and ensures that the font has been tested and is not corrupted</td> </tr>
    ///</table>
    uint  ntmFlags;
    ///The size of the em square for the font. This value is in notional units (that is, the units for which the font
    ///was designed).
    uint  ntmSizeEM;
    ///The height, in notional units, of the font. This value should be compared with the value of the <b>ntmSizeEM</b>
    ///member.
    uint  ntmCellHeight;
    ///The average width of characters in the font, in notional units. This value should be compared with the value of
    ///the <b>ntmSizeEM</b> member.
    uint  ntmAvgWidth;
}

///The <b>NEWTEXTMETRIC</b> structure contains data that describes a physical font.
struct NEWTEXTMETRICW
{
    ///The height (ascent + descent) of characters.
    int    tmHeight;
    ///The ascent (units above the base line) of characters.
    int    tmAscent;
    ///The descent (units below the base line) of characters.
    int    tmDescent;
    ///The amount of leading (space) inside the bounds set by the <b>tmHeight</b> member. Accent marks and other
    ///diacritical characters may occur in this area. The designer may set this member to zero.
    int    tmInternalLeading;
    ///The amount of extra leading (space) that the application adds between rows. Since this area is outside the font,
    ///it contains no marks and is not altered by text output calls in either OPAQUE or TRANSPARENT mode. The designer
    ///may set this member to zero.
    int    tmExternalLeading;
    ///The average width of characters in the font (generally defined as the width of the letter x). This value does not
    ///include overhang required for bold or italic characters.
    int    tmAveCharWidth;
    ///The width of the widest character in the font.
    int    tmMaxCharWidth;
    ///The weight of the font.
    int    tmWeight;
    ///The extra width per string that may be added to some synthesized fonts. When synthesizing some attributes, such
    ///as bold or italic, graphics device interface (GDI) or a device may have to add width to a string on both a
    ///per-character and per-string basis. For example, GDI makes a string bold by expanding the spacing of each
    ///character and overstriking by an offset value; it italicizes a font by shearing the string. In either case, there
    ///is an overhang past the basic string. For bold strings, the overhang is the distance by which the overstrike is
    ///offset. For italic strings, the overhang is the amount the top of the font is sheared past the bottom of the
    ///font. The <b>tmOverhang</b> member enables the application to determine how much of the character width returned
    ///by a GetTextExtentPoint32 function call on a single character is the actual character width and how much is the
    ///per-string extra width. The actual width is the extent minus the overhang.
    int    tmOverhang;
    ///The horizontal aspect of the device for which the font was designed.
    int    tmDigitizedAspectX;
    ///The vertical aspect of the device for which the font was designed. The ratio of the <b>tmDigitizedAspectX</b> and
    ///<b>tmDigitizedAspectY</b> members is the aspect ratio of the device for which the font was designed.
    int    tmDigitizedAspectY;
    ///The value of the first character defined in the font.
    ushort tmFirstChar;
    ///The value of the last character defined in the font.
    ushort tmLastChar;
    ///The value of the character to be substituted for characters that are not in the font.
    ushort tmDefaultChar;
    ///The value of the character to be used to define word breaks for text justification.
    ushort tmBreakChar;
    ///An italic font if it is nonzero.
    ubyte  tmItalic;
    ///An underlined font if it is nonzero.
    ubyte  tmUnderlined;
    ///A strikeout font if it is nonzero.
    ubyte  tmStruckOut;
    ///The pitch and family of the selected font. The low-order bit (bit 0) specifies the pitch of the font. If it is 1,
    ///the font is variable pitch (or proportional). If it is 0, the font is fixed pitch (or monospace). Bits 1 and 2
    ///specify the font type. If both bits are 0, the font is a raster font; if bit 1 is 1 and bit 2 is 0, the font is a
    ///vector font; if bit 1 is 0 and bit 2 is set, or if both bits are 1, the font is some other type. Bit 3 is 1 if
    ///the font is a device font; otherwise, it is 0. The four high-order bits designate the font family. The
    ///<b>tmPitchAndFamily</b> member can be combined with the hexadecimal value 0xF0 by using the bitwise AND operator
    ///and can then be compared with the font family names for an identical match. For more information about the font
    ///families, see LOGFONT.
    ubyte  tmPitchAndFamily;
    ///The character set of the font.
    ubyte  tmCharSet;
    ///Specifies whether the font is italic, underscored, outlined, bold, and so forth. May be any reasonable
    ///combination of the following values. <table> <tr> <th>Bit</th> <th>Name</th> <th>Meaning</th> </tr> <tr>
    ///<td>0</td> <td>NTM_ITALIC</td> <td>italic</td> </tr> <tr> <td>5</td> <td>NTM_BOLD</td> <td>bold</td> </tr> <tr>
    ///<td>8</td> <td>NTM_REGULAR</td> <td>regular</td> </tr> <tr> <td>16</td> <td>NTM_NONNEGATIVE_AC</td> <td> no glyph
    ///in a font at any size has a negative A or C space.</td> </tr> <tr> <td>17</td> <td>NTM_PS_OPENTYPE</td> <td>
    ///PostScript OpenType font</td> </tr> <tr> <td>18</td> <td>NTM_TT_OPENTYPE</td> <td> TrueType OpenType font</td>
    ///</tr> <tr> <td>19</td> <td>NTM_MULTIPLEMASTER</td> <td> multiple master font</td> </tr> <tr> <td>20</td>
    ///<td>NTM_TYPE1</td> <td> Type 1 font</td> </tr> <tr> <td>21</td> <td>NTM_DSIG</td> <td> font with a digital
    ///signature. This allows traceability and ensures that the font has been tested and is not corrupted</td> </tr>
    ///</table>
    uint   ntmFlags;
    ///The size of the em square for the font. This value is in notional units (that is, the units for which the font
    ///was designed).
    uint   ntmSizeEM;
    ///The height, in notional units, of the font. This value should be compared with the value of the <b>ntmSizeEM</b>
    ///member.
    uint   ntmCellHeight;
    ///The average width of characters in the font, in notional units. This value should be compared with the value of
    ///the <b>ntmSizeEM</b> member.
    uint   ntmAvgWidth;
}

///The <b>NEWTEXTMETRICEX</b> structure contains information about a physical font.
struct NEWTEXTMETRICEXA
{
    ///A NEWTEXTMETRIC structure.
    NEWTEXTMETRICA ntmTm;
    ///A FONTSIGNATURE structure indicating the coverage of the font.
    FONTSIGNATURE  ntmFontSig;
}

///The <b>NEWTEXTMETRICEX</b> structure contains information about a physical font.
struct NEWTEXTMETRICEXW
{
    ///A NEWTEXTMETRIC structure.
    NEWTEXTMETRICW ntmTm;
    ///A FONTSIGNATURE structure indicating the coverage of the font.
    FONTSIGNATURE  ntmFontSig;
}

struct PELARRAY
{
    int   paXCount;
    int   paYCount;
    int   paXExt;
    int   paYExt;
    ubyte paRGBs;
}

///The <b>LOGBRUSH</b> structure defines the style, color, and pattern of a physical brush. It is used by the
///CreateBrushIndirect and ExtCreatePen functions.
struct LOGBRUSH
{
    ///The brush style. The <b>lbStyle</b> member must be one of the following styles. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>BS_DIBPATTERN</td> <td>A pattern brush defined by a device-independent bitmap
    ///(DIB) specification. If <b>lbStyle</b> is BS_DIBPATTERN, the <b>lbHatch</b> member contains a handle to a packed
    ///DIB. For more information, see discussion in <b>lbHatch</b>.</td> </tr> <tr> <td>BS_DIBPATTERN8X8</td> <td>See
    ///BS_DIBPATTERN.</td> </tr> <tr> <td>BS_DIBPATTERNPT</td> <td>A pattern brush defined by a device-independent
    ///bitmap (DIB) specification. If <b>lbStyle</b> is BS_DIBPATTERNPT, the <b>lbHatch</b> member contains a pointer to
    ///a packed DIB. For more information, see discussion in <b>lbHatch</b>.</td> </tr> <tr> <td>BS_HATCHED</td>
    ///<td>Hatched brush.</td> </tr> <tr> <td>BS_HOLLOW</td> <td>Hollow brush.</td> </tr> <tr> <td>BS_NULL</td> <td>Same
    ///as BS_HOLLOW.</td> </tr> <tr> <td>BS_PATTERN</td> <td>Pattern brush defined by a memory bitmap.</td> </tr> <tr>
    ///<td>BS_PATTERN8X8</td> <td>See BS_PATTERN.</td> </tr> <tr> <td>BS_SOLID</td> <td>Solid brush.</td> </tr> </table>
    uint   lbStyle;
    ///The color in which the brush is to be drawn. If <b>lbStyle</b> is the BS_HOLLOW or BS_PATTERN style,
    ///<b>lbColor</b> is ignored. If <b>lbStyle</b> is BS_DIBPATTERN or BS_DIBPATTERNPT, the low-order word of
    ///<b>lbColor</b> specifies whether the <b>bmiColors</b> members of the BITMAPINFO structure contain explicit red,
    ///green, blue (RGB) values or indexes into the currently realized logical palette. The <b>lbColor</b> member must
    ///be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DIB_PAL_COLORS</td>
    ///<td>The color table consists of an array of 16-bit indexes into the currently realized logical palette.</td>
    ///</tr> <tr> <td>DIB_RGB_COLORS</td> <td>The color table contains literal RGB values.</td> </tr> </table> If
    ///<b>lbStyle</b> is BS_HATCHED or BS_SOLID, <b>lbColor</b> is a COLORREF color value. To create a <b>COLORREF</b>
    ///color value, use the RGB macro.
    uint   lbColor;
    ///A hatch style. The meaning depends on the brush style defined by <b>lbStyle</b>. If <b>lbStyle</b> is
    ///BS_DIBPATTERN, the <b>lbHatch</b> member contains a handle to a packed DIB. To obtain this handle, an application
    ///calls the GlobalAlloc function with GMEM_MOVEABLE (or LocalAlloc with LMEM_MOVEABLE) to allocate a block of
    ///memory and then fills the memory with the packed DIB. A packed DIB consists of a BITMAPINFO structure immediately
    ///followed by the array of bytes that define the pixels of the bitmap. If <b>lbStyle</b> is BS_DIBPATTERNPT, the
    ///<b>lbHatch</b> member contains a pointer to a packed DIB. The pointer derives from the memory block created by
    ///LocalAlloc with LMEM_FIXED set or by GlobalAlloc with GMEM_FIXED set, or it is the pointer returned by a call
    ///like LocalLock (handle_to_the_dib). A packed DIB consists of a BITMAPINFO structure immediately followed by the
    ///array of bytes that define the pixels of the bitmap. If <b>lbStyle</b> is BS_HATCHED, the <b>lbHatch</b> member
    ///specifies the orientation of the lines used to create the hatch. It can be one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>HS_BDIAGONAL</td> <td>A 45-degree upward, left-to-right
    ///hatch</td> </tr> <tr> <td>HS_CROSS</td> <td>Horizontal and vertical cross-hatch</td> </tr> <tr>
    ///<td>HS_DIAGCROSS</td> <td>45-degree crosshatch</td> </tr> <tr> <td>HS_FDIAGONAL</td> <td>A 45-degree downward,
    ///left-to-right hatch</td> </tr> <tr> <td>HS_HORIZONTAL</td> <td>Horizontal hatch</td> </tr> <tr>
    ///<td>HS_VERTICAL</td> <td>Vertical hatch</td> </tr> </table> If <b>lbStyle</b> is BS_PATTERN, <b>lbHatch</b> is a
    ///handle to the bitmap that defines the pattern. The bitmap cannot be a DIB section bitmap, which is created by the
    ///CreateDIBSection function. If <b>lbStyle</b> is BS_SOLID or BS_HOLLOW, <b>lbHatch</b> is ignored.
    size_t lbHatch;
}

///The <b>LOGBRUSH32</b> structure defines the style, color, and pattern of a physical brush. It is similar to LOGBRUSH,
///but it is used to maintain compatibility between 32-bit platforms and 64-bit platforms when we record the metafile
///record on one platform and then play it on another. Thus, it is only used in EMRCREATEBRUSHINDIRECT. If the code will
///only be on one platform, <b>LOGBRUSH</b> is sufficient.
struct LOGBRUSH32
{
    ///The brush style. The <b>lbStyle</b> member must be one of the following styles. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>BS_DIBPATTERN</td> <td>A pattern brush defined by a device-independent bitmap
    ///(DIB) specification. If <b>lbStyle</b> is BS_DIBPATTERN, the <b>lbHatch</b> member contains a handle to a packed
    ///DIB. For more information, see discussion in <b>lbHatch</b>.</td> </tr> <tr> <td>BS_DIBPATTERN8X8</td> <td>Same
    ///as BS_DIBPATTERN.</td> </tr> <tr> <td>BS_DIBPATTERNPT</td> <td>A pattern brush defined by a device-independent
    ///bitmap (DIB) specification. If <b>lbStyle</b> is BS_DIBPATTERNPT, the <b>lbHatch</b> member contains a pointer to
    ///a packed DIB. For more information, see discussion in <b>lbHatch</b>.</td> </tr> <tr> <td>BS_HATCHED</td>
    ///<td>Hatched brush.</td> </tr> <tr> <td>BS_HOLLOW</td> <td>Hollow brush.</td> </tr> <tr> <td>BS_NULL</td> <td>Same
    ///as BS_HOLLOW.</td> </tr> <tr> <td>BS_PATTERN</td> <td>Pattern brush defined by a memory bitmap.</td> </tr> <tr>
    ///<td>BS_PATTERN8X8</td> <td>Same as BS_PATTERN.</td> </tr> <tr> <td>BS_SOLID</td> <td>Solid brush.</td> </tr>
    ///</table>
    uint lbStyle;
    ///The color in which the brush is to be drawn. If <b>lbStyle</b> is the BS_HOLLOW or BS_PATTERN style,
    ///<b>lbColor</b> is ignored. If <b>lbStyle</b> is BS_DIBPATTERN or BS_DIBPATTERNPT, the low-order word of
    ///<b>lbColor</b> specifies whether the <b>bmiColors</b> members of the BITMAPINFO structure contain explicit red,
    ///green, blue (RGB) values or indexes into the currently realized logical palette. The <b>lbColor</b> member must
    ///be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DIB_PAL_COLORS</td>
    ///<td>The color table consists of an array of 16-bit indexes into the currently realized logical palette.</td>
    ///</tr> <tr> <td>DIB_RGB_COLORS</td> <td>The color table contains literal RGB values.</td> </tr> </table> If
    ///<b>lbStyle</b> is BS_HATCHED or BS_SOLID, <b>lbColor</b> is a COLORREF color value. To create a <b>COLORREF</b>
    ///color value, use the RGB macro.
    uint lbColor;
    ///A hatch style. The meaning depends on the brush style defined by <b>lbStyle</b>. If <b>lbStyle</b> is
    ///BS_DIBPATTERN, the <b>lbHatch</b> member contains a handle to a packed DIB. To obtain this handle, an application
    ///calls the GlobalAlloc function with GMEM_MOVEABLE (or LocalAlloc with LMEM_MOVEABLE) to allocate a block of
    ///memory and then fills the memory with the packed DIB. A packed DIB consists of a BITMAPINFO structure immediately
    ///followed by the array of bytes that define the pixels of the bitmap. If <b>lbStyle</b> is BS_DIBPATTERNPT, the
    ///<b>lbHatch</b> member contains a pointer to a packed DIB. The pointer derives from the memory block created by
    ///LocalAlloc with LMEM_FIXED set or by GlobalAlloc with GMEM_FIXED set, or it is the pointer returned by a call
    ///like LocalLock (handle_to_the_dib). A packed DIB consists of a BITMAPINFO structure immediately followed by the
    ///array of bytes that define the pixels of the bitmap. If <b>lbStyle</b> is BS_HATCHED, the <b>lbHatch</b> member
    ///specifies the orientation of the lines used to create the hatch. It can be one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>HS_BDIAGONAL</td> <td>A 45-degree upward, left-to-right
    ///hatch</td> </tr> <tr> <td>HS_CROSS</td> <td>Horizontal and vertical cross-hatch</td> </tr> <tr>
    ///<td>HS_DIAGCROSS</td> <td>45-degree crosshatch</td> </tr> <tr> <td>HS_FDIAGONAL</td> <td>A 45-degree downward,
    ///left-to-right hatch</td> </tr> <tr> <td>HS_HORIZONTAL</td> <td>Horizontal hatch</td> </tr> <tr>
    ///<td>HS_VERTICAL</td> <td>Vertical hatch</td> </tr> </table> If <b>lbStyle</b> is BS_PATTERN, <b>lbHatch</b> is a
    ///handle to the bitmap that defines the pattern. The bitmap cannot be a DIB section bitmap, which is created by the
    ///CreateDIBSection function. If <b>lbStyle</b> is BS_SOLID or BS_HOLLOW, <b>lbHatch</b> is ignored.
    uint lbHatch;
}

///The <b>LOGPEN</b> structure defines the style, width, and color of a pen. The CreatePenIndirect function uses the
///<b>LOGPEN</b> structure.
struct LOGPEN
{
    ///The pen style, which can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PS_SOLID</td> <td>The pen is solid.</td> </tr> <tr> <td>PS_DASH</td> <td>The pen is dashed.</td> </tr> <tr>
    ///<td>PS_DOT</td> <td>The pen is dotted.</td> </tr> <tr> <td>PS_DASHDOT</td> <td>The pen has alternating dashes and
    ///dots.</td> </tr> <tr> <td>PS_DASHDOTDOT</td> <td>The pen has dashes and double dots.</td> </tr> <tr>
    ///<td>PS_NULL</td> <td>The pen is invisible.</td> </tr> <tr> <td>PS_INSIDEFRAME</td> <td>The pen is solid. When
    ///this pen is used in any GDI drawing function that takes a bounding rectangle, the dimensions of the figure are
    ///shrunk so that it fits entirely in the bounding rectangle, taking into account the width of the pen. This applies
    ///only to geometric pens.</td> </tr> </table>
    uint  lopnStyle;
    ///The POINT structure that contains the pen width, in logical units. If the <b>pointer</b> member is <b>NULL</b>,
    ///the pen is one pixel wide on raster devices. The <b>y</b> member in the <b>POINT</b> structure for
    ///<b>lopnWidth</b> is not used.
    POINT lopnWidth;
    ///The pen color. To generate a COLORREF structure, use the RGB macro.
    uint  lopnColor;
}

///The <b>EXTLOGPEN</b> structure defines the pen style, width, and brush attributes for an extended pen. This structure
///is used by the GetObject function when it retrieves a description of a pen that was created when an application
///called the ExtCreatePen function.
struct EXTLOGPEN
{
    ///A combination of pen type, style, end cap style, and join style. The values from each category can be retrieved
    ///by using a bitwise AND operator with the appropriate mask. The <b>elpPenStyle</b> member masked with PS_TYPE_MASK
    ///has one of the following pen type values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PS_GEOMETRIC</td> <td>The pen is geometric.</td> </tr> <tr> <td>PS_COSMETIC</td> <td>The pen is
    ///cosmetic.</td> </tr> </table> The <b>elpPenStyle</b> member masked with PS_STYLE_MASK has one of the following
    ///pen styles values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>PS_DASH</td> <td>The pen is
    ///dashed.</td> </tr> <tr> <td>PS_DASHDOT</td> <td>The pen has alternating dashes and dots.</td> </tr> <tr>
    ///<td>PS_DASHDOTDOT</td> <td>The pen has alternating dashes and double dots.</td> </tr> <tr> <td>PS_DOT</td>
    ///<td>The pen is dotted.</td> </tr> <tr> <td>PS_INSIDEFRAME</td> <td>The pen is solid. When this pen is used in any
    ///GDI drawing function that takes a bounding rectangle, the dimensions of the figure are shrunk so that it fits
    ///entirely in the bounding rectangle, taking into account the width of the pen. This applies only to PS_GEOMETRIC
    ///pens.</td> </tr> <tr> <td>PS_NULL</td> <td>The pen is invisible.</td> </tr> <tr> <td>PS_SOLID</td> <td>The pen is
    ///solid.</td> </tr> <tr> <td>PS_USERSTYLE</td> <td>The pen uses a styling array supplied by the user.</td> </tr>
    ///</table> The following category applies only to PS_GEOMETRIC pens. The <b>elpPenStyle</b> member masked with
    ///PS_ENDCAP_MASK has one of the following end cap values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PS_ENDCAP_FLAT</td> <td>Line end caps are flat.</td> </tr> <tr> <td>PS_ENDCAP_ROUND</td> <td>Line end caps
    ///are round.</td> </tr> <tr> <td>PS_ENDCAP_SQUARE</td> <td>Line end caps are square.</td> </tr> </table> The
    ///following category applies only to PS_GEOMETRIC pens. The <b>elpPenStyle</b> member masked with PS_JOIN_MASK has
    ///one of the following join values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>PS_JOIN_BEVEL</td>
    ///<td>Line joins are beveled.</td> </tr> <tr> <td>PS_JOIN_MITER</td> <td>Line joins are mitered when they are
    ///within the current limit set by the SetMiterLimit function. A join is beveled when it would exceed the
    ///limit.</td> </tr> <tr> <td>PS_JOIN_ROUND</td> <td>Line joins are round.</td> </tr> </table>
    uint    elpPenStyle;
    ///The width of the pen. If the <b>elpPenStyle</b> member is PS_GEOMETRIC, this value is the width of the line in
    ///logical units. Otherwise, the lines are cosmetic and this value is 1, which indicates a line with a width of one
    ///pixel.
    uint    elpWidth;
    ///The brush style of the pen. The <b>elpBrushStyle</b> member value can be one of the following. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td>BS_DIBPATTERN</td> <td>Specifies a pattern brush defined by a DIB
    ///specification. If <b>elpBrushStyle</b> is BS_DIBPATTERN, the <b>elpHatch</b> member contains a handle to a packed
    ///DIB. For more information, see discussion in <b>elpHatch</b></td> </tr> <tr> <td>BS_DIBPATTERNPT</td>
    ///<td>Specifies a pattern brush defined by a DIB specification. If <b>elpBrushStyle</b> is BS_DIBPATTERNPT, the
    ///<b>elpHatch</b> member contains a pointer to a packed DIB. For more information, see discussion in
    ///<b>elpHatch</b>.</td> </tr> <tr> <td>BS_HATCHED</td> <td>Specifies a hatched brush.</td> </tr> <tr>
    ///<td>BS_HOLLOW</td> <td>Specifies a hollow or <b>NULL</b> brush.</td> </tr> <tr> <td>BS_PATTERN</td> <td>Specifies
    ///a pattern brush defined by a memory bitmap.</td> </tr> <tr> <td>BS_SOLID</td> <td>Specifies a solid brush.</td>
    ///</tr> </table>
    uint    elpBrushStyle;
    ///If <b>elpBrushStyle</b> is BS_SOLID or BS_HATCHED, <b>elpColor</b> specifies the color in which the pen is to be
    ///drawn. For BS_HATCHED, the SetBkMode and SetBkColor functions determine the background color. If
    ///<b>elpBrushStyle</b> is BS_HOLLOW or BS_PATTERN, <b>elpColor</b> is ignored. If <b>elpBrushStyle</b> is
    ///BS_DIBPATTERN or BS_DIBPATTERNPT, the low-order word of <b>elpColor</b> specifies whether the <b>bmiColors</b>
    ///member of the BITMAPINFO structure contain explicit RGB values or indices into the currently realized logical
    ///palette. The <b>elpColor</b> value must be one of the following. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>DIB_PAL_COLORS</td> <td>The color table consists of an array of 16-bit indices into the currently
    ///realized logical palette.</td> </tr> <tr> <td>DIB_RGB_COLORS</td> <td>The color table contains literal RGB
    ///values.</td> </tr> </table> The RGB macro is used to generate a COLORREF structure.
    uint    elpColor;
    ///If <b>elpBrushStyle</b> is BS_PATTERN, <b>elpHatch</b> is a handle to the bitmap that defines the pattern. If
    ///<b>elpBrushStyle</b> is BS_SOLID or BS_HOLLOW, <b>elpHatch</b> is ignored. If <b>elpBrushStyle</b> is
    ///BS_DIBPATTERN, the <b>elpHatch</b> member is a handle to a packed DIB. To obtain this handle, an application
    ///calls the GlobalAlloc function with GMEM_MOVEABLE (or LocalAlloc with LMEM_MOVEABLE) to allocate a block of
    ///memory and then fills the memory with the packed DIB. A packed DIB consists of a BITMAPINFO structure immediately
    ///followed by the array of bytes that define the pixels of the bitmap. If <b>elpBrushStyle</b> is BS_DIBPATTERNPT,
    ///the <b>elpHatch</b> member is a pointer to a packed DIB. The pointer derives from the memory block created by
    ///LocalAlloc with LMEM_FIXED set or by GlobalAlloc with GMEM_FIXED set, or it is the pointer returned by a call
    ///like LocalLock (handle_to_the_dib). A packed DIB consists of a BITMAPINFO structure immediately followed by the
    ///array of bytes that define the pixels of the bitmap. If <b>elpBrushStyle</b> is BS_HATCHED, the <b>elpHatch</b>
    ///member specifies the orientation of the lines used to create the hatch. It can be one of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>HS_BDIAGONAL</td> <td>45-degree upward hatch (left to
    ///right)</td> </tr> <tr> <td>HS_CROSS</td> <td>Horizontal and vertical crosshatch</td> </tr> <tr>
    ///<td>HS_DIAGCROSS</td> <td>45-degree crosshatch</td> </tr> <tr> <td>HS_FDIAGONAL</td> <td>45-degree downward hatch
    ///(left to right)</td> </tr> <tr> <td>HS_HORIZONTAL</td> <td>Horizontal hatch</td> </tr> <tr> <td>HS_VERTICAL</td>
    ///<td>Vertical hatch</td> </tr> </table>
    size_t  elpHatch;
    ///The number of entries in the style array in the <b>elpStyleEntry</b> member. This value is zero if
    ///<b>elpPenStyle</b> does not specify PS_USERSTYLE.
    uint    elpNumEntries;
    ///A user-supplied style array. The array is specified with a finite length, but it is used as if it repeated
    ///indefinitely. The first entry in the array specifies the length of the first dash. The second entry specifies the
    ///length of the first gap. Thereafter, lengths of dashes and gaps alternate. If <b>elpWidth</b> specifies geometric
    ///lines, the lengths are in logical units. Otherwise, the lines are cosmetic and lengths are in device units.
    uint[1] elpStyleEntry;
}

struct EXTLOGPEN32
{
    uint    elpPenStyle;
    uint    elpWidth;
    uint    elpBrushStyle;
    uint    elpColor;
    uint    elpHatch;
    uint    elpNumEntries;
    uint[1] elpStyleEntry;
}

///The <b>LOGPALETTE</b> structure defines a logical palette.
struct LOGPALETTE
{
    ///The version number of the system.
    ushort          palVersion;
    ///The number of entries in the logical palette.
    ushort          palNumEntries;
    ///Specifies an array of PALETTEENTRY structures that define the color and usage of each entry in the logical
    ///palette.
    PALETTEENTRY[1] palPalEntry;
}

///The <b>ENUMLOGFONT</b> structure defines the attributes of a font, the complete name of a font, and the style of a
///font.
struct ENUMLOGFONTA
{
    ///A LOGFONT structure that defines the attributes of a font.
    LOGFONTA  elfLogFont;
    ///A unique name for the font. For example, ABCD Font Company TrueType Bold Italic Sans Serif.
    ubyte[64] elfFullName;
    ///The style of the font. For example, Bold Italic.
    ubyte[32] elfStyle;
}

///The <b>ENUMLOGFONT</b> structure defines the attributes of a font, the complete name of a font, and the style of a
///font.
struct ENUMLOGFONTW
{
    ///A LOGFONT structure that defines the attributes of a font.
    LOGFONTW   elfLogFont;
    ///A unique name for the font. For example, ABCD Font Company TrueType Bold Italic Sans Serif.
    ushort[64] elfFullName;
    ///The style of the font. For example, Bold Italic.
    ushort[32] elfStyle;
}

///The <b>ENUMLOGFONTEX</b> structure contains information about an enumerated font.
struct ENUMLOGFONTEXA
{
    ///A LOGFONT structure that contains values defining the font attributes.
    LOGFONTA  elfLogFont;
    ///The unique name of the font. For example, ABC Font Company TrueType Bold Italic Sans Serif.
    ubyte[64] elfFullName;
    ///The style of the font. For example, Bold Italic.
    ubyte[32] elfStyle;
    ///The script, that is, the character set, of the font. For example, Cyrillic.
    ubyte[32] elfScript;
}

///The <b>ENUMLOGFONTEX</b> structure contains information about an enumerated font.
struct ENUMLOGFONTEXW
{
    ///A LOGFONT structure that contains values defining the font attributes.
    LOGFONTW   elfLogFont;
    ///The unique name of the font. For example, ABC Font Company TrueType Bold Italic Sans Serif.
    ushort[64] elfFullName;
    ///The style of the font. For example, Bold Italic.
    ushort[32] elfStyle;
    ///The script, that is, the character set, of the font. For example, Cyrillic.
    ushort[32] elfScript;
}

///The <b>PANOSE</b> structure describes the PANOSE font-classification values for a TrueType font. These
///characteristics are then used to associate the font with other fonts of similar appearance but different names.
struct PANOSE
{
    ///For Latin fonts, one of one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_FAMILY_TEXT_DISPLAY</td> <td>Text and display</td> </tr> <tr> <td>PAN_FAMILY_SCRIPT</td> <td>Script</td>
    ///</tr> <tr> <td>PAN_FAMILY_DECORATIVE</td> <td>Decorative</td> </tr> <tr> <td>PAN_FAMILY_PICTORIAL</td>
    ///<td>Pictorial</td> </tr> </table>
    ubyte bFamilyType;
    ///The serif style. For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_SERIF_COVE</td> <td>Cove</td> </tr> <tr> <td>PAN_SERIF_OBTUSE_COVE</td> <td>Obtuse cove</td> </tr> <tr>
    ///<td>PAN_SERIF_SQUARE_COVE</td> <td>Square cove</td> </tr> <tr> <td>PAN_SERIF_OBTUSE_SQUARE_COVE</td> <td>Obtuse
    ///square cove</td> </tr> <tr> <td>PAN_SERIF_SQUARE</td> <td>Square</td> </tr> <tr> <td>PAN_SERIF_THIN</td>
    ///<td>Thin</td> </tr> <tr> <td>PAN_SERIF_BONE</td> <td>Bone</td> </tr> <tr> <td>PAN_SERIF_EXAGGERATED</td>
    ///<td>Exaggerated</td> </tr> <tr> <td>PAN_SERIF_TRIANGLE</td> <td>Triangle</td> </tr> <tr>
    ///<td>PAN_SERIF_NORMAL_SANS</td> <td>Normal sans serif</td> </tr> <tr> <td>PAN_SERIF_OBTUSE_SANS</td> <td>Obtuse
    ///sans serif</td> </tr> <tr> <td>PAN_SERIF_PERP_SANS</td> <td>Perp sans serif</td> </tr> <tr>
    ///<td>PAN_SERIF_FLARED</td> <td>Flared</td> </tr> <tr> <td>PAN_SERIF_ROUNDED</td> <td>Rounded</td> </tr> </table>
    ubyte bSerifStyle;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_WEIGHT_VERY_LIGHT</td> <td>Very light</td> </tr> <tr> <td>PAN_WEIGHT_LIGHT</td> <td>Light</td> </tr> <tr>
    ///<td>PAN_WEIGHT_THIN</td> <td>Thin</td> </tr> <tr> <td>PAN_WEIGHT_BOOK</td> <td>Book</td> </tr> <tr>
    ///<td>PAN_WEIGHT_MEDIUM</td> <td>Medium</td> </tr> <tr> <td>PAN_WEIGHT_DEMI</td> <td>Demibold</td> </tr> <tr>
    ///<td>PAN_WEIGHT_BOLD</td> <td>Bold</td> </tr> <tr> <td>PAN_WEIGHT_HEAVY</td> <td>Heavy</td> </tr> <tr>
    ///<td>PAN_WEIGHT_BLACK</td> <td>Black</td> </tr> <tr> <td>PAN_WEIGHT_NORD</td> <td>Nord</td> </tr> </table>
    ubyte bWeight;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_PROP_OLD_STYLE</td> <td>Old style</td> </tr> <tr> <td>PAN_PROP_MODERN</td> <td>Modern</td> </tr> <tr>
    ///<td>PAN_PROP_EVEN_WIDTH</td> <td>Even width</td> </tr> <tr> <td>PAN_PROP_EXPANDED</td> <td>Expanded</td> </tr>
    ///<tr> <td>PAN_PROP_CONDENSED</td> <td>Condensed</td> </tr> <tr> <td>PAN_PROP_VERY_EXPANDED</td> <td>Very
    ///expanded</td> </tr> <tr> <td>PAN_PROP_VERY_CONDENSED</td> <td>Very condensed</td> </tr> <tr>
    ///<td>PAN_PROP_MONOSPACED</td> <td>Monospaced</td> </tr> </table>
    ubyte bProportion;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_CONTRAST_NONE</td> <td>None</td> </tr> <tr> <td>PAN_CONTRAST_VERY_LOW</td> <td>Very low</td> </tr> <tr>
    ///<td>PAN_CONTRAST_LOW</td> <td>Low</td> </tr> <tr> <td>PAN_CONTRAST_MEDIUM_LOW</td> <td>Medium low</td> </tr> <tr>
    ///<td>PAN_CONTRAST_MEDIUM</td> <td>Medium</td> </tr> <tr> <td>PAN_CONTRAST_MEDIUM_HIGH</td> <td>Medium high</td>
    ///</tr> <tr> <td>PAN_CONTRAST_HIGH</td> <td>High</td> </tr> <tr> <td>PAN_CONTRAST_VERY_HIGH</td> <td>Very high</td>
    ///</tr> </table>
    ubyte bContrast;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_STROKE_GRADUAL_DIAG</td> <td>Gradual/diagonal</td> </tr> <tr> <td>PAN_STROKE_GRADUAL_TRAN</td>
    ///<td>Gradual/transitional</td> </tr> <tr> <td>PAN_STROKE_GRADUAL_VERT</td> <td>Gradual/vertical</td> </tr> <tr>
    ///<td>PAN_STROKE_GRADUAL_HORZ</td> <td>Gradual/horizontal</td> </tr> <tr> <td>PAN_STROKE_RAPID_VERT</td>
    ///<td>Rapid/vertical</td> </tr> <tr> <td>PAN_STROKE_RAPID_HORZ</td> <td>Rapid/horizontal</td> </tr> <tr>
    ///<td>PAN_STROKE_INSTANT_VERT</td> <td>Instant/vertical</td> </tr> </table>
    ubyte bStrokeVariation;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_STRAIGHT_ARMS_HORZ</td> <td>Straight arms/horizontal</td> </tr> <tr> <td>PAN_STRAIGHT_ARMS_WEDGE</td>
    ///<td>Straight arms/wedge</td> </tr> <tr> <td>PAN_STRAIGHT_ARMS_VERT</td> <td>Straight arms/vertical</td> </tr>
    ///<tr> <td>PAN_STRAIGHT_ARMS_SINGLE_SERIF</td> <td>Straight arms/single-serif</td> </tr> <tr>
    ///<td>PAN_STRAIGHT_ARMS_DOUBLE_SERIF</td> <td>Straight arms/double-serif</td> </tr> <tr>
    ///<td>PAN_BENT_ARMS_HORZ</td> <td>Nonstraight arms/horizontal</td> </tr> <tr> <td>PAN_BENT_ARMS_WEDGE</td>
    ///<td>Nonstraight arms/wedge</td> </tr> <tr> <td>PAN_BENT_ARMS_VERT</td> <td>Nonstraight arms/vertical</td> </tr>
    ///<tr> <td>PAN_BENT_ARMS_SINGLE_SERIF</td> <td>Nonstraight arms/single-serif</td> </tr> <tr>
    ///<td>PAN_BENT_ARMS_DOUBLE_SERIF</td> <td>Nonstraight arms/double-serif</td> </tr> </table>
    ubyte bArmStyle;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_LETT_NORMAL_CONTACT</td> <td>Normal/contact</td> </tr> <tr> <td>PAN_LETT_NORMAL_WEIGHTED</td>
    ///<td>Normal/weighted</td> </tr> <tr> <td>PAN_LETT_NORMAL_BOXED</td> <td>Normal/boxed</td> </tr> <tr>
    ///<td>PAN_LETT_NORMAL_FLATTENED</td> <td>Normal/flattened</td> </tr> <tr> <td>PAN_LETT_NORMAL_ROUNDED</td>
    ///<td>Normal/rounded</td> </tr> <tr> <td>PAN_LETT_NORMAL_OFF_CENTER</td> <td>Normal/off center</td> </tr> <tr>
    ///<td>PAN_LETT_NORMAL_SQUARE</td> <td>Normal/square</td> </tr> <tr> <td>PAN_LETT_OBLIQUE_CONTACT</td>
    ///<td>Oblique/contact</td> </tr> <tr> <td>PAN_LETT_OBLIQUE_WEIGHTED</td> <td>Oblique/weighted</td> </tr> <tr>
    ///<td>PAN_LETT_OBLIQUE_BOXED</td> <td>Oblique/boxed</td> </tr> <tr> <td>PAN_LETT_OBLIQUE_FLATTENED</td>
    ///<td>Oblique/flattened</td> </tr> <tr> <td>PAN_LETT_OBLIQUE_ROUNDED</td> <td>Oblique/rounded</td> </tr> <tr>
    ///<td>PAN_LETT_OBLIQUE_OFF_CENTER</td> <td>Oblique/off center</td> </tr> <tr> <td>PAN_LETT_OBLIQUE_SQUARE</td>
    ///<td>Oblique/square</td> </tr> </table>
    ubyte bLetterform;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_MIDLINE_STANDARD_TRIMMED</td> <td>Standard/trimmed</td> </tr> <tr> <td>PAN_MIDLINE_STANDARD_POINTED</td>
    ///<td>Standard/pointed</td> </tr> <tr> <td>PAN_MIDLINE_STANDARD_SERIFED</td> <td>Standard/serifed</td> </tr> <tr>
    ///<td>PAN_MIDLINE_HIGH_TRIMMED</td> <td>High/trimmed</td> </tr> <tr> <td>PAN_MIDLINE_HIGH_POINTED</td>
    ///<td>High/pointed</td> </tr> <tr> <td>PAN_MIDLINE_HIGH_SERIFED</td> <td>High/serifed</td> </tr> <tr>
    ///<td>PAN_MIDLINE_CONSTANT_TRIMMED</td> <td>Constant/trimmed</td> </tr> <tr> <td>PAN_MIDLINE_CONSTANT_POINTED</td>
    ///<td>Constant/pointed</td> </tr> <tr> <td>PAN_MIDLINE_CONSTANT_SERIFED</td> <td>Constant/serifed</td> </tr> <tr>
    ///<td>PAN_MIDLINE_LOW_TRIMMED</td> <td>Low/trimmed</td> </tr> <tr> <td>PAN_MIDLINE_LOW_POINTED</td>
    ///<td>Low/pointed</td> </tr> <tr> <td>PAN_MIDLINE_LOW_SERIFED</td> <td>Low/serifed</td> </tr> </table>
    ubyte bMidline;
    ///For Latin fonts, one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>PAN_ANY</td> <td>Any</td> </tr> <tr> <td>PAN_NO_FIT</td> <td>No fit</td> </tr> <tr>
    ///<td>PAN_XHEIGHT_CONSTANT_SMALL</td> <td>Constant/small</td> </tr> <tr> <td>PAN_XHEIGHT_CONSTANT_STD</td>
    ///<td>Constant/standard</td> </tr> <tr> <td>PAN_XHEIGHT_CONSTANT_LARGE</td> <td>Constant/large</td> </tr> <tr>
    ///<td>PAN_XHEIGHT_DUCKING_SMALL</td> <td>Ducking/small</td> </tr> <tr> <td>PAN_XHEIGHT_DUCKING_STD</td>
    ///<td>Ducking/standard</td> </tr> <tr> <td>PAN_XHEIGHT_DUCKING_LARGE</td> <td>Ducking/large</td> </tr> </table>
    ubyte bXHeight;
}

///The <b>EXTLOGFONT</b> structure defines the attributes of a font.
struct EXTLOGFONTA
{
    ///Specifies some of the attributes of the specified font. This member is a LOGFONT structure.
    LOGFONTA  elfLogFont;
    ///A unique name for the font (for example, ABCD Font Company TrueType Bold Italic Sans Serif).
    ubyte[64] elfFullName;
    ///The style of the font (for example, Bold Italic).
    ubyte[32] elfStyle;
    ///Reserved. Must be zero.
    uint      elfVersion;
    ///This member only has meaning for hinted fonts. It specifies the point size at which the font is hinted. If set to
    ///zero, which is its default value, the font is hinted at the point size corresponding to the <b>lfHeight</b>
    ///member of the LOGFONT structure specified by <b>elfLogFont</b>.
    uint      elfStyleSize;
    ///A unique identifier for an enumerated font. This will be filled in by the graphics device interface (GDI) upon
    ///font enumeration.
    uint      elfMatch;
    ///Reserved; must be zero.
    uint      elfReserved;
    ///A 4-byte identifier of the font vendor.
    ubyte[4]  elfVendorId;
    ///Reserved; must be zero.
    uint      elfCulture;
    ///A PANOSE structure that specifies the shape of the font. If all members of this structure are set to zero, the
    ///<b>elfPanose</b> member is ignored by the font mapper.
    PANOSE    elfPanose;
}

///The <b>EXTLOGFONT</b> structure defines the attributes of a font.
struct EXTLOGFONTW
{
    ///Specifies some of the attributes of the specified font. This member is a LOGFONT structure.
    LOGFONTW   elfLogFont;
    ///A unique name for the font (for example, ABCD Font Company TrueType Bold Italic Sans Serif).
    ushort[64] elfFullName;
    ///The style of the font (for example, Bold Italic).
    ushort[32] elfStyle;
    ///Reserved. Must be zero.
    uint       elfVersion;
    ///This member only has meaning for hinted fonts. It specifies the point size at which the font is hinted. If set to
    ///zero, which is its default value, the font is hinted at the point size corresponding to the <b>lfHeight</b>
    ///member of the LOGFONT structure specified by <b>elfLogFont</b>.
    uint       elfStyleSize;
    ///A unique identifier for an enumerated font. This will be filled in by the graphics device interface (GDI) upon
    ///font enumeration.
    uint       elfMatch;
    ///Reserved; must be zero.
    uint       elfReserved;
    ///A 4-byte identifier of the font vendor.
    ubyte[4]   elfVendorId;
    ///Reserved; must be zero.
    uint       elfCulture;
    ///A PANOSE structure that specifies the shape of the font. If all members of this structure are set to zero, the
    ///<b>elfPanose</b> member is ignored by the font mapper.
    PANOSE     elfPanose;
}

///The <b>DISPLAY_DEVICE</b> structure receives information about the display device specified by the <i>iDevNum</i>
///parameter of the EnumDisplayDevices function.
struct DISPLAY_DEVICEA
{
    ///Size, in bytes, of the <b>DISPLAY_DEVICE</b> structure. This must be initialized prior to calling
    ///EnumDisplayDevices.
    uint      cb;
    ///An array of characters identifying the device name. This is either the adapter device or the monitor device.
    byte[32]  DeviceName;
    ///An array of characters containing the device context string. This is either a description of the display adapter
    ///or of the display monitor.
    byte[128] DeviceString;
    ///Device state flags. It can be any reasonable combination of the following. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>DISPLAY_DEVICE_ACTIVE</td> <td>DISPLAY_DEVICE_ACTIVE specifies whether a monitor
    ///is presented as being "on" by the respective GDI view. <b>Windows Vista:</b> EnumDisplayDevices will only
    ///enumerate monitors that can be presented as being "on." </td> </tr> <tr> <td>DISPLAY_DEVICE_MIRRORING_DRIVER</td>
    ///<td>Represents a pseudo device used to mirror application drawing for remoting or other purposes. An invisible
    ///pseudo monitor is associated with this device. For example, NetMeeting uses it. Note that GetSystemMetrics
    ///(SM_MONITORS) only accounts for visible display monitors.</td> </tr> <tr> <td>DISPLAY_DEVICE_MODESPRUNED</td>
    ///<td>The device has more display modes than its output devices support.</td> </tr> <tr>
    ///<td>DISPLAY_DEVICE_PRIMARY_DEVICE</td> <td>The primary desktop is on the device. For a system with a single
    ///display card, this is always set. For a system with multiple display cards, only one device can have this
    ///set.</td> </tr> <tr> <td>DISPLAY_DEVICE_REMOVABLE</td> <td>The device is removable; it cannot be the primary
    ///display.</td> </tr> <tr> <td>DISPLAY_DEVICE_VGA_COMPATIBLE</td> <td>The device is VGA compatible.</td> </tr>
    ///</table>
    uint      StateFlags;
    ///Not used.
    byte[128] DeviceID;
    ///Reserved.
    byte[128] DeviceKey;
}

///The <b>DISPLAY_DEVICE</b> structure receives information about the display device specified by the <i>iDevNum</i>
///parameter of the EnumDisplayDevices function.
struct DISPLAY_DEVICEW
{
    ///Size, in bytes, of the <b>DISPLAY_DEVICE</b> structure. This must be initialized prior to calling
    ///EnumDisplayDevices.
    uint        cb;
    ///An array of characters identifying the device name. This is either the adapter device or the monitor device.
    ushort[32]  DeviceName;
    ///An array of characters containing the device context string. This is either a description of the display adapter
    ///or of the display monitor.
    ushort[128] DeviceString;
    ///Device state flags. It can be any reasonable combination of the following. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>DISPLAY_DEVICE_ACTIVE</td> <td>DISPLAY_DEVICE_ACTIVE specifies whether a monitor
    ///is presented as being "on" by the respective GDI view. <b>Windows Vista:</b> EnumDisplayDevices will only
    ///enumerate monitors that can be presented as being "on." </td> </tr> <tr> <td>DISPLAY_DEVICE_MIRRORING_DRIVER</td>
    ///<td>Represents a pseudo device used to mirror application drawing for remoting or other purposes. An invisible
    ///pseudo monitor is associated with this device. For example, NetMeeting uses it. Note that GetSystemMetrics
    ///(SM_MONITORS) only accounts for visible display monitors.</td> </tr> <tr> <td>DISPLAY_DEVICE_MODESPRUNED</td>
    ///<td>The device has more display modes than its output devices support.</td> </tr> <tr>
    ///<td>DISPLAY_DEVICE_PRIMARY_DEVICE</td> <td>The primary desktop is on the device. For a system with a single
    ///display card, this is always set. For a system with multiple display cards, only one device can have this
    ///set.</td> </tr> <tr> <td>DISPLAY_DEVICE_REMOVABLE</td> <td>The device is removable; it cannot be the primary
    ///display.</td> </tr> <tr> <td>DISPLAY_DEVICE_VGA_COMPATIBLE</td> <td>The device is VGA compatible.</td> </tr>
    ///</table>
    uint        StateFlags;
    ///Not used.
    ushort[128] DeviceID;
    ///Reserved.
    ushort[128] DeviceKey;
}

struct DISPLAYCONFIG_GET_ADVANCED_COLOR_INFO
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    union
    {
        struct
        {
            uint _bitfield42;
        }
        uint value;
    }
    DISPLAYCONFIG_COLOR_ENCODING colorEncoding;
    uint bitsPerColorChannel;
}

struct DISPLAYCONFIG_SET_ADVANCED_COLOR_STATE
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    union
    {
        struct
        {
            uint _bitfield43;
        }
        uint value;
    }
}

struct DISPLAYCONFIG_SDR_WHITE_LEVEL
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    uint SDRWhiteLevel;
}

///The <b>RGNDATAHEADER</b> structure describes the data returned by the GetRegionData function.
struct RGNDATAHEADER
{
    ///The size, in bytes, of the header.
    uint dwSize;
    ///The type of region. This value must be RDH_RECTANGLES.
    uint iType;
    ///The number of rectangles that make up the region.
    uint nCount;
    ///The size of the RGNDATA buffer required to receive the RECT structures that make up the region. If the size is
    ///not known, this member can be zero.
    uint nRgnSize;
    ///A bounding rectangle for the region in logical units.
    RECT rcBound;
}

///The <b>RGNDATA</b> structure contains a header and an array of rectangles that compose a region. The rectangles are
///sorted top to bottom, left to right. They do not overlap.
struct RGNDATA
{
    ///A RGNDATAHEADER structure. The members of this structure specify the type of region (whether it is rectangular or
    ///trapezoidal), the number of rectangles that make up the region, the size of the buffer that contains the
    ///rectangle structures, and so on.
    RGNDATAHEADER rdh;
    ///Specifies an arbitrary-size buffer that contains the RECT structures that make up the region.
    byte[1]       Buffer;
}

///The <b>ABC</b> structure contains the width of a character in a TrueType font.
struct ABC
{
    ///The A spacing of the character. The A spacing is the distance to add to the current position before drawing the
    ///character glyph.
    int  abcA;
    ///The B spacing of the character. The B spacing is the width of the drawn portion of the character glyph.
    uint abcB;
    ///The C spacing of the character. The C spacing is the distance to add to the current position to provide white
    ///space to the right of the character glyph.
    int  abcC;
}

///The <b>ABCFLOAT</b> structure contains the A, B, and C widths of a font character.
struct ABCFLOAT
{
    ///The A spacing of the character. The A spacing is the distance to add to the current position before drawing the
    ///character glyph.
    float abcfA;
    ///The B spacing of the character. The B spacing is the width of the drawn portion of the character glyph.
    float abcfB;
    ///The C spacing of the character. The C spacing is the distance to add to the current position to provide white
    ///space to the right of the character glyph.
    float abcfC;
}

///The <b>OUTLINETEXTMETRIC</b> structure contains metrics describing a TrueType font.
struct OUTLINETEXTMETRICA
{
    ///The size, in bytes, of the <b>OUTLINETEXTMETRIC</b> structure.
    uint         otmSize;
    ///A TEXTMETRIC structure containing further information about the font.
    TEXTMETRICA  otmTextMetrics;
    ///A value that causes the structure to be byte-aligned.
    ubyte        otmFiller;
    ///The PANOSE number for this font.
    PANOSE       otmPanoseNumber;
    ///The nature of the font pattern. This member can be a combination of the following bits. <table> <tr> <th>Bit</th>
    ///<th>Meaning</th> </tr> <tr> <td>0</td> <td>Italic</td> </tr> <tr> <td>1</td> <td>Underscore</td> </tr> <tr>
    ///<td>2</td> <td>Negative</td> </tr> <tr> <td>3</td> <td>Outline</td> </tr> <tr> <td>4</td> <td>Strikeout</td>
    ///</tr> <tr> <td>5</td> <td>Bold</td> </tr> </table>
    uint         otmfsSelection;
    ///Indicates whether the font is licensed. Licensed fonts must not be modified or exchanged. If bit 1 is set, the
    ///font may not be embedded in a document. If bit 1 is clear, the font can be embedded. If bit 2 is set, the
    ///embedding is read-only.
    uint         otmfsType;
    ///The slope of the cursor. This value is 1 if the slope is vertical. Applications can use this value and the value
    ///of the <b>otmsCharSlopeRun</b> member to create an italic cursor that has the same slope as the main italic angle
    ///(specified by the <b>otmItalicAngle</b> member).
    int          otmsCharSlopeRise;
    ///The slope of the cursor. This value is zero if the slope is vertical. Applications can use this value and the
    ///value of the <b>otmsCharSlopeRise</b> member to create an italic cursor that has the same slope as the main
    ///italic angle (specified by the <b>otmItalicAngle</b> member).
    int          otmsCharSlopeRun;
    ///The main italic angle of the font, in tenths of a degree counterclockwise from vertical. Regular (roman) fonts
    ///have a value of zero. Italic fonts typically have a negative italic angle (that is, they lean to the right).
    int          otmItalicAngle;
    ///The number of logical units defining the x- or y-dimension of the em square for this font. (The number of units
    ///in the x- and y-directions are always the same for an em square.)
    uint         otmEMSquare;
    ///The maximum distance characters in this font extend above the base line. This is the typographic ascent for the
    ///font.
    int          otmAscent;
    ///The maximum distance characters in this font extend below the base line. This is the typographic descent for the
    ///font.
    int          otmDescent;
    ///The typographic line spacing.
    uint         otmLineGap;
    ///Not supported.
    uint         otmsCapEmHeight;
    ///Not supported.
    uint         otmsXHeight;
    ///The bounding box for the font.
    RECT         otmrcFontBox;
    ///The maximum distance characters in this font extend above the base line for the Macintosh computer.
    int          otmMacAscent;
    ///The maximum distance characters in this font extend below the base line for the Macintosh computer.
    int          otmMacDescent;
    ///The line-spacing information for the Macintosh computer.
    uint         otmMacLineGap;
    ///The smallest recommended size for this font, in pixels per em-square.
    uint         otmusMinimumPPEM;
    ///The recommended horizontal and vertical size for subscripts in this font.
    POINT        otmptSubscriptSize;
    ///The recommended horizontal and vertical offset for subscripts in this font. The subscript offset is measured from
    ///the character origin to the origin of the subscript character.
    POINT        otmptSubscriptOffset;
    ///The recommended horizontal and vertical size for superscripts in this font.
    POINT        otmptSuperscriptSize;
    ///The recommended horizontal and vertical offset for superscripts in this font. The superscript offset is measured
    ///from the character base line to the base line of the superscript character.
    POINT        otmptSuperscriptOffset;
    ///The width of the strikeout stroke for this font. Typically, this is the width of the em dash for the font.
    uint         otmsStrikeoutSize;
    ///The position of the strikeout stroke relative to the base line for this font. Positive values are above the base
    ///line and negative values are below.
    int          otmsStrikeoutPosition;
    ///The thickness of the underscore character for this font.
    int          otmsUnderscoreSize;
    ///The position of the underscore character for this font.
    int          otmsUnderscorePosition;
    ///The offset from the beginning of the structure to a string specifying the family name for the font.
    const(char)* otmpFamilyName;
    ///The offset from the beginning of the structure to a string specifying the typeface name for the font. (This
    ///typeface name corresponds to the name specified in the LOGFONT structure.)
    const(char)* otmpFaceName;
    ///The offset from the beginning of the structure to a string specifying the style name for the font.
    const(char)* otmpStyleName;
    ///The offset from the beginning of the structure to a string specifying the full name for the font. This name is
    ///unique for the font and often contains a version number or other identifying information.
    const(char)* otmpFullName;
}

///The <b>OUTLINETEXTMETRIC</b> structure contains metrics describing a TrueType font.
struct OUTLINETEXTMETRICW
{
    ///The size, in bytes, of the <b>OUTLINETEXTMETRIC</b> structure.
    uint         otmSize;
    ///A TEXTMETRIC structure containing further information about the font.
    TEXTMETRICW  otmTextMetrics;
    ///A value that causes the structure to be byte-aligned.
    ubyte        otmFiller;
    ///The PANOSE number for this font.
    PANOSE       otmPanoseNumber;
    ///The nature of the font pattern. This member can be a combination of the following bits. <table> <tr> <th>Bit</th>
    ///<th>Meaning</th> </tr> <tr> <td>0</td> <td>Italic</td> </tr> <tr> <td>1</td> <td>Underscore</td> </tr> <tr>
    ///<td>2</td> <td>Negative</td> </tr> <tr> <td>3</td> <td>Outline</td> </tr> <tr> <td>4</td> <td>Strikeout</td>
    ///</tr> <tr> <td>5</td> <td>Bold</td> </tr> </table>
    uint         otmfsSelection;
    ///Indicates whether the font is licensed. Licensed fonts must not be modified or exchanged. If bit 1 is set, the
    ///font may not be embedded in a document. If bit 1 is clear, the font can be embedded. If bit 2 is set, the
    ///embedding is read-only.
    uint         otmfsType;
    ///The slope of the cursor. This value is 1 if the slope is vertical. Applications can use this value and the value
    ///of the <b>otmsCharSlopeRun</b> member to create an italic cursor that has the same slope as the main italic angle
    ///(specified by the <b>otmItalicAngle</b> member).
    int          otmsCharSlopeRise;
    ///The slope of the cursor. This value is zero if the slope is vertical. Applications can use this value and the
    ///value of the <b>otmsCharSlopeRise</b> member to create an italic cursor that has the same slope as the main
    ///italic angle (specified by the <b>otmItalicAngle</b> member).
    int          otmsCharSlopeRun;
    ///The main italic angle of the font, in tenths of a degree counterclockwise from vertical. Regular (roman) fonts
    ///have a value of zero. Italic fonts typically have a negative italic angle (that is, they lean to the right).
    int          otmItalicAngle;
    ///The number of logical units defining the x- or y-dimension of the em square for this font. (The number of units
    ///in the x- and y-directions are always the same for an em square.)
    uint         otmEMSquare;
    ///The maximum distance characters in this font extend above the base line. This is the typographic ascent for the
    ///font.
    int          otmAscent;
    ///The maximum distance characters in this font extend below the base line. This is the typographic descent for the
    ///font.
    int          otmDescent;
    ///The typographic line spacing.
    uint         otmLineGap;
    ///Not supported.
    uint         otmsCapEmHeight;
    ///Not supported.
    uint         otmsXHeight;
    ///The bounding box for the font.
    RECT         otmrcFontBox;
    ///The maximum distance characters in this font extend above the base line for the Macintosh computer.
    int          otmMacAscent;
    ///The maximum distance characters in this font extend below the base line for the Macintosh computer.
    int          otmMacDescent;
    ///The line-spacing information for the Macintosh computer.
    uint         otmMacLineGap;
    ///The smallest recommended size for this font, in pixels per em-square.
    uint         otmusMinimumPPEM;
    ///The recommended horizontal and vertical size for subscripts in this font.
    POINT        otmptSubscriptSize;
    ///The recommended horizontal and vertical offset for subscripts in this font. The subscript offset is measured from
    ///the character origin to the origin of the subscript character.
    POINT        otmptSubscriptOffset;
    ///The recommended horizontal and vertical size for superscripts in this font.
    POINT        otmptSuperscriptSize;
    ///The recommended horizontal and vertical offset for superscripts in this font. The superscript offset is measured
    ///from the character base line to the base line of the superscript character.
    POINT        otmptSuperscriptOffset;
    ///The width of the strikeout stroke for this font. Typically, this is the width of the em dash for the font.
    uint         otmsStrikeoutSize;
    ///The position of the strikeout stroke relative to the base line for this font. Positive values are above the base
    ///line and negative values are below.
    int          otmsStrikeoutPosition;
    ///The thickness of the underscore character for this font.
    int          otmsUnderscoreSize;
    ///The position of the underscore character for this font.
    int          otmsUnderscorePosition;
    ///The offset from the beginning of the structure to a string specifying the family name for the font.
    const(char)* otmpFamilyName;
    ///The offset from the beginning of the structure to a string specifying the typeface name for the font. (This
    ///typeface name corresponds to the name specified in the LOGFONT structure.)
    const(char)* otmpFaceName;
    ///The offset from the beginning of the structure to a string specifying the style name for the font.
    const(char)* otmpStyleName;
    ///The offset from the beginning of the structure to a string specifying the full name for the font. This name is
    ///unique for the font and often contains a version number or other identifying information.
    const(char)* otmpFullName;
}

///The <b>POLYTEXT</b> structure describes how the PolyTextOut function should draw a string of text.
struct POLYTEXTA
{
    ///The horizontal reference point for the string. The string is aligned to this point using the current
    ///text-alignment mode.
    int          x;
    ///The vertical reference point for the string. The string is aligned to this point using the current text-alignment
    ///mode.
    int          y;
    ///The length of the string pointed to by <b>lpstr</b>.
    uint         n;
    ///Pointer to a string of text to be drawn by the PolyTextOut function. This string need not be null-terminated,
    ///since <b>n</b> specifies the length of the string.
    const(char)* lpstr;
    ///Specifies whether the string is to be opaque or clipped and whether the string is accompanied by an array of
    ///character-width values. This member can be one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>ETO_OPAQUE</td> <td>The rectangle for each string is to be opaqued with the
    ///current background color.</td> </tr> <tr> <td>ETO_CLIPPED</td> <td>Each string is to be clipped to its specified
    ///rectangle.</td> </tr> </table>
    uint         uiFlags;
    ///A rectangle structure that contains the dimensions of the opaquing or clipping rectangle. This member is ignored
    ///if neither of the ETO_OPAQUE nor the ETO_CLIPPED value is specified for the <b>uiFlags</b> member.
    RECT         rcl;
    ///Pointer to an array containing the width value for each character in the string.
    int*         pdx;
}

///The <b>POLYTEXT</b> structure describes how the PolyTextOut function should draw a string of text.
struct POLYTEXTW
{
    ///The horizontal reference point for the string. The string is aligned to this point using the current
    ///text-alignment mode.
    int           x;
    ///The vertical reference point for the string. The string is aligned to this point using the current text-alignment
    ///mode.
    int           y;
    ///The length of the string pointed to by <b>lpstr</b>.
    uint          n;
    ///Pointer to a string of text to be drawn by the PolyTextOut function. This string need not be null-terminated,
    ///since <b>n</b> specifies the length of the string.
    const(wchar)* lpstr;
    ///Specifies whether the string is to be opaque or clipped and whether the string is accompanied by an array of
    ///character-width values. This member can be one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>ETO_OPAQUE</td> <td>The rectangle for each string is to be opaqued with the
    ///current background color.</td> </tr> <tr> <td>ETO_CLIPPED</td> <td>Each string is to be clipped to its specified
    ///rectangle.</td> </tr> </table>
    uint          uiFlags;
    ///A rectangle structure that contains the dimensions of the opaquing or clipping rectangle. This member is ignored
    ///if neither of the ETO_OPAQUE nor the ETO_CLIPPED value is specified for the <b>uiFlags</b> member.
    RECT          rcl;
    ///Pointer to an array containing the width value for each character in the string.
    int*          pdx;
}

///The <b>FIXED</b> structure contains the integral and fractional parts of a fixed-point real number.
struct FIXED
{
    ///The fractional part of the number.
    ushort fract;
    ///The integer part of the number.
    short  value;
}

///The <b>MAT2</b> structure contains the values for a transformation matrix used by the GetGlyphOutline function.
struct MAT2
{
    ///A fixed-point value for the M11 component of a 3 by 3 transformation matrix.
    FIXED eM11;
    ///A fixed-point value for the M12 component of a 3 by 3 transformation matrix.
    FIXED eM12;
    ///A fixed-point value for the M21 component of a 3 by 3 transformation matrix.
    FIXED eM21;
    ///A fixed-point value for the M22 component of a 3 by 3 transformation matrix.
    FIXED eM22;
}

///The <b>GLYPHMETRICS</b> structure contains information about the placement and orientation of a glyph in a character
///cell.
struct GLYPHMETRICS
{
    ///The width of the smallest rectangle that completely encloses the glyph (its black box).
    uint  gmBlackBoxX;
    ///The height of the smallest rectangle that completely encloses the glyph (its black box).
    uint  gmBlackBoxY;
    ///The x- and y-coordinates of the upper left corner of the smallest rectangle that completely encloses the glyph.
    POINT gmptGlyphOrigin;
    ///The horizontal distance from the origin of the current character cell to the origin of the next character cell.
    short gmCellIncX;
    ///The vertical distance from the origin of the current character cell to the origin of the next character cell.
    short gmCellIncY;
}

///The <b>POINTFX</b> structure contains the coordinates of points that describe the outline of a character in a
///TrueType font.
struct POINTFX
{
    ///The x-component of a point on the outline of a TrueType character.
    FIXED x;
    ///The y-component of a point on the outline of a TrueType character.
    FIXED y;
}

///The <b>TTPOLYCURVE</b> structure contains information about a curve in the outline of a TrueType character.
struct TTPOLYCURVE
{
    ///The type of curve described by the structure. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td>TT_PRIM_LINE</td> <td>Curve is a polyline.</td> </tr> <tr>
    ///<td>TT_PRIM_QSPLINE</td> <td>Curve is a quadratic Bézier spline.</td> </tr> <tr> <td>TT_PRIM_CSPLINE</td>
    ///<td>Curve is a cubic Bézier spline.</td> </tr> </table>
    ushort     wType;
    ///The number of POINTFX structures in the array.
    ushort     cpfx;
    ///Specifies an array of POINTFX structures that define the polyline or Bézier spline.
    POINTFX[1] apfx;
}

///The <b>TTPOLYGONHEADER</b> structure specifies the starting position and type of a contour in a TrueType character
///outline.
struct TTPOLYGONHEADER
{
    ///The number of bytes required by the <b>TTPOLYGONHEADER</b> structure and TTPOLYCURVE structure or structures
    ///required to describe the contour of the character.
    uint    cb;
    ///The type of character outline returned. Currently, this value must be TT_POLYGON_TYPE.
    uint    dwType;
    ///The starting point of the contour in the character outline.
    POINTFX pfxStart;
}

///The <b>GCP_RESULTS</b> structure contains information about characters in a string. This structure receives the
///results of the GetCharacterPlacement function. For some languages, the first element in the arrays may contain more,
///language-dependent information.
struct GCP_RESULTSA
{
    ///The size, in bytes, of the structure.
    uint          lStructSize;
    ///A pointer to the buffer that receives the output string or is <b>NULL</b> if the output string is not needed. The
    ///output string is a version of the original string that is in the order that will be displayed on a specified
    ///device. Typically the output string is identical to the original string, but may be different if the string needs
    ///reordering and the GCP_REORDER flag is set or if the original string exceeds the maximum extent and the
    ///GCP_MAXEXTENT flag is set.
    const(char)*  lpOutString;
    ///A pointer to the array that receives ordering indexes or is <b>NULL</b> if the ordering indexes are not needed.
    ///However, its meaning depends on the other elements of <b>GCP_RESULTS</b>. If glyph indexes are to be returned,
    ///the indexes are for the <b>lpGlyphs</b> array; if glyphs indexes are not returned and <b>lpOrder</b> is
    ///requested, the indexes are for <b>lpOutString</b>. For example, in the latter case the value of <b>lpOrder</b>[i]
    ///is the position of <b>lpString</b>[i] in the output string lpOutString. This is typically used when
    ///GetFontLanguageInfo returns the GCP_REORDER flag, which indicates that the original string needs reordering. For
    ///example, in Hebrew, in which the text runs from right to left, the <b>lpOrder</b> array gives the exact locations
    ///of each element in the original string.
    uint*         lpOrder;
    ///A pointer to the array that receives the distances between adjacent character cells or is <b>NULL</b> if these
    ///distances are not needed. If glyph rendering is done, the distances are for the glyphs not the characters, so the
    ///resulting array can be used with the ExtTextOut function. The distances in this array are in display order. To
    ///find the distance for the <i>i</i><sup>th</sup> character in the original string, use the <b>lpOrder</b> array as
    ///follows: <pre class="syntax" xml:space="preserve"><code> width = lpDx[lpOrder[i]]; </code></pre>
    int*          lpDx;
    ///A pointer to the array that receives the caret position values or is <b>NULL</b> if caret positions are not
    ///needed. Each value specifies the caret position immediately before the corresponding character. In some languages
    ///the position of the caret for each character may not be immediately to the left of the character. For example, in
    ///Hebrew, in which the text runs from right to left, the caret position is to the right of the character. If glyph
    ///ordering is done, <b>lpCaretPos</b> matches the original string, not the output string. This means that some
    ///adjacent values may be the same. The values in this array are in input order. To find the caret position value
    ///for the <i>i</i><sup>th</sup> character in the original string, use the array as follows: <pre class="syntax"
    ///xml:space="preserve"><code> position = lpCaretPos[i]; </code></pre>
    int*          lpCaretPos;
    ///A pointer to the array that contains and/or receives character classifications. The values indicate how to lay
    ///out characters in the string and are similar (but not identical) to the CT_CTYPE2 values returned by the
    ///GetStringTypeEx function. Each element of the array can be set to zero or one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCPCLASS_ARABIC"></a><a
    ///id="gcpclass_arabic"></a><dl> <dt><b>GCPCLASS_ARABIC</b></dt> </dl> </td> <td width="60%"> Arabic character.
    ///</td> </tr> <tr> <td width="40%"><a id="GCPCLASS_HEBREW"></a><a id="gcpclass_hebrew"></a><dl>
    ///<dt><b>GCPCLASS_HEBREW</b></dt> </dl> </td> <td width="60%"> Hebrew character. </td> </tr> <tr> <td
    ///width="40%"><a id="GCPCLASS_LATIN"></a><a id="gcpclass_latin"></a><dl> <dt><b>GCPCLASS_LATIN</b></dt> </dl> </td>
    ///<td width="60%"> Character from a Latin or other single-byte character set for a left-to-right language. </td>
    ///</tr> <tr> <td width="40%"><a id="GCPCLASS_LATINNUMBER"></a><a id="gcpclass_latinnumber"></a><dl>
    ///<dt><b>GCPCLASS_LATINNUMBER</b></dt> </dl> </td> <td width="60%"> Digit from a Latin or other single-byte
    ///character set for a left-to-right language. </td> </tr> <tr> <td width="40%"><a id="GCPCLASS_LOCALNUMBER"></a><a
    ///id="gcpclass_localnumber"></a><dl> <dt><b>GCPCLASS_LOCALNUMBER</b></dt> </dl> </td> <td width="60%"> Digit from
    ///the character set associated with the current font. </td> </tr> </table> In addition, the following can be used
    ///when supplying values in the <b>lpClass</b> array with the GCP_CLASSIN flag. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCPCLASS_LATINNUMERICSEPARATOR"></a><a
    ///id="gcpclass_latinnumericseparator"></a><dl> <dt><b>GCPCLASS_LATINNUMERICSEPARATOR</b></dt> </dl> </td> <td
    ///width="60%"> Input only. Character used to separate Latin digits, such as a comma or decimal point. </td> </tr>
    ///<tr> <td width="40%"><a id="GCPCLASS_LATINNUMERICTERMINATOR"></a><a id="gcpclass_latinnumericterminator"></a><dl>
    ///<dt><b>GCPCLASS_LATINNUMERICTERMINATOR</b></dt> </dl> </td> <td width="60%"> Input only. Character used to
    ///terminate Latin digits, such as a plus or minus sign. </td> </tr> <tr> <td width="40%"><a
    ///id="GCPCLASS_NEUTRAL"></a><a id="gcpclass_neutral"></a><dl> <dt><b>GCPCLASS_NEUTRAL</b></dt> </dl> </td> <td
    ///width="60%"> Input only. Character has no specific classification. </td> </tr> <tr> <td width="40%"><a
    ///id="GCPCLASS_NUMERICSEPARATOR"></a><a id="gcpclass_numericseparator"></a><dl>
    ///<dt><b>GCPCLASS_NUMERICSEPARATOR</b></dt> </dl> </td> <td width="60%"> Input only. Character used to separate
    ///digits, such as a comma or decimal point. </td> </tr> </table> For languages that use the GCP_REORDER flag, the
    ///following values can also be used with the GCP_CLASSIN flag. Unlike the preceding values, which can be used
    ///anywhere in the <b>lpClass</b> array, all of the following values are used only in the first location in the
    ///array. All combine with other classifications. Note that GCPCLASS_PREBOUNDLTR and GCPCLASS_PREBOUNDRTL are
    ///mutually exclusive, as are GCPCLASSPOSTBOUNDLTR and GCPCLASSPOSTBOUNDRTL. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCPCLASS_PREBOUNDLTR"></a><a
    ///id="gcpclass_preboundltr"></a><dl> <dt><b>GCPCLASS_PREBOUNDLTR</b></dt> </dl> </td> <td width="60%"> Set
    ///<b>lpClass</b>[0] to GCPCLASS_PREBOUNDLTR to bind the string to left-to-right reading order before the string.
    ///</td> </tr> <tr> <td width="40%"><a id="GCPCLASS_PREBOUNDRTL"></a><a id="gcpclass_preboundrtl"></a><dl>
    ///<dt><b>GCPCLASS_PREBOUNDRTL</b></dt> </dl> </td> <td width="60%"> Set <b>lpClass</b>[0] to GCPCLASS_PREBOUNDRTL
    ///to bind the string to right-to-left reading order before the string. </td> </tr> <tr> <td width="40%"><a
    ///id="GCPCLASS_POSTBOUNDLTR"></a><a id="gcpclass_postboundltr"></a><dl> <dt><b>GCPCLASS_POSTBOUNDLTR</b></dt> </dl>
    ///</td> <td width="60%"> Set <b>lpClass</b>[0] to GCPCLASS_POSTBOUNDLTR to bind the string to left-to-right reading
    ///order after the string. </td> </tr> <tr> <td width="40%"><a id="GCPCLASS_POSTBOUNDRTL"></a><a
    ///id="gcpclass_postboundrtl"></a><dl> <dt><b>GCPCLASS_POSTBOUNDRTL</b></dt> </dl> </td> <td width="60%"> Set
    ///<b>lpClass</b>[0] to GCPCLASS_POSTBOUNDRTL to bind the string to right-to-left reading order after the string.
    ///</td> </tr> </table> To force the layout of a character to be carried out in a specific way, preset the
    ///classification for the corresponding array element; the function leaves such preset classifications unchanged and
    ///computes classifications only for array elements that have been set to zero. Preset classifications are used only
    ///if the GCP_CLASSIN flag is set and the <b>lpClass</b> array is supplied. If GetFontLanguageInfo does not return
    ///GCP_REORDER for the current font, only the GCPCLASS_LATIN value is meaningful.
    const(char)*  lpClass;
    ///A pointer to the array that receives the values identifying the glyphs used for rendering the string or is
    ///<b>NULL</b> if glyph rendering is not needed. The number of glyphs in the array may be less than the number of
    ///characters in the original string if the string contains ligated glyphs. Also if reordering is required, the
    ///order of the glyphs may not be sequential. This array is useful if more than one operation is being done on a
    ///string which has any form of ligation, kerning or order-switching. Using the values in this array for subsequent
    ///operations saves the time otherwise required to generate the glyph indices each time. This array always contains
    ///glyph indices and the ETO_GLYPH_INDEX value must always be used when this array is used with the ExtTextOut
    ///function. When GCP_LIGATE is used, you can limit the number of characters that will be ligated together. (In
    ///Arabic for example, three-character ligations are common). This is done by setting the maximum required in
    ///lpGcpResults-&gt;lpGlyphs[0]. If no maximum is required, you should set this field to zero. For languages such as
    ///Arabic, where GetFontLanguageInfo returns the GCP_GLYPHSHAPE flag, the glyphs for a character will be different
    ///depending on whether the character is at the beginning, middle, or end of a word. Typically, the first character
    ///in the input string will also be the first character in a word, and the last character in the input string will
    ///be treated as the last character in a word. However, if the displayed string is a subset of the complete string,
    ///such as when displaying a section of scrolled text, this may not be true. In these cases, it is desirable to
    ///force the first or last characters to be shaped as not being initial or final forms. To do this, again, the first
    ///location in the <b>lpGlyphs</b> array is used by performing an OR operation of the ligation value above with the
    ///values GCPGLYPH_LINKBEFORE and/or GCPGLYPH_LINKAFTER. For example, a value of GCPGLYPH_LINKBEFORE | 2 means that
    ///two-character ligatures are the maximum required, and the first character in the string should be treated as if
    ///it is in the middle of a word.
    const(wchar)* lpGlyphs;
    ///On input, this member must be set to the size of the arrays pointed to by the array pointer members. On output,
    ///this is set to the number of glyphs filled in, in the output arrays. If glyph substitution is not required (that
    ///is, each input character maps to exactly one glyph), this member is the same as it is on input.
    uint          nGlyphs;
    ///The number of characters that fit within the extents specified by the <i>nMaxExtent</i> parameter of the
    ///GetCharacterPlacement function. If the GCP_MAXEXTENT or GCP_JUSTIFY value is set, this value may be less than the
    ///number of characters in the original string. This member is set regardless of whether the GCP_MAXEXTENT or
    ///GCP_JUSTIFY value is specified. Unlike <b>nGlyphs</b>, which specifies the number of output glyphs,
    ///<b>nMaxFit</b> refers to the number of characters from the input string. For Latin SBCS languages, this will be
    ///the same.
    int           nMaxFit;
}

///The <b>GCP_RESULTS</b> structure contains information about characters in a string. This structure receives the
///results of the GetCharacterPlacement function. For some languages, the first element in the arrays may contain more,
///language-dependent information.
struct GCP_RESULTSW
{
    ///The size, in bytes, of the structure.
    uint          lStructSize;
    ///A pointer to the buffer that receives the output string or is <b>NULL</b> if the output string is not needed. The
    ///output string is a version of the original string that is in the order that will be displayed on a specified
    ///device. Typically the output string is identical to the original string, but may be different if the string needs
    ///reordering and the GCP_REORDER flag is set or if the original string exceeds the maximum extent and the
    ///GCP_MAXEXTENT flag is set.
    const(wchar)* lpOutString;
    ///A pointer to the array that receives ordering indexes or is <b>NULL</b> if the ordering indexes are not needed.
    ///However, its meaning depends on the other elements of <b>GCP_RESULTS</b>. If glyph indexes are to be returned,
    ///the indexes are for the <b>lpGlyphs</b> array; if glyphs indexes are not returned and <b>lpOrder</b> is
    ///requested, the indexes are for <b>lpOutString</b>. For example, in the latter case the value of <b>lpOrder</b>[i]
    ///is the position of <b>lpString</b>[i] in the output string lpOutString. This is typically used when
    ///GetFontLanguageInfo returns the GCP_REORDER flag, which indicates that the original string needs reordering. For
    ///example, in Hebrew, in which the text runs from right to left, the <b>lpOrder</b> array gives the exact locations
    ///of each element in the original string.
    uint*         lpOrder;
    ///A pointer to the array that receives the distances between adjacent character cells or is <b>NULL</b> if these
    ///distances are not needed. If glyph rendering is done, the distances are for the glyphs not the characters, so the
    ///resulting array can be used with the ExtTextOut function. The distances in this array are in display order. To
    ///find the distance for the <i>i</i><sup>th</sup> character in the original string, use the <b>lpOrder</b> array as
    ///follows: <pre class="syntax" xml:space="preserve"><code> width = lpDx[lpOrder[i]]; </code></pre>
    int*          lpDx;
    ///A pointer to the array that receives the caret position values or is <b>NULL</b> if caret positions are not
    ///needed. Each value specifies the caret position immediately before the corresponding character. In some languages
    ///the position of the caret for each character may not be immediately to the left of the character. For example, in
    ///Hebrew, in which the text runs from right to left, the caret position is to the right of the character. If glyph
    ///ordering is done, <b>lpCaretPos</b> matches the original string, not the output string. This means that some
    ///adjacent values may be the same. The values in this array are in input order. To find the caret position value
    ///for the <i>i</i><sup>th</sup> character in the original string, use the array as follows: <pre class="syntax"
    ///xml:space="preserve"><code> position = lpCaretPos[i]; </code></pre>
    int*          lpCaretPos;
    ///A pointer to the array that contains and/or receives character classifications. The values indicate how to lay
    ///out characters in the string and are similar (but not identical) to the CT_CTYPE2 values returned by the
    ///GetStringTypeEx function. Each element of the array can be set to zero or one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCPCLASS_ARABIC"></a><a
    ///id="gcpclass_arabic"></a><dl> <dt><b>GCPCLASS_ARABIC</b></dt> </dl> </td> <td width="60%"> Arabic character.
    ///</td> </tr> <tr> <td width="40%"><a id="GCPCLASS_HEBREW"></a><a id="gcpclass_hebrew"></a><dl>
    ///<dt><b>GCPCLASS_HEBREW</b></dt> </dl> </td> <td width="60%"> Hebrew character. </td> </tr> <tr> <td
    ///width="40%"><a id="GCPCLASS_LATIN"></a><a id="gcpclass_latin"></a><dl> <dt><b>GCPCLASS_LATIN</b></dt> </dl> </td>
    ///<td width="60%"> Character from a Latin or other single-byte character set for a left-to-right language. </td>
    ///</tr> <tr> <td width="40%"><a id="GCPCLASS_LATINNUMBER"></a><a id="gcpclass_latinnumber"></a><dl>
    ///<dt><b>GCPCLASS_LATINNUMBER</b></dt> </dl> </td> <td width="60%"> Digit from a Latin or other single-byte
    ///character set for a left-to-right language. </td> </tr> <tr> <td width="40%"><a id="GCPCLASS_LOCALNUMBER"></a><a
    ///id="gcpclass_localnumber"></a><dl> <dt><b>GCPCLASS_LOCALNUMBER</b></dt> </dl> </td> <td width="60%"> Digit from
    ///the character set associated with the current font. </td> </tr> </table> In addition, the following can be used
    ///when supplying values in the <b>lpClass</b> array with the GCP_CLASSIN flag. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCPCLASS_LATINNUMERICSEPARATOR"></a><a
    ///id="gcpclass_latinnumericseparator"></a><dl> <dt><b>GCPCLASS_LATINNUMERICSEPARATOR</b></dt> </dl> </td> <td
    ///width="60%"> Input only. Character used to separate Latin digits, such as a comma or decimal point. </td> </tr>
    ///<tr> <td width="40%"><a id="GCPCLASS_LATINNUMERICTERMINATOR"></a><a id="gcpclass_latinnumericterminator"></a><dl>
    ///<dt><b>GCPCLASS_LATINNUMERICTERMINATOR</b></dt> </dl> </td> <td width="60%"> Input only. Character used to
    ///terminate Latin digits, such as a plus or minus sign. </td> </tr> <tr> <td width="40%"><a
    ///id="GCPCLASS_NEUTRAL"></a><a id="gcpclass_neutral"></a><dl> <dt><b>GCPCLASS_NEUTRAL</b></dt> </dl> </td> <td
    ///width="60%"> Input only. Character has no specific classification. </td> </tr> <tr> <td width="40%"><a
    ///id="GCPCLASS_NUMERICSEPARATOR"></a><a id="gcpclass_numericseparator"></a><dl>
    ///<dt><b>GCPCLASS_NUMERICSEPARATOR</b></dt> </dl> </td> <td width="60%"> Input only. Character used to separate
    ///digits, such as a comma or decimal point. </td> </tr> </table> For languages that use the GCP_REORDER flag, the
    ///following values can also be used with the GCP_CLASSIN flag. Unlike the preceding values, which can be used
    ///anywhere in the <b>lpClass</b> array, all of the following values are used only in the first location in the
    ///array. All combine with other classifications. Note that GCPCLASS_PREBOUNDLTR and GCPCLASS_PREBOUNDRTL are
    ///mutually exclusive, as are GCPCLASSPOSTBOUNDLTR and GCPCLASSPOSTBOUNDRTL. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCPCLASS_PREBOUNDLTR"></a><a
    ///id="gcpclass_preboundltr"></a><dl> <dt><b>GCPCLASS_PREBOUNDLTR</b></dt> </dl> </td> <td width="60%"> Set
    ///<b>lpClass</b>[0] to GCPCLASS_PREBOUNDLTR to bind the string to left-to-right reading order before the string.
    ///</td> </tr> <tr> <td width="40%"><a id="GCPCLASS_PREBOUNDRTL"></a><a id="gcpclass_preboundrtl"></a><dl>
    ///<dt><b>GCPCLASS_PREBOUNDRTL</b></dt> </dl> </td> <td width="60%"> Set <b>lpClass</b>[0] to GCPCLASS_PREBOUNDRTL
    ///to bind the string to right-to-left reading order before the string. </td> </tr> <tr> <td width="40%"><a
    ///id="GCPCLASS_POSTBOUNDLTR"></a><a id="gcpclass_postboundltr"></a><dl> <dt><b>GCPCLASS_POSTBOUNDLTR</b></dt> </dl>
    ///</td> <td width="60%"> Set <b>lpClass</b>[0] to GCPCLASS_POSTBOUNDLTR to bind the string to left-to-right reading
    ///order after the string. </td> </tr> <tr> <td width="40%"><a id="GCPCLASS_POSTBOUNDRTL"></a><a
    ///id="gcpclass_postboundrtl"></a><dl> <dt><b>GCPCLASS_POSTBOUNDRTL</b></dt> </dl> </td> <td width="60%"> Set
    ///<b>lpClass</b>[0] to GCPCLASS_POSTBOUNDRTL to bind the string to right-to-left reading order after the string.
    ///</td> </tr> </table> To force the layout of a character to be carried out in a specific way, preset the
    ///classification for the corresponding array element; the function leaves such preset classifications unchanged and
    ///computes classifications only for array elements that have been set to zero. Preset classifications are used only
    ///if the GCP_CLASSIN flag is set and the <b>lpClass</b> array is supplied. If GetFontLanguageInfo does not return
    ///GCP_REORDER for the current font, only the GCPCLASS_LATIN value is meaningful.
    const(char)*  lpClass;
    ///A pointer to the array that receives the values identifying the glyphs used for rendering the string or is
    ///<b>NULL</b> if glyph rendering is not needed. The number of glyphs in the array may be less than the number of
    ///characters in the original string if the string contains ligated glyphs. Also if reordering is required, the
    ///order of the glyphs may not be sequential. This array is useful if more than one operation is being done on a
    ///string which has any form of ligation, kerning or order-switching. Using the values in this array for subsequent
    ///operations saves the time otherwise required to generate the glyph indices each time. This array always contains
    ///glyph indices and the ETO_GLYPH_INDEX value must always be used when this array is used with the ExtTextOut
    ///function. When GCP_LIGATE is used, you can limit the number of characters that will be ligated together. (In
    ///Arabic for example, three-character ligations are common). This is done by setting the maximum required in
    ///lpGcpResults-&gt;lpGlyphs[0]. If no maximum is required, you should set this field to zero. For languages such as
    ///Arabic, where GetFontLanguageInfo returns the GCP_GLYPHSHAPE flag, the glyphs for a character will be different
    ///depending on whether the character is at the beginning, middle, or end of a word. Typically, the first character
    ///in the input string will also be the first character in a word, and the last character in the input string will
    ///be treated as the last character in a word. However, if the displayed string is a subset of the complete string,
    ///such as when displaying a section of scrolled text, this may not be true. In these cases, it is desirable to
    ///force the first or last characters to be shaped as not being initial or final forms. To do this, again, the first
    ///location in the <b>lpGlyphs</b> array is used by performing an OR operation of the ligation value above with the
    ///values GCPGLYPH_LINKBEFORE and/or GCPGLYPH_LINKAFTER. For example, a value of GCPGLYPH_LINKBEFORE | 2 means that
    ///two-character ligatures are the maximum required, and the first character in the string should be treated as if
    ///it is in the middle of a word.
    const(wchar)* lpGlyphs;
    ///On input, this member must be set to the size of the arrays pointed to by the array pointer members. On output,
    ///this is set to the number of glyphs filled in, in the output arrays. If glyph substitution is not required (that
    ///is, each input character maps to exactly one glyph), this member is the same as it is on input.
    uint          nGlyphs;
    ///The number of characters that fit within the extents specified by the <i>nMaxExtent</i> parameter of the
    ///GetCharacterPlacement function. If the GCP_MAXEXTENT or GCP_JUSTIFY value is set, this value may be less than the
    ///number of characters in the original string. This member is set regardless of whether the GCP_MAXEXTENT or
    ///GCP_JUSTIFY value is specified. Unlike <b>nGlyphs</b>, which specifies the number of output glyphs,
    ///<b>nMaxFit</b> refers to the number of characters from the input string. For Latin SBCS languages, this will be
    ///the same.
    int           nMaxFit;
}

///The <b>RASTERIZER_STATUS</b> structure contains information about whether TrueType is installed. This structure is
///filled when an application calls the GetRasterizerCaps function.
struct RASTERIZER_STATUS
{
    ///The size, in bytes, of the <b>RASTERIZER_STATUS</b> structure.
    short nSize;
    ///Specifies whether at least one TrueType font is installed and whether TrueType is enabled. This value is
    ///TT_AVAILABLE, TT_ENABLED, or both if TrueType is on the system.
    short wFlags;
    ///The language in the system's Setup.inf file.
    short nLanguageID;
}

///The <b>WCRANGE</b> structure specifies a range of Unicode characters.
struct WCRANGE
{
    ///Low Unicode code point in the range of supported Unicode code points.
    ushort wcLow;
    ///Number of supported Unicode code points in this range.
    ushort cGlyphs;
}

///The <b>GLYPHSET</b> structure contains information about a range of Unicode code points.
struct GLYPHSET
{
    ///The size, in bytes, of this structure.
    uint       cbThis;
    ///Flags describing the maximum size of the glyph indices. This member can be the following value. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td>GS_8BIT_INDICES</td> <td>Treat glyph indices as 8-bit wide values.
    ///Otherwise, they are 16-bit wide values.</td> </tr> </table>
    uint       flAccel;
    ///The total number of Unicode code points supported in the font.
    uint       cGlyphsSupported;
    ///The total number of Unicode ranges in <b>ranges</b>.
    uint       cRanges;
    ///Array of Unicode ranges that are supported in the font.
    WCRANGE[1] ranges;
}

///The <b>DESIGNVECTOR</b> structure is used by an application to specify values for the axes of a multiple master font.
struct DESIGNVECTOR
{
    ///Reserved. Must be STAMP_DESIGNVECTOR.
    uint    dvReserved;
    ///Number of values in the <b>dvValues</b> array.
    uint    dvNumAxes;
    ///An array specifying the values of the axes of a multiple master OpenType font. This array corresponds to the
    ///<b>axlAxisInfo</b> array in the AXESLIST structure.
    int[16] dvValues;
}

///The <b>AXISINFO</b> structure contains information about an axis of a multiple master font.
struct AXISINFOA
{
    ///The minimum value for this axis.
    int       axMinValue;
    ///The maximum value for this axis.
    int       axMaxValue;
    ///The name of the axis, specified as an array of characters.
    ubyte[16] axAxisName;
}

///The <b>AXISINFO</b> structure contains information about an axis of a multiple master font.
struct AXISINFOW
{
    ///The minimum value for this axis.
    int        axMinValue;
    ///The maximum value for this axis.
    int        axMaxValue;
    ///The name of the axis, specified as an array of characters.
    ushort[16] axAxisName;
}

///The <b>AXESLIST</b> structure contains information on all the axes of a multiple master font.
struct AXESLISTA
{
    ///Reserved. Must be STAMP_AXESLIST.
    uint          axlReserved;
    ///Number of axes for a specified multiple master font.
    uint          axlNumAxes;
    ///An array of AXISINFO structures. Each <b>AXISINFO</b> structure contains information on an axis of a specified
    ///multiple master font. This corresponds to the <b>dvValues</b> array in the DESIGNVECTOR structure.
    AXISINFOA[16] axlAxisInfo;
}

///The <b>AXESLIST</b> structure contains information on all the axes of a multiple master font.
struct AXESLISTW
{
    ///Reserved. Must be STAMP_AXESLIST.
    uint          axlReserved;
    ///Number of axes for a specified multiple master font.
    uint          axlNumAxes;
    ///An array of AXISINFO structures. Each <b>AXISINFO</b> structure contains information on an axis of a specified
    ///multiple master font. This corresponds to the <b>dvValues</b> array in the DESIGNVECTOR structure.
    AXISINFOW[16] axlAxisInfo;
}

///The <b>ENUMLOGFONTEXDV</b> structure contains the information used to create a font.
struct ENUMLOGFONTEXDVA
{
    ///An ENUMLOGFONTEX structure that contains information about the logical attributes of the font.
    ENUMLOGFONTEXA elfEnumLogfontEx;
    ///A DESIGNVECTOR structure. This is zero-filled unless the font described is a multiple master OpenType font.
    DESIGNVECTOR   elfDesignVector;
}

///The <b>ENUMLOGFONTEXDV</b> structure contains the information used to create a font.
struct ENUMLOGFONTEXDVW
{
    ///An ENUMLOGFONTEX structure that contains information about the logical attributes of the font.
    ENUMLOGFONTEXW elfEnumLogfontEx;
    ///A DESIGNVECTOR structure. This is zero-filled unless the font described is a multiple master OpenType font.
    DESIGNVECTOR   elfDesignVector;
}

///The <b>ENUMTEXTMETRIC</b> structure contains information about a physical font.
struct ENUMTEXTMETRICA
{
    ///A NEWTEXTMETRICEX structure, containing information about a physical font.
    NEWTEXTMETRICEXA etmNewTextMetricEx;
    ///An AXESLIST structure, containing information about the axes for the font. This is only used for multiple master
    ///fonts.
    AXESLISTA        etmAxesList;
}

///The <b>ENUMTEXTMETRIC</b> structure contains information about a physical font.
struct ENUMTEXTMETRICW
{
    ///A NEWTEXTMETRICEX structure, containing information about a physical font.
    NEWTEXTMETRICEXW etmNewTextMetricEx;
    ///An AXESLIST structure, containing information about the axes for the font. This is only used for multiple master
    ///fonts.
    AXESLISTW        etmAxesList;
}

///The <b>TRIVERTEX</b> structure contains color information and position information.
struct TRIVERTEX
{
    ///The x-coordinate, in logical units, of the upper-left corner of the rectangle.
    int    x;
    ///The y-coordinate, in logical units, of the upper-left corner of the rectangle.
    int    y;
    ///The color information at the point of x, y.
    ushort Red;
    ///The color information at the point of x, y.
    ushort Green;
    ///The color information at the point of x, y.
    ushort Blue;
    ///The color information at the point of x, y.
    ushort Alpha;
}

///The <b>GRADIENT_TRIANGLE</b> structure specifies the index of three vertices in the <i>pVertex</i> array in the
///<b>GradientFill</b> function. These three vertices form one triangle.
struct GRADIENT_TRIANGLE
{
    ///The first point of the triangle where sides intersect.
    uint Vertex1;
    ///The second point of the triangle where sides intersect.
    uint Vertex2;
    ///The third point of the triangle where sides intersect.
    uint Vertex3;
}

///The <b>GRADIENT_RECT</b> structure specifies the index of two vertices in the <i>pVertex</i> array in the
///<b>GradientFill</b> function. These two vertices form the upper-left and lower-right boundaries of a rectangle.
struct GRADIENT_RECT
{
    ///The upper-left corner of a rectangle.
    uint UpperLeft;
    ///The lower-right corner of a rectangle.
    uint LowerRight;
}

///The <b>BLENDFUNCTION</b> structure controls blending by specifying the blending functions for source and destination
///bitmaps.
struct BLENDFUNCTION
{
    ///The source blend operation. Currently, the only source and destination blend operation that has been defined is
    ///AC_SRC_OVER. For details, see the following Remarks section.
    ubyte BlendOp;
    ///Must be zero.
    ubyte BlendFlags;
    ///Specifies an alpha transparency value to be used on the entire source bitmap. The <b>SourceConstantAlpha</b>
    ///value is combined with any per-pixel alpha values in the source bitmap. If you set <b>SourceConstantAlpha</b> to
    ///0, it is assumed that your image is transparent. Set the <b>SourceConstantAlpha</b> value to 255 (opaque) when
    ///you only want to use per-pixel alpha values.
    ubyte SourceConstantAlpha;
    ///This member controls the way the source and destination bitmaps are interpreted. <b>AlphaFormat</b> has the
    ///following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>AC_SRC_ALPHA</td> <td>This flag is
    ///set when the bitmap has an Alpha channel (that is, per-pixel alpha). Note that the APIs use premultiplied alpha,
    ///which means that the red, green and blue channel values in the bitmap must be premultiplied with the alpha
    ///channel value. For example, if the alpha channel value is x, the red, green and blue channels must be multiplied
    ///by x and divided by 0xff prior to the call.</td> </tr> </table>
    ubyte AlphaFormat;
}

///The <b>DIBSECTION</b> structure contains information about a DIB created by calling the CreateDIBSection function. A
///<b>DIBSECTION</b> structure includes information about the bitmap's dimensions, color format, color masks, optional
///file mapping object, and optional bit values storage offset. An application can obtain a filled-in <b>DIBSECTION</b>
///structure for a given DIB by calling the GetObject function.
struct DIBSECTION
{
    ///A BITMAP data structure that contains information about the DIB: its type, its dimensions, its color capacities,
    ///and a pointer to its bit values.
    BITMAP           dsBm;
    ///A BITMAPINFOHEADER structure that contains information about the color format of the DIB.
    BITMAPINFOHEADER dsBmih;
    ///Specifies three color masks for the DIB. This field is only valid when the <b>BitCount</b> member of the
    ///BITMAPINFOHEADER structure has a value greater than 8. Each color mask indicates the bits that are used to encode
    ///one of the three color channels (red, green, and blue).
    uint[3]          dsBitfields;
    ///Contains a handle to the file mapping object that the CreateDIBSection function used to create the DIB. If
    ///<b>CreateDIBSection</b> was called with a <b>NULL</b> value for its <i>hSection</i> parameter, causing the system
    ///to allocate memory for the bitmap, the <i>dshSection</i> member will be <b>NULL</b>.
    HANDLE           dshSection;
    ///The offset to the bitmap's bit values within the file mapping object referenced by <i>dshSection</i>. If
    ///<i>dshSection</i> is <b>NULL</b>, the <i>dsOffset</i> value has no meaning.
    uint             dsOffset;
}

///The <b>COLORADJUSTMENT</b> structure defines the color adjustment values used by the StretchBlt and StretchDIBits
///functions when the stretch mode is HALFTONE. You can set the color adjustment values by calling the
///SetColorAdjustment function.
struct COLORADJUSTMENT
{
    ///The size, in bytes, of the structure.
    ushort caSize;
    ///Specifies how the output image should be prepared. This member may be set to <b>NULL</b> or any combination of
    ///the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>CA_NEGATIVE</td> <td>Specifies
    ///that the negative of the original image should be displayed.</td> </tr> <tr> <td>CA_LOG_FILTER</td> <td>Specifies
    ///that a logarithmic function should be applied to the final density of the output colors. This will increase the
    ///color contrast when the luminance is low.</td> </tr> </table>
    ushort caFlags;
    ///The type of standard light source under which the image is viewed. This member may be set to one of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>ILLUMINANT_DEVICE_DEFAULT</td> <td>Device's
    ///default. Standard used by output devices.</td> </tr> <tr> <td>ILLUMINANT_A</td> <td>Tungsten lamp.</td> </tr>
    ///<tr> <td>ILLUMINANT_B</td> <td>Noon sunlight.</td> </tr> <tr> <td>ILLUMINANT_C</td> <td>NTSC daylight.</td> </tr>
    ///<tr> <td>ILLUMINANT_D50</td> <td>Normal print.</td> </tr> <tr> <td>ILLUMINANT_D55</td> <td>Bond paper print.</td>
    ///</tr> <tr> <td>ILLUMINANT_D65</td> <td>Standard daylight. Standard for CRTs and pictures.</td> </tr> <tr>
    ///<td>ILLUMINANT_D75</td> <td>Northern daylight.</td> </tr> <tr> <td>ILLUMINANT_F2</td> <td>Cool white lamp.</td>
    ///</tr> <tr> <td>ILLUMINANT_TUNGSTEN</td> <td>Same as ILLUMINANT_A.</td> </tr> <tr> <td>ILLUMINANT_DAYLIGHT</td>
    ///<td>Same as ILLUMINANT_C.</td> </tr> <tr> <td>ILLUMINANT_FLUORESCENT</td> <td>Same as ILLUMINANT_F2.</td> </tr>
    ///<tr> <td>ILLUMINANT_NTSC</td> <td>Same as ILLUMINANT_C.</td> </tr> </table>
    ushort caIlluminantIndex;
    ///Specifies the <i>n</i><sup>th</sup> power gamma-correction value for the red primary of the source colors. The
    ///value must be in the range from 2500 to 65,000. A value of 10,000 means no gamma correction.
    ushort caRedGamma;
    ///Specifies the <i>n</i><sup>th</sup> power gamma-correction value for the green primary of the source colors. The
    ///value must be in the range from 2500 to 65,000. A value of 10,000 means no gamma correction.
    ushort caGreenGamma;
    ///Specifies the <i>n</i><sup>th</sup> power gamma-correction value for the blue primary of the source colors. The
    ///value must be in the range from 2500 to 65,000. A value of 10,000 means no gamma correction.
    ushort caBlueGamma;
    ///The black reference for the source colors. Any colors that are darker than this are treated as black. The value
    ///must be in the range from 0 to 4000.
    ushort caReferenceBlack;
    ///The white reference for the source colors. Any colors that are lighter than this are treated as white. The value
    ///must be in the range from 6000 to 10,000.
    ushort caReferenceWhite;
    ///The amount of contrast to be applied to the source object. The value must be in the range from -100 to 100. A
    ///value of 0 means no contrast adjustment.
    short  caContrast;
    ///The amount of brightness to be applied to the source object. The value must be in the range from -100 to 100. A
    ///value of 0 means no brightness adjustment.
    short  caBrightness;
    ///The amount of colorfulness to be applied to the source object. The value must be in the range from -100 to 100. A
    ///value of 0 means no colorfulness adjustment.
    short  caColorfulness;
    ///The amount of red or green tint adjustment to be applied to the source object. The value must be in the range
    ///from -100 to 100. Positive numbers adjust toward red and negative numbers adjust toward green. Zero means no tint
    ///adjustment.
    short  caRedGreenTint;
}

///The <b>KERNINGPAIR</b> structure defines a kerning pair.
struct KERNINGPAIR
{
    ///The character code for the first character in the kerning pair.
    ushort wFirst;
    ///The character code for the second character in the kerning pair.
    ushort wSecond;
    ///The amount this pair will be kerned if they appear side by side in the same font and size. This value is
    ///typically negative, because pair kerning usually results in two characters being set more tightly than normal.
    ///The value is specified in logical units; that is, it depends on the current mapping mode.
    int    iKernAmount;
}

///The <b>EMR</b> structure provides the base structure for all enhanced metafile records. An enhanced metafile record
///contains the parameters for a specific GDI function used to create part of a picture in an enhanced format metafile.
struct EMR
{
    ///The record type. The parameter can be one of the following (with a link to the associated record structure).
    ///EMR_ABORTPATH EMR_ALPHABLEND EMR_ANGLEARC EMR_ARC EMR_ARCTO EMR_BEGINPATH EMR_BITBLT EMR_CHORD EMR_CLOSEFIGURE
    ///EMR_COLORCORRECTPALETTE EMR_COLORMATCHTOTARGETW EMR_CREATEBRUSHINDIRECT EMR_CREATECOLORSPACE
    ///EMR_CREATECOLORSPACEW EMR_CREATEDIBPATTERNBRUSHPT EMR_CREATEMONOBRUSH EMR_CREATEPALETTE EMR_CREATEPEN
    ///EMR_DELETECOLORSPACE EMR_DELETEOBJECT EMR_ELLIPSE EMR_ENDPATH EMR_EOF EMR_EXCLUDECLIPRECT
    ///EMR_EXTCREATEFONTINDIRECTW EMR_EXTCREATEPEN EMR_EXTFLOODFILL EMR_EXTSELECTCLIPRGN EMR_EXTTEXTOUTA EMR_EXTTEXTOUTW
    ///EMR_FILLPATH EMR_FILLRGN EMR_FLATTENPATH EMR_FRAMERGN EMR_GDICOMMENT EMR_GLSBOUNDEDRECORD EMR_GLSRECORD
    ///EMR_GRADIENTFILL EMR_INTERSECTCLIPRECT EMR_INVERTRGN EMR_LINETO EMR_MASKBLT EMR_MODIFYWORLDTRANSFORM EMR_MOVETOEX
    ///EMR_OFFSETCLIPRGN EMR_PAINTRGN EMR_PIE EMR_PIXELFORMAT EMR_PLGBLT EMR_POLYBEZIER EMR_POLYBEZIER16
    ///EMR_POLYBEZIERTO EMR_POLYBEZIERTO16 EMR_POLYDRAW EMR_POLYDRAW16 EMR_POLYGON EMR_POLYGON16 EMR_POLYLINE
    ///EMR_POLYLINE16 EMR_POLYLINETO EMR_POLYLINETO16 EMR_POLYPOLYGON EMR_POLYPOLYGON16 EMR_POLYPOLYLINE
    ///EMR_POLYPOLYLINE16 EMR_POLYTEXTOUTA EMR_POLYTEXTOUTW EMR_REALIZEPALETTE EMR_RECTANGLE EMR_RESIZEPALETTE
    ///EMR_RESTOREDC EMR_ROUNDRECT EMR_SAVEDC EMR_SCALEVIEWPORTEXTEX EMR_SCALEWINDOWEXTEX EMR_SELECTCLIPPATH
    ///EMR_SELECTOBJECT EMR_SELECTPALETTE EMR_SETARCDIRECTION EMR_SETBKCOLOR EMR_SETBKMODE EMR_SETBRUSHORGEX
    ///EMR_SETCOLORADJUSTMENT EMR_SETCOLORSPACE EMR_SETDIBITSTODEVICE EMR_SETICMMODE EMR_SETICMPROFILEA
    ///EMR_SETICMPROFILEW EMR_SETLAYOUT EMR_SETMAPMODE EMR_SETMAPPERFLAGS EMR_SETMETARGN EMR_SETMITERLIMIT
    ///EMR_SETPALETTEENTRIES EMR_SETPIXELV EMR_SETPOLYFILLMODE EMR_SETROP2 EMR_SETSTRETCHBLTMODE EMR_SETTEXTALIGN
    ///EMR_SETTEXTCOLOR EMR_SETVIEWPORTEXTEX EMR_SETVIEWPORTORGEX EMR_SETWINDOWEXTEX EMR_SETWINDOWORGEX
    ///EMR_SETWORLDTRANSFORM EMR_STRETCHBLT EMR_STRETCHDIBITS EMR_STROKEANDFILLPATH EMR_STROKEPATH EMR_TRANSPARENTBLT
    ///EMR_WIDENPATH
    uint iType;
    ///The size of the record, in bytes. This member must be a multiple of four.
    uint nSize;
}

///The <b>EMRTEXT</b> structure contains members for text output.
struct EMRTEXT
{
    ///The logical coordinates of the reference point used to position the string.
    POINTL ptlReference;
    ///The number of characters in the string.
    uint   nChars;
    ///The offset to the string.
    uint   offString;
    ///A value that indicates how to use the application-defined rectangle. This member can be a combination of the
    ///ETO_CLIPPED and ETO_OPAQUE values.
    uint   fOptions;
    ///An optional clipping and/or opaquing rectangle, in logical units.
    RECTL  rcl;
    ///The offset to the intercharacter spacing array.
    uint   offDx;
}

struct ABORTPATH
{
    EMR emr;
}

///Contains parameters for the SelectClipPath, SetBkMode, SetMapMode, SetPolyFillMode, SetROP2, SetStretchBltMode,
///SetTextAlign, SetICMMode , and SetLayout enhanced metafile records.
struct EMRSELECTCLIPPATH
{
    ///The base structure for all record types.
    EMR  emr;
    ///A value and meaning that varies depending on the function contained in the enhanced metafile record. For a
    ///description of this member, see the documentation of the functions contained in this record.
    uint iMode;
}

///The <b>EMRSETMITERLIMIT</b> structure contains members for the <b>SetMiterLimit</b> enhanced metafile record.
struct EMRSETMITERLIMIT
{
    ///The base structure for all record types.
    EMR   emr;
    ///New miter limit.
    float eMiterLimit;
}

///The <b>EMRRESTOREDC</b> structure contains members for the <b>RestoreDC</b> enhanced metafile record.
struct EMRRESTOREDC
{
    ///The base structure for all record types.
    EMR emr;
    ///Relative instance to restore.
    int iRelative;
}

///The <b>EMRSETARCDIRECTION</b> structure contains members for the <b>SetArcDirection</b> enhanced metafile record.
struct EMRSETARCDIRECTION
{
    ///The base structure for all record types.
    EMR  emr;
    ///Arc direction. This member can be either the AD_CLOCKWISE or AD_COUNTERCLOCKWISE value.
    uint iArcDirection;
}

///The <b>EMRSETMAPPERFLAGS</b> structure contains members for the <b>SetMapperFlags</b> enhanced metafile record.
struct EMRSETMAPPERFLAGS
{
    ///The base structure for all record types.
    EMR  emr;
    ///Font mapper flag.
    uint dwFlags;
}

struct EMRSETTEXTCOLOR
{
    EMR  emr;
    uint crColor;
}

///The <b>EMRSELECTOBJECT</b> and <b>EMRDELETEOBJECT</b> structures contain members for the <b>SelectObject</b> and
///<b>DeleteObject</b> enhanced metafile records.
struct EMRSELECTOBJECT
{
    ///The base structure for all record types.
    EMR  emr;
    ///The index of an object in the handle table.
    uint ihObject;
}

///The <b>EMRSELECTPALETTE</b> structure contains members for the SelectPalette enhanced metafile record. Note that the
///<i>bForceBackground</i> parameter in <b>SelectPalette</b> is always recorded as <b>TRUE</b>, which causes the palette
///to be realized as a background palette.
struct EMRSELECTPALETTE
{
    ///The base structure for all record types.
    EMR  emr;
    ///Index to logical palette in the handle table.
    uint ihPal;
}

///The <b>EMRRESIZEPALETTE</b> structure contains members for the <b>ResizePalette</b> enhanced metafile record.
struct EMRRESIZEPALETTE
{
    ///The base structure for all record types.
    EMR  emr;
    ///Index of the palette in the handle table.
    uint ihPal;
    ///Number of entries in palette after resizing.
    uint cEntries;
}

///The <b>EMRSETPALETTEENTRIES</b> structure contains members for the SetPaletteEntries enhanced metafile record.
struct EMRSETPALETTEENTRIES
{
    ///The base structure for all record types.
    EMR             emr;
    ///Palette handle index.
    uint            ihPal;
    ///Index of first entry to set.
    uint            iStart;
    ///Number of entries.
    uint            cEntries;
    ///Array of PALETTEENTRY structures. Note that <b>peFlags</b> members in the structures do not contain any flags.
    PALETTEENTRY[1] aPalEntries;
}

///The <b>EMRSETCOLORADJUSTMENT</b> structure contains members for the <b>SetColorAdjustment</b> enhanced metafile
///record.
struct EMRSETCOLORADJUSTMENT
{
    ///The base structure for all record types.
    EMR             emr;
    ///A COLORADJUSTMENT structure.
    COLORADJUSTMENT ColorAdjustment;
}

///The <b>EMRGDICOMMENT</b> structure contains application-specific data. This enhanced metafile record is only
///meaningful to applications that know the format of the data and how to utilize it. This record is ignored by graphics
///device interface (GDI) during playback of the enhanced metafile.
struct EMRGDICOMMENT
{
    ///The base structure for all record types.
    EMR      emr;
    ///Size of data buffer, in bytes.
    uint     cbData;
    ///Application-specific data.
    ubyte[1] Data;
}

///The <b>EMREOF</b> structure contains data for the enhanced metafile record that indicates the end of the metafile.
struct EMREOF
{
    ///The base structure for all record types.
    EMR  emr;
    ///The number of palette entries.
    uint nPalEntries;
    ///The offset, in bytes, to an array of PALETTEENTRY structures.
    uint offPalEntries;
    ///The same size as the <b>nSize</b> member of the EMR structure. This member must be the last double word of the
    ///record. If palette entries exist, they precede this member.
    uint nSizeLast;
}

///The <b>EMRLINETO</b> and <b>EMRMOVETOEX</b> structures contains members for the LineTo and MoveToEx enhanced metafile
///records.
struct EMRLINETO
{
    ///Base structure for all record types.
    EMR    emr;
    ///Coordinates of the line's ending point for the LineTo function or coordinates of the new current position for the
    ///MoveToEx function in logical units.
    POINTL ptl;
}

///The <b>EMROFFSETCLIPRGN</b> structure contains members for the <b>OffsetClipRgn</b> enhanced metafile record.
struct EMROFFSETCLIPRGN
{
    ///The base structure for all record types.
    EMR    emr;
    ///The logical coordinates of offset.
    POINTL ptlOffset;
}

///The <b>EMRFILLPATH</b>, <b>EMRSTROKEANDFILLPATH</b>, and <b>EMRSTROKEPATH</b> structures contain members for the
///FillPath, StrokeAndFillPath, and StrokePath enhanced metafile records.
struct EMRFILLPATH
{
    ///Base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in device units.
    RECTL rclBounds;
}

///The <b>EMREXCLUDECLIPRECT</b> and <b>EMRINTERSECTCLIPRECT</b> structures contain members for the ExcludeClipRect and
///IntersectClipRect enhanced metafile records.
struct EMREXCLUDECLIPRECT
{
    ///Base structure for all record types.
    EMR   emr;
    ///Clipping rectangle in logical units.
    RECTL rclClip;
}

///The <b>EMRSETVIEWPORTORGEX, </b><b>EMRSETWINDOWORGEX, </b> and <b>EMRSETBRUSHORGEX</b> structures contain members for
///the <b>SetViewportOrgEx</b>, <b>SetWindowOrgEx</b>, and <b>SetBrushOrgEx</b> enhanced metafile records.
struct EMRSETVIEWPORTORGEX
{
    ///Base structure for all record types.
    EMR    emr;
    ///Coordinates of the origin. For <b>EMRSETVIEWPORTORGEX</b> and <b>EMRSETBRUSHORGEX</b>, this is in device units.
    ///For <b>EMRSETWINDOWORGEX</b>, this is in logical units.
    POINTL ptlOrigin;
}

///The <b>EMRSETVIEWPORTEXTEX</b> and <b>EMRSETWINDOWEXTEX</b> structures contains members for the
///<b>SetViewportExtEx</b> and <b>SetWindowExtEx</b> enhanced metafile records.
struct EMRSETVIEWPORTEXTEX
{
    ///Base structure for all record types.
    EMR  emr;
    ///Horizontal and vertical extents. For <b>SetViewportExtEx</b>, the extents are in device units, and for
    ///<b>SetWindowExtEx</b>, the extents are in logical units.
    SIZE szlExtent;
}

///The <b>EMRSCALEVIEWPORTEXTEX</b> and <b>EMRSCALEWINDOWEXTEX</b> structures contain members for the ScaleViewportExtEx
///and ScaleWindowExtEx enhanced metafile records.
struct EMRSCALEVIEWPORTEXTEX
{
    ///Base structure for all record types.
    EMR emr;
    ///Horizontal multiplicand.
    int xNum;
    ///Horizontal divisor.
    int xDenom;
    ///Vertical multiplicand.
    int yNum;
    ///Vertical divisor.
    int yDenom;
}

///The <b>EMRSETWORLDTRANSFORM</b> structure contains members for the <b>SetWorldTransform</b> enhanced metafile record.
struct EMRSETWORLDTRANSFORM
{
    ///The base structure for all record types.
    EMR   emr;
    ///World-space to page-space transformation data.
    XFORM xform;
}

///The <b>EMRMODIFYWORLDTRANSFORM</b> structure contains members for the ModifyWorldTransform enhanced metafile record.
struct EMRMODIFYWORLDTRANSFORM
{
    ///The base structure for all record types.
    EMR   emr;
    ///The world-space to page-space transform data.
    XFORM xform;
    ///Indicates how the transformation data modifies the current world transformation. This member can be one of the
    ///following values: MWT_IDENTITY, MWT_LEFTMULTIPLY, or MWT_RIGHTMULTIPLY.
    uint  iMode;
}

///The <b>EMRSETPIXELV</b> structure contains members for the SetPixelV enhanced metafile record. When an enhanced
///metafile is created, calls to SetPixel are also recorded in this record.
struct EMRSETPIXELV
{
    ///The base structure for all record types.
    EMR    emr;
    ///Logical coordinates of pixel.
    POINTL ptlPixel;
    ///Color value. To make a COLORREF value, use the RGB macro.
    uint   crColor;
}

///The <b>EMREXTFLOODFILL</b> structure contains members for the ExtFloodFill enhanced metafile record.
struct EMREXTFLOODFILL
{
    ///The base structure for all record types.
    EMR    emr;
    ///Coordinates, in logical units, where filling begins.
    POINTL ptlStart;
    ///Color of fill. To make a COLORREF value, use the RGB macro.
    uint   crColor;
    ///Type of fill operation to be performed. This member must be either the FLOODFILLBORDER or FLOODFILLSURFACE value.
    uint   iMode;
}

///The <b>EMRELLIPSE</b> and <b>EMRRECTANGLE</b> structures contain members for the Ellipse and Rectangle enhanced
///metafile records.
struct EMRELLIPSE
{
    ///Base structure for all record types.
    EMR   emr;
    ///Bounding rectangle in logical units.
    RECTL rclBox;
}

///The <b>EMRROUNDRECT</b> structure contains members for the <b>RoundRect</b> enhanced metafile record.
struct EMRROUNDRECT
{
    ///The base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in logical units.
    RECTL rclBox;
    ///Width and height, in logical units, of the ellipse used to draw rounded corners.
    SIZE  szlCorner;
}

///The <b>EMRARC, </b><b>EMRARCTO, </b><b>EMRCHORD, </b> and <b>EMRPIE</b> structures contain members for the Arc,
///ArcTo, Chord, and Pie enhanced metafile records.
struct EMRARC
{
    ///Base structure for all record types.
    EMR    emr;
    ///Bounding rectangle in logical units.
    RECTL  rclBox;
    ///Coordinates of first radial ending point in logical units.
    POINTL ptlStart;
    ///Coordinates of second radial ending point in logical units.
    POINTL ptlEnd;
}

///The <b>EMRANGLEARC</b> structure contains members for the AngleArc enhanced metafile record.
struct EMRANGLEARC
{
    ///The base structure for all record types.
    EMR    emr;
    ///Logical coordinates of a circle's center.
    POINTL ptlCenter;
    ///A circle's radius, in logical units.
    uint   nRadius;
    ///An arc's start angle, in degrees.
    float  eStartAngle;
    ///An arc's sweep angle, in degrees.
    float  eSweepAngle;
}

///The <b>EMRPOLYLINE, </b><b>EMRPOLYBEZIER, </b><b>EMRPOLYGON, </b><b>EMRPOLYBEZIERTO, </b> and <b>EMRPOLYLINETO</b>
///structures contain members for the Polyline, PolyBezier, Polygon, PolyBezierTo, and PolylineTo enhanced metafile
///records.
struct EMRPOLYLINE
{
    ///Base structure for all record types.
    EMR       emr;
    ///Bounding rectangle, in device units.
    RECTL     rclBounds;
    ///Number of points array.
    uint      cptl;
    ///Array of 32-bit points, in logical units.
    POINTL[1] aptl;
}

///The <b>EMRPOLYLINE16, </b><b>EMRPOLYBEZIER16, </b><b>EMRPOLYGON16, </b><b>EMRPOLYBEZIERTO16, </b> and
///<b>EMRPOLYLINETO16</b> structures contain members for the Polyline, PolyBezier, Polygon, PolyBezierTo, and PolylineTo
///enhanced metafile records.
struct EMRPOLYLINE16
{
    ///Base structure for all record types.
    EMR       emr;
    ///Bounding rectangle, in device units.
    RECTL     rclBounds;
    ///Number of points in the array.
    uint      cpts;
    ///Array of 16-bit points, in logical units.
    POINTS[1] apts;
}

///The <b>EMRPOLYDRAW</b> structure contains members for the PolyDraw enhanced metafile record.
struct EMRPOLYDRAW
{
    ///The base structure for all record types.
    EMR       emr;
    ///The bounding rectangle, in device units.
    RECTL     rclBounds;
    ///The number of points.
    uint      cptl;
    ///An array of POINTL structures, representing the data points in logical units.
    POINTL[1] aptl;
    ///An array of values that specifies how each point in the <b>aptl</b> array is used. Each element can be one of the
    ///following values: PT_MOVETO, PT_LINETO, or PT_BEZIERTO. The PT_LINETO or PT_BEZIERTO value can be combined with
    ///the PT_CLOSEFIGURE value using the bitwise-OR operator.
    ubyte[1]  abTypes;
}

///The <b>EMRPOLYDRAW16</b> structure contains members for the PolyDraw enhanced metafile record.
struct EMRPOLYDRAW16
{
    ///The base structure for all record types.
    EMR       emr;
    ///The bounding rectangle, in device units.
    RECTL     rclBounds;
    ///The number of points.
    uint      cpts;
    ///An array of POINTS structures, representing the data points in logical units.
    POINTS[1] apts;
    ///An array of values that specifies how each point in the <b>apts</b> array is used. Each element can be one of the
    ///following values: PT_MOVETO, PT_LINETO, or PT_BEZIERTO. The PT_LINETO or PT_BEZIERTO value can be combined with
    ///the PT_CLOSEFIGURE value using the bitwise-OR operator.
    ubyte[1]  abTypes;
}

///The <b>EMRPOLYPOLYLINE</b> and <b>EMRPOLYPOLYGON</b> structures contain members for the PolyPolyline and PolyPolygon
///enhanced metafile records.
struct EMRPOLYPOLYLINE
{
    ///The base structure for all record types.
    EMR       emr;
    ///The bounding rectangle, in device units.
    RECTL     rclBounds;
    ///The number of polys.
    uint      nPolys;
    ///The total number of points in all polys.
    uint      cptl;
    ///An array of point counts for each poly.
    uint[1]   aPolyCounts;
    ///An array of POINTL structures, representing the points in logical units.
    POINTL[1] aptl;
}

///The <b>EMRPOLYPOLYLINE16</b> and <b>EMRPOLYPOLYGON16</b> structures contain members for the PolyPolyline and
///PolyPolygon enhanced metafile records.
struct EMRPOLYPOLYLINE16
{
    ///The base structure for all record types.
    EMR       emr;
    ///The bounding rectangle, in device units.
    RECTL     rclBounds;
    ///The number of polys.
    uint      nPolys;
    ///The total number of points in all polys.
    uint      cpts;
    ///An array of point counts for each poly.
    uint[1]   aPolyCounts;
    ///An array of POINTS structures, representing the points in logical units.
    POINTS[1] apts;
}

///The <b>EMRINVERTRGN</b> and <b>EMRPAINTRGN</b> structures contain members for the InvertRgn and PaintRgn enhanced
///metafile records.
struct EMRINVERTRGN
{
    ///Base structure for all record types.
    EMR      emr;
    ///Bounding rectangle, in device units.
    RECTL    rclBounds;
    ///Size of region data, in bytes.
    uint     cbRgnData;
    ///Buffer containing an RGNDATA structure.
    ubyte[1] RgnData;
}

///The <b>EMRFILLRGN</b> structure contains members for the FillRgn enhanced metafile record.
struct EMRFILLRGN
{
    ///The base structure for all record types.
    EMR      emr;
    ///Bounding rectangle, in device units.
    RECTL    rclBounds;
    ///Size of region data, in bytes.
    uint     cbRgnData;
    ///Index of brush, in handle table.
    uint     ihBrush;
    ///Buffer containing RGNDATA structure.
    ubyte[1] RgnData;
}

///The <b>EMRFRAMERGN</b> structure contains members for the FrameRgn enhanced metafile record.
struct EMRFRAMERGN
{
    ///The base structure for all record types.
    EMR      emr;
    ///Bounding rectangle, in device units.
    RECTL    rclBounds;
    ///Size of region data, in bytes.
    uint     cbRgnData;
    ///Index of brush, in handle table.
    uint     ihBrush;
    ///Width and height of region frame, in logical units.
    SIZE     szlStroke;
    ///Buffer containing RGNDATA structure.
    ubyte[1] RgnData;
}

///The <b>EMREXTSELECTCLIPRGN</b> structure contains members for the ExtSelectClipRgn enhanced metafile record.
struct EMREXTSELECTCLIPRGN
{
    ///The base structure for all record types.
    EMR      emr;
    ///Size of region data, in bytes.
    uint     cbRgnData;
    ///Operation to be performed. This member must be one of the following values: RGN_AND, RGN_COPY, RGN_DIFF, RGN_OR,
    ///or RGN_XOR.
    uint     iMode;
    ///Buffer containing a RGNDATA structure.
    ubyte[1] RgnData;
}

///The <b>EMREXTTEXTOUTA</b> and <b>EMREXTTEXTOUTW</b> structures contain members for the ExtTextOut, TextOut, or
///DrawText enhanced metafile records.
struct EMREXTTEXTOUTA
{
    ///Base structure for all record types.
    EMR     emr;
    ///Bounding rectangle, in device units.
    RECTL   rclBounds;
    ///Current graphics mode. This member can be either the GM_COMPATIBLE or GM_ADVANCED value.
    uint    iGraphicsMode;
    ///X-scaling factor from page units to .01mm units if the graphics mode is the GM_COMPATIBLE value.
    float   exScale;
    ///Y-scaling factor from page units to .01mm units if the graphics mode is the GM_COMPATIBLE value.
    float   eyScale;
    ///<b>EMRTEXT</b> structure, which is followed by the string and the intercharacter spacing array.
    EMRTEXT emrtext;
}

///The <b>EMRPOLYTEXTOUTA</b> and <b>EMRPOLYTEXTOUTW</b> structures contain members for the <b>PolyTextOut</b> enhanced
///metafile record.
struct EMRPOLYTEXTOUTA
{
    ///Base structure for all record types.
    EMR        emr;
    ///Bounding rectangle, in device units.
    RECTL      rclBounds;
    ///Current graphics mode. This member can be either the GM_COMPATIBLE or GM_ADVANCED value.
    uint       iGraphicsMode;
    ///X-scaling factor from page units to .01mm units if the graphics mode is the GM_COMPATIBLE value.
    float      exScale;
    ///Y-scaling factor from page units to .01mm units if the graphics mode is the GM_COMPATIBLE value.
    float      eyScale;
    ///Number of strings.
    int        cStrings;
    ///<b>EMRTEXT</b> structure, which is followed by the string and the intercharacter spacing array.
    EMRTEXT[1] aemrtext;
}

///The <b>EMRBITBLT</b> structure contains members for the BitBlt enhanced metafile record. Note that graphics device
///interface (GDI) converts the device-dependent bitmap into a device-independent bitmap (DIB) before storing it in the
///metafile record.
struct EMRBITBLT
{
    ///The base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in device units.
    RECTL rclBounds;
    ///Logical x-coordinate of the upper-left corner of the destination rectangle.
    int   xDest;
    ///Logical y-coordinate of the upper-left corner of the destination rectangle.
    int   yDest;
    ///Logical width of the destination rectangle.
    int   cxDest;
    ///Logical height of the destination rectangle.
    int   cyDest;
    ///Raster-operation code. These codes define how the color data of the source rectangle is to be combined with the
    ///color data of the destination rectangle to achieve the final color.
    uint  dwRop;
    ///Logical x-coordinate of the upper-left corner of the source rectangle.
    int   xSrc;
    ///Logical y-coordinate of the upper-left corner of the source rectangle.
    int   ySrc;
    ///World-space to page-space transformation of the source device context.
    XFORM xformSrc;
    ///Background color (the RGB value) of the source device context. To make a COLORREF value, use the RGB macro.
    uint  crBkColorSrc;
    ///Value of the <b>bmiColors</b> member of the BITMAPINFO structure. The <b>iUsageSrc</b> member can be either the
    ///DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint  iUsageSrc;
    ///Offset to source BITMAPINFO structure.
    uint  offBmiSrc;
    ///Size of source BITMAPINFO structure.
    uint  cbBmiSrc;
    ///Offset to source bitmap bits.
    uint  offBitsSrc;
    ///Size of source bitmap bits.
    uint  cbBitsSrc;
}

///The <b>EMRSTRETCHBLT</b> structure contains members for the StretchBlt enhanced metafile record. Note that graphics
///device interface (GDI) converts the device-dependent bitmap into a device-independent bitmap (DIB) before storing it
///in the metafile record.
struct EMRSTRETCHBLT
{
    ///The base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in device units.
    RECTL rclBounds;
    ///Logical x-coordinate of the upper-left corner of the destination rectangle.
    int   xDest;
    ///Logical y-coordinate of the upper-left corner of the destination rectangle.
    int   yDest;
    ///Logical width of the destination rectangle.
    int   cxDest;
    ///Logical height of the destination rectangle.
    int   cyDest;
    ///Raster-operation code. These codes define how the color data of the source rectangle is to be combined with the
    ///color data of the destination rectangle to achieve the final color.
    uint  dwRop;
    ///Logical x-coordinate of the upper-left corner of the source rectangle.
    int   xSrc;
    ///Logical y-coordinate of the upper-left corner of the source rectangle.
    int   ySrc;
    ///World-space to page-space transformation of the source device context.
    XFORM xformSrc;
    ///Background color (the RGB value) of the source device context. To make a COLORREF value, use the RGB macro.
    uint  crBkColorSrc;
    ///Value of the <b>bmiColors</b> member of the BITMAPINFO structure. The <b>iUsageSrc</b> member can be either the
    ///DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint  iUsageSrc;
    ///Offset to the source BITMAPINFO structure.
    uint  offBmiSrc;
    ///Size of the source BITMAPINFO structure.
    uint  cbBmiSrc;
    ///Offset to source bitmap bits.
    uint  offBitsSrc;
    ///Size of source bitmap bits.
    uint  cbBitsSrc;
    ///Width of the source rectangle, in logical units.
    int   cxSrc;
    ///Height of the source rectangle, in logical units.
    int   cySrc;
}

///The <b>EMRMASKBLT</b> structure contains members for the MaskBlt enhanced metafile record. Note that graphics device
///interface (GDI) converts the device-dependent bitmap into a device-independent bitmap (DIB) before storing it in the
///metafile record.
struct EMRMASKBLT
{
    ///The base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in device units.
    RECTL rclBounds;
    ///Logical x-coordinate of the upper-left corner of the destination rectangle.
    int   xDest;
    ///Logical y-coordinate of the upper-left corner of the destination rectangle.
    int   yDest;
    ///Logical width of the destination rectangle.
    int   cxDest;
    ///Logical height of the destination rectangle.
    int   cyDest;
    ///Raster-operation code. These codes define how the color data of the source rectangle is to be combined with the
    ///color data of the destination rectangle to achieve the final color.
    uint  dwRop;
    ///Logical x-coordinate of the upper-left corner of the source rectangle.
    int   xSrc;
    ///Logical y-coordinate of the upper-left corner of the source rectangle.
    int   ySrc;
    ///World-space to page-space transformation of the source device context.
    XFORM xformSrc;
    ///Background color (the RGB value) of the source device context. To make a COLORREF value, use the RGB macro.
    uint  crBkColorSrc;
    ///Value of the <b>bmiColors</b> member of the source BITMAPINFO structure. The <b>iUsageSrc</b> member can be
    ///either the DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint  iUsageSrc;
    ///Offset to source BITMAPINFO structure.
    uint  offBmiSrc;
    ///Size of source BITMAPINFO structure.
    uint  cbBmiSrc;
    ///Offset to source bitmap bits.
    uint  offBitsSrc;
    ///Size of source bitmap bits.
    uint  cbBitsSrc;
    ///Horizontal pixel offset into mask bitmap.
    int   xMask;
    ///Vertical pixel offset into mask bitmap.
    int   yMask;
    ///Value of the <b>bmiColors</b> member of the mask BITMAPINFO structure.
    uint  iUsageMask;
    ///Offset to mask BITMAPINFO structure.
    uint  offBmiMask;
    ///Size of mask BITMAPINFO structure.
    uint  cbBmiMask;
    ///Offset to mask bitmap bits.
    uint  offBitsMask;
    ///Size of mask bitmap bits.
    uint  cbBitsMask;
}

///The <b>EMRPLGBLT</b> structure contains members for the PlgBlt enhanced metafile record. Note that graphics device
///interface (GDI) converts the device-dependent bitmap into a device-independent bitmap (DIB) before storing it in the
///metafile record.
struct EMRPLGBLT
{
    ///The base structure for all record types.
    EMR       emr;
    ///Bounding rectangle, in device units.
    RECTL     rclBounds;
    ///Array of three points in logical space that identify three corners of the destination parallelogram. The
    ///upper-left corner of the source rectangle is mapped to the first point in this array, the upper-right corner to
    ///the second point in this array, and the lower-left corner to the third point. The lower-right corner of the
    ///source rectangle is mapped to the implicit fourth point in the parallelogram.
    POINTL[3] aptlDest;
    ///Logical x-coordinate of the upper-left corner of the source rectangle.
    int       xSrc;
    ///Logical y-coordinate of the upper-left corner of the source rectangle.
    int       ySrc;
    ///Logical width of the source.
    int       cxSrc;
    ///Logical height of the source.
    int       cySrc;
    ///World-space to page-space transformation of the source device context.
    XFORM     xformSrc;
    ///Background color (the RGB value) of the source device context. To make a COLORREF value, use the RGB macro.
    uint      crBkColorSrc;
    ///Value of the <b>bmiColors</b> member of the BITMAPINFO structure. The <b>iUsageSrc</b> member can be either the
    ///DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint      iUsageSrc;
    ///Offset to source BITMAPINFO structure.
    uint      offBmiSrc;
    ///Size of source BITMAPINFO structure.
    uint      cbBmiSrc;
    ///Offset to source bitmap bits.
    uint      offBitsSrc;
    ///Size of source bitmap bits.
    uint      cbBitsSrc;
    ///Horizontal pixel offset into mask bitmap.
    int       xMask;
    ///Vertical pixel offset into mask bitmap.
    int       yMask;
    ///Value of the <b>bmiColors</b> member of the mask BITMAPINFO structure.
    uint      iUsageMask;
    ///Offset to mask BITMAPINFO structure.
    uint      offBmiMask;
    ///Size of mask BITMAPINFO structure.
    uint      cbBmiMask;
    ///Offset to mask bitmap bits.
    uint      offBitsMask;
    ///Size of mask bitmap bits.
    uint      cbBitsMask;
}

///The <b>EMRSETDIBITSTODEVICE</b> structure contains members for the SetDIBitsToDevice enhanced metafile record.
struct EMRSETDIBITSTODEVICE
{
    ///The base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in device units.
    RECTL rclBounds;
    ///Logical x-coordinate of the upper-left corner of the destination rectangle.
    int   xDest;
    ///Logical y-coordinate of the upper-left corner of the destination rectangle.
    int   yDest;
    ///Logical x-coordinate of the lower-left corner of the source device-independent bitmap (DIB).
    int   xSrc;
    ///Logical y-coordinate of the lower-left corner of the source DIB.
    int   ySrc;
    ///Width of the source rectangle, in logical units.
    int   cxSrc;
    ///Height of the source rectangle, in logical units.
    int   cySrc;
    ///Offset to the source BITMAPINFO structure.
    uint  offBmiSrc;
    ///Size of the source BITMAPINFO structure.
    uint  cbBmiSrc;
    ///Offset to source bitmap bits.
    uint  offBitsSrc;
    ///Size of source bitmap bits.
    uint  cbBitsSrc;
    ///Value of the <b>bmiColors</b> member of the BITMAPINFO structure. The <b>iUsageSrc</b> member can be either the
    ///DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint  iUsageSrc;
    ///First scan line in the array.
    uint  iStartScan;
    ///Number of scan lines.
    uint  cScans;
}

///The <b>EMRSTRETCHDIBITS</b> structure contains members for the StretchDIBits enhanced metafile record.
struct EMRSTRETCHDIBITS
{
    ///The base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in device units.
    RECTL rclBounds;
    ///Logical x-coordinate of the upper-left corner of the destination rectangle.
    int   xDest;
    ///Logical y-coordinate of the upper-left corner of the destination rectangle.
    int   yDest;
    ///Logical x-coordinate of the upper-left corner of the source rectangle.
    int   xSrc;
    ///Logical y-coordinate of the upper-left corner of the source rectangle.
    int   ySrc;
    ///Width of the source rectangle, in logical units.
    int   cxSrc;
    ///Height of the source rectangle, in logical units.
    int   cySrc;
    ///Offset to the source BITMAPINFO structure.
    uint  offBmiSrc;
    ///Size of the source BITMAPINFO structure.
    uint  cbBmiSrc;
    ///Offset to source bitmap bits.
    uint  offBitsSrc;
    ///Size of source bitmap bits.
    uint  cbBitsSrc;
    ///Value of the <b>bmiColors</b> member of the BITMAPINFO structure. The <b>iUsageSrc</b> member can be either the
    ///DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint  iUsageSrc;
    ///Raster-operation code. These codes define how the color data of the source rectangle is to be combined with the
    ///color data of the destination rectangle to achieve the final color.
    uint  dwRop;
    ///Logical width of the destination rectangle.
    int   cxDest;
    ///Logical height of the destination rectangle.
    int   cyDest;
}

///The <b>EMREXTCREATEFONTINDIRECTW</b> structure contains members for the CreateFontIndirect enhanced metafile record.
struct EMREXTCREATEFONTINDIRECTW
{
    ///The base structure for all record types.
    EMR         emr;
    ///Index to the font in handle table.
    uint        ihFont;
    ///Logical font.
    EXTLOGFONTW elfw;
}

///The <b>EMRCREATEPALETTE</b> structure contains members for the CreatePalette enhanced metafile record.
struct EMRCREATEPALETTE
{
    ///The base structure for all record types.
    EMR        emr;
    ///Index of palette in handle table.
    uint       ihPal;
    ///A LOGPALETTE structure that contains information about the palette. Note that <b>peFlags</b> members in the
    ///PALETTEENTRY structures do not contain any flags.
    LOGPALETTE lgpl;
}

///The <b>EMRCREATEPEN</b> structure contains members for the <b>CreatePen</b> enhanced metafile record.
struct EMRCREATEPEN
{
    ///The base structure for all record types.
    EMR    emr;
    ///Index to pen in handle table.
    uint   ihPen;
    ///Logical pen.
    LOGPEN lopn;
}

///The <b>EMREXTCREATEPEN</b> structure contains members for the ExtCreatePen enhanced metafile record. If the record
///contains a BITMAPINFO structure, it is followed by the bitmap bits that form a packed device-independent bitmap
///(DIB).
struct EMREXTCREATEPEN
{
    ///The base structure for all record types.
    EMR         emr;
    ///Index to pen in handle table.
    uint        ihPen;
    ///Offset to BITMAPINFO structure, if any.
    uint        offBmi;
    ///Size of BITMAPINFO structure, if any.
    uint        cbBmi;
    ///Offset to brush bitmap bits, if any.
    uint        offBits;
    ///Size of brush bitmap bits, if any.
    uint        cbBits;
    ///Extended logical pen, including the <b>elpStyleEntry</b> member of the EXTLOGPEN structure.
    EXTLOGPEN32 elp;
}

///The <b>EMRCREATEBRUSHINDIRECT</b> structure contains members for the CreateBrushIndirect enhanced metafile record.
struct EMRCREATEBRUSHINDIRECT
{
    ///The base structure for all record types.
    EMR        emr;
    ///Index of brush in handle table.
    uint       ihBrush;
    ///A LOGBRUSH32 structure containing information about the brush. The <b>lbStyle</b> member must be either the
    ///BS_SOLID, BS_HOLLOW, BS_NULL, or BS_HATCHED value. Note, that if your code is used on both 32-bit and 64-bit
    ///platforms, you must use the LOGBRUSH32 structure. This maintains compatibility between the platforms when you
    ///record the metafile on one platform and use it on the other platform. If your code remains on one platform, it is
    ///sufficient to use LOGBRUSH.
    LOGBRUSH32 lb;
}

///The <b>EMRCREATEMONOBRUSH</b> structure contains members for the CreatePatternBrush (when passed a monochrome bitmap)
///or CreateDIBPatternBrush (when passed a monochrome DIB) enhanced metafile records.
struct EMRCREATEMONOBRUSH
{
    ///The base structure for all record types.
    EMR  emr;
    ///Index of brush in handle table.
    uint ihBrush;
    ///Value specifying whether the <b>bmiColors</b> member of the BITMAPINFO structure was provided and, if so, whether
    ///<b>bmiColors</b> contains explicit red, green, blue (RGB) values or indices. The <b>iUsage</b> member must be
    ///either the DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint iUsage;
    ///Offset to BITMAPINFO structure.
    uint offBmi;
    ///Size of BITMAPINFO structure.
    uint cbBmi;
    ///Offset to bitmap bits.
    uint offBits;
    ///Size of bitmap bits.
    uint cbBits;
}

///The <b>EMRCREATEDIBPATTERNBRUSHPT</b> structure contains members for the CreateDIBPatternBrushPt enhanced metafile
///record. The BITMAPINFO structure is followed by the bitmap bits that form a packed device-independent bitmap (DIB).
struct EMRCREATEDIBPATTERNBRUSHPT
{
    ///The base structure for all record types.
    EMR  emr;
    ///Index of brush in handle table.
    uint ihBrush;
    ///Value specifying whether the <b>bmiColors</b> member of the BITMAPINFO structure was provided and, if so, whether
    ///<b>bmiColors</b> contains explicit red, green, blue (RGB) values or indices. The <b>iUsage</b> member must be
    ///either the DIB_PAL_COLORS or DIB_RGB_COLORS value.
    uint iUsage;
    ///Offset to BITMAPINFO structure.
    uint offBmi;
    ///Size of BITMAPINFO structure.
    uint cbBmi;
    ///Offset to bitmap bits.
    uint offBits;
    ///Size of bitmap bits.
    uint cbBits;
}

///The <b>EMRFORMAT</b> structure contains information that identifies graphics data in an enhanced metafile. A
///GDICOMMENT_MULTIFORMATS enhanced metafile public comment contains an array of <b>EMRFORMAT</b> structures.
struct EMRFORMAT
{
    ///Contains a picture format identifier. The following identifier values are defined. <table> <tr>
    ///<th>Identifier</th> <th>Meaning</th> </tr> <tr> <td>ENHMETA_SIGNATURE</td> <td>The picture is in enhanced
    ///metafile format.</td> </tr> <tr> <td>EPS_SIGNATURE</td> <td>The picture is in encapsulated PostScript file
    ///format.</td> </tr> </table>
    uint dSignature;
    ///Contains a picture version number. The following version number value is defined. <table> <tr> <th>Version</th>
    ///<th>Meaning</th> </tr> <tr> <td>1</td> <td>This is the version number of a level 1 encapsulated PostScript
    ///file.</td> </tr> </table>
    uint nVersion;
    ///The size, in bytes, of the picture data.
    uint cbData;
    ///Specifies an offset to the picture data. The offset is figured from the start of the GDICOMMENT_MULTIFORMATS
    ///public comment within which this <b>EMRFORMAT</b> structure is embedded. The offset must be a <b>DWORD</b>
    ///offset.
    uint offData;
}

///The <b>EMRGLSRECORD</b> structure contains members for an enhanced metafile record generated by OpenGL functions. It
///contains data for OpenGL functions that scale automatically to the OpenGL viewport.
struct EMRGLSRECORD
{
    ///The base structure for all records.
    EMR      emr;
    ///Size of <b>Data</b>, in bytes.
    uint     cbData;
    ///Array of data representing the OpenGL function to be performed.
    ubyte[1] Data;
}

///The <b>EMRGLSBOUNDEDRECORD</b> structure contains members for an enhanced metafile record generated by OpenGL
///functions. It contains data for OpenGL functions with information in pixel units that must be scaled when playing the
///metafile.
struct EMRGLSBOUNDEDRECORD
{
    ///The base structure for all record types.
    EMR      emr;
    ///Bounds of the rectangle, in device coordinates, within which to perform the OpenGL function. For more
    ///information, see Remarks.
    RECTL    rclBounds;
    ///Size of <i>Data</i>, in bytes.
    uint     cbData;
    ///Array of data representing the OpenGL function to be performed.
    ubyte[1] Data;
}

///The <b>EMRPIXELFORMAT</b> structure contains the members for the SetPixelFormat enhanced metafile record. The pixel
///format information in ENHMETAHEADER refers to this structure.
struct EMRPIXELFORMAT
{
    ///The base structure for all record types.
    EMR emr;
    ///A PIXELFORMATDESCRIPTOR structure, which describes the pixel format.
    PIXELFORMATDESCRIPTOR pfd;
}

///The <b>EMRCREATECOLORSPACE</b> structure contains members for the <b>CreateColorSpace</b> enhanced metafile record.
struct EMRCREATECOLORSPACE
{
    ///The base structure for all record types.
    EMR            emr;
    ///The index of the color space in handle table.
    uint           ihCS;
    ///The logical color space.
    LOGCOLORSPACEA lcs;
}

///The <b>EMRSETCOLORSPACE</b>, <b>EMRSELECTCOLORSPACE</b>, and <b>EMRDELETECOLORSPACE</b> structures contain members
///for the <b>SetColorSpace</b> and <b>DeleteColorSpace</b> enhanced metafile records.
struct EMRSETCOLORSPACE
{
    ///Base structure for all record types.
    EMR  emr;
    ///Color space handle index.
    uint ihCS;
}

struct EMREXTESCAPE
{
    EMR      emr;
    int      iEscape;
    int      cbEscData;
    ubyte[1] EscData;
}

struct EMRNAMEDESCAPE
{
    EMR      emr;
    int      iEscape;
    int      cbDriver;
    int      cbEscData;
    ubyte[1] EscData;
}

///The <b>EMRSETICMPROFILE</b> structure contains members for the SetICMProfile enhanced metafile record.
struct EMRSETICMPROFILE
{
    ///The base structure for all record types.
    EMR      emr;
    ///The profile flags. This member can be SETICMPROFILE_EMBEDED (0x00000001).
    uint     dwFlags;
    ///The size of the desired profile name.
    uint     cbName;
    ///The size of profile data, if attached.
    uint     cbData;
    ///An array that contains the profile data. The length of this array is <b>cbName</b> plus <b>cbData</b>.
    ubyte[1] Data;
}

///The <b>EMRCREATECOLORSPACEW</b> structure contains members for the CreateColorSpace enhanced metafile record. It
///differs from EMRCREATECOLORSPACE in that it has a Unicode logical color space and also has an optional array
///containing raw source profile data.
struct EMRCREATECOLORSPACEW
{
    ///The base structure for all record types.
    EMR            emr;
    ///Index of the color space in handle table.
    uint           ihCS;
    ///Logical color space. Note, this is the Unicode version of the structure.
    LOGCOLORSPACEW lcs;
    ///Can be the following. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>CREATECOLORSPACE_EMBEDED</td>
    ///<td>Indicates that a color space is embedded in the metafile.</td> </tr> </table>
    uint           dwFlags;
    ///Size of the raw source profile data in bytes, if it is attached.
    uint           cbData;
    ///An array containing the source profile data. The size of the array is <b>cbData</b>.
    ubyte[1]       Data;
}

struct COLORMATCHTOTARGET
{
    EMR      emr;
    uint     dwAction;
    uint     dwFlags;
    uint     cbName;
    uint     cbData;
    ubyte[1] Data;
}

struct COLORCORRECTPALETTE
{
    EMR  emr;
    uint ihPalette;
    uint nFirstEntry;
    uint nPalEntries;
    uint nReserved;
}

///The <b>EMRALPHABLEND</b> structure contains members for the AlphaBlend enhanced metafile record.
struct EMRALPHABLEND
{
    ///The base structure for all record types.
    EMR   emr;
    ///Bounding rectangle, in device units.
    RECTL rclBounds;
    ///The x coordinate, in logical units, of the upper-left corner of the destination rectangle.
    int   xDest;
    ///The y coordinate, in logical units, of the upper-left corner of the destination rectangle.
    int   yDest;
    ///Logical width of the destination rectangle.
    int   cxDest;
    ///Logical height of the destination rectangle.
    int   cyDest;
    ///Stores the BLENDFUNCTION structure.
    uint  dwRop;
    ///Logical x coordinate of the upper-left corner of the source rectangle.
    int   xSrc;
    ///Logical y coordinate of the upper-left corner of the source rectangle.
    int   ySrc;
    ///World-space to page-space transformation of the source device context.
    XFORM xformSrc;
    ///Background color (the RGB value) of the source device context. To make a COLORREF value, use the RGB macro.
    uint  crBkColorSrc;
    ///Source bitmap information color table usage (DIB_RGB_COLORS).
    uint  iUsageSrc;
    ///Offset to the source BITMAPINFO structure.
    uint  offBmiSrc;
    ///Size of the source BITMAPINFO structure.
    uint  cbBmiSrc;
    ///Offset to the source bitmap bits.
    uint  offBitsSrc;
    ///Size of the source bitmap bits.
    uint  cbBitsSrc;
    ///Width of source rectangle in logical units.
    int   cxSrc;
    ///Height of the source rectangle in logical units.
    int   cySrc;
}

///The <b>EMRGRADIENTFILL</b> structure contains members for the GradientFill enhanced metafile record.
struct EMRGRADIENTFILL
{
    ///The base structure for all record types.
    EMR          emr;
    ///The bounding rectangle, in device units.
    RECTL        rclBounds;
    ///The number of vertices.
    uint         nVer;
    ///The number of rectangles or triangles to be passed to GradientFill.
    uint         nTri;
    ///The gradient fill mode. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_RECT_H"></a><a
    ///id="gradient_fill_rect_h"></a><dl> <dt><b>GRADIENT_FILL_RECT_H</b></dt> </dl> </td> <td width="60%"> In this
    ///mode, two endpoints describe a rectangle. The rectangle is defined to have a constant color (specified by the
    ///TRIVERTEX structure) for the left and right edges. GDI interpolates the color from the left to right edge and
    ///fills the interior. </td> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_RECT_V"></a><a
    ///id="gradient_fill_rect_v"></a><dl> <dt><b>GRADIENT_FILL_RECT_V</b></dt> </dl> </td> <td width="60%"> In this
    ///mode, two endpoints describe a rectangle. The rectangle is defined to have a constant color (specified by the
    ///TRIVERTEX structure) for the top and bottom edges. GDI interpolates the color from the top to bottom edge and
    ///fills the interior. </td> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_TRIANGLE"></a><a
    ///id="gradient_fill_triangle"></a><dl> <dt><b>GRADIENT_FILL_TRIANGLE</b></dt> </dl> </td> <td width="60%"> In this
    ///mode, an array of TRIVERTEX structures is passed to GDI along with a list of array indexes that describe separate
    ///triangles. GDI performs linear interpolation between triangle vertices and fills the interior. Drawing is done
    ///directly in 24- and 32-bpp modes. Dithering is performed in 16-, 8-, 4-, and 1-bpp mode. </td> </tr> </table>
    uint         ulMode;
    ///An array of TRIVERTEX structures that each define a vertex.
    TRIVERTEX[1] Ver;
}

///The <b>EMRTRANSPARENTBLT</b> structure contains members for the TransparentBLT enhanced metafile record.
struct EMRTRANSPARENTBLT
{
    ///The base structure for all record types.
    EMR   emr;
    ///Inclusive bounds, in device units.
    RECTL rclBounds;
    ///Logical x coordinate of the upper-left corner of the destination rectangle.
    int   xDest;
    ///Logical y coordinate of the upper-left corner of the destination rectangle.
    int   yDest;
    ///Logical width of the destination rectangle.
    int   cxDest;
    ///Logical height of the destination rectangle.
    int   cyDest;
    ///Stores the transparent color.
    uint  dwRop;
    ///Logical x coordinate of the upper-left corner of the source rectangle.
    int   xSrc;
    ///Logical y coordinate of the upper-left corner of the source rectangle.
    int   ySrc;
    ///World-space to page-space transformation of the source device context.
    XFORM xformSrc;
    ///Background color (the RGB value) of the source device context. To make a COLORREF value, use the RGB macro.
    uint  crBkColorSrc;
    ///Source bitmap information color table usage (DIB_RGB_COLORS).
    uint  iUsageSrc;
    ///Offset to the source BITMAPINFO structure.
    uint  offBmiSrc;
    ///Size of the source BITMAPINFO structure.
    uint  cbBmiSrc;
    ///Offset to the source bitmap bits.
    uint  offBitsSrc;
    ///Size of the source bitmap bits.
    uint  cbBitsSrc;
    ///Width of the source rectangle, in logical units.
    int   cxSrc;
    ///Height of the source rectangle, in logical units.
    int   cySrc;
}

struct WGLSWAP
{
    HDC  hdc;
    uint uiFlags;
}

///The <b>TTLOADINFO</b> structure contains the URL from which the embedded font object has been obtained.
struct TTLOADINFO
{
    ///Size, in bytes, of this structure. The client should set this value to <b>sizeof</b>(TTLOADINFO).
    ushort  usStructSize;
    ///Size, in wide characters, of <i>pusRefStr</i>, including the terminating null character.
    ushort  usRefStrSize;
    ///Pointer to the string containing the current URL.
    ushort* pusRefStr;
}

///The <b>TTEMBEDINFO</b> structure contains a list of URLs from which the embedded font object may be legitimately
///referenced.
struct TTEMBEDINFO
{
    ///Size, in bytes, of this structure. The client should set this value to <b>sizeof</b>(TTEMBEDINFO).
    ushort  usStructSize;
    ///Size, in wide characters, of <i>pusRootStr</i> including NULL terminator(s).
    ushort  usRootStrSize;
    ///One or more full URLs that the embedded font object may be referenced from. Multiple URLs, separated by NULL
    ///terminators, can be specified.
    ushort* pusRootStr;
}

///The <b>TTVALIDATIONTESTSPARAMS</b> structure contains parameters for testing a Microsoft OpenType font.
struct TTVALIDATIONTESTSPARAMS
{
    ///Size, in bytes, of this structure. The client should set this value to <b>sizeof</b>(TTVALIDATIONTESTSPARAMS).
    uint    ulStructSize;
    ///First character point size to test. This value is the smallest font size (lower bound) of the font sizes to test.
    int     lTestFromSize;
    ///Last character point size to test. This value is an largest font size (upper bound) of the font sizes to test.
    int     lTestToSize;
    ///Flag specifying the character set of the font to validate. This flag can have one of the following values.
    ///<table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>CHARSET_UNICODE</td> <td>Unicode character set,
    ///requiring 16-bit-character encoding.</td> </tr> <tr> <td>CHARSET_SYMBOL</td> <td>Symbol character set, requiring
    ///16-bit-character encoding.</td> </tr> </table>
    uint    ulCharSet;
    ///Currently not used.
    ushort  usReserved1;
    ///If zero, test over all glyphs.
    ushort  usCharCodeCount;
    ///Pointer to array of Unicode characters.
    ushort* pusCharCodeSet;
}

///The <b>TTVALIDATIONTESTSPARAMSEX</b> structure contains parameters for testing a Microsoft OpenType font.
struct TTVALIDATIONTESTSPARAMSEX
{
    ///Size, in bytes, of this structure. The client should set this value to <b>sizeof</b>(TTVALIDATIONTESTSPARAMSEX).
    uint   ulStructSize;
    ///First character point size to test. This value is the smallest font size (lower bound) of the font sizes to test.
    int    lTestFromSize;
    ///Last character point size to test. This value is the largest font size (upper bound) to test.
    int    lTestToSize;
    ///Flag specifying the character set of the font to validate. This flag can have one of the following values.
    ///<table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>CHARSET_UNICODE</td> <td>Unicode character set,
    ///requiring 16-bit character encoding.</td> </tr> <tr> <td>CHARSET_SYMBOL</td> <td>Symbol character set, requiring
    ///16-bit character encoding.</td> </tr> </table>
    uint   ulCharSet;
    ///Currently not used.
    ushort usReserved1;
    ///If zero, test over all glyphs.
    ushort usCharCodeCount;
    ///Pointer to array of UCS-4 characters.
    uint*  pulCharCodeSet;
}

struct tagMxdcEscapeHeader
{
align (1):
    uint cbInput;
    uint cbOutput;
    uint opCode;
}

struct tagMxdcGetFileNameData
{
align (1):
    uint      cbOutput;
    ushort[1] wszData;
}

struct tagMxdcS0PageData
{
align (1):
    uint     dwSize;
    ubyte[1] bData;
}

struct tagMxdcXpsS0PageResource
{
align (1):
    uint       dwSize;
    uint       dwResourceType;
    ubyte[260] szUri;
    uint       dwDataSize;
    ubyte[1]   bData;
}

struct tagMxdcPrintTicketPassthrough
{
align (1):
    uint     dwDataSize;
    ubyte[1] bData;
}

struct tagMxdcPrintTicketEscape
{
    tagMxdcEscapeHeader mxdcEscape;
    tagMxdcPrintTicketPassthrough printTicketData;
}

struct tagMxdcS0PagePassthroughEscape
{
    tagMxdcEscapeHeader mxdcEscape;
    tagMxdcS0PageData   xpsS0PageData;
}

struct tagMxdcS0PageResourceEscape
{
    tagMxdcEscapeHeader mxdcEscape;
    tagMxdcXpsS0PageResource xpsS0PageResourcePassthrough;
}

alias HBITMAP = ptrdiff_t;

alias HBRUSH = ptrdiff_t;

alias HCOLORSPACE = ptrdiff_t;

alias HCURSOR = ptrdiff_t;

alias HDC = ptrdiff_t;

alias HdcMetdataEnhFileHandle = ptrdiff_t;

alias HdcMetdataFileHandle = ptrdiff_t;

alias HFONT = ptrdiff_t;

alias HICON = ptrdiff_t;

alias HPALETTE = ptrdiff_t;

alias HPEN = ptrdiff_t;

alias HRGN = ptrdiff_t;

///The <b>PAINTSTRUCT</b> structure contains information for an application. This information can be used to paint the
///client area of a window owned by that application.
struct PAINTSTRUCT
{
    ///A handle to the display DC to be used for painting.
    HDC       hdc;
    ///Indicates whether the background must be erased. This value is nonzero if the application should erase the
    ///background. The application is responsible for erasing the background if a window class is created without a
    ///background brush. For more information, see the description of the <b>hbrBackground</b> member of the WNDCLASS
    ///structure.
    BOOL      fErase;
    ///A RECT structure that specifies the upper left and lower right corners of the rectangle in which the painting is
    ///requested, in device units relative to the upper-left corner of the client area.
    RECT      rcPaint;
    ///Reserved; used internally by the system.
    BOOL      fRestore;
    ///Reserved; used internally by the system.
    BOOL      fIncUpdate;
    ///Reserved; used internally by the system.
    ubyte[32] rgbReserved;
}

///The <b>DRAWTEXTPARAMS</b> structure contains extended formatting options for the DrawTextEx function.
struct DRAWTEXTPARAMS
{
    ///The structure size, in bytes.
    uint cbSize;
    ///The size of each tab stop, in units equal to the average character width.
    int  iTabLength;
    ///The left margin, in units equal to the average character width.
    int  iLeftMargin;
    ///The right margin, in units equal to the average character width.
    int  iRightMargin;
    ///Receives the number of characters processed by DrawTextEx, including white-space characters. The number can be
    ///the length of the string or the index of the first line that falls below the drawing area. Note that
    ///<b>DrawTextEx</b> always processes the entire string if the DT_NOCLIP formatting flag is specified.
    uint uiLengthDrawn;
}

///The <b>MONITORINFO</b> structure contains information about a display monitor. The GetMonitorInfo function stores
///information in a <b>MONITORINFO</b> structure or a MONITORINFOEX structure. The <b>MONITORINFO</b> structure is a
///subset of the MONITORINFOEX structure. The <b>MONITORINFOEX</b> structure adds a string member to contain a name for
///the display monitor.
struct MONITORINFO
{
    ///The size of the structure, in bytes. Set this member to <code>sizeof ( MONITORINFO )</code> before calling the
    ///GetMonitorInfo function. Doing so lets the function determine the type of structure you are passing to it.
    uint cbSize;
    ///A RECT structure that specifies the display monitor rectangle, expressed in virtual-screen coordinates. Note that
    ///if the monitor is not the primary display monitor, some of the rectangle's coordinates may be negative values.
    RECT rcMonitor;
    ///A RECT structure that specifies the work area rectangle of the display monitor, expressed in virtual-screen
    ///coordinates. Note that if the monitor is not the primary display monitor, some of the rectangle's coordinates may
    ///be negative values.
    RECT rcWork;
    ///A set of flags that represent attributes of the display monitor. The following flag is defined. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td>MONITORINFOF_PRIMARY</td> <td>This is the primary display
    ///monitor.</td> </tr> </table>
    uint dwFlags;
}

///The <b>MONITORINFOEX</b> structure contains information about a display monitor. The GetMonitorInfo function stores
///information into a <b>MONITORINFOEX</b> structure or a MONITORINFO structure. The <b>MONITORINFOEX</b> structure is a
///superset of the MONITORINFO structure. The <b>MONITORINFOEX</b> structure adds a string member to contain a name for
///the display monitor.
struct MONITORINFOEXA
{
    MONITORINFO __AnonymousBase_winuser_L13554_C43;
    ///A string that specifies the device name of the monitor being used. Most applications have no use for a display
    ///monitor name, and so can save some bytes by using a MONITORINFO structure.
    byte[32]    szDevice;
}

///The <b>MONITORINFOEX</b> structure contains information about a display monitor. The GetMonitorInfo function stores
///information into a <b>MONITORINFOEX</b> structure or a MONITORINFO structure. The <b>MONITORINFOEX</b> structure is a
///superset of the MONITORINFO structure. The <b>MONITORINFOEX</b> structure adds a string member to contain a name for
///the display monitor.
struct MONITORINFOEXW
{
    MONITORINFO __AnonymousBase_winuser_L13558_C43;
    ///A string that specifies the device name of the monitor being used. Most applications have no use for a display
    ///monitor name, and so can save some bytes by using a MONITORINFO structure.
    ushort[32]  szDevice;
}

// Functions

///The <b>AddFontResource</b> function adds the font resource from the specified file to the system font table. The font
///can subsequently be used for text output by any application. To mark a font as private or not enumerable, use the
///AddFontResourceEx function.
///Params:
///    Arg1 = A pointer to a null-terminated character string that contains a valid font file name. This parameter can specify
///           any of the following files. <table> <tr> <th>File Extension</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id=".fon"></a><a id=".FON"></a><dl> <dt><b>.fon</b></dt> </dl> </td> <td width="60%"> Font resource file. </td>
///           </tr> <tr> <td width="40%"><a id=".fnt"></a><a id=".FNT"></a><dl> <dt><b>.fnt</b></dt> </dl> </td> <td
///           width="60%"> Raw bitmap font file. </td> </tr> <tr> <td width="40%"><a id=".ttf"></a><a id=".TTF"></a><dl>
///           <dt><b>.ttf</b></dt> </dl> </td> <td width="60%"> Raw TrueType file. </td> </tr> <tr> <td width="40%"><a
///           id=".ttc"></a><a id=".TTC"></a><dl> <dt><b>.ttc</b></dt> </dl> </td> <td width="60%"> East Asian Windows:
///           TrueType font collection. </td> </tr> <tr> <td width="40%"><a id=".fot"></a><a id=".FOT"></a><dl>
///           <dt><b>.fot</b></dt> </dl> </td> <td width="60%"> TrueType resource file. </td> </tr> <tr> <td width="40%"><a
///           id=".otf"></a><a id=".OTF"></a><dl> <dt><b>.otf</b></dt> </dl> </td> <td width="60%"> PostScript OpenType font.
///           </td> </tr> <tr> <td width="40%"><a id=".mmm"></a><a id=".MMM"></a><dl> <dt><b>.mmm</b></dt> </dl> </td> <td
///           width="60%"> Multiple master Type1 font resource file. It must be used with .pfm and .pfb files. </td> </tr> <tr>
///           <td width="40%"><a id=".pfb"></a><a id=".PFB"></a><dl> <dt><b>.pfb</b></dt> </dl> </td> <td width="60%"> Type 1
///           font bits file. It is used with a .pfm file. </td> </tr> <tr> <td width="40%"><a id=".pfm"></a><a
///           id=".PFM"></a><dl> <dt><b>.pfm</b></dt> </dl> </td> <td width="60%"> Type 1 font metrics file. It is used with a
///           .pfb file. </td> </tr> </table> To add a font whose information comes from several resource files, have
///           <i>lpszFileName</i> point to a string with the file names separated by a "|" --for example, abcxxxxx.pfm |
///           abcxxxxx.pfb.
///Returns:
///    If the function succeeds, the return value specifies the number of fonts added. If the function fails, the return
///    value is zero. No extended error information is available.
///    
@DllImport("GDI32")
int AddFontResourceA(const(char)* param0);

///The <b>AddFontResource</b> function adds the font resource from the specified file to the system font table. The font
///can subsequently be used for text output by any application. To mark a font as private or not enumerable, use the
///AddFontResourceEx function.
///Params:
///    Arg1 = A pointer to a null-terminated character string that contains a valid font file name. This parameter can specify
///           any of the following files. <table> <tr> <th>File Extension</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id=".fon"></a><a id=".FON"></a><dl> <dt><b>.fon</b></dt> </dl> </td> <td width="60%"> Font resource file. </td>
///           </tr> <tr> <td width="40%"><a id=".fnt"></a><a id=".FNT"></a><dl> <dt><b>.fnt</b></dt> </dl> </td> <td
///           width="60%"> Raw bitmap font file. </td> </tr> <tr> <td width="40%"><a id=".ttf"></a><a id=".TTF"></a><dl>
///           <dt><b>.ttf</b></dt> </dl> </td> <td width="60%"> Raw TrueType file. </td> </tr> <tr> <td width="40%"><a
///           id=".ttc"></a><a id=".TTC"></a><dl> <dt><b>.ttc</b></dt> </dl> </td> <td width="60%"> East Asian Windows:
///           TrueType font collection. </td> </tr> <tr> <td width="40%"><a id=".fot"></a><a id=".FOT"></a><dl>
///           <dt><b>.fot</b></dt> </dl> </td> <td width="60%"> TrueType resource file. </td> </tr> <tr> <td width="40%"><a
///           id=".otf"></a><a id=".OTF"></a><dl> <dt><b>.otf</b></dt> </dl> </td> <td width="60%"> PostScript OpenType font.
///           </td> </tr> <tr> <td width="40%"><a id=".mmm"></a><a id=".MMM"></a><dl> <dt><b>.mmm</b></dt> </dl> </td> <td
///           width="60%"> Multiple master Type1 font resource file. It must be used with .pfm and .pfb files. </td> </tr> <tr>
///           <td width="40%"><a id=".pfb"></a><a id=".PFB"></a><dl> <dt><b>.pfb</b></dt> </dl> </td> <td width="60%"> Type 1
///           font bits file. It is used with a .pfm file. </td> </tr> <tr> <td width="40%"><a id=".pfm"></a><a
///           id=".PFM"></a><dl> <dt><b>.pfm</b></dt> </dl> </td> <td width="60%"> Type 1 font metrics file. It is used with a
///           .pfb file. </td> </tr> </table> To add a font whose information comes from several resource files, have
///           <i>lpszFileName</i> point to a string with the file names separated by a "|" --for example, abcxxxxx.pfm |
///           abcxxxxx.pfb.
///Returns:
///    If the function succeeds, the return value specifies the number of fonts added. If the function fails, the return
///    value is zero. No extended error information is available.
///    
@DllImport("GDI32")
int AddFontResourceW(const(wchar)* param0);

///The <b>AnimatePalette</b> function replaces entries in the specified logical palette.
///Params:
///    hPal = A handle to the logical palette.
///    iStartIndex = The first logical palette entry to be replaced.
///    cEntries = The number of entries to be replaced.
///    ppe = A pointer to the first member in an array of PALETTEENTRY structures used to replace the current entries.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL AnimatePalette(HPALETTE hPal, uint iStartIndex, uint cEntries, char* ppe);

///The <b>Arc</b> function draws an elliptical arc.
///Params:
///    hdc = A handle to the device context where drawing takes place.
///    x1 = The x-coordinate, in logical units, of the upper-left corner of the bounding rectangle.
///    y1 = The y-coordinate, in logical units, of the upper-left corner of the bounding rectangle.
///    x2 = The x-coordinate, in logical units, of the lower-right corner of the bounding rectangle.
///    y2 = The y-coordinate, in logical units, of the lower-right corner of the bounding rectangle.
///    x3 = The x-coordinate, in logical units, of the ending point of the radial line defining the starting point of the
///         arc.
///    y3 = The y-coordinate, in logical units, of the ending point of the radial line defining the starting point of the
///         arc.
///    x4 = The x-coordinate, in logical units, of the ending point of the radial line defining the ending point of the arc.
///    y4 = The y-coordinate, in logical units, of the ending point of the radial line defining the ending point of the arc.
///Returns:
///    If the arc is drawn, the return value is nonzero. If the arc is not drawn, the return value is zero.
///    
@DllImport("GDI32")
BOOL Arc(HDC hdc, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);

///The <b>BitBlt</b> function performs a bit-block transfer of the color data corresponding to a rectangle of pixels
///from the specified source device context into a destination device context.
///Params:
///    hdc = A handle to the destination device context.
///    x = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    y = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    cx = The width, in logical units, of the source and destination rectangles.
///    cy = The height, in logical units, of the source and the destination rectangles.
///    hdcSrc = A handle to the source device context.
///    x1 = The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    y1 = The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    rop = A raster-operation code. These codes define how the color data for the source rectangle is to be combined with
///          the color data for the destination rectangle to achieve the final color. The following list shows some common
///          raster operation codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///          id="BLACKNESS"></a><a id="blackness"></a><dl> <dt><b>BLACKNESS</b></dt> </dl> </td> <td width="60%"> Fills the
///          destination rectangle using the color associated with index 0 in the physical palette. (This color is black for
///          the default physical palette.) </td> </tr> <tr> <td width="40%"><a id="CAPTUREBLT"></a><a
///          id="captureblt"></a><dl> <dt><b>CAPTUREBLT</b></dt> </dl> </td> <td width="60%"> Includes any windows that are
///          layered on top of your window in the resulting image. By default, the image only contains your window. Note that
///          this generally cannot be used for printing device contexts. </td> </tr> <tr> <td width="40%"><a
///          id="DSTINVERT"></a><a id="dstinvert"></a><dl> <dt><b>DSTINVERT</b></dt> </dl> </td> <td width="60%"> Inverts the
///          destination rectangle. </td> </tr> <tr> <td width="40%"><a id="MERGECOPY"></a><a id="mergecopy"></a><dl>
///          <dt><b>MERGECOPY</b></dt> </dl> </td> <td width="60%"> Merges the colors of the source rectangle with the brush
///          currently selected in <i>hdcDest</i>, by using the Boolean AND operator. </td> </tr> <tr> <td width="40%"><a
///          id="MERGEPAINT"></a><a id="mergepaint"></a><dl> <dt><b>MERGEPAINT</b></dt> </dl> </td> <td width="60%"> Merges
///          the colors of the inverted source rectangle with the colors of the destination rectangle by using the Boolean OR
///          operator. </td> </tr> <tr> <td width="40%"><a id="NOMIRRORBITMAP"></a><a id="nomirrorbitmap"></a><dl>
///          <dt><b>NOMIRRORBITMAP</b></dt> </dl> </td> <td width="60%"> Prevents the bitmap from being mirrored. </td> </tr>
///          <tr> <td width="40%"><a id="NOTSRCCOPY"></a><a id="notsrccopy"></a><dl> <dt><b>NOTSRCCOPY</b></dt> </dl> </td>
///          <td width="60%"> Copies the inverted source rectangle to the destination. </td> </tr> <tr> <td width="40%"><a
///          id="NOTSRCERASE"></a><a id="notsrcerase"></a><dl> <dt><b>NOTSRCERASE</b></dt> </dl> </td> <td width="60%">
///          Combines the colors of the source and destination rectangles by using the Boolean OR operator and then inverts
///          the resultant color. </td> </tr> <tr> <td width="40%"><a id="PATCOPY"></a><a id="patcopy"></a><dl>
///          <dt><b>PATCOPY</b></dt> </dl> </td> <td width="60%"> Copies the brush currently selected in <i>hdcDest</i>, into
///          the destination bitmap. </td> </tr> <tr> <td width="40%"><a id="PATINVERT"></a><a id="patinvert"></a><dl>
///          <dt><b>PATINVERT</b></dt> </dl> </td> <td width="60%"> Combines the colors of the brush currently selected in
///          <i>hdcDest</i>, with the colors of the destination rectangle by using the Boolean XOR operator. </td> </tr> <tr>
///          <td width="40%"><a id="PATPAINT"></a><a id="patpaint"></a><dl> <dt><b>PATPAINT</b></dt> </dl> </td> <td
///          width="60%"> Combines the colors of the brush currently selected in <i>hdcDest</i>, with the colors of the
///          inverted source rectangle by using the Boolean OR operator. The result of this operation is combined with the
///          colors of the destination rectangle by using the Boolean OR operator. </td> </tr> <tr> <td width="40%"><a
///          id="SRCAND"></a><a id="srcand"></a><dl> <dt><b>SRCAND</b></dt> </dl> </td> <td width="60%"> Combines the colors
///          of the source and destination rectangles by using the Boolean AND operator. </td> </tr> <tr> <td width="40%"><a
///          id="SRCCOPY"></a><a id="srccopy"></a><dl> <dt><b>SRCCOPY</b></dt> </dl> </td> <td width="60%"> Copies the source
///          rectangle directly to the destination rectangle. </td> </tr> <tr> <td width="40%"><a id="SRCERASE"></a><a
///          id="srcerase"></a><dl> <dt><b>SRCERASE</b></dt> </dl> </td> <td width="60%"> Combines the inverted colors of the
///          destination rectangle with the colors of the source rectangle by using the Boolean AND operator. </td> </tr> <tr>
///          <td width="40%"><a id="SRCINVERT"></a><a id="srcinvert"></a><dl> <dt><b>SRCINVERT</b></dt> </dl> </td> <td
///          width="60%"> Combines the colors of the source and destination rectangles by using the Boolean XOR operator.
///          </td> </tr> <tr> <td width="40%"><a id="SRCPAINT"></a><a id="srcpaint"></a><dl> <dt><b>SRCPAINT</b></dt> </dl>
///          </td> <td width="60%"> Combines the colors of the source and destination rectangles by using the Boolean OR
///          operator. </td> </tr> <tr> <td width="40%"><a id="WHITENESS"></a><a id="whiteness"></a><dl>
///          <dt><b>WHITENESS</b></dt> </dl> </td> <td width="60%"> Fills the destination rectangle using the color associated
///          with index 1 in the physical palette. (This color is white for the default physical palette.) </td> </tr>
///          </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("GDI32")
BOOL BitBlt(HDC hdc, int x, int y, int cx, int cy, HDC hdcSrc, int x1, int y1, uint rop);

///The <b>CancelDC</b> function cancels any pending operation on the specified device context (DC).
///Params:
///    hdc = A handle to the DC.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL CancelDC(HDC hdc);

///The <b>Chord</b> function draws a chord (a region bounded by the intersection of an ellipse and a line segment,
///called a secant). The chord is outlined by using the current pen and filled by using the current brush.
///Params:
///    hdc = A handle to the device context in which the chord appears.
///    x1 = The x-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
///    y1 = The y-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
///    x2 = The x-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
///    y2 = The y-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
///    x3 = The x-coordinate, in logical coordinates, of the endpoint of the radial defining the beginning of the chord.
///    y3 = The y-coordinate, in logical coordinates, of the endpoint of the radial defining the beginning of the chord.
///    x4 = The x-coordinate, in logical coordinates, of the endpoint of the radial defining the end of the chord.
///    y4 = The y-coordinate, in logical coordinates, of the endpoint of the radial defining the end of the chord.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL Chord(HDC hdc, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);

///The <b>CloseMetaFile</b> function closes a metafile device context and returns a handle that identifies a
///Windows-format metafile. <div class="alert"><b>Note</b> This function is provided only for compatibility with
///Windows-format metafiles. Enhanced-format metafiles provide superior functionality and are recommended for new
///applications. The corresponding function for an enhanced-format metafile is CloseEnhMetaFile.</div><div> </div>
///Params:
///    hdc = Handle to a metafile device context used to create a Windows-format metafile.
///Returns:
///    If the function succeeds, the return value is a handle to a Windows-format metafile. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t CloseMetaFile(HDC hdc);

///The <b>CombineRgn</b> function combines two regions and stores the result in a third region. The two regions are
///combined according to the specified mode.
///Params:
///    hrgnDst = A handle to a new region with dimensions defined by combining two other regions. (This region must exist before
///              <b>CombineRgn</b> is called.)
///    hrgnSrc1 = A handle to the first of two regions to be combined.
///    hrgnSrc2 = A handle to the second of two regions to be combined.
///    iMode = A mode indicating how the two regions will be combined. This parameter can be one of the following values.
///            <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RGN_AND"></a><a
///            id="rgn_and"></a><dl> <dt><b>RGN_AND</b></dt> </dl> </td> <td width="60%"> Creates the intersection of the two
///            combined regions. </td> </tr> <tr> <td width="40%"><a id="RGN_COPY"></a><a id="rgn_copy"></a><dl>
///            <dt><b>RGN_COPY</b></dt> </dl> </td> <td width="60%"> Creates a copy of the region identified by <i>hrgnSrc1</i>.
///            </td> </tr> <tr> <td width="40%"><a id="RGN_DIFF"></a><a id="rgn_diff"></a><dl> <dt><b>RGN_DIFF</b></dt> </dl>
///            </td> <td width="60%"> Combines the parts of <i>hrgnSrc1</i> that are not part of <i>hrgnSrc2</i>. </td> </tr>
///            <tr> <td width="40%"><a id="RGN_OR"></a><a id="rgn_or"></a><dl> <dt><b>RGN_OR</b></dt> </dl> </td> <td
///            width="60%"> Creates the union of two combined regions. </td> </tr> <tr> <td width="40%"><a id="RGN_XOR"></a><a
///            id="rgn_xor"></a><dl> <dt><b>RGN_XOR</b></dt> </dl> </td> <td width="60%"> Creates the union of two combined
///            regions except for any overlapping areas. </td> </tr> </table>
///Returns:
///    The return value specifies the type of the resulting region. It can be one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULLREGION</b></dt> </dl> </td>
///    <td width="60%"> The region is empty. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SIMPLEREGION</b></dt> </dl>
///    </td> <td width="60%"> The region is a single rectangle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> The region is more than a single rectangle. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> No region is created. </td>
///    </tr> </table>
///    
@DllImport("GDI32")
int CombineRgn(HRGN hrgnDst, HRGN hrgnSrc1, HRGN hrgnSrc2, int iMode);

///The <b>CopyMetaFile</b> function copies the content of a Windows-format metafile to the specified file. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is CopyEnhMetaFile.</div><div> </div>
///Params:
///    arg1 = A handle to the source Windows-format metafile.
///    arg2 = A pointer to the name of the destination file. If this parameter is <b>NULL</b>, the source metafile is copied to
///           memory.
///Returns:
///    If the function succeeds, the return value is a handle to the copy of the Windows-format metafile. If the
///    function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t CopyMetaFileA(ptrdiff_t param0, const(char)* param1);

///The <b>CopyMetaFile</b> function copies the content of a Windows-format metafile to the specified file. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is CopyEnhMetaFile.</div><div> </div>
///Params:
///    arg1 = A handle to the source Windows-format metafile.
///    arg2 = A pointer to the name of the destination file. If this parameter is <b>NULL</b>, the source metafile is copied to
///           memory.
///Returns:
///    If the function succeeds, the return value is a handle to the copy of the Windows-format metafile. If the
///    function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t CopyMetaFileW(ptrdiff_t param0, const(wchar)* param1);

///The <b>CreateBitmap</b> function creates a bitmap with the specified width, height, and color format (color planes
///and bits-per-pixel).
///Params:
///    nWidth = The bitmap width, in pixels.
///    nHeight = The bitmap height, in pixels.
///    nPlanes = The number of color planes used by the device.
///    nBitCount = The number of bits required to identify the color of a single pixel.
///    lpBits = A pointer to an array of color data used to set the colors in a rectangle of pixels. Each scan line in the
///             rectangle must be word aligned (scan lines that are not word aligned must be padded with zeros). If this
///             parameter is <b>NULL</b>, the contents of the new bitmap is undefined.
///Returns:
///    If the function succeeds, the return value is a handle to a bitmap. If the function fails, the return value is
///    <b>NULL</b>. This function can return the following value. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_BITMAP</b></dt> </dl> </td> <td width="60%"> The calculated
///    size of the bitmap is less than zero. </td> </tr> </table>
///    
@DllImport("GDI32")
HBITMAP CreateBitmap(int nWidth, int nHeight, uint nPlanes, uint nBitCount, const(void)* lpBits);

///The <b>CreateBitmapIndirect</b> function creates a bitmap with the specified width, height, and color format (color
///planes and bits-per-pixel).
///Params:
///    pbm = A pointer to a BITMAP structure that contains information about the bitmap. If an application sets the
///          <b>bmWidth</b> or <b>bmHeight</b> members to zero, <b>CreateBitmapIndirect</b> returns the handle to a 1-by-1
///          pixel, monochrome bitmap.
///Returns:
///    If the function succeeds, the return value is a handle to the bitmap. If the function fails, the return value is
///    <b>NULL</b>. This function can return the following values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The bitmap is too big for memory to be
///    allocated. </td> </tr> </table>
///    
@DllImport("GDI32")
HBITMAP CreateBitmapIndirect(const(BITMAP)* pbm);

///The <b>CreateBrushIndirect</b> function creates a logical brush that has the specified style, color, and pattern.
///Params:
///    plbrush = A pointer to a LOGBRUSH structure that contains information about the brush.
///Returns:
///    If the function succeeds, the return value identifies a logical brush. If the function fails, the return value is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
HBRUSH CreateBrushIndirect(const(LOGBRUSH)* plbrush);

///The <b>CreateCompatibleBitmap</b> function creates a bitmap compatible with the device that is associated with the
///specified device context.
///Params:
///    hdc = A handle to a device context.
///    cx = The bitmap width, in pixels.
///    cy = The bitmap height, in pixels.
///Returns:
///    If the function succeeds, the return value is a handle to the compatible bitmap (DDB). If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HBITMAP CreateCompatibleBitmap(HDC hdc, int cx, int cy);

///The <b>CreateDiscardableBitmap</b> function creates a discardable bitmap that is compatible with the specified
///device. The bitmap has the same bits-per-pixel format and the same color palette as the device. An application can
///select this bitmap as the current bitmap for a memory device that is compatible with the specified device. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should use the CreateCompatibleBitmap function.</div><div> </div>
///Params:
///    hdc = A handle to a device context.
///    cx = The width, in pixels, of the bitmap.
///    cy = The height, in pixels, of the bitmap.
///Returns:
///    If the function succeeds, the return value is a handle to the compatible bitmap (DDB). If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HBITMAP CreateDiscardableBitmap(HDC hdc, int cx, int cy);

///The <b>CreateCompatibleDC</b> function creates a memory device context (DC) compatible with the specified device.
///Params:
///    hdc = A handle to an existing DC. If this handle is <b>NULL</b>, the function creates a memory DC compatible with the
///          application's current screen.
///Returns:
///    If the function succeeds, the return value is the handle to a memory DC. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HDC CreateCompatibleDC(HDC hdc);

///The <b>CreateDC</b> function creates a device context (DC) for a device using the specified name.
///Params:
///    pwszDriver = A pointer to a null-terminated character string that specifies either DISPLAY or the name of a specific display
///                 device. For printing, we recommend that you pass <b>NULL</b> to <i>lpszDriver</i> because GDI ignores
///                 <i>lpszDriver</i> for printer devices.
///    pwszDevice = A pointer to a null-terminated character string that specifies the name of the specific output device being used,
///                 as shown by the Print Manager (for example, Epson FX-80). It is not the printer model name. The <i>lpszDevice</i>
///                 parameter must be used. To obtain valid names for displays, call EnumDisplayDevices. If <i>lpszDriver</i> is
///                 DISPLAY or the device name of a specific display device, then <i>lpszDevice</i> must be <b>NULL</b> or that same
///                 device name. If <i>lpszDevice</i> is <b>NULL</b>, then a DC is created for the primary display device. If there
///                 are multiple monitors on the system, calling <code>CreateDC(TEXT("DISPLAY"),NULL,NULL,NULL)</code> will create a
///                 DC covering all the monitors.
///    pszPort = This parameter is ignored and should be set to <b>NULL</b>. It is provided only for compatibility with 16-bit
///              Windows.
///    pdm = A pointer to a DEVMODE structure containing device-specific initialization data for the device driver. The
///          DocumentProperties function retrieves this structure filled in for a specified device. The <i>pdm</i> parameter
///          must be <b>NULL</b> if the device driver is to use the default initialization (if any) specified by the user. If
///          <i>lpszDriver</i> is DISPLAY, <i>pdm</i> must be <b>NULL</b>; GDI then uses the display device's current DEVMODE.
///Returns:
///    If the function succeeds, the return value is the handle to a DC for the specified device. If the function fails,
///    the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HDC CreateDCA(const(char)* pwszDriver, const(char)* pwszDevice, const(char)* pszPort, const(DEVMODEA)* pdm);

///The <b>CreateDC</b> function creates a device context (DC) for a device using the specified name.
///Params:
///    pwszDriver = A pointer to a null-terminated character string that specifies either DISPLAY or the name of a specific display
///                 device. For printing, we recommend that you pass <b>NULL</b> to <i>lpszDriver</i> because GDI ignores
///                 <i>lpszDriver</i> for printer devices.
///    pwszDevice = A pointer to a null-terminated character string that specifies the name of the specific output device being used,
///                 as shown by the Print Manager (for example, Epson FX-80). It is not the printer model name. The <i>lpszDevice</i>
///                 parameter must be used. To obtain valid names for displays, call EnumDisplayDevices. If <i>lpszDriver</i> is
///                 DISPLAY or the device name of a specific display device, then <i>lpszDevice</i> must be <b>NULL</b> or that same
///                 device name. If <i>lpszDevice</i> is <b>NULL</b>, then a DC is created for the primary display device. If there
///                 are multiple monitors on the system, calling <code>CreateDC(TEXT("DISPLAY"),NULL,NULL,NULL)</code> will create a
///                 DC covering all the monitors.
///    pszPort = This parameter is ignored and should be set to <b>NULL</b>. It is provided only for compatibility with 16-bit
///              Windows.
///    pdm = A pointer to a DEVMODE structure containing device-specific initialization data for the device driver. The
///          DocumentProperties function retrieves this structure filled in for a specified device. The <i>pdm</i> parameter
///          must be <b>NULL</b> if the device driver is to use the default initialization (if any) specified by the user. If
///          <i>lpszDriver</i> is DISPLAY, <i>pdm</i> must be <b>NULL</b>; GDI then uses the display device's current DEVMODE.
///Returns:
///    If the function succeeds, the return value is the handle to a DC for the specified device. If the function fails,
///    the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HDC CreateDCW(const(wchar)* pwszDriver, const(wchar)* pwszDevice, const(wchar)* pszPort, const(DEVMODEW)* pdm);

///The <b>CreateDIBitmap</b> function creates a compatible bitmap (DDB) from a DIB and, optionally, sets the bitmap
///bits.
///Params:
///    hdc = A handle to a device context.
///    pbmih = A pointer to a bitmap information header structure, BITMAPV5HEADER. If <i>fdwInit</i> is CBM_INIT, the function
///            uses the bitmap information header structure to obtain the desired width and height of the bitmap as well as
///            other information. Note that a positive value for the height indicates a bottom-up DIB while a negative value for
///            the height indicates a top-down DIB. Calling <b>CreateDIBitmap</b> with <i>fdwInit</i> as CBM_INIT is equivalent
///            to calling the CreateCompatibleBitmap function to create a DDB in the format of the device and then calling the
///            SetDIBits function to translate the DIB bits to the DDB.
///    flInit = Specifies how the system initializes the bitmap bits. The following value is defined. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CBM_INIT"></a><a id="cbm_init"></a><dl>
///             <dt><b>CBM_INIT</b></dt> </dl> </td> <td width="60%"> If this flag is set, the system uses the data pointed to by
///             the <i>lpbInit</i> and <i>lpbmi</i> parameters to initialize the bitmap bits. If this flag is clear, the data
///             pointed to by those parameters is not used. </td> </tr> </table> If <i>fdwInit</i> is zero, the system does not
///             initialize the bitmap bits.
///    pjBits = A pointer to an array of bytes containing the initial bitmap data. The format of the data depends on the
///             <b>biBitCount</b> member of the BITMAPINFO structure to which the <i>lpbmi</i> parameter points.
///    pbmi = A pointer to a BITMAPINFO structure that describes the dimensions and color format of the array pointed to by the
///           <i>lpbInit</i> parameter.
///    iUsage = Specifies whether the <b>bmiColors</b> member of the BITMAPINFO structure was initialized and, if so, whether
///             <b>bmiColors</b> contains explicit red, green, blue (RGB) values or palette indexes. The <i>fuUsage</i> parameter
///             must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="DIB_PAL_COLORS"></a><a id="dib_pal_colors"></a><dl> <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td> <td
///             width="60%"> A color table is provided and consists of an array of 16-bit indexes into the logical palette of the
///             device context into which the bitmap is to be selected. </td> </tr> <tr> <td width="40%"><a
///             id="DIB_RGB_COLORS"></a><a id="dib_rgb_colors"></a><dl> <dt><b>DIB_RGB_COLORS</b></dt> </dl> </td> <td
///             width="60%"> A color table is provided and contains literal RGB values. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a handle to the compatible bitmap. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HBITMAP CreateDIBitmap(HDC hdc, const(BITMAPINFOHEADER)* pbmih, uint flInit, const(void)* pjBits, 
                       const(BITMAPINFO)* pbmi, uint iUsage);

///The <b>CreateDIBPatternBrush</b> function creates a logical brush that has the pattern specified by the specified
///device-independent bitmap (DIB). The brush can subsequently be selected into any device context that is associated
///with a device that supports raster operations. <div class="alert"><b>Note</b> This function is provided only for
///compatibility with 16-bit versions of Windows. Applications should use the CreateDIBPatternBrushPt function.</div>
///<div> </div>
///Params:
///    h = A handle to a global memory object containing a packed DIB, which consists of a BITMAPINFO structure immediately
///        followed by an array of bytes defining the pixels of the bitmap.
///    iUsage = Specifies whether the <b>bmiColors</b> member of the BITMAPINFO structure is initialized and, if so, whether this
///             member contains explicit red, green, blue (RGB) values or indexes into a logical palette. The <i>fuColorSpec</i>
///             parameter must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///             width="40%"><a id="DIB_PAL_COLORS"></a><a id="dib_pal_colors"></a><dl> <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td>
///             <td width="60%"> A color table is provided and consists of an array of 16-bit indexes into the logical palette of
///             the device context into which the brush is to be selected. </td> </tr> <tr> <td width="40%"><a
///             id="DIB_RGB_COLORS"></a><a id="dib_rgb_colors"></a><dl> <dt><b>DIB_RGB_COLORS</b></dt> </dl> </td> <td
///             width="60%"> A color table is provided and contains literal RGB values. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value identifies a logical brush. If the function fails, the return value is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
HBRUSH CreateDIBPatternBrush(ptrdiff_t h, uint iUsage);

///The <b>CreateDIBPatternBrushPt</b> function creates a logical brush that has the pattern specified by the
///device-independent bitmap (DIB).
///Params:
///    lpPackedDIB = A pointer to a packed DIB consisting of a BITMAPINFO structure immediately followed by an array of bytes defining
///                  the pixels of the bitmap.
///    iUsage = Specifies whether the <b>bmiColors</b> member of the BITMAPINFO structure contains a valid color table and, if
///             so, whether the entries in this color table contain explicit red, green, blue (RGB) values or palette indexes.
///             The <i>iUsage</i> parameter must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="DIB_PAL_COLORS"></a><a id="dib_pal_colors"></a><dl>
///             <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td> <td width="60%"> A color table is provided and consists of an array of
///             16-bit indexes into the logical palette of the device context into which the brush is to be selected. </td> </tr>
///             <tr> <td width="40%"><a id="DIB_RGB_COLORS"></a><a id="dib_rgb_colors"></a><dl> <dt><b>DIB_RGB_COLORS</b></dt>
///             </dl> </td> <td width="60%"> A color table is provided and contains literal RGB values. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value identifies a logical brush. If the function fails, the return value is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
HBRUSH CreateDIBPatternBrushPt(const(void)* lpPackedDIB, uint iUsage);

///The <b>CreateEllipticRgn</b> function creates an elliptical region.
///Params:
///    x1 = Specifies the x-coordinate in logical units, of the upper-left corner of the bounding rectangle of the ellipse.
///    y1 = Specifies the y-coordinate in logical units, of the upper-left corner of the bounding rectangle of the ellipse.
///    x2 = Specifies the x-coordinate in logical units, of the lower-right corner of the bounding rectangle of the ellipse.
///    y2 = Specifies the y-coordinate in logical units, of the lower-right corner of the bounding rectangle of the ellipse.
///Returns:
///    If the function succeeds, the return value is the handle to the region. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HRGN CreateEllipticRgn(int x1, int y1, int x2, int y2);

///The <b>CreateEllipticRgnIndirect</b> function creates an elliptical region.
///Params:
///    lprect = Pointer to a RECT structure that contains the coordinates of the upper-left and lower-right corners of the
///             bounding rectangle of the ellipse in logical units.
///Returns:
///    If the function succeeds, the return value is the handle to the region. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HRGN CreateEllipticRgnIndirect(const(RECT)* lprect);

///The <b>CreateFontIndirect</b> function creates a logical font that has the specified characteristics. The font can
///subsequently be selected as the current font for any device context.
///Params:
///    lplf = A pointer to a LOGFONT structure that defines the characteristics of the logical font.
///Returns:
///    If the function succeeds, the return value is a handle to a logical font. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HFONT CreateFontIndirectA(const(LOGFONTA)* lplf);

///The <b>CreateFontIndirect</b> function creates a logical font that has the specified characteristics. The font can
///subsequently be selected as the current font for any device context.
///Params:
///    lplf = A pointer to a LOGFONT structure that defines the characteristics of the logical font.
///Returns:
///    If the function succeeds, the return value is a handle to a logical font. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HFONT CreateFontIndirectW(const(LOGFONTW)* lplf);

///The <b>CreateFont</b> function creates a logical font with the specified characteristics. The logical font can
///subsequently be selected as the font for any device.
///Params:
///    cHeight = The height, in logical units, of the font's character cell or character. The character height value (also known
///              as the em height) is the character cell height value minus the internal-leading value. The font mapper interprets
///              the value specified in <i>nHeight</i> in the following manner. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"> <dl> <dt>&gt; 0</dt> </dl> </td> <td width="60%"> The font mapper transforms this value
///              into device units and matches it against the cell height of the available fonts. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The font mapper uses a default height value when it
///              searches for a match. </td> </tr> <tr> <td width="40%"> <dl> <dt>&lt; 0</dt> </dl> </td> <td width="60%"> The
///              font mapper transforms this value into device units and matches its absolute value against the character height
///              of the available fonts. </td> </tr> </table> For all height comparisons, the font mapper looks for the largest
///              font that does not exceed the requested size. This mapping occurs when the font is used for the first time. For
///              the MM_TEXT mapping mode, you can use the following formula to specify a height for a font with a specified point
///              size: ```cpp nHeight = -MulDiv(PointSize, GetDeviceCaps(hDC, LOGPIXELSY), 72); ```
///    cWidth = The average width, in logical units, of characters in the requested font. If this value is zero, the font mapper
///             chooses a closest match value. The closest match value is determined by comparing the absolute values of the
///             difference between the current device's aspect ratio and the digitized aspect ratio of available fonts.
///    cEscapement = The angle, in tenths of degrees, between the escapement vector and the x-axis of the device. The escapement
///                  vector is parallel to the base line of a row of text. When the graphics mode is set to GM_ADVANCED, you can
///                  specify the escapement angle of the string independently of the orientation angle of the string's characters.
///                  When the graphics mode is set to GM_COMPATIBLE, <i>nEscapement</i> specifies both the escapement and orientation.
///                  You should set <i>nEscapement</i> and <i>nOrientation</i> to the same value.
///    cOrientation = The angle, in tenths of degrees, between each character's base line and the x-axis of the device.
///    cWeight = The weight of the font in the range 0 through 1000. For example, 400 is normal and 700 is bold. If this value is
///              zero, a default weight is used. The following values are defined for convenience. <table> <tr> <th>Weight</th>
///              <th>Value</th> </tr> <tr> <td width="40%"><a id="FW_DONTCARE"></a><a id="fw_dontcare"></a><dl>
///              <dt><b>FW_DONTCARE</b></dt> </dl> </td> <td width="60%"> 0 </td> </tr> <tr> <td width="40%"><a
///              id="FW_THIN"></a><a id="fw_thin"></a><dl> <dt><b>FW_THIN</b></dt> </dl> </td> <td width="60%"> 100 </td> </tr>
///              <tr> <td width="40%"><a id="FW_EXTRALIGHT"></a><a id="fw_extralight"></a><dl> <dt><b>FW_EXTRALIGHT</b></dt> </dl>
///              </td> <td width="60%"> 200 </td> </tr> <tr> <td width="40%"><a id="FW_ULTRALIGHT"></a><a
///              id="fw_ultralight"></a><dl> <dt><b>FW_ULTRALIGHT</b></dt> </dl> </td> <td width="60%"> 200 </td> </tr> <tr> <td
///              width="40%"><a id="FW_LIGHT"></a><a id="fw_light"></a><dl> <dt><b>FW_LIGHT</b></dt> </dl> </td> <td width="60%">
///              300 </td> </tr> <tr> <td width="40%"><a id="FW_NORMAL"></a><a id="fw_normal"></a><dl> <dt><b>FW_NORMAL</b></dt>
///              </dl> </td> <td width="60%"> 400 </td> </tr> <tr> <td width="40%"><a id="FW_REGULAR"></a><a
///              id="fw_regular"></a><dl> <dt><b>FW_REGULAR</b></dt> </dl> </td> <td width="60%"> 400 </td> </tr> <tr> <td
///              width="40%"><a id="FW_MEDIUM"></a><a id="fw_medium"></a><dl> <dt><b>FW_MEDIUM</b></dt> </dl> </td> <td
///              width="60%"> 500 </td> </tr> <tr> <td width="40%"><a id="FW_SEMIBOLD"></a><a id="fw_semibold"></a><dl>
///              <dt><b>FW_SEMIBOLD</b></dt> </dl> </td> <td width="60%"> 600 </td> </tr> <tr> <td width="40%"><a
///              id="FW_DEMIBOLD"></a><a id="fw_demibold"></a><dl> <dt><b>FW_DEMIBOLD</b></dt> </dl> </td> <td width="60%"> 600
///              </td> </tr> <tr> <td width="40%"><a id="FW_BOLD"></a><a id="fw_bold"></a><dl> <dt><b>FW_BOLD</b></dt> </dl> </td>
///              <td width="60%"> 700 </td> </tr> <tr> <td width="40%"><a id="FW_EXTRABOLD"></a><a id="fw_extrabold"></a><dl>
///              <dt><b>FW_EXTRABOLD</b></dt> </dl> </td> <td width="60%"> 800 </td> </tr> <tr> <td width="40%"><a
///              id="FW_ULTRABOLD"></a><a id="fw_ultrabold"></a><dl> <dt><b>FW_ULTRABOLD</b></dt> </dl> </td> <td width="60%"> 800
///              </td> </tr> <tr> <td width="40%"><a id="FW_HEAVY"></a><a id="fw_heavy"></a><dl> <dt><b>FW_HEAVY</b></dt> </dl>
///              </td> <td width="60%"> 900 </td> </tr> <tr> <td width="40%"><a id="FW_BLACK"></a><a id="fw_black"></a><dl>
///              <dt><b>FW_BLACK</b></dt> </dl> </td> <td width="60%"> 900 </td> </tr> </table>
///    bItalic = Specifies an italic font if set to <b>TRUE</b>.
///    bUnderline = Specifies an underlined font if set to <b>TRUE</b>.
///    bStrikeOut = A strikeout font if set to <b>TRUE</b>.
///    iCharSet = The character set. The following values are predefined: <ul> <li>ANSI_CHARSET</li> <li>BALTIC_CHARSET</li>
///               <li>CHINESEBIG5_CHARSET</li> <li>DEFAULT_CHARSET</li> <li>EASTEUROPE_CHARSET</li> <li>GB2312_CHARSET</li>
///               <li>GREEK_CHARSET</li> <li>HANGUL_CHARSET</li> <li>MAC_CHARSET</li> <li>OEM_CHARSET</li> <li>RUSSIAN_CHARSET</li>
///               <li>SHIFTJIS_CHARSET</li> <li>SYMBOL_CHARSET</li> <li>TURKISH_CHARSET</li> <li>VIETNAMESE_CHARSET</li> </ul>
///               Korean language edition of Windows: <ul> <li>JOHAB_CHARSET</li> </ul> Middle East language edition of Windows:
///               <ul> <li>ARABIC_CHARSET</li> <li>HEBREW_CHARSET</li> </ul> Thai language edition of Windows: <ul>
///               <li>THAI_CHARSET</li> </ul> The OEM_CHARSET value specifies a character set that is operating-system dependent.
///               DEFAULT_CHARSET is set to a value based on the current system locale. For example, when the system locale is
///               English (United States), it is set as ANSI_CHARSET. Fonts with other character sets may exist in the operating
///               system. If an application uses a font with an unknown character set, it should not attempt to translate or
///               interpret strings that are rendered with that font. To ensure consistent results when creating a font, do not
///               specify OEM_CHARSET or DEFAULT_CHARSET. If you specify a typeface name in the <i>lpszFace</i> parameter, make
///               sure that the <i>fdwCharSet</i> value matches the character set of the typeface specified in <i>lpszFace</i>.
///    iOutPrecision = The output precision. The output precision defines how closely the output must match the requested font's height,
///                    width, character orientation, escapement, pitch, and font type. It can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OUT_CHARACTER_PRECIS"></a><a
///                    id="out_character_precis"></a><dl> <dt><b>OUT_CHARACTER_PRECIS</b></dt> </dl> </td> <td width="60%"> Not used.
///                    </td> </tr> <tr> <td width="40%"><a id="OUT_DEFAULT_PRECIS"></a><a id="out_default_precis"></a><dl>
///                    <dt><b>OUT_DEFAULT_PRECIS</b></dt> </dl> </td> <td width="60%"> The default font mapper behavior. </td> </tr>
///                    <tr> <td width="40%"><a id="OUT_DEVICE_PRECIS"></a><a id="out_device_precis"></a><dl>
///                    <dt><b>OUT_DEVICE_PRECIS</b></dt> </dl> </td> <td width="60%"> Instructs the font mapper to choose a Device font
///                    when the system contains multiple fonts with the same name. </td> </tr> <tr> <td width="40%"><a
///                    id="OUT_OUTLINE_PRECIS"></a><a id="out_outline_precis"></a><dl> <dt><b>OUT_OUTLINE_PRECIS</b></dt> </dl> </td>
///                    <td width="60%"> This value instructs the font mapper to choose from TrueType and other outline-based fonts.
///                    </td> </tr> <tr> <td width="40%"><a id="OUT_PS_ONLY_PRECIS"></a><a id="out_ps_only_precis"></a><dl>
///                    <dt><b>OUT_PS_ONLY_PRECIS</b></dt> </dl> </td> <td width="60%"> Instructs the font mapper to choose from only
///                    PostScript fonts. If there are no PostScript fonts installed in the system, the font mapper returns to default
///                    behavior. </td> </tr> <tr> <td width="40%"><a id="OUT_RASTER_PRECIS"></a><a id="out_raster_precis"></a><dl>
///                    <dt><b>OUT_RASTER_PRECIS</b></dt> </dl> </td> <td width="60%"> Instructs the font mapper to choose a raster font
///                    when the system contains multiple fonts with the same name. </td> </tr> <tr> <td width="40%"><a
///                    id="OUT_STRING_PRECIS"></a><a id="out_string_precis"></a><dl> <dt><b>OUT_STRING_PRECIS</b></dt> </dl> </td> <td
///                    width="60%"> This value is not used by the font mapper, but it is returned when raster fonts are enumerated.
///                    </td> </tr> <tr> <td width="40%"><a id="OUT_STROKE_PRECIS"></a><a id="out_stroke_precis"></a><dl>
///                    <dt><b>OUT_STROKE_PRECIS</b></dt> </dl> </td> <td width="60%"> This value is not used by the font mapper, but it
///                    is returned when TrueType, other outline-based fonts, and vector fonts are enumerated. </td> </tr> <tr> <td
///                    width="40%"><a id="OUT_TT_ONLY_PRECIS"></a><a id="out_tt_only_precis"></a><dl> <dt><b>OUT_TT_ONLY_PRECIS</b></dt>
///                    </dl> </td> <td width="60%"> Instructs the font mapper to choose from only TrueType fonts. If there are no
///                    TrueType fonts installed in the system, the font mapper returns to default behavior. </td> </tr> <tr> <td
///                    width="40%"><a id="OUT_TT_PRECIS"></a><a id="out_tt_precis"></a><dl> <dt><b>OUT_TT_PRECIS</b></dt> </dl> </td>
///                    <td width="60%"> Instructs the font mapper to choose a TrueType font when the system contains multiple fonts with
///                    the same name. </td> </tr> </table> Applications can use the OUT_DEVICE_PRECIS, OUT_RASTER_PRECIS, OUT_TT_PRECIS,
///                    and OUT_PS_ONLY_PRECIS values to control how the font mapper chooses a font when the operating system contains
///                    more than one font with a specified name. For example, if an operating system contains a font named Symbol in
///                    raster and TrueType form, specifying OUT_TT_PRECIS forces the font mapper to choose the TrueType version.
///                    Specifying OUT_TT_ONLY_PRECIS forces the font mapper to choose a TrueType font, even if it must substitute a
///                    TrueType font of another name.
///    iClipPrecision = The clipping precision. The clipping precision defines how to clip characters that are partially outside the
///                     clipping region. It can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                     </tr> <tr> <td width="40%"><a id="CLIP_CHARACTER_PRECIS"></a><a id="clip_character_precis"></a><dl>
///                     <dt><b>CLIP_CHARACTER_PRECIS</b></dt> </dl> </td> <td width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_DEFAULT_PRECIS"></a><a id="clip_default_precis"></a><dl> <dt><b>CLIP_DEFAULT_PRECIS</b></dt> </dl> </td>
///                     <td width="60%"> Specifies default clipping behavior. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_DFA_DISABLE"></a><a id="clip_dfa_disable"></a><dl> <dt><b>CLIP_DFA_DISABLE</b></dt> </dl> </td> <td
///                     width="60%"> Windows XP SP1: Turns off font association for the font. Note that this flag is not guaranteed to
///                     have any effect on any platform after Windows Server 2003. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_EMBEDDED"></a><a id="clip_embedded"></a><dl> <dt><b>CLIP_EMBEDDED</b></dt> </dl> </td> <td width="60%">
///                     You must specify this flag to use an embedded read-only font. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_LH_ANGLES"></a><a id="clip_lh_angles"></a><dl> <dt><b>CLIP_LH_ANGLES</b></dt> </dl> </td> <td
///                     width="60%"> When this value is used, the rotation for all fonts depends on whether the orientation of the
///                     coordinate system is left-handed or right-handed. If not used, device fonts always rotate counterclockwise, but
///                     the rotation of other fonts is dependent on the orientation of the coordinate system. For more information about
///                     the orientation of coordinate systems, see the description of the <i>nOrientation</i> parameter </td> </tr> <tr>
///                     <td width="40%"><a id="CLIP_MASK"></a><a id="clip_mask"></a><dl> <dt><b>CLIP_MASK</b></dt> </dl> </td> <td
///                     width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a id="CLIP_DFA_OVERRIDE"></a><a
///                     id="clip_dfa_override"></a><dl> <dt><b>CLIP_DFA_OVERRIDE</b></dt> </dl> </td> <td width="60%"> Turns off font
///                     association for the font. This is identical to CLIP_DFA_DISABLE, but it can have problems in some situations; the
///                     recommended flag to use is CLIP_DFA_DISABLE. </td> </tr> <tr> <td width="40%"><a id="CLIP_STROKE_PRECIS"></a><a
///                     id="clip_stroke_precis"></a><dl> <dt><b>CLIP_STROKE_PRECIS</b></dt> </dl> </td> <td width="60%"> Not used by the
///                     font mapper, but is returned when raster, vector, or TrueType fonts are enumerated. For compatibility, this value
///                     is always returned when enumerating fonts. </td> </tr> <tr> <td width="40%"><a id="CLIP_TT_ALWAYS"></a><a
///                     id="clip_tt_always"></a><dl> <dt><b>CLIP_TT_ALWAYS</b></dt> </dl> </td> <td width="60%"> Not used. </td> </tr>
///                     </table>
///    iQuality = The output quality. The output quality defines how carefully GDI must attempt to match the logical-font
///               attributes to those of an actual physical font. It can be one of the following values. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ANTIALIASED_QUALITY"></a><a
///               id="antialiased_quality"></a><dl> <dt><b>ANTIALIASED_QUALITY</b></dt> </dl> </td> <td width="60%"> Font is
///               antialiased, or smoothed, if the font supports it and the size of the font is not too small or too large. </td>
///               </tr> <tr> <td width="40%"><a id="CLEARTYPE_QUALITY"></a><a id="cleartype_quality"></a><dl>
///               <dt><b>CLEARTYPE_QUALITY</b></dt> </dl> </td> <td width="60%"> If set, text is rendered (when possible) using
///               ClearType antialiasing method. See Remarks for more information. </td> </tr> <tr> <td width="40%"><a
///               id="DEFAULT_QUALITY"></a><a id="default_quality"></a><dl> <dt><b>DEFAULT_QUALITY</b></dt> </dl> </td> <td
///               width="60%"> Appearance of the font does not matter. </td> </tr> <tr> <td width="40%"><a
///               id="DRAFT_QUALITY"></a><a id="draft_quality"></a><dl> <dt><b>DRAFT_QUALITY</b></dt> </dl> </td> <td width="60%">
///               Appearance of the font is less important than when the PROOF_QUALITY value is used. For GDI raster fonts, scaling
///               is enabled, which means that more font sizes are available, but the quality may be lower. Bold, italic,
///               underline, and strikeout fonts are synthesized, if necessary. </td> </tr> <tr> <td width="40%"><a
///               id="NONANTIALIASED_QUALITY"></a><a id="nonantialiased_quality"></a><dl> <dt><b>NONANTIALIASED_QUALITY</b></dt>
///               </dl> </td> <td width="60%"> Font is never antialiased, that is, font smoothing is not done. </td> </tr> <tr> <td
///               width="40%"><a id="PROOF_QUALITY"></a><a id="proof_quality"></a><dl> <dt><b>PROOF_QUALITY</b></dt> </dl> </td>
///               <td width="60%"> Character quality of the font is more important than exact matching of the logical-font
///               attributes. For GDI raster fonts, scaling is disabled and the font closest in size is chosen. Although the chosen
///               font size may not be mapped exactly when PROOF_QUALITY is used, the quality of the font is high and there is no
///               distortion of appearance. Bold, italic, underline, and strikeout fonts are synthesized, if necessary. </td> </tr>
///               </table> If the output quality is DEFAULT_QUALITY, DRAFT_QUALITY, or PROOF_QUALITY, then the font is antialiased
///               if the SPI_GETFONTSMOOTHING system parameter is <b>TRUE</b>. Users can control this system parameter from the
///               Control Panel. (The precise wording of the setting in the Control panel depends on the version of Windows, but it
///               will be words to the effect of "Smooth edges of screen fonts".)
///    iPitchAndFamily = The pitch and family of the font. The two low-order bits specify the pitch of the font and can be one of the
///                      following values: <ul> <li>DEFAULT_PITCH</li> <li>FIXED_PITCH</li> <li>VARIABLE_PITCH</li> </ul> The four
///                      high-order bits specify the font family and can be one of the following values. <table> <tr> <th>Value</th>
///                      <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FF_DECORATIVE"></a><a id="ff_decorative"></a><dl>
///                      <dt><b>FF_DECORATIVE</b></dt> </dl> </td> <td width="60%"> Novelty fonts. Old English is an example. </td> </tr>
///                      <tr> <td width="40%"><a id="FF_DONTCARE"></a><a id="ff_dontcare"></a><dl> <dt><b>FF_DONTCARE</b></dt> </dl> </td>
///                      <td width="60%"> Use default font. </td> </tr> <tr> <td width="40%"><a id="FF_MODERN"></a><a
///                      id="ff_modern"></a><dl> <dt><b>FF_MODERN</b></dt> </dl> </td> <td width="60%"> Fonts with constant stroke width,
///                      with or without serifs. Pica, Elite, and Courier New are examples. </td> </tr> <tr> <td width="40%"><a
///                      id="FF_ROMAN"></a><a id="ff_roman"></a><dl> <dt><b>FF_ROMAN</b></dt> </dl> </td> <td width="60%"> Fonts with
///                      variable stroke width and with serifs. MS Serif is an example. </td> </tr> <tr> <td width="40%"><a
///                      id="FF_SCRIPT"></a><a id="ff_script"></a><dl> <dt><b>FF_SCRIPT</b></dt> </dl> </td> <td width="60%"> Fonts
///                      designed to look like handwriting. Script and Cursive are examples. </td> </tr> <tr> <td width="40%"><a
///                      id="FF_SWISS"></a><a id="ff_swiss"></a><dl> <dt><b>FF_SWISS</b></dt> </dl> </td> <td width="60%"> Fonts with
///                      variable stroke width and without serifs. MS?Sans Serif is an example. </td> </tr> </table> An application can
///                      specify a value for the <i>fdwPitchAndFamily</i> parameter by using the Boolean OR operator to join a pitch
///                      constant with a family constant. Font families describe the look of a font in a general way. They are intended
///                      for specifying fonts when the exact typeface requested is not available.
///    pszFaceName = A pointer to a null-terminated string that specifies the typeface name of the font. The length of this string
///                  must not exceed 32 characters, including the terminating null character. The EnumFontFamilies function can be
///                  used to enumerate the typeface names of all currently available fonts. For more information, see the Remarks. If
///                  <i>lpszFace</i> is <b>NULL</b> or empty string, GDI uses the first font that matches the other specified
///                  attributes.
///Returns:
///    If the function succeeds, the return value is a handle to a logical font. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HFONT CreateFontA(int cHeight, int cWidth, int cEscapement, int cOrientation, int cWeight, uint bItalic, 
                  uint bUnderline, uint bStrikeOut, uint iCharSet, uint iOutPrecision, uint iClipPrecision, 
                  uint iQuality, uint iPitchAndFamily, const(char)* pszFaceName);

///The <b>CreateFont</b> function creates a logical font with the specified characteristics. The logical font can
///subsequently be selected as the font for any device.
///Params:
///    cHeight = The height, in logical units, of the font's character cell or character. The character height value (also known
///              as the em height) is the character cell height value minus the internal-leading value. The font mapper interprets
///              the value specified in <i>nHeight</i> in the following manner. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"> <dl> <dt>&gt; 0</dt> </dl> </td> <td width="60%"> The font mapper transforms this value
///              into device units and matches it against the cell height of the available fonts. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The font mapper uses a default height value when it
///              searches for a match. </td> </tr> <tr> <td width="40%"> <dl> <dt>&lt; 0</dt> </dl> </td> <td width="60%"> The
///              font mapper transforms this value into device units and matches its absolute value against the character height
///              of the available fonts. </td> </tr> </table> For all height comparisons, the font mapper looks for the largest
///              font that does not exceed the requested size. This mapping occurs when the font is used for the first time. For
///              the MM_TEXT mapping mode, you can use the following formula to specify a height for a font with a specified point
///              size: ```cpp nHeight = -MulDiv(PointSize, GetDeviceCaps(hDC, LOGPIXELSY), 72); ```
///    cWidth = The average width, in logical units, of characters in the requested font. If this value is zero, the font mapper
///             chooses a closest match value. The closest match value is determined by comparing the absolute values of the
///             difference between the current device's aspect ratio and the digitized aspect ratio of available fonts.
///    cEscapement = The angle, in tenths of degrees, between the escapement vector and the x-axis of the device. The escapement
///                  vector is parallel to the base line of a row of text. When the graphics mode is set to GM_ADVANCED, you can
///                  specify the escapement angle of the string independently of the orientation angle of the string's characters.
///                  When the graphics mode is set to GM_COMPATIBLE, <i>nEscapement</i> specifies both the escapement and orientation.
///                  You should set <i>nEscapement</i> and <i>nOrientation</i> to the same value.
///    cOrientation = The angle, in tenths of degrees, between each character's base line and the x-axis of the device.
///    cWeight = The weight of the font in the range 0 through 1000. For example, 400 is normal and 700 is bold. If this value is
///              zero, a default weight is used. The following values are defined for convenience. <table> <tr> <th>Weight</th>
///              <th>Value</th> </tr> <tr> <td width="40%"><a id="FW_DONTCARE"></a><a id="fw_dontcare"></a><dl>
///              <dt><b>FW_DONTCARE</b></dt> </dl> </td> <td width="60%"> 0 </td> </tr> <tr> <td width="40%"><a
///              id="FW_THIN"></a><a id="fw_thin"></a><dl> <dt><b>FW_THIN</b></dt> </dl> </td> <td width="60%"> 100 </td> </tr>
///              <tr> <td width="40%"><a id="FW_EXTRALIGHT"></a><a id="fw_extralight"></a><dl> <dt><b>FW_EXTRALIGHT</b></dt> </dl>
///              </td> <td width="60%"> 200 </td> </tr> <tr> <td width="40%"><a id="FW_ULTRALIGHT"></a><a
///              id="fw_ultralight"></a><dl> <dt><b>FW_ULTRALIGHT</b></dt> </dl> </td> <td width="60%"> 200 </td> </tr> <tr> <td
///              width="40%"><a id="FW_LIGHT"></a><a id="fw_light"></a><dl> <dt><b>FW_LIGHT</b></dt> </dl> </td> <td width="60%">
///              300 </td> </tr> <tr> <td width="40%"><a id="FW_NORMAL"></a><a id="fw_normal"></a><dl> <dt><b>FW_NORMAL</b></dt>
///              </dl> </td> <td width="60%"> 400 </td> </tr> <tr> <td width="40%"><a id="FW_REGULAR"></a><a
///              id="fw_regular"></a><dl> <dt><b>FW_REGULAR</b></dt> </dl> </td> <td width="60%"> 400 </td> </tr> <tr> <td
///              width="40%"><a id="FW_MEDIUM"></a><a id="fw_medium"></a><dl> <dt><b>FW_MEDIUM</b></dt> </dl> </td> <td
///              width="60%"> 500 </td> </tr> <tr> <td width="40%"><a id="FW_SEMIBOLD"></a><a id="fw_semibold"></a><dl>
///              <dt><b>FW_SEMIBOLD</b></dt> </dl> </td> <td width="60%"> 600 </td> </tr> <tr> <td width="40%"><a
///              id="FW_DEMIBOLD"></a><a id="fw_demibold"></a><dl> <dt><b>FW_DEMIBOLD</b></dt> </dl> </td> <td width="60%"> 600
///              </td> </tr> <tr> <td width="40%"><a id="FW_BOLD"></a><a id="fw_bold"></a><dl> <dt><b>FW_BOLD</b></dt> </dl> </td>
///              <td width="60%"> 700 </td> </tr> <tr> <td width="40%"><a id="FW_EXTRABOLD"></a><a id="fw_extrabold"></a><dl>
///              <dt><b>FW_EXTRABOLD</b></dt> </dl> </td> <td width="60%"> 800 </td> </tr> <tr> <td width="40%"><a
///              id="FW_ULTRABOLD"></a><a id="fw_ultrabold"></a><dl> <dt><b>FW_ULTRABOLD</b></dt> </dl> </td> <td width="60%"> 800
///              </td> </tr> <tr> <td width="40%"><a id="FW_HEAVY"></a><a id="fw_heavy"></a><dl> <dt><b>FW_HEAVY</b></dt> </dl>
///              </td> <td width="60%"> 900 </td> </tr> <tr> <td width="40%"><a id="FW_BLACK"></a><a id="fw_black"></a><dl>
///              <dt><b>FW_BLACK</b></dt> </dl> </td> <td width="60%"> 900 </td> </tr> </table>
///    bItalic = Specifies an italic font if set to <b>TRUE</b>.
///    bUnderline = Specifies an underlined font if set to <b>TRUE</b>.
///    bStrikeOut = A strikeout font if set to <b>TRUE</b>.
///    iCharSet = The character set. The following values are predefined: <ul> <li>ANSI_CHARSET</li> <li>BALTIC_CHARSET</li>
///               <li>CHINESEBIG5_CHARSET</li> <li>DEFAULT_CHARSET</li> <li>EASTEUROPE_CHARSET</li> <li>GB2312_CHARSET</li>
///               <li>GREEK_CHARSET</li> <li>HANGUL_CHARSET</li> <li>MAC_CHARSET</li> <li>OEM_CHARSET</li> <li>RUSSIAN_CHARSET</li>
///               <li>SHIFTJIS_CHARSET</li> <li>SYMBOL_CHARSET</li> <li>TURKISH_CHARSET</li> <li>VIETNAMESE_CHARSET</li> </ul>
///               Korean language edition of Windows: <ul> <li>JOHAB_CHARSET</li> </ul> Middle East language edition of Windows:
///               <ul> <li>ARABIC_CHARSET</li> <li>HEBREW_CHARSET</li> </ul> Thai language edition of Windows: <ul>
///               <li>THAI_CHARSET</li> </ul> The OEM_CHARSET value specifies a character set that is operating-system dependent.
///               DEFAULT_CHARSET is set to a value based on the current system locale. For example, when the system locale is
///               English (United States), it is set as ANSI_CHARSET. Fonts with other character sets may exist in the operating
///               system. If an application uses a font with an unknown character set, it should not attempt to translate or
///               interpret strings that are rendered with that font. To ensure consistent results when creating a font, do not
///               specify OEM_CHARSET or DEFAULT_CHARSET. If you specify a typeface name in the <i>lpszFace</i> parameter, make
///               sure that the <i>fdwCharSet</i> value matches the character set of the typeface specified in <i>lpszFace</i>.
///    iOutPrecision = The output precision. The output precision defines how closely the output must match the requested font's height,
///                    width, character orientation, escapement, pitch, and font type. It can be one of the following values. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OUT_CHARACTER_PRECIS"></a><a
///                    id="out_character_precis"></a><dl> <dt><b>OUT_CHARACTER_PRECIS</b></dt> </dl> </td> <td width="60%"> Not used.
///                    </td> </tr> <tr> <td width="40%"><a id="OUT_DEFAULT_PRECIS"></a><a id="out_default_precis"></a><dl>
///                    <dt><b>OUT_DEFAULT_PRECIS</b></dt> </dl> </td> <td width="60%"> The default font mapper behavior. </td> </tr>
///                    <tr> <td width="40%"><a id="OUT_DEVICE_PRECIS"></a><a id="out_device_precis"></a><dl>
///                    <dt><b>OUT_DEVICE_PRECIS</b></dt> </dl> </td> <td width="60%"> Instructs the font mapper to choose a Device font
///                    when the system contains multiple fonts with the same name. </td> </tr> <tr> <td width="40%"><a
///                    id="OUT_OUTLINE_PRECIS"></a><a id="out_outline_precis"></a><dl> <dt><b>OUT_OUTLINE_PRECIS</b></dt> </dl> </td>
///                    <td width="60%"> This value instructs the font mapper to choose from TrueType and other outline-based fonts.
///                    </td> </tr> <tr> <td width="40%"><a id="OUT_PS_ONLY_PRECIS"></a><a id="out_ps_only_precis"></a><dl>
///                    <dt><b>OUT_PS_ONLY_PRECIS</b></dt> </dl> </td> <td width="60%"> Instructs the font mapper to choose from only
///                    PostScript fonts. If there are no PostScript fonts installed in the system, the font mapper returns to default
///                    behavior. </td> </tr> <tr> <td width="40%"><a id="OUT_RASTER_PRECIS"></a><a id="out_raster_precis"></a><dl>
///                    <dt><b>OUT_RASTER_PRECIS</b></dt> </dl> </td> <td width="60%"> Instructs the font mapper to choose a raster font
///                    when the system contains multiple fonts with the same name. </td> </tr> <tr> <td width="40%"><a
///                    id="OUT_STRING_PRECIS"></a><a id="out_string_precis"></a><dl> <dt><b>OUT_STRING_PRECIS</b></dt> </dl> </td> <td
///                    width="60%"> This value is not used by the font mapper, but it is returned when raster fonts are enumerated.
///                    </td> </tr> <tr> <td width="40%"><a id="OUT_STROKE_PRECIS"></a><a id="out_stroke_precis"></a><dl>
///                    <dt><b>OUT_STROKE_PRECIS</b></dt> </dl> </td> <td width="60%"> This value is not used by the font mapper, but it
///                    is returned when TrueType, other outline-based fonts, and vector fonts are enumerated. </td> </tr> <tr> <td
///                    width="40%"><a id="OUT_TT_ONLY_PRECIS"></a><a id="out_tt_only_precis"></a><dl> <dt><b>OUT_TT_ONLY_PRECIS</b></dt>
///                    </dl> </td> <td width="60%"> Instructs the font mapper to choose from only TrueType fonts. If there are no
///                    TrueType fonts installed in the system, the font mapper returns to default behavior. </td> </tr> <tr> <td
///                    width="40%"><a id="OUT_TT_PRECIS"></a><a id="out_tt_precis"></a><dl> <dt><b>OUT_TT_PRECIS</b></dt> </dl> </td>
///                    <td width="60%"> Instructs the font mapper to choose a TrueType font when the system contains multiple fonts with
///                    the same name. </td> </tr> </table> Applications can use the OUT_DEVICE_PRECIS, OUT_RASTER_PRECIS, OUT_TT_PRECIS,
///                    and OUT_PS_ONLY_PRECIS values to control how the font mapper chooses a font when the operating system contains
///                    more than one font with a specified name. For example, if an operating system contains a font named Symbol in
///                    raster and TrueType form, specifying OUT_TT_PRECIS forces the font mapper to choose the TrueType version.
///                    Specifying OUT_TT_ONLY_PRECIS forces the font mapper to choose a TrueType font, even if it must substitute a
///                    TrueType font of another name.
///    iClipPrecision = The clipping precision. The clipping precision defines how to clip characters that are partially outside the
///                     clipping region. It can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                     </tr> <tr> <td width="40%"><a id="CLIP_CHARACTER_PRECIS"></a><a id="clip_character_precis"></a><dl>
///                     <dt><b>CLIP_CHARACTER_PRECIS</b></dt> </dl> </td> <td width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_DEFAULT_PRECIS"></a><a id="clip_default_precis"></a><dl> <dt><b>CLIP_DEFAULT_PRECIS</b></dt> </dl> </td>
///                     <td width="60%"> Specifies default clipping behavior. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_DFA_DISABLE"></a><a id="clip_dfa_disable"></a><dl> <dt><b>CLIP_DFA_DISABLE</b></dt> </dl> </td> <td
///                     width="60%"> Windows XP SP1: Turns off font association for the font. Note that this flag is not guaranteed to
///                     have any effect on any platform after Windows Server 2003. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_EMBEDDED"></a><a id="clip_embedded"></a><dl> <dt><b>CLIP_EMBEDDED</b></dt> </dl> </td> <td width="60%">
///                     You must specify this flag to use an embedded read-only font. </td> </tr> <tr> <td width="40%"><a
///                     id="CLIP_LH_ANGLES"></a><a id="clip_lh_angles"></a><dl> <dt><b>CLIP_LH_ANGLES</b></dt> </dl> </td> <td
///                     width="60%"> When this value is used, the rotation for all fonts depends on whether the orientation of the
///                     coordinate system is left-handed or right-handed. If not used, device fonts always rotate counterclockwise, but
///                     the rotation of other fonts is dependent on the orientation of the coordinate system. For more information about
///                     the orientation of coordinate systems, see the description of the <i>nOrientation</i> parameter </td> </tr> <tr>
///                     <td width="40%"><a id="CLIP_MASK"></a><a id="clip_mask"></a><dl> <dt><b>CLIP_MASK</b></dt> </dl> </td> <td
///                     width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a id="CLIP_DFA_OVERRIDE"></a><a
///                     id="clip_dfa_override"></a><dl> <dt><b>CLIP_DFA_OVERRIDE</b></dt> </dl> </td> <td width="60%"> Turns off font
///                     association for the font. This is identical to CLIP_DFA_DISABLE, but it can have problems in some situations; the
///                     recommended flag to use is CLIP_DFA_DISABLE. </td> </tr> <tr> <td width="40%"><a id="CLIP_STROKE_PRECIS"></a><a
///                     id="clip_stroke_precis"></a><dl> <dt><b>CLIP_STROKE_PRECIS</b></dt> </dl> </td> <td width="60%"> Not used by the
///                     font mapper, but is returned when raster, vector, or TrueType fonts are enumerated. For compatibility, this value
///                     is always returned when enumerating fonts. </td> </tr> <tr> <td width="40%"><a id="CLIP_TT_ALWAYS"></a><a
///                     id="clip_tt_always"></a><dl> <dt><b>CLIP_TT_ALWAYS</b></dt> </dl> </td> <td width="60%"> Not used. </td> </tr>
///                     </table>
///    iQuality = The output quality. The output quality defines how carefully GDI must attempt to match the logical-font
///               attributes to those of an actual physical font. It can be one of the following values. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ANTIALIASED_QUALITY"></a><a
///               id="antialiased_quality"></a><dl> <dt><b>ANTIALIASED_QUALITY</b></dt> </dl> </td> <td width="60%"> Font is
///               antialiased, or smoothed, if the font supports it and the size of the font is not too small or too large. </td>
///               </tr> <tr> <td width="40%"><a id="CLEARTYPE_QUALITY"></a><a id="cleartype_quality"></a><dl>
///               <dt><b>CLEARTYPE_QUALITY</b></dt> </dl> </td> <td width="60%"> If set, text is rendered (when possible) using
///               ClearType antialiasing method. See Remarks for more information. </td> </tr> <tr> <td width="40%"><a
///               id="DEFAULT_QUALITY"></a><a id="default_quality"></a><dl> <dt><b>DEFAULT_QUALITY</b></dt> </dl> </td> <td
///               width="60%"> Appearance of the font does not matter. </td> </tr> <tr> <td width="40%"><a
///               id="DRAFT_QUALITY"></a><a id="draft_quality"></a><dl> <dt><b>DRAFT_QUALITY</b></dt> </dl> </td> <td width="60%">
///               Appearance of the font is less important than when the PROOF_QUALITY value is used. For GDI raster fonts, scaling
///               is enabled, which means that more font sizes are available, but the quality may be lower. Bold, italic,
///               underline, and strikeout fonts are synthesized, if necessary. </td> </tr> <tr> <td width="40%"><a
///               id="NONANTIALIASED_QUALITY"></a><a id="nonantialiased_quality"></a><dl> <dt><b>NONANTIALIASED_QUALITY</b></dt>
///               </dl> </td> <td width="60%"> Font is never antialiased, that is, font smoothing is not done. </td> </tr> <tr> <td
///               width="40%"><a id="PROOF_QUALITY"></a><a id="proof_quality"></a><dl> <dt><b>PROOF_QUALITY</b></dt> </dl> </td>
///               <td width="60%"> Character quality of the font is more important than exact matching of the logical-font
///               attributes. For GDI raster fonts, scaling is disabled and the font closest in size is chosen. Although the chosen
///               font size may not be mapped exactly when PROOF_QUALITY is used, the quality of the font is high and there is no
///               distortion of appearance. Bold, italic, underline, and strikeout fonts are synthesized, if necessary. </td> </tr>
///               </table> If the output quality is DEFAULT_QUALITY, DRAFT_QUALITY, or PROOF_QUALITY, then the font is antialiased
///               if the SPI_GETFONTSMOOTHING system parameter is <b>TRUE</b>. Users can control this system parameter from the
///               Control Panel. (The precise wording of the setting in the Control panel depends on the version of Windows, but it
///               will be words to the effect of "Smooth edges of screen fonts".)
///    iPitchAndFamily = The pitch and family of the font. The two low-order bits specify the pitch of the font and can be one of the
///                      following values: <ul> <li>DEFAULT_PITCH</li> <li>FIXED_PITCH</li> <li>VARIABLE_PITCH</li> </ul> The four
///                      high-order bits specify the font family and can be one of the following values. <table> <tr> <th>Value</th>
///                      <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FF_DECORATIVE"></a><a id="ff_decorative"></a><dl>
///                      <dt><b>FF_DECORATIVE</b></dt> </dl> </td> <td width="60%"> Novelty fonts. Old English is an example. </td> </tr>
///                      <tr> <td width="40%"><a id="FF_DONTCARE"></a><a id="ff_dontcare"></a><dl> <dt><b>FF_DONTCARE</b></dt> </dl> </td>
///                      <td width="60%"> Use default font. </td> </tr> <tr> <td width="40%"><a id="FF_MODERN"></a><a
///                      id="ff_modern"></a><dl> <dt><b>FF_MODERN</b></dt> </dl> </td> <td width="60%"> Fonts with constant stroke width,
///                      with or without serifs. Pica, Elite, and Courier New are examples. </td> </tr> <tr> <td width="40%"><a
///                      id="FF_ROMAN"></a><a id="ff_roman"></a><dl> <dt><b>FF_ROMAN</b></dt> </dl> </td> <td width="60%"> Fonts with
///                      variable stroke width and with serifs. MS Serif is an example. </td> </tr> <tr> <td width="40%"><a
///                      id="FF_SCRIPT"></a><a id="ff_script"></a><dl> <dt><b>FF_SCRIPT</b></dt> </dl> </td> <td width="60%"> Fonts
///                      designed to look like handwriting. Script and Cursive are examples. </td> </tr> <tr> <td width="40%"><a
///                      id="FF_SWISS"></a><a id="ff_swiss"></a><dl> <dt><b>FF_SWISS</b></dt> </dl> </td> <td width="60%"> Fonts with
///                      variable stroke width and without serifs. MS?Sans Serif is an example. </td> </tr> </table> An application can
///                      specify a value for the <i>fdwPitchAndFamily</i> parameter by using the Boolean OR operator to join a pitch
///                      constant with a family constant. Font families describe the look of a font in a general way. They are intended
///                      for specifying fonts when the exact typeface requested is not available.
///    pszFaceName = A pointer to a null-terminated string that specifies the typeface name of the font. The length of this string
///                  must not exceed 32 characters, including the terminating null character. The EnumFontFamilies function can be
///                  used to enumerate the typeface names of all currently available fonts. For more information, see the Remarks. If
///                  <i>lpszFace</i> is <b>NULL</b> or empty string, GDI uses the first font that matches the other specified
///                  attributes.
///Returns:
///    If the function succeeds, the return value is a handle to a logical font. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HFONT CreateFontW(int cHeight, int cWidth, int cEscapement, int cOrientation, int cWeight, uint bItalic, 
                  uint bUnderline, uint bStrikeOut, uint iCharSet, uint iOutPrecision, uint iClipPrecision, 
                  uint iQuality, uint iPitchAndFamily, const(wchar)* pszFaceName);

///The <b>CreateHatchBrush</b> function creates a logical brush that has the specified hatch pattern and color.
///Params:
///    iHatch = The hatch style of the brush. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="HS_BDIAGONAL"></a><a id="hs_bdiagonal"></a><dl>
///             <dt><b>HS_BDIAGONAL</b></dt> </dl> </td> <td width="60%"> 45-degree upward left-to-right hatch </td> </tr> <tr>
///             <td width="40%"><a id="HS_CROSS"></a><a id="hs_cross"></a><dl> <dt><b>HS_CROSS</b></dt> </dl> </td> <td
///             width="60%"> Horizontal and vertical crosshatch </td> </tr> <tr> <td width="40%"><a id="HS_DIAGCROSS"></a><a
///             id="hs_diagcross"></a><dl> <dt><b>HS_DIAGCROSS</b></dt> </dl> </td> <td width="60%"> 45-degree crosshatch </td>
///             </tr> <tr> <td width="40%"><a id="HS_FDIAGONAL"></a><a id="hs_fdiagonal"></a><dl> <dt><b>HS_FDIAGONAL</b></dt>
///             </dl> </td> <td width="60%"> 45-degree downward left-to-right hatch </td> </tr> <tr> <td width="40%"><a
///             id="HS_HORIZONTAL"></a><a id="hs_horizontal"></a><dl> <dt><b>HS_HORIZONTAL</b></dt> </dl> </td> <td width="60%">
///             Horizontal hatch </td> </tr> <tr> <td width="40%"><a id="HS_VERTICAL"></a><a id="hs_vertical"></a><dl>
///             <dt><b>HS_VERTICAL</b></dt> </dl> </td> <td width="60%"> Vertical hatch </td> </tr> </table>
///    color = The foreground color of the brush that is used for the hatches. To create a COLORREF color value, use the RGB
///            macro.
///Returns:
///    If the function succeeds, the return value identifies a logical brush. If the function fails, the return value is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
HBRUSH CreateHatchBrush(int iHatch, uint color);

///The <b>CreateIC</b> function creates an information context for the specified device. The information context
///provides a fast way to get information about the device without creating a device context (DC). However, GDI drawing
///functions cannot accept a handle to an information context.
///Params:
///    pszDriver = A pointer to a null-terminated character string that specifies the name of the device driver (for example,
///                Epson).
///    pszDevice = A pointer to a null-terminated character string that specifies the name of the specific output device being used,
///                as shown by the Print Manager (for example, Epson FX-80). It is not the printer model name. The <i>lpszDevice</i>
///                parameter must be used.
///    pszPort = This parameter is ignored and should be set to <b>NULL</b>. It is provided only for compatibility with 16-bit
///              Windows.
///    pdm = A pointer to a DEVMODE structure containing device-specific initialization data for the device driver. The
///          DocumentProperties function retrieves this structure filled in for a specified device. The <i>lpdvmInit</i>
///          parameter must be <b>NULL</b> if the device driver is to use the default initialization (if any) specified by the
///          user.
///Returns:
///    If the function succeeds, the return value is the handle to an information context. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HDC CreateICA(const(char)* pszDriver, const(char)* pszDevice, const(char)* pszPort, const(DEVMODEA)* pdm);

///The <b>CreateIC</b> function creates an information context for the specified device. The information context
///provides a fast way to get information about the device without creating a device context (DC). However, GDI drawing
///functions cannot accept a handle to an information context.
///Params:
///    pszDriver = A pointer to a null-terminated character string that specifies the name of the device driver (for example,
///                Epson).
///    pszDevice = A pointer to a null-terminated character string that specifies the name of the specific output device being used,
///                as shown by the Print Manager (for example, Epson FX-80). It is not the printer model name. The <i>lpszDevice</i>
///                parameter must be used.
///    pszPort = This parameter is ignored and should be set to <b>NULL</b>. It is provided only for compatibility with 16-bit
///              Windows.
///    pdm = A pointer to a DEVMODE structure containing device-specific initialization data for the device driver. The
///          DocumentProperties function retrieves this structure filled in for a specified device. The <i>lpdvmInit</i>
///          parameter must be <b>NULL</b> if the device driver is to use the default initialization (if any) specified by the
///          user.
///Returns:
///    If the function succeeds, the return value is the handle to an information context. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HDC CreateICW(const(wchar)* pszDriver, const(wchar)* pszDevice, const(wchar)* pszPort, const(DEVMODEW)* pdm);

///The <b>CreateMetaFile</b> function creates a device context for a Windows-format metafile. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is CreateEnhMetaFile.</div><div> </div>
///Params:
///    pszFile = A pointer to the file name for the Windows-format metafile to be created. If this parameter is <b>NULL</b>, the
///              Windows-format metafile is memory based and its contents are lost when it is deleted by using the DeleteMetaFile
///              function.
///Returns:
///    If the function succeeds, the return value is a handle to the device context for the Windows-format metafile. If
///    the function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HdcMetdataFileHandle CreateMetaFileA(const(char)* pszFile);

///The <b>CreateMetaFile</b> function creates a device context for a Windows-format metafile. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is CreateEnhMetaFile.</div><div> </div>
///Params:
///    pszFile = A pointer to the file name for the Windows-format metafile to be created. If this parameter is <b>NULL</b>, the
///              Windows-format metafile is memory based and its contents are lost when it is deleted by using the DeleteMetaFile
///              function.
///Returns:
///    If the function succeeds, the return value is a handle to the device context for the Windows-format metafile. If
///    the function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HdcMetdataFileHandle CreateMetaFileW(const(wchar)* pszFile);

///The <b>CreatePalette</b> function creates a logical palette.
///Params:
///    plpal = A pointer to a LOGPALETTE structure that contains information about the colors in the logical palette.
///Returns:
///    If the function succeeds, the return value is a handle to a logical palette. If the function fails, the return
///    value is <b>NULL</b>.
///    
@DllImport("GDI32")
HPALETTE CreatePalette(char* plpal);

///The <b>CreatePen</b> function creates a logical pen that has the specified style, width, and color. The pen can
///subsequently be selected into a device context and used to draw lines and curves.
///Params:
///    iStyle = The pen style. It can be any one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///             <td width="40%"><a id="PS_SOLID"></a><a id="ps_solid"></a><dl> <dt><b>PS_SOLID</b></dt> </dl> </td> <td
///             width="60%"> The pen is solid. </td> </tr> <tr> <td width="40%"><a id="PS_DASH"></a><a id="ps_dash"></a><dl>
///             <dt><b>PS_DASH</b></dt> </dl> </td> <td width="60%"> The pen is dashed. This style is valid only when the pen
///             width is one or less in device units. </td> </tr> <tr> <td width="40%"><a id="PS_DOT"></a><a id="ps_dot"></a><dl>
///             <dt><b>PS_DOT</b></dt> </dl> </td> <td width="60%"> The pen is dotted. This style is valid only when the pen
///             width is one or less in device units. </td> </tr> <tr> <td width="40%"><a id="PS_DASHDOT"></a><a
///             id="ps_dashdot"></a><dl> <dt><b>PS_DASHDOT</b></dt> </dl> </td> <td width="60%"> The pen has alternating dashes
///             and dots. This style is valid only when the pen width is one or less in device units. </td> </tr> <tr> <td
///             width="40%"><a id="PS_DASHDOTDOT"></a><a id="ps_dashdotdot"></a><dl> <dt><b>PS_DASHDOTDOT</b></dt> </dl> </td>
///             <td width="60%"> The pen has alternating dashes and double dots. This style is valid only when the pen width is
///             one or less in device units. </td> </tr> <tr> <td width="40%"><a id="PS_NULL"></a><a id="ps_null"></a><dl>
///             <dt><b>PS_NULL</b></dt> </dl> </td> <td width="60%"> The pen is invisible. </td> </tr> <tr> <td width="40%"><a
///             id="PS_INSIDEFRAME"></a><a id="ps_insideframe"></a><dl> <dt><b>PS_INSIDEFRAME</b></dt> </dl> </td> <td
///             width="60%"> The pen is solid. When this pen is used in any GDI drawing function that takes a bounding rectangle,
///             the dimensions of the figure are shrunk so that it fits entirely in the bounding rectangle, taking into account
///             the width of the pen. This applies only to geometric pens. </td> </tr> </table>
///    cWidth = The width of the pen, in logical units. If <i>nWidth</i> is zero, the pen is a single pixel wide, regardless of
///             the current transformation. <b>CreatePen</b> returns a pen with the specified width but with the PS_SOLID style
///             if you specify a width greater than one for the following styles: PS_DASH, PS_DOT, PS_DASHDOT, PS_DASHDOTDOT.
///    color = A color reference for the pen color. To generate a COLORREF structure, use the RGB macro.
///Returns:
///    If the function succeeds, the return value is a handle that identifies a logical pen. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HPEN CreatePen(int iStyle, int cWidth, uint color);

///The <b>CreatePenIndirect</b> function creates a logical cosmetic pen that has the style, width, and color specified
///in a structure.
///Params:
///    plpen = Pointer to a LOGPEN structure that specifies the pen's style, width, and color.
///Returns:
///    If the function succeeds, the return value is a handle that identifies a logical cosmetic pen. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HPEN CreatePenIndirect(const(LOGPEN)* plpen);

///The <b>CreatePolyPolygonRgn</b> function creates a region consisting of a series of polygons. The polygons can
///overlap.
///Params:
///    pptl = A pointer to an array of POINT structures that define the vertices of the polygons in logical units. The polygons
///           are specified consecutively. Each polygon is presumed closed and each vertex is specified only once.
///    pc = A pointer to an array of integers, each of which specifies the number of points in one of the polygons in the
///         array pointed to by <i>lppt</i>.
///    cPoly = The total number of integers in the array pointed to by <i>lpPolyCounts</i>.
///    iMode = The fill mode used to determine which pixels are in the region. This parameter can be one of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ALTERNATE"></a><a
///            id="alternate"></a><dl> <dt><b>ALTERNATE</b></dt> </dl> </td> <td width="60%"> Selects alternate mode (fills area
///            between odd-numbered and even-numbered polygon sides on each scan line). </td> </tr> <tr> <td width="40%"><a
///            id="WINDING"></a><a id="winding"></a><dl> <dt><b>WINDING</b></dt> </dl> </td> <td width="60%"> Selects winding
///            mode (fills any region with a nonzero winding value). </td> </tr> </table> For more information about these
///            modes, see the SetPolyFillMode function.
///Returns:
///    If the function succeeds, the return value is the handle to the region. If the function fails, the return value
///    is zero.
///    
@DllImport("GDI32")
HRGN CreatePolyPolygonRgn(const(POINT)* pptl, char* pc, int cPoly, int iMode);

///The <b>CreatePatternBrush</b> function creates a logical brush with the specified bitmap pattern. The bitmap can be a
///DIB section bitmap, which is created by the <b>CreateDIBSection</b> function, or it can be a device-dependent bitmap.
///Params:
///    hbm = A handle to the bitmap to be used to create the logical brush.
///Returns:
///    If the function succeeds, the return value identifies a logical brush. If the function fails, the return value is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
HBRUSH CreatePatternBrush(HBITMAP hbm);

///The <b>CreateRectRgn</b> function creates a rectangular region.
///Params:
///    x1 = Specifies the x-coordinate of the upper-left corner of the region in logical units.
///    y1 = Specifies the y-coordinate of the upper-left corner of the region in logical units.
///    x2 = Specifies the x-coordinate of the lower-right corner of the region in logical units.
///    y2 = Specifies the y-coordinate of the lower-right corner of the region in logical units.
///Returns:
///    If the function succeeds, the return value is the handle to the region. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HRGN CreateRectRgn(int x1, int y1, int x2, int y2);

///The <b>CreateRectRgnIndirect</b> function creates a rectangular region.
///Params:
///    lprect = Pointer to a RECT structure that contains the coordinates of the upper-left and lower-right corners of the
///             rectangle that defines the region in logical units.
///Returns:
///    If the function succeeds, the return value is the handle to the region. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HRGN CreateRectRgnIndirect(const(RECT)* lprect);

///The <b>CreateRoundRectRgn</b> function creates a rectangular region with rounded corners.
///Params:
///    x1 = Specifies the x-coordinate of the upper-left corner of the region in device units.
///    y1 = Specifies the y-coordinate of the upper-left corner of the region in device units.
///    x2 = Specifies the x-coordinate of the lower-right corner of the region in device units.
///    y2 = Specifies the y-coordinate of the lower-right corner of the region in device units.
///    w = Specifies the width of the ellipse used to create the rounded corners in device units.
///    h = Specifies the height of the ellipse used to create the rounded corners in device units.
///Returns:
///    If the function succeeds, the return value is the handle to the region. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HRGN CreateRoundRectRgn(int x1, int y1, int x2, int y2, int w, int h);

///<p class="CCE_Message">[The <b>CreateScalableFontResource</b> function is available for use in the operating systems
///specified in the Requirements section. It may be altered or unavailable in subsequent versions.] The
///<b>CreateScalableFontResource</b> function creates a font resource file for a scalable font.
///Params:
///    fdwHidden = Specifies whether the font is a read-only font. This parameter can be one of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///                width="60%"> The font has read/write permission. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl>
///                <dt><b>1</b></dt> </dl> </td> <td width="60%"> The font has read-only permission and should be hidden from other
///                applications in the system. When this flag is set, the font is not enumerated by the EnumFonts or
///                EnumFontFamilies function. </td> </tr> </table>
///    lpszFont = A pointer to a null-terminated string specifying the name of the font resource file to create. If this parameter
///               specifies an existing font resource file, the function fails.
///    lpszFile = A pointer to a null-terminated string specifying the name of the scalable font file that this function uses to
///               create the font resource file.
///    lpszPath = A pointer to a null-terminated string specifying the path to the scalable font file.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. If
///    <i>lpszFontRes</i> specifies an existing font file, GetLastError returns ERROR_FILE_EXISTS
///    
@DllImport("GDI32")
BOOL CreateScalableFontResourceA(uint fdwHidden, const(char)* lpszFont, const(char)* lpszFile, 
                                 const(char)* lpszPath);

///<p class="CCE_Message">[The <b>CreateScalableFontResource</b> function is available for use in the operating systems
///specified in the Requirements section. It may be altered or unavailable in subsequent versions.] The
///<b>CreateScalableFontResource</b> function creates a font resource file for a scalable font.
///Params:
///    fdwHidden = Specifies whether the font is a read-only font. This parameter can be one of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///                width="60%"> The font has read/write permission. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl>
///                <dt><b>1</b></dt> </dl> </td> <td width="60%"> The font has read-only permission and should be hidden from other
///                applications in the system. When this flag is set, the font is not enumerated by the EnumFonts or
///                EnumFontFamilies function. </td> </tr> </table>
///    lpszFont = A pointer to a null-terminated string specifying the name of the font resource file to create. If this parameter
///               specifies an existing font resource file, the function fails.
///    lpszFile = A pointer to a null-terminated string specifying the name of the scalable font file that this function uses to
///               create the font resource file.
///    lpszPath = A pointer to a null-terminated string specifying the path to the scalable font file.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. If
///    <i>lpszFontRes</i> specifies an existing font file, GetLastError returns ERROR_FILE_EXISTS
///    
@DllImport("GDI32")
BOOL CreateScalableFontResourceW(uint fdwHidden, const(wchar)* lpszFont, const(wchar)* lpszFile, 
                                 const(wchar)* lpszPath);

///The <b>CreateSolidBrush</b> function creates a logical brush that has the specified solid color.
///Params:
///    color = The color of the brush. To create a COLORREF color value, use the RGB macro.
///Returns:
///    If the function succeeds, the return value identifies a logical brush. If the function fails, the return value is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
HBRUSH CreateSolidBrush(uint color);

///The <b>DeleteDC</b> function deletes the specified device context (DC).
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL DeleteDC(HDC hdc);

///The <b>DeleteMetaFile</b> function deletes a Windows-format metafile or Windows-format metafile handle. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is DeleteEnhMetaFile.</div><div> </div>
///Params:
///    hmf = A handle to a Windows-format metafile.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL DeleteMetaFile(ptrdiff_t hmf);

///The <b>DeleteObject</b> function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system
///resources associated with the object. After the object is deleted, the specified handle is no longer valid.
///Params:
///    ho = A handle to a logical pen, brush, font, bitmap, region, or palette.
///Returns:
///    If the function succeeds, the return value is nonzero. If the specified handle is not valid or is currently
///    selected into a DC, the return value is zero.
///    
@DllImport("GDI32")
BOOL DeleteObject(ptrdiff_t ho);

///The <b>DrawEscape</b> function provides drawing capabilities of the specified video display that are not directly
///available through the graphics device interface (GDI).
///Params:
///    hdc = A handle to the DC for the specified video display.
///    iEscape = The escape function to be performed.
///    cjIn = The number of bytes of data pointed to by the <i>lpszInData</i> parameter.
///    lpIn = A pointer to the input structure required for the specified escape.
///Returns:
///    If the function is successful, the return value is greater than zero except for the QUERYESCSUPPORT draw escape,
///    which checks for implementation only. If the escape is not implemented, the return value is zero. If an error
///    occurred, the return value is less than zero.
///    
@DllImport("GDI32")
int DrawEscape(HDC hdc, int iEscape, int cjIn, const(char)* lpIn);

///The <b>Ellipse</b> function draws an ellipse. The center of the ellipse is the center of the specified bounding
///rectangle. The ellipse is outlined by using the current pen and is filled by using the current brush.
///Params:
///    hdc = A handle to the device context.
///    left = The x-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
///    top = The y-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
///    right = The x-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
///    bottom = The y-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL Ellipse(HDC hdc, int left, int top, int right, int bottom);

///The <b>EnumFontFamiliesEx</b> function enumerates all uniquely-named fonts in the system that match the font
///characteristics specified by the LOGFONT structure. <b>EnumFontFamiliesEx</b> enumerates fonts based on typeface
///name, character set, or both.
///Params:
///    hdc = A handle to the device context from which to enumerate the fonts.
///    lpLogfont = A pointer to a LOGFONT structure that contains information about the fonts to enumerate. The function examines
///                the following members. <table> <tr> <th>Member</th> <th>Description</th> </tr> <tr> <td><b>lfCharSet</b></td>
///                <td>If set to DEFAULT_CHARSET, the function enumerates all uniquely-named fonts in all character sets. (If there
///                are two fonts with the same name, only one is enumerated.) If set to a valid character set value, the function
///                enumerates only fonts in the specified character set.</td> </tr> <tr> <td><b>lfFaceName</b></td> <td>If set to an
///                empty string, the function enumerates one font in each available typeface name. If set to a valid typeface name,
///                the function enumerates all fonts with the specified name.</td> </tr> <tr> <td><b>lfPitchAndFamily</b></td>
///                <td>Must be set to zero for all language versions of the operating system.</td> </tr> </table>
///    lpProc = A pointer to the application defined callback function. For more information, see the EnumFontFamExProc function.
///    lParam = An application defined value. The function passes this value to the callback function along with font
///             information.
///    dwFlags = This parameter is not used and must be zero.
///Returns:
///    The return value is the last value returned by the callback function. This value depends on which font families
///    are available for the specified device.
///    
@DllImport("GDI32")
int EnumFontFamiliesExA(HDC hdc, LOGFONTA* lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam, uint dwFlags);

///The <b>EnumFontFamiliesEx</b> function enumerates all uniquely-named fonts in the system that match the font
///characteristics specified by the LOGFONT structure. <b>EnumFontFamiliesEx</b> enumerates fonts based on typeface
///name, character set, or both.
///Params:
///    hdc = A handle to the device context from which to enumerate the fonts.
///    lpLogfont = A pointer to a LOGFONT structure that contains information about the fonts to enumerate. The function examines
///                the following members. <table> <tr> <th>Member</th> <th>Description</th> </tr> <tr> <td><b>lfCharSet</b></td>
///                <td>If set to DEFAULT_CHARSET, the function enumerates all uniquely-named fonts in all character sets. (If there
///                are two fonts with the same name, only one is enumerated.) If set to a valid character set value, the function
///                enumerates only fonts in the specified character set.</td> </tr> <tr> <td><b>lfFaceName</b></td> <td>If set to an
///                empty string, the function enumerates one font in each available typeface name. If set to a valid typeface name,
///                the function enumerates all fonts with the specified name.</td> </tr> <tr> <td><b>lfPitchAndFamily</b></td>
///                <td>Must be set to zero for all language versions of the operating system.</td> </tr> </table>
///    lpProc = A pointer to the application defined callback function. For more information, see the EnumFontFamExProc function.
///    lParam = An application defined value. The function passes this value to the callback function along with font
///             information.
///    dwFlags = This parameter is not used and must be zero.
///Returns:
///    The return value is the last value returned by the callback function. This value depends on which font families
///    are available for the specified device.
///    
@DllImport("GDI32")
int EnumFontFamiliesExW(HDC hdc, LOGFONTW* lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam, uint dwFlags);

///The <b>EnumFontFamilies</b> function enumerates the fonts in a specified font family that are available on a
///specified device. <div class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit
///versions of Windows. Applications should use the EnumFontFamiliesEx function.</div><div> </div>
///Params:
///    hdc = A handle to the device context from which to enumerate the fonts.
///    lpLogfont = A pointer to a null-terminated string that specifies the family name of the desired fonts. If <i>lpszFamily</i>
///                is <b>NULL</b>, <b>EnumFontFamilies</b> selects and enumerates one font of each available type family.
///    lpProc = A pointer to the application defined callback function. For information, see EnumFontFamProc.
///    lParam = A pointer to application-supplied data. The data is passed to the callback function along with the font
///             information.
///Returns:
///    The return value is the last value returned by the callback function. Its meaning is implementation specific.
///    
@DllImport("GDI32")
int EnumFontFamiliesA(HDC hdc, const(char)* lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam);

///The <b>EnumFontFamilies</b> function enumerates the fonts in a specified font family that are available on a
///specified device. <div class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit
///versions of Windows. Applications should use the EnumFontFamiliesEx function.</div><div> </div>
///Params:
///    hdc = A handle to the device context from which to enumerate the fonts.
///    lpLogfont = A pointer to a null-terminated string that specifies the family name of the desired fonts. If <i>lpszFamily</i>
///                is <b>NULL</b>, <b>EnumFontFamilies</b> selects and enumerates one font of each available type family.
///    lpProc = A pointer to the application defined callback function. For information, see EnumFontFamProc.
///    lParam = A pointer to application-supplied data. The data is passed to the callback function along with the font
///             information.
///Returns:
///    The return value is the last value returned by the callback function. Its meaning is implementation specific.
///    
@DllImport("GDI32")
int EnumFontFamiliesW(HDC hdc, const(wchar)* lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam);

///The <b>EnumFonts</b> function enumerates the fonts available on a specified device. For each font with the specified
///typeface name, the <b>EnumFonts</b> function retrieves information about that font and passes it to the application
///defined callback function. This callback function can process the font information as desired. Enumeration continues
///until there are no more fonts or the callback function returns zero. <div class="alert"><b>Note</b> This function is
///provided only for compatibility with 16-bit versions of Windows. Applications should use the EnumFontFamiliesEx
///function.</div><div> </div>
///Params:
///    hdc = A handle to the device context from which to enumerate the fonts.
///    lpLogfont = A pointer to a null-terminated string that specifies the typeface name of the desired fonts. If <i>lpFaceName</i>
///                is <b>NULL</b>, <b>EnumFonts</b> randomly selects and enumerates one font of each available typeface.
///    lpProc = A pointer to the application definedcallback function. For more information, see EnumFontsProc.
///    lParam = A pointer to any application-defined data. The data is passed to the callback function along with the font
///             information.
///Returns:
///    The return value is the last value returned by the callback function. Its meaning is defined by the application.
///    
@DllImport("GDI32")
int EnumFontsA(HDC hdc, const(char)* lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam);

///The <b>EnumFonts</b> function enumerates the fonts available on a specified device. For each font with the specified
///typeface name, the <b>EnumFonts</b> function retrieves information about that font and passes it to the application
///defined callback function. This callback function can process the font information as desired. Enumeration continues
///until there are no more fonts or the callback function returns zero. <div class="alert"><b>Note</b> This function is
///provided only for compatibility with 16-bit versions of Windows. Applications should use the EnumFontFamiliesEx
///function.</div><div> </div>
///Params:
///    hdc = A handle to the device context from which to enumerate the fonts.
///    lpLogfont = A pointer to a null-terminated string that specifies the typeface name of the desired fonts. If <i>lpFaceName</i>
///                is <b>NULL</b>, <b>EnumFonts</b> randomly selects and enumerates one font of each available typeface.
///    lpProc = A pointer to the application definedcallback function. For more information, see EnumFontsProc.
///    lParam = A pointer to any application-defined data. The data is passed to the callback function along with the font
///             information.
///Returns:
///    The return value is the last value returned by the callback function. Its meaning is defined by the application.
///    
@DllImport("GDI32")
int EnumFontsW(HDC hdc, const(wchar)* lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam);

///The <b>EnumObjects</b> function enumerates the pens or brushes available for the specified device context (DC). This
///function calls the application-defined callback function once for each available object, supplying data describing
///that object. <b>EnumObjects</b> continues calling the callback function until the callback function returns zero or
///until all of the objects have been enumerated.
///Params:
///    hdc = A handle to the DC.
///    nType = The object type. This parameter can be OBJ_BRUSH or OBJ_PEN.
///    lpFunc = A pointer to the application-defined callback function. For more information about the callback function, see the
///             EnumObjectsProc function.
///    lParam = A pointer to the application-defined data. The data is passed to the callback function along with the object
///             information.
///Returns:
///    If the function succeeds, the return value is the last value returned by the callback function. Its meaning is
///    user-defined. If the objects cannot be enumerated (for example, there are too many objects), the function returns
///    zero without calling the callback function.
///    
@DllImport("GDI32")
int EnumObjects(HDC hdc, int nType, GOBJENUMPROC lpFunc, LPARAM lParam);

///The <b>EqualRgn</b> function checks the two specified regions to determine whether they are identical. The function
///considers two regions identical if they are equal in size and shape.
///Params:
///    hrgn1 = Handle to a region.
///    hrgn2 = Handle to a region.
///Returns:
///    If the two regions are equal, the return value is nonzero. If the two regions are not equal, the return value is
///    zero. A return value of ERROR means at least one of the region handles is invalid.
///    
@DllImport("GDI32")
BOOL EqualRgn(HRGN hrgn1, HRGN hrgn2);

///The <b>ExcludeClipRect</b> function creates a new clipping region that consists of the existing clipping region minus
///the specified rectangle.
///Params:
///    hdc = A handle to the device context.
///    left = The x-coordinate, in logical units, of the upper-left corner of the rectangle.
///    top = The y-coordinate, in logical units, of the upper-left corner of the rectangle.
///    right = The x-coordinate, in logical units, of the lower-right corner of the rectangle.
///    bottom = The y-coordinate, in logical units, of the lower-right corner of the rectangle.
///Returns:
///    The return value specifies the new clipping region's complexity; it can be one of the following values. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULLREGION</b></dt> </dl>
///    </td> <td width="60%"> Region is empty. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SIMPLEREGION</b></dt> </dl>
///    </td> <td width="60%"> Region is a single rectangle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> Region is more than one rectangle. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> No region was created. </td> </tr>
///    </table>
///    
@DllImport("GDI32")
int ExcludeClipRect(HDC hdc, int left, int top, int right, int bottom);

///The <b>ExtCreateRegion</b> function creates a region from the specified region and transformation data.
///Params:
///    lpx = A pointer to an XFORM structure that defines the transformation to be performed on the region. If this pointer is
///          <b>NULL</b>, the identity transformation is used.
///    nCount = The number of bytes pointed to by <i>lpRgnData</i>.
///    lpData = A pointer to a RGNDATA structure that contains the region data in logical units.
///Returns:
///    If the function succeeds, the return value is the value of the region. If the function fails, the return value is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
HRGN ExtCreateRegion(const(XFORM)* lpx, uint nCount, char* lpData);

///The <b>ExtFloodFill</b> function fills an area of the display surface with the current brush.
///Params:
///    hdc = A handle to a device context.
///    x = The x-coordinate, in logical units, of the point where filling is to start.
///    y = The y-coordinate, in logical units, of the point where filling is to start.
///    color = The color of the boundary or of the area to be filled. The interpretation of <i>color</i> depends on the value of
///            the <i>fuFillType</i> parameter. To create a COLORREF color value, use the RGB macro.
///    type = The type of fill operation to be performed. This parameter must be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FLOODFILLBORDER"></a><a
///           id="floodfillborder"></a><dl> <dt><b>FLOODFILLBORDER</b></dt> </dl> </td> <td width="60%"> The fill area is
///           bounded by the color specified by the <i>color</i> parameter. This style is identical to the filling performed by
///           the FloodFill function. </td> </tr> <tr> <td width="40%"><a id="FLOODFILLSURFACE"></a><a
///           id="floodfillsurface"></a><dl> <dt><b>FLOODFILLSURFACE</b></dt> </dl> </td> <td width="60%"> The fill area is
///           defined by the color that is specified by <i>color</i>. Filling continues outward in all directions as long as
///           the color is encountered. This style is useful for filling areas with multicolored boundaries. </td> </tr>
///           </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ExtFloodFill(HDC hdc, int x, int y, uint color, uint type);

///The <b>FillRgn</b> function fills a region by using the specified brush.
///Params:
///    hdc = Handle to the device context.
///    hrgn = Handle to the region to be filled. The region's coordinates are presumed to be in logical units.
///    hbr = Handle to the brush to be used to fill the region.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL FillRgn(HDC hdc, HRGN hrgn, HBRUSH hbr);

///The <b>FloodFill</b> function fills an area of the display surface with the current brush. The area is assumed to be
///bounded as specified by the <i>color</i> parameter. <div class="alert"><b>Note</b> The <b>FloodFill</b> function is
///included only for compatibility with 16-bit versions of Windows. Applications should use the ExtFloodFill function
///with FLOODFILLBORDER specified.</div><div> </div>
///Params:
///    hdc = A handle to a device context.
///    x = The x-coordinate, in logical units, of the point where filling is to start.
///    y = The y-coordinate, in logical units, of the point where filling is to start.
///    color = The color of the boundary or the area to be filled. To create a COLORREF color value, use the RGB macro.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL FloodFill(HDC hdc, int x, int y, uint color);

///The <b>FrameRgn</b> function draws a border around the specified region by using the specified brush.
///Params:
///    hdc = Handle to the device context.
///    hrgn = Handle to the region to be enclosed in a border. The region's coordinates are presumed to be in logical units.
///    hbr = Handle to the brush to be used to draw the border.
///    w = Specifies the width, in logical units, of vertical brush strokes.
///    h = Specifies the height, in logical units, of horizontal brush strokes.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL FrameRgn(HDC hdc, HRGN hrgn, HBRUSH hbr, int w, int h);

///The <b>GetROP2</b> function retrieves the foreground mix mode of the specified device context. The mix mode specifies
///how the pen or interior color and the color already on the screen are combined to yield a new color.
///Params:
///    hdc = Handle to the device context.
///Returns:
///    If the function succeeds, the return value specifies the foreground mix mode. If the function fails, the return
///    value is zero.
///    
@DllImport("GDI32")
int GetROP2(HDC hdc);

///The <b>GetAspectRatioFilterEx</b> function retrieves the setting for the current aspect-ratio filter.
///Params:
///    hdc = Handle to a device context.
///    lpsize = Pointer to a SIZE structure that receives the current aspect-ratio filter.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetAspectRatioFilterEx(HDC hdc, SIZE* lpsize);

///The <b>GetBkColor</b> function returns the current background color for the specified device context.
///Params:
///    hdc = Handle to the device context whose background color is to be returned.
///Returns:
///    If the function succeeds, the return value is a COLORREF value for the current background color. If the function
///    fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint GetBkColor(HDC hdc);

///The <b>GetDCBrushColor</b> function retrieves the current brush color for the specified device context (DC).
///Params:
///    hdc = A handle to the DC whose brush color is to be returned.
///Returns:
///    If the function succeeds, the return value is the COLORREF value for the current DC brush color. If the function
///    fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint GetDCBrushColor(HDC hdc);

///The <b>GetDCPenColor</b> function retrieves the current pen color for the specified device context (DC).
///Params:
///    hdc = A handle to the DC whose brush color is to be returned.
///Returns:
///    If the function succeeds, the return value is a COLORREF value for the current DC pen color. If the function
///    fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint GetDCPenColor(HDC hdc);

///The <b>GetBkMode</b> function returns the current background mix mode for a specified device context. The background
///mix mode of a device context affects text, hatched brushes, and pen styles that are not solid lines.
///Params:
///    hdc = Handle to the device context whose background mode is to be returned.
///Returns:
///    If the function succeeds, the return value specifies the current background mix mode, either OPAQUE or
///    TRANSPARENT. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
int GetBkMode(HDC hdc);

///The <b>GetBitmapBits</b> function copies the bitmap bits of a specified device-dependent bitmap into a buffer. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should use the GetDIBits function.</div><div> </div>
///Params:
///    hbit = A handle to the device-dependent bitmap.
///    cb = The number of bytes to copy from the bitmap into the buffer.
///    lpvBits = A pointer to a buffer to receive the bitmap bits. The bits are stored as an array of byte values.
///Returns:
///    If the function succeeds, the return value is the number of bytes copied to the buffer. If the function fails,
///    the return value is zero.
///    
@DllImport("GDI32")
int GetBitmapBits(HBITMAP hbit, int cb, char* lpvBits);

///The <b>GetBitmapDimensionEx</b> function retrieves the dimensions of a compatible bitmap. The retrieved dimensions
///must have been set by the SetBitmapDimensionEx function.
///Params:
///    hbit = A handle to a compatible bitmap (DDB).
///    lpsize = A pointer to a SIZE structure to receive the bitmap dimensions. For more information, see Remarks.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetBitmapDimensionEx(HBITMAP hbit, SIZE* lpsize);

///The <b>GetBoundsRect</b> function obtains the current accumulated bounding rectangle for a specified device context.
///The system maintains an accumulated bounding rectangle for each application. An application can retrieve and set this
///rectangle.
///Params:
///    hdc = A handle to the device context whose bounding rectangle the function will return.
///    lprect = A pointer to the RECT structure that will receive the current bounding rectangle. The application's rectangle is
///             returned in logical coordinates, and the bounding rectangle is returned in screen coordinates.
///    flags = Specifies how the <b>GetBoundsRect</b> function will behave. This parameter can be the following value. <table>
///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DCB_RESET"></a><a id="dcb_reset"></a><dl>
///            <dt><b>DCB_RESET</b></dt> </dl> </td> <td width="60%"> Clears the bounding rectangle after returning it. If this
///            flag is not set, the bounding rectangle will not be cleared. </td> </tr> </table>
///Returns:
///    The return value specifies the state of the accumulated bounding rectangle; it can be one of the following
///    values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>0</td> <td>An error occurred. The specified
///    device context handle is invalid.</td> </tr> <tr> <td>DCB_DISABLE</td> <td>Boundary accumulation is off.</td>
///    </tr> <tr> <td>DCB_ENABLE</td> <td>Boundary accumulation is on.</td> </tr> <tr> <td>DCB_RESET</td> <td>The
///    bounding rectangle is empty.</td> </tr> <tr> <td>DCB_SET</td> <td>The bounding rectangle is not empty.</td> </tr>
///    </table>
///    
@DllImport("GDI32")
uint GetBoundsRect(HDC hdc, RECT* lprect, uint flags);

///The <b>GetBrushOrgEx</b> function retrieves the current brush origin for the specified device context. This function
///replaces the <b>GetBrushOrg</b> function.
///Params:
///    hdc = A handle to the device context.
///    lppt = A pointer to a POINT structure that receives the brush origin, in device coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetBrushOrgEx(HDC hdc, POINT* lppt);

///The <b>GetCharWidth</b> function retrieves the widths, in logical coordinates, of consecutive characters in a
///specified range from the current font. <div class="alert"><b>Note</b> This function is provided only for
///compatibility with 16-bit versions of Windows. Applications should call the GetCharWidth32 function, which provides
///more accurate results.</div><div> </div>
///Params:
///    hdc = A handle to the device context.
///    iFirst = The first character in the group of consecutive characters.
///    iLast = The last character in the group of consecutive characters, which must not precede the specified first character.
///    lpBuffer = A pointer to a buffer that receives the character widths, in logical coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharWidthA(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

///The <b>GetCharWidth</b> function retrieves the widths, in logical coordinates, of consecutive characters in a
///specified range from the current font. <div class="alert"><b>Note</b> This function is provided only for
///compatibility with 16-bit versions of Windows. Applications should call the GetCharWidth32 function, which provides
///more accurate results.</div><div> </div>
///Params:
///    hdc = A handle to the device context.
///    iFirst = The first character in the group of consecutive characters.
///    iLast = The last character in the group of consecutive characters, which must not precede the specified first character.
///    lpBuffer = A pointer to a buffer that receives the character widths, in logical coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharWidthW(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

///The <b>GetCharWidth32</b> function retrieves the widths, in logical coordinates, of consecutive characters in a
///specified range from the current font.
///Params:
///    hdc = A handle to the device context.
///    iFirst = The first character in the group of consecutive characters.
///    iLast = The last character in the group of consecutive characters, which must not precede the specified first character.
///    lpBuffer = A pointer to a buffer that receives the character widths, in logical coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharWidth32A(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

///The <b>GetCharWidth32</b> function retrieves the widths, in logical coordinates, of consecutive characters in a
///specified range from the current font.
///Params:
///    hdc = A handle to the device context.
///    iFirst = The first character in the group of consecutive characters.
///    iLast = The last character in the group of consecutive characters, which must not precede the specified first character.
///    lpBuffer = A pointer to a buffer that receives the character widths, in logical coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharWidth32W(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

///The <b>GetCharWidthFloat</b> function retrieves the fractional widths of consecutive characters in a specified range
///from the current font.
///Params:
///    hdc = A handle to the device context.
///    iFirst = The code point of the first character in the group of consecutive characters.
///    iLast = The code point of the last character in the group of consecutive characters.
///    lpBuffer = A pointer to a buffer that receives the character widths, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharWidthFloatA(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

///The <b>GetCharWidthFloat</b> function retrieves the fractional widths of consecutive characters in a specified range
///from the current font.
///Params:
///    hdc = A handle to the device context.
///    iFirst = The code point of the first character in the group of consecutive characters.
///    iLast = The code point of the last character in the group of consecutive characters.
///    lpBuffer = A pointer to a buffer that receives the character widths, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharWidthFloatW(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

///The <b>GetCharABCWidths</b> function retrieves the widths, in logical units, of consecutive characters in a specified
///range from the current TrueType font. This function succeeds only with TrueType fonts.
///Params:
///    hdc = A handle to the device context.
///    wFirst = The first character in the group of consecutive characters from the current font.
///    wLast = The last character in the group of consecutive characters from the current font.
///    lpABC = A pointer to an array of ABC structures that receives the character widths, in logical units. This array must
///            contain at least as many <b>ABC</b> structures as there are characters in the range specified by the
///            <i>uFirstChar</i> and <i>uLastChar</i> parameters.
///Returns:
///    If the function succeeds, the return value is nonzero If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharABCWidthsA(HDC hdc, uint wFirst, uint wLast, char* lpABC);

///The <b>GetCharABCWidths</b> function retrieves the widths, in logical units, of consecutive characters in a specified
///range from the current TrueType font. This function succeeds only with TrueType fonts.
///Params:
///    hdc = A handle to the device context.
///    wFirst = The first character in the group of consecutive characters from the current font.
///    wLast = The last character in the group of consecutive characters from the current font.
///    lpABC = A pointer to an array of ABC structures that receives the character widths, in logical units. This array must
///            contain at least as many <b>ABC</b> structures as there are characters in the range specified by the
///            <i>uFirstChar</i> and <i>uLastChar</i> parameters.
///Returns:
///    If the function succeeds, the return value is nonzero If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharABCWidthsW(HDC hdc, uint wFirst, uint wLast, char* lpABC);

///The <b>GetCharABCWidthsFloat</b> function retrieves the widths, in logical units, of consecutive characters in a
///specified range from the current font.
///Params:
///    hdc = Handle to the device context.
///    iFirst = Specifies the code point of the first character in the group of consecutive characters where the ABC widths are
///             seeked.
///    iLast = Specifies the code point of the last character in the group of consecutive characters where the ABC widths are
///            seeked. This range is inclusive. An error is returned if the specified last character precedes the specified
///            first character.
///    lpABC = Pointer to an array of ABCFLOAT structures that receives the character widths, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharABCWidthsFloatA(HDC hdc, uint iFirst, uint iLast, char* lpABC);

///The <b>GetCharABCWidthsFloat</b> function retrieves the widths, in logical units, of consecutive characters in a
///specified range from the current font.
///Params:
///    hdc = Handle to the device context.
///    iFirst = Specifies the code point of the first character in the group of consecutive characters where the ABC widths are
///             seeked.
///    iLast = Specifies the code point of the last character in the group of consecutive characters where the ABC widths are
///            seeked. This range is inclusive. An error is returned if the specified last character precedes the specified
///            first character.
///    lpABC = Pointer to an array of ABCFLOAT structures that receives the character widths, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharABCWidthsFloatW(HDC hdc, uint iFirst, uint iLast, char* lpABC);

///The <b>GetClipBox</b> function retrieves the dimensions of the tightest bounding rectangle that can be drawn around
///the current visible area on the device. The visible area is defined by the current clipping region or clip path, as
///well as any overlapping windows.
///Params:
///    hdc = A handle to the device context.
///    lprect = A pointer to a RECT structure that is to receive the rectangle dimensions, in logical units.
///Returns:
///    If the function succeeds, the return value specifies the clipping box's complexity and can be one of the
///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NULLREGION</b></dt> </dl> </td> <td width="60%"> Region is empty. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SIMPLEREGION</b></dt> </dl> </td> <td width="60%"> Region is a single rectangle. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> Region is more than one rectangle.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred.
///    </td> </tr> </table> <b>GetClipBox</b> returns logical coordinates based on the given device context.
///    
@DllImport("GDI32")
int GetClipBox(HDC hdc, RECT* lprect);

///The <b>GetClipRgn</b> function retrieves a handle identifying the current application-defined clipping region for the
///specified device context.
///Params:
///    hdc = A handle to the device context.
///    hrgn = A handle to an existing region before the function is called. After the function returns, this parameter is a
///           handle to a copy of the current clipping region.
///Returns:
///    If the function succeeds and there is no clipping region for the given device context, the return value is zero.
///    If the function succeeds and there is a clipping region for the given device context, the return value is 1. If
///    an error occurs, the return value is -1.
///    
@DllImport("GDI32")
int GetClipRgn(HDC hdc, HRGN hrgn);

///The <b>GetMetaRgn</b> function retrieves the current metaregion for the specified device context.
///Params:
///    hdc = A handle to the device context.
///    hrgn = A handle to an existing region before the function is called. After the function returns, this parameter is a
///           handle to a copy of the current metaregion.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
int GetMetaRgn(HDC hdc, HRGN hrgn);

///The <b>GetCurrentObject</b> function retrieves a handle to an object of the specified type that has been selected
///into the specified device context (DC).
///Params:
///    hdc = A handle to the DC.
///    type = The object type to be queried. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OBJ_BITMAP"></a><a id="obj_bitmap"></a><dl>
///           <dt><b>OBJ_BITMAP</b></dt> </dl> </td> <td width="60%"> Returns the current selected bitmap. </td> </tr> <tr> <td
///           width="40%"><a id="OBJ_BRUSH"></a><a id="obj_brush"></a><dl> <dt><b>OBJ_BRUSH</b></dt> </dl> </td> <td
///           width="60%"> Returns the current selected brush. </td> </tr> <tr> <td width="40%"><a id="OBJ_COLORSPACE"></a><a
///           id="obj_colorspace"></a><dl> <dt><b>OBJ_COLORSPACE</b></dt> </dl> </td> <td width="60%"> Returns the current
///           color space. </td> </tr> <tr> <td width="40%"><a id="OBJ_FONT"></a><a id="obj_font"></a><dl>
///           <dt><b>OBJ_FONT</b></dt> </dl> </td> <td width="60%"> Returns the current selected font. </td> </tr> <tr> <td
///           width="40%"><a id="OBJ_PAL"></a><a id="obj_pal"></a><dl> <dt><b>OBJ_PAL</b></dt> </dl> </td> <td width="60%">
///           Returns the current selected palette. </td> </tr> <tr> <td width="40%"><a id="OBJ_PEN"></a><a
///           id="obj_pen"></a><dl> <dt><b>OBJ_PEN</b></dt> </dl> </td> <td width="60%"> Returns the current selected pen.
///           </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a handle to the specified object. If the function fails, the return
///    value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t GetCurrentObject(HDC hdc, uint type);

///The <b>GetCurrentPositionEx</b> function retrieves the current position in logical coordinates.
///Params:
///    hdc = A handle to the device context.
///    lppt = A pointer to a POINT structure that receives the logical coordinates of the current position.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCurrentPositionEx(HDC hdc, POINT* lppt);

///The <b>GetDeviceCaps</b> function retrieves device-specific information for the specified device.
///Params:
///    hdc = A handle to the DC.
///    index = The item to be returned. This parameter can be one of the following values. <table> <tr> <th>Index</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DRIVERVERSION"></a><a id="driverversion"></a><dl>
///            <dt><b>DRIVERVERSION</b></dt> </dl> </td> <td width="60%"> The device driver version. </td> </tr> <tr> <td
///            width="40%"><a id="TECHNOLOGY"></a><a id="technology"></a><dl> <dt><b>TECHNOLOGY</b></dt> </dl> </td> <td
///            width="60%"> Device technology. It can be any one of the following values. <table> <tr> <td>DT_PLOTTER</td>
///            <td>Vector plotter</td> </tr> <tr> <td>DT_RASDISPLAY</td> <td>Raster display</td> </tr> <tr>
///            <td>DT_RASPRINTER</td> <td>Raster printer</td> </tr> <tr> <td>DT_RASCAMERA</td> <td>Raster camera</td> </tr> <tr>
///            <td>DT_CHARSTREAM</td> <td>Character stream</td> </tr> <tr> <td>DT_METAFILE</td> <td>Metafile</td> </tr> <tr>
///            <td>DT_DISPFILE</td> <td>Display file</td> </tr> </table> If the <i>hdc</i> parameter is a handle to the DC of an
///            enhanced metafile, the device technology is that of the referenced device as specified to the CreateEnhMetaFile
///            function. To determine whether it is an enhanced metafile DC, use the GetObjectType function. </td> </tr> <tr>
///            <td width="40%"><a id="HORZSIZE"></a><a id="horzsize"></a><dl> <dt><b>HORZSIZE</b></dt> </dl> </td> <td
///            width="60%"> Width, in millimeters, of the physical screen. </td> </tr> <tr> <td width="40%"><a
///            id="VERTSIZE"></a><a id="vertsize"></a><dl> <dt><b>VERTSIZE</b></dt> </dl> </td> <td width="60%"> Height, in
///            millimeters, of the physical screen. </td> </tr> <tr> <td width="40%"><a id="HORZRES"></a><a
///            id="horzres"></a><dl> <dt><b>HORZRES</b></dt> </dl> </td> <td width="60%"> Width, in pixels, of the screen; or
///            for printers, the width, in pixels, of the printable area of the page. </td> </tr> <tr> <td width="40%"><a
///            id="VERTRES"></a><a id="vertres"></a><dl> <dt><b>VERTRES</b></dt> </dl> </td> <td width="60%"> Height, in raster
///            lines, of the screen; or for printers, the height, in pixels, of the printable area of the page. </td> </tr> <tr>
///            <td width="40%"><a id="LOGPIXELSX"></a><a id="logpixelsx"></a><dl> <dt><b>LOGPIXELSX</b></dt> </dl> </td> <td
///            width="60%"> Number of pixels per logical inch along the screen width. In a system with multiple display
///            monitors, this value is the same for all monitors. </td> </tr> <tr> <td width="40%"><a id="LOGPIXELSY"></a><a
///            id="logpixelsy"></a><dl> <dt><b>LOGPIXELSY</b></dt> </dl> </td> <td width="60%"> Number of pixels per logical
///            inch along the screen height. In a system with multiple display monitors, this value is the same for all
///            monitors. </td> </tr> <tr> <td width="40%"><a id="BITSPIXEL"></a><a id="bitspixel"></a><dl>
///            <dt><b>BITSPIXEL</b></dt> </dl> </td> <td width="60%"> Number of adjacent color bits for each pixel. </td> </tr>
///            <tr> <td width="40%"><a id="PLANES"></a><a id="planes"></a><dl> <dt><b>PLANES</b></dt> </dl> </td> <td
///            width="60%"> Number of color planes. </td> </tr> <tr> <td width="40%"><a id="NUMBRUSHES"></a><a
///            id="numbrushes"></a><dl> <dt><b>NUMBRUSHES</b></dt> </dl> </td> <td width="60%"> Number of device-specific
///            brushes. </td> </tr> <tr> <td width="40%"><a id="NUMPENS"></a><a id="numpens"></a><dl> <dt><b>NUMPENS</b></dt>
///            </dl> </td> <td width="60%"> Number of device-specific pens. </td> </tr> <tr> <td width="40%"><a
///            id="NUMFONTS"></a><a id="numfonts"></a><dl> <dt><b>NUMFONTS</b></dt> </dl> </td> <td width="60%"> Number of
///            device-specific fonts. </td> </tr> <tr> <td width="40%"><a id="NUMCOLORS"></a><a id="numcolors"></a><dl>
///            <dt><b>NUMCOLORS</b></dt> </dl> </td> <td width="60%"> Number of entries in the device's color table, if the
///            device has a color depth of no more than 8 bits per pixel. For devices with greater color depths, 1 is returned.
///            </td> </tr> <tr> <td width="40%"><a id="ASPECTX"></a><a id="aspectx"></a><dl> <dt><b>ASPECTX</b></dt> </dl> </td>
///            <td width="60%"> Relative width of a device pixel used for line drawing. </td> </tr> <tr> <td width="40%"><a
///            id="ASPECTY"></a><a id="aspecty"></a><dl> <dt><b>ASPECTY</b></dt> </dl> </td> <td width="60%"> Relative height of
///            a device pixel used for line drawing. </td> </tr> <tr> <td width="40%"><a id="ASPECTXY"></a><a
///            id="aspectxy"></a><dl> <dt><b>ASPECTXY</b></dt> </dl> </td> <td width="60%"> Diagonal width of the device pixel
///            used for line drawing. </td> </tr> <tr> <td width="40%"><a id="PDEVICESIZE"></a><a id="pdevicesize"></a><dl>
///            <dt><b>PDEVICESIZE</b></dt> </dl> </td> <td width="60%"> Reserved. </td> </tr> <tr> <td width="40%"><a
///            id="CLIPCAPS"></a><a id="clipcaps"></a><dl> <dt><b>CLIPCAPS</b></dt> </dl> </td> <td width="60%"> Flag that
///            indicates the clipping capabilities of the device. If the device can clip to a rectangle, it is 1. Otherwise, it
///            is 0. </td> </tr> <tr> <td width="40%"><a id="SIZEPALETTE"></a><a id="sizepalette"></a><dl>
///            <dt><b>SIZEPALETTE</b></dt> </dl> </td> <td width="60%"> Number of entries in the system palette. This index is
///            valid only if the device driver sets the RC_PALETTE bit in the RASTERCAPS index and is available only if the
///            driver is compatible with 16-bit Windows. </td> </tr> <tr> <td width="40%"><a id="NUMRESERVED"></a><a
///            id="numreserved"></a><dl> <dt><b>NUMRESERVED</b></dt> </dl> </td> <td width="60%"> Number of reserved entries in
///            the system palette. This index is valid only if the device driver sets the RC_PALETTE bit in the RASTERCAPS index
///            and is available only if the driver is compatible with 16-bit Windows. </td> </tr> <tr> <td width="40%"><a
///            id="COLORRES"></a><a id="colorres"></a><dl> <dt><b>COLORRES</b></dt> </dl> </td> <td width="60%"> Actual color
///            resolution of the device, in bits per pixel. This index is valid only if the device driver sets the RC_PALETTE
///            bit in the RASTERCAPS index and is available only if the driver is compatible with 16-bit Windows. </td> </tr>
///            <tr> <td width="40%"><a id="PHYSICALWIDTH"></a><a id="physicalwidth"></a><dl> <dt><b>PHYSICALWIDTH</b></dt> </dl>
///            </td> <td width="60%"> For printing devices: the width of the physical page, in device units. For example, a
///            printer set to print at 600 dpi on 8.5-x11-inch paper has a physical width value of 5100 device units. Note that
///            the physical page is almost always greater than the printable area of the page, and never smaller. </td> </tr>
///            <tr> <td width="40%"><a id="PHYSICALHEIGHT"></a><a id="physicalheight"></a><dl> <dt><b>PHYSICALHEIGHT</b></dt>
///            </dl> </td> <td width="60%"> For printing devices: the height of the physical page, in device units. For example,
///            a printer set to print at 600 dpi on 8.5-by-11-inch paper has a physical height value of 6600 device units. Note
///            that the physical page is almost always greater than the printable area of the page, and never smaller. </td>
///            </tr> <tr> <td width="40%"><a id="PHYSICALOFFSETX"></a><a id="physicaloffsetx"></a><dl>
///            <dt><b>PHYSICALOFFSETX</b></dt> </dl> </td> <td width="60%"> For printing devices: the distance from the left
///            edge of the physical page to the left edge of the printable area, in device units. For example, a printer set to
///            print at 600 dpi on 8.5-by-11-inch paper, that cannot print on the leftmost 0.25-inch of paper, has a horizontal
///            physical offset of 150 device units. </td> </tr> <tr> <td width="40%"><a id="PHYSICALOFFSETY"></a><a
///            id="physicaloffsety"></a><dl> <dt><b>PHYSICALOFFSETY</b></dt> </dl> </td> <td width="60%"> For printing devices:
///            the distance from the top edge of the physical page to the top edge of the printable area, in device units. For
///            example, a printer set to print at 600 dpi on 8.5-by-11-inch paper, that cannot print on the topmost 0.5-inch of
///            paper, has a vertical physical offset of 300 device units. </td> </tr> <tr> <td width="40%"><a
///            id="VREFRESH"></a><a id="vrefresh"></a><dl> <dt><b>VREFRESH</b></dt> </dl> </td> <td width="60%"> For display
///            devices: the current vertical refresh rate of the device, in cycles per second (Hz). A vertical refresh rate
///            value of 0 or 1 represents the display hardware's default refresh rate. This default rate is typically set by
///            switches on a display card or computer motherboard, or by a configuration program that does not use display
///            functions such as ChangeDisplaySettings. </td> </tr> <tr> <td width="40%"><a id="SCALINGFACTORX"></a><a
///            id="scalingfactorx"></a><dl> <dt><b>SCALINGFACTORX</b></dt> </dl> </td> <td width="60%"> Scaling factor for the
///            x-axis of the printer. </td> </tr> <tr> <td width="40%"><a id="SCALINGFACTORY"></a><a
///            id="scalingfactory"></a><dl> <dt><b>SCALINGFACTORY</b></dt> </dl> </td> <td width="60%"> Scaling factor for the
///            y-axis of the printer. </td> </tr> <tr> <td width="40%"><a id="BLTALIGNMENT"></a><a id="bltalignment"></a><dl>
///            <dt><b>BLTALIGNMENT</b></dt> </dl> </td> <td width="60%"> Preferred horizontal drawing alignment, expressed as a
///            multiple of pixels. For best drawing performance, windows should be horizontally aligned to a multiple of this
///            value. A value of zero indicates that the device is accelerated, and any alignment may be used. </td> </tr> <tr>
///            <td width="40%"><a id="SHADEBLENDCAPS"></a><a id="shadeblendcaps"></a><dl> <dt><b>SHADEBLENDCAPS</b></dt> </dl>
///            </td> <td width="60%"> Value that indicates the shading and blending capabilities of the device. See Remarks for
///            further comments. <table> <tr> <td>SB_CONST_ALPHA</td> <td>Handles the <b>SourceConstantAlpha</b> member of the
///            BLENDFUNCTION structure, which is referenced by the blendFunction parameter of the AlphaBlend function.</td>
///            </tr> <tr> <td>SB_GRAD_RECT</td> <td>Capable of doing GradientFill rectangles.</td> </tr> <tr>
///            <td>SB_GRAD_TRI</td> <td>Capable of doing GradientFill triangles.</td> </tr> <tr> <td>SB_NONE</td> <td>Device
///            does not support any of these capabilities.</td> </tr> <tr> <td>SB_PIXEL_ALPHA</td> <td>Capable of handling
///            per-pixel alpha in AlphaBlend.</td> </tr> <tr> <td>SB_PREMULT_ALPHA</td> <td>Capable of handling premultiplied
///            alpha in AlphaBlend.</td> </tr> </table> </td> </tr> <tr> <td width="40%"><a id="RASTERCAPS"></a><a
///            id="rastercaps"></a><dl> <dt><b>RASTERCAPS</b></dt> </dl> </td> <td width="60%"> Value that indicates the raster
///            capabilities of the device, as shown in the following table. <table> <tr> <td>RC_BANDING</td> <td>Requires
///            banding support.</td> </tr> <tr> <td>RC_BITBLT</td> <td>Capable of transferring bitmaps.</td> </tr> <tr>
///            <td>RC_BITMAP64</td> <td>Capable of supporting bitmaps larger than 64 KB.</td> </tr> <tr> <td>RC_DI_BITMAP</td>
///            <td>Capable of supporting the SetDIBits and GetDIBits functions.</td> </tr> <tr> <td>RC_DIBTODEV</td> <td>Capable
///            of supporting the SetDIBitsToDevice function.</td> </tr> <tr> <td>RC_FLOODFILL</td> <td>Capable of performing
///            flood fills.</td> </tr> <tr> <td>RC_PALETTE</td> <td>Specifies a palette-based device.</td> </tr> <tr>
///            <td>RC_SCALING</td> <td>Capable of scaling.</td> </tr> <tr> <td>RC_STRETCHBLT</td> <td>Capable of performing the
///            StretchBlt function.</td> </tr> <tr> <td>RC_STRETCHDIB</td> <td>Capable of performing the StretchDIBits
///            function.</td> </tr> </table> </td> </tr> <tr> <td width="40%"><a id="CURVECAPS"></a><a id="curvecaps"></a><dl>
///            <dt><b>CURVECAPS</b></dt> </dl> </td> <td width="60%"> Value that indicates the curve capabilities of the device,
///            as shown in the following table. <table> <tr> <td>CC_NONE</td> <td>Device does not support curves.</td> </tr>
///            <tr> <td>CC_CHORD</td> <td>Device can draw chord arcs.</td> </tr> <tr> <td>CC_CIRCLES</td> <td>Device can draw
///            circles.</td> </tr> <tr> <td>CC_ELLIPSES</td> <td>Device can draw ellipses.</td> </tr> <tr> <td>CC_INTERIORS</td>
///            <td>Device can draw interiors.</td> </tr> <tr> <td>CC_PIE</td> <td>Device can draw pie wedges.</td> </tr> <tr>
///            <td>CC_ROUNDRECT</td> <td>Device can draw rounded rectangles.</td> </tr> <tr> <td>CC_STYLED</td> <td>Device can
///            draw styled borders.</td> </tr> <tr> <td>CC_WIDE</td> <td>Device can draw wide borders.</td> </tr> <tr>
///            <td>CC_WIDESTYLED</td> <td>Device can draw borders that are wide and styled.</td> </tr> </table> </td> </tr> <tr>
///            <td width="40%"><a id="LINECAPS"></a><a id="linecaps"></a><dl> <dt><b>LINECAPS</b></dt> </dl> </td> <td
///            width="60%"> Value that indicates the line capabilities of the device, as shown in the following table: <table>
///            <tr> <td>LC_NONE</td> <td>Device does not support lines.</td> </tr> <tr> <td>LC_INTERIORS</td> <td>Device can
///            draw interiors.</td> </tr> <tr> <td>LC_MARKER</td> <td>Device can draw a marker.</td> </tr> <tr>
///            <td>LC_POLYLINE</td> <td>Device can draw a polyline.</td> </tr> <tr> <td>LC_POLYMARKER</td> <td>Device can draw
///            multiple markers.</td> </tr> <tr> <td>LC_STYLED</td> <td>Device can draw styled lines.</td> </tr> <tr>
///            <td>LC_WIDE</td> <td>Device can draw wide lines.</td> </tr> <tr> <td>LC_WIDESTYLED</td> <td>Device can draw lines
///            that are wide and styled.</td> </tr> </table> </td> </tr> <tr> <td width="40%"><a id="POLYGONALCAPS"></a><a
///            id="polygonalcaps"></a><dl> <dt><b>POLYGONALCAPS</b></dt> </dl> </td> <td width="60%"> Value that indicates the
///            polygon capabilities of the device, as shown in the following table. <table> <tr> <td>PC_NONE</td> <td>Device
///            does not support polygons.</td> </tr> <tr> <td>PC_INTERIORS</td> <td>Device can draw interiors.</td> </tr> <tr>
///            <td>PC_POLYGON</td> <td>Device can draw alternate-fill polygons.</td> </tr> <tr> <td>PC_RECTANGLE</td> <td>Device
///            can draw rectangles.</td> </tr> <tr> <td>PC_SCANLINE</td> <td>Device can draw a single scanline.</td> </tr> <tr>
///            <td>PC_STYLED</td> <td>Device can draw styled borders.</td> </tr> <tr> <td>PC_WIDE</td> <td>Device can draw wide
///            borders.</td> </tr> <tr> <td>PC_WIDESTYLED</td> <td>Device can draw borders that are wide and styled.</td> </tr>
///            <tr> <td>PC_WINDPOLYGON</td> <td>Device can draw winding-fill polygons.</td> </tr> </table> </td> </tr> <tr> <td
///            width="40%"><a id="TEXTCAPS"></a><a id="textcaps"></a><dl> <dt><b>TEXTCAPS</b></dt> </dl> </td> <td width="60%">
///            Value that indicates the text capabilities of the device, as shown in the following table. <table> <tr>
///            <td>TC_OP_CHARACTER</td> <td>Device is capable of character output precision.</td> </tr> <tr>
///            <td>TC_OP_STROKE</td> <td>Device is capable of stroke output precision.</td> </tr> <tr> <td>TC_CP_STROKE</td>
///            <td>Device is capable of stroke clip precision.</td> </tr> <tr> <td>TC_CR_90</td> <td>Device is capable of
///            90-degree character rotation.</td> </tr> <tr> <td>TC_CR_ANY</td> <td>Device is capable of any character
///            rotation.</td> </tr> <tr> <td>TC_SF_X_YINDEP</td> <td>Device can scale independently in the x- and
///            y-directions.</td> </tr> <tr> <td>TC_SA_DOUBLE</td> <td>Device is capable of doubled character for scaling.</td>
///            </tr> <tr> <td>TC_SA_INTEGER</td> <td>Device uses integer multiples only for character scaling.</td> </tr> <tr>
///            <td>TC_SA_CONTIN</td> <td>Device uses any multiples for exact character scaling.</td> </tr> <tr>
///            <td>TC_EA_DOUBLE</td> <td>Device can draw double-weight characters.</td> </tr> <tr> <td>TC_IA_ABLE</td>
///            <td>Device can italicize.</td> </tr> <tr> <td>TC_UA_ABLE</td> <td>Device can underline.</td> </tr> <tr>
///            <td>TC_SO_ABLE</td> <td>Device can draw strikeouts.</td> </tr> <tr> <td>TC_RA_ABLE</td> <td>Device can draw
///            raster fonts.</td> </tr> <tr> <td>TC_VA_ABLE</td> <td>Device can draw vector fonts.</td> </tr> <tr>
///            <td>TC_RESERVED</td> <td>Reserved; must be zero.</td> </tr> <tr> <td>TC_SCROLLBLT</td> <td>Device cannot scroll
///            using a bit-block transfer. Note that this meaning may be the opposite of what you expect.</td> </tr> </table>
///            </td> </tr> <tr> <td width="40%"><a id="COLORMGMTCAPS"></a><a id="colormgmtcaps"></a><dl>
///            <dt><b>COLORMGMTCAPS</b></dt> </dl> </td> <td width="60%"> Value that indicates the color management capabilities
///            of the device. <table> <tr> <td>CM_CMYK_COLOR</td> <td>Device can accept CMYK color space ICC color profile.</td>
///            </tr> <tr> <td>CM_DEVICE_ICM</td> <td>Device can perform ICM on either the device driver or the device
///            itself.</td> </tr> <tr> <td>CM_GAMMA_RAMP</td> <td>Device supports GetDeviceGammaRamp and SetDeviceGammaRamp
///            </td> </tr> <tr> <td>CM_NONE</td> <td>Device does not support ICM.</td> </tr> </table> </td> </tr> </table>
///Returns:
///    The return value specifies the value of the desired item. When <i>nIndex</i> is BITSPIXEL and the device has
///    15bpp or 16bpp, the return value is 16.
///    
@DllImport("GDI32")
int GetDeviceCaps(HDC hdc, int index);

///The <b>GetDIBits</b> function retrieves the bits of the specified compatible bitmap and copies them into a buffer as
///a DIB using the specified format.
///Params:
///    hdc = A handle to the device context.
///    hbm = A handle to the bitmap. This must be a compatible bitmap (DDB).
///    start = The first scan line to retrieve.
///    cLines = The number of scan lines to retrieve.
///    lpvBits = A pointer to a buffer to receive the bitmap data. If this parameter is <b>NULL</b>, the function passes the
///              dimensions and format of the bitmap to the BITMAPINFO structure pointed to by the <i>lpbi</i> parameter.
///    lpbmi = A pointer to a BITMAPINFO structure that specifies the desired format for the DIB data.
///    usage = The format of the <b>bmiColors</b> member of the BITMAPINFO structure. It must be one of the following values.
///            <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DIB_PAL_COLORS"></a><a
///            id="dib_pal_colors"></a><dl> <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td> <td width="60%"> The color table should
///            consist of an array of 16-bit indexes into the current logical palette. </td> </tr> <tr> <td width="40%"><a
///            id="DIB_RGB_COLORS"></a><a id="dib_rgb_colors"></a><dl> <dt><b>DIB_RGB_COLORS</b></dt> </dl> </td> <td
///            width="60%"> The color table should consist of literal red, green, blue (RGB) values. </td> </tr> </table>
///Returns:
///    If the <i>lpvBits</i> parameter is non-<b>NULL</b> and the function succeeds, the return value is the number of
///    scan lines copied from the bitmap. If the <i>lpvBits</i> parameter is <b>NULL</b> and <b>GetDIBits</b>
///    successfully fills the BITMAPINFO structure, the return value is nonzero. If the function fails, the return value
///    is zero. This function can return the following value. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more
///    of the input parameters is invalid. </td> </tr> </table>
///    
@DllImport("GDI32")
int GetDIBits(HDC hdc, HBITMAP hbm, uint start, uint cLines, void* lpvBits, BITMAPINFO* lpbmi, uint usage);

///The <b>GetFontData</b> function retrieves font metric data for a TrueType font.
///Params:
///    hdc = A handle to the device context.
///    dwTable = The name of a font metric table from which the font data is to be retrieved. This parameter can identify one of
///              the metric tables documented in the TrueType Font Files specification published by Microsoft Corporation. If this
///              parameter is zero, the information is retrieved starting at the beginning of the file for TrueType font files or
///              from the beginning of the data for the currently selected font for TrueType Collection files. To retrieve the
///              data from the beginning of the file for TrueType Collection files specify 'ttcf' (0x66637474).
///    dwOffset = The offset from the beginning of the font metric table to the location where the function should begin retrieving
///               information. If this parameter is zero, the information is retrieved starting at the beginning of the table
///               specified by the <i>dwTable</i> parameter. If this value is greater than or equal to the size of the table, an
///               error occurs.
///    pvBuffer = A pointer to a buffer that receives the font information. If this parameter is <b>NULL</b>, the function returns
///               the size of the buffer required for the font data.
///    cjBuffer = The length, in bytes, of the information to be retrieved. If this parameter is zero, <b>GetFontData</b> returns
///               the size of the data specified in the <i>dwTable</i> parameter.
///Returns:
///    If the function succeeds, the return value is the number of bytes returned. If the function fails, the return
///    value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetFontData(HDC hdc, uint dwTable, uint dwOffset, char* pvBuffer, uint cjBuffer);

///The <b>GetGlyphOutline</b> function retrieves the outline or bitmap for a character in the TrueType font that is
///selected into the specified device context.
///Params:
///    hdc = A handle to the device context.
///    uChar = The character for which data is to be returned.
///    fuFormat = The format of the data that the function retrieves. This parameter can be one of the following values. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GGO_BEZIER"></a><a
///               id="ggo_bezier"></a><dl> <dt><b>GGO_BEZIER</b></dt> </dl> </td> <td width="60%"> The function retrieves the curve
///               data as a cubic Bézier spline (not in quadratic spline format). </td> </tr> <tr> <td width="40%"><a
///               id="GGO_BITMAP"></a><a id="ggo_bitmap"></a><dl> <dt><b>GGO_BITMAP</b></dt> </dl> </td> <td width="60%"> The
///               function retrieves the glyph bitmap. For information about memory allocation, see the following Remarks section.
///               </td> </tr> <tr> <td width="40%"><a id="GGO_GLYPH_INDEX"></a><a id="ggo_glyph_index"></a><dl>
///               <dt><b>GGO_GLYPH_INDEX</b></dt> </dl> </td> <td width="60%"> Indicates that the <i>uChar</i> parameter is a
///               TrueType Glyph Index rather than a character code. See the ExtTextOut function for additional remarks on Glyph
///               Indexing. </td> </tr> <tr> <td width="40%"><a id="GGO_GRAY2_BITMAP"></a><a id="ggo_gray2_bitmap"></a><dl>
///               <dt><b>GGO_GRAY2_BITMAP</b></dt> </dl> </td> <td width="60%"> The function retrieves a glyph bitmap that contains
///               five levels of gray. </td> </tr> <tr> <td width="40%"><a id="GGO_GRAY4_BITMAP"></a><a
///               id="ggo_gray4_bitmap"></a><dl> <dt><b>GGO_GRAY4_BITMAP</b></dt> </dl> </td> <td width="60%"> The function
///               retrieves a glyph bitmap that contains 17 levels of gray. </td> </tr> <tr> <td width="40%"><a
///               id="GGO_GRAY8_BITMAP"></a><a id="ggo_gray8_bitmap"></a><dl> <dt><b>GGO_GRAY8_BITMAP</b></dt> </dl> </td> <td
///               width="60%"> The function retrieves a glyph bitmap that contains 65 levels of gray. </td> </tr> <tr> <td
///               width="40%"><a id="GGO_METRICS"></a><a id="ggo_metrics"></a><dl> <dt><b>GGO_METRICS</b></dt> </dl> </td> <td
///               width="60%"> The function only retrieves the GLYPHMETRICS structure specified by <i>lpgm</i>. The
///               <i>lpvBuffer</i> is ignored. This value affects the meaning of the function's return value upon failure; see the
///               Return Values section. </td> </tr> <tr> <td width="40%"><a id="GGO_NATIVE"></a><a id="ggo_native"></a><dl>
///               <dt><b>GGO_NATIVE</b></dt> </dl> </td> <td width="60%"> The function retrieves the curve data points in the
///               rasterizer's native format and uses the font's design units. </td> </tr> <tr> <td width="40%"><a
///               id="GGO_UNHINTED"></a><a id="ggo_unhinted"></a><dl> <dt><b>GGO_UNHINTED</b></dt> </dl> </td> <td width="60%"> The
///               function only returns unhinted outlines. This flag only works in conjunction with GGO_BEZIER and GGO_NATIVE.
///               </td> </tr> </table> Note that, for the GGO_GRAYn_BITMAP values, the function retrieves a glyph bitmap that
///               contains n^2+1 (n squared plus one) levels of gray.
///    lpgm = A pointer to the GLYPHMETRICS structure describing the placement of the glyph in the character cell.
///    cjBuffer = The size, in bytes, of the buffer (*<i>lpvBuffer</i>) where the function is to copy information about the outline
///               character. If this value is zero, the function returns the required size of the buffer.
///    pvBuffer = A pointer to the buffer that receives information about the outline character. If this value is <b>NULL</b>, the
///               function returns the required size of the buffer.
///    lpmat2 = A pointer to a MAT2 structure specifying a transformation matrix for the character.
///Returns:
///    If GGO_BITMAP, GGO_GRAY2_BITMAP, GGO_GRAY4_BITMAP, GGO_GRAY8_BITMAP, or GGO_NATIVE is specified and the function
///    succeeds, the return value is greater than zero; otherwise, the return value is GDI_ERROR. If one of these flags
///    is specified and the buffer size or address is zero, the return value specifies the required buffer size, in
///    bytes. If GGO_METRICS is specified and the function fails, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetGlyphOutlineA(HDC hdc, uint uChar, uint fuFormat, GLYPHMETRICS* lpgm, uint cjBuffer, char* pvBuffer, 
                      const(MAT2)* lpmat2);

///The <b>GetGlyphOutline</b> function retrieves the outline or bitmap for a character in the TrueType font that is
///selected into the specified device context.
///Params:
///    hdc = A handle to the device context.
///    uChar = The character for which data is to be returned.
///    fuFormat = The format of the data that the function retrieves. This parameter can be one of the following values. <table>
///               <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GGO_BEZIER"></a><a
///               id="ggo_bezier"></a><dl> <dt><b>GGO_BEZIER</b></dt> </dl> </td> <td width="60%"> The function retrieves the curve
///               data as a cubic Bézier spline (not in quadratic spline format). </td> </tr> <tr> <td width="40%"><a
///               id="GGO_BITMAP"></a><a id="ggo_bitmap"></a><dl> <dt><b>GGO_BITMAP</b></dt> </dl> </td> <td width="60%"> The
///               function retrieves the glyph bitmap. For information about memory allocation, see the following Remarks section.
///               </td> </tr> <tr> <td width="40%"><a id="GGO_GLYPH_INDEX"></a><a id="ggo_glyph_index"></a><dl>
///               <dt><b>GGO_GLYPH_INDEX</b></dt> </dl> </td> <td width="60%"> Indicates that the <i>uChar</i> parameter is a
///               TrueType Glyph Index rather than a character code. See the ExtTextOut function for additional remarks on Glyph
///               Indexing. </td> </tr> <tr> <td width="40%"><a id="GGO_GRAY2_BITMAP"></a><a id="ggo_gray2_bitmap"></a><dl>
///               <dt><b>GGO_GRAY2_BITMAP</b></dt> </dl> </td> <td width="60%"> The function retrieves a glyph bitmap that contains
///               five levels of gray. </td> </tr> <tr> <td width="40%"><a id="GGO_GRAY4_BITMAP"></a><a
///               id="ggo_gray4_bitmap"></a><dl> <dt><b>GGO_GRAY4_BITMAP</b></dt> </dl> </td> <td width="60%"> The function
///               retrieves a glyph bitmap that contains 17 levels of gray. </td> </tr> <tr> <td width="40%"><a
///               id="GGO_GRAY8_BITMAP"></a><a id="ggo_gray8_bitmap"></a><dl> <dt><b>GGO_GRAY8_BITMAP</b></dt> </dl> </td> <td
///               width="60%"> The function retrieves a glyph bitmap that contains 65 levels of gray. </td> </tr> <tr> <td
///               width="40%"><a id="GGO_METRICS"></a><a id="ggo_metrics"></a><dl> <dt><b>GGO_METRICS</b></dt> </dl> </td> <td
///               width="60%"> The function only retrieves the GLYPHMETRICS structure specified by <i>lpgm</i>. The
///               <i>lpvBuffer</i> is ignored. This value affects the meaning of the function's return value upon failure; see the
///               Return Values section. </td> </tr> <tr> <td width="40%"><a id="GGO_NATIVE"></a><a id="ggo_native"></a><dl>
///               <dt><b>GGO_NATIVE</b></dt> </dl> </td> <td width="60%"> The function retrieves the curve data points in the
///               rasterizer's native format and uses the font's design units. </td> </tr> <tr> <td width="40%"><a
///               id="GGO_UNHINTED"></a><a id="ggo_unhinted"></a><dl> <dt><b>GGO_UNHINTED</b></dt> </dl> </td> <td width="60%"> The
///               function only returns unhinted outlines. This flag only works in conjunction with GGO_BEZIER and GGO_NATIVE.
///               </td> </tr> </table> Note that, for the GGO_GRAYn_BITMAP values, the function retrieves a glyph bitmap that
///               contains n^2+1 (n squared plus one) levels of gray.
///    lpgm = A pointer to the GLYPHMETRICS structure describing the placement of the glyph in the character cell.
///    cjBuffer = The size, in bytes, of the buffer (*<i>lpvBuffer</i>) where the function is to copy information about the outline
///               character. If this value is zero, the function returns the required size of the buffer.
///    pvBuffer = A pointer to the buffer that receives information about the outline character. If this value is <b>NULL</b>, the
///               function returns the required size of the buffer.
///    lpmat2 = A pointer to a MAT2 structure specifying a transformation matrix for the character.
///Returns:
///    If GGO_BITMAP, GGO_GRAY2_BITMAP, GGO_GRAY4_BITMAP, GGO_GRAY8_BITMAP, or GGO_NATIVE is specified and the function
///    succeeds, the return value is greater than zero; otherwise, the return value is GDI_ERROR. If one of these flags
///    is specified and the buffer size or address is zero, the return value specifies the required buffer size, in
///    bytes. If GGO_METRICS is specified and the function fails, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetGlyphOutlineW(HDC hdc, uint uChar, uint fuFormat, GLYPHMETRICS* lpgm, uint cjBuffer, char* pvBuffer, 
                      const(MAT2)* lpmat2);

///The <b>GetGraphicsMode</b> function retrieves the current graphics mode for the specified device context.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is the current graphics mode. It can be one of the following values.
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>GM_COMPATIBLE</td> <td>The current graphics mode is
///    the compatible graphics mode, a mode that is compatible with 16-bit Windows. In this graphics mode, an
///    application cannot set or modify the world transformation for the specified device context. The compatible
///    graphics mode is the default graphics mode.</td> </tr> <tr> <td>GM_ADVANCED</td> <td>The current graphics mode is
///    the advanced graphics mode, a mode that allows world transformations. In this graphics mode, an application can
///    set or modify the world transformation for the specified device context.</td> </tr> </table> Otherwise, the
///    return value is zero.
///    
@DllImport("GDI32")
int GetGraphicsMode(HDC hdc);

///The <b>GetMapMode</b> function retrieves the current mapping mode.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value specifies the mapping mode. If the function fails, the return value is
///    zero.
///    
@DllImport("GDI32")
int GetMapMode(HDC hdc);

///The <b>GetMetaFileBitsEx</b> function retrieves the contents of a Windows-format metafile and copies them into the
///specified buffer. <div class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format
///metafiles. Enhanced-format metafiles provide superior functionality and are recommended for new applications. The
///corresponding function for an enhanced-format metafile is GetEnhMetaFileBits.</div><div> </div>
///Params:
///    hMF = A handle to a Windows-format metafile.
///    cbBuffer = The size, in bytes, of the buffer to receive the data.
///    lpData = A pointer to a buffer that receives the metafile data. The buffer must be sufficiently large to contain the data.
///             If <i>lpvData</i> is <b>NULL</b>, the function returns the number of bytes required to hold the data.
///Returns:
///    If the function succeeds and the buffer pointer is <b>NULL</b>, the return value is the number of bytes required
///    for the buffer; if the function succeeds and the buffer pointer is a valid pointer, the return value is the
///    number of bytes copied. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetMetaFileBitsEx(ptrdiff_t hMF, uint cbBuffer, char* lpData);

///<p class="CCE_Message">[GetMetaFile is no longer available for use as of Windows 2000. Instead, use GetEnhMetaFile.]
///The <b>GetMetaFile</b> function creates a handle that identifies the metafile stored in the specified file.
///Params:
///    lpName = A pointer to a null-terminated string that specifies the name of a metafile.
///Returns:
///    If the function succeeds, the return value is a handle to the metafile. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t GetMetaFileA(const(char)* lpName);

///<p class="CCE_Message">[GetMetaFile is no longer available for use as of Windows 2000. Instead, use GetEnhMetaFile.]
///The <b>GetMetaFile</b> function creates a handle that identifies the metafile stored in the specified file.
///Params:
///    lpName = A pointer to a null-terminated string that specifies the name of a metafile.
///Returns:
///    If the function succeeds, the return value is a handle to the metafile. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t GetMetaFileW(const(wchar)* lpName);

///The <b>GetNearestColor</b> function retrieves a color value identifying a color from the system palette that will be
///displayed when the specified color value is used.
///Params:
///    hdc = A handle to the device context.
///    color = A color value that identifies a requested color. To create a COLORREF color value, use the RGB macro.
///Returns:
///    If the function succeeds, the return value identifies a color from the system palette that corresponds to the
///    given color value. If the function fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint GetNearestColor(HDC hdc, uint color);

///The <b>GetNearestPaletteIndex</b> function retrieves the index for the entry in the specified logical palette most
///closely matching a specified color value.
///Params:
///    h = A handle to a logical palette.
///    color = A color to be matched. To create a COLORREF color value, use the RGB macro.
///Returns:
///    If the function succeeds, the return value is the index of an entry in a logical palette. If the function fails,
///    the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint GetNearestPaletteIndex(HPALETTE h, uint color);

///The <b>GetObjectType</b> retrieves the type of the specified object.
///Params:
///    h = A handle to the graphics object.
///Returns:
///    If the function succeeds, the return value identifies the object. This value can be one of the following. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>OBJ_BITMAP</td> <td>Bitmap</td> </tr> <tr> <td>OBJ_BRUSH</td>
///    <td>Brush</td> </tr> <tr> <td>OBJ_COLORSPACE</td> <td>Color space</td> </tr> <tr> <td>OBJ_DC</td> <td>Device
///    context</td> </tr> <tr> <td>OBJ_ENHMETADC</td> <td>Enhanced metafile DC</td> </tr> <tr> <td>OBJ_ENHMETAFILE</td>
///    <td>Enhanced metafile</td> </tr> <tr> <td>OBJ_EXTPEN</td> <td>Extended pen</td> </tr> <tr> <td>OBJ_FONT</td>
///    <td>Font</td> </tr> <tr> <td>OBJ_MEMDC</td> <td>Memory DC</td> </tr> <tr> <td>OBJ_METAFILE</td> <td>Metafile</td>
///    </tr> <tr> <td>OBJ_METADC</td> <td>Metafile DC</td> </tr> <tr> <td>OBJ_PAL</td> <td>Palette</td> </tr> <tr>
///    <td>OBJ_PEN</td> <td>Pen</td> </tr> <tr> <td>OBJ_REGION</td> <td>Region</td> </tr> </table> If the function
///    fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetObjectType(ptrdiff_t h);

///The <b>GetOutlineTextMetrics</b> function retrieves text metrics for TrueType fonts.
///Params:
///    hdc = A handle to the device context.
///    cjCopy = The size, in bytes, of the array that receives the text metrics.
///    potm = A pointer to an OUTLINETEXTMETRIC structure. If this parameter is <b>NULL</b>, the function returns the size of
///           the buffer required for the retrieved metric data.
///Returns:
///    If the function succeeds, the return value is nonzero or the size of the required buffer. If the function fails,
///    the return value is zero.
///    
@DllImport("GDI32")
uint GetOutlineTextMetricsA(HDC hdc, uint cjCopy, char* potm);

///The <b>GetOutlineTextMetrics</b> function retrieves text metrics for TrueType fonts.
///Params:
///    hdc = A handle to the device context.
///    cjCopy = The size, in bytes, of the array that receives the text metrics.
///    potm = A pointer to an OUTLINETEXTMETRIC structure. If this parameter is <b>NULL</b>, the function returns the size of
///           the buffer required for the retrieved metric data.
///Returns:
///    If the function succeeds, the return value is nonzero or the size of the required buffer. If the function fails,
///    the return value is zero.
///    
@DllImport("GDI32")
uint GetOutlineTextMetricsW(HDC hdc, uint cjCopy, char* potm);

///The <b>GetPaletteEntries</b> function retrieves a specified range of palette entries from the given logical palette.
///Params:
///    hpal = A handle to the logical palette.
///    iStart = The first entry in the logical palette to be retrieved.
///    cEntries = The number of entries in the logical palette to be retrieved.
///    pPalEntries = A pointer to an array of PALETTEENTRY structures to receive the palette entries. The array must contain at least
///                  as many structures as specified by the <i>nEntries</i> parameter.
///Returns:
///    If the function succeeds and the handle to the logical palette is a valid pointer (not <b>NULL</b>), the return
///    value is the number of entries retrieved from the logical palette. If the function succeeds and handle to the
///    logical palette is <b>NULL</b>, the return value is the number of entries in the given palette. If the function
///    fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetPaletteEntries(HPALETTE hpal, uint iStart, uint cEntries, char* pPalEntries);

///The <b>GetPixel</b> function retrieves the red, green, blue (RGB) color value of the pixel at the specified
///coordinates.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical units, of the pixel to be examined.
///    y = The y-coordinate, in logical units, of the pixel to be examined.
///Returns:
///    The return value is the COLORREF value that specifies the RGB of the pixel. If the pixel is outside of the
///    current clipping region, the return value is CLR_INVALID (0xFFFFFFFF defined in Wingdi.h).
///    
@DllImport("GDI32")
uint GetPixel(HDC hdc, int x, int y);

///The <b>GetPolyFillMode</b> function retrieves the current polygon fill mode.
///Params:
///    hdc = Handle to the device context.
///Returns:
///    If the function succeeds, the return value specifies the polygon fill mode, which can be one of the following
///    values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>ALTERNATE</td> <td>Selects alternate mode
///    (fills area between odd-numbered and even-numbered polygon sides on each scan line).</td> </tr> <tr>
///    <td>WINDING</td> <td>Selects winding mode (fills any region with a nonzero winding value).</td> </tr> </table> If
///    an error occurs, the return value is zero.
///    
@DllImport("GDI32")
int GetPolyFillMode(HDC hdc);

///The <b>GetRasterizerCaps</b> function returns flags indicating whether TrueType fonts are installed in the system.
///Params:
///    lpraststat = A pointer to a RASTERIZER_STATUS structure that receives information about the rasterizer.
///    cjBytes = The number of bytes to be copied into the structure pointed to by the <i>lprs</i> parameter.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetRasterizerCaps(char* lpraststat, uint cjBytes);

///The <b>GetRandomRgn</b> function copies the system clipping region of a specified device context to a specific
///region.
///Params:
///    hdc = A handle to the device context.
///    hrgn = A handle to a region. Before the function is called, this identifies an existing region. After the function
///           returns, this identifies a copy of the current system region. The old region identified by <i>hrgn</i> is
///           overwritten.
///    i = This parameter must be SYSRGN.
///Returns:
///    If the function succeeds, the return value is 1. If the function fails, the return value is -1. If the region to
///    be retrieved is <b>NULL</b>, the return value is 0. If the function fails or the region to be retrieved is
///    <b>NULL</b>, <i>hrgn</i> is not initialized.
///    
@DllImport("GDI32")
int GetRandomRgn(HDC hdc, HRGN hrgn, int i);

///The <b>GetRegionData</b> function fills the specified buffer with data describing a region. This data includes the
///dimensions of the rectangles that make up the region.
///Params:
///    hrgn = A handle to the region.
///    nCount = The size, in bytes, of the <i>lpRgnData</i> buffer.
///    lpRgnData = A pointer to a RGNDATA structure that receives the information. The dimensions of the region are in logical
///                units. If this parameter is <b>NULL</b>, the return value contains the number of bytes needed for the region
///                data.
///Returns:
///    If the function succeeds and <i>dwCount</i> specifies an adequate number of bytes, the return value is always
///    <i>dwCount</i>. If <i>dwCount</i> is too small or the function fails, the return value is 0. If <i>lpRgnData</i>
///    is <b>NULL</b>, the return value is the required number of bytes. If the function fails, the return value is
///    zero.
///    
@DllImport("GDI32")
uint GetRegionData(HRGN hrgn, uint nCount, char* lpRgnData);

///The <b>GetRgnBox</b> function retrieves the bounding rectangle of the specified region.
///Params:
///    hrgn = A handle to the region.
///    lprc = A pointer to a RECT structure that receives the bounding rectangle in logical units.
///Returns:
///    The return value specifies the region's complexity. It can be one of the following values: <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td>NULLREGION</td> <td>Region is empty.</td> </tr> <tr>
///    <td>SIMPLEREGION</td> <td>Region is a single rectangle.</td> </tr> <tr> <td>COMPLEXREGION</td> <td>Region is more
///    than a single rectangle.</td> </tr> </table> If the <i>hrgn</i> parameter does not identify a valid region, the
///    return value is zero.
///    
@DllImport("GDI32")
int GetRgnBox(HRGN hrgn, RECT* lprc);

///The <b>GetStockObject</b> function retrieves a handle to one of the stock pens, brushes, fonts, or palettes.
///Params:
///    i = The type of stock object. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///        <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BLACK_BRUSH"></a><a id="black_brush"></a><dl>
///        <dt><b>BLACK_BRUSH</b></dt> </dl> </td> <td width="60%"> Black brush. </td> </tr> <tr> <td width="40%"><a
///        id="DKGRAY_BRUSH"></a><a id="dkgray_brush"></a><dl> <dt><b>DKGRAY_BRUSH</b></dt> </dl> </td> <td width="60%">
///        Dark gray brush. </td> </tr> <tr> <td width="40%"><a id="DC_BRUSH"></a><a id="dc_brush"></a><dl>
///        <dt><b>DC_BRUSH</b></dt> </dl> </td> <td width="60%"> Solid color brush. The default color is white. The color
///        can be changed by using the SetDCBrushColor function. For more information, see the Remarks section. </td> </tr>
///        <tr> <td width="40%"><a id="GRAY_BRUSH"></a><a id="gray_brush"></a><dl> <dt><b>GRAY_BRUSH</b></dt> </dl> </td>
///        <td width="60%"> Gray brush. </td> </tr> <tr> <td width="40%"><a id="HOLLOW_BRUSH"></a><a
///        id="hollow_brush"></a><dl> <dt><b>HOLLOW_BRUSH</b></dt> </dl> </td> <td width="60%"> Hollow brush (equivalent to
///        NULL_BRUSH). </td> </tr> <tr> <td width="40%"><a id="LTGRAY_BRUSH"></a><a id="ltgray_brush"></a><dl>
///        <dt><b>LTGRAY_BRUSH</b></dt> </dl> </td> <td width="60%"> Light gray brush. </td> </tr> <tr> <td width="40%"><a
///        id="NULL_BRUSH"></a><a id="null_brush"></a><dl> <dt><b>NULL_BRUSH</b></dt> </dl> </td> <td width="60%"> Null
///        brush (equivalent to HOLLOW_BRUSH). </td> </tr> <tr> <td width="40%"><a id="WHITE_BRUSH"></a><a
///        id="white_brush"></a><dl> <dt><b>WHITE_BRUSH</b></dt> </dl> </td> <td width="60%"> White brush. </td> </tr> <tr>
///        <td width="40%"><a id="BLACK_PEN"></a><a id="black_pen"></a><dl> <dt><b>BLACK_PEN</b></dt> </dl> </td> <td
///        width="60%"> Black pen. </td> </tr> <tr> <td width="40%"><a id="DC_PEN"></a><a id="dc_pen"></a><dl>
///        <dt><b>DC_PEN</b></dt> </dl> </td> <td width="60%"> Solid pen color. The default color is white. The color can be
///        changed by using the SetDCPenColor function. For more information, see the Remarks section. </td> </tr> <tr> <td
///        width="40%"><a id="NULL_PEN"></a><a id="null_pen"></a><dl> <dt><b>NULL_PEN</b></dt> </dl> </td> <td width="60%">
///        Null pen. The null pen draws nothing. </td> </tr> <tr> <td width="40%"><a id="WHITE_PEN"></a><a
///        id="white_pen"></a><dl> <dt><b>WHITE_PEN</b></dt> </dl> </td> <td width="60%"> White pen. </td> </tr> <tr> <td
///        width="40%"><a id="ANSI_FIXED_FONT"></a><a id="ansi_fixed_font"></a><dl> <dt><b>ANSI_FIXED_FONT</b></dt> </dl>
///        </td> <td width="60%"> Windows fixed-pitch (monospace) system font. </td> </tr> <tr> <td width="40%"><a
///        id="ANSI_VAR_FONT"></a><a id="ansi_var_font"></a><dl> <dt><b>ANSI_VAR_FONT</b></dt> </dl> </td> <td width="60%">
///        Windows variable-pitch (proportional space) system font. </td> </tr> <tr> <td width="40%"><a
///        id="DEVICE_DEFAULT_FONT"></a><a id="device_default_font"></a><dl> <dt><b>DEVICE_DEFAULT_FONT</b></dt> </dl> </td>
///        <td width="60%"> Device-dependent font. </td> </tr> <tr> <td width="40%"><a id="DEFAULT_GUI_FONT"></a><a
///        id="default_gui_font"></a><dl> <dt><b>DEFAULT_GUI_FONT</b></dt> </dl> </td> <td width="60%"> Default font for
///        user interface objects such as menus and dialog boxes. It is not recommended that you use DEFAULT_GUI_FONT or
///        SYSTEM_FONT to obtain the font used by dialogs and windows; for more information, see the remarks section. The
///        default font is Tahoma. </td> </tr> <tr> <td width="40%"><a id="OEM_FIXED_FONT"></a><a
///        id="oem_fixed_font"></a><dl> <dt><b>OEM_FIXED_FONT</b></dt> </dl> </td> <td width="60%"> Original equipment
///        manufacturer (OEM) dependent fixed-pitch (monospace) font. </td> </tr> <tr> <td width="40%"><a
///        id="SYSTEM_FONT"></a><a id="system_font"></a><dl> <dt><b>SYSTEM_FONT</b></dt> </dl> </td> <td width="60%"> System
///        font. By default, the system uses the system font to draw menus, dialog box controls, and text. It is not
///        recommended that you use DEFAULT_GUI_FONT or SYSTEM_FONT to obtain the font used by dialogs and windows; for more
///        information, see the remarks section. The default system font is Tahoma. </td> </tr> <tr> <td width="40%"><a
///        id="SYSTEM_FIXED_FONT"></a><a id="system_fixed_font"></a><dl> <dt><b>SYSTEM_FIXED_FONT</b></dt> </dl> </td> <td
///        width="60%"> Fixed-pitch (monospace) system font. This stock object is provided only for compatibility with
///        16-bit Windows versions earlier than 3.0. </td> </tr> <tr> <td width="40%"><a id="DEFAULT_PALETTE"></a><a
///        id="default_palette"></a><dl> <dt><b>DEFAULT_PALETTE</b></dt> </dl> </td> <td width="60%"> Default palette. This
///        palette consists of the static colors in the system palette. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a handle to the requested logical object. If the function fails,
///    the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t GetStockObject(int i);

///The <b>GetStretchBltMode</b> function retrieves the current stretching mode. The stretching mode defines how color
///data is added to or removed from bitmaps that are stretched or compressed when the StretchBlt function is called.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is the current stretching mode. This can be one of the following
///    values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>BLACKONWHITE</td> <td>Performs a Boolean
///    AND operation using the color values for the eliminated and existing pixels. If the bitmap is a monochrome
///    bitmap, this mode preserves black pixels at the expense of white pixels.</td> </tr> <tr> <td>COLORONCOLOR</td>
///    <td>Deletes the pixels. This mode deletes all eliminated lines of pixels without trying to preserve their
///    information.</td> </tr> <tr> <td>HALFTONE</td> <td>Maps pixels from the source rectangle into blocks of pixels in
///    the destination rectangle. The average color over the destination block of pixels approximates the color of the
///    source pixels.</td> </tr> <tr> <td>STRETCH_ANDSCANS</td> <td>Same as BLACKONWHITE.</td> </tr> <tr>
///    <td>STRETCH_DELETESCANS</td> <td>Same as COLORONCOLOR.</td> </tr> <tr> <td>STRETCH_HALFTONE</td> <td>Same as
///    HALFTONE.</td> </tr> <tr> <td>STRETCH_ORSCANS</td> <td>Same as WHITEONBLACK.</td> </tr> <tr>
///    <td>WHITEONBLACK</td> <td>Performs a Boolean OR operation using the color values for the eliminated and existing
///    pixels. If the bitmap is a monochrome bitmap, this mode preserves white pixels at the expense of black
///    pixels.</td> </tr> </table> If the function fails, the return value is zero.
///    
@DllImport("GDI32")
int GetStretchBltMode(HDC hdc);

///The <b>GetSystemPaletteEntries</b> function retrieves a range of palette entries from the system palette that is
///associated with the specified device context (DC).
///Params:
///    hdc = A handle to the device context.
///    iStart = The first entry to be retrieved from the system palette.
///    cEntries = The number of entries to be retrieved from the system palette.
///    pPalEntries = A pointer to an array of PALETTEENTRY structures to receive the palette entries. The array must contain at least
///                  as many structures as specified by the <i>cEntries</i> parameter. If this parameter is <b>NULL</b>, the function
///                  returns the total number of entries in the palette.
///Returns:
///    If the function succeeds, the return value is the number of entries retrieved from the palette. If the function
///    fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetSystemPaletteEntries(HDC hdc, uint iStart, uint cEntries, char* pPalEntries);

///The <b>GetSystemPaletteUse</b> function retrieves the current state of the system (physical) palette for the
///specified device context (DC).
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is the current state of the system palette. This parameter can be one
///    of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>SYSPAL_NOSTATIC</td> <td>The
///    system palette contains no static colors except black and white.</td> </tr> <tr> <td>SYSPAL_STATIC</td> <td>The
///    system palette contains static colors that will not change when an application realizes its logical palette.</td>
///    </tr> <tr> <td>SYSPAL_ERROR</td> <td>The given device context is invalid or does not support a color
///    palette.</td> </tr> </table>
///    
@DllImport("GDI32")
uint GetSystemPaletteUse(HDC hdc);

///The <b>GetTextCharacterExtra</b> function retrieves the current intercharacter spacing for the specified device
///context.
///Params:
///    hdc = Handle to the device context.
///Returns:
///    If the function succeeds, the return value is the current intercharacter spacing, in logical coordinates. If the
///    function fails, the return value is 0x8000000.
///    
@DllImport("GDI32")
int GetTextCharacterExtra(HDC hdc);

///The <b>GetTextAlign</b> function retrieves the text-alignment setting for the specified device context.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is the status of the text-alignment flags. For more information about
///    the return value, see the Remarks section. The return value is a combination of the following values. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>TA_BASELINE</td> <td>The reference point is on the base line
///    of the text.</td> </tr> <tr> <td>TA_BOTTOM</td> <td>The reference point is on the bottom edge of the bounding
///    rectangle.</td> </tr> <tr> <td>TA_TOP</td> <td>The reference point is on the top edge of the bounding
///    rectangle.</td> </tr> <tr> <td>TA_CENTER</td> <td>The reference point is aligned horizontally with the center of
///    the bounding rectangle.</td> </tr> <tr> <td>TA_LEFT</td> <td>The reference point is on the left edge of the
///    bounding rectangle.</td> </tr> <tr> <td>TA_RIGHT</td> <td>The reference point is on the right edge of the
///    bounding rectangle.</td> </tr> <tr> <td>TA_RTLREADING</td> <td><b>Middle East language edition of Windows:</b>
///    The text is laid out in right to left reading order, as opposed to the default left to right order. This only
///    applies when the font selected into the device context is either Hebrew or Arabic.</td> </tr> <tr>
///    <td>TA_NOUPDATECP</td> <td>The current position is not updated after each text output call.</td> </tr> <tr>
///    <td>TA_UPDATECP</td> <td>The current position is updated after each text output call.</td> </tr> </table> When
///    the current font has a vertical default base line (as with Kanji), the following values are used instead of
///    TA_BASELINE and TA_CENTER. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>VTA_BASELINE</td> <td>The
///    reference point is on the base line of the text.</td> </tr> <tr> <td>VTA_CENTER</td> <td>The reference point is
///    aligned vertically with the center of the bounding rectangle.</td> </tr> </table> If the function fails, the
///    return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetTextAlign(HDC hdc);

///The <b>GetTextColor</b> function retrieves the current text color for the specified device context.
///Params:
///    hdc = Handle to the device context.
///Returns:
///    If the function succeeds, the return value is the current text color as a COLORREF value. If the function fails,
///    the return value is CLR_INVALID. No extended error information is available.
///    
@DllImport("GDI32")
uint GetTextColor(HDC hdc);

///The <b>GetTextExtentPoint</b> function computes the width and height of the specified string of text. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should call the GetTextExtentPoint32 function, which provides more accurate results.</div> <div> </div>
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to the string that specifies the text. The string does not need to be zero-terminated, since
///               <i>cbString</i> specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>.
///    lpsz = A pointer to a SIZE structure that receives the dimensions of the string, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentPointA(HDC hdc, const(char)* lpString, int c, SIZE* lpsz);

///The <b>GetTextExtentPoint</b> function computes the width and height of the specified string of text. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should call the GetTextExtentPoint32 function, which provides more accurate results.</div> <div> </div>
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to the string that specifies the text. The string does not need to be zero-terminated, since
///               <i>cbString</i> specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>.
///    lpsz = A pointer to a SIZE structure that receives the dimensions of the string, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentPointW(HDC hdc, const(wchar)* lpString, int c, SIZE* lpsz);

///The <b>GetTextExtentPoint32</b> function computes the width and height of the specified string of text.
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to a buffer that specifies the text string. The string does not need to be null-terminated, because the
///               <i>c</i> parameter specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>.
///    psizl = A pointer to a SIZE structure that receives the dimensions of the string, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentPoint32A(HDC hdc, const(char)* lpString, int c, SIZE* psizl);

///The <b>GetTextExtentPoint32</b> function computes the width and height of the specified string of text.
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to a buffer that specifies the text string. The string does not need to be null-terminated, because the
///               <i>c</i> parameter specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>.
///    psizl = A pointer to a SIZE structure that receives the dimensions of the string, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentPoint32W(HDC hdc, const(wchar)* lpString, int c, SIZE* psizl);

///The <b>GetTextExtentExPoint</b> function retrieves the number of characters in a specified string that will fit
///within a specified space and fills an array with the text extent for each of those characters. (A text extent is the
///distance between the beginning of the space and a character that will fit in the space.) This information is useful
///for word-wrapping calculations.
///Params:
///    hdc = A handle to the device context.
///    lpszString = A pointer to the null-terminated string for which extents are to be retrieved.
///    cchString = The number of characters in the string pointed to by the <i>lpszStr</i> parameter. For an ANSI call it specifies
///                the string length in bytes and for a Unicode it specifies the string length in WORDs. Note that for the ANSI
///                function, characters in SBCS code pages take one byte each, while most characters in DBCS code pages take two
///                bytes; for the Unicode function, most currently defined Unicode characters (those in the Basic Multilingual Plane
///                (BMP)) are one WORD while Unicode surrogates are two WORDs.
///    nMaxExtent = The maximum allowable width, in logical units, of the formatted string.
///    lpnFit = A pointer to an integer that receives a count of the maximum number of characters that will fit in the space
///             specified by the <i>nMaxExtent</i> parameter. When the <i>lpnFit</i> parameter is <b>NULL</b>, the
///             <i>nMaxExtent</i> parameter is ignored.
///    lpnDx = A pointer to an array of integers that receives partial string extents. Each element in the array gives the
///            distance, in logical units, between the beginning of the string and one of the characters that fits in the space
///            specified by the <i>nMaxExtent</i> parameter. This array must have at least as many elements as characters
///            specified by the <i>cchString</i> parameter because the entire array is used internally. The function fills the
///            array with valid extents for as many characters as are specified by the <i>lpnFit</i> parameter. Any values in
///            the rest of the array should be ignored. If <i>alpDx</i> is <b>NULL</b>, the function does not compute partial
///            string widths. For complex scripts, where a sequence of characters may be represented by any number of glyphs,
///            the values in the <i>alpDx</i> array up to the number specified by the <i>lpnFit</i> parameter match one-to-one
///            with code points. Again, you should ignore the rest of the values in the <i>alpDx</i> array.
///    lpSize = A pointer to a SIZE structure that receives the dimensions of the string, in logical units. This parameter cannot
///             be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentExPointA(HDC hdc, const(char)* lpszString, int cchString, int nMaxExtent, int* lpnFit, 
                           char* lpnDx, SIZE* lpSize);

///The <b>GetTextExtentExPoint</b> function retrieves the number of characters in a specified string that will fit
///within a specified space and fills an array with the text extent for each of those characters. (A text extent is the
///distance between the beginning of the space and a character that will fit in the space.) This information is useful
///for word-wrapping calculations.
///Params:
///    hdc = A handle to the device context.
///    lpszString = A pointer to the null-terminated string for which extents are to be retrieved.
///    cchString = The number of characters in the string pointed to by the <i>lpszStr</i> parameter. For an ANSI call it specifies
///                the string length in bytes and for a Unicode it specifies the string length in WORDs. Note that for the ANSI
///                function, characters in SBCS code pages take one byte each, while most characters in DBCS code pages take two
///                bytes; for the Unicode function, most currently defined Unicode characters (those in the Basic Multilingual Plane
///                (BMP)) are one WORD while Unicode surrogates are two WORDs.
///    nMaxExtent = The maximum allowable width, in logical units, of the formatted string.
///    lpnFit = A pointer to an integer that receives a count of the maximum number of characters that will fit in the space
///             specified by the <i>nMaxExtent</i> parameter. When the <i>lpnFit</i> parameter is <b>NULL</b>, the
///             <i>nMaxExtent</i> parameter is ignored.
///    lpnDx = A pointer to an array of integers that receives partial string extents. Each element in the array gives the
///            distance, in logical units, between the beginning of the string and one of the characters that fits in the space
///            specified by the <i>nMaxExtent</i> parameter. This array must have at least as many elements as characters
///            specified by the <i>cchString</i> parameter because the entire array is used internally. The function fills the
///            array with valid extents for as many characters as are specified by the <i>lpnFit</i> parameter. Any values in
///            the rest of the array should be ignored. If <i>alpDx</i> is <b>NULL</b>, the function does not compute partial
///            string widths. For complex scripts, where a sequence of characters may be represented by any number of glyphs,
///            the values in the <i>alpDx</i> array up to the number specified by the <i>lpnFit</i> parameter match one-to-one
///            with code points. Again, you should ignore the rest of the values in the <i>alpDx</i> array.
///    lpSize = A pointer to a SIZE structure that receives the dimensions of the string, in logical units. This parameter cannot
///             be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentExPointW(HDC hdc, const(wchar)* lpszString, int cchString, int nMaxExtent, int* lpnFit, 
                           char* lpnDx, SIZE* lpSize);

///The <b>GetFontLanguageInfo</b> function returns information about the currently selected font for the specified
///display context. Applications typically use this information and the GetCharacterPlacement function to prepare a
///character string for display.
///Params:
///    hdc = Handle to a display device context.
///Returns:
///    The return value identifies characteristics of the currently selected font. The function returns 0 if the font is
///    "normalized" and can be treated as a simple Latin font; it returns GCP_ERROR if an error occurs. Otherwise, the
///    function returns a combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///    <td>GCP_DBCS</td> <td>The character set is DBCS.</td> </tr> <tr> <td>GCP_DIACRITIC</td> <td>The font/language
///    contains diacritic glyphs.</td> </tr> <tr> <td>FLI_GLYPHS</td> <td>The font contains extra glyphs not normally
///    accessible using the code page. Use GetCharacterPlacement to access the glyphs. This value is for information
///    only and is not intended to be passed to <b>GetCharacterPlacement</b>.</td> </tr> <tr> <td>GCP_GLYPHSHAPE</td>
///    <td>The font/language contains multiple glyphs per code point or per code point combination (supports shaping
///    and/or ligation), and the font contains advanced glyph tables to provide extra glyphs for the extra shapes. If
///    this value is specified, the <b>lpGlyphs</b> array must be used with the GetCharacterPlacement function and the
///    ETO_GLYPHINDEX value must be passed to the ExtTextOut function when the string is drawn.</td> </tr> <tr>
///    <td>GCP_KASHIDA</td> <td>The font/ language permits Kashidas.</td> </tr> <tr> <td>GCP_LIGATE</td> <td>The
///    font/language contains ligation glyphs which can be substituted for specific character combinations.</td> </tr>
///    <tr> <td>GCP_USEKERNING</td> <td>The font contains a kerning table which can be used to provide better spacing
///    between the characters and glyphs.</td> </tr> <tr> <td>GCP_REORDER</td> <td>The language requires reordering for
///    displayfor example, Hebrew or Arabic.</td> </tr> </table> The return value, when masked with FLI_MASK, can be
///    passed directly to the GetCharacterPlacement function.
///    
@DllImport("GDI32")
uint GetFontLanguageInfo(HDC hdc);

///The <b>GetCharacterPlacement</b> function retrieves information about a character string, such as character widths,
///caret positioning, ordering within the string, and glyph rendering. The type of information returned depends on the
///<i>dwFlags</i> parameter and is based on the currently selected font in the specified display context. The function
///copies the information to the specified GCP_RESULTS structure or to one or more arrays specified by the structure.
///Although this function was once adequate for working with character strings, a need to work with an increasing number
///of languages and scripts has rendered it obsolete. It has been superseded by the functionality of the Uniscribe
///module. For more information, see Uniscribe. It is recommended that an application use the GetFontLanguageInfo
///function to determine whether the GCP_DIACRITIC, GCP_DBCS, GCP_USEKERNING, GCP_LIGATE, GCP_REORDER, GCP_GLYPHSHAPE,
///and GCP_KASHIDA values are valid for the currently selected font. If not valid, <b>GetCharacterPlacement</b> ignores
///the value. The GCP_NODIACRITICS value is no longer defined and should not be used.
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to the character string to process. The string does not need to be zero-terminated, since <i>nCount</i>
///               specifies the length of the string.
///    nCount = The length of the string pointed to by <i>lpString</i>.
///    nMexExtent = The maximum extent (in logical units) to which the string is processed. Characters that, if processed, would
///                 exceed this extent are ignored. Computations for any required ordering or glyph arrays apply only to the included
///                 characters. This parameter is used only if the GCP_MAXEXTENT value is specified in the <i>dwFlags</i> parameter.
///                 As the function processes the input string, each character and its extent is added to the output, extent, and
///                 other arrays only if the total extent has not yet exceeded the maximum. Once the limit is reached, processing
///                 will stop.
///    lpResults = A pointer to a GCP_RESULTS structure that receives the results of the function.
///    dwFlags = Specifies how to process the string into the required arrays. This parameter can be one or more of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCP_CLASSIN"></a><a
///              id="gcp_classin"></a><dl> <dt><b>GCP_CLASSIN</b></dt> </dl> </td> <td width="60%"> Specifies that the
///              <i>lpClass</i> array contains preset classifications for characters. The classifications may be the same as on
///              output. If the particular classification for a character is not known, the corresponding location in the array
///              must be set to zero. for more information about the classifications, see GCP_RESULTS. This is useful only if
///              GetFontLanguageInfo returned the GCP_REORDER flag. </td> </tr> <tr> <td width="40%"><a id="GCP_DIACRITIC"></a><a
///              id="gcp_diacritic"></a><dl> <dt><b>GCP_DIACRITIC</b></dt> </dl> </td> <td width="60%"> Determines how diacritics
///              in the string are handled. If this value is not set, diacritics are treated as zero-width characters. For
///              example, a Hebrew string may contain diacritics, but you may not want to display them. Use GetFontLanguageInfo to
///              determine whether a font supports diacritics. If it does, you can use or not use the GCP_DIACRITIC flag in the
///              call to <b>GetCharacterPlacement</b>, depending on the needs of your application. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_DISPLAYZWG"></a><a id="gcp_displayzwg"></a><dl> <dt><b>GCP_DISPLAYZWG</b></dt> </dl> </td>
///              <td width="60%"> For languages that need reordering or different glyph shapes depending on the positions of the
///              characters within a word, nondisplayable characters often appear in the code page. For example, in the Hebrew
///              code page, there are Left-To-Right and Right-To-Left markers, to help determine the final positioning of
///              characters within the output strings. Normally these are not displayed and are removed from the <i>lpGlyphs</i>
///              and <i>lpDx</i> arrays. You can use the GCP_DISPLAYZWG flag to display these characters. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_GLYPHSHAPE"></a><a id="gcp_glyphshape"></a><dl> <dt><b>GCP_GLYPHSHAPE</b></dt> </dl> </td>
///              <td width="60%"> Specifies that some or all characters in the string are to be displayed using shapes other than
///              the standard shapes defined in the currently selected font for the current code page. Some languages, such as
///              Arabic, cannot support glyph creation unless this value is specified. As a general rule, if GetFontLanguageInfo
///              returns this value for a string, this value must be used with <b>GetCharacterPlacement</b>. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_JUSTIFY"></a><a id="gcp_justify"></a><dl> <dt><b>GCP_JUSTIFY</b></dt> </dl> </td> <td
///              width="60%"> Adjusts the extents in the <i>lpDx</i> array so that the string length is the same as
///              <i>nMaxExtent</i>. GCP_JUSTIFY may only be used in conjunction with GCP_MAXEXTENT. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_KASHIDA"></a><a id="gcp_kashida"></a><dl> <dt><b>GCP_KASHIDA</b></dt> </dl> </td> <td
///              width="60%"> Use Kashidas as well as, or instead of, adjusted extents to modify the length of the string so that
///              it is equal to the value specified by <i>nMaxExtent</i>. In the <i>lpDx</i> array, a Kashida is indicated by a
///              negative justification index. GCP_KASHIDA may be used only in conjunction with GCP_JUSTIFY and only if the font
///              (and language) support Kashidas. Use GetFontLanguageInfo to determine whether the current font supports Kashidas.
///              Using Kashidas to justify the string can result in the number of glyphs required being greater than the number of
///              characters in the input string. Because of this, when Kashidas are used, the application cannot assume that
///              setting the arrays to be the size of the input string will be sufficient. (The maximum possible will be
///              approximately dxPageWidth/dxAveCharWidth, where dxPageWidth is the width of the document and dxAveCharWidth is
///              the average character width as returned from a GetTextMetrics call). Note that just because GetFontLanguageInfo
///              returns the GCP_KASHIDA flag does not mean that it has to be used in the call to <b>GetCharacterPlacement</b>,
///              just that the option is available. </td> </tr> <tr> <td width="40%"><a id="GCP_LIGATE"></a><a
///              id="gcp_ligate"></a><dl> <dt><b>GCP_LIGATE</b></dt> </dl> </td> <td width="60%"> Use ligations wherever
///              characters ligate. A ligation occurs where one glyph is used for two or more characters. For example, the letters
///              a and e can ligate to ?. For this to be used, however, both the language support and the font must support the
///              required glyphs (the example will not be processed by default in English). Use GetFontLanguageInfo to determine
///              whether the current font supports ligation. If it does and a specific maximum is required for the number of
///              characters that will ligate, set the number in the first element of the <b>lpGlyphs</b> array. If normal ligation
///              is required, set this value to zero. If GCP_LIGATE is not specified, no ligation will take place. See GCP_RESULTS
///              for more information. If the GCP_REORDER value is usually required for the character set but is not specified,
///              the output will be meaningless unless the string being passed in is already in visual ordering (that is, the
///              result that gets put into lpGcpResults-&gt;lpOutString in one call to <b>GetCharacterPlacement</b> is the input
///              string of a second call). Note that just because GetFontLanguageInfo returns the GCP_LIGATE flag does not mean
///              that it has to be used in the call to <b>GetCharacterPlacement</b>, just that the option is available. </td>
///              </tr> <tr> <td width="40%"><a id="GCP_MAXEXTENT"></a><a id="gcp_maxextent"></a><dl> <dt><b>GCP_MAXEXTENT</b></dt>
///              </dl> </td> <td width="60%"> Compute extents of the string only as long as the resulting extent, in logical
///              units, does not exceed the values specified by the <i>nMaxExtent</i> parameter. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_NEUTRALOVERRIDE"></a><a id="gcp_neutraloverride"></a><dl>
///              <dt><b>GCP_NEUTRALOVERRIDE</b></dt> </dl> </td> <td width="60%"> Certain languages only. Override the normal
///              handling of neutrals and treat them as strong characters that match the strings reading order. Useful only with
///              the GCP_REORDER flag. </td> </tr> <tr> <td width="40%"><a id="GCP_NUMERICOVERRIDE"></a><a
///              id="gcp_numericoverride"></a><dl> <dt><b>GCP_NUMERICOVERRIDE</b></dt> </dl> </td> <td width="60%"> Certain
///              languages only. Override the normal handling of numerics and treat them as strong characters that match the
///              strings reading order. Useful only with the GCP_REORDER flag. </td> </tr> <tr> <td width="40%"><a
///              id="GCP_NUMERICSLATIN"></a><a id="gcp_numericslatin"></a><dl> <dt><b>GCP_NUMERICSLATIN</b></dt> </dl> </td> <td
///              width="60%"> Arabic/Thai only. Use standard Latin glyphs for numbers and override the system default. To
///              determine if this option is available in the language of the font, use GetStringTypeEx to see if the language
///              supports more than one number format. </td> </tr> <tr> <td width="40%"><a id="GCP_NUMERICSLOCAL"></a><a
///              id="gcp_numericslocal"></a><dl> <dt><b>GCP_NUMERICSLOCAL</b></dt> </dl> </td> <td width="60%"> Arabic/Thai only.
///              Use local glyphs for numeric characters and override the system default. To determine if this option is available
///              in the language of the font, use GetStringTypeEx to see if the language supports more than one number format.
///              </td> </tr> <tr> <td width="40%"><a id="GCP_REORDER"></a><a id="gcp_reorder"></a><dl> <dt><b>GCP_REORDER</b></dt>
///              </dl> </td> <td width="60%"> Reorder the string. Use for languages that are not SBCS and left-to-right reading
///              order. If this value is not specified, the string is assumed to be in display order already. If this flag is set
///              for Semitic languages and the <b>lpClass</b> array is used, the first two elements of the array are used to
///              specify the reading order beyond the bounds of the string. GCP_CLASS_PREBOUNDRTL and GCP_CLASS_PREBOUNDLTR can be
///              used to set the order. If no preset order is required, set the values to zero. These values can be combined with
///              other values if the GCPCLASSIN flag is set. If the GCP_REORDER value is not specified, the <i>lpString</i>
///              parameter is taken to be visual ordered for languages where this is used, and the <i>lpOutString</i> and
///              <i>lpOrder</i> fields are ignored. Use GetFontLanguageInfo to determine whether the current font supports
///              reordering. </td> </tr> <tr> <td width="40%"><a id="GCP_SYMSWAPOFF"></a><a id="gcp_symswapoff"></a><dl>
///              <dt><b>GCP_SYMSWAPOFF</b></dt> </dl> </td> <td width="60%"> Semitic languages only. Specifies that swappable
///              characters are not reset. For example, in a right-to-left string, the '(' and ')' are not reversed. </td> </tr>
///              <tr> <td width="40%"><a id="GCP_USEKERNING"></a><a id="gcp_usekerning"></a><dl> <dt><b>GCP_USEKERNING</b></dt>
///              </dl> </td> <td width="60%"> Use kerning pairs in the font (if any) when creating the widths arrays. Use
///              GetFontLanguageInfo to determine whether the current font supports kerning pairs. Note that just because
///              GetFontLanguageInfo returns the GCP_USEKERNING flag does not mean that it has to be used in the call to
///              <b>GetCharacterPlacement</b>, just that the option is available. Most TrueType fonts have a kerning table, but
///              you do not have to use it. </td> </tr> </table> It is recommended that an application use the GetFontLanguageInfo
///              function to determine whether the GCP_DIACRITIC, GCP_DBCS, GCP_USEKERNING, GCP_LIGATE, GCP_REORDER,
///              GCP_GLYPHSHAPE, and GCP_KASHIDA values are valid for the currently selected font. If not valid,
///              <b>GetCharacterPlacement</b> ignores the value. The GCP_NODIACRITICS value is no longer defined and should not be
///              used.
///Returns:
///    If the function succeeds, the return value is the width and height of the string in logical units. The width is
///    the low-order word and the height is the high-order word. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetCharacterPlacementA(HDC hdc, const(char)* lpString, int nCount, int nMexExtent, GCP_RESULTSA* lpResults, 
                            uint dwFlags);

///The <b>GetCharacterPlacement</b> function retrieves information about a character string, such as character widths,
///caret positioning, ordering within the string, and glyph rendering. The type of information returned depends on the
///<i>dwFlags</i> parameter and is based on the currently selected font in the specified display context. The function
///copies the information to the specified GCP_RESULTS structure or to one or more arrays specified by the structure.
///Although this function was once adequate for working with character strings, a need to work with an increasing number
///of languages and scripts has rendered it obsolete. It has been superseded by the functionality of the Uniscribe
///module. For more information, see Uniscribe. It is recommended that an application use the GetFontLanguageInfo
///function to determine whether the GCP_DIACRITIC, GCP_DBCS, GCP_USEKERNING, GCP_LIGATE, GCP_REORDER, GCP_GLYPHSHAPE,
///and GCP_KASHIDA values are valid for the currently selected font. If not valid, <b>GetCharacterPlacement</b> ignores
///the value. The GCP_NODIACRITICS value is no longer defined and should not be used.
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to the character string to process. The string does not need to be zero-terminated, since <i>nCount</i>
///               specifies the length of the string.
///    nCount = The length of the string pointed to by <i>lpString</i>.
///    nMexExtent = The maximum extent (in logical units) to which the string is processed. Characters that, if processed, would
///                 exceed this extent are ignored. Computations for any required ordering or glyph arrays apply only to the included
///                 characters. This parameter is used only if the GCP_MAXEXTENT value is specified in the <i>dwFlags</i> parameter.
///                 As the function processes the input string, each character and its extent is added to the output, extent, and
///                 other arrays only if the total extent has not yet exceeded the maximum. Once the limit is reached, processing
///                 will stop.
///    lpResults = A pointer to a GCP_RESULTS structure that receives the results of the function.
///    dwFlags = Specifies how to process the string into the required arrays. This parameter can be one or more of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GCP_CLASSIN"></a><a
///              id="gcp_classin"></a><dl> <dt><b>GCP_CLASSIN</b></dt> </dl> </td> <td width="60%"> Specifies that the
///              <i>lpClass</i> array contains preset classifications for characters. The classifications may be the same as on
///              output. If the particular classification for a character is not known, the corresponding location in the array
///              must be set to zero. for more information about the classifications, see GCP_RESULTS. This is useful only if
///              GetFontLanguageInfo returned the GCP_REORDER flag. </td> </tr> <tr> <td width="40%"><a id="GCP_DIACRITIC"></a><a
///              id="gcp_diacritic"></a><dl> <dt><b>GCP_DIACRITIC</b></dt> </dl> </td> <td width="60%"> Determines how diacritics
///              in the string are handled. If this value is not set, diacritics are treated as zero-width characters. For
///              example, a Hebrew string may contain diacritics, but you may not want to display them. Use GetFontLanguageInfo to
///              determine whether a font supports diacritics. If it does, you can use or not use the GCP_DIACRITIC flag in the
///              call to <b>GetCharacterPlacement</b>, depending on the needs of your application. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_DISPLAYZWG"></a><a id="gcp_displayzwg"></a><dl> <dt><b>GCP_DISPLAYZWG</b></dt> </dl> </td>
///              <td width="60%"> For languages that need reordering or different glyph shapes depending on the positions of the
///              characters within a word, nondisplayable characters often appear in the code page. For example, in the Hebrew
///              code page, there are Left-To-Right and Right-To-Left markers, to help determine the final positioning of
///              characters within the output strings. Normally these are not displayed and are removed from the <i>lpGlyphs</i>
///              and <i>lpDx</i> arrays. You can use the GCP_DISPLAYZWG flag to display these characters. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_GLYPHSHAPE"></a><a id="gcp_glyphshape"></a><dl> <dt><b>GCP_GLYPHSHAPE</b></dt> </dl> </td>
///              <td width="60%"> Specifies that some or all characters in the string are to be displayed using shapes other than
///              the standard shapes defined in the currently selected font for the current code page. Some languages, such as
///              Arabic, cannot support glyph creation unless this value is specified. As a general rule, if GetFontLanguageInfo
///              returns this value for a string, this value must be used with <b>GetCharacterPlacement</b>. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_JUSTIFY"></a><a id="gcp_justify"></a><dl> <dt><b>GCP_JUSTIFY</b></dt> </dl> </td> <td
///              width="60%"> Adjusts the extents in the <i>lpDx</i> array so that the string length is the same as
///              <i>nMaxExtent</i>. GCP_JUSTIFY may only be used in conjunction with GCP_MAXEXTENT. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_KASHIDA"></a><a id="gcp_kashida"></a><dl> <dt><b>GCP_KASHIDA</b></dt> </dl> </td> <td
///              width="60%"> Use Kashidas as well as, or instead of, adjusted extents to modify the length of the string so that
///              it is equal to the value specified by <i>nMaxExtent</i>. In the <i>lpDx</i> array, a Kashida is indicated by a
///              negative justification index. GCP_KASHIDA may be used only in conjunction with GCP_JUSTIFY and only if the font
///              (and language) support Kashidas. Use GetFontLanguageInfo to determine whether the current font supports Kashidas.
///              Using Kashidas to justify the string can result in the number of glyphs required being greater than the number of
///              characters in the input string. Because of this, when Kashidas are used, the application cannot assume that
///              setting the arrays to be the size of the input string will be sufficient. (The maximum possible will be
///              approximately dxPageWidth/dxAveCharWidth, where dxPageWidth is the width of the document and dxAveCharWidth is
///              the average character width as returned from a GetTextMetrics call). Note that just because GetFontLanguageInfo
///              returns the GCP_KASHIDA flag does not mean that it has to be used in the call to <b>GetCharacterPlacement</b>,
///              just that the option is available. </td> </tr> <tr> <td width="40%"><a id="GCP_LIGATE"></a><a
///              id="gcp_ligate"></a><dl> <dt><b>GCP_LIGATE</b></dt> </dl> </td> <td width="60%"> Use ligations wherever
///              characters ligate. A ligation occurs where one glyph is used for two or more characters. For example, the letters
///              a and e can ligate to ?. For this to be used, however, both the language support and the font must support the
///              required glyphs (the example will not be processed by default in English). Use GetFontLanguageInfo to determine
///              whether the current font supports ligation. If it does and a specific maximum is required for the number of
///              characters that will ligate, set the number in the first element of the <b>lpGlyphs</b> array. If normal ligation
///              is required, set this value to zero. If GCP_LIGATE is not specified, no ligation will take place. See GCP_RESULTS
///              for more information. If the GCP_REORDER value is usually required for the character set but is not specified,
///              the output will be meaningless unless the string being passed in is already in visual ordering (that is, the
///              result that gets put into lpGcpResults-&gt;lpOutString in one call to <b>GetCharacterPlacement</b> is the input
///              string of a second call). Note that just because GetFontLanguageInfo returns the GCP_LIGATE flag does not mean
///              that it has to be used in the call to <b>GetCharacterPlacement</b>, just that the option is available. </td>
///              </tr> <tr> <td width="40%"><a id="GCP_MAXEXTENT"></a><a id="gcp_maxextent"></a><dl> <dt><b>GCP_MAXEXTENT</b></dt>
///              </dl> </td> <td width="60%"> Compute extents of the string only as long as the resulting extent, in logical
///              units, does not exceed the values specified by the <i>nMaxExtent</i> parameter. </td> </tr> <tr> <td
///              width="40%"><a id="GCP_NEUTRALOVERRIDE"></a><a id="gcp_neutraloverride"></a><dl>
///              <dt><b>GCP_NEUTRALOVERRIDE</b></dt> </dl> </td> <td width="60%"> Certain languages only. Override the normal
///              handling of neutrals and treat them as strong characters that match the strings reading order. Useful only with
///              the GCP_REORDER flag. </td> </tr> <tr> <td width="40%"><a id="GCP_NUMERICOVERRIDE"></a><a
///              id="gcp_numericoverride"></a><dl> <dt><b>GCP_NUMERICOVERRIDE</b></dt> </dl> </td> <td width="60%"> Certain
///              languages only. Override the normal handling of numerics and treat them as strong characters that match the
///              strings reading order. Useful only with the GCP_REORDER flag. </td> </tr> <tr> <td width="40%"><a
///              id="GCP_NUMERICSLATIN"></a><a id="gcp_numericslatin"></a><dl> <dt><b>GCP_NUMERICSLATIN</b></dt> </dl> </td> <td
///              width="60%"> Arabic/Thai only. Use standard Latin glyphs for numbers and override the system default. To
///              determine if this option is available in the language of the font, use GetStringTypeEx to see if the language
///              supports more than one number format. </td> </tr> <tr> <td width="40%"><a id="GCP_NUMERICSLOCAL"></a><a
///              id="gcp_numericslocal"></a><dl> <dt><b>GCP_NUMERICSLOCAL</b></dt> </dl> </td> <td width="60%"> Arabic/Thai only.
///              Use local glyphs for numeric characters and override the system default. To determine if this option is available
///              in the language of the font, use GetStringTypeEx to see if the language supports more than one number format.
///              </td> </tr> <tr> <td width="40%"><a id="GCP_REORDER"></a><a id="gcp_reorder"></a><dl> <dt><b>GCP_REORDER</b></dt>
///              </dl> </td> <td width="60%"> Reorder the string. Use for languages that are not SBCS and left-to-right reading
///              order. If this value is not specified, the string is assumed to be in display order already. If this flag is set
///              for Semitic languages and the <b>lpClass</b> array is used, the first two elements of the array are used to
///              specify the reading order beyond the bounds of the string. GCP_CLASS_PREBOUNDRTL and GCP_CLASS_PREBOUNDLTR can be
///              used to set the order. If no preset order is required, set the values to zero. These values can be combined with
///              other values if the GCPCLASSIN flag is set. If the GCP_REORDER value is not specified, the <i>lpString</i>
///              parameter is taken to be visual ordered for languages where this is used, and the <i>lpOutString</i> and
///              <i>lpOrder</i> fields are ignored. Use GetFontLanguageInfo to determine whether the current font supports
///              reordering. </td> </tr> <tr> <td width="40%"><a id="GCP_SYMSWAPOFF"></a><a id="gcp_symswapoff"></a><dl>
///              <dt><b>GCP_SYMSWAPOFF</b></dt> </dl> </td> <td width="60%"> Semitic languages only. Specifies that swappable
///              characters are not reset. For example, in a right-to-left string, the '(' and ')' are not reversed. </td> </tr>
///              <tr> <td width="40%"><a id="GCP_USEKERNING"></a><a id="gcp_usekerning"></a><dl> <dt><b>GCP_USEKERNING</b></dt>
///              </dl> </td> <td width="60%"> Use kerning pairs in the font (if any) when creating the widths arrays. Use
///              GetFontLanguageInfo to determine whether the current font supports kerning pairs. Note that just because
///              GetFontLanguageInfo returns the GCP_USEKERNING flag does not mean that it has to be used in the call to
///              <b>GetCharacterPlacement</b>, just that the option is available. Most TrueType fonts have a kerning table, but
///              you do not have to use it. </td> </tr> </table> It is recommended that an application use the GetFontLanguageInfo
///              function to determine whether the GCP_DIACRITIC, GCP_DBCS, GCP_USEKERNING, GCP_LIGATE, GCP_REORDER,
///              GCP_GLYPHSHAPE, and GCP_KASHIDA values are valid for the currently selected font. If not valid,
///              <b>GetCharacterPlacement</b> ignores the value. The GCP_NODIACRITICS value is no longer defined and should not be
///              used.
///Returns:
///    If the function succeeds, the return value is the width and height of the string in logical units. The width is
///    the low-order word and the height is the high-order word. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetCharacterPlacementW(HDC hdc, const(wchar)* lpString, int nCount, int nMexExtent, GCP_RESULTSW* lpResults, 
                            uint dwFlags);

///The <b>GetFontUnicodeRanges</b> function returns information about which Unicode characters are supported by a font.
///The information is returned as a GLYPHSET structure.
///Params:
///    hdc = A handle to the device context.
///    lpgs = A pointer to a GLYPHSET structure that receives the glyph set information. If this parameter is <b>NULL</b>, the
///           function returns the size of the <b>GLYPHSET</b> structure required to store the information.
///Returns:
///    If the function succeeds, it returns number of bytes written to the GLYPHSET structure or, if the <i>lpgs</i>
///    parameter is <b>NULL</b>, it returns the size of the GLYPHSET structure required to store the information. If the
///    function fails, it returns zero. No extended error information is available.
///    
@DllImport("GDI32")
uint GetFontUnicodeRanges(HDC hdc, GLYPHSET* lpgs);

///The <b>GetGlyphIndices</b> function translates a string into an array of glyph indices. The function can be used to
///determine whether a glyph exists in a font.
///Params:
///    hdc = A handle to the device context.
///    lpstr = A pointer to the string to be converted.
///    c = The length of both the length of the string pointed to by <i>lpstr</i> and the size (in WORDs) of the buffer
///        pointed to by <i>pgi</i>.
///    pgi = This buffer must be of dimension c. On successful return, contains an array of glyph indices corresponding to the
///          characters in the string.
///    fl = Specifies how glyphs should be handled if they are not supported. This parameter can be the following value.
///         <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///         id="GGI_MARK_NONEXISTING_GLYPHS"></a><a id="ggi_mark_nonexisting_glyphs"></a><dl>
///         <dt><b>GGI_MARK_NONEXISTING_GLYPHS</b></dt> </dl> </td> <td width="60%"> Marks unsupported glyphs with the
///         hexadecimal value 0xffff. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns the number of bytes (for the ANSI function) or WORDs (for the Unicode
///    function) converted. If the function fails, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetGlyphIndicesA(HDC hdc, const(char)* lpstr, int c, char* pgi, uint fl);

///The <b>GetGlyphIndices</b> function translates a string into an array of glyph indices. The function can be used to
///determine whether a glyph exists in a font.
///Params:
///    hdc = A handle to the device context.
///    lpstr = A pointer to the string to be converted.
///    c = The length of both the length of the string pointed to by <i>lpstr</i> and the size (in WORDs) of the buffer
///        pointed to by <i>pgi</i>.
///    pgi = This buffer must be of dimension c. On successful return, contains an array of glyph indices corresponding to the
///          characters in the string.
///    fl = Specifies how glyphs should be handled if they are not supported. This parameter can be the following value.
///         <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///         id="GGI_MARK_NONEXISTING_GLYPHS"></a><a id="ggi_mark_nonexisting_glyphs"></a><dl>
///         <dt><b>GGI_MARK_NONEXISTING_GLYPHS</b></dt> </dl> </td> <td width="60%"> Marks unsupported glyphs with the
///         hexadecimal value 0xffff. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns the number of bytes (for the ANSI function) or WORDs (for the Unicode
///    function) converted. If the function fails, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetGlyphIndicesW(HDC hdc, const(wchar)* lpstr, int c, char* pgi, uint fl);

///The <b>GetTextExtentPointI</b> function computes the width and height of the specified array of glyph indices.
///Params:
///    hdc = Handle to the device context.
///    pgiIn = Pointer to array of glyph indices.
///    cgi = Specifies the number of glyph indices.
///    psize = Pointer to a SIZE structure that receives the dimensions of the string, in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentPointI(HDC hdc, char* pgiIn, int cgi, SIZE* psize);

///The <b>GetTextExtentExPointI</b> function retrieves the number of characters in a specified string that will fit
///within a specified space and fills an array with the text extent for each of those characters. (A text extent is the
///distance between the beginning of the space and a character that will fit in the space.) This information is useful
///for word-wrapping calculations.
///Params:
///    hdc = A handle to the device context.
///    lpwszString = A pointer to an array of glyph indices for which extents are to be retrieved.
///    cwchString = The number of glyphs in the array pointed to by the <i>pgiIn</i> parameter.
///    nMaxExtent = The maximum allowable width, in logical units, of the formatted string.
///    lpnFit = A pointer to an integer that receives a count of the maximum number of characters that will fit in the space
///             specified by the <i>nMaxExtent</i> parameter. When the <i>lpnFit</i> parameter is <b>NULL</b>, the
///             <i>nMaxExtent</i> parameter is ignored.
///    lpnDx = A pointer to an array of integers that receives partial glyph extents. Each element in the array gives the
///            distance, in logical units, between the beginning of the glyph indices array and one of the glyphs that fits in
///            the space specified by the <i>nMaxExtent</i> parameter. Although this array should have at least as many elements
///            as glyph indices specified by the <i>cgi</i> parameter, the function fills the array with extents only for as
///            many glyph indices as are specified by the <i>lpnFit</i> parameter. If <i>lpnFit</i> is <b>NULL</b>, the function
///            does not compute partial string widths.
///    lpSize = A pointer to a SIZE structure that receives the dimensions of the glyph indices array, in logical units. This
///             value cannot be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextExtentExPointI(HDC hdc, char* lpwszString, int cwchString, int nMaxExtent, int* lpnFit, char* lpnDx, 
                           SIZE* lpSize);

///The <b>GetCharWidthI</b> function retrieves the widths, in logical coordinates, of consecutive glyph indices in a
///specified range from the current font.
///Params:
///    hdc = A handle to the device context.
///    giFirst = The first glyph index in the group of consecutive glyph indices.
///    cgi = The number of glyph indices.
///    pgi = A pointer to an array of glyph indices. If this parameter is not <b>NULL</b>, it is used instead of the
///          <i>giFirst</i> parameter.
///    piWidths = A pointer to a buffer that receives the widths, in logical coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharWidthI(HDC hdc, uint giFirst, uint cgi, char* pgi, char* piWidths);

///The <b>GetCharABCWidthsI</b> function retrieves the widths, in logical units, of consecutive glyph indices in a
///specified range from the current TrueType font. This function succeeds only with TrueType fonts.
///Params:
///    hdc = A handle to the device context.
///    giFirst = The first glyph index in the group of consecutive glyph indices from the current font. This parameter is only
///              used if the <i>pgi</i> parameter is <b>NULL</b>.
///    cgi = The number of glyph indices.
///    pgi = A pointer to an array that contains glyph indices. If this parameter is <b>NULL</b>, the <i>giFirst</i> parameter
///          is used instead. The <i>cgi</i> parameter specifies the number of glyph indices in this array.
///    pabc = A pointer to an array of ABC structures that receives the character widths, in logical units. This array must
///           contain at least as many <b>ABC</b> structures as there are glyph indices specified by the <i>cgi</i> parameter.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetCharABCWidthsI(HDC hdc, uint giFirst, uint cgi, char* pgi, char* pabc);

///The <b>AddFontResourceEx</b> function adds the font resource from the specified file to the system. Fonts added with
///the <b>AddFontResourceEx</b> function can be marked as private and not enumerable.
///Params:
///    name = A pointer to a null-terminated character string that contains a valid font file name. This parameter can specify
///           any of the following files. <table> <tr> <th>File Extension</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id=".fon"></a><a id=".FON"></a><dl> <dt><b>.fon</b></dt> </dl> </td> <td width="60%"> Font resource file. </td>
///           </tr> <tr> <td width="40%"><a id=".fnt"></a><a id=".FNT"></a><dl> <dt><b>.fnt</b></dt> </dl> </td> <td
///           width="60%"> Raw bitmap font file. </td> </tr> <tr> <td width="40%"><a id=".ttf"></a><a id=".TTF"></a><dl>
///           <dt><b>.ttf</b></dt> </dl> </td> <td width="60%"> Raw TrueType file. </td> </tr> <tr> <td width="40%"><a
///           id=".ttc"></a><a id=".TTC"></a><dl> <dt><b>.ttc</b></dt> </dl> </td> <td width="60%"> East Asian Windows:
///           TrueType font collection. </td> </tr> <tr> <td width="40%"><a id=".fot"></a><a id=".FOT"></a><dl>
///           <dt><b>.fot</b></dt> </dl> </td> <td width="60%"> TrueType resource file. </td> </tr> <tr> <td width="40%"><a
///           id=".otf"></a><a id=".OTF"></a><dl> <dt><b>.otf</b></dt> </dl> </td> <td width="60%"> PostScript OpenType font.
///           </td> </tr> <tr> <td width="40%"><a id=".mmm"></a><a id=".MMM"></a><dl> <dt><b>.mmm</b></dt> </dl> </td> <td
///           width="60%"> multiple master Type1 font resource file. It must be used with .pfm and .pfb files. </td> </tr> <tr>
///           <td width="40%"><a id=".pfb"></a><a id=".PFB"></a><dl> <dt><b>.pfb</b></dt> </dl> </td> <td width="60%"> Type 1
///           font bits file. It is used with a .pfm file. </td> </tr> <tr> <td width="40%"><a id=".pfm"></a><a
///           id=".PFM"></a><dl> <dt><b>.pfm</b></dt> </dl> </td> <td width="60%"> Type 1 font metrics file. It is used with a
///           .pfb file. </td> </tr> </table> To add a font whose information comes from several resource files, point
///           <i>lpszFileName</i> to a string with the file names separated by a | --for example, abcxxxxx.pfm | abcxxxxx.pfb.
///    fl = The characteristics of the font to be added to the system. This parameter can be one of the following values.
///         <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FR_PRIVATE"></a><a
///         id="fr_private"></a><dl> <dt><b>FR_PRIVATE</b></dt> </dl> </td> <td width="60%"> Specifies that only the process
///         that called the <b>AddFontResourceEx</b> function can use this font. When the font name matches a public font,
///         the private font will be chosen. When the process terminates, the system will remove all fonts installed by the
///         process with the <b>AddFontResourceEx</b> function. </td> </tr> <tr> <td width="40%"><a id="FR_NOT_ENUM"></a><a
///         id="fr_not_enum"></a><dl> <dt><b>FR_NOT_ENUM</b></dt> </dl> </td> <td width="60%"> Specifies that no process,
///         including the process that called the <b>AddFontResourceEx</b> function, can enumerate this font. </td> </tr>
///         </table>
///    res = Reserved. Must be zero.
///Returns:
///    If the function succeeds, the return value specifies the number of fonts added. If the function fails, the return
///    value is zero. No extended error information is available.
///    
@DllImport("GDI32")
int AddFontResourceExA(const(char)* name, uint fl, void* res);

///The <b>AddFontResourceEx</b> function adds the font resource from the specified file to the system. Fonts added with
///the <b>AddFontResourceEx</b> function can be marked as private and not enumerable.
///Params:
///    name = A pointer to a null-terminated character string that contains a valid font file name. This parameter can specify
///           any of the following files. <table> <tr> <th>File Extension</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id=".fon"></a><a id=".FON"></a><dl> <dt><b>.fon</b></dt> </dl> </td> <td width="60%"> Font resource file. </td>
///           </tr> <tr> <td width="40%"><a id=".fnt"></a><a id=".FNT"></a><dl> <dt><b>.fnt</b></dt> </dl> </td> <td
///           width="60%"> Raw bitmap font file. </td> </tr> <tr> <td width="40%"><a id=".ttf"></a><a id=".TTF"></a><dl>
///           <dt><b>.ttf</b></dt> </dl> </td> <td width="60%"> Raw TrueType file. </td> </tr> <tr> <td width="40%"><a
///           id=".ttc"></a><a id=".TTC"></a><dl> <dt><b>.ttc</b></dt> </dl> </td> <td width="60%"> East Asian Windows:
///           TrueType font collection. </td> </tr> <tr> <td width="40%"><a id=".fot"></a><a id=".FOT"></a><dl>
///           <dt><b>.fot</b></dt> </dl> </td> <td width="60%"> TrueType resource file. </td> </tr> <tr> <td width="40%"><a
///           id=".otf"></a><a id=".OTF"></a><dl> <dt><b>.otf</b></dt> </dl> </td> <td width="60%"> PostScript OpenType font.
///           </td> </tr> <tr> <td width="40%"><a id=".mmm"></a><a id=".MMM"></a><dl> <dt><b>.mmm</b></dt> </dl> </td> <td
///           width="60%"> multiple master Type1 font resource file. It must be used with .pfm and .pfb files. </td> </tr> <tr>
///           <td width="40%"><a id=".pfb"></a><a id=".PFB"></a><dl> <dt><b>.pfb</b></dt> </dl> </td> <td width="60%"> Type 1
///           font bits file. It is used with a .pfm file. </td> </tr> <tr> <td width="40%"><a id=".pfm"></a><a
///           id=".PFM"></a><dl> <dt><b>.pfm</b></dt> </dl> </td> <td width="60%"> Type 1 font metrics file. It is used with a
///           .pfb file. </td> </tr> </table> To add a font whose information comes from several resource files, point
///           <i>lpszFileName</i> to a string with the file names separated by a | --for example, abcxxxxx.pfm | abcxxxxx.pfb.
///    fl = The characteristics of the font to be added to the system. This parameter can be one of the following values.
///         <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FR_PRIVATE"></a><a
///         id="fr_private"></a><dl> <dt><b>FR_PRIVATE</b></dt> </dl> </td> <td width="60%"> Specifies that only the process
///         that called the <b>AddFontResourceEx</b> function can use this font. When the font name matches a public font,
///         the private font will be chosen. When the process terminates, the system will remove all fonts installed by the
///         process with the <b>AddFontResourceEx</b> function. </td> </tr> <tr> <td width="40%"><a id="FR_NOT_ENUM"></a><a
///         id="fr_not_enum"></a><dl> <dt><b>FR_NOT_ENUM</b></dt> </dl> </td> <td width="60%"> Specifies that no process,
///         including the process that called the <b>AddFontResourceEx</b> function, can enumerate this font. </td> </tr>
///         </table>
///    res = Reserved. Must be zero.
///Returns:
///    If the function succeeds, the return value specifies the number of fonts added. If the function fails, the return
///    value is zero. No extended error information is available.
///    
@DllImport("GDI32")
int AddFontResourceExW(const(wchar)* name, uint fl, void* res);

///The <b>RemoveFontResourceEx</b> function removes the fonts in the specified file from the system font table.
///Params:
///    name = A pointer to a null-terminated string that names a font resource file.
///    fl = The characteristics of the font to be removed from the system. In order for the font to be removed, the flags
///         used must be the same as when the font was added with the AddFontResourceEx function. See the
///         <b>AddFontResourceEx</b> function for more information.
///    pdv = Reserved. Must be zero.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. No
///    extended error information is available.
///    
@DllImport("GDI32")
BOOL RemoveFontResourceExA(const(char)* name, uint fl, void* pdv);

///The <b>RemoveFontResourceEx</b> function removes the fonts in the specified file from the system font table.
///Params:
///    name = A pointer to a null-terminated string that names a font resource file.
///    fl = The characteristics of the font to be removed from the system. In order for the font to be removed, the flags
///         used must be the same as when the font was added with the AddFontResourceEx function. See the
///         <b>AddFontResourceEx</b> function for more information.
///    pdv = Reserved. Must be zero.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. No
///    extended error information is available.
///    
@DllImport("GDI32")
BOOL RemoveFontResourceExW(const(wchar)* name, uint fl, void* pdv);

///The <b>AddFontMemResourceEx</b> function adds the font resource from a memory image to the system.
///Params:
///    pFileView = A pointer to a font resource.
///    cjSize = The number of bytes in the font resource that is pointed to by <i>pbFont</i>.
///    pvResrved = Reserved. Must be 0.
///    pNumFonts = A pointer to a variable that specifies the number of fonts installed.
///Returns:
///    If the function succeeds, the return value specifies the handle to the font added. This handle uniquely
///    identifies the fonts that were installed on the system. If the function fails, the return value is zero. No
///    extended error information is available.
///    
@DllImport("GDI32")
HANDLE AddFontMemResourceEx(char* pFileView, uint cjSize, void* pvResrved, uint* pNumFonts);

///The <b>RemoveFontMemResourceEx</b> function removes the fonts added from a memory image file.
///Params:
///    h = A handle to the font-resource. This handle is returned by the AddFontMemResourceEx function.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. No
///    extended error information is available.
///    
@DllImport("GDI32")
BOOL RemoveFontMemResourceEx(HANDLE h);

///The <b>CreateFontIndirectEx</b> function specifies a logical font that has the characteristics in the specified
///structure. The font can subsequently be selected as the current font for any device context.
///Params:
///    Arg1 = Pointer to an ENUMLOGFONTEXDV structure that defines the characteristics of a multiple master font. Note, this
///           function ignores the <b>elfDesignVector</b> member in ENUMLOGFONTEXDV.
///Returns:
///    If the function succeeds, the return value is the handle to the new ENUMLOGFONTEXDV structure. If the function
///    fails, the return value is zero. No extended error information is available.
///    
@DllImport("GDI32")
HFONT CreateFontIndirectExA(const(ENUMLOGFONTEXDVA)* param0);

///The <b>CreateFontIndirectEx</b> function specifies a logical font that has the characteristics in the specified
///structure. The font can subsequently be selected as the current font for any device context.
///Params:
///    Arg1 = Pointer to an ENUMLOGFONTEXDV structure that defines the characteristics of a multiple master font. Note, this
///           function ignores the <b>elfDesignVector</b> member in ENUMLOGFONTEXDV.
///Returns:
///    If the function succeeds, the return value is the handle to the new ENUMLOGFONTEXDV structure. If the function
///    fails, the return value is zero. No extended error information is available.
///    
@DllImport("GDI32")
HFONT CreateFontIndirectExW(const(ENUMLOGFONTEXDVW)* param0);

///The <b>GetViewportExtEx</b> function retrieves the x-extent and y-extent of the current viewport for the specified
///device context.
///Params:
///    hdc = A handle to the device context.
///    lpsize = A pointer to a SIZE structure that receives the x- and y-extents, in device units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetViewportExtEx(HDC hdc, SIZE* lpsize);

///The <b>GetViewportOrgEx</b> function retrieves the x-coordinates and y-coordinates of the viewport origin for the
///specified device context.
///Params:
///    hdc = A handle to the device context.
///    lppoint = A pointer to a POINT structure that receives the coordinates of the origin, in device units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetViewportOrgEx(HDC hdc, POINT* lppoint);

///This function retrieves the x-extent and y-extent of the window for the specified device context.
///Params:
///    hdc = A handle to the device context.
///    lpsize = A pointer to a SIZE structure that receives the x- and y-extents in page-space units, that is, logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetWindowExtEx(HDC hdc, SIZE* lpsize);

///The <b>GetWindowOrgEx</b> function retrieves the x-coordinates and y-coordinates of the window origin for the
///specified device context.
///Params:
///    hdc = A handle to the device context.
///    lppoint = A pointer to a POINT structure that receives the coordinates, in logical units, of the window origin.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetWindowOrgEx(HDC hdc, POINT* lppoint);

///The <b>IntersectClipRect</b> function creates a new clipping region from the intersection of the current clipping
///region and the specified rectangle.
///Params:
///    hdc = A handle to the device context.
///    left = The x-coordinate, in logical units, of the upper-left corner of the rectangle.
///    top = The y-coordinate, in logical units, of the upper-left corner of the rectangle.
///    right = The x-coordinate, in logical units, of the lower-right corner of the rectangle.
///    bottom = The y-coordinate, in logical units, of the lower-right corner of the rectangle.
///Returns:
///    The return value specifies the new clipping region's type and can be one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULLREGION</b></dt> </dl> </td>
///    <td width="60%"> Region is empty. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SIMPLEREGION</b></dt> </dl> </td>
///    <td width="60%"> Region is a single rectangle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> Region is more than one rectangle. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred. (The current clipping
///    region is unaffected.) </td> </tr> </table>
///    
@DllImport("GDI32")
int IntersectClipRect(HDC hdc, int left, int top, int right, int bottom);

///The <b>InvertRgn</b> function inverts the colors in the specified region.
///Params:
///    hdc = Handle to the device context.
///    hrgn = Handle to the region for which colors are inverted. The region's coordinates are presumed to be logical
///           coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL InvertRgn(HDC hdc, HRGN hrgn);

///The <b>LineDDA</b> function determines which pixels should be highlighted for a line defined by the specified
///starting and ending points.
///Params:
///    xStart = Specifies the x-coordinate, in logical units, of the line's starting point.
///    yStart = Specifies the y-coordinate, in logical units, of the line's starting point.
///    xEnd = Specifies the x-coordinate, in logical units, of the line's ending point.
///    yEnd = Specifies the y-coordinate, in logical units, of the line's ending point.
///    lpProc = Pointer to an application-defined callback function. For more information, see the LineDDAProc callback function.
///    data = Pointer to the application-defined data.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL LineDDA(int xStart, int yStart, int xEnd, int yEnd, LINEDDAPROC lpProc, LPARAM data);

///The <b>LineTo</b> function draws a line from the current position up to, but not including, the specified point.
///Params:
///    hdc = Handle to a device context.
///    x = Specifies the x-coordinate, in logical units, of the line's ending point.
///    y = Specifies the y-coordinate, in logical units, of the line's ending point.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL LineTo(HDC hdc, int x, int y);

///The <b>MaskBlt</b> function combines the color data for the source and destination bitmaps using the specified mask
///and raster operation.
///Params:
///    hdcDest = A handle to the destination device context.
///    xDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    width = The width, in logical units, of the destination rectangle and source bitmap.
///    height = The height, in logical units, of the destination rectangle and source bitmap.
///    hdcSrc = A handle to the device context from which the bitmap is to be copied. It must be zero if the <i>dwRop</i>
///             parameter specifies a raster operation that does not include a source.
///    xSrc = The x-coordinate, in logical units, of the upper-left corner of the source bitmap.
///    ySrc = The y-coordinate, in logical units, of the upper-left corner of the source bitmap.
///    hbmMask = A handle to the monochrome mask bitmap combined with the color bitmap in the source device context.
///    xMask = The horizontal pixel offset for the mask bitmap specified by the <i>hbmMask</i> parameter.
///    yMask = The vertical pixel offset for the mask bitmap specified by the <i>hbmMask</i> parameter.
///    rop = The foreground and background ternary raster operation codes (ROPs) that the function uses to control the
///          combination of source and destination data. The background raster operation code is stored in the high-order byte
///          of the high-order word of this value; the foreground raster operation code is stored in the low-order byte of the
///          high-order word of this value; the low-order word of this value is ignored, and should be zero. The macro
///          MAKEROP4 creates such combinations of foreground and background raster operation codes. For a discussion of
///          foreground and background in the context of this function, see the following Remarks section. For a list of
///          common raster operation codes (ROPs), see the BitBlt function. Note that the CAPTUREBLT ROP generally cannot be
///          used for printing device contexts.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL MaskBlt(HDC hdcDest, int xDest, int yDest, int width, int height, HDC hdcSrc, int xSrc, int ySrc, 
             HBITMAP hbmMask, int xMask, int yMask, uint rop);

///The <b>PlgBlt</b> function performs a bit-block transfer of the bits of color data from the specified rectangle in
///the source device context to the specified parallelogram in the destination device context. If the given bitmask
///handle identifies a valid monochrome bitmap, the function uses this bitmap to mask the bits of color data from the
///source rectangle.
///Params:
///    hdcDest = A handle to the destination device context.
///    lpPoint = A pointer to an array of three points in logical space that identify three corners of the destination
///              parallelogram. The upper-left corner of the source rectangle is mapped to the first point in this array, the
///              upper-right corner to the second point in this array, and the lower-left corner to the third point. The
///              lower-right corner of the source rectangle is mapped to the implicit fourth point in the parallelogram.
///    hdcSrc = A handle to the source device context.
///    xSrc = The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    ySrc = The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    width = The width, in logical units, of the source rectangle.
///    height = The height, in logical units, of the source rectangle.
///    hbmMask = A handle to an optional monochrome bitmap that is used to mask the colors of the source rectangle.
///    xMask = The x-coordinate, in logical units, of the upper-left corner of the monochrome bitmap.
///    yMask = The y-coordinate, in logical units, of the upper-left corner of the monochrome bitmap.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PlgBlt(HDC hdcDest, char* lpPoint, HDC hdcSrc, int xSrc, int ySrc, int width, int height, HBITMAP hbmMask, 
            int xMask, int yMask);

///The <b>OffsetClipRgn</b> function moves the clipping region of a device context by the specified offsets.
///Params:
///    hdc = A handle to the device context.
///    x = The number of logical units to move left or right.
///    y = The number of logical units to move up or down.
///Returns:
///    The return value specifies the new region's complexity and can be one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULLREGION</b></dt> </dl> </td>
///    <td width="60%"> Region is empty. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SIMPLEREGION</b></dt> </dl> </td>
///    <td width="60%"> Region is a single rectangle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> Region is more than one rectangle. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred. (The current clipping
///    region is unaffected.) </td> </tr> </table>
///    
@DllImport("GDI32")
int OffsetClipRgn(HDC hdc, int x, int y);

///The <b>OffsetRgn</b> function moves a region by the specified offsets.
///Params:
///    hrgn = Handle to the region to be moved.
///    x = Specifies the number of logical units to move left or right.
///    y = Specifies the number of logical units to move up or down.
///Returns:
///    The return value specifies the new region's complexity. It can be one of the following values. <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td>NULLREGION</td> <td>Region is empty.</td> </tr> <tr>
///    <td>SIMPLEREGION</td> <td>Region is a single rectangle.</td> </tr> <tr> <td>COMPLEXREGION</td> <td>Region is more
///    than one rectangle.</td> </tr> <tr> <td>ERROR</td> <td>An error occurred; region is unaffected.</td> </tr>
///    </table>
///    
@DllImport("GDI32")
int OffsetRgn(HRGN hrgn, int x, int y);

///The <b>PatBlt</b> function paints the specified rectangle using the brush that is currently selected into the
///specified device context. The brush color and the surface color or colors are combined by using the specified raster
///operation.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical units, of the upper-left corner of the rectangle to be filled.
///    y = The y-coordinate, in logical units, of the upper-left corner of the rectangle to be filled.
///    w = The width, in logical units, of the rectangle.
///    h = The height, in logical units, of the rectangle.
///    rop = The raster operation code. This code can be one of the following values. <table> <tr> <th>Value</th>
///          <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PATCOPY"></a><a id="patcopy"></a><dl> <dt><b>PATCOPY</b></dt>
///          </dl> </td> <td width="60%"> Copies the specified pattern into the destination bitmap. </td> </tr> <tr> <td
///          width="40%"><a id="PATINVERT"></a><a id="patinvert"></a><dl> <dt><b>PATINVERT</b></dt> </dl> </td> <td
///          width="60%"> Combines the colors of the specified pattern with the colors of the destination rectangle by using
///          the Boolean XOR operator. </td> </tr> <tr> <td width="40%"><a id="DSTINVERT"></a><a id="dstinvert"></a><dl>
///          <dt><b>DSTINVERT</b></dt> </dl> </td> <td width="60%"> Inverts the destination rectangle. </td> </tr> <tr> <td
///          width="40%"><a id="BLACKNESS"></a><a id="blackness"></a><dl> <dt><b>BLACKNESS</b></dt> </dl> </td> <td
///          width="60%"> Fills the destination rectangle using the color associated with index 0 in the physical palette.
///          (This color is black for the default physical palette.) </td> </tr> <tr> <td width="40%"><a id="WHITENESS"></a><a
///          id="whiteness"></a><dl> <dt><b>WHITENESS</b></dt> </dl> </td> <td width="60%"> Fills the destination rectangle
///          using the color associated with index 1 in the physical palette. (This color is white for the default physical
///          palette.) </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PatBlt(HDC hdc, int x, int y, int w, int h, uint rop);

///The <b>Pie</b> function draws a pie-shaped wedge bounded by the intersection of an ellipse and two radials. The pie
///is outlined by using the current pen and filled by using the current brush.
///Params:
///    hdc = A handle to the device context.
///    left = The x-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
///    top = The y-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
///    right = The x-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
///    bottom = The y-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
///    xr1 = The x-coordinate, in logical coordinates, of the endpoint of the first radial.
///    yr1 = The y-coordinate, in logical coordinates, of the endpoint of the first radial.
///    xr2 = The x-coordinate, in logical coordinates, of the endpoint of the second radial.
///    yr2 = The y-coordinate, in logical coordinates, of the endpoint of the second radial.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL Pie(HDC hdc, int left, int top, int right, int bottom, int xr1, int yr1, int xr2, int yr2);

///The <b>PlayMetaFile</b> function displays the picture stored in the given Windows-format metafile on the specified
///device. <div class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format
///metafiles. Enhanced-format metafiles provide superior functionality and are recommended for new applications. The
///corresponding function for an enhanced-format metafile is PlayEnhMetaFile.</div><div> </div>
///Params:
///    hdc = Handle to a device context.
///    hmf = Handle to a Windows-format metafile.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PlayMetaFile(HDC hdc, ptrdiff_t hmf);

///The <b>PaintRgn</b> function paints the specified region by using the brush currently selected into the device
///context.
///Params:
///    hdc = Handle to the device context.
///    hrgn = Handle to the region to be filled. The region's coordinates are presumed to be logical coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PaintRgn(HDC hdc, HRGN hrgn);

///The <b>PolyPolygon</b> function draws a series of closed polygons. Each polygon is outlined by using the current pen
///and filled by using the current brush and polygon fill mode. The polygons drawn by this function can overlap.
///Params:
///    hdc = A handle to the device context.
///    apt = A pointer to an array of POINT structures that define the vertices of the polygons, in logical coordinates. The
///          polygons are specified consecutively. Each polygon is closed automatically by drawing a line from the last vertex
///          to the first. Each vertex should be specified once.
///    asz = A pointer to an array of integers, each of which specifies the number of points in the corresponding polygon.
///          Each integer must be greater than or equal to 2.
///    csz = The total number of polygons.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolyPolygon(HDC hdc, const(POINT)* apt, char* asz, int csz);

///The <b>PtInRegion</b> function determines whether the specified point is inside the specified region.
///Params:
///    hrgn = Handle to the region to be examined.
///    x = Specifies the x-coordinate of the point in logical units.
///    y = Specifies the y-coordinate of the point in logical units.
///Returns:
///    If the specified point is in the region, the return value is nonzero. If the specified point is not in the
///    region, the return value is zero.
///    
@DllImport("GDI32")
BOOL PtInRegion(HRGN hrgn, int x, int y);

///The <b>PtVisible</b> function determines whether the specified point is within the clipping region of a device
///context.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical units, of the point.
///    y = The y-coordinate, in logical units, of the point.
///Returns:
///    If the specified point is within the clipping region of the device context, the return value is <b>TRUE</b>(1).
///    If the specified point is not within the clipping region of the device context, the return value is
///    <b>FALSE</b>(0). If the <b>HDC</b> is not valid, the return value is (BOOL)-1.
///    
@DllImport("GDI32")
BOOL PtVisible(HDC hdc, int x, int y);

///The <b>RectInRegion</b> function determines whether any part of the specified rectangle is within the boundaries of a
///region.
///Params:
///    hrgn = Handle to the region.
///    lprect = Pointer to a RECT structure containing the coordinates of the rectangle in logical units. The lower and right
///             edges of the rectangle are not included.
///Returns:
///    If any part of the specified rectangle lies within the boundaries of the region, the return value is nonzero. If
///    no part of the specified rectangle lies within the boundaries of the region, the return value is zero.
///    
@DllImport("GDI32")
BOOL RectInRegion(HRGN hrgn, const(RECT)* lprect);

///The <b>RectVisible</b> function determines whether any part of the specified rectangle lies within the clipping
///region of a device context.
///Params:
///    hdc = A handle to the device context.
///    lprect = A pointer to a RECT structure that contains the logical coordinates of the specified rectangle.
///Returns:
///    If the current transform does not have a rotation and the rectangle lies within the clipping region, the return
///    value is <b>TRUE</b> (1). If the current transform does not have a rotation and the rectangle does not lie within
///    the clipping region, the return value is <b>FALSE</b> (0). If the current transform has a rotation and the
///    rectangle lies within the clipping region, the return value is 2. If the current transform has a rotation and the
///    rectangle does not lie within the clipping region, the return value is 1. All other return values are considered
///    error codes. If the any parameter is not valid, the return value is undefined.
///    
@DllImport("GDI32")
BOOL RectVisible(HDC hdc, const(RECT)* lprect);

///The <b>Rectangle</b> function draws a rectangle. The rectangle is outlined by using the current pen and filled by
///using the current brush.
///Params:
///    hdc = A handle to the device context.
///    left = The x-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
///    top = The y-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
///    right = The x-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
///    bottom = The y-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL Rectangle(HDC hdc, int left, int top, int right, int bottom);

///The <b>RestoreDC</b> function restores a device context (DC) to the specified state. The DC is restored by popping
///state information off a stack created by earlier calls to the SaveDC function.
///Params:
///    hdc = A handle to the DC.
///    nSavedDC = The saved state to be restored. If this parameter is positive, <i>nSavedDC</i> represents a specific instance of
///               the state to be restored. If this parameter is negative, <i>nSavedDC</i> represents an instance relative to the
///               current state. For example, -1 restores the most recently saved state.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL RestoreDC(HDC hdc, int nSavedDC);

///The <b>ResetDC</b> function updates the specified printer or plotter device context (DC) using the specified
///information.
///Params:
///    hdc = A handle to the DC to update.
///    lpdm = A pointer to a DEVMODE structure containing information about the new DC.
///Returns:
///    If the function succeeds, the return value is a handle to the original DC. If the function fails, the return
///    value is <b>NULL</b>.
///    
@DllImport("GDI32")
HDC ResetDCA(HDC hdc, const(DEVMODEA)* lpdm);

///The <b>ResetDC</b> function updates the specified printer or plotter device context (DC) using the specified
///information.
///Params:
///    hdc = A handle to the DC to update.
///    lpdm = A pointer to a DEVMODE structure containing information about the new DC.
///Returns:
///    If the function succeeds, the return value is a handle to the original DC. If the function fails, the return
///    value is <b>NULL</b>.
///    
@DllImport("GDI32")
HDC ResetDCW(HDC hdc, const(DEVMODEW)* lpdm);

///The <b>RealizePalette</b> function maps palette entries from the current logical palette to the system palette.
///Params:
///    hdc = A handle to the device context into which a logical palette has been selected.
///Returns:
///    If the function succeeds, the return value is the number of entries in the logical palette mapped to the system
///    palette. If the function fails, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint RealizePalette(HDC hdc);

///The <b>RemoveFontResource</b> function removes the fonts in the specified file from the system font table. If the
///font was added using the AddFontResourceEx function, you must use the RemoveFontResourceEx function.
///Params:
///    lpFileName = A pointer to a null-terminated string that names a font resource file.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL RemoveFontResourceA(const(char)* lpFileName);

///The <b>RemoveFontResource</b> function removes the fonts in the specified file from the system font table. If the
///font was added using the AddFontResourceEx function, you must use the RemoveFontResourceEx function.
///Params:
///    lpFileName = A pointer to a null-terminated string that names a font resource file.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL RemoveFontResourceW(const(wchar)* lpFileName);

///The <b>RoundRect</b> function draws a rectangle with rounded corners. The rectangle is outlined by using the current
///pen and filled by using the current brush.
///Params:
///    hdc = A handle to the device context.
///    left = The x-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
///    top = The y-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
///    right = The x-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
///    bottom = The y-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
///    width = The width, in logical coordinates, of the ellipse used to draw the rounded corners.
///    height = The height, in logical coordinates, of the ellipse used to draw the rounded corners.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL RoundRect(HDC hdc, int left, int top, int right, int bottom, int width, int height);

///The <b>ResizePalette</b> function increases or decreases the size of a logical palette based on the specified value.
///Params:
///    hpal = A handle to the palette to be changed.
///    n = The number of entries in the palette after it has been resized. The number of entries is limited to 1024.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ResizePalette(HPALETTE hpal, uint n);

///The <b>SaveDC</b> function saves the current state of the specified device context (DC) by copying data describing
///selected objects and graphic modes (such as the bitmap, brush, palette, font, pen, region, drawing mode, and mapping
///mode) to a context stack.
///Params:
///    hdc = A handle to the DC whose state is to be saved.
///Returns:
///    If the function succeeds, the return value identifies the saved state. If the function fails, the return value is
///    zero.
///    
@DllImport("GDI32")
int SaveDC(HDC hdc);

///The <b>SelectClipRgn</b> function selects a region as the current clipping region for the specified device context.
///Params:
///    hdc = A handle to the device context.
///    hrgn = A handle to the region to be selected.
///Returns:
///    The return value specifies the region's complexity and can be one of the following values. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULLREGION</b></dt> </dl> </td>
///    <td width="60%"> Region is empty. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SIMPLEREGION</b></dt> </dl> </td>
///    <td width="60%"> Region is a single rectangle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> Region is more than one rectangle. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred. (The previous
///    clipping region is unaffected.) </td> </tr> </table>
///    
@DllImport("GDI32")
int SelectClipRgn(HDC hdc, HRGN hrgn);

///The <b>ExtSelectClipRgn</b> function combines the specified region with the current clipping region using the
///specified mode.
///Params:
///    hdc = A handle to the device context.
///    hrgn = A handle to the region to be selected. This handle must not be <b>NULL</b> unless the RGN_COPY mode is specified.
///    mode = The operation to be performed. It must be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RGN_AND"></a><a id="rgn_and"></a><dl> <dt><b>RGN_AND</b></dt>
///           </dl> </td> <td width="60%"> The new clipping region combines the overlapping areas of the current clipping
///           region and the region identified by <i>hrgn</i>. </td> </tr> <tr> <td width="40%"><a id="RGN_COPY"></a><a
///           id="rgn_copy"></a><dl> <dt><b>RGN_COPY</b></dt> </dl> </td> <td width="60%"> The new clipping region is a copy of
///           the region identified by <i>hrgn</i>. This is identical to SelectClipRgn. If the region identified by <i>hrgn</i>
///           is <b>NULL</b>, the new clipping region is the default clipping region (the default clipping region is a null
///           region). </td> </tr> <tr> <td width="40%"><a id="RGN_DIFF"></a><a id="rgn_diff"></a><dl> <dt><b>RGN_DIFF</b></dt>
///           </dl> </td> <td width="60%"> The new clipping region combines the areas of the current clipping region with those
///           areas excluded from the region identified by <i>hrgn</i>. </td> </tr> <tr> <td width="40%"><a id="RGN_OR"></a><a
///           id="rgn_or"></a><dl> <dt><b>RGN_OR</b></dt> </dl> </td> <td width="60%"> The new clipping region combines the
///           current clipping region and the region identified by <i>hrgn</i>. </td> </tr> <tr> <td width="40%"><a
///           id="RGN_XOR"></a><a id="rgn_xor"></a><dl> <dt><b>RGN_XOR</b></dt> </dl> </td> <td width="60%"> The new clipping
///           region combines the current clipping region and the region identified by <i>hrgn</i> but excludes any overlapping
///           areas. </td> </tr> </table>
///Returns:
///    The return value specifies the new clipping region's complexity; it can be one of the following values. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULLREGION</b></dt> </dl>
///    </td> <td width="60%"> Region is empty. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SIMPLEREGION</b></dt> </dl>
///    </td> <td width="60%"> Region is a single rectangle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> Region is more than one rectangle. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred. </td> </tr> </table>
///    
@DllImport("GDI32")
int ExtSelectClipRgn(HDC hdc, HRGN hrgn, int mode);

///The <b>SetMetaRgn</b> function intersects the current clipping region for the specified device context with the
///current metaregion and saves the combined region as the new metaregion for the specified device context. The clipping
///region is reset to a null region.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    The return value specifies the new clipping region's complexity and can be one of the following values. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NULLREGION</b></dt> </dl>
///    </td> <td width="60%"> Region is empty. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SIMPLEREGION</b></dt> </dl>
///    </td> <td width="60%"> Region is a single rectangle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> Region is more than one rectangle. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred. (The previous
///    clipping region is unaffected.) </td> </tr> </table>
///    
@DllImport("GDI32")
int SetMetaRgn(HDC hdc);

///The <b>SelectObject</b> function selects an object into the specified device context (DC). The new object replaces
///the previous object of the same type.
///Params:
///    hdc = A handle to the DC.
///    h = A handle to the object to be selected. The specified object must have been created by using one of the following
///        functions. <table> <tr> <th>Object</th> <th>Functions</th> </tr> <tr> <td width="40%"><a id="Bitmap"></a><a
///        id="bitmap"></a><a id="BITMAP"></a><dl> <dt><b>Bitmap</b></dt> </dl> </td> <td width="60%"> CreateBitmap,
///        CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection Bitmaps can only be selected into
///        memory DC's. A single bitmap cannot be selected into more than one DC at the same time. </td> </tr> <tr> <td
///        width="40%"><a id="Brush"></a><a id="brush"></a><a id="BRUSH"></a><dl> <dt><b>Brush</b></dt> </dl> </td> <td
///        width="60%"> CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush,
///        CreatePatternBrush, CreateSolidBrush </td> </tr> <tr> <td width="40%"><a id="Font"></a><a id="font"></a><a
///        id="FONT"></a><dl> <dt><b>Font</b></dt> </dl> </td> <td width="60%"> CreateFont, CreateFontIndirect </td> </tr>
///        <tr> <td width="40%"><a id="Pen"></a><a id="pen"></a><a id="PEN"></a><dl> <dt><b>Pen</b></dt> </dl> </td> <td
///        width="60%"> CreatePen, CreatePenIndirect </td> </tr> <tr> <td width="40%"><a id="Region"></a><a
///        id="region"></a><a id="REGION"></a><dl> <dt><b>Region</b></dt> </dl> </td> <td width="60%"> CombineRgn,
///        CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect </td> </tr>
///        </table>
///Returns:
///    If the selected object is not a region and the function succeeds, the return value is a handle to the object
///    being replaced. If the selected object is a region and the function succeeds, the return value is one of the
///    following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>SIMPLEREGION</td> <td>Region
///    consists of a single rectangle.</td> </tr> <tr> <td>COMPLEXREGION</td> <td>Region consists of more than one
///    rectangle.</td> </tr> <tr> <td>NULLREGION</td> <td>Region is empty.</td> </tr> </table> If an error occurs and
///    the selected object is not a region, the return value is <b>NULL</b>. Otherwise, it is HGDI_ERROR.
///    
@DllImport("GDI32")
ptrdiff_t SelectObject(HDC hdc, ptrdiff_t h);

///The <b>SelectPalette</b> function selects the specified logical palette into a device context.
///Params:
///    hdc = A handle to the device context.
///    hPal = A handle to the logical palette to be selected.
///    bForceBkgd = Specifies whether the logical palette is forced to be a background palette. If this value is <b>TRUE</b>, the
///                 RealizePalette function causes the logical palette to be mapped to the colors already in the physical palette in
///                 the best possible way. This is always done, even if the window for which the palette is realized belongs to a
///                 thread without active focus. If this value is <b>FALSE</b>, RealizePalette causes the logical palette to be
///                 copied into the device palette when the application is in the foreground. (If the <i>hdc</i> parameter is a
///                 memory device context, this parameter is ignored.)
///Returns:
///    If the function succeeds, the return value is a handle to the device context's previous logical palette. If the
///    function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HPALETTE SelectPalette(HDC hdc, HPALETTE hPal, BOOL bForceBkgd);

///The <b>SetBkColor</b> function sets the current background color to the specified color value, or to the nearest
///physical color if the device cannot represent the specified color value.
///Params:
///    hdc = A handle to the device context.
///    color = The new background color. To make a COLORREF value, use the RGB macro.
///Returns:
///    If the function succeeds, the return value specifies the previous background color as a COLORREF value. If the
///    function fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint SetBkColor(HDC hdc, uint color);

///<b>SetDCBrushColor</b> function sets the current device context (DC) brush color to the specified color value. If the
///device cannot represent the specified color value, the color is set to the nearest physical color.
///Params:
///    hdc = A handle to the DC.
///    color = The new brush color.
///Returns:
///    If the function succeeds, the return value specifies the previous DC brush color as a COLORREF value. If the
///    function fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint SetDCBrushColor(HDC hdc, uint color);

///<b>SetDCPenColor</b> function sets the current device context (DC) pen color to the specified color value. If the
///device cannot represent the specified color value, the color is set to the nearest physical color.
///Params:
///    hdc = A handle to the DC.
///    color = The new pen color.
///Returns:
///    If the function succeeds, the return value specifies the previous DC pen color as a COLORREF value. If the
///    function fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint SetDCPenColor(HDC hdc, uint color);

///The <b>SetBkMode</b> function sets the background mix mode of the specified device context. The background mix mode
///is used with text, hatched brushes, and pen styles that are not solid lines.
///Params:
///    hdc = A handle to the device context.
///    mode = The background mode. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OPAQUE"></a><a id="opaque"></a><dl> <dt><b>OPAQUE</b></dt>
///           </dl> </td> <td width="60%"> Background is filled with the current background color before the text, hatched
///           brush, or pen is drawn. </td> </tr> <tr> <td width="40%"><a id="TRANSPARENT"></a><a id="transparent"></a><dl>
///           <dt><b>TRANSPARENT</b></dt> </dl> </td> <td width="60%"> Background remains untouched. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value specifies the previous background mode. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
int SetBkMode(HDC hdc, int mode);

///The <b>SetBitmapBits</b> function sets the bits of color data for a bitmap to the specified values. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should use the SetDIBits function.</div><div> </div>
///Params:
///    hbm = A handle to the bitmap to be set. This must be a compatible bitmap (DDB).
///    cb = The number of bytes pointed to by the <i>lpBits</i> parameter.
///    pvBits = A pointer to an array of bytes that contain color data for the specified bitmap.
///Returns:
///    If the function succeeds, the return value is the number of bytes used in setting the bitmap bits. If the
///    function fails, the return value is zero.
///    
@DllImport("GDI32")
int SetBitmapBits(HBITMAP hbm, uint cb, char* pvBits);

///The <b>SetBoundsRect</b> function controls the accumulation of bounding rectangle information for the specified
///device context. The system can maintain a bounding rectangle for all drawing operations. An application can examine
///and set this rectangle. The drawing boundaries are useful for invalidating bitmap caches.
///Params:
///    hdc = A handle to the device context for which to accumulate bounding rectangles.
///    lprect = A pointer to a RECT structure used to set the bounding rectangle. Rectangle dimensions are in logical
///             coordinates. This parameter can be <b>NULL</b>.
///    flags = Specifies how the new rectangle will be combined with the accumulated rectangle. This parameter can be one of
///            more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DCB_ACCUMULATE"></a><a id="dcb_accumulate"></a><dl> <dt><b>DCB_ACCUMULATE</b></dt> </dl> </td> <td
///            width="60%"> Adds the rectangle specified by the <i>lprcBounds</i> parameter to the bounding rectangle (using a
///            rectangle union operation). Using both DCB_RESET and DCB_ACCUMULATE sets the bounding rectangle to the rectangle
///            specified by the <i>lprcBounds</i> parameter. </td> </tr> <tr> <td width="40%"><a id="DCB_DISABLE"></a><a
///            id="dcb_disable"></a><dl> <dt><b>DCB_DISABLE</b></dt> </dl> </td> <td width="60%"> Turns off boundary
///            accumulation. </td> </tr> <tr> <td width="40%"><a id="DCB_ENABLE"></a><a id="dcb_enable"></a><dl>
///            <dt><b>DCB_ENABLE</b></dt> </dl> </td> <td width="60%"> Turns on boundary accumulation, which is disabled by
///            default. </td> </tr> <tr> <td width="40%"><a id="DCB_RESET"></a><a id="dcb_reset"></a><dl>
///            <dt><b>DCB_RESET</b></dt> </dl> </td> <td width="60%"> Clears the bounding rectangle. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value specifies the previous state of the bounding rectangle. This state can
///    be a combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///    <td>DCB_DISABLE</td> <td>Boundary accumulation is off.</td> </tr> <tr> <td>DCB_ENABLE</td> <td>Boundary
///    accumulation is on. DCB_ENABLE and DCB_DISABLE are mutually exclusive.</td> </tr> <tr> <td>DCB_RESET</td>
///    <td>Bounding rectangle is empty.</td> </tr> <tr> <td>DCB_SET</td> <td>Bounding rectangle is not empty. DCB_SET
///    and DCB_RESET are mutually exclusive.</td> </tr> </table> If the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint SetBoundsRect(HDC hdc, const(RECT)* lprect, uint flags);

///The <b>SetDIBits</b> function sets the pixels in a compatible bitmap (DDB) using the color data found in the
///specified DIB.
///Params:
///    hdc = A handle to a device context.
///    hbm = A handle to the compatible bitmap (DDB) that is to be altered using the color data from the specified DIB.
///    start = The starting scan line for the device-independent color data in the array pointed to by the <i>lpvBits</i>
///            parameter.
///    cLines = The number of scan lines found in the array containing device-independent color data.
///    lpBits = A pointer to the DIB color data, stored as an array of bytes. The format of the bitmap values depends on the
///             <b>biBitCount</b> member of the BITMAPINFO structure pointed to by the <i>lpbmi</i> parameter.
///    lpbmi = A pointer to a BITMAPINFO structure that contains information about the DIB.
///    ColorUse = Indicates whether the <b>bmiColors</b> member of the BITMAPINFO structure was provided and, if so, whether
///               <b>bmiColors</b> contains explicit red, green, blue (RGB) values or palette indexes. The <i>fuColorUse</i>
///               parameter must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="DIB_PAL_COLORS"></a><a id="dib_pal_colors"></a><dl> <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td>
///               <td width="60%"> The color table consists of an array of 16-bit indexes into the logical palette of the device
///               context identified by the <i>hdc</i> parameter. </td> </tr> <tr> <td width="40%"><a id="DIB_RGB_COLORS"></a><a
///               id="dib_rgb_colors"></a><dl> <dt><b>DIB_RGB_COLORS</b></dt> </dl> </td> <td width="60%"> The color table is
///               provided and contains literal RGB values. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the number of scan lines copied. If the function fails, the return
///    value is zero. This can be the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    input parameters is invalid. </td> </tr> </table>
///    
@DllImport("GDI32")
int SetDIBits(HDC hdc, HBITMAP hbm, uint start, uint cLines, const(void)* lpBits, const(BITMAPINFO)* lpbmi, 
              uint ColorUse);

///The <b>SetDIBitsToDevice</b> function sets the pixels in the specified rectangle on the device that is associated
///with the destination device context using color data from a DIB, JPEG, or PNG image.
///Params:
///    hdc = A handle to the device context.
///    xDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    w = The width, in logical units, of the image.
///    h = The height, in logical units, of the image.
///    xSrc = The x-coordinate, in logical units, of the lower-left corner of the image.
///    ySrc = The y-coordinate, in logical units, of the lower-left corner of the image.
///    StartScan = The starting scan line in the image.
///    cLines = The number of DIB scan lines contained in the array pointed to by the <i>lpvBits</i> parameter.
///    lpvBits = A pointer to the color data stored as an array of bytes. For more information, see the following Remarks section.
///    lpbmi = A pointer to a BITMAPINFO structure that contains information about the DIB.
///    ColorUse = Indicates whether the <b>bmiColors</b> member of the BITMAPINFO structure contains explicit red, green, blue
///               (RGB) values or indexes into a palette. For more information, see the following Remarks section. The
///               <i>fuColorUse</i> parameter must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///               </tr> <tr> <td width="40%"><a id="DIB_PAL_COLORS"></a><a id="dib_pal_colors"></a><dl>
///               <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td> <td width="60%"> The color table consists of an array of 16-bit
///               indexes into the currently selected logical palette. </td> </tr> <tr> <td width="40%"><a
///               id="DIB_RGB_COLORS"></a><a id="dib_rgb_colors"></a><dl> <dt><b>DIB_RGB_COLORS</b></dt> </dl> </td> <td
///               width="60%"> The color table contains literal RGB values. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the number of scan lines set. If zero scan lines are set (such as
///    when <i>dwHeight</i> is 0) or the function fails, the function returns zero. If the driver cannot support the
///    JPEG or PNG file image passed to <b>SetDIBitsToDevice</b>, the function will fail and return GDI_ERROR. If
///    failure does occur, the application must fall back on its own JPEG or PNG support to decompress the image into a
///    bitmap, and then pass the bitmap to <b>SetDIBitsToDevice</b>.
///    
@DllImport("GDI32")
int SetDIBitsToDevice(HDC hdc, int xDest, int yDest, uint w, uint h, int xSrc, int ySrc, uint StartScan, 
                      uint cLines, const(void)* lpvBits, const(BITMAPINFO)* lpbmi, uint ColorUse);

///The <b>SetMapperFlags</b> function alters the algorithm the font mapper uses when it maps logical fonts to physical
///fonts.
///Params:
///    hdc = A handle to the device context that contains the font-mapper flag.
///    flags = Specifies whether the font mapper should attempt to match a font's aspect ratio to the current device's aspect
///            ratio. If bit zero is set, the mapper selects only matching fonts.
///Returns:
///    If the function succeeds, the return value is the previous value of the font-mapper flag. If the function fails,
///    the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint SetMapperFlags(HDC hdc, uint flags);

///The <b>SetGraphicsMode</b> function sets the graphics mode for the specified device context.
///Params:
///    hdc = A handle to the device context.
///    iMode = The graphics mode. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GM_COMPATIBLE"></a><a id="gm_compatible"></a><dl>
///            <dt><b>GM_COMPATIBLE</b></dt> </dl> </td> <td width="60%"> Sets the graphics mode that is compatible with 16-bit
///            Windows. This is the default mode. If this value is specified, the application can only modify the
///            world-to-device transform by calling functions that set window and viewport extents and origins, but not by using
///            SetWorldTransform or ModifyWorldTransform; calls to those functions will fail. Examples of functions that set
///            window and viewport extents and origins are SetViewportExtEx and SetWindowExtEx. </td> </tr> <tr> <td
///            width="40%"><a id="GM_ADVANCED"></a><a id="gm_advanced"></a><dl> <dt><b>GM_ADVANCED</b></dt> </dl> </td> <td
///            width="60%"> Sets the advanced graphics mode that allows world transformations. This value must be specified if
///            the application will set or modify the world transformation for the specified device context. In this mode all
///            graphics, including text output, fully conform to the world-to-device transformation specified in the device
///            context. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the old graphics mode. If the function fails, the return value is
///    zero.
///    
@DllImport("GDI32")
int SetGraphicsMode(HDC hdc, int iMode);

///The <b>SetMapMode</b> function sets the mapping mode of the specified device context. The mapping mode defines the
///unit of measure used to transform page-space units into device-space units, and also defines the orientation of the
///device's x and y axes.
///Params:
///    hdc = A handle to the device context.
///    iMode = The new mapping mode. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MM_ANISOTROPIC"></a><a id="mm_anisotropic"></a><dl>
///            <dt><b>MM_ANISOTROPIC</b></dt> </dl> </td> <td width="60%"> Logical units are mapped to arbitrary units with
///            arbitrarily scaled axes. Use the SetWindowExtEx and SetViewportExtEx functions to specify the units, orientation,
///            and scaling. </td> </tr> <tr> <td width="40%"><a id="MM_HIENGLISH"></a><a id="mm_hienglish"></a><dl>
///            <dt><b>MM_HIENGLISH</b></dt> </dl> </td> <td width="60%"> Each logical unit is mapped to 0.001 inch. Positive x
///            is to the right; positive y is up. </td> </tr> <tr> <td width="40%"><a id="MM_HIMETRIC"></a><a
///            id="mm_himetric"></a><dl> <dt><b>MM_HIMETRIC</b></dt> </dl> </td> <td width="60%"> Each logical unit is mapped to
///            0.01 millimeter. Positive x is to the right; positive y is up. </td> </tr> <tr> <td width="40%"><a
///            id="MM_ISOTROPIC"></a><a id="mm_isotropic"></a><dl> <dt><b>MM_ISOTROPIC</b></dt> </dl> </td> <td width="60%">
///            Logical units are mapped to arbitrary units with equally scaled axes; that is, one unit along the x-axis is equal
///            to one unit along the y-axis. Use the SetWindowExtEx and SetViewportExtEx functions to specify the units and the
///            orientation of the axes. Graphics device interface (GDI) makes adjustments as necessary to ensure the x and y
///            units remain the same size (When the window extent is set, the viewport will be adjusted to keep the units
///            isotropic). </td> </tr> <tr> <td width="40%"><a id="MM_LOENGLISH"></a><a id="mm_loenglish"></a><dl>
///            <dt><b>MM_LOENGLISH</b></dt> </dl> </td> <td width="60%"> Each logical unit is mapped to 0.01 inch. Positive x is
///            to the right; positive y is up. </td> </tr> <tr> <td width="40%"><a id="MM_LOMETRIC"></a><a
///            id="mm_lometric"></a><dl> <dt><b>MM_LOMETRIC</b></dt> </dl> </td> <td width="60%"> Each logical unit is mapped to
///            0.1 millimeter. Positive x is to the right; positive y is up. </td> </tr> <tr> <td width="40%"><a
///            id="MM_TEXT"></a><a id="mm_text"></a><dl> <dt><b>MM_TEXT</b></dt> </dl> </td> <td width="60%"> Each logical unit
///            is mapped to one device pixel. Positive x is to the right; positive y is down. </td> </tr> <tr> <td
///            width="40%"><a id="MM_TWIPS"></a><a id="mm_twips"></a><dl> <dt><b>MM_TWIPS</b></dt> </dl> </td> <td width="60%">
///            Each logical unit is mapped to one twentieth of a printer's point (1/1440 inch, also called a twip). Positive x
///            is to the right; positive y is up. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value identifies the previous mapping mode. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
int SetMapMode(HDC hdc, int iMode);

///The <b>SetLayout</b> function changes the layout of a device context (DC).
///Params:
///    hdc = A handle to the DC.
///    l = The DC layout. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///        <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LAYOUT_BITMAPORIENTATIONPRESERVED"></a><a
///        id="layout_bitmaporientationpreserved"></a><dl> <dt><b>LAYOUT_BITMAPORIENTATIONPRESERVED</b></dt> </dl> </td> <td
///        width="60%"> Disables any reflection during BitBlt and StretchBlt operations. </td> </tr> <tr> <td width="40%"><a
///        id="LAYOUT_RTL"></a><a id="layout_rtl"></a><dl> <dt><b>LAYOUT_RTL</b></dt> </dl> </td> <td width="60%"> Sets the
///        default horizontal layout to be right to left. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns the previous layout of the DC. If the function fails, it returns GDI_ERROR.
///    
@DllImport("GDI32")
uint SetLayout(HDC hdc, uint l);

///The <b>GetLayout</b> function returns the layout of a device context (DC).
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, it returns the layout flags for the current device context. If the function fails, it
///    returns GDI_ERROR. For extended error information, call GetLastError.
///    
@DllImport("GDI32")
uint GetLayout(HDC hdc);

///The <b>SetMetaFileBitsEx</b> function creates a memory-based Windows-format metafile from the supplied data. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is SetEnhMetaFileBits.</div><div> </div>
///Params:
///    cbBuffer = Specifies the size, in bytes, of the Windows-format metafile.
///    lpData = Pointer to a buffer that contains the Windows-format metafile. (It is assumed that the data was obtained by using
///             the GetMetaFileBitsEx function.)
///Returns:
///    If the function succeeds, the return value is a handle to a memory-based Windows-format metafile. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t SetMetaFileBitsEx(uint cbBuffer, char* lpData);

///The <b>SetPaletteEntries</b> function sets RGB (red, green, blue) color values and flags in a range of entries in a
///logical palette.
///Params:
///    hpal = A handle to the logical palette.
///    iStart = The first logical-palette entry to be set.
///    cEntries = The number of logical-palette entries to be set.
///    pPalEntries = A pointer to the first member of an array of PALETTEENTRY structures containing the RGB values and flags.
///Returns:
///    If the function succeeds, the return value is the number of entries that were set in the logical palette. If the
///    function fails, the return value is zero.
///    
@DllImport("GDI32")
uint SetPaletteEntries(HPALETTE hpal, uint iStart, uint cEntries, char* pPalEntries);

///The <b>SetPixel</b> function sets the pixel at the specified coordinates to the specified color.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical units, of the point to be set.
///    y = The y-coordinate, in logical units, of the point to be set.
///    color = The color to be used to paint the point. To create a COLORREF color value, use the RGB macro.
///Returns:
///    If the function succeeds, the return value is the RGB value that the function sets the pixel to. This value may
///    differ from the color specified by <i>crColor</i>; that occurs when an exact match for the specified color cannot
///    be found. If the function fails, the return value is -1. This can be the following value. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One or more of the input parameters is invalid. </td> </tr> </table>
///    
@DllImport("GDI32")
uint SetPixel(HDC hdc, int x, int y, uint color);

///The <b>SetPixelV</b> function sets the pixel at the specified coordinates to the closest approximation of the
///specified color. The point must be in the clipping region and the visible part of the device surface.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical units, of the point to be set.
///    y = The y-coordinate, in logical units, of the point to be set.
///    color = The color to be used to paint the point. To create a COLORREF color value, use the RGB macro.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetPixelV(HDC hdc, int x, int y, uint color);

///The <b>SetPolyFillMode</b> function sets the polygon fill mode for functions that fill polygons.
///Params:
///    hdc = A handle to the device context.
///    mode = The new fill mode. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ALTERNATE"></a><a id="alternate"></a><dl>
///           <dt><b>ALTERNATE</b></dt> </dl> </td> <td width="60%"> Selects alternate mode (fills the area between
///           odd-numbered and even-numbered polygon sides on each scan line). </td> </tr> <tr> <td width="40%"><a
///           id="WINDING"></a><a id="winding"></a><dl> <dt><b>WINDING</b></dt> </dl> </td> <td width="60%"> Selects winding
///           mode (fills any region with a nonzero winding value). </td> </tr> </table>
///Returns:
///    The return value specifies the previous filling mode. If an error occurs, the return value is zero.
///    
@DllImport("GDI32")
int SetPolyFillMode(HDC hdc, int mode);

///The <b>StretchBlt</b> function copies a bitmap from a source rectangle into a destination rectangle, stretching or
///compressing the bitmap to fit the dimensions of the destination rectangle, if necessary. The system stretches or
///compresses the bitmap according to the stretching mode currently set in the destination device context.
///Params:
///    hdcDest = A handle to the destination device context.
///    xDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    wDest = The width, in logical units, of the destination rectangle.
///    hDest = The height, in logical units, of the destination rectangle.
///    hdcSrc = A handle to the source device context.
///    xSrc = The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    ySrc = The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    wSrc = The width, in logical units, of the source rectangle.
///    hSrc = The height, in logical units, of the source rectangle.
///    rop = The raster operation to be performed. Raster operation codes define how the system combines colors in output
///          operations that involve a brush, a source bitmap, and a destination bitmap. See BitBlt for a list of common
///          raster operation codes (ROPs). Note that the CAPTUREBLT ROP generally cannot be used for printing device
///          contexts.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL StretchBlt(HDC hdcDest, int xDest, int yDest, int wDest, int hDest, HDC hdcSrc, int xSrc, int ySrc, int wSrc, 
                int hSrc, uint rop);

///The <b>SetRectRgn</b> function converts a region into a rectangular region with the specified coordinates.
///Params:
///    hrgn = Handle to the region.
///    left = Specifies the x-coordinate of the upper-left corner of the rectangular region in logical units.
///    top = Specifies the y-coordinate of the upper-left corner of the rectangular region in logical units.
///    right = Specifies the x-coordinate of the lower-right corner of the rectangular region in logical units.
///    bottom = Specifies the y-coordinate of the lower-right corner of the rectangular region in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetRectRgn(HRGN hrgn, int left, int top, int right, int bottom);

///The <b>StretchDIBits</b> function copies the color data for a rectangle of pixels in a DIB, JPEG, or PNG image to the
///specified destination rectangle. If the destination rectangle is larger than the source rectangle, this function
///stretches the rows and columns of color data to fit the destination rectangle. If the destination rectangle is
///smaller than the source rectangle, this function compresses the rows and columns by using the specified raster
///operation.
///Params:
///    hdc = A handle to the destination device context.
///    xDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    DestWidth = The width, in logical units, of the destination rectangle.
///    DestHeight = The height, in logical units, of the destination rectangle.
///    xSrc = The x-coordinate, in pixels, of the source rectangle in the image.
///    ySrc = The y-coordinate, in pixels, of the source rectangle in the image.
///    SrcWidth = The width, in pixels, of the source rectangle in the image.
///    SrcHeight = The height, in pixels, of the source rectangle in the image.
///    lpBits = A pointer to the image bits, which are stored as an array of bytes. For more information, see the Remarks
///             section.
///    lpbmi = A pointer to a BITMAPINFO structure that contains information about the DIB.
///    iUsage = Specifies whether the <b>bmiColors</b> member of the BITMAPINFO structure was provided and, if so, whether
///             <b>bmiColors</b> contains explicit red, green, blue (RGB) values or indexes. The <i>iUsage</i> parameter must be
///             one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="DIB_PAL_COLORS"></a><a id="dib_pal_colors"></a><dl> <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td> <td
///             width="60%"> The array contains 16-bit indexes into the logical palette of the source device context. </td> </tr>
///             <tr> <td width="40%"><a id="DIB_RGB_COLORS"></a><a id="dib_rgb_colors"></a><dl> <dt><b>DIB_RGB_COLORS</b></dt>
///             </dl> </td> <td width="60%"> The color table contains literal RGB values. </td> </tr> </table> For more
///             information, see the Remarks section.
///    rop = A raster-operation code that specifies how the source pixels, the destination device context's current brush, and
///          the destination pixels are to be combined to form the new image. For a list of some common raster operation
///          codes, see BitBlt.
///Returns:
///    If the function succeeds, the return value is the number of scan lines copied. Note that this value can be
///    negative for mirrored content. If the function fails, or no scan lines are copied, the return value is 0. If the
///    driver cannot support the JPEG or PNG file image passed to <b>StretchDIBits</b>, the function will fail and
///    return GDI_ERROR. If failure does occur, the application must fall back on its own JPEG or PNG support to
///    decompress the image into a bitmap, and then pass the bitmap to <b>StretchDIBits</b>.
///    
@DllImport("GDI32")
int StretchDIBits(HDC hdc, int xDest, int yDest, int DestWidth, int DestHeight, int xSrc, int ySrc, int SrcWidth, 
                  int SrcHeight, const(void)* lpBits, const(BITMAPINFO)* lpbmi, uint iUsage, uint rop);

///The <b>SetROP2</b> function sets the current foreground mix mode. GDI uses the foreground mix mode to combine pens
///and interiors of filled objects with the colors already on the screen. The foreground mix mode defines how colors
///from the brush or pen and the colors in the existing image are to be combined.
///Params:
///    hdc = A handle to the device context.
///    rop2 = The mix mode. This parameter can be one of the following values. <table> <tr> <th>Mix mode</th> <th>Meaning</th>
///           </tr> <tr> <td width="40%"><a id="R2_BLACK"></a><a id="r2_black"></a><dl> <dt><b>R2_BLACK</b></dt> </dl> </td>
///           <td width="60%"> Pixel is always 0. </td> </tr> <tr> <td width="40%"><a id="R2_COPYPEN"></a><a
///           id="r2_copypen"></a><dl> <dt><b>R2_COPYPEN</b></dt> </dl> </td> <td width="60%"> Pixel is the pen color. </td>
///           </tr> <tr> <td width="40%"><a id="R2_MASKNOTPEN"></a><a id="r2_masknotpen"></a><dl> <dt><b>R2_MASKNOTPEN</b></dt>
///           </dl> </td> <td width="60%"> Pixel is a combination of the colors common to both the screen and the inverse of
///           the pen. </td> </tr> <tr> <td width="40%"><a id="R2_MASKPEN"></a><a id="r2_maskpen"></a><dl>
///           <dt><b>R2_MASKPEN</b></dt> </dl> </td> <td width="60%"> Pixel is a combination of the colors common to both the
///           pen and the screen. </td> </tr> <tr> <td width="40%"><a id="R2_MASKPENNOT"></a><a id="r2_maskpennot"></a><dl>
///           <dt><b>R2_MASKPENNOT</b></dt> </dl> </td> <td width="60%"> Pixel is a combination of the colors common to both
///           the pen and the inverse of the screen. </td> </tr> <tr> <td width="40%"><a id="R2_MERGENOTPEN"></a><a
///           id="r2_mergenotpen"></a><dl> <dt><b>R2_MERGENOTPEN</b></dt> </dl> </td> <td width="60%"> Pixel is a combination
///           of the screen color and the inverse of the pen color. </td> </tr> <tr> <td width="40%"><a id="R2_MERGEPEN"></a><a
///           id="r2_mergepen"></a><dl> <dt><b>R2_MERGEPEN</b></dt> </dl> </td> <td width="60%"> Pixel is a combination of the
///           pen color and the screen color. </td> </tr> <tr> <td width="40%"><a id="R2_MERGEPENNOT"></a><a
///           id="r2_mergepennot"></a><dl> <dt><b>R2_MERGEPENNOT</b></dt> </dl> </td> <td width="60%"> Pixel is a combination
///           of the pen color and the inverse of the screen color. </td> </tr> <tr> <td width="40%"><a id="R2_NOP"></a><a
///           id="r2_nop"></a><dl> <dt><b>R2_NOP</b></dt> </dl> </td> <td width="60%"> Pixel remains unchanged. </td> </tr>
///           <tr> <td width="40%"><a id="R2_NOT"></a><a id="r2_not"></a><dl> <dt><b>R2_NOT</b></dt> </dl> </td> <td
///           width="60%"> Pixel is the inverse of the screen color. </td> </tr> <tr> <td width="40%"><a
///           id="R2_NOTCOPYPEN"></a><a id="r2_notcopypen"></a><dl> <dt><b>R2_NOTCOPYPEN</b></dt> </dl> </td> <td width="60%">
///           Pixel is the inverse of the pen color. </td> </tr> <tr> <td width="40%"><a id="R2_NOTMASKPEN"></a><a
///           id="r2_notmaskpen"></a><dl> <dt><b>R2_NOTMASKPEN</b></dt> </dl> </td> <td width="60%"> Pixel is the inverse of
///           the R2_MASKPEN color. </td> </tr> <tr> <td width="40%"><a id="R2_NOTMERGEPEN"></a><a id="r2_notmergepen"></a><dl>
///           <dt><b>R2_NOTMERGEPEN</b></dt> </dl> </td> <td width="60%"> Pixel is the inverse of the R2_MERGEPEN color. </td>
///           </tr> <tr> <td width="40%"><a id="R2_NOTXORPEN"></a><a id="r2_notxorpen"></a><dl> <dt><b>R2_NOTXORPEN</b></dt>
///           </dl> </td> <td width="60%"> Pixel is the inverse of the R2_XORPEN color. </td> </tr> <tr> <td width="40%"><a
///           id="R2_WHITE"></a><a id="r2_white"></a><dl> <dt><b>R2_WHITE</b></dt> </dl> </td> <td width="60%"> Pixel is always
///           1. </td> </tr> <tr> <td width="40%"><a id="R2_XORPEN"></a><a id="r2_xorpen"></a><dl> <dt><b>R2_XORPEN</b></dt>
///           </dl> </td> <td width="60%"> Pixel is a combination of the colors in the pen and in the screen, but not in both.
///           </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value specifies the previous mix mode. If the function fails, the return
///    value is zero.
///    
@DllImport("GDI32")
int SetROP2(HDC hdc, int rop2);

///The <b>SetStretchBltMode</b> function sets the bitmap stretching mode in the specified device context.
///Params:
///    hdc = A handle to the device context.
///    mode = The stretching mode. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BLACKONWHITE"></a><a id="blackonwhite"></a><dl>
///           <dt><b>BLACKONWHITE</b></dt> </dl> </td> <td width="60%"> Performs a Boolean AND operation using the color values
///           for the eliminated and existing pixels. If the bitmap is a monochrome bitmap, this mode preserves black pixels at
///           the expense of white pixels. </td> </tr> <tr> <td width="40%"><a id="COLORONCOLOR"></a><a
///           id="coloroncolor"></a><dl> <dt><b>COLORONCOLOR</b></dt> </dl> </td> <td width="60%"> Deletes the pixels. This
///           mode deletes all eliminated lines of pixels without trying to preserve their information. </td> </tr> <tr> <td
///           width="40%"><a id="HALFTONE"></a><a id="halftone"></a><dl> <dt><b>HALFTONE</b></dt> </dl> </td> <td width="60%">
///           Maps pixels from the source rectangle into blocks of pixels in the destination rectangle. The average color over
///           the destination block of pixels approximates the color of the source pixels. After setting the HALFTONE
///           stretching mode, an application must call the SetBrushOrgEx function to set the brush origin. If it fails to do
///           so, brush misalignment occurs. </td> </tr> <tr> <td width="40%"><a id="STRETCH_ANDSCANS"></a><a
///           id="stretch_andscans"></a><dl> <dt><b>STRETCH_ANDSCANS</b></dt> </dl> </td> <td width="60%"> Same as
///           BLACKONWHITE. </td> </tr> <tr> <td width="40%"><a id="STRETCH_DELETESCANS"></a><a
///           id="stretch_deletescans"></a><dl> <dt><b>STRETCH_DELETESCANS</b></dt> </dl> </td> <td width="60%"> Same as
///           COLORONCOLOR. </td> </tr> <tr> <td width="40%"><a id="STRETCH_HALFTONE"></a><a id="stretch_halftone"></a><dl>
///           <dt><b>STRETCH_HALFTONE</b></dt> </dl> </td> <td width="60%"> Same as HALFTONE. </td> </tr> <tr> <td
///           width="40%"><a id="STRETCH_ORSCANS"></a><a id="stretch_orscans"></a><dl> <dt><b>STRETCH_ORSCANS</b></dt> </dl>
///           </td> <td width="60%"> Same as WHITEONBLACK. </td> </tr> <tr> <td width="40%"><a id="WHITEONBLACK"></a><a
///           id="whiteonblack"></a><dl> <dt><b>WHITEONBLACK</b></dt> </dl> </td> <td width="60%"> Performs a Boolean OR
///           operation using the color values for the eliminated and existing pixels. If the bitmap is a monochrome bitmap,
///           this mode preserves white pixels at the expense of black pixels. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the previous stretching mode. If the function fails, the return
///    value is zero. This function can return the following value. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters is invalid. </td> </tr> </table>
///    
@DllImport("GDI32")
int SetStretchBltMode(HDC hdc, int mode);

///The <b>SetSystemPaletteUse</b> function allows an application to specify whether the system palette contains 2 or 20
///static colors. The default system palette contains 20 static colors. (Static colors cannot be changed when an
///application realizes a logical palette.)
///Params:
///    hdc = A handle to the device context. This device context must refer to a device that supports color palettes.
///    use = The new use of the system palette. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///          <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SYSPAL_NOSTATIC"></a><a id="syspal_nostatic"></a><dl>
///          <dt><b>SYSPAL_NOSTATIC</b></dt> </dl> </td> <td width="60%"> The system palette contains two static colors (black
///          and white). </td> </tr> <tr> <td width="40%"><a id="SYSPAL_NOSTATIC256"></a><a id="syspal_nostatic256"></a><dl>
///          <dt><b>SYSPAL_NOSTATIC256</b></dt> </dl> </td> <td width="60%"> The system palette contains no static colors.
///          </td> </tr> <tr> <td width="40%"><a id="SYSPAL_STATIC"></a><a id="syspal_static"></a><dl>
///          <dt><b>SYSPAL_STATIC</b></dt> </dl> </td> <td width="60%"> The system palette contains static colors that will
///          not change when an application realizes its logical palette. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the previous system palette. It can be either SYSPAL_NOSTATIC,
///    SYSPAL_NOSTATIC256, or SYSPAL_STATIC. If the function fails, the return value is SYSPAL_ERROR.
///    
@DllImport("GDI32")
uint SetSystemPaletteUse(HDC hdc, uint use);

///The <b>SetTextCharacterExtra</b> function sets the intercharacter spacing. Intercharacter spacing is added to each
///character, including break characters, when the system writes a line of text.
///Params:
///    hdc = A handle to the device context.
///    extra = The amount of extra space, in logical units, to be added to each character. If the current mapping mode is not
///            MM_TEXT, the <i>nCharExtra</i> parameter is transformed and rounded to the nearest pixel.
///Returns:
///    If the function succeeds, the return value is the previous intercharacter spacing. If the function fails, the
///    return value is 0x80000000.
///    
@DllImport("GDI32")
int SetTextCharacterExtra(HDC hdc, int extra);

///The <b>SetTextColor</b> function sets the text color for the specified device context to the specified color.
///Params:
///    hdc = A handle to the device context.
///    color = The color of the text.
///Returns:
///    If the function succeeds, the return value is a color reference for the previous text color as a COLORREF value.
///    If the function fails, the return value is CLR_INVALID.
///    
@DllImport("GDI32")
uint SetTextColor(HDC hdc, uint color);

///The <b>SetTextAlign</b> function sets the text-alignment flags for the specified device context.
///Params:
///    hdc = A handle to the device context.
///    align = The text alignment by using a mask of the values in the following list. Only one flag can be chosen from those
///            that affect horizontal and vertical alignment. In addition, only one of the two flags that alter the current
///            position can be chosen. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="TA_BASELINE"></a><a id="ta_baseline"></a><dl> <dt><b>TA_BASELINE</b></dt> </dl> </td> <td width="60%"> The
///            reference point will be on the base line of the text. </td> </tr> <tr> <td width="40%"><a id="TA_BOTTOM"></a><a
///            id="ta_bottom"></a><dl> <dt><b>TA_BOTTOM</b></dt> </dl> </td> <td width="60%"> The reference point will be on the
///            bottom edge of the bounding rectangle. </td> </tr> <tr> <td width="40%"><a id="TA_TOP"></a><a
///            id="ta_top"></a><dl> <dt><b>TA_TOP</b></dt> </dl> </td> <td width="60%"> The reference point will be on the top
///            edge of the bounding rectangle. </td> </tr> <tr> <td width="40%"><a id="TA_CENTER"></a><a id="ta_center"></a><dl>
///            <dt><b>TA_CENTER</b></dt> </dl> </td> <td width="60%"> The reference point will be aligned horizontally with the
///            center of the bounding rectangle. </td> </tr> <tr> <td width="40%"><a id="TA_LEFT"></a><a id="ta_left"></a><dl>
///            <dt><b>TA_LEFT</b></dt> </dl> </td> <td width="60%"> The reference point will be on the left edge of the bounding
///            rectangle. </td> </tr> <tr> <td width="40%"><a id="TA_RIGHT"></a><a id="ta_right"></a><dl>
///            <dt><b>TA_RIGHT</b></dt> </dl> </td> <td width="60%"> The reference point will be on the right edge of the
///            bounding rectangle. </td> </tr> <tr> <td width="40%"><a id="TA_NOUPDATECP"></a><a id="ta_noupdatecp"></a><dl>
///            <dt><b>TA_NOUPDATECP</b></dt> </dl> </td> <td width="60%"> The current position is not updated after each text
///            output call. The reference point is passed to the text output function. </td> </tr> <tr> <td width="40%"><a
///            id="TA_RTLREADING"></a><a id="ta_rtlreading"></a><dl> <dt><b>TA_RTLREADING</b></dt> </dl> </td> <td width="60%">
///            <b>Middle East language edition of Windows:</b> The text is laid out in right to left reading order, as opposed
///            to the default left to right order. This applies only when the font selected into the device context is either
///            Hebrew or Arabic. </td> </tr> <tr> <td width="40%"><a id="TA_UPDATECP"></a><a id="ta_updatecp"></a><dl>
///            <dt><b>TA_UPDATECP</b></dt> </dl> </td> <td width="60%"> The current position is updated after each text output
///            call. The current position is used as the reference point. </td> </tr> </table> When the current font has a
///            vertical default base line, as with Kanji, the following values must be used instead of TA_BASELINE and
///            TA_CENTER. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VTA_BASELINE"></a><a
///            id="vta_baseline"></a><dl> <dt><b>VTA_BASELINE</b></dt> </dl> </td> <td width="60%"> The reference point will be
///            on the base line of the text. </td> </tr> <tr> <td width="40%"><a id="VTA_CENTER"></a><a id="vta_center"></a><dl>
///            <dt><b>VTA_CENTER</b></dt> </dl> </td> <td width="60%"> The reference point will be aligned vertically with the
///            center of the bounding rectangle. </td> </tr> </table> The default values are TA_LEFT, TA_TOP, and TA_NOUPDATECP.
///Returns:
///    If the function succeeds, the return value is the previous text-alignment setting. If the function fails, the
///    return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint SetTextAlign(HDC hdc, uint align_);

///The <b>SetTextJustification</b> function specifies the amount of space the system should add to the break characters
///in a string of text. The space is added when an application calls the TextOut or ExtTextOut functions.
///Params:
///    hdc = A handle to the device context.
///    extra = The total extra space, in logical units, to be added to the line of text. If the current mapping mode is not
///            MM_TEXT, the value identified by the <i>nBreakExtra</i> parameter is transformed and rounded to the nearest
///            pixel.
///    count = The number of break characters in the line.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetTextJustification(HDC hdc, int extra, int count);

///The <b>UpdateColors</b> function updates the client area of the specified device context by remapping the current
///colors in the client area to the currently realized logical palette.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL UpdateColors(HDC hdc);

///The <b>AlphaBlend</b> function displays bitmaps that have transparent or semitransparent pixels.
///Params:
///    hdcDest = A handle to the destination device context.
///    xoriginDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yoriginDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    wDest = The width, in logical units, of the destination rectangle.
///    hDest = The height, in logical units, of the destination rectangle.
///    hdcSrc = A handle to the source device context.
///    xoriginSrc = The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    yoriginSrc = The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    wSrc = The width, in logical units, of the source rectangle.
///    hSrc = The height, in logical units, of the source rectangle.
///    ftn = The alpha-blending function for source and destination bitmaps, a global alpha value to be applied to the entire
///          source bitmap, and format information for the source bitmap. The source and destination blend functions are
///          currently limited to AC_SRC_OVER. See the BLENDFUNCTION and EMRALPHABLEND structures.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("MSIMG32")
BOOL AlphaBlend(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, 
                int yoriginSrc, int wSrc, int hSrc, BLENDFUNCTION ftn);

///The <b>TransparentBlt</b> function performs a bit-block transfer of the color data corresponding to a rectangle of
///pixels from the specified source device context into a destination device context.
///Params:
///    hdcDest = A handle to the destination device context.
///    xoriginDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yoriginDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    wDest = The width, in logical units, of the destination rectangle.
///    hDest = The height, in logical units, of the destination rectangle.
///    hdcSrc = A handle to the source device context.
///    xoriginSrc = The x-coordinate, in logical units, of the source rectangle.
///    yoriginSrc = The y-coordinate, in logical units, of the source rectangle.
///    wSrc = The width, in logical units, of the source rectangle.
///    hSrc = The height, in logical units, of the source rectangle.
///    crTransparent = The RGB color in the source bitmap to treat as transparent.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("MSIMG32")
BOOL TransparentBlt(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, 
                    int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, uint crTransparent);

///The <b>GradientFill</b> function fills rectangle and triangle structures.
///Params:
///    hdc = A handle to the destination device context.
///    pVertex = A pointer to an array of TRIVERTEX structures that each define a vertex.
///    nVertex = The number of vertices in <i>pVertex</i>.
///    pMesh = An array of GRADIENT_TRIANGLE structures in triangle mode, or an array of GRADIENT_RECT structures in rectangle
///            mode.
///    nMesh = The number of elements (triangles or rectangles) in <i>pMesh</i>.
///    ulMode = The gradient fill mode. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_RECT_H"></a><a
///             id="gradient_fill_rect_h"></a><dl> <dt><b>GRADIENT_FILL_RECT_H</b></dt> </dl> </td> <td width="60%"> In this
///             mode, two endpoints describe a rectangle. The rectangle is defined to have a constant color (specified by the
///             TRIVERTEX structure) for the left and right edges. GDI interpolates the color from the left to right edge and
///             fills the interior. </td> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_RECT_V"></a><a
///             id="gradient_fill_rect_v"></a><dl> <dt><b>GRADIENT_FILL_RECT_V</b></dt> </dl> </td> <td width="60%"> In this
///             mode, two endpoints describe a rectangle. The rectangle is defined to have a constant color (specified by the
///             TRIVERTEX structure) for the top and bottom edges. GDI interpolates the color from the top to bottom edge and
///             fills the interior. </td> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_TRIANGLE"></a><a
///             id="gradient_fill_triangle"></a><dl> <dt><b>GRADIENT_FILL_TRIANGLE</b></dt> </dl> </td> <td width="60%"> In this
///             mode, an array of TRIVERTEX structures is passed to GDI along with a list of array indexes that describe separate
///             triangles. GDI performs linear interpolation between triangle vertices and fills the interior. Drawing is done
///             directly in 24- and 32-bpp modes. Dithering is performed in 16-, 8-, 4-, and 1-bpp mode. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("MSIMG32")
BOOL GradientFill(HDC hdc, char* pVertex, uint nVertex, void* pMesh, uint nMesh, uint ulMode);

///The <b>GdiAlphaBlend</b> function displays bitmaps that have transparent or semitransparent pixels.
///Params:
///    hdcDest = A handle to the destination device context.
///    xoriginDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yoriginDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    wDest = The width, in logical units, of the destination rectangle.
///    hDest = The height, in logical units, of the destination rectangle.
///    hdcSrc = A handle to the source device context.
///    xoriginSrc = The x-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    yoriginSrc = The y-coordinate, in logical units, of the upper-left corner of the source rectangle.
///    wSrc = The width, in logical units, of the source rectangle.
///    hSrc = The height, in logical units, of the source rectangle.
///    ftn = The alpha-blending function for source and destination bitmaps, a global alpha value to be applied to the entire
///          source bitmap, and format information for the source bitmap. The source and destination blend functions are
///          currently limited to AC_SRC_OVER. See the BLENDFUNCTION and EMRALPHABLEND structures.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. This function can return the following value. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the input parameters is invalid. </td> </tr> </table>
///    
@DllImport("GDI32")
BOOL GdiAlphaBlend(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, 
                   int yoriginSrc, int wSrc, int hSrc, BLENDFUNCTION ftn);

///The <b>GdiTransparentBlt</b> function performs a bit-block transfer of the color data corresponding to a rectangle of
///pixels from the specified source device context into a destination device context. <div class="alert"><b>Note</b>
///This function is the same as TransparentBlt.</div><div> </div>
///Params:
///    hdcDest = A handle to the destination device context.
///    xoriginDest = The x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    yoriginDest = The y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
///    wDest = The width, in logical units, of the destination rectangle.
///    hDest = The height, in logical units, of the destination rectangle.
///    hdcSrc = A handle to the source device context.
///    xoriginSrc = The x-coordinate, in logical units, of the source rectangle.
///    yoriginSrc = The y-coordinate, in logical units, of the source rectangle.
///    wSrc = The width, in logical units, of the source rectangle.
///    hSrc = The height, in logical units, of the source rectangle.
///    crTransparent = The RGB color in the source bitmap to treat as transparent.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL GdiTransparentBlt(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, 
                       int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, uint crTransparent);

///The <b>GdiGradientFill</b> function fills rectangle and triangle structures.
///Params:
///    hdc = A handle to the destination device context.
///    pVertex = A pointer to an array of TRIVERTEX structures that each define a triangle vertex.
///    nVertex = The number of vertices in <i>pVertex</i>.
///    pMesh = An array of GRADIENT_TRIANGLE structures in triangle mode, or an array of GRADIENT_RECT structures in rectangle
///            mode.
///    nCount = The number of elements (triangles or rectangles) in <i>pMesh</i>.
///    ulMode = The gradient fill mode. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_RECT_H"></a><a
///             id="gradient_fill_rect_h"></a><dl> <dt><b>GRADIENT_FILL_RECT_H</b></dt> </dl> </td> <td width="60%"> In this
///             mode, two endpoints describe a rectangle. The rectangle is defined to have a constant color (specified by the
///             TRIVERTEX structure) for the left and right edges. GDI interpolates the color from the left to right edge and
///             fills the interior. </td> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_RECT_V"></a><a
///             id="gradient_fill_rect_v"></a><dl> <dt><b>GRADIENT_FILL_RECT_V</b></dt> </dl> </td> <td width="60%"> In this
///             mode, two endpoints describe a rectangle. The rectangle is defined to have a constant color (specified by the
///             TRIVERTEX structure) for the top and bottom edges. GDI interpolates the color from the top to bottom edge and
///             fills the interior. </td> </tr> <tr> <td width="40%"><a id="GRADIENT_FILL_TRIANGLE"></a><a
///             id="gradient_fill_triangle"></a><dl> <dt><b>GRADIENT_FILL_TRIANGLE</b></dt> </dl> </td> <td width="60%"> In this
///             mode, an array of TRIVERTEX structures is passed to GDI along with a list of array indexes that describe separate
///             triangles. GDI performs linear interpolation between triangle vertices and fills the interior. Drawing is done
///             directly in 24- and 32-bpp modes. Dithering is performed in 16-, 8-, 4-, and 1-bpp mode. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL GdiGradientFill(HDC hdc, char* pVertex, uint nVertex, void* pMesh, uint nCount, uint ulMode);

///The <b>PlayMetaFileRecord</b> function plays a Windows-format metafile record by executing the graphics device
///interface (GDI) function contained within that record. <div class="alert"><b>Note</b> This function is provided only
///for compatibility with Windows-format metafiles. Enhanced-format metafiles provide superior functionality and are
///recommended for new applications. The corresponding function for an enhanced-format metafile is
///PlayEnhMetaFileRecord.</div><div> </div>
///Params:
///    hdc = A handle to a device context.
///    lpHandleTable = A pointer to a HANDLETABLE structure representing the table of handles to GDI objects used when playing the
///                    metafile.
///    lpMR = A pointer to the Windows-format metafile record.
///    noObjs = The number of handles in the handle table.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PlayMetaFileRecord(HDC hdc, char* lpHandleTable, METARECORD* lpMR, uint noObjs);

///The <b>EnumMetaFile</b> function enumerates the records within a Windows-format metafile by retrieving each record
///and passing it to the specified callback function. The application-supplied callback function processes each record
///as required. The enumeration continues until the last record is processed or when the callback function returns zero.
///<div class="alert"><b>Note</b> This function is provided only for compatibility with Windows-format metafiles.
///Enhanced-format metafiles provide superior functionality and are recommended for new applications. The corresponding
///function for an enhanced-format metafile is EnumEnhMetaFile.</div><div> </div>
///Params:
///    hdc = Handle to a device context. This handle is passed to the callback function.
///    hmf = Handle to a Windows-format metafile.
///    proc = Pointer to an application-supplied callback function. For more information, see EnumMetaFileProc.
///    param = Pointer to optional data.
///Returns:
///    If the callback function successfully enumerates all the records in the Windows-format metafile, the return value
///    is nonzero. If the callback function does not successfully enumerate all the records in the Windows-format
///    metafile, the return value is zero.
///    
@DllImport("GDI32")
BOOL EnumMetaFile(HDC hdc, ptrdiff_t hmf, MFENUMPROC proc, LPARAM param3);

///The <b>CloseEnhMetaFile</b> function closes an enhanced-metafile device context and returns a handle that identifies
///an enhanced-format metafile.
///Params:
///    hdc = Handle to an enhanced-metafile device context.
///Returns:
///    If the function succeeds, the return value is a handle to an enhanced metafile. If the function fails, the return
///    value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t CloseEnhMetaFile(HDC hdc);

///The <b>CopyEnhMetaFile</b> function copies the contents of an enhanced-format metafile to a specified file.
///Params:
///    hEnh = A handle to the enhanced metafile to be copied.
///    lpFileName = A pointer to the name of the destination file. If this parameter is <b>NULL</b>, the source metafile is copied to
///                 memory.
///Returns:
///    If the function succeeds, the return value is a handle to the copy of the enhanced metafile. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t CopyEnhMetaFileA(ptrdiff_t hEnh, const(char)* lpFileName);

///The <b>CopyEnhMetaFile</b> function copies the contents of an enhanced-format metafile to a specified file.
///Params:
///    hEnh = A handle to the enhanced metafile to be copied.
///    lpFileName = A pointer to the name of the destination file. If this parameter is <b>NULL</b>, the source metafile is copied to
///                 memory.
///Returns:
///    If the function succeeds, the return value is a handle to the copy of the enhanced metafile. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t CopyEnhMetaFileW(ptrdiff_t hEnh, const(wchar)* lpFileName);

///The <b>CreateEnhMetaFile</b> function creates a device context for an enhanced-format metafile. This device context
///can be used to store a device-independent picture.
///Params:
///    hdc = A handle to a reference device for the enhanced metafile. This parameter can be <b>NULL</b>; for more
///          information, see Remarks.
///    lpFilename = A pointer to the file name for the enhanced metafile to be created. If this parameter is <b>NULL</b>, the
///                 enhanced metafile is memory based and its contents are lost when it is deleted by using the DeleteEnhMetaFile
///                 function.
///    lprc = A pointer to a RECT structure that specifies the dimensions (in .01-millimeter units) of the picture to be stored
///           in the enhanced metafile.
///    lpDesc = A pointer to a string that specifies the name of the application that created the picture, as well as the
///             picture's title. This parameter can be <b>NULL</b>; for more information, see Remarks.
///Returns:
///    If the function succeeds, the return value is a handle to the device context for the enhanced metafile. If the
///    function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HdcMetdataEnhFileHandle CreateEnhMetaFileA(HDC hdc, const(char)* lpFilename, const(RECT)* lprc, 
                                           const(char)* lpDesc);

///The <b>CreateEnhMetaFile</b> function creates a device context for an enhanced-format metafile. This device context
///can be used to store a device-independent picture.
///Params:
///    hdc = A handle to a reference device for the enhanced metafile. This parameter can be <b>NULL</b>; for more
///          information, see Remarks.
///    lpFilename = A pointer to the file name for the enhanced metafile to be created. If this parameter is <b>NULL</b>, the
///                 enhanced metafile is memory based and its contents are lost when it is deleted by using the DeleteEnhMetaFile
///                 function.
///    lprc = A pointer to a RECT structure that specifies the dimensions (in .01-millimeter units) of the picture to be stored
///           in the enhanced metafile.
///    lpDesc = A pointer to a string that specifies the name of the application that created the picture, as well as the
///             picture's title. This parameter can be <b>NULL</b>; for more information, see Remarks.
///Returns:
///    If the function succeeds, the return value is a handle to the device context for the enhanced metafile. If the
///    function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HdcMetdataEnhFileHandle CreateEnhMetaFileW(HDC hdc, const(wchar)* lpFilename, const(RECT)* lprc, 
                                           const(wchar)* lpDesc);

///The <b>DeleteEnhMetaFile</b> function deletes an enhanced-format metafile or an enhanced-format metafile handle.
///Params:
///    hmf = A handle to an enhanced metafile.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL DeleteEnhMetaFile(ptrdiff_t hmf);

///The <b>EnumEnhMetaFile</b> function enumerates the records within an enhanced-format metafile by retrieving each
///record and passing it to the specified callback function. The application-supplied callback function processes each
///record as required. The enumeration continues until the last record is processed or when the callback function
///returns zero.
///Params:
///    hdc = A handle to a device context. This handle is passed to the callback function.
///    hmf = A handle to an enhanced metafile.
///    proc = A pointer to the application-supplied callback function. For more information, see the EnhMetaFileProc function.
///    param = A pointer to optional callback-function data.
///    lpRect = A pointer to a RECT structure that specifies the coordinates, in logical units, of the picture's upper-left and
///             lower-right corners.
///Returns:
///    If the callback function successfully enumerates all the records in the enhanced metafile, the return value is
///    nonzero. If the callback function does not successfully enumerate all the records in the enhanced metafile, the
///    return value is zero.
///    
@DllImport("GDI32")
BOOL EnumEnhMetaFile(HDC hdc, ptrdiff_t hmf, ENHMFENUMPROC proc, void* param3, const(RECT)* lpRect);

///The <b>GetEnhMetaFile</b> function creates a handle that identifies the enhanced-format metafile stored in the
///specified file.
///Params:
///    lpName = A pointer to a null-terminated string that specifies the name of an enhanced metafile.
///Returns:
///    If the function succeeds, the return value is a handle to the enhanced metafile. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t GetEnhMetaFileA(const(char)* lpName);

///The <b>GetEnhMetaFile</b> function creates a handle that identifies the enhanced-format metafile stored in the
///specified file.
///Params:
///    lpName = A pointer to a null-terminated string that specifies the name of an enhanced metafile.
///Returns:
///    If the function succeeds, the return value is a handle to the enhanced metafile. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t GetEnhMetaFileW(const(wchar)* lpName);

///The <b>GetEnhMetaFileBits</b> function retrieves the contents of the specified enhanced-format metafile and copies
///them into a buffer.
///Params:
///    hEMF = A handle to the enhanced metafile.
///    nSize = The size, in bytes, of the buffer to receive the data.
///    lpData = A pointer to a buffer that receives the metafile data. The buffer must be sufficiently large to contain the data.
///             If <i>lpbBuffer</i> is <b>NULL</b>, the function returns the size necessary to hold the data.
///Returns:
///    If the function succeeds and the buffer pointer is <b>NULL</b>, the return value is the size of the enhanced
///    metafile, in bytes. If the function succeeds and the buffer pointer is a valid pointer, the return value is the
///    number of bytes copied to the buffer. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetEnhMetaFileBits(ptrdiff_t hEMF, uint nSize, char* lpData);

///The <b>GetEnhMetaFileDescription</b> function retrieves an optional text description from an enhanced-format metafile
///and copies the string to the specified buffer.
///Params:
///    hemf = A handle to the enhanced metafile.
///    cchBuffer = The size, in characters, of the buffer to receive the data. Only this many characters will be copied.
///    lpDescription = A pointer to a buffer that receives the optional text description.
///Returns:
///    If the optional text description exists and the buffer pointer is <b>NULL</b>, the return value is the length of
///    the text string, in characters. If the optional text description exists and the buffer pointer is a valid
///    pointer, the return value is the number of characters copied into the buffer. If the optional text description
///    does not exist, the return value is zero. If the function fails, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetEnhMetaFileDescriptionA(ptrdiff_t hemf, uint cchBuffer, const(char)* lpDescription);

///The <b>GetEnhMetaFileDescription</b> function retrieves an optional text description from an enhanced-format metafile
///and copies the string to the specified buffer.
///Params:
///    hemf = A handle to the enhanced metafile.
///    cchBuffer = The size, in characters, of the buffer to receive the data. Only this many characters will be copied.
///    lpDescription = A pointer to a buffer that receives the optional text description.
///Returns:
///    If the optional text description exists and the buffer pointer is <b>NULL</b>, the return value is the length of
///    the text string, in characters. If the optional text description exists and the buffer pointer is a valid
///    pointer, the return value is the number of characters copied into the buffer. If the optional text description
///    does not exist, the return value is zero. If the function fails, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetEnhMetaFileDescriptionW(ptrdiff_t hemf, uint cchBuffer, const(wchar)* lpDescription);

///The <b>GetEnhMetaFileHeader</b> function retrieves the record containing the header for the specified enhanced-format
///metafile.
///Params:
///    hemf = A handle to the enhanced metafile for which the header is to be retrieved.
///    nSize = The size, in bytes, of the buffer to receive the data. Only this many bytes will be copied.
///    lpEnhMetaHeader = A pointer to an ENHMETAHEADER structure that receives the header record. If this parameter is <b>NULL</b>, the
///                      function returns the size of the header record.
///Returns:
///    If the function succeeds and the structure pointer is <b>NULL</b>, the return value is the size of the record
///    that contains the header; if the structure pointer is a valid pointer, the return value is the number of bytes
///    copied. Otherwise, it is zero.
///    
@DllImport("GDI32")
uint GetEnhMetaFileHeader(ptrdiff_t hemf, uint nSize, char* lpEnhMetaHeader);

///The <b>GetEnhMetaFilePaletteEntries</b> function retrieves optional palette entries from the specified enhanced
///metafile.
///Params:
///    hemf = A handle to the enhanced metafile.
///    nNumEntries = The number of entries to be retrieved from the optional palette.
///    lpPaletteEntries = A pointer to an array of PALETTEENTRY structures that receives the palette colors. The array must contain at
///                       least as many structures as there are entries specified by the <i>cEntries</i> parameter.
///Returns:
///    If the array pointer is <b>NULL</b> and the enhanced metafile contains an optional palette, the return value is
///    the number of entries in the enhanced metafile's palette; if the array pointer is a valid pointer and the
///    enhanced metafile contains an optional palette, the return value is the number of entries copied; if the metafile
///    does not contain an optional palette, the return value is zero. Otherwise, the return value is GDI_ERROR.
///    
@DllImport("GDI32")
uint GetEnhMetaFilePaletteEntries(ptrdiff_t hemf, uint nNumEntries, char* lpPaletteEntries);

///The <b>GetWinMetaFileBits</b> function converts the enhanced-format records from a metafile into Windows-format
///records and stores the converted records in the specified buffer.
///Params:
///    hemf = A handle to the enhanced metafile.
///    cbData16 = The size, in bytes, of the buffer into which the converted records are to be copied.
///    pData16 = A pointer to the buffer that receives the converted records. If <i>lpbBuffer</i> is <b>NULL</b>,
///              <b>GetWinMetaFileBits</b> returns the number of bytes required to store the converted metafile records.
///    iMapMode = The mapping mode to use in the converted metafile.
///    hdcRef = A handle to the reference device context.
///Returns:
///    If the function succeeds and the buffer pointer is <b>NULL</b>, the return value is the number of bytes required
///    to store the converted records; if the function succeeds and the buffer pointer is a valid pointer, the return
///    value is the size of the metafile data in bytes. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetWinMetaFileBits(ptrdiff_t hemf, uint cbData16, char* pData16, int iMapMode, HDC hdcRef);

///The <b>PlayEnhMetaFile</b> function displays the picture stored in the specified enhanced-format metafile.
///Params:
///    hdc = A handle to the device context for the output device on which the picture will appear.
///    hmf = A handle to the enhanced metafile.
///    lprect = A pointer to a RECT structure that contains the coordinates of the bounding rectangle used to display the
///             picture. The coordinates are specified in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PlayEnhMetaFile(HDC hdc, ptrdiff_t hmf, const(RECT)* lprect);

///The <b>PlayEnhMetaFileRecord</b> function plays an enhanced-metafile record by executing the graphics device
///interface (GDI) functions identified by the record.
///Params:
///    hdc = A handle to the device context passed to the EnumEnhMetaFile function.
///    pht = A pointer to a table of handles to GDI objects used when playing the metafile. The first entry in this table
///          contains the enhanced-metafile handle.
///    pmr = A pointer to the enhanced-metafile record to be played.
///    cht = The number of handles in the handle table.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PlayEnhMetaFileRecord(HDC hdc, char* pht, const(ENHMETARECORD)* pmr, uint cht);

///The <b>SetEnhMetaFileBits</b> function creates a memory-based enhanced-format metafile from the specified data.
///Params:
///    nSize = Specifies the size, in bytes, of the data provided.
///    pb = Pointer to a buffer that contains enhanced-metafile data. (It is assumed that the data in the buffer was obtained
///         by calling the GetEnhMetaFileBits function.)
///Returns:
///    If the function succeeds, the return value is a handle to a memory-based enhanced metafile. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t SetEnhMetaFileBits(uint nSize, char* pb);

///The <b>SetWinMetaFileBits</b> function converts a metafile from the older Windows format to the new enhanced format
///and stores the new metafile in memory.
///Params:
///    nSize = The size, in bytes, of the buffer that contains the Windows-format metafile.
///    lpMeta16Data = A pointer to a buffer that contains the Windows-format metafile data. (It is assumed that the data was obtained
///                   by using the GetMetaFileBitsEx or GetWinMetaFileBits function.)
///    hdcRef = A handle to a reference device context.
///    lpMFP = A pointer to a METAFILEPICT structure that contains the suggested size of the metafile picture and the mapping
///            mode that was used when the picture was created.
///Returns:
///    If the function succeeds, the return value is a handle to a memory-based enhanced metafile. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
ptrdiff_t SetWinMetaFileBits(uint nSize, char* lpMeta16Data, HDC hdcRef, const(METAFILEPICT)* lpMFP);

///The <b>GdiComment</b> function copies a comment from a buffer into a specified enhanced-format metafile.
///Params:
///    hdc = A handle to an enhanced-metafile device context.
///    nSize = The length of the comment buffer, in bytes.
///    lpData = A pointer to the buffer that contains the comment.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GdiComment(HDC hdc, uint nSize, char* lpData);

///The <b>GetTextMetrics</b> function fills the specified buffer with the metrics for the currently selected font.
///Params:
///    hdc = A handle to the device context.
///    lptm = A pointer to the TEXTMETRIC structure that receives the text metrics.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextMetricsA(HDC hdc, TEXTMETRICA* lptm);

///The <b>GetTextMetrics</b> function fills the specified buffer with the metrics for the currently selected font.
///Params:
///    hdc = A handle to the device context.
///    lptm = A pointer to the TEXTMETRIC structure that receives the text metrics.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetTextMetricsW(HDC hdc, TEXTMETRICW* lptm);

///The <b>AngleArc</b> function draws a line segment and an arc. The line segment is drawn from the current position to
///the beginning of the arc. The arc is drawn along the perimeter of a circle with the given radius and center. The
///length of the arc is defined by the given start and sweep angles.
///Params:
///    hdc = Handle to a device context.
///    x = Specifies the x-coordinate, in logical units, of the center of the circle.
///    y = Specifies the y-coordinate, in logical units, of the center of the circle.
///    r = Specifies the radius, in logical units, of the circle. This value must be positive.
///    StartAngle = Specifies the start angle, in degrees, relative to the x-axis.
///    SweepAngle = Specifies the sweep angle, in degrees, relative to the starting angle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL AngleArc(HDC hdc, int x, int y, uint r, float StartAngle, float SweepAngle);

///The <b>PolyPolyline</b> function draws multiple series of connected line segments.
///Params:
///    hdc = A handle to the device context.
///    apt = A pointer to an array of POINT structures that contains the vertices of the polylines, in logical units. The
///          polylines are specified consecutively.
///    asz = A pointer to an array of variables specifying the number of points in the <i>lppt</i> array for the corresponding
///          polyline. Each entry must be greater than or equal to two.
///    csz = The total number of entries in the <i>lpdwPolyPoints</i> array.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolyPolyline(HDC hdc, const(POINT)* apt, char* asz, uint csz);

///The <b>GetWorldTransform</b> function retrieves the current world-space to page-space transformation.
///Params:
///    hdc = A handle to the device context.
///    lpxf = A pointer to an XFORM structure that receives the current world-space to page-space transformation.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetWorldTransform(HDC hdc, XFORM* lpxf);

///The <b>SetWorldTransform</b> function sets a two-dimensional linear transformation between world space and page space
///for the specified device context. This transformation can be used to scale, rotate, shear, or translate graphics
///output.
///Params:
///    hdc = A handle to the device context.
///    lpxf = A pointer to an XFORM structure that contains the transformation data.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetWorldTransform(HDC hdc, const(XFORM)* lpxf);

///The <b>ModifyWorldTransform</b> function changes the world transformation for a device context using the specified
///mode.
///Params:
///    hdc = A handle to the device context.
///    lpxf = A pointer to an XFORM structure used to modify the world transformation for the given device context.
///    mode = Specifies how the transformation data modifies the current world transformation. This parameter must be one of
///           the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id="MWT_IDENTITY"></a><a id="mwt_identity"></a><dl> <dt><b>MWT_IDENTITY</b></dt> </dl> </td> <td width="60%">
///           Resets the current world transformation by using the identity matrix. If this mode is specified, the XFORM
///           structure pointed to by <i>lpXform</i> is ignored. </td> </tr> <tr> <td width="40%"><a
///           id="MWT_LEFTMULTIPLY"></a><a id="mwt_leftmultiply"></a><dl> <dt><b>MWT_LEFTMULTIPLY</b></dt> </dl> </td> <td
///           width="60%"> Multiplies the current transformation by the data in the XFORM structure. (The data in the
///           <b>XFORM</b> structure becomes the left multiplicand, and the data for the current transformation becomes the
///           right multiplicand.) </td> </tr> <tr> <td width="40%"><a id="MWT_RIGHTMULTIPLY"></a><a
///           id="mwt_rightmultiply"></a><dl> <dt><b>MWT_RIGHTMULTIPLY</b></dt> </dl> </td> <td width="60%"> Multiplies the
///           current transformation by the data in the XFORM structure. (The data in the <b>XFORM</b> structure becomes the
///           right multiplicand, and the data for the current transformation becomes the left multiplicand.) </td> </tr>
///           </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ModifyWorldTransform(HDC hdc, const(XFORM)* lpxf, uint mode);

///The <b>CombineTransform</b> function concatenates two world-space to page-space transformations.
///Params:
///    lpxfOut = A pointer to an XFORM structure that receives the combined transformation.
///    lpxf1 = A pointer to an XFORM structure that specifies the first transformation.
///    lpxf2 = A pointer to an XFORM structure that specifies the second transformation.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL CombineTransform(XFORM* lpxfOut, const(XFORM)* lpxf1, const(XFORM)* lpxf2);

///The <b>CreateDIBSection</b> function creates a DIB that applications can write to directly. The function gives you a
///pointer to the location of the bitmap bit values. You can supply a handle to a file-mapping object that the function
///will use to create the bitmap, or you can let the system allocate the memory for the bitmap.
///Params:
///    hdc = A handle to a device context. If the value of <i>iUsage</i> is DIB_PAL_COLORS, the function uses this device
///          context's logical palette to initialize the DIB colors.
///    pbmi = A pointer to a BITMAPINFO structure that specifies various attributes of the DIB, including the bitmap dimensions
///           and colors.
///    usage = The type of data contained in the <b>bmiColors</b> array member of the BITMAPINFO structure pointed to by
///            <i>pbmi</i> (either logical palette indexes or literal RGB values). The following values are defined. <table>
///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DIB_PAL_COLORS"></a><a
///            id="dib_pal_colors"></a><dl> <dt><b>DIB_PAL_COLORS</b></dt> </dl> </td> <td width="60%"> The <b>bmiColors</b>
///            member is an array of 16-bit indexes into the logical palette of the device context specified by <i>hdc</i>.
///            </td> </tr> <tr> <td width="40%"><a id="DIB_RGB_COLORS"></a><a id="dib_rgb_colors"></a><dl>
///            <dt><b>DIB_RGB_COLORS</b></dt> </dl> </td> <td width="60%"> The BITMAPINFO structure contains an array of literal
///            RGB values. </td> </tr> </table>
///    ppvBits = A pointer to a variable that receives a pointer to the location of the DIB bit values.
///    hSection = A handle to a file-mapping object that the function will use to create the DIB. This parameter can be
///               <b>NULL</b>. If <i>hSection</i> is not <b>NULL</b>, it must be a handle to a file-mapping object created by
///               calling the CreateFileMapping function with the PAGE_READWRITE or PAGE_WRITECOPY flag. Read-only DIB sections are
///               not supported. Handles created by other means will cause <b>CreateDIBSection</b> to fail. If <i>hSection</i> is
///               not <b>NULL</b>, the <b>CreateDIBSection</b> function locates the bitmap bit values at offset <i>dwOffset</i> in
///               the file-mapping object referred to by <i>hSection</i>. An application can later retrieve the <i>hSection</i>
///               handle by calling the GetObject function with the <b>HBITMAP</b> returned by <b>CreateDIBSection</b>. If
///               <i>hSection</i> is <b>NULL</b>, the system allocates memory for the DIB. In this case, the
///               <b>CreateDIBSection</b> function ignores the <i>dwOffset</i> parameter. An application cannot later obtain a
///               handle to this memory. The <b>dshSection</b> member of the DIBSECTION structure filled in by calling the
///               GetObject function will be <b>NULL</b>.
///    offset = The offset from the beginning of the file-mapping object referenced by <i>hSection</i> where storage for the
///             bitmap bit values is to begin. This value is ignored if <i>hSection</i> is <b>NULL</b>. The bitmap bit values are
///             aligned on doubleword boundaries, so <i>dwOffset</i> must be a multiple of the size of a <b>DWORD</b>.
///Returns:
///    If the function succeeds, the return value is a handle to the newly created DIB, and *<i>ppvBits</i> points to
///    the bitmap bit values. If the function fails, the return value is <b>NULL</b>, and *<i>ppvBits</i> is
///    <b>NULL</b>. This function can return the following value. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more
///    of the input parameters is invalid. </td> </tr> </table>
///    
@DllImport("GDI32")
HBITMAP CreateDIBSection(HDC hdc, const(BITMAPINFO)* pbmi, uint usage, void** ppvBits, HANDLE hSection, 
                         uint offset);

///The <b>GetDIBColorTable</b> function retrieves RGB (red, green, blue) color values from a range of entries in the
///color table of the DIB section bitmap that is currently selected into a specified device context.
///Params:
///    hdc = A handle to a device context. A DIB section bitmap must be selected into this device context.
///    iStart = A zero-based color table index that specifies the first color table entry to retrieve.
///    cEntries = The number of color table entries to retrieve.
///    prgbq = A pointer to a buffer that receives an array of RGBQUAD data structures containing color information from the DIB
///            color table. The buffer must be large enough to contain as many <b>RGBQUAD</b> data structures as the value of
///            <i>cEntries</i>.
///Returns:
///    If the function succeeds, the return value is the number of color table entries that the function retrieves. If
///    the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint GetDIBColorTable(HDC hdc, uint iStart, uint cEntries, char* prgbq);

///The <b>SetDIBColorTable</b> function sets RGB (red, green, blue) color values in a range of entries in the color
///table of the DIB that is currently selected into a specified device context.
///Params:
///    hdc = A device context. A DIB must be selected into this device context.
///    iStart = A zero-based color table index that specifies the first color table entry to set.
///    cEntries = The number of color table entries to set.
///    prgbq = A pointer to an array of RGBQUAD structures containing new color information for the DIB's color table.
///Returns:
///    If the function succeeds, the return value is the number of color table entries that the function sets. If the
///    function fails, the return value is zero.
///    
@DllImport("GDI32")
uint SetDIBColorTable(HDC hdc, uint iStart, uint cEntries, char* prgbq);

///The <b>SetColorAdjustment</b> function sets the color adjustment values for a device context (DC) using the specified
///values.
///Params:
///    hdc = A handle to the device context.
///    lpca = A pointer to a COLORADJUSTMENT structure containing the color adjustment values.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetColorAdjustment(HDC hdc, const(COLORADJUSTMENT)* lpca);

///The <b>GetColorAdjustment</b> function retrieves the color adjustment values for the specified device context (DC).
///Params:
///    hdc = A handle to the device context.
///    lpca = A pointer to a COLORADJUSTMENT structure that receives the color adjustment values.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetColorAdjustment(HDC hdc, COLORADJUSTMENT* lpca);

///The <b>CreateHalftonePalette</b> function creates a halftone palette for the specified device context (DC).
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is a handle to a logical halftone palette. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
HPALETTE CreateHalftonePalette(HDC hdc);

///The <b>AbortPath</b> function closes and discards any paths in the specified device context.
///Params:
///    hdc = Handle to the device context from which a path will be discarded.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL AbortPath(HDC hdc);

///The <b>ArcTo</b> function draws an elliptical arc.
///Params:
///    hdc = A handle to the device context where drawing takes place.
///    left = The x-coordinate, in logical units, of the upper-left corner of the bounding rectangle.
///    top = The y-coordinate, in logical units, of the upper-left corner of the bounding rectangle.
///    right = The x-coordinate, in logical units, of the lower-right corner of the bounding rectangle.
///    bottom = The y-coordinate, in logical units, of the lower-right corner of the bounding rectangle.
///    xr1 = The x-coordinate, in logical units, of the endpoint of the radial defining the starting point of the arc.
///    yr1 = The y-coordinate, in logical units, of the endpoint of the radial defining the starting point of the arc.
///    xr2 = The x-coordinate, in logical units, of the endpoint of the radial defining the ending point of the arc.
///    yr2 = The y-coordinate, in logical units, of the endpoint of the radial defining the ending point of the arc.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ArcTo(HDC hdc, int left, int top, int right, int bottom, int xr1, int yr1, int xr2, int yr2);

///The <b>BeginPath</b> function opens a path bracket in the specified device context.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL BeginPath(HDC hdc);

///The <b>CloseFigure</b> function closes an open figure in a path.
///Params:
///    hdc = Handle to the device context in which the figure will be closed.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL CloseFigure(HDC hdc);

///The <b>EndPath</b> function closes a path bracket and selects the path defined by the bracket into the specified
///device context.
///Params:
///    hdc = A handle to the device context into which the new path is selected.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL EndPath(HDC hdc);

///The <b>FillPath</b> function closes any open figures in the current path and fills the path's interior by using the
///current brush and polygon-filling mode.
///Params:
///    hdc = A handle to a device context that contains a valid path.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL FillPath(HDC hdc);

///The <b>FlattenPath</b> function transforms any curves in the path that is selected into the current device context
///(DC), turning each curve into a sequence of lines.
///Params:
///    hdc = A handle to a DC that contains a valid path.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL FlattenPath(HDC hdc);

///The <b>GetPath</b> function retrieves the coordinates defining the endpoints of lines and the control points of
///curves found in the path that is selected into the specified device context.
///Params:
///    hdc = A handle to a device context that contains a closed path.
///    apt = A pointer to an array of POINT structures that receives the line endpoints and curve control points, in logical
///          coordinates.
///    aj = A pointer to an array of bytes that receives the vertex types. This parameter can be one of the following values.
///         <table> <tr> <th>Type</th> <th>Description</th> </tr> <tr> <td width="40%"><a id="PT_MOVETO"></a><a
///         id="pt_moveto"></a><dl> <dt><b>PT_MOVETO</b></dt> </dl> </td> <td width="60%"> Specifies that the corresponding
///         point in the <i>lpPoints</i> parameter starts a disjoint figure. </td> </tr> <tr> <td width="40%"><a
///         id="PT_LINETO"></a><a id="pt_lineto"></a><dl> <dt><b>PT_LINETO</b></dt> </dl> </td> <td width="60%"> Specifies
///         that the previous point and the corresponding point in <i>lpPoints</i> are the endpoints of a line. </td> </tr>
///         <tr> <td width="40%"><a id="PT_BEZIERTO"></a><a id="pt_bezierto"></a><dl> <dt><b>PT_BEZIERTO</b></dt> </dl> </td>
///         <td width="60%"> Specifies that the corresponding point in <i>lpPoints</i> is a control point or ending point for
///         a Bézier curve. PT_BEZIERTO values always occur in sets of three. The point in the path immediately preceding
///         them defines the starting point for the Bézier curve. The first two PT_BEZIERTO points are the control points,
///         and the third PT_BEZIERTO point is the ending (if hard-coded) point. </td> </tr> </table> A PT_LINETO or
///         PT_BEZIERTO value may be combined with the following value (by using the bitwise operator OR) to indicate that
///         the corresponding point is the last point in a figure and the figure should be closed. <table> <tr> <th>Flag</th>
///         <th>Description</th> </tr> <tr> <td width="40%"><a id="PT_CLOSEFIGURE"></a><a id="pt_closefigure"></a><dl>
///         <dt><b>PT_CLOSEFIGURE</b></dt> </dl> </td> <td width="60%"> Specifies that the figure is automatically closed
///         after the corresponding line or curve is drawn. The figure is closed by drawing a line from the line or curve
///         endpoint to the point corresponding to the last PT_MOVETO. </td> </tr> </table>
///    cpt = The total number of POINT structures that can be stored in the array pointed to by <i>lpPoints</i>. This value
///          must be the same as the number of bytes that can be placed in the array pointed to by <i>lpTypes</i>.
///Returns:
///    If the <i>nSize</i> parameter is nonzero, the return value is the number of points enumerated. If <i>nSize</i> is
///    0, the return value is the total number of points in the path (and <b>GetPath</b> writes nothing to the buffers).
///    If <i>nSize</i> is nonzero and is less than the number of points in the path, the return value is 1.
///    
@DllImport("GDI32")
int GetPath(HDC hdc, char* apt, char* aj, int cpt);

///The <b>PathToRegion</b> function creates a region from the path that is selected into the specified device context.
///The resulting region uses device coordinates.
///Params:
///    hdc = Handle to a device context that contains a closed path.
///Returns:
///    If the function succeeds, the return value identifies a valid region. If the function fails, the return value is
///    zero.
///    
@DllImport("GDI32")
HRGN PathToRegion(HDC hdc);

///The <b>PolyDraw</b> function draws a set of line segments and Bézier curves.
///Params:
///    hdc = A handle to a device context.
///    apt = A pointer to an array of POINT structures that contains the endpoints for each line segment and the endpoints and
///          control points for each Bézier curve, in logical units.
///    aj = A pointer to an array that specifies how each point in the <i>lppt</i> array is used. This parameter can be one
///         of the following values. <table> <tr> <th>Type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///         id="PT_MOVETO"></a><a id="pt_moveto"></a><dl> <dt><b>PT_MOVETO</b></dt> </dl> </td> <td width="60%"> Specifies
///         that this point starts a disjoint figure. This point becomes the new current position. </td> </tr> <tr> <td
///         width="40%"><a id="PT_LINETO"></a><a id="pt_lineto"></a><dl> <dt><b>PT_LINETO</b></dt> </dl> </td> <td
///         width="60%"> Specifies that a line is to be drawn from the current position to this point, which then becomes the
///         new current position. </td> </tr> <tr> <td width="40%"><a id="PT_BEZIERTO"></a><a id="pt_bezierto"></a><dl>
///         <dt><b>PT_BEZIERTO</b></dt> </dl> </td> <td width="60%"> Specifies that this point is a control point or ending
///         point for a Bézier curve. PT_BEZIERTO types always occur in sets of three. The current position defines the
///         starting point for the Bézier curve. The first two PT_BEZIERTO points are the control points, and the third
///         PT_BEZIERTO point is the ending point. The ending point becomes the new current position. If there are not three
///         consecutive PT_BEZIERTO points, an error results. </td> </tr> </table> A PT_LINETO or PT_BEZIERTO type can be
///         combined with the following value by using the bitwise operator OR to indicate that the corresponding point is
///         the last point in a figure and the figure is closed. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///         width="40%"><a id="PT_CLOSEFIGURE"></a><a id="pt_closefigure"></a><dl> <dt><b>PT_CLOSEFIGURE</b></dt> </dl> </td>
///         <td width="60%"> Specifies that the figure is automatically closed after the PT_LINETO or PT_BEZIERTO type for
///         this point is done. A line is drawn from this point to the most recent PT_MOVETO or MoveToEx point. This value is
///         combined with the PT_LINETO type for a line, or with the PT_BEZIERTO type of the ending point for a Bézier
///         curve, by using the bitwise operator OR. The current position is set to the ending point of the closing line.
///         </td> </tr> </table>
///    cpt = The total number of points in the <i>lppt</i> array, the same as the number of bytes in the <i>lpbTypes</i>
///          array.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolyDraw(HDC hdc, char* apt, char* aj, int cpt);

///The <b>SelectClipPath</b> function selects the current path as a clipping region for a device context, combining the
///new region with any existing clipping region using the specified mode.
///Params:
///    hdc = A handle to the device context of the path.
///    mode = The way to use the path. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RGN_AND"></a><a id="rgn_and"></a><dl> <dt><b>RGN_AND</b></dt>
///           </dl> </td> <td width="60%"> The new clipping region includes the intersection (overlapping areas) of the current
///           clipping region and the current path. </td> </tr> <tr> <td width="40%"><a id="RGN_COPY"></a><a
///           id="rgn_copy"></a><dl> <dt><b>RGN_COPY</b></dt> </dl> </td> <td width="60%"> The new clipping region is the
///           current path. </td> </tr> <tr> <td width="40%"><a id="RGN_DIFF"></a><a id="rgn_diff"></a><dl>
///           <dt><b>RGN_DIFF</b></dt> </dl> </td> <td width="60%"> The new clipping region includes the areas of the current
///           clipping region with those of the current path excluded. </td> </tr> <tr> <td width="40%"><a id="RGN_OR"></a><a
///           id="rgn_or"></a><dl> <dt><b>RGN_OR</b></dt> </dl> </td> <td width="60%"> The new clipping region includes the
///           union (combined areas) of the current clipping region and the current path. </td> </tr> <tr> <td width="40%"><a
///           id="RGN_XOR"></a><a id="rgn_xor"></a><dl> <dt><b>RGN_XOR</b></dt> </dl> </td> <td width="60%"> The new clipping
///           region includes the union of the current clipping region and the current path but without the overlapping areas.
///           </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SelectClipPath(HDC hdc, int mode);

///The <b>SetArcDirection</b> sets the drawing direction to be used for arc and rectangle functions.
///Params:
///    hdc = A handle to the device context.
///    dir = The new arc direction. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///          <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AD_COUNTERCLOCKWISE"></a><a id="ad_counterclockwise"></a><dl>
///          <dt><b>AD_COUNTERCLOCKWISE</b></dt> </dl> </td> <td width="60%"> Figures drawn counterclockwise. </td> </tr> <tr>
///          <td width="40%"><a id="AD_CLOCKWISE"></a><a id="ad_clockwise"></a><dl> <dt><b>AD_CLOCKWISE</b></dt> </dl> </td>
///          <td width="60%"> Figures drawn clockwise. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value specifies the old arc direction. If the function fails, the return
///    value is zero.
///    
@DllImport("GDI32")
int SetArcDirection(HDC hdc, int dir);

///The <b>SetMiterLimit</b> function sets the limit for the length of miter joins for the specified device context.
///Params:
///    hdc = Handle to the device context.
///    limit = Specifies the new miter limit for the device context.
///    old = Pointer to a floating-point value that receives the previous miter limit. If this parameter is <b>NULL</b>, the
///          previous miter limit is not returned.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetMiterLimit(HDC hdc, float limit, float* old);

///The <b>StrokeAndFillPath</b> function closes any open figures in a path, strokes the outline of the path by using the
///current pen, and fills its interior by using the current brush.
///Params:
///    hdc = A handle to the device context.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL StrokeAndFillPath(HDC hdc);

///The <b>StrokePath</b> function renders the specified path by using the current pen.
///Params:
///    hdc = Handle to a device context that contains the completed path.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL StrokePath(HDC hdc);

///The <b>WidenPath</b> function redefines the current path as the area that would be painted if the path were stroked
///using the pen currently selected into the given device context.
///Params:
///    hdc = A handle to a device context that contains a closed path.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL WidenPath(HDC hdc);

///The <b>ExtCreatePen</b> function creates a logical cosmetic or geometric pen that has the specified style, width, and
///brush attributes.
///Params:
///    iPenStyle = A combination of type, style, end cap, and join attributes. The values from each category are combined by using
///                the bitwise OR operator ( | ). The pen type can be one of the following values. <table> <tr> <th>Value</th>
///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PS_GEOMETRIC"></a><a id="ps_geometric"></a><dl>
///                <dt><b>PS_GEOMETRIC</b></dt> </dl> </td> <td width="60%"> The pen is geometric. </td> </tr> <tr> <td
///                width="40%"><a id="PS_COSMETIC"></a><a id="ps_cosmetic"></a><dl> <dt><b>PS_COSMETIC</b></dt> </dl> </td> <td
///                width="60%"> The pen is cosmetic. </td> </tr> </table> The pen style can be one of the following values. <table>
///                <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PS_ALTERNATE"></a><a
///                id="ps_alternate"></a><dl> <dt><b>PS_ALTERNATE</b></dt> </dl> </td> <td width="60%"> The pen sets every other
///                pixel. (This style is applicable only for cosmetic pens.) </td> </tr> <tr> <td width="40%"><a
///                id="PS_SOLID"></a><a id="ps_solid"></a><dl> <dt><b>PS_SOLID</b></dt> </dl> </td> <td width="60%"> The pen is
///                solid. </td> </tr> <tr> <td width="40%"><a id="PS_DASH"></a><a id="ps_dash"></a><dl> <dt><b>PS_DASH</b></dt>
///                </dl> </td> <td width="60%"> The pen is dashed. </td> </tr> <tr> <td width="40%"><a id="PS_DOT"></a><a
///                id="ps_dot"></a><dl> <dt><b>PS_DOT</b></dt> </dl> </td> <td width="60%"> The pen is dotted. </td> </tr> <tr> <td
///                width="40%"><a id="PS_DASHDOT"></a><a id="ps_dashdot"></a><dl> <dt><b>PS_DASHDOT</b></dt> </dl> </td> <td
///                width="60%"> The pen has alternating dashes and dots. </td> </tr> <tr> <td width="40%"><a
///                id="PS_DASHDOTDOT"></a><a id="ps_dashdotdot"></a><dl> <dt><b>PS_DASHDOTDOT</b></dt> </dl> </td> <td width="60%">
///                The pen has alternating dashes and double dots. </td> </tr> <tr> <td width="40%"><a id="PS_NULL"></a><a
///                id="ps_null"></a><dl> <dt><b>PS_NULL</b></dt> </dl> </td> <td width="60%"> The pen is invisible. </td> </tr> <tr>
///                <td width="40%"><a id="PS_USERSTYLE"></a><a id="ps_userstyle"></a><dl> <dt><b>PS_USERSTYLE</b></dt> </dl> </td>
///                <td width="60%"> The pen uses a styling array supplied by the user. </td> </tr> <tr> <td width="40%"><a
///                id="PS_INSIDEFRAME"></a><a id="ps_insideframe"></a><dl> <dt><b>PS_INSIDEFRAME</b></dt> </dl> </td> <td
///                width="60%"> The pen is solid. When this pen is used in any GDI drawing function that takes a bounding rectangle,
///                the dimensions of the figure are shrunk so that it fits entirely in the bounding rectangle, taking into account
///                the width of the pen. This applies only to geometric pens. </td> </tr> </table> The end cap is only specified for
///                geometric pens. The end cap can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                </tr> <tr> <td width="40%"><a id="PS_ENDCAP_ROUND"></a><a id="ps_endcap_round"></a><dl>
///                <dt><b>PS_ENDCAP_ROUND</b></dt> </dl> </td> <td width="60%"> End caps are round. </td> </tr> <tr> <td
///                width="40%"><a id="PS_ENDCAP_SQUARE"></a><a id="ps_endcap_square"></a><dl> <dt><b>PS_ENDCAP_SQUARE</b></dt> </dl>
///                </td> <td width="60%"> End caps are square. </td> </tr> <tr> <td width="40%"><a id="PS_ENDCAP_FLAT"></a><a
///                id="ps_endcap_flat"></a><dl> <dt><b>PS_ENDCAP_FLAT</b></dt> </dl> </td> <td width="60%"> End caps are flat. </td>
///                </tr> </table> The join is only specified for geometric pens. The join can be one of the following values.
///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PS_JOIN_BEVEL"></a><a
///                id="ps_join_bevel"></a><dl> <dt><b>PS_JOIN_BEVEL</b></dt> </dl> </td> <td width="60%"> Joins are beveled. </td>
///                </tr> <tr> <td width="40%"><a id="PS_JOIN_MITER"></a><a id="ps_join_miter"></a><dl> <dt><b>PS_JOIN_MITER</b></dt>
///                </dl> </td> <td width="60%"> Joins are mitered when they are within the current limit set by the SetMiterLimit
///                function. If it exceeds this limit, the join is beveled. </td> </tr> <tr> <td width="40%"><a
///                id="PS_JOIN_ROUND"></a><a id="ps_join_round"></a><dl> <dt><b>PS_JOIN_ROUND</b></dt> </dl> </td> <td width="60%">
///                Joins are round. </td> </tr> </table>
///    cWidth = The width of the pen. If the <i>dwPenStyle</i> parameter is PS_GEOMETRIC, the width is given in logical units. If
///             <i>dwPenStyle</i> is PS_COSMETIC, the width must be set to 1.
///    plbrush = A pointer to a LOGBRUSH structure. If <i>dwPenStyle</i> is PS_COSMETIC, the <b>lbColor</b> member specifies the
///              color of the pen and the <b>lpStyle</b> member must be set to BS_SOLID. If <i>dwPenStyle</i> is PS_GEOMETRIC, all
///              members must be used to specify the brush attributes of the pen.
///    cStyle = The length, in <b>DWORD</b> units, of the <i>lpStyle</i> array. This value must be zero if <i>dwPenStyle</i> is
///             not PS_USERSTYLE. The style count is limited to 16.
///    pstyle = A pointer to an array. The first value specifies the length of the first dash in a user-defined style, the second
///             value specifies the length of the first space, and so on. This pointer must be <b>NULL</b> if <i>dwPenStyle</i>
///             is not PS_USERSTYLE. If the <i>lpStyle</i> array is exceeded during line drawing, the pointer is reset to the
///             beginning of the array. When this happens and <i>dwStyleCount</i> is an even number, the pattern of dashes and
///             spaces repeats. However, if <i>dwStyleCount</i> is odd, the pattern reverses when the pointer is reset -- the
///             first element of <i>lpStyle</i> now refers to spaces, the second refers to dashes, and so forth.
///Returns:
///    If the function succeeds, the return value is a handle that identifies a logical pen. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
HPEN ExtCreatePen(uint iPenStyle, uint cWidth, const(LOGBRUSH)* plbrush, uint cStyle, char* pstyle);

///The <b>GetMiterLimit</b> function retrieves the miter limit for the specified device context.
///Params:
///    hdc = Handle to the device context.
///    plimit = Pointer to a floating-point value that receives the current miter limit.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetMiterLimit(HDC hdc, float* plimit);

///The <b>GetArcDirection</b> function retrieves the current arc direction for the specified device context. Arc and
///rectangle functions use the arc direction.
///Params:
///    hdc = Handle to the device context.
///Returns:
///    The return value specifies the current arc direction; it can be any one of the following values: <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td>AD_COUNTERCLOCKWISE</td> <td>Arcs and rectangles are drawn
///    counterclockwise.</td> </tr> <tr> <td>AD_CLOCKWISE</td> <td>Arcs and rectangles are drawn clockwise.</td> </tr>
///    </table>
///    
@DllImport("GDI32")
int GetArcDirection(HDC hdc);

///The <b>GetObject</b> function retrieves information for the specified graphics object.
///Params:
///    h = A handle to the graphics object of interest. This can be a handle to one of the following: a logical bitmap, a
///        brush, a font, a palette, a pen, or a device independent bitmap created by calling the CreateDIBSection function.
///    c = The number of bytes of information to be written to the buffer.
///    pv = A pointer to a buffer that receives the information about the specified graphics object. The following table
///         shows the type of information the buffer receives for each type of graphics object you can specify with
///         <i>hgdiobj</i>. <table> <tr> <th>Object type</th> <th>Data written to buffer</th> </tr> <tr> <td width="40%"><a
///         id="HBITMAP"></a><a id="hbitmap"></a><dl> <dt><b><b>HBITMAP</b></b></dt> </dl> </td> <td width="60%"> BITMAP
///         </td> </tr> <tr> <td width="40%"><a id="HBITMAP_returned_from_a_call_to_CreateDIBSection"></a><a
///         id="hbitmap_returned_from_a_call_to_createdibsection"></a><a
///         id="HBITMAP_RETURNED_FROM_A_CALL_TO_CREATEDIBSECTION"></a><dl> <dt><b><b>HBITMAP</b> returned from a call to
///         CreateDIBSection</b></dt> </dl> </td> <td width="60%"> DIBSECTION, if <i>cbBuffer</i> is set to<code> sizeof
///         (DIBSECTION)</code>, or BITMAP, if <i>cbBuffer</i> is set to <code>sizeof (BITMAP)</code>. </td> </tr> <tr> <td
///         width="40%"><a id="HPALETTE"></a><a id="hpalette"></a><dl> <dt><b><b>HPALETTE</b></b></dt> </dl> </td> <td
///         width="60%"> A <b>WORD</b> count of the number of entries in the logical palette </td> </tr> <tr> <td
///         width="40%"><a id="HPEN_returned_from_a_call_to_ExtCreatePen"></a><a
///         id="hpen_returned_from_a_call_to_extcreatepen"></a><a id="HPEN_RETURNED_FROM_A_CALL_TO_EXTCREATEPEN"></a><dl>
///         <dt><b><b>HPEN</b> returned from a call to ExtCreatePen</b></dt> </dl> </td> <td width="60%"> EXTLOGPEN </td>
///         </tr> <tr> <td width="40%"><a id="HPEN"></a><a id="hpen"></a><dl> <dt><b><b>HPEN</b></b></dt> </dl> </td> <td
///         width="60%"> LOGPEN </td> </tr> <tr> <td width="40%"><a id="HBRUSH"></a><a id="hbrush"></a><dl>
///         <dt><b><b>HBRUSH</b></b></dt> </dl> </td> <td width="60%"> LOGBRUSH </td> </tr> <tr> <td width="40%"><a
///         id="HFONT"></a><a id="hfont"></a><dl> <dt><b><b>HFONT</b></b></dt> </dl> </td> <td width="60%"> LOGFONT </td>
///         </tr> </table> If the <i>lpvObject</i> parameter is <b>NULL</b>, the function return value is the number of bytes
///         required to store the information it writes to the buffer for the specified graphics object. The address of
///         <i>lpvObject</i> must be on a 4-byte boundary; otherwise, <b>GetObject</b> fails.
///Returns:
///    If the function succeeds, and <i>lpvObject</i> is a valid pointer, the return value is the number of bytes stored
///    into the buffer. If the function succeeds, and <i>lpvObject</i> is <b>NULL</b>, the return value is the number of
///    bytes required to hold the information the function would store into the buffer. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
int GetObjectA(HANDLE h, int c, char* pv);

///The <b>GetObject</b> function retrieves information for the specified graphics object.
///Params:
///    h = A handle to the graphics object of interest. This can be a handle to one of the following: a logical bitmap, a
///        brush, a font, a palette, a pen, or a device independent bitmap created by calling the CreateDIBSection function.
///    c = The number of bytes of information to be written to the buffer.
///    pv = A pointer to a buffer that receives the information about the specified graphics object. The following table
///         shows the type of information the buffer receives for each type of graphics object you can specify with
///         <i>hgdiobj</i>. <table> <tr> <th>Object type</th> <th>Data written to buffer</th> </tr> <tr> <td width="40%"><a
///         id="HBITMAP"></a><a id="hbitmap"></a><dl> <dt><b><b>HBITMAP</b></b></dt> </dl> </td> <td width="60%"> BITMAP
///         </td> </tr> <tr> <td width="40%"><a id="HBITMAP_returned_from_a_call_to_CreateDIBSection"></a><a
///         id="hbitmap_returned_from_a_call_to_createdibsection"></a><a
///         id="HBITMAP_RETURNED_FROM_A_CALL_TO_CREATEDIBSECTION"></a><dl> <dt><b><b>HBITMAP</b> returned from a call to
///         CreateDIBSection</b></dt> </dl> </td> <td width="60%"> DIBSECTION, if <i>cbBuffer</i> is set to<code> sizeof
///         (DIBSECTION)</code>, or BITMAP, if <i>cbBuffer</i> is set to <code>sizeof (BITMAP)</code>. </td> </tr> <tr> <td
///         width="40%"><a id="HPALETTE"></a><a id="hpalette"></a><dl> <dt><b><b>HPALETTE</b></b></dt> </dl> </td> <td
///         width="60%"> A <b>WORD</b> count of the number of entries in the logical palette </td> </tr> <tr> <td
///         width="40%"><a id="HPEN_returned_from_a_call_to_ExtCreatePen"></a><a
///         id="hpen_returned_from_a_call_to_extcreatepen"></a><a id="HPEN_RETURNED_FROM_A_CALL_TO_EXTCREATEPEN"></a><dl>
///         <dt><b><b>HPEN</b> returned from a call to ExtCreatePen</b></dt> </dl> </td> <td width="60%"> EXTLOGPEN </td>
///         </tr> <tr> <td width="40%"><a id="HPEN"></a><a id="hpen"></a><dl> <dt><b><b>HPEN</b></b></dt> </dl> </td> <td
///         width="60%"> LOGPEN </td> </tr> <tr> <td width="40%"><a id="HBRUSH"></a><a id="hbrush"></a><dl>
///         <dt><b><b>HBRUSH</b></b></dt> </dl> </td> <td width="60%"> LOGBRUSH </td> </tr> <tr> <td width="40%"><a
///         id="HFONT"></a><a id="hfont"></a><dl> <dt><b><b>HFONT</b></b></dt> </dl> </td> <td width="60%"> LOGFONT </td>
///         </tr> </table> If the <i>lpvObject</i> parameter is <b>NULL</b>, the function return value is the number of bytes
///         required to store the information it writes to the buffer for the specified graphics object. The address of
///         <i>lpvObject</i> must be on a 4-byte boundary; otherwise, <b>GetObject</b> fails.
///Returns:
///    If the function succeeds, and <i>lpvObject</i> is a valid pointer, the return value is the number of bytes stored
///    into the buffer. If the function succeeds, and <i>lpvObject</i> is <b>NULL</b>, the return value is the number of
///    bytes required to hold the information the function would store into the buffer. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
int GetObjectW(HANDLE h, int c, char* pv);

///The <b>MoveToEx</b> function updates the current position to the specified point and optionally returns the previous
///position.
///Params:
///    hdc = Handle to a device context.
///    x = Specifies the x-coordinate, in logical units, of the new position, in logical units.
///    y = Specifies the y-coordinate, in logical units, of the new position, in logical units.
///    lppt = Pointer to a POINT structure that receives the previous current position. If this parameter is a <b>NULL</b>
///           pointer, the previous position is not returned.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL MoveToEx(HDC hdc, int x, int y, POINT* lppt);

///The <b>TextOut</b> function writes a character string at the specified location, using the currently selected font,
///background color, and text color.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical coordinates, of the reference point that the system uses to align the string.
///    y = The y-coordinate, in logical coordinates, of the reference point that the system uses to align the string.
///    lpString = A pointer to the string to be drawn. The string does not need to be zero-terminated, because <i>cchString</i>
///               specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>, in characters.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL TextOutA(HDC hdc, int x, int y, const(char)* lpString, int c);

///The <b>TextOut</b> function writes a character string at the specified location, using the currently selected font,
///background color, and text color.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical coordinates, of the reference point that the system uses to align the string.
///    y = The y-coordinate, in logical coordinates, of the reference point that the system uses to align the string.
///    lpString = A pointer to the string to be drawn. The string does not need to be zero-terminated, because <i>cchString</i>
///               specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>, in characters.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL TextOutW(HDC hdc, int x, int y, const(wchar)* lpString, int c);

///The <b>ExtTextOut</b> function draws text using the currently selected font, background color, and text color. You
///can optionally provide dimensions to be used for clipping, opaquing, or both.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical coordinates, of the reference point used to position the string.
///    y = The y-coordinate, in logical coordinates, of the reference point used to position the string.
///    options = Specifies how to use the application-defined rectangle. This parameter can be one or more of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ETO_CLIPPED"></a><a
///              id="eto_clipped"></a><dl> <dt><b>ETO_CLIPPED</b></dt> </dl> </td> <td width="60%"> The text will be clipped to
///              the rectangle. </td> </tr> <tr> <td width="40%"><a id="ETO_GLYPH_INDEX"></a><a id="eto_glyph_index"></a><dl>
///              <dt><b>ETO_GLYPH_INDEX</b></dt> </dl> </td> <td width="60%"> The <i>lpString</i> array refers to an array
///              returned from GetCharacterPlacement and should be parsed directly by GDI as no further language-specific
///              processing is required. Glyph indexing only applies to TrueType fonts, but the flag can be used for bitmap and
///              vector fonts to indicate that no further language processing is necessary and GDI should process the string
///              directly. Note that all glyph indexes are 16-bit values even though the string is assumed to be an array of 8-bit
///              values for raster fonts. For ExtTextOutW, the glyph indexes are saved to a metafile. However, to display the
///              correct characters the metafile must be played back using the same font. For ExtTextOutA, the glyph indexes are
///              not saved. </td> </tr> <tr> <td width="40%"><a id="ETO_IGNORELANGUAGE"></a><a id="eto_ignorelanguage"></a><dl>
///              <dt><b>ETO_IGNORELANGUAGE</b></dt> </dl> </td> <td width="60%"> Reserved for system use. If an application sets
///              this flag, it loses international scripting support and in some cases it may display no text at all. </td> </tr>
///              <tr> <td width="40%"><a id="ETO_NUMERICSLATIN"></a><a id="eto_numericslatin"></a><dl>
///              <dt><b>ETO_NUMERICSLATIN</b></dt> </dl> </td> <td width="60%"> To display numbers, use European digits. </td>
///              </tr> <tr> <td width="40%"><a id="ETO_NUMERICSLOCAL"></a><a id="eto_numericslocal"></a><dl>
///              <dt><b>ETO_NUMERICSLOCAL</b></dt> </dl> </td> <td width="60%"> To display numbers, use digits appropriate to the
///              locale. </td> </tr> <tr> <td width="40%"><a id="ETO_OPAQUE"></a><a id="eto_opaque"></a><dl>
///              <dt><b>ETO_OPAQUE</b></dt> </dl> </td> <td width="60%"> The current background color should be used to fill the
///              rectangle. </td> </tr> <tr> <td width="40%"><a id="ETO_PDY"></a><a id="eto_pdy"></a><dl> <dt><b>ETO_PDY</b></dt>
///              </dl> </td> <td width="60%"> When this is set, the array pointed to by <i>lpDx</i> contains pairs of values. The
///              first value of each pair is, as usual, the distance between origins of adjacent character cells, but the second
///              value is the displacement along the vertical direction of the font. </td> </tr> <tr> <td width="40%"><a
///              id="ETO_RTLREADING"></a><a id="eto_rtlreading"></a><dl> <dt><b>ETO_RTLREADING</b></dt> </dl> </td> <td
///              width="60%"> <b>Middle East language edition of Windows:</b> If this value is specified and a Hebrew or Arabic
///              font is selected into the device context, the string is output using right-to-left reading order. If this value
///              is not specified, the string is output in left-to-right order. The same effect can be achieved by setting the
///              TA_RTLREADING value in SetTextAlign. This value is preserved for backward compatibility. </td> </tr> </table> The
///              ETO_GLYPH_INDEX and ETO_RTLREADING values cannot be used together. Because ETO_GLYPH_INDEX implies that all
///              language processing has been completed, the function ignores the ETO_RTLREADING flag if also specified.
///    lprect = A pointer to an optional RECT structure that specifies the dimensions, in logical coordinates, of a rectangle
///             that is used for clipping, opaquing, or both.
///    lpString = A pointer to a string that specifies the text to be drawn. The string does not need to be zero-terminated, since
///               <i>cbCount</i> specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>. This value may not exceed 8192.
///    lpDx = A pointer to an optional array of values that indicate the distance between origins of adjacent character cells.
///           For example, lpDx[<i>i</i>] logical units separate the origins of character cell <i>i</i> and character cell
///           <i>i</i> + 1.
///Returns:
///    If the string is drawn, the return value is nonzero. However, if the ANSI version of <b>ExtTextOut</b> is called
///    with ETO_GLYPH_INDEX, the function returns <b>TRUE</b> even though the function does nothing. If the function
///    fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ExtTextOutA(HDC hdc, int x, int y, uint options, const(RECT)* lprect, const(char)* lpString, uint c, 
                 char* lpDx);

///The <b>ExtTextOut</b> function draws text using the currently selected font, background color, and text color. You
///can optionally provide dimensions to be used for clipping, opaquing, or both.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical coordinates, of the reference point used to position the string.
///    y = The y-coordinate, in logical coordinates, of the reference point used to position the string.
///    options = Specifies how to use the application-defined rectangle. This parameter can be one or more of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ETO_CLIPPED"></a><a
///              id="eto_clipped"></a><dl> <dt><b>ETO_CLIPPED</b></dt> </dl> </td> <td width="60%"> The text will be clipped to
///              the rectangle. </td> </tr> <tr> <td width="40%"><a id="ETO_GLYPH_INDEX"></a><a id="eto_glyph_index"></a><dl>
///              <dt><b>ETO_GLYPH_INDEX</b></dt> </dl> </td> <td width="60%"> The <i>lpString</i> array refers to an array
///              returned from GetCharacterPlacement and should be parsed directly by GDI as no further language-specific
///              processing is required. Glyph indexing only applies to TrueType fonts, but the flag can be used for bitmap and
///              vector fonts to indicate that no further language processing is necessary and GDI should process the string
///              directly. Note that all glyph indexes are 16-bit values even though the string is assumed to be an array of 8-bit
///              values for raster fonts. For ExtTextOutW, the glyph indexes are saved to a metafile. However, to display the
///              correct characters the metafile must be played back using the same font. For ExtTextOutA, the glyph indexes are
///              not saved. </td> </tr> <tr> <td width="40%"><a id="ETO_IGNORELANGUAGE"></a><a id="eto_ignorelanguage"></a><dl>
///              <dt><b>ETO_IGNORELANGUAGE</b></dt> </dl> </td> <td width="60%"> Reserved for system use. If an application sets
///              this flag, it loses international scripting support and in some cases it may display no text at all. </td> </tr>
///              <tr> <td width="40%"><a id="ETO_NUMERICSLATIN"></a><a id="eto_numericslatin"></a><dl>
///              <dt><b>ETO_NUMERICSLATIN</b></dt> </dl> </td> <td width="60%"> To display numbers, use European digits. </td>
///              </tr> <tr> <td width="40%"><a id="ETO_NUMERICSLOCAL"></a><a id="eto_numericslocal"></a><dl>
///              <dt><b>ETO_NUMERICSLOCAL</b></dt> </dl> </td> <td width="60%"> To display numbers, use digits appropriate to the
///              locale. </td> </tr> <tr> <td width="40%"><a id="ETO_OPAQUE"></a><a id="eto_opaque"></a><dl>
///              <dt><b>ETO_OPAQUE</b></dt> </dl> </td> <td width="60%"> The current background color should be used to fill the
///              rectangle. </td> </tr> <tr> <td width="40%"><a id="ETO_PDY"></a><a id="eto_pdy"></a><dl> <dt><b>ETO_PDY</b></dt>
///              </dl> </td> <td width="60%"> When this is set, the array pointed to by <i>lpDx</i> contains pairs of values. The
///              first value of each pair is, as usual, the distance between origins of adjacent character cells, but the second
///              value is the displacement along the vertical direction of the font. </td> </tr> <tr> <td width="40%"><a
///              id="ETO_RTLREADING"></a><a id="eto_rtlreading"></a><dl> <dt><b>ETO_RTLREADING</b></dt> </dl> </td> <td
///              width="60%"> <b>Middle East language edition of Windows:</b> If this value is specified and a Hebrew or Arabic
///              font is selected into the device context, the string is output using right-to-left reading order. If this value
///              is not specified, the string is output in left-to-right order. The same effect can be achieved by setting the
///              TA_RTLREADING value in SetTextAlign. This value is preserved for backward compatibility. </td> </tr> </table> The
///              ETO_GLYPH_INDEX and ETO_RTLREADING values cannot be used together. Because ETO_GLYPH_INDEX implies that all
///              language processing has been completed, the function ignores the ETO_RTLREADING flag if also specified.
///    lprect = A pointer to an optional RECT structure that specifies the dimensions, in logical coordinates, of a rectangle
///             that is used for clipping, opaquing, or both.
///    lpString = A pointer to a string that specifies the text to be drawn. The string does not need to be zero-terminated, since
///               <i>cbCount</i> specifies the length of the string.
///    c = The length of the string pointed to by <i>lpString</i>. This value may not exceed 8192.
///    lpDx = A pointer to an optional array of values that indicate the distance between origins of adjacent character cells.
///           For example, lpDx[<i>i</i>] logical units separate the origins of character cell <i>i</i> and character cell
///           <i>i</i> + 1.
///Returns:
///    If the string is drawn, the return value is nonzero. However, if the ANSI version of <b>ExtTextOut</b> is called
///    with ETO_GLYPH_INDEX, the function returns <b>TRUE</b> even though the function does nothing. If the function
///    fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ExtTextOutW(HDC hdc, int x, int y, uint options, const(RECT)* lprect, const(wchar)* lpString, uint c, 
                 char* lpDx);

///The <b>PolyTextOut</b> function draws several strings using the font and text colors currently selected in the
///specified device context.
///Params:
///    hdc = A handle to the device context.
///    ppt = A pointer to an array of POLYTEXT structures describing the strings to be drawn. The array contains one structure
///          for each string to be drawn.
///    nstrings = The number of POLYTEXT structures in the <i>pptxt</i> array.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolyTextOutA(HDC hdc, char* ppt, int nstrings);

///The <b>PolyTextOut</b> function draws several strings using the font and text colors currently selected in the
///specified device context.
///Params:
///    hdc = A handle to the device context.
///    ppt = A pointer to an array of POLYTEXT structures describing the strings to be drawn. The array contains one structure
///          for each string to be drawn.
///    nstrings = The number of POLYTEXT structures in the <i>pptxt</i> array.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolyTextOutW(HDC hdc, char* ppt, int nstrings);

///The <b>CreatePolygonRgn</b> function creates a polygonal region.
///Params:
///    pptl = A pointer to an array of POINT structures that define the vertices of the polygon in logical units. The polygon
///           is presumed closed. Each vertex can be specified only once.
///    cPoint = The number of points in the array.
///    iMode = The fill mode used to determine which pixels are in the region. This parameter can be one of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ALTERNATE"></a><a
///            id="alternate"></a><dl> <dt><b>ALTERNATE</b></dt> </dl> </td> <td width="60%"> Selects alternate mode (fills area
///            between odd-numbered and even-numbered polygon sides on each scan line). </td> </tr> <tr> <td width="40%"><a
///            id="WINDING"></a><a id="winding"></a><dl> <dt><b>WINDING</b></dt> </dl> </td> <td width="60%"> Selects winding
///            mode (fills any region with a nonzero winding value). </td> </tr> </table> For more information about these
///            modes, see the SetPolyFillMode function.
///Returns:
///    If the function succeeds, the return value is the handle to the region. If the function fails, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
HRGN CreatePolygonRgn(char* pptl, int cPoint, int iMode);

///The <b>DPtoLP</b> function converts device coordinates into logical coordinates. The conversion depends on the
///mapping mode of the device context, the settings of the origins and extents for the window and viewport, and the
///world transformation.
///Params:
///    hdc = A handle to the device context.
///    lppt = A pointer to an array of POINT structures. The x- and y-coordinates contained in each <b>POINT</b> structure will
///           be transformed.
///    c = The number of points in the array.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL DPtoLP(HDC hdc, char* lppt, int c);

///The <b>LPtoDP</b> function converts logical coordinates into device coordinates. The conversion depends on the
///mapping mode of the device context, the settings of the origins and extents for the window and viewport, and the
///world transformation.
///Params:
///    hdc = A handle to the device context.
///    lppt = A pointer to an array of POINT structures. The x-coordinates and y-coordinates contained in each of the
///           <b>POINT</b> structures will be transformed.
///    c = The number of points in the array.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL LPtoDP(HDC hdc, char* lppt, int c);

///The <b>Polygon</b> function draws a polygon consisting of two or more vertices connected by straight lines. The
///polygon is outlined by using the current pen and filled by using the current brush and polygon fill mode.
///Params:
///    hdc = A handle to the device context.
///    apt = A pointer to an array of POINT structures that specify the vertices of the polygon, in logical coordinates.
///    cpt = The number of vertices in the array. This value must be greater than or equal to 2.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL Polygon(HDC hdc, char* apt, int cpt);

///The <b>Polyline</b> function draws a series of line segments by connecting the points in the specified array.
///Params:
///    hdc = A handle to a device context.
///    apt = A pointer to an array of POINT structures, in logical units.
///    cpt = The number of points in the array. This number must be greater than or equal to two.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL Polyline(HDC hdc, char* apt, int cpt);

///The <b>PolyBezier</b> function draws one or more Bézier curves.
///Params:
///    hdc = A handle to a device context.
///    apt = A pointer to an array of POINT structures that contain the endpoints and control points of the curve(s), in
///          logical units.
///    cpt = The number of points in the <i>lppt</i> array. This value must be one more than three times the number of curves
///          to be drawn, because each Bézier curve requires two control points and an endpoint, and the initial curve
///          requires an additional starting point.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolyBezier(HDC hdc, char* apt, uint cpt);

///The <b>PolyBezierTo</b> function draws one or more Bézier curves.
///Params:
///    hdc = A handle to a device context.
///    apt = A pointer to an array of POINT structures that contains the endpoints and control points, in logical units.
///    cpt = The number of points in the <i>lppt</i> array. This value must be three times the number of curves to be drawn
///          because each Bézier curve requires two control points and an ending point.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolyBezierTo(HDC hdc, char* apt, uint cpt);

///The <b>PolylineTo</b> function draws one or more straight lines.
///Params:
///    hdc = A handle to the device context.
///    apt = A pointer to an array of POINT structures that contains the vertices of the line, in logical units.
///    cpt = The number of points in the array.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL PolylineTo(HDC hdc, char* apt, uint cpt);

///The <b>SetViewportExtEx</b> function sets the horizontal and vertical extents of the viewport for a device context by
///using the specified values.
///Params:
///    hdc = A handle to the device context.
///    x = The horizontal extent, in device units, of the viewport.
///    y = The vertical extent, in device units, of the viewport.
///    lpsz = A pointer to a SIZE structure that receives the previous viewport extents, in device units. If <i>lpSize</i> is
///           <b>NULL</b>, this parameter is not used.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetViewportExtEx(HDC hdc, int x, int y, SIZE* lpsz);

///The <b>SetViewportOrgEx</b> function specifies which device point maps to the window origin (0,0).
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in device units, of the new viewport origin.
///    y = The y-coordinate, in device units, of the new viewport origin.
///    lppt = A pointer to a POINT structure that receives the previous viewport origin, in device coordinates. If
///           <i>lpPoint</i> is <b>NULL</b>, this parameter is not used.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetViewportOrgEx(HDC hdc, int x, int y, POINT* lppt);

///The <b>SetWindowExtEx</b> function sets the horizontal and vertical extents of the window for a device context by
///using the specified values.
///Params:
///    hdc = A handle to the device context.
///    x = The window's horizontal extent in logical units.
///    y = The window's vertical extent in logical units.
///    lpsz = A pointer to a SIZE structure that receives the previous window extents, in logical units. If <i>lpSize</i> is
///           <b>NULL</b>, this parameter is not used.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetWindowExtEx(HDC hdc, int x, int y, SIZE* lpsz);

///The <b>SetWindowOrgEx</b> function specifies which window point maps to the viewport origin (0,0).
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in logical units, of the new window origin.
///    y = The y-coordinate, in logical units, of the new window origin.
///    lppt = A pointer to a POINT structure that receives the previous origin of the window, in logical units. If
///           <i>lpPoint</i> is <b>NULL</b>, this parameter is not used.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetWindowOrgEx(HDC hdc, int x, int y, POINT* lppt);

///The <b>OffsetViewportOrgEx</b> function modifies the viewport origin for a device context using the specified
///horizontal and vertical offsets.
///Params:
///    hdc = A handle to the device context.
///    x = The horizontal offset, in device units.
///    y = The vertical offset, in device units.
///    lppt = A pointer to a POINT structure. The previous viewport origin, in device units, is placed in this structure. If
///           <i>lpPoint</i> is <b>NULL</b>, the previous viewport origin is not returned.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL OffsetViewportOrgEx(HDC hdc, int x, int y, POINT* lppt);

///The <b>OffsetWindowOrgEx</b> function modifies the window origin for a device context using the specified horizontal
///and vertical offsets.
///Params:
///    hdc = A handle to the device context.
///    x = The horizontal offset, in logical units.
///    y = The vertical offset, in logical units.
///    lppt = A pointer to a POINT structure. The logical coordinates of the previous window origin are placed in this
///           structure. If <i>lpPoint</i> is <b>NULL</b>, the previous origin is not returned.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL OffsetWindowOrgEx(HDC hdc, int x, int y, POINT* lppt);

///The <b>ScaleViewportExtEx</b> function modifies the viewport for a device context using the ratios formed by the
///specified multiplicands and divisors.
///Params:
///    hdc = A handle to the device context.
///    xn = The amount by which to multiply the current horizontal extent.
///    dx = The amount by which to divide the current horizontal extent.
///    yn = The amount by which to multiply the current vertical extent.
///    yd = The amount by which to divide the current vertical extent.
///    lpsz = A pointer to a SIZE structure that receives the previous viewport extents, in device units. If <i>lpSize</i> is
///           <b>NULL</b>, this parameter is not used.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ScaleViewportExtEx(HDC hdc, int xn, int dx, int yn, int yd, SIZE* lpsz);

///The <b>ScaleWindowExtEx</b> function modifies the window for a device context using the ratios formed by the
///specified multiplicands and divisors.
///Params:
///    hdc = A handle to the device context.
///    xn = The amount by which to multiply the current horizontal extent.
///    xd = The amount by which to divide the current horizontal extent.
///    yn = The amount by which to multiply the current vertical extent.
///    yd = The amount by which to divide the current vertical extent.
///    lpsz = A pointer to a SIZE structure that receives the previous window extents, in logical units. If <i>lpSize</i> is
///           <b>NULL</b>, this parameter is not used.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL ScaleWindowExtEx(HDC hdc, int xn, int xd, int yn, int yd, SIZE* lpsz);

///The <b>SetBitmapDimensionEx</b> function assigns preferred dimensions to a bitmap. These dimensions can be used by
///applications; however, they are not used by the system.
///Params:
///    hbm = A handle to the bitmap. The bitmap cannot be a DIB-section bitmap.
///    w = The width, in 0.1-millimeter units, of the bitmap.
///    h = The height, in 0.1-millimeter units, of the bitmap.
///    lpsz = A pointer to a SIZE structure to receive the previous dimensions of the bitmap. This pointer can be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetBitmapDimensionEx(HBITMAP hbm, int w, int h, SIZE* lpsz);

///The <b>SetBrushOrgEx</b> function sets the brush origin that GDI assigns to the next brush an application selects
///into the specified device context.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate, in device units, of the new brush origin. If this value is greater than the brush width, its
///        value is reduced using the modulus operator (<i>nXOrg</i> <b>mod</b> brush width).
///    y = The y-coordinate, in device units, of the new brush origin. If this value is greater than the brush height, its
///        value is reduced using the modulus operator (<i>nYOrg</i> <b>mod</b> brush height).
///    lppt = A pointer to a POINT structure that receives the previous brush origin. This parameter can be <b>NULL</b> if the
///           previous brush origin is not required.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL SetBrushOrgEx(HDC hdc, int x, int y, POINT* lppt);

///The <b>GetTextFace</b> function retrieves the typeface name of the font that is selected into the specified device
///context.
///Params:
///    hdc = A handle to the device context.
///    c = The length of the buffer pointed to by <i>lpFaceName</i>. For the ANSI function it is a BYTE count and for the
///        Unicode function it is a WORD count. Note that for the ANSI function, characters in SBCS code pages take one byte
///        each, while most characters in DBCS code pages take two bytes; for the Unicode function, most currently defined
///        Unicode characters (those in the Basic Multilingual Plane (BMP)) are one WORD while Unicode surrogates are two
///        WORDs.
///    lpName = A pointer to the buffer that receives the typeface name. If this parameter is <b>NULL</b>, the function returns
///             the number of characters in the name, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is the number of characters copied to the buffer. If the function
///    fails, the return value is zero.
///    
@DllImport("GDI32")
int GetTextFaceA(HDC hdc, int c, const(char)* lpName);

///The <b>GetTextFace</b> function retrieves the typeface name of the font that is selected into the specified device
///context.
///Params:
///    hdc = A handle to the device context.
///    c = The length of the buffer pointed to by <i>lpFaceName</i>. For the ANSI function it is a BYTE count and for the
///        Unicode function it is a WORD count. Note that for the ANSI function, characters in SBCS code pages take one byte
///        each, while most characters in DBCS code pages take two bytes; for the Unicode function, most currently defined
///        Unicode characters (those in the Basic Multilingual Plane (BMP)) are one WORD while Unicode surrogates are two
///        WORDs.
///    lpName = A pointer to the buffer that receives the typeface name. If this parameter is <b>NULL</b>, the function returns
///             the number of characters in the name, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is the number of characters copied to the buffer. If the function
///    fails, the return value is zero.
///    
@DllImport("GDI32")
int GetTextFaceW(HDC hdc, int c, const(wchar)* lpName);

///The <b>GetKerningPairs</b> function retrieves the character-kerning pairs for the currently selected font for the
///specified device context.
///Params:
///    hdc = A handle to the device context.
///    nPairs = The number of pairs in the <i>lpkrnpair</i> array. If the font has more than <i>nNumPairs</i> kerning pairs, the
///             function returns an error.
///    lpKernPair = A pointer to an array of KERNINGPAIR structures that receives the kerning pairs. The array must contain at least
///                 as many structures as specified by the <i>nNumPairs</i> parameter. If this parameter is <b>NULL</b>, the function
///                 returns the total number of kerning pairs for the font.
///Returns:
///    If the function succeeds, the return value is the number of kerning pairs returned. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
uint GetKerningPairsA(HDC hdc, uint nPairs, char* lpKernPair);

///The <b>GetKerningPairs</b> function retrieves the character-kerning pairs for the currently selected font for the
///specified device context.
///Params:
///    hdc = A handle to the device context.
///    nPairs = The number of pairs in the <i>lpkrnpair</i> array. If the font has more than <i>nNumPairs</i> kerning pairs, the
///             function returns an error.
///    lpKernPair = A pointer to an array of KERNINGPAIR structures that receives the kerning pairs. The array must contain at least
///                 as many structures as specified by the <i>nNumPairs</i> parameter. If this parameter is <b>NULL</b>, the function
///                 returns the total number of kerning pairs for the font.
///Returns:
///    If the function succeeds, the return value is the number of kerning pairs returned. If the function fails, the
///    return value is zero.
///    
@DllImport("GDI32")
uint GetKerningPairsW(HDC hdc, uint nPairs, char* lpKernPair);

///The <b>GetDCOrgEx</b> function retrieves the final translation origin for a specified device context (DC). The final
///translation origin specifies an offset that the system uses to translate device coordinates into client coordinates
///(for coordinates in an application's window).
///Params:
///    hdc = A handle to the DC whose final translation origin is to be retrieved.
///    lppt = A pointer to a POINT structure that receives the final translation origin, in device coordinates.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL GetDCOrgEx(HDC hdc, POINT* lppt);

@DllImport("GDI32")
BOOL FixBrushOrgEx(HDC hdc, int x, int y, POINT* ptl);

///The <b>UnrealizeObject</b> function resets the origin of a brush or resets a logical palette. If the <i>hgdiobj</i>
///parameter is a handle to a brush, <b>UnrealizeObject</b> directs the system to reset the origin of the brush the next
///time it is selected. If the <i>hgdiobj</i> parameter is a handle to a logical palette, <b>UnrealizeObject</b> directs
///the system to realize the palette as though it had not previously been realized. The next time the application calls
///the RealizePalette function for the specified palette, the system completely remaps the logical palette to the system
///palette.
///Params:
///    h = A handle to the logical palette to be reset.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL UnrealizeObject(ptrdiff_t h);

///The <b>GdiFlush</b> function flushes the calling thread's current batch.
///Returns:
///    If all functions in the current batch succeed, the return value is nonzero. If not all functions in the current
///    batch succeed, the return value is zero, indicating that at least one function returned an error.
///    
@DllImport("GDI32")
BOOL GdiFlush();

///The <b>GdiSetBatchLimit</b> function sets the maximum number of function calls that can be accumulated in the calling
///thread's current batch. The system flushes the current batch whenever this limit is exceeded.
///Params:
///    dw = Specifies the batch limit to be set. A value of 0 sets the default limit. A value of 1 disables batching.
///Returns:
///    If the function succeeds, the return value is the previous batch limit. If the function fails, the return value
///    is zero.
///    
@DllImport("GDI32")
uint GdiSetBatchLimit(uint dw);

///The <b>GdiGetBatchLimit</b> function returns the maximum number of function calls that can be accumulated in the
///calling thread's current batch. The system flushes the current batch whenever this limit is exceeded.
///Returns:
///    If the function succeeds, the return value is the batch limit. If the function fails, the return value is zero.
///    
@DllImport("GDI32")
uint GdiGetBatchLimit();

@DllImport("OPENGL32")
uint wglSwapMultipleBuffers(uint param0, const(WGLSWAP)* param1);

///The <b>CreateFontPackage</b> function creates a subset version of a specified TrueType font, typically in order to
///pass it to a printer. In order to allow for the fact that pages later in a document may need characters or glyphs
///that were not used on the first page, this function can create an initial subset font package, then create "Delta"
///font packages that can be merged with the original subset font package, effectively extending it.
///Params:
///    puchSrcBuffer = Points to a buffer containing source TTF or TTC data, describing the font that is to be subsetted.
///    ulSrcBufferSize = Specifies size of *<i>puchSrcBuffer</i>, in bytes.
///    ppuchFontPackageBuffer = Points to a variable of type unsigned char*. The <b>CreateFontPackage</b> function will allocate a buffer
///                             **<i>puchFontPackageBuffer</i>, using <i>lpfnAllocate</i> and <i>lpfnReAllocate</i>. On successful return, the
///                             buffer will contain the subset font or font package. The application is responsible for eventually freeing the
///                             buffer.
///    pulFontPackageBufferSize = Points to an unsigned long, which on successful return will specify the allocated size of buffer
///                               **<i>puchFontPackageBuffer</i>.
///    pulBytesWritten = Points to an unsigned long, which on successful return will specify the number of bytes actually used in buffer
///                      **<i>puchFontPackageBuffer</i>.
///    usFlag = Specifies whether this font should be subsetted, compressed, or both; whether it is a TTF or TTC; and
///             whether*pusSubsetKeepListrepresents character codes or glyph indices. Any combination of the following flags may
///             be specified: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="TTFCFP_FLAGS_SUBSET"></a><a id="ttfcfp_flags_subset"></a><dl> <dt><b>TTFCFP_FLAGS_SUBSET</b></dt> </dl> </td>
///             <td width="60%"> If set, requests subsetting. </td> </tr> <tr> <td width="40%"><a
///             id="TTFCFP_FLAGS_COMPRESS"></a><a id="ttfcfp_flags_compress"></a><dl> <dt><b>TTFCFP_FLAGS_COMPRESS</b></dt> </dl>
///             </td> <td width="60%"> If set, requests compression. The currently shipping version of this function does not do
///             compression. This flag allows for future implementation of this capability, but is currently ignored. </td> </tr>
///             <tr> <td width="40%"><a id="TTFCFP_FLAGS_TTC"></a><a id="ttfcfp_flags_ttc"></a><dl>
///             <dt><b>TTFCFP_FLAGS_TTC</b></dt> </dl> </td> <td width="60%"> If set, specifies that the font in
///             <i>puchSrcBuffer</i> is a TTC; otherwise, it must be a TTF. </td> </tr> <tr> <td width="40%"><a
///             id="TTFCFP_FLAGS_GLYPHLIST"></a><a id="ttfcfp_flags_glyphlist"></a><dl> <dt><b>TTFCFP_FLAGS_GLYPHLIST</b></dt>
///             </dl> </td> <td width="60%"> If set, specifies that*pusSubsetKeepListis a list of glyph indices; otherwise, it
///             must be a list of character codes. </td> </tr> </table>
///    usTTCIndex = The zero based TTC Index; only used if TTFCFP_FLAGS_TTC is set in <i>usFlags</i>.
///    usSubsetFormat = The format of the file to create. Select one of these values; they cannot be combined. <table> <tr>
///                     <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTFCFP_SUBSET"></a><a
///                     id="ttfcfp_subset"></a><dl> <dt><b>TTFCFP_SUBSET</b></dt> </dl> </td> <td width="60%"> Create a standalone Subset
///                     font that cannot be merged with later. </td> </tr> <tr> <td width="40%"><a id="TTFCFP_SUBSET1"></a><a
///                     id="ttfcfp_subset1"></a><dl> <dt><b>TTFCFP_SUBSET1</b></dt> </dl> </td> <td width="60%"> Create a Subset font
///                     package that can be merged with later. </td> </tr> <tr> <td width="40%"><a id="TTFCFP_DELTA"></a><a
///                     id="ttfcfp_delta"></a><dl> <dt><b>TTFCFP_DELTA</b></dt> </dl> </td> <td width="60%"> Create a Delta font package
///                     that can merge with a previous subset font. </td> </tr> </table>
///    usSubsetLanguage = The language in the Name table to retain. If Set to 0, all languages will be retained. Used only for initial
///                       subsetting: that is, used only if <i>usSubsetFormat</i> is either TTFCFP_SUBSET or TTFCFP_SUBSET1, and the
///                       TTFCFP_FLAGS_SUBSET flag is set in <i>usFlags</i>.
///    usSubsetPlatform = In conjunction with <i>usSubsetEncoding</i>, specifies which CMAP to use. Used only if *<i>pusSubsetKeepList</i>
///                       is a list of characters: that is, used only if TTFCFP_FLAGS_GLYPHLIST is not set in <i>usFlags</i>. In that case,
///                       by this CMAP subtable is applied to <i>pusSubsetKeepList</i> to create a list of glyphs to retain in the output
///                       font or font package. If used, this must take one of the following values; they cannot be combined: <table> <tr>
///                       <th>Value </th> <th>Meaning </th> </tr> <tr> <td width="40%"><a id="TTFCFP_UNICODE_PLATFORMID"></a><a
///                       id="ttfcfp_unicode_platformid"></a><dl> <dt><b>TTFCFP_UNICODE_PLATFORMID</b></dt> </dl> </td> <td
///                       width="60%"></td> </tr> <tr> <td width="40%"><a id="TTFCFP_APPLE_PLATFORMID"></a><a
///                       id="ttfcfp_apple_platformid"></a><dl> <dt><b>TTFCFP_APPLE_PLATFORMID</b></dt> </dl> </td> <td width="60%"></td>
///                       </tr> <tr> <td width="40%"><a id="TTFCFP_ISO_PLATFORMID"></a><a id="ttfcfp_iso_platformid"></a><dl>
///                       <dt><b>TTFCFP_ISO_PLATFORMID</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a
///                       id="TTFCFP_MS_PLATFORMID"></a><a id="ttfcfp_ms_platformid"></a><dl> <dt><b>TTFCFP_MS_PLATFORMID</b></dt> </dl>
///                       </td> <td width="60%"></td> </tr> </table>
///    usSubsetEncoding = In conjunction with <i>usSubsetPlatform</i>, specifies which CMAP to use. Used only if *<i>pusSubsetKeepList</i>
///                       is a list of characters: that is, used only if TTFCFP_FLAGS_GLYPHLIST is not set in <i>usFlags</i>. If used, this
///                       must take one of the following values; they cannot be combined: <table> <tr> <th>Value</th> <th>Meaning</th>
///                       </tr> <tr> <td width="40%"><a id="TTFCFP_STD_MAC_CHAR_SET"></a><a id="ttfcfp_std_mac_char_set"></a><dl>
///                       <dt><b>TTFCFP_STD_MAC_CHAR_SET</b></dt> </dl> </td> <td width="60%"> Can be used only if <i>usSubsetPlatform</i>
///                       == TTFCFP_APPLE_PLATFORMID. </td> </tr> <tr> <td width="40%"><a id="TTFCFP_SYMBOL_CHAR_SET"></a><a
///                       id="ttfcfp_symbol_char_set"></a><dl> <dt><b>TTFCFP_SYMBOL_CHAR_SET</b></dt> </dl> </td> <td width="60%"> Can be
///                       used only if <i>usSubsetPlatform</i> == TTFSUB_MS_PLATFORMID. </td> </tr> <tr> <td width="40%"><a
///                       id="TTFCFP_UNICODE_CHAR_SET"></a><a id="ttfcfp_unicode_char_set"></a><dl> <dt><b>TTFCFP_UNICODE_CHAR_SET</b></dt>
///                       </dl> </td> <td width="60%"> Can be used only if <i>usSubsetPlatform</i> == TTFSUB_MS_PLATFORMID. </td> </tr>
///                       <tr> <td width="40%"><a id="TTFCFP_DONT_CARE"></a><a id="ttfcfp_dont_care"></a><dl>
///                       <dt><b>TTFCFP_DONT_CARE</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
///    pusSubsetKeepList = Points to an array of integers which comprise a list of character codes or glyph indices that should be retained
///                        in the output font or font package. If this list contains character codes (that is, if if TTFCFP_FLAGS_GLYPHLIST
///                        is not set in <i>usFlags</i>), this list may be either Unicode or some other type of encoding, depending on the
///                        Platform-Encoding CMAP specified by <i>usSubsetPlatform</i> and <i>usSubsetEncoding</i>.
///    usSubsetListCount = The number of elements in the list *<i>pusSubsetKeepList</i>.
///    lpfnAllocate = The callback function to allocate initial memory for <i>puchFontPackageBuffer</i> and for temporary buffers.
///    lpfnReAllocate = The callback function to reallocate memory for <i>puchFontPackageBuffer</i> and for temporary buffers.
///    lpfnFree = The callback function to free up memory allocated by <i>lpfnAllocate</i> and <i>lpfnReAllocate</i>.
///    lpvReserved = Must be set to <b>NULL</b>.
///Returns:
///    If the function is successful, returns zero. Otherwise, returns a nonzero value. See Font-Package Function Error
///    Messages for possible error returns.
///    
@DllImport("FONTSUB")
uint CreateFontPackage(const(ubyte)* puchSrcBuffer, const(uint) ulSrcBufferSize, ubyte** ppuchFontPackageBuffer, 
                       uint* pulFontPackageBufferSize, uint* pulBytesWritten, const(ushort) usFlag, 
                       const(ushort) usTTCIndex, const(ushort) usSubsetFormat, const(ushort) usSubsetLanguage, 
                       const(ushort) usSubsetPlatform, const(ushort) usSubsetEncoding, 
                       const(ushort)* pusSubsetKeepList, const(ushort) usSubsetListCount, CFP_ALLOCPROC lpfnAllocate, 
                       CFP_REALLOCPROC lpfnReAllocate, CFP_FREEPROC lpfnFree, void* lpvReserved);

///The <b>MergeFontPackage</b> function manipulates fonts created by CreateFontPackage. It is slightly more flexible
///than its name might suggest: it can appropriately handle all of the subset fonts and font packages created by
///<b>CreateFontPackage</b>. It can turn a font package into a working font, and it can merge a Delta font package into
///an appropriately prepared working font. Typically, CreateFontPackage creates subset fonts and font packages to pass
///to a printer or print server; <b>MergeFontPackage</b> runs on that printer or print server.
///Params:
///    puchMergeFontBuffer = A pointer to a buffer containing a font to merge with. This is used only when <i>usMode</i> is TTFMFP_DELTA.
///    ulMergeFontBufferSize = Specifies size of *<i>puchMergeFontBuffer</i>, in bytes.
///    puchFontPackageBuffer = A pointer to a to buffer containing a font package.
///    ulFontPackageBufferSize = Specifies size of *<i>puchMergeFontBuffer</i>, in bytes.
///    ppuchDestBuffer = A pointer to a variable of type unsigned char*. The <b>MergeFontPackage</b> function will allocate a buffer
///                      **<i>ppuchDestBuffer</i>, using <i>lpfnAllocate</i> and <i>lpfnReAllocate</i>. On successful return, that buffer
///                      will contain the resulting merged or expanded font. The application is responsible for eventually freeing that
///                      buffer.
///    pulDestBufferSize = Points to an unsigned long, which on successful return will specify the allocated size of buffer
///                        **<i>ppuchDestBuffer</i>.
///    pulBytesWritten = Points to an unsigned long, which on successful return will specify the number of bytes actually used in buffer
///                      **<i>ppuchDestBuffer</i>.
///    usMode = Specifies what kind of process to perform. Select one of these values; they cannot be combined. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTFMFP_SUBSET"></a><a
///             id="ttfmfp_subset"></a><dl> <dt><b>TTFMFP_SUBSET</b></dt> </dl> </td> <td width="60%"> Copies a simple working
///             font; see remarks below. <i>puchMergeFontBuffer</i> will be ignored; <i>puchFontPackageBuffer</i> should contain
///             a working font created by CreateFontPackage with <i>usSubsetFormat</i> set to TTFCFP_SUBSET; this working font
///             will simply be copied to <i>ppuchDestBuffer</i>. </td> </tr> <tr> <td width="40%"><a id="TTFMFP_SUBSET1"></a><a
///             id="ttfmfp_subset1"></a><dl> <dt><b>TTFMFP_SUBSET1</b></dt> </dl> </td> <td width="60%"> Turns a font package
///             into a mergeable working font; see remarks below. <i>puchMergeFontBuffer</i> will be ignored;
///             <i>puchFontPackageBuffer</i> should contain a mergeable working font created by CreateFontPackage with
///             <i>usSubsetFormat</i> set to TTFCFP_SUBSET1. The result in **<i>ppuchDestBuffer</i> will be a working font that
///             may be merged with later. </td> </tr> <tr> <td width="40%"><a id="TTFMFP_DELTA"></a><a id="ttfmfp_delta"></a><dl>
///             <dt><b>TTFMFP_DELTA</b></dt> </dl> </td> <td width="60%"> Merges a Delta font package into a mergeable working
///             font; see remarks below. *<i>puchFontPackageBuffer</i> should contain a font package created by CreateFontPackage
///             with <i>usSubsetFormat</i> set to TTFCFP_DELTA and <i>puchMergeFontBuffer</i> should contain a font package
///             created by a prior call to <b>MergeFontPackage</b> with <i>usMode</i> set to TTFMFP_SUBSET1 or TTFMFP_DELTA. The
///             resulting merged font in **<i>ppuchDestBuffer</i> will be a working font that may be merged with later. </td>
///             </tr> </table>
///    lpfnAllocate = The callback function to allocate initial memory for <i>ppuchDestBuffer</i> and for temporary buffers.
///    lpfnReAllocate = The callback function to reallocate memory for <i>ppuchDestBuffer</i> and for temporary buffers.
///    lpfnFree = The callback function to free up memory allocated by <i>lpfnAllocate</i> and <i>lpfnReAllocate</i>.
///    lpvReserved = Must be set to <b>NULL</b>.
///Returns:
///    If the function is successful, returns zero. Otherwise, returns a nonzero value. See Font-Package Function Error
///    Messages for possible error returns.
///    
@DllImport("FONTSUB")
uint MergeFontPackage(const(ubyte)* puchMergeFontBuffer, const(uint) ulMergeFontBufferSize, 
                      const(ubyte)* puchFontPackageBuffer, const(uint) ulFontPackageBufferSize, 
                      ubyte** ppuchDestBuffer, uint* pulDestBufferSize, uint* pulBytesWritten, const(ushort) usMode, 
                      CFP_ALLOCPROC lpfnAllocate, CFP_REALLOCPROC lpfnReAllocate, CFP_FREEPROC lpfnFree, 
                      void* lpvReserved);

///Creates a font structure containing the subsetted wide-character (16-bit) font. The current font of the device
///context (hDC) provides the font information. This function passes the data to a client-defined callback routine for
///insertion into the document stream.
///Params:
///    hDC = Device context handle.
///    ulFlags = Flag specifying the embedding request. This flag can have zero or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTEMBED_EMBEDEUDC"></a><a
///              id="ttembed_embedeudc"></a><dl> <dt><b>TTEMBED_EMBEDEUDC</b></dt> </dl> </td> <td width="60%"> Include the
///              associated EUDC font file data with the font structure. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_RAW"></a><a id="ttembed_raw"></a><dl> <dt><b>TTEMBED_RAW</b></dt> </dl> </td> <td width="60%"> Return
///              a font structure containing the full character set, non-compressed. This is the default behavior of the function.
///              </td> </tr> <tr> <td width="40%"><a id="TTEMBED_SUBSET"></a><a id="ttembed_subset"></a><dl>
///              <dt><b>TTEMBED_SUBSET</b></dt> </dl> </td> <td width="60%"> Return a subsetted font containing only the glyphs
///              indicated by the <i>pusCharCodeSet</i> or <i>pulCharCodeSet</i> parameter. These character codes must be denoted
///              as 16-bit or UCS-4 characters, as appropriate for the parameter. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_TTCOMPRESSED"></a><a id="ttembed_ttcompressed"></a><dl> <dt><b>TTEMBED_TTCOMPRESSED</b></dt> </dl>
///              </td> <td width="60%"> Return a compressed font structure. </td> </tr> </table>
///    ulCharSet = Flag specifying the character set of the font to be embedded. This flag can have one of the following values.
///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CHARSET_UNICODE"></a><a
///                id="charset_unicode"></a><dl> <dt><b>CHARSET_UNICODE</b></dt> </dl> </td> <td width="60%"> Unicode character set,
///                requiring 16-bit character encoding. </td> </tr> <tr> <td width="40%"><a id="CHARSET_SYMBOL"></a><a
///                id="charset_symbol"></a><dl> <dt><b>CHARSET_SYMBOL</b></dt> </dl> </td> <td width="60%"> Symbol character set,
///                requiring 16-bit character encoding. </td> </tr> </table>
///    pulPrivStatus = Pointer to flag indicating embedding privileges of the font. This flag can have one of the following values. This
///                    function returns the least restrictive license granted. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                    <td width="40%"><a id="EMBED_PREVIEWPRINT"></a><a id="embed_previewprint"></a><dl>
///                    <dt><b>EMBED_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and Print Embedding. </td> </tr> <tr> <td
///                    width="40%"><a id="EMBED_EDITABLE"></a><a id="embed_editable"></a><dl> <dt><b>EMBED_EDITABLE</b></dt> </dl> </td>
///                    <td width="60%"> Editable Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_INSTALLABLE"></a><a
///                    id="embed_installable"></a><dl> <dt><b>EMBED_INSTALLABLE</b></dt> </dl> </td> <td width="60%"> Installable
///                    Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_NOEMBEDDING"></a><a id="embed_noembedding"></a><dl>
///                    <dt><b>EMBED_NOEMBEDDING</b></dt> </dl> </td> <td width="60%"> Restricted License Embedding. </td> </tr> </table>
///    pulStatus = Pointer to a bitfield containing status information about the embedding request. This field is filled upon
///                completion of this function. No bits are currently defined for this parameter.
///    lpfnWriteToStream = Pointer to the client-defined callback function, which writes the font structure to the document stream. See
///                        WRITEEMBEDPROC.
///    lpvWriteStream = A token to represent the output stream.
///    pusCharCodeSet = Pointer to the buffer containing the optional Unicode character codes for subsetting. This field is only used for
///                     subsetting a font and is ignored if the <i>ulFlags</i> field does not specify TTEMBED_SUBSET.
///    usCharCodeCount = The number of characters in the list of characters indicated by <i>pusCharCodeSet</i>. This field is only used
///                      for subsetting a font and is ignored if the <i>ulFlags</i> field does not specify TTEMBED_SUBSET.
///    usLanguage = Specifies which language in the name table to keep when subsetting. Set to 0 to keep all languages. This field is
///                 only used for subsetting a font and is ignored if the <i>ulFlags</i> field does not specify TTEMBED_SUBSET.
///    pTTEmbedInfo = Pointer to a TTEMBEDINFO structure containing the URLs from which the embedded font object may be legitimately
///                   referenced. If <i>pTTEmbedInfo</i> is <b>NULL</b>, no URLs will be added to the embedded font object and no URL
///                   checking will occur when the client calls TTLoadEmbeddedFont.
///Returns:
///    If the embedding is successful, returns E_NONE. The font structure is incorporated into the document stream by
///    the client. <i>pulPrivStatus</i> is set, indicating the embedding privileges of the font; and <i>pulStatus</i> is
///    set to provide results of the embedding operation. Otherwise, returns an error code described in
///    Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTEmbedFont(HDC hDC, uint ulFlags, uint ulCharSet, uint* pulPrivStatus, uint* pulStatus, 
                WRITEEMBEDPROC lpfnWriteToStream, void* lpvWriteStream, char* pusCharCodeSet, ushort usCharCodeCount, 
                ushort usLanguage, TTEMBEDINFO* pTTEmbedInfo);

///Creates a font structure containing the subsetted wide-character (16-bit) font. An external file provides the font
///information. This function passes the data to a client-defined callback routine for insertion into the document
///stream.
///Params:
///    hDC = Device context handle.
///    szFontFileName = The font file name and path to embed. This is an ANSI string.
///    usTTCIndex = Zero-based index into the font file (TTC) identifying the physical font to embed. If the file contains a single
///                 font (such as a TTF or OTF outline file), this parameter should be set to 0.
///    ulFlags = Flag specifying the embedding request. This flag can have zero or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTEMBED_EMBEDEUDC"></a><a
///              id="ttembed_embedeudc"></a><dl> <dt><b>TTEMBED_EMBEDEUDC</b></dt> </dl> </td> <td width="60%"> Include the
///              associated EUDC font file data with the font structure. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_RAW"></a><a id="ttembed_raw"></a><dl> <dt><b>TTEMBED_RAW</b></dt> </dl> </td> <td width="60%"> Return
///              a font structure containing the full character set, non-compressed. This is the default behavior of the function.
///              </td> </tr> <tr> <td width="40%"><a id="TTEMBED_SUBSET"></a><a id="ttembed_subset"></a><dl>
///              <dt><b>TTEMBED_SUBSET</b></dt> </dl> </td> <td width="60%"> Return a subsetted font containing only the glyphs
///              indicated by the <i>pusCharCodeSet</i> or <i>pulCharCodeSet</i> parameter. These character codes must be denoted
///              as 16-bit or UCS-4 characters as appropriate for the parameter. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_TTCOMPRESSED"></a><a id="ttembed_ttcompressed"></a><dl> <dt><b>TTEMBED_TTCOMPRESSED</b></dt> </dl>
///              </td> <td width="60%"> Return a compressed font structure. </td> </tr> </table>
///    ulCharSet = Flag specifying the character set of the font to be embedded. This flag can have one of the following values.
///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CHARSET_UNICODE"></a><a
///                id="charset_unicode"></a><dl> <dt><b>CHARSET_UNICODE</b></dt> </dl> </td> <td width="60%"> Unicode character set,
///                requiring 16-bit character encoding. </td> </tr> <tr> <td width="40%"><a id="CHARSET_SYMBOL"></a><a
///                id="charset_symbol"></a><dl> <dt><b>CHARSET_SYMBOL</b></dt> </dl> </td> <td width="60%"> Symbol character set,
///                requiring 16-bit character encoding. </td> </tr> </table>
///    pulPrivStatus = Pointer to flag indicating embedding privileges of the font. This flag can have one of the following values. This
///                    function returns the least restrictive license granted. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                    <td width="40%"><a id="EMBED_PREVIEWPRINT"></a><a id="embed_previewprint"></a><dl>
///                    <dt><b>EMBED_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and Print Embedding. </td> </tr> <tr> <td
///                    width="40%"><a id="EMBED_EDITABLE"></a><a id="embed_editable"></a><dl> <dt><b>EMBED_EDITABLE</b></dt> </dl> </td>
///                    <td width="60%"> Editable Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_INSTALLABLE"></a><a
///                    id="embed_installable"></a><dl> <dt><b>EMBED_INSTALLABLE</b></dt> </dl> </td> <td width="60%"> Installable
///                    Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_NOEMBEDDING"></a><a id="embed_noembedding"></a><dl>
///                    <dt><b>EMBED_NOEMBEDDING</b></dt> </dl> </td> <td width="60%"> Restricted License Embedding. </td> </tr> </table>
///    pulStatus = Pointer to a bitfield containing status information about the embedding request. This field is filled upon
///                completion of this function. No bits are currently defined for this parameter.
///    lpfnWriteToStream = Pointer to the client-defined callback function that writes the font structure to the document stream. See
///                        WRITEEMBEDPROC.
///    lpvWriteStream = A token to represent the output stream.
///    pusCharCodeSet = Pointer to the buffer containing the optional Unicode character codes for subsetting. This field is only used for
///                     subsetting a font and is ignored if theulFlagsfield does not specify TTEMBED_SUBSET.
///    usCharCodeCount = The number of characters in the list of characters indicated by <i>pusCharCodeSet</i>. This field is only used
///                      for subsetting a font and is ignored if the <i>ulFlags</i> field does not specify TTEMBED_SUBSET.
///    usLanguage = Specifies which language in the name table to keep when subsetting. Set to 0 to keep all languages. This field is
///                 only used for subsetting a font and is ignored if the <i>ulFlags</i> field does not specify TTEMBED_SUBSET.
///    pTTEmbedInfo = Pointer to a TTEMBEDINFO structure containing the URLs from which the embedded font object may be legitimately
///                   referenced. If <i>pTTEmbedInfo</i> is <b>NULL</b>, no URLs will be added to the embedded font object and no URL
///                   checking will occur when the client calls the TTLoadEmbeddedFont function.
///Returns:
///    If the embedding is successful, returns E_NONE. The font structure is incorporated into the document stream by
///    the client. <i>pulPrivStatus</i> is set, indicating the embedding privileges of the font; and <i>pulStatus</i> is
///    set to provide results of the embedding operation. Otherwise, returns an error code described in
///    Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTEmbedFontFromFileA(HDC hDC, const(char)* szFontFileName, ushort usTTCIndex, uint ulFlags, uint ulCharSet, 
                         uint* pulPrivStatus, uint* pulStatus, WRITEEMBEDPROC lpfnWriteToStream, 
                         void* lpvWriteStream, char* pusCharCodeSet, ushort usCharCodeCount, ushort usLanguage, 
                         TTEMBEDINFO* pTTEmbedInfo);

///Reads an embedded font from the document stream and installs it. Also allows a client to further restrict embedding
///privileges of the font.
///Params:
///    phFontReference = A pointer to a handle that identifies the installed embedded font. This handle references an internal structure,
///                      not an Hfont.
///    ulFlags = A flag specifying loading and installation options. Currently, this flag can be set to zero or the following
///              value: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTLOAD_PRIVATE"></a><a
///              id="ttload_private"></a><dl> <dt><b>TTLOAD_PRIVATE</b></dt> </dl> </td> <td width="60%"> Load the font so that it
///              is not enumerated to the user. If the font is not installable, it will remain private. </td> </tr> </table>
///    pulPrivStatus = A pointer to flag indicating embedding privileges of the font. This flag is written upon completion of this
///                    function and can have one of the following values. This function returns the least restrictive license granted.
///                    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EMBED_PREVIEWPRINT"></a><a
///                    id="embed_previewprint"></a><dl> <dt><b>EMBED_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and
///                    Print Embedding. The font may be embedded within documents, but must only be installed temporarily on the remote
///                    system. A document containing this type of font can only be opened as read-only. The application must not allow
///                    the user to edit the document. The document can only be viewed and/or printed. </td> </tr> <tr> <td
///                    width="40%"><a id="EMBED_EDITABLE"></a><a id="embed_editable"></a><dl> <dt><b>EMBED_EDITABLE</b></dt> </dl> </td>
///                    <td width="60%"> Editable Embedding. The font may be embedded within documents, but must only be installed
///                    temporarily on the remote system. A document containing this type of font may be opened "read/write," with
///                    editing permitted. </td> </tr> <tr> <td width="40%"><a id="EMBED_INSTALLABLE"></a><a
///                    id="embed_installable"></a><dl> <dt><b>EMBED_INSTALLABLE</b></dt> </dl> </td> <td width="60%"> Installable
///                    Embedding. The font may be embedded and permanently installed on the remote system. The user of the remote system
///                    acquires the identical rights, obligations, and licenses for that font as the original purchaser of the font, and
///                    is subject to the same end-user license agreement, copyright, design patent, and/or trademark as was the original
///                    purchaser. </td> </tr> <tr> <td width="40%"><a id="EMBED_NOEMBEDDING"></a><a id="embed_noembedding"></a><dl>
///                    <dt><b>EMBED_NOEMBEDDING</b></dt> </dl> </td> <td width="60%"> Restricted License Embedding. The font must not be
///                    modified, embedded, or exchanged in any manner without first obtaining permission of the legal owner. </td> </tr>
///                    </table>
///    ulPrivs = A flag indicating a further restriction of embedding privileges, imposed by the client loading the font. This
///              flag must have one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="LICENSE_PREVIEWPRINT"></a><a id="license_previewprint"></a><dl>
///              <dt><b>LICENSE_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and Print Embedding. </td> </tr> <tr>
///              <td width="40%"><a id="LICENSE_EDITABLE"></a><a id="license_editable"></a><dl> <dt><b>LICENSE_EDITABLE</b></dt>
///              </dl> </td> <td width="60%"> Editable Embedding. </td> </tr> <tr> <td width="40%"><a
///              id="LICENSE_INSTALLABLE"></a><a id="license_installable"></a><dl> <dt><b>LICENSE_INSTALLABLE</b></dt> </dl> </td>
///              <td width="60%"> Installable Embedding. </td> </tr> <tr> <td width="40%"><a id="LICENSE_NOEMBEDDING"></a><a
///              id="license_noembedding"></a><dl> <dt><b>LICENSE_NOEMBEDDING</b></dt> </dl> </td> <td width="60%"> Restricted
///              License Embedding. </td> </tr> <tr> <td width="40%"><a id="LICENSE_DEFAULT"></a><a id="license_default"></a><dl>
///              <dt><b>LICENSE_DEFAULT</b></dt> </dl> </td> <td width="60%"> Use default embedding level. </td> </tr> </table>
///    pulStatus = A pointer to a bitfield containing status information about the <b>TTLoadEmbeddedFont</b> request. This field is
///                filled upon completion of this function and can have zero or more of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTLOAD_FONT_SUBSETTED"></a><a
///                id="ttload_font_subsetted"></a><dl> <dt><b>TTLOAD_FONT_SUBSETTED</b></dt> </dl> </td> <td width="60%"> The font
///                loaded is a subset of the original font. </td> </tr> <tr> <td width="40%"><a
///                id="TTLOAD_FONT_IN_SYSSTARTUP"></a><a id="ttload_font_in_sysstartup"></a><dl>
///                <dt><b>TTLOAD_FONT_IN_SYSSTARTUP</b></dt> </dl> </td> <td width="60%"> The font loaded was labeled as installable
///                and has been added to the registry so it will be available upon startup. </td> </tr> </table>
///    lpfnReadFromStream = A pointer to the client-defined callback function that reads the font structure from the document stream.
///    lpvReadStream = A pointer to the stream (font structure).
///    szWinFamilyName = A pointer to the new 16-bit-character Unicode Microsoft Windows family name of the font. Set to <b>NULL</b> to
///                      use existing name. When changing the name of a font upon loading, you must supply both this parameter and the
///                      <i>szMacFamilyName</i> parameter.
///    szMacFamilyName = A pointer to the new 8-bit-character Macintosh family name of the font. Set to <b>NULL</b> to use existing name.
///                      When changing the name of a font upon loading, you must supply both this parameter and the <i>szWinFamilyName</i>
///                      parameter.
///    pTTLoadInfo = A pointer to a TTLOADINFO structure containing the URL from which the embedded font object has been obtained. If
///                  this value does not match one of those contained in the TTEMBEDINFO structure, the font will not load
///                  successfully.
///Returns:
///    If successful, returns E_NONE. If font loading is successful, a font indicated by <i>phFontReference</i> is
///    created from the font structure with the names referenced in <i>szWinFamilyName</i> and <i>szMacFamilyName</i>.
///    <i>pulPrivStatus</i> is set indicating the embedding privileges of the font; and <i>pulStatus</i> may be set
///    indicating status information about the font loading operation. Otherwise, returns an error code described in
///    Embedding Function Error Messages.
///    
@DllImport("t2embed")
int TTLoadEmbeddedFont(HANDLE* phFontReference, uint ulFlags, uint* pulPrivStatus, uint ulPrivs, uint* pulStatus, 
                       READEMBEDPROC lpfnReadFromStream, void* lpvReadStream, const(wchar)* szWinFamilyName, 
                       const(char)* szMacFamilyName, TTLOADINFO* pTTLoadInfo);

///Retrieves information about an embedded font, such as embedding permissions. <b>TTGetEmbeddedFontInfo</b> performs
///the same task as TTLoadEmbeddedFont but does not allocate internal data structures for the embedded font.
///Params:
///    ulFlags = Flags specifying the request. This flag can have zero or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTEMBED_EMBEDEUDC"></a><a
///              id="ttembed_embedeudc"></a><dl> <dt><b>TTEMBED_EMBEDEUDC</b></dt> </dl> </td> <td width="60%"> Include the
///              associated EUDC font file data with the font structure. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_RAW"></a><a id="ttembed_raw"></a><dl> <dt><b>TTEMBED_RAW</b></dt> </dl> </td> <td width="60%"> Return
///              a font structure containing the full character set, non-compressed. This is the default behavior of the function.
///              </td> </tr> <tr> <td width="40%"><a id="TTEMBED_SUBSET"></a><a id="ttembed_subset"></a><dl>
///              <dt><b>TTEMBED_SUBSET</b></dt> </dl> </td> <td width="60%"> Return a subsetted font containing only the glyphs
///              indicated by the <i>pusCharCodeSet</i> or <i>pulCharCodeSet</i> parameter. These character codes must be denoted
///              as 16-bit or UCS-4 characters, as appropriate for the parameter. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_TTCOMPRESSED"></a><a id="ttembed_ttcompressed"></a><dl> <dt><b>TTEMBED_TTCOMPRESSED</b></dt> </dl>
///              </td> <td width="60%"> Return a compressed font structure. </td> </tr> </table>
///    pulPrivStatus = On completion, indicates embedding privileges of the font. A list of possible values follows: <table> <tr>
///                    <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EMBED_PREVIEWPRINT"></a><a
///                    id="embed_previewprint"></a><dl> <dt><b>EMBED_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and
///                    Print Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_EDITABLE"></a><a id="embed_editable"></a><dl>
///                    <dt><b>EMBED_EDITABLE</b></dt> </dl> </td> <td width="60%"> Editable Embedding. </td> </tr> <tr> <td
///                    width="40%"><a id="EMBED_INSTALLABLE"></a><a id="embed_installable"></a><dl> <dt><b>EMBED_INSTALLABLE</b></dt>
///                    </dl> </td> <td width="60%"> Installable Embedding. </td> </tr> <tr> <td width="40%"><a
///                    id="EMBED_NOEMBEDDING"></a><a id="embed_noembedding"></a><dl> <dt><b>EMBED_NOEMBEDDING</b></dt> </dl> </td> <td
///                    width="60%"> Restricted License Embedding. </td> </tr> </table>
///    ulPrivs = Flag indicating a further restriction of embedding privileges, imposed by the client. See TTLoadEmbeddedFont for
///              additional information. This flag must have one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LICENSE_PREVIEWPRINT"></a><a
///              id="license_previewprint"></a><dl> <dt><b>LICENSE_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and
///              Print Embedding. </td> </tr> <tr> <td width="40%"><a id="LICENSE_EDITABLE"></a><a id="license_editable"></a><dl>
///              <dt><b>LICENSE_EDITABLE</b></dt> </dl> </td> <td width="60%"> Editable Embedding. </td> </tr> <tr> <td
///              width="40%"><a id="LICENSE_INSTALLABLE"></a><a id="license_installable"></a><dl>
///              <dt><b>LICENSE_INSTALLABLE</b></dt> </dl> </td> <td width="60%"> Installable Embedding. </td> </tr> <tr> <td
///              width="40%"><a id="LICENSE_NOEMBEDDING"></a><a id="license_noembedding"></a><dl>
///              <dt><b>LICENSE_NOEMBEDDING</b></dt> </dl> </td> <td width="60%"> Restricted License Embedding. </td> </tr> <tr>
///              <td width="40%"><a id="LICENSE_DEFAULT"></a><a id="license_default"></a><dl> <dt><b>LICENSE_DEFAULT</b></dt>
///              </dl> </td> <td width="60%"> Use default embedding level. </td> </tr> </table>
///    pulStatus = Pointer to a bitfield containing status information, and is filled upon completion of this function. The status
///                can be zero or the following value: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="TTLOAD_FONT_SUBSETTED"></a><a id="ttload_font_subsetted"></a><dl> <dt><b>TTLOAD_FONT_SUBSETTED</b></dt> </dl>
///                </td> <td width="60%"> The font loaded is a subset of the original font. </td> </tr> </table>
///    lpfnReadFromStream = [callback] Pointer to the client-defined callback function that reads the font structure from the document
///                         stream.
///    lpvReadStream = Currently undefined. Reserved for a pointer to the stream (font structure).
///    pTTLoadInfo = Pointer to a TTLOADINFO structure containing the URL from which the embedded font object has been obtained.
///Returns:
///    If successful, returns E_NONE. The location referenced by *<i>pulPrivStatus</i> identifies embedding privileges
///    of the font. The location referenced by *<i>pulStatus</i> identifies whether a subset of the font is embedded.
///    Otherwise, returns an error code described in Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTGetEmbeddedFontInfo(uint ulFlags, uint* pulPrivStatus, uint ulPrivs, uint* pulStatus, 
                          READEMBEDPROC lpfnReadFromStream, void* lpvReadStream, TTLOADINFO* pTTLoadInfo);

///Releases memory used by an embedded font, <i>hFontReference</i>. By default, <b>TTDeleteEmbeddedFont</b> also removes
///the installed version of the font from the user's system. When an installable font is loaded, this function still
///must be called to release the memory used by the embedded font structure, but a flag can be specified indicating that
///the font should remain installed on the system.
///Params:
///    hFontReference = Handle identifying font, as provided in the TTLoadEmbeddedFont function.
///    ulFlags = Flag specifying font deletion options. Currently, this flag can be set to zero or the following value: <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTDELETE_DONTREMOVEFONT"></a><a
///              id="ttdelete_dontremovefont"></a><dl> <dt><b>TTDELETE_DONTREMOVEFONT</b></dt> </dl> </td> <td width="60%"> Do not
///              remove the installed font from the system, but release the memory previously occupied by the embedded font
///              structure. </td> </tr> </table>
///    pulStatus = Currently undefined.
///Returns:
///    If successful, <b>TTDeleteEmbeddedFont</b> returns a value of E_NONE. The memory occupied by the embedded font
///    structure is cleared. By default, the font indicated by <i>hFontReference</i> is also permanently removed
///    (uninstalled and deleted) from the system. Otherwise, returns an error code described in Embedding-Function Error
///    Messages.
///    
@DllImport("t2embed")
int TTDeleteEmbeddedFont(HANDLE hFontReference, uint ulFlags, uint* pulStatus);

///Obtains the embedding privileges of a font.
///Params:
///    hDC = Device context handle.
///    pulEmbedType = Pointer to flag indicating embedding privileges of the font. This flag can have one of the following values. This
///                   function returns the least restrictive license granted. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                   <td width="40%"><a id="EMBED_PREVIEWPRINT"></a><a id="embed_previewprint"></a><dl>
///                   <dt><b>EMBED_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and Print Embedding. </td> </tr> <tr> <td
///                   width="40%"><a id="EMBED_EDITABLE"></a><a id="embed_editable"></a><dl> <dt><b>EMBED_EDITABLE</b></dt> </dl> </td>
///                   <td width="60%"> Editable Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_INSTALLABLE"></a><a
///                   id="embed_installable"></a><dl> <dt><b>EMBED_INSTALLABLE</b></dt> </dl> </td> <td width="60%"> Installable
///                   Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_NOEMBEDDING"></a><a id="embed_noembedding"></a><dl>
///                   <dt><b>EMBED_NOEMBEDDING</b></dt> </dl> </td> <td width="60%"> Restricted License Embedding. </td> </tr> </table>
///Returns:
///    If successful, returns E_NONE. This function reads the embedding privileges stored in the font and transfers the
///    privileges to <i>pulPrivStatus</i>. Otherwise, returns an error code described in Embedding-Function Error
///    Messages.
///    
@DllImport("t2embed")
int TTGetEmbeddingType(HDC hDC, uint* pulEmbedType);

///Converts an array of 8-bit character code values to 16-bit Unicode values.
///Params:
///    hDC = A device context handle.
///    pucCharCodes = A pointer to an array of 8-bit character codes to convert to 16-bit Unicode values. Must be set to a non-null
///                   value.
///    ulCharCodeSize = The size of an 8-bit character code array.
///    pusShortCodes = A pointer to an array that will be filled by this function with the Unicode equivalents of the 8-bit values in
///                    the <i>pucCharCodesarray</i>. This parameter must be set to a non-null value.
///    ulShortCodeSize = The size, in wide characters, of the character code array.
///    ulFlags = This parameter is currently unused.
///Returns:
///    If successful, returns E_NONE. Array *<i>pusShortCodes</i> is filled with 16-bit Unicode values that correspond
///    to the 8-bit character codes in *<i>pusCharCodes</i>.<i>ulShortCodeSize</i> contains the size, in wide
///    characters, of *<i>pusShortCodes</i>. Otherwise, returns an error code described in Embedding Function Error
///    Messages.
///    
@DllImport("t2embed")
int TTCharToUnicode(HDC hDC, char* pucCharCodes, uint ulCharCodeSize, char* pusShortCodes, uint ulShortCodeSize, 
                    uint ulFlags);

///Validates part or all glyph data of a wide-character (16-bit) font, in the size range specified. <b>Windows Vista and
///later</b>: this function will always return E_API_NOTIMPL, and no processing is performed by this API.
///Params:
///    hDC = Device context handle.
///    pTestParam = Pointer to a TTVALIDATIONTESTPARAMS structure specifying the parameters to test.
///Returns:
///    If successful and the glyph data is valid, returns E_NONE. Otherwise, returns an error code described in
///    Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTRunValidationTests(HDC hDC, TTVALIDATIONTESTSPARAMS* pTestParam);

///Determines whether the typeface exclusion list contains a specified font.
///Params:
///    hDC = Device context handle.
///    pbEnabled = Pointer to a boolean, set upon completion of the function. A nonzero value indicates the font is not in the
///                typeface exclusion list and, therefore, can be embedded without conflict.
///Returns:
///    If successful, returns E_NONE. The parameter <i>pbEnabled</i> is filled with a boolean that indicates whether
///    embedding is currently enabled within a device context. Otherwise, returns an error code described in
///    Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTIsEmbeddingEnabled(HDC hDC, int* pbEnabled);

///Determines whether embedding is enabled for a specified font.
///Params:
///    lpszFacename = Pointer to the facename of the font, such as Arial Bold.
///    pbEnabled = Pointer to a boolean, set upon completion of the function. A nonzero value indicates the font is not in the
///                typeface exclusion list, and, therefore, can be embedded without conflict.
///Returns:
///    If successful, returns E_NONE. <i>pbEnabled</i> is filled with a boolean that indicates whether embedding is
///    currently enabled within a device context for the specified font. Otherwise, returns an error code described in
///    Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTIsEmbeddingEnabledForFacename(const(char)* lpszFacename, int* pbEnabled);

///Adds or removes facenames from the typeface exclusion list.
///Params:
///    lpszFacename = Pointer to the facename of the font to be added or removed from the typeface exclusion list.
///    bEnable = Boolean controlling operation on typeface exclusion list. If nonzero, then the facename will be removed from the
///              list; if zero, the facename will be added to the list.
///Returns:
///    If successful, returns E_NONE. The facename indicated by <i>lpszFacename</i> will be added or removed from the
///    typeface exclusion list. Otherwise, returns an error code described in Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTEnableEmbeddingForFacename(const(char)* lpszFacename, BOOL bEnable);

///Creates a font structure containing the subsetted UCS-4 character (32-bit) font. The current font of the device
///context (hDC) provides the font information. This function passes the data to a client-defined callback routine for
///insertion into the document stream. <b>TTEmbedFontEx</b> is used the same way as TTEmbedFont, but accepts a character
///code set given in UCS-4 (32 bits).
///Params:
///    hDC = Device context handle.
///    ulFlags = Flag specifying the embedding request. This flag can have zero or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TTEMBED_EMBEDEUDC"></a><a
///              id="ttembed_embedeudc"></a><dl> <dt><b>TTEMBED_EMBEDEUDC</b></dt> </dl> </td> <td width="60%"> Include the
///              associated EUDC font file data with the font structure. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_RAW"></a><a id="ttembed_raw"></a><dl> <dt><b>TTEMBED_RAW</b></dt> </dl> </td> <td width="60%"> Return
///              a font structure containing the full character set, non-compressed. This is the default behavior of the function.
///              </td> </tr> <tr> <td width="40%"><a id="TTEMBED_SUBSET"></a><a id="ttembed_subset"></a><dl>
///              <dt><b>TTEMBED_SUBSET</b></dt> </dl> </td> <td width="60%"> Return a subsetted font containing only the glyphs
///              indicated by the <i>pusCharCodeSet</i> or <i>pulCharCodeSet</i> parameter. These character codes must be denoted
///              as 16-bit or UCS-4 characters as appropriate for the parameter. </td> </tr> <tr> <td width="40%"><a
///              id="TTEMBED_TTCOMPRESSED"></a><a id="ttembed_ttcompressed"></a><dl> <dt><b>TTEMBED_TTCOMPRESSED</b></dt> </dl>
///              </td> <td width="60%"> Return a compressed font structure. </td> </tr> </table>
///    ulCharSet = Flag specifying the character set of the font to be embedded. This flag can have one of the following values.
///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CHARSET_UNICODE"></a><a
///                id="charset_unicode"></a><dl> <dt><b>CHARSET_UNICODE</b></dt> </dl> </td> <td width="60%"> Unicode character set,
///                requiring 16-bit character encoding. </td> </tr> <tr> <td width="40%"><a id="CHARSET_SYMBOL"></a><a
///                id="charset_symbol"></a><dl> <dt><b>CHARSET_SYMBOL</b></dt> </dl> </td> <td width="60%"> Symbol character set,
///                requiring 16-bit character encoding. </td> </tr> </table>
///    pulPrivStatus = Pointer to flag indicating embedding privileges of the font. This flag can have one of the following values. This
///                    function returns the least restrictive license granted. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                    <td width="40%"><a id="EMBED_PREVIEWPRINT"></a><a id="embed_previewprint"></a><dl>
///                    <dt><b>EMBED_PREVIEWPRINT</b></dt> </dl> </td> <td width="60%"> Preview and Print Embedding. </td> </tr> <tr> <td
///                    width="40%"><a id="EMBED_EDITABLE"></a><a id="embed_editable"></a><dl> <dt><b>EMBED_EDITABLE</b></dt> </dl> </td>
///                    <td width="60%"> Editable Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_INSTALLABLE"></a><a
///                    id="embed_installable"></a><dl> <dt><b>EMBED_INSTALLABLE</b></dt> </dl> </td> <td width="60%"> Installable
///                    Embedding. </td> </tr> <tr> <td width="40%"><a id="EMBED_NOEMBEDDING"></a><a id="embed_noembedding"></a><dl>
///                    <dt><b>EMBED_NOEMBEDDING</b></dt> </dl> </td> <td width="60%"> Restricted License Embedding. </td> </tr> </table>
///    pulStatus = Pointer to a bitfield containing status information about the embedding request. This field is filled upon
///                completion of this function. No bits are currently defined for this parameter.
///    lpfnWriteToStream = Pointer to the client-defined callback function which writes the font structure to the document stream. See
///                        WRITEEMBEDPROC.
///    lpvWriteStream = A token to represent the output stream.
///    pulCharCodeSet = Pointer to the buffer containing the optional UCS-4 character codes for subsetting. This field is only used for
///                     subsetting a font and is ignored if the <i>ulFlags</i> field does not specify TTEMBED_SUBSET.
///    usCharCodeCount = The number of characters in the list of characters indicated by <i>pulCharCodeSet</i>. This field is only used
///                      for subsetting a font and is ignored if the ulFlags field does not specify TTEMBED_SUBSET.
///    usLanguage = Specifies which language in the name table to keep when subsetting. Set to 0 to keep all languages. This field is
///                 only used for subsetting a font and is ignored if the <i>ulFlags</i> field does not specify TTEMBED_SUBSET.
///    pTTEmbedInfo = Pointer to a TTEMBEDINFO structure containing the URLs from which the embedded font object may be legitimately
///                   referenced. If <i>pTTEmbedInfo</i> is <b>NULL</b>, no URLs will be added to the embedded font object and no URL
///                   checking will occur when the client calls TTLoadEmbeddedFont.
///Returns:
///    If the embedding is successful, returns E_NONE. The font structure is incorporated into the document stream by
///    the client. <i>pulPrivStatus</i> is set, indicating the embedding privileges of the font; and <i>pulStatus</i> is
///    set to provide results of the embedding operation. Otherwise, returns an error code described in
///    Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTEmbedFontEx(HDC hDC, uint ulFlags, uint ulCharSet, uint* pulPrivStatus, uint* pulStatus, 
                  WRITEEMBEDPROC lpfnWriteToStream, void* lpvWriteStream, char* pulCharCodeSet, 
                  ushort usCharCodeCount, ushort usLanguage, TTEMBEDINFO* pTTEmbedInfo);

///Validates part or all glyph data of a UCS-4 character (32-bit) font, in the size range specified. <b>Windows Vista
///and later</b>: this function will always return E_API_NOTIMPL, and no processing is performed by this API.
///Params:
///    hDC = Device context handle.
///    pTestParam = Pointer to a TTVALIDATIONTESTPARAMSEX structure specifying the parameters to test.
///Returns:
///    If successful and the glyph data is valid, returns E_NONE. Otherwise, returns an error code described in
///    Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTRunValidationTestsEx(HDC hDC, TTVALIDATIONTESTSPARAMSEX* pTestParam);

///Obtains the family name for the font loaded through TTLoadEmbeddedFont.
///Params:
///    phFontReference = Handle that identifies the embedded font that has been installed. The handle references an internal structure,
///                      not an Hfont.
///    wzWinFamilyName = Buffer to hold the new 16-bit-character Microsoft Windows family name.
///    cchMaxWinName = Length of the string allocated for the Windows name (<i>szWinFamilyName</i>). Must be at least LF_FACESIZE long.
///    szMacFamilyName = Buffer to hold the new 8-bit-character MacIntosh family name.
///    cchMaxMacName = Length of the string allocated for the Macintosh name (<i>szMacFamilyName</i>). Must be at least LF_FACESIZE
///                    long.
///Returns:
///    If successful, returns E_NONE. The font family name is a string in <i>szWinFamilyName</i> or
///    <i>szMacFamilyName</i>. Otherwise, returns an error code described in Embedding-Function Error Messages.
///    
@DllImport("t2embed")
int TTGetNewFontName(HANDLE* phFontReference, const(wchar)* wzWinFamilyName, int cchMaxWinName, 
                     const(char)* szMacFamilyName, int cchMaxMacName);

///The <b>DrawEdge</b> function draws one or more edges of rectangle.
///Params:
///    hdc = A handle to the device context.
///    qrc = A pointer to a RECT structure that contains the logical coordinates of the rectangle.
///    edge = The type of inner and outer edges to draw. This parameter must be a combination of one inner-border flag and one
///           outer-border flag. The inner-border flags are as follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///           <td width="40%"><a id="BDR_RAISEDINNER"></a><a id="bdr_raisedinner"></a><dl> <dt><b>BDR_RAISEDINNER</b></dt>
///           </dl> </td> <td width="60%"> Raised inner edge. </td> </tr> <tr> <td width="40%"><a id="BDR_SUNKENINNER"></a><a
///           id="bdr_sunkeninner"></a><dl> <dt><b>BDR_SUNKENINNER</b></dt> </dl> </td> <td width="60%"> Sunken inner edge.
///           </td> </tr> </table> The outer-border flags are as follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///           <tr> <td width="40%"><a id="BDR_RAISEDOUTER"></a><a id="bdr_raisedouter"></a><dl> <dt><b>BDR_RAISEDOUTER</b></dt>
///           </dl> </td> <td width="60%"> Raised outer edge. </td> </tr> <tr> <td width="40%"><a id="BDR_SUNKENOUTER"></a><a
///           id="bdr_sunkenouter"></a><dl> <dt><b>BDR_SUNKENOUTER</b></dt> </dl> </td> <td width="60%"> Sunken outer edge.
///           </td> </tr> </table> Alternatively, the <i>edge</i> parameter can specify one of the following flags. <table>
///           <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EDGE_BUMP"></a><a id="edge_bump"></a><dl>
///           <dt><b>EDGE_BUMP</b></dt> </dl> </td> <td width="60%"> Combination of BDR_RAISEDOUTER and BDR_SUNKENINNER. </td>
///           </tr> <tr> <td width="40%"><a id="EDGE_ETCHED"></a><a id="edge_etched"></a><dl> <dt><b>EDGE_ETCHED</b></dt> </dl>
///           </td> <td width="60%"> Combination of BDR_SUNKENOUTER and BDR_RAISEDINNER. </td> </tr> <tr> <td width="40%"><a
///           id="EDGE_RAISED"></a><a id="edge_raised"></a><dl> <dt><b>EDGE_RAISED</b></dt> </dl> </td> <td width="60%">
///           Combination of BDR_RAISEDOUTER and BDR_RAISEDINNER. </td> </tr> <tr> <td width="40%"><a id="EDGE_SUNKEN"></a><a
///           id="edge_sunken"></a><dl> <dt><b>EDGE_SUNKEN</b></dt> </dl> </td> <td width="60%"> Combination of BDR_SUNKENOUTER
///           and BDR_SUNKENINNER. </td> </tr> </table>
///    grfFlags = The type of border. This parameter can be a combination of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BF_ADJUST"></a><a id="bf_adjust"></a><dl>
///               <dt><b>BF_ADJUST</b></dt> </dl> </td> <td width="60%"> If this flag is passed, shrink the rectangle pointed to by
///               the <i>qrc</i> parameter to exclude the edges that were drawn. If this flag is not passed, then do not change the
///               rectangle pointed to by the <i>qrc</i> parameter. </td> </tr> <tr> <td width="40%"><a id="BF_BOTTOM"></a><a
///               id="bf_bottom"></a><dl> <dt><b>BF_BOTTOM</b></dt> </dl> </td> <td width="60%"> Bottom of border rectangle. </td>
///               </tr> <tr> <td width="40%"><a id="BF_BOTTOMLEFT"></a><a id="bf_bottomleft"></a><dl> <dt><b>BF_BOTTOMLEFT</b></dt>
///               </dl> </td> <td width="60%"> Bottom and left side of border rectangle. </td> </tr> <tr> <td width="40%"><a
///               id="BF_BOTTOMRIGHT"></a><a id="bf_bottomright"></a><dl> <dt><b>BF_BOTTOMRIGHT</b></dt> </dl> </td> <td
///               width="60%"> Bottom and right side of border rectangle. </td> </tr> <tr> <td width="40%"><a
///               id="BF_DIAGONAL"></a><a id="bf_diagonal"></a><dl> <dt><b>BF_DIAGONAL</b></dt> </dl> </td> <td width="60%">
///               Diagonal border. </td> </tr> <tr> <td width="40%"><a id="BF_DIAGONAL_ENDBOTTOMLEFT"></a><a
///               id="bf_diagonal_endbottomleft"></a><dl> <dt><b>BF_DIAGONAL_ENDBOTTOMLEFT</b></dt> </dl> </td> <td width="60%">
///               Diagonal border. The end point is the lower-left corner of the rectangle; the origin is top-right corner. </td>
///               </tr> <tr> <td width="40%"><a id="BF_DIAGONAL_ENDBOTTOMRIGHT"></a><a id="bf_diagonal_endbottomright"></a><dl>
///               <dt><b>BF_DIAGONAL_ENDBOTTOMRIGHT</b></dt> </dl> </td> <td width="60%"> Diagonal border. The end point is the
///               lower-right corner of the rectangle; the origin is top-left corner. </td> </tr> <tr> <td width="40%"><a
///               id="BF_DIAGONAL_ENDTOPLEFT"></a><a id="bf_diagonal_endtopleft"></a><dl> <dt><b>BF_DIAGONAL_ENDTOPLEFT</b></dt>
///               </dl> </td> <td width="60%"> Diagonal border. The end point is the top-left corner of the rectangle; the origin
///               is lower-right corner. </td> </tr> <tr> <td width="40%"><a id="BF_DIAGONAL_ENDTOPRIGHT"></a><a
///               id="bf_diagonal_endtopright"></a><dl> <dt><b>BF_DIAGONAL_ENDTOPRIGHT</b></dt> </dl> </td> <td width="60%">
///               Diagonal border. The end point is the top-right corner of the rectangle; the origin is lower-left corner. </td>
///               </tr> <tr> <td width="40%"><a id="BF_FLAT"></a><a id="bf_flat"></a><dl> <dt><b>BF_FLAT</b></dt> </dl> </td> <td
///               width="60%"> Flat border. </td> </tr> <tr> <td width="40%"><a id="BF_LEFT"></a><a id="bf_left"></a><dl>
///               <dt><b>BF_LEFT</b></dt> </dl> </td> <td width="60%"> Left side of border rectangle. </td> </tr> <tr> <td
///               width="40%"><a id="BF_MIDDLE"></a><a id="bf_middle"></a><dl> <dt><b>BF_MIDDLE</b></dt> </dl> </td> <td
///               width="60%"> Interior of rectangle to be filled. </td> </tr> <tr> <td width="40%"><a id="BF_MONO"></a><a
///               id="bf_mono"></a><dl> <dt><b>BF_MONO</b></dt> </dl> </td> <td width="60%"> One-dimensional border. </td> </tr>
///               <tr> <td width="40%"><a id="BF_RECT"></a><a id="bf_rect"></a><dl> <dt><b>BF_RECT</b></dt> </dl> </td> <td
///               width="60%"> Entire border rectangle. </td> </tr> <tr> <td width="40%"><a id="BF_RIGHT"></a><a
///               id="bf_right"></a><dl> <dt><b>BF_RIGHT</b></dt> </dl> </td> <td width="60%"> Right side of border rectangle.
///               </td> </tr> <tr> <td width="40%"><a id="BF_SOFT"></a><a id="bf_soft"></a><dl> <dt><b>BF_SOFT</b></dt> </dl> </td>
///               <td width="60%"> Soft buttons instead of tiles. </td> </tr> <tr> <td width="40%"><a id="BF_TOP"></a><a
///               id="bf_top"></a><dl> <dt><b>BF_TOP</b></dt> </dl> </td> <td width="60%"> Top of border rectangle. </td> </tr>
///               <tr> <td width="40%"><a id="BF_TOPLEFT"></a><a id="bf_topleft"></a><dl> <dt><b>BF_TOPLEFT</b></dt> </dl> </td>
///               <td width="60%"> Top and left side of border rectangle. </td> </tr> <tr> <td width="40%"><a
///               id="BF_TOPRIGHT"></a><a id="bf_topright"></a><dl> <dt><b>BF_TOPRIGHT</b></dt> </dl> </td> <td width="60%"> Top
///               and right side of border rectangle. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL DrawEdge(HDC hdc, RECT* qrc, uint edge, uint grfFlags);

///The <b>DrawFrameControl</b> function draws a frame control of the specified type and style.
///Params:
///    arg1 = A handle to the device context of the window in which to draw the control.
///    arg2 = A pointer to a RECT structure that contains the logical coordinates of the bounding rectangle for frame control.
///    arg3 = The type of frame control to draw. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DFC_BUTTON"></a><a id="dfc_button"></a><dl>
///           <dt><b>DFC_BUTTON</b></dt> </dl> </td> <td width="60%"> Standard button </td> </tr> <tr> <td width="40%"><a
///           id="DFC_CAPTION"></a><a id="dfc_caption"></a><dl> <dt><b>DFC_CAPTION</b></dt> </dl> </td> <td width="60%"> Title
///           bar </td> </tr> <tr> <td width="40%"><a id="DFC_MENU"></a><a id="dfc_menu"></a><dl> <dt><b>DFC_MENU</b></dt>
///           </dl> </td> <td width="60%"> Menu bar </td> </tr> <tr> <td width="40%"><a id="DFC_POPUPMENU"></a><a
///           id="dfc_popupmenu"></a><dl> <dt><b>DFC_POPUPMENU</b></dt> </dl> </td> <td width="60%"> Popup menu item. </td>
///           </tr> <tr> <td width="40%"><a id="DFC_SCROLL"></a><a id="dfc_scroll"></a><dl> <dt><b>DFC_SCROLL</b></dt> </dl>
///           </td> <td width="60%"> Scroll bar </td> </tr> </table>
///    arg4 = The initial state of the frame control. If <i>uType</i> is DFC_BUTTON, <i>uState</i> can be one of the following
///           values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DFCS_BUTTON3STATE"></a><a
///           id="dfcs_button3state"></a><dl> <dt><b>DFCS_BUTTON3STATE</b></dt> </dl> </td> <td width="60%"> Three-state button
///           </td> </tr> <tr> <td width="40%"><a id="DFCS_BUTTONCHECK"></a><a id="dfcs_buttoncheck"></a><dl>
///           <dt><b>DFCS_BUTTONCHECK</b></dt> </dl> </td> <td width="60%"> Check box </td> </tr> <tr> <td width="40%"><a
///           id="DFCS_BUTTONPUSH"></a><a id="dfcs_buttonpush"></a><dl> <dt><b>DFCS_BUTTONPUSH</b></dt> </dl> </td> <td
///           width="60%"> Push button </td> </tr> <tr> <td width="40%"><a id="DFCS_BUTTONRADIO"></a><a
///           id="dfcs_buttonradio"></a><dl> <dt><b>DFCS_BUTTONRADIO</b></dt> </dl> </td> <td width="60%"> Radio button </td>
///           </tr> <tr> <td width="40%"><a id="DFCS_BUTTONRADIOIMAGE"></a><a id="dfcs_buttonradioimage"></a><dl>
///           <dt><b>DFCS_BUTTONRADIOIMAGE</b></dt> </dl> </td> <td width="60%"> Image for radio button (nonsquare needs image)
///           </td> </tr> <tr> <td width="40%"><a id="DFCS_BUTTONRADIOMASK"></a><a id="dfcs_buttonradiomask"></a><dl>
///           <dt><b>DFCS_BUTTONRADIOMASK</b></dt> </dl> </td> <td width="60%"> Mask for radio button (nonsquare needs mask)
///           </td> </tr> </table> If <i>uType</i> is DFC_CAPTION, <i>uState</i> can be one of the following values. <table>
///           <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DFCS_CAPTIONCLOSE"></a><a
///           id="dfcs_captionclose"></a><dl> <dt><b>DFCS_CAPTIONCLOSE</b></dt> </dl> </td> <td width="60%"> <b>Close</b>
///           button </td> </tr> <tr> <td width="40%"><a id="DFCS_CAPTIONHELP"></a><a id="dfcs_captionhelp"></a><dl>
///           <dt><b>DFCS_CAPTIONHELP</b></dt> </dl> </td> <td width="60%"> <b>Help</b> button </td> </tr> <tr> <td
///           width="40%"><a id="DFCS_CAPTIONMAX"></a><a id="dfcs_captionmax"></a><dl> <dt><b>DFCS_CAPTIONMAX</b></dt> </dl>
///           </td> <td width="60%"> <b>Maximize</b> button </td> </tr> <tr> <td width="40%"><a id="DFCS_CAPTIONMIN"></a><a
///           id="dfcs_captionmin"></a><dl> <dt><b>DFCS_CAPTIONMIN</b></dt> </dl> </td> <td width="60%"> <b>Minimize</b> button
///           </td> </tr> <tr> <td width="40%"><a id="DFCS_CAPTIONRESTORE"></a><a id="dfcs_captionrestore"></a><dl>
///           <dt><b>DFCS_CAPTIONRESTORE</b></dt> </dl> </td> <td width="60%"> <b>Restore</b> button </td> </tr> </table> If
///           <i>uType</i> is DFC_MENU, <i>uState</i> can be one of the following values. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DFCS_MENUARROW"></a><a id="dfcs_menuarrow"></a><dl>
///           <dt><b>DFCS_MENUARROW</b></dt> </dl> </td> <td width="60%"> Submenu arrow </td> </tr> <tr> <td width="40%"><a
///           id="DFCS_MENUARROWRIGHT"></a><a id="dfcs_menuarrowright"></a><dl> <dt><b>DFCS_MENUARROWRIGHT</b></dt> </dl> </td>
///           <td width="60%"> Submenu arrow pointing left. This is used for the right-to-left cascading menus used with
///           right-to-left languages such as Arabic or Hebrew. </td> </tr> <tr> <td width="40%"><a id="DFCS_MENUBULLET"></a><a
///           id="dfcs_menubullet"></a><dl> <dt><b>DFCS_MENUBULLET</b></dt> </dl> </td> <td width="60%"> Bullet </td> </tr>
///           <tr> <td width="40%"><a id="DFCS_MENUCHECK"></a><a id="dfcs_menucheck"></a><dl> <dt><b>DFCS_MENUCHECK</b></dt>
///           </dl> </td> <td width="60%"> Check mark </td> </tr> </table> If <i>uType</i> is DFC_SCROLL, <i>uState</i> can be
///           one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id="DFCS_SCROLLCOMBOBOX"></a><a id="dfcs_scrollcombobox"></a><dl> <dt><b>DFCS_SCROLLCOMBOBOX</b></dt> </dl> </td>
///           <td width="60%"> Combo box scroll bar </td> </tr> <tr> <td width="40%"><a id="DFCS_SCROLLDOWN"></a><a
///           id="dfcs_scrolldown"></a><dl> <dt><b>DFCS_SCROLLDOWN</b></dt> </dl> </td> <td width="60%"> Down arrow of scroll
///           bar </td> </tr> <tr> <td width="40%"><a id="DFCS_SCROLLLEFT"></a><a id="dfcs_scrollleft"></a><dl>
///           <dt><b>DFCS_SCROLLLEFT</b></dt> </dl> </td> <td width="60%"> Left arrow of scroll bar </td> </tr> <tr> <td
///           width="40%"><a id="DFCS_SCROLLRIGHT"></a><a id="dfcs_scrollright"></a><dl> <dt><b>DFCS_SCROLLRIGHT</b></dt> </dl>
///           </td> <td width="60%"> Right arrow of scroll bar </td> </tr> <tr> <td width="40%"><a
///           id="DFCS_SCROLLSIZEGRIP"></a><a id="dfcs_scrollsizegrip"></a><dl> <dt><b>DFCS_SCROLLSIZEGRIP</b></dt> </dl> </td>
///           <td width="60%"> Size grip in lower-right corner of window </td> </tr> <tr> <td width="40%"><a
///           id="DFCS_SCROLLSIZEGRIPRIGHT"></a><a id="dfcs_scrollsizegripright"></a><dl>
///           <dt><b>DFCS_SCROLLSIZEGRIPRIGHT</b></dt> </dl> </td> <td width="60%"> Size grip in lower-left corner of window.
///           This is used with right-to-left languages such as Arabic or Hebrew. </td> </tr> <tr> <td width="40%"><a
///           id="DFCS_SCROLLUP"></a><a id="dfcs_scrollup"></a><dl> <dt><b>DFCS_SCROLLUP</b></dt> </dl> </td> <td width="60%">
///           Up arrow of scroll bar </td> </tr> </table> The following style can be used to adjust the bounding rectangle of
///           the push button. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id="DFCS_ADJUSTRECT"></a><a id="dfcs_adjustrect"></a><dl> <dt><b>DFCS_ADJUSTRECT</b></dt> </dl> </td> <td
///           width="60%"> Bounding rectangle is adjusted to exclude the surrounding edge of the push button. </td> </tr>
///           </table> One or more of the following values can be used to set the state of the control to be drawn. <table>
///           <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DFCS_CHECKED"></a><a
///           id="dfcs_checked"></a><dl> <dt><b>DFCS_CHECKED</b></dt> </dl> </td> <td width="60%"> Button is checked. </td>
///           </tr> <tr> <td width="40%"><a id="DFCS_FLAT"></a><a id="dfcs_flat"></a><dl> <dt><b>DFCS_FLAT</b></dt> </dl> </td>
///           <td width="60%"> Button has a flat border. </td> </tr> <tr> <td width="40%"><a id="DFCS_HOT"></a><a
///           id="dfcs_hot"></a><dl> <dt><b>DFCS_HOT</b></dt> </dl> </td> <td width="60%"> Button is hot-tracked. </td> </tr>
///           <tr> <td width="40%"><a id="DFCS_INACTIVE"></a><a id="dfcs_inactive"></a><dl> <dt><b>DFCS_INACTIVE</b></dt> </dl>
///           </td> <td width="60%"> Button is inactive (grayed). </td> </tr> <tr> <td width="40%"><a id="DFCS_MONO"></a><a
///           id="dfcs_mono"></a><dl> <dt><b>DFCS_MONO</b></dt> </dl> </td> <td width="60%"> Button has a monochrome border.
///           </td> </tr> <tr> <td width="40%"><a id="DFCS_PUSHED"></a><a id="dfcs_pushed"></a><dl> <dt><b>DFCS_PUSHED</b></dt>
///           </dl> </td> <td width="60%"> Button is pushed. </td> </tr> <tr> <td width="40%"><a id="DFCS_TRANSPARENT"></a><a
///           id="dfcs_transparent"></a><dl> <dt><b>DFCS_TRANSPARENT</b></dt> </dl> </td> <td width="60%"> The background
///           remains untouched. This flag can only be combined with DFCS_MENUARROWUP or DFCS_MENUARROWDOWN. </td> </tr>
///           </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL DrawFrameControl(HDC param0, RECT* param1, uint param2, uint param3);

///The <b>DrawCaption</b> function draws a window caption.
///Params:
///    hwnd = A handle to a window that supplies text and an icon for the window caption.
///    hdc = A handle to a device context. The function draws the window caption into this device context.
///    lprect = A pointer to a RECT structure that specifies the bounding rectangle for the window caption in logical
///             coordinates.
///    flags = The drawing options. This parameter can be zero or more of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DC_ACTIVE"></a><a id="dc_active"></a><dl>
///            <dt><b>DC_ACTIVE</b></dt> </dl> </td> <td width="60%"> The function uses the colors that denote an active
///            caption. </td> </tr> <tr> <td width="40%"><a id="DC_BUTTONS"></a><a id="dc_buttons"></a><dl>
///            <dt><b>DC_BUTTONS</b></dt> </dl> </td> <td width="60%"> If set, the function draws the buttons in the caption bar
///            (to minimize, restore, or close an application). </td> </tr> <tr> <td width="40%"><a id="DC_GRADIENT"></a><a
///            id="dc_gradient"></a><dl> <dt><b>DC_GRADIENT</b></dt> </dl> </td> <td width="60%"> When this flag is set, the
///            function uses COLOR_GRADIENTACTIVECAPTION (if the DC_ACTIVE flag was set) or COLOR_GRADIENTINACTIVECAPTION for
///            the title-bar color. If this flag is not set, the function uses COLOR_ACTIVECAPTION or COLOR_INACTIVECAPTION for
///            both colors. </td> </tr> <tr> <td width="40%"><a id="DC_ICON"></a><a id="dc_icon"></a><dl>
///            <dt><b>DC_ICON</b></dt> </dl> </td> <td width="60%"> The function draws the icon when drawing the caption text.
///            </td> </tr> <tr> <td width="40%"><a id="DC_INBUTTON"></a><a id="dc_inbutton"></a><dl> <dt><b>DC_INBUTTON</b></dt>
///            </dl> </td> <td width="60%"> The function draws the caption as a button. </td> </tr> <tr> <td width="40%"><a
///            id="DC_SMALLCAP"></a><a id="dc_smallcap"></a><dl> <dt><b>DC_SMALLCAP</b></dt> </dl> </td> <td width="60%"> The
///            function draws a small caption, using the current small caption font. </td> </tr> <tr> <td width="40%"><a
///            id="DC_TEXT"></a><a id="dc_text"></a><dl> <dt><b>DC_TEXT</b></dt> </dl> </td> <td width="60%"> The function draws
///            the caption text when drawing the caption. </td> </tr> </table> If DC_SMALLCAP is specified, the function draws a
///            normal window caption.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL DrawCaption(HWND hwnd, HDC hdc, const(RECT)* lprect, uint flags);

///Animates the caption of a window to indicate the opening of an icon or the minimizing or maximizing of a window.
///Params:
///    hwnd = A handle to the window whose caption should be animated on the screen. The animation will be clipped to the
///           parent of this window.
///    idAni = The type of animation. This must be IDANI_CAPTION. With the IDANI_CAPTION animation type, the window caption will
///            animate from the position specified by lprcFrom to the position specified by lprcTo. The effect is similar to
///            minimizing or maximizing a window.
///    lprcFrom = A pointer to a RECT structure specifying the location and size of the icon or minimized window. Coordinates are
///               relative to the clipping window <i>hwnd</i>.
///    lprcTo = A pointer to a RECT structure specifying the location and size of the restored window. Coordinates are relative
///             to the clipping window <i>hwnd</i>.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL DrawAnimatedRects(HWND hwnd, int idAni, const(RECT)* lprcFrom, const(RECT)* lprcTo);

///The <b>DrawText</b> function draws formatted text in the specified rectangle. It formats the text according to the
///specified method (expanding tabs, justifying characters, breaking lines, and so forth). To specify additional
///formatting options, use the DrawTextEx function.
///Params:
///    hdc = A handle to the device context.
///    lpchText = A pointer to the string that specifies the text to be drawn. If the <i>nCount</i> parameter is -1, the string
///               must be null-terminated. If <i>uFormat</i> includes DT_MODIFYSTRING, the function could add up to four additional
///               characters to this string. The buffer containing the string should be large enough to accommodate these extra
///               characters.
///    cchText = The length, in characters, of the string. If <i>nCount</i> is -1, then the <i>lpchText</i> parameter is assumed
///              to be a pointer to a null-terminated string and <b>DrawText</b> computes the character count automatically.
///    lprc = A pointer to a RECT structure that contains the rectangle (in logical coordinates) in which the text is to be
///           formatted.
///    format = The method of formatting the text. This parameter can be one or more of the following values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DT_BOTTOM"></a><a id="dt_bottom"></a><dl>
///             <dt><b>DT_BOTTOM</b></dt> </dl> </td> <td width="60%"> Justifies the text to the bottom of the rectangle. This
///             value is used only with the DT_SINGLELINE value. </td> </tr> <tr> <td width="40%"><a id="DT_CALCRECT"></a><a
///             id="dt_calcrect"></a><dl> <dt><b>DT_CALCRECT</b></dt> </dl> </td> <td width="60%"> Determines the width and
///             height of the rectangle. If there are multiple lines of text, <b>DrawText</b> uses the width of the rectangle
///             pointed to by the <i>lpRect</i> parameter and extends the base of the rectangle to bound the last line of text.
///             If the largest word is wider than the rectangle, the width is expanded. If the text is less than the width of the
///             rectangle, the width is reduced. If there is only one line of text, <b>DrawText</b> modifies the right side of
///             the rectangle so that it bounds the last character in the line. In either case, <b>DrawText</b> returns the
///             height of the formatted text but does not draw the text. </td> </tr> <tr> <td width="40%"><a
///             id="DT_CENTER"></a><a id="dt_center"></a><dl> <dt><b>DT_CENTER</b></dt> </dl> </td> <td width="60%"> Centers text
///             horizontally in the rectangle. </td> </tr> <tr> <td width="40%"><a id="DT_EDITCONTROL"></a><a
///             id="dt_editcontrol"></a><dl> <dt><b>DT_EDITCONTROL</b></dt> </dl> </td> <td width="60%"> Duplicates the
///             text-displaying characteristics of a multiline edit control. Specifically, the average character width is
///             calculated in the same manner as for an edit control, and the function does not display a partially visible last
///             line. </td> </tr> <tr> <td width="40%"><a id="DT_END_ELLIPSIS"></a><a id="dt_end_ellipsis"></a><dl>
///             <dt><b>DT_END_ELLIPSIS</b></dt> </dl> </td> <td width="60%"> For displayed text, if the end of a string does not
///             fit in the rectangle, it is truncated and ellipses are added. If a word that is not at the end of the string goes
///             beyond the limits of the rectangle, it is truncated without ellipses. The string is not modified unless the
///             DT_MODIFYSTRING flag is specified. Compare with DT_PATH_ELLIPSIS and DT_WORD_ELLIPSIS. </td> </tr> <tr> <td
///             width="40%"><a id="DT_EXPANDTABS"></a><a id="dt_expandtabs"></a><dl> <dt><b>DT_EXPANDTABS</b></dt> </dl> </td>
///             <td width="60%"> Expands tab characters. The default number of characters per tab is eight. The DT_WORD_ELLIPSIS,
///             DT_PATH_ELLIPSIS, and DT_END_ELLIPSIS values cannot be used with the DT_EXPANDTABS value. </td> </tr> <tr> <td
///             width="40%"><a id="DT_EXTERNALLEADING"></a><a id="dt_externalleading"></a><dl> <dt><b>DT_EXTERNALLEADING</b></dt>
///             </dl> </td> <td width="60%"> Includes the font external leading in line height. Normally, external leading is not
///             included in the height of a line of text. </td> </tr> <tr> <td width="40%"><a id="DT_HIDEPREFIX"></a><a
///             id="dt_hideprefix"></a><dl> <dt><b>DT_HIDEPREFIX</b></dt> </dl> </td> <td width="60%"> Ignores the ampersand
///             (&amp;) prefix character in the text. The letter that follows will not be underlined, but other mnemonic-prefix
///             characters are still processed. Example: input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d"
///             DT_HIDEPREFIX: "Abc&amp;d" Compare with DT_NOPREFIX and DT_PREFIXONLY. </td> </tr> <tr> <td width="40%"><a
///             id="DT_INTERNAL"></a><a id="dt_internal"></a><dl> <dt><b>DT_INTERNAL</b></dt> </dl> </td> <td width="60%"> Uses
///             the system font to calculate text metrics. </td> </tr> <tr> <td width="40%"><a id="DT_LEFT"></a><a
///             id="dt_left"></a><dl> <dt><b>DT_LEFT</b></dt> </dl> </td> <td width="60%"> Aligns text to the left. </td> </tr>
///             <tr> <td width="40%"><a id="DT_MODIFYSTRING"></a><a id="dt_modifystring"></a><dl> <dt><b>DT_MODIFYSTRING</b></dt>
///             </dl> </td> <td width="60%"> Modifies the specified string to match the displayed text. This value has no effect
///             unless DT_END_ELLIPSIS or DT_PATH_ELLIPSIS is specified. </td> </tr> <tr> <td width="40%"><a
///             id="DT_NOCLIP"></a><a id="dt_noclip"></a><dl> <dt><b>DT_NOCLIP</b></dt> </dl> </td> <td width="60%"> Draws
///             without clipping. <b>DrawText</b> is somewhat faster when DT_NOCLIP is used. </td> </tr> <tr> <td width="40%"><a
///             id="DT_NOFULLWIDTHCHARBREAK"></a><a id="dt_nofullwidthcharbreak"></a><dl> <dt><b>DT_NOFULLWIDTHCHARBREAK</b></dt>
///             </dl> </td> <td width="60%"> Prevents a line break at a DBCS (double-wide character string), so that the line
///             breaking rule is equivalent to SBCS strings. For example, this can be used in Korean windows, for more
///             readability of icon labels. This value has no effect unless DT_WORDBREAK is specified. </td> </tr> <tr> <td
///             width="40%"><a id="DT_NOPREFIX"></a><a id="dt_noprefix"></a><dl> <dt><b>DT_NOPREFIX</b></dt> </dl> </td> <td
///             width="60%"> Turns off processing of prefix characters. Normally, <b>DrawText</b> interprets the mnemonic-prefix
///             character &amp; as a directive to underscore the character that follows, and the mnemonic-prefix characters
///             &amp;&amp; as a directive to print a single &amp;. By specifying DT_NOPREFIX, this processing is turned off. For
///             example, Example: input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d" DT_NOPREFIX:
///             "A&amp;bc&amp;&amp;d" Compare with DT_HIDEPREFIX and DT_PREFIXONLY. </td> </tr> <tr> <td width="40%"><a
///             id="DT_PATH_ELLIPSIS"></a><a id="dt_path_ellipsis"></a><dl> <dt><b>DT_PATH_ELLIPSIS</b></dt> </dl> </td> <td
///             width="60%"> For displayed text, replaces characters in the middle of the string with ellipses so that the result
///             fits in the specified rectangle. If the string contains backslash (\\) characters, DT_PATH_ELLIPSIS preserves as
///             much as possible of the text after the last backslash. The string is not modified unless the DT_MODIFYSTRING flag
///             is specified. Compare with DT_END_ELLIPSIS and DT_WORD_ELLIPSIS. </td> </tr> <tr> <td width="40%"><a
///             id="DT_PREFIXONLY"></a><a id="dt_prefixonly"></a><dl> <dt><b>DT_PREFIXONLY</b></dt> </dl> </td> <td width="60%">
///             Draws only an underline at the position of the character following the ampersand (&amp;) prefix character. Does
///             not draw any other characters in the string. For example, Example: input string: "A&amp;bc&amp;&amp;d"n normal:
///             "A<u>b</u>c&amp;d" DT_PREFIXONLY: " _ " Compare with DT_HIDEPREFIX and DT_NOPREFIX. </td> </tr> <tr> <td
///             width="40%"><a id="DT_RIGHT"></a><a id="dt_right"></a><dl> <dt><b>DT_RIGHT</b></dt> </dl> </td> <td width="60%">
///             Aligns text to the right. </td> </tr> <tr> <td width="40%"><a id="DT_RTLREADING"></a><a
///             id="dt_rtlreading"></a><dl> <dt><b>DT_RTLREADING</b></dt> </dl> </td> <td width="60%"> Layout in right-to-left
///             reading order for bidirectional text when the font selected into the <i>hdc</i> is a Hebrew or Arabic font. The
///             default reading order for all text is left-to-right. </td> </tr> <tr> <td width="40%"><a
///             id="DT_SINGLELINE"></a><a id="dt_singleline"></a><dl> <dt><b>DT_SINGLELINE</b></dt> </dl> </td> <td width="60%">
///             Displays text on a single line only. Carriage returns and line feeds do not break the line. </td> </tr> <tr> <td
///             width="40%"><a id="DT_TABSTOP"></a><a id="dt_tabstop"></a><dl> <dt><b>DT_TABSTOP</b></dt> </dl> </td> <td
///             width="60%"> Sets tab stops. Bits 15-8 (high-order byte of the low-order word) of the <i>uFormat</i> parameter
///             specify the number of characters for each tab. The default number of characters per tab is eight. The
///             DT_CALCRECT, DT_EXTERNALLEADING, DT_INTERNAL, DT_NOCLIP, and DT_NOPREFIX values cannot be used with the
///             DT_TABSTOP value. </td> </tr> <tr> <td width="40%"><a id="DT_TOP"></a><a id="dt_top"></a><dl>
///             <dt><b>DT_TOP</b></dt> </dl> </td> <td width="60%"> Justifies the text to the top of the rectangle. </td> </tr>
///             <tr> <td width="40%"><a id="DT_VCENTER"></a><a id="dt_vcenter"></a><dl> <dt><b>DT_VCENTER</b></dt> </dl> </td>
///             <td width="60%"> Centers text vertically. This value is used only with the DT_SINGLELINE value. </td> </tr> <tr>
///             <td width="40%"><a id="DT_WORDBREAK"></a><a id="dt_wordbreak"></a><dl> <dt><b>DT_WORDBREAK</b></dt> </dl> </td>
///             <td width="60%"> Breaks words. Lines are automatically broken between words if a word would extend past the edge
///             of the rectangle specified by the <i>lpRect</i> parameter. A carriage return-line feed sequence also breaks the
///             line. If this is not specified, output is on one line. </td> </tr> <tr> <td width="40%"><a
///             id="DT_WORD_ELLIPSIS"></a><a id="dt_word_ellipsis"></a><dl> <dt><b>DT_WORD_ELLIPSIS</b></dt> </dl> </td> <td
///             width="60%"> Truncates any word that does not fit in the rectangle and adds ellipses. Compare with
///             DT_END_ELLIPSIS and DT_PATH_ELLIPSIS. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the height of the text in logical units. If DT_VCENTER or DT_BOTTOM
///    is specified, the return value is the offset from <code>lpRect-&gt;top</code> to the bottom of the drawn text If
///    the function fails, the return value is zero.
///    
@DllImport("USER32")
int DrawTextA(HDC hdc, const(char)* lpchText, int cchText, RECT* lprc, uint format);

///The <b>DrawText</b> function draws formatted text in the specified rectangle. It formats the text according to the
///specified method (expanding tabs, justifying characters, breaking lines, and so forth). To specify additional
///formatting options, use the DrawTextEx function.
///Params:
///    hdc = A handle to the device context.
///    lpchText = A pointer to the string that specifies the text to be drawn. If the <i>nCount</i> parameter is -1, the string
///               must be null-terminated. If <i>uFormat</i> includes DT_MODIFYSTRING, the function could add up to four additional
///               characters to this string. The buffer containing the string should be large enough to accommodate these extra
///               characters.
///    cchText = The length, in characters, of the string. If <i>nCount</i> is -1, then the <i>lpchText</i> parameter is assumed
///              to be a pointer to a null-terminated string and <b>DrawText</b> computes the character count automatically.
///    lprc = A pointer to a RECT structure that contains the rectangle (in logical coordinates) in which the text is to be
///           formatted.
///    format = The method of formatting the text. This parameter can be one or more of the following values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DT_BOTTOM"></a><a id="dt_bottom"></a><dl>
///             <dt><b>DT_BOTTOM</b></dt> </dl> </td> <td width="60%"> Justifies the text to the bottom of the rectangle. This
///             value is used only with the DT_SINGLELINE value. </td> </tr> <tr> <td width="40%"><a id="DT_CALCRECT"></a><a
///             id="dt_calcrect"></a><dl> <dt><b>DT_CALCRECT</b></dt> </dl> </td> <td width="60%"> Determines the width and
///             height of the rectangle. If there are multiple lines of text, <b>DrawText</b> uses the width of the rectangle
///             pointed to by the <i>lpRect</i> parameter and extends the base of the rectangle to bound the last line of text.
///             If the largest word is wider than the rectangle, the width is expanded. If the text is less than the width of the
///             rectangle, the width is reduced. If there is only one line of text, <b>DrawText</b> modifies the right side of
///             the rectangle so that it bounds the last character in the line. In either case, <b>DrawText</b> returns the
///             height of the formatted text but does not draw the text. </td> </tr> <tr> <td width="40%"><a
///             id="DT_CENTER"></a><a id="dt_center"></a><dl> <dt><b>DT_CENTER</b></dt> </dl> </td> <td width="60%"> Centers text
///             horizontally in the rectangle. </td> </tr> <tr> <td width="40%"><a id="DT_EDITCONTROL"></a><a
///             id="dt_editcontrol"></a><dl> <dt><b>DT_EDITCONTROL</b></dt> </dl> </td> <td width="60%"> Duplicates the
///             text-displaying characteristics of a multiline edit control. Specifically, the average character width is
///             calculated in the same manner as for an edit control, and the function does not display a partially visible last
///             line. </td> </tr> <tr> <td width="40%"><a id="DT_END_ELLIPSIS"></a><a id="dt_end_ellipsis"></a><dl>
///             <dt><b>DT_END_ELLIPSIS</b></dt> </dl> </td> <td width="60%"> For displayed text, if the end of a string does not
///             fit in the rectangle, it is truncated and ellipses are added. If a word that is not at the end of the string goes
///             beyond the limits of the rectangle, it is truncated without ellipses. The string is not modified unless the
///             DT_MODIFYSTRING flag is specified. Compare with DT_PATH_ELLIPSIS and DT_WORD_ELLIPSIS. </td> </tr> <tr> <td
///             width="40%"><a id="DT_EXPANDTABS"></a><a id="dt_expandtabs"></a><dl> <dt><b>DT_EXPANDTABS</b></dt> </dl> </td>
///             <td width="60%"> Expands tab characters. The default number of characters per tab is eight. The DT_WORD_ELLIPSIS,
///             DT_PATH_ELLIPSIS, and DT_END_ELLIPSIS values cannot be used with the DT_EXPANDTABS value. </td> </tr> <tr> <td
///             width="40%"><a id="DT_EXTERNALLEADING"></a><a id="dt_externalleading"></a><dl> <dt><b>DT_EXTERNALLEADING</b></dt>
///             </dl> </td> <td width="60%"> Includes the font external leading in line height. Normally, external leading is not
///             included in the height of a line of text. </td> </tr> <tr> <td width="40%"><a id="DT_HIDEPREFIX"></a><a
///             id="dt_hideprefix"></a><dl> <dt><b>DT_HIDEPREFIX</b></dt> </dl> </td> <td width="60%"> Ignores the ampersand
///             (&amp;) prefix character in the text. The letter that follows will not be underlined, but other mnemonic-prefix
///             characters are still processed. Example: input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d"
///             DT_HIDEPREFIX: "Abc&amp;d" Compare with DT_NOPREFIX and DT_PREFIXONLY. </td> </tr> <tr> <td width="40%"><a
///             id="DT_INTERNAL"></a><a id="dt_internal"></a><dl> <dt><b>DT_INTERNAL</b></dt> </dl> </td> <td width="60%"> Uses
///             the system font to calculate text metrics. </td> </tr> <tr> <td width="40%"><a id="DT_LEFT"></a><a
///             id="dt_left"></a><dl> <dt><b>DT_LEFT</b></dt> </dl> </td> <td width="60%"> Aligns text to the left. </td> </tr>
///             <tr> <td width="40%"><a id="DT_MODIFYSTRING"></a><a id="dt_modifystring"></a><dl> <dt><b>DT_MODIFYSTRING</b></dt>
///             </dl> </td> <td width="60%"> Modifies the specified string to match the displayed text. This value has no effect
///             unless DT_END_ELLIPSIS or DT_PATH_ELLIPSIS is specified. </td> </tr> <tr> <td width="40%"><a
///             id="DT_NOCLIP"></a><a id="dt_noclip"></a><dl> <dt><b>DT_NOCLIP</b></dt> </dl> </td> <td width="60%"> Draws
///             without clipping. <b>DrawText</b> is somewhat faster when DT_NOCLIP is used. </td> </tr> <tr> <td width="40%"><a
///             id="DT_NOFULLWIDTHCHARBREAK"></a><a id="dt_nofullwidthcharbreak"></a><dl> <dt><b>DT_NOFULLWIDTHCHARBREAK</b></dt>
///             </dl> </td> <td width="60%"> Prevents a line break at a DBCS (double-wide character string), so that the line
///             breaking rule is equivalent to SBCS strings. For example, this can be used in Korean windows, for more
///             readability of icon labels. This value has no effect unless DT_WORDBREAK is specified. </td> </tr> <tr> <td
///             width="40%"><a id="DT_NOPREFIX"></a><a id="dt_noprefix"></a><dl> <dt><b>DT_NOPREFIX</b></dt> </dl> </td> <td
///             width="60%"> Turns off processing of prefix characters. Normally, <b>DrawText</b> interprets the mnemonic-prefix
///             character &amp; as a directive to underscore the character that follows, and the mnemonic-prefix characters
///             &amp;&amp; as a directive to print a single &amp;. By specifying DT_NOPREFIX, this processing is turned off. For
///             example, Example: input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d" DT_NOPREFIX:
///             "A&amp;bc&amp;&amp;d" Compare with DT_HIDEPREFIX and DT_PREFIXONLY. </td> </tr> <tr> <td width="40%"><a
///             id="DT_PATH_ELLIPSIS"></a><a id="dt_path_ellipsis"></a><dl> <dt><b>DT_PATH_ELLIPSIS</b></dt> </dl> </td> <td
///             width="60%"> For displayed text, replaces characters in the middle of the string with ellipses so that the result
///             fits in the specified rectangle. If the string contains backslash (\\) characters, DT_PATH_ELLIPSIS preserves as
///             much as possible of the text after the last backslash. The string is not modified unless the DT_MODIFYSTRING flag
///             is specified. Compare with DT_END_ELLIPSIS and DT_WORD_ELLIPSIS. </td> </tr> <tr> <td width="40%"><a
///             id="DT_PREFIXONLY"></a><a id="dt_prefixonly"></a><dl> <dt><b>DT_PREFIXONLY</b></dt> </dl> </td> <td width="60%">
///             Draws only an underline at the position of the character following the ampersand (&amp;) prefix character. Does
///             not draw any other characters in the string. For example, Example: input string: "A&amp;bc&amp;&amp;d"n normal:
///             "A<u>b</u>c&amp;d" DT_PREFIXONLY: " _ " Compare with DT_HIDEPREFIX and DT_NOPREFIX. </td> </tr> <tr> <td
///             width="40%"><a id="DT_RIGHT"></a><a id="dt_right"></a><dl> <dt><b>DT_RIGHT</b></dt> </dl> </td> <td width="60%">
///             Aligns text to the right. </td> </tr> <tr> <td width="40%"><a id="DT_RTLREADING"></a><a
///             id="dt_rtlreading"></a><dl> <dt><b>DT_RTLREADING</b></dt> </dl> </td> <td width="60%"> Layout in right-to-left
///             reading order for bidirectional text when the font selected into the <i>hdc</i> is a Hebrew or Arabic font. The
///             default reading order for all text is left-to-right. </td> </tr> <tr> <td width="40%"><a
///             id="DT_SINGLELINE"></a><a id="dt_singleline"></a><dl> <dt><b>DT_SINGLELINE</b></dt> </dl> </td> <td width="60%">
///             Displays text on a single line only. Carriage returns and line feeds do not break the line. </td> </tr> <tr> <td
///             width="40%"><a id="DT_TABSTOP"></a><a id="dt_tabstop"></a><dl> <dt><b>DT_TABSTOP</b></dt> </dl> </td> <td
///             width="60%"> Sets tab stops. Bits 15-8 (high-order byte of the low-order word) of the <i>uFormat</i> parameter
///             specify the number of characters for each tab. The default number of characters per tab is eight. The
///             DT_CALCRECT, DT_EXTERNALLEADING, DT_INTERNAL, DT_NOCLIP, and DT_NOPREFIX values cannot be used with the
///             DT_TABSTOP value. </td> </tr> <tr> <td width="40%"><a id="DT_TOP"></a><a id="dt_top"></a><dl>
///             <dt><b>DT_TOP</b></dt> </dl> </td> <td width="60%"> Justifies the text to the top of the rectangle. </td> </tr>
///             <tr> <td width="40%"><a id="DT_VCENTER"></a><a id="dt_vcenter"></a><dl> <dt><b>DT_VCENTER</b></dt> </dl> </td>
///             <td width="60%"> Centers text vertically. This value is used only with the DT_SINGLELINE value. </td> </tr> <tr>
///             <td width="40%"><a id="DT_WORDBREAK"></a><a id="dt_wordbreak"></a><dl> <dt><b>DT_WORDBREAK</b></dt> </dl> </td>
///             <td width="60%"> Breaks words. Lines are automatically broken between words if a word would extend past the edge
///             of the rectangle specified by the <i>lpRect</i> parameter. A carriage return-line feed sequence also breaks the
///             line. If this is not specified, output is on one line. </td> </tr> <tr> <td width="40%"><a
///             id="DT_WORD_ELLIPSIS"></a><a id="dt_word_ellipsis"></a><dl> <dt><b>DT_WORD_ELLIPSIS</b></dt> </dl> </td> <td
///             width="60%"> Truncates any word that does not fit in the rectangle and adds ellipses. Compare with
///             DT_END_ELLIPSIS and DT_PATH_ELLIPSIS. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the height of the text in logical units. If DT_VCENTER or DT_BOTTOM
///    is specified, the return value is the offset from <code>lpRect-&gt;top</code> to the bottom of the drawn text If
///    the function fails, the return value is zero.
///    
@DllImport("USER32")
int DrawTextW(HDC hdc, const(wchar)* lpchText, int cchText, RECT* lprc, uint format);

///The <b>DrawTextEx</b> function draws formatted text in the specified rectangle.
///Params:
///    hdc = A handle to the device context in which to draw.
///    lpchText = A pointer to the string that contains the text to draw. If the <i>cchText</i> parameter is -1, the string must be
///               null-terminated. If <i>dwDTFormat</i> includes DT_MODIFYSTRING, the function could add up to four additional
///               characters to this string. The buffer containing the string should be large enough to accommodate these extra
///               characters.
///    cchText = The length of the string pointed to by <i>lpchText</i>. If <i>cchText</i> is -1, then the <i>lpchText</i>
///              parameter is assumed to be a pointer to a null-terminated string and <b>DrawTextEx</b> computes the character
///              count automatically.
///    lprc = A pointer to a RECT structure that contains the rectangle, in logical coordinates, in which the text is to be
///           formatted.
///    format = The formatting options. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DT_BOTTOM"></a><a id="dt_bottom"></a><dl>
///             <dt><b>DT_BOTTOM</b></dt> </dl> </td> <td width="60%"> Justifies the text to the bottom of the rectangle. This
///             value is used only with the DT_SINGLELINE value. </td> </tr> <tr> <td width="40%"><a id="DT_CALCRECT"></a><a
///             id="dt_calcrect"></a><dl> <dt><b>DT_CALCRECT</b></dt> </dl> </td> <td width="60%"> Determines the width and
///             height of the rectangle. If there are multiple lines of text, <b>DrawTextEx</b> uses the width of the rectangle
///             pointed to by the <i>lprc</i> parameter and extends the base of the rectangle to bound the last line of text. If
///             there is only one line of text, <b>DrawTextEx</b> modifies the right side of the rectangle so that it bounds the
///             last character in the line. In either case, <b>DrawTextEx</b> returns the height of the formatted text, but does
///             not draw the text. </td> </tr> <tr> <td width="40%"><a id="DT_CENTER"></a><a id="dt_center"></a><dl>
///             <dt><b>DT_CENTER</b></dt> </dl> </td> <td width="60%"> Centers text horizontally in the rectangle. </td> </tr>
///             <tr> <td width="40%"><a id="DT_EDITCONTROL"></a><a id="dt_editcontrol"></a><dl> <dt><b>DT_EDITCONTROL</b></dt>
///             </dl> </td> <td width="60%"> Duplicates the text-displaying characteristics of a multiline edit control.
///             Specifically, the average character width is calculated in the same manner as for an edit control, and the
///             function does not display a partially visible last line. </td> </tr> <tr> <td width="40%"><a
///             id="DT_END_ELLIPSIS"></a><a id="dt_end_ellipsis"></a><dl> <dt><b>DT_END_ELLIPSIS</b></dt> </dl> </td> <td
///             width="60%"> For displayed text, replaces the end of a string with ellipses so that the result fits in the
///             specified rectangle. Any word (not at the end of the string) that goes beyond the limits of the rectangle is
///             truncated without ellipses. The string is not modified unless the DT_MODIFYSTRING flag is specified. Compare with
///             DT_PATH_ELLIPSIS and DT_WORD_ELLIPSIS. </td> </tr> <tr> <td width="40%"><a id="DT_EXPANDTABS"></a><a
///             id="dt_expandtabs"></a><dl> <dt><b>DT_EXPANDTABS</b></dt> </dl> </td> <td width="60%"> Expands tab characters.
///             The default number of characters per tab is eight. </td> </tr> <tr> <td width="40%"><a
///             id="DT_EXTERNALLEADING"></a><a id="dt_externalleading"></a><dl> <dt><b>DT_EXTERNALLEADING</b></dt> </dl> </td>
///             <td width="60%"> Includes the font external leading in line height. Normally, external leading is not included in
///             the height of a line of text. </td> </tr> <tr> <td width="40%"><a id="DT_HIDEPREFIX"></a><a
///             id="dt_hideprefix"></a><dl> <dt><b>DT_HIDEPREFIX</b></dt> </dl> </td> <td width="60%"> Ignores the ampersand
///             (&amp;) prefix character in the text. The letter that follows will not be underlined, but other mnemonic-prefix
///             characters are still processed. Example: input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d"
///             DT_HIDEPREFIX: "Abc&amp;d" Compare with DT_NOPREFIX and DT_PREFIXONLY. </td> </tr> <tr> <td width="40%"><a
///             id="DT_INTERNAL"></a><a id="dt_internal"></a><dl> <dt><b>DT_INTERNAL</b></dt> </dl> </td> <td width="60%"> Uses
///             the system font to calculate text metrics. </td> </tr> <tr> <td width="40%"><a id="DT_LEFT"></a><a
///             id="dt_left"></a><dl> <dt><b>DT_LEFT</b></dt> </dl> </td> <td width="60%"> Aligns text to the left. </td> </tr>
///             <tr> <td width="40%"><a id="DT_MODIFYSTRING"></a><a id="dt_modifystring"></a><dl> <dt><b>DT_MODIFYSTRING</b></dt>
///             </dl> </td> <td width="60%"> Modifies the specified string to match the displayed text. This value has no effect
///             unless DT_END_ELLIPSIS or DT_PATH_ELLIPSIS is specified. </td> </tr> <tr> <td width="40%"><a
///             id="DT_NOCLIP"></a><a id="dt_noclip"></a><dl> <dt><b>DT_NOCLIP</b></dt> </dl> </td> <td width="60%"> Draws
///             without clipping. <b>DrawTextEx</b> is somewhat faster when DT_NOCLIP is used. </td> </tr> <tr> <td
///             width="40%"><a id="DT_NOFULLWIDTHCHARBREAK"></a><a id="dt_nofullwidthcharbreak"></a><dl>
///             <dt><b>DT_NOFULLWIDTHCHARBREAK</b></dt> </dl> </td> <td width="60%"> Prevents a line break at a DBCS (double-wide
///             character string), so that the line-breaking rule is equivalent to SBCS strings. For example, this can be used in
///             Korean windows, for more readability of icon labels. This value has no effect unless DT_WORDBREAK is specified.
///             </td> </tr> <tr> <td width="40%"><a id="DT_NOPREFIX"></a><a id="dt_noprefix"></a><dl> <dt><b>DT_NOPREFIX</b></dt>
///             </dl> </td> <td width="60%"> Turns off processing of prefix characters. Normally, <b>DrawTextEx</b> interprets
///             the ampersand (&amp;) mnemonic-prefix character as a directive to underscore the character that follows, and the
///             double-ampersand (&amp;&amp;) mnemonic-prefix characters as a directive to print a single ampersand. By
///             specifying DT_NOPREFIX, this processing is turned off. Compare with DT_HIDEPREFIX and DT_PREFIXONLY </td> </tr>
///             <tr> <td width="40%"><a id="DT_PATH_ELLIPSIS"></a><a id="dt_path_ellipsis"></a><dl>
///             <dt><b>DT_PATH_ELLIPSIS</b></dt> </dl> </td> <td width="60%"> For displayed text, replaces characters in the
///             middle of the string with ellipses so that the result fits in the specified rectangle. If the string contains
///             backslash (\\) characters, DT_PATH_ELLIPSIS preserves as much as possible of the text after the last backslash.
///             The string is not modified unless the DT_MODIFYSTRING flag is specified. Compare with DT_END_ELLIPSIS and
///             DT_WORD_ELLIPSIS. </td> </tr> <tr> <td width="40%"><a id="DT_PREFIXONLY"></a><a id="dt_prefixonly"></a><dl>
///             <dt><b>DT_PREFIXONLY</b></dt> </dl> </td> <td width="60%"> Draws only an underline at the position of the
///             character following the ampersand (&amp;) prefix character. Does not draw any character in the string. Example:
///             input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d" PREFIXONLY: " _ " Compare with DT_NOPREFIX and
///             DT_HIDEPREFIX. </td> </tr> <tr> <td width="40%"><a id="DT_RIGHT"></a><a id="dt_right"></a><dl>
///             <dt><b>DT_RIGHT</b></dt> </dl> </td> <td width="60%"> Aligns text to the right. </td> </tr> <tr> <td
///             width="40%"><a id="DT_RTLREADING"></a><a id="dt_rtlreading"></a><dl> <dt><b>DT_RTLREADING</b></dt> </dl> </td>
///             <td width="60%"> Layout in right-to-left reading order for bidirectional text when the font selected into the
///             <i>hdc</i> is a Hebrew or Arabic font. The default reading order for all text is left-to-right. </td> </tr> <tr>
///             <td width="40%"><a id="DT_SINGLELINE"></a><a id="dt_singleline"></a><dl> <dt><b>DT_SINGLELINE</b></dt> </dl>
///             </td> <td width="60%"> Displays text on a single line only. Carriage returns and line feeds do not break the
///             line. </td> </tr> <tr> <td width="40%"><a id="DT_TABSTOP"></a><a id="dt_tabstop"></a><dl>
///             <dt><b>DT_TABSTOP</b></dt> </dl> </td> <td width="60%"> Sets tab stops. The DRAWTEXTPARAMS structure pointed to
///             by the <i>lpDTParams</i> parameter specifies the number of average character widths per tab stop. </td> </tr>
///             <tr> <td width="40%"><a id="DT_TOP"></a><a id="dt_top"></a><dl> <dt><b>DT_TOP</b></dt> </dl> </td> <td
///             width="60%"> Justifies the text to the top of the rectangle. </td> </tr> <tr> <td width="40%"><a
///             id="DT_VCENTER"></a><a id="dt_vcenter"></a><dl> <dt><b>DT_VCENTER</b></dt> </dl> </td> <td width="60%"> Centers
///             text vertically. This value is used only with the DT_SINGLELINE value. </td> </tr> <tr> <td width="40%"><a
///             id="DT_WORDBREAK"></a><a id="dt_wordbreak"></a><dl> <dt><b>DT_WORDBREAK</b></dt> </dl> </td> <td width="60%">
///             Breaks words. Lines are automatically broken between words if a word extends past the edge of the rectangle
///             specified by the <i>lprc</i> parameter. A carriage return-line feed sequence also breaks the line. </td> </tr>
///             <tr> <td width="40%"><a id="DT_WORD_ELLIPSIS"></a><a id="dt_word_ellipsis"></a><dl>
///             <dt><b>DT_WORD_ELLIPSIS</b></dt> </dl> </td> <td width="60%"> Truncates any word that does not fit in the
///             rectangle and adds ellipses. Compare with DT_END_ELLIPSIS and DT_PATH_ELLIPSIS. </td> </tr> </table>
///    lpdtp = A pointer to a DRAWTEXTPARAMS structure that specifies additional formatting options. This parameter can be
///            <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is the text height in logical units. If DT_VCENTER or DT_BOTTOM is
///    specified, the return value is the offset from <code>lprc-&gt;top</code> to the bottom of the drawn text If the
///    function fails, the return value is zero.
///    
@DllImport("USER32")
int DrawTextExA(HDC hdc, const(char)* lpchText, int cchText, RECT* lprc, uint format, DRAWTEXTPARAMS* lpdtp);

///The <b>DrawTextEx</b> function draws formatted text in the specified rectangle.
///Params:
///    hdc = A handle to the device context in which to draw.
///    lpchText = A pointer to the string that contains the text to draw. If the <i>cchText</i> parameter is -1, the string must be
///               null-terminated. If <i>dwDTFormat</i> includes DT_MODIFYSTRING, the function could add up to four additional
///               characters to this string. The buffer containing the string should be large enough to accommodate these extra
///               characters.
///    cchText = The length of the string pointed to by <i>lpchText</i>. If <i>cchText</i> is -1, then the <i>lpchText</i>
///              parameter is assumed to be a pointer to a null-terminated string and <b>DrawTextEx</b> computes the character
///              count automatically.
///    lprc = A pointer to a RECT structure that contains the rectangle, in logical coordinates, in which the text is to be
///           formatted.
///    format = The formatting options. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DT_BOTTOM"></a><a id="dt_bottom"></a><dl>
///             <dt><b>DT_BOTTOM</b></dt> </dl> </td> <td width="60%"> Justifies the text to the bottom of the rectangle. This
///             value is used only with the DT_SINGLELINE value. </td> </tr> <tr> <td width="40%"><a id="DT_CALCRECT"></a><a
///             id="dt_calcrect"></a><dl> <dt><b>DT_CALCRECT</b></dt> </dl> </td> <td width="60%"> Determines the width and
///             height of the rectangle. If there are multiple lines of text, <b>DrawTextEx</b> uses the width of the rectangle
///             pointed to by the <i>lprc</i> parameter and extends the base of the rectangle to bound the last line of text. If
///             there is only one line of text, <b>DrawTextEx</b> modifies the right side of the rectangle so that it bounds the
///             last character in the line. In either case, <b>DrawTextEx</b> returns the height of the formatted text, but does
///             not draw the text. </td> </tr> <tr> <td width="40%"><a id="DT_CENTER"></a><a id="dt_center"></a><dl>
///             <dt><b>DT_CENTER</b></dt> </dl> </td> <td width="60%"> Centers text horizontally in the rectangle. </td> </tr>
///             <tr> <td width="40%"><a id="DT_EDITCONTROL"></a><a id="dt_editcontrol"></a><dl> <dt><b>DT_EDITCONTROL</b></dt>
///             </dl> </td> <td width="60%"> Duplicates the text-displaying characteristics of a multiline edit control.
///             Specifically, the average character width is calculated in the same manner as for an edit control, and the
///             function does not display a partially visible last line. </td> </tr> <tr> <td width="40%"><a
///             id="DT_END_ELLIPSIS"></a><a id="dt_end_ellipsis"></a><dl> <dt><b>DT_END_ELLIPSIS</b></dt> </dl> </td> <td
///             width="60%"> For displayed text, replaces the end of a string with ellipses so that the result fits in the
///             specified rectangle. Any word (not at the end of the string) that goes beyond the limits of the rectangle is
///             truncated without ellipses. The string is not modified unless the DT_MODIFYSTRING flag is specified. Compare with
///             DT_PATH_ELLIPSIS and DT_WORD_ELLIPSIS. </td> </tr> <tr> <td width="40%"><a id="DT_EXPANDTABS"></a><a
///             id="dt_expandtabs"></a><dl> <dt><b>DT_EXPANDTABS</b></dt> </dl> </td> <td width="60%"> Expands tab characters.
///             The default number of characters per tab is eight. </td> </tr> <tr> <td width="40%"><a
///             id="DT_EXTERNALLEADING"></a><a id="dt_externalleading"></a><dl> <dt><b>DT_EXTERNALLEADING</b></dt> </dl> </td>
///             <td width="60%"> Includes the font external leading in line height. Normally, external leading is not included in
///             the height of a line of text. </td> </tr> <tr> <td width="40%"><a id="DT_HIDEPREFIX"></a><a
///             id="dt_hideprefix"></a><dl> <dt><b>DT_HIDEPREFIX</b></dt> </dl> </td> <td width="60%"> Ignores the ampersand
///             (&amp;) prefix character in the text. The letter that follows will not be underlined, but other mnemonic-prefix
///             characters are still processed. Example: input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d"
///             DT_HIDEPREFIX: "Abc&amp;d" Compare with DT_NOPREFIX and DT_PREFIXONLY. </td> </tr> <tr> <td width="40%"><a
///             id="DT_INTERNAL"></a><a id="dt_internal"></a><dl> <dt><b>DT_INTERNAL</b></dt> </dl> </td> <td width="60%"> Uses
///             the system font to calculate text metrics. </td> </tr> <tr> <td width="40%"><a id="DT_LEFT"></a><a
///             id="dt_left"></a><dl> <dt><b>DT_LEFT</b></dt> </dl> </td> <td width="60%"> Aligns text to the left. </td> </tr>
///             <tr> <td width="40%"><a id="DT_MODIFYSTRING"></a><a id="dt_modifystring"></a><dl> <dt><b>DT_MODIFYSTRING</b></dt>
///             </dl> </td> <td width="60%"> Modifies the specified string to match the displayed text. This value has no effect
///             unless DT_END_ELLIPSIS or DT_PATH_ELLIPSIS is specified. </td> </tr> <tr> <td width="40%"><a
///             id="DT_NOCLIP"></a><a id="dt_noclip"></a><dl> <dt><b>DT_NOCLIP</b></dt> </dl> </td> <td width="60%"> Draws
///             without clipping. <b>DrawTextEx</b> is somewhat faster when DT_NOCLIP is used. </td> </tr> <tr> <td
///             width="40%"><a id="DT_NOFULLWIDTHCHARBREAK"></a><a id="dt_nofullwidthcharbreak"></a><dl>
///             <dt><b>DT_NOFULLWIDTHCHARBREAK</b></dt> </dl> </td> <td width="60%"> Prevents a line break at a DBCS (double-wide
///             character string), so that the line-breaking rule is equivalent to SBCS strings. For example, this can be used in
///             Korean windows, for more readability of icon labels. This value has no effect unless DT_WORDBREAK is specified.
///             </td> </tr> <tr> <td width="40%"><a id="DT_NOPREFIX"></a><a id="dt_noprefix"></a><dl> <dt><b>DT_NOPREFIX</b></dt>
///             </dl> </td> <td width="60%"> Turns off processing of prefix characters. Normally, <b>DrawTextEx</b> interprets
///             the ampersand (&amp;) mnemonic-prefix character as a directive to underscore the character that follows, and the
///             double-ampersand (&amp;&amp;) mnemonic-prefix characters as a directive to print a single ampersand. By
///             specifying DT_NOPREFIX, this processing is turned off. Compare with DT_HIDEPREFIX and DT_PREFIXONLY </td> </tr>
///             <tr> <td width="40%"><a id="DT_PATH_ELLIPSIS"></a><a id="dt_path_ellipsis"></a><dl>
///             <dt><b>DT_PATH_ELLIPSIS</b></dt> </dl> </td> <td width="60%"> For displayed text, replaces characters in the
///             middle of the string with ellipses so that the result fits in the specified rectangle. If the string contains
///             backslash (\\) characters, DT_PATH_ELLIPSIS preserves as much as possible of the text after the last backslash.
///             The string is not modified unless the DT_MODIFYSTRING flag is specified. Compare with DT_END_ELLIPSIS and
///             DT_WORD_ELLIPSIS. </td> </tr> <tr> <td width="40%"><a id="DT_PREFIXONLY"></a><a id="dt_prefixonly"></a><dl>
///             <dt><b>DT_PREFIXONLY</b></dt> </dl> </td> <td width="60%"> Draws only an underline at the position of the
///             character following the ampersand (&amp;) prefix character. Does not draw any character in the string. Example:
///             input string: "A&amp;bc&amp;&amp;d" normal: "A<u>b</u>c&amp;d" PREFIXONLY: " _ " Compare with DT_NOPREFIX and
///             DT_HIDEPREFIX. </td> </tr> <tr> <td width="40%"><a id="DT_RIGHT"></a><a id="dt_right"></a><dl>
///             <dt><b>DT_RIGHT</b></dt> </dl> </td> <td width="60%"> Aligns text to the right. </td> </tr> <tr> <td
///             width="40%"><a id="DT_RTLREADING"></a><a id="dt_rtlreading"></a><dl> <dt><b>DT_RTLREADING</b></dt> </dl> </td>
///             <td width="60%"> Layout in right-to-left reading order for bidirectional text when the font selected into the
///             <i>hdc</i> is a Hebrew or Arabic font. The default reading order for all text is left-to-right. </td> </tr> <tr>
///             <td width="40%"><a id="DT_SINGLELINE"></a><a id="dt_singleline"></a><dl> <dt><b>DT_SINGLELINE</b></dt> </dl>
///             </td> <td width="60%"> Displays text on a single line only. Carriage returns and line feeds do not break the
///             line. </td> </tr> <tr> <td width="40%"><a id="DT_TABSTOP"></a><a id="dt_tabstop"></a><dl>
///             <dt><b>DT_TABSTOP</b></dt> </dl> </td> <td width="60%"> Sets tab stops. The DRAWTEXTPARAMS structure pointed to
///             by the <i>lpDTParams</i> parameter specifies the number of average character widths per tab stop. </td> </tr>
///             <tr> <td width="40%"><a id="DT_TOP"></a><a id="dt_top"></a><dl> <dt><b>DT_TOP</b></dt> </dl> </td> <td
///             width="60%"> Justifies the text to the top of the rectangle. </td> </tr> <tr> <td width="40%"><a
///             id="DT_VCENTER"></a><a id="dt_vcenter"></a><dl> <dt><b>DT_VCENTER</b></dt> </dl> </td> <td width="60%"> Centers
///             text vertically. This value is used only with the DT_SINGLELINE value. </td> </tr> <tr> <td width="40%"><a
///             id="DT_WORDBREAK"></a><a id="dt_wordbreak"></a><dl> <dt><b>DT_WORDBREAK</b></dt> </dl> </td> <td width="60%">
///             Breaks words. Lines are automatically broken between words if a word extends past the edge of the rectangle
///             specified by the <i>lprc</i> parameter. A carriage return-line feed sequence also breaks the line. </td> </tr>
///             <tr> <td width="40%"><a id="DT_WORD_ELLIPSIS"></a><a id="dt_word_ellipsis"></a><dl>
///             <dt><b>DT_WORD_ELLIPSIS</b></dt> </dl> </td> <td width="60%"> Truncates any word that does not fit in the
///             rectangle and adds ellipses. Compare with DT_END_ELLIPSIS and DT_PATH_ELLIPSIS. </td> </tr> </table>
///    lpdtp = A pointer to a DRAWTEXTPARAMS structure that specifies additional formatting options. This parameter can be
///            <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is the text height in logical units. If DT_VCENTER or DT_BOTTOM is
///    specified, the return value is the offset from <code>lprc-&gt;top</code> to the bottom of the drawn text If the
///    function fails, the return value is zero.
///    
@DllImport("USER32")
int DrawTextExW(HDC hdc, const(wchar)* lpchText, int cchText, RECT* lprc, uint format, DRAWTEXTPARAMS* lpdtp);

///The <b>GrayString</b> function draws gray text at the specified location. The function draws the text by copying it
///into a memory bitmap, graying the bitmap, and then copying the bitmap to the screen. The function grays the text
///regardless of the selected brush and background. <b>GrayString</b> uses the font currently selected for the specified
///device context. If thelpOutputFuncparameter is <b>NULL</b>, GDI uses the TextOut function, and thelpDataparameter is
///assumed to be a pointer to the character string to be output. If the characters to be output cannot be handled by
///<b>TextOut</b> (for example, the string is stored as a bitmap), the application must supply its own output function.
///Params:
///    hDC = A handle to the device context.
///    hBrush = A handle to the brush to be used for graying. If this parameter is <b>NULL</b>, the text is grayed with the same
///             brush that was used to draw window text.
///    lpOutputFunc = A pointer to the application-defined function that will draw the string, or, if TextOut is to be used to draw the
///                   string, it is a <b>NULL</b> pointer. For details, see the OutputProc callback function.
///    lpData = A pointer to data to be passed to the output function. If the <i>lpOutputFunc</i> parameter is <b>NULL</b>,
///             <i>lpData</i> must be a pointer to the string to be output.
///    nCount = The number of characters to be output. If the <i>nCount</i> parameter is zero, <b>GrayString</b> calculates the
///             length of the string (assuming <i>lpData</i> is a pointer to the string). If <i>nCount</i> is 1 and the function
///             pointed to by <i>lpOutputFunc</i> returns <b>FALSE</b>, the image is shown but not grayed.
///    X = The device x-coordinate of the starting position of the rectangle that encloses the string.
///    Y = The device y-coordinate of the starting position of the rectangle that encloses the string.
///    nWidth = The width, in device units, of the rectangle that encloses the string. If this parameter is zero,
///             <b>GrayString</b> calculates the width of the area, assuming <i>lpData</i> is a pointer to the string.
///    nHeight = The height, in device units, of the rectangle that encloses the string. If this parameter is zero,
///              <b>GrayString</b> calculates the height of the area, assuming <i>lpData</i> is a pointer to the string.
///Returns:
///    If the string is drawn, the return value is nonzero. If either the TextOut function or the application-defined
///    output function returned zero, or there was insufficient memory to create a memory bitmap for graying, the return
///    value is zero.
///    
@DllImport("USER32")
BOOL GrayStringA(HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, 
                 int nWidth, int nHeight);

///The <b>GrayString</b> function draws gray text at the specified location. The function draws the text by copying it
///into a memory bitmap, graying the bitmap, and then copying the bitmap to the screen. The function grays the text
///regardless of the selected brush and background. <b>GrayString</b> uses the font currently selected for the specified
///device context. If thelpOutputFuncparameter is <b>NULL</b>, GDI uses the TextOut function, and thelpDataparameter is
///assumed to be a pointer to the character string to be output. If the characters to be output cannot be handled by
///<b>TextOut</b> (for example, the string is stored as a bitmap), the application must supply its own output function.
///Params:
///    hDC = A handle to the device context.
///    hBrush = A handle to the brush to be used for graying. If this parameter is <b>NULL</b>, the text is grayed with the same
///             brush that was used to draw window text.
///    lpOutputFunc = A pointer to the application-defined function that will draw the string, or, if TextOut is to be used to draw the
///                   string, it is a <b>NULL</b> pointer. For details, see the OutputProc callback function.
///    lpData = A pointer to data to be passed to the output function. If the <i>lpOutputFunc</i> parameter is <b>NULL</b>,
///             <i>lpData</i> must be a pointer to the string to be output.
///    nCount = The number of characters to be output. If the <i>nCount</i> parameter is zero, <b>GrayString</b> calculates the
///             length of the string (assuming <i>lpData</i> is a pointer to the string). If <i>nCount</i> is 1 and the function
///             pointed to by <i>lpOutputFunc</i> returns <b>FALSE</b>, the image is shown but not grayed.
///    X = The device x-coordinate of the starting position of the rectangle that encloses the string.
///    Y = The device y-coordinate of the starting position of the rectangle that encloses the string.
///    nWidth = The width, in device units, of the rectangle that encloses the string. If this parameter is zero,
///             <b>GrayString</b> calculates the width of the area, assuming <i>lpData</i> is a pointer to the string.
///    nHeight = The height, in device units, of the rectangle that encloses the string. If this parameter is zero,
///              <b>GrayString</b> calculates the height of the area, assuming <i>lpData</i> is a pointer to the string.
///Returns:
///    If the string is drawn, the return value is nonzero. If either the TextOut function or the application-defined
///    output function returned zero, or there was insufficient memory to create a memory bitmap for graying, the return
///    value is zero.
///    
@DllImport("USER32")
BOOL GrayStringW(HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, 
                 int nWidth, int nHeight);

///The <b>DrawState</b> function displays an image and applies a visual effect to indicate a state, such as a disabled
///or default state.
///Params:
///    hdc = A handle to the device context to draw in.
///    hbrFore = A handle to the brush used to draw the image, if the state specified by the <i>fuFlags</i> parameter is DSS_MONO.
///              This parameter is ignored for other states.
///    qfnCallBack = A pointer to an application-defined callback function used to render the image. This parameter is required if the
///                  image type in <i>fuFlags</i> is DST_COMPLEX. It is optional and can be <b>NULL</b> if the image type is DST_TEXT.
///                  For all other image types, this parameter is ignored. For more information about the callback function, see the
///                  DrawStateProc function.
///    lData = Information about the image. The meaning of this parameter depends on the image type.
///    wData = Information about the image. The meaning of this parameter depends on the image type. It is, however, zero
///            extended for use with the DrawStateProc function.
///    x = The horizontal location, in device units, at which to draw the image.
///    y = The vertical location, in device units, at which to draw the image.
///    cx = The width of the image, in device units. This parameter is required if the image type is DST_COMPLEX. Otherwise,
///         it can be zero to calculate the width of the image.
///    cy = The height of the image, in device units. This parameter is required if the image type is DST_COMPLEX. Otherwise,
///         it can be zero to calculate the height of the image.
///    uFlags = The image type and state. This parameter can be one of the following type values. <table> <tr> <th>Value
///             (type)</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DST_BITMAP"></a><a id="dst_bitmap"></a><dl>
///             <dt><b>DST_BITMAP</b></dt> </dl> </td> <td width="60%"> The image is a bitmap. The <i>lData</i> parameter is the
///             bitmap handle. Note that the bitmap cannot already be selected into an existing device context. </td> </tr> <tr>
///             <td width="40%"><a id="DST_COMPLEX"></a><a id="dst_complex"></a><dl> <dt><b>DST_COMPLEX</b></dt> </dl> </td> <td
///             width="60%"> The image is application defined. To render the image, <b>DrawState</b> calls the callback function
///             specified by the <i>lpOutputFunc</i> parameter. </td> </tr> <tr> <td width="40%"><a id="DST_ICON"></a><a
///             id="dst_icon"></a><dl> <dt><b>DST_ICON</b></dt> </dl> </td> <td width="60%"> The image is an icon. The
///             <i>lData</i> parameter is the icon handle. </td> </tr> <tr> <td width="40%"><a id="DST_PREFIXTEXT"></a><a
///             id="dst_prefixtext"></a><dl> <dt><b>DST_PREFIXTEXT</b></dt> </dl> </td> <td width="60%"> The image is text that
///             may contain an accelerator mnemonic. <b>DrawState</b> interprets the ampersand (&amp;) prefix character as a
///             directive to underscore the character that follows. The <i>lData</i> parameter is a pointer to the string, and
///             the <i>wData</i> parameter specifies the length. If <i>wData</i> is zero, the string must be null-terminated.
///             </td> </tr> <tr> <td width="40%"><a id="DST_TEXT"></a><a id="dst_text"></a><dl> <dt><b>DST_TEXT</b></dt> </dl>
///             </td> <td width="60%"> The image is text. The <i>lData</i> parameter is a pointer to the string, and the
///             <i>wData</i> parameter specifies the length. If <i>wData</i> is zero, the string must be null-terminated. </td>
///             </tr> </table> This parameter can also be one of the following state values. <table> <tr> <th>Value (state)</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DSS_DISABLED"></a><a id="dss_disabled"></a><dl>
///             <dt><b>DSS_DISABLED</b></dt> </dl> </td> <td width="60%"> Embosses the image. </td> </tr> <tr> <td width="40%"><a
///             id="DSS_HIDEPREFIX"></a><a id="dss_hideprefix"></a><dl> <dt><b>DSS_HIDEPREFIX</b></dt> </dl> </td> <td
///             width="60%"> Ignores the ampersand (&amp;) prefix character in the text, thus the letter that follows will not be
///             underlined. This must be used with DST_PREFIXTEXT. </td> </tr> <tr> <td width="40%"><a id="DSS_MONO"></a><a
///             id="dss_mono"></a><dl> <dt><b>DSS_MONO</b></dt> </dl> </td> <td width="60%"> Draws the image using the brush
///             specified by the <i>hbr</i> parameter. </td> </tr> <tr> <td width="40%"><a id="DSS_NORMAL"></a><a
///             id="dss_normal"></a><dl> <dt><b>DSS_NORMAL</b></dt> </dl> </td> <td width="60%"> Draws the image without any
///             modification. </td> </tr> <tr> <td width="40%"><a id="DSS_PREFIXONLY"></a><a id="dss_prefixonly"></a><dl>
///             <dt><b>DSS_PREFIXONLY</b></dt> </dl> </td> <td width="60%"> Draws only the underline at the position of the
///             letter after the ampersand (&amp;) prefix character. No text in the string is drawn. This must be used with
///             DST_PREFIXTEXT. </td> </tr> <tr> <td width="40%"><a id="DSS_RIGHT"></a><a id="dss_right"></a><dl>
///             <dt><b>DSS_RIGHT</b></dt> </dl> </td> <td width="60%"> Aligns the text to the right. </td> </tr> <tr> <td
///             width="40%"><a id="DSS_UNION"></a><a id="dss_union"></a><dl> <dt><b>DSS_UNION</b></dt> </dl> </td> <td
///             width="60%"> Dithers the image. </td> </tr> </table> For all states except DSS_NORMAL, the image is converted to
///             monochrome before the visual effect is applied.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL DrawStateA(HDC hdc, HBRUSH hbrFore, DRAWSTATEPROC qfnCallBack, LPARAM lData, WPARAM wData, int x, int y, 
                int cx, int cy, uint uFlags);

///The <b>DrawState</b> function displays an image and applies a visual effect to indicate a state, such as a disabled
///or default state.
///Params:
///    hdc = A handle to the device context to draw in.
///    hbrFore = A handle to the brush used to draw the image, if the state specified by the <i>fuFlags</i> parameter is DSS_MONO.
///              This parameter is ignored for other states.
///    qfnCallBack = A pointer to an application-defined callback function used to render the image. This parameter is required if the
///                  image type in <i>fuFlags</i> is DST_COMPLEX. It is optional and can be <b>NULL</b> if the image type is DST_TEXT.
///                  For all other image types, this parameter is ignored. For more information about the callback function, see the
///                  DrawStateProc function.
///    lData = Information about the image. The meaning of this parameter depends on the image type.
///    wData = Information about the image. The meaning of this parameter depends on the image type. It is, however, zero
///            extended for use with the DrawStateProc function.
///    x = The horizontal location, in device units, at which to draw the image.
///    y = The vertical location, in device units, at which to draw the image.
///    cx = The width of the image, in device units. This parameter is required if the image type is DST_COMPLEX. Otherwise,
///         it can be zero to calculate the width of the image.
///    cy = The height of the image, in device units. This parameter is required if the image type is DST_COMPLEX. Otherwise,
///         it can be zero to calculate the height of the image.
///    uFlags = The image type and state. This parameter can be one of the following type values. <table> <tr> <th>Value
///             (type)</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DST_BITMAP"></a><a id="dst_bitmap"></a><dl>
///             <dt><b>DST_BITMAP</b></dt> </dl> </td> <td width="60%"> The image is a bitmap. The <i>lData</i> parameter is the
///             bitmap handle. Note that the bitmap cannot already be selected into an existing device context. </td> </tr> <tr>
///             <td width="40%"><a id="DST_COMPLEX"></a><a id="dst_complex"></a><dl> <dt><b>DST_COMPLEX</b></dt> </dl> </td> <td
///             width="60%"> The image is application defined. To render the image, <b>DrawState</b> calls the callback function
///             specified by the <i>lpOutputFunc</i> parameter. </td> </tr> <tr> <td width="40%"><a id="DST_ICON"></a><a
///             id="dst_icon"></a><dl> <dt><b>DST_ICON</b></dt> </dl> </td> <td width="60%"> The image is an icon. The
///             <i>lData</i> parameter is the icon handle. </td> </tr> <tr> <td width="40%"><a id="DST_PREFIXTEXT"></a><a
///             id="dst_prefixtext"></a><dl> <dt><b>DST_PREFIXTEXT</b></dt> </dl> </td> <td width="60%"> The image is text that
///             may contain an accelerator mnemonic. <b>DrawState</b> interprets the ampersand (&amp;) prefix character as a
///             directive to underscore the character that follows. The <i>lData</i> parameter is a pointer to the string, and
///             the <i>wData</i> parameter specifies the length. If <i>wData</i> is zero, the string must be null-terminated.
///             </td> </tr> <tr> <td width="40%"><a id="DST_TEXT"></a><a id="dst_text"></a><dl> <dt><b>DST_TEXT</b></dt> </dl>
///             </td> <td width="60%"> The image is text. The <i>lData</i> parameter is a pointer to the string, and the
///             <i>wData</i> parameter specifies the length. If <i>wData</i> is zero, the string must be null-terminated. </td>
///             </tr> </table> This parameter can also be one of the following state values. <table> <tr> <th>Value (state)</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DSS_DISABLED"></a><a id="dss_disabled"></a><dl>
///             <dt><b>DSS_DISABLED</b></dt> </dl> </td> <td width="60%"> Embosses the image. </td> </tr> <tr> <td width="40%"><a
///             id="DSS_HIDEPREFIX"></a><a id="dss_hideprefix"></a><dl> <dt><b>DSS_HIDEPREFIX</b></dt> </dl> </td> <td
///             width="60%"> Ignores the ampersand (&amp;) prefix character in the text, thus the letter that follows will not be
///             underlined. This must be used with DST_PREFIXTEXT. </td> </tr> <tr> <td width="40%"><a id="DSS_MONO"></a><a
///             id="dss_mono"></a><dl> <dt><b>DSS_MONO</b></dt> </dl> </td> <td width="60%"> Draws the image using the brush
///             specified by the <i>hbr</i> parameter. </td> </tr> <tr> <td width="40%"><a id="DSS_NORMAL"></a><a
///             id="dss_normal"></a><dl> <dt><b>DSS_NORMAL</b></dt> </dl> </td> <td width="60%"> Draws the image without any
///             modification. </td> </tr> <tr> <td width="40%"><a id="DSS_PREFIXONLY"></a><a id="dss_prefixonly"></a><dl>
///             <dt><b>DSS_PREFIXONLY</b></dt> </dl> </td> <td width="60%"> Draws only the underline at the position of the
///             letter after the ampersand (&amp;) prefix character. No text in the string is drawn. This must be used with
///             DST_PREFIXTEXT. </td> </tr> <tr> <td width="40%"><a id="DSS_RIGHT"></a><a id="dss_right"></a><dl>
///             <dt><b>DSS_RIGHT</b></dt> </dl> </td> <td width="60%"> Aligns the text to the right. </td> </tr> <tr> <td
///             width="40%"><a id="DSS_UNION"></a><a id="dss_union"></a><dl> <dt><b>DSS_UNION</b></dt> </dl> </td> <td
///             width="60%"> Dithers the image. </td> </tr> </table> For all states except DSS_NORMAL, the image is converted to
///             monochrome before the visual effect is applied.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL DrawStateW(HDC hdc, HBRUSH hbrFore, DRAWSTATEPROC qfnCallBack, LPARAM lData, WPARAM wData, int x, int y, 
                int cx, int cy, uint uFlags);

///The <b>TabbedTextOut</b> function writes a character string at a specified location, expanding tabs to the values
///specified in an array of tab-stop positions. Text is written in the currently selected font, background color, and
///text color.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate of the starting point of the string, in logical units.
///    y = The y-coordinate of the starting point of the string, in logical units.
///    lpString = A pointer to the character string to draw. The string does not need to be zero-terminated, since <i>nCount</i>
///               specifies the length of the string.
///    chCount = The length of the string pointed to by <i>lpString</i>.
///    nTabPositions = The number of values in the array of tab-stop positions.
///    lpnTabStopPositions = A pointer to an array containing the tab-stop positions, in logical units. The tab stops must be sorted in
///                          increasing order; the smallest x-value should be the first item in the array.
///    nTabOrigin = The x-coordinate of the starting position from which tabs are expanded, in logical units.
///Returns:
///    If the function succeeds, the return value is the dimensions, in logical units, of the string. The height is in
///    the high-order word and the width is in the low-order word. If the function fails, the return value is zero.
///    
@DllImport("USER32")
int TabbedTextOutA(HDC hdc, int x, int y, const(char)* lpString, int chCount, int nTabPositions, 
                   char* lpnTabStopPositions, int nTabOrigin);

///The <b>TabbedTextOut</b> function writes a character string at a specified location, expanding tabs to the values
///specified in an array of tab-stop positions. Text is written in the currently selected font, background color, and
///text color.
///Params:
///    hdc = A handle to the device context.
///    x = The x-coordinate of the starting point of the string, in logical units.
///    y = The y-coordinate of the starting point of the string, in logical units.
///    lpString = A pointer to the character string to draw. The string does not need to be zero-terminated, since <i>nCount</i>
///               specifies the length of the string.
///    chCount = The length of the string pointed to by <i>lpString</i>.
///    nTabPositions = The number of values in the array of tab-stop positions.
///    lpnTabStopPositions = A pointer to an array containing the tab-stop positions, in logical units. The tab stops must be sorted in
///                          increasing order; the smallest x-value should be the first item in the array.
///    nTabOrigin = The x-coordinate of the starting position from which tabs are expanded, in logical units.
///Returns:
///    If the function succeeds, the return value is the dimensions, in logical units, of the string. The height is in
///    the high-order word and the width is in the low-order word. If the function fails, the return value is zero.
///    
@DllImport("USER32")
int TabbedTextOutW(HDC hdc, int x, int y, const(wchar)* lpString, int chCount, int nTabPositions, 
                   char* lpnTabStopPositions, int nTabOrigin);

///The <b>GetTabbedTextExtent</b> function computes the width and height of a character string. If the string contains
///one or more tab characters, the width of the string is based upon the specified tab stops. The
///<b>GetTabbedTextExtent</b> function uses the currently selected font to compute the dimensions of the string.
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to a character string.
///    chCount = The length of the text string. For the ANSI function it is a BYTE count and for the Unicode function it is a WORD
///              count. Note that for the ANSI function, characters in SBCS code pages take one byte each, while most characters
///              in DBCS code pages take two bytes; for the Unicode function, most currently defined Unicode characters (those in
///              the Basic Multilingual Plane (BMP)) are one WORD while Unicode surrogates are two WORDs.
///    nTabPositions = The number of tab-stop positions in the array pointed to by the <i>lpnTabStopPositions</i> parameter.
///    lpnTabStopPositions = A pointer to an array containing the tab-stop positions, in device units. The tab stops must be sorted in
///                          increasing order; the smallest x-value should be the first item in the array.
///Returns:
///    If the function succeeds, the return value is the dimensions of the string in logical units. The height is in the
///    high-order word and the width is in the low-order word. If the function fails, the return value is 0.
///    <b>GetTabbedTextExtent</b> will fail if <i>hDC</i> is invalid and if <i>nTabPositions</i> is less than 0.
///    
@DllImport("USER32")
uint GetTabbedTextExtentA(HDC hdc, const(char)* lpString, int chCount, int nTabPositions, 
                          char* lpnTabStopPositions);

///The <b>GetTabbedTextExtent</b> function computes the width and height of a character string. If the string contains
///one or more tab characters, the width of the string is based upon the specified tab stops. The
///<b>GetTabbedTextExtent</b> function uses the currently selected font to compute the dimensions of the string.
///Params:
///    hdc = A handle to the device context.
///    lpString = A pointer to a character string.
///    chCount = The length of the text string. For the ANSI function it is a BYTE count and for the Unicode function it is a WORD
///              count. Note that for the ANSI function, characters in SBCS code pages take one byte each, while most characters
///              in DBCS code pages take two bytes; for the Unicode function, most currently defined Unicode characters (those in
///              the Basic Multilingual Plane (BMP)) are one WORD while Unicode surrogates are two WORDs.
///    nTabPositions = The number of tab-stop positions in the array pointed to by the <i>lpnTabStopPositions</i> parameter.
///    lpnTabStopPositions = A pointer to an array containing the tab-stop positions, in device units. The tab stops must be sorted in
///                          increasing order; the smallest x-value should be the first item in the array.
///Returns:
///    If the function succeeds, the return value is the dimensions of the string in logical units. The height is in the
///    high-order word and the width is in the low-order word. If the function fails, the return value is 0.
///    <b>GetTabbedTextExtent</b> will fail if <i>hDC</i> is invalid and if <i>nTabPositions</i> is less than 0.
///    
@DllImport("USER32")
uint GetTabbedTextExtentW(HDC hdc, const(wchar)* lpString, int chCount, int nTabPositions, 
                          char* lpnTabStopPositions);

///The <b>UpdateWindow</b> function updates the client area of the specified window by sending a WM_PAINT message to the
///window if the window's update region is not empty. The function sends a <b>WM_PAINT</b> message directly to the
///window procedure of the specified window, bypassing the application queue. If the update region is empty, no message
///is sent.
///Params:
///    hWnd = Handle to the window to be updated.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL UpdateWindow(HWND hWnd);

///The <b>PaintDesktop</b> function fills the clipping region in the specified device context with the desktop pattern
///or wallpaper. The function is provided primarily for shell desktops.
///Params:
///    hdc = Handle to the device context.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL PaintDesktop(HDC hdc);

///The <b>WindowFromDC</b> function returns a handle to the window associated with the specified display device context
///(DC). Output functions that use the specified device context draw into this window.
///Params:
///    hDC = Handle to the device context from which a handle to the associated window is to be retrieved.
///Returns:
///    The return value is a handle to the window associated with the specified DC. If no window is associated with the
///    specified DC, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HWND WindowFromDC(HDC hDC);

///The <b>GetDC</b> function retrieves a handle to a device context (DC) for the client area of a specified window or
///for the entire screen. You can use the returned handle in subsequent GDI functions to draw in the DC. The device
///context is an opaque data structure, whose values are used internally by GDI. The GetDCEx function is an extension to
///<b>GetDC</b>, which gives an application more control over how and whether clipping occurs in the client area.
///Params:
///    hWnd = A handle to the window whose DC is to be retrieved. If this value is <b>NULL</b>, <b>GetDC</b> retrieves the DC
///           for the entire screen.
///Returns:
///    If the function succeeds, the return value is a handle to the DC for the specified window's client area. If the
///    function fails, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
HDC GetDC(HWND hWnd);

///The <b>GetDCEx</b> function retrieves a handle to a device context (DC) for the client area of a specified window or
///for the entire screen. You can use the returned handle in subsequent GDI functions to draw in the DC. The device
///context is an opaque data structure, whose values are used internally by GDI. This function is an extension to the
///GetDC function, which gives an application more control over how and whether clipping occurs in the client area.
///Params:
///    hWnd = A handle to the window whose DC is to be retrieved. If this value is <b>NULL</b>, <b>GetDCEx</b> retrieves the DC
///           for the entire screen.
///    hrgnClip = A clipping region that may be combined with the visible region of the DC. If the value of <i>flags</i> is
///               DCX_INTERSECTRGN or DCX_EXCLUDERGN, then the operating system assumes ownership of the region and will
///               automatically delete it when it is no longer needed. In this case, the application should not use or delete the
///               region after a successful call to <b>GetDCEx</b>.
///    flags = Specifies how the DC is created. This parameter can be one or more of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DCX_WINDOW"></a><a id="dcx_window"></a><dl>
///            <dt><b>DCX_WINDOW</b></dt> </dl> </td> <td width="60%"> Returns a DC that corresponds to the window rectangle
///            rather than the client rectangle. </td> </tr> <tr> <td width="40%"><a id="DCX_CACHE"></a><a
///            id="dcx_cache"></a><dl> <dt><b>DCX_CACHE</b></dt> </dl> </td> <td width="60%"> Returns a DC from the cache,
///            rather than the OWNDC or CLASSDC window. Essentially overrides CS_OWNDC and CS_CLASSDC. </td> </tr> <tr> <td
///            width="40%"><a id="DCX_PARENTCLIP"></a><a id="dcx_parentclip"></a><dl> <dt><b>DCX_PARENTCLIP</b></dt> </dl> </td>
///            <td width="60%"> Uses the visible region of the parent window. The parent's WS_CLIPCHILDREN and CS_PARENTDC style
///            bits are ignored. The origin is set to the upper-left corner of the window identified by <i>hWnd</i>. </td> </tr>
///            <tr> <td width="40%"><a id="DCX_CLIPSIBLINGS"></a><a id="dcx_clipsiblings"></a><dl>
///            <dt><b>DCX_CLIPSIBLINGS</b></dt> </dl> </td> <td width="60%"> Excludes the visible regions of all sibling windows
///            above the window identified by <i>hWnd</i>. </td> </tr> <tr> <td width="40%"><a id="DCX_CLIPCHILDREN"></a><a
///            id="dcx_clipchildren"></a><dl> <dt><b>DCX_CLIPCHILDREN</b></dt> </dl> </td> <td width="60%"> Excludes the visible
///            regions of all child windows below the window identified by <i>hWnd</i>. </td> </tr> <tr> <td width="40%"><a
///            id="DCX_NORESETATTRS"></a><a id="dcx_noresetattrs"></a><dl> <dt><b>DCX_NORESETATTRS</b></dt> </dl> </td> <td
///            width="60%"> This flag is ignored. </td> </tr> <tr> <td width="40%"><a id="DCX_LOCKWINDOWUPDATE"></a><a
///            id="dcx_lockwindowupdate"></a><dl> <dt><b>DCX_LOCKWINDOWUPDATE</b></dt> </dl> </td> <td width="60%"> Allows
///            drawing even if there is a LockWindowUpdate call in effect that would otherwise exclude this window. Used for
///            drawing during tracking. </td> </tr> <tr> <td width="40%"><a id="DCX_EXCLUDERGN"></a><a
///            id="dcx_excludergn"></a><dl> <dt><b>DCX_EXCLUDERGN</b></dt> </dl> </td> <td width="60%"> The clipping region
///            identified by <i>hrgnClip</i> is excluded from the visible region of the returned DC. </td> </tr> <tr> <td
///            width="40%"><a id="DCX_INTERSECTRGN"></a><a id="dcx_intersectrgn"></a><dl> <dt><b>DCX_INTERSECTRGN</b></dt> </dl>
///            </td> <td width="60%"> The clipping region identified by <i>hrgnClip</i> is intersected with the visible region
///            of the returned DC. </td> </tr> <tr> <td width="40%"><a id="DCX_INTERSECTUPDATE"></a><a
///            id="dcx_intersectupdate"></a><dl> <dt><b>DCX_INTERSECTUPDATE</b></dt> </dl> </td> <td width="60%"> Reserved; do
///            not use. </td> </tr> <tr> <td width="40%"><a id="DCX_VALIDATE"></a><a id="dcx_validate"></a><dl>
///            <dt><b>DCX_VALIDATE</b></dt> </dl> </td> <td width="60%"> Reserved; do not use. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is the handle to the DC for the specified window. If the function
///    fails, the return value is <b>NULL</b>. An invalid value for the <i>hWnd</i> parameter will cause the function to
///    fail.
///    
@DllImport("USER32")
HDC GetDCEx(HWND hWnd, HRGN hrgnClip, uint flags);

///The <b>GetWindowDC</b> function retrieves the device context (DC) for the entire window, including title bar, menus,
///and scroll bars. A window device context permits painting anywhere in a window, because the origin of the device
///context is the upper-left corner of the window instead of the client area. <b>GetWindowDC</b> assigns default
///attributes to the window device context each time it retrieves the device context. Previous attributes are lost.
///Params:
///    hWnd = A handle to the window with a device context that is to be retrieved. If this value is <b>NULL</b>,
///           <b>GetWindowDC</b> retrieves the device context for the entire screen. If this parameter is <b>NULL</b>,
///           <b>GetWindowDC</b> retrieves the device context for the primary display monitor. To get the device context for
///           other display monitors, use the EnumDisplayMonitors and CreateDC functions.
///Returns:
///    If the function succeeds, the return value is a handle to a device context for the specified window. If the
///    function fails, the return value is <b>NULL</b>, indicating an error or an invalid <i>hWnd</i> parameter.
///    
@DllImport("USER32")
HDC GetWindowDC(HWND hWnd);

///The <b>ReleaseDC</b> function releases a device context (DC), freeing it for use by other applications. The effect of
///the <b>ReleaseDC</b> function depends on the type of DC. It frees only common and window DCs. It has no effect on
///class or private DCs.
///Params:
///    hWnd = A handle to the window whose DC is to be released.
///    hDC = A handle to the DC to be released.
///Returns:
///    The return value indicates whether the DC was released. If the DC was released, the return value is 1. If the DC
///    was not released, the return value is zero.
///    
@DllImport("USER32")
int ReleaseDC(HWND hWnd, HDC hDC);

///The <b>BeginPaint</b> function prepares the specified window for painting and fills a PAINTSTRUCT structure with
///information about the painting.
///Params:
///    hWnd = Handle to the window to be repainted.
///    lpPaint = Pointer to the PAINTSTRUCT structure that will receive painting information.
///Returns:
///    If the function succeeds, the return value is the handle to a display device context for the specified window. If
///    the function fails, the return value is <b>NULL</b>, indicating that no display device context is available.
///    
@DllImport("USER32")
HDC BeginPaint(HWND hWnd, PAINTSTRUCT* lpPaint);

///The <b>EndPaint</b> function marks the end of painting in the specified window. This function is required for each
///call to the BeginPaint function, but only after painting is complete.
///Params:
///    hWnd = Handle to the window that has been repainted.
///    lpPaint = Pointer to a PAINTSTRUCT structure that contains the painting information retrieved by BeginPaint.
///Returns:
///    The return value is always nonzero.
///    
@DllImport("USER32")
BOOL EndPaint(HWND hWnd, const(PAINTSTRUCT)* lpPaint);

///The <b>GetUpdateRect</b> function retrieves the coordinates of the smallest rectangle that completely encloses the
///update region of the specified window. <b>GetUpdateRect</b> retrieves the rectangle in logical coordinates. If there
///is no update region, <b>GetUpdateRect</b> retrieves an empty rectangle (sets all coordinates to zero).
///Params:
///    hWnd = Handle to the window whose update region is to be retrieved.
///    lpRect = Pointer to the RECT structure that receives the coordinates, in device units, of the enclosing rectangle. An
///             application can set this parameter to <b>NULL</b> to determine whether an update region exists for the window. If
///             this parameter is <b>NULL</b>, <b>GetUpdateRect</b> returns nonzero if an update region exists, and zero if one
///             does not. This provides a simple and efficient means of determining whether a <b>WM_PAINT</b> message resulted
///             from an invalid area.
///    bErase = Specifies whether the background in the update region is to be erased. If this parameter is <b>TRUE</b> and the
///             update region is not empty, <b>GetUpdateRect</b> sends a <b>WM_ERASEBKGND</b> message to the specified window to
///             erase the background.
///Returns:
///    If the update region is not empty, the return value is nonzero. If there is no update region, the return value is
///    zero.
///    
@DllImport("USER32")
BOOL GetUpdateRect(HWND hWnd, RECT* lpRect, BOOL bErase);

///The <b>GetUpdateRgn</b> function retrieves the update region of a window by copying it into the specified region. The
///coordinates of the update region are relative to the upper-left corner of the window (that is, they are client
///coordinates).
///Params:
///    hWnd = Handle to the window with an update region that is to be retrieved.
///    hRgn = Handle to the region to receive the update region.
///    bErase = Specifies whether the window background should be erased and whether nonclient areas of child windows should be
///             drawn. If this parameter is <b>FALSE</b>, no drawing is done.
///Returns:
///    The return value indicates the complexity of the resulting region; it can be one of the following values. <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>COMPLEXREGION</td> <td>Region consists of more than one
///    rectangle.</td> </tr> <tr> <td>ERROR</td> <td>An error occurred.</td> </tr> <tr> <td>NULLREGION</td> <td>Region
///    is empty.</td> </tr> <tr> <td>SIMPLEREGION</td> <td>Region is a single rectangle.</td> </tr> </table>
///    
@DllImport("USER32")
int GetUpdateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);

///The <b>SetWindowRgn</b> function sets the window region of a window. The window region determines the area within the
///window where the system permits drawing. The system does not display any portion of a window that lies outside of the
///window region
///Params:
///    hWnd = A handle to the window whose window region is to be set.
///    hRgn = A handle to a region. The function sets the window region of the window to this region. If <i>hRgn</i> is
///           <b>NULL</b>, the function sets the window region to <b>NULL</b>.
///    bRedraw = Specifies whether the system redraws the window after setting the window region. If <i>bRedraw</i> is
///              <b>TRUE</b>, the system does so; otherwise, it does not. Typically, you set <i>bRedraw</i> to <b>TRUE</b> if the
///              window is visible.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
int SetWindowRgn(HWND hWnd, HRGN hRgn, BOOL bRedraw);

///The <b>GetWindowRgn</b> function obtains a copy of the window region of a window. The window region of a window is
///set by calling the SetWindowRgn function. The window region determines the area within the window where the system
///permits drawing. The system does not display any portion of a window that lies outside of the window region
///Params:
///    hWnd = Handle to the window whose window region is to be obtained.
///    hRgn = Handle to the region which will be modified to represent the window region.
///Returns:
///    The return value specifies the type of the region that the function obtains. It can be one of the following
///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NULLREGION</b></dt> </dl> </td> <td width="60%"> The region is empty. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>SIMPLEREGION</b></dt> </dl> </td> <td width="60%"> The region is a single rectangle. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>COMPLEXREGION</b></dt> </dl> </td> <td width="60%"> The region is more than one
///    rectangle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR</b></dt> </dl> </td> <td width="60%"> The
///    specified window does not have a region, or an error occurred while attempting to return the region. </td> </tr>
///    </table>
///    
@DllImport("USER32")
int GetWindowRgn(HWND hWnd, HRGN hRgn);

///The <b>GetWindowRgnBox</b> function retrieves the dimensions of the tightest bounding rectangle for the window region
///of a window.
///Params:
///    hWnd = Handle to the window.
///    lprc = Pointer to a RECT structure that receives the rectangle dimensions, in device units relative to the upper-left
///           corner of the window.
///Returns:
///    The return value specifies the type of the region that the function obtains. It can be one of the following
///    values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>COMPLEXREGION</td> <td>The region is more
///    than one rectangle.</td> </tr> <tr> <td>ERROR</td> <td>The specified window does not have a region, or an error
///    occurred while attempting to return the region.</td> </tr> <tr> <td>NULLREGION</td> <td>The region is empty.</td>
///    </tr> <tr> <td>SIMPLEREGION</td> <td>The region is a single rectangle.</td> </tr> </table>
///    
@DllImport("USER32")
int GetWindowRgnBox(HWND hWnd, RECT* lprc);

///The <b>ExcludeUpdateRgn</b> function prevents drawing within invalid areas of a window by excluding an updated region
///in the window from a clipping region.
///Params:
///    hDC = Handle to the device context associated with the clipping region.
///    hWnd = Handle to the window to update.
///Returns:
///    The return value specifies the complexity of the excluded region; it can be any one of the following values.
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>COMPLEXREGION</td> <td>Region consists of more than
///    one rectangle.</td> </tr> <tr> <td>ERROR</td> <td>An error occurred.</td> </tr> <tr> <td>NULLREGION</td>
///    <td>Region is empty.</td> </tr> <tr> <td>SIMPLEREGION</td> <td>Region is a single rectangle.</td> </tr> </table>
///    
@DllImport("USER32")
int ExcludeUpdateRgn(HDC hDC, HWND hWnd);

///The <b>InvalidateRect</b> function adds a rectangle to the specified window's update region. The update region
///represents the portion of the window's client area that must be redrawn.
///Params:
///    hWnd = A handle to the window whose update region has changed. If this parameter is <b>NULL</b>, the system invalidates
///           and redraws all windows, not just the windows for this application, and sends the WM_ERASEBKGND and WM_NCPAINT
///           messages before the function returns. Setting this parameter to <b>NULL</b> is not recommended.
///    lpRect = A pointer to a RECT structure that contains the client coordinates of the rectangle to be added to the update
///             region. If this parameter is <b>NULL</b>, the entire client area is added to the update region.
///    bErase = Specifies whether the background within the update region is to be erased when the update region is processed. If
///             this parameter is <b>TRUE</b>, the background is erased when the BeginPaint function is called. If this parameter
///             is <b>FALSE</b>, the background remains unchanged.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL InvalidateRect(HWND hWnd, const(RECT)* lpRect, BOOL bErase);

///The <b>ValidateRect</b> function validates the client area within a rectangle by removing the rectangle from the
///update region of the specified window.
///Params:
///    hWnd = Handle to the window whose update region is to be modified. If this parameter is <b>NULL</b>, the system
///           invalidates and redraws all windows and sends the <b>WM_ERASEBKGND</b> and <b>WM_NCPAINT</b> messages to the
///           window procedure before the function returns.
///    lpRect = Pointer to a RECT structure that contains the client coordinates of the rectangle to be removed from the update
///             region. If this parameter is <b>NULL</b>, the entire client area is removed.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL ValidateRect(HWND hWnd, const(RECT)* lpRect);

///The <b>InvalidateRgn</b> function invalidates the client area within the specified region by adding it to the current
///update region of a window. The invalidated region, along with all other areas in the update region, is marked for
///painting when the next WM_PAINT message occurs.
///Params:
///    hWnd = A handle to the window with an update region that is to be modified.
///    hRgn = A handle to the region to be added to the update region. The region is assumed to have client coordinates. If
///           this parameter is <b>NULL</b>, the entire client area is added to the update region.
///    bErase = Specifies whether the background within the update region should be erased when the update region is processed.
///             If this parameter is <b>TRUE</b>, the background is erased when the BeginPaint function is called. If the
///             parameter is <b>FALSE</b>, the background remains unchanged.
///Returns:
///    The return value is always nonzero.
///    
@DllImport("USER32")
BOOL InvalidateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);

///The <b>ValidateRgn</b> function validates the client area within a region by removing the region from the current
///update region of the specified window.
///Params:
///    hWnd = Handle to the window whose update region is to be modified.
///    hRgn = Handle to a region that defines the area to be removed from the update region. If this parameter is <b>NULL</b>,
///           the entire client area is removed.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL ValidateRgn(HWND hWnd, HRGN hRgn);

///The <b>RedrawWindow</b> function updates the specified rectangle or region in a window's client area.
///Params:
///    hWnd = A handle to the window to be redrawn. If this parameter is <b>NULL</b>, the desktop window is updated.
///    lprcUpdate = A pointer to a RECT structure containing the coordinates, in device units, of the update rectangle. This
///                 parameter is ignored if the <i>hrgnUpdate</i> parameter identifies a region.
///    hrgnUpdate = A handle to the update region. If both the <i>hrgnUpdate</i> and <i>lprcUpdate</i> parameters are <b>NULL</b>,
///                 the entire client area is added to the update region.
///    flags = One or more redraw flags. This parameter can be used to invalidate or validate a window, control repainting, and
///            control which windows are affected by <b>RedrawWindow</b>. The following flags are used to invalidate the window.
///            <table> <tr> <th>Flag (invalidation)</th> <th>Description</th> </tr> <tr> <td width="40%"><a
///            id="RDW_ERASE"></a><a id="rdw_erase"></a><dl> <dt><b>RDW_ERASE</b></dt> </dl> </td> <td width="60%"> Causes the
///            window to receive a WM_ERASEBKGND message when the window is repainted. The RDW_INVALIDATE flag must also be
///            specified; otherwise, RDW_ERASE has no effect. </td> </tr> <tr> <td width="40%"><a id="RDW_FRAME"></a><a
///            id="rdw_frame"></a><dl> <dt><b>RDW_FRAME</b></dt> </dl> </td> <td width="60%"> Causes any part of the nonclient
///            area of the window that intersects the update region to receive a WM_NCPAINT message. The RDW_INVALIDATE flag
///            must also be specified; otherwise, RDW_FRAME has no effect. The <b>WM_NCPAINT</b> message is typically not sent
///            during the execution of <b>RedrawWindow</b> unless either RDW_UPDATENOW or RDW_ERASENOW is specified. </td> </tr>
///            <tr> <td width="40%"><a id="RDW_INTERNALPAINT"></a><a id="rdw_internalpaint"></a><dl>
///            <dt><b>RDW_INTERNALPAINT</b></dt> </dl> </td> <td width="60%"> Causes a WM_PAINT message to be posted to the
///            window regardless of whether any portion of the window is invalid. </td> </tr> <tr> <td width="40%"><a
///            id="RDW_INVALIDATE"></a><a id="rdw_invalidate"></a><dl> <dt><b>RDW_INVALIDATE</b></dt> </dl> </td> <td
///            width="60%"> Invalidates <i>lprcUpdate</i> or <i>hrgnUpdate</i> (only one may be non-<b>NULL</b>). If both are
///            <b>NULL</b>, the entire window is invalidated. </td> </tr> </table> The following flags are used to validate the
///            window. <table> <tr> <th>Flag (validation)</th> <th>Description</th> </tr> <tr> <td width="40%"><a
///            id="RDW_NOERASE"></a><a id="rdw_noerase"></a><dl> <dt><b>RDW_NOERASE</b></dt> </dl> </td> <td width="60%">
///            Suppresses any pending WM_ERASEBKGND messages. </td> </tr> <tr> <td width="40%"><a id="RDW_NOFRAME"></a><a
///            id="rdw_noframe"></a><dl> <dt><b>RDW_NOFRAME</b></dt> </dl> </td> <td width="60%"> Suppresses any pending
///            WM_NCPAINT messages. This flag must be used with RDW_VALIDATE and is typically used with RDW_NOCHILDREN.
///            RDW_NOFRAME should be used with care, as it could cause parts of a window to be painted improperly. </td> </tr>
///            <tr> <td width="40%"><a id="RDW_NOINTERNALPAINT"></a><a id="rdw_nointernalpaint"></a><dl>
///            <dt><b>RDW_NOINTERNALPAINT</b></dt> </dl> </td> <td width="60%"> Suppresses any pending internal WM_PAINT
///            messages. This flag does not affect <b>WM_PAINT</b> messages resulting from a non-<b>NULL</b> update area. </td>
///            </tr> <tr> <td width="40%"><a id="RDW_VALIDATE"></a><a id="rdw_validate"></a><dl> <dt><b>RDW_VALIDATE</b></dt>
///            </dl> </td> <td width="60%"> Validates <i>lprcUpdate</i> or <i>hrgnUpdate</i> (only one may be non-<b>NULL</b>).
///            If both are <b>NULL</b>, the entire window is validated. This flag does not affect internal WM_PAINT messages.
///            </td> </tr> </table> The following flags control when repainting occurs. <b>RedrawWindow</b> will not repaint
///            unless one of these flags is specified. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td
///            width="40%"><a id="RDW_ERASENOW"></a><a id="rdw_erasenow"></a><dl> <dt><b>RDW_ERASENOW</b></dt> </dl> </td> <td
///            width="60%"> Causes the affected windows (as specified by the RDW_ALLCHILDREN and RDW_NOCHILDREN flags) to
///            receive WM_NCPAINT and WM_ERASEBKGND messages, if necessary, before the function returns. WM_PAINT messages are
///            received at the ordinary time. </td> </tr> <tr> <td width="40%"><a id="RDW_UPDATENOW"></a><a
///            id="rdw_updatenow"></a><dl> <dt><b>RDW_UPDATENOW</b></dt> </dl> </td> <td width="60%"> Causes the affected
///            windows (as specified by the RDW_ALLCHILDREN and RDW_NOCHILDREN flags) to receive WM_NCPAINT, WM_ERASEBKGND, and
///            WM_PAINT messages, if necessary, before the function returns. </td> </tr> </table> By default, the windows
///            affected by <b>RedrawWindow</b> depend on whether the specified window has the WS_CLIPCHILDREN style. Child
///            windows that are not the WS_CLIPCHILDREN style are unaffected; non-WS_CLIPCHILDREN windows are recursively
///            validated or invalidated until a WS_CLIPCHILDREN window is encountered. The following flags control which windows
///            are affected by the <b>RedrawWindow</b> function. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td
///            width="40%"><a id="RDW_ALLCHILDREN"></a><a id="rdw_allchildren"></a><dl> <dt><b>RDW_ALLCHILDREN</b></dt> </dl>
///            </td> <td width="60%"> Includes child windows, if any, in the repainting operation. </td> </tr> <tr> <td
///            width="40%"><a id="RDW_NOCHILDREN"></a><a id="rdw_nochildren"></a><dl> <dt><b>RDW_NOCHILDREN</b></dt> </dl> </td>
///            <td width="60%"> Excludes child windows, if any, from the repainting operation. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL RedrawWindow(HWND hWnd, const(RECT)* lprcUpdate, HRGN hrgnUpdate, uint flags);

///The <b>LockWindowUpdate</b> function disables or enables drawing in the specified window. Only one window can be
///locked at a time.
///Params:
///    hWndLock = The window in which drawing will be disabled. If this parameter is <b>NULL</b>, drawing in the locked window is
///               enabled.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero,
///    indicating that an error occurred or another window was already locked.
///    
@DllImport("USER32")
BOOL LockWindowUpdate(HWND hWndLock);

///The <b>ClientToScreen</b> function converts the client-area coordinates of a specified point to screen coordinates.
///Params:
///    hWnd = A handle to the window whose client area is used for the conversion.
///    lpPoint = A pointer to a POINT structure that contains the client coordinates to be converted. The new screen coordinates
///              are copied into this structure if the function succeeds.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL ClientToScreen(HWND hWnd, POINT* lpPoint);

///The <b>ScreenToClient</b> function converts the screen coordinates of a specified point on the screen to client-area
///coordinates.
///Params:
///    hWnd = A handle to the window whose client area will be used for the conversion.
///    lpPoint = A pointer to a POINT structure that specifies the screen coordinates to be converted.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL ScreenToClient(HWND hWnd, POINT* lpPoint);

///The <b>MapWindowPoints</b> function converts (maps) a set of points from a coordinate space relative to one window to
///a coordinate space relative to another window.
///Params:
///    hWndFrom = A handle to the window from which points are converted. If this parameter is <b>NULL</b> or HWND_DESKTOP, the
///               points are presumed to be in screen coordinates.
///    hWndTo = A handle to the window to which points are converted. If this parameter is <b>NULL</b> or HWND_DESKTOP, the
///             points are converted to screen coordinates.
///    lpPoints = A pointer to an array of POINT structures that contain the set of points to be converted. The points are in
///               device units. This parameter can also point to a RECT structure, in which case the <i>cPoints</i> parameter
///               should be set to 2.
///    cPoints = The number of POINT structures in the array pointed to by the <i>lpPoints</i> parameter.
///Returns:
///    If the function succeeds, the low-order word of the return value is the number of pixels added to the horizontal
///    coordinate of each source point in order to compute the horizontal coordinate of each destination point. (In
///    addition to that, if precisely one of <i>hWndFrom</i> and <i>hWndTo</i> is mirrored, then each resulting
///    horizontal coordinate is multiplied by -1.) The high-order word is the number of pixels added to the vertical
///    coordinate of each source point in order to compute the vertical coordinate of each destination point. If the
///    function fails, the return value is zero. Call SetLastError prior to calling this method to differentiate an
///    error return value from a legitimate "0" return value.
///    
@DllImport("USER32")
int MapWindowPoints(HWND hWndFrom, HWND hWndTo, char* lpPoints, uint cPoints);

///The <b>GetSysColorBrush</b> function retrieves a handle identifying a logical brush that corresponds to the specified
///color index.
///Params:
///    nIndex = A color index. This value corresponds to the color used to paint one of the window elements. See GetSysColor for
///             system color index values.
///Returns:
///    The return value identifies a logical brush if the <i>nIndex</i> parameter is supported by the current platform.
///    Otherwise, it returns <b>NULL</b>.
///    
@DllImport("USER32")
HBRUSH GetSysColorBrush(int nIndex);

///The <b>DrawFocusRect</b> function draws a rectangle in the style used to indicate that the rectangle has the focus.
///Params:
///    hDC = A handle to the device context.
///    lprc = A pointer to a RECT structure that specifies the logical coordinates of the rectangle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL DrawFocusRect(HDC hDC, const(RECT)* lprc);

///The <b>FillRect</b> function fills a rectangle by using the specified brush. This function includes the left and top
///borders, but excludes the right and bottom borders of the rectangle.
///Params:
///    hDC = A handle to the device context.
///    lprc = A pointer to a RECT structure that contains the logical coordinates of the rectangle to be filled.
///    hbr = A handle to the brush used to fill the rectangle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
int FillRect(HDC hDC, const(RECT)* lprc, HBRUSH hbr);

///The <b>FrameRect</b> function draws a border around the specified rectangle by using the specified brush. The width
///and height of the border are always one logical unit.
///Params:
///    hDC = A handle to the device context in which the border is drawn.
///    lprc = A pointer to a RECT structure that contains the logical coordinates of the upper-left and lower-right corners of
///           the rectangle.
///    hbr = A handle to the brush used to draw the border.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
int FrameRect(HDC hDC, const(RECT)* lprc, HBRUSH hbr);

///The <b>InvertRect</b> function inverts a rectangle in a window by performing a logical NOT operation on the color
///values for each pixel in the rectangle's interior.
///Params:
///    hDC = A handle to the device context.
///    lprc = A pointer to a RECT structure that contains the logical coordinates of the rectangle to be inverted.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL InvertRect(HDC hDC, const(RECT)* lprc);

///The <b>SetRect</b> function sets the coordinates of the specified rectangle. This is equivalent to assigning the
///left, top, right, and bottom arguments to the appropriate members of the <b>RECT</b> structure.
///Params:
///    lprc = Pointer to the RECT structure that contains the rectangle to be set.
///    xLeft = Specifies the x-coordinate of the rectangle's upper-left corner.
///    yTop = Specifies the y-coordinate of the rectangle's upper-left corner.
///    xRight = Specifies the x-coordinate of the rectangle's lower-right corner.
///    yBottom = Specifies the y-coordinate of the rectangle's lower-right corner.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL SetRect(RECT* lprc, int xLeft, int yTop, int xRight, int yBottom);

///The <b>SetRectEmpty</b> function creates an empty rectangle in which all coordinates are set to zero.
///Params:
///    lprc = Pointer to the RECT structure that contains the coordinates of the rectangle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL SetRectEmpty(RECT* lprc);

///The <b>CopyRect</b> function copies the coordinates of one rectangle to another.
///Params:
///    lprcDst = Pointer to the RECT structure that receives the logical coordinates of the source rectangle.
///    lprcSrc = Pointer to the RECT structure whose coordinates are to be copied in logical units.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL CopyRect(RECT* lprcDst, const(RECT)* lprcSrc);

///The <b>InflateRect</b> function increases or decreases the width and height of the specified rectangle. The
///<b>InflateRect</b> function adds <i>-dx</i> units to the left end and <i>dx</i> to the right end of the rectangle and
///<i>-dy</i> units to the top and <i>dy</i> to the bottom. The <i>dx</i> and <i>dy</i> parameters are signed values;
///positive values increase the width and height, and negative values decrease them.
///Params:
///    lprc = A pointer to the RECT structure that increases or decreases in size.
///    dx = The amount to increase or decrease the rectangle width. This parameter must be negative to decrease the width.
///    dy = The amount to increase or decrease the rectangle height. This parameter must be negative to decrease the height.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL InflateRect(RECT* lprc, int dx, int dy);

///The <b>IntersectRect</b> function calculates the intersection of two source rectangles and places the coordinates of
///the intersection rectangle into the destination rectangle. If the source rectangles do not intersect, an empty
///rectangle (in which all coordinates are set to zero) is placed into the destination rectangle.
///Params:
///    lprcDst = A pointer to the RECT structure that is to receive the intersection of the rectangles pointed to by the
///              <i>lprcSrc1</i> and <i>lprcSrc2</i> parameters. This parameter cannot be <b>NULL</b>.
///    lprcSrc1 = A pointer to the RECT structure that contains the first source rectangle.
///    lprcSrc2 = A pointer to the RECT structure that contains the second source rectangle.
///Returns:
///    If the rectangles intersect, the return value is nonzero. If the rectangles do not intersect, the return value is
///    zero.
///    
@DllImport("USER32")
BOOL IntersectRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

///The <b>UnionRect</b> function creates the union of two rectangles. The union is the smallest rectangle that contains
///both source rectangles.
///Params:
///    lprcDst = A pointer to the RECT structure that will receive a rectangle containing the rectangles pointed to by the
///              <i>lprcSrc1</i> and <i>lprcSrc2</i> parameters.
///    lprcSrc1 = A pointer to the RECT structure that contains the first source rectangle.
///    lprcSrc2 = A pointer to the RECT structure that contains the second source rectangle.
///Returns:
///    If the specified structure contains a nonempty rectangle, the return value is nonzero. If the specified structure
///    does not contain a nonempty rectangle, the return value is zero.
///    
@DllImport("USER32")
BOOL UnionRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

///The <b>SubtractRect</b> function determines the coordinates of a rectangle formed by subtracting one rectangle from
///another.
///Params:
///    lprcDst = A pointer to a RECT structure that receives the coordinates of the rectangle determined by subtracting the
///              rectangle pointed to by <i>lprcSrc2</i> from the rectangle pointed to by <i>lprcSrc1</i>.
///    lprcSrc1 = A pointer to a RECT structure from which the function subtracts the rectangle pointed to by <i>lprcSrc2</i>.
///    lprcSrc2 = A pointer to a RECT structure that the function subtracts from the rectangle pointed to by <i>lprcSrc1</i>.
///Returns:
///    If the resulting rectangle is empty, the return value is zero. If the resulting rectangle is not empty, the
///    return value is nonzero.
///    
@DllImport("USER32")
BOOL SubtractRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

///The <b>OffsetRect</b> function moves the specified rectangle by the specified offsets.
///Params:
///    lprc = Pointer to a RECT structure that contains the logical coordinates of the rectangle to be moved.
///    dx = Specifies the amount to move the rectangle left or right. This parameter must be a negative value to move the
///         rectangle to the left.
///    dy = Specifies the amount to move the rectangle up or down. This parameter must be a negative value to move the
///         rectangle up.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL OffsetRect(RECT* lprc, int dx, int dy);

///The <b>IsRectEmpty</b> function determines whether the specified rectangle is empty. An empty rectangle is one that
///has no area; that is, the coordinate of the right side is less than or equal to the coordinate of the left side, or
///the coordinate of the bottom side is less than or equal to the coordinate of the top side.
///Params:
///    lprc = Pointer to a RECT structure that contains the logical coordinates of the rectangle.
///Returns:
///    If the rectangle is empty, the return value is nonzero. If the rectangle is not empty, the return value is zero.
///    
@DllImport("USER32")
BOOL IsRectEmpty(const(RECT)* lprc);

///The <b>EqualRect</b> function determines whether the two specified rectangles are equal by comparing the coordinates
///of their upper-left and lower-right corners.
///Params:
///    lprc1 = Pointer to a RECT structure that contains the logical coordinates of the first rectangle.
///    lprc2 = Pointer to a RECT structure that contains the logical coordinates of the second rectangle.
///Returns:
///    If the two rectangles are identical, the return value is nonzero. If the two rectangles are not identical, the
///    return value is zero.
///    
@DllImport("USER32")
BOOL EqualRect(const(RECT)* lprc1, const(RECT)* lprc2);

///The <b>PtInRect</b> function determines whether the specified point lies within the specified rectangle. A point is
///within a rectangle if it lies on the left or top side or is within all four sides. A point on the right or bottom
///side is considered outside the rectangle.
///Params:
///    lprc = A pointer to a RECT structure that contains the specified rectangle.
///    pt = A POINT structure that contains the specified point.
///Returns:
///    If the specified point lies within the rectangle, the return value is nonzero. If the specified point does not
///    lie within the rectangle, the return value is zero.
///    
@DllImport("USER32")
BOOL PtInRect(const(RECT)* lprc, POINT pt);

///<p class="CCE_Message">[<b>LoadBitmap</b> is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. Instead, use LoadImage and DrawFrameControl.] The
///<b>LoadBitmap</b> function loads the specified bitmap resource from a module's executable file.
///Params:
///    hInstance = A handle to the instance of the module whose executable file contains the bitmap to be loaded.
///    lpBitmapName = A pointer to a null-terminated string that contains the name of the bitmap resource to be loaded. Alternatively,
///                   this parameter can consist of the resource identifier in the low-order word and zero in the high-order word. The
///                   MAKEINTRESOURCE macro can be used to create this value.
///Returns:
///    If the function succeeds, the return value is the handle to the specified bitmap. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("USER32")
HBITMAP LoadBitmapA(HINSTANCE hInstance, const(char)* lpBitmapName);

///<p class="CCE_Message">[<b>LoadBitmap</b> is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. Instead, use LoadImage and DrawFrameControl.] The
///<b>LoadBitmap</b> function loads the specified bitmap resource from a module's executable file.
///Params:
///    hInstance = A handle to the instance of the module whose executable file contains the bitmap to be loaded.
///    lpBitmapName = A pointer to a null-terminated string that contains the name of the bitmap resource to be loaded. Alternatively,
///                   this parameter can consist of the resource identifier in the low-order word and zero in the high-order word. The
///                   MAKEINTRESOURCE macro can be used to create this value.
///Returns:
///    If the function succeeds, the return value is the handle to the specified bitmap. If the function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("USER32")
HBITMAP LoadBitmapW(HINSTANCE hInstance, const(wchar)* lpBitmapName);

///The <b>ChangeDisplaySettings</b> function changes the settings of the default display device to the specified
///graphics mode. To change the settings of a specified display device, use the ChangeDisplaySettingsEx function. <div
///class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query or set display modes
///that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a compatibility manifest that
///targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps that were built without a
///Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color mode.</div><div> </div>
///Params:
///    lpDevMode = A pointer to a DEVMODE structure that describes the new graphics mode. If <i>lpDevMode</i> is <b>NULL</b>, all
///                the values currently in the registry will be used for the display setting. Passing <b>NULL</b> for the
///                <i>lpDevMode</i> parameter and 0 for the <i>dwFlags</i> parameter is the easiest way to return to the default
///                mode after a dynamic mode change. The <b>dmSize</b> member of DEVMODE must be initialized to the size, in bytes,
///                of the <b>DEVMODE</b> structure. The <b>dmDriverExtra</b> member of <b>DEVMODE</b> must be initialized to
///                indicate the number of bytes of private driver data following the <b>DEVMODE</b> structure. In addition, you can
///                use any or all of the following members of the <b>DEVMODE</b> structure. <table> <tr> <th>Member</th>
///                <th>Meaning</th> </tr> <tr> <td><b>dmBitsPerPel</b></td> <td>Bits per pixel</td> </tr> <tr>
///                <td><b>dmPelsWidth</b></td> <td>Pixel width</td> </tr> <tr> <td><b>dmPelsHeight</b></td> <td>Pixel height</td>
///                </tr> <tr> <td><b>dmDisplayFlags</b></td> <td>Mode flags</td> </tr> <tr> <td><b>dmDisplayFrequency</b></td>
///                <td>Mode frequency</td> </tr> <tr> <td><b>dmPosition</b></td> <td>Position of the device in a multi-monitor
///                configuration.</td> </tr> </table> In addition to using one or more of the preceding DEVMODE members, you must
///                also set one or more of the following values in the <b>dmFields</b> member to change the display setting. <table>
///                <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DM_BITSPERPEL</td> <td>Use the <b>dmBitsPerPel</b>
///                value.</td> </tr> <tr> <td>DM_PELSWIDTH</td> <td>Use the <b>dmPelsWidth</b> value.</td> </tr> <tr>
///                <td>DM_PELSHEIGHT</td> <td>Use the <b>dmPelsHeight</b> value.</td> </tr> <tr> <td>DM_DISPLAYFLAGS</td> <td>Use
///                the <b>dmDisplayFlags</b> value.</td> </tr> <tr> <td>DM_DISPLAYFREQUENCY</td> <td>Use the
///                <b>dmDisplayFrequency</b> value.</td> </tr> <tr> <td>DM_POSITION</td> <td>Use the <b>dmPosition</b> value.</td>
///                </tr> </table>
///    dwFlags = Indicates how the graphics mode should be changed. This parameter can be one of the following values. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td>
///              <td width="60%"> The graphics mode for the current screen will be changed dynamically. </td> </tr> <tr> <td
///              width="40%"><a id="CDS_FULLSCREEN"></a><a id="cds_fullscreen"></a><dl> <dt><b>CDS_FULLSCREEN</b></dt> </dl> </td>
///              <td width="60%"> The mode is temporary in nature. If you change to and from another desktop, this mode will not
///              be reset. </td> </tr> <tr> <td width="40%"><a id="CDS_GLOBAL"></a><a id="cds_global"></a><dl>
///              <dt><b>CDS_GLOBAL</b></dt> </dl> </td> <td width="60%"> The settings will be saved in the global settings area so
///              that they will affect all users on the machine. Otherwise, only the settings for the user are modified. This flag
///              is only valid when specified with the CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_NORESET"></a><a id="cds_noreset"></a><dl> <dt><b>CDS_NORESET</b></dt> </dl> </td> <td width="60%"> The
///              settings will be saved in the registry, but will not take effect. This flag is only valid when specified with the
///              CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a id="CDS_RESET"></a><a id="cds_reset"></a><dl>
///              <dt><b>CDS_RESET</b></dt> </dl> </td> <td width="60%"> The settings should be changed, even if the requested
///              settings are the same as the current settings. </td> </tr> <tr> <td width="40%"><a id="CDS_SET_PRIMARY"></a><a
///              id="cds_set_primary"></a><dl> <dt><b>CDS_SET_PRIMARY</b></dt> </dl> </td> <td width="60%"> This device will
///              become the primary device. </td> </tr> <tr> <td width="40%"><a id="CDS_TEST"></a><a id="cds_test"></a><dl>
///              <dt><b>CDS_TEST</b></dt> </dl> </td> <td width="60%"> The system tests if the requested graphics mode could be
///              set. </td> </tr> <tr> <td width="40%"><a id="CDS_UPDATEREGISTRY"></a><a id="cds_updateregistry"></a><dl>
///              <dt><b>CDS_UPDATEREGISTRY</b></dt> </dl> </td> <td width="60%"> The graphics mode for the current screen will be
///              changed dynamically and the graphics mode will be updated in the registry. The mode information is stored in the
///              USER profile. </td> </tr> </table> Specifying CDS_TEST allows an application to determine which graphics modes
///              are actually valid, without causing the system to change to that graphics mode. If CDS_UPDATEREGISTRY is
///              specified and it is possible to change the graphics mode dynamically, the information is stored in the registry
///              and DISP_CHANGE_SUCCESSFUL is returned. If it is not possible to change the graphics mode dynamically, the
///              information is stored in the registry and DISP_CHANGE_RESTART is returned. If CDS_UPDATEREGISTRY is specified and
///              the information could not be stored in the registry, the graphics mode is not changed and DISP_CHANGE_NOTUPDATED
///              is returned.
///Returns:
///    The <b>ChangeDisplaySettings</b> function returns one of the following values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_SUCCESSFUL</b></dt> </dl> </td> <td
///    width="60%"> The settings change was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADDUALVIEW</b></dt> </dl> </td> <td width="60%"> The settings change was unsuccessful because
///    the system is DualView capable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADFLAGS</b></dt> </dl>
///    </td> <td width="60%"> An invalid set of flags was passed in. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADMODE</b></dt> </dl> </td> <td width="60%"> The graphics mode is not supported. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADPARAM</b></dt> </dl> </td> <td width="60%"> An invalid parameter
///    was passed in. This can include an invalid flag or combination of flags. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_FAILED</b></dt> </dl> </td> <td width="60%"> The display driver failed the specified graphics
///    mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_NOTUPDATED</b></dt> </dl> </td> <td width="60%">
///    Unable to write settings to the registry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_RESTART</b></dt> </dl> </td> <td width="60%"> The computer must be restarted for the graphics
///    mode to work. </td> </tr> </table>
///    
@DllImport("USER32")
int ChangeDisplaySettingsA(DEVMODEA* lpDevMode, uint dwFlags);

///The <b>ChangeDisplaySettings</b> function changes the settings of the default display device to the specified
///graphics mode. To change the settings of a specified display device, use the ChangeDisplaySettingsEx function. <div
///class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query or set display modes
///that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a compatibility manifest that
///targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps that were built without a
///Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color mode.</div><div> </div>
///Params:
///    lpDevMode = A pointer to a DEVMODE structure that describes the new graphics mode. If <i>lpDevMode</i> is <b>NULL</b>, all
///                the values currently in the registry will be used for the display setting. Passing <b>NULL</b> for the
///                <i>lpDevMode</i> parameter and 0 for the <i>dwFlags</i> parameter is the easiest way to return to the default
///                mode after a dynamic mode change. The <b>dmSize</b> member of DEVMODE must be initialized to the size, in bytes,
///                of the <b>DEVMODE</b> structure. The <b>dmDriverExtra</b> member of <b>DEVMODE</b> must be initialized to
///                indicate the number of bytes of private driver data following the <b>DEVMODE</b> structure. In addition, you can
///                use any or all of the following members of the <b>DEVMODE</b> structure. <table> <tr> <th>Member</th>
///                <th>Meaning</th> </tr> <tr> <td><b>dmBitsPerPel</b></td> <td>Bits per pixel</td> </tr> <tr>
///                <td><b>dmPelsWidth</b></td> <td>Pixel width</td> </tr> <tr> <td><b>dmPelsHeight</b></td> <td>Pixel height</td>
///                </tr> <tr> <td><b>dmDisplayFlags</b></td> <td>Mode flags</td> </tr> <tr> <td><b>dmDisplayFrequency</b></td>
///                <td>Mode frequency</td> </tr> <tr> <td><b>dmPosition</b></td> <td>Position of the device in a multi-monitor
///                configuration.</td> </tr> </table> In addition to using one or more of the preceding DEVMODE members, you must
///                also set one or more of the following values in the <b>dmFields</b> member to change the display setting. <table>
///                <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DM_BITSPERPEL</td> <td>Use the <b>dmBitsPerPel</b>
///                value.</td> </tr> <tr> <td>DM_PELSWIDTH</td> <td>Use the <b>dmPelsWidth</b> value.</td> </tr> <tr>
///                <td>DM_PELSHEIGHT</td> <td>Use the <b>dmPelsHeight</b> value.</td> </tr> <tr> <td>DM_DISPLAYFLAGS</td> <td>Use
///                the <b>dmDisplayFlags</b> value.</td> </tr> <tr> <td>DM_DISPLAYFREQUENCY</td> <td>Use the
///                <b>dmDisplayFrequency</b> value.</td> </tr> <tr> <td>DM_POSITION</td> <td>Use the <b>dmPosition</b> value.</td>
///                </tr> </table>
///    dwFlags = Indicates how the graphics mode should be changed. This parameter can be one of the following values. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td>
///              <td width="60%"> The graphics mode for the current screen will be changed dynamically. </td> </tr> <tr> <td
///              width="40%"><a id="CDS_FULLSCREEN"></a><a id="cds_fullscreen"></a><dl> <dt><b>CDS_FULLSCREEN</b></dt> </dl> </td>
///              <td width="60%"> The mode is temporary in nature. If you change to and from another desktop, this mode will not
///              be reset. </td> </tr> <tr> <td width="40%"><a id="CDS_GLOBAL"></a><a id="cds_global"></a><dl>
///              <dt><b>CDS_GLOBAL</b></dt> </dl> </td> <td width="60%"> The settings will be saved in the global settings area so
///              that they will affect all users on the machine. Otherwise, only the settings for the user are modified. This flag
///              is only valid when specified with the CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_NORESET"></a><a id="cds_noreset"></a><dl> <dt><b>CDS_NORESET</b></dt> </dl> </td> <td width="60%"> The
///              settings will be saved in the registry, but will not take effect. This flag is only valid when specified with the
///              CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a id="CDS_RESET"></a><a id="cds_reset"></a><dl>
///              <dt><b>CDS_RESET</b></dt> </dl> </td> <td width="60%"> The settings should be changed, even if the requested
///              settings are the same as the current settings. </td> </tr> <tr> <td width="40%"><a id="CDS_SET_PRIMARY"></a><a
///              id="cds_set_primary"></a><dl> <dt><b>CDS_SET_PRIMARY</b></dt> </dl> </td> <td width="60%"> This device will
///              become the primary device. </td> </tr> <tr> <td width="40%"><a id="CDS_TEST"></a><a id="cds_test"></a><dl>
///              <dt><b>CDS_TEST</b></dt> </dl> </td> <td width="60%"> The system tests if the requested graphics mode could be
///              set. </td> </tr> <tr> <td width="40%"><a id="CDS_UPDATEREGISTRY"></a><a id="cds_updateregistry"></a><dl>
///              <dt><b>CDS_UPDATEREGISTRY</b></dt> </dl> </td> <td width="60%"> The graphics mode for the current screen will be
///              changed dynamically and the graphics mode will be updated in the registry. The mode information is stored in the
///              USER profile. </td> </tr> </table> Specifying CDS_TEST allows an application to determine which graphics modes
///              are actually valid, without causing the system to change to that graphics mode. If CDS_UPDATEREGISTRY is
///              specified and it is possible to change the graphics mode dynamically, the information is stored in the registry
///              and DISP_CHANGE_SUCCESSFUL is returned. If it is not possible to change the graphics mode dynamically, the
///              information is stored in the registry and DISP_CHANGE_RESTART is returned. If CDS_UPDATEREGISTRY is specified and
///              the information could not be stored in the registry, the graphics mode is not changed and DISP_CHANGE_NOTUPDATED
///              is returned.
///Returns:
///    The <b>ChangeDisplaySettings</b> function returns one of the following values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_SUCCESSFUL</b></dt> </dl> </td> <td
///    width="60%"> The settings change was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADDUALVIEW</b></dt> </dl> </td> <td width="60%"> The settings change was unsuccessful because
///    the system is DualView capable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADFLAGS</b></dt> </dl>
///    </td> <td width="60%"> An invalid set of flags was passed in. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADMODE</b></dt> </dl> </td> <td width="60%"> The graphics mode is not supported. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADPARAM</b></dt> </dl> </td> <td width="60%"> An invalid parameter
///    was passed in. This can include an invalid flag or combination of flags. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_FAILED</b></dt> </dl> </td> <td width="60%"> The display driver failed the specified graphics
///    mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_NOTUPDATED</b></dt> </dl> </td> <td width="60%">
///    Unable to write settings to the registry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_RESTART</b></dt> </dl> </td> <td width="60%"> The computer must be restarted for the graphics
///    mode to work. </td> </tr> </table>
///    
@DllImport("USER32")
int ChangeDisplaySettingsW(DEVMODEW* lpDevMode, uint dwFlags);

///The <b>ChangeDisplaySettingsEx</b> function changes the settings of the specified display device to the specified
///graphics mode. <div class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query
///or set display modes that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a
///compatibility manifest that targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps
///that were built without a Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color
///mode.</div><div> </div>
///Params:
///    lpszDeviceName = A pointer to a null-terminated string that specifies the display device whose graphics mode will change. Only
///                     display device names as returned by EnumDisplayDevices are valid. See <b>EnumDisplayDevices</b> for further
///                     information on the names associated with these display devices. The <i>lpszDeviceName</i> parameter can be
///                     <b>NULL</b>. A <b>NULL</b> value specifies the default display device. The default device can be determined by
///                     calling EnumDisplayDevices and checking for the DISPLAY_DEVICE_PRIMARY_DEVICE flag.
///    lpDevMode = A pointer to a DEVMODE structure that describes the new graphics mode. If <i>lpDevMode</i> is <b>NULL</b>, all
///                the values currently in the registry will be used for the display setting. Passing <b>NULL</b> for the
///                <i>lpDevMode</i> parameter and 0 for the <i>dwFlags</i> parameter is the easiest way to return to the default
///                mode after a dynamic mode change. The <b>dmSize</b> member must be initialized to the size, in bytes, of the
///                DEVMODE structure. The <b>dmDriverExtra</b> member must be initialized to indicate the number of bytes of private
///                driver data following the <b>DEVMODE</b> structure. In addition, you can use any of the following members of the
///                <b>DEVMODE</b> structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td><b>dmBitsPerPel</b></td>
///                <td>Bits per pixel</td> </tr> <tr> <td><b>dmPelsWidth</b></td> <td>Pixel width</td> </tr> <tr>
///                <td><b>dmPelsHeight</b></td> <td>Pixel height</td> </tr> <tr> <td><b>dmDisplayFlags</b></td> <td>Mode flags</td>
///                </tr> <tr> <td><b>dmDisplayFrequency</b></td> <td>Mode frequency</td> </tr> <tr> <td><b>dmPosition</b></td>
///                <td>Position of the device in a multi-monitor configuration.</td> </tr> </table> In addition to using one or more
///                of the preceding DEVMODE members, you must also set one or more of the following values in the <b>dmFields</b>
///                member to change the display settings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                <td>DM_BITSPERPEL</td> <td>Use the <b>dmBitsPerPel</b> value.</td> </tr> <tr> <td>DM_PELSWIDTH</td> <td>Use the
///                <b>dmPelsWidth</b> value.</td> </tr> <tr> <td>DM_PELSHEIGHT</td> <td>Use the <b>dmPelsHeight</b> value.</td>
///                </tr> <tr> <td>DM_DISPLAYFLAGS</td> <td>Use the <b>dmDisplayFlags</b> value.</td> </tr> <tr>
///                <td>DM_DISPLAYFREQUENCY</td> <td>Use the <b>dmDisplayFrequency</b> value.</td> </tr> <tr> <td>DM_POSITION</td>
///                <td>Use the <b>dmPosition</b> value.</td> </tr> </table>
///    hwnd = Reserved; must be <b>NULL</b>.
///    dwflags = Indicates how the graphics mode should be changed. This parameter can be one of the following values. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The
///              graphics mode for the current screen will be changed dynamically. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_FULLSCREEN"></a><a id="cds_fullscreen"></a><dl> <dt><b>CDS_FULLSCREEN</b></dt> </dl> </td> <td
///              width="60%"> The mode is temporary in nature. If you change to and from another desktop, this mode will not be
///              reset. </td> </tr> <tr> <td width="40%"><a id="CDS_GLOBAL"></a><a id="cds_global"></a><dl>
///              <dt><b>CDS_GLOBAL</b></dt> </dl> </td> <td width="60%"> The settings will be saved in the global settings area so
///              that they will affect all users on the machine. Otherwise, only the settings for the user are modified. This flag
///              is only valid when specified with the CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_NORESET"></a><a id="cds_noreset"></a><dl> <dt><b>CDS_NORESET</b></dt> </dl> </td> <td width="60%"> The
///              settings will be saved in the registry, but will not take effect. This flag is only valid when specified with the
///              CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a id="CDS_RESET"></a><a id="cds_reset"></a><dl>
///              <dt><b>CDS_RESET</b></dt> </dl> </td> <td width="60%"> The settings should be changed, even if the requested
///              settings are the same as the current settings. </td> </tr> <tr> <td width="40%"><a id="CDS_SET_PRIMARY"></a><a
///              id="cds_set_primary"></a><dl> <dt><b>CDS_SET_PRIMARY</b></dt> </dl> </td> <td width="60%"> This device will
///              become the primary device. </td> </tr> <tr> <td width="40%"><a id="CDS_TEST"></a><a id="cds_test"></a><dl>
///              <dt><b>CDS_TEST</b></dt> </dl> </td> <td width="60%"> The system tests if the requested graphics mode could be
///              set. </td> </tr> <tr> <td width="40%"><a id="CDS_UPDATEREGISTRY"></a><a id="cds_updateregistry"></a><dl>
///              <dt><b>CDS_UPDATEREGISTRY</b></dt> </dl> </td> <td width="60%"> The graphics mode for the current screen will be
///              changed dynamically and the graphics mode will be updated in the registry. The mode information is stored in the
///              USER profile. </td> </tr> <tr> <td width="40%"><a id="CDS_VIDEOPARAMETERS"></a><a
///              id="cds_videoparameters"></a><dl> <dt><b>CDS_VIDEOPARAMETERS</b></dt> </dl> </td> <td width="60%"> When set, the
///              <i>lParam</i> parameter is a pointer to a VIDEOPARAMETERS structure. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_ENABLE_UNSAFE_MODES"></a><a id="cds_enable_unsafe_modes"></a><dl> <dt><b>CDS_ENABLE_UNSAFE_MODES</b></dt>
///              </dl> </td> <td width="60%"> Enables settings changes to unsafe graphics modes. </td> </tr> <tr> <td
///              width="40%"><a id="CDS_DISABLE_UNSAFE_MODES"></a><a id="cds_disable_unsafe_modes"></a><dl>
///              <dt><b>CDS_DISABLE_UNSAFE_MODES</b></dt> </dl> </td> <td width="60%"> Disables settings changes to unsafe
///              graphics modes. </td> </tr> </table> Specifying CDS_TEST allows an application to determine which graphics modes
///              are actually valid, without causing the system to change to them. If CDS_UPDATEREGISTRY is specified and it is
///              possible to change the graphics mode dynamically, the information is stored in the registry and
///              DISP_CHANGE_SUCCESSFUL is returned. If it is not possible to change the graphics mode dynamically, the
///              information is stored in the registry and DISP_CHANGE_RESTART is returned. If CDS_UPDATEREGISTRY is specified and
///              the information could not be stored in the registry, the graphics mode is not changed and DISP_CHANGE_NOTUPDATED
///              is returned.
///    lParam = If <i>dwFlags</i> is <b>CDS_VIDEOPARAMETERS</b>, <i>lParam</i> is a pointer to a VIDEOPARAMETERS structure.
///             Otherwise <i>lParam</i> must be <b>NULL</b>.
///Returns:
///    The <b>ChangeDisplaySettingsEx</b> function returns one of the following values. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_SUCCESSFUL</b></dt> </dl>
///    </td> <td width="60%"> The settings change was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADDUALVIEW</b></dt> </dl> </td> <td width="60%"> The settings change was unsuccessful because
///    the system is DualView capable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADFLAGS</b></dt> </dl>
///    </td> <td width="60%"> An invalid set of flags was passed in. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADMODE</b></dt> </dl> </td> <td width="60%"> The graphics mode is not supported. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADPARAM</b></dt> </dl> </td> <td width="60%"> An invalid parameter
///    was passed in. This can include an invalid flag or combination of flags. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_FAILED</b></dt> </dl> </td> <td width="60%"> The display driver failed the specified graphics
///    mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_NOTUPDATED</b></dt> </dl> </td> <td width="60%">
///    Unable to write settings to the registry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_RESTART</b></dt> </dl> </td> <td width="60%"> The computer must be restarted for the graphics
///    mode to work. </td> </tr> </table>
///    
@DllImport("USER32")
int ChangeDisplaySettingsExA(const(char)* lpszDeviceName, DEVMODEA* lpDevMode, HWND hwnd, uint dwflags, 
                             void* lParam);

///The <b>ChangeDisplaySettingsEx</b> function changes the settings of the specified display device to the specified
///graphics mode. <div class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query
///or set display modes that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a
///compatibility manifest that targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps
///that were built without a Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color
///mode.</div><div> </div>
///Params:
///    lpszDeviceName = A pointer to a null-terminated string that specifies the display device whose graphics mode will change. Only
///                     display device names as returned by EnumDisplayDevices are valid. See <b>EnumDisplayDevices</b> for further
///                     information on the names associated with these display devices. The <i>lpszDeviceName</i> parameter can be
///                     <b>NULL</b>. A <b>NULL</b> value specifies the default display device. The default device can be determined by
///                     calling EnumDisplayDevices and checking for the DISPLAY_DEVICE_PRIMARY_DEVICE flag.
///    lpDevMode = A pointer to a DEVMODE structure that describes the new graphics mode. If <i>lpDevMode</i> is <b>NULL</b>, all
///                the values currently in the registry will be used for the display setting. Passing <b>NULL</b> for the
///                <i>lpDevMode</i> parameter and 0 for the <i>dwFlags</i> parameter is the easiest way to return to the default
///                mode after a dynamic mode change. The <b>dmSize</b> member must be initialized to the size, in bytes, of the
///                DEVMODE structure. The <b>dmDriverExtra</b> member must be initialized to indicate the number of bytes of private
///                driver data following the <b>DEVMODE</b> structure. In addition, you can use any of the following members of the
///                <b>DEVMODE</b> structure. <table> <tr> <th>Member</th> <th>Meaning</th> </tr> <tr> <td><b>dmBitsPerPel</b></td>
///                <td>Bits per pixel</td> </tr> <tr> <td><b>dmPelsWidth</b></td> <td>Pixel width</td> </tr> <tr>
///                <td><b>dmPelsHeight</b></td> <td>Pixel height</td> </tr> <tr> <td><b>dmDisplayFlags</b></td> <td>Mode flags</td>
///                </tr> <tr> <td><b>dmDisplayFrequency</b></td> <td>Mode frequency</td> </tr> <tr> <td><b>dmPosition</b></td>
///                <td>Position of the device in a multi-monitor configuration.</td> </tr> </table> In addition to using one or more
///                of the preceding DEVMODE members, you must also set one or more of the following values in the <b>dmFields</b>
///                member to change the display settings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                <td>DM_BITSPERPEL</td> <td>Use the <b>dmBitsPerPel</b> value.</td> </tr> <tr> <td>DM_PELSWIDTH</td> <td>Use the
///                <b>dmPelsWidth</b> value.</td> </tr> <tr> <td>DM_PELSHEIGHT</td> <td>Use the <b>dmPelsHeight</b> value.</td>
///                </tr> <tr> <td>DM_DISPLAYFLAGS</td> <td>Use the <b>dmDisplayFlags</b> value.</td> </tr> <tr>
///                <td>DM_DISPLAYFREQUENCY</td> <td>Use the <b>dmDisplayFrequency</b> value.</td> </tr> <tr> <td>DM_POSITION</td>
///                <td>Use the <b>dmPosition</b> value.</td> </tr> </table>
///    hwnd = Reserved; must be <b>NULL</b>.
///    dwflags = Indicates how the graphics mode should be changed. This parameter can be one of the following values. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The
///              graphics mode for the current screen will be changed dynamically. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_FULLSCREEN"></a><a id="cds_fullscreen"></a><dl> <dt><b>CDS_FULLSCREEN</b></dt> </dl> </td> <td
///              width="60%"> The mode is temporary in nature. If you change to and from another desktop, this mode will not be
///              reset. </td> </tr> <tr> <td width="40%"><a id="CDS_GLOBAL"></a><a id="cds_global"></a><dl>
///              <dt><b>CDS_GLOBAL</b></dt> </dl> </td> <td width="60%"> The settings will be saved in the global settings area so
///              that they will affect all users on the machine. Otherwise, only the settings for the user are modified. This flag
///              is only valid when specified with the CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_NORESET"></a><a id="cds_noreset"></a><dl> <dt><b>CDS_NORESET</b></dt> </dl> </td> <td width="60%"> The
///              settings will be saved in the registry, but will not take effect. This flag is only valid when specified with the
///              CDS_UPDATEREGISTRY flag. </td> </tr> <tr> <td width="40%"><a id="CDS_RESET"></a><a id="cds_reset"></a><dl>
///              <dt><b>CDS_RESET</b></dt> </dl> </td> <td width="60%"> The settings should be changed, even if the requested
///              settings are the same as the current settings. </td> </tr> <tr> <td width="40%"><a id="CDS_SET_PRIMARY"></a><a
///              id="cds_set_primary"></a><dl> <dt><b>CDS_SET_PRIMARY</b></dt> </dl> </td> <td width="60%"> This device will
///              become the primary device. </td> </tr> <tr> <td width="40%"><a id="CDS_TEST"></a><a id="cds_test"></a><dl>
///              <dt><b>CDS_TEST</b></dt> </dl> </td> <td width="60%"> The system tests if the requested graphics mode could be
///              set. </td> </tr> <tr> <td width="40%"><a id="CDS_UPDATEREGISTRY"></a><a id="cds_updateregistry"></a><dl>
///              <dt><b>CDS_UPDATEREGISTRY</b></dt> </dl> </td> <td width="60%"> The graphics mode for the current screen will be
///              changed dynamically and the graphics mode will be updated in the registry. The mode information is stored in the
///              USER profile. </td> </tr> <tr> <td width="40%"><a id="CDS_VIDEOPARAMETERS"></a><a
///              id="cds_videoparameters"></a><dl> <dt><b>CDS_VIDEOPARAMETERS</b></dt> </dl> </td> <td width="60%"> When set, the
///              <i>lParam</i> parameter is a pointer to a VIDEOPARAMETERS structure. </td> </tr> <tr> <td width="40%"><a
///              id="CDS_ENABLE_UNSAFE_MODES"></a><a id="cds_enable_unsafe_modes"></a><dl> <dt><b>CDS_ENABLE_UNSAFE_MODES</b></dt>
///              </dl> </td> <td width="60%"> Enables settings changes to unsafe graphics modes. </td> </tr> <tr> <td
///              width="40%"><a id="CDS_DISABLE_UNSAFE_MODES"></a><a id="cds_disable_unsafe_modes"></a><dl>
///              <dt><b>CDS_DISABLE_UNSAFE_MODES</b></dt> </dl> </td> <td width="60%"> Disables settings changes to unsafe
///              graphics modes. </td> </tr> </table> Specifying CDS_TEST allows an application to determine which graphics modes
///              are actually valid, without causing the system to change to them. If CDS_UPDATEREGISTRY is specified and it is
///              possible to change the graphics mode dynamically, the information is stored in the registry and
///              DISP_CHANGE_SUCCESSFUL is returned. If it is not possible to change the graphics mode dynamically, the
///              information is stored in the registry and DISP_CHANGE_RESTART is returned. If CDS_UPDATEREGISTRY is specified and
///              the information could not be stored in the registry, the graphics mode is not changed and DISP_CHANGE_NOTUPDATED
///              is returned.
///    lParam = If <i>dwFlags</i> is <b>CDS_VIDEOPARAMETERS</b>, <i>lParam</i> is a pointer to a VIDEOPARAMETERS structure.
///             Otherwise <i>lParam</i> must be <b>NULL</b>.
///Returns:
///    The <b>ChangeDisplaySettingsEx</b> function returns one of the following values. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_SUCCESSFUL</b></dt> </dl>
///    </td> <td width="60%"> The settings change was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADDUALVIEW</b></dt> </dl> </td> <td width="60%"> The settings change was unsuccessful because
///    the system is DualView capable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADFLAGS</b></dt> </dl>
///    </td> <td width="60%"> An invalid set of flags was passed in. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_BADMODE</b></dt> </dl> </td> <td width="60%"> The graphics mode is not supported. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_BADPARAM</b></dt> </dl> </td> <td width="60%"> An invalid parameter
///    was passed in. This can include an invalid flag or combination of flags. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_FAILED</b></dt> </dl> </td> <td width="60%"> The display driver failed the specified graphics
///    mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_CHANGE_NOTUPDATED</b></dt> </dl> </td> <td width="60%">
///    Unable to write settings to the registry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_CHANGE_RESTART</b></dt> </dl> </td> <td width="60%"> The computer must be restarted for the graphics
///    mode to work. </td> </tr> </table>
///    
@DllImport("USER32")
int ChangeDisplaySettingsExW(const(wchar)* lpszDeviceName, DEVMODEW* lpDevMode, HWND hwnd, uint dwflags, 
                             void* lParam);

///The <b>EnumDisplaySettings</b> function retrieves information about one of the graphics modes for a display device.
///To retrieve information for all the graphics modes of a display device, make a series of calls to this function. <div
///class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query or set display modes
///that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a compatibility manifest that
///targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps that were built without a
///Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color mode.</div><div> </div>
///Params:
///    lpszDeviceName = A pointer to a null-terminated string that specifies the display device about whose graphics mode the function
///                     will obtain information. This parameter is either <b>NULL</b> or a DISPLAY_DEVICE.<b>DeviceName</b> returned from
///                     EnumDisplayDevices. A <b>NULL</b> value specifies the current display device on the computer on which the calling
///                     thread is running.
///    iModeNum = The type of information to be retrieved. This value can be a graphics mode index or one of the following values.
///               <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ENUM_CURRENT_SETTINGS"></a><a
///               id="enum_current_settings"></a><dl> <dt><b>ENUM_CURRENT_SETTINGS</b></dt> </dl> </td> <td width="60%"> Retrieve
///               the current settings for the display device. </td> </tr> <tr> <td width="40%"><a
///               id="ENUM_REGISTRY_SETTINGS"></a><a id="enum_registry_settings"></a><dl> <dt><b>ENUM_REGISTRY_SETTINGS</b></dt>
///               </dl> </td> <td width="60%"> Retrieve the settings for the display device that are currently stored in the
///               registry. </td> </tr> </table> Graphics mode indexes start at zero. To obtain information for all of a display
///               device's graphics modes, make a series of calls to <b>EnumDisplaySettings</b>, as follows: Set <i>iModeNum</i> to
///               zero for the first call, and increment <i>iModeNum</i> by one for each subsequent call. Continue calling the
///               function until the return value is zero. When you call <b>EnumDisplaySettings</b> with <i>iModeNum</i> set to
///               zero, the operating system initializes and caches information about the display device. When you call
///               <b>EnumDisplaySettings</b> with <i>iModeNum</i> set to a nonzero value, the function returns the information that
///               was cached the last time the function was called with <i>iModeNum</i> set to zero.
///    lpDevMode = A pointer to a DEVMODE structure into which the function stores information about the specified graphics mode.
///                Before calling <b>EnumDisplaySettings</b>, set the <b>dmSize</b> member to <code>sizeof(DEVMODE)</code>, and set
///                the <b>dmDriverExtra</b> member to indicate the size, in bytes, of the additional space available to receive
///                private driver data. The <b>EnumDisplaySettings</b> function sets values for the following five DEVMODE members:
///                <ul> <li><b>dmBitsPerPel</b></li> <li><b>dmPelsWidth</b></li> <li><b>dmPelsHeight</b></li>
///                <li><b>dmDisplayFlags</b></li> <li><b>dmDisplayFrequency</b></li> </ul>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL EnumDisplaySettingsA(const(char)* lpszDeviceName, uint iModeNum, DEVMODEA* lpDevMode);

///The <b>EnumDisplaySettings</b> function retrieves information about one of the graphics modes for a display device.
///To retrieve information for all the graphics modes of a display device, make a series of calls to this function. <div
///class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query or set display modes
///that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a compatibility manifest that
///targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps that were built without a
///Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color mode.</div><div> </div>
///Params:
///    lpszDeviceName = A pointer to a null-terminated string that specifies the display device about whose graphics mode the function
///                     will obtain information. This parameter is either <b>NULL</b> or a DISPLAY_DEVICE.<b>DeviceName</b> returned from
///                     EnumDisplayDevices. A <b>NULL</b> value specifies the current display device on the computer on which the calling
///                     thread is running.
///    iModeNum = The type of information to be retrieved. This value can be a graphics mode index or one of the following values.
///               <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ENUM_CURRENT_SETTINGS"></a><a
///               id="enum_current_settings"></a><dl> <dt><b>ENUM_CURRENT_SETTINGS</b></dt> </dl> </td> <td width="60%"> Retrieve
///               the current settings for the display device. </td> </tr> <tr> <td width="40%"><a
///               id="ENUM_REGISTRY_SETTINGS"></a><a id="enum_registry_settings"></a><dl> <dt><b>ENUM_REGISTRY_SETTINGS</b></dt>
///               </dl> </td> <td width="60%"> Retrieve the settings for the display device that are currently stored in the
///               registry. </td> </tr> </table> Graphics mode indexes start at zero. To obtain information for all of a display
///               device's graphics modes, make a series of calls to <b>EnumDisplaySettings</b>, as follows: Set <i>iModeNum</i> to
///               zero for the first call, and increment <i>iModeNum</i> by one for each subsequent call. Continue calling the
///               function until the return value is zero. When you call <b>EnumDisplaySettings</b> with <i>iModeNum</i> set to
///               zero, the operating system initializes and caches information about the display device. When you call
///               <b>EnumDisplaySettings</b> with <i>iModeNum</i> set to a nonzero value, the function returns the information that
///               was cached the last time the function was called with <i>iModeNum</i> set to zero.
///    lpDevMode = A pointer to a DEVMODE structure into which the function stores information about the specified graphics mode.
///                Before calling <b>EnumDisplaySettings</b>, set the <b>dmSize</b> member to <code>sizeof(DEVMODE)</code>, and set
///                the <b>dmDriverExtra</b> member to indicate the size, in bytes, of the additional space available to receive
///                private driver data. The <b>EnumDisplaySettings</b> function sets values for the following five DEVMODE members:
///                <ul> <li><b>dmBitsPerPel</b></li> <li><b>dmPelsWidth</b></li> <li><b>dmPelsHeight</b></li>
///                <li><b>dmDisplayFlags</b></li> <li><b>dmDisplayFrequency</b></li> </ul>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL EnumDisplaySettingsW(const(wchar)* lpszDeviceName, uint iModeNum, DEVMODEW* lpDevMode);

///The <b>EnumDisplaySettingsEx</b> function retrieves information about one of the graphics modes for a display device.
///To retrieve information for all the graphics modes for a display device, make a series of calls to this function.
///This function differs from EnumDisplaySettings in that there is a <i>dwFlags</i> parameter. <div
///class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query or set display modes
///that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a compatibility manifest that
///targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps that were built without a
///Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color mode.</div><div> </div>
///Params:
///    lpszDeviceName = A pointer to a null-terminated string that specifies the display device about which graphics mode the function
///                     will obtain information. This parameter is either <b>NULL</b> or a DISPLAY_DEVICE.<b>DeviceName</b> returned from
///                     EnumDisplayDevices. A <b>NULL</b> value specifies the current display device on the computer that the calling
///                     thread is running on.
///    iModeNum = Indicates the type of information to be retrieved. This value can be a graphics mode index or one of the
///               following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="ENUM_CURRENT_SETTINGS"></a><a id="enum_current_settings"></a><dl> <dt><b>ENUM_CURRENT_SETTINGS</b></dt> </dl>
///               </td> <td width="60%"> Retrieve the current settings for the display device. </td> </tr> <tr> <td width="40%"><a
///               id="ENUM_REGISTRY_SETTINGS"></a><a id="enum_registry_settings"></a><dl> <dt><b>ENUM_REGISTRY_SETTINGS</b></dt>
///               </dl> </td> <td width="60%"> Retrieve the settings for the display device that are currently stored in the
///               registry. </td> </tr> </table> Graphics mode indexes start at zero. To obtain information for all of a display
///               device's graphics modes, make a series of calls to <b>EnumDisplaySettingsEx</b>, as follows: Set <i>iModeNum</i>
///               to zero for the first call, and increment <i>iModeNum</i> by one for each subsequent call. Continue calling the
///               function until the return value is zero. When you call <b>EnumDisplaySettingsEx</b> with <i>iModeNum</i> set to
///               zero, the operating system initializes and caches information about the display device. When you call
///               <b>EnumDisplaySettingsEx</b> with <i>iModeNum</i> set to a nonzero value, the function returns the information
///               that was cached the last time the function was called with <i>iModeNum</i> set to zero.
///    lpDevMode = A pointer to a DEVMODE structure into which the function stores information about the specified graphics mode.
///                Before calling <b>EnumDisplaySettingsEx</b>, set the <b>dmSize</b> member to <b>sizeof</b> (DEVMODE), and set the
///                <b>dmDriverExtra</b> member to indicate the size, in bytes, of the additional space available to receive private
///                driver data. The <b>EnumDisplaySettingsEx</b> function will populate the <b>dmFields</b> member of the
///                <b>lpDevMode</b> and one or more other members of the DEVMODE structure. To determine which members were set by
///                the call to <b>EnumDisplaySettingsEx</b>, inspect the <i>dmFields</i> bitmask. Some of the fields typically
///                populated by this function include: <ul> <li><b>dmBitsPerPel</b></li> <li><b>dmPelsWidth</b></li>
///                <li><b>dmPelsHeight</b></li> <li><b>dmDisplayFlags</b></li> <li><b>dmDisplayFrequency</b></li>
///                <li><b>dmPosition</b></li> <li><b>dmDisplayOrientation</b></li> </ul>
///    dwFlags = This parameter can be the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="EDS_RAWMODE"></a><a id="eds_rawmode"></a><dl> <dt><b>EDS_RAWMODE</b></dt> </dl> </td> <td
///              width="60%"> If set, the function will return all graphics modes reported by the adapter driver, regardless of
///              monitor capabilities. Otherwise, it will only return modes that are compatible with current monitors. </td> </tr>
///              <tr> <td width="40%"><a id="EDS_ROTATEDMODE_"></a><a id="eds_rotatedmode_"></a><dl> <dt><b>EDS_ROTATEDMODE
///              </b></dt> </dl> </td> <td width="60%"> If set, the function will return graphics modes in all orientations.
///              Otherwise, it will only return modes that have the same orientation as the one currently set for the requested
///              display. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL EnumDisplaySettingsExA(const(char)* lpszDeviceName, uint iModeNum, DEVMODEA* lpDevMode, uint dwFlags);

///The <b>EnumDisplaySettingsEx</b> function retrieves information about one of the graphics modes for a display device.
///To retrieve information for all the graphics modes for a display device, make a series of calls to this function.
///This function differs from EnumDisplaySettings in that there is a <i>dwFlags</i> parameter. <div
///class="alert"><b>Note</b> Apps that you design to target Windows 8 and later can no longer query or set display modes
///that are less than 32 bits per pixel (bpp); these operations will fail. These apps have a compatibility manifest that
///targets Windows 8. Windows 8 still supports 8-bit and 16-bit color modes for desktop apps that were built without a
///Windows 8 manifest; Windows 8 emulates these modes but still runs in 32-bit color mode.</div><div> </div>
///Params:
///    lpszDeviceName = A pointer to a null-terminated string that specifies the display device about which graphics mode the function
///                     will obtain information. This parameter is either <b>NULL</b> or a DISPLAY_DEVICE. <b>DeviceName</b> returned
///                     from EnumDisplayDevices. A <b>NULL</b> value specifies the current display device on the computer that the
///                     calling thread is running on.
///    iModeNum = Indicates the type of information to be retrieved. This value can be a graphics mode index or one of the
///               following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="ENUM_CURRENT_SETTINGS"></a><a id="enum_current_settings"></a><dl> <dt><b>ENUM_CURRENT_SETTINGS</b></dt> </dl>
///               </td> <td width="60%"> Retrieve the current settings for the display device. </td> </tr> <tr> <td width="40%"><a
///               id="ENUM_REGISTRY_SETTINGS"></a><a id="enum_registry_settings"></a><dl> <dt><b>ENUM_REGISTRY_SETTINGS</b></dt>
///               </dl> </td> <td width="60%"> Retrieve the settings for the display device that are currently stored in the
///               registry. </td> </tr> </table> Graphics mode indexes start at zero. To obtain information for all of a display
///               device's graphics modes, make a series of calls to <b>EnumDisplaySettingsEx</b>, as follows: Set <i>iModeNum</i>
///               to zero for the first call, and increment <i>iModeNum</i> by one for each subsequent call. Continue calling the
///               function until the return value is zero. When you call <b>EnumDisplaySettingsEx</b> with <i>iModeNum</i> set to
///               zero, the operating system initializes and caches information about the display device. When you call
///               <b>EnumDisplaySettingsEx</b> with <i>iModeNum</i> set to a nonzero value, the function returns the information
///               that was cached the last time the function was called with <i>iModeNum</i> set to zero.
///    lpDevMode = A pointer to a DEVMODE structure into which the function stores information about the specified graphics mode.
///                Before calling <b>EnumDisplaySettingsEx</b>, set the <b>dmSize</b> member to <b>sizeof</b> (DEVMODE), and set the
///                <b>dmDriverExtra</b> member to indicate the size, in bytes, of the additional space available to receive private
///                driver data. The <b>EnumDisplaySettingsEx</b> function will populate the <b>dmFields</b> member of the
///                <b>lpDevMode</b> and one or more other members of the DEVMODE structure. To determine which members were set by
///                the call to <b>EnumDisplaySettingsEx</b>, inspect the <i>dmFields</i> bitmask. Some of the fields typically
///                populated by this function include: <ul> <li><b>dmBitsPerPel</b></li> <li><b>dmPelsWidth</b></li>
///                <li><b>dmPelsHeight</b></li> <li><b>dmDisplayFlags</b></li> <li><b>dmDisplayFrequency</b></li>
///                <li><b>dmPosition</b></li> <li><b>dmDisplayOrientation</b></li> </ul>
///    dwFlags = This parameter can be the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="EDS_RAWMODE"></a><a id="eds_rawmode"></a><dl> <dt><b>EDS_RAWMODE</b></dt> </dl> </td> <td
///              width="60%"> If set, the function will return all graphics modes reported by the adapter driver, regardless of
///              monitor capabilities. Otherwise, it will only return modes that are compatible with current monitors. </td> </tr>
///              <tr> <td width="40%"><a id="EDS_ROTATEDMODE_"></a><a id="eds_rotatedmode_"></a><dl> <dt><b>EDS_ROTATEDMODE
///              </b></dt> </dl> </td> <td width="60%"> If set, the function will return graphics modes in all orientations.
///              Otherwise, it will only return modes that have the same orientation as the one currently set for the requested
///              display. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL EnumDisplaySettingsExW(const(wchar)* lpszDeviceName, uint iModeNum, DEVMODEW* lpDevMode, uint dwFlags);

///The <b>EnumDisplayDevices</b> function lets you obtain information about the display devices in the current session.
///Params:
///    lpDevice = A pointer to the device name. If <b>NULL</b>, function returns information for the display adapter(s) on the
///               machine, based on <i>iDevNum</i>. For more information, see Remarks.
///    iDevNum = An index value that specifies the display device of interest. The operating system identifies each display device
///              in the current session with an index value. The index values are consecutive integers, starting at 0. If the
///              current session has three display devices, for example, they are specified by the index values 0, 1, and 2.
///    lpDisplayDevice = A pointer to a DISPLAY_DEVICE structure that receives information about the display device specified by
///                      <i>iDevNum</i>. Before calling <b>EnumDisplayDevices</b>, you must initialize the <b>cb</b> member of
///                      DISPLAY_DEVICE to the size, in bytes, of <b>DISPLAY_DEVICE</b>.
///    dwFlags = Set this flag to EDD_GET_DEVICE_INTERFACE_NAME (0x00000001) to retrieve the device interface name for
///              GUID_DEVINTERFACE_MONITOR, which is registered by the operating system on a per monitor basis. The value is
///              placed in the DeviceID member of the DISPLAY_DEVICE structure returned in <i>lpDisplayDevice</i>. The resulting
///              device interface name can be used with SetupAPI functions and serves as a link between GDI monitor devices and
///              SetupAPI monitor devices.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. The
///    function fails if <i>iDevNum</i> is greater than the largest device index.
///    
@DllImport("USER32")
BOOL EnumDisplayDevicesA(const(char)* lpDevice, uint iDevNum, DISPLAY_DEVICEA* lpDisplayDevice, uint dwFlags);

///The <b>EnumDisplayDevices</b> function lets you obtain information about the display devices in the current session.
///Params:
///    lpDevice = A pointer to the device name. If <b>NULL</b>, function returns information for the display adapter(s) on the
///               machine, based on <i>iDevNum</i>. For more information, see Remarks.
///    iDevNum = An index value that specifies the display device of interest. The operating system identifies each display device
///              in the current session with an index value. The index values are consecutive integers, starting at 0. If the
///              current session has three display devices, for example, they are specified by the index values 0, 1, and 2.
///    lpDisplayDevice = A pointer to a DISPLAY_DEVICE structure that receives information about the display device specified by
///                      <i>iDevNum</i>. Before calling <b>EnumDisplayDevices</b>, you must initialize the <b>cb</b> member of
///                      DISPLAY_DEVICE to the size, in bytes, of <b>DISPLAY_DEVICE</b>.
///    dwFlags = Set this flag to EDD_GET_DEVICE_INTERFACE_NAME (0x00000001) to retrieve the device interface name for
///              GUID_DEVINTERFACE_MONITOR, which is registered by the operating system on a per monitor basis. The value is
///              placed in the DeviceID member of the DISPLAY_DEVICE structure returned in <i>lpDisplayDevice</i>. The resulting
///              device interface name can be used with SetupAPI functions and serves as a link between GDI monitor devices and
///              SetupAPI monitor devices.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. The
///    function fails if <i>iDevNum</i> is greater than the largest device index.
///    
@DllImport("USER32")
BOOL EnumDisplayDevicesW(const(wchar)* lpDevice, uint iDevNum, DISPLAY_DEVICEW* lpDisplayDevice, uint dwFlags);

///The <b>MonitorFromPoint</b> function retrieves a handle to the display monitor that contains a specified point.
///Params:
///    pt = A POINT structure that specifies the point of interest in virtual-screen coordinates.
///    dwFlags = Determines the function's return value if the point is not contained within any display monitor. This parameter
///              can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MONITOR_DEFAULTTONEAREST"></a><a id="monitor_defaulttonearest"></a><dl>
///              <dt><b>MONITOR_DEFAULTTONEAREST</b></dt> </dl> </td> <td width="60%"> Returns a handle to the display monitor
///              that is nearest to the point. </td> </tr> <tr> <td width="40%"><a id="MONITOR_DEFAULTTONULL"></a><a
///              id="monitor_defaulttonull"></a><dl> <dt><b>MONITOR_DEFAULTTONULL</b></dt> </dl> </td> <td width="60%"> Returns
///              <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="MONITOR_DEFAULTTOPRIMARY"></a><a
///              id="monitor_defaulttoprimary"></a><dl> <dt><b>MONITOR_DEFAULTTOPRIMARY</b></dt> </dl> </td> <td width="60%">
///              Returns a handle to the primary display monitor. </td> </tr> </table>
///Returns:
///    If the point is contained by a display monitor, the return value is an <b>HMONITOR</b> handle to that display
///    monitor. If the point is not contained by a display monitor, the return value depends on the value of
///    <i>dwFlags</i>.
///    
@DllImport("USER32")
ptrdiff_t MonitorFromPoint(POINT pt, uint dwFlags);

///The <b>MonitorFromRect</b> function retrieves a handle to the display monitor that has the largest area of
///intersection with a specified rectangle.
///Params:
///    lprc = A pointer to a RECT structure that specifies the rectangle of interest in virtual-screen coordinates.
///    dwFlags = Determines the function's return value if the rectangle does not intersect any display monitor. This parameter
///              can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MONITOR_DEFAULTTONEAREST"></a><a id="monitor_defaulttonearest"></a><dl>
///              <dt><b>MONITOR_DEFAULTTONEAREST</b></dt> </dl> </td> <td width="60%"> Returns a handle to the display monitor
///              that is nearest to the rectangle. </td> </tr> <tr> <td width="40%"><a id="MONITOR_DEFAULTTONULL"></a><a
///              id="monitor_defaulttonull"></a><dl> <dt><b>MONITOR_DEFAULTTONULL</b></dt> </dl> </td> <td width="60%"> Returns
///              <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="MONITOR_DEFAULTTOPRIMARY"></a><a
///              id="monitor_defaulttoprimary"></a><dl> <dt><b>MONITOR_DEFAULTTOPRIMARY</b></dt> </dl> </td> <td width="60%">
///              Returns a handle to the primary display monitor. </td> </tr> </table>
///Returns:
///    If the rectangle intersects one or more display monitor rectangles, the return value is an <b>HMONITOR</b> handle
///    to the display monitor that has the largest area of intersection with the rectangle. If the rectangle does not
///    intersect a display monitor, the return value depends on the value of <i>dwFlags</i>.
///    
@DllImport("USER32")
ptrdiff_t MonitorFromRect(RECT* lprc, uint dwFlags);

///The <b>MonitorFromWindow</b> function retrieves a handle to the display monitor that has the largest area of
///intersection with the bounding rectangle of a specified window.
///Params:
///    hwnd = A handle to the window of interest.
///    dwFlags = Determines the function's return value if the window does not intersect any display monitor. This parameter can
///              be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MONITOR_DEFAULTTONEAREST"></a><a id="monitor_defaulttonearest"></a><dl>
///              <dt><b>MONITOR_DEFAULTTONEAREST</b></dt> </dl> </td> <td width="60%"> Returns a handle to the display monitor
///              that is nearest to the window. </td> </tr> <tr> <td width="40%"><a id="MONITOR_DEFAULTTONULL"></a><a
///              id="monitor_defaulttonull"></a><dl> <dt><b>MONITOR_DEFAULTTONULL</b></dt> </dl> </td> <td width="60%"> Returns
///              <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="MONITOR_DEFAULTTOPRIMARY"></a><a
///              id="monitor_defaulttoprimary"></a><dl> <dt><b>MONITOR_DEFAULTTOPRIMARY</b></dt> </dl> </td> <td width="60%">
///              Returns a handle to the primary display monitor. </td> </tr> </table>
///Returns:
///    If the window intersects one or more display monitor rectangles, the return value is an <b>HMONITOR</b> handle to
///    the display monitor that has the largest area of intersection with the window. If the window does not intersect a
///    display monitor, the return value depends on the value of <i>dwFlags</i>.
///    
@DllImport("USER32")
ptrdiff_t MonitorFromWindow(HWND hwnd, uint dwFlags);

///The <b>GetMonitorInfo</b> function retrieves information about a display monitor.
///Params:
///    hMonitor = A handle to the display monitor of interest.
///    lpmi = A pointer to a MONITORINFO or MONITORINFOEX structure that receives information about the specified display
///           monitor. You must set the <b>cbSize</b> member of the structure to sizeof(MONITORINFO) or sizeof(MONITORINFOEX)
///           before calling the <b>GetMonitorInfo</b> function. Doing so lets the function determine the type of structure you
///           are passing to it. The MONITORINFOEX structure is a superset of the MONITORINFO structure. It has one additional
///           member: a string that contains a name for the display monitor. Most applications have no use for a display
///           monitor name, and so can save some bytes by using a <b>MONITORINFO</b> structure.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL GetMonitorInfoA(ptrdiff_t hMonitor, MONITORINFO* lpmi);

///The <b>GetMonitorInfo</b> function retrieves information about a display monitor.
///Params:
///    hMonitor = A handle to the display monitor of interest.
///    lpmi = A pointer to a MONITORINFO or MONITORINFOEX structure that receives information about the specified display
///           monitor. You must set the <b>cbSize</b> member of the structure to sizeof(MONITORINFO) or sizeof(MONITORINFOEX)
///           before calling the <b>GetMonitorInfo</b> function. Doing so lets the function determine the type of structure you
///           are passing to it. The MONITORINFOEX structure is a superset of the MONITORINFO structure. It has one additional
///           member: a string that contains a name for the display monitor. Most applications have no use for a display
///           monitor name, and so can save some bytes by using a <b>MONITORINFO</b> structure.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL GetMonitorInfoW(ptrdiff_t hMonitor, MONITORINFO* lpmi);

///The <b>EnumDisplayMonitors</b> function enumerates display monitors (including invisible pseudo-monitors associated
///with the mirroring drivers) that intersect a region formed by the intersection of a specified clipping rectangle and
///the visible region of a device context. <b>EnumDisplayMonitors</b> calls an application-defined MonitorEnumProc
///callback function once for each monitor that is enumerated. Note that GetSystemMetrics (SM_CMONITORS) counts only the
///display monitors.
///Params:
///    hdc = A handle to a display device context that defines the visible region of interest. If this parameter is
///          <b>NULL</b>, the <i>hdcMonitor</i> parameter passed to the callback function will be <b>NULL</b>, and the visible
///          region of interest is the virtual screen that encompasses all the displays on the desktop.
///    lprcClip = A pointer to a RECT structure that specifies a clipping rectangle. The region of interest is the intersection of
///               the clipping rectangle with the visible region specified by <i>hdc</i>. If <i>hdc</i> is non-<b>NULL</b>, the
///               coordinates of the clipping rectangle are relative to the origin of the <i>hdc</i>. If <i>hdc</i> is <b>NULL</b>,
///               the coordinates are virtual-screen coordinates. This parameter can be <b>NULL</b> if you don't want to clip the
///               region specified by <i>hdc</i>.
///    lpfnEnum = A pointer to a MonitorEnumProc application-defined callback function.
///    dwData = Application-defined data that <b>EnumDisplayMonitors</b> passes directly to the MonitorEnumProc function.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("USER32")
BOOL EnumDisplayMonitors(HDC hdc, RECT* lprcClip, MONITORENUMPROC lpfnEnum, LPARAM dwData);


