// Written in the D programming language.

module windows.windowscolorsystem;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HCOLORSPACE, HDC, HPALETTE, RGBTRIPLE;
public import windows.kernel : LUID;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : DLGPROC, HWND, LPARAM;

extern(Windows):


// Enums


///The values of the **COLORTYPE** enumeration are used by several WCS functions. Variables of type **COLOR** are
///defined in the color spaces enumerated by the **COLORTYPE** enumeration.
alias COLORTYPE = int;
enum : int
{
    ///The **COLOR** is in the GRAYCOLOR color space.
    COLOR_GRAY      = 0x00000001,
    ///The **COLOR** is in the RGBCOLOR color space.
    COLOR_RGB       = 0x00000002,
    ///The **COLOR** is in the XYZCOLOR color space.
    COLOR_XYZ       = 0x00000003,
    ///The **COLOR** is in the YxyCOLOR color space.
    COLOR_Yxy       = 0x00000004,
    ///The **COLOR** is in the LabCOLOR color space.
    COLOR_Lab       = 0x00000005,
    ///The **COLOR** is in the GENERIC3CHANNEL color space.
    COLOR_3_CHANNEL = 0x00000006,
    ///The **COLOR** is in the CMYKCOLOR color space.
    COLOR_CMYK      = 0x00000007,
    ///The **COLOR** is in a five channel color space.
    COLOR_5_CHANNEL = 0x00000008,
    ///The **COLOR** is in a six channel color space.
    COLOR_6_CHANNEL = 0x00000009,
    ///The **COLOR** is in a seven channel color space.
    COLOR_7_CHANNEL = 0x0000000a,
    ///The **COLOR** is in an eight channel color space.
    COLOR_8_CHANNEL = 0x0000000b,
    ///The **COLOR** is in a named color space.
    COLOR_NAMED     = 0x0000000c,
}

///Specifies the type of color profile.
alias COLORPROFILETYPE = int;
enum : int
{
    ///An International Color Consortium (ICC) profile. If you specify this value, only the CPST\_RGB\_WORKING\_SPACE
    ///and CPST\_CUSTOM\_WORKING\_SPACE values of
    ///[**COLORPROFILESUBTYPE**](/windows/win32/api/icm/ne-icm-colorprofilesubtype) are valid.
    CPT_ICC  = 0x00000000,
    ///A device model profile (DMP) defined in WCS. If you specify this value, only the CPST\_RGB\_WORKING\_SPACE and
    ///CPST\_CUSTOM\_WORKING\_SPACE values of
    ///[**COLORPROFILESUBTYPE**](/windows/win32/api/icm/ne-icm-colorprofilesubtype) are valid.
    CPT_DMP  = 0x00000001,
    ///A color appearance model profile (CAMP) defined in WCS. If you specify this value, only the CPST\_NONE value of
    ///[**COLORPROFILESUBTYPE**](/windows/win32/api/icm/ne-icm-colorprofilesubtype) is valid.
    CPT_CAMP = 0x00000002,
    ///Specifies a WCS gamut map model profile (GMMP). If this value is specified, only the CPST\_PERCEPTUAL,
    ///CPST\_SATURATION, CPST\_RELATIVE\_COLORIMETRIC, and CPST\_ABSOLUTE\_COLORIMETRIC values of
    ///[**COLORPROFILESUBTYPE**](/windows/win32/api/icm/ne-icm-colorprofilesubtype) are valid. Any of these values may
    ///optionally be combined (in a bitwise **OR** operation) with CPST\_DEFAULT.
    CPT_GMMP = 0x00000003,
}

///Specifies the subtype of the color profile.
alias COLORPROFILESUBTYPE = int;
enum : int
{
    ///A perceptual rendering intent for gamut map model profiles (GMMPs) defined in WCS.
    CPST_PERCEPTUAL                  = 0x00000000,
    ///A relative colorimetric rendering intent for GMMPs defined in WCS.
    CPST_RELATIVE_COLORIMETRIC       = 0x00000001,
    ///A saturation rendering intent for GMMPs defined in WCS.
    CPST_SATURATION                  = 0x00000002,
    ///An absolute colorimetric rendering intent for GMMPs defined in WCS.
    CPST_ABSOLUTE_COLORIMETRIC       = 0x00000003,
    ///The color profile subtype is not applicable to the selected color profile type.
    CPST_NONE                        = 0x00000004,
    ///The RGB color working space for International Color Consortium (ICC) profiles or device model profiles (DMPs)
    ///defined in WCS.
    CPST_RGB_WORKING_SPACE           = 0x00000005,
    ///A custom color working space.
    CPST_CUSTOM_WORKING_SPACE        = 0x00000006,
    ///TBD
    CPST_STANDARD_DISPLAY_COLOR_MODE = 0x00000007,
    ///TBD
    CPST_EXTENDED_DISPLAY_COLOR_MODE = 0x00000008,
}

///Used by WCS functions to indicate the data type of vector content.
alias COLORDATATYPE = int;
enum : int
{
    ///Color data is stored as 8 bits per channel, with a value from 0 to 255, inclusive.
    COLOR_BYTE               = 0x00000001,
    ///Color data is stored as 16 bits per channel, with a value from 0 to 65535, inclusive.
    COLOR_WORD               = 0x00000002,
    ///Color data is stored as 32 bits value per channel, as defined by the IEEE 32-bit floating point standard.
    COLOR_FLOAT              = 0x00000003,
    ///Color data is stored as 16 bits per channel, with a fixed range of -4 to +4, inclusive. A signed format is used,
    ///with 1 bit for the sign, 2 bits for the integer portion, and 13 bits for the fractional portion.
    COLOR_S2DOT13FIXED       = 0x00000004,
    ///Color data is stored as 10 bits per channel. The two most significant bits are alpha.
    COLOR_10b_R10G10B10A2    = 0x00000005,
    ///Color data is stored as 10 bits per channel, 32 bits per pixel. The 10 bits of each color channel are 2.8 fixed
    ///point with a -0.75 bias, giving a range of \[-0.76 .. 1.25\]. This range corresponds to \[-0.5 .. 1.5\] in a
    ///gamma = 1 space. The two most significant bits are preserved for alpha. This uses an extended range (XR) sRGB
    ///color space. It has the same RGB primaries, white point, and gamma as sRGB.
    COLOR_10b_R10G10B10A2_XR = 0x00000006,
    ///Color data is stored as 16 bits value per channel, as defined by the IEEE 16-bit floating point standard.
    COLOR_FLOAT16            = 0x00000007,
}

///The values of the **BMFORMAT** enumerated type are used by several WCS functions to indicate the format that
///particular bitmaps are in.
alias BMFORMAT = int;
enum : int
{
    ///16 bits per pixel. RGB color space. 5 bits per channel. The most significant bit is ignored.
    BM_x555RGB             = 0x00000000,
    ///16 bits per pixel. CIE device-independent XYZ color space. 5 bits per channel. The most significant bit is
    ///ignored.
    BM_x555XYZ             = 0x00000101,
    ///16 bits per pixel. Yxy color space. 5 bits per channel. The most significant bit is ignored.
    BM_x555Yxy             = 0x00000102,
    ///16 bits per pixel. L\*a\*b color space. 5 bits per channel. The most significant bit is ignored.
    BM_x555Lab             = 0x00000103,
    ///16 bits per pixel. G3CH color space. 5 bits per channel. The most significant bit is ignored.
    BM_x555G3CH            = 0x00000104,
    ///24 bits per pixel maximum. For three channel colors, such as Red,Green,Blue, the total size is 24 bits per pixel.
    ///For single channel colors, such as gray, the total size is 8 bits per pixel.
    BM_RGBTRIPLETS         = 0x00000002,
    ///24 bits per pixel maximum. For three channel colors, such as Red,Green,Blue, the total size is 24 bits per pixel.
    ///For single channel colors, such as gray, the total size is 8 bits per pixel.
    BM_BGRTRIPLETS         = 0x00000004,
    ///24 bits per pixel maximum. For three channel, X, Y and Z values, the total size is 24 bits per pixel. For single
    ///channel gray scale, the total size is 8 bits per pixel. > [!Note] > The
    ///[**TranslateBitmapBits**](/windows/win32/api/icm/nf-icm-translatebitmapbits) function does not support
    ///[**BM\_XYZTRIPLETS**](/windows/win32/api/icm/ne-icm-bmformat) as an input.
    BM_XYZTRIPLETS         = 0x00000201,
    ///24 bits per pixel maximum. For three channel, Y, x and y values, the total size is 24 bits per pixel. For single
    ///channel gray scale, the total size is 8 bits per pixel. > [!Note] > The
    ///[**TranslateBitmapBits**](/windows/win32/api/icm/nf-icm-translatebitmapbits) function does not support
    ///[**BM\_YxyTRIPLETS**](/windows/win32/api/icm/ne-icm-bmformat) as an input.
    BM_YxyTRIPLETS         = 0x00000202,
    ///24 bits per pixel maximum. For three channel, L, a and b values, the total size is 24 bits per pixel. For single
    ///channel gray scale, the total size is 8 bits per pixel.
    BM_LabTRIPLETS         = 0x00000203,
    ///24 bits per pixel maximum. For three channel values, the total size is 24 bits per pixel. For single channel gray
    ///scale, the total size is 8 bits per pixel.
    BM_G3CHTRIPLETS        = 0x00000204,
    ///40 bits per pixel. 8 bits apiece are used for each channel.
    BM_5CHANNEL            = 0x00000205,
    ///48 bits per pixel. 8 bits apiece are used for each channel.
    BM_6CHANNEL            = 0x00000206,
    ///56 bits per pixel. 8 bits apiece are used for each channel.
    BM_7CHANNEL            = 0x00000207,
    ///64 bits per pixel. 8 bits apiece are used for each channel.
    BM_8CHANNEL            = 0x00000208,
    ///32 bits per pixel. Only the 8 bit gray-scale value is used.
    BM_GRAY                = 0x00000209,
    ///32 bits per pixel. 8 bits are used for each color channel. The most significant byte is ignored.
    BM_xRGBQUADS           = 0x00000008,
    ///32 bits per pixel. 8 bits are used for each color channel. The most significant byte is ignored.
    BM_xBGRQUADS           = 0x00000010,
    ///32 bits per pixel. 8 bits are used for each color channel. The most significant byte is ignored.
    BM_xG3CHQUADS          = 0x00000304,
    ///32 bits per pixel. 8 bits are used for each color channel.
    BM_KYMCQUADS           = 0x00000305,
    ///32 bits per pixel. 8 bits are used for each color channel.
    BM_CMYKQUADS           = 0x00000020,
    ///32 bits per pixel. 10 bits are used for each color channel. The 2 most significant bits are ignored.
    BM_10b_RGB             = 0x00000009,
    ///32 bits per pixel. 10 bits are used for each color channel. The 2 most significant bits are ignored.
    BM_10b_XYZ             = 0x00000401,
    ///32 bits per pixel. 10 bits are used for each color channel. The 2 most significant bits are ignored.
    BM_10b_Yxy             = 0x00000402,
    ///32 bits per pixel. 10 bits are used for each color channel. The 2 most significant bits are ignored.
    BM_10b_Lab             = 0x00000403,
    ///32 bits per pixel. 10 bits are used for each color channel. The 2 most significant bits are ignored.
    BM_10b_G3CH            = 0x00000404,
    ///32 bits per pixel. Named color indices. Index numbering begins at 1.
    BM_NAMED_INDEX         = 0x00000405,
    ///48 bits per pixel. Each channel uses 16 bits.
    BM_16b_RGB             = 0x0000000a,
    ///48 bits per pixel. Each channel uses 16 bits.
    BM_16b_XYZ             = 0x00000501,
    ///48 bits per pixel. Each channel uses 16 bits.
    BM_16b_Yxy             = 0x00000502,
    ///48 bits per pixel. Each channel uses 16 bits.
    BM_16b_Lab             = 0x00000503,
    ///48 bits per pixel. Each channel uses 16 bits.
    BM_16b_G3CH            = 0x00000504,
    ///16 bits per pixel.
    BM_16b_GRAY            = 0x00000505,
    ///16 bits per pixel. 5 bits are used for red, 6 for green, and 5 for blue.
    BM_565RGB              = 0x00000001,
    ///96 bits per pixel, 32 bit per channel IEEE floating point.
    BM_32b_scRGB           = 0x00000601,
    ///128 bits per pixel, 32 bit per channel IEEE floating point.
    BM_32b_scARGB          = 0x00000602,
    ///48 bits per pixel, Fixed point integer ranging from -4 to +4 with a sign bit and 2 bit exponent and 13 bit
    ///mantissa.
    BM_S2DOT13FIXED_scRGB  = 0x00000603,
    ///64 bits per pixel, Fixed point integer ranging from -4 to +4 with a sign bit and 2 bit exponent and 13 bit
    ///mantissa.
    BM_S2DOT13FIXED_scARGB = 0x00000604,
    ///32 bits per pixel. 10 bits are used for each color channel. The two most significant bits are alpha.
    BM_R10G10B10A2         = 0x00000701,
    ///32 bits per pixel. 10 bits are used for each color channel. The 10 bits of each color channel are 2.8 fixed point
    ///with a -0.75 bias, giving a range of \[-0.76 .. 1.25\]. This range corresponds to \[-0.5 .. 1.5\] in a gamma = 1
    ///space. The two most significant bits are preserved for alpha. This uses an extended range (XR) sRGB color space.
    ///It has the same RGB primaries, white point, and gamma as sRGB.
    BM_R10G10B10A2_XR      = 0x00000702,
    ///64 bits per pixel. Each channel is a 16-bit float. The last WORD is alpha.
    BM_R16G16B16A16_FLOAT  = 0x00000703,
}

///Specifies the scope of a profile management operation, such as associating a profile with a device.
alias WCS_PROFILE_MANAGEMENT_SCOPE = int;
enum : int
{
    ///Indicates that the profile management operation affects all users.
    WCS_PROFILE_MANAGEMENT_SCOPE_SYSTEM_WIDE  = 0x00000000,
    ///Indicates that the profile management operation affects only the current user.
    WCS_PROFILE_MANAGEMENT_SCOPE_CURRENT_USER = 0x00000001,
}

// Callbacks

///The <b>EnumICMProfilesProcCallback</b> callback is an application-defined callback function that processes color
///profile data from <b>EnumICMProfiles</b> .
///Params:
///    Arg1 = 
///    Arg2 = 
///Returns:
///    This function must return a positive value to continue enumeration, or zero to stop enumeration. It may not
///    return a negative value.
///    
alias ICMENUMPROCA = int function(const(char)* param0, LPARAM param1);
///The <b>EnumICMProfilesProcCallback</b> callback is an application-defined callback function that processes color
///profile data from <b>EnumICMProfiles</b> .
///Params:
///    Arg1 = 
///    Arg2 = 
///Returns:
///    This function must return a positive value to continue enumeration, or zero to stop enumeration. It may not
///    return a negative value.
///    
alias ICMENUMPROCW = int function(const(wchar)* param0, LPARAM param1);
///TBD
///Params:
///    Arg1 = TBD
///    Arg2 = TBD
///    Arg3 = TBD
///Returns:
///    
///    
alias PBMCALLBACKFN = BOOL function(uint param0, uint param1, LPARAM param2);
alias LPBMCALLBACKFN = BOOL function();
///\**PCMSCALLBACKW** (or **ApplyCallbackFunction**) is a callback function that you implement that updates the WCS
///configuration data while the dialog box displayed by the
///[**SetupColorMatchingW**](/windows/win32/api/icm/nf-icm-setupcolormatchingw) function is executing. The name
///**ApplyCallbackFunction** is a placeholder. The actual name of this callback function is supplied by your application
///using ICM.
///Params:
///    Arg1 = Pointer to a [**COLORMATCHSETUPW**](/windows/win32/api/icm/ns-icm-colormatchsetupw) structure that contains WCS
///           configuration data.
///    Arg2 = Contains a value supplied by the application.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    The callback function can set the extended error information by calling
///    [SetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-setlasterror).
///    
alias PCMSCALLBACKW = BOOL function(COLORMATCHSETUPW* param0, LPARAM param1);
///\**PCMSCALLBACKA** (or **ApplyCallbackFunction**) is a callback function that you implement that updates the WCS
///configuration data while the dialog box displayed by the
///[**SetupColorMatchingW**](/windows/win32/api/icm/nf-icm-setupcolormatchingw) function is executing. The name
///**ApplyCallbackFunction** is a placeholder. The actual name of this callback function is supplied by your application
///using ICM.
///Params:
///    Arg1 = Pointer to a [**COLORMATCHSETUPW**](/windows/win32/api/icm/ns-icm-colormatchsetupw) structure that contains WCS
///           configuration data.
///    Arg2 = Contains a value supplied by the application.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    The callback function can set the extended error information by calling
///    [SetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-setlasterror).
///    
alias PCMSCALLBACKA = BOOL function(COLORMATCHSETUPA* param0, LPARAM param1);

// Structs


///The <b>CIEXYZ</b> structure contains the <i>x</i>,<i>y</i>, and <i>z</i> coordinates of a specific color in a
///specified color space.
struct CIEXYZ
{
    ///The x coordinate in fix point (2.30).
    int ciexyzX;
    ///The y coordinate in fix point (2.30).
    int ciexyzY;
    ///The z coordinate in fix point (2.30).
    int ciexyzZ;
}

///The <b>CIEXYZTRIPLE</b> structure contains the <i>x</i>,<i>y</i>, and <i>z</i> coordinates of the three colors that
///correspond to the red, green, and blue endpoints for a specified logical color space.
struct CIEXYZTRIPLE
{
    ///The xyz coordinates of red endpoint.
    CIEXYZ ciexyzRed;
    ///The xyz coordinates of green endpoint.
    CIEXYZ ciexyzGreen;
    ///The xyz coordinates of blue endpoint.
    CIEXYZ ciexyzBlue;
}

///The <b>LOGCOLORSPACE</b> structure contains information that defines a logical color space.
struct LOGCOLORSPACEA
{
    ///Color space signature. At present, this member should always be set to LCS_SIGNATURE.
    uint         lcsSignature;
    ///Version number; must be 0x400.
    uint         lcsVersion;
    ///Size of this structure, in bytes.
    uint         lcsSize;
    ///Color space type. The member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>LCS_CALIBRATED_RGB</td> <td>Color values are calibrated RGB values. The values are translated
    ///using the endpoints specified by the <b>lcsEndpoints</b> member before being passed to the device.</td> </tr>
    ///<tr> <td>LCS_sRGB</td> <td>Color values are values are sRGB values.</td> </tr> <tr>
    ///<td>LCS_WINDOWS_COLOR_SPACE</td> <td>Color values are Windows default color space color values.</td> </tr>
    ///</table> If LCS_CALIBRATED_RGB is not specified, the <b>lcsEndpoints</b> member is ignored.
    int          lcsCSType;
    ///The gamut mapping method. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Intent</th> <th>ICC Name</th> <th>Meaning</th> </tr> <tr> <td>LCS_GM_ABS_<div> </div>COLORIMETRIC</td>
    ///<td>Match</td> <td>Absolute Colorimetric</td> <td>Maintain the white point. Match the colors to their nearest
    ///color in the destination gamut.</td> </tr> <tr> <td>LCS_GM_<div> </div>BUSINESS</td> <td>Graphic</td>
    ///<td>Saturation</td> <td>Maintain saturation. Used for business charts and other situations in which undithered
    ///colors are required.</td> </tr> <tr> <td>LCS_GM_<div> </div>GRAPHICS</td> <td>Proof</td> <td>Relative
    ///Colorimetric</td> <td>Maintain colorimetric match. Used for graphic designs and named colors.</td> </tr> <tr>
    ///<td>LCS_GM_<div> </div>IMAGES</td> <td>Picture</td> <td>Perceptual</td> <td>Maintain contrast. Used for
    ///photographs and natural images.</td> </tr> </table>
    int          lcsIntent;
    ///Red, green, blue endpoints.
    CIEXYZTRIPLE lcsEndpoints;
    ///Scale of the red coordinate.
    uint         lcsGammaRed;
    ///Scale of the green coordinate.
    uint         lcsGammaGreen;
    ///Scale of the blue coordinate.
    uint         lcsGammaBlue;
    ///A null-terminated string that names a color profile file. This member is typically set to zero, but may be used
    ///to set the color space to be exactly as specified by the color profile. This is useful for devices that input
    ///color values for a specific printer, or when using an installable image color matcher. If a color profile is
    ///specified, all other members of this structure should be set to reasonable values, even if the values are not
    ///completely accurate.
    byte[260]    lcsFilename;
}

///The <b>LOGCOLORSPACE</b> structure contains information that defines a logical color space.
struct LOGCOLORSPACEW
{
    ///Color space signature. At present, this member should always be set to LCS_SIGNATURE.
    uint         lcsSignature;
    ///Version number; must be 0x400.
    uint         lcsVersion;
    ///Size of this structure, in bytes.
    uint         lcsSize;
    ///Color space type. The member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>LCS_CALIBRATED_RGB</td> <td>Color values are calibrated RGB values. The values are translated
    ///using the endpoints specified by the <b>lcsEndpoints</b> member before being passed to the device.</td> </tr>
    ///<tr> <td>LCS_sRGB</td> <td>Color values are values are sRGB values.</td> </tr> <tr>
    ///<td>LCS_WINDOWS_COLOR_SPACE</td> <td>Color values are Windows default color space color values.</td> </tr>
    ///</table> If LCS_CALIBRATED_RGB is not specified, the <b>lcsEndpoints</b> member is ignored.
    int          lcsCSType;
    ///The gamut mapping method. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Intent</th> <th>ICC Name</th> <th>Meaning</th> </tr> <tr> <td>LCS_GM_ABS_<div> </div>COLORIMETRIC</td>
    ///<td>Match</td> <td>Absolute Colorimetric</td> <td>Maintain the white point. Match the colors to their nearest
    ///color in the destination gamut.</td> </tr> <tr> <td>LCS_GM_<div> </div>BUSINESS</td> <td>Graphic</td>
    ///<td>Saturation</td> <td>Maintain saturation. Used for business charts and other situations in which undithered
    ///colors are required.</td> </tr> <tr> <td>LCS_GM_<div> </div>GRAPHICS</td> <td>Proof</td> <td>Relative
    ///Colorimetric</td> <td>Maintain colorimetric match. Used for graphic designs and named colors.</td> </tr> <tr>
    ///<td>LCS_GM_<div> </div>IMAGES</td> <td>Picture</td> <td>Perceptual</td> <td>Maintain contrast. Used for
    ///photographs and natural images.</td> </tr> </table>
    int          lcsIntent;
    ///Red, green, blue endpoints.
    CIEXYZTRIPLE lcsEndpoints;
    ///Scale of the red coordinate.
    uint         lcsGammaRed;
    ///Scale of the green coordinate.
    uint         lcsGammaGreen;
    ///Scale of the blue coordinate.
    uint         lcsGammaBlue;
    ///A null-terminated string that names a color profile file. This member is typically set to zero, but may be used
    ///to set the color space to be exactly as specified by the color profile. This is useful for devices that input
    ///color values for a specific printer, or when using an installable image color matcher. If a color profile is
    ///specified, all other members of this structure should be set to reasonable values, even if the values are not
    ///completely accurate.
    ushort[260]  lcsFilename;
}

///TBD
struct XYZColorF
{
    ///TBD
    float X;
    ///TBD
    float Y;
    float Z;
}

///TBD
struct JChColorF
{
    ///TBD
    float J;
    ///TBD
    float C;
    float h;
}

