// Written in the D programming language.

module windows.dxgi;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : HDC, HMONITOR;
public import windows.kernel : LUID;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, PSTR, PWSTR,
                                       SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


///Specifies color space types.
alias DXGI_COLOR_SPACE_TYPE = int;
enum : int
{
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> </table> This is the standard definition for
    ///sRGB. Note that this is often implemented with a linear segment, but in that case the exponent is corrected to
    ///stay aligned with a gamma 2.2 curve. This is usually used with 8 or 10 bit color channels.
    DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P709           = 0x00000000,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>1.0</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> </table> This is the standard definition for
    ///scRGB, and is usually used with 16 bit integer, 16 bit floating point, or 32 bit floating point color channels.
    DXGI_COLOR_SPACE_RGB_FULL_G10_NONE_P709           = 0x00000001,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> </table> This is the standard definition for
    ///ITU-R Recommendation BT.709. Note that due to the inclusion of a linear segment, the transfer curve looks similar
    ///to a pure exponential gamma of 1.9. This is usually used with 8 or 10 bit color channels.
    DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P709         = 0x00000002,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_RGB_STUDIO_G22_NONE_P2020        = 0x00000003,
    ///Reserved.
    DXGI_COLOR_SPACE_RESERVED                         = 0x00000004,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> <tr> <td>Transfer Matrix</td> <td>BT.601</td>
    ///</tr> </table> This definition is commonly used for JPG, and is usually used with 8, 10, or 12 bit color
    ///channels.
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_NONE_P709_X601    = 0x00000005,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.601</td> </tr> </table> This definition is commonly used for
    ///MPEG2, and is usually used with 8, 10, or 12 bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P601       = 0x00000006,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.601</td> </tr> </table> This is sometimes used for H.264
    ///camera capture, and is usually used with 8, 10, or 12 bit color channels.
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P601         = 0x00000007,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> </table> This definition is commonly used for
    ///H.264 and HEVC, and is usually used with 8, 10, or 12 bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P709       = 0x00000008,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> </table> This is sometimes used for H.264
    ///camera capture, and is usually used with 8, 10, or 12 bit color channels.
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P709         = 0x00000009,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This definition may be used by HEVC,
    ///and is usually used with 10 or 12 bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_LEFT_P2020      = 0x0000000a,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_FULL_G22_LEFT_P2020        = 0x0000000b,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>2084</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_RGB_FULL_G2084_NONE_P2020        = 0x0000000c,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2084</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_LEFT_P2020    = 0x0000000d,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2084</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_RGB_STUDIO_G2084_NONE_P2020      = 0x0000000e,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G22_TOPLEFT_P2020   = 0x0000000f,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCbCr</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2084</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G2084_TOPLEFT_P2020 = 0x00000010,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>2.2</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P2020          = 0x00000011,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCBCR</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>HLG</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_GHLG_TOPLEFT_P2020  = 0x00000012,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCBCR</td> </tr>
    ///<tr> <td>Range</td> <td>0-255</td> </tr> <tr> <td>Gamma</td> <td>HLG</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_FULL_GHLG_TOPLEFT_P2020    = 0x00000013,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.4</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> </table> This is usually used with 8, 10, or
    ///12 bit color channels.
    DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P709         = 0x00000014,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>RGB</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.4</td> </tr> <tr> <td>Siting</td>
    ///<td>Image</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_RGB_STUDIO_G24_NONE_P2020        = 0x00000015,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCBCR</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.4</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.709</td> </tr> </table> This is usually used with 8, 10, or
    ///12 bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P709       = 0x00000016,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCBCR</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.4</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_LEFT_P2020      = 0x00000017,
    ///<table> <tr> <td><b>Property</b></td> <td><b>Value</b></td> </tr> <tr> <td>Colorspace</td> <td>YCBCR</td> </tr>
    ///<tr> <td>Range</td> <td>16-235</td> </tr> <tr> <td>Gamma</td> <td>2.4</td> </tr> <tr> <td>Siting</td>
    ///<td>Video</td> </tr> <tr> <td>Primaries</td> <td>BT.2020</td> </tr> </table> This is usually used with 10 or 12
    ///bit color channels.
    DXGI_COLOR_SPACE_YCBCR_STUDIO_G24_TOPLEFT_P2020   = 0x00000018,
    ///A custom color definition is used.
    DXGI_COLOR_SPACE_CUSTOM                           = 0xffffffff,
}

///Resource data formats, including fully-typed and typeless formats. A list of modifiers at the bottom of the page more
///fully describes each format type.
alias DXGI_FORMAT = uint;
enum : uint
{
    ///The format is not known.
    DXGI_FORMAT_UNKNOWN                                 = 0x00000000,
    ///A four-component, 128-bit typeless format that supports 32 bits per channel including alpha. ¹
    DXGI_FORMAT_R32G32B32A32_TYPELESS                   = 0x00000001,
    ///A four-component, 128-bit floating-point format that supports 32 bits per channel including alpha.
    ///<sup>1,5,8</sup>
    DXGI_FORMAT_R32G32B32A32_FLOAT                      = 0x00000002,
    ///A four-component, 128-bit unsigned-integer format that supports 32 bits per channel including alpha. ¹
    DXGI_FORMAT_R32G32B32A32_UINT                       = 0x00000003,
    ///A four-component, 128-bit signed-integer format that supports 32 bits per channel including alpha. ¹
    DXGI_FORMAT_R32G32B32A32_SINT                       = 0x00000004,
    ///A three-component, 96-bit typeless format that supports 32 bits per color channel.
    DXGI_FORMAT_R32G32B32_TYPELESS                      = 0x00000005,
    ///A three-component, 96-bit floating-point format that supports 32 bits per color channel.<sup>5,8</sup>
    DXGI_FORMAT_R32G32B32_FLOAT                         = 0x00000006,
    ///A three-component, 96-bit unsigned-integer format that supports 32 bits per color channel.
    DXGI_FORMAT_R32G32B32_UINT                          = 0x00000007,
    ///A three-component, 96-bit signed-integer format that supports 32 bits per color channel.
    DXGI_FORMAT_R32G32B32_SINT                          = 0x00000008,
    ///A four-component, 64-bit typeless format that supports 16 bits per channel including alpha.
    DXGI_FORMAT_R16G16B16A16_TYPELESS                   = 0x00000009,
    ///A four-component, 64-bit floating-point format that supports 16 bits per channel including alpha.<sup>5,7</sup>
    DXGI_FORMAT_R16G16B16A16_FLOAT                      = 0x0000000a,
    ///A four-component, 64-bit unsigned-normalized-integer format that supports 16 bits per channel including alpha.
    DXGI_FORMAT_R16G16B16A16_UNORM                      = 0x0000000b,
    ///A four-component, 64-bit unsigned-integer format that supports 16 bits per channel including alpha.
    DXGI_FORMAT_R16G16B16A16_UINT                       = 0x0000000c,
    ///A four-component, 64-bit signed-normalized-integer format that supports 16 bits per channel including alpha.
    DXGI_FORMAT_R16G16B16A16_SNORM                      = 0x0000000d,
    ///A four-component, 64-bit signed-integer format that supports 16 bits per channel including alpha.
    DXGI_FORMAT_R16G16B16A16_SINT                       = 0x0000000e,
    ///A two-component, 64-bit typeless format that supports 32 bits for the red channel and 32 bits for the green
    ///channel.
    DXGI_FORMAT_R32G32_TYPELESS                         = 0x0000000f,
    ///A two-component, 64-bit floating-point format that supports 32 bits for the red channel and 32 bits for the green
    ///channel.<sup>5,8</sup>
    DXGI_FORMAT_R32G32_FLOAT                            = 0x00000010,
    ///A two-component, 64-bit unsigned-integer format that supports 32 bits for the red channel and 32 bits for the
    ///green channel.
    DXGI_FORMAT_R32G32_UINT                             = 0x00000011,
    ///A two-component, 64-bit signed-integer format that supports 32 bits for the red channel and 32 bits for the green
    ///channel.
    DXGI_FORMAT_R32G32_SINT                             = 0x00000012,
    ///A two-component, 64-bit typeless format that supports 32 bits for the red channel, 8 bits for the green channel,
    ///and 24 bits are unused.
    DXGI_FORMAT_R32G8X24_TYPELESS                       = 0x00000013,
    ///A 32-bit floating-point component, and two unsigned-integer components (with an additional 32 bits). This format
    ///supports 32-bit depth, 8-bit stencil, and 24 bits are unused.⁵
    DXGI_FORMAT_D32_FLOAT_S8X24_UINT                    = 0x00000014,
    ///A 32-bit floating-point component, and two typeless components (with an additional 32 bits). This format supports
    ///32-bit red channel, 8 bits are unused, and 24 bits are unused.⁵
    DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS                = 0x00000015,
    ///A 32-bit typeless component, and two unsigned-integer components (with an additional 32 bits). This format has 32
    ///bits unused, 8 bits for green channel, and 24 bits are unused.
    DXGI_FORMAT_X32_TYPELESS_G8X24_UINT                 = 0x00000016,
    ///A four-component, 32-bit typeless format that supports 10 bits for each color and 2 bits for alpha.
    DXGI_FORMAT_R10G10B10A2_TYPELESS                    = 0x00000017,
    ///A four-component, 32-bit unsigned-normalized-integer format that supports 10 bits for each color and 2 bits for
    ///alpha.
    DXGI_FORMAT_R10G10B10A2_UNORM                       = 0x00000018,
    ///A four-component, 32-bit unsigned-integer format that supports 10 bits for each color and 2 bits for alpha.
    DXGI_FORMAT_R10G10B10A2_UINT                        = 0x00000019,
    ///Three partial-precision floating-point numbers encoded into a single 32-bit value (a variant of s10e5, which is
    ///sign bit, 10-bit mantissa, and 5-bit biased (15) exponent). There are no sign bits, and there is a 5-bit biased
    ///(15) exponent for each channel, 6-bit mantissa for R and G, and a 5-bit mantissa for B, as shown in the following
    ///illustration.<sup>5,7</sup> <img alt="Illustration of the bits in the three partial-precision floating-point
    ///numbers" src="./images/R11G11B10_FLOAT.png"/>
    DXGI_FORMAT_R11G11B10_FLOAT                         = 0x0000001a,
    ///A four-component, 32-bit typeless format that supports 8 bits per channel including alpha.
    DXGI_FORMAT_R8G8B8A8_TYPELESS                       = 0x0000001b,
    ///A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits per channel including alpha.
    DXGI_FORMAT_R8G8B8A8_UNORM                          = 0x0000001c,
    ///A four-component, 32-bit unsigned-normalized integer sRGB format that supports 8 bits per channel including
    ///alpha.
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB                     = 0x0000001d,
    ///A four-component, 32-bit unsigned-integer format that supports 8 bits per channel including alpha.
    DXGI_FORMAT_R8G8B8A8_UINT                           = 0x0000001e,
    ///A four-component, 32-bit signed-normalized-integer format that supports 8 bits per channel including alpha.
    DXGI_FORMAT_R8G8B8A8_SNORM                          = 0x0000001f,
    ///A four-component, 32-bit signed-integer format that supports 8 bits per channel including alpha.
    DXGI_FORMAT_R8G8B8A8_SINT                           = 0x00000020,
    ///A two-component, 32-bit typeless format that supports 16 bits for the red channel and 16 bits for the green
    ///channel.
    DXGI_FORMAT_R16G16_TYPELESS                         = 0x00000021,
    ///A two-component, 32-bit floating-point format that supports 16 bits for the red channel and 16 bits for the green
    ///channel.<sup>5,7</sup>
    DXGI_FORMAT_R16G16_FLOAT                            = 0x00000022,
    ///A two-component, 32-bit unsigned-normalized-integer format that supports 16 bits each for the green and red
    ///channels.
    DXGI_FORMAT_R16G16_UNORM                            = 0x00000023,
    ///A two-component, 32-bit unsigned-integer format that supports 16 bits for the red channel and 16 bits for the
    ///green channel.
    DXGI_FORMAT_R16G16_UINT                             = 0x00000024,
    ///A two-component, 32-bit signed-normalized-integer format that supports 16 bits for the red channel and 16 bits
    ///for the green channel.
    DXGI_FORMAT_R16G16_SNORM                            = 0x00000025,
    ///A two-component, 32-bit signed-integer format that supports 16 bits for the red channel and 16 bits for the green
    ///channel.
    DXGI_FORMAT_R16G16_SINT                             = 0x00000026,
    ///A single-component, 32-bit typeless format that supports 32 bits for the red channel.
    DXGI_FORMAT_R32_TYPELESS                            = 0x00000027,
    ///A single-component, 32-bit floating-point format that supports 32 bits for depth.<sup>5,8</sup>
    DXGI_FORMAT_D32_FLOAT                               = 0x00000028,
    ///A single-component, 32-bit floating-point format that supports 32 bits for the red channel.<sup>5,8</sup>
    DXGI_FORMAT_R32_FLOAT                               = 0x00000029,
    ///A single-component, 32-bit unsigned-integer format that supports 32 bits for the red channel.
    DXGI_FORMAT_R32_UINT                                = 0x0000002a,
    ///A single-component, 32-bit signed-integer format that supports 32 bits for the red channel.
    DXGI_FORMAT_R32_SINT                                = 0x0000002b,
    ///A two-component, 32-bit typeless format that supports 24 bits for the red channel and 8 bits for the green
    ///channel.
    DXGI_FORMAT_R24G8_TYPELESS                          = 0x0000002c,
    ///A 32-bit z-buffer format that supports 24 bits for depth and 8 bits for stencil.
    DXGI_FORMAT_D24_UNORM_S8_UINT                       = 0x0000002d,
    ///A 32-bit format, that contains a 24 bit, single-component, unsigned-normalized integer, with an additional
    ///typeless 8 bits. This format has 24 bits red channel and 8 bits unused.
    DXGI_FORMAT_R24_UNORM_X8_TYPELESS                   = 0x0000002e,
    ///A 32-bit format, that contains a 24 bit, single-component, typeless format, with an additional 8 bit unsigned
    ///integer component. This format has 24 bits unused and 8 bits green channel.
    DXGI_FORMAT_X24_TYPELESS_G8_UINT                    = 0x0000002f,
    ///A two-component, 16-bit typeless format that supports 8 bits for the red channel and 8 bits for the green
    ///channel.
    DXGI_FORMAT_R8G8_TYPELESS                           = 0x00000030,
    ///A two-component, 16-bit unsigned-normalized-integer format that supports 8 bits for the red channel and 8 bits
    ///for the green channel.
    DXGI_FORMAT_R8G8_UNORM                              = 0x00000031,
    ///A two-component, 16-bit unsigned-integer format that supports 8 bits for the red channel and 8 bits for the green
    ///channel.
    DXGI_FORMAT_R8G8_UINT                               = 0x00000032,
    ///A two-component, 16-bit signed-normalized-integer format that supports 8 bits for the red channel and 8 bits for
    ///the green channel.
    DXGI_FORMAT_R8G8_SNORM                              = 0x00000033,
    ///A two-component, 16-bit signed-integer format that supports 8 bits for the red channel and 8 bits for the green
    ///channel.
    DXGI_FORMAT_R8G8_SINT                               = 0x00000034,
    ///A single-component, 16-bit typeless format that supports 16 bits for the red channel.
    DXGI_FORMAT_R16_TYPELESS                            = 0x00000035,
    ///A single-component, 16-bit floating-point format that supports 16 bits for the red channel.<sup>5,7</sup>
    DXGI_FORMAT_R16_FLOAT                               = 0x00000036,
    ///A single-component, 16-bit unsigned-normalized-integer format that supports 16 bits for depth.
    DXGI_FORMAT_D16_UNORM                               = 0x00000037,
    ///A single-component, 16-bit unsigned-normalized-integer format that supports 16 bits for the red channel.
    DXGI_FORMAT_R16_UNORM                               = 0x00000038,
    ///A single-component, 16-bit unsigned-integer format that supports 16 bits for the red channel.
    DXGI_FORMAT_R16_UINT                                = 0x00000039,
    ///A single-component, 16-bit signed-normalized-integer format that supports 16 bits for the red channel.
    DXGI_FORMAT_R16_SNORM                               = 0x0000003a,
    ///A single-component, 16-bit signed-integer format that supports 16 bits for the red channel.
    DXGI_FORMAT_R16_SINT                                = 0x0000003b,
    ///A single-component, 8-bit typeless format that supports 8 bits for the red channel.
    DXGI_FORMAT_R8_TYPELESS                             = 0x0000003c,
    ///A single-component, 8-bit unsigned-normalized-integer format that supports 8 bits for the red channel.
    DXGI_FORMAT_R8_UNORM                                = 0x0000003d,
    ///A single-component, 8-bit unsigned-integer format that supports 8 bits for the red channel.
    DXGI_FORMAT_R8_UINT                                 = 0x0000003e,
    ///A single-component, 8-bit signed-normalized-integer format that supports 8 bits for the red channel.
    DXGI_FORMAT_R8_SNORM                                = 0x0000003f,
    ///A single-component, 8-bit signed-integer format that supports 8 bits for the red channel.
    DXGI_FORMAT_R8_SINT                                 = 0x00000040,
    ///A single-component, 8-bit unsigned-normalized-integer format for alpha only.
    DXGI_FORMAT_A8_UNORM                                = 0x00000041,
    ///A single-component, 1-bit unsigned-normalized integer format that supports 1 bit for the red channel. ².
    DXGI_FORMAT_R1_UNORM                                = 0x00000042,
    ///Three partial-precision floating-point numbers encoded into a single 32-bit value all sharing the same 5-bit
    ///exponent (variant of s10e5, which is sign bit, 10-bit mantissa, and 5-bit biased (15) exponent). There is no sign
    ///bit, and there is a shared 5-bit biased (15) exponent and a 9-bit mantissa for each channel, as shown in the
    ///following illustration. <sup>6,7</sup>. <img alt="Illustration of the bits in the three partial-precision
    ///floating-point numbers" src="./images/RGBE.png"/>
    DXGI_FORMAT_R9G9B9E5_SHAREDEXP                      = 0x00000043,
    ///A four-component, 32-bit unsigned-normalized-integer format. This packed RGB format is analogous to the UYVY
    ///format. Each 32-bit block describes a pair of pixels: (R8, G8, B8) and (R8, G8, B8) where the R8/B8 values are
    ///repeated, and the G8 values are unique to each pixel. ³ Width must be even.
    DXGI_FORMAT_R8G8_B8G8_UNORM                         = 0x00000044,
    ///A four-component, 32-bit unsigned-normalized-integer format. This packed RGB format is analogous to the YUY2
    ///format. Each 32-bit block describes a pair of pixels: (R8, G8, B8) and (R8, G8, B8) where the R8/B8 values are
    ///repeated, and the G8 values are unique to each pixel. ³ Width must be even.
    DXGI_FORMAT_G8R8_G8B8_UNORM                         = 0x00000045,
    ///Four-component typeless block-compression format. For information about block-compression formats, see Texture
    ///Block Compression in Direct3D 11.
    DXGI_FORMAT_BC1_TYPELESS                            = 0x00000046,
    ///Four-component block-compression format. For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC1_UNORM                               = 0x00000047,
    ///Four-component block-compression format for sRGB data. For information about block-compression formats, see
    ///Texture Block Compression in Direct3D 11.
    DXGI_FORMAT_BC1_UNORM_SRGB                          = 0x00000048,
    ///Four-component typeless block-compression format. For information about block-compression formats, see Texture
    ///Block Compression in Direct3D 11.
    DXGI_FORMAT_BC2_TYPELESS                            = 0x00000049,
    ///Four-component block-compression format. For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC2_UNORM                               = 0x0000004a,
    ///Four-component block-compression format for sRGB data. For information about block-compression formats, see
    ///Texture Block Compression in Direct3D 11.
    DXGI_FORMAT_BC2_UNORM_SRGB                          = 0x0000004b,
    ///Four-component typeless block-compression format. For information about block-compression formats, see Texture
    ///Block Compression in Direct3D 11.
    DXGI_FORMAT_BC3_TYPELESS                            = 0x0000004c,
    ///Four-component block-compression format. For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC3_UNORM                               = 0x0000004d,
    ///Four-component block-compression format for sRGB data. For information about block-compression formats, see
    ///Texture Block Compression in Direct3D 11.
    DXGI_FORMAT_BC3_UNORM_SRGB                          = 0x0000004e,
    ///One-component typeless block-compression format. For information about block-compression formats, see Texture
    ///Block Compression in Direct3D 11.
    DXGI_FORMAT_BC4_TYPELESS                            = 0x0000004f,
    ///One-component block-compression format. For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC4_UNORM                               = 0x00000050,
    ///One-component block-compression format. For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC4_SNORM                               = 0x00000051,
    ///Two-component typeless block-compression format. For information about block-compression formats, see Texture
    ///Block Compression in Direct3D 11.
    DXGI_FORMAT_BC5_TYPELESS                            = 0x00000052,
    ///Two-component block-compression format. For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC5_UNORM                               = 0x00000053,
    ///Two-component block-compression format. For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC5_SNORM                               = 0x00000054,
    ///A three-component, 16-bit unsigned-normalized-integer format that supports 5 bits for blue, 6 bits for green, and
    ///5 bits for red. <b>Direct3D 10 through Direct3D 11: </b>This value is defined for DXGI. However, Direct3D 10,
    ///10.1, or 11 devices do not support this format. <b>Direct3D 11.1: </b>This value is not supported until Windows
    ///8.
    DXGI_FORMAT_B5G6R5_UNORM                            = 0x00000055,
    ///A four-component, 16-bit unsigned-normalized-integer format that supports 5 bits for each color channel and 1-bit
    ///alpha. <b>Direct3D 10 through Direct3D 11: </b>This value is defined for DXGI. However, Direct3D 10, 10.1, or 11
    ///devices do not support this format. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_B5G5R5A1_UNORM                          = 0x00000056,
    ///A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits for each color channel and 8-bit
    ///alpha.
    DXGI_FORMAT_B8G8R8A8_UNORM                          = 0x00000057,
    ///A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits for each color channel and 8
    ///bits unused.
    DXGI_FORMAT_B8G8R8X8_UNORM                          = 0x00000058,
    ///A four-component, 32-bit 2.8-biased fixed-point format that supports 10 bits for each color channel and 2-bit
    ///alpha.
    DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM              = 0x00000059,
    ///A four-component, 32-bit typeless format that supports 8 bits for each channel including alpha. ⁴
    DXGI_FORMAT_B8G8R8A8_TYPELESS                       = 0x0000005a,
    ///A four-component, 32-bit unsigned-normalized standard RGB format that supports 8 bits for each channel including
    ///alpha. ⁴
    DXGI_FORMAT_B8G8R8A8_UNORM_SRGB                     = 0x0000005b,
    ///A four-component, 32-bit typeless format that supports 8 bits for each color channel, and 8 bits are unused. ⁴
    DXGI_FORMAT_B8G8R8X8_TYPELESS                       = 0x0000005c,
    ///A four-component, 32-bit unsigned-normalized standard RGB format that supports 8 bits for each color channel, and
    ///8 bits are unused. ⁴
    DXGI_FORMAT_B8G8R8X8_UNORM_SRGB                     = 0x0000005d,
    ///A typeless block-compression format. ⁴ For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC6H_TYPELESS                           = 0x0000005e,
    ///A block-compression format. ⁴ For information about block-compression formats, see Texture Block Compression in
    ///Direct3D 11.⁵
    DXGI_FORMAT_BC6H_UF16                               = 0x0000005f,
    ///A block-compression format. ⁴ For information about block-compression formats, see Texture Block Compression in
    ///Direct3D 11.⁵
    DXGI_FORMAT_BC6H_SF16                               = 0x00000060,
    ///A typeless block-compression format. ⁴ For information about block-compression formats, see Texture Block
    ///Compression in Direct3D 11.
    DXGI_FORMAT_BC7_TYPELESS                            = 0x00000061,
    ///A block-compression format. ⁴ For information about block-compression formats, see Texture Block Compression in
    ///Direct3D 11.
    DXGI_FORMAT_BC7_UNORM                               = 0x00000062,
    ///A block-compression format. ⁴ For information about block-compression formats, see Texture Block Compression in
    ///Direct3D 11.
    DXGI_FORMAT_BC7_UNORM_SRGB                          = 0x00000063,
    ///Most common YUV 4:4:4 video resource format. Valid view formats for this video resource format are
    ///DXGI_FORMAT_R8G8B8A8_UNORM and DXGI_FORMAT_R8G8B8A8_UINT. For UAVs, an additional valid view format is
    ///DXGI_FORMAT_R32_UINT. By using DXGI_FORMAT_R32_UINT for UAVs, you can both read and write as opposed to just
    ///write for DXGI_FORMAT_R8G8B8A8_UNORM and DXGI_FORMAT_R8G8B8A8_UINT. Supported view types are SRV, RTV, and UAV.
    ///One view provides a straightforward mapping of the entire surface. The mapping to the view channel is V-&gt;R8,
    ///U-&gt;G8, Y-&gt;B8, and A-&gt;A8. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV
    ///Formats for Video Rendering. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_AYUV                                    = 0x00000064,
    ///10-bit per channel packed YUV 4:4:4 video resource format. Valid view formats for this video resource format are
    ///DXGI_FORMAT_R10G10B10A2_UNORM and DXGI_FORMAT_R10G10B10A2_UINT. For UAVs, an additional valid view format is
    ///DXGI_FORMAT_R32_UINT. By using DXGI_FORMAT_R32_UINT for UAVs, you can both read and write as opposed to just
    ///write for DXGI_FORMAT_R10G10B10A2_UNORM and DXGI_FORMAT_R10G10B10A2_UINT. Supported view types are SRV and UAV.
    ///One view provides a straightforward mapping of the entire surface. The mapping to the view channel is U-&gt;R10,
    ///Y-&gt;G10, V-&gt;B10, and A-&gt;A2. For more info about YUV formats for video rendering, see Recommended 8-Bit
    ///YUV Formats for Video Rendering. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_Y410                                    = 0x00000065,
    ///16-bit per channel packed YUV 4:4:4 video resource format. Valid view formats for this video resource format are
    ///DXGI_FORMAT_R16G16B16A16_UNORM and DXGI_FORMAT_R16G16B16A16_UINT. Supported view types are SRV and UAV. One view
    ///provides a straightforward mapping of the entire surface. The mapping to the view channel is U-&gt;R16,
    ///Y-&gt;G16, V-&gt;B16, and A-&gt;A16. For more info about YUV formats for video rendering, see Recommended 8-Bit
    ///YUV Formats for Video Rendering. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_Y416                                    = 0x00000066,
    ///Most common YUV 4:2:0 video resource format. Valid luminance data view formats for this video resource format are
    ///DXGI_FORMAT_R8_UNORM and DXGI_FORMAT_R8_UINT. Valid chrominance data view formats (width and height are each 1/2
    ///of luminance view) for this video resource format are DXGI_FORMAT_R8G8_UNORM and DXGI_FORMAT_R8G8_UINT. Supported
    ///view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y-&gt;R8. For
    ///chrominance data view, the mapping to the view channel is U-&gt;R8 and V-&gt;G8. For more info about YUV formats
    ///for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width and height must be even.
    ///Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2)))
    ///bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes
    ///are the UV plane. An app using the YUY 4:2:0 formats must map the luma (Y) plane separately from the chroma (UV)
    ///planes. Developers do this by calling ID3D12Device::CreateShaderResourceView twice for the same texture and
    ///passing in 1-channel and 2-channel formats. Passing in a 1-channel format compatible with the Y plane maps only
    ///the Y plane. Passing in a 2-channel format compatible with the UV planes (together) maps only the U and V planes
    ///as a single resource view. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_NV12                                    = 0x00000067,
    ///10-bit per channel planar YUV 4:2:0 video resource format. Valid luminance data view formats for this video
    ///resource format are DXGI_FORMAT_R16_UNORM and DXGI_FORMAT_R16_UINT. The runtime does not enforce whether the
    ///lowest 6 bits are 0 (given that this video resource format is a 10-bit format that uses 16 bits). If required,
    ///application shader code would have to enforce this manually. From the runtime's point of view, DXGI_FORMAT_P010
    ///is no different than DXGI_FORMAT_P016. Valid chrominance data view formats (width and height are each 1/2 of
    ///luminance view) for this video resource format are DXGI_FORMAT_R16G16_UNORM and DXGI_FORMAT_R16G16_UINT. For
    ///UAVs, an additional valid chrominance data view format is DXGI_FORMAT_R32_UINT. By using DXGI_FORMAT_R32_UINT for
    ///UAVs, you can both read and write as opposed to just write for DXGI_FORMAT_R16G16_UNORM and
    ///DXGI_FORMAT_R16G16_UINT. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the
    ///view channel is Y-&gt;R16. For chrominance data view, the mapping to the view channel is U-&gt;R16 and V-&gt;G16.
    ///For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width
    ///and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch *
    ///(height + (height / 2))) bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining
    ///(SysMemPitch * (height / 2)) bytes are the UV plane. An app using the YUY 4:2:0 formats must map the luma (Y)
    ///plane separately from the chroma (UV) planes. Developers do this by calling
    ///ID3D12Device::CreateShaderResourceView twice for the same texture and passing in 1-channel and 2-channel formats.
    ///Passing in a 1-channel format compatible with the Y plane maps only the Y plane. Passing in a 2-channel format
    ///compatible with the UV planes (together) maps only the U and V planes as a single resource view. <b>Direct3D
    ///11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_P010                                    = 0x00000068,
    ///16-bit per channel planar YUV 4:2:0 video resource format. Valid luminance data view formats for this video
    ///resource format are DXGI_FORMAT_R16_UNORM and DXGI_FORMAT_R16_UINT. Valid chrominance data view formats (width
    ///and height are each 1/2 of luminance view) for this video resource format are DXGI_FORMAT_R16G16_UNORM and
    ///DXGI_FORMAT_R16G16_UINT. For UAVs, an additional valid chrominance data view format is DXGI_FORMAT_R32_UINT. By
    ///using DXGI_FORMAT_R32_UINT for UAVs, you can both read and write as opposed to just write for
    ///DXGI_FORMAT_R16G16_UNORM and DXGI_FORMAT_R16G16_UINT. Supported view types are SRV, RTV, and UAV. For luminance
    ///data view, the mapping to the view channel is Y-&gt;R16. For chrominance data view, the mapping to the view
    ///channel is U-&gt;R16 and V-&gt;G16. For more info about YUV formats for video rendering, see Recommended 8-Bit
    ///YUV Formats for Video Rendering. Width and height must be even. Direct3D 11 staging resources and initData
    ///parameters for this format use (rowPitch * (height + (height / 2))) bytes. The first (SysMemPitch * height) bytes
    ///are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes are the UV plane. An app using the YUY 4:2:0
    ///formats must map the luma (Y) plane separately from the chroma (UV) planes. Developers do this by calling
    ///ID3D12Device::CreateShaderResourceView twice for the same texture and passing in 1-channel and 2-channel formats.
    ///Passing in a 1-channel format compatible with the Y plane maps only the Y plane. Passing in a 2-channel format
    ///compatible with the UV planes (together) maps only the U and V planes as a single resource view. <b>Direct3D
    ///11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_P016                                    = 0x00000069,
    ///8-bit per channel planar YUV 4:2:0 video resource format. This format is subsampled where each pixel has its own
    ///Y value, but each 2x2 pixel block shares a single U and V value. The runtime requires that the width and height
    ///of all resources that are created with this format are multiples of 2. The runtime also requires that the left,
    ///right, top, and bottom members of any RECT that are used for this format are multiples of 2. This format differs
    ///from DXGI_FORMAT_NV12 in that the layout of the data within the resource is completely opaque to applications.
    ///Applications cannot use the CPU to map the resource and then access the data within the resource. You cannot use
    ///shaders with this format. Because of this behavior, legacy hardware that supports a non-NV12 4:2:0 layout (for
    ///example, YV12, and so on) can be used. Also, new hardware that has a 4:2:0 implementation better than NV12 can be
    ///used when the application does not need the data to be in a standard layout. For more info about YUV formats for
    ///video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width and height must be even. Direct3D
    ///11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. An
    ///app using the YUY 4:2:0 formats must map the luma (Y) plane separately from the chroma (UV) planes. Developers do
    ///this by calling ID3D12Device::CreateShaderResourceView twice for the same texture and passing in 1-channel and
    ///2-channel formats. Passing in a 1-channel format compatible with the Y plane maps only the Y plane. Passing in a
    ///2-channel format compatible with the UV planes (together) maps only the U and V planes as a single resource view.
    ///<b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_420_OPAQUE                              = 0x0000006a,
    ///Most common YUV 4:2:2 video resource format. Valid view formats for this video resource format are
    ///DXGI_FORMAT_R8G8B8A8_UNORM and DXGI_FORMAT_R8G8B8A8_UINT. For UAVs, an additional valid view format is
    ///DXGI_FORMAT_R32_UINT. By using DXGI_FORMAT_R32_UINT for UAVs, you can both read and write as opposed to just
    ///write for DXGI_FORMAT_R8G8B8A8_UNORM and DXGI_FORMAT_R8G8B8A8_UINT. Supported view types are SRV and UAV. One
    ///view provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0-&gt;R8,
    ///U0-&gt;G8, Y1-&gt;B8, and V0-&gt;A8. A unique valid view format for this video resource format is
    ///DXGI_FORMAT_R8G8_B8G8_UNORM. With this view format, the width of the view appears to be twice what the
    ///DXGI_FORMAT_R8G8B8A8_UNORM or DXGI_FORMAT_R8G8B8A8_UINT view would be when hardware reconstructs RGBA
    ///automatically on read and before filtering. This Direct3D hardware behavior is legacy and is likely not useful
    ///any more. With this view format, the mapping to the view channel is Y0-&gt;R8, U0-&gt; G8[0], Y1-&gt;B8, and
    ///V0-&gt; G8[1]. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video
    ///Rendering. Width must be even. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_YUY2                                    = 0x0000006b,
    ///10-bit per channel packed YUV 4:2:2 video resource format. Valid view formats for this video resource format are
    ///DXGI_FORMAT_R16G16B16A16_UNORM and DXGI_FORMAT_R16G16B16A16_UINT. The runtime does not enforce whether the lowest
    ///6 bits are 0 (given that this video resource format is a 10-bit format that uses 16 bits). If required,
    ///application shader code would have to enforce this manually. From the runtime's point of view, DXGI_FORMAT_Y210
    ///is no different than DXGI_FORMAT_Y216. Supported view types are SRV and UAV. One view provides a straightforward
    ///mapping of the entire surface. The mapping to the view channel is Y0-&gt;R16, U-&gt;G16, Y1-&gt;B16, and
    ///V-&gt;A16. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video
    ///Rendering. Width must be even. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_Y210                                    = 0x0000006c,
    ///16-bit per channel packed YUV 4:2:2 video resource format. Valid view formats for this video resource format are
    ///DXGI_FORMAT_R16G16B16A16_UNORM and DXGI_FORMAT_R16G16B16A16_UINT. Supported view types are SRV and UAV. One view
    ///provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0-&gt;R16,
    ///U-&gt;G16, Y1-&gt;B16, and V-&gt;A16. For more info about YUV formats for video rendering, see Recommended 8-Bit
    ///YUV Formats for Video Rendering. Width must be even. <b>Direct3D 11.1: </b>This value is not supported until
    ///Windows 8.
    DXGI_FORMAT_Y216                                    = 0x0000006d,
    ///Most common planar YUV 4:1:1 video resource format. Valid luminance data view formats for this video resource
    ///format are DXGI_FORMAT_R8_UNORM and DXGI_FORMAT_R8_UINT. Valid chrominance data view formats (width and height
    ///are each 1/4 of luminance view) for this video resource format are DXGI_FORMAT_R8G8_UNORM and
    ///DXGI_FORMAT_R8G8_UINT. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the
    ///view channel is Y-&gt;R8. For chrominance data view, the mapping to the view channel is U-&gt;R8 and V-&gt;G8.
    ///For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width
    ///must be a multiple of 4. Direct3D11 staging resources and initData parameters for this format use (rowPitch *
    ///height * 2) bytes. The first (SysMemPitch * height) bytes are the Y plane, the next ((SysMemPitch / 2) * height)
    ///bytes are the UV plane, and the remainder is padding. <b>Direct3D 11.1: </b>This value is not supported until
    ///Windows 8.
    DXGI_FORMAT_NV11                                    = 0x0000006e,
    ///4-bit palletized YUV format that is commonly used for DVD subpicture. For more info about YUV formats for video
    ///rendering, see Recommended 8-Bit YUV Formats for Video Rendering. <b>Direct3D 11.1: </b>This value is not
    ///supported until Windows 8.
    DXGI_FORMAT_AI44                                    = 0x0000006f,
    ///4-bit palletized YUV format that is commonly used for DVD subpicture. For more info about YUV formats for video
    ///rendering, see Recommended 8-Bit YUV Formats for Video Rendering. <b>Direct3D 11.1: </b>This value is not
    ///supported until Windows 8.
    DXGI_FORMAT_IA44                                    = 0x00000070,
    ///8-bit palletized format that is used for palletized RGB data when the processor processes ISDB-T data and for
    ///palletized YUV data when the processor processes BluRay data. For more info about YUV formats for video
    ///rendering, see Recommended 8-Bit YUV Formats for Video Rendering. <b>Direct3D 11.1: </b>This value is not
    ///supported until Windows 8.
    DXGI_FORMAT_P8                                      = 0x00000071,
    ///8-bit palletized format with 8 bits of alpha that is used for palletized YUV data when the processor processes
    ///BluRay data. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video
    ///Rendering. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_A8P8                                    = 0x00000072,
    ///A four-component, 16-bit unsigned-normalized integer format that supports 4 bits for each channel including
    ///alpha. <b>Direct3D 11.1: </b>This value is not supported until Windows 8.
    DXGI_FORMAT_B4G4R4A4_UNORM                          = 0x00000073,
    ///A video format; an 8-bit version of a hybrid planar 4:2:2 format.
    DXGI_FORMAT_P208                                    = 0x00000082,
    ///An 8 bit YCbCrA 4:4 rendering format.
    DXGI_FORMAT_V208                                    = 0x00000083,
    ///An 8 bit YCbCrA 4:4:4:4 rendering format.
    DXGI_FORMAT_V408                                    = 0x00000084,
    DXGI_FORMAT_SAMPLER_FEEDBACK_MIN_MIP_OPAQUE         = 0x000000bd,
    DXGI_FORMAT_SAMPLER_FEEDBACK_MIP_REGION_USED_OPAQUE = 0x000000be,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    DXGI_FORMAT_FORCE_UINT                              = 0xffffffff,
}

