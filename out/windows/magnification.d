// Written in the D programming language.

module windows.magnification;

public import windows.core;
public import windows.displaydevices : RECT;
public import windows.gdi : HRGN;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Callbacks

///<div class="alert"><b>Note</b> The <i>MagImageScalingCallback</i> function is deprecated in Windows 7 and later, and
///should not be used in new applications. There is no alternate functionality.</div><div> </div>Prototype for a
///callback function that implements a custom transform for image scaling.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    srcdata = Type: <b>void*</b> The input data.
///    srcheader = Type: <b>MAGIMAGEHEADER</b> The description of the input format.
///    destdata = Type: <b>void*</b> The output data.
///    destheader = Type: <b>MAGIMAGEHEADER</b> The description of the output format.
///    unclipped = Type: <b>RECT</b> The coordinates of the scaled version of the source bitmap.
///    clipped = Type: <b>RECT</b> The coordinates of the window to which the scaled bitmap is clipped.
///    dirty = Type: <b>HRGN</b> The region that needs to be refreshed.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
alias MagImageScalingCallback = BOOL function(HWND hwnd, void* srcdata, MAGIMAGEHEADER srcheader, void* destdata, 
                                              MAGIMAGEHEADER destheader, RECT unclipped, RECT clipped, HRGN dirty);

// Structs


///Describes a transformation matrix that a magnifier control uses to magnify screen content.
struct MAGTRANSFORM
{
    ///Type: <b>float[3]</b> The transformation matrix.
    float[9] v;
}

///<div class="alert"><b>Note</b> The <b>MAGIMAGEHEADER</b> structure is deprecated in Windows 7 and later, and should
///not be used in new applications. There is no alternate functionality.</div><div> </div>Describes an image format.
struct MAGIMAGEHEADER
{
    ///Type: <b>UINT</b> The width of the image.
    uint   width;
    ///Type: <b>UINT</b> The height of the image.
    uint   height;
    ///Type: <b>WICPixelFormatGUID</b> A WICPixelFormatGUID (declared in wincodec.h) that specifies the pixel format of
    ///the image. For a list of available pixel formats, see the Native Pixel Formats topic.
    GUID   format;
    ///Type: <b>UINT</b> The stride, or number of bytes in a row of the image.
    uint   stride;
    ///Type: <b>UINT</b> The offset of the start of the image data from the beginning of the file.
    uint   offset;
    ///Type: <b>SIZE_T</b> The size of the data.
    size_t cbSize;
}

///Describes a color transformation matrix that a magnifier control uses to apply a color effect to magnified screen
///content.
struct MAGCOLOREFFECT
{
    ///Type: <b>float [5] [5]</b> The color transformation matrix.
    float[25] transform;
}

// Functions

///Creates and initializes the magnifier run-time objects.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if initialization was successful; otherwise <b>FALSE</b>.
///    
@DllImport("MAGNIFICATION")
BOOL MagInitialize();

///Destroys the magnifier run-time objects.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagUninitialize();

///Sets the source rectangle for the magnification window.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    rect = Type: <b>RECT</b> The rectangle to be magnified, in desktop coordinates.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetWindowSource(HWND hwnd, RECT rect);

///Gets the rectangle of the area that is being magnified.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    pRect = Type: <b>RECT*</b> The rectangle that is being magnified, in desktop coordinates.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagGetWindowSource(HWND hwnd, RECT* pRect);

///Sets the transformation matrix for a magnifier control.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    pTransform = Type: <b>PMAGTRANSFORM</b> A transformation matrix.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

///Retrieves the transformation matrix associated with a magnifier control.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    pTransform = Type: <b>PMAGTRANSFORM</b> The transformation matrix.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagGetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