///TBD
struct JabColorF
{
    ///TBD
    float J;
    ///TBD
    float a;
    float b;
}

///Contains three vertex indices for accessing a vertex buffer.
struct GamutShellTriangle
{
    ///An array of three vertex indices that are used for accessing a vertex buffer.
    uint[3] aVertexIndex;
}

///Contains information that defines a gamut shell, which is represented by a list of indexed triangles. The vertex
///buffer contains the vertices data.
struct GamutShell
{
    ///The minimum lightness of the shell.
    float               JMin;
    ///The maximum lightness of the shell.
    float               JMax;
    ///The number of vertices in the shell.
    uint                cVertices;
    ///The number of triangles in the shell.
    uint                cTriangles;
    JabColorF*          pVertices;
    GamutShellTriangle* pTriangles;
}

///This structure contains eight primary colors in Jab coordinates.
struct PrimaryJabColors
{
    ///Red primary.
    JabColorF red;
    ///Yellow primary.
    JabColorF yellow;
    ///Green primary.
    JabColorF green;
    ///Cyan primary.
    JabColorF cyan;
    ///Blue primary.
    JabColorF blue;
    ///Magenta primary.
    JabColorF magenta;
    ///Black primary.
    JabColorF black;
    ///White primary.
    JabColorF white;
}

///This structure contains eight primary colors in XYZ coordinates.
struct PrimaryXYZColors
{
    ///Red primary.
    XYZColorF red;
    ///Yellow primary.
    XYZColorF yellow;
    ///Green primary.
    XYZColorF green;
    ///Cyan primary.
    XYZColorF cyan;
    ///Blue primary.
    XYZColorF blue;
    ///Magenta primary.
    XYZColorF magenta;
    ///Black primary.
    XYZColorF black;
    ///White primary.
    XYZColorF white;
}

///Defines a gamut boundary.
struct GamutBoundaryDescription
{
    PrimaryJabColors* pPrimaries;
    ///The number of neutral samples.
    uint              cNeutralSamples;
    JabColorF*        pNeutralSamples;
    GamutShell*       pReferenceShell;
    GamutShell*       pPlausibleShell;
    GamutShell*       pPossibleShell;
}

///Contains information for device models that have a black color channel.
struct BlackInformation
{
    BOOL  fBlackOnly;
    ///A value between 0.0 and 1.0 that indicates the relative amount of black to use in the output. A value of 0.0
    ///means that no black is used; a value of 1.0 means that the maximum amount of black is used.
    float blackWeight;
}

///The **NAMED_PROFILE_INFO** structure is used to store information about a named color profile.
struct NAMED_PROFILE_INFO
{
    ///Not currently used by the default CMM.
    uint     dwFlags;
    ///Total number of named colors in the profile.
    uint     dwCount;
    ///Total number of device coordinates for each named color.
    uint     dwCountDevCoordinates;
    ///Pointer to a string containing the prefix for each color name.
    byte[32] szPrefix;
    ///Pointer to a string containing the suffix for each color name.
    byte[32] szSuffix;
}

///Description of the GRAYCOLOR structure.
struct GRAYCOLOR
{
    ///TBD
    ushort gray;
}

///TBD
struct RGBCOLOR
{
    ///TBD
    ushort red;
    ///TBD
    ushort green;
    ///TBD
    ushort blue;
}

///Description of the CMYKCOLOR structure.
struct CMYKCOLOR
{
    ///TBD
    ushort cyan;
    ///TBD
    ushort magenta;
    ///TBD
    ushort yellow;
    ///TBD
    ushort black;
}

///TBD
struct XYZCOLOR
{
    ///TBD
    ushort X;
    ///TBD
    ushort Y;
    ///TBD
    ushort Z;
}

///TBD
struct YxyCOLOR
{
    ///TBD
    ushort Y;
    ///TBD
    ushort x;
    ///TBD
    ushort y;
}

///TBD
struct LabCOLOR
{
    ///TBD
    ushort L;
    ///TBD
    ushort a;
    ///TBD
    ushort b;
}

///TBD
struct GENERIC3CHANNEL
{
    ///TBD
    ushort ch1;
    ///TBD
    ushort ch2;
    ///TBD
    ushort ch3;
}

///TBD
struct NAMEDCOLOR
{
    ///TBD
    uint dwIndex;
}

///Description of the HiFiCOLOR structure.
struct HiFiCOLOR
{
    ///TBD
    ubyte[8] channel;
}

///Description of the COLOR union.
union COLOR
{
    ///TBD
    GRAYCOLOR       gray;
    ///TBD
    RGBCOLOR        rgb;
    ///TBD
    CMYKCOLOR       cmyk;
    ///TBD
    XYZCOLOR        XYZ;
    ///TBD
    YxyCOLOR        Yxy;
    ///TBD
    LabCOLOR        Lab;
    ///TBD
    GENERIC3CHANNEL gen3ch;
    ///TBD
    NAMEDCOLOR      named;
    ///TBD
    HiFiCOLOR       hifi;
    struct
    {
        uint  reserved1;
        void* reserved2;
    }
}

///Contains information that describes the contents of a device profile file. This header occurs at the beginning of a
///device profile file.
struct PROFILEHEADER
{
    ///The size of the profile in bytes.
    uint      phSize;
    ///The identification number of the CMM that is used in the profile. Identification numbers are registered with the
    ///ICC.
    uint      phCMMType;
    ///The version number of the profile. The version number is determined by the ICC. The current major version number
    ///is 02h. The current minor version number is 10h. The major and minor version numbers are in binary coded decimal
    ///(BCD). They must be stored in the following format. | Byte Number | Contents |
    ///|-------------|---------------------------------------------------------------------------------------------------------------------------|
    ///| 0 | Major version number in BCD. | | 1 | Minor version number in the most significant nibble of this byte. Bug
    ///fix version number in the least significant nibble. | | 2 | Reserved. Must be set to 0. | | 3 | Reserved. Must be
    ///set to 0. |
    uint      phVersion;
    ///Indicates the profile class. For a description of profile classes, see [Using Device Profiles with
    ///WCS](using-device-profiles-with-wcs.md). A profile class may have any of the following values. | Profile Class |
    ///Signature | |--------------------------------|-------------------| | Input Device Profile | CLASS\_SCANNER | |
    ///Display Device Profile | CLASS\_MONITOR | | Output Device Profile | CLASS\_PRINTER | | Device Link Profile |
    ///CLASS\_LINK | | Color Space Conversion Profile | CLASS\_COLORSPACE | | Abstract Profile | CLASS\_ABSTRACT | |
    ///Named Color Profile | CLASS\_NAMED | | Color Appearance Model Profile | CLASS\_CAMP | | Color Gamut Map Model
    ///Profile | CLASS\_GMMP |
    uint      phClass;
    ///A signature value that indicates the color space in which the profile data is defined. The member can be any of
    ///value from the [Color Space Constants](color-space-constants.md).
    uint      phDataColorSpace;
    ///A signature value that indicates the color space in which the profile connection space (PCS) is defined. The
    ///member can be any of the following values. | Profile Class | Signature | |---------------|------------| | XYZ |
    ///SPACE\_XYZ | | Lab | SPACE\_Lab | When the **phClass** member is set to CLASS\_LINK, the PCS is taken from the
    ///**phDataColorSpace** member.
    uint      phConnectionSpace;
    ///The date and time that the profile was created.
    uint[3]   phDateTime;
    ///Reserved for internal use.
    uint      phSignature;
    ///The primary platform for which the profile was created. The primary platform can be set to any of the following
    ///values. | Platform | Value | |------------------------|--------| | Apple Computer, Inc. | 'APPL' | | Microsoft
    ///Corp. | 'MSFT' | | Silicon Graphics, Inc. | 'SGI' | | Sun Microsystems, Inc. | 'SUNW' | | Taligent | 'TGNT' |
    uint      phPlatform;
    ///Bit flags containing hints that the CMM uses to interpret the profile data. The member can be set to the
    ///following values. <table> <colgroup> <col style="width: 50%" /> <col style="width: 50%" /> </colgroup> <thead>
    ///<tr class="header"> <th>Constant</th> <th>Meaning</th> </tr> </thead> <tbody> <tr class="odd"> <td> <table>
    ///<tbody> <tr class="odd"> <td>FLAG_EMBEDDEDPROFILE</td> </tr> </tbody> </table> <p> </p></td> <td> <table> <tbody>
    ///<tr class="odd"> <td>The profile is embedded in a bitmap file.</td> </tr> </tbody> </table> <p> </p></td> </tr>
    ///<tr class="even"> <td> <table> <tbody> <tr class="odd"> <td>FLAG_DEPENDENTONDATA</td> </tr> </tbody> </table> <p>
    ///</p></td> <td> <table> <tbody> <tr class="odd"> <td>The profile can't be used independently of the embedded color
    ///data. Used for profiles that are embedded in bitmap files.</td> </tr> </tbody> </table> <p> </p></td> </tr>
    ///</tbody> </table>
    uint      phProfileFlags;
    ///The identification number of the device profile manufacturer. All manufacturer identification numbers are
    ///registered with the ICC.
    uint      phManufacturer;
    ///The device manufacturer's device model number. All model identification numbers are registered with the ICC.
    uint      phModel;
    ///Attributes of profile. The profile attributes can be any of the following values. | Constant | Meaning |
    ///|----------------------|------------------------------------------------------------------------------------------|
    ///| ATTRIB\_TRANSPARENCY | Turns transparency on. If this flag is not used, the attribute is reflective by default.
    ///| | ATTRIB\_MATTE | Turns matte display on. If this flag is not used, the attribute is glossy by default. |
    uint[2]   phAttributes;
    ///The profile rendering intent. The member can be set to one of the following values: INTENT\_PERCEPTUAL
    ///INTENT\_SATURATION INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see
    ///[Rendering intents](rendering-intents.md).
    uint      phRenderingIntent;
    ///Profile illuminant.
    CIEXYZ    phIlluminant;
    ///Signature of the software that created the profile. Signatures are registered with the ICC.
    uint      phCreator;
    ///Reserved.
    ubyte[44] phReserved;
}

///Contains information that defines a color profile. See [Using device profiles with
///WCS](using-device-profiles-with-wcs.md) for more information.
struct PROFILE
{
    ///Must be set to one of the following values. | Value | Meaning |
    ///|--------------------|----------------------------------------------------------------------------------------------------------------------------|
    ///| PROFILE\_FILENAME | Indicates that the **pProfileData** member contains a null-terminated string that holds the
    ///name of a device profile file. | | PROFILE\_MEMBUFFER | Indicates that the **pProfileData** member contains a
    ///pointer to a device profile in a memory buffer. |
    uint  dwType;
    ///The contents of this member is indicated by the **dwTYPE** member. It will either be a pointer to a
    ///null-terminated string containing the file name of the device profile, or it will be a pointer to a buffer in
    ///memory containing the device profile data.
    void* pProfileData;
    ///The size in bytes of the data buffer pointed to by the **pProfileData** member.
    uint  cbDataSize;
}

///Contains information that defines the profile enumeration constraints.
struct ENUMTYPEA
{
    ///The size of this structure in bytes.
    uint         dwSize;
    ///The version number of the **ENUMTYPE** structure. Should be set to ENUM\_TYPE\_VERSION.
    uint         dwVersion;
    ///Indicates which fields in this structure are being used. Can be set to any combination of the following constant
    ///values. ET\_DEVICENAME ET\_MEDIATYPE ET\_DITHERMODE ET\_RESOLUTION ET\_CMMTYPE ET\_CLASS ET\_DATACOLORSPACE
    ///ET\_CONNECTIONSPACE ET\_SIGNATURE ET\_PLATFORM ET\_PROFILEFLAGS ET\_MANUFACTURER ET\_MODEL ET\_ATTRIBUTES
    ///ET\_RENDERINGINTENT ET\_CREATOR ET\_DEVICECLASS
    uint         dwFields;
    ///User friendly name of the device.
    const(char)* pDeviceName;
    ///Indicates which type of media is associated with the profile, such as a printer or screen.
    uint         dwMediaType;
    ///Indicates the style of dithering that will be used when an image is displayed.
    uint         dwDitheringMode;
    ///The horizontal (x) and vertical (y) resolution in pixels of the device on which the image will be displayed. The
    ///x resolution is stored in **dwResolution\[0\]**, and the y resolution is kept in **dwResolution\[1\]**.
    uint[2]      dwResolution;
    ///The identification number of the CMM that is used in the profile. Identification numbers are registered with the
    ///ICC.
    uint         dwCMMType;
    ///Indicates the profile class. For a description of profile classes, see [Using Device Profiles with
    ///WCS](using-device-profiles-with-wcs.md). A profile class may have any of the following values. | Profile Class |
    ///Signature | |--------------------------------|-------------------| | Input Device Profile | CLASS\_SCANNER | |
    ///Display Device Profile | CLASS\_MONITOR | | Output Device Profile | CLASS\_PRINTER | | Device Link Profile |
    ///CLASS\_LINK | | Color Space Conversion Profile | CLASS\_COLORSPACE | | Abstract Profile | CLASS\_ABSTRACT | |
    ///Named Color Profile | CLASS\_NAMED | | Color Appearance Model Profile | CLASS\_CAMP | | Color Gamut Map Model
    ///Profile | CLASS\_GMMP |
    uint         dwClass;
    ///A signature value that indicates the color space in which the profile data is defined. Can be any value from the
    ///[Color Space Constants](color-space-constants.md).
    uint         dwDataColorSpace;
    ///A signature value that indicates the color space in which the profile connection space (PCS) is defined. Can be
    ///any of the following values. | Profile Class | Signature | |---------------|------------| | XYZ | SPACE\_XYZ | |
    ///Lab | SPACE\_Lab | When the **dwClass** member is set to CLASS\_LINK, the PCS is taken from the
    ///**dwDataColorSpace** member.
    uint         dwConnectionSpace;
    ///Reserved for internal use.
    uint         dwSignature;
    ///The primary platform for which the profile was created. The member can be set to any of the following values. |
    ///Platform | Value | |------------------------|--------| | Apple Computer, Inc. | 'APPL' | | Microsoft Corp. |
    ///'MSFT' | | Silicon Graphics, Inc. | 'SGI' | | Sun Microsystems, Inc. | 'SUNW' | | Taligent | 'TGNT' |
    uint         dwPlatform;
    ///Bit flags containing hints that the CMM uses to interpret the profile data and can be set to one of the following
    ///values. | Constant | Meaning |
    ///|-----------------------|--------------------------------------------------------------------------------------------------------------------------|
    ///| FLAG\_EMBEDDEDPROFILE | The profile is embedded in a bitmap file. | | FLAG\_DEPENDENTONDATA | The profile can't
    ///be used independently of the embedded color data. Used for profiles that are embedded in bitmap files. |
    uint         dwProfileFlags;
    ///The identification number of the device profile manufacturer. All manufacturer identification numbers are
    ///registered with the ICC.
    uint         dwManufacturer;
    ///The device manufacturer's device model number. All model identification numbers are registered with the ICC.
    uint         dwModel;
    ///Attributes of profile that can be any of the following values. | Constant | Meaning |
    ///|----------------------|------------------------------------------------------------------------------------------|
    ///| ATTRIB\_TRANSPARENCY | Turns transparency on. If this flag is not used, the attribute is reflective by default.
    ///| | ATTRIB\_MATTE | Turns matte display on. If this flag is not used, the attribute is glossy by default. |
    uint[2]      dwAttributes;
    ///The profile rendering intent that can be set to one of the following values: INTENT\_PERCEPTUAL
    ///INTENT\_SATURATION INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see
    ///[Rendering intents](rendering-intents.md).
    uint         dwRenderingIntent;
    ///Signature of the software that created the profile. Signatures are registered with the ICC.
    uint         dwCreator;
    ///Indicates the device class. A device class may have one of the following values. | Profile Class | Signature |
    ///|------------------------|----------------| | Input Device Profile | CLASS\_SCANNER | | Display Device Profile |
    ///CLASS\_MONITOR | | Output Device Profile | CLASS\_PRINTER |
    uint         dwDeviceClass;
}

///Contains information that defines the profile enumeration constraints.
struct ENUMTYPEW
{
    ///The size of this structure in bytes.
    uint          dwSize;
    ///The version number of the **ENUMTYPE** structure. Should be set to ENUM\_TYPE\_VERSION.
    uint          dwVersion;
    ///Indicates which fields in this structure are being used. Can be set to any combination of the following constant
    ///values. ET\_DEVICENAME ET\_MEDIATYPE ET\_DITHERMODE ET\_RESOLUTION ET\_CMMTYPE ET\_CLASS ET\_DATACOLORSPACE
    ///ET\_CONNECTIONSPACE ET\_SIGNATURE ET\_PLATFORM ET\_PROFILEFLAGS ET\_MANUFACTURER ET\_MODEL ET\_ATTRIBUTES
    ///ET\_RENDERINGINTENT ET\_CREATOR ET\_DEVICECLASS
    uint          dwFields;
    ///User friendly name of the device.
    const(wchar)* pDeviceName;
    ///Indicates which type of media is associated with the profile, such as a printer or screen.
    uint          dwMediaType;
    ///Indicates the style of dithering that will be used when an image is displayed.
    uint          dwDitheringMode;
    ///The horizontal (x) and vertical (y) resolution in pixels of the device on which the image will be displayed. The
    ///x resolution is stored in **dwResolution\[0\]**, and the y resolution is kept in **dwResolution\[1\]**.
    uint[2]       dwResolution;
    ///The identification number of the CMM that is used in the profile. Identification numbers are registered with the
    ///ICC.
    uint          dwCMMType;
    ///Indicates the profile class. For a description of profile classes, see [Using Device Profiles with
    ///WCS](using-device-profiles-with-wcs.md). A profile class may have any of the following values. | Profile Class |
    ///Signature | |--------------------------------|-------------------| | Input Device Profile | CLASS\_SCANNER | |
    ///Display Device Profile | CLASS\_MONITOR | | Output Device Profile | CLASS\_PRINTER | | Device Link Profile |
    ///CLASS\_LINK | | Color Space Conversion Profile | CLASS\_COLORSPACE | | Abstract Profile | CLASS\_ABSTRACT | |
    ///Named Color Profile | CLASS\_NAMED | | Color Appearance Model Profile | CLASS\_CAMP | | Color Gamut Map Model
    ///Profile | CLASS\_GMMP |
    uint          dwClass;
    ///A signature value that indicates the color space in which the profile data is defined. Can be any value from the
    ///[Color Space Constants](color-space-constants.md).
    uint          dwDataColorSpace;
    ///A signature value that indicates the color space in which the profile connection space (PCS) is defined. Can be
    ///any of the following values. | Profile Class | Signature | |---------------|------------| | XYZ | SPACE\_XYZ | |
    ///Lab | SPACE\_Lab | When the **dwClass** member is set to CLASS\_LINK, the PCS is taken from the
    ///**dwDataColorSpace** member.
    uint          dwConnectionSpace;
    ///Reserved for internal use.
    uint          dwSignature;
    ///The primary platform for which the profile was created. The member can be set to any of the following values. |
    ///Platform | Value | |------------------------|--------| | Apple Computer, Inc. | 'APPL' | | Microsoft Corp. |
    ///'MSFT' | | Silicon Graphics, Inc. | 'SGI' | | Sun Microsystems, Inc. | 'SUNW' | | Taligent | 'TGNT' |
    uint          dwPlatform;
    ///Bit flags containing hints that the CMM uses to interpret the profile data and can be set to one of the following
    ///values. | Constant | Meaning |
    ///|-----------------------|--------------------------------------------------------------------------------------------------------------------------|
    ///| FLAG\_EMBEDDEDPROFILE | The profile is embedded in a bitmap file. | | FLAG\_DEPENDENTONDATA | The profile can't
    ///be used independently of the embedded color data. Used for profiles that are embedded in bitmap files. |
    uint          dwProfileFlags;
    ///The identification number of the device profile manufacturer. All manufacturer identification numbers are
    ///registered with the ICC.
    uint          dwManufacturer;
    ///The device manufacturer's device model number. All model identification numbers are registered with the ICC.
    uint          dwModel;
    ///Attributes of profile that can be any of the following values. | Constant | Meaning |
    ///|----------------------|------------------------------------------------------------------------------------------|
    ///| ATTRIB\_TRANSPARENCY | Turns transparency on. If this flag is not used, the attribute is reflective by default.
    ///| | ATTRIB\_MATTE | Turns matte display on. If this flag is not used, the attribute is glossy by default. |
    uint[2]       dwAttributes;
    ///The profile rendering intent that can be set to one of the following values: INTENT\_PERCEPTUAL
    ///INTENT\_SATURATION INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see
    ///[Rendering intents](rendering-intents.md).
    uint          dwRenderingIntent;
    ///Signature of the software that created the profile. Signatures are registered with the ICC.
    uint          dwCreator;
    ///Indicates the device class. A device class may have one of the following values. | Profile Class | Signature |
    ///|------------------------|----------------| | Input Device Profile | CLASS\_SCANNER | | Display Device Profile |
    ///CLASS\_MONITOR | | Output Device Profile | CLASS\_PRINTER |
    uint          dwDeviceClass;
}