alias DXGI_MODE_SCANLINE_ORDER = int;
enum : int
{
    DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED       = 0x00000000,
    DXGI_MODE_SCANLINE_ORDER_PROGRESSIVE       = 0x00000001,
    DXGI_MODE_SCANLINE_ORDER_UPPER_FIELD_FIRST = 0x00000002,
    DXGI_MODE_SCANLINE_ORDER_LOWER_FIELD_FIRST = 0x00000003,
}

alias DXGI_MODE_SCALING = int;
enum : int
{
    DXGI_MODE_SCALING_UNSPECIFIED = 0x00000000,
    DXGI_MODE_SCALING_CENTERED    = 0x00000001,
    DXGI_MODE_SCALING_STRETCHED   = 0x00000002,
}

alias DXGI_MODE_ROTATION = int;
enum : int
{
    DXGI_MODE_ROTATION_UNSPECIFIED = 0x00000000,
    DXGI_MODE_ROTATION_IDENTITY    = 0x00000001,
    DXGI_MODE_ROTATION_ROTATE90    = 0x00000002,
    DXGI_MODE_ROTATION_ROTATE180   = 0x00000003,
    DXGI_MODE_ROTATION_ROTATE270   = 0x00000004,
}

///Flags indicating the memory location of a resource.
alias DXGI_RESIDENCY = int;
enum : int
{
    ///The resource is located in video memory.
    DXGI_RESIDENCY_FULLY_RESIDENT            = 0x00000001,
    ///At least some of the resource is located in CPU memory.
    DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY = 0x00000002,
    ///At least some of the resource has been paged out to the hard drive.
    DXGI_RESIDENCY_EVICTED_TO_DISK           = 0x00000003,
}

///Options for handling pixels in a display surface after calling IDXGISwapChain1::Present1.
alias DXGI_SWAP_EFFECT = int;
enum : int
{
    ///Use this flag to specify the bit-block transfer (bitblt) model and to specify that DXGI discard the contents of
    ///the back buffer after you call IDXGISwapChain1::Present1. This flag is valid for a swap chain with more than one
    ///back buffer, although, applications only have read and write access to buffer 0. Use this flag to enable the
    ///display driver to select the most efficient presentation technique for the swap chain. <b>Direct3D 12: </b>This
    ///enumeration value is never supported. D3D12 apps must using <b>DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL</b> or
    ///<b>DXGI_SWAP_EFFECT_FLIP_DISCARD</b>. <div class="alert"><b>Note</b> There are differences between full screen
    ///exclusive and full screen UWP. If you are porting a Direct3D 11 application to UWP on a Windows PC, be aware that
    ///the use of <b>DXGI_SWAP_EFFECT_DISCARD</b> when creating swap chains does not behave the same way in UWP as it
    ///does in Win32, and its use may be detrimental to GPU performance. This is because UWP applications are forced
    ///into FLIP swap modes (even if other swap modes are set), because this reduces the computation time used by the
    ///memory copies originally done by the older bitblt model. The recommended approach is to manually convert DX11
    ///Discard swap chains to use flip models within UWP, using <b>DXGI_SWAP_EFFECT_FLIP_DISCARD</b> instead of
    ///<b>DXGI_SWAP_EFFECT_DISCARD</b> where possible. Refer to the Example below, and see this article for more
    ///information.</div> <div> </div>
    DXGI_SWAP_EFFECT_DISCARD         = 0x00000000,
    ///Use this flag to specify the bitblt model and to specify that DXGI persist the contents of the back buffer after
    ///you call IDXGISwapChain1::Present1. Use this option to present the contents of the swap chain in order, from the
    ///first buffer (buffer 0) to the last buffer. This flag cannot be used with multisampling. <b>Direct3D 12: </b>This
    ///enumeration value is never supported. D3D12 apps must using <b>DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL</b> or
    ///<b>DXGI_SWAP_EFFECT_FLIP_DISCARD</b>. <div class="alert"><b>Note</b> For best performance, use
    ///<b>DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL</b> instead of <b>DXGI_SWAP_EFFECT_SEQUENTIAL</b>. See this article for more
    ///information.</div> <div> </div>
    DXGI_SWAP_EFFECT_SEQUENTIAL      = 0x00000001,
    ///Use this flag to specify the flip presentation model and to specify that DXGI persist the contents of the back
    ///buffer after you call IDXGISwapChain1::Present1. This flag cannot be used with multisampling. <b>Direct3D 11:
    ///</b>This enumeration value is supported starting with Windows 8.
    DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL = 0x00000003,
    ///Use this flag to specify the flip presentation model and to specify that DXGI discard the contents of the back
    ///buffer after you call IDXGISwapChain1::Present1. This flag cannot be used with multisampling and partial
    ///presentation. See DXGI 1.4 Improvements. <b>Direct3D 11: </b>This enumeration value is supported starting with
    ///Windows 10. <div class="alert"><b>Note</b> Windows Store apps must use <b>DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL</b> or
    ///<b>DXGI_SWAP_EFFECT_FLIP_DISCARD</b>. </div> <div> </div>
    DXGI_SWAP_EFFECT_FLIP_DISCARD    = 0x00000004,
}

///Options for swap-chain behavior.
alias DXGI_SWAP_CHAIN_FLAG = int;
enum : int
{
    ///Set this flag to turn off automatic image rotation; that is, do not perform a rotation when transferring the
    ///contents of the front buffer to the monitor. Use this flag to avoid a bandwidth penalty when an application
    ///expects to handle rotation. This option is valid only during full-screen mode.
    DXGI_SWAP_CHAIN_FLAG_NONPREROTATED                          = 0x00000001,
    ///Set this flag to enable an application to switch modes by calling IDXGISwapChain::ResizeTarget. When switching
    ///from windowed to full-screen mode, the display mode (or monitor resolution) will be changed to match the
    ///dimensions of the application window.
    DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH                      = 0x00000002,
    ///Set this flag to enable an application to render using GDI on a swap chain or a surface. This will allow the
    ///application to call IDXGISurface1::GetDC on the 0th back buffer or a surface. This flag is not applicable for
    ///Direct3D 12.
    DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE                         = 0x00000004,
    ///Set this flag to indicate that the swap chain might contain protected content; therefore, the operating system
    ///supports the creation of the swap chain only when driver and hardware protection is used. If the driver and
    ///hardware do not support content protection, the call to create a resource for the swap chain fails. <b>Direct3D
    ///11: </b>This enumeration value is supported starting with Windows 8.
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT                     = 0x00000008,
    ///Set this flag to indicate that shared resources that are created within the swap chain must be protected by using
    ///the driver’s mechanism for restricting access to shared surfaces. <b>Direct3D 11: </b>This enumeration value is
    ///supported starting with Windows 8.
    DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER        = 0x00000010,
    ///Set this flag to restrict presented content to the local displays. Therefore, the presented content is not
    ///accessible via remote accessing or through the desktop duplication APIs. This flag supports the window content
    ///protection features of Windows. Applications can use this flag to protect their own onscreen window content from
    ///being captured or copied through a specific set of public operating system features and APIs. If you use this
    ///flag with windowed (HWND or <b>IWindow</b>) swap chains where another process created the <b>HWND</b>, the owner
    ///of the <b>HWND</b> must use the SetWindowDisplayAffinity function appropriately in order to allow calls to
    ///IDXGISwapChain::Present or IDXGISwapChain1::Present1 to succeed. <b>Direct3D 11: </b>This enumeration value is
    ///supported starting with Windows 8.
    DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY                           = 0x00000020,
    ///Set this flag to create a waitable object you can use to ensure rendering does not begin while a frame is still
    ///being presented. When this flag is used, the swapchain's latency must be set with the
    ///IDXGISwapChain2::SetMaximumFrameLatency API instead of IDXGIDevice1::SetMaximumFrameLatency. <b>Note</b> This
    ///enumeration value is supported starting with Windows 8.1.
    DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT          = 0x00000040,
    ///Set this flag to create a swap chain in the foreground layer for multi-plane rendering. This flag can only be
    ///used with CoreWindow swap chains, which are created with CreateSwapChainForCoreWindow. Apps should not create
    ///foreground swap chains if IDXGIOutput2::SupportsOverlays indicates that hardware support for overlays is not
    ///available. Note that IDXGISwapChain::ResizeBuffers cannot be used to add or remove this flag. <b>Note</b> This
    ///enumeration value is supported starting with Windows 8.1.
    DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER                       = 0x00000080,
    ///Set this flag to create a swap chain for full-screen video. <b>Note</b> This enumeration value is supported
    ///starting with Windows 8.1.
    DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO                       = 0x00000100,
    ///Set this flag to create a swap chain for YUV video. <b>Note</b> This enumeration value is supported starting with
    ///Windows 8.1.
    DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO                              = 0x00000200,
    ///Indicates that the swap chain should be created such that all underlying resources can be protected by the
    ///hardware. Resource creation will fail if hardware content protection is not supported. This flag has the
    ///following restrictions: <ul> <li>This flag can only be used with swap effect
    ///<b>DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL</b>.</li> </ul> <div class="alert"><b>Note</b> Creating a swap chain using
    ///this flag does not automatically guarantee that hardware protection will be enabled for the underlying
    ///allocation. Some implementations require that the DRM components are first initialized prior to any guarantees of
    ///protection.</div> <div> </div> <b>Note</b> This enumeration value is supported starting with Windows 10.
    DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED                           = 0x00000400,
    ///Tearing support is a requirement to enable displays that support variable refresh rates to function properly when
    ///the application presents a swap chain tied to a full screen borderless window. Win32 apps can already achieve
    ///tearing in fullscreen exclusive mode by calling SetFullscreenState(TRUE), but the recommended approach for Win32
    ///developers is to use this tearing flag instead. This flag requires the use of a <b>DXGI_SWAP_EFFECT_FLIP_*</b>
    ///swap effect. To check for hardware support of this feature, refer to IDXGIFactory5::CheckFeatureSupport. For
    ///usage information refer to IDXGISwapChain::Present and the DXGI_PRESENT flags.
    DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING                          = 0x00000800,
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS = 0x00001000,
}

///Identifies the type of DXGI adapter.
alias DXGI_ADAPTER_FLAG = uint;
enum : uint
{
    ///Specifies no flags.
    DXGI_ADAPTER_FLAG_NONE     = 0x00000000,
    ///Value always set to 0. This flag is reserved.
    DXGI_ADAPTER_FLAG_REMOTE   = 0x00000001,
    ///Specifies a software adapter. For more info about this flag, see new info in Windows 8 about enumerating
    ///adapters. <b>Direct3D 11: </b>This enumeration value is supported starting with Windows 8.
    DXGI_ADAPTER_FLAG_SOFTWARE = 0x00000002,
}

///Identifies the type of pointer shape.
alias DXGI_OUTDUPL_POINTER_SHAPE_TYPE = int;
enum : int
{
    ///The pointer type is a monochrome mouse pointer, which is a monochrome bitmap. The bitmap's size is specified by
    ///width and height in a 1 bits per pixel (bpp) device independent bitmap (DIB) format AND mask that is followed by
    ///another 1 bpp DIB format XOR mask of the same size.
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME   = 0x00000001,
    ///The pointer type is a color mouse pointer, which is a color bitmap. The bitmap's size is specified by width and
    ///height in a 32 bpp ARGB DIB format.
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR        = 0x00000002,
    ///The pointer type is a masked color mouse pointer. A masked color mouse pointer is a 32 bpp ARGB format bitmap
    ///with the mask value in the alpha bits. The only allowed mask values are 0 and 0xFF. When the mask value is 0, the
    ///RGB value should replace the screen pixel. When the mask value is 0xFF, an XOR operation is performed on the RGB
    ///value and the screen pixel; the result replaces the screen pixel.
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR = 0x00000004,
}

///Identifies the alpha value, transparency behavior, of a surface.
alias DXGI_ALPHA_MODE = uint;
enum : uint
{
    ///Indicates that the transparency behavior is not specified.
    DXGI_ALPHA_MODE_UNSPECIFIED   = 0x00000000,
    ///Indicates that the transparency behavior is premultiplied. Each color is first scaled by the alpha value. The
    ///alpha value itself is the same in both straight and premultiplied alpha. Typically, no color channel value is
    ///greater than the alpha channel value. If a color channel value in a premultiplied format is greater than the
    ///alpha channel, the standard source-over blending math results in an additive blend.
    DXGI_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    ///Indicates that the transparency behavior is not premultiplied. The alpha channel indicates the transparency of
    ///the color.
    DXGI_ALPHA_MODE_STRAIGHT      = 0x00000002,
    ///Indicates to ignore the transparency behavior.
    DXGI_ALPHA_MODE_IGNORE        = 0x00000003,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    DXGI_ALPHA_MODE_FORCE_DWORD   = 0xffffffff,
}

///Identifies the importance of a resource’s content when you call the IDXGIDevice2::OfferResources method to offer
///the resource.
alias DXGI_OFFER_RESOURCE_PRIORITY = int;
enum : int
{
    ///The resource is low priority. The operating system discards a low priority resource before other offered
    ///resources with higher priority. It is a good programming practice to mark a resource as low priority if it has no
    ///useful content.
    DXGI_OFFER_RESOURCE_PRIORITY_LOW    = 0x00000001,
    ///The resource is normal priority. You mark a resource as normal priority if it has content that is easy to
    ///regenerate.
    DXGI_OFFER_RESOURCE_PRIORITY_NORMAL = 0x00000002,
    ///The resource is high priority. The operating system discards other offered resources with lower priority before
    ///it discards a high priority resource. You mark a resource as high priority if it has useful content that is
    ///difficult to regenerate.
    DXGI_OFFER_RESOURCE_PRIORITY_HIGH   = 0x00000003,
}

///Identifies resize behavior when the back-buffer size does not match the size of the target output.
alias DXGI_SCALING = int;
enum : int
{
    ///Directs DXGI to make the back-buffer contents scale to fit the presentation target size. This is the implicit
    ///behavior of DXGI when you call the IDXGIFactory::CreateSwapChain method.
    DXGI_SCALING_STRETCH              = 0x00000000,
    ///Directs DXGI to make the back-buffer contents appear without any scaling when the presentation target size is not
    ///equal to the back-buffer size. The top edges of the back buffer and presentation target are aligned together. If
    ///the WS_EX_LAYOUTRTL style is associated with the HWND handle to the target output window, the right edges of the
    ///back buffer and presentation target are aligned together; otherwise, the left edges are aligned together. All
    ///target area outside the back buffer is filled with window background color. This value specifies that all target
    ///areas outside the back buffer of a swap chain are filled with the background color that you specify in a call to
    ///IDXGISwapChain1::SetBackgroundColor.
    DXGI_SCALING_NONE                 = 0x00000001,
    ///Directs DXGI to make the back-buffer contents scale to fit the presentation target size, while preserving the
    ///aspect ratio of the back-buffer. If the scaled back-buffer does not fill the presentation area, it will be
    ///centered with black borders. This constant is supported on Windows Phone 8 and Windows 10. Note that with legacy
    ///Win32 window swapchains, this works the same as DXGI_SCALING_STRETCH.
    DXGI_SCALING_ASPECT_RATIO_STRETCH = 0x00000002,
}

///Identifies the granularity at which the graphics processing unit (GPU) can be preempted from performing its current
///graphics rendering task.
alias DXGI_GRAPHICS_PREEMPTION_GRANULARITY = int;
enum : int
{
    ///Indicates the preemption granularity as a DMA buffer.
    DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY  = 0x00000000,
    ///Indicates the preemption granularity as a graphics primitive. A primitive is a section in a DMA buffer and can be
    ///a group of triangles.
    DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY   = 0x00000001,
    ///Indicates the preemption granularity as a triangle. A triangle is a part of a primitive.
    DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY    = 0x00000002,
    ///Indicates the preemption granularity as a pixel. A pixel is a part of a triangle.
    DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY       = 0x00000003,
    ///Indicates the preemption granularity as a graphics instruction. A graphics instruction operates on a pixel.
    DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY = 0x00000004,
}

///Identifies the granularity at which the graphics processing unit (GPU) can be preempted from performing its current
///compute task.
alias DXGI_COMPUTE_PREEMPTION_GRANULARITY = int;
enum : int
{
    ///Indicates the preemption granularity as a compute packet.
    DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY   = 0x00000000,
    ///Indicates the preemption granularity as a dispatch (for example, a call to the ID3D11DeviceContext::Dispatch
    ///method). A dispatch is a part of a compute packet.
    DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY     = 0x00000001,
    ///Indicates the preemption granularity as a thread group. A thread group is a part of a dispatch.
    DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY = 0x00000002,
    ///Indicates the preemption granularity as a thread in a thread group. A thread is a part of a thread group.
    DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY       = 0x00000003,
    ///Indicates the preemption granularity as a compute instruction in a thread.
    DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY  = 0x00000004,
}

///Options for swap-chain color space.
alias DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS = int;
enum : int
{
    ///Specifies nominal range YCbCr, which isn't an absolute color space, but a way of encoding RGB info.
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE = 0x00000001,
    ///Specifies BT.709, which standardizes the format of high-definition television and has 16:9 (widescreen) aspect
    ///ratio.
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709         = 0x00000002,
    ///Specifies xvYCC or extended-gamut YCC (also x.v.Color) color space that can be used in the video electronics of
    ///television sets to support a gamut 1.8 times as large as that of the sRGB color space.
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC         = 0x00000004,
}

///Indicates options for presenting frames to the swap chain.
alias DXGI_FRAME_PRESENTATION_MODE = int;
enum : int
{
    ///Specifies that the presentation mode is a composition surface, meaning that the conversion from YUV to RGB is
    ///happening once per output refresh (for example, 60 Hz). When this value is returned, the media app should
    ///discontinue use of the decode swap chain and perform YUV to RGB conversion itself, reducing the frequency of YUV
    ///to RGB conversion to once per video frame.
    DXGI_FRAME_PRESENTATION_MODE_COMPOSED            = 0x00000000,
    ///Specifies that the presentation mode is an overlay surface, meaning that the YUV to RGB conversion is happening
    ///efficiently in hardware (once per video frame). When this value is returned, the media app can continue to use
    ///the decode swap chain. See IDXGIDecodeSwapChain.
    DXGI_FRAME_PRESENTATION_MODE_OVERLAY             = 0x00000001,
    ///No presentation is specified.
    DXGI_FRAME_PRESENTATION_MODE_NONE                = 0x00000002,
    ///An issue occurred that caused content protection to be invalidated in a swap-chain with hardware content
    ///protection, and is usually because the system ran out of hardware protected memory. The app will need to do one
    ///of the following: <ul> <li>Drastically reduce the amount of hardware protected memory used. For example, media
    ///applications might be able to reduce their buffering. </li> <li>Stop using hardware protection if possible.</li>
    ///</ul> Note that simply re-creating the swap chain or the device will usually have no impact as the DWM will
    ///continue to run out of memory and will return the same failure.
    DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE = 0x00000003,
}

///Specifies overlay support to check for in a call to IDXGIOutput3::CheckOverlaySupport.
alias DXGI_OVERLAY_SUPPORT_FLAG = int;
enum : int
{
    ///Direct overlay support.
    DXGI_OVERLAY_SUPPORT_FLAG_DIRECT  = 0x00000001,
    ///Scaling overlay support.
    DXGI_OVERLAY_SUPPORT_FLAG_SCALING = 0x00000002,
}

///Specifies color space support for the swap chain.
alias DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG = int;
enum : int
{
    ///Color space support is present.
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT         = 0x00000001,
    ///Overlay color space support is present.
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT = 0x00000002,
}

///Specifies support for overlay color space.
alias DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG = int;
enum : int
{
    ///Overlay color space support is present.
    DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT = 0x00000001,
}

///Specifies the memory segment group to use.
alias DXGI_MEMORY_SEGMENT_GROUP = int;
enum : int
{
    ///The grouping of segments which is considered local to the video adapter, and represents the fastest available
    ///memory to the GPU. Applications should target the local segment group as the target size for their working set.
    DXGI_MEMORY_SEGMENT_GROUP_LOCAL     = 0x00000000,
    ///The grouping of segments which is considered non-local to the video adapter, and may have slower performance than
    ///the local segment group.
    DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL = 0x00000001,
}

alias DXGI_OUTDUPL_FLAG = int;
enum : int
{
    DXGI_OUTDUPL_COMPOSITED_UI_CAPTURE_ONLY = 0x00000001,
}

///Specifies the header metadata type.
alias DXGI_HDR_METADATA_TYPE = int;
enum : int
{
    ///Indicates there is no header metadata.
    DXGI_HDR_METADATA_TYPE_NONE      = 0x00000000,
    ///Indicates the header metadata is held by a DXGI_HDR_METADATA_HDR10 structure.
    DXGI_HDR_METADATA_TYPE_HDR10     = 0x00000001,
    DXGI_HDR_METADATA_TYPE_HDR10PLUS = 0x00000002,
}

///Specifies flags for the OfferResources1 method.
alias DXGI_OFFER_RESOURCE_FLAGS = int;
enum : int
{
    ///Indicates the ability to allow memory de-commit by the DirectX Graphics Kernel.
    DXGI_OFFER_RESOURCE_FLAG_ALLOW_DECOMMIT = 0x00000001,
}

///Specifies result flags for the ReclaimResources1 method.
alias DXGI_RECLAIM_RESOURCE_RESULTS = int;
enum : int
{
    ///The surface was successfully reclaimed and has valid content. This result is identical to the <i>false</i> value
    ///returned by the older ReclaimResources API.
    DXGI_RECLAIM_RESOURCE_RESULT_OK            = 0x00000000,
    ///The surface was reclaimed, but the old content was lost and must be regenerated. This result is identical to the
    ///<i>true</i> value returned by the older ReclaimResources API.
    DXGI_RECLAIM_RESOURCE_RESULT_DISCARDED     = 0x00000001,
    ///Both the surface and its contents are lost and invalid. The surface must be recreated and the content regenerated
    ///in order to be used. All future use of that resource is invalid. Attempts to bind it to the pipeline or map a
    ///resource which returns this value will never succeed, and the resource cannot be reclaimed again.
    DXGI_RECLAIM_RESOURCE_RESULT_NOT_COMMITTED = 0x00000002,
}

///Specifies a range of hardware features, to be used when checking for feature support.
alias DXGI_FEATURE = int;
enum : int
{
    ///The display supports tearing, a requirement of variable refresh rate displays.
    DXGI_FEATURE_PRESENT_ALLOW_TEARING = 0x00000000,
}

///Identifies the type of DXGI adapter.
alias DXGI_ADAPTER_FLAG3 = uint;
enum : uint
{
    ///Specifies no flags.
    DXGI_ADAPTER_FLAG3_NONE                         = 0x00000000,
    ///Value always set to 0. This flag is reserved.
    DXGI_ADAPTER_FLAG3_REMOTE                       = 0x00000001,
    ///Specifies a software adapter. For more info about this flag, see new info in Windows 8 about enumerating
    ///adapters. <b>Direct3D 11: </b>This enumeration value is supported starting with Windows 8.
    DXGI_ADAPTER_FLAG3_SOFTWARE                     = 0x00000002,
    ///Specifies that the adapter's driver has been confirmed to work in an OS process where Arbitrary Code Guard (ACG)
    ///is enabled (i.e. dynamic code generation is disallowed).
    DXGI_ADAPTER_FLAG3_ACG_COMPATIBLE               = 0x00000004,
    ///Specifies that the adapter supports monitored fences. These adapters support the ID3D12Device::CreateFence and
    ///ID3D11Device5::CreateFence functions.
    DXGI_ADAPTER_FLAG3_SUPPORT_MONITORED_FENCES     = 0x00000008,
    ///Specifies that the adapter supports non-monitored fences. These adapters support the ID3D12Device::CreateFence
    ///function together with the D3D12_FENCE_FLAG_NON_MONITORED flag. <div class="alert"><b>Note</b> For adapters that
    ///support both monitored and non-monitored fences, non-monitored fences are only supported when created with the
    ///D3D12_FENCE_FLAG_SHARED and <b>D3D12_FENCE_FLAG_SHARED_CROSS_ADAPTER</b> flags. Monitored fences should always be
    ///used by supporting adapters unless communicating with an adapter that only supports non-monitored fences.</div>
    ///<div> </div>
    DXGI_ADAPTER_FLAG3_SUPPORT_NON_MONITORED_FENCES = 0x00000010,
    ///Specifies that the adapter claims keyed mutex conformance. This signals a stronger guarantee that the
    ///IDXGIKeyedMutex interface behaves correctly.
    DXGI_ADAPTER_FLAG3_KEYED_MUTEX_CONFORMANCE      = 0x00000020,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. This value is not used.
    DXGI_ADAPTER_FLAG3_FORCE_DWORD                  = 0xffffffff,
}

///Describes which levels of hardware composition are supported.
alias DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS = int;
enum : int
{
    ///This flag specifies that swapchain composition can be facilitated in a performant manner using hardware for
    ///fullscreen applications.
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_FULLSCREEN       = 0x00000001,
    ///This flag specifies that swapchain composition can be facilitated in a performant manner using hardware for
    ///windowed applications.
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_WINDOWED         = 0x00000002,
    ///This flag specifies that swapchain composition facilitated using hardware can cause the cursor to appear
    ///stretched.
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_CURSOR_STRETCHED = 0x00000004,
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] The preference of GPU for the app to run on.
alias DXGI_GPU_PREFERENCE = int;
enum : int
{
    ///No preference of GPU.
    DXGI_GPU_PREFERENCE_UNSPECIFIED      = 0x00000000,
    ///Preference for the minimum-powered GPU (such as an integrated graphics processor, or iGPU).
    DXGI_GPU_PREFERENCE_MINIMUM_POWER    = 0x00000001,
    ///Preference for the highest performing GPU, such as a discrete graphics processor (dGPU) or external graphics
    ///processor (xGPU).
    DXGI_GPU_PREFERENCE_HIGH_PERFORMANCE = 0x00000002,
}

///Flags used with ReportLiveObjects to specify the amount of info to report about an object's lifetime.
alias DXGI_DEBUG_RLO_FLAGS = int;
enum : int
{
    ///A flag that specifies to obtain a summary about an object's lifetime.
    DXGI_DEBUG_RLO_SUMMARY         = 0x00000001,
    ///A flag that specifies to obtain detailed info about an object's lifetime.
    DXGI_DEBUG_RLO_DETAIL          = 0x00000002,
    ///This flag indicates to ignore objects which have no external refcounts keeping them alive. D3D objects are
    ///printed using an external refcount and an internal refcount. Typically, all objects are printed. This flag means
    ///ignore the objects whose external refcount is 0, because the application is not responsible for keeping them
    ///alive.
    DXGI_DEBUG_RLO_IGNORE_INTERNAL = 0x00000004,
    ///A flag that specifies to obtain both a summary and detailed info about an object's lifetime.
    DXGI_DEBUG_RLO_ALL             = 0x00000007,
}

///Values that specify categories of debug messages.
alias DXGI_INFO_QUEUE_MESSAGE_CATEGORY = int;
enum : int
{
    ///Unknown category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_UNKNOWN               = 0x00000000,
    ///Miscellaneous category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_MISCELLANEOUS         = 0x00000001,
    ///Initialization category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_INITIALIZATION        = 0x00000002,
    ///Cleanup category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_CLEANUP               = 0x00000003,
    ///Compilation category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_COMPILATION           = 0x00000004,
    ///State creation category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_CREATION        = 0x00000005,
    ///State setting category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_SETTING         = 0x00000006,
    ///State getting category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_GETTING         = 0x00000007,
    ///Resource manipulation category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 0x00000008,
    ///Execution category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_EXECUTION             = 0x00000009,
    ///Shader category.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_SHADER                = 0x0000000a,
}

///Values that specify debug message severity levels for an information queue.
alias DXGI_INFO_QUEUE_MESSAGE_SEVERITY = int;
enum : int
{
    ///Defines some type of corruption that has occurred.
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    ///Defines an error message.
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    ///Defines a warning message.
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    ///Defines an information message.
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_INFO       = 0x00000003,
    ///Defines a message other than corruption, error, warning, or information.
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}

// Constants


enum : uint
{
    DXGI_USAGE_SHADER_INPUT         = 0x00000010,
    DXGI_USAGE_RENDER_TARGET_OUTPUT = 0x00000020,
}

enum : uint
{
    DXGI_USAGE_SHARED             = 0x00000080,
    DXGI_USAGE_READ_ONLY          = 0x00000100,
    DXGI_USAGE_DISCARD_ON_PRESENT = 0x00000200,
}

enum : uint
{
    DXGI_RESOURCE_PRIORITY_MINIMUM = 0x28000000,
    DXGI_RESOURCE_PRIORITY_LOW     = 0x50000000,
    DXGI_RESOURCE_PRIORITY_NORMAL  = 0x78000000,
    DXGI_RESOURCE_PRIORITY_HIGH    = 0xa0000000,
    DXGI_RESOURCE_PRIORITY_MAXIMUM = 0xc8000000,
}

enum : uint
{
    DXGI_MAP_WRITE   = 0x00000002,
    DXGI_MAP_DISCARD = 0x00000004,
}

enum uint DXGI_ENUM_MODES_SCALING = 0x00000002;

enum : uint
{
    DXGI_PRESENT_TEST                  = 0x00000001,
    DXGI_PRESENT_DO_NOT_SEQUENCE       = 0x00000002,
    DXGI_PRESENT_RESTART               = 0x00000004,
    DXGI_PRESENT_DO_NOT_WAIT           = 0x00000008,
    DXGI_PRESENT_STEREO_PREFER_RIGHT   = 0x00000010,
    DXGI_PRESENT_STEREO_TEMPORARY_MONO = 0x00000020,
}

enum : uint
{
    DXGI_PRESENT_USE_DURATION  = 0x00000100,
    DXGI_PRESENT_ALLOW_TEARING = 0x00000200,
}

enum : uint
{
    DXGI_MWA_NO_ALT_ENTER    = 0x00000002,
    DXGI_MWA_NO_PRINT_SCREEN = 0x00000004,
}

// Structs


///Represents a rational number.
struct DXGI_RATIONAL
{
    ///Type: <b>UINT</b> An unsigned integer value representing the top of the rational number.
    uint Numerator;
    ///Type: <b>UINT</b> An unsigned integer value representing the bottom of the rational number.
    uint Denominator;
}

///Describes multi-sampling parameters for a resource.
struct DXGI_SAMPLE_DESC
{
    ///Type: <b>UINT</b> The number of multisamples per pixel.
    uint Count;
    ///Type: <b>UINT</b> The image quality level. The higher the quality, the lower the performance. The valid range is
    ///between zero and one less than the level returned by ID3D10Device::CheckMultisampleQualityLevels for Direct3D 10
    ///or ID3D11Device::CheckMultisampleQualityLevels for Direct3D 11. For Direct3D 10.1 and Direct3D 11, you can use
    ///two special quality level values. For more information about these quality level values, see Remarks.
    uint Quality;
}