///Sets the list of windows to be magnified or the list of windows to be excluded from magnification.
///Params:
///    hwnd = Type: <b>HWND</b> The handle of the magnification window.
///    dwFilterMode = Type: <b>DWORD</b> The magnification filter mode. It can be one of the following values: <table> <tr>
///                   <th>Value</th> <th>Meaning</th> </tr> <tr> <td>MW_FILTERMODE_INCLUDE</td> <td>Magnify the windows. <div
///                   class="alert"><b>Note:</b> This value is not supported on Windows 7 or newer.</div> <div> </div> </td> </tr> <tr>
///                   <td>MW_FILTERMODE_EXCLUDE</td> <td>Exclude the windows from magnification.</td> </tr> </table>
///    count = Type: <b>int</b> The number of window handles in the list.
///    pHWND = Type: <b>HWND*</b> The list of window handles.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetWindowFilterList(HWND hwnd, uint dwFilterMode, int count, HWND* pHWND);

///Retrieves the list of windows that are magnified or excluded from magnification.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    pdwFilterMode = Type: <b>DWORD*</b> The filter mode, as set by MagSetWindowFilterList.
///    count = Type: <b>int</b> The number of windows to retrieve, or 0 to retrieve a count of windows in the filter list.
///    pHWND = Type: <b>HWND*</b> The list of window handles.
///Returns:
///    Type: <b>int</b> Returns the count of window handles in the filter list, or -1 if the <i>hwnd</i> parameter is
///    not valid.
///    
@DllImport("MAGNIFICATION")
int MagGetWindowFilterList(HWND hwnd, uint* pdwFilterMode, int count, HWND* pHWND);

///<div class="alert"><b>Note</b> The <b>MagSetImageScalingCallback</b> function is deprecated in Windows 7 and later,
///and should not be used in new applications. There is no alternate functionality.</div> <div> </div> Sets the callback
///function for external image filtering and scaling.
///Params:
///    hwnd = Type: <b>HWND</b> The handle of the magnification window.
///    callback = Type: <b>MagImageScalingCallback</b> The callback function, or <b>NULL</b> to remove a callback that was
///               previously set.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetImageScalingCallback(HWND hwnd, MagImageScalingCallback callback);

///<div class="alert"><b>Note</b> The <b>MagGetImageScalingCallback</b> function is deprecated in Windows 7 and later,
///and should not be used in new applications. There is no alternate functionality.</div> <div> </div> Retrieves the
///registered callback function that implements a custom transform for image scaling.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///Returns:
///    Type: <b>MagImageScalingCallback</b> Returns the registered MagImageScalingCallback callback function, or
///    <b>NULL</b> if no callback is registered.
///    
@DllImport("MAGNIFICATION")
MagImageScalingCallback MagGetImageScalingCallback(HWND hwnd);

///Sets the color transformation matrix for a magnifier control.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    pEffect = Type: <b>PMAGCOLOREFFECT</b> The color transformation matrix, or <b>NULL</b> to remove the current color effect,
///              if any.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

///Gets the color transformation matrix for a magnifier control.
///Params:
///    hwnd = Type: <b>HWND</b> The magnification window.
///    pEffect = Type: <b>PMAGCOLOREFFECT</b> The color transformation matrix, or <b>NULL</b> if no color effect has been set.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagGetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

///Changes the magnification settings for the full-screen magnifier.
///Params:
///    magLevel = Type: **float** The new magnification factor for the full-screen magnifier. The minimum value of this parameter
///               is 1.0, and the maximum value is 4096.0. If this value is 1.0, the screen content is not magnified and no offsets
///               are applied.
///    xOffset = Type: **int** The new x-coordinate offset, in pixels, for the upper-left corner of the magnified view. The offset
///              is relative to the upper-left corner of the primary monitor, in unmagnified coordinates. The minimum value of the
///              parameter is -262144, and the maximum value is 262144.
///    yOffset = Type: **int** The new y-coordinate offset, in pixels, for the upper-left corner of the magnified view. The offset
///              is relative to the upper-left corner of the primary monitor, in unmagnified coordinates. The minimum value of the
///              parameter is -262144, and the maximum value is 262144.
///Returns:
///    Type: **BOOL** Returns TRUE if successful. Otherwise, FALSE.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetFullscreenTransform(float magLevel, int xOffset, int yOffset);