///The **COLORMATCHSETUP** structure contains information that the
///[**SetupColorMatchingW**](/windows/win32/api/icm/nf-icm-setupcolormatchingw) function uses to initialize the
///**ColorManagement** dialog box. After the user closes the dialog box, **SetupColorMatching** returns information
///about the user's selection in this structure.
struct COLORMATCHSETUPW
{
    ///Size of the structure. Should be set to **sizeof** ( **COLORMATCHSETUP** ).
    uint          dwSize;
    ///Version of the **COLORMATCHSETUP** structure. This should be set to COLOR\_MATCH\_VERSION.
    uint          dwVersion;
    ///A set of bit flags used to initialize the dialog box. If set to 0 on entry, all controls assume their default
    ///states. When the dialog box returns, these flags are set to indicate the user's input. This member can be set
    ///using a combination of the following flags. | Flag | Meaning | |-|-| | CMS\_DISABLEICM | If set on entry, this
    ///flag indicates that the "Enable Color Management" check box is cleared, disabling all other controls. If set on
    ///exit, it means that the user does not wish color management performed. | | CMS\_ENABLEPROOFING | If set on entry,
    ///this flag indicates that the Proofing controls are to be enabled, and the Proofing check box is checked. If set
    ///on exit, it means that the user wishes to perform color management for a different target device than the
    ///selected printer. | | CMS\_SETRENDERINTENT | If set on entry, this flag indicates that the **dwRenderIntent**
    ///member contains the value to use to initialize the Rendering Intent control. Otherwise, the control defaults to
    ///Picture rendering. This flag is set on exit if WCS is enabled. | | CMS\_SETPROOFINTENT | Ignored unless
    ///CMS\_ENABLEPROOFING is also set. If set on entry, and CMS\_ENABLEPROOFING is also set, this flag indicates that
    ///the **dwProofingIntent** member is to be used to initialize the Target Rendering Intent control. Otherwise, the
    ///control defaults to Picture rendering. This flag is set on exit if proofing is enabled. | |
    ///CMS\_SETMONITORPROFILE | If set on entry, this flag indicates that the color management profile named in the
    ///**pMonitorProfile** member is to be the initial selection in the monitor profile control. If the specified
    ///profile is not associated with the monitor, this flag is ignored, and the default profile for the monitor is
    ///used. | | CMS\_SETPRINTERPROFILE | If set on entry, this flag indicates that the color management profile named
    ///in the **pPrinterProfile** member is to be the initial selection in the printer profile control. If the specified
    ///profile is not associated with the printer, this flag is ignored, and the default profile for the printer is
    ///used. | | CMS\_SETTARGETPROFILE | If set on entry, this flag indicates that the color profile named in the
    ///**pTargetProfile** member is to be the initial selection in the target profile control. If the specified profile
    ///is not installed, this flag is ignored, and the default profile for the printer is used. If the printer has no
    ///default profile, then the first profile in alphabetical order will be displayed. | | CMS\_USEHOOK | This flag
    ///specifies that the **lpfnHook** member contains the address of a hook procedure, and the **lParam** member
    ///contains a value to be passed to the hook procedure when the WM\_INITDIALOG message is sent. | |
    ///CMS\_MONITOROVERFLOW | This flag is set on exit if color management is to be enabled and the buffer size given in
    ///**ccMonitorProfile** is insufficient for the selected profile name. **GetLastError** returns
    ///ERROR\_INSUFFICIENT\_BUFFER in such a case. | | CMS\_PRINTERROVERFLOW | This flag is set on exit if color
    ///management is to be enabled and the buffer size given in **ccPrinterProfile** is insufficient for the selected
    ///profile name. **GetLastError** returns ERROR\_INSUFFICIENT\_BUFFER in such a case. | | CMS\_TARGETOVERFLOW | This
    ///flag is set on exit if proofing is to be enabled and the buffer size given in **ccTargetProfile** is insufficient
    ///for the selected profile name. **GetLastError** returns ERROR\_INSUFFICIENT\_BUFFER in such a case. | |
    ///CMS\_USEAPPLYCALLBACK | If set on entry, this flag indicates that the **SetupColorMatching** function should call
    ///the function [**PCMSCALLBACKW**](/windows/win32/api/icm/nc-icm-pcmscallbackw). The address of the callback
    ///function is contained in *lpfnApplyCallback*. | | CMS\_USEDESCRIPTION | If set on entry, this flag instructs the
    ///**SetupColorMatching** function to retrieve the profile description contained in the profile description tags
    ///(See ICC Profile Format Specification v3.4). It will insert them into the **Monitor Profile**, **Printer
    ///Profile**, **Emulated Device Profile** edit boxes in the **Color Management** common dialog box. |
    uint          dwFlags;
    ///The window handle to the owner of the dialog box, or **NULL** if the dialog box has no owner.
    HWND          hwndOwner;
    ///Pointer to an application-specified string which describes the source profile of the item for which color
    ///management is to be performed. If this is **NULL**, the Image Source control displays the name of the Windows
    ///default color profile.
    const(wchar)* pSourceName;
    ///Points to a string naming the monitor to be used for color management. If this is not the name of a valid
    ///monitor, the first enumerated monitor is used.
    const(wchar)* pDisplayName;
    ///Points to a string naming the printer on which the image is to be rendered. If this is not a valid printer name,
    ///the default printer is used and named in the dialog.
    const(wchar)* pPrinterName;
    ///The type of color management desired. Valid values are: INTENT\_PERCEPTUAL INTENT\_SATURATION
    ///INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see [Rendering
    ///intents](rendering-intents.md).
    uint          dwRenderIntent;
    ///The type of color management desired for the proofed image. Valid values are: INTENT\_PERCEPTUAL
    ///INTENT\_SATURATION INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see
    ///[Rendering intents](rendering-intents.md).
    uint          dwProofingIntent;
    ///Pointer to a buffer in which to place the name of the user-selected monitor profile. If the
    ///CMS\_SETMONITORPROFILE flag is used, this flag can also be used to select a profile other than the monitor
    ///default when the dialog is first displayed.
    const(wchar)* pMonitorProfile;
    ///The size of the buffer pointed to by the **pMonitorProfile** member, in characters. If the buffer is not large
    ///enough to hold the selected name, the name is truncated to this size, and ERROR\_INSUFFICIENT\_BUFFER is
    ///returned. A buffer of MAX\_PATH size always works.
    uint          ccMonitorProfile;
    ///Points to a buffer in which to place the name of the user-selected printer profile. If the CMS\_SETPRINTERPROFILE
    ///flag is used, this flag can also be used to select a profile other than the printer default when the dialog is
    ///first displayed.
    const(wchar)* pPrinterProfile;
    ///The size of the buffer pointed to by the **pPrinterProfile** member, in characters. If the buffer is not large
    ///enough to hold the selected name, the name is truncated to this size, and ERROR\_INSUFFICIENT\_BUFFER is
    ///returned. A buffer of MAX\_PATH size always works.
    uint          ccPrinterProfile;
    ///Points to a buffer in which to place the name of the user-selected target profile for proofing. If the
    ///CMS\_SETTARGETPROFILE flag is used, this flag can also be used to select a profile other than the printer default
    ///when the dialog is first displayed.
    const(wchar)* pTargetProfile;
    ///The size of the buffer pointed to by the **pTargetProfile** member, in characters. If the buffer is not large
    ///enough to hold the selected name, the name is truncated to this size, and ERROR\_INSUFFICIENT\_BUFFER is
    ///returned. A buffer of MAX\_PATH size always works.
    uint          ccTargetProfile;
    ///If the CMS\_USEHOOK flag is set, this member is the address of a dialog procedure (see
    ///[DialogProc](https://msdn.microsoft.com/windows/desktop/37c1b0b2-cf81-45d9-9a4e-9e5f7fa58dfd) ) that can filter
    ///or handle messages for the dialog. The hook procedure receives no messages issued before WM\_INITDIALOG. It is
    ///called on the WM\_INITDIALOG message after the system-provided dialog procedure has processed the message. On all
    ///other messages, the hook procedure receives the message before the system-provided procedure. If the hook
    ///procedure returns **TRUE** to these messages, the system-provided procedure is not called. The hook procedure may
    ///call the [EndDialog](https://msdn.microsoft.com/windows/desktop/925e8aa8-9d8d-4bec-a19e-ba24e78b2d10) function.
    DLGPROC       lpfnHook;
    ///If the CMS\_USEHOOK flag is set, this member is passed to the application-provided hook procedure as the *lParam*
    ///parameter when the WM\_INITDIALOG message is processed.
    LPARAM        lParam;
    ///Contains a pointer to a callback function that is invoked when the **Apply** button of the Color Management
    ///dialog box is selected. If no callback function is provided, this member should be set to **NULL**. See
    ///[**PCMSCALLBACKW**](/windows/win32/api/icm/nc-icm-pcmscallbackw).
    PCMSCALLBACKW lpfnApplyCallback;
    ///Contains a value that will be passed to the function **ApplyCallbackFunction** through its *lParam* parameter.
    ///The meaning and content of the value is specified by the application.
    LPARAM        lParamApplyCallback;
}

///The **COLORMATCHSETUP** structure contains information that the
///[**SetupColorMatchingW**](/windows/win32/api/icm/nf-icm-setupcolormatchingw) function uses to initialize the
///**ColorManagement** dialog box. After the user closes the dialog box, **SetupColorMatching** returns information
///about the user's selection in this structure.
struct COLORMATCHSETUPA
{
    ///Size of the structure. Should be set to **sizeof** ( **COLORMATCHSETUP** ).
    uint          dwSize;
    ///Version of the **COLORMATCHSETUP** structure. This should be set to COLOR\_MATCH\_VERSION.
    uint          dwVersion;
    ///A set of bit flags used to initialize the dialog box. If set to 0 on entry, all controls assume their default
    ///states. When the dialog box returns, these flags are set to indicate the user's input. This member can be set
    ///using a combination of the following flags. | Flag | Meaning | |-|-| | CMS\_DISABLEICM | If set on entry, this
    ///flag indicates that the "Enable Color Management" check box is cleared, disabling all other controls. If set on
    ///exit, it means that the user does not wish color management performed. | | CMS\_ENABLEPROOFING | If set on entry,
    ///this flag indicates that the Proofing controls are to be enabled, and the Proofing check box is checked. If set
    ///on exit, it means that the user wishes to perform color management for a different target device than the
    ///selected printer. | | CMS\_SETRENDERINTENT | If set on entry, this flag indicates that the **dwRenderIntent**
    ///member contains the value to use to initialize the Rendering Intent control. Otherwise, the control defaults to
    ///Picture rendering. This flag is set on exit if WCS is enabled. | | CMS\_SETPROOFINTENT | Ignored unless
    ///CMS\_ENABLEPROOFING is also set. If set on entry, and CMS\_ENABLEPROOFING is also set, this flag indicates that
    ///the **dwProofingIntent** member is to be used to initialize the Target Rendering Intent control. Otherwise, the
    ///control defaults to Picture rendering. This flag is set on exit if proofing is enabled. | |
    ///CMS\_SETMONITORPROFILE | If set on entry, this flag indicates that the color management profile named in the
    ///**pMonitorProfile** member is to be the initial selection in the monitor profile control. If the specified
    ///profile is not associated with the monitor, this flag is ignored, and the default profile for the monitor is
    ///used. | | CMS\_SETPRINTERPROFILE | If set on entry, this flag indicates that the color management profile named
    ///in the **pPrinterProfile** member is to be the initial selection in the printer profile control. If the specified
    ///profile is not associated with the printer, this flag is ignored, and the default profile for the printer is
    ///used. | | CMS\_SETTARGETPROFILE | If set on entry, this flag indicates that the color profile named in the
    ///**pTargetProfile** member is to be the initial selection in the target profile control. If the specified profile
    ///is not installed, this flag is ignored, and the default profile for the printer is used. If the printer has no
    ///default profile, then the first profile in alphabetical order will be displayed. | | CMS\_USEHOOK | This flag
    ///specifies that the **lpfnHook** member contains the address of a hook procedure, and the **lParam** member
    ///contains a value to be passed to the hook procedure when the WM\_INITDIALOG message is sent. | |
    ///CMS\_MONITOROVERFLOW | This flag is set on exit if color management is to be enabled and the buffer size given in
    ///**ccMonitorProfile** is insufficient for the selected profile name. **GetLastError** returns
    ///ERROR\_INSUFFICIENT\_BUFFER in such a case. | | CMS\_PRINTERROVERFLOW | This flag is set on exit if color
    ///management is to be enabled and the buffer size given in **ccPrinterProfile** is insufficient for the selected
    ///profile name. **GetLastError** returns ERROR\_INSUFFICIENT\_BUFFER in such a case. | | CMS\_TARGETOVERFLOW | This
    ///flag is set on exit if proofing is to be enabled and the buffer size given in **ccTargetProfile** is insufficient
    ///for the selected profile name. **GetLastError** returns ERROR\_INSUFFICIENT\_BUFFER in such a case. | |
    ///CMS\_USEAPPLYCALLBACK | If set on entry, this flag indicates that the **SetupColorMatching** function should call
    ///the function [**PCMSCALLBACKW**](/windows/win32/api/icm/nc-icm-pcmscallbackw). The address of the callback
    ///function is contained in *lpfnApplyCallback*. | | CMS\_USEDESCRIPTION | If set on entry, this flag instructs the
    ///**SetupColorMatching** function to retrieve the profile description contained in the profile description tags
    ///(See ICC Profile Format Specification v3.4). It will insert them into the **Monitor Profile**, **Printer
    ///Profile**, **Emulated Device Profile** edit boxes in the **Color Management** common dialog box. |
    uint          dwFlags;
    ///The window handle to the owner of the dialog box, or **NULL** if the dialog box has no owner.
    HWND          hwndOwner;
    ///Pointer to an application-specified string which describes the source profile of the item for which color
    ///management is to be performed. If this is **NULL**, the Image Source control displays the name of the Windows
    ///default color profile.
    const(char)*  pSourceName;
    ///Points to a string naming the monitor to be used for color management. If this is not the name of a valid
    ///monitor, the first enumerated monitor is used.
    const(char)*  pDisplayName;
    ///Points to a string naming the printer on which the image is to be rendered. If this is not a valid printer name,
    ///the default printer is used and named in the dialog.
    const(char)*  pPrinterName;
    ///The type of color management desired. Valid values are: INTENT\_PERCEPTUAL INTENT\_SATURATION
    ///INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see [Rendering
    ///intents](rendering-intents.md).
    uint          dwRenderIntent;
    ///The type of color management desired for the proofed image. Valid values are: INTENT\_PERCEPTUAL
    ///INTENT\_SATURATION INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see
    ///[Rendering intents](rendering-intents.md).
    uint          dwProofingIntent;
    ///Pointer to a buffer in which to place the name of the user-selected monitor profile. If the
    ///CMS\_SETMONITORPROFILE flag is used, this flag can also be used to select a profile other than the monitor
    ///default when the dialog is first displayed.
    const(char)*  pMonitorProfile;
    ///The size of the buffer pointed to by the **pMonitorProfile** member, in characters. If the buffer is not large
    ///enough to hold the selected name, the name is truncated to this size, and ERROR\_INSUFFICIENT\_BUFFER is
    ///returned. A buffer of MAX\_PATH size always works.
    uint          ccMonitorProfile;
    ///Points to a buffer in which to place the name of the user-selected printer profile. If the CMS\_SETPRINTERPROFILE
    ///flag is used, this flag can also be used to select a profile other than the printer default when the dialog is
    ///first displayed.
    const(char)*  pPrinterProfile;
    ///The size of the buffer pointed to by the **pPrinterProfile** member, in characters. If the buffer is not large
    ///enough to hold the selected name, the name is truncated to this size, and ERROR\_INSUFFICIENT\_BUFFER is
    ///returned. A buffer of MAX\_PATH size always works.
    uint          ccPrinterProfile;
    ///Points to a buffer in which to place the name of the user-selected target profile for proofing. If the
    ///CMS\_SETTARGETPROFILE flag is used, this flag can also be used to select a profile other than the printer default
    ///when the dialog is first displayed.
    const(char)*  pTargetProfile;
    ///The size of the buffer pointed to by the **pTargetProfile** member, in characters. If the buffer is not large
    ///enough to hold the selected name, the name is truncated to this size, and ERROR\_INSUFFICIENT\_BUFFER is
    ///returned. A buffer of MAX\_PATH size always works.
    uint          ccTargetProfile;
    ///If the CMS\_USEHOOK flag is set, this member is the address of a dialog procedure (see
    ///[DialogProc](https://msdn.microsoft.com/windows/desktop/37c1b0b2-cf81-45d9-9a4e-9e5f7fa58dfd) ) that can filter
    ///or handle messages for the dialog. The hook procedure receives no messages issued before WM\_INITDIALOG. It is
    ///called on the WM\_INITDIALOG message after the system-provided dialog procedure has processed the message. On all
    ///other messages, the hook procedure receives the message before the system-provided procedure. If the hook
    ///procedure returns **TRUE** to these messages, the system-provided procedure is not called. The hook procedure may
    ///call the [EndDialog](https://msdn.microsoft.com/windows/desktop/925e8aa8-9d8d-4bec-a19e-ba24e78b2d10) function.
    DLGPROC       lpfnHook;
    ///If the CMS\_USEHOOK flag is set, this member is passed to the application-provided hook procedure as the *lParam*
    ///parameter when the WM\_INITDIALOG message is processed.
    LPARAM        lParam;
    ///Contains a pointer to a callback function that is invoked when the **Apply** button of the Color Management
    ///dialog box is selected. If no callback function is provided, this member should be set to **NULL**. See
    ///[**PCMSCALLBACKW**](/windows/win32/api/icm/nc-icm-pcmscallbackw).
    PCMSCALLBACKA lpfnApplyCallback;
    ///Contains a value that will be passed to the function **ApplyCallbackFunction** through its *lParam* parameter.
    ///The meaning and content of the value is specified by the application.
    LPARAM        lParamApplyCallback;
}

struct XYYPoint
{
    float x;
    float y;
    float Y;
}

struct WhitePoint
{
    int type;
    union
    {
        XYYPoint xyY;
        float    CCT;
    }
    int CHROMATICITY = 0x00000000;
    int TEMPERATURE  = 0x00000001;
    int D65          = 0x00000002;
}

struct DisplayID
{
    LUID targetAdapterID;
    uint sourceInfoID;
}

struct DisplayStateID
{
    uint profileID;
    uint transformID;
    uint whitepointID;
}

struct DisplayTransformLut
{
    ushort[256] red;
    ushort[256] green;
    ushort[256] blue;
}

// Functions

///The <b>SetICMMode</b> function causes Image Color Management to be enabled, disabled, or queried on a given device
///context (DC).
///Params:
///    hdc = Identifies handle to the device context.
///    mode = Turns on and off image color management. This parameter can take one of the following constant values.<div>
///           </div> <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ICM_ON"></a><a
///           id="icm_on"></a><dl> <dt><b>ICM_ON</b></dt> </dl> </td> <td width="60%"> Turns on color management. Turns off
///           old-style color correction of halftones. </td> </tr> <tr> <td width="40%"><a id="ICM_OFF"></a><a
///           id="icm_off"></a><dl> <dt><b>ICM_OFF</b></dt> </dl> </td> <td width="60%"> Turns off color management. Turns on
///           old-style color correction of halftones. </td> </tr> <tr> <td width="40%"><a id="ICM_QUERY"></a><a
///           id="icm_query"></a><dl> <dt><b>ICM_QUERY</b></dt> </dl> </td> <td width="60%"> Queries the current state of color
///           management. </td> </tr> <tr> <td width="40%"><a id="ICM_DONE_OUTSIDEDC"></a><a id="icm_done_outsidedc"></a><dl>
///           <dt><b>ICM_DONE_OUTSIDEDC</b></dt> </dl> </td> <td width="60%"> Turns off color management inside DC. Under
///           Windows 2000, also turns off old-style color correction of halftones. Not supported under Windows 95. </td> </tr>
///           </table>
///Returns:
///    If this function succeeds, the return value is a nonzero value. If this function fails, the return value is zero.
///    If ICM_QUERY is specified and the function succeeds, the nonzero value returned is ICM_ON or ICM_OFF to indicate
///    the current mode.
///    
@DllImport("GDI32")
int SetICMMode(HDC hdc, int mode);

///The <b>CheckColorsInGamut</b> function determines whether a specified set of RGB triples lies in the output gamut of
///a specified device. The RGB triples are interpreted in the input logical color space.
///Params:
///    hdc = Handle to the device context whose output gamut to be checked.
///    lpRGBTriple = Pointer to an array of RGB triples to check.
///    dlpBuffer = Pointer to the buffer in which the results are to be placed. This buffer must be at least as large as
///                <i>nCount</i> bytes.
///    nCount = The number of elements in the array of triples.
///Returns:
///    If this function succeeds, the return value is a nonzero value. If this function fails, the return value is zero.
///    
@DllImport("GDI32")
BOOL CheckColorsInGamut(HDC hdc, char* lpRGBTriple, char* dlpBuffer, uint nCount);

///The <b>GetColorSpace</b> function retrieves the handle to the input color space from a specified device context.
///Params:
///    hdc = Specifies a device context that is to have its input color space handle retrieved.
///Returns:
///    If the function succeeds, the return value is the current input color space handle. If this function fails, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HCOLORSPACE GetColorSpace(HDC hdc);

///The <b>GetLogColorSpace</b> function retrieves the color space definition identified by a specified handle.
///Params:
///    hColorSpace = Specifies the handle to a color space.
///    lpBuffer = Points to a buffer to receive the LOGCOLORSPACE structure.
///    nSize = Specifies the maximum size of the buffer.
///Returns:
///    If this function succeeds, the return value is TRUE. If this function fails, the return value is <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL GetLogColorSpaceA(HCOLORSPACE hColorSpace, char* lpBuffer, uint nSize);

///The <b>GetLogColorSpace</b> function retrieves the color space definition identified by a specified handle.
///Params:
///    hColorSpace = Specifies the handle to a color space.
///    lpBuffer = Points to a buffer to receive the LOGCOLORSPACE structure.
///    nSize = Specifies the maximum size of the buffer.
///Returns:
///    If this function succeeds, the return value is TRUE. If this function fails, the return value is <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL GetLogColorSpaceW(HCOLORSPACE hColorSpace, char* lpBuffer, uint nSize);

///The <b>CreateColorSpace</b> function creates a logical color space.
///Params:
///    lplcs = Pointer to the LOGCOLORSPACE data structure.
///Returns:
///    If this function succeeds, the return value is a handle that identifies a color space. If this function fails,
///    the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HCOLORSPACE CreateColorSpaceA(LOGCOLORSPACEA* lplcs);

///The <b>CreateColorSpace</b> function creates a logical color space.
///Params:
///    lplcs = Pointer to the LOGCOLORSPACE data structure.
///Returns:
///    If this function succeeds, the return value is a handle that identifies a color space. If this function fails,
///    the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HCOLORSPACE CreateColorSpaceW(LOGCOLORSPACEW* lplcs);

///The <b>SetColorSpace</b> function defines the input color space for a given device context.
///Params:
///    hdc = Specifies the handle to a device context.
///    hcs = Identifies handle to the color space to set.
///Returns:
///    If this function succeeds, the return value is a handle to the <i>hColorSpace</i> being replaced. If this
///    function fails, the return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HCOLORSPACE SetColorSpace(HDC hdc, HCOLORSPACE hcs);

///The <b>DeleteColorSpace</b> function removes and destroys a specified color space.
///Params:
///    hcs = Specifies the handle to a color space to delete.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL DeleteColorSpace(HCOLORSPACE hcs);

///The <b>GetICMProfile</b> function retrieves the file name of the current output color profile for a specified device
///context.
///Params:
///    hdc = Specifies a device context from which to retrieve the color profile.
///    pBufSize = Pointer to a <b>DWORD</b> that contains the size of the buffer pointed to by <i>lpszFilename</i>. For the ANSI
///               version of this function, the size is in bytes. For the Unicode version, the size is in WCHARs. If this function
///               is successful, on return this parameter contains the size of the buffer actually used. However, if the buffer is
///               not large enough, this function returns <b>FALSE</b>. In this case, the <b>GetLastError()</b> function returns
///               ERROR_INSUFFICIENT_BUFFER and the <b>DWORD</b> pointed to by this parameter contains the size needed for the
///               <i>lpszFilename</i> buffer.
///    pszFilename = Points to the buffer that receives the path name of the profile.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. It also returns <b>TRUE</b> if the
///    <i>lpszFilename</i> parameter is <b>NULL</b> and the size required for the buffer is copied into <i>lpcbName.</i>
///    If this function fails, the return value is <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL GetICMProfileA(HDC hdc, uint* pBufSize, const(char)* pszFilename);

///The <b>GetICMProfile</b> function retrieves the file name of the current output color profile for a specified device
///context.
///Params:
///    hdc = Specifies a device context from which to retrieve the color profile.
///    pBufSize = Pointer to a <b>DWORD</b> that contains the size of the buffer pointed to by <i>lpszFilename</i>. For the ANSI
///               version of this function, the size is in bytes. For the Unicode version, the size is in WCHARs. If this function
///               is successful, on return this parameter contains the size of the buffer actually used. However, if the buffer is
///               not large enough, this function returns <b>FALSE</b>. In this case, the <b>GetLastError()</b> function returns
///               ERROR_INSUFFICIENT_BUFFER and the <b>DWORD</b> pointed to by this parameter contains the size needed for the
///               <i>lpszFilename</i> buffer.
///    pszFilename = Points to the buffer that receives the path name of the profile.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. It also returns <b>TRUE</b> if the
///    <i>lpszFilename</i> parameter is <b>NULL</b> and the size required for the buffer is copied into <i>lpcbName.</i>
///    If this function fails, the return value is <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL GetICMProfileW(HDC hdc, uint* pBufSize, const(wchar)* pszFilename);