struct DXGI_RGB
{
    float Red;
    float Green;
    float Blue;
}

struct DXGI_RGBA
{
    float r;
    float g;
    float b;
    float a;
}

struct DXGI_GAMMA_CONTROL
{
    DXGI_RGB       Scale;
    DXGI_RGB       Offset;
    DXGI_RGB[1025] GammaCurve;
}

struct DXGI_GAMMA_CONTROL_CAPABILITIES
{
    BOOL        ScaleAndOffsetSupported;
    float       MaxConvertedValue;
    float       MinConvertedValue;
    uint        NumGammaControlPoints;
    float[1025] ControlPointPositions;
}

struct DXGI_MODE_DESC
{
    uint              Width;
    uint              Height;
    DXGI_RATIONAL     RefreshRate;
    DXGI_FORMAT       Format;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
}

struct DXGI_JPEG_DC_HUFFMAN_TABLE
{
    ubyte[12] CodeCounts;
    ubyte[12] CodeValues;
}

struct DXGI_JPEG_AC_HUFFMAN_TABLE
{
    ubyte[16]  CodeCounts;
    ubyte[162] CodeValues;
}

struct DXGI_JPEG_QUANTIZATION_TABLE
{
    ubyte[64] Elements;
}

///Describes timing and presentation statistics for a frame.
struct DXGI_FRAME_STATISTICS
{
    ///Type: <b>UINT</b> A value that represents the running total count of times that an image was presented to the
    ///monitor since the computer booted. <div class="alert"><b>Note</b> The number of times that an image was presented
    ///to the monitor is not necessarily the same as the number of times that you called IDXGISwapChain::Present or
    ///IDXGISwapChain1::Present1.</div> <div> </div>
    uint          PresentCount;
    ///Type: <b>UINT</b> A value that represents the running total count of v-blanks at which the last image was
    ///presented to the monitor and that have happened since the computer booted (for windowed mode, since the swap
    ///chain was created).
    uint          PresentRefreshCount;
    ///Type: <b>UINT</b> A value that represents the running total count of v-blanks when the scheduler last sampled the
    ///machine time by calling QueryPerformanceCounter and that have happened since the computer booted (for windowed
    ///mode, since the swap chain was created).
    uint          SyncRefreshCount;
    ///Type: <b>LARGE_INTEGER</b> A value that represents the high-resolution performance counter timer. This value is
    ///the same as the value returned by the QueryPerformanceCounter function.
    LARGE_INTEGER SyncQPCTime;
    ///Type: <b>LARGE_INTEGER</b> Reserved. Always returns 0.
    LARGE_INTEGER SyncGPUTime;
}

///Describes a mapped rectangle that is used to access a surface.
struct DXGI_MAPPED_RECT
{
    ///Type: <b>INT</b> A value that describes the width, in bytes, of the surface.
    int    Pitch;
    ///Type: <b>BYTE*</b> A pointer to the image buffer of the surface.
    ubyte* pBits;
}

///Describes an adapter (or video card) by using DXGI 1.0.
struct DXGI_ADAPTER_DESC
{
    ///Type: <b>WCHAR[128]</b> A string that contains the adapter description. On feature level 9 graphics hardware,
    ///GetDesc returns “Software Adapter” for the description string.
    ushort[128] Description;
    ///Type: <b>UINT</b> The PCI ID of the hardware vendor. On feature level 9 graphics hardware, GetDesc returns zeros
    ///for the PCI ID of the hardware vendor.
    uint        VendorId;
    ///Type: <b>UINT</b> The PCI ID of the hardware device. On feature level 9 graphics hardware, GetDesc returns zeros
    ///for the PCI ID of the hardware device.
    uint        DeviceId;
    ///Type: <b>UINT</b> The PCI ID of the sub system. On feature level 9 graphics hardware, GetDesc returns zeros for
    ///the PCI ID of the sub system.
    uint        SubSysId;
    ///Type: <b>UINT</b> The PCI ID of the revision number of the adapter. On feature level 9 graphics hardware, GetDesc
    ///returns zeros for the PCI ID of the revision number of the adapter.
    uint        Revision;
    ///Type: <b>SIZE_T</b> The number of bytes of dedicated video memory that are not shared with the CPU.
    size_t      DedicatedVideoMemory;
    ///Type: <b>SIZE_T</b> The number of bytes of dedicated system memory that are not shared with the CPU. This memory
    ///is allocated from available system memory at boot time.
    size_t      DedicatedSystemMemory;
    ///Type: <b>SIZE_T</b> The number of bytes of shared system memory. This is the maximum value of system memory that
    ///may be consumed by the adapter during operation. Any incidental memory consumed by the driver as it manages and
    ///uses video memory is additional.
    size_t      SharedSystemMemory;
    ///Type: <b>LUID</b> A unique value that identifies the adapter. See LUID for a definition of the structure.
    ///<b>LUID</b> is defined in dxgi.h.
    LUID        AdapterLuid;
}

///Describes an output or physical connection between the adapter (video card) and a device.
struct DXGI_OUTPUT_DESC
{
    ///Type: <b>WCHAR[32]</b> A string that contains the name of the output device.
    ushort[32]         DeviceName;
    ///Type: <b>RECT</b> A RECT structure containing the bounds of the output in desktop coordinates. Desktop
    ///coordinates depend on the dots per inch (DPI) of the desktop. For info about writing DPI-aware Win32 apps, see
    ///High DPI.
    RECT               DesktopCoordinates;
    ///Type: <b>BOOL</b> True if the output is attached to the desktop; otherwise, false.
    BOOL               AttachedToDesktop;
    ///Type: <b>DXGI_MODE_ROTATION</b> A member of the DXGI_MODE_ROTATION enumerated type describing on how an image is
    ///rotated by the output.
    DXGI_MODE_ROTATION Rotation;
    ///Type: <b>HMONITOR</b> An HMONITOR handle that represents the display monitor. For more information, see HMONITOR
    ///and the Device Context.
    HMONITOR           Monitor;
}

///Represents a handle to a shared resource.
struct DXGI_SHARED_RESOURCE
{
    ///Type: <b>HANDLE</b> A handle to a shared resource.
    HANDLE Handle;
}

///Describes a surface.
struct DXGI_SURFACE_DESC
{
    ///Type: <b>UINT</b> A value describing the surface width.
    uint             Width;
    ///Type: <b>UINT</b> A value describing the surface height.
    uint             Height;
    ///Type: <b>DXGI_FORMAT</b> A member of the DXGI_FORMAT enumerated type that describes the surface format.
    DXGI_FORMAT      Format;
    ///Type: <b>DXGI_SAMPLE_DESC</b> A member of the DXGI_SAMPLE_DESC structure that describes multi-sampling parameters
    ///for the surface.
    DXGI_SAMPLE_DESC SampleDesc;
}

///Describes a swap chain.
struct DXGI_SWAP_CHAIN_DESC
{
    ///Type: <b>DXGI_MODE_DESC</b> A DXGI_MODE_DESC structure that describes the backbuffer display mode.
    DXGI_MODE_DESC   BufferDesc;
    ///Type: <b>DXGI_SAMPLE_DESC</b> A DXGI_SAMPLE_DESC structure that describes multi-sampling parameters.
    DXGI_SAMPLE_DESC SampleDesc;
    ///Type: <b>DXGI_USAGE</b> A member of the DXGI_USAGE enumerated type that describes the surface usage and CPU
    ///access options for the back buffer. The back buffer can be used for shader input or render-target output.
    uint             BufferUsage;
    ///Type: <b>UINT</b> A value that describes the number of buffers in the swap chain. When you call
    ///IDXGIFactory::CreateSwapChain to create a full-screen swap chain, you typically include the front buffer in this
    ///value. For more information about swap-chain buffers, see Remarks.
    uint             BufferCount;
    ///Type: <b>HWND</b> An HWND handle to the output window. This member must not be <b>NULL</b>.
    HWND             OutputWindow;
    ///Type: <b>BOOL</b> A Boolean value that specifies whether the output is in windowed mode. <b>TRUE</b> if the
    ///output is in windowed mode; otherwise, <b>FALSE</b>. We recommend that you create a windowed swap chain and allow
    ///the end user to change the swap chain to full screen through IDXGISwapChain::SetFullscreenState; that is, do not
    ///set this member to FALSE to force the swap chain to be full screen. However, if you create the swap chain as full
    ///screen, also provide the end user with a list of supported display modes through the <b>BufferDesc</b> member
    ///because a swap chain that is created with an unsupported display mode might cause the display to go black and
    ///prevent the end user from seeing anything. For more information about choosing windowed verses full screen, see
    ///IDXGIFactory::CreateSwapChain.
    BOOL             Windowed;
    ///Type: <b>DXGI_SWAP_EFFECT</b> A member of the DXGI_SWAP_EFFECT enumerated type that describes options for
    ///handling the contents of the presentation buffer after presenting a surface.
    DXGI_SWAP_EFFECT SwapEffect;
    ///Type: <b>UINT</b> A member of the DXGI_SWAP_CHAIN_FLAG enumerated type that describes options for swap-chain
    ///behavior.
    uint             Flags;
}

///Describes an adapter (or video card) using DXGI 1.1.
struct DXGI_ADAPTER_DESC1
{
    ///Type: <b>WCHAR[128]</b> A string that contains the adapter description. On feature level 9 graphics hardware,
    ///GetDesc1 returns “Software Adapter” for the description string.
    ushort[128] Description;
    ///Type: <b>UINT</b> The PCI ID of the hardware vendor. On feature level 9 graphics hardware, GetDesc1 returns zeros
    ///for the PCI ID of the hardware vendor.
    uint        VendorId;
    ///Type: <b>UINT</b> The PCI ID of the hardware device. On feature level 9 graphics hardware, GetDesc1 returns zeros
    ///for the PCI ID of the hardware device.
    uint        DeviceId;
    ///Type: <b>UINT</b> The PCI ID of the sub system. On feature level 9 graphics hardware, GetDesc1 returns zeros for
    ///the PCI ID of the sub system.
    uint        SubSysId;
    ///Type: <b>UINT</b> The PCI ID of the revision number of the adapter. On feature level 9 graphics hardware,
    ///GetDesc1 returns zeros for the PCI ID of the revision number of the adapter.
    uint        Revision;
    ///Type: <b>SIZE_T</b> The number of bytes of dedicated video memory that are not shared with the CPU.
    size_t      DedicatedVideoMemory;
    ///Type: <b>SIZE_T</b> The number of bytes of dedicated system memory that are not shared with the CPU. This memory
    ///is allocated from available system memory at boot time.
    size_t      DedicatedSystemMemory;
    ///Type: <b>SIZE_T</b> The number of bytes of shared system memory. This is the maximum value of system memory that
    ///may be consumed by the adapter during operation. Any incidental memory consumed by the driver as it manages and
    ///uses video memory is additional.
    size_t      SharedSystemMemory;
    ///Type: <b>LUID</b> A unique value that identifies the adapter. See LUID for a definition of the structure.
    ///<b>LUID</b> is defined in dxgi.h.
    LUID        AdapterLuid;
    ///Type: <b>UINT</b> A value of the DXGI_ADAPTER_FLAG enumerated type that describes the adapter type. The
    ///<b>DXGI_ADAPTER_FLAG_REMOTE</b> flag is reserved.
    uint        Flags;
}

///Don't use this structure; it is not supported and it will be removed from the header in a future release.
struct DXGI_DISPLAY_COLOR_SPACE
{
    ///The primary coordinates, as an 8 by 2 array of FLOAT values.
    float[16] PrimaryCoordinates;
    ///The white points, as a 16 by 2 array of FLOAT values.
    float[32] WhitePoints;
}

///The <b>DXGI_OUTDUPL_MOVE_RECT</b> structure describes the movement of a rectangle.
struct DXGI_OUTDUPL_MOVE_RECT
{
    ///The starting position of a rectangle.
    POINT SourcePoint;
    ///The target region to which to move a rectangle.
    RECT  DestinationRect;
}

///The DXGI_OUTDUPL_DESC structure describes the dimension of the output and the surface that contains the desktop
///image. The format of the desktop image is always DXGI_FORMAT_B8G8R8A8_UNORM.
struct DXGI_OUTDUPL_DESC
{
    ///A DXGI_MODE_DESC structure that describes the display mode of the duplicated output.
    DXGI_MODE_DESC     ModeDesc;
    ///A member of the DXGI_MODE_ROTATION enumerated type that describes how the duplicated output rotates an image.
    DXGI_MODE_ROTATION Rotation;
    ///Specifies whether the resource that contains the desktop image is already located in system memory. <b>TRUE</b>
    ///if the resource is in system memory; otherwise, <b>FALSE</b>. If this value is <b>TRUE</b> and the application
    ///requires CPU access, it can use the IDXGIOutputDuplication::MapDesktopSurface and
    ///IDXGIOutputDuplication::UnMapDesktopSurface methods to avoid copying the data into a staging buffer.
    BOOL               DesktopImageInSystemMemory;
}

///The <b>DXGI_OUTDUPL_POINTER_POSITION</b> structure describes the position of the hardware cursor.
struct DXGI_OUTDUPL_POINTER_POSITION
{
    ///The position of the hardware cursor relative to the top-left of the adapter output.
    POINT Position;
    ///Specifies whether the hardware cursor is visible. <b>TRUE</b> if visible; otherwise, <b>FALSE</b>. If the
    ///hardware cursor is not visible, the calling application does not display the cursor in the client.
    BOOL  Visible;
}

///The <b>DXGI_OUTDUPL_POINTER_SHAPE_INFO</b> structure describes information about the cursor shape.
struct DXGI_OUTDUPL_POINTER_SHAPE_INFO
{
    ///A DXGI_OUTDUPL_POINTER_SHAPE_TYPE-typed value that specifies the type of cursor shape.
    uint  Type;
    ///The width in pixels of the mouse cursor.
    uint  Width;
    ///The height in scan lines of the mouse cursor.
    uint  Height;
    ///The width in bytes of the mouse cursor.
    uint  Pitch;
    ///The position of the cursor's hot spot relative to its upper-left pixel. An application does not use the hot spot
    ///when it determines where to draw the cursor shape.
    POINT HotSpot;
}

///The <b>DXGI_OUTDUPL_FRAME_INFO</b> structure describes the current desktop image.
struct DXGI_OUTDUPL_FRAME_INFO
{
    ///The time stamp of the last update of the desktop image. The operating system calls the QueryPerformanceCounter
    ///function to obtain the value. A zero value indicates that the desktop image was not updated since an application
    ///last called the IDXGIOutputDuplication::AcquireNextFrame method to acquire the next frame of the desktop image.
    LARGE_INTEGER LastPresentTime;
    ///The time stamp of the last update to the mouse. The operating system calls the QueryPerformanceCounter function
    ///to obtain the value. A zero value indicates that the position or shape of the mouse was not updated since an
    ///application last called the IDXGIOutputDuplication::AcquireNextFrame method to acquire the next frame of the
    ///desktop image. The mouse position is always supplied for a mouse update. A new pointer shape is indicated by a
    ///non-zero value in the <b>PointerShapeBufferSize</b> member.
    LARGE_INTEGER LastMouseUpdateTime;
    ///The number of frames that the operating system accumulated in the desktop image surface since the calling
    ///application processed the last desktop image. For more information about this number, see Remarks.
    uint          AccumulatedFrames;
    ///Specifies whether the operating system accumulated updates by coalescing dirty regions. Therefore, the dirty
    ///regions might contain unmodified pixels. <b>TRUE</b> if dirty regions were accumulated; otherwise, <b>FALSE</b>.
    BOOL          RectsCoalesced;
    ///Specifies whether the desktop image might contain protected content that was already blacked out in the desktop
    ///image. <b>TRUE</b> if protected content was already blacked; otherwise, <b>FALSE</b>. The application can use
    ///this information to notify the remote user that some of the desktop content might be protected and therefore not
    ///visible.
    BOOL          ProtectedContentMaskedOut;
    ///A DXGI_OUTDUPL_POINTER_POSITION structure that describes the most recent mouse position if the
    ///<b>LastMouseUpdateTime</b> member is a non-zero value; otherwise, this value is ignored. This value provides the
    ///coordinates of the location where the top-left-hand corner of the pointer shape is drawn; this value is not the
    ///desktop position of the hot spot.
    DXGI_OUTDUPL_POINTER_POSITION PointerPosition;
    ///Size in bytes of the buffers to store all the desktop update metadata for this frame. For more information about
    ///this size, see Remarks.
    uint          TotalMetadataBufferSize;
    ///Size in bytes of the buffer to hold the new pixel data for the mouse shape. For more information about this size,
    ///see Remarks.
    uint          PointerShapeBufferSize;
}

///Describes a display mode and whether the display mode supports stereo.
struct DXGI_MODE_DESC1
{
    ///A value that describes the resolution width.
    uint              Width;
    ///A value that describes the resolution height.
    uint              Height;
    ///A DXGI_RATIONAL structure that describes the refresh rate in hertz.
    DXGI_RATIONAL     RefreshRate;
    ///A DXGI_FORMAT-typed value that describes the display format.
    DXGI_FORMAT       Format;
    ///A DXGI_MODE_SCANLINE_ORDER-typed value that describes the scan-line drawing mode.
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    ///A DXGI_MODE_SCALING-typed value that describes the scaling mode.
    DXGI_MODE_SCALING Scaling;
    ///Specifies whether the full-screen display mode is stereo. <b>TRUE</b> if stereo; otherwise, <b>FALSE</b>.
    BOOL              Stereo;
}

///Describes a swap chain.
struct DXGI_SWAP_CHAIN_DESC1
{
    ///A value that describes the resolution width. If you specify the width as zero when you call the
    ///IDXGIFactory2::CreateSwapChainForHwnd method to create a swap chain, the runtime obtains the width from the
    ///output window and assigns this width value to the swap-chain description. You can subsequently call the
    ///IDXGISwapChain1::GetDesc1 method to retrieve the assigned width value. You cannot specify the width as zero when
    ///you call the IDXGIFactory2::CreateSwapChainForComposition method.
    uint             Width;
    ///A value that describes the resolution height. If you specify the height as zero when you call the
    ///IDXGIFactory2::CreateSwapChainForHwnd method to create a swap chain, the runtime obtains the height from the
    ///output window and assigns this height value to the swap-chain description. You can subsequently call the
    ///IDXGISwapChain1::GetDesc1 method to retrieve the assigned height value. You cannot specify the height as zero
    ///when you call the IDXGIFactory2::CreateSwapChainForComposition method.
    uint             Height;
    ///A DXGI_FORMAT structure that describes the display format.
    DXGI_FORMAT      Format;
    ///Specifies whether the full-screen display mode or the swap-chain back buffer is stereo. <b>TRUE</b> if stereo;
    ///otherwise, <b>FALSE</b>. If you specify stereo, you must also specify a flip-model swap chain (that is, a swap
    ///chain that has the DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL value set in the <b>SwapEffect</b> member).
    BOOL             Stereo;
    ///A DXGI_SAMPLE_DESC structure that describes multi-sampling parameters. This member is valid only with bit-block
    ///transfer (bitblt) model swap chains.
    DXGI_SAMPLE_DESC SampleDesc;
    ///A DXGI_USAGE-typed value that describes the surface usage and CPU access options for the back buffer. The back
    ///buffer can be used for shader input or render-target output.
    uint             BufferUsage;
    ///A value that describes the number of buffers in the swap chain. When you create a full-screen swap chain, you
    ///typically include the front buffer in this value.
    uint             BufferCount;
    ///A DXGI_SCALING-typed value that identifies resize behavior if the size of the back buffer is not equal to the
    ///target output.
    DXGI_SCALING     Scaling;
    ///A DXGI_SWAP_EFFECT-typed value that describes the presentation model that is used by the swap chain and options
    ///for handling the contents of the presentation buffer after presenting a surface. You must specify the
    ///DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL value when you call the IDXGIFactory2::CreateSwapChainForComposition method
    ///because this method supports only <a href="/windows/desktop/direct3ddxgi/dxgi-flip-model">flip presentation
    ///model</a>.
    DXGI_SWAP_EFFECT SwapEffect;
    ///A DXGI_ALPHA_MODE-typed value that identifies the transparency behavior of the swap-chain back buffer.
    DXGI_ALPHA_MODE  AlphaMode;
    ///A combination of DXGI_SWAP_CHAIN_FLAG-typed values that are combined by using a bitwise OR operation. The
    ///resulting value specifies options for swap-chain behavior.
    uint             Flags;
}

///Describes full-screen mode for a swap chain.
struct DXGI_SWAP_CHAIN_FULLSCREEN_DESC
{
    ///A DXGI_RATIONAL structure that describes the refresh rate in hertz.
    DXGI_RATIONAL     RefreshRate;
    ///A member of the DXGI_MODE_SCANLINE_ORDER enumerated type that describes the scan-line drawing mode.
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    ///A member of the DXGI_MODE_SCALING enumerated type that describes the scaling mode.
    DXGI_MODE_SCALING Scaling;
    ///A Boolean value that specifies whether the swap chain is in windowed mode. <b>TRUE</b> if the swap chain is in
    ///windowed mode; otherwise, <b>FALSE</b>.
    BOOL              Windowed;
}

///Describes information about present that helps the operating system optimize presentation.
struct DXGI_PRESENT_PARAMETERS
{
    ///The number of updated rectangles that you update in the back buffer for the presented frame. The operating system
    ///uses this information to optimize presentation. You can set this member to 0 to indicate that you update the
    ///whole frame.
    uint   DirtyRectsCount;
    ///A list of updated rectangles that you update in the back buffer for the presented frame. An application must
    ///update every single pixel in each rectangle that it reports to the runtime; the application cannot assume that
    ///the pixels are saved from the previous frame. For more information about updating dirty rectangles, see Remarks.
    ///You can set this member to <b>NULL</b> if <b>DirtyRectsCount</b> is 0. An application must not update any pixel
    ///outside of the dirty rectangles.
    RECT*  pDirtyRects;
    ///A pointer to the scrolled rectangle. The scrolled rectangle is the rectangle of the previous frame from which the
    ///runtime bit-block transfers (bitblts) content. The runtime also uses the scrolled rectangle to optimize
    ///presentation in terminal server and indirect display scenarios. The scrolled rectangle also describes the
    ///destination rectangle, that is, the region on the current frame that is filled with scrolled content. You can set
    ///this member to <b>NULL</b> to indicate that no content is scrolled from the previous frame.
    RECT*  pScrollRect;
    ///A pointer to the offset of the scrolled area that goes from the source rectangle (of previous frame) to the
    ///destination rectangle (of current frame). You can set this member to <b>NULL</b> to indicate no offset.
    POINT* pScrollOffset;
}