///Retrieves the magnification settings for the full-screen magnifier.
///Params:
///    pMagLevel = Type: <b>float*</b> The current magnification factor for the full-screen magnifier. A value of 1.0 indicates that
///                the screen content is not being magnified. A value above 1.0 indicates the scale factor for magnification. A
///                value less than 1.0 is not valid.
///    pxOffset = Type: <b>int*</b> The x-coordinate offset for the upper-left corner of the unmagnified view. The offset is
///               relative to the upper-left corner of the primary monitor, in unmagnified coordinates.
///    pyOffset = Type: <b>int*</b> The y-coordinate offset for the upper-left corner of the unmagnified view. The offset is
///               relative to the upper-left corner of the primary monitor, in unmagnified coordinates.
///Returns:
///    Type: <b>BOOL</b> Returns TRUE if successful, or FALSE otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagGetFullscreenTransform(float* pMagLevel, int* pxOffset, int* pyOffset);

///Changes the color transformation matrix associated with the full-screen magnifier.
///Params:
///    pEffect = Type: <b>PMAGCOLOREFFECT</b> The new color transformation matrix. This parameter must not be NULL.
///Returns:
///    Type: <b>BOOL</b> Returns TRUE if successful, or FALSE otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

///Retrieves the color transformation matrix associated with the full-screen magnifier.
///Params:
///    pEffect = Type: <b>PMAGCOLOREFFECT</b> The color transformation matrix, or the identity matrix if no color effect has been
///              set.
///Returns:
///    Type: <b>BOOL</b> Returns TRUE if successful, or FALSE otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagGetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

///Sets the current active input transformation for pen and touch input, represented as a source rectangle and a
///destination rectangle.
///Params:
///    fEnabled = Type: **[BOOL](/windows/win32/WinProg/windows-data-types)** TRUE to enable input transformation, or FALSE to
///               disable it.
///    pRectSource = Type: **const [LPRECT](../windef/ns-windef-rect.md)** The new source rectangle, in unmagnified screen
///                  coordinates, that defines the area of the screen to magnify. This parameter is ignored if *bEnabled* is FALSE.
///    pRectDest = Type: **const [LPRECT](../windef/ns-windef-rect.md)** The new destination rectangle, in unmagnified screen
///                coordinates, that defines the area of the screen where the magnified screen content is displayed. Pen and touch
///                input in this rectangle is mapped to the source rectangle. This parameter is ignored if *bEnabled* is FALSE.
///Returns:
///    Type: **[BOOL](/windows/win32/WinProg/windows-data-types)** Returns TRUE if successful, or FALSE otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagSetInputTransform(BOOL fEnabled, const(RECT)* pRectSource, const(RECT)* pRectDest);

///Retrieves the current input transformation for pen and touch input, represented as a source rectangle and a
///destination rectangle.
///Params:
///    pfEnabled = Type: <b>BOOL*</b> TRUE if input translation is enabled, or FALSE if not.
///    pRectSource = Type: <b>LPRECT</b> The source rectangle, in unmagnified screen coordinates, that defines the area of the screen
///                  that is magnified.
///    pRectDest = Type: <b>LPRECT</b> The destination rectangle, in screen coordinates, that defines the area of the screen where
///                the magnified screen content is displayed. Pen and touch input in this rectangle is mapped to the source
///                rectangle.
///Returns:
///    Type: <b>BOOL</b> Returns TRUE if successful, or FALSE otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagGetInputTransform(int* pfEnabled, RECT* pRectSource, RECT* pRectDest);

///Shows or hides the system cursor.
///Params:
///    fShowCursor = Type: <b>BOOL</b> TRUE to show the system cursor, or FALSE to hide it.
///Returns:
///    Type: <b>BOOL</b> Returns TRUE if successful, or FALSE otherwise.
///    
@DllImport("MAGNIFICATION")
BOOL MagShowSystemCursor(BOOL fShowCursor);