///The <b>SetICMProfile</b> function sets a specified color profile as the output profile for a specified device context
///(DC).
///Params:
///    hdc = Specifies a device context in which to set the color profile.
///    lpFileName = Specifies the path name of the color profile to be set.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL SetICMProfileA(HDC hdc, const(char)* lpFileName);

///The <b>SetICMProfile</b> function sets a specified color profile as the output profile for a specified device context
///(DC).
///Params:
///    hdc = Specifies a device context in which to set the color profile.
///    lpFileName = Specifies the path name of the color profile to be set.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL SetICMProfileW(HDC hdc, const(wchar)* lpFileName);

///The <b>GetDeviceGammaRamp</b> function gets the gamma ramp on direct color display boards having drivers that support
///downloadable gamma ramps in hardware. > [!IMPORTANT] > We strongly recommend that you don't use this API. Use of this
///API is subject to major limitations. See [SetDeviceGammaRamp](nf-wingdi-setdevicegammaramp.md) for more information.
///Params:
///    hdc = Specifies the device context of the direct color display board in question.
///    lpRamp = Points to a buffer where the function can place the current gamma ramp of the color display board. The gamma ramp
///             is specified in three arrays of 256 <b>WORD</b> elements each, which contain the mapping between RGB values in
///             the frame buffer and digital-analog-converter (DAC) values. The sequence of the arrays is red, green, blue.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL GetDeviceGammaRamp(HDC hdc, char* lpRamp);

///The <b>SetDeviceGammaRamp</b> function sets the gamma ramp on direct color display boards having drivers that support
///downloadable gamma ramps in hardware. > [!IMPORTANT] > We strongly recommend that you don't use this API. Use of this
///API is subject to major limitations: > > * **SetDeviceGammaRamp** implements heuristics to check whether a provided
///ramp will result in an unreadable screen. If a ramp violates those heuristics, then the function fails silently (that
///is, it returns **TRUE**, but it doesn't set your ramp). For that reason, you can't expect to use this function to set
///*just any arbitrary* gamma ramp. In particular, the heuristics prevent ramps that would result in nearly all pixels
///approaching a single value (such as fullscreen black/white) as this may prevent a user from recovering the screen. >
///> * Because of the function's global nature, any other application on the system could, at any time, overwrite any
///ramp that you've set. In some cases the operating system itself may reserve the use of this function, causing any
///existing ramp to be overwritten. The gamma ramp is also reset on most display events (connecting/disconnecting a
///monitor, resolution changes, etc.). So you can't be certain that any ramp you set is in effect. > > * This API has
///undefined behavior in HDR modes. > > * This API has undefined interaction with both built-in and third-party color
///calibration solutions. > > For color calibration, we recommend that you create an International Color Consortium
///(ICC) profile, and let the OS apply the profile. For advanced original equipment manufacturer (OEM) scenarios,
///there's a device driver model that you can use to customize color calibration more directly. See the [Windows Color
///System](/previous-versions/windows/desktop/wcs/windows-color-system) for information on managing color profiles. > >
///For blue light filtering, Windows now provides built-in support called [**Night
///Light**](https://support.microsoft.com/help/4027563/windows-10-set-your-display-for-night-time). We recommend
///directing users to this feature. > > For color adaptation (for example, adjusting color calibration based on ambient
///light sensors), Windows now provides built-in support, which we recommend for use by OEMs. > > For custom filter
///effects, there are a variety of built-in accessibility [color
///filters](https://support.microsoft.com/help/4344736/windows-10-use-color-filters) to help with a range of cases.
///Params:
///    hdc = Specifies the device context of the direct color display board in question.
///    lpRamp = Pointer to a buffer containing the gamma ramp to be set. The gamma ramp is specified in three arrays of 256
///             <b>WORD</b> elements each, which contain the mapping between RGB values in the frame buffer and
///             digital-analog-converter (<i>DAC</i> ) values. The sequence of the arrays is red, green, blue. The RGB values
///             must be stored in the most significant bits of each WORD to increase DAC independence.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL SetDeviceGammaRamp(HDC hdc, char* lpRamp);

///The <b>ColorMatchToTarget</b> function enables you to preview colors as they would appear on the target device.
///Params:
///    hdc = Specifies the device context for previewing, generally the screen.
///    hdcTarget = Specifies the target device context, generally a printer.
///    action = A constant that can have one of the following values.<div> </div> <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="CS_ENABLE"></a><a id="cs_enable"></a><dl> <dt><b>CS_ENABLE</b></dt> </dl> </td>
///             <td width="60%"> Map the colors to the target device's color gamut. This enables color proofing. All subsequent
///             draw commands to the DC will render colors as they would appear on the target device. </td> </tr> <tr> <td
///             width="40%"><a id="CS_DISABLE"></a><a id="cs_disable"></a><dl> <dt><b>CS_DISABLE</b></dt> </dl> </td> <td
///             width="60%"> Disable color proofing. </td> </tr> <tr> <td width="40%"><a id="CS_DELETE_TRANSFORM"></a><a
///             id="cs_delete_transform"></a><dl> <dt><b>CS_DELETE_TRANSFORM</b></dt> </dl> </td> <td width="60%"> If color
///             management is enabled for the target profile, disable it and delete the concatenated transform. </td> </tr>
///             </table>
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL ColorMatchToTarget(HDC hdc, HDC hdcTarget, uint action);

///The <b>EnumICMProfiles</b> function enumerates the different output color profiles that the system supports for a
///given device context.
///Params:
///    hdc = Specifies the device context.
///    proc = Specifies the procedure instance address of a callback function defined by the application. (See
///           EnumICMProfilesProcCallback.)
///    param = Data supplied by the application that is passed to the callback function along with the color profile
///            information.
///Returns:
///    This function returns zero if the application interrupted the enumeration. The return value is -1 if there are no
///    color profiles to enumerate. Otherwise, the return value is the last value returned by the callback function.
///    
@DllImport("GDI32")
int EnumICMProfilesA(HDC hdc, ICMENUMPROCA proc, LPARAM param2);

///The <b>EnumICMProfiles</b> function enumerates the different output color profiles that the system supports for a
///given device context.
///Params:
///    hdc = Specifies the device context.
///    proc = Specifies the procedure instance address of a callback function defined by the application. (See
///           EnumICMProfilesProcCallback.)
///    param = Data supplied by the application that is passed to the callback function along with the color profile
///            information.
///Returns:
///    This function returns zero if the application interrupted the enumeration. The return value is -1 if there are no
///    color profiles to enumerate. Otherwise, the return value is the last value returned by the callback function.
///    
@DllImport("GDI32")
int EnumICMProfilesW(HDC hdc, ICMENUMPROCW proc, LPARAM param2);

///<i>(Obsolete; retained for backward compatibility)</i> The <b>UpdateICMRegKey</b> function manages color profiles and
///Color Management Modules in the system.
///Params:
///    reserved = Reserved, must be set to zero.
///    lpszCMID = Points to a string that specifies the ICC profile identifier for the color management DLL to use with the
///               profile.
///    lpszFileName = Points to a fully qualified ICC color profile file name or to a <b>DEVMODE</b> structure.
///    command = Specifies a function to execute. It can have one of the following values.<div> </div> <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ICM_ADDPROFILE"></a><a id="icm_addprofile"></a><dl>
///              <dt><b>ICM_ADDPROFILE</b></dt> </dl> </td> <td width="60%"> Installs the ICC profile in the system. </td> </tr>
///              <tr> <td width="40%"><a id="ICM_DELETEPROFILE"></a><a id="icm_deleteprofile"></a><dl>
///              <dt><b>ICM_DELETEPROFILE</b></dt> </dl> </td> <td width="60%"> Uninstalls the ICC profile from the system, but
///              does not delete the file. </td> </tr> <tr> <td width="40%"><a id="ICM_QUERYPROFILE"></a><a
///              id="icm_queryprofile"></a><dl> <dt><b>ICM_QUERYPROFILE</b></dt> </dl> </td> <td width="60%"> Determines whether
///              the profile is already installed in the system. </td> </tr> <tr> <td width="40%"><a
///              id="ICM_SETDEFAULTPROFILE"></a><a id="icm_setdefaultprofile"></a><dl> <dt><b>ICM_SETDEFAULTPROFILE</b></dt> </dl>
///              </td> <td width="60%"> Makes the profile first among equals. </td> </tr> <tr> <td width="40%"><a
///              id="ICM_REGISTERICMATCHER"></a><a id="icm_registericmatcher"></a><dl> <dt><b>ICM_REGISTERICMATCHER</b></dt> </dl>
///              </td> <td width="60%"> Registers a CMM in the system. The <i>pszFileName</i> parameter points to a fully
///              qualified path for the CMM DLL. The <i>lpszCMID</i> parameter points to a <b>DWORD</b> identifying the CMM. </td>
///              </tr> <tr> <td width="40%"><a id="ICM_UNREGISTERICMATCHER"></a><a id="icm_unregistericmatcher"></a><dl>
///              <dt><b>ICM_UNREGISTERICMATCHER</b></dt> </dl> </td> <td width="60%"> Unregisters the CMM from the system. The
///              <i>lpszCMID</i> parameter points to a <b>DWORD</b> identifying the CMM. </td> </tr> <tr> <td width="40%"><a
///              id="ICM_QUERYMATCH"></a><a id="icm_querymatch"></a><dl> <dt><b>ICM_QUERYMATCH</b></dt> </dl> </td> <td
///              width="60%"> Determines whether a profile exists based on the <b>DEVMODE</b> structure pointed to by the
///              <i>pszFileName</i> parameter. </td> </tr> </table>
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL UpdateICMRegKeyA(uint reserved, const(char)* lpszCMID, const(char)* lpszFileName, uint command);

///<i>(Obsolete; retained for backward compatibility)</i> The <b>UpdateICMRegKey</b> function manages color profiles and
///Color Management Modules in the system.
///Params:
///    reserved = Reserved, must be set to zero.
///    lpszCMID = Points to a string that specifies the ICC profile identifier for the color management DLL to use with the
///               profile.
///    lpszFileName = Points to a fully qualified ICC color profile file name or to a <b>DEVMODE</b> structure.
///    command = Specifies a function to execute. It can have one of the following values.<div> </div> <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ICM_ADDPROFILE"></a><a id="icm_addprofile"></a><dl>
///              <dt><b>ICM_ADDPROFILE</b></dt> </dl> </td> <td width="60%"> Installs the ICC profile in the system. </td> </tr>
///              <tr> <td width="40%"><a id="ICM_DELETEPROFILE"></a><a id="icm_deleteprofile"></a><dl>
///              <dt><b>ICM_DELETEPROFILE</b></dt> </dl> </td> <td width="60%"> Uninstalls the ICC profile from the system, but
///              does not delete the file. </td> </tr> <tr> <td width="40%"><a id="ICM_QUERYPROFILE"></a><a
///              id="icm_queryprofile"></a><dl> <dt><b>ICM_QUERYPROFILE</b></dt> </dl> </td> <td width="60%"> Determines whether
///              the profile is already installed in the system. </td> </tr> <tr> <td width="40%"><a
///              id="ICM_SETDEFAULTPROFILE"></a><a id="icm_setdefaultprofile"></a><dl> <dt><b>ICM_SETDEFAULTPROFILE</b></dt> </dl>
///              </td> <td width="60%"> Makes the profile first among equals. </td> </tr> <tr> <td width="40%"><a
///              id="ICM_REGISTERICMATCHER"></a><a id="icm_registericmatcher"></a><dl> <dt><b>ICM_REGISTERICMATCHER</b></dt> </dl>
///              </td> <td width="60%"> Registers a CMM in the system. The <i>pszFileName</i> parameter points to a fully
///              qualified path for the CMM DLL. The <i>lpszCMID</i> parameter points to a <b>DWORD</b> identifying the CMM. </td>
///              </tr> <tr> <td width="40%"><a id="ICM_UNREGISTERICMATCHER"></a><a id="icm_unregistericmatcher"></a><dl>
///              <dt><b>ICM_UNREGISTERICMATCHER</b></dt> </dl> </td> <td width="60%"> Unregisters the CMM from the system. The
///              <i>lpszCMID</i> parameter points to a <b>DWORD</b> identifying the CMM. </td> </tr> <tr> <td width="40%"><a
///              id="ICM_QUERYMATCH"></a><a id="icm_querymatch"></a><dl> <dt><b>ICM_QUERYMATCH</b></dt> </dl> </td> <td
///              width="60%"> Determines whether a profile exists based on the <b>DEVMODE</b> structure pointed to by the
///              <i>pszFileName</i> parameter. </td> </tr> </table>
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL UpdateICMRegKeyW(uint reserved, const(wchar)* lpszCMID, const(wchar)* lpszFileName, uint command);

///The <b>ColorCorrectPalette</b> function corrects the entries of a palette using the WCS 1.0 parameters in the
///specified device context.
///Params:
///    hdc = Specifies a device context whose WCS parameters to use.
///    hPal = Specifies the handle to the palette to be color corrected.
///    deFirst = Specifies the first entry in the palette to be color corrected.
///    num = Specifies the number of entries to color correct.
///Returns:
///    If this function succeeds, the return value is <b>TRUE</b>. If this function fails, the return value is
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL ColorCorrectPalette(HDC hdc, HPALETTE hPal, uint deFirst, uint num);

///Creates a handle to a specified color profile. The handle can then be used in other profile management functions.
///Params:
///    pProfile = Pointer to a color profile structure specifying the profile. The *pProfile* pointer can be freed as soon as the
///               handle is created.
///    dwDesiredAccess = Specifies how to access the given profile. This parameter must take one the following constant values. | Value |
///                      Meaning | |-|-| | <span id="PROFILE_READ"></span><span id="profile_read"></span><dl> <dt>**PROFILE\_READ**</dt>
///                      </dl> | Opens the profile for read access.<br/> | | <span id="PROFILE_READWRITE"></span><span
///                      id="profile_readwrite"></span><dl> <dt>**PROFILE\_READWRITE**</dt> </dl> | Opens the profile for both read and
///                      write access. Has no effect for WCS XML profiles.<br/> |
///    dwShareMode = Specifies how the profile should be shared, if the profile is contained in a file. A value of zero prevents the
///                  profile from being shared at all. The parameter can contain one or both of the following constants (combined by
///                  addition or logical OR). | Value | Meaning | |-|-| | <span id="FILE_SHARE_READ"></span><span
///                  id="file_share_read"></span><dl> <dt>**FILE\_SHARE\_READ**</dt> </dl> | Other open operations can be performed on
///                  the profile for read access.<br/> | | <span id="FILE_SHARE_WRITE"></span><span id="file_share_write"></span><dl>
///                  <dt>**FILE\_SHARE\_WRITE**</dt> </dl> | Other open operations can be performed on the profile for write access.
///                  Has no effect for WCS XML profiles.<br/> |
///    dwCreationMode = Specifies which actions to take on the profile while opening it, if it is contained in a file. This parameter
///                     must take one of the following constant values. | Value | Meaning | |-|-| | <span id="CREATE_NEW"></span><span
///                     id="create_new"></span><dl> <dt>**CREATE\_NEW**</dt> </dl> | Creates a new profile. Fails if the profile already
///                     exists.<br/> | | <span id="CREATE_ALWAYS"></span><span id="create_always"></span><dl> <dt>**CREATE\_ALWAYS**</dt>
///                     </dl> | Creates a new profile. Overwrites the profile if it exists.<br/> | | <span
///                     id="OPEN_EXISTING"></span><span id="open_existing"></span><dl> <dt>**OPEN\_EXISTING**</dt> </dl> | Opens the
///                     profile. Fails if it does not exist<br/> | | <span id="OPEN_ALWAYS"></span><span id="open_always"></span><dl>
///                     <dt>**OPEN\_ALWAYS**</dt> </dl> | Opens the profile if it exists. For ICC profiles, if the profile does not
///                     exist, creates the profile. For WCS XML profiles, if the profile does not exist, returns an error.<br/> | | <span
///                     id="TRUNCATE_EXISTING"></span><span id="truncate_existing"></span><dl> <dt>**TRUNCATE\_EXISTING**</dt> </dl> |
///                     Opens the profile, and truncates it to zero bytes, returning a blank ICC profile. Fails if the profile doesn't
///                     exist.<br/> |
///Returns:
///    If this function succeeds, the return value is the handle of the color profile that is opened. For ICC and WCS
///    profiles, a CAMP and GMMP are provided by the function based on the current default CAMP and GMMP in the
///    registry. When OpenColorProfile encounters an ICC profile with an embedded WCS profile, and if the dwType member
///    within the Profile structure does not take the value DONT\_USE\_EMBEDDED\_WCS\_PROFILES, it should extract and
///    use the WCS profile(s) contained in this WcsProfilesTag. The HPROFILE returned would be a WCS HPROFILE. If this
///    function fails, the return value is **NULL**. For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
ptrdiff_t OpenColorProfileA(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

///Creates a handle to a specified color profile. The handle can then be used in other profile management functions.
///Params:
///    pProfile = Pointer to a color profile structure specifying the profile. The *pProfile* pointer can be freed as soon as the
///               handle is created.
///    dwDesiredAccess = Specifies how to access the given profile. This parameter must take one the following constant values. | Value |
///                      Meaning | |-|-| | <span id="PROFILE_READ"></span><span id="profile_read"></span><dl> <dt>**PROFILE\_READ**</dt>
///                      </dl> | Opens the profile for read access.<br/> | | <span id="PROFILE_READWRITE"></span><span
///                      id="profile_readwrite"></span><dl> <dt>**PROFILE\_READWRITE**</dt> </dl> | Opens the profile for both read and
///                      write access. Has no effect for WCS XML profiles.<br/> |
///    dwShareMode = Specifies how the profile should be shared, if the profile is contained in a file. A value of zero prevents the
///                  profile from being shared at all. The parameter can contain one or both of the following constants (combined by
///                  addition or logical OR). | Value | Meaning | |-|-| | <span id="FILE_SHARE_READ"></span><span
///                  id="file_share_read"></span><dl> <dt>**FILE\_SHARE\_READ**</dt> </dl> | Other open operations can be performed on
///                  the profile for read access.<br/> | | <span id="FILE_SHARE_WRITE"></span><span id="file_share_write"></span><dl>
///                  <dt>**FILE\_SHARE\_WRITE**</dt> </dl> | Other open operations can be performed on the profile for write access.
///                  Has no effect for WCS XML profiles.<br/> |
///    dwCreationMode = Specifies which actions to take on the profile while opening it, if it is contained in a file. This parameter
///                     must take one of the following constant values. | Value | Meaning | |-|-| | <span id="CREATE_NEW"></span><span
///                     id="create_new"></span><dl> <dt>**CREATE\_NEW**</dt> </dl> | Creates a new profile. Fails if the profile already
///                     exists.<br/> | | <span id="CREATE_ALWAYS"></span><span id="create_always"></span><dl> <dt>**CREATE\_ALWAYS**</dt>
///                     </dl> | Creates a new profile. Overwrites the profile if it exists.<br/> | | <span
///                     id="OPEN_EXISTING"></span><span id="open_existing"></span><dl> <dt>**OPEN\_EXISTING**</dt> </dl> | Opens the
///                     profile. Fails if it does not exist<br/> | | <span id="OPEN_ALWAYS"></span><span id="open_always"></span><dl>
///                     <dt>**OPEN\_ALWAYS**</dt> </dl> | Opens the profile if it exists. For ICC profiles, if the profile does not
///                     exist, creates the profile. For WCS XML profiles, if the profile does not exist, returns an error.<br/> | | <span
///                     id="TRUNCATE_EXISTING"></span><span id="truncate_existing"></span><dl> <dt>**TRUNCATE\_EXISTING**</dt> </dl> |
///                     Opens the profile, and truncates it to zero bytes, returning a blank ICC profile. Fails if the profile doesn't
///                     exist.<br/> |
///Returns:
///    If this function succeeds, the return value is the handle of the color profile that is opened. For ICC and WCS
///    profiles, a CAMP and GMMP are provided by the function based on the current default CAMP and GMMP in the
///    registry. When OpenColorProfile encounters an ICC profile with an embedded WCS profile, and if the dwType member
///    within the Profile structure does not take the value DONT\_USE\_EMBEDDED\_WCS\_PROFILES, it should extract and
///    use the WCS profile(s) contained in this WcsProfilesTag. The HPROFILE returned would be a WCS HPROFILE. If this
///    function fails, the return value is **NULL**. For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
ptrdiff_t OpenColorProfileW(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

///Closes an open profile handle.
///Params:
///    hProfile = Handle to the profile to be closed. The function determines whether the HPROFILE contains ICC or WCS profile
///               information.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL CloseColorProfile(ptrdiff_t hProfile);

///Given a handle to an open color profile, the **GetColorProfileFromHandle** function copies the contents of the
///profile into a buffer supplied by the application. If the handle is a Windows Color System (WCS) handle, then the DMP
///is returned and the CAMP and GMMP associated with the HPROFILE are ignored.
///Params:
///    hProfile = Handle to an open color profile. The function determines whether the HPROFILE contains ICC or WCS profile
///               information.
///    pProfile = Pointer to buffer to receive raw ICC or DMP profile data. Can be **NULL**. If it is, the size required for the
///               buffer will be stored in the memory location pointed to by *pcbSize*. The buffer can be allocated to the
///               appropriate size, and this function called again with *pBuffer* containing the address of the buffer.
///    pcbProfile = Pointer to a **DWORD** that holds the size of buffer pointed at by *pBuffer*. On return it is filled with size of
///                 buffer that was actually used if the function succeeds. If this function is called with *pBuffer* set to
///                 **NULL**, this parameter will contain the size of the buffer required.
///Returns:
///    If this function succeeds, the return value is **TRUE**. It returns **FALSE** if the *pBuffer* parameter is
///    **NULL** and the size required for the buffer is copied into *pcbSize.* If this function fails, the return value
///    is **FALSE**. For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetColorProfileFromHandle(ptrdiff_t hProfile, char* pProfile, uint* pcbProfile);

///Allows you to determine whether the specified profile is a valid International Color Consortium (ICC) profile, or a
///valid Windows Color System (WCS) profile handle that can be used for color management. WCS profile validation doesn't
///invoke the underlying device models, but instead simply validates against the XML schema and the schema element range
///limits.
///Params:
///    hProfile = Specifies a handle to the profile to be validated. The function determines whether the HPROFILE contains ICC or
///               WCS profile information.
///    pbValid = Pointer to a variable that is set to **TRUE** on return if the operation succeeds and the profile is a valid ICC
///              or WCS profile. If the operation fails or the profile is not valid the variable is **FALSE**.
///Returns:
///    If this function succeeds and the profile is valid, the return value is **TRUE**. If this function fails (or
///    succeeds and the profile is not valid), the return value is **FALSE**. For extended error information, call
///    **GetLastError**.
///    
@DllImport("mscms")
BOOL IsColorProfileValid(ptrdiff_t hProfile, int* pbValid);

///Converts a logical [color space](c.md) to a [device profile](d.md).
///Params:
///    pLogColorSpace = A pointer to a logical color space structure. See
///                     [**LOGCOLORSPACEA**](/windows/desktop/api/Wingdi/ns-wingdi-taglogcolorspacea) for details. The **lcsFilename**
///                     \[0\] member of the structure must be set to the **null** character ('\\0') or this function call will fail with
///                     the return value of INVALID\_PARAMETER.
///    pProfile = A pointer to a pointer to a buffer where the device profile will be created. This function allocates the buffer
///               and fills it with profile information if it is successful. If not, the pointer is set to **NULL**. The caller is
///               responsible for freeing this buffer when it is no longer needed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    If the **lcsFilename** \[0\] member if the
///    [**LOGCOLORSPACEA**](/windows/desktop/api/Wingdi/ns-wingdi-taglogcolorspacea) structure pointed to by
///    *pLogColorSpace* is not '\\0', this function returns INVALID\_PARAMETER.
///    
@DllImport("mscms")
BOOL CreateProfileFromLogColorSpaceA(LOGCOLORSPACEA* pLogColorSpace, ubyte** pProfile);

///Converts a logical [color space](c.md) to a [device profile](d.md).
///Params:
///    pLogColorSpace = A pointer to a logical color space structure. See
///                     [**LOGCOLORSPACEA**](/windows/desktop/api/Wingdi/ns-wingdi-taglogcolorspacea) for details. The **lcsFilename**
///                     \[0\] member of the structure must be set to the **null** character ('\\0') or this function call will fail with
///                     the return value of INVALID\_PARAMETER.
///    pProfile = A pointer to a pointer to a buffer where the device profile will be created. This function allocates the buffer
///               and fills it with profile information if it is successful. If not, the pointer is set to **NULL**. The caller is
///               responsible for freeing this buffer when it is no longer needed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    If the **lcsFilename** \[0\] member if the
///    [**LOGCOLORSPACEA**](/windows/desktop/api/Wingdi/ns-wingdi-taglogcolorspacea) structure pointed to by
///    *pLogColorSpace* is not '\\0', this function returns INVALID\_PARAMETER.
///    
@DllImport("mscms")
BOOL CreateProfileFromLogColorSpaceW(LOGCOLORSPACEW* pLogColorSpace, ubyte** pProfile);

///Retrieves the number of tagged elements in a given color profile.
///Params:
///    hProfile = Specifies a handle to the profile in question.
///    pnElementCount = Pointer to a variable in which to place the number of tagged elements in the profile.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetCountColorProfileElements(ptrdiff_t hProfile, uint* pnElementCount);

///Retrieves or derives ICC header structure from either ICC color profile or WCS XML profile. Drivers and applications
///should assume returning **TRUE** only indicates that a properly structured header is returned. Each tag will still
///need to be validated independently using either legacy ICM2 APIs or XML schema APIs.
///Params:
///    hProfile = Specifies a handle to the color profile in question.
///    pHeader = Points to a variable in which the ICC header structure is to be placed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    This function will fail is an invalid ICC or WCS XML profile is referenced in the hProfile parameter. For
///    extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetColorProfileHeader(ptrdiff_t hProfile, PROFILEHEADER* pHeader);

///Retrieves the tag name specified by *dwIndex* in the tag table of a given International Color Consortium (ICC) color
///profile, where *dwIndex* is a one-based index into that table.
///Params:
///    hProfile = Specifies a handle to the ICC color profile in question.
///    dwIndex = Specifies the one-based index of the tag to retrieve.
///    pTag = Pointer to a variable in which the tag name is to be placed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetColorProfileElementTag(ptrdiff_t hProfile, uint dwIndex, uint* pTag);

///Reports whether a specified International Color Consortium (ICC) tag is present in the specified color profile.
///Params:
///    hProfile = Specifies a handle to the ICC profile in question.
///    tag = Specifies the ICC tag to check.
///    pbPresent = Pointer to a variable that is set to **TRUE** on return if the specified ICC tag is present, or **FALSE** if not.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL IsColorProfileTagPresent(ptrdiff_t hProfile, uint tag, int* pbPresent);

///Copies data from a specified tagged profile element of a specified color profile into a buffer.
///Params:
///    hProfile = Specifies a handle to the International Color Consortium (ICC) color profile in question.
///    tag = Identifies the tagged element from which to copy.
///    dwOffset = Specifies the offset from the first byte of the tagged element data at which to begin copying.
///    pcbElement = Pointer to a variable specifying the number of bytes to copy. On return, the variable contains the number of
///                 bytes actually copied.
///    pElement = Pointer to a buffer into which the tagged element data is to be copied. The buffer must contain at least as many
///               bytes as are specified by the variable pointed to by *pcbSize*. If the *pBuffer* pointer is set to **NULL**, the
///               size of the entire tagged element data in bytes is returned in the memory location pointed to by *pcbSize,* and
///               *dwOffset* is ignored. In this case, the function will return **FALSE**.
///    pbReference = Points to a Boolean value that is set to **TRUE** if more than one tag in the color profile refers to the same
///                  data as the specified tag refers to, or **FALSE** if not.
///Returns:
///    If this function succeeds, the return value is nonzero. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetColorProfileElement(ptrdiff_t hProfile, uint tag, uint dwOffset, uint* pcbElement, char* pElement, 
                            int* pbReference);

///Sets the header data in a specified ICC color profile.
///Params:
///    hProfile = Specifies a handle to the ICC color profile in question.
///    pHeader = Pointer to the profile header data to write to the specified profile.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL SetColorProfileHeader(ptrdiff_t hProfile, char* pHeader);

///Sets the size of a tagged element in an ICC color profile.
///Params:
///    hProfile = Specifies a handle to the ICC color profile in question.
///    tagType = Identifies the tagged element.
///    pcbElement = Specifies the size to set the tagged element to. If *cbSize* is zero, this function deletes the specified tagged
///                 element. If the tag is a reference, only the tag table entry is deleted, not the data.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL SetColorProfileElementSize(ptrdiff_t hProfile, uint tagType, uint pcbElement);

///Sets the element data for a tagged profile element in an ICC color profile.
///Params:
///    hProfile = Specifies a handle to the ICC profile in question.
///    tag = Identifies the tagged element.
///    dwOffset = Specifies the offset from the first byte of the tagged element data at which to start writing.
///    pcbElement = Pointer to a variable containing the number of bytes of data to write. On return, it contains the number of bytes
///                 actually written.
///    pElement = Pointer to a buffer containing the data to write to the tagged element in the color profile.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL SetColorProfileElement(ptrdiff_t hProfile, uint tag, uint dwOffset, uint* pcbElement, char* pElement);

///Creates in a specified ICC color profile a new tag that references the same data as an existing tag.
///Params:
///    hProfile = Specifies a handle to the ICC color profile in question.
///    newTag = Identifies the new tag to create.
///    refTag = Identifies the existing tag whose data is to be referenced by the new tag.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL SetColorProfileElementReference(ptrdiff_t hProfile, uint newTag, uint refTag);

///Retrieves the PostScript Level 2 [color space](c.md) array from an ICC color profile.
///Params:
///    hProfile = Specifies a handle to the ICC profile from which to retrieve the PostScript Level 2 color space array.
///    dwIntent = Specifies the desired rendering intent for the color space array. This field may take one of the following
///               values: INTENT\_PERCEPTUAL INTENT\_SATURATION INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For
///               more information, see [Rendering Intents](rendering-intents.md).
///    dwCSAType = Specifies the type of color space array. See [Color Space Type Identifiers](color-space-type-identifiers.md).
///    pPS2ColorSpaceArray = Pointer to a buffer in which the color space array is to be placed. If the *pBuffer* pointer is set to **NULL**,
///                          the function returns the required size of the buffer in the memory location pointed to by *pcbSize*.
///    pcbPS2ColorSpaceArray = Pointer to a variable containing the size of the buffer in bytes. On return, it contains the number of bytes
///                            copied into the buffer.
///    pbBinary = Pointer to a Boolean variable. If set to **TRUE**, the data copied could be binary. If set to **FALSE**, data
///               should be encoded as ASCII85. On return, the memory location pointed to by *pbBinary* indicates whether the data
///               returned actually is binary (**TRUE**) or ASCII85 (**FALSE**).
///Returns:
///    If this function succeeds, the return value is **TRUE**. It also returns **TRUE** if the *pBuffer* parameter is
///    **NULL** and the size required for the buffer is copied into *pcbSize.* If this function fails, the return value
///    is **FALSE**. For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetPS2ColorSpaceArray(ptrdiff_t hProfile, uint dwIntent, uint dwCSAType, char* pPS2ColorSpaceArray, 
                           uint* pcbPS2ColorSpaceArray, int* pbBinary);