///Describes an adapter (or video card) that uses Microsoft DirectX Graphics Infrastructure (DXGI) 1.2.
struct DXGI_ADAPTER_DESC2
{
    ///A string that contains the adapter description.
    ushort[128] Description;
    ///The PCI ID of the hardware vendor.
    uint        VendorId;
    ///The PCI ID of the hardware device.
    uint        DeviceId;
    ///The PCI ID of the sub system.
    uint        SubSysId;
    ///The PCI ID of the revision number of the adapter.
    uint        Revision;
    ///The number of bytes of dedicated video memory that are not shared with the CPU.
    size_t      DedicatedVideoMemory;
    ///The number of bytes of dedicated system memory that are not shared with the CPU. This memory is allocated from
    ///available system memory at boot time.
    size_t      DedicatedSystemMemory;
    ///The number of bytes of shared system memory. This is the maximum value of system memory that may be consumed by
    ///the adapter during operation. Any incidental memory consumed by the driver as it manages and uses video memory is
    ///additional.
    size_t      SharedSystemMemory;
    ///A unique value that identifies the adapter. See LUID for a definition of the structure. <b>LUID</b> is defined in
    ///dxgi.h.
    LUID        AdapterLuid;
    ///A value of the DXGI_ADAPTER_FLAG enumerated type that describes the adapter type. The
    ///<b>DXGI_ADAPTER_FLAG_REMOTE</b> flag is reserved.
    uint        Flags;
    ///A value of the DXGI_GRAPHICS_PREEMPTION_GRANULARITY enumerated type that describes the granularity level at which
    ///the GPU can be preempted from performing its current graphics rendering task.
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    ///A value of the DXGI_COMPUTE_PREEMPTION_GRANULARITY enumerated type that describes the granularity level at which
    ///the GPU can be preempted from performing its current compute task.
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

///Represents a 3x2 matrix. Used with GetMatrixTransform and SetMatrixTransform to indicate the scaling and translation
///transform for SwapChainPanel swap chains.
struct DXGI_MATRIX_3X2_F
{
    ///The value in the first row and first column of the matrix.
    float _11;
    ///The value in the first row and second column of the matrix.
    float _12;
    ///The value in the second row and first column of the matrix.
    float _21;
    ///The value in the second row and second column of the matrix.
    float _22;
    ///The value in the third row and first column of the matrix.
    float _31;
    ///The value in the third row and second column of the matrix.
    float _32;
}

///Used with
///[IDXGIFactoryMedia::CreateDecodeSwapChainForCompositionSurfaceHandle](./nf-dxgi1_3-idxgifactorymedia-createdecodeswapchainforcompositionsurfacehandle.md)
///to describe a decode swap chain.
struct DXGI_DECODE_SWAP_CHAIN_DESC
{
    ///Type: <b>UINT</b> Can be 0, or a combination of **DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO** and/or
    ///**DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO**. Those named values are members of the DXGI_SWAP_CHAIN_FLAG enumerated type,
    ///and you can combine them by using a bitwise OR operation. The resulting value specifies options for decode
    ///swap-chain behavior.
    uint Flags;
}

///Used to verify system approval for the app's custom present duration (custom refresh rate). Approval should be
///continuously verified on a frame-by-frame basis.
struct DXGI_FRAME_STATISTICS_MEDIA
{
    ///Type: <b>UINT</b> A value that represents the running total count of times that an image was presented to the
    ///monitor since the computer booted. <div class="alert"><b>Note</b> The number of times that an image was presented
    ///to the monitor is not necessarily the same as the number of times that you called IDXGISwapChain::Present or
    ///IDXGISwapChain1::Present1.</div> <div> </div>
    uint          PresentCount;
    ///Type: <b>UINT</b> A value that represents the running total count of v-blanks at which the last image was
    ///presented to the monitor and that have happened since the computer booted (for windowed mode, since the swap
    ///chain was created).
    uint          PresentRefreshCount;
    ///Type: <b>UINT</b> A value that represents the running total count of v-blanks when the scheduler last sampled the
    ///machine time by calling QueryPerformanceCounter and that have happened since the computer booted (for windowed
    ///mode, since the swap chain was created).
    uint          SyncRefreshCount;
    ///Type: <b>LARGE_INTEGER</b> A value that represents the high-resolution performance counter timer. This value is
    ///the same as the value returned by the QueryPerformanceCounter function.
    LARGE_INTEGER SyncQPCTime;
    ///Type: <b>LARGE_INTEGER</b> Reserved. Always returns 0.
    LARGE_INTEGER SyncGPUTime;
    ///Type: <b>DXGI_FRAME_PRESENTATION_MODE</b> A value indicating the composition presentation mode. This value is
    ///used to determine whether the app should continue to use the decode swap chain. See DXGI_FRAME_PRESENTATION_MODE.
    DXGI_FRAME_PRESENTATION_MODE CompositionMode;
    ///Type: <b>UINT</b> If the system approves an app's custom present duration request, this field is set to the
    ///approved custom present duration. If the app's custom present duration request is not approved, this field is set
    ///to zero.
    uint          ApprovedPresentDuration;
}

///Describes the current video memory budgeting parameters.
struct DXGI_QUERY_VIDEO_MEMORY_INFO
{
    ///Specifies the OS-provided video memory budget, in bytes, that the application should target. If
    ///<i>CurrentUsage</i> is greater than <i>Budget</i>, the application may incur stuttering or performance penalties
    ///due to background activity by the OS to provide other applications with a fair usage of video memory.
    ulong Budget;
    ///Specifies the application’s current video memory usage, in bytes.
    ulong CurrentUsage;
    ///The amount of video memory, in bytes, that the application has available for reservation. To reserve this video
    ///memory, the application should call IDXGIAdapter3::SetVideoMemoryReservation.
    ulong AvailableForReservation;
    ///The amount of video memory, in bytes, that is reserved by the application. The OS uses the reservation as a hint
    ///to determine the application’s minimum working set. Applications should attempt to ensure that their video
    ///memory usage can be trimmed to meet this requirement.
    ulong CurrentReservation;
}

///Describes the metadata for HDR10, used when video is compressed using High Efficiency Video Coding (HEVC). This is
///used to describe the capabilities of the display used to master the content and the luminance values of the content.
struct DXGI_HDR_METADATA_HDR10
{
    ///The chromaticity coordinates of the red value in the CIE1931 color space. Index 0 contains the X coordinate and
    ///index 1 contains the Y coordinate. The values are normalized to 50,000.
    ushort[2] RedPrimary;
    ///The chromaticity coordinates of the green value in the CIE1931 color space. Index 0 contains the X coordinate and
    ///index 1 contains the Y coordinate. The values are normalized to 50,000.
    ushort[2] GreenPrimary;
    ///The chromaticity coordinates of the blue value in the CIE1931 color space. Index 0 contains the X coordinate and
    ///index 1 contains the Y coordinate. The values are normalized to 50,000.
    ushort[2] BluePrimary;
    ///The chromaticity coordinates of the white point in the CIE1931 color space. Index 0 contains the X coordinate and
    ///index 1 contains the Y coordinate. The values are normalized to 50,000.
    ushort[2] WhitePoint;
    ///The maximum number of nits of the display used to master the content. Values are in whole nits.
    uint      MaxMasteringLuminance;
    ///The minimum number of nits of the display used to master the content. Values are 1/10000th of a nit (0.0001 nit).
    uint      MinMasteringLuminance;
    ///The maximum content light level (MaxCLL). This is the nit value corresponding to the brightest pixel used
    ///anywhere in the content.
    ushort    MaxContentLightLevel;
    ///The maximum frame average light level (MaxFALL). This is the nit value corresponding to the average luminance of
    ///the frame which has the brightest average luminance anywhere in the content.
    ushort    MaxFrameAverageLightLevel;
}

struct DXGI_HDR_METADATA_HDR10PLUS
{
    ubyte[72] Data;
}

///Describes an adapter (or video card) that uses Microsoft DirectX Graphics Infrastructure (DXGI) 1.6.
struct DXGI_ADAPTER_DESC3
{
    ///A string that contains the adapter description.
    ushort[128]        Description;
    ///The PCI ID of the hardware vendor.
    uint               VendorId;
    ///The PCI ID of the hardware device.
    uint               DeviceId;
    ///The PCI ID of the sub system.
    uint               SubSysId;
    ///The PCI ID of the revision number of the adapter.
    uint               Revision;
    ///The number of bytes of dedicated video memory that are not shared with the CPU.
    size_t             DedicatedVideoMemory;
    ///The number of bytes of dedicated system memory that are not shared with the CPU. This memory is allocated from
    ///available system memory at boot time.
    size_t             DedicatedSystemMemory;
    ///The number of bytes of shared system memory. This is the maximum value of system memory that may be consumed by
    ///the adapter during operation. Any incidental memory consumed by the driver as it manages and uses video memory is
    ///additional.
    size_t             SharedSystemMemory;
    ///A unique value that identifies the adapter. See LUID for a definition of the structure. <b>LUID</b> is defined in
    ///dxgi.h.
    LUID               AdapterLuid;
    ///A value of the DXGI_ADAPTER_FLAG3 enumeration that describes the adapter type. The
    ///<b>DXGI_ADAPTER_FLAG_REMOTE</b> flag is reserved.
    DXGI_ADAPTER_FLAG3 Flags;
    ///A value of the DXGI_GRAPHICS_PREEMPTION_GRANULARITY enumerated type that describes the granularity level at which
    ///the GPU can be preempted from performing its current graphics rendering task.
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    ///A value of the DXGI_COMPUTE_PREEMPTION_GRANULARITY enumerated type that describes the granularity level at which
    ///the GPU can be preempted from performing its current compute task.
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

///Describes an output or physical connection between the adapter (video card) and a device, including additional
///information about color capabilities and connection type.
struct DXGI_OUTPUT_DESC1
{
    ///Type: <b>WCHAR[32]</b> A string that contains the name of the output device.
    ushort[32]         DeviceName;
    ///Type: <b>RECT</b> A RECT structure containing the bounds of the output in desktop coordinates. Desktop
    ///coordinates depend on the dots per inch (DPI) of the desktop. For info about writing DPI-aware Win32 apps, see
    ///High DPI.
    RECT               DesktopCoordinates;
    ///Type: <b>BOOL</b> True if the output is attached to the desktop; otherwise, false.
    BOOL               AttachedToDesktop;
    ///Type: <b>DXGI_MODE_ROTATION</b> A member of the DXGI_MODE_ROTATION enumerated type describing on how an image is
    ///rotated by the output.
    DXGI_MODE_ROTATION Rotation;
    ///Type: <b>HMONITOR</b> An HMONITOR handle that represents the display monitor. For more information, see HMONITOR
    ///and the Device Context.
    HMONITOR           Monitor;
    ///Type: <b>UINT</b> The number of bits per color channel for the active wire format of the display attached to this
    ///output.
    uint               BitsPerColor;
    ///Type: <b>DXGI_COLOR_SPACE_TYPE</b> The current advanced color capabilities of the display attached to this
    ///output. Specifically, whether its capable of reproducing color and luminance values outside of the sRGB color
    ///space. A value of DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P709 indicates that the display is limited to SDR/sRGB; A
    ///value of DXGI_COLOR_SPACE_RGB_FULL_G2048_NONE_P2020 indicates that the display supports advanced color
    ///capabilities. For detailed luminance and color capabilities, see additional members of this struct.
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    ///Type: <b>FLOAT[2]</b> The red color primary, in xy coordinates, of the display attached to this output. This
    ///value will usually come from the EDID of the corresponding display or sometimes from an override.
    float[2]           RedPrimary;
    ///Type: <b>FLOAT[2]</b> The green color primary, in xy coordinates, of the display attached to this output. This
    ///value will usually come from the EDID of the corresponding display or sometimes from an override.
    float[2]           GreenPrimary;
    ///Type: <b>FLOAT[2]</b> The blue color primary, in xy coordinates, of the display attached to this output. This
    ///value will usually come from the EDID of the corresponding display or sometimes from an override.
    float[2]           BluePrimary;
    ///Type: <b>FLOAT[2]</b> The white point, in xy coordinates, of the display attached to this output. This value will
    ///usually come from the EDID of the corresponding display or sometimes from an override.
    float[2]           WhitePoint;
    ///Type: <b>FLOAT</b> The minimum luminance, in nits, that the display attached to this output is capable of
    ///rendering. Content should not exceed this minimum value for optimal rendering. This value will usually come from
    ///the EDID of the corresponding display or sometimes from an override.
    float              MinLuminance;
    ///Type: <b>FLOAT</b> The maximum luminance, in nits, that the display attached to this output is capable of
    ///rendering; this value is likely only valid for a small area of the panel. Content should not exceed this minimum
    ///value for optimal rendering. This value will usually come from the EDID of the corresponding display or sometimes
    ///from an override.
    float              MaxLuminance;
    ///Type: <b>FLOAT</b> The maximum luminance, in nits, that the display attached to this output is capable of
    ///rendering; unlike MaxLuminance, this value is valid for a color that fills the entire area of the panel. Content
    ///should not exceed this value across the entire panel for optimal rendering. This value will usually come from the
    ///EDID of the corresponding display or sometimes from an override.
    float              MaxFullFrameLuminance;
}

///Describes a debug message in the information queue.
struct DXGI_INFO_QUEUE_MESSAGE
{
    ///A DXGI_DEBUG_ID value that identifies the entity that produced the message.
    GUID          Producer;
    ///A DXGI_INFO_QUEUE_MESSAGE_CATEGORY-typed value that specifies the category of the message.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category;
    ///A DXGI_INFO_QUEUE_MESSAGE_SEVERITY-typed value that specifies the severity of the message.
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity;
    ///An integer that uniquely identifies the message.
    int           ID;
    ///The message string.
    const(ubyte)* pDescription;
    ///The length of the message string at <b>pDescription</b>, in bytes.
    size_t        DescriptionByteLength;
}

///Describes the types of messages to allow or deny to pass through a filter.
struct DXGI_INFO_QUEUE_FILTER_DESC
{
    ///The number of message categories to allow or deny.
    uint NumCategories;
    ///An array of DXGI_INFO_QUEUE_MESSAGE_CATEGORY enumeration values that describe the message categories to allow or
    ///deny. The array must have at least <b>NumCategories</b> number of elements.
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY* pCategoryList;
    ///The number of message severity levels to allow or deny.
    uint NumSeverities;
    ///An array of DXGI_INFO_QUEUE_MESSAGE_SEVERITY enumeration values that describe the message severity levels to
    ///allow or deny. The array must have at least <b>NumSeverities</b> number of elements.
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY* pSeverityList;
    ///The number of message IDs to allow or deny.
    uint NumIDs;
    ///An array of integers that represent the message IDs to allow or deny. The array must have at least <b>NumIDs</b>
    ///number of elements.
    int* pIDList;
}

///Describes a debug message filter, which contains lists of message types to allow and deny.
struct DXGI_INFO_QUEUE_FILTER
{
    ///A DXGI_INFO_QUEUE_FILTER_DESC structure that describes the types of messages to allow.
    DXGI_INFO_QUEUE_FILTER_DESC AllowList;
    ///A DXGI_INFO_QUEUE_FILTER_DESC structure that describes the types of messages to deny.
    DXGI_INFO_QUEUE_FILTER_DESC DenyList;
}

// Functions

///Creates a DXGI 1.0 factory that you can use to generate other DXGI objects.
///Params:
///    riid = Type: <b>REFIID</b> The globally unique identifier (GUID) of the IDXGIFactory object referenced by the
///           <i>ppFactory</i> parameter.
///    ppFactory = Type: <b>void**</b> Address of a pointer to an IDXGIFactory object.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; otherwise, returns one of the following DXGI_ERROR.
///    
@DllImport("dxgi")
HRESULT CreateDXGIFactory(const(GUID)* riid, void** ppFactory);

///Creates a DXGI 1.1 factory that you can use to generate other DXGI objects.
///Params:
///    riid = Type: <b>REFIID</b> The globally unique identifier (GUID) of the IDXGIFactory1 object referenced by the
///           <i>ppFactory</i> parameter.
///    ppFactory = Type: <b>void**</b> Address of a pointer to an IDXGIFactory1 object.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
///    DXGI_ERROR.
///    
@DllImport("dxgi")
HRESULT CreateDXGIFactory1(const(GUID)* riid, void** ppFactory);

///Creates a DXGI 1.3 factory that you can use to generate other DXGI objects. In Windows 8, any DXGI factory created
///while DXGIDebug.dll was present on the system would load and use it. Starting in Windows 8.1, apps explicitly request
///that DXGIDebug.dll be loaded instead. Use <b>CreateDXGIFactory2</b> and specify the DXGI_CREATE_FACTORY_DEBUG flag to
///request DXGIDebug.dll; the DLL will be loaded if it is present on the system.
///Params:
///    Flags = Type: <b>UINT</b> Valid values include the <b>DXGI_CREATE_FACTORY_DEBUG (0x01)</b> flag, and zero. <div
///            class="alert"><b>Note</b> This flag will be set by the D3D runtime if:<ul> <li>The system creates an implicit
///            factory during device creation.</li> <li>The D3D11_CREATE_DEVICE_DEBUG flag is specified during device creation,
///            for example using D3D11CreateDevice (or the swapchain method, or the Direct3D 10 equivalents).</li> </ul> </div>
///            <div> </div>
///    riid = Type: <b>REFIID</b> The globally unique identifier (GUID) of the IDXGIFactory2 object referenced by the
///           <i>ppFactory</i> parameter.
///    ppFactory = Type: <b>void**</b> Address of a pointer to an IDXGIFactory2 object.
///Returns:
///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
///    DXGI_ERROR.
///    
@DllImport("dxgi")
HRESULT CreateDXGIFactory2(uint Flags, const(GUID)* riid, void** ppFactory);

///Retrieves an interface that Windows Store apps use for debugging the Microsoft DirectX Graphics Infrastructure
///(DXGI).
///Params:
///    Flags = Not used.
///    riid = The globally unique identifier (GUID) of the requested interface type, which can be the identifier for the
///           IDXGIDebug, IDXGIDebug1, or IDXGIInfoQueue interfaces.
///    pDebug = A pointer to a buffer that receives a pointer to the debugging interface.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dxgi")
HRESULT DXGIGetDebugInterface1(uint Flags, const(GUID)* riid, void** pDebug);

///Allows a process to indicate that it's resilient to any of its graphics devices being removed.
///Returns:
///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; an error code otherwise. If this function is called after
///    device creation, it returns <b>DXGI_ERROR_INVALID_CALL</b>. If this is not the first time that this function is
///    called, it returns <b>DXGI_ERROR_ALREADY_EXISTS</b>. For a full list of error codes, see DXGI_ERROR.
///    
@DllImport("dxgi")
HRESULT DXGIDeclareAdapterRemovalSupport();


// Interfaces

///An <b>IDXGIObject</b> interface is a base interface for all DXGI objects; <b>IDXGIObject</b> supports associating
///caller-defined (private data) with an object and retrieval of an interface to the parent object.
@GUID("AEC22FB8-76F3-4639-9BE0-28EB43A67A2E")
interface IDXGIObject : IUnknown
{
    ///Sets application-defined data to the object and associates that data with a GUID.
    ///Params:
    ///    Name = Type: <b>REFGUID</b> A GUID that identifies the data. Use this GUID in a call to GetPrivateData to get the
    ///           data.
    ///    DataSize = Type: <b>UINT</b> The size of the object's data.
    ///    pData = Type: <b>const void*</b> A pointer to the object's data.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT SetPrivateData(const(GUID)* Name, uint DataSize, const(void)* pData);
    ///Set an interface in the object's private data.
    ///Params:
    ///    Name = Type: <b>REFGUID</b> A GUID identifying the interface.
    ///    pUnknown = Type: <b>const IUnknown*</b> The interface to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT SetPrivateDataInterface(const(GUID)* Name, const(IUnknown) pUnknown);
    ///Get a pointer to the object's data.
    ///Params:
    ///    Name = Type: <b>REFGUID</b> A GUID identifying the data.
    ///    pDataSize = Type: <b>UINT*</b> The size of the data.
    ///    pData = Type: <b>void*</b> Pointer to the data.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT GetPrivateData(const(GUID)* Name, uint* pDataSize, void* pData);
    ///Gets the parent of the object.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The ID of the requested interface.
    ///    ppParent = Type: <b>void**</b> The address of a pointer to the parent object.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT GetParent(const(GUID)* riid, void** ppParent);
}

///Inherited from objects that are tied to the device so that they can retrieve a pointer to it.
@GUID("3D3E0379-F9DE-4D58-BB6C-18D62992F1A6")
interface IDXGIDeviceSubObject : IDXGIObject
{
    ///Retrieves the device.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The reference id for the device.
    ///    ppDevice = Type: <b>void**</b> The address of a pointer to the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> A code that indicates success or failure (see DXGI_ERROR).
    ///    
    HRESULT GetDevice(const(GUID)* riid, void** ppDevice);
}

///An <b>IDXGIResource</b> interface allows resource sharing and identifies the memory that a resource resides in.
@GUID("035F3AB4-482E-4E50-B41F-8A7F8BD8960B")
interface IDXGIResource : IDXGIDeviceSubObject
{
    ///<p class="CCE_Message">[Starting with Direct3D 11.1, we recommend not to use <b>GetSharedHandle</b> anymore to
    ///retrieve the handle to a shared resource. Instead, use IDXGIResource1::CreateSharedHandle to get a handle for
    ///sharing. To use <b>IDXGIResource1::CreateSharedHandle</b>, you must create the resource as shared and specify
    ///that it uses NT handles (that is, you set the D3D11_RESOURCE_MISC_SHARED_NTHANDLE flag). We also recommend that
    ///you create shared resources that use NT handles so you can use CloseHandle, DuplicateHandle, and so on on those
    ///shared resources.] Gets the handle to a shared resource.
    ///Params:
    ///    pSharedHandle = Type: <b>HANDLE*</b> A pointer to a handle.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT GetSharedHandle(HANDLE* pSharedHandle);
    ///Get the expected resource usage.
    ///Params:
    ///    pUsage = Type: <b>DXGI_USAGE*</b> A pointer to a usage flag (see DXGI_USAGE). For Direct3D 10, a surface can be used
    ///             as a shader input or a render-target output.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT GetUsage(uint* pUsage);
    ///Set the priority for evicting the resource from memory.
    ///Params:
    ///    EvictionPriority = Type: <b>UINT</b> The priority is one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                       </tr> <tr> <td width="40%"><a id="DXGI_RESOURCE_PRIORITY_MINIMUM__0x28000000_"></a><a
    ///                       id="dxgi_resource_priority_minimum__0x28000000_"></a><a
    ///                       id="DXGI_RESOURCE_PRIORITY_MINIMUM__0X28000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_MINIMUM
    ///                       (0x28000000)</b></dt> </dl> </td> <td width="60%"> The resource is unused and can be evicted as soon as
    ///                       another resource requires the memory that the resource occupies. </td> </tr> <tr> <td width="40%"><a
    ///                       id="DXGI_RESOURCE_PRIORITY_LOW__0x50000000_"></a><a id="dxgi_resource_priority_low__0x50000000_"></a><a
    ///                       id="DXGI_RESOURCE_PRIORITY_LOW__0X50000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_LOW (0x50000000)</b></dt>
    ///                       </dl> </td> <td width="60%"> The eviction priority of the resource is low. The placement of the resource is
    ///                       not critical, and minimal work is performed to find a location for the resource. For example, if a GPU can
    ///                       render with a vertex buffer from either local or non-local memory with little difference in performance, that
    ///                       vertex buffer is low priority. Other more critical resources (for example, a render target or texture) can
    ///                       then occupy the faster memory. </td> </tr> <tr> <td width="40%"><a
    ///                       id="DXGI_RESOURCE_PRIORITY_NORMAL__0x78000000_"></a><a id="dxgi_resource_priority_normal__0x78000000_"></a><a
    ///                       id="DXGI_RESOURCE_PRIORITY_NORMAL__0X78000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_NORMAL
    ///                       (0x78000000)</b></dt> </dl> </td> <td width="60%"> The eviction priority of the resource is normal. The
    ///                       placement of the resource is important, but not critical, for performance. The resource is placed in its
    ///                       preferred location instead of a low-priority resource. </td> </tr> <tr> <td width="40%"><a
    ///                       id="DXGI_RESOURCE_PRIORITY_HIGH__0xa0000000_"></a><a id="dxgi_resource_priority_high__0xa0000000_"></a><a
    ///                       id="DXGI_RESOURCE_PRIORITY_HIGH__0XA0000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_HIGH
    ///                       (0xa0000000)</b></dt> </dl> </td> <td width="60%"> The eviction priority of the resource is high. The
    ///                       resource is placed in its preferred location instead of a low-priority or normal-priority resource. </td>
    ///                       </tr> <tr> <td width="40%"><a id="DXGI_RESOURCE_PRIORITY_MAXIMUM__0xc8000000_"></a><a
    ///                       id="dxgi_resource_priority_maximum__0xc8000000_"></a><a
    ///                       id="DXGI_RESOURCE_PRIORITY_MAXIMUM__0XC8000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_MAXIMUM
    ///                       (0xc8000000)</b></dt> </dl> </td> <td width="60%"> The resource is evicted from memory only if there is no
    ///                       other way of resolving the memory requirement. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT SetEvictionPriority(uint EvictionPriority);
    ///Get the eviction priority.
    ///Params:
    ///    pEvictionPriority = Type: <b>UINT*</b> A pointer to the eviction priority, which determines when a resource can be evicted from
    ///                        memory. The following defined values are possible. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///                        <td width="40%"><a id="DXGI_RESOURCE_PRIORITY_MINIMUM__0x28000000_"></a><a
    ///                        id="dxgi_resource_priority_minimum__0x28000000_"></a><a
    ///                        id="DXGI_RESOURCE_PRIORITY_MINIMUM__0X28000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_MINIMUM
    ///                        (0x28000000)</b></dt> </dl> </td> <td width="60%"> The resource is unused and can be evicted as soon as
    ///                        another resource requires the memory that the resource occupies. </td> </tr> <tr> <td width="40%"><a
    ///                        id="DXGI_RESOURCE_PRIORITY_LOW__0x50000000_"></a><a id="dxgi_resource_priority_low__0x50000000_"></a><a
    ///                        id="DXGI_RESOURCE_PRIORITY_LOW__0X50000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_LOW (0x50000000)</b></dt>
    ///                        </dl> </td> <td width="60%"> The eviction priority of the resource is low. The placement of the resource is
    ///                        not critical, and minimal work is performed to find a location for the resource. For example, if a GPU can
    ///                        render with a vertex buffer from either local or non-local memory with little difference in performance, that
    ///                        vertex buffer is low priority. Other more critical resources (for example, a render target or texture) can
    ///                        then occupy the faster memory. </td> </tr> <tr> <td width="40%"><a
    ///                        id="DXGI_RESOURCE_PRIORITY_NORMAL__0x78000000_"></a><a id="dxgi_resource_priority_normal__0x78000000_"></a><a
    ///                        id="DXGI_RESOURCE_PRIORITY_NORMAL__0X78000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_NORMAL
    ///                        (0x78000000)</b></dt> </dl> </td> <td width="60%"> The eviction priority of the resource is normal. The
    ///                        placement of the resource is important, but not critical, for performance. The resource is placed in its
    ///                        preferred location instead of a low-priority resource. </td> </tr> <tr> <td width="40%"><a
    ///                        id="DXGI_RESOURCE_PRIORITY_HIGH__0xa0000000_"></a><a id="dxgi_resource_priority_high__0xa0000000_"></a><a
    ///                        id="DXGI_RESOURCE_PRIORITY_HIGH__0XA0000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_HIGH
    ///                        (0xa0000000)</b></dt> </dl> </td> <td width="60%"> The eviction priority of the resource is high. The
    ///                        resource is placed in its preferred location instead of a low-priority or normal-priority resource. </td>
    ///                        </tr> <tr> <td width="40%"><a id="DXGI_RESOURCE_PRIORITY_MAXIMUM__0xc8000000_"></a><a
    ///                        id="dxgi_resource_priority_maximum__0xc8000000_"></a><a
    ///                        id="DXGI_RESOURCE_PRIORITY_MAXIMUM__0XC8000000_"></a><dl> <dt><b>DXGI_RESOURCE_PRIORITY_MAXIMUM
    ///                        (0xc8000000)</b></dt> </dl> </td> <td width="60%"> The resource is evicted from memory only if there is no
    ///                        other way of resolving the memory requirement. </td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT GetEvictionPriority(uint* pEvictionPriority);
}

///Represents a keyed mutex, which allows exclusive access to a shared resource that is used by multiple devices.
@GUID("9D8E1289-D7B3-465F-8126-250E349AF85D")
interface IDXGIKeyedMutex : IDXGIDeviceSubObject
{
    ///Using a key, acquires exclusive rendering access to a shared resource.
    ///Params:
    ///    Key = Type: <b>UINT64</b> A value that indicates which device to give access to. This method will succeed when the
    ///          device that currently owns the surface calls the IDXGIKeyedMutex::ReleaseSync method using the same value.
    ///          This value can be any UINT64 value.
    ///    dwMilliseconds = Type: <b>DWORD</b> The time-out interval, in milliseconds. This method will return if the interval elapses,
    ///                     and the keyed mutex has not been released using the specified <i>Key</i>. If this value is set to zero, the
    ///                     <b>AcquireSync</b> method will test to see if the keyed mutex has been released and returns immediately. If
    ///                     this value is set to INFINITE, the time-out interval will never elapse.
    ///Returns:
    ///    Type: <b>HRESULT</b> Return S_OK if successful. If the owning device attempted to create another keyed mutex
    ///    on the same shared resource, <b>AcquireSync</b> returns E_FAIL. <b>AcquireSync</b> can also return the
    ///    following DWORD constants. Therefore, you should explicitly check for these constants. If you only use the
    ///    SUCCEEDED macro on the return value to determine if <b>AcquireSync</b> succeeded, you will not catch these
    ///    constants. <ul> <li>WAIT_ABANDONED - The shared surface and keyed mutex are no longer in a consistent state.
    ///    If <b>AcquireSync</b> returns this value, you should release and recreate both the keyed mutex and the shared
    ///    surface.</li> <li>WAIT_TIMEOUT - The time-out interval elapsed before the specified key was released.</li>
    ///    </ul>
    ///    
    HRESULT AcquireSync(ulong Key, uint dwMilliseconds);
    ///Using a key, releases exclusive rendering access to a shared resource.
    ///Params:
    ///    Key = Type: <b>UINT64</b> A value that indicates which device to give access to. This method succeeds when the
    ///          device that currently owns the surface calls the <b>ReleaseSync</b> method using the same value. This value
    ///          can be any UINT64 value.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful. If the device attempted to release a keyed mutex that is not
    ///    valid or owned by the device, <b>ReleaseSync</b> returns E_FAIL.
    ///    
    HRESULT ReleaseSync(ulong Key);
}

///The <b>IDXGISurface</b> interface implements methods for image-data objects.
@GUID("CAFCB56C-6AC3-4889-BF47-9E23BBD260EC")
interface IDXGISurface : IDXGIDeviceSubObject
{
    ///Get a description of the surface.
    ///Params:
    ///    pDesc = Type: <b>DXGI_SURFACE_DESC*</b> A pointer to the surface description (see DXGI_SURFACE_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the error codes that are described
    ///    in the DXGI_ERROR topic.
    ///    
    HRESULT GetDesc(DXGI_SURFACE_DESC* pDesc);
    ///Get a pointer to the data contained in the surface, and deny GPU access to the surface.
    ///Params:
    ///    pLockedRect = Type: <b>DXGI_MAPPED_RECT*</b> A pointer to the surface data (see DXGI_MAPPED_RECT).
    ///    MapFlags = Type: <b>UINT</b> CPU read-write flags. These flags can be combined with a logical OR. <ul> <li>DXGI_MAP_READ
    ///               - Allow CPU read access.</li> <li>DXGI_MAP_WRITE - Allow CPU write access.</li> <li>DXGI_MAP_DISCARD -
    ///               Discard the previous contents of a resource when it is mapped.</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the error codes that are described
    ///    in the DXGI_ERROR topic.
    ///    
    HRESULT Map(DXGI_MAPPED_RECT* pLockedRect, uint MapFlags);
    ///Invalidate the pointer to the surface retrieved by IDXGISurface::Map and re-enable GPU access to the resource.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the error codes that are described
    ///    in the DXGI_ERROR topic.
    ///    
    HRESULT Unmap();
}

///The <b>IDXGISurface1</b> interface extends the IDXGISurface by adding support for using Windows Graphics Device
///Interface (GDI) to render to a Microsoft DirectX Graphics Infrastructure (DXGI) surface.
@GUID("4AE63092-6327-4C1B-80AE-BFE12EA32B86")
interface IDXGISurface1 : IDXGISurface
{
    ///Returns a device context (DC) that allows you to render to a Microsoft DirectX Graphics Infrastructure (DXGI)
    ///surface using Windows Graphics Device Interface (GDI).
    ///Params:
    ///    Discard = Type: <b>BOOL</b> A Boolean value that specifies whether to preserve Direct3D contents in the GDI DC.
    ///              <b>TRUE</b> directs the runtime not to preserve Direct3D contents in the GDI DC; that is, the runtime
    ///              discards the Direct3D contents. <b>FALSE</b> guarantees that Direct3D contents are available in the GDI DC.
    ///    phdc = Type: <b>HDC*</b> A pointer to an HDC handle that represents the current device context for GDI rendering.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, an error code.
    ///    
    HRESULT GetDC(BOOL Discard, HDC* phdc);
    ///Releases the GDI device context (DC) that is associated with the current surface and allows you to use Direct3D
    ///to render.
    ///Params:
    ///    pDirtyRect = Type: <b>RECT*</b> A pointer to a <b>RECT</b> structure that identifies the dirty region of the surface. A
    ///                 dirty region is any part of the surface that you used for GDI rendering and that you want to preserve. This
    ///                 area is used as a performance hint to graphics subsystem in certain scenarios. Do not use this parameter to
    ///                 restrict rendering to the specified rectangular region. If you pass in <b>NULL</b>, <b>ReleaseDC</b>
    ///                 considers the whole surface as dirty. Otherwise, <b>ReleaseDC</b> uses the area specified by the RECT as a
    ///                 performance hint to indicate what areas have been manipulated by GDI rendering. You can pass a pointer to an
    ///                 empty <b>RECT</b> structure (a rectangle with no position or area) if you didn't change any content.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReleaseDC(RECT* pDirtyRect);
}

///The <b>IDXGIAdapter</b> interface represents a display subsystem (including one or more GPUs, DACs and video memory).
@GUID("2411E7E1-12AC-4CCF-BD14-9798E8534DC0")
interface IDXGIAdapter : IDXGIObject
{
    ///Enumerate adapter (video card) outputs.
    ///Params:
    ///    Output = Type: <b>UINT</b> The index of the output.
    ///    ppOutput = Type: <b>IDXGIOutput**</b> The address of a pointer to an IDXGIOutput interface at the position specified by
    ///               the <i>Output</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> A code that indicates success or failure (see DXGI_ERROR). DXGI_ERROR_NOT_FOUND is
    ///    returned if the index is greater than the number of outputs. If the adapter came from a device created using
    ///    D3D_DRIVER_TYPE_WARP, then the adapter has no outputs, so DXGI_ERROR_NOT_FOUND is returned.
    ///    
    HRESULT EnumOutputs(uint Output, IDXGIOutput* ppOutput);
    ///Gets a DXGI 1.0 description of an adapter (or video card).
    ///Params:
    ///    pDesc = Type: <b>DXGI_ADAPTER_DESC*</b> A pointer to a DXGI_ADAPTER_DESC structure that describes the adapter. This
    ///            parameter must not be <b>NULL</b>. On feature level 9 graphics hardware, <b>GetDesc</b> returns zeros for the
    ///            PCI ID in the <b>VendorId</b>, <b>DeviceId</b>, <b>SubSysId</b>, and <b>Revision</b> members of
    ///            <b>DXGI_ADAPTER_DESC</b> and “Software Adapter” for the description string in the <b>Description</b>
    ///            member.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise returns E_INVALIDARG if the <i>pDesc</i> parameter
    ///    is <b>NULL</b>.
    ///    
    HRESULT GetDesc(DXGI_ADAPTER_DESC* pDesc);
    ///Checks whether the system supports a device interface for a graphics component.
    ///Params:
    ///    InterfaceName = Type: <b>REFGUID</b> The GUID of the interface of the device version for which support is being checked. This
    ///                    should usually be __uuidof(IDXGIDevice), which returns the version number of the Direct3D 9 UMD (user mode
    ///                    driver) binary. Since WDDM 2.3, all driver components within a driver package (D3D9, D3D11, and D3D12) have
    ///                    been required to share a single version number, so this is a good way to query the driver version regardless
    ///                    of which API is being used.
    ///    pUMDVersion = Type: <b>LARGE_INTEGER*</b> The user mode driver version of <i>InterfaceName</i>. This is returned only if
    ///                  the interface is supported, otherwise this parameter will be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> S_OK indicates that the interface is supported, otherwise DXGI_ERROR_UNSUPPORTED is
    ///    returned (For more information, see DXGI_ERROR).
    ///    
    HRESULT CheckInterfaceSupport(const(GUID)* InterfaceName, LARGE_INTEGER* pUMDVersion);
}

///An <b>IDXGIOutput</b> interface represents an adapter output (such as a monitor).
@GUID("AE02EEDB-C735-4690-8D52-5A8DC20213AA")
interface IDXGIOutput : IDXGIObject
{
    ///Get a description of the output.
    ///Params:
    ///    pDesc = Type: <b>DXGI_OUTPUT_DESC*</b> A pointer to the output description (see DXGI_OUTPUT_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns a code that indicates success or failure. S_OK if successful,
    ///    DXGI_ERROR_INVALID_CALL if <i>pDesc</i> is passed in as <b>NULL</b>.
    ///    
    HRESULT GetDesc(DXGI_OUTPUT_DESC* pDesc);
    ///<p class="CCE_Message">[Starting with Direct3D 11.1, we recommend not to use <b>GetDisplayModeList</b> anymore to
    ///retrieve the matching display mode. Instead, use IDXGIOutput1::GetDisplayModeList1, which supports stereo display
    ///mode.] Gets the display modes that match the requested format and other input options.
    ///Params:
    ///    EnumFormat = Type: <b>DXGI_FORMAT</b> The color format (see DXGI_FORMAT).
    ///    Flags = Type: <b>UINT</b> Options for modes to include (see DXGI_ENUM_MODES). DXGI_ENUM_MODES_SCALING needs to be
    ///            specified to expose the display modes that require scaling. Centered modes, requiring no scaling and
    ///            corresponding directly to the display output, are enumerated by default.
    ///    pNumModes = Type: <b>UINT*</b> Set <i>pDesc</i> to <b>NULL</b> so that <i>pNumModes</i> returns the number of display
    ///                modes that match the format and the options. Otherwise, <i>pNumModes</i> returns the number of display modes
    ///                returned in <i>pDesc</i>.
    ///    pDesc = Type: <b>DXGI_MODE_DESC*</b> A pointer to a list of display modes (see DXGI_MODE_DESC); set to <b>NULL</b> to
    ///            get the number of display modes.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR. It is rare, but possible, that the display
    ///    modes available can change immediately after calling this method, in which case DXGI_ERROR_MORE_DATA is
    ///    returned (if there is not enough room for all the display modes). If <b>GetDisplayModeList</b> is called from
    ///    a Remote Desktop Services session (formerly Terminal Services session), DXGI_ERROR_NOT_CURRENTLY_AVAILABLE is
    ///    returned.
    ///    
    HRESULT GetDisplayModeList(DXGI_FORMAT EnumFormat, uint Flags, uint* pNumModes, DXGI_MODE_DESC* pDesc);
    ///<p class="CCE_Message">[Starting with Direct3D 11.1, we recommend not to use <b>FindClosestMatchingMode</b>
    ///anymore to find the display mode that most closely matches the requested display mode. Instead, use
    ///IDXGIOutput1::FindClosestMatchingMode1, which supports stereo display mode.] Finds the display mode that most
    ///closely matches the requested display mode.
    ///Params:
    ///    pModeToMatch = Type: <b>const DXGI_MODE_DESC*</b> The desired display mode (see DXGI_MODE_DESC). Members of
    ///                   <b>DXGI_MODE_DESC</b> can be unspecified indicating no preference for that member. A value of 0 for
    ///                   <b>Width</b> or <b>Height</b> indicates the value is unspecified. If either <b>Width</b> or <b>Height</b> are
    ///                   0, both must be 0. A numerator and denominator of 0 in <b>RefreshRate</b> indicate it is unspecified. Other
    ///                   members of <b>DXGI_MODE_DESC</b> have enumeration values indicating the member is unspecified. If
    ///                   <i>pConcernedDevice</i> is <b>NULL</b>, <b>Format</b>cannot be DXGI_FORMAT_UNKNOWN.
    ///    pClosestMatch = Type: <b>DXGI_MODE_DESC*</b> The mode that most closely matches <i>pModeToMatch</i>.
    ///    pConcernedDevice = Type: <b>IUnknown*</b> A pointer to the Direct3D device interface. If this parameter is <b>NULL</b>, only
    ///                       modes whose format matches that of <i>pModeToMatch</i> will be returned; otherwise, only those formats that
    ///                       are supported for scan-out by the device are returned. For info about the formats that are supported for
    ///                       scan-out by the device at each feature level: <ul> <li> DXGI Format Support for Direct3D Feature Level 12.1
    ///                       Hardware </li> <li> DXGI Format Support for Direct3D Feature Level 12.0 Hardware </li> <li> DXGI Format
    ///                       Support for Direct3D Feature Level 11.1 Hardware </li> <li> DXGI Format Support for Direct3D Feature Level
    ///                       11.0 Hardware </li> <li> Hardware Support for Direct3D 10Level9 Formats </li> <li> Hardware Support for
    ///                       Direct3D 10.1 Formats </li> <li> Hardware Support for Direct3D 10 Formats </li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT FindClosestMatchingMode(const(DXGI_MODE_DESC)* pModeToMatch, DXGI_MODE_DESC* pClosestMatch, 
                                    IUnknown pConcernedDevice);
    ///Halt a thread until the next vertical blank occurs.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT WaitForVBlank();
    ///Takes ownership of an output.
    ///Params:
    ///    pDevice = Type: <b>IUnknown*</b> A pointer to the IUnknown interface of a device (such as an ID3D10Device).
    ///    Exclusive = Type: <b>BOOL</b> Set to <b>TRUE</b> to enable other threads or applications to take ownership of the device;
    ///                otherwise, set to <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT TakeOwnership(IUnknown pDevice, BOOL Exclusive);
    ///Releases ownership of the output.
    void    ReleaseOwnership();
    ///Gets a description of the gamma-control capabilities.
    ///Params:
    ///    pGammaCaps = Type: <b>DXGI_GAMMA_CONTROL_CAPABILITIES*</b> A pointer to a description of the gamma-control capabilities
    ///                 (see DXGI_GAMMA_CONTROL_CAPABILITIES).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT GetGammaControlCapabilities(DXGI_GAMMA_CONTROL_CAPABILITIES* pGammaCaps);
    ///Sets the gamma controls.
    ///Params:
    ///    pArray = Type: <b>const DXGI_GAMMA_CONTROL*</b> A pointer to a DXGI_GAMMA_CONTROL structure that describes the gamma
    ///             curve to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT SetGammaControl(const(DXGI_GAMMA_CONTROL)* pArray);
    ///Gets the gamma control settings.
    ///Params:
    ///    pArray = Type: <b>DXGI_GAMMA_CONTROL*</b> An array of gamma control settings (see DXGI_GAMMA_CONTROL).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT GetGammaControl(DXGI_GAMMA_CONTROL* pArray);
    ///Changes the display mode.
    ///Params:
    ///    pScanoutSurface = Type: <b>IDXGISurface*</b> A pointer to a surface (see IDXGISurface) used for rendering an image to the
    ///                      screen. The surface must have been created as a back buffer (DXGI_USAGE_BACKBUFFER).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT SetDisplaySurface(IDXGISurface pScanoutSurface);
    ///<p class="CCE_Message">[Starting with Direct3D 11.1, we recommend not to use <b>GetDisplaySurfaceData</b> anymore
    ///to retrieve the current display surface. Instead, use IDXGIOutput1::GetDisplaySurfaceData1, which supports stereo
    ///display mode.] Gets a copy of the current display surface.
    ///Params:
    ///    pDestination = Type: <b>IDXGISurface*</b> A pointer to a destination surface (see IDXGISurface).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT GetDisplaySurfaceData(IDXGISurface pDestination);
    ///Gets statistics about recently rendered frames.
    ///Params:
    ///    pStats = Type: <b>DXGI_FRAME_STATISTICS*</b> A pointer to frame statistics (see DXGI_FRAME_STATISTICS).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this function succeeds, it returns S_OK. Otherwise, it might return
    ///    DXGI_ERROR_INVALID_CALL.
    ///    
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
}

///An <b>IDXGISwapChain</b> interface implements one or more surfaces for storing rendered data before presenting it to
///an output.
@GUID("310D36A0-D2E7-4C0A-AA04-6A9D23B8886A")
interface IDXGISwapChain : IDXGIDeviceSubObject
{
    ///Presents a rendered image to the user.
    ///Params:
    ///    SyncInterval = Type: <b>UINT</b> An integer that specifies how to synchronize presentation of a frame with the vertical
    ///                   blank. For the bit-block transfer (bitblt) model (DXGI_SWAP_EFFECT_DISCARDor DXGI_SWAP_EFFECT_SEQUENTIAL),
    ///                   values are: <ul> <li>0 - The presentation occurs immediately, there is no synchronization.</li> <li>1 through
    ///                   4 - Synchronize presentation after the <i>n</i>th vertical blank.</li> </ul> For the flip model
    ///                   (DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL), values are: <ul> <li>0 - Cancel the remaining time on the previously
    ///                   presented frame and discard this frame if a newer frame is queued. </li> <li>1 through 4 - Synchronize
    ///                   presentation for at least <i>n</i> vertical blanks. </li> </ul> For an example that shows how sync-interval
    ///                   values affect a flip presentation queue, see Remarks. If the update region straddles more than one output
    ///                   (each represented by IDXGIOutput), <b>Present</b> performs the synchronization to the output that contains
    ///                   the largest sub-rectangle of the target window's client area.
    ///    Flags = Type: <b>UINT</b> An integer value that contains swap-chain presentation options. These options are defined
    ///            by the DXGI_PRESENT constants.
    ///Returns:
    ///    Type: <b>HRESULT</b> Possible return values include: S_OK, DXGI_ERROR_DEVICE_RESET or
    ///    DXGI_ERROR_DEVICE_REMOVED (see DXGI_ERROR), DXGI_STATUS_OCCLUDED (see DXGI_STATUS), or
    ///    D3DDDIERR_DEVICEREMOVED. <div class="alert"><b>Note</b> The <b>Present</b> method can return either
    ///    DXGI_ERROR_DEVICE_REMOVED or D3DDDIERR_DEVICEREMOVED if a video card has been physically removed from the
    ///    computer, or a driver upgrade for the video card has occurred.</div> <div> </div>
    ///    
    HRESULT Present(uint SyncInterval, uint Flags);
    ///Accesses one of the swap-chain's back buffers.
    ///Params:
    ///    Buffer = Type: <b>UINT</b> A zero-based buffer index. If the swap chain's swap effect is DXGI_SWAP_EFFECT_DISCARD,
    ///             this method can only access the first buffer; for this situation, set the index to zero. If the swap chain's
    ///             swap effect is either DXGI_SWAP_EFFECT_SEQUENTIAL or DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL, only the swap chain's
    ///             zero-index buffer can be read from and written to. The swap chain's buffers with indexes greater than zero
    ///             can only be read from; so if you call the IDXGIResource::GetUsage method for such buffers, they have the
    ///             DXGI_USAGE_READ_ONLY flag set.
    ///    riid = Type: <b>REFIID</b> The type of interface used to manipulate the buffer.
    ///    ppSurface = Type: <b>void**</b> A pointer to a back-buffer interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT GetBuffer(uint Buffer, const(GUID)* riid, void** ppSurface);
    ///Sets the display state to windowed or full screen.
    ///Params:
    ///    Fullscreen = Type: <b>BOOL</b> A Boolean value that specifies whether to set the display state to windowed or full screen.
    ///                 <b>TRUE</b> for full screen, and <b>FALSE</b> for windowed.
    ///    pTarget = Type: [in, optional] <b>IDXGIOutput*</b> If you pass <b>TRUE</b> to the <i>Fullscreen</i> parameter to set
    ///              the display state to full screen, you can optionally set this parameter to a pointer to an IDXGIOutput
    ///              interface for the output target that contains the swap chain. If you set this parameter to <b>NULL</b>, DXGI
    ///              will choose the output based on the swap-chain's device and the output window's placement. If you pass
    ///              <b>FALSE</b> to <i>Fullscreen</i>, then you must set this parameter to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of these values. - **S_OK** if the action succeeded and the swap
    ///    chain was placed in the requested state. - **DXGI_ERROR_NOT_CURRENTLY_AVAILABLE** if the action failed. When
    ///    this error is returned, your application can continue to run in windowed mode and try to switch to
    ///    full-screen mode later. There are many reasons why a windowed-mode swap chain cannot switch to full-screen
    ///    mode. Here are some examples. - The application is running over Terminal Server. - The output window is
    ///    occluded. - The output window does not have keyboard focus. - Another application is already in full-screen
    ///    mode. - **DXGI_STATUS_MODE_CHANGE_IN_PROGRESS** is returned if a fullscreen/windowed mode transition is
    ///    occurring when this API is called. - Other error codes if you run out of memory or encounter another
    ///    unexpected fault; these codes may be treated as hard, non-continuable errors.
    ///    
    HRESULT SetFullscreenState(BOOL Fullscreen, IDXGIOutput pTarget);
    ///Get the state associated with full-screen mode.
    ///Params:
    ///    pFullscreen = Type: <b>BOOL*</b> A pointer to a boolean whose value is either: <ul> <li><b>TRUE</b> if the swap chain is in
    ///                  full-screen mode</li> <li><b>FALSE</b> if the swap chain is in windowed mode</li> </ul>
    ///    ppTarget = Type: <b>IDXGIOutput**</b> A pointer to the output target (see IDXGIOutput) when the mode is full screen;
    ///               otherwise <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT GetFullscreenState(BOOL* pFullscreen, IDXGIOutput* ppTarget);
    ///<p class="CCE_Message">[Starting with Direct3D 11.1, we recommend not to use <b>GetDesc</b> anymore to get a
    ///description of the swap chain. Instead, use IDXGISwapChain1::GetDesc1.] Get a description of the swap chain.
    ///Params:
    ///    pDesc = Type: <b>DXGI_SWAP_CHAIN_DESC*</b> A pointer to the swap-chain description (see DXGI_SWAP_CHAIN_DESC).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT GetDesc(DXGI_SWAP_CHAIN_DESC* pDesc);
    ///Changes the swap chain's back buffer size, format, and number of buffers. This should be called when the
    ///application window is resized.
    ///Params:
    ///    BufferCount = Type: <b>UINT</b> The number of buffers in the swap chain (including all back and front buffers). This number
    ///                  can be different from the number of buffers with which you created the swap chain. This number can't be
    ///                  greater than <b>DXGI_MAX_SWAP_CHAIN_BUFFERS</b>. Set this number to zero to preserve the existing number of
    ///                  buffers in the swap chain. You can't specify less than two buffers for the flip presentation model.
    ///    Width = Type: <b>UINT</b> The new width of the back buffer. If you specify zero, DXGI will use the width of the
    ///            client area of the target window. You can't specify the width as zero if you called the
    ///            IDXGIFactory2::CreateSwapChainForComposition method to create the swap chain for a composition surface.
    ///    Height = Type: <b>UINT</b> The new height of the back buffer. If you specify zero, DXGI will use the height of the
    ///             client area of the target window. You can't specify the height as zero if you called the
    ///             IDXGIFactory2::CreateSwapChainForComposition method to create the swap chain for a composition surface.
    ///    NewFormat = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT-typed value for the new format of the back buffer. Set this value to
    ///                DXGI_FORMAT_UNKNOWN to preserve the existing format of the back buffer. The flip presentation model supports
    ///                a more restricted set of formats than the bit-block transfer (bitblt) model.
    ///    SwapChainFlags = Type: <b>UINT</b> A combination of DXGI_SWAP_CHAIN_FLAG-typed values that are combined by using a bitwise OR
    ///                     operation. The resulting value specifies options for swap-chain behavior.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
    ///    DXGI_ERROR.
    ///    
    HRESULT ResizeBuffers(uint BufferCount, uint Width, uint Height, DXGI_FORMAT NewFormat, uint SwapChainFlags);
    ///Resizes the output target.
    ///Params:
    ///    pNewTargetParameters = Type: <b>const DXGI_MODE_DESC*</b> A pointer to a DXGI_MODE_DESC structure that describes the mode, which
    ///                           specifies the new width, height, format, and refresh rate of the target. If the format is
    ///                           DXGI_FORMAT_UNKNOWN, <b>ResizeTarget</b> uses the existing format. We only recommend that you use
    ///                           <b>DXGI_FORMAT_UNKNOWN</b> when the swap chain is in full-screen mode as this method is not thread safe.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns a code that indicates success or failure.
    ///    <b>DXGI_STATUS_MODE_CHANGE_IN_PROGRESS</b> is returned if a full-screen/windowed mode transition is occurring
    ///    when this API is called. See DXGI_ERROR for additional DXGI error codes.
    ///    
    HRESULT ResizeTarget(const(DXGI_MODE_DESC)* pNewTargetParameters);
    ///Get the output (the display monitor) that contains the majority of the client area of the target window.
    ///Params:
    ///    ppOutput = Type: <b>IDXGIOutput**</b> A pointer to the output interface (see IDXGIOutput).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following DXGI_ERROR.
    ///    
    HRESULT GetContainingOutput(IDXGIOutput* ppOutput);
    ///Gets performance statistics about the last render frame.
    ///Params:
    ///    pStats = Type: <b>DXGI_FRAME_STATISTICS*</b> A pointer to a DXGI_FRAME_STATISTICS structure for the frame statistics.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
    ///Gets the number of times that IDXGISwapChain::Present or IDXGISwapChain1::Present1 has been called.
    ///Params:
    ///    pLastPresentCount = Type: <b>UINT*</b> A pointer to a variable that receives the number of calls.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the DXGI_ERROR values.
    ///    
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
}

///An <b>IDXGIFactory</b> interface implements methods for generating DXGI objects (which handle full screen
///transitions).
@GUID("7B7166EC-21C7-44AE-B21A-C9AE321AE369")
interface IDXGIFactory : IDXGIObject
{
    ///Enumerates the adapters (video cards).
    ///Params:
    ///    Adapter = Type: <b>UINT</b> The index of the adapter to enumerate.
    ///    ppAdapter = Type: <b>IDXGIAdapter**</b> The address of a pointer to an IDXGIAdapter interface at the position specified
    ///                by the <i>Adapter</i> parameter. This parameter must not be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns DXGI_ERROR_NOT_FOUND if the index is
    ///    greater than or equal to the number of adapters in the local system, or DXGI_ERROR_INVALID_CALL if
    ///    <i>ppAdapter</i> parameter is <b>NULL</b>.
    ///    
    HRESULT EnumAdapters(uint Adapter, IDXGIAdapter* ppAdapter);
    ///Allows DXGI to monitor an application's message queue for the alt-enter key sequence (which causes the
    ///application to switch from windowed to full screen or vice versa).
    ///Params:
    ///    WindowHandle = Type: <b>HWND</b> The handle of the window that is to be monitored. This parameter can be <b>NULL</b>; but
    ///                   only if *Flags* is also 0.
    ///    Flags = Type: <b>UINT</b> One or more of the following values. <ul> <li>DXGI_MWA_NO_WINDOW_CHANGES - Prevent DXGI
    ///            from monitoring an applications message queue; this makes DXGI unable to respond to mode changes.</li>
    ///            <li>DXGI_MWA_NO_ALT_ENTER - Prevent DXGI from responding to an alt-enter sequence.</li>
    ///            <li>DXGI_MWA_NO_PRINT_SCREEN - Prevent DXGI from responding to a print-screen key.</li> </ul>
    ///Returns:
    ///    Type: <b>HRESULT</b> DXGI_ERROR_INVALID_CALL if <i>WindowHandle</i> is invalid, or E_OUTOFMEMORY.
    ///    
    HRESULT MakeWindowAssociation(HWND WindowHandle, uint Flags);
    ///Get the window through which the user controls the transition to and from full screen.
    ///Params:
    ///    pWindowHandle = Type: <b>HWND*</b> A pointer to a window handle.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns a code that indicates success or failure. <b>S_OK</b> indicates success,
    ///    DXGI_ERROR_INVALID_CALL indicates <i>pWindowHandle</i> was passed in as <b>NULL</b>.
    ///    
    HRESULT GetWindowAssociation(HWND* pWindowHandle);
    ///<p class="CCE_Message">[Starting with Direct3D 11.1, we recommend not to use <b>CreateSwapChain</b> anymore to
    ///create a swap chain. Instead, use CreateSwapChainForHwnd, CreateSwapChainForCoreWindow, or
    ///CreateSwapChainForComposition depending on how you want to create the swap chain.] Creates a swap chain.
    ///Params:
    ///    pDevice = Type: <b>IUnknown*</b> For Direct3D 11, and earlier versions of Direct3D, this is a pointer to the Direct3D
    ///              device for the swap chain. For Direct3D 12 this is a pointer to a direct command queue (refer to
    ///              ID3D12CommandQueue) . This parameter cannot be <b>NULL</b>.
    ///    pDesc = Type: <b>DXGI_SWAP_CHAIN_DESC*</b> A pointer to a DXGI_SWAP_CHAIN_DESC structure for the swap-chain
    ///            description. This parameter cannot be <b>NULL</b>.
    ///    ppSwapChain = Type: <b>IDXGISwapChain**</b> A pointer to a variable that receives a pointer to the IDXGISwapChain interface
    ///                  for the swap chain that <b>CreateSwapChain</b> creates.
    ///Returns:
    ///    Type: <b>HRESULT</b> DXGI_ERROR_INVALID_CALL if <i>pDesc</i> or <i>ppSwapChain</i> is <b>NULL</b>,
    ///    DXGI_STATUS_OCCLUDED if you request full-screen mode and it is unavailable, or E_OUTOFMEMORY. Other error
    ///    codes defined by the type of device passed in may also be returned.
    ///    
    HRESULT CreateSwapChain(IUnknown pDevice, DXGI_SWAP_CHAIN_DESC* pDesc, IDXGISwapChain* ppSwapChain);
    ///Create an adapter interface that represents a software adapter.
    ///Params:
    ///    Module = Type: <b>HMODULE</b> Handle to the software adapter's dll. HMODULE can be obtained with GetModuleHandle or
    ///             LoadLibrary.
    ///    ppAdapter = Type: <b>IDXGIAdapter**</b> Address of a pointer to an adapter (see IDXGIAdapter).
    ///Returns:
    ///    Type: <b>HRESULT</b> A return code indicating success or failure.
    ///    
    HRESULT CreateSoftwareAdapter(ptrdiff_t Module, IDXGIAdapter* ppAdapter);
}

///An <b>IDXGIDevice</b> interface implements a derived class for DXGI objects that produce image data.
@GUID("54EC77FA-1377-44E6-8C32-88FD5F44C84C")
interface IDXGIDevice : IDXGIObject
{
    ///Returns the adapter for the specified device.
    ///Params:
    ///    pAdapter = Type: <b>IDXGIAdapter**</b> The address of an IDXGIAdapter interface pointer to the adapter. This parameter
    ///               must not be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the DXGI_ERROR that indicates
    ///    failure. If the <i>pAdapter</i> parameter is <b>NULL</b> this method returns E_INVALIDARG.
    ///    
    HRESULT GetAdapter(IDXGIAdapter* pAdapter);
    ///Returns a surface. This method is used internally and you should not call it directly in your application.
    ///Params:
    ///    pDesc = Type: <b>const DXGI_SURFACE_DESC*</b> A pointer to a DXGI_SURFACE_DESC structure that describes the surface.
    ///    NumSurfaces = Type: <b>UINT</b> The number of surfaces to create.
    ///    Usage = Type: <b>DXGI_USAGE</b> A DXGI_USAGE flag that specifies how the surface is expected to be used.
    ///    pSharedResource = Type: <b>const DXGI_SHARED_RESOURCE*</b> An optional pointer to a DXGI_SHARED_RESOURCE structure that
    ///                      contains shared resource information for opening views of such resources.
    ///    ppSurface = Type: <b>IDXGISurface**</b> The address of an IDXGISurface interface pointer to the first created surface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
    ///    DXGI_ERROR.
    ///    
    HRESULT CreateSurface(const(DXGI_SURFACE_DESC)* pDesc, uint NumSurfaces, uint Usage, 
                          const(DXGI_SHARED_RESOURCE)* pSharedResource, IDXGISurface* ppSurface);
    ///Gets the residency status of an array of resources.
    ///Params:
    ///    ppResources = Type: <b>IUnknown*</b> An array of IDXGIResource interfaces.
    ///    pResidencyStatus = Type: <b>DXGI_RESIDENCY*</b> An array of DXGI_RESIDENCY flags. Each element describes the residency status
    ///                       for corresponding element in the <i>ppResources</i> argument array.
    ///    NumResources = Type: <b>UINT</b> The number of resources in the <i>ppResources</i> argument array and
    ///                   <i>pResidencyStatus</i> argument array.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns DXGI_ERROR_DEVICE_REMOVED, E_INVALIDARG,
    ///    or E_POINTER (see Common HRESULT Values and WinError.h for more information).
    ///    
    HRESULT QueryResourceResidency(IUnknown* ppResources, DXGI_RESIDENCY* pResidencyStatus, uint NumResources);
    ///Sets the GPU thread priority.
    ///Params:
    ///    Priority = Type: <b>INT</b> A value that specifies the required GPU thread priority. This value must be between -7 and
    ///               7, inclusive, where 0 represents normal priority.
    ///Returns:
    ///    Type: <b>HRESULT</b> Return S_OK if successful; otherwise, returns E_INVALIDARG if the <i>Priority</i>
    ///    parameter is invalid.
    ///    
    HRESULT SetGPUThreadPriority(int Priority);
    ///Gets the GPU thread priority.
    ///Params:
    ///    pPriority = Type: <b>INT*</b> A pointer to a variable that receives a value that indicates the current GPU thread
    ///                priority. The value will be between -7 and 7, inclusive, where 0 represents normal priority.
    ///Returns:
    ///    Type: <b>HRESULT</b> Return S_OK if successful; otherwise, returns E_POINTER if the <i>pPriority</i>
    ///    parameter is <b>NULL</b>.
    ///    
    HRESULT GetGPUThreadPriority(int* pPriority);
}

///The <b>IDXGIFactory1</b> interface implements methods for generating DXGI objects.
@GUID("770AAE78-F26F-4DBA-A829-253C83D1B387")
interface IDXGIFactory1 : IDXGIFactory
{
    ///Enumerates both adapters (video cards) with or without outputs.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> The index of the adapter to enumerate.
    ///    ppAdapter = Type: <b>IDXGIAdapter1**</b> The address of a pointer to an IDXGIAdapter1 interface at the position specified
    ///                by the <i>Adapter</i> parameter. This parameter must not be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns DXGI_ERROR_NOT_FOUND if the index is
    ///    greater than or equal to the number of adapters in the local system, or DXGI_ERROR_INVALID_CALL if
    ///    <i>ppAdapter</i> parameter is <b>NULL</b>.
    ///    
    HRESULT EnumAdapters1(uint Adapter, IDXGIAdapter1* ppAdapter);
    ///Informs an application of the possible need to re-enumerate adapters.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>FALSE</b>, if a new adapter is becoming available or the current adapter is going away.
    ///    <b>TRUE</b>, no adapter changes. <b>IsCurrent</b> returns <b>FALSE</b> to inform the calling application to
    ///    re-enumerate adapters.
    ///    
    BOOL    IsCurrent();
}

///The <b>IDXGIAdapter1</b> interface represents a display sub-system (including one or more GPU's, DACs and video
///memory).
@GUID("29038F61-3839-4626-91FD-086879011A05")
interface IDXGIAdapter1 : IDXGIAdapter
{
    ///Gets a DXGI 1.1 description of an adapter (or video card).
    ///Params:
    ///    pDesc = Type: <b>DXGI_ADAPTER_DESC1*</b> A pointer to a DXGI_ADAPTER_DESC1 structure that describes the adapter. This
    ///            parameter must not be <b>NULL</b>. On feature level 9 graphics hardware, <b>GetDesc1</b> returns zeros for
    ///            the PCI ID in the <b>VendorId</b>, <b>DeviceId</b>, <b>SubSysId</b>, and <b>Revision</b> members of
    ///            <b>DXGI_ADAPTER_DESC1</b> and “Software Adapter” for the description string in the <b>Description</b>
    ///            member.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns E_INVALIDARG if the <i>pDesc</i>
    ///    parameter is <b>NULL</b>.
    ///    
    HRESULT GetDesc1(DXGI_ADAPTER_DESC1* pDesc);
}

///An <b>IDXGIDevice1</b> interface implements a derived class for DXGI objects that produce image data.
@GUID("77DB970F-6276-48BA-BA28-070143B4392C")
interface IDXGIDevice1 : IDXGIDevice
{
    ///Sets the number of frames that the system is allowed to queue for rendering.
    ///Params:
    ///    MaxLatency = Type: <b>UINT</b> The maximum number of back buffer frames that a driver can queue. The value defaults to 3,
    ///                 but can range from 1 to 16. A value of 0 will reset latency to the default. For multi-head devices, this
    ///                 value is specified per-head.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, DXGI_ERROR_DEVICE_REMOVED if the device was
    ///    removed.
    ///    
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    ///Gets the number of frames that the system is allowed to queue for rendering.
    ///Params:
    ///    pMaxLatency = Type: <b>UINT*</b> This value is set to the number of frames that can be queued for render. This value
    ///                  defaults to 3, but can range from 1 to 16.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; otherwise, returns one of the following members of the
    ///    D3DERR enumerated type: <ul> <li><b>D3DERR_DEVICELOST</b></li> <li><b>D3DERR_DEVICEREMOVED</b></li>
    ///    <li><b>D3DERR_DRIVERINTERNALERROR</b></li> <li><b>D3DERR_INVALIDCALL</b></li>
    ///    <li><b>D3DERR_OUTOFVIDEOMEMORY</b></li> </ul>
    ///    
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
}

///The <b>IDXGIDisplayControl</b> interface exposes methods to indicate user preference for the operating system's
///stereoscopic 3D display behavior and to set stereoscopic 3D display status to enable or disable. We recommend that
///you not use <b>IDXGIDisplayControl</b> to query or set system-wide stereoscopic 3D settings in your stereoscopic 3D
///apps. Instead, for your windowed apps, call the IDXGIFactory2::IsWindowedStereoEnabled method to determine whether to
///render in stereo; for your full-screen apps, call the IDXGIOutput1::GetDisplayModeList1 method and then determine
///whether any of the returned display modes support rendering in stereo.
@GUID("EA9DBF1A-C88E-4486-854A-98AA0138F30C")
interface IDXGIDisplayControl : IUnknown
{
    ///Retrieves a Boolean value that indicates whether the operating system's stereoscopic 3D display behavior is
    ///enabled.
    ///Returns:
    ///    <b>IsStereoEnabled</b> returns TRUE when the operating system's stereoscopic 3D display behavior is enabled
    ///    and FALSE when this behavior is disabled. <b>Platform Update for Windows 7: </b>On Windows 7 or Windows
    ///    Server 2008 R2 with the Platform Update for Windows 7 installed, <b>IsStereoEnabled</b> always returns FALSE
    ///    because stereoscopic 3D display behavior isn’t available with the Platform Update for Windows 7. For more
    ///    info about the Platform Update for Windows 7, see Platform Update for Windows 7.
    ///    
    BOOL IsStereoEnabled();
    ///Set a Boolean value to either enable or disable the operating system's stereoscopic 3D display behavior.
    ///Params:
    ///    enabled = A Boolean value that either enables or disables the operating system's stereoscopic 3D display behavior. TRUE
    ///              enables the operating system's stereoscopic 3D display behavior and FALSE disables it.
    void SetStereoEnabled(BOOL enabled);
}

///The <b>IDXGIOutputDuplication</b> interface accesses and manipulates the duplicated desktop image.
@GUID("191CFAC3-A341-470D-B26E-A864F428319C")
interface IDXGIOutputDuplication : IDXGIObject
{
    ///Retrieves a description of a duplicated output. This description specifies the dimensions of the surface that
    ///contains the desktop image.
    ///Params:
    ///    pDesc = A pointer to a DXGI_OUTDUPL_DESC structure that describes the duplicated output. This parameter must not be
    ///            <b>NULL</b>.
    void    GetDesc(DXGI_OUTDUPL_DESC* pDesc);
    ///Indicates that the application is ready to process the next desktop image.
    ///Params:
    ///    TimeoutInMilliseconds = The time-out interval, in milliseconds. This interval specifies the amount of time that this method waits for
    ///                            a new frame before it returns to the caller. This method returns if the interval elapses, and a new desktop
    ///                            image is not available. For more information about the time-out interval, see Remarks.
    ///    pFrameInfo = A pointer to a memory location that receives the DXGI_OUTDUPL_FRAME_INFO structure that describes timing and
    ///                 presentation statistics for a frame.
    ///    ppDesktopResource = A pointer to a variable that receives the IDXGIResource interface of the surface that contains the desktop
    ///                        bitmap.
    ///Returns:
    ///    <b>AcquireNextFrame</b> returns: <ul> <li>S_OK if it successfully received the next desktop image.</li>
    ///    <li>DXGI_ERROR_ACCESS_LOST if the desktop duplication interface is invalid. The desktop duplication interface
    ///    typically becomes invalid when a different type of image is displayed on the desktop. Examples of this
    ///    situation are: <ul> <li>Desktop switch</li> <li>Mode change</li> <li>Switch from DWM on, DWM off, or other
    ///    full-screen application</li> </ul>In this situation, the application must release the IDXGIOutputDuplication
    ///    interface and create a new <b>IDXGIOutputDuplication</b> for the new content.</li>
    ///    <li>DXGI_ERROR_WAIT_TIMEOUT if the time-out interval elapsed before the next desktop frame was
    ///    available.</li> <li>DXGI_ERROR_INVALID_CALL if the application called <b>AcquireNextFrame</b> without
    ///    releasing the previous frame.</li> <li>E_INVALIDARG if one of the parameters to <b>AcquireNextFrame</b> is
    ///    incorrect; for example, if <i>pFrameInfo</i> is NULL.</li> <li>Possibly other error codes that are described
    ///    in the DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT AcquireNextFrame(uint TimeoutInMilliseconds, DXGI_OUTDUPL_FRAME_INFO* pFrameInfo, 
                             IDXGIResource* ppDesktopResource);
    ///Gets information about dirty rectangles for the current desktop frame.
    ///Params:
    ///    DirtyRectsBufferSize = The size in bytes of the buffer that the caller passed to the <i>pDirtyRectsBuffer</i> parameter.
    ///    pDirtyRectsBuffer = A pointer to an array of RECT structures that identifies the dirty rectangle regions for the desktop frame.
    ///    pDirtyRectsBufferSizeRequired = Pointer to a variable that receives the number of bytes that <b>GetFrameDirtyRects</b> needs to store
    ///                                    information about dirty regions in the buffer at <i>pDirtyRectsBuffer</i>. For more information about
    ///                                    returning the required buffer size, see Remarks.
    ///Returns:
    ///    <b>GetFrameDirtyRects</b> returns: <ul> <li>S_OK if it successfully retrieved information about dirty
    ///    rectangles.</li> <li>DXGI_ERROR_ACCESS_LOST if the desktop duplication interface is invalid. The desktop
    ///    duplication interface typically becomes invalid when a different type of image is displayed on the desktop.
    ///    Examples of this situation are: <ul> <li>Desktop switch</li> <li>Mode change</li> <li>Switch from DWM on, DWM
    ///    off, or other full-screen application</li> </ul>In this situation, the application must release the
    ///    IDXGIOutputDuplication interface and create a new <b>IDXGIOutputDuplication</b> for the new content.</li>
    ///    <li>DXGI_ERROR_MORE_DATA if the buffer that the calling application provided was not big enough.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the application called <b>GetFrameDirtyRects</b> without owning the desktop
    ///    image.</li> <li>E_INVALIDARG if one of the parameters to <b>GetFrameDirtyRects</b> is incorrect; for example,
    ///    if <i>pDirtyRectsBuffer</i> is NULL.</li> <li>Possibly other error codes that are described in the DXGI_ERROR
    ///    topic.</li> </ul>
    ///    
    HRESULT GetFrameDirtyRects(uint DirtyRectsBufferSize, RECT* pDirtyRectsBuffer, 
                               uint* pDirtyRectsBufferSizeRequired);
    ///Gets information about the moved rectangles for the current desktop frame.
    ///Params:
    ///    MoveRectsBufferSize = The size in bytes of the buffer that the caller passed to the <i>pMoveRectBuffer</i> parameter.
    ///    pMoveRectBuffer = A pointer to an array of DXGI_OUTDUPL_MOVE_RECT structures that identifies the moved rectangle regions for
    ///                      the desktop frame.
    ///    pMoveRectsBufferSizeRequired = Pointer to a variable that receives the number of bytes that <b>GetFrameMoveRects</b> needs to store
    ///                                   information about moved regions in the buffer at <i>pMoveRectBuffer</i>. For more information about returning
    ///                                   the required buffer size, see Remarks.
    ///Returns:
    ///    <b>GetFrameMoveRects</b> returns: <ul> <li>S_OK if it successfully retrieved information about moved
    ///    rectangles.</li> <li>DXGI_ERROR_ACCESS_LOST if the desktop duplication interface is invalid. The desktop
    ///    duplication interface typically becomes invalid when a different type of image is displayed on the desktop.
    ///    Examples of this situation are: <ul> <li>Desktop switch</li> <li>Mode change</li> <li>Switch from DWM on, DWM
    ///    off, or other full-screen application</li> </ul>In this situation, the application must release the
    ///    IDXGIOutputDuplication interface and create a new <b>IDXGIOutputDuplication</b> for the new content.</li>
    ///    <li>DXGI_ERROR_MORE_DATA if the buffer that the calling application provided is not big enough.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the application called <b>GetFrameMoveRects</b> without owning the desktop
    ///    image.</li> <li>E_INVALIDARG if one of the parameters to <b>GetFrameMoveRects</b> is incorrect; for example,
    ///    if <i>pMoveRectBuffer</i> is NULL.</li> <li>Possibly other error codes that are described in the DXGI_ERROR
    ///    topic.</li> </ul>
    ///    
    HRESULT GetFrameMoveRects(uint MoveRectsBufferSize, DXGI_OUTDUPL_MOVE_RECT* pMoveRectBuffer, 
                              uint* pMoveRectsBufferSizeRequired);
    ///Gets information about the new pointer shape for the current desktop frame.
    ///Params:
    ///    PointerShapeBufferSize = The size in bytes of the buffer that the caller passed to the <i>pPointerShapeBuffer</i> parameter.
    ///    pPointerShapeBuffer = A pointer to a buffer to which <b>GetFramePointerShape</b> copies and returns pixel data for the new pointer
    ///                          shape.
    ///    pPointerShapeBufferSizeRequired = Pointer to a variable that receives the number of bytes that <b>GetFramePointerShape</b> needs to store the
    ///                                      new pointer shape pixel data in the buffer at <i>pPointerShapeBuffer</i>. For more information about
    ///                                      returning the required buffer size, see Remarks.
    ///    pPointerShapeInfo = Pointer to a DXGI_OUTDUPL_POINTER_SHAPE_INFO structure that receives the pointer shape information.
    ///Returns:
    ///    <b>GetFramePointerShape</b> returns: <ul> <li>S_OK if it successfully retrieved information about the new
    ///    pointer shape.</li> <li>DXGI_ERROR_ACCESS_LOST if the desktop duplication interface is invalid. The desktop
    ///    duplication interface typically becomes invalid when a different type of image is displayed on the desktop.
    ///    Examples of this situation are: <ul> <li>Desktop switch</li> <li>Mode change</li> <li>Switch from DWM on, DWM
    ///    off, or other full-screen application</li> </ul>In this situation, the application must release the
    ///    IDXGIOutputDuplication interface and create a new <b>IDXGIOutputDuplication</b> for the new content.</li>
    ///    <li>DXGI_ERROR_MORE_DATA if the buffer that the calling application provided was not big enough.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the application called <b>GetFramePointerShape</b> without owning the desktop
    ///    image.</li> <li>E_INVALIDARG if one of the parameters to <b>GetFramePointerShape</b> is incorrect; for
    ///    example, if <i>pPointerShapeInfo</i> is NULL.</li> <li>Possibly other error codes that are described in the
    ///    DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT GetFramePointerShape(uint PointerShapeBufferSize, void* pPointerShapeBuffer, 
                                 uint* pPointerShapeBufferSizeRequired, 
                                 DXGI_OUTDUPL_POINTER_SHAPE_INFO* pPointerShapeInfo);
    ///Provides the CPU with efficient access to a desktop image if that desktop image is already in system memory.
    ///Params:
    ///    pLockedRect = A pointer to a DXGI_MAPPED_RECT structure that receives the surface data that the CPU needs to directly
    ///                  access the surface data.
    ///Returns:
    ///    <b>MapDesktopSurface</b> returns: <ul> <li>S_OK if it successfully retrieved the surface data.</li>
    ///    <li>DXGI_ERROR_ACCESS_LOST if the desktop duplication interface is invalid. The desktop duplication interface
    ///    typically becomes invalid when a different type of image is displayed on the desktop. Examples of this
    ///    situation are: <ul> <li>Desktop switch</li> <li>Mode change</li> <li>Switch from DWM on, DWM off, or other
    ///    full-screen application</li> </ul>In this situation, the application must release the IDXGIOutputDuplication
    ///    interface and create a new <b>IDXGIOutputDuplication</b> for the new content.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the application already has an outstanding map on the desktop image. The
    ///    application must call UnMapDesktopSurface before it calls <b>MapDesktopSurface</b> again.
    ///    DXGI_ERROR_INVALID_CALL is also returned if the application did not own the desktop image when it called
    ///    <b>MapDesktopSurface</b>.</li> <li>DXGI_ERROR_UNSUPPORTED if the desktop image is not in system memory. In
    ///    this situation, the application must first transfer the image to a staging surface and then lock the image by
    ///    calling the IDXGISurface::Map method.</li> <li>E_INVALIDARG if the <i>pLockedRect</i> parameter is incorrect;
    ///    for example, if <i>pLockedRect</i> is <b>NULL</b>.</li> <li>Possibly other error codes that are described in
    ///    the DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT MapDesktopSurface(DXGI_MAPPED_RECT* pLockedRect);
    ///Invalidates the pointer to the desktop image that was retrieved by using
    ///IDXGIOutputDuplication::MapDesktopSurface.
    ///Returns:
    ///    <b>UnMapDesktopSurface</b> returns: <ul> <li>S_OK if it successfully completed.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the application did not map the desktop surface by calling
    ///    IDXGIOutputDuplication::MapDesktopSurface.</li> <li>Possibly other error codes that are described in the
    ///    DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT UnMapDesktopSurface();
    ///Indicates that the application finished processing the frame.
    ///Returns:
    ///    <b>ReleaseFrame</b> returns: <ul> <li>S_OK if it successfully completed.</li> <li>DXGI_ERROR_INVALID_CALL if
    ///    the application already released the frame.</li> <li>DXGI_ERROR_ACCESS_LOST if the desktop duplication
    ///    interface is invalid. The desktop duplication interface typically becomes invalid when a different type of
    ///    image is displayed on the desktop. Examples of this situation are: <ul> <li>Desktop switch</li> <li>Mode
    ///    change</li> <li>Switch from DWM on, DWM off, or other full-screen application</li> </ul>In this situation,
    ///    the application must release the IDXGIOutputDuplication interface and create a new
    ///    <b>IDXGIOutputDuplication</b> for the new content.</li> <li>Possibly other error codes that are described in
    ///    the DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT ReleaseFrame();
}