///Retrieves the PostScript Level 2 color [rendering intent](r.md) from an ICC color profile.
///Params:
///    hProfile = Specifies a handle to the ICC color profile in question.
///    dwIntent = Specifies the desired rendering intent to retrieve. Valid values are: INTENT\_PERCEPTUAL INTENT\_SATURATION
///               INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see [Rendering
///               Intents](rendering-intents.md).
///    pBuffer = Points to a buffer in which the color rendering intent is to be placed. If the *pBuffer* pointer is set to
///              **NULL**, the buffer size required is returned in *\*pcbSize*.
///    pcbPS2ColorRenderingIntent = Points to a variable containing the buffer size in bytes. On return, this variable contains the number of bytes
///                                 actually copied.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function succeeds, the return value is **TRUE**.
///    It also returns **TRUE** if the *pBuffer* parameter is **NULL** and the size required for the buffer is copied
///    into *pcbSize.* If this function fails, the return value is **FALSE**. For extended error information, call
///    **GetLastError**.
///    
@DllImport("mscms")
BOOL GetPS2ColorRenderingIntent(ptrdiff_t hProfile, uint dwIntent, char* pBuffer, uint* pcbPS2ColorRenderingIntent);

///Retrieves the PostScript Level 2 color rendering dictionary from the specified ICC color profile.
///Params:
///    hProfile = Specifies a handle to the ICC color profile in question.
///    dwIntent = Specifies the desired rendering intent for the color rendering dictionary. Valid values are: * INTENT\_PERCEPTUAL
///               * INTENT\_SATURATION * INTENT\_RELATIVE\_COLORIMETRIC * INTENT\_ABSOLUTE\_COLORIMETRIC For more information, see
///               [Rendering intents](rendering-intents.md).
///    pPS2ColorRenderingDictionary = Pointer to a buffer in which the color rendering dictionary is to be placed. If the *pBuffer* pointer is set to
///                                   **NULL**, the required buffer size is returned in *\*pcbSize*.
///    pcbPS2ColorRenderingDictionary = Pointer to a variable containing the size of the buffer in bytes. On return, the variable contains the number of
///                                     bytes actually copied.
///    pbBinary = Pointer to a Boolean variable. If **TRUE**, the color rendering dictionary could be copied in binary form. If
///               **FALSE**, the dictionary will be encoded in ASCII85 form. On return, this Boolean variable indicates whether the
///               dictionary was actually binary (**TRUE**) or ASCII85 (**FALSE**).
///Returns:
///    If this function succeeds, the return value is **TRUE**. It also returns **TRUE** if the *pBuffer* parameter is
///    **NULL** and the size required for the buffer is copied into *pcbSize.* If this function fails, the return value
///    is **FALSE**.
///    
@DllImport("mscms")
BOOL GetPS2ColorRenderingDictionary(ptrdiff_t hProfile, uint dwIntent, char* pPS2ColorRenderingDictionary, 
                                    uint* pcbPS2ColorRenderingDictionary, int* pbBinary);

///Retrieves information about the International Color Consortium (ICC) named color profile that is specified in the
///first parameter.
///Params:
///    hProfile = The handle to the ICC profile from which the information will be retrieved.
///    pNamedProfileInfo = A pointer to a **NAMED\_PROFILE\_INFO** structure.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    
@DllImport("mscms")
BOOL GetNamedProfileInfo(ptrdiff_t hProfile, char* pNamedProfileInfo);

///Converts color names in a named color space to index numbers in an International Color Consortium (ICC) color
///profile.
///Params:
///    hProfile = The handle to an ICC named color profile.
///    paColorName = Pointer to an array of color name structures.
///    paIndex = Pointer to an array of **DWORDS** that this function fills with the indices. The indices begin with one, not
///              zero.
///    dwCount = The number of color names to convert.
///Returns:
///    If this function succeeds with the conversion, the return value is **TRUE**. If the conversion function fails,
///    the return value is **FALSE**.
///    
@DllImport("mscms")
BOOL ConvertColorNameToIndex(ptrdiff_t hProfile, char* paColorName, char* paIndex, uint dwCount);

///Transforms indices in a color space to an array of names in a named color space.
///Params:
///    hProfile = The handle to an International Color Consortium (ICC) color space profile.
///    paIndex = Pointer to an array of color-space index numbers. The indices begin with one, not zero.
///    paColorName = Pointer to an array of color name structures.
///    dwCount = The number of indices to convert.
///Returns:
///    If this conversion function succeeds, the return value is **TRUE**. If this conversion function fails, the return
///    value is **FALSE**.
///    
@DllImport("mscms")
BOOL ConvertIndexToColorName(ptrdiff_t hProfile, char* paIndex, char* paColorName, uint dwCount);

///Creates an International Color Consortium (ICC) *device link profile* from a set of color profiles, using the
///specified intents.
///Params:
///    hProfile = Pointer to an array of handles of the color profiles to be used. The function determines whether the HPROFILEs
///               contain ICC profile information and, if so, it processes them appropriately.
///    nProfiles = Specifies the number of profiles in the array pointed to by *hProfile*.
///    padwIntent = Pointer to an array of **DWORDS** containing the intents to be used. See [Rendering
///                 Intents](rendering-intents.md).
///    nIntents = The number of intents in the array pointed to by *padwIntent*.
///    dwFlags = Specifies flags to used control creation of the transform. For details, see [CMM Transform Creation
///              Flags](cmm-transform-creation-flags.md).
///    pProfileData = Pointer to a pointer to a buffer. If successful, this function allocates the buffer, places its address in
///                   *\*pProfileData*, and fills it with a device link profile. If the function succeeds, the calling application must
///                   free the buffer after it is no longer needed.
///    indexPreferredCMM = Specifies the one-based index of the color profile that indicates what color management module (CMM) to use. The
///                        application developer may allow Windows to choose the CMM by setting this parameter to INDEX\_DONT\_CARE. See
///                        [Using Color Management Modules (CMM)](using-color-management-modules--cmm.md).
///Returns:
///    If this function succeeds, the return value is a nonzero value. If this function fails, the return value is zero.
///    For extended error information, call GetLastError.
///    
@DllImport("mscms")
BOOL CreateDeviceLinkProfile(char* hProfile, uint nProfiles, char* padwIntent, uint nIntents, uint dwFlags, 
                             ubyte** pProfileData, uint indexPreferredCMM);

///Creates a color transform that applications can use to perform color management.
///Params:
///    pLogColorSpace = Pointer to the input [**LOGCOLORSPACEA**](/windows/desktop/api/Wingdi/ns-wingdi-taglogcolorspacea).
///    hDestProfile = Handle to the profile of the destination device. The function determines whether the HPROFILE contains
///                   International Color Consortium (ICC) or Windows Color System (WCS) profile information.
///    hTargetProfile = Handle to the profile of the target device. The function determines whether the HPROFILE contains ICC or WCS
///                     profile information.
///    dwFlags = Specifies flags to used control creation of the transform. See Remarks.
///Returns:
///    If this function succeeds, the return value is a handle to the color transform. If this function fails, the
///    return value is **NULL**. For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
ptrdiff_t CreateColorTransformA(LOGCOLORSPACEA* pLogColorSpace, ptrdiff_t hDestProfile, ptrdiff_t hTargetProfile, 
                                uint dwFlags);

///Creates a color transform that applications can use to perform color management.
///Params:
///    pLogColorSpace = Pointer to the input [**LOGCOLORSPACEA**](/windows/desktop/api/Wingdi/ns-wingdi-taglogcolorspacea).
///    hDestProfile = Handle to the profile of the destination device. The function determines whether the HPROFILE contains
///                   International Color Consortium (ICC) or Windows Color System (WCS) profile information.
///    hTargetProfile = Handle to the profile of the target device. The function determines whether the HPROFILE contains ICC or WCS
///                     profile information.
///    dwFlags = Specifies flags to used control creation of the transform. See Remarks.
///Returns:
///    If this function succeeds, the return value is a handle to the color transform. If this function fails, the
///    return value is **NULL**. For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
ptrdiff_t CreateColorTransformW(LOGCOLORSPACEW* pLogColorSpace, ptrdiff_t hDestProfile, ptrdiff_t hTargetProfile, 
                                uint dwFlags);

///Accepts an array of profiles or a single [device link profile](d.md) and creates a color transform that applications
///can use to perform color mapping.
///Params:
///    pahProfiles = Pointer to an array of handles to the profiles to be used. The function determines whether the HPROFILEs contain
///                  International Color Consortium (ICC) or Windows Color System (WCS) profile information and processes them
///                  appropriately. When valid WCS profiles are returned by
///                  [**OpenColorProfileW**](/windows/win32/api/icm/nf-icm-opencolorprofilew) and
///                  [**WcsOpenColorProfileW**](/windows/win32/api/icm/nf-icm-wcsopencolorprofile), these profile handles contain the
///                  combination of DMP, CAMP, and GMMP profiles.
///    nProfiles = Specifies the number of profiles in the array. The maximum is 10.
///    padwIntent = Pointer to an array of intents to use. Each intent is one of the following values: <dl><span
///                 id="INTENT_PERCEPTUAL"></span><span id="intent_perceptual"></span><dt> **INTENT\_PERCEPTUAL** </dt><span
///                 id="INTENT_SATURATION"></span><span id="intent_saturation"></span><dt> **INTENT\_SATURATION** </dt><span
///                 id="INTENT_RELATIVE_COLORIMETRIC"></span><span id="intent_relative_colorimetric"></span><dt>
///                 **INTENT\_RELATIVE\_COLORIMETRIC** </dt><span id="INTENT_ABSOLUTE_COLORIMETRIC"></span><span
///                 id="intent_absolute_colorimetric"></span><dt> **INTENT\_ABSOLUTE\_COLORIMETRIC** </dt> </dl> GMMPs are a
///                 generalization of intents. There are two possible sources of intents: the "destination" profile and the intent
///                 list parameter to **CreateMultiProfileTransform**. The term "destination" is not used since all but two of the
///                 profiles in the profile list parameter will serve as first destination and then source. For more information, see
///                 [Rendering Intents](rendering-intents.md).
///    nIntents = Specifies the number of elements in the intents array: can either be 1 or the same value as *nProfiles*. For
///               profile arrays that contain any WCS profiles, the first rendering intent is ignored and only *nProfiles* -1
///               elements are used for these profile arrays. The maximum number of *nIntents* is 10.
///    dwFlags = Specifies flags used to control creation of the transform. See Remarks.
///    indexPreferredCMM = Specifies the one-based index of the color profile that indicates what color management module (CMM) to use. The
///                        application developer may allow Windows to choose the CMM by setting this parameter to INDEX\_DONT\_CARE. See
///                        [Using Color Management Modules (CMM)](using-color-management-modules--cmm.md) Third party CMMs are only
///                        available for ICC workflows. Profile arrays containing WCS profiles will ignore this flag. It is also ignored
///                        when only ICC profiles are used and when the WCS\_ALWAYS flag is used.
///Returns:
///    If this function succeeds, the return value is a handle to the color transform. If this function fails, the
///    return value is **NULL**. For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
ptrdiff_t CreateMultiProfileTransform(char* pahProfiles, uint nProfiles, char* padwIntent, uint nIntents, 
                                      uint dwFlags, uint indexPreferredCMM);

///Deletes a given color transform.
///Params:
///    hxform = Identifies the color transform to delete.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL DeleteColorTransform(ptrdiff_t hxform);

///Translates the colors of a bitmap having a defined format so as to produce another bitmap in a requested format.
///Params:
///    hColorTransform = Identifies the color transform to use.
///    pSrcBits = Pointer to the bitmap to translate.
///    bmInput = Specifies the format of the input bitmap. Must be set to one of the values of the
///              [**BMFORMAT**](/windows/win32/api/icm/ne-icm-bmformat) enumerated type. > [!Note] > This function doesn't support
///              [**BM\_XYZTRIPLETS**](/windows/win32/api/icm/ne-icm-bmformat) or **BM\_YxyTRIPLETS** as inputs.
///    dwWidth = Specifies the number of pixels per scan line in the input bitmap.
///    dwHeight = Specifies the number of scan lines in the input bitmap.
///    dwInputStride = Specifies the number of bytes from the beginning of one scan line to the beginning of the next in the input
///                    bitmap; if set to zero, the function assumes that scan lines are padded so as to be **DWORD**-aligned.
///    pDestBits = Pointer to the buffer in which to place the translated bitmap.
///    bmOutput = Specifies the format of the output bitmap. Must be set to one of the values of the
///               [**BMFORMAT**](/windows/win32/api/icm/ne-icm-bmformat) enumerated type.
///    dwOutputStride = Specifies the number of bytes from the beginning of one scan line to the beginning of the next in the output
///                     bitmap; if set to zero, the function assumes that scan lines should be padded to be **DWORD**-aligned.
///    pfnCallBack = Pointer to a callback function called periodically by **TranslateBitmapBits** to report progress and allow the
///                  calling process to cancel the translation. (See [**ICMProgressProcCallback**](icmprogressproccallback.md) )
///    ulCallbackData = Data passed back to the callback function, for example, to identify the translation that is reporting progress.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL TranslateBitmapBits(ptrdiff_t hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                         uint dwInputStride, void* pDestBits, BMFORMAT bmOutput, uint dwOutputStride, 
                         PBMCALLBACKFN pfnCallBack, LPARAM ulCallbackData);

///Checks whether the pixels in a specified bitmap lie within the output [gamut](/windows/win32/wcs/g) of a specified
///transform.
///Params:
///    hColorTransform = Handle to the color transform to use.
///    pSrcBits = Pointer to the bitmap to check against the output gamut.
///    bmInput = Specifies the format of the bitmap. Must be set to one of the values of the
///              [**BMFORMAT**](/windows/win32/api/icm/ne-icm-bmformat) enumerated type.
///    dwWidth = Specifies the number of pixels per scan line of the bitmap.
///    dwHeight = Specifies the number of scan lines of the bitmap.
///    dwStride = Specifies the number of bytes from the beginning one scan line to the beginning of the next one. If set to zero,
///               the bitmap scan lines are assumed to be padded so as to be **DWORD**-aligned.
///    paResult = Pointer to an array of bytes where the test results are to be placed. This results buffer must contain at least
///               as many bytes as there are pixels in the bitmap.
///    pfnCallback = Pointer to a callback function called periodically by **CheckBitmapBits** to report progress and allow the
///                  calling process to cancel the bitmap test. (See [**ICMProgressProcCallback**](icmprogressproccallback.md)).
///    lpCallbackData = Data passed back to the callback function, for example, to identify the bitmap test about which progress is being
///                     reported.
///Returns:
///    If this function succeeds, the return value is a nonzero value. If this function fails, the return value is zero.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL CheckBitmapBits(ptrdiff_t hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                     uint dwStride, char* paResult, PBMCALLBACKFN pfnCallback, LPARAM lpCallbackData);

///Translates an array of colors from the source [color space](c.md) to the destination color space as defined by a
///color transform.
///Params:
///    hColorTransform = Identifies the color transform to use.
///    paInputColors = Pointer to an array of *nColors*[**COLOR**](/windows/win32/api/icm/ns-icm-color) structures to translate.
///    nColors = Contains the number of elements in the arrays pointed to by *paInputColors* and *paOutputColors*.
///    ctInput = Specifies the input color type.
///    paOutputColors = Pointer to an array of *nColors* **COLOR** structures that receive the translated colors.
///    ctOutput = Specifies the output color type.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL TranslateColors(ptrdiff_t hColorTransform, char* paInputColors, uint nColors, COLORTYPE ctInput, 
                     char* paOutputColors, COLORTYPE ctOutput);

///Determines whether the colors in an array lie within the output [gamut](/windows/win32/wcs/g) of a specified
///transform.
///Params:
///    hColorTransform = Handle to the color transform to use.
///    paInputColors = Pointer to an array of *nColors* [**COLOR**](/windows/win32/api/icm/ns-icm-color) structures to translate.
///    nColors = Contains the number of elements in the arrays pointed to by *paInputColors* and *paResult*.
///    ctInput = Specifies the input color type.
///    paResult = Pointer to an array of *nColors* bytes that receives the results of the test.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL CheckColors(ptrdiff_t hColorTransform, char* paInputColors, uint nColors, COLORTYPE ctInput, char* paResult);

///Retrieves various information about the color management module (CMM) that created the specified color transform.
///Params:
///    hColorTransform = Identifies the transform for which to find CMM information.
///    arg2 = Specifies the information to be retrieved. This parameter can take one of the following constant values. | Value
///           | Meaning | |-|-| | <span id="CMM_WIN_VERSION"></span><span id="cmm_win_version"></span><dl>
///           <dt>**CMM\_WIN\_VERSION**</dt> </dl> | Retrieves the version of Windows targeted by the color management module
///           (CMM).<br/> | | <span id="CMM_DLL_VERSION"></span><span id="cmm_dll_version"></span><dl>
///           <dt>**CMM\_DLL\_VERSION**</dt> </dl> | Retrieves the version number of the CMM.<br/> | | <span
///           id="CMM_IDENT"></span><span id="cmm_ident"></span><dl> <dt>**CMM\_IDENT**</dt> </dl> | Retrieves the CMM
///           signature registered with the International Color Consortium (ICC).<br/> |
///Returns:
///    If this function succeeds, the return value is the information specified in *dwInfo.* If this function fails, the
///    return value is zero.
///    
@DllImport("mscms")
uint GetCMMInfo(ptrdiff_t hColorTransform, uint param1);

///Associates a specified identification value with the specified color management module dynamic link library (CMM
///DLL). When this ID appears in a color profile, Windows can then locate the corresponding CMM so as to create a
///transform.
///Params:
///    pMachineName = Reserved; must currently be set to **NULL**, until non-local registration is supported. This parameter is
///                   intended to point to the name of the machine on which a CMM DLL should be registered. A **NULL** pointer
///                   indicates the local machine.
///    cmmID = Specifies the ID signature of the CMM registered with the International Color Consortium (ICC).
///    pCMMdll = Pointer to the fully qualified path name of the CMM DLL.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL RegisterCMMA(const(char)* pMachineName, uint cmmID, const(char)* pCMMdll);

///Associates a specified identification value with the specified color management module dynamic link library (CMM
///DLL). When this ID appears in a color profile, Windows can then locate the corresponding CMM so as to create a
///transform.
///Params:
///    pMachineName = Reserved; must currently be set to **NULL**, until non-local registration is supported. This parameter is
///                   intended to point to the name of the machine on which a CMM DLL should be registered. A **NULL** pointer
///                   indicates the local machine.
///    cmmID = Specifies the ID signature of the CMM registered with the International Color Consortium (ICC).
///    pCMMdll = Pointer to the fully qualified path name of the CMM DLL.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL RegisterCMMW(const(wchar)* pMachineName, uint cmmID, const(wchar)* pCMMdll);

///Dissociates a specified ID value from a given color management module dynamic-link library (CMM DLL).
///Params:
///    pMachineName = Reserved; must currently be set to **NULL**, until non-local registration is supported. This parameter is
///                   intended to point to the name of the computer on which a CMM DLLs registration should be removed. A **NULL**
///                   pointer indicates the local computer.
///    cmmID = Specifies the ID value identifying the CMM whose registration is to be removed. This is the signature of the CMM
///            registered with the International Color Consortium (ICC).
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL UnregisterCMMA(const(char)* pMachineName, uint cmmID);

///Dissociates a specified ID value from a given color management module dynamic-link library (CMM DLL).
///Params:
///    pMachineName = Reserved; must currently be set to **NULL**, until non-local registration is supported. This parameter is
///                   intended to point to the name of the computer on which a CMM DLLs registration should be removed. A **NULL**
///                   pointer indicates the local computer.
///    cmmID = Specifies the ID value identifying the CMM whose registration is to be removed. This is the signature of the CMM
///            registered with the International Color Consortium (ICC).
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL UnregisterCMMW(const(wchar)* pMachineName, uint cmmID);

///Allows you to select the preferred color management module (CMM) to use.
///Params:
///    dwCMMType = Specifies the signature of the desired CMM as registered with the International Color Consortium (ICC). **Windows
///                2000 only:** Setting this parameter to **NULL** causes the WCS system to select the default CMM.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL SelectCMM(uint dwCMMType);

///Retrieves the path of the Windows COLOR directory on a specified machine.
///Params:
///    pMachineName = Reserved; must be **NULL**. This parameter is intended to point to the name of the machine on which the profile
///                   is to be installed. A **NULL** pointer indicates the local machine.
///    pBuffer = Points to the buffer in which the color directory path is to be placed.
///    pdwSize = Points to a variable containing the size in bytes of the buffer pointed to by *pBuffer*. On return, the variable
///              contains the size of the buffer actually used or needed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetColorDirectoryA(const(char)* pMachineName, const(char)* pBuffer, uint* pdwSize);

///Retrieves the path of the Windows COLOR directory on a specified machine.
///Params:
///    pMachineName = Reserved; must be **NULL**. This parameter is intended to point to the name of the machine on which the profile
///                   is to be installed. A **NULL** pointer indicates the local machine.
///    pBuffer = Points to the buffer in which the color directory path is to be placed.
///    pdwSize = Points to a variable containing the size in bytes of the buffer pointed to by *pBuffer*. On return, the variable
///              contains the size of the buffer actually used or needed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetColorDirectoryW(const(wchar)* pMachineName, const(wchar)* pBuffer, uint* pdwSize);

///Installs a given profile for use on a specified machine. The profile is also copied to the COLOR directory.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which the profile
///                   is to be installed. A **NULL** pointer indicates the local computer.
///    pProfileName = Pointer to the fully qualified path name of the profile to install.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL InstallColorProfileA(const(char)* pMachineName, const(char)* pProfileName);

///Installs a given profile for use on a specified machine. The profile is also copied to the COLOR directory.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which the profile
///                   is to be installed. A **NULL** pointer indicates the local computer.
///    pProfileName = Pointer to the fully qualified path name of the profile to install.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL InstallColorProfileW(const(wchar)* pMachineName, const(wchar)* pProfileName);

///Removes a specified color profile from a specified computer. Associated files are optionally deleted from the system.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the machine from which to
///                   uninstall the specified profile. A **NULL** pointer indicates the local machine.
///    pProfileName = Points to the file name of the profile to uninstall.
///    bDelete = If set to **TRUE**, the function deletes the profile from the COLOR directory. If set to **FALSE**, this function
///              has no effect.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL UninstallColorProfileA(const(char)* pMachineName, const(char)* pProfileName, BOOL bDelete);

///Removes a specified color profile from a specified computer. Associated files are optionally deleted from the system.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the machine from which to
///                   uninstall the specified profile. A **NULL** pointer indicates the local machine.
///    pProfileName = Points to the file name of the profile to uninstall.
///    bDelete = If set to **TRUE**, the function deletes the profile from the COLOR directory. If set to **FALSE**, this function
///              has no effect.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL UninstallColorProfileW(const(wchar)* pMachineName, const(wchar)* pProfileName, BOOL bDelete);

///Enumerates all the profiles satisfying the given enumeration criteria.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which to enumerate
///                   profiles. A **NULL** pointer indicates the local computer.
///    pEnumRecord = Pointer to a structure specifying the enumeration criteria.
///    pEnumerationBuffer = Pointer to a buffer in which the profiles are to be enumerated. A MULTI\_SZ string of profile names satisfying
///                         the criteria specified in *\*pEnumRecord* will be placed in this buffer.
///    pdwSizeOfEnumerationBuffer = Pointer to a variable containing the size of the buffer pointed to by *pBuffer*. On return, *\*pdwSize* contains
///                                 the size of buffer actually used or needed.
///    pnProfiles = Pointer to a variable that will contain, on return, the number of profile names actually copied to the buffer.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL EnumColorProfilesA(const(char)* pMachineName, ENUMTYPEA* pEnumRecord, char* pEnumerationBuffer, 
                        uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

///Enumerates all the profiles satisfying the given enumeration criteria.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which to enumerate
///                   profiles. A **NULL** pointer indicates the local computer.
///    pEnumRecord = Pointer to a structure specifying the enumeration criteria.
///    pEnumerationBuffer = Pointer to a buffer in which the profiles are to be enumerated. A MULTI\_SZ string of profile names satisfying
///                         the criteria specified in *\*pEnumRecord* will be placed in this buffer.
///    pdwSizeOfEnumerationBuffer = Pointer to a variable containing the size of the buffer pointed to by *pBuffer*. On return, *\*pdwSize* contains
///                                 the size of buffer actually used or needed.
///    pnProfiles = Pointer to a variable that will contain, on return, the number of profile names actually copied to the buffer.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL EnumColorProfilesW(const(wchar)* pMachineName, ENUMTYPEW* pEnumRecord, char* pEnumerationBuffer, 
                        uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

///Registers a specified profile for a given standard [color space](c.md). The profile can be queried using
///[GetStandardColorSpaceProfileW](/windows/win32/api/icm/nf-icm-getstandardcolorspaceprofilew).
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the machine on which to set a
///                   standard color space profile. A **NULL** pointer indicates the local machine.
///    dwProfileID = Specifies the ID value of the standard color space that the given profile represents. This is a custom ID value
///                  used to uniquely identify the color space profile within your application.
///    pProfilename = Points to a fully qualified path to the profile file.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL SetStandardColorSpaceProfileA(const(char)* pMachineName, uint dwProfileID, const(char)* pProfilename);

///Registers a specified profile for a given standard [color space](c.md). The profile can be queried using
///[GetStandardColorSpaceProfileW](/windows/win32/api/icm/nf-icm-getstandardcolorspaceprofilew).
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the machine on which to set a
///                   standard color space profile. A **NULL** pointer indicates the local machine.
///    dwProfileID = Specifies the ID value of the standard color space that the given profile represents. This is a custom ID value
///                  used to uniquely identify the color space profile within your application.
///    pProfilename = Points to a fully qualified path to the profile file.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL SetStandardColorSpaceProfileW(const(wchar)* pMachineName, uint dwProfileID, const(wchar)* pProfileName);

///Retrieves the color profile registered for the specified standard [color space](c.md).
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which to get a
///                   standard color space profile. A **NULL** pointer indicates the local machine.
///    dwSCS = Specifies the ID value of the standard color space for which to retrieve the profile. The only valid values for
///            this parameter are LCS\_sRGB and LCS\_WINDOWS\_COLOR\_SPACE.
///    pBuffer = Pointer to the buffer in which the name of the profile is to be placed. If **NULL**, the call will return
///              **TRUE** and the required size of the buffer is placed in *pdwSize.*
///    pcbSize = Pointer to a variable containing the size in bytes of the buffer pointed to by *pProfileName*. On return, the
///              variable contains the size of the buffer actually used or needed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetStandardColorSpaceProfileA(const(char)* pMachineName, uint dwSCS, const(char)* pBuffer, uint* pcbSize);

///Retrieves the color profile registered for the specified standard [color space](c.md).
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which to get a
///                   standard color space profile. A **NULL** pointer indicates the local machine.
///    dwSCS = Specifies the ID value of the standard color space for which to retrieve the profile. The only valid values for
///            this parameter are LCS\_sRGB and LCS\_WINDOWS\_COLOR\_SPACE.
///    pBuffer = Pointer to the buffer in which the name of the profile is to be placed. If **NULL**, the call will return
///              **TRUE** and the required size of the buffer is placed in *pdwSize.*
///    pcbSize = Pointer to a variable containing the size in bytes of the buffer pointed to by *pProfileName*. On return, the
///              variable contains the size of the buffer actually used or needed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL GetStandardColorSpaceProfileW(const(wchar)* pMachineName, uint dwSCS, const(wchar)* pBuffer, uint* pcbSize);

///Associates a specified color profile with a specified device.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the machine on which to associate
///                   the specified profile and device. A **NULL** pointer indicates the local machine.
///    pProfileName = Points to the file name of the profile to associate.
///    pDeviceName = Points to the name of the device to associate.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL AssociateColorProfileWithDeviceA(const(char)* pMachineName, const(char)* pProfileName, 
                                      const(char)* pDeviceName);

///Associates a specified color profile with a specified device.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the machine on which to associate
///                   the specified profile and device. A **NULL** pointer indicates the local machine.
///    pProfileName = Points to the file name of the profile to associate.
///    pDeviceName = Points to the name of the device to associate.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL AssociateColorProfileWithDeviceW(const(wchar)* pMachineName, const(wchar)* pProfileName, 
                                      const(wchar)* pDeviceName);

///Disassociates a specified color profile with a specified device on a specified computer.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which to
///                   disassociate the specified profile and device. A **NULL** pointer indicates the local computer.
///    pProfileName = Pointer to the file name of the profile to disassociate.
///    pDeviceName = Pointer to the name of the device to disassociate.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL DisassociateColorProfileFromDeviceA(const(char)* pMachineName, const(char)* pProfileName, 
                                         const(char)* pDeviceName);

///Disassociates a specified color profile with a specified device on a specified computer.
///Params:
///    pMachineName = Reserved. Must be **NULL**. This parameter is intended to point to the name of the computer on which to
///                   disassociate the specified profile and device. A **NULL** pointer indicates the local computer.
///    pProfileName = Pointer to the file name of the profile to disassociate.
///    pDeviceName = Pointer to the name of the device to disassociate.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL DisassociateColorProfileFromDeviceW(const(wchar)* pMachineName, const(wchar)* pProfileName, 
                                         const(wchar)* pDeviceName);

///Creates a Color Management dialog box that lets the user choose whether to enable color management and, if so,
///provides control over the color profiles used and over the [rendering intent](r.md).
///Params:
///    pcms = Pointer to a [**COLORMATCHSETUPW**](/windows/win32/api/icm/ns-icm-colormatchsetupw) structure that on entry
///           contains information used to initialize the dialog box. When **SetupColorMatching** returns, if the user clicked
///           the OK button, this structure contains information about the user's selection. Otherwise, if an error occurred or
///           the user canceled the dialog box, the structure is left unchanged.
///Returns:
///    If this function succeeds, the return value is **TRUE** indicating that no errors occurred and the user clicked
///    the OK button. If this function fails, the return value is **FALSE** indicating that an error occurred or the
///    dialog was canceled. For extended error information, call **GetLastError**.
///    
@DllImport("ICMUI")
BOOL SetupColorMatchingW(char* pcms);

///Creates a Color Management dialog box that lets the user choose whether to enable color management and, if so,
///provides control over the color profiles used and over the [rendering intent](r.md).
///Params:
///    pcms = Pointer to a [**COLORMATCHSETUPW**](/windows/win32/api/icm/ns-icm-colormatchsetupw) structure that on entry
///           contains information used to initialize the dialog box. When **SetupColorMatching** returns, if the user clicked
///           the OK button, this structure contains information about the user's selection. Otherwise, if an error occurred or
///           the user canceled the dialog box, the structure is left unchanged.
///Returns:
///    If this function succeeds, the return value is **TRUE** indicating that no errors occurred and the user clicked
///    the OK button. If this function fails, the return value is **FALSE** indicating that an error occurred or the
///    dialog was canceled. For extended error information, call **GetLastError**.
///    
@DllImport("ICMUI")
BOOL SetupColorMatchingA(char* pcms);

///Associates a specified WCS color profile with a specified device.
///Params:
///    scope = A [**WCS\_PROFILE\_MANAGEMENT\_SCOPE**](/windows/win32/api/icm/ne-icm-wcs_profile_management_scope) value that
///            specifies the scope of this profile management operation, which could be system-wide or for the current user.
///    pProfileName = A pointer to the file name of the profile to associate.
///    pDeviceName = A pointer to the name of the device with which the profile is to be associated.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsAssociateColorProfileWithDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pProfileName, 
                                        const(wchar)* pDeviceName);

///Disassociates a specified WCS color profile from a specified device on a computer.
///Params:
///    scope = A [**WCS\_PROFILE\_MANAGEMENT\_SCOPE**](/windows/win32/api/icm/ne-icm-wcs_profile_management_scope) value that
///            specifies the scope of this profile management operation, which could be system-wide or for the current user.
///    pProfileName = A pointer to the file name of the profile to disassociate.
///    pDeviceName = A pointer to the name of the device from which to disassociate the profile.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsDisassociateColorProfileFromDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pProfileName, 
                                           const(wchar)* pDeviceName);

///Returns the size, in bytes, of the buffer that is required by the
///[**WcsEnumColorProfiles**](/windows/win32/api/icm/nf-icm-wcsenumcolorprofiles) function to enumerate color profiles.
///Params:
///    scope = A [**WCS\_PROFILE\_MANAGEMENT\_SCOPE**](/windows/win32/api/icm/ne-icm-wcs_profile_management_scope) value that
///            specifies the scope of the profile management operation that is performed by this function.
///    pEnumRecord = A pointer to a structure that specifies the enumeration criteria.
///    pdwSize = A pointer to a variable that receives the size of the buffer that is required to receive all enumerated profile
///              names. This value is used by the *dwSize* parameter of the
///              [**WcsEnumColorProfiles**](/windows/win32/api/icm/nf-icm-wcsenumcolorprofiles) function.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsEnumColorProfilesSize(WCS_PROFILE_MANAGEMENT_SCOPE scope_, ENUMTYPEW* pEnumRecord, uint* pdwSize);

///Params:
///    scope = A [**WCS\_PROFILE\_MANAGEMENT\_SCOPE**](/windows/win32/api/icm/ne-icm-wcs_profile_management_scope) value
///            specifying the scope of this profile management operation.
///    pEnumRecord = A pointer to a structure specifying the enumeration criteria.
///    pBuffer = A pointer to a buffer in which the profile names are to be enumerated. The **WcsEnumColorProfiles** function
///              places, in this buffer, a MULTI\_SZ string that consists of profile names that satisfy the criteria specified in
///              *\*pEnumRecord*.
///    dwSize = A variable that contains the size, in bytes, of the buffer that is pointed to by *pBuffer*. See **Remarks**.
///    pnProfiles = An optional pointer to a variable that receives the number of profile names that are copied to the buffer to
///                 which *pBuffer* points. Can be **NULL** if this information is not needed.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsEnumColorProfiles(WCS_PROFILE_MANAGEMENT_SCOPE scope_, ENUMTYPEW* pEnumRecord, char* pBuffer, uint dwSize, 
                          uint* pnProfiles);

///Returns the size, in bytes, of the default color profile name (including the **NULL** terminator), for a device.
///Params:
///    scope = A [**WCS\_PROFILE\_MANAGEMENT\_SCOPE**](/windows/win32/api/icm/ne-icm-wcs_profile_management_scope) value that
///            specifies the scope of this profile management operation.
///    pDeviceName = A pointer to the name of the device for which the default color profile is to be obtained. If **NULL**, a
///                  device-independent default profile will be used.
///    cptColorProfileType = A [**COLORPROFILETYPE**](/windows/win32/api/icm/ne-icm-colorprofiletype) value specifying the color profile type.
///    cpstColorProfileSubType = A [**COLORPROFILESUBTYPE**](/windows/win32/api/icm/ne-icm-colorprofilesubtype) value specifying the color profile
///                              subtype.
///    dwProfileID = The ID of the color space that the color profile represents.
///    pcbProfileName = A pointer to a location that receives the size, in bytes, of the path name of the default color profile,
///                     including the **NULL** terminator.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsGetDefaultColorProfileSize(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pDeviceName, 
                                   COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                                   uint dwProfileID, uint* pcbProfileName);

///Retrieves the default color profile for a device, or for a device-independent default if the device is not specified.
///Params:
///    scope = A [**WCS_PROFILE_MANAGEMENT_SCOPE**](/windows/win32/api/icm/ne-icm-wcs_profile_management_scope) value specifying
///            the scope of this profile management operation.
///    pDeviceName = A pointer to the name of the device for which the default color profile is obtained. If **NULL**, a
///                  device-independent default profile is obtained.
///    cptColorProfileType = A [**COLORPROFILETYPE**](/windows/win32/api/icm/ne-icm-colorprofiletype) value specifying the color profile type.
///    cpstColorProfileSubType = A [**COLORPROFILESUBTYPE**](/windows/win32/api/icm/ne-icm-colorprofilesubtype) value specifying the color profile
///                              subtype.
///    dwProfileID = The ID of the color space that the color profile represents.
///    cbProfileName = The buffer size, in bytes, of the buffer that is pointed to by *pProfileName*.
///    pProfileName = A pointer to a buffer to receive the name of the color profile. The size of the buffer, in bytes, will be the
///                   indicated by *cbProfileName*.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsGetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pDeviceName, 
                               COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                               uint dwProfileID, uint cbProfileName, const(wchar)* pProfileName);

///Sets the default color profile name for the specified profile type in the specified profile management scope.
///Params:
///    scope = A [**WCS\_PROFILE\_MANAGEMENT\_SCOPE**](/windows/win32/api/icm/ne-icm-wcs_profile_management_scope) value that
///            specifies the scope of this profile management operation.
///    pDeviceName = A pointer to the name of the device for which the default color profile is to be set. If **NULL**, a
///                  device-independent default profile is used.
///    cptColorProfileType = A [**COLORPROFILETYPE**](/windows/win32/api/icm/ne-icm-colorprofiletype) value that specifies the color profile
///                          type.
///    cpstColorProfileSubType = A [**COLORPROFILESUBTYPE**](/windows/win32/api/icm/ne-icm-colorprofilesubtype) value that specifies the color
///                              profile subtype.
///    dwProfileID = The ID of the color space that the color profile represents. This is a custom ID value used to uniquely identify
///                  the color space profile within your application.
///    pProfileName = A pointer to a buffer that holds the name of the color profile. See Remarks.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
BOOL WcsSetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pDeviceName, 
                               COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                               uint dwProfileID, const(wchar)* pProfileName);

///Sets the default rendering intent in the specified profile management scope.
///Params:
///    scope = The profile management scope for this operation, which can be system-wide or the current user only.
///    dwRenderingIntent = The rendering intent. It can be set to one of the following values: INTENT\_PERCEPTUAL
///                        INTENT\_RELATIVE\_COLORIMETRIC INTENT\_SATURATION INTENT\_ABSOLUTE\_COLORIMETRIC DWORD\_MAX If
///                        *dwRenderingIntent* is DWORD\_MAX and *scope* is WCS\_PROFILE\_MANAGEMENT\_SCOPE\_CURRENT\_USER, the default
///                        rendering intent for the current user reverts to the system-wide default. For more information, see [Rendering
///                        intents](rendering-intents.md).
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsSetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope_, uint dwRenderingIntent);