///The <b>IDXGISurface2</b> interface extends the IDXGISurface1 interface by adding support for subresource surfaces and
///getting a handle to a shared resource.
@GUID("ABA496DD-B617-4CB8-A866-BC44D7EB1FA2")
interface IDXGISurface2 : IDXGISurface1
{
    ///Gets the parent resource and subresource index that support a subresource surface.
    ///Params:
    ///    riid = The globally unique identifier (GUID) of the requested interface type.
    ///    ppParentResource = A pointer to a buffer that receives a pointer to the parent resource object for the subresource surface.
    ///    pSubresourceIndex = A pointer to a variable that receives the index of the subresource surface.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns one of the following values: <ul> <li>E_NOINTERFACE if the
    ///    object does not implement the GUID that the <i>riid</i> parameter specifies.</li> <li>Possibly other error
    ///    codes that are described in the DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT GetResource(const(GUID)* riid, void** ppParentResource, uint* pSubresourceIndex);
}

///An <b>IDXGIResource1</b> interface extends the IDXGIResource interface by adding support for creating a subresource
///surface object and for creating a handle to a shared resource.
@GUID("30961379-4609-4A41-998E-54FE567EE0C1")
interface IDXGIResource1 : IDXGIResource
{
    ///Creates a subresource surface object.
    ///Params:
    ///    index = The index of the subresource surface object to enumerate.
    ///    ppSurface = The address of a pointer to a IDXGISurface2 interface that represents the created subresource surface object
    ///                at the position specified by the <i>index</i> parameter.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns one of the following values: <ul> <li>DXGI_ERROR_INVALID_CALL
    ///    if the index is out of range or if the subresource is not a valid surface.</li> <li>E_OUTOFMEMORY if
    ///    insufficient memory is available to create the subresource surface object.</li> </ul> A subresource is a
    ///    valid surface if the original resource would have been a valid surface had its array size been equal to 1.
    ///    
    HRESULT CreateSubresourceSurface(uint index, IDXGISurface2* ppSurface);
    ///Creates a handle to a shared resource. You can then use the returned handle with multiple Direct3D devices.
    ///Params:
    ///    pAttributes = A pointer to a SECURITY_ATTRIBUTES structure that contains two separate but related data members: an optional
    ///                  security descriptor, and a Boolean value that determines whether child processes can inherit the returned
    ///                  handle. Set this parameter to <b>NULL</b> if you want child processes that the application might create to
    ///                  not inherit the handle returned by <b>CreateSharedHandle</b>, and if you want the resource that is associated
    ///                  with the returned handle to get a default security descriptor. The <b>lpSecurityDescriptor</b> member of the
    ///                  structure specifies a SECURITY_DESCRIPTOR for the resource. Set this member to <b>NULL</b> if you want the
    ///                  runtime to assign a default security descriptor to the resource that is associated with the returned handle.
    ///                  The ACLs in the default security descriptor for the resource come from the primary or impersonation token of
    ///                  the creator. For more info, see Synchronization Object Security and Access Rights.
    ///    dwAccess = The requested access rights to the resource. In addition to the generic access rights, DXGI defines the
    ///               following values: <ul> <li><b>DXGI_SHARED_RESOURCE_READ</b> ( 0x80000000L ) - specifies read access to the
    ///               resource.</li> <li><b>DXGI_SHARED_RESOURCE_WRITE</b> ( 1 ) - specifies write access to the resource.</li>
    ///               </ul> You can combine these values by using a bitwise OR operation.
    ///    lpName = The name of the resource to share. The name is limited to MAX_PATH characters. Name comparison is case
    ///             sensitive. You will need the resource name if you call the ID3D11Device1::OpenSharedResourceByName method to
    ///             access the shared resource by name. If you instead call the ID3D11Device1::OpenSharedResource1 method to
    ///             access the shared resource by handle, set this parameter to <b>NULL</b>. If <i>lpName</i> matches the name of
    ///             an existing resource, <b>CreateSharedHandle</b> fails with DXGI_ERROR_NAME_ALREADY_EXISTS. This occurs
    ///             because these objects share the same namespace. The name can have a "Global\" or "Local\" prefix to
    ///             explicitly create the object in the global or session namespace. The remainder of the name can contain any
    ///             character except the backslash character (\\). For more information, see Kernel Object Namespaces. Fast user
    ///             switching is implemented using Terminal Services sessions. Kernel object names must follow the guidelines
    ///             outlined for Terminal Services so that applications can support multiple users. The object can be created in
    ///             a private namespace. For more information, see Object Namespaces.
    ///    pHandle = A pointer to a variable that receives the NT HANDLE value to the resource to share. You can use this handle
    ///              in calls to access the resource.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns one of the following values: <ul> <li>DXGI_ERROR_INVALID_CALL
    ///    if one of the parameters is invalid.</li> <li>DXGI_ERROR_NAME_ALREADY_EXISTS if the supplied name of the
    ///    resource to share is already associated with another resource.</li> <li>E_ACCESSDENIED if the object is being
    ///    created in a protected namespace.</li> <li>E_OUTOFMEMORY if sufficient memory is not available to create the
    ///    handle.</li> <li>Possibly other error codes that are described in the DXGI_ERROR topic. </li> </ul>
    ///    <b>Platform Update for Windows 7: </b>On Windows 7 or Windows Server 2008 R2 with the Platform Update for
    ///    Windows 7 installed, <b>CreateSharedHandle</b> fails with E_NOTIMPL. For more info about the Platform Update
    ///    for Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT CreateSharedHandle(const(SECURITY_ATTRIBUTES)* pAttributes, uint dwAccess, const(PWSTR) lpName, 
                               HANDLE* pHandle);
}