///Retrieves the default rendering intent in the specified profile management scope.
///Params:
///    scope = The profile management scope for this operation, which can be system-wide or the current user only.
///    pdwRenderingIntent = A pointer to the variable that will hold the rendering intent. For more information, see [Rendering
///                         intents](rendering-intents.md).
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsGetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope_, uint* pdwRenderingIntent);

///Determines whether the user chose to use a per-user profile association list for the specified device.
///Params:
///    pDeviceName = A pointer to a string containing the user-friendly name of the device.
///    dwDeviceClass = A flag value specifying the class of the device. This parameter must take one of the following values. | | |
///                    |----------------|------------------------------------| | CLASS\_MONITOR | Specifies a display device. | |
///                    CLASS\_PRINTER | Specifies a printer. | | CLASS\_SCANNER | Specifies an image-capture device. |
///    pUsePerUserProfiles = A pointer to a location to receive a Boolean value that is **TRUE** if the user chose to use a per-user profile
///                          association list for the specified device; otherwise **FALSE**.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsGetUsePerUserProfiles(const(wchar)* pDeviceName, uint dwDeviceClass, int* pUsePerUserProfiles);

///Enables a user to specify whether or not to use a per-user profile association list for the specified device.
///Params:
///    pDeviceName = A pointer to a string that contains the user-friendly name of the device.
///    dwDeviceClass = A flag value that specifies the class of the device. This parameter must take one of the following values: | | |
///                    |----------------|------------------------------------| | CLASS\_MONITOR | Specifies a display device. | |
///                    CLASS\_PRINTER | Specifies a printer. | | CLASS\_SCANNER | Specifies an image capture device. |
///    usePerUserProfiles = A Boolean value that is **TRUE** if the user wants to use a per-user profile association list for the specified
///                         device; otherwise **FALSE**.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsSetUsePerUserProfiles(const(wchar)* pDeviceName, uint dwDeviceClass, BOOL usePerUserProfiles);

///Translates an array of colors from the source color space to the destination color space as defined by a color
///transform.
///Params:
///    hColorTransform = A handle for the WCS color transform.
///    nColors = The number of elements in the array to which *pInputData* and *pOutputData* point.
///    nInputChannels = The number of channels per element in the array to which *pInputData* points.
///    cdtInput = The input [**COLORDATATYPE**](/windows/win32/api/icm/ne-icm-colordatatype) color data type.
///    cbInput = The buffer size, in bytes, of *pInputData*.
///    pInputData = A pointer to an array of input colors. The size of the buffer for this array, in bytes, is the **DWORD** value of
///                 *cbInput*.
///    nOutputChannels = The number of channels per element in the array to which *pOutputData* points.
///    cdtOutput = The [**COLORDATATYPE**](/windows/win32/api/icm/ne-icm-colordatatype) output that specified the color data type.
///    cbOutput = The buffer size, in bytes, of *pOutputData*.
///    pOutputData = A pointer to an array of colors that receives the results of the color translation.The size of the buffer for
///                  this array, in bytes, is the **DWORD** value of *cbOutput*.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsTranslateColors(ptrdiff_t hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, 
                        uint cbInput, char* pInputData, uint nOutputChannels, COLORDATATYPE cdtOutput, uint cbOutput, 
                        char* pOutputData);

///Determines whether the colors in an array are within the output gamut of a specified WCS color transform.
///Params:
///    hColorTransform = A handle to the specified WCS color transform.
///    nColors = The number of elements in the array pointed to by *pInputData* and *paResult*.
///    nInputChannels = The number of channels per element in the array pointed to by *pInputData*.
///    cdtInput = The input COLORDATATYPE color data type.
///    cbInput = The buffer size of *pInputData*.
///    pInputData = A pointer to an array of input colors. Colors in this array correspond to the color space of the source profile.
///                 The size of the buffer for this array will be the number of bytes indicated by *cbInput*.
///    paResult = A pointer to an array of *nColors* bytes that receives the results of the test.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    For extended error information, call **GetLastError**.
///    
@DllImport("mscms")
BOOL WcsCheckColors(ptrdiff_t hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, 
                    uint cbInput, char* pInputData, char* paResult);

///Determines whether given colors lie within the output [gamut](/windows/win32/wcs/g) of a specified transform.
///Params:
///    hcmTransform = Handle to the color transform to use.
///    lpaInputColors = Pointer to an array of [**COLOR**](/windows/win32/api/icm/ns-icm-color) structures to check against the output
///                     gamut.
///    nColors = Specifies the number of elements in the array.
///    ctInput = Specifies the input color type.
///    lpaResult = Pointer to a buffer in which to place an array of bytes containing the test results. Each byte in the buffer
///                corresponds to a **COLOR** structure, and on exit has been set to an unsigned value between 0 and 255. The value
///                0 denotes that the color is in gamut, while a nonzero value indicates that it is out of gamut. For any integer
///                *n* such that 0 \< *n* \< 255, a result value of *n* + 1 indicates that the corresponding color is at least as
///                far out of gamut as would be indicated by a result value of *n*. These values are usually generated from the
///                *gamutTag* in the ICC profile.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    If the function is not successful, the CMM should call
///    [SetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-setlasterror) to set the last error to a valid
///    error value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMCheckColors(ptrdiff_t hcmTransform, char* lpaInputColors, uint nColors, COLORTYPE ctInput, char* lpaResult);

///Checks bitmap colors against an output gamut.
///Params:
///    hcmTransform = 
///    lpSrcBits = 
///    bmInput = 
///    dwWidth = 
///    dwHeight = 
///    dwStride = 
///    lpaResult = 
///    pfnCallback = 
///    ulCallbackData = 
///Returns:
///    
///    
@DllImport("ICM32")
BOOL CMCheckRGBs(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                 uint dwStride, char* lpaResult, PBMCALLBACKFN pfnCallback, LPARAM ulCallbackData);

///Converts color names in a named color space to index numbers in a color profile.
///Params:
///    hProfile = The handle to a named color profile.
///    paColorName = Pointer to an array of color name structures.
///    paIndex = Pointer to an array of **DWORDS** that this function fills with the indices.
///    dwCount = The number of color names to convert.
///Returns:
///    If this function succeeds with the conversion, the return value is **TRUE**. If this function fails, the return
///    value is **FALSE**. When this occurs, the CMM should call **SetLastError** to set the last error to a valid error
///    value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMConvertColorNameToIndex(ptrdiff_t hProfile, char* paColorName, char* paIndex, uint dwCount);

///Transforms indices in a color space to an array of names in a named color space.
///Params:
///    hProfile = The handle to a color space profile.
///    paIndex = Pointer to an array of color-space index numbers.
///    paColorName = Pointer to an array of color name structures.
///    dwCount = The number of indices to convert.
///Returns:
///    If this conversion function succeeds, the return value is TRUE. If this function fails, the return value is
///    FALSE. When this occurs, the CMM should call **SetLastError** to set the last error to a valid error value
///    defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMConvertIndexToColorName(ptrdiff_t hProfile, char* paIndex, char* paColorName, uint dwCount);

///Creates a [device link profile](/windows/win32/wcs/d) in the format specified by the International Color Consortium
///in its ICC Profile Format Specification.
///Params:
///    pahProfiles = Pointer to an array of profile handles.
///    nProfiles = Specifies the number of profiles in the array.
///    padwIntents = An array of rendering intents.
///    nIntents = The number of elements in the array of intents.
///    dwFlags = Specifies flags to used control creation of the transform. For details, see [CMM Transform Creation
///              Flags](ms536577\(v=vs.85\).md).
///    lpProfileData = Pointer to a pointer to a buffer. If successful the function allocates and fills this buffer. The calling
///                    application must free this buffer when it is no longer needed. Use the **GlobalFree** function to free this
///                    buffer.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If this function fails, the return value is zero.
///    If the function is not successful, the CMM should call **SetLastError** to set the last error to a valid error
///    value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMCreateDeviceLinkProfile(char* pahProfiles, uint nProfiles, char* padwIntents, uint nIntents, uint dwFlags, 
                               ubyte** lpProfileData);

///Accepts an array of profiles or a single [device link profile](/windows/win32/wcs/d) and creates a color transform.
///This transform is a mapping from the color space specified by the first profile to that of the second profile and so
///on to the last one.
///Params:
///    pahProfiles = Points to an array of profile handles.
///    nProfiles = Specifies the number of profiles in the array.
///    padwIntents = Points to an array of rendering intents. Each rendering intent is represented by one of the following values:
///                  INTENT\_PERCEPTUAL INTENT\_SATURATION INTENT\_RELATIVE\_COLORIMETRIC INTENT\_ABSOLUTE\_COLORIMETRIC For more
///                  information, see [Rendering intents](/windows/win32/wcs/rendering-intents).
///    nIntents = Specifies the number of intents in the intent array. Can be 1, or the same value as *nProfiles*.
///    dwFlags = Specifies flags to used control creation of the transform. For details, see [CMM Transform Creation
///              Flags](/windows/win32/wcs/cmm-transform-creation-flags).
///Returns:
///    If this function succeeds, the return value is a color transform in the range 256 to 65,535. Since only the low
///    **WORD** of the transform is retained, valid transforms cannot exceed this range. If this function fails, the
///    return value is an error code having a value less than 256. When the return value is less than 256, signaling an
///    error, the CMM should use **SetLastError** to set the last error to a valid error value as defined in Winerror.h.
///    
@DllImport("ICM32")
ptrdiff_t CMCreateMultiProfileTransform(char* pahProfiles, uint nProfiles, char* padwIntents, uint nIntents, 
                                        uint dwFlags);

///\[**CMCreateProfileW** is no longer available for use as of Windows Vista.\] Creates a display color profile from a
///[**LOGCOLORSPACEW**](/windows/win32/api/wingdi/ns-wingdi-logcolorspacew) structure.
///Params:
///    lpColorSpace = Pointer to a color logical space, of which the **lcsFilename** member will be **NULL**.
///    lpProfileData = Pointer to a pointer to a buffer. If successful the function allocates and fills this buffer. It is the calling
///                    application's responsibility to free this buffer when it is no longer needed.
///Returns:
///    Beginning with Windows Vista, the default CMM (Icm32.dll) will return **FALSE** and
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) will report
///    ERROR\_NOT\_SUPPORTED. **Windows Server 2003, Windows XP and Windows 2000:** If this function succeeds, the
///    return value is **TRUE**. If this function fails, the return value is **FALSE**. Call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) to retrieve the error.
///    
@DllImport("ICM32")
BOOL CMCreateProfileW(LOGCOLORSPACEW* lpColorSpace, void** lpProfileData);

///Deprecated. There is no replacement API because this one was no longer being used. Developers of alternate CMM
///modules are not required to implement it.
///Params:
///    lpColorSpace = 
///    lpDevCharacter = 
///    lpTargetDevCharacter = 
///Returns:
///    
///    
@DllImport("ICM32")
ptrdiff_t CMCreateTransform(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

///Deprecated. There is no replacement API because this one was no longer being used. Developers of alternate CMM
///modules are not required to implement it.
///Params:
///    lpColorSpace = 
///    lpDevCharacter = 
///    lpTargetDevCharacter = 
///Returns:
///    
///    
@DllImport("ICM32")
ptrdiff_t CMCreateTransformW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

///Creates a color transform that maps from an input
///[**LOGCOLORSPACEA**](/windows/win32/api/wingdi/ns-wingdi-logcolorspacea) to an optional target space and then to an
///output device, using a set of flags that define how the transform should be created.
///Params:
///    lpColorSpace = Pointer to an input logical color space structure.
///    lpDevCharacter = Pointer to a memory-mapped device profile.
///    lpTargetDevCharacter = Pointer to a memory-mapped target profile.
///    dwFlags = Specifies flags to used control creation of the transform. For details, see [CMM transform creation
///              flags](/windows/win32/wcs/cmm-transform-creation-flags).
///Returns:
///    If this function succeeds, the return value is a color transform in the range 256 to 65,535. Since only the low
///    **WORD** of the transform is retained, valid transforms cannot exceed this range. If this function fails, the
///    return value is an error code having a value less than 256. When the return value is less than 256, signaling an
///    error, the CMM should use **SetLastError** to set the last error to a valid error value as defined in Winerror.h.
///    
@DllImport("ICM32")
ptrdiff_t CMCreateTransformExt(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, 
                               uint dwFlags);

///\[**CMCheckColorsInGamut** is no longer available for use as of Windows Vista.\] Determines whether specified RGB
///triples lie in the output [gamut](/windows/win32/wcs/g) of a specified transform.
///Params:
///    hcmTransform = Specifies the transform to use.
///    lpaRGBTriple = Points to an array of RGB triples to check.
///    lpaResult = Points to the buffer in which to put results. The results are represented by an array of bytes. Each byte in the
///                array corresponds to an RGB triple and has an unsigned value between 0 and 255. The value 0 denotes that the
///                color is in gamut, while a nonzero value denotes that it is out of gamut. For any integer *n* in the range 0 \<
///                *n* \< 255, a result value of *n* + 1 indicates that the corresponding color is at least as far out of gamut as
///                would be indicated by a result value of *n*.
///    nCount = Specifies the number of elements in the array.
///Returns:
///    Beginning with Windows Vista, the default CMM (Icm32.dll) will return **FALSE** and
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) will report
///    ERROR\_NOT\_SUPPORTED. **Windows Server 2003, Windows XP and Windows 2000:** If this function succeeds, the
///    return value is **TRUE**. If this function fails, the return value is **FALSE**. Call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) to retrieve the error.
///    
@DllImport("ICM32")
BOOL CMCheckColorsInGamut(ptrdiff_t hcmTransform, char* lpaRGBTriple, char* lpaResult, uint nCount);

///\[**CMCreateProfile** is no longer available for use as of Windows Vista.\] Creates a display color profile from a
///[**LOGCOLORSPACEA**](/windows/win32/api/wingdi/ns-wingdi-logcolorspacea) structure.
///Params:
///    lpColorSpace = Pointer to a color logical space, of which the **lcsFilename** member will be **NULL**.
///    lpProfileData = Pointer to a pointer to a buffer. If successful the function allocates and fills this buffer. It is the calling
///                    application's responsibility to free this buffer when it is no longer needed.
///Returns:
///    Beginning with Windows Vista, the default CMM (Icm32.dll) will return **FALSE** and
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) will report
///    ERROR\_NOT\_SUPPORTED. **Windows Server 2003, Windows XP and Windows 2000:** If this function succeeds, the
///    return value is **TRUE**. If this function fails, the return value is **FALSE**. Call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) to retrieve the error.
///    
@DllImport("ICM32")
BOOL CMCreateProfile(LOGCOLORSPACEA* lpColorSpace, void** lpProfileData);

///Translates an application-supplied RGBQuad into the device [color
///space](https://msdn.microsoft.com/en-us/library/dd371818\(v=vs.85\)).
///Params:
///    hcmTransform = Specifies the transform to be used.
///    ColorRef = The RGBQuad to translate.
///    lpColorRef = Points to a buffer in which to place the translation.
///    dwFlags = Specifies how the transform should be used to make the translation. This parameter can take one of the following
///              meanings. <table> <colgroup> <col style="width: 50%" /> <col style="width: 50%" /> </colgroup> <thead> <tr
///              class="header"> <th>Value</th> <th>Meaning</th> </tr> </thead> <tbody> <tr class="odd"> <td><span
///              id="CMS_FORWARD"></span><span id="cms_forward"></span> <strong>CMS_FORWARD</strong></td> <td><p>Use forward
///              transform</p></td> </tr> <tr class="even"> <td><span id="CMS_BACKWARD"></span><span id="cms_backward"></span>
///              <strong>CMS_BACKWARD</strong></td> <td><p>Use reverse transform</p></td> </tr> </tbody> </table>
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    The CMM should call **SetLastError** to set the last error to a valid error value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMTranslateRGB(ptrdiff_t hcmTransform, uint ColorRef, uint* lpColorRef, uint dwFlags);

///\[**CMTranslateRGBs** is no longer available for use as of Windows Vista.\] Translates a bitmap from one [color
///space](https://msdn.microsoft.com/en-us/library/dd371818\(v=vs.85\)) to another using a color transform.
///Params:
///    hcmTransform = Specifies the color transform to use.
///    lpSrcBits = Points to the bitmap to translate.
///    bmInput = Specifies the input bitmap format.
///    dwWidth = Specifies the number of pixels per scan line in the input bitmap.
///    dwHeight = Specifies the number of scan lines in the input bitmap.
///    dwStride = Specifies the number of bytes from the beginning of one scan line to the beginning of the next in the input
///               bitmap. If *dwStride* is set to zero, the CMM should assume that scan lines are padded so as to be
///               **DWORD**-aligned.
///    lpDestBits = Points to a destination buffer in which to place the translated bitmap.
///    bmOutput = Specifies the output bitmap format.
///    dwTranslateDirection = Specifies the direction of the transform being used for the translation. This parameter must take one of the
///                           following values. <table> <colgroup> <col style="width: 50%" /> <col style="width: 50%" /> </colgroup> <thead>
///                           <tr class="header"> <th>Value</th> <th>Meaning</th> </tr> </thead> <tbody> <tr class="odd"> <td><span
///                           id="CMS_FORWARD"></span><span id="cms_forward"></span> <strong>CMS_FORWARD</strong></td> <td><p>Use forward
///                           transform</p></td> </tr> <tr class="even"> <td><span id="CMS_BACKWARD"></span><span id="cms_backward"></span>
///                           <strong>CMS_BACKWARD</strong></td> <td><p>Use reverse transform</p></td> </tr> </tbody> </table>
///Returns:
///    Beginning with Windows Vista, the default CMM (Icm32.dll) will return **FALSE** and
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror) will report
///    ERROR\_NOT\_SUPPORTED. **Windows Server 2003, Windows XP and Windows 2000:** If this function succeeds, the
///    return value is **TRUE**. If this function fails, the return value is **FALSE**. If the function is not
///    successful, the CMM should call [SetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-setlasterror)
///    to set the last error to a valid error value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMTranslateRGBs(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                     uint dwStride, void* lpDestBits, BMFORMAT bmOutput, uint dwTranslateDirection);

///Creates a color transform that maps from an input
///[**LOGCOLORSPACEW**](/windows/win32/api/wingdi/ns-wingdi-logcolorspacew) to an optional target space and then to an
///output device, using a set of flags that define how the transform should be created.
///Params:
///    lpColorSpace = Pointer to an input logical color space structure.
///    lpDevCharacter = Pointer to a memory-mapped device profile.
///    lpTargetDevCharacter = Pointer to a memory-mapped target profile.
///    dwFlags = Specifies flags to used control creation of the transform. For details, see [CMM transform creation
///              flags](/windows/win32/wcs/cmm-transform-creation-flags).
///Returns:
///    If this function succeeds, the return value is a color transform in the range 256 to 65,535. Since only the low
///    **WORD** of the transform is retained, valid transforms cannot exceed this range. If this function fails, the
///    return value is an error code having a value less than 256. When the return value is less than 256, signaling an
///    error, the CMM should use **SetLastError** to set the last error to a valid error value as defined in Winerror.h.
///    
@DllImport("ICM32")
ptrdiff_t CMCreateTransformExtW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, 
                                uint dwFlags);

///Deletes a specified color transform, and frees any memory associated with it.
///Params:
///    hcmTransform = Identifies the color transform to be deleted.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If the function fails, the return value is **FALSE**. If
///    the **CMDeleteTransform** function is not successful, the CMM should call **SetLastError** to set the last error
///    to a valid error value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMDeleteTransform(ptrdiff_t hcmTransform);

///Retrieves various information about the color management module (CMM). Every CMM is required to export this function.
///Params:
///    dwInfo = Specifies what information should be retrieved. This parameter can take one of the following constant values.
///             <table> <colgroup> <col style="width: 50%" /> <col style="width: 50%" /> </colgroup> <thead> <tr class="header">
///             <th>Constant</th> <th>Significance of the function's return value</th> </tr> </thead> <tbody> <tr class="odd">
///             <td><span id="CMM_DESCRIPTION"></span><span id="cmm_description"></span> <strong>CMM_DESCRIPTION</strong></td>
///             <td><p>A text string that describes the color management module.</p></td> </tr> <tr class="even"> <td><span
///             id="CMM_DLL_VERSION"></span><span id="cmm_dll_version"></span> <strong>CMM_DLL_VERSION</strong></td>
///             <td><p>Version number of the CMM DLL.</p></td> </tr> <tr class="odd"> <td><span
///             id="CMM_DRIVER_LEVEL"></span><span id="cmm_driver_level"></span> <strong>CMM_DRIVER_LEVEL</strong></td>
///             <td><p>Driver compatibility information.</p></td> </tr> <tr class="even"> <td><span id="CMM_IDENT"></span><span
///             id="cmm_ident"></span> <strong>CMM_IDENT</strong></td> <td><p>The CMM identification signature registered with
///             the International Color Consortium (ICC).</p></td> </tr> <tr class="odd"> <td><span
///             id="CMM_LOGOICON"></span><span id="cmm_logoicon"></span> <strong>CMM_LOGOICON</strong></td> <td><p>The logo icon
///             for this CMM.</p></td> </tr> <tr class="even"> <td><span id="CMM_VERSION"></span><span id="cmm_version"></span>
///             <strong>CMM_VERSION</strong></td> <td><p>Version of Windows supported.</p></td> </tr> <tr class="odd"> <td><span
///             id="CMM_WIN_VERSION"></span><span id="cmm_win_version"></span> <strong>CMM_WIN_VERSION</strong></td>
///             <td><p>Backward compatibility with Windows 95.</p></td> </tr> </tbody> </table>
///Returns:
///    If this function succeeds, the return value is the same nonzero value that was passed in through the *dwInfo*
///    parameter. If the function fails, the return value is zero.
///    
@DllImport("ICM32")
uint CMGetInfo(uint dwInfo);

///Retrieves information about the specified named color profile.
///Params:
///    hProfile = The handle to the profile from which the information will be retrieved.
///    pNamedProfileInfo = A pointer to a **NAMED_PROFILE_INFO** structure.
///Returns:
///    If this function succeeds, the return value is TRUE. If this function fails, the return value is FALSE. When this
///    occurs, the CMM should call **SetLastError** to set the last error to a valid error value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMGetNamedProfileInfo(ptrdiff_t hProfile, NAMED_PROFILE_INFO* pNamedProfileInfo);

///Reports whether the given profile is a valid ICC profile that can be used for color management.
///Params:
///    hProfile = Specifies the profile to check.
///    lpbValid = Pointer to a variable that is set on exit to TRUE if the profile is a valid ICC profile, or FALSE if not.
///Returns:
///    If this function succeeds, the return value is TRUE. If this function fails, the return value is FALSE. If the
///    function fails, the CMM should call **SetLastError** to set the last error to a valid error value defined in
///    Winerror.h.
///    
@DllImport("ICM32")
BOOL CMIsProfileValid(ptrdiff_t hProfile, int* lpbValid);

///Translates an array of colors from a source [color space](ms536506\(v=vs.85\).md) to a destination color space using
///a color transform.
///Params:
///    hcmTransform = Specifies the color transform to use.
///    lpaInputColors = Points to an array of [**COLOR**](/windows/win32/api/icm/ns-icm-color) structures to translate.
///    nColors = Specifies the number of elements in the array.
///    ctInput = Specifies the color type of the input.
///    lpaOutputColors = Points to a buffer in which an array of translated **COLOR** structures is to be placed.
///    ctOutput = Specifies the output color type.
///Returns:
///    If this function succeeds, the return value is TRUE. If this function fails, the return value is FALSE. The CMM
///    should call **SetLastError** to set the last error to a valid error value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMTranslateColors(ptrdiff_t hcmTransform, char* lpaInputColors, uint nColors, COLORTYPE ctInput, 
                       char* lpaOutputColors, COLORTYPE ctOutput);