///The <b>IDXGIDevice2</b> interface implements a derived class for DXGI objects that produce image data. The interface
///exposes methods to block CPU processing until the GPU completes processing, and to offer resources to the operating
///system.
@GUID("05008617-FBFD-4051-A790-144884B4F6A9")
interface IDXGIDevice2 : IDXGIDevice1
{
    ///Allows the operating system to free the video memory of resources by discarding their content.
    ///Params:
    ///    NumResources = The number of resources in the <i>ppResources</i> argument array.
    ///    ppResources = An array of pointers to IDXGIResource interfaces for the resources to offer.
    ///    Priority = A DXGI_OFFER_RESOURCE_PRIORITY-typed value that indicates how valuable data is.
    ///Returns:
    ///    <b>OfferResources</b> returns: <ul> <li>S_OK if resources were successfully offered</li> <li>E_INVALIDARG if
    ///    a resource in the array or the priority is invalid</li> </ul>
    ///    
    HRESULT OfferResources(uint NumResources, IDXGIResource* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority);
    ///Restores access to resources that were previously offered by calling IDXGIDevice2::OfferResources.
    ///Params:
    ///    NumResources = The number of resources in the <i>ppResources</i> argument and <i>pDiscarded</i> argument arrays.
    ///    ppResources = An array of pointers to IDXGIResource interfaces for the resources to reclaim.
    ///    pDiscarded = A pointer to an array that receives Boolean values. Each value in the array corresponds to a resource at the
    ///                 same index that the <i>ppResources</i> parameter specifies. The runtime sets each Boolean value to TRUE if
    ///                 the corresponding resource’s content was discarded and is now undefined, or to FALSE if the corresponding
    ///                 resource’s old content is still intact. The caller can pass in <b>NULL</b>, if the caller intends to fill
    ///                 the resources with new content regardless of whether the old content was discarded.
    ///Returns:
    ///    <b>ReclaimResources</b> returns: <ul> <li>S_OK if resources were successfully reclaimed</li> <li>E_INVALIDARG
    ///    if the resources are invalid</li> </ul>
    ///    
    HRESULT ReclaimResources(uint NumResources, IDXGIResource* ppResources, BOOL* pDiscarded);
    ///Flushes any outstanding rendering commands and sets the specified event object to the signaled state after all
    ///previously submitted rendering commands complete.
    ///Params:
    ///    hEvent = A handle to the event object. The CreateEvent or OpenEvent function returns this handle. All types of event
    ///             objects (manual-reset, auto-reset, and so on) are supported. The handle must have the EVENT_MODIFY_STATE
    ///             access right. For more information about access rights, see Synchronization Object Security and Access
    ///             Rights.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; otherwise, returns one of the following values: <ul>
    ///    <li><b>E_OUTOFMEMORY</b> if insufficient memory is available to complete the operation.</li>
    ///    <li><b>E_INVALIDARG</b> if the parameter was validated and determined to be incorrect.</li> </ul> <b>Platform
    ///    Update for Windows 7: </b>On Windows 7 or Windows Server 2008 R2 with the Platform Update for Windows 7
    ///    installed, <b>EnqueueSetEvent</b> fails with E_NOTIMPL. For more info about the Platform Update for Windows
    ///    7, see Platform Update for Windows 7.
    ///    
    HRESULT EnqueueSetEvent(HANDLE hEvent);
}

///Provides presentation capabilities that are enhanced from IDXGISwapChain. These presentation capabilities consist of
///specifying dirty rectangles and scroll rectangle to optimize the presentation.
@GUID("790A45F7-0D42-4876-983A-0A55CFE6F4AA")
interface IDXGISwapChain1 : IDXGISwapChain
{
    ///Gets a description of the swap chain.
    ///Params:
    ///    pDesc = A pointer to a DXGI_SWAP_CHAIN_DESC1 structure that describes the swap chain.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT GetDesc1(DXGI_SWAP_CHAIN_DESC1* pDesc);
    ///Gets a description of a full-screen swap chain.
    ///Params:
    ///    pDesc = A pointer to a DXGI_SWAP_CHAIN_FULLSCREEN_DESC structure that describes the full-screen swap chain.
    ///Returns:
    ///    <b>GetFullscreenDesc</b> returns: <ul> <li>S_OK if it successfully retrieved the description of the
    ///    full-screen swap chain.</li> <li> DXGI_ERROR_INVALID_CALL for non-HWND swap chains or if <i>pDesc</i> is
    ///    <b>NULL</b>.</li> <li>Possibly other error codes that are described in the DXGI_ERROR topic. </li> </ul>
    ///    
    HRESULT GetFullscreenDesc(DXGI_SWAP_CHAIN_FULLSCREEN_DESC* pDesc);
    ///Retrieves the underlying HWND for this swap-chain object.
    ///Params:
    ///    pHwnd = A pointer to a variable that receives the HWND for the swap-chain object.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR. If
    ///    <i>pHwnd</i> receives <b>NULL</b> (that is, the swap chain is not HWND-based), <b>GetHwnd</b> returns
    ///    DXGI_ERROR_INVALID_CALL.
    ///    
    HRESULT GetHwnd(HWND* pHwnd);
    ///Retrieves the underlying CoreWindow object for this swap-chain object.
    ///Params:
    ///    refiid = A pointer to the globally unique identifier (GUID) of the CoreWindow object that is referenced by the
    ///             <i>ppUnk</i> parameter.
    ///    ppUnk = A pointer to a variable that receives a pointer to the CoreWindow object.
    ///Returns:
    ///    <b>GetCoreWindow</b> returns: <ul> <li>S_OK if it successfully retrieved the underlying CoreWindow
    ///    object.</li> <li> DXGI_ERROR_INVALID_CALL if <i>ppUnk</i> is <b>NULL</b>; that is, the swap chain is not
    ///    associated with a CoreWindow object.</li> <li>Any HRESULT that a call to QueryInterface to query for an
    ///    CoreWindow object might typically return.</li> <li>Possibly other error codes that are described in the
    ///    DXGI_ERROR topic. </li> </ul> <b>Platform Update for Windows 7: </b>On Windows 7 or Windows Server 2008 R2
    ///    with the Platform Update for Windows 7 installed, <b>GetCoreWindow</b> fails with E_NOTIMPL. For more info
    ///    about the Platform Update for Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT GetCoreWindow(const(GUID)* refiid, void** ppUnk);
    ///Presents a frame on the display screen.
    ///Params:
    ///    SyncInterval = An integer that specifies how to synchronize presentation of a frame with the vertical blank. For the
    ///                   bit-block transfer (bitblt) model (DXGI_SWAP_EFFECT_DISCARDor DXGI_SWAP_EFFECT_SEQUENTIAL), values are: <ul>
    ///                   <li>0 - The presentation occurs immediately, there is no synchronization.</li> <li>1 through 4 - Synchronize
    ///                   presentation after the <i>n</i>th vertical blank.</li> </ul> For the flip model
    ///                   (DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL), values are: <ul> <li>0 - Cancel the remaining time on the previously
    ///                   presented frame and discard this frame if a newer frame is queued. </li> <li>1 through 4 - Synchronize
    ///                   presentation for at least <i>n</i> vertical blanks.</li> </ul> For an example that shows how sync-interval
    ///                   values affect a flip presentation queue, see Remarks. If the update region straddles more than one output
    ///                   (each represented by IDXGIOutput1), <b>Present1</b> performs the synchronization to the output that contains
    ///                   the largest sub-rectangle of the target window's client area.
    ///    PresentFlags = An integer value that contains swap-chain presentation options. These options are defined by the DXGI_PRESENT
    ///                   constants.
    ///    pPresentParameters = A pointer to a DXGI_PRESENT_PARAMETERS structure that describes updated rectangles and scroll information of
    ///                         the frame to present.
    ///Returns:
    ///    Possible return values include: S_OK, DXGI_ERROR_DEVICE_REMOVED , DXGI_STATUS_OCCLUDED,
    ///    DXGI_ERROR_INVALID_CALL, or E_OUTOFMEMORY.
    ///    
    HRESULT Present1(uint SyncInterval, uint PresentFlags, const(DXGI_PRESENT_PARAMETERS)* pPresentParameters);
    ///Determines whether a swap chain supports “temporary mono.”
    ///Returns:
    ///    Indicates whether to use the swap chain in temporary mono mode. <b>TRUE</b> indicates that you can use
    ///    temporary-mono mode; otherwise, <b>FALSE</b>. <b>Platform Update for Windows 7: </b>On Windows 7 or Windows
    ///    Server 2008 R2 with the Platform Update for Windows 7 installed, <b>IsTemporaryMonoSupported</b> always
    ///    returns FALSE because stereoscopic 3D display behavior isn’t available with the Platform Update for Windows
    ///    7. For more info about the Platform Update for Windows 7, see Platform Update for Windows 7.
    ///    
    BOOL    IsTemporaryMonoSupported();
    ///Gets the output (the display monitor) to which you can restrict the contents of a present operation.
    ///Params:
    ///    ppRestrictToOutput = A pointer to a buffer that receives a pointer to the IDXGIOutput interface for the restrict-to output. An
    ///                         application passes this pointer to <b>IDXGIOutput</b> in a call to the IDXGIFactory2::CreateSwapChainForHwnd,
    ///                         IDXGIFactory2::CreateSwapChainForCoreWindow, or IDXGIFactory2::CreateSwapChainForComposition method to create
    ///                         the swap chain.
    ///Returns:
    ///    Returns S_OK if the restrict-to output was successfully retrieved; otherwise, returns E_INVALIDARG if the
    ///    pointer is invalid.
    ///    
    HRESULT GetRestrictToOutput(IDXGIOutput* ppRestrictToOutput);
    ///Changes the background color of the swap chain.
    ///Params:
    ///    pColor = A pointer to a DXGI_RGBA structure that specifies the background color to set.
    ///Returns:
    ///    <b>SetBackgroundColor</b> returns: <ul> <li>S_OK if it successfully set the background color.</li>
    ///    <li>E_INVALIDARG if the <i>pColor</i> parameter is incorrect, for example, <i>pColor</i> is NULL or any of
    ///    the floating-point values of the members of DXGI_RGBA to which <i>pColor</i> points are outside the range
    ///    from 0.0 through 1.0.</li> <li>Possibly other error codes that are described in the DXGI_ERROR topic.</li>
    ///    </ul> <b>Platform Update for Windows 7: </b>On Windows 7 or Windows Server 2008 R2 with the Platform Update
    ///    for Windows 7 installed, <b>SetBackgroundColor</b> fails with E_NOTIMPL. For more info about the Platform
    ///    Update for Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT SetBackgroundColor(const(DXGI_RGBA)* pColor);
    ///Retrieves the background color of the swap chain.
    ///Params:
    ///    pColor = A pointer to a DXGI_RGBA structure that receives the background color of the swap chain.
    ///Returns:
    ///    <b>GetBackgroundColor</b> returns: <ul> <li>S_OK if it successfully retrieves the background color.</li> <li>
    ///    DXGI_ERROR_INVALID_CALL if the <i>pColor</i> parameter is invalid, for example, <i>pColor</i> is NULL.</li>
    ///    <li>Possibly other error codes that are described in the DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT GetBackgroundColor(DXGI_RGBA* pColor);
    ///Sets the rotation of the back buffers for the swap chain.
    ///Params:
    ///    Rotation = A DXGI_MODE_ROTATION-typed value that specifies how to set the rotation of the back buffers for the swap
    ///               chain.
    ///Returns:
    ///    <b>SetRotation</b> returns: <ul> <li>S_OK if it successfully set the rotation.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the swap chain is bit-block transfer (bitblt) model. The swap chain must be
    ///    flip model to successfully call <b>SetRotation</b>.</li> <li>Possibly other error codes that are described in
    ///    the DXGI_ERROR topic.</li> </ul> <b>Platform Update for Windows 7: </b>On Windows 7 or Windows Server 2008 R2
    ///    with the Platform Update for Windows 7 installed, <b>SetRotation</b> fails with DXGI_ERROR_INVALID_CALL. For
    ///    more info about the Platform Update for Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT SetRotation(DXGI_MODE_ROTATION Rotation);
    ///Gets the rotation of the back buffers for the swap chain.
    ///Params:
    ///    pRotation = A pointer to a variable that receives a DXGI_MODE_ROTATION-typed value that specifies the rotation of the
    ///                back buffers for the swap chain.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR. <b>Platform
    ///    Update for Windows 7: </b>On Windows 7 or Windows Server 2008 R2 with the Platform Update for Windows 7
    ///    installed, <b>GetRotation</b> fails with DXGI_ERROR_INVALID_CALL. For more info about the Platform Update for
    ///    Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT GetRotation(DXGI_MODE_ROTATION* pRotation);
}

///The <b>IDXGIFactory2</b> interface includes methods to create a newer version swap chain with more features than
///IDXGISwapChain and to monitor stereoscopic 3D capabilities.
@GUID("50C83A1C-E072-4C48-87B0-3630FA36A6D0")
interface IDXGIFactory2 : IDXGIFactory1
{
    ///Determines whether to use stereo mode.
    ///Returns:
    ///    Indicates whether to use stereo mode. <b>TRUE</b> indicates that you can use stereo mode; otherwise,
    ///    <b>FALSE</b>. <b>Platform Update for Windows 7: </b>On Windows 7 or Windows Server 2008 R2 with the Platform
    ///    Update for Windows 7 installed, <b>IsWindowedStereoEnabled</b> always returns FALSE because stereoscopic 3D
    ///    display behavior isn’t available with the Platform Update for Windows 7. For more info about the Platform
    ///    Update for Windows 7, see Platform Update for Windows 7.
    ///    
    BOOL    IsWindowedStereoEnabled();
    ///Creates a swap chain that is associated with an HWND handle to the output window for the swap chain.
    ///Params:
    ///    pDevice = For Direct3D 11, and earlier versions of Direct3D, this is a pointer to the Direct3D device for the swap
    ///              chain. For Direct3D 12 this is a pointer to a direct command queue (refer to ID3D12CommandQueue). This
    ///              parameter cannot be <b>NULL</b>.
    ///    hWnd = The HWND handle that is associated with the swap chain that <b>CreateSwapChainForHwnd</b> creates. This
    ///           parameter cannot be <b>NULL</b>.
    ///    pDesc = A pointer to a DXGI_SWAP_CHAIN_DESC1 structure for the swap-chain description. This parameter cannot be
    ///            <b>NULL</b>.
    ///    pFullscreenDesc = A pointer to a DXGI_SWAP_CHAIN_FULLSCREEN_DESC structure for the description of a full-screen swap chain. You
    ///                      can optionally set this parameter to create a full-screen swap chain. Set it to <b>NULL</b> to create a
    ///                      windowed swap chain.
    ///    pRestrictToOutput = A pointer to the IDXGIOutput interface for the output to restrict content to. You must also pass the
    ///                        DXGI_PRESENT_RESTRICT_TO_OUTPUT flag in a IDXGISwapChain1::Present1 call to force the content to appear
    ///                        blacked out on any other output. If you want to restrict the content to a different output, you must create a
    ///                        new swap chain. However, you can conditionally restrict content based on the
    ///                        <b>DXGI_PRESENT_RESTRICT_TO_OUTPUT</b> flag. Set this parameter to <b>NULL</b> if you don't want to restrict
    ///                        content to an output target.
    ///    ppSwapChain = A pointer to a variable that receives a pointer to the IDXGISwapChain1 interface for the swap chain that
    ///                  <b>CreateSwapChainForHwnd</b> creates.
    ///Returns:
    ///    <b>CreateSwapChainForHwnd</b> returns: <ul> <li>S_OK if it successfully created a swap chain.</li>
    ///    <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li> DXGI_ERROR_INVALID_CALL if
    ///    the calling application provided invalid data, for example, if <i>pDesc</i> or <i>ppSwapChain</i> is
    ///    <b>NULL</b>, or <i>pDesc</i> data members are invalid.</li> <li>Possibly other error codes that are described
    ///    in the DXGI_ERROR topic that are defined by the type of device that you pass to <i>pDevice</i>.</li> </ul>
    ///    <b>Platform Update for Windows 7: </b>DXGI_SCALING_NONE is not supported on Windows 7 or Windows Server 2008
    ///    R2 with the Platform Update for Windows 7 installed and causes <b>CreateSwapChainForHwnd</b> to return
    ///    DXGI_ERROR_INVALID_CALL when called. For more info about the Platform Update for Windows 7, see Platform
    ///    Update for Windows 7.
    ///    
    HRESULT CreateSwapChainForHwnd(IUnknown pDevice, HWND hWnd, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                   const(DXGI_SWAP_CHAIN_FULLSCREEN_DESC)* pFullscreenDesc, 
                                   IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    ///Creates a swap chain that is associated with the CoreWindow object for the output window for the swap chain.
    ///Params:
    ///    pDevice = For Direct3D 11, and earlier versions of Direct3D, this is a pointer to the Direct3D device for the swap
    ///              chain. For Direct3D 12 this is a pointer to a direct command queue (refer to ID3D12CommandQueue). This
    ///              parameter cannot be <b>NULL</b>.
    ///    pWindow = A pointer to the CoreWindow object that is associated with the swap chain that
    ///              <b>CreateSwapChainForCoreWindow</b> creates.
    ///    pDesc = A pointer to a DXGI_SWAP_CHAIN_DESC1 structure for the swap-chain description. This parameter cannot be
    ///            <b>NULL</b>.
    ///    pRestrictToOutput = A pointer to the IDXGIOutput interface that the swap chain is restricted to. If the swap chain is moved to a
    ///                        different output, the content is black. You can optionally set this parameter to an output target that uses
    ///                        DXGI_PRESENT_RESTRICT_TO_OUTPUT to restrict the content on this output. If you do not set this parameter to
    ///                        restrict content on an output target, you can set it to <b>NULL</b>.
    ///    ppSwapChain = A pointer to a variable that receives a pointer to the IDXGISwapChain1 interface for the swap chain that
    ///                  <b>CreateSwapChainForCoreWindow</b> creates.
    ///Returns:
    ///    <b>CreateSwapChainForCoreWindow</b> returns: <ul> <li>S_OK if it successfully created a swap chain.</li>
    ///    <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li> DXGI_ERROR_INVALID_CALL if
    ///    the calling application provided invalid data, for example, if <i>pDesc</i> or <i>ppSwapChain</i> is
    ///    <b>NULL</b>.</li> <li>Possibly other error codes that are described in the DXGI_ERROR topic that are defined
    ///    by the type of device that you pass to <i>pDevice</i>.</li> </ul> <b>Platform Update for Windows 7: </b>On
    ///    Windows 7 or Windows Server 2008 R2 with the Platform Update for Windows 7 installed,
    ///    <b>CreateSwapChainForCoreWindow</b> fails with E_NOTIMPL. For more info about the Platform Update for Windows
    ///    7, see Platform Update for Windows 7.
    ///    
    HRESULT CreateSwapChainForCoreWindow(IUnknown pDevice, IUnknown pWindow, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                         IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    ///Identifies the adapter on which a shared resource object was created.
    ///Params:
    ///    hResource = A handle to a shared resource object. The IDXGIResource1::CreateSharedHandle method returns this handle.
    ///    pLuid = A pointer to a variable that receives a locally unique identifier (LUID) value that identifies the adapter.
    ///            <b>LUID</b> is defined in Dxgi.h. An <b>LUID</b> is a 64-bit value that is guaranteed to be unique only on
    ///            the operating system on which it was generated. The uniqueness of an <b>LUID</b> is guaranteed only until the
    ///            operating system is restarted.
    ///Returns:
    ///    <b>GetSharedResourceAdapterLuid</b> returns: <ul> <li>S_OK if it identified the adapter.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if <i>hResource</i> is invalid.</li> <li>Possibly other error codes that are
    ///    described in the DXGI_ERROR topic.</li> </ul> <b>Platform Update for Windows 7: </b>On Windows 7 or Windows
    ///    Server 2008 R2 with the Platform Update for Windows 7 installed, <b>GetSharedResourceAdapterLuid</b> fails
    ///    with E_NOTIMPL. For more info about the Platform Update for Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT GetSharedResourceAdapterLuid(HANDLE hResource, LUID* pLuid);
    ///Registers an application window to receive notification messages of changes of stereo status.
    ///Params:
    ///    WindowHandle = The handle of the window to send a notification message to when stereo status change occurs.
    ///    wMsg = Identifies the notification message to send.
    ///    pdwCookie = A pointer to a key value that an application can pass to the IDXGIFactory2::UnregisterStereoStatus method to
    ///                unregister the notification message that <i>wMsg</i> specifies.
    ///Returns:
    ///    <b>RegisterStereoStatusWindow</b> returns: <ul> <li>S_OK if it successfully registered the window.</li>
    ///    <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li>Possibly other error codes
    ///    that are described in the DXGI_ERROR topic.</li> </ul> <b>Platform Update for Windows 7: </b>On Windows 7 or
    ///    Windows Server 2008 R2 with the Platform Update for Windows 7 installed, <b>RegisterStereoStatusWindow</b>
    ///    fails with E_NOTIMPL. For more info about the Platform Update for Windows 7, see Platform Update for Windows
    ///    7.
    ///    
    HRESULT RegisterStereoStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
    ///Registers to receive notification of changes in stereo status by using event signaling.
    ///Params:
    ///    hEvent = A handle to the event object that the operating system sets when notification of stereo status change occurs.
    ///             The CreateEvent or OpenEvent function returns this handle.
    ///    pdwCookie = A pointer to a key value that an application can pass to the IDXGIFactory2::UnregisterStereoStatus method to
    ///                unregister the notification event that <i>hEvent</i> specifies.
    ///Returns:
    ///    <b>RegisterStereoStatusEvent</b> returns: <ul> <li>S_OK if it successfully registered the event.</li>
    ///    <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li>Possibly other error codes
    ///    that are described in the DXGI_ERROR topic.</li> </ul> <b>Platform Update for Windows 7: </b>On Windows 7 or
    ///    Windows Server 2008 R2 with the Platform Update for Windows 7 installed, <b>RegisterStereoStatusEvent</b>
    ///    fails with E_NOTIMPL. For more info about the Platform Update for Windows 7, see Platform Update for Windows
    ///    7.
    ///    
    HRESULT RegisterStereoStatusEvent(HANDLE hEvent, uint* pdwCookie);
    ///Unregisters a window or an event to stop it from receiving notification when stereo status changes.
    ///Params:
    ///    dwCookie = A key value for the window or event to unregister. The IDXGIFactory2::RegisterStereoStatusWindow or
    ///               IDXGIFactory2::RegisterStereoStatusEvent method returns this value.
    void    UnregisterStereoStatus(uint dwCookie);
    ///Registers an application window to receive notification messages of changes of occlusion status.
    ///Params:
    ///    WindowHandle = The handle of the window to send a notification message to when occlusion status change occurs.
    ///    wMsg = Identifies the notification message to send.
    ///    pdwCookie = A pointer to a key value that an application can pass to the IDXGIFactory2::UnregisterOcclusionStatus method
    ///                to unregister the notification message that <i>wMsg</i> specifies.
    ///Returns:
    ///    <b>RegisterOcclusionStatusWindow</b> returns: <ul> <li>S_OK if it successfully registered the window.</li>
    ///    <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li> DXGI_ERROR_INVALID_CALL if
    ///    <i>WindowHandle</i> is not a valid window handle or not the window handle that the current process owns.</li>
    ///    <li>Possibly other error codes that are described in the DXGI_ERROR topic.</li> </ul> <b>Platform Update for
    ///    Windows 7: </b>On Windows 7 or Windows Server 2008 R2 with the Platform Update for Windows 7 installed,
    ///    <b>RegisterOcclusionStatusWindow</b> fails with E_NOTIMPL. For more info about the Platform Update for
    ///    Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT RegisterOcclusionStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
    ///Registers to receive notification of changes in occlusion status by using event signaling.
    ///Params:
    ///    hEvent = A handle to the event object that the operating system sets when notification of occlusion status change
    ///             occurs. The CreateEvent or OpenEvent function returns this handle.
    ///    pdwCookie = A pointer to a key value that an application can pass to the IDXGIFactory2::UnregisterOcclusionStatus method
    ///                to unregister the notification event that <i>hEvent</i> specifies.
    ///Returns:
    ///    <b>RegisterOcclusionStatusEvent</b> returns: <ul> <li>S_OK if the method successfully registered the
    ///    event.</li> <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li>
    ///    DXGI_ERROR_INVALID_CALL if <i>hEvent</i> is not a valid handle or not an event handle. </li> <li>Possibly
    ///    other error codes that are described in the DXGI_ERROR topic.</li> </ul> <b>Platform Update for Windows 7:
    ///    </b>On Windows 7 or Windows Server 2008 R2 with the Platform Update for Windows 7 installed,
    ///    <b>RegisterOcclusionStatusEvent</b> fails with E_NOTIMPL. For more info about the Platform Update for Windows
    ///    7, see Platform Update for Windows 7.
    ///    
    HRESULT RegisterOcclusionStatusEvent(HANDLE hEvent, uint* pdwCookie);
    ///Unregisters a window or an event to stop it from receiving notification when occlusion status changes.
    ///Params:
    ///    dwCookie = A key value for the window or event to unregister. The IDXGIFactory2::RegisterOcclusionStatusWindow or
    ///               IDXGIFactory2::RegisterOcclusionStatusEvent method returns this value.
    void    UnregisterOcclusionStatus(uint dwCookie);
    ///Creates a swap chain that you can use to send Direct3D content into the DirectComposition API or the
    ///Windows.UI.Xaml framework to compose in a window.
    ///Params:
    ///    pDevice = For Direct3D 11, and earlier versions of Direct3D, this is a pointer to the Direct3D device for the swap
    ///              chain. For Direct3D 12 this is a pointer to a direct command queue (refer to ID3D12CommandQueue). This
    ///              parameter cannot be <b>NULL</b>. Software drivers, like D3D_DRIVER_TYPE_REFERENCE, are not supported for
    ///              composition swap chains.
    ///    pDesc = A pointer to a DXGI_SWAP_CHAIN_DESC1 structure for the swap-chain description. This parameter cannot be
    ///            <b>NULL</b>. You must specify the DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL value in the <b>SwapEffect</b> member of
    ///            DXGI_SWAP_CHAIN_DESC1 because <b>CreateSwapChainForComposition</b> supports only flip presentation model. You
    ///            must also specify the DXGI_SCALING_STRETCH value in the <b>Scaling</b> member of DXGI_SWAP_CHAIN_DESC1.
    ///    pRestrictToOutput = A pointer to the IDXGIOutput interface for the output to restrict content to. You must also pass the
    ///                        DXGI_PRESENT_RESTRICT_TO_OUTPUT flag in a IDXGISwapChain1::Present1 call to force the content to appear
    ///                        blacked out on any other output. If you want to restrict the content to a different output, you must create a
    ///                        new swap chain. However, you can conditionally restrict content based on the
    ///                        <b>DXGI_PRESENT_RESTRICT_TO_OUTPUT</b> flag. Set this parameter to <b>NULL</b> if you don't want to restrict
    ///                        content to an output target.
    ///    ppSwapChain = A pointer to a variable that receives a pointer to the IDXGISwapChain1 interface for the swap chain that
    ///                  <b>CreateSwapChainForComposition</b> creates.
    ///Returns:
    ///    <b>CreateSwapChainForComposition</b> returns: <ul> <li>S_OK if it successfully created a swap chain.</li>
    ///    <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li> DXGI_ERROR_INVALID_CALL if
    ///    the calling application provided invalid data, for example, if <i>pDesc</i> or <i>ppSwapChain</i> is
    ///    <b>NULL</b>.</li> <li>Possibly other error codes that are described in the DXGI_ERROR topic that are defined
    ///    by the type of device that you pass to <i>pDevice</i>.</li> </ul> <b>Platform Update for Windows 7: </b>On
    ///    Windows 7 or Windows Server 2008 R2 with the Platform Update for Windows 7 installed,
    ///    <b>CreateSwapChainForComposition</b> fails with E_NOTIMPL. For more info about the Platform Update for
    ///    Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT CreateSwapChainForComposition(IUnknown pDevice, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                          IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
}

///The <b>IDXGIAdapter2</b> interface represents a display subsystem, which includes one or more GPUs, DACs, and video
///memory.
@GUID("0AA1AE0A-FA0E-4B84-8644-E05FF8E5ACB5")
interface IDXGIAdapter2 : IDXGIAdapter1
{
    ///Gets a Microsoft DirectX Graphics Infrastructure (DXGI) 1.2 description of an adapter or video card. This
    ///description includes information about the granularity at which the graphics processing unit (GPU) can be
    ///preempted from performing its current task.
    ///Params:
    ///    pDesc = A pointer to a DXGI_ADAPTER_DESC2 structure that describes the adapter. This parameter must not be
    ///            <b>NULL</b>. On feature level 9 graphics hardware, earlier versions of <b>GetDesc2</b> (GetDesc and GetDesc1)
    ///            return zeros for the PCI ID in the <b>VendorId</b>, <b>DeviceId</b>, <b>SubSysId</b>, and <b>Revision</b>
    ///            members of the adapter description structure and “Software Adapter” for the description string in the
    ///            <b>Description</b> member. <b>GetDesc2</b> returns the actual feature level 9 hardware values in these
    ///            members.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns E_INVALIDARG if the <i>pDesc</i> parameter is <b>NULL</b>.
    ///    
    HRESULT GetDesc2(DXGI_ADAPTER_DESC2* pDesc);
}

///An <b>IDXGIOutput1</b> interface represents an adapter output (such as a monitor).
@GUID("00CDDEA8-939B-4B83-A340-A685226666CC")
interface IDXGIOutput1 : IDXGIOutput
{
    ///Gets the display modes that match the requested format and other input options.
    ///Params:
    ///    EnumFormat = A DXGI_FORMAT-typed value for the color format.
    ///    Flags = A combination of DXGI_ENUM_MODES-typed values that are combined by using a bitwise OR operation. The
    ///            resulting value specifies options for display modes to include. You must specify DXGI_ENUM_MODES_SCALING to
    ///            expose the display modes that require scaling. Centered modes that require no scaling and correspond directly
    ///            to the display output are enumerated by default.
    ///    pNumModes = A pointer to a variable that receives the number of display modes that <b>GetDisplayModeList1</b> returns in
    ///                the memory block to which <i>pDesc</i> points. Set <i>pDesc</i> to <b>NULL</b> so that <i>pNumModes</i>
    ///                returns the number of display modes that match the format and the options. Otherwise, <i>pNumModes</i>
    ///                returns the number of display modes returned in <i>pDesc</i>.
    ///    pDesc = A pointer to a list of display modes; set to <b>NULL</b> to get the number of display modes.
    ///Returns:
    ///    Returns one of the error codes described in the DXGI_ERROR topic. It is rare, but possible, that the display
    ///    modes available can change immediately after calling this method, in which case DXGI_ERROR_MORE_DATA is
    ///    returned (if there is not enough room for all the display modes).
    ///    
    HRESULT GetDisplayModeList1(DXGI_FORMAT EnumFormat, uint Flags, uint* pNumModes, DXGI_MODE_DESC1* pDesc);
    ///Finds the display mode that most closely matches the requested display mode.
    ///Params:
    ///    pModeToMatch = A pointer to the DXGI_MODE_DESC1 structure that describes the display mode to match. Members of
    ///                   <b>DXGI_MODE_DESC1</b> can be unspecified, which indicates no preference for that member. A value of 0 for
    ///                   <b>Width</b> or <b>Height</b> indicates that the value is unspecified. If either <b>Width</b> or
    ///                   <b>Height</b> is 0, both must be 0. A numerator and denominator of 0 in <b>RefreshRate</b> indicate it is
    ///                   unspecified. Other members of <b>DXGI_MODE_DESC1</b> have enumeration values that indicate that the member is
    ///                   unspecified. If <i>pConcernedDevice</i> is <b>NULL</b>, the <b>Format</b>member of <b>DXGI_MODE_DESC1</b>
    ///                   cannot be <b>DXGI_FORMAT_UNKNOWN</b>.
    ///    pClosestMatch = A pointer to the DXGI_MODE_DESC1 structure that receives a description of the display mode that most closely
    ///                    matches the display mode described at <i>pModeToMatch</i>.
    ///    pConcernedDevice = A pointer to the Direct3D device interface. If this parameter is <b>NULL</b>, <b>FindClosestMatchingMode1</b>
    ///                       returns only modes whose format matches that of <i>pModeToMatch</i>; otherwise,
    ///                       <b>FindClosestMatchingMode1</b> returns only those formats that are supported for scan-out by the device. For
    ///                       info about the formats that are supported for scan-out by the device at each feature level: <ul> <li> DXGI
    ///                       Format Support for Direct3D Feature Level 12.1 Hardware </li> <li> DXGI Format Support for Direct3D Feature
    ///                       Level 12.0 Hardware </li> <li> DXGI Format Support for Direct3D Feature Level 11.1 Hardware </li> <li> DXGI
    ///                       Format Support for Direct3D Feature Level 11.0 Hardware </li> <li> Hardware Support for Direct3D 10Level9
    ///                       Formats </li> <li> Hardware Support for Direct3D 10.1 Formats </li> <li> Hardware Support for Direct3D 10
    ///                       Formats </li> </ul>
    ///Returns:
    ///    Returns one of the error codes described in the DXGI_ERROR topic.
    ///    
    HRESULT FindClosestMatchingMode1(const(DXGI_MODE_DESC1)* pModeToMatch, DXGI_MODE_DESC1* pClosestMatch, 
                                     IUnknown pConcernedDevice);
    ///Copies the display surface (front buffer) to a user-provided resource.
    ///Params:
    ///    pDestination = A pointer to a resource interface that represents the resource to which <b>GetDisplaySurfaceData1</b> copies
    ///                   the display surface.
    ///Returns:
    ///    Returns one of the error codes described in the DXGI_ERROR topic.
    ///    
    HRESULT GetDisplaySurfaceData1(IDXGIResource pDestination);
    ///Creates a desktop duplication interface from the IDXGIOutput1 interface that represents an adapter output.
    ///Params:
    ///    pDevice = A pointer to the Direct3D device interface that you can use to process the desktop image. This device must be
    ///              created from the adapter to which the output is connected.
    ///    ppOutputDuplication = A pointer to a variable that receives the new IDXGIOutputDuplication interface.
    ///Returns:
    ///    <b>DuplicateOutput</b> returns: <ul> <li>S_OK if <b>DuplicateOutput</b> successfully created the desktop
    ///    duplication interface.</li> <li>E_INVALIDARG for one of the following reasons: <ul> <li>The specified device
    ///    (<i>pDevice</i>) is invalid, was not created on the correct adapter, or was not created from IDXGIFactory1
    ///    (or a later version of a DXGI factory interface that inherits from <b>IDXGIFactory1</b>).</li> <li>The
    ///    calling application is already duplicating this desktop output.</li> </ul> </li> <li>E_ACCESSDENIED if the
    ///    application does not have access privilege to the current desktop image. For example, only an application
    ///    that runs at LOCAL_SYSTEM can access the secure desktop.</li> <li>DXGI_ERROR_UNSUPPORTED if the created
    ///    IDXGIOutputDuplication interface does not support the current desktop mode or scenario. For example, 8bpp and
    ///    non-DWM desktop modes are not supported. If <b>DuplicateOutput</b> fails with DXGI_ERROR_UNSUPPORTED, the
    ///    application can wait for system notification of desktop switches and mode changes and then call
    ///    <b>DuplicateOutput</b> again after such a notification occurs. For more information, refer to
    ///    EVENT_SYSTEM_DESKTOPSWITCH and mode change notification (WM_DISPLAYCHANGE). </li>
    ///    <li>DXGI_ERROR_NOT_CURRENTLY_AVAILABLE if DXGI reached the limit on the maximum number of concurrent
    ///    duplication applications (default of four). Therefore, the calling application cannot create any desktop
    ///    duplication interfaces until the other applications close.</li> <li>DXGI_ERROR_SESSION_DISCONNECTED if
    ///    <b>DuplicateOutput</b> failed because the session is currently disconnected.</li> <li>Other error codes are
    ///    described in the DXGI_ERROR topic.</li> </ul> <b>Platform Update for Windows 7: </b>On Windows 7 or Windows
    ///    Server 2008 R2 with the Platform Update for Windows 7 installed, <b>DuplicateOutput</b> fails with E_NOTIMPL.
    ///    For more info about the Platform Update for Windows 7, see Platform Update for Windows 7.
    ///    
    HRESULT DuplicateOutput(IUnknown pDevice, IDXGIOutputDuplication* ppOutputDuplication);
}

///The <b>IDXGIDevice3</b> interface implements a derived class for DXGI objects that produce image data. The interface
///exposes a method to trim graphics memory usage by the DXGI device.
@GUID("6007896C-3244-4AFD-BF18-A6D3BEDA5023")
interface IDXGIDevice3 : IDXGIDevice2
{
    ///Trims the graphics memory allocated by the IDXGIDevice3 DXGI device on the app's behalf. For apps that render
    ///with DirectX, graphics drivers periodically allocate internal memory buffers in order to speed up subsequent
    ///rendering requests. These memory allocations count against the app's memory usage for PLM and in general lead to
    ///increased memory usage by the overall system. Starting in Windows 8.1, apps that render with Direct2D and/or
    ///Direct3D (including CoreWindow and XAML interop) must call <b>Trim</b> in response to the PLM suspend callback.
    ///The Direct3D runtime and the graphics driver will discard internal memory buffers allocated for the app, reducing
    ///its memory footprint. Calling this method does not change the rendering state of the graphics device and it has
    ///no effect on rendering operations. There is a brief performance hit when internal buffers are reallocated during
    ///the first rendering operations after the <b>Trim</b> call, therefore apps should only call <b>Trim</b> when going
    ///idle for a period of time (in response to PLM suspend, for example). Apps should ensure that they call
    ///<b>Trim</b> as one of the last D3D operations done before going idle. Direct3D will normally defer the
    ///destruction of D3D objects. Calling <b>Trim</b>, however, forces Direct3D to destroy objects immediately. For
    ///this reason, it is not guaranteed that releasing the final reference on Direct3D objects after calling
    ///<b>Trim</b> will cause the object to be destroyed and memory to be deallocated before the app suspends. Similar
    ///to ID3D11DeviceContext::Flush, apps should call ID3D11DeviceContext::ClearState before calling <b>Trim</b>.
    ///<b>ClearState</b> clears the Direct3D pipeline bindings, ensuring that Direct3D does not hold any references to
    ///the Direct3D objects you are trying to release. It is also prudent to release references on middleware before
    ///calling <b>Trim</b>, as that middleware may also need to release references to Direct3D objects.
    void Trim();
}

///Extends IDXGISwapChain1 with methods to support swap back buffer scaling and lower-latency swap chains.
@GUID("A8BE2AC4-199F-4946-B331-79599FB98DE7")
interface IDXGISwapChain2 : IDXGISwapChain1
{
    ///Sets the source region to be used for the swap chain. Use <b>SetSourceSize</b> to specify the portion of the swap
    ///chain from which the operating system presents. This allows an effective resize without calling the
    ///more-expensive IDXGISwapChain::ResizeBuffers method. Prior to Windows 8.1, calling
    ///<b>IDXGISwapChain::ResizeBuffers</b> was the only way to resize the swap chain. The source rectangle is always
    ///defined by the region [0, 0, Width, Height].
    ///Params:
    ///    Width = Source width to use for the swap chain. This value must be greater than zero, and must be less than or equal
    ///            to the overall width of the swap chain.
    ///    Height = Source height to use for the swap chain. This value must be greater than zero, and must be less than or equal
    ///             to the overall height of the swap chain.
    ///Returns:
    ///    This method can return: <ul> <li>E_INVALIDARG if one or more parameters exceed the size of the back
    ///    buffer.</li> <li>Possibly other error codes that are described in the DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT SetSourceSize(uint Width, uint Height);
    ///Gets the source region used for the swap chain. Use <b>GetSourceSize</b> to get the portion of the swap chain
    ///from which the operating system presents. The source rectangle is always defined by the region [0, 0, Width,
    ///Height]. Use SetSourceSize to set this portion of the swap chain.
    ///Params:
    ///    pWidth = The current width of the source region of the swap chain. This value can range from 1 to the overall width of
    ///             the swap chain.
    ///    pHeight = The current height of the source region of the swap chain. This value can range from 1 to the overall height
    ///              of the swap chain.
    ///Returns:
    ///    This method can return error codes that are described in the DXGI_ERROR topic.
    ///    
    HRESULT GetSourceSize(uint* pWidth, uint* pHeight);
    ///Sets the number of frames that the swap chain is allowed to queue for rendering.
    ///Params:
    ///    MaxLatency = The maximum number of back buffer frames that will be queued for the swap chain. This value is 1 by default.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, DXGI_ERROR_DEVICE_REMOVED if the device was removed.
    ///    
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    ///Gets the number of frames that the swap chain is allowed to queue for rendering.
    ///Params:
    ///    pMaxLatency = The maximum number of back buffer frames that will be queued for the swap chain. This value is 1 by default,
    ///                  but should be set to 2 if the scene takes longer than it takes for one vertical refresh (typically about
    ///                  16ms) to draw.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns one of the following members of the D3DERR enumerated type:
    ///    <ul> <li><b>D3DERR_DEVICELOST</b></li> <li><b>D3DERR_DEVICEREMOVED</b></li>
    ///    <li><b>D3DERR_DRIVERINTERNALERROR</b></li> <li><b>D3DERR_INVALIDCALL</b></li>
    ///    <li><b>D3DERR_OUTOFVIDEOMEMORY</b></li> </ul>
    ///    
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
    ///Returns a waitable handle that signals when the DXGI adapter has finished presenting a new frame. Windows 8.1
    ///introduces new APIs that allow lower-latency rendering by waiting until the previous frame is presented to the
    ///display before drawing the next frame. To use this method, first create the DXGI swap chain with the
    ///DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT flag set, then call <b>GetFrameLatencyWaitableObject</b> to
    ///retrieve the waitable handle. Use the waitable handle with WaitForSingleObjectEx to synchronize rendering of each
    ///new frame with the end of the previous frame. For every frame it renders, the app should wait on this handle
    ///before starting any rendering operations. Note that this requirement includes the first frame the app renders
    ///with the swap chain. See the DirectXLatency sample. When you are done with the handle, use CloseHandle to close
    ///it.
    ///Returns:
    ///    A handle to the waitable object, or NULL if the swap chain was not created with
    ///    DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT.
    ///    
    HANDLE  GetFrameLatencyWaitableObject();
    ///Sets the transform matrix that will be applied to a composition swap chain upon the next present. Starting with
    ///Windows 8.1, Windows Store apps are able to place DirectX swap chain visuals in XAML pages using the
    ///SwapChainPanel element, which can be placed and sized arbitrarily. This exposes the DirectX swap chain visuals to
    ///touch scaling and translation scenarios using touch UI. The GetMatrixTransform and <b>SetMatrixTransform</b>
    ///methods are used to synchronize scaling of the DirectX swap chain with its associated <b>SwapChainPanel</b>
    ///element. Only simple scale/translation elements in the matrix are allowed – the call will fail if the matrix
    ///contains skew/rotation elements.
    ///Params:
    ///    pMatrix = The transform matrix to use for swap chain scaling and translation. This function can only be used with
    ///              composition swap chains created by IDXGIFactory2::CreateSwapChainForComposition. Only scale and translation
    ///              components are allowed in the matrix.
    ///Returns:
    ///    <b>SetMatrixTransform</b> returns: <ul> <li>S_OK if it successfully retrieves the transform matrix.</li>
    ///    <li>E_INVALIDARG if the <i>pMatrix</i> parameter is incorrect, for example, <i>pMatrix</i> is NULL or the
    ///    matrix represented by DXGI_MATRIX_3X2_F includes components other than scale and translation.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the method is called on a swap chain that was not created with
    ///    CreateSwapChainForComposition.</li> <li>Possibly other error codes that are described in the DXGI_ERROR
    ///    topic.</li> </ul>
    ///    
    HRESULT SetMatrixTransform(const(DXGI_MATRIX_3X2_F)* pMatrix);
    ///Gets the transform matrix that will be applied to a composition swap chain upon the next present. Starting with
    ///Windows 8.1, Windows Store apps are able to place DirectX swap chain visuals in XAML pages using the
    ///SwapChainPanel element, which can be placed and sized arbitrarily. This exposes the DirectX swap chain visuals to
    ///touch scaling and translation scenarios using touch UI. The <b>GetMatrixTransform</b> and SetMatrixTransform
    ///methods are used to synchronize scaling of the DirectX swap chain with its associated <b>SwapChainPanel</b>
    ///element. Only simple scale/translation elements in the matrix are allowed – the call will fail if the matrix
    ///contains skew/rotation elements.
    ///Params:
    ///    pMatrix = [out] The transform matrix currently used for swap chain scaling and translation.
    ///Returns:
    ///    <b>GetMatrixTransform</b> returns: <ul> <li>S_OK if it successfully retrieves the transform matrix.</li>
    ///    <li>DXGI_ERROR_INVALID_CALL if the method is called on a swap chain that was not created with
    ///    CreateSwapChainForComposition.</li> <li>Possibly other error codes that are described in the DXGI_ERROR
    ///    topic.</li> </ul>
    ///    
    HRESULT GetMatrixTransform(DXGI_MATRIX_3X2_F* pMatrix);
}

///Represents an adapter output (such as a monitor). The <b>IDXGIOutput2</b> interface exposes a method to check for
///multiplane overlay support on the primary output adapter.
@GUID("595E39D1-2724-4663-99B1-DA969DE28364")
interface IDXGIOutput2 : IDXGIOutput1
{
    ///Queries an adapter output for multiplane overlay support. If this API returns ‘TRUE’, multiple swap chain
    ///composition takes place in a performant manner using overlay hardware. If this API returns false, apps should
    ///avoid using foreground swap chains (that is, avoid using swap chains created with the
    ///DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER flag).
    ///Returns:
    ///    TRUE if the output adapter is the primary adapter and it supports multiplane overlays, otherwise returns
    ///    FALSE.
    ///    
    BOOL SupportsOverlays();
}

///Enables creating Microsoft DirectX Graphics Infrastructure (DXGI) objects.
@GUID("25483823-CD46-4C7D-86CA-47AA95B837BD")
interface IDXGIFactory3 : IDXGIFactory2
{
    ///Gets the flags that were used when a Microsoft DirectX Graphics Infrastructure (DXGI) object was created.
    ///Returns:
    ///    The creation flags.
    ///    
    uint GetCreationFlags();
}

///Represents a swap chain that is used by desktop media apps to decode video data and show it on a DirectComposition
///surface.
@GUID("2633066B-4514-4C7A-8FD8-12EA98059D18")
interface IDXGIDecodeSwapChain : IUnknown
{
    ///Presents a frame on the output adapter. The frame is a subresource of the IDXGIResource object that was used to
    ///create the decode swap chain.
    ///Params:
    ///    BufferToPresent = An index indicating which member of the subresource array to present.
    ///    SyncInterval = An integer that specifies how to synchronize presentation of a frame with the vertical blank. For the
    ///                   bit-block transfer (bitblt) model (DXGI_SWAP_EFFECT_DISCARDor DXGI_SWAP_EFFECT_SEQUENTIAL), values are: <ul>
    ///                   <li>0 - The presentation occurs immediately, there is no synchronization.</li> <li>1,2,3,4 - Synchronize
    ///                   presentation after the <i>n</i>th vertical blank.</li> </ul> For the flip model
    ///                   (DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL), values are: <ul> <li>0 - Cancel the remaining time on the previously
    ///                   presented frame and discard this frame if a newer frame is queued. </li> <li>n &gt; 0 - Synchronize
    ///                   presentation for at least <i>n</i> vertical blanks.</li> </ul>
    ///    Flags = An integer value that contains swap-chain presentation options. These options are defined by the DXGI_PRESENT
    ///            constants. The <b>DXGI_PRESENT_USE_DURATION</b> flag must be set if a custom present duration (custom refresh
    ///            rate) is being used.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success, or it returns one of the following error codes: <ul>
    ///    <li>DXGI_ERROR_DEVICE_REMOVED</li> <li>DXGI_STATUS_OCCLUDED</li> <li>DXGI_ERROR_INVALID_CALL</li>
    ///    <li><b>E_OUTOFMEMORY</b></li> </ul>
    ///    
    HRESULT PresentBuffer(uint BufferToPresent, uint SyncInterval, uint Flags);
    ///Sets the rectangle that defines the source region for the video processing blit operation. The source rectangle
    ///is the portion of the input surface that is blitted to the destination surface. The source rectangle is given in
    ///pixel coordinates, relative to the input surface.
    ///Params:
    ///    pRect = A pointer to a RECT structure that contains the source region to set for the swap chain.
    ///Returns:
    ///    This method returns S_OK on success, or it returns one of the error codes that are described in the
    ///    DXGI_ERROR topic.
    ///    
    HRESULT SetSourceRect(const(RECT)* pRect);
    ///Sets the rectangle that defines the target region for the video processing blit operation. The target rectangle
    ///is the area within the destination surface where the output will be drawn. The target rectangle is given in pixel
    ///coordinates, relative to the destination surface.
    ///Params:
    ///    pRect = A pointer to a RECT structure that contains the target region to set for the swap chain.
    ///Returns:
    ///    This method returns S_OK on success, or it returns one of the error codes that are described in the
    ///    DXGI_ERROR topic.
    ///    
    HRESULT SetTargetRect(const(RECT)* pRect);
    ///Sets the size of the destination surface to use for the video processing blit operation. The destination
    ///rectangle is the portion of the output surface that receives the blit for this stream. The destination rectangle
    ///is given in pixel coordinates, relative to the output surface.
    ///Params:
    ///    Width = The width of the destination size, in pixels.
    ///    Height = The height of the destination size, in pixels.
    ///Returns:
    ///    This method returns S_OK on success, or it returns one of the error codes that are described in the
    ///    DXGI_ERROR topic.
    ///    
    HRESULT SetDestSize(uint Width, uint Height);
    ///Gets the source region that is used for the swap chain.
    ///Params:
    ///    pRect = A pointer to a RECT structure that receives the source region for the swap chain.
    ///Returns:
    ///    This method returns S_OK on success, or it returns one of the error codes that are described in the
    ///    DXGI_ERROR topic.
    ///    
    HRESULT GetSourceRect(RECT* pRect);
    ///Gets the rectangle that defines the target region for the video processing blit operation.
    ///Params:
    ///    pRect = A pointer to a RECT structure that receives the target region for the swap chain.
    ///Returns:
    ///    This method returns S_OK on success, or it returns one of the error codes that are described in the
    ///    DXGI_ERROR topic.
    ///    
    HRESULT GetTargetRect(RECT* pRect);
    ///Gets the size of the destination surface to use for the video processing blit operation.
    ///Params:
    ///    pWidth = A pointer to a variable that receives the width in pixels.
    ///    pHeight = A pointer to a variable that receives the height in pixels.
    ///Returns:
    ///    This method returns S_OK on success, or it returns one of the error codes that are described in the
    ///    DXGI_ERROR topic.
    ///    
    HRESULT GetDestSize(uint* pWidth, uint* pHeight);
    ///Sets the color space used by the swap chain.
    ///Params:
    ///    ColorSpace = A pointer to a combination of DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS-typed values that are combined by using a
    ///                 bitwise OR operation. The resulting value specifies the color space to set for the swap chain.
    ///Returns:
    ///    This method returns S_OK on success, or it returns one of the error codes that are described in the
    ///    DXGI_ERROR topic.
    ///    
    HRESULT SetColorSpace(DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS ColorSpace);
    ///Gets the color space used by the swap chain.
    ///Returns:
    ///    A combination of DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS-typed values that are combined by using a bitwise OR
    ///    operation. The resulting value specifies the color space for the swap chain.
    ///    
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS GetColorSpace();
}

///Creates swap chains for desktop media apps that use DirectComposition surfaces to decode and display video.
@GUID("41E7D1F2-A591-4F7B-A2E5-FA9C843E1C12")
interface IDXGIFactoryMedia : IUnknown
{
    ///Creates a YUV swap chain for an existing DirectComposition surface handle.
    ///Params:
    ///    pDevice = A pointer to the Direct3D device for the swap chain. This parameter cannot be <b>NULL</b>. Software drivers,
    ///              like D3D_DRIVER_TYPE_REFERENCE, are not supported for composition swap chains.
    ///    hSurface = A handle to an existing DirectComposition surface. This parameter cannot be <b>NULL</b>.
    ///    pDesc = A pointer to a DXGI_SWAP_CHAIN_DESC1 structure for the swap-chain description. This parameter cannot be
    ///            <b>NULL</b>.
    ///    pRestrictToOutput = A pointer to the IDXGIOutput interface for the swap chain to restrict content to. If the swap chain is moved
    ///                        to a different output, the content is black. You can optionally set this parameter to an output target that
    ///                        uses DXGI_PRESENT_RESTRICT_TO_OUTPUT to restrict the content on this output. If the swap chain is moved to a
    ///                        different output, the content is black. You must also pass the DXGI_PRESENT_RESTRICT_TO_OUTPUT flag in a
    ///                        present call to force the content to appear blacked out on any other output. If you want to restrict the
    ///                        content to a different output, you must create a new swap chain. However, you can conditionally restrict
    ///                        content based on the <b>DXGI_PRESENT_RESTRICT_TO_OUTPUT</b> flag. Set this parameter to <b>NULL</b> if you
    ///                        don't want to restrict content to an output target.
    ///    ppSwapChain = A pointer to a variable that receives a pointer to the IDXGISwapChain1 interface for the swap chain that this
    ///                  method creates.
    ///Returns:
    ///    <b>CreateSwapChainForCompositionSurfaceHandle</b> returns: <ul> <li>S_OK if it successfully created a swap
    ///    chain.</li> <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li>
    ///    DXGI_ERROR_INVALID_CALL if the calling application provided invalid data, for example, if <i>pDesc</i>,
    ///    <i>pYuvDecodeBuffers</i>, or <i>ppSwapChain</i> is <b>NULL</b>.</li> <li>Possibly other error codes that are
    ///    described in the DXGI_ERROR topic that are defined by the type of device that you pass to
    ///    <i>pDevice</i>.</li> </ul>
    ///    
    HRESULT CreateSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, 
                                                       const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                                       IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
    ///Creates a YUV swap chain for an existing DirectComposition surface handle. The swap chain is created with
    ///pre-existing buffers and very few descriptive elements are required. Instead, this method requires a
    ///DirectComposition surface handle and an IDXGIResource buffer to hold decoded frame data. The swap chain format is
    ///determined by the format of the subresources of the <b>IDXGIResource</b>.
    ///Params:
    ///    pDevice = A pointer to the Direct3D device for the swap chain. This parameter cannot be <b>NULL</b>. Software drivers,
    ///              like D3D_DRIVER_TYPE_REFERENCE, are not supported for composition swap chains.
    ///    hSurface = A handle to an existing DirectComposition surface. This parameter cannot be <b>NULL</b>.
    ///    pDesc = A pointer to a DXGI_DECODE_SWAP_CHAIN_DESC structure for the swap-chain description. This parameter cannot be
    ///            <b>NULL</b>.
    ///    pYuvDecodeBuffers = A pointer to a IDXGIResource interface that represents the resource that contains the info that
    ///                        <b>CreateDecodeSwapChainForCompositionSurfaceHandle</b> decodes.
    ///    pRestrictToOutput = A pointer to the IDXGIOutput interface for the swap chain to restrict content to. If the swap chain is moved
    ///                        to a different output, the content is black. You can optionally set this parameter to an output target that
    ///                        uses DXGI_PRESENT_RESTRICT_TO_OUTPUT to restrict the content on this output. If the swap chain is moved to a
    ///                        different output, the content is black. You must also pass the DXGI_PRESENT_RESTRICT_TO_OUTPUT flag in a
    ///                        present call to force the content to appear blacked out on any other output. If you want to restrict the
    ///                        content to a different output, you must create a new swap chain. However, you can conditionally restrict
    ///                        content based on the <b>DXGI_PRESENT_RESTRICT_TO_OUTPUT</b> flag. Set this parameter to <b>NULL</b> if you
    ///                        don't want to restrict content to an output target.
    ///    ppSwapChain = A pointer to a variable that receives a pointer to the IDXGIDecodeSwapChain interface for the swap chain that
    ///                  this method creates.
    ///Returns:
    ///    <b>CreateDecodeSwapChainForCompositionSurfaceHandle</b> returns: <ul> <li>S_OK if it successfully created a
    ///    swap chain.</li> <li>E_OUTOFMEMORY if memory is unavailable to complete the operation.</li> <li>
    ///    DXGI_ERROR_INVALID_CALL if the calling application provided invalid data, for example, if <i>pDesc</i>,
    ///    <i>pYuvDecodeBuffers</i>, or <i>ppSwapChain</i> is <b>NULL</b>. </li> <li>Possibly other error codes that are
    ///    described in the DXGI_ERROR topic that are defined by the type of device that you pass to <i>pDevice</i>.
    ///    </li> </ul>
    ///    
    HRESULT CreateDecodeSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, 
                                                             DXGI_DECODE_SWAP_CHAIN_DESC* pDesc, 
                                                             IDXGIResource pYuvDecodeBuffers, 
                                                             IDXGIOutput pRestrictToOutput, 
                                                             IDXGIDecodeSwapChain* ppSwapChain);
}

///This swap chain interface allows desktop media applications to request a seamless change to a specific refresh rate.
///For example, a media application presenting video at a typical framerate of 23.997 frames per second can request a
///custom refresh rate of 24 or 48 Hz to eliminate jitter. If the request is approved, the app starts presenting frames
///at the custom refresh rate immediately - without the typical 'mode switch' a user would experience when changing the
///refresh rate themselves by using the control panel.
@GUID("DD95B90B-F05F-4F6A-BD65-25BFB264BD84")
interface IDXGISwapChainMedia : IUnknown
{
    ///Queries the system for a DXGI_FRAME_STATISTICS_MEDIA structure that indicates whether a custom refresh rate is
    ///currently approved by the system.
    ///Params:
    ///    pStats = A DXGI_FRAME_STATISTICS_MEDIA structure indicating whether the system currently approves the custom refresh
    ///             rate request.
    ///Returns:
    ///    This method returns S_OK on success, or a DXGI error code on failure.
    ///    
    HRESULT GetFrameStatisticsMedia(DXGI_FRAME_STATISTICS_MEDIA* pStats);
    ///Requests a custom presentation duration (custom refresh rate).
    ///Params:
    ///    Duration = The custom presentation duration, specified in hundreds of nanoseconds.
    ///Returns:
    ///    This method returns S_OK on success, or a DXGI error code on failure.
    ///    
    HRESULT SetPresentDuration(uint Duration);
    ///Queries the graphics driver for a supported frame present duration corresponding to a custom refresh rate.
    ///Params:
    ///    DesiredPresentDuration = Indicates the frame duration to check. This value is the duration of one frame at the desired refresh rate,
    ///                             specified in hundreds of nanoseconds. For example, set this field to 167777 to check for 60 Hz refresh rate
    ///                             support.
    ///    pClosestSmallerPresentDuration = A variable that will be set to the closest supported frame present duration that's smaller than the requested
    ///                                     value, or zero if the device does not support any lower duration.
    ///    pClosestLargerPresentDuration = A variable that will be set to the closest supported frame present duration that's larger than the requested
    ///                                    value, or zero if the device does not support any higher duration.
    ///Returns:
    ///    This method returns S_OK on success, or a DXGI error code on failure.
    ///    
    HRESULT CheckPresentDurationSupport(uint DesiredPresentDuration, uint* pClosestSmallerPresentDuration, 
                                        uint* pClosestLargerPresentDuration);
}

///Represents an adapter output (such as a monitor). The <b>IDXGIOutput3</b> interface exposes a method to check for
///overlay support.
@GUID("8A6BB301-7E7E-41F4-A8E0-5B32F7F99B18")
interface IDXGIOutput3 : IDXGIOutput2
{
    ///Checks for overlay support.
    ///Params:
    ///    EnumFormat = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT-typed value for the color format.
    ///    pConcernedDevice = Type: <b>IUnknown*</b> A pointer to the Direct3D device interface. <b>CheckOverlaySupport</b> returns only
    ///                       support info about this scan-out device.
    ///    pFlags = Type: <b>UINT*</b> A pointer to a variable that receives a combination of DXGI_OVERLAY_SUPPORT_FLAG-typed
    ///             values that are combined by using a bitwise OR operation. The resulting value specifies options for overlay
    ///             support.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the error codes described in the DXGI_ERROR topic.
    ///    
    HRESULT CheckOverlaySupport(DXGI_FORMAT EnumFormat, IUnknown pConcernedDevice, uint* pFlags);
}

///Extends IDXGISwapChain2 with methods to support getting the index of the swap chain's current back buffer and support
///for color space.
@GUID("94D99BDB-F1F8-4AB0-B236-7DA0170EDAB1")
interface IDXGISwapChain3 : IDXGISwapChain2
{
    ///Gets the index of the swap chain's current back buffer.
    ///Returns:
    ///    Type: <b>UINT</b> Returns the index of the current back buffer.
    ///    
    uint    GetCurrentBackBufferIndex();
    ///Checks the swap chain's support for color space.
    ///Params:
    ///    ColorSpace = Type: <b>DXGI_COLOR_SPACE_TYPE</b> A DXGI_COLOR_SPACE_TYPE-typed value that specifies color space type to
    ///                 check support for.
    ///    pColorSpaceSupport = Type: <b>UINT*</b> A pointer to a variable that receives a combination of
    ///                         DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG-typed values that are combined by using a bitwise OR operation. The
    ///                         resulting value specifies options for color space support.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>S_OK</b> on success, or it returns one of the error codes that
    ///    are described in the DXGI_ERROR topic.
    ///    
    HRESULT CheckColorSpaceSupport(DXGI_COLOR_SPACE_TYPE ColorSpace, uint* pColorSpaceSupport);
    ///Sets the color space used by the swap chain.
    ///Params:
    ///    ColorSpace = Type: <b>DXGI_COLOR_SPACE_TYPE</b> A DXGI_COLOR_SPACE_TYPE-typed value that specifies the color space to set.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>S_OK</b> on success, or it returns one of the error codes that
    ///    are described in the DXGI_ERROR topic.
    ///    
    HRESULT SetColorSpace1(DXGI_COLOR_SPACE_TYPE ColorSpace);
    ///Changes the swap chain's back buffer size, format, and number of buffers, where the swap chain was created using
    ///a D3D12 command queue as an input device. This should be called when the application window is resized.
    ///Params:
    ///    BufferCount = Type: <b>UINT</b> The number of buffers in the swap chain (including all back and front buffers). This number
    ///                  can be different from the number of buffers with which you created the swap chain. This number can't be
    ///                  greater than <b>DXGI_MAX_SWAP_CHAIN_BUFFERS</b>. Set this number to zero to preserve the existing number of
    ///                  buffers in the swap chain. You can't specify less than two buffers for the flip presentation model.
    ///    Width = Type: <b>UINT</b> The new width of the back buffer. If you specify zero, DXGI will use the width of the
    ///            client area of the target window. You can't specify the width as zero if you called the
    ///            IDXGIFactory2::CreateSwapChainForComposition method to create the swap chain for a composition surface.
    ///    Height = Type: <b>UINT</b> The new height of the back buffer. If you specify zero, DXGI will use the height of the
    ///             client area of the target window. You can't specify the height as zero if you called the
    ///             IDXGIFactory2::CreateSwapChainForComposition method to create the swap chain for a composition surface.
    ///    Format = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT-typed value for the new format of the back buffer. Set this value to
    ///             DXGI_FORMAT_UNKNOWN to preserve the existing format of the back buffer. The flip presentation model supports
    ///             a more restricted set of formats than the bit-block transfer (bitblt) model.
    ///    SwapChainFlags = Type: <b>UINT</b> A combination of DXGI_SWAP_CHAIN_FLAG-typed values that are combined by using a bitwise OR
    ///                     operation. The resulting value specifies options for swap-chain behavior.
    ///    pCreationNodeMask = Type: <b>const UINT*</b> An array of UINTs, of total size <i>BufferCount</i>, where the value indicates which
    ///                        node the back buffer should be created on. Buffers created using <b>ResizeBuffers1</b> with a non-null
    ///                        <i>pCreationNodeMask</i> array are visible to all nodes.
    ///    ppPresentQueue = Type: <b>IUnknown*</b> An array of command queues (ID3D12CommandQueue instances), of total size
    ///                     <i>BufferCount</i>. Each queue provided must match the corresponding creation node mask specified in the
    ///                     <i>pCreationNodeMask</i> array. When <b>Present()</b> is called, in addition to rotating to the next buffer
    ///                     for the next frame, the swapchain will also rotate through these command queues. This allows the app to
    ///                     control which queue requires synchronization for a given present operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
    ///    DXGI_ERROR.
    ///    
    HRESULT ResizeBuffers1(uint BufferCount, uint Width, uint Height, DXGI_FORMAT Format, uint SwapChainFlags, 
                           const(uint)* pCreationNodeMask, IUnknown* ppPresentQueue);
}

///Represents an adapter output (such as a monitor). The <b>IDXGIOutput4</b> interface exposes a method to check for
///overlay color space support.
@GUID("DC7DCA35-2196-414D-9F53-617884032A60")
interface IDXGIOutput4 : IDXGIOutput3
{
    ///Checks for overlay color space support.
    ///Params:
    ///    Format = Type: <b>DXGI_FORMAT</b> A DXGI_FORMAT-typed value for the color format.
    ///    ColorSpace = Type: <b>DXGI_COLOR_SPACE_TYPE</b> A DXGI_COLOR_SPACE_TYPE-typed value that specifies color space type to
    ///                 check overlay support for.
    ///    pConcernedDevice = Type: <b>IUnknown*</b> A pointer to the Direct3D device interface. <b>CheckOverlayColorSpaceSupport</b>
    ///                       returns only support info about this scan-out device.
    ///    pFlags = Type: <b>UINT*</b> A pointer to a variable that receives a combination of
    ///             DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG-typed values that are combined by using a bitwise OR operation. The
    ///             resulting value specifies options for overlay color space support.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns <b>S_OK</b> on success, or it returns one of the error codes that
    ///    are described in the DXGI_ERROR topic.
    ///    
    HRESULT CheckOverlayColorSpaceSupport(DXGI_FORMAT Format, DXGI_COLOR_SPACE_TYPE ColorSpace, 
                                          IUnknown pConcernedDevice, uint* pFlags);
}

///Enables creating Microsoft DirectX Graphics Infrastructure (DXGI) objects.
@GUID("1BC6EA02-EF36-464F-BF0C-21CA39E5168A")
interface IDXGIFactory4 : IDXGIFactory3
{
    ///Outputs the IDXGIAdapter for the specified LUID.
    ///Params:
    ///    AdapterLuid = Type: <b>LUID</b> A unique value that identifies the adapter. See LUID for a definition of the structure.
    ///                  <b>LUID</b> is defined in dxgi.h.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (GUID) of the IDXGIAdapter object referenced by the
    ///           <i>ppvAdapter</i> parameter.
    ///    ppvAdapter = Type: <b>void**</b> The address of an IDXGIAdapter interface pointer to the adapter. This parameter must not
    ///                 be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
    ///    DXGI_ERROR. See also Direct3D 12 Return Codes.
    ///    
    HRESULT EnumAdapterByLuid(LUID AdapterLuid, const(GUID)* riid, void** ppvAdapter);
    ///Provides an adapter which can be provided to D3D12CreateDevice to use the WARP renderer.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (GUID) of the IDXGIAdapter object referenced by the
    ///           <i>ppvAdapter</i> parameter.
    ///    ppvAdapter = Type: <b>void**</b> The address of an IDXGIAdapter interface pointer to the adapter. This parameter must not
    ///                 be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
    ///    DXGI_ERROR. See also Direct3D 12 Return Codes.
    ///    
    HRESULT EnumWarpAdapter(const(GUID)* riid, void** ppvAdapter);
}

///This interface adds some memory residency methods, for budgeting and reserving physical memory.
@GUID("645967A4-1392-4310-A798-8053CE3E93FD")
interface IDXGIAdapter3 : IDXGIAdapter2
{
    ///Registers to receive notification of hardware content protection teardown events.
    ///Params:
    ///    hEvent = Type: <b>HANDLE</b> A handle to the event object that the operating system sets when hardware content
    ///             protection teardown occurs. The CreateEvent or OpenEvent function returns this handle.
    ///    pdwCookie = Type: <b>DWORD*</b> A pointer to a key value that an application can pass to the
    ///                IDXGIAdapter3::UnregisterHardwareContentProtectionTeardownStatus method to unregister the notification event
    ///                that <i>hEvent</i> specifies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterHardwareContentProtectionTeardownStatusEvent(HANDLE hEvent, uint* pdwCookie);
    ///Unregisters an event to stop it from receiving notification of hardware content protection teardown events.
    ///Params:
    ///    dwCookie = Type: <b>DWORD</b> A key value for the window or event to unregister. The
    ///               IDXGIAdapter3::RegisterHardwareContentProtectionTeardownStatusEvent method returns this value.
    void    UnregisterHardwareContentProtectionTeardownStatus(uint dwCookie);
    ///This method informs the process of the current budget and process usage.
    ///Params:
    ///    NodeIndex = Type: <b>UINT</b> Specifies the device's physical adapter for which the video memory information is queried.
    ///                For single-GPU operation, set this to zero. If there are multiple GPU nodes, set this to the index of the
    ///                node (the device's physical adapter) for which the video memory information is queried. See Multi-adapter
    ///                systems.
    ///    MemorySegmentGroup = Type: <b>DXGI_MEMORY_SEGMENT_GROUP</b> Specifies a DXGI_MEMORY_SEGMENT_GROUP that identifies the group as
    ///                         local or non-local.
    ///    pVideoMemoryInfo = Type: <b>DXGI_QUERY_VIDEO_MEMORY_INFO*</b> Fills in a DXGI_QUERY_VIDEO_MEMORY_INFO structure with the current
    ///                       values.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
    ///    DXGI_ERROR.
    ///    
    HRESULT QueryVideoMemoryInfo(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, 
                                 DXGI_QUERY_VIDEO_MEMORY_INFO* pVideoMemoryInfo);
    ///This method sends the minimum required physical memory for an application, to the OS.
    ///Params:
    ///    NodeIndex = Type: <b>UINT</b> Specifies the device's physical adapter for which the video memory information is being
    ///                set. For single-GPU operation, set this to zero. If there are multiple GPU nodes, set this to the index of
    ///                the node (the device's physical adapter) for which the video memory information is being set. See
    ///                Multi-adapter systems.
    ///    MemorySegmentGroup = Type: <b>DXGI_MEMORY_SEGMENT_GROUP</b> Specifies a DXGI_MEMORY_SEGMENT_GROUP that identifies the group as
    ///                         local or non-local.
    ///    Reservation = Type: <b>UINT64</b> Specifies a UINT64 that sets the minimum required physical memory, in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; an error code otherwise. For a list of error codes, see
    ///    DXGI_ERROR.
    ///    
    HRESULT SetVideoMemoryReservation(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, 
                                      ulong Reservation);
    ///This method establishes a correlation between a CPU synchronization object and the budget change event.
    ///Params:
    ///    hEvent = Type: <b>HANDLE</b> Specifies a HANDLE for the event.
    ///    pdwCookie = Type: <b>DWORD*</b> A key value for the window or event to unregister. The
    ///                IDXGIAdapter3::RegisterHardwareContentProtectionTeardownStatusEvent method returns this value.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT RegisterVideoMemoryBudgetChangeNotificationEvent(HANDLE hEvent, uint* pdwCookie);
    ///This method stops notifying a CPU synchronization object whenever a budget change occurs. An application may
    ///switch back to polling the information regularly.
    ///Params:
    ///    dwCookie = Type: <b>DWORD</b> A key value for the window or event to unregister. The
    ///               IDXGIAdapter3::RegisterHardwareContentProtectionTeardownStatusEvent method returns this value.
    void    UnregisterVideoMemoryBudgetChangeNotification(uint dwCookie);
}

///Represents an adapter output (such as a monitor). The <b>IDXGIOutput5</b> interface exposes a single method to
///specify a list of supported formats for fullscreen surfaces.
@GUID("80A07424-AB52-42EB-833C-0C42FD282D98")
interface IDXGIOutput5 : IDXGIOutput4
{
    ///Allows specifying a list of supported formats for fullscreen surfaces that can be returned by the
    ///IDXGIOutputDuplication object.
    ///Params:
    ///    pDevice = Type: <b>IUnknown*</b> A pointer to the Direct3D device interface that you can use to process the desktop
    ///              image. This device must be created from the adapter to which the output is connected.
    ///    Flags = Type: <b>UINT</b> Reserved for future use; must be zero.
    ///    SupportedFormatsCount = Type: <b>UINT</b> Specifies the number of supported formats.
    ///    pSupportedFormats = Type: <b>const DXGI_FORMAT*</b> Specifies an array, of length <i>SupportedFormatsCount</i> of DXGI_FORMAT
    ///                        entries.
    ///    ppOutputDuplication = Type: <b>IDXGIOutputDuplication**</b> A pointer to a variable that receives the new IDXGIOutputDuplication
    ///                          interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> <ul> <li>S_OK if <b>DuplicateOutput1</b> successfully created the desktop duplication
    ///    interface.</li> <li>E_INVALIDARG for one of the following reasons: <ul> <li>The specified device
    ///    (<i>pDevice</i>) is invalid, was not created on the correct adapter, or was not created from IDXGIFactory1
    ///    (or a later version of a DXGI factory interface that inherits from <b>IDXGIFactory1</b>).</li> <li>The
    ///    calling application is already duplicating this desktop output.</li> </ul> </li> <li>E_ACCESSDENIED if the
    ///    application does not have access privilege to the current desktop image. For example, only an application
    ///    that runs at LOCAL_SYSTEM can access the secure desktop.</li> <li> DXGI_ERROR_UNSUPPORTED if the created
    ///    IDXGIOutputDuplication interface does not support the current desktop mode or scenario. For example, 8bpp and
    ///    non-DWM desktop modes are not supported. If <b>DuplicateOutput1</b> fails with DXGI_ERROR_UNSUPPORTED, the
    ///    application can wait for system notification of desktop switches and mode changes and then call
    ///    <b>DuplicateOutput1</b> again after such a notification occurs. For more information, see the desktop switch
    ///    (EVENT_SYSTEM_DESKTOPSWITCH) and mode change notification (WM_DISPLAYCHANGE). </li>
    ///    <li>DXGI_ERROR_NOT_CURRENTLY_AVAILABLE if DXGI reached the limit on the maximum number of concurrent
    ///    duplication applications (default of four). Therefore, the calling application cannot create any desktop
    ///    duplication interfaces until the other applications close.</li> <li>DXGI_ERROR_SESSION_DISCONNECTED if
    ///    <b>DuplicateOutput1</b> failed because the session is currently disconnected.</li> <li>Other error codes are
    ///    described in the DXGI_ERROR topic.</li> </ul>
    ///    
    HRESULT DuplicateOutput1(IUnknown pDevice, uint Flags, uint SupportedFormatsCount, 
                             const(DXGI_FORMAT)* pSupportedFormats, IDXGIOutputDuplication* ppOutputDuplication);
}

///This interface exposes a single method for setting video metadata.
@GUID("3D585D5A-BD4A-489E-B1F4-3DBCB6452FFB")
interface IDXGISwapChain4 : IDXGISwapChain3
{
    ///This method sets High Dynamic Range (HDR) and Wide Color Gamut (WCG) header metadata.
    ///Params:
    ///    Type = Type: <b>DXGI_HDR_METADATA_TYPE</b> Specifies one member of the DXGI_HDR_METADATA_TYPE enum.
    ///    Size = Type: <b>UINT</b> Specifies the size of <i>pMetaData</i>, in bytes.
    ///    pMetaData = Type: <b>void*</b> Specifies a void pointer that references the metadata, if it exists. Refer to the
    ///                DXGI_HDR_METADATA_HDR10 structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT SetHDRMetaData(DXGI_HDR_METADATA_TYPE Type, uint Size, void* pMetaData);
}

///This interface provides updated methods to offer and reclaim resources.
@GUID("95B4F95F-D8DA-4CA4-9EE6-3B76D5968A10")
interface IDXGIDevice4 : IDXGIDevice3
{
    ///Allows the operating system to free the video memory of resources, including both discarding the content and
    ///de-committing the memory.
    ///Params:
    ///    NumResources = Type: <b>UINT</b> The number of resources in the <i>ppResources</i> argument array.
    ///    ppResources = Type: <b>IDXGIResource*</b> An array of pointers to IDXGIResource interfaces for the resources to offer.
    ///    Priority = Type: <b>DXGI_OFFER_RESOURCE_PRIORITY</b> A DXGI_OFFER_RESOURCE_PRIORITY-typed value that indicates how
    ///               valuable data is.
    ///    Flags = Type: <b>UINT</b> Specifies the DXGI_OFFER_RESOURCE_FLAGS.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code, which can include E_INVALIDARG if
    ///    a resource in the array, or the priority, is invalid.
    ///    
    HRESULT OfferResources1(uint NumResources, IDXGIResource* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority, 
                            uint Flags);
    ///Restores access to resources that were previously offered by calling IDXGIDevice4::OfferResources1.
    ///Params:
    ///    NumResources = Type: <b>UINT</b> The number of resources in the <i>ppResources</i> argument and <i>pResults</i> argument
    ///                   arrays.
    ///    ppResources = Type: <b>IDXGIResource*</b> An array of pointers to IDXGIResource interfaces for the resources to reclaim.
    ///    pResults = Type: <b>DXGI_RECLAIM_RESOURCE_RESULTS*</b> A pointer to an array that receives DXGI_RECLAIM_RESOURCE_RESULTS
    ///               values. Each value in the array corresponds to a resource at the same index that the <i>ppResources</i>
    ///               parameter specifies. The caller can pass in <b>NULL</b>, if the caller intends to fill the resources with new
    ///               content regardless of whether the old content was discarded.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code, including E_INVALIDARG if the
    ///    resources are invalid.
    ///    
    HRESULT ReclaimResources1(uint NumResources, IDXGIResource* ppResources, 
                              DXGI_RECLAIM_RESOURCE_RESULTS* pResults);
}

///This interface enables a single method to support variable refresh rate displays.
@GUID("7632E1F5-EE65-4DCA-87FD-84CD75F8838D")
interface IDXGIFactory5 : IDXGIFactory4
{
    ///Used to check for hardware feature support.
    ///Params:
    ///    Feature = Type: <b>DXGI_FEATURE</b> Specifies one member of DXGI_FEATURE to query support for.
    ///    pFeatureSupportData = Type: <b>void*</b> Specifies a pointer to a buffer that will be filled with data that describes the feature
    ///                          support.
    ///    FeatureSupportDataSize = Type: <b>UINT</b> The size, in bytes, of <i>pFeatureSupportData</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CheckFeatureSupport(DXGI_FEATURE Feature, void* pFeatureSupportData, uint FeatureSupportDataSize);
}

///This interface represents a display subsystem, and extends this family of interfaces to expose a method to check for
///an adapter's compatibility with Arbitrary Code Guard (ACG).
@GUID("3C8D99D1-4FBF-4181-A82C-AF66BF7BD24E")
interface IDXGIAdapter4 : IDXGIAdapter3
{
    ///Gets a Microsoft DirectX Graphics Infrastructure (DXGI) 1.6 description of an adapter or video card. This
    ///description includes information about ACG compatibility.
    ///Params:
    ///    pDesc = A pointer to a DXGI_ADAPTER_DESC3 structure that describes the adapter. This parameter must not be
    ///            <b>NULL</b>. On feature level 9 graphics hardware, early versions of <b>GetDesc3</b> (GetDesc1, and GetDesc)
    ///            return zeros for the PCI ID in the <b>VendorId</b>, <b>DeviceId</b>, <b>SubSysId</b>, and <b>Revision</b>
    ///            members of the adapter description structure and “Software Adapter” for the description string in the
    ///            <b>Description</b> member. <b>GetDesc3</b> and GetDesc2 return the actual feature level 9 hardware values in
    ///            these members.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns E_INVALIDARG if the <i>pDesc</i> parameter is <b>NULL</b>.
    ///    
    HRESULT GetDesc3(DXGI_ADAPTER_DESC3* pDesc);
}

///Represents an adapter output (such as a monitor). The <b>IDXGIOutput6</b> interface exposes methods to provide
///specific monitor capabilities.
@GUID("068346E8-AAEC-4B84-ADD7-137F513F77A1")
interface IDXGIOutput6 : IDXGIOutput5
{
    ///Get an extended description of the output that includes color characteristics and connection type.
    ///Params:
    ///    pDesc = Type: <b>DXGI_OUTPUT_DESC1*</b> A pointer to the output description (see DXGI_OUTPUT_DESC1).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns a code that indicates success or failure. S_OK if successful,
    ///    DXGI_ERROR_INVALID_CALL if <i>pDesc</i> is passed in as <b>NULL</b>.
    ///    
    HRESULT GetDesc1(DXGI_OUTPUT_DESC1* pDesc);
    ///Notifies applications that hardware stretching is supported.
    ///Params:
    ///    pFlags = Type: <b>UINT*</b> A bitfield of DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS enumeration values describing which
    ///             types of hardware composition are supported. The values are bitwise OR'd together.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns a code that indicates success or failure.
    ///    
    HRESULT CheckHardwareCompositionSupport(uint* pFlags);
}

///This interface enables a single method that enumerates graphics adapters based on a given GPU preference.
@GUID("C1B6694F-FF09-44A9-B03C-77900A0A1D17")
interface IDXGIFactory6 : IDXGIFactory5
{
    ///Enumerates graphics adapters based on a given GPU preference.
    ///Params:
    ///    Adapter = Type: <b>UINT</b> The index of the adapter to enumerate. The indices are in order of the preference specified
    ///              in <i>GpuPreference</i>—for example, if <b>DXGI_GPU_PREFERENCE_HIGH_PERFORMANCE</b> is specified, then the
    ///              highest-performing adapter is at index 0, the second-highest is at index 1, and so on.
    ///    GpuPreference = Type: <b>DXGI_GPU_PREFERENCE</b> The GPU preference for the app.
    ///    riid = Type: <b>REFIID</b> The globally unique identifier (GUID) of the IDXGIAdapter object referenced by the
    ///           <i>ppvAdapter</i> parameter.
    ///    ppvAdapter = Type: <b>void**</b> The address of an IDXGIAdapter interface pointer to the adapter. This parameter must not
    ///                 be NULL.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns <b>S_OK</b> if successful; an error code otherwise. For a list of error codes,
    ///    see DXGI_ERROR.
    ///    
    HRESULT EnumAdapterByGpuPreference(uint Adapter, DXGI_GPU_PREFERENCE GpuPreference, const(GUID)* riid, 
                                       void** ppvAdapter);
}

///This interface enables registration for notifications to detect adapter enumeration state changes.
@GUID("A4966EED-76DB-44DA-84C1-EE9A7AFB20A8")
interface IDXGIFactory7 : IDXGIFactory6
{
    ///Registers to receive notification of changes whenever the adapter enumeration state changes.
    ///Params:
    ///    hEvent = A handle to the event object.
    ///    pdwCookie = A key value for the registered event.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; an error code otherwise.
    ///    
    HRESULT RegisterAdaptersChangedEvent(HANDLE hEvent, uint* pdwCookie);
    ///Unregisters an event to stop receiving notifications when the adapter enumeration state changes.
    ///Params:
    ///    dwCookie = A key value for the event to unregister.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful; an error code otherwise.
    ///    
    HRESULT UnregisterAdaptersChangedEvent(uint dwCookie);
}

///This interface controls the debug information queue, and can only be used if the debug layer is turned on.
@GUID("D67441C7-672A-476F-9E82-CD55B44949CE")
interface IDXGIInfoQueue : IUnknown
{
    ///Sets the maximum number of messages that can be added to the message queue.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that sets the limit on the number of messages.
    ///    MessageCountLimit = The maximum number of messages that can be added to the queue. –1 means no limit.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT SetMessageCountLimit(GUID Producer, ulong MessageCountLimit);
    ///Clears all messages from the message queue.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that clears the messages.
    void    ClearStoredMessages(GUID Producer);
    HRESULT GetMessageA(GUID Producer, ulong MessageIndex, DXGI_INFO_QUEUE_MESSAGE* pMessage, 
                        size_t* pMessageByteLength);
    ///Gets the number of messages that can pass through a retrieval filter.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the number.
    ///Returns:
    ///    Returns the number of messages that can pass through a retrieval filter.
    ///    
    ulong   GetNumStoredMessagesAllowedByRetrievalFilters(GUID Producer);
    ///Gets the number of messages currently stored in the message queue.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the number.
    ///Returns:
    ///    Returns the number of messages currently stored in the message queue.
    ///    
    ulong   GetNumStoredMessages(GUID Producer);
    ///Gets the number of messages that were discarded due to the message count limit.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the number.
    ///Returns:
    ///    Returns the number of messages that were discarded.
    ///    
    ulong   GetNumMessagesDiscardedByMessageCountLimit(GUID Producer);
    ///Gets the maximum number of messages that can be added to the message queue.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the number.
    ///Returns:
    ///    Returns the maximum number of messages that can be added to the queue. –1 means no limit.
    ///    
    ulong   GetMessageCountLimit(GUID Producer);
    ///Gets the number of messages that a storage filter allowed to pass through.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the number.
    ///Returns:
    ///    Returns the number of messages allowed by a storage filter.
    ///    
    ulong   GetNumMessagesAllowedByStorageFilter(GUID Producer);
    ///Gets the number of messages that were denied passage through a storage filter.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the number.
    ///Returns:
    ///    Returns the number of messages denied by a storage filter.
    ///    
    ulong   GetNumMessagesDeniedByStorageFilter(GUID Producer);
    ///Adds storage filters to the top of the storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that produced the filters.
    ///    pFilter = An array of DXGI_INFO_QUEUE_FILTER structures that describe the filters.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT AddStorageFilterEntries(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    ///Gets the storage filter at the top of the storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the filter.
    ///    pFilter = A pointer to a DXGI_INFO_QUEUE_FILTER structure that describes the filter.
    ///    pFilterByteLength = A pointer to a variable that receives the size, in bytes, of the filter description to which <i>pFilter</i>
    ///                        points. If <i>pFilter</i> is <b>NULL</b>, <b>GetStorageFilter</b> outputs the size of the storage filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT GetStorageFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter, size_t* pFilterByteLength);
    ///Removes a storage filter from the top of the storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that removes the filter.
    void    ClearStorageFilter(GUID Producer);
    ///Pushes an empty storage filter onto the storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the empty storage filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushEmptyStorageFilter(GUID Producer);
    ///Pushes a deny-all storage filter onto the storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushDenyAllStorageFilter(GUID Producer);
    ///Pushes a copy of the storage filter that is currently on the top of the storage-filter stack onto the
    ///storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the copy of the storage filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushCopyOfStorageFilter(GUID Producer);
    ///Pushes a storage filter onto the storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the filter.
    ///    pFilter = A pointer to a DXGI_INFO_QUEUE_FILTER structure that describes the filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushStorageFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    ///Pops a storage filter from the top of the storage-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pops the filter.
    void    PopStorageFilter(GUID Producer);
    ///Gets the size of the storage-filter stack in bytes.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the size.
    ///Returns:
    ///    Returns the size of the storage-filter stack in bytes.
    ///    
    uint    GetStorageFilterStackSize(GUID Producer);
    ///Adds retrieval filters to the top of the retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that produced the filters.
    ///    pFilter = An array of DXGI_INFO_QUEUE_FILTER structures that describe the filters.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT AddRetrievalFilterEntries(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    ///Gets the retrieval filter at the top of the retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the filter.
    ///    pFilter = A pointer to a DXGI_INFO_QUEUE_FILTER structure that describes the filter.
    ///    pFilterByteLength = A pointer to a variable that receives the size, in bytes, of the filter description to which <i>pFilter</i>
    ///                        points. If <i>pFilter</i> is <b>NULL</b>, <b>GetRetrievalFilter</b> outputs the size of the retrieval filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT GetRetrievalFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter, size_t* pFilterByteLength);
    ///Removes a retrieval filter from the top of the retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that removes the filter.
    void    ClearRetrievalFilter(GUID Producer);
    ///Pushes an empty retrieval filter onto the retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the empty retrieval filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushEmptyRetrievalFilter(GUID Producer);
    ///Pushes a deny-all retrieval filter onto the retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the deny-all retrieval filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushDenyAllRetrievalFilter(GUID Producer);
    ///Pushes a copy of the retrieval filter that is currently on the top of the retrieval-filter stack onto the
    ///retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the copy of the retrieval filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushCopyOfRetrievalFilter(GUID Producer);
    ///Pushes a retrieval filter onto the retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pushes the filter.
    ///    pFilter = A pointer to a DXGI_INFO_QUEUE_FILTER structure that describes the filter.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT PushRetrievalFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
    ///Pops a retrieval filter from the top of the retrieval-filter stack.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that pops the filter.
    void    PopRetrievalFilter(GUID Producer);
    ///Gets the size of the retrieval-filter stack in bytes.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the size.
    ///Returns:
    ///    Returns the size of the retrieval-filter stack in bytes.
    ///    
    uint    GetRetrievalFilterStackSize(GUID Producer);
    ///Adds a debug message to the message queue and sends that message to the debug output.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that produced the message.
    ///    Category = A DXGI_INFO_QUEUE_MESSAGE_CATEGORY-typed value that specifies the category of the message.
    ///    Severity = A DXGI_INFO_QUEUE_MESSAGE_SEVERITY-typed value that specifies the severity of the message.
    ///    ID = An integer that uniquely identifies the message.
    ///    pDescription = The message string.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT AddMessage(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, 
                       DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, int ID, const(PSTR) pDescription);
    ///Adds a user-defined message to the message queue and sends that message to the debug output.
    ///Params:
    ///    Severity = A DXGI_INFO_QUEUE_MESSAGE_SEVERITY-typed value that specifies the severity of the message.
    ///    pDescription = The message string.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT AddApplicationMessage(DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, const(PSTR) pDescription);
    ///Sets a message category to break on when a message with that category passes through the storage filter.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that sets the breaking condition.
    ///    Category = A DXGI_INFO_QUEUE_MESSAGE_CATEGORY-typed value that specifies the category of the message.
    ///    bEnable = A Boolean value that specifies whether <b>SetBreakOnCategory</b> turns on or off this breaking condition
    ///              (<b>TRUE</b> for on, <b>FALSE</b> for off).
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT SetBreakOnCategory(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, BOOL bEnable);
    ///Sets a message severity level to break on when a message with that severity level passes through the storage
    ///filter.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that sets the breaking condition.
    ///    Severity = A DXGI_INFO_QUEUE_MESSAGE_SEVERITY-typed value that specifies the severity of the message.
    ///    bEnable = A Boolean value that specifies whether <b>SetBreakOnSeverity</b> turns on or off this breaking condition
    ///              (<b>TRUE</b> for on, <b>FALSE</b> for off).
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT SetBreakOnSeverity(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, BOOL bEnable);
    ///Sets a message identifier to break on when a message with that identifier passes through the storage filter.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that sets the breaking condition.
    ///    ID = An integer value that specifies the identifier of the message.
    ///    bEnable = A Boolean value that specifies whether <b>SetBreakOnID</b> turns on or off this breaking condition
    ///              (<b>TRUE</b> for on, <b>FALSE</b> for off).
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT SetBreakOnID(GUID Producer, int ID, BOOL bEnable);
    ///Determines whether the break on a message category is turned on or off.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the breaking status.
    ///    Category = A DXGI_INFO_QUEUE_MESSAGE_CATEGORY-typed value that specifies the category of the message.
    ///Returns:
    ///    Returns a Boolean value that specifies whether this category of breaking condition is turned on or off
    ///    (<b>TRUE</b> for on, <b>FALSE</b> for off).
    ///    
    BOOL    GetBreakOnCategory(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category);
    ///Determines whether the break on a message severity level is turned on or off.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the breaking status.
    ///    Severity = A DXGI_INFO_QUEUE_MESSAGE_SEVERITY-typed value that specifies the severity of the message.
    ///Returns:
    ///    Returns a Boolean value that specifies whether this severity of breaking condition is turned on or off
    ///    (<b>TRUE</b> for on, <b>FALSE</b> for off).
    ///    
    BOOL    GetBreakOnSeverity(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity);
    ///Determines whether the break on a message identifier is turned on or off.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the breaking status.
    ///    ID = An integer value that specifies the identifier of the message.
    ///Returns:
    ///    Returns a Boolean value that specifies whether this break on a message identifier is turned on or off
    ///    (<b>TRUE</b> for on, <b>FALSE</b> for off).
    ///    
    BOOL    GetBreakOnID(GUID Producer, int ID);
    ///Turns the debug output on or off.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the mute status.
    ///    bMute = A Boolean value that specifies whether to turn the debug output on or off (<b>TRUE</b> for on, <b>FALSE</b>
    ///            for off).
    void    SetMuteDebugOutput(GUID Producer, BOOL bMute);
    ///Determines whether the debug output is turned on or off.
    ///Params:
    ///    Producer = A DXGI_DEBUG_ID value that identifies the entity that gets the mute status.
    ///Returns:
    ///    Returns a Boolean value that specifies whether the debug output is turned on or off (<b>TRUE</b> for on,
    ///    <b>FALSE</b> for off).
    ///    
    BOOL    GetMuteDebugOutput(GUID Producer);
}