///Translates a bitmap from one defined format into a different defined format and calls a callback function
///periodically, if one is specified, to report progress and permit the calling application to terminate the
///translation.
///Params:
///    hcmTransform = Specifies the color transform to use.
///    lpSrcBits = Pointer to the bitmap to translate.
///    bmInput = Specifies the input bitmap format.
///    dwWidth = Specifies the number of pixels per scan line in the input bitmap.
///    dwHeight = Specifies the number of scan lines in the input bitmap.
///    dwInputStride = Specifies the number of bytes from the beginning of one scan line to the beginning of the next in the input
///                    bitmap. If *dwInputStride* is set to zero, the CMM should assume that scan lines are padded so as to be
///                    **DWORD**-aligned.
///    lpDestBits = Points to a destination buffer in which to place the translated bitmap.
///    bmOutput = Specifies the output bitmap format.
///    dwOutputStride = Specifies the number of bytes from the beginning of one scan line to the beginning of the next in the input
///                     bitmap. If *dwOutputStride* is set to zero, the CMM should pad scan lines so that they are **DWORD**-aligned.
///    lpfnCallback = Pointer to an application-supplied callback function called periodically by **CMTranslateRGBsExt** to report
///                   progress and allow the calling process to cancel the translation. (See
///                   [**ICMProgressProcCallback**](https://msdn.microsoft.com/en-us/library/dd372114\(v=vs.85\)).)
///    ulCallbackData = Data passed back to the callback function, for example to identify the translation that is reporting progress.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**
///    and the CMM should call **SetLastError** to set the last error to a valid error value defined in Winerror.h.
///    
@DllImport("ICM32")
BOOL CMTranslateRGBsExt(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                        uint dwInputStride, void* lpDestBits, BMFORMAT bmOutput, uint dwOutputStride, 
                        LPBMCALLBACKFN lpfnCallback, LPARAM ulCallbackData);

///Creates a handle to a specified color profile.
///Params:
///    pCDMPProfile = Pointer to a WCS DMP or an ICC color profile structure specifying the profile. You can free the *pCDMPProfile*
///                   pointer after you create the handle. If the profile is ICC and its **dwType** member is set to
///                   DONT\_USE\_EMBEDDED\_WCS\_PROFILES, **WcsOpenColorProfile** ignores any embedded WCS profile within the ICC
///                   profile.
///    pCAMPProfile = A pointer to a profile structure that specifies a WCS color appearance model profile (CAMP). You can free the
///                   *pCAMPProfile* pointer after you create the handle. If **NULL**, the default CAMP is used, and the current user
///                   setting, WCS\_PROFILE\_MANAGEMENT\_SCOPE\_CURRENT\_USER, is used while querying the default CAMP.
///    pGMMPProfile = A pointer to a profile structure that specifies a WCS gamut map model profile (GMMP). You can free the
///                   *pGMMPProfile* pointer after you create the handle. If **NULL**, the default GMMP for the default rendering
///                   intent is used, and the current user setting, WCS\_PROFILE\_MANAGEMENT\_SCOPE\_CURRENT\_USER, is used while
///                   querying the default GMMP. For a description of rendering intents, see [Rendering Intents](rendering-intents.md).
///    dwDesireAccess = A flag value that specifies how to access the specified color profile. This parameter must take one of the
///                     following values: | | | |-|-| | PROFILE\_READ | Specifies that the color profile opens for read-only access. | |
///                     PROFILE\_READWRITE | Specifies that the color profile opens for both read and write access. The value of this
///                     flag is ignored if the profile is a WCS profile. |
///    dwShareMode = A flag value that specifies actions to take while opening a color profile contained in a file. This parameter
///                  must take one of the following values, which are defined in *winnt.h*: | | | |-|-| | FILE\_SHARE\_READ |
///                  Specifies that you can perform other open (for read access) operations on the profile. | | FILE\_SHARE\_WRITE |
///                  Specifies that you can perform other open (for write access) operations on the profile. This flag value is
///                  ignored when a WCS profile is opened. |
///    dwCreationMode = A flag value that specifies the actions to take while opening a color profile if it is contained in a file. This
///                     parameter must take one of the following values, which are defined in *winbase.h*: | | | |-|-| | CREATE\_NEW |
///                     Specifies that a new profile is created. This function fails if the profile already exists. | | CREATE\_ALWAYS |
///                     Specifies that a new profile is created. If a profile already exists, it is overwritten. | | OPEN\_EXISTING |
///                     Specifies that the profile is opened. This function fails if the profile does not exist. | | OPEN\_ALWAYS |
///                     Specifies that the profile is to be opened if an International Color Consortium (ICC) file exists. If an ICC
///                     profile does not exist, WCS creates a new ICC profile. The function will fail for WCS profiles if this flag is
///                     set and a WCS profile does not exist. | | TRUNCATE\_EXISTING | Specifies that the profile is to be opened and
///                     truncated to zero bytes. The function fails if the profile does not exist. |
///    dwFlags = A flag value that specifies whether to use the embedded WCS profile. This parameter has no effect unless
///              *pCDMProfile* specifies an ICC profile that contains an embedded WCS profile. This parameter takes one of the
///              following values: | | | |-|-| | 0 | Specifies that the embedded WCS profile will be used and the ICC profile
///              specfied by pCDMPProfile will be ignored. | | DONT\_USE\_EMBEDDED\_WCS\_PROFILES | Specifies that the ICC profile
///              specified by pCDMPProfile will be used and the embedded WCS profile will be ignored. |
///Returns:
///    If this function succeeds, the return value is the handle of the color profile that is opened. If this function
///    fails, the return value is **NULL**.
///    
@DllImport("mscms")
ptrdiff_t WcsOpenColorProfileA(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, 
                               uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

///Creates a handle to a specified color profile.
///Params:
///    pCDMPProfile = Pointer to a WCS DMP or an ICC color profile structure specifying the profile. You can free the *pCDMPProfile*
///                   pointer after you create the handle. If the profile is ICC and its **dwType** member is set to
///                   DONT\_USE\_EMBEDDED\_WCS\_PROFILES, **WcsOpenColorProfile** ignores any embedded WCS profile within the ICC
///                   profile.
///    pCAMPProfile = A pointer to a profile structure that specifies a WCS color appearance model profile (CAMP). You can free the
///                   *pCAMPProfile* pointer after you create the handle. If **NULL**, the default CAMP is used, and the current user
///                   setting, WCS\_PROFILE\_MANAGEMENT\_SCOPE\_CURRENT\_USER, is used while querying the default CAMP.
///    pGMMPProfile = A pointer to a profile structure that specifies a WCS gamut map model profile (GMMP). You can free the
///                   *pGMMPProfile* pointer after you create the handle. If **NULL**, the default GMMP for the default rendering
///                   intent is used, and the current user setting, WCS\_PROFILE\_MANAGEMENT\_SCOPE\_CURRENT\_USER, is used while
///                   querying the default GMMP. For a description of rendering intents, see [Rendering Intents](rendering-intents.md).
///    dwDesireAccess = A flag value that specifies how to access the specified color profile. This parameter must take one of the
///                     following values: | | | |-|-| | PROFILE\_READ | Specifies that the color profile opens for read-only access. | |
///                     PROFILE\_READWRITE | Specifies that the color profile opens for both read and write access. The value of this
///                     flag is ignored if the profile is a WCS profile. |
///    dwShareMode = A flag value that specifies actions to take while opening a color profile contained in a file. This parameter
///                  must take one of the following values, which are defined in *winnt.h*: | | | |-|-| | FILE\_SHARE\_READ |
///                  Specifies that you can perform other open (for read access) operations on the profile. | | FILE\_SHARE\_WRITE |
///                  Specifies that you can perform other open (for write access) operations on the profile. This flag value is
///                  ignored when a WCS profile is opened. |
///    dwCreationMode = A flag value that specifies the actions to take while opening a color profile if it is contained in a file. This
///                     parameter must take one of the following values, which are defined in *winbase.h*: | | | |-|-| | CREATE\_NEW |
///                     Specifies that a new profile is created. This function fails if the profile already exists. | | CREATE\_ALWAYS |
///                     Specifies that a new profile is created. If a profile already exists, it is overwritten. | | OPEN\_EXISTING |
///                     Specifies that the profile is opened. This function fails if the profile does not exist. | | OPEN\_ALWAYS |
///                     Specifies that the profile is to be opened if an International Color Consortium (ICC) file exists. If an ICC
///                     profile does not exist, WCS creates a new ICC profile. The function will fail for WCS profiles if this flag is
///                     set and a WCS profile does not exist. | | TRUNCATE\_EXISTING | Specifies that the profile is to be opened and
///                     truncated to zero bytes. The function fails if the profile does not exist. |
///    dwFlags = A flag value that specifies whether to use the embedded WCS profile. This parameter has no effect unless
///              *pCDMProfile* specifies an ICC profile that contains an embedded WCS profile. This parameter takes one of the
///              following values: | | | |-|-| | 0 | Specifies that the embedded WCS profile will be used and the ICC profile
///              specfied by pCDMPProfile will be ignored. | | DONT\_USE\_EMBEDDED\_WCS\_PROFILES | Specifies that the ICC profile
///              specified by pCDMPProfile will be used and the embedded WCS profile will be ignored. |
///Returns:
///    If this function succeeds, the return value is the handle of the color profile that is opened. If this function
///    fails, the return value is **NULL**.
///    
@DllImport("mscms")
ptrdiff_t WcsOpenColorProfileW(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, 
                               uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

///Converts a WCS profile into an International Color Consortium (ICC) profile.
///Params:
///    hWcsProfile = A handle to the WCS color profile that is converted. See Remarks.
///    dwOptions = A flag value that specifies the profile conversion options. By default, the original WCS profiles used for the
///                conversion are embedded in the output ICC profile in a Microsoft private tag, *WcsProfilesTag* (with signature
///                "MS000". This produces an ICC profile that is compatible with ICC software, yet retains the original WCS profile
///                data available to code designed to parse it. The possible values of this parameter are as follows. Any bits not
///                defined in this list are reserved and should be set to zero: | | |
///                |--------------|------------------------------------------------------------------------------------------------------------|
///                | WCS\_DEFAULT | Specifies that the new ICC profile contains the original WCS profile in a private
///                WcsProfilesTag. | | WCS\_ICCONLY | Specifies that the new ICC profile does not contain either the WcsProfilesTag
///                or the original WCS profile. |
///Returns:
///    If this function succeeds, the return value is the handle of the new color profile. If this function fails, the
///    return value is **NULL**. For extended error information, call
///    [GetLastError](/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror).
///    
@DllImport("mscms")
ptrdiff_t WcsCreateIccProfile(ptrdiff_t hWcsProfile, uint dwOptions);

///Determines whether system management of the display calibration state is enabled.
///Params:
///    pbIsEnabled = **TRUE** if system management of the display calibration state is enabled; otherwise **FALSE**.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    
@DllImport("mscms")
BOOL WcsGetCalibrationManagementState(int* pbIsEnabled);

///Enables or disables system management of the display calibration state.
///Params:
///    bIsEnabled = **TRUE** to enable system management of the display calibration state. **FALSE** to disable system management of
///                 the display calibration state.
///Returns:
///    If this function succeeds, the return value is **TRUE**. If this function fails, the return value is **FALSE**.
///    
@DllImport("mscms")
BOOL WcsSetCalibrationManagementState(BOOL bIsEnabled);

@DllImport("mscms")
HRESULT ColorAdapterGetSystemModifyWhitePointCaps(int* whitePointAdjCapable, int* isColorOverrideActive);

@DllImport("mscms")
HRESULT ColorAdapterUpdateDisplayGamma(DisplayID displayID, DisplayTransformLut* displayTransform, BOOL internal);

@DllImport("mscms")
HRESULT ColorAdapterUpdateDeviceProfile(DisplayID displayID, const(wchar)* profName);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayCurrentStateID(DisplayID displayID, DisplayStateID* displayStateID);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayTransformData(DisplayID displayID, DisplayTransformLut* displayTransformLut, 
                                            uint* transformID);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayTargetWhitePoint(DisplayID displayID, WhitePoint* wtpt, uint* transitionTime, 
                                               uint* whitepointID);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayProfile(DisplayID displayID, const(wchar)* displayProfile, uint* profileID, 
                                      int* bUseAccurate);

@DllImport("mscms")
HRESULT ColorAdapterGetCurrentProfileCalibration(DisplayID displayID, uint maxCalibrationBlobSize, uint* blobSize, 
                                                 char* calibrationBlob);

@DllImport("mscms")
HRESULT ColorAdapterRegisterOEMColorService(HANDLE* registration);

@DllImport("mscms")
HRESULT ColorAdapterUnregisterOEMColorService(HANDLE registration);

///Params:
///    scope = 
///    profileName = 
///    targetAdapterID = 
///    sourceID = 
///    setAsDefault = 
///    associateAsAdvancedColor = 
///Returns:
///    
///    
@DllImport("mscms")
HRESULT ColorProfileAddDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* profileName, 
                                          LUID targetAdapterID, uint sourceID, BOOL setAsDefault, 
                                          BOOL associateAsAdvancedColor);

///Params:
///    scope = 
///    profileName = 
///    targetAdapterID = 
///    sourceID = 
///    dissociateAdvancedColor = 
///Returns:
///    
///    
@DllImport("mscms")
HRESULT ColorProfileRemoveDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* profileName, 
                                             LUID targetAdapterID, uint sourceID, BOOL dissociateAdvancedColor);

///Params:
///    scope = 
///    profileName = 
///    profileType = 
///    profileSubType = 
///    targetAdapterID = 
///    sourceID = 
///Returns:
///    
///    
@DllImport("mscms")
HRESULT ColorProfileSetDisplayDefaultAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* profileName, 
                                                 COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, 
                                                 LUID targetAdapterID, uint sourceID);

///Params:
///    scope = 
///    targetAdapterID = 
///    sourceID = 
///    profileList = 
///    profileCount = 
///Returns:
///    
///    
@DllImport("mscms")
HRESULT ColorProfileGetDisplayList(WCS_PROFILE_MANAGEMENT_SCOPE scope_, LUID targetAdapterID, uint sourceID, 
                                   ushort*** profileList, uint* profileCount);

///Params:
///    scope = 
///    targetAdapterID = 
///    sourceID = 
///    profileType = 
///    profileSubType = 
///    profileName = 
///Returns:
///    
///    
@DllImport("mscms")
HRESULT ColorProfileGetDisplayDefault(WCS_PROFILE_MANAGEMENT_SCOPE scope_, LUID targetAdapterID, uint sourceID, 
                                      COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, 
                                      ushort** profileName);

///Params:
///    targetAdapterID = 
///    sourceID = 
///    scope = 
///Returns:
///    
///    
@DllImport("mscms")
HRESULT ColorProfileGetDisplayUserScope(LUID targetAdapterID, uint sourceID, WCS_PROFILE_MANAGEMENT_SCOPE* scope_);


// Interfaces

///Describes the methods that are defined for the IDeviceModelPlugIn Component Object Model (COM) interface.
@GUID("1CD63475-07C4-46FE-A903-D655316D11FD")
interface IDeviceModelPlugIn : IUnknown
{
    ///Takes a pointer to a Stream that contains the whole device model plug-in as input, and initializes any internal
    ///parameters required by the plug-in.
    ///Params:
    ///    bstrXml = A string that contains the BSTR XML device model plug-in profile. This parameter stores data as little-endian
    ///              Unicode XML; however, it may have no leading bytes to tag it as such. Also, the encoding keyword in the XML
    ///              may not reflect that this is formatted as little-endian Unicode. Furthermore, due to the action of the MSXML
    ///              engine, the BSTR XML file is processed and might not have exactly the same contents as the original XML file.
    ///    cNumModels = The number of total models in the transform sequence.
    ///    iModelPosition = The one-based model position of the other device model in the workflow of <i>uiNumModels</i> as provided in
    ///                     the <b>Initialize</b> function.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT Initialize(BSTR bstrXml, uint cNumModels, uint iModelPosition);
    ///Returns the number of device channels in the parameter <i>pNumChannels</i>.
    ///Params:
    ///    pNumChannels = A pointer to an unsigned integer representing the number of color channels for your device.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT GetNumChannels(uint* pNumChannels);
    ///Returns the appropriate XYZ colors in response to the specified number of colors, channels, device colors and the
    ///proprietary plug-in algorithms.
    ///Params:
    ///    cColors = The number of colors in the <i>pXYZColors</i> and <i>pDeviceValues</i> arrays.
    ///    cChannels = The number of color channels in the <i>pDeviceValues</i> arrays.
    ///    pDeviceValues = A pointer to the array of outgoing XYZColors.
    ///    pXYZColors = A pointer to the array of incoming device colors to convert to XYZColors.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL. For
    ///    extended error information, call <b>GetLastError</b>.
    ///    
    HRESULT DeviceToColorimetricColors(uint cColors, uint cChannels, char* pDeviceValues, char* pXYZColors);
    ///Returns the appropriate XYZ colors in response to the specified number of colors, channels, device colors and the
    ///proprietary plug-in algorithms.
    ///Params:
    ///    cColors = The number of colors in the <i>pXYZColors</i> and <i>pDeviceValues</i> arrays.
    ///    cChannels = The number of color channels in the <i>pDeviceValues</i> arrays.
    ///    pXYZColors = The pointer to the array of incoming XYZColors to convert to device colors.
    ///    pDeviceValues = The pointer to an array that contains the resulting outgoing device color values.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT ColorimetricToDeviceColors(uint cColors, uint cChannels, char* pXYZColors, char* pDeviceValues);
    ///Returns the appropriate device colors in response to the incoming number of colors, channels, black information,
    ///Commission Internationale l'Eclairge XYZ (CIEXYZ) colors and the proprietary plug-in algorithms.
    ///Params:
    ///    cColors = The number of colors in the <i>pXYZColors</i> and <i>pDeviceValues</i> arrays.
    ///    cChannels = The number of color channels in the <i>pDeviceValues</i> arrays.
    ///    pXYZColors = A pointer to the array of outgoing XYZColorF structures.
    ///    pBlackInformation = A pointer to the BlackInformation.
    ///    pDeviceValues = A pointer to the array of incoming device colors that are to be converted to XYZColorF structures.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL. For
    ///    extended error information, call <b>GetLastError</b>.
    ///    
    HRESULT ColorimetricToDeviceColorsWithBlack(uint cColors, uint cChannels, char* pXYZColors, 
                                                char* pBlackInformation, char* pDeviceValues);
    ///Provides the plug-in with parameters to determine where in the transform sequence the specific plug-in occurs.
    ///Params:
    ///    iModelPosition = The one-based model position of the other device model in the workflow of <i>uiNumModels</i>, as provided in
    ///                     the Initialize function.
    ///    pIDeviceModelOther = A pointer to a <b>IDeviceModelPlugIn</b> interface that contains the other device model in the transform
    ///                         sequence.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT SetTransformDeviceModelInfo(uint iModelPosition, IDeviceModelPlugIn pIDeviceModelOther);
    ///Returns the measurement color for the primary sample.
    ///Params:
    ///    pPrimaryColor = The primary color type, which is determined by using the hue circle order. If the plugin device model does
    ///                    not natively support primaries for red, yellow, green, cyan, blue, magenta, black and white, it must still
    ///                    return virtual primary data.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT GetPrimarySamples(PrimaryXYZColors* pPrimaryColor);
    ///Returns the required data structure sizes for the GetGamutBoundaryMesh function.
    ///Params:
    ///    pNumVertices = The required number of vertices.
    ///    pNumTriangles = The required number of triangles.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If the plug-in device model wants WCS to compute its
    ///    gamut boundary mesh, the return value is S_FALSE. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT GetGamutBoundaryMeshSize(uint* pNumVertices, uint* pNumTriangles);
    ///Returns the triangular mesh from the plug-in. This function is used to compute the GamutBoundaryDescription.
    ///Params:
    ///    cChannels = The number of channels.
    ///    cVertices = The number of vertices.
    ///    cTriangles = The number of triangles.
    ///    pVertices = A pointer to the array of vertices in the plug-in model gamut shell.
    ///    pTriangles = A pointer to the array of triangles in the plug-in model gamut shell.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT GetGamutBoundaryMesh(uint cChannels, uint cVertices, uint cTriangles, char* pVertices, 
                                 char* pTriangles);
    ///The IDeviceModelPlugIn::GetNeutralAxisSize function returns the number of data points along the neutral axis that
    ///are returned by the GetNeutralAxis function. It is provided so that a Color Management Module (CMM) can allocate
    ///an appropriately sized buffer.
    ///Params:
    ///    pcColors = The number of points that will be returned by a call to GetNeutralAxis. Minimum is 2 (black and white).
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT GetNeutralAxisSize(uint* pcColors);
    ///The IDeviceModelPlugIn::GetNeutralAxis return the XYZ colorimetry of sample points along the device's neutral
    ///axis.
    ///Params:
    ///    cColors = The number of points that are returned.
    ///    pXYZColors = A pointer to an array of XYZColorF structures.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT GetNeutralAxis(uint cColors, char* pXYZColors);
}

///Describes the methods that are defined for the IGamutMapModelPlugIn Component Object Model (COM) interface.
@GUID("2DD80115-AD1E-41F6-A219-A4F4B583D1F9")
interface IGamutMapModelPlugIn : IUnknown
{
    ///Initializes a gamut map model profile (GMMP) by using the specified source and destination gamut boundary
    ///descriptions and optional source and destination device model plug-ins.
    ///Params:
    ///    bstrXml = A string that contains the BSTR XML GMMP profile. This is little-endian Unicode XML, but without the leading
    ///              bytes to tag it as such. Also, the encoding keyword in the XML may not reflect this format.
    ///    pSrcPlugIn = A pointer to a source IDeviceModelPlugIn. If <b>NULL</b>, it indicates the source device model profile is not
    ///                 a plug-in profile.
    ///    pDestPlugIn = A pointer to a destination IDeviceModelPlugIn. If <b>NULL</b>, it indicates the destination device model
    ///                  profile is not a plug-in profile.
    ///    pSrcGBD = A pointer to a source GamutBoundaryDescription.
    ///    pDestGBD = A pointer to a destination GamutBoundaryDescription.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT Initialize(BSTR bstrXml, IDeviceModelPlugIn pSrcPlugIn, IDeviceModelPlugIn pDestPlugIn, 
                       GamutBoundaryDescription* pSrcGBD, GamutBoundaryDescription* pDestGBD);
    ///Returns the appropriate gamut-mapped appearance colors in response to the specified number of colors and the
    ///CIEJCh colors.
    ///Params:
    ///    cColors = The number of colors in the <i>pXYZColors</i> and <i>pDeviceValues</i> arrays.
    ///    pInputColors = A pointer to the array of incoming colors to be gamut mapped.
    ///    pOutputColors = A pointer to the array of outgoing colors.
    ///Returns:
    ///    If this function succeeds, the return value is S_OK. If this function fails, the return value is E_FAIL.
    ///    
    HRESULT SourceToDestinationAppearanceColors(uint cColors, char* pInputColors, char* pOutputColors);
}


// GUIDs


const GUID IID_IDeviceModelPlugIn   = GUIDOF!IDeviceModelPlugIn;
const GUID IID_IGamutMapModelPlugIn = GUIDOF!IGamutMapModelPlugIn;