///This interface controls debug settings, and can only be used if the debug layer is turned on.
@GUID("119E7452-DE9E-40FE-8806-88F90C12B441")
interface IDXGIDebug : IUnknown
{
    ///Reports info about the lifetime of an object or objects.
    ///Params:
    ///    apiid = The globally unique identifier (GUID) of the object or objects to get info about. Use one of the
    ///            DXGI_DEBUG_ID GUIDs.
    ///    flags = A DXGI_DEBUG_RLO_FLAGS-typed value that specifies the amount of info to report.
    ///Returns:
    ///    Returns S_OK if successful; an error code otherwise. For a list of error codes, see DXGI_ERROR.
    ///    
    HRESULT ReportLiveObjects(GUID apiid, DXGI_DEBUG_RLO_FLAGS flags);
}

///Controls debug settings for Microsoft DirectX Graphics Infrastructure (DXGI). You can use the <b>IDXGIDebug1</b>
///interface in Windows Store apps.
@GUID("C5A05F0C-16F2-4ADF-9F4D-A8C4D58AC550")
interface IDXGIDebug1 : IDXGIDebug
{
    ///Starts tracking leaks for the current thread.
    void EnableLeakTrackingForThread();
    ///Stops tracking leaks for the current thread.
    void DisableLeakTrackingForThread();
    ///Gets a value indicating whether leak tracking is turned on for the current thread.
    ///Returns:
    ///    <b>TRUE</b> if leak tracking is turned on for the current thread; otherwise, <b>FALSE</b>.
    ///    
    BOOL IsLeakTrackingEnabledForThread();
}


// GUIDs


const GUID IID_IDXGIAdapter           = GUIDOF!IDXGIAdapter;
const GUID IID_IDXGIAdapter1          = GUIDOF!IDXGIAdapter1;
const GUID IID_IDXGIAdapter2          = GUIDOF!IDXGIAdapter2;
const GUID IID_IDXGIAdapter3          = GUIDOF!IDXGIAdapter3;
const GUID IID_IDXGIAdapter4          = GUIDOF!IDXGIAdapter4;
const GUID IID_IDXGIDebug             = GUIDOF!IDXGIDebug;
const GUID IID_IDXGIDebug1            = GUIDOF!IDXGIDebug1;
const GUID IID_IDXGIDecodeSwapChain   = GUIDOF!IDXGIDecodeSwapChain;
const GUID IID_IDXGIDevice            = GUIDOF!IDXGIDevice;
const GUID IID_IDXGIDevice1           = GUIDOF!IDXGIDevice1;
const GUID IID_IDXGIDevice2           = GUIDOF!IDXGIDevice2;
const GUID IID_IDXGIDevice3           = GUIDOF!IDXGIDevice3;
const GUID IID_IDXGIDevice4           = GUIDOF!IDXGIDevice4;
const GUID IID_IDXGIDeviceSubObject   = GUIDOF!IDXGIDeviceSubObject;
const GUID IID_IDXGIDisplayControl    = GUIDOF!IDXGIDisplayControl;
const GUID IID_IDXGIFactory           = GUIDOF!IDXGIFactory;
const GUID IID_IDXGIFactory1          = GUIDOF!IDXGIFactory1;
const GUID IID_IDXGIFactory2          = GUIDOF!IDXGIFactory2;
const GUID IID_IDXGIFactory3          = GUIDOF!IDXGIFactory3;
const GUID IID_IDXGIFactory4          = GUIDOF!IDXGIFactory4;
const GUID IID_IDXGIFactory5          = GUIDOF!IDXGIFactory5;
const GUID IID_IDXGIFactory6          = GUIDOF!IDXGIFactory6;
const GUID IID_IDXGIFactory7          = GUIDOF!IDXGIFactory7;
const GUID IID_IDXGIFactoryMedia      = GUIDOF!IDXGIFactoryMedia;
const GUID IID_IDXGIInfoQueue         = GUIDOF!IDXGIInfoQueue;
const GUID IID_IDXGIKeyedMutex        = GUIDOF!IDXGIKeyedMutex;
const GUID IID_IDXGIObject            = GUIDOF!IDXGIObject;
const GUID IID_IDXGIOutput            = GUIDOF!IDXGIOutput;
const GUID IID_IDXGIOutput1           = GUIDOF!IDXGIOutput1;
const GUID IID_IDXGIOutput2           = GUIDOF!IDXGIOutput2;
const GUID IID_IDXGIOutput3           = GUIDOF!IDXGIOutput3;
const GUID IID_IDXGIOutput4           = GUIDOF!IDXGIOutput4;
const GUID IID_IDXGIOutput5           = GUIDOF!IDXGIOutput5;
const GUID IID_IDXGIOutput6           = GUIDOF!IDXGIOutput6;
const GUID IID_IDXGIOutputDuplication = GUIDOF!IDXGIOutputDuplication;
const GUID IID_IDXGIResource          = GUIDOF!IDXGIResource;
const GUID IID_IDXGIResource1         = GUIDOF!IDXGIResource1;
const GUID IID_IDXGISurface           = GUIDOF!IDXGISurface;
const GUID IID_IDXGISurface1          = GUIDOF!IDXGISurface1;
const GUID IID_IDXGISurface2          = GUIDOF!IDXGISurface2;
const GUID IID_IDXGISwapChain         = GUIDOF!IDXGISwapChain;
const GUID IID_IDXGISwapChain1        = GUIDOF!IDXGISwapChain1;
const GUID IID_IDXGISwapChain2        = GUIDOF!IDXGISwapChain2;
const GUID IID_IDXGISwapChain3        = GUIDOF!IDXGISwapChain3;
const GUID IID_IDXGISwapChain4        = GUIDOF!IDXGISwapChain4;
const GUID IID_IDXGISwapChainMedia    = GUIDOF!IDXGISwapChainMedia;
